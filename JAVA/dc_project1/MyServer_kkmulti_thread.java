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

public class MyServer_kkmulti_thread {


	public static void main(String[] args) throws IOException {

		if (args.length != 1) {
			System.err.println("Usage: java KKMultiServer <port number>");
			System.exit(1);
		}

		int portNumber = Integer.parseInt(args[0]);
		boolean listening = true;

		try (ServerSocket serverSocket = new ServerSocket(portNumber)) { 
			//build the KKmulti_thread to make it multi-thread style
			while (listening) {
				new KKmulti_thread(serverSocket.accept()).start();
			}
		} catch (IOException e) {
			System.err.println("Could not listen on port " + portNumber);
			System.exit(-1);
		}
	}
}
