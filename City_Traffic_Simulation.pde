import g4p_controls.*;

int roadSize = 20; // for the demo, not sure if this will be a variable for roads
int selCity = 1; // put this into the GUI later



int time = 0; // this will be the global time variable used, 1 second = 60 seconds | time = 0 -> 60, time in game = 00:00 -> 00:01
float speedUpFactor = 1;
String inGameTime = "00:00"; // not going to be a string, just a placeholder
int frameRate = 60;

boolean Builder; // for building a city or choosing a preset city

String [] roadData;
String [] buildingData;

ArrayList <Road> Roads = new ArrayList<Road>();
ArrayList <Building> Buildings = new ArrayList<Building>();
ArrayList <Traffic> People = new ArrayList<Traffic>();

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
  
  
  
  

  
  Traffic test = new Traffic(new PVector(0, 200), 2);
  People.add(test);
  generateRoads();
  generateBuildings();
  //println
  
}


void draw() {
  background(255);
  frameRate(frameRate);
 // fill(255);
 
  for (Road currRoad : Roads) {
    currRoad.drawRoad();
  }
  
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
    int yStart = buildingData[curr].indexOf("Y:") + 3;
    float y = float(buildingData[curr].substring(yStart));
    
    int xStart = buildingData[curr].indexOf("X:") + 3;
    println("index name:",buildingData[curr]);
    float x = float(buildingData[curr].substring(xStart, yStart - 4));
    //println("index:", i, "x value", x, "y value", y);
    
    char buildType = buildingData[curr].charAt(3); // takes the character of the inputted number in the string
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

//void checkHorizontal(); // roads will have a horizontla variable to skip 


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
  clear();
  generateRoads();
  generateBuildings();
  
}
