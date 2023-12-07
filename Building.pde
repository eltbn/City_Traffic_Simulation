class Building { //
  int capacity,numpeople;
  float Size;
  PVector Pos;
  Boolean enterable;
  color Colour;
  
  int [] Entrances;
  
 char [] Entrance; // up to 4 points where traffic can enter a building
 
 Building(PVector p, float s, int c, color col){
    this.Pos = p;
    this.capacity= c; 
    this.numpeople = 0;
    this.enterable = true;
    this.Colour = col;
    this.Size = s;
   // this.Entrances = E;
  }
  
  //void placeEntrances() {
  //  for (int i = 0; i < Entrances.length; i++) {
  //    switch (this.Entrance[i]) {
  //      case 'u':
  //        for (Intersection point : Intersections); {
  //          if (this.Pos.x <= point.Pos.x) {
              
  //          }
        
  //        }
  //    }
  //  }
  //}
  
  
  
  void updateB(){
    if (this.capacity<=this.numpeople){
      this.enterable = false;
    } else {
      this.enterable = true;
    }
  }
  
  
  void drawBuilding(){
    fill(this.Colour);
    rect(this.Pos.x,this.Pos.y, Size, Size);
  }
  
  
  
  
  void spawnTraffic() {
    
    Building Destination = Buildings.get(int(random(0, Buildings.size()-1)));
    while (Destination != this) { // while the random destination is not this building
      Destination = Buildings.get(int(random(0, Buildings.size()-1)));
    }
    Traffic newTraffic = new Traffic(new PVector(-10, 205), 2);
    
  }

}

class School extends Building{ 
  School(PVector p, float s){
    super(p,s, int(random(100,200)),color(255,0,0));
  }
}

class Bank extends Building{ 
  Bank(PVector p, float s){
    super(p, s,int(random(50,100)),color(0,255,0));
  }  
}

class House extends Building{ 
  House(PVector p, float s){
    super(p,s,int(random(50,100)),color(0,100,100));
  }  
}
