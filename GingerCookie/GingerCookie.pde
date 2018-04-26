import KinectPV2.*;

KinectPV2 kinect;
PrintWriter outfile;

PImage img;
int wpd;
int hpd;
int front;
int rear;
int drawData[];
int fade;
int drawWidth;

int mode;//プログラムのモード 0:コンテンツ 1:コンフィグ
int confselect;

String setting[];

void setup() {
  //size(1920, 1080, P3D);
  fullScreen(P3D);

  kinect = new KinectPV2(this);
  kinect.enableDepthImg(true);
  kinect.enableColorImg(true);
  kinect.init();

  setting = loadStrings("setting.txt");
  
  wpd = width/512*2;
  hpd = height/424*2;
  rear = int(setting[0]);//<--最大深度
  front = int(setting[1]);//<--最少震度(描ける位置)
  fade = int(setting[2]);//<--透明がうすくなる速度
  drawWidth = int(setting[3]);//<--描ける幅
  img = loadImage("default.jpg");
  img.filter(GRAY);
  drawData = new int[217088];
  colorMode(HSB, 360, 100, 100);
  mode = 2;
  confselect = 0;
}

void draw() {
  switch(mode) {
    case 0:
    background(255);
    image(img, 0, 0);

    //raw Data int valeus from [0 - 4500]
    int [] rawData = kinect.getRawDepthData();

    noStroke();
    fill(255, 0, 0);
    for (int i = 0; i < rawData.length; i++) {
      if (front < rawData[i] && rawData[i] < rear) {
        fill(map(rawData[i], front, rear, 0, 360), 70, map(rawData[i], front, rear, 100, 80));//h色相s彩度b明度
        rect((i%512)*wpd, int(i/512)*hpd, wpd, wpd);
      } else if (front-drawWidth < rawData[i] && rawData[i] < front) {
        drawData[i] = 255;
      }
      if (drawData[i] > 0) {
        fill(0, 0, 100, drawData[i]);//h色相s彩度b明度
        rect((i%512)*wpd, int(i/512)*hpd, wpd, wpd);
        drawData[i]-=fade;
      }
    }
    break;
    case 1:
    fill(0,0,0);
    rect(width/4, height/4, width/2, height/2);
    textSize(20);
    fill(0,0,100);
    text("Config", width/3, height/3);
    if(confselect==0)fill(0,100,100);else fill(0,0,100);
    text("rear      = < "+rear+" >", width/3, height/3+50);
    if(confselect==1)fill(0,100,100);else fill(0,0,100);
    text("front     = < "+front+" >", width/3, height/3+80);
    if(confselect==2)fill(0,100,100);else fill(0,0,100);
    text("fade      = < "+fade+" >", width/3, height/3+110);
    if(confselect==3)fill(0,100,100);else fill(0,0,100);
    text("drawWidth = < "+drawWidth+" >", width/3, height/3+140);
    fill(0,0,100);
    text("Take a new picture : enter ", width/3, height/3+200);
    text("Return contents : press c key", width/3, height/3+230);
    break;
    default:
    mode++;
    if(mode==180){
      img = kinect.getColorImage();
      tint(212);
      img.filter(GRAY);
      mode=0;
    }
    break;
  }
}

void keyPressed() {
  if (keyCode == ENTER) {
    img = kinect.getColorImage();
    tint(212);
    img.filter(GRAY);
  }
  if (key == 'c') {
    if(mode==0) mode = 1;
    else mode = 0;
  }
  if (mode == 1){
    if(keyPressed){
      switch(keyCode){
        case UP:
        if(0 < confselect)confselect--;
        break;
        case DOWN:
        if(3 > confselect)confselect++;
        break;
        case RIGHT:
        switch(confselect){
          case 0:
          rear+=100;
          break;
          case 1:
          front+=100;
          break;
          case 2:
          fade++;
          break;
          case 3:
          drawWidth+=10;
          break;
        }
        break;
        case LEFT:
        switch(confselect){
          case 0:
          rear-=100;
          break;
          case 1:
          front-=100;
          break;
          case 2:
          fade--;
          break;
          case 3:
          drawWidth-=10;
          break;
        }
        break;
      }
      outfile = createWriter("setting.txt");
      outfile.println(rear);
      outfile.println(front);
      outfile.println(fade);
      outfile.println(drawWidth);
      outfile.flush(); //残りを出力する
      outfile.close(); // ファイルを閉じる
    }
  }
}