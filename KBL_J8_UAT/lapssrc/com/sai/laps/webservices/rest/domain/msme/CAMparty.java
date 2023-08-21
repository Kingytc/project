package com.sai.laps.webservices.rest.domain.msme;

public class CAMparty {

	
	 private String party1;
	 private String party2;
	 private String party3;
	 private String party4;
	 private String party5;

public CAMparty()
{
	super();
}
public CAMparty(String party1, String party2, String party3, String party4,String party5)
{
this.party1=party1;
this.party2=party2;
this.party3=party3;
this.party4=party4;
this.party5=party5;
}
public String getParty1() {
	return party1;
}
public void setParty1(String party1) {
	this.party1 = party1;
}
public String getParty2() {
	return party2;
}
public void setParty2(String party2) {
	this.party2 = party2;
}
public String getParty3() {
	return party3;
}
public void setParty3(String party3) {
	this.party3 = party3;
}
public String getParty4() {
	return party4;
}
public void setParty4(String party4) {
	this.party4 = party4;
}
public String getParty5() {
	return party5;
}
public void setParty5(String party5) {
	this.party5 = party5;
}


}