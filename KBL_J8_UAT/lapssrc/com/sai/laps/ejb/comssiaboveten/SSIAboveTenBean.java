package com.sai.laps.ejb.comssiaboveten;

import java.io.ByteArrayOutputStream;
import java.sql.Blob;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.ApplicantParams;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.SetupParams;

@Stateless(name = "SSIAboveTenBean", mappedName = "SSIAboveTenHome")
@Remote (SSIAboveTenRemote.class)
public class SSIAboveTenBean extends BeanAdapter
{	
	//static Logger log=Logger.getLogger(SSIAboveTenBean.class);
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	


	static Logger log=Logger.getLogger(SSIAboveTenBean.class);	


	public HashMap getData(HashMap hshRequestValues) 
	{		

		HashMap hshRecord = new HashMap();		
		String strMethodName="";
		try
		{				
			strMethodName = correctNull((String)hshRequestValues.get("hidMethod"));		
			
			if(strMethodName.equals("getProjectDetails"))
			{				
				hshRecord = (HashMap)getProjectDetails(hshRequestValues);
			}
			else if(strMethodName.equals("getGeneralDetails"))
			{				
				hshRecord = (HashMap)getGeneralDetails(hshRequestValues);
			}
			else if(strMethodName.equals("getCostofProject"))
			{
				hshRecord = (HashMap)getCostofProject(hshRequestValues);			
			}
			else if(strMethodName.equals("getExportProducts"))
			{				
				hshRecord = (HashMap)getExportProducts(hshRequestValues);
			}
			else if(strMethodName.equals("getStaffDetails"))
			{				
				hshRecord = (HashMap)getStaffDetails(hshRequestValues);
			}
			else if(strMethodName.equals("getAnnexure2Structure"))
			{				
				hshRecord = (HashMap)getAnnexure2Structure(hshRequestValues);
			}
			else if(strMethodName.equals("getAnnexure2ProposedBuilding"))
			{				
				hshRecord = (HashMap)getAnnexure2ProposedBuilding(hshRequestValues);
			}
			else if(strMethodName.equals("getAnnexure2MachineryDetails"))
			{			
				hshRecord = (HashMap)getAnnexure2MachineryDetails(hshRequestValues);
			}
			//else if(strMethodName.equals("getApplicantBakgroundDetails"))
			//{			
				//hshRecord = (HashMap)getApplicantBakgroundDetails(hshRequestValues);
			//}
			//else if(strMethodName.equals("getGuarantorDetails"))
			//{			
				//hshRecord = (HashMap)getGuarantorDetails(hshRequestValues);
			//}			
			//hshRecord.put("comapp_id",correctNull((String)hshRequestValues.get("comapp_id")));
			//hshRecord.put("hidPageType",correctNull((String)hshRequestValues.get("hidPageType")));
			//hshRecord.put("hidCategoryType",correctNull((String)hshRequestValues.get("hidCategoryType")));
			//hshRecord.put("hidSSIType",correctNull((String)hshRequestValues.get("hidSSIType")));
		
			
		
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData1 login  "+ce.toString());
		}		
		return hshRecord;
	}

