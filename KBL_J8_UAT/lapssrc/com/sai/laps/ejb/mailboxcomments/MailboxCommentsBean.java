package com.sai.laps.ejb.mailboxcomments;


import java.sql.ResultSet;

import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "MailboxCommentsBean", mappedName = "MailboxCommentsHome")
@Remote (MailboxCommentsRemote.class)
public class MailboxCommentsBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public HashMap getData(HashMap hshValues) 
	{	
		ResultSet rs = null;
		HashMap hshRecord = null;
		HashMap hshRow=null;
		String strAppNo = "";
		int no=0;

		try
		{

			strAppNo = correctNull((String)hshValues.get("hidappno"));
			
			if(strAppNo.equalsIgnoreCase("null")||strAppNo.equalsIgnoreCase(""))
			{
				strAppNo = correctNull((String)hshValues.get("cbsappno"));
			}
			if(strAppNo.equalsIgnoreCase(""))
			{
				strAppNo = correctNull((String)hshValues.get("cbsaccno"));
			}
			
			hshRecord = new HashMap();
			
			rs=DBUtils.executeLAPSQuery("selmaiboxcomments^"+strAppNo);
			while(rs.next())
			{		
					no++;
					hshRow=new HashMap();
					hshRow.put("mail_appno",correctNull(rs.getString("mail_appno")));
					hshRow.put("mail_comments",correctNull(Helper.CLOBToString(rs.getClob("mail_comments"))));
					hshRow.put("mail_userid",correctNull(rs.getString("mail_userid")));
					hshRow.put("mail_date",correctNull(rs.getString("mail_date")));
					hshRow.put("mail_touser",correctNull(rs.getString("mail_touser")));
					hshRow.put("mail_usrname",correctNull(rs.getString("usr_fname")));
					hshRow.put("mail_usrdesign",correctNull(rs.getString("user_designation")));
					hshRow.put("mail_pano",correctNull(rs.getString("mail_pano")));

					hshRecord.put(Integer.toString(no),hshRow);
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
		}
		finally
		{
			try
			{
	
				if(rs != null)
				{
					rs.close();
				}
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
	return hshRecord;
	}
public void updateData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAppno="";
		String strMailComments="";
		String strUserId="";
		String strtoUser="";
		String strtoUserid="";
		
		try
		{	
				strAppno = correctNull((String )hshValues.get("hidappno"));
				strMailComments = correctNull((String )hshValues.get("comments"));
				strUserId = correctNull((String )hshValues.get("hiduserid"));
				strtoUser = correctNull((String )hshValues.get("hidtoUser"));
				strtoUserid=correctNull((String )hshValues.get("hidtousrid"));
				
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insertmaiboxcomments");
				arrValues.add(strAppno);
				arrValues.add(strMailComments);
				arrValues.add(strUserId);
				arrValues.add(strtoUser);
				arrValues.add(strtoUserid);
				arrValues.add(correctNull((String )hshValues.get("txt_pano")));
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
	}
public HashMap getReviewTermLoanData(HashMap hshValues) 
{	
	ResultSet rs = null;
	HashMap hshRecord = null;
	HashMap hshRow=null;

	String strAccNo = "";

	int no=1;

	try
	{

		strAccNo = correctNull((String)hshValues.get("hidtlrno"));

		hshRecord = new HashMap();
		
		rs=DBUtils.executeLAPSQuery("tlr_mailboxcomments_select^"+strAccNo);
		while(rs.next())
		{		hshRow=new HashMap();
				hshRow.put("mail_appno",correctNull(rs.getString(1)));
				hshRow.put("mail_comments",correctNull(Helper.CLOBToString(rs.getClob("mail_comments"))));
				hshRow.put("mail_userid",correctNull(rs.getString(3)));
				hshRow.put("mail_date",correctNull(rs.getString(4)));
				hshRow.put("mail_touser",correctNull(rs.getString(5)));
				hshRow.put("mail_usrname",correctNull(rs.getString(7)));
				hshRow.put("mail_usrdesign",correctNull(rs.getString(6)));
				hshRow.put("mail_pano",correctNull(rs.getString(8)));

				hshRecord.put(Integer.toString(no),hshRow);
				no++;				
		}
	}
	catch(Exception ce)
	{
		throw new EJBException("Error in getData login  "+ce.toString());
	}
	finally
	{
		try
		{

			if(rs != null)
			{
				rs.close();
			}
			
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
					
		}
	}
return hshRecord;
}
public void updateMMRComments(HashMap hshValues) 
{
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = null;
	ArrayList arrValues=new ArrayList();
	String strMailComments="";
	String strUserId="";
	String strtoUser="";
	
	try
	{	
		//String cbsid=correctNull((String)hshValues.get("cbsid"));
		//String mon_month=correctNull((String)hshValues.get("mon_month"));
		//String mon_year=correctNull((String)hshValues.get("strYear"));
		String strmmrno=correctNull((String)hshValues.get("mmrno"));
		strMailComments = correctNull((String )hshValues.get("comments"));
		strUserId = correctNull((String )hshValues.get("hiduserid"));
		strtoUser = correctNull((String )hshValues.get("hidtoUser"));
		
		hshQueryValues = new HashMap();
		hshQuery = new HashMap();					
		hshQueryValues.put("size","1");
		
		arrValues=new ArrayList();
		hshQuery.put("strQueryId","ins_mon_mail_comments");
//		arrValues.add(cbsid);
//		arrValues.add(mon_month);
//		arrValues.add(mon_year);
		arrValues.add(strMailComments);
		arrValues.add(strUserId);
		arrValues.add(strtoUser);
		arrValues.add(strmmrno);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);	
		
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		
	}
	catch(Exception ce)
	{
		throw new EJBException("inside update"+ce.toString());
	}
}


public HashMap getMMRComments(HashMap hshValues) 
{	
	ResultSet rs = null;
	HashMap hshRecord = null;
	HashMap hshRow=null;
	int no=1;

	try
	{
		String strmmrno=correctNull((String)hshValues.get("mmrno"));
		
		hshRecord = new HashMap();
		
		rs=DBUtils.executeLAPSQuery("sel_mon_mail_comments^"+strmmrno);
		while(rs.next())
		{		
				hshRow=new HashMap();
				
				hshRow.put("mail_comments",correctNull(rs.getString("mail_comments")));
				hshRow.put("mail_userid",correctNull(rs.getString("mail_userid")));
				hshRow.put("mail_date",correctNull(rs.getString("mail_date")));
				hshRow.put("mail_touser",correctNull(rs.getString("mail_touser")));
				hshRow.put("mail_usrname",correctNull(rs.getString("usr_fname")));
				hshRow.put("mail_usrdesign",correctNull(rs.getString("user_designation")));
				hshRow.put("mail_pano",correctNull(rs.getString("mail_pano")));

				hshRecord.put(Integer.toString(no),hshRow);
				no++;				
		}
	}
	catch(Exception ce)
	{
		throw new EJBException("Error in getData login  "+ce.toString());
	}
	finally
	{
		try
		{

			if(rs != null)
			{
				rs.close();
			}
			
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
					
		}
	}
return hshRecord;
}



public void updateReviewTermLoanData(HashMap hshValues) 
{
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = null;
	ArrayList arrValues=new ArrayList();
	String strAccNo="";
	String strMailComments="";
	String strUserId="";
	String strtoUser="";
	String strtoUserid="";
	try
	{	
			strAccNo = correctNull((String )hshValues.get("hidtlrno"));
			strMailComments = correctNull((String )hshValues.get("comments"));
			strUserId = correctNull((String )hshValues.get("hiduserid"));
			strtoUser = correctNull((String )hshValues.get("hidtoUser"));
			strtoUserid=correctNull((String )hshValues.get("hidtoUserid"));
			
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();					
			hshQueryValues.put("size","1");
			
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","tlr_mailboxcomments_insert");
			arrValues.add(strAccNo);
			arrValues.add(strMailComments);
			arrValues.add(strUserId);
			arrValues.add(strtoUser);
			arrValues.add(strtoUserid);
			arrValues.add(correctNull((String )hshValues.get("txt_pano")));
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);	
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		
	}
	catch(Exception ce)
	{
		throw new EJBException("inside update"+ce.toString());
	}
}

public HashMap getRemarksData(HashMap hshValues) 
{	
	ResultSet rs = null;
	String strAppNo = "";
	HashMap hshRecord = null;
	ArrayList arrRow = null;
	ArrayList arrCol = null;
	String strOrgName = null;
	String strQuery = "";
	String formtype = "";
	
	try
	{
		hshRecord =new HashMap();
		arrRow = new ArrayList();
		
		strAppNo = correctNull((String)hshValues.get("appno"));
		strOrgName = correctNull((String)hshValues.get("strOrgName"));
	
		strQuery = SQLParser.getSqlQuery("comfunsel1^"+strAppNo);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next()) 
		{
			formtype = Helper.correctDoubleQuote(correctNull(rs.getString("app_loantype")));
		}
		if (formtype.equalsIgnoreCase("P")) {
			strQuery = SQLParser.getSqlQuery("comfunsel2^" + strAppNo);
		} else if ((formtype.equalsIgnoreCase("C")) || formtype.equalsIgnoreCase("A") || (formtype.equalsIgnoreCase("E")) || (formtype.equalsIgnoreCase("U")) || (formtype.equalsIgnoreCase("H"))) {
			strQuery = SQLParser.getSqlQuery("comfunsel3^" + strAppNo);
		}else if (formtype.equalsIgnoreCase("T")) {
			strQuery = SQLParser.getSqlQuery("comfunsel4^" + strAppNo + "^N");
		}
		
		if(rs!=null)
			rs.close();
		rs = DBUtils.executeQuery(strQuery);
		while (rs.next()) {
			hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
			hshRecord.put("apporgcode", rs.getString("app_orgcode"));
			hshRecord.put("inwardno", rs.getString("app_inwardno"));
			hshRecord.put("applevel", rs.getString("app_orglevel"));
			hshRecord.put("applnholder",correctNull(rs.getString("app_applnholder")));
			hshRecord.put("apporgname",correctNull(rs.getString("org_name")));
			hshRecord.put("apploantype",formtype);
		}
		
		strQuery = SQLParser.getSqlQuery("mailbox_comments_select^"+strAppNo);
		if(rs!=null)
			rs.close();
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{	
			arrCol = new ArrayList();
			arrCol.add(correctNull(Helper.CLOBToString(rs.getClob("mail_comments"))));
			arrCol.add(correctNull(rs.getString("mail_userid")));
			arrCol.add(correctNull(rs.getString("mail_date")));
			arrCol.add(correctNull(rs.getString("mail_touser")));
			arrCol.add(correctNull(rs.getString("user_designation")));
			arrCol.add(correctNull(rs.getString("usr_fname")));
			arrRow.add(arrCol);
		}
		
		
		hshRecord.put("arrMailBoxComments",arrRow);
		hshRecord.put("appno",strAppNo);
		hshRecord.put("orgName",strOrgName);
		
	
		
	}
	catch(Exception ce)
	{
		throw new EJBException("Error in getRemarksData login  "+ce.toString());
	}
	finally
	{
		try
		{
			if(rs != null)
			{
				rs.close();
			}

		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
					
		}
	}
return hshRecord;
}
}
