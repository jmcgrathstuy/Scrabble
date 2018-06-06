import java.util.*;
import java.io.*;
import java.lang.*;

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

    //UNWRITTEN
    //Returns an int describing the Specialty level of brd[x][y]
    //Normal space = 0//DL = 1//DW = 2//TL = 3//TW = 4
    public int specialty(int x, int y){
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
    
    
    

    public static void main( String[] args){
	Board b = new Board();
	System.out.println( b.toString());
	Piece p = new Piece( 'A', 7);
	b.placePiece( p, 4, 2);
        System.out.println( b.toString());
	


    }
	







}
