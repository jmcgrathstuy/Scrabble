import java.util.*;
import java.io.*;
//import java.lang.*;

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
	   sck.add( new Piece( 'K', 5));
	   sck.add( new Piece( 'J', 8));
	   sck.add( new Piece( 'X', 8));
	   sck.add( new Piece( 'Q', 10));
	   sck.add( new Piece( 'Z', 10));
	}
    }
    //returns, but does not remove, piece at position i
    public Piece getPiece(int i){
	return sck.get(i);
    }

    //Selects a random Piece, removes it, and returns it
    public Piece drawPiece(){
	int i = (int)((Math.random() * 100) + 1);
	//int i = Math.Random(100);
	return sck.get(i);
    }

    public static void main (String[] args){
	Sack s = new Sack();
	System.out.println(s.drawPiece());
    }


    

    
}
