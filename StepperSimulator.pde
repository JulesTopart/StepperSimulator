

int VMAX = 1000, 
    AMAX = 100;

float speedToPixel;
float stepsToPixel;

Stepper motorA, motorB;

void setup(){
  size(1080, 720);
  
  motorA = new Stepper(100,100);
  motorB = new Stepper(300,100);
  
  motorA.SetAccel(AMAX);
  motorA.SetSpeedTarget(VMAX);
  motorA.SetTarget(1000);
  
  speedToPixel = 8000.0/height;
  stepsToPixel = 2000.0/width;
}



void draw(){
  background(200);
  stroke(20);
  noFill();
  
  pushMatrix();
  translate(200,200+ height/2);
  motorA.Plot();
  motorB.Plot();
  popMatrix();
  
  motorA.Run();
  motorB.Run();
  
  motorA.Draw();
  motorB.Draw();
  

  
}
