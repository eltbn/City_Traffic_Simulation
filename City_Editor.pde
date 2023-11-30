// not sure if this will be a feature but would be useful for making preset cities in the files
void mousePressed() {
  if (Builder) {
    
    
  }
  
}

void makeRoad() {
  
  // road constructor here
  
}


void keyPressed() {
  if (key == 'l') {
    selCity = 2;
    println(selCity);
    reset();
  }
  else {
    selCity = 1;
    println(selCity);
    reset();
  }
  
}
