package Thread;

class A extends Thread{
	
	int i;

	public void run()
	{
		for(i=1; i<10; i++) {
		System.out.println("hi");
		try {
			Thread.sleep(100);
		} catch (Exception e) {
			// TODO: handle exception
		}
		}
	}
}


class B extends Thread{
	
	int i;
	public void run()
	{	
		for(i=1; i<10; i++)
		{
		System.out.println("hellow");
		try {
			Thread.sleep(100);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	}
}


public class Demo {
	
	public static void main(String[] args) {
		
		
		
		A obj1 = new A();
		B obj2 = new B();
		
		obj1.start();
		obj2.start();
		
	}
}
