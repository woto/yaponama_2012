//
// разбор картинки от камеры в HSV
//
// позволяет подобрать параметры
// Hmin, Hmax, Smin, Smax, Vmin, Vmax
// для выделения нужного объекта
//
// robocraft.ru
//

#include <cv.h>
#include <highgui.h>
#include <stdlib.h>
#include <stdio.h>

IplImage* frame = 0;

// для хранения каналов HSV
IplImage* hsv = 0;
IplImage* h_plane = 0;
IplImage* s_plane = 0;
IplImage* v_plane = 0;
// для хранения каналов HSV после преобразования
IplImage* h_range = 0;
IplImage* s_range = 0;
IplImage* v_range = 0;
// для хранения суммарной картинки
IplImage* hsv_and = 0;

int Hmin = 0;
int Hmax = 256;

int Smin = 0;
int Smax = 256;

int Vmin = 0;
int Vmax = 256;

int HSVmax = 256;

//
// функции-обработчики ползунков
//
void myTrackbarHmin(int pos) {
	Hmin = pos;
}

void myTrackbarHmax(int pos) {
	Hmax = pos;
}

void myTrackbarSmin(int pos) {
	Smin = pos;
}

void myTrackbarSmax(int pos) {
	Smax = pos;
}

void myTrackbarVmin(int pos) {
	Vmin = pos;
}

void myTrackbarVmax(int pos) {
	Vmax = pos;
}

int main(int argc, char* argv[])
{
	// получаем любую подключённую камеру
	CvCapture* capture = cvCreateCameraCapture(CV_CAP_ANY);
	assert( capture );

	// узнаем ширину и высоту кадра
	double width = cvGetCaptureProperty(capture, CV_CAP_PROP_FRAME_WIDTH);
	double height = cvGetCaptureProperty(capture, CV_CAP_PROP_FRAME_HEIGHT);
	printf("[i] %.0f x %.0f\n", width, height );

	// окна для отображения картинки
	cvNamedWindow("original",CV_WINDOW_AUTOSIZE);
	cvNamedWindow("H",CV_WINDOW_AUTOSIZE);
	cvNamedWindow("S",CV_WINDOW_AUTOSIZE);
	cvNamedWindow("V",CV_WINDOW_AUTOSIZE);
	cvNamedWindow("H range",CV_WINDOW_AUTOSIZE);
	cvNamedWindow("S range",CV_WINDOW_AUTOSIZE);
	cvNamedWindow("V range",CV_WINDOW_AUTOSIZE);
	cvNamedWindow("hsv and",CV_WINDOW_AUTOSIZE);

	cvCreateTrackbar("Hmin", "H range", &Hmin, HSVmax, myTrackbarHmin);
	cvCreateTrackbar("Hmax", "H range", &Hmax, HSVmax, myTrackbarHmax);
	cvCreateTrackbar("Smin", "S range", &Smin, HSVmax, myTrackbarSmin);
	cvCreateTrackbar("Smax", "S range", &Smax, HSVmax, myTrackbarSmax);
	cvCreateTrackbar("Vmin", "V range", &Vmin, HSVmax, myTrackbarVmin);
	cvCreateTrackbar("Vmax", "V range", &Vmax, HSVmax, myTrackbarVmax);
	//
	// разместим окна по рабочему столу
	//
	frame = cvQueryFrame( capture );
	if(frame->width <1920/4 && frame->height<1080/2){
		cvMoveWindow("original", 0, 0);
		cvMoveWindow("H", frame->width+10, 0);
		cvMoveWindow("S", (frame->width+10)*2, 0);
		cvMoveWindow("V", (frame->width+10)*3, 0);
		cvMoveWindow("hsv and", 0, frame->height+30);
		cvMoveWindow("H range", frame->width+10, frame->height+30);
		cvMoveWindow("S range", (frame->width+10)*2, frame->height+30);
		cvMoveWindow("V range", (frame->width+10)*3, frame->height+30);
	}

	// получаем кадр (чтобы создать картинки нужного размера)
	frame = cvQueryFrame( capture );

	// создаём картинки
	hsv = cvCreateImage( cvGetSize(frame), IPL_DEPTH_8U, 3 );
	h_plane = cvCreateImage( cvGetSize(frame), IPL_DEPTH_8U, 1 );
	s_plane = cvCreateImage( cvGetSize(frame), IPL_DEPTH_8U, 1 );
	v_plane = cvCreateImage( cvGetSize(frame), IPL_DEPTH_8U, 1 );
	h_range = cvCreateImage( cvGetSize(frame), IPL_DEPTH_8U, 1 );
	s_range = cvCreateImage( cvGetSize(frame), IPL_DEPTH_8U, 1 );
	v_range = cvCreateImage( cvGetSize(frame), IPL_DEPTH_8U, 1 );
	hsv_and = cvCreateImage( cvGetSize(frame), IPL_DEPTH_8U, 1 );

	while(true)
	{
		// получаем кадр
		frame = cvQueryFrame( capture );

		//  конвертируем в HSV 
		cvCvtColor( frame, hsv, CV_BGR2HSV ); 
		// разбиваем на отельные каналы
		cvCvtPixToPlane( hsv, h_plane, s_plane, v_plane, 0 );

		// показываем картинку
		cvShowImage("original", frame);

		// показываем H-S-V-слои
		cvShowImage("H", h_plane);
		cvShowImage("S", s_plane);
		cvShowImage("V", v_plane);

		// выполняем пороговое преобразование
		cvInRangeS(h_plane, cvScalar(Hmin), cvScalar(Hmax), h_range);
		cvInRangeS(s_plane, cvScalar(Smin), cvScalar(Smax), s_range);
		cvInRangeS(v_plane, cvScalar(Vmin), cvScalar(Vmax), v_range);

		// показываем результат
		cvShowImage("H range", h_range);
		cvShowImage("S range", s_range);
		cvShowImage("V range", v_range);

		// обнуляем
		cvZero(hsv_and);

		// складываем 
		cvAnd(h_range, s_range, hsv_and);
		cvAnd(hsv_and, v_range, hsv_and);

		cvShowImage( "hsv and", hsv_and );

		char c = cvWaitKey(33);
		if (c == 27) { // если нажата ESC - выходим
			break;
		}
	}
	printf("\n[i] Results:\n" );
	printf("[H] %d x %d\n", Hmin, Hmax );
	printf("[S] %d x %d\n", Smin, Smax );
	printf("[V] %d x %d\n", Vmin, Vmax );

	// освобождаем ресурсы
	cvReleaseCapture( &capture );

	cvReleaseImage(&hsv);
	cvReleaseImage(&h_plane);
	cvReleaseImage(&s_plane);
	cvReleaseImage(&v_plane);
	cvReleaseImage(&h_range);
	cvReleaseImage(&s_range);
	cvReleaseImage(&v_range);
	cvReleaseImage(&hsv_and);

	// удаляем окна
	cvDestroyAllWindows();
	return 0;
}