import g4p_controls.*;

int roadSize = 50; // for the demo, not sure if this will be a variable for roads
int selCity = 0; // put this into the GUI later



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
  //println
  
}


void draw() {
  background(255);
 // fill(255);
 
  for (Road currRoad : Roads) {
    currRoad.drawRoad();
  }
  for (Building currBuilding : Buildings) {

    currBuilding.drawBuilding();
  }
  
  noLoop();
}



void generateBuilding() {


  // find the start and end index of the desired city preset
  int sn = 0; // emulates a for loop variable, finds the starting index for the desired city preset
  
  String start = str(selCity); // 4 will be changed to the button value from the GUI
  while (!buildingData[sn].substring(0, 2).equals("C" + start)) {
    sn ++;
  }
   println("final", sn, ":", buildingData[sn]);
  
  int en = sn; // index of the last building; continue from the start index
  
  String end = str(selCity+1); // represents the next city or end
  while (!buildingData[en].substring(0, 2).equals("C" + end)) {
    en ++;
  }
  en --;
  println("final", en, ":", buildingData[en]);
  
  int numBuildings = en - sn;
  println(numBuildings);
  
  int n = 1+sn;
  for (int i = 0; i < numBuildings; i++) {
    int curr = n + i;
    int yStart = buildingData[curr].indexOf("Y:") + 3;
    float y = float(buildingData[curr].substring(yStart));
    
    int xStart = buildingData[curr].indexOf("X:") + 3;
    float x = float(buildingData[curr].substring(xStart, yStart - 4));
    println("index:", i, "x value", x, "y value", y);
    
    char buildType = buildingData[curr].charAt(3);
    switch (buildType) {
      
      case 'B':
        Bank newBank = new Bank(new PVector(x, y));
        Buildings.add(newBank);
        break;
       
      case 'S':
        School newSchool = new School(new PVector(x, y));
        Buildings.add(newSchool);
        break;
    }
  }
  
  //switch
  
  
}
