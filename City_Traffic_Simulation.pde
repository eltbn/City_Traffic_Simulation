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
  //println(roadData);
  
  fileData = loadStrings("buildingData.txt");
  buildingData = new String [fileData.length];
  buildingData = fileData;
 // println(buildingData[1]);
  
  
  
  
  //if (buildingData[0].substring(0, 1) != "C" + "1") { println("Amogus");}
  
  Road test = new Road(200, 200, 300, 200, 5, 1);
  Roads.add(test);
  
  generateBuilding();
  
}


void draw() {
  background(255);
 // fill(255);
 
  for (Road currRoad : Roads) {
    currRoad.drawRoad();
  }
}



void generateBuilding() {
  int numBuildings = 0;
  boolean thisCity = true;
  int n = 0; // emulates a for loop variable
  while (buildingData[n].substring(0, 2) != "C" + "0") {
    //loopNum ++;
    println(n);
    println(buildingData[n].substring(0, 2));
    
    n ++;
  }
  println("final", n);
  
}
