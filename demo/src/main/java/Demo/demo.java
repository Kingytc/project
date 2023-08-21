package Demo;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import org.hibernate.sql.ast.tree.expression.Collation;
import org.springframework.boot.jackson.JsonObjectSerializer;
import org.springframework.data.convert.Jsr310Converters.ZoneIdToStringConverter;

import com.fasterxml.jackson.core.io.JsonEOFException;
import com.fasterxml.jackson.databind.util.JSONPObject;

import Project.Demoobject;
import practices.interfacedemo;

public class demo {
	public static void main(String[] args) {
		
		ArrayList<String> s1 = new ArrayList<String>(); 
			s1.add("shiva");
			s1.add("rama");
			s1.add("raju");
			
			System.out.println(s1);
		
		}
}


//---------------------------------Iterator-------------------------------------//

class demo1 {
	public static void main(String[] args) {
		
		ArrayList<String> list = new  ArrayList<String>();
		
		list.add("raju");
		list.add("rama");
		list.add("shiva");
		
		Iterator<String> itr = list.iterator();
		while(itr.hasNext()) {
			System.out.println(itr.next());
		}
	}
}

class demo2 {
	public static void main(String[] args) {
		
		ArrayList<String> list1 = new ArrayList<String>();
		list1.add("shiva");
		list1.add("shiva");
		list1.add("Ranjan");
		
		
		Iterator<String> itr1 = list1.iterator();
		while (itr1.hasNext()) {
			System.out.println(itr1.next());
			
		}
		
				
	}
}


class externalaccess {
	public static void main(String[] args) {
		
Collection<Integer> num = new ArrayList<Integer>();

	num.add(2);
	num.add(5);
	num.add(9);
	
	for(int n: num)
	{
		System.out.println(n);
	}
  }	
}


class extera {
	public static void main(String[] args) {
		
		 Collection<String> str1 = new ArrayList<String>();
		 
		 str1.add("Shiva");
		 str1.add("rama");
		 str1.add("raju");
		 
		 //pending for the index values.
		 System.out.println();
	}
}