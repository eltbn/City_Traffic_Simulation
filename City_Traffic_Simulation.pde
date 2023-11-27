import g4p_controls.*;

String [] roadData;
String [] BuildingData;

void setup() {
  size(600, 600);
  createGUI();
  String [] fileData = loadStrings("a.txt"); // represents the current file which that is imported
  roadData = new String [fileData.length];
  roadData = fileData;
}
