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
    entrancePoint = new Intersection[Entrance.length]; //
    placeEntrances();
   
  }
  
  void placeEntrances() { // based on the entrancePoint array which contains characters for the cardinal direction of the entrance
    Intersection [] toPlace = new Intersection[Entrance.length]; // for potential optimization since adding the function also unnecessarily checks newly added intersections
    for (int i = 0; i < Entrance.length; i++) {
      switch (this.Entrance[i]) { // the cases are similar and only differ with the conditional
        case 'u':
          for (Intersection point : Intersections) {
            if (point != null) {
            if (point.Pos.x >= this.Pos.x && point.Pos.x <= this.Pos.x + this.Size && point.Pos.y <= this.Pos.y && abs(this.Pos.y - point.Pos.y) <= 50) { // check if intersection is above the building
              float pointX = point.Pos.x;
              PVector intersectionPos = new PVector(pointX, this.Pos.y + this.Size/3); // make the entrance more closer to the sides of the building
              Intersection entIntersection = new Intersection(intersectionPos);
              Road entRoad = new Road(intersectionPos, point.Pos, 1);
              
              entIntersection.Connected.add(entRoad);
              toPlace[i] = entIntersection; // queue the intersection into this list so that they can all be added at once
              Roads.add(entRoad);
              break; 
            }
            }
          }
        break;
        case 'd':
          for (Intersection point : Intersections) {
            if (point != null){
            if (point.Pos.x >= this.Pos.x && point.Pos.x <= this.Pos.x + this.Size && point.Pos.y >= this.Pos.y && abs(this.Pos.y + this.Size - point.Pos.y) <= 50) { // check if intersection is below the building
              float pointX = point.Pos.x;
              PVector intersectionPos = new PVector(pointX, this.Pos.y + this.Size/3*2);
              Intersection entIntersection = new Intersection(intersectionPos);
              Road entRoad = new Road(intersectionPos, point.Pos, 1);
              
              entIntersection.Connected.add(entRoad);
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
            if (point.Pos.y >= this.Pos.y && point.Pos.y <= this.Pos.y + this.Size && point.Pos.x <= this.Pos.x && abs(this.Pos.x - point.Pos.x) <= 50) { // check if intersection is above the building
              float pointY = point.Pos.y;
              PVector intersectionPos = new PVector(this.Pos.x + this.Size/3, pointY);
              Intersection entIntersection = new Intersection(intersectionPos);
              Road entRoad = new Road(intersectionPos, point.Pos, 1);
              
              entIntersection.Connected.add(entRoad);
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
            if (point.Pos.y >= this.Pos.y && point.Pos.y <= this.Pos.y + this.Size && point.Pos.x >= this.Pos.x && abs(this.Pos.y - point.Pos.y) <= 50) { // check if intersection is above the building
              float pointY = point.Pos.y;
              PVector intersectionPos = new PVector(this.Pos.x + this.Size/3, pointY);
              Intersection entIntersection = new Intersection(intersectionPos);
              Road entRoad = new Road(intersectionPos, point.Pos, 1);
              
              entIntersection.Connected.add(entRoad);
              toPlace[i] = entIntersection;
              Roads.add(entRoad);
              break; 
            }
            }
          }
      }
    }
    for (int i = 0; i < toPlace.length; i++) { // add the entrances to the intersection
      Intersections.add(toPlace[i]);
      entrancePoint[i] = toPlace[i];
    }
  }
  
  
  void drawBuilding(){
    fill(this.Colour);
    rect(this.Pos.x,this.Pos.y, Size, Size);
  }
  

}

class School extends Building { 
  School(PVector p, float s, char[] E) {
    super(p,s, int(random(100,200)),color(255,0,0), E);
  }
}

class Bank extends Building { 
  Bank(PVector p, float s, char[] E) {
    super(p, s,int(random(50,100)),color(0,255,0), E);
  }  
}

class Mart extends Building { 
  Mart(PVector p, float s, char[] E) {
    super(p, s,int(random(50,100)),color(50,100,20), E);
  }  
}


class Park extends Building { 
  Park(PVector p, float s, char[] E) {
    super(p, s,int(random(50,100)),color(50,100,20), E);
  }  
}


class House extends Building { 
  House(PVector p, float s, char[] E) {
    super(p,s,int(random(50,100)),color(0,100,100), E);
  }  
}
