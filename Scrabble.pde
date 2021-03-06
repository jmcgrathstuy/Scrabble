Board brd, tempBrd;
Sack sck;
Player p, playerOne, playerTwo, playerThree, playerFour, winner;
ArrayList<Player> players;
PFont f;
int boxWidth, boxHeight, scr, numPlayers, curPlayer;
Piece selectedPiece;
int selectedPieceSpot, turnPoints, w, turn, tadd;
PImage bg;
BufferedReader reader;
String line;
ArrayList<String> dict;
boolean canStart, canEnd;

//SETUP
//DRAW


//PLAYER
//BOARD
//PIECE
//SACK

public void setup(){
  size(673, 600);
  sck = new Sack();
  brd = new Board();
  tempBrd = new Board();
  players = new ArrayList<Player>();
 // p = new Player("Jack");
  dict = new ArrayList<String>();
  reader = createReader("dict.txt");
  //p.fillHand(sck);
  f = createFont("Arial", 16, true);
  boxWidth = 35;
  boxHeight = 35;
  turnPoints = 0;
  turn = 0;
  tadd = 1;
  scr = 0;
  canStart = true;
  for( int i = 0; i < 58109; i++){
  try{
    line = reader.readLine();
  } catch (IOException e){
    e.printStackTrace();
    line = null;
  }
  if( line == null){
    noLoop();
  } else{
    dict.add(line);
  }
  }
  
}

public void mouseReleased(){
  if( ( mouseX > 536 && mouseX < 663 && ( mouseY > 102 && mouseY < 182)) && p.getHand().size() < 7 && canEnd){
    //println(brd.verifyInt(dict));
   //if( brd.verify( dict)){
   //if( brd.verHoriz(dict, 0, 0)){
   if( brd.verifyInt(dict) > 0){
      delay(2500);
      for( Piece[] pa : brd.getBoard()){
        for( Piece pi: pa){
          if( pi != null){
            pi.setRemovable(false);
          }
        }
      }
      tadd = 1;
      canStart = true;
      canEnd = false;
      for( String s : brd.allWords){
       /* if( brd.setWords.indexOf(s) == -1){
          p.addScore( brd.wordValue(s));
        }*/
        brd.setWords.add(s);
      }
      p.addScore(turnPoints);
      if( curPlayer == numPlayers - 1){
        curPlayer = 0;
      }else{
        curPlayer++;
      }
      p = players.get(curPlayer);
      

      
   }else{
     for( Piece[] pa : brd.getBoard()){
        for( Piece pi: pa){
          if( pi != null){
            if( pi.isRemovable()){
              p.addPiece(brd.removePiece(pi.getR(), pi.getC()));
            }
          }
        }
      }
     
     
   }
    turnPoints = 0;
  }
  if( ( mouseX > 536 && mouseX < 663 && ( mouseY > 195 && mouseY < 276)) && p.getHand().size() == 7 && canEnd){
    delay(2500);
    tadd = 1;
    canStart = true;
    canEnd = false;
    if( curPlayer == numPlayers - 1){
        curPlayer = 0;
    }else{
      curPlayer++;
    }
    p = players.get(curPlayer);
  }
  
}

void keyPressed(){
  if( keyCode == CONTROL && scr == 0){
    scr++;
  }
  if( key == TAB){
    int highest = 0;
    for( Player pe : players){
      if( pe.getScore() >= highest){
        highest = pe.getScore();
        winner = pe;
      }
    }
    scr++;
  }
  if( key == '1' || key == '2' || key == '3' || key == '4'){
      canStart = true;
      numPlayers = Character.getNumericValue(key);
      for( int i = 0; i < numPlayers; i++){
        if( i == 0){
          playerOne = new Player("Player 1");
          players.add(playerOne);
          p = playerOne;
          curPlayer = 0;
        }
        if( i == 1){
          playerTwo = new Player("Player 2");
          players.add(playerTwo);
        }
        if( i == 2){
          playerThree = new Player("Player 3");
          players.add(playerThree);
        }
        if( i == 3){
          playerFour = new Player("Player 4");
          players.add(playerFour);
        }
    }
  }
  }
  
  

