class Intersection { // acts as a node for djikstra's algorithm
  PVector Pos;
  ArrayList <Road> Connected = new ArrayList <Road>();
  Intersection Prevnode;
  int mindist;
  int [][]connections;
  
  
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

//void djikstra(Intersection start, Intersection end){
//  ArrayList<Intersection>unvisited = new ArrayList<>();
//  for (Intersection intersection: AllIntersections){
//    intersection.mindist = Integer.MAX_VALUE;
//    intersection.Prevnode =null;
//    unvisited.add(intersection);
//  }
//}
