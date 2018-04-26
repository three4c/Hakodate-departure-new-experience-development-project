//右手座標
float migix = 0;
float migiy= 0;
float migiz = 0;

//左手座標
float hidarix = 0;
float hidariy = 0;
float hidariz = 0;

//カウント値
int count = 0;
int pcount = 0;
int pp = 0;
int pq = 0;
int pr = 0;

int R = 7; //曲線の大きさ調整用
int vertex_num = 8; //とげの数

//文字
String a = "";
String b = "";
String c = "";
int moji1=0;
int moji2=0;
int moji3=0;
int mojimoji = 1;

//a
float x1 = 0;
float y1 = 0;

//b
float x2 = 1000;
float y2 = 0;

//c
float x3 = 0;
float y3 = 1000;

//a
float dx1 = random(10, 20);
;
float dy1 = random(5, 20);
;

//b
float dx2 = random(10, 20);
float dy2 = random(5, 20);

//c
float dx3 = random(5, 20);
float dy3 = random(10, 20);

//手のボール
int cc = 0;
float bx=random(100, 150);
float by=random(100, 150);

//塗る
float xx = 0;
float dc = 10;
int tc = -1;

//人数
int peo = 0;

import KinectPV2.KJoint;
import KinectPV2.*;

KinectPV2 kinect;

PImage m;

void setup() {
  size(1920, 1080, P3D);

  kinect = new KinectPV2(this);

  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);

  kinect.init();

  PFont font = createFont("メイリオ ボールド", 32, true);
  textFont(font);

  m = loadImage("1499058933420.jpg");
  
}

