package com.sai.laps.ejb.proposalterms;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface ProposalTermsRemote {
		
	public HashMap getConduct(HashMap hshValues);
	public HashMap getRBIGuidelines(HashMap hshValues);
	public HashMap getInspection(HashMap hshValues);
	public HashMap getCersaiCibil(HashMap hshValues);
	public HashMap getNpaScheme(HashMap hshValues);
	
	public void updateConduct(HashMap hshValues);
	public void updateRBIGuidelines(HashMap hshValues);
	public void updateInspection(HashMap hshValues);
	public void updateCersaiCibil(HashMap hshValues);
	public void updateNpaScheme(HashMap hshValues);
}
