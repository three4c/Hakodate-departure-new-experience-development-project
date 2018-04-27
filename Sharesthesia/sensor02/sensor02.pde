import processing.sound.*;
import  processing.serial.*;

Serial  serial;
SoundFile soundfile4, soundfile5 ;

int val = 0;
int t = 0;

void setup() {  

  size(400, 400);

  serial = new Serial( this, Serial.list()[1], 9600 );
 
  soundfile4 = new SoundFile(this, "run.mp3");
  soundfile5 = new SoundFile(this, "sing.mp3");
}

void serialEvent(Serial port) {  
  val = port.read();
}

void draw() {

  ellipse(200, 200, 100, 100);
  
  if (val == 4) {
    if (t != 1) {
      fill(255, 255, 0);//黄
      soundfile4.play();
      t = 1;
      delay(800);
    }
    t = 0;
  } else if (val == 5) {
    if (t != 1) {
      fill(0, 255, 255);//水色
      soundfile5.play();
      t = 1;
      delay(800);
    }
    t = 0;
  } else {
    fill(255); //白
  }

  println(val);
  delay(500);
}