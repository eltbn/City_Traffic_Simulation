/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:window1:701500:
  appc.background(230);
} //_CODE_:window1:701500:

public void Time_Changed(GSlider source, GEvent event) { //_CODE_:Time_Scale:418764:
  speedUpFactor = Time_Scale.getValueF();
  //println("Time_Speed - GSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:Time_Scale:418764:

public void Time_Changed_Title(GTextField source, GEvent event) { //_CODE_:Time_Scale_Title:224194:
} //_CODE_:Time_Scale_Title:224194:

public void Pause_Start(GButton source, GEvent event) { //_CODE_:Pause_Button:630141:
  if (pause_button_option == false) {
   pause_button_option = true;
   Pause_Button.setText("RESUME");
   noLoop();
  }
  else {
   pause_button_option = false;
   Pause_Button.setText("PAUSE");
   loop();
  }
} //_CODE_:Pause_Button:630141:

public void Preset_Changed(GDropList source, GEvent event) { //_CODE_:Preset_Selector:642755:
  selCity = int(Preset_Selector.getSelectedText().substring(5));

  resetCity();  
} //_CODE_:Preset_Selector:642755:

public void TrafficSpawned(GButton source, GEvent event) { //_CODE_:TrafficSpawner:621476:
  spawnTraffic();
} //_CODE_:TrafficSpawner:621476:

public void button1_click1(GButton source, GEvent event) { //_CODE_:BatchSpawn:779496:
  for (int b = 0; b < batchAmt; b++) {
    spawnTraffic(); 
  }
} //_CODE_:BatchSpawn:779496:

public void AmountTrafficChanged(GSlider source, GEvent event) { //_CODE_:BatchAmount:247318:
  batchAmt = BatchAmount.getValueI();
} //_CODE_:BatchAmount:247318:

public void BatchAmountIndicator(GTextField source, GEvent event) { //_CODE_:Batch_Amount_Scale:423078:
  println("Batch_Amount_Scale - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:Batch_Amount_Scale:423078:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  window1 = GWindow.getWindow(this, "Window title", 0, 0, 240, 360, JAVA2D);
  window1.noLoop();
  window1.setActionOnClose(G4P.KEEP_OPEN);
  window1.addDrawHandler(this, "win_draw1");
  Time_Scale = new GSlider(window1, 10, 30, 190, 40, 10.0);
  Time_Scale.setShowValue(true);
  Time_Scale.setShowLimits(true);
  Time_Scale.setLimits(1.0, 0.5, 10.0);
  Time_Scale.setNbrTicks(5);
  Time_Scale.setNumberFormat(G4P.DECIMAL, 0);
  Time_Scale.setOpaque(false);
  Time_Scale.addEventHandler(this, "Time_Changed");
  Time_Scale_Title = new GTextField(window1, 9, 10, 120, 17, G4P.SCROLLBARS_NONE);
  Time_Scale_Title.setText("Time Scale");
  Time_Scale_Title.setOpaque(true);
  Time_Scale_Title.addEventHandler(this, "Time_Changed_Title");
  Pause_Button = new GButton(window1, 73, 94, 80, 30);
  Pause_Button.setText("PAUSE");
  Pause_Button.addEventHandler(this, "Pause_Start");
  Preset_Selector = new GDropList(window1, 70, 147, 90, 100, 4, 10);
  Preset_Selector.setItems(loadStrings("list_642755"), 0);
  Preset_Selector.addEventHandler(this, "Preset_Changed");
  TrafficSpawner = new GButton(window1, 24, 256, 80, 30);
  TrafficSpawner.setText("Spawn Traffic");
  TrafficSpawner.addEventHandler(this, "TrafficSpawned");
  BatchSpawn = new GButton(window1, 130, 256, 80, 30);
  BatchSpawn.setText("Batch Spawn");
  BatchSpawn.addEventHandler(this, "button1_click1");
  BatchAmount = new GSlider(window1, 52, 204, 139, 51, 10.0);
  BatchAmount.setShowValue(true);
  BatchAmount.setShowLimits(true);
  BatchAmount.setLimits(1, 1, 5);
  BatchAmount.setNbrTicks(5);
  BatchAmount.setStickToTicks(true);
  BatchAmount.setShowTicks(true);
  BatchAmount.setNumberFormat(G4P.INTEGER, 0);
  BatchAmount.setOpaque(false);
  BatchAmount.addEventHandler(this, "AmountTrafficChanged");
  Batch_Amount_Scale = new GTextField(window1, 59, 182, 120, 19, G4P.SCROLLBARS_NONE);
  Batch_Amount_Scale.setText("Batch amount");
  Batch_Amount_Scale.setOpaque(true);
  Batch_Amount_Scale.addEventHandler(this, "BatchAmountIndicator");
  window1.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow window1;
GSlider Time_Scale; 
GTextField Time_Scale_Title; 
GButton Pause_Button; 
GDropList Preset_Selector; 
GButton TrafficSpawner; 
GButton BatchSpawn; 
GSlider BatchAmount; 
GTextField Batch_Amount_Scale; 
