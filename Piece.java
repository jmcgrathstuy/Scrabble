public class Piece{

    private char letter;
    private int value;
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
    




}
