package com.sai.laps.webservices.rest.domain;

public class FinalInPrinciple {

	private String schemeCode;
	private String module;
	private String digiAppno;
	private String processToDate;
	private String processfromDate;
	
	
	public FinalInPrinciple(){
		super();
	}
	
	public FinalInPrinciple(String schemeCode,String module,String digiAppno,String processToDate,String processfromDate){
		super();
		this.setProcessDate(processfromDate);
		this.setSchemeCode(schemeCode);
		this.setModule(module);
		this.setDigiAppno(digiAppno);
		this.setProcessToDate(processToDate);
		}

	public void setProcessDate(String processDate) {
		this.processfromDate = processDate;
	}

	public String getProcessDate() {
		return processfromDate;
	}

	public void setSchemeCode(String schemeCode) {
		this.schemeCode = schemeCode;
	}

	public String getSchemeCode() {
		return schemeCode;
	}

	public void setModule(String module) {
		this.module = module;
	}

	public String getModule() {
		return module;
	}

	public void setDigiAppno(String digiAppno) {
		this.digiAppno = digiAppno;
	}

	public String getDigiAppno() {
		return digiAppno;
	}

	public void setProcessToDate(String processToDate) {
		this.processToDate = processToDate;
	}

	public String getProcessToDate() {
		return processToDate;
	}

	public void setProcessfromDate(String processfromDate) {
		this.processfromDate = processfromDate;
	}

	public String getProcessfromDate() {
		return processfromDate;
	}
}
