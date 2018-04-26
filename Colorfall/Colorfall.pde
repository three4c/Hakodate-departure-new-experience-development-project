import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import gab.opencv.*;
import KinectPV2.KJoint;
import KinectPV2.*;


KinectPV2 kinect;
OpenCV opencv;

Minim minim;    //追加箇所
AudioPlayer player;    //追加箇所

float polygonFactor = 1;
int threshold = 10;

//Distance in cm
int maxD = 4500; //4.5m
int minD = 50; //50cm

boolean    contourBodyIndex = true;

float zVal = 180;
float rotX = PI;

int c;  //下記のcolor[][]の、どの段を参照するかを決定するための変数
int playerColor[] = {0, 0, 0};  //人の色
int objectColor[] = {0, 0, 0};  //オブジェクトの合計の色
int pColors[][] = {  //位置(position)の色情報
  {85, 0, 0}, 
  {85, 42, 0}, 
  {85, 85, 0}, 
  {42, 85, 0}, 
  {0, 85, 0}, 
  {0, 85, 42}, 
  {0, 85, 85}, 
  {0, 42, 85}, 
  {0, 0, 85}, 
  {42, 0, 85}, 
  {85, 0, 85}
};
int oColors[][] = {  //オブジェクトの色情報
  //初期色
  {0, 0, 0}, 

  //濃い方
  {255, 0, 0}, 
  {255, 128, 0}, 
  {255, 255, 0}, 
  {128, 255, 0}, 
  {0, 255, 0}, 
  {0, 255, 128}, 
  {0, 255, 255}, 
  {0, 128, 255}, 
  {0, 0, 255}, 
  {128, 0, 255}, 
  {255, 0, 255}, 

  //薄い方
  {170, 0, 0}, 
  {170, 85, 0}, 
  {170, 170, 0}, 
  {85, 170, 0}, 
  {0, 170, 0}, 
  {0, 170, 85}, 
  {0, 170, 170}, 
  {0, 85, 170}, 
  {0, 0, 170}, 
  {85, 0, 170}, 
  {170, 0, 170}
};

ArrayList<Integer[]> catchColors = new ArrayList<Integer[]>();    //追加箇所

float SpineBaseX;//人の腰のx座標の位置

float trigger = 0;
int timecount = 0;  //何秒経ったかを計測する変数
int i;          //画像と、処理に必要な諸情報が格納されたObjects型のArrayListを参照するための変数
int x = 0;      //画像のx座標　あまり意味はないが、妙なバグが出られても困るので初期化している
int y;          //画像のy座標　多分これ使ってない
int yspeed = 3; //画像が降る速さ　ちょうどオブジェクトが画面に3つ収まるように調整している
float either;    //四角と円のどちらを降らせるか、を判定する変数
float contourNumPoints = 1860;

PImage img_temp;  //読み込んだ画像を一時的に保存しておく変数
ArrayList<PImage> rectimg = new ArrayList<PImage>();  //四角の画像を押し込むArrayList
ArrayList<PImage> ellipseimg = new ArrayList<PImage>();  //円の画像を押しこむArrayList

Objects pct;  //新しくObjectクラスを宣言するための変数
ArrayList<Objects> objects = new ArrayList<Objects>();  //生成したObjectクラスの情報を格納するためのArrayList

int BaseX = 0;
int clearcount = 0;
int listcount = 0;
int t = 120;

void setup() {
  size(1306, displayHeight, P3D);
  opencv = new OpenCV(this, 512, 424);
  kinect = new KinectPV2(this);

  kinect.enableBodyTrackImg(true);
  kinect.enableSkeleton3DMap(true);

  kinect.init();

  minim = new Minim(this);    //追加箇所
  player = minim.loadFile("hoge.wav");    //追加箇所

  setImage();  //一気に画像をrectimgとellipseimgにぶちこむ
}

