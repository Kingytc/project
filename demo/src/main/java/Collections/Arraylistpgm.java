package Collections;

import java.util.ArrayList;
import java.util.Iterator;

public class Arraylistpgm {
	
	public static void main(String[] argStrings)
	{
		ArrayList<String> list=new ArrayList<String>();
		list.add("Ravi");
		list.add("rama");
		list.add("shiva");
		
		Iterator itr=list.iterator();
		while (itr.hasNext()) {
			System.out.println(itr.next());
		}
		
	}
}


class listforarray{
	public static void main(String[] args) {
		
		ArrayList<String> list = new ArrayList<String>();
		
		list.add("rama");
		list.add("raju");
		list.add("Technical");
		
		System.out.println(list);
	}
	
}