public void draw(){
  switch(scr){
    case 0:
    textSize(30);
    text("Press the key that corresponds to the number\n of players (1-4), then press CTRL", 0, 100);
    text("To end the game and crown a winner, press\n TAB", 0, 300);
    break;
    case 1:
  bg = loadImage("WWFBoard.png");
  background(bg);
  int a = 5;
  //int a = 0;
  textFont(f, 16);
  fill(0);
  textSize(18);
  text( "You're up,", 545, 345);
  text( p.getName() + "!", 545, 364);
  text( "Turn: " + turn, 545, 295);
  text( "Tiles left: " + sck.size(), 545, 315);
  text( "Score: " + p.getScore(), 545, 395);
  for( Piece s : p.getHand()){
    s.setX( a);
    s.setY( 532);
    //s.setY(0);
    a += 70;
    //a += 35;
    s.display();
    //PIECE SELECTION
    if( ((  mouseX > ( s.getX()) && mouseX < (s.getX() + 60)) && ( mouseY > ( s.getY()) && mouseY < (s.getY() + 60))) && mousePressed){
      selectedPiece = s;
      selectedPieceSpot = p.getHand().indexOf(s);
    }
      
  }
  for( int rc = 0; rc < 15; rc++){
    for( int cc = 0; cc < 15; cc++){
      if( brd.getBoard()[rc][cc] == null){
        fill( 0, 0.0);
        rect( cc * boxWidth, rc * boxHeight, boxWidth, boxHeight);
      }
      else{
        brd.getBoard()[rc][cc].setX(cc * 35);
        brd.getBoard()[rc][cc].setY(rc * 35);
        brd.getBoard()[rc][cc].displaySmall();
      }
    }
  }
  //PIECE PLACEMENT
  if( ((( (((mouseY < 526)&&(mouseY>1))&&((mouseX < 524)&&(mouseX > 1))) && mousePressed) && selectedPiece != null) && brd.getBoard()[mouseY / 35][mouseX / 35] == null) && !canStart){
    int rSpot = mouseY / 35;
    int cSpot = mouseX / 35;
    brd.placePiece(p.getHand().remove(selectedPieceSpot), rSpot, cSpot);
    selectedPiece = null;
    selectedPieceSpot = 0;
  }
  
  //START TURN
  if( ((  mouseX > 536 && mouseX < 663 && ( mouseY > 9 && mouseY < 89)) && mousePressed)){
    for( int rc = 0; rc < 15; rc++){
      for( int cc = 0; cc < 15; cc++){
        if( brd.getBoard()[rc][cc] != null){
          tempBrd.getBoard()[rc][cc] = brd.getBoard()[rc][cc];
        }
      }
    }
    turnPoints = 0;
    turn += tadd;
    tadd = 0;
    p.fillHand(sck);
    canStart = false;
    canEnd = true;
  }
  
  break;
  case 2:
  background(255, 172, 249);
  textFont(f, 16);
  fill(0);
  textSize(24);
  text( "Congratulations, " + winner.getName() + "!", 175, 30);
  int yc = 130;
  for( Player pe : players){
    text( pe.getName() + ": " + pe.getScore() + " points", 200, yc);
    yc += 45;
  }
  break;
  
 }
}








//PLAYER PLAYER PLAYER
//PLAYER PLAYER PLAYER

public class Player{

    private String name;
    private int score;
    private ArrayList<Piece> hand;
    

    public Player(String inName){
    name = inName;
    score = 0;
    hand = new ArrayList<Piece>();
    }

    //notes to self:
    //don't need a fillHand() method, driver will do that ( i think)
  
