class Traffic {
  PVector Pos, Direction = new PVector(1,0);
  float Speed;
  int currentIndex; // represents the index of the path arrayList, this is done so that the whole arrayList can be cleared at once when reaching the destination
  Boolean reachedEnd = false;
  
  Intersection startPoint; // represents the spawnpoint or the startpoint for pathfinding
  Road inRoad; // the road the traffic object should be in
  
  Building Destination;
  ArrayList <Building> Schedule = new ArrayList <Building>();
  ArrayList <Intersection> Path = new ArrayList <Intersection>(); // path of intersection points to the destination
  
  
   Traffic(PVector p, float s, Intersection Start) {
    this.Pos = p;
    this.Speed = s;
    println("buildings", Buildings);
    this.startPoint = Start;
    Path = getShortestPath(startPoint, Buildings.get(int(random(0, Buildings.size()))).entrancePoint[0]);
    //Path.add(Intersections.get(7));
    //Path.add(Intersections.get(8));
    //Path.add(Intersections.get(1));
    //Path.add(Intersections.get(0));
    //Path.add(Intersections.get(2));
    //Path.add(Intersections.get(9));
    ////Path.add(Intersections.get(0));
    if (Path.size() != 1){
    inRoad = roadBetween(Path.get(0), Path.get(1)); // calling this function so that traffic is initialized with their current road set
    Direction = determineDirection(Path.get(0).Pos, Path.get(1).Pos);
    println("direction returned", Direction);
    currentIndex = 0;
    }
    else {
      reachedEnd = true;
      Direction = new PVector(0,0);
    }
    for (Intersection m : Path) {
    println("path is", m.Pos);
    }
  }
  
  void drawTraffic () {
    rect(this.Pos.x - 5, this.Pos.y - 5, 10, 10);
  }
  
  
  void moveTraffic() {
    PVector Move = Direction.copy(); // making a copy so that it doesnt multiply itself, copy is used so that Move doesn't use a reference to Direction
    Move.mult(speedUpFactor);
    this.Pos.add(Move);

    if (!reachedEnd) {
      if (inRoad != null && reachedNextIntersection(Path.get(currentIndex+1).Pos)) {
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
  

  boolean reachedNextIntersection(PVector targetLoc) {
    float distance;
    println(this.Pos, targetLoc, "road is", this.inRoad.horizontal, "direction is", Direction);
    if (inRoad.horizontal) {
      if (Direction.x < 0) {
        return this.Pos.x < targetLoc.x +1;
      }
      else {
        return this.Pos.x > targetLoc.x - 1;
      }
    }
    else {
     if (Direction.y < 0) {
       return this.Pos.y < targetLoc.y + 1;
     }
     else {
       return this.Pos.y > targetLoc.y - 1; 
     }
   }
 }
  
  PVector determineDirection(PVector p1, PVector p2) {
    if (p1.equals(p2)) {
        return new PVector(0, 0);
    }

    float xDiff = p2.x - p1.x;
    float yDiff = p2.y - p1.y;
    println("direction is ", xDiff, yDiff);
    float xDirection = constrain(xDiff, -1, 1);
    println("contrained x is", xDirection);
    float yDirection = constrain(yDiff, -1, 1);
println("contrained y is", yDirection);
    PVector direction = new PVector(xDirection, yDirection);
    println(direction);
    return direction;
}

  
  Road roadBetween(Intersection start, Intersection end) {
    PVector startPos = start.Pos;
    PVector endPos = end.Pos;
    //println(end.Pos);

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
  
  
  
  
  
  
