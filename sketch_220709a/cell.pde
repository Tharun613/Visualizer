

class cell{
  float h,w;
  float x,y; //location of the center of the cell.
  color fillColor;
  
  float gValue;
  
  TYPE type;
  cell parent;
  
  cell(float loc_x,float loc_y, float x_dimension,float y_dimension){
     this.h = y_dimension;
     this.w = x_dimension;
     this.x = loc_x;
     this.y = loc_y;
     this.parent = null;
     this.gValue = Float.POSITIVE_INFINITY;
  }
  void setParent(cell c){
      this.parent = c;
  }
  void setType(TYPE type){
    this.type = type;
    this.fillColor = colorOf.get(type.name());
    
    if(type == TYPE.START){gValue = 0;parent=null;}
  }
  
  void draw(){
    rectMode(CENTER);
    stroke(0);
    fill(fillColor);
    rect(x,y,w,h);
  }
  
  void reset(){
    this.parent = null;
    if(!(this.type == TYPE.START || this.type == TYPE.GOAL || this.type == TYPE.WALL)){
         this.setType(TYPE.NONE);
    }
    gValue = Float.POSITIVE_INFINITY;
  }
}
