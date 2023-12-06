class Traffic {
  PVector Pos, Direction = new PVector(1,0);
  float Speed;
  int currentIndex = 0; // represents the index of the path arrayList, this is done so that the whole arrayList can be cleared at once when reaching the destination
  
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
    
    
   if (inRoad != null && reachedNextIntersection()) {
      currentIndex ++;
      
      roadBetween(Path.get(currentIndex), Path.get(currentIndex+1));
    }
  }
  float distToNext(char d) {
    switch(d) {
      
      
      
      
    }
    return 0.0;
  }  
    
  boolean reachedNextIntersection() { // calculates distance of the objects position to its target intersection, returns true if it has reached it

    // Check if the traffic's position is close to the end point of the current road
    float distanceToEnd = PVector.dist(this.Pos, inRoad.endPoint);
    
    // If the distance to the end point is less than the threshold, consider it reached
    return distanceToEnd < 5;
  }
  
  
  void determineDirection(PVector p1, PVector p2) {
    Direction = new PVector(p2.x - p1.x, p1.y - p2.y);
    
  }
  
  Road roadBetween(Intersection start, Intersection end) {
    // Find the road between two intersections based on their positions (start and end points)
    PVector startPos = start.Pos;
    PVector endPos = end.Pos;

    for (Road road : Roads) {
      if (road.startPoint.equals(startPos) && road.endPoint.equals(endPos) || 
      road.startPoint.equals(endPos) && road.endPoint.equals(startPos)) { // checks if the start and end intersections positions are equal to the road start and end points
            
        return road; // Return the road in between the intersections
      }
    }
    return null; // No road found between the intersections
  }
  
  void drawTraffic () {
    rect(this.Pos.x - 5, this.Pos.y - 5, 10, 10);
  }
  
}

  //Pedestrian (PVector p, float s) {
  //  super(p, s);
  //}
  
  
  
  
  
  
  
