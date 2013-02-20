//
// пример использования CvAdaptiveSkinDetector
//
// robocraft.ru
//

#include <cv.h>
#include <highgui.h>
#include <cvaux.h> // для CvAdaptiveSkinDetector

#include <stdlib.h>
#include <stdio.h>

int main(int argc, char* argv[])
{
	IplImage* image=0, *dst=0, *mask=0;

	// имя картинки задаётся первым параметром
	const char* filename = argc >= 2 ? argv[1] : "Image0.jpg";
	// получаем картинку
	image = cvLoadImage(filename, 1);

	printf("[i] image: %s\n", filename);
	assert( image != 0 );

	// покажем изображение
	cvNamedWindow( "original");
	cvShowImage( "original", image );

	// картинка для хранения изображения
	dst = cvCloneImage(image);

	// детектор кожи
	CvAdaptiveSkinDetector filter(1, CvAdaptiveSkinDetector::MORPHING_METHOD_ERODE); // MORPHING_METHOD_ERODE_DILATE

	// картинка для хранения результата (маски)
	mask = cvCreateImage( cvGetSize(image), IPL_DEPTH_8U, 1);

	// обработка
	filter.process(image, mask);

	// покажем маску
	cvNamedWindow( "mask");
	cvShowImage( "mask", mask);

	// пробегаемся по всем пикселям изображения
	// и увеличиваем у пикселей картинки, где установлена маска
	// зелёную компоненту до максимума
	for( int y=0; y<dst->height; y++ ) {
		uchar* ptr = (uchar*) (dst->imageData + y * dst->widthStep); // изображение
		uchar* ptrM = (uchar*) (mask->imageData + y * mask->widthStep); // маска
		for( int x=0; x<dst->width; x++ ) {
			if(ptrM[x]){ // маска установлена
				// 3 канала 
				//ptr[3*x] = ; // B
				ptr[3*x+1] = 255; // G
				//ptr[3*x+2] = ; // R
			}
		}
	}

	// покажем  картинку
	cvNamedWindow( "dst");
	cvShowImage( "dst", dst );

	// ждём нажатия клавиши
	cvWaitKey(0);

	// освобождаем ресурсы
	cvReleaseImage(& image);
	cvReleaseImage(&dst);
	cvReleaseImage(&mask);

	// удаляем окна
	cvDestroyAllWindows();
	return 0;
}
