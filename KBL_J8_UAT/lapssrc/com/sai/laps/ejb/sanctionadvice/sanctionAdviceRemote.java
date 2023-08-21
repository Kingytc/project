package com.sai.laps.ejb.sanctionadvice;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface sanctionAdviceRemote 
{
	
	public HashMap getsanctionAdvice(HashMap hshValues);
	public HashMap updatesanctionAdvice(HashMap hshValues);
	
	//added by Mercy for tertiary
	public HashMap getTertiarySanctionletter(HashMap hshValues);
	public HashMap getStaffLoanSanctionAdvice(HashMap hshValues);
	
	public HashMap getCorporateSanctionAdvice(HashMap hshValues);
	public HashMap getTertiarySanctionAdvice(HashMap hshValues);
	public HashMap getAdhocLimitSanctionAdvice(HashMap hshValues);
	public HashMap getShortTermLoanLimitSanctionAdvice(HashMap hshValues);
	
	public HashMap getCorpSanLetterAnnexureone(HashMap hshValues);
	public HashMap getCorpSanLetterAnnexuretwo(HashMap hshValues);
	//Added by Arsath for Sanction Letter
	public  HashMap getCorpSanctiondata(HashMap hshValues);
}