void draw() {
  scale(2.55);//全体を拡大

  background(playerColor[0], playerColor[1], playerColor[2]);//人に塗る色

  timecount++;  //経過秒数を測る

  opencv.loadImage(kinect.getBodyTrackImage());
  opencv.gray();
  opencv.threshold(threshold);

  if (timecount == 40) {  //「40/60秒が経過したら」という意味
    trigger = random(1);
    if (trigger < 0.7) {
      either = random(1);  //eitherに、0～1の値をランダムでセット
      //if (either > 0.5) setRect();  //eitherが0.5以上なら四角を、
      //else setEllipse();            //それ以外（つまり0.5未満）の場合は円を、
      //objectsにセットさせるための関数を起動
      setObjects(either);    //関数化してみた
    }
    trigger = 0;
    timecount = 0;  //カウントを０にリセットして再び経過時間を計測させる
  }

  //人以外の範囲を黒で塗りつぶし
  ArrayList<Contour> contours = opencv.findContours(false, false);

  if (contours.size() > 0) {
    for (Contour contour : contours) {
      contour.setPolygonApproximationFactor(polygonFactor);//これ消すと人がカクカクになる
      contourNumPoints = contour.numPoints();
      if ((contour.numPoints() > 50 && contour.numPoints() < 1860) || contour.numPoints() > 1860 ) {

        fill(0);
        beginShape();

        for (PVector point : contour.getPolygonApproximation ().getPoints()) {
          vertex(point.x, point.y);//人の輪郭を描画
        }
        endShape();

        for (PVector point : contour.getPolygonApproximation().getPoints()) {
          for (int n = 0; n < objects.size(); n++) {  //objectsに格納されているすべての要素を参照
            Objects obj_tmp = objects.get(n);  //一時的にobjectsのn番目の中身を保存しておくためのObject型の変数pct_tmpをここで宣言しておき、
            if (obj_tmp.checkHit(point.x, point.y)) {
              changeColor(obj_tmp.Color);
              if(playerColor[0] == 255 && playerColor[1] == 255 && playerColor[2] == 255){
              Integer[] totalObjectColor = { oColors[obj_tmp.Color][0],
                                             oColors[obj_tmp.Color][1],
                                             oColors[obj_tmp.Color][2] };
              catchColors.add(totalObjectColor);
              }
              removeObject(n);                 //関数化してみた
              player.rewind();    //追加箇所
              player.play();    //追加箇所
            }
          }
        }
      } else if (contour.numPoints() == 1860) {//人がいないと判断されたら色を初期化
        for (int n = 0; n < 3; n++) {
          objectColor[n] = 0;
          playerColor[n] = 0;
          c = 0;
        }
      }
    }
  }

  //余白を黒で塗りつぶし
  fill(0);
  rect(0, 0, 512, 1);
  rect(0, 1, 1, 423);
  rect(510, 1, 2, 423);
  rect(0, 422, 512, 2);

  //translate the scene to the center 
  //以下、人の腰の位置を取得するためにいろいろしてる
  pushMatrix();
  translate(512/2, 200, 0);
  scale(zVal);//奥行、値が小さいほど遠くに、大きいほど近くに
  rotateX(rotX);

  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeleton3d();

  //individual JOINTS
  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();

      //stroke(0,255,0);
      //strokeWeight(15);
      //point(joints[KinectPV2.JointType_SpineBase].getX(), joints[KinectPV2.JointType_SpineBase].getY());//腰の位置を描画

      //位置色の判定
      if (joints[KinectPV2.JointType_SpineBase].getX() <= -1.12) setColor(0);
      else if (joints[KinectPV2.JointType_SpineBase].getX() <= -0.84) setColor(1);
      else if (joints[KinectPV2.JointType_SpineBase].getX() <= -0.56) setColor(2);
      else if (joints[KinectPV2.JointType_SpineBase].getX() <= -0.28) setColor(3);
      else if (joints[KinectPV2.JointType_SpineBase].getX() <= 0) setColor(4);
      else if (joints[KinectPV2.JointType_SpineBase].getX() <= 0.28) setColor(5);
      else if (joints[KinectPV2.JointType_SpineBase].getX() <= 0.56) setColor(6);
      else if (joints[KinectPV2.JointType_SpineBase].getX() <= 0.84) setColor(7);
      else if (joints[KinectPV2.JointType_SpineBase].getX() <= 1.12) setColor(8);
      else if (joints[KinectPV2.JointType_SpineBase].getX() > 1.12) setColor(9);

      SpineBaseX = joints[KinectPV2.JointType_SpineBase].getX();//人の腰のx座標の位置を保存
    }
  }
  popMatrix();

  scale(0.55248619);//一旦全体の座標系を初期に戻す

  for (int n = 0; n < objects.size(); n++) {  //objectsに格納されているすべての要素を参照
    Objects pct_tmp = objects.get(n);  //一時的にobjectsのn番目の中身を保存しておくためのObject型の変数pct_tmpをここで宣言しておき、
    pct_tmp.draw();                    //このpct_tmpに画像を描画させる（ここの具体的な内容はObjects.pdeを参照のこと）
    if (pct_tmp.y > height) {          //画像のｙ座標がheightより大きい＝画面外に出た場合は
      objects.remove(n);               //その画像を消去し
      n--;                             //nをひとつ減らして参照位置のズレを補正
    }
  }

  OboolOR();  //今まで触ったオブジェクトの合計の「真のRBGの加色」関数を起動
  PboolOR();  //人とオブジェクトの「真のRBGの加色」関数を起動

  noStroke();

  if (playerColor[0] == 255 && playerColor[1] == 255 && playerColor[2] == 255) {//人の色が白に到達したら
    if (BaseX < 250) {
      fill(10, 200);
      rect(BaseX-250, 0, 250, height);
      BaseX += 3;
    } else {
      fill(10, 200);
      rect(0, 0, 250, height);
      fill(255);

      if (clearcount >= 30) text("Result:", 20, 40);
      fill(255, 0, 0);
      if (clearcount >= 60) text("Red", 20, 100);
      fill(0, 255, 0);
      if (clearcount >= 60) text("Green", 80, 100);
      fill(0, 0, 255);
      if (clearcount >= 60) text("Blue", 150, 100);
      
      /*if (clearcount >= t) {
        for(int n=0; n < 3; n++) {
          Integer[] toc_tmp = catchColors.get();
          text(toc_tmp[n], x * 30, setY);
        }
      }やりたそうなこと*/

      fill(255);
      if (clearcount >= 120) text("255          128          0", 20, 120);
      if (clearcount >= 150) text("+", 200, 120);
      if (clearcount >= 180) text("128          0             255", 20, 140);
      if (clearcount >= 210) text("+", 200, 140);
      if (clearcount >= 240) text("128          255         128", 20, 160);

      if (clearcount >= 300) text("=", 20, 200);

      if (clearcount >= 390) text("255          255          255", 20, 240);

      if (clearcount >= 690) {
        for (int n = 0; n < 3; n++) {
          objectColor[n] = 0;
          playerColor[n] = 0;
          c = 0;
        }
      }

      clearcount += 1;
    }
  } else {
    BaseX = 0;
    clearcount = 0;
    listcount = 0;
  }

  //デバック用に情報表示
  //fill(255);
  //text("ObjectColorRed: " + objectColor[0], 20, 20);
  //text("ObjectColorGreen: " + objectColor[1], 20, 40);
  //text("ObjectColorBlue: " + objectColor[2], 20, 60);

  //text("PlayerColorRed: " + playerColor[0], 20, 100);
  //text("PlayerColorGreen: " + playerColor[1], 20, 120);
  //text("PlayerColorBlue: " + playerColor[2], 20, 140);

  //text("BaseX: " + BaseX, 20, 160);

  //text("contourNumPoints: " + contourNumPoints, 20, 180);

  //text("SpineBaseX: " + SpineBaseX, 20, 220);//人の腰のx座標の位置を描画

  //text("fps: "+frameRate, 20, 260);
  //text("threshold: "+threshold, 20, 280);
  //text("minD: "+minD, 20, 300);
  //text("maxD: "+maxD, 20, 320);

  kinect.setLowThresholdPC(minD);
  kinect.setHighThresholdPC(maxD);
}
//メイン終わり