  public void fillHand(Sack s){
    for( int i = hand.size(); i < 7 && sck.size() > 0; i++){
      addPiece( s.drawPiece());
    }
  }
  
  public void setName( String n){
      name = n;
  }
    
  public boolean addPiece(Piece p){
    if(getHandSize() > 6){
      return false;
    }
    else{
      hand.add(p);
      return true;
    }
  }
      
  public String getName(){
    return name;
  }
  
  public int getHandSize(){
    return hand.size();
  }
  
  public void setScore( int s){
    score = s;
  }
  
  public void addScore( int s){
    score += s;
  }
  
  public int getScore(){
    return score;
  }
  
  public ArrayList<Piece> getHand(){
    return hand;
  }
}








//BOARD BOARD BOARD
//BOARD BOARD BOARD

public class Board{

    private Piece[][] brd, tmpBoard;
    public ArrayList<String> setWords;
    public ArrayList<String> allWords;
    private int score;

    //Constructs a 15x15 board
    public Board(){
      brd = new Piece[15][15];
      tmpBoard = new Piece[15][15];
      setWords = new ArrayList<String>();
      allWords = new ArrayList<String>();
    }
    //Returns a boolean, true if brd[x][y] does not contain a piece, false otherwise.
    public boolean isEmpty( int x, int y){
      return brd[x][y] == null;
    }
    public boolean isEmptyTmp( int x, int y){
      return tmpBoard[x][y] == null;
    }
    
    //Returns brd
    public Piece[][] getBoard(){
      return brd;
    }
    public int getScore(){
      return score;
    }
    public void setScore(int i){
      score = i;
    }
    public void addScore(int i){
      score += i;
    }
      
    public int verifyInt( ArrayList<String> d){
      int r = 0;
      for( Piece[] pa : brd){
        for( Piece p: pa){
          if( p != null){
          if( p.getC() == 0){
            r += verHorizInt( d, p.getR(), p.getC());
          }else{
            if(isEmpty(p.getR(), p.getC() - 1)){
              r += verHorizInt( d, p.getR(), p.getC());
            }
          }
          if( p.getR() == 0){
            r += verVertInt( d, p.getR(), p.getC());
          }else{
            if(isEmpty(p.getR() - 1, p.getC())){
              r += verVertInt( d, p.getR(), p.getC());
            }
          }
        }
      }
      }
      if( turn == 1 && isEmpty(7,7)){
        r += -999;
      }
        return r;
    }
    
    
    //0 if single letter, -999 if fake word, 1 if valid word.
    public int verHorizInt( ArrayList<String> d, int r, int c){
      int wordVal = 0;
      int wordMult = 1;
      String s = "";
      boolean hasNoFriends = true;
      for( int cs = c; cs < 15 && !isEmpty( r, cs); cs++){
        s += brd[r][cs].getLetter();
          if( specialty(r, cs) == 1 && isEmptyTmp(r, cs)){
            wordVal += brd[r][cs].getValue() * 2;
          }else
          if( specialty(r, cs) == 2 && isEmptyTmp(r, cs)){
            wordVal += brd[r][cs].getValue();
            wordMult *= 2;
          }else
          if( specialty(r, cs) == 3 && isEmptyTmp(r, cs)){
            wordVal += brd[r][cs].getValue() * 3;
          }else
          if( specialty(r, cs) == 4 && isEmptyTmp(r, cs)){
            wordVal += brd[r][cs].getValue();
            wordMult *= 3;
          }else{
          wordVal += brd[r][cs].getValue();
        }
        //println( wordVal + ", " + wordMult);
      }  
      if( s.length() == 1){
        if( r != 0){
          if( !isEmpty(r - 1, c )){
            hasNoFriends = false;
          }
        }
        if( r != 14){
          if( !isEmpty(r + 1, c)){
            hasNoFriends = false;
          }
        }
        if( c != 0){
          if( !isEmpty(r, c - 1)){
            hasNoFriends = false;
          }
        }
        if( c != 14){
          if( !isEmpty(r, c + 1)){
            hasNoFriends = false;
          }
        }
        if( hasNoFriends){
          return -999;
        }else{
          return 0;
        }
      }
      if( d.indexOf(s) == -1){
          return -999;
      }else{
        if( setWords.indexOf(s) == -1){
          allWords.add(s);
          println(wordVal * wordMult);
          turnPoints += wordVal * wordMult;
        }
        return 1;
      }
    }
    
