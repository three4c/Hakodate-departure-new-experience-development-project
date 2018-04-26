import KinectPV2.KJoint;
import KinectPV2.*;
import ddf.minim.*;
Minim minim;  //Minim型変数であるminimの宣言
AudioPlayer bomb, whistle, red, blue, green, yellow, reaget, reatime;  //サウンドデータ格納用の変数
KinectPV2 kinect;
PFont font;
PImage setu1, setu2, giza;
PImage title, r0, b1, y2, g3, p4, v5, o6, b7, s8, c9, a10, l11, l12, w13;
PImage sco, tim;
PImage next, conan;
int start, finish, setumei, game, kakari, xr, yr;
int hd = 0;
int hue = 0;
int iro = 0;
int shuryo = 0;
int saturation = 0;
int brightness = 0;
int houkou = 0;
int yon[] = {0, 1, 2, 3, 0};
int check = 0;
int rec = 0;
int a=90, b=81, o=41;
int big = 0;
int[] aa={0, 0, 0, 0};
float bollx[] = {2000, 2000, 2000, 2000, 2000}; //x座標
float bolly[] = {20, 20, 20, 20, 20}; //y座標
int bc[] = {0, 0, 0, 0, 0};
int bc2[] = {0, 0, 0, 0};
float bollx2[] = {random(100, 1800), random(100, 1800), random(100, 1800), random(100, 1800)}; //x座標
float bolly2[] = {random(100, 800), random(100, 800), random(100, 800), random(100, 800)}; //y座標
float handR[] = {0, 0};
float handL[] = {0, 0};
float cc1 = 0;
int t = 0;
int gzc, gs, gt = 0;
int ttama = 0;
float[] xx = {0, 0, 0, 0};
float[] yy = {0, 0, 0, 0};
int[] c = {0, 0, 0, 0, 0};
int[] count = {0, 0, 0, 0};
int number;
int tuyosa = 5;
int otiru= 5;
int[] bbtime ={0, 0};
float[][] sabun = {{-20, -8, 8, 20, 8, -8}, {0, -16, -16, 0, 16, 16}};
float[][] sabun0 = {{0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}};
float[][] sabun1 = {{0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}};
float[][] sabun2 = {{0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}};
float[][] sabun3 = {{0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}};
float gizax = 1830;
float gizay = 50;
int gc = 0;
int score = 0;
//付け加え
float[][] sabun4 = {{0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}};
int reahit = 0;
int count2 = 0;
int[] ballck1={0, 0, 0, 0};
int[] tikan={0, 1, 2, 3};
int maetc = 0;
int saidai = 0;
int first=-1;
int second=4;


void setup() {
  xr = yr = 150;
  start = game = finish = kakari = 0;
  setumei = 0;
  gzc = gs = 0;
  gt = 50;
  ttama = height;

  minim = new Minim(this);  //初期化
  bomb =  minim.loadFile("bomb.mp3");
  whistle = minim.loadFile("whistle.mp3");
  red = minim.loadFile("red.mp3");
  blue = minim.loadFile("blue.mp3");
  green = minim.loadFile("green.mp3");
  yellow = minim.loadFile("yellow.mp3");
  reaget = minim.loadFile("reaget.mp3");
  reatime = minim.loadFile("reatime.mp3");
  frameRate(60);
  //size(displayWidth, displayHeight, P3D);
  fullScreen(P3D, 2);
  kinect = new KinectPV2(this);
  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);
  kinect.init();
  strokeJoin(ROUND);
  colorMode(HSB, 360, 100, 100, 0.2);
  blendMode(ADD);
  strokeWeight(5);
  smooth();
  noCursor();
  setu1 = loadImage("o-rainfo1.png");
  setu2 = loadImage("o-rainfo2.png");
  next = loadImage("tugihe.png");
  conan = loadImage("hazimeru.png");
  title   = loadImage("o-ra.png");
  sco = loadImage("score.png");
  tim = loadImage("time.png");
  r0 = loadImage("0red.png");
  b1 = loadImage("1blue.png");
  y2 = loadImage("2yellow.png");
  g3 = loadImage("3green.png");
  p4 = loadImage("4pink.png");
  v5 = loadImage("5violet.png");
  o6 = loadImage("6orange.png");
  b7 = loadImage("7blown.png");
  s8 = loadImage("8sky.png");
  c9 = loadImage("9cyan.png");
  a10 = loadImage("10aquamarine.png");
  l11 = loadImage("11lemon.png");
  l12 = loadImage("12lightgreen.png");
  w13 = loadImage("13white.png");
  font = loadFont("MeiryoUI-48.vlw");
  giza = loadImage("gizagiza.png");
  textFont(font, 80);
  t = 1000;
}

