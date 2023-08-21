package com.sai.laps.ejb.Inspection;


import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface TechnicalInspectionRemote 
{
//	public void updateTechnicalInspection1(HashMap hshValues);
//	public void updateTechnicalInspection2(HashMap hshValues);
//	public void updateTechnicalInspection3(HashMap hshValues);
//	public HashMap getTechnicalInspection(HashMap hshValues);
	
	public void updateTechnicalpage1(HashMap hshValues);
	public HashMap getTechnicalpage1(HashMap hshValues);
	
	public void updateTechnicalpage2(HashMap hshValues);
	public HashMap getTechnicalpage2(HashMap hshValues);
	
	public void updateTechnicalpage3(HashMap hshValues);
	public HashMap getTechnicalpage3(HashMap hshValues);
	
	public void updateTechnicalpage4(HashMap hshValues);
	public HashMap getTechnicalpage4(HashMap hshValues);
	
	public void updateTechnicalpage5(HashMap hshValues);
	public HashMap getTechnicalpage5(HashMap hshValues);
	
	public HashMap printgetTechnicalpage(HashMap hshValues);
	
	public HashMap getPDCCharges(HashMap hshValues);
	
}