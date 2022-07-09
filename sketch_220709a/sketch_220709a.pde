
import java.util.*;
cell c;

enum TYPE {
    START,
    GOAL,
    CLOSED,
    OPENED,
    NONE,
    PATH,
    WALL;    
}
enum DIRECTION{
    TOP,
    LEFT,
    RIGHT,
    BOTTOM,
    TOPRIGHT,
    TOPLEFT,
    BOTTOMRIGHT,
    BOTTOMLEFT,
    TOOFAR;
}
HashMap<String,Integer> colorOf; 



grid g;
Astar a;
void setup(){
    colorOf = new HashMap<String,Integer>();
  
    colorOf.put(TYPE.START.name(),color(161,247,152));
    colorOf.put(TYPE.GOAL.name(),color(217,111,126));
    colorOf.put(TYPE.CLOSED.name(),color(11,102,181));
    colorOf.put(TYPE.OPENED.name(),color(0,221,255));
    colorOf.put(TYPE.NONE.name(),color(255,255,255));
    colorOf.put(TYPE.PATH.name(),color(223,216,73));
    colorOf.put(TYPE.WALL.name(),color(0,0,0));
  
  
    size(800,800);
    
    float w = 20,h = 20;
    int numx = 30,numy = 30; 
    g = new grid(w/2,h/2,numx,numy,w,h);
    a = new Astar(g);
}
void draw(){
  
    background(255);
    strokeWeight(1);
    //a.next();
    
    g.draw();
    a.drawPath();
    //p.drawPath();
    
}
void mousePressed(){
    int id = g.getId(mouseX,mouseY);
    if(!g.isStart(id) && !g.isGoal(id)){
        g.setType(id,TYPE.WALL);
    }
}
void keyPressed(){
    if(key == ' '){
        a.next();
    }
}
