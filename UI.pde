
void setupUI() {
  cp5.addSlider("timespeedMultiplier")
     .setPosition(605, 20)
     .setSize(150, 15)
     .setRange(-0.2, 0.2)
     .setValue(0)
     .setColorBackground(color(255, 100))
     .setColorForeground(color(255, 150))
     .setLabel("")
     .setSliderMode(Slider.FLEXIBLE)
     .setFont(font)
     .onRelease(new CallbackListener() {
       void controlEvent(CallbackEvent event) {
         cp5.get(Slider.class, "timespeedMultiplier").setValueLabel("Inc Timespeed");
         cp5.get(Slider.class, "timespeedMultiplier").setValue(0);
       }
     });
  cp5.addRadioButton("viewMode")
     .setPosition(605, 75)
     .setSize(15, 15)
     .setColorBackground(color(255, 100))
     .setColorForeground(color(255, 150))
     .addItem("Magnitude + Phase", 0)
     .addItem("Probabilities", 1)
     .activate(0)
     .setFont(font);
  cp5.addToggle("isPaused")
     .setPosition(605, 40)
     .setSize(15, 15)
     .setColorBackground(color(255, 100))
     .setColorForeground(color(255, 150))
     .setCaptionLabel("Pause").getCaptionLabel().align(ControlP5.LEFT, ControlP5.RIGHT_OUTSIDE).setPaddingX(20)
     .setFont(font);
  cp5.addButton("realTime")
     .setPosition(width - 40, 20)
     .setSize(35, 15)
     .setColorBackground(color(255,100))
     .setColorForeground(color(255,150))
     .setLabel("Real")
     .setFont(font);
  cp5.addButton("reverseTime")
     .setPosition(width - 65, 40)
     .setSize(60, 15)
     .setColorBackground(color(255,100))
     .setColorForeground(color(255,150))
     .setLabel("Reverse")
     .setFont(font);
  cp5.addToggle("normColor")
     .setPosition(725, 75)
     .setSize(15, 15)
     .setColorBackground(color(255, 100))
     .setColorForeground(color(255, 150))
     .setCaptionLabel("Norm\nColor").getCaptionLabel().align(ControlP5.LEFT, ControlP5.RIGHT_OUTSIDE).setPaddingX(20)
     .setFont(font);
  cp5.addButton("takeImg")
     .setPosition(height + 5, 125)
     .setSize(80, 15)
     .setColorBackground(color(255,100))
     .setColorForeground(color(255,150))
     .setLabel("Save Image")
     .setFont(font);
  cp5.addButton("observe")
     .setPosition(height + 5, 145)
     .setSize(80, 15)
     .setColorBackground(color(255,100))
     .setColorForeground(color(255,150))
     .setLabel("Observe")
     .setFont(font);
}

void updateUI() {
  fill(255);
  
  if(isPaused) text("FPS: " + frameRate + 
                    "\nt: " + t +
                    "\nTimespeed: " + timespeed +
                    "\n\u0394t: " + dt + " (paused)", 5, 5);
  else text("FPS: " + frameRate + 
            "\nt: " + t +
            "\nTimespeed: " + timespeed +
            "\n\u0394t: " + dt, 5, 5);
  
  text("Simulation Settings:", height + 5, 5);
  text("View Mode:", height + 5, 60);
  text("Tools:", height + 5, 110);
  // text("New Simulation Settings:", height + 5, 165);
  
  // cp5.get(Button.class, "measure").setPosition(height + 5, 20);
  timespeed *= 1 + cp5.get(Slider.class, "timespeedMultiplier").getValue();
  cp5.get(Slider.class, "timespeedMultiplier").setValueLabel("Timespeed: " + nfp(cp5.get(Slider.class, "timespeedMultiplier").getValue() * 100, 2, 2) + "%");
  
  drawMode = (int)cp5.get(RadioButton.class, "viewMode").getValue();
}
