class Intersection { // acts as a node for djikstra's algorithm
  PVector Pos;
  ArrayList <Road> Connected = new ArrayList <Road>();
  Intersection Prevnode;
  float minDist;
  float [][]connections;
  
  
  Intersection(PVector p) {
   this.Pos = p;
    
  }
  void drawIntersection() {
    fill(255, 0, 0);
    circle(this.Pos.x, this.Pos.y, 10); 
  }
  
  void addConnected(Road road) { // not needed but makes the code more readable
    if (!this.Connected.contains(road)) {
      this.Connected.add(road); 
    }
  }
}

void djikstra(Intersection start, Intersection end){
  ArrayList<Intersection>unvisited = new ArrayList<Intersection>();
  println("intersections", Intersections);
  for (Intersection intersection: Intersections){
    if (intersection != null) {
    intersection.minDist = Integer.MAX_VALUE;
    intersection.Prevnode =null;
    unvisited.add(intersection);
    }
  }
  
  start.minDist = 0;
  while(unvisited.size() != 0) {
    Intersection current = getNextMinIntersection(unvisited);
    unvisited.remove(current);
    println("found", current, Intersections.indexOf(current));
    println(current.Connected.size());
    
    for (Road road : current.Connected) { // only the roads connected to the intersection are needed
      Intersection neighbour = getNeighbourIntersection(current, road);
      println("neighbour is", neighbour, "from", current.Pos, road.startPoint, road.endPoint);
      if (!unvisited.contains(neighbour)) {  // if the neighbour is already explored
        continue; // skip the below logic
      }
      println("not neightbour");
        float totalDist = current.minDist + road.dist;
        if (totalDist < neighbour.minDist) {
          neighbour.minDist = totalDist;
          neighbour.Prevnode = current;
        }
      }
    }
  }

  
  
Intersection getNextMinIntersection(ArrayList <Intersection> unvisited) {
  Intersection minIntersection = null; // initialize this in case no min distance Intersection is found
  float minDistance = Integer.MAX_VALUE; // default if no other paths are found, meaning the point is isolated or itself
  for (Intersection intersection : unvisited) {
    if (intersection.minDist < minDistance) {
      minDistance = intersection.minDist;
      minIntersection = intersection;
      }
    }
  return minIntersection;
}


Intersection getNeighbourIntersection(Intersection intersection, Road road) {
    Intersection neighbor = null;
  println("find neighbour",intersection.Pos, road.startPoint, road.endPoint);
    // If the road's startPoint matches the intersection's position, the endPoint is the neighboring intersection
    if (intersection.Pos.equals(road.startPoint)) {
        neighbor = posToIntersection(road.endPoint); // Implement findIntersectionByPosition() method
    }
    // If the road's endPoint matches the intersection's position, the startPoint is the neighboring intersection
    else if (intersection.Pos.equals(road.endPoint)) {
        neighbor = posToIntersection(road.startPoint); // Implement findIntersectionByPosition() method
    }

    return neighbor;
}


ArrayList<Intersection> getShortestPath(Intersection start, Intersection end) {
    ArrayList<Intersection> path = new ArrayList<Intersection>();
    
    djikstra(start, end);
    Intersection current = end;
    while (current != null) {
        path.add(current);
        current = current.Prevnode;
    }
    
    println("path:");
    for (Intersection p: path) {
      println("goto",p.Pos);
    }
    
    path = reverseArrayList(path);
    
    
    println("path:");
    for (Intersection p: path) {
      println("goto",p.Pos);
    }
    return path;
}


ArrayList <Intersection> reverseArrayList(ArrayList<Intersection> list) {
  ArrayList <Intersection> newList = new ArrayList <Intersection>();
  for (int i = list.size() - 1; i >= 0; i--) {
    newList.add(list.get(i));
  }
  return newList;
}
