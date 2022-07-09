
class Astar{
    grid g;
    PriorityQueue<cell> frontier;
    boolean finished = false;
    Path p;
    Astar(grid g){
      this.g = g;
      this.p = new Path(g.h);
      frontier = new PriorityQueue<>((a,b)-> int(a.gValue + heuristic(a) - b.gValue - heuristic(b)));
      frontier.add(g.getStart());
    }
    void next(){
       //println("**********************************");
       
      if(!finished && !frontier.isEmpty()){
           cell c = frontier.poll();
           //g.aboutCell(c,"Removed");
           
           if(!g.isStart(c) && !g.isGoal(c))
           c.setType(TYPE.CLOSED);
           if(g.isGoal(c)){finished = true;return;}
           ArrayList<cell> neighbours = g.getNeighbours(g.getId(c),false);
           for(cell neighbour:neighbours){
               //g.aboutCell(neighbour,"Found");
               float tentative_g = c.gValue + g.weight(c,neighbour,c.parent);
               if(tentative_g  < neighbour.gValue){
                   if(frontier.contains(neighbour))
                     frontier.remove(neighbour);
                   neighbour.setParent(c);
                   neighbour.gValue = tentative_g;
                   if(!g.isGoal(neighbour))
                   neighbour.setType(TYPE.OPENED);
                   frontier.add(neighbour);
                   //g.aboutCell(neighbour,"Added");
                   
               }
               //else if(!frontier.contains(neighbour)){
               //    g.aboutCell(neighbour,"Added");
               //    frontier.add(neighbour);
               //    neighbour.setType(TYPE.OPENED);
               //}
           }  
       }
    }
    void drawPath(){
      if(!finished)return;
      ArrayList<cell> path = new ArrayList<cell>();
      cell current = g.getGoal();  
      while(current.parent != null){
            path.add(current);
            current = current.parent;
      }
      path.add(current);
      p.drawPath(path);
    }
    float heuristic1(cell c){return 0;}
    float heuristic(cell c){
       int x = g.getX(c),y = g.getY(c);
       int gx = g.getX(g.getGoal()),gy = g.getY(g.getGoal());
       return abs(gx-x) + abs(gy-y);
    }
}
