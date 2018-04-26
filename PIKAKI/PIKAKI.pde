import KinectPV2.KJoint;
import KinectPV2.*;

KinectPV2 kinect;

Canvas c;

void setup() {
  fullScreen();

  kinect = new KinectPV2(this);

  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);

  kinect.init();

  c = new Canvas();
  
  colorMode(HSB,360,255,255);
}

void draw() {
  if(c.picMode==0 || c.picMode>=3){//写真撮影中は書けないようにする
    c.peintersUpdate(kinectUpdate());
  }
  //Kinectのカメラからの映像
  blendMode(BLEND);
  image(kinect.getColorImage(), 0, 0, width, height);
  //眩しい時は画面全体に黒色を掛ける
  fill(0,0,0,80);
  rect(0, 0, width, height);
  //キャンバスの描画(加算)
  blendMode(ADD);
  image(c.pg, 0, 0);
  //UI系統の描画
  blendMode(BLEND);
  c.draw();
  c.savePic();
}

ArrayList<Hands> kinectUpdate() {
  ArrayList<Hands> handsArray = new ArrayList<Hands>();
  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();
  
  //individual JOINTS
  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();

      Hands h = new Hands();
      h.id = i;
      h.rx = joints[KinectPV2.JointType_HandRight].getX();
      h.ry = joints[KinectPV2.JointType_HandRight].getY();
      h.rz = joints[KinectPV2.JointType_HandRight].getZ();
      h.rState = handState(joints[KinectPV2.JointType_HandRight].getState());
      h.lx = joints[KinectPV2.JointType_HandLeft].getX();
      h.ly = joints[KinectPV2.JointType_HandLeft].getY();
      h.lz = joints[KinectPV2.JointType_HandLeft].getZ();
      h.lState = handState(joints[KinectPV2.JointType_HandLeft].getState());
      h.headx = joints[KinectPV2.JointType_Head].getX();
      h.heady = joints[KinectPV2.JointType_Head].getY();
      
      handsArray.add(h);
    }
  }
  return handsArray;
}

int handState(int handState) {
  switch(handState) {
  case KinectPV2.HandState_Open:
    return 1;
  case KinectPV2.HandState_Closed:
    return 2;
  case KinectPV2.HandState_Lasso:
    return 3;
  case KinectPV2.HandState_NotTracked:
    return 0;
  }
  return 0;
}

void keyPressed(){
  if(key == ' '){
    c.reset();
  }
}