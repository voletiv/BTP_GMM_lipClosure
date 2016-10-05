#include "stdafx.h"
#include <stdio.h>
#include <cv.h>
#include <iostream>
#include <conio.h>
#include <cxcore.h>
#include <highgui.h>
#include <cvaux.h>
#include <stdlib.h>	

CvHaarClassifierCascade *cascade,*cascade_e,*cascade_mouth;
CvMemStorage *storage;
char *face_cascade="C:\\OpenCV2.4\\data\\haarcascades\\haarcascade_frontalface_alt2.xml";
char *eye_cascade="C:\\OpenCV2.4\\data\\haarcascades\\haarcascade_mcs_eyepair_big.xml";
char *mouth_cascade="C:\\OpenCV2.4\\data\\haarcascades\\haarcascade_mcs_mouth.xml";
int lc=0;

/*Mouth detect ion*/
void detectMouth( IplImage *img, CvRect *r)
{
   CvSeq *mouth;
   //mouth detecetion - set ROI
   cvSetImageROI(img,/* the source image */ 
                 cvRect(r->x,            /* x = start from leftmost */
                        r->y+(r->height *2/3), /* y = a few pixels from the top */
                        r->width,        /* width = same width with the face */
                        r->height/3    /* height = 1/3 of face height */
                       )
                );
    mouth = cvHaarDetectObjects(img,/* the source image, with the estimated location defined */ 
                                cascade_mouth,      /* the eye classifier */ 
                                storage,        /* memory buffer */
                                1.15, 4, 0,     /* tune for your app */ 
                                cvSize(25, 15)  /* minimum detection scale */
                               );

        for( int i = 0; i < (mouth ? mouth->total : 0); i++ )
        {
      
          CvRect *mouth_cord = (CvRect*)cvGetSeqElem(mouth, i);
          /* draw a white rectangle */
          cvRectangle(img, 
                      cvPoint(mouth_cord->x, mouth_cord->y), 
                      cvPoint(mouth_cord->x + mouth_cord->width, mouth_cord->y + mouth_cord->height),
                      CV_RGB(255,255, 255), 
                      4, 8, 0
                    );
        }
     //end mouth detection
}


/*Eyes detection*/
void detectEyes( IplImage *img,CvRect *r)
{
    char *eyecascade;
    CvSeq *eyes;
    int eye_detect=0;
    

   //eye detection starts
  /* Set the Region of Interest: estimate the eyes' position */
    
    cvSetImageROI(img,                    /* the source image */ 
          cvRect
          (
              r->x,            /* x = start from leftmost */
              r->y + (r->height/5.5), /* y = a few pixels from the top */
              r->width,        /* width = same width with the face */
              r->height/3.0    /* height = 1/3 of face height */
          )
      );

      /* detect the eyes */
      eyes = cvHaarDetectObjects( img,            /* the source image, with the estimated location defined */ 
                                  cascade_e,      /* the eye classifier */ 
                                  storage,        /* memory buffer */
                                  1.15, 3, 0,     /* tune for your app */ 
                                  cvSize(25, 15)  /* minimum detection scale */
                                );
    
      printf("\no of eyes detected are %d",eyes->total);
	
      
        /* draw a rectangle for each detected eye */
        for( int i = 0; i < (eyes ? eyes->total : 0); i++ )
        {
              eye_detect++;
              /* get one eye */
              CvRect *eye = (CvRect*)cvGetSeqElem(eyes, i);
              /* draw a blue rectangle */
                        cvRectangle(img, 
                                    cvPoint(eye->x, eye->y), 
                                    cvPoint(eye->x + eye->width, eye->y + eye->height),
                                    CV_RGB(0, 0, 255), 
                                    6, 8, 0
                                   );
         }
            
}

