
final float RESOLUTION = 200; //200 steps per rotation

enum State {
  ACCELERATING,
    TRAVELING,
    DECCELERATING,
    STOPPED
}




class Stepper {
  //Display
  int x, y;
  ArrayList<Point> plot;
  color col;

  //Control
  State currentState;

  float position, target;     //Absolute Steps
  float travel, distanceToGo, accelDistance; //Relative Steps
  float speed, targetSpeed; //Steps / min
  float accel;              //Steps / min²
  
  long lastStep;

  float maxSpeed;
  float maxAccel;

  Stepper(int _x, int _y, color _col) {
    col = _col;
    x = _x;
    y = _y;
    plot = new ArrayList<Point>();

    currentState = State.STOPPED;
    maxSpeed = VMAX;
    maxAccel = AMAX;
    
    lastStep = 0;
    travel = 0;
    distanceToGo = 0;
    position = 0;
    target = 0;
    speed = 0;
    targetSpeed = 0;
    accel = 0;
  }

  void SetAccel(float v) {
    accel = v;
  }

  void SetMaxAccel(float v) {
    maxAccel = v;
  }

  void SetSpeedTarget(float v) {
    targetSpeed = v;
  }

  void SetMaxSpeed(float v) {
    maxSpeed = v;
  }

  void SetTarget(float v) {
    target = v;
  }

  void Plot() {
    plot.add(toPoint(position, speed));
    drawLines(toLine(plot), col);
    drawPoints(plot, col);
  }


  float SpeedToDelay() { //Milliseconds
    float value = (60.0/speed) * 1000.0; //remove last 60
    println(value);
    return value;
  }
  
  float GetAngle() { //Radians
    float twoPi = 2.0 * 3.141592865358979;
    float angle = position*(twoPi/RESOLUTION);
    return angle - twoPi * floor( angle / twoPi );
  }

  void Run() {
    switch(currentState) {
    case ACCELERATING:
      if (travel >= accelDistance) currentState = State.TRAVELING;
      break;
    case TRAVELING:
      if (travel >= distanceToGo - (accelDistance)) currentState = State.DECCELERATING;
      break;
    case DECCELERATING:
      if (travel >= distanceToGo){
        //travel = distanceToGo;
        //position = target;
        currentState = State.STOPPED;
      }
      break;
    case STOPPED:
      if (position != target) {
        currentState = State.ACCELERATING;
        travel = 0;
        distanceToGo = target - position;
        accelDistance = targetSpeed/accel;
      }
      break;
    }
    
    println("time : " + time );
    
    if(speed == 0 || time - lastStep >= SpeedToDelay()) Step();
  }

  void Step() {
    lastStep = time;
    switch(currentState) {
    case ACCELERATING:
      speed += accel;//Raise speed by acceleration

      travel++;
      position++;//One more step

      break;
    case TRAVELING:

      travel++;
      position++;//One more step

      break;
    case DECCELERATING:
      speed -= accel;//Raise speed by acceleration
      if(speed <= 0) speed = 0;

      travel++;
      position++;//One more step

      break;
    case STOPPED:

      break;
    }
  }

  String GetStateString() {
    switch(currentState) {
    case ACCELERATING:
      return "Accelerating";
    case TRAVELING:
      return "traveling";
    case DECCELERATING:
      return "Deccelerating";
    case STOPPED:
      return "Stopped";
    }
    return "?";
  }


  void Draw() {

    pushMatrix();
    translate(x, y);
    stroke(0);

    fill(10);
    pushMatrix();
    translate(-50, -(50 + 25));
    shapeMode(CENTER);
    beginShape();
    vertex(0, 0);
    vertex(100, 0);
    vertex(125, 25);
    vertex(125, 125);
    vertex(100, 150);
    vertex(0, 150);
    vertex(-25, 125);
    vertex(-25, 25);
    vertex(0, 0);
    endShape();

    fill(100);
    translate(-10, -10);
    beginShape();
    vertex(0, 0);
    vertex(100, 0);
    vertex(125, 25);
    vertex(125, 125);
    vertex(100, 150);
    vertex(0, 150);
    vertex(-25, 125);
    vertex(-25, 25);
    vertex(0, 0);
    endShape();

    popMatrix();

    translate(-10, -10);

    fill(120);
    ellipse(0, 0, 100, 100); //Shaft


    noStroke();
    fill(200);
    ellipse(0, 0, 20, 20); //Shaft
    fill(120);

    pushMatrix();
    rotate(GetAngle());
    rect(-28, -10, 20, 20);
    stroke(col);
    strokeWeight(3);
    line(0, 0, -50, 0);
    strokeWeight(1);
    popMatrix();


    stroke(255);
    fill(255);
    text(GetStateString(), 50, 100);
    text(position, 50, 120);
    text(speed, 50, 140);
    text(accel, 50, 160);
    
    popMatrix();
  }
};
