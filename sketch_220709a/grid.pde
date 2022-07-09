

class grid{
    int num_cells_x,num_cells_y;
    int startId,goalId;
    float h,w; // dimensions of each cell
    cell[] array;
    float grid_x,grid_y;
    boolean shuffle = true;
    
    grid(float grid_x,float grid_y,int num_cells_x,int num_cells_y,float w,float h){
        this.num_cells_x = num_cells_x;
        this.num_cells_y = num_cells_y;
        this.w = w;
        this.h = h;
        
        this.grid_x = grid_x;
        this.grid_y = grid_y;
        
        if(shuffle)
        shuffle();
        else{
          startId = 0;goalId = num_cells_x*num_cells_y-1;
        }
        
        array = new cell[num_cells_x*num_cells_y];
        
        for(int i = 0;i<num_cells_x*num_cells_y;i++){
          TYPE t = TYPE.NONE;
          float x = grid_x + (i%num_cells_x)*w,y = grid_y + (i/num_cells_x)*h;
          if(i == startId){t = TYPE.START;}
          else if(i == goalId){t = TYPE.GOAL;}
          
          array[i] = new cell(x,y,w,h);
          array[i].setType(t);
          
        }
        
        
        
    }
    int getId(float x,float y){
        int i = int(x / w);
        int j = int(y / h);
        
        return j*num_cells_x + i;
    }
    int getId(cell c){
      return getId(c.x,c.y);
    }
    // returns all neighbours that are not walls;
    ArrayList<cell> getNeighbours(int id,boolean diagonal){
        ArrayList<cell> ret = new ArrayList<cell>();
        boolean top = false,left = false,right = false,bottom = false;
        if(id > 0 && (id % num_cells_x != 0)){if(!isWall(id-1))ret.add(array[id-1]);left = true;}
        if(id < num_cells_x*num_cells_y - 1  && (id +1 )%num_cells_x != 0){if(!isWall(id+1))ret.add(array[id+1]);right = true;}
        if(id / num_cells_x != 0){if(!isWall(id-num_cells_x))ret.add(array[id-num_cells_x]);top = true;}
        if(id / num_cells_x < num_cells_y - 1){if(!isWall(id+num_cells_x))ret.add(array[id+num_cells_x]);bottom = true;}
        
        if(diagonal){
            if(top && left && !isWall(id-1-num_cells_x))ret.add(array[id-1-num_cells_x]);
            if(top && right && !isWall(id+1-num_cells_x))ret.add(array[id+1-num_cells_x]);
            if(bottom && left && !isWall(id-1+num_cells_x))ret.add(array[id-1+num_cells_x]);
            if(bottom && right && !isWall(id+1+num_cells_x))ret.add(array[id+1+num_cells_x]);
        }
        return ret;
    }
    boolean isWall(int id){
        return array[id].type == TYPE.WALL;     
    }
    boolean isWall(cell c){
        return isWall(getId(c));
    }
    void setType(int id,TYPE t){
        if(array[id].type == TYPE.START && t == TYPE.GOAL)return;
        if(array[id].type == TYPE.GOAL && t == TYPE.START)return;
        array[id].setType(t);
    }
    void setPosition(float x,float y){
      this.grid_x = x;
      this.grid_y = y;
    } 
    void shuffle(){
       this.startId = int(random(num_cells_x*num_cells_y));
       while(true){
         this.goalId = int(random(num_cells_x*num_cells_y));
         if(this.goalId != this.startId)break;
       }
    }
    DIRECTION getDirection(cell from,cell to){
        int x = getId(from),y = getId(to);
        if(y-x == 1)return DIRECTION.RIGHT;
        else if(y-x == -1)return DIRECTION.LEFT;
        else if(y-x == num_cells_x)return DIRECTION.BOTTOM;
        else if(y-x == -1*num_cells_x)return DIRECTION.TOP;
        else if(y-x == 1+num_cells_x)return DIRECTION.BOTTOMRIGHT;
        else if(y-x == -1+num_cells_x)return DIRECTION.BOTTOMLEFT;
        else if(y-x == -1-num_cells_x)return DIRECTION.TOPLEFT;
        else if(y-x == 1-num_cells_x)return DIRECTION.TOPRIGHT;
        else return DIRECTION.TOOFAR;
    }
    float weight(int from,int to){
        return 1;
    }
    float weight(cell from,cell to){
      return weight(getId(from),getId(to));
    }
    float weight(cell from,cell to,cell prev){
        if(prev == null)return 1;
        else if(isWall(to))return Float.POSITIVE_INFINITY;
        else{
            if(getDirection(prev,from) == getDirection(from,to) && getDirection(from,to)!=DIRECTION.TOOFAR){
                return 1;
            }
            else{
                return 2;
            }
        }
    }
    cell getStart(){
        return array[startId];
    }
    cell getGoal(){
        return array[goalId];
    }
    
    
    boolean isStart(int id){return id == startId;}
    boolean isStart(cell c){return isStart(getId(c));}
    boolean isGoal(int id){return id == goalId;}
    boolean isGoal(cell c){return isGoal(getId(c));}
    
    void clearWalls(){
        for(cell c: array){
            if(c.type == TYPE.WALL){c.setType(TYPE.NONE);}
        }
    }
    void resetGrid(){
      for(cell c:array){
        c.reset();
      }
    
    }
    int getX(cell c){
       return getId(c) % num_cells_x;
    }
    int getY(cell c){
       return getId(c) / num_cells_y; 
    }
    void aboutCell(cell c,String s){
      println("Cell Id: " + getId(c) + " is " + s);
      println("\t gValue: "+ c.gValue);
    }
    void draw(){
       for(cell c:array){
         c.draw();
       }
    }

}
