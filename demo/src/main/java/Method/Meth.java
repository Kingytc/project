package Method;

import java.security.PublicKey;

import org.springframework.context.support.StaticApplicationContext;

//----------------------------------------------------Method overloading----------------------------------------------------------------//

class Adder{  
			 static int  add(int a,int b)
			{return a+b;}  
			 static int add(int a,int b,int c)
			{return a+b+c;}  
		}  
			
		class TestOverloading1{  
			public static void main(String[] args){  
			System.out.println(Adder.add(11,11));  
			System.out.println(Adder.add(11,11,11));  
			}
		}  

//----------------------------------------------------Method overloading----------------------------------------------------------------//
		
		class sum{
			
		static int sum( int a,final int b) {
			return a+b;
		}
		static int sum(int a,int b,int c) {
			return a+b+c;
		}
		
		class overloading{
			public static void main(String[] args) {
				System.out.println(sum(10, 20));
				System.out.println(sum(10, 20, 30));
			}
			
		}
	}
//------------------------------------------------------Method OverRiding----------------------------------------------------------------//
		
		
		// parent class
		class Box{
			
			void color(){
				System.out.println(" the color is yellow");
						
			}
		}
		
		// Sub/child class extends parent class
		class Black extends Box{
			
			public static void main(String[] args) {
				
				Black b1 = new Black();
				b1.color();
				
			}
		}
		
		
		
		