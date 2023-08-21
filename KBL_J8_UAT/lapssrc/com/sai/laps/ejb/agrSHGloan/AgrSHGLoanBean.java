package com.sai.laps.ejb.agrSHGloan;

import java.sql.Date;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;


import com.sai.fw.management.utils.FwUtils;
import com.sai.laps.ejb.rules.SelfHelpGroupBO;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.LAlerts;

@Stateless(name = "AgrSHGLoanBean", mappedName = "AgrSHGLoanHome")
@Remote (AgrSHGLoanRemote.class)
public class AgrSHGLoanBean extends BeanAdapter 
{
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(AgrSHGLoanBean.class);	
  /**
   * Method to update shg finance position added on 12-04-2010
   * @param hshValues
   * @
   */
	public void updateSHGFinancePositionDetails(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		String schemename = "";
		ArrayList arrValues=new ArrayList();
		String strAction= correctNull((String)hshValues.get("hidAction"));
		String strAppno= correctNull((String)hshValues.get("strappno"));
		//String schemetype = correctNull((String)hshValues.get("schemetype"));	
		String facno="";
		if(strAppno.equalsIgnoreCase("null") || strAppno.equalsIgnoreCase(""))
		{
			strAppno = correctNull((String)hshValues.get("appno"));
		}
		String schemetype=Helper.getfacilitySchemetype(correctNull((String)hshValues.get("schemetype")));
		facno=Helper.getfacilitySno(correctNull((String)hshValues.get("schemetype")));
		ResultSet rs = null;
		ResultSet rs2 = null;
		try
		{			
			if(strAction.equals("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();	
				hshQueryValues.put("size","1");
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agr_shgfinanceposition_delete"+"^"+schemetype+"^"+facno);
				arrValues.add(strAppno);
				arrValues.add(schemetype);
				arrValues.add(facno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size","1");
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agr_shgfinanceposition_delete"+"^"+schemetype+"^"+facno);
				arrValues.add(strAppno);
				arrValues.add(schemetype);
				arrValues.add(facno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agr_shgfinanceposition_insert");
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hshValues.get("txt_cumulativeSavings")));
				arrValues.add(correctNull((String)hshValues.get("txt_interestCollected")));
				arrValues.add(correctNull((String)hshValues.get("txt_RFA")));
				arrValues.add(correctNull((String)hshValues.get("txt_fines")));
				arrValues.add(correctNull((String)hshValues.get("txt_bankLoan")));
				arrValues.add(correctNull((String)hshValues.get("txt_totalA")));
				arrValues.add(correctNull((String)hshValues.get("txt_outstandingLoans")));
				arrValues.add(correctNull((String)hshValues.get("txt_cashInHand")));
				arrValues.add(correctNull((String)hshValues.get("txt_savingsBal")));
				arrValues.add(correctNull((String)hshValues.get("txt_deposits")));
				arrValues.add(correctNull((String)hshValues.get("txt_otherExpenditure")));
				arrValues.add(correctNull((String)hshValues.get("txt_totalB")));
				arrValues.add(correctNull((String)hshValues.get("txt_difference")));
				arrValues.add(schemetype);
				arrValues.add(facno);
		
				hshQuery.put("arrValues",arrValues);						
				hshQueryValues.put("1",hshQuery);	
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
//				---------------------------------------Audittrial------------------------
			StringBuilder sbAuditTrial=new StringBuilder();
			
					
			sbAuditTrial.append(
			"~Cumulative Savings = ").append(correctNull((String)hshValues.get("txt_cumulativeSavings"))).append(
			"~Interest Collected = ").append(correctNull((String )hshValues.get("txt_interestCollected"))).append(
			"~RFA/Matching grant = ").append(correctNull((String )hshValues.get("txt_RFA"))).append(
			"~Fines & penalties = ").append(correctNull((String )hshValues.get("txt_fines"))).append(
			"~Bank Loan etc = ").append(correctNull((String)hshValues.get("txt_bankLoan"))).append(
			"~Total(A) = ").append(correctNull((String )hshValues.get("txt_totalA"))).append(
			"~Outstanding Loans = ").append(correctNull((String )hshValues.get("txt_outstandingLoans"))).append(
			"~Cash In Hand = ").append(correctNull((String )hshValues.get("txt_cashInHand"))).append(
			"~Savings A/C Balance = ").append(correctNull((String )hshValues.get("txt_savingsBal"))).append(
			"~Deposits = ").append(correctNull((String)hshValues.get("txt_deposits"))).append(
			"~Other Expenditure = ").append(correctNull((String )hshValues.get("txt_otherExpenditure"))).append(
			"~Total (B) = ").append(correctNull((String )hshValues.get("txt_totalB"))).append(
			"~Difference between sources & uses of funds= ").append(correctNull((String )hshValues.get("txt_difference")));
			
			AuditTrial.auditLog(hshValues,"228",strAppno,sbAuditTrial.toString());	
			//-------------------------------------------End---------------------------
		}
		catch(Exception ce)
		{	log.error(ce);
			throw new EJBException(LAlerts.EXCEPTION+"inside update"+ce.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
				if(rs2 != null)
				{
					rs2.close();
				}
			}
			catch(Exception cf)
			{	log.error(cf);
				throw new EJBException(LAlerts.DBEXCEPTION+"Error closing the connection "+cf.getMessage());
			}
		}
	}
	
	public HashMap getSHGFinancePositionDetails(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		HashMap hshSHGFinance	=	null;
		String strAppNo=null,facno=null;
		//String schemename = correctNull((String)hshValues.get("schemetype"));	
		try {
			strAppNo=correctNull((String)hshValues.get("appno"));
			if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
			{
				strAppNo = correctNull((String)hshValues.get("strappno"));
			}if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
			{
				strAppNo = correctNull((String)hshValues.get("strAppno"));
			}
			String schemetype=Helper.getfacilitySchemetype(correctNull((String)hshValues.get("schemetype")));
			facno=Helper.getfacilitySno(correctNull((String)hshValues.get("schemetype")));
			hshSHGFinance=new SelfHelpGroupBO().getSHGFinancePositionByAppno(strAppNo,schemetype,facno);
			hshRecord.put("appno",strAppNo);
			hshRecord.put("hshFinanceDet",hshSHGFinance);

	} catch (Exception e) {
		log.error(e.toString());
		throw new EJBException("Error in getSHGFinancePositionDetails === AgrSHGLoanBean"+e.toString());
	}
	return hshRecord;
  }

	public void updateSHGCorpusDetails(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String schemetype ="",facno="";	
		String appno="";
		if(appno.trim().equalsIgnoreCase("")){
			appno=Helper.correctNull((String)hshValues.get("strappno"));
		}
		if(correctNull(appno).trim().equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("strAppno"));
		}
		if(correctNull(appno).trim().equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}
		try
		{
			schemetype=Helper.getfacilitySchemetype(correctNull((String)hshValues.get("schemetype")));
			facno=Helper.getfacilitySno(correctNull((String)hshValues.get("schemetype")));
			if(strAction.equals("update"))
			{								
			 	arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size","2");	
				hshQuery = new HashMap();					
				hshQuery.put("strQueryId","agrshgcorpusofgroup_delete"+"^"+schemetype+"^"+facno);
				arrValues.add(appno);
				arrValues.add(schemetype);
				arrValues.add(facno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
						
				hshQuery = new HashMap();					
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","agrshgcorpusofgroup_insert");
				arrValues.add(appno);
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_balamt")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_amtlent")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_interest")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_fundgovt")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_total")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_monthlysavg")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_loanoutstdg")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_recoveryperf")));		
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_levelofsavg")));		
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_veloflending")));
				arrValues.add(schemetype);
				arrValues.add(facno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("delete"))
			{
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");					
				hshQuery.put("strQueryId","agrshgcorpusofgroup_delete"+"^"+schemetype+"^"+facno);
				arrValues.add(appno);
				arrValues.add(schemetype);
				arrValues.add(facno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
	
			StringBuilder sbAuditTrial=new StringBuilder();
			sbAuditTrial.append("Balance amount in SB account = ").append(Helper.correctDouble((String )hshValues.get("txt_balamt")))
			.append("~Amount internally lent= ").append(Helper.correctDouble((String )hshValues.get("txt_amtlent")))
			.append("~Interest from members= ").append(Helper.correctDouble((String )hshValues.get("txt_interest")))
			.append("~Grants/ donations/ funds from Govt= ").append(Helper.correctDouble((String )hshValues.get("txt_fundgovt")))
			.append("~Total= ").append(Helper.correctDouble((String )hshValues.get("txt_total")))				
			.append("~Monthly Savings= ").append(Helper.correctDouble((String )hshValues.get("txt_monthlysavg")))
			.append("~Total Loans Outstanding= ").append(Helper.correctDouble((String )hshValues.get("txt_loanoutstdg")))		
			.append("~Recovery Performance within the Group= ").append(Helper.correctDouble((String )hshValues.get("txt_recoveryperf")))
			.append("~Level of Savings= ").append(Helper.correctDouble((String )hshValues.get("txt_levelofsavg")))
			.append("~Velocity of Lending= ").append(Helper.correctDouble((String )hshValues.get("txt_veloflending")));
			AuditTrial.auditLog(hshValues,"218",appno,sbAuditTrial.toString());
		}
		catch(Exception ce)
		{
			log.error("Error in updateSHGCorpusDetails::"+ce.getMessage());
			throw new EJBException(LAlerts.EXCEPTION+"inside updateSHGCorpusDetails"+ce.toString());
		}
		finally
		{
			try
			{
				
			}
			catch(Exception cf)
			{
				log.error("Error in updateSHGCorpusDetails ::"+cf.getMessage());
				throw new EJBException(LAlerts.DBEXCEPTION+"Error closing the connection "+cf.getMessage());
			}
		}
	}
	
	public HashMap getSHGCorpusDetails(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		HashMap hshSHGCorpus	=	null;
		String strAppNo=null;
		String schemetype = "",facno="";	
		Date dateOfFormation=null;
		try 
		{
			strAppNo=Helper.correctNull((String)hshValues.get("appno"));
			if(Helper.correctNull(strAppNo).trim().equalsIgnoreCase(""))
			{
				strAppNo = Helper.correctNull((String)hshValues.get("strappno"));
			}if(Helper.correctNull(strAppNo).trim().equalsIgnoreCase(""))
			{
				strAppNo = Helper.correctNull((String)hshValues.get("strAppno"));
			}
			schemetype=Helper.getfacilitySchemetype(correctNull((String)hshValues.get("schemetype")));
			facno=Helper.getfacilitySno(correctNull((String)hshValues.get("schemetype")));
			hshSHGCorpus=new SelfHelpGroupBO().getSHGCorpusOfGroupByAppno(strAppNo,schemetype,facno);
			hshRecord.put("hshSHGCorpus",hshSHGCorpus);
			//hshRecord.put("totmembers",""+new SelfHelpGroupBO().getSHGGroupMemberCountByAppId(Helper.correctNull((String)hshValues.get("hidapplicantid"))));
			//dateOfFormation= new SelfHelpGroupBO().getDateOfFormationByAppId(Helper.correctNull((String)hshValues.get("hidapplicantid")));
			//if(dateOfFormation!=null)
			//{
			//	hshRecord.put("noofmonths",""+(-1) * Helper.getMonthDifference(dateOfFormation,FwUtils.getSystemDate()));
			//}
			hshRecord.put("appno",strAppNo);
			hshRecord.put("totalcumulative", new SelfHelpGroupBO().getCumulativeSavingsByAppNo(strAppNo,schemetype));
		} catch (Exception e) {
			log.error(e.toString());
			throw new EJBException("Error in getSHGCorpusDetails === AgrSHGLoanBean"+e.toString());
		}
		return hshRecord;
	}
}
