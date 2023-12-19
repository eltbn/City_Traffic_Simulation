boolean pause_button_option = false;


String convertToTimeFormat(float totalTime) {
  String Meridiem; // AM or PM
  float displayTime = totalTime + 21600;
  
  int minutes = floor(displayTime / 60) % 60; // Extract minutes
  int hours = floor(displayTime / 3600) % 24; // Extract hours
  if (totalTime/86400 == 1) {
    totalTime = 0;
  }
  if (hours < 12) {
    Meridiem = "AM"; 
  }
  else {
    Meridiem = "PM";
  }
  
  String gameTime = nf(hours%12, 2) + ":" + nf(minutes, 2) + " "+Meridiem; // create string as displayed time 
  return gameTime;
}

void setTime() {
 textSize(35);
 fill(204, 0, 50);
 text(convertToTimeFormat(time), 450, 600); 
}
