/*
 * parsecsv.cpp
 *
 *  Created on: Jul 1, 2015
 *      Author: xpeng
 */




#include<iostream>
#include<string>
#include<fstream>
#include<vector>
#include<dirent.h>



using namespace std;
string path="F:\\shapenet\\ShapeNetCore2015v0\\ShapeNetCore2015v0\\";

bool has_suffix(const string& s, const string& suffix)
{
	return (s.size() >= suffix.size()) && equal(suffix.rbegin(), suffix.rend(), s.rbegin());
}

int main()
{
	DIR *dir = opendir(path.c_str());
	string dst="3dw.9cd4467976a27ac9f3b65283778dd624";
	if(!dir)
		return 1;
	dirent *entry;
	while(entry=readdir(dir))
	{

		if(has_suffix(entry->d_name, ".csv"))
		{
			string csv_path = path+string(entry->d_name);
			fstream file(csv_path.c_str());
			string value;
			while(file.good())
			{
				getline(file, value, '\n');
				size_t found= value.find(dst.c_str());
				if(found!=string::npos)
					cout<<entry->d_name;

			}
			file.close();
		}


	}

}
