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
	for( int sR = 0; sR < 15; sR++){
	    for( int sC = 0; sC < 15; sC++){
		if( 
	
    
    //Sets brd as a new, empty 15x15 board
    public void clearBoard(){
	brd = new Piece[15][15];
    }

    //UNWRITTEN
    //Returns an int describing the Specialty level of brd[x][y]
    //Normal space = 0//DL = 1//DW = 2//TL = 3//TW = 4
    public int specialty(int x, int y){
	//series of ifs to see if it is one of the special spots
	//OR add a list to this class of special coords and loop through that?
	//either way writing this will be easy but time consuming
	return 999;
    }    
    
    
    

    public static void main( String[] args){}
	







}
