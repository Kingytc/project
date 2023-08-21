package ObjectCall;

// Create New Object Program

public class Objectcreate {
	
	int a=20;
	String Fname="Shiva";
	char name='B';
	
	public static void main(String[] args) {
		
		
		Objectcreate S=new Objectcreate();
		
		
		System.out.println("All value"+ S);
		System.out.println("integer values="+S.a);
		System.out.println("String value="+"  "+S.Fname);
		System.out.println("char value="+S.name);
	}
	
}