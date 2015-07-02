/*
 * parsecsv.cpp
 *
 *  Created on: Jul 1, 2015
 *      Author: xpeng
 */




#include<iostream>
#include<string>
#include<fstream>

using namespace std;
string path="F:\\shapenet\\ShapeNetCore2015v0\\ShapeNetCore2015v0\\04379243.csv";
string desk_path="F:\\shapenet\\desk.txt";
string table_path="F:\\shapenet\\table.txt";
int main()
{
	//cout<<path<<endl;
	ifstream file(path.c_str());

	ofstream desk, table;
	desk.open(desk_path.c_str());
	table.open(table_path.c_str());
	string value;
	int i=0;
	while(file.good())
	{
		i++;
		getline(file, value, '\n');

		size_t found = value.find("desk");
		if(found!=string::npos)
		{
			size_t comma = value.find(",");
			desk<<"\""<<string(value, 4,comma-4)<<"\",";
		}
		 found = value.find("table");
		if(found!=string::npos)
		{
			size_t comma = value.find(",");
			table<<"\""<<string(value, 4,comma-4)<<"\",";
		}
	}
	file.close();
	desk.close();
	table.close();


}
