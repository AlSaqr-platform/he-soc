void Conv5x5_Scalar  (int cid, int * In_Img, int * Out_Img, int ROW, int COL, int  * Kernel)
{
  int k, w, t;
  int acc;

  int blockSize = ((ROW-4)+NUM_CORES-1) / NUM_CORES;
  int start = cid*blockSize + 2;

  for (int row=start; (row < ROW-2) && (row < start+blockSize); row++) {
    for(int col=2; col < COL-2; col++) {

      acc = 0;
      t = row*ROW+col;

      //move in the window
        /* Coordinate window
            (-2;-2) (-2;-1) (-2; 0) (-2;+1) (-2;+2)
            (-1;-2) (-1;-1) (-1; 0) (-1;+1) (-1;+2)
            ( 0;-2) ( 0;-1) ( 0; 0) ( 0;+1) ( 0;+2)
            (+1;-2) (+1;-1) (+1; 0) (+1;+1) (+1;+2)
            (+2;-2) (+2;-1) (+2; 0) (+2;+1) (+2;+2)
        */

      for (int i=-2; i<=2; i++) {
        for (int j=-2; j<=2; j++) {
          int coeff;
          int data;

          k = (row+i)*ROW + (col+j); //coeff for one dimension matrix
          data = In_Img[k];
          w = (i+2)*FILT_WIN + (j+2);
          coeff = Kernel[w];

          acc += coeff * data;

        }
      }

      Out_Img[t] = acc;
    }
  }

}
