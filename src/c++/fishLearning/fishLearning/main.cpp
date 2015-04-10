
#include "opencv2/core/core.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"
#include <iostream>
#include <fstream>
#include <vector>
#include <sstream>

using namespace cv;
using namespace std;

std::vector<std::string> &mySplit(const std::string &s, char delim, std::vector<std::string> &elems) {
	std::stringstream ss(s);
	std::string item;
	while (std::getline(ss, item, delim)) {
		elems.push_back(item);
	}
	return elems;
}


std::vector<std::string> mySplit(const std::string &s, char delim) {
	std::vector<std::string> elems;
	mySplit(s, delim, elems);
	return elems;
}


bool horizontal = true;

//std::string directoryName = "E:\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 2 - Middle\\LeftFish1_1\\Pos0\\";
//std::string directoryName = "E:\\Reza\\fish_learning\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 2 - Middle\\LeftFish1_1\\Pos0\\";

//std::string directoryName = "E:\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 2 - Middle\\LeftToRightFish1_1\\Pos0\\";

//std::string directoryName = "E:\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 3 - Farthest\\BottomFish_1\\Pos0\\";

//std::string directoryName = "E:\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 1 - Closest\\LeftToRightCross1_1\\Pos0\\";

std::string directoryName = "E:\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 1 - Closest\\RightToLeftToRight_DoubleCrossFish1_1\\Pos0\\";

//std::string directoryName = "E:\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 3 - Farthest\\TopFish_withReflection_1\\Pos0\\";

//std::string directoryName = "E:\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 2 - Middle\\LeftToRightFish1_1\\Pos0\\";

//std::string directoryName = "E:\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 2 - Middle\\LeftToRightFish1_1\\Pos0\\";

//std::string directoryName = "E:\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 3 - Farthest\\BottomToTopFish1_1\\Pos0\\";


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
	//directoryName = "E:\\assey2\\Sample_data\\Larvae_TestingZoom_forReza\\Zoom 2 - Middle\\LeftFish1_1\\Pos0\\";
		//std::vector<std::string> res;
		//res = mySplit(directoryName, '\');
		


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
	std::string outputFileName;
	outputFileName = directoryName + "output.avi";

	outputVideo.open(outputFileName.c_str(), -1, 25.0, s);

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
			cv::Point pos;
			returnThePosition(contours, pos);
			size_t height = image.size().height;
			size_t width = image.size().width;
			cv::Mat out;
			cv::Mat in[] = { image, image, image };
			cv::merge(in, 3, out);

			circle(out, pos, 4, cv::Scalar(255, 0, 0), 2);

			std::string descriptor;

			if (horizontal)
			{
				line(out, cv::Point(width / 2, 0), cv::Point(width / 2, height), cv::Scalar(0, 0, 255), 3, 4);

				if (pos.x < width / 2)
					descriptor = "Left";
				else
					descriptor = "Right";
			}
			else
			{

				line(out, cv::Point(0, height/2), cv::Point(width, height/2), cv::Scalar(0, 0, 255), 3, 4);

				if (pos.y < height / 2)
					descriptor = "Top";
				else
					descriptor = "Bottom";

			}


			char str[1000];
			sprintf(str, "Frame # : %.6d", frameNumber);
			int XBias = 500;
			int YBias = 100;
			cv::putText(out, str, cv::Point(width - XBias, YBias + 10), FONT_HERSHEY_COMPLEX_SMALL, 1.5, cv::Scalar(255, 255, 255), 1, CV_AA);

			sprintf(str, "x =%.3d, y = %.3d", pos.x, pos.y);
			cv::putText(out, str, cv::Point(width - XBias, YBias + 110), FONT_HERSHEY_COMPLEX_SMALL, 1.5, cv::Scalar(255, 255, 255), 1, CV_AA);

			cv::putText(out, descriptor.c_str(), cv::Point(width - XBias, YBias + 210), FONT_HERSHEY_COMPLEX_SMALL, 1.5, cv::Scalar(255, 255, 255), 1, CV_AA);



			imshow("output", out);

			if (outputVideo.isOpened())
			{
				outputVideo << out;

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