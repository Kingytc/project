package com.sai.laps.ejb.borrowersearch;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import java.sql.CallableStatement;
import java.sql.Connection;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.ConnectionFactory;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "borrowersearchBean", mappedName = "borrowersearchHome")
@Remote (borrowersearchRemote.class)
public class borrowersearchBean extends BeanAdapter
{
	static Logger log=Logger.getLogger(borrowersearchBean.class);
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public HashMap getData(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList arr = null;
		String strQuery="";		
		try
		{
			hshRecord = new HashMap();
			arr =  new ArrayList();
			strQuery = SQLParser.getSqlQuery("glpoption");
			rs =DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				arr.add(Helper.correctNull(rs.getString(1)));	
				arr.add(Helper.correctNull(rs.getString(2)));	
				arr.add(Helper.correctNull(rs.getString(3)));	
				arr.add(Helper.correctNull(rs.getString(4)));	
				arr.add(Helper.correctNull(rs.getString(5)));	
				arr.add(Helper.correctNull(rs.getString(6)));	
			}
			hshRecord.put("arr",arr);				
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
	
	public HashMap getDataFinal(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = null;
		String strid="",strQuery="",status="",appno="",strProposalType="";
		ArrayList vecval =  new ArrayList();
		ArrayList vecdata =  new ArrayList();
		String hidPageType="";
		String token="";
		StringBuilder strcomappidList=null;
		String strorghead="";
		String strLoantype="";
		String strOrgSelect="";
		String strhidModuleType="";
		String strApplicantid="",strprofilestatus="",strhidCategoryType="";
		boolean apprenewed=false;
		String sel_cat="";
		try
		{
			hshRecord = new HashMap();
			
			strOrgSelect = Helper.correctNull((String)hshRequestValues.get("strOrgSelect"));
			//strhidCategoryType = Helper.correctNull((String)hshRequestValues.get("hidCategoryType"));
			strhidModuleType = Helper.correctNull((String)hshRequestValues.get("hidModuleType"));
			sel_cat = Helper.correctNull((String)hshRequestValues.get("select_cat"));
			if(strOrgSelect.equalsIgnoreCase("001001"))
			{
				strOrgSelect="001";
			}
			
			String ib =Helper.correctNull((String)hshRequestValues.get("Inbox"));
			strid = correctNull((String)hshRequestValues.get("id"));
			if(strid.equalsIgnoreCase(""))
			{
				strid=Helper.correctNull((String)hshRequestValues.get("comid"));
			}
			strQuery = SQLParser.getSqlQuery("UniqAppidList^"+strid);
			
			rs =DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strApplicantid=correctNull((String)rs.getString("perapp_id"));
				strprofilestatus=correctNull((String)rs.getString("perapp_profilestatus"));
				apprenewed=true;
			}
			if(rs!=null)
			{
				rs.close();
			}

			if(strhidModuleType.equalsIgnoreCase("AGR"))
			{
				strhidCategoryType="A";
			}
			else
			{
				strhidCategoryType="C";
			}
			
			appno= correctNull((String)hshRequestValues.get("appno"));
			appno=appno.trim();
			String strAppno="";
			
			if(sel_cat.equalsIgnoreCase("1"))//Inward number search
			{
				strAppno="and app_inwardno='"+appno+"'";
			}
			else if (sel_cat.equalsIgnoreCase("3"))//Proposal Number search
			{
				strAppno="and app_no='"+appno+"'";
			}
			else
			{
				strAppno="and app_no <> ' '";
			}
			if(!strAppno.equals(""))
			{
				strQuery = SQLParser.getSqlQuery("UniqOrgAppgenerationa_com^"+strhidCategoryType+"^"+strid +"^"+strAppno);
			}    
			/*hidPageType=correctNull((String)hshRequestValues.get("hidPageType"));
			if(appno.equals(""))
			{
				if(hidPageType.trim().equals("EXI") || hidPageType.trim().equals("PROP") || hidPageType.trim().equals("audit_trial") || hidPageType.trim().equals("INS") || hidPageType.trim().equals("CPD") ||hidPageType.trim().equals("SRE") || hidPageType.trim().equals("EXC") ||hidPageType.trim().equals("STL") ||hidPageType.trim().equals("ADC"))
				{
					
					strcomappidList=new StringBuffer();
					strQuery = SQLParser.getSqlQuery("UniqComappidListBranch^"+strOrgSelect+"^"+strid);
					rs =DBUtils.executeQuery(strQuery);
					
					int j = 0;
					strcomappidList.append("(");
					while(rs.next())
					{
						if(j!=0)
						{
							strcomappidList.append(",");
						}
						strcomappidList.append(Helper.correctNull((String)rs.getString("perapp_id")));
						
						j++;
					}
					strcomappidList.append(")");
					
					if(hidPageType.equalsIgnoreCase("SRE"))
					{
						strLoantype="E";
					}
					else if(hidPageType.equalsIgnoreCase("ADC"))
					{
						strLoantype="H";
					}
					else if(hidPageType.equalsIgnoreCase("STL"))
					{
						strLoantype="U";
					}
					else
					{
						strLoantype="C";
					}
					
						strQuery = SQLParser.getSqlQuery("appgeneration^"+strcomappidList.toString() +"^"+strLoantype);
				}
				else if(hidPageType.trim().equals("NEW"))
				{
					strQuery = SQLParser.getSqlQuery("appgeneration^"+strid);
				}
				else if(hidPageType.equals("MST"))
				{
					strQuery = SQLParser.getSqlQuery("commstapplist^"+strOrgSelect+"%^"+strid);
				}
				
			}
			else if(!appno.equals("") && (hidPageType.trim().equals("EXI") || hidPageType.trim().equals("PROP")  || hidPageType.trim().equals("audit_trial")  || hidPageType.trim().equals("INS") || hidPageType.trim().equals("CPD")) || hidPageType.trim().equals("EXC"))
			{
				
				String strOrgShortCode = Helper.correctNull((String)hshRequestValues.get("strOrgShortCode"));
				strcomappidList=new StringBuffer();
				if(Helper.correctNull((String)hshRequestValues.get("strOrgLevel")).equalsIgnoreCase("A"))
				{
					strQuery = SQLParser.getSqlQuery("UniqComappidListBranch^"+strOrgShortCode+"^"+strid);
				}
				else
				{
					strQuery = SQLParser.getSqlQuery("UniqComappidListOthers^"+strid);
				}
				rs =DBUtils.executeQuery(strQuery);
				
				int j = 0;
				strcomappidList.append("(");
				while(rs.next())
				{
					if(j!=0)
					{
						strcomappidList.append(",");
					}
					strcomappidList.append(Helper.correctNull((String)rs.getString("comapp_id")));
					
					j++;
				}
				strcomappidList.append(")");
				strQuery = SQLParser.getSqlQuery("appgeneration1^"+strcomappidList.toString()+"^"+appno);
			}*/
			
			
			rs =DBUtils.executeQuery(strQuery);	
			
			
			while(rs.next())
			{		
				vecval =  new ArrayList();
				
				vecval.add(rs.getString(1));
				token=rs.getString(1);
				
				status=rs.getString(2);
				
				if(status.equalsIgnoreCase("op"))
				{
					status="OPEN/PENDING";
				}
				else if(status.equalsIgnoreCase("ol"))
				{
					status="OPEN/LODGED";
				}
				else if(status.equalsIgnoreCase("pa"))
				{
					status="PROCESSED/APPROVED";
				}
				else if(status.equalsIgnoreCase("pr"))
				{
					status="PROCESSED/REJECTED";
				}
				else if(status.equalsIgnoreCase("ca"))
				{
					status="CLOSED/APPROVED";
				}
				else if(status.equalsIgnoreCase("cr"))
				{
					status="CLOSED/REJECTED";
				}
				vecval.add(status);
				
				//String strchk = correctNull((String)rs.getString("mailchkstatus"));	
				
				String strAppholderid=correctNull(rs.getString("app_applnholder"));
				String strAppholdername=correctNull(rs.getString("appholdername"));
				
			
					if(!strAppholderid.equals(""))
					{
						if(correctNull((String)hshRequestValues.get("strUserId")).equals(strAppholderid))
						{
							vecval.add("Y");
							vecval.add(strAppholdername);
						}
						else
						{
							vecval.add("N");	
							vecval.add(strAppholdername);
						}
						
					}
				vecval.add(correctNull((String)rs.getString("app_orglevel")));
				
				strProposalType=Helper.correctNull(rs.getString("app_renew_flag"));
				
				if(strProposalType.equalsIgnoreCase("P"))
				{
					vecval.add("Post Sanction");
				}
				else if(strProposalType.equalsIgnoreCase("S"))
				{
					vecval.add("Restructured");
				}
				else if(strProposalType.equalsIgnoreCase("R"))
				{
					vecval.add("Renew");
				}
				else
				{
					vecval.add("Fresh");
				}
				vecdata.add(vecval);	
			}
			hshRecord.put("vecval",vecdata);
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
				if(rs1!=null)
				{
					rs1.close();
				}
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	public HashMap getRenewalData(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = null;
		String strQuery="";
		String strAppno = "";
		String strOrgCode ="";
		String strPge = "";
	
		try
		{
			strAppno = correctNull((String)hshRequestValues.get("txtapp"));
			strOrgCode = correctNull((String)hshRequestValues.get("strOrgCode"));
			strPge = correctNull((String)hshRequestValues.get("hidPge"));
			if(strPge.equalsIgnoreCase("getComResults"))
			{				
				hshRecord = new HashMap();
				strQuery = SQLParser.getSqlQuery("getRenewal^"+strAppno+"^"+strAppno+"^"+strOrgCode);
				rs =DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					hshRecord.put("strAppno",correctNull((String)rs.getString(1)));	
					hshRecord.put("strOrgCode",correctNull((String)rs.getString(2)));	
					hshRecord.put("strStatus",correctNull((String)rs.getString(3)));	
					hshRecord.put("strCompName",correctNull((String)rs.getString(4)));		
					hshRecord.put("strCategory",correctNull((String)rs.getString(5)));		
					hshRecord.put("strSubCategory",correctNull((String)rs.getString(6)));		
					hshRecord.put("strRng",correctNull((String)rs.getString(7)));		
				}
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
	
	public HashMap getBorrowerDetails(HashMap hshRequestValues) 
	{		
		ResultSet rs = null;
		String strQuery="",areacheckval="",catval="",desc="",bownameval="",subj="",absPosition="";
		String area2="",area3="",area4="",area5="",glptotlevel="",pagetype="",ddesc="";
		String strCusCBSStatus="",str_statuscust="",strSessionModule="",strApplicantId="",strCBSID="";
		try
		{
			strQuery = SQLParser.getSqlQuery("glpoption");
			rs =DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				glptotlevel = (String)Helper.correctNull(rs.getString(1));						
			}
			pagetype= correctNull((String)hshRequestValues.get("link"));
			absPosition=correctNull((String)hshRequestValues.get("hid_rowcount"));
			strSessionModule=Helper.correctNull((String)hshRequestValues.get("varstrSessionModuleType"));
			if(!strSessionModule.equalsIgnoreCase(""))
			{
				strSessionModule=Helper.correctNull((String)hshRequestValues.get("sessionModuleType"));
			}
			String strLoanType="";
			if(strSessionModule.equalsIgnoreCase("CORP"))
			{
				strLoanType="C";
			}
			else
			{
				strLoanType="A";
			}
			area2= correctNull((String)hshRequestValues.get("area2"));
			area3 = correctNull((String)hshRequestValues.get("area3"));
			area4 = correctNull((String)hshRequestValues.get("area4"));
			area5 = correctNull((String)hshRequestValues.get("area5"));
			
			if(area4.equals("undefined"))
				area4="";
			
			if(!area5.equals(""))
			{
				areacheckval=area5;
			}
			else if(!area4.equals(""))
			{
				if(glptotlevel.equals("4"))
				{
					areacheckval=area4.substring(0,12)+"%%%";
				}
				else if(glptotlevel.equals("5"))
				{
					areacheckval=area4.substring(0,15);
				}
			}
			else if(!area3.equals(""))
			{
				areacheckval=area3.substring(0,9)+"%%%%%%";
			}
			else if(!area2.equals(""))
			{
				areacheckval=area2.substring(0,6)+"%%%%%%%%%";
			}
			else
			{
				areacheckval="";			
			}
			
			catval = correctNull((String)hshRequestValues.get("cat"));
			bownameval = correctNull((String)hshRequestValues.get("bow_name"));
			if (!catval.equals("") && !bownameval.equals("") )
			{
				if(catval.equals("1"))//Inward Number search
				{
					desc="app_inwardno = '"+bownameval+"'";
					
					strQuery = SQLParser.getSqlQuery("sel_appnosearchbyappnocom^"+strLoanType+"^"+desc);
				}
				else if(catval.equals("2")) //CBS ID search
				{	
					desc=bownameval;
					strQuery = SQLParser.getSqlQuery("sel_appnosearchbycbsid^"+desc);
				}
				else if(catval.equals("3")) // Proposal No search
				{	
					desc="app_no = '"+bownameval+"'";
					strQuery = SQLParser.getSqlQuery("sel_appnosearchbyappnocom^"+strLoanType+"^"+desc);
				}
				else if(catval.equals("4"))//Name search
				{	
					desc= "(upper(perapp_fname) like upper('%"+bownameval+"%'))" ;
					strQuery = SQLParser.getSqlQuery("sel_appnosearchbyname^"+desc+"^"+areacheckval);
				}
			}
			ArrayList vecval =  new ArrayList();
			ArrayList vecdata =  new ArrayList();
			if(rs != null)
				rs.close();
			rs =DBUtils.executeQuery(strQuery);
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
			String tempstr="";
			ResultSet rs1=null;
			while(rs.next())
			{
				vecval =  new ArrayList();
				vecval.add(rs.getString(1));//0
				vecval.add(rs.getString(2));//1
				//added by s.sathya moorthy for null pointer exception 
				/*tempstr =Helper.correctNull((rs.getString(4)));
				if (tempstr.equals("CORP"))
				{
					tempstr = "CORPORATE";
				}*/			
				vecval.add(rs.getString(3));//2
				vecval.add("CORPORATE");//3
				vecval.add(rs.getString(5));//4
				vecval.add(rs.getString(6));//5
				strCBSID=correctNull(rs.getString(6));
				
				String strProfilestatus="N";str_statuscust="";strCusCBSStatus="";
				if(rs1!=null)
				{
					rs1.close();
				}
				rs1=DBUtils.executeLAPSQuery("getprofilestatusfromdemographic^"+Helper.correctNull((String)rs.getString("perapp_id")));
				if(rs1.next())
				{
					strProfilestatus=Helper.correctNull((String)rs1.getString("perapp_profilestatus"));
					strCusCBSStatus=Helper.correctNull((String)rs1.getString("perapp_cbsstatus"));
				}
				//hshValues.put("strProfilestatus",strProfilestatus);
				str_statuscust=strProfilestatus;
				
				vecval.add(strProfilestatus);//6
				vecval.add(strCusCBSStatus);//7
				vecval.add(str_statuscust);//8
				strApplicantId=Helper.correctInt(rs.getString("perapp_oldid"));
				vecval.add(rs.getString("perapp_id"));//9			
				
				if(rs1!=null)
				{
					rs1.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_processAppl_demoid^"+strApplicantId+"^"+strApplicantId+"^"+strApplicantId);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					vecval.add("Y");//10
				}
				else
				{
					vecval.add("N");//10
				}
				String strOccupation="";
				if(rs1!=null)
					rs1.close();
				if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
				{
					strQuery=SQLParser.getCBSSqlQuery("cbscusmastersearch_newconnection^"+Helper.correctNull(rs.getString("perapp_cbsid")));
					rs1=DBUtils.executeQueryCBSConnection(strQuery);
				}
				else
				{
					strQuery= SQLParser.getSqlQuery("cbscusmastersearch^"+Helper.correctNull(rs.getString("perapp_cbsid")));
					rs1=DBUtils.executeQuery(strQuery); 
				}
				if(rs1.next())
				{
					strOccupation=Helper.correctNull(rs1.getString("cust_occp_code"));
				}
				if(!strOccupation.equalsIgnoreCase("MIGR"))
				{
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("selkyc_kycActivity^"+Helper.correctNull(rs.getString("perapp_id")));
					if(rs1.next())
					{
						strOccupation=Helper.correctNull(rs1.getString("kyc_occupationcode"));
					}
				}
				vecval.add(strOccupation);//11
				
				vecdata.add(vecval);
			}
			hshRequestValues.put("vecval",vecdata);		
			
			if(rs != null)
			{rs.close();}
			strQuery=SQLParser.getSqlQuery("sel_op_ratingproposal^"+strCBSID);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(rs1!=null)
				{rs1.close();}
				String strRatAppNo=correctNull(rs.getString("fin_ratappno"));
				strQuery=SQLParser.getSqlQuery("selcrefreezeflag^"+strRatAppNo);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					if(!correctNull(rs1.getString("cre_rating")).equalsIgnoreCase("")&& !correctNull(rs1.getString("cre_weight")).equalsIgnoreCase(""))
					hshRequestValues.put("strRatingProposalPending", "Y");
					else
					hshRequestValues.put("strProposalPendinginKalypto", "Y");	
					hshRequestValues.put("strProposalUserID",correctNull(rs1.getString("cre_userid")));
					hshRequestValues.put("strProposalUserName",correctNull(rs1.getString("username")));
					
				}
				else
				{
					hshRequestValues.put("strRatingProposalPending", "Y");
				}
				//hshRequestValues.put("strRatingProposalPending", "Y");
			}
			if(rs != null)
			{rs.close();}
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
		return hshRequestValues;
	}

	public HashMap getDataHelp(HashMap hsh) 
	{
		String strQuery="";
		ResultSet rs=null;				
		HashMap hshvalues = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		String valsys="";
		try
		{
			valsys =Helper.correctNull((String)hsh.get("valsys"));
			strQuery = SQLParser.getSqlQuery("orgcodesel^"+valsys);
			rs =DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arr.add(correctNull(rs.getString(1)));
				arr1.add(correctNull(rs.getString(2)));
			}
			hshvalues.put("arrVal",arr);
			hshvalues.put("arrValdesc",arr1);			
		}		
		catch (Exception e)
		{
			throw new EJBException("Error Occured"+e.getMessage());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}				
			}
			catch (Exception e1)
			{
				throw new EJBException("Error Occured"+e1.getMessage());
			}
		}
		return hshvalues;
	}	

	public HashMap getNPABorrower(HashMap hshRequestValues) 
	{		
		ResultSet rs = null;
		String strQuery="",areacheckval="",catval="",bownameval="";
		
		String area2="",area3="",area4="",area5="",glptotlevel="";
		String absPosition="";
		String ddesc="";
		try
		{
			absPosition=correctNull((String)hshRequestValues.get("hid_rowcount"));
			strQuery = SQLParser.getSqlQuery("glpoption");
			rs =DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				glptotlevel = (String)Helper.correctNull(rs.getString(1));						
			}
			
			area2= correctNull((String)hshRequestValues.get("area2"));
			area3 = correctNull((String)hshRequestValues.get("area3"));
			area4 = correctNull((String)hshRequestValues.get("area4"));
			area5 = correctNull((String)hshRequestValues.get("area5"));
			
			if(area4.equals(""))
				area4="";
			
			if(!area5.equals(""))
			{
				areacheckval=area5;
			}
			else if(!area4.equals(""))
			{
				if(glptotlevel.equals("4"))
				{
					areacheckval=area4.substring(0,12)+"%%%";
				}
				else if(glptotlevel.equals("5"))
				{
					areacheckval=area4.substring(0,15);
				}
			}
			else if(!area3.equals(""))
			{
				areacheckval=area3.substring(0,9)+"%%%%%%";
			}
			else if(!area2.equals(""))
			{
				areacheckval=area2.substring(0,6)+"%%%%%%%%%";
			}
			else
			{
				areacheckval="";			
			}
			
			catval = correctNull((String)hshRequestValues.get("cat"));
			bownameval = correctNull((String)hshRequestValues.get("bow_name"));
	
			String moduletype=correctNull((String)hshRequestValues.get("hidmoduletype"));	

			ArrayList arrVal =  new ArrayList();
			ArrayList arrData =  new ArrayList();
			if(rs != null)
				rs.close();
			
			
			if(!catval.equals("") && !bownameval.equals("") && !areacheckval.equals(""))
			{
				ddesc= "and cbsnpa_custbranch in(select solid from organisations where org_code like '"+areacheckval+"')";
				if(catval.equals("1"))
				{
					strQuery=SQLParser.getSqlQuery("getnpaborrowerbyid^"+bownameval+"^"+ddesc);
				}
				else if(catval.equals("2"))
				{
					strQuery=SQLParser.getSqlQuery("getnpaborrowerbyname^"+bownameval+"^"+ddesc);
				}
			}
			
			else if(!catval.equals("") && !bownameval.equals("") && areacheckval.equals(""))
			{
				String strOrglevel=correctNull((String)hshRequestValues.get("strOrgLevel"));
				String strOrgCode= correctNull((String)hshRequestValues.get("strOrgCode"));
				
				if(strOrglevel.equals("C"))
				{
					strOrgCode=strOrgCode.substring(0,3)+"%%%%%%%%%%%%";
					ddesc= " and  cbsnpa_custbranch in (select solid from organisations where org_code like '"+strOrgCode+"')";
				}
				else if(strOrglevel.equals("R"))
				{
					strOrgCode=strOrgCode.substring(0,6)+"%%%%%%%%%";
					ddesc= " and  cbsnpa_custbranch in (select solid from organisations where org_code like '"+strOrgCode+"')";
				}
				else if(strOrglevel.equals("D"))
				{
					strOrgCode=strOrgCode.substring(0,9)+"%%%%%%";
					ddesc= " and  cbsnpa_custbranch in (select solid from organisations where org_code like '"+strOrgCode+"')";
				}
				else if(strOrglevel.equals("A"))
				{
					strOrgCode=strOrgCode.substring(0,12)+"%%%";
					ddesc= " and  cbsnpa_custbranch in (select solid from organisations where org_code like '"+strOrgCode+"')";
				}
				else if(strOrglevel.equals("B"))
				{
					ddesc= " and  cbsnpa_custbranch in (select solid from organisations where org_code like '"+strOrgCode+"')";
				}
				
				if(catval.equals("1"))
				{
					strQuery=SQLParser.getSqlQuery("getnpaborrowerbyid^"+bownameval+"^"+ddesc);
				}
				else if(catval.equals("2"))
				{
					strQuery=SQLParser.getSqlQuery("getnpaborrowerbyname^"+bownameval+"^"+ddesc);
				}
				
			}
			
			rs =DBUtils.executeQuery(strQuery);
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
 				arrVal =  new ArrayList();
 				arrVal.add(rs.getString("cbsnpa_custname"));
				arrVal.add(rs.getString("cbsnpa_custid"));
				arrVal.add(rs.getString("org_name"));
 				arrData.add(arrVal);
			}
			

			hshRequestValues.put("arrVal",arrData);	
			hshRequestValues.put("moduletype",moduletype);	
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
		return hshRequestValues;
	}
	
	public HashMap getMonitoringBorrower(HashMap hshRequestValues) 
	{		
		ResultSet rs = null;
		String strQuery="",areacheckval="",catval="",bownameval="";
		String ddesc="";
		
		String area2="",area3="",area4="",area5="",glptotlevel="";
		String montype=correctNull((String)hshRequestValues.get("hidmontype"));
		String printtype=correctNull((String)hshRequestValues.get("hidprinttype"));
		String moduletype=correctNull((String)hshRequestValues.get("hidmoduletype"));	
		try
		{
			strQuery = SQLParser.getSqlQuery("glpoption");
			rs =DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				glptotlevel = (String)Helper.correctNull(rs.getString(1));						
			}
			
			
			area2= correctNull((String)hshRequestValues.get("area2"));
			area3 = correctNull((String)hshRequestValues.get("area3"));
			area4 = correctNull((String)hshRequestValues.get("area4"));
			area5 = correctNull((String)hshRequestValues.get("area5"));
			
			if(area4.equals(""))
				area4="";
			
			if(!area5.equals(""))
			{
				areacheckval=area5;
			}
			else if(!area4.equals(""))
			{
				if(glptotlevel.equals("4"))
				{
					areacheckval=area4.substring(0,12)+"%%%";
				}
				else if(glptotlevel.equals("5"))
				{
					areacheckval=area4.substring(0,15);
				}
			}
			else if(!area3.equals(""))
			{
				areacheckval=area3.substring(0,9)+"%%%%%%";
			}
			else if(!area2.equals(""))
			{
				areacheckval=area2.substring(0,6)+"%%%%%%%%%";
			}
			else
			{
				areacheckval="";			
			}
			
			catval = correctNull((String)hshRequestValues.get("cat"));
			bownameval = correctNull((String)hshRequestValues.get("bow_name"));
	
			ArrayList arrRow =  new ArrayList();
			ArrayList arrData =  new ArrayList();
			if(rs != null)
				rs.close();
			
			if(!catval.equals("") && !bownameval.equals("") && !areacheckval.equals(""))
			{
				if(moduletype.equalsIgnoreCase("OTSCO") || moduletype.equalsIgnoreCase("SARFI") || moduletype.equalsIgnoreCase("SUIT") || moduletype.equalsIgnoreCase("PAWO") || moduletype.equalsIgnoreCase("STAT"))
				{
					//ddesc= "and personal_classification!='001' and  org_code like '"+areacheckval+"'";
					ddesc= "and  org_code like '"+areacheckval+"'";
				}
				else
				{
					//ddesc= "and personal_classification='001' and  org_code like '"+areacheckval+"'";
					ddesc= "and  org_code like '"+areacheckval+"'";
				}
				if(catval.equals("1"))
				{
					strQuery=SQLParser.getSqlQuery("getmonborrowerbyid^"+bownameval+"^"+ddesc);
				}
				else if(catval.equals("2"))
				{
					strQuery=SQLParser.getSqlQuery("getmonborrowerbyname^"+bownameval+"^"+ddesc);
				}
			}
			
			else if(!catval.equals("") && !bownameval.equals("") && areacheckval.equals(""))
			{
				String strOrglevel=correctNull((String)hshRequestValues.get("strOrgLevel"));
				String strOrgCode= correctNull((String)hshRequestValues.get("strOrgCode"));
				
				if(strOrglevel.equals("C"))
				{
					strOrgCode=strOrgCode.substring(0,3)+"%%%%%%%%%%%%";
					if(moduletype.equalsIgnoreCase("OTSCO") || moduletype.equalsIgnoreCase("SARFI") || moduletype.equalsIgnoreCase("SUIT") || moduletype.equalsIgnoreCase("PAWO") || moduletype.equalsIgnoreCase("STAT"))
					{
						//ddesc= "and personal_classification!='001' and  org_code like '"+strOrgCode+"'";
						ddesc= "and  org_code like '"+strOrgCode+"'";
					}
					else
					{
						//ddesc= "and personal_classification='001' and  org_code like '"+strOrgCode+"'";
						ddesc= "and  org_code like '"+strOrgCode+"'";
					}
				}
				else if(strOrglevel.equals("R"))
				{
					strOrgCode=strOrgCode.substring(0,6)+"%%%%%%%%%";
					if(moduletype.equalsIgnoreCase("OTSCO") || moduletype.equalsIgnoreCase("SARFI") || moduletype.equalsIgnoreCase("SUIT") || moduletype.equalsIgnoreCase("PAWO") || moduletype.equalsIgnoreCase("STAT"))
					{
						//ddesc= "and personal_classification!='001' and  org_code like '"+strOrgCode+"'";
						ddesc= "and  org_code like '"+strOrgCode+"'";
					}
					else
					{
						//ddesc= "and personal_classification='001' and  org_code like '"+strOrgCode+"'";
						ddesc= "and  org_code like '"+strOrgCode+"'";
					}
				}
				else if(strOrglevel.equals("D"))
				{
					strOrgCode=strOrgCode.substring(0,9)+"%%%%%%";
					if(moduletype.equalsIgnoreCase("OTSCO") || moduletype.equalsIgnoreCase("SARFI") || moduletype.equalsIgnoreCase("SUIT") || moduletype.equalsIgnoreCase("PAWO") || moduletype.equalsIgnoreCase("STAT"))
					{
						//ddesc= "and personal_classification!='001' and  org_code like '"+strOrgCode+"'";
						ddesc= "and org_code like '"+strOrgCode+"'";
					}
					else
					{
						//ddesc= "and personal_classification='001' and  org_code like '"+strOrgCode+"'";
						ddesc= "and  org_code like '"+strOrgCode+"'";
					}
				}
				else if(strOrglevel.equals("A"))
				{
					strOrgCode=strOrgCode.substring(0,12)+"%%%";
					if(moduletype.equalsIgnoreCase("OTSCO") || moduletype.equalsIgnoreCase("SARFI") || moduletype.equalsIgnoreCase("SUIT") || moduletype.equalsIgnoreCase("PAWO") || moduletype.equalsIgnoreCase("STAT"))
					{
						//ddesc= "and personal_classification!='001' and  org_code like '"+strOrgCode+"'";
						ddesc= "and  org_code like '"+strOrgCode+"'";
					}
					else
					{
						//ddesc= "and personal_classification='001' and  org_code like '"+strOrgCode+"'";
						ddesc= "and  org_code like '"+strOrgCode+"'";
					}
				}
				else if(strOrglevel.equals("B"))
				{
					if(moduletype.equalsIgnoreCase("OTSCO") || moduletype.equalsIgnoreCase("SARFI") || moduletype.equalsIgnoreCase("SUIT") || moduletype.equalsIgnoreCase("PAWO") || moduletype.equalsIgnoreCase("STAT"))
					{
						//ddesc= "and personal_classification!='001' and  org_code like '"+strOrgCode+"'";
						ddesc= "and  org_code like '"+strOrgCode+"'";
					}
					else
					{
						//ddesc= "and personal_classification='001' and  org_code like '"+strOrgCode+"'";
						ddesc= "and  org_code like '"+strOrgCode+"'";
					}
				}
				
				if(catval.equals("1"))
				{
					strQuery=SQLParser.getSqlQuery("getmonborrowerbyid^"+bownameval+"^"+ddesc);
				}
				else if(catval.equals("2"))
				{
					strQuery=SQLParser.getSqlQuery("getmonborrowerbyname^"+bownameval+"^"+ddesc);
				}
			}
			
			rs =DBUtils.executeQuery(strQuery);

			while(rs.next())
			{
				arrData =  new ArrayList();
				arrData.add(rs.getString("personal_custname"));//0
				arrData.add(rs.getString("personal_cbsid"));//1
				arrData.add(rs.getString("org_name"));//2
				arrData.add(rs.getString("org_scode"));//3
				arrData.add(rs.getString("personal_solid"));//4
				arrData.add(rs.getString("personal_classification"));//5
				arrRow.add(arrData);
			}
			
			hshRequestValues.put("arrRow",arrRow);	
			hshRequestValues.put("montype",montype);
			hshRequestValues.put("printtype",printtype);
			hshRequestValues.put("moduletype",moduletype);

		}
		catch(Exception ce)
		{
			throw new EJBException("Error in Monitoring Search "+ce.toString());
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
		return hshRequestValues;
	}
	public HashMap getMonitoringData(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		ResultSet rs1=null;
		String strQuery="";
		String strCBSCustId="";
		ArrayList vecval =  new ArrayList();
		ArrayList vecdata =  new ArrayList();
		String sample=Helper.correctNull((String)hshRequestValues.get("hidmontype"));
		String strprinttype=Helper.correctNull((String)hshRequestValues.get("hidprinttype"));
		String lim_facode="",facility="";
		try
		{
		
			
			strCBSCustId=correctNull((String)hshRequestValues.get("id"));
			strQuery=SQLParser.getSqlQuery("getmonitoraccounts^"+strCBSCustId);
			rs =DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecval =  new ArrayList();
				vecval.add(rs.getString("limit_cutaccno"));
				vecval.add(rs.getString("limit_custid"));
				lim_facode=Helper.correctNull(rs.getString("limit_facility"));
				strQuery=SQLParser.getSqlQuery("getmonfacility^"+lim_facode);
				rs1 =DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					facility=Helper.correctNull((String)rs1.getString("stat_data_desc1"));
				}
				vecval.add(facility);
				vecval.add(rs.getString("limit_status"));
				vecdata.add(vecval);
			}
			
			hshRequestValues.put("vecval",vecdata);	
			hshRequestValues.put("sample",sample);
			hshRequestValues.put("strprinttype",strprinttype);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in Monitoring Search "+ce.toString());
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
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRequestValues;
		
	}
	public HashMap getNPADataFinal(HashMap hshValues) 
	{
		
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecRow = new ArrayList();	
		String strAppid=Helper.correctNull((String)hshValues.get("appid"));
		String strApptype=Helper.correctNull((String)hshValues.get("apptype"));
		String strModuletype=Helper.correctNull((String)hshValues.get("moduletype"));
		String strQuery="";
		String newbtnenable="Y";
		try
		{
			
			strQuery=SQLParser.getSqlQuery("sel_npaapplicationno^"+strModuletype+"^"+strAppid+"^"+strApptype);
			rs =DBUtils.executeQuery(strQuery);
			
			hshRecord = new HashMap();
			while(rs.next())
			{
				ArrayList vecCol = new ArrayList();	
				String status=correctNull(rs.getString("npa_status"));
				if(status.equalsIgnoreCase("op"))
				{
					status="OPEN/PENDING";
					newbtnenable="N";
				}
				else if(status.equalsIgnoreCase("pa"))
				{
					status="PROCESSED/APPROVED";
					newbtnenable="N";
				}
				else if(status.equalsIgnoreCase("pr"))
				{
					status="PROCESSED/REJECTED";
					newbtnenable="N";
				}
				else if(status.equalsIgnoreCase("ca"))
				{
					status="CLOSED/APPROVED";
					newbtnenable="Y";
				}
				else if(status.equalsIgnoreCase("cr"))
				{
					status="CLOSED/REJECTED";
					newbtnenable="Y";
				}
				
				vecCol.add(correctNull(rs.getString("npa_appno")));
				vecCol.add(correctNull(rs.getString("npa_status")));
				vecCol.add(status);
				vecCol.add(correctNull(rs.getString("npa_holduser")));
				vecCol.add("Y");
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow",vecRow);	
			hshRecord.put("newbtnenable",newbtnenable);
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getNPADataFinal "+ce.toString());
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
	public HashMap getTermLoanReviewData(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		ResultSet rs1=null;
		String strQuery="";
		String newButtonDisable=null;
		String strCBSCustId="";
		ArrayList vecval =  new ArrayList();
		ArrayList vecdata =  new ArrayList();
		String sample=Helper.correctNull((String)hshRequestValues.get("hidmontype"));
		String strprinttype=Helper.correctNull((String)hshRequestValues.get("hidprinttype"));
		String strShort_orgcode = Helper.correctNull((String)hshRequestValues.get("custorgscode"));
		if(strShort_orgcode.equalsIgnoreCase(""))
		{
			strShort_orgcode = Helper.correctNull((String)hshRequestValues.get("strOrgShortCode"));
		}
		try
		{
		
			strCBSCustId=correctNull((String)hshRequestValues.get("id"));
			strQuery=SQLParser.getSqlQuery("tlr_applications_selectall^"+strCBSCustId+"^"+strShort_orgcode);
			rs =DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecval =  new ArrayList();
				vecval.add(rs.getString("tlr_appno"));
				vecval.add(rs.getString("tlr_cbsid"));
				String status=correctNull(rs.getString("tlr_status"));
				if(status.equalsIgnoreCase("op"))
				{
					status="PENDING";
					newButtonDisable = "Y";
				}
				else if(status.equalsIgnoreCase("pa"))
				{
					status="APPROVED";
					newButtonDisable = "Y";
				}
				else if(status.equalsIgnoreCase("ca"))
				{
					status="CLOSED";
				}
    			vecval.add(correctNull(rs.getString("tlr_status")));
    			vecval.add(rs.getString("tlr_year"));
    			vecval.add(status);
				vecdata.add(vecval);
			}
			
			strQuery=SQLParser.getSqlQuery("tlr_applications_maxreviewyear^"+strCBSCustId+"^"+strShort_orgcode);
			if(rs!=null)
				rs.close();
			rs =DBUtils.executeQuery(strQuery);
			if(rs.next()){
				hshRequestValues.put("tlr_maxyear",correctNull((String)rs.getString("tlr_maxyear")));
			}
			
			hshRequestValues.put("vecval",vecdata);	
			hshRequestValues.put("sample",sample);
			hshRequestValues.put("strprinttype",strprinttype);
			hshRequestValues.put("newButtonDisable",newButtonDisable);
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getTermLoanReviewData "+ce.toString());
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
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRequestValues;
		
	}
	public HashMap getNPAAccountSearchData(HashMap hshRequestValues) 
	{
		ResultSet rs=null,rs1=null;
		String strSearch="",strSearchCriteria="",strQuery="",strText="",strGlobalSearch="",strGlobalText="";
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		String strSno="";
		try
		{
			
			strSearchCriteria=Helper.correctNull((String)hshRequestValues.get("rdovalue"));
			strGlobalSearch=Helper.correctNull((String)hshRequestValues.get("strSearch"));
			strSearch=Helper.correctNull((String)hshRequestValues.get("txtsearch"));
			strSno=Helper.correctNull((String)hshRequestValues.get("exec_sno"));
			
			if(strSearchCriteria.equalsIgnoreCase("CBSID"))
			{
				strText=  "and cust_id='"+strSearch+"' ";
				strGlobalText=  "and perapp_cbsid='"+strSearch+"' ";
			}
			else if(strSearchCriteria.equalsIgnoreCase("NAME"))
			{
				strText=  " and upper(cust_name) like ('"+strSearch.toUpperCase()+"%%') ";
				strGlobalText=  " and upper(perapp_fname) like ('"+strSearch.toUpperCase()+"%%') ";
			}
			else 
			{
				strText=  " ";	
			}
			if(!("").equalsIgnoreCase(strSno) || ("GlobalSearch").equalsIgnoreCase(strGlobalSearch)  ){
			if(strGlobalSearch.equalsIgnoreCase("GlobalSearch"))
				strQuery=SQLParser.getSqlQuery("npacustomersearch_globalsearch^"+strText+"^"+strGlobalText);
			else
				strQuery=SQLParser.getSqlQuery("npacustomersearch^"+strText+"^"+strText);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("cust_id")));//0
				arrCol.add(Helper.correctNull(rs.getString("cust_name")));//1
				arrCol.add(Helper.correctNull(rs.getString("org_name")));//2
				arrRow.add(arrCol);
			}}
			
			hshRequestValues.put("arrRow",arrRow);
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getNPAAccountSearchData "+ce.toString());
		}
		finally
		{
			try
			{
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRequestValues;
		
	}
	public HashMap getNPAAccountDetails(HashMap hshRequestValues) 
	{
		
		java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		nf.setGroupingUsed(false);
		
		ResultSet rs=null,rs1=null,rs2=null;
		String strCBSID="",strQuery="",strName="",strOrgName="",strorg="",strDate="",strSno="",strGl="";
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		int  count=0;
		try
		{
			
			strCBSID=Helper.correctNull((String)hshRequestValues.get("hidCBSID"));
			strName=Helper.correctNull((String)hshRequestValues.get("hidname"));
			strSno=	Helper.correctNull((String)hshRequestValues.get("strExecSno"));
			strDate=Helper.correctNull((String)hshRequestValues.get("strExec_Date"));
			strGl=Helper.correctNull((String)hshRequestValues.get("strisGlobal"));
			if(!("").equalsIgnoreCase(strSno)){
				if(rs2!=null)
					rs2.close();
				
				rs2=DBUtils.executeLAPSQuery("npa_newcount^"+strCBSID+"^"+strSno);
				
				if(rs2.next())
				{
					count=(rs2.getInt("rowcount"));
				}
				if(count >0 ){
					strQuery=SQLParser.getSqlQuery("npaaccountdetails1^"+strCBSID+"^"+strSno);	
				}else{
				strQuery=SQLParser.getSqlQuery("npaaccountdetails2^"+strCBSID+"^"+strSno);
				}
			
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("acc_no")));//0
				arrCol.add(Helper.correctNull(rs.getString("proposal_no")));//1
				if(Helper.correctNull(rs.getString("loan_type")).equalsIgnoreCase("S"))
				{
					arrCol.add("");//2
					arrCol.add("");//3
				}
				else if(Helper.correctNull(rs.getString("loan_type")).equalsIgnoreCase("P"))
				{
					arrCol.add("1");//2
					if(rs1!=null)
						rs1.close();
					strQuery=SQLParser.getSqlQuery("sel_retailfacdescription^"+Helper.correctNull(rs.getString("proposal_no")));
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						arrCol.add(Helper.correctNull(rs1.getString("prd_desc")));//3
					}
					else
					{
						arrCol.add("");//3
					}
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("proposal_sno")));//2
					if(rs1!=null)
						rs1.close();
					strQuery=SQLParser.getSqlQuery("sel_corpagrifacdescription^"+Helper.correctInt(rs.getString("proposal_sno"))+"^"+Helper.correctNull(rs.getString("proposal_no")));
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						arrCol.add(Helper.correctNull(rs1.getString("com_facdesc")));//3
					}
					else
					{
						arrCol.add("");//3
					}
				}
				arrCol.add(Helper.correctNull(rs.getString("npa_date")));//4
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("sanc_limit")))));//5
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("os_limit")))));//6
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("unreal_int_val")))));//7
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("coverage_val_sanc")))));//8
				arrCol.add(Helper.correctNull(rs.getString("cust_id")));//9
				arrCol.add(Helper.correctNull(rs.getString("cust_name")));//10
				arrCol.add(Helper.correctNull(rs.getString("type")));//11
				arrCol.add(Helper.correctNull(rs.getString("loan_type")));//12
				arrCol.add(Helper.correctNull(rs.getString("execution_no")));//13
				arrCol.add(Helper.correctNull(rs.getString("as_on_date")));//14
				arrCol.add(Helper.correctNull(rs.getString("org_soldid")));//15
				arrCol.add(Helper.correctNull(rs.getString("org_name")));//16
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("unsec_os_limit")))));//17
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("prime_sec_val")))));//18
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("prov_value")))));//19
				arrCol.add(Helper.correctNull(rs.getString("fraud_applnt")));//20
				arrCol.add(Helper.correctNull(rs.getString("norm_status")));//21
				if(Helper.correctNull(rs.getString("fraud_applnt")).equalsIgnoreCase("Y"))
					arrCol.add("Yes");//22
				else
					arrCol.add("No");//22
				arrCol.add(Helper.correctNull(rs.getString("regionname")));//23
				
				arrCol.add(Helper.correctNull(rs.getString("npa_mannualflag")));//24
				
				arrCol.add(Helper.correctNull(rs.getString("write_off")));//25
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("othr_charges")))));//26
				arrCol.add(Helper.correctNull(rs.getString("npa_sbca_acc")));//27
				
				arrCol.add(Helper.correctNull(rs.getString("npa_reason")));//28
				
				if(rs1!=null)
					rs1.close();
				strQuery=SQLParser.getSqlQuery("sel_npamoc^"+Helper.correctNull(rs.getString("acc_no")));
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					arrCol.add(Helper.correctNull(rs1.getString("NPA_VERIFICATION_FLAG")));//29
				}
				else
				{
					arrCol.add("");//29
				}
				
				arrRow.add(arrCol);
				strName=Helper.correctNull(rs.getString("cust_name"));
			}}
			
			if(rs!=null)
				rs.close();
			
			rs=DBUtils.executeLAPSQuery("sel_max_npaprovno");
			if(rs.next())
			{
				hshRequestValues.put("strExeNo", Helper.correctNull(rs.getString("exe_sno")));
				hshRequestValues.put("strExeDate", Helper.correctNull(rs.getString("exe_date")));
			}
			if(rs!=null)
				rs.close();
			if(("Y").equalsIgnoreCase(strGl)){
			rs=DBUtils.executeLAPSQuery("sel_max_npaprovno_mocdate^"+strDate);
			if(rs.next())
			{
				hshRequestValues.put("strExeNo_gl", Helper.correctNull(rs.getString("exe_sno")));
				hshRequestValues.put("strExeDate_gl", Helper.correctNull(rs.getString("exe_date")));
			}}
			hshRequestValues.put("strGl", strGl);
			hshRequestValues.put("arrRow", arrRow);
			hshRequestValues.put("strName", strName);
			hshRequestValues.put("strCBSID", strCBSID);
			
			if(strName.equalsIgnoreCase("") && !strCBSID.equalsIgnoreCase(""))
			{
				if(rs!=null)
					rs.close();
				
				rs=DBUtils.executeLAPSQuery("sel_lapsidfromcbsid^"+strCBSID);
				if(rs.next())
				{
					hshRequestValues.put("strName", Helper.correctNull(rs.getString("perapp_fname")));
				}
			}
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getNPAAccountDetails "+ce.toString());
		}
		finally
		{
			try
			{				
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRequestValues;
		
	}
	public void updateNPAAccountDetails(HashMap hshRequestValues) 
	{
		HashMap hshQueryValues= new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		HashMap hshQuerynewValues= new HashMap();
		HashMap hshQuerynew= new HashMap();
		String strAccNo="",strFlag="",strQuery="",strAction="",strExcep="$",strmocflag="";
		ResultSet rs=null;
		try
		{
			strAccNo=Helper.correctNull((String)hshRequestValues.get("txtaccountno"));
			strFlag=Helper.correctNull((String)hshRequestValues.get("txtinsertFlag"));
			strAction=Helper.correctNull((String)hshRequestValues.get("hidAction"));
			String strUser = correctNull((String) hshRequestValues.get("strUserId"));
//			if(strFlag.equalsIgnoreCase(""))
//			{
//				strQuery=SQLParser.getSqlQuery("sel_npaprovaccdatamoc^"+strAccNo);
//				rs=DBUtils.executeQuery(strQuery);
//				if(!rs.next())
//				{
//					strFlag="Y";
//				}
//			}
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				
				rs = DBUtils.executeLAPSQuery("chk_npa_prov_acc_data^"+Helper.correctNull((String)hshRequestValues.get("txtaccountno")));
				if(rs.next())
				{
					strExcep=strExcep+"Account Information is already Available...";
					throw new Exception(strExcep);
				}
				if(rs!=null)rs.close();
				rs=DBUtils.executeLAPSQuery("chk_npa_prov_moc_data^"+Helper.correctNull((String)hshRequestValues.get("txtaccountno")));
				if(rs.next())
				{
					strExcep=strExcep+"Account Information is already Available...";
					throw new Exception(strExcep);
				}
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","ins_npa_prov_moc_data");
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno"))); // EXECUTION_NO
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_executiondate")));//AS_ON_DATE
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("hidCBSID")));//CUST_ID
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_appname")));//CUST_NAME
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtaccountno")));//ACC_NO
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtorgsolid")));//ORG_SOLDID
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtNPADate")));//NPA_DATE
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtsancamt")));//SANC_LIMIT
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtoutstandingamt")));//OS_LIMIT
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtinterestval")));//UNREAL_INT_VAL
				arrValues.add(null);//COVERAGE_VAL_SANC
				arrValues.add(null);//COVERAGE_PERCNT
				arrValues.add(null);//COVERAGE_VAL_PRESENT
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtclearbalance")));//UNSEC_OS_LIMIT 
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_secvalue")));//PRIME_SEC_VAL 
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_fraudapplicant")));//FRAUD_APPLNT
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtLoantype")));//LOAN_TYPE
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtproposalno")));//PROPOSAL_NO
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("hidsno")));//PROPOSAL_SNO
				arrValues.add(null);//OS_PERCNT
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_npanormstatus")));//NORM_STATUS
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_provisionvalue")));//PROV_VALUE
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_othercharges")));//OTHR_CHARGES
				if(Helper.correctNull((String)hshRequestValues.get("txtLoantype")).equalsIgnoreCase("S"))//NPA_SBCA_ACC
				arrValues.add("Y");
				else
				arrValues.add(null);
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_writeoffflag")));//WRITE_OFF
				arrValues.add("Y");
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_reason")));
				arrValues.add(strUser);
				arrValues.add("N");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1", hshQuery);
				
				hshQueryValues.put("size", "1");
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
				
				
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_npa_prov_acc_data");
				arrValues.add("Y");
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_reason")));
				arrValues.add(strUser);
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtaccountno")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_npa_prov_old_data");
				arrValues.add("Y");
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_reason")));
				arrValues.add(strUser);
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtaccountno")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
				hshQuerynewValues= new HashMap();
				hshQuerynew = new HashMap();
				arrValues = new ArrayList();
				hshQuerynew.put("strQueryId","insnpaverprovaccdatamoc");
				arrValues.add(strAccNo);
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno")));
				arrValues.add(strAccNo);
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno")));
				arrValues.add(strAccNo);
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno")));
				arrValues.add(strAccNo);
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno")));
				
				hshQuerynew.put("arrValues",arrValues);
				hshQuerynewValues.put("1", hshQuerynew);
				hshQuerynewValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQuerynewValues, "updateData");
			}
			else
			{
				if(strFlag.equalsIgnoreCase("Y"))
				{
					strQuery=SQLParser.getSqlQuery("sel_npamoc^"+strAccNo);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strmocflag="Y";
					}
				if(strmocflag.equalsIgnoreCase("")){
					hshQuerynewValues= new HashMap();
					hshQuerynew = new HashMap();
					arrValues = new ArrayList();
					hshQuerynew.put("strQueryId","insnpaprovaccdatamoc");
					arrValues.add(strAccNo);
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno")));
					arrValues.add(strAccNo);
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno")));
					arrValues.add(strAccNo);
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno")));
					arrValues.add(strAccNo);
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno")));
					
					hshQuerynew.put("arrValues",arrValues);
					hshQuerynewValues.put("1", hshQuerynew);
					hshQuerynewValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQuerynewValues, "updateData");
				}
					
					
					
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","updnpaverfprovaccdata");
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtNPADate")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtoutstandingamt")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtsancamt")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtinterestval")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtclearbalance")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_secvalue")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_fraudapplicant")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_npanormstatus")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_provisionvalue")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_writeoffflag")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_othercharges")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_SBCA_Flag")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_reason")));
					arrValues.add(strUser);
					arrValues.add(strAccNo);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1", hshQuery);
					
					hshQueryValues.put("size", "1");
					
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
					
					hshQuerynewValues= new HashMap();
					hshQuerynew = new HashMap();
					arrValues = new ArrayList();
					hshQuerynew.put("strQueryId","insnpaverprovaccdatamoc");
					arrValues.add(strAccNo);
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno")));
					arrValues.add(strAccNo);
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno")));
					arrValues.add(strAccNo);
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno")));
					arrValues.add(strAccNo);
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno")));
					
					hshQuerynew.put("arrValues",arrValues);
					hshQuerynewValues.put("1", hshQuerynew);
					hshQuerynewValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQuerynewValues, "updateData");
				    
					hshQuerynewValues= new HashMap();
					hshQuerynew = new HashMap();
					arrValues = new ArrayList();
					hshQuerynew.put("strQueryId","upd_verfhis_editflag");
					
					arrValues.add(strAccNo);
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno")));
					
					hshQuerynew.put("arrValues",arrValues);
					hshQuerynewValues.put("1", hshQuerynew);
					hshQuerynewValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQuerynewValues, "updateData");
								
				}
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateNPAAccountDetails "+ce.toString());
		}
		finally
		{
			try
			{
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		
	}

	public HashMap getNPAProvisioning(HashMap hshRequestValues) 
	{		
		java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		nf.setGroupingUsed(false);
		
		ResultSet rs=null,rs1=null;
		String strCBSID="",strQuery="",strName="",strOrgName="",strorg="";
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		try
		{
			
			strName=Helper.correctNull((String)hshRequestValues.get("hidname"));
			strOrgName=Helper.correctNull((String)hshRequestValues.get("hidOrgName"));
			
			strQuery = SQLParser.getSqlQuery("sel_executiondetails");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRequestValues.put("exec_sno", Helper.correctNull((String)rs.getString("EXE_SNO")));
				hshRequestValues.put("exec_date", Helper.correctNull((String)rs.getString("EXE_DATE")));
				hshRequestValues.put("exec_by", Helper.correctNull((String)rs.getString("EXE_USER"))+" - "+Helper.correctNull((String)rs.getString("USR_FNAME")));
				hshRequestValues.put("customer_count", Helper.correctNull((String)rs.getString("CUST_ID")));
				hshRequestValues.put("account_count", Helper.correctNull((String)rs.getString("ACC_NO")));
				hshRequestValues.put("tot_prov_val", Helper.correctNull((String)rs.getString("PROV_VALUE")));
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("sel_executiondetails_fail");
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRequestValues.put("exec_sno", Helper.correctNull((String)rs.getString("EXE_SNO")));
					hshRequestValues.put("exec_date", Helper.correctNull((String)rs.getString("EXE_DATE")));
					hshRequestValues.put("exec_by", Helper.correctNull((String)rs.getString("EXE_USER"))+" - "+Helper.correctNull((String)rs.getString("USR_FNAME")));
					hshRequestValues.put("EXE_EXCEPTION", Helper.correctNull((String)rs.getString("EXE_EXCEPTION")).replaceAll("\n", " ").replaceAll("\"", ""));
				}
			}

			if(rs!=null)rs.close();
			strQuery = SQLParser.getSqlQuery("sel_uploadStatus");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRequestValues.put("pending_filename", Helper.correctNull((String)rs.getString("EXE_FILENAME")));
				hshRequestValues.put("pending_fileexists", "Y");
				hshRequestValues.put("exec_sno", Helper.correctNull((String)rs.getString("exe_sno")));
			}
			
			String strRadioVal = "",strQuerystr="";
			int intOptionVal=0;
			
			strRadioVal = Helper.correctNull((String)hshRequestValues.get("txt_radval"));
			if(strRadioVal.equalsIgnoreCase(""))
				strRadioVal = "N";
			
			if(strRadioVal.equalsIgnoreCase("C"))
			{
				arrCol=new ArrayList();
				arrCol.add("Customer CBS ID");
				arrCol.add("Customer Name");
				arrCol.add("NPA Date");
				arrCol.add("Norm Status");
				arrCol.add("Total Provision Value");
				arrRow.add(arrCol);
				intOptionVal = 5;
				strQuerystr = "sel_npaaccountdetails_custid";
			}
			else if(strRadioVal.equalsIgnoreCase("O"))
			{
				arrCol=new ArrayList();
				arrCol.add("Organisation SOLID");
				arrCol.add("Organisation Name");
				arrCol.add("Norm Status");
				arrCol.add("No. Of Accounts");
				arrCol.add("Total Provision Value");
				arrRow.add(arrCol);
				intOptionVal = 5;
				strQuerystr = "sel_npaaccountdetails_org";
			}
			else if(strRadioVal.equalsIgnoreCase("N"))
			{
				arrCol=new ArrayList();
				arrCol.add("Norm Status");
				arrCol.add("No. Of Accounts");
				arrCol.add("Total Provision Value");
				arrRow.add(arrCol);
				intOptionVal = 3;
				strQuerystr = "sel_npaaccountdetails_norm";
			}
			else if(strRadioVal.equalsIgnoreCase("L"))
			{
				arrCol=new ArrayList();
				arrCol.add("Loan Type");
				arrCol.add("Norm Status");
				arrCol.add("No. Of Accounts");
				arrCol.add("Total Provision Value");
				arrRow.add(arrCol);
				intOptionVal = 4;
				strQuerystr = "sel_npaaccountdetails_loantype";
			}
			
			hshRequestValues.put("txt_radval", strRadioVal);
			
			if(rs!=null)rs.close();
			strQuery=SQLParser.getSqlQuery(strQuerystr);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				for(int i = 1;i<=intOptionVal;i++)
				{
					arrCol.add(Helper.correctNull(rs.getString(i)));
				}
				arrRow.add(arrCol);