	public HashMap getProjectDetails(HashMap hshRequestValues)
	{

		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol =null;
		HashMap hshRecord = new HashMap();		
		String strQuery="";
		String strAppno="";
		try
		{
			
			if(correctNull((String)hshRequestValues.get("hidappno"))=="")
			{
				strAppno = correctNull((String) hshRequestValues.get("appno"));
			}
			else
			{
				strAppno = correctNull((String) hshRequestValues.get("hidappno"));
			}
			//strAppno = correctNull((String)hshRequestValues.get("appno"));		
			//strTabName = correctNull((String)hshRequestValues.get("hidTabName"));		
			
			strQuery = SQLParser.getSqlQuery("selssiabv10employment^"+strAppno+"^"+"Employment");			
			rs = DBUtils.executeQuery(strQuery);			
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull((String)rs.getString("ssi_projid")));
				vecCol.add(correctNull((String)rs.getString("SSI_PROJDESC")));
				vecCol.add(correctNull((String)rs.getString("ssi_projexisting")));
				vecCol.add(correctNull((String)rs.getString("ssi_projfuture")));
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow",vecRow);			

		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getProjectDetails   "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}


	private HashMap getGeneralDetails(HashMap hshRequestValues)
	{
		

		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol =null;
		HashMap hshRecord = new HashMap();		
		String strQuery="";
		String strAppno="";
		String strTabName="";
		//String strDesc="";
		String strParam="";
		String strTemp ="";

		//int totaldesc =0;
		int i =0;
		Blob b = null;
		byte[] aBlob = null;	
		
		try
		{			
			
			if(correctNull((String)hshRequestValues.get("hidappno"))=="")
			{
				strAppno = correctNull((String) hshRequestValues.get("appno"));
			}
			else
			{
				strAppno = correctNull((String) hshRequestValues.get("hidappno"));
			}

			//strAppno = correctNull((String)hshRequestValues.get("appno"));			
			strTabName = correctNull((String)hshRequestValues.get("hidTabName"));			
			strParam= correctNull((String)hshRequestValues.get("hidparam"));
			

			StringTokenizer strToken = new StringTokenizer(strParam,"^");
			strTemp="(";

			while (strToken.hasMoreTokens())
			{	
				strTemp = strTemp+" ssi_gendesc like '"+(String)strToken.nextToken()+"' or";
			}
			strTemp =strTemp.substring(0,(strTemp.length())-3);			
			strTemp = strTemp+")";	
			strTemp =strTemp.trim();
			
			ByteArrayOutputStream bios=new ByteArrayOutputStream();
			
			strQuery = SQLParser.getSqlQuery("selssiabv10associate^"+strAppno+"^"+strTabName+"^"+strTemp);			
			rs = DBUtils.executeQuery(strQuery);			
			while (rs.next())
			{ 
				vecCol = new ArrayList();
				for (i=0;i<2;i++ )
				{	
					b=null;
					aBlob = null;	
					bios=new ByteArrayOutputStream();					
					
					vecCol.add(Helper.correctNull(rs.getString("ssi_genid")));		
					b = rs.getBlob("ssi_genvalue");
					aBlob = b.getBytes(0, (int) b.length());			
					bios.write(aBlob);
					bios.flush();						
					vecCol.add(bios.toString());	
					bios.close();
				}
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow",vecRow);	

		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getGeneralDetails   "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}

	private HashMap getCostofProject(HashMap hshRequestValues)
	{
		
		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol =null;
		HashMap hshRecord = new HashMap();		
		String strQuery="";
		String strAppno="";
		String strTabName="";
		
		int i =0;
		boolean bool =false;
		String recordflag = "N";
		try
		{	
			
			if(correctNull((String)hshRequestValues.get("hidappno"))=="")
			{
				strAppno = correctNull((String) hshRequestValues.get("appno"));
			}
			else
			{
				strAppno = correctNull((String) hshRequestValues.get("hidappno"));
			}				
			

			if(correctNull((String)hshRequestValues.get("hid_TabName")) == "")
			{				
				strTabName = correctNull((String)hshRequestValues.get("hidTabName"));			
			}
			else
			{				
				strTabName = correctNull((String)hshRequestValues.get("hid_TabName"));
			}
				
			strQuery = SQLParser.getSqlQuery("selssiabv10costofproject^"+strAppno+"^"+strTabName);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{ 
				 bool =true;
				vecCol = new ArrayList();
				for (i=0;i<5;i++ )
				{
				  vecCol.add(correctNull(rs.getString(i+1)));
				}
				vecRow.add(vecCol);
				recordflag = "Y";
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_anticipatedturnover_TL^"+strAppno+"^"+strTabName);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshRecord.put("PurposeForTL",correctNull(rs.getString(2)));
				hshRecord.put("EstimatePreparedBy",correctNull(rs.getString(3)));
				hshRecord.put("EscalationInEstimates",correctNull(rs.getString(4)));				
			}
			
			if (strTabName.equals("MeansOfFinancing"))
			{
				if(rs!=null)
				{
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("selssimeansoffincomm^"+strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					hshRecord.put("comm1",correctNull(rs.getString(2)));
					hshRecord.put("comm2",correctNull(rs.getString(3)));
					hshRecord.put("comm3",correctNull(rs.getString(4)));
					hshRecord.put("comm4",correctNull(rs.getString(5)));
					hshRecord.put("comm5",correctNull(rs.getString(6)));
				}
				else
				{
					hshRecord.put("comm1","");
					hshRecord.put("comm2","");
					hshRecord.put("comm3","");
					hshRecord.put("comm4","");
					hshRecord.put("comm5","");
				}
				
			}
			else
			{				
					hshRecord.put("comm1","");
					hshRecord.put("comm2","");
					hshRecord.put("comm3","");
					hshRecord.put("comm4","");
					hshRecord.put("comm5","");

			}

			if(bool)
			{
				if(rs!=null)
				{
					rs.close();
				}
				
				strQuery = SQLParser.getSqlQuery("selsumssiabv10costofproject^"+strAppno+"^"+strTabName);				
				rs = DBUtils.executeQuery(strQuery);				
				if (rs.next())
				{ 
					vecCol = new ArrayList();
					vecCol.add(" ");
					vecCol.add(" ");
					for (i=0;i<3;i++ )
					{ vecCol.add(rs.getString(i+1));					  
					}
					vecRow.add(vecCol);
				}
			}
//			else
//			{
//				vecCol = new ArrayList();
//				for (i=0;i<5;i++ )
//				{ 
//					vecCol.add("");
//				}
//				vecRow.add(vecCol);
//			}
//
			hshRecord.put("vecRow",vecRow);	
			hshRecord.put("recordflag",recordflag);

		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getGeneralDetails2   "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	private HashMap getExportProducts(HashMap hshRequestValues)
	{
		
		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol =null;
		HashMap hshRecord = new HashMap();		
		String strQuery="";
		String strAppno="";
		//String strDesc="";
		//String strParam="";
		//String strTemp ="";

		//int totaldesc =0;
		//int i =0;
		//boolean bool =false;
		String recordflag = "N";
		try
		{			
			
			if(correctNull((String)hshRequestValues.get("hidappno"))=="")
			{
				strAppno = correctNull((String) hshRequestValues.get("appno"));
			}
			else
			{
				strAppno = correctNull((String) hshRequestValues.get("hidappno"));
			}			
	
			strQuery = SQLParser.getSqlQuery("selssiabv10export^"+strAppno);			
			rs = DBUtils.executeQuery(strQuery);			
			while (rs.next())
			{ 
				vecCol = new ArrayList();
//				for (i=0;i<5;i++ )
//				{ 
//					vecCol.add(correctNull(rs.getString(i+1)));
//				}				
				vecCol.add(correctNull(rs.getString(1)));
				vecCol.add(correctNull(rs.getString(2)));
				vecCol.add(correctNull(rs.getString(3)));
				vecCol.add(correctNull(rs.getString(4)));				
				vecCol.add(correctNull(rs.getString(5)));
				vecRow.add(vecCol);
				recordflag = "Y";
			}
			hshRecord.put("vecRow",vecRow);
			hshRecord.put("recordflag",recordflag);	

		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getExportProducts   "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}

	private HashMap getStaffDetails(HashMap hshRequestValues)
	{
		
		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol =null;

		HashMap hshRecord = new HashMap();
		
		String strQuery="";
		String strAppno="";
		//String strDesc="";
		//String strParam="";
		//String strTemp ="";

		//int totaldesc =0;
		int i =0;
		////boolean bool =false;
		try
		{			
			
			if(correctNull((String)hshRequestValues.get("hidappno"))=="")
			{
				strAppno = correctNull((String) hshRequestValues.get("appno"));
			}
			else
			{
				strAppno = correctNull((String) hshRequestValues.get("hidappno"));
			}			
							
			strQuery = SQLParser.getSqlQuery("selssiabv10staff^"+strAppno);			
			rs = DBUtils.executeQuery(strQuery);			
			while (rs.next())
			{ 
				vecCol = new ArrayList();
				for (i=0;i<7;i++ )
				{ vecCol.add(correctNull(rs.getString(i+1)));		
				}
				vecRow.add(vecCol);
				//bool =true;
			}
			hshRecord.put("vecRow",vecRow);		

		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getStaffDetails   "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}

	private HashMap getAnnexure2Structure(HashMap hshRequestValues)
	{
		
		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol =null;

		HashMap hshRecord = new HashMap();
		
		String strQuery="";
		String strAppno="";
		//String strDesc="";
		//String strParam="";
		//String strTemp ="";

		//int totaldesc =0;
		int i =0;
		//boolean bool =false;
		try
		{			
			
//			strAppno = correctNull((String)hshRequestValues.get("appno"));
			if(correctNull((String)hshRequestValues.get("hidappno"))=="")
			{
				strAppno = correctNull((String) hshRequestValues.get("appno"));
			}
			else
			{
				strAppno = correctNull((String) hshRequestValues.get("hidappno"));
			}			
							
			strQuery = SQLParser.getSqlQuery("selssiannexure2structure^"+strAppno);			
			rs = DBUtils.executeQuery(strQuery);			
			while (rs.next())
			{ 
				vecCol = new ArrayList();
				for (i=0;i<6;i++ )
				{ vecCol.add(correctNull(rs.getString(i+1)));				  
				}
				vecRow.add(vecCol);
				//bool =true;
			}
			hshRecord.put("vecRow",vecRow);			

		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getAnnexure2Structure   "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	private HashMap getAnnexure2ProposedBuilding(HashMap hshRequestValues)
	{
		
		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol =null;

		HashMap hshRecord = new HashMap();
		
		String strQuery="";
		String strAppno="";
		//String strDesc="";
		//String strParam="";
		//String strTemp ="";

		//int totaldesc =0;
		int i =0;
		//boolean bool =false;
		try
		{			
			
			if(correctNull((String)hshRequestValues.get("hidappno"))=="")
			{
				strAppno = correctNull((String) hshRequestValues.get("appno"));
			}
			else
			{
				strAppno = correctNull((String) hshRequestValues.get("hidappno"));
			}			
							
			strQuery = SQLParser.getSqlQuery("selssiannexure2propbuilding^"+strAppno);			
			rs = DBUtils.executeQuery(strQuery);			
			while (rs.next())
			{ 
				vecCol = new ArrayList();
				for (i=0;i<10;i++ )
				{ vecCol.add(correctNull(rs.getString(i+1)));				  
				}
				vecRow.add(vecCol);
				//bool =true;
			}
			hshRecord.put("vecRow",vecRow);	

		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getAnnexure2ProposedBuilding   "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap getAnnexure2MachineryDetails(HashMap hshRequestValues)
	{
		
		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol =null;

		HashMap hshRecord = new HashMap();
		
		String strQuery="";
		String strAppno="";
		//String strDesc="";
		//String strParam="";
		//String strTemp ="";

		//int totaldesc =0;
		int i =0;
		//boolean bool =false;
		try
		{			
			
			if(correctNull((String)hshRequestValues.get("hidappno"))=="")
			{
				strAppno = correctNull((String) hshRequestValues.get("appno"));
			}
			else
			{
				strAppno = correctNull((String) hshRequestValues.get("hidappno"));
			}		
							
			strQuery = SQLParser.getSqlQuery("selssiannexure2machinerydetails^"+strAppno);			
			rs = DBUtils.executeQuery(strQuery);			
			while (rs.next())
			{ 
				vecCol = new ArrayList();
				for (i=0;i<=11;i++ )
				{ vecCol.add(correctNull(rs.getString(i+1)));				  
				}
				vecRow.add(vecCol);
				//bool =true;
			}
			hshRecord.put("vecRow",vecRow);			

		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getAnnexure2MachineryDetails   "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	
	/**
	 * @method added for other details in Appendix
	 * @added by S.SATHYA MOORTHY
	 * 
	 * @param hshRequestValues
	 * @return
	 * @
	 */
	public HashMap getotherdetailsData1(HashMap hshValues) 
	{
		HashMap hashmap=new HashMap();
		ResultSet rs=null;
		String comappid=(String)hshValues.get("appno");
		
				//RETREVING DETAILS FROM COM_SSI_OTHERDETAILS
		
		try
		{
		String strQuery = SQLParser.getSqlQuery("ssi_otherdetails_select^"+comappid);			
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hashmap.put("txt_avgmonthlysales",Helper.correctNull((String)rs.getString(1)));
			hashmap.put("txt_electricpowerrequired",Helper.correctNull((String)rs.getString(2)));
		
			hashmap.put("txt_unskilledlabour",Helper.correctNull((String)rs.getString(3)));
			hashmap.put("txt_skilledlabour",Helper.correctNull((String)rs.getString(4)));
			hashmap.put("txt_supervisor",Helper.correctNull((String)rs.getString(5)));
			hashmap.put("txt_officers",Helper.correctNull((String)rs.getString(6)));
			
			
		}
		
		}
		catch(Exception e)
		{
			e.printStackTrace();
			
		}
		finally
		{
			try
			{
			if(rs!=null)rs.close();
			}catch(Exception e){}
		}
		
		
		
		
		return hashmap;
	}
	
	public HashMap updateotherdetails1(HashMap hshValues) 
	{
		
		HashMap hashmap=new HashMap();
		ResultSet rs=null;
		
		ArrayList arrValues=new ArrayList();
		String strAction="";
		strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		String comappid=Helper.correctNull((String)hshValues.get("appno"));
		
		
		if(strAction.equalsIgnoreCase("insert"))
		{
		
		}
		if(strAction.equalsIgnoreCase("update"))
		{
		
		}
		
		try
		{
		
	if (strAction.equalsIgnoreCase("update"))
		{
		arrValues.add(Helper.correctNull((String)hshValues.get("txt_avgmonthlysales")));
		arrValues.add(Helper.correctNull((String)hshValues.get("txt_electricpowerrequired")));
		arrValues.add(Helper.correctNull((String)hshValues.get("txt_unskilledlabour")));
		arrValues.add(Helper.correctNull((String)hshValues.get("txt_skilledlabour")));
		arrValues.add(Helper.correctNull((String)hshValues.get("txt_supervisor")));
		arrValues.add(Helper.correctNull((String)hshValues.get("txt_officers")));
		arrValues.add(comappid);
			
			String strQuery = SQLParser.getSqlQuery("ssi_otherdetails_select^"+comappid);			
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				
				HashMap hashvalues=new HashMap();
				hashvalues.put("arrValues",arrValues);
				hashvalues.put("strQueryId","ssi_otherdetails_update");
				
				HashMap hm=new HashMap();
				hm.put("size","1");
				hm.put("1",hashvalues);
				
			
				EJBInvoker.executeStateLess("dataaccess",hm,"updateData");
					
				
				
			}
			else
			{
				 arrValues=new ArrayList();
				arrValues.add(comappid);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_avgmonthlysales")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_electricpowerrequired")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_unskilledlabour")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_skilledlabour")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_supervisor")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_officers")));
				
				HashMap hashvalues=new HashMap();
				hashvalues.put("arrValues",arrValues);
				hashvalues.put("strQueryId","ssi_otherdetails_insert");
				
				HashMap hm=new HashMap();
				hm.put("size","1");
				hm.put("1",hashvalues);
						
				EJBInvoker.executeStateLess("dataaccess",hm,"updateData");
							
				
			}
			
						
		}
				
		if(strAction.equalsIgnoreCase("delete"))
		{
			
			
			
			HashMap hashvalues=new HashMap();
			arrValues=new ArrayList();
			arrValues.add(comappid);
			hashvalues.put("arrValues",arrValues);
			hashvalues.put("strQueryId","ssi_otherdetails_delete");

			HashMap hm=new HashMap();
			hm.put("size","1");
			hm.put("1",hashvalues);
					
			EJBInvoker.executeStateLess("dataaccess",hm,"updateData");
					
			
		}
		
		}
		catch(Exception e)
		{
			
			e.printStackTrace();
			
		}
		
		finally
		{
			try
			{
			if(rs!=null)rs.close();
			}catch(Exception e){}
		}
		
		return hashmap;

		}
		
		


//public HashMap getApplicantBakgroundDetails(HashMap hshRequestValues)
//	{
//		
//		ResultSet rs = null;
//		ArrayList vecRow = new ArrayList();
//		//ArrayList vecCol =null;
//
//		HashMap hshRecord = new HashMap();
//		
//		String strQuery="";
//		String strAppno="";
//		String strId ="";
//		String strcom_appid ="";
//		//String strDesc="";
//		//String strParam="";
//		//String strTemp ="";
//
//		//int totaldesc =0;
//		int i =0;
//		//boolean bool =false;
//		try
//		{
//			
//			if((correctNull((String)hshRequestValues.get("hidappno"))).trim().equals(""))
//			{
//				strAppno = correctNull((String) hshRequestValues.get("appno"));
//			}
//			else
//			{
//				strAppno = correctNull((String) hshRequestValues.get("hidappno"));
//			}			
//			strId = correctNull((String)hshRequestValues.get("hidId"));	
//			
//			strcom_appid = correctNull((String)hshRequestValues.get("comapp_id"));
//			
//			rs=DBUtils.executeLAPSQuery("comappmasterexistsel^"+strcom_appid);
//			if(rs.next())
//			{
//				hshRecord.put("comapp_totalshares",correctNull(rs.getString("comapp_totalshares")));
//			}
//			
//			//strQuery = SQLParser.getSqlQuery("selssiupto10applicant1share^"+strAppno);				
//			//rs = DBUtils.executeQuery(strQuery);
//			//int Count=0;
//			if (rs.next())
//			{
//				hshRecord.put("totalsharevalue",correctNull(rs.getString("totalsharevalue")));
//			}
//			
//			if(!correctNull((String)hshRequestValues.get("hidId")).equals(""))
//			{
//				
//							
//				strQuery = SQLParser.getSqlQuery("selssiupto10applicant1^"+strAppno+"^"+strId);				
//				rs = DBUtils.executeQuery(strQuery);
//				//int Count=0;
//				if (rs.next())
//				{ 
//					for (i=0;i<15;i++ )
//					{
//						vecRow.add(correctNull((String)rs.getString(i+1)));
//					}
//					
//					hshRecord.put("type",(String)vecRow.get(10));
//					hshRecord.put("ssi_upto10resaddress",correctNull((String)rs.getString("ssi_upto10resaddress")));
//					hshRecord.put("ssi_upto10restelno",correctNull((String)rs.getString("ssi_upto10restelno")));
//					//To Display Applicant Name on PROMOTER PAGE
//					String A1=correctNull((String)rs.getString(1));
//					String A2=correctNull((String)rs.getString(2));
//					String A3 = A2+" "+A1;
//					hshRecord.put("ApplicantName",A3);
//
//				}			
//			}
//			else
//			{
//				for (i=0;i<15;i++ )
//				{ 
//					vecRow.add("");				  
//				}	
//				hshRecord.put("type","S");
//				hshRecord.put("ssi_upto10resaddress","");
//				hshRecord.put("ssi_upto10restelno","");
//			}
//			hshRecord.put("appid",strId);
//			hshRecord.put("vecRow",vecRow);			
//			hshRecord.put("appname",correctNull((String)vecRow.get(1))+" "+correctNull((String)vecRow.get(0)));
//
//		}
//		
//		
//		
//		catch(Exception ce)
//		{
//			throw new EJBException("Error in getApplicantBakgroundDetails   "+ce.toString());
//		}
//		finally
//		{
//			try
//			{	if(rs != null)
//					rs.close();
//				
//			}
//			catch(Exception cf)
//			{
//				throw new EJBException("Error closing the connection "+cf.getMessage());
//			}
//		}
//		return hshRecord;
//	}

//	public HashMap getApplicanBackgroundHelpData(HashMap hshRequestValues)
//	{
//		
//		ResultSet rs = null;
//		ArrayList vecId = new ArrayList();
//		ArrayList vecAppName = new ArrayList();
//		HashMap hshRecord = new HashMap();		
//		String strQuery="";
//		String strAppno="";
//
//		//int i =0;
//		try
//		{			
//			
//			if(correctNull((String)hshRequestValues.get("hidappno"))=="")
//			{
//				strAppno = correctNull((String) hshRequestValues.get("appno"));
//			}
//			else
//			{
//				strAppno = correctNull((String) hshRequestValues.get("hidappno"));
//			}			
//										
//			strQuery = SQLParser.getSqlQuery("selallssiupto10applicant^"+strAppno);			
//			rs = DBUtils.executeQuery(strQuery);			
//			while (rs.next())
//			{ 
//				vecId.add(correctNull((String)rs.getString("ssi_applicant_id")));
//				vecAppName.add(correctNull((String)rs.getString("ssi_applicantname")));
//				
//			}
//			hshRecord.put("vecId",vecId);
//			hshRecord.put("vecAppName",vecAppName);			
//
//		}
//		catch(Exception ce)
//		{
//			throw new EJBException("Error in getApplicanBackgroundHelpData-- "+ce.toString());
//		}
//		finally
//		{
//			try
//			{	if(rs != null)
//					rs.close();
//				
//			}
//			catch(Exception cf)
//			{
//				throw new EJBException("Error closing the connection "+cf.getMessage());
//			}
//		}
//		return hshRecord;
//	}

//	private HashMap getGuarantorDetails(HashMap hshRequestValues)
//	{
//		
//		ResultSet rs = null;
//		ArrayList vecRow = new ArrayList();
//		//ArrayList vecCol =null;
//
//		HashMap hshRecord = new HashMap();
//		
//		String strQuery="";
//		String strAppno="";
//		String strId ="";
//		//String strDesc="";
//		//String strParam="";
//		//String strTemp ="";
//
//		//int totaldesc =0;
//		int i =0;
//		//boolean bool =false;
//		try
//		{			
//			
//			if(correctNull((String)hshRequestValues.get("hidappno"))=="")
//			{
//				strAppno = correctNull((String) hshRequestValues.get("appno"));
//			}
//			else
//			{
//				strAppno = correctNull((String) hshRequestValues.get("hidappno"));
//			}			
//			strId = correctNull((String)hshRequestValues.get("hidId"));			
//			if(correctNull((String)hshRequestValues.get("hidId")).equals(""))
//			{
//				strId ="0";
//			}
//							
//			strQuery = SQLParser.getSqlQuery("selssiguarantor^"+strAppno+"^"+strId);
//			rs = DBUtils.executeQuery(strQuery);			
//			while (rs.next())
//			{ 
//				for (i=0;i<4;i++ )
//				{ vecRow.add(correctNull(rs.getString(i+1)));
//				
//				}
//				hshRecord.put("ssi_guarantor_telno",correctNull((String)rs.getString("ssi_guarantor_telno")));
//				hshRecord.put("ApplicantName",correctNull((String)rs.getString("ssi_guarantor_name")));
//			}
//			hshRecord.put("appid",strId);
//			hshRecord.put("vecRow",vecRow);
//			hshRecord.put("frompage",correctNull((String)hshRequestValues.get("frompage")));			
//
//		}
//		catch(Exception ce)
//		{
//			throw new EJBException("Error in getGuarantorDetails   "+ce.toString());
//		}
//		finally
//		{
//			try
//			{	if(rs != null)
//					rs.close();
//				
//			}
//			catch(Exception cf)
//			{
//				throw new EJBException("Error closing the connection "+cf.getMessage());
//			}
//		}
//		return hshRecord;
//	}

//	public HashMap getGuarantorHelpData(HashMap hshRequestValues)
//	{
//		
//		ResultSet rs = null;
//		ArrayList vecId = new ArrayList();
//		ArrayList vecAppName = new ArrayList();
//
//		HashMap hshRecord = new HashMap();
//		
//		String strQuery="";
//		String strAppno="";
//
//		//int i =0;
//		try
//		{			
//			
//			if(correctNull((String)hshRequestValues.get("hidappno"))=="")
//			{
//				strAppno = correctNull((String) hshRequestValues.get("appno"));
//			}
//			else
//			{
//				strAppno = correctNull((String) hshRequestValues.get("hidappno"));
//			}			
//										
//			strQuery = SQLParser.getSqlQuery("selallssiguarantor^"+strAppno);			
//			rs = DBUtils.executeQuery(strQuery);			
//			while (rs.next())
//			{ 
//				vecId.add(correctNull((String)rs.getString("ssi_guarantor_id")));
//				vecAppName.add(correctNull((String)rs.getString("ssi_guarantor_name")));
//				
//			}
//			hshRecord.put("vecId",vecId);
//			hshRecord.put("vecAppName",vecAppName);			
//
//		}
//		catch(Exception ce)
//		{
//			throw new EJBException("Error in getGuarantorHelpData-- "+ce.toString());
//		}
//		finally
//		{
//			try
//			{	if(rs != null)
//					rs.close();
//				
//			}
//			catch(Exception cf)
//			{
//				throw new EJBException("Error closing the connection "+cf.getMessage());
//			}
//		}
//		return hshRecord;
//	}



	public void updateProjectData(HashMap hshValues) 
	{			
		HashMap hshQueryValues = new HashMap();
		ResultSet rs=null;
		HashMap hshQuery = null;
		ArrayList arrValues=null;
		String strAppno="";
		String strQuery="";
		String strsno="";
		strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		strsno=Helper.correctNull((String)hshValues.get("hid_strsno"));
		
		String strDesig=Helper.correctNull((String)hshValues.get("txt_designation"));
		String strPresent=Helper.correctNull((String)hshValues.get("txt_present"));
		String strProposed=Helper.correctNull((String)hshValues.get("txt_proposed"));
		String strTabname=Helper.correctNull((String)hshValues.get("hidTabName"));
		StringBuilder sbolddata=new StringBuilder();
		try
		{
			StringBuilder sbAt = new StringBuilder();
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				strQuery=SQLParser.getSqlQuery("selssiabv10employmentbyid^"+strsno+"^"+strAppno+"^"+"Employment");
				rs=DBUtils.executeQuery(strQuery);	
				if(rs.next())
				{
					sbolddata.append("~Designation = ").append(correctNull(rs.getString("SSI_PROJDESC"))).append(
					"~Present = ").append(correctNull(rs.getString("ssi_projexisting"))).append(
					"~Proposed  = ").append(correctNull(rs.getString("ssi_projfuture")));
				}
			}
			if(strAction.equalsIgnoreCase("insert"))
			{	
				if(rs!=null)
				{
					rs.close();
				}
				
				strQuery="sel_maxemployment^"+strAppno;
				rs=DBUtils.executeLAPSQuery(strQuery);
				if(rs.next())
				{
					 strsno=Helper.correctNull((String)rs.getString("employment_no"));
				}
				if(rs!=null)
				{
					rs.close();
				}
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insssiabv10employment");
				
				arrValues.add(strAppno);
				arrValues.add(strsno);
				arrValues.add(strTabname);
				arrValues.add(strDesig);
				arrValues.add(strPresent);
				arrValues.add(strProposed);
						
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_employment");
				
				arrValues.add(strDesig);
				arrValues.add(strPresent);
				arrValues.add(strProposed);
				arrValues.add(strAppno);
				arrValues.add(strsno);
				
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				
				arrValues.add(strAppno);
				arrValues.add(strsno);
				
				hshQuery.put("strQueryId","delssiabv10employment");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			//---------------------------------------AuditTrial----------------------------------
			if(!strAction.equalsIgnoreCase("delete")){
			sbAt.append("~Designation = ").append(strDesig).append(
			"~Present = ").append(strPresent).append(
			"~Proposed  = ").append(strProposed);
			}
			AuditTrial.auditNewLog(hshValues,"173",strAppno,sbAt.toString(),sbolddata.toString());		
			//AuditTrial.auditNewLog(hshValues,"173",strAppno,sbAt.toString(),sbolddata.toString());		
			//-------------------------------------------End-------------------------------------
			
				
		}
		catch(Exception ae)
		{
			throw new EJBException("Error in updateEmployment-- "+ae.toString());
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
				throw new EJBException("Error closing in updateEmployment"+cf.getMessage());						
			}
		}
		
		
		/*int noofrows=0;
		String MyAction="";
		String strTemp = "";
		int i =0;
		try
		{
			noofrows = Integer.parseInt(correctNull((String )hshValues.get("hidTotalDesc")))+1;			
		 	hshQueryValues = new HashMap();
			hshQuery = new HashMap();					
				
			MyAction=correctNull((String)hshValues.get("hidVal"));
			hshQuery.put("strQueryId","delssiabv10employment");
			arrValues.add(correctNull((String )hshValues.get("appno")));
			arrValues.add(correctNull((String )hshValues.get("hidTabName")));			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);

			for( i=1;i<noofrows;i++)
			{
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insssiabv10employment");
				arrValues.add(correctNull((String )hshValues.get("appno")));
				arrValues.add(Integer.toString(i));
				arrValues.add(correctNull((String )hshValues.get("hidTabName")));
				strTemp = "hidDesc"+Integer.toString(i);
				arrValues.add(correctNull((String )hshValues.get(strTemp)));
				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(i)+"1";
				arrValues.add(correctNull((String) hshValues.get(strTemp)));
				strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+Integer.toString(i)+"2";
				arrValues.add(correctNull((String )hshValues.get(strTemp)));				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(i+1),hshQuery);
			}
			hshQueryValues.put("size",Integer.toString(i));
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			hshQuery =(HashMap)getData(hshValues);
		
		 if(MyAction.equals("Delete"))
					  {										
					 	hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQueryValues.put("size","1");
						hshQuery.put("strQueryId","delssiabv10employment");
						arrValues.add(correctNull((String )hshValues.get("appno")));						
						arrValues.add(correctNull((String )hshValues.get("hidTabName")));						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);							
					   EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					 }
		
		}
		catch(Exception ce)
		{
			throw new EJBException(ce.toString());
		}*/
		
		
	}

	public HashMap updateGeneralData(HashMap hshValues) 
	{			
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();

		int noofrows=0;
		int maxgenid=0;

		String strTemp = "",strTemp2="";
		String strAction = "";
		String strTabName ="";
		String app_no="";
		String sqno2="";
		ResultSet rs=null;
		String strQuery="";		
		int i=0;
		try
		{
			noofrows = Integer.parseInt(correctNull((String )hshValues.get("hidTotalDesc")))+1;		 	
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();	
			
			if(correctNull((String)hshValues.get("hidGenID")).equals(""))
			{
				strTemp = "0";
			}
			else
			{
				strTemp = (String)hshValues.get("hidGenID");
			}
			maxgenid = getGenId(correctNull((String )hshValues.get("appno")));			
			strAction = correctNull((String )hshValues.get("hidAction"));			
			strTabName = correctNull((String)hshValues.get("hidTabName"));
			

			if(strAction.equals("insert"))
			{
				hshQuery.put("strQueryId","delssiabv10associate");
				arrValues.add(correctNull((String )hshValues.get("appno")));
				arrValues.add(strTabName);
				arrValues.add(strTemp);				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				for( i=1;i<noofrows;i++)
				{
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","insssiabv10associate");
					arrValues.add(correctNull((String )hshValues.get("appno")));
					arrValues.add(Integer.toString(maxgenid+(i-1)));
					arrValues.add(strTabName);
					strTemp = "hidDesc"+Integer.toString(i);					
					arrValues.add(correctNull((String )hshValues.get(strTemp)));
					strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(i);
					strTemp2 = correctNull((String) hshValues.get(strTemp));
					arrValues.add(strTemp2.getBytes());
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(i+1),hshQuery);					
				}
				hshQueryValues.put("size",Integer.toString(i));
			}
			else if(strAction.equals("update"))
			{	
				for( i=1;i<noofrows;i++)
				{	hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","updssiabv10associate");
					strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(i);
					strTemp2 = correctNull((String) hshValues.get(strTemp));
					arrValues.add(strTemp2.getBytes());								
					arrValues.add(correctNull((String )hshValues.get("appno")));			
					strTemp = "hidtxt"+Integer.toString(i);
				//	strTemp = "txt_utilities"+Integer.toString(i);
					arrValues.add(correctNull((String )hshValues.get(strTemp)));
					arrValues.add(strTabName);
					strTemp = "hidDesc"+Integer.toString(i);
				//	strTemp = "txt_utilities"+Integer.toString(i);
					arrValues.add(correctNull((String )hshValues.get(strTemp)));					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(i),hshQuery);
					hshQueryValues.put("size",Integer.toString(i));
				}
			}			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			hshQuery =(HashMap)getData(hshValues);
		
			if(strAction.equalsIgnoreCase("Delete"))
		{		
				int j=0;
				strQuery = SQLParser.getSqlQuery("execusumselect^"+app_no);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				  {
					j++;
				  }
				if(j==1)
					{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					
					hshQuery.put("strQueryId","execusumdelete");
					arrValues.add(app_no);
					arrValues.add(sqno2);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","execusumsubdelete");
					arrValues.add(app_no);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();				
					hshQuery.put("strQueryId","execusumsubdelete1");
					arrValues.add(app_no);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","execusumsubdelete2");
					arrValues.add(app_no);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
					}
					else
					{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","execusumdelete");
					arrValues.add(app_no);
					arrValues.add(sqno2);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
					}
		 }
		
		}
		catch(Exception ce)
		{
			throw new EJBException(ce.toString());
		}finally
		{
			try
			{
				if(rs!=null)
					rs.close();
			}catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in updateGeneralData "+ exp.toString()); 
			}
		}
		return hshQuery;
	}

	public HashMap updateCostofProjectData(HashMap hshValues) 
	{			
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		int noofrows=0;
		//int maxgenid=0;		
		ResultSet rs=null;
		String strQuery="";
		String strTemp = "";
		String MyAction = "";
		String strAppno="";
		String strTabName ="";
		String PurposeForTL="",EstimatePreparedBy="",EscalationInEstimates="";

		int i =1;
		try
		{
			java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
			nf.setMinimumFractionDigits(2);
			nf.setMaximumFractionDigits(2);
			nf.setGroupingUsed(false);
			if(correctNull((String)hshValues.get("hidappno"))=="")
			{
				strAppno = correctNull((String) hshValues.get("appno"));
			}
			else
			{
				strAppno = correctNull((String) hshValues.get("hidappno"));
			}				
			
			noofrows = Integer.parseInt(correctNull((String )hshValues.get("hidTotalDesc")))+1;			
		 	hshQueryValues = new HashMap();
			hshQuery = new HashMap();				
			
			strTabName = correctNull((String)hshValues.get("hidTabName"));			
			MyAction=correctNull((String)hshValues.get("hidAction"));			
			hshQuery.put("strQueryId","delssiabv10costofproject");
			arrValues.add(correctNull((String )hshValues.get("appno")));
			arrValues.add(strTabName);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);			
						
			if(!MyAction.equals("Delete"))
			{
				for( i=1;i<noofrows;i++)
				{
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","insssiabv10costofproject");
					
					arrValues.add(correctNull((String )hshValues.get("appno")));
					arrValues.add(Integer.toString(i));
					strTemp = "hidDesc"+Integer.toString(i);					
					arrValues.add(correctNull((String )hshValues.get(strTemp)));
					
					arrValues.add(strTabName);
					
					strTemp = correctNull((String )hshValues.get("hidFieldPrefix"))+"1"+ Integer.toString(i);
					arrValues.add(Helper.correctDouble((String) hshValues.get(strTemp)));
						
					strTemp = correctNull((String )hshValues.get("hidFieldPrefix"))+"2"+ Integer.toString(i);
					arrValues.add(Helper.correctDouble((String) hshValues.get(strTemp)));
						
					strTemp = correctNull((String )hshValues.get("hidFieldPrefix"))+"3"+ Integer.toString(i);
					arrValues.add(Helper.correctDouble((String) hshValues.get(strTemp)));
						
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(i+1),hshQuery);
					
				}
				
				hshQueryValues.put("size",Integer.toString(i));
			
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				if(strTabName.equals("getCostofProject"))
				{
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					arrValues=new ArrayList();				
					
					arrValues.add(strAppno);
					arrValues.add(strTabName);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","del_anticipatedturnover_TL");
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
			  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			  		
			  		PurposeForTL=Helper.correctNull((String)hshValues.get("txt_PurposeForTL"));
			  		EstimatePreparedBy=Helper.correctNull((String)hshValues.get("txt_EstimatePreparedBy"));
			  		EscalationInEstimates=Helper.correctNull((String)hshValues.get("txt_EscalationInEstimates"));
			  		
			  		hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					
					arrValues.add(strAppno);
					arrValues.add(strTabName);
					arrValues.add(PurposeForTL);
					arrValues.add(EstimatePreparedBy);
					arrValues.add(EscalationInEstimates);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","ins_anticipatedturnover_TL");
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
			  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");					
			  		
				}
				
				// added by priya gfor ciomments of means of finance 
				if (strTabName.equals("MeansOfFinancing"))
				{
					strQuery = SQLParser.getSqlQuery("selssimeansoffincomm^"+strAppno);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							hshQueryValues.put("size","1");
							hshQuery.put("strQueryId","updssimeansoffincomm");
							arrValues.add(correctNull((String)hshValues.get("comm1")));
							arrValues.add(correctNull((String)hshValues.get("comm2")));
							arrValues.add(correctNull((String)hshValues.get("comm3")));
							arrValues.add(correctNull((String)hshValues.get("comm4")));
							arrValues.add(correctNull((String)hshValues.get("comm5")));
							arrValues.add(correctNull((String)hshValues.get("appno")));
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
					else
					{	
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							hshQueryValues.put("size","1");
							hshQuery.put("strQueryId","insssimeansoffincomm");
							arrValues.add(correctNull((String )hshValues.get("appno")));
							arrValues.add(correctNull((String)hshValues.get("comm1")));
							arrValues.add(correctNull((String)hshValues.get("comm2")));
							arrValues.add(correctNull((String)hshValues.get("comm3")));
							arrValues.add(correctNull((String)hshValues.get("comm4")));
							arrValues.add(correctNull((String)hshValues.get("comm5")));
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
				}
				hshQuery =(HashMap)getData(hshValues);

		  }
		
		if(MyAction.equals("Delete"))
		{	
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","delssiabv10costofproject");
					arrValues.add(correctNull((String )hshValues.get("appno")));					
					arrValues.add(strTabName);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					arrValues.add(strAppno);
					arrValues.add(strTabName);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","del_anticipatedturnover_TL");
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
			  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
					if (strTabName.equals("MeansOfFinancing"))
					{
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							hshQueryValues.put("size","1");
							hshQuery.put("strQueryId","delssimeansoffincomm");
							arrValues.add(correctNull((String )hshValues.get("appno")));					
							//arrValues.add(strTabName);
							
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
			
		}
		double alrincurresd=0.00;
		double tobeincurresd=0.00;
		double totcost=0.00;
		if(strTabName.equals("getCostofProject"))
		{
			StringBuilder sbAuditTrial=new StringBuilder();
			if(!MyAction.equals("Delete")){
			String strdesc[]= {"Cost of Project","Land including development","Building & Other Civil Works",
			"Indigenous","Imported","Essential Tools, Spares & Accessories","Testing Equipment"
			,"Miscellaneous Fixed Assets","Erection / Installation charges","Preliminary Expenses"
			,"Pre-Operative Expenses","Building",
			"Plant & Machinery","Other Fixed Assets",
			"Margin for Working Capital Required","Total"};
			for(i=0;i<=noofrows;i++)
			{
				if(i==0)
				{
					sbAuditTrial
					.append(strdesc[i]).append("^");
				}
				else
				{		if(i!=noofrows)
						{
					    alrincurresd+=Double.parseDouble(Helper.correctDouble((String )hshValues.get("txt_costofprojectincurred"+"1"+ Integer.toString(i))));
					    tobeincurresd+=Double.parseDouble(Helper.correctDouble((String )hshValues.get("txt_costofprojectincurred"+"2"+ Integer.toString(i))));
					    totcost+=(Double.parseDouble(Helper.correctDouble((String )hshValues.get("txt_costofprojectincurred"+"1"+ Integer.toString(i))))+Double.parseDouble(Helper.correctDouble((String )hshValues.get("txt_costofprojectincurred"+"2"+ Integer.toString(i)))));
						sbAuditTrial.append("~").append(strdesc[i]).append("^")
						.append("~Already incurred = ")
						.append(correctNull((String )hshValues.get("txt_costofprojectincurred"+"1"+ Integer.toString(i))))
						.append("~To be incurred = ")
						.append(correctNull((String )hshValues.get("txt_costofprojectincurred"+"2"+ Integer.toString(i))))
						.append("~Total Cost= ")
						.append(nf.format(Double.parseDouble(Helper.correctDouble((String )hshValues.get("txt_costofprojectincurred"+"1"+ Integer.toString(i))))+Double.parseDouble(Helper.correctDouble((String )hshValues.get("txt_costofprojectincurred"+"2"+ Integer.toString(i))))))
						;
						}
				}
				if(i==noofrows)
				{
					sbAuditTrial.append("~").append(strdesc[i]).append("^")
					.append("~Already incurred = ")
					.append(nf.format(alrincurresd))
					.append("~To be incurred = ")
					.append(nf.format(tobeincurresd))
					.append("~Total Cost= ")
					.append(nf.format(totcost))
					;
				}
			}
			}
			if(MyAction.equalsIgnoreCase(""))
			{
			hshValues.put("hidAction","update");
			}
			AuditTrial.auditLog(hshValues,"178",strAppno,sbAuditTrial.toString());
			}
			else if(strTabName.equals("MeansOfFinancing")){

				StringBuilder sbAuditTrial=new StringBuilder();
				if(!MyAction.equals("Delete")){
				String strdesc[]= {"Capital","Reserves","Term loans",
				"Unsecured Loans and Deposits","Deferred Payment Arrangements","Subsidy Central Govt. State Govt","Seed Capital"
				,"Internal Cash Accurals","Other Sources"};
				noofrows = noofrows-1;
				for(i=0;i<noofrows;i++)
				{
							sbAuditTrial.append("~").append(strdesc[i]).append("^")
							.append("~ Amount already raised = ")
							.append(correctNull((String )hshValues.get("txt_costofprojectraised"+"1"+ Integer.toString(i+1))))
							.append("~ Amount proposed to be raised = ")
							.append(correctNull((String )hshValues.get("txt_costofprojectraised"+"2"+ Integer.toString(i+1))));
				}
				}
				if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
				{
				hshValues.put("hidAction","update");
				}
				else if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("N"))
				{
					hshValues.put("hidAction","Insert");
				}
				AuditTrial.auditLog(hshValues,"302",strAppno,sbAuditTrial.toString());
				
		}
		}
		catch(Exception ce)
		{
			throw new EJBException(ce.toString());
		}

		finally
		{
			try
			{
				if(rs!=null)
				{
					rs.close();
				}
				
			}
			catch(Exception e)
			{
				throw new EJBException(
								"Error in closing Connection "+e.getMessage());
			}
		}

		return hshQuery;
	}

	private int getGenId(String strAppno )
	{
		String strQuery="";
		ResultSet rs = null;
		int genId = 0;
		try
		{	
			strQuery = SQLParser.getSqlQuery("maxgenidssiabv10associate^"+strAppno);			
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(rs.getString(1) != null)
				{
					genId = Integer.parseInt(rs.getString(1));
				}
				else
				{
					genId = 1;
				}
			}			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData2 "+ce.toString());
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
		return genId;
	}

	public HashMap updateExportProductsData(HashMap hshValues) 
	{			
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		//HashMap hshQuery1 = new HashMap();
		ArrayList arrValues=new ArrayList();
		
		int noofrows=0;
		ResultSet rs=null;
		String strQuery="";
		String appno="";
		String []txt_exportproducts = new String[5];
		String []txt_exportproductcntry=new String[5];
		String []txt_exportproductvalue=new String[5];
		//String strTemp = "";
		try
		{			
			StringBuilder sbAt = new StringBuilder();
			if(correctNull((String)hshValues.get("hidappno"))=="")
			{
				appno = correctNull((String) hshValues.get("appno"));
			}
			else
			{
				appno = correctNull((String) hshValues.get("hidappno"));
			}
			
			String strAction= correctNull((String)hshValues.get("hidAction"));			
			String txt_exportercodeno	 =  correctNull((String )hshValues.get("txt_exportercodeno"));	
			   if(!txt_exportercodeno.equalsIgnoreCase(""))
			 {
			for (int j=0;j<5 ;j++ )
			{
			
			txt_exportproducts[j]=correctNull((String)hshValues.get("txt_exportproducts"+Integer.toString(j+1)));
			txt_exportproductcntry[j]=correctNull((String)hshValues.get("txt_exportproductcntry"+Integer.toString(j+1)));
			txt_exportproductvalue[j]=correctNull((String)hshValues.get("txt_exportproductvalue"+Integer.toString(j+1)));

			}
			strQuery = SQLParser.getSqlQuery("selssiabv10export^"+appno);			
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{	
				noofrows++;
			}
			
			//hshQueryValues.put("size","5");
			if (noofrows==0)
			{
				// for insert query---insssiabv10export//priya on 06-09
				//ssi_export_appno, ssi_export_code_no, ssi_export_product_id ,ssi_export_product_name ,ssi_export_country_name ,ssi_export_FOB_value
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				for (int i=0;i<5 ;i++ )
				{
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","insssiabv10export");
					arrValues.add(appno);
					arrValues.add(correctNull((String)txt_exportercodeno));
					arrValues.add(Integer.toString(i+1));
					arrValues.add(correctNull((String)txt_exportproducts[i]));
					arrValues.add(correctNull((String)txt_exportproductcntry[i]));
					arrValues.add(correctNull((String)txt_exportproductvalue[i]));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(i+1));
					hshQueryValues.put(Integer.toString(i+1),hshQuery);					
			  }
			}
			else
			{
				//for update query--updssiabv10export
				//ssi_export_code_no=?,	ssi_export_product_name=?,
				//ssi_export_country_name=?,ssi_export_FOB_value=? 	where  ssi_export_appno=? and ssi_export_product_id=?,
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				for (int i=0;i<5 ;i++ )
				{
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","updssiabv10export");
					arrValues.add(correctNull((String)txt_exportercodeno));
					arrValues.add(correctNull((String)txt_exportproducts[i]));
					arrValues.add(correctNull((String)txt_exportproductcntry[i]));
					arrValues.add(correctNull((String)txt_exportproductvalue[i]));
					arrValues.add(appno);
					arrValues.add(Integer.toString(i+1));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(i+1));
					hshQueryValues.put(Integer.toString(i+1),hshQuery);
			  }
		  }
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			 }
		 if(strAction.equalsIgnoreCase("Delete"))
		  {							
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","delssiabv10export");
			arrValues.add(appno); 
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);				
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		 }
		 
		 //------------------------------------AuditTrial------------------------------------
		 	String straction = "";
			if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
				{hshValues.put("hidAction","Update"); straction = "Update";}
			else if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("N"))
				{hshValues.put("hidAction","Insert"); straction = "Insert";}
			else
				{hshValues.put("hidAction","Delete"); straction = "Delete";}
		 
			if(!straction.equalsIgnoreCase("Delete")){
		sbAt.append("~Code Number = ").append(correctNull((String)txt_exportercodeno));
		for(int i=0;i<5;i++){
			if(!txt_exportproducts[i].equals("")){
		sbAt.append("~Name of the Product Exported = ").append(correctNull((String)txt_exportproducts[i])).append(
		"~Name of the Country where Exported = ").append(correctNull((String)txt_exportproductcntry[i])).append(
		"~F.O.B. Value = ").append(correctNull((String)txt_exportproductvalue[i]));		
			}
		 }
			}
	
		 AuditTrial.auditLog(hshValues,"177",appno,sbAt.toString());		
		 
		 //----------------------------------------End---------------------------------------
// COMMENTED BY PRIYA
//			noofrows=0;
//			noofrows = Integer.parseInt(correctNull((String )hshValues.get("hidTotalDesc")))+1;
//		 	hshQueryValues = new HashMap();
//			hshQuery = new HashMap();					
//			
//			if(correctNull((String)hshValues.get("hidGenID")).equals(""))
//			{
//				strTemp = "0";
//			}
//			else
//			{
//				strTemp = (String)hshValues.get("hidGenID");
//			}
//
//				
//			hshQuery.put("strQueryId","delssiabv10export");
//			arrValues.add(correctNull((String )hshValues.get("appno")));
//			hshQuery.put("arrValues",arrValues);
//			hshQueryValues.put("1",hshQuery);
//
//			for( i=0;i<noofrows;i++)
//			{
//				hshQuery = new HashMap();
//				arrValues=new ArrayList();
//				hshQuery.put("strQueryId","insssiabv10export");
//				arrValues.add(correctNull((String )hshValues.get("appno")));
//				
//				arrValues.add(correctNull((String )hshValues.get("txt_exportercodeno")));
//				arrValues.add(Integer.toString(i));
//				
//				//arrValues.add(correctNull((String )hshValues.get("txt_exportproducts1")));
//				strTemp = correctNull((String )hshValues.get("hidFieldPrefix"))+"1"+Integer.toString(i);
//				arrValues.add(correctNull((String) hshValues.get(strTemp)));
//				
//				//arrValues.add(correctNull((String )hshValues.get("txt_exportproducts2")));
//				strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"2"+Integer.toString(i);
//				arrValues.add(correctNull((String )hshValues.get(strTemp)));
//
//				//arrValues.add(correctNull((String )hshValues.get("txt_exportproducts3")));
//				strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"3"+Integer.toString(i);
//				arrValues.add(Helper.correctDouble((String )hshValues.get(strTemp)));
//
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put(Integer.toString(i+1),hshQuery);
//				hshQueryValues.put("size",Integer.toString(i));
//			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//			}
// END OF COMMENTED BY PRIYA 			
			hshQuery =(HashMap)getData(hshValues);
		}
		catch(Exception ce)
		{
			throw new EJBException(ce.toString());
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
		return hshQuery;
	}

	public HashMap updateStaffData(HashMap hshValues) 
	{			
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();

		int noofrows=0;

		String strTemp = "";
		int i =0 , j=0;
		try
		{
			noofrows = Integer.parseInt(correctNull((String )hshValues.get("hidTotalDesc")))+1;

		 	hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			hshQuery.put("strQueryId","delssiabv10staff");
			arrValues.add(correctNull((String )hshValues.get("appno")));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			j=1;

			for( i=1;i<noofrows;i++)
			{
				strTemp = correctNull((String )hshValues.get("hidFieldPrefix"))+"1"+Integer.toString(i);
				if(!correctNull((String) hshValues.get(strTemp)).equals(""))
				{
					j++;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","insssiabv10staff");
					arrValues.add(correctNull((String )hshValues.get("appno")));
					arrValues.add(Integer.toString(i));							
					strTemp = correctNull((String )hshValues.get("hidFieldPrefix"))+"1"+Integer.toString(i);
					arrValues.add(correctNull((String) hshValues.get(strTemp)));

					strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"2"+Integer.toString(i);
					arrValues.add(correctNull((String )hshValues.get(strTemp)));

					strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"3"+Integer.toString(i);
					arrValues.add(correctNull((String )hshValues.get(strTemp)));

					strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"4"+Integer.toString(i);
					arrValues.add(correctNull((String )hshValues.get(strTemp)));

					strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"5"+Integer.toString(i);
					arrValues.add(correctNull((String )hshValues.get(strTemp)));

					strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"6"+Integer.toString(i);
					arrValues.add(correctNull((String )hshValues.get(strTemp)));

					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(j),hshQuery);
				}
			}
			hshQueryValues.put("size",Integer.toString(j));			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			hshQuery =(HashMap)getData(hshValues);
		}
		catch(Exception ce)
		{
			throw new EJBException(ce.toString());
		}
		return hshQuery;
	}

	public HashMap updateAnnexure2StructureData(HashMap hshValues) 
	{			
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		int noofrows=0;

		ResultSet rs=null;
		String strQuery="";
		String strTemp = "";
		String MyAction="";
		int i =0 , j=0; 
		try
		{
			
			noofrows = Integer.parseInt(correctNull((String )hshValues.get("hidTotalDesc")))+1;			
		 	hshQueryValues = new HashMap();
			hshQuery = new HashMap();					
			MyAction=correctNull((String)hshValues.get("hidAction"));	
				
			hshQuery.put("strQueryId","delssiannexure2structure");
			arrValues.add(correctNull((String )hshValues.get("appno")));			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			j=1;

			strQuery = SQLParser.getSqlQuery("selectappendixstruct^"+correctNull((String )hshValues.get("appno")));					
					rs = DBUtils.executeQuery(strQuery);
					int q=0;
					if(rs.next())
					{
					q++;
					}				
			
		if(!MyAction.equals("Delete"))
		 {	
			
			for( i=1;i<noofrows;i++)
			{
				strTemp = correctNull((String )hshValues.get("hidFieldPrefix"))+"1"+Integer.toString(i);
				//if(!correctNull((String) hshValues.get(strTemp)).equals(""))
				//{
					j++;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","insssiannexure2structure");

					arrValues.add(correctNull((String )hshValues.get("appno")));
					arrValues.add(Integer.toString(i));

					strTemp = correctNull((String )hshValues.get("hidFieldPrefix"))+"1"+Integer.toString(i);
					arrValues.add(correctNull((String) hshValues.get(strTemp)));

					strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"2"+Integer.toString(i);
					arrValues.add(correctNull((String )hshValues.get(strTemp)));

					strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"3"+Integer.toString(i);
					arrValues.add(Helper.correctDouble((String )hshValues.get(strTemp)));

					strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"4"+Integer.toString(i);
					arrValues.add(Helper.correctDouble((String )hshValues.get(strTemp)));

					strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"5"+Integer.toString(i);
					arrValues.add(correctNull((String )hshValues.get(strTemp)));
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(j),hshQuery);
				//}
			}
			hshQueryValues.put("size",Integer.toString(j));			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			hshQuery =(HashMap)getData(hshValues);
		}
		
	  if(MyAction.equals("Delete"))
		{		
			if(q==1)
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","delssiannexure2structure");
				arrValues.add(correctNull((String )hshValues.get("appno")));					
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);					
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		
	}
		catch(Exception ce)
		{
			throw new EJBException(ce.toString());
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
		return hshQuery;
	}

	public HashMap updateAnnexure2BuildingProposedData (HashMap hshValues) 
	{			
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		int noofrows=0;
		ResultSet rs=null;
		String strQuery="";
		String MyAction="";
		String strTemp = "";
		//int updateSize=0;
		int i =0 , j=0;
		try
		{			
			noofrows = Integer.parseInt(correctNull((String )hshValues.get("hidTotalDesc")))+1;			
		 	hshQueryValues = new HashMap();
			hshQuery = new HashMap();					
			MyAction=correctNull((String)hshValues.get("hidAction"));	
			hshQuery.put("strQueryId","delssiannexure2propbuilding");
			arrValues.add(correctNull((String )hshValues.get("appno")));			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			j=1;
			
			strQuery = SQLParser.getSqlQuery("selectbuildingprop^"+correctNull((String )hshValues.get("appno")));			
			rs = DBUtils.executeQuery(strQuery);
			int p=0;
			if (rs.next())
			{
				p++;
			}			
					
		if(!MyAction.equals("Delete"))
		{	
			for( i=1;i<noofrows;i++)
			{
				
				strTemp = correctNull((String )hshValues.get("hidFieldPrefix"))+"1"+Integer.toString(i);
				if(!correctNull((String) hshValues.get(strTemp)).equals(""))
				{
					j++;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","insssiannexure2propbuilding");
					
					arrValues.add(correctNull((String )hshValues.get("appno")));
					arrValues.add(Integer.toString(i));		
					
					strTemp = correctNull((String )hshValues.get("hidFieldPrefix"))+"1"+Integer.toString(i);
					arrValues.add(correctNull((String) hshValues.get(strTemp)));

					strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"2"+Integer.toString(i);
					arrValues.add(correctNull((String )hshValues.get(strTemp)));

					strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"3"+Integer.toString(i);
					arrValues.add(Helper.correctDouble((String )hshValues.get(strTemp)));

					strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"4"+Integer.toString(i);
					arrValues.add(Helper.correctDouble((String )hshValues.get(strTemp)));

					strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"5"+Integer.toString(i);
					arrValues.add(Helper.correctDouble((String )hshValues.get(strTemp)));

					strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"6"+Integer.toString(i);
					arrValues.add(Helper.correctDouble((String )hshValues.get(strTemp)));

					strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"7"+Integer.toString(i);
					arrValues.add(Helper.correctDouble((String )hshValues.get(strTemp)));

					strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"8"+Integer.toString(i);
					arrValues.add(Helper.correctDouble((String )hshValues.get(strTemp)));

					strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"9"+Integer.toString(i);
					arrValues.add(correctNull((String )hshValues.get(strTemp)));

					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(j),hshQuery);
				}
			}
			hshQueryValues.put("size",Integer.toString(j));			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			hshQuery =(HashMap)getData(hshValues);
	}	
	if (MyAction.equals("Delete"))
	{		
		if (p==1)
		{	
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","delssiannexure2propbuilding");
			arrValues.add(correctNull((String )hshValues.get("appno")));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);				
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
	} 	
	
	StringBuilder sbAuditTrial=new StringBuilder();
	if (!MyAction.equals("Delete")){
	j=1;
	for( i=1;i<noofrows;i++)
	{
		strTemp = correctNull((String )hshValues.get("hidFieldPrefix"))+"1"+Integer.toString(i);
		if(!correctNull((String) hshValues.get(strTemp)).equals(""))
		{
			j++;
			
			if(i==1)
			{
				sbAuditTrial.append("S.No = ");
			}
			else
			{
				sbAuditTrial.append("~S.No = ");
			}
			if(i==1)
			{
				hshValues.put("hidAction", "Insert");
			}
			else
			{
				hshValues.put("hidAction", "Update");
			}
			
			strTemp = correctNull((String )hshValues.get("hidFieldPrefix"))+"1"+Integer.toString(i);
			sbAuditTrial.append(i).append("~Description of each Bldg = ").append(correctNull((String) hshValues.get(strTemp)));
			
			strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"2"+Integer.toString(i);
			sbAuditTrial.append("~Type of construction  = ").append(correctNull((String) hshValues.get(strTemp)));
			
			strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"3"+Integer.toString(i);
			sbAuditTrial.append("~Build up area in mtrs Length = ").append(correctNull((String) hshValues.get(strTemp)));
			
			strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"4"+Integer.toString(i);
			sbAuditTrial.append("~Build up area in mtrs Breadth = ").append(correctNull((String) hshValues.get(strTemp)));
			
			strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"5"+Integer.toString(i);
			sbAuditTrial.append("~ Build up area in mtrs Avg. Height= ").append(correctNull((String) hshValues.get(strTemp)));
			
			strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"6"+Integer.toString(i);
			sbAuditTrial.append("~ Total Floor Area in sq.mt = ").append(correctNull((String) hshValues.get(strTemp)));
			
			strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"7"+Integer.toString(i);
			sbAuditTrial.append("~ Rate of construction per sq.mt = ").append(correctNull((String) hshValues.get(strTemp)));
			
			strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"8"+Integer.toString(i);
			sbAuditTrial.append("~ Estimated cost of each Bldg. = ").append(correctNull((String) hshValues.get(strTemp)));
			
			strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"9"+Integer.toString(i);
			sbAuditTrial.append("~ Expected date of completion = ").append(correctNull((String) hshValues.get(strTemp)));
		}
	}
	}
	
	AuditTrial.auditLog(hshValues,"180",correctNull((String )hshValues.get("appno")),sbAuditTrial.toString());
	
 }
		catch(Exception ce)
		{
			throw new EJBException(ce.toString());
		}

		finally
		{
			try
			{
				if(rs!=null)
				{
					rs.close();
				}
				
			}
			catch(Exception e)
			{
				throw new EJBException(
								"Error in closing Connection "+e.getMessage());
			}
		}
		return hshQuery;
	}

public void updateAnnexure2MachineryData (HashMap hshValues) 
	{			
		/*HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		int noofrows=0;		
		ResultSet rs=null;

		String strQuery="";
		String MyAction="";
		String strTemp = "";
		int i =0 , j=0;
		try
		{
			
			noofrows = Integer.parseInt(correctNull((String )hshValues.get("hidTotalDesc")))+1;			
		 	hshQueryValues = new HashMap();
			hshQuery = new HashMap();					
			MyAction=correctNull((String)hshValues.get("hidAction"));	
			hshQuery.put("strQueryId","delssiannexure2machinerydetails");
			arrValues.add(correctNull((String )hshValues.get("appno")));			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			j=1;
			
			strQuery = SQLParser.getSqlQuery("selectmachinerydetails^"+correctNull((String )hshValues.get("appno")));			
			rs = DBUtils.executeQuery(strQuery);
			int m=0;
			if (rs.next())
			{
				m++;
			}			
			
	if (!MyAction.equals("Delete"))
		{
			
			for( i=1;i<noofrows;i++)
			{
				strTemp = correctNull((String)hshValues.get("hidFieldPrefix"))+"1"+Integer.toString(i);
				if(!correctNull((String) hshValues.get(strTemp)).equals(""))
				{
					j++;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","insssiannexure2machinerydetails");					
					arrValues.add(correctNull((String )hshValues.get("appno")));
					arrValues.add(Integer.toString(i));

					strTemp = "txt_machinerytype"+Integer.toString(i);					
					arrValues.add(correctNull((String) hshValues.get(strTemp)));
					//arrValues.add(strTemp);
					strTemp = correctNull((String )hshValues.get("hidFieldPrefix"))+"1"+Integer.toString(i);
					arrValues.add(correctNull((String) hshValues.get(strTemp)));
					//arrValues.add(strTemp);
					strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"2"+Integer.toString(i);
					arrValues.add(correctNull((String )hshValues.get(strTemp)));
					//arrValues.add(strTemp);
					
					strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"3"+Integer.toString(i);
					arrValues.add(correctNull((String )hshValues.get(strTemp)));
					//arrValues.add(strTemp);
					strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"4"+Integer.toString(i);
					arrValues.add(correctNull((String )hshValues.get(strTemp)));
					//arrValues.add(strTemp);
					strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"5"+Integer.toString(i);
					arrValues.add(correctNull((String )hshValues.get(strTemp)));
					//arrValues.add(strTemp);
					strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"6"+Integer.toString(i);
					arrValues.add(Helper.correctDouble((String )hshValues.get(strTemp)));
					//arrValues.add(strTemp);
					strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"7"+Integer.toString(i);
				arrValues.add(Helper.correctDouble((String )hshValues.get(strTemp)));
					//arrValues.add(strTemp);
					strTemp =correctNull((String )hshValues.get("hidFieldPrefix"))+"8"+Integer.toString(i);
					arrValues.add(Helper.correctDouble((String )hshValues.get(strTemp)));				
					//arrValues.add(strTemp);
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(i+1),hshQuery);
				//	hshQueryValues.put("3",hshQuery);
				}
			}
			hshQueryValues.put("size",Integer.toString(j));		
			//hshQueryValues.put("size","3");		
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			hshQuery =(HashMap)getData(hshValues);
		}
	
	if (MyAction.equals("Delete"))
	{		
		if(m==1)
		{
		hshQuery = new HashMap();
		arrValues = new ArrayList();
		hshQueryValues.put("size","1");
		hshQuery.put("strQueryId","delssiannexure2machinerydetails");
		arrValues.add(correctNull((String )hshValues.get("appno")));
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);			
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
	}

}
		catch(Exception ce)
		{
			throw new EJBException(ce.toString());
		}

		finally
		{
			try
			{
				if(rs!=null)
				{
					rs.close();
				}
				
			}
			catch(Exception e)
			{
				throw new EJBException(
								"Error in closing Connection "+e.getMessage());
			}
		}*/
		java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.setGroupingUsed(false);
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		HashMap hshQuery =new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strhidAction="";
		String strSno="";
		ResultSet rs=null;
		String strQuery="",strQueryId="";
		String strappno="";
		String strMachinerylist=Helper.correctNull((String)hshValues.get("sel_machinerylist"));
		String strMachinerytype=Helper.correctNull((String)hshValues.get("sel_machinerytype"));
		String strMachineryname=Helper.correctNull((String)hshValues.get("txt_machineryname"));
		String strMachinerycategory=Helper.correctNull((String)hshValues.get("sel_machinerycat"));
		String strMachineryManufname=Helper.correctNull((String)hshValues.get("txt_manufacturername"));
		String strMachineryAcqdate=Helper.correctNull((String)hshValues.get("txt_aquisationdate"));
		String strMachineryexpecdate=Helper.correctNull((String)hshValues.get("txt_expecteddate"));
		String strMachineryInvoice=Helper.correctNull((String)hshValues.get("txt_invoiceprice"));
		String strMachineryEstimprice=Helper.correctNull((String)hshValues.get("txt_estimatedexp"));
		String strMachineryTotalcost=Helper.correctNull((String)hshValues.get("txt_totalcost"));
		String strMachineryElectric=Helper.correctNull((String)hshValues.get("txt_electricreq"));
		
		strhidAction=Helper.correctNull((String)hshValues.get("hidAction"));
		strSno=Helper.correctNull((String)hshValues.get("hid_strsno"));
		StringBuilder sbolddata=new StringBuilder();
		
		try
		{
			strappno=Helper.correctNull((String)hshValues.get("appno"));
			if(strhidAction.equalsIgnoreCase("update") || strhidAction.equalsIgnoreCase("delete"))
			{
				strQuery=SQLParser.getSqlQuery("selssiannexure2machinerydetailsbysno^"+strSno+"^"+strappno);
				rs=DBUtils.executeQuery(strQuery);	
				if(rs.next())
				{
					sbolddata.append("Equipment List = ").append(ApplicantParams.getApplicantParams("VirtualityVehicle",correctNull(rs.getString("ssi_machinerylist")))).append("~Equipment Type = ")
					.append(ApplicantParams.getApplicantParams("EquipmentType",correctNull(rs.getString("ssi_machinerytype"))))
					.append("~Name of equipment and specification = ").append(correctNull(rs.getString("ssi_machineryname")))
					.append("~Equipment Category = ").append(ApplicantParams.getApplicantParams("EquipmentCategory",correctNull(rs.getString("ssi_machinerycategory"))))
					.append("~Name of Manufacturer / Fabricator (Place & country of origin,if imported)= ")
					.append(correctNull(rs.getString("ssi_machinerymanufacturername")))
					.append("~Date of aquisation/ Date of placement of order (actual/expected)  = ")
					.append(correctNull(rs.getString("ssi_machineryacquisitiondate")))
					.append("~Expected Date of delivery  =").append(correctNull(rs.getString("ssi_machineryexpecteddate")))
					.append("~Invoice price incl. Taxes for indigenous equipment/CIF for imported equipment = ")
					.append(ApplicationParams.getCurrency() + " "+nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("ssi_machineryinvoiceprice")))))
					.append("~Estimated expenses o/a of insurance, freight,installation, import duty = ")
					.append(ApplicationParams.getCurrency() + " "+nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("ssi_machineryestimatedexp"))))).append("~Total Cost  = ")
					.append(ApplicationParams.getCurrency() + " "+nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("ssi_machinerytotalcost")))))
					.append("~Electric power requirement (Watt)= ").append(correctNull(rs.getString("ssi_machineryelectricreq")));
				}
			}
			if(strhidAction.equalsIgnoreCase("insert")){
				
				strQuery="sel_maxmachinery^"+strappno;
				rs=DBUtils.executeLAPSQuery(strQuery);
				if(rs.next())
				{
					strSno=Helper.correctNull((String)rs.getString("machinery_no"));
				}
				if(rs!=null)rs.close();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","insssiannexure2machinerydetails");
				arrValues.add(strappno);
				arrValues.add(strSno);
				arrValues.add(strMachinerylist);
				arrValues.add(strMachinerytype);
				arrValues.add(strMachineryname);
				arrValues.add(strMachinerycategory);
				arrValues.add(strMachineryManufname);
				arrValues.add(strMachineryAcqdate);
				arrValues.add(strMachineryexpecdate);
				arrValues.add(strMachineryInvoice);
				arrValues.add(strMachineryEstimprice);
				arrValues.add(strMachineryTotalcost);
				arrValues.add(strMachineryElectric);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("DataAccess",hshQueryValues,"updateData");
			}
			else if(strhidAction.equalsIgnoreCase("update")){
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","updssiannexure2machinerydetails");
				arrValues.add(strMachinerylist);
				arrValues.add(strMachinerytype);
				arrValues.add(strMachineryname);
				arrValues.add(strMachinerycategory);
				arrValues.add(strMachineryManufname);
				arrValues.add(strMachineryAcqdate);
				arrValues.add(strMachineryexpecdate);
				arrValues.add(strMachineryInvoice);
				arrValues.add(strMachineryEstimprice);
				arrValues.add(strMachineryTotalcost);
				arrValues.add(strMachineryElectric);
				arrValues.add(strappno);
				arrValues.add(strSno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("DataAccess",hshQueryValues,"updateData");
			}
			if(strhidAction.equalsIgnoreCase("delete")){
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","delssiannexure2machinerydetails");
				arrValues.add(strappno);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("DataAccess",hshQueryValues,"updateData");
			}
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(!strhidAction.equalsIgnoreCase("delete")){
			sbAuditTrial.append("Equipment List = ").append(ApplicantParams.getApplicantParams("VirtualityVehicle",correctNull((String )hshValues.get("sel_machinerylist")))).append("~Equipment Type = ").append(ApplicantParams.getApplicantParams("EquipmentType",correctNull((String )hshValues.get("sel_machinerytype"))))
			.append("~Name of equipment and specification = ").append(correctNull((String )hshValues.get("txt_machineryname"))).append("~Equipment Category = ").append(ApplicantParams.getApplicantParams("EquipmentCategory",correctNull((String )hshValues.get("sel_machinerycat"))))
			.append("~Name of Manufacturer / Fabricator (Place & country of origin,if imported)= ").append(correctNull((String )hshValues.get("txt_manufacturername"))).append("~Date of aquisation/ Date of placement of order (actual/expected)  = ").append(correctNull((String )hshValues.get("txt_aquisationdate")))
			.append("~Expected Date of delivery  =").append(correctNull((String )hshValues.get("txt_expecteddate"))).append("~Invoice price incl. Taxes for indigenous equipment/CIF for imported equipment = ").append(ApplicationParams.getCurrency() + " "+correctNull((String )hshValues.get("txt_invoiceprice")))
			.append("~Estimated expenses o/a of insurance, freight,installation, import duty = ").append(ApplicationParams.getCurrency() + " "+correctNull((String )hshValues.get("txt_estimatedexp"))).append("~Total Cost  = ").append(ApplicationParams.getCurrency() + " "+correctNull((String )hshValues.get("txt_totalcost")))
			.append("~Electric power requirement (Watt)= ").append(correctNull((String )hshValues.get("txt_electricreq")));
			}
			
			AuditTrial.auditNewLog(hshValues,"181",strappno,sbAuditTrial.toString(),sbolddata.toString());
		}
		catch(Exception ae)
		{
			log.error("Exception in updateAnnexure2MachineryData:: "+ae);
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
		
		
		
	}