void draw() {
  blendMode(ADD);
  if (start == 0) {
    background(0);
    image(title, 590, 100, 700, 360);
   
    box();
    ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();
    for (int i = 0; i < skeletonArray.size(); i++) {
      KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
      if (skeleton.isTracked()) {
        KJoint[] joint = skeleton.getJoints();
        starthand(joint);
      }
    }
  } else if (setumei == 0) { 
    background(0);
    image(setu1, 200, 50, width-400, 950);
    //image(next,  width-300, 800, 200, 200);
    rect(1515,75,180,180);
    ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();
    for (int i = 0; i < skeletonArray.size(); i++) {
      KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
      if (skeleton.isTracked()) {
        KJoint[] joint = skeleton.getJoints();
        starthand(joint);
      }
    }
  } else if (setumei == 1) {
    background(0);
    image(setu2, 200, 50, width-400, 950);
    //image(conan,  width-300, 800, 200, 200);
    ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();
    for (int i = 0; i < skeletonArray.size(); i++) {
      KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
      if (skeleton.isTracked()) {
        KJoint[] joint = skeleton.getJoints();
        starthand(joint);
      }
    }
    
  } else if (game == 0) {
    blendMode(ADD);
    background(0);
    image(kinect.getColorImage(), 0, 0, width, height);
    fill(0);
    ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();
    stop();
    if (t<=0) {
      game = 1;
      t=0;
    }
    auradama();
    nuri();
    for (int i=0; i<4; i++) {
      if (c[i]==0)  aa[i]=yon[i];
    }
    for (int i = 0; i < skeletonArray.size(); i++) {
      KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
      if (skeleton.isTracked()) {
        KJoint[] joints = skeleton.getJoints();
        hd = 0;
        drawHandState(joints[KinectPV2.JointType_HandRight]); //特に使ってないけど右手の状態
        hd = 1;
        drawHandState(joints[KinectPV2.JointType_HandLeft]);  //特に使ってないけど左手の状態
        aurairo();
        drawaura(joints);                                     //オーラの表示
        hantei(joints);
      }
    }
    blendMode(BLEND);
    fill(60, 5, 100);
    image(sco, 1500, 800, 300, 200);
    text(score, 1570, 950);
    image(tim, 125, 800, 300, 200);
    text(t, 200, 950);

    if (gs == 0) { 
      gt = (int)random(90, 120);
      gs = 1;
    }
    if (gt == 0)  gizagiza();
  } else if (finish==0) {
    blendMode(ADD);
    background(0);
    image(kinect.getColorImage(), 0, 0, width, height);
    ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();
    for (int i = 0; i < skeletonArray.size(); i++) {
      KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
      if (skeleton.isTracked()) {
        KJoint[] joints = skeleton.getJoints();
        drawaura(joints);        //オーラの表示
      }
    }
    if (shuryo == 0) {
      whistle.play();  //再生
      whistle.rewind();  //再生が終わったら巻き戻しておく
      shuryo = 1;
    }
    finished();
    stop();
    if (t>=130) {
      finish=1;
      t=0;
    }
  } else if (kakari==0) {
    background(0);
    image(kinect.getColorImage(), 0, 0, width, height);
    ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();
    for (int i = 0; i < skeletonArray.size(); i++) {
      blendMode(ADD);
      KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
      if (skeleton.isTracked()) {
        KJoint[] joints = skeleton.getJoints();
        drawaura(joints);                                     //オーラの表示
      }
    }

    blendMode(BLEND);
    kakaried();
    if (skeletonArray.size()==0)     shokika();
    fill(60, 5, 100);
    image(sco, 1500, 800, 300, 200);
    text(score, 1570, 960);
  }
}

void box() {
  fill(0, 0, 0);
  stroke(128);
  if (start == 0)  rect(400, 600, 1120, 200);
  else if (setumei == 0 || setumei == 1) rect(500, 800, 930, 100);
  
  fill(0, 0, 255);
  if (start == 0)  text("はじめる", 834, 730);
}


void starthand(KJoint[] joints) {
  startbox(joints, KinectPV2.JointType_HandRight, KinectPV2.JointType_HandLeft);
}

void startbox(KJoint[] joints, int right, int left) {
  float rx = joints[right].getX();
  float ry = joints[right].getY();
  float lx = joints[left].getX();
  float ly = joints[left].getY();
  fill(0, 0, 0);
  ellipse(rx, ry, xr, yr);
  ellipse(lx, ly, xr, yr);
  if (start == 0) {
    if (rx > 400 && rx < 1520 && ry > 600 && ry < 800) { 
      xr -= 3;
      yr -= 3;
      if (xr <= 0) {
        start = 1;
        xr = yr = 150;
      }
    }else if (lx > 400 && lx < 1520 && ly > 600 && ly < 800) { 
      xr -= 3;
      yr -= 3;
      if (xr <= 0) {
        start = 1;
        xr = yr = 150;
      }
    }
    
  } else if (setumei==0 || setumei == 1) {
    if (rx > 1515 && rx < 1695 && ry > 75 && ry < 255) {
      xr -= 3;
      yr -= 3;
      if (xr <= 0) {
        if (setumei==0) {
          t=130;
          setumei=1;
          xr = yr = 150;
        } else if (setumei==1) {
          setumei = 2;
          t = 1000;
        }
      }
    }else if (lx > 1515 && lx < 1695 && ly > 75 && ly < 255) {
      xr -= 3;
      yr -= 3;
      if (xr <= 0) {
        if (setumei==0) {
          t=130;
          setumei=1;
          xr = yr = 150;
        } else if (setumei==1) {
          setumei = 2;
          t = 1000;
        }
      }
    }
  }
}

void stop() {
  if (game == 0) {
    t--;
    if (gt>0)    gt--;
  } else t++;
}

void finished() {
  fill(0, 0, 60);
  rect(0, height/2-200, width, 400);
  fill(0, 0, 0);
  textFont(font, 110);
  text("フィニッシュ!!", 680, 570);
}

