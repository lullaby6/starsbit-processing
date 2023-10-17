import processing.sound.*;

SoundFile laser;
SoundFile exp;
SoundFile theme;
SoundFile menu;

float theme_state;
float theme_pause_de = 0.025;
float theme_in_game_volume = 0.2;
float theme_amp = 1;

int reset_code = 82;
int pause_code = 80;
boolean pause;

int play_time;
int delay_text = 3;
boolean option;

boolean playing;

int fullscreen_code = 107;
boolean fullscreen = true, started = false;

PFont TitleFont;
PFont ButtonFont;

Player player1;
Player player2;
int player1_ia_level = 0;
int player2_ia_level = 0;

PImage icon;

int dimension = 15;

void settings(){
  fullScreen(P2D, 2);
  //size(900, 500, P2D);
}

void setup(){
  
  surface.setResizable(true);
  
  player1 = new Player(width/60, height/2, dimension, 87, 83, 65, 68, 66, 86, 67, 1, 2);
  player2 = new Player(width/1.25, height/2, dimension, 38, 40, 37, 39, 44, 77, 46, -1, 1);
  
  play = new Button(width/17.5+((width/3.75)/15), height/2+((height/2)/6.5), "Play", 1, 70);
  options = new Button(width/17.5+((width/3.75)/15), height/2+((height/2)/6.5)+((player1.size/2)*10)*1+(player1.size/2)*1.7, "Options", 2, 45);
  exit = new Button(width/17.5+((width/3.75)/15), height/2+((height/2)/6.5)+((player1.size/2)*10)*2+(player1.size/2)*3.4, "Exit", 3, 70);
  
  resume = new Button(width/17.5+((width/3.75)/15), height/2+((height/2)/6.5), "Resume", 4, 50);
  retry = new Button(width/17.5+((width/3.75)/15), height/2+((height/2)/6.5)+((player1.size/2)*10)*1+(player1.size/2)*1.7, "Retry", 10, 60);
  quit = new Button(width/17.5+((width/3.75)/15), height/2+((height/2)/6.5)+((player1.size/2)*10)*2+(player1.size/2)*3.4, "Quit", 5, 70);
  
  again = new Button(width/17.5+((width/3.75)/15), height/2+((height/2)/6.5), "Play Again", 6, 22.5);
  
  player1b = new Button(width/17.5+((width/3.75)/15), height/2+((height/2)/6.5), "Player 1", 7, 40);
  player2b = new Button(width/17.5+((width/3.75)/15), height/2+((height/2)/6.5)+((player1.size/2)*10)*1+(player1.size/2)*1.7, "Player 2", 8, 38.5);
  back = new Button(width/17.5+((width/3.75)/15), height/2+((height/2)/6.5)+((player1.size/2)*10)*2+(player1.size/2)*3.4, "Back", 9, 70);
  
  TitleFont = createFont("data/wendy.ttf", (player1.size/2)*25);
  ButtonFont = createFont("data/wendy.ttf", (player1.size/2)*10);
  
  icon = loadImage("data/icon.png");
  surface.setIcon(icon);
  surface.setResizable(false);
  
  laser = new SoundFile(this, "data/laser.wav");
  exp = new SoundFile(this, "data/exp.wav");
  menu = new SoundFile(this, "data/menu.wav");
  theme = new SoundFile(this, "data/theme.wav");
  
  if(started == false){
    theme.loop();
    for(int i = 0; i < 5000; i++){
      Stars.add(new Star(random(-width*dimension, width*dimension), random(-height*dimension, height*dimension), color(random(0, 255), random(0, 255), random(0, 255), random(100,225)), random(2.5, 7.5), random(0.05, 2)));
    }
    started = true;
  }
  
  background(0, 0, 15);
  
  frameRate(60);
  
}

