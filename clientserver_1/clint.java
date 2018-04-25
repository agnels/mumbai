import java.util.*;
import java.io.*;
import java.net.*;
public class clint
{
public static void main(String args[])
{
	try
	{
		Socket s=new Socket("localhost",6666);
		DataOutputStream dout= new DataOutputStream(s.getOutputStream());
		String str;
		Scanner sc = new Scanner(System.in);
		System.out.println("Enter your message");
		str=sc.next();
		dout.writeUTF(str);
		dout.flush();
		dout.close();
		s.close();		
	}catch(Exception e){System.out.println(e);}
}
}
