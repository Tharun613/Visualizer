class Path{
    float h;
    Path(float h){this.h = h;}
    void drawPath(ArrayList<cell> path){
        for(int i = 0;i<path.size()-1;i++){
            stroke(colorOf.get(TYPE.PATH.name()));
            strokeWeight(h*0.1);
            line(path.get(i).x,path.get(i).y,path.get(i+1).x,path.get(i+1).y);
        }
    }
    

}
