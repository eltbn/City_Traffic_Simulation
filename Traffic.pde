class Traffic {
  PVector Pos, Direction = new PVector(1,0);
  float Speed;
  
  Road inRoad;
  ArrayList <Intersection> Path = new ArrayList <Intersection>();
  
  
  
  Traffic(float x, float y, float s) {
    this.Pos = new PVector(x, y);
    this.Speed = s;
    this.Direction = new PVector(1,0);
  }
  
   Traffic(PVector p, float s) {
    this.Pos = p;
    this.Speed = s;
  }
  
  void moveTraffic() {
    this.Pos.add(Direction.mult(speedUpFactor));
    
    
    
    //distToNext(direction);
  }
  
  //float distToNext(char d) {
  //  switch(d) {
      
      
      
      
  //  }
  //}  
    
  
  
  
  void determineDirection(PVector p1, PVector p2) {
    Direction = new PVector(p2.x - p1.x, p1.y - p2.y);
    
  }
  
  void findRoad() {
    float closest = 0; // incomplete; for checking people in road
    int index = 0;
    for (Road road : Roads) { // using generic for loop so that an index number (i) can be used
      //Road road = Roads.get(i); 
      
    }
    
  }
  void drawTraffic () {
    rect(this.Pos.x - 5, this.Pos.y - 5, 10, 10);
  }
  
}

  //Pedestrian (PVector p, float s) {
  //  super(p, s);
  //}
  
  
  
  
  
  
  
