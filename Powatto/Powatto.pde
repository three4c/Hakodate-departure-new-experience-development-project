//KinectPV2
import KinectPV2.KJoint;
import KinectPV2.*;
KinectPV2 kinect;

import ddf.minim.*;

Minim minim;
AudioSample kick1, kick2;

import processing.sound.*;
SoundFile touch;

PImage img;

//one hand
float rh1x=0;
float lh1x=0; 
float rh1y=0;
float lh1y=0;

//two hand
float rh2x=0;
float lh2x=0;
float rh2y=0;
float lh2y=0;

//one head
float h1x=0;
float h1y=0;

float chx =0;
float chy=0;
//two head
float h2x=0;
float h2y=0;

// GLOBALS
float MAX_PARTICLES = 120;
//color[] COLORS = {color(249, 212, 35), color(250, 105, 0), color(167, 219, 216), color(243, 134, 48),color(255, 78, 80), color(105, 210, 231), color(224, 228, 192)};
//color[] COLORS = {color(255, 255, 0), color(0, 255, 0), color(255, 0, 0),  color(0, 0, 255), color(255, 0, 255), color(0, 255, 255), color(255, 255, 255)};
color[] COLORS_BODY = {color(255, 255, 0), color(0, 255, 0), color(255, 0, 0), color(100, 100, 255)};
color[] COLORS = {color(255, 255, 0, 90), color(0, 255, 0, 90), color(255, 0, 0, 80), color(0, 0, 255, 90)};
//ARRAYS
ArrayList<Particle>particles = new ArrayList<Particle>();
ArrayList<Particle>pool_p = new ArrayList<Particle>();

//floatIABLES
float distR1R2 = 300;
float distR1L2 = 300;
float distL1R2 = 300;
float distL1L2 = 300;

float distR1R2map;
float distR1L2map;
float distL1R2map;
float distL1L2map;

ArrayList<Integer> seqActives = new ArrayList<Integer>();
ArrayList<KSkeleton> skeletonArray;

int disableCount1 = 0;
int disableCount2 = 0;

int state = 0;
int colState=0;
int stateCount = 50;

int cameraZ =1;


void spawn(float x, float y, float resize) {
  if ( particles.size() >= MAX_PARTICLES ) {
    pool_p.add( 0, particles.remove(0) );
  }
  float size1 = 5; 
  float size2 = 80;
  Particle particle = new Particle(x, y, random(size1, size2+resize));

  particles.add( particle );
}


void moved(float x, float y, float size) {
  float max = random( 1, 4 );
  for ( int i = 0; i < max; i++ ) {
    spawn( x, y, size );
  }
}


void update() {
  Particle particle;
  for (int i=particles.size()-1; i>=0; i--) {
    particle = particles.get(i);
    if (particle.alive == true) {
      particle.move();
    } else {
      pool_p.add(particles.get(int(particles.get(i).alive)));
    }
  }
}    

void ripple(int x, int y) {
  int dia=0;
  fill(0);
  noFill();
  stroke(COLORS[colState]);
  while (dia<1000) {
    ellipse(x, y, dia, dia);
    dia++;
  }
}


void setup() {
  size(displayWidth, displayHeight, P3D);
  kinect = new KinectPV2(this);
  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);

  kinect.enableBodyTrackImg(true);
  kinect.enableDepthMaskImg(true);

  kinect.init();
  background(0);

  minim = new Minim(this);
    kick1 = minim.loadSample("bubble-burst1.mp3");
  kick2 = minim.loadSample("bubble-burst1.mp3");
  touch = new SoundFile(this, "decision3.mp3");

  //kick1 = minim.loadSample("pawawa.mp3");
  //kick2 = minim.loadSample("pawawa.mp3");
  //touch = new SoundFile(this, "haretsu.mp3");

  ellipseMode(CENTER);

  int seqSize = 10;
  for (int i=0; i<seqSize; i++) seqActives.add(0);

  noCursor();
}

