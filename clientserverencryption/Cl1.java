import java.util.*;
import java.net.*;
import java.io.*;
import java.lang.*;

class Cl1{
	 public static void main(String[] args) {
	 	try{
	 	Socket s = new Socket("localhost",9000);
		DataOutputStream dout = new DataOutputStream(s.getOutputStream());
		System.out.println("Enter your message : ");
		Scanner sc=new Scanner(System.in);
		String str;
		StringBuilder encrypt=new StringBuilder("");
		str=sc.next();
		for(int i=0;i<str.length();i++){
			if(str.charAt(i)=='a')
				encrypt.append('@');
			else if(str.charAt(i)=='e')
				encrypt.append('$');
			else if(str.charAt(i)=='i')
				encrypt.append('!');
			else if(str.charAt(i)=='o')
				encrypt.append('?');
			else if(str.charAt(i)=='u')
				encrypt.append('&');
			else
				encrypt.append(str.charAt(i));
							
		}
		encrypt.reverse();
		dout.writeUTF(encrypt.toString());
		dout.flush();
		dout.close();
		s.close();
	 }
	 catch(Exception e){
	 	System.out.println(e);
	 }
		
	}
}