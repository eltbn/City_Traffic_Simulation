class Traffic {
  PVector Pos, Direction = new PVector(1,0);
  float Speed;
  int currentIndex; // represents the index of the path arrayList, this is done so that the whole arrayList can be cleared at once when reaching the destination
  Boolean reachedEnd = false;
  
  Intersection startPoint; // represents the spawnpoint or the startpoint for pathfinding
  Road inRoad; // the road the traffic object should be in
  Intersection previousPoint; // in case the person changes paths while moving 
  
  Building Destination;
  HashMap <Integer, Building> Schedule = new HashMap <Integer, Building>();
  ArrayList <Intersection> Path = new ArrayList <Intersection>(); // path of intersection points to the destination
  
  
   Traffic(PVector p, float s, Intersection Start) {
    this.Pos = p;
    this.Speed = s;
    println("buildings", Buildings);
    this.startPoint = Start;
    Path = getShortestPath(startPoint, Buildings.get(int(random(0, Buildings.size()))).entrancePoint[0]);

    setSchedule();
    previousPoint = Path.get(0);
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
        previousPoint = Path.get(currentIndex);
        if (currentIndex + 1 < Path.size()) {
        inRoad = roadBetween(Path.get(currentIndex), Path.get(currentIndex+1));
          
        Direction = determineDirection(Path.get(currentIndex).Pos, Path.get(currentIndex+1).Pos);
        }
      else { Direction = new PVector (0, 0); reachedEnd = true;}
      }
    }
  }
  
  

  boolean reachedNextIntersection(PVector targetLoc) {
    if (inRoad.horizontal) {
      if (Direction.x < 0) {
        return this.Pos.x < targetLoc.x ;
      }
      else {
        return this.Pos.x > targetLoc.x ;
      }
    }
    else {
     if (Direction.y < 0) {
       return this.Pos.y < targetLoc.y ;
     }
     else {
       return this.Pos.y > targetLoc.y ; 
     }
   }
 }
  
  PVector determineDirection(PVector p1, PVector p2) {
    if (p1.equals(p2)) {
        return new PVector(0, 0);
    }

    float xDiff = p2.x - p1.x;
    float yDiff = p2.y - p1.y;
    float xDirection = constrain(xDiff, -1, 1);
    float yDirection = constrain(yDiff, -1, 1);
    PVector direction = new PVector(xDirection, yDirection);
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

  void setSchedule() { // traffic will have 6 buildings to go to each day
    int numDayLoc = int(random(1,4));
    
    int timeRange = 24 / numDayLoc; // time range between moving to next location so that traffic is more likely to reach their destination before moving again, counts up by 30 minutes
    
    
    for (int i = 0; i < numDayLoc; i++) {
      Building chosenLoc = Buildings.get(int(random(0,Buildings.size() - 1)));
      int time = int(random(0, timeRange));
      Schedule.put(time + i*timeRange, chosenLoc);
    } 
   
    int numNightLoc = int(random(0, 2));
    if (numNightLoc != 0) { // people might not go outside at night
      timeRange = 24/ numNightLoc;
   
      for (int i = 0; i < numNightLoc; i++) {
        Building chosenLoc = Buildings.get(int(random(0, Buildings.size() - 1)));
        int time = int(random(0, timeRange));
        Schedule.put(time + i*timeRange + 12, chosenLoc);
      }
    }
    for (Integer key : Schedule.keySet()) {
    println("key", key);
    println(Schedule.get(key));
  }
  }
  
  void checkSchedule (int time) {
    Building check = Schedule.get(time);
    println(check);
    if (check != null) {
      
      Path = getShortestPath(previousPoint, check.entrancePoint[int(random(0, check.entrancePoint.length))]);
      reachedEnd = false;


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
    }
    
  }
  
}
  
  
  
