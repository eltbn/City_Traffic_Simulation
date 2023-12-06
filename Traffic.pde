class Traffic {
  PVector Pos, Direction = new PVector(1,0);
  float Speed;
  
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
    
    
   if (inRoad != null && distToNext(findDirection.get(Direction).charAt(0))) {
      // Move to the next road in the path if available
      int currentIndex = Path.indexOf(currentRoad.startIntersection);
      if (currentIndex < Path.size() - 1) {
        Intersection nextIntersection = Path.get(currentIndex + 1);
        currentRoad = findRoadBetweenIntersections(currentRoad.startIntersection, nextIntersection);
      } else {
        currentRoad = null; // Traffic reached the end of the path
      }
    }
   // distToNext(charAt(Direction.getValue(Direction)));
  }
  
  float distToNext(char d) {
    switch(d) {
      
      
      
      
    }
    return 0.0;
  }  
    
  boolean reachedNextIntersection() {
    // Implement logic to check if the traffic has reached the end of the current road
    
    // Check if the traffic's position is close to the end point of the current road
    float distanceToEnd = PVector.dist(this.Pos, inRoad.endPoint);
    
    // If the distance to the end point is less than the threshold, consider it reached
    return distanceToEnd < 5;
  }
  
  
  void determineDirection(PVector p1, PVector p2) {
    Direction = new PVector(p2.x - p1.x, p1.y - p2.y);
    
  }
  
  void findRoad() {
    float closest = 0; // incomplete; for checking people in road
    int index = 0;
    for (Road road : Roads) { // using generic for loop so that an index number (i) can be used
      //Road road = Roads.get(i); 
      
    }
    
  }
  
  void drawTraffic () {
    rect(this.Pos.x - 5, this.Pos.y - 5, 10, 10);
  }
  
}

  //Pedestrian (PVector p, float s) {
  //  super(p, s);
  //}
  
  
  
  
  
  
  
