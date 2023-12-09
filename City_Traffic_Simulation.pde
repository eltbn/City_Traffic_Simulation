import g4p_controls.*;

int roadSize = 30; // for the demo, not sure if this will be a variable for roads
int selCity = 1; // put this into the GUI later



int time = 0; // this will be the global time variable used, 1 second = 60 seconds | time = 0 -> 60, time in game = 00:00 -> 00:01
float speedUpFactor = 1;
String inGameTime = "00:00"; // not going to be a string, just a placeholder
int frameRate = 60;
 
boolean Builder; // for building a city or choosing a preset city

String [] roadData;
String [] buildingData;

ArrayList <Road> Roads = new ArrayList<Road>();
ArrayList <Intersection> Intersections = new ArrayList <Intersection>();
ArrayList <Building> Buildings = new ArrayList<Building>();
ArrayList <Traffic> People = new ArrayList<Traffic>();


HashMap<PVector, String> findDirection = new HashMap<PVector, String>(); // hashmap returns the value when the first value (key) is input 





void setup() {
  size(700, 700);
  createGUI();
  String [] fileData = loadStrings("roadData.txt"); // represents the current file which that is imported
  roadData = new String [fileData.length];
  roadData = fileData;
  //println(roadData);
  
  fileData = loadStrings("buildingData.txt");
  buildingData = new String [fileData.length];
  buildingData = fileData;
 // println(buildingData[1]);
  
  findDirection.put(new PVector(1,0),"right");
  findDirection.put(new PVector(0,1),"up");
  findDirection.put(new PVector(1,0),"l");
  findDirection.put(new PVector(1,0),"up");
  
  
  

  generateRoads();
  createIntersection();
  println("num roads", Roads.size());
  for (Intersection i : Intersections) {
    println("intersections:",i.Pos, "connected to", i.Connected.size());
    
  }

  //println
  
  Traffic test = new Traffic(new PVector(-20, 205), 2);
  People.add(test);
  generateBuildings();
}


void draw() {

  
  background(255);
  frameRate(frameRate);
 // fill(255);
 
  for (int i = 0; i < Roads.size(); i++) {
    Roads.get(i).drawRoad();
  }
  
  for (Intersection currIntersection : Intersections) {
    if (currIntersection != null) {
    currIntersection.drawIntersection();
    }
  }//
  
  time += 1*speedUpFactor;

  setTime();
  
  time += 1*speedUpFactor;



  for (Building currBuilding : Buildings) {

    currBuilding.drawBuilding();
  }
  

  for (Traffic currTraffic : People) {

    currTraffic.drawTraffic();
    currTraffic.moveTraffic();
  }
}



void generateBuildings() {


  //// find the start and end index of the desired city preset
  int [] preset = findPreset(buildingData);
  
  
  int n = preset[0]; // sn starts at the preset name, 
  println ("n:", n);
  for (int i = 0; i < preset[1]; i++) {
    println("index:", i);
    int curr = n + i;
    
    
    
    
    int eStart = buildingData[curr].indexOf("E:") + 3; // e parameter specifies the direction of entrances the building has (up, down, left, right)
    int numEntrances = buildingData[curr].length() - eStart;
    println("num entrances",numEntrances);
    char [] Entrances = new char[numEntrances];
    int currEntrance = 0; // acts as a for loop variable, will increment each loop 
    
    for (int o = eStart; o < buildingData[curr].length(); o ++) {
      println(o);
      Entrances[currEntrance] = buildingData[curr].charAt(o);
      currEntrance ++;
    }
   
    println(Entrances);
    
    
    
    int sStart = buildingData[curr].indexOf("S:") + 3;
    float Size = float(buildingData[curr].substring(sStart, eStart - 4));
    
    
    
    int yStart = buildingData[curr].indexOf("Y:") + 3;
    println("substring",yStart, eStart - 4);
    float y = float(buildingData[curr].substring(yStart, sStart - 4));
    
    int xStart = buildingData[curr].indexOf("X:") + 3;
    println("index name:",buildingData[curr]);
    float x = float(buildingData[curr].substring(xStart, yStart - 4));
    //println("index:", i, "x value", x, "y value", y);
    
    char buildType = buildingData[curr].charAt(3); // takes the character of the inputted number in the string
    switch (buildType) {
      
      case 'B':
        Bank newBank = new Bank(new PVector(x, y), Size, Entrances);
        Buildings.add(newBank);
        break;
       
      case 'S':
        School newSchool = new School(new PVector(x, y), Size, Entrances);
        Buildings.add(newSchool);
        break;
    }
  }
}

