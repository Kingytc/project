package Thread;

import java.util.Iterator;

class X extends Thread{
	
	
	
	public void run() {
		
		for (int i = 1; i <10; i++) {
			
		System.out.println("1");
		try {
		//	Thread.sleep(100);
			
			Thread t2 =new Thread();
			t2.setPriority(200);
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		}
	}
}

class Y extends Thread{
	public void run() {
		
		for (int i = 1; i < 10; i++) {
			System.out.println("2");
			try {
				Thread t1 = new Thread();
				//t1.setPriority(200);
				
				
				Thread t2 =new Thread();
				t2.setPriority(100);
				
			} catch (Exception e) {
				// TODO: handle exception
			}
		}
		
	}
}
public class MultiThread {
	
	public static void main(String[] args) {
		
		X obj1 = new X();
		Y obj2 = new Y();
		
		obj1.start();
		obj2.start();
	}

}
