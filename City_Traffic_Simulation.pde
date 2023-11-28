import g4p_controls.*;

int roadSize = 50; // for the demo, not sure if this will be a variable for roads

boolean Builder; // for building a city or choosing a preset city

String [] roadData;
String [] buildingData;

ArrayList <Road> Roads = new ArrayList<Road>();
ArrayList <Building> Buildings = new ArrayList<Building>();

void setup() {
  size(800, 800);
  createGUI();
  String [] fileData = loadStrings("roadData.txt"); // represents the current file which that is imported
  roadData = new String [fileData.length];
  roadData = fileData;
  println(roadData);
  
  fileData = loadStrings("buildingData.txt");
  buildingData = new String [fileData.length];
  buildingData = fileData;
  
  
  Road test = new Road(200, 200, 300, 200, 5, 1);
  Roads.add(test);
}


void draw() {
  background(255);
 // fill(255);
 
  for (Road currRoad : Roads) {
    currRoad.drawRoad();
  }
}
