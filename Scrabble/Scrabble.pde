Board brd;
Sack sck;
Player p;
PFont f;
int boxWidth, boxHeight;
Piece selectedPiece;
int selectedPieceSpot, turnPoints;
PImage bg;

//SETUP
//DRAW


//PLAYER
//BOARD
//PIECE
//SACK


public void setup(){
  size(673, 600);
  bg = loadImage("WWFBoard.png");
  background(bg);
  sck = new Sack();
  brd = new Board();
  p = new Player("Jack");
  p.fillHand(sck);
  f = createFont("Arial", 16, true);
  boxWidth = 35;
  boxHeight = 35;
  turnPoints = 0;
  
}

public void draw(){
  background(bg);
  int a = 5;
  //int a = 0;
  textFont(f, 16);
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
        rect( rc * boxWidth, cc * boxHeight, boxWidth, boxHeight);
      }
      else{
        brd.getBoard()[rc][cc].setY(cc * 35);
        brd.getBoard()[rc][cc].setX(rc * 35);
        brd.getBoard()[rc][cc].displaySmall();
      }
    }
  }
  //PIECE PLACEMENT
  if( (( (((mouseY < 526)&&(mouseY>1))&&((mouseX < 524)&&(mouseX > 1))) && mousePressed) && selectedPiece != null) && brd.getBoard()[mouseX / 35][mouseY / 35] == null){
    turnPoints += selectedPiece.getValue();
    brd.placePiece(p.getHand().remove(selectedPieceSpot), mouseX / 35, mouseY / 35);
    selectedPiece = null;
    selectedPieceSpot = 0;
  }
  
  //END TURN AND RECEIVE POINTS
  if( ((  mouseX > 536 && mouseX < 663 && ( mouseY > 9 && mouseY < 89)) && mousePressed)){
    p.addScore(turnPoints);
    turnPoints = 0;
    p.fillHand(sck);
    println(p.getScore());
  }
  
  
  //println("selectedPiece: " + selectedPiece);
  //println("[0][0]: " + brd.getBoard()[0][0]);
  //println("[0][1]: " + brd.getBoard()[0][1]);
  
  /*if(mousePressed){
    println("" + (mouseY / 35) +" "+ (mouseX / 35));
    println("yeet" + ((( (mouseY < 526) && mousePressed) && selectedPiece != null) && brd.getBoard()[mouseY / 35][mouseX / 35] == null));
  }*/
  
  
}



    //Given a coordinate returns the relevant x or y spot in the array
    //public static int relSpot(int coord){
    //  return coord / 35;
    //}









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
    for( int i = hand.size(); i < 7; i++){
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

    private Piece[][] brd;

    //Constructs a 15x15 board
    public Board(){
  brd = new Piece[15][15];
    }
    //Returns a boolean, true if brd[x][y] does not contain a piece, false otherwise.
    public boolean isEmpty( int x, int y){
  return brd[x][y] == null;
    }
    
    //Returns brd
    public Piece[][] getBoard(){
      return brd;
    }

    
    
    //If space is empty, places said piece in brd[x][y]. Otherwise returns false.
    public boolean placePiece(Piece p, int x, int y){
  if( !isEmpty(x, y)){
      return false;
  }else{
      brd[x][y] = p;
      return true;
  }
    }
    //Removes and returns the piece at the brd[x][y]
    public Piece removePiece(int x, int y){
  Piece a = brd[x][y];
        brd[x][y] = null;
  return a;
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
  //series of ifs to see if it is one of the special spots
  //OR add a list to this class of special coords and loop through that?
  //either way writing this will be easy but time consuming
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
    private int value, x, y;
    //Defaults to true, is set to false when the turn in which it is placed ends
    private boolean removable;


    public Piece( char let, int val){
  letter = let;
  value = val;
  removable = true;
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
    public void swapRemovable(){
  removable = !removable;
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
