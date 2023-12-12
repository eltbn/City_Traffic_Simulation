import g4p_controls.*;

int roadSize = 30;
int selCity = 1; // put GUI but also changable here



int batchAmt = 1;
float time = 0; // this will be the global time variable used, 1 second = 60 seconds | time = 0 -> 60, time in game = 00:00 -> 00:0
int timeInterval = 0; // used for 30 simulation minute intervals
float speedUpFactor = 1;
int frameRate = 60;
 
boolean Builder; // for building a city or choosing a preset city

String [] roadData;
String [] buildingData;

// simulation objects
ArrayList <Road> Roads = new ArrayList<Road>();
ArrayList <Intersection> Intersections = new ArrayList <Intersection>();
ArrayList <Intersection> spawnPoints = new ArrayList <Intersection>(); // traffic can be spawned on any of these intersections
ArrayList <Building> Buildings = new ArrayList<Building>();
ArrayList <Traffic> People = new ArrayList<Traffic>();


void setup() {
  size(700, 700);
  createGUI();
  String [] fileData = loadStrings("roadData.txt"); // represents the current file which that is imported
  roadData = new String [fileData.length];
  roadData = fileData;
  
  fileData = loadStrings("buildingData.txt");
  buildingData = new String [fileData.length];
  buildingData = fileData;
  
  // object creation is done in this order intentionally
  generateRoads(); // creates roads from text file
  createIntersection(); // creates intersection points at the ends of roads

  generateBuildings(); //creates buildings from text file
  setSpawnPoints(); // designates certain points, points on edges of screen or buildings to place new traffic objects in
 
  setRoadConnections(); // in case connected intersections in roads are not properly set
}


void draw() {
  background(255);
  frameRate(frameRate);
  
  
 time += 6*speedUpFactor;

  setTime();
  if (time / 1800 >= timeInterval) { // every 30 simulation minutes
    timeInterval ++;
    if (timeInterval > 51) { //
      timeInterval = 0; 
      time = 0;
    }
    for (Traffic person : People) {
      person.checkSchedule(timeInterval);
    }
  }
 

  for (int i = 0; i < Roads.size(); i++) {
    Roads.get(i).drawRoad();
  }
  
  for (Intersection currIntersection : Intersections) {
    if (currIntersection != null) {
    currIntersection.drawIntersection();
    }
  }
  
  for (int i = 0; i < People.size(); i++) {
    Traffic currTraffic = People.get(i);
    currTraffic.drawTraffic();
    currTraffic.moveTraffic();
  }
  
  for (Building currBuilding : Buildings) {

    currBuilding.drawBuilding();
  }
}



void generateBuildings() {
  // find the start and end index of the desired city preset, also called at the start of generateRoads()
  int [] preset = findPreset(buildingData);
  
  
  int n = preset[0]; // sn starts at the preset name, 
  for (int i = 0; i < preset[1]; i++) {
    int curr = n + i; // represents the current line being read
    
    // reading file data from right to left; find entrances
    int eStart = buildingData[curr].indexOf("E:") + 3; // e parameter specifies the direction of entrances the building has (up, down, left, right)
    int numEntrances = buildingData[curr].length() - eStart; // this is possible since entrances are listed last
    char [] Entrances = new char[numEntrances]; // entrances are added as characters to be used later in a switch statement
    
    int currEntrance = 0; // acts as a for loop variable, will increment each loop    
    for (int o = eStart; o < buildingData[curr].length(); o ++) { // add the entrances to the array
      Entrances[currEntrance] = buildingData[curr].charAt(o);
      currEntrance ++;
    }
    
    
    // find size
    int sStart = buildingData[curr].indexOf("S:") + 3; // index for where to read the size
    float Size = float(buildingData[curr].substring(sStart, eStart - 4)); // float value of the size
    
    
    // find y coordinate
    int yStart = buildingData[curr].indexOf("Y:") + 3; // index of where the y cordinate is read
    float y = float(buildingData[curr].substring(yStart, sStart - 4));
    
    //find x coordinate
    int xStart = buildingData[curr].indexOf("X:") + 3; // index of where the x cordinate is read
    float x = float(buildingData[curr].substring(xStart, yStart - 4));
    
    char buildType = buildingData[curr].charAt(3); // takes the character of the inputted number in the string to find what type of building to be constructed
    switch (buildType) {
      
      case 'B':
        Bank newBank = new Bank(new PVector(x, y), Size, Entrances);
        Buildings.add(newBank);
        break;
       
      case 'S':
        School newSchool = new School(new PVector(x, y), Size, Entrances);
        Buildings.add(newSchool);
        break;
        
      case 'H':
        House newHouse = new House(new PVector(x, y), Size, Entrances);
        Buildings.add(newHouse);
        break;
        
      case 'M':
        Mart newMart = new Mart(new PVector(x, y), Size, Entrances); // this is named such since building types cant have the same first letter
        Buildings.add(newMart);
        break;  
    }
  }
}


