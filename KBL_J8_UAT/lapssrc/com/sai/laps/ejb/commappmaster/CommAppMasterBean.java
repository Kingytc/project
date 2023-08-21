package com.sai.laps.ejb.commappmaster;

import java.rmi.RemoteException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;
import org.jfree.util.Log;

import com.sai.laps.ejb.mastapplicant.MastApplicantBean;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
@Stateless(name = "CommAppMasterBean", mappedName = "CommAppMasterHome")
@Remote (CommAppMasterRemote.class)
public class CommAppMasterBean extends BeanAdapter
{
	private static final long serialVersionUID = 1L;
	public HashMap getApplicantList(HashMap hshValues) 
	{
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		ArrayList arryCol=null;
		ArrayList arryRow=new ArrayList();
		ArrayList arrcomappid=new ArrayList();
		ArrayList arrcomname= new ArrayList();
		ArrayList arrcomid=new ArrayList();
		ArrayList arrcomtype = new ArrayList();
		ArrayList arrindustryname = new ArrayList();
		String strQuery="";
		String strComappid="";
		String strComappname="",absPosition="";
		try
		{
			strComappid=correctNull((String)hshValues.get("comapp_id"));
			if(strComappid.trim().equalsIgnoreCase(""))
				strComappid="%";
			
			strComappname=correctNull((String)hshValues.get("comapp_companyname"));
			if(strComappname.trim().equalsIgnoreCase(""))
				strComappname="%";
			
			String strOrgShortCode=correctNull((String)hshValues.get("strOrgShortCode"));
			String strOrgSelect=correctNull((String)hshValues.get("strOrgSelect"));
		    absPosition = correctNull((String)hshValues.get("hid_rowcount"));
			if(strOrgSelect.trim().equalsIgnoreCase(""))
				strOrgSelect="%";
			
			if(strOrgShortCode.trim().equalsIgnoreCase(""))
				strOrgShortCode="%";
				
			strQuery=SQLParser.getSqlQuery("comappmasterlist^"+strComappid+"^"+strComappname+"^"+strOrgSelect+"%");
			rs=DBUtils.executeQuery(strQuery);
			rs.last();
			
			int RowCount = rs.getRow();			    
			rs.beforeFirst();
		 	if(RowCount != 0)				
		 	{
		 		if (!absPosition.equals("0"))
				{
		 			if(Integer.parseInt(absPosition) > RowCount)
					{
		 				rs.absolute(RowCount);
					}
					else
					{
						rs.absolute(Integer.parseInt(absPosition));
					}				
				}			
			}
			
			while(rs.next())
			{
				arrcomappid.add(correctNull((String)rs.getString(1)));
				arrcomname.add(correctNull((String)rs.getString(2)));
				arrcomid.add(correctNull(rs.getString(3)));
				arrcomtype.add(correctNull(rs.getString(4)));
				arrindustryname.add(correctNull(rs.getString(5)));
				arryCol=new ArrayList();				 
				arryCol.add(correctNull((String)rs.getString("comapp_id")));
				arryCol.add(correctNull((String)rs.getString("comapp_companyname")));
				arryCol.add(correctNull((String)rs.getString("comapp_companyid")));
				arryCol.add(correctNull((String)rs.getString("comapp_comtype")));
				arryCol.add(correctNull((String)rs.getString("ind_name")));		
				arryCol.add(correctNull((String)rs.getString("org_name")));		
				arryRow.add(arryCol);
			}
			
			hshRecord.put("arrcomappid",arrcomappid);
			hshRecord.put("arrcomname",arrcomname);
			hshRecord.put("arrcomid",arrcomid);
			hshRecord.put("arrcomtype",arrcomtype);
			hshRecord.put("arrindustryname",arrindustryname);
			hshRecord.put("hidPageType",correctNull((String)hshValues.get("hidPageType")));
			hshRecord.put("arryRow",arryRow);
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
				throw new EJBException("Error closing connection"+e1);
			}
		}
		return hshRecord;
	}

	public HashMap getBorrowerType(HashMap hshValues) 
	{
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		String strAppNo="";

		try
		{
			strAppNo =correctNull((String)hshValues.get("appno"));
			rs=DBUtils.executeLAPSQuery("selborrowertype^"+strAppNo);
			while(rs.next())
			{
				hshRecord.put("comapp_companyname",correctNull((String)rs.getString("perapp_fname")));
				//hshRecord.put("comapp_companyid",correctNull((String)rs.getString("comapp_companyid")));
				//hshRecord.put("comapp_comtype",correctNull((String)rs.getString("comapp_comtype")));
				//hshRecord.put("comapp_ssitype",correctNull((String)rs.getString("comapp_ssitype")));
				hshRecord.put("comapp_id",correctNull((String)rs.getString("perapp_id")));				
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
				throw new EJBException("Error closing connection"+e1);
			}
		}
		return hshRecord;
	}

	public HashMap getBorrowers(HashMap hshValues) 
	{
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		ArrayList arrcomappid=new ArrayList();
		ArrayList arrcomname= new ArrayList();
		ArrayList arrcomid=new ArrayList();
		ArrayList arrcomtype = new ArrayList();
		ArrayList arrindustryname = new ArrayList();

		String strQuery="";
		String strComappid="";
		String strComappname="";
		String strComType="";
		String strSSIType="";

		try
		{
			strComappid=correctNull((String)hshValues.get("comapp_id"));			
			strComappname=correctNull((String)hshValues.get("comapp_companyname"));
			strComType =correctNull((String)hshValues.get("comapp_comtype"));			

			strSSIType =correctNull((String)hshValues.get("comapp_ssitype"));			
			strQuery=SQLParser.getSqlQuery("comborrowerlist^"+strComappid+"^"+strComappname+"^"+strComType+"^"+strSSIType);

			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrcomappid.add(correctNull((String)rs.getString(1)));
				arrcomname.add(correctNull((String)rs.getString(2)));
				arrcomid.add(correctNull(rs.getString(3)));
				arrcomtype.add(correctNull(rs.getString(4)));
				arrindustryname.add(correctNull(rs.getString(5)));
			}
			hshRecord.put("arrcomappid",arrcomappid);
			hshRecord.put("arrcomname",arrcomname);
			hshRecord.put("arrcomid",arrcomid);
			hshRecord.put("arrcomtype",arrcomtype);
			hshRecord.put("arrindustryname",arrindustryname);
			hshRecord.put("hidPageType",correctNull((String)hshValues.get("hidPageType")));
			hshRecord.put("hidCategoryType",correctNull((String)hshValues.get("comapp_comtype")));
			hshRecord.put("hidSSIType",correctNull((String)hshValues.get("comapp_ssitype")));
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
				throw new EJBException("Error closing connection"+e1);
			}
		}
		return hshRecord;
	}

	public HashMap getData(HashMap hshValues) 
	{
		ResultSet rs=null;
		ResultSet rs1=null;
		HashMap hshRecord=new HashMap();
		String strQuery="";
		String strComappid="";
		String cityregval="",cityregvalue="",stateregvalue="",statereg_value="";
		boolean recordflag=false;
		try
		{
			strComappid=(String)hshValues.get("comapp_id");
			
			if(strComappid==null || strComappid.equals("New"))
			{
				return new HashMap();
			}
		
			rs=DBUtils.executeLAPSQuery("comappmastersel^"+strComappid);
			if(rs.next())
			{
				hshRecord.put("comapp_id",rs.getString("comapp_id"));
				hshRecord.put("comapp_companyname",correctNull(rs.getString("comapp_companyname")));
				hshRecord.put("comapp_companyid",correctNull(rs.getString("comapp_companyid")));
				hshRecord.put("comapp_crptaddress1",correctNull(rs.getString("comapp_crptaddress1")));
				hshRecord.put("comapp_crptaddress2",correctNull(rs.getString("comapp_crptaddress2")));
				hshRecord.put("comapp_crptcity",correctNull(rs.getString("comapp_crptcity")));
				hshRecord.put("comapp_crptstate",correctNull(rs.getString("comapp_crptstate")));
				hshRecord.put("comapp_crptpin",correctNull(rs.getString("comapp_crptpin")));
				hshRecord.put("comapp_crptphone",correctNull(rs.getString("comapp_crptphone")));
				hshRecord.put("comapp_crptfax",correctNull(rs.getString("comapp_crptfax")));
				hshRecord.put("comapp_businessnature",correctNull(rs.getString("comapp_businessnature")));
				hshRecord.put("comapp_corpstructure",correctNull(rs.getString("comapp_corpstructure")));
				hshRecord.put("comapp_companyrole",correctNull(rs.getString("comapp_companyrole")));
				hshRecord.put("comapp_yrsinbusiness",correctNull(rs.getString("comapp_yrsinbusiness")));
				hshRecord.put("comapp_ownership",correctNull(rs.getString("comapp_ownership")));
				hshRecord.put("comapp_totemployees",correctNull(rs.getString("comapp_totemployees")));
				hshRecord.put("comapp_contact",correctNull(rs.getString("comapp_contact")));
				hshRecord.put("comapp_email",correctNull(rs.getString("comapp_email")));
				hshRecord.put("comapp_groupid",correctNull(rs.getString("comapp_group")));
				hshRecord.put("comapp_corppremises",correctNull(rs.getString("comapp_corppremises")));
				//hshRecord.put("comapp_factpremises",correctNull(rs.getString(28)));
				hshRecord.put("comapp_regpremises",correctNull(rs.getString("comapp_regpremises")));
				hshRecord.put("comapp_regadd1",correctNull(rs.getString("comapp_regadd1")));
				hshRecord.put("comapp_regadd2",correctNull(rs.getString("comapp_regadd2")));
				hshRecord.put("hidcity3",correctNull(rs.getString("comapp_regcity")));
				cityregval=correctNull(rs.getString("comapp_regcity"));
				hshRecord.put("hidstate3",correctNull(rs.getString("comapp_regstate")));
				hshRecord.put("comapp_regphone",correctNull(rs.getString("comapp_regphone")));
				hshRecord.put("comapp_regfax",correctNull(rs.getString("comapp_regfax")));
				hshRecord.put("comapp_regpin",correctNull(rs.getString("comapp_regpin")));
				hshRecord.put("comapp_indcode",correctNull(rs.getString("comapp_indcode")));
				hshRecord.put("comapp_regdeal",correctNull(rs.getString("comapp_bankdealing")));
				hshRecord.put("comapp_indtype",correctNull(rs.getString("comapp_indtype")));					
				//hshRecord.put("relatives",correctNull(rs.getString(40)));
				hshRecord.put("scale",correctNull(rs.getString("scale")));
				//hshRecord.put("emp",correctNull(rs.getString(42)));
				//hshRecord.put("relationship",correctNull(rs.getString(43)));
				//hshRecord.put("comapp_exp",correctNull(rs.getString(44)));
				hshRecord.put("comapp_admadd1",correctNull(rs.getString("comapp_admadd1")));
				hshRecord.put("comapp_admadd2",correctNull(rs.getString("comapp_admadd2")));
				hshRecord.put("hidcity4",correctNull(rs.getString("comapp_admcity")));
				hshRecord.put("hidstate4",correctNull(rs.getString("comapp_admstate")));
				hshRecord.put("comapp_admphone",correctNull(rs.getString("comapp_admphone")));
				hshRecord.put("comapp_admfax",correctNull(rs.getString("comapp_admfax")));
				hshRecord.put("comapp_admpin",correctNull(rs.getString("comapp_admpin")));
				hshRecord.put("comapp_comtype",correctNull(rs.getString("comapp_comtype")));
				hshRecord.put("comapp_smetype",correctNull(rs.getString("comapp_ssitype")));
				hshRecord.put("comapp_scode",correctNull(rs.getString("comapp_org_scode")));	
				hshRecord.put("comapp_group",correctNull(rs.getString("groupdesc")));	
				hshRecord.put("comapp_rbino",correctNull(rs.getString("comapp_rbino")));
				hshRecord.put("comapp_subnbfc",correctNull(rs.getString("comapp_subnbfc")));
				hshRecord.put("auth_captial",correctNull(rs.getString("auth_captial")));
				hshRecord.put("company_status",correctNull(rs.getString("company_status")));
				hshRecord.put("company_staff",correctNull(rs.getString("company_staff")));
				hshRecord.put("company_inland",correctNull(rs.getString("company_inland")));
				hshRecord.put("company_introtitle",correctNull(rs.getString("company_introtitle")));
				hshRecord.put("company_introname",correctNull(rs.getString("company_introname")));
				hshRecord.put("comapp_regcountry",correctNull(rs.getString("comapp_regcountry")));
				hshRecord.put("comapp_subcapital",correctNull(rs.getString("comapp_subcapital")));
				hshRecord.put("comapp_totalshares",correctNull(rs.getString("comapp_totalshares")));
				hshRecord.put("cbs_companycode",correctNull(rs.getString("cbs_companycode")));
				hshRecord.put("comapp_oldid",correctNull(rs.getString("comapp_oldid")));
				hshRecord.put("comapp_pubtype",correctNull(rs.getString("comapp_pubtype")));
				hshRecord.put("comapp_orgname",correctNull(rs.getString("org_name")));
				hshRecord.put("regcountrydesc",correctNull(rs.getString("con_country")));	
				hshRecord.put("comapp_ieccode",correctNull(rs.getString("comapp_ieccode")));	
				hshRecord.put("comapp_irbid",correctNull(rs.getString("comapp_irbid")));
				hshRecord.put("hidPageType",correctNull((String)hshValues.get("hidPageType")));
				hshRecord.put("hidCategoryType",correctNull((String)hshValues.get("hidCategoryType")));
				hshRecord.put("hidSSIType",correctNull((String)hshValues.get("hidSSIType")));	
				hshRecord.put("comapp_cin",correctNull((String)rs.getString("comapp_cin")));	//Added By Gayathri.K for adding CIN in Customer Profile
				if(!cityregval.equalsIgnoreCase(""))
				{
					strQuery = SQLParser.getSqlQuery("selcitycode^"+ cityregval);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						cityregvalue = Helper.correctNull((String)rs1.getString(1));
						stateregvalue = Helper.correctNull((String)rs1.getString(2));
						if(!stateregvalue.equalsIgnoreCase(""))
						{
							strQuery = SQLParser.getSqlQuery("selstatecode^"+stateregvalue);
							rs1 = DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{
								statereg_value = Helper.correctNull((String)rs1.getString(1));
							}
						}
					}
				}
				hshRecord.put("comapp_regcity",cityregvalue);
				hshRecord.put("comapp_regstate",statereg_value);
				recordflag=true;
			}
			strQuery=SQLParser.getSqlQuery("checkapplnstatuscom^"+strComappid);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
				hshRecord.put("appstatus","true");
			}
			else
			{
				hshRecord.put("appstatus","false");
			}
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
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
				if(rs1 != null)
				{
					rs1.close();
				}
			}
			catch(Exception e1)
			{
				throw new EJBException("Error closing connection");
			}
		}
		return hshRecord;
	}

	public HashMap updateData(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strExp ="";
		String strAction=correctNull((String)hshValues.get("hidAction"));
		ResultSet  rs =null;
		String flag = "N";
		String strId="";
		String str_rbino=correctNull((String)hshValues.get("txt_rbino"));
		String str_subnbfc=correctNull((String)hshValues.get("subnbfc"));
		int count=0;
		
		try
		{
			if(strAction.equalsIgnoreCase("delete"))
			{
				strId=correctNull((String)hshValues.get("comapp_id"));
				rs=DBUtils.executeLAPSQuery("comappchkdemo^"+strId);
				while (rs.next())
				{				
					if(!((correctNull((String)rs.getString("app_delflag"))).equals("Y")))
					{
						count++;				
						break;
					}				
				}																
				if(count>0)
				{
					hshQuery.put("hidDemoId",correctNull((String)hshValues.get("comapp_id")));					
					strExp ="$Cannot delete this applicant master,it is used by applications";
					throw new EJBException(strExp);
				}
				else
				{
					hshQuery.put("strQueryId","del_applKYCNorms");
					arrValues.add(correctNull((String)hshValues.get("comapp_id")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","delfactorydetails_access");
					arrValues.add(correctNull((String)hshValues.get("comapp_id")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("2",hshQuery);
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","deldivisiondetails_access");
					arrValues.add(correctNull((String)hshValues.get("comapp_id")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("3",hshQuery);
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(correctNull((String)hshValues.get("comapp_id")));
					hshQuery.put("strQueryId","delreldetails_access"); 
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("4",hshQuery);
					
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","comappmasterdel");
					arrValues.add(correctNull((String)hshValues.get("comapp_id")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("5",hshQuery);
					hshQueryValues.put("size","5");
				}
			}
			if(strAction.equalsIgnoreCase("update"))
			{
				strId=correctNull((String)hshValues.get("comapp_id"));
				
				hshQuery.put("strQueryId","comappmasterupd");
				arrValues.add(correctNull((String)hshValues.get("comapp_companyname")).toUpperCase());
				arrValues.add(correctNull((String)hshValues.get("comapp_companyid")));
				arrValues.add(correctNull((String)hshValues.get("comapp_crptaddress1")));
				arrValues.add(correctNull((String)hshValues.get("comapp_crptaddress2")));
				arrValues.add(correctNull((String)hshValues.get("comapp_crptcity")));
				arrValues.add(correctNull((String)hshValues.get("comapp_crptstate")));
				arrValues.add(correctNull((String)hshValues.get("comapp_crptpin")));
				arrValues.add(correctNull((String)hshValues.get("comapp_crptphone")));
				arrValues.add(correctNull((String)hshValues.get("comapp_crptfax")));
				arrValues.add(correctNull((String)hshValues.get("comapp_businessnature")));
				arrValues.add(correctNull((String)hshValues.get("comapp_corpstructure")));
				arrValues.add(correctNull((String)hshValues.get("comapp_companyrole")));
				arrValues.add(correctNull((String)hshValues.get("comapp_yrsinbusiness")));
				arrValues.add(correctNull((String)hshValues.get("comapp_ownership")));
				arrValues.add(correctNull((String)hshValues.get("comapp_totemployees")));
				arrValues.add(correctNull((String)hshValues.get("comapp_contact")));
				arrValues.add(correctNull((String)hshValues.get("comapp_email")));
				arrValues.add(correctNull((String)hshValues.get("comapp_groupid")));
				arrValues.add(correctNull((String)hshValues.get("comapp_corppremises")));
				arrValues.add(correctNull((String)hshValues.get("comapp_regpremises")));
				arrValues.add(correctNull((String)hshValues.get("comapp_regadd1")));
				arrValues.add(correctNull((String)hshValues.get("comapp_regadd2")));
				arrValues.add(correctNull((String)hshValues.get("hidcity3")));
				arrValues.add(correctNull((String)hshValues.get("hidstate3")));
				arrValues.add(correctNull((String)hshValues.get("comapp_regphone")));
				arrValues.add(correctNull((String)hshValues.get("comapp_regfax")));
				arrValues.add(correctNull((String)hshValues.get("comapp_regpin")));
				arrValues.add(correctNull((String)hshValues.get("comapp_dealing")));
				arrValues.add(correctNull((String)hshValues.get("comapp_indcode")));
				arrValues.add(correctNull((String)hshValues.get("comapp_indtype")));				
				arrValues.add(correctNull((String)hshValues.get("scale")));
				arrValues.add(correctNull((String)hshValues.get("comapp_admadd1")));
				arrValues.add(correctNull((String)hshValues.get("comapp_admadd2")));
				arrValues.add(correctNull((String)hshValues.get("comapp_admcity")));
				arrValues.add(correctNull((String)hshValues.get("comapp_admstate")));
				arrValues.add(correctNull((String)hshValues.get("comapp_admphone")));
				arrValues.add(correctNull((String)hshValues.get("comapp_admfax")));
				arrValues.add(correctNull((String)hshValues.get("comapp_admpin")));
				
				if(Helper.correctNull((String)hshValues.get("comapp_commtype")).equalsIgnoreCase(""))
				{
					arrValues.add(correctNull((String)hshValues.get("comapp_type")));
				}
				else
				{
				arrValues.add(correctNull((String)hshValues.get("comapp_commtype")));
				}
				
				
				//arrValues.add(correctNull((String)hshValues.get("comapp_ssitype")));
				arrValues.add(correctNull((String)hshValues.get("comapp_smetype")));
				
				arrValues.add(correctNull((String)hshValues.get("comapp_scode")));
				arrValues.add(correctNull((String)hshValues.get("strOrgSelect")));
				
			    arrValues.add(str_rbino);
			    arrValues.add(str_subnbfc);
			    
			    arrValues.add(correctNull((String)hshValues.get("txt_captial")));
			    arrValues.add(correctNull((String)hshValues.get("comapp_cbsid")));
			    arrValues.add(correctNull((String)hshValues.get("sel_status")));
			    arrValues.add(correctNull((String)hshValues.get("sel_staff")));
			    arrValues.add(correctNull((String)hshValues.get("sel_inland")));
			    arrValues.add(correctNull((String)hshValues.get("txt_ititle")));
			    arrValues.add(correctNull((String)hshValues.get("hid_introname")));
			    arrValues.add(correctNull((String)hshValues.get("comapp_hidregcountry")));
			    arrValues.add(correctNull((String)hshValues.get("txt_subcapital")));
			    arrValues.add(correctNull((String)hshValues.get("comapp_totsharevalue")));
			    arrValues.add(correctNull((String)hshValues.get("sel_pubtype")));
			    arrValues.add(correctNull((String)hshValues.get("txt_ieccode")));
			    arrValues.add(correctNull((String)hshValues.get("txt_irbcode")));
			    arrValues.add(correctNull((String)hshValues.get("txt_cin")));//Added By Gayathri.K for adding CIN in Customer Profile
			    arrValues.add(strId);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
			}

			if(strAction.equalsIgnoreCase("insert"))
			{		
				hshValues.put("appflag","N");
				if(strAction.equalsIgnoreCase("insert"))
				{
					hshQuery.put("strQueryId","comappmasterins");
					strId=getId();
					hshValues.put("comapp_id",strId);
					arrValues.add(strId);
					arrValues.add(correctNull((String)hshValues.get("comapp_companyname")).toUpperCase());
					arrValues.add(correctNull((String)hshValues.get("comapp_companyid")));
					
					arrValues.add(correctNull((String)hshValues.get("comapp_crptaddress1")));
					arrValues.add(correctNull((String)hshValues.get("comapp_crptaddress2")));
					arrValues.add(correctNull((String)hshValues.get("comapp_crptcity")));
					arrValues.add(correctNull((String)hshValues.get("comapp_crptstate")));
					arrValues.add(correctNull((String)hshValues.get("comapp_crptpin")));
					arrValues.add(correctNull((String)hshValues.get("comapp_crptphone")));
					arrValues.add(correctNull((String)hshValues.get("comapp_crptfax")));
					
					arrValues.add(correctNull((String)hshValues.get("comapp_businessnature")));
					arrValues.add(correctNull((String)hshValues.get("comapp_corpstructure")));
					arrValues.add(correctNull((String)hshValues.get("comapp_companyrole")));
					arrValues.add(correctNull((String)hshValues.get("comapp_yrsinbusiness")));
					arrValues.add(correctNull((String)hshValues.get("comapp_ownership")));
					arrValues.add(correctNull((String)hshValues.get("comapp_totemployees")));
					arrValues.add(correctNull((String)hshValues.get("comapp_contact")));
					arrValues.add(correctNull((String)hshValues.get("comapp_email")));
					arrValues.add(correctNull((String)hshValues.get("comapp_groupid")));
					
					arrValues.add(correctNull((String)hshValues.get("comapp_corppremises")));
					arrValues.add(correctNull((String)hshValues.get("comapp_regpremises")));
					
					arrValues.add(correctNull((String)hshValues.get("comapp_regadd1")));
					arrValues.add(correctNull((String)hshValues.get("comapp_regadd2")));
					arrValues.add(correctNull((String)hshValues.get("hidcity3")));
					arrValues.add(correctNull((String)hshValues.get("hidstate3")));
					arrValues.add(correctNull((String)hshValues.get("comapp_regphone")));
					arrValues.add(correctNull((String)hshValues.get("comapp_regfax")));
					arrValues.add(correctNull((String)hshValues.get("comapp_regpin")));
					
					arrValues.add(correctNull((String)hshValues.get("comapp_indcode")));
					arrValues.add(correctNull((String)hshValues.get("comapp_dealing")));
					arrValues.add(correctNull((String)hshValues.get("comapp_indtype")));
					arrValues.add(correctNull((String)hshValues.get("comapp_commtype")));
					//arrValues.add(correctNull((String)hshValues.get("comapp_ssitype")));
					arrValues.add(correctNull((String)hshValues.get("comapp_smetype")));
					arrValues.add(correctNull((String)hshValues.get("comapp_scode")));
					arrValues.add(correctNull((String)hshValues.get("strOrgSelect")));
					arrValues.add(correctNull((String)hshValues.get("scale")));
					
					arrValues.add(correctNull((String)hshValues.get("comapp_admadd1")));
					arrValues.add(correctNull((String)hshValues.get("comapp_admadd2")));
					arrValues.add(correctNull((String)hshValues.get("comapp_admcity")));
					arrValues.add(correctNull((String)hshValues.get("comapp_admstate")));
					arrValues.add(correctNull((String)hshValues.get("comapp_admphone")));
					arrValues.add(correctNull((String)hshValues.get("comapp_admfax")));
					arrValues.add(correctNull((String)hshValues.get("comapp_admpin")));				
				   
					arrValues.add(str_rbino);
				    arrValues.add(str_subnbfc);
				    
				    arrValues.add(correctNull((String)hshValues.get("txt_captial")));
				    arrValues.add(correctNull((String)hshValues.get("comapp_cbsid")));
				    arrValues.add(correctNull((String)hshValues.get("sel_status")));
				    arrValues.add(correctNull((String)hshValues.get("sel_staff")));
				    arrValues.add(correctNull((String)hshValues.get("sel_inland")));
				    arrValues.add(correctNull((String)hshValues.get("txt_ititle")));
				    arrValues.add(correctNull((String)hshValues.get("hid_introname")));
				    arrValues.add(correctNull((String)hshValues.get("comapp_hidregcountry")));
				    arrValues.add(correctNull((String)hshValues.get("txt_subcapital")));
				    arrValues.add(correctNull((String)hshValues.get("comapp_totsharevalue")));
				    arrValues.add(strId);
				    arrValues.add(correctNull((String)hshValues.get("sel_pubtype")));
				    arrValues.add(correctNull((String)hshValues.get("txt_ieccode")));
				    arrValues.add(correctNull((String)hshValues.get("txt_irbcode")));
				    arrValues.add(correctNull((String)hshValues.get("txt_cin")));//Added By Gayathri.K for adding CIN in Customer Profile
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
				}
			}
			
			StringBuilder sbAuditTrial=new StringBuilder();
			
			if(correctNull((String)hshValues.get("comapp_commtype")).equalsIgnoreCase("CORP"))
			{
				sbAuditTrial.append("~Corporate Type =").append("Corporate");
			}
			else if(correctNull((String)hshValues.get("comapp_commtype")).equalsIgnoreCase("SME"))
			{
				sbAuditTrial.append("~Corporate Type =").append("SME");
				
			}
			sbAuditTrial.append("~SME Type =");
			if(correctNull((String)hshValues.get("comapp_smetype")).equalsIgnoreCase("1"))
			{
				sbAuditTrial.append("Micro");
			}
			else if(correctNull((String)hshValues.get("comapp_smetype")).equalsIgnoreCase("2"))
			{
				sbAuditTrial.append("Small");
			}
			else if(correctNull((String)hshValues.get("comapp_smetype")).equalsIgnoreCase("3"))
			{
				sbAuditTrial.append("Medium");
			}
			else
			{
				sbAuditTrial.append("");
			}
			
			sbAuditTrial.append("~Company Name =").append(correctNull((String)hshValues.get("comapp_companyname")))
				.append("~Industry BSR Code =").append(correctNull((String)hshValues.get("comapp_companyid")))
				.append("~CBS Customer ID =").append(correctNull((String)hshValues.get("comapp_cbsid")))
				.append("~IRB Company Code =").append(correctNull((String)hshValues.get("txt_irbcode")))
				.append("~Line of Activity =").append(correctNull((String)hshValues.get("comapp_businessnature")))
				.append("~PAN Number =").append(correctNull((String)hshValues.get("comapp_corpstructure")))
				.append("~ROC Number =").append(correctNull((String)hshValues.get("comapp_companyrole")))
				.append("~CIN =").append(correctNull((String)hshValues.get("txt_cin")))
				.append("~Date of Incorporation =").append(correctNull((String)hshValues.get("comapp_yrsinbusiness")))
				.append("~Total Employees =").append(correctNull((String)hshValues.get("comapp_totemployees")));
			sbAuditTrial.append("~Type of Ownership =");
			if(correctNull((String)hshValues.get("comapp_ownership")).equalsIgnoreCase("OO"))
			{
				sbAuditTrial.append("Others");
			}
			else if(correctNull((String)hshValues.get("comapp_ownership")).equalsIgnoreCase("IN"))
			{
				sbAuditTrial.append("Individual");
			}
			else if(correctNull((String)hshValues.get("comapp_ownership")).equalsIgnoreCase("OLP"))
			{
				sbAuditTrial.append("Private Limited Company");
			}
			else if(correctNull((String)hshValues.get("comapp_ownership")).equalsIgnoreCase("OCC"))
			{
				sbAuditTrial.append("Public Limited Company");
			}
			else if(correctNull((String)hshValues.get("comapp_ownership")).equalsIgnoreCase("OP"))
			{
				sbAuditTrial.append("Partnership");
			}
			else if(correctNull((String)hshValues.get("comapp_ownership")).equalsIgnoreCase("OLC"))
			{
				sbAuditTrial.append("Joint Borrowers");
			}
			else if(correctNull((String)hshValues.get("comapp_ownership")).equalsIgnoreCase("OS"))
			{
				sbAuditTrial.append("Sole Proprietor");
			}
			else if(correctNull((String)hshValues.get("comapp_ownership")).equalsIgnoreCase("Jo"))
			{
				sbAuditTrial.append("Joint Venture");
			}
			else if(correctNull((String)hshValues.get("comapp_ownership")).equalsIgnoreCase("sub"))
			{
				sbAuditTrial.append("Wholly owned subsidiary");
			}
			else if(correctNull((String)hshValues.get("comapp_ownership")).equalsIgnoreCase("TR"))
			{
				sbAuditTrial.append("Trusts");
			}
			else if(correctNull((String)hshValues.get("comapp_ownership")).equalsIgnoreCase("nbfc"))
			{
				sbAuditTrial.append("NBFC");
			}
			else if(correctNull((String)hshValues.get("comapp_ownership")).equalsIgnoreCase("HUF"))
			{
				sbAuditTrial.append("H.U.F");
			}
			else
			{
				sbAuditTrial.append("");
			}
			sbAuditTrial.append("~Group =").append(correctNull((String)hshValues.get("comapp_group")))
				.append("~Banking Since =").append(correctNull((String)hshValues.get("comapp_dealing")))
				.append("~Contact Name =").append(correctNull((String)hshValues.get("comapp_contact")));
			sbAuditTrial.append("~Industry Type =");
			if(correctNull((String)hshValues.get("scale")).equalsIgnoreCase("1"))
			{
				sbAuditTrial.append("Services");
			}
			else if(correctNull((String)hshValues.get("scale")).equalsIgnoreCase("2"))
			{
				sbAuditTrial.append("Exports");
			}
			else if(correctNull((String)hshValues.get("scale")).equalsIgnoreCase("3"))
			{
				sbAuditTrial.append("Agriculture");
			}
			else if(correctNull((String)hshValues.get("scale")).equalsIgnoreCase("4"))
			{
				sbAuditTrial.append("Infrastructure");
			}
			else if(correctNull((String)hshValues.get("scale")).equalsIgnoreCase("Trading"))
			{
				sbAuditTrial.append("Trading");
			}
			else if(correctNull((String)hshValues.get("scale")).equalsIgnoreCase("Manufacturing"))
			{
				sbAuditTrial.append("Manufacturing");
			}
			else
			{
				sbAuditTrial.append("");
			}
			sbAuditTrial.append("~Email Address =").append(correctNull((String)hshValues.get("comapp_email")))
				.append("~Application Recd. From  =").append(correctNull((String)hshValues.get("comapp_orgname")))
				.append("~Registered Office Address =").append(correctNull((String)hshValues.get("comapp_regadd1")))
				.append("~Registered Office Address2 =").append(correctNull((String)hshValues.get("comapp_regadd2")))
				.append("~Registered Office City =").append(correctNull((String)hshValues.get("comapp_regcity")))
				.append("~Registered Office State =").append(correctNull((String)hshValues.get("comapp_regstate")))
				.append("~Registered Office Pin Code=").append(correctNull((String)hshValues.get("comapp_regpin")))
				.append("~Registered Office Country =").append(correctNull((String)hshValues.get("comapp_regcountry")))
				.append("~Registered Office Phone No. =").append(correctNull((String)hshValues.get("comapp_regphone")))
				.append("~Registered Office Fax No =").append(correctNull((String)hshValues.get("comapp_regfax")));
			if(correctNull((String)hshValues.get("comapp_regpremises")).equalsIgnoreCase("1"))
			{
				sbAuditTrial.append("~Registered Office Premises =").append("Owned");
			}
			else if(correctNull((String)hshValues.get("comapp_regpremises")).equalsIgnoreCase("2"))
			{
				sbAuditTrial.append("~Registered Office Premises =").append("Leased");
			}
			else if(correctNull((String)hshValues.get("comapp_regpremises")).equalsIgnoreCase("3"))
			{
				sbAuditTrial.append("~Registered Office Premises =").append("Rented");
			}
			else
			{
				sbAuditTrial.append("~Registered Office Premises =").append("");
			}
				 
			sbAuditTrial.append("~Corporate Office Address =").append(correctNull((String)hshValues.get("comapp_crptaddress1")))
			.append("~Corporate Office Address2 =").append(correctNull((String)hshValues.get("comapp_crptaddress2")))
			.append("~Corporate Office City =").append(correctNull((String)hshValues.get("comapp_crptcity")))
			.append("~Corporate Office State =").append(correctNull((String)hshValues.get("comapp_crptstate")))
			.append("~Corporate Office Pin Code=").append(correctNull((String)hshValues.get("comapp_crptpin")))
			//.append("~Corporate Office Country =").append(correctNull((String)hshValues.get("comapp_regcountry")))
			.append("~Corporate Office Phone No. =").append(correctNull((String)hshValues.get("comapp_crptphone")))
			.append("~Corporate Office Fax No =").append(correctNull((String)hshValues.get("comapp_crptfax")));
			if(correctNull((String)hshValues.get("comapp_corppremises")).equalsIgnoreCase("1"))
			{
				sbAuditTrial.append("~Corporate Office Premises =").append("Owned");
			}
			else if(correctNull((String)hshValues.get("comapp_corppremises")).equalsIgnoreCase("2"))
			{
				sbAuditTrial.append("~Corporate Office Premises =").append("Leased");
			}
			else if(correctNull((String)hshValues.get("comapp_corppremises")).equalsIgnoreCase("3"))
			{
				sbAuditTrial.append("~Corporate Office Premises =").append("Rented");
			}
			else
			{
				sbAuditTrial.append("~Corporate Office Premises =").append("");
			}
			 	
			sbAuditTrial.append("~Administrative Office Address =").append(correctNull((String)hshValues.get("comapp_admadd1")))
			.append("~Administrative Office Address2 =").append(correctNull((String)hshValues.get("comapp_admadd2")))
			.append("~Administrative Office City =").append(correctNull((String)hshValues.get("comapp_admcity")))
			.append("~Administrative Office State =").append(correctNull((String)hshValues.get("comapp_admstate")))
			.append("~Administrative Office Pin Code=").append(correctNull((String)hshValues.get("comapp_admpin")))
			//.append("~Corporate Office Country =").append(correctNull((String)hshValues.get("comapp_regcountry")))
			.append("~Administrative Office Phone No. =").append(correctNull((String)hshValues.get("comapp_admphone")))
			.append("~Administrative Office Fax No =").append(correctNull((String)hshValues.get("comapp_admfax")));
			
			if(correctNull((String)hshValues.get("txt_ititle")).equalsIgnoreCase("MR"))
			{
				sbAuditTrial.append("~Introducer Title =").append("Mr.");
			}
			else if(correctNull((String)hshValues.get("txt_ititle")).equalsIgnoreCase("MS"))
			{
				sbAuditTrial.append("~Introducer Title =").append("Ms.");
			}
			else if(correctNull((String)hshValues.get("txt_ititle")).equalsIgnoreCase("MRS"))
			{
				sbAuditTrial.append("~Introducer Title =").append("Mrs.");
			}
			else if(correctNull((String)hshValues.get("txt_ititle")).equalsIgnoreCase("M/S"))
			{
				sbAuditTrial.append("~Introducer Title =").append("M/s.");
			}
			else
			{
				sbAuditTrial.append("~Introducer Title =").append("");
			}
			
			sbAuditTrial.append("~Introducer Name  =").append(correctNull((String)hshValues.get("txt_introname")));
			if(correctNull((String)hshValues.get("sel_staff")).equalsIgnoreCase("Y"))
			{
				sbAuditTrial.append("~Trade Finance  =").append("Yes");
				sbAuditTrial.append("~IEC Code =").append(correctNull((String)hshValues.get("txt_ieccode")));
			}
			else if(correctNull((String)hshValues.get("sel_staff")).equalsIgnoreCase("N"))
			{
				sbAuditTrial.append("~Trade Finance  =").append("No");
			}
			else
			{
				sbAuditTrial.append("~Trade Finance  =").append("");
			}
			sbAuditTrial.append("~Status =").append(correctNull((String)hshValues.get("hidstatus")));
			
			if(correctNull((String)hshValues.get("sel_inland")).equalsIgnoreCase("Y"))
			{
				sbAuditTrial.append("~If Trade Finance yes Inland trade allowed =").append("Yes");
			}
			else if(correctNull((String)hshValues.get("sel_inland")).equalsIgnoreCase("N"))
			{
				sbAuditTrial.append("~If Trade Finance yes Inland trade allowed =").append("No");
			}
			else
			{
				sbAuditTrial.append("~If Trade Finance yes Inland trade allowed =").append("");
			}
		if(flag.equals("N"))
			{
				AuditTrial.auditLog(hshValues,"319",strId,sbAuditTrial.toString());
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				hshValues=getData(hshValues);
			}
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage()+strExp);
			
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
				throw new EJBException("Error closing connection");
			}
		}
		if(strAction.equalsIgnoreCase("insert"))
		{
			return hshValues;
		}
		else
		{
			return null;
		}
	}

	public String getId() throws Exception
	{
		ResultSet rs=null;
		//String strId="1";
		String strAppCodeper="";
		String strAppCodecom="";
		String strAppCode="";
		try
		{
			/*
			 * rs=DBUtils.executeLAPSQuery("comappmastergetid");
			 */
			
			
			
			/*rs=DBUtils.executeLAPSQuery("mastgetAppid");
			if(rs.next())
			{
				strId=rs.getString(1);
			}*/
			rs=DBUtils.executeLAPSQuery("mastgetAppid");			 
			if(rs.next())
			{
				strAppCodeper=rs.getString(1);
			}
			/*rs=DBUtils.executeLAPSQuery("comappmastergetid");			 
			if(rs.next())
			{
				strAppCodecom=rs.getString(1);
			}
			if(Integer.parseInt(strAppCodeper)<Integer.parseInt(strAppCodecom))
				strAppCode=strAppCodecom;
			else*/
				strAppCode=strAppCodeper;
		}
		catch(Exception e)
		{
			throw new Exception("Error getting applicant id.."+e);
		}
		finally
		{
			if(rs != null)
			{
				rs.close();
			}
		}
		return strAppCode;
	}

	
	
	public HashMap getFactoryDetails(HashMap hshValues) 
	{
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String comapp_id="";
   	 	boolean recordflag=false;
   	 	String strAppStatus="";
   	 	String strDistcode="";
   	 	String strDistDesc="";
   	 	String strCitycode="";
	 	String strCityDesc="";
	 	String strStatecode="";
   	 	String strStateDesc="";
   	 	ResultSet rs1=null;
   		ResultSet rs2=null;
   		ResultSet rs3=null;
		try
		{
			strAppStatus=Helper.correctNull((String)hshValues.get("hidappstatus"));
			
			comapp_id= correctNull((String)hshValues.get("hidapplicantnewid"));
			if(comapp_id.equalsIgnoreCase("")){
				comapp_id= correctNull((String)hshValues.get("txtperapp_appid"));
			}
			if(comapp_id.equalsIgnoreCase("")){
				comapp_id= correctNull((String)hshValues.get("hidDemoId"));
			}
			rs=DBUtils.executeLAPSQuery("selallfactorydetails^"+comapp_id);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull((String)rs.getString("comapp_id")));//0
				arrCol.add(correctNull((String)rs.getString("comapp_sno")));//1
				arrCol.add(correctNull((String)rs.getString("comapp_detailtype")));//2
				arrCol.add(correctNull((String)rs.getString("comapp_name")));//3
				arrCol.add(correctNull((String)rs.getString("comapp_add")));//4			
				strCitycode = Helper.correctNull((String)rs.getString("comapp_city"));//5	
				if(!strCitycode.equalsIgnoreCase(""))
				{				
				if(rs1!=null)
				{
					rs1.close();
				}
				rs1=DBUtils.executeLAPSQuery("sel_citynamebycode^"+strCitycode);
				if(rs1.next())
				{
					
					strCityDesc = Helper.correctNull((String)rs1.getString("city_name"));					
				}
				}
				arrCol.add(strCitycode);//5
				arrCol.add(strCityDesc);//6
				
				strStatecode = Helper.correctNull((String)rs.getString("comapp_state"));	
				if(!strStatecode.equalsIgnoreCase(""))
				{				
				if(rs2!=null)
				{
					rs2.close();
				}
				rs2=DBUtils.executeLAPSQuery("sel_statenamebycode^"+strStatecode);
				if(rs2.next())
				{
					
					strStateDesc = Helper.correctNull((String)rs2.getString("state_name"));					
				}
				}
				arrCol.add(strStatecode);//7
				arrCol.add(strStateDesc);//8
				
				
				arrCol.add(correctNull((String)rs.getString("comapp_pincode")));//9
				arrCol.add(correctNull((String)rs.getString("comapp_phoneno")));//10
				arrCol.add(correctNull((String)rs.getString("comapp_fax")));//11
				arrCol.add(correctNull((String)rs.getString("comapp_factpremises")));//12
				strDistcode = Helper.correctNull((String)rs.getString("comapp_dist"));//13
							
				if(!strDistcode.equalsIgnoreCase(""))
				{				
				if(rs3!=null)
				{
					rs3.close();
				}
				rs3=DBUtils.executeLAPSQuery("sel_distnamebycode^"+strDistcode);
				if(rs3.next())
				{
					
					strDistDesc = Helper.correctNull((String)rs3.getString("district_desc"));//15					
				}
				}
				arrCol.add(strDistcode);//13
				arrCol.add(strDistDesc);	//14	
				arrCol.add(Helper.correctNull((String)rs.getString("comapp_Leaserentage")));//15
				arrRow.add(arrCol);
				recordflag=true;
			}			
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("comapp_id",comapp_id);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
			
			/*HashMap prof=new HashMap();
			HashMap profile=new HashMap();
			prof.put("profile_id",comapp_id);
			
			profile = (HashMap) EJBInvoker.executeStateLess("mastapplicant",
					prof, "getCustomerProfileStatus");
			*/
			MastApplicantBean mast=new MastApplicantBean();
			HashMap prof=new HashMap();
			HashMap profile=new HashMap();
			prof.put("profile_id",comapp_id);
			profile=(HashMap)mast.getCustomerProfileStatus(prof);
			hshRecord.put("strIncompletepage", Helper.correctNull((String)profile.get("strIncompletepage")));
			
			String strProfilestatus="";
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("getprofilestatusfromdemographic^"+comapp_id);
			if(rs.next())
			{
				strProfilestatus=Helper.correctNull((String)rs.getString("perapp_profilestatus"));
			}
			hshRecord.put("strProfilestatus",strProfilestatus);
			hshRecord.put("appstatus",strAppStatus);
		}
		catch(Exception e1)
		{
			throw new EJBException(e1.getMessage());
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
	
	public void updateFactoryDetails(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strsno ="";
		ResultSet rs=null;
		String strAction=(String)hshValues.get("hidAction");
		StringBuilder sbolddata=new StringBuilder();
		String strCityCode="";
		String strDistCode="";
		String strStateCode="";
		String strCityDesc="";
		String strDistDesc="";
		String strStateDesc="";
		try
		{
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			String comapp_id= correctNull((String)hshValues.get("txtperapp_appid"));	
			strsno=correctNull((String)hshValues.get("comapp_sno"));
			MastApplicantBean MAB=new MastApplicantBean();
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("Delete"))
			{
				String strQuery=SQLParser.getSqlQuery("selallfactorydetailsbysno^"+strsno+"^"+comapp_id);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					/***
					 * For Audit Trial Old Data - By Karthikeyan.S on 17/09/2013
					 */
					String strCityCodeOldAudit=Helper.correctNull(rs.getString("comapp_city"));
					String strDistCodeOldAudit=Helper.correctNull(rs.getString("comapp_dist"));
					String strStateCodeOldAudit=Helper.correctNull(rs.getString("comapp_state"));
					String strCityDescOldAudit=MAB.getCityDistrictStateDesc("city",strCityCodeOldAudit);
					String strDistDescOldAudit=MAB.getCityDistrictStateDesc("district",strDistCodeOldAudit);
					String strStateDescOldAudit=MAB.getCityDistrictStateDesc("state",strStateCodeOldAudit);
					if(correctNull(rs.getString("comapp_detailtype")).equals("1"))
					{
						sbolddata.append("Select =").append("Factory");
					}
					else if(correctNull(rs.getString("comapp_detailtype")).equals("2"))
					{
						sbolddata.append("Select =").append("Branches");
					}
					else if(correctNull(rs.getString("comapp_detailtype")).equals("3"))
					{
						sbolddata.append("Select =").append("Godown");
					}
					else if(correctNull(rs.getString("comapp_detailtype")).equals("4"))
					{
						sbolddata.append("Select =").append("Sales depots/ Outlets");
					}
					sbolddata.append(" ~Name of the Factory/Branches/ Godown = ").append(correctNull(rs.getString("comapp_name")));
					sbolddata.append(" ~City = ").append(strCityDescOldAudit);
					sbolddata.append(" ~District = ").append(strDistDescOldAudit);
					sbolddata.append(" ~State = ").append(strStateDescOldAudit);
					sbolddata.append(" ~Pin Code= ").append(correctNull(rs.getString("comapp_pincode")));
					sbolddata.append(" ~Phone No = ").append(correctNull(rs.getString("comapp_phoneno")));
					sbolddata.append(" ~Fax = ").append(correctNull(rs.getString("comapp_fax")));
					if(correctNull(rs.getString("comapp_factpremises")).equals("1"))
					{
						sbolddata.append(" ~Premises = ").append("Owned");
					}
					else if(correctNull(rs.getString("comapp_factpremises")).equals("2"))
					{
						sbolddata.append(" ~Premises = ").append("Leased");
					}
					else if(correctNull(rs.getString("comapp_factpremises")).equals("3"))
					{
						sbolddata.append(" ~Premises = ").append("Rented");
					}
					else
					{
						sbolddata.append(" ~Premises = ").append("");
					}
					/***
					 * End - Audit Trial Old Data
					 */
				}
			}
			if(strAction.equalsIgnoreCase("Delete"))
			{
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","delfactorydetails");
				arrValues.add(comapp_id);
				arrValues.add(correctNull((String)hshValues.get("comapp_sno")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("Insert"))
			{
				rs=DBUtils.executeLAPSQuery("selmaxsnofactorydetails^"+correctNull((String)hshValues.get("txtperapp_appid")));
				if(rs.next())
				{
					strsno = correctNull((String)rs.getString("snomax"));
				}
				else
				{
					strsno = "1";
				}
				hshQueryValues.put("size","1");	
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insfactorydetails");
				arrValues.add(comapp_id);
				arrValues.add(strsno);
				arrValues.add(correctNull((String)hshValues.get("seltype")));
				arrValues.add(correctNull((String)hshValues.get("comapp_name")));
				arrValues.add(correctNull((String)hshValues.get("comapp_address")));	
				arrValues.add(correctNull((String)hshValues.get("hid_city")));
				arrValues.add(correctNull((String)hshValues.get("hid_state")));
				arrValues.add(correctNull((String)hshValues.get("comapp_pin")));
				arrValues.add(correctNull((String)hshValues.get("comapp_ph")));
				arrValues.add(correctNull((String)hshValues.get("comapp_fax")));
				arrValues.add(correctNull((String)hshValues.get("comapp_factpremises")));
				arrValues.add(correctNull((String)hshValues.get("hid_dist")));
				arrValues.add(correctNull((String)hshValues.get("txt_leaserentdate")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");				
			}
			else if(strAction.equalsIgnoreCase("Update"))
			{
				hshQueryValues.put("size","1");	
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","updfactorydetails");
				
				arrValues.add(correctNull((String)hshValues.get("seltype")));
				arrValues.add(correctNull((String)hshValues.get("comapp_name")));
				arrValues.add(correctNull((String)hshValues.get("comapp_address")));
				arrValues.add(correctNull((String)hshValues.get("hid_city")));
				arrValues.add(correctNull((String)hshValues.get("hid_state")));
				arrValues.add(correctNull((String)hshValues.get("comapp_pin")));
				arrValues.add(correctNull((String)hshValues.get("comapp_ph")));
				arrValues.add(correctNull((String)hshValues.get("comapp_fax")));
				arrValues.add(correctNull((String)hshValues.get("comapp_factpremises")));
				arrValues.add(correctNull((String)hshValues.get("hid_dist")));
				arrValues.add(correctNull((String)hshValues.get("txt_leaserentdate")));
				arrValues.add(correctNull((String)hshValues.get("txtperapp_appid")));
				arrValues.add(correctNull((String)hshValues.get("comapp_sno")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");				
			}
			/***
			 * For Audit Trial New Data - By Karthikeyan.S on 17/09/2013
			 */
			StringBuilder sbAt = new StringBuilder();
			strCityCode=Helper.correctNull((String)hshValues.get("hid_city"));
			strDistCode=Helper.correctNull((String)hshValues.get("hid_dist"));
			strStateCode=Helper.correctNull((String)hshValues.get("hid_state"));
			strCityDesc=MAB.getCityDistrictStateDesc("city",strCityCode);
			strDistDesc=MAB.getCityDistrictStateDesc("district",strDistCode);
			strStateDesc=MAB.getCityDistrictStateDesc("state",strStateCode);
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update")){
							
			if(correctNull((String)hshValues.get("seltype")).equals("1"))
			{
				sbAt.append("Select =").append("Factory");
			}
			else if(correctNull((String)hshValues.get("seltype")).equals("2"))
			{
				sbAt.append("Select =").append("Branches");
			}
			else if(correctNull((String)hshValues.get("seltype")).equals("3"))
			{
				sbAt.append("Select =").append("Godown");
			}
			else if(correctNull((String)hshValues.get("seltype")).equals("4"))
			{
				sbAt.append("Select =").append("Sales depots/ Outlets");
			}
			sbAt.append(" ~Name of the Factory/Branches/ Godown = ").append(correctNull((String)hshValues.get("comapp_name")));
			sbAt.append(" ~City = ").append(strCityDesc);
			sbAt.append(" ~District = ").append(strDistDesc);
			sbAt.append(" ~State = ").append(strStateDesc);
			sbAt.append(" ~Pin Code= ").append(correctNull((String)hshValues.get("comapp_pin")));
			sbAt.append(" ~Phone No = ").append(correctNull((String)hshValues.get("comapp_ph")));
			sbAt.append(" ~Fax = ").append(correctNull((String)hshValues.get("comapp_fax")));
			
			if(correctNull((String)hshValues.get("comapp_factpremises")).equals("1"))
			{
				sbAt.append(" ~Premises = ").append("Owned");
			}
			else if(correctNull((String)hshValues.get("comapp_factpremises")).equals("2"))
			{
				sbAt.append(" ~Premises = ").append("Leased");
			}
			else if(correctNull((String)hshValues.get("comapp_factpremises")).equals("3"))
			{
				sbAt.append(" ~Premises = ").append("Rented");
			}
			else
			{
				sbAt.append(" ~Premises = ").append("");
			}
		  }
			AuditTrial.auditNewLog(hshValues,"210",comapp_id,sbAt.toString(),sbolddata.toString());
			/***
			 * End - Audit Trial New Data
			 */
		}
		catch(Exception e1)
		{
			throw new EJBException(e1.getMessage());
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
	
	public HashMap getrocdetails(HashMap hshValues) 
	{
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String comapp_id="";
		String strappno=correctNull((String)hshValues.get("appno"));
		String strInwardno=correctNull((String)hshValues.get("inwardno"));
		String strSaral = correctNull((String)hshValues.get("hidsaral"));
		boolean recordflag=false;
		try
		{
			if(strSaral.equals("saral"))
			{			
				rs=DBUtils.executeLAPSQuery("selallrocbyiwardno^"+strInwardno);	
			}
			else
			{			
				rs=DBUtils.executeLAPSQuery("selallroc^"+strappno);	
			}
			
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull((String)rs.getString("comapp_id")));
				vecCol.add(correctNull((String)rs.getString("comapp_date")));
				vecCol.add(correctNull((String)rs.getString("comapp_date2")));
				vecCol.add(correctNull((String)rs.getString("comapp_date3")));
				vecCol.add(correctNull((String)rs.getString("comapp_mod")));
				vecCol.add(correctNull((String)rs.getString("comapp_details")));
				vecCol.add(correctNull((String)rs.getString("comapp_mod2")));
				vecCol.add(correctNull((String)rs.getString("comapp_date4")));
				vecCol.add(correctNull((String)rs.getString("comapp_amtofcreat")));
				vecRow.add(vecCol);
				recordflag=true;
			}			
			hshRecord.put("vecRow",vecRow);
			hshRecord.put("comapp_id",comapp_id);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
		}
		catch(Exception e1)
		{
			throw new EJBException(e1.getMessage());
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
	
	public void updaterocdetails(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		StringBuilder sbolddata=new StringBuilder();
	
		ResultSet rs=null;

		String strAction=((String)hshValues.get("hidAction"));
		String strAppno=correctNull((String)hshValues.get("appno"));
		String strhidstrno=correctNull((String)hshValues.get("hid_strsno"));
		String strInwardno=correctNull((String)hshValues.get("inwardno"));
		String strSaral = correctNull((String)hshValues.get("hidsaral"));	
		
		String strsno="";
		try
		{
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				String strQuery=SQLParser.getSqlQuery("selallrocbyiwardno^"+strInwardno+"^"+strhidstrno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					sbolddata.append("Date of Initial Creation  =").append(correctNull(rs.getString("comapp_date")))
					.append("~Amount of Creation =").append(correctNull(rs.getString("comapp_amtofcreat")))
					.append("~Modification of Charge =").append(correctNull(rs.getString("comapp_mod2")))
					.append("~Modification of Date =").append(correctNull(rs.getString("comapp_date4")))
					.append("~Satisfaction of Charge, if any =").append(correctNull(rs.getString("comapp_mod")))
					.append("~Satisfaction of Date, if any =").append(correctNull(rs.getString("comapp_date2")))
					.append("~Latest Search Report Date  =").append(correctNull(rs.getString("comapp_date3")));
				}
			}
			if(strAction.equalsIgnoreCase("Delete"))
			{
				arrValues.add(strhidstrno);
				
				if(strSaral.equals("saral")) //for deleting from loan application register
				{
					arrValues.add(strInwardno);					
				}
				else
				{
					arrValues.add(strAppno);
				}
					
				hshQueryValues.put("size","1");
				if(strSaral.equals("saral"))
				{
					hshQuery.put("strQueryId","delrocbyinwardno");				
				}
				else
				{
					hshQuery.put("strQueryId","delroc");
				}
				
								
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			else if(strAction.equalsIgnoreCase("Update"))
			{
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
								
				if(strSaral.equals("saral"))
				{					
					hshQuery.put("strQueryId","updrocbyinwardno");
				}
				else
				{
					
					hshQuery.put("strQueryId","updroc");
				}
				
				arrValues.add(correctNull((String)hshValues.get("comapp_date")));
				arrValues.add(correctNull((String)hshValues.get("comapp_date2")));
				arrValues.add(correctNull((String)hshValues.get("comapp_date3")));				
				arrValues.add(correctNull((String)hshValues.get("comapp_mod")));
				arrValues.add(correctNull((String)hshValues.get("comapp_details")));
				arrValues.add(correctNull((String)hshValues.get("comapp_mod2")));
				arrValues.add(correctNull((String)hshValues.get("comapp_date4")));
				arrValues.add(correctNull((String)hshValues.get("comapp_amtofcreat")));
				arrValues.add(strInwardno);
				//arrValues.add(correctNull((String)hshValues.get("comapp_id")));
				arrValues.add(strhidstrno);
				if(strSaral.equals("saral"))
				{
					arrValues.add(strInwardno);				
				}
				else
				{
					arrValues.add(strAppno);					
				}				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");				
			}
			else if(strAction.equalsIgnoreCase("insert"))
			{
				
				
				if(strSaral.equals("saral"))
				{
					rs=DBUtils.executeLAPSQuery("sel_maxsrocdetailsbyiwardno^"+strInwardno);
					
				}
				else
				{
					rs=DBUtils.executeLAPSQuery("sel_maxsrocdetails^"+strAppno);
					
				}			
				
				if(rs.next())
				{
					strsno = correctNull((String)rs.getString("snomax"));
				}
				else
				{
					strsno = "1";
				}
				
				
				hshQueryValues.put("size","1");
				
			
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","insroc");
				arrValues.add(strsno);
				arrValues.add(correctNull((String)hshValues.get("comapp_date")));
				arrValues.add(correctNull((String)hshValues.get("comapp_date2")));
				arrValues.add(correctNull((String)hshValues.get("comapp_date3")));				
				arrValues.add(correctNull((String)hshValues.get("comapp_mod")));
				arrValues.add(correctNull((String)hshValues.get("comapp_details")));
				arrValues.add(correctNull((String)hshValues.get("comapp_mod2")));
				arrValues.add(correctNull((String)hshValues.get("comapp_date4")));
				arrValues.add(correctNull((String)hshValues.get("comapp_amtofcreat")));
				arrValues.add(strAppno);
				arrValues.add(strInwardno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");				
			}
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("Update") ||  strAction.equalsIgnoreCase("insert")){
			sbAuditTrial.append("Date of Initial Creation  =").append(correctNull((String)hshValues.get("comapp_date"))).append("~Amount of Creation =").append(correctNull((String)hshValues.get("comapp_amtofcreat")))
			.append("~Modification of Charge =").append(correctNull((String)hshValues.get("comapp_mod2"))).append("~Modification of Date =").append(correctNull((String)hshValues.get("comapp_date4")))
			.append("~Satisfaction of Charge, if any =").append(correctNull((String)hshValues.get("comapp_mod"))).append("~Satisfaction of Date, if any =").append(correctNull((String)hshValues.get("comapp_date2")))
			.append("~Latest Search Report Date  =").append(correctNull((String)hshValues.get("comapp_date3")));
			}
			if(strSaral.equals("saral"))
			{
				AuditTrial.auditNewLog(hshValues,"159",strInwardno,sbAuditTrial.toString(),sbolddata.toString());
			}
			else
			{
			AuditTrial.auditNewLog(hshValues,"159",strAppno,sbAuditTrial.toString(),sbolddata.toString());
			}
			
		}
		
		catch(Exception e1)
		{
			throw new EJBException(e1.getMessage());
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
	public HashMap getreldetails(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		String comapp_id="";
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		ResultSet rs = null;
		String recordflag="N";
		try
		{
			comapp_id= correctNull((String)hshValues.get("comapp_id"));		
			rs=DBUtils.executeLAPSQuery("selreldetails^"+comapp_id);
			while(rs.next())
			{
				recordflag="Y";
				vecCol = new ArrayList();
				vecCol.add(correctNull((String)rs.getString("comapp_id")));
				vecCol.add(correctNull((String)rs.getString("comapp_emprelno")));
				vecCol.add(correctNull((String)rs.getString("comapp_borrel")));
				vecCol.add(correctNull((String)rs.getString("comapp_scale")));
				vecCol.add(correctNull((String)rs.getString("comapp_placepost")));
				vecCol.add(correctNull((String)rs.getString("comapp_loancomments")));
				vecCol.add(correctNull((String)rs.getString("comapp_relsno")));
				
				vecRow.add(vecCol);
			}			
			hshRecord.put("vecRow",vecRow);
			hshRecord.put("recordflag",recordflag);
			//hshRecord.put("comapp_id",comapp_id);
			
		}
		catch(Exception e1)
		{
			throw new EJBException(e1.getMessage());
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
		hshRecord.put("comapp_id",comapp_id);
		
		return hshRecord;
	}
	public void updatereldetails(HashMap hshValues)
	{
		ResultSet rs = null;
		String strQuery=null;
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues = new ArrayList();
		StringBuilder sbolddata=new StringBuilder();
		String strsno ="";
		HashMap hshQuery = new HashMap();
		try
		{
			String strAction =Helper.correctNull((String)hshValues.get("hidAction"));
			String strcomappid=Helper.correctNull((String)hshValues.get("comapp_id"));
			String strempno=Helper.correctNull((String)hshValues.get("txt_empno"));
			String strborrel=Helper.correctNull((String)hshValues.get("txt_borrel"));
			String strscale=Helper.correctNull((String)hshValues.get("txt_scale"));
			String strplacepost=Helper.correctNull((String)hshValues.get("txt_placepost"));
			String strloancomments=Helper.correctNull((String)hshValues.get("txt_loancomments"));
			strsno=Helper.correctNull((String)hshValues.get("comapp_sno"));
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				strQuery=SQLParser.getSqlQuery("selreldetailsbysno^"+strsno+"^"+strcomappid);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					/***
					 * For Audit Trial Old Data - By Karthikeyan.S on 12/09/2013
					 */
					sbolddata.append("Employee No =").append(correctNull(rs.getString("comapp_emprelno")));
					sbolddata.append(" ~Relationship with the Borrower = ").append(correctNull(rs.getString("comapp_borrel")));
					sbolddata.append(" ~Scale/Grade = ").append(correctNull(rs.getString("comapp_scale")));
					sbolddata.append(" ~Place of posting = ").append(correctNull(rs.getString("comapp_placepost")));
					/***
					 * End - Audit Trial Old Data
					 */
					
				}
			}
					
			if(strAction.equalsIgnoreCase("insert"))
			{
				strQuery="selmaxsrelation^"+strcomappid;
				rs=DBUtils.executeLAPSQuery(strQuery);
				if(rs.next())
				{
					strsno=Helper.correctNull((String)rs.getString("snorelmax"));
				}
				 hshQueryValues = new HashMap();
				 								 
				 hshQuery=new HashMap();
				 hshQuery.put("strQueryId","insreldetails"); 
				 arrValues.add(strcomappid);
				 arrValues.add(strempno);
				 arrValues.add(strborrel);
				 arrValues.add(strscale);
				 arrValues.add(strplacepost);
				 arrValues.add(strloancomments);
				 arrValues.add(strsno); 
				 
				 hshQuery.put("arrValues",arrValues);
				 hshQueryValues.put("1",hshQuery);
				 hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				 hshQueryValues = new HashMap();
				 								 
				 hshQuery=new HashMap();
				 hshQuery.put("strQueryId","updreldetails"); 
				 arrValues.add(strempno);
				 arrValues.add(strborrel);
				 arrValues.add(strscale);
				 arrValues.add(strplacepost);
				 arrValues.add(strloancomments);
				 arrValues.add(strcomappid);
				 arrValues.add(strsno);
				 
				 
				 hshQuery.put("arrValues",arrValues);
				 hshQueryValues.put("1",hshQuery);
				 hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
			else if(strAction.equalsIgnoreCase("Delete"))
			{
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
		  		hshQuery=new HashMap();
				hshQueryValues.put("size","1");
				arrValues.add(strcomappid);
				arrValues.add(strsno);
				hshQuery.put("strQueryId","delreldetails"); 
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			/** Audit Trial**/
			StringBuilder sbAt = new StringBuilder();
			/***
			 * For Audit Trial New Data - By Karthikeyan.S on 12/09/2013
			 */
			sbAt.append("Employee No =").append(correctNull((String)hshValues.get("txt_empno")));
			sbAt.append(" ~Relationship with the Borrower = ").append(correctNull((String)hshValues.get("txt_borrel")));
			sbAt.append(" ~Scale/Grade = ").append(correctNull((String)hshValues.get("txt_scale")));
			sbAt.append(" ~Place of posting = ").append(correctNull((String)hshValues.get("txt_placepost")));
			
			AuditTrial.auditNewLog(hshValues,"203",strcomappid,sbAt.toString(),sbolddata.toString());
			/***
			 * End - Audit Trial New Data
			 */
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updatereldetails "+e.getMessage());
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
	
		
		public void updateDivisionDetails(HashMap hshValues) 
		{
			HashMap hshQueryVal=new HashMap();
			HashMap hshQuery=new HashMap();
			ArrayList arrValues=new ArrayList();
			String strsno ="";
			ResultSet rs=null;
			ResultSet rs1=null;
			String strQuery="",strQuery1="";
			String strAction=(String)hshValues.get("hidAction");
			int intUpdatesize=0;
			StringBuilder sbolddata=new StringBuilder();
			
			try
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				String comapp_id=correctNull((String)hshValues.get("txtperapp_appid"));
				String strdivid=correctNull((String)hshValues.get("comapp_div_id"));
				String strOldID="";
				strOldID="";
				rs=DBUtils.executeLAPSQuery("get_perdemographics_oldid_renew^"+comapp_id);
				if(rs.next())
				{
					strOldID=Helper.correctNull((String)rs.getString("perapp_oldid"));
				}
				if(rs!=null){rs.close();}	
				if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("Delete"))
				{
					strQuery=SQLParser.getSqlQuery("seldivisiondetails_audittrial^"+strdivid+"^"+comapp_id);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						/***
						 * For Audit Trial Old Data - By Karthikeyan.S on 17/09/2013
						 */
						String strCityCodeOldAudit=Helper.correctNull(rs.getString("comapp_div_city"));
						String strDistCodeOldAudit=Helper.correctNull(rs.getString("comapp_div_dist"));
						String strStateCodeOldAudit=Helper.correctNull(rs.getString("comapp_div_state"));
						MastApplicantBean MAB=new MastApplicantBean();
						String strCityDescOldAudit=MAB.getCityDistrictStateDesc("city",strCityCodeOldAudit);
						String strDistDescOldAudit=MAB.getCityDistrictStateDesc("district",strDistCodeOldAudit);
						String strStateDescOldAudit=MAB.getCityDistrictStateDesc("state",strStateCodeOldAudit);
						
						sbolddata.append("Concern type =").append(correctNull(rs.getString("comapp_divisiontype")));
						sbolddata.append(" ~ Customer ID =").append(correctNull(rs.getString("comapp_div_appid")));
						sbolddata.append(" ~Concern Name = ").append(correctNull(rs.getString("comapp_div_name")));
						sbolddata.append(" ~City = ").append(strCityDescOldAudit);
						sbolddata.append(" ~District = ").append(strDistDescOldAudit);
						sbolddata.append(" ~State = ").append(strStateDescOldAudit);
						sbolddata.append(" ~Pin Code= ").append(correctNull(rs.getString("comapp_div_pin")));
						sbolddata.append(" ~Phone No = ").append(correctNull(rs.getString("comapp_div_phone")));
						sbolddata.append(" ~Fax = ").append(correctNull(rs.getString("comapp_div_fax")));
						
						if(!correctNull(rs.getString("comapp_div_bsrcode")).equals(""))
						{
							String strValues[] =correctNull(rs.getString("comapp_div_bsrcode")).split("-");
							if(!strValues[0].equals(""))
							{
								strQuery1=SQLParser.getSqlQuery("sel_industrydetailsbycode^"+strValues[0]);
								rs1=DBUtils.executeQuery(strQuery1);
								if(rs1.next())
								{ 
									sbolddata.append(" ~BSR Code= ").append(correctNull(rs1.getString("ind_bsr_code"))+"-"+correctNull(rs1.getString("ind_name")));
								}
								else
								{
									sbolddata.append(" ~BSR Code= ").append("");
								}
								if(rs1!=null)rs1.close();
							}
						}
						else
						{
							sbolddata.append(" ~BSR Code= ").append("");
						}
						/***
						 * End - Audit Trial Old Data
						 */
					}
				}
				if(strAction.equalsIgnoreCase("Delete"))
				{
					++intUpdatesize;
					hshQuery.put("strQueryId","deldivisiondetails");
					arrValues.add(comapp_id);
					arrValues.add(correctNull((String)hshValues.get("comapp_div_id")));
					hshQuery.put("arrValues",arrValues);
				}
				else if(strAction.equalsIgnoreCase("Insert"))
				{
					String company_id=correctNull((String)hshValues.get("txtperapp_appid"));
					strQuery=("selmaxsdivision^"+company_id);
					rs=DBUtils.executeLAPSQuery(strQuery);
					if(rs.next())
					{
						strsno=Helper.correctNull((String)rs.getString("snorelmax"));
					}
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					++intUpdatesize;
					hshQuery.put("strQueryId","insdivisiondetails_new");
					arrValues.add(strOldID);
					arrValues.add(strsno);
					arrValues.add(comapp_id);
					arrValues.add(correctNull((String)hshValues.get("comapp_div_name")));
					arrValues.add(correctNull((String)hshValues.get("comapp_div_address")));
					arrValues.add(correctNull((String)hshValues.get("hid_city")));				
					arrValues.add(correctNull((String)hshValues.get("hid_state")));
					arrValues.add(correctNull((String)hshValues.get("comapp_div_pin")));
					arrValues.add(correctNull((String)hshValues.get("comapp_div_phone")));
					arrValues.add(correctNull((String)hshValues.get("comapp_div_fax")));
					arrValues.add(correctNull((String)hshValues.get("comapp_divisiontype")));
					arrValues.add(correctNull((String)hshValues.get("comapp_companyid")));
					arrValues.add(correctNull((String)hshValues.get("hid_dist")));
					arrValues.add(correctNull((String)hshValues.get("comapp_customer_id")));
					arrValues.add(correctNull((String)hshValues.get("txt_ratinggrade1")));
					arrValues.add(correctNull((String)hshValues.get("txt_ratingdate1")));
					arrValues.add(correctNull((String)hshValues.get("rating_type1")));
					arrValues.add(correctNull((String)hshValues.get("txt_ratinggrade2")));
					arrValues.add(correctNull((String)hshValues.get("txt_ratingdate2")));
					arrValues.add(correctNull((String)hshValues.get("rating_type2")));
					arrValues.add(correctNull((String)hshValues.get("comapp_banker")));
					arrValues.add(correctNull((String)hshValues.get("comapp_cbsid")));
					arrValues.add(correctNull((String)hshValues.get("txt_relation")));
					arrValues.add(correctNull((String)hshValues.get("comapp_divisionSubtype")));
					arrValues.add(correctNull((String)hshValues.get("sel_docexecutant")));
					arrValues.add(correctNull((String)hshValues.get("selaccoperby")));//Added By Sathish
					arrValues.add(correctNull((String)hshValues.get("txt_DINnumber"))); 
					arrValues.add(correctNull((String)hshValues.get("sel_chf_promoter")));
					arrValues.add(correctNull((String)hshValues.get("sel_personal_guarantee")));
					arrValues.add(correctNull((String)hshValues.get("sel_chk_npa"))); 
					hshQuery.put("arrValues",arrValues);
				}
				else if(strAction.equalsIgnoreCase("Update"))
				{
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					++intUpdatesize;
			
					hshQuery.put("strQueryId","upddivisiondetails");
					arrValues.add(correctNull((String)hshValues.get("comapp_div_name")));
					arrValues.add(correctNull((String)hshValues.get("comapp_div_address")));
					arrValues.add(correctNull((String)hshValues.get("hid_city")));				
					arrValues.add(correctNull((String)hshValues.get("hid_state")));
					arrValues.add(correctNull((String)hshValues.get("comapp_div_pin")));
					arrValues.add(correctNull((String)hshValues.get("comapp_div_phone")));
					arrValues.add(correctNull((String)hshValues.get("comapp_div_fax")));
					arrValues.add(correctNull((String)hshValues.get("comapp_divisiontype")));
					arrValues.add(correctNull((String)hshValues.get("comapp_companyid")));
					arrValues.add(correctNull((String)hshValues.get("hid_dist")));
					arrValues.add(correctNull((String)hshValues.get("comapp_customer_id")));
					arrValues.add(strOldID);
					arrValues.add(correctNull((String)hshValues.get("txt_ratinggrade1")));
					arrValues.add(correctNull((String)hshValues.get("txt_ratingdate1")));
					arrValues.add(correctNull((String)hshValues.get("rating_type1")));
					arrValues.add(correctNull((String)hshValues.get("txt_ratinggrade2")));
					arrValues.add(correctNull((String)hshValues.get("txt_ratingdate2")));
					arrValues.add(correctNull((String)hshValues.get("rating_type2")));
					arrValues.add(correctNull((String)hshValues.get("comapp_banker")));
					arrValues.add(correctNull((String)hshValues.get("comapp_cbsid")));
					arrValues.add(correctNull((String)hshValues.get("txt_relation")));
					arrValues.add(correctNull((String)hshValues.get("comapp_divisionSubtype")));
					arrValues.add(correctNull((String)hshValues.get("sel_docexecutant")));
					arrValues.add(correctNull((String)hshValues.get("selaccoperby")));//Added by sathish
					arrValues.add(correctNull((String)hshValues.get("txt_DINnumber"))); 
					arrValues.add(correctNull((String)hshValues.get("sel_chf_promoter")));
					arrValues.add(correctNull((String)hshValues.get("sel_personal_guarantee")));
					arrValues.add(correctNull((String)hshValues.get("sel_chk_npa")));

					arrValues.add(comapp_id);
					arrValues.add(correctNull((String)hshValues.get("comapp_div_id")));
					
					hshQuery.put("arrValues",arrValues);
				}
				hshQueryVal.put("size",Integer.toString(intUpdatesize));
				hshQueryVal.put(Integer.toString(intUpdatesize),hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryVal,"updateData");
				/***
				 * For Audit Trial New Data - By Karthikeyan.S on 17/09/2013
				 */
				StringBuilder sbAt = new StringBuilder();
				if(!strAction.equalsIgnoreCase("Delete")){
				sbAt.append("Concern type =").append(correctNull((String)hshValues.get("comapp_divisiontype")));
				sbAt.append(" ~Customer ID =").append(correctNull((String)hshValues.get("comapp_customer_id")));
				sbAt.append(" ~Concern Name = ").append(correctNull((String)hshValues.get("comapp_div_name")));
				sbAt.append(" ~City = ").append(correctNull((String)hshValues.get("comapp_div_city")));
				sbAt.append(" ~District = ").append(correctNull((String)hshValues.get("comapp_div_dist")));
				sbAt.append(" ~State = ").append(correctNull((String)hshValues.get("comapp_div_state")));
				sbAt.append(" ~Pin Code= ").append(correctNull((String)hshValues.get("comapp_div_pin")));
				sbAt.append(" ~Phone No = ").append(correctNull((String)hshValues.get("comapp_div_phone")));
				sbAt.append(" ~Fax = ").append(correctNull((String)hshValues.get("comapp_div_fax")));
				sbAt.append(" ~BSR Code= ").append(correctNull((String)hshValues.get("comapp_companyid")));
				sbAt.append(" ~Personal guarantee= ").append(correctNull((String)hshValues.get("sel_personal_guarantee")));
				}
				AuditTrial.auditNewLog(hshValues,"211",comapp_id,sbAt.toString(),sbolddata.toString());
				/***
				 * End - Audit Trial New Data
				 */
			}
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
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
		
		public void updateSHGmembersDetail(HashMap hshValues) 
		{
			HashMap hshQuery = new HashMap();
			HashMap hshQueryValues = new HashMap();
			ArrayList arrValues = new ArrayList();
			
			String strAction = Helper.correctNull((String)hshValues.get("hidAction"));
			String strAppId = Helper.correctNull((String)hshValues.get("hidDemoId"));
			int size=0;
			
			String[] strSno = (String[])hshValues.get("txt_sno");
			String[] strCBSID = (String[])hshValues.get("txt_cbsid");
			String[] strLAPSID = (String[])hshValues.get("txt_lapsid");
			String[] strMemName = (String[])hshValues.get("txt_name");
			String[] strMemDOB = (String[])hshValues.get("txt_dob");
			String[] strMemPAN = (String[])hshValues.get("txt_panno");
			String[] strMemExis = (String[])hshValues.get("sel_existing");
			String[] strMemDefault = (String[])hshValues.get("sel_default");
			String[] strMemConcernType = (String[])hshValues.get("sel_concerntype");
			try
			{
				hshQueryValues = new HashMap();
				if(strAction.equalsIgnoreCase("update"))
				{
					size++;
					hshQuery.put("strQueryId", "del_shgMemberInfo");
					arrValues.add(strAppId);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(size), hshQuery);
					
					if(strSno instanceof String[])
					{
						for(int i=0;i<strSno.length;i++)
						{
							size++;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							hshQuery.put("strQueryId", "ins_shgMemberInfo");
							arrValues.add(strAppId);
							arrValues.add(strSno[i]);
							arrValues.add(strCBSID[i]);
							arrValues.add(strLAPSID[i]);
							arrValues.add(strMemName[i]);
							arrValues.add(strMemDOB[i]);
							arrValues.add(strMemPAN[i]);
							arrValues.add(strMemExis[i]);
							arrValues.add(strMemDefault[i]);
							arrValues.add(strMemConcernType[i]);
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put(String.valueOf(size), hshQuery);
						}
					}
					
					size++;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_shgAddtnl_info1");
					arrValues.add(strAppId);
					arrValues.add(strAppId);
					arrValues.add(strAppId);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(size), hshQuery);

					size++;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_shgAddtnl_info2");
					arrValues.add(strAppId);
					arrValues.add(strAppId);
					arrValues.add(strAppId);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(size), hshQuery);
				}
				else if(strAction.equalsIgnoreCase("delete"))
				{
					size++;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_shgMemberInfo");
					arrValues.add(strAppId);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(size), hshQuery);
					
					size++;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_shgAddtnl_info1");
					arrValues.add(strAppId);
					arrValues.add(strAppId);
					arrValues.add(strAppId);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(size), hshQuery);
					
					size++;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_shgAddtnl_info2");
					arrValues.add(strAppId);
					arrValues.add(strAppId);
					arrValues.add(strAppId);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(size), hshQuery);
				}
				else if(strAction.equalsIgnoreCase("remove"))
				{
					size++;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_shgMemberInfo_indv");
					arrValues.add(strAppId);
					arrValues.add(Helper.correctNull((String)hshValues.get("hid_DelSno")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(size), hshQuery);
					
					size++;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_shgAddtnl_info1");
					arrValues.add(strAppId);
					arrValues.add(strAppId);
					arrValues.add(strAppId);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(size), hshQuery);

					size++;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_shgAddtnl_info2");
					arrValues.add(strAppId);
					arrValues.add(strAppId);
					arrValues.add(strAppId);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(size), hshQuery);
				}
				
				hshQueryValues.put("size", String.valueOf(size));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strAppId);
				arrValues.add(strAppId);
				hshQuery.put("strQueryId","upd_misreselectflag"); 
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			catch(Exception e)
			{
				throw new EJBException("Error in updateSHGmembersDetail==>"+e.toString());
			}
		}
		
		public void updateSHGAddtnDetail(HashMap hshValues) 
		{
			HashMap hshQuery = new HashMap();
			HashMap hshQueryValues = new HashMap();
			ArrayList arrValues = new ArrayList();
			
			try
			{
				hshQueryValues = new HashMap();
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_shg_addntl_det");
				arrValues.add(Helper.correctNull((String)hshValues.get("hidDemoId")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_Sno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidType")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_shg_addntl_det");
				arrValues.add(Helper.correctNull((String)hshValues.get("hidDemoId")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_Sno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidType")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_shgname")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_lendingbank")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_shgAccNo")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_borrowed")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_os")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_status")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				
				hshQueryValues.put("size", "2");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
			catch(Exception e)
			{
				throw new EJBException("Error in updateSHGAddtnDetail==>"+e.toString());
			}
		}
		
		public HashMap getSHGAddtnDetail(HashMap hshValues) 
		{
			HashMap hshResult = new HashMap();
			String strQuery="";
			ResultSet rs = null;
			
			String strAppId = Helper.correctNull((String)hshValues.get("hidDemoId"));
			String strSno = Helper.correctNull((String)hshValues.get("hid_Sno"));
			if(strSno.equalsIgnoreCase(""))
				strSno = Helper.correctNull((String)hshValues.get("varSno"));
			String strType = Helper.correctNull((String)hshValues.get("hidType"));
			if(strType.equalsIgnoreCase(""))
				strType = Helper.correctNull((String)hshValues.get("varType"));
			hshResult.put("hidDemoId", strAppId);
			hshResult.put("varSno", strSno);
			hshResult.put("varType", strType);
			
			try
			{
				strQuery = SQLParser.getSqlQuery("sel_shg_addntl_det^"+strAppId+"^"+strSno+"^"+strType);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshResult.put("hidDemoId", Helper.correctNull((String)rs.getString("SHGINFO_APPID")));
					hshResult.put("hid_Sno", Helper.correctNull((String)rs.getString("SHGINFO_SNO")));
					hshResult.put("hidType", Helper.correctNull((String)rs.getString("SHGINFO_TYPE")));
					hshResult.put("SHGINFO_NAME", Helper.correctNull((String)rs.getString("SHGINFO_NAME")));
					hshResult.put("SHGINFO_BANK", Helper.correctNull((String)rs.getString("SHGINFO_BANK")));
					hshResult.put("SHGINFO_ACCNO", Helper.correctNull((String)rs.getString("SHGINFO_ACCNO")));
					hshResult.put("SHGINFO_BORROW", Helper.correctNull((String)rs.getString("SHGINFO_BORROW")));
					hshResult.put("SHGINFO_OS", Helper.correctNull((String)rs.getString("SHGINFO_OS")));
					hshResult.put("SHGINFO_STATUS", Helper.correctNull((String)rs.getString("SHGINFO_STATUS")));
				}
			}
			catch(Exception e)
			{
				throw new EJBException("Error in getSHGAddtnDetail==>"+e.toString());
			}
			return hshResult;
		}
		
		public HashMap getSHGmembersDetail(HashMap hshValues) 
		{
			HashMap hshRecord = new HashMap();
			String strQuery = "";
			ArrayList arrCol = new ArrayList();
			ArrayList arrRow = new ArrayList();
			
			ResultSet rs = null;
			String strProfilestatus="";
			String strAppStatus="";
			String hidDemoId=correctNull((String)hshValues.get("hidDemoId"));
			String strcomappid= correctNull((String)hshValues.get("hidapplicantid"));
			int intMembers=0;
			int intAvailable=0;
			
			try
			{
				strAppStatus=Helper.correctNull((String)hshValues.get("hidappstatus"));
				//To get the number of members details from the previous page
				strQuery = SQLParser.getSqlQuery("sel_agrappshg^"+hidDemoId);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					intMembers = Integer.parseInt(Helper.correctInt((String)rs.getString("perapp_shgmember")));
				}

				//To get the number of members details from the previous page
				if(rs != null)
					rs.close();
				strQuery = SQLParser.getSqlQuery("sel_shgmembersdetails^"+hidDemoId);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(Helper.correctNull((String)rs.getString("SHG_MEM_SNO")));
					arrCol.add(Helper.correctNull((String)rs.getString("SHG_MEM_CBSID")));
					arrCol.add(Helper.correctNull((String)rs.getString("SHG_MEM_LAPSID")));
					arrCol.add(Helper.correctNull((String)rs.getString("SHG_MEM_NAME")));
					arrCol.add(Helper.correctNull((String)rs.getString("SHG_MEM_DOB")));
					arrCol.add(Helper.correctNull((String)rs.getString("SHG_MEM_PAN")));
					arrCol.add(Helper.correctNull((String)rs.getString("SHG_MEM_EXISTING")));
					arrCol.add(Helper.correctNull((String)rs.getString("SHG_MEM_DEFAULT")));
					arrCol.add(Helper.correctNull(rs.getString("SHG_MEM_CONCERNTYPE")));
					arrRow.add(arrCol);
				}
				
				intAvailable = arrRow.size();
				for(int i = 0;i<(intMembers - intAvailable);i++)
				{
					arrCol = new ArrayList();
					arrCol.add("");
					arrCol.add("");
					arrCol.add("");
					arrCol.add("");
					arrCol.add("");
					arrCol.add("");
					arrCol.add("S");
					arrCol.add("S");
					arrCol.add("S");
					arrRow.add(arrCol);
				}
				hshRecord.put("arrRow", arrRow);
				
				MastApplicantBean mast=new MastApplicantBean();
				HashMap prof=new HashMap();
				HashMap profile=new HashMap();
				prof.put("profile_id",hidDemoId);
				profile=(HashMap)mast.getCustomerProfileStatus(prof);
				hshRecord.put("strIncompletepage", Helper.correctNull((String)profile.get("strIncompletepage")));
				if(rs!=null)
				{
					rs.close();
				}
				
				rs=DBUtils.executeLAPSQuery("getprofilestatusfromdemographic^"+hidDemoId);
				if(rs.next())
				{
					strProfilestatus=Helper.correctNull((String)rs.getString("perapp_profilestatus"));
				}	
				else
				{
					strProfilestatus="";
				}
				hshRecord.put("strProfilestatus",strProfilestatus);
				hshRecord.put("appstatus", strAppStatus);
			}
			catch(Exception e)
			{
				throw new EJBException("Error in getSHGmembersDetail=="+e.toString());
			}
			return hshRecord;
		}
		
		public HashMap getDivisionDetails(HashMap hshValues) 
		{
			ResultSet rs=null;
			HashMap hshRecord=new HashMap();
			ArrayList vecCol = new ArrayList();
			ArrayList vecRow = new ArrayList();
			String strcomapp_div_id="",strcomapp_id="";
			boolean recordflag=false;
			String strAppStatus="";
			ResultSet rs1=null;
			ResultSet rs2=null;
			ResultSet rs3=null;
	 	 	String strDistcode="";
	   	 	String strDistDesc="";
	   	 	String strCitycode="";
		 	String strCityDesc="";
		 	String strStatecode="";
	   	 	String strStateDesc="";
	   	 	String strQuery="",strConstitution="";

			ArrayList arrCol = new ArrayList();
			ArrayList arrRow = new ArrayList();
			ArrayList arrCol1 = new ArrayList();
			ArrayList arrCol2 = new ArrayList();
			ArrayList arrRow1= new ArrayList();
			try
			{
	
				
				strAppStatus=Helper.correctNull((String)hshValues.get("hidappstatus"));

				strcomapp_div_id= correctNull((String)hshValues.get("comapp_div_id"));
				
				strcomapp_id=correctNull((String)hshValues.get("hidapplicantnewid"));
				if(strcomapp_id.equalsIgnoreCase("")){
				strcomapp_id=correctNull((String)hshValues.get("txtperapp_appid"));
				}
				if(strcomapp_id.equalsIgnoreCase("")){
					strcomapp_id=correctNull((String)hshValues.get("hidDemoId"));
				}
				String strLapsId=correctNull((String)hshValues.get("txt_laps_app_id"));
				if(strLapsId.equals("") && (!strcomapp_id.equals("")))
				{
				rs=DBUtils.executeLAPSQuery("get_perdemographics_oldid_renew^"+strcomapp_id);
				if(rs.next())
				{
					strLapsId=Helper.correctNull((String)rs.getString("perapp_oldid"));
				}
				}
				if(rs!=null){rs.close();}

				rs=DBUtils.executeLAPSQuery("get_perapplicant_details^"+strcomapp_id);
				if(rs.next())
				{
					strConstitution=Helper.correctNull((String)rs.getString("perapp_constitutionnew"));
				}
				System.out.println("<<<<<<<<<<<<<<<<==============strConstitution======================>>>>>>>>>>>>>>>>>"+strConstitution);
				hshRecord.put("strOldID", strLapsId);
				if(rs!=null){rs.close();}
				
				rs=DBUtils.executeLAPSQuery("comapp_division_details_sel^"+strcomapp_id);
				while(rs.next())
				{
					vecCol = new ArrayList();
					vecCol.add(correctNull((String)rs.getString("comapp_div_id")));//0
					vecCol.add(correctNull((String)rs.getString("comapp_div_name")));//1
					vecCol.add(correctNull((String)rs.getString("comapp_div_address")));//2
					//vecCol.add(correctNull((String)rs.getString("comapp_div_city")));					
					strCitycode = Helper.correctNull((String)rs.getString("comapp_div_city"));
					if(!strCitycode.equalsIgnoreCase(""))
					{				
					if(rs1!=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeLAPSQuery("sel_citynamebycode^"+strCitycode);
					if(rs1.next())
					{
						
						strCityDesc = Helper.correctNull((String)rs1.getString("city_name"));					
					}
					}
					vecCol.add(strCitycode);//3
					vecCol.add(strCityDesc);//4
					//vecCol.add(correctNull((String)rs.getString("comapp_div_state")));
					strStatecode = Helper.correctNull((String)rs.getString("comapp_div_state"));	
					if(!strStatecode.equalsIgnoreCase(""))
					{				
					if(rs2!=null)
					{
						rs2.close();
					}
					rs2=DBUtils.executeLAPSQuery("sel_statenamebycode^"+strStatecode);
					if(rs2.next())
					{
						strStateDesc = Helper.correctNull((String)rs2.getString("state_name"));					
					}
					}
					vecCol.add(strStatecode);//5
					vecCol.add(strStateDesc);//6
					vecCol.add(correctNull((String)rs.getString("comapp_div_pin")));//7
					vecCol.add(correctNull((String)rs.getString("comapp_div_phone")));//8
					vecCol.add(correctNull((String)rs.getString("comapp_div_fax")));//9
					vecCol.add(correctNull((String)rs.getString("comapp_divisiontype")));//10
					vecCol.add(correctNull((String)rs.getString("comapp_div_bsrcode")));	//11
					strDistcode = Helper.correctNull((String)rs.getString("comapp_div_dist"));
					
					if(!strDistcode.equalsIgnoreCase(""))
					{				
					if(rs3!=null)
					{
						rs3.close();
					}
					rs3=DBUtils.executeLAPSQuery("sel_distnamebycode^"+strDistcode);
					if(rs3.next())
					{
						
						strDistDesc = Helper.correctNull((String)rs3.getString("district_desc"));//15					
					}
					}
					vecCol.add(strDistcode);//12
					vecCol.add(strDistDesc);//13
			
					vecCol.add(correctNull((String)rs.getString("comapp_div_appid")));//14
					vecCol.add(correctNull((String)rs.getString("com_compratinggrade1")));//15
					vecCol.add(correctNull((String)rs.getString("com_compratingason1")));//16
					vecCol.add(correctNull((String)rs.getString("com_compratingtype1")));//17
					vecCol.add(correctNull((String)rs.getString("com_compratinggrade2")));//18
					vecCol.add(correctNull((String)rs.getString("com_compratingason2")));//19
					vecCol.add(correctNull((String)rs.getString("com_compratingtype2")));//20
					vecCol.add(Helper.CLOBToString(rs.getClob("COMAPP_BANKERS")));//21
					vecCol.add(correctNull(rs.getString("comapp_cbsid")));//22
					if(!correctNull(rs.getString("comapp_groupid")).equalsIgnoreCase(""))
					{
						if(rs3!=null)
						{
							rs3.close();
						}
						rs3=DBUtils.executeLAPSQuery("selcusgroupsID^"+correctNull(rs.getString("comapp_groupid")));
						if(rs3.next())
						{
							
							vecCol.add(correctNull(rs3.getString("group_name")));//23			
						}
						else
						{
							vecCol.add("");//23
						}
					}
					else
					{
						vecCol.add("");//23
					}
					vecCol.add(correctNull(rs.getString("comapp_relation")));//24
					vecCol.add(correctNull(rs.getString("COMAPP_DIVISIONSUBTYPE")));//25
					vecCol.add(correctNull(rs.getString("COMAPP_DOCEXECUTANT")));//26
					vecCol.add(correctNull(rs.getString("COMAPP_ACCOUNTOPERTED")));//27
					vecCol.add(correctNull(rs.getString("COMAPP_DINNUMBER")));//28
					if(rs3!=null)
					{
						rs3.close();
					}
					if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("Division"))
						rs3=DBUtils.executeLAPSQuery("selstatdatabyiddesc^193^"+correctNull(rs.getString("COMAPP_DIVISIONSUBTYPE")));
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("Sister concern"))
						rs3=DBUtils.executeLAPSQuery("selstatdatabyiddesc^194^"+correctNull(rs.getString("COMAPP_DIVISIONSUBTYPE")));
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("Group concern"))
						rs3=DBUtils.executeLAPSQuery("selstatdatabyiddesc^195^"+correctNull(rs.getString("COMAPP_DIVISIONSUBTYPE")));
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("O"))
						rs3=DBUtils.executeLAPSQuery("selstatdatabyiddesc^196^"+correctNull(rs.getString("COMAPP_DIVISIONSUBTYPE")));
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("D"))
						rs3=DBUtils.executeLAPSQuery("selstatdatabyiddesc^197^"+correctNull(rs.getString("COMAPP_DIVISIONSUBTYPE")));
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("SP"))
						rs3=DBUtils.executeLAPSQuery("selstatdatabyiddesc^198^"+correctNull(rs.getString("COMAPP_DIVISIONSUBTYPE")));
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("PT"))
						rs3=DBUtils.executeLAPSQuery("selstatdatabyiddesc^199^"+correctNull(rs.getString("COMAPP_DIVISIONSUBTYPE")));
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("T"))
						rs3=DBUtils.executeLAPSQuery("selstatdatabyiddesc^200^"+correctNull(rs.getString("COMAPP_DIVISIONSUBTYPE")));
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("K"))
						rs3=DBUtils.executeLAPSQuery("selstatdatabyiddesc^201^"+correctNull(rs.getString("COMAPP_DIVISIONSUBTYPE")));
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("PA"))
						rs3=DBUtils.executeLAPSQuery("selstatdatabyiddesc^202^"+correctNull(rs.getString("COMAPP_DIVISIONSUBTYPE")));
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("OT"))
						rs3=DBUtils.executeLAPSQuery("selstatdatabyiddesc^203^"+correctNull(rs.getString("COMAPP_DIVISIONSUBTYPE")));
					if(rs3.next())
						vecCol.add(correctNull(rs3.getString("stat_data_desc1")));//29			
					else
						vecCol.add("");//29
					vecCol.add(correctNull(rs.getString("COMAPP_CHF_PROMOTER")));//30COMAPP_PERSONAL_GUARANTEE
					vecCol.add(correctNull(rs.getString("COMAPP_PERSONAL_GUARANTEE")));//31					
					vecCol.add(correctNull(rs.getString("COMAPP_CHF_NPA")));//32


					vecRow.add(vecCol);
					recordflag=true;
				}
			
				hshRecord.put("vecRow",vecRow);
				hshRecord.put("comapp_div_id",strcomapp_div_id);
				hshRecord.put("comapp_id",strcomapp_id);
				if(recordflag)
					hshRecord.put("recordflag","Y");
				else
					hshRecord.put("recordflag","N");
				if(rs1!=null)
					rs1.close();
				ArrayList arrmin=new ArrayList();
				strQuery = SQLParser.getSqlQuery("sel_grpmangminoritychk^" + strcomapp_id);
				rs1 = DBUtils.executeQuery(strQuery);
					while (rs1.next()) {
				strQuery = SQLParser.getSqlQuery("sel_partnerschk^" + Helper.correctNull((String) rs1.getString("COMAPP_CBSID")));
				rs2 = DBUtils.executeQuery(strQuery);
				if (rs2.next()) {
					
								arrCol = new ArrayList();
								arrCol.add(Helper.correctNull((String) rs2
										.getString("COMINFO_MINORITY_COMMUNITY")));
								arrCol.add(Helper.correctInt((String) rs2
										.getString("perapp_id")));

								arrCol.add(Helper.correctNull((String) rs2
										.getString("perapp_fname")));
								
								arrRow1.add(arrCol);
							}
							
							
							
							
					}
            if (strConstitution.equalsIgnoreCase("09")) {
				for (int i = 0; i < arrRow1.size(); i++) {
					ArrayList arrCol11 = (ArrayList) arrRow1.get(i);
					if (Helper.correctNull((String) arrCol11.get(0))
							.equalsIgnoreCase("")) {
						ArrayList arrCol12 = new ArrayList();
						arrCol12.add(arrCol11.get(1));
						arrCol12.add(arrCol11.get(2));
						arrmin.add(arrCol12);
					}
				}
			}
					hshRecord.put("arrmin",arrmin);

					System.out.println("****************arrmin**************"+arrmin);
				MastApplicantBean mast=new MastApplicantBean();
				HashMap prof=new HashMap();
				HashMap profile=new HashMap();
				prof.put("profile_id",strcomapp_id);
				profile=(HashMap)mast.getCustomerProfileStatus(prof);
				hshRecord.put("strIncompletepage", Helper.correctNull((String)profile.get("strIncompletepage")));
				
			String strProfilestatus="";
				if(rs!=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("getprofilestatusfromdemographic^"+strcomapp_id);
				if(rs.next())
				{
					strProfilestatus=Helper.correctNull((String)rs.getString("perapp_profilestatus"));
				}
				hshRecord.put("strProfilestatus",strProfilestatus);
				hshRecord.put("appstatus",strAppStatus);
			}
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
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
	
		public HashMap getcompanyData(HashMap hshValues) 
		{
			ResultSet rs=null;ResultSet rs1=null;
			HashMap hshRecord=new HashMap();
			String strQuery="";
			String strComappid="";
				String citycodeval="",statecode_val="",city_code_val="",state_code_val="";
			String permcity="";
			String cityregval="",cityadmval="",cityregvalue="",stateregvalue="",statereg_value="";
			String  cityadmvalue="",stateadmvalue="",stateadm_value="";
			//String hidcity1="",hidcity2="",hidcity3="",hidcity4="";
			try
			{
				strComappid=(String)hshValues.get("hidapplicantid");
				if(strComappid.equalsIgnoreCase(""))
				{
				strComappid=Helper.correctNull((String)hshValues.get("comapp_id"));
				}
				/*hidcity1=(String)hshValues.get("hidcity1");
				hidcity2=(String)hshValues.get("hidcity2");
				hidcity3=(String)hshValues.get("hidcity3");
				hidcity4=(String)hshValues.get("hidcity4");*/
				if(strComappid==null || strComappid.equals("New"))
				{
					return null;
					
				}
			
				rs=DBUtils.executeLAPSQuery("comappmasterexistsel^"+strComappid);
				if(rs.next())
				{
					hshRecord.put("comapp_id",rs.getString(1));
					hshRecord.put("comapp_companyname",correctNull(rs.getString(2)));
					hshRecord.put("comapp_companyid",correctNull(rs.getString(3)));
					hshRecord.put("comapp_crptaddress1",correctNull(rs.getString(4)));
					hshRecord.put("comapp_crptaddress2",correctNull(rs.getString(5)));
					hshRecord.put("hidcity1",correctNull(rs.getString(6)));
					 citycodeval=correctNull(rs.getString(6));
						
					hshRecord.put("hidstate1",correctNull(rs.getString(7)));
					hshRecord.put("sel_state",correctNull(rs.getString(7)));
						
					hshRecord.put("comapp_crptpin",correctNull(rs.getString(8)));
					hshRecord.put("comapp_crptphone",correctNull(rs.getString(9)));
					hshRecord.put("comapp_crptfax",correctNull(rs.getString(10)));
					hshRecord.put("comapp_factaddress1",correctNull(rs.getString(11)));
					hshRecord.put("comapp_factaddress2",correctNull(rs.getString(12)));
					hshRecord.put("hidcity2",correctNull(rs.getString(13)));
					  permcity=correctNull(rs.getString(13));
						
					hshRecord.put("hidstate2",correctNull(rs.getString(14)));
					hshRecord.put("comapp_factpin",correctNull(rs.getString(15)));
					hshRecord.put("comapp_factphone",correctNull(rs.getString(16)));
					hshRecord.put("comapp_factfax",correctNull(rs.getString(17)));
					hshRecord.put("comapp_businessnature",correctNull(rs.getString(18)));
					hshRecord.put("comapp_corpstructure",correctNull(rs.getString(19)));
					hshRecord.put("comapp_companyrole",correctNull(rs.getString(20)));
					hshRecord.put("comapp_yrsinbusiness",correctNull(rs.getString(21)));
					hshRecord.put("comapp_ownership",correctNull(rs.getString(22)));
					hshRecord.put("comapp_totemployees",correctNull(rs.getString(23)));
					hshRecord.put("comapp_contact",correctNull(rs.getString(24)));
					hshRecord.put("comapp_email",correctNull(rs.getString(25)));
					hshRecord.put("comapp_groupid",correctNull(rs.getString(26)));
					hshRecord.put("comapp_corppremises",correctNull(rs.getString(27)));
					hshRecord.put("comapp_factpremises",correctNull(rs.getString(28)));
					hshRecord.put("comapp_regpremises",correctNull(rs.getString(29)));
					hshRecord.put("comapp_regadd1",correctNull(rs.getString(30)));
					hshRecord.put("comapp_regadd2",correctNull(rs.getString(31)));
					hshRecord.put("hidcity3",correctNull(rs.getString(32)));
					cityregval=correctNull(rs.getString(32));
					hshRecord.put("hidstate3",correctNull(rs.getString(33)));
					hshRecord.put("comapp_regphone",correctNull(rs.getString(34)));
					hshRecord.put("comapp_regfax",correctNull(rs.getString(35)));
					hshRecord.put("comapp_regpin",correctNull(rs.getString(36)));
					hshRecord.put("comapp_indcode",correctNull(rs.getString(37)));
					hshRecord.put("comapp_regdeal",correctNull(rs.getString(38)));
					hshRecord.put("comapp_indtype",correctNull(rs.getString(39)));					
					
					hshRecord.put("relatives",correctNull(rs.getString(40)));
					hshRecord.put("scale",correctNull(rs.getString(41)));
					hshRecord.put("emp",correctNull(rs.getString(42)));
					hshRecord.put("relationship",correctNull(rs.getString(43)));
					hshRecord.put("comapp_exp",correctNull(rs.getString(44)));
					hshRecord.put("comapp_admadd1",correctNull(rs.getString(45)));
					hshRecord.put("comapp_admadd2",correctNull(rs.getString(46)));
					hshRecord.put("hidcity4",correctNull(rs.getString(47)));
					cityadmval=correctNull(rs.getString(47));
					
					hshRecord.put("hidstate4",correctNull(rs.getString(48)));
					hshRecord.put("comapp_admphone",correctNull(rs.getString(49)));
					hshRecord.put("comapp_admfax",correctNull(rs.getString(50)));
					hshRecord.put("comapp_admpin",correctNull(rs.getString(51)));
					
					hshRecord.put("comapp_comtype",correctNull(rs.getString("comapp_comtype")));
					hshRecord.put("comapp_ssitype",correctNull(rs.getString("comapp_ssitype")));
					hshRecord.put("hidPageType",correctNull((String)hshValues.get("hidPageType")));
					hshRecord.put("hidCategoryType",correctNull((String)hshValues.get("hidCategoryType")));
					hshRecord.put("hidSSIType",correctNull((String)hshValues.get("hidSSIType")));	
					hshRecord.put("comapp_scode",correctNull(rs.getString("comapp_org_scode")));	
					hshRecord.put("comapp_group",correctNull(rs.getString("groupdesc")));	
					
					//district
					hshRecord.put("comapp_corpdist",correctNull(rs.getString("comapp_corpdist")));
					hshRecord.put("comapp_facdist",correctNull(rs.getString("comapp_facdist")));
					hshRecord.put("comapp_regdist",correctNull(rs.getString("comapp_regdist")));
					hshRecord.put("comapp_admindist",correctNull(rs.getString("comapp_admindist")));
					
					hshRecord.put("txt_district",correctNull(rs.getString("comapp_corpdist")));
					hshRecord.put("txt_district2",correctNull(rs.getString("comapp_facdist")));
					hshRecord.put("txt_district3",correctNull(rs.getString("comapp_regdist")));
					hshRecord.put("txt_district4",correctNull(rs.getString("comapp_admindist")));
					//others
					
					hshRecord.put("comapp_rbino",correctNull(rs.getString("comapp_rbino")));
					hshRecord.put("comapp_selrel",correctNull(rs.getString("comapp_selrel")));
					hshRecord.put("comapp_grpscl",correctNull(rs.getString("comapp_grpscl")));
					hshRecord.put("comapp_reldet",correctNull(rs.getString("comapp_reldet")));
					
					hshRecord.put("comapp_subnbfc",correctNull(rs.getString("comapp_subnbfc")));
					hshRecord.put("comapp_relempno",correctNull(rs.getString("comapp_relempno")));
					hshRecord.put("comapp_borrel",correctNull(rs.getString("comapp_borrel")));
					hshRecord.put("auth_captial",correctNull(rs.getString("auth_captial")));
					hshRecord.put("company_status",correctNull(rs.getString("company_status")));
					hshRecord.put("company_staff",correctNull(rs.getString("company_staff")));
					
					hshRecord.put("company_inland",correctNull(rs.getString("company_inland")));
					hshRecord.put("company_introtitle",correctNull(rs.getString("company_introtitle")));
					hshRecord.put("company_introname",correctNull(rs.getString("company_introname")));
					hshRecord.put("comapp_regcountry",correctNull(rs.getString("comapp_regcountry")));
					hshRecord.put("comapp_subcapital",correctNull(rs.getString("comapp_subcapital")));
					hshRecord.put("comapp_totalshares",correctNull(rs.getString("comapp_totalshares")));
//					namrata
					if(!citycodeval.equalsIgnoreCase(""))
					{
					strQuery = SQLParser.getSqlQuery("selcitycode^"+citycodeval);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						city_code_val = Helper.correctNull((String)rs1.getString(1));
						state_code_val = Helper.correctNull((String)rs1.getString(2));
						if(!state_code_val.equalsIgnoreCase(""))
						{
						strQuery = SQLParser.getSqlQuery("selstatecode^"+state_code_val);
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							statecode_val = Helper.correctNull((String)rs1.getString(1));
							
						}
						}
					}
					}
					hshRecord.put("comapp_crptcity",city_code_val);
					hshRecord.put("sel_state",statecode_val);
					String permcity_code_val="",permstate_code_val="",permstatecode_val="";
//					namrata
					if(!permcity.equalsIgnoreCase(""))
					{
					strQuery = SQLParser.getSqlQuery("selcitycode^"+ permcity);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						permcity_code_val = Helper.correctNull((String)rs1.getString(1));
						permstate_code_val = Helper.correctNull((String)rs1.getString(2));
						if(!permstate_code_val.equalsIgnoreCase(""))
						{
						strQuery = SQLParser.getSqlQuery("selstatecode^"+permstate_code_val);
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							permstatecode_val = Helper.correctNull((String)rs1.getString(1));
							
						}
						}
					}
					}
					hshRecord.put("comapp_factcity",permcity_code_val);
					hshRecord.put("comapp_factstate",permstatecode_val);
					if(!cityregval.equalsIgnoreCase(""))
					{
					strQuery = SQLParser.getSqlQuery("selcitycode^"+ cityregval);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						cityregvalue = Helper.correctNull((String)rs1.getString(1));
						stateregvalue = Helper.correctNull((String)rs1.getString(2));
						if(!stateregvalue.equalsIgnoreCase(""))
						{
						strQuery = SQLParser.getSqlQuery("selstatecode^"+stateregvalue);
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							statereg_value = Helper.correctNull((String)rs1.getString(1));
							
						}
						}
					}
					}
					hshRecord.put("comapp_regcity",cityregvalue);
					hshRecord.put("comapp_regstate",statereg_value);
					if(!cityadmval.equalsIgnoreCase(""))
					{
					strQuery = SQLParser.getSqlQuery("selcitycode^"+ cityadmval);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						cityadmvalue = Helper.correctNull((String)rs1.getString(1));
						stateadmvalue = Helper.correctNull((String)rs1.getString(2));
						if(!stateadmvalue.equalsIgnoreCase(""))
						{
						strQuery = SQLParser.getSqlQuery("selstatecode^"+stateadmvalue);
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							stateadm_value = Helper.correctNull((String)rs1.getString(1));
							
						}
						}
					}
					}
					hshRecord.put("comapp_admcity",cityadmvalue);
					hshRecord.put("comapp_admstate",stateadm_value);
					//namrata
					//namrata
					hshRecord.put("org_code",correctNull(rs.getString("org_code")));
					
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
					if(rs1 != null)
					{
						rs1.close();
					}
				}
				catch(Exception e1)
				{
					throw new EJBException("Error closing connection");
				}
			}
			return hshRecord;
		}
		public HashMap getagrApplicantList(HashMap hshValues) 
		{
			ResultSet rs=null;
			HashMap hshRecord=new HashMap();
			ArrayList arryCol=null;
			ArrayList arryRow=new ArrayList();
			ArrayList arrcomappid=new ArrayList();
			ArrayList arrcomname= new ArrayList();
			ArrayList arrcomid=new ArrayList();
			ArrayList arrcomtype = new ArrayList();
			ArrayList arrindustryname = new ArrayList();
			String strQuery="";
			String strComappid="";
			String strComappname="",absPosition="";
			try
			{
				strComappid=correctNull((String)hshValues.get("comapp_id"));
				if(strComappid.trim().equalsIgnoreCase(""))
					strComappid="%";
				
				strComappname=correctNull((String)hshValues.get("comapp_companyname"));
				if(strComappname.trim().equalsIgnoreCase(""))
					strComappname="%";
				
				String strOrgShortCode=correctNull((String)hshValues.get("strOrgShortCode"));
				String strOrgSelect=correctNull((String)hshValues.get("strOrgSelect"));
			    absPosition = correctNull((String)hshValues.get("hid_rowcount"));
				if(strOrgSelect.trim().equalsIgnoreCase(""))
					strOrgSelect="%";
				
				if(strOrgShortCode.trim().equalsIgnoreCase(""))
					strOrgShortCode="%";
					
				strQuery=SQLParser.getSqlQuery("comagrappmasterlist^"+strComappid+"^"+strComappname+"^"+strOrgShortCode);
				rs=DBUtils.executeQuery(strQuery);
				rs.last();
				
				int RowCount = rs.getRow();			    
				rs.beforeFirst();
			 	
					if(RowCount != 0)				{
						
							if (!absPosition.equals("0"))
							{
								if(Integer.parseInt(absPosition) > RowCount)
								{
									rs.absolute(RowCount);
									
								}
								else
								{
								rs.absolute(Integer.parseInt(absPosition));
								
								}				
						}			
					}
				
				while(rs.next())
				{
					arrcomappid.add(rs.getString(1));
					arrcomname.add(rs.getString(2));
					arrcomid.add(correctNull(rs.getString(3)));
					arrcomtype.add(correctNull(rs.getString(4)));
					arrindustryname.add(correctNull(rs.getString(5)));
					arryCol=new ArrayList();				 
					arryCol.add(rs.getString("comapp_id"));
					arryCol.add(rs.getString("comapp_companyname"));
					arryCol.add(rs.getString("comapp_companyid"));
					arryCol.add(rs.getString("comapp_comtype"));
					arryCol.add(rs.getString("ind_name"));				
					arryRow.add(arryCol);
				}
				
				hshRecord.put("arrcomappid",arrcomappid);
				hshRecord.put("arrcomname",arrcomname);
				hshRecord.put("arrcomid",arrcomid);
				hshRecord.put("arrcomtype",arrcomtype);
				hshRecord.put("arrindustryname",arrindustryname);
				hshRecord.put("hidPageType",correctNull((String)hshValues.get("hidPageType")));
				hshRecord.put("arryRow",arryRow);


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
					throw new EJBException("Error closing connection"+e1);
				}
			}
			return hshRecord;
		}
		public HashMap getRAMParameters(HashMap hshValues) 
		{
			ResultSet rs=null;
			String strQuery;
			String strCompanycode="";
			boolean bstate=false;
			HashMap hshRecord=new HashMap();
			try
			{
				strCompanycode=correctNull((String)hshValues.get("comapp_id"));
				if(strCompanycode.equalsIgnoreCase(""))
				{
					strCompanycode=Helper.correctNull((String)hshValues.get("comapp_companyid"));
				}
				strQuery=SQLParser.getSqlQuery("selRAMparameters^"+strCompanycode);
				rs=DBUtils.executeQuery(strQuery);
				bstate=rs.next();
				if(bstate)
				{
					hshRecord.put("companysectorcode",correctNull((String)rs.getString("companysectorcode")));
					hshRecord.put("companycountrycode",correctNull((String)rs.getString("companycountrycode")));
					hshRecord.put("marketsegment",correctNull((String)rs.getString("marketsegment")));
					hshRecord.put("rbiindustrycode",correctNull((String)rs.getString("rbiindustrycode")));
					hshRecord.put("standardhost",correctNull((String)rs.getString("standardhost")));
					hshRecord.put("ismarketparticipant",correctNull((String)rs.getString("marketparticipant")));
					hshRecord.put("iscommercialbank",correctNull((String)rs.getString("commercialbank")));
					hshRecord.put("ispsenotified",correctNull((String)rs.getString("psenotified")));
					hshRecord.put("iscentralsoverign",correctNull((String)rs.getString("centralsoverign")));
					hshRecord.put("flag","Y");	
					hshRecord.put("comapp_id",strCompanycode);
					hshRecord.put("comapp_companyid",strCompanycode);
				}
				else
				{
					hshRecord.put("flag","N");	
					hshRecord.put("comapp_id",strCompanycode);
					hshRecord.put("comapp_companyid",strCompanycode);
				}
				
			}catch(Exception e)
			{
				throw new EJBException(e.getMessage());
			}finally
			{
				try
				{
					if(rs!=null)
					{
						rs.close();
					}
				}catch(Exception ex)
				{
					throw new EJBException("Error in closing connection in getRAMParameters");
				}
			}
			return hshRecord;
		}
	
		
		public HashMap getBSRCode(HashMap hshValues) 
		{
			HashMap hshResult=new HashMap();
			ResultSet rs=null;
			ArrayList arrCol = new ArrayList();
			ArrayList arrValue = new ArrayList();
			String strindustry="",strtype="";
			try
			{
				strindustry=Helper.correctNull((String)hshValues.get("txt_bsrcode"));
				strtype=Helper.correctNull((String)hshValues.get("cat"));
				if(strtype.equalsIgnoreCase("1"))
				{
					rs = DBUtils.executeLAPSQuery("sel_industrydetailsbycode^"+strindustry);
				}
				else if(strtype.equalsIgnoreCase("2"))
				{
					rs = DBUtils.executeLAPSQuery("sel_industrydetailsbyname^"+strindustry);
				}
					
				while(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(correctNull((String)rs.getString("ind_bsr_code")));
					arrCol.add(correctNull((String)rs.getString("ind_name")));
					arrCol.add(correctNull((String)rs.getString("ind_no")));
					arrCol.add(correctNull((String)rs.getString("ind_grpcode")));
					arrCol.add(correctNull((String)rs.getString("ind_grp")));
					arrValue.add(arrCol);
				}
				hshResult.put("arrBSRCode",arrValue);
			}
			catch(Exception e)
			{
				throw new EJBException(e.getMessage());
			}finally
			{
				try
				{
					if(rs!=null)
					{
						rs.close();
					}
				}catch(Exception ex)
				{
					throw new EJBException("Error in closing connection in getBSRCode");
				}
			}
			
			return hshResult;
		}
		
		public HashMap renewComappMasterData(HashMap hshValues)
		{

			HashMap hshQueryValues=new HashMap();
			HashMap hshQuery=new HashMap();
			ArrayList arrValues=new ArrayList();
			String strAppCode = "";
			HashMap hshRecord = new HashMap();
			int intUpdateQuerySize=0;
			try
			{
				strAppCode = getId();
				String strOldAppId = Helper.correctNull((String)hshValues.get("comapp_oldid"));
				String strAppId = Helper.correctNull((String)hshValues.get("comapp_id"));
				
				//copying the datas with commap_id
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdateQuerySize++;
				arrValues.add(strAppCode);
				arrValues.add(strOldAppId);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","comappmasterrenew");
				hshQueryValues.put(""+intUpdateQuerySize,hshQuery);
				
				// update renew column in comapplicant table
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdateQuerySize++;
				arrValues.add("Y");
				arrValues.add(strAppId);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","comappmasterupdaterenew");
				hshQueryValues.put(""+intUpdateQuerySize,hshQuery);

				// insert data in to comappfactorydetails table
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdateQuerySize++;
				arrValues.add(strAppCode);
				arrValues.add(strAppId);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","factorydetailsrenew");
				hshQueryValues.put(""+intUpdateQuerySize,hshQuery);
				
				// insert data in to comapp_company_divisions table
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdateQuerySize++;
				arrValues.add(strAppCode);
				arrValues.add(strAppId);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","divisiondetailsrenew");
				hshQueryValues.put(""+intUpdateQuerySize,hshQuery);
				
				//insert data in to comapp_company_divisions table
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdateQuerySize++;
				arrValues.add(strAppCode);
				arrValues.add(strAppId);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","reldetailsrenew");
				hshQueryValues.put(""+intUpdateQuerySize,hshQuery);
				
				//insert data in to KYC norms table
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdateQuerySize++;
				arrValues.add(strAppCode);
				arrValues.add(strAppId);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","kycnormsrenew");
				hshQueryValues.put(""+intUpdateQuerySize,hshQuery);
				
				hshQueryValues.put("size",""+intUpdateQuerySize);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");		
		
				hshRecord.put("comapp_id",strAppCode);
				hshRecord = getData(hshRecord);
			}
			catch(Exception ce)
			{
				throw new EJBException("Error in renewApplicantData  "+ce.toString());
			}
			return hshRecord;
		
		}
		public HashMap getSetupBSRCode(HashMap hshValues) 
		{
			HashMap hshResult=new HashMap();
			ResultSet rs=null;
			ArrayList arrCol = new ArrayList();
			ArrayList arrValue = new ArrayList();
			String strindustry="",strtype="";
			try
			{
				strindustry=Helper.correctNull((String)hshValues.get("txt_bsrcode"));
				strtype=Helper.correctNull((String)hshValues.get("cat"));
				if(strtype.equalsIgnoreCase("1"))
				{
					rs = DBUtils.executeLAPSQuery("industry_master_searchby_bsrcode^"+strindustry);
				}
				else if(strtype.equalsIgnoreCase("2"))
				{
					rs = DBUtils.executeLAPSQuery("industry_master_searchby_name^"+strindustry);
				}
					
				while(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(correctNull((String)rs.getString("ind_bsr_code")));
					arrCol.add(correctNull((String)rs.getString("ind_name")));
					arrCol.add(correctNull((String)rs.getString("ind_no")));
					arrCol.add(correctNull((String)rs.getString("ind_grpcode")));
					arrCol.add(correctNull((String)rs.getString("ind_grp")));
					arrCol.add(correctNull((String)rs.getString("ind_active")));
					arrValue.add(arrCol);
				}
				hshResult.put("arrBSRCode",arrValue);
			}
			catch(Exception e)
			{
				throw new EJBException(e.getMessage());
			}finally
			{
				try
				{
					if(rs!=null)
					{
						rs.close();
					}
				}catch(Exception ex)
				{
					throw new EJBException("Error in closing connection in getBSRCode");
				}
			}
			
			return hshResult;
		}
		public HashMap getMasterSearch(HashMap hshValues) 
		{
			String strQuery="",strQuery1= "";
			String absPosition="";
			ResultSet rs=null;
			ResultSet rs1=null,rs2=null,rs4=null,rs5=null;
			HashMap hshResult=new HashMap();
			ArrayList arryRow=new ArrayList();
			ArrayList arryCol=null;
			String strradioValues=null;
			String strSearchText=null;
			String strCheckCBS=null;
			String cbsdata="FALSE";
			String strOrgname="";
			String strOrgNameFromSolID="";
			String strLAPSIDFromCBSID="";
			String strText="";
			String strappno =Helper.correctNull((String)hshValues.get("strAppno"));//corp
			if(strappno.equalsIgnoreCase("")){
				strappno =Helper.correctNull((String)hshValues.get("strappno"));//retail
			}
			String strAppSubType ="";
			
			try
			{			
				String strOrgSelect=correctNull((String)hshValues.get("strOrgSelect"));
				if(strOrgSelect.equalsIgnoreCase("001001"))
				{
					strOrgSelect="001";
				}
				absPosition = correctNull((String)hshValues.get("hid_rowcount"));	
				/*
				 * By default value for the field checkcbs is coming as "Y". 
				 * Bcoz they are passing the value Y
				 */
				
				strCheckCBS = correctNull((String)hshValues.get("checkcbs"));
				strOrgname=correctNull((String)hshValues.get("strOrgName"));
				
				//strQuery= SQLParser.getSqlQuery("reailmastsearch^"+strOrgSelect+"%");
				strSearchText=Helper.correctSingleQuote(correctNull((String)hshValues.get("txtsearch")));
				if(strSearchText.equals(""))
				{
					strSearchText="%";
				}
				strradioValues=correctNull((String)hshValues.get("radiobutton"));
				if(strradioValues.equalsIgnoreCase("first"))
				{
					strText= " and upper(perapp_fname) like upper('%"+strSearchText+"%') Order by perapp_fname";	
				}
				else if(strradioValues.equalsIgnoreCase("CBSID"))
				{
					strText=  " and perapp_cbsid = '"+strSearchText+"' Order by perapp_fname";
				}
				else if(strradioValues.equalsIgnoreCase("MSMECBSIDSEARCH"))
				{
					strText=  " and perapp_cbsid = '"+strSearchText+"' Order by perapp_fname";
				}
				else if(strradioValues.equalsIgnoreCase("LAPSID"))
				{
					strText=" and perapp_oldid = '"+strSearchText+"' Order by perapp_fname";
				}
				else if(strradioValues.equalsIgnoreCase("PANNO"))
				{
					strText= " and perapp_panno = '"+strSearchText+"' Order by perapp_fname";
				}
				else 
				{
					strText=  " Order by perapp_fname";	
				}
				/*
				 * Other than Name search all other search options are global
				 */
				
				if(strradioValues.equalsIgnoreCase("first"))
				{
					strOrgSelect=strOrgSelect;
				}
				else
				{
					strOrgSelect="001";
				}
				strQuery= SQLParser.getSqlQuery("reailmastsearch^"+strOrgSelect+"%"+"^"+strText);
				//rs=DBUtils.executeQuery("reailmastsearch^"+strOrgSelect+"%"+"^"+strText);
				rs=DBUtils.executeQuery(strQuery);
				
				rs.last();
				int RowCount = rs.getRow();		
				if(strradioValues.equalsIgnoreCase("CBSIDSEARCH") && strCheckCBS.equalsIgnoreCase("Y") ||
						strradioValues.equalsIgnoreCase("MSMECBSIDSEARCH") && strCheckCBS.equalsIgnoreCase("Y"))//No need to process
				{
					boolean exbool=false;

					/*if(rs!=null)rs.close();
					boolean exbool=false;
					strQuery= SQLParser.getSqlQuery("getperapplicantbycbsid^"+strSearchText);
					rs=DBUtils.executeQuery(strQuery); 
					if(rs.next())
					{
						hshResult.put("exapplicantid",correctNull(rs.getString("perapp_id")));
						hshResult.put("exbranch",correctNull(rs.getString("perapp_branchcode")));
						hshResult.put("exbranchname",correctNull(rs.getString("org_name")));
						hshResult.put("exbool","true");
						exbool=true;
					}
					else
					{
						strQuery= SQLParser.getSqlQuery("cbscustsearch^"+strSearchText+"^"+strOrgSelect+"%");
						cbsdata="TRUE";
						if(rs!=null)rs.close();
						rs=DBUtils.executeQuery(strQuery);
					}
					if(exbool)
					{
						if(rs!=null)rs.close();
					}*/
					
					/*
					 * Added by prakash. The customer search should always hit CBS DataBase
					 */
					
					if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
					{
						strQuery=SQLParser.getCBSSqlQuery("cbscusmastersearch_newconnection^"+strSearchText);
						rs=DBUtils.executeQueryCBSConnection(strQuery);
					}
					else
					{
						strQuery= SQLParser.getSqlQuery("cbscusmastersearch^"+strSearchText);
						rs=DBUtils.executeQuery(strQuery); 
					}
				
					cbsdata="TRUE";
					
				}
				
				rs.last();
				RowCount = rs.getRow();		
				if(RowCount==0 && strradioValues.equalsIgnoreCase("LAPSID"))
				{
					rs=DBUtils.executeQuery(strQuery);
				}
				rs.last();
				RowCount = rs.getRow();
				if(RowCount==0 && strradioValues.equalsIgnoreCase("PANNO"))
				{
					rs=DBUtils.executeQuery(strQuery);
				}
				rs.beforeFirst();				
				if(RowCount != 0)
				{					
					if (!absPosition.equals("0"))
					{
						if(Integer.parseInt(absPosition) > RowCount)
						{
							rs.absolute(RowCount);
						}
						else
						{
							rs.absolute(Integer.parseInt(absPosition));
						}				
					}			
				}
				while(rs.next())
				{
					arryCol=new ArrayList();
					if(strradioValues.equalsIgnoreCase("CBSIDSEARCH") || strradioValues.equalsIgnoreCase("MSMECBSIDSEARCH"))// No need to process
					{
						arryCol.add(correctNull((String)rs.getString("cust_id")));//0
						arryCol.add(correctNull((String)rs.getString("cust_name")).toUpperCase());//1
						arryCol.add(correctNull((String)rs.getString("pan_gir_num")));//2
						String strSolID=Helper.correctNull((String)rs.getString("solid"));
						if(!strSolID.equalsIgnoreCase(""))
						{
							if(rs1!=null)
							{
								rs1.close();
							}
							String strQuery2=SQLParser.getSqlQuery("selectorgappl^"+strSolID);
							rs1=DBUtils.executeQuery(strQuery2);
							if(rs1.next())
							{
								strOrgNameFromSolID=Helper.correctNull((String)rs1.getString("org_name"));
							}
						}
						arryCol.add(strOrgNameFromSolID);//3
						String strCBSID=Helper.correctNull((String)rs.getString("cust_id"));
						if(!strCBSID.equalsIgnoreCase(""))
						{
							if(rs1!=null)
							{
								rs1.close();
							}
							strQuery=SQLParser.getSqlQuery("sel_lapsidfromcbsid^"+strCBSID);
							rs1=DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{
								strLAPSIDFromCBSID=Helper.correctNull((String)rs1.getString("perapp_oldid"));
							}
						}
						arryCol.add(strLAPSIDFromCBSID);//4
						arryCol.add(correctNull((String)rs.getString("cust_id")));//5
						arryCol.add(cbsdata);//6
						
						//for each customer Id , add his address and etc.
				if(!strLAPSIDFromCBSID.equalsIgnoreCase(""))
				{
						if(rs1!=null)
							{ rs1.close();}
						strQuery=SQLParser.getSqlQuery("sel_customerdetail^"+strLAPSIDFromCBSID);//add query here
						rs1=DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							String strCityDesc="",strDistcode="",strDistDesc="",strCitycode="",strStatecode="";
							if(Helper.correctNull(rs1.getString("INDINFO_RESIDENT_STATUS")).equalsIgnoreCase("Y"))
							{
								arryCol.add(correctNull((String)rs1.getString("CON_PERMADDR1"))+ " "+correctNull((String)rs1.getString("CON_PERMADDR2"))+ " "+correctNull((String)rs1.getString("CON_PERMVILLAGE")));//7
								arryCol.add(correctNull((String)rs1.getString("CON_PERMCITY")));//8
								arryCol.add(correctNull((String)rs1.getString("CON_PERMDIST")));//9
								arryCol.add(correctNull((String)rs1.getString("CON_PERMSTATE")));//10
								arryCol.add(correctNull((String)rs1.getString("CON_PERMZIP")));//11
								arryCol.add(correctNull((String)rs1.getString("CON_PERMPHONE")));//12
								arryCol.add(correctNull((String)rs1.getString("CON_PERMFAX")));//13
								
								strCitycode=correctNull((String)rs1.getString("CON_PERMCITY"));
								strStatecode = Helper.correctNull((String)rs1.getString("CON_PERMSTATE"));
								strDistcode=correctNull((String)rs1.getString("CON_PERMDIST"));
							}
							else
							{
								arryCol.add(correctNull((String)rs1.getString("CON_COMADDR1"))+ " "+correctNull((String)rs1.getString("CON_COMADDR2"))+ " "+correctNull((String)rs1.getString("CON_COMVILLAGE")));//7
								arryCol.add(correctNull((String)rs1.getString("CON_COMCITY")));//8
								arryCol.add(correctNull((String)rs1.getString("CON_COMDIST")));//9
								arryCol.add(correctNull((String)rs1.getString("CON_COMSTATE")));//10
								arryCol.add(correctNull((String)rs1.getString("CON_COMZIP")));//11
								arryCol.add(correctNull((String)rs1.getString("CON_COMPHONE")));//12
								arryCol.add(correctNull((String)rs1.getString("CON_COMFAX")));//13
								
								strCitycode=correctNull((String)rs1.getString("CON_COMCITY"));
								strStatecode = Helper.correctNull((String)rs1.getString("CON_COMSTATE"));
								strDistcode=correctNull((String)rs1.getString("CON_COMDIST"));
							}
							
							if(!strCitycode.equalsIgnoreCase(""))
							{				
							if(rs1!=null)
							{
								rs1.close();
							}
							rs1=DBUtils.executeLAPSQuery("sel_citynamebycode^"+strCitycode);
							if(rs1.next())
							{
								
								strCityDesc = Helper.correctNull((String)rs1.getString("city_name"));					
							}
							}
							arryCol.add(strCityDesc);//14
							if(rs1!=null)
							{
								rs1.close();
							}
							
							
							
							String strStateDesc="";
							if(!strStatecode.equalsIgnoreCase(""))
							{				
				
							rs1=DBUtils.executeLAPSQuery("sel_statenamebycode^"+strStatecode);
							if(rs1.next())
							{
								strStateDesc = Helper.correctNull((String)rs1.getString("state_name"));					
							}
							}
							arryCol.add(strStateDesc);//15
							
							
							

							
							if(!strDistcode.equalsIgnoreCase(""))
							{				
							if(rs1!=null)
							{
								rs1.close();
							}
							rs1=DBUtils.executeLAPSQuery("sel_distnamebycode^"+strDistcode);
							if(rs1.next())
							{
								
								strDistDesc = Helper.correctNull((String)rs1.getString("district_desc"));//15					
							}
							}
							arryCol.add(strDistDesc);//16
						}
					}
						else
						{
							arryCol.add("");//7
							arryCol.add("");//8
							arryCol.add("");//9
							arryCol.add("");//10
							arryCol.add("");//11
							arryCol.add("");//12
							arryCol.add("");//13
							arryCol.add("");//14
							arryCol.add("");//15
							arryCol.add("");//16
						}
						arryCol.add("");//17
						arryCol.add(correctNull(rs.getString("age")));//18
						if(rs1!=null){rs1.close();}
					}
					else
					{
						arryCol.add(correctNull((String)rs.getString("perapp_id")));//0
						arryCol.add(correctNull((String)rs.getString("perapp_fname")).toUpperCase());//1
						arryCol.add(correctNull((String)rs.getString("perapp_panno")));//2
						arryCol.add(correctNull((String)rs.getString("org_name")));//3
						arryCol.add(correctNull((String)rs.getString("perapp_oldid"))); //Shahul 4
						arryCol.add(correctNull((String)rs.getString("perapp_cbsid")));//5
						arryCol.add(cbsdata);//6
						
						//for each customer Id , add his address and etc.
						String cust_id=correctNull((String)rs.getString("perapp_id"));
						if(rs1!=null)
							{ rs1.close();}
						strQuery=SQLParser.getSqlQuery("sel_customerdetail^"+cust_id);//add query here
						rs1=DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							
							String strCityDesc="",strDistcode="",strDistDesc="",strCitycode="",strStatecode="";
							if(Helper.correctNull(rs1.getString("INDINFO_RESIDENT_STATUS")).equalsIgnoreCase("Y"))
							{
								arryCol.add(correctNull((String)rs1.getString("CON_PERMADDR1"))+ " "+correctNull((String)rs1.getString("CON_PERMADDR2"))+ " "+correctNull((String)rs1.getString("CON_PERMVILLAGE")));//7
								arryCol.add(correctNull((String)rs1.getString("CON_PERMCITY")));//8
								arryCol.add(correctNull((String)rs1.getString("CON_PERMDIST")));//9
								arryCol.add(correctNull((String)rs1.getString("CON_PERMSTATE")));//10
								arryCol.add(correctNull((String)rs1.getString("CON_PERMZIP")));//11
								arryCol.add(correctNull((String)rs1.getString("CON_PERMPHONE")));//12
								arryCol.add(correctNull((String)rs1.getString("CON_PERMFAX")));//13
								
								strCitycode=correctNull((String)rs1.getString("CON_PERMCITY"));
								strStatecode = Helper.correctNull((String)rs1.getString("CON_PERMSTATE"));
								strDistcode=correctNull((String)rs1.getString("CON_PERMDIST"));
							}
							else
							{
								arryCol.add(correctNull((String)rs1.getString("CON_COMADDR1"))+ " "+correctNull((String)rs1.getString("CON_COMADDR2"))+ " "+correctNull((String)rs1.getString("CON_COMVILLAGE")));//7
								arryCol.add(correctNull((String)rs1.getString("CON_COMCITY")));//8
								arryCol.add(correctNull((String)rs1.getString("CON_COMDIST")));//9
								arryCol.add(correctNull((String)rs1.getString("CON_COMSTATE")));//10
								arryCol.add(correctNull((String)rs1.getString("CON_COMZIP")));//11
								arryCol.add(correctNull((String)rs1.getString("CON_COMPHONE")));//12
								arryCol.add(correctNull((String)rs1.getString("CON_COMFAX")));//13
								
								strCitycode=correctNull((String)rs1.getString("CON_COMCITY"));
								strStatecode = Helper.correctNull((String)rs1.getString("CON_COMSTATE"));
								strDistcode=correctNull((String)rs1.getString("CON_COMDIST"));
							}
							
							if(!strCitycode.equalsIgnoreCase(""))
							{				
							if(rs1!=null)
							{
								rs1.close();
							}
							rs1=DBUtils.executeLAPSQuery("sel_citynamebycode^"+strCitycode);
							if(rs1.next())
							{
								
								strCityDesc = Helper.correctNull((String)rs1.getString("city_name"));					
							}
							}
							arryCol.add(strCityDesc);//14
							if(rs1!=null)
							{
								rs1.close();
							}
							
							
							
							String strStateDesc="";
							if(!strStatecode.equalsIgnoreCase(""))
							{				
				
							rs1=DBUtils.executeLAPSQuery("sel_statenamebycode^"+strStatecode);
							if(rs1.next())
							{
								strStateDesc = Helper.correctNull((String)rs1.getString("state_name"));					
							}
							}
							arryCol.add(strStateDesc);//15
							
							
							

							
							if(!strDistcode.equalsIgnoreCase(""))
							{				
							if(rs1!=null)
							{
								rs1.close();
							}
							rs1=DBUtils.executeLAPSQuery("sel_distnamebycode^"+strDistcode);
							if(rs1.next())
							{
								
								strDistDesc = Helper.correctNull((String)rs1.getString("district_desc"));//15					
							}
							}
							arryCol.add(strDistDesc);//16
						}
						else
						{
							arryCol.add("");//7
							arryCol.add("");//8
							arryCol.add("");//9
							arryCol.add("");//10
							arryCol.add("");//11
							arryCol.add("");//12
							arryCol.add("");//13
							arryCol.add("");//14
							arryCol.add("");//15
							arryCol.add("");//16
						}
						if(rs1!=null){rs1.close();}
						arryCol.add(correctNull((String)rs.getString("perapp_profilestatus")));//17
						arryCol.add(correctNull(rs.getString("age")));//18
					//	if(rs!=null)rs.close();
						String strpartnerchk="N";
						String strMinority="N";
						String strMinorityCommunity="";
						String strIndMinority="";
						strQuery= SQLParser.getSqlQuery("sel_partnersminoritychk^"+strText);
						rs4=DBUtils.executeQuery(strQuery); 
						if(rs4.next())
						{
							strMinorityCommunity=correctNull(rs4.getString("COMINFO_MINORITY_COMMUNITY"));
							if(strMinorityCommunity.equalsIgnoreCase("")){
								strpartnerchk="Y";
							}
						}
						arryCol.add(strpartnerchk);//19
						strQuery= SQLParser.getSqlQuery("sel_indpartnersminoritychk^"+strText);
						rs5=DBUtils.executeQuery(strQuery); 
						if(rs5.next())
						{
							strIndMinority=correctNull(rs5.getString("INDINFO_MINORITY"));
							if(strIndMinority.equalsIgnoreCase("")){
								strMinority="Y";
							}
						}
						arryCol.add(strMinority);//20

						hshResult.put("strpartnerchk",strpartnerchk);
		         Log.info("<<<<<<<<<<<<<<<====strpartnerchk====>>>>>>>>>>>>>>>>"+strpartnerchk);
					}
					arryRow.add(arryCol);
				}
				hshResult.put("arryRow",arryRow);
				hshResult.put("count",Helper.correctNull((String)hshValues.get("count")));
				hshResult.put("appCount",Helper.correctNull((String)hshValues.get("appCount")));
				
			if (rs1 != null) {
				rs1.close();
			}
			rs1 = DBUtils.executeLAPSQuery("seldigiprd_appl^"
					+ strappno);
			if (rs1.next()) {
				strAppSubType = Helper.correctNull((String) rs1
						.getString("APP_LOANSUBTYPE_DIGI"));
			}
			
			if (rs1 != null) {
			rs1.close();
		}
		String corpAppID = "", corpcoappID = "", retAppID = "", strSrchPERAPPPANNO = "", strSrchCONMOBILE = "", 
		strSrchKYCIDPROOFREF = "", 
		strPERAPPPANNO = "", strCONMOBILE = "", strKYCIDPROOFREF = "";
		strQuery = SQLParser.getSqlQuery("reailmastsearch_cust^"
				+ strOrgSelect + "%" + "^" + strText);
		rs = DBUtils.executeQuery(strQuery);
		if (rs.next()) {
			strSrchPERAPPPANNO = Helper.correctNull((String) rs
					.getString("PERAPP_PANNO"));
			strSrchCONMOBILE = Helper.correctNull((String) rs
					.getString("CON_MOBILE"));
			strSrchKYCIDPROOFREF = Helper.correctNull((String) rs
					.getString("perapp_oldid"));
		}
		if (!strSrchPERAPPPANNO.equalsIgnoreCase("")
				|| !strSrchCONMOBILE.equalsIgnoreCase("")
				|| !strSrchKYCIDPROOFREF.equalsIgnoreCase("")) {
			if (strAppSubType.equalsIgnoreCase("PC")) {
				rs1 = DBUtils.executeLAPSQuery("com_demographics_cma_sel^"
						+ strappno);
				if (rs1.next()) {
					corpAppID = Helper.correctNull((String) rs1
							.getString("DEMO_COMAPPNEWID"));
					if (!corpAppID.equalsIgnoreCase("")) {
						rs2 = DBUtils
								.executeLAPSQuery("com_companysearchdetails_app^"
										+ corpAppID);
						if (rs2.next()) {
							strPERAPPPANNO = Helper.correctNull((String) rs2
									.getString("PERAPP_PANNO"));
							strCONMOBILE = Helper.correctNull((String) rs2
									.getString("CON_MOBILE"));
							strKYCIDPROOFREF = Helper
									.correctNull((String) rs2
											.getString("kyc_idproofref"));
						}
					}
				}
				if (strSrchPERAPPPANNO.equalsIgnoreCase(strPERAPPPANNO)
						|| strSrchCONMOBILE.equalsIgnoreCase(strCONMOBILE)
						|| strSrchKYCIDPROOFREF
								.equalsIgnoreCase(strKYCIDPROOFREF)) {
					hshResult.put("ALERT", "N");

				}
				if (rs1 != null) {
					rs1.close();
				}
				rs1 = DBUtils.executeLAPSQuery("com_companydetails_coapp^"
						+ strappno);
				while (rs1.next()) {
					corpcoappID = Helper.correctNull((String) rs1
							.getString("com_compdtappid"));
					if (!corpcoappID.equalsIgnoreCase("")) {
						if (rs2 != null) {
							rs2.close();
						}
						rs2 = DBUtils
								.executeLAPSQuery("com_companysearchdetails_app^"
										+ corpcoappID);
						while (rs2.next()) {
							strPERAPPPANNO = Helper.correctNull((String) rs2
									.getString("PERAPP_PANNO"));
							strCONMOBILE = Helper.correctNull((String) rs2
									.getString("CON_MOBILE"));
							strKYCIDPROOFREF = Helper
									.correctNull((String) rs2
											.getString("kyc_idproofref"));
							if (strSrchPERAPPPANNO
									.equalsIgnoreCase(strPERAPPPANNO)
									|| strSrchCONMOBILE
											.equalsIgnoreCase(strCONMOBILE)
									|| strSrchKYCIDPROOFREF
											.equalsIgnoreCase(strKYCIDPROOFREF)) {
								hshResult.put("ALERT", "N");

							}
						}
					}
				}
				if (rs1 != null) {
					rs1.close();
				}
			} else if (strAppSubType.equalsIgnoreCase("PR")) {
				rs1 = DBUtils
						.executeLAPSQuery("sel_guar_check^"
								+ strappno);
				while (rs1.next()) {
					retAppID = Helper.correctNull((String) rs1
							.getString("demo_appid"));
					if (!retAppID.equalsIgnoreCase("")) {
						if (rs2 != null) {
							rs2.close();
						}
						rs2 = DBUtils
								.executeLAPSQuery("com_companysearchdetails_app^"
										+ retAppID);
						while (rs2.next()) {
							strPERAPPPANNO = Helper.correctNull((String) rs2
									.getString("PERAPP_PANNO"));
							strCONMOBILE = Helper.correctNull((String) rs2
									.getString("CON_MOBILE"));
							strKYCIDPROOFREF = Helper
									.correctNull((String) rs2
											.getString("kyc_idproofref"));
							if (strSrchPERAPPPANNO
									.equalsIgnoreCase(strPERAPPPANNO)
									|| strSrchCONMOBILE
											.equalsIgnoreCase(strCONMOBILE)
									|| strSrchKYCIDPROOFREF
											.equalsIgnoreCase(strKYCIDPROOFREF)) {
								hshResult.put("ALERT", "N");

							}
						}
					}
				}
			}
		}
			}
			catch(Exception e)
			{
				throw new EJBException("Error in getMasterSearch "+e.getMessage());
			}
			finally
			{
				try
				{
					if(rs!=null)
					{
						rs.close();
					}
					if(rs1!=null)
					{
						rs1.close();
					}
				}
				catch(Exception e)
				{
					throw new EJBException("Error in closing Connection "+e.getMessage());
				}
			}
			return hshResult;
		}
   public void updateComfinancialparticularsdata(HashMap hshValues) 
	 {
    	
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshRecord=new HashMap();
		ArrayList arrValues = new ArrayList();
		
		String hidDemoId=correctNull((String)hshValues.get("hidDemoId"));
		String  status="Y";
		
		String[] strtxt_particular=null;
		String strhidfield[]=null;
		
		try
		{
			String strAction = correctNull((String)hshValues.get("hidAction"));
			//String strhidfield[]={"SFM","SMFS","BOSS","LOAM","AIDA","RPER","CABB"};
			strhidfield=((String[]) hshValues.get("hidfield"));
			strtxt_particular=((String[]) hshValues.get("txt_particular"));
			int count=strhidfield.length;
			
			if((strAction.equalsIgnoreCase("update"))||(strAction.equalsIgnoreCase("delete")))
			{
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(hidDemoId);
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId", "del_com_Financialparticulars");
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
		    }
			
			if(strAction.equalsIgnoreCase("update"))
			{
				for(int i=0;i<count;i++)
				{
				 		
				 		arrValues = new ArrayList();
				 		hshQueryValues = new HashMap();
				 		
				 		hshQuery.put("strQueryId","ins_com_Financialparticulars");
				 		arrValues.add(hidDemoId);
				 		arrValues.add(String.valueOf(i+1));
				 		arrValues.add(strhidfield[i]);
				 		arrValues.add(strtxt_particular[i]);
				 		hshQuery.put("arrValues",arrValues);
				 		hshQueryValues.put("1",hshQuery);
				 		hshQueryValues.put("size","1");	
				 		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
		}
				
		catch(Exception ce)
		{
			throw new EJBException("Error in updateData "+ce.toString());
		}
       	
	 }
	    
	    public HashMap getComfinancialparticularsdata(HashMap hshValues) 
	    {
	    	
	    	ResultSet rs = null;
			String strQuery=null;
			String strQuery1=null;
			ResultSet rs1=null;
			String strhidfield=null;
			HashMap hshResult = new HashMap();
			String strAppStatus="";
			java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
			nf.setGroupingUsed(false);
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			
			String hidDemoId=correctNull((String)hshValues.get("hidDemoId"));
			
			try
			{
				strAppStatus=Helper.correctNull((String)hshValues.get("hidappstatus"));
				
				strQuery=SQLParser.getSqlQuery("sel_com_Financialparticulars^"+hidDemoId);
				rs=DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{
					strhidfield=Helper.correctNull((String)rs.getString("comfin_fieldname"));
					
					if(!strhidfield.equalsIgnoreCase(""))
					{
						hshResult.put("amount"+strhidfield,nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("comfin_amount")))));
						
					}
					
				}
				
				MastApplicantBean mast=new MastApplicantBean();
				HashMap prof=new HashMap();
				HashMap profile=new HashMap();
				prof.put("profile_id",hidDemoId);
				profile=(HashMap)mast.getCustomerProfileStatus(prof);
				hshResult.put("strIncompletepage", Helper.correctNull((String)profile.get("strIncompletepage")));
				
				String strProfilestatus="";
				if(rs!=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("getprofilestatusfromdemographic^"+hidDemoId);
				if(rs.next())
				{
					strProfilestatus=Helper.correctNull((String)rs.getString("perapp_profilestatus"));
					
				}	
				else
				{
					strProfilestatus="";
				}
				hshResult.put("strProfilestatus",strProfilestatus);
				hshResult.put("appstatus", strAppStatus);
				
			}
			catch(Exception c)
			{
				throw new EJBException("Error in updateData "+c.toString());
			}
				return hshResult;
	    	
	    }
	    public HashMap getGrpConcernType(HashMap hshValues) 
		{
			ResultSet rs=null;
			String strType="";
			ArrayList arrRow=new ArrayList();
			ArrayList arrCol=new ArrayList();

			try
			{
				strType =correctNull((String)hshValues.get("strconcerntype"));
				rs=DBUtils.executeLAPSQuery("sel_custprofBAstaticdata^"+strType);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull(rs.getString("stat_data_desc")));
					arrCol.add(Helper.correctNull(rs.getString("stat_data_desc1")));
					arrRow.add(arrCol);
				}
				
				hshValues.put("arrRow", arrRow);
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
					throw new EJBException("Error closing connection"+e1);
				}
			}
			return hshValues;
		}
		
		
}

