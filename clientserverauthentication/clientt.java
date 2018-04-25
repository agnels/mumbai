import java.io.*;
import java.net.*;
import java.util.*;
public class clientt
{
public static void main(String args[])
{
	try
	{
		ServerSocket ss=new ServerSocket(6666);
		Socket s=ss.accept();
		DataInputStream dis=new DataInputStream(s.getInputStream());
		int opt=dis.readInt();
		System.out.println("Put OTP and press enter!");
		int validation;
		System.out.println("OTP=");
		Scanner sc=new Scanner(System.in);
		validation=sc.nextInt();
		if(opt==validation)
		{
			System.out.println("Authenticated");
		}
		else
		{
			System.out.println("Not Authenticated");
		}
		ss.close();
	}catch(Exception e){System.out.println(e);}
}
}