//デバック用
void mousePressed() {
  for (int n = 0; n < 3; n++) {
    objectColor[n] = 255;
    playerColor[n] = 255;
  }
}

//関数

void setColor(int i) {    //現在の人のx座標に応じた色を、playerColor[]にセットする関数
  for (int n = 0; n < 3; n++) {             //playerColor[]を全参照するfor文
    playerColor[n] = (int)(pColors[i][n]);  //playerColor[]のn番目(for文で回されてる方のint)に、
  }                                        //pColors[][]i段目(引数として与えられている方のi)
}

void changeColor(int i) {
  c = i;
}

void OboolOR() {  //今まで触ったオブジェクトの合計の「真のRBGの加色」関数
  for (int n = 0; n < 3; n++) {
    if (objectColor[n] < oColors[c][n]) {  //もしobjectColor[]の各値よりも大きい値が、参照したoColors[][]の中から見つかれば
      objectColor[n] = oColors[c][n];    //値をそれに更新
    }
  }
}

void PboolOR() {  //人とオブジェクトの「真のRBGの加色」関数
  for (int n = 0; n < 3; n++) {
    if (playerColor[n] < objectColor[n]) {  //もしplayerColor[]の各値よりも大きい値が、参照したobjectColor[]の中から見つかれば
      playerColor[n] = objectColor[n];    //値をそれに更新
    }
  }
}

