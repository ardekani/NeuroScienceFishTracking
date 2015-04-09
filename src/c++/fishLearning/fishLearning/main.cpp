
#include "opencv2/core/core.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"
#include <iostream>
#include <fstream>
using namespace cv;
using namespace std;

//std::string directoryName = "E:\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 2 - Middle\\LeftFish1_1\\Pos0\\";

std::string directoryName = "E:\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 3 - Farthest\\BottomFish_1\\Pos0\\";

//std::string directoryName = "E:\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 1 - Closest\\LeftToRightCross1_1\\Pos0\\";


int readframe(int frameNumber, cv::Mat& frame)
{
	char fileName[1000];
	sprintf(fileName, "%simg_%.9i_Default_000.tif", directoryName.c_str(), frameNumber);
	frame = imread(fileName, CV_LOAD_IMAGE_GRAYSCALE);
	if (!frame.data)
	{
		std::cout << "Could not open or find the image:" << fileName << std::endl;
		return -1;
	}
	return 0;
}

int calculateBackgroundModel(int firstFrame, int lastFrame, int NumOfFramesToUse, cv::Mat &m_currBackGroundModel)
{
	cv::Mat curFrame;
	readframe(firstFrame, curFrame);
	m_currBackGroundModel = curFrame;
	int countRun = 1;
	for (int i = firstFrame; i < lastFrame; i++)
	{
		
		readframe(i, curFrame);
		cv::addWeighted(curFrame, 1.0 / (countRun + 1), m_currBackGroundModel, 1.0*countRun / (countRun + 1), 0.0, m_currBackGroundModel);
		cv::imshow("aa", curFrame);
		cv::imshow("bg", m_currBackGroundModel);
		cvWaitKey(10);
		countRun++;
	}

	cv::imshow("final background", m_currBackGroundModel);
	cvWaitKey(-1);

	return 0;
}

int main(int argc, char** argv)
{
	//std::string directory = "E:\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 2 - Middle\\LeftFish1_1\\Pos0\\";
	Mat image;
	int frameNumber = 1;
	cv::Mat bg;
	calculateBackgroundModel(1, 499, 10, bg);
	//cv::imshow("calculated BG", bg);
	//getchar();

	//for (int frameNumber = 0; frameNumber < 499; frameNumber++)
	//{
	//
	//	if (!readframe(frameNumber, image))
	//	{
	//		cv::imshow("Display window", image);
	//		cv::waitKey(30);
	//	}
	//}

	for (int frameNumber = 0; frameNumber < 499; frameNumber++)
	{
		ofstream fn;
		fn.open("output.csv");
		if (!readframe(frameNumber, image))
		{
			cv::Mat diff = bg - image;
			cv::imshow("Display window", diff);
			//fn << cv::format(diff, "CSV");
			//fn.close();
			//getchar();
			Mat canny_output;
			vector<vector<Point> > contours;
			vector<Vec4i> hierarchy;
			int thresh = 50;
			RNG rng(12345);
			cv::Mat _img;
			//cv::threshold(diff, _img, 0, 255, CV_THRESH_BINARY | CV_THRESH_OTSU);
			cv::threshold(diff, _img, 10, 255, CV_THRESH_BINARY);

			


			imshow("_img", _img);

			//cvWaitKey(-1);

			Canny(diff, canny_output, thresh, thresh * 2, 3);
			/// Find contours
			//findContours(canny_output, contours, hierarchy, CV_RETR_TREE, CV_CHAIN_APPROX_SIMPLE, Point(0, 0));

			findContours(_img, contours, hierarchy, CV_RETR_TREE, CV_CHAIN_APPROX_SIMPLE, Point(0, 0));
			for (int i = 0; i < contours.size(); i++)
			{
				std::cout << "contour[" << i << "].size() = " << contours[i].size() << std::endl;;


			}
			/// Draw contours
			Mat drawing = Mat::zeros(canny_output.size(), CV_8UC3);
			for (int i = 0; i< contours.size(); i++)
			{
				Scalar color = Scalar(rng.uniform(0, 255), rng.uniform(0, 255), rng.uniform(0, 255));
				drawContours(drawing, contours, i, color, 2, 8, hierarchy, 0, Point());
			}

			/// Show in a window
			namedWindow("Contours", CV_WINDOW_AUTOSIZE);
			imshow("Contours", drawing);

			std::cout << "frame : " << frameNumber << std::endl;

			cv::waitKey(30);
		}
	}

	
	return 0;

}