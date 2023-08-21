package com.sai.laps.helper;

import java.util.HashMap;

public class AuditParams
{
	private static HashMap htAudit = null;

	public void setAuditParams(String str1,String str2,String str3,String str4,String str5)
	{	
		htAudit = new HashMap();
		htAudit.put("strAuditUser",str1);
		htAudit.put("strAuditLocation",str2);
		htAudit.put("strAuditIP",str3);
		htAudit.put("strAuditHost",str4);
		htAudit.put("strAuditPage",str5);
		
	}
	
	public HashMap getAuditParams()
	{
		return htAudit;
	}
	
}
