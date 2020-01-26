PImage img;
PImage sorted;
int index = 0;

int imgWidth = 100;
int imgHeight = 100;

int lastRow = 466;
int lastColumn = 100;
int currentFirstRow = 0;
int firstColumn = 0;

int currentColumn = 0;
int currentRow = 0;

int totalPixels;
int swapCounter = 1;

void setup() {
  size(472, 198);

  img = loadImage("Mai Laughing.jpg");
  sorted = createImage(img.width, img.height, RGB);
  sorted = img.get();
  
  totalPixels = imgWidth * imgHeight;
}

void draw() {
  println(frameRate);

  sorted.loadPixels();

  for (int n = 0; n < 10; n++) {
    float record = -1;
    int selectedPixel = index;
    boolean check = false;

    for (int row = currentFirstRow; row <= lastRow; row++) {
      for (int column = firstColumn; column <= lastColumn; column++) {
        check = true;
   
        if (currentRow == currentFirstRow && ((column == firstColumn && firstColumn != 0) || (column < currentColumn))) {
          check = false;
        }
        else if (currentColumn == lastColumn && (row == currentFirstRow || row < currentRow)) {
          check = false;
        }
        else if (currentRow == lastRow && (column == lastColumn || column > currentColumn)) {
          check = false;
        }
        else if (currentColumn == firstColumn && (row == lastRow || row > currentRow)) {
          check = false;
        }
    
        if(check) {
          int checkPixelIndex = (row * imgWidth) + column;
          color pix = sorted.pixels[checkPixelIndex];
          float b = hue(pix);
          if (b > record) {
            selectedPixel = checkPixelIndex;
            record = b;
          }
        }
      }
    }

    color temp = sorted.pixels[index];
    sorted.pixels[index] = sorted.pixels[selectedPixel];
    sorted.pixels[selectedPixel] = temp;

    swapCounter++;

    if (swapCounter <= totalPixels) {

      if (currentColumn < lastColumn && currentRow == currentFirstRow) {
        currentColumn++;
      }
      else if (currentRow < lastRow && currentColumn == lastColumn) {
        currentRow++;
      }
      else if (currentRow == lastRow && currentColumn > firstColumn) {
        currentColumn--;
      }
      else if (currentColumn == firstColumn && currentRow > currentFirstRow) {
        currentRow--;
      }
      
      if (currentColumn == lastColumn && currentRow == lastRow) {
        currentFirstRow++;
      }
      if (currentColumn == firstColumn && currentRow == currentFirstRow) {
        lastRow--;
      }
      if (currentColumn == firstColumn && currentRow == lastRow) {
        lastColumn--;
      }
      if (currentColumn == lastColumn && currentRow == currentFirstRow && currentFirstRow != 0) {
        firstColumn++;
      }
                   
      index = (currentRow * imgWidth) + currentColumn;
    }
  }

  sorted.updatePixels();

  background(0);
  image(img, 0, 0);
  image(sorted, imgWidth * 2 + 38, 0);
}
