package practices;

import org.springframework.web.client.HttpClientErrorException.Forbidden;

import com.fasterxml.jackson.core.sym.Name;

/*public class CountString {
	
	public static void main(String[] args) {
		
		String name = "qw qwert qwertyui";
		int count =0;
		
		
		
		 try {
			for(int i = 0; i < name.length(); i++) 
			 {    
			       // if(name.charAt(i) !=' ')   --->  space not consider. 
			            count++;   
			 }
			
			System.out.println(count);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}*/

// <------------------------------------------------------------------------------------------------------------------------->

class shiva{
	
	public static void main(String[] args) {
			
	String name=" qwe qwe qwe ";
	int Count =0;
	try {
		for(int i=0; i<name.length(); i++ ){
			if (name.charAt(i)!=' ') {
				Count++;
				
			}
		}
		
	} catch (Exception e) {
		// TODO: handle exception
	}
	
	System.out.println(Count);
}
}	
	