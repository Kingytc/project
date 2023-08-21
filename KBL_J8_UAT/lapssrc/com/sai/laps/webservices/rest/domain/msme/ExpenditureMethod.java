package com.sai.laps.webservices.rest.domain.msme;

public class ExpenditureMethod {

	 	private String year;
		private String type;
		private String projectExpenditure;
		private String acceptprojectExpenditure;
		private String operationalCycle;
		private String eligibleCycle;
		private String permissibleFinance;
		private String limitSought;
		private String limitProposed;
	
public	ExpenditureMethod()
{super();
}

public	ExpenditureMethod( String year,
 		 String type,
 		 String projectExpenditure,
 		 String acceptprojectExpenditure,
 		 String operationalCycle,
 		 String eligibleCycle,
 		 String permissibleFinance,
 		 String limitSought,
 		 String limitProposed)
{
	
	  	 this.year=year;
		 this.type=type;
		 this.projectExpenditure=projectExpenditure;
		 this.acceptprojectExpenditure=acceptprojectExpenditure;
		 this.operationalCycle=operationalCycle;
		 this.eligibleCycle=eligibleCycle;
		 this.permissibleFinance=permissibleFinance;
		 this.limitSought=limitSought;
		 this.limitProposed=limitProposed;
}


public String getYear() {
	return year;
}


public void setYear(String year) {
	this.year = year;
}


public String getType() {
	return type;
}


public void setType(String type) {
	this.type = type;
}


public String getProjectExpenditure() {
	return projectExpenditure;
}


public void setProjectExpenditure(String projectExpenditure) {
	this.projectExpenditure = projectExpenditure;
}


public String getAcceptprojectExpenditure() {
	return acceptprojectExpenditure;
}


public void setAcceptprojectExpenditure(String acceptprojectExpenditure) {
	this.acceptprojectExpenditure = acceptprojectExpenditure;
}


public String getOperationalCycle() {
	return operationalCycle;
}


public void setOperationalCycle(String operationalCycle) {
	this.operationalCycle = operationalCycle;
}


public String getEligibleCycle() {
	return eligibleCycle;
}


public void setEligibleCycle(String eligibleCycle) {
	this.eligibleCycle = eligibleCycle;
}


public String getPermissibleFinance() {
	return permissibleFinance;
}


public void setPermissibleFinance(String permissibleFinance) {
	this.permissibleFinance = permissibleFinance;
}


public String getLimitSought() {
	return limitSought;
}


public void setLimitSought(String limitSought) {
	this.limitSought = limitSought;
}


public String getLimitProposed() {
	return limitProposed;
}


public void setLimitProposed(String limitProposed) {
	this.limitProposed = limitProposed;
}



}