void detectFacialFeatures( IplImage *img,IplImage *temp_img,char* win)
{
    
    char image[100],msg[100],temp_image[100];
    float m[6];
    double factor = 1;
    CvMat M = cvMat( 2, 3, CV_32F, m );
    int w = (img)->width;
    int h = (img)->height;
    CvSeq* faces;
    CvRect *r;

    m[0] = (float)(factor*cos(0.0));
    m[1] = (float)(factor*sin(0.0));
    m[2] = w*0.5f;
    m[3] = -m[1];
    m[4] = m[0];
    m[5] = h*0.5f;
    
    cvGetQuadrangleSubPix(img, temp_img, &M);
    CvMemStorage* storage=cvCreateMemStorage(0);
    cvClearMemStorage( storage );
    
    if( cascade )
        faces = cvHaarDetectObjects(img,cascade, storage, 1.2, 2, CV_HAAR_DO_CANNY_PRUNING, cvSize(20, 20));
    else
	{printf("\nFrontal face cascade not loaded\n"); getch(); return;}

    printf("\n no of faces detected are %d\n",faces->total);

    /* for each face found, draw a red box */
    for(int i = 0 ; i < ( faces ? faces->total : 0 ) ; i++ )
    {        
        r = ( CvRect* )cvGetSeqElem( faces, i );
        cvRectangle( img,cvPoint( r->x, r->y ),cvPoint( r->x + r->width, r->y + r->height ),
                     CV_RGB( 255, 0, 0 ), 8, 8, 0 );    
    
        printf("\n face_x=%d face_y=%d wd=%d ht=%d",r->x,r->y,r->width,r->height);
        
        //detectEyes(img,r);
        /* reset region of interest */
        cvResetImageROI(img);
        detectMouth(img,r);
        cvResetImageROI(img);
    }

	  return;
	  /*
	  printf("Waiting for your KEY\n");
	  getch();
	  cvNamedWindow("new");
	  cvShowImage("new", img);
	  cvWaitKey(0);
	  
      if(faces->total > 0)
        {
            sprintf(image,"C:\\Users\\Vikram\\Pictures\\%d.jpg",img_no);
            cvSaveImage( image, img );
        }
	*/
}

int main()
{ 

	CvCapture* capture = cvCreateFileCapture("C:\\Users\\Vikram\\Documents\\EDU\\Summer 2012\\Vids\\sj.avi"); //The video is loaded into a pointer of type CvCapture
	//CvCapture* capture = cvCreateCameraCapture(-1); //The video is loaded into a pointer of type CvCapture
	IplImage *frame, *temp_frame; 

	/* load the classifier 
       note that I put the file in the same directory with
       this code */
    storage = cvCreateMemStorage( 0 );
    cascade = ( CvHaarClassifierCascade* )cvLoad( face_cascade, 0, 0, 0 );
    cascade_e = ( CvHaarClassifierCascade* )cvLoad( eye_cascade, 0, 0, 0 );
    cascade_mouth = ( CvHaarClassifierCascade* )cvLoad( mouth_cascade, 0, 0, 0 );

	if(!cascade)
        {
        fprintf(stderr, "ERROR: Could not load FACE classifier cascade\n");
		getch();
        return -1;
        }

	if(!cascade_e)
        {
        fprintf( stderr, "ERROR: Could not load EYE classifier cascade\n" );
		getch();
        return -1;
        }
    
    if(!cascade_mouth)
	{
        fprintf( stderr, "ERROR: Could not load MOUTH classifier cascade\n" );
		getch();
        return -1;
    }

	char *win = "video"; //Declaration of character pointer to store window name
	cvNamedWindow(win,CV_WINDOW_AUTOSIZE); //Window is created for image of each frame

	frame = cvQueryFrame(capture);
	/*
	while(!cvWaitKey(0)) {
		frame = cvQueryFrame(capture);
		cvShowImage(win, frame);
	}
	*/

	char c, t[100];
	int count=0;
	float posMsec;
	CvFont font;
	cvInitFont(&font, CV_FONT_HERSHEY_SIMPLEX, 1.0, 1.0, 0, 3, CV_AA);
	while(1)
	{
		lc = 0;
		frame = cvQueryFrame(capture); //Image under consideration is captured as a shot of the video
		temp_frame = frame;
		detectFacialFeatures(frame,temp_frame, win);
		posMsec = cvGetCaptureProperty(capture, CV_CAP_PROP_POS_MSEC);
		if(lc==1) sprintf(t, "Time = %.2f, YES!!!", posMsec/1000);
		else sprintf(t, "Time = %.2f", posMsec/1000);
		cvPutText(frame, t, cvPoint(100,100), &font, cvScalar(0,0,0));
		cvShowImage(win, frame);

		

		c = cvWaitKey(50); //This is to account for the frame speed of the loaded video
		if(c==27) break;//If the character of code 27 or the ESCAPE character is entered, the loop will break
		if(c==32) cvWaitKey(0);
	}

	cvReleaseCapture(&capture); //Video is released from memory
	cvReleaseHaarClassifierCascade( &cascade );
    cvReleaseHaarClassifierCascade( &cascade_e );
    cvReleaseHaarClassifierCascade( &cascade_mouth );
    cvReleaseMemStorage( &storage );
	cvReleaseImage(&frame); //Image released from memory
	cvReleaseImage(&temp_frame);
	cvDestroyWindow(win); //Window closed
}