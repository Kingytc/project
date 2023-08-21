package com.sai.laps.webservices.rest.services;

import java.util.List;

public class ArrBsadsaMaster {

	private List<BsadsaMaster> bsadsaMaster;

	public  ArrBsadsaMaster() {
		super();
		// TODO Auto-generated constructor stub
	
	}
	
	public  ArrBsadsaMaster(List<BsadsaMaster> BsadsaMaster) {
		super();
		// TODO Auto-generated constructor stub
		this.bsadsaMaster=BsadsaMaster;
	
	}

	public void setBsadsaMaster(List<BsadsaMaster> bsadsaMaster) {
		this.bsadsaMaster = bsadsaMaster;
	}

	public List<BsadsaMaster> getBsadsaMaster() {
		return bsadsaMaster;
	}
}
