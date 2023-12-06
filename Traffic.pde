class Traffic {
  PVector Pos, Direction = new PVector(1,0);
  float Speed;
  int currentIndex = 0; // represents the index of the path arrayList, this is done so that the whole arrayList can be cleared at once when reaching the destination
  Boolean reached = false;
  Road inRoad;
  ArrayList <Intersection> Path = new ArrayList <Intersection>();
  
  
   Traffic(PVector p, float s) {
    this.Pos = p;
    this.Speed = s;
    Path.add(Intersections.get(5));
    Path.add(Intersections.get(0));
    Path.add(Intersections.get(1));
    Path.add(Intersections.get(3));
    inRoad = roadBetween(Path.get(0), Path.get(1)); // calling this function so that traffic is initialized with their current road set
  }
  
  void drawTraffic () {
    rect(this.Pos.x - 5, this.Pos.y - 5, 10, 10);
  }
  
  
  void moveTraffic() {
    this.Pos.add(Direction.mult(speedUpFactor));
    if (!reached) {
   if (inRoad != null && reachedNextIntersection(Path.get(currentIndex+1).Pos)) {
     println("reached target");
      currentIndex ++;
      
      if (currentIndex + 1 < Path.size()) {
      inRoad = roadBetween(Path.get(currentIndex), Path.get(currentIndex+1));
      
      Direction = determineDirection(Path.get(currentIndex).Pos, Path.get(currentIndex+1).Pos);
      }
      else { Direction = new PVector (0, 0); reached = true;}
    }
    }
  }
  
  
  

  boolean reachedNextIntersection(PVector target) { // calculates distance of the objects position to its target intersection, returns true if it has reached it

    // Check if the traffic's position is close to the end point of the current road
    float distanceToTarget = PVector.dist(this.Pos, target);
    
    // If the distance to the end point is less than the threshold, consider it reached
    return distanceToTarget < 10;
  }
  
  
  PVector determineDirection(PVector p1, PVector p2) {
    return new PVector(constrain(p2.x - p1.x, -1, 1), constrain(p2.y - p1.y, -1, 1));
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
  
  
}

  //Pedestrian (PVector p, float s) {
  //  super(p, s);
  //}
  
  
  
  
  
  
  
