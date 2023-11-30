class Road{
int name; 
PVector startPoint,endPoint;
int speedLimit;
float weight;
Boolean Horizontal = true; // expressed as a boolean since there are only 2 possibilities for a road, also indicates if traffic should check x or y when looking for start/end points
ArrayList <Traffic> People_in_Road = new ArrayList<Traffic>();

  Road(PVector sP, PVector eP, int sl, float w, int n) {
    this.startPoint = sP;
    this.endPoint = eP;
    this.speedLimit = sl;
    this.weight = w;
    this.name = n;
 
  }


void drawRoad() {

  fill(0);  
  rect(this.startPoint.x - roadSize/2, this.startPoint.y - roadSize/2, this.endPoint.x - this.startPoint.x + roadSize, this.endPoint.y - this.startPoint.y + roadSize);
    
  
  
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
