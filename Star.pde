ArrayList<Star> Stars = new ArrayList<Star>();

class Star{
  float x, y, s, v, d, rmd;
  color c, ac;
  Star(float _x, float _y, color _c, float _s, float _v){
    x = _x;
    y = _y;
    c = _c;
    ac = _c;
    s = _s;
    v = _v;
    d = 0;
    rmd = random(20, 50);
  }
  void display(){
    noStroke();
    fill(c);
    rect(x, y, s, s);
  }
  void move(){
    if(d < rmd){
      d++;
    }else{
      d = 0;
      if(c == ac){
        c = color(255);
      }else{
        c = ac;
      }
    }
    x -= v;
    if(x < -width*dimension){
      reset();
    }
  }
  void reset(){
    x = width*dimension;
    y = random(-height*dimension, height*dimension);
    s = random(2.5, 7.5);
    c = color(random(0, 255), random(0, 255), random(0, 255), random(100, 225));
    v = random(0.05, 2);
    rmd = random(20, 50);
    d = 0;
  }
}
