class Road{
int name; 
PVector startPoint,endPoint;
int speedLimit;
float weight;
Boolean horizontal = false; // expressed as a boolean since there are only 2 possibilities for a road, also indicates if traffic should check x or y when looking for start/end points
ArrayList <Traffic> People_in_Road = new ArrayList<Traffic>();

Road(PVector sP, PVector eP, int sl, float w, int n) {
  this.startPoint = sP;
  this.endPoint = eP;
  this.speedLimit = sl;
  this.weight = w;
  this.name = n;
  if (this.startPoint.x == this.endPoint.x) {
    horizontal = true;
  }
 
}


void drawRoad() {
  fill(0);  
  if (horizontal) {
    rect(this.startPoint.x, this.startPoint.y, this.endPoint.x - this.startPoint.x + roadSize, this.endPoint.y - this.startPoint.y + roadSize);
  }
  else if (!horizontal) {
    rect(this.startPoint.x, this.startPoint.y, this.endPoint.x - this.startPoint.x + roadSize, this.endPoint.y - this.startPoint.y + roadSize);
  }
  rect(this.startPoint.x, this.startPoint.y, 10, 10);
  rect(this.endPoint.x, this.endPoint.y, 10, 10);
  
  //rect(this.startPoint.x, this.startPoint.y, this.endPoint.x, roadSize);
  //line(this.startPoint.x, this.startPoint.y, this.endPoint.x, this.endPoint.y);

}

// edits
void weightcalculation(){
 
  
  }
  
  
  //super.
}

//class Highway extends Road {
//  Highway(
  
  
//}
