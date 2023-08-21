package com.sai.laps.ejb.agrpoultry;

import java.rmi.RemoteException;

import java.sql.ResultSet;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;
import com.sai.laps.helper.DBUtils;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.AuditTrial;

@Stateless(name = "agrpoultryBean", mappedName = "agrpoultryHome")
@Remote (agrpoultryRemote.class)
public class agrpoultryBean extends BeanAdapter 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(agrpoultryBean.class);	


	public void updatenonrecurringData(HashMap hshValues) 
	{
		String appno=correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") ||  appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}
		//String appno1=correctNull((String)hshValues.get("appno1"));
		String strappno=correctNull((String)hshValues.get("strappno"));
		String strAction=null;//String strAction1=null;
		strAction = correctNull((String) hshValues.get("hidAction"));
		//strAction1 = correctNull((String) hshValues.get("hidAction1"));
		HashMap hshQueryValues = new HashMap();
		HashMap hshQueryValues1 = new HashMap();
		ArrayList arrValues3 = new ArrayList();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();	
		HashMap hshQuery3 = new HashMap();
		String[] txt_sq= null;
		String[] txt_value = null;
		String[] txt_loanamount = null;
		String[] txt_specify= null;
		String txt_marginper=null;
		String[] txt_item1= null;
		String[] txt_cost = null;
		String[] txt_unit = null;
		String[] txt_loanamount1 = null;
		String txt_totalamount=null;
		String txt_totalmargin=null;
		String txt_totalloanamount=null;
		String[] txt_amount = null;
		String[] txt_amount1 = null;
		/*if(appno.equalsIgnoreCase(""))
		{
			appno=appno1;
		}*/
		if(appno.equalsIgnoreCase(""))
		{
			appno=strappno;
		}		
		ResultSet rs = null;
		int intUpdatesize = 0;	int intUpdatesize1 = 0;
		try
		{		
			txt_sq = (String[]) hshValues.get("txt_sq");
			txt_value = (String[])hshValues.get("txt_value");
			txt_specify= (String[])hshValues.get("txt_specify");
			txt_loanamount = (String[])hshValues.get("txt_loanamount");
			txt_marginper = correctNull((String)hshValues.get("txt_marginper"));
			txt_item1 = (String[]) hshValues.get("txt_item1");
			txt_unit = (String[])hshValues.get("txt_unit");
			txt_cost= (String[])hshValues.get("txt_cost");
			txt_loanamount1 = (String[])hshValues.get("txt_loanamount1");
			txt_totalamount= correctNull((String)hshValues.get("txt_totalamount"));
			txt_totalmargin= correctNull((String)hshValues.get("txt_totalmargin"));
			txt_totalloanamount= correctNull((String)hshValues.get("txt_totalloanamount"));
			txt_amount = (String[])hshValues.get("txt_amount");
			txt_amount1 = (String[])hshValues.get("txt_amount1");
			
			if (strAction.equals("delete"))
			{
				 hshQuery3 = new HashMap();
				 hshQueryValues1 = new HashMap();
				 arrValues3 = new ArrayList();
				hshQuery3.put("strQueryId", "del_poultry_nonrecurring");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				hshQueryValues1.put("1", hshQuery3);
				hshQueryValues1.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			}
			if (strAction.equals("delete"))
			{
				 hshQuery3 = new HashMap();
				 hshQueryValues1 = new HashMap();
				 arrValues3 = new ArrayList();
				hshQuery3.put("strQueryId", "del_poultry_non_recurring");
				arrValues3.add(appno);
				arrValues3.add(prd_type);
				hshQuery3.put("arrValues", arrValues3);
				hshQueryValues1.put("1", hshQuery3);
				hshQueryValues1.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			}
			if (strAction.equals("insert"))
			{
			
				hshQuery3 = new HashMap();
				arrValues3 = new ArrayList();
				hshQuery3.put("size", "1");
				hshQuery3.put("strQueryId", "del_poultry_nonrecurring");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				hshQueryValues1.put("1", hshQuery3);
				hshQueryValues1.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
				intUpdatesize = 1;
				for (int j = 0; j < 1; j++)
				{
					intUpdatesize1 = intUpdatesize1 + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_poultry_nonrecurring");
					arrValues.add(appno);
					arrValues.add("0");
					arrValues.add("0");
					arrValues.add("");
					arrValues.add("0");
	
					if(txt_marginper.equalsIgnoreCase(""))
					{
						txt_marginper = "";
					}
					arrValues.add(txt_marginper);
					if(txt_totalamount.equalsIgnoreCase(""))
					{
						txt_totalamount= "";
					}
					arrValues.add(txt_totalamount);
					if(txt_totalmargin.equalsIgnoreCase(""))
					{
						txt_totalmargin = "";
					}
					arrValues.add(txt_totalmargin);
					if(txt_totalloanamount.equalsIgnoreCase(""))
					{
						txt_totalloanamount= "";
					}
					arrValues.add(txt_totalloanamount);
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
			
				   intUpdatesize = 1;
					for (int i =0; i <=2; i++)
					{
						intUpdatesize = intUpdatesize + 1;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_poultry_nonrecurring");
						arrValues.add(appno);
						if(txt_sq[i].equalsIgnoreCase(""))
						{
							txt_sq[i] = "0";
						}
						arrValues.add(txt_sq[i]);
						if(txt_value[i].equalsIgnoreCase(""))
						{
							txt_value[i] = "0";
						}
						arrValues.add(txt_value[i]);
						arrValues.add("");
						if(txt_loanamount[i].equalsIgnoreCase(""))
						{
							txt_loanamount[i] = "0";
						}
						arrValues.add(txt_loanamount[i]);
						arrValues.add("0");
						arrValues.add("0");
						arrValues.add("0");
						arrValues.add("0");
					   hshQuery.put("arrValues", arrValues);	
						hshQueryValues.put("1", hshQuery);
						hshQueryValues.put("size", "1");
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					}
			
					intUpdatesize = 1;
					for (int i =3; i <=8; i++)
					{
						intUpdatesize = intUpdatesize + 1;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_poultry_nonrecurring");
						arrValues.add(appno);
						if(txt_sq[i].equalsIgnoreCase(""))
						{
							txt_sq[i] = "0";
						}
						arrValues.add(txt_sq[i]);
						if(txt_value[i].equalsIgnoreCase(""))
						{
							txt_value[i] = "0";
						}
						arrValues.add(txt_value[i]);
						if(txt_specify[i].equalsIgnoreCase(""))
						{
							txt_specify[i] = "";
						}
						arrValues.add(txt_specify[i]);
						if(txt_loanamount[i].equalsIgnoreCase(""))
						{
							txt_loanamount[i] = "0";
						}
						arrValues.add(txt_loanamount[i]);
						arrValues.add("0");
						arrValues.add("0");
						arrValues.add("0");
						arrValues.add("0");
					   hshQuery.put("arrValues", arrValues);	
						hshQueryValues.put("1", hshQuery);
						hshQueryValues.put("size", "1");
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					}
			
			}
			if (strAction.equals("insert"))
			{
			
				 hshQuery3 = new HashMap();
				 arrValues3 = new ArrayList();
				 hshQuery3.put("size", "1");
				 hshQuery3.put("strQueryId", "del_poultry_non_recurring");
				 arrValues3.add(appno);
				 arrValues3.add(prd_type);
				 hshQuery3.put("arrValues", arrValues3);
				 hshQueryValues1.put("1", hshQuery3);
				 hshQueryValues1.put("size", "1");
				 EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
				 intUpdatesize = 1;
				for (int i =0; i <=6; i++)
				{
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_poultry_non_recurring");
					arrValues.add(appno);
					arrValues.add(Integer.toString(i+1));
					if(txt_item1[i].equalsIgnoreCase(""))
					{
						txt_item1[i] = "";
					}
					arrValues.add(txt_item1[i]);
					if(txt_unit[i].equalsIgnoreCase(""))
					{
						txt_unit[i] = "0";
					}
					arrValues.add(txt_unit[i]);
					if(txt_cost[i].equalsIgnoreCase(""))
					{
						txt_cost[i] = "0";
					}
					arrValues.add(txt_cost[i]);
					if(txt_loanamount1[i].equalsIgnoreCase(""))
					{
						txt_loanamount1[i] = "0";
					}
					arrValues.add(txt_loanamount1[i]);
					arrValues.add("N");
					arrValues.add(prd_type);
				    hshQuery.put("arrValues", arrValues);	
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
		
			}
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{
			String strdesc[]={"~ sq ft Brooder Shed@Rs. = ","~ sq ft Grower Shed@Rs. = ","~ sq ft Layer Shed@Rs. = "};
			sbAuditTrial.append("~Particulars ^")
			.append("<br>");
			
				for (int i =0; i <=2; i++)
				{
					sbAuditTrial
					.append("~Construction of = ").append(txt_sq[i])
					.append(strdesc[i])
					.append(txt_value[i]).append("~per sq ft = ")
					.append(txt_amount[i]);
				}
			
			sbAuditTrial
			.append("<br>")
			.append("~Other Civil Works ^")
			.append("<br>");
			for (int i =3; i <=8; i++)
			{
				sbAuditTrial
				.append("~Construction of = ")
				.append(txt_specify[i])
				.append("~building measuring = ")
				.append(txt_sq[i])
				.append("~sq ft @ Rs. = ")
				.append(txt_value[i])
				.append("~per sq ft = ")
				.append(txt_amount[i]);
			}
			sbAuditTrial
			.append("<br>")
			.append("~Purchase of Equipments ^")
			.append("<br>");
			for (int i =0; i <=6; i++)
			{
				
				sbAuditTrial
				.append("~Name of equipments with specifications = ")
				.append(txt_item1[i])
				.append("~No of units = ")
				.append(txt_unit[i])
				.append("~Cost per unit = ")
				.append(txt_cost[i])
				.append("~Amount(Rs.) = ")
				.append(txt_amount1[i]);
			}
			if(correctNull((String)hshValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
			{
				hshValues.put("strAction", "update");
			}
			else
			{
				hshValues.put("strAction", "insert");
			}
			}
			AuditTrial.auditLog(hshValues,"246",appno,sbAuditTrial.toString());
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
	
	public  HashMap getnonrecurringData(HashMap hshValues) 
	{
 		ResultSet rs = null;
 		ResultSet rs1 = null;ResultSet rs2 = null;
 		String strQuery = "";
 		HashMap hshRecord = new HashMap();
 		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		ArrayList arryRow1 = new ArrayList();
		ArrayList arryCol1 = null;
 		String appno = correctNull((String) hshValues.get("appno"));
 		if(appno.equalsIgnoreCase("null") ||  appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
 		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}
        String PageType=Helper.correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
         {
      	 PageType=Helper.correctNull((String)hshValues.get("hidpagetype"));
         }
 		try 
		{
			/*strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}*/
										 
			strQuery = SQLParser.getSqlQuery("sel_poultry_nonrecurring^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(appno);
				arryCol.add(rs.getString("poultry_sq"));
				arryCol.add(rs.getString("poultry_amount"));
				arryCol.add(rs.getString("poultry_specify"));
				arryCol.add(rs.getString("poultry_loanamount"));
				arryCol.add(rs.getString("poultry_margin"));
				arryCol.add(rs.getString("poultry_totalamount"));
				arryCol.add(rs.getString("poultry_totalmargin"));
				arryCol.add(rs.getString("poultry_totalloanamount"));
				
				arryRow.add(arryCol);
				hshRecord.put("auditFlag", "Y");
			}
			strQuery = SQLParser.getSqlQuery("sel_poultry_non_recurring^" + appno+"^"+prd_type);
			rs = DBUtils.executeQuery(strQuery);
			double amount1=0.00;double amount2=0.00;double amount3=0.00;
			double amount4=0.00;double amount5=0.00;
			while (rs.next())
			{
				arryCol1 = new ArrayList();
				arryCol1.add(appno);
				arryCol1.add(rs.getString("poultry_item"));
				arryCol1.add(rs.getString("poultry_unit"));
				arryCol1.add(rs.getString("poultry_cost"));
				amount1 = Double.parseDouble((Helper.correctDouble((String)rs.getString("poultry_unit"))));
				amount2 = Double.parseDouble((Helper.correctDouble((String)rs.getString("poultry_cost"))));
				amount3=Math.round(amount1*amount2);
				arryCol1.add(rs.getString("poultry_loan_amount"));
				amount4= Double.parseDouble((Helper.correctDouble((String)rs.getString("poultry_loan_amount"))));
				amount5=Math.round(amount3-amount4);
				arryCol1.add(Helper.formatDoubleValue(amount3));
				arryCol1.add(Helper.formatDoubleValue(amount5));
				arryRow1.add(arryCol1);
				hshRecord.put("auditFlag", "Y");
			}
			strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
			rs1= DBUtils.executeQuery(strQuery);
			if(rs1.next())
					{
			hshRecord.put("land_measurement",Helper.correctNull(rs1.getString("land_measurement")));
					}
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("arryRow1", arryRow1);
			hshRecord.put("PageType", PageType);
			
		} 
		catch(Exception ce)
		{
			throw new EJBException("Error in getcoopsocMasterList "+ce.toString());
		}
		finally 
		{
			try
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
				if (rs1 != null) 
				{
					rs1.close();
					rs1 = null;
				}
				if (rs2 != null) 
				{
					rs2.close();
				}
				
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}
	//recurring
	public void updaterecurringData(HashMap hshValues) 
	{
		String appno=correctNull((String)hshValues.get("appno"));
		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}
		if(appno.equalsIgnoreCase("null") ||  appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
		//String appno1=correctNull((String)hshValues.get("appno1"));
		String strappno=correctNull((String)hshValues.get("strappno"));
		String strAction=null;//String strAction1=null;String strAction2=null;
		strAction = correctNull((String) hshValues.get("hidAction"));
		//strAction1 = correctNull((String) hshValues.get("hidAction1"));
		//strAction2 = correctNull((String) hshValues.get("hidAction2"));
		String strAction3 = correctNull((String) hshValues.get("hidAction3"));
		HashMap hshQueryValues = new HashMap();
		HashMap hshQueryValues1 = new HashMap();
		ArrayList arrValues3 = new ArrayList();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();	
		HashMap hshQuery3 = new HashMap();
		String[] txt_nochicks= null;
		String[] txt_noofbatches = null;
		String txt_totalamount=null;
		String txt_totalmargin=null;
		String txt_totalloanamount=null;
		String[] txt_value= null;
		String[] txt_value1= null;
		String txt_mortality1=null;
		String txt_mortality2=null;
		String[] txt_charges= null;
		String[] txt_value2= null;
		String[] txt_month= null;
		String[] txt_amount = null;
		String[] txt_item1= null;
		String[] txt_amount1 = null;
		String[] txt_month1 = null;
		String[] txt_loanamount1 = null;
		String[] txt_margin= null;String[] txt_loanamount= null;
		//String[] txt_margin1= null;
		String[] txt_cost1=null;
		String[] strDesc_1={"~Labourers salary/wages  = ","~Manager salary/wages  = ","~Supervisors salary/wages  = ","~others ie. "+Helper.correctNull((String)hshValues.get("txt_specify1"))+" salary/wages  = ","~others ie "+Helper.correctNull((String)hshValues.get("txt_specify2"))+" salary/wages  = ","~Water charge:Rs.  = ","~Electricity charges Rs.  = ","~Veterinary aid Rs.  =  ","~Insurance of birds @ Rs.  =  ","~Transportation charges @ Rs.  =  "};
		String[] strDesc_2={"~no.of labourers @Rs.  =  ","~no.of Managers @Rs.  =  ","~no.of Supervisors @Rs  = ","~no.of persons @Rs.  = ","~no.of persons @Rs.  = ","~per month for   = ","~per month for   = ","~per batch for  = ","~per batch for   = ","~per batch for   = " };
		String[] strDesc_3={"~per labourer p.m for  =  ","~per Manager p.m for   = ","~per Supervisor p.m for   = ","~per person p.m for   = ","~per person p.m for  = ","~months ^","~months  ^","~number of batches ^","~number of batches ^","~number of batches ^" };
		/*if(appno.equalsIgnoreCase(""))
		{
			appno=appno1;
		}*/
		if(appno.equalsIgnoreCase(""))
		{
			appno=strappno;
		}		
		ResultSet rs = null;
		int intUpdatesize = 0;	int intUpdatesize1 = 0;
		try
		{		
			 txt_nochicks = (String[]) hshValues.get("txt_nochicks");
			 txt_noofbatches= (String[])hshValues.get("txt_noofbatches");
			 txt_value= (String[])hshValues.get("txt_value");
			 txt_value1= (String[])hshValues.get("txt_value1");
			 txt_mortality1= correctNull((String)hshValues.get("txt_mortality1"));
			 txt_mortality2=correctNull((String)hshValues.get("txt_mortality2"));
			 txt_charges=(String[]) hshValues.get("txt_charges");
			 txt_value2=(String[])hshValues.get("txt_value2");
			 txt_month=(String[])hshValues.get("txt_month");
			 txt_item1 = (String[]) hshValues.get("txt_item1");
			 txt_amount1 = (String[])hshValues.get("txt_amount1");
			 txt_loanamount1 = (String[])hshValues.get("txt_loanamount1");
			 txt_amount = (String[])hshValues.get("txt_amount");
			 txt_margin = (String[])hshValues.get("txt_margin");
			 txt_loanamount = (String[])hshValues.get("txt_loanamount");
			 //txt_margin1 = (String[])hshValues.get("txt_margin1");
			 txt_month1 = (String[])hshValues.get("txt_month1");
			 txt_totalamount= correctNull((String)hshValues.get("txt_totalamount"));
			 txt_totalmargin= correctNull((String)hshValues.get("txt_totalmargin"));
			 txt_totalloanamount= correctNull((String)hshValues.get("txt_totalloanamount"));
			 txt_cost1= (String[])hshValues.get("txt_cost1");
			if (strAction.equals("delete"))
			{
				 hshQuery3 = new HashMap();
				 hshQueryValues1 = new HashMap();
				 arrValues3 = new ArrayList();
				hshQuery3.put("strQueryId", "del_poultry_recurringdata");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				hshQueryValues1.put("1", hshQuery3);
				hshQueryValues1.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			}
			if (strAction.equals("delete"))
			{
				 hshQuery3 = new HashMap();
				 arrValues3 = new ArrayList();
				hshQuery3.put("strQueryId", "del_poultry_recurring");
				arrValues3.add(appno);
				arrValues3.add(prd_type);
				hshQuery3.put("arrValues", arrValues3);
				hshQueryValues1.put("1", hshQuery3);
				hshQueryValues1.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			}
			if(strAction.equals("delete"))
			{
				arrValues= new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","agr_del_poultry_labcharge");
				arrValues.add(appno);
				arrValues.add(prd_type);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			if (strAction.equals("insert"))
			{
			
			 hshQuery3 = new HashMap();
			 arrValues3 = new ArrayList();
			hshQuery3.put("size", "1");
			hshQuery3.put("strQueryId", "del_poultry_recurringdata");
			arrValues3.add(appno);
			hshQuery3.put("arrValues", arrValues3);
			hshQueryValues1.put("1", hshQuery3);
			hshQueryValues1.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			intUpdatesize = 1;
			for (int j = 0; j < 1; j++)
			{
				intUpdatesize1 = intUpdatesize1 + 1;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_poultry_recurringdata");
				arrValues.add(appno);
				arrValues.add(Integer.toString(j+1));
				arrValues.add("0");
				arrValues.add("0");
				arrValues.add("0");
				arrValues.add("0");

				if(txt_mortality1.equalsIgnoreCase(""))
				{
					txt_mortality1= "";
				}
				arrValues.add(txt_mortality1);
				if(txt_mortality2.equalsIgnoreCase(""))
				{
					txt_mortality2= "";
				}
				arrValues.add(txt_mortality2);
				arrValues.add("0");
				arrValues.add("0");
				arrValues.add("0");
				arrValues.add("0");
				if(txt_totalamount.equalsIgnoreCase(""))
				{
					txt_totalamount= "";
				}
				arrValues.add(txt_totalamount);
				if(txt_totalmargin.equalsIgnoreCase(""))
				{
					txt_totalmargin = "";
				}
				arrValues.add(txt_totalmargin);
				if(txt_totalloanamount.equalsIgnoreCase(""))
				{
					txt_totalloanamount= "";
				}
				arrValues.add(txt_totalloanamount);
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			intUpdatesize = 2;
			for (int i =0; i <=2; i++)
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_poultry_recurringdata");
				arrValues.add(appno);
				arrValues.add(Integer.toString(i+intUpdatesize));
				if(txt_nochicks[i].equalsIgnoreCase(""))
				{
					txt_nochicks[i] = "0";
				}
				arrValues.add(txt_nochicks[i]);
				if(txt_noofbatches[i].equalsIgnoreCase(""))
				{
					txt_noofbatches[i] = "0";
				}
				arrValues.add(txt_noofbatches[i]);
				if(txt_value[i].equalsIgnoreCase(""))
				{
					txt_value[i] = "0";
				}
				arrValues.add(txt_value[i]);
				if(txt_value1[i].equalsIgnoreCase(""))
				{
					txt_value1[i] = "0";
				}
				arrValues.add(txt_value1[i]);
				arrValues.add("0");
				arrValues.add("0");
				arrValues.add("0");
				arrValues.add("0");
				arrValues.add("0");
				if(txt_amount[i].equalsIgnoreCase(""))
				{
					txt_amount[i] = "0";
				}
				arrValues.add(txt_amount[i]);
				arrValues.add("0");
				//arrValues.add("0");
				//arrValues.add("0");
				if(txt_margin[i].equalsIgnoreCase(""))
				{
					txt_margin[i] = "0";
				}
				arrValues.add(txt_margin[i]);
				if(txt_loanamount[i].equalsIgnoreCase(""))
				{
					txt_loanamount[i] = "0";
				}
				arrValues.add(txt_loanamount[i]);
			    hshQuery.put("arrValues", arrValues);	
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			intUpdatesize = 2;
			for (int i =3; i <=12; i++)
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_poultry_recurringdata");
				arrValues.add(appno);
				arrValues.add(Integer.toString(i+intUpdatesize));
				arrValues.add("0");
				arrValues.add("0");
				arrValues.add("0");
				arrValues.add("0");
				arrValues.add("0");
				arrValues.add("0");
				if(txt_charges[i-3].equalsIgnoreCase(""))
				{
					txt_charges[i-3] = "0";
				}
				arrValues.add(txt_charges[i-3]);
				if(txt_value2[i-3].equalsIgnoreCase(""))
				{
					txt_value2[i-3] = "0";
				}
				arrValues.add(txt_value2[i-3]);
				if(txt_month[i-3].equalsIgnoreCase(""))
				{
					txt_month[i-3] = "0";
				}
				arrValues.add(txt_month[i-3]);
				if(txt_amount[i].equalsIgnoreCase(""))
				{
					txt_amount[i] = "0";
				}
				arrValues.add(txt_amount[i]);
				arrValues.add("0");
				if(txt_margin[i].equalsIgnoreCase(""))
				{
					txt_margin[i] = "0";
				}
				arrValues.add(txt_margin[i]);
				if(txt_loanamount[i].equalsIgnoreCase(""))
				{
					txt_loanamount[i] = "0";
				}
				arrValues.add(txt_loanamount[i]);
				
			   hshQuery.put("arrValues", arrValues);	
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			}
			if (strAction.equals("insert"))
			{
			
			 hshQuery3 = new HashMap();
			 arrValues3 = new ArrayList();
			hshQuery3.put("size", "1");
			hshQuery3.put("strQueryId", "del_poultry_recurring");
			arrValues3.add(appno);
			arrValues3.add(prd_type);
			hshQuery3.put("arrValues", arrValues3);
			hshQueryValues1.put("1", hshQuery3);
			hshQueryValues1.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			intUpdatesize = 1;
			for (int i =0; i <=4; i++)
			{
				intUpdatesize = intUpdatesize + 1;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_poultry_recurring");
				arrValues.add(appno);
				arrValues.add(Integer.toString(i+1));
				if(txt_item1[i].equalsIgnoreCase(""))
				{
					txt_item1[i] = "";
				}
				arrValues.add(txt_item1[i]);
				if(txt_amount1[i].equalsIgnoreCase(""))
				{
					txt_amount1[i] = "0";
				}
				arrValues.add(txt_amount1[i]);
				//arrValues.add("0");
				if(txt_month1[i].equalsIgnoreCase(""))
				{
					txt_month1[i] = "0";
				}
				arrValues.add(txt_month1[i]);
				if(txt_loanamount1[i].equalsIgnoreCase(""))
				{
					txt_loanamount1[i] = "0";
				}
				arrValues.add(txt_loanamount1[i]);
				arrValues.add("R");
				arrValues.add(prd_type);
			   hshQuery.put("arrValues", arrValues);	
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
		   
			}
			ArrayList arrValues4 = new ArrayList();
			if(strAction.equalsIgnoreCase("insert"))
			{
				
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","agr_del_poultryrecexp");
				arrValues4.add(appno);
				hshQuery.put("arrValues",arrValues4);
				hshQueryValues.put("1",hshQuery);
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(correctNull((String) hshValues.get("txt_totalamount")));
				arrValues.add(correctNull((String) hshValues.get("txt_totalmargin")));
				arrValues.add(correctNull((String) hshValues.get("txt_totalloanamount")));
				arrValues.add(correctNull((String) hshValues.get("txt_totalamount2")));
				arrValues.add(correctNull((String) hshValues.get("txt_totalmargin2")));
				arrValues.add(correctNull((String) hshValues.get("txt_totalloanamount2")));
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agr_ins_poultryrecexp");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction3.equalsIgnoreCase("insert3"))
			{
				arrValues4= new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","agr_del_poultry_labcharge");
				arrValues4.add(appno);
				arrValues4.add(prd_type);
				hshQuery.put("arrValues",arrValues4);
				hshQueryValues.put("1",hshQuery);
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(correctNull((String) hshValues.get("txt_labourcharge")));
				arrValues.add(prd_type);
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agr_ins_poultry_labcharge");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			 StringBuilder sbAuditTrial=new StringBuilder();
			 if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			 {
				sbAuditTrial
				.append("Particulars ^")
				.append("~Purchase of = ")
				.append(txt_nochicks[0])
				.append("~number of chicks/batch = ")
				.append(txt_noofbatches[0])
				.append("~no. of batches,@Rs. = ")
				.append(txt_value[0])
				.append(" per chick. ")
				.append("~Amount = ")
				.append(txt_amount[0])
				
				.append("~Feeding of = ")
				.append(txt_nochicks[1])
				.append("~number of chicks/batch = ")
				.append(txt_noofbatches[1])
				.append("~no. of batches,at = ")
				.append(txt_value[1])
				.append("~kg per chick,@Rs. = ")
				.append(txt_value1[1])
				.append("~per kg of chick mash.(chick mortality = ")
				.append(Helper.correctNull((String)hshValues.get("txt_mortality1")))
				.append(" %) ")
				.append("~Amount = ")
				.append(txt_amount[1])
				
				.append("~Feeding of = ")
				.append(txt_nochicks[2])
				.append("~number of growers/batch, = ")
				.append(txt_noofbatches[2])
				.append("~no. of batches,at =")
				.append(txt_value[2])
				.append("~kg per Grower@Rs.=")
				.append(txt_value1[2])
				.append("~per kg of grower mash.(mortality in Grower = ")
				.append(Helper.correctNull((String)hshValues.get("txt_mortality2")))
				.append(" %) ")
				.append("~Amount = ")
				.append(txt_amount[2]);
				
				 
				 sbAuditTrial.append("Miscellaneous Expenses upto economic laying ^");
				 
				 for (int i =3; i <=12; i++)
					{
						 sbAuditTrial
						 .append(strDesc_1[i-3])
						 .append(txt_charges[i-3])
						 .append(strDesc_2[i-3])
						 .append(txt_value2[i-3])
						 .append(strDesc_3[i-3]);
						 if((i-3)<5)
						 {
							 sbAuditTrial
							 .append(txt_month[i-3])
							 .append(" months. ");
						 }
						 else
						 {
							 sbAuditTrial
							 .append(" ");
						 }
						 sbAuditTrial
						 .append("~Amount(Rs.) = ")
						 .append(txt_amount[i]);
					}
				 
				 sbAuditTrial.append("~If Others Specify ^")
				 .append("~Particulars ^");
				 for (int i =0; i <=4; i++)
					{
					 sbAuditTrial
					 .append("~")
					 .append(txt_item1[i])
					 .append(" = ")
					 .append("~Rs = ")
					 .append(txt_cost1[i])
					 .append("~for = ")
					 .append(txt_month1[i])
					 .append(" months. ")
					 .append("~Amount(Rs.) = ")
					 .append(txt_amount1[i]);
					}
				 if(correctNull((String)hshValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
				 {
					 hshValues.put("strAction", "update");
				 }
				 else
				 {
					 hshValues.put("strAction", "insert");
				 }
			 }
				 AuditTrial.auditLog(hshValues,"247",appno,sbAuditTrial.toString());
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
	
	public  HashMap getrecurringData(HashMap hshValues) 
	{
 		ResultSet rs = null;
 		ResultSet rs1 = null;ResultSet rs2 = null;
 		String strQuery = "";
 		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}
 		HashMap hshRecord = new HashMap();
 		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		ArrayList arryRow1 = new ArrayList();
		ArrayList arryCol1 = null;
		ArrayList arryRow2 = new ArrayList();
		ArrayList arryCol2 = null;
		String appno = correctNull((String) hshValues.get("appno"));
 		if(appno.equalsIgnoreCase("null") ||  appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
        String PageType=Helper.correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
         {
      	 PageType=Helper.correctNull((String)hshValues.get("hidpagetype"));
         }
 		try 
		{
			/*strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}*/
			strQuery = SQLParser.getSqlQuery("agr_get_poultryfindata^"+appno+ "^" +prd_type);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) 
			{
				hshRecord.put("txt_nochicks", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_nochicks"))));
				hshRecord.put("txt_costchicks", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_costchicks"))));
				hshRecord.put("txt_costchickmash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_costchickmash"))));
				hshRecord.put("txt_conchickmash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_conchickmash"))));
				hshRecord.put("txt_costgrowermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_costgrowermash"))));
				hshRecord.put("txt_congrowermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_congrowermash"))));
				hshRecord.put("txt_costlayermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_costlayermash"))));
				hshRecord.put("txt_conlayermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_conlayermash"))));
				hshRecord.put("txt_broodingmor", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_broodingmor"))));
				hshRecord.put("txt_growingmor", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_growingmor"))));
				hshRecord.put("txt_layingmor", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_layingmor"))));
				hshRecord.put("txt_specify1", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_specify1"))));
				hshRecord.put("txt_specify2", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_specify2"))));
				hshRecord.put("txt_electricitycharge", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_electricitycharge"))));
				hshRecord.put("txt_watercharge", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_watercharge"))));
				hshRecord.put("txt_vtaid", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_vtaid"))));
				hshRecord.put("txt_inspremium", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_inspremium"))));
				hshRecord.put("txt_yieldegg", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_yieldegg"))));
				hshRecord.put("txt_saleegg", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_saleegg"))));
				hshRecord.put("txt_saleculled", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_saleculled"))));
				hshRecord.put("txt_yieldmanure", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_yieldmanure"))));
				hshRecord.put("txt_salemanure", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_salemanure"))));
				hshRecord.put("txt_salegunny", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_salegunny"))));
				hshRecord.put("txt_emptybag", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_emptybag"))));
				hshRecord.put("txt_transportcharge", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_transportcharge"))));
				hshRecord.put("txt_totalcostchicks", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalcostchicks"))));
				hshRecord.put("txt_totalchickmash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalchickmash"))));
				hshRecord.put("txt_totalgrowermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalgrowermash"))));
				hshRecord.put("txt_totallayermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totallayermash"))));
				hshRecord.put("txt_totalvtaid", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalvtaid"))));
				hshRecord.put("txt_totalinspremium", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalinspremium"))));
				hshRecord.put("txt_totalsaleegg", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalsaleegg"))));
				hshRecord.put("txt_totsaleculled", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totsaleculled"))));
				hshRecord.put("txt_totsalemanure", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totsalemanure"))));
				hshRecord.put("txt_totsalebag", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totsalebag"))));
				
			}
			
				 if (rs1 != null)
				    {
					rs1.close();
				    }
				
						 							 
			strQuery = SQLParser.getSqlQuery("per_get_poultryfinperdata^" + appno+ "^" +prd_type);
			rs = DBUtils.executeQuery(strQuery);
			ArrayList arryCol3 = new ArrayList();
			ArrayList arryRow3 = new ArrayList();
			while (rs.next())
			{
				arryCol3 = new ArrayList();
				arryCol3.add(appno);
				arryCol3.add(rs.getString("sno"));
				arryCol3.add(rs.getString("poultry_noperson"));
				arryCol3.add(rs.getString("poultry_salarypm"));
				arryCol3.add(rs.getString("poultry_salarypy"));
				arryRow3.add(arryCol3);
			}
										 
			strQuery = SQLParser.getSqlQuery("sel_poultry_nonrecurring^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol2 = new ArrayList();
				arryCol2.add(appno);
				arryCol2.add(rs.getString("poultry_sq"));
				arryCol2.add(rs.getString("poultry_amount"));
				arryCol2.add(rs.getString("poultry_specify"));
				arryCol2.add(rs.getString("poultry_loanamount"));
				arryCol2.add(rs.getString("poultry_margin"));
				arryCol2.add(rs.getString("poultry_totalamount"));
				arryCol2.add(rs.getString("poultry_totalmargin"));
				arryCol2.add(rs.getString("poultry_totalloanamount"));
				
				arryRow2.add(arryCol2);
			}
		
			strQuery = SQLParser.getSqlQuery("sel_poultry_expenses_poultrytype^" + appno+"^"+prd_type+"^E");
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol1 = new ArrayList();
				arryCol1.add(rs.getString("poultry_expenses"));
				arryCol1.add(rs.getString("poultry_iyear"));
				arryCol1.add(rs.getString("poultry_iiyear"));
				arryCol1.add(rs.getString("poultry_iiiyear"));
				arryCol1.add(rs.getString("poultry_type"));
				arryRow1.add(arryCol1);
				hshRecord.put("auditFlag", "Y");
			}
			strQuery = SQLParser.getSqlQuery("sel_poultry_recurring^" + appno+"^"+prd_type);
			rs = DBUtils.executeQuery(strQuery);
			ArrayList arryCol4 = new ArrayList();
			ArrayList arryRow4= new ArrayList();
			
			while (rs.next())
			{
				arryCol4 = new ArrayList();
				arryCol4.add(rs.getString("poultry_item"));
				arryCol4.add(rs.getString("poultry_unit"));
				arryCol4.add(rs.getString("poultry_cost"));
				arryCol4.add(rs.getString("poultry_loan_amount"));
				
				arryRow4.add(arryCol4);
			}
			strQuery = SQLParser.getSqlQuery("sel_poultry_recurringdata^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			//String poultry_mortality1="",poultry_mortality2="";
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(appno);
				arryCol.add(rs.getString("poultry_nochicks"));
				arryCol.add(rs.getString("poultry_nobatch"));
				arryCol.add(rs.getString("poultry_value"));
				arryCol.add(rs.getString("poultry_value1"));
				arryCol.add(rs.getString("poultry_mortality1"));
				arryCol.add(rs.getString("poultry_mortality2"));
			    arryCol.add(rs.getString("poultry_charge"));
				arryCol.add(rs.getString("poultry_value2"));
				arryCol.add(rs.getString("poultry_month"));
				arryCol.add(rs.getString("poultry_loanamount"));
				arryCol.add(rs.getString("poultry_totalamount"));
				arryCol.add(rs.getString("poultry_totalmargin"));
				arryCol.add(rs.getString("poultry_totalloanamount"));
			
				arryRow.add(arryCol);
				hshRecord.put("auditFlag", "Y");
			}
			
			
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("arryRow1", arryRow1);
			hshRecord.put("arryRow2", arryRow2);
			hshRecord.put("arryRow3", arryRow3);
			hshRecord.put("arryRow4", arryRow4);
			hshRecord.put("PageType", PageType);
			
		} 
		catch(Exception ce)
		{
			throw new EJBException("Error in getcoopsocMasterList "+ce.toString());
		}
		finally 
		{
			try
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
				if (rs1 != null) 
				{
					rs1.close();
					rs1 = null;
				}
				if (rs2 != null) 
				{
					rs2.close();
				}
				
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}	
	public HashMap updateagrflock(HashMap hshValues)  
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshpasValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ResultSet rs = null;
		HashMap hshResult = new HashMap();
		String strAction="";		
		String strApplicationNo = correctNull((String) hshValues.get("strappno"));
		if(strApplicationNo.equalsIgnoreCase(""))
		{
			strApplicationNo = Helper.correctNull((String)hshValues.get("appno"));
		}
		 strAction = correctNull((String) hshValues.get("hidAction"));
	  	String []txt_batch=null;
		String []txt_broodermon=null;
		String []txt_growermon=null;
		String []txt_layermon=null;
		String []txt_culls=null;
		
		int intUpdatesize=0;
		try
		{
			strApplicationNo=correctNull((String)hshValues.get("strappno"));
			if(strApplicationNo.equalsIgnoreCase(""))
			{
				strApplicationNo = Helper.correctNull((String)hshValues.get("appno"));
			}
			txt_batch=(String [])hshValues.get("txt_batch");
			txt_broodermon=(String [])hshValues.get("txt_broodermon");
			txt_growermon=(String [])hshValues.get("txt_growermon");
			txt_layermon=(String [])hshValues.get("txt_layermon");
			txt_culls=(String [])hshValues.get("txt_culls");
			ArrayList arrValues=new ArrayList();
			if (strAction.equals("delete"))
			{	
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","agr_delflockrep");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			if (strAction.equals("insert"))
			{			
				hshQuery=new HashMap();
				 arrValues=new ArrayList();
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","agr_delflockrep");
				intUpdatesize=1;
				hshQueryValues.put("1",hshQuery);
				for(int i=2;i<txt_batch.length+2;i++)
				{
					if(!txt_batch[i-2].equals(""))
					{
						intUpdatesize=intUpdatesize+1;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","agr_insflockrep");
						arrValues.add(strApplicationNo);
						arrValues.add(new Integer(i-1).toString());
						if(correctNull(txt_batch[i-2]).equals(""))
						{
							arrValues.add("0");
						}
						else
						{
							arrValues.add(correctNull(txt_batch[i-2]));
						}if(correctNull(txt_broodermon[i-2]).equals(""))
						{
							arrValues.add("0");
						}
						else
						{
							arrValues.add(correctNull(txt_broodermon[i-2]));
						}
						if(correctNull(txt_growermon[i-2]).equals(""))
						{
							arrValues.add("0");
						}
						else
						{
							arrValues.add(correctNull(txt_growermon[i-2]));
						}
						if(correctNull(txt_layermon[i-2]).equals(""))
						{
							arrValues.add("0");
						}
						else
						{
							arrValues.add(correctNull(txt_layermon[i-2]));
						}
						if(correctNull(txt_culls[i-2]).equals(""))
						{
							arrValues.add("0");
						}
						else
						{
							arrValues.add(correctNull(txt_culls[i-2]));
						}
						hshQuery.put("arrValues",arrValues);	
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(i),hshQuery);		
					}
				}
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			} 			
			hshpasValues.put("appno",strApplicationNo);
			hshResult=getagrflock(hshpasValues);
			
			
			 StringBuilder sbAuditTrial=new StringBuilder();
			 if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			 {
			for(int i=0;i<txt_batch.length;i++)
			{
				if(!txt_batch[i].equals(""))
				{
					sbAuditTrial
					.append("~Project Year = ")				
					.append(i+1)
					.append("~No.of Batches of chicks purchased = ")
					.append(correctNull(txt_batch[i]))
					.append("~No.of Brooder batches = ")
					.append(correctNull(txt_broodermon[i]))
					.append("~No.of Grower batches = ")
					.append(correctNull(txt_growermon[i]))
					.append("~No.of Layer batches = ")
					.append(correctNull(txt_layermon[i]))
					.append("~No.of culls = ")
					.append(correctNull(txt_culls[i]));
				}
			  }
			if(correctNull((String)hshValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
			{
				hshValues.put("strAction", "update");
			}
			else
			{
				hshValues.put("strAction", "insert");
			}
			 }
			AuditTrial.auditLog(hshValues,"248",strApplicationNo,sbAuditTrial.toString());
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
	
	public HashMap getagrflock(HashMap hshValues)  
	{		 
		ResultSet rs=null;
		HashMap hshResult=new HashMap();
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=null;		
		String strApplicationNo=correctNull((String)hshValues.get("strappno"));
		if(strApplicationNo.equalsIgnoreCase(""))
		{
			strApplicationNo = Helper.correctNull((String)hshValues.get("appno"));
		}
		try
		{
			rs=DBUtils.executeLAPSQuery("agr_selflockrep^"+strApplicationNo);			 
			while (rs.next())
			{
				arryCol=new ArrayList();
				arryCol.add(rs.getString("sno"));
				arryCol.add(rs.getString("agr_batch"));				
				arryCol.add(rs.getString("agr_broodermon"));
				arryCol.add(rs.getString("agr_growermon"));
				arryCol.add(rs.getString("agr_layermon"));
				arryCol.add(rs.getString("agr_culls"));
				
				arryRow.add(arryCol);
				hshResult.put("auditFlag", "Y");
			}
			hshResult.put("arryRow",arryRow);	
		} 
		catch (Exception e) 
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		}finally
		{
			try
			{
				if(rs!=null)
					rs.close();
			}catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in getagrflock "+ exp.toString()); 
			}
		}
		return hshResult;
	}
	//poultry tech data
	public HashMap getpoultrytechdata(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;ResultSet rs2 = null;
		HashMap hshRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}
		
		ArrayList arryCol = null;
		String appno=correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
		
        String PageType=Helper.correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
        {
        	 PageType=Helper.correctNull((String)hshValues.get("hidpagetype"));
        }
        
		try 
		{
			/*strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}*/
			strQuery = SQLParser.getSqlQuery("agr_get_poultrytechdata^"+appno+ "^" +prd_type);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) 
			{
				hshRecord.put("txt_distbranch", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_distbranch"))));
				hshRecord.put("sel_farm", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_farm"))));
				hshRecord.put("txr_location", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_location"))));
				hshRecord.put("txt_mortorable", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_mortorable"))));
				hshRecord.put("txt_environment", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_environment"))));
				hshRecord.put("txt_aidloc", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_aidloc"))));
				hshRecord.put("txt_distfarm", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_distfarm"))));
				hshRecord.put("txt_watersrc", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_watersrc"))));
				hshRecord.put("txt_waterloc", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_waterloc"))));
				hshRecord.put("sel_electricity", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_electricity"))));
				hshRecord.put("txr_electricity", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_electricityspec"))));
				hshRecord.put("txt_marketingegg", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_marketingegg"))));
				hshRecord.put("txt_distegg", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_distegg"))));
				hshRecord.put("txt_feed", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_feed"))));
				hshRecord.put("txt_distfeed", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_distfeed"))));
				hshRecord.put("txt_chicks", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_chicks"))));
				hshRecord.put("txt_distchicks", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_distchicks"))));
				hshRecord.put("txr_farm", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_farmspec"))));
				hshRecord.put("sel_shed", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_shed"))));
				hshRecord.put("txt_specify1", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_specify1"))));
				hshRecord.put("sel_rearing", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_rearing"))));
				hshRecord.put("txt_specify2", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_specify2"))));
				hshRecord.put("txt_broodershed", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_broodershed"))));
				hshRecord.put("txt_growershed", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_growershed"))));
				hshRecord.put("txt_bgshed", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_bgshed"))));
				hshRecord.put("txt_layershed", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_layershed"))));
				hshRecord.put("txt_ashed", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_ashed"))));
				hshRecord.put("txt_time", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_time"))));
				hshRecord.put("txt_breed", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_breed"))));
				hshRecord.put("recordFlag", "Y");
			}
			
				 if (rs1 != null)
				    {
					rs1.close();
				    }
				
						 							 
			strQuery = SQLParser.getSqlQuery("per_get_poultrylanddata^" + appno+ "^" + prd_type);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(appno);
				arryCol.add(rs.getString("sno"));
				arryCol.add(rs.getString("poultry_syno"));
				arryCol.add(rs.getString("poultry_land"));
				arryCol.add(rs.getString("poultry_village"));
				arryCol.add(rs.getString("poultry_taluk"));
			
				arryRow.add(arryCol);
			}
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("PageType", PageType);
			
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
					rs = null;
				}
				 if (rs1 != null)
				    {
					rs1.close();
				    }
				 if (rs2 != null)
				    {
					rs2.close();
				    }
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap updatepoultrytechdata(HashMap hshValues)  
	{
 		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshQuery5 = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strAction = null;		
		//String strAction1 = null;	
		HashMap hshResult = new HashMap();
		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		
		HashMap hshQuery4 = new HashMap();
		int intUpdatesize = 0;
		int f = 0;
		String strid = "", strQuery1 = "";
		String appno=correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
		strAction = correctNull((String) hshValues.get("hidAction"));
		//strAction1 = correctNull((String) hshValues.get("hidAction1"));
		String sel_farm= correctNull((String) hshValues.get("sel_farm"));
		if(sel_farm.equalsIgnoreCase(""))
		{
			sel_farm="0";	
		}
		else
		{
			sel_farm= correctNull((String) hshValues.get("sel_farm"));
		}
		String sel_electricity= correctNull((String) hshValues.get("sel_electricity"));
		if(sel_electricity.equalsIgnoreCase(""))
		{
			sel_electricity="0";	
		}
		else
		{
			sel_electricity= correctNull((String) hshValues.get("sel_electricity"));
		}
		String sel_shed= correctNull((String) hshValues.get("sel_shed"));
		
		if(sel_shed.equalsIgnoreCase(""))
		{
			sel_shed="0";	
		}
		else
		{
			sel_shed= correctNull((String) hshValues.get("sel_shed"));
		}
		String sel_rearing= correctNull((String) hshValues.get("sel_rearing"));
		if(sel_rearing.equalsIgnoreCase(""))
		{
			sel_rearing="0";	
		}
		else
		{
			sel_rearing= correctNull((String) hshValues.get("sel_rearing"));
		}
		String txt_distbranch = correctNull((String) hshValues.get("txt_distbranch"));
		String  txr_location= correctNull((String) hshValues.get("txr_location"));
		String  txt_mortorable= correctNull((String) hshValues.get("txt_mortorable"));
		String txt_environment= correctNull((String) hshValues.get("txt_environment"));
		String txt_aidloc= correctNull((String) hshValues.get("txt_aidloc"));
		String txt_distfarm = correctNull((String) hshValues.get("txt_distfarm"));
		String  txt_watersrc= correctNull((String) hshValues.get("txt_watersrc"));
		String  txt_waterloc= correctNull((String) hshValues.get("txt_waterloc"));
		String txr_electricity= correctNull((String) hshValues.get("txr_electricity"));
		String  txt_marketingegg= correctNull((String) hshValues.get("txt_marketingegg"));
		String txt_distegg= correctNull((String) hshValues.get("txt_distegg"));
		String txt_feed = correctNull((String) hshValues.get("txt_feed"));
		String  txt_distfeed= correctNull((String) hshValues.get("txt_distfeed"));
		String  txt_chicks= correctNull((String) hshValues.get("txt_chicks"));
		String txt_distchicks= correctNull((String) hshValues.get("txt_distchicks"));
		String txr_farm= correctNull((String) hshValues.get("txr_farm"));
		String txt_specify1= correctNull((String) hshValues.get("txt_specify1"));
		String  txt_specify2= correctNull((String) hshValues.get("txt_specify2"));
		String  txt_broodershed= correctNull((String) hshValues.get("txt_broodershed"));
		String txt_growershed= correctNull((String) hshValues.get("txt_growershed"));
		String  txt_bgshed= correctNull((String) hshValues.get("txt_bgshed"));
		String txt_layershed= correctNull((String) hshValues.get("txt_layershed"));
		String txt_ashed= correctNull((String) hshValues.get("txt_ashed"));
		String  txt_time= correctNull((String) hshValues.get("txt_time"));
		String txt_breed= correctNull((String) hshValues.get("txt_breed"));
		
		try 
		{
			String[] txt_syno = null;
			String[]txt_land = null;
			String[] txt_village= null;
			String[] txt_taluk= null;
			txt_syno = (String[]) hshValues.get("txt_syno");
			txt_village= (String[]) hshValues.get("txt_village");
			txt_land = (String[]) hshValues.get("txt_land");
			strid = correctNull((String) hshValues.get("hid_sno"));
			txt_taluk= (String[]) hshValues.get("txt_taluk");
			/*strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshResult.put("applicantid", rs.getString("demo_appid"));
			}*/
			if (strAction.equals("delete"))
			{
				hshQuery4 = new HashMap();
				HashMap hshQueryValues4 = new HashMap();
				ArrayList arrValues4 = new ArrayList();
				hshQueryValues4.put("size", "1");
				hshQuery4.put("strQueryId", "per_del_poultrytechdata");
				arrValues4.add(appno);
				arrValues4.add(prd_type);
				hshQuery4.put("arrValues", arrValues4);
				hshQueryValues4.put("1", hshQuery4);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
			}
			if (strAction.equals("delete"))
			{
				hshQuery5 = new HashMap();
				HashMap hshQueryValues5 = new HashMap();
				ArrayList arrValues5 = new ArrayList();
				hshQueryValues5.put("size", "1");
				hshQuery5.put("strQueryId", "agr_del_poultrylanddata");
				arrValues5.add(appno);
				arrValues5.add(prd_type);
				hshQuery5.put("arrValues", arrValues5);
				hshQueryValues5.put("1", hshQuery5);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues5,"updateData");
			}
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQuery= new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("size", "1");
				hshQuery.put("strQueryId", "per_del_poultrytechdata");
				arrValues.add(appno);
				arrValues.add(prd_type);
				hshQuery.put("arrValues",arrValues);	
				hshQueryValues.put("1",hshQuery);
				
				hshQuery= new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(txt_distbranch);
				arrValues.add(sel_farm);
				arrValues.add(txr_location);
				arrValues.add(txt_mortorable);
				arrValues.add(txt_environment);
				arrValues.add(txt_aidloc);
				arrValues.add(txt_distfarm);
				arrValues.add(txt_watersrc);
				arrValues.add(txt_waterloc);
				arrValues.add(sel_electricity);
				arrValues.add(txr_electricity);
				arrValues.add(txt_marketingegg);
				arrValues.add(txt_distegg);
				arrValues.add(txt_feed);
				arrValues.add(txt_distfeed);
				arrValues.add(txt_chicks);
				arrValues.add(txt_distchicks);
				arrValues.add(txr_farm);
				arrValues.add(sel_shed);
				arrValues.add(txt_specify1);
				arrValues.add(sel_rearing);
				arrValues.add(txt_specify2);
				arrValues.add(txt_broodershed);
				arrValues.add(txt_growershed);
				arrValues.add(txt_bgshed);
				arrValues.add(txt_layershed);
				arrValues.add(txt_ashed);
				arrValues.add(txt_time);
			    arrValues.add(txt_breed);
			    arrValues.add(prd_type);
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agr_ins_poultrytechdata");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			if (strAction.equals("insert"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "1");
				hshQuery3.put("strQueryId", "agr_del_poultrylanddata");
				arrValues3.add(appno);
				arrValues3.add(prd_type);
				hshQuery3.put("arrValues", arrValues3);
				strQuery1 = SQLParser.getSqlQuery("sel_maxid_poultrylanddata");
				rs = DBUtils.executeQuery(strQuery1);
				if (rs.next())
				{
					strid = correctNull((String) rs.getString("maxid"));
					f = Integer.parseInt(strid);
				}
				intUpdatesize = 1;

				for (int i = 0; i < txt_syno.length; i++)
				{					
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "per_ins_poultrylanddata");
					arrValues.add(appno);
					arrValues.add(new Integer(i + 1).toString());
					if (correctNull( txt_syno[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_syno[i]));
					}
					if (correctNull(txt_land[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_land[i]));
					}
					if (correctNull(txt_village[i]).equals("")) 
					{
						arrValues.add("");
					}
					else 
					{
						arrValues.add(correctNull(txt_village[i]));
					}
					if (correctNull(txt_taluk[i]).equals(""))
					{
						arrValues.add("");
					} 
					else
					{
						arrValues.add(correctNull(txt_taluk[i]));
					}
					
				   arrValues.add(prd_type);
					hshQuery.put("arrValues", arrValues);
					f = f + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);					
				}
				hshQueryValues.put("1", hshQuery3);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{
			for (int i = 0; i < txt_syno.length; i++)
			{	
				
					sbAuditTrial
					.append("~Survey Number  = ").append(correctNull(txt_syno[i]))
					.append("~Extent of land in acres/cents = ").append(correctNull(txt_land[i]))
					.append("~village= ").append(correctNull(txt_village[i]))
					.append("~Taluk/District = ").append(correctNull(txt_taluk[i]));
					
			}	
				sbAuditTrial
				.append("~Distance from the Branch =")
				.append(txt_distbranch).append("(KM)")
				.append("~Whether the proposed farm =")
				.append(correctNull((String) hshValues.get("sel_farm1")))
				.append("~Whether the proposed farm has as follows : ^")
				.append("~Good Mortorable road to farm =")
				.append(txt_mortorable)
				.append("~Calm Environment =")
				.append(txt_environment)
				.append("~Veterinary Aid facility( location) =")
				.append(txt_aidloc)
				.append("~Distance from farm =")
				.append(txt_distfarm).append("(KM)")
				.append("~Water arrangement(Source) =")
				.append(txt_watersrc)
				.append("~Location =")
				.append(txt_waterloc)
				.append("~Electricity =")
				.append(correctNull((String) hshValues.get("sel_electricity1")))
				.append("~Marketing of Egg/Birds(place) =")
				.append(txt_marketingegg)
				.append("~Distance =")
				.append(txt_distegg).append("(KM)")
				.append("~Avalibility of Feed(Place) =")
				.append(txt_feed)
				.append("~Distance =")
				.append(txt_distfeed).append("(KM)")
				.append("~Avalibility of Chicks(Place) =")
				.append(txt_chicks)
				.append("~Distance =")
				.append(txt_distchicks).append("(KM)")
				.append("~Type of Shed =")
				.append(correctNull((String) hshValues.get("sel_shed1")));
				if(Helper.correctNull((String)hshValues.get("sel_shed1")).equalsIgnoreCase("Any other"))
				{
					sbAuditTrial.append("~specify =").append(txt_specify1);
				}
				sbAuditTrial
				.append("~Type of rearing =")
				.append(correctNull((String) hshValues.get("sel_rearing1")));
				if(Helper.correctNull((String)hshValues.get("sel_rearing1")).equalsIgnoreCase("other"))
				{
					sbAuditTrial.append("~specify =").append(txt_specify2);
				}
				sbAuditTrial
				.append("~Brooder Shed =")
				.append(txt_broodershed)
				.append("~Grower Shed =")
				.append(txt_growershed);
				if(prd_type.equalsIgnoreCase("aP"))
				{
				sbAuditTrial
				.append("~Brooder cum Grower Shed =")
				.append(txt_bgshed)
				.append("~Layer Shed =")
				.append(txt_layershed);
				}
				sbAuditTrial
				.append("~All in all out system =")
				.append(txt_ashed)
				.append("~Time required to complete civil works and purchase of first batch of bird =")
				.append(txt_time)
				.append("months")
				.append("~Breed of Birds to be purchased =")
				.append(txt_breed);
				if(correctNull((String)hshValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
				{
					hshValues.put("strAction", "update");
				}
			}
				if(prd_type.equalsIgnoreCase("aP"))
				{
					AuditTrial.auditNewLog(hshValues, "244", appno, sbAuditTrial.toString(), "");
				}
				else
				{
					AuditTrial.auditLog(hshValues,"252",appno,sbAuditTrial.toString());
				}
			
			hshpasValues.put("prd_type",prd_type);
			hshpasValues.put("appno", appno);
			hshResult = getpoultrytechdata(hshpasValues);
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} 
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
			} 
			catch (Exception e1) 
			{
				throw new EJBException("Error in closing Connection "+ e1.getMessage());
			}
		}
		return hshResult;
	}
	//findata

	public HashMap getpoultryfindata(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;ResultSet rs2 = null;
		HashMap hshRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		ArrayList arryRow1 = new ArrayList();
		ArrayList arryCol1 = null;
		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}
		String appno=correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
	    String PageType=Helper.correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
        {
        	 PageType=Helper.correctNull((String)hshValues.get("hidpagetype"));
        }
        
		try 
		{
			/*strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}*/
			strQuery = SQLParser.getSqlQuery("agr_get_poultryfindata^"+appno+ "^" +prd_type);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) 
			{
				hshRecord.put("txt_nochicks", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_nochicks"))));
				hshRecord.put("txt_costchicks", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_costchicks"))));
				hshRecord.put("txt_costchickmash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_costchickmash"))));
				hshRecord.put("txt_conchickmash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_conchickmash"))));
				hshRecord.put("txt_costgrowermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_costgrowermash"))));
				hshRecord.put("txt_congrowermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_congrowermash"))));
				hshRecord.put("txt_costlayermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_costlayermash"))));
				hshRecord.put("txt_conlayermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_conlayermash"))));
				hshRecord.put("txt_broodingmor", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_broodingmor"))));
				hshRecord.put("txt_growingmor", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_growingmor"))));
				hshRecord.put("txt_layingmor", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_layingmor"))));
				hshRecord.put("txt_specify1", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_specify1"))));
				hshRecord.put("txt_specify2", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_specify2"))));
				hshRecord.put("txt_electricitycharge", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_electricitycharge"))));
				hshRecord.put("txt_watercharge", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_watercharge"))));
				hshRecord.put("txt_vtaid", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_vtaid"))));
				hshRecord.put("txt_inspremium", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_inspremium"))));
				hshRecord.put("txt_yieldegg", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_yieldegg"))));
				hshRecord.put("txt_saleegg", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_saleegg"))));
				hshRecord.put("txt_saleculled", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_saleculled"))));
				hshRecord.put("txt_yieldmanure", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_yieldmanure"))));
				hshRecord.put("txt_salemanure", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_salemanure"))));
				hshRecord.put("txt_salegunny", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_salegunny"))));
				hshRecord.put("txt_emptybag", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_emptybag"))));
				hshRecord.put("txt_transportcharge", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_transportcharge"))));
				hshRecord.put("txt_totalcostchicks", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalcostchicks"))));
				hshRecord.put("txt_totalchickmash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalchickmash"))));
				hshRecord.put("txt_totalgrowermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalgrowermash"))));
				hshRecord.put("txt_totallayermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totallayermash"))));
				hshRecord.put("txt_totalvtaid", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalvtaid"))));
				hshRecord.put("txt_totalinspremium", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalinspremium"))));
				hshRecord.put("txt_totalsaleegg", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalsaleegg"))));
				hshRecord.put("txt_totsaleculled", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totsaleculled"))));
				hshRecord.put("txt_totsalemanure", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totsalemanure"))));
				hshRecord.put("txt_totsalebag", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totsalebag"))));
				hshRecord.put("auditFlag", "Y");
			}
			
				 if (rs1 != null)
				    {
					rs1.close();
				    }
				
						 							 
			strQuery = SQLParser.getSqlQuery("per_get_poultryfinperdata^" + appno+ "^" +prd_type);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(appno);
				arryCol.add(rs.getString("sno"));
				arryCol.add(rs.getString("poultry_noperson"));
				arryCol.add(rs.getString("poultry_salarypm"));
				arryCol.add(rs.getString("poultry_salarypy"));
				arryRow.add(arryCol);
			}
			
			strQuery = SQLParser.getSqlQuery("sel_poultry_expenses_poultrytype^" + appno+ "^" +prd_type+"^E");
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol1 = new ArrayList();
				arryCol1.add(rs.getString("poultry_expenses"));
				arryCol1.add(rs.getString("poultry_iyear"));
				arryCol1.add(rs.getString("poultry_iiyear"));
				arryCol1.add(rs.getString("poultry_iiiyear"));
				arryCol1.add(rs.getString("poultry_type"));
				arryRow1.add(arryCol1);
			}
			hshRecord.put("arryRow1", arryRow1);
			
			arryRow1 = new ArrayList(); 
			
			strQuery = SQLParser.getSqlQuery("sel_poultry_expenses_poultrytype^" + appno+ "^" +prd_type+"^S");
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol1 = new ArrayList();
				arryCol1.add(rs.getString("poultry_expenses"));
				arryCol1.add(rs.getString("poultry_iyear"));
				arryCol1.add(rs.getString("poultry_iiyear"));
				arryCol1.add(rs.getString("poultry_iiiyear"));
				arryCol1.add(rs.getString("poultry_type"));
				arryRow1.add(arryCol1);
			}
			hshRecord.put("arryRow2", arryRow1);
			
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("PageType", PageType);
			
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
					rs = null;
				}
				 if (rs1 != null)
				    {
					rs1.close();
				    }
				 if (rs2 != null)
				    {
					rs2.close();
				    }
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap updatepoultryfindata(HashMap hshValues)  
	{
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshQuery5 = new HashMap();
		ArrayList arrValues = new ArrayList();
		HashMap hshQuery3 = new HashMap();
		ArrayList arrValues3 = new ArrayList();
		ResultSet rs = null;
		String strAction = null;		
		//String strAction1 = null;	
		//String strAction2 = null;	
		HashMap hshResult = new HashMap();
		HashMap hshQuery4 = new HashMap();
		int intUpdatesize = 0;
		int intUpdatesize2=0;
		int f = 0;
		String strid = "", strQuery1 = "";
		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		
		String appno=correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
		strAction = correctNull((String) hshValues.get("hidAction"));
		//strAction1 = correctNull((String) hshValues.get("hidAction1"));
		//strAction2 = correctNull((String) hshValues.get("hidAction2"));
		String txt_nochicks = correctNull((String) hshValues.get("txt_nochicks"));
		String  txt_costchicks= correctNull((String) hshValues.get("txt_costchicks"));
		String  txt_costchickmash= correctNull((String) hshValues.get("txt_costchickmash"));
		String txt_conchickmash= correctNull((String) hshValues.get("txt_conchickmash"));
		String txt_costgrowermash= correctNull((String) hshValues.get("txt_costgrowermash"));
		String txt_congrowermash = correctNull((String) hshValues.get("txt_congrowermash"));
		String  txt_costlayermash= correctNull((String) hshValues.get("txt_costlayermash"));
		String  txt_conlayermash= correctNull((String) hshValues.get("txt_conlayermash"));
		String  txt_broodingmor= correctNull((String) hshValues.get("txt_broodingmor"));
		String txt_growingmor= correctNull((String) hshValues.get("txt_growingmor"));
		String  txt_layingmor= correctNull((String) hshValues.get("txt_layingmor"));
		String txt_specify1= correctNull((String) hshValues.get("txt_specify1"));
		String txt_specify2= correctNull((String) hshValues.get("txt_specify2"));
		String  txt_electricitycharge= correctNull((String) hshValues.get("txt_electricitycharge"));
		if(txt_electricitycharge.equalsIgnoreCase(""))
		{
			txt_electricitycharge="0";	
		}
		else{
			txt_electricitycharge= correctNull((String) hshValues.get("txt_electricitycharge"));
		}
		
		String  txt_watercharge= correctNull((String) hshValues.get("txt_watercharge"));
		if(txt_watercharge.equalsIgnoreCase(""))
		{
			txt_watercharge="0";	
		}
		else{
			txt_watercharge= correctNull((String) hshValues.get("txt_watercharge"));
		}
		String txt_vtaid= correctNull((String) hshValues.get("txt_vtaid"));
		if(txt_vtaid.equalsIgnoreCase(""))
		{
			txt_vtaid="0";	
		}
		else{
			txt_vtaid= correctNull((String) hshValues.get("txt_vtaid"));
		}
		String txt_inspremium= correctNull((String) hshValues.get("txt_inspremium"));
		if(txt_inspremium.equalsIgnoreCase(""))
		{
			txt_inspremium="0";	
		}
		else{
			txt_inspremium= correctNull((String) hshValues.get("txt_inspremium"));
		}
		String  txt_yieldegg= correctNull((String) hshValues.get("txt_yieldegg"));
		String txt_saleegg= correctNull((String) hshValues.get("txt_saleegg"));
		String  txt_saleculled= correctNull((String) hshValues.get("txt_saleculled"));
		String txt_yieldmanure= correctNull((String) hshValues.get("txt_yieldmanure"));
		String txt_salemanure= correctNull((String) hshValues.get("txt_salemanure"));
		if(txt_salemanure.equalsIgnoreCase(""))
		{
			txt_salemanure="0";	
		}
		else{
			txt_salemanure= correctNull((String) hshValues.get("txt_salemanure"));
		}
		String  txt_salegunny= correctNull((String) hshValues.get("txt_salegunny"));
		String txt_emptybag= correctNull((String) hshValues.get("txt_emptybag"));
		String txt_transportcharge= correctNull((String) hshValues.get("txt_transportcharge"));
		if(txt_transportcharge.equalsIgnoreCase(""))
		{
			txt_transportcharge="0";	
		}
		else{
			txt_transportcharge= correctNull((String) hshValues.get("txt_transportcharge"));
		}
		String  txt_totalcostchicks= correctNull((String) hshValues.get("txt_totalcostchicks"));
		String txt_totalchickmash= correctNull((String) hshValues.get("txt_totalchickmash"));
		String  txt_totalgrowermash= correctNull((String) hshValues.get("txt_totalgrowermash"));
		String txt_totallayermash= correctNull((String) hshValues.get("txt_totallayermash"));
		String txt_totalvtaid= correctNull((String) hshValues.get("txt_totalvtaid"));
		String  txt_totalinspremium= correctNull((String) hshValues.get("txt_totalinspremium"));
		String txt_totalsaleegg= correctNull((String) hshValues.get("txt_totsaleegg"));
		String txt_totsaleculled= correctNull((String) hshValues.get("txt_totsaleculled"));
		String txt_totsalemanure= correctNull((String) hshValues.get("txt_totsalemanure"));
		
		String txt_totsalebag= correctNull((String) hshValues.get("txt_totsalebag"));
		
		try 
		{
			String[] txt_noperson = null;
			String[]txt_salarypm = null;
			String[]txt_salarypy = null;
			String[] txt_exp = null;
			String[]txt_iyear= null;
			String[] txt_src = null;
			String[]txt_iyearsrc= null;
			String[]txt_iiyearsrc= null;
			String[]txt_iiiyearsrc= null;
			String[] strdesc={"~Labourers","Manager","~Supervisor","~"+Helper.correctNull((String)hshValues.get("txt_specify1")),"~"+Helper.correctNull((String)hshValues.get("txt_specify2"))};
			txt_noperson = (String[]) hshValues.get("txt_noperson");
			txt_salarypm= (String[]) hshValues.get("txt_salarypm");
			txt_salarypy= (String[]) hshValues.get("txt_salarypy");
			strid = correctNull((String) hshValues.get("hid_sno"));
			
			txt_exp = (String[]) hshValues.get("txt_exp");
			txt_iyear= (String[]) hshValues.get("txt_iyear");
			txt_src = (String[]) hshValues.get("txt_src");
			txt_iyearsrc= (String[]) hshValues.get("txt_iyearsrc");
			txt_iiyearsrc= (String[]) hshValues.get("txt_iiyearsrc");
			txt_iiiyearsrc= (String[]) hshValues.get("txt_iiiyearsrc");
			
			/*strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshResult.put("applicantid", rs.getString("demo_appid"));
			}*/
			if (strAction.equals("delete"))
			{
				hshQuery4 = new HashMap();
				HashMap hshQueryValues4 = new HashMap();
				ArrayList arrValues4 = new ArrayList();
				hshQueryValues4.put("size", "1");
				hshQuery4.put("strQueryId", "per_del_poultryfindata");
				arrValues4.add(appno);
				arrValues4.add(prd_type);
				hshQuery4.put("arrValues", arrValues4);
				hshQueryValues4.put("1", hshQuery4);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
			}
			if (strAction.equals("delete"))
			{
				hshQuery5 = new HashMap();
				HashMap hshQueryValues5 = new HashMap();
				ArrayList arrValues5 = new ArrayList();
				hshQueryValues5.put("size", "1");
				hshQuery5.put("strQueryId", "agr_del_poultryfinperdata");
				arrValues5.add(appno);
				arrValues5.add(prd_type);
				hshQuery5.put("arrValues", arrValues5);
				hshQueryValues5.put("1", hshQuery5);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues5,"updateData");
			}
			if (strAction.equals("delete"))
			{
				hshQuery4 = new HashMap();
				HashMap hshQueryValues4 = new HashMap();
				ArrayList arrValues4 = new ArrayList();
				hshQueryValues4.put("size", "1");
				hshQuery4.put("strQueryId", "del_poultry_expenses");
				arrValues4.add(appno);
				arrValues4.add(prd_type);
				hshQuery4.put("arrValues", arrValues4);
				hshQueryValues4.put("1", hshQuery4);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
			}
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQuery= new HashMap();
				ArrayList arrValues2 = new ArrayList();
				hshQuery.put("size", "2");
				hshQuery.put("strQueryId", "per_del_poultryfindata");
				arrValues2.add(appno);
				arrValues2.add(prd_type);
				hshQuery.put("arrValues",arrValues2);	
				hshQueryValues.put("1",hshQuery);
				hshQuery= new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(txt_nochicks);
				arrValues.add(txt_costchicks);
				arrValues.add(txt_costchickmash);
				arrValues.add(txt_conchickmash);
				arrValues.add(txt_costgrowermash);
				arrValues.add(txt_congrowermash);
				arrValues.add(txt_costlayermash);
				arrValues.add(txt_conlayermash);
				arrValues.add(txt_broodingmor);
				arrValues.add(txt_growingmor);
				arrValues.add(txt_layingmor);
				arrValues.add(txt_specify1);
				arrValues.add(txt_specify2);
				arrValues.add(txt_electricitycharge);
				arrValues.add(txt_watercharge);
				arrValues.add(txt_vtaid);
				arrValues.add(txt_inspremium);
				arrValues.add(txt_yieldegg);
				arrValues.add(txt_saleegg);
				arrValues.add(txt_saleculled);
				arrValues.add(txt_yieldmanure);
				arrValues.add(txt_salemanure);
				arrValues.add(txt_salegunny);
				arrValues.add(txt_emptybag);
				arrValues.add(txt_transportcharge);
				
				arrValues.add(txt_totalcostchicks);
				arrValues.add(txt_totalchickmash);
				arrValues.add(txt_totalgrowermash);
				arrValues.add(txt_totallayermash);
				arrValues.add(txt_totalvtaid);
				arrValues.add(txt_totalinspremium);
				arrValues.add(txt_totalsaleegg);
				arrValues.add(txt_totsaleculled);
				arrValues.add(txt_totsalemanure);
				arrValues.add(txt_totsalebag);
				arrValues.add(prd_type);
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agr_ins_poultryfindata");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			if (strAction.equals("insert"))
			{
				 hshQuery3 = new HashMap();
				 arrValues3 = new ArrayList();
				hshQuery3.put("size", "2");
				hshQuery3.put("strQueryId", "agr_del_poultryfinperdata");
				arrValues3.add(appno);
				arrValues3.add(prd_type);
				hshQuery3.put("arrValues", arrValues3);
				strQuery1 = SQLParser.getSqlQuery("sel_maxid_poultryfinperdata");
				rs = DBUtils.executeQuery(strQuery1);
				if (rs.next())
				{
					strid = correctNull((String) rs.getString("maxid"));
					f = Integer.parseInt(strid);
				}
				intUpdatesize = 1;

				for (int i = 0; i < txt_noperson.length; i++)
				{					
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "per_ins_poultryfinperdata");
					arrValues.add(appno);
					arrValues.add(new Integer(i + 1).toString());
					if (correctNull( txt_noperson[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_noperson[i]));
					}
					if (correctNull(txt_salarypm[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_salarypm[i]));
					}
					
				    arrValues.add(prd_type);
				    if (correctNull(txt_salarypy[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_salarypy[i]));
					}
					hshQuery.put("arrValues", arrValues);
					f = f + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);					
				}
				hshQueryValues.put("1", hshQuery3);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			if (strAction.equals("insert"))
			{
			
			 hshQuery3 = new HashMap();
			arrValues3 = new ArrayList();
			hshQuery3.put("size", "1");
			hshQuery3.put("strQueryId", "del_poultry_expenses");
			arrValues3.add(appno);
			arrValues3.add(prd_type);
			hshQuery3.put("arrValues", arrValues3);
			hshQueryValues.put("1", hshQuery3);
			hshQueryValues.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
			intUpdatesize2 = 1;
			
			
			for (int j = 0; j<5; j++)
			{
				if(!txt_exp[j].equalsIgnoreCase(""))
				{
					intUpdatesize2 = intUpdatesize2 + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_poultry_expenses");
					arrValues.add(appno);
					if(txt_exp[j].equalsIgnoreCase(""))
					{
						txt_exp[j] = "NIL";
					}
					arrValues.add(txt_exp[j]);
					if(txt_iyear[j].equalsIgnoreCase(""))
					{
						txt_iyear[j] = "0";
					}
					arrValues.add(txt_iyear[j]);
					
					arrValues.add("0");
					
					arrValues.add("0");
					arrValues.add("E");
					arrValues.add(prd_type);
					arrValues.add(""+j);
					hshQuery.put("arrValues", arrValues);	
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}	
			}
			intUpdatesize2 = 1;
			for (int l = 0; l<3; l++)
			{
				if(!txt_src[l].equalsIgnoreCase(""))
				{	
					intUpdatesize2 = intUpdatesize2 + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_poultry_expenses");
					arrValues.add(appno);
					if(txt_src[l].equalsIgnoreCase(""))
					{
						txt_src[l] = "NIL";
					}
					arrValues.add(txt_src[l]);
					if(txt_iyearsrc[l].equalsIgnoreCase(""))
					{
						txt_iyearsrc[l] = "0";
					}
					arrValues.add(txt_iyearsrc[l]);
					if(txt_iiyearsrc[l].equalsIgnoreCase(""))
					{
						txt_iiyearsrc[l] = "0";
					}
					arrValues.add(txt_iiyearsrc[l]);
					if(txt_iiiyearsrc[l].equalsIgnoreCase(""))
					{
						txt_iiiyearsrc[l] = "0";
					}
					arrValues.add(txt_iiiyearsrc[l]);
					arrValues.add("S");
					arrValues.add(prd_type);
					arrValues.add(""+l);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}	
			}
			
			}
			
			hshpasValues.put("prd_type",prd_type);
			hshpasValues.put("appno", appno);
			hshResult = getpoultryfindata(hshpasValues);
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{
				sbAuditTrial
				.append("~Financial Data ^")
				.append("~No. of chicks purchased per batch = ")	.append(txt_nochicks)
				.append("~Cost per chick = ")	.append(txt_costchicks)
				.append("~Cost of chicks per batch = ").append(txt_totalcostchicks)
				.append("<br>")
				
				.append("~Mortality Provision ^")
				.append("~Brooding % of Mortality = ").append(txt_broodingmor)
				.append("~Growing % of Mortality = ").append(txt_growingmor)
				.append("~Laying % of Mortality = ").append(txt_layingmor)
				.append("~Total = ").append(Helper.correctNull((String)hshValues.get("txt_totalmor")))
				.append("<br>")
				
				.append("~Feeding Expenses  ^")
				.append("~Chick Mash cost per kg(Rs.) = ").append(txt_costchickmash)
				.append("~Chick Mash consumption of feed/bird(Kgs) = ").append(txt_conchickmash).append("(During Brooding Period)")
				.append("~Chick Mash Total Cost of Consumption /batch(Rs.) = ").append(txt_totalchickmash)
				
				.append("~Grower Mash cost per kg(Rs.) = ").append(txt_costgrowermash)
				.append("~Grower Mash consumption of feed/bird(Kgs) = ").append(txt_congrowermash).append("(During Brooding Period)")
				.append("~Grower Mash Total Cost of Consumption /batch(Rs.) = ").append(txt_totalgrowermash)
				
				.append("~Layer Mash cost per kg(Rs.) = ").append(txt_costlayermash)
				.append("~Layer Mash consumption of feed/bird(Kgs) = ").append(txt_conlayermash)
				.append("~Layer Mash Total Cost of Consumption /batch(Rs.) = ").append(txt_totallayermash)
				.append("~Total Feed Consumption per bird upto Culling(Kgs) = ").append(Helper.correctNull((String)hshValues.get("txt_totalfeedcon")))
				.append("<br>")
				.append("~Expenditure on salaries/wages ^");
				
				for (int i = 0; i < txt_noperson.length; i++)
				{	
					if(!txt_noperson[i].equals(""))
					{
						sbAuditTrial
						.append("~")
						.append(strdesc[i])
						.append("~No.of Persons = ")
						.append(txt_noperson[i])
						.append("~Salary per month(Rs.) = ")
						.append(txt_salarypm[i])
						.append("~Total Salary(Rs.) = ")
						.append(txt_salarypy[i]);
					}	
				}	
				sbAuditTrial
				.append("<br>")
				.append("~Miscellaneous Expenses on charges: ^")
				.append("~Electricity = ")	.append(txt_electricitycharge).append("Rs. per month ^")
				.append("~Water Charges = ")	.append(txt_watercharge).append("Rs. per month ^")
				.append("~Veterinary Aid Expenses  = ")	.append(txt_vtaid).append("Rs. per Bird ^")
				.append("~Cost per batch Rs.  = ")	.append(txt_totalvtaid)
				.append("~Insurance Premium = ")	.append(txt_inspremium).append("Rs. per Bird ^")
				.append("~Cost per batch Rs.  = ")	.append(txt_totalinspremium)
				.append("~Transportation Charges = ")	.append(txt_transportcharge).append("Rs. per Batch ^");
				
				for (int j = 0; j<txt_exp.length; j++)
				{
					if(!txt_exp[j].equalsIgnoreCase(""))
					{
						sbAuditTrial
						.append("~Other Expenses = ");
						if(txt_exp[j].trim().equalsIgnoreCase(""))
						{
							txt_exp[j]="Nil";
						}
						sbAuditTrial.append(txt_exp[j])	
						.append("~per month(Rs.) = ");
						if(txt_iyear[j].trim().equalsIgnoreCase(""))
						{
							txt_iyear[j]="Nil";
						}
						sbAuditTrial.append(txt_iyear[j]);	
					}	
				}
				
				sbAuditTrial
				.append("~Average Yield of Eggs per bird(During Laying Period) = ").append(txt_yieldegg)
				.append("~Average sale price of eggs(Rs.) = ").append(txt_saleegg).append("/egg")
				.append("~Total sales realisation from eggs/batch(Rs.) = ").append(txt_totalsaleegg)
				.append("~Average sale price of culled birds(Rs.) = ").append(txt_saleculled).append("/bird")
				.append("~Total sales realisation rom culled birds/batch(Rs.) = ")	.append(txt_totsaleculled)
				.append("~Average yield of manure per bird = ")	.append(txt_yieldmanure).append("kgs")
				.append("~Average sale price of Manure(Rs.) = ")	.append(txt_salemanure).append("/tonne")
				.append("~Total sales realisation from Manure/batch(Rs.) = ")	.append(txt_totsalemanure)
				.append("~Sale Price of empty Gunny Bags(Rs.) = ")	.append(txt_salegunny).append("/bag");
				
				
				for (int l = 0; l<txt_src.length; l++)
				{
					if(!txt_src[l].equalsIgnoreCase(""))
					{	
						sbAuditTrial
						.append("~Other Sources of Income = ");
						if(txt_src[l].equalsIgnoreCase(""))
						{
							txt_src[l] = "NIL";
						}
						sbAuditTrial.append(txt_src[l])
						.append("~I year(Rs.) = ");
						if(txt_iyearsrc[l].equalsIgnoreCase(""))
						{
							txt_iyearsrc[l] = "0";
						}
						sbAuditTrial.append(txt_iyearsrc[l])
						.append("~II year(Rs.) = ");
						if(txt_iiyearsrc[l].equalsIgnoreCase(""))
						{
							txt_iiyearsrc[l] = "0";
						}
						sbAuditTrial.append(txt_iiyearsrc[l])
						.append("~III year(onwards)(Rs.) = ");
						if(txt_iiiyearsrc[l].equalsIgnoreCase(""))
						{
							txt_iiiyearsrc[l] = "0";
						}
						sbAuditTrial.append(txt_iiiyearsrc[l]);
					}	
				}
				if(correctNull((String)hshValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
				{
					hshValues.put("strAction", "update");
				}
				else
				{
					hshValues.put("strAction", "insert");
				}
			}
				AuditTrial.auditLog(hshValues,"245",appno,sbAuditTrial.toString());
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} 
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
			} 
			catch (Exception e1) 
			{
				throw new EJBException("Error in closing Connection "+ e1.getMessage());
			}
		}
		return hshResult;
	}
	//flow chart
	public HashMap getpoultryflowchartData(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;ResultSet rs2 = null;
		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}
		HashMap hshRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		ArrayList arryRow1 = new ArrayList();
		ArrayList arryCol1 = null;
		ArrayList arryRow2 = new ArrayList();
		ArrayList arryCol2 = null;
		ArrayList arryRow3 = new ArrayList();
		ArrayList arryCol3 = null;
		String appno=correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
	    String PageType=Helper.correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
        {
        	 PageType=Helper.correctNull((String)hshValues.get("hidpagetype"));
        }
        
        //Added By Zahoorunnisa.S for calculation automation
        double dblexpforyear[]=new double[8];
        
        ArrayList arrPurchase=new ArrayList();
		ArrayList arrChicksMash=new ArrayList();
		ArrayList arrGrowersMash=new ArrayList();
		ArrayList arrLayersMash=new ArrayList();
		ArrayList arrLabour=new ArrayList();
		ArrayList arrWater=new ArrayList();
		ArrayList arrElectric=new ArrayList();
		ArrayList arrVetriAid=new ArrayList();
		ArrayList arrInsurance=new ArrayList();
		ArrayList arrTransporation=new ArrayList();
		ArrayList arrTotalExpenses=new ArrayList();
		
        //end
		
		try 
		{
			/*strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}*/
		   
			strQuery = SQLParser.getSqlQuery("sel_poultry_expenses_poultrytype^" + appno+"^"+prd_type+"^E");
			rs = DBUtils.executeQuery(strQuery);
			
			double poultry_iyear=0.00;
			while (rs.next())
			{
				
				arryCol1 = new ArrayList();
				arryCol1.add(rs.getString("poultry_expenses"));
				poultry_iyear = Double.parseDouble((Helper.correctDouble((String)rs.getString("poultry_iyear"))));
				poultry_iyear =poultry_iyear*12;
				
				for(int i=0; i<8; i++){
				dblexpforyear[i]=dblexpforyear[i]+poultry_iyear;
				}
				
				arryCol1.add(Helper.formatDoubleValue(poultry_iyear));
				arryCol1.add(rs.getString("poultry_iyear"));
				arryCol1.add(rs.getString("poultry_iiyear"));
				arryCol1.add(rs.getString("poultry_iiiyear"));
				arryCol1.add(rs.getString("poultry_type"));
				arryRow1.add(arryCol1);
			}
			strQuery = SQLParser.getSqlQuery("sel_poultry_recurringdata^" + appno+"^"+prd_type);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(rs.getString("poultry_totalloanamount"));
				arryRow.add(arryCol);
			}
			
			
				
			rs=DBUtils.executeLAPSQuery("agr_selflockrep^"+appno);
			boolean bstate=rs.next();
			if(bstate)
			{
				rs.beforeFirst();
				arryCol2=new ArrayList();
				while (rs.next())
				{
					
					//arryCol2.add(rs.getString("sno"));
					arryCol2.add(rs.getString("agr_batch"));				
					//arryCol2.add(rs.getString("agr_broodermon"));
					//arryCol2.add(rs.getString("agr_growermon"));
					//arryCol2.add(rs.getString("agr_layermon"));
					//arryCol2.add(rs.getString("agr_culls"));
				 
					arryRow2.add(arryCol2);
				}
			}
			else
			{
				hshRecord.put("nodata","Y");
			}
			strQuery = SQLParser.getSqlQuery("agr_get_poultryfindata^"+appno+"^"+prd_type);
			rs1 = DBUtils.executeQuery(strQuery);
			
			double txt_watercharge=0.00;double txt_electricitycharge=0.00;
			
			String totalChicks="",
			vtaid="",inspremium="",transportcharge="",totalgrowermash="",totallayermash="",totalChicksmash="";
			
			if (rs1.next()) 
			{
				
				hshRecord.put("txt_nochicks", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_nochicks"))));
				hshRecord.put("txt_costchicks", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_costchicks"))));
				hshRecord.put("txt_costchickmash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_costchickmash"))));
				hshRecord.put("txt_conchickmash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_conchickmash"))));
				hshRecord.put("txt_costgrowermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_costgrowermash"))));
				hshRecord.put("txt_congrowermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_congrowermash"))));
				hshRecord.put("txt_costlayermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_costlayermash"))));
				hshRecord.put("txt_conlayermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_conlayermash"))));
				hshRecord.put("txt_broodingmor", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_broodingmor"))));
				hshRecord.put("txt_growingmor", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_growingmor"))));
				hshRecord.put("txt_layingmor", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_layingmor"))));
				hshRecord.put("txt_specify1", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_specify1"))));
				hshRecord.put("txt_specify2", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_specify2"))));
				
				txt_electricitycharge = txt_watercharge+ Double.parseDouble((Helper.correctDouble((String)rs1.getString("poultry_electricitycharge"))));
				txt_watercharge = txt_watercharge+ Double.parseDouble((Helper.correctDouble((String)rs1.getString("poultry_watercharge"))));
				
				hshRecord.put("txt_vtaid", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_vtaid"))));
				hshRecord.put("txt_inspremium", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_inspremium"))));
				hshRecord.put("txt_yieldegg", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_yieldegg"))));
				hshRecord.put("txt_saleegg", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_saleegg"))));
				hshRecord.put("txt_saleculled", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_saleculled"))));
				hshRecord.put("txt_yieldmanure", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_yieldmanure"))));
				hshRecord.put("txt_salemanure", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_salemanure"))));
				hshRecord.put("txt_salegunny", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_salegunny"))));
				hshRecord.put("txt_emptybag", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_emptybag"))));
				
				transportcharge=Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_transportcharge")));
				
				hshRecord.put("txt_transportcharge", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_transportcharge"))));
				
				totalChicks = Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalcostchicks")));
				
				hshRecord.put("txt_totalcostchicks",Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalcostchicks"))));
				
				totalChicksmash = Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalchickmash")));
				totalgrowermash =  Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalgrowermash")));
				totallayermash = Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totallayermash")));
				
				hshRecord.put("txt_totalchickmash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalchickmash"))));
				hshRecord.put("txt_totalgrowermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalgrowermash"))));
				hshRecord.put("txt_totallayermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totallayermash"))));
				
				vtaid = Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalvtaid")));
				inspremium=Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalinspremium")));
				
				hshRecord.put("txt_totalvtaid", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalvtaid"))));
				hshRecord.put("txt_totalinspremium", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalinspremium"))));
				hshRecord.put("txt_totalsaleegg", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalsaleegg"))));
				hshRecord.put("txt_totsaleculled", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totsaleculled"))));
				hshRecord.put("txt_totsalemanure", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totsalemanure"))));
				hshRecord.put("txt_totsalebag", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totsalebag"))));
				
			}
			strQuery = SQLParser.getSqlQuery("per_get_poultryfinperdata^" + appno+"^"+prd_type);
			rs = DBUtils.executeQuery(strQuery);
			double salarypy=0.00;//double noperson=0.00;
			while (rs.next())
			{
				arryCol3 = new ArrayList();
				arryCol3.add(appno);
				arryCol3.add(rs.getString("sno"));
				arryCol3.add(rs.getString("poultry_noperson"));
				arryCol3.add(rs.getString("poultry_salarypm"));
				arryCol3.add(rs.getString("poultry_salarypy"));
				salarypy=salarypy+Double.parseDouble((Helper.correctDouble((String)rs.getString("poultry_salarypy"))));
				arryRow3.add(arryCol3);
			}
			
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow1", arryRow1);
			txt_watercharge=txt_watercharge*12;
			txt_electricitycharge=txt_electricitycharge*12;
			salarypy=salarypy*12;
			hshRecord.put("salarypy",Helper.formatDoubleValue(salarypy));
			hshRecord.put("txt_watercharge",Helper.formatDoubleValue(txt_watercharge));
			hshRecord.put("txt_electricitycharge",Helper.formatDoubleValue(txt_electricitycharge));
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("arryRow2", arryRow2);
			hshRecord.put("PageType", PageType);
			strQuery = SQLParser.getSqlQuery("sel_poultry_recurring^" + appno+"^"+prd_type);
			rs = DBUtils.executeQuery(strQuery);
			ArrayList arryCol4 = new ArrayList();
			ArrayList arryRow4= new ArrayList();
			double poultry_unit=0.00;
			while (rs.next())
			{
				arryCol4 = new ArrayList();
				arryCol4.add(rs.getString("poultry_item"));
				poultry_unit=Double.parseDouble((Helper.correctDouble((String)rs.getString("poultry_unit"))));
				arryCol4.add(Helper.formatDoubleValue(poultry_unit));
				arryCol4.add(rs.getString("poultry_cost"));
				arryCol4.add(rs.getString("poultry_loan_amount"));
				
				arryRow4.add(arryCol4);
			}
			hshRecord.put("arryRow4", arryRow4);
			strQuery = SQLParser.getSqlQuery("agr_sel_poultry_labcharge^"+appno+"^"+prd_type);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) 
			{
				hshRecord.put("labourcharge", Helper.correctDoubleQuote(correctNull(rs1.getString("labcharge"))));
			}
			
			
			//Calculation added by Zahoorunnisa.S for Automation of this page. Instead of Edit/apply the page
			
			if(totalChicks.equals("")){totalChicks="0.00";}
			if(vtaid.equals("")){vtaid="0.00";}
			if(inspremium.equals("")){inspremium="0.00";}
			if(transportcharge.equals("")){transportcharge="0.00";}
			if(totalgrowermash.equals("")){totalgrowermash="0.00";}
			if(totallayermash.equals("")){totallayermash="0.00";}
			if(totalChicksmash.equals("")){totalChicksmash="0.00";}
			
			 arrPurchase=new ArrayList();
			 arrChicksMash=new ArrayList();
			 arrGrowersMash=new ArrayList();
			 arrLayersMash=new ArrayList();
			 arrLabour=new ArrayList();
			 arrWater=new ArrayList();
			 arrElectric=new ArrayList();
			 arrVetriAid=new ArrayList();
			 arrInsurance=new ArrayList();
			 arrTransporation=new ArrayList();
			
			if(arryCol2 != null){
			for(int i=0;i<arryCol2.size();i++)
			{
				//Purchase of Chicks
				dblexpforyear[i]=dblexpforyear[i]+(Double.parseDouble(totalChicks)*Double.parseDouble((String)arryCol2.get(i)));
				arrPurchase.add(Helper.formatDoubleValue((Double.parseDouble(totalChicks)*Double.parseDouble((String)arryCol2.get(i)))));
				
				//Feeding of chicks 
				dblexpforyear[i]=dblexpforyear[i]+(Double.parseDouble(totalChicksmash)*Double.parseDouble((String)arryCol2.get(i)));
				arrChicksMash.add(Helper.formatDoubleValue((Double.parseDouble(totalChicksmash)*Double.parseDouble((String)arryCol2.get(i)))));
				
				//Feeding of growers
				dblexpforyear[i]=dblexpforyear[i]+(Double.parseDouble(totalgrowermash)*Double.parseDouble((String)arryCol2.get(i)));
				arrGrowersMash.add(Helper.formatDoubleValue((Double.parseDouble(totalgrowermash)*Double.parseDouble((String)arryCol2.get(i)))));
				
				//Feeding of layers
				dblexpforyear[i]=dblexpforyear[i]+(Double.parseDouble(totallayermash)*Double.parseDouble((String)arryCol2.get(i)));
				arrLayersMash.add(Helper.formatDoubleValue((Double.parseDouble(totallayermash)*Double.parseDouble((String)arryCol2.get(i)))));
				
				//Labour charges 
				dblexpforyear[i]=dblexpforyear[i]+(salarypy);
				arrLabour.add(Helper.formatDoubleValue(salarypy));
				
				//Water charges
				dblexpforyear[i]=dblexpforyear[i]+(txt_watercharge);
				arrWater.add(Helper.formatDoubleValue(txt_watercharge));
				
				//Electricity charges
				dblexpforyear[i]=dblexpforyear[i]+(txt_electricitycharge);
				arrElectric.add(Helper.formatDoubleValue(txt_electricitycharge));
				
				//Veterinary aid
				dblexpforyear[i]=dblexpforyear[i]+(Double.parseDouble(vtaid)*Double.parseDouble((String)arryCol2.get(i)));
				arrVetriAid.add(Helper.formatDoubleValue((Double.parseDouble(vtaid)*Double.parseDouble((String)arryCol2.get(i)))));
				
				//Insurance of birds
				dblexpforyear[i]=dblexpforyear[i]+(Double.parseDouble(inspremium)*Double.parseDouble((String)arryCol2.get(i)));
				arrInsurance.add(Helper.formatDoubleValue((Double.parseDouble(inspremium)*Double.parseDouble((String)arryCol2.get(i)))));
				
				//Transportation charges
				
				dblexpforyear[i]=dblexpforyear[i]+(Double.parseDouble(transportcharge)*Double.parseDouble((String)arryCol2.get(i)));
				arrTransporation.add(Helper.formatDoubleValue((Double.parseDouble(transportcharge)*Double.parseDouble((String)arryCol2.get(i)))));
				
				
				arrTotalExpenses.add(Helper.formatDoubleValue(dblexpforyear[i]));
			
			} }else{
				
				 for(int i=0;i<8;i++){
					 
					 arrPurchase.add("0.00"); 
					 arrChicksMash.add("0.00"); 
					 arrGrowersMash.add("0.00"); 
					 arrLayersMash.add("0.00");
					 arrVetriAid.add("0.00"); 
					 arrInsurance.add("0.00");
					 arrTransporation.add("0.00");
					 arrTotalExpenses.add("0.00");
				 }
			 }
			
			hshRecord.put("arrPurchase",arrPurchase);
			hshRecord.put("arrChicksMash",arrChicksMash);
			hshRecord.put("arrGrowersMash",arrGrowersMash);
			hshRecord.put("arrLayersMash",arrLayersMash);
			hshRecord.put("arrLabour",arrLabour);
			hshRecord.put("arrWater",arrWater);
			hshRecord.put("arrElectric",arrElectric);
			hshRecord.put("arrVetriAid",arrVetriAid);
			hshRecord.put("arrInsurance",arrInsurance);
			hshRecord.put("arrTransporation",arrTransporation);
			hshRecord.put("arrTotalExpenses",arrTotalExpenses);
		
			
			if(arrTotalExpenses.size() > 0 || arrTotalExpenses!=null){
			HashMap hshQueryValues=new HashMap();
			HashMap hshQuery=new HashMap();
			ArrayList arrValues=new ArrayList();
		 	hshQueryValues.put("size","2");
			hshQuery.put("strQueryId","del_poultry_expenditure");
			arrValues.add(appno);
			arrValues.add(prd_type);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			
            hshQuery = new HashMap();
			arrValues = new ArrayList();
			arrValues.add(appno);
			arrValues.add(Helper.correctDouble((String)arrTotalExpenses.get(0)));
			arrValues.add(Helper.correctDouble((String)arrTotalExpenses.get(1)));
			arrValues.add(Helper.correctDouble((String)arrTotalExpenses.get(2)));
			arrValues.add(Helper.correctDouble((String)arrTotalExpenses.get(3)));
			arrValues.add(Helper.correctDouble((String)arrTotalExpenses.get(4)));
			arrValues.add(Helper.correctDouble((String)arrTotalExpenses.get(5)));
			arrValues.add(Helper.correctDouble((String)arrTotalExpenses.get(6)));
			arrValues.add(Helper.correctDouble((String)arrTotalExpenses.get(7)));
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add(prd_type);
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			hshQueryValues.put("size", "2");
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "ins_poultry_expenditure");
			hshQueryValues.put("2", hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}//End 
			
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
					rs = null;
				}
				 if (rs1 != null)
				    {
					rs1.close();
				    }
				 if (rs2 != null)
				    {
					rs2.close();
				    }
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}
//flow income

	public HashMap getpoultryincomeflowData(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;ResultSet rs2 = null;
		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}
		HashMap hshRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		ArrayList arryRow1 = new ArrayList();
		ArrayList arryCol1 = null;
		ArrayList arryRow2 = new ArrayList();
		ArrayList arryCol2 = null;
		String appno=correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
	    String PageType=Helper.correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
        {
        	 PageType=Helper.correctNull((String)hshValues.get("hidpagetype"));
        }
    	
		 //Added By Zahoorunnisa.S for calculation automation
        
        double dblincforyear[]=new double[8];
        
		ArrayList arrSaleeggs=new ArrayList();
		ArrayList arrSalebirds=new ArrayList();
		ArrayList arrSalemanure=new ArrayList();
		ArrayList arrSalebag=new ArrayList();
	
		ArrayList arryBrood=new ArrayList();
		ArrayList arrylayer=new ArrayList();
		ArrayList arryculls=new ArrayList();
		ArrayList arrygrowers=new ArrayList();
		
		ArrayList arrsurplus=new ArrayList();
		ArrayList arrexpenses=new ArrayList();
		ArrayList arrincome=new ArrayList();
       //end
		
		try 
		{
			/*strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}*/
		
			strQuery = SQLParser.getSqlQuery("sel_poultry_income^" + appno+"^"+prd_type);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				int i=0;
				arryCol1 = new ArrayList();
				
				dblincforyear[i]=dblincforyear[i]+ Double.parseDouble(rs.getString("poultry_iyear"));
				i++;
				dblincforyear[i]=dblincforyear[i]+ Double.parseDouble(rs.getString("poultry_iiyear"));
				i++;
				
				for(; i<8; i++){
					dblincforyear[i]=dblincforyear[i]+ Double.parseDouble(rs.getString("poultry_iiiyear"));
				}
				
				arryCol1.add(rs.getString("poultry_expenses"));
				arryCol1.add(rs.getString("poultry_iyear"));
				arryCol1.add(rs.getString("poultry_iiyear"));
				arryCol1.add(rs.getString("poultry_iiiyear"));
				arryCol1.add(rs.getString("poultry_type"));
				arryRow1.add(arryCol1);
			}
			strQuery = SQLParser.getSqlQuery("sel_poultry_recurringdata^" + appno+"^"+prd_type);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(rs.getString("poultry_loanamount"));
				arryRow.add(arryCol);
			}
			rs=DBUtils.executeLAPSQuery("agr_selflockrep^"+appno);		
			boolean bstate=rs.next();
			if(bstate)
			{
				rs.beforeFirst();
				while (rs.next())
				{
					arryCol2=new ArrayList();
					//arryCol2.add(rs.getString("sno"));
					
					arryCol2.add(Helper.correctDouble(rs.getString("agr_batch")));
					arryBrood.add(Helper.correctDouble(rs.getString("agr_broodermon")));
					arrygrowers.add(Helper.correctDouble(rs.getString("agr_growermon")));
					arrylayer.add(Helper.correctDouble(rs.getString("agr_layermon")));
					arryculls.add(Helper.correctDouble(rs.getString("agr_culls")));
					arryRow2.add(arryCol2);
				}
			}
			else
			{
				hshRecord.put("nodata","Y");
			}
			
				
                for(int i=0;i<8;i++){
                	
                	if(arryBrood.size() < 0){	 
                	arryBrood.add("0.00");
                	}
                	
                	if(arrygrowers.size() < 0){	 
                		arrygrowers.add("0.00"); 
                	}
                	
                	if(arrylayer.size() < 0){	 
                		arrylayer.add("0.00"); 
                	}
                	
                	if(arryculls.size() < 0){	 
                		arryculls.add("0.00"); 
                	}
					
				 }
			
			
			strQuery = SQLParser.getSqlQuery("agr_get_poultryfindata^"+appno+"^"+prd_type);
			rs1 = DBUtils.executeQuery(strQuery);
			double txt_watercharge=0.00;double txt_electricitycharge=0.00;
			
			String totsalesegg="", totsalebirds="", totsalemanure="", totsalebag="";
			String strbrood="", strchicksno="", strgrowing="", strbroodprev="", strlayer="";
			String strgrowingprev="";
			
			if (rs1.next()) 
			{
				hshRecord.put("txt_nochicks", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_nochicks"))));
				hshRecord.put("txt_costchicks", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_costchicks"))));
				hshRecord.put("txt_costchickmash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_costchickmash"))));
				hshRecord.put("txt_conchickmash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_conchickmash"))));
				hshRecord.put("txt_costgrowermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_costgrowermash"))));
				hshRecord.put("txt_congrowermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_congrowermash"))));
				hshRecord.put("txt_costlayermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_costlayermash"))));
				hshRecord.put("txt_conlayermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_conlayermash"))));
				
				strbrood = Helper.correctDouble(correctNull(rs1.getString("poultry_broodingmor")));
				strchicksno = Helper.correctDouble(correctNull(rs1.getString("poultry_nochicks")));
				
				strgrowing = Helper.correctDouble(correctNull(rs1.getString("poultry_growingmor")));
				strbroodprev = Helper.formatDoubleValue(Math.round((Double.parseDouble(strchicksno) 
						             - ((Double.parseDouble(strbrood)/100)*(Double.parseDouble(strchicksno))))));
				
				strlayer = Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_layingmor")));
				strgrowingprev = Helper.formatDoubleValue(Math.round((Double.parseDouble(strbroodprev) 
			                            - ((Double.parseDouble(strgrowing)/100)*(Double.parseDouble(strbroodprev))))));
				
				hshRecord.put("txt_broodingmor", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_broodingmor"))));
				hshRecord.put("txt_growingmor", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_growingmor"))));
				hshRecord.put("txt_layingmor", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_layingmor"))));
				hshRecord.put("txt_specify1", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_specify1"))));
				hshRecord.put("txt_specify2", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_specify2"))));
				txt_electricitycharge = txt_watercharge+ Double.parseDouble((Helper.correctDouble((String)rs1.getString("poultry_electricitycharge"))));
				txt_watercharge = txt_watercharge+ Double.parseDouble((Helper.correctDouble((String)rs1.getString("poultry_watercharge"))));
				hshRecord.put("txt_vtaid", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_vtaid"))));
				hshRecord.put("txt_inspremium", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_inspremium"))));
				hshRecord.put("txt_yieldegg", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_yieldegg"))));
				hshRecord.put("txt_saleegg", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_saleegg"))));
				hshRecord.put("txt_saleculled", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_saleculled"))));
				hshRecord.put("txt_yieldmanure", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_yieldmanure"))));
				hshRecord.put("txt_salemanure", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_salemanure"))));
				hshRecord.put("txt_salegunny", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_salegunny"))));
				hshRecord.put("txt_emptybag", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_emptybag"))));
				hshRecord.put("txt_transportcharge", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_transportcharge"))));
				hshRecord.put("txt_totalcostchicks", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalcostchicks"))));
				hshRecord.put("txt_totalchickmash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalchickmash"))));
				hshRecord.put("txt_totalgrowermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalgrowermash"))));
				hshRecord.put("txt_totallayermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totallayermash"))));
				hshRecord.put("txt_totalvtaid", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalvtaid"))));
				hshRecord.put("txt_totalinspremium", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalinspremium"))));
				
				totsalesegg = Helper.correctDouble(correctNull(rs1.getString("poultry_totalsaleegg")));
				totsalebirds =  Helper.correctDouble(correctNull(rs1.getString("poultry_totsaleculled")));
				totsalemanure = Helper.correctDouble(correctNull(rs1.getString("poultry_totsalemanure")));
				totsalebag = Helper.correctDouble(correctNull(rs1.getString("poultry_salegunny")));
					
				hshRecord.put("txt_totalsaleegg", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalsaleegg"))));
				hshRecord.put("txt_totsaleculled", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totsaleculled"))));
				hshRecord.put("txt_totsalemanure", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totsalemanure"))));
				hshRecord.put("txt_totsalebag", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totsalebag"))));
				
			}
			
			strQuery = SQLParser.getSqlQuery("sel_poultry_expenditure^"+appno+"^"+prd_type);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) 
			{
				
				hshRecord.put("totiyearexpenses", Helper.correctDoubleQuote(correctNull(rs1.getString("totiyearexpenses"))));
				hshRecord.put("totiiyearexpenses", Helper.correctDoubleQuote(correctNull(rs1.getString("totiiyearexpenses"))));
				hshRecord.put("totiiiyearexpenses", Helper.correctDoubleQuote(correctNull(rs1.getString("totiiiyearexpenses"))));
				hshRecord.put("totivyearexpenses", Helper.correctDoubleQuote(correctNull(rs1.getString("totivyearexpenses"))));
				hshRecord.put("totvyearexpenses", Helper.correctDoubleQuote(correctNull(rs1.getString("totvyearexpenses"))));
				hshRecord.put("totviyearexpenses", Helper.correctDoubleQuote(correctNull(rs1.getString("totviyearexpenses"))));
				hshRecord.put("totviiyearexpenses", Helper.correctDoubleQuote(correctNull(rs1.getString("totviiyearexpenses"))));
				hshRecord.put("totviiiyearexpenses", Helper.correctDoubleQuote(correctNull(rs1.getString("totviiiyearexpenses"))));
				
				arrexpenses.add(Helper.correctDouble(rs1.getString("totiyearexpenses")));
				arrexpenses.add(Helper.correctDouble(rs1.getString("totiiyearexpenses")));
				arrexpenses.add(Helper.correctDouble(rs1.getString("totiiiyearexpenses")));
				arrexpenses.add(Helper.correctDouble(rs1.getString("totivyearexpenses")));
				arrexpenses.add(Helper.correctDouble(rs1.getString("totvyearexpenses")));
				arrexpenses.add(Helper.correctDouble(rs1.getString("totviyearexpenses")));
				arrexpenses.add(Helper.correctDouble(rs1.getString("totviiyearexpenses")));
				arrexpenses.add(Helper.correctDouble(rs1.getString("totviiiyearexpenses")));
			}
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow1", arryRow1);
			txt_watercharge=txt_watercharge*12;
			txt_electricitycharge=txt_electricitycharge*12;
			
			hshRecord.put("txt_watercharge",Helper.formatDoubleValue(txt_watercharge));
			hshRecord.put("txt_electricitycharge",Helper.formatDoubleValue(txt_electricitycharge));
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("arryRow2", arryRow2);
			hshRecord.put("PageType", PageType);
			
			//Added By Zahoorunnisa.S for automated calculation
			
			if(totsalesegg.equals("")){totsalesegg="0.00";}
			if(totsalebirds.equals("")){totsalebirds="0.00";}
			if(totsalemanure.equals("")){totsalemanure="0.00";}
			if(totsalebag.equals("")){totsalebag="0.00";}
			if(strbrood.equals("")){strbrood="0.00";}
			if(strchicksno.equals("")){strchicksno="0.00";}
			if(strgrowing.equals("")){strgrowing="0.00";}
			if(strbroodprev.equals("")){strbroodprev="0.00";}
			if(strlayer.equals("")){strlayer="0.00";}
			if(strgrowingprev.equals("")){strgrowingprev="0.00";}
			
			double dbla =0.00, dblb=0.00, dblc=0.00, dbltotalbags=0.00;
			
			 for(int i=0;i<8;i++) {
				 
				 dblincforyear[i]=dblincforyear[i]+((Double.parseDouble(totsalesegg)*Double.parseDouble((String)arrylayer.get(i))));
				 arrSaleeggs.add(Helper.formatDoubleValue((Double.parseDouble(totsalesegg)*Double.parseDouble((String)arrylayer.get(i)))));
				 
				 dblincforyear[i]=dblincforyear[i]+((Double.parseDouble(totsalebirds)*Double.parseDouble((String)arryculls.get(i))));
				 arrSalebirds.add(Helper.formatDoubleValue((Double.parseDouble(totsalebirds)*Double.parseDouble((String)arryculls.get(i)))));
				 
				 dblincforyear[i]=dblincforyear[i]+((Double.parseDouble(totsalemanure)*Double.parseDouble((String)arrygrowers.get(i))));
				 arrSalemanure.add(Helper.formatDoubleValue((Double.parseDouble(totsalemanure)*Double.parseDouble((String)arrygrowers.get(i)))));
				 
				 dbla = Double.parseDouble(strbrood) *  Double.parseDouble(strchicksno) * Double.parseDouble(Helper.correctDouble((String)arryBrood.get(i)));
				 dblb = Math.round(Double.parseDouble(strgrowing) *  Double.parseDouble(strbroodprev) * Double.parseDouble(Helper.correctDouble((String)arrygrowers.get(i))));
				 dblc = Math.round(Double.parseDouble(strlayer) *  Double.parseDouble(strgrowingprev) * Double.parseDouble(Helper.correctDouble((String)arrylayer.get(i))));
				 
				 dbltotalbags = (((dbla + dblb + dblc) / 100) * Double.parseDouble(totsalebag));
				 
				 dblincforyear[i]=dblincforyear[i]+(dbltotalbags);
				
				 arrSalebag.add(Helper.formatDoubleValue(dbltotalbags));
				 
				 
				 arrincome.add(Helper.formatDoubleValue(dblincforyear[i]));
				 arrsurplus.add(Helper.formatDoubleValue(dblincforyear[i] - Double.parseDouble((String)arrexpenses.get(i))));
			
			 }
			 
			    hshRecord.put("arrSaleeggs",arrSaleeggs);
			 	hshRecord.put("arrSalebirds",arrSalebirds);
				hshRecord.put("arrSalemanure",arrSalemanure);
				hshRecord.put("arrSalebag",arrSalebag);
				hshRecord.put("arrincome",arrincome);
				hshRecord.put("arrsurplus",arrsurplus);
				
				
				if(arrsurplus.size() > 0 || arrsurplus!=null){
					
					HashMap hshQueryValues=new HashMap();
					HashMap hshQuery=new HashMap();
					ArrayList arrValues=new ArrayList();
				 	hshQueryValues.put("size","2");
					hshQuery.put("strQueryId","del_poultry_income");
					arrValues.add(appno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(appno);
					arrValues.add(Helper.correctDouble((String)arrsurplus.get(0)));
					arrValues.add(Helper.correctDouble((String)arrsurplus.get(1)));
					arrValues.add(Helper.correctDouble((String)arrsurplus.get(2)));
					arrValues.add(Helper.correctDouble((String)arrsurplus.get(3)));
					arrValues.add(Helper.correctDouble((String)arrsurplus.get(4)));
					arrValues.add(Helper.correctDouble((String)arrsurplus.get(5)));
					arrValues.add(Helper.correctDouble((String)arrsurplus.get(6)));
					arrValues.add(Helper.correctDouble((String)arrsurplus.get(7)));
					
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "ins_poultry_income");
					hshQueryValues.put("2", hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

					}
				//End 
			
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
					rs = null;
				}
				 if (rs1 != null)
				    {
					rs1.close();
				    }
				 if (rs2 != null)
				    {
					rs2.close();
				    }
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}
//expenditure
	public void updatepoultryflowchartData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery =  new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=correctNull((String)hshValues.get("hidAction"));
		String appno=correctNull((String)hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("appno"));
		}
		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}
		try
		{			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","del_poultry_expenditure");
				arrValues.add(appno);
				arrValues.add(prd_type);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(correctNull((String) hshValues.get("txt_totiyearu")));
				arrValues.add(correctNull((String) hshValues.get("txt_totaliiyearu")));
				arrValues.add(correctNull((String) hshValues.get("txt_totaliiiyearu")));
				arrValues.add(correctNull((String) hshValues.get("txt_totalivyearu")));
				arrValues.add(correctNull((String) hshValues.get("txt_totalvyearu")));
				arrValues.add(correctNull((String) hshValues.get("txt_totalviyearu")));
				arrValues.add(correctNull((String) hshValues.get("txt_totalviiyearu")));
				arrValues.add(correctNull((String) hshValues.get("txt_totalviiiyearu")));
				arrValues.add(correctNull((String) hshValues.get("txt_totaliyearl")));
				arrValues.add(correctNull((String) hshValues.get("txt_totaliiyearl")));
				arrValues.add(correctNull((String) hshValues.get("txt_totaliiiyearl")));
				arrValues.add(correctNull((String) hshValues.get("txt_totaliyear2")));
				arrValues.add(correctNull((String) hshValues.get("txt_totaliiyear2")));
				arrValues.add(correctNull((String) hshValues.get("txt_totaliiiyear2")));
				
				
				arrValues.add(prd_type);
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "ins_poultry_expenditure");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_poultry_expenditure");
				arrValues.add(appno);
				arrValues.add(prd_type);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");  
			}			
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
	}
//income

	public void updatepoultryincomeflowData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery =  new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=correctNull((String)hshValues.get("hidAction"));
		String appno=correctNull((String)hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("appno"));
		}
		try
		{			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","del_poultry_income");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(correctNull((String) hshValues.get("txt_totaliyears")));
				arrValues.add(correctNull((String) hshValues.get("txt_totaliiyears")));
				arrValues.add(correctNull((String) hshValues.get("txt_totaliiiyears")));
				arrValues.add(correctNull((String) hshValues.get("txt_totalivyears")));
				arrValues.add(correctNull((String) hshValues.get("txt_totalvyears")));
				arrValues.add(correctNull((String) hshValues.get("txt_totalviyears")));
				arrValues.add(correctNull((String) hshValues.get("txt_totalviiyears")));
				arrValues.add(correctNull((String) hshValues.get("txt_totalviiiyears")));
				
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "ins_poultry_income");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_poultry_income");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");  
			}			
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
	}
	public void updatepoultrycashflow(HashMap hshRequestValues) 
	{
		String appno=correctNull((String)hshRequestValues.get("appno"));
		//String productType=Helper.correctNull((String)hshRequestValues.get("strProductType"));
        String prd_type = Helper.correctNull((String)hshRequestValues.get("strProductType"));
		//String txt_roi ="", txt_holiday="",sel_payment="",txt_installment="",txt_date="";
		//String txt_lastinstallment="";
		
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno=correctNull((String)hshRequestValues.get("strappno"));
		}
		HashMap hshQueryValues = new HashMap();
		HashMap hshQueryValues1 = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();		
		String[] loanamt = null;
		String[] intrate = null;
		String[] netinc = null;
		String[] principal = null;
		String[] netintamt = null;
		String[] outgoingamt = null;
		String[] surplusamt = null;
		String[] repayment = null;
		String[] txt_taxdedc = null;
		String[] txt_aftertax = null;
		String[] txt_depri = null;
		String[] txt_dscr = null;
		String strAction = Helper.correctNull((String)hshRequestValues.get("hidAction"));
		String rollNO[] = {"I","II","III","IV","V","VI","VII","VIII","IX","X","XI","XII"};
		ResultSet rs = null;
		int intUpdatesize = 0;
		try
		{		
			loanamt = (String[]) hshRequestValues.get("txt_loan");
			intrate = (String[])hshRequestValues.get("txt_int");
			netinc = (String[])hshRequestValues.get("txt_netinc");
			principal = (String[])hshRequestValues.get("txt_principal");
			netintamt = (String[])hshRequestValues.get("txt_netint");
			outgoingamt = (String[])hshRequestValues.get("txt_outgoing");
			surplusamt = (String[])hshRequestValues.get("txt_surplus");
			repayment = (String[])hshRequestValues.get("txt_repayment");
			txt_taxdedc = (String[])hshRequestValues.get("txt_taxdec");
			txt_aftertax = (String[])hshRequestValues.get("txt_aftertax");
			txt_depri= (String[])hshRequestValues.get("txt_depri");
			txt_dscr= (String[])hshRequestValues.get("txt_dscr");
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "1");
				hshQuery3.put("strQueryId", "del_poultrycashflow");
				arrValues3.add(appno);
				arrValues3.add(prd_type);
				hshQuery3.put("arrValues", arrValues3);
				hshQueryValues1.put("1", hshQuery3);
				hshQueryValues1.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
				
				intUpdatesize = 1;
				for (int i = 0; i < loanamt.length; i++)
				{
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_poultrycashflow");
					arrValues.add(appno);
					arrValues.add(Integer.toString(i+1));
					if(loanamt[i].equalsIgnoreCase(""))
					{
						loanamt[i] = "0.00";
					}
					arrValues.add(loanamt[i]);
					if(intrate[i].equalsIgnoreCase(""))
					{
						intrate[i] = "0.00";
					}
					arrValues.add(intrate[i]);
					if(netinc[i].equalsIgnoreCase(""))
					{
						netinc[i] = "0.00";
					}
					arrValues.add(netinc[i]);
					if(principal[i].equalsIgnoreCase(""))
					{
						principal[i] = "0.00";
					}
					arrValues.add(principal[i]);
					if(netintamt[i].equalsIgnoreCase(""))
					{
						netintamt[i] = "0.00";
					}	
					arrValues.add(netintamt[i]);
					if(outgoingamt[i].equalsIgnoreCase(""))
					{
						outgoingamt[i] = "0.00";
					}
					arrValues.add(outgoingamt[i]);
					if(surplusamt[i].equalsIgnoreCase(""))
					{
						surplusamt[i] = "0.00";
					}
					     arrValues.add(surplusamt[i]);
								
						if(repayment[i].equalsIgnoreCase(""))
						{
							repayment[i]="0.00";
						}
						arrValues.add(repayment[i]);
						arrValues.add(prd_type);
						if(txt_taxdedc[i].equalsIgnoreCase(""))
						{
							txt_taxdedc[i]="0.00";
						}
						arrValues.add(txt_taxdedc[i]);
						if(txt_aftertax[i].equalsIgnoreCase(""))
						{
							txt_aftertax[i]="0.00";
						}
						arrValues.add(txt_aftertax[i]);
						if(txt_depri[i].equalsIgnoreCase(""))
						{
							txt_depri[i]="0.00";
						}
						arrValues.add(txt_depri[i]);
						if(txt_dscr[i].equalsIgnoreCase(""))
						{
							txt_dscr[i]="0.00";
						}
						arrValues.add(txt_dscr[i]);
					hshQuery.put("arrValues", arrValues);	
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
			}
          /*if(strAction1.equalsIgnoreCase("insert1"))
				
			{
        	    arrValues = new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","agr_del_bullockrepay");
				arrValues.add(appno);
				arrValues.add(prd_type);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				txt_roi= Helper.correctNull((String)hshRequestValues.get("txt_roi"));
				txt_holiday= Helper.correctNull((String)hshRequestValues.get("txt_holiday"));
				sel_payment= Helper.correctNull((String)hshRequestValues.get("sel_payment"));
				txt_installment = Helper.correctNull((String)hshRequestValues.get("txt_installment"));
				txt_date = Helper.correctNull((String)hshRequestValues.get("txt_date"));
				txt_lastinstallment= Helper.correctNull((String)hshRequestValues.get("txt_lastinstallment"));
				if(txt_roi.equalsIgnoreCase(""))
				{	
					txt_roi="0";
				}
				arrValues.add(txt_roi);
				
				if(txt_holiday.equalsIgnoreCase(""))
				{	
					txt_holiday="0";
				}
				arrValues.add(txt_holiday);
				
				if(sel_payment.equalsIgnoreCase(""))
				{	
					sel_payment ="1";
				}
				arrValues.add(sel_payment);
									
				if(txt_installment.equalsIgnoreCase(""))
				{	
					txt_installment="0.00";
				}
				arrValues.add(txt_installment);
				
				if(txt_date.equalsIgnoreCase(""))
				{	
					txt_date ="01/01/1900";
				}
				arrValues.add(txt_date);
				if(txt_lastinstallment.equalsIgnoreCase(""))
				{	
					txt_lastinstallment ="0.00";
				}
				arrValues.add(txt_lastinstallment);		
				arrValues.add(prd_type);
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agr_ins_bullockrepay");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			}*/
	
			if(strAction.equalsIgnoreCase("delete"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "1");
				hshQuery3.put("strQueryId", "del_poultrycashflow");
				arrValues3.add(appno);
				arrValues3.add(prd_type);
				hshQuery3.put("arrValues", arrValues3);
				hshQueryValues1.put("1", hshQuery3);
				hshQueryValues1.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			}
			/*if(strAction.equalsIgnoreCase("delete"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "1");
				hshQuery3.put("strQueryId", "agr_del_bullockrepay");
				arrValues3.add(appno);
				arrValues3.add(prd_type);
				hshQuery3.put("arrValues", arrValues3);
				hshQueryValues1.put("1", hshQuery3);
				hshQueryValues1.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			}*/
			
			if(!(strAction.equalsIgnoreCase("cancel")))
			{
				StringBuilder sbAuditTrial=new StringBuilder();
				
				sbAuditTrial.append("~Cash Flow ^");
				
				for (int i = 0; i < loanamt.length; i++)
				{	
					
					sbAuditTrial.append("~Loan At the Beginning ").append(rollNO[i]+" year = ").append(correctNull(loanamt[i]))
					.append("~Interest ").append(correctNull((String)hshRequestValues.get("txt_roi"))+" ").append(rollNO[i]+"  year [%] = ").append(correctNull(intrate[i]))
					.append("~Gross Income (G)").append(rollNO[i]+"  year = ").append(correctNull(netinc[i]))
					.append("~Repayment Principal(A) ").append(rollNO[i]+"  year = ").append(correctNull(principal[i]))
					.append("~Repayment Interest(B) ").append(rollNO[i]+"  year = ").append(correctNull(netintamt[i]))
					.append("~Repayment to Other loans(C) ").append(rollNO[i]+"  year = ").append(correctNull(repayment[i]))
					.append("~Total Repay(A+B+C=D) ").append(rollNO[i]+"  year = ").append(correctNull(outgoingamt[i]))
					.append("~Surplus(G-D) ").append(rollNO[i]+"  year = ").append(correctNull(surplusamt[i]))
					.append("~Tax Deduction (T) ").append(rollNO[i]+"  year = ").append(correctNull(txt_taxdedc[i]))
					.append("~Net Profit after tax(G-D-T=I) ").append(rollNO[i]+"  year = ").append(correctNull(txt_aftertax[i]))
					.append("~Depreciation(D1) ").append(rollNO[i]+"  year = ").append(correctNull(txt_depri[i]))
					.append("~DSCR(I+D1+B)/(A+B) ").append(rollNO[i]+"  year = ").append(correctNull(txt_dscr[i]));
				}	
				
					AuditTrial.auditLog(hshRequestValues,"251",appno,sbAuditTrial.toString());
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

	public  HashMap getpoultrycashflow(HashMap hshValues) 
	{
		ResultSet rs = null;
		ResultSet rs1 = null;
		String strQuery = "";
		HashMap hshRecord = new HashMap();
		HashMap hshTotal = new HashMap();
		ArrayList vecRow = new ArrayList();
		ArrayList vecData = new ArrayList();
		boolean bstate =true;
		
		String prd_type =correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type =correctNull((String)hshValues.get("prd_type"));
		}
		
		try
		{
			String appno	= correctNull((String )hshValues.get("appno"));	
			//String appno1 = correctNull((String)hshValues.get("appno1"));
			/*if(appno.equalsIgnoreCase(""))
			{
				appno=appno1;
			}*/	
			if(appno.equalsIgnoreCase(""))
			{
				appno =correctNull((String)hshValues.get("strappno"));
			}
			
				
			strQuery = SQLParser.getSqlQuery("sel_poultrycashflow^" + appno+"^"+prd_type);
			rs = DBUtils.executeQuery(strQuery);
			rs1 = DBUtils.executeQuery(strQuery);
			bstate = rs1.next();
			if(bstate == true)
			{
				while(rs.next())
				{
					vecRow = new ArrayList();
					vecRow.add(Helper.correctNull((String)rs.getString("appno")));
					if(Helper.correctNull((String)rs.getString("loan_begin")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(Helper.correctNull((String)rs.getString("loan_begin")));
					}
					if(Helper.correctNull((String)rs.getString("interest")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(Helper.correctNull((String)rs.getString("interest")));
					}
					if(Helper.correctNull((String)rs.getString("netincome")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(Helper.correctNull((String)rs.getString("netincome")));
					}
					if(Helper.correctNull((String)rs.getString("principalamt")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(Helper.correctNull((String)rs.getString("principalamt")));
					}
					if(Helper.correctNull((String)rs.getString("netintamt")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(Helper.correctNull((String)rs.getString("netintamt")));
					}
					if(Helper.correctNull((String)rs.getString("outgoingamt")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(Helper.correctNull((String)rs.getString("outgoingamt")));
					}
					if(Helper.correctNull((String)rs.getString("surplusamt")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(Helper.correctNull((String)rs.getString("surplusamt")));
					}
					if(Helper.correctNull((String)rs.getString("repayment")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(Helper.correctNull((String)rs.getString("repayment")));
					}
					if(Helper.correctNull((String)rs.getString("taxdedc")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(Helper.correctNull((String)rs.getString("taxdedc")));
					} 
					if(Helper.correctNull((String)rs.getString("netprofit")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(Helper.correctNull((String)rs.getString("netprofit")));
					}
					if(Helper.correctNull((String)rs.getString("depriciation")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(Helper.correctNull((String)rs.getString("depriciation")));
					}
					if(Helper.correctNull((String)rs.getString("dscr")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(Helper.correctNull((String)rs.getString("dscr")));
					}
					vecData.add(vecRow);
				}
			}
			else
			{
				for(int i=0; i<13; i++)
				{
					vecRow = new ArrayList();
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecData.add(vecRow);
				}
			}
			
			hshRecord.put("vecData", vecData);
			
			/* FOR BEE KEEPING(aK)
			 * Done By : Muralidharan
			 */ 
			if(prd_type.equalsIgnoreCase("aK"))
			{
				
				hshTotal=(HashMap)EJBInvoker.executeStateLess("agrcommon",hshValues,"getIncomeExpenseTotal");
				
				hshRecord.put("totiyearincome",correctNull((String)hshTotal.get("total1")));
				hshRecord.put("totiiyearincome",correctNull((String)hshTotal.get("total2")));
				hshRecord.put("totiiiyearincome",correctNull((String)hshTotal.get("total3")));
				hshRecord.put("totivyearincome",correctNull((String)hshTotal.get("total4")));
				hshRecord.put("totvyearincome",correctNull((String)hshTotal.get("total5")));
				hshRecord.put("totviyearincome",correctNull((String)hshTotal.get("total6")));
				hshRecord.put("totviiyearincome",correctNull((String)hshTotal.get("total7")));
				hshRecord.put("totviiiyearincome",correctNull((String)hshTotal.get("total8")));				
			}
			
			else 
			{			
				strQuery = SQLParser.getSqlQuery("sel_poultry_cashflow^" + appno);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					hshRecord.put("totiyearincome",correctNull(rs1.getString("totiyearincome")));
					hshRecord.put("totiiyearincome",correctNull(rs1.getString("totiiyearincome")));
					hshRecord.put("totiiiyearincome",correctNull(rs1.getString("totiiiyearincome")));
					hshRecord.put("totivyearincome",correctNull(rs1.getString("totivyearincome")));
					hshRecord.put("totvyearincome",correctNull(rs1.getString("totvyearincome")));
					hshRecord.put("totviyearincome",correctNull(rs1.getString("totviyearincome")));
					hshRecord.put("totviiyearincome",correctNull(rs1.getString("totviiyearincome")));
					hshRecord.put("totviiiyearincome",correctNull(rs1.getString("totviiiyearincome")));
				}
			}
			
			
		/*	strQuery = SQLParser.getSqlQuery("agr_sel_serieconomics^"+appno);			
			rs =DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("txt_totalincomeiyear",correctNull(rs.getString("agr_totalincomeiyear")));
				hshRecord.put("txt_totalincomeiiyear",correctNull(rs.getString("agr_totalincomeiiyear")));
			}
			*/
			if(rs1!=null)
			{
				rs1.close();
			}
			
			strQuery = SQLParser.getSqlQuery("getloanterms^" + appno);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				hshRecord.put("loan_recmdamt", Helper.correctDouble((String)rs1.getString("loan_recmdamt")));
				hshRecord.put("loan_modintrate", Helper.correctDouble((String)rs1.getString("loan_modintrate")));
			}
			
			
			hshRecord.put("appno",appno);			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getcoopsocMasterList "+ce.toString());
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
//sheep
	public void updatesheeptechdata(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery =  new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=correctNull((String)hshValues.get("hidAction"));
		String appno=correctNull((String)hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("appno"));
		}
		try
		{			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","agr_del_sheeptechdata");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				String sel_animal=Helper.correctNull((String) hshValues.get("sel_animal"));
				if(sel_animal.equalsIgnoreCase(""))
				{
					sel_animal="0";
				}
				arrValues.add(sel_animal);	
				arrValues.add(correctNull((String) hshValues.get("txt_breed")));
				arrValues.add(correctNull((String) hshValues.get("txt_agem")));
				arrValues.add(correctNull((String) hshValues.get("txt_maleno")));
				arrValues.add(correctNull((String) hshValues.get("txt_malecost")));
				arrValues.add(correctNull((String) hshValues.get("txt_maleamount")));
				arrValues.add(correctNull((String) hshValues.get("txt_agef")));
				arrValues.add(correctNull((String) hshValues.get("txt_femaleno")));
				arrValues.add(correctNull((String) hshValues.get("txt_femalecost")));
			    arrValues.add(correctNull((String) hshValues.get("txt_femaleamount")));
			    arrValues.add(correctNull((String) hshValues.get("txt_totalanimalno")));
				arrValues.add(correctNull((String) hshValues.get("txt_totalanimalcost")));
				arrValues.add(correctNull((String) hshValues.get("txt_totalanimalamount")));
				arrValues.add(correctNull((String) hshValues.get("txt_marketplace")));
				arrValues.add(correctNull((String) hshValues.get("txt_marketdistance")));
				arrValues.add(correctNull((String) hshValues.get("txt_markettransport")));
				//arrValues.add(correctNull((String) hshValues.get("txt_markettranscost")));
				String txt_markettranscost=Helper.correctNull((String) hshValues.get("txt_markettranscost"));
				if(txt_markettranscost.equalsIgnoreCase(""))
				{
					txt_markettranscost="0";
				}
				arrValues.add(txt_markettranscost);	
				String sel_purchase=Helper.correctNull((String) hshValues.get("sel_purchase"));
				if(sel_purchase.equalsIgnoreCase(""))
				{
					sel_purchase="0";
				}
				arrValues.add(sel_purchase);	
				arrValues.add(correctNull((String) hshValues.get("txt_namepurcom")));
			    arrValues.add(correctNull((String) hshValues.get("txt_per")));
			    arrValues.add(correctNull((String) hshValues.get("txt_birth")));
				arrValues.add(correctNull((String) hshValues.get("txt_annualper")));
				arrValues.add(correctNull((String) hshValues.get("txt_annualpera")));
				String sel_flock=Helper.correctNull((String) hshValues.get("sel_flock"));
				if(sel_flock.equalsIgnoreCase(""))
				{
					sel_flock="0";
				}
				arrValues.add(sel_flock);	
				arrValues.add(correctNull((String) hshValues.get("txt_migrationpattern")));
				arrValues.add(correctNull((String) hshValues.get("txt_grazingpattern")));
				arrValues.add(correctNull((String) hshValues.get("txt_greenfodder")));
				arrValues.add(correctNull((String) hshValues.get("txt_vtaidplace")));
				arrValues.add(correctNull((String) hshValues.get("txt_distancefarm")));
			    arrValues.add(correctNull((String) hshValues.get("txt_woolplace")));
			    arrValues.add(correctNull((String) hshValues.get("txt_distancewool")));
			    String sel_care=Helper.correctNull((String) hshValues.get("sel_care"));
				if(sel_care.equalsIgnoreCase(""))
				{
					sel_care="0";
				}
				arrValues.add(sel_care);	
				arrValues.add(correctNull((String) hshValues.get("sheep_waterfac2")));
			    arrValues.add(correctNull((String) hshValues.get("sheep_elecfac")));
			    arrValues.add(correctNull((String) hshValues.get("txt_market")));
			    arrValues.add(correctNull((String) hshValues.get("txt_kids1")));
			    arrValues.add(correctNull((String) hshValues.get("txt_kids2")));
			    arrValues.add(correctNull((String) hshValues.get("txt_kids3")));
			    hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agr_ins_sheeptechdata");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_del_sheeptechdata");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");  
			}		
			
			
			StringBuilder sbAuditTrial=new StringBuilder();
			
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{
				sbAuditTrial
				
				.append("~Particulars of Animals = ").append(correctNull((String) hshValues.get("sel_animal_text")))
				.append("~Breed = ").append(correctNull((String) hshValues.get("txt_breed")))
				
				.append("~Type - Male ^ ")
				.append("~Age(Months) = ").append(correctNull((String) hshValues.get("txt_agem")))
				.append("~No. of Animals = ").append(correctNull((String) hshValues.get("txt_maleno")))
				.append("~Cost per Animal(Rs.) = ").append(correctNull((String) hshValues.get("txt_malecost")))
				.append("~Amount(Rs.) = ").append(correctNull((String) hshValues.get("txt_maleamount")))
				
				.append("~Type - Female = ")
				.append("~Age(Months) = ").append(correctNull((String) hshValues.get("txt_agef")))
				.append("~No. of Animals = ").append(correctNull((String) hshValues.get("txt_femaleno")))
				.append("~Cost per Animal(Rs.) = ").append(correctNull((String) hshValues.get("txt_femalecost")))
				.append("~Amount(Rs.) = ").append(correctNull((String) hshValues.get("txt_femaleamount")))
				
				.append("~Market where animals are proposed to be purchased ^")
				
				.append("~Place =  ").append(correctNull((String) hshValues.get("txt_marketplace")))
				.append("~Distance from the Farm =  ").append(correctNull((String) hshValues.get("txt_marketdistance")))
				.append("~Mode of Transport = ").append(correctNull((String) hshValues.get("txt_markettransport")))
				.append("~Cost of Transport per Animal(Rs.) = ").append(correctNull((String) hshValues.get("txt_markettranscost")))
				.append("~Purchased Through = ").append(correctNull((String) hshValues.get("sel_purchase_text")));
				if(correctNull((String) hshValues.get("sel_purchase")).equalsIgnoreCase("1"))
				{
				sbAuditTrial.append("~Name of purchase Committe = ").append(correctNull((String) hshValues.get("txt_namepurcom")));	
				}
				sbAuditTrial
				.append("~percentage of = ").append(correctNull((String) hshValues.get("txt_kids1"))).append(" ").append("is").append(" ").append(correctNull((String) hshValues.get("txt_per")))
				.append("~Male to Female ratio of = ").append(correctNull((String) hshValues.get("txt_kids2"))).append(" ").append("@ birth is").append(" ").append(correctNull((String) hshValues.get("txt_birth")))
				.append("~Annual Mortality Percentage of = ").append(correctNull((String) hshValues.get("txt_kids3"))).append(" ").append("is").append(" ").append(correctNull((String) hshValues.get("txt_annualper")))
				.append("~Annual Mortality Percentage in Adults is = ").append(correctNull((String) hshValues.get("txt_annualpera")))
				.append("~Whether the Flock is = ").append(correctNull((String) hshValues.get("sel_flock_text")));
				if(correctNull((String) hshValues.get("sel_flock")).equalsIgnoreCase("1"))
				{
					sbAuditTrial
				.append("~Indicate Migration Pattern = ").append(correctNull((String) hshValues.get("txt_migrationpattern")));
				}
				else if(correctNull((String) hshValues.get("sel_flock")).equalsIgnoreCase("2"))
				{
					sbAuditTrial
					.append("~Indicate Migration Pattern  = ").append(correctNull((String) hshValues.get("txt_grazingpattern")));
				}
				else if(correctNull((String) hshValues.get("sel_flock")).equalsIgnoreCase("3"))
				{
					sbAuditTrial
					.append("~Indicate Arrangement for supply of Green Fodder = ").append(correctNull((String) hshValues.get("txt_greenfodder")));
				}
				sbAuditTrial
				.append("~Veterinary aid available at Place  = ").append(correctNull((String) hshValues.get("txt_vtaidplace")))
				.append("~Distance From Farm  = ").append(correctNull((String) hshValues.get("txt_distancefarm")))
				.append("~Marketing of Animals/By Products Place  = ").append(correctNull((String) hshValues.get("txt_woolplace")))  
				.append("~Distance From Farm  = ").append(correctNull((String) hshValues.get("txt_distancewool")))
				.append("~Water Facility available  = ").append(correctNull((String) hshValues.get("sheep_waterfac2"))) 
				.append("~Electricity available  = ").append(correctNull((String) hshValues.get("sheep_elecfac"))) 
				.append("~Who Will take care of the Animal  = ").append(correctNull((String) hshValues.get("sel_care_text"))) 
				.append("~Market Facility  = ").append(correctNull((String) hshValues.get("txt_market")));
				
				if(correctNull((String)hshValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
				{
					hshValues.put("strAction", "update");
				}
				else
				{
					hshValues.put("strAction", "insert");
				}
			
			}	
				AuditTrial.auditLog(hshValues,"228",appno,sbAuditTrial.toString());
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
	}

	public  HashMap getsheeptechdata(HashMap hshValues) 
	{		
		String strQuery="";
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		HashMap hshResult = new HashMap();	
		try
		{
			String appstatus=Helper.correctNull((String)hshValues.get("appstatus1"));
			hshResult.put("appstatus",appstatus);
			java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
			jtn.setGroupingUsed(false);
			String appno=correctNull((String)hshValues.get("strappno"));
			if(appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("appno"));
			}
			strQuery = SQLParser.getSqlQuery("agr_get_sheeptechdata^"+appno);			
			rs2 =DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				hshResult.put("sel_animal",correctNull(rs2.getString("sheep_animal")));
				hshResult.put("txt_breed",correctNull(rs2.getString("sheep_breed")));
				hshResult.put("txt_agem",correctNull(rs2.getString("sheep_agem")));
				hshResult.put("txt_maleno",correctNull(rs2.getString("sheep_maleno")));
				hshResult.put("txt_malecost",correctNull(rs2.getString("sheep_malecost")));
				hshResult.put("txt_maleamount",correctNull(rs2.getString("sheep_maleamount")));
				hshResult.put("txt_agef",correctNull(rs2.getString("sheep_agef")));
				hshResult.put("txt_femaleno",correctNull(rs2.getString("sheep_femaleno")));
				hshResult.put("txt_femalecost",correctNull(rs2.getString("sheep_femalecost")));
				hshResult.put("txt_femaleamount",correctNull(rs2.getString("sheep_femaleamount")));
				hshResult.put("txt_totalanimalno",correctNull(rs2.getString("sheep_totalanimalno")));
				hshResult.put("txt_totalanimalcost",correctNull(rs2.getString("sheep_totalanimalcost")));
				hshResult.put("txt_totalanimalamount",correctNull(rs2.getString("sheep_totalanimalamount")));
				hshResult.put("txt_marketplace",correctNull(rs2.getString("sheep_marketplace")));
				hshResult.put("txt_marketdistance",correctNull(rs2.getString("sheep_marketdistance")));
				hshResult.put("txt_markettransport",correctNull(rs2.getString("sheep_markettransport")));
				hshResult.put("txt_markettranscost",correctNull(rs2.getString("sheep_markettranscost")));
				hshResult.put("sel_purchase",correctNull(rs2.getString("sheep_purchase")));
				hshResult.put("txt_namepurcom",correctNull(rs2.getString("sheep_namepurcom")));
				hshResult.put("txt_per",correctNull(rs2.getString("sheep_per")));
				hshResult.put("txt_birth",correctNull(rs2.getString("sheep_birth")));
				hshResult.put("txt_annualper",correctNull(rs2.getString("sheep_annualper")));
				hshResult.put("txt_annualpera",correctNull(rs2.getString("sheep_annualpera")));
				hshResult.put("sel_flock",correctNull(rs2.getString("sheep_flock")));
				hshResult.put("txt_migrationpattern",correctNull(rs2.getString("sheep_migrationpattern")));
				hshResult.put("txt_grazingpattern",correctNull(rs2.getString("sheep_grazingpattern")));
				hshResult.put("txt_greenfodder",correctNull(rs2.getString("sheep_greenfodder")));
				hshResult.put("txt_vtaidplace",correctNull(rs2.getString("sheep_vtaidplace")));
				hshResult.put("txt_distancefarm",correctNull(rs2.getString("sheep_distancefarm")));
				hshResult.put("txt_woolplace",correctNull(rs2.getString("sheep_woolplace")));
				hshResult.put("txt_distancewool",correctNull(rs2.getString("sheep_distancewool")));
				hshResult.put("sel_care",correctNull(rs2.getString("sheep_care")));
				hshResult.put("sheep_waterfac",correctNull(rs2.getString("sheep_waterfac")));
				hshResult.put("sheep_elecfac",correctNull(rs2.getString("sheep_elecfac")));
				hshResult.put("sheep_marketfacility",correctNull(rs2.getString("sheep_marketfacility")));
				hshResult.put("sheep_kids1",correctNull(rs2.getString("sheep_kids1")));
				hshResult.put("sheep_kids2",correctNull(rs2.getString("sheep_kids2")));
				hshResult.put("sheep_kids3",correctNull(rs2.getString("sheep_kids3")));
				hshResult.put("auditFlag", "Y");
				
				
			}		    	
			return hshResult;
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData "+ce.toString());
		}
		finally
		{
			try
			{
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
	}
	//sheep eco data
	public HashMap getsheepecodata(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;ResultSet rs2 = null;
		HashMap hshRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		String appno=correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
	  String PageType=Helper.correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
        {
        	 PageType=Helper.correctNull((String)hshValues.get("hidpagetype"));
        }
        
		try 
		{
			/*strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}*/
			boolean flag = false;
			strQuery = SQLParser.getSqlQuery("agr_get_sheeptechdata^"+appno);			
			rs2 =DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				hshRecord.put("sel_animal",correctNull(rs2.getString("sheep_animal")));
				hshRecord.put("sheep_kids1",correctNull(rs2.getString("sheep_kids1")));
				hshRecord.put("sheep_kids2",correctNull(rs2.getString("sheep_kids2")));
				hshRecord.put("sheep_kids3",correctNull(rs2.getString("sheep_kids3")));
								
			}	
			strQuery = SQLParser.getSqlQuery("agr_get_sheepecodata^"+appno);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) 
			{
				hshRecord.put("txt_age", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_age"))));
				hshRecord.put("sel_kids", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_kids"))));
				hshRecord.put("txt_price", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_price"))));
				hshRecord.put("sel_sale", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_sale"))));
				hshRecord.put("txt_salemanure", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_salemanure"))));
				hshRecord.put("txt_fine", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_fine"))));
				hshRecord.put("txt_fineprice", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_fineprice"))));
				hshRecord.put("txt_medium", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_medium"))));
				hshRecord.put("txt_mediumprice", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_mediumprice"))));
				hshRecord.put("txt_coarse", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_coarse"))));
				hshRecord.put("txt_coarseprice", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_coarseprice"))));
				hshRecord.put("txt_vtaidprice", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_vtaidprice"))));
				hshRecord.put("txt_inspremium", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_inspremium"))));
				hshRecord.put("txt_employee", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_employee"))));
				hshRecord.put("txt_wageemployee", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_wageemployee"))));
				hshRecord.put("txt_transcost", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_transcost"))));
				hshRecord.put("txt_feedadult", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_feedadult"))));
				hshRecord.put("txt_feedadult1", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_feedadult1"))));
				hshRecord.put("txt_feedlamb", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_feedlamb"))));
				hshRecord.put("txt_feedlamb1", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_feedlamp1"))));
				hshRecord.put("txt_amount4", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_amountwool"))));
				
				hshRecord.put("txt_specify1", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_specify1"))));
				hshRecord.put("txt_specify2", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_specify2"))));
				hshRecord.put("txt_amountspec1", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_amountspec1"))));
				hshRecord.put("txt_amountspec2", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_amountspec2"))));
				hshRecord.put("txt_specify3", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_specify3"))));
				hshRecord.put("txt_specify4", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_specify4"))));
				hshRecord.put("txt_amountspec3", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_amountspec3"))));
				hshRecord.put("txt_amountspec4", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_amountspec4"))));
			
				hshRecord.put("sheep_othersale", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_othersale"))));
				hshRecord.put("sheep_elecexp", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_elecexp"))));
				hshRecord.put("sheep_maincharge", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_maincharge"))));
				flag = true;

			}
			
				 if (rs1 != null)
				    {
					rs1.close();
				    }
						 							 
			strQuery = SQLParser.getSqlQuery("agr_get_sheepequipdata^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(rs.getString("seqno"));
				arryCol.add(appno);
				arryCol.add(rs.getString("sno"));
				arryCol.add(rs.getString("sheep_particulars"));
				arryCol.add(rs.getString("sheep_units"));
				arryCol.add(rs.getString("sheep_cost"));
				arryCol.add(rs.getString("sheep_amount"));
				
				arryRow.add(arryCol);
				flag = true;
			}
			if(flag == true)
			{
				hshRecord.put("auditFlag", "Y");
			}
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("PageType", PageType);
			
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
					rs = null;
				}
				 if (rs1 != null)
				    {
					rs1.close();
				    }
				 if (rs2 != null)
				    {
					rs2.close();
				    }
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap updatesheepecodata(HashMap hshValues)  
	{
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		//HashMap hshQueryValues6 = new HashMap();
		HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshQuery5 = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strAction = null;		
		//String strAction1 = null;	
		//String strAction2 = null;	
		HashMap hshResult = new HashMap();
		HashMap hshQuery4 = new HashMap();
		int intUpdatesize = 0;
		int f = 0;
		String strid = "", strQuery1 = "";
		String appno=correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
		strAction = correctNull((String) hshValues.get("hidAction"));
		//strAction1 = correctNull((String) hshValues.get("hidAction1"));
		String sel_kids= correctNull((String) hshValues.get("sel_kids"));
		if(sel_kids.equalsIgnoreCase(""))
		{
			sel_kids="0";	
		}
		else
		{
			sel_kids= correctNull((String) hshValues.get("sel_kids"));
		}
		String sel_sale= correctNull((String) hshValues.get("sel_sale"));
		if(sel_sale.equalsIgnoreCase(""))
		{
			sel_sale="0";	
		}
		else
		{
			sel_sale= correctNull((String) hshValues.get("sel_sale"));
		}
		String txt_age = correctNull((String) hshValues.get("txt_age"));
		String  txt_price = correctNull((String) hshValues.get("txt_price"));
		if(txt_price.equalsIgnoreCase(""))
		{
			txt_price="0";	
		}
		else
		{
			txt_price= correctNull((String) hshValues.get("txt_price"));
		}
		String  txt_salemanure= correctNull((String) hshValues.get("txt_salemanure"));
		if(txt_salemanure.equalsIgnoreCase(""))
		{
			txt_salemanure="0";	
		}
		else
		{
			txt_salemanure= correctNull((String) hshValues.get("txt_salemanure"));
		}
		String txt_fine = correctNull((String) hshValues.get("txt_fine"));
		String txt_fineprice = correctNull((String) hshValues.get("txt_fineprice"));
		String txt_medium = correctNull((String) hshValues.get("txt_medium"));
		String  txt_mediumprice = correctNull((String) hshValues.get("txt_mediumprice"));
		String  txt_coarse= correctNull((String) hshValues.get("txt_coarse"));
		String  txt_coarseprice= correctNull((String) hshValues.get("txt_coarseprice"));
		String  txt_vtaidprice= correctNull((String) hshValues.get("txt_vtaidprice"));
		if(txt_vtaidprice.equalsIgnoreCase(""))
		{
			txt_vtaidprice="0";	
		}
		else
		{
			txt_vtaidprice= correctNull((String) hshValues.get("txt_vtaidprice"));
		}
		String  txt_inspremium= correctNull((String) hshValues.get("txt_inspremium"));
		if(txt_inspremium.equalsIgnoreCase(""))
		{
			txt_inspremium="0";	
		}
		else
		{
			txt_inspremium= correctNull((String) hshValues.get("txt_inspremium"));
		}
		String  txt_employee= correctNull((String) hshValues.get("txt_employee"));
		if(txt_employee.equalsIgnoreCase(""))
		{
			txt_employee="0";	
		}
		else
		{
			txt_employee= correctNull((String) hshValues.get("txt_employee"));
		}
		String  txt_wageemployee= correctNull((String) hshValues.get("txt_wageemployee"));
		if(txt_wageemployee.equalsIgnoreCase(""))
		{
			txt_wageemployee="0";	
		}
		else
		{
			txt_wageemployee= correctNull((String) hshValues.get("txt_wageemployee"));
		}
		String  txt_transcost = correctNull((String) hshValues.get("txt_transcost"));
		if( txt_transcost.equalsIgnoreCase(""))
		{
			 txt_transcost="0";	
		}
		else
		{
			 txt_transcost= correctNull((String) hshValues.get("txt_transcost"));
		}
		String  txt_feedadult= correctNull((String) hshValues.get("txt_feedadult"));
		if(txt_feedadult.equalsIgnoreCase(""))
		{
			txt_feedadult="0";	
		}
		else
		{
			txt_feedadult= correctNull((String) hshValues.get("txt_feedadult"));
		}
		
		String  txt_feedadult1= correctNull((String) hshValues.get("txt_feedadult1"));
		if(txt_feedadult1.equalsIgnoreCase(""))
		{
			txt_feedadult1="0";	
		}
		else
		{
			txt_feedadult1= correctNull((String) hshValues.get("txt_feedadult1"));
		}
		
		String  txt_feedlamb= correctNull((String) hshValues.get("txt_feedlamb"));
		if(txt_feedlamb.equalsIgnoreCase(""))
		{
			txt_feedlamb="0";	
		}
		else
		{
			txt_feedlamb= correctNull((String) hshValues.get("txt_feedlamb"));
		}
		
		String  txt_feedlamb1= correctNull((String) hshValues.get("txt_feedlamb1"));
		if(txt_feedlamb1.equalsIgnoreCase(""))
		{
			txt_feedlamb1="0";	
		}
		else
		{
			txt_feedlamb1= correctNull((String) hshValues.get("txt_feedlamb1"));
		}
		
		
		
		
		
		String  txt_amount4= correctNull((String) hshValues.get("txt_amount4"));
		if( txt_amount4.equalsIgnoreCase("NaN"))
		{
			 txt_amount4="0";	
		}
		else
		{
			txt_amount4= correctNull((String) hshValues.get("txt_amount4"));
		}
		String  txt_specify1= correctNull((String) hshValues.get("txt_specify1"));
		String  txt_specify2= correctNull((String) hshValues.get("txt_specify2"));
		String  txt_amountspec1= correctNull((String) hshValues.get("txt_amountspec1"));
		String  txt_amountspec2 = correctNull((String) hshValues.get("txt_amountspec2"));
		String  txt_specify3= correctNull((String) hshValues.get("txt_specify3"));
		String  txt_specify4= correctNull((String) hshValues.get("txt_specify4"));
		String  txt_amountspec3= correctNull((String) hshValues.get("txt_amountspec3"));
		String  txt_amountspec4= correctNull((String) hshValues.get("txt_amountspec4"));

		String  txt_specify5= correctNull((String) hshValues.get("txt_specify5"));
		String  txt_amountspec5= correctNull((String) hshValues.get("txt_amountspec5"));
		String  txt_specify6= correctNull((String) hshValues.get("txt_specify6"));
		String  txt_amountspec6= correctNull((String) hshValues.get("txt_amountspec6"));

		String  sheep_othersale= correctNull((String) hshValues.get("sheep_othersale"));
		if( sheep_othersale.equalsIgnoreCase("NaN"))
		{
			sheep_othersale="0";	
		}
		else
		{
			sheep_othersale= correctNull((String) hshValues.get("sheep_othersale"));
		}
		String  sheep_elecexp= correctNull((String) hshValues.get("sheep_elecexp"));
		if( sheep_elecexp.equalsIgnoreCase("NaN"))
		{
			sheep_elecexp="0";	
		}
		else
		{
			sheep_elecexp= correctNull((String) hshValues.get("sheep_elecexp"));
		}
		String  sheep_maincharge= correctNull((String) hshValues.get("sheep_maincharge"));
		if( sheep_maincharge.equalsIgnoreCase("NaN"))
		{
			sheep_maincharge="0";	
		}
		else
		{
			sheep_maincharge= correctNull((String) hshValues.get("sheep_maincharge"));
		}

		
		
		
		try 
		{
			java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			nf.setGroupingUsed(false);
			String[] txt_particulars = null;
			String[]txt_units = null;
			String[] txt_cost = null;
			String[] txt_amount= null;
		    txt_particulars= (String[]) hshValues.get("txt_particulars");
			txt_units= (String[]) hshValues.get("txt_units");
			txt_cost= (String[]) hshValues.get("txt_cost");
			strid = correctNull((String) hshValues.get("hid_sno"));
			txt_amount = (String[]) hshValues.get("txt_amount");
			/*strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshResult.put("applicantid", rs.getString("demo_appid"));
			}*/
			if (strAction.equals("delete"))
			{
				hshQuery4 = new HashMap();
				HashMap hshQueryValues4 = new HashMap();
				ArrayList arrValues4 = new ArrayList();
				hshQueryValues4.put("size", "1");
				hshQuery4.put("strQueryId", "agr_del_sheepecodata");
				arrValues4.add(appno);
				hshQuery4.put("arrValues", arrValues4);
				hshQueryValues4.put("1", hshQuery4);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
			}
			if (strAction.equals("delete"))
			{
				hshQuery5 = new HashMap();
				HashMap hshQueryValues5 = new HashMap();
				ArrayList arrValues5 = new ArrayList();
				hshQueryValues5.put("size", "1");
				hshQuery5.put("strQueryId", "agr_del_sheepequipdata");
				arrValues5.add(appno);
				hshQuery5.put("arrValues", arrValues5);
				hshQueryValues5.put("1", hshQuery5);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues5,"updateData");
			}
		
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQuery= new HashMap();
				 arrValues = new ArrayList();
				hshQuery.put("size", "2");
				hshQuery.put("strQueryId", "agr_del_sheepecodata");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);	
				hshQueryValues.put("1",hshQuery);
				hshQuery= new HashMap();
				arrValues = new ArrayList();
				
				arrValues.add(appno);
				arrValues.add(txt_age);
				arrValues.add(sel_kids);
				arrValues.add(txt_price);
				arrValues.add(sel_sale);
				arrValues.add(txt_salemanure);
				arrValues.add(txt_fine);
				arrValues.add(txt_fineprice);
				arrValues.add(txt_medium);
				arrValues.add(txt_mediumprice);
				arrValues.add(txt_coarse);
				arrValues.add(txt_coarseprice);
				arrValues.add(txt_vtaidprice);
				arrValues.add(txt_inspremium);
				arrValues.add(txt_employee);
				arrValues.add(txt_wageemployee);
				arrValues.add(txt_transcost);
				arrValues.add(txt_feedadult);
				arrValues.add(txt_feedadult1);
				arrValues.add(txt_feedlamb);
				arrValues.add(txt_feedlamb1);
				arrValues.add(txt_amount4);
				arrValues.add(txt_specify1);
				arrValues.add(txt_specify2);
				arrValues.add(txt_amountspec1);
				arrValues.add(txt_amountspec2);
				arrValues.add(txt_specify3);
				arrValues.add(txt_specify4);
				arrValues.add(txt_amountspec3);
				arrValues.add(txt_amountspec4);
				arrValues.add(txt_specify5);
				arrValues.add(txt_amountspec5);
				arrValues.add(txt_specify6);
				arrValues.add(txt_amountspec6);
				arrValues.add(sheep_othersale);
				arrValues.add(sheep_elecexp);
				arrValues.add(sheep_maincharge);

				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agr_ins_sheepecodata");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			if (strAction.equalsIgnoreCase("insert"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "2");
				hshQuery3.put("strQueryId", "agr_del_sheepequipdata");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				strQuery1 = SQLParser.getSqlQuery("sel_maxid_sheepequipdata");
				rs = DBUtils.executeQuery(strQuery1);
				if (rs.next())
				{
					strid = correctNull((String) rs.getString("maxid"));
					f = Integer.parseInt(strid);
				}
				intUpdatesize = 1;

				for (int i = 0; i < txt_particulars.length; i++)
				{					
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "agr_ins_sheepequipdata");
					arrValues.add(Integer.toString(f));
					arrValues.add(appno);
					arrValues.add(new Integer(i + 1).toString());
					
					
					if (correctNull( txt_particulars[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_particulars[i]));
					}
					if (correctNull(txt_units[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_units[i]));
					}
					if (correctNull(txt_cost[i]).equals("")) 
					{
						arrValues.add("");
					}
					else 
					{
						arrValues.add(correctNull(txt_cost[i]));
					}
					if (correctNull(txt_amount[i]).equals(""))
					{
						arrValues.add("");
					} 
					else
					{
						arrValues.add(correctNull(txt_amount[i]));
					}
					
					
				
					hshQuery.put("arrValues", arrValues);
					f = f + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);					
				}
				hshQueryValues.put("1", hshQuery3);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			hshpasValues.put("appno", appno);
			hshResult = getsheepecodata(hshpasValues);
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{
			sbAuditTrial
			.append("~Age at which ^")
			.append(Helper.correctNull((String)hshValues.get("txt_kids1")))
			.append(" ")
			.append("are sold ")
			.append(" ")
			.append(txt_age)
			.append(" ")
			.append("Months ^")
			.append("~Sale of =")
			.append(Helper.correctNull((String)hshValues.get("txt_kids2")))
			.append(" ")
			.append(Helper.correctNull((String)hshValues.get("sel_kids_text")))
			.append("~Sale price of = ")
			.append(Helper.correctNull((String)hshValues.get("txt_kids3")))
			.append("  Rs. ")
			.append(Helper.correctNull((String)hshValues.get("txt_price")))
			.append(" each")
			.append("~Sale price of manure/income from penning = ")
			.append(Helper.correctNull((String)hshValues.get("sel_sale_text")))
			.append("  Rs. " +nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_salemanure")))))
			.append("   per adult/year  ^")
			.append("~Sale of Wool / Hairs ^")
			
			
			.append("~Fine ^")
			.append("~kgs/Animal/year = ")
			.append(txt_fine)
			.append("~Rs. per Kg = ")
			.append(txt_fineprice)
			.append("~Amount(Rs.) = ")
			.append(Helper.correctNull((String)hshValues.get("txt_amount1")))
			
			.append("~Medium ^")
			.append("~kgs/Animal/year = ")
			.append(txt_medium)
			.append("~Rs. per Kg = ")
			.append(txt_mediumprice)
			.append("~kgs/Animal/year = ")
			.append(Helper.correctNull((String)hshValues.get("txt_amount2")))
			
			.append("~Coarse ^")
			.append("~kgs/Animal/year = ")
			.append(txt_coarse)
			.append("~Rs. per Kg = ")
			.append(txt_coarseprice)
			.append("~kgs/Animal/year = ")
			.append(Helper.correctNull((String)hshValues.get("txt_amount3")))
			
			.append("~Income from other sources ^")
			.append(Helper.correctNull((String)hshValues.get("txt_specify1")))
			.append("~Amount(Rs.) per year =")
			.append(txt_amountspec1)
			.append("~Income from other sources ^")
			.append(Helper.correctNull((String)hshValues.get("txt_specify2")))
			.append("~Amount(Rs.) per year =")
			.append(txt_amountspec2)
			
			.append("~Expenses on Veterinary Aid =")
			.append(" Rs." +txt_vtaidprice +" per adult animal/month")
			
			.append("~Insurance Premium  = ")
			.append(" Rs." +txt_inspremium +" per adult animal/month")
			
			.append("~Wages/salary per Employee ^")
			.append("~No. of Employee =")
			.append(Helper.correctNull((String)hshValues.get("txt_employee")))
			.append("~Wages/salary per employee Rs = " +txt_wageemployee +" per month")
			
			.append("~Electricity Expenses = ").append("Rs." + sheep_elecexp + " per month")
			.append("~Maintanence charge = ").append("Rs." + sheep_maincharge + " per month")
			
			.append("~Cost of Feeding ^ ")
			.append("~For Male Adults Rs = ")
			.append(txt_feedadult).append(" per Animal per Day ")
			
			.append("~For Female Adults Rs = ")
			.append(txt_feedadult1).append(" per Animal per Day ")
			
			
			.append("~For Male ")
			.append(Helper.correctNull((String)hshValues.get("txt_kids4"))).append("Rs. = ")
			.append(Helper.correctNull((String)hshValues.get("txt_feedlamb")))
			.append(" per Animal per Day  ")
			
			.append("~For Female ")
			.append(Helper.correctNull((String)hshValues.get("txt_kids41"))).append("Rs. = ")
			.append(Helper.correctNull((String)hshValues.get("txt_feedlamb1")))
			.append(" per Animal per Day  ")
			
			.append("~Other Expenses ^")
			.append("~"+Helper.correctNull((String)hshValues.get("txt_specify3")) +"=")
			.append("~Amount(Rs.) per month = ")
			.append(txt_amountspec3)
			.append("~"+Helper.correctNull((String)hshValues.get("txt_specify4")) +"=")
			.append("~Amount(Rs.) per month = ")
			.append(txt_amountspec4)
			
			.append("~Equipments ^");
			
			for (int i = 0; i < txt_particulars.length; i++)
			{					
				sbAuditTrial
				.append("~"+correctNull(txt_particulars[i]))
				.append("~No. of units = ")
				.append(correctNull(txt_units[i]))
				.append("~Cost per unit(Rs.) = ")
				.append(correctNull(txt_cost[i]))
				.append("~Amount(Rs.) = ")
				.append(correctNull(txt_amount[i]));
			}
			
			if(correctNull((String)hshValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
			{
				hshValues.put("strAction", "update");
			}
			}
			 AuditTrial.auditLog(hshValues,"229",appno,sbAuditTrial.toString());
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} 
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
			} 
			catch (Exception e1) 
			{
				throw new EJBException("Error in closing Connection "+ e1.getMessage());
			}
		}
		return hshResult;
	}
	//sheep income
	public HashMap getsheepincome(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;ResultSet rs2 = null;
		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}
		HashMap hshResult = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		
		//ArrayList arryRow2 = new ArrayList();
		//ArrayList arryCol2 = null;
		//ArrayList arryRow3 = new ArrayList();
		//ArrayList arryCol3 = null;
		String appno=correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
	    String PageType=Helper.correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
        {
        	 PageType=Helper.correctNull((String)hshValues.get("hidpagetype"));
        }
        
		try 
		{
			
			strQuery = SQLParser.getSqlQuery("agr_get_sheeptechdata^"+appno);			
			rs2 =DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				
				hshResult.put("sel_animal",correctNull(rs2.getString("sheep_animal")));
				hshResult.put("txt_breed",correctNull(rs2.getString("sheep_breed")));
				hshResult.put("txt_agem",correctNull(rs2.getString("sheep_agem")));
				hshResult.put("txt_maleno",correctNull(rs2.getString("sheep_maleno")));
				hshResult.put("txt_malecost",correctNull(rs2.getString("sheep_malecost")));
				hshResult.put("txt_maleamount",correctNull(rs2.getString("sheep_maleamount")));
				hshResult.put("txt_agef",correctNull(rs2.getString("sheep_agef")));
				hshResult.put("txt_femaleno",correctNull(rs2.getString("sheep_femaleno")));
				hshResult.put("txt_femalecost",correctNull(rs2.getString("sheep_femalecost")));
				hshResult.put("txt_femaleamount",correctNull(rs2.getString("sheep_femaleamount")));
				hshResult.put("txt_totalanimalno",correctNull(rs2.getString("sheep_totalanimalno")));
				hshResult.put("txt_totalanimalcost",correctNull(rs2.getString("sheep_totalanimalcost")));
				hshResult.put("txt_totalanimalamount",correctNull(rs2.getString("sheep_totalanimalamount")));
				hshResult.put("txt_marketplace",correctNull(rs2.getString("sheep_marketplace")));
				hshResult.put("txt_marketdistance",correctNull(rs2.getString("sheep_marketdistance")));
				hshResult.put("txt_markettransport",correctNull(rs2.getString("sheep_markettransport")));
				hshResult.put("txt_markettranscost",correctNull(rs2.getString("sheep_markettranscost")));
				hshResult.put("sel_purchase",correctNull(rs2.getString("sheep_purchase")));
				hshResult.put("txt_namepurcom",correctNull(rs2.getString("sheep_namepurcom")));
				hshResult.put("txt_per",correctNull(rs2.getString("sheep_per")));
				hshResult.put("txt_birth",correctNull(rs2.getString("sheep_birth")));
				hshResult.put("txt_annualper",correctNull(rs2.getString("sheep_annualper")));
				hshResult.put("txt_annualpera",correctNull(rs2.getString("sheep_annualpera")));
				hshResult.put("sel_flock",correctNull(rs2.getString("sheep_flock")));
				hshResult.put("txt_migrationpattern",correctNull(rs2.getString("sheep_migrationpattern")));
				hshResult.put("txt_grazingpattern",correctNull(rs2.getString("sheep_grazingpattern")));
				hshResult.put("txt_greenfodder",correctNull(rs2.getString("sheep_greenfodder")));
				hshResult.put("txt_vtaidplace",correctNull(rs2.getString("sheep_vtaidplace")));
				hshResult.put("txt_distancefarm",correctNull(rs2.getString("sheep_distancefarm")));
				hshResult.put("txt_woolplace",correctNull(rs2.getString("sheep_woolplace")));
				hshResult.put("txt_distancewool",correctNull(rs2.getString("sheep_distancewool")));
				hshResult.put("sel_care",correctNull(rs2.getString("sheep_care")));
				
				
			}	
			strQuery = SQLParser.getSqlQuery("sel_sheep_expenses^"+appno);			
			rs2 =DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				
				hshResult.put("totiyearexpenses",correctNull(rs2.getString("totiyearu")));
				hshResult.put("totiiyearexpenses",correctNull(rs2.getString("totiiyearu")));
				hshResult.put("totiiiyearexpenses",correctNull(rs2.getString("totiiiyearu")));
				hshResult.put("totivyearexpenses",correctNull(rs2.getString("totivyearu")));
				hshResult.put("totvyearexpenses",correctNull(rs2.getString("totvyearu")));
				hshResult.put("totviyearexpenses",correctNull(rs2.getString("totviyearu")));
				hshResult.put("totiyearu1",correctNull(rs2.getString("totiyearu1")));
				
				
			}	
			strQuery = SQLParser.getSqlQuery("agr_get_sheepecodata^"+appno);
			rs1 = DBUtils.executeQuery(strQuery);
			
			double salePrice=0.00, saleManure=0.00, totalSaleOfWool =0.00, calculateSalePrice=0.00, calculateSaleManure=0.00, calculatTotalSaleOfWool=0.00;
			
			if (rs1.next()) 
			{
				
				salePrice = Double.parseDouble(Helper.correctDouble(rs1.getString("sheep_price")));
				saleManure = Double.parseDouble(Helper.correctDouble(rs1.getString("sheep_salemanure")));
				
				// in econonomic data the value has not stored (ie) calculate total sale of wool / hairs
				
				totalSaleOfWool = Double.parseDouble(Helper.correctDouble(rs1.getString("sheep_fine"))) *  
				Double.parseDouble(Helper.correctDouble(rs1.getString("sheep_fineprice"))) + 
				Double.parseDouble(Helper.correctDouble(rs1.getString("sheep_medium"))) *
				Double.parseDouble(Helper.correctDouble(rs1.getString("sheep_mediumprice"))) +
				Double.parseDouble(Helper.correctDouble(rs1.getString("sheep_coarse"))) *
				Double.parseDouble(Helper.correctDouble(rs1.getString("sheep_coarseprice"))); 
				
				hshResult.put("txt_specify1", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_specify1"))));
				hshResult.put("txt_specify2", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_specify2"))));
				hshResult.put("txt_amountspec1", Helper.correctDouble(rs1.getString("sheep_amountspec1")));
				hshResult.put("txt_amountspec2", Helper.correctDouble(rs1.getString("sheep_amountspec2")));

			}
			
						 
			rs=DBUtils.executeLAPSQuery("agr_get_sheepflock^"+appno);			 
			while (rs.next())
			{
				//	this is calculation done by paul as per suresh guidance
				arryCol=new ArrayList();
				
				calculateSalePrice = salePrice * (Double.parseDouble(Helper.correctDouble(rs.getString("CULLSALE_MALEKID")))+Double.parseDouble(Helper.correctDouble(rs.getString("CULLSALE_FEMALEKID"))));
				calculatTotalSaleOfWool = totalSaleOfWool * (Double.parseDouble(Helper.correctDouble(rs.getString("OPENSTOCK_MALE")))+Double.parseDouble(Helper.correctDouble(rs.getString("OPENSTOCK_FEMALE")))); 
				calculateSaleManure = saleManure * (Double.parseDouble(Helper.correctDouble(rs.getString("OPENSTOCK_MALE")))+Double.parseDouble(Helper.correctDouble(rs.getString("OPENSTOCK_FEMALE"))));
				
				arryCol.add(""+calculateSalePrice);
				arryCol.add(""+calculatTotalSaleOfWool);
				arryCol.add(""+calculateSaleManure);
				arryRow.add(arryCol);
				
			}	
			
			hshResult.put("arryRow",arryRow);	
			hshResult.put("appno", appno);
			
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
					rs = null;
				}
				 if (rs1 != null)
				    {
					rs1.close();
				    }
				 if (rs2 != null)
				    {
					rs2.close();
				    }
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshResult;
	}
	public void updatesheepincome(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery =  new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=correctNull((String)hshValues.get("hidAction"));
		String appno=correctNull((String)hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("appno"));
		}
		ResultSet rs = null;
		try
		{	
			String[] txt_totaliyears = ((String[]) hshValues.get("txt_totaliyears"));
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","del_sheep_income");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				for(int i =0;i<txt_totaliyears.length;i++)
				{	
					arrValues.add(correctNull((String)txt_totaliyears[i]));
				}
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "ins_sheep_income");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_sheep_income");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
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
	//expenses
	public void updatesheepexpenses(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery =  new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=correctNull((String)hshValues.get("hidAction"));
		String appno=correctNull((String)hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("appno"));
		}
		ResultSet rs = null;
		try
		{	
			String[] totalYearValue = ((String[]) hshValues.get("txt_totaliyearu2"));
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","del_sheep_expenses");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				
				for(int i=0;i<totalYearValue.length;i++)
				{
					arrValues.add(correctNull((String) totalYearValue[i]));
					
				}
				arrValues.add(correctNull((String) hshValues.get("txt_totaliyearu1")));
				
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "ins_sheep_expenses");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_sheep_expenses");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
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
	//sheep expenses
	public HashMap getsheepexpenses(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		
		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}
		HashMap hshResult = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		
		String appno=correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
	    String PageType=Helper.correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
        {
        	 PageType=Helper.correctNull((String)hshValues.get("hidpagetype"));
        }
        
		try 
		{
			
						
			double dblMaleAdultFeedcost=0.00,dblFemaleAdultFeedcost=0.00,dblMaleLambFeedcost=0.00,dblFemaleLambFeedcost=0.00, 
			txt_vtaidprice=0.00,txt_inspremium=0.00,
			txt_employee=0.00,txt_wageemployee=0.00,sheep_elecexp=0.00,sheep_maincharge=0.00,
			txt_amountspec1=0.00,txt_amountspec2=0.00;
			
			double cal_feedadult=0.00,cal_feedadult1=0.00,cal_feedlamb=0.00,cal_feedlamb1=0.00,
			cal_vtaidprice=0.00,cal_inspremium=0.00,
			cal_employee=0.00,cal_elecexp=0.00,cal_maincharge=0.00,
			cal_amountspec1=0.00,cal_amountspec2=0.00;
			strQuery = SQLParser.getSqlQuery("agr_get_sheepecodata^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				dblMaleAdultFeedcost  = Double.parseDouble(Helper.correctDouble((rs.getString("sheep_feedadult"))));
				dblFemaleAdultFeedcost  = Double.parseDouble(Helper.correctDouble((rs.getString("sheep_feedadult1"))));
				dblMaleLambFeedcost =  Double.parseDouble(Helper.correctDouble((rs.getString("sheep_feedlamb"))));
				dblFemaleLambFeedcost = Double.parseDouble(Helper.correctDouble((rs.getString("sheep_feedlamp1"))));
				txt_vtaidprice = Double.parseDouble(Helper.correctDouble(rs.getString("sheep_vtaidprice")));
				txt_inspremium = Double.parseDouble(Helper.correctDouble(rs.getString("sheep_inspremium")));
				txt_employee = Double.parseDouble(Helper.correctDouble(rs.getString("sheep_employee")));
				txt_wageemployee = Double.parseDouble(Helper.correctDouble(rs.getString("sheep_wageemployee")));
				sheep_elecexp = Double.parseDouble(Helper.correctDouble(rs.getString("sheep_elecexp")));
				sheep_maincharge = Double.parseDouble((Helper.correctDouble(rs.getString("sheep_maincharge"))));
				txt_amountspec1 =  Double.parseDouble(Helper.correctDouble(rs.getString("sheep_amountspec3")));
				txt_amountspec2 = Double.parseDouble(Helper.correctDouble(rs.getString("sheep_amountspec4")));
				
				hshResult.put("txt_specify3",(correctNull(rs.getString("sheep_specify3"))));
				hshResult.put("txt_specify4",(correctNull(rs.getString("sheep_specify4"))));
				
				//this is calculation done by paul as per suresh guidance
				
				cal_employee =  txt_employee * txt_wageemployee * 12;
				cal_elecexp = sheep_elecexp * 12;
				cal_maincharge =  sheep_maincharge * 12;
				cal_amountspec1 = txt_amountspec1 * 12;
				cal_amountspec2 = txt_amountspec2 * 12;
				
			}
			
			hshResult.put("labour",""+cal_employee);
			hshResult.put("dblelectricity",""+cal_elecexp);
			hshResult.put("dblmaintain",""+cal_maincharge);
			hshResult.put("amountspec3",""+cal_amountspec1);
			hshResult.put("amountspec4",""+cal_amountspec2);
			
			rs=DBUtils.executeLAPSQuery("agr_get_sheepflock^"+appno);			 
			while (rs.next())
			{
				//	this is calculation done by paul as per suresh guidance
				arryCol=new ArrayList();
				// this for male adult
				cal_feedadult = dblMaleAdultFeedcost * Double.parseDouble(Helper.correctDouble(rs.getString("OPENSTOCK_MALE")))*365;

				cal_feedadult1 = dblFemaleAdultFeedcost * Double.parseDouble(Helper.correctDouble(rs.getString("OPENSTOCK_FEMALE")))*365;
				 
				cal_feedlamb =  dblMaleLambFeedcost * Double.parseDouble(Helper.correctDouble(rs.getString("OPENSTOCK_MALEKID")))*365;
				cal_feedlamb1  = dblFemaleLambFeedcost * Double.parseDouble(Helper.correctDouble(rs.getString("OPENSTOCK_FEMALEKID")))*365;
				
				cal_vtaidprice = txt_vtaidprice * (Double.parseDouble(Helper.correctDouble(rs.getString("OPENSTOCK_MALE"))) + Double.parseDouble(Helper.correctDouble(rs.getString("OPENSTOCK_FEMALE")))) * 12;
				cal_inspremium = txt_inspremium * (Double.parseDouble(Helper.correctDouble(rs.getString("OPENSTOCK_MALE"))) + Double.parseDouble(Helper.correctDouble(rs.getString("OPENSTOCK_FEMALE"))));
				
				
				arryCol.add(""+cal_feedadult);
				arryCol.add(""+cal_feedadult1);
				arryCol.add(""+cal_feedlamb);
				arryCol.add(""+cal_feedlamb1);
				arryCol.add(""+cal_vtaidprice);
				arryCol.add(""+cal_inspremium);
				
				
				arryRow.add(arryCol);
			}
			
			hshResult.put("arryRow",arryRow);	
			hshResult.put("appno", appno);
		
			rs=DBUtils.executeLAPSQuery("sel_sheep_expenses^"+appno);
			
			if(rs.next())
			{
				hshResult.put("capitalizedExpenses",correctNull(rs.getString("totiyearu1")));
			}
			
			
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
					rs = null;
				}
				 
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshResult;
	}
	//sheep flock
	public HashMap updateagrsheepflock(HashMap hshValues)  
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ResultSet rs = null;
		HashMap hshResult = new HashMap();
		String strAction="";		
		String strApplicationNo = correctNull((String) hshValues.get("strappno"));
		if(strApplicationNo.equalsIgnoreCase(""))
		{
			strApplicationNo = Helper.correctNull((String)hshValues.get("appno"));
		}
		 strAction = correctNull((String) hshValues.get("hidAction"));
	  	String []txt_ostock=null,txt_ostock2=null,txt_ostock3=null,txt_ostock4=null;
		String []txt_addlambs=null,txt_addlambs2=null,txt_addlambs3=null,txt_addlambs4=null;
		String []txt_mortalityadults=null,txt_mortalityadults2=null,txt_mortalityadults3=null,txt_mortalityadults4=null;
		String []txt_mortalitylambs=null,txt_mortalitylambs2=null,txt_mortalitylambs3=null,txt_mortalitylambs4=null;
		String []txt_clostock=null,txt_clostock2=null,txt_clostock3=null,txt_clostock4=null;
		String []txt_sale=null,txt_sale2=null,txt_sale3=null,txt_sale4=null;
		int intUpdatesize=0;
		try
		{
			strApplicationNo=correctNull((String)hshValues.get("strappno"));
			if(strApplicationNo.equalsIgnoreCase(""))
			{
				strApplicationNo = Helper.correctNull((String)hshValues.get("appno"));
			}
			txt_ostock=(String [])hshValues.get("txt_ostock");
			txt_ostock2=(String [])hshValues.get("txt_ostock2");
			txt_ostock3=(String [])hshValues.get("txt_ostock3");
			txt_ostock4=(String [])hshValues.get("txt_ostock4");
			
			txt_addlambs=(String [])hshValues.get("txt_addlambs");
			txt_addlambs2=(String [])hshValues.get("txt_addlambs2");
			txt_addlambs3=(String [])hshValues.get("txt_addlambs3");
			txt_addlambs4=(String [])hshValues.get("txt_addlambs4");
			
			txt_mortalityadults=(String [])hshValues.get("txt_mortalityadults");
			txt_mortalityadults2=(String [])hshValues.get("txt_mortalityadults2");
			txt_mortalityadults3=(String [])hshValues.get("txt_mortalityadults3");
			txt_mortalityadults4=(String [])hshValues.get("txt_mortalityadults4");
			
						
			txt_mortalitylambs=(String [])hshValues.get("txt_mortalitylambs");
			txt_mortalitylambs2=(String [])hshValues.get("txt_mortalitylambs2");
			txt_mortalitylambs3=(String [])hshValues.get("txt_mortalitylambs3");
			txt_mortalitylambs4=(String [])hshValues.get("txt_mortalitylambs4");
			
			
			
			
			txt_clostock=(String [])hshValues.get("txt_clostock");
			txt_clostock2=(String [])hshValues.get("txt_clostock2");
			txt_clostock3=(String [])hshValues.get("txt_clostock3");
			txt_clostock4=(String [])hshValues.get("txt_clostock4");
			
			txt_sale=(String [])hshValues.get("txt_sale");
			txt_sale2=(String [])hshValues.get("txt_sale2");
			txt_sale3=(String [])hshValues.get("txt_sale3");
			txt_sale4=(String [])hshValues.get("txt_sale4");
			
		
			
			ArrayList arrValues=new ArrayList();
			ArrayList  arrValues1=new ArrayList();
			if (strAction.equals("delete"))
			{
					hshQuery=new HashMap();
					arrValues1=new ArrayList();
					arrValues1.add(strApplicationNo);
					hshQuery.put("strQueryId","agr_del_sheepflock");
					hshQuery.put("arrValues", arrValues1);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			if (strAction.equals("insert"))
			{			
				hshQuery=new HashMap();
				arrValues1=new ArrayList();
				arrValues1.add(strApplicationNo);
				hshQuery.put("arrValues",arrValues1);
				hshQuery.put("strQueryId","agr_del_sheepflock");
				hshQueryValues.put("1",hshQuery);
				intUpdatesize=1;
				for(int i=0;i<txt_ostock.length;i++)
				{
						intUpdatesize=intUpdatesize+1;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","agr_ins_sheepflock");
						arrValues.add(strApplicationNo);
						arrValues.add(new Integer(i).toString());
						if(correctNull(txt_ostock[i]).equals(""))
						{
							arrValues.add("");
						}
						else
						{
							arrValues.add(correctNull(txt_ostock[i]));
						}
						if(correctNull(txt_ostock2[i]).equals(""))
						{
							arrValues.add("");
						}
						else
						{
							arrValues.add(correctNull(txt_ostock2[i]));
						}
						if(correctNull(txt_ostock3[i]).equals(""))
						{
							arrValues.add("");
						}
						else
						{
							arrValues.add(correctNull(txt_ostock3[i]));
						}
						if(correctNull(txt_ostock4[i]).equals(""))
						{
							arrValues.add("");
						}
						else
						{
							arrValues.add(correctNull(txt_ostock4[i]));
						}
						
						if(correctNull(txt_addlambs[i]).equals(""))
						{
							arrValues.add("");
						}
						else
						{
							arrValues.add(correctNull(txt_addlambs[i]));
						}
						if(correctNull(txt_addlambs2[i]).equals(""))
						{
							arrValues.add("");
						}
						else
						{
							arrValues.add(correctNull(txt_addlambs2[i]));
						}
						if(correctNull(txt_addlambs3[i]).equals(""))
						{
							arrValues.add("");
						}
						else
						{
							arrValues.add(correctNull(txt_addlambs3[i]));
						}
						if(correctNull(txt_addlambs4[i]).equals(""))
						{
							arrValues.add("");
						}
						else
						{
							arrValues.add(correctNull(txt_addlambs4[i]));
						}
						if(correctNull(txt_mortalityadults[i]).equals(""))
						{
							arrValues.add("");
						}
						else
						{
							arrValues.add(correctNull(txt_mortalityadults[i]));
						}
						if(correctNull(txt_mortalityadults2[i]).equals(""))
						{
							arrValues.add("");
						}
						else
						{
							arrValues.add(correctNull(txt_mortalityadults2[i]));
						}
						if(correctNull(txt_mortalityadults3[i]).equals(""))
						{
							arrValues.add("");
						}
						else
						{
							arrValues.add(correctNull(txt_mortalityadults3[i]));
						}
						if(correctNull(txt_mortalityadults4[i]).equals(""))
						{
							arrValues.add("");
						}
						else
						{
							arrValues.add(correctNull(txt_mortalityadults4[i]));
						}
						
						if(correctNull(txt_mortalitylambs[i]).equals(""))
						{
							arrValues.add("");
						}
						else
						{
							arrValues.add(correctNull(txt_mortalitylambs[i]));
						}
						if(correctNull(txt_mortalitylambs2[i]).equals(""))
						{
							arrValues.add("");
						}
						else
						{
							arrValues.add(correctNull(txt_mortalitylambs2[i]));
						}
						if(correctNull(txt_mortalitylambs3[i]).equals(""))
						{
							arrValues.add("");
						}
						else
						{
							arrValues.add(correctNull(txt_mortalitylambs3[i]));
						}
						if(correctNull(txt_mortalitylambs4[i]).equals(""))
						{
							arrValues.add("");
						}
						else
						{
							arrValues.add(correctNull(txt_mortalitylambs4[i]));
						}
						
						if(correctNull(txt_clostock[i]).equals(""))
						{
							arrValues.add("");
						}
						else
						{
							arrValues.add(correctNull(txt_clostock[i]));
						}
						if(correctNull(txt_clostock2[i]).equals(""))
						{
							arrValues.add("");
						}
						else
						{
							arrValues.add(correctNull(txt_clostock2[i]));
						}
						if(correctNull(txt_clostock3[i]).equals(""))
						{
							arrValues.add("");
						}
						else
						{
							arrValues.add(correctNull(txt_clostock3[i]));
						}
						if(correctNull(txt_clostock4[i]).equals(""))
						{
							arrValues.add("");
						}
						else
						{
							arrValues.add(correctNull(txt_clostock4[i]));
						}
						if(correctNull(txt_sale[i]).equals(""))
						{
							arrValues.add("");
						}
						else
						{
							arrValues.add(correctNull(txt_sale[i]));
						}
						if(correctNull(txt_sale2[i]).equals(""))
						{
							arrValues.add("");
						}
						else
						{
							arrValues.add(correctNull(txt_sale2[i]));
						}
						if(correctNull(txt_sale3[i]).equals(""))
						{
							arrValues.add("");
						}
						else
						{
							arrValues.add(correctNull(txt_sale3[i]));
						}
						if(correctNull(txt_sale4[i]).equals(""))
						{
							arrValues.add("");
						}
						else
						{
							arrValues.add(correctNull(txt_sale4[i]));
						}
						
						hshQuery.put("arrValues",arrValues);	
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);		
					
				}
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			} 
			 StringBuilder sbAuditTrial=new StringBuilder();
			 
			 if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			 {
			 for(int i=0;i<txt_ostock.length;i++)
				{
					 sbAuditTrial
					 .append("~Project Year = ")
					 .append((i+1))
					 .append(" Year ^")
					 .append("~OPENSTOCK (O) ^")
					.append("~MALE = ")
					.append(correctNull(txt_ostock[i]))
					.append("~FEMALE = ")
					.append(correctNull(txt_ostock2[i]))
					.append("~MALE lambs /kids /piglets = ")
					.append(correctNull(txt_ostock3[i]))
					.append("~FEMALE lambs /kids /piglets = ")
					.append(correctNull(txt_ostock4[i]))
					.append("~Lambing / Kidding / Pigletting (A) ^")
					.append("~MALE lambs /kids /piglets = ")
					.append(correctNull(txt_addlambs3[i]))
					.append("~FEMALE lambs /kids /piglets = ")
					.append(correctNull(txt_addlambs4[i]))
					.append("~MORTALITY (B) ^")
					.append("~FEMALE = ")
					.append(correctNull(txt_mortalityadults2[i]))
					.append("~MALE lambs /kids /piglets = ")
					.append(correctNull(txt_mortalityadults3[i]))
					.append("~FEMALE lambs /kids /piglets = ")
					.append(correctNull(txt_mortalityadults4[i]))
					.append("~CULLINGSALE (C) ^")
					.append("~MALE = ")
					.append(correctNull(txt_mortalitylambs[i]))
					.append("~FEMALE = ")
					.append(correctNull(txt_mortalitylambs2[i]))
					.append("~MALE lambs /kids /piglets = ")
					.append(correctNull(txt_mortalitylambs3[i]))
					.append("~FEMALE lambs /kids /piglets = ")
					.append(correctNull(txt_mortalitylambs4[i]))
					.append("~PURCHASE (D) ^")
					.append("~MALE = ")
					.append(correctNull(txt_clostock[i]))
					.append("~FEMALE = ")
					.append(correctNull(txt_clostock2[i]))
					.append("~Closing stock(O+A-B-C+D) ^")
					.append("~MALE = ")
					.append(correctNull(txt_sale[i]))
					.append("~FEMALE = ")
					.append(correctNull(txt_sale2[i]))
					.append("~MALE lambs /kids /piglets = ")
					.append(correctNull(txt_sale3[i]))
					.append("~FEMALE lambs /kids /piglets = ")
					.append(correctNull(txt_sale4[i]));
				}
			 if(correctNull((String)hshValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
			 {
				 hshValues.put("strAction", "update");
			 }
			 else
			 {
				 hshValues.put("strAction", "insert");
			 }
			 }
			 AuditTrial.auditLog(hshValues,"230",strApplicationNo,sbAuditTrial.toString());
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
	
	public HashMap getagrsheepflock(HashMap hshValues)  
	{		 
		ResultSet rs=null;ResultSet rs2=null;
		HashMap hshResult=new HashMap();
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=null;	
		String strQuery="";
		String strApplicationNo=correctNull((String)hshValues.get("strappno"));
		if(strApplicationNo.equalsIgnoreCase(""))
		{
			strApplicationNo = Helper.correctNull((String)hshValues.get("appno"));
		}
		try
		{
				
			rs=DBUtils.executeLAPSQuery("agr_get_sheepflock^"+strApplicationNo);			 
			while (rs.next())
			{
				arryCol=new ArrayList();
				
				
				
				arryCol.add(rs.getString("OPENSTOCK_MALE"));
				arryCol.add(rs.getString("OPENSTOCK_FEMALE"));
				arryCol.add(rs.getString("OPENSTOCK_MALEKID"));
				arryCol.add(rs.getString("OPENSTOCK_FEMALEKID"));
				
				arryCol.add(rs.getString("LAMBING_MALE"));
				arryCol.add(rs.getString("LAMBING_FEMALE"));
				arryCol.add(rs.getString("LAMBING_MALEKID"));
				arryCol.add(rs.getString("LAMBING_FEMALEKID"));
				
				arryCol.add(rs.getString("MORTALITY_MALE"));
				arryCol.add(rs.getString("MORTALITY_FEMALE"));
				arryCol.add(rs.getString("MORTALITY_MALEKID"));
				arryCol.add(rs.getString("MORTALITY_FEMALEKID"));
				
				arryCol.add(rs.getString("CULLSALE_MALE"));
				arryCol.add(rs.getString("CULLSALE_FEMALE"));
				arryCol.add(rs.getString("CULLSALE_MALEKID"));
				arryCol.add(rs.getString("CULLSALE_FEMALEKID"));
				
				arryCol.add(rs.getString("PURCHASE_MALE"));
				arryCol.add(rs.getString("PURCHASE_FEMALE"));
				arryCol.add(rs.getString("PURCHASE_MALEKID"));
				arryCol.add(rs.getString("PURCHASE_FEMALEKID"));
				
				arryCol.add(rs.getString("CLOSINGSTOCK_MALE"));
				arryCol.add(rs.getString("CLOSINGSTOCK_FEMALE"));
				arryCol.add(rs.getString("CLOSINGSTOCK_MALEKID"));
				arryCol.add(rs.getString("CLOSINGSTOCK_FEMALEKID"));
				
				arryRow.add(arryCol);
				hshResult.put("auditFlag", "Y");
			}
			hshResult.put("arryRow",arryRow);	
			
			strQuery = SQLParser.getSqlQuery("agr_get_sheeptechdata^"+strApplicationNo);			
			rs2 =DBUtils.executeQuery(strQuery);
			if(rs2.next())
			{
				hshResult.put("txt_maleno",correctNull(rs2.getString("sheep_maleno")));
				hshResult.put("txt_femaleno",correctNull(rs2.getString("sheep_femaleno")));
			}
			
			if(rs2!=null)
				rs.close();
			
			/* for getting sale of values from economic data */
			
			strQuery =SQLParser.getSqlQuery("agr_get_sheepecodata^"+strApplicationNo);
			rs2=DBUtils.executeQuery(strQuery);
			if(rs2.next())
				{
				hshResult.put("kidsvalue", correctNull(rs2.getString("sheep_kids")));
				}
			
			
		} 
		catch (Exception e) 
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		}
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
				}
				if (rs2 != null) 
				{
					rs2.close();
				}
			} 
			catch (Exception e) 
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshResult;
	}
	//sheep cash flow
	public void updatesheepcashflow(HashMap hshRequestValues) 
	{
		String appno=correctNull((String)hshRequestValues.get("appno"));
		//String productType=Helper.correctNull((String)hshRequestValues.get("strProductType"));
        String prd_type = Helper.correctNull((String)hshRequestValues.get("strProductType"));
		//String txt_roi ="", txt_holiday="",sel_payment="",txt_installment="",txt_date="";
		//String txt_lastinstallment="";
        String rollNO[] = {"I","II","III","IV","V","VI"};	
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno=correctNull((String)hshRequestValues.get("strappno"));
		}
		HashMap hshQueryValues = new HashMap();
		HashMap hshQueryValues1 = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();		
		String[] loanamt = null;
		String[] intrate = null;
		String[] netinc = null;
		String[] principal = null;
		String[] netintamt = null;
		String[] outgoingamt = null;
		String[] surplusamt = null;
		String[] repayment = null;
		String[] txt_taxdedc = null;
		String[] txt_aftertax = null;
		String[] txt_depri = null;
		String[] txt_dscr = null;
		String strAction = Helper.correctNull((String)hshRequestValues.get("hidAction"));
		ResultSet rs = null;
		int intUpdatesize = 0;
		try
		{		
			loanamt = (String[]) hshRequestValues.get("txt_loan");
			intrate = (String[])hshRequestValues.get("txt_int");
			netinc = (String[])hshRequestValues.get("txt_netinc");
			principal = (String[])hshRequestValues.get("txt_principal");
			netintamt = (String[])hshRequestValues.get("txt_netint");
			outgoingamt = (String[])hshRequestValues.get("txt_outgoing");
			surplusamt = (String[])hshRequestValues.get("txt_surplus");
			repayment = (String[])hshRequestValues.get("txt_repayment");
			txt_taxdedc = (String[])hshRequestValues.get("txt_taxdec");
			txt_aftertax = (String[])hshRequestValues.get("txt_aftertax");
			txt_depri= (String[])hshRequestValues.get("txt_depri");
			txt_dscr= (String[])hshRequestValues.get("txt_dscr");
		
			if(strAction.equalsIgnoreCase("insert"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "1");
				hshQuery3.put("strQueryId", "del_poultrycashflow");
				arrValues3.add(appno);
				arrValues3.add(prd_type);
				hshQuery3.put("arrValues", arrValues3);
				hshQueryValues1.put("1", hshQuery3);
				hshQueryValues1.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
				
				intUpdatesize = 1;
				for (int i = 0; i < loanamt.length; i++)
				{
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_poultrycashflow");
					arrValues.add(appno);
					arrValues.add(Integer.toString(i+1));
					if(loanamt[i].equalsIgnoreCase(""))
					{
						loanamt[i] = "0.00";
					}
					arrValues.add(loanamt[i]);
					if(intrate[i].equalsIgnoreCase(""))
					{
						intrate[i] = "0.00";
					}
					arrValues.add(intrate[i]);
					if(netinc[i].equalsIgnoreCase(""))
					{
						netinc[i] = "0.00";
					}
					arrValues.add(netinc[i]);
					if(principal[i].equalsIgnoreCase(""))
					{
						principal[i] = "0.00";
					}
					arrValues.add(principal[i]);
					if(netintamt[i].equalsIgnoreCase(""))
					{
						netintamt[i] = "0.00";
					}	
					arrValues.add(netintamt[i]);
					if(outgoingamt[i].equalsIgnoreCase(""))
					{
						outgoingamt[i] = "0.00";
					}
					arrValues.add(outgoingamt[i]);
					if(surplusamt[i].equalsIgnoreCase(""))
					{
						surplusamt[i] = "0.00";
					}
					     arrValues.add(surplusamt[i]);
								
						if(repayment[i].equalsIgnoreCase(""))
						{
							repayment[i]="0.00";
						}
						arrValues.add(repayment[i]);
						arrValues.add(prd_type);
						if(txt_taxdedc[i].equalsIgnoreCase(""))
						{
							txt_taxdedc[i]="0.00";
						}
						arrValues.add(txt_taxdedc[i]);
						if(txt_aftertax[i].equalsIgnoreCase(""))
						{
							txt_aftertax[i]="0.00";
						}
						arrValues.add(txt_aftertax[i]);
						if(txt_depri[i].equalsIgnoreCase(""))
						{
							txt_depri[i]="0.00";
						}
						arrValues.add(txt_depri[i]);
						if(txt_dscr[i].equalsIgnoreCase(""))
						{
							txt_dscr[i]="0.00";
						}
						arrValues.add(txt_dscr[i]);
					hshQuery.put("arrValues", arrValues);	
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
			}
          /*if(strAction1.equalsIgnoreCase("insert1"))
				
			{
        	    arrValues = new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","agr_del_bullockrepay");
				arrValues.add(appno);
				arrValues.add(prd_type);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				txt_roi= Helper.correctNull((String)hshRequestValues.get("txt_roi"));
				txt_holiday= Helper.correctNull((String)hshRequestValues.get("txt_holiday"));
				sel_payment= Helper.correctNull((String)hshRequestValues.get("sel_payment"));
				txt_installment = Helper.correctNull((String)hshRequestValues.get("txt_installment"));
				txt_date = Helper.correctNull((String)hshRequestValues.get("txt_date"));
				txt_lastinstallment= Helper.correctNull((String)hshRequestValues.get("txt_lastinstallment"));
				if(txt_roi.equalsIgnoreCase(""))
				{	
					txt_roi="0";
				}
				arrValues.add(txt_roi);
				
				if(txt_holiday.equalsIgnoreCase(""))
				{	
					txt_holiday="0";
				}
				arrValues.add(txt_holiday);
				
				if(sel_payment.equalsIgnoreCase(""))
				{	
					sel_payment ="1";
				}
				arrValues.add(sel_payment);
									
				if(txt_installment.equalsIgnoreCase(""))
				{	
					txt_installment="0.00";
				}
				arrValues.add(txt_installment);
				
				if(txt_date.equalsIgnoreCase(""))
				{	
					txt_date ="01/01/1900";
				}
				arrValues.add(txt_date);
				if(txt_lastinstallment.equalsIgnoreCase(""))
				{	
					txt_lastinstallment ="0.00";
				}
				arrValues.add(txt_lastinstallment);		
				arrValues.add(prd_type);
				arrValues.add("");
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agr_ins_bullockrepay");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			}*/
			if(strAction.equalsIgnoreCase("delete"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "1");
				hshQuery3.put("strQueryId", "del_poultrycashflow");
				arrValues3.add(appno);
				arrValues3.add(prd_type);
				hshQuery3.put("arrValues", arrValues3);
				hshQueryValues1.put("1", hshQuery3);
				hshQueryValues1.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			}
			
			StringBuilder sbAuditTrial=new StringBuilder();
			
			for (int i = 0; i < loanamt.length; i++)
			{	
				
				sbAuditTrial.append("~Loan At the Beginning ").append(rollNO[i]+" year = ").append(correctNull(loanamt[i]))
				.append("~Interest ").append(correctNull((String)hshRequestValues.get("txt_roi"))+" ").append(rollNO[i]+"  year [%] = ").append(correctNull(intrate[i]))
				.append("~Gross Income (G)").append(rollNO[i]+"  year = ").append(correctNull(netinc[i]))
				.append("~Repayment Principal(A) ").append(rollNO[i]+"  year = ").append(correctNull(principal[i]))
				.append("~Repayment Interest(B) ").append(rollNO[i]+"  year = ").append(correctNull(netintamt[i]))
				.append("~Repayment to Other loans(C) ").append(rollNO[i]+"  year = ").append(correctNull(repayment[i]))
				.append("~Total Repay(A+B+C=D) ").append(rollNO[i]+"  year = ").append(correctNull(outgoingamt[i]))
				.append("~Surplus(G-D) ").append(rollNO[i]+"  year = ").append(correctNull(surplusamt[i]))
				.append("~Tax Deduction (T) ").append(rollNO[i]+"  year = ").append(correctNull(txt_taxdedc[i]))
				.append("~Net Profit after tax(G-D-T=I) ").append(rollNO[i]+"  year = ").append(correctNull(txt_aftertax[i]))
				.append("~Depreciation(D1) ").append(rollNO[i]+"  year = ").append(correctNull(txt_depri[i]))
				.append("~DSCR(I+D1+B)/(A+B) ").append(rollNO[i]+"  year = ").append(correctNull(txt_dscr[i]))
				.append("<br>");
			}	
			
			
				
				AuditTrial.auditLog(hshRequestValues,"237",appno,sbAuditTrial.toString());
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

	public  HashMap getsheepcashflow(HashMap hshValues) 
	{
			ResultSet rs = null;
			ResultSet rs1 = null;
			String strQuery = "";
		HashMap hshRecord = new HashMap();
		ArrayList vecRow = new ArrayList();
		ArrayList vecData = new ArrayList();
		boolean bstate =true;
		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}
		try
		{
			String appno	= correctNull((String )hshValues.get("appno"));	
			/*String appno1 = correctNull((String)hshValues.get("appno1"));
			if(appno.equalsIgnoreCase(""))
			{
				appno=appno1;
			}	*/
			if(appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			
				
			strQuery = SQLParser.getSqlQuery("sel_poultrycashflow^" + appno+"^"+prd_type);
			rs = DBUtils.executeQuery(strQuery);
			rs1 = DBUtils.executeQuery(strQuery);
			bstate = rs1.next();
			if(bstate == true)
			{
				while(rs.next())
				{
					vecRow = new ArrayList();
					vecRow.add(Helper.correctNull((String)rs.getString("appno")));
					if(Helper.correctDouble((String)rs.getString("loan_begin")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(Helper.correctNull((String)rs.getString("loan_begin")));
					}
					if(Helper.correctDouble((String)rs.getString("interest")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(Helper.correctNull((String)rs.getString("interest")));
					}
					if(Helper.correctDouble((String)rs.getString("netincome")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(Helper.correctNull((String)rs.getString("netincome")));
					}
					if(Helper.correctDouble((String)rs.getString("principalamt")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(Helper.correctNull((String)rs.getString("principalamt")));
					}
					if(Helper.correctDouble((String)rs.getString("netintamt")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(Helper.correctNull((String)rs.getString("netintamt")));
					}
					if(Helper.correctDouble((String)rs.getString("outgoingamt")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(Helper.correctNull((String)rs.getString("outgoingamt")));
					}
					if(Helper.correctDouble((String)rs.getString("surplusamt")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(Helper.correctNull((String)rs.getString("surplusamt")));
					}
					if(Helper.correctDouble((String)rs.getString("repayment")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(Helper.correctNull((String)rs.getString("repayment")));
					}
					if(Helper.correctNull((String)rs.getString("taxdedc")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(Helper.correctNull((String)rs.getString("taxdedc")));
					} 
					if(Helper.correctDouble((String)rs.getString("netprofit")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(Helper.correctNull((String)rs.getString("netprofit")));
					}
					if(Helper.correctNull((String)rs.getString("depriciation")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(Helper.correctNull((String)rs.getString("depriciation")));
					}
					if(Helper.correctDouble((String)rs.getString("dscr")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(Helper.correctNull((String)rs.getString("dscr")));
					}  
					vecData.add(vecRow);
				}
			}
			else
			{
				for(int i=0; i<13; i++)
				{
					vecRow = new ArrayList();
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecData.add(vecRow);
				}
			}
				hshRecord.put("vecData", vecData);
				strQuery = SQLParser.getSqlQuery("sel_sheep_income^" + appno);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				hshRecord.put("totiyearincome", Helper.correctNull((String)rs1.getString("totiyears")));
				hshRecord.put("totiiyearincome", Helper.correctNull((String)rs1.getString("totiiyears")));
				hshRecord.put("totiiiyearincome", Helper.correctNull((String)rs1.getString("totiiiyears")));
				hshRecord.put("totivyearincome", Helper.correctNull((String)rs1.getString("totivyears")));
				hshRecord.put("totvyearincome", Helper.correctNull((String)rs1.getString("totvyears")));
				hshRecord.put("totviyearincome", Helper.correctNull((String)rs1.getString("totviyears")));
			
			}
			
			strQuery = SQLParser.getSqlQuery("agr_get_sheeploanamountdata^"+appno+"^"+prd_type);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) 
			{
				hshRecord.put("txt_totalamount", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_totalamount"))));
				hshRecord.put("txt_margin", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_marginper"))));
				hshRecord.put("txt_marginper", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_margin"))));
				hshRecord.put("txt_subsidyper", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_subsidyper"))));
				hshRecord.put("txt_subsidy", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_subsidy"))));
				hshRecord.put("txt_totalloanamount1", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_totalloanamount"))));
				hshRecord.put("txt_value1", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_value1"))));
				hshRecord.put("txt_value2", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_value2"))));
				hshRecord.put("txt_value3", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_value3"))));
				
			}	
			
			if(rs1 !=null)
			{
				rs1.close();
			}
			String strProdPurpose="";
			strQuery = SQLParser.getSqlQuery("selprodpurpose^" + appno);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next()){strProdPurpose=Helper.correctNull((String)rs1.getString("prd_purpose"));}
			/*
			 * 			For Purchase of Ready Built House and Used Vehicle loan, 
			 * 				Margin is based on age of the building / vehicle respectively
			 */
			if(strProdPurpose.equalsIgnoreCase("H") || strProdPurpose.equalsIgnoreCase("U")) 
			{
				strQuery = SQLParser.getSqlQuery("pergetloanProductbymargin^" + appno);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("pergetloanProduct^" + appno);
			}
			if(rs1 !=null)
			{
				rs1.close();
			}
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{				
				hshRecord.put("loan_recmdamt", Helper.correctDouble((String)rs1.getString("amtreqd")));
			}
			
			if(rs1!=null)
			{
				rs1.close();
			}
			
			strQuery = SQLParser.getSqlQuery("getloanterms^" + appno);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{				
				hshRecord.put("loan_modintrate", Helper.correctDouble((String)rs1.getString("loan_modintrate")));
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getcoopsocMasterList "+ce.toString());
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
	//sheep loanreq

	public HashMap updatesheeploanreq(HashMap hshValues) 
	{
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshQuery5 = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strAction = null;		
		//String strAction1 = null;	
		HashMap hshResult = new HashMap();
		HashMap hshQuery4 = new HashMap();
		int intUpdatesize = 0;
		int f = 0;
		String strid = "", strQuery1 = "";
		String appno=correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
		strAction = correctNull((String) hshValues.get("hidAction"));
		//strAction1 = correctNull((String) hshValues.get("hidAction1"));
		String  txt_totalamount = correctNull((String) hshValues.get("txt_totalamount"));
		String  txt_marginper= correctNull((String) hshValues.get("txt_marginper"));
		String  txt_subsidy= correctNull((String) hshValues.get("txt_subsidy"));
		String  txt_margin= correctNull((String) hshValues.get("txt_margin"));
		String  txt_subsidyper= correctNull((String) hshValues.get("txt_subsidyper"));
		String  txt_totalloanamount1= correctNull((String) hshValues.get("txt_totalloanamount1"));
		String  txt_totalloanamount= correctNull((String) hshValues.get("txt_totalloanamount"));
		
		String  txt_value1= correctNull((String) hshValues.get("txt_value1"));
		String  txt_value2= correctNull((String) hshValues.get("txt_value2"));
		String  txt_value3= correctNull((String) hshValues.get("txt_value3"));
		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}
		
		try 
		{
			String[] txt_specify= null;
			String[]txt_unit = null;
			String[] txt_cost = null;
			String[] txt_amount= null;
			String[] txt_sq = null;
			String[] txt_value= null;
			
			txt_specify= (String[]) hshValues.get("txt_specify");
			txt_unit= (String[]) hshValues.get("txt_unit");
			txt_cost= (String[]) hshValues.get("txt_cost");
			strid = correctNull((String) hshValues.get("hid_sno"));
			txt_amount = (String[]) hshValues.get("txt_amount");
			txt_sq= (String[]) hshValues.get("txt_sq");
			txt_value= (String[]) hshValues.get("txt_value");
			/*strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshResult.put("applicantid", rs.getString("demo_appid"));
			}*/
			if (strAction.equals("delete"))
			{
				hshQuery4 = new HashMap();
				HashMap hshQueryValues4 = new HashMap();
				ArrayList arrValues4 = new ArrayList();
				hshQueryValues4.put("size", "1");
				hshQuery4.put("strQueryId", "agr_del_sheeploanreqdata");
				arrValues4.add(appno);
				hshQuery4.put("arrValues", arrValues4);
				hshQueryValues4.put("1", hshQuery4);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
			}
			if (strAction.equals("delete"))
			{
				hshQuery5 = new HashMap();
				HashMap hshQueryValues5 = new HashMap();
				ArrayList arrValues5 = new ArrayList();
				hshQueryValues5.put("size", "1");
				hshQuery5.put("strQueryId", "agr_del_sheeploanamountdata");
				arrValues5.add(appno);
				arrValues5.add(prd_type);
				hshQuery5.put("arrValues", arrValues5);
				hshQueryValues5.put("1", hshQuery5);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues5,"updateData");
			}
		
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQuery= new HashMap();
				 arrValues = new ArrayList();
				hshQuery.put("size", "2");
				hshQuery.put("strQueryId", "agr_del_sheeploanamountdata");
				arrValues.add(appno);
				arrValues.add(prd_type);
				hshQuery.put("arrValues",arrValues);	
				hshQueryValues.put("1",hshQuery);
				hshQuery= new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(txt_totalamount);
				arrValues.add(txt_marginper);
				arrValues.add(txt_margin);
				arrValues.add(txt_subsidyper);
				arrValues.add(txt_subsidy);
				if(txt_totalloanamount1.equalsIgnoreCase(""))
				{
					arrValues.add(txt_totalloanamount);	
				}
				else{
				arrValues.add(txt_totalloanamount1);
					
				}
				if(txt_value1.equalsIgnoreCase(""))
				{
					arrValues.add("");	
				}
				else{
				arrValues.add(txt_value1);
				}
				if(txt_value2.equalsIgnoreCase(""))
				{
					arrValues.add("");	
				}
				else{
				arrValues.add(txt_value2);
				}
				if(txt_value3.equalsIgnoreCase(""))
				{
					arrValues.add("");	
				}
				else{
				arrValues.add(txt_value3);
				}
				arrValues.add(prd_type);
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agr_ins_sheeploanamountdata");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			if (strAction.equalsIgnoreCase("insert"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "2");
				hshQuery3.put("strQueryId", "agr_del_sheeploanreqdata");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				strQuery1 = SQLParser.getSqlQuery("sel_maxid_sheeploanreqdata");
				rs = DBUtils.executeQuery(strQuery1);
				if (rs.next())
				{
					strid = correctNull((String) rs.getString("maxid"));
					f = Integer.parseInt(strid);
				}
				intUpdatesize = 1;

				for (int i =19; i < 23; i++)
				{					
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "agr_ins_sheeploanreqdata");
					arrValues.add(Integer.toString(f));
					arrValues.add(appno);
					arrValues.add(new Integer(i + 1).toString());
					
					
					if (correctNull(txt_specify[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_specify[i]));
					}
					if (correctNull(txt_unit[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_unit[i]));
					}
					if (correctNull(txt_cost[i]).equals("")) 
					{
						arrValues.add("");
					}
					else 
					{
						arrValues.add(correctNull(txt_cost[i]));
					}
					if (correctNull(txt_amount[i]).equals(""))
					{
						arrValues.add("");
					} 
					else
					{
						arrValues.add(correctNull(txt_amount[i]));
					}
					arrValues.add("o");
					arrValues.add("");
					hshQuery.put("arrValues", arrValues);
					f = f + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);					
				}
				for (int i =8; i < 14; i++)
				{					
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "agr_ins_sheeploanreqdata");
					arrValues.add(Integer.toString(f));
					arrValues.add(appno);
					arrValues.add(new Integer(i + 1).toString());
					
					
					if (correctNull(txt_specify[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_specify[i]));
					}
					if (correctNull(txt_sq[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_sq[i]));
					}
					if (correctNull(txt_value[i]).equals("")) 
					{
						arrValues.add("");
					}
					else 
					{
						arrValues.add(correctNull(txt_value[i]));
					}
					if (correctNull(txt_unit[i]).equals(""))
					{
						arrValues.add("");
					} 
					else
					{
						arrValues.add(correctNull(txt_unit[i]));
					}
					arrValues.add("c");
					if (correctNull(txt_amount[i]).equals(""))
					{
						arrValues.add("");
					} 
					else
					{
						arrValues.add(correctNull(txt_amount[i]));
					}
					hshQuery.put("arrValues", arrValues);
					f = f + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);					
				}
				
				hshQueryValues.put("1", hshQuery3);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			hshpasValues.put("appno", appno);
			hshpasValues.put("prd_type", prd_type);
			hshResult = getsheeploanreq(hshpasValues);
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{
			String strdesc[]={"~ Purchase of Goat/Sheep/Rabbit/Pig (Male) = ","~ Purchase of Goat/Sheep/Rabbit/Pig (Female) = ",
			"~ Cost of transportation of Animals = ",
			"~ Cost of Feeding of Breeding Stock(No.of Male adults*cost of feeding/animal/day" + txt_value[3] + " days ) =",					
			"~ Cost of Feeding of Breeding Stock(No.of Female adults*cost of feeding/animal/day" + txt_value[4] + " days ) =",
			"~ Veterinary Aid(No.of adults*cost of vt aid/month/animal" + txt_value[4] + "months) = ",
			"~ Insurance Premium(No.of adults*cost of insurance/animal/year) = ",
			"~ Labour(no.of labourers*wages/month" + txt_value[7] +"months) = "};
			sbAuditTrial.append("~Particulars ^")
			.append("<br>");
			
				for (int i =0; i <8; i++)
				{
					sbAuditTrial
					.append(strdesc[i])
					.append("~No. of units = ")
					.append(txt_unit[i])
					.append("~Cost per unit(Rs.) = ")
					.append(txt_cost[i])
					.append("~Amount(Rs.) = ")
					.append(txt_amount[i])
					;
				}
			
			sbAuditTrial
			.append("<br>")
			.append("~Other Civil Works ^")
			.append("<br>");
			for (int i =8; i <=13; i++)
			{
				sbAuditTrial
				.append("~Construction of = ")
				.append(txt_specify[i])
				.append("~ shed measuring  = ")
				.append(txt_sq[i])
				.append("~sq ft @ Rs. = ")
				.append(txt_value[i])
				.append("~per sq ft = ")
				.append("~No. of units = ")
				.append(txt_unit[i])
				.append("~Cost per unit(Rs.) = ")
				.append(txt_cost[i])
				.append("~Amount(Rs.) = ")
				.append(txt_amount[i]);
			}
			sbAuditTrial
			.append("<br>")
			.append("~Purchase of Equipments ^")
			.append("<br>");
			for (int i =14; i <=18; i++)
			{
				
				sbAuditTrial
				.append("~Name of equipments with specifications = ")
				.append(txt_specify[i])
				.append("~No of units = ")
				.append(txt_unit[i])
				.append("~Cost per unit = ")
				.append(txt_cost[i])
				.append("~Amount(Rs.) = ")
				.append(txt_amount[i]);
			}
			sbAuditTrial.append("<br>")
			.append("~Others Specify ^")
			.append("<br>");
			for (int i =19; i <=22; i++)
			{
				if(!(txt_specify[i].equalsIgnoreCase("")))
					{
					sbAuditTrial
					.append("~").append(txt_specify[i]).append(" = ")
					.append("~No of units = ")
					.append(txt_unit[i])
					.append("~Cost per unit = ")
					.append(txt_cost[i])
					.append("~Amount(Rs.) = ")
					.append(txt_amount[i]);
					}
			}
			sbAuditTrial.append("~Total(Amount)(Rs.) = ").append(txt_totalamount);
			
			if(correctNull((String)hshValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
			 {
				 hshValues.put("strAction", "update");
			 }
			 else
			 {
				 hshValues.put("strAction", "insert");
			 }
			}
			AuditTrial.auditLog(hshValues,"231",appno,sbAuditTrial.toString());
			
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} 
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
			} 
			catch (Exception e1) 
			{
				throw new EJBException("Error in closing Connection "+ e1.getMessage());
			}
		}
		return hshResult;
	}

	public  HashMap getsheeploanreq(HashMap hshValues) 
	{
			ResultSet rs = null;
			ResultSet rs2 = null;
			ResultSet rs1 = null;
			String strQuery = "";
		HashMap hshResult = new HashMap();
		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}
		try
		{
			String appno	= correctNull((String )hshValues.get("appno"));	
			/*String appno1 = correctNull((String)hshValues.get("appno1"));
			if(appno.equalsIgnoreCase(""))
			{
				appno=appno1;
			}*/	
			if(appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			
				
			strQuery = SQLParser.getSqlQuery("agr_get_sheeptechdata^"+appno);			
			rs2 =DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				hshResult.put("sel_animal",correctNull(rs2.getString("sheep_animal")));
				hshResult.put("txt_breed",correctNull(rs2.getString("sheep_breed")));
				hshResult.put("txt_agem",correctNull(rs2.getString("sheep_agem")));
				hshResult.put("txt_maleno",correctNull(rs2.getString("sheep_maleno")));
				hshResult.put("txt_malecost",correctNull(rs2.getString("sheep_malecost")));
				hshResult.put("txt_maleamount",correctNull(rs2.getString("sheep_maleamount")));
				hshResult.put("txt_agef",correctNull(rs2.getString("sheep_agef")));
				hshResult.put("txt_femaleno",correctNull(rs2.getString("sheep_femaleno")));
				hshResult.put("txt_femalecost",correctNull(rs2.getString("sheep_femalecost")));
				hshResult.put("txt_femaleamount",correctNull(rs2.getString("sheep_femaleamount")));
				hshResult.put("txt_totalanimalno",correctNull(rs2.getString("sheep_totalanimalno")));
				hshResult.put("txt_totalanimalcost",correctNull(rs2.getString("sheep_totalanimalcost")));
				hshResult.put("txt_totalanimalamount",correctNull(rs2.getString("sheep_totalanimalamount")));
				hshResult.put("txt_marketplace",correctNull(rs2.getString("sheep_marketplace")));
				hshResult.put("txt_marketdistance",correctNull(rs2.getString("sheep_marketdistance")));
				hshResult.put("txt_markettransport",correctNull(rs2.getString("sheep_markettransport")));
				hshResult.put("txt_markettranscost",correctNull(rs2.getString("sheep_markettranscost")));
				hshResult.put("sel_purchase",correctNull(rs2.getString("sheep_purchase")));
				hshResult.put("txt_namepurcom",correctNull(rs2.getString("sheep_namepurcom")));
				hshResult.put("txt_per",correctNull(rs2.getString("sheep_per")));
				hshResult.put("txt_birth",correctNull(rs2.getString("sheep_birth")));
				hshResult.put("txt_annualper",correctNull(rs2.getString("sheep_annualper")));
				hshResult.put("txt_annualpera",correctNull(rs2.getString("sheep_annualpera")));
				hshResult.put("sel_flock",correctNull(rs2.getString("sheep_flock")));
				hshResult.put("txt_migrationpattern",correctNull(rs2.getString("sheep_migrationpattern")));
				hshResult.put("txt_grazingpattern",correctNull(rs2.getString("sheep_grazingpattern")));
				hshResult.put("txt_greenfodder",correctNull(rs2.getString("sheep_greenfodder")));
				hshResult.put("txt_vtaidplace",correctNull(rs2.getString("sheep_vtaidplace")));
				hshResult.put("txt_distancefarm",correctNull(rs2.getString("sheep_distancefarm")));
				hshResult.put("txt_woolplace",correctNull(rs2.getString("sheep_woolplace")));
				hshResult.put("txt_distancewool",correctNull(rs2.getString("sheep_distancewool")));
				hshResult.put("sel_care",correctNull(rs2.getString("sheep_care")));
			
			}	
			strQuery = SQLParser.getSqlQuery("agr_get_sheepecodata^"+appno);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) 
			{
				hshResult.put("txt_age", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_age"))));
				hshResult.put("sel_kids", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_kids"))));
				hshResult.put("txt_price", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_price"))));
				hshResult.put("sel_sale", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_sale"))));
				hshResult.put("txt_salemanure", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_salemanure"))));
				hshResult.put("txt_fine", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_fine"))));
				hshResult.put("txt_fineprice", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_fineprice"))));
				hshResult.put("txt_medium", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_medium"))));
				hshResult.put("txt_mediumprice", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_mediumprice"))));
				hshResult.put("txt_coarse", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_coarse"))));
				hshResult.put("txt_coarseprice", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_coarseprice"))));
				hshResult.put("txt_vtaidprice", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_vtaidprice"))));
				hshResult.put("txt_inspremium", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_inspremium"))));
				hshResult.put("txt_employee", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_employee"))));
				hshResult.put("txt_wageemployee", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_wageemployee"))));
				hshResult.put("txt_transcost", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_transcost"))));
				hshResult.put("txt_feedadult", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_feedadult"))));
				hshResult.put("txt_feedadult1", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_feedadult1"))));
				
				hshResult.put("txt_feedlamb", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_feedlamb"))));
				hshResult.put("txt_amount4", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_amountwool"))));
				
				hshResult.put("txt_specify1", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_specify1"))));
				hshResult.put("txt_specify2", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_specify2"))));
				hshResult.put("txt_amountspec1", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_amountspec1"))));
				hshResult.put("txt_amountspec2", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_amountspec2"))));
				hshResult.put("txt_specify3", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_specify3"))));
				hshResult.put("txt_specify4", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_specify4"))));
				hshResult.put("txt_amountspec3", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_amountspec3"))));
				hshResult.put("txt_amountspec4", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_amountspec4"))));

			}
			strQuery = SQLParser.getSqlQuery("agr_get_sheeploanamountdata^"+appno+"^"+prd_type);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) 
			{
				hshResult.put("txt_totalamount", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_totalamount"))));
				hshResult.put("txt_margin", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_marginper"))));
				hshResult.put("txt_marginper", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_margin"))));
				hshResult.put("txt_subsidyper", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_subsidyper"))));
				hshResult.put("txt_subsidy", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_subsidy"))));
				hshResult.put("txt_totalloanamount1", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_totalloanamount"))));
				hshResult.put("txt_value1", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_value1"))));
				hshResult.put("txt_value2", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_value2"))));
				hshResult.put("txt_value3", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_value3"))));
				
			}
			
				 if (rs1 != null)
				    {
					rs1.close();
				    }
						 							 
			strQuery = SQLParser.getSqlQuery("agr_get_sheepequipdata^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			ArrayList arryCol1 = new ArrayList();
			ArrayList arryRow1 = new ArrayList();
			while (rs.next())
			{
				arryCol1 = new ArrayList();
				arryCol1.add(rs.getString("seqno"));
				arryCol1.add(appno);
				arryCol1.add(rs.getString("sno"));
				arryCol1.add(rs.getString("sheep_particulars"));
				arryCol1.add(rs.getString("sheep_units"));
				arryCol1.add(rs.getString("sheep_cost"));
				arryCol1.add(rs.getString("sheep_amount"));
				
				arryRow1.add(arryCol1);
			}
			strQuery = SQLParser.getSqlQuery("agr_get_sheeploanreqdata^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			
			ArrayList arryCol = new ArrayList();
			ArrayList arryRow = new ArrayList();
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(rs.getString("seqno"));
				arryCol.add(appno);
				arryCol.add(rs.getString("sno"));
				arryCol.add(rs.getString("sheep_particulars"));
				arryCol.add(rs.getString("sheep_units"));
				arryCol.add(rs.getString("sheep_cost"));
				arryCol.add(rs.getString("sheep_amount"));
				
				arryRow.add(arryCol);
				hshResult.put("auditFlag", "Y");
			}
			
			if(rs !=null)
			{
				rs.close();
			}
			String strProdPurpose="";
			strQuery = SQLParser.getSqlQuery("selprodpurpose^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()){strProdPurpose=Helper.correctNull((String)rs.getString("prd_purpose"));}
			/*
			 * 			For Purchase of Ready Built House and Used Vehicle loan, 
			 * 				Margin is based on age of the building / vehicle respectively
			 */
			if(strProdPurpose.equalsIgnoreCase("H") || strProdPurpose.equalsIgnoreCase("U")) 
			{
				strQuery = SQLParser.getSqlQuery("pergetloanProductbymargin^" + appno);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("pergetloanProduct^" + appno);
			}
			if(rs !=null)
			{
				rs.close();
			}
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{	
				
				hshResult.put("loan_sub", Helper.correctNull(rs.getString("loan_sub")));
			    hshResult.put("offeredmargin", Helper.correctNull(rs.getString("offeredmargin")));
			    hshResult.put("cloanprd", Helper.correctNull(rs.getString("cloanprd")));
			}
			
			strQuery = SQLParser.getSqlQuery("selsanction_adviceloan^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
				hshResult.put("loan_recmdamt",Helper.correctNull((String)rs.getString("loan_recmdamt")));
			}
			
			hshResult.put("appno", appno);
			hshResult.put("arryRow1", arryRow1);
			hshResult.put("arryRow", arryRow);			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getcoopsocMasterList "+ce.toString());
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
		return hshResult;
	}		
//sheep eligibility
	public HashMap getsheepeligibility(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;ResultSet rs2 = null;
		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}
		HashMap hshResult = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		ArrayList arryRow1 = new ArrayList();
		ArrayList arryCol1 = null;
		ArrayList arryRow2 = new ArrayList();
		ArrayList arryCol2 = null;
		ArrayList arryRow3 = new ArrayList();
		ArrayList arryCol3 = null;
		String appno=correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
	    String PageType=Helper.correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
        {
        	 PageType=Helper.correctNull((String)hshValues.get("hidpagetype"));
        }
        
		try 
		{
			
			strQuery = SQLParser.getSqlQuery("agr_get_sheeptechdata^"+appno);			
			rs2 =DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				
				hshResult.put("sel_animal",correctNull(rs2.getString("sheep_animal")));
				hshResult.put("txt_breed",correctNull(rs2.getString("sheep_breed")));
				hshResult.put("txt_agem",correctNull(rs2.getString("sheep_agem")));
				hshResult.put("txt_maleno",correctNull(rs2.getString("sheep_maleno")));
				hshResult.put("txt_malecost",correctNull(rs2.getString("sheep_malecost")));
				hshResult.put("txt_maleamount",correctNull(rs2.getString("sheep_maleamount")));
				hshResult.put("txt_agef",correctNull(rs2.getString("sheep_agef")));
				hshResult.put("txt_femaleno",correctNull(rs2.getString("sheep_femaleno")));
				hshResult.put("txt_femalecost",correctNull(rs2.getString("sheep_femalecost")));
				hshResult.put("txt_femaleamount",correctNull(rs2.getString("sheep_femaleamount")));
				hshResult.put("txt_totalanimalno",correctNull(rs2.getString("sheep_totalanimalno")));
				hshResult.put("txt_totalanimalcost",correctNull(rs2.getString("sheep_totalanimalcost")));
				hshResult.put("txt_totalanimalamount",correctNull(rs2.getString("sheep_totalanimalamount")));
				hshResult.put("txt_marketplace",correctNull(rs2.getString("sheep_marketplace")));
				hshResult.put("txt_marketdistance",correctNull(rs2.getString("sheep_marketdistance")));
				hshResult.put("txt_markettransport",correctNull(rs2.getString("sheep_markettransport")));
				hshResult.put("txt_markettranscost",correctNull(rs2.getString("sheep_markettranscost")));
				hshResult.put("sel_purchase",correctNull(rs2.getString("sheep_purchase")));
				hshResult.put("txt_namepurcom",correctNull(rs2.getString("sheep_namepurcom")));
				hshResult.put("txt_per",correctNull(rs2.getString("sheep_per")));
				hshResult.put("txt_birth",correctNull(rs2.getString("sheep_birth")));
				hshResult.put("txt_annualper",correctNull(rs2.getString("sheep_annualper")));
				hshResult.put("txt_annualpera",correctNull(rs2.getString("sheep_annualpera")));
				hshResult.put("sel_flock",correctNull(rs2.getString("sheep_flock")));
				hshResult.put("txt_migrationpattern",correctNull(rs2.getString("sheep_migrationpattern")));
				hshResult.put("txt_grazingpattern",correctNull(rs2.getString("sheep_grazingpattern")));
				hshResult.put("txt_greenfodder",correctNull(rs2.getString("sheep_greenfodder")));
				hshResult.put("txt_vtaidplace",correctNull(rs2.getString("sheep_vtaidplace")));
				hshResult.put("txt_distancefarm",correctNull(rs2.getString("sheep_distancefarm")));
				hshResult.put("txt_woolplace",correctNull(rs2.getString("sheep_woolplace")));
				hshResult.put("txt_distancewool",correctNull(rs2.getString("sheep_distancewool")));
				hshResult.put("sel_care",correctNull(rs2.getString("sheep_care")));
				
				
			}	
			strQuery = SQLParser.getSqlQuery("sel_sheep_income^" + appno);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				hshResult.put("totiyearincome", Helper.correctNull((String)rs1.getString("totiyears")));
				hshResult.put("totiiyearincome", Helper.correctNull((String)rs1.getString("totiiyears")));
				hshResult.put("totiiiyearincome", Helper.correctNull((String)rs1.getString("totiiiyears")));
				hshResult.put("totivyearincome", Helper.correctNull((String)rs1.getString("totivyears")));
				hshResult.put("totvyearincome", Helper.correctNull((String)rs1.getString("totvyears")));
				hshResult.put("totviyearincome", Helper.correctNull((String)rs1.getString("totviyears")));
			
			}
			
			rs=DBUtils.executeLAPSQuery("agr_get_sheepflock_ostock^"+appno);			 
			while (rs.next())
			{
				arryCol3=new ArrayList();
				arryCol3.add(rs.getString("agr_ostock"));				
				arryRow3.add(arryCol3);
			}
			rs=DBUtils.executeLAPSQuery("agr_get_sheepflock_sale^"+appno);			 
			while (rs.next())
			{
				arryCol1=new ArrayList();
				arryCol1.add(rs.getString("agr_sale"));				
				arryRow1.add(arryCol1);
			}
			strQuery = SQLParser.getSqlQuery("agr_get_sheeploanamountdata^"+appno+"^"+prd_type);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) 
			{
				hshResult.put("txt_totalamount", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_totalamount"))));
				hshResult.put("txt_margin", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_marginper"))));
				hshResult.put("txt_marginper", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_margin"))));
				hshResult.put("txt_subsidyper", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_subsidyper"))));
				hshResult.put("txt_subsidy", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_subsidy"))));
				hshResult.put("txt_totalloanamount1", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_totalloanamount"))));
				hshResult.put("txt_value1", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_value1"))));
				hshResult.put("txt_value2", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_value2"))));
				hshResult.put("txt_value3", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_value3"))));
				
			}
			
				 if (rs1 != null)
				    {
					rs1.close();
				    }
						 							 
			strQuery = SQLParser.getSqlQuery("agr_get_sheeploanequipdata^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			 arryCol2= new ArrayList();
			 arryRow2 = new ArrayList();
			while (rs.next())
			{
				arryCol2 = new ArrayList();
				arryCol2.add(rs.getString("seqno"));
				arryCol2.add(appno);
				arryCol2.add(rs.getString("sno"));
				arryCol2.add(rs.getString("sheep_particulars"));
				arryCol2.add(rs.getString("sheep_units"));
				arryCol2.add(rs.getString("sheep_cost"));
				arryCol2.add(rs.getString("sheep_amount"));
				
				arryRow2.add(arryCol2);
			}
			strQuery = SQLParser.getSqlQuery("agr_get_sheeploanreqdataconst^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(rs.getString("seqno"));
				arryCol.add(appno);
				arryCol.add(rs.getString("sno"));
				arryCol.add(rs.getString("sheep_particulars"));
				arryCol.add(rs.getString("sheep_units"));
				arryCol.add(rs.getString("sheep_cost"));
				arryCol.add(rs.getString("sheep_amount"));
				arryCol.add(rs.getString("sheep_totamount"));
				arryRow.add(arryCol);
			}
			strQuery = SQLParser.getSqlQuery("agr_get_sheepecodata^"+appno);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) 
			{
				hshResult.put("txt_age", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_age"))));
				hshResult.put("sel_kids", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_kids"))));
				hshResult.put("txt_price", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_price"))));
				hshResult.put("sel_sale", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_sale"))));
				hshResult.put("txt_salemanure", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_salemanure"))));
				hshResult.put("txt_fine", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_fine"))));
				hshResult.put("txt_fineprice", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_fineprice"))));
				hshResult.put("txt_medium", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_medium"))));
				hshResult.put("txt_mediumprice", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_mediumprice"))));
				hshResult.put("txt_coarse", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_coarse"))));
				hshResult.put("txt_coarseprice", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_coarseprice"))));
				hshResult.put("txt_vtaidprice", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_vtaidprice"))));
				hshResult.put("txt_inspremium", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_inspremium"))));
				hshResult.put("txt_employee", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_employee"))));
				hshResult.put("txt_wageemployee", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_wageemployee"))));
				hshResult.put("txt_transcost", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_transcost"))));
				hshResult.put("txt_feedadult", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_feedadult"))));
				hshResult.put("txt_feedlamb", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_feedlamb"))));
				hshResult.put("txt_amount4", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_amountwool"))));
				
				hshResult.put("txt_specify1", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_specify1"))));
				hshResult.put("txt_specify2", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_specify2"))));
				hshResult.put("txt_amountspec1", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_amountspec1"))));
				hshResult.put("txt_amountspec2", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_amountspec2"))));
				hshResult.put("txt_specify3", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_specify3"))));
				hshResult.put("txt_specify4", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_specify4"))));
				hshResult.put("txt_amountspec3", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_amountspec3"))));
				hshResult.put("txt_amountspec4", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_amountspec4"))));
			}
			strQuery = SQLParser.getSqlQuery("agr_get_sheeploanreqdatasources^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			ArrayList arryCol4= new ArrayList();
			ArrayList arryRow4 = new ArrayList();
			
			while (rs.next())
			{
				arryCol4 = new ArrayList();
				arryCol4.add(rs.getString("seqno"));
				arryCol4.add(appno);
				arryCol4.add(rs.getString("sno"));
				arryCol4.add(rs.getString("sheep_particulars"));
				arryCol4.add(rs.getString("sheep_units"));
				arryCol4.add(rs.getString("sheep_cost"));
				arryCol4.add(rs.getString("sheep_amount"));
				
				arryRow4.add(arryCol4);
			}
			hshResult.put("appno", appno);
			hshResult.put("arryRow1", arryRow1);
			hshResult.put("arryRow", arryRow);		
			hshResult.put("arryRow2", arryRow2);
			hshResult.put("arryRow3", arryRow3);
			hshResult.put("arryRow4", arryRow4);
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
					rs = null;
				}
				 if (rs1 != null)
				    {
					rs1.close();
				    }
				 if (rs2 != null)
				    {
					rs2.close();
				    }
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshResult;
	}
	
	
	//broiler findata
	public HashMap getpoultrybroilerfindata(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;ResultSet rs2 = null;
		HashMap hshRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		ArrayList arryRow1 = new ArrayList();
		ArrayList arryCol11= new ArrayList();
		ArrayList  arryRow11= new ArrayList();
		ArrayList arryCol1 = null;
		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}
		String appno=correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
	    String PageType=Helper.correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
        {
        	 PageType=Helper.correctNull((String)hshValues.get("hidpagetype"));
        }
        
		try 
		{
			/*strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}*/
			strQuery = SQLParser.getSqlQuery("agr_get_poultrybroifindata^"+appno+ "^" +prd_type);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) 
			{
				hshRecord.put("txt_nochicks", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_nochicks"))));
				hshRecord.put("txt_costchicks", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_costchicks"))));
				hshRecord.put("txt_totalcostchicks", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalcostchicks"))));
				hshRecord.put("txt_costchickmash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_costchickmash"))));
				hshRecord.put("txt_conchickmash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_conchickmash"))));
				hshRecord.put("txt_totalchickmash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalchickmash"))));
				hshRecord.put("txt_costgrowermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_costgrowermash"))));
				hshRecord.put("txt_congrowermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_congrowermash"))));
				hshRecord.put("txt_totalgrowermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalgrowermash"))));
				hshRecord.put("txt_totalfeedcon", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalfeedcon"))));
				hshRecord.put("txt_totalfeedcost", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalfeedcost"))));
				hshRecord.put("txt_broodingmor", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_broodingmor"))));
				hshRecord.put("txt_broodingchicks", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_broodingchicks"))));
				hshRecord.put("txt_specify1", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_specify1"))));
				hshRecord.put("txt_specify2", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_specify2"))));
				hshRecord.put("txt_electricitycharge", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_electricitycharge"))));
				hshRecord.put("txt_watercharge", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_watercharge"))));
				hshRecord.put("txt_vtaid", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_vtaid"))));
				hshRecord.put("txt_inspremium", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_inspremium"))));
				hshRecord.put("txt_yieldegg", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_yieldegg"))));
				
				hshRecord.put("txt_totsaleegg", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totsaleegg"))));
				
				hshRecord.put("txt_yieldmanure", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_yieldmanure"))));
				hshRecord.put("txt_salemanure", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_salemanure"))));
				hshRecord.put("txt_salegunny", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_salegunny"))));
				hshRecord.put("txt_emptybag", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_emptybag"))));
				hshRecord.put("txt_transportcharge", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_transportcharge"))));
				hshRecord.put("txt_totalvtaid", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalvtaid"))));
				hshRecord.put("txt_totalinspremium", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalinspremium"))));
				hshRecord.put("txt_totsalemanure", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totsalemanure"))));
				hshRecord.put("txt_totsalebag", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totsalebag"))));
				hshRecord.put("auditFlag", "Y");
				
			}
			
				 if (rs1 != null)
				    {
					rs1.close();
				    }
				
						 							 
			strQuery = SQLParser.getSqlQuery("per_get_poultryfinperdata^" + appno+ "^" +prd_type);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(appno);
				arryCol.add(rs.getString("sno"));
				arryCol.add(rs.getString("poultry_noperson"));
				arryCol.add(rs.getString("poultry_salarypm"));
				arryCol.add(rs.getString("poultry_salarypy"));
				arryRow.add(arryCol);
			}
			strQuery = SQLParser.getSqlQuery("sel_poultry_exp^" + appno+ "^" +prd_type+"^E");
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol1 = new ArrayList();
				arryCol1.add(rs.getString("poultry_expenses"));
				arryCol1.add(rs.getString("poultry_iyear"));
				arryCol1.add(rs.getString("poultry_iiyear"));
				arryCol1.add(rs.getString("poultry_iiiyear"));
				arryCol1.add(rs.getString("poultry_type"));
				arryRow1.add(arryCol1);
			}
			
			
			if(rs!=null)rs.close();
			strQuery = SQLParser.getSqlQuery("sel_poultry_inc^" + appno+ "^" +prd_type+"^S");
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol11 = new ArrayList();
				arryCol11.add(rs.getString("poultry_expenses"));
				arryCol11.add(rs.getString("poultry_iyear"));
				arryCol11.add(rs.getString("poultry_iiyear"));
				arryCol11.add(rs.getString("poultry_iiiyear"));
				arryCol11.add(rs.getString("poultry_type"));
				arryRow11.add(arryCol11);
			}
			
			strQuery = SQLParser.getSqlQuery("sel_poultry_non_recurring^" + appno+"^"+prd_type);
			rs = DBUtils.executeQuery(strQuery);
			ArrayList arryCol2 = new ArrayList();
			ArrayList arryRow2 = new ArrayList();
			while (rs.next())
			{
				arryCol2 = new ArrayList();
				arryCol2.add(appno);
				arryCol2.add(rs.getString("poultry_item"));
				arryCol2.add(rs.getString("poultry_unit"));
				arryCol2.add(rs.getString("poultry_cost"));
				arryCol2.add(rs.getString("poultry_loan_amount"));
				arryRow2.add(arryCol2);
			}
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("arryRow1", arryRow1);
			hshRecord.put("arryRow11",arryRow11);
			hshRecord.put("arryRow2", arryRow2);
			hshRecord.put("PageType", PageType);
			
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
					rs = null;
				}
				 if (rs1 != null)
				    {
					rs1.close();
				    }
				 if (rs2 != null)
				    {
					rs2.close();
				    }
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap updatepoultrybroilerfindata(HashMap hshValues)  
	{
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		HashMap hshQuery3 = new HashMap();
		ArrayList arrValues3 = new ArrayList();
		ResultSet rs = null;
		String strAction = null;		
		HashMap hshResult = new HashMap();
		int intUpdatesize = 0;
		int intUpdatesize2=0;
		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}
		String appno=correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
		strAction = correctNull((String) hshValues.get("hidAction"));
		String txt_nochicks = correctNull((String) hshValues.get("txt_nochicks"));
		String  txt_costchicks= correctNull((String) hshValues.get("txt_costchicks"));
		String  txt_totalcostchicks= correctNull((String) hshValues.get("txt_totalcostchicks"));
		String  txt_costchickmash= correctNull((String) hshValues.get("txt_costchickmash"));
		String txt_conchickmash= correctNull((String) hshValues.get("txt_conchickmash"));
		String  txt_totalchickmash= correctNull((String) hshValues.get("txt_totalchickmash"));
		String txt_costgrowermash= correctNull((String) hshValues.get("txt_costgrowermash"));
		String txt_congrowermash = correctNull((String) hshValues.get("txt_congrowermash"));
		
		String  txt_totalgrowermash= correctNull((String) hshValues.get("txt_totalgrowermash"));
		String txt_totalfeedcon= correctNull((String) hshValues.get("txt_totalfeedcon"));
		String txt_totalfeedcost = correctNull((String) hshValues.get("txt_totalfeedcost"));
		String  txt_broodingchicks= correctNull((String) hshValues.get("txt_broodingchicks"));
		
		String  txt_broodingmor= correctNull((String) hshValues.get("txt_broodingmor"));
		String txt_specify1= correctNull((String) hshValues.get("txt_specify1"));
		String txt_specify2= correctNull((String) hshValues.get("txt_specify2"));
		String  txt_electricitycharge= correctNull((String) hshValues.get("txt_electricitycharge"));
		if(txt_electricitycharge.equalsIgnoreCase(""))
		{
			txt_electricitycharge="0";	
		}
		else{
			txt_electricitycharge= correctNull((String) hshValues.get("txt_electricitycharge"));
		}
		
		String  txt_watercharge= correctNull((String) hshValues.get("txt_watercharge"));
		if(txt_watercharge.equalsIgnoreCase(""))
		{
			txt_watercharge="0";	
		}
		else{
			txt_watercharge= correctNull((String) hshValues.get("txt_watercharge"));
		}
		String txt_vtaid= correctNull((String) hshValues.get("txt_vtaid"));
		if(txt_vtaid.equalsIgnoreCase(""))
		{
			txt_vtaid="0";	
		}
		else{
			txt_vtaid= correctNull((String) hshValues.get("txt_vtaid"));
		}
		String txt_inspremium= correctNull((String) hshValues.get("txt_inspremium"));
		if(txt_inspremium.equalsIgnoreCase(""))
		{
			txt_inspremium="0";	
		}
		else{
			txt_inspremium= correctNull((String) hshValues.get("txt_inspremium"));
		}
		String  txt_yieldegg= correctNull((String) hshValues.get("txt_yieldegg"));
		String txt_yieldmanure= correctNull((String) hshValues.get("txt_yieldmanure"));
		String txt_salemanure= correctNull((String) hshValues.get("txt_salemanure"));
		if(txt_salemanure.equalsIgnoreCase(""))
		{
			txt_salemanure="0";	
		}
		else{
			txt_salemanure= correctNull((String) hshValues.get("txt_salemanure"));
		}
		
		String txt_totsalemanure= correctNull((String) hshValues.get("txt_totsalemanure"));
		
		String  txt_salegunny= correctNull((String) hshValues.get("txt_salegunny"));
		String txt_emptybag= correctNull((String) hshValues.get("txt_emptybag"));
		String txt_transportcharge= correctNull((String) hshValues.get("txt_transportcharge"));
		if(txt_transportcharge.equalsIgnoreCase(""))
		{
			txt_transportcharge="0";	
		}
		else{
			txt_transportcharge= correctNull((String) hshValues.get("txt_transportcharge"));
		}
	    String txt_totalvtaid= correctNull((String) hshValues.get("txt_totalvtaid"));
		String  txt_totalinspremium= correctNull((String) hshValues.get("txt_totalinspremium"));
		String txt_totsaleegg= correctNull((String) hshValues.get("txt_totsaleegg"));
		String txt_totsalebag= correctNull((String) hshValues.get("txt_totsalebag"));
		String[] strDesc_1={"~Labourers ^","~Manager ^","~Supervisor ^","~"+Helper.correctNull((String)hshValues.get("txt_specify1"))+" ^" ,"~"+Helper.correctNull((String)hshValues.get("txt_specify2"))+" ^"};
		
		String[] txt_noperson = null;
		String[]txt_salarypm = null;
		//String[]txt_salarypy = null;
		
		String[] txt_exp = null;
		String[]txt_iyear= null;
		String[]txt_iiyear= null;
		String[]txt_iiiyear= null;
		
		String[] txt_src = null;
		String[]txt_iyearsrc= null;
		String[]txt_iiyearsrc= null;
		String[]txt_iiiyearsrc= null;
		
		String[] txt_item1 = null;
		String[]txt_unit= null;
		String[]txt_cost= null;
		try 
		{
			
			
			txt_noperson = (String[]) hshValues.get("txt_noperson");
			txt_salarypm= (String[]) hshValues.get("txt_salarypm");
			//txt_salarypy= (String[]) hshValues.get("txt_salarypy");
			//strid = correctNull((String) hshValues.get("hid_sno"));
			
			txt_exp = (String[]) hshValues.get("txt_exp");
			txt_iyear= (String[]) hshValues.get("txt_iyear");
			txt_iiyear= (String[]) hshValues.get("txt_iiyear");
			txt_iiiyear= (String[]) hshValues.get("txt_iiiyear");
			
			txt_src = (String[]) hshValues.get("txt_src");
			txt_iyearsrc= (String[]) hshValues.get("txt_iyearsrc");
			txt_iiyearsrc= (String[]) hshValues.get("txt_iiyearsrc");
			txt_iiiyearsrc= (String[]) hshValues.get("txt_iiiyearsrc");
			
			
			txt_item1 = (String[]) hshValues.get("txt_item1");
			txt_unit = (String[])hshValues.get("txt_unit");
			txt_cost= (String[])hshValues.get("txt_cost");
			
			
			/*strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshResult.put("applicantid", rs.getString("demo_appid"));
			}*/
			if (strAction.equals("delete"))
			{
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				
				hshQuery.put("strQueryId", "per_del_poultrybroifindata");
				arrValues.add(appno);
				arrValues.add(appno);
				arrValues.add(appno);
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				//EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
			
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId", "agr_del_poultryfinperdata");
				arrValues.add(appno);
				arrValues.add(prd_type);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				//EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId", "del_poultry_expenses");
				arrValues.add(appno);
				arrValues.add(prd_type);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				//EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId", "del_poultry_non_recurring");
				arrValues.add(appno);
				arrValues.add(prd_type);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				hshQueryValues.put("size", ""+intUpdatesize);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQuery= new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				arrValues.add(appno);
				
				hshQuery.put("strQueryId", "per_del_poultrybroifindata");
				hshQuery.put("arrValues",arrValues);	
				
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
				hshQuery= new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				
				arrValues.add(appno);
				arrValues.add(txt_nochicks);
				arrValues.add(txt_costchicks);
				arrValues.add(txt_totalcostchicks);
				arrValues.add(txt_costchickmash);
				arrValues.add(txt_conchickmash);
				arrValues.add(txt_totalchickmash);
				arrValues.add(txt_costgrowermash);
				arrValues.add(txt_congrowermash);
				arrValues.add(txt_totalgrowermash);
				arrValues.add(txt_totalfeedcon);
				arrValues.add(txt_totalfeedcost);
				arrValues.add(txt_broodingmor);
				arrValues.add(txt_broodingchicks);
				arrValues.add(txt_specify1);
				arrValues.add(txt_specify2);
				arrValues.add(txt_electricitycharge);
				arrValues.add(txt_watercharge);
				arrValues.add(txt_vtaid);
				arrValues.add(txt_inspremium);
				arrValues.add(txt_yieldegg);
				arrValues.add(txt_totsaleegg);
				arrValues.add(txt_yieldmanure);
				arrValues.add(txt_salemanure);
				arrValues.add(txt_salegunny);
				arrValues.add(txt_emptybag);
				arrValues.add(txt_transportcharge);
			    arrValues.add(txt_totalvtaid);
				arrValues.add(txt_totalinspremium);
				arrValues.add(txt_totsalemanure);
				arrValues.add(txt_totsalebag);
				arrValues.add(prd_type);
				
				
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agr_ins_poultrybroifindata");
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				
			
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				
				hshQuery.put("strQueryId", "agr_del_poultryfinperdata");
				arrValues.add(appno);
				arrValues.add(prd_type);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				
				//hshQueryValues.put("size", ""+intUpdatesize);
				//EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				

				for (int i = 0; i < txt_noperson.length; i++)
				{					
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize = intUpdatesize + 1;
					
					arrValues.add(appno);
					arrValues.add(new Integer(i + 1).toString());
					arrValues.add(correctNull(txt_noperson[i]));
					arrValues.add(correctNull(txt_salarypm[i]));
					arrValues.add(prd_type);
				   	arrValues.add("");
				   	
					hshQuery.put("strQueryId", "per_ins_poultryfinperdata");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}
				hshQueryValues.put("size", ""+intUpdatesize);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
			}
			if (strAction.equals("insert"))
			{
			
			 hshQuery3 = new HashMap();
			arrValues3 = new ArrayList();
			hshQuery3.put("size", "1");
			hshQuery3.put("strQueryId", "del_poultry_expenses");
			arrValues3.add(appno);
			arrValues3.add(prd_type);
			hshQuery3.put("arrValues", arrValues3);
			hshQueryValues.put("1", hshQuery3);
			hshQueryValues.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
			intUpdatesize2 = 1;
			
			for (int j = 0; j<5; j++)
			{
				if(txt_exp[j].equalsIgnoreCase(""))
					continue;
				intUpdatesize2 = intUpdatesize2 + 1;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_poultry_expenses");
				arrValues.add(appno);
				if(txt_exp[j].equalsIgnoreCase(""))
				{
					txt_exp[j] = "";
				}
				arrValues.add(txt_exp[j]);
				if(txt_iyear[j].equalsIgnoreCase(""))
				{
					txt_iyear[j] = "0";
				}
				arrValues.add(txt_iyear[j]);
				
				arrValues.add(txt_iiyear!=null ?txt_iiyear[j]:"");
				
				arrValues.add(txt_iiiyear!=null ? txt_iiiyear[j]:"");
				arrValues.add("E");
				arrValues.add(prd_type);
				arrValues.add(""+(j));
				hshQuery.put("arrValues", arrValues);	
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			intUpdatesize2 = 1;
			for (int l = 0; l<3; l++)
			{
				if(!txt_src[l].equalsIgnoreCase(""))
				{
					intUpdatesize2 = intUpdatesize2 + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_poultry_expenses");
					arrValues.add(appno);
					if(txt_src[l].equalsIgnoreCase(""))
					{
						txt_src[l] = "";
					}
					arrValues.add(txt_src[l]);
					if(txt_iyearsrc[l].equalsIgnoreCase(""))
					{
						txt_iyearsrc[l] = "0";
					}
					arrValues.add(txt_iyearsrc[l]);
					if(txt_iiyearsrc[l].equalsIgnoreCase(""))
					{
						txt_iiyearsrc[l] = "0";
					}
					arrValues.add(txt_iiyearsrc[l]);
					if(txt_iiiyearsrc[l].equalsIgnoreCase(""))
					{
						txt_iiiyearsrc[l] = "0";
					}
					arrValues.add(txt_iiiyearsrc[l]);
					arrValues.add("S");
					arrValues.add(prd_type);
					arrValues.add(""+(l+1));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
			}
			
			}
			if (strAction.equals("insert"))
			{
				
			 hshQuery3 = new HashMap();
			 arrValues3 = new ArrayList();
			hshQuery3.put("size", "1");
			hshQuery3.put("strQueryId", "del_poultry_non_recurring");
			arrValues3.add(appno);
			arrValues3.add(prd_type);
			hshQuery3.put("arrValues", arrValues3);
			hshQueryValues.put("1", hshQuery3);
			hshQueryValues.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			intUpdatesize = 1;
			for (int i =0; i <=3; i++)
			{
				intUpdatesize = intUpdatesize + 1;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_poultry_non_recurring");
				arrValues.add(appno);
				arrValues.add(Integer.toString(i+1));
				if(txt_item1[i].equalsIgnoreCase(""))
				{
					txt_item1[i] = "";
				}
				arrValues.add(txt_item1[i]);
				if(txt_unit[i].equalsIgnoreCase(""))
				{
					txt_unit[i] = "0";
				}
				arrValues.add(txt_unit[i]);
				if(txt_cost[i].equalsIgnoreCase(""))
				{
					txt_cost[i] = "0";
				}
				arrValues.add(txt_cost[i]);
				
				arrValues.add("0");
				arrValues.add("N");
				arrValues.add(prd_type);
			    hshQuery.put("arrValues", arrValues);	
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
		
			}
	
			//Audit Trial
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{
			sbAuditTrial
			.append("Financial Data ^")
			.append("~No. of Broiler Chicks purchased per batch = ") .append(txt_nochicks)
			.append("~Cost per day-old chick = ") .append(txt_costchicks)
			.append("~Total Cost of Broiler Birds per batch = ") .append(txt_totalcostchicks)
			.append("<br>")
			
			.append("~Feeding Expenses ^")
			.append("~Starter Mash cost per kg(Rs.) = ") .append(txt_costchickmash)
			.append("~Starter Mash consumption of feed/bird(Kgs) = ") .append(txt_conchickmash)
			.append("~Starter Mash Cost of Consumption of feed/bird(Rs.) = ") .append(txt_totalchickmash)
			.append("~Finisher Mash cost per kg(Rs.) = ") .append(txt_costgrowermash)
			.append("~Finisher Mash consumption of feed/bird(Kgs) = ") .append(txt_congrowermash)
			.append("~Finisher Mash Cost of Consumption of feed/bird(Rs.) = ") .append(txt_totalgrowermash)
			.append("<br>")
			
			.append("~Mortality Provision ^")
			.append("~Broiler % of Mortality = ") .append(txt_broodingmor)
			.append("~Broiler No. of Chicks per Batch(After Mortality) = ") .append(txt_broodingchicks)
			.append("<br>")
			
			.append("~Expenditure on salaries/wages ^");
			for (int i = 0; i < txt_noperson.length; i++)
			{					
				sbAuditTrial
				.append(strDesc_1[i])
				.append("~No.of Persons = ")
				.append(correctNull(txt_noperson[i]))
				.append("~Salary per month(Rs.) = ")
				.append(correctNull(txt_salarypm[i]));
			}
			
			sbAuditTrial
			.append("<br>")
			.append("~Miscellaneous Expenses on ^")
			.append("~Electricity Rs. = ") .append(txt_electricitycharge).append(" per month")
			.append("~Water Charges Rs. = ") .append(txt_watercharge).append(" per month")
			.append("~Veterinary Aid Expenses  Rs. = ") .append(txt_vtaid).append(" per Bird")
			.append("~Insurance Premium = ") .append(txt_inspremium).append(" per Bird")
			.append("~Transportation Charges = ") .append(txt_transportcharge).append(" per Batch")
			
			.append("<br>")
			.append("~Other Expenses ^");
			for (int j = 0; j<5; j++)
			{
			sbAuditTrial
			.append("~")
			.append(txt_exp[j] +"^")
			.append("~I Year(Rs.) = ")
			.append(txt_iyear[j])
			.append("~II Year(Rs.) = ")
			.append(txt_iiyear[j])
			.append("~III Year (OnWards)(Rs.) = ")
			.append(txt_iiiyear[j]);
			}
			
			sbAuditTrial
			.append("<br>")
			.append("~Average Sale price per Broiler Bird(Rs.) = ") .append(txt_yieldegg)
			.append("~Total realisation from sale of Broilers/Batch(Rs.) = ") .append(txt_totsaleegg)
			.append("~Average yield of manure per batch = ") .append(txt_yieldmanure).append(" kgs")
			.append("~Average sale price of Manure(Rs.) = ") .append(txt_salemanure).append(" /tonne")
			.append("~Total sales realisation from Manure/batch(Rs.) = ") .append(txt_totsalemanure)
			.append("~Sale Price of empty Gunny Bags(Rs.) = ") .append(txt_salegunny).append(" /bag") 	
			.append("~No.of empty bags = ") .append(txt_emptybag).append(" /batch")
			.append("~Total sales realisation from empty bags/batch(Rs.) = ") .append(txt_totsalebag)
			.append("<br>")
			
			.append("~Other Sources of Income ^");
			for (int l = 0; l<3; l++)
			{
				sbAuditTrial
				.append("~")
				.append(txt_src[l] + "^")
				.append("~I year(Rs.) = ")
				.append(txt_iyearsrc[l])
				.append("~II year(Rs.) = ")
				.append(txt_iiyearsrc[l])
				.append("~III year(onwards)(Rs.) = ")
				.append(txt_iiiyearsrc[l]);
			}
			sbAuditTrial
			.append("<br>")
			.append("~Purchase of Equipments/Machinery/cages ^");
			for (int i =0; i <=3; i++)
			{
				sbAuditTrial
				.append("~Specifications = ")
				.append(txt_item1[i])
				.append("~No. of units = ")
				.append(txt_unit[i])
				.append("~Unit Cost(Rs.) = ")
				.append(txt_cost[i]);
			}
			if(correctNull((String)hshValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
			{
				hshValues.put("strAction", "update");
			}
			}
			AuditTrial.auditLog(hshValues,"253",appno,sbAuditTrial.toString());
			//
			hshpasValues.put("prd_type",prd_type);
			hshpasValues.put("appno", appno);
			hshResult = getpoultrybroilerfindata(hshpasValues);
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} 
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
			} 
			catch (Exception e1) 
			{
				throw new EJBException("Error in closing Connection "+ e1.getMessage());
			}
		}
		return hshResult;
	}
	//broiler ninrec
	public void updatebroinonrecurringData(HashMap hshRequestValues) 
	{
		String appno=correctNull((String)hshRequestValues.get("appno"));
		//String productType=Helper.correctNull((String)hshRequestValues.get("strProductType"));
		
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno=correctNull((String)hshRequestValues.get("strappno"));
		}
		HashMap hshQueryValues = new HashMap();
		HashMap hshQueryValues1 = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();		
		String[] txt_sq= null;
		String[] txt_value = null;
		String[] txt_unit= null;
		String[] txt_cost = null;
		String[] txt_loanamount = null;
		String[] txt_specify= null;
		String strAction = Helper.correctNull((String)hshRequestValues.get("hidAction"));
		ResultSet rs = null;
		String txt_totalloanamount= correctNull((String)hshRequestValues.get("txt_totalloanamount"));
		
		int intUpdatesize = 0;
		try
		{		
			txt_sq = (String[])hshRequestValues.get("txt_sq");
			txt_value = (String[])hshRequestValues.get("txt_value");
			txt_specify= (String[])hshRequestValues.get("txt_specify");
			txt_unit= (String[])hshRequestValues.get("txt_unit");
			txt_cost = (String[])hshRequestValues.get("txt_cost");
			
			txt_loanamount = (String[])hshRequestValues.get("txt_loanamount");
			int intUpdatesize1=0;
			if (strAction.equals("insert"))
			{
			
			 hshQuery = new HashMap();
			 arrValues = new ArrayList();
			hshQuery.put("size", "1");
			hshQuery.put("strQueryId", "del_poultry_broinonrecurring");
			arrValues.add(appno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues1.put("1", hshQuery);
			hshQueryValues1.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			intUpdatesize = 1;
			for (int j = 0; j < 1; j++)
			{
				intUpdatesize1 = intUpdatesize1 + 1;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_poultry_broinonrecurring");
				arrValues.add(appno);
				arrValues.add("11");
				arrValues.add("");
				arrValues.add("0");
				arrValues.add("0");
				
				arrValues.add("0");
				arrValues.add("0");
				if(txt_totalloanamount.equalsIgnoreCase(""))
				{
					txt_totalloanamount= "";
				}
				arrValues.add(txt_totalloanamount);
				arrValues.add("N");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			intUpdatesize = 0;
			for (int i =0; i <=9; i++)
			{
				intUpdatesize = intUpdatesize + 1;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_poultry_broinonrecurring");
				arrValues.add(appno);
				arrValues.add(Integer.toString(intUpdatesize));
				if(txt_specify[i].equalsIgnoreCase(""))
				{
					txt_specify[i] = "0";
				}
				arrValues.add(txt_specify[i]);
				if(txt_sq[i].equalsIgnoreCase(""))
				{
					txt_sq[i] = "0";
				}
				arrValues.add(txt_sq[i]);
				if(txt_value[i].equalsIgnoreCase(""))
				{
					txt_value[i] = "0";
				}
				arrValues.add(txt_value[i]);
				if(txt_unit[i].equalsIgnoreCase(""))
				{
					txt_unit[i] = "0";
				}
				arrValues.add(txt_unit[i]);
				if(txt_cost[i].equalsIgnoreCase(""))
				{
					txt_cost[i] = "0";
				}
				arrValues.add(txt_cost[i]);
				if(txt_loanamount[i].equalsIgnoreCase(""))
				{
					txt_loanamount[i] = "0";
				}
				arrValues.add(txt_loanamount[i]);
				arrValues.add("N");
			   hshQuery.put("arrValues", arrValues);	
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			}
         
			if(strAction.equalsIgnoreCase("delete"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "1");
				hshQuery3.put("strQueryId", "del_poultry_broinonrecurring");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				hshQueryValues1.put("1", hshQuery3);
				hshQueryValues1.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			}
			
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{
			sbAuditTrial.append("~Particulars ^");
			sbAuditTrial
			.append("~Other Civil Works ^")
			.append("<br>");
			for (int i =0; i <=5; i++)
			{
				sbAuditTrial
				.append("~Construction of = ")
				.append(txt_specify[i])
				.append("~shed measuring = ")
				.append(txt_sq[i])
				.append("~sq ft @ Rs. = ")
				.append(txt_value[i])
				.append("~per sq ft. ^")
				.append("~No of units = ")
				.append(txt_unit[i]) 
				.append("~Cost per unit = ")
				.append(txt_cost[i])
				.append("~Amount(Rs.) = ")
				.append(txt_loanamount[i]);
			}
			sbAuditTrial
			.append("~Purchase of Equipments ^")
			.append("<br>");
			for (int i =6; i <=9; i++)
			{
				sbAuditTrial
				.append("~Name of equipments with specifications = ")
				.append(txt_specify[i])
				.append("~No of units = ")
				.append(txt_unit[i])
				.append("~Cost per unit = ")
				.append(txt_cost[i])
				.append("~Amount(Rs.) = ")
				.append(txt_loanamount[i]);
			}
			sbAuditTrial
			.append("~Total(Rs.) = ")
			.append(txt_totalloanamount);
			if(correctNull((String)hshRequestValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
			{
				hshRequestValues.put("strAction", "update");
			}
			}
			AuditTrial.auditLog(hshRequestValues,"254",appno,sbAuditTrial.toString());
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
	public HashMap getbroinonrecurringData(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;ResultSet rs2 = null;
		HashMap hshRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		ArrayList arryRow1 = new ArrayList();
		ArrayList arryCol1 = null;
		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}
		String appno=correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
	    String PageType=Helper.correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
        {
        	 PageType=Helper.correctNull((String)hshValues.get("hidpagetype"));
        }
        
		try 
		{
			/*strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}*/
			strQuery = SQLParser.getSqlQuery("sel_poultry_broinonrecurring^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			arryCol = new ArrayList();
			arryRow = new ArrayList();
			boolean booParticulars = false;
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(appno);
				arryCol.add(rs.getString("poultry_specify"));
				arryCol.add(rs.getString("poultry_sq"));
				arryCol.add(rs.getString("poultry_value"));
				arryCol.add(rs.getString("poultry_unit"));
				arryCol.add(rs.getString("poultry_cost"));
				arryCol.add(rs.getString("poultry_loanamount"));
				arryRow.add(arryCol);
				booParticulars = true;
			}
			
			strQuery = SQLParser.getSqlQuery("sel_poultry_non_recurring^" + appno+"^"+prd_type);
			rs = DBUtils.executeQuery(strQuery);
			arryCol1 = new ArrayList();
			arryRow1 = new ArrayList();
			while (rs.next())
			{
				arryCol1 = new ArrayList();
				arryCol1.add(appno);
				arryCol1.add(rs.getString("poultry_item"));
				arryCol1.add(rs.getString("poultry_unit"));
				arryCol1.add(rs.getString("poultry_cost"));
				arryCol1.add(rs.getString("poultry_loan_amount"));
				arryRow1.add(arryCol1);
			}
			if(booParticulars == true)
			{
				hshRecord.put("auditFlag", "Y");
			}
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("arryRow1", arryRow1);
			
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
					rs = null;
				}
				 if (rs1 != null)
				    {
					rs1.close();
				    }
				 if (rs2 != null)
				    {
					rs2.close();
				    }
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}
//broi recurring

	public void updatebroirecurringData(HashMap hshValues) 
	{
		String appno=correctNull((String)hshValues.get("appno"));
		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}
		if(appno.equalsIgnoreCase("null") ||  appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
		//String appno1=correctNull((String)hshValues.get("appno1"));
		String strappno=correctNull((String)hshValues.get("strappno"));
		String strAction=null;//String strAction1=null;//String strAction2=null;
		strAction = correctNull((String) hshValues.get("hidAction"));
		//strAction1 = correctNull((String) hshValues.get("hidAction1"));
		//strAction2 = correctNull((String) hshValues.get("hidAction2"));
		String strAction3 = correctNull((String) hshValues.get("hidAction3"));
		String  txt_totalloanamount = correctNull((String) hshValues.get("txt_totalloanamount"));
		//String  txt_marginper= correctNull((String) hshValues.get("txt_marginper"));
		//String  txt_subsidy= correctNull((String) hshValues.get("txt_subsidy"));
		//String  txt_margin= correctNull((String) hshValues.get("txt_margin"));
		//String  txt_subsidyper= correctNull((String) hshValues.get("txt_subsidyper"));
		//String  txt_totalloanamount1= correctNull((String) hshValues.get("txt_totalloanamount1"));
		//String  txt_totalloanamount2= correctNull((String) hshValues.get("txt_totalloanamount2"));
		
		HashMap hshQueryValues = new HashMap();
		HashMap hshQueryValues1 = new HashMap();
		ArrayList arrValues3 = new ArrayList();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();	
		HashMap hshQuery3 = new HashMap();
		String[] txt_value1= null;
		String[] txt_value2 = null;
		String[] txt_value3=null;
		String[] strDesc_1={"~Labourers salary/wages  = ","~Manager salary/wages  = ","~Supervisors salary/wages  = ","~others ie. "+Helper.correctNull((String)hshValues.get("txt_specify1"))+" salary/wages  = ","~others ie "+Helper.correctNull((String)hshValues.get("txt_specify2"))+" salary/wages  = ","~Water charge:Rs.  = ","~Electricity charges Rs.  = ","~Veterinary aid Rs.  =  ","~Insurance of birds @ Rs.  =  ","~Transportation charges @ Rs.  =  "};
		String[] strDesc_2={"~no.of labourers @Rs.  =  ","~no.of Managers @Rs.  =  ","~no.of Supervisors @Rs  = ","~no.of persons @Rs.  = ","~no.of persons @Rs.  = ","~per month for   = ","~per month for   = ","~per batch for  = ","~per batch for   = ","~per batch for   = " };
		String[] strDesc_3={"~per labourer p.m for  =  ","~per Manager p.m for   = ","~per Supervisor p.m for   = ","~per person p.m for   = ","~per person p.m for  = ","~months ^","~months  ^","~number of batches ^","~number of batches ^","~number of batches ^" };
		String[] txt_item1= null;
		String[] txt_amount1 = null;
		String[] txt_amount = null;
		String[] txt_month1 = null;
		String[] txt_cost1= null;
		String[] txt_costval1=null;
		/*if(appno.equalsIgnoreCase(""))
		{
			appno=appno1;
		}*/
		if(appno.equalsIgnoreCase(""))
		{
			appno=strappno;
		}		
		ResultSet rs = null;
		int intUpdatesize = 0;	int intUpdatesize1 = 0;
		try
		{		
			 txt_value1= (String[]) hshValues.get("txt_value1");
			 txt_value2= (String[])hshValues.get("txt_value2");
			 txt_value3= (String[])hshValues.get("txt_value3");
			 txt_item1 = (String[]) hshValues.get("txt_item1");
			txt_amount1 = (String[])hshValues.get("txt_amount1");
			txt_amount = (String[])hshValues.get("txt_amount");
			 txt_cost1 = (String[])hshValues.get("txt_cost1");
			 txt_month1 = (String[])hshValues.get("txt_month1");
			 txt_costval1=(String[])hshValues.get("txt_costval1");
			txt_totalloanamount= correctNull((String)hshValues.get("txt_totalloanamount"));			
			if (strAction.equals("insert"))
			{
			
			 hshQuery = new HashMap();
			 arrValues = new ArrayList();
			hshQuery.put("size", "1");
			hshQuery.put("strQueryId", "del_poultry_broirecurring");
			arrValues.add(appno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues1.put("1", hshQuery);
			hshQueryValues1.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			intUpdatesize = 1;
			for (int j = 0; j < 1; j++)
			{
				intUpdatesize1 = intUpdatesize1 + 1;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_poultry_broirecurring");
				arrValues.add(appno);
				arrValues.add("13");
				arrValues.add("");
				arrValues.add("0");
				arrValues.add("0");
				
				arrValues.add("0");
				arrValues.add("0");
				if(txt_totalloanamount.equalsIgnoreCase(""))
				{
					txt_totalloanamount= "";
				}
				arrValues.add(txt_totalloanamount);
				arrValues.add("R");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			intUpdatesize = 1;
			for (int i =0; i <=11; i++)
			{
				intUpdatesize = intUpdatesize + 1;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_poultry_broirecurring");
				arrValues.add(appno);
				arrValues.add(Integer.toString(i+1));
				if(txt_value1[i].equalsIgnoreCase(""))
				{
					txt_value1[i] = "0";
				}
				arrValues.add(txt_value1[i]);
				if(txt_value2[i].equalsIgnoreCase(""))
				{
					txt_value2[i] = "0";
				}
				arrValues.add(txt_value2[i]);
				if(txt_value3[i].equalsIgnoreCase(""))
				{
					txt_value3[i] = "0";
				}
				arrValues.add(txt_value3[i]);
				
				arrValues.add("0");
				
				arrValues.add("0");
				if(txt_amount[i].equalsIgnoreCase(""))
				{
					txt_amount[i] = "0";
				}
				arrValues.add(txt_amount[i]);
				arrValues.add("R");
			   hshQuery.put("arrValues", arrValues);	
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			}
         
			if(strAction.equalsIgnoreCase("delete"))
			{
				 hshQuery3 = new HashMap();
				arrValues3 = new ArrayList();
				hshQuery3.put("size", "1");
				hshQuery3.put("strQueryId", "del_poultry_broirecurring");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				hshQueryValues1.put("1", hshQuery3);
				hshQueryValues1.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
				
				 hshQuery3 = new HashMap();
				 arrValues3 = new ArrayList();
				hshQuery3.put("size", "1");
				hshQuery3.put("strQueryId", "upd_poultry_recurring");
				arrValues3.add(appno);
				arrValues3.add(prd_type);
				hshQuery3.put("arrValues", arrValues3);
				hshQueryValues1.put("1", hshQuery3);
				hshQueryValues1.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			}
			/*if (strAction1.equals("delete2"))
			{
				hshQuery = new HashMap();
				HashMap hshQueryValues5 = new HashMap();
				ArrayList arrValues5 = new ArrayList();
				hshQueryValues5.put("size", "1");
				hshQuery.put("strQueryId", "agr_del_sheeploanamountdata");
				arrValues5.add(appno);
				arrValues5.add(prd_type);
				hshQuery.put("arrValues", arrValues5);
				hshQueryValues5.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues5,"updateData");
			}
			/*if(strAction.equalsIgnoreCase("insert"))
			{
				hshQuery= new HashMap();
				ArrayList arrValues1 = new ArrayList();
				hshQuery.put("size", "2");
				hshQuery.put("strQueryId", "agr_del_sheeploanamountdata");
				arrValues1.add(appno);
				arrValues1.add(prd_type);
				hshQuery.put("arrValues",arrValues1);	
				hshQueryValues.put("1",hshQuery);
				hshQuery= new HashMap();
				arrValues1 = new ArrayList();
				arrValues1.add(appno);
				arrValues1.add(txt_totalloanamount);
				arrValues1.add(txt_marginper);
				arrValues1.add(txt_margin);
				arrValues1.add(txt_subsidyper);
				arrValues1.add(txt_subsidy);
				if(txt_totalloanamount2.equalsIgnoreCase(""))
				{
					arrValues1.add(txt_totalloanamount2);	
				}
				else{
				arrValues1.add(txt_totalloanamount1);
					
				}
				
				arrValues1.add("");	
				arrValues1.add("");	
				arrValues1.add("");	
				arrValues1.add(prd_type);
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues1);
				hshQuery.put("strQueryId", "agr_ins_sheeploanamountdata");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}*/
			
			if (strAction.equals("insert"))
			{
			
			 hshQuery3 = new HashMap();
			 arrValues3 = new ArrayList();
			hshQuery3.put("size", "1");
			hshQuery3.put("strQueryId", "del_poultry_recurring");
			arrValues3.add(appno);
			arrValues3.add(prd_type);
			hshQuery3.put("arrValues", arrValues3);
			hshQueryValues1.put("1", hshQuery3);
			hshQueryValues1.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			intUpdatesize = 1;
			for (int i =0; i <=4; i++)
			{
				intUpdatesize = intUpdatesize + 1;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_poultry_recurring");
				arrValues.add(appno);
				arrValues.add(Integer.toString(i+1));
				if(txt_item1[i].equalsIgnoreCase(""))
				{
					txt_item1[i] = "";
				}
				arrValues.add(txt_item1[i]);
				if(txt_cost1[i].equalsIgnoreCase(""))
				{
					txt_cost1[i] = "0";
				}
				arrValues.add(txt_cost1[i]);
				//arrValues.add("0");
				if(txt_month1[i].equalsIgnoreCase(""))
				{
					txt_month1[i] = "0";
				}
				arrValues.add(txt_month1[i]);
				if(txt_amount1[i].equalsIgnoreCase(""))
				{
					txt_amount1[i] = "0";
				}
				arrValues.add(txt_amount1[i]);
				arrValues.add("R");
				arrValues.add(prd_type);
			    hshQuery.put("arrValues", arrValues);	
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
		   
			}
			ArrayList arrValues4= new ArrayList();
			if(strAction3.equalsIgnoreCase("insert3"))
			{
				arrValues4= new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","agr_del_poultry_labcharge");
				arrValues4.add(appno);
				arrValues4.add(prd_type);
				hshQuery.put("arrValues",arrValues4);
				hshQueryValues.put("1",hshQuery);
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(correctNull((String) hshValues.get("txt_labourcharge")));
				arrValues.add(prd_type);
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agr_ins_poultry_labcharge");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			 StringBuilder sbAuditTrial=new StringBuilder();
			 if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			 {
				sbAuditTrial
				.append("Particulars ^")
				.append("~Purchase of = ")
				.append(txt_value1[0])
				.append("~number of chicks/batch = ")
				.append(txt_value2[0])
				.append("~no. of batches,@Rs. = ")
				.append(txt_value3[0])
				.append(" per chick. ^")
				.append("~Amount = ")
				.append(txt_amount[0])
				
				.append("~Feeding of = ")
				.append(txt_value1[1])
				.append("~number of chicks/batch = ")
				.append(txt_value2[1])
				.append("~no. of batches,at = ")
				.append(txt_value3[1])
				.append(" per chick. ^")
				.append("~Amount = ")
				.append(txt_amount[1]);
				
				 sbAuditTrial.append("~Miscellaneous Expenses upto economic laying ^");
				 
				 for (int i =2; i <=11; i++)
					{
						 sbAuditTrial
						 .append(strDesc_1[i-2])
						 .append(txt_value1[i])
						 .append(strDesc_2[i-2])
						 .append(txt_value2[i])
						 .append(strDesc_3[i-2]);
						 if((i-2)<5)
						 {
							 sbAuditTrial
							 .append(txt_value3[i])
							 .append(" months. ^");
						 }
						 else
						 {
							 sbAuditTrial
							 .append(" ");
						 }
						 sbAuditTrial
						 .append("~Amount = ")
						 .append(txt_amount[i]);
					}
				 sbAuditTrial.append("~If Others Specify ^")
				 .append("~Particulars ^");
				 for (int i =0; i <=4; i++)
					{
					 sbAuditTrial
					 .append("~")
					 .append(txt_item1[i])
					 .append("~Rs = ")
					 .append(txt_costval1[i])
					 .append("~for = ")
					 .append(txt_month1[i])
					 .append(" months. ^")
					 .append("~Amount(Rs.) = ")
					 .append(txt_amount1[i]);
					}
				 sbAuditTrial
				 .append("~Total(Recurring Expenses)= ")
				 .append(correctNull((String) hshValues.get("txt_totalloanamount")))
				 .append("~Total(Non-Recurring Expenses)= ")
				 .append(correctNull((String) hshValues.get("txt_totalnonrecurring")))
				 .append("~Required Project Cost= ")
				 .append(correctNull((String) hshValues.get("txt_reqprojectcost")));
				 if(correctNull((String)hshValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
				 {
					 hshValues.put("strAction", "update");
				 }
			 }
				 
				 AuditTrial.auditLog(hshValues,"255",appno,sbAuditTrial.toString());
				 
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
	
	public  HashMap getbroirecurringData(HashMap hshValues) 
	{
 		ResultSet rs = null;
 		ResultSet rs1 = null;ResultSet rs2 = null;
 		String strQuery = "";
 		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}
 		HashMap hshRecord = new HashMap();
 		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		ArrayList arryRow1 = new ArrayList();
		ArrayList arryCol1 = null;
		ArrayList arryRow2 = new ArrayList();
		ArrayList arryCol2 = null;
		String appno = correctNull((String) hshValues.get("appno"));
 		if(appno.equalsIgnoreCase("null") ||  appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
        String PageType=Helper.correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
         {
      	 PageType=Helper.correctNull((String)hshValues.get("hidpagetype"));
         }
 		try 
		{
			/*strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}*/
			strQuery = SQLParser.getSqlQuery("agr_get_sheeploanamountdata^"+appno+"^"+prd_type);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) 
			{
				hshRecord.put("txt_totalamount", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_totalamount"))));
				hshRecord.put("txt_margin", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_marginper"))));
				hshRecord.put("txt_marginper", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_margin"))));
				hshRecord.put("txt_subsidyper", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_subsidyper"))));
				hshRecord.put("txt_subsidy", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_subsidy"))));
				hshRecord.put("txt_totalloanamount1", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_totalloanamount"))));
				
			}
			strQuery = SQLParser.getSqlQuery("agr_get_poultrybroifindata^"+appno+ "^" +prd_type);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) 
			{
				hshRecord.put("txt_nochicks", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_nochicks"))));
				hshRecord.put("txt_costchicks", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_costchicks"))));
				hshRecord.put("txt_totalcostchicks", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalcostchicks"))));
				hshRecord.put("txt_costchickmash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_costchickmash"))));
				hshRecord.put("txt_conchickmash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_conchickmash"))));
				hshRecord.put("txt_totalchickmash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalchickmash"))));
				hshRecord.put("txt_costgrowermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_costgrowermash"))));
				hshRecord.put("txt_congrowermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_congrowermash"))));
				hshRecord.put("txt_totalgrowermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalgrowermash"))));
				hshRecord.put("txt_totalfeedcon", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalfeedcon"))));
				hshRecord.put("txt_totalfeedcost", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalfeedcost"))));
				hshRecord.put("txt_broodingmor", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_broodingmor"))));
				hshRecord.put("txt_broodingchicks", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_broodingchicks"))));
				hshRecord.put("txt_specify1", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_specify1"))));
				hshRecord.put("txt_specify2", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_specify2"))));
				hshRecord.put("txt_electricitycharge", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_electricitycharge"))));
				hshRecord.put("txt_watercharge", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_watercharge"))));
				hshRecord.put("txt_vtaid", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_vtaid"))));
				hshRecord.put("txt_inspremium", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_inspremium"))));
				hshRecord.put("txt_yieldegg", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_yieldegg"))));
				hshRecord.put("txt_totsaleegg", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totsaleegg"))));
				hshRecord.put("txt_yieldmanure", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_yieldmanure"))));
				hshRecord.put("txt_salemanure", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_salemanure"))));
				hshRecord.put("txt_salegunny", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_salegunny"))));
				hshRecord.put("txt_emptybag", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_emptybag"))));
				hshRecord.put("txt_transportcharge", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_transportcharge"))));
				hshRecord.put("txt_totalvtaid", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalvtaid"))));
				hshRecord.put("txt_totalinspremium", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalinspremium"))));
				hshRecord.put("txt_totsalemanure", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totsalemanure"))));
				hshRecord.put("txt_totsalebag", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totsalebag"))));
				
			}
			
			
				 if (rs1 != null)
				    {
					rs1.close();
				    }
				
						 							 
			strQuery = SQLParser.getSqlQuery("per_get_poultryfinperdata^" + appno+ "^" +prd_type);
			rs = DBUtils.executeQuery(strQuery);
			ArrayList arryCol3 = new ArrayList();
			ArrayList arryRow3 = new ArrayList();
			while (rs.next())
			{
				arryCol3 = new ArrayList();
				arryCol3.add(appno);
				arryCol3.add(rs.getString("sno"));
				arryCol3.add(rs.getString("poultry_noperson"));
				arryCol3.add(rs.getString("poultry_salarypm"));
				arryCol3.add(rs.getString("poultry_salarypy"));
				arryRow3.add(arryCol3);
			}
										 
			strQuery = SQLParser.getSqlQuery("sel_poultry_broirecurring^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			arryCol = new ArrayList();
			arryRow = new ArrayList();
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(appno);
				arryCol.add(rs.getString("poultry_specify"));
				arryCol.add(rs.getString("poultry_sq"));
				arryCol.add(rs.getString("poultry_value"));
				arryCol.add(rs.getString("poultry_unit"));
				arryCol.add(rs.getString("poultry_cost"));
				arryCol.add(rs.getString("poultry_loanamount"));
				arryRow.add(arryCol);
				hshRecord.put("auditFlag", "Y");
			}
		
			strQuery = SQLParser.getSqlQuery("sel_poultry_exp^" + appno+"^"+prd_type+"^E");
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol1 = new ArrayList();
				arryCol1.add(rs.getString("poultry_expenses"));
				arryCol1.add(rs.getString("poultry_iyear"));
				arryCol1.add(rs.getString("poultry_iiyear"));
				arryCol1.add(rs.getString("poultry_iiiyear"));
				arryCol1.add(rs.getString("poultry_type"));
				arryRow1.add(arryCol1);
			}
			strQuery = SQLParser.getSqlQuery("sel_poultry_recurring^" + appno+"^"+prd_type);
			rs = DBUtils.executeQuery(strQuery);
			ArrayList arryCol4 = new ArrayList();
			ArrayList arryRow4= new ArrayList();
			
			while (rs.next())
			{
				arryCol4 = new ArrayList();
				arryCol4.add(rs.getString("poultry_item"));
				arryCol4.add(rs.getString("poultry_unit"));
				arryCol4.add(rs.getString("poultry_cost"));
				arryCol4.add(rs.getString("poultry_loan_amount"));
				
				arryRow4.add(arryCol4);
			}
			strQuery = SQLParser.getSqlQuery("sel_poultry_broinonrecurring^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			arryCol2 = new ArrayList();
			arryRow2 = new ArrayList();
			while (rs.next())
			{
				arryCol2 = new ArrayList();
				arryCol2.add(appno);
				arryCol2.add(rs.getString("poultry_specify"));
				arryCol2.add(rs.getString("poultry_sq"));
				arryCol2.add(rs.getString("poultry_value"));
				arryCol2.add(rs.getString("poultry_unit"));
				arryCol2.add(rs.getString("poultry_cost"));
				arryCol2.add(rs.getString("poultry_loanamount"));
				arryRow2.add(arryCol2);
			}
			if(rs!=null)rs.close();
			String strNonRecurringTotal=null;
			strQuery = SQLParser.getSqlQuery("get_nonrec_total^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				strNonRecurringTotal=rs.getString("tot_nonrec");
			}
			hshRecord.put("tot_non_recurring",Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(strNonRecurringTotal))));
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("arryRow1", arryRow1);
			hshRecord.put("arryRow2", arryRow2);
			hshRecord.put("arryRow3", arryRow3);
			hshRecord.put("arryRow4", arryRow4);
			hshRecord.put("PageType", PageType);
			
		} 
		catch(Exception ce)
		{
			throw new EJBException("Error in getcoopsocMasterList "+ce.toString());
		}
		finally 
		{
			try
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
				if (rs1 != null) 
				{
					rs1.close();
					rs1 = null;
				}
				if (rs2 != null) 
				{
					rs2.close();
				}
				
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}
	//broi flock
	public HashMap updatebroiagrflock(HashMap hshValues)  
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshpasValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs = null;
		HashMap hshResult = new HashMap();
		String strAction="";		
		String strApplicationNo = correctNull((String) hshValues.get("strappno"));
		if(strApplicationNo.equalsIgnoreCase(""))
		{
			strApplicationNo = Helper.correctNull((String)hshValues.get("appno"));
		}
		 strAction = correctNull((String) hshValues.get("hidAction"));
	  	String []txt_batch=null;
		String []txt_broodermon=null;
		
		int intUpdatesize=0;
		try
		{
			strApplicationNo=correctNull((String)hshValues.get("strappno"));
			if(strApplicationNo.equalsIgnoreCase(""))
			{
				strApplicationNo = Helper.correctNull((String)hshValues.get("appno"));
			}
			txt_batch=(String [])hshValues.get("txt_batch");
			txt_broodermon=(String [])hshValues.get("txt_broodermon");
			
			if (strAction.equals("insert"))
			{			
				hshQuery=new HashMap();
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","agr_broidelflockrep");
				intUpdatesize=1;
				hshQueryValues.put("1",hshQuery);
				for(int i=2;i<txt_batch.length+2;i++)
				{
					if(!txt_batch[i-2].equals(""))
					{
						intUpdatesize=intUpdatesize+1;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","agr_broiinsflockrep");
						arrValues.add(strApplicationNo);
						arrValues.add(new Integer(i-1).toString());
						if(correctNull(txt_batch[i-2]).equals(""))
						{
							arrValues.add("0");
						}
						else
						{
							arrValues.add(correctNull(txt_batch[i-2]));
						}if(correctNull(txt_broodermon[i-2]).equals(""))
						{
							arrValues.add("0");
						}
						else
						{
							arrValues.add(correctNull(txt_broodermon[i-2]));
						}
						
						hshQuery.put("arrValues",arrValues);	
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(i),hshQuery);		
					}
				}
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			} 	
			if(strAction.equals("delete"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agr_broidelflockrep");
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues",arrValues);	
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			hshpasValues.put("appno",strApplicationNo);
			hshResult=getbroiagrflock(hshpasValues);
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{
			for(int i=0;i<txt_batch.length;i++)
			{
				if(!txt_batch[i].equals(""))
				{
					sbAuditTrial
					.append("~Project Year = ")				
					.append(i+1)
					.append(" Year ^")
					.append("~No.of Batches Purchased = ")
					.append(correctNull(txt_batch[i]))
					.append("~No.of Batches Sold = ")
					.append(correctNull(txt_broodermon[i]));
				}
			}
			if(correctNull((String)hshValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
			{
				hshValues.put("strAction", "update");
			}
			}
			AuditTrial.auditLog(hshValues,"256",strApplicationNo,sbAuditTrial.toString());
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
	
	public HashMap getbroiagrflock(HashMap hshValues)  
	{		 
		ResultSet rs=null;
		HashMap hshResult=new HashMap();
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=null;		
		String strApplicationNo=correctNull((String)hshValues.get("strappno"));
		if(strApplicationNo.equalsIgnoreCase(""))
		{
			strApplicationNo = Helper.correctNull((String)hshValues.get("appno"));
		}
		try
		{
			rs=DBUtils.executeLAPSQuery("agr_broiselflockrep^"+strApplicationNo);			 
			while (rs.next())
			{
				arryCol=new ArrayList();
				arryCol.add(rs.getString("sno"));
				arryCol.add(rs.getString("agr_batch"));				
				arryCol.add(rs.getString("agr_broodermon"));
				
				arryRow.add(arryCol);
				hshResult.put("auditFlag", "Y");
			}
			hshResult.put("arryRow",arryRow);	
		} 
		catch (Exception e) 
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
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
	//broiler flow chart
//	expenditure
	public void updatepoultrybroiflowchartData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery =  new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=correctNull((String)hshValues.get("hidAction"));
		String appno=correctNull((String)hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("appno"));
		}
		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}
		ResultSet rs = null;
		try
		{			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","del_poultry_expenditure");
				arrValues.add(appno);
				arrValues.add(prd_type);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(correctNull((String) hshValues.get("txt_totiyearu")));
				arrValues.add(correctNull((String) hshValues.get("txt_totaliiyearu")));
				arrValues.add(correctNull((String) hshValues.get("txt_totaliiiyearu")));
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add(correctNull((String) hshValues.get("txt_totaliyearl")));
				arrValues.add(correctNull((String) hshValues.get("txt_totaliiyearl")));
				arrValues.add(correctNull((String) hshValues.get("txt_totaliiiyearl")));
				arrValues.add(correctNull((String) hshValues.get("txt_totaliyear2")));
				arrValues.add(correctNull((String) hshValues.get("txt_totaliiyear2")));
				arrValues.add(correctNull((String) hshValues.get("txt_totaliiiyear2")));
				
				arrValues.add(prd_type);
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "ins_poultry_expenditure");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_poultry_expenditure");
				arrValues.add(appno);
				arrValues.add(prd_type);
				hshQuery.put("arrValues",arrValues);
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
	}
//	flow chart
	public HashMap getpoultrybroiflowchartData(HashMap hshValues)  
	{
		String strQuery = "";
		
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;

		
		String prd_type = correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}
		
		HashMap hshRecord = new HashMap();
		
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		
		ArrayList arryRow1 = new ArrayList();
		ArrayList arryCol1 = null;
		
		ArrayList arryRow2 = new ArrayList();
		ArrayList arryCol2 = null;
		
		ArrayList arryRow3 = new ArrayList();
		ArrayList arryCol3 = null;
		
		ArrayList arrSal=new ArrayList();
		ArrayList arrChicks=new ArrayList();
		ArrayList arrFeedCost=new ArrayList();
		ArrayList arrWaterCharge=new ArrayList();
		ArrayList arrElectric=new ArrayList();
		ArrayList arrVetri=new ArrayList();
		ArrayList arrInsPre=new ArrayList();
		ArrayList arrTransport=new ArrayList();
		ArrayList arrTotalExpenses=new ArrayList();
		
		double dblexpforyear[]=new double[3];
		
		
		
		
		String appno=correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno =correctNull((String)hshValues.get("strappno"));
		}
		
	    String PageType=correctNull((String)hshValues.get("hidpagetype1"));
	    
        if(PageType.equalsIgnoreCase(""))
        {
        	 PageType=correctNull((String)hshValues.get("hidpagetype"));
        }
        
		try 
		{
			/*strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
				
			}*/
			
			strQuery = SQLParser.getSqlQuery("agr_broiselflockrep^" + appno);
			rs = DBUtils.executeQuery(strQuery);
						
				strQuery = SQLParser.getSqlQuery("sel_poultry_exp^" + appno+"^"+prd_type+"^E");
				rs = DBUtils.executeQuery(strQuery);
				//double poultry_iyear=0.00;
				while (rs.next())
				{
					int i=0;
					arryCol1 = new ArrayList();
					arryCol1.add(rs.getString("poultry_expenses"));
					dblexpforyear[i]=dblexpforyear[i]+Double.parseDouble((Helper.correctDouble((String)rs.getString("poultry_iyear"))));
					arryCol1.add(Helper.formatDoubleValue(Double.parseDouble((Helper.correctDouble((String)rs.getString("poultry_iyear"))))));
					i++;
					dblexpforyear[i]=dblexpforyear[i]+Double.parseDouble((Helper.correctDouble((String)rs.getString("poultry_iiyear"))));
					arryCol1.add(Helper.formatDoubleValue(Double.parseDouble((Helper.correctDouble((String)rs.getString("poultry_iiyear"))))));
					i++;
					dblexpforyear[i]=dblexpforyear[i]+Double.parseDouble((Helper.correctDouble((String)rs.getString("poultry_iiiyear"))));
					arryCol1.add(Helper.formatDoubleValue(rs.getDouble("poultry_iiiyear")));
					arryCol1.add(rs.getString("poultry_type"));
					arryRow1.add(arryCol1);
				}
				strQuery = SQLParser.getSqlQuery("sel_poultry_recurringdata^" + appno+"^"+prd_type);
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next())
				{
					arryCol = new ArrayList();                                                                         
					arryCol.add(rs.getString("poultry_loanamount"));
					arryRow.add(arryCol);
				}
				/*strQuery = SQLParser.getSqlQuery("agr_sel_poultry_labcharge^"+appno+"^"+prd_type);
				rs1 = DBUtils.executeQuery(strQuery);
				if (rs1.next()) 
				{
					hshRecord.put("labourcharge", Helper.correctDoubleQuote(correctNull(rs1.getString("labcharge"))));
					
					
				}*/
				rs=DBUtils.executeLAPSQuery("agr_broiselflockrep^"+appno);
				arryCol2=new ArrayList();
				while (rs.next())
				{
				//	arryCol2=new ArrayList();
					//arryCol2.add(rs.getString("sno"));
					arryCol2.add(rs.getString("agr_batch"));				
					//arryCol2.add(rs.getString("agr_broodermon"));
					
					//arryRow2.add(arryCol2);
				}
				if(arryCol2.size()<3)
				{
					hshRecord.put("nodata","Y");
					arryCol2.add("0.00");
					arryCol2.add("0.00");
					arryCol2.add("0.00");
				}
				strQuery = SQLParser.getSqlQuery("agr_get_poultrybroifindata^"+appno+ "^" +prd_type);
				rs1 = DBUtils.executeQuery(strQuery);
				double txt_watercharge=0.00;double txt_electricitycharge=0.00;
				String totalChicks="",totalfeedcost="",watercharge="",electricitycharge="",
				vtaid="",inspremium="",transportcharge="",nochicks="";
				if (rs1.next()) 
				{
					nochicks=Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_nochicks")));
					hshRecord.put("txt_costchicks", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_costchicks"))));
					totalChicks=Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalcostchicks")));
					hshRecord.put("txt_costchickmash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_costchickmash"))));
					hshRecord.put("txt_conchickmash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_conchickmash"))));
					hshRecord.put("txt_totalchickmash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalchickmash"))));
					hshRecord.put("txt_costgrowermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_costgrowermash"))));
					hshRecord.put("txt_congrowermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_congrowermash"))));
					hshRecord.put("txt_totalgrowermash", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalgrowermash"))));
					hshRecord.put("txt_totalfeedcon", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalfeedcon"))));
					totalfeedcost= Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalfeedcost")));
					hshRecord.put("txt_broodingmor", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_broodingmor"))));
					hshRecord.put("txt_broodingchicks", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_broodingchicks"))));
					hshRecord.put("txt_specify1", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_specify1"))));
					hshRecord.put("txt_specify2", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_specify2"))));
					electricitycharge=Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_electricitycharge")));
					watercharge=Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_watercharge")));
					//vtaid=Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_vtaid")));
					//inspremium=Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_inspremium")));
					hshRecord.put("txt_yieldegg", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_yieldegg"))));
					hshRecord.put("txt_totsaleegg", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totsaleegg"))));
					hshRecord.put("txt_yieldmanure", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_yieldmanure"))));
					hshRecord.put("txt_salemanure", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_salemanure"))));
					hshRecord.put("txt_salegunny", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_salegunny"))));
					hshRecord.put("txt_emptybag", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_emptybag"))));
					transportcharge=Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_transportcharge")));
					vtaid=Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalvtaid")));
					inspremium=Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totalinspremium")));
					hshRecord.put("txt_totsalemanure", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totsalemanure"))));
					hshRecord.put("txt_totsalebag", Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totsalebag"))));
					txt_electricitycharge = txt_watercharge+ Double.parseDouble((Helper.correctDouble((String)rs1.getString("poultry_electricitycharge"))));
					txt_watercharge = txt_watercharge+ Double.parseDouble((Helper.correctDouble((String)rs1.getString("poultry_watercharge"))));
				
				}
				if("".equals(nochicks))nochicks="0.00";
				if("".equals(totalChicks))totalChicks="0.00";
				if("".equals(totalfeedcost))totalfeedcost="0.00";
				if("".equals(electricitycharge))electricitycharge="0.00";
				if("".equals(watercharge))watercharge="0.00";
				if("".equals(transportcharge))transportcharge="0.00";
				if("".equals(vtaid))vtaid="0.00";
				if("".equals(inspremium))inspremium="0.00";
				strQuery = SQLParser.getSqlQuery("per_get_poultryfinperdata^" + appno+"^"+prd_type);
				rs = DBUtils.executeQuery(strQuery);
				double salarypy=0.00;//double noperson=0.00;
				double sal1=0.00;double sal2=0.00;double sal3=0.00;
				while (rs.next())
				{
					arryCol3 = new ArrayList();
					arryCol3.add(appno);
					arryCol3.add(rs.getString("sno"));
					arryCol3.add(rs.getString("poultry_noperson"));
					arryCol3.add(rs.getString("poultry_salarypm"));
					sal1=Double.parseDouble((Helper.correctDouble((String)rs.getString("poultry_noperson"))));
					sal2=Double.parseDouble((Helper.correctDouble((String)rs.getString("poultry_salarypm"))));
					sal3=sal1*sal2*12;
					arryCol3.add(rs.getString("poultry_salarypy"));
					salarypy=salarypy+sal3;
					arryRow3.add(arryCol3);
				}
				
				for(int i=0;i<arryCol2.size();i++)
				{
					dblexpforyear[i]=dblexpforyear[i]+(salarypy);
					arrSal.add(Helper.formatDoubleValue(salarypy));
					
					dblexpforyear[i]=dblexpforyear[i]+(Double.parseDouble(totalChicks)*Double.parseDouble((String)arryCol2.get(i)));
					arrChicks.add(Helper.formatDoubleValue((Double.parseDouble(totalChicks)*Double.parseDouble((String)arryCol2.get(i)))));
					
					dblexpforyear[i]=dblexpforyear[i]+(Double.parseDouble(nochicks)*Double.parseDouble(totalfeedcost)*Double.parseDouble((String)arryCol2.get(i)));
					arrFeedCost.add(Helper.formatDoubleValue((Double.parseDouble(nochicks)*Double.parseDouble(totalfeedcost)*Double.parseDouble((String)arryCol2.get(i)))));
					
					dblexpforyear[i]=dblexpforyear[i]+(Double.parseDouble(watercharge)*12.0);
					arrWaterCharge.add(Helper.formatDoubleValue((Double.parseDouble(watercharge)*12.0)));
					
					dblexpforyear[i]=dblexpforyear[i]+(Double.parseDouble(electricitycharge)*12.0);
					arrElectric.add(Helper.formatDoubleValue((Double.parseDouble(electricitycharge)*12.0)));
					
					dblexpforyear[i]=dblexpforyear[i]+(Double.parseDouble(vtaid)*Double.parseDouble((String)arryCol2.get(i)));
					arrVetri.add(Helper.formatDoubleValue((Double.parseDouble(vtaid)*Double.parseDouble((String)arryCol2.get(i)))));
					
					dblexpforyear[i]=dblexpforyear[i]+(Double.parseDouble(inspremium)*Double.parseDouble((String)arryCol2.get(i)));
					arrInsPre.add(Helper.formatDoubleValue((Double.parseDouble(inspremium)*Double.parseDouble((String)arryCol2.get(i)))));
					
					dblexpforyear[i]=dblexpforyear[i]+(Double.parseDouble(transportcharge)*12.0);
					arrTransport.add(Helper.formatDoubleValue((Double.parseDouble(transportcharge)*12.0)));
					
					arrTotalExpenses.add(Helper.formatDoubleValue(dblexpforyear[i]));
				}
				hshRecord.put("arrSal",arrSal);
				hshRecord.put("arrChicks",arrChicks);
				hshRecord.put("arrFeedCost",arrFeedCost);
				hshRecord.put("arrWaterCharge",arrWaterCharge);
				hshRecord.put("arrElectric",arrElectric);
				hshRecord.put("arrVetri",arrVetri);
				hshRecord.put("arrInsPre",arrInsPre);
				hshRecord.put("arrTransport",arrTransport);
				hshRecord.put("arrTotalExpenses",arrTotalExpenses);
				
				hshRecord.put("appno", appno);
				hshRecord.put("arryRow1", arryRow1);
				txt_watercharge=txt_watercharge*12;
				txt_electricitycharge=txt_electricitycharge*12;
				//hshRecord.put("salarypy",Helper.formatDoubleValue(salarypy));
				//hshRecord.put("txt_watercharge",Helper.formatDoubleValue(txt_watercharge));
				//hshRecord.put("txt_electricitycharge",Helper.formatDoubleValue(txt_electricitycharge));
				hshRecord.put("arryRow", arryRow);
				hshRecord.put("arryRow2", arryRow2);
				hshRecord.put("PageType", PageType);
				/*strQuery = SQLParser.getSqlQuery("sel_poultry_broirecurring^" + appno);
				rs = DBUtils.executeQuery(strQuery);
				ArrayList arryCol4 = new ArrayList();
				ArrayList arryRow4 = new ArrayList();
				while (rs.next())
				{
					arryCol4 = new ArrayList();
					arryCol4.add(appno);
					arryCol4.add(rs.getString("poultry_specify"));
					arryCol4.add(rs.getString("poultry_sq"));
					arryCol4.add(rs.getString("poultry_value"));
					arryCol4.add(rs.getString("poultry_unit"));
					arryCol4.add(rs.getString("poultry_cost"));
					arryCol4.add(rs.getString("poultry_loanamount"));
					arryRow4.add(arryCol4);
				}
				hshRecord.put("arryRow4", arryRow4);*/
				strQuery = SQLParser.getSqlQuery("sel_poultry_recurring^" + appno+"^"+prd_type);
				rs = DBUtils.executeQuery(strQuery);
				ArrayList arryCol5 = new ArrayList();
				ArrayList arryRow5= new ArrayList();
				
				while (rs.next())
				{
					arryCol5 = new ArrayList();
					arryCol5.add(rs.getString("poultry_item"));
					arryCol5.add(rs.getString("poultry_unit"));
					arryCol5.add(rs.getString("poultry_cost"));
					arryCol5.add(rs.getString("poultry_loan_amount"));
					
					arryRow5.add(arryCol5);
				}
				hshRecord.put("arryRow5", arryRow5);
			
			
			 
				HashMap hshQueryValues=new HashMap();
				HashMap hshQuery=new HashMap();
				ArrayList arrValues=new ArrayList();
			 	hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","del_poultry_expenditure");
				arrValues.add(appno);
				arrValues.add(prd_type);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(Helper.formatDoubleValue(dblexpforyear[0]));
				arrValues.add(Helper.formatDoubleValue(dblexpforyear[1]));
				arrValues.add(Helper.formatDoubleValue(dblexpforyear[2]));
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add(Helper.formatDoubleValue(dblexpforyear[0]));
				arrValues.add(Helper.formatDoubleValue(dblexpforyear[1]));
				arrValues.add(Helper.formatDoubleValue(dblexpforyear[2]));
				
				arrValues.add(prd_type);
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "ins_poultry_expenditure");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			
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
					rs = null;
				}
				 if (rs1 != null)
				    {
					rs1.close();
				    }
				 if (rs2 != null)
				    {
					rs2.close();
				    }
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}
	public HashMap getpoultryirr(HashMap hshValues)  
	{
		String strQuery = "";
		
		ResultSet rs = null;
		
		HashMap hshRecord = new HashMap();
		
		ArrayList arrRow1=new ArrayList();
		ArrayList arrRow11=new ArrayList();
		ArrayList arrData = new ArrayList();
		ArrayList arrIrrValues=new ArrayList();
		
		NumberFormat nf=NumberFormat.getNumberInstance();
		nf.setGroupingUsed(false);
		nf.setMaximumFractionDigits(6);
		nf.setMinimumFractionDigits(6);
		
		String prd_type = "";
		String appno = correctNull((String) hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("strappno"));
		}
       
        String PageType=correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
        {
        	 PageType=correctNull((String)hshValues.get("hidpagetype"));
        }
        
        int intnoofyrs=0;
		try 
		{
			double dblcostOfProject=0.0;
			strQuery = SQLParser.getSqlQuery("getloanproductdetails^"+ appno);			
			rs =DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				dblcostOfProject=rs.getDouble("loan_costloanprd");
				hshRecord.put("loan_begin",Helper.formatDoubleValue(dblcostOfProject));
				intnoofyrs=(int)Math.ceil(rs.getDouble("loan_reqterms")/12);
				prd_type=correctNull(rs.getString("prd_type"));
			}
			
			//intnoofyrs=10;
			
			if(rs!=null) rs.close();
			
		//For getting IRR-Cash Flow from Cash Flow Gross Income(Net Income) 	
			if(prd_type.equalsIgnoreCase("aE") || 				//for Animal Rearing 
					prd_type.equalsIgnoreCase("aK") ||  		//for common product
					prd_type.equalsIgnoreCase("aP") || 			//for poultry Layer
					prd_type.equalsIgnoreCase("aA") || 			//For Poultry Broiler
					prd_type.equalsIgnoreCase("aN") || 			//for Fisheris
					prd_type.equalsIgnoreCase("aD") || 			//for Diary Farming
					prd_type.equalsIgnoreCase("aJ") || 			//for Sericulture
					prd_type.equalsIgnoreCase("aF") || 			//for Farm Machinery
					prd_type.equalsIgnoreCase("aU") ||			//for Minor Irrigation
					prd_type.equalsIgnoreCase("aQ")) 			//for Long Term Plantation
			{
				strQuery = SQLParser.getSqlQuery("sel_cashflow^" + appno+"^"+prd_type);
				rs = DBUtils.executeQuery(strQuery);
				arrData = new ArrayList();
				String strProfit="";
				while (rs.next()) 
				{
					strProfit=correctNull(rs.getString("netprofit"));
					arrData.add(strProfit);
				}
			
				int len=arrData.size();
				for(int i=(len+1);i<=intnoofyrs;i++)
				{
					arrData.add(strProfit);
				}
			}
//			else if(prd_type.equalsIgnoreCase("aQ")  ) 
//			{
//				strQuery = SQLParser.getSqlQuery("sel_cashflowPlantation^" + appno);
//				rs = DBUtils.executeQuery(strQuery);
//				arrData = new ArrayList();
//				while (rs.next()) 
//				{
//					arrData.add(correctNull(rs.getString("surplus")));
//				}
//			}
			
				
/** IRR CALCULATION ADDED BY D.THADEUSE		*/
				double diffFactRate=15.00;
				double calValue=0.00;
				double totalValue=0.00;
			//	double grandTotal1=0.00;
				if(arrData!=null && arrData.size()>0)
				{
					while(diffFactRate<96)
					{
						arrRow1=new ArrayList();
						double grandTotal=0.00;
						for(int i=1;i<=intnoofyrs;i++)
						{
							
							calValue=1/Math.pow(((100+diffFactRate)/100),i);
							arrRow1.add(nf.format(calValue));
							totalValue=(Double.parseDouble(Helper.correctDouble((String)arrData.get(i-1)))* Double.parseDouble(nf.format(calValue)));
							arrRow1.add(Helper.formatDoubleValue(totalValue));
							grandTotal=grandTotal+totalValue;
						}
						
						arrRow1.add(Helper.formatDoubleValue(diffFactRate));
					//	grandTotal1=grandTotal-Double.parseDouble(costOfProject);
						arrRow1.add(Helper.formatDoubleValue(grandTotal-dblcostOfProject));
						arrRow11.add(arrRow1);
												
						diffFactRate+=5;
					}
					
					
					hshRecord.put("arrRow11",arrRow11);
					double diffFactRate1=0.00;
					double negTotalAmount=0.00;
					double preTotalAmount=0.00;
					double finalIrrAmount=0.00;
					for(int check=0;check<arrRow11.size();check++)
					{
						arrRow1=(ArrayList)arrRow11.get(check);
						
						if(Double.parseDouble((String)arrRow1.get((intnoofyrs*2)+1))<0.00)
						{
							
							arrIrrValues.add("5");
							negTotalAmount=Double.parseDouble((String)arrRow1.get((intnoofyrs*2)+1));
							arrIrrValues.add(Helper.formatDoubleValue(Math.abs(negTotalAmount)));
							if(Double.parseDouble(Helper.correctDouble((String)arrRow1.get(intnoofyrs*2)))==15)
							{
								preTotalAmount=0.00;
								arrIrrValues.add(Helper.formatDoubleValue(preTotalAmount));
								diffFactRate1=0;
								arrIrrValues.add(Helper.formatDoubleValue(diffFactRate1));
							}
							else
							{
								arrRow1=(ArrayList)arrRow11.get(check-1);
								preTotalAmount=Double.parseDouble((String)arrRow1.get((intnoofyrs*2)+1));
								arrIrrValues.add(Helper.formatDoubleValue(preTotalAmount));
								diffFactRate1=Double.parseDouble((String)arrRow1.get(intnoofyrs*2));
								arrIrrValues.add(Helper.formatDoubleValue(diffFactRate1));
							}
							break;
						}
											
					}
					if(negTotalAmount==0.00 && preTotalAmount==0.00)
					{
						arrIrrValues.add("5");
						arrIrrValues.add("0.00");
						arrIrrValues.add("0.00");
						arrIrrValues.add("0.00");
						arrIrrValues.add("0.00");
						finalIrrAmount=0.00;
					}
					else
					{
					finalIrrAmount=diffFactRate1+5*preTotalAmount/(preTotalAmount+Math.abs(negTotalAmount));
					}
					arrIrrValues.add(Helper.formatDoubleValue(finalIrrAmount));
					hshRecord.put("arrIrrValues",arrIrrValues);
				}
				hshRecord.put("appno", appno);
				hshRecord.put("arrData",arrData);
				hshRecord.put("noofyrs",Integer.toString(intnoofyrs));
				
				hshRecord.put("strProductType",prd_type);
			//end
			
		} 
		catch (Exception ce)
		{
			//throw new EJBException("Error in closing getData" + ce.getMessage());
			ce.printStackTrace();
		}
		finally 
		{
			try
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}
	
	
	
	
	public HashMap getpoultrybroiincomeflowData(HashMap hshValues) 
	{
		
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2=null;
		ResultSet rs3=null;
		ResultSet rs4=null;
		HashMap hshRecord = new HashMap();
		//ArrayList arryRow = new ArrayList();
		//ArrayList arryCol = null;
		ArrayList arryRow1 = new ArrayList();
		ArrayList arryCol1 = null;
		ArrayList arryCol2=new ArrayList();
		
		ArrayList arrSalebirds=new ArrayList();
		ArrayList arrSalemanure=new ArrayList();
		ArrayList arrSalebag=new ArrayList();
		
		ArrayList arrCalYear1=new ArrayList();
		ArrayList arrCalYear2=new ArrayList();
		ArrayList arrCalYear3=new ArrayList();
		ArrayList arryBrood=new ArrayList();
		
		
		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}
		String appno=correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
	    String PageType=Helper.correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
        {
        	 PageType=Helper.correctNull((String)hshValues.get("hidpagetype"));
        }
        
		try 
		{
			/*strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}*/
			strQuery = SQLParser.getSqlQuery("agr_broiselflockrep^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			//boolean bstate=rs.next();
			
			String totsalebirds="",totsalemanure="",totsalebag="";
			strQuery = SQLParser.getSqlQuery("agr_get_poultrybroifindata^"+appno+ "^" +prd_type);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) 
			{
				totsalebirds=Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totsaleegg")));
				totsalemanure=Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totsalemanure")));
				totsalebag=Helper.correctDoubleQuote(correctNull(rs1.getString("poultry_totsalebag")));
			}
			if("".equals(totsalebirds))totsalebirds="0.00";
			if("".equals(totsalemanure))totsalemanure="0.00";
			if("".equals(totsalebag))totsalebag="0.00";
		
			 
			 strQuery = SQLParser.getSqlQuery("agr_broiselflockrep^" + appno+ "^" +prd_type);
			 rs2=DBUtils.executeQuery(strQuery);
			while(rs2.next()) 
				{

				// arryCol=new ArrayList();
				//  arryCol.add(rs2.getString("sno"));
					//arryCol.add(rs2.getString("agr_batch"));
					arryCol2.add(rs2.getString("agr_batch"));
				//	arryCol.add(rs2.getString("agr_broodermon"));
					arryBrood.add(rs2.getString("agr_broodermon"));
				//	arryRow.add(arryCol);
				}
			// hshRecord.put("arryRow",arryRow);
			 if(arryCol2.size()<3)
				{
					hshRecord.put("nodata","Y");
					arryCol2.add("0.00");
					arryCol2.add("0.00");
					arryCol2.add("0.00");
				}
			 if(arryBrood.size()<3)
				{
					
					arryBrood.add("0.00");
					arryBrood.add("0.00");
					arryBrood.add("0.00");
				}
			 
			 for(int i=0;i<arryCol2.size();i++)
				{
				 arrSalebirds.add(Helper.formatDoubleValue((Double.parseDouble(totsalebirds)*Double.parseDouble((String)arryBrood.get(i)))));
				 arrSalemanure.add(Helper.formatDoubleValue((Double.parseDouble(totsalemanure)*Double.parseDouble((String)arryCol2.get(i)))));
				 arrSalebag.add(Helper.formatDoubleValue((Double.parseDouble(totsalebag)*Double.parseDouble((String)arryCol2.get(i)))));
				}
				hshRecord.put("arrSalebirds",arrSalebirds);
				hshRecord.put("arrSalemanure",arrSalemanure);
				hshRecord.put("arrSalebag",arrSalebag);
				
				if(arrSalebirds.size()<3)
				{
					arrSalebirds.add("0.00");
					arrSalebirds.add("0.00");
					arrSalebirds.add("0.00");
				}
				if(arrSalemanure.size()<3)
				{
					arrSalemanure.add("0.00");
					arrSalemanure.add("0.00");
					arrSalemanure.add("0.00");
				}
				if(arrSalebag.size()<3)
				{
					arrSalebag.add("0.00");
					arrSalebag.add("0.00");
					arrSalebag.add("0.00");
				}
				
			 strQuery = SQLParser.getSqlQuery("sel_poultry_income^" + appno+ "^" +prd_type);
			 rs3 = DBUtils.executeQuery(strQuery);
				while (rs3.next())
				{
					arryCol1 = new ArrayList();
					arryCol1.add(Helper.correctNull(rs3.getString("poultry_expenses")));
					arryCol1.add(Helper.formatDoubleValue(rs3.getDouble("poultry_iyear")));
					arryCol1.add(Helper.formatDoubleValue(rs3.getDouble("poultry_iiyear")));
					arryCol1.add(Helper.formatDoubleValue(rs3.getDouble("poultry_iiiyear")));
					arryCol1.add(Helper.correctNull(rs3.getString("poultry_type")));
					arryRow1.add(arryCol1);
					arrCalYear1.add(Helper.formatDoubleValue(rs3.getDouble("poultry_iyear")));
					arrCalYear2.add(Helper.formatDoubleValue(rs3.getDouble("poultry_iiyear")));
					arrCalYear3.add(Helper.formatDoubleValue(rs3.getDouble("poultry_iiiyear")));
				}
		
				if(arrCalYear1.size()<3)
				{
					arrCalYear1.add("0.00");
					arrCalYear1.add("0.00");
					arrCalYear1.add("0.00");
				}
				if(arrCalYear2.size()<3)
				{
					arrCalYear2.add("0.00");
					arrCalYear2.add("0.00");
					arrCalYear2.add("0.00");
				}
				if(arrCalYear3.size()<3)
				{
					arrCalYear3.add("0.00");
					arrCalYear3.add("0.00");
					arrCalYear3.add("0.00");
				}
		 hshRecord.put("arryRow1",arryRow1);
		 
		 strQuery = SQLParser.getSqlQuery("sel_poultry_expenditure^" + appno+ "^" +prd_type);
		 rs4 = DBUtils.executeQuery(strQuery);
		 if (rs4.next()) 
			{
				hshRecord.put("txt_expenseyear1", Helper.correctDoubleQuote(correctNull(rs4.getString("totiyearexpenses"))));
				hshRecord.put("txt_expenseyear2", Helper.correctDoubleQuote(correctNull(rs4.getString("totiiyearexpenses"))));
				hshRecord.put("txt_expenseyear3", Helper.correctDoubleQuote(correctNull(rs4.getString("totiiiyearexpenses"))));
				hshRecord.put("totiyearbank", Helper.correctDoubleQuote(correctNull(rs4.getString("totiyearbank"))));
				hshRecord.put("totiiyearbank", Helper.correctDoubleQuote(correctNull(rs4.getString("totiiyearbank"))));
				hshRecord.put("totiiiyearbank", Helper.correctDoubleQuote(correctNull(rs4.getString("totiiiyearbank"))));
				hshRecord.put("totiyearlastexp", Helper.formatDoubleValue(rs4.getDouble("totiyearlastexp")));
				hshRecord.put("totiiyearlastexp", Helper.formatDoubleValue(rs4.getDouble("totiiyearlastexp")));
				hshRecord.put("totiiiyearlastexp", Helper.formatDoubleValue(rs4.getDouble("totiiiyearlastexp")));
			
			}
		 		
		double totalIncome1=Double.parseDouble(Helper.correctDouble((String)arrSalebirds.get(0)))+Double.parseDouble(Helper.correctDouble((String)arrSalemanure.get(0)))
					+Double.parseDouble(Helper.correctDouble((String)arrSalebag.get(0)))+Double.parseDouble((String)arrCalYear1.get(0))+
					Double.parseDouble((String)arrCalYear1.get(1))+Double.parseDouble((String)arrCalYear1.get(2));
		
		double totalIncome2=Double.parseDouble(Helper.correctDouble((String)arrSalebirds.get(1)))+Double.parseDouble(Helper.correctDouble((String)arrSalemanure.get(1)))
					+Double.parseDouble(Helper.correctDouble((String)arrSalebag.get(1)))+Double.parseDouble(Helper.correctDouble((String)arrCalYear2.get(0)))+
					Double.parseDouble(Helper.correctDouble((String)arrCalYear2.get(1)))+Double.parseDouble(Helper.correctDouble((String)arrCalYear2.get(2)));
		
		double totalIncome3=Double.parseDouble(Helper.correctDouble((String)arrSalebirds.get(2)))+Double.parseDouble(Helper.correctDouble((String)arrSalemanure.get(2)))
					+Double.parseDouble(Helper.correctDouble((String)arrSalebag.get(2)))+Double.parseDouble(Helper.correctDouble((String)arrCalYear3.get(0)))+
					Double.parseDouble(Helper.correctDouble((String)arrCalYear3.get(1)))+Double.parseDouble(Helper.correctDouble((String)arrCalYear3.get(2)));
		double surplus1=totalIncome1-Double.parseDouble(Helper.correctDouble((String)hshRecord.get("totiyearlastexp")));
		double surplus2=totalIncome2-Double.parseDouble(Helper.correctDouble((String)hshRecord.get("totiiyearlastexp")));
		double surplus3=totalIncome3-Double.parseDouble(Helper.correctDouble((String)hshRecord.get("totiiiyearlastexp")));
		 
		 	HashMap hshQueryValues=new HashMap();
		 	HashMap hshQuery=new HashMap();
		 	ArrayList arrValues=new ArrayList();
		 	hshQueryValues.put("size","2");
			hshQuery.put("strQueryId","del_poultry_income");
			arrValues.add(appno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			arrValues.add(appno);
			arrValues.add(Helper.formatDoubleValue(surplus1));
			arrValues.add(Helper.formatDoubleValue(surplus2));
			arrValues.add(Helper.formatDoubleValue(surplus3));
			arrValues.add(Helper.formatDoubleValue(surplus3));
			arrValues.add(Helper.formatDoubleValue(surplus3));
			arrValues.add(Helper.formatDoubleValue(surplus3));
			arrValues.add(Helper.formatDoubleValue(surplus3));
			arrValues.add(Helper.formatDoubleValue(surplus3));
			
			hshQueryValues.put("size", "2");
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "ins_poultry_income");
			hshQueryValues.put("2", hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");  
			
			hshRecord.put("surplus1",Helper.formatDoubleValue(surplus1));
			hshRecord.put("surplus2",Helper.formatDoubleValue(surplus2));
			hshRecord.put("surplus3",Helper.formatDoubleValue(surplus3));
			
			hshRecord.put("totalIncome1",Helper.formatDoubleValue(totalIncome1));
			hshRecord.put("totalIncome2",Helper.formatDoubleValue(totalIncome2));
			hshRecord.put("totalIncome3",Helper.formatDoubleValue(totalIncome3));
		
		}
		catch (Exception ce)
		{
			throw new EJBException("Error in closing getData" + ce.getMessage());
		}
		finally 
		{
			try
			{
				
				if (rs1 != null)
			    {
				rs1.close();
			    }
				if (rs2 != null) 
				{
					rs2.close();
					rs2 = null;
				}
				
				if(rs != null)
				{
					rs.close();
					rs=null;
				}
				if (rs3 != null) 
				{
					rs3.close();
					
				}
				if (rs4 != null) 
				{
					rs4.close();
					
				}
				
			}
			
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
		
			
	}
	
	public void updatepoultrybroiincomeflowData(HashMap hshValues)
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery =  new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=correctNull((String)hshValues.get("hidAction"));
		String appno=correctNull((String)hshValues.get("strappno"));
		
		if(appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("appno"));
		}
		//ResultSet rs = null;
		try
		{			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","del_poultry_income");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(correctNull((String) hshValues.get("txt_sur1")));
				arrValues.add(correctNull((String) hshValues.get("txt_sur2")));
				arrValues.add(correctNull((String) hshValues.get("txt_sur3")));
				arrValues.add(correctNull((String) hshValues.get("txt_sur3")));
				arrValues.add(correctNull((String) hshValues.get("txt_sur3")));
				arrValues.add(correctNull((String) hshValues.get("txt_sur3")));
				arrValues.add(correctNull((String) hshValues.get("txt_sur3")));
				arrValues.add(correctNull((String) hshValues.get("txt_sur3")));
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "ins_poultry_income");
				hshQueryValues.put("2", hshQuery);
				
				
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_poultry_income");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");  
			}			
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
	}
	
	
	
	public HashMap updatepoultryirr(HashMap hshValues)  
	{
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strAction = null;		
		HashMap hshResult = new HashMap();
		HashMap hshQuery4 = new HashMap();
		int intUpdatesize = 0;
		int f = 0;
		String strid = "", strQuery1 = "";
		String appno = correctNull((String) hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
		strAction = correctNull((String) hshValues.get("hidAction"));
		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}	
		try 
		{
			String[] txt_iiyear = null;
			String[] txt_ivyear = null;
			String[] txt_viyear = null;
			String[] txt_viiiyear = null;
			String[] txt_xyear = null;
			String[] txt_xiiyear = null;
			String[] txt_xivyear = null;
			String[] txt_xviyear = null;
			String[] txt_xviiiyear = null;
			String[] txt_aayear = null;
			String[] txt_ccyear = null;
			String[] txt_24year = null;
			String[] txt_26year = null;
			String[] txt_28year = null;
			String[] txt_30year = null;
			String[] txt_32year = null;
			String[] txt_34year = null;
			txt_iiyear = (String[]) hshValues.get("txt_iiyear");
			txt_ivyear = (String[]) hshValues.get("txt_ivyear");
			txt_viyear = (String[]) hshValues.get("txt_viyear");
			strid = correctNull((String) hshValues.get("hid_sno"));
			txt_viiiyear = (String[]) hshValues.get("txt_viiiyear");
			txt_xyear = (String[]) hshValues.get("txt_xyear");
			txt_xiiyear = (String[]) hshValues.get("txt_xiiyear");
			txt_xivyear = (String[]) hshValues.get("txt_xivyear");
			txt_xviyear = (String[]) hshValues.get("txt_xviyear");
			txt_xviiiyear = (String[]) hshValues.get("txt_xviiiyear");
		    txt_aayear = (String[]) hshValues.get("txt_aayear");
		    txt_ccyear= (String[]) hshValues.get("txt_ccyear");
		    txt_24year = (String[]) hshValues.get("txt_24year");
		    txt_26year= (String[]) hshValues.get("txt_26year");
		    txt_28year = (String[]) hshValues.get("txt_28year");
		    txt_30year= (String[]) hshValues.get("txt_30year");
		    txt_32year = (String[]) hshValues.get("txt_32year");
		    txt_34year= (String[]) hshValues.get("txt_34year");
			
			/*strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshResult.put("applicantid", rs.getString("demo_appid"));
			}*/
			if (strAction.equals("delete"))
			{
				hshQuery4 = new HashMap();
				HashMap hshQueryValues4 = new HashMap();
				ArrayList arrValues4 = new ArrayList();
				hshQueryValues4.put("size", "1");
				hshQuery4.put("strQueryId", "per_del_poultryirr");
				arrValues4.add(appno);
				hshQuery4.put("arrValues", arrValues4);
				hshQueryValues4.put("1", hshQuery4);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
			}
			
			
			if (strAction.equals("insert"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "2");
				hshQuery3.put("strQueryId", "per_del_poultryirr");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				strQuery1 = SQLParser.getSqlQuery("sel_maxid_poultryirr");
				rs = DBUtils.executeQuery(strQuery1);
				if (rs.next())
				{
					strid = correctNull((String) rs.getString("maxid"));
					f = Integer.parseInt(strid);
				}
				intUpdatesize = 1;

				for (int i = 0; i <9; i++)
				{					
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "per_ins_poultryirr");
					arrValues.add(Integer.toString(f));
					arrValues.add(appno);
					arrValues.add(new Integer(i + 1).toString());
					if (i + 1 == 1) 
					{
						arrValues.add("p1");
					}
					if (i + 1 == 2) 
					{
						arrValues.add("p2");
					}
					if (i + 1 == 3)
					{
						arrValues.add("p3");
					}
					if (i + 1 == 4)
					{
						arrValues.add("p4");
					}
					if (i + 1 == 5) 
					{
						arrValues.add("p5");
					}
					if (i + 1 == 6) 
					{
						arrValues.add("p6");
					}
					if (i + 1 == 7) 
					{
						arrValues.add("p7");
					}
					if (i + 1 == 8)
					{
						arrValues.add("p8");
					}
					if (i + 1 == 9)
					{
						arrValues.add("p9");
					}
					
					if (correctNull(txt_iiyear[i]).equals("")) 
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(correctNull(txt_iiyear[i]));
					}
					if (correctNull(txt_ivyear[i]).equals(""))
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(correctNull(txt_ivyear[i]));
					}
					if (correctNull(txt_viyear[i]).equals("")) 
					{
						arrValues.add("0");
					}
					else 
					{
						arrValues.add(correctNull(txt_viyear[i]));
					}
				if (correctNull(txt_viiiyear[i]).equals(""))
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(correctNull(txt_viiiyear[i]));
					}
				if (correctNull(txt_xyear[i]).equals(""))
				{
					arrValues.add("0");
				} 
				else 
				{
					arrValues.add(correctNull(txt_xyear[i]));
				}
				if (correctNull(txt_xiiyear[i]).equals(""))
				{
					arrValues.add("0");
				} 
				else 
				{
					arrValues.add(correctNull(txt_xiiyear[i]));
				}
				if (correctNull(txt_xivyear[i]).equals(""))
				{
					arrValues.add("0");
				} 
				else 
				{
					arrValues.add(correctNull(txt_xivyear[i]));
				}
				if (correctNull(txt_xviyear[i]).equals(""))
				{
					arrValues.add("0");
				} 
				else 
				{
					arrValues.add(correctNull(txt_xviyear[i]));
				}
				if (correctNull(txt_xviiiyear[i]).equals(""))
				{
					arrValues.add("0");
				} 
				else 
				{
					arrValues.add(correctNull(txt_xviiiyear[i]));
				}
					if (correctNull(txt_aayear[i]).equals(""))
					{
						arrValues.add("0");
					} 
					else
					{
						arrValues.add(correctNull(txt_aayear[i]));
					}
					if (correctNull(txt_ccyear[i]).equals("")) 
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(correctNull(txt_ccyear[i]));
					}
					if (correctNull(txt_24year[i]).equals("")) 
					{
						arrValues.add("0");
					} 
					else
					{
						arrValues.add(correctNull(txt_24year[i]));
					}						
					if (correctNull(txt_26year[i]).equals(""))
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(correctNull(txt_26year[i]));
					}
					if (correctNull(txt_28year[i]).equals(""))
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(correctNull(txt_28year[i]));
					}
					
					if (correctNull(txt_30year[i]).equals("")) 
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(correctNull(txt_30year[i]));
					}
					if (correctNull(txt_32year[i]).equals("")) 
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(correctNull(txt_32year[i]));
					}
					if (correctNull(txt_34year[i]).equals("")) 
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(correctNull(txt_34year[i]));
					}
					hshQuery.put("arrValues", arrValues);
					f = f + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);					
				}
				hshQueryValues.put("1", hshQuery3);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			hshpasValues.put("appno", appno);
			hshpasValues.put("prd_type", prd_type);
			hshResult = getpoultryirr(hshpasValues);
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} 
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
			} 
			catch (Exception e1) 
			{
				throw new EJBException("Error in closing Connection "+ e1.getMessage());
			}
		}
		return hshResult;
	}
	
}