    public int verVertInt( ArrayList<String> d, int r, int c){
      int wordVal = 0;
      int wordMult = 1;
      String s = "";
      for( int rs = r; rs < 15 && !isEmpty( rs, c); rs++){
        s += brd[rs][c].getLetter();
          if( specialty(rs, c) == 1 && isEmptyTmp(rs, c)){
            wordVal += brd[rs][c].getValue() * 2;
          }else
          if( specialty(rs, c) == 2 && isEmptyTmp(rs, c)){
            wordMult *= 2;
            wordVal += brd[rs][c].getValue();
          }else
          if( specialty(rs, c) == 3 && isEmptyTmp(rs, c)){
            wordVal += brd[rs][c].getValue() * 3;
          }else
          if( specialty(rs, c) == 4 && isEmptyTmp(rs, c)){
            wordMult *= 3;
            wordVal += brd[rs][c].getValue();
          }else{
          wordVal += brd[rs][c].getValue();
        }
      }  
      if( s.length() == 1){
        return 0;
      }
      if( d.indexOf(s) == -1){
          return -999;
      }else{
        if( setWords.indexOf(s) == -1){
          allWords.add(s);
          turnPoints += wordVal * wordMult;
        }
        return 1;
      }
    }
    
    public int wordValue(String w){
      int v = 0;
      for( int i = 0; i < w.length(); i++){
        if( w.charAt(i) == 'A' || w.charAt(i) == 'E' || w.charAt(i) == 'I' || w.charAt(i) == 'O' || w.charAt(i) == 'U' || w.charAt(i) == 'N' || w.charAt(i) == 'R' || w.charAt(i) == 'T' || w.charAt(i) == 'L' || w.charAt(i) == 'S'){
          v += 1;
        }
        if( w.charAt(i) == 'D' || w.charAt(i) == 'G'){
          v += 2;
        }
        if( w.charAt(i) == 'B' || w.charAt(i) == 'C' || w.charAt(i) == 'M' || w.charAt(i) == 'P'){
          v += 3;
        }
        if( w.charAt(i) == 'F' || w.charAt(i) == 'H' || w.charAt(i) == 'V' || w.charAt(i) == 'W' || w.charAt(i) == 'Y'){
          v += 4;
        }
        if( w.charAt(i) == 'K'){
          v += 5;
        }
        if( w.charAt(i) == 'J' || w.charAt(i) == 'X'){
          v += 8;
        }
        if( w.charAt(i) == 'Q' || w.charAt(i) == 'Z'){
          v += 10;
        }
      }
      return v;
    }
    
    //If space is empty, places said piece in brd[r][c]. Otherwise returns false.
    public boolean placePiece(Piece p, int r, int c){
      if( !isEmpty(r, c)){
        return false;
      }else{
        brd[r][c] = p;
        p.setR(r);
        p.setC(c);
        return true;
      }  
    }
    //Removes and returns the piece at the brd[x][y]
    public Piece removePiece(int x, int y){
  Piece a = brd[x][y];
        brd[x][y] = null;
  return a;
    }
    public boolean placePieceTmp(Piece p, int r, int c){
      if( !isEmpty(r, c)){
        return false;
      }else{
        tmpBoard[r][c] = p;
        return true;
      }  
    }

