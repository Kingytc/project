package practices;

import org.apache.catalina.filters.AddDefaultCharsetFilter;
import org.hibernate.sql.Template;
import org.thymeleaf.spring6.util.SpringReactiveModelAdditionsUtils;

public class Swapingno {
	
	public static void main(String[] args) {
		
		int a = 10;
		int b = 20;
		int temp;
		System.out.println("Before swaping the a and b numbers ");
		System.out.println("a="+a);
		System.out.println("b="+b);
		
		temp = a;
		a = b;
		b = temp;
		
		System.out.println("After swaping the a and b numbers");
		System.out.println("a="+a);
		System.out.println("b="+b);
		
	}
}


//--------------------------------------------------------------------------end of the swaping---------------------------------------------//

class programno1{
	public static void main(String[] args) {
		String name = "shiva";
		String lname = "ranjan";
		
		System.out.println((name+lname));
		
	}
	
	
}