void djikstra(Intersection start){ // Djikstra's algorithm doesn't directly find the path but instead sets the previous node i intersections to trace a path
  ArrayList<Intersection>unvisited = new ArrayList<Intersection>();
  for (Intersection intersection: Intersections){
    if (intersection != null) {
      
      intersection.minDist = Integer.MAX_VALUE; // set the minDist to default in case djikstra was used previously
      intersection.Prevnode =null; 
      unvisited.add(intersection);
    }
  }
  
  start.minDist = 0; // ensures that the start will be added first
  while (unvisited.size() != 0) {
    Intersection current = getNextMinIntersection(unvisited); // from the current intersection, find the next lowest distance intersection
    unvisited.remove(current); // set this intersection as visited
    
    for (Road road : current.Connected) { // only the roads connected to the intersection are needed
      Intersection neighbour = getNeighbourIntersection(current, road); // find the other intersection which the road is connected to
      if (!unvisited.contains(neighbour)) { // if the neighbour is already explored
        continue; // skip the below logic
      }
        float totalDist = current.minDist + road.dist; // set the distance of the neighbour
        if (totalDist < neighbour.minDist) {
          neighbour.minDist = totalDist;
          neighbour.Prevnode = current; // set the previous intersection to get to this intersection
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
    
  djikstra(start);
  Intersection current = end; // from the end intersection, trace the path using prevnode
  while (current != null) {
      path.add(current);
      current = current.Prevnode;
  }

  path = reverseArrayList(path); // the path needs to be reversed since points added earlier use bigger indexes
  return path;
}


ArrayList <Intersection> reverseArrayList(ArrayList<Intersection> list) {
  ArrayList <Intersection> newList = new ArrayList <Intersection>();
  for (int i = list.size() - 1; i >= 0; i--) {
    newList.add(list.get(i));
  }
  return newList;
}
