package ObjectCall;

// Class 1 object calling variables

	public class Outerrun {
		
		public static void main(String[] args) {
			
			// Object create
			Demotest S1 = new Demotest();
					
			// print
			System.out.println(S1.id);
			System.out.println(S1.nameString);
			System.out.println(S1.emailString);
			
			}
	}

	
// Class 2 having Variables
 class Demotest {
		
		int id=20;
		String nameString="shiva";
		String emailString="shiva@gmail.com";
		
		}