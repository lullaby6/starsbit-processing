
class Player{
  
  float x, y;
  float size;
  float x_os, y_os;
  
  boolean right, left, up, down; 
  
  float power, min_power, max_power;
  
  float right_power = 2, left_power = 2, up_power = 2, down_power = 2;
  
  int up_code, down_code, left_code, right_code, spin_code, shot_code, turn_code;
  
  int turned, turned_os;
  
  int delay_shot, delay_spin, time_shot = 10, time_spin = 25;
  
  boolean spin;
  float angle;
  
  boolean del;
  
  int enemy, magic = 0;
  
  Player(float x_, float y_, float size_, int up_code_, int down_code_, int left_code_, int right_code_, int spin_code_, int shot_code_, int turn_code_, int turned_, int enemy_){
    x_os = x_;
    y_os = y_;
    x = x_;
    y = y_;
    size = size_;
    up_code = up_code_;
    down_code = down_code_;
    left_code = left_code_;
    right_code = right_code_;
    spin_code = spin_code_;
    shot_code = shot_code_;
    turn_code = turn_code_;
    turned_os = turned_;
    turned = turned_;
    enemy = enemy_;
    
    min_power = size/5;
    max_power = size/1.25;
    power = size/50;
  }
  
  void display(){
    
    noStroke();
    fill(255);
    
    pushMatrix();
      translate(x, y);
      rotate(angle);
    
      float nx = -size, ny = -(size/2)*3;
      
      rect(nx, ny, size, size);
      rect(nx+size, ny, size, size);
      if(turned == -1){
        rect(nx, ny+size, size, size);
        rect(nx-size, ny+size, size, size);
      }else{
        rect(nx+size, ny+size, size, size);
        rect(nx+size*2, ny+size, size, size);
      }
      rect(nx, ny+size*2, size, size);
      rect(nx+size, ny+size*2, size, size);
    
    popMatrix();
    
  }
  
  void move(int level){
    
    if(right == true){
      x += right_power;
      
      if(right_power < max_power){
        right_power += power;
        
      }
    }else{
      
      if(right_power > min_power){
        x += right_power;
        right_power -= power;
        
      }else{
        right_power = min_power;
      }
    }
    
    if(left == true){
      x -= left_power;
      
      if(left_power < max_power){
        left_power += power;
        
      }
    }else{
      
      if(left_power > min_power){
        x -= left_power;
        left_power -= power;
        
      }else{
        left_power = min_power;
      }
    }
    
    if(up == true){
      y -= up_power;
      
      if(up_power < 8){
        up_power += power;
        
      }
    }else{
      
      if(up_power > min_power){
        y -= up_power;
        up_power -= power;
        
      }else{
        up_power = min_power;
      }
    }
    
    if(down == true){
      y += down_power;
      
      if(down_power < max_power){
        down_power += power;
        
      }
    }else{
      
      if(down_power > min_power){
        y += down_power;
        down_power -= power;
        
      }else{
        down_power = min_power;
      }
    }
    
    if(spin == true){
      if(turned == 1){
        if(angle < 6){
          angle += 0.35;
        }else if(angle >= 6){
          angle = 0;
          spin = false;
        }
      }else{
        if(angle > -6){
          angle -= 0.35;
        }else if(angle <= -6){
          angle = 0;
          spin = false;
        }
      }
    }
    
    if(x > width*(dimension-1)){
      x = width*(dimension-1);
    }
    if(x < -width*(dimension-1)){
      x = -width*(dimension-1);
    }
    if(y < -height*(dimension-1)){
      y = -height*(dimension-1);
    }
    if(y > height*(dimension-1)){
      y = height*(dimension-1);
    }
    
    if(delay_shot > 0){
      delay_shot -= 1;
    }
    
    if(delay_spin > 0){
      delay_spin -= 1;
    }
    
    if(level > 0){
      
      for(int i = 0; i < Cubes.size(); i++){
        Cube cube = Cubes.get(i);
        if(dist(cube.x, cube.y, x, y) < 60 && spin == false && delay_spin == 0 && cube.byai == 0){
          spin = true;
          delay_spin = time_spin;
        }
      }
      
      if(enemy == 1 && player1.del == false){
              
        if((dist(player1.y, player1.y, y, y) < 5 || (dist(player1.y, player1.y, y, y) > 100) && dist(player1.y, player1.y, y, y) < 130) && delay_shot == 0){
          if(turned == 1){
            Cubes.add(new Cube(x+size*2, y-size/2, (size/2)*3, 0, size, cube_id, 1));
          }else{
            Cubes.add(new Cube(x-size*3, y-size/2, -(size/2)*3, 0, size, cube_id, 1));
          }
          cube_id += 1;
          delay_shot = time_shot;
          laser.stop();
          laser.play();
        }
        
        if(dist(player1.x, player1.y, x, y) < 50 && spin == false && delay_spin == 0){
          spin = true;
          delay_spin = time_spin;
        }
        
        if(x > player1.x){
          left = true;
          right = false;
          turned = -1;
          
        }else{
          right = true;
          left = false;
          turned = 1;
          
        }
        
        if(magic > 0){
          magic -= 1;
        }
        if(magic == 0){
          if(y > player1.y){
            up = true;
            down = false;
            
          }else{
            down = true;
            up = false;
            
          }
        }
        
        if(level > 1){
          if(dist(player1.x, player1.y, x, y) < 425){
            right = false;
            left = false;
          }
          if(dist(player1.x, player1.y, x, y) < 250){
            right = false;
            left = false;
            if(x > player1.x){
              left = false;
              right = true;
              
            }else{
              right = false;
              left = true;
              
            }
          }
        }
        
        if(level > 2){
          for(int i = 0; i < Cubes.size(); i++){
            Cube cube = Cubes.get(i);
            if(dist(cube.x, cube.y, x, y) < 200 && cube.byai == 0 && ((cube.xs > 0 && cube.x < x)||(cube.xs < 0 && cube.x > x))){
              if(player1.y > y){
                down = false;
                up = true;
              }else{
                up = false;
                down = true;
              }
              if(player1.x > x){
                right = false;
                left = true;
              }else{
                left = false;
                right = true;
              }
              magic = 20;
            }
          }
        }
        
      }
      if(enemy == 2 && player2.del == false){
              
        if(dist(player2.y, player2.y, y, y) < 5 && delay_shot == 0){
          if(turned == 1){
            Cubes.add(new Cube(x+size*2, y-size/2, (size/2)*3, 0, size, cube_id, 1));
          }else{
            Cubes.add(new Cube(x-size*3, y-size/2, -(size/2)*3, 0, size, cube_id, 1));
          }
          cube_id += 1;
          delay_shot = time_shot;
          laser.stop();
          laser.play();
        }
        
        if(dist(player2.x, player1.y, x, y) < 50 && spin == false && delay_spin == 0){
          spin = true;
          delay_spin = time_spin;
        }
        
        if(x > player2.x){
          left = true;
          right = false;
          turned = -1;
          
        }else{
          right = true;
          left = false;
          turned = 1;
          
        }
        
        if(y > player2.y){
          up = true;
          down = false;
          
        }else{
          down = true;
          up = false;
          
        }
        
        if(level > 1){
          if(dist(player2.x, player2.y, x, y) < 425){
            right = false;
            left = false;
          }
          if(dist(player2.x, player2.y, x, y) < 250){
            right = false;
            left = false;
            if(x > player2.x){
              left = false;
              right = true;
              
            }else{
              right = false;
              left = true;
              
            }
          }
        }
        
        if(level > 2){
          for(int i = 0; i < Cubes.size(); i++){
            Cube cube = Cubes.get(i);
            if(dist(cube.x, cube.y, x, y) < 200 && cube.byai == 0 && ((cube.xs > 0 && cube.x < x)||(cube.xs < 0 && cube.x > x))){
              if(player2.y > y){
                down = false;
                up = true;
              }else{
                up = false;
                down = true;
              }
              if(player2.x > x){
                right = false;
                left = true;
              }else{
                left = false;
                right = true;
              }
              magic = 20;
            }
          }
        }
        
      }
    }
  }
  
