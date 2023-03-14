

float T1, T2, P1, P2, V1, V2, A1, A2;
float VMAX = 4000, 
      AMAX = 100;

float speedToPixel;
float stepsToPixel;

ArrayList<Point> points;
ArrayList<Point> motor1;
ArrayList<Point> motor2;

enum State{
  ACCELERATING,
  TRAVELING,
  DECCELERATING, 
  STOPPED
}

State motor1State = State.ACCELERATING;
State motor2State = State.ACCELERATING;

void setup(){
  size(1080, 720);
  
  speedToPixel = 8000.0/height;
  stepsToPixel = 2000.0/width;
  
  T1 = 1000;
  T2 = 300;
  
  P1 = 0;
  V1 = 0;
  A1 = 0;
   

  
  points = new ArrayList<Point>();
  motor1 = new ArrayList<Point>();
  motor2 = new ArrayList<Point>();
  
  points.add(toPoint(0,0));
  points.add(toPoint(0.2 * T1, 4000));
  points.add(toPoint(0.8 * T1, 4000));
  points.add(toPoint(T1, 0));
  
  
  
  
  
  //Init Speed and accel
  if(0.2*T1 <= VMAX/AMAX){ //We don't have time to reach max speed
    A1 = AMAX;
    float maxV1 = 0.5*T1*A1;
    A2 = maxV1/(0.2*T2); //We accelerate 
  }else{                 //We will reach max speed
    A1 = VMAX/(0.2*T1);  //Acceleration  to VMAX in 20% of the travel
    float tRatio = T2/T1;
    float targetV2 = tRatio * VMAX;
    A2 = targetV2/(0.2*T2);  //Acceleration  to VMAX in 20% of the travel
  }
}



void draw(){
  background(200);
  stroke(20);
  noFill();
  translate(200,200+ height/2);
  

  step();
  
  motor1.add(toPoint(P1, V1));
  motor2.add(toPoint(P2, V2));
  
  drawPoints(motor1);
  drawPoints(motor2);
  drawPoints(points);
  drawLines(toLine(points));
}

void step(){
   //Compute speed and position
  
  switch(motor1State){
   case ACCELERATING: 
     V1 += A1;//Raise speed by acceleration
     P1 += 1;//One more step
     if(P1 >= 0.2*T1) motor1State = State.TRAVELING;
     
   break;
   case TRAVELING: 
     V1 += 0;//0 acceleration
     P1 += 1;//One more step
     if(P1 >= 0.8*T1) motor1State = State.DECCELERATING;
    
   break;
   case DECCELERATING: 
     V1 -= A1;//Raise speed by acceleration
     P1 += 1;//One more step
     if(P1 >= T1) motor1State = State.STOPPED;
     
   break;
   case STOPPED:
     P1 += 0;//One more step
   
   break;
    
  }
  
  switch(motor2State){
   case ACCELERATING: 
     V2 += A2;//Raise speed by acceleration
     P2 += 1;//One more step
     if(P2 >= 0.2*T2) motor2State = State.TRAVELING;
     
   break;
   case TRAVELING: 
     V2 += 0;//Raise speed by acceleration
     P2 += 1;//One more step
     if(P2 >= 0.8*T2) motor2State = State.DECCELERATING;
   break;
   
   case DECCELERATING: 
     V2 -= A2;//Raise speed by acceleration
     P2 += 1;//One more step
     if(P2 >= T2) motor2State = State.STOPPED;
   break;
   
   case STOPPED:
     P2 += 0;//One more step
   
   break;
    
  } 
  
}