    //toString
    public String toString(){
  String str = "";
  for( int i = 0; i < 30; i++){
    str += "--";
      }
  str += "\n";
  for( int sR = 0; sR < 15; sR++){
      str+= "|";
      for( int sC = 0; sC < 15; sC++){
    if( brd[sR][sC] != null){
        str += " " + brd[sR][sC].getLetter() + " |";
    }
    else{
        str += specialtyStr( sR, sC);
        str += " |";
    }
      }
      str += "\n";
      for( int i = 0; i < 30; i++){
    str += "--";
      }
      str += "\n";
  }
  return str;
    }
  
    
    //Sets brd as a new, empty 15x15 board
    public void clearBoard(){
  brd = new Piece[15][15];
    }
    //Returns an int describing the Specialty level of brd[x][y]
    //Normal space = 0//DL = 1//DW = 2//TL = 3//TW = 4
    public int specialty(int x, int y){
  if(       ( x == 1 && y == 2)
         || ( x == 1 && y == 12)
         || ( x == 2 && y == 1)
         || ( x == 2 && y == 4)
         || ( x == 2 && y == 10)
         || ( x == 2 && y == 13)
         || ( x == 4 && y == 2)
         || ( x == 4 && y == 6)
         || ( x == 4 && y == 8)
         || ( x == 4 && y == 12)
         || ( x == 6 && y == 4)
         || ( x == 6 && y == 10)
         || ( x == 8 && y == 4)
         || ( x == 8 && y == 10)
         || ( x == 10 && y == 2)
         || ( x == 10 && y == 6)
         || ( x == 10 && y == 8)
         || ( x == 10 && y == 12)
         || ( x == 12 && y == 1)
         || ( x == 12 && y == 4)
         || ( x == 12 && y == 10)
         || ( x == 12 && y == 13)
         || ( x == 13 && y == 2)
         || ( x == 13 && y == 12) ){
      return 1;
  }
  if(       ( x == 1 && y == 9)
         || ( x == 1 && y == 5)
         || ( x == 3 && y == 7)
         || ( x == 5 && y == 1)
         || ( x == 5 && y == 13)
         || ( x == 7 && y == 3)
         || ( x == 7 && y == 11)
         || ( x == 9 && y == 1)
         || ( x == 9 && y == 13)
         || ( x == 11 && y == 7)
         || ( x == 13 && y == 5)
         || ( x == 13 && y == 9)
      ){
      return 2;
  }
  if(       ( y == 0 && x == 6)
         || ( y == 0 && x == 8)
         || ( y == 3 && x == 3)
         || ( y == 3 && x == 11)
         || ( y == 5 && x == 5)
         || ( y == 5 && x == 9)
         || ( y == 6 && x == 0)
         || ( y == 6 && x == 14)
         || ( y == 8 && x == 0)
         || ( y == 8 && x == 14)
         || ( y == 9 && x == 5)
         || ( y == 9 && x == 9)
         || ( y == 11 && x == 3)
         || ( y == 11 && x == 11)
         || ( y == 14 && x == 6)
         || ( y == 14 && x == 8)
      ){
      return 3;
  }
  if(       ( y == 0 && x == 3)
         || ( y == 0 && x == 11)
         || ( y == 3 && x == 0)
         || ( y == 3 && x == 14)
         || ( y == 14 && x == 3)
         || ( y == 11 && x == 0)
         || ( y == 11 && x == 14)
         || ( y == 14 && x == 11)
      ){
      return 4;
  }
  else{
    
  return 0;
  }
    }
     public String specialtyStr(int x, int y){
  if(       ( x == 1 && y == 2)
         || ( x == 1 && y == 12)
         || ( x == 2 && y == 1)
         || ( x == 2 && y == 4)
         || ( x == 2 && y == 10)
         || ( x == 2 && y == 13)
         || ( x == 4 && y == 2)
         || ( x == 4 && y == 6)
         || ( x == 4 && y == 8)
         || ( x == 4 && y == 12)
         || ( x == 6 && y == 4)
         || ( x == 6 && y == 10)
         || ( x == 8 && y == 4)
         || ( x == 8 && y == 10)
         || ( x == 10 && y == 2)
         || ( x == 10 && y == 6)
         || ( x == 10 && y == 8)
         || ( x == 10 && y == 12)
         || ( x == 12 && y == 1)
         || ( x == 12 && y == 4)
         || ( x == 12 && y == 10)
         || ( x == 12 && y == 13)
         || ( x == 13 && y == 2)
         || ( x == 13 && y == 12) ){
      return "DL";
  }
  if(       ( x == 1 && y == 9)
         || ( x == 1 && y == 5)
         || ( x == 3 && y == 7)
         || ( x == 5 && y == 1)
         || ( x == 5 && y == 13)
         || ( x == 7 && y == 3)
         || ( x == 7 && y == 11)
         || ( x == 9 && y == 1)
         || ( x == 9 && y == 13)
         || ( x == 11 && y == 7)
         || ( x == 13 && y == 5)
         || ( x == 13 && y == 9)
      ){
      return "DW";
  }
  if(       ( y == 0 && x == 6)
         || ( y == 0 && x == 8)
         || ( y == 3 && x == 3)
         || ( y == 3 && x == 11)
         || ( y == 5 && x == 5)
         || ( y == 5 && x == 9)
         || ( y == 6 && x == 0)
         || ( y == 6 && x == 14)
         || ( y == 8 && x == 0)
         || ( y == 8 && x == 14)
         || ( y == 9 && x == 5)
         || ( y == 9 && x == 9)
         || ( y == 11 && x == 3)
         || ( y == 11 && x == 11)
         || ( y == 14 && x == 6)
         || ( y == 14 && x == 8)
      ){
      return "TL";
  }
  if(       ( y == 0 && x == 3)
         || ( y == 0 && x == 11)
         || ( y == 3 && x == 0)
         || ( y == 3 && x == 14)
         || ( y == 14 && x == 3)
         || ( y == 11 && x == 0)
         || ( y == 11 && x == 14)
         || ( y == 14 && x == 11)
      ){
      return "TW";
  }
  else{
    
  return "  ";
  }
    }
}