//				arrCol.add(Helper.correctNull(rs.getString("acc_no")));//0
//				arrCol.add(Helper.correctNull(rs.getString("proposal_no")));//1
//				if(Helper.correctNull(rs.getString("loan_type")).equalsIgnoreCase("P"))
//				{
//					arrCol.add("1");//2
//					if(rs1!=null)
//						rs1.close();
//					strQuery=SQLParser.getSqlQuery("sel_retailfacdescription^"+Helper.correctNull(rs.getString("proposal_no")));
//					rs1=DBUtils.executeQuery(strQuery);
//					if(rs1.next())
//					{
//						arrCol.add(Helper.correctNull(rs1.getString("prd_desc")));//3
//					}
//					else
//					{
//						arrCol.add("");//3
//					}
//				}
//				else
//				{
//					arrCol.add(Helper.correctNull(rs.getString("proposal_sno")));//2
//					if(rs1!=null)
//						rs1.close();
//					strQuery=SQLParser.getSqlQuery("sel_corpagrifacdescription^"+Helper.correctInt(rs.getString("proposal_sno"))+"^"+Helper.correctNull(rs.getString("proposal_no")));
//					rs1=DBUtils.executeQuery(strQuery);
//					if(rs1.next())
//					{
//						arrCol.add(Helper.correctNull(rs1.getString("com_facdesc")));//3
//					}
//					else
//					{
//						arrCol.add("");//3
//					}
//				}
//				arrCol.add(Helper.correctNull(rs.getString("npa_date")));//4
//				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("sanc_limit")))));//5
//				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("os_limit")))));//6
//				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("unreal_int_val")))));//7
//				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("coverage_val_sanc")))));//8
//				arrCol.add(Helper.correctNull(rs.getString("cust_id")));//9
//				arrCol.add(Helper.correctNull(rs.getString("cust_name")));//10
//				arrCol.add(Helper.correctNull(rs.getString("type")));//11
//				arrCol.add(Helper.correctNull(rs.getString("loan_type")));//12
//				arrCol.add(Helper.correctNull(rs.getString("NORM_STATUS")));//13
//				arrCol.add(Helper.correctNull(rs.getString("PROV_VALUE")));//14
//				strorg=Helper.correctNull(rs.getString("org_soldid"));
//				strName=Helper.correctNull(rs.getString("cust_name"));
			}
			
			if(rs!=null)
				rs.close();
			
			if(strOrgName.equalsIgnoreCase("") && !strorg.equalsIgnoreCase(""))
			{
				
				rs=DBUtils.executeLAPSQuery("getorgcode^"+strorg);
				if(rs.next())
				{
					strOrgName=Helper.correctNull(rs.getString("org_name"));
				}
			}
			
			if(rs!=null)
				rs.close();
			
			rs=DBUtils.executeLAPSQuery("sel_availableusers");
			if(rs.next())
			{
				hshRequestValues.put("strAvailUsersFlag", "Y");
			}
			
			if(rs!=null)
				rs.close();
			
			rs=DBUtils.executeLAPSQuery("sel_npa_prov_enddate");
			if(rs.next())
			{
				hshRequestValues.put("strQEndDate", Helper.correctNull(rs.getString("qdate")));
			}
			
			hshRequestValues.put("arrRow", arrRow);
			hshRequestValues.put("strNameofOrg", strOrgName);
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getNPAAccountDetails "+ce.toString());
		}
		finally
		{
			try
			{				
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRequestValues;
		
	}
	
	public void updateNPAprovisioning(HashMap hshValues) 
	{
		String strQuery = "";
		ResultSet rs = null;
		Connection connTemp = null; 
		CallableStatement CallStmt = null;
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues = new ArrayList();
		
		String strAction = "",strFromPage="";
		try
		{
			strAction = Helper.correctNull((String)hshValues.get("hidAction"));
			
			if("UploadFile".equalsIgnoreCase(strAction))
			{
				log.info("********** NPA_PROVISIONING_BACKUP Procedure Started  ************");
				
				connTemp = ConnectionFactory.getConnection();
				CallStmt = connTemp.prepareCall("call NPA_PROVISIONING_BACKUP()");
				CallStmt.execute();
				CallStmt.clearParameters();
				CallStmt.close();
				connTemp.close();
				
				log.info("********** NPA_PROVISIONING_BACKUP Procedure Completed  ************");
				
				connTemp = ConnectionFactory.getConnection();
				CallStmt = connTemp.prepareCall("call NPA_PROV_TABLE_INDX_REBUILD()");
				CallStmt.execute();
				CallStmt.clearParameters();
				CallStmt.close();
				connTemp.close();
				
				log.info("********** Indexes Rebuilded  ************");
			}
			if("RevertFile".equalsIgnoreCase(strAction))
			{
				log.info("********** NPA_PROVISIONING_REVERT Procedure Started  ************");
				
				connTemp = ConnectionFactory.getConnection();
				CallStmt = connTemp.prepareCall("call NPA_PROVISIONING_REVERT()");
				CallStmt.execute();
				CallStmt.clearParameters();
				CallStmt.close();
				connTemp.close();
				
				log.info("********** NPA_PROVISIONING_REVERT Procedure Completed  ************");
			}
			if("Calculate".equalsIgnoreCase(strAction))
			{
				rs=DBUtils.executeLAPSQuery("chk_npa_prov_enddate^"+Helper.correctNull((String)hshValues.get("txt_qenddate")));
				if(!rs.next())
				{
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "ins_npa_prov_enddate");
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_qenddate")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
					
					hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					
				}
				
				
				long startTime = System.currentTimeMillis();
				if("".equalsIgnoreCase(strFromPage))
				{
					log.info("********** NPA_PROVISIONING_MAIN_1 Procedure Started  ************");
					
					connTemp = ConnectionFactory.getConnection();
					CallStmt = connTemp.prepareCall("call NPA_PROVISIONING_MAIN_1()");
					CallStmt.execute();
					CallStmt.clearParameters();
					CallStmt.close();
					connTemp.close();
					
					log.info("********** NPA_PROVISIONING_MAIN_1 Procedure Completed  ************");
					
					connTemp = ConnectionFactory.getConnection();
					CallStmt = connTemp.prepareCall("call NPA_PROV_TABLE_INDX_REBUILD()");
					CallStmt.execute();
					CallStmt.clearParameters();
					CallStmt.close();
					connTemp.close();
					
					log.info("********** Indexes Rebuilded  ************");
				}
				if("".equalsIgnoreCase(strFromPage))
				{
					log.info("********** NPA_PROVISIONING_MAIN_2 Procedure Started  ************");
					
					connTemp = ConnectionFactory.getConnection();
					CallStmt = connTemp.prepareCall("call NPA_PROVISIONING_MAIN_2()");
					CallStmt.execute();
					CallStmt.clearParameters();
					CallStmt.close();
					connTemp.close();
					
					log.info("********** NPA_PROVISIONING_MAIN_2 Procedure Completed  ************");
					
					connTemp = ConnectionFactory.getConnection();
					CallStmt = connTemp.prepareCall("call NPA_PROV_TABLE_INDX_REBUILD()");
					CallStmt.execute();
					CallStmt.clearParameters();
					CallStmt.close();
					connTemp.close();
					
					log.info("********** Indexes Rebuilded  ************");
				}
				if("".equalsIgnoreCase(strFromPage))
				{
					log.info("********** NPA_PROVISIONING_MAIN_3 Procedure Started  ************");
					
					connTemp = ConnectionFactory.getConnection();
					CallStmt = connTemp.prepareCall("call NPA_PROVISIONING_MAIN_3()");
					CallStmt.execute();
					CallStmt.clearParameters();
					CallStmt.close();
					connTemp.close();
					
					log.info("********** NPA_PROVISIONING_MAIN_3 Procedure Completed  ************");
					
					connTemp = ConnectionFactory.getConnection();
					CallStmt = connTemp.prepareCall("call NPA_PROV_TABLE_INDX_REBUILD()");
					CallStmt.execute();
					CallStmt.clearParameters();
					CallStmt.close();
					connTemp.close();
					
					log.info("********** Indexes Rebuilded  ************");
					
					long endTime = System.currentTimeMillis();
					
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "upd_exec_status");
					arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
					arrValues.add(Helper.correctNull((String)hshValues.get("strSolid")));
					arrValues.add(Helper.correctNull(String.valueOf((endTime-startTime)/1000)+" Seconds"));
					arrValues.add("S");
					arrValues.add(Helper.correctNull((String)hshValues.get("hid_execsno")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				}
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updateNPAprovisioning== "+e.toString());
		}
	}
	
	public HashMap getNPAAccountVerifySearchData(HashMap hshRequestValues) 
	{
		ResultSet rs=null,rs1=null;
		String strSearch="",strSearchCriteria="",strQuery="",strText="",strGlobalSearch="",strGlobalText="";
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		try
		{
			strSearchCriteria=Helper.correctNull((String)hshRequestValues.get("rdovalue"));
			strGlobalSearch=Helper.correctNull((String)hshRequestValues.get("strSearch"));
			strSearch=Helper.correctNull((String)hshRequestValues.get("txtsearch"));
			
			if(strSearchCriteria.equalsIgnoreCase("CBSID"))
			{
				strText=  "and cust_id='"+strSearch+"' ";
				strGlobalText=  "and perapp_cbsid='"+strSearch+"' ";
			}
			else if(strSearchCriteria.equalsIgnoreCase("NAME"))
			{
				strText=  " and upper(cust_name) like ('"+strSearch.toUpperCase()+"%%') ";
				strGlobalText=  " and upper(perapp_fname) like ('"+strSearch.toUpperCase()+"%%') ";
			}
			else 
			{
				strText=  " ";	
			}
			
			if(strGlobalSearch.equalsIgnoreCase("GlobalSearch"))
				strQuery=SQLParser.getSqlQuery("npacustomersearch_globalsearch_ver^"+strText+"^"+strGlobalText);
			else
				strQuery=SQLParser.getSqlQuery("npacustomersearch_ver^"+strText+"^"+strText);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("cust_id")));//0
				arrCol.add(Helper.correctNull(rs.getString("cust_name")));//1
				arrCol.add(Helper.correctNull(rs.getString("org_name")));//2
				arrRow.add(arrCol);
			}
			
			hshRequestValues.put("arrRow",arrRow);
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getNPAAccountVerifySearchData "+ce.toString());
		}
		finally
		{
			try
			{
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRequestValues;
		
	}
	
	public void updateNPAVERFAccountDetails(HashMap hshRequestValues) 
	{
		HashMap hshQueryValues= new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strAccNo="",strFlag="",strQuery="",strAction="",strExcep="$";
		ResultSet rs=null;
		HashMap hshQuerynewValues= new HashMap();
		HashMap hshQuerynew= new HashMap();
		String strData="",strDataOld="";
		try
		{
			strAccNo=Helper.correctNull((String)hshRequestValues.get("txtaccountno"));
			strFlag=Helper.correctNull((String)hshRequestValues.get("txtinsertFlag"));
			strAction=Helper.correctNull((String)hshRequestValues.get("hidAction"));
			String strUser = correctNull((String) hshRequestValues.get("strUserId"));
			String strExeSno=Helper.correctNull((String)hshRequestValues.get("txtexecutionno"));
			
			if(strAction.equalsIgnoreCase("verify"))
			{
				hshQuerynewValues= new HashMap();
				hshQuerynew = new HashMap();
				arrValues = new ArrayList();
				hshQuerynew.put("strQueryId","upd_verf_flag");
				arrValues.add(strUser);
				arrValues.add(strAccNo);
				hshQuerynew.put("arrValues",arrValues);
				hshQuerynewValues.put("1", hshQuerynew);
				hshQuerynewValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQuerynewValues, "updateData");
			    int count=0;
				if(rs!=null)
					rs.close();
				strQuery=SQLParser.getSqlQuery("npa_datacount^"+strAccNo+"^"+strExeSno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{ 
					count=(rs.getInt("rowcount"));
					if(count >0 ){
					hshQuerynewValues= new HashMap();
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","updnpaprovaccdata");
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtNPADate")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtoutstandingamt")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtsancamt")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtinterestval")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtclearbalance")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_secvalue")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_fraudapplicant")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_npanormstatus")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_provisionvalue")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_writeoffflag")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_othercharges")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_SBCA_Flag")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_reason")));
					arrValues.add(strUser);
					arrValues.add(strAccNo);
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno")));					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1", hshQuery);
					
					hshQueryValues.put("size", "1");
					
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
					}else{
						strData="N";
					}
					
				}
				if(rs!=null)
					rs.close();
				strQuery=SQLParser.getSqlQuery("npa_dataoldcount^"+strAccNo+"^"+strExeSno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					count=(rs.getInt("rowcount"));
					if(count >0 ){
					hshQuerynewValues= new HashMap();
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","updnpa_accdata_old");
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtNPADate")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtoutstandingamt")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtsancamt")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtinterestval")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtclearbalance")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_secvalue")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_fraudapplicant")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_npanormstatus")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_provisionvalue")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_writeoffflag")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_othercharges")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_SBCA_Flag")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_reason")));
					arrValues.add(strUser);
					arrValues.add(strAccNo);	
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1", hshQuery);
					
					hshQueryValues.put("size", "1");
					
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
					}else{
						strDataOld="N";
					}					
					
				}
					
				if(("N").equalsIgnoreCase(strData) && ("N").equalsIgnoreCase(strDataOld) ){
						if(rs!=null)
							rs.close();
						strQuery=SQLParser.getSqlQuery("npa_datacheck^"+strExeSno);
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							count=(rs.getInt("rowcount"));
							if(count >0 ){
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							hshQuery.put("strQueryId","npa_insaccdata");
							arrValues.add(strAccNo);
							arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno")));
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1", hshQuery);
							
							hshQueryValues.put("size", "1");
							
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
							}
						}
						
						if(rs!=null)
							rs.close();
						strQuery=SQLParser.getSqlQuery("npa_dataoldcheck^"+strExeSno);
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							count=(rs.getInt("rowcount"));
							if(count >0 ){
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							hshQuery.put("strQueryId","npa_insaccdataold");
							arrValues.add(strAccNo);
							arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno")));
							
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1", hshQuery);
							
							hshQueryValues.put("size", "1");
							
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
							}
						}
						hshQuerynewValues= new HashMap();
						hshQuerynew = new HashMap();
						arrValues = new ArrayList();
						hshQuerynew.put("strQueryId","insnpaverprovaccdatamoc");
						arrValues.add(strAccNo);
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno")));
						arrValues.add(strAccNo);
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno")));
						arrValues.add(strAccNo);
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno")));
						arrValues.add(strAccNo);
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno")));
						
						hshQuerynew.put("arrValues",arrValues);
						hshQuerynewValues.put("1", hshQuerynew);
						hshQuerynewValues.put("size", "1");
						EJBInvoker.executeStateLess("dataaccess", hshQuerynewValues, "updateData");
					     
						
						
					}
				
				hshQuerynewValues= new HashMap();
				hshQuerynew = new HashMap();
				arrValues = new ArrayList();
				hshQuerynew.put("strQueryId","upd_verfhis_flag");
				
				arrValues.add(strAccNo);
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno")));
				arrValues.add(strAccNo);
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno")));
				arrValues.add(strAccNo);
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno")));
				arrValues.add(strAccNo);
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txtexecutionno")));
				
				hshQuerynew.put("arrValues",arrValues);
				hshQuerynewValues.put("1", hshQuerynew);
				hshQuerynewValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQuerynewValues, "updateData");
			    
					
					
				}else if(strAction.equalsIgnoreCase("reject"))
				{
					hshQueryValues= new HashMap();
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","del_mocdata");
					arrValues.add(strAccNo);
					arrValues.add(strExeSno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1", hshQuery);					
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
					
					hshQueryValues= new HashMap();
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","del_mochisdata");					
					arrValues.add(strAccNo);
					arrValues.add(strExeSno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1", hshQuery);					
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
					
					
					
				}
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateNPAAccountDetails "+ce.toString());
		}
		finally
		{
			try
			{
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		
	}
	
	public HashMap getNPAverfAccountDetails(HashMap hshRequestValues) 
	{
		
		java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		nf.setGroupingUsed(false);
		
		ResultSet rs=null,rs1=null,rs3=null;
		String strCBSID="",strQuery="",strName="",strOrgName="",strorg="";
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		
		try
		{
			
			strCBSID=Helper.correctNull((String)hshRequestValues.get("hidCBSID"));
			strName=Helper.correctNull((String)hshRequestValues.get("hidname"));
			String strUser = correctNull((String) hshRequestValues.get("strUserId"));
			strQuery=SQLParser.getSqlQuery("npaverfaccountdetails^"+strCBSID);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("acc_no")));//0
				arrCol.add(Helper.correctNull(rs.getString("proposal_no")));//1
				if(Helper.correctNull(rs.getString("loan_type")).equalsIgnoreCase("S"))
				{
					arrCol.add("");//2
					arrCol.add("");//3
				}
				else if(Helper.correctNull(rs.getString("loan_type")).equalsIgnoreCase("P"))
				{
					arrCol.add("1");//2
					if(rs1!=null)
						rs1.close();
					strQuery=SQLParser.getSqlQuery("sel_retailfacdescription^"+Helper.correctNull(rs.getString("proposal_no")));
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						arrCol.add(Helper.correctNull(rs1.getString("prd_desc")));//3
					}
					else
					{
						arrCol.add("");//3
					}
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("proposal_sno")));//2
					if(rs1!=null)
						rs1.close();
					strQuery=SQLParser.getSqlQuery("sel_corpagrifacdescription^"+Helper.correctInt(rs.getString("proposal_sno"))+"^"+Helper.correctNull(rs.getString("proposal_no")));
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						arrCol.add(Helper.correctNull(rs1.getString("com_facdesc")));//3
					}
					else
					{
						arrCol.add("");//3
					}
				}
				arrCol.add(Helper.correctNull(rs.getString("npa_date")));//4
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("sanc_limit")))));//5
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("os_limit")))));//6
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("unreal_int_val")))));//7
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("coverage_val_sanc")))));//8
				arrCol.add(Helper.correctNull(rs.getString("cust_id")));//9
				arrCol.add(Helper.correctNull(rs.getString("cust_name")));//10
				arrCol.add(Helper.correctNull(rs.getString("type")));//11
				arrCol.add(Helper.correctNull(rs.getString("loan_type")));//12
				arrCol.add(Helper.correctNull(rs.getString("execution_no")));//13
				arrCol.add(Helper.correctNull(rs.getString("as_on_date")));//14
				arrCol.add(Helper.correctNull(rs.getString("org_soldid")));//15
				arrCol.add(Helper.correctNull(rs.getString("org_name")));//16
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("unsec_os_limit")))));//17
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("prime_sec_val")))));//18
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("prov_value")))));//19
				arrCol.add(Helper.correctNull(rs.getString("fraud_applnt")));//20
				arrCol.add(Helper.correctNull(rs.getString("norm_status")));//21
				if(Helper.correctNull(rs.getString("fraud_applnt")).equalsIgnoreCase("Y"))
					arrCol.add("Yes");//22
				else
					arrCol.add("No");//22
				arrCol.add(Helper.correctNull(rs.getString("regionname")));//23
				arrCol.add(Helper.correctNull(rs.getString("npa_mannualflag")));//24
				arrCol.add(Helper.correctNull(rs.getString("write_off")));//25
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("othr_charges")))));//26
				arrCol.add(Helper.correctNull(rs.getString("npa_sbca_acc")));//27
				arrCol.add(Helper.correctNull(rs.getString("npa_reason")));//28
				if(!strCBSID.equalsIgnoreCase(""))
				{
					rs3=DBUtils.executeLAPSQuery("sel_verf_chk^"+strUser+"^"+Helper.correctNull(rs.getString("acc_no")));
					if(rs3.next())
					{
						arrCol.add("Y");//29
					}else{
						arrCol.add("N");//29
					}
				}
				arrCol.add(Helper.correctNull(rs.getString("NPA_VERIFICATION_FLAG")));//30
				arrRow.add(arrCol);
				strName=Helper.correctNull(rs.getString("cust_name"));
			}
			
			if(rs!=null)
				rs.close();
			
			rs=DBUtils.executeLAPSQuery("sel_max_npaprovno");
			if(rs.next())
			{
				hshRequestValues.put("strExeNo", Helper.correctNull(rs.getString("exe_sno")));
				hshRequestValues.put("strExeDate", Helper.correctNull(rs.getString("exe_date")));
			}
			
			hshRequestValues.put("arrRow", arrRow);
			hshRequestValues.put("strName", strName);
			hshRequestValues.put("strCBSID", strCBSID);
			
			if(strName.equalsIgnoreCase("") && !strCBSID.equalsIgnoreCase(""))
			{
				if(rs!=null)
					rs.close();
				
				rs=DBUtils.executeLAPSQuery("sel_lapsidfromcbsid^"+strCBSID);
				if(rs.next())
				{
					hshRequestValues.put("strName", Helper.correctNull(rs.getString("perapp_fname")));
				}
			}
			if(rs!=null)
				rs.close();
			
			
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getNPAverfAccountDetails "+ce.toString());
		}
		finally
		{
			try
			{				
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRequestValues;
		
	}
	public HashMap getExecMOCDetails(HashMap hshRequestValues) 
	{
		ResultSet rs=null;
		String strdate="";
		String strSno="";
		String strText="";
		String strGlobalText="";
		String strId="";
		try
		{
			String strSearchCriteria=Helper.correctNull((String)hshRequestValues.get("rdovalue"));
			String strGlobalSearch=Helper.correctNull((String)hshRequestValues.get("strSearch"));
			String strSearch=Helper.correctNull((String)hshRequestValues.get("hidsearch"));
			strdate=Helper.correctNull((String)hshRequestValues.get("hid_date"));
			if(strSearchCriteria.equalsIgnoreCase("CBSID"))
			{
				strText=  "cust_id='"+strSearch+"' ";
				strId="CBSID";
			}
			else if(strSearchCriteria.equalsIgnoreCase("NAME"))
			{
				strText=  "upper(cust_name) like ('"+strSearch.toUpperCase()+"%%') ";
				strId="NAME";
			}
			else 
			{
				strText=  " ";	
			}
			String strQuery="";
			if(!("").equalsIgnoreCase(strdate)){
			strQuery=SQLParser.getSqlQuery("npasnocustomersearch^"+strText+"^"+strdate+"^"+strText+"^"+strdate);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
				strSno= Helper.correctNull(rs.getString("exe_sno"));
			}}
			hshRequestValues.put("RecordFlag", "Y");
			hshRequestValues.put("strSno", strSno);
			hshRequestValues.put("strId", strId);
			hshRequestValues.put("strSearch", strSearch);
			hshRequestValues.put("strdate", strdate);
			hshRequestValues.put("strGlobalSearch", strGlobalSearch);
			
			if(rs!=null)
				rs.close();
			}
		catch(Exception ce)
		{
			throw new EJBException("Error in getExecMOCDetails "+ce.toString());
		}
		finally
		{
			try
			{				
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRequestValues;
		
	}
}
