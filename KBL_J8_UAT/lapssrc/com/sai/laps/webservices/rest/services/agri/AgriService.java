package com.sai.laps.webservices.rest.services.agri;

import javax.ejb.Remote;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.sai.laps.webservices.rest.domain.agri.AgriLarService;
import com.sai.laps.webservices.rest.domain.agri.AgriFacilityProposal;



@Remote
public interface AgriService {
	
	public String AgriLarService(AgriLarService AgriLarService) throws JsonProcessingException;
	public String AgriFacilityProposal(AgriFacilityProposal AgriFacilityProposal) throws JsonProcessingException;
	

}
