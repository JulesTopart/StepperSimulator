
ArrayList<Line> toLine(ArrayList<Point> pts){
  ArrayList<Line> result = new ArrayList<Line>();
  
  if(pts.size() <= 1) return result;
  
  for(int i = 1; i < pts.size(); i++){
    result.add(new Line(pts.get(i-1), pts.get(i) ));
    
  }
 return result;
}

void drawLines(ArrayList<Line> lines, color c){
  for(Line l : lines){
    l.Draw(c);
  }
}

void drawPoints(ArrayList<Point> pts, color c){
  for(Point l : pts){
    l.Draw(c);
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
  
  void Draw(color c){
    strokeWeight(3);
    stroke(c);
    
    point(X,Y);
    strokeWeight(1);
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
  
  void Draw(color c){
    strokeWeight(1);
    stroke(c);
    noFill();
    
    line(A.X, A.Y, B.X, B.Y);
  }
  
}
