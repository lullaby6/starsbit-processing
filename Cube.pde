ArrayList<Cube> Cubes = new ArrayList<Cube>();
int cube_id = 0;

class Cube{
  float x, y, xs, ys, size;
  boolean del;
  int id, byai;
  Cube(float _x, float _y, float _xs, float _ys, float _size, int  id_, int byai_){
    x = _x;
    y = _y;
    xs = _xs;
    ys = _ys;
    size = _size;
    id = id_;
    byai = byai_;
  }
  void display(){
    noStroke();
    fill(255);
    rect(x, y, size, size);
  }
  void move(){
     x += xs;
     y += ys;
       if(x > width*(dimension-1)){
        del = true;
      }
      if(x < -width*(dimension-1)){
        del = true;
      }
      if(y < -height*(dimension-1)){
        del = true;
      }
      if(y > height*(dimension-1)){
        del = true;
      }
  }
}
