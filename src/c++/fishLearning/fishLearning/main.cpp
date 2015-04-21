
#include "opencv2/core/core.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"
#include <iostream>
#include <fstream>
#include <vector>
#include <sstream>

using namespace cv;
using namespace std;


bool horizontal = true;

//std::string directoryName = "E:\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 2 - Middle\\LeftFish1_1\\Pos0\\";
//std::string directoryName = "E:\\Reza\\fish_learning\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 2 - Middle\\LeftFish1_1\\Pos0\\";

//std::string directoryName = "E:\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 2 - Middle\\LeftToRightFish1_1\\Pos0\\";

//std::string directoryName = "E:\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 3 - Farthest\\BottomFish_1\\Pos0\\";

//std::string directoryName = "E:\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 1 - Closest\\LeftToRightCross1_1\\Pos0\\";

//std::string directoryName = "E:\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 1 - Closest\\RightToLeftToRight_DoubleCrossFish1_1\\Pos0\\";

//std::string directoryName = "E:\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 3 - Farthest\\TopFish_withReflection_1\\Pos0\\";

//std::string directoryName = "E:\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 2 - Middle\\LeftToRightFish1_1\\Pos0\\";

//std::string directoryName = "E:\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 2 - Middle\\LeftToRightFish1_1\\Pos0\\";

//std::string directoryName = "E:\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 3 - Farthest\\BottomToTopFish1_1\\Pos0\\";

std::string directoryName = "C:\\Larvae_TestingZoom_forReza\\Zoom 1 - Closest\\RightToLeftToRight_DoubleCrossFish1_1\\Pos0\\";



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

int calculateBackgroundModel(int firstFrame, int lastFrame, int stepSize, cv::Mat &m_currBackGroundModel)
{
	std::cout<<"Building background model.."<<std::endl;
	cv::Mat curFrame;
	readframe(firstFrame, curFrame);
	m_currBackGroundModel = curFrame;
	int countRun = 1;
	for (int i = firstFrame; i < lastFrame; i=i+stepSize)
	{
		
		readframe(i, curFrame);
		cv::addWeighted(curFrame, 1.0 / (countRun + 1), m_currBackGroundModel, 1.0*countRun / (countRun + 1), 0.0, m_currBackGroundModel);
//		cv::imshow("currentFrame", curFrame);
//		cv::imshow("bg", m_currBackGroundModel);
//		cvWaitKey(1);
		countRun++;
	}

	std::cout<<"Done!"<<std::endl;

	return 0;
}

int main(int argc, char** argv)
{
	if(argc>1)
	{
		directoryName=argv[1];
	}


	cv::Mat image;
	int frameNumber = 1;
	int firstFrame = 0;
	int lastFrame = 499;
	cv::Mat bg;
	calculateBackgroundModel(firstFrame, lastFrame, 1, bg);

	//VideoWriter outputVideo;
	//
	//readframe(0, image);
	//cv:Size s = image.size();
	//std::string outputFileName;
	//outputFileName = directoryName + "output.avi";

	//outputVideo.open(outputFileName.c_str(), -1, 25.0, s);

	for (int frameNumber = firstFrame; frameNumber < lastFrame; frameNumber++)
	{

		if (!readframe(frameNumber, image))
		{
			// find contours in current frame
			cv::Mat diff = bg - image;
			int simpleThresh = 10;
			cv::Mat _img;

			cv::threshold(diff, _img, simpleThresh, 255, CV_THRESH_BINARY);
			vector<vector<Point> > contours;
			vector<Vec4i> hierarchy;
			findContours(_img, contours, hierarchy, CV_RETR_TREE, CV_CHAIN_APPROX_SIMPLE, Point(0, 0));

			//find the position of the fish
			cv::Point pos;
			returnThePosition(contours, pos);
			size_t height = image.size().height;
			size_t width = image.size().width;

			std::string descriptor;

			if (horizontal)
			{
				if (pos.x < width / 2)
					descriptor = "Left";
				else
					descriptor = "Right";
			}
			else
			{
				if (pos.y < height / 2)
					descriptor = "Top";
				else
					descriptor = "Bottom";
			}

			std::cout << "frame : " << frameNumber << std::endl;

			cv::waitKey(1);
		}
	}

	
	return 0;

}