void generateRoads() {
  int [] preset = findPreset(roadData); // get the start and end index of this preset
  
  int n = preset[0];
  for (int i = 0; i < preset[1]; i++) {
    int curr = n + i; // represents the line being read
    String data = roadData[curr];
    
    int rightChecked = data.indexOf("EPy:") + 5; // represents the right most parameter, this is used to skip declaring a variable for the index of each parameter in roadData
    float yPoint = int(data.substring(rightChecked));
    
    int leftChecked = data.indexOf("EPx:") + 5;  // get the leftmost index for the endPoint x value
    float xPoint = int(data.substring(leftChecked, rightChecked - 6));
    PVector endPoint = new PVector(xPoint, yPoint); // making the Pvector here to reuse variables
    
    rightChecked = leftChecked; // adjust the check variables to the next item being readd
    leftChecked = data.indexOf("SPy:") + 5;
    
    yPoint = int(data.substring(leftChecked, rightChecked - 6)); // startPoint y value
    
    rightChecked = leftChecked;
    leftChecked = data.indexOf("SPx:") + 5;   
    
    xPoint = int(data.substring(leftChecked, rightChecked - 6)); // startPoint x value
    
    PVector startPoint = new PVector(xPoint, yPoint);
    
    Road newRoad = new Road(startPoint, endPoint, 1);
    Roads.add(newRoad);
  }
}


int [] findPreset(String [] file) { // takes in one of the fileData arrays, outputs the index of the preset name and the number of lines before the next
  int sn = 0; // emulates a for loop variable, finds the starting index for the desired city preset
  
  String start = str(selCity-1); // 4 will be changed to the button value from the GUI
  while (!file[sn].substring(0, 2).equals("C" + start)) {
    sn ++;
  }
  
  int en = sn; // index of the last building; continue from the start index
  
  String end = str(selCity); // represents the next city or end
  while (!file[en].substring(0, 2).equals("C" + end)) {
    en ++;
  }
  en --;
  
  int numBuildings = en - sn; // number of lines between the current city and the next city
  
  int n = 1+sn;
  int [] output = {n, numBuildings};
  return output;
}


void createIntersection() { // this function mainly calls other functions to construct intersections
  for (int i = 0; i < Roads.size() - 1; i++) { // this cant be an array based for loop since Roads will be modified
    for (int j = i + 1; j < Roads.size(); j++) {
      Road roadA = Roads.get(i); // emulates an array based for loop
      Road roadB = Roads.get(j);
      
      PVector intersection = findIntersection(roadA, roadB); // find intersections from these roads
      if (intersection != null) {
        addIntersection(intersection, roadA, roadB);
        
      }
    }
  }
  
  // Add any remaining start or end points on roads as intersections
  for (Road road : Roads) {
    addLoneIntersection(road.startPoint, road);
    addLoneIntersection(road.endPoint, road);
  }
}


