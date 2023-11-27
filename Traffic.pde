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
  
  void move() {
  
    
    
  }
  
}


class Pedestrian extends Traffic {
  Pedestrian (float x, float y, float s) {
    super(x, y, s);
  }
  
  Pedestrian (PVector p, float s) {
    super(p, s);
  }
  
  
  
  
  
  
  
}
