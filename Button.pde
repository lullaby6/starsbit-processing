boolean mouse;

Button play;
Button options;
Button exit;
Button resume;
Button retry;
Button quit;
Button again;

Button player1b;
Button player2b;
Button back;

class Button{
  
  float x, y, w;
    
  int id;
  
  String text;
  
  color c;
    
  Button(float x_, float y_, String text_, int id_, float w_){
    x = x_;
    y = y_;
    w = w_;
    text = text_;
    id = id_;
    c = color(255, 255, 255, 0);
  }
  void display(){
    fill(255);
    text(text, x+(height/2.1)/1.15/2-(textWidth(text)/2), y+(((player1.size/2)*10)/3));
    if(mouseX > x && mouseX < x+(height/2.1)/1.15 && mouseY < y+(height/2.5)/6 && mouseY > y-(((player1.size/2)*10)/2)){
      if(mouse){
        ButtonPressed(id);
      }
      c = color(255, 255, 255, 15);
      //c = color(255, 0, 0, 255);
    }else{
      c = color(255, 255, 255, 0);
    }
    fill(c);
    rect(x, y-(((player1.size/2)*10)/2), (height/2.1)/1.15, (height/2.5)/3.5);
  }
  
}

void ButtonPressed(int id){
  
  if(id == 1){
    playing = true;
    reset();

  }else if(id == 2){;
    option = true;
  }else if(id == 3){
    exit();
    
  }else if(id == 4){
    theme_state = 1;
    pause = false;
    
  }else if(id == 5){
    pause = false;
    playing = false;
    player1.reset();
    player2.reset();
    mouse = false;
    tx = 0;
    ty = 0;
    vibrate_fase = 0;
    theme_state = 2;
    camera_target_x = 0;
    camera_target_y = 0;
    smooth_camera_target_x = 0;
    smooth_camera_target_y = 0;
    Cubes.clear();
  }else if(id == 6){
    reset();
  }else if(id == 7){
    if(player1b.text == "Player 1"){
      player1b.text = "AI 1";
      player1_ia_level = 1;
    }else if(player1b.text == "AI 1"){
      player1b.text = "AI 2";
      player1_ia_level = 2;
    }else if(player1b.text == "AI 2"){
      player1b.text = "AI 3";
      player1_ia_level = 3;
    }else if(player1b.text == "AI 3"){
      player1b.text = "Player 1";
      player1_ia_level = 0;
    }
  }else if(id == 8){
    if(player2b.text == "Player 2"){
      player2b.text = "AI 1";
      player2_ia_level = 1;
    }else if(player2b.text == "AI 1"){
      player2b.text = "AI 2";
      player2_ia_level = 2;
    }else if(player2b.text == "AI 2"){
      player2b.text = "AI 3";
      player2_ia_level = 3;
    }else if(player2b.text == "AI 3"){
      player2b.text = "Player 2";
      player2_ia_level = 0;
    }
  }else if(id == 9){
    option = false;
  }else if(id == 10){
    reset();
  }
  menu.play();
  mouse = false;
}


void mousePressed(){
   mouse = true;
}

void mouseReleased(){
   mouse = false;
}
