import de.bezier.guido.*;
public static final int rows = 20;
public static final int cols = 20;
public static final int Bombs = 50;
private MSButton[][] buttons; 
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); 
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    Interactive.make( this );
    buttons = new MSButton[rows][cols];
    for(int i = 0; i<rows; i++)
    {
        for(int j = 0; j<cols; j++)
        {
            buttons[i][j] = new MSButton(i,j);
        }
    }
    setBombs();
}
public void setBombs()
{
    while(bombs.size()<Bombs)
    {
        int r = (int)(Math.random()*rows);
        int c = (int)(Math.random()*cols);
        if(!bombs.contains(buttons[r][c]))
        {
            bombs.add(buttons[r][c]);
        }
    }
}
public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
    if(gameOver())
        displayLosingMessage();
}
public boolean isWon()
{
    int markCount = 0;
    for(int i = 0; i<bombs.size();i++)
    {
        if(bombs.get(i).isMarked())
        {
            markCount++;
        }
    }
    if(markCount == bombs.size())
    {
        return true;
    }
    return false;
}
public boolean gameOver()
{
     for(int i = 0; i<bombs.size();i++)
    {
        if(bombs.get(i).isClicked())
        {
            return true;
        }
    }
    return false;
}
public void displayLosingMessage()
{
    buttons[10][7].setLabel("Y");
    buttons[10][8].setLabel("O");
    buttons[10][9].setLabel("U");
    buttons[10][10].setLabel("");
    buttons[10][11].setLabel("L");
    buttons[10][12].setLabel("O");
    buttons[10][13].setLabel("S");
    buttons[10][14].setLabel("E");
}
public void displayWinningMessage()
{
    buttons[10][7].setLabel("Y");
    buttons[10][8].setLabel("O");
    buttons[10][9].setLabel("U");
    buttons[10][10].setLabel("");
    buttons[10][11].setLabel("W");
    buttons[10][12].setLabel("I");
    buttons[10][13].setLabel("N");   
}
public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    public MSButton ( int rr, int cc )
    {
        width = 400/cols;
        height = 400/rows;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); 
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    public void mousePressed () 
    {
        if(mouseButton == LEFT)
        {
            clicked = true;
        }
        if(mouseButton == RIGHT)
        {
            marked = !marked;
        }
        else if(countBombs(r,c)>0)
        {
          if(isMarked()==false)
         {
            label = "" + countBombs(r,c);
         }
     }
         else
         {
            if(isValid(r-1,c) && !buttons[r-1][c].clicked)
                buttons[r-1][c].mousePressed();
             if(isValid(r-1,c-1) && !buttons[r-1][c-1].clicked)
                buttons[r-1][c-1].mousePressed();
             if(isValid(r-1,c+1) && !buttons[r-1][c+1].clicked)
                buttons[r-1][c+1].mousePressed();
             if(isValid(r,c-1) && !buttons[r][c-1].clicked)
                buttons[r][c-1].mousePressed();
             if(isValid(r+1,c-1) && !buttons[r+1][c-1].clicked)
                buttons[r+1][c-1].mousePressed();
             if(isValid(r+1,c) && !buttons[r+1][c].clicked)
                buttons[r+1][c].mousePressed();
             if(isValid(r+1,c+1) && !buttons[r+1][c+1].clicked)
                buttons[r+1][c+1].mousePressed();
             if(isValid(r,c+1) && !buttons[r][c+1].clicked)
                buttons[r][c+1].mousePressed();
         }
    }
    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );
            rect(x, y, width, height);
            fill(0);
            text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
       return r>=0 && r<rows && c>=0 && c<cols;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(row-1,col-1) && bombs.contains(buttons[row-1][col-1]))
        {
             numBombs++;
        }
        if(isValid(row-1,col) && bombs.contains(buttons[row-1][col]))
        {
             numBombs++;
        }
        if(isValid(row-1,col+1) && bombs.contains(buttons[row-1][col+1]))
        {
             numBombs++;
        }
        if(isValid(row,col+1) && bombs.contains(buttons[row][col+1]))
        {
             numBombs++;
        }
        if(isValid(row+1,col+1) && bombs.contains(buttons[row+1][col+1]))
        {
             numBombs++;
        }
        if(isValid(row+1,col) && bombs.contains(buttons[row+1][col]))
        {
             numBombs++;
        }
        if(isValid(row+1,col-1) && bombs.contains(buttons[row+1][col-1]))
        {
             numBombs++;
        }
        if(isValid(row,col-1) && bombs.contains(buttons[row][col-1]))
        {
             numBombs++;
        }
        return numBombs;
    }
}
public void keyPressed()
{
    if(keyCode == 32)
    {
        for(int i = 0; i<rows; i++)
        {
            for(int j = 0; j<cols; j++)
            {
                bombs.remove(buttons[i][j]);
                buttons[i][j].marked = false;
                buttons[i][j].clicked = false;
                buttons[i][j].setLabel(" ");
            }
        }
    setBombs();
    }
}
