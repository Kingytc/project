package com.sai.laps.ejb.postinspection;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface PostInspectionRemote 
{
	public HashMap getPostInspecSearch(HashMap hshValues);
	public HashMap getTypePostInspection(HashMap hshValues);
	public void updateTypePostInspection(HashMap hshValues);
	public HashMap getPostInspectionFaclity(HashMap hshValues);
	public HashMap getPostInspectionReport(HashMap hshValues);
	public HashMap updatePostInspectionReport(HashMap hshValues);
	public HashMap getNewPostInspectionReport(HashMap hshValues);
	public HashMap getPostInspectionPrint(HashMap hshValues);
	public HashMap getPostInspectionAnnexure(HashMap hshValues);
	public void updatePostInspectionAnnexure(HashMap hshValues);
	
	public HashMap getPostInspectionHistory(HashMap hshValues);
	public HashMap getPostInspectionAction(HashMap hshValues);
	public void updatePostInspectionAction(HashMap hshValues);
	
}