//	public HashMap updateApplicantBackgroundData (HashMap hshValues) 
//	{			
//		HashMap hshQueryValues = new HashMap();
//		HashMap hshQuery = null;
//		ArrayList arrValues=new ArrayList();
//
//		//int noofrows=0;
//		int maxappid =0;
//
//		String strTemp = "";
//		String strAction = "";
//		String strTemp1 ="";
//		String strTemp2 ="";
//		String prinid ="";
//		String strApplnt="";
//		String strId ="0";
//
//		//int i =0;
//		try
//		{
//			
//			//noofrows = Integer.parseInt(correctNull((String )hshValues.get("hidTotalDesc")))+1;
//		 	hshQueryValues = new HashMap();
//			hshQuery = new HashMap();	
//			maxappid = getApplicantBackgroundId(correctNull((String )hshValues.get("appno")));
//			strAction = correctNull((String )hshValues.get("hidAction"));
//			strId = correctNull((String )hshValues.get("hidId"));
//			strTemp = correctNull((String )hshValues.get("hidFieldPrefix"));
//			strTemp1 = correctNull((String )hshValues.get("txt_applicant1"));
//			strTemp2 = correctNull((String )hshValues.get("txt_applicant2"));
//			prinid= correctNull((String)hshValues.get("prinname"));
//			strApplnt = correctNull((String)hshValues.get("frompage"));
//			String appno = correctNull((String)hshValues.get("appno"));
//						
//			if((!strTemp1.equals("")) || (!strTemp2.equals("")))
//			{
//			if(strAction.equals("insert"))
//			{
//			
//				hshQuery = new HashMap();
//				arrValues=new ArrayList();
//				hshQuery.put("strQueryId","insssiupto10applicant");
//				arrValues.add(correctNull((String )hshValues.get("appno")));
//				arrValues.add(Integer.toString(maxappid));
//				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(1);
//				arrValues.add(correctNull((String )hshValues.get(strTemp)));
//				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(2);
//				arrValues.add(correctNull((String) hshValues.get(strTemp)));
//				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(3);
//				arrValues.add(correctNull((String )hshValues.get(strTemp)));
//				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(4);
//				arrValues.add(correctNull((String) hshValues.get(strTemp)));
//				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(5);
//				arrValues.add(correctNull((String )hshValues.get(strTemp)));
//				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(6);
//				arrValues.add(correctNull((String) hshValues.get(strTemp)));
//				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(7);
//				arrValues.add(correctNull((String )hshValues.get(strTemp)));
//				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(8);
//				arrValues.add(correctNull((String) hshValues.get(strTemp)));
//				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(9);
//				arrValues.add(correctNull((String )hshValues.get(strTemp)));
//				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(10);
//				arrValues.add(correctNull((String) hshValues.get(strTemp)));
//				strTemp = correctNull((String )hshValues.get("Type"));
//				arrValues.add(strTemp);
//				strTemp = correctNull((String )hshValues.get("txt_shareper"));
//				arrValues.add(strTemp);
//				strTemp = correctNull((String )hshValues.get("txt_facevalue"));
//				arrValues.add(strTemp);
//				strTemp = correctNull((String )hshValues.get("txt_sharesheld"));
//				arrValues.add(strTemp);
//				strTemp = correctNull((String )hshValues.get("txt_capcontribution"));
//				arrValues.add(strTemp);
//				strTemp = correctNull((String )hshValues.get("ssi_upto10resaddress"));
//				arrValues.add(strTemp);
//				strTemp = correctNull((String )hshValues.get("ssi_upto10restelno"));
//				arrValues.add(strTemp);
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("1",hshQuery);
//				hshQueryValues.put("size","1");				
//				hshValues.put("hidId",Integer.toString(maxappid));
//
//			}			
//			else if(strAction.equals("update"))
//			{				
//				hshQuery = new HashMap();
//				arrValues=new ArrayList();
//				hshQuery.put("strQueryId","updtssiupto10applicant");
//
//				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(1);
//				arrValues.add(correctNull((String )hshValues.get(strTemp)));
//				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(2);
//				arrValues.add(correctNull((String) hshValues.get(strTemp)));
//				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(3);
//				arrValues.add(correctNull((String )hshValues.get(strTemp)));
//				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(4);
//				arrValues.add(correctNull((String) hshValues.get(strTemp)));
//				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(5);
//				arrValues.add(correctNull((String )hshValues.get(strTemp)));
//				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(6);
//				arrValues.add(correctNull((String) hshValues.get(strTemp)));
//				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(7);
//				arrValues.add(correctNull((String )hshValues.get(strTemp)));
//				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(8);
//				arrValues.add(correctNull((String) hshValues.get(strTemp)));
//				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(9);
//				arrValues.add(correctNull((String )hshValues.get(strTemp)));
//				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(10);
//				arrValues.add(correctNull((String) hshValues.get(strTemp)));
//				strTemp = correctNull((String )hshValues.get("Type"));
//				arrValues.add(strTemp);
//				strTemp = correctNull((String )hshValues.get("txt_shareper"));
//				arrValues.add(strTemp);
//				strTemp = correctNull((String )hshValues.get("txt_facevalue"));
//				arrValues.add(strTemp);
//				strTemp = correctNull((String )hshValues.get("txt_sharesheld"));
//				arrValues.add(strTemp);
//				strTemp = correctNull((String )hshValues.get("txt_capcontribution"));
//				arrValues.add(strTemp);
//				strTemp = correctNull((String )hshValues.get("ssi_upto10resaddress"));
//				arrValues.add(strTemp);
//				strTemp = correctNull((String )hshValues.get("ssi_upto10restelno"));
//				arrValues.add(strTemp);
//				arrValues.add(correctNull((String )hshValues.get("appno")));
//				arrValues.add(strId);		
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("1",hshQuery);
//				hshQueryValues.put("size","1");
//				hshValues.put("hidId",strId);				
//			}	
//			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//		   }
//		   else
//			{
//			   hshValues.put("hidId"," ");
//			}
//		 if(strAction.equals("delete"))
//			{				
//				hshQuery.put("strQueryId","delssiupto10applicant");
//				arrValues.add(correctNull((String )hshValues.get("appno")));
//				arrValues.add(strId);				
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("1",hshQuery);
//				
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				hshQuery.put("strQueryId","ssidelfinancialbnk1");
//				arrValues.add(appno);		  
//				arrValues.add(prinid);
//				arrValues.add(strApplnt.toUpperCase());		 
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("2",hshQuery);
//				
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				hshQuery.put("strQueryId","ssidelfinancialinv1");
//				arrValues.add(appno);		  
//				arrValues.add(prinid);
//				arrValues.add(strApplnt.toUpperCase());		 
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("3",hshQuery);
//				
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				hshQuery.put("strQueryId","ssidelfinancialpol1");
//				arrValues.add(appno);		  
//				arrValues.add(prinid);
//				arrValues.add(strApplnt.toUpperCase());		 
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("4",hshQuery);
//				
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				hshQuery.put("strQueryId","ssidelfinancialprop1");
//				arrValues.add(appno);		  
//				arrValues.add(prinid);
//				arrValues.add(strApplnt.toUpperCase());		 
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("5",hshQuery);
//				
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				hshQuery.put("strQueryId","ssidelfinancialliab1");
//				arrValues.add(appno);		  
//				arrValues.add(prinid);
//				arrValues.add(strApplnt.toUpperCase());		 
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("6",hshQuery);
//				
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				hshQuery.put("strQueryId","delcreditreport");
//				arrValues.add(appno);		  
//				arrValues.add(prinid);
//				//arrValues.add(strApplnt.toUpperCase());		 
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("7",hshQuery);
//				
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				hshQuery.put("strQueryId","delcreditreport2");
//				arrValues.add(appno);		  
//				arrValues.add(prinid);
//				//arrValues.add(strApplnt.toUpperCase());		 
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("8",hshQuery);
//				
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				hshQuery.put("strQueryId","delcreditreport3");
//				arrValues.add(appno);		  
//				arrValues.add(prinid);
//				//arrValues.add(strApplnt.toUpperCase());		 
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("9",hshQuery);
//				
//				hshQueryValues.put("size","9");						
//				//hshValues.put("hidId"," ");				
//				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//			}
//			hshQuery =(HashMap)getData(hshValues);
//		}
//		catch(Exception ce)
//		{
//			throw new EJBException(ce.toString());
//		}
//		return hshQuery;
//	}

