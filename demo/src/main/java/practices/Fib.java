package practices;


//  Fibonacci Series with out using recursion in java

public class Fib {
	
	public static void main(String[] args) {
		
		int n1=0, n2=1,n3,count=10;
		
		//System.out.println(n1+" "+n2);
		System.out.println(n1);
		System.out.println(n2);
		for (int i = 2; i<count; i++) {
			
			n3=n1+n2;
			n1=n2;
			n2=n3;
			System.out.println(n3);
			
			
			
			
		}
	}

}
//------------------------------------------------------------------------------------------>//
 

// Fibonacci Series using recursion in java
class Fibo{
	
	static int n1=0,n2=1,n3=0;
	static void fib(int count) {
		if (count>0) {
			n3=n1+n2;
			n1=n2;
			n2=n3;
			System.out.println(n3);
			fib(count-1);
		}
	}
	
	public static void main(String[] args) {
		
		int count=10;
		// System.out.println(n1+"  "+n2);
		System.out.println(n1);
		System.out.println(n2);
		fib(count-2);
		
	}
	
}