void draw() {
  background(0);
  if (peo == 0) {
    image(m, 0, 0, width, height);

    ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();
    
    for (int i = 0; i < skeletonArray.size(); i++) {
      KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
      if (skeleton.isTracked()) {
        peo = skeletonArray.size();
      }
    }
    
    if(moji1 < 13){
      moji1+=mojimoji;
    }else{
      moji1 = 0; 
    }
    
    if(moji2 < 13){
      moji2+=mojimoji*2;
    }else{
      moji2 = 0; 
    }
    
    if(moji3 < 13){
      moji3+=mojimoji*3;
    }else{
      moji3 = 0; 
    }
       
    a = hh(a,moji1);
    b = hh(b,moji2);
    c = hh(c,moji3);
    
    if(moji1 == moji2){
      a = "はねる";
    }
    if(moji2 == moji3){
      b = "まける";
    }
    if(moji3 == moji1){
      c = "ならす";
    }
  } else {

    image(kinect.getColorImage(), 0, 0, width, height);

    ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();

    /*palette*/
    //left color
    noStroke();
    fill(255, 0, 0);//赤
    pushMatrix();
    translate(width/4-150, 150);
    beginShape();
    for (int theta = 0; theta < 360; theta++) {
      float x = R * (vertex_num * cos(radians(theta)) + cos(radians(-vertex_num * theta)));
      float y = R * (vertex_num * sin(radians(theta)) + sin(radians(-vertex_num * theta)));
      vertex(x, y);
    }
    endShape();
    popMatrix();

    fill(255, 0, 180);//ピンク
    pushMatrix();
    translate(width/4-150, 300);
    beginShape();
    for (int theta = 0; theta < 360; theta++) {
      float x = R * (vertex_num * cos(radians(theta)) + cos(radians(-vertex_num * theta)));
      float y = R * (vertex_num * sin(radians(theta)) + sin(radians(-vertex_num * theta)));
      vertex(x, y);
    }
    endShape();
    popMatrix();

    fill(255, 129, 25);//オレンジ
    pushMatrix();
    translate(width/4-150, 450);
    beginShape();
    for (int theta = 0; theta < 360; theta++) {
      float x = R * (vertex_num * cos(radians(theta)) + cos(radians(-vertex_num * theta)));
      float y = R * (vertex_num * sin(radians(theta)) + sin(radians(-vertex_num * theta)));
      vertex(x, y);
    }
    endShape();
    popMatrix();

    fill(255, 255, 0);//黄色
    pushMatrix();
    translate(width/4-150, 600);
    beginShape();
    for (int theta = 0; theta < 360; theta++) {
      float x = R * (vertex_num * cos(radians(theta)) + cos(radians(-vertex_num * theta)));
      float y = R * (vertex_num * sin(radians(theta)) + sin(radians(-vertex_num * theta)));
      vertex(x, y);
    }
    endShape();
    popMatrix();

    fill(171, 255, 127);//黄緑
    pushMatrix();
    translate(width/4-150, 750);
    beginShape();
    for (int theta = 0; theta < 360; theta++) {
      float x = R * (vertex_num * cos(radians(theta)) + cos(radians(-vertex_num * theta)));
      float y = R * (vertex_num * sin(radians(theta)) + sin(radians(-vertex_num * theta)));
      vertex(x, y);
    }
    endShape();
    popMatrix();

    fill(0, 255, 65);//緑
    pushMatrix();
    translate(width/4-150, 900);
    beginShape();
    for (int theta = 0; theta < 360; theta++) {
      float x = R * (vertex_num * cos(radians(theta)) + cos(radians(-vertex_num * theta)));
      float y = R * (vertex_num * sin(radians(theta)) + sin(radians(-vertex_num * theta)));
      vertex(x, y);
    }
    endShape();
    popMatrix();

    //right color
    fill(0, 0, 255);//青
    pushMatrix();
    translate(width/4*3+200, 150);
    beginShape();
    for (int theta = 0; theta < 360; theta++) {
      float x = R * (vertex_num * cos(radians(theta)) + cos(radians(-vertex_num * theta)));
      float y = R * (vertex_num * sin(radians(theta)) + sin(radians(-vertex_num * theta)));
      vertex(x, y);
    }
    endShape();
    popMatrix();

    fill(0, 180, 255);//水色
    pushMatrix();
    translate(width/4*3+200, 300);
    beginShape();
    for (int theta = 0; theta < 360; theta++) {
      float x = R * (vertex_num * cos(radians(theta)) + cos(radians(-vertex_num * theta)));
      float y = R * (vertex_num * sin(radians(theta)) + sin(radians(-vertex_num * theta)));
      vertex(x, y);
    }
    endShape();
    popMatrix();

    fill(196, 0, 204);//紫
    pushMatrix();
    translate(width/4*3+200, 450);
    beginShape();
    for (int theta = 0; theta < 360; theta++) {
      float x = R * (vertex_num * cos(radians(theta)) + cos(radians(-vertex_num * theta)));
      float y = R * (vertex_num * sin(radians(theta)) + sin(radians(-vertex_num * theta)));
      vertex(x, y);
    }
    endShape();
    popMatrix();

    fill(124, 96, 53);//茶色
    pushMatrix();
    translate(width/4*3+200, 600);
    beginShape();
    for (int theta = 0; theta < 360; theta++) {
      float x = R * (vertex_num * cos(radians(theta)) + cos(radians(-vertex_num * theta)));
      float y = R * (vertex_num * sin(radians(theta)) + sin(radians(-vertex_num * theta)));
      vertex(x, y);
    }
    endShape();
    popMatrix();

    fill(140, 140, 140);//グレー
    pushMatrix();
    translate(width/4*3+200, 750);
    beginShape();
    for (int theta = 0; theta < 360; theta++) {
      float x = R * (vertex_num * cos(radians(theta)) + cos(radians(-vertex_num * theta)));
      float y = R * (vertex_num * sin(radians(theta)) + sin(radians(-vertex_num * theta)));
      vertex(x, y);
    }
    endShape();
    popMatrix();

    fill(0);
    pushMatrix();
    translate(width/4*3+200, 900);
    beginShape();
    for (int theta = 0; theta < 360; theta++) {
      float x = R * (vertex_num * cos(radians(theta)) + cos(radians(-vertex_num * theta)));
      float y = R * (vertex_num * sin(radians(theta)) + sin(radians(-vertex_num * theta)));
      vertex(x, y);
    }
    endShape();
    popMatrix();

    if ( (pp ==1) ) {
      fill(255, 0, 0);
      stroke(255, 0, 0);
      toon(pp, x1, y1);
    } else if ( pp == 2) {
      fill(255, 0, 180);//ピンク
      stroke(255, 0, 180);
      toon(pp, x1, y1);
    } else if ( pp == 3) {
      fill(255, 129, 25);//オレンジ
      stroke(255, 129, 25);
      toon(pp, x1, y1);
    } else if (pp == 4) {
      fill(255, 255, 0);//黄色
      stroke(255, 255, 0);
      toon(pp, x1, y1);
    } else if (pp == 5) {
      fill(171, 255, 127);//黄緑
      stroke(171, 255, 127);
      toon(pp, x1, y1);
    } else if (pp == 6) {
      fill(0, 255, 65);//緑
      stroke(0, 255, 65);
      toon(pp, x1, y1);
    } else if (pp == 7) {
      fill(0, 0, 255);//青
      stroke(0, 0, 255);
      toon(pp, x1, y1);
    } else if (pp == 8) {
      fill(0, 180, 255);//水色
      stroke(0, 180, 255);
      toon(pp, x1, y1);
    } else if (pp == 9) {
      fill(196, 0, 204);//紫
      stroke(196, 0, 204);
      toon(pp, x1, y1);
    } else if (pp == 10) {
      fill(124, 96, 53);//茶色
      stroke(124, 96, 53);
      toon(pp, x1, y1);
    } else if (pp == 11) {
      fill(140, 140, 140);//グレー
      stroke(140, 140, 140);
      toon(pp, x1, y1);
    } else if (pp == 12) {
      fill(0);//黒
      stroke(0);
      toon(pp, x1, y1);
    } else {
      fill(255);
      stroke(0);
    }

    x1=x1+dx1;
    y1=y1+dy1;
    if (width < x1) {
      dx1 = -1*dx1;
    } else if (x1 < 0) {
      dx1 = -1*dx1;
    }
    if (height < y1) {
      dy1 = -1*dy1;
    } else if (y1 < 0) {
      dy1 = -1*dy1;
    }
    textSize(100);
    text(a, x1, y1);


    if ( pq == 1 ) {
      fill(255, 0, 0);
      stroke(255, 0, 0);
      toon(pq, x2, y2);
    } else if ( pq == 2) {
      fill(255, 0, 180);//ピンク
      stroke(255, 0, 180);
      toon(pq, x2, y2);
    } else if ( pq == 3) {
      fill(255, 129, 25);//オレンジ
      stroke(255, 129, 25);
      toon(pq, x2, y2);
    } else if (pq == 4) {
      fill(255, 255, 0);//黄色
      stroke(255, 255, 0);
      toon(pq, x2, y2);
    } else if (pq == 5) {
      fill(171, 255, 127);//黄緑
      stroke(171, 255, 127);
      toon(pq, x2, y2);
    } else if (pq == 6) {
      fill(0, 255, 65);//緑
      stroke(0, 255, 65);
      toon(pq, x2, y2);
    } else if (pq == 7) {
      fill(0, 0, 255);//青
      stroke(0, 0, 255);
      toon(pq, x2, y2);
    } else if (pq == 8) {
      fill(0, 180, 255);//水色
      stroke(0, 180, 255);
      toon(pq, x2, y2);
    } else if (pq == 9) {
      fill(196, 0, 204);//紫
      stroke(196, 0, 204);
      toon(pq, x2, y2);
    } else if (pq == 10) {
      fill(124, 96, 53);//茶色
      stroke(124, 96, 53);
      toon(pq, x2, y2);
    } else if (pq == 11) {
      fill(140, 140, 140);//グレー
      stroke(140, 140, 140);
      toon(pq, x2, y2);
    } else if (pq == 12) {
      fill(0);//黒
      stroke(0);
      toon(pq, x2, y2);
    } else {
      fill(255);
      stroke(0);
    }
    x2=x2+dx2;
    y2=y2+dy2;
    if (width < x2) {
      dx2 = -1*dx2;
    } else if (x2 < 0) {
      dx2 = -1*dx2;
    }
    if (height < y2) {
      dy2 = -1*dy2;
    } else if (y2 < 0) {
      dy2 = -1*dy2;
    }
    text(b, x2, y2);

    if ( pr == 1 ) {
      fill(255, 0, 0);
      stroke(255, 0, 0);
      toon(pr, x3, y3);
    } else if ( pr == 2) {
      fill(255, 0, 180);//ピンク
      stroke(255, 0, 180);
      toon(pr, x3, y3);
    } else if ( pr == 3) {
      fill(255, 129, 25);//オレンジ
      stroke(255, 129, 25);
      toon(pr, x3, y3);
    } else if (pr == 4) {
      fill(255, 255, 0);//黄色
      stroke(255, 255, 0);
      toon(pr, x3, y3);
    } else if (pr == 5) {
      fill(171, 255, 127);//黄緑
      stroke(171, 255, 127);
      toon(pr, x3, y3);
    } else if (pr == 6) {
      fill(0, 255, 65);//緑
      stroke(0, 255, 65);
      toon(pr, x3, y3);
    } else if (pr == 7) {
      fill(0, 0, 255);//青
      stroke(0, 0, 255);
      toon(pr, x3, y3);
    } else if (pr == 8) {
      fill(0, 180, 255);//水色
      stroke(0, 180, 255);
      toon(pr, x3, y3);
    } else if (pr == 9) {
      fill(196, 0, 204);//紫
      stroke(196, 0, 204);
      toon(pr, x3, y3);
    } else if (pr == 10) {
      fill(124, 96, 53);//茶色
      stroke(124, 96, 53);
      toon(pr, x3, y3);
    } else if (pr == 11) {
      fill(140, 140, 140);//グレー
      stroke(140, 140, 140);
      toon(pr, x3, y3);
    } else if (pr == 12) {
      fill(0);//黒
      stroke(0);
      toon(pr, x3, y3);
    } else {
      fill(255);
      stroke(0);
    }

    x3=x3+dx3;
    y3=y3+dy3;
    if (width < x3) {
      dx3 = -1*dx3;
    } else if (x3 < 0) {
      dx3 = -1*dx3;
    }
    if (height < y3) {
      dy3 = -1*dy3;
    } else if (y3 < 0) {
      dy3 = -1*dy3;
    }
    text(c, x3, y3);

    //individual JOINTS
    for (int i = 0; i < skeletonArray.size(); i++) {
      KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
      if (skeleton.isTracked()) {
        KJoint[] joints = skeleton.getJoints();

        color col  = skeleton.getIndexColor();
        fill(col);
        stroke(col);

        drawHandState1(joints[KinectPV2.JointType_HandLeft]);
        drawHandState2(joints[KinectPV2.JointType_HandRight]);

        migix = joints[KinectPV2.JointType_HandRight].getX();
        migiy= joints[KinectPV2.JointType_HandRight].getY();
        migiz = joints[KinectPV2.JointType_HandRight].getZ();

        hidarix = joints[KinectPV2.JointType_HandLeft].getX();
        hidariy = joints[KinectPV2.JointType_HandLeft].getY();
        hidariz = joints[KinectPV2.JointType_HandLeft].getZ();
        
      }
    }
    peo = skeletonArray.size();
  }
}

