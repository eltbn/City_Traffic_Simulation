boolean pause_button_option = false;

String convertionRate(float totalTime) {
 // 1 second = time/60
 // 1 minute = time/3600
 // 1 hour = time/216,000
 // 1 day = time/5,184,000
 float seconds = totalTime/60;
 float minutes = totalTime/3600;
 float hours = totalTime/216000;
 
 if (minutes >= 60) {
  minutes -= 60;
  hours += 1;
 }
 
 if (hours >= 24) {
  hours = 0; 
 }
 
 String gameTime = str(minutes + minutes);
 return gameTime;
}

String convertToTimeFormat(int time) {
  int hours = (time/10) / 60; // Extract hours
  int minutes = (time/10) % 60; // Extract minutes

  // Ensure hours and minutes are two digits
  String formattedHours = nf(hours, 2);
  String formattedMinutes = nf(minutes, 2);

  // Combine hours and minutes with ":" separator
  return formattedHours + ":" + formattedMinutes;
}

void setTime() {
 textSize(35);
 fill(204, 0, 50);
 text(convertToTimeFormat(time), 450, 600); 
}
