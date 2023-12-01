class Traffic {
  PVector Pos, Direction = new PVector(1,0);
  float Speed;
  
  Road inRoad;
  ArrayList <Road> Path = new ArrayList <Road>();
  
  
  
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
  
  
  
  
  
  
  
