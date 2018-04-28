//
//  ViewController.swift
//  PlayAndRecSample
//
//  Created by Tadashi on 2017/03/02.
//  Copyright © 2017 T@d. All rights reserved.
//

import UIKit
import CoreMotion

import UIKit
import AVFoundation
import AudioToolbox

var open = 0
var stop = 0
var counT = 0
var Reccount = 0


class ViewController: UIViewController {
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var DB: UILabel!
    var audioEngine : AVAudioEngine!
    var audioFile : AVAudioFile!
    var audioPlayer : AVAudioPlayerNode!
    var outref: ExtAudioFileRef?
    var audioFilePlayer: AVAudioPlayerNode!
    var mixer : AVAudioMixerNode!
    var filePath : String? = nil
    var isPlay = false
    var isRec = false
    var motionManager: CMMotionManager?
    
    
    
    @IBOutlet var rec: UIButton!
    @IBAction func rec(_ sender: Any) {
        if self.isRec {
        }else{
            self.rec.isEnabled = false
            attitude()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.audioEngine = AVAudioEngine()
        self.audioFilePlayer = AVAudioPlayerNode()
        self.mixer = AVAudioMixerNode()
        self.audioEngine.attach(audioFilePlayer)
        self.audioEngine.attach(mixer)
        self.indicator(value: false)
        
        motionManager = CMMotionManager()
        motionManager?.deviceMotionUpdateInterval = 0.1
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.audio) != .authorized {
            AVCaptureDevice.requestAccess(for: AVMediaType.audio,
                                          completionHandler: { (granted: Bool) in
            })
        }
    }
    
