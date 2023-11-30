class Traffic {
  PVector Pos, Direction = new PVector(1,0);
  float Speed;
  
  Road inRoad;
  
  
  
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
    this.Pos.add(Direction);
    
    for (Road road : Roads) {
      if (road.endPoint.x - this.Pos.x <= -10) {
        this.Direction = new PVector (0, 1);
      }
    }
  }
  
  
  
  void findRoad() {
    float closest = 0; // incomplete; for checking people in road
    int index = 0;
    for (int i = 0; i < Roads.size(); i++) { // using generic for loop so that an index number (i) can be used
      Road road = Roads.get(i); 
      float check = dist(this.Pos.x, this.Pos.y, road.startPoint.x, road.startPoint.y);
      if (check < closest) {
        closest = check;
        index = i;
      }
      
      check = dist(this.Pos.x, this.Pos.y, road.endPoint.x, road.endPoint.y);
      if (check < closest) {
        closest = check;
        index = i;
      }
      if (i == Roads.size()) {
        Roads.get(index).People_in_Road.add(this);
     //   this.inRoad = Roads.get(index);
      }
    }
    
  }
  void drawTraffic () {
    rect(this.Pos.x, this.Pos.y, 10, 10);
  }
  
}

  //Pedestrian (PVector p, float s) {
  //  super(p, s);
  //}
  
  
  
  
  
  
  