void draw() {
  camera(width/2, height/2, 800*cameraZ, width/2, height/2, 0, 0, 1, 0);
  update();
  skeletonArray.clear();
  skeletonArray =  kinect.getSkeletonColorMap();
  //blendMode(BLEND);
  background(0);
  //image(kinect.getColorImage(), 0, 0, width, height);
  blendMode(ADD);
  for (int j = particles.size() - 1; j >= 0; j--) {
    particles.get(j).show();
  }

  float diffHandRight1 = 0;
  float diffHandLeft1 = 0;
  float diffHandRight2 = 0;
  float diffHandLeft2 = 0;

  boolean tmpActive1 = false;
  boolean tmpActive2 = false;

  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();
      if (skeletonArray.size()==1) {
        distR1R2map = 100;
        distL1L2map = 100;
        colState = 0;
      }

      color colSke  = COLORS_BODY[colState];
      
      

      //draw different color for each hand state
      drawHandState(joints[KinectPV2.JointType_HandRight]);
      drawHandState(joints[KinectPV2.JointType_HandLeft]);


      if (i == 0) {
        switch(state) {
        case 0:
          diffHandRight1 = dist(rh1x, rh1y, joints[KinectPV2.JointType_HandRight].getX(), joints[KinectPV2.JointType_HandRight].getY());
          diffHandLeft1 = dist(lh1x, lh1y, joints[KinectPV2.JointType_HandLeft].getX(), joints[KinectPV2.JointType_HandLeft].getY());

          if (diffHandRight1 > 30) {
            moved(rh1x, rh1y, distR1R2map);
            tmpActive1 = true;
          }
          if (diffHandLeft1 > 30) {
            moved(lh1x, lh1y, distL1L2map);
            tmpActive1 = true;
          }
        }
        rh1x = joints[KinectPV2.JointType_HandRight].getX();
        lh1x = joints[KinectPV2.JointType_HandLeft].getX();
        rh1y = joints[KinectPV2.JointType_HandRight].getY();
        lh1y = joints[KinectPV2.JointType_HandLeft].getY();
        h1x = joints[KinectPV2.JointType_Head].getX();
        h1y = joints[KinectPV2.JointType_Head].getY();
      }



      if (i == 1) {
        switch(state) {
        case 0:

          diffHandRight2 = dist(rh2x, rh2y, joints[KinectPV2.JointType_HandRight].getX(), joints[KinectPV2.JointType_HandRight].getY());
          diffHandLeft2 = dist(lh2x, lh2y, joints[KinectPV2.JointType_HandLeft].getX(), joints[KinectPV2.JointType_HandLeft].getY());

          if (distR1L2map > distR1R2map && distL1R2map > distL1L2map) {
            if (diffHandRight2 > 15) {
              moved(rh2x, rh2y, distR1R2map);
              tmpActive2 = true;
            }
            if (diffHandLeft2 > 15) {
              moved(lh2x, lh2y, distL1L2map);
              tmpActive2 = true;
            }
          } else {
            if (diffHandRight2 > 15) {
              moved(rh2x, rh2y, distL1R2map);
              tmpActive2 = true;
            }
            if (diffHandLeft2 > 15) {
              moved(lh2x, lh2y, distR1L2map);
              tmpActive2 = true;
            }
          }

          if (distR1R2 < 70 || distL1L2 < 70 || distL1R2 < 70 || distR1L2 < 70) {
            float min = min(min(distR1R2, distL1L2),min(distL1R2, distR1L2));
            if(min == distR1R2 || min == distR1L2){
             chx = rh1x;
             chy = rh1y;
            }else{
             chx = lh1x;
             chy = lh1y;
            }
            
            state = 1;
          }
          break;

        case 1:
          touch.play();
          cameraZ = cameraZ * -1;
          println("aaa");
          if (colState < 3) {
            colState++;
          } else {
            colState = 0;
          }
          stateCount = 100;

          state = 2;
          break;

        case 2:
          //stroke(COLORS[colState]);
          //strokeWeight(100);
          //noFill();
          //rect(0,0,width,height);
          fill(colSke);
          stroke(colSke);
          stopAction(stateCount);
          stateCount--;
          //camera(chx, chy, -100, width/2, height/2, 0, 0, 1, 0);
          if (stateCount == 0) {
            state = 0;
            break;
          }
        }

        rh2x = joints[KinectPV2.JointType_HandRight].getX();
        lh2x = joints[KinectPV2.JointType_HandLeft].getX();
        rh2y = joints[KinectPV2.JointType_HandRight].getY();
        lh2y = joints[KinectPV2.JointType_HandLeft].getY();
        h2x = joints[KinectPV2.JointType_Head].getX();
        h2y = joints[KinectPV2.JointType_Head].getY();

        distR1R2 = dist(rh1x, rh1y, rh2x, rh2y);
        distR1L2 = dist(rh1x, rh1y, lh2x, lh2y);
        distL1R2 = dist(lh1x, lh1y, rh2x, rh2y);
        distL1L2 = dist(lh1x, lh1y, lh2x, lh2y);

        distR1R2map = map(dist(rh1x, rh1y, rh2x, rh2y), 0, 1000, 500, 0);
        distR1L2map = map(dist(rh1x, rh1y, lh2x, lh2y), 0, 1000, 500, 0);
        distL1R2map = map(dist(lh1x, lh1y, rh2x, rh2y), 0, 1000, 500, 0);
        distL1L2map = map(dist(lh1x, lh1y, lh2x, lh2y), 0, 1000, 500, 0);

        float distMin = min(min(distR1R2, distR1L2), min(distL1R2, distL1L2));
        float distMinMap = map(distMin, 0, 2000, +20, -100);

        kick1.setGain(distMinMap);
        kick2.setGain(distMinMap);

        println("R1R2, " + int(distR1R2) + "  L1L2, " + int(distL1L2) + "  L1R2, " + int(distL1R2) + "  R1L2, " + int(distR1L2));
      }
      fill(colSke);
      stroke(colSke);
      drawBody(joints);
    }
  }


  switch(state) {

  case 0:
    if (tmpActive1) {
      if (disableCount1 == 0) {
        kick1.trigger();
        if (constrain(diffHandRight1, 0, 80) > constrain(diffHandLeft1, 0, 80)) {
          disableCount1 = int(map(constrain(diffHandRight1, 0, 70), 0, 80, 10, 2));
        } else {
          disableCount1 = int(map(constrain(diffHandLeft1, 0, 70), 0, 80, 10, 2));
        }
        //println(disableCount1);
      }
    }

    if (disableCount1 > 0) {
      disableCount1--;
    }

    if (tmpActive2) {
      if (disableCount2 == 0) {
        kick2.trigger();
        if (constrain(diffHandRight2, 0, 80) > constrain(diffHandLeft2, 0, 80)) {
          disableCount2 = int(map(constrain(diffHandRight2, 0, 70), 0, 80, 10, 2));
        } else {
          disableCount2 = int(map(constrain(diffHandLeft2, 0, 70), 0, 80, 10, 2));
        }
        //println(disableCount2);
      }

      if (disableCount2 > 0) {
        disableCount2--;
      }

    }
  }


  //scale(1, -1);
  //rotateX(PI);
  //rotateY(PI);

  

  //image = kinect.getColorImage();
  //image.filter(THRESHOLD);
  //image(displayWidth, displayHeight);
}