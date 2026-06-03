
import controlP5.*;

int spaceW = 102, spaceH = 102;

PGraphics pg;
int drawMode = 0;

boolean isPaused = false, isObserved = false, normColor = true;

ControlP5 cp5;
PFont font;

void setup() {
  size(800, 600);
  surface.setResizable(false);
  surface.setCursor(CROSS);
  
  // ((PGraphicsOpenGL)g).textureSampling(3);
  noSmooth();
  
  font = createFont("Arial", 12);
  textFont(font);
  textAlign(LEFT, TOP);
  
  pg = createGraphics(spaceW, spaceH);
  cp5 = new ControlP5(this);
  
  setupUI();
  
  init();
}

void draw() {
  background(20);
  
  pg.beginDraw();
  for(int j = 0; j < spaceH; j++) {
    for(int i = 0; i < spaceW; i++) {
      float phase = psi[i][j].heading();
      
      if(phase < 0) phase += TWO_PI;
      
      color drawColor = 0;
      
      switch(drawMode) {
        case 0:
        drawColor = colFromAng(phase, psi[i][j].mag() / maxAmpl);
        break;
        
        case 1:
        float drawProb = psi[i][j].magSq() / (maxAmpl * maxAmpl);
        drawColor = color(drawProb * 255);
        break;
      }
      
      pg.stroke(red(drawColor) + max(V[i][j], 0) * 255, green(drawColor), blue(drawColor) - min(V[i][j], 0) * 255, 255);
      pg.point(i, j);
    }
  }
  pg.endDraw();
  
  if(!isPaused && !isObserved) update();
  normalize();
  
  int x1 = 0, y1 = 0;
  int x2 = height, y2 = height;
  
  float aspect = (float)spaceW / spaceH;
  
  if(aspect >= 1) {
    x1 = 0;
    x2 = height;
    
    int imgHeight = round(height / aspect);
    
    y1 = height / 2 - imgHeight / 2;
    y2 = height / 2 + imgHeight / 2;
    
    image(pg, x1, y1, height, imgHeight);
  } else {
    y1 = 0;
    y2 = height;
    
    int imgWidth = round(height * aspect);
    
    x1 = height / 2 - imgWidth / 2;
    x2 = height / 2 + imgWidth / 2;
    
    image(pg, x1, y1, imgWidth, height);
  }
  proceedTools(x1, y1, x2, y2);
  
  updateUI();
}

void keyPressed() {
  switch(key) {
    case ' ':
    cp5.get(Toggle.class, "isPaused").setValue(1 - cp5.get(Toggle.class, "isPaused").getValue());
    break;
    
    case '>':
    case '.':
    timespeed *= 1.05;
    break;
    
    case '<':
    case ',':
    timespeed /= 1.05;
    break;
    
    case '!':
    case '1':
    cp5.get(RadioButton.class, "viewMode").setValue(0);
    break;
    
    case '@':
    case '2':
    cp5.get(RadioButton.class, "viewMode").setValue(1);
    break;
    
    case ')':
    case '0':
    observe();
    break;
    
    case '~':
    case '`':
    // There may will be a console window
    break;
  }
}

void init() {
  for(int j = 0; j < spaceH; j++) {
    for(int i = 0; i < spaceW; i++) {
      psi[i][j] = new PVector();
    }
  }
  
  psi[spaceW / 4][spaceH / 2] = new PVector(1, 0);
  isObserved = false;
}

void update() {
  dt = timespeed / frameRate; // Simpliest time system
  nextStep(dt);
  t += dt;
}

void proceedTools(int x1, int y1, int x2, int y2) {
  int mousePosX = floor(map(mouseX, x1, x2, 0, spaceW));
  int mousePosY = floor(map(mouseY, y1, y2, 0, spaceH));
  
  if(mousePosX > spaceW - 1 || mousePosX < 0) mousePosX = -1;
  if(mousePosY > spaceH - 1 || mousePosY < 0) mousePosY = -1;
  
  pg.beginDraw();
  pg.stroke(255, 255, 192);
  pg.point(mousePosX, mousePosY);
  pg.endDraw();
  
  if(mousePosX != -1 && mousePosY != -1) {
    float phase = psi[mousePosX][mousePosY].heading();
        
    if(phase < 0) phase += TWO_PI;
    
    text("\u03C8 = " + psi[mousePosX][mousePosY] +
         "\nArg(\u03C8) = " + degrees(phase) + "\u00B0" +
         "\n|\u03C8| = " + psi[mousePosX][mousePosY].mag() +
         "\n|\u03C8|\u00B2 = " + psi[mousePosX][mousePosY].magSq() * 100 + "%", mouseX + 5, mouseY - 5);
  }
}
