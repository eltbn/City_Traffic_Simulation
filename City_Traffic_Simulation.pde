import g4p_controls.*;

int roadSize = 50; // for the demo, not sure if this will be a variable for roads
int selCity = 1; // put this into the GUI later



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
  
  
  
  

  
  Road test = new Road(200, 200, 300, 200, 5, 1);
  Roads.add(test);
  
  generateBuildings();
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



void generateBuildings() {


  //// find the start and end index of the desired city preset
  //int sn = 0; // emulates a for loop variable, finds the starting index for the desired city preset
  
  //String start = str(selCity-1); // 4 will be changed to the button value from the GUI
  //while (!buildingData[sn].substring(0, 2).equals("C" + start)) {
  //  sn ++;
  //}
  // println("final", sn, ":", buildingData[sn]);
  
  //int en = sn; // index of the last building; continue from the start index
  
  //String end = str(selCity); // represents the next city or end
  //while (!buildingData[en].substring(0, 2).equals("C" + end)) {
  //  en ++;
  //}
  //en --;
  //println("final", en, ":", buildingData[en]);
  
  //int numBuildings = en - sn;
  //println(numBuildings);
  int [] preset = findPreset(buildingData);
  
  
  int n = preset[0]; // sn starts at the preset name, 
  println ("n:", n);
  for (int i = 0; i < preset[1]; i++) {
    //println("preset",preset[0]);
    int curr = n + i;
    int yStart = buildingData[curr].indexOf("Y:") + 3;
    float y = float(buildingData[curr].substring(yStart));
    
    int xStart = buildingData[curr].indexOf("X:") + 3;
    println("index name:",buildingData[curr]);
    float x = float(buildingData[curr].substring(xStart, yStart - 4));
    //println("index:", i, "x value", x, "y value", y);
    
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
}

void generateRoads() {
  int sn = 0;
  
  
}


int [] findPreset(String [] file) { // takes in one of the fileData arrays, outputs the index of the preset name and the number of lines before the next
  int sn = 0; // emulates a for loop variable, finds the starting index for the desired city preset
  
  String start = str(selCity-1); // 4 will be changed to the button value from the GUI
  while (!file[sn].substring(0, 2).equals("C" + start)) {
    sn ++;
  }
   println("final", sn, ":", file[sn]);
  
  int en = sn; // index of the last building; continue from the start index
  
  String end = str(selCity); // represents the next city or end
  while (!file[en].substring(0, 2).equals("C" + end)) {
    en ++;
  }
  en --;
  println("final", en, ":", file[en]);
  
  int numBuildings = en - sn;
  println(numBuildings);
  
  int n = 1+sn;
  int [] output = {n, numBuildings};
  return output;
}
