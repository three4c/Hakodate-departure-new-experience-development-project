import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import codeanticode.gsvideo.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class delay extends PApplet {



final int ParSplit = 5;
final int CamWid = 640;
final int CamHei = 480;
final int WindowW = CamWid;
final int WindowH = CamHei;

int mode = 1;
int i;

GSCapture cam;
//PImage[] img = new PImage[WindowH/ParSplit+1];
PImage[] imgcam = new PImage[WindowW/ParSplit+1];
PImage imgsum;

int count = 0;

public void setup(){
	/* \u753b\u9762\u30b5\u30a4\u30ba */
	frameRate(120);
	size(WindowW, WindowH);
	/* \u63a5\u7d9a\u3055\u308c\u3066\u3044\u308b\u5168\u3066\u306e\u30ab\u30e1\u30e9\u306e\u540d\u524d\u3092\u53d6\u5f97 */
	String[] cams = GSCapture.list();
	for (int i = 0; i < cams.length; ++i) {
		println(i+":"+cams[i]);
	}
	/* \u30ab\u30e1\u30e9\u306e\u30ad\u30e3\u30d7\u30c1\u30e3\u30fc */
	cam = new GSCapture(this, CamWid, CamHei, cams[0]);
	cam.start();
	imgsum = cam.get(0, 0, CamWid, CamHei);
	for (i = 0; i < imgcam.length; ++i) {
		//img[i] = cam.get(0, 0, 0, 0);
		imgcam[i] = cam.get(0, 0, 0, 0);
	}//\u30c0\u30df\u30fc\u306e\u521d\u671f\u30c7\u30fc\u30bf\u3092\u3068\u308a\u3042\u3048\u305a\u5165\u308c\u308b
}

public void draw(){
	/* \u30ab\u30e1\u30e9\u306e\u753b\u50cf\u3092\u53d6\u5f97 */
	if (cam.available()) cam.read();
	imgcam[count] = cam.get(0, 0, CamWid, CamHei);//\u6700\u65b0\u3092\u683c\u7d0d;
	delayMode(mode);
	image( imgsum, 0, 0);
	if(count == (imgcam.length-1)) count = 0;
	else count ++;
}

public void delayMode (int imode){
	switch (imode) {
		default :
		case 1:
			for (int j = count, k = 0; j != count+1 && k != imgcam.length; --j, ++k) {
				if(j == -1) j = imgcam.length -1;
					imgsum.set( 0, k*ParSplit, imgcam[j].get( 0, k*ParSplit, CamWid, ParSplit) );
			}
			break;
		case 2:
			for (int j = count, k = imgcam.length-1; j != count+1 && k != -1; --j, --k) {
				if(j == -1) j = imgcam.length -1;
					imgsum.set( 0, k*ParSplit, imgcam[j].get( 0, k*ParSplit, CamWid, ParSplit) );
			}
		break;
		case 3:
			for (int j = count, k = 0; j != count+1 && k != imgcam.length; --j, ++k) {
				if(j == -1) j = imgcam.length -1;
				imgsum.set( k*ParSplit, 0, imgcam[j].get( k*ParSplit, 0, ParSplit, CamHei) );
			}
		break;
		case 4:
			for (int j = count, k = imgcam.length-1; j != count+1 && k != -1; --j, --k) {
				if(j == -1) j = imgcam.length -1;
					imgsum.set( k*ParSplit, 0, imgcam[j].get( k*ParSplit, 0, ParSplit, CamHei) );
			}
		break;
		case 5 :
			if(count == (imgcam.length-1)) i = 0;
			else i = count+1;
			imgsum.set( 0, 0, imgcam[count].get( 0, 0, CamWid, CamHei/2) );
			imgsum.set( 0, CamHei/2, imgcam[i].get( 0, CamHei/2, CamWid, CamHei/2) );
		break;
	}
}

public void keyPressed() {
	if (key == CODED) {
		switch (keyCode) {
			case UP :
				if(mode == 1) mode = 5;
				else mode = 1;
			break;
			case DOWN :
				mode = 2;
			break;
			case RIGHT :
				mode = 3;
			break;
			case LEFT :
				mode = 4;
			break;
		}
	}
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "delay" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