void kakaried() {
  if (iro == 0) {
    fill(0, 0, 0, 0);
    image(r0, 0, 0, 1920, 250);
  }
  if (iro == 1) {
    fill(0, 0, 0, 0);
    image(b1, 0, 0, 1920, 250);
  }
  if (iro == 2) {
    fill(0, 0, 0, 0);
    image(y2, 0, 0, 1920, 250);
  }
  if (iro == 3) {
    fill(0, 0, 0, 0);
    image(g3, 0, 0, 1920, 250);
  }
  if (iro == 4) {
    fill(0, 0, 0, 0);
    image(p4, 0, 0, 1920, 250);
  }
  if (iro == 5) {
    fill(0, 0, 0, 0);
    image(v5, 0, 0, 1920, 250);
  }
  if (iro == 6) {
    fill(0, 0, 0, 0);
    image(o6, 0, 0, 1920, 250);
  }
  if (iro == 7) {
    fill(0, 0, 0, 0);
    image(b7, 0, 0, 1920, 250);
  }
  if (iro == 8) {
    fill(0, 0, 0, 0);
    image(s8, 0, 0, 1920, 250);
  }
  if (iro == 9) {
    fill(0, 0, 0, 0);
    image(c9, 0, 0, 1920, 250);
  }
  if (iro == 10) {
    fill(0, 0, 0, 0);
    image(a10, 0, 0, 1920, 250);
  }
  if (iro == 11) {
    fill(0, 0, 0, 0);
    image(l11, 0, 0, 1920, 250);
  }
  if (iro == 12) {
    fill(0, 0, 0, 0);
    image(l12, 0, 0, 1920, 250);
  }
  if (iro == 13) {
    fill(0, 0, 0, 0);
    image(w13, 0, 0, 1920, 250);
  }
}

void gizagiza() {
  if (houkou == 0) {
    if (gc==0) {
      gizay =  random(400, 600);
      gc++;
    }
    if (gizax >= 10) {
      image(giza, gizax, gizay, 150, 150);
      gizax -= 10;
    } else {
      houkou = 1;
      gizay = 0;
      gc=0;
      gs=0;
    }
  } else {
    if (gc==0) {
      gizax =  random(300, 1000);
      gc++;
    }
    if (gizay <= 990) {
      image(giza, gizax, gizay, 150, 150);
      gizay += 10;
    } else {
      houkou = 0;
      gizax = 1880;
      gc=0;
      gs=0;
    }
  }
}

void shokika() {
  int i = 0;

  check = 0;
  start =  setumei =  game =  finish =  kakari = t = shuryo = 0;
  xr = yr = 150;
  hd = hue = iro = saturation = brightness = 0;
  cc1 = gc = score = 0;
  t =  1000;
  gs = 0;
  gt = 50;
  ttama = height;
  tuyosa=5;
  gizax=1830;
  gizay=50;
  rec = 0;
  big = 0;
  bc[4]=0;
  c[4] = 0;
  bollx[4]=0;
  bolly[4]=0;
  otiru = 5;

  //aa
  reahit = 0;
  count2 = 0;
  bbtime[1] = bbtime[0] = 0;
  first = -1;
  second = 4;

  for (i=0; i<4; i++) { 
    bollx[i] = 2000; //x座標
    bolly[i] = 20; //y座標
    bc[i] = 0;
    xx[i]=0;
    yy[i]=0;
    c[i] = 0;
    count[i] = 0;
    yon[i] = i;
    ballck1[i]=0;
    tikan[i]=i;
  }
  bollx[4] = 0;
  bolly[4] = 0;
  for (i=0; i<2; i++) {
    handR[i] = 0;
    handL[i] = 0;
  }

  for (i=0; i<2; i++) {
    for (int j=0; j<6; j++) {
      sabun0[i][j] = 0;
      sabun1[i][j] = 0;
      sabun2[i][j] = 0;
      sabun3[i][j] = 0;
      sabun4[i][j] = 0;
    }
  }
  sabun[0][0] = -20;
  sabun[0][1] = -8;
  sabun[0][2] = 8;
  sabun[0][3] = 20;
  sabun[0][4] = 8;
  sabun[0][5] = -8;
  sabun[1][0] = 0;
  sabun[1][1] = -16;
  sabun[1][2] = -16;
  sabun[1][3] = 0;
  sabun[1][4] = 16;
  sabun[1][5] = 16;
}


void drawaura(KJoint[] joints) {
  bodyck(joints, KinectPV2.JointType_HandRight, KinectPV2.JointType_HandLeft);  //bodyのx, yの座標を入手

  drawBone(joints, KinectPV2.JointType_Head);//頭
  drawBone(joints, KinectPV2.JointType_Neck);//首
  drawBone(joints, KinectPV2.JointType_SpineShoulder);//肩の真ん中
  drawBone(joints, KinectPV2.JointType_SpineMid);//だいたい腹
  drawBone(joints, KinectPV2.JointType_SpineBase);//腰

  drawBone(joints, KinectPV2.JointType_ShoulderLeft);//左肩
  drawBone(joints, KinectPV2.JointType_ElbowLeft);//左ひじ
  drawBone(joints, KinectPV2.JointType_WristLeft);//左手首
  drawBone(joints, KinectPV2.JointType_HandLeft);//左手
  drawBone(joints, KinectPV2.JointType_HipLeft);//左尻
  drawBone(joints, KinectPV2.JointType_KneeLeft);//左ひざ
  drawBone(joints, KinectPV2.JointType_AnkleLeft);//左足首
  drawBone(joints, KinectPV2.JointType_FootLeft);//だいたい左つま先

  drawBone(joints, KinectPV2.JointType_ShoulderRight);//右肩
  drawBone(joints, KinectPV2.JointType_ElbowRight);//右ひじ
  drawBone(joints, KinectPV2.JointType_WristRight);//右手首
  drawBone(joints, KinectPV2.JointType_HandRight);//右手のだいたい甲
  drawBone(joints, KinectPV2.JointType_HipRight);//右尻
  drawBone(joints, KinectPV2.JointType_KneeRight);//右ひざ
  drawBone(joints, KinectPV2.JointType_AnkleRight);//右足首
  drawBone(joints, KinectPV2.JointType_FootRight);//だいだい右つま先

  drawaura2(joints, KinectPV2.JointType_ElbowLeft, KinectPV2.JointType_ShoulderLeft);//肩と肘
  drawaura2(joints, KinectPV2.JointType_ElbowRight, KinectPV2.JointType_ShoulderRight);
  drawaura2(joints, KinectPV2.JointType_HandLeft, KinectPV2.JointType_ElbowLeft);//肘と手
  drawaura2(joints, KinectPV2.JointType_HandRight, KinectPV2.JointType_ElbowRight);
  drawaura2(joints, KinectPV2.JointType_KneeLeft, KinectPV2.JointType_HipLeft);//尻とひざ
  drawaura2(joints, KinectPV2.JointType_KneeRight, KinectPV2.JointType_HipRight);
  drawaura2(joints, KinectPV2.JointType_AnkleRight, KinectPV2.JointType_KneeRight);//足首と膝
  drawaura2(joints, KinectPV2.JointType_AnkleLeft, KinectPV2.JointType_KneeLeft);
  drawaura2(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_SpineMid);//肩と腹
  drawaura2(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_SpineMid);//腹と腰
}