//	private int getApplicantBackgroundId(String strAppno )
//	{
//		String strQuery="";
//		ResultSet rs = null;
//		int genId = 0;
//		try
//		{	
//			strQuery = SQLParser.getSqlQuery("maxssiupto10applicant^"+strAppno);			
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				if(rs.getString(1) != null)
//				{
//					genId = Integer.parseInt(rs.getString(1));
//				}
//				else
//				{
//					genId = 1;
//				}
//			}			
//		}
//		catch(Exception ce)
//		{			
//			throw new EJBException("Error in getApplicantBackgroundId "+ce.toString());
//		}
//		finally
//		{
//			try
//			{
//				if(rs != null)
//				{
//					rs.close();
//				}
//				
//			}
//			catch(Exception cf)
//			{
//				throw new EJBException("Error closing the connection "+cf.getMessage());
//						
//			}
//		}
//		return genId;
//	}

//	public HashMap updateGuarantorData (HashMap hshValues) 
//	{			
//		HashMap hshQueryValues = new HashMap();
//		HashMap hshQuery = null;
//		ArrayList arrValues=new ArrayList();
//		//int noofrows=0;
//		int maxappid =0;
//		String strTemp = "";
//		String strAction = "";
//		String strTemp1 ="";
//		//String strTemp2 ="";  
//		String strId ="0";
//
//		//int i =0;
//		try
//		{			
//			//noofrows = Integer.parseInt(correctNull((String )hshValues.get("hidTotalDesc")))+1;
//		 	hshQueryValues = new HashMap();
//			hshQuery = new HashMap();	
//							
//			maxappid = getGuarantorId(correctNull((String )hshValues.get("appno")));
//			strAction = correctNull((String )hshValues.get("hidAction"));
//			strId = correctNull((String )hshValues.get("hidId"));			
//
//			strTemp = correctNull((String )hshValues.get("hidFieldPrefix"));
//			strTemp1 = correctNull((String )hshValues.get("txt_occupationguarantor1"));	
//			String appno = correctNull((String)hshValues.get("appno"));
//			String prinid = correctNull((String)hshValues.get("prinname"));
//			String strApplnt = correctNull((String)hshValues.get("frompage"));
//						
//			if(!strTemp1.equals(""))
//			{
//			if(strAction.equals("insert"))
//			{				
//				hshQuery = new HashMap();
//				arrValues=new ArrayList();
//				hshQuery.put("strQueryId","insssiguarantor");
//				arrValues.add(correctNull((String )hshValues.get("appno")));
//				arrValues.add(Integer.toString(maxappid));
//				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(1);
//				arrValues.add(correctNull((String )hshValues.get(strTemp)));
//				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(2);
//				arrValues.add(correctNull((String) hshValues.get(strTemp)));
//				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(3);
//				arrValues.add(correctNull((String )hshValues.get(strTemp)));
////				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(4);
////				arrValues.add(correctNull((String) hshValues.get(strTemp)));
////				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(5);
////				arrValues.add(correctNull((String )hshValues.get(strTemp)));
////				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(6);
////				arrValues.add(correctNull((String )hshValues.get(strTemp)));
//				//added one text area field for similar guar on 06-09-2004 by priya ranjan
//				arrValues.add(correctNull((String )hshValues.get("txt_occupationguarantor4")));
//				arrValues.add(correctNull((String )hshValues.get("ssi_gurrestelno")));
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("1",hshQuery);
//				hshQueryValues.put("size","1");				
//				hshValues.put("hidId",Integer.toString(maxappid));
//
//			}			
//			else if(strAction.equals("update"))
//			{
//				hshQuery = new HashMap();
//				arrValues=new ArrayList();
//				hshQuery.put("strQueryId","updtssiguarantor");
//
//				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(1);
//				arrValues.add(correctNull((String )hshValues.get(strTemp)));
//				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(2);
//				arrValues.add(correctNull((String) hshValues.get(strTemp)));
//				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(3);
//				arrValues.add(correctNull((String )hshValues.get(strTemp)));
//				arrValues.add(correctNull((String )hshValues.get("txt_occupationguarantor4")));
//				arrValues.add(correctNull((String )hshValues.get("ssi_gurrestelno")));
////				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(4);
////				arrValues.add(correctNull((String) hshValues.get(strTemp)));
////				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(5);
////				arrValues.add(correctNull((String )hshValues.get(strTemp)));
////				strTemp = correctNull((String )hshValues.get("hidFieldPrefix")) +Integer.toString(6);
////				arrValues.add(correctNull((String )hshValues.get(strTemp)));
//				
//				arrValues.add(correctNull((String )hshValues.get("appno")));
//				arrValues.add(strId);		
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("1",hshQuery);
//				hshQueryValues.put("size","1");
//				hshValues.put("hidId",strId);
//			}	
//			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//		   }
//		   else
//			{
//			   hshValues.put("hidId"," ");
//			}
//		 if(strAction.equals("delete"))
//			{				
//				hshQuery.put("strQueryId","delssiguarantor");
//				arrValues.add(correctNull((String )hshValues.get("appno")));
//				arrValues.add(strId);				
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("1",hshQuery);
//				hshQueryValues.put("size","1");
//				hshValues.put("hidId",strId);
//				
//				
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				hshQuery.put("strQueryId","ssidelfinancialbnk1");
//				arrValues.add(appno);		  
//				arrValues.add(prinid);
//				arrValues.add(strApplnt.toUpperCase());		 
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("2",hshQuery);
//				
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				hshQuery.put("strQueryId","ssidelfinancialinv1");
//				arrValues.add(appno);		  
//				arrValues.add(prinid);
//				arrValues.add(strApplnt.toUpperCase());		 
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("3",hshQuery);
//				
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				hshQuery.put("strQueryId","ssidelfinancialpol1");
//				arrValues.add(appno);		  
//				arrValues.add(prinid);
//				arrValues.add(strApplnt.toUpperCase());		 
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("4",hshQuery);
//				
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				hshQuery.put("strQueryId","ssidelfinancialprop1");
//				arrValues.add(appno);		  
//				arrValues.add(prinid);
//				arrValues.add(strApplnt.toUpperCase());		 
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("5",hshQuery);
//				
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				hshQuery.put("strQueryId","ssidelfinancialliab1");
//				arrValues.add(appno);		  
//				arrValues.add(prinid);
//				arrValues.add(strApplnt.toUpperCase());		 
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("6",hshQuery);
//				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//			}
//			hshQuery =(HashMap)getData(hshValues);
//		}
//		catch(Exception ce)
//		{
//			throw new EJBException(ce.toString());
//		}
//		return hshQuery;
//	}