//PIECE PIECE PIECE
//PIECE PIECE PIECE

public class Piece{

    private char letter;
    private int value, x, y, r, c;
    //Defaults to true, is set to false when the turn in which it is placed ends
    private boolean removable;
    


    public Piece( char let, int val){
  letter = let;
  value = val;
  removable = true;
  r = 0;
  c = 0;
    }
    public String toString(){
  return ("Letter: " + letter + ", Value: " + value);
    }

    //All methods self-explanatory
    public void setLetter(char let){
  letter = let;
    }
    public char getLetter(){
  return letter;
    }
    public void setValue(int val){
  value = val;
    }
    public int getValue(){
  return value;
    }
    public boolean isRemovable(){
  return removable;
    }
    public void setRemovable(boolean b){
      removable = b;
    }
    public void setX(int in){
      x = in;
    }
    public void setY(int in){
      y = in;
    }
    public int getX(){
      return x;
    }
    public int getY(){
      return y;
    }
    public void setR(int in){
      r = in;
    }
    public void setC(int in){
      c = in;
    }
    public int getR(){
      return r;
    }
    public int getC(){
      return c;
    }
    public void display(){
      fill(252, 217, 103);
      rect(x, y, 60, 60);
      fill(0);
      textSize(48);
      text(getLetter(), getX() + 7, getY() + 45);
      textSize(12);
      text(getValue(), getX() + 46, getY() + 55);
    }
    
    public void displaySmall(){
      fill(252, 217, 103);
      rect(x, y, 35, 35);
      fill(0);
      textSize(26);
      text(getLetter(), getX() + 3, getY() + 27);
      textSize(10);
      text(getValue(), getX() + 23, getY() + 31);
    }
}









