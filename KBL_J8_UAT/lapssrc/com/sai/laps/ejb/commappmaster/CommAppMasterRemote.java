package com.sai.laps.ejb.commappmaster;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface CommAppMasterRemote 
{
	public HashMap getApplicantList(HashMap hshValues);
	public HashMap getBorrowers(HashMap hshValues);
	public HashMap getBorrowerType(HashMap hshValues);
	public HashMap getData(HashMap hshValues);
	public HashMap updateData(HashMap hshValues);
	public HashMap getFactoryDetails(HashMap hshValues);
	public void updateFactoryDetails(HashMap hshValues);
	public HashMap getrocdetails(HashMap hshValues);
	public void updaterocdetails(HashMap hshValues);
	public HashMap getRAMParameters(HashMap hshValues);
	
	public void updatereldetails(HashMap hshValues);
	public HashMap getreldetails(HashMap hshValues);
	public void updateDivisionDetails(HashMap hshValues);
	public HashMap getDivisionDetails(HashMap hshValues);
	public HashMap getcompanyData(HashMap hshValues);
	public HashMap getagrApplicantList(HashMap hshValues);
	
	public HashMap getBSRCode(HashMap hshValues);
	public HashMap renewComappMasterData(HashMap hshValues);
	public HashMap getSetupBSRCode(HashMap hshValues);
	public HashMap getMasterSearch(HashMap hshValues);
	
	public void updateComfinancialparticularsdata(HashMap hshValues);
	public HashMap getComfinancialparticularsdata(HashMap hshValues);

	public void updateSHGmembersDetail(HashMap hshValues);
	public HashMap getSHGmembersDetail(HashMap hshValues);

	public void updateSHGAddtnDetail(HashMap hshValues);
	public HashMap getSHGAddtnDetail(HashMap hshValues);
	public HashMap getGrpConcernType(HashMap hshValues);
}
