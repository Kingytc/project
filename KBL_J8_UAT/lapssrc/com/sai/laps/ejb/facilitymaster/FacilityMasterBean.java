package com.sai.laps.ejb.facilitymaster;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "FacilityMasterBean", mappedName = "FacilityMasterHome")
@Remote (FacilityMasterRemote.class)
public class FacilityMasterBean extends BeanAdapter
{
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(FacilityMasterBean.class);
	private static final long serialVersionUID = 1L;

	public HashMap updateData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshRecord = new HashMap();
		ArrayList arrValues = new ArrayList();
		int count =0;
		String strTemp =null;
		String strAction =null;
		String strCatid=null;
		String strCatName =null;
		String strCatParent=null;
		String strMsg="",strCode="";
		String strKeyId = "";
		StringBuilder sbolddata = new StringBuilder();
		String strQuery = "";
		ResultSet rs = null,rs1 = null;
		try
		{	
			String strSelectedHead = Helper.correctNull((String)hshValues.get("rad"));
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			String strPage = Helper.correctNull((String)hshValues.get("hid_selProd"));
			hshQueryValues.put("size","1");
			strAction = correctNull((String)hshValues.get("hidAction"));	
			strCatName= correctNull((String)hshValues.get("txtcat_name"));
			strCatParent = (String)hshValues.get("hidcat_parent");
			strCode = correctNull((String)hshValues.get("txt_code"));
			String txt_schemecode= correctNull((String)hshValues.get("txt_schemecode"));
			String strValue = Helper.correctNull((String)hshValues.get("hidcat_parent"));
			String strFacFor=Helper.correctNull((String)hshValues.get("sel_facilityfor"));
			String strActive=Helper.correctNull((String)hshValues.get("sel_active"));
			String strFacilityType="";
			strFacilityType=Helper.correctNull((String)hshValues.get("seltype"));
			String strFacility=Helper.correctNull((String)hshValues.get("facility1"));
			
			/*
			 * The changes made by prakash. Since for the Subfacility need to store the facility type (F / NF)
			 * and for the Facility Head need to store the Type of Facility (TL / WC)
			 */
			
			if(!strCatParent.equalsIgnoreCase("0"))
			{
				if(rs !=null) rs.close();
				rs=DBUtils.executeLAPSQuery("sel_facilitymaster_audittrial^"+strCatParent);
				if(rs.next())
				{
					strFacilityType=Helper.correctNull((String)rs.getString("facility_for"));
				}
			}
			else
			{
				if(strFacility.equalsIgnoreCase("1"))
				{
					strCode="WC";
				}
				else if(strFacility.equalsIgnoreCase("2"))
				{
					strCode="TL";
				}
				else
				{
					strCode="";
				}	
			}
			if(strAction.equalsIgnoreCase("Update") || strAction.equalsIgnoreCase("Delete"))
			{
				rs = DBUtils.executeLAPSQuery("sel_facilitymaster_audittrial^"+Helper.correctNull((String)hshValues.get("hidcat_id")));
				if(rs.next()){
					String strFacility_parent = Helper.correctNull((String)rs.getString("facility_parent"));
					if(strFacility_parent.equalsIgnoreCase("0"))
					{
						sbolddata.append("~Head of the Facility = ");
						sbolddata.append(Helper.correctNull((String)rs.getString("facility_catdesc")));
						sbolddata.append("~Type = ");
						if(Helper.correctNull((String)rs.getString("facility_for")).equals("F"))
						{
							sbolddata.append("Funded");
						}
						else if(Helper.correctNull((String)rs.getString("facility_for")).equals("NF"))
						{
							sbolddata.append("Non - Funded");
						}
						sbolddata.append("~Sequence Order = ");
						sbolddata.append(Helper.correctNull((String)rs.getString("facility_index")));
					}
					else
					{
						sbolddata.append("~Head of the Facility = ");
						strQuery=SQLParser.getSqlQuery("sel_facilitydesc^"+strFacility_parent);
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							sbolddata.append(Helper.correctNull((String)rs1.getString("facility_catdesc")));
						}
						if(rs1!=null)
						{
							rs1.close();
						}
						sbolddata.append("~Facility = ");
						sbolddata.append(Helper.correctNull((String)rs.getString("facility_catdesc")));
						sbolddata.append("~Code = ");
						if(Helper.correctNull((String)rs.getString("facility_code")).equalsIgnoreCase("SEC"))
						{
							sbolddata.append("Secured Advances");
						}else if(Helper.correctNull((String)rs.getString("facility_code")).equalsIgnoreCase("UNSEC"))
						{
							sbolddata.append("Unsecured Advances");
						}else if(Helper.correctNull((String)rs.getString("facility_code")).equalsIgnoreCase("BOD"))
						{
							sbolddata.append("Bank's Own Deposit");
						}else if(Helper.correctNull((String)rs.getString("facility_code")).equalsIgnoreCase("LC100"))
						{
							sbolddata.append("LC with 100% Margin");
						}else if(Helper.correctNull((String)rs.getString("facility_code")).equalsIgnoreCase("LG100"))
						{
							sbolddata.append("LG with 100% Margin");
						}else if(Helper.correctNull((String)rs.getString("facility_code")).equalsIgnoreCase("LCPB"))
						{
							sbolddata.append("LC of Prime Bank");
						}
						
						sbolddata.append("~Scheme Code= ");
						sbolddata.append(Helper.correctNull((String)rs.getString("facility_schemecode")));
						sbolddata.append("~Sequence Order = ");
						sbolddata.append(Helper.correctNull((String)rs.getString("facility_index")));
						sbolddata.append("~Facility Status = ");
						if(Helper.correctNull((String)rs.getString("FACILITY_NATURE")).equalsIgnoreCase("A"))
						{
							sbolddata.append("Active");
						}
						else if(Helper.correctNull((String)rs.getString("FACILITY_NATURE")).equalsIgnoreCase("I"))
						{
							sbolddata.append("Inactive");
						}
					}
				}
			}
			if (strAction.equalsIgnoreCase("Insert"))
			{
				hshQuery.put("strQueryId","InsertFacility");
				int intcatid = getProductid("max",strCatName,strCatParent);
				strTemp = java.lang.String.valueOf(intcatid);
				
				arrValues.add(strTemp);
				arrValues.add(hshValues.get("txtcat_name"));
				arrValues.add(hshValues.get("hidcat_parent"));
				arrValues.add(strCode);
				arrValues.add(hshValues.get("txt_seqorder"));
				arrValues.add(strFacilityType);
				arrValues.add(hshValues.get("facility1"));
				arrValues.add(txt_schemecode);
				//added by bhaskar
				arrValues.add(strFacFor);
				arrValues.add(strActive);	
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
								
			}
			else if(strAction.equalsIgnoreCase("Update"))
			{
					hshQuery.put("strQueryId","UpdateFacility");
					arrValues.add(hshValues.get("hidcat_id"));
					arrValues.add(hshValues.get("txtcat_name"));
					arrValues.add(hshValues.get("hidcat_parent"));
					arrValues.add(strCode);
					arrValues.add(hshValues.get("txt_seqorder"));
					arrValues.add(strFacilityType);
					arrValues.add(hshValues.get("facility1"));
					arrValues.add(txt_schemecode);
					arrValues.add(strFacFor);
					arrValues.add(strActive);	
					arrValues.add(hshValues.get("hidcat_id"));	
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
				}			
			else if (strAction.equalsIgnoreCase("Delete"))
			{
				if (strCatParent.equals("0"))
				{
					strCatParent = (String)hshValues.get("hidcat_id");
					count = getProductid("headfacilityupd",strCatName,strCatParent);
				}
				else  
				{
					strCatParent = (String)hshValues.get("hidcat_id");
					count = getProductid("facilityupd",strCatName,strCatParent);
				}
				if (count == 0)
				{
					hshQuery.put("strQueryId","DeleteFacility");
					arrValues.add(hshValues.get("hidcat_id"));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);					
				}
				else
				{
					strMsg="Cannot delete because it is having related records";
				}
			}			
			if (count == 0)
			{
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				hshRecord.put("action","done");
				hshRecord.put("Msg",strMsg);
			}
			else
			{
				hshRecord.put("action","failed");
				hshRecord.put("Msg",strMsg);
			}			
			strAction = correctNull((String)hshValues.get("hidAction"));	
			strCatName= correctNull((String)hshValues.get("txtcat_name"));
			strCatParent = (String)hshValues.get("hidcat_parent");
			strCode = correctNull((String)hshValues.get("txt_code"));
			 txt_schemecode= correctNull((String)hshValues.get("txt_schemecode"));
			 
			 String sel_type=correctNull((String)hshValues.get("seltype"));
			 String sel_subType = Helper.correctNull((String)hshValues.get("txt_code"));
			 String prod=correctNull((String)hshValues.get("hid_selProd"));
			 StringBuilder sbAuditTrial=new StringBuilder();
			
			 if(strAction.equalsIgnoreCase("Update") || strAction.equalsIgnoreCase("Insert"))
			 {
				 if(strSelectedHead.equalsIgnoreCase("H"))
				 {
					 sbAuditTrial.append("Head of the Facility=").append(strCatName);
						if(sel_type.equals("F"))sel_type="Funded";
						if(sel_type.equals("NF"))sel_type="Non-Funded";
					sbAuditTrial.append("~Type=").append(sel_type);
					sbAuditTrial.append("~Sequence Order=").append(correctNull((String)hshValues.get("txt_seqorder")));
				 }
				 else
				 {
					 sbAuditTrial.append("~Head of the Facility = ");
					 sbAuditTrial.append(correctNull((String)hshValues.get("hid_selProd")));
					 sbAuditTrial.append("~Facility=").append(strCatName);
					 	if(sel_subType.equals("SEC"))sel_type="Secured Advances";
					 	if(sel_subType.equals("UNSEC"))sel_type="Unsecured Advances";
					 	if(sel_subType.equals("BOD"))sel_type="Bank's Own Deposit";
					 	if(sel_subType.equals("LC100"))sel_type="LC with 100% Margin";
					 	if(sel_subType.equals("LG100"))sel_type="LG with 100% Margin";
					 	if(sel_subType.equals("LCPB"))sel_type="LC of Prime Bank";
					 sbAuditTrial.append("~Code=").append(sel_type);
					 sbAuditTrial.append("~Scheme Code=").append(txt_schemecode);
					 sbAuditTrial.append("~Sequence Order=").append(correctNull((String)hshValues.get("txt_seqorder")));
					 if(Helper.correctNull((String)hshValues.get("selstatus")).equalsIgnoreCase("A"))
					 {
						 sbAuditTrial.append("~Facility Status = ").append("Active");
					 }
					 else if(Helper.correctNull((String)hshValues.get("selstatus")).equalsIgnoreCase("I"))
					 {
						 sbAuditTrial.append("~Facility Status = ").append("InActive");
					 }
					 else
					 {
						 sbAuditTrial.append("~Facility Status = ").append("");
					 }
				 }
			 }
			AuditTrial.auditNewLog(hshValues,"104",strKeyId,sbAuditTrial.toString(),sbolddata.toString());
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
		return hshRecord;
	}

	private int getProductid(String strVal,String name,String parent) 
	{		
		ResultSet rs= null;
		String strQuery=null;
		int count=0;
		try
		{
			
			if (strVal.equalsIgnoreCase("max"))
			{
				strQuery =SQLParser.getSqlQuery("maxfacility");
				
			}
			else if (strVal.equalsIgnoreCase("headfacilityupd"))
			{
				strQuery =SQLParser.getSqlQuery("checkupdheadfacility^"+Integer.parseInt(parent));
				
			}
			else if (strVal.equalsIgnoreCase("facilityupd"))
			{
				strQuery =SQLParser.getSqlQuery("checkupdfacility^"+Integer.parseInt(parent));
				
			}

			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				count = rs.getInt(1);	
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error Occured  "+e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("close"+e.toString()); 
			}
		}
		return count;
	}

	private HashMap getFacility(HashMap hshValues) 
	{		
		String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecCatid = new ArrayList();
		ArrayList vecCatName = new ArrayList();
		String strValue = "";
		String strParent = "1";
		String strPage="";
		String strid="",strModulType="",strFrom="";

		try
		{			
			strValue = correctNull((String)hshValues.get("value"));
			strParent = correctNull((String)hshValues.get("parent"));
			strPage= correctNull((String)hshValues.get("page"));
			strid= correctNull((String)hshValues.get("setid"));
			strModulType=correctNull((String)hshValues.get("hidModType"));
			if(strModulType.equalsIgnoreCase(""))
			{
				String strModNew=correctNull((String)hshValues.get("sessionModuleType"));
				if(strModNew.equalsIgnoreCase("CORP"))
				{
					strModulType="c";
				}
				else if(strModNew.equalsIgnoreCase("AGR"))
				{
					strModulType="a";
				}
			}
			strFrom=correctNull((String)hshValues.get("varFromLink"));
			if(strFrom.equalsIgnoreCase("GCF"))
			{
				String strModNew=correctNull((String)hshValues.get("varModuleNew"));
				if(strModNew.equalsIgnoreCase("CORP"))
				{
					strModulType="c";
				}
				else if(strModNew.equalsIgnoreCase("AGR"))
				{
					strModulType="a";
				}
				
			}
			
			if (strValue.equalsIgnoreCase("parent"))
			{  
				if(strPage.equals("facility"))
				{
				strQuery = SQLParser.getSqlQuery("selparentfacility");
				}
				else{
					strQuery = SQLParser.getSqlQuery("selparentfacility_app");
				}
			}
			else if (strValue.equalsIgnoreCase("sub"))
			{
				strQuery = SQLParser.getSqlQuery("selallfacility");
			}
			else if (strValue.equalsIgnoreCase("subsel"))
			{
				if(strPage.equals("facility"))
				{
					strQuery = SQLParser.getSqlQuery("selfacility^"+Integer.parseInt(strParent));
				}
				else
				{
					if(!strModulType.equalsIgnoreCase(""))
					{
					 strQuery = SQLParser.getSqlQuery("selfacility_by_module^"+Integer.parseInt(strParent)+"^"+strModulType);
					}
				}
			}

			if(!strQuery.equalsIgnoreCase(""))
			{
			rs = DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				String catid =correctNull(rs.getString("facility_catid"));
				String catpa =correctNull(rs.getString("facility_parent"));
				String code =correctNull(rs.getString("facility_code"));
				String index =correctNull(rs.getString("facility_index"));
				String facilityfor =correctNull(rs.getString("facility_for"));
				String facility1 =correctNull(rs.getString("facility_nature"));
				String facility_schemecode=correctNull(rs.getString("facility_schemecode"));
				String facility_modfor=correctNull(rs.getString("facility_modfor"));
				//String facility_facilityname=correctNull(rs.getString("facility_facilityname"));
				String facility_active=correctNull(rs.getString("FACILITY_ACTIVE"));
				
				catpa= catid+"-"+catpa+"~"+code+"~"+index+"~"+facilityfor+"~"+facility1+"~"+
				facility_schemecode+"~"+facility_modfor+"~"+facility_active;
				vecCatid.add(catpa);
				if (strValue.equalsIgnoreCase("parent"))
					vecCatName.add(correctNull(rs.getString("facility_catdesc")));
				else 
					if(strid.equalsIgnoreCase("setup"))
					{
					vecCatName.add(correctNull(rs.getString("facility_catdesc")));
					}
					else
					{
						vecCatName.add(correctNull(rs.getString("facility_catdesc"))+" - "+facility_schemecode);
					}
					
			}
			}
		
			
			hshRecord.put("vecCodes",vecCatid);
			hshRecord.put("vecValues",vecCatName);
		
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in help "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs !=null)
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
	
	
//	public HashMap getFacilityNames(HashMap hshValues) 
//	{		
//		String strQuery="";
//		ResultSet rs = null;
//		HashMap hshRecord = new HashMap();
//		ArrayList vecCatid = new ArrayList();
//		ArrayList vecCatName = new ArrayList();
//		String strValue = "";
//		String strParent = "1";
//
//		try
//		{			
//			strValue = (String)hshValues.get("value");
//			strParent = (String)hshValues.get("parent");
///*
//			if (strValue.equalsIgnoreCase("parent"))
//			{
//				strQuery = SQLParser.getSqlQuery("selparentfacility");
//			}
//			else if (strValue.equalsIgnoreCase("sub"))
//			{
//				strQuery = SQLParser.getSqlQuery("selallfacility");
//			}
//			else if (strValue.equalsIgnoreCase("subsel"))
//			{
//				strQuery = SQLParser.getSqlQuery("selfacility^"+Integer.parseInt(strParent));
//			}
//			*/
//			
//			strQuery = SQLParser.getSqlQuery("SelectFacilitynames^"+strParent+"^"+strValue);
//
//			rs = DBUtils.executeQuery(strQuery);
//			
//			while(rs.next())
//			{
//				
//				vecCatName.add(correctNull(rs.getString("facility_names")));
//				
//			}
//			
//			hshRecord.put("vecCodes",vecCatName);
//			hshRecord.put("vecValues",vecCatName);
//		
//		}
//		catch(Exception ce)
//		{
//			throw new EJBException("Error in help "+ce.toString());
//		}
//		finally
//		{
//			try
//			{
//				if(rs !=null)
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
//		return hshRecord;
//	}
	
	public HashMap getData(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		String strMethod ="";

		try
		{
			strMethod=Helper.correctNull((String)hshValues.get("hidMethod"));

			if (strMethod.equalsIgnoreCase("getFacility"))
			{
				hshRecord =(HashMap)getFacility(hshValues);
			}		
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getdata "+ce.toString());
		}
		
		return hshRecord;

	}
	
	public void updateexposureindustry(HashMap hshvalues) 
	{
		HashMap hashValue = new HashMap();
		HashMap hashQueryValue = new HashMap();
		ArrayList arrValue = new ArrayList();
		String action="", Strid="";  
		
		try
		{
			 action = Helper.correctNull((String)hshvalues.get("hidAction"));
			 Strid     = Helper.correctNull((String)hshvalues.get("hidSno"));
			
			        if(action.equalsIgnoreCase("insert"))
				    { 
					ResultSet rs = null;	
					rs=DBUtils.executeLAPSQuery("sel_maxid_exposureindustry");
					if(rs.next())
					{
						Strid=rs.getString("SE_SINO");
					}
					
					hashValue = new HashMap();
					arrValue =new ArrayList();
					hashValue.put("strQueryId", "ins_exposureindustry");
					arrValue.add(Helper.correctNull((String)hshvalues.get("txt_activity")));
					arrValue.add(Strid);
					arrValue.add(Helper.correctNull((String)hshvalues.get("sel_active")));
					hashValue.put("arrValues", arrValue);
					hashQueryValue.put("size","1");
					hashQueryValue.put("1", hashValue);
					EJBInvoker.executeStateLess("dataaccess", hashQueryValue, "updateData");
				    }
			    	
			        else if(action.equalsIgnoreCase("update"))
					{   
						
						hashValue = new HashMap();
						arrValue =new ArrayList();
						hashValue.put("strQueryId", "updt_exposureindustry");
						arrValue.add(Helper.correctNull((String)hshvalues.get("txt_activity")));
						arrValue.add(Helper.correctNull((String)hshvalues.get("sel_active")));
						arrValue.add(Strid);
						hashValue.put("arrValues", arrValue);
						hashQueryValue.put("size","1");
						hashQueryValue.put("1", hashValue);
						EJBInvoker.executeStateLess("dataaccess", hashQueryValue, "updateData");
				    }
			        
			    	else if(action.equalsIgnoreCase("delete"))
					{
				    hashValue = new HashMap();
				    hashQueryValue = new HashMap();
					arrValue = new ArrayList();
					arrValue.add(Strid);
					hashValue.put("strQueryId" ,"del_exposureindustry^"+Strid);
					hashValue.put("arrValues", arrValue);
					hashQueryValue.put("size","1");
					hashQueryValue.put("1", hashValue);
					EJBInvoker.executeStateLess("dataaccess",hashQueryValue,"updateData");
					}
					
				
		}
		catch (Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getdata "+ce.toString());
		}
	}

	public HashMap getexposureindustry(HashMap hshvalues) 
	{
        ResultSet rs = null;
		HashMap hshRow = new HashMap();
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String strAppid="",strPageid="";
		try{
			strPageid=Helper.correctNull((String)hshvalues.get("hidPageId"));
			if(strPageid.equalsIgnoreCase("setupnav"))
			{
			rs=DBUtils.executeLAPSQuery("sel_exposureindustry"); 
			}
			else{
				rs=DBUtils.executeLAPSQuery("sel_exposureindustry_action"); 
			}
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("SE_SINO")));
                arrCol.add(Helper.correctNull((String)rs.getString("SE_ACTIVITY")));
                arrCol.add(Helper.correctNull((String)rs.getString("SE_ACTION")));
				arrRow.add(arrCol);
			}
			hshRow.put("arrRow", arrRow);
				
		}	
		
		
		catch(final Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getdata "+ce.toString());
		}
		
		return hshRow;
	}
		
			
			
}