//SACK SACK SACK
//SACK SACK SACK

public class Sack{

  private ArrayList<Piece>  sck;

  public Sack(){
  sck = new ArrayList<Piece>();

  for( int i = 1; i < 13; i++){
     sck.add( new Piece( 'E', 1));
     if( i < 10){
         sck.add( new Piece( 'A', 1));
         sck.add( new Piece( 'I', 1));
     }
     if( i < 9){
         sck.add( new Piece( 'O', 1));
     }
     if( i < 7){
         sck.add( new Piece( 'N', 1));
         sck.add( new Piece( 'R', 1));
         sck.add( new Piece( 'T', 1));
     }
     if( i < 5){
         sck.add( new Piece( 'L', 1));
         sck.add( new Piece( 'S', 1));
         sck.add( new Piece( 'U', 1));
         sck.add( new Piece( 'D', 2));
     }
     if( i < 4){
         sck.add( new Piece( 'G', 2));
     }
     if( i < 3){
         sck.add( new Piece( 'B', 3));
         sck.add( new Piece( 'C', 3));
         sck.add( new Piece( 'M', 3));
         sck.add( new Piece( 'P', 3));
         sck.add( new Piece( 'F', 4));
         sck.add( new Piece( 'H', 4));
         sck.add( new Piece( 'V', 4));
         sck.add( new Piece( 'W', 4));
         sck.add( new Piece( 'Y', 4));
     }
     if( i < 2){
     sck.add( new Piece( 'K', 5));
     sck.add( new Piece( 'J', 8));
     sck.add( new Piece( 'X', 8));
     sck.add( new Piece( 'Q', 10));
     sck.add( new Piece( 'Z', 10));
     }
  }
 }
    //returns, but does not remove, piece at position i
    public Piece getPiece(int i){
  return sck.get(i);
    }

    //Selects a random Piece, removes it, and returns it
  public Piece drawPiece(){
    if( size() == 0){
      return null;
    }
    int i = (int)((Math.random() * (size()) ));
    //int i = Math.Random(100);
    Piece a = sck.get(i);
    sck.remove(i);
    return a;
  }
  
  public int size(){
    return sck.size();
  }
  
  //Empties the sack
  public void clear(){
    sck.clear();
  }
  
  //Empties and refills the sack
  public void reset(){
    clear();
  for( int i = 1; i < 13; i++){
     sck.add( new Piece( 'E', 1));
     if( i < 10){
         sck.add( new Piece( 'A', 1));
         sck.add( new Piece( 'I', 1));
     }
     if( i < 9){
         sck.add( new Piece( 'O', 1));
     }
     if( i < 7){
         sck.add( new Piece( 'N', 1));
         sck.add( new Piece( 'R', 1));
         sck.add( new Piece( 'T', 1));
     }
     if( i < 5){
         sck.add( new Piece( 'L', 1));
         sck.add( new Piece( 'S', 1));
         sck.add( new Piece( 'U', 1));
         sck.add( new Piece( 'D', 2));
     }
     if( i < 4){
         sck.add( new Piece( 'G', 2));
     }
     if( i < 3){
         sck.add( new Piece( 'B', 3));
         sck.add( new Piece( 'C', 3));
         sck.add( new Piece( 'M', 3));
         sck.add( new Piece( 'P', 3));
         sck.add( new Piece( 'F', 4));
         sck.add( new Piece( 'H', 4));
         sck.add( new Piece( 'V', 4));
         sck.add( new Piece( 'W', 4));
         sck.add( new Piece( 'Y', 4));
     }
     sck.add( new Piece( 'K', 5));
     sck.add( new Piece( 'J', 8));
     sck.add( new Piece( 'X', 8));
     sck.add( new Piece( 'Q', 10));
     sck.add( new Piece( 'Z', 10));
  }
 }
}
