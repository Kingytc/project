package Collections;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class Hashmappgm {

	public static void main(String[] args)
	{
		
		HashMap<Integer, String> map=new HashMap<Integer, String>();
		
		map.put(1, "Mango");
		map.put(2, "radha");
		map.put(3, "shiva");
		
		System.out.println("Hash map..........");
		
		for(Map.Entry m: map.entrySet())
		{
			 System.out.println(m.getKey()+" "+m.getValue()); 
			
		}
	}

}

/*
 * 
 * Hashmap<Integer,String> map=new Hashmap<Integer,String>();
 * 
 * map.put(1, "shiva");
 * map.put(2, "ranjan");
 * map.put(3, "dasa");
 * 
 * System.out.println("Hash map..............");
 * 
 * for(Map.Entry m:map.entrySet())
 * {
 *   System.out.println(m.getKey()+"   "+m.getValue());
 *   }
 *   
 *   }
 * }
 * 
 * 
 * 
 * 
 * 
 * 
 * 
 * 
 * 
 * 
 */