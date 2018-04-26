class Painter{
  ArrayList <Hands> handsPast = new ArrayList<Hands>();//最後の要素が最新の値
  Painter(Hands h){
    for(int i = 0; i < 20; i++){
      handsPast.add(h);
    }
  }
  
  void update(Hands h){
    handsPast.add(h);
    handsPast.remove(0);
  }
  
  float getHandpos(String s){
    switch(s){
      case "rx":
      return handsPast.get(handsPast.size()-1).rx;
      case "ry":
      return handsPast.get(handsPast.size()-1).ry;
      case "rz":
      return handsPast.get(handsPast.size()-1).rz;
      case "lx":
      return handsPast.get(handsPast.size()-1).lx;
      case "ly":
      return handsPast.get(handsPast.size()-1).ly;
      case "lz":
      return handsPast.get(handsPast.size()-1).lz;
      case "headx":
      return handsPast.get(handsPast.size()-1).headx;
      case "heady":
      return handsPast.get(handsPast.size()-1).heady;
      case "prx":
      return handsPast.get(handsPast.size()-2).rx;
      case "pry":
      return handsPast.get(handsPast.size()-2).ry;
      case "prz":
      return handsPast.get(handsPast.size()-2).rz;
      case "plx":
      return handsPast.get(handsPast.size()-2).lx;
      case "ply":
      return handsPast.get(handsPast.size()-2).ly;
      case "plz":
      return handsPast.get(handsPast.size()-2).lz;
    }
    return -1;
  }
  
  int getLassoNum(){
    int numr = 0;
    int numl = 0;
    for(Hands h: handsPast){
      if(h.rState==3)numr++;
      if(h.lState==3)numl++;
    }
    return numr > numl ? numr : numl;
  }
  
  int getHandState(String s){
    switch(s){
      case "r":
      return handsPast.get(handsPast.size()-1).rState;
      case "l":
      return handsPast.get(handsPast.size()-1).lState;
    }
    //int state[] = {0, 0, 0, 0};
    //switch(s){
    //  case "r":
    //  for(int i = 0; i < 3; i++){
    //    state[handsPast.get(handsPast.size()-1-i).rState]++;
    //  }
    //  case "l":
    //  for(int i = 0; i < 3; i++){
    //    state[handsPast.get(handsPast.size()-1-i).lState]++;
    //  }
    //}
    //for(int i = 0; i < 4; i++){
    //  if(state[i]>2){
    //    return i;
    //  }
    //}
    return 0;
  }
}