int  gSize;

int[][] board = {{0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0}};   

void setup() {
  
  frameRate(2);
  size(600, 600);
  gSize = width/9;
  background(0);
  Grid(); 

  if (Solve(board)) {   
    PrintNum();
  }
}


boolean Solve(int[][] bo) {

  //check for empty cell
  int row = 0;
  int col = 0;
  boolean isEmpty = true;

  for (int i=0; i<9; i++) {
    for (int j=0; j<9; j++) {
      if (bo[i][j] == 0) {
        
        row = i;
        col = j;        
        isEmpty=false;
        break;
      }
    }
  }
  if (isEmpty) {
    return true;
  }

  //assign random number and use backtracking
  for (int i=1; i<=9; i++) {
    int n = (int)random(1,10);
    if (CheckValid(bo, row, col, n)) {     
      bo[row][col] = n;
      if (Solve(bo)) {
        return true;
      } 
      else {      
        bo[row][col] = 0;
      }
    }
  }   
  return false;
}

//Check if the given number is valid if yes then return true else false
boolean CheckValid(int[][] bo, int r, int c, int n) {

  //for rows and columns
  for (int i=0; i<9; i++) {     
    if (bo[r][i] == n) {
      return false;
    } 
    if (bo[i][c] == n) {
      return false;
    }
  }

  //for 3x3 grid
  int row = floor(r/3);
  int col = floor(c/3);

  for (int i = row * 3; i < (row*3)+3; i++) {
    for (int j = col * 3; j < (col*3)+3; j++) {

      if (bo[i][j] == n) {
        return false;
      }
    }
  }
  return true;
}

//Print numbers
void PrintNum() {
  for (int i=0; i<9; i++) {       
    for (int j=0; j<9; j++) {
      textSize(20);
      text(board[i][j], i*gSize+gSize/2, j*gSize+gSize/2);
    }
  }
}
//create 9x9 grid
void Grid() {

  stroke(255);

  for (int i=0; i<width; i+=gSize) {       
    for (int j=0; j<height; j+=gSize) {

      line(i, j, i+100, j);
      line(j, i, j, i+100);
    }
  } 
  RedGrid();
}

//create 3x3 grid
void RedGrid() {
  stroke(255, 0, 0);
  strokeWeight(2);
  for (int i=0; i<width; i+=gSize*3) {    
    for (int j=0; j<height; j+=gSize*3) {

      line(i, j, i+500, j);
      line(j, i, j, i+500);
    }
  }
}
