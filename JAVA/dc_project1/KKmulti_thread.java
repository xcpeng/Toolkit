
import java.net.*;
import java.io.*;

/*********************************************************
 * Copyright (c) 2015, Xingchao Peng
 * 
 * This file is a part of Xingchao Peng's Project1 for data
 * communication and is available  under the terms of the
 * Simplified BSD License provided in  LICENSE. Please retain
 * this notice and LICENSE if you use this file 
 * (or any portion of it) in your project.
 * @author xpeng
 *
 **********************************************************/

public class KKmulti_thread extends Thread {
	//some error information
	private static String Response_200="HTTP/1.0 200 OK\r\nServer: Written"
			+ " By Xingchao Peng\r\n"
			+ "Content-Type: text\\html \r\nWhat's the fox say???:bia~bia~bia \r\n\r\n";
	private static String Response_404="404 Not Found \r\nHe has gone to "
			+ "California\r\nHe has gone to"
			+ "Texas\r\nHe has gone to China\r\nHe has gone to moon\r\n"
			+ "He is now with Xingchao\r\nHe "
			+ "becomes Luminiferous aether\r\nAnyway, "
			+ "you can't find him in this server!";
	private Socket socket = null;

	public KKmulti_thread(Socket socket) {
		super("KKmulti_thread");
		this.socket = socket;
	}

	public void run() {

		try (
				//build the PrintWriter and BufferedReader to complete the information
				//exchange between the server and the client.
				PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
				BufferedReader in = new BufferedReader(
						new InputStreamReader(
								socket.getInputStream()));
				) {
			String inputLine;
			System.out.println("New thread have been build with the thread ID: ");
			System.out.println(Thread.currentThread().getId());

			inputLine = in.readLine();
			//Case 1: this request comes from some browser or 
			//Case 2: this request comes from myClient
			//For this two case, they are both GET request
			if (!inputLine.contains("PUT"))
			{
				File f = new File("index.html"); 	//open the file
				if(f.exists() && !f.isDirectory())	//Check if the file exists
				{
					out.println(Response_200);		//sending head information
					FileInputStream FIS =new FileInputStream(f);
					//build a Buffered Reader to open the file and send it to the 
					//server
					BufferedReader br = new BufferedReader(new InputStreamReader(FIS));
					String html_line =null;
					while((html_line = br.readLine())!= null)
					{
						out.println(html_line);
					}
					out.println("\r\n\r\n");
					br.close();
				}
				else
					//Otherwise send 404 NOT FOUND back to the client 
					out.println(Response_404);
			}

			//Case 3: this request comes from MyClient and it's a PUT request
			if(inputLine.contains("PUT"))
			{
				//Open a file to get the file 
				File f = new File("test_server.txt");
				//Check wheate the file exists, if not build it, otherwise, delete 
				//the old one and build the new one 
				if(f.exists() && !f.isDirectory())
				{
					try{
						if(f.delete())
						{
							System.out.println(f.getName() + " is existing on the server, "
									+ "but now removed to receive new file");
						}
						else System.out.println("Delete file failed");
					}catch(Exception e)
					{
						e.printStackTrace();
					}
				}
				//Sending the confirmation information back to the client 
				out.println("200 OK File Created");
				out.flush();

				System.out.println("Receiving files from the client, it has been"
						+ "saved to test_server.txt and the content is:\r\n");

				//Build the file and get the file from the Client and then
				//write it to the local file
				Writer writer = new BufferedWriter(new OutputStreamWriter(
						new FileOutputStream(f)));
				while ((inputLine = in.readLine()) != null) {
					System.out.println(inputLine);
					writer.write(inputLine+"\r\n");

				}
				writer.close();
			}

			socket.close();			//close the socket
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}