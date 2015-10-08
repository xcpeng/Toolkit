

import java.io.*;
import java.net.Socket;
import java.net.UnknownHostException;

/*********************************************************
 * Copyright (c) 2015, Xingchao Peng
 * 
 * This file is a part of Xingchao Peng's Project 1 for data
 * communication and is available  under the terms of the
 * Simplified BSD License provided in  LICENSE. Please retain
 * this notice and LICENSE if you use this file 
 * (or any portion of it) in your project.
 * @author xpeng
 *
 **********************************************************/

public class MyClient {
	private String host;
	private int port;
	private String filename;
	private String method;


	// construction function
	public MyClient(String host, int port, String method,String filename)
	{
		this.host = host;			//the host we want to connect
		this.port = port;			//the port number we will use 
		this.method = method;		//PUT or GET method
		this.filename = filename;	//the filename we want to fetch
	}

	
	/*******************************************************
	 * When the Client Object has been built, it will use this
	 * connect function to get response to the GET and PUT method
	 * *****************************************************/
	public void connect()
	{
		//trying to build the socket and get the error.
		try{

			Socket client = new Socket(host, port);	//build the socket 
			if (method.equals("GET")) 			//GET method
				responseSocket(client);
			else
				responseSocket_PUT(client);		//PUT method
		}catch(UnknownHostException uhe)		//handle the UnknownException
		{
			System.out.println("unknown host: " + host);
			uhe.printStackTrace();
		}catch(IOException ioex)
		{
			System.out.println("IOException:  " + ioex);
			ioex.printStackTrace();
		}
	}

	/*******************************************************
	 * This function is use to handle the GET method, after
	 * the PrintWriter has send message to the server, the 
	 * client will wait to response information form the server
	 * and display it
	 * *****************************************************/
	
	public void responseSocket(Socket client) throws IOException
	{
		PrintWriter s_out = new PrintWriter( client.getOutputStream(), true);
		s_out.println( "GET /"+filename+" HTTP/1.0\r\n");	//sending the GET information
		s_out.println("host: " + host+"\r\n\r\n");
		
		//Using BufferedReader to read the information returned by the server. 
		BufferedReader br =new BufferedReader(new InputStreamReader(client.getInputStream()));
		String output;
		while((output = br.readLine())!=null)
			System.out.println(output);
		br.close();
	}

	public void responseSocket_PUT(Socket client) throws IOException
	{
		PrintWriter s_out = new PrintWriter(client.getOutputStream(),true);
		
		
		s_out.println("PUT test.txt");	//Sending the PUT information to the server
		File f = new File("test.txt");	//Open the file we need to PUT
		if(f.exists() && !f.isDirectory())
		{
			FileInputStream FIS =new FileInputStream(f);
			BufferedReader br = new BufferedReader(new InputStreamReader(FIS));
			String html_line =null;
			while((html_line = br.readLine())!= null) //read each line and send to server
			{
				System.out.println(html_line);
				s_out.println(html_line);
			}
			br.close();
		}
	}

	public static void main(String[] args){
		String host = "www.google.com";
		String filename = "index.html";
		String method = "GET";
		int port = 80;
		if(args.length >0 )
		{
			host = args[0];
		}
		if(args.length >1)
		{
			port = Integer.parseInt(args[1]);
		}
		if(args.length >2)
		{
			method=args[2];
		}
		if(args.length >3)
		{
			filename = args[4];
		}
		//Build the Client Objec and use the connect function to connect
		MyClient client = new MyClient(host, port, method ,filename);
		client.connect();


	}
}