void bodyck(KJoint[] joints, int right, int left) {
  handR[0] = joints[right].getX(); //bodyxにx座標を入れる
  handR[1] = joints[right].getY(); //bodyyにy座標を入れる
  handL[0] = joints[left].getX(); //bodyxにx座標を入れる
  handL[1] = joints[left].getY(); //bodyyにy座標を入れる
}

void drawBone(KJoint[] joints, int jointType1) { //各骨格のポイントのオーラを表示
  if (cc1!=0) {
    for (int i = 0; i < 1; i++) {  //オーラの強さを判断してループ
      float x = joints[jointType1].getX();    // x座標
      float y = joints[jointType1].getY();   // y座標
      float w = random(100+tuyosa, 130+tuyosa);  // 幅
      float h = random(100+tuyosa, 130+tuyosa);  // 高さ
      noStroke();
      fill(hue, saturation, brightness);
      ellipse(x+random(-10, 10), y+random(-10, 10), w, h); //座標を微妙にづらして表示
    }
  }
}

void drawaura2(KJoint[] joints, int jointType1, int jointType2) { //各ポイント間の隙間（脛とか）のオーラを表示
  if (cc1!=0) {
    for (int i = 0; i < 1; i++) {
      float x = joints[jointType1].getX();    // x座標
      float x2 = joints[jointType2].getX();
      float y = joints[jointType1].getY();   // y座標
      float y2 = joints[jointType2].getY();
      float vx, vy, cg;
      float w = random(100+tuyosa, 160+tuyosa);       // 幅
      float h = random(100+tuyosa, 160+tuyosa);       // 高さ
      //int hue = (int)random(cl[peo], cl[peo]+70); // 色相
      vx = vy = cg = 0.0;
      noStroke();
      vx = (x - x2)/2; //x座標の差を入手
      vy = (y - y2)/2; //y座標の差を入手
      if (vx<0) vx = vx * (-1); //差が負だったら正に入れ替え
      if (vy<0) vy = vy * (-1); //差が負だったら正に入れ替え
      fill(hue, saturation, brightness); 
      if (x>x2) { //2番目より1番目のx座標が大きかったら入れ替え
        cg = x; 
        x = x2; 
        x2 = x;
      }
      if (y>y2) { //2番目より1番目のy座標が大きかったら入れ替え 
        cg = y; 
        y = y2; 
        y2 = y;
      }
      ellipse(x + vx + random(-20, 20), y + vy + random(-20, 20), w, h); //脛とか表示
    }
  }
}

void hantei(KJoint[] joints) {
  hit(joints, KinectPV2.JointType_Head);            //頭
  hit(joints, KinectPV2.JointType_ShoulderRight);   //右肩
  hit(joints, KinectPV2.JointType_ShoulderLeft);    //左肩
  hit(joints, KinectPV2.JointType_ElbowRight);      //右ひじ
  hit(joints, KinectPV2.JointType_ElbowLeft);       //右ひじ
  hit(joints, KinectPV2.JointType_HandRight);       //右手
  hit(joints, KinectPV2.JointType_HandLeft);        //左手
  hit(joints, KinectPV2.JointType_HipRight);        //右尻
  hit(joints, KinectPV2.JointType_HipLeft);         //右尻
  hit(joints, KinectPV2.JointType_KneeRight);       //右ひざ
  hit(joints, KinectPV2.JointType_KneeLeft);        //左ひざ
  hit(joints, KinectPV2.JointType_FootRight);       //だいだい右つま先
  hit(joints, KinectPV2.JointType_FootLeft);        //だいだい右つま先

  hit(joints, KinectPV2.JointType_SpineShoulder);   //両肩の真ん中
  hit(joints, KinectPV2.JointType_SpineMid);        //だいたい腹
  hit(joints, KinectPV2.JointType_SpineBase);       //腰

  hit2(joints, KinectPV2.JointType_HandLeft, KinectPV2.JointType_ElbowLeft);       //肘と手
  hit2(joints, KinectPV2.JointType_HandRight, KinectPV2.JointType_ElbowRight);     //肘と手
  hit2(joints, KinectPV2.JointType_KneeRight, KinectPV2.JointType_HipRight);       //尻とひざ
  hit2(joints, KinectPV2.JointType_KneeLeft, KinectPV2.JointType_HipLeft);         //尻とひざ
  hit2(joints, KinectPV2.JointType_AnkleRight, KinectPV2.JointType_KneeRight);     //足首と膝
  hit2(joints, KinectPV2.JointType_AnkleLeft, KinectPV2.JointType_KneeLeft);       //足首と膝
  hit2(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_SpineBase);  //肩と腹
}