//	private int getGuarantorId(String strAppno )
//	{
//		
//		String strQuery="";
//		ResultSet rs = null;
//		int genId = 0;
//		try
//		{	
//			strQuery = SQLParser.getSqlQuery("maxssiguarantor^"+strAppno);			
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				if(rs.getString(1) != null)
//				{
//					genId = Integer.parseInt(rs.getString(1));
//				}
//				else
//				{
//					genId = 1;
//				}
//			}			
//		}
//		catch(Exception ce)
//		{			
//			throw new EJBException("Error in getData4 "+ce.toString());
//		}
//		finally
//		{
//			try
//			{
//				if(rs != null)
//				{
//					rs.close();
//				}
//				
//			}
//			catch(Exception cf)
//			{
//				throw new EJBException("Error closing the connection "+cf.getMessage());
//						
//			}
//		}
//		return genId;
//	}

//Remove Data return by vino for purpose of attached the delete button inside the
//corporate-->Existing Tabs    
	public void removeUtillitiesData(HashMap hshValues)
	 {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		//HashMap hshRecord = new HashMap();
		ArrayList arrValues = new ArrayList();		
		ResultSet rs=null;		
		//String strQuery = "";
		String appno = "";
		String hidTabName = "";
		String MyAction="";
	
  try
	 {	

		appno = correctNull((String)hshValues.get("appno"));
		hidTabName = Helper.correctNull((String)hshValues.get("hidTabName"));
		MyAction = correctNull((String)hshValues.get("hidAction"));

		 if(MyAction.equals("Delete"))
		  {							
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","delutilities");			
			arrValues.add(hidTabName);			
			arrValues.add(appno); 
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);				
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		 }
		
	 }
		catch(Exception ce)
		{			
			throw new EJBException("Error in removeData "+ce.toString());
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
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
	}

