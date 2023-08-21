package practices;

import java.util.FormatFlagsConversionMismatchException;
import java.util.Iterator;

import com.fasterxml.jackson.databind.node.BooleanNode;

public class PrimeNo {
	

		  public static void main(String[] args) {

		    int num = 20;
		    boolean flag = false;
		    for (int i = 2; i <= num / 2; ++i) {
		    	
		    	
		      // condition for nonprime number
		      if (num % i == 0) {
		        flag = true;
		        break;
		        }
		      System.out.println(num);
		    }
		    	
		    
		    if (!flag && num==1)
		      System.out.println(num + " is a prime number.");
		    else
		      System.out.println(num + " is not a prime number.");
		  }
		}


class primecheck {
	public static void main(String[] args) {
		
		int num =10;
		boolean flag = false;
		for (int i = 2; i < num/2; i++) {
			
			if (num % i == 0) {
				flag = true;
				break;
			}
				
				System.out.println(num);
				
			}
			if ( !flag && num == 1) {
				System.out.println("prime");
			}
				else {
				System.out.println("not prime");
				}
				
			}
		}

class reverose {
	public static void main(String[] args) {
		
		String name = "shiva";
		char ch;
		String nstr="";
		
		
		
		for (int i = 0; i <name.length(); i++) {
			
			ch = name.charAt(i);
				nstr = ch+nstr;
				
		}
		System.out.println(nstr);
	}
}
		
		
	

