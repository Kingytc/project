package com.sai.laps.ejb.agriapprisal;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.UpdateDairyData;

@Stateless(name = "AgriApprisalBean", mappedName = "AgriApprisalHome")
@Remote (AgriApprisalRemote.class)
public class AgriApprisalBean extends BeanAdapter{
	
	static Logger log=Logger.getLogger(AgriApprisalBean.class);	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;	
	
	public  HashMap getdairyfarmingData(HashMap hshValues) 
	{
 		ResultSet rs1 = null;
 		String strQuery = "";
 		HashMap hshRecord = new HashMap();
 		String hidPageType = correctNull((String)hshValues.get("hidPageType"));
		String appno = correctNull((String)hshValues.get("strappno"));
 		java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
 		nf.setMinimumIntegerDigits(7);
		nf.setGroupingUsed(false);
		try
		{
			if(hidPageType.equalsIgnoreCase("IE"))
			{
				strQuery = SQLParser.getSqlQuery("sel_agr_dairyfarming^" + appno);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					hshRecord.put("firstyearincome", correctNull((String)rs1.getString("firstyearincome")));
					hshRecord.put("secondyearincome", correctNull((String)rs1.getString("secondyearincome")));
					hshRecord.put("thirdyearincome", correctNull((String)rs1.getString("thirdyearincome")));
					hshRecord.put("fourthyearincome", correctNull((String)rs1.getString("fourthyearincome")));
					hshRecord.put("fifthyearincome", correctNull((String)rs1.getString("fifthyearincome")));
					hshRecord.put("sixthyearincome", correctNull((String)rs1.getString("sixthyearincome")));
					hshRecord.put("seventhyearincome", correctNull((String)rs1.getString("seventhyearincome")));
				}
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getdairyfarmingData "+ce.toString());
		}
		finally
		{
			try
			{
		
				if(rs1!=null)
				{
					rs1.close();
				}
			}
			catch(Exception ce)
			{
				throw new EJBException("Error in getdairyfarmingData "+ce.toString());
			}
		}
		return hshRecord;
	}
	
