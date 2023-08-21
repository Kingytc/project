package com.sai.laps.ejb.govtsponschklist;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "GovtSponsChkListBean", mappedName = "GovtSponsChkListHome")
@Remote (GovtSponsChkListRemote.class)
public class GovtSponsChkListBean extends BeanAdapter
{
	private static final long serialVersionUID = 1L;
		
	public void updategovtsponsData(HashMap hshValues)
	{		 
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();	 
		ArrayList arrValues = new ArrayList();
	
		ResultSet rs = null;
		ResultSet rs1=null;
		String strAction = null;		 
		String strslno = "";
		String strSchID = "";
		String strQuestion = "";
		String strQuery="";
		String strKeyId = "";
		StringBuilder sbolddata=new StringBuilder();    
		try
		{
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			strAction = Helper.correctNull((String)hshValues.get("hidAction"));
			strslno	= correctNull((String )hshValues.get("hidsno"));
			strSchID = Helper.correctNull((String)hshValues.get("sel_govtScheme"));
			strQuestion = (Helper.correctNull((String)hshValues.get("txt_question"))).toUpperCase();
			String strInfoID = Helper.correctNull((String)hshValues.get("hidsno"));
			
			if(strAction.equalsIgnoreCase("Edit"))
			{
				rs = DBUtils.executeLAPSQuery("sel_govtspinsinfo_audit^"+strSchID+"^"+strInfoID);
				while(rs.next())
				{
					sbolddata.append("~Sponsor Scheme = ").append(Helper.correctNull((String)hshValues.get("hid_sel_govtScheme")));
					sbolddata.append("~Question = ").append(Helper.correctNull((String)rs.getString("info_question")));
				}
				if(rs!=null)
				rs.close();
			}
				
			if (strAction.equalsIgnoreCase("New"))
			{
				rs = DBUtils.executeLAPSQuery("max_sponserinfo^"+strSchID);
				if(rs.next())
				{	
					strslno = rs.getString("maxid");
				}		
				arrValues.add(strslno);
				arrValues.add(strSchID);
				arrValues.add(strQuestion);
				
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_sponsinfo");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}			
			else if(strAction.equalsIgnoreCase("Edit"))
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strQuestion);
				arrValues.add(strslno);
				arrValues.add(strSchID);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upd_sponsinfo");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			
//			FOR AUDIT TRIAL
			if (strAction.equalsIgnoreCase("New"))
			{
				strAction="insert";			
			}
			else if(strAction.equalsIgnoreCase("Edit"))
			{
				strAction="update";		
			}
			StringBuilder sbAuditTrial=new StringBuilder();
			sbAuditTrial.append("~Sponsor Scheme = ") .append(Helper.correctNull((String)hshValues.get("hid_sel_govtScheme")));
			sbAuditTrial.append("~Question = ") .append(Helper.correctNull((String)hshValues.get("txt_question")));
			if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
			hshValues.put("hidAction", "update");
			hshValues.put("strAction", strAction);
			AuditTrial.auditNewLog(hshValues,"349",strKeyId,sbAuditTrial.toString(),sbolddata.toString());
			
//			END OF AUDIT TRIAL
			
		}
		catch (Exception ce)
		{
			throw new EJBException("Error on found in Govt Sponser Bean "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
				if(rs1 != null)
				{
					rs1.close();
				}
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection in Govt Sponser Bean"+cf.getMessage());
			}
		}
	}
	
