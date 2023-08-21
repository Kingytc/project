package Collections;

import java.util.Iterator;
import java.util.Vector;

public class Itr {
	
	public static void main(String args[]){ 
		
		//Create object
		Vector<String> v=new Vector<String>();  
		v.add("Ayush");  
		v.add("Amit");  
		v.add("Ashish");  
		v.add("Garima");  
		
		// Iterator 
		Iterator<String> itr=v.iterator();  
		while(itr.hasNext()){  
		System.out.println(itr.next());  
		}  
		}  
		}  