PVector findIntersection(Road roadA, Road roadB) {
  // Check if one road is horizontal and the other is vertical
  if ((roadA.horizontal && !roadB.horizontal) || (!roadA.horizontal && roadB.horizontal)) {
    if (roadA.horizontal) { // since all roads are perfectly horizontal or vertical, they are essential line equations of x = __ and y = __, making the intersection (x, y)
      float x = roadB.startPoint.x;
      float y = roadA.startPoint.y;

      // Check if the vertical road's x-coordinate is within the range of the horizontal road's x-coordinates
      if (x >= roadA.min && x <= roadA.max) {
        // Check if the horizontal road's y-coordinate is within the range of the vertical road's y-coordinates
        if (y >= roadB.min && y <= roadB.max) {
          return new PVector(x, y);
        }
      }
    } else {
      float x = roadA.startPoint.x;
      float y = roadB.startPoint.y;

      // Check if the horizontal road's x-coordinate is within the range of the vertical road's x-coordinates
      if (x >= min(roadB.startPoint.x, roadB.endPoint.x) && x <= max(roadB.startPoint.x, roadB.endPoint.x)) {
        // Check if the vertical road's y-coordinate is within the range of the horizontal road's y-coordinates
        if (y >= min(roadA.startPoint.y, roadA.endPoint.y) && y <= max(roadA.startPoint.y, roadA.endPoint.y)) {
          return new PVector(x, y);
        }
      }
    }
  }
  return null; // if no intersection
}


void addIntersection(PVector intersectPos, Road roadA, Road roadB) { // general function for safely adding intersections 
  
  for (Intersection existingIntersection : Intersections) {
    if (existingIntersection.Pos.equals(intersectPos)) {
      return; // end the function prematurely
    }
  }
  
  Intersection intersection = new Intersection(intersectPos); 
  
    Intersections.add(intersection); // add intersection to arrays
    intersection.addConnected(roadA); 
    intersection.addConnected(roadB);
  
}

void addLoneIntersection(PVector point, Road road) {
  for (Intersection existingIntersection : Intersections) { // check if an intersection doesn't exist at this point
    if (existingIntersection.Pos.equals(point)) {
      return; // If the point is already an intersection, skip creating another intersection object
    }
  }
  // If the point is not an intersection, create one at the point
  Intersection intersection = new Intersection(point); 
  Intersections.add(intersection);
  intersection.addConnected(road);
}


Intersection posToIntersection(PVector point) { // takes a pVector and returns the Intersection at the point
  for (Intersection intersection : Intersections) {
    if (point.equals(intersection.Pos)) {
      return intersection; // Return the intersection if there is an intersection at this point
    }
  }
  return null; // Return null in case there is no intersection at this point
}


void setRoadConnections() { // adds any missed raods to their respective connected intersections
  for (Intersection intersection : Intersections) {
    for (Road road : Roads) {
      if (intersection.Pos.equals(road.startPoint) || intersection.Pos.equals(road.endPoint)) {
        intersection.addConnected(road);
      }
    }
  }
}


void setSpawnPoints() { // 
  for (Intersection point : Intersections) {
    if (point != null) {
    if (point.Pos.x == 0 || point.Pos.x == width || point.Pos.y == 0 || point.Pos.y == height) { // if the intersections are on the edge of the screen
      spawnPoints.add(point);
    }
    }  
  }
  for (Building entrance : Buildings) {
    for (Intersection point : entrance.entrancePoint) { // add all buildings entrances as spawnPoints as well
      spawnPoints.add(point);
    }
  }
}


void spawnTraffic () {
  Intersection randSpawn = spawnPoints.get(int(random(0,spawnPoints.size()))); // spawn traffic at a random spawnPoint
  PVector spawnPos = randSpawn.Pos.copy(); // a copy is used so that a reference is not used
  
  Traffic newTraffic = new Traffic (spawnPos, 1, randSpawn);
  People.add(newTraffic);
}


void resetCity () { // reset everything stored
  Roads.clear();
  Buildings.clear();
  People.clear();
  Intersections.clear();
  clear();
  generateRoads();
  createIntersection();
  generateBuildings();
  timeInterval = 0; 
  time = 0;
}
