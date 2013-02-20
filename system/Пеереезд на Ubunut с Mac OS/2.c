/*ALL the necessary header files*/
#include"math.h"
// #include"conio.h"
#include"cv.h"
#include"highgui.h"
#include"stdio.h"
int main()
{
  int i,j,k;
  int height,width,step,channels;
  int stepr, channelsr;
  int temp=0;
  uchar *data,*datar;
  i=j=k=0;
  IplImage *frame=cvLoadImage("3d-09-5balls.jpg",1);
  IplImage *result=cvCreateImage( cvGetSize(frame), 8, 1 );
  if(frame==NULL ) {
    puts("unable to load the frame");exit(0);}
  printf("frame loaded");
  cvNamedWindow("original",CV_WINDOW_AUTOSIZE);
  cvNamedWindow("Result",CV_WINDOW_AUTOSIZE);

  height = frame->height;
  width = frame->width;
  step =frame->widthStep;
  channels = frame->nChannels;
  data = (uchar *)frame->imageData;
  /*Here I use the Suffix r to diffenrentiate the result data and the frame data
   * Example :stepr denotes widthStep of the result IplImage and step is for frame IplImage*/

  stepr=result->widthStep;
  channelsr=result->nChannels;
  datar = (uchar *)result->imageData;

  for(i=0;i < (height);i++) for(j=0;j <(width);j++)

    /*As I told you previously you need to select pixels which are
     * more red than any other color
     * Hence i select a difference of 29(which again depends on the scene).
     * (you need to select randomly and test*/
    if(((data[i*step+j*channels+16]) > (155+data[i*step+j*channels]))
        && ((data[i*step+j*channels+16]) > (155+data[i*step+j*channels+1])))
      datar[i*stepr+j*channelsr]=255;
    else
      datar[i*stepr+j*channelsr]=0;
  /*If you want to use cvErode you may...*/
  /*Destroying all the Windows*/
  cvShowImage("original",frame);
  cvShowImage("Result",result);
  cvSaveImage("result.jpg",result, 0);
  cvWaitKey(0);
  cvDestroyWindow("original");
  cvDestroyWindow("Result");
  return 0;
}
