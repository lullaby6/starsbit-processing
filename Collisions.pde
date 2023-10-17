void Collisions(){
  
  if(dist(player1.x, player1.y-5, player2.x, player2.y-5) < (player1.size/2)*5 && player1.del == false && player2.del == false){
    if(player1.spin == false){
      player1.del = true;
      player1.explode(random(-7.5, 7.5));
      vibrate_fase = 1;
      exp.play();
    }
    if(player2.spin == false){
      player2.del = true;
      player2.explode(random(-7.5, 7.5));
      vibrate_fase = 1;
      exp.play();
    }
  }
  
  for(int i = 0; i < Cubes.size(); i++){
    
    Cube cube = Cubes.get(i);
    if(cube.id > -1){
      if(dist(cube.x, cube.y, player1.x, player1.y-5) < player1.size*2 && player1.spin == false && player1.del == false){
        player1.del = true;
        player1.explode(cube.xs);
        Cubes.remove(i);
        vibrate_fase = 1;
        exp.play();
      }
      
      if(dist(cube.x, cube.y, player2.x, player2.y-5) < player1.size*2 && player2.spin == false && player2.del == false){
        player2.del = true;
        player2.explode(cube.xs);
        Cubes.remove(i);
        vibrate_fase = 1;
        exp.play();
      }
      
      for(int i2 = 0; i2 < Cubes.size(); i2++){
        Cube cube2 = Cubes.get(i2);
        if(cube2.id > -1){
          if(dist(cube.x, cube.y, cube2.x, cube2.y) < player1.size/2 && cube.id != cube2.id){
            vibrate_fase = 1;
            exp.play();
            Cubes.clear();
          }
        }
      }
      
    }
  }
  
}
