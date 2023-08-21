package com.sai.laps.ejb.pertakeover;
 
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

@Stateless(name = "pertakeoverBean", mappedName = "pertakeoverHome")
@Remote (pertakeoverRemote.class)
public class pertakeoverBean extends BeanAdapter
{			
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(pertakeoverBean.class);	

	private static final long serialVersionUID = 1L;

	public HashMap getData(HashMap hshValues)  
	{		 
		ResultSet rs = null;		 
		HashMap hshResult = new HashMap();
		String strApplicationNo = correctNull((String)hshValues.get("appno"));
		String strPagefrom = correctNull((String)hshValues.get("pagefrom"));
		boolean recordflag=false;
		try 
		{ 
			rs=DBUtils.executeLAPSQuery("takeoversel^"+ strApplicationNo);			 
			while (rs.next()) 
			{
				hshResult.put("appno",correctNull(rs.getString("app_no")));
				hshResult.put("loan_frombank",correctNull(rs.getString("loan_frombank")));
				hshResult.put("loan_fininst",correctNull(rs.getString("loan_fininst")));
				hshResult.put("loanamt_transbank",correctNull(rs.getString("loanamt_transbank")));
			    hshResult.put("installamt_transbank",correctNull(rs.getString("installamt_transbank")));
				hshResult.put("repay_period",correctNull(rs.getString("repay_period")));
				String avail_date=correctNull(rs.getString("avail_date"));
				if(avail_date.equalsIgnoreCase("01/01/1900"))
				{
					avail_date ="";
				}
				else
				{
					hshResult.put("avail_date",correctNull(rs.getString("avail_date")));
				}				
				String fromdate=correctNull(rs.getString("fromdate"));
				if(fromdate.equalsIgnoreCase("01/01/1900"))
				{
					fromdate ="";
				}
				else
				{
					hshResult.put("fromdate",correctNull(rs.getString("fromdate")));
				}
				hshResult.put("tot_liability",correctNull(rs.getString("tot_liability")));
				hshResult.put("no_installpaid",correctNull(rs.getString("no_installpaid")));
				String ason_date=correctNull(rs.getString("ason_date"));
				if(ason_date.equalsIgnoreCase("01/01/1900"))
				{
					ason_date ="";
				}
				else
				{
					hshResult.put("ason_date",correctNull(rs.getString("ason_date")));
				}
				String uptodate=correctNull(rs.getString("uptodate"));
				if(uptodate.equalsIgnoreCase("01/01/1900"))
				{
					uptodate ="";
				}
				else
				{
					hshResult.put("uptodate",correctNull(rs.getString("uptodate")));
				}
				String Overason_date=correctNull(rs.getString("Overason_date"));
				if(Overason_date.equalsIgnoreCase("01/01/1900"))
				{
					Overason_date ="";
				}
				else
				{
					hshResult.put("Overason_date",correctNull(rs.getString("Overason_date")));
				}
				hshResult.put("regular_loan",correctNull(rs.getString("regular_loan")));
				//hshResult.put("overdue_install",correctNull(rs.getString("overdue_install")));
				hshResult.put("overdue_interest",correctNull(rs.getString("overdue_interest")));
				hshResult.put("tot_overdue",correctNull(rs.getString("tot_overdue")));
				hshResult.put("takeover_amtpaid",correctNull(rs.getString("takeover_amtpaid")));
				hshResult.put("sel_transbank",correctNull(rs.getString("sel_transbank")));
				hshResult.put("shifting_reason",correctNull(rs.getString("shifting_reason")));
				hshResult.put("holiday_period",correctNull(rs.getString("holiday_period")));
				hshResult.put("rate_of_interest",correctNull(rs.getString("rate_of_interest")));
				hshResult.put("prev_bank_opinion",correctNull(rs.getString("prev_bank_opinion")));
				hshResult.put("stmt_from_date",correctNull(rs.getString("stmt_from_date")));
				hshResult.put("stmt_to_date",correctNull(rs.getString("stmt_to_date")));
				hshResult.put("stmt_comments",correctNull(rs.getString("stmt_comments")));
				hshResult.put("due_date",correctNull(rs.getString("due_date")));
				hshResult.put("loan_bankid",correctNull(rs.getString("loan_bankid")));
				recordflag=true;
			}	
			  if(recordflag)//for audit trail
				  hshResult.put("recordflag","Y");
			  else
			   	 hshResult.put("recordflag","N");
			// for loan take over tab
				  hshResult.put("strPagefrom",strPagefrom);

		} 
		catch (Exception ce) 
		{
			throw new EJBException("Error in closing getData" + ce.getMessage());
		}
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
				}
			}
			catch (Exception e) 
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshResult;
	}

	public void updateData(HashMap hshValues) 
	{	
		ArrayList arrValues = new ArrayList();
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		String strAppno=correctNull((String)hshValues.get("appno"));
		String strAction="";
		String installamt_transbank="";
		String overdue_install="";
		String overdue_interest="";
		String tot_overdue="";
		String takeover_amtpaid ="";
		String tot_liability ="";
		String loanamt_transbank ="";
		String str_shifting_reason ="";
		String str_holiday_period ="";
		String str_rate_of_interest ="";
		String str_prevbank_opinion ="";
		String str_stmt_dt_from ="";
		String str_stmt_dt_to ="";
		String str_stmt_comments ="";
		String str_due_due ="";
		StringBuilder sbAuditTrial=new StringBuilder();
		try
		{	
			strAction  = Helper.correctNull((String)hshValues.get("hidAction"));
			installamt_transbank = correctNull((String) hshValues.get("installamt_transbank"));
			if (installamt_transbank.equals(""))
			{
				installamt_transbank = "0.00";
			}
			loanamt_transbank = Helper.correctDouble((String) hshValues.get("loanamt_transbank"));
			if (loanamt_transbank .equals(""))
			{
				loanamt_transbank  = "0.00";
			}
			String loan_frombank = Helper.correctDouble((String) hshValues.get("loan_frombank"));
			if (loan_frombank .equals(""))
			{
				loan_frombank = "0.00";
			}
			overdue_install = correctNull((String) hshValues.get("overdue_install"));
			if (overdue_install.equals(""))
			{
				overdue_install = "0.00";
			}
			overdue_interest = correctNull((String) hshValues.get("overdue_interest"));
			if (overdue_interest.equals(""))
			{
				overdue_interest = "0.00";
			}
			tot_overdue = correctNull((String) hshValues.get("tot_overdue"));
			if (tot_overdue.equals(""))
			{
				tot_overdue = "0.00";
			}
			takeover_amtpaid = correctNull((String) hshValues.get("takeover_amtpaid"));
			if (takeover_amtpaid .equals(""))
			{
				takeover_amtpaid  = "0.00";
			}
			tot_liability = correctNull((String) hshValues.get("tot_liability"));
			if (tot_liability  .equals(""))
			{
				tot_liability   = "0.00";
			}
			str_shifting_reason=Helper.correctNull((String)hshValues.get("txt_shifting_reason"));
			str_holiday_period=Helper.correctNull((String)hshValues.get("txt_holiday_period"));
			str_rate_of_interest=Helper.correctNull((String)hshValues.get("txt_rate_of_interest"));
			str_prevbank_opinion=Helper.correctNull((String)hshValues.get("txtar_prev_bank_opinion"));
			str_stmt_dt_from=Helper.correctNull((String)hshValues.get("txt_stmt_dt_from"));
			str_stmt_dt_to=Helper.correctNull((String)hshValues.get("txt_stmt_dt_to"));
			str_stmt_comments=Helper.correctNull((String)hshValues.get("txtar_comments_statement"));
			str_due_due=Helper.correctNull((String)hshValues.get("txt_due_date"));
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","takeoverdel");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
	
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(loan_frombank);
				arrValues.add(correctNull((String) hshValues.get("loan_fininst")));
				arrValues.add(loanamt_transbank);
				arrValues.add(installamt_transbank);
				arrValues.add(correctNull((String) hshValues.get("repay_period")));
				String avail_date=Helper.correctNull((String) hshValues.get("avail_date"));
				if(avail_date.equalsIgnoreCase(""))
				{
					avail_date="01/01/1900";
				}
				arrValues.add(avail_date);
				String fromdate=Helper.correctNull((String) hshValues.get("fromdate"));
				if(fromdate.equalsIgnoreCase(""))
				{
					fromdate="01/01/1900";
				}
				arrValues.add(fromdate);
				arrValues.add(tot_liability );
				arrValues.add(correctNull((String) hshValues.get("no_installpaid")));
				
				String ason_date=Helper.correctNull((String) hshValues.get("ason_date"));
				if(ason_date.equalsIgnoreCase(""))
				{
					ason_date="01/01/1900";
				}
				arrValues.add(ason_date);	
				String uptodate=Helper.correctNull((String) hshValues.get("uptodate"));
				if(uptodate.equalsIgnoreCase(""))
				{
					uptodate="01/01/1900";
				}
				
					
				arrValues.add(uptodate);	
				arrValues.add(Helper.correctNull((String) hshValues.get("regular_loan")));
				arrValues.add(overdue_install);
				arrValues.add(overdue_interest);
				arrValues.add(tot_overdue);
				arrValues.add(takeover_amtpaid );
				arrValues.add(Helper.correctNull((String) hshValues.get("sel_transbank")));
				String Overason_date=Helper.correctNull((String) hshValues.get("Overason_date"));
				if(Overason_date.equalsIgnoreCase(""))
				{
					Overason_date="01/01/1900";
				}
				arrValues.add(Overason_date);
				arrValues.add(str_shifting_reason);
				arrValues.add(str_holiday_period);
				arrValues.add(str_rate_of_interest);
				arrValues.add(str_prevbank_opinion);
				arrValues.add(str_stmt_dt_from);
				arrValues.add(str_stmt_dt_to);
				arrValues.add(str_stmt_comments);
				arrValues.add(str_due_due);
				arrValues.add(correctNull((String) hshValues.get("txt_bankid")));
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "takeoverins");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","takeoverdel");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");  
			}
			/** For the purpose of 'Audit Trial' */
			if (strAction.equalsIgnoreCase("insert")) {
			sbAuditTrial.append("Loan From Bank / Financial Institution=");
			sbAuditTrial.append("~"+Helper.correctNull((String)hshValues.get("loan_fininst")));
			sbAuditTrial.append("~Loan Amount From Transferor Bank/FI=");
			sbAuditTrial.append("~"+Helper.correctNull((String)hshValues.get("loanamt_transbank")));
			sbAuditTrial.append("~Date of Availing Loan /First Disbursal=").
			append(""+Helper.correctNull((String)hshValues.get("avail_date")));
			sbAuditTrial.append("~Instalment Stipulated by Transferor Bank/FI=");
			sbAuditTrial.append("~"+Helper.correctNull((String)hshValues.get("installamt_transbank")));
			if(Helper.correctNull((String)hshValues.get("sel_transbank")).trim().equalsIgnoreCase("1"))
				sbAuditTrial.append("-Monthly");
			else if(Helper.correctNull((String)hshValues.get("sel_transbank")).trim().equalsIgnoreCase("1"))
				sbAuditTrial.append("-Quarterly");
			sbAuditTrial.append("~From Date=").
			append(""+Helper.correctNull((String)hshValues.get("fromdate")));
			sbAuditTrial.append("~Total Repayment Period(Months)=").
			append(""+Helper.correctNull((String)hshValues.get("repay_period")));
			sbAuditTrial.append("~Total Liability=").
			append(""+Helper.correctNull((String)hshValues.get("tot_liability")));
			sbAuditTrial.append("~As On Date=").
			append(""+Helper.correctNull((String)hshValues.get("ason_date")));
			sbAuditTrial.append("~No of Instalments Paid=").
			append(""+Helper.correctNull((String)hshValues.get("no_installpaid")));
			sbAuditTrial.append("~Upto Date=").
			append(""+Helper.correctNull((String)hshValues.get("uptodate")));
			sbAuditTrial.append("~Whether Loan A/c is Regular=");
			if(Helper.correctNull((String)hshValues.get("regular_loan")).trim().equalsIgnoreCase("1"))
				sbAuditTrial.append("Yes");
			else if(Helper.correctNull((String)hshValues.get("regular_loan")).trim().equalsIgnoreCase("2"))
				sbAuditTrial.append("No");
			sbAuditTrial.append("~Overdue Amount(As on Date)=").
			append(""+Helper.correctNull((String)hshValues.get("Overason_date")));
			/*sbAuditTrial.append("~Installments=");
			sbAuditTrial.append("~"+Helper.correctNull((String)hshValues.get("overdue_install")));*/
			sbAuditTrial.append("~Total Overdues=").
			append(""+Helper.correctNull((String)hshValues.get("tot_overdue")));
			sbAuditTrial.append("~Amount to be Paid Transferor Bank/FI For Takeover=").
			append(""+Helper.correctNull((String)hshValues.get("takeover_amtpaid")));
				if(correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
				{
					hshValues.put("hidAction", "update");
				}
			}
			AuditTrial.auditLog(hshValues,"85",strAppno,sbAuditTrial.toString());
			/** End */
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateData "+ce.toString());
		}
		finally
		{	
			try
			{
				//EJBInvoker.executeStateLess("appeditlock",hshValues,"unLockApplication");
			}
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
	}
}