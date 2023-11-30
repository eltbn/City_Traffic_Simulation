class Traffic {
  PVector Pos, Direction = new PVector(1,0);
  float Speed;
  
  
  
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
    
    float closest = 0; // incomplete; for checking people in road
    for (Road road : Roads) {
      
      float check = dist(this.Pos.x, this.Pos.y, road.startPoint.x, road.startPoint.y);
      if (check < closest) {
        closest = check;
      }
      
      check = dist(this.Pos.x, this.Pos.y, road.endPoint.x, road.endPoint.y);
      if (check < closest) {
        closest = check;
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
  
  
  
  
  
  
  
