class Road{
int name; 
PVector startPoint,endPoint;
int speedLimit;
float weight;
ArrayList <Traffic> People_in_Road = new ArrayList<Traffic>();

  Road(PVector sP, PVector eP, int sl, float w) {
    this.startPoint = sP;
    this.endPoint = eP;
    this.speedLimit = sl;
    this.weight = w;
 
  }


void drawRoad() {
  strokeWeight(10);
  rect(this.startPoint.x, this.startPoint.y, this.endPoint.x, roadSize);
  //line(this.startPoint.x, this.startPoint.y, this.endPoint.x, this.endPoint.y);
  strokeWeight(1);
}

// edits
void weightcalculation(){
 
  
  }
  
  
  //super.
}

//class Highway extends Road {
//  Highway(
  
  
//}
