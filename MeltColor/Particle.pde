class Particle{
  PVector iPos;//512,424上の位置データ
  PVector pos;//マップ後の位置データ
  PVector vel;//マップ後の位置データに適用
  PVector acc;//マップ後の位置データに適用
  float velMax = 50;
  float accMax = 10;
  color col;//前回の色ログ(最後に書き換える)
  color particleCol;//描画の色(より明るい色になった時に更新する)
  float size;
  float sizeVel = 0;
  float sizeAcc = -1;
  float alph;
  
  int updatecount = 0;
  
  Particle(float x, float y, color c){
    iPos = new PVector(x,y);
    pos = new PVector();
    pos = mapPos(x,y);
    vel = new PVector(random(-50,50),random(-50,50));
    acc = new PVector(random(-3,3),random(-3,3));
    col = c;
  }
  
  void update(color c){
    //値のupdate処理
    if(brightness(c)>brightness(col)&&updatecount==0){
      //色
      particleCol = color(hue(c), map(saturation(c),0,100,15,100), map(brightness(c),0,100,30,100));
      alph = brightness(c);
      //サイズ
      size = 6; 
      sizeVel = map(brightness(c), 0, 100, 10, 8);
      //動き
      acc.x = random(-10,10);
      acc.y = random(-15,10);
      vel.x *= sizeVel/4;
      vel.y *= sizeVel/4;
      //カウント
      updatecount = (int)random(10, 20);
    }else{
      //動き
      acc.x = 0;
      acc.y = 0;
      //カウント
      if(updatecount>0)updatecount--;
    }
    
    //動き
    vel.add(acc);
    if(vel.x > 2 || -2 > vel.x){
      vel.x *= 0.9;
    }
    if(vel.y > 2 || -2 > vel.y){
      vel.y *= 0.9;
    }
    pos.add(vel);
    
    //サイズ
    sizeVel += sizeAcc;
    size += sizeVel;
    if(size > 60) {sizeAcc = -5;}
    else sizeAcc = -1;
    if(alph > 10) alph *= 0.98;
    
    //画面の端についたら反対端にループ
    boolean loop = false;
    if(pos.x<=0){pos.x=width-10;loop = true;}
    if(pos.x>=width){pos.x=10;loop = true;}
    if(pos.y<=0){pos.y=height-10;loop = true;}
    if(pos.y>=height){pos.y=10;loop = true;}
    if(loop){
      size = 5;
    }
    
    //描画
    if(size>5 && alph>10){
      noStroke();
      fill(particleCol, alph);
      ellipse(pos.x, pos.y, size, size);
    }else{
      //平常時にランダムで復活
      if(!foundUsers){
        alph = random(90);
        if(alph <= 89) alph=0;
      }else {
        alph = 0;
      }
      size = 6;
      sizeVel = random(8, 20);
      particleCol = color(random(0,360), random(50, 100), random(80, 100));
    }
    
    col = c;
    iPos = mapiPos(pos.x, pos.y);
  }
  
  PVector mapPos(float x, float y){
    x = map(x, 0, 512, 0, width);
    y = map(y, 0, 424, 0, height);
    PVector r = new PVector(x,y);
    return r;
  }
  
  PVector mapiPos(float x, float y){
    x = map(x, 0, width, 0, 512);
    y = map(y, 0, height, 0, 424);
    PVector r = new PVector(x,y);
    return r;
  }
}