void generateRoads() {
  int [] preset = findPreset(roadData);
  
  int n = preset[0];
  for (int i = 0; i < preset[1]; i++) {
    int curr = n + i;
    int SPStart = roadData[curr].indexOf("SP:")+4;
    println("char at",roadData[curr].charAt(SPStart));
    PVector startPoint = new PVector(int(roadData[curr].substring(SPStart, SPStart + 3)), int(roadData[curr].substring(SPStart+4, SPStart + 7)));
    println("Start",startPoint);
    
    int EPStart = roadData[curr].indexOf("EP:")+4;
    println("char at",roadData[curr].charAt(EPStart));
    println(roadData[curr]);
    PVector endPoint = new PVector(int(roadData[curr].substring(EPStart, EPStart + 3)), int(roadData[curr].substring(EPStart+4, EPStart + 7)));
    println("end",endPoint);
    
    Road newRoad = new Road(startPoint, endPoint, 1, 1);
    Roads.add(newRoad);
  }
}


void createIntersection() {
  for (int i = 0; i < Roads.size() - 1; i++) {
    for (int j = i + 1; j < Roads.size(); j++) {
      Road roadA = Roads.get(i);
      Road roadB = Roads.get(j);
      
      PVector intersection = findIntersection(roadA, roadB);
      if (intersection != null) {
        addIntersection(intersection, roadA, roadB);
      }
    }
  }
  
  // Add start or end points as intersections
  for (Road road : Roads) {
    addLoneIntersection(road.startPoint, road);
    addLoneIntersection(road.endPoint, road);
  }
  
  println("Intersections", Intersections.size());
}


PVector findIntersection(Road roadA, Road roadB) {  // since all roads will only be horizontal/vertical, points can be found geometrically instead of from formulas
  if ((roadA.horizontal && roadB.horizontal) || (!roadA.horizontal && !roadB.horizontal)) {
    return null; // If both lines are horizontal or vertical, or if both are neither, they don't intersect
  }

  float x, y;
  
  if (roadA.horizontal) { 
    x = roadB.startPoint.x;
    y = roadA.startPoint.y;
  } 
  else {
    x = roadA.startPoint.x;
    y = roadB.startPoint.y;
  }
  
  return new PVector(x, y);
}

void addIntersection(PVector intersectPos, Road roadA, Road roadB) { 
  boolean isDuplicate = false;
  
  for (Intersection existingIntersection : Intersections) {
    if (existingIntersection.Pos.equals(intersectPos)) {
      isDuplicate = true;
      return; // end the function prematurely
    }
  }
  
  if (!isDuplicate) {
    Intersection intersection = new Intersection(intersectPos); 
    Intersections.add(intersection);
    intersection.addConnected(roadA);
    intersection.addConnected(roadB);
  }
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


int [] findPreset(String [] file) { // takes in one of the fileData arrays, outputs the index of the preset name and the number of lines before the next
  int sn = 0; // emulates a for loop variable, finds the starting index for the desired city preset
  
  String start = str(selCity-1); // 4 will be changed to the button value from the GUI
  while (!file[sn].substring(0, 2).equals("C" + start)) {
    sn ++;
    println("sn",sn);
  }
  // println("final", sn, ":", file[sn]);
  
  int en = sn; // index of the last building; continue from the start index
  
  String end = str(selCity); // represents the next city or end
  while (!file[en].substring(0, 2).equals("C" + end)) {
    en ++;
  }
  en --;
 // println("final", en, ":", file[en]);
  
  int numBuildings = en - sn;
 // println(numBuildings);
  
  int n = 1+sn;
  int [] output = {n, numBuildings};
  return output;
}


void resetCity () {
  Roads.clear();
  Buildings.clear();
  People.clear();
  Intersections.clear();
  clear();
  generateRoads();
  createIntersection();
  generateBuildings();
  
}
