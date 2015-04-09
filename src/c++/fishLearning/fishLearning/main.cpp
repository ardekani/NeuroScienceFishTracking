
#include "opencv2/core/core.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"
#include <iostream>
#include <fstream>
#include <vector>
using namespace cv;
using namespace std;

std::string directoryName = "E:\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 2 - Middle\\LeftFish1_1\\Pos0\\";
//std::string directoryName = "E:\\Reza\\fish_learning\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 2 - Middle\\LeftFish1_1\\Pos0\\";
//std::string directoryName = "E:\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 3 - Farthest\\BottomFish_1\\Pos0\\";

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

int returnThePosition(std::vector < std::vector < cv::Point >> allContours, cv::Point &pos)
{
	std::cout << "i am here" << std::endl;
	if (allContours.size() < 1) //contour list is empty
	{
		pos.x = 0;
		pos.y = 0;
		std::cout << "did not find the fish\n";
		return -1;
	}
	//first find the largest contour
	size_t maxLenID = 0;
	for (size_t i = 1; i < allContours.size(); i++)
	{
		if (allContours[i].size()>allContours[maxLenID].size())
		{
			maxLenID = i;
		}
	}
	//now find the center of the contour - using cvRect
	cv::Rect rct = cv::boundingRect(Mat(allContours[maxLenID]));
	pos.x = rct.x + rct.width / 2;
	pos.y = rct.y + rct.height / 2;

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
//		cv::imshow("bg", m_currBackGroundModel);
		cvWaitKey(1);
		countRun++;
	}

//	cv::imshow("final background", m_currBackGroundModel);
//	cvWaitKey(-1);

	return 0;
}

int main(int argc, char** argv)
{
	//std::string directory = "E:\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 2 - Middle\\LeftFish1_1\\Pos0\\";
	Mat image;
	int frameNumber = 1;
	int firstFrame = 1;
	int lastFrame = 499;
	cv::Mat bg;
	calculateBackgroundModel(firstFrame, lastFrame, 10, bg);
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


	VideoWriter outputVideo;
	
	readframe(0, image);
	cv:Size s = image.size();
	outputVideo.open("output.avi", -1, 25.0, s);

	for (int frameNumber = 0; frameNumber < 499; frameNumber++)
	{
		//ofstream fn;
		//fn.open("output.csv");
		//fn << cv::format(diff, "CSV");
		//fn.close();
		//getchar();

		if (!readframe(frameNumber, image))
		{
			cv::Mat diff = bg - image;
			//cv::imshow("Display window", diff);
			Mat canny_output;
			int cannythresh = 50;
			int simpleThresh = 10;
			RNG rng(12345);
			cv::Mat _img;
			//cv::threshold(diff, _img, 0, 255, CV_THRESH_BINARY | CV_THRESH_OTSU);
			cv::threshold(diff, _img, simpleThresh, 255, CV_THRESH_BINARY);

			//imshow("_img", _img);

			//cvWaitKey(-1);

			//Canny(diff, canny_output, thresh, thresh * 2, 3);
			/// Find contours
			//findContours(canny_output, contours, hierarchy, CV_RETR_TREE, CV_CHAIN_APPROX_SIMPLE, Point(0, 0));

			vector<vector<Point> > contours;
			vector<Vec4i> hierarchy;
			findContours(_img, contours, hierarchy, CV_RETR_TREE, CV_CHAIN_APPROX_SIMPLE, Point(0, 0));

			//for (int i = 0; i < contours.size(); i++)
			//{
			//	std::cout << "contour[" << i << "].size() = " << contours[i].size() << std::endl;;
			//}

			/// Draw contours
			//Mat drawing = Mat::zeros(canny_output.size(), CV_8UC3);
			//for (int i = 0; i< contours.size(); i++)
			//{
			//	Scalar color = Scalar(rng.uniform(0, 255), rng.uniform(0, 255), rng.uniform(0, 255));
			//	drawContours(drawing, contours, i, color, 2, 8, hierarchy, 0, Point());
			//}

			//Mat biggest = Mat::zeros(canny_output.size(), CV_8UC3);
			//cv::Point pos;
			//
			//returnThePosition(contours, pos);
			//circle(biggest, pos, 4, cv::Scalar(255, 0, 0), 1);
			//imshow("BIGGEST", biggest);
			returnThePosition(contours, pos);
			circle(image, pos, 4, cv::Scalar(255, 0, 0), 1);
			size_t height = image.size().height;
			size_t width = image.size().height;

			if (outputVideo.isOpened())
			{
				outputVideo << image;

			}
			/// Show in a window
			//namedWindow("Contours", CV_WINDOW_AUTOSIZE);
			//imshow("Contours", drawing);

			std::cout << "frame : " << frameNumber << std::endl;

			cv::waitKey(1);
		}
		//outputVideo.release();

	}

	
	return 0;

}