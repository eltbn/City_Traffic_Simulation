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

void setTime() {
 textSize(35);
 fill(204, 0, 50);
 text(convertionRate(time), 450, 600); 
}
