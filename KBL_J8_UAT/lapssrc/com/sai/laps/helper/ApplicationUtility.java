package com.sai.laps.helper;

import java.sql.ResultSet;
import java.util.HashMap;

import javax.ejb.EJBException;

public class ApplicationUtility {
	
	/*
	 * @Purpose	:	For Getting Application Status Description from app_status code
	 */
	public static String getApplicationStatus(String strAppStatusCode) {
		String strAppStatusDesc="";
		if (strAppStatusCode.equalsIgnoreCase("CA")) 
		{
			strAppStatusDesc = "Closed/Approved";
		}
		else if (strAppStatusCode.equalsIgnoreCase("OP")) 
		{
			strAppStatusDesc = "Open/Pending";
		}
		else if (strAppStatusCode.equalsIgnoreCase("PA")) 
		{
			strAppStatusDesc = "Processed/Approved";
		}
		else if (strAppStatusCode.equalsIgnoreCase("PR")) 
		{
			strAppStatusDesc = "Processed/Rejected";
		}
		else if (strAppStatusCode.equalsIgnoreCase("CR")) 
		{
			strAppStatusDesc = "Closed/Rejected";
		}
		else
		{
			strAppStatusDesc="";
		}
		return strAppStatusDesc;
	}
}
