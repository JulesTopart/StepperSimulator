
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


  //Control
  State currentState;

  int position, target;     //Absolute Steps
  int travel, distanceToGo; //Relative Steps
  float speed, targetSpeed; //Steps / min
  float accel;              //Steps / min²
  
  long lastStep;

  float maxSpeed;
  float maxAccel;

  Stepper(int _x, int _y) {
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

  void SetAccel(int v) {
    accel = float(v);
  }

  void SetMaxAccel(int v) {
    maxAccel = float(v);
  }

  void SetSpeedTarget(int v) {
    targetSpeed = float(v);
  }

  void SetMaxSpeed(int v) {
    maxSpeed = float(v);
  }

  void SetTarget(int v) {
    target = v;
  }

  void Plot() {
    plot.add(toPoint(position, speed));
    drawLines(toLine(plot));
    drawPoints(plot);
  }


  float SpeedToDelay() { //Milliseconds
    return (60.0/speed) * 1000.0;
  }
  
  float GetAngle() { //Radians
    float twoPi = 2.0 * 3.141592865358979;
    float angle = position*(twoPi/RESOLUTION);
    return angle - twoPi * floor( angle / twoPi );
  }

  void Run() {
    switch(currentState) {
    case ACCELERATING:
      if (speed >= targetSpeed) currentState = State.TRAVELING;
      break;
    case TRAVELING:
      if (travel >= 0.8*distanceToGo) currentState = State.DECCELERATING;
      break;
    case DECCELERATING:
      if (speed <= 0) currentState = State.STOPPED;
      break;
    case STOPPED:
      if (position != target) {
        currentState = State.ACCELERATING;
        travel = 0;
        distanceToGo = target - position;
      }
      break;
    }
    
    if(speed == 0 || millis() - lastStep > SpeedToDelay())
      Step();
  }

  void Step() {
    lastStep = millis();
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
    stroke(255, 0, 0);
    line(0, 0, -50, 0);
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