void draw(){
  fill(0, 0, 15, 100);
  rect(0, 0, width, height);
  //background(0, 0, 15);
  
  theme.amp(theme_amp);
  
  if(theme_state == 1){
    if(theme_amp > theme_in_game_volume){
      theme_amp -= theme_pause_de;
    }
  }else if(theme_state == 2){
    if(theme_amp < 1){
      theme_amp += theme_pause_de;
    }
  }
  
  if (vibrate_fase == 1){
    vibrate(7.5, 15);
  }
  
  if(playing == false){
    
    textFont(ButtonFont);
    if(option == true){
      player1b.display();
      player2b.display();
      back.display();
    }else{
      play.display();
      options.display();
      exit.display();
    }
        
    noStroke();
    fill(255, 255, 255, 15);
    rect(width/17.5, height/2, width/3.75, height/2.5);
        
    textFont(TitleFont);
    fill(255);
    text("Starsbit", width/17.5, height/3.25);
    
  }
  
  if(player1.del || player2.del){
    
    textFont(ButtonFont);
    noStroke();
    fill(255, 255, 255, 15);
    //rect(50, 250, 240, 200);
    rect(width/17.5, height/2, width/3.75, height/2.5);
    cursor(ARROW);
    if(option == true){
      player1b.display();
      player2b.display();
      back.display();
    }else{
      again.display();
      options.display();
      quit.display();
    }
    
  }
  
  if(pause == true){
    
    textFont(ButtonFont);
    resume.display();
    retry.display();
    quit.display();
    noStroke();
    fill(255, 255, 255, 15);
    rect(width/17.5, height/2, width/3.75, height/2.5);
    
  }else{
    if(player1.del == false && player2.del == false){
      Camera(player1.x, player1.y, player2.x, player2.y);
    }
    if(player1.del){
      Camera(player2.x, player2.y, player2.x, player2.y);
    }
    if(player2.del){
      Camera(player1.x, player1.y, player1.x, player1.y);
    }
  }

  pushMatrix();
        
    translate(camera_target_x + tx, camera_target_y + ty);
      
    for(int i = 0; i < Stars.size(); i++){
      Star star = Stars.get(i);
      star.display();
      star.move();
    }
        
    if(player1.del == false){
      player1.display();
    }
    if(player2.del == false){
      player2.display();
    }
      
    for(int i = 0; i < Cubes.size(); i++){
      Cube cube = Cubes.get(i);
      cube.display();
    }
    
    if(playing){
      if(play_time <= 150){
        textFont(ButtonFont);
        fill(255);
        text(str(delay_text), width/2.5, height/2+20);
      }
    }
          
    if(pause == false && playing == true){
        
      if(player1.del == false && delay_text == 0){
        player1.move(player1_ia_level);
      }
        
      if(player2.del == false && delay_text == 0){
        player2.move(player2_ia_level);
      }
      
      for(int i = 0; i < Cubes.size(); i++){
        Cube cube = Cubes.get(i);
        cube.move();
        if(cube.del == true){
          Cubes.remove(i);
        }
      }
      
      if(play_time <= 150){
        if(play_time == 50){
          menu.play();
          delay_text -= 1;
        }else if(play_time == 100){
          menu.play();
          delay_text -= 1;
        }
        else if(play_time == 150){
          menu.play();
          delay_text -= 1;
        }
        play_time += 1;
      }
      
      Collisions();
        
    }
        
  popMatrix();
  
}

void reset(){
  pause = false;
  Cubes.clear();
  player1.reset();
  player2.reset();
  tx = 0;
  ty = 0;
  vibrate_fase = 0;
  theme_state = 1;
  smooth_camera_target_x = player1.x/2 + player2.x/2;
  smooth_camera_target_y = player1.y/2 + player2.y/2;
  camera_target_x = player1.x/2 + player2.x/2;
  camera_target_y = player1.y/2 + player2.y/2;
  play_time = 0;
  delay_text = 3;
  noCursor();
}

void keyPressed(){
  
  if(keyCode == fullscreen_code){
    if(fullscreen == true){
      fullscreen = false;
      surface.setSize(900, 500);
      surface.setLocation(displayWidth/2 - width/2, displayHeight/2 - height/2);
      dimension = 10;
      setup();
    }else{
      fullscreen = true;
      surface.setSize(displayWidth, displayHeight);
      surface.setLocation(0, 0);
      dimension = 15;
      setup();
    }
  }
  
  if(key == ESC) {
    if(playing == true){
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
      cursor(ARROW);
    }else{
      exit();
    }
    key = 0;
  }
  
  if(keyCode == pause_code && playing == true  && player1.del == false && player2.del == false){
    if(pause == true){
      pause = false;
      noCursor();
      theme_state = 1;
    }else{
      pause = true;
      cursor(ARROW);
      theme_state = 2;
    }
  }
  
  if(keyCode == reset_code && playing == true){
    reset();
  }
  
  if(playing == true && pause == false){
    if(player1.del == false){
      player1.keyPressed();
    }
    if(player2.del == false){
      player2.keyPressed();
    }
  } 
}

void keyReleased(){
  if(playing == true){
    if(player1.del == false){
      player1.keyReleased();
    }
    if(player2.del == false){
      player2.keyReleased();
    }
  }
}
