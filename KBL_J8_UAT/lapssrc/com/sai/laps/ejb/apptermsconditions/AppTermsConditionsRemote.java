package com.sai.laps.ejb.apptermsconditions;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface AppTermsConditionsRemote
{
	public void updateTerms(HashMap hshValues);
	public HashMap getTerms(HashMap hshValues);
	public HashMap getTermData(HashMap hshRequestValues);
	public HashMap getDeletedTerms(HashMap hshRequestValues);
	public HashMap getComFacilities(HashMap hshRequestValues);
	public HashMap getComFacilityTermData(HashMap hshRequestValues);
	public void updateComFacilityTermData(HashMap hshRequestValues);
	public void UndeleteTermsData(HashMap hshValues);
}