  void keyPressed(){
    
    if(keyCode == right_code){
      right = true;
    }
    
    if(keyCode == left_code){
      left = true;
    }
    
    if(keyCode == up_code){
      up = true;
    }
    
    if(keyCode == down_code){
      down = true;
    }
    
    if(keyCode == shot_code && delay_shot == 0 && delay_text == 0){
        if(turned == 1){
          Cubes.add(new Cube(x+size*2, y-size/2, (size/2)*3, 0, size, cube_id, 0));
        }else{
          Cubes.add(new Cube(x-size*3, y-size/2, -(size/2)*3, 0, size, cube_id, 0));
        }
        cube_id += 1;
        delay_shot = time_shot;
        laser.stop();
        laser.play();
    }
    
    if(keyCode == turn_code && delay_text == 0){
      turned *= -1;
    }
    
    if(keyCode == spin_code && spin == false && delay_spin == 0 && delay_text == 0){
      spin = true;
      delay_spin = time_spin;
    }
    
  }
  
  void keyReleased(){
    
    if(keyCode == right_code){
      right = false;
    }
    
    if(keyCode == left_code){
      left = false;
    }
    
    if(keyCode == up_code){
      up = false;
    }
    
    if(keyCode == down_code){
      down = false;
    }
    
  }
  
  void reset(){
    x = x_os;
    y = y_os;
    turned = turned_os;
    del = false;
    up = false;
    down = false;
    right = false;
    left = false;
    spin = false;
    angle = 0;
    up_power = 0;
    down_power = 0;
    left_power = 0;
    right_power = 0;
    delay_shot = 0;
    delay_spin = 0;
  }
  
  void explode(float _xs){
    _xs /= 1.5;
    
    Cubes.add(new Cube(x-size, y+size/2, _xs, random(-1, 1), size, -1, 0));
    Cubes.add(new Cube(x, y+size/2, _xs, random(-1, 1), size, -1, 0));
    
    Cubes.add(new Cube(x-size, y-(size/2)*3, _xs, random(-1, 1), size, -1, 0));
    Cubes.add(new Cube(x, y-(size/2)*3, _xs, random(-1, 1), size, -1, 0));
    
    if(turned == 1){
      Cubes.add(new Cube(x, y-size/2, _xs, random(-1, 1), size, -1, 0));
      Cubes.add(new Cube(x+size, y-size/2, _xs, random(-1, 1), size, -1, 0));
      
    }else{
      Cubes.add(new Cube(x-size*2, y-size/2, _xs, random(1, 1), size, -1, 0));
      Cubes.add(new Cube(x-size, y-size/2, _xs, random(1, 1), size, -1, 0));;
      
    }
  
  }
  
}
