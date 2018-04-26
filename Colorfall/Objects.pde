class Objects {  //Objectsクラスは現状は非常に簡潔な内容です。そんなに説明はいらないと思います。
  //変数
  PImage img;
  float either;  //これを追加した
  int x;
  int y;
  int yspeed;
  int Color;
  
  //演算用の変数
  int tempx, tempy;
  int r = 18;
  int center = 75;
  int correction = 35;
  
  //コンストラクタ
  Objects(PImage _img, 
          float _either,
          int _x, 
          int _y, 
          int _yspeed, 
          int _Color) {
    img = _img;
    either = _either;
    x = _x;
    y = _y;
    yspeed = _yspeed;
    Color = _Color;
  }
  
  void draw() {
    pushMatrix();
    scale(2);    //1.81倍ではなく2倍にするとちょうどいい感じの当たり判定に引き延ばせる（？）
    int imX = 72;
    int imY = 72;
    img.resize(imX, imY);
    image(img, x, y);  //ここで画像を描画します。
    y += yspeed;     //画像のｙ座標をyspeedぶんずらします。ようするに移動させています。
    popMatrix();
  }
  
  boolean checkHit(float px, float py) {
    boolean isHit;
    coordinateCorrection();
    if(either > 0.5) isHit = checkHitR(px, py);
    else isHit = chechHitE(px, py);
    return isHit;
  }
  
  boolean checkHitR(float px, float py) {
    if(tempx+5 < px && (tempx+correction-5) > px &&    //変更箇所
       tempy+5 < py && (tempy+correction-5) > py ) {    //変更箇所
         return true;
       } else {
         return false;
       }
  }
  
  boolean chechHitE(float px, float py) {
    if( ((tempx-px)*(tempx-px) + (tempy-py)*(tempy-py)) < r*r-5 ) {    //変更箇所
      return true;
    } else {
      return false;
    }
  }
  
  void coordinateCorrection() {
    if(either > 0.5) {
      tempx = x + center - r;
      tempy = y + center - r;
    }
    else {
      tempx = x + center;
      tempy = y + center;
    }
  }
}