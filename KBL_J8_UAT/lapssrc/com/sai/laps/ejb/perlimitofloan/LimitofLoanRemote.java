package com.sai.laps.ejb.perlimitofloan;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface LimitofLoanRemote 
{
	public HashMap getData(HashMap hshRequestValues);
	public HashMap getEligibleAmount(HashMap hshRequestValues);
	public HashMap getDocFee(HashMap hshRequestValues);
	public HashMap getPermissionPropSearch(HashMap hshRequestValues);
	public HashMap updateDeviationData(HashMap hshValues);
	public HashMap updateDigiDeviationData(HashMap hshValues);
	public HashMap getSolvencyDocFee(HashMap hshRequestValues); 
	public HashMap getDeviationData(HashMap hshValues);
	public void updateDeviationDataforcorpandagri(HashMap hshValues);

}