    func attitude() {
        audioEngine.inputNode.removeTap(onBus: 0)
        guard let _ = motionManager?.isDeviceMotionAvailable,
            let operationQueue = OperationQueue.current
            else {
                return
        }
        motionManager?.startDeviceMotionUpdates(to: operationQueue, withHandler: { motion, _ in
            if let attitude = motion?.attitude {
                if(open == 0 && stop == 1){
                    counT = counT + 1
                }else if(open == 1 && stop == 0){
                    Reccount = Reccount + 1
                }
                //rec
                if((attitude.pitch * 180.0 / Double.pi) > 35 && open == 0 && stop == 0){
                    self.rec.isEnabled = false
                    self.rec.setTitle("STOP", for: .normal)
                    self.indicator(value: true)
                    self.startRecord()
                    open = 1
                }else //play
                    if( (attitude.pitch * 180.0 / Double.pi) < 5){
                        self.rec.isEnabled = false
                        self.indicator(value: true)
                        self.DB.text = String(format: "Play")
                        if(self.filePath != nil){
                            self.startPlay()
                            open = 0
                        }
                }
                //recstop
                if((attitude.pitch * 180.0 / Double.pi <= 35) && (attitude.pitch * 180.0 / Double.pi >= 5) && open == 1 && stop == 0 ){
                    self.rec.setTitle("RECORDING", for: .normal)
                    self.indicator(value: false)
                    self.stopRecord()
                    self.DB.text = String(format: "RecStop")
                    stop = 1
                    counT = 0
                } else //play stop
                    if((attitude.pitch * 180.0 / Double.pi) <= 35 && (attitude.pitch * 180.0 / Double.pi >= 5) && open ==  0 && stop == 1){
                        self.indicator(value: false)
                        self.stopPlay()
                        self.rec.isEnabled = false
                        self.DB.text = String(format: "PS")
                        stop = 0
                        Reccount=0
                }
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func startRecord() {
        audioEngine.inputNode.removeTap(onBus: 0)
        
        self.filePath = nil
        self.DB.text = String(format: "rec")
        self.isRec = true
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! AVAudioSession.sharedInstance().setActive(true)
        self.audioFile = try! AVAudioFile(forReading: Bundle.main.url(forResource: "1K", withExtension: "mp3")!)
        let format = AVAudioFormat(commonFormat: AVAudioCommonFormat.pcmFormatInt16,
                                   sampleRate: 44100.0,
                                   channels: 1,
                                   interleaved: true)
        self.audioEngine.connect(self.audioEngine.inputNode, to: self.mixer, format: format)
        self.audioEngine.connect(self.audioFilePlayer, to: self.mixer, format: self.audioFile.processingFormat)
        self.audioEngine.connect(self.mixer, to: self.audioEngine.mainMixerNode, format: format)
        self.audioFilePlayer.scheduleSegment(audioFile,
                                             startingFrame: AVAudioFramePosition(0),
                                             frameCount: AVAudioFrameCount(self.audioFile.length),
                                             at: nil,
                                             completionHandler: self.completion)
        let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as String
        self.filePath =  dir.appending("/temp.wav")
        _ = ExtAudioFileCreateWithURL(URL(fileURLWithPath: self.filePath!) as CFURL,
                                      kAudioFileWAVEType,
                                      (format?.streamDescription)!,
                                      nil,
                                      AudioFileFlags.eraseFile.rawValue,
                                      &outref)
        self.mixer.installTap(onBus: 0, bufferSize: AVAudioFrameCount((format?.sampleRate)! * 0.4), format: format, block: { (buffer: AVAudioPCMBuffer!, time: AVAudioTime!) -> Void in
            let audioBuffer : AVAudioBuffer = buffer
            _ = ExtAudioFileWrite(self.outref!, buffer.frameLength, audioBuffer.audioBufferList)
        })
        try! self.audioEngine.start()
    }
    
    func stopRecord() {
        audioEngine.inputNode.removeTap(onBus: 0)
        self.isRec = false
        self.audioFilePlayer.stop()
        self.audioEngine.stop()
        self.mixer.removeTap(onBus: 0)
        ExtAudioFileDispose(self.outref!)
        try! AVAudioSession.sharedInstance().setActive(false)
        audioEngine.inputNode.removeTap(onBus: 0)
    }
    
    func startPlay(){
        audioEngine.inputNode.removeTap(onBus: 0)
        let audioFile: AVAudioFile = try! AVAudioFile(forReading: URL(fileURLWithPath: self.filePath!))
        let sampleRate = audioFile.fileFormat.sampleRate
        let duration = Double(audioFile.length) / sampleRate
        if(open == 1){
            self.isPlay = true
            
            try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try! AVAudioSession.sharedInstance().setActive(true)
            
            self.audioFile = try! AVAudioFile(forReading: URL(fileURLWithPath: self.filePath!))
            self.audioEngine.connect(self.audioFilePlayer, to: self.audioEngine.mainMixerNode, format: audioFile.processingFormat)
            
            self.audioFilePlayer.scheduleSegment(audioFile,
                                                 startingFrame: AVAudioFramePosition(0),
                                                 frameCount: AVAudioFrameCount(self.audioFile.length),
                                                 at: nil,
                                                 completionHandler: self.completion)
            try! self.audioEngine.start()
            self.audioFilePlayer.play()
        }
        if(Double(counT/17) >= duration){
            self.audioFilePlayer.scheduleSegment(audioFile,
                                                 startingFrame: AVAudioFramePosition(0),
                                                 frameCount: AVAudioFrameCount(self.audioFile.length),
                                                 at: nil,
                                                 completionHandler: self.completion)
            self.audioFilePlayer.play()
            counT = 0
        }
    }
    
    func stopPlay() {
        audioEngine.inputNode.removeTap(onBus: 0)
        self.isPlay = false
        if self.audioFilePlayer != nil && self.audioFilePlayer.isPlaying {
            self.audioFilePlayer.stop()
        }
        self.audioEngine.stop()
        try! AVAudioSession.sharedInstance().setActive(false)
    }
    
    
    func completion() {
        audioEngine.inputNode.removeTap(onBus: 0)
        if self.isRec {
            DispatchQueue.main.async {
                self.rec(UIButton())
            }
        }
    }
    
    func indicator(value: Bool) {
        audioEngine.inputNode.removeTap(onBus: 0)
        DispatchQueue.main.async {
            if value {
                self.indicatorView.startAnimating()
                self.indicatorView.isHidden = false
            } else {
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
            }
        }
    }
}