void hit(KJoint[] joints, int jointType1) {
  float x = joints[jointType1].getX();   // x座標
  float y = joints[jointType1].getY() - 20;   // y座標

  if (gizax<x+10 && x<gizax+150 && gizay<y && y<gizay+150) {

    score -=20;
    gc = 0;
    if (houkou == 0) {
      gizay = 10;
      houkou = 1;
    } else { 
      gizax = 1880;
      houkou = 0;
    }
    if (tuyosa > -15) tuyosa -= 20;
    gs=0;
    bomb.play();  //再生
    bomb.rewind();  //再生が終わったら巻き戻しておく
  }
}

void hit2(KJoint[] joints, int jointType1, int jointType2) {
  float x1 = joints[jointType1].getX();   // x座標
  float y1 = joints[jointType1].getY() - 20;   // y座標
  float x2 = joints[jointType2].getX();   // x座標
  float y2 = joints[jointType2].getY() - 20;   // y座標

  if (x1<x2) x1 = x1 + ((x2 - x1) / 2);
  if (x2<x1) x1 = x2 + ((x1 - x2) / 2);
  if (y1<y2) y1 = y1 + ((y2 - y1) / 2);
  if (y2<y1) y1 = y2 + ((y1 - y2) / 2);

  if (gizax<x1+10 && x1<gizax+150 && gizay<y1 && y1<gizay+150) {
    score -=20;
    gc = 0;
    gizax = 1880;
    if (tuyosa > -15) tuyosa -= 20;
    gs=0;
    bomb.play();  //再生
    bomb.rewind();  //再生が終わったら巻き戻しておく
  }
}

void auradama() {
  bollsetup();

  if (a > 360) a=0;
  else a+=10;

  for (int i=0; i<=4; i++)  tama(i);
  if ((rec==1 || rec == 2) && bbtime[1] < bbtime[0]) {
    for (int i=0; i<=3; i++)  tama2(i);
  }

  for (int i=0; i<4; i++) {
    if (bolly[i] > 1000) {
      bolly[i] = 20;
      bc[i] = 0;
    } else {
      bolly[i] += otiru;
    }
  }

  if (rec ==1) {
    reaura();
    reatime.play();
    if (bolly[4] > 1000) {
      bollx[4] = random(250, 1670);
      bolly[4]=0;
    } else {
      bolly[4] += 10;
    }
  }
}

void bollsetup() {
  if ((rec==1 || rec == 2) && bbtime[1] < bbtime[0]) {
    //text("qqqqq",100,100); 
    reatime.pause();
    reatime.rewind();
    if (bc[0]==0) {
      bollx[0] = random(600, 700);
      bolly[0] = random(200, 800);
      bc[0]=1;
    }
    if (bc[1]==0) {
      bollx[1] = random(600, 700);
      bolly[1] = random(200, 800);
      bc[1]=1;
    }
    if (bc[2]==0) {
      bollx[2] = random(1200, 1300);
      bolly[2] = random(200, 800);
      bc[2]=1;
    }
    if (bc[3]==0) {
      bollx[3] = random(1200, 1300);
      bolly[3] = random(200, 800);
      bc[3]=1;
    }
    if (otiru != 0) otiru--;
  } else {
    if (bc[0]==0) {
      bollx[0] = random(250, 415);
      bc[0]=1;
    }
    if (bc[1]==0) {
      bollx[1] = random(555, 885);
      bc[1]=1;
    }
    if (bc[2]==0) {
      bollx[2] = random(1035, 1365);
      bc[2]=1;
    }
    if (bc[3]==0) {
      bollx[3] = random(1515, 1670);
      bc[3]=1;
    }
    if (bc[4]==0 && t <= 600) {
      bollx[4] = random(250, 1670);
      bc[4]=1;
      rec = 1;
    }
    if (otiru <= 5) otiru++;
  }
  if ( bbtime[1] < bbtime[0]) {
    bbtime[1]+=1;
  } else if (rec == 2)
    rec = 3;
}

void tama(int i) {
  int tmp = 0;
  if (yon[i]==0) fill(2, 83, 91);
  if (yon[i]==1) fill(243, 89, 60);
  if (yon[i]==2) fill(58, 76, 94);
  if (yon[i]==3) fill(143, 84, 48);
  if (check == 1) {
    tmp = yon[i];
    yon[i]=(int)random(0, 4);
    for (int h=0; h<=3; h++) {
      if (yon[h]==yon[i]&&i!=h) {
        yon[h] = tmp;
        check = 0;
      }
    }
  }

  if (i != 4)ellipse(bollx[i], bolly[i], random(130, 150), random(130, 150));
}

void tama2(int i) {
  if (yon[i]==0) fill(2, 83, 91);
  if (yon[i]==1) fill(243, 89, 60);
  if (yon[i]==2) fill(58, 76, 94);
  if (yon[i]==3) fill(143, 84, 48);
  ellipse(bollx[i], bolly[i], random(130, 150), random(130, 150));
}

void reaura() {
  blendMode(BLEND);
  noStroke();
  fill(a, 100, 100);
  if (c[4]==0)
    ellipse(bollx[4], bolly[4], random(200, 250), random(200, 250));
  blendMode(ADD);
}

void drawHandState(KJoint joint) {
  noStroke();
  handState(joint.getState());
}

void aurairo() {
  if (iro==0) {    
    hue=1;
    saturation=89;    
    brightness=90;
  }
  if (iro==1) {
    hue=217;
    saturation=85;
    brightness=61;
  }
  if (iro==2) {
    hue=57;
    saturation=90;
    brightness=97;
  }
  if (iro==3) {
    hue=141;
    saturation=83;   
    brightness=48;
  }
  if (iro==4) {
    hue=299;
    saturation=84;
    brightness=50;
  }
  if (iro==5) {
    hue=261;
    saturation=65;
    brightness=43;
  }
  if (iro==6) {
    hue=38;
    saturation=66;
    brightness=70;
  }
  if (iro==7) {
    hue=355;
    saturation=80;
    brightness=51;
  }
  if (iro==8) { 
    hue=196;
    saturation=80;   
    brightness=91;
  }
  if (iro==9) { 
    hue=179;
    saturation=39;   
    brightness=30;
  }
  if (iro==10) {  
    hue=145;
    saturation=63;   
    brightness=67;
  }
  if (iro==11) {   
    hue=62;
    saturation=40;
    brightness=43;
  }
  if (iro==12) {  
    hue=88;
    saturation=53;   
    brightness=40;
  }
  if (iro==13) {   
    hue=11;
    saturation=7;   
    brightness=24;
  }
}

 int tmp = 0;

