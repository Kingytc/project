package practices;

class Emp{
	
	int id;
	String nameString;
	
	
	public Emp(int i, String n) {
		
		id=i;
		nameString=n;
		
	}
	
	 void display() {
		System.out.println(" display"+"  "+id+"  "+nameString);
	}
	
	
	/*
	 * public static void main(String[] args) {
	 * 
	 * Emp obj1 = new Emp(1, "shiva"); Emp obj2 = new Emp(2, "Raju"); Emp obj3 = new
	 * Emp(3, "Rama"); }
	 */
}

public class DefaultConstructor{
	
public static void main(String[] args) {
		
		Emp obj1 = new Emp(1, "shiva");
		Emp obj2 = new Emp(2, "Raju");
		Emp obj3 = new Emp(3, "Rama");
		
		
		obj1.display();
		obj2.display();
		obj3.display();
		
		
	}
}