	public HashMap getgovtsponsData(HashMap hshValues)
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();
		try
		{
			String strSchID = Helper.correctNull((String)hshValues.get("sel_govtScheme"));
					
			if(!strSchID.equalsIgnoreCase(""))
			{
				rs = DBUtils.executeLAPSQuery("sel_govtsponsinfo^"+strSchID);
				while(rs.next())
				{
					vecCol = new ArrayList();
					vecCol.add(correctNull(rs.getString(1)));					
					vecCol.add(correctNull(rs.getString(2)));					
					vecCol.add(correctNull(rs.getString(3)));
					vecRow.add(vecCol);
				}
			}
			else
			{
				vecCol.add("");
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow",vecRow);
			hshRecord.put("strschcode",strSchID);
		}catch(Exception ce)
		{
			throw new EJBException("Error in getgeneralinfo "+ce.toString());
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

	public HashMap getgovtQuestParameters(HashMap hshValues)  
	{ 
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();	
		ArrayList vecData = new ArrayList();
		ArrayList vecRec1 = new ArrayList();
		ArrayList vecData2=new ArrayList();
		ArrayList vecRec2=new ArrayList();
		String strAction="";	
		String strappno="";
		int vecsize=0;
		int vecsize1=0;
		String strmodtype="";
		String strsponsor="";
		try 
		{ 
			strmodtype=Helper.correctNull((String)hshValues.get("hidCategoryType"));
			if(strmodtype.equalsIgnoreCase(""))
			{
				strmodtype=Helper.correctNull((String)hshValues.get("cattype"));
			}
			strAction ="select";
			String appno;
			String schcode="";
			appno=Helper.correctNull((String)hshValues.get("appno"));
			/*if(appno.equalsIgnoreCase("")){
				appno=Helper.correctNull((String)hshValues.get("appno1"));
			}*/
			if(appno.equalsIgnoreCase("") || appno.equalsIgnoreCase("null")){
				appno=Helper.correctNull((String)hshValues.get("strappno"));
			}
			if(strmodtype.equalsIgnoreCase("OPS"))
			{
				rs=DBUtils.executeLAPSQuery("sel_opssubsidy^"+appno);			 
				if(rs.next())
				{
					schcode=Helper.correctNull((String)rs.getString("ops_schemetype"));
					strsponsor=Helper.correctNull((String)rs.getString("ops_govtsponsor"));
				}
			}
			else
			{
				
				if(rs !=null)
				{
					rs.close();
				}
				String strProdPurpose="",strVehicleType="";
				rs=DBUtils.executeLAPSQuery("selprodpurpose^"+appno);			 
				if(rs.next()){strProdPurpose=Helper.correctNull((String)rs.getString("prd_purpose"));
				strVehicleType=Helper.correctNull((String)rs.getString("prd_vehitype"));}
				/*
				 * 			For Purchase of Ready Built House and Used Vehicle loan, 
				 * 				Margin is based on age of the building / vehicle respectively
				 */
				if(rs !=null)
				{
					rs.close();
				}
				if(strProdPurpose.equalsIgnoreCase("H") || strProdPurpose.equalsIgnoreCase("U")||strVehicleType.equalsIgnoreCase("2")) 
				{
					rs=DBUtils.executeLAPSQuery("pergetloanProductbymargin^"+appno);			 

				}
				else
				{
					rs=DBUtils.executeLAPSQuery("pergetloanProduct^"+appno);			 
				}
				if(rs.next())
				{
					schcode=Helper.correctNull((String)rs.getString("govt_scheme"));
				}
			}
			if(rs!=null)rs.close();
			rs=DBUtils.executeLAPSQuery("sel_appconfgovtparams^"+schcode);			 
			vecData=new ArrayList();
			vecRec2=new ArrayList();
			vecData2=new ArrayList();			
			while (rs.next()) 
			{				
				vecRec1=new ArrayList();
				vecRec1.add(correctNull(rs.getString("info_id")));
				vecRec1.add(correctNull(rs.getString("info_question")));
				vecData.add(vecRec1);				
			}	
			vecsize1=vecData.size();
			if(strAction.equals("select"))
			{			
				strappno = Helper.correctNull((String)hshValues.get("appno"));
				/*if((strappno.equalsIgnoreCase("null"))||(strappno.equals("")))
				{
					strappno = Helper.correctNull((String)hshValues.get("appno1"));
				}*/
				if((strappno.equalsIgnoreCase("null"))||(strappno.equals("")))
				{
					strappno = Helper.correctNull((String)hshValues.get("strappno"));
				}
				rs1=DBUtils.executeLAPSQuery("sel_appraisalgovtQuest^"+strappno);
				while (rs1.next()) 
				{
					vecRec2=new ArrayList();
				    vecRec2.add(correctNull(rs1.getString("info_response")));
					vecRec2.add(correctNull(rs1.getString("info_remarks")));
					vecData2.add(vecRec2);
				}
			}
			vecsize=vecData2.size();
			if(vecsize1!=vecsize)
			{
				int i=vecsize1-vecsize;
				for(int l=1; l<=i; l++)
				{
					vecRec2=new ArrayList();
					vecRec2.add("2");
					vecRec2.add("");
					vecData2.add(vecRec2);
				}
			}			
			vecsize=vecData2.size();
			String str=Integer.toString(vecsize);
			hshRecord.put("vecData2",vecData2);
			hshRecord.put("strappno",strappno);
			hshRecord.put("str",str);
			hshRecord.put("vecData",vecData);	 
			hshRecord.put("strsponsor",strsponsor);
		} 		
		catch (Exception e) 
		{
			throw new EJBException(e.getMessage());
		} 
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();					 
				}
				if (rs1!= null) 
				{
					rs1.close();
				}
			} 			
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}		
		return hshRecord;
	}

	public void updategovtQuestParameters(HashMap hshValues)  
	{
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		//HashMap hshquery2 = new HashMap();
		ArrayList arrValues ;		 
		ResultSet rs=null;
		String strAction="";			
		String strappno="";			
		try
		{ 
			String []strOption=null;
			String []strDet=null;
			int intUpdatesize = 0;	
			intUpdatesize=intUpdatesize+1;	
			strAction =correctNull((String)hshValues.get("hidAction"));
			if(hshValues.get("sel_option") instanceof java.lang.String){
				strOption= new String[1];
				strOption[0]=(String)hshValues.get("sel_option");
			}else{
			strOption=(String[])hshValues.get("sel_option");
			}
			if(hshValues.get("txt_comments") instanceof java.lang.String){
				strDet= new String[1];
				strDet[0] = (String)hshValues.get("txt_comments");	
			}else{
				strDet = (String[])hshValues.get("txt_comments");	
			}
			
			//strappno = Helper.correctNull((String)hshValues.get("appno1"));	
			if(strappno.equals("") || strappno.equals("null"))
			{
				strappno = Helper.correctNull((String)hshValues.get("strappno"));	
			}
			if(strappno.equals("") || strappno.equals("null"))
			{
				strappno = Helper.correctNull((String)hshValues.get("appno"));
			}
			int len=strOption.length;
			if(strAction.equals("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","del_govtQuest");		
				arrValues.add(strappno);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				for(int k=0;k<len;k++)
				{
					hshQuery.put("strQueryId","ins_govtQuest");
					arrValues=new ArrayList();				
					arrValues.add(strappno);
					arrValues.add(strOption[k]);
					arrValues.add(strDet[k]);							
					hshQuery.put("arrValues",arrValues);					
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					//hshquery2.put("appno",strappno);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}						
			}
			
			if(strAction.equals("Delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","del_govtQuest");		
				arrValues.add(strappno);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
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

	public void updategovtsponsparameters(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues= new ArrayList();
		String strKeyId = "";
		String strAction =Helper.correctNull((String)hshValues.get("hidAction"));
		String strQuery ="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		try
		{
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			StringBuilder strOldAudit = new StringBuilder();
			String strActionflag = "";
			if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("N"))
			{
				strActionflag = "Insert";
				hshValues.put("hidAction","Insert");
			}
			else if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
			{
				strActionflag = "Update";
				hshValues.put("hidAction","Update");
			}
			if(strActionflag.equalsIgnoreCase("Update") || strActionflag.equalsIgnoreCase("Insert"))
			{
				
				strQuery = SQLParser.getSqlQuery("sel_govtspon^"+Helper.correctNull((String)hshValues.get("sel_Govtsponsorschme")));
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()){
					strOldAudit.append("~Government Sponsor Scheme=");
					strQuery = SQLParser.getSqlQuery("sel_static_desc_audit^11^"+Helper.correctNull((String)rs.getString("sel_govtscheme")));
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next()){
						strOldAudit.append(Helper.correctNull((String)rs1.getString("stat_data_desc")));
					}
					else
						strOldAudit.append("");
					strOldAudit.append("~Minimum Age=");
					strOldAudit.append(Helper.correctNull((String)rs.getString("minage")));
					strOldAudit.append("~Maximum Age General (Yrs)=");
					strOldAudit.append(Helper.correctNull((String)rs.getString("maxage")));
					strOldAudit.append("~Maximum Age (SC/ST) (Yrs)=");
					strOldAudit.append(Helper.correctNull((String)rs.getString("maxagescst")));
					strOldAudit.append("~Maximum age (Ex-serviceman) (Yrs)=");
					strOldAudit.append(Helper.correctNull((String)rs.getString("maxageexser")));
					strOldAudit.append("~Maximum age (Phy.Challenged) (Yrs)=");
					strOldAudit.append(Helper.correctNull((String)rs.getString("maxagephy")));
					strOldAudit.append("~Maximum age (Women) (Yrs)=");
					strOldAudit.append(Helper.correctNull((String)rs.getString("maxagewomen")));
					strOldAudit.append("~North east general maximum age (Yrs)=");
					strOldAudit.append(Helper.correctNull((String)rs.getString("northeast")));
					
					String strEduQua = Helper.correctNull((String)rs.getString("minedu"));
					if(strEduQua.trim().equalsIgnoreCase("9"))
					{
						strEduQua="PUC / Plus 2";
					}
					else if(strEduQua.trim().equalsIgnoreCase("10"))
					{
						strEduQua="SSLC";
					}
					else if(strEduQua.trim().equalsIgnoreCase("11"))
					{
						strEduQua="VIII Pass";
					}
					else if(strEduQua.trim().equalsIgnoreCase("12"))
					{
						strEduQua="Illiterate";
					}
					strOldAudit.append("~Minimum educational qualification=");
					strOldAudit.append(strEduQua);
					strOldAudit.append("~Annual income of family (Rural) (Rs.)=");
					strOldAudit.append(Helper.correctNull((String)rs.getString("annualincomerural")));
					strOldAudit.append("~Annual income of family (Others) (Rs.)=");
					strOldAudit.append(Helper.correctNull((String)rs.getString("annualincomeothers")));
					strOldAudit.append("~Mobility=");
					strOldAudit.append(Helper.correctNull((String)rs.getString("mobility")));
					strOldAudit.append("~Business sector (Overall Limit) (Rs.)=");
					strOldAudit.append(Helper.correctNull((String)rs.getString("sector")));
					strOldAudit.append("~Term loan (Rs.)=");
					strOldAudit.append(Helper.correctNull((String)rs.getString("termloan")));
					strOldAudit.append("~Working Capital (Rs.)=");
					strOldAudit.append(Helper.correctNull((String)rs.getString("workingcapital")));
					strOldAudit.append("~Margin=");
					strOldAudit.append(Helper.correctNull((String)rs.getString("margin")));
					strOldAudit.append("~Subsidy %=");
					strOldAudit.append(Helper.correctNull((String)rs.getString("subsidy")));
					strOldAudit.append("~Maximum Subsidy Amount (Rs.)=");
					strOldAudit.append(Helper.correctNull((String)rs.getString("maxsubamt")));
					strOldAudit.append("~Min Repayment period (Months)=");
					strOldAudit.append(Helper.correctNull((String)rs.getString("minreayment")));
					strOldAudit.append("~Maximum repayment period (Months)=");
					strOldAudit.append(Helper.correctNull((String)rs.getString("maxrepay")));
					strOldAudit.append("~Minimum sustenance Required (%)=");
					strOldAudit.append(Helper.correctNull((String)rs.getString("sustenance")));
					strOldAudit.append("~Min No. of members=");
					strOldAudit.append(Helper.correctNull((String)rs.getString("shgminmem")));
					strOldAudit.append("~Max. no. of members=");
					strOldAudit.append(Helper.correctNull((String)rs.getString("shgmaxmem")));
					strOldAudit.append("~Max. limit of loan for single borrower (Rs.)=");
					strOldAudit.append(Helper.correctNull((String)rs.getString("shgmaxloan")));
				}
			}
			if(rs1!=null){rs1.close();}
			if(strAction.equalsIgnoreCase("update"))
			{
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();					
			hshQueryValues.put("size","2");
			hshQuery.put("strQueryId","del_govtspon");
			arrValues.add(correctNull((String)hshValues.get("sel_Govtsponsorschme")));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			hshQuery.put("strQueryId","ins_govtspon");
					
			arrValues.add(correctNull((String)hshValues.get("sel_Govtsponsorschme")));
			arrValues.add(correctNull((String)hshValues.get("txt_minage")));
			arrValues.add(correctNull((String)hshValues.get("txt_maxage")));
			arrValues.add(correctNull((String)hshValues.get("txt_maxagescst")));
			arrValues.add(correctNull((String)hshValues.get("txt_maxageex")));
			arrValues.add(correctNull((String)hshValues.get("txt_maxagephy")));
			arrValues.add(correctNull((String)hshValues.get("txt_maxagewomen")));
			arrValues.add(correctNull((String)hshValues.get("txt_northeast")));
			arrValues.add(correctNull((String)hshValues.get("txt_minedu")));
			arrValues.add(correctNull((String)hshValues.get("txt_annualincomerural")));
			arrValues.add(correctNull((String)hshValues.get("txt_annualincomeothers")));
			arrValues.add(correctNull((String)hshValues.get("txt_mobility")));
		//	arrValues.add(correctNull((String)hshValues.get("txt_defaulter")));
			//arrValues.add(correctNull((String)hshValues.get("txt_subsidy")));
			//arrValues.add(correctNull((String)hshValues.get("txt_linked")));
		//	arrValues.add(correctNull((String)hshValues.get("txt_fb")));
			arrValues.add(correctNull((String)hshValues.get("txt_tl")));
			arrValues.add(correctNull((String)hshValues.get("txt_wc")));
			arrValues.add(correctNull((String)hshValues.get("txt_businesssector")));
			arrValues.add(correctNull((String)hshValues.get("txt_otherbus")));
			arrValues.add(correctNull((String)hshValues.get("txt_margin")));
			arrValues.add(correctNull((String)hshValues.get("txt_loansubsidy")));
			arrValues.add(correctNull((String)hshValues.get("txt_maxsubsidy")));
			arrValues.add(correctNull((String)hshValues.get("txt_minrepay")));
			arrValues.add(correctNull((String)hshValues.get("txt_maxrepay")));
			arrValues.add(correctNull((String)hshValues.get("txt_sustenance")));
			//arrValues.add(correctNull((String)hshValues.get("txt_ind")));
			arrValues.add(correctNull((String)hshValues.get("txt_minno")));
			arrValues.add(correctNull((String)hshValues.get("txt_maxno")));
			arrValues.add(correctNull((String)hshValues.get("txt_maxloan")));
			
			arrValues.add(correctNull((String)hshValues.get("txt_othertl")));
			arrValues.add(correctNull((String)hshValues.get("txt_otherwc")));
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("2",hshQuery);	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","del_govtspon");
				arrValues.add(correctNull((String)hshValues.get("sel_legalposition")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			//------------------------------Audittrial----------------------------
			StringBuilder sbAuditTrial=new StringBuilder();
			String strEduQua=correctNull((String)hshValues.get("txt_minedu"));
			if(strEduQua.trim().equalsIgnoreCase("9"))
			{
				strEduQua="PUC / Plus 2";
			}
			else if(strEduQua.trim().equalsIgnoreCase("10"))
			{
				strEduQua="SSLC";
			}
			else if(strEduQua.trim().equalsIgnoreCase("11"))
			{
				strEduQua="VIII Pass";
			}
			else if(strEduQua.trim().equalsIgnoreCase("12"))
			{
				strEduQua="Illiterate";
			}
			String strMobility=correctNull((String)hshValues.get("txt_mobility"));
			if(strMobility.trim().equalsIgnoreCase("1"))
			{
				strMobility="More than 5 years";
			}
			else if(strMobility.trim().equalsIgnoreCase("2"))
			{
				strMobility="2 to 5 years";
			}
			else if(strMobility.trim().equalsIgnoreCase("3"))
			{
				strMobility="Less than 2 years";
			}
			if(strActionflag.equalsIgnoreCase("Update") || strAction.equalsIgnoreCase("Delete")||strActionflag.equalsIgnoreCase("Insert"))
			{
			sbAuditTrial.append(
			"~Government Sponsor Scheme=");
			strQuery = SQLParser.getSqlQuery("sel_static_desc_audit^11^"+correctNull((String)hshValues.get("sel_Govtsponsorschme")));
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next()){
				sbAuditTrial.append(Helper.correctNull((String)rs1.getString("stat_data_desc")));
			}
			else
				sbAuditTrial.append("");
			sbAuditTrial.append(
			"~Minimum Age=").append(correctNull((String)hshValues.get("txt_minage"))).append(
			"~Maximum Age General (Yrs)=").append(correctNull((String)hshValues.get("txt_maxage"))).append(
			"~Maximum Age (SC/ST) (Yrs)=").append(correctNull((String)hshValues.get("txt_maxagescst"))).append(
			"~Maximum age (Ex-serviceman) (Yrs)=").append(correctNull((String)hshValues.get("txt_maxageex"))).append(
			"~Maximum age (Phy.Challenged) (Yrs)=").append(correctNull((String)hshValues.get("txt_maxagephy"))).append(
			"~Maximum age (Women) (Yrs)=").append(correctNull((String)hshValues.get("txt_maxagewomen"))).append(
			"~North east general maximum age (Yrs)=").append(correctNull((String)hshValues.get("txt_northeast"))).append(
			"~Minimum educational qualification=").append(strEduQua).append(
			"~Annual income of family (Rural) (Rs.)=").append(correctNull((String)hshValues.get("txt_annualincomerural"))).append(
			"~Annual income of family (Others) (Rs.)=").append(correctNull((String)hshValues.get("txt_annualincomeothers"))).append(	
			"~Mobility=").append(strMobility).append(
			"~Business sector (Overall Limit) (Rs.)=").append(correctNull((String)hshValues.get("txt_businesssector"))).append(
			"~Term loan (Rs.)=").append(correctNull((String)hshValues.get("txt_tl"))).append(
			"~Working Capital (Rs.)=").append(correctNull((String)hshValues.get("txt_wc"))).append(
			"~Other than business (Overall Limit) (Rs.)=").append(correctNull((String)hshValues.get("txt_otherbus"))).append(
			"~Term loan (Rs.)=").append(correctNull((String)hshValues.get("txt_othertl"))).append(
			"~Working Capital (Rs.)=").append(correctNull((String)hshValues.get("txt_otherwc"))).append(
			"~Margin=").append(correctNull((String)hshValues.get("txt_margin"))).append(
			"~Subsidy %=").append(correctNull((String)hshValues.get("txt_loansubsidy"))).append(
			"~Maximum Subsidy Amount (Rs.)=").append(correctNull((String)hshValues.get("txt_maxsubsidy"))).append(
			"~Min Repayment period (Months)=").append(correctNull((String)hshValues.get("txt_minrepay"))).append(
			"~Maximum repayment period (Months)=").append(correctNull((String)hshValues.get("txt_maxrepay"))).append(
			"~Minimum sustenance Required (%)=").append(correctNull((String)hshValues.get("txt_sustenance"))).append(
			"~Min No. of members=").append(correctNull((String)hshValues.get("txt_minno"))).append(
			"~Max. no. of members=").append(correctNull((String)hshValues.get("txt_maxno"))).append(
			"~Max. limit of loan for single borrower (Rs.)=").append(correctNull((String)hshValues.get("txt_maxloan")));
			}
			if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
			{
				AuditTrial.auditNewLog(hshValues,"121",strKeyId,sbAuditTrial.toString(),strOldAudit.toString());
			}
			if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("N"))
			{
				AuditTrial.auditLog(hshValues,"121",strKeyId,sbAuditTrial.toString());
			}
			//---------------------------------End--------------------------------
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updateLegalPosition :: " + e.getMessage());
		} 
	}

	public HashMap getgovtsponsparameters(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		
		ResultSet rs=null;
		
		String strQuery="";
		String strGovtsponsorschme="";
		boolean recordflag=false;
		try
		{
			strGovtsponsorschme=correctNull((String)hshValues.get("sel_Govtsponsorschme"));
			strQuery = SQLParser.getSqlQuery("sel_govtspon^"+strGovtsponsorschme);
			rs = DBUtils.executeQuery(strQuery);	
			if (rs.next())
			{ 
				recordflag=true;			
				hshResult.put("govtsponsorschme",correctNull((rs.getString("sel_govtscheme"))));
				hshResult.put("minage",correctNull((rs.getString("minage"))));
				hshResult.put("maxage",correctNull((rs.getString("maxage"))));
				hshResult.put("maxagescst",correctNull((rs.getString("maxagescst"))));
				hshResult.put("maxageexser",correctNull((rs.getString("maxageexser"))));
				hshResult.put("maxagephy",correctNull((rs.getString("maxagephy"))));
				hshResult.put("maxagewomen",correctNull((rs.getString("maxagewomen"))));
				hshResult.put("northeast",correctNull((rs.getString("northeast"))));
				hshResult.put("minedu",correctNull((rs.getString("minedu"))));
				hshResult.put("annualincomerural",correctNull((rs.getString("annualincomerural"))));
				hshResult.put("annualincomeothers",correctNull((rs.getString("annualincomeothers"))));
				hshResult.put("mobility",correctNull((rs.getString("mobility"))));
				//hshResult.put("defaulter",correctNull((rs.getString("defaulter"))));
				//hshResult.put("loansubsidy",correctNull((rs.getString("loansubsidy"))));
				//hshResult.put("linkpgm",correctNull((rs.getString("linkpgm"))));
				//hshResult.put("fundbased",correctNull((rs.getString("fundbased"))));
				hshResult.put("termloan",correctNull((rs.getString("termloan"))));
				hshResult.put("workingcapital",correctNull((rs.getString("workingcapital"))));
				hshResult.put("sector",correctNull((rs.getString("sector"))));
				hshResult.put("otherbuss",correctNull((rs.getString("otherbuss"))));
				hshResult.put("margin",correctNull((rs.getString("margin"))));
				hshResult.put("subsidy",correctNull((rs.getString("subsidy"))));
				hshResult.put("maxsubamt",correctNull((rs.getString("maxsubamt"))));
				hshResult.put("minreayment",correctNull((rs.getString("minreayment"))));
				hshResult.put("maxrepay",correctNull((rs.getString("maxrepay"))));
				hshResult.put("sustenance",correctNull((rs.getString("sustenance"))));
				//hshResult.put("shgmembers",correctNull((rs.getString("shgmembers"))));
				hshResult.put("shgminmem",correctNull((rs.getString("shgminmem"))));
				hshResult.put("shgmaxmem",correctNull((rs.getString("shgmaxmem"))));
				hshResult.put("shgmaxloan",correctNull((rs.getString("shgmaxloan"))));
				
				hshResult.put("othertl",correctNull((rs.getString("othertl"))));
				hshResult.put("otherwc",correctNull((rs.getString("otherwc"))));
	
			}
			hshResult.put("govtsponsorschme",strGovtsponsorschme);
			if(recordflag)
				hshResult.put("recordflag","Y");
			else
				hshResult.put("recordflag","N");
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getLegalPosition ::  "+ce.toString());
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
		return hshResult;
			
	}

	public HashMap checkeligibityforgovtsponsor(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		
		ArrayList arrValues=new ArrayList();
		
		ResultSet rs=null;
		ResultSet rs1=null;
		
		String strAppno="";
		String strQuery="";
		String strSponsortype="";
		//double dblSponsoramt=0.0;
		double dblgenminage=0;
		double dblgenmaxage=0;
		double dblscstmaxage=0;
		double dblexservicemaxage=0;
		double dblphymaxage=0;
		double dblwomenmaxage=0;
		double dblnortheastmaxage=0;
		double dblmineducation=0;
		double dblannualincomerural=0;
		double dblannualincomeothers=0;
		int intminmobility=0;
		int intmobility=0;
		double dblbusinesssectoraggr=0.0;
		double dblbusitermloan=0.0;
		double dblbusiwc=0.0;
		double dblnonbusiaggr=0.0;
		double dblnonbusiterm=0.0;
		double dblnonbusiwc=0.0;
		double dblmargin=0;
		String strresidencein="";
		String strsubsidyperc="";
		double dblmaxsubsidyamt=0.0;
		String strminsustance="";
		String strminmemforshg="";
		String strmaxmemforshg="";
		String strmaxloanforshg="";
		String strMinRepayPeriod="";//declared for calculating repayment period.
		String strMaxRepayPeriod="";//declard for calucating max repayment period.
		String strApplicantType="";
		double proposed_amount=0.00d;
		double subsidyAnnualIncome=0.00d;
		double subsidyAmount=0.00d;
		double marginamount=0.00d;
		double marginpercent=0.0d;
		ResultSet shgrs=null;
		String strAppName="";
		//String strMobility="";
		try
		{
			strAppno=correctNull((String)hshValues.get("appno"));
			
			subsidyAnnualIncome=0.00d;
			strQuery=SQLParser.getSqlQuery("sel_opssubsidy^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strSponsortype=correctNull(rs.getString("ops_schemetype"));
				//dblSponsoramt=rs.getDouble("ops_subsidyamt");
				strresidencein=correctNull(rs.getString("ops_residencein"));
				intmobility=rs.getInt("ops_mobility");
				subsidyAnnualIncome=Double.parseDouble(Helper.correctDouble(rs.getString("ops_income")));
				subsidyAmount=Double.parseDouble(Helper.correctDouble(rs.getString("ops_subsidyamt")));
			}
			if(rs!=null)rs.close();
			rs=DBUtils.executeQuery(SQLParser.getSqlQuery("get_facility_proposed_shg^"+strAppno));
			while(rs.next())
			{
				proposed_amount=proposed_amount+rs.getDouble("proposed_amount");
				marginamount=marginamount+(rs.getDouble("proposed_amount")*rs.getDouble("marginperct"))/100;
			}
		   if(rs!=null)rs.close();
			
			if(!strSponsortype.equalsIgnoreCase(""))
			{
				
				if(rs!=null)
					rs.close();
				String Id = correctNull((String)hshValues.get("comapp_id"));
				if(Id.equalsIgnoreCase(""))
				{
					Id = correctNull((String)hshValues.get("comappid"));
				}
				if(Id.equalsIgnoreCase(""))
				{
					Id=correctNull((String)hshValues.get("hidapplicantid"));
				}
				strQuery=SQLParser.getSqlQuery("sel_perapptitle^"+correctNull(Id));
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strApplicantType=correctNull(rs.getString("perapp_title"));
					
					
				}
				
				if(rs!=null)
					rs.close();
				strQuery=SQLParser.getSqlQuery("sel_govtspon^"+strSponsortype);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					dblgenminage=rs.getDouble("minage");
					dblgenmaxage=rs.getDouble("maxage");
					dblscstmaxage=rs.getDouble("maxagescst");
					dblexservicemaxage=rs.getDouble("maxageexser");
					dblphymaxage=rs.getDouble("maxagephy");
					dblwomenmaxage=rs.getDouble("maxagewomen");
					dblnortheastmaxage=rs.getDouble("northeast");
					
					dblmineducation=rs.getDouble("minedu");
					dblannualincomerural=rs.getDouble("annualincomerural");
					dblannualincomeothers=rs.getDouble("annualincomeothers");
					intminmobility=rs.getInt("mobility");
					
					dblbusinesssectoraggr=rs.getDouble("sector");
					dblbusitermloan=rs.getDouble("termloan");
					dblbusiwc=rs.getDouble("workingcapital");
					
					dblnonbusiaggr=rs.getDouble("otherbuss");
					dblnonbusiterm=rs.getDouble("othertl");
					dblnonbusiwc=rs.getDouble("otherwc");
					
					dblmargin=rs.getDouble("margin");
					strsubsidyperc=correctNull((rs.getString("subsidy")));
					dblmaxsubsidyamt=rs.getDouble("maxsubamt");
					strminsustance=correctNull((rs.getString("sustenance")));
					strminmemforshg=correctNull((rs.getString("shgminmem")));
					strmaxmemforshg=correctNull((rs.getString("shgmaxmem")));
					strmaxloanforshg=correctNull((rs.getString("shgmaxloan")));
					strMinRepayPeriod=correctNull((rs.getString("minreayment")));
					strMaxRepayPeriod=correctNull((rs.getString("maxrepay")));
				}
				
				
//				FLAG INFO: 1==>ELGIBILITY 2==>NOT ELIGBILE 0==>VALUES NOT IN PROCESSING LEVEL 3===>NOT APPLICABLE 4==>NOT DEFINED IN SETUP.
			
				if(correctNull(strsubsidyperc).equals("") || dblmaxsubsidyamt==0)
				{
					if(correctNull(strsubsidyperc).equals(""))
						hshRecord.put("Subsidy","<font color='red'>  Subsidy % Not Defined in the Setup ! </font><br>");
					if(dblmaxsubsidyamt==0)
						hshRecord.put("Subsidy",correctNull((String)hshRecord.get("Subsidy"))+""+"<font color='red'>Maximum Subsidy Amount Not defined in setup !");
					marginpercent=(marginamount/proposed_amount)*100;
					if(dblmargin<=marginpercent)
					{
						hshRecord.put("Margin","Eligbile");
					}
					else
					{
						hshRecord.put("Margin","Not Eligbile");
					}
				}
				else
				{
					double proposed_result= (proposed_amount* Double.parseDouble(strsubsidyperc)) / 100;
					if(dblmaxsubsidyamt <= proposed_result)
					{
						if( subsidyAmount <= dblmaxsubsidyamt )
						{
							if(correctNull((String)hshRecord.get("Subsidy")).equals(""))
								hshRecord.put("Subsidy","Eligbile");
						}
						else
						{
							if(correctNull((String)hshRecord.get("Subsidy")).equals(""))
								hshRecord.put("Subsidy","Not Eligbile");
						}	
					}
					else if(dblmaxsubsidyamt > proposed_result)
					{				
						if(subsidyAmount<=proposed_result)
						{
							if(correctNull((String)hshRecord.get("Subsidy")).equals(""))
								hshRecord.put("Subsidy","Eligbile");
						}
						else
						{
							if(correctNull((String)hshRecord.get("Subsidy")).equals(""))
								hshRecord.put("Subsidy","Not Eligbile ");
						}
					}
					
					marginpercent=((marginamount+subsidyAmount)/proposed_amount)*100;
					if(dblmargin<=marginpercent)
					{
						if(correctNull((String)hshRecord.get("Margin")).equals(""))
							hshRecord.put("Margin","Eligbile");
					}
					else
					{
						if(correctNull((String)hshRecord.get("Margin")).equals(""))
							hshRecord.put("Margin","Not Eligbile");
					}
					
					
					
				}	
				
//				calculating Annual Income
				if(strresidencein.equalsIgnoreCase(""))
				{
					hshRecord.put("AnnualIncome","<font color='red'>  Residence In Not entered in Subsidy page ! </font>");
				}
				else if(strresidencein.equalsIgnoreCase("R"))
				{
					if(dblannualincomerural!=0.0)
					{
					
						//calculating annual income
						if(subsidyAnnualIncome > dblannualincomerural)
						{
							hshRecord.put("AnnualIncome","Not Eligible");
						}
						else if(subsidyAnnualIncome <= dblannualincomerural)
						{
							hshRecord.put("AnnualIncome","Eligible");
						}
					}
					else
					{
						hshRecord.put("AnnualIncome","<font color='blue'>Not Applicable</font>");
					}
				}
				else
				{
					if(dblannualincomeothers!=0)
					{
					
						//calculating annual income
						if(subsidyAnnualIncome > dblannualincomeothers)
						{
							hshRecord.put("AnnualIncome","Not Eligible");
						}
						else if(subsidyAnnualIncome <= dblannualincomeothers)
						{
							hshRecord.put("AnnualIncome","Eligible");
						}
					}
					else
					{
						hshRecord.put("AnnualIncome","<font color='blue'>Not Applicable</font>");
					}
				}		
				
				if(rs!=null) rs.close();
				strQuery=SQLParser.getSqlQuery("selperappbycomdemoappno^"+strAppno+"^N");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					double dblagecompleted=0;
					String strCategory="";
					String strExserviceman="";
					String strPhychallenged="";
					String strGender="";
					String strapplicantregion="";
					int inteducqualification=0;
					//int intmobility=0;
					
					dblagecompleted=rs.getDouble("agecompleted");
					/***
					 * Reason for adding age with hundred is due to the
					 * oracle default date format is dd/mm/yy so, it will take 2008 as
					 * 08
					 ***/
					if(dblagecompleted<0)
						dblagecompleted+=100;
					strCategory=correctNull(rs.getString("perapp_category"));
					strExserviceman=correctNull(rs.getString("perapp_selexservice"));
					strPhychallenged=correctNull(rs.getString("perapp_selphysical"));
					strGender=correctNull(rs.getString("perapp_sex"));
					strapplicantregion=correctNull(rs.getString("org_region"));
					inteducqualification=rs.getInt("perapp_education");
					//intmobility=rs.getInt("perapp_yrsinpresadd");
				
					
					if(dblagecompleted>dblgenminage)
					{
						
						if(!strApplicantType.equalsIgnoreCase("M/S"))
						{
						hshRecord.put("Minage","Eligible");
						//arrValues.add("Based on Minimum age of the applicant is Eligible");
						if((strCategory.equalsIgnoreCase("003") || strCategory.equalsIgnoreCase("004")) && dblagecompleted>dblscstmaxage)
						{
							hshRecord.put("Maxage","Not Eligible");
							//arrValues.add("Maximum age of the SC/ST applicant should be "+intscstmaxage+" years");
						}
						else if(strExserviceman.equalsIgnoreCase("Y") && dblagecompleted>dblexservicemaxage)
						{
							hshRecord.put("Maxage","Not Eligible");
							//arrValues.add("Maximum age of the Ex-Serviceman should be "+intexservicemaxage+" years");
						}
						else if(strPhychallenged.equalsIgnoreCase("Y") && dblagecompleted>dblphymaxage)
						{
							hshRecord.put("Maxage","Not Eligible");
							//arrValues.add("Maximum age of the Physically Challenged should be "+intphymaxage+" years");
						}
						else if(strGender.equalsIgnoreCase("F") && dblagecompleted>dblwomenmaxage)
						{
							hshRecord.put("Maxage","Not Eligible");
							//arrValues.add("Maximum age of the Women applicant should be "+intwomenmaxage+" years");
						}
						else if(strapplicantregion.equalsIgnoreCase("2") && dblagecompleted>dblnortheastmaxage)
						{
							hshRecord.put("Maxage","Not Eligible");
							//arrValues.add("Maximum age of the Women applicant should be "+intnortheastmaxage+" years");
						}
						else if(dblagecompleted>dblgenmaxage)
						{
							hshRecord.put("Maxage","Not Eligible");
							//arrValues.add("Maximum age of the applicant should be "+intgenmaxage+" years");
						}
						else
						{
							hshRecord.put("Maxage","Eligible");
							//arrValues.add("Based on Maximum age of the applicant Eligible");
						}
						}else{
							
							hshRecord.put("Minage","<font color='blue'>Not Applicable</font>");
							hshRecord.put("Maxage","<font color='blue'>Not Applicable </font>");
							
						}
						
					}
					else
					{if(!strApplicantType.equalsIgnoreCase("M/S"))
						{
						hshRecord.put("Minage","Not Eligible");
						hshRecord.put("Maxage","Not Eligible");
						}else{
							hshRecord.put("Minage","<font color='blue'>Not Applicable</font>");
							hshRecord.put("Maxage","<font color='blue'>Not Applicable</font>");
						}
						//arrValues.add("Minimum age of the applicant should be "+intgenminage+" years");
					}
					
					if(inteducqualification!=13 && inteducqualification<=dblmineducation)
					{
						hshRecord.put("EduQualification","Eligible");
						//arrValues.add("Based on Minimum Education the applicant is eligible");
					}
					else
					{
						hshRecord.put("EduQualification","Not Eligible");
						//arrValues.add("Based on Minimum Education the applicant is not eligible");
					}
					if(intminmobility!=0)
					{
						if(intminmobility<=intmobility)
							hshRecord.put("Mobility","Eligible");
						else
							hshRecord.put("Mobility","Not Eligible");
					}
					else
					{
						hshRecord.put("Mobility","Eligible");
					}
					
				}
				
				
				
				
				
				if(rs!=null) rs.close();
				
				strQuery=SQLParser.getSqlQuery("sel_opsaccountdetails^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				boolean bstate=rs.next();
				if(bstate)
				{
					double dblwclimit=0.0;
					double dbltermlimit=0.0;
					double dbltotallimit=0.0;
					
					if(rs1!=null)rs1.close();
					strQuery=SQLParser.getSqlQuery("comfundtotal^"+strAppno);
					rs1=DBUtils.executeQuery(strQuery);
					
					if(rs1.next())
					{
						dblwclimit=rs1.getDouble(2);//working capital  fund limit
					}
					
					if(rs1!=null)rs1.close();
					strQuery=SQLParser.getSqlQuery("comnonfundtotal^"+strAppno);
					rs1=DBUtils.executeQuery(strQuery);
					
					if(rs1.next())
					{
						dblwclimit=dblwclimit+rs1.getDouble(2);//working capital non fun limit (+total).
					}
					
					if(rs1!=null)rs1.close();
					strQuery=SQLParser.getSqlQuery("comtermfundtotal^"+strAppno);
					rs1=DBUtils.executeQuery(strQuery);
					
					if(rs1.next())
					{
						dbltermlimit=rs1.getDouble(2);//term loan funded.
					}
					dbltotallimit=dbltermlimit+dblwclimit;//over all limit.
					if(correctNull(rs.getString("ops_accountsectorcategory")).equalsIgnoreCase("3"))
					{
						if(dblbusinesssectoraggr>=dbltotallimit)
						{
							hshRecord.put("Overallimit","Eligible");
							//Checking for term loan eligibility
							if(dblbusitermloan>=dbltermlimit)
								hshRecord.put("Termloanlimit","Eligible");
							else
								hshRecord.put("Termloanlimit","Not Eligible");
								
							//checking for working capital elibility
							if(dblbusiwc>=dblwclimit)
								hshRecord.put("WClimit","Eligible");
							else
								hshRecord.put("WClimit","Not Eligible");
						}
						else{
							hshRecord.put("Overallimit","Not Eligible");
							hshRecord.put("WClimit","Not Eligible");
							hshRecord.put("Termloanlimit","Not Eligible");
						}
					}
					else
					{
						if(dblnonbusiaggr>=dbltotallimit)
						{
							hshRecord.put("Overallimit","Eligible");
							//Checking for term loan eligibility
							if(dblnonbusiterm>=dbltermlimit)
								hshRecord.put("Termloanlimit","Eligible");
							else
								hshRecord.put("Termloanlimit","Not Eligible");
							
							//checking for working capital elibility
							if(dblnonbusiwc>=dblwclimit)
								hshRecord.put("WClimit","Eligible");
							else
								hshRecord.put("WClimit","Not Eligible");
						}
						else
						{
							hshRecord.put("Overallimit","Not Eligible");
							hshRecord.put("WClimit","Not Eligible");
							hshRecord.put("Termloanlimit","Not Eligible");
						}
					}
				}
				else
				{
					arrValues.add("Enter Values in Account Details Page");
				}
				
				//COMPARING THE REPAYMENT PERIOD WITH SETUP CONSTRAINS.BY S.SATHYA MOORTHY.
				//All facilties should follow this setup level data.(if one facility exceeds the setup level value
				// then Status will be not Eligible.
				if(correctNull(strMaxRepayPeriod).equals(""))
				hshRecord.put("MAX_REPAYMENT_PRD","<font color='red'>Maximum Repayment Period Not Defined in the Setup !</font>");
				if(correctNull(strMinRepayPeriod).equals(""))
				hshRecord.put("MIN_REPAYMENT_PRD","<font color='red'>Minimum Repayment Period Not Defined in the Setup !</font>");
				if(rs1!=null)rs1.close();
				strQuery=SQLParser.getSqlQuery("sel_repayment_eligbility_check^"+strAppno);
				rs1=DBUtils.executeQuery(strQuery);
				
				ArrayList arr=new ArrayList();
				int i=0;
				int nullcheck=0;
				while(rs1.next())
				{
					arr.add(new Integer(rs1.getInt("facility_months")));
					if(correctNull(rs1.getString("facility_months")).equals("0"))nullcheck++;
					++i;
				}
				if(i==0||nullcheck!=0)hshRecord.put("MAX_REPAYMENT_PRD",""+correctNull((String)hshRecord.get("MAX_REPAYMENT_PRD"))+"<font color='red'><br>Repayment Period Not Defined in Facilities!</font>");
				if(i==0 ||nullcheck!=0)hshRecord.put("MIN_REPAYMENT_PRD",""+correctNull((String)hshRecord.get("MIN_REPAYMENT_PRD"))+"<font color='red'><br>Repayment Period Not Defined in Facilities!</font>");
				int mincheckFlag=0;
				int maxcheckFlag=0;
				for(int k=0;k<arr.size();k++)
				{
					
					if(!correctNull(strMaxRepayPeriod).equals(""))
					{
						if(Integer.parseInt(strMaxRepayPeriod)<= Integer.parseInt(""+arr.get(k).toString()) && maxcheckFlag!=1){
							maxcheckFlag=1;
						}
						else if(maxcheckFlag!=1) maxcheckFlag=2;
						
					}
					if(!correctNull(strMinRepayPeriod).equals(""))
					{
						if(Integer.parseInt(strMinRepayPeriod)>= Integer.parseInt(""+arr.get(k))&&mincheckFlag!=1 ){
							mincheckFlag=1;
						}else if(mincheckFlag!=1)mincheckFlag=2;
						
					}
					
				}
				if(nullcheck==0){
				if(maxcheckFlag==1 ){hshRecord.put("MAX_REPAYMENT_PRD","Not Eligible");}else if(maxcheckFlag==2){hshRecord.put("MAX_REPAYMENT_PRD","Eligible");}
				if(mincheckFlag==1){hshRecord.put("MIN_REPAYMENT_PRD","Not Eligible");}else if(mincheckFlag==2){hshRecord.put("MIN_REPAYMENT_PRD","Eligible");}
				}
				
				
				
				if(rs!=null)rs.close();
				rs=DBUtils.executeQuery(SQLParser.getSqlQuery("get_shg_type^"+strAppno));
				boolean shgcheck=rs.next();
			   if(rs!=null)rs.close();
				
				//THIS BLOCK IS MENT FOR SHG MINIMUM AND MAXIMUM PROCESSING..
				//BY S.SATHYA MOORTHY.
				int intPromotersCount=0;
				if(rs!=null)rs.close();
				rs=DBUtils.executeQuery(SQLParser.getSqlQuery("get_promoters_count_shg^SH@^"+strAppno));
				if(rs.next())
				{
					intPromotersCount=rs.getInt("promotercount");
				}
				if(rs!=null)rs.close();
			if(intPromotersCount==0)
			{
				hshRecord.put("MIN_SHG_MEMBERS","<font color=red>Not Applicable </font>");
				hshRecord.put("MAX_SHG_MEMBERS","<font color=red>Not Applicable </font>");
				hshRecord.put("SHG_LIMIT","<font color=red>Not Applicable </font>");
			}
			else
			{
				if(correctNull(strminmemforshg).equals(""))hshRecord.put("MIN_SHG_MEMBERS","<font color=red>SHG Members Minimum Limit Not Defined in the Setup !</font>");
				else
				{
					if(intPromotersCount < Integer.parseInt(strminmemforshg))
					{
						hshRecord.put("MIN_SHG_MEMBERS","Not Eligible");
					}
					else if(intPromotersCount >= Integer.parseInt(strminmemforshg))
					{
						hshRecord.put("MIN_SHG_MEMBERS","Eligible");
					}
				}	
			
				if(correctNull(strmaxmemforshg).equals(""))hshRecord.put("MAX_SHG_MEMBERS","<font color=red>SHG Members Maximum Limit Not Defined in the Setup !</font>");
				else
				{
					if(intPromotersCount > Integer.parseInt(strmaxmemforshg))
					{
						hshRecord.put("MAX_SHG_MEMBERS","Not Eligible");
					}
					else if(intPromotersCount <= Integer.parseInt(strmaxmemforshg))
					{
						hshRecord.put("MAX_SHG_MEMBERS","Eligible");
					}
					
				}
			
				if(correctNull(strmaxloanforshg).equals(""))
				{	
					hshRecord.put("SHG_LIMIT","<font color=red>SHG Limit not Defined in the Setup !</font>");
				}
				else
				{
					int tot_promotersLimit=intPromotersCount * Integer.parseInt(strmaxloanforshg);
					if(tot_promotersLimit > proposed_amount)
					{
						hshRecord.put("SHG_LIMIT","Not Eligible");
					}
					else if(tot_promotersLimit <= proposed_amount)
					{
						hshRecord.put("SHG_LIMIT","Eligible");
					}
				}
			}
			
			
			
			//THIS BLOCK IS MENT FOR SHG LIMIT PROCESSING...
			//S.SATHYA MOORTHY.
		
							
		  

		 if(shgcheck)
		 {
			 
			 //ASSIGNING THE INDIVIDUAL STATUS TO NOT APPLICABLE IF THE APPLICATION HAS SHG PROMOTERS.
			hshRecord.put("Subsidy","<font color='red'>Not Applicable </font>");
			hshRecord.put("Minage","<font color='red'>Not Applicable </font>");
			hshRecord.put("Maxage","<font color='red'>Not Applicable </font>");
			hshRecord.put("EduQualification","<font color='red'>Not Applicable </font>");
			//hshRecord.put("Mobility","<font color='red'>Not Applicable </font>");
			hshRecord.put("Overallimit","<font color='red'>Not Applicable </font>");
			hshRecord.put("Termloanlimit","<font color='red'>Not Applicable </font>");
			hshRecord.put("WClimit","<font color='red'>Not Applicable </font>");
			 
					 
		 //CHECKING THE AGE,EDUCATION,ANNUAL INCOME AND SUBSIDY AMOUNT OF THE SHG BORROWERS(PROMOTERS)..
		 //S.SATHYA MOORTHY.
		 //FLAG INFO: 1==>ELGIBILITY 2==>NOT ELIGBILE 0==>VALUES NOT IN PROCESSING LEVEL 3===>NOT APPLICABLE 4==>NOT DEFINED IN SETUP.
		 double dblagecompleted=0;
			String strCategory="";
			String strExserviceman="";
			String strPhychallenged="";
			String strGender="";
			String strapplicantregion="";
			int inteducqualification=0;
			//int intmobility=0;
			ArrayList arrCol=new ArrayList();
			ArrayList arrRow=null;;
			
			int MinAgeEligbilityFlag=0;
			int MaxAgeEligbilityFlag=0;
			int EducationEligbilityFlag=0;
			//int MobilityElgibilityFlag=0;
			//int AnnualIncomeEligibiltyFlag=0;
			int SubsidyAmountEligibiltyFlag=0;
			String strAppId="";
			
			strQuery=SQLParser.getSqlQuery("get_shg_type^"+strAppno);
			shgrs=DBUtils.executeQuery(strQuery);
			//boolean shgtype=shgrs.next();
			if(shgrs!=null)shgrs.close();
			
			if(rs!=null) rs.close();
			strQuery=SQLParser.getSqlQuery("selperappbycomdemoappno^"+strAppno+"^SH@");
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				MinAgeEligbilityFlag=0;
				MaxAgeEligbilityFlag=0;
				
				dblagecompleted=rs.getDouble("agecompleted");
				/***
				 * Reason for adding age with hundred is due to the
				 * oracle default date format is dd/mm/yy so, it will take 2008 as
				 * 08
				 ***/
				if(dblagecompleted<0)
					dblagecompleted+=100;
				strCategory=correctNull(rs.getString("perapp_category"));
				strExserviceman=correctNull(rs.getString("perapp_selexservice"));
				strPhychallenged=correctNull(rs.getString("perapp_selphysical"));
				strGender=correctNull(rs.getString("perapp_sex"));
				strapplicantregion=correctNull(rs.getString("org_region"));
				inteducqualification=rs.getInt("perapp_education");
				//intmobility=rs.getInt("perapp_yrsinpresadd");
				strAppId=rs.getString("perapp_oldid");
			
				
				if(dblagecompleted>dblgenminage)
				{
					
					if(!strApplicantType.equalsIgnoreCase("M/S"))
					{
					//hshRecord.put("Minage","Eligible");
				     MinAgeEligbilityFlag=1;
					//arrValues.add("Based on Minimum age of the applicant is Eligible");
					if((strCategory.equalsIgnoreCase("003") || strCategory.equalsIgnoreCase("004")) && dblagecompleted>dblscstmaxage)
					{
						//hshRecord.put("Maxage","Not Eligible");
						MaxAgeEligbilityFlag=2;
						//arrValues.add("Maximum age of the SC/ST applicant should be "+intscstmaxage+" years");
					}
					else if(strExserviceman.equalsIgnoreCase("Y") && dblagecompleted>dblexservicemaxage)
					{
						//hshRecord.put("Maxage","Not Eligible");
						MaxAgeEligbilityFlag=2;
						//arrValues.add("Maximum age of the Ex-Serviceman should be "+intexservicemaxage+" years");
					}
					else if(strPhychallenged.equalsIgnoreCase("Y") && dblagecompleted>dblphymaxage)
					{
						//hshRecord.put("Maxage","Not Eligible");
						MaxAgeEligbilityFlag=2;
						//arrValues.add("Maximum age of the Physically Challenged should be "+intphymaxage+" years");
					}
					else if(strGender.equalsIgnoreCase("F") && dblagecompleted>dblwomenmaxage)
					{
						//hshRecord.put("Maxage","Not Eligible");
						MaxAgeEligbilityFlag=2;
						//arrValues.add("Maximum age of the Women applicant should be "+intwomenmaxage+" years");
					}
					else if(strapplicantregion.equalsIgnoreCase("2") && dblagecompleted>dblnortheastmaxage)
					{
						//hshRecord.put("Maxage","Not Eligible");
						MaxAgeEligbilityFlag=2;
						//arrValues.add("Maximum age of the Women applicant should be "+intnortheastmaxage+" years");
					}
					else if(dblagecompleted>dblgenmaxage)
					{
						//hshRecord.put("Maxage","Not Eligible");
						MaxAgeEligbilityFlag=2;
						//arrValues.add("Maximum age of the applicant should be "+intgenmaxage+" years");
					}
					else
					{
						//hshRecord.put("Maxage","Eligible");
						MaxAgeEligbilityFlag=1;
						//arrValues.add("Based on Maximum age of the applicant Eligible");
					}
					}else{
						
						MaxAgeEligbilityFlag=3;
						MinAgeEligbilityFlag=3;
						EducationEligbilityFlag=3;
						
					}
					
				}
				else
				{if(!strApplicantType.equalsIgnoreCase("M/S"))
					{
					MaxAgeEligbilityFlag=2;
					MinAgeEligbilityFlag=2;
					}else{
						MaxAgeEligbilityFlag=3;
						MinAgeEligbilityFlag=3;
						
					}
					//arrValues.add("Minimum age of the applicant should be "+intgenminage+" years");
				}
				
				if(inteducqualification!=13 && inteducqualification<=dblmineducation)
				{
					//hshRecord.put("EduQualification","Eligible");
					EducationEligbilityFlag=1;
					
					//arrValues.add("Based on Minimum Education the applicant is eligible");
				}
				else
				{
					//hshRecord.put("EduQualification","Not Eligible");
					//arrValues.add("Based on Minimum Education the applicant is not eligible");
					EducationEligbilityFlag=2;
				}
				
				/*if(intminmobility!=0)
				{
					if(intminmobility>=intmobility)
						MobilityElgibilityFlag=1;
					else
						MobilityElgibilityFlag=2;
				}
				else
				{
					MobilityElgibilityFlag=1;
				}*/
				
			
				
				
				if(shgrs!=null)shgrs.close();
				
								
			
				
				//SHG SUBSIDY...
				 //FLAG INFO: 1==>ELGIBILITY 2==>NOT ELIGBILE 0==>VALUES NOT IN PROCESSING LEVEL 3===>NOT APPLICABLE 4==>NOT DEFINED IN SETUP.
				 
				SubsidyAmountEligibiltyFlag=0;
				if(correctNull(strsubsidyperc).equals("") || dblmaxsubsidyamt==0)
				{
					SubsidyAmountEligibiltyFlag=4;	
								
				}
				else
				{
			      double proposed_result= (proposed_amount* Double.parseDouble(strsubsidyperc)) / 100;
				  if(dblmaxsubsidyamt <= proposed_result)
			  	{
					if( subsidyAmount <= dblmaxsubsidyamt ){
						SubsidyAmountEligibiltyFlag=1;
					}
					else
					{
							SubsidyAmountEligibiltyFlag=2;
					}	
				 }
				 else if(dblmaxsubsidyamt > proposed_result)
				 {				
					if(subsidyAmount<=proposed_result){
						SubsidyAmountEligibiltyFlag=1;						
					}else{
						
						SubsidyAmountEligibiltyFlag=2;
					}
				}
				}	
										
				
				strQuery=SQLParser.getSqlQuery("get_perapplicant_details^"+strAppId);
				shgrs=DBUtils.executeQuery(strQuery);
				if(shgrs.next())
				{
					strAppName=shgrs.getString("perapplicant_name");
				}
				if(shgrs!=null)shgrs.close();
				
				//this block makes the flag into not applicable when this application number doesnt have SHG promoters.
				
				
				
				arrRow=new ArrayList();
				arrRow.add(strAppId);
				arrRow.add(strAppName);
				arrRow.add(""+MinAgeEligbilityFlag);
				arrRow.add(""+MaxAgeEligbilityFlag);
				arrRow.add(""+EducationEligbilityFlag);
				//arrRow.add(""+MobilityElgibilityFlag);
				//arrRow.add(""+AnnualIncomeEligibiltyFlag);
				arrRow.add(""+SubsidyAmountEligibiltyFlag);
			    arrCol.add(arrRow); 
				
				
			}//end of while loop.
			
		    hshRecord.put("SHG_STATUS",arrCol);
		 
		 }//end of SHG CONDITION FLAG..
		
		 	
		}	
		}catch(Exception ex)
		{
			throw new EJBException("Error in checkeligibityforgovtsponsor :: "+ex.getMessage());
		}finally
		{
			try{
				if(rs!=null)
					rs.close();
				
			}catch(Exception exc)
			{
				throw new EJBException("Error in closing connection in checkeligibityforgovtsponsor :: "+exc.getMessage());
			}
		}
		return hshRecord;
	}

}