package Coductional;

public class Ifcondution {
	
	public static void main(String[] args) {
		
		/*
		 * int a=10; int b=20;
		 */
			
			try {
				/*
				 * 01. String a=" "; String b="20";
				 * 
				 * if (a.equals(" ")) 
				 * { System.out.println("a is empty"); } else {
				 * System.out.println("a is not empty"); }
				 * 
				 * --> a is empty
				 */
		//	------------------------------------------------------------------	//
				
				/*02.
				 * String a=" ", b="20";
				 * 
				 * if (!a.equals(" ")) 
				 * { System.out.println("a is empty"); } else {
				 * System.out.println("a is not empty"); }
				 * 
				 * --> a is not empty
				 */
				
		//	------------------------------------------------------------------	//
		
				/*03.
				 * String a=" ", b="20";
				 * 
				 * if (a.equalsIgnoreCase(" ")) 
				 * { System.out.println("a is empty"); } else {
				 * System.out.println("a is not empty"); }
				 * 
				 * --> a is empty
				 */
		// ------------------------------------------------------------------	//
		 
				/*
				 * String a=" ", b="20";
				 * 
				 * if (!a.equalsIgnoreCase(" ")) { System.out.println("a is empty"); } else {
				 * System.out.println("a is not empty"); }
				 * 
				 * --> a is not empty
				 */
		// ------------------------------------------------------------------	//
		
				  String a=" ", b="20";
				  
				  if (!a.equalsIgnoreCase(" ") || b.equalsIgnoreCase(" ")) 
				  { System.out.println("a is empty"); } else {
				  System.out.println("a is not empty"); }
		 
		 	
			} catch (Exception e) {
			// TODO: handle exception
		}
	}
}