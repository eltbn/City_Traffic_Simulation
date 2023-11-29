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
  println("Speed Up Factor:", speedUpFactor);
  //println("Time_Speed - GSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:Time_Scale:418764:

public void Time_Changed_Title(GTextField source, GEvent event) { //_CODE_:Time_Scale_Title:224194:
} //_CODE_:Time_Scale_Title:224194:

public void button1_click1(GButton source, GEvent event) { //_CODE_:button1:630141:
  println("button1 - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:button1:630141:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  window1 = GWindow.getWindow(this, "Window title", 0, 0, 240, 240, JAVA2D);
  window1.noLoop();
  window1.setActionOnClose(G4P.CLOSE_WINDOW);
  window1.addDrawHandler(this, "win_draw1");
  Time_Scale = new GSlider(window1, 10, 30, 190, 40, 10.0);
  Time_Scale.setShowValue(true);
  Time_Scale.setShowLimits(true);
  Time_Scale.setLimits(1.0, 0.5, 3.0);
  Time_Scale.setNbrTicks(5);
  Time_Scale.setNumberFormat(G4P.DECIMAL, 0);
  Time_Scale.setOpaque(false);
  Time_Scale.addEventHandler(this, "Time_Changed");
  Time_Scale_Title = new GTextField(window1, 9, 10, 120, 17, G4P.SCROLLBARS_NONE);
  Time_Scale_Title.setText("Time Scale");
  Time_Scale_Title.setOpaque(true);
  Time_Scale_Title.addEventHandler(this, "Time_Changed_Title");
  button1 = new GButton(window1, 80, 110, 80, 30);
  button1.setText("PAUSE");
  button1.addEventHandler(this, "button1_click1");
  window1.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow window1;
GSlider Time_Scale; 
GTextField Time_Scale_Title; 
GButton button1; 
