import java.util.*;
import java.io.*;
import java.net.*;

class Se1{
	 public static void main(String[] args) {
	 	try {
		ServerSocket ss = new ServerSocket(9000)	;
		Socket s=ss.accept();
		DataInputStream dis= new DataInputStream(s.getInputStream());
		String str,str1;
		StringBuilder decrypt = new StringBuilder("");
		str1 = (String)dis.readUTF();
		StringBuilder sr= new StringBuilder(str1);
		str=sr.reverse().toString();
		System.out.println("The encrypted message is : "+str1);
		for(int i=0;i<str.length();i++){
			if(str.charAt(i)=='@')
				decrypt.append('a');
			else if(str.charAt(i)=='$')
				decrypt.append('e');
			else if(str.charAt(i)=='!')
				decrypt.append('i');
			else if(str.charAt(i)=='?')
				decrypt.append('o');
			else if(str.charAt(i)=='&')
				decrypt.append('u');
			else
				decrypt.append(str.charAt(i));
							
		}

		System.out.println("The decrypted message is : "+decrypt.toString());
		
		ss.close();
	}
	catch(Exception e){
		System.out.println(e);
	}
	}
}