// added by priya ranjan for ssi_otherdetails on 06-09-2004
// link is in appendix tab. table used ssi_otherdetails. jsp page name is - ssi_otherdetails.jsp
//	public HashMap getotherdetailsData(HashMap hshValues);
//	public void updateotherdetailsData(HashMap hshValues);
public HashMap getotherdetailsData(HashMap hshValues) 
	{	
	
	String strQuery="";
	ResultSet rs = null;
	HashMap hshRecord = new HashMap();
	try
	{
			
			hshRecord = new HashMap();
			String appno	  = null;
			if(correctNull((String)hshValues.get("hidappno"))=="")
			{
				appno = correctNull((String) hshValues.get("appno"));
			}
			else
			{
				appno = correctNull((String) hshValues.get("hidappno"));
			}

			//String strAction= correctNull((String)hshValues.get("hidAction"));
			strQuery = SQLParser.getSqlQuery("selssiothdet^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{	
				
				hshRecord.put("appno",Helper.correctNull(rs.getString("appno")));
				hshRecord.put("desc1",Helper.correctNull(rs.getString("desc1")));
				hshRecord.put("desc2",Helper.correctNull(rs.getString("desc2")));
				hshRecord.put("desc3",Helper.correctNull(rs.getString("desc3")));
				hshRecord.put("desc4",Helper.correctNull(rs.getString("desc4")));
				hshRecord.put("desc5",Helper.correctNull(rs.getString("desc5")));
				hshRecord.put("desc6",Helper.correctNull(rs.getString("desc6")));
				hshRecord.put("desc7",Helper.correctNull(rs.getString("desc7")));
					

			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs!=null)
				{
					rs.close();
				}
				
			}
			catch(Exception cf)
			{
				throw new EJBException(
							"Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	} 

public void updateotherdetailsData(HashMap hshValues) 
{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		//HashMap hshRecord = new HashMap();
		ArrayList arrValues = new ArrayList();
		
		ResultSet rs = null;
		String strQuery="";
		String appno = null;
		String strAction = null;
		String desc1="";
		String desc2="";
		String desc3="";
		String desc4="";
		String desc5="";
		String desc6="";
		String desc7="";

		try
		{
			
			desc1 = Helper.correctNull((String)hshValues.get("Description1"));
			desc2 = Helper.correctNull((String)hshValues.get("Description2"));
			desc3 = Helper.correctNull((String)hshValues.get("Description3"));
			desc4 = Helper.correctNull((String)hshValues.get("Description4"));
			desc5 = Helper.correctNull((String)hshValues.get("Description5"));
			desc6 = Helper.correctNull((String)hshValues.get("Description6"));
			desc7 = Helper.correctNull((String)hshValues.get("Description7"));

			if(correctNull((String)hshValues.get("hidappno"))=="")
			{
				appno = correctNull((String) hshValues.get("appno"));
			}
			else
			{
				appno = correctNull((String) hshValues.get("hidappno"));
			}
			int cnt=0;
			strAction   = Helper.correctNull((String)hshValues.get("hidAction"));
			strQuery = SQLParser.getSqlQuery("selssiothdet^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{	
				cnt++;
			}
			if(cnt==0)
			{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(appno);
					arrValues.add(desc1);
					arrValues.add(desc2);
					arrValues.add(desc3);
					arrValues.add(desc4);
					arrValues.add(desc5);
					arrValues.add(desc6);
					arrValues.add(desc7);

					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","insssiothdet");
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else  
			{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(desc1);
					arrValues.add(desc2);
					arrValues.add(desc3);
					arrValues.add(desc4);
					arrValues.add(desc5);
					arrValues.add(desc6);
					arrValues.add(desc7);
					arrValues.add(appno);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","updssiothdet");
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if (strAction.equalsIgnoreCase("Delete"))
			{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(appno);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","delssiothdet");
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
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

	}

// end of priya ranjan's code

//Added by Gokulakrishnan.C
public HashMap getAllVehicleDetails(HashMap hshValues) 
{
	HashMap hshResult = new HashMap();
	ResultSet rs = null;
	String strAppno="";
	String strQuery = "";
	ArrayList vecRecord = new ArrayList();
	ArrayList vecCol = new ArrayList();
	boolean recordflag=false;
	try
	{
		if(correctNull((String)hshValues.get("hidappno")).trim().equalsIgnoreCase(""))
			strAppno = correctNull((String)hshValues.get("appno"));
		else
			strAppno = correctNull((String)hshValues.get("hidappno"));

		strQuery = SQLParser.getSqlQuery("sel_ops_all_vehdetails^"+strAppno);
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			vecCol = new ArrayList();
			vecCol.add(Helper.correctNull((String)rs.getString("veh_appno")));
			vecCol.add(Helper.correctNull((String)rs.getString("veh_id")));
			vecCol.add(Helper.correctNull((String)rs.getString("veh_type")));
			vecCol.add(Helper.correctNull((String)rs.getString("veh_virtual")));
			vecCol.add(Helper.correctNull((String)rs.getString("veh_year_manu")));
			vecCol.add(Helper.correctNull((String)rs.getString("veh_cost")));
			vecCol.add(Helper.correctNull((String)rs.getString("veh_estimate")));
			vecCol.add(Helper.correctNull((String)rs.getString("veh_fuel")));
			vecCol.add(Helper.correctNull((String)rs.getString("veh_make")));
			vecCol.add(Helper.correctNull((String)rs.getString("veh_mnth_inc")));
			vecCol.add(Helper.correctNull((String)rs.getString("veh_details")));
			vecCol.add(Helper.correctNull((String)rs.getString("veh_register")));
			vecCol.add(Helper.correctNull((String)rs.getString("veh_persons")));
			vecCol.add(Helper.correctNull((String)rs.getString("veh_load")));
			vecCol.add(Helper.correctNull((String)rs.getString("veh_driven")));
			vecCol.add(Helper.correctNull((String)rs.getString("veh_permit")));
			vecCol.add(Helper.correctNull((String)rs.getString("veh_route_operation")));
			vecCol.add(Helper.correctNull((String)rs.getString("veh_dealer_info")));
			vecRecord.add(vecCol);
			recordflag=true;
		}
		hshResult.put("vecRecord",vecRecord);
		if(recordflag)
			hshResult.put("recordflag","Y");
		else
			hshResult.put("recordflag","N");
	}catch(Exception e)
	{
		throw new EJBException("Error in getAllVehicleDetails of SSIAboveTenBean"+e.getMessage());
	}finally{
		try{
		if(rs!=null)
			rs.close();
		}catch(Exception e)
		{
			throw new EJBException("Exception in closing connection in getAllVehicleDetails of SSIAboveTenBean"+e.getMessage());
		}
	}
	return hshResult;
}

public void updateVehicleDetails(HashMap hshValues) 
{
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = new HashMap();
	ArrayList arrValues = new ArrayList();
	ResultSet rs = null;
	String strAppno="";
	String strVehId = "";
	String strQueryId = "";
	String strAction = "";
	String strMaxId = "";
	StringBuilder sbolddata=new StringBuilder();
	try
	{
		if(correctNull((String)hshValues.get("hidappno")).trim().equalsIgnoreCase(""))
			strAppno = correctNull((String)hshValues.get("appno"));
		else
			strAppno = correctNull((String)hshValues.get("hidappno"));

		strVehId = Helper.correctNull((String)hshValues.get("hidVehicleId"));
		strAction = Helper.correctNull((String)hshValues.get("hidAction"));
		if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
		{
			String strQuery=SQLParser.getSqlQuery("sel_ops_all_vehdetailsbyid^"+strVehId+"^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);	
			if(rs.next())
			{
				sbolddata.append("Type of Vehicle = ").append(ApplicantParams.getApplicantParams("Category_vehicle",correctNull(rs.getString("veh_type"))))
				.append("~Virtuality of Vehicle = ").append(ApplicantParams.getApplicantParams("VirtualityVehicle",correctNull(rs.getString("veh_virtual"))))
				.append("~Year of Manufacture = ").append(correctNull(rs.getString("veh_year_manu")))
				.append("~Cost Price = ").append(correctNull(rs.getString("veh_cost")))
				.append("~Present Estimated Value = ").append(correctNull(rs.getString("veh_estimate")))
				.append("~Fuel Used = ").append(correctNull(rs.getString("veh_fuel")))
				.append("~Make =").append(correctNull(rs.getString("veh_make")));
				if(correctNull(rs.getString("veh_virtual")).equals("1"))
				{	
					sbolddata.append("~Average Monthly Income Derived = ");
				}
				else
				{
					sbolddata.append("~Anticipated Income Monthly = ");
				}
				sbolddata.append(correctNull(rs.getString("veh_mnth_inc")))
				.append("~Persons = ").append(correctNull(rs.getString("veh_persons")))
				.append("~Load (in kgs) = ").append(correctNull(rs.getString("veh_load")))
				.append("~Whether the vehicle to be driven by the applicant = ")
				.append(SetupParams.getSetupParams("SAABranch",correctNull(rs.getString("veh_driven"))))
				.append("~Necessary permit/License obtained = ")
				.append(SetupParams.getSetupParams("SAABranch",correctNull(rs.getString("veh_permit"))));
			}
		}
		if(strAction.trim().equalsIgnoreCase("insert"))
		{
			strQueryId = SQLParser.getSqlQuery("max_ops_vehdetails^"+strAppno);
			rs = DBUtils.executeQuery(strQueryId);
			if(rs.next())
				strMaxId = Helper.correctNull((String)rs.getString("veh_id"));
			//now for the values
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","ins_ops_vehdetails");
			arrValues.add(strMaxId);
			arrValues.add(strAppno);
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_veh_type")));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_veh_virtual")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_manufact")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_cost")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_est_val")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_fuel")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_make")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_mnth_inc")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_details")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_register")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_persons")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_load")));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_driven")));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_permit")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_veh_operate")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_dealer_info")));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		else if(strAction.trim().equalsIgnoreCase("update"))
		{
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			hshQuery.put("strQueryId","upd_ops_vehdetails");
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_veh_type")));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_veh_virtual")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_manufact")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_cost")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_est_val")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_fuel")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_make")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_mnth_inc")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_details")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_register")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_persons")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_load")));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_driven")));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_permit")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_veh_operate")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_dealer_info")));
			arrValues.add(strAppno);
			arrValues.add(strVehId);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}else if(strAction.trim().equalsIgnoreCase("delete"))
		{
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			hshQuery.put("strQueryId","del_ops_vehdetails");
			arrValues.add(strAppno);
			arrValues.add(strVehId);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		
		StringBuilder sbAuditTrial=new StringBuilder();
		if(!strAction.trim().equalsIgnoreCase("delete")){
		sbAuditTrial.append("Type of Vehicle = ").append(ApplicantParams.getApplicantParams("Category_vehicle",correctNull((String )hshValues.get("sel_veh_type")))).append("~Virtuality of Vehicle = ").append(ApplicantParams.getApplicantParams("VirtualityVehicle",correctNull((String )hshValues.get("sel_veh_virtual"))))
		.append("~Year of Manufacture = ").append(correctNull((String )hshValues.get("txt_manufact"))).append("~Cost Price = ").append(correctNull((String )hshValues.get("txt_cost")))
		.append("~Present Estimated Value = ").append(correctNull((String )hshValues.get("txt_est_val"))).append("~Fuel Used = ").append(correctNull((String )hshValues.get("txt_fuel")))
		.append("~Make =").append(correctNull((String )hshValues.get("txt_make")));
		if(correctNull((String )hshValues.get("sel_veh_virtual")).equals("1"))
		{	
			sbAuditTrial.append("~Average Monthly Income Derived = ");
		}
		else
		{
			sbAuditTrial.append("~Anticipated Income Monthly = ");
		}
		sbAuditTrial.append(correctNull((String )hshValues.get("txt_mnth_inc")))
		.append("~Persons = ").append(correctNull((String )hshValues.get("txt_persons"))).append("~Load (in kgs) = ").append(correctNull((String )hshValues.get("txt_load")))
		.append("~Whether the vehicle to be driven by the applicant = ").append(SetupParams.getSetupParams("SAABranch",correctNull((String )hshValues.get("sel_driven")))).append("~Necessary permit/License obtained = ").append(SetupParams.getSetupParams("SAABranch",correctNull((String )hshValues.get("sel_permit"))));
		}
		AuditTrial.auditNewLog(hshValues,"182",strAppno,sbAuditTrial.toString(),sbolddata.toString());
	}catch(Exception e)
	{
		throw new EJBException("Error in updateVehicleDetails of SSIAboveTenBean"+e.getMessage());
	}finally{
		try{
		if(rs!=null)
			rs.close();
		}catch(Exception e)
		{
			throw new EJBException("Exception in closing connection in updateVehicleDetails of SSIAboveTenBean"+e.getMessage());
		}
	}
}

