import java.util.*;
import java.io.*;
import java.lang.*;

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
        score =+ s;
    }
    public int getScore(){
	return score;
    }

    
	

    

}
