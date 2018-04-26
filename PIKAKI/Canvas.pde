class Canvas {
  PGraphics pg;
  ArrayList <Painter> painters = new ArrayList<Painter>();

  float penColor = 0;//色が自動で変わるようにする

  int picMode = 0;
  int picCount = 0;

  Canvas() {
    pg = createGraphics(width, height);

    pg.beginDraw();
    pg.background(0);
    pg.colorMode(HSB, 360, 255, 255);
    //pg.blendMode(ADD);
    pg.endDraw();
  }

  void peintersUpdate(ArrayList<Hands> handsArray) {
    for (int i = 0; i < handsArray.size(); i++) {
      if (painters.size() > i) {
        painters.get(i).update(handsArray.get(i));
      } else {
        Painter p = new Painter(handsArray.get(i));
        painters.add(p);
      }
    }

    for (Painter p : painters) {
      if (p.getHandState("r")==1) {
        drawing(p.getHandpos("prx"), p.getHandpos("pry"), p.getHandpos("rx"), p.getHandpos("ry"));
      }
      if (p.getHandState("l")==1) {
        drawing(p.getHandpos("plx"), p.getHandpos("ply"), p.getHandpos("lx"), p.getHandpos("ly"));
      }
    }
    penColor += 0.5;
    if (penColor >= 360)penColor -= 360;
  }

  void drawing(float px, float py, float x, float y) {
    pg.beginDraw();
    pg.stroke(penColor, 255, 255);
    pg.strokeWeight(20);
    pg.line(px, py, x, y);
    pg.endDraw();
    //pg.beginDraw();
    //pg.stroke(0, 255, 128);
    //for (int i = 10; i >= 1; i--) {
    //  pg.strokeWeight(i);
    //  pg.line(px, py, x, y);
    //}
    //pg.endDraw();
  }

  void draw() {
    noStroke();
    fill(0, 0, 0, 128);
    rect(0, 0, 300, height);
    rect(width, 0, -300, height);
    text(frameRate, 20, 20);

    fill(penColor, 255, 255, 128);
    rect(0, 0, 50, height);
    rect(width, 0, -50, height);
  }

  void savePic() {
    for (Painter p : painters) {
      if (p.getLassoNum() > 18 && picMode == 0) {
        picMode = 1;
        picCount = 89;
      }
    }
    switch(picMode) {
    case 1:
      textSize(250);
      textAlign(CENTER);
      fill(0,0,255);
      text(ceil(picCount/30)+1, width/2, height/2);
      picCount--;
      if(picCount <= 0){
        picMode = 2;
        picCount = 30;
      }
      break;
    case 2:
      save("picture/"+year()+""+nf(month(),2)+""+nf(day(),2)+"_"+nf(hour(),2)+""+nf(minute(),2)+""+nf(second(),2)+".png");
      picMode = 3;
      break;
    case 3:
      fill(0,0,255,255*(picCount/30));
      rect(0,0,width,height);
      picCount--;
      if(picCount <= 0){
        picMode = 4;
        picCount = 90;
      }
      break;
    case 4:
      picCount--;
      if(picCount <= 0){
        picMode = 0;
        picCount = 0;
      }
      break;
    } 
  }

  void reset() {
    pg.beginDraw();
    pg.background(0);
    pg.colorMode(HSB);
    //pg.blendMode(ADD);
    pg.endDraw();
  }
}