void handState(int handState) {
  switch(handState) {
  case KinectPV2.HandState_Open:
   
    if (hd==0) {
      for (int i = 0; i<4; i++) {
        if (bollx[i]-75 < handR[0] && bollx[i]+75 > handR[0] && bolly[i]-75 < handR[1] && bolly[i]+75 > handR[1]) {
          ballck1[ yon[i] ]++;
          bc[i] = 0;
          if (tikan[0] != yon[i]) {
            tmp = tikan[0]; 
            tikan[0] = yon[i];
            for (int j=1; j<4; j++) {
              if (yon[i]==tikan[j]) {
                tikan[j] = tmp;
                break;
              } else {
                maetc = tmp;
                tmp = tikan[j];   
                tikan[j] = maetc;
              }
            }
          }
          orack();
          cc1 = 1;
          xx[i] = bollx[i];
          yy[i] = bolly[i];
          count[i]=1;
          bolly[i]=0;
          number = i;
          if (tuyosa<=140)   tuyosa+=10;
          score += 10;
          check = 1;
          if (yon[i]==0) {
            red.play();  //再生
            red.rewind();  //再生が終わったら巻き戻しておく
          }
          if (yon[i]==1) {
            blue.play();  //再生
            blue.rewind();  //再生が終わったら巻き戻しておく
          }
          if (yon[i]==2) {
            yellow.play();  //再生
            yellow.rewind();  //再生が終わったら巻き戻しておく
          }
          if (yon[i]==3) {
            green.play();  //再生
            green.rewind();  //再生が終わったら巻き戻しておく
          }
        }
      }
      if (bollx[4]-100 < handR[0] && bollx[4]+100 > handR[0] && bolly[4]-100 < handR[1] && bolly[4]+100 > handR[1] && rec == 1) {
        c[4] = 1;
        if (rec ==1) reahit = 1; //aa
        rec = 2;
        bbtime[0] = t;
        bbtime[1] = t-100;
      }
    } else if (hd==1) {
      for (int i = 0; i<4; i++) {
        if (bollx[i]-75 < handL[0] && bollx[i]+75 > handL[0] && bolly[i]-75 < handL[1] && bolly[i]+75 > handL[1]) {
          ballck1[ yon[i] ]++;
          bc[i] = 0;

          if (tikan[0] != yon[i]) {
            tmp = tikan[0]; 
            tikan[0] = yon[i];
            for (int j=1; j<4; j++) {
              if (yon[i]==tikan[j]) {
                tikan[j] = tmp;
                break;
              } else {
                maetc = tmp;
                tmp = tikan[j];   
                tikan[j] = maetc;
              }
            }
          }
          orack();
          cc1 = 1;
          xx[i] = bollx[i];
          yy[i] = bolly[i];
          count[i]=1;
          bolly[i] = 0;
          number = i;
          if (tuyosa<=140)     tuyosa+=10;
          score += 10;
          check = 1;
          if (yon[i]==0) {
            red.play();  //再生
            red.rewind();  //再生が終わったら巻き戻しておく
          }
          if (yon[i]==1) {
            blue.play();  //再生
            blue.rewind();  //再生が終わったら巻き戻しておく
          }
          if (yon[i]==2) {
            yellow.play();  //再生
            yellow.rewind();  //再生が終わったら巻き戻しておく
          }
          if (yon[i]==3) {
            green.play();  //再生
            green.rewind();  //再生が終わったら巻き戻しておく
          }
        }
      }
      if (bollx[4]-100 < handL[0] && bollx[4]+100 > handL[0] && bolly[4]-100 < handL[1] && bolly[4]+100 > handL[1] && rec == 1) {
        reaget.play();  //再生
        reaget.rewind(); 
        if (rec ==1) reahit = 1;  //aa
        c[4] = 1;
        rec = 2;
        bbtime[0] = t; //500
        bbtime[1] = t-100; //400
        reatime.pause();
        reatime.rewind();
      }
    }
    break;
  case KinectPV2.HandState_Closed:
   int tmp = 0;
    if (hd==0) {
      for (int i = 0; i<4; i++) {
        if (bollx[i]-75 < handR[0] && bollx[i]+75 > handR[0] && bolly[i]-75 < handR[1] && bolly[i]+75 > handR[1]) {
          ballck1[ yon[i] ]++;
          bc[i] = 0;
          if (tikan[0] != yon[i]) {
            tmp = tikan[0]; 
            tikan[0] = yon[i];
            for (int j=1; j<4; j++) {
              if (yon[i]==tikan[j]) {
                tikan[j] = tmp;
                break;
              } else {
                maetc = tmp;
                tmp = tikan[j];   
                tikan[j] = maetc;
              }
            }
          }
          orack();
          cc1 = 1;
          xx[i] = bollx[i];
          yy[i] = bolly[i];
          count[i]=1;
          bolly[i]=0;
          number = i;
          if (tuyosa<=140)   tuyosa+=10;
          score += 10;
          check = 1;
          if (yon[i]==0) {
            red.play();  //再生
            red.rewind();  //再生が終わったら巻き戻しておく
          }
          if (yon[i]==1) {
            blue.play();  //再生
            blue.rewind();  //再生が終わったら巻き戻しておく
          }
          if (yon[i]==2) {
            yellow.play();  //再生
            yellow.rewind();  //再生が終わったら巻き戻しておく
          }
          if (yon[i]==3) {
            green.play();  //再生
            green.rewind();  //再生が終わったら巻き戻しておく
          }
        }
      }
      if (bollx[4]-100 < handR[0] && bollx[4]+100 > handR[0] && bolly[4]-100 < handR[1] && bolly[4]+100 > handR[1] && rec == 1) {
        c[4] = 1;
        if (rec ==1) reahit = 1; //aa
        rec = 2;
        bbtime[0] = t;
        bbtime[1] = t-100;
      }
    } else if (hd==1) {
      for (int i = 0; i<4; i++) {
        if (bollx[i]-75 < handL[0] && bollx[i]+75 > handL[0] && bolly[i]-75 < handL[1] && bolly[i]+75 > handL[1]) {
          ballck1[ yon[i] ]++;
          bc[i] = 0;

          if (tikan[0] != yon[i]) {
            tmp = tikan[0]; 
            tikan[0] = yon[i];
            for (int j=1; j<4; j++) {
              if (yon[i]==tikan[j]) {
                tikan[j] = tmp;
                break;
              } else {
                maetc = tmp;
                tmp = tikan[j];   
                tikan[j] = maetc;
              }
            }
          }
          orack();
          cc1 = 1;
          xx[i] = bollx[i];
          yy[i] = bolly[i];
          count[i]=1;
          bolly[i] = 0;
          number = i;
          if (tuyosa<=140)     tuyosa+=10;
          score += 10;
          check = 1;
          if (yon[i]==0) {
            red.play();  //再生
            red.rewind();  //再生が終わったら巻き戻しておく
          }
          if (yon[i]==1) {
            blue.play();  //再生
            blue.rewind();  //再生が終わったら巻き戻しておく
          }
          if (yon[i]==2) {
            yellow.play();  //再生
            yellow.rewind();  //再生が終わったら巻き戻しておく
          }
          if (yon[i]==3) {
            green.play();  //再生
            green.rewind();  //再生が終わったら巻き戻しておく
          }
        }
      }
      if (bollx[4]-100 < handL[0] && bollx[4]+100 > handL[0] && bolly[4]-100 < handL[1] && bolly[4]+100 > handL[1] && rec == 1) {
        reaget.play();  //再生
        reaget.rewind(); 
        if (rec ==1) reahit = 1;  //aa
        c[4] = 1;
        rec = 2;
        bbtime[0] = t; //500
        bbtime[1] = t-100; //400
        reatime.pause();
        reatime.rewind();
      }
    }
    break;
  case KinectPV2.HandState_Lasso:
    break;
  case KinectPV2.HandState_NotTracked:
    break;
  }
}

