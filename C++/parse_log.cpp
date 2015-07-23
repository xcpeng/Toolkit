/*
 * parse.cpp
 *	This file is written to parse the log file accuracy
 *
 *  Created on: Jul 23, 2015
 *      Author: xpeng
 */



#include<iostream>
#include<fstream>
#include<string>
#include<sstream>
#include<stdio.h>
#include<string.h>
#include <vector>
#include <math.h>
#include <stdlib.h>
using namespace std;

const int interation = 105;
const string fname="C:\\Users\\xpeng\\Desktop\\multi_full.log";
const string template_str="Testing net";
double result[interation]={};

int main()
{
	ifstream infile(fname.c_str());
	if(!infile)
	{
		cout<<"file not found"<<endl;
		return -1;
	}

	string line;
	int j = 0,i=0;

	while(getline(infile, line)) //read the file line by line
	{
		//find the line with the template string
		if(strstr(line.c_str(), template_str.c_str())!=0)
		{
			getline(infile, line); //get the next line to get the accuracy
			const char *s;
			s = strchr(line.c_str(), '=');//return the first pointer that have the char
			double x = atof(s+1);
			result[j] =x;
			j++;

		}
	}
	infile.close();
	for(i=0;i<j;i++)
		cout<<result[i]<<endl;
	return 0;

}

