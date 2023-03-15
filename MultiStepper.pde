
    
class Controller{
  
 Stepper A, B, C;
 
 Controller(){
    A = new Stepper(100,100, color(255,0,0));
    B = new Stepper(300,100, color(50,255,10));
    C = new Stepper(500,100, color(120,10,255));
 }
 
 
 
 void move(int tA, int tB, int tC){

    float U1 = tA;
    float U2 = tB;
    float U3 = tC;
    
    float V1 = VMAX;
    float V2;
    float V3;
    
    float A1 = AMAX;
    float A2 = AMAX;
    float A3 = AMAX;
    
    float Ua1 = V1 / A1; //Equation 2
    float alpha = (1 / V1) * (U1 - Ua1); //Equation 1
    
    V2 = (U2 * A2) / (A2 * alpha + 1);
    V3 = (U3 * A3) / (A3 *  alpha + 1);
    
    A.SetAccel(A1);
    A.SetSpeedTarget(V1);
    A.SetTarget(U1 + A.position);
    
    B.SetAccel(A2);
    B.SetSpeedTarget(V2);
    B.SetTarget(U2 + B.position);
    
    //C.SetAccel(A3);
    //C.SetSpeedTarget(V3);
    //C.SetTarget(U3 + C.position);
   
 }
 
 
 void Run(){
   A.Run();
   B.Run();
   C.Run();
 }
 
 
 void Draw(){
   
  pushMatrix();
  translate(200,200+ height/2);
  A.Plot();
  B.Plot();
  //C.Plot();
  popMatrix();
   
  A.Draw();
  B.Draw();
  //C.Draw();
 }
  
 
  
  
}