//left
void drawHandState1(KJoint joint) {
  noStroke();
  handState1(joint.getState(), hidarix, hidariy);

  if (count == 1) {
    fill(255, 0, 0);
  } else if (count == 2) {
    fill(255, 0, 180);//ピンク
  } else if (count == 3) {
    fill(255, 129, 25);//オレンジ
  } else if (count == 4) {
    fill(255, 255, 0);//黄色
  } else if (count == 5) {
    fill(171, 255, 127);//黄緑
  } else if (count == 6) {
    fill(0, 255, 65);//緑
  } else { 
    fill(255);
  }

  pushMatrix();
  if (0 < count && count <= 6) {
    translate(hidarix, hidariy, hidariz);
    if (cc == 0) {
      bx=random(100, 150);
      by=random(100, 150);
      cc = 9;
    } else {
      cc--;
    }
    ellipse(0, 0, bx, by);
  }
  popMatrix();
}

//right
void drawHandState2(KJoint joint) {
  noStroke();
  handState2(joint.getState(), migix, migiy);

  if (count == 7) {
    fill(0, 0, 255);//青
  } else if (count == 8) {
    fill(0, 180, 255);//水色
  } else if (count == 9) {
    fill(196, 0, 204);//紫
  } else if (count == 10) {
    fill(124, 96, 53);//茶色
  } else if (count == 11) {
    fill(140, 140, 140);
  } else if (count == 12) {
    fill(0);
  } else { 
    fill(255);
  }

  pushMatrix();
  if (7 <= count && count <= 12) {
    translate(migix, migiy, migiz);
    if (cc == 0) {
      bx=random(100, 150);
      by=random(100, 150);
      cc = 9;
    } else {
      cc--;
    }
    ellipse(0, 0, bx, by);
  }
  popMatrix();
}

