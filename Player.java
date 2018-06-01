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

    public void setName( String n){
	name = n;
    }
    public String getName(){
	return name;
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
