/*
Thomas Sanchez Lengeling.
http://codigogenerativo.com/

KinectPV2, Kinect for Windows v2 library for processing

Mask test, number of users and find user test

使用:Processing 3.0.1
kinectPV2
*/


import KinectPV2.*;

KinectPV2 kinect;

PGraphics img;//colorセンサーの画像をその他のセンサーの画像サイズに利リマップして格納
//PGraphics mask;//人の形のマスク画像を格納

boolean foundUsers = false;

int light = 0;//軽くするために読み込みを制限

Particle particle[] = new Particle[5000];

void setup() {
  fullScreen();

  kinect = new KinectPV2(this);

  kinect.enableDepthImg(true);
  kinect.enableBodyTrackImg(true);
  kinect.enableColorImg(true);

  kinect.init();
  
  img = createGraphics(512, 424);
  //mask = createGraphics(512, 424);
  
  colorMode(HSB, 360, 100, 100);
  
  for(int i = 0; i < particle.length; i++){
    particle[i] = new Particle(random(0,512),random(0,424),color(180,0,0));
  }
}

void draw() {
  background(0, 0, 0);
  
  if(light == 0){
    img.beginDraw();
    img.image(kinect.getBodyTrackImage(), 0, 0, 512, 424);
    img.blend(kinect.getColorImage(), 0, 0, 1920, 1080, -121, 0, 754, 424, ADD);//
    //img.image(kinect.getColorImage(), -121, 0, 754, 424);
    //img.blend(kinect.getBodyTrackImage(), 0, 0, 512, 424, 0, 0, 512, 424, SUBTRACT);//
    img.endDraw();
    //mask.beginDraw();
    //mask.image(kinect.getBodyTrackImage(), 0, 0, 512, 424);
    //mask.endDraw();
    //mask.filter(INVERT);
    //img.mask(mask);
  }
  light--;
  if(light<0)light = 4;
  
  for(Particle p: particle){
    p.update(img.get(int(p.iPos.x), int(p.iPos.y)));
  }

  //raw body data 0-6 users 255 nothing
  int [] rawData = kinect.getRawBodyTrack();

  foundUsers = false;
  //iterate through 1/5th of the data
  for(int i = 0; i < rawData.length; i+=5){
    if(rawData[i] != 255){
     //found something
     foundUsers = true;
     break;
    }
  }

  //fill(0);
  //textSize(32);
  //text(kinect.getNumOfUsers(), 50, 50);
  //text("Found User: "+foundUsers, 50, 80);
  //text(frameRate, 50, 110);
  //image(img,0,0);
  //image(mask,512,0);
}

void mousePressed() {
  println(frameRate);
  ///saveFrame();
}