class Road{
int name; 
PVector startPoint,endPoint;
int speedLimit;
float dist, max, min; // max and min are the max and min of x values if horizontal, and y values if vertical, they are variables so that they can nbe easily accessed
Boolean horizontal; // expressed as a boolean since there are only 2 possibilities for a road; indicates if traffic should check x or y things such as drawing roads
ArrayList <Traffic> People_in_Road = new ArrayList<Traffic>();

Road(PVector sP, PVector eP, int sl) {
  this.startPoint = sP;
  this.endPoint = eP;
  this.speedLimit = sl;
  this.name = Roads.size(); // road names are the index of this object in the Roads list
  if (this.startPoint.x == this.endPoint.x) {
    horizontal = false;
    min = min(this.startPoint.y, this.endPoint.y);
    max = max(this.startPoint.y, this.endPoint.y);
  }
  else {
    horizontal = true;
    min = min(this.startPoint.y, this.endPoint.y);
    max = max(this.startPoint.y, this.endPoint.y);
  }
  this.dist = calculateWeight();
 
}


void drawRoad() {
  fill(0);  
  strokeWeight(roadSize);
  line(this.startPoint.x, this.startPoint.y, this.endPoint.x, this.endPoint.y);
  strokeWeight(1);
}


float calculateWeight() { // returns the length of the road, considering that it is one dimensional
  if (this.horizontal) { // if horizontal, use x values
    return abs(this.startPoint.x - this.endPoint.x);   
  }
  else { // if vertical, use y values
    return abs(this.startPoint.y - this.endPoint.y);
   }  
 }
}
