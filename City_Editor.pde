// not sure if this will be a feature but would be useful for making preset cities in the files
void mousePressed() {
  //if (Builder) {
    
    
  //}
  println(mouseX, mouseY);
}

void makeRoad() {
  
  //Road(
  
}


void keyPressed() {
  if (key == 'l') {
    spawnTraffic();
  }
}


void spawnTraffic () {
  Intersection randSpawn = spawnPoints.get(int(random(0,spawnPoints.size())));
  PVector spawnPos = randSpawn.Pos.copy();
  
  Traffic newTraffic = new Traffic (spawnPos, 1, randSpawn);
  People.add(newTraffic);
}