void nuri() {
  if (number == 0 || count[0] == 1) {
    if (count[0] == 1) {
      if (c[number]==0) c[number]=1;
      if (aa[0]==0) fill(1, 89, 90);
      else if (aa[0]==1) fill(217, 85, 61);
      else if (aa[0]==2) fill(57, 90, 97);
      else if (aa[0]==3) fill(141, 83, 48);

      if (c[0] <= 15) {
        c[0]++;
        if (sabun0[0][0] == 0) {
          sabun0[0][0] = sabun0[0][1] = sabun0[0][2] = sabun0[0][3] = sabun0[0][4] = sabun0[0][5] = xx[number];
          sabun0[1][0] = sabun0[1][1] = sabun0[1][2] = sabun0[1][3] = sabun0[1][4] = sabun0[1][5] = yy[number];
        }
        for (int i=0; i<6; i++) {
          sabun0[0][i]+=sabun[0][i];        
          sabun0[1][i]+=sabun[1][i];
        }
        for (int j=0; j<6; j++) {
          ellipse(sabun0[0][j], sabun0[1][j], 40, 40);
        }
      } else {
        c[0]=0;
        for (int i=0; i<6; i++) {
          sabun0[0][i] = 0;        
          sabun0[1][i] = 0;
        }
        count[0] = 0;
      }
    }
  }
  if (number == 1 || count[1] == 1) {
    if (count[1] == 1) {
      if (c[number]==0) c[number]=1;
      if (aa[1]==0) fill(1, 89, 90);
      else if (aa[1]==1) fill(217, 85, 61);
      else if (aa[1]==2) fill(57, 90, 97);
      else if (aa[1]==3) fill(141, 83, 48);
      if (c[1] <= 15) {
        c[1]++;
        if (sabun1[0][0] == 0) {
          sabun1[0][0] = sabun1[0][1] = sabun1[0][2] = sabun1[0][3] = sabun1[0][4] = sabun1[0][5] = xx[number];
          sabun1[1][0] = sabun1[1][1] = sabun1[1][2] = sabun1[1][3] = sabun1[1][4] = sabun1[1][5] = yy[number];
        }
        for (int i=0; i<6; i++) {
          sabun1[0][i]+=sabun[0][i];
          sabun1[1][i]+=sabun[1][i];
        }
        for (int j=0; j<6; j++) {
          ellipse(sabun1[0][j], sabun1[1][j], 40, 40);
        }
      } else {
        c[1]=0;
        for (int i=0; i<6; i++) {
          sabun1[0][i] = 0;
          sabun1[1][i] = 0;
        }
        count[1] = 0;
      }
    }
  }

  if (number == 2 || count[2] == 1) {
    if (count[2] == 1) {
      if (c[number]==0) c[number]=1;
      if (aa[2]==0) fill(1, 89, 90);
      else if (aa[2]==1) fill(217, 85, 61);
      else if (aa[2]==2) fill(57, 90, 97);
      else if (aa[2]==3) fill(141, 83, 48);
      if (c[2] <= 15) {
        c[2]++;
        if (sabun2[0][0] == 0) {
          sabun2[0][0] = sabun2[0][1] = sabun2[0][2] = sabun2[0][3] = sabun2[0][4] = sabun2[0][5] = xx[number];
          sabun2[1][0] = sabun2[1][1] = sabun2[1][2] = sabun2[1][3] = sabun2[1][4] = sabun2[1][5] = yy[number];
        }
        for (int i=0; i<6; i++) {
          sabun2[0][i]+=sabun[0][i];
          sabun2[1][i]+=sabun[1][i];
        }
        for (int j=0; j<6; j++) {
          ellipse(sabun2[0][j], sabun2[1][j], 40, 40);
        }
      } else {
        c[2]=0;
        for (int i=0; i<6; i++) {
          sabun2[0][i] = 0;
          sabun2[1][i] = 0;
        }
        count[2] = 0;
      }
    }
  }
  if (number == 3 || count[3] == 1) {
    if (count[3] == 1) {
      if (c[number]==0) c[number]=1;
      if (aa[3]==0) fill(1, 89, 90);
      else if (aa[3]==1) fill(217, 85, 61);
      else if (aa[3]==2) fill(57, 90, 97);
      else if (aa[3]==3) fill(141, 83, 48);
      if (c[3] <= 15) {
        c[3]++;
        if (sabun3[0][0] == 0) {
          sabun3[0][0] = sabun3[0][1] = sabun3[0][2] = sabun3[0][3] = sabun3[0][4] = sabun3[0][5] = xx[number];
          sabun3[1][0] = sabun3[1][1] = sabun3[1][2] = sabun3[1][3] = sabun3[1][4] = sabun3[1][5] = yy[number];
        }
        for (int i=0; i<6; i++) {
          sabun3[0][i]+=sabun[0][i];
          sabun3[1][i]+=sabun[1][i];
        }
        for (int j=0; j<6; j++) {
          ellipse(sabun3[0][j], sabun3[1][j], 40, 40);
        }
      } else {
        c[3]=0;
        for (int i=0; i<6; i++) {
          sabun3[0][i] = 0;
          sabun3[1][i] = 0;
        }
        count[3] = 0;
      }
    }
  }

  //aa
  if (reahit == 1) {
    if (count2 <= 15) {
      count2++;
      if (sabun4[0][0] == 0) {
        sabun4[0][0] = sabun4[0][1] = sabun4[0][2] = sabun4[0][3] = sabun4[0][4] = sabun4[0][5] = bollx[4];
        sabun4[1][0] = sabun4[1][1] = sabun4[1][2] = sabun4[1][3] = sabun4[1][4] = sabun4[1][5] = bolly[4];
      }
      for (int i=0; i<6; i++) {
        sabun4[0][i]+=sabun[0][i];
        sabun4[1][i]+=sabun[1][i];
      }
      for (int j=0; j<6; j++) {
        ellipse(sabun4[0][j], sabun4[1][j], 70, 70);
      }
    } else {
      count2=0;
      for (int i=0; i<6; i++) {
        sabun4[0][i] = 0;
        sabun4[1][i] = 0;
      }
      reahit = 0;
      //count[3] = 0;
    }
  }//
}

