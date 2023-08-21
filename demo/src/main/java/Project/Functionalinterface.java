package Project;

import com.fasterxml.jackson.databind.ser.std.StdKeySerializers.Default;

import practices.interfacedemo;

interface colors{
	 default void color() {
		System.out.println("Red");
	}
}

@FunctionalInterface
interface price extends colors {
	 void cost(int n);
}

class Functionalinterface implements price
{
	
		public void cost(int n) {
			System.out.println(n);
		}
		
		
	public static void main(String[] args) {
		
		Functionalinterface f1 = new Functionalinterface();
		
		f1.cost(100);
		f1.color();
		
	}

	

}
