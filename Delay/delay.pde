import codeanticode.gsvideo.*;

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

void setup(){
	/* 画面サイズ */
	frameRate(120);
	size(WindowW, WindowH);
	/* 接続されている全てのカメラの名前を取得 */
	String[] cams = GSCapture.list();
	for (int i = 0; i < cams.length; ++i) {
		println(i+":"+cams[i]);
	}
	/* カメラのキャプチャー */
	cam = new GSCapture(this, CamWid, CamHei, cams[0]);
	cam.start();
	imgsum = cam.get(0, 0, CamWid, CamHei);
	for (i = 0; i < imgcam.length; ++i) {
		//img[i] = cam.get(0, 0, 0, 0);
		imgcam[i] = cam.get(0, 0, 0, 0);
	}//ダミーの初期データをとりあえず入れる
}

void draw(){
	/* カメラの画像を取得 */
	if (cam.available()) cam.read();
	imgcam[count] = cam.get(0, 0, CamWid, CamHei);//最新を格納;
	delayMode(mode);
	image( imgsum, 0, 0);
	if(count == (imgcam.length-1)) count = 0;
	else count ++;
}

void delayMode (int imode){
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

void keyPressed() {
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