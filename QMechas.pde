
PVector[][] psi = new PVector[spaceW][spaceH];
float[][]   V   = new float  [spaceW][spaceH];

float m = 1, dx = sqrt(2) / 2; // h / (2 * pi) = 1
float t = 0, dt = 0, timespeed = 1.0;

float maxAmpl;

void nextStep(float dt) {
  PVector[][] laplacian = new PVector[spaceW][spaceH];
  
  for(int j = 0; j < spaceH; j++) {
    for(int i = 0; i < spaceW; i++) {
      /* laplacian(psi[i][j]) = (psi[i - 1][j] +
                                 psi[i + 1][j] +
                                 psi[i][j - 1] +
                                 psi[i][j + 1] -
                                4 * psi[i][j]) / (dx * dx)
      */
      
      laplacian[i][j] = new PVector();
      
      PVector psiNextX = new PVector();
      PVector psiPrevX = new PVector();
      PVector psiNextY = new PVector();
      PVector psiPrevY = new PVector();
      
      if(i < spaceW - 1) psiNextX = psi[i + 1][j];
      if(i > 0) psiPrevX = psi[i - 1][j];
      if(j < spaceH - 1) psiNextY = psi[i][j + 1];
      if(j > 0) psiPrevY = psi[i][j - 1];
      
      laplacian[i][j].add(psiNextX);
      laplacian[i][j].add(psiPrevX);
      laplacian[i][j].add(psiNextY);
      laplacian[i][j].add(psiPrevY);
      laplacian[i][j].sub(PVector.mult(psi[i][j], 4));
      laplacian[i][j].div(dx * dx);
    }
  }
  
  for(int j = 0; j < spaceH; j++) {
    for(int i = 0; i < spaceW; i++) {
      // dpsi[i][j] / dt = i / (2 * m) * laplacian(psi[i][j]) - i * potential(i, j) * psi[i][j];
      
      laplacian[i][j].div(2 * m);                            // laplacian(psi[i][j]) / (2 * m)
      laplacian[i][j].sub(PVector.mult(psi[i][j], V[i][j])); // laplacian(psi[i][j]) / (2 * m)     - V[i][j] * psi[i][j]
      laplacian[i][j].rotate(HALF_PI);                       // laplacian(psi[i][j]) / (2 * m) * i - V[i][j] * psi[i][j] * i = dpsi[i][j] / dt
      
      // psi[i][j](t + dt) = psi[i][j] + dpsi[i][j] / dt * dt
      
      psi[i][j].add(PVector.mult(laplacian[i][j], dt)); 
    }
  }
}

void normalize() {
  float sum = 0.0;
  
  for(int j = 0; j < spaceH; j++) {
    for(int i = 0; i < spaceW; i++) {
      sum += psi[i][j].magSq();
    }
  }
  
  sum = sqrt(sum);
  
  maxAmpl = 0;
  
  for(int j = 0; j < spaceH; j++) {
    for(int i = 0; i < spaceW; i++) {
      psi[i][j].div(sum);
      if(normColor) maxAmpl = max(psi[i][j].mag(), maxAmpl);
      else maxAmpl = 1;
    }
  }
}

void observe() {
  float probability = 0;
  float random = random(0, 1);
  
  for(int j = 0; j < spaceH; j++) {
    for(int i = 0; i < spaceW; i++) {
      probability += psi[i][j].magSq();
      
      if(random < probability) {
        timespeed = 0;
        
        for(int n = 0; n < spaceH; n++) {
          for(int m = 0; m < spaceW; m++) {
            psi[m][n] = new PVector();
          }
        }
        
        psi[i][j] = new PVector(1, 0);
        isObserved = true;
        return;
      }
    }
  }
}
