package com.sai.laps.ejb.agreligibility;

import java.rmi.RemoteException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "AgrEligibilityBean", mappedName = "AgrEligibilityHome")
@Remote (AgrEligibilityRemote.class)
public class AgrEligibilityBean extends BeanAdapter
{
	static Logger log=Logger.getLogger(AgrEligibilityBean.class);	
	/**
	 * 
	 */
	private static final long serialVersionUID = -1544647393147205645L;



	/**
	 * 
	 */
	

	public  HashMap getUGCC_Eligibility(HashMap hshValues) 
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		double grossinc=0.00,totaldeduc=0.00,annual_inc=0.00,dbtotal_otherinc=0.00;
		
		
		String appno = correctNull((String) hshValues.get("strappno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("appno"));
		}
		
		try
		{
		strQuery = SQLParser.getSqlQuery("getincomededuction^"+appno);
		rs=DBUtils.executeQuery(strQuery);
		while(rs.next())
		{	
			
			grossinc=Double.parseDouble(Helper.correctDouble(rs.getString("perinc_yearsalary")));
			dbtotal_otherinc=Double.parseDouble(Helper.correctDouble(rs.getString("perinc_secincome")));
			hshResult.put("perinc_yearsalary",""+(grossinc+dbtotal_otherinc));
			hshResult.put("totaldeduc",correctNull(rs.getString("totaldeduc")));
			totaldeduc=Double.parseDouble(Helper.correctDouble(rs.getString("totaldeduc")));
			
			
			annual_inc=(grossinc+dbtotal_otherinc)-totaldeduc;
			hshResult.put("annual_inc",Helper.formatDoubleValue(annual_inc));
			
						
		}
		if(rs != null)
		{
			rs.close();
			rs=null;
		}
		strQuery = SQLParser.getSqlQuery("sel_ugcc_eligibility^"+appno);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{	
		
			hshResult.put("SPOUSE_UBI",correctNull(rs.getString("SPOUSE_UBI")));
			hshResult.put("LOAN_ACC_NO",correctNull(rs.getString("LOAN_ACC_NO")));
			hshResult.put("OTHER_DETAILS",correctNull(rs.getString("OTHER_DETAILS")));
			hshResult.put("SPOUSE_GUARANTEE",correctNull(rs.getString("SPOUSE_GUARANTEE")));
			hshResult.put("ONBEHALF_OF",correctNull(rs.getString("ONBEHALF_OF")));
			hshResult.put("ORG_NAME",correctNull(rs.getString("ORG_NAME")));
			hshResult.put("AMOUNT",correctNull(rs.getString("AMOUNT")));
			hshResult.put("TOT_GROSS_INCOME",correctNull(rs.getString("TOT_GROSS_INCOME")));
			hshResult.put("TOT_EXPENSES",correctNull(rs.getString("TOT_EXPENSES")));
			hshResult.put("NET_INCOME",correctNull(rs.getString("NET_INCOME")));
			hshResult.put("NET_INCOME_BRANCH",correctNull(rs.getString("NET_INCOME_BRANCH")));
			hshResult.put("RECOMMENDED_LIMIT",correctNull(rs.getString("RECOMMENDED_LIMIT")));
			hshResult.put("RATE_OF_INTEREST",correctNull(rs.getString("RATE_OF_INTEREST")));
			hshResult.put("SECURITY_DOC",correctNull(rs.getString("SECURITY_DOC")));
		}
		else
		{
			hshResult.put("auditFlag", "Y");
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
		
		return hshResult;
	}
		
	
	
		
	
	
	public void updateUGCC_Eligibility(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues= new ArrayList();
		String strAction = null;		
		strAction = correctNull((String) hshValues.get("hidAction"));
		   
		String appno = correctNull((String) hshValues.get("strappno"));
		StringBuilder sbaudittrail=null;
		StringBuilder sbAuditTrialOld=new StringBuilder();
		try
		{
			if(correctNull((String) hshValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
			{
				strAction="insert";
				hshValues.put("strAction", "insert");
			}
			else
			{
				if(!strAction.equalsIgnoreCase("delete"))
				{
				strAction="update";
				hshValues.put("strAction", "update");
				}
			}
			if(!strAction.equalsIgnoreCase("insert"))
			{
				String strQuery = SQLParser.getSqlQuery("sel_ugcc_eligibility^"+appno);
				ResultSet rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{	
				sbAuditTrialOld.append("~Loan Applied Earlier TO UBI= ");
				if(correctNull((String)rs.getString("SPOUSE_UBI")).equals("y"))
				{
					sbAuditTrialOld.append("Yes")
								.append("~Loan A/C No= ").append(correctNull((String)rs.getString("LOAN_ACC_NO")))
								.append("~Other Details= ").append(correctNull((String)rs.getString("OTHER_DETAILS")));
				}
				else
				if(correctNull((String)rs.getString("SPOUSE_UBI")).equals("n"))
				{
					sbAuditTrialOld.append("No");
				}
				sbAuditTrialOld.append("~Personal Guarantee(s)= ");
				if(correctNull((String)rs.getString("SPOUSE_GUARANTEE")).equals("y"))
				{
					sbAuditTrialOld.append("Yes")
								.append("~On Behalf Of= ").append(correctNull((String)rs.getString("ONBEHALF_OF")))
								.append("~Name Of The Organisation= ").append(correctNull((String)rs.getString("ORG_NAME")))
								.append("~Amount= ").append(correctNull((String)rs.getString("AMOUNT")));
				}
				else
				if(correctNull((String)rs.getString("SPOUSE_GUARANTEE")).equals("n"))
				{
					sbAuditTrialOld.append("No");
				}
				sbAuditTrialOld.append("~Gross Annual Income= ").append(correctNull((String)rs.getString("TOT_GROSS_INCOME")))
							.append("~Total Expenses/Deductions= ").append(correctNull((String)rs.getString("TOT_EXPENSES")))
							.append("~Net Annual Income= ").append(correctNull((String)rs.getString("NET_INCOME")))
							.append("~Net Annual Income acceptable to the branch= ").append(correctNull((String)rs.getString("NET_INCOME_BRANCH")))
							.append("~Recommended Limit= ").append(correctNull((String)rs.getString("RECOMMENDED_LIMIT")))
							.append("~Rate Of Interest= ").append(correctNull((String)rs.getString("RATE_OF_INTEREST")))
							.append("~Security Documents= ").append(correctNull((String)rs.getString("SECURITY_DOC")));
				}
			}
			sbaudittrail=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{
				    hshQueryValues = new HashMap();
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","del_ugcc_eligibility");
					arrValues.add(appno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
				
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQueryValues.put("size","2");
					hshQuery.put("strQueryId","ins_ugcc_eligibility");
					arrValues.add(appno);
					arrValues.add(correctNull((String)hshValues.get("selubi")));
					arrValues.add(correctNull((String)hshValues.get("txt_accno")));
					arrValues.add(correctNull((String)hshValues.get("txt_otherdetail")));
					arrValues.add(correctNull((String)hshValues.get("selguarantee")));
					arrValues.add(correctNull((String)hshValues.get("txt_behalf")));
					arrValues.add(correctNull((String)hshValues.get("txt_organisation")));
					arrValues.add(correctNull((String)hshValues.get("txt_amount")));
					arrValues.add(correctNull((String)hshValues.get("txt_grossincome")));
					arrValues.add(correctNull((String)hshValues.get("txt_exp_deduction")));
					arrValues.add(correctNull((String)hshValues.get("txt_netincome")));
					arrValues.add(correctNull((String)hshValues.get("txt_acceptbranch")));
					arrValues.add(correctNull((String)hshValues.get("txt_recomdlimit")));
					arrValues.add(correctNull((String)hshValues.get("txt_interst")));
					arrValues.add(correctNull((String)hshValues.get("txt_security")));
					
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(appno);
				
				hshQuery.put("strQueryId","del_ugcc_eligibility");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
//		 	-------Start Of Audit Trail ----------
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{
			sbaudittrail.append("~Loan Applied Earlier TO UBI= ");
			if(correctNull((String)hshValues.get("selubi")).equals("y"))
			{
				sbaudittrail.append("Yes")
							.append("~Loan A/C No= ").append(correctNull((String)hshValues.get("txt_accno")))
							.append("~Other Details= ").append(correctNull((String)hshValues.get("txt_otherdetail")));
			}
			else
			if(correctNull((String)hshValues.get("selubi")).equals("n"))
			{
				sbaudittrail.append("No");
			}
			sbaudittrail.append("~Personal Guarantee(s)= ");
			if(correctNull((String)hshValues.get("selguarantee")).equals("y"))
			{
				sbaudittrail.append("Yes")
							.append("~On Behalf Of= ").append(correctNull((String)hshValues.get("txt_behalf")))
							.append("~Name Of The Organisation= ").append(correctNull((String)hshValues.get("txt_organisation")))
							.append("~Amount= ").append(correctNull((String)hshValues.get("txt_amount")));
			}
			else
			if(correctNull((String)hshValues.get("selguarantee")).equals("n"))
			{
				sbaudittrail.append("No");
			}
			sbaudittrail.append("~Gross Annual Income= ").append(correctNull((String)hshValues.get("txt_grossincome")))
						.append("~Total Expenses/Deductions= ").append(correctNull((String)hshValues.get("txt_exp_deduction")))
						.append("~Net Annual Income= ").append(correctNull((String)hshValues.get("txt_netincome")))
						.append("~Net Annual Income acceptable to the branch= ").append(correctNull((String)hshValues.get("txt_acceptbranch")))
						.append("~Recommended Limit= ").append(correctNull((String)hshValues.get("txt_recomdlimit")))
						.append("~Rate Of Interest= ").append(correctNull((String)hshValues.get("txt_interst")))
						.append("~Security Documents= ").append(correctNull((String)hshValues.get("txt_security")));
			}
			AuditTrial.auditNewLog(hshValues, "276", appno, sbaudittrail.toString(), sbAuditTrialOld.toString());	
//		     ------- End  Of Audit Trail ----------
			
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} 
		
			
		
	}
	
}
			
