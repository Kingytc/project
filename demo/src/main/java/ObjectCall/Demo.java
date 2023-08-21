package ObjectCall;

import org.springframework.web.client.HttpClientErrorException.Forbidden;

import practices.interfacedemo;

public class Demo {
}
	
	class largest{
		public static void main(String[] args) {
			
		
		int temp;
		int arr[]= {10,72,32,68,3,99};
		int i;
		
		System.out.println("Before Swaping Numbers");
//		System.out.println(arr[i]);
		for( i=0; i<arr.length; i++) {
			
		for (int j = i+1; j < arr.length; j++) {
			
			
			if (arr[i]>arr[j]) {
				
				temp = arr[i];
				arr[i]=arr[j];
				arr[j]=temp;
				
				
			}
			
			
		}
		
		System.out.println(arr[i]);	
	}	
		
	}
}

