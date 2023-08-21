package com.sai.laps.webservices.rest.domain.msme;

import java.util.List;

public class FinancialLiabilitis {

	private String startingPeriod;
	private String endingPeriod;
	private String type;
	private String tab;
	private List<DescriptionValues> values;
		

		public FinancialLiabilitis(){
			super();
		}
		
	public FinancialLiabilitis(String startingPeriod,String endingPeriod,String type,List<DescriptionValues> values,String tab){
		
		this.startingPeriod=startingPeriod;
		this.endingPeriod=endingPeriod;
		this.type=type;
		this.values=values;
		this.tab=tab;
		
	}

	public String getStartingPeriod() {
		return startingPeriod;
	}

	public void setStartingPeriod(String startingPeriod) {
		this.startingPeriod = startingPeriod;
	}

	public String getEndingPeriod() {
		return endingPeriod;
	}

	public void setEndingPeriod(String endingPeriod) {
		this.endingPeriod = endingPeriod;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public List<DescriptionValues> getValues() {
		return values;
	}

	public void setValues(List<DescriptionValues> values) {
		this.values = values;
	}

	public String getTab() {
		return tab;
	}

	public void setTab(String tab) {
		this.tab = tab;
	}

	
	
	

}

	


