package practices;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.xml.crypto.dsig.spec.C14NMethodParameterSpec;

import org.apache.logging.log4j.message.Message;
import org.aspectj.weaver.patterns.IScope;
import org.aspectj.weaver.patterns.ThisOrTargetAnnotationPointcut;
import org.hibernate.boot.model.naming.ImplicitNameSource;
import org.hibernate.internal.build.AllowSysOut;
import org.hibernate.query.NativeQuery.ReturnableResultNode;
import org.hibernate.sql.Template;

import com.fasterxml.jackson.core.sym.Name;
import com.fasterxml.jackson.databind.JsonMappingException.Reference;

import jakarta.annotation.Generated;
import practices.color.demopgm12;

@FunctionalInterface
interface Drawable{
	public void draw();
}

public class lambdaexp{
	public static void main(String[] args) {
		int width=10;
		
		Drawable d2=()->
		{
			System.out.println("Drable"+width);
		};
		d2.draw();
		
	}
	
}

//------------------------------------------------------------------------------//

interface drawthi{
	public void draw();
	
}

 class lambdaex{
	public static void main(String[] args) {
		int width = 10;
		
		drawthi d1 = ()->
		{
			System.out.println("Drawthi"+width);
		};
		
		d1.draw();
		
	}
}

//------------------------------------------------------------------------------//
// 				RUN TIME POLYMORPHISM								//
 

interface color{
	void draw();
	
class demopgm12{
	public void dasa() 
	{
		System.out.println("Dasa");
	}
	
}
	
}

class pgm123 extends demopgm12{
	public static void main(String[] args) {
		
		int triangle = 20;
		
		demopgm12 g2 = new pgm123();
		color g1 = ()->
		{
			System.out.println("triangle size="+triangle);
		};
		
		g1.draw();
		g2.dasa();
	}
}
//--------------------------------------------------Swaping-------------------------------------//

class  shivar{
	public static void main(String[] args) {
		
		int a = 10;
		int b = 20;
		int temp;
		
		
		temp = a;
		a = b;
		b = temp;
		
		System.out.println(a);
		System.out.println(b);
	}
}
 
//---------------------------------------------find largest------------------------------------//

class largestpgm{
	public static void main(String[] args) {
		
		int arr[]= {10,72,32,68,3,99};
		
		int max = arr[0];
		
		for (int i = 0; i < arr.length; i++) {
			for (int j = 1; j < arr.length; j++) {
				
			if (arr[i]<arr[j]) {
				
				System.out.println(arr[i]);
			}else {
				System.out.println(arr[j]);
			}
		}
		}System.out.println(max);
	}
}



//---------------------------------------------find Sorting------------------------------------//

class Sorting{
	public static void main(String[] args) {
		
		int arr[]= {10,72,32,68,3,99};
		
		int i,j,temp;
		
		
		for ( i = 0; i < arr.length; i++) {
			for ( j = i+1; j < arr.length; j++) {
				
				if (arr[i]>arr[j]) {
					
					temp = arr[i];
					
					arr[i]=arr[j];
					
					arr[j] = temp;
					
				}
				
			}
			
		} 	
		for(i=0; i<arr.length; i++)
		{
		System.out.println("Asscending Order"+" "+arr[i]);
		}
	}
}

//------------------------------------------------------------Method reference for the Static----------------------------------//
interface pgms1{
	public void extera();
	
class demomethod{
	
	public static void refer() {
		
		System.out.println("shivaranjan");
	} 
	

public static void main(String[] args) {
		
		pgms1 p1 = demomethod::refer;
		
		p1.extera();
	}
	
	}
}

//----------------------------------------------------------addition of numbers-------------------------------------//


interface addition{
	
	 int add(int a,int b);
}



class add{
	public static void main(String[] args) {
		
		addition a1 = (a,b)->(a+b);
		System.out.println(a1.add(100,200));
	}
}

 //----------------------------------------------------------addition of numbers-------------------------------------//
@FunctionalInterface
interface 	test1{
	String say(String message);
}


class test2{
	public static void main(String[] args) {
		test1 t2 = Message -> {
			return "hellow, "+Message;
		};
		
		System.out.println(t2.say("Welcome to the new world"));
	}
}

//----------------------------------------------------------addition of numbers-------------------------------------//

interface test4{
	
	int add(int a, int b);
}


class test5{
	
	public static void main(String[] args) {
		
		
		// Notice the code
		test4 t4 = (a,b) -> (a+b);
		
		System.out.println(t4.add(300, 600));
	}
}
//----------------------------------------------------------string -------------------------------------//

interface demo1{
	String say(String name);
}

class demo2 {
	
	public static void main(String[] args) {
		

		// Notice the code
		demo1 d1 = name -> {
			
			String str1 = "Welcome to the world,";
			String str2 = str1 + name;
			
			return str2;
		};
		
		System.out.println(d1.say("  "+"The world is Asome!"));
	}
}

//----------------------------------------------------------string -------------------------------------//

class liststring {
	public static void main(String[] args) {
		
	List<String> list = new ArrayList<String>();
	
	list.add("Test1");
	list.add("Test2");
	list.add("Test3");
	
	list.forEach(
			(n) -> System.out.println(n)
			);
	}
}
//----------------------------------------------------------string -------------------------------------//

interface test6{
	int add(int a, int b);
	
}


class test7 {
	public static void main(String[] args) {
		
		test6 t6 = (a,b) -> (a+b);
		System.out.println(t6.add(10, 40));
	}
}