void setImage() {  //画像をロードしまくる関数
  //四角の処理
  //明るい画像
  img_temp = loadImage("r(255,0,0).png");
  rectimg.add(img_temp);
  img_temp = loadImage("r(255,128,0).png");
  rectimg.add(img_temp);
  img_temp = loadImage("r(255,255,0).png");
  rectimg.add(img_temp);
  img_temp = loadImage("r(128,255,0).png");
  rectimg.add(img_temp);
  img_temp = loadImage("r(0,255,0).png");
  rectimg.add(img_temp);
  img_temp = loadImage("r(0,255,128).png");
  rectimg.add(img_temp);
  img_temp = loadImage("r(0,255,255).png");
  rectimg.add(img_temp);
  img_temp = loadImage("r(0,128,255).png");
  rectimg.add(img_temp);
  img_temp = loadImage("r(0,0,255).png");
  rectimg.add(img_temp);
  img_temp = loadImage("r(128,0,255).png");
  rectimg.add(img_temp);
  img_temp = loadImage("r(255,0,255).png");
  rectimg.add(img_temp);

  //暗めの画像
  img_temp = loadImage("r(170,0,0).png");
  rectimg.add(img_temp);
  img_temp = loadImage("r(170,85,0).png");
  rectimg.add(img_temp);
  img_temp = loadImage("r(170,170,0).png");
  rectimg.add(img_temp);
  img_temp = loadImage("r(85,170,0).png");
  rectimg.add(img_temp);
  img_temp = loadImage("r(0,170,0).png");
  rectimg.add(img_temp);
  img_temp = loadImage("r(0,170,85).png");
  rectimg.add(img_temp);
  img_temp = loadImage("r(0,170,170).png");
  rectimg.add(img_temp);
  img_temp = loadImage("r(0,85,170).png");
  rectimg.add(img_temp);
  img_temp = loadImage("r(0,0,170).png");
  rectimg.add(img_temp);
  img_temp = loadImage("r(85,0,170).png");
  rectimg.add(img_temp);
  img_temp = loadImage("r(170,0,170).png");
  rectimg.add(img_temp);

  //円の処理
  //明るい画像
  img_temp = loadImage("e(255,0,0).png");
  ellipseimg.add(img_temp);
  img_temp = loadImage("e(255,128,0).png");
  ellipseimg.add(img_temp);
  img_temp = loadImage("e(255,255,0).png");
  ellipseimg.add(img_temp);
  img_temp = loadImage("e(128,255,0).png");
  ellipseimg.add(img_temp);
  img_temp = loadImage("e(0,255,0).png");
  ellipseimg.add(img_temp);
  img_temp = loadImage("e(0,255,128).png");
  ellipseimg.add(img_temp);
  img_temp = loadImage("e(0,255,255).png");
  ellipseimg.add(img_temp);
  img_temp = loadImage("e(0,128,255).png");
  ellipseimg.add(img_temp);
  img_temp = loadImage("e(0,0,255).png");
  ellipseimg.add(img_temp);
  img_temp = loadImage("e(128,0,255).png");
  ellipseimg.add(img_temp);
  img_temp = loadImage("e(255,0,255).png");
  ellipseimg.add(img_temp);

  //暗めの画像
  img_temp = loadImage("e(170,0,0).png");
  ellipseimg.add(img_temp);
  img_temp = loadImage("e(170,85,0).png");
  ellipseimg.add(img_temp);
  img_temp = loadImage("e(170,170,0).png");
  ellipseimg.add(img_temp);
  img_temp = loadImage("e(85,170,0).png");
  ellipseimg.add(img_temp);
  img_temp = loadImage("e(0,170,0).png");
  ellipseimg.add(img_temp);
  img_temp = loadImage("e(0,170,85).png");
  ellipseimg.add(img_temp);
  img_temp = loadImage("e(0,170,170).png");
  ellipseimg.add(img_temp);
  img_temp = loadImage("e(0,85,170).png");
  ellipseimg.add(img_temp);
  img_temp = loadImage("e(0,0,170).png");
  ellipseimg.add(img_temp);
  img_temp = loadImage("e(85,0,170).png");
  ellipseimg.add(img_temp);
  img_temp = loadImage("e(170,0,170).png");
  ellipseimg.add(img_temp);
}