public HashMap getDataSubsidy(HashMap hshValue)
{
	HashMap hshRecord=new HashMap();
	ResultSet rs=null;
	boolean recordflag=false;
	String strappno="",strQuery="",strcomappid;
	strappno=Helper.correctNull((String)hshValue.get("appno"));
	strcomappid=Helper.correctNull((String)hshValue.get("hidBorrowerType"));
	if(strcomappid.equalsIgnoreCase(""))
	{
		strcomappid=Helper.correctNull((String)hshValue.get("hidapplicantid"));
	}
	if(strcomappid.equalsIgnoreCase(""))
	{
		strcomappid=Helper.correctNull((String)hshValue.get("comapp_id"));
	}
	if(strcomappid.equalsIgnoreCase(""))
	{
		strcomappid=Helper.correctNull((String)hshValue.get("comappid"));
	}
	try
	{
		strQuery=SQLParser.getSqlQuery("sel_opssubsidy^" +strappno);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshRecord.put("OPS_APPNO",correctNull((String)rs.getString("OPS_APPNO")));
			hshRecord.put("OPS_GOVTSPONSOR",correctNull((String)rs.getString("OPS_GOVTSPONSOR")));
			hshRecord.put("OPS_SCHEMETYPE",correctNull((String)rs.getString("OPS_SCHEMETYPE")));
			hshRecord.put("OPS_SUBSIDYAMT",correctNull((String)rs.getString("OPS_SUBSIDYAMT")));
			hshRecord.put("OPS_SPONSORAGENCY",correctNull((String)rs.getString("OPS_SPONSORAGENCY")));
			hshRecord.put("OPS_SUBSIDYTYPE",correctNull((String)rs.getString("OPS_SUBSIDYTYPE")));
			hshRecord.put("ops_familyincome",correctNull((String)rs.getString("ops_income")));
			hshRecord.put("ops_srcincome",correctNull((String)rs.getString("ops_incomesrc")));
			hshRecord.put("ops_residencein",correctNull((String)rs.getString("ops_residencein")));
			hshRecord.put("ops_mobility",correctNull((String)rs.getString("ops_mobility")));
			recordflag=true;
		}
		hshRecord.put("comappid",strcomappid);
		if(recordflag)
			hshRecord.put("recordflag","Y");
		else
			hshRecord.put("recordflag","N");
	}
	catch(Exception e)
	{
		throw new EJBException("Error in getDataSubsidy"+e.getMessage());
	}
	
	finally
	{
		try
		{
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in closing connection"+e.getStackTrace());
		}
	}
	return hshRecord;
}
public HashMap getAccountDetails(HashMap hshValue)
{
	HashMap hshRecord=new HashMap();
	ResultSet rs=null;
	
	String strappno="",strQuery="",strcomappid;
	strappno=Helper.correctNull((String)hshValue.get("appno"));
	strcomappid=Helper.correctNull((String)hshValue.get("hidBorrowerType"));
	if(strcomappid.equalsIgnoreCase(""))
	{
		strcomappid=Helper.correctNull((String)hshValue.get("hidapplicantid"));
	}
	if(strcomappid.equalsIgnoreCase(""))
	{
		strcomappid=Helper.correctNull((String)hshValue.get("comapp_id"));
	}
	if(strcomappid.equalsIgnoreCase(""))
	{
		strcomappid=Helper.correctNull((String)hshValue.get("comappid"));
	}
	String recordflag = "N";
	try
	{
		strQuery=SQLParser.getSqlQuery("sel_opsaccountdetails^" +strappno);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshRecord.put("ops_accountbusinessnature",Helper.correctNull((String)rs.getString("ops_accountbusinessnature")));
			hshRecord.put("ops_accountsectorcategory",Helper.correctNull((String)rs.getString("ops_accountsectorcategory")));
			hshRecord.put("ops_accountassetclassification",Helper.correctNull((String)rs.getString("ops_accountassetclassification")));
			recordflag = "Y";
		}
		hshRecord.put("comappid",strcomappid);
		hshRecord.put("recordflag",recordflag);
	}
	catch(Exception e)
	{
		throw new EJBException("Error in getAccountDetails"+e.getMessage());
	}
	
	finally
	{
		try
		{
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in closing connection"+e.getStackTrace());
		}
	}
	return hshRecord;
}


