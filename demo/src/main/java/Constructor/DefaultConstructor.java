package Constructor;

import org.hibernate.internal.build.AllowSysOut;


//<------------------------------------------------------------------------------------------------------------>
												/*Default Constructor*/ 

class Bike {
	
	public Bike() {
	System.out.println("Bike Constructor Created");
	}
	
	public static void main(String[] args) {
	
		Bike objBike = new Bike();
	}
}

// <------------------------------------------------------------------------------------------------------------>

										/* Default Constructor with values */
	class Student {
		
		int id;
		String name;
		
		void display() {
			System.out.println(id+" "+name);
		}
		
		public static void main(String[] args) {
			
			Student obj1 = new Student();
			Student obj2 = new Student();
			
			obj1.display();
			obj2.display();
		}
	}
// <------------------------------------------------------------------------------------------------------------->
	
											/* Parameterized Constructor */
	
	class Emp{
		
		int id;
		String name;
		String email;
		
		public Emp(int i,String n,String e) {
			
			id = i;
			name = n;
			email = e;
		}
		
		void display() {
			System.out.println(id+" "+name+" "+email);
		}
		public static void main(String[] args) {
			
			Emp e1 = new Emp(10,"shiva","shiva@gmail.com");
			Emp e2 = new Emp(20,"Rama","Rama@gmail.com");
			Emp e3 = new Emp(30,"Krishna","Krishna@gmail.com");
			
			e1.display();
			e2.display();
			e3.display();
		}
		
	}
	
	
	
	
	
	
	
	
	