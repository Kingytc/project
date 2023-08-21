package com.sai.laps.ejb.AgriDigitalAppInterface;

import java.util.HashMap;
import javax.ejb.Remote;
import com.sai.laps.ejb.AgriDigitalAppInterface.AgriDigitalAppInterfaceRemote;


@Remote
public interface AgriDigitalAppInterfaceRemote {
	
	public HashMap UpdateAgriLarService(HashMap hshValues);
	public HashMap AgriProposalCreation(HashMap hshValues);
	


	
}
