class Traffic {
  PVector Pos, Direction = new PVector(1,0);
  float Speed;
  int currentIndex = 0; // represents the index of the path arrayList, this is done so that the whole arrayList can be cleared at once when reaching the destination
  Boolean reachedEnd = false;
  Road inRoad; // the road the traffic object should be in
  
  Building Destination;
  ArrayList <Building> Schedule = new ArrayList <Building>();
  ArrayList <Intersection> Path = new ArrayList <Intersection>(); // path of intersection points to the destination
  
  
   Traffic(PVector p, float s) {
    this.Pos = p;
    this.Speed = s;
    Path.add(Intersections.get(7));
    Path.add(Intersections.get(8));
    Path.add(Intersections.get(1));
    Path.add(Intersections.get(0));
    Path.add(Intersections.get(2));
    Path.add(Intersections.get(9));
   // Path.add(Intersections.get(0));
    inRoad = roadBetween(Path.get(0), Path.get(1)); // calling this function so that traffic is initialized with their current road set
  }
  
  void drawTraffic () {
    rect(this.Pos.x - 5, this.Pos.y - 5, 10, 10);
  }
  
  
  void moveTraffic() {
    PVector Move = Direction.copy(); // making a copy so that it doesnt multiply itself, copy is used so that Move doesn't use a reference to Direction
    Move.mult(speedUpFactor);
    this.Pos.add(Move);
    println(Direction);
    //println(Path.get(currentIndex+1).Pos);
    if (!reachedEnd) {
      if (inRoad != null && reachedNextIntersection(Path.get(currentIndex+1).Pos)) {
        println("reached target");
        currentIndex ++;
      
        if (currentIndex + 1 < Path.size()) {
        inRoad = roadBetween(Path.get(currentIndex), Path.get(currentIndex+1));
      
        Direction = determineDirection(Path.get(currentIndex).Pos, Path.get(currentIndex+1).Pos);
        }
      else { Direction = new PVector (0, 0); reachedEnd = true;}
      }
    }
  }
  
  void setSchedule() {
    
  }
  

  boolean reachedNextIntersection(PVector targetLoc) { // calculates distance of the objects position to its target intersection, returns true if it has reached it
    float distToTarget;
    if (inRoad.horizontal) {
      distToTarget = abs(targetLoc.x - this.Pos.x);
    }
    else {
      distToTarget = abs(targetLoc.y - this.Pos.y);
    }
    return distToTarget < 5; // If the distance to the end point is less than the threshold, return true
  }
  
  
  PVector determineDirection(PVector p1, PVector p2) {
    return new PVector(constrain(p2.x - p1.x, -1, 1), constrain(p2.y - p1.y, -1, 1)); // essentially normalizes the PVector but since values will only be exactly -1, 0, and 1 the calculation can be skipped
  }

  
  Road roadBetween(Intersection start, Intersection end) {
    PVector startPos = start.Pos;
    PVector endPos = end.Pos;
    println(end.Pos);

    for (Road road : Roads) {
      if ((road.startPoint.equals(startPos) && road.endPoint.equals(endPos)) || // checks if the start and end points of the roads are where the intersections are
          (road.startPoint.equals(endPos) && road.endPoint.equals(startPos))) {
        return road;
      }
    }
    return null; // there is no road found in between these points
  }
}

  

  //Pedestrian (PVector p, float s) {
  //  super(p, s);
  //}
  
  
  
  
  
  
