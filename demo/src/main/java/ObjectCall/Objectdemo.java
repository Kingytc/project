package ObjectCall;

import org.aspectj.weaver.NewConstructorTypeMunger;
import org.hibernate.Hibernate;
import org.springframework.boot.autoconfigure.h2.H2ConsoleAutoConfiguration;
import org.springframework.core.StandardReflectionParameterNameDiscoverer;
import org.springframework.web.client.HttpClientErrorException.Gone;

import com.fasterxml.jackson.core.sym.Name;

import lombok.experimental.Helper;
import practices.interfacedemo;

public class Objectdemo {
	
	int id = 10;
	String name	= "shivaranjan";
	
	public static void main(String[] args) {
		
		Objectdemo s1 = new Objectdemo();
		
			System.out.println(s1.id);
			System.out.println(s1.name);
	}

}

//--------------------------------------Out side the class ----------------------------------//

  class access{
	int id = 20;
	private String name = "dasa";
	private String emailString ="shiva@gmail.com";
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmailString() {
		return emailString;
	}

	public void setEmailString(String emailString) {
		this.emailString = emailString;
	}
}
 
 
  class getaccess{
	  
	private String names = "baba";
	 private String emailString = "ranjan@gmail.com";
	 int id = 30;
	 
	public static void main(String[] args) {
		
		 String id = "";
		 access s1 = new access();
		 getaccess s2 = new getaccess();
		 
		try {
			if(id.equals("")) {
				
				System.out.println(s2.id);
				System.out.println(s2.names);
				System.out.println(s2.emailString);
			} else {
				 System.out.println(s1.id );
				 System.out.println(s1.getName());
				 System.out.println(s1.getEmailString());
			}
		} catch (Exception e) {
			// Exception occured 
			e.printStackTrace();
		} 
	}

	
 }