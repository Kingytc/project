/****
 * @author Madhura.V
 * @
 * @since Sep 2007
*****/
package com.sai.laps.ejb.setstatecity;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.ApplicantParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.SetupParams;

@Stateless(name = "SetStateCityBean", mappedName = "SetStateCityHome")
@Remote (SetStateCityRemote.class)

public class SetStateCityBean extends BeanAdapter
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -7473041542017785555L;
	static Logger log=Logger.getLogger(SetStateCityBean.class);
	/**
	 * 
	 */
	
	public HashMap updateStateDetails(HashMap hshValues) 
	{
		HashMap hshQueryVal=new HashMap();
		HashMap hshQuery=new HashMap();
		HashMap hsh=new HashMap();
		ArrayList arrValues=new ArrayList();
		HashMap hshQueryValOnl=new HashMap();
		HashMap hshQueryOnl=new HashMap();
		ArrayList arrValuesOnl=new ArrayList();
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		String strAction=(String)hshValues.get("hidAction");
		int intUpdatesize=0;
		String strStateId="",strsId="",strStateCode="";
		String strExcep="$";
		String flag="No";
		StringBuilder sbolddata = new StringBuilder();
		try
		{
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			strStateId=Helper.correctNull((String)hshValues.get("hidstateID"));
			strStateCode=correctNull((String)hshValues.get("txt_statecode"));
			String strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			if(strAction.equalsIgnoreCase("Delete") || strAction.equalsIgnoreCase("Update"))
			{
				rs = DBUtils.executeLAPSQuery("sel_statename_audit^"+Helper.correctNull((String)hshValues.get("hidstateID")));
				if(rs.next())
				{
					sbolddata.append("~ State Name = "+Helper.correctNull((String)rs.getString("state_name")));
					sbolddata.append("~ State Code = "+Helper.correctNull((String)rs.getString("state_code")));
					sbolddata.append("~ CIBIL State Code = "+Helper.correctNull((String)rs.getString("state_cibilcode")));
					sbolddata.append("~ Pin code First two digit(MIN) = "+Helper.correctNull((String)rs.getString("state_pinmin")));
					sbolddata.append("~ Pin code First two digit(MAX) = "+Helper.correctNull((String)rs.getString("state_pinmax")));
				}
				if(rs!=null)
				rs.close();
			}
			if(strAction.equalsIgnoreCase("Delete"))
			{
				rs2=DBUtils.executeLAPSQuery("selStateIdCheck^"+strStateId);
				if(rs2.next())
				{
					if(!rs2.getString(1).equalsIgnoreCase(""))
					{
						strExcep="Cannot delete the state.It consists of city";
						hsh = getData(hsh);
						flag="Yes";
						hsh.put("msg",strExcep);
						hsh.put("flag",flag);
						//throw new Exception(strExcep);	
					}
				}
				else
				{
					++intUpdatesize;
					hshQuery.put("strQueryId","delstatedetails");
					arrValues.add(strStateId);
					hshQuery.put("arrValues",arrValues);
					
					hshQueryOnl.put("strQueryId","del_statedetails_online");
					arrValuesOnl.add("1"+strStateId);
					hshQueryOnl.put("arrValues",arrValuesOnl);
					//hsh = getData(hsh);
				}
				
			}
			//To avoid State code Duplication
			else if(strAction.equalsIgnoreCase("Insert"))
			{
				rs1=DBUtils.executeLAPSQuery("selStateCodeCheckDuplication^"+strStateCode);
				if(rs1.next())
				{
					if(!rs1.getString(1).equalsIgnoreCase(""))
					{
						strExcep="Already the State Code Exist";
						hsh = getData(hsh);
						flag="Yes";
						hsh.put("msg",strExcep);
						hsh.put("flag",flag);
						//throw new Exception(strExcep);
					}
				}
				else
				{
					rs=DBUtils.executeLAPSQuery("selmaxstateid");
					if(rs.next())
					{
						strsId = correctNull((String)rs.getString("stateidmax"));
					}
					else
					{
						strsId = "1";
					}
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					++intUpdatesize;
					hshQuery.put("strQueryId","insstatedetails");
					arrValues.add(strsId);
					arrValues.add(correctNull((String)hshValues.get("txt_statecode")));
					arrValues.add(correctNull((String)hshValues.get("txt_statename")));
					arrValues.add(correctNull((String)hshValues.get("txt_cibilcode")));
					arrValues.add(correctNull((String)hshValues.get("txt_minpincode")));
					arrValues.add(correctNull((String)hshValues.get("txt_maxpincode")));
					arrValues.add(correctNull((String)hshValues.get("sel_active")));
					hshQuery.put("arrValues",arrValues);
					
					hshQueryOnl=new HashMap();
					arrValuesOnl=new ArrayList();
					hshQueryOnl.put("strQueryId","ins_statecitydetails_onl");
					arrValuesOnl.add("1"+strsId);
					arrValuesOnl.add("S");
					arrValuesOnl.add(correctNull((String)hshValues.get("txt_statecode")));
					arrValuesOnl.add(correctNull((String)hshValues.get("txt_statename")));
					arrValuesOnl.add("0");
					arrValuesOnl.add("N");
					hshQueryOnl.put("arrValues",arrValuesOnl);
					//hsh = getData(hsh);
				}		
			}
			else if(strAction.equalsIgnoreCase("Update"))
			{
				if(!correctNull((String)hshValues.get("hidstatecode")).equalsIgnoreCase(correctNull((String)hshValues.get("txt_statecode"))))
				{
				rs1=DBUtils.executeLAPSQuery("selStateCodeCheckDuplication^"+strStateCode);
				if(rs1.next())
				{
					if(!rs1.getString(1).equalsIgnoreCase(""))
					{
					strExcep="Already the State Code Exist";
					hsh = getData(hsh);
					flag="Yes";
					hsh.put("msg",strExcep);
					hsh.put("flag",flag);
					//throw new Exception(strExcep);
					}
				}
				}
				if(flag.equalsIgnoreCase("No"))
				{
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					++intUpdatesize;
					hshQuery.put("strQueryId","updstatedetails");
					arrValues.add(correctNull((String)hshValues.get("txt_statecode")));
					arrValues.add(correctNull((String)hshValues.get("txt_statename")));
					arrValues.add(correctNull((String)hshValues.get("txt_cibilcode")));
					arrValues.add(correctNull((String)hshValues.get("txt_minpincode")));
					arrValues.add(correctNull((String)hshValues.get("txt_maxpincode")));
					arrValues.add(correctNull((String)hshValues.get("sel_active")));
					arrValues.add(correctNull((String)hshValues.get("hidstateID")));
					hshQuery.put("arrValues",arrValues);
					
					hshQueryOnl=new HashMap();
					arrValuesOnl=new ArrayList();
					hshQueryOnl.put("strQueryId","upd_statecitydetails_onl");
					arrValuesOnl.add(correctNull((String)hshValues.get("txt_statecode")));
					arrValuesOnl.add(correctNull((String)hshValues.get("txt_statename")));
					arrValuesOnl.add("1"+correctNull((String)hshValues.get("hidstateID")));
					hshQueryOnl.put("arrValues",arrValuesOnl);
					//hsh = getData(hsh);
				}	
			}
			
			hshQueryVal.put("size",Integer.toString(intUpdatesize));
			hshQueryVal.put(Integer.toString(intUpdatesize),hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryVal,"updateData");
			
			/*hshQueryValOnl.put("size",Integer.toString(intUpdatesize));
			hshQueryValOnl.put(Integer.toString(intUpdatesize),hshQueryOnl);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValOnl,"updateInternetData");*/
			
			if(flag.equalsIgnoreCase("No"))
			{
				hsh = getData(hsh);
			}
		
				StringBuilder sbAuditTrial=new StringBuilder();
				if(!strAction.equalsIgnoreCase("Delete"))
				{
					sbAuditTrial.append("~ State Name =").append(correctNull((String )hshValues.get("txt_statename"))).append("~State Code  =").append(correctNull((String )hshValues.get("txt_statecode")))
					.append("~ CIBIL State Code =").append(correctNull((String )hshValues.get("txt_cibilcode")))
					.append("~ Pin code First two digit(MIN) =").append(correctNull((String )hshValues.get("txt_minpincode")))
					.append("~ Pin code First two digit(MAX) =").append(correctNull((String )hshValues.get("txt_maxpincode")));
				}
				//if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
				//	hshValues.put("hidAction", "update");
				AuditTrial.auditNewLog(hshValues,"75",strKeyId,sbAuditTrial.toString(),sbolddata.toString());
			
		}
		catch(Exception e1)
		{
			log.error("Error in updateState.."+e1);
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
				if(rs1 != null)
				{
					rs1.close();
					
				}	
				if(rs2 != null)
				{
					rs2.close();
				}	
			
			
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
			
		}
		return hsh;
		
	}
	public HashMap getData(HashMap hsh) 
	{
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String strStateId="";
		boolean recordflag=false;
		try
		{
			strStateId=Helper.correctNull((String)hsh.get("stateid"));
			if(correctNull((String)hsh.get("val")).equalsIgnoreCase("1"))
			{
				rs=DBUtils.executeLAPSQuery("selstatename2^"+strStateId);
				if(rs.next())
				{
					hshRecord.put("state_validatepin",correctNull((String)rs.getString("state_pinmin"))+"~"+correctNull((String)rs.getString("state_pinmax")));
				}
			}
			else
			{
			rs=DBUtils.executeLAPSQuery("selstatedetails");
			while(rs.next())
				{
				recordflag=true;
					vecCol = new ArrayList();
					vecCol.add(correctNull((String)rs.getString("state_id")));
					vecCol.add(correctNull((String)rs.getString("state_code")));
					vecCol.add(correctNull((String)rs.getString("state_name")));
					vecCol.add(correctNull((String)rs.getString("state_cibilcode")));
					vecCol.add(correctNull((String)rs.getString("state_pinmin")));
					vecCol.add(correctNull((String)rs.getString("state_pinmax")));
					vecCol.add(correctNull((String)rs.getString("STATE_ACTION")));
					vecRow.add(vecCol);
				}
			}
			
			hshRecord.put("vecRow",vecRow);			
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
	public HashMap updateCibilDetails(HashMap hshValues) 
	{
		HashMap hshQueryVal=new HashMap();
		HashMap hshQuery=new HashMap();
		HashMap hsh=new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		String strAction=(String)hshValues.get("hidAction");
		int intUpdatesize=0;
		String strSlno="",strsId="",strStateCode="";
		String strExcep="$";
		String flag="No";
		String strQuery="",strKeyId="";
		try
		{
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			strSlno=Helper.correctNull((String)hshValues.get("hidslno"));
			strStateCode=correctNull((String)hshValues.get("txt_statecode"));
			strKeyId = correctNull((String)hshValues.get("hidkeyid"));
			
			//Added By Zahoorunnisa.S For Audit Trial
			StringBuilder sbAuditTrialOld=new StringBuilder();
			if(!strAction.equalsIgnoreCase("insert")){
		
			strQuery = SQLParser.getSqlQuery("sel_cibilproducts_audittrail^" + strSlno);
			rs = DBUtils.executeQuery(strQuery);
			
			while (rs.next()) {	
			sbAuditTrialOld.append("Value=").append(correctNull((String)rs.getString("mc_value")))
				.append("~Acronym  =").append(correctNull((String)rs.getString("mc_acronym")))
				.append("~Account Type =").append(correctNull((String)rs.getString("mc_acctype")))
				.append("~Loan Type =").append(ApplicantParams.getApplicantParams("cibilinterface",correctNull((String)rs.getString("mc_loantype"))));
				
			}}
			//End
			
			
			if(strAction.equalsIgnoreCase("Delete"))
			{
					++intUpdatesize;
					hshQuery.put("strQueryId","del_cibilproducts");
					arrValues.add(strSlno);
					hshQuery.put("arrValues",arrValues);
			}
			else if(strAction.equalsIgnoreCase("Insert"))
			{
				
					rs=DBUtils.executeLAPSQuery("selmax_cibilproducts");
					if(rs.next())
					{
						strsId = correctNull((String)rs.getString("mc_slno"));
					}
					else
					{
						strsId = "1";
					}
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					++intUpdatesize;
					hshQuery.put("strQueryId","ins_cibilproducts");
					arrValues.add(correctNull((String)hshValues.get("txt_value")));
					arrValues.add(strsId);
					arrValues.add(correctNull((String)hshValues.get("txt_acronym")));
					arrValues.add(correctNull((String)hshValues.get("txt_acctype")));
					arrValues.add(correctNull((String)hshValues.get("sel_loantype")));
					
					hshQuery.put("arrValues",arrValues);
			}
			else if(strAction.equalsIgnoreCase("Update"))
			{
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					++intUpdatesize;
					
					hshQuery.put("strQueryId","upd_cibilproducts");
					arrValues.add(correctNull((String)hshValues.get("txt_value")));
					arrValues.add(correctNull((String)hshValues.get("txt_acronym")));
					arrValues.add(correctNull((String)hshValues.get("txt_acctype")));
					arrValues.add(correctNull((String)hshValues.get("sel_loantype")));
					arrValues.add(correctNull((String)hshValues.get("hidslno")));
					hshQuery.put("arrValues",arrValues);
			}
			hshQueryVal.put("size",Integer.toString(intUpdatesize));
			hshQueryVal.put(Integer.toString(intUpdatesize),hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryVal,"updateData");
			
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if (strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update")) {
				
				sbAuditTrial.append("Value=").append(correctNull((String)hshValues.get("txt_value")))
				.append("~Acronym  =").append(correctNull((String)hshValues.get("txt_acronym")))
				.append("~Account Type ^").append(correctNull((String)hshValues.get("txt_acctype")))
				.append("~Loan Type =").append(ApplicantParams.getApplicantParams("cibilinterface",correctNull((String)hshValues.get("sel_loantype"))));
				
			}
			AuditTrial.auditNewLog(hshValues,"412",strKeyId,sbAuditTrial.toString(),sbAuditTrialOld.toString());
		}
		catch(Exception e1)
		{
			log.error("Error in updateCibilDetails.."+e1);
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
				if(rs1 != null)
				{
					rs1.close();
					
				}	
				if(rs2 != null)
				{
					rs2.close();
				}	
			
			
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
			
		}
		return hsh;
		
	}
	public HashMap getDataCibilDetails(HashMap hsh) 
	{
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		try
		{
			rs=DBUtils.executeLAPSQuery("sel_cibilproducts");
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull((String)rs.getString("mc_value")));//0
				vecCol.add(correctNull((String)rs.getString("mc_slno")));//1
				vecCol.add(correctNull((String)rs.getString("mc_acronym")));//2
				vecCol.add(correctNull((String)rs.getString("mc_acctype")));//3
				vecCol.add(correctNull((String)rs.getString("mc_loantype")));//4
				vecRow.add(vecCol);
			}
		
			hshRecord.put("vecRow",vecRow);			
			
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
	
	
	public HashMap updateUserOnlDetails(HashMap hshValues) 
	{
		HashMap hshQueryVal=new HashMap();
		HashMap hshQuery=new HashMap();
		HashMap hsh=new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		String strAction=(String)hshValues.get("hidAction");
		int intUpdatesize=0;
		String strQuery="",strKeyId="";
		try
		{
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","del_bulk_user_onl");
			hshQuery.put("arrValues",arrValues);
			hshQueryVal.put("1",hshQuery);
			
			hshQuery=new HashMap();
			hshQuery.put("strQueryId","ins_bulk_user_onl");
			hshQuery.put("arrValues",arrValues);
			hshQueryVal.put("2",hshQuery);
			
			hshQueryVal.put("size","2");
			EJBInvoker.executeStateLess("dataaccess",hshQueryVal,"updateInternetData");
			
		}
		catch(Exception e1)
		{
			log.error("Error in updateUserOnlDetails.."+e1);
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
				if(rs1 != null)
				{
					rs1.close();
					
				}	
				if(rs2 != null)
				{
					rs2.close();
				}	
			
			
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
			
		}
		return hsh;
		
	}
	
	public HashMap updateOrgOnlDetails(HashMap hshValues) 
	{
		HashMap hshQueryVal=new HashMap();
		HashMap hshQuery=new HashMap();
		HashMap hsh=new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		String strAction=(String)hshValues.get("hidAction");
		int intUpdatesize=0;
		String strQuery="",strKeyId="";
		try
		{
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","del_bulk_org_onl");
			hshQuery.put("arrValues",arrValues);
			hshQueryVal.put("1",hshQuery);
			
			hshQuery=new HashMap();
			hshQuery.put("strQueryId","ins_bulk_org_onl");
			hshQuery.put("arrValues",arrValues);
			hshQueryVal.put("2",hshQuery);
			
			hshQueryVal.put("size","2");
			EJBInvoker.executeStateLess("dataaccess",hshQueryVal,"updateInternetData");
			
		}
		catch(Exception e1)
		{
			log.error("Error in updateCibilDetails.."+e1);
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
				if(rs1 != null)
				{
					rs1.close();
					
				}	
				if(rs2 != null)
				{
					rs2.close();
				}	
			
			
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
			
		}
		return hsh;
		
	}
	
	
	public HashMap updateCityOnlDetails(HashMap hshValues) 
	{
		HashMap hshQueryVal=new HashMap();
		HashMap hshQuery=new HashMap();
		HashMap hsh=new HashMap();
		ArrayList arrValues=new ArrayList();
		try
		{

			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","del_bulk_city_onl");
			hshQuery.put("arrValues",arrValues);
			hshQueryVal.put("1",hshQuery);
			
			hshQuery=new HashMap();
			hshQuery.put("strQueryId","ins_bulk_city_onl");
			hshQuery.put("arrValues",arrValues);
			hshQueryVal.put("2",hshQuery);
			
			hshQueryVal.put("size","2");
			EJBInvoker.executeStateLess("dataaccess",hshQueryVal,"updateInternetData");
			
		}
		catch(Exception e1)
		{
			log.error("Error in updateCibilDetails.."+e1);
			throw new EJBException(e1.getMessage());
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
		return hsh;
		
	}
	
	public HashMap updateStateOnlDetails(HashMap hshValues) 
	{
		HashMap hshQueryVal=new HashMap();
		HashMap hshQuery=new HashMap();
		HashMap hsh=new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		String strAction=(String)hshValues.get("hidAction");
		int intUpdatesize=0;
		String strQuery="",strKeyId="";
		try
		{

			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","del_bulk_state_onl");
			hshQuery.put("arrValues",arrValues);
			hshQueryVal.put("1",hshQuery);
			
			hshQuery=new HashMap();
			hshQuery.put("strQueryId","ins_bulk_state_onl");
			hshQuery.put("arrValues",arrValues);
			hshQueryVal.put("2",hshQuery);
			
			hshQueryVal.put("size","2");
			EJBInvoker.executeStateLess("dataaccess",hshQueryVal,"updateInternetData");
			
		}
		catch(Exception e1)
		{
			log.error("Error in updateCibilDetails.."+e1);
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
				if(rs1 != null)
				{
					rs1.close();
					
				}	
				if(rs2 != null)
				{
					rs2.close();
				}	
			
			
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
			
		}
		return hsh;
		
	}
}
