import g4p_controls.*;

int roadSize = 30;
int selCity = 1; // put GUI but also changable here
int startTime = 0;


int batchAmt = 1;
int numDayMax = 3; // the number of buildings in the schedule are randomized by default
int numNightMax = 3;
Boolean randomizeSchedule = true; // option to randomize the amount of locations each day


float time = 0; // this will be the global time variable used, 1 second = 60 seconds | time = 0 -> 60, time in game = 00:00 -> 00:0
int timeInterval = 0; // used for 30 simulation minute intervals
float speedUpFactor = 1;
int frameRate = 60;
 
boolean showIntersection = true; // this option is in here since showing intersections isn't realistic for the simulation, but is helpful for debugging

String [] roadData;
String [] buildingData;

// simulation objects
ArrayList <Road> Roads = new ArrayList<Road>();
ArrayList <Intersection> Intersections = new ArrayList <Intersection>();
ArrayList <Intersection> spawnPoints = new ArrayList <Intersection>(); // traffic can be spawned on any of these intersections
ArrayList <Building> Buildings = new ArrayList<Building>();
ArrayList <Traffic> People = new ArrayList<Traffic>();
HashMap <PVector, PVector> rightSide = new HashMap <PVector, PVector>(); // determines the right side position of cars to the road by adding its value, hashmaps return the second value when the first value (key) is input


void setup() {
  size(700, 700);
  createGUI();
  
  rightSide.put(new PVector(1, 0), new PVector(0, -roadSize/2));
  rightSide.put(new PVector(-1, 0), new PVector(0, roadSize/2));
  rightSide.put(new PVector(0, 1), new PVector(roadSize/2, 0));
  rightSide.put(new PVector(0, -1), new PVector(-roadSize/2, 0));
  
  
  String [] fileData = loadStrings("roadData.txt"); // represents the current file which that is imported
  roadData = new String [fileData.length];
  roadData = fileData;
  
  fileData = loadStrings("buildingData.txt");
  buildingData = new String [fileData.length];
  buildingData = fileData;
  
  setCity();
}


void draw() {
  background(255);
  frameRate(frameRate);
  

  time += 6*speedUpFactor;

  setTime();
  if (time / 1800 >= timeInterval) { // every 30 in-simulation minutes
    timeInterval ++;
    if (timeInterval > 49) { //
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
  
  if (showIntersection) {
    for (Intersection currIntersection : Intersections) {
      if (currIntersection != null) {
      currIntersection.drawIntersection();
      }
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
  spawnPoints.clear();
  clear();
  
  setCity();
}


void setCity() {
  // object creation is done in this order intentionally
  generateRoads(); // creates roads from text file
  createIntersection(); // creates intersection points at the ends of roads

  generateBuildings(); //creates buildings from text file
  setSpawnPoints(); // designates certain points, points on edges of screen or buildings to place new traffic objects in
  setRoadConnections(); // in case connected intersections in roads are not properly set
  
  timeInterval = 0; 
  time = startTime;
}

void mousePressed() {
  println(mouseX, mouseY);
}
