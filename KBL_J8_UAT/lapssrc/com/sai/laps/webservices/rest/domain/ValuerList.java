package com.sai.laps.webservices.rest.domain;

public class ValuerList {

	
	private String valuedLoc;
	
	
 public ValuerList(){
	 super();
 }
 
 public ValuerList(String valuedLoc){
	 
	 this.valuedLoc=valuedLoc;
	 
 }

public String getValuedLoc() {
	return valuedLoc;
}

public void setValuedLoc(String valuedLoc) {
	this.valuedLoc = valuedLoc;
}
 
 
}
