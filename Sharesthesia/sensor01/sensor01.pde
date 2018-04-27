import processing.sound.*;
import  processing.serial.*;

Serial  serial;
SoundFile soundfile1, soundfile2, soundfile3;
//soundfile4, soundfile5 ;

int val = 0;
int t = 0;

void setup() {  

  size(400, 400);

  serial = new Serial( this, Serial.list()[0], 9600 );

  soundfile1 = new SoundFile(this, "eat.mp3");
  soundfile2 = new SoundFile(this, "kokeru.mp3");
  soundfile3 = new SoundFile(this, "laugh.mp3");
}


void serialEvent(Serial port) {  

  val = port.read();
}

void draw() {

  ellipse(200, 200, 100, 100);

  if (val == 1) {
    if (t != 1) {
      fill(255, 0, 0);//赤
      soundfile1.play();
      t=1;
      delay(800);
    }
    t = 0;
  } else if (val == 2) {
    if (t != 1) {
      fill(0, 255, 0);//緑
      soundfile2.play();
      t=1;
      delay(800);
    }
    t = 0;
  } else if (val == 3) {
    if (t != 1) {
      fill(0, 0, 255);//青
      soundfile3.play();
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