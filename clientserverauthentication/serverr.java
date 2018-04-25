import java.io.*;
import java.net.*;
import java.util.Random;
public class serverr
{
public static void main(String args[])
{
	try
	{
		Socket s= new Socket("localhost",6666);
		Random rand=new Random();
		int n=rand.nextInt(50)+1;
		int opt=n;
		System.out.println(opt);
		DataOutputStream dout= new DataOutputStream(s.getOutputStream());
		dout.writeInt(opt);
		dout.flush();
	}catch(Exception e){System.out.println(e);}
}
}