void setObjects(float either) {
  if (either > 0.5) setRect(either);  //eitherが0.5以上なら四角を、
  else setEllipse(either);            //それ以外（つまり0.5未満）の場合は円を、
  //objectsにセットさせるための関数を起動
}

void setRect(float either) {  //四角のObjects情報をArrayListにセットさせる関数
  i = (int)random(rectimg.size());  //まずどの四角を描画するかをランダムに決定させる　おさらいすると、rectimg()は四角の画像をすべて押しこんであるPImage型のArrayList
  if (i == rectimg.size()) i = 0;   //プログラムにおいては、配列だろうがArrayListだろうが、参照する位置というのは０から始まる
  //もしsize()の数字がきっちり出てしまう＝23番目を参照することになればセグメント違反になるので、そうならないように強引に0にしてしまう
  x = (int)random(width);           //画像のｘ座標をランダムで決定
  if (x >= width) x = 0;            //きっかり画面端を選択してしまって、画像が全く見えなくなるという事故を防いでいる　もうちょっと内側でも良い気がする
  pct = new Objects(rectimg.get(i), //Objectsクラスを新たに生成する
    either, //追加しました
    x, 
    -rectimg.get(i).height, //わざわざ画像の高さ文表示位置を上にずらしている理由は、オブジェクトが生成された時に「降ってくる」というよりも「突然現れて落ちてくる」といったほうが正しいような見え方になるから
    yspeed, 
    i);
  objects.add(pct);  //以上で生成したクラスをArrayListに格納する
}

void setEllipse(float either) {  //円のObjects情報をArrayListにセットさせる関数以下の処理はsetRect()と同じ　参照するArrayListと情報を格納するArrayListが違うだけ
  i = (int)random(ellipseimg.size());
  if (i == ellipseimg.size()) i = 0;
  x = (int)random(width);
  if (x >= width) x = 0;
  pct = new Objects(ellipseimg.get(i), 
    either, //追加しました
    x, 
    -ellipseimg.get(i).height, 
    yspeed, 
    i);
  objects.add(pct);
}

void removeObject(int i) {
  objects.remove(i);               //画像を消去し
  i--;                             //nをひとつ減らして参照位置のズレを補正
}




/*
//なんか値をいろいろ変えてる
 void keyPressed() {
 //change contour finder from contour body to depth-PC
 if ( key == 'b') {
 contourBodyIndex = !contourBodyIndex;
 if (contourBodyIndex)
 threshold = 200;
 else
 threshold = 40;
 }
 
 if (key == 'a') {
 threshold+=1;
 }
 if (key == 's') {
 threshold-=1;
 }
 
 if (key == '1') {
 minD += 10;
 }
 
 if (key == '2') {
 minD -= 10;
 }
 
 if (key == '3') {
 maxD += 10;
 }
 
 if (key == '4') {
 maxD -= 10;
 }
 
 if (key == '5')
 polygonFactor += 0.1;
 
 if (key == '6')
 polygonFactor -= 0.1;
 }
 */

void stop() {  ////追加箇所
  player.close();
  minim.stop();
  super.stop();
}