	public void updatedairyfarmingData(HashMap hshRequestValues) 
	{
		String appno=correctNull((String)hshRequestValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno=correctNull((String)hshRequestValues.get("strappno"));
		}
		String hidPageType = correctNull((String)hshRequestValues.get("hidPageType1"));
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
 		ResultSet rs =  null;
 		String strQuery = "";
		int intUpdatesize = 0;
		boolean bstate = false;
		try
		{		
			if(hidPageType.equalsIgnoreCase("IE"))
			{
				strQuery = SQLParser.getSqlQuery("sel_agr_dairyfarming^" + appno);
				rs = DBUtils.executeQuery(strQuery);
				bstate = rs.next();
				if(bstate == true)
				{
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "upd_dairyfarming_IE");
					arrValues.add(correctNull((String)hshRequestValues.get("txt_firstyearincome")));
					arrValues.add(correctNull((String)hshRequestValues.get("txt_secondyearincome")));
					arrValues.add(correctNull((String)hshRequestValues.get("txt_thirdyearincome")));
					arrValues.add(correctNull((String)hshRequestValues.get("txt_fourthyearincome")));
					arrValues.add(correctNull((String)hshRequestValues.get("txt_fifthyearincome")));
					arrValues.add(correctNull((String)hshRequestValues.get("txt_sixthyearincome")));
					arrValues.add(correctNull((String)hshRequestValues.get("txt_seventhyearincome")));
					arrValues.add(appno);
					hshQuery.put("arrValues", arrValues);	
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				else
				{
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_dairyfarming_IE");
					arrValues.add(appno);
					arrValues.add(correctNull((String)hshRequestValues.get("txt_firstyearincome")));
					arrValues.add(correctNull((String)hshRequestValues.get("txt_secondyearincome")));
					arrValues.add(correctNull((String)hshRequestValues.get("txt_thirdyearincome")));
					arrValues.add(correctNull((String)hshRequestValues.get("txt_fourthyearincome")));
					arrValues.add(correctNull((String)hshRequestValues.get("txt_fifthyearincome")));
					arrValues.add(correctNull((String)hshRequestValues.get("txt_sixthyearincome")));
					arrValues.add(correctNull((String)hshRequestValues.get("txt_seventhyearincome")));
					hshQuery.put("arrValues", arrValues);	
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
			}
			else if(hidPageType.equalsIgnoreCase("EC"))
			{
				strQuery = SQLParser.getSqlQuery("sel_agr_dairyfarming^" + appno);
				rs = DBUtils.executeQuery(strQuery);
				bstate = rs.next();
				if(bstate == true)
				{
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "upd_dairyfarming_EC");
					arrValues.add(correctNull((String)hshRequestValues.get("txt_margin")));
					arrValues.add(correctNull((String)hshRequestValues.get("txt_subsidy")));
					arrValues.add(correctNull((String)hshRequestValues.get("txt_interest")));
					arrValues.add(correctNull((String)hshRequestValues.get("txt_EMI")));
					arrValues.add(correctNull((String)hshRequestValues.get("txt_loanamount")));
					arrValues.add(correctNull((String)hshRequestValues.get("txt_leastamount")));
					String subsidyamt = correctNull((String)hshRequestValues.get("txt_subsidyamt"));
					if(subsidyamt.equalsIgnoreCase(""))
					{
						arrValues.add("0");
					}
					else
					{
						arrValues.add(subsidyamt);
					}
					arrValues.add(appno);
					hshQuery.put("arrValues", arrValues);	
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				else
				{
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_dairyfarming_EC");
					arrValues.add(appno);
					arrValues.add(correctNull((String)hshRequestValues.get("txt_margin")));
					arrValues.add(correctNull((String)hshRequestValues.get("txt_subsidy")));
					arrValues.add(correctNull((String)hshRequestValues.get("txt_interest")));
					arrValues.add(correctNull((String)hshRequestValues.get("txt_EMI")));
					arrValues.add(correctNull((String)hshRequestValues.get("txt_loanamount")));
					arrValues.add(correctNull((String)hshRequestValues.get("txt_leastamount")));
					String subsidyamt = correctNull((String)hshRequestValues.get("txt_subsidyamt"));
					if(subsidyamt.equalsIgnoreCase(""))
					{
						arrValues.add("0");
					}
					else
					{
						arrValues.add(subsidyamt);
					}
					hshQuery.put("arrValues", arrValues);	
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
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
	
	public  HashMap getDatadairyfindata(HashMap hshValues) 
	{
 		
		HashMap hshRecord = new HashMap();
		try
		{
			
			UpdateDairyData updateDiaryData = new UpdateDairyData(); 
			
			hshRecord = updateDiaryData.updateDataForDairy(hshValues);
			
		}
		
		catch(Exception cf)
		{
				throw new EJBException("Error closing the connection "+cf.getMessage());
		}
		return hshRecord;
	}

	//capl
	public  HashMap getcapleligdata(HashMap hshValues) 
	{
 		ResultSet rs1 = null;
 		ResultSet rs = null;
 		String strQuery = "";
 		HashMap hshRecord = new HashMap();
 		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		double totmarketval=0.00,totloanamt=0.00;
		String appno = correctNull((String)hshValues.get("strappno"));
 		java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
 		nf.setMinimumIntegerDigits(7);
		nf.setGroupingUsed(false);
		try
		{
			
				strQuery = SQLParser.getSqlQuery("agr_get_capldata^" +appno);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					hshRecord.put("txt_warehouse", Helper.correctDoubleQuote(correctNull(rs1.getString("capl_warehouse"))));
					hshRecord.put("txtgodownno", Helper.correctDoubleQuote(correctNull(rs1.getString("capl_godownno"))));
					hshRecord.put("txr_address", Helper.correctDoubleQuote(correctNull(rs1.getString("capl_address"))));
					hshRecord.put("sel_warehouse", Helper.correctDoubleQuote(correctNull(rs1.getString("capl_selwarehouse"))));
					hshRecord.put("txt_distance", Helper.correctDoubleQuote(correctNull(rs1.getString("capl_distance"))));
					hshRecord.put("txt_accesibilty", Helper.correctDoubleQuote(correctNull(rs1.getString("capl_accesibility"))));
					hshRecord.put("sel_applicant", Helper.correctDoubleQuote(correctNull(rs1.getString("capl_applicant"))));
					hshRecord.put("sel_license", Helper.correctDoubleQuote(correctNull(rs1.getString("capl_license"))));
				}
				 if (rs1 != null)
				    {
					rs1.close();
				    }
						
				strQuery = SQLParser.getSqlQuery("per_get_capldata^" + appno);
				rs = DBUtils.executeQuery(strQuery);
				String capl_invoicedate="";
			     
				while (rs.next())
				{
					arryCol = new ArrayList();
					arryCol.add(rs.getString("seqno"));
					arryCol.add(appno);
					arryCol.add(rs.getString("sno"));
					arryCol.add(rs.getString("capl_type"));
					arryCol.add(rs.getString("capl_namewarehouse"));
					arryCol.add(rs.getString("capl_warehousedoc"));
					arryCol.add(rs.getString("capl_units"));
					arryCol.add(rs.getString("capl_weight"));
					arryCol.add(rs.getString("capl_marketrate"));
					arryCol.add(rs.getString("capl_marketvalue"));
					totmarketval =  totmarketval + Double.parseDouble((Helper.correctDouble((String)rs.getString("capl_marketvalue"))));
					
					arryCol.add(rs.getString("capl_invoicevalue"));
					capl_invoicedate=correctNull((String)rs.getString("capl_invoicedate"));
					if(capl_invoicedate.equalsIgnoreCase("01/01/1900"))
					{
						arryCol.add("");
					}
					else
					{
						arryCol.add(capl_invoicedate);
					}
					arryCol.add(rs.getString("capl_loanamt"));
					totloanamt =  totloanamt + Double.parseDouble((Helper.correctDouble((String)rs.getString("capl_loanamt"))));
					
					arryRow.add(arryCol);
				}
				hshRecord.put("arryRow", arryRow);
				hshRecord.put("totloanamt", Helper.formatDoubleValue(totloanamt));
				hshRecord.put("totmarketval",Helper.formatDoubleValue(totmarketval));
				
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getdairyfarmingData "+ce.toString());
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
		return hshRecord;
	}
	
	public  HashMap getagrigloddata(HashMap hshValues) 
	{
 		ResultSet rs = null;
 		HashMap hshRecord = new HashMap();
 		
		String appno ="";
		String strQuery=null;
		
		double dblmargin =0.0;
		double dblApprisalvalue=0.0;
		double dblBankvalue=0.00;
		double dblLoanamtreq=0.00;
 		
		try
		{
			appno = correctNull((String)hshValues.get("appno"));
			if(appno.equals(""))
			{
				appno = correctNull((String)hshValues.get("strappno"));
			}
			
			if(!appno.equals(""))
			{
				
				strQuery=SQLParser.getSqlQuery("selgolddetailstotal^" + appno);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					dblApprisalvalue=rs.getDouble("estimatevalue");
					hshRecord.put("apprisalvalue",Helper.formatDoubleValue(rs.getDouble("estimatevalue")));
					
					dblBankvalue=rs.getDouble("bankvalue");
					hshRecord.put("bankvalue",Helper.formatDoubleValue(rs.getDouble("bankvalue")));
				}
				
				if(rs!=null)rs.close();
				strQuery=null;
				strQuery=SQLParser.getSqlQuery("selgolddetailsreqamt^" + appno);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					dblLoanamtreq=rs.getDouble("loan_amtreqd");
					dblmargin=rs.getDouble("loan_margin");
					hshRecord.put("loan_amtreqd",Helper.formatDoubleValue(rs.getDouble("loan_amtreqd")));
				}
				
				double marginamt=(dblApprisalvalue*dblmargin)/100;
				hshRecord.put("marginamt",Helper.formatDoubleValue(marginamt));
				
				double eligiblemargin=dblApprisalvalue-marginamt;
				hshRecord.put("eligiblemargin",Helper.formatDoubleValue(eligiblemargin));
				
				if(eligiblemargin<dblBankvalue && eligiblemargin<dblLoanamtreq)
				{
						hshRecord.put("eligible",Helper.formatDoubleValue(eligiblemargin));
				}
				else if(dblBankvalue<dblLoanamtreq)
				{
					hshRecord.put("eligible",Helper.formatDoubleValue(dblBankvalue));
				}
				else
				{
					hshRecord.put("eligible",Helper.formatDoubleValue(dblLoanamtreq));
				}
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getdairyfarmingData "+ce.toString());
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

	
	
	public  HashMap getagrifddata(HashMap hshValues) 
	{
 		ResultSet rs = null;
 		HashMap hshRecord = new HashMap();
 		String appno = correctNull((String)hshValues.get("appno"));
 		String strQuery="";
		double dblloanamtreq=0.0;
 		
		try
		{
			strQuery=SQLParser.getSqlQuery("selgolddetailsreqamt^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				dblloanamtreq=rs.getDouble("loan_amtreqd");
				hshRecord.put("loan_amtreqd",correctNull((String)rs.getString("loan_amtreqd")));
			}
			
			double tempOustanding=0.00, totalOutstanding=0.00, tempMargin=0.00,totalMargin=0.00,elgibityMarginAmount=0.00;
			strQuery=SQLParser.getSqlQuery("sel_loanagainstdeposit^"+appno);
			rs=DBUtils.executeQuery(strQuery);		
			while(rs.next())
			{
				tempOustanding = rs.getDouble("loan_presentos");
				totalOutstanding = totalOutstanding + tempOustanding;
				tempMargin = tempOustanding * rs.getDouble("loan_margin");
				tempMargin = tempMargin / 100;
				totalMargin = totalMargin + tempMargin;
			}
			elgibityMarginAmount = totalOutstanding - totalMargin;
			hshRecord.put("apprisalvalue",Helper.formatDoubleValue(totalOutstanding));
			hshRecord.put("marginamt",Helper.formatDoubleValue(totalMargin));
			hshRecord.put("eligiblemargin",Helper.formatDoubleValue(elgibityMarginAmount));
			
			if(dblloanamtreq<elgibityMarginAmount)
			{
				hshRecord.put("eligible",Helper.formatDoubleValue(dblloanamtreq));
			}
			else
			{
				hshRecord.put("eligible",Helper.formatDoubleValue(elgibityMarginAmount));
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getagrifddata ::  "+ce.toString());
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
				throw new EJBException("Error closing the connection in getagrifddata :: "+cf.getMessage());
			}
		}
		return hshRecord;
	}

	
	public HashMap checkagrieligibility(HashMap hshValues)
	{
		HashMap hshRecord =null;
		
		String strAppno=null;
		String strQuery=null;
		String strProdtype=null;
		
		ResultSet rs=null;
		
		double dblSanctionamt=0.0;
		double dblprodeligibleamt=0.0;
		double dblRequestedAmount=0.0;
		double dblmarginrate=0.0;
		
		ArrayList arrValues=null;
		try{
			
			strAppno=correctNull((String)hshValues.get("appno"));
			strProdtype=correctNull((String)hshValues.get("strProdcut"));
			dblSanctionamt=Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_sanction_amount")));
			
			arrValues=new ArrayList();
			
			if(rs !=null)
			{
				rs.close();
			}
			String strProdPurpose="";
			strQuery = SQLParser.getSqlQuery("selprodpurpose^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()){strProdPurpose=Helper.correctNull((String)rs.getString("prd_purpose"));}
			/*
			 * 			For Purchase of Ready Built House and Used Vehicle loan, 
			 * 				Margin is based on age of the building / vehicle respectively
			 */
			if(strProdPurpose.equalsIgnoreCase("H") || strProdPurpose.equalsIgnoreCase("U")) 
			{
				strQuery = SQLParser.getSqlQuery("pergetloanProductbymargin^" + strAppno);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("pergetloanProduct^" + strAppno);
			}
			if(rs !=null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);

			if (rs.next())
			{
				dblRequestedAmount = rs.getDouble("amtreqd");
				dblmarginrate= rs.getDouble("loan_margin");
				strProdtype = correctNull(rs.getString("prd_type")).toUpperCase();
			}
			
			if(dblRequestedAmount<dblSanctionamt)
			{
				arrValues.add("Sanction Amount should not be greater than Requested amount");
			}
			
			
			if(strProdtype.equalsIgnoreCase("aR"))
			{
				/****
				 *  For Loan Against Deposits the eligibility is done based on the receipt data
				 ****/
				if(rs!=null)
					rs.close();
				strQuery=SQLParser.getSqlQuery("sel_loanagainstdeposit^" + strAppno);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					double dblreceiptos=0.0;
					double dblmarginperct=0.0;
					double dblmarginamt=0.0;
					dblreceiptos=rs.getDouble("loan_presentos");
					dblmarginperct=rs.getDouble("loan_margin");
					dblmarginamt=dblreceiptos*dblmarginperct/100.0;
					dblprodeligibleamt=dblprodeligibleamt+ (dblreceiptos-dblmarginamt);
				}
			}
			else if(strProdtype.equalsIgnoreCase("aH"))
			{
				/****
				 *  For Gold Loan the eligibility is done based on the Gold Ornaments
				 ****/
				if(rs!=null)
					rs.close();
				
				double dblapprvalue=0.0;
				double dblbankvalue=0.0;
				double dblmargineligibleamt=0.0;
				
				strQuery=SQLParser.getSqlQuery("selgolddetailstotal^" + strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					dblbankvalue=rs.getDouble("bankvalue");
					dblapprvalue=rs.getDouble("estimatevalue");
					dblmargineligibleamt=dblapprvalue-(dblapprvalue*dblmarginrate/100);
					
					dblprodeligibleamt=dblmargineligibleamt<dblbankvalue?dblmargineligibleamt:dblbankvalue;
				}
				
			}
			
			if(dblprodeligibleamt<dblSanctionamt)
			{
				arrValues.add("Eligibility Based on Product is "+dblprodeligibleamt);
			}
			hshRecord=new HashMap();
			if(arrValues.size()>0)
			{
				hshRecord.put("Status","Failed");
			}
			else
			{
				hshRecord.put("Status","SUCCESS");
			}
			hshRecord.put("Message",arrValues);
			
		}
		catch(Exception ex)
		{
			throw new EJBException ("Error in checkagrieligibility  ::  "+ex.toString());
		}
		finally{
			
		}
		return hshRecord;
	}
}