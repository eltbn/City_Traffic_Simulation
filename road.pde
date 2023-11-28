class Road{
int name; 
PVector startPoint,endPoint;
int speedLimit;
float weight;
ArrayList <Traffic> People_in_Road = new ArrayList<Traffic>();

  Road(float x1, float y1, float x2, float y2, int sl, float w) {
    this.startPoint = new PVector(x1, y1);
    this.endPoint = new PVector(x2, y2);
    this.speedLimit = sl;
    this.weight = w;
    
    
  }

void calculateAngle() {
  PVector originAngle = new PVector(this.endPoint.x - this.startPoint.x, this.endPoint.x - this.startPoint.y);
  originAngle.x = cos(originAngle.x); originAngle.y = sin(originAngle.y);
  
  
  
}

void drawRoad() {
  strokeWeight(10);
  line(this.startPoint.x, this.startPoint.y, this.endPoint.x, this.endPoint.y);
}

// edits
void weightcalculation(){
 
  
  }
  
  
  //super.
}

//class Highway extends Road {
//  Highway(
  
  
//}
