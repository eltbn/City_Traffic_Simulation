class Building { //
  int capacity,numpeople;
  PVector Pos;
  Boolean enterable;
  color Colour;
  
  int [] Entrances;
  
 char [] Entrance; // up to 4 points where traffic can enter a building
 
 Building(PVector p, int c, color col){
    this.Pos = p;
    this.capacity= c; 
    this.numpeople = 0;
    this.enterable = true;
    this.Colour = col;
   // this.Entrances = E;
  }
  
  //void placeEntrances() {
  //  for (int i = 0; i < Entrances.length; i++) {
  //    switch (this.Entrance[i]) {
  //      case 'u':
  //        for (Intersection point
          
        
        
  //    }
  //  }
    
    
    
  }
  
  
  void updateB(){
    if (this.capacity<=this.numpeople){
      this.enterable = false;
    } else {
      this.enterable = true;
    }
  }
  
  
  void drawBuilding(){
    fill(this.Colour);
    rect(this.Pos.x,this.Pos.y, 100, 100);
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
  School(PVector p){
    super(p,int(random(100,200)),color(255,0,0));
  }
}

class Bank extends Building{ 
  Bank(PVector p){
    super(p,int(random(50,100)),color(0,255,0));
  }  
}

class House extends Building{ 
  House(PVector p){
    super(p,int(random(50,100)),color(0,100,100));
  }  
}
