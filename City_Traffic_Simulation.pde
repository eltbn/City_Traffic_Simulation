import g4p_controls.*;

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
}


void draw() {
  background(0);
  
  
}