public void updataSubsidy(HashMap hshValues)
{
	
	HashMap hshQueryValues=null;
	ArrayList arrValues=null;
	HashMap hshQuery=null;
	String strAction="",strAppno="";
	
	strAppno=Helper.correctNull((String)hshValues.get("appno"));
	strAction=Helper.correctNull((String)hshValues.get("hidAction"));
	
	try
	{
		if(strAction.equalsIgnoreCase("update"))
		{
			arrValues=new ArrayList();
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			hshQueryValues.put("size","2");
			hshQuery.put("strQueryId","del_opssubsidy");
			arrValues.add(strAppno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			hshQuery.put("strQueryId","ins_opssubsidy");
			arrValues.add(strAppno);
			arrValues.add(correctNull((String)hshValues.get("selectgovt")));
			arrValues.add(correctNull((String)hshValues.get("schemetype")));
			arrValues.add(correctNull((String)hshValues.get("sub_amt")));
			arrValues.add(correctNull((String)hshValues.get("sel_sponser_agency")));
			arrValues.add(correctNull((String)hshValues.get("sel_subsidytype")));
			arrValues.add(correctNull((String)hshValues.get("txt_familyincome")));
			arrValues.add(correctNull((String)hshValues.get("txt_incomesrc")));
			arrValues.add(correctNull((String)hshValues.get("sel_residencein")));
			arrValues.add(correctNull((String)hshValues.get("txt_mobility")));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("2",hshQuery);
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updatedata");
		}
		if(strAction.equalsIgnoreCase("delete"))
		{
			arrValues=new ArrayList();
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","del_opssubsidy");
			arrValues.add(strAppno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updatedata");
		}
		
		StringBuilder sbAuditTrial=new StringBuilder();
		if(correctNull((String)hshValues.get("hidRecordflag")).equals("N"))
			hshValues.put("hidAction", "insert");
		if(!strAction.equalsIgnoreCase("delete")){
		sbAuditTrial.append("~Govt. Sponsor Scheme = ").append(SetupParams.getSetupParams("SAABranch",correctNull((String )hshValues.get("selectgovt"))));
		if(correctNull((String )hshValues.get("selectgovt")).equals("1"))
		{	
			if(correctNull((String )hshValues.get("schemetype1")).equals("<---select--->"))
			{
				sbAuditTrial.append("~Scheme Type = ").append("");
			}else{
			sbAuditTrial.append("~Scheme Type = ").append(correctNull((String )hshValues.get("schemetype1")));
			}
			sbAuditTrial.append("~Subsidy Amount = ").append(correctNull((String )hshValues.get("sub_amt")));
			if(correctNull((String )hshValues.get("sel_sponser_agency1")).equals("<---Select--->"))
			{
				sbAuditTrial.append("~Sponsor Agency = ").append("");
			}else{
			sbAuditTrial.append("~Sponsor Agency = ").append(correctNull((String )hshValues.get("sel_sponser_agency1")));
			}
			if(correctNull((String )hshValues.get("sel_subsidytype1")).equals("<---Select--->"))
			{
				sbAuditTrial.append("~Subsidy type = ").append("");
			}else{
			sbAuditTrial.append("~Subsidy type = ").append(correctNull((String )hshValues.get("sel_subsidytype1")));
			}
			if(correctNull((String )hshValues.get("sel_residencein1")).equals("<---Select--->"))
			{
				sbAuditTrial.append("~Residence In = ").append("");
			}else{
			sbAuditTrial.append("~Residence In = ").append(correctNull((String )hshValues.get("sel_residencein1")));
			}
			sbAuditTrial.append("~Mobility in Years = ").append(correctNull((String )hshValues.get("txt_mobility")));
			sbAuditTrial.append("~Present Income(Including Family Member) = ").append(correctNull((String )hshValues.get("txt_familyincome")));
		}	
		}
		AuditTrial.auditLog(hshValues,"168",strAppno,sbAuditTrial.toString());
		
		
	}
	catch(Exception e)
	{
		throw new EJBException("Error in updataSubsidy" +e.getMessage());
	}
	
}

public void updateAccountDetails(HashMap hshValues)
{
	
	HashMap hshQueryValues=null;
	ArrayList arrValues=null;
	HashMap hshQuery=null;
	String strAction="",strAppno="";
	
	strAppno=Helper.correctNull((String)hshValues.get("appno"));
	strAction=Helper.correctNull((String)hshValues.get("hidAction"));
	
	try
	{
		if(strAction.equalsIgnoreCase("update"))
		{
			arrValues=new ArrayList();
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			hshQueryValues.put("size","2");
			hshQuery.put("strQueryId","del_opsaccountdetails");
			arrValues.add(strAppno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			hshQuery.put("strQueryId","ins_opsaccountdetails");
			arrValues.add(strAppno);
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_businessnature")));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_category")));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_assetclassification")));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("2",hshQuery);
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updatedata");
		}
		if(strAction.equalsIgnoreCase("delete"))
		{
			arrValues=new ArrayList();
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","del_opsaccountdetails");
			arrValues.add(strAppno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updatedata");
		}
		
		StringBuilder sbAuditTrial=new StringBuilder();
		if(!strAction.equalsIgnoreCase("delete")){
		sbAuditTrial.append("Sectoral Category =").append(ApplicantParams.getApplicantParams("TertiaryCategory",correctNull((String )hshValues.get("sel_category")))).append("~Asset Classification =").append(correctNull((String )hshValues.get("sel_assetclassification1")));
		}
		if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("N"))
		{
			hshValues.put("hidAction","Insert");
		}
		AuditTrial.auditLog(hshValues,"169",strAppno,sbAuditTrial.toString());
		
		
		
	}
	catch(Exception e)
	{
		throw new EJBException("Error in updateAccountDetails" +e.getMessage());
	}
	
}

}//End of Class