//left
void handState1(int handState, float x, float y) {
  switch(handState) {
  case KinectPV2.HandState_Open:

    if (count > 0) {

      if ( (x1 < x && x < x1+220) && (y1 < y && y < y1+130 ) ) {
        pcount = 1;
        if (count == 1) {
          pp = 1;
          tc = 1;
          count = 0;
        } else if (count == 2) {
          pp = 2;
          tc = 2;
          count = 0;
        } else if (count == 3) {
          pp = 3;
          tc = 3;
          count = 0;
        } else if (count == 4) {
          pp = 4;
          tc = 4;
          count = 0;
        } else if (count == 5) {
          pp = 5;
          tc = 5;
          count = 0;
        } else if (count == 6) {
          pp = 6;
          tc = 6;
          count = 0;
        } else {
          pcount = 0;
        }
      }

      if ( (x2 < x && x < x2+220) && (y2 < y && y < y2+130 ) ) {
        pcount = 1;
        if (count == 1) {
          pq = 1;
          tc = 1;
          count = 0;
        } else if (count == 2) {
          pq = 2;
          tc = 2;
          count = 0;
        } else if (count == 3) {
          pq = 3;
          tc = 3;
          count = 0;
        } else if (count == 4) {
          pq = 4;
          tc = 4;
          count = 0;
        } else if (count == 5) {
          pq = 5;
          tc = 5;
          count = 0;
        } else if (count == 6) {
          pq = 6;
          tc = 6;
          count = 0;
        } else {
          pcount = 0;
        }
      }

      if ( (x3 < x && x < x3+220) && (y3 < y && y < y3+130 ) ) {
        pcount = 1;
        if (count == 1) {
          pr = 1;
          tc = 1;
          count = 0;
        } else if (count == 2) {
          pr = 2;
          tc = 2;
          count = 0;
        } else if (count == 3) {
          pr = 3;
          tc = 3;
          count = 0;
        } else if (count == 4) {
          pr = 4;
          tc = 4;
          count = 0;
        } else if (count == 5) {
          pr = 5;
          tc = 5;
          count = 0;
        } else if (count == 6) {
          pr = 6;
          tc = 6;
          count = 0;
        } else {
          pcount = 0;
        }
      }
    }
    break;
  case KinectPV2.HandState_Closed:

    if ( (width/4-150 < x && x < width/4-50) && (50 < y && y < 250) ) {
      count = 1;
    } else if ( (width/4-150 < x && x < width/4-50) && (200 < y && y < 400) ) {
      count = 2;
    } else if ((width/4-150 < x && x < width/4-50) && (350 < y && y < 550) ) {
      count = 3;
    } else if ((width/4-150 < x && x < width/4-50) && (500 < y && y < 700)  ) {
      count = 4;
    } else if ((width/4-150 < x && x < width/4-50) && (650 < y && y < 850)  ) {
      count = 5;
    } else if ((width/4-150 < x && x < width/4-50) && (800 < y && y < 1000)  ) {
      count = 6;
    } else {
    }
    break;
  case KinectPV2.HandState_Lasso:
    break;
  case KinectPV2.HandState_NotTracked:
    break;
  }
}

//right
void handState2(int handState, float x, float y) {
  switch(handState) {
  case KinectPV2.HandState_Open:
    if (count > 0) {

      if ( (x1 < x && x < x1+220) && (y1 < y && y < y1+130 )) {
        pcount = 2;
        if (count == 7) {
          pp = 7;
          tc = 7;
          count=0;
        } else if (count == 8) {
          pp = 8;
          tc = 8;
          count=0;
        } else if (count == 9) {
          pp = 9;
          tc = 9;
          count=0;
        } else if (count == 10) {
          pp = 10;
          tc = 10;
          count=0;
        } else if (count == 11) {
          pp = 11;
          tc = 11;
          count=0;
        } else if (count == 12) {
          pp = 12;
          tc = 12;
          count=0;
        } else {
          pcount = 0;
        }
      }

      if ( (x2 < x && x < x2+220) && (y2 < y && y < y2+130 ) ) {
        pcount = 2;
        if (count == 7) {
          pq = 7;
          tc = 7;
          count=0;
        } else if (count == 8) {
          pq = 8;
          tc = 8;
          count=0;
        } else if (count == 9) {
          pq = 9;
          tc = 9;
          count=0;
        } else if (count == 10) {
          pq = 10;
          tc = 10;
          count=0;
        } else if (count == 11) {
          pq = 11;
          tc = 11;
          count=0;
        } else if (count == 12) {
          pq = 12;
          tc = 12;
          count=0;
        } else {
          pcount = 0;
        }
      }

      if ( (x3 < x && x < x3+220) && (y3 < y && y < y3+130 ) ) {
        pcount = 2;
        if (count == 7) {
          pr = 7;
          tc = 7;
          count=0;
        } else if (count == 8) {
          pr = 8;
          tc = 8;
          count=0;
        } else if (count == 9) {
          pr = 9;
          tc = 9;
          count=0;
        } else if (count == 10) {
          pr = 10;
          tc = 10;
          count=0;
        } else if (count == 11) {
          pr = 11;
          tc = 11;
          count=0;
        } else if (count == 12) {
          pr = 12;
          tc = 12;
          count=0;
        } else {
          pcount = 0;
        }
      }
    }
    break;
  case KinectPV2.HandState_Closed:

    if ( (width/4*3+100 < x && x < width/4*3+300) && (50 < y && y < 250) ) {
      count = 7;
    } else if ( (width/4*3+100 < x && x < width/4*3+300) && (200 < y && y < 400) ) {
      count = 8;
    } else if ((width/4*3+100 < x && x < width/4*3+300) && (350 < y && y < 550) ) {
      count = 9;
    } else if ((width/4*3+100 < x && x < width/4*3+300) && (500 < y && y < 700)  ) {
      count = 10;
    } else if ((width/4*3+100 < x && x < width/4*3+300) && (650 < y && y < 850)  ) {
      count = 11;
    } else if ((width/4*3+100 < x && x < width/4*3+300) && (800 < y && y < 1000)  ) {
      count = 12;
    } else {
    }  
    break;
  case KinectPV2.HandState_Lasso:
    break;
  case KinectPV2.HandState_NotTracked:
    break;
  }
}

void toon(int i, float x, float y) {    
  if (i == tc ) {
    if (xx < 150) {
      ellipse(x+50, y + xx, 400, 400);
      ellipse(x-200+50, y-50+xx, 30, 30);
      ellipse(x-200+50, y-150+xx, 30, 30);
      ellipse(x-150+50, y-180+xx, 30, 30);
      ellipse(x-110+50, y-250+xx, 30, 30);
      ellipse(x-50+50, y-240+xx, 30, 30);
      ellipse(x+110+50, y-220+xx, 30, 30);
      ellipse(x+210+50, y-280+xx, 30, 30);
      ellipse(x+210+50, y-120+xx, 30, 30);
      ellipse(x+250+50, y+150+xx, 30, 30);
      ellipse(x+150+50, y+180+xx, 30, 30);
      ellipse(x+110+50, y+280+xx, 30, 30);
      ellipse(x+50+50, y+200+xx, 30, 30);
      ellipse(x-110+50, y+250+xx, 30, 30);
      ellipse(x-150+50, y+220+xx, 30, 30);

      ellipse(x-180+50, y+170+xx, 40, 40);

      ellipse(x-200+50, y+150+xx, 20, 20);
      ellipse(x-220+50, y+170+xx, 20, 20);
      ellipse(x-170+50, y+190+xx, 20, 20);

      ellipse(x+220+50, y+90+xx, 40, 40);

      ellipse(x+240+50, y+70+xx, 20, 20);
      ellipse(x+270+50, y+70+xx, 20, 20);
      ellipse(x+210+50, y+xx, 20, 20);

      ellipse(x+220+50, y-90+xx, 40, 40);

      ellipse(x-240+50, y-70+xx, 20, 20);
      ellipse(x-270+50, y-70+xx, 20, 20);
      ellipse(x-210+50, y+xx, 20, 20);

      strokeWeight(30);
      line(x+50, y+xx, x-200+50, y+xx);
      line(x+50, y+xx, x-200+50, y-150+xx);
      line(x+50, y+xx, x-150+50, y-180+xx);
      line(x+50, y+xx, x-110+50, y-250+xx);
      line(x+50, y+xx, x+110+50, y-220+xx);
      line(x+50, y+xx, x+210+50, y-280+xx);
      line(x+50, y+xx, x+210+50, y-110+xx);
      line(x+50, y+xx, x-150+50, y-180+xx);
      line(x+50, y+xx, x+250+50, y+150+xx);
      line(x+50, y+xx, x+150+50, y+180+xx);
      line(x+50, y+xx, x+110+50, y+280+xx);
      line(x+50, y+xx, x+50, y+200+xx);
      line(x+50, y+xx, x-110+50, y+250+xx);
      line(x+50, y+xx, x-150+50, y+220+xx);
      line(x+50, y+xx, x+50, y-240+xx);

      xx = xx + dc;
    } else {
      tc = -1;
      xx = 0;
    }
  }
}

String hh(String v, int i){
  switch(i) {
    case 0:
    v = "はしる";
    break;
    
    case 1:
    v = "なげる";
    break;
    
    case 2:
    v = "はなす";
    break;
    
    case 3:
    v = "あそぶ";
    break;
    
    case 4:
    v = "にらむ";
    break;
    
    case 5:
    v = "あるく";
    break;
    
    case 6:
    v = "おこる";
    break;
    
    case 7:
    v = "わらう";
    break;
    
    case 8:
    v = "ちぢむ";
    break;
    
    case 9:
    v = "はかる";
    break;
    
    case 10:
    v = "にげる";
    break;
    
    case 11:
    v = "ねがう";
    break;
    
    case 12:
    v = "さがす";
    break;
  
  default: //どのケースにも当てはまらないとき以下を実行
    stroke(0, 0, 255);
    break;
  }
  
  return v;
}