float VMAX = 100, 
      AMAX = 1;

float speedToPixel;
float stepsToPixel;

int time = 0;

Controller controller;

void setup(){
  size(1080, 720);
  
  speedToPixel = 4000.0/height;
  stepsToPixel = 2000.0/width;
  
  controller = new Controller();
  controller.move(800,400,100);
  
  thread("compute"); 
  thread("updateTime"); 

  
}



void draw(){
  background(200);
  stroke(20);
  noFill();
  controller.Draw();

  
}

void compute(){
  while(true){
    controller.Run();
  }
}


void updateTime(){
  while(true){
    time++;
    for(int i = 0; i < 10000; i++);
  }
}
