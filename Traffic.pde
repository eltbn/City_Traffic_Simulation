class Traffic {
  PVector Pos;
  float Speed;
  
  
  
  Traffic(float x, float y, float s) {
    this.Pos = new PVector(x, y);
    this.Speed = s;
  }
  
   Traffic(PVector p, float s) {
    this.Pos = p;
    this.Speed = s;
  }
  
  void moveTraffic() {
    this.Pos.add(new PVector(2,0));
    
    
  }
  void drawTraffic () {
    rect(this.Pos.x, this.Pos.y, 10, 10);
  }
  
}

  //Pedestrian (PVector p, float s) {
  //  super(p, s);
  //}
  
  
  
  
  
  
  