void orack() {
  int  sec=0, j=0;

  if (cc1 == 0) first = tikan[0];

  for (int i=0; i<3; i++) {
    for (j=0; j<4; j++) {
      if (ballck1[i] < ballck1[j]) {
        saidai = ballck1[j];
      }
    }
  }
  j=0;

  if (ballck1[tikan[0]] == saidai && ballck1[tikan[1]] == 0 && ballck1[tikan[2]] == 0 && ballck1[tikan[3]] == 0) { //tikan[0] ga saidai
    aura2(first);
  } else {
    for (int i=0; i<4; i++) {
      if (saidai == ballck1[i]) {  //sadai kaburi hantei
        j++;
      }
    }

    if (j != 1) { //kaburi saidai
      if (j == 4) { //saidai ga 4
        iro = 13;
      } else if ( j == 2 || j == 3) { // saidai ga 2~3
        for (int i=0; i<4; i++) {
          if (ballck1[tikan[i]] == saidai) {
            if (first <= -1) {
              first = tikan[i];
            } else {
              second = tikan[i];
              break;
            }
          }
        }
      }
    } else { //saidai kaburi nashi
      for (int i=0; i<4; i++) {
        if (saidai != ballck1[tikan[i]]) {
          if (sec == 0) {
            sec = ballck1[tikan[i]];
            second = tikan[i];
          } else {
            if (sec < ballck1[tikan[i]]) {
              second = tikan[i];
              sec = ballck1[tikan[i]];
            }
          }
        }
      }
    }
  }
  if (second != 4)    aura(first, second);

  if (j == 4) iro = 13;
}

void aura(int saidai, int sec) {
  if ((saidai == 0 && sec == 1) || (saidai == 1 && sec == 0)) iro = 5;
  if ((saidai == 0 && sec == 2) || (saidai == 2 && sec == 0)) iro = 6;    
  if ((saidai == 0 && sec == 3) || (saidai == 3 && sec == 0)) iro = 7;
  if ((saidai == 1 && sec == 2) || (saidai == 2 && sec == 1)) iro = 8;    
  if ((saidai == 1 && sec == 3) || (saidai == 3 && sec == 1)) iro = 10;
  if ((saidai == 2 && sec == 3) || (saidai == 3 && sec == 2)) iro = 12;
}

void aura2(int first) {
  if (first == 0) iro = 0;
  if (first == 1) iro = 1;
  if (first == 2) iro = 2;
  if (first == 3) iro = 3;
}
