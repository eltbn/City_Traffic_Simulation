class Intersection { // acts as a node for djikstra's algorithm
  PVector Pos;
  ArrayList <Road> Connected = new ArrayList <Road>();
  Intersection(PVector p) {
   this.Pos = p;
    
  }
  void drawIntersection() {
    fill(255, 0, 0);
    circle(this.Pos.x, this.Pos.y, 10); 
  }
  
  void addConnected(Road road) { // not needed but makes the code more readable
    this.Connected.add(road); 
    
  }
}
