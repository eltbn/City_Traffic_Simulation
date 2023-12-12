boolean pause_button_option = false;


String convertToTimeFormat(float totalTime) {
  float seconds = totalTime; // Calculate seconds
  //println(seconds);
  int minutes = floor(seconds / 60) % 60; // Extract minutes
  int hours = floor(seconds / 3600) % 24; // Extract hours
  if (seconds/86400 == 1) {
    seconds = 0;
  }

  String gameTime = nf(hours, 2) + ":" + nf(minutes, 2); // create string as displayed time 
  return gameTime;
}

void setTime() {
 textSize(35);
 fill(204, 0, 50);
 text(convertToTimeFormat(time), 450, 600); 
}
