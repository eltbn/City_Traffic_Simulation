class Building { //
  int capacity,numpeople;
  float Size;
  PVector Pos;
  Boolean enterable;
  color Colour;
  
  
  char [] Entrance; // up to 4 points where traffic can enter a building, used in building creation
  Intersection [] entrancePoint;
 
 Building(PVector p, float s, int c, color col, char[] E){
    this.Pos = p;
    this.capacity= c; 
    this.numpeople = 0;
    this.enterable = true;
    this.Colour = col;
    this.Size = s;
    this.Entrance = E;
    entrancePoint = new Intersection[Entrance.length];
    placeEntrances();
   
  }
  
  void placeEntrances() {
    Intersection [] toPlace = new Intersection[Entrance.length]; // for potential optimization since adding the function also unnecessarily checks newly added intersections, also used to use Array iterating loops
    for (int i = 0; i < Entrance.length; i++) {
      switch (this.Entrance[i]) {
        case 'u':
          for (Intersection point : Intersections) {
            if (point != null) {
            if (point.Pos.x >= this.Pos.x && point.Pos.x <= this.Pos.x + this.Size && point.Pos.y <= this.Pos.y && abs(this.Pos.y-point.Pos.y) <= 50) { // check if intersection is above the building
              float pointX = point.Pos.x;
              println("building road up",pointX, this.Pos.y + this.Size/4);
              PVector intersectionPos = new PVector(pointX, this.Pos.y + this.Size/4);
              Intersection entIntersection = new Intersection(intersectionPos); // no need to call addLoneIntersection() since no checking for intersections can be safely skipped
              Road entRoad = new Road(intersectionPos, point.Pos, 1, 1);
              println("building road down, building:", entRoad.startPoint, entRoad.endPoint);
              toPlace[i] = entIntersection;
              Roads.add(entRoad);
              break; 
            }
            }
          }
        break;
        case 'd':
          for (Intersection point : Intersections) {
            if (point != null){
            if (point.Pos.x >= this.Pos.x && point.Pos.x <= this.Pos.x + this.Size && point.Pos.y >= this.Pos.y) { // check if intersection is below the building
              float pointX = point.Pos.x;
              PVector intersectionPos = new PVector(pointX, this.Pos.y + this.Size/4);
              Intersection entIntersection = new Intersection(intersectionPos);
              Road entRoad = new Road(intersectionPos, point.Pos, 1, 1);
              println("building road down, building:", entRoad.startPoint, entRoad.endPoint);
              toPlace[i] = entIntersection;
              Roads.add(entRoad);
              break; 
            }
            }
          }
        break;
        case 'l':
          for (Intersection point : Intersections) {
            if (point != null) {
            if (point.Pos.y >= this.Pos.y && point.Pos.y <= this.Pos.y + this.Size && point.Pos.x <= this.Pos.x) { // check if intersection is above the building
              float pointY = point.Pos.y;
              PVector intersectionPos = new PVector(this.Pos.x + this.Size/4, pointY);
              Intersection entIntersection = new Intersection(intersectionPos);
              Road entRoad = new Road(intersectionPos, point.Pos, 1, 1);
              println("building road left, building:", entRoad.startPoint, entRoad.endPoint);
              toPlace[i] = entIntersection;
              Roads.add(entRoad);
              break; 
            }
            }
          }
        break;
        case'r':
          for (Intersection point : Intersections) {
            if (point != null) {
            if (point.Pos.y >= this.Pos.y && point.Pos.y <= this.Pos.y + this.Size && point.Pos.x >= this.Pos.x) { // check if intersection is above the building
              float pointY = point.Pos.y;
              PVector intersectionPos = new PVector(this.Pos.x + this.Size/4, pointY);
              Intersection entIntersection = new Intersection(intersectionPos);
              Road entRoad = new Road(intersectionPos, point.Pos, 1, 1);
              println("building road right, building:", entRoad.startPoint, entRoad.endPoint);
              toPlace[i] = entIntersection;
              Roads.add(entRoad);
              break; 
            }
            }
          }
      }
    }
    for (int i = 0; i < toPlace.length; i++) {
      Intersections.add(toPlace[i]);
      entrancePoint[i] = toPlace[i];
    }
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
  School(PVector p, float s, char[] E){
    super(p,s, int(random(100,200)),color(255,0,0), E);
  }
}

class Bank extends Building{ 
  Bank(PVector p, float s, char[] E){
    super(p, s,int(random(50,100)),color(0,255,0), E);
  }  
}

class House extends Building{ 
  House(PVector p, float s, char[] E){
    super(p,s,int(random(50,100)),color(0,100,100), E);
  }  
}
