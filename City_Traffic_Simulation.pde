import g4p_controls.*;

int roadSize = 50; // for the demo, not sure if this will be a variable for roads

float time = 0; // this will be the global time variable used, 1 second = 60 seconds | time = 0 -> 60, time in game = 00:00 -> 00:01
float speedUpFactor = 1;
String inGameTime = "00:00"; // not going to be a string, just a placeholder
int frameRate = 60;

boolean Builder; // for building a city or choosing a preset city

String [] roadData;
String [] BuildingData;

ArrayList <Road> Roads = new ArrayList<Road>();
ArrayList <Building> Buildings = new ArrayList<Building>();

void setup() {
  size(800, 800);
  createGUI();
  String [] fileData = loadStrings("roadData.txt"); // represents the current file which that is imported
  roadData = new String [fileData.length];
  roadData = fileData;
  Road test = new Road(200, 200, 300, 200, 5, 1);
  Roads.add(test);
}


void draw() {
  background(255);
  frameRate(frameRate);
 // fill(255);
 
  for (Road currRoad : Roads) {
    currRoad.drawRoad();
  }
  
  time += 1*speedUpFactor;
}
