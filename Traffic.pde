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
    this.startPoint = Start;
    
    // constructor can be used as a local setup function
    Path = getShortestPath(startPoint, Buildings.get(int(random(0, Buildings.size()))).entrancePoint[0]);
    setSchedule();
    previousPoint = Path.get(0);
    if (Path.size() != 1) { // if the traffic is not already at their destination 
      inRoad = roadBetween(Path.get(0), Path.get(1)); // calling this function so that traffic is initialized with their current road set
      Direction = determineDirection(Path.get(0).Pos, Path.get(1).Pos);
      println("direction returned", Direction);
      currentIndex = 0;
    
    }
    else { // ensure the traffic stays at the destination 
      reachedEnd = true;
      Direction = new PVector(0,0);
    }
  }
  
  
  void drawTraffic () {
    rect(this.Pos.x - 5, this.Pos.y - 5, 10, 10);
  }
  
  
  void moveTraffic() {
    PVector Move = Direction.copy(); // copy is used so that Move doesn't use a reference to Direction and multiply itself as a result
    Move.mult(speedUpFactor);
    
    if (!reachedEnd) {
    float check = inRoad.rightSide.get(this.Direction); // cars will move to the right side of the road
    if (inRoad.horizontal) {
      Move.y = constrain(check - this.Pos.y, -1.0, 1.0);
    }
    else  {
      Move.x = constrain(check-this.Pos.x, -1, 1);
    }
    }
    
    this.Pos.add(Move);
    

    if (!reachedEnd) {
      if (inRoad != null && reachedNextIntersection(Path.get(currentIndex+1).Pos)) { // if the traffic passes the next intersection in their path
        currentIndex ++; // removing the item at index 0 from the path ArrayList would be more costly since all items are shifted down one index
        //this.Pos = Path.get(currentIndex).Pos.copy(); // ensure traffic stays on the road, especially with higher speeds where cars would skip over roads
        
        previousPoint = Path.get(currentIndex); // take the last index the traffic was on in case the schedule changes while it is moving
        
        if (currentIndex + 1 < Path.size()) { // if there is a next insection
        inRoad = roadBetween(Path.get(currentIndex), Path.get(currentIndex+1)); // take the road in between the intersections
          
        Direction = determineDirection(Path.get(currentIndex).Pos, Path.get(currentIndex+1).Pos);
        }
        else { // traffic has reached its destination
          Direction = new PVector (0, 0);  // ensure the car stops moving
          reachedEnd = true;
        }
      }
    }
  }

  boolean reachedNextIntersection(PVector targetLoc) { // returns true if the traffic has passed the intersection by comparing x or y values
    if (inRoad.horizontal) { // if horizontal, x values will be checked
      if (Direction.x < 0) { 
        return this.Pos.x < targetLoc.x + roadSize/4;
      }
      else {
        return this.Pos.x > targetLoc.x - roadSize/4;
      }
    }
    else { // if vertical, y values will be checked
     if (Direction.y < 0) {
       return this.Pos.y < targetLoc.y + roadSize/4;
     }
     else {
       return this.Pos.y > targetLoc.y - roadSize/4; 
     }
   }
 }
 
  
  PVector determineDirection(PVector p1, PVector p2) { // find direction by subtracting current and target positions, then normalizing the pvector
    if (p1.equals(p2)) {
        return new PVector(0, 0);
    }

    float xDiff = p2.x - p1.x;
    float yDiff = p2.y - p1.y;
    float xDirection = constrain(xDiff, -1, 1); // constrain can be used to normalize the pvector since only x or y will not be 0
    float yDirection = constrain(yDiff, -1, 1);
    PVector direction = new PVector(xDirection, yDirection);
    return direction;
}

  
  Road roadBetween(Intersection start, Intersection end) { // finds the road by checking if the road's start and endpoints are equal to the two intersections
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

  void setSchedule() { // traffic will have up to 6 buildings to go to each day
    Schedule.clear();
    int numDayLoc;
    int numNightLoc;
    
    
    if (randomizeSchedule) {
      numDayLoc = int(random(0, numDayMax)); 
      numNightLoc = int(random(0, numNightMax)); 
    }
    else {
      numDayLoc = numDayMax;
      numNightLoc = numNightMax;
    }
    
    if (numDayLoc != 0) {
    int timeRange = 24 / numDayLoc; // time range between moving to next location so that traffic is more likely to reach their destination before moving again, counts up by 30 minutes
        
    for (int i = 0; i < numDayLoc; i++) {
      Building chosenLoc = Buildings.get(int(random(0,Buildings.size() - 1)));
      int setTime = int(random(0, timeRange));
      Schedule.put(setTime + i*timeRange, chosenLoc);
      println("morning", setTime + i*timeRange);
    } 
    }
  
    if (numNightLoc != 0) {
      int timeRange = 24/ numNightLoc;
   
      for (int i = 0; i < numNightLoc; i++) {
        Building chosenLoc = Buildings.get(int(random(0, Buildings.size() - 1)));
        int setTime = int(random(0, timeRange));
        Schedule.put(setTime + i*timeRange + 12, chosenLoc); // setting the hashmap so when the time is input and there is a value associated, it will return the value
        println("night",setTime + i*timeRange + 12);
      }
    }
  }

  
  void checkSchedule (int time) { // inputs the key into the schedule hashmap, and setting the destination if a value is returned   
    Building check = Schedule.get(time);
    if (check != null && reachedEnd) { // if the person has a scheduled building at this time
      
      Path = getShortestPath(previousPoint, check.entrancePoint[int(random(0, check.entrancePoint.length))]);
      reachedEnd = false;

      if (Path.size() != 1) { // if the traffic is not currently at the destination
        inRoad = roadBetween(Path.get(0), Path.get(1)); // calling this function so that traffic is initialized with their current road set
        Direction = determineDirection(Path.get(0).Pos, Path.get(1).Pos);
        currentIndex = 0;    
      }
      else { // the traffic is already at the destination
        reachedEnd = true;
        Direction = new PVector(0,0);
      }
    }    
  }  
}  
