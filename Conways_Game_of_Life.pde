// Initial setup varibales
int w_box = 100;
int h_box = 72;
int cell_dim = 10;
double init_live_density = 0.4;

// Global board variable
boolean[][] board = new boolean[w_box][h_box];


// Function to check if cell is going to live based on it's neighbours
boolean isAlive(int i, int j) {
  int liveNeighbours = 0;
  
  int startPosX = (i - 1 < 0) ? i : i-1;
  int startPosY = (j - 1 < 0) ? j : j-1;
  int endPosX =   (i + 1 > w_box - 1) ? i : i+1;
  int endPosY =   (j + 1 > h_box - 1) ? j : j+1;
  
  for (int rowNum=startPosX; rowNum<=endPosX; rowNum++) {
    for (int colNum=startPosY; colNum<=endPosY; colNum++) {
      if (board[rowNum][colNum]) liveNeighbours++;
    }
  }
  
  if (board[i][j]) liveNeighbours--;
  
  if (board[i][j] && liveNeighbours == 2 || liveNeighbours == 3) return true;
  
  return false;
}

// Updating all cells
void update() {
  boolean[][] new_board = new boolean[w_box][h_box];
  
  for (int i = 0; i < new_board.length; i++) {
    for (int j = 0; j < new_board[0].length; j++) {
      new_board[i][j] = isAlive(i, j);
    }
  }
  
  board = new_board;
}

// Draws the cells
void show() {
  for(int i=0;i<w_box;i++){
    for(int j=0;j<h_box;j++){
      if (board[i][j]) fill(0);
      else fill(255);
      rect(i*cell_dim, j*cell_dim, cell_dim, cell_dim);
    }
  }
}

// In setup we initialize the board randomly with predefined live cell density
void setup() {
  for (int i = 0; i < board.length; i++) {
    for (int j = 0; j < board[0].length; j++) {
      if (random(1) < init_live_density) board[i][j] = true;
    }
  }
  
  size(1000, 720); // x10
  frameRate(10);
}

void draw() {
  update();
  show();
}
