class Building {
  int capacity,numpeople;
  PVector Pos;
  Boolean enterable;
  color Colour;
 
 Building(PVector p, int c,color col){
    this.Pos = p;
    this.capacity= c; 
    this.numpeople = 0;
    this.enterable = true;
    this.Colour = col;
  }
  
  void updateB(){
    if (this.capacity<=this.numpeople){
      this.enterable = false;
    } else {
      this.enterable = true;
    }
  }
}


class School extends Building{ 
  School(PVector p){
    super(p,int(random(100,200)),color(255,0,0));
  }
}

class Bank extends Building{ 
  Bank(PVector p){
    super(p,int(random(50,100)),color(0,255,0));
  }
}
