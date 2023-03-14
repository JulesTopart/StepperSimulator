
ArrayList<Line> toLine(ArrayList<Point> pts){
  ArrayList<Line> result = new ArrayList<Line>();
  
  if(pts.size() <= 1) return result;
  
  for(int i = 1; i < pts.size(); i++){
    result.add(new Line(pts.get(i-1), pts.get(i) ));
    
  }
 return result;
}

void drawLines(ArrayList<Line> lines){
  for(Line l : lines){
    l.Draw();
  }
}

void drawPoints(ArrayList<Point> pts){
  for(Point l : pts){
    l.Draw();
  }
}


Point toPoint(float steps, float speed){
   int Y = -int(speed / speedToPixel);
   int X = int(steps / stepsToPixel);
     
   return new Point(X,Y);
}

class Point{
  int X, Y;
  
  Point(int x, int y){
    
     X = x;
     Y = y;
     
  }
  
  void Draw(){
    strokeWeight(5);
    stroke(180,50,0);
    fill(180,50,0);
    
    point(X,Y);
  }
  
  
};


class Line{
  Point A, B;
  
  Line(Point a, Point b){
    A = a;
    B = b;
  }
  
  
  Line(int xA, int yA, int xB, int yB){
    A = new Point(xA, yA);
    B = new Point(xB, yB);
  }
  
  void Draw(){
    strokeWeight(1);
    stroke(52);
    noFill();
    
    line(A.X, A.Y, B.X, B.Y);
  }
  
}
