package com.sai.laps.ejb.agriculture;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.ApplicantParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.UpdateDairyData;
@Stateless(name = "AgriMechanisedBoatBean", mappedName = "AgriMechanisedBoatHome")
@Remote (AgriMechanisedBoatRemote.class)
public class AgriMechanisedBoatBean extends BeanAdapter {
	
	static Logger log=Logger.getLogger(AgriMechanisedBoatBean.class);	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	*	Function  getFinancialList This Method is collect the all finiancial data for mechanised boat laon.
	*	@param hshMapValues     
	*   @return HashMap		 
	*	@exception java.ejb.EJBException
	*/
	public HashMap getFinancialList(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs = null;
		ArrayList vecRecord1= new ArrayList();
		ArrayList VecData = new ArrayList();
		String strQuery=null;
		
		try
		{
			String appno=correctNull((String)hshValues.get("appno"));
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			strQuery = SQLParser.getSqlQuery("sel_agrmechBoat^"+appno);
			rs=DBUtils.executeQuery(strQuery);
 			while(rs.next())
			{
				vecRecord1 = new ArrayList();
				vecRecord1.add(Helper.correctNull((String)rs.getString("mach_appno")));
				vecRecord1.add(Helper.correctNull((String)rs.getString("mach_slno")));
				vecRecord1.add(Helper.correctNull((String)rs.getString("mach_exp_desc")));
				vecRecord1.add(Helper.correctNull((String)rs.getString("mach_exp_alinc")));
				vecRecord1.add(Helper.correctNull((String)rs.getString("mach_exp_toinc")));
				vecRecord1.add(Helper.correctNull((String)rs.getString("mach_expt_life")));
				vecRecord1.add(Helper.correctNull((String)rs.getString("mach_order_placed")));
				vecRecord1.add(Helper.correctNull((String)rs.getString("mach_source_desc")));
				vecRecord1.add(Helper.correctNull((String)rs.getString("mach_source")));
				VecData.add(vecRecord1);				
			}		
			hshRecord.put("VecData", VecData);
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
		return hshRecord;		
	}
	
	/**
	*	Function  updateFinancialList This Method is insert the all finiancial data for mechanised boat laon.
	*	@param hshMapValues     
	*   @return void		 
	*	@exception java.ejb.EJBException
	*/
	public void updateFinancialList(HashMap hshValues) 
	{
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		HashMap hshquery2 = new HashMap();
		ArrayList arrValues ;
		ResultSet rs=null;
		String strAction=null;			
		try
		{
			String appno=correctNull((String)hshValues.get("appno"));
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			String []strAllInc=null;
			String []strToBeInc=null;
			String []strYears=null;
			String []strSFinancial=null;
			String []strOrderPlaced=null;			
			String strFAName="";
			String strSFName1="";
			String strSFName2="";			
			int intUpdatesize = 0;	
			intUpdatesize=intUpdatesize+1;	
			strAction =correctNull((String)hshValues.get("hidAction"));			
			strAllInc=(String[])hshValues.get("txt_allinc");
			strToBeInc = (String[])hshValues.get("txt_toBeInc");	
			strYears=(String[])hshValues.get("txt_years");
			strSFinancial=(String[])hshValues.get("txt_sfinance");
			strOrderPlaced=(String[])hshValues.get("sel_placed");			
			strFAName=correctNull((String)hshValues.get("txt_other_faname"));
			strSFName1=correctNull((String)hshValues.get("txt_other_sfname1"));
			strSFName2=correctNull((String)hshValues.get("txt_other_sfname2"));
			
			int len=strAllInc.length;
			if(strAction.equals("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","del_agrMachBoat");		
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				for(int k=0;k<len;k++)
				{
					hshQuery.put("strQueryId","ins_agrMachBoat");
					arrValues=new ArrayList();	
					int z=0;
					arrValues.add(appno);
					z=k+1;
					arrValues.add(Integer.toString(z));
					if(k>3)
					{
						arrValues.add(strFAName);
					}
					else
					{
						arrValues.add("");
					}						
					arrValues.add(strAllInc[k]);
					arrValues.add(strToBeInc[k]);	
					arrValues.add(strYears[k]);
					arrValues.add(strOrderPlaced[k]);
					if (k==3)
					{
						arrValues.add(strSFName1);							
					}
					else if(k==4)
					{
						arrValues.add(strSFName2);
					}
					else
					{
						arrValues.add("");
					}
					arrValues.add(strSFinancial[k]);					
					hshQuery.put("arrValues",arrValues);					
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					hshquery2.put("appno",appno);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}						
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
	
	/**
	*	Function  getCatchesList This Method is collect the all Catches per year data for mechanised boat laon.
	*	@param hshMapValues     
	*   @return HashMap		 
	*	@exception java.ejb.EJBException
	*/
	
	public HashMap getCatchesSurplusList(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs = null;
		ArrayList vecRecord= new ArrayList();
		//ArrayList vecDataCatches = new ArrayList();
		ArrayList vecDataSurplus = new ArrayList();
		String strschemetype="",strfacsno="",stragrschemetype="";
		HashMap hshScheme = new HashMap();
		try
		{
			String appno=correctNull((String)hshValues.get("appno"));
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			strschemetype	= Helper.correctNull((String )hshValues.get("schemetype"));	
			hshScheme = Helper.splitScheme(strschemetype);
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			rs=DBUtils.executeLAPSQuery("sel_agrMachSurplus^"+appno+"^"+strfacsno+"^"+stragrschemetype);
 			while(rs.next())
			{
				vecRecord = new ArrayList();
				vecRecord.add(Helper.correctNull((String)rs.getString("mach_sur_appno")));
				vecRecord.add(Helper.correctNull((String)rs.getString("mach_sur_sino")));
				vecRecord.add(Helper.correctNull((String)rs.getString("qty_year1")));
				vecRecord.add(Helper.correctNull((String)rs.getString("value_year1")));
				vecRecord.add(Helper.correctNull((String)rs.getString("qty_year2")));
				vecRecord.add(Helper.correctNull((String)rs.getString("value_year2")));
				vecRecord.add(Helper.correctNull((String)rs.getString("qty_year3")));
				vecRecord.add(Helper.correctNull((String)rs.getString("value_year3")));
				vecRecord.add(Helper.correctNull((String)rs.getString("qty_year4")));
				vecRecord.add(Helper.correctNull((String)rs.getString("value_year4")));
				vecRecord.add(Helper.correctNull((String)rs.getString("fishtype")));
				vecRecord.add(Helper.correctNull((String)rs.getString("income_year1")));
				vecRecord.add(Helper.correctNull((String)rs.getString("income_year2")));
				vecRecord.add(Helper.correctNull((String)rs.getString("income_year3")));
				vecRecord.add(Helper.correctNull((String)rs.getString("income_year4")));
				vecDataSurplus.add(vecRecord);
				hshRecord.put("auditFlag", "Y");
			}
	 		hshRecord.put("vecDataSurplus", vecDataSurplus);
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
		return hshRecord;		
	}
	
	/**
	*	Function  updateCatches List This Method is insert the all Catches data for mechanised boat laon.
	*	@param hshMapValues     
	*   @return void		 
	*	@exception java.ejb.EJBException
	*/
	
	
	
	
	public void updateCatchesSurplusList(HashMap hshValues) 
	{
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		HashMap hshquery2 = new HashMap();
		ArrayList arrValues ;
		String strAction=null;	
		String strschemetype="",strfacsno="",stragrschemetype="";
		HashMap hshScheme = new HashMap();
		try
		{
			String appno=correctNull((String)hshValues.get("appno"));
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			if(appno.equalsIgnoreCase(""))
			{
				appno=Helper.correctNull((String)hshValues.get("strAppno"));
			}
			strschemetype	= Helper.correctNull((String )hshValues.get("schemetype"));	
			hshScheme = Helper.splitScheme(strschemetype);
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			
			String []strFishType=null;
			String []strQty1=null;
			String []strValue1=null;
			String []strincome1=null;
			String []strQty2=null;
			String []strValue2=null;
			String []strincome2=null;
			String []strQty3=null;
			String []strValue3=null;
			String []strincome3=null;
			String []strQty4=null;
			String []strValue4=null;
			String []strincome4=null;
			
			int intUpdatesize = 0;	
			intUpdatesize=intUpdatesize+1;	
			strAction =correctNull((String)hshValues.get("hidAction"));			
			strFishType=(String[])hshValues.get("txt_fish_type");
			strQty1 = (String[])hshValues.get("txt_qty1");
			strQty2 = (String[])hshValues.get("txt_qty2");
			strQty3 = (String[])hshValues.get("txt_qty3");
			strQty4 = (String[])hshValues.get("txt_qty4");			
			strValue1 = (String[])hshValues.get("txt_value1");	
			strValue2 = (String[])hshValues.get("txt_value2");
			strValue3 = (String[])hshValues.get("txt_value3");
			strValue4 = (String[])hshValues.get("txt_value4");
			strincome1 = (String[])hshValues.get("txt_income1");	
			strincome2 = (String[])hshValues.get("txt_income2");
			strincome3 = (String[])hshValues.get("txt_income3");
			strincome4 = (String[])hshValues.get("txt_income4");
			
		
			int lenSurplus=strQty1.length;
			if(strAction.equals("update"))
			{
				//income record deleted
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","del_agrMachSurplus");		
				arrValues.add(appno);
				arrValues.add(strfacsno);
				arrValues.add(stragrschemetype);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				for(int k=0;k<lenSurplus;k++)
				{
					hshQueryValues = new HashMap();
					hshQuery.put("strQueryId","ins_agrMachSurplus");
					arrValues=new ArrayList();	
					int z=0;
					arrValues.add(appno);
					z=k+1;
					arrValues.add(Integer.toString(z));						
					arrValues.add(strQty1[k]);
					arrValues.add(strValue1[k]);					
					arrValues.add(strQty2[k]);
					arrValues.add(strValue2[k]);					
					arrValues.add(strQty3[k]);	
					arrValues.add(strValue3[k]);					
					arrValues.add(strQty4[k]);
					arrValues.add(strValue4[k]);	
					arrValues.add(strFishType[k]);	
					arrValues.add(strincome1[k]);	
					arrValues.add(strincome2[k]);	
					arrValues.add(strincome3[k]);	
					arrValues.add(strincome4[k]);	
					arrValues.add(strfacsno);
					arrValues.add(stragrschemetype);
					hshQuery.put("arrValues",arrValues);					
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					hshquery2.put("appno",appno);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
			if(strAction.equals("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","del_agrMachSurplus");		
				arrValues.add(appno);
				arrValues.add(strfacsno);
				arrValues.add(stragrschemetype);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{
			for (int i = 0; i < lenSurplus; i++)
			{	
				sbAuditTrial
				.append("~Particulars (Type of Fish ) = ")
				.append(strFishType[i])	
				.append("~I Year  Quantity in Kgs = ")
				.append(strQty1[i])
				.append("~I Year  Value per Kg in Rs = ")
				.append(strValue1[i])
				.append("~I Year  Income in Rs = ")
				.append(strincome1[i])
				.append("~II Year Quantity in Kgs = ")
				.append(strQty2[i])
				.append("~II Year Value per Kg in Rs = ")
				.append(strValue2[i])
				.append("~II Year Income in Rs = ")
				.append(strincome2[i])
				.append("~III Year Quantity in Kgs = ")
				.append(strQty3[i])
				.append("~III Year Value per Kg in Rs = ")
				.append(strValue3[i])
				.append("~III Year Income in Rs = ")
				.append(strincome3[i])
				.append("~IV Year Quantity in Kgs = ")
				.append(strQty4[i])
				.append("~IV Year Value per Kg in Rs. = ")
				.append(strValue4[i])
				.append("~IV Year Income in Rs = ")
				.append(strincome4[i]);
			}	
			
			sbAuditTrial
			.append("~ Total ^")
			.append("~I Year Quantity in Kgs = ")
			.append((String)hshValues.get("txt_total_qty1"))
			.append("~I Year  Income in Rs = ")
			.append((String)hshValues.get("txt_total_income1"))
			.append("~II Year Quantity in Kgs = ")
			.append((String)hshValues.get("txt_total_qty2"))
			.append("~II Year  Income in Rs = ")
			.append((String)hshValues.get("txt_total_income2"))
			.append("~III Year Quantity in Kgs = ")
			.append((String)hshValues.get("txt_total_qty3"))
			.append("~III Year  Income in Rs = ")
			.append((String)hshValues.get("txt_total_income3"))
			.append("~IV Year Quantity in Kgs = ")
			.append((String)hshValues.get("txt_total_qty4"))
			.append("~IV Year  Income in Rs = ")
			.append((String)hshValues.get("txt_total_income4"));
			
			if(correctNull((String)hshValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
			{
				hshValues.put("strAction", "update");
			}
			else
			{
				hshValues.put("strAction", "insert");
			}
			}
			AuditTrial.auditLog(hshValues,"262",appno,sbAuditTrial.toString());
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
		}			
	}
	
	/**
	*	Function  getOperatingExpenses This Method is collect the all  Operating Expenses per year data for mechanised boat laon.
	*	@param hshMapValues     
	*   @return HashMap		 
	*	@exception java.ejb.EJBException
	*/
	
	public HashMap getOperatingExpenses(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs = null;
		ResultSet rs1 = null;
		ArrayList vecRecord1= new ArrayList();
		ArrayList vecDataEcoValues = new ArrayList();
		ArrayList vecDataOPExp= new ArrayList();
		String strschemetype="",strfacsno="",stragrschemetype="";
		HashMap hshScheme = new HashMap();
		
		try
		{
			String appno=correctNull((String)hshValues.get("appno"));
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			
			strschemetype	= Helper.correctNull((String )hshValues.get("schemetype"));	
			hshScheme = Helper.splitScheme(strschemetype);
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			
			rs=DBUtils.executeLAPSQuery("sel_agrMachEcoValues^"+appno+'^'+"ope"+"^"+strfacsno+"^"+stragrschemetype);
 			while(rs.next())
			{
 				vecRecord1 = new ArrayList();
 				vecRecord1.add(Helper.correctNull((String)rs.getString("machv_appno")));
 				vecRecord1.add(Helper.correctNull((String)rs.getString("machv_sino")));
 				vecRecord1.add(Helper.correctNull((String)rs.getString("mech_type")));
 				vecRecord1.add(Helper.correctNull((String)rs.getString("value1")));
 				vecRecord1.add(Helper.correctNull((String)rs.getString("value2")));
 				vecRecord1.add(Helper.correctNull((String)rs.getString("value3")));
 				vecRecord1.add(Helper.correctNull((String)rs.getString("value4")));
 				vecRecord1.add(Helper.correctNull((String)rs.getString("value5")));
				vecRecord1.add(Helper.correctNull((String)rs.getString("value6")));
				vecDataEcoValues.add(vecRecord1);
				hshRecord.put("auditFlag", "Y");
			}
 			rs1=DBUtils.executeLAPSQuery("sel_agrMachOPExp^"+appno+"^"+strfacsno+"^"+stragrschemetype);
 			while(rs1.next())
			{
				vecRecord1 = new ArrayList();
				vecRecord1.add(Helper.correctNull((String)rs1.getString("mach_op_appno")));
				vecRecord1.add(Helper.correctNull((String)rs1.getString("mach_op_sino")));
				vecRecord1.add(Helper.correctNull((String)rs1.getString("year1")));
				vecRecord1.add(Helper.correctNull((String)rs1.getString("year2")));
				vecRecord1.add(Helper.correctNull((String)rs1.getString("year3")));
				vecRecord1.add(Helper.correctNull((String)rs1.getString("year4")));
				vecDataOPExp.add(vecRecord1);
				hshRecord.put("auditFlag", "Y");
			}
	 		hshRecord.put("vecDataEcoValues", vecDataEcoValues);
			hshRecord.put("vecDataOPExp", vecDataOPExp);
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
	
	/**
	*	Function  updateOperatingExpenses List This Method is insert the all Operating Expenses data for mechanised boat laon.
	*	@param hshMapValues     
	*   @return void		 
	*	@exception java.ejb.EJBException
	*/
	
	public void updateOperatingExpenses(HashMap hshValues) 
	{
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		HashMap hshquery2 = new HashMap();
		ArrayList arrValues ;
		String strAction=null;	
		String strschemetype="",strfacsno="",stragrschemetype="";
		HashMap hshScheme = new HashMap();
		try
		{
			String appno= correctNull((String)hshValues.get("appno"));	
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			strschemetype	= Helper.correctNull((String )hshValues.get("schemetype"));	
			hshScheme = Helper.splitScheme(strschemetype);
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			String strEcoMechType="";			
			String []strEcoValue=null;			
			String []strYear1=null;
			String []strYear2=null;
			String []strYear3=null;
			String []strYear4=null;	
			String []strDesc={"","","Repairs and maintenance of hull. Net and engine","Taxes and insurance","Incidental and miscellaneous charges","Provision for contingencies","Depreciation :","Transport cost for marketing fish","Sales commission","Other expenses like port charges, registration etc,","cost of purchase of fingerling's","Cost of feeding for fingerling's","Total expenditure"};
			int intUpdatesize = 0;	
			int lenOpExp =0;
			intUpdatesize=intUpdatesize+1;	
			strAction =correctNull((String)hshValues.get("hidAction"));			
			strEcoValue = (String[])hshValues.get("txt_eco_value");				
			strYear1 = (String[])hshValues.get("txt_exp1");
			strYear2 = (String[])hshValues.get("txt_exp2");
			strYear3 = (String[])hshValues.get("txt_exp3");
			strYear4 = (String[])hshValues.get("txt_exp4");
			lenOpExp=strYear1.length;			
			if(strAction.equals("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","del_agrMachEcoValues");		
				arrValues.add(appno);
				arrValues.add("ope");
				arrValues.add(strfacsno);
				arrValues.add(stragrschemetype);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQueryValues = new HashMap();
				strEcoMechType="ope";
				hshQuery.put("strQueryId","ins_agrMachEcoValues");
				arrValues=new ArrayList();				
				arrValues.add(appno);
				arrValues.add("1");
				arrValues.add(strEcoMechType);
				for(int k=0;k<strEcoValue.length;k++)
				{	
					arrValues.add(strEcoValue[k]);
				}	
				arrValues.add(strfacsno);
				arrValues.add(stragrschemetype);
				hshQuery.put("arrValues",arrValues);					
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				hshquery2.put("appno",appno);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
								
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","del_agrMachOPExp");		
				arrValues.add(appno);
				arrValues.add(strfacsno);
				arrValues.add(stragrschemetype);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");				
				
				for(int k=0;k<lenOpExp;k++)
				{
					hshQueryValues = new HashMap();
					hshQuery.put("strQueryId","ins_agrMachOPExp");
					arrValues=new ArrayList();	
					int z=0;
					arrValues.add(appno);
					z=k+1;
					arrValues.add(Integer.toString(z));						
					arrValues.add(strYear1[k]);
					arrValues.add(strYear2[k]);
					arrValues.add(strYear3[k]);
					arrValues.add(strYear4[k]);		
					arrValues.add(strfacsno);
					arrValues.add(stragrschemetype);
					hshQuery.put("arrValues",arrValues);					
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					hshquery2.put("appno",appno);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
			
		  if(strAction.equalsIgnoreCase("delete"))
		   {
			   
			    hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","del_agrMachEcoValues");		
				arrValues.add(appno);
				arrValues.add("ope");
				arrValues.add(strfacsno);
				arrValues.add(stragrschemetype);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			    
				  
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","del_agrMachOPExp");		
				arrValues.add(appno);
				arrValues.add(strfacsno);
				arrValues.add(stragrschemetype);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
		   }
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{
			for(int k=0;k<lenOpExp;k++)
			{
				if(k==0)
				{
					sbAuditTrial
					.append("~ Diesel at  = "+strEcoValue[0])
					.append("~litres per day for = "+strEcoValue[1])
					.append("~days at Rs. = "+strEcoValue[2])
					.append("~per litre ^")
					.append("~I Year in Rs. = ")
					.append(strYear1[k])
					.append("~II Year in Rs. = ")
					.append(strYear2[k])
					.append("~III Year in Rs. = ")
					.append(strYear3[k])
					.append("~IV Year till the end of loan period in Rs. = ")
					.append(strYear4[k]);
				}
				else if(k==1)
				{
					sbAuditTrial
					.append("~ Oil at  = "+strEcoValue[3])
					.append("~litres per day for = "+strEcoValue[4])
					.append("~Days at Rs. = "+strEcoValue[5])
					.append("~per litre ^")
					.append("~I Year in Rs. = ")
					.append(strYear1[k])
					.append("~II Year in Rs. = ")
					.append(strYear2[k])
					.append("~III Year in Rs. = ")
					.append(strYear3[k])
					.append("~IV Year till the end of loan period in Rs. = ")
					.append(strYear4[k]);
				}
				else
				{
					sbAuditTrial
					.append("~")
					.append(strDesc[k])
					.append(" ^ ")
					.append("~I Year in Rs. = ")
					.append(strYear1[k])
					.append("~II Year in Rs. = ")
					.append(strYear2[k])
					.append("~III Year in Rs. = ")
					.append(strYear3[k])
					.append("~IV Year till the end of loan period in Rs. =")
					.append(strYear4[k]);
				}
			}
			sbAuditTrial
			.append("~ Total Expenditure ^")
			.append("~I Year in Rs. = ")
			.append((String)hshValues.get("txt_total_exp1"))
			.append("~II Year in Rs. = ")
			.append((String)hshValues.get("txt_total_exp2"))
			.append("~III Year in Rs. = ")
			.append((String)hshValues.get("txt_total_exp3"))
			.append("~IV Year till the end of loan period in Rs. =")
			.append((String)hshValues.get("txt_total_exp4"));
			
			if(correctNull((String)hshValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
			{
				hshValues.put("strAction", "update");
			}else
			{
				hshValues.put("strAction", "insert");
			}
			
			}
			AuditTrial.auditLog(hshValues,"261",appno,sbAuditTrial.toString());
			
			
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
		}			
	}
	
	/**
	*	Function  getAnnexure This Method is collect the all  Annexure per year data for mechanised boat laon.
	*	@param hshMapValues     
	*   @return HashMap		 
	*	@exception java.ejb.EJBException
	*/
	
	public HashMap getAnnexure(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs = null;
		ArrayList vecRecord1= new ArrayList();
		ArrayList vecDataAnnexure = new ArrayList();
		String appno=correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
		try
		{
			rs=DBUtils.executeLAPSQuery("sel_agrMachEcoValues^"+appno+'^'+"ann");
 			while(rs.next())
			{
 				vecRecord1 = new ArrayList();
 				vecRecord1.add(Helper.correctNull((String)rs.getString("machv_appno")));
 				vecRecord1.add(Helper.correctNull((String)rs.getString("machv_sino")));
 				vecRecord1.add(Helper.correctNull((String)rs.getString("mech_type")));
 				vecRecord1.add(Helper.correctNull((String)rs.getString("value1")));
 				vecRecord1.add(Helper.correctNull((String)rs.getString("value2")));
 				vecRecord1.add(Helper.correctNull((String)rs.getString("value3")));
 				vecRecord1.add(Helper.correctNull((String)rs.getString("value4")));
 				vecRecord1.add(Helper.correctNull((String)rs.getString("value5")));
				vecRecord1.add(Helper.correctNull((String)rs.getString("value6")));
				vecRecord1.add(Helper.correctNull((String)rs.getString("value7")));
				vecRecord1.add(Helper.correctNull((String)rs.getString("value8")));
				vecRecord1.add(Helper.correctNull((String)rs.getString("value9")));
				vecRecord1.add(Helper.correctNull((String)rs.getString("value10")));
				vecRecord1.add(Helper.correctNull((String)rs.getString("value11")));
				vecDataAnnexure.add(vecRecord1);
			} 			
 			hshRecord.put("vecDataAnnexure", vecDataAnnexure);
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
		return hshRecord;		
	}
	
	/**
	*	Function  updateOperatingExpenses List This Method is insert the all Operating Expenses data for mechanised boat laon.
	*	@param hshMapValues     
	*   @return void		 
	*	@exception java.ejb.EJBException
	*/
	
	public void updateAnnexure(HashMap hshValues) 
	{
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		HashMap hshquery2 = new HashMap();
		ArrayList arrValues ;
		String strAction=null;			
		try
		{
			String appno=correctNull((String)hshValues.get("appno"));	
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			String strEcoMechType="";			
			String []strEcoValue=null;			
			int intUpdatesize = 0;	
			intUpdatesize=intUpdatesize+1;	
			strAction =correctNull((String)hshValues.get("hidAction"));			
			strEcoValue = (String[])hshValues.get("txt_eco_value");				
			if(strAction.equals("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","del_agrMachEcoValues");		
				arrValues.add(appno);
				arrValues.add("ann");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQueryValues = new HashMap();
				strEcoMechType="ann";
				hshQuery.put("strQueryId","ins_agrMachEcoValues");
				arrValues=new ArrayList();				
				arrValues.add(appno);
				arrValues.add("2");
				arrValues.add(strEcoMechType);
				for(int k=0;k<strEcoValue.length;k++)
				{	
					arrValues.add(strEcoValue[k]);
				}
				for(int k=0;k<7;k++)
				{	
					arrValues.add("0");
				}				
				hshQuery.put("arrValues",arrValues);					
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				hshquery2.put("appno",appno);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");				
			}	
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
		}			
	}
	
	/**
	*	Function  getAnnexureIII This Method is collect the all  AnnexureIII per year data for mechanised boat laon.
	*	@param hshMapValues     
	*   @return HashMap		 
	*	@exception java.ejb.EJBException
	*/
	
//	public HashMap getAnnexureIII(HashMap hshValues) 
//	{
//		HashMap hshRecord=new HashMap();
//		ResultSet rs = null;
//		ArrayList vecRecord1= new ArrayList();
//		ArrayList vecDataAnnexure = new ArrayList();
//		String strQuery=null;
//		try
//		{
//			String appno=correctNull((String)hshValues.get("appno"));
//			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
//			{
//				appno = Helper.correctNull((String)hshValues.get("strappno"));
//			}
//			strQuery=SQLParser.getSqlQuery("sel_agrMachAnnexure^"+appno);
//			rs=DBUtils.executeQuery(strQuery);
// 			while(rs.next())
//			{
// 				vecRecord1 = new ArrayList();
// 				vecRecord1.add(Helper.correctNull((String)rs.getString("mach_ann_appno")));
// 				vecRecord1.add(Helper.correctNull((String)rs.getString("mach_ann_sino")));
// 				vecRecord1.add(Helper.correctNull((String)rs.getString("loan_received")));
// 				vecRecord1.add(Helper.correctNull((String)rs.getString("loan_out_standing")));
// 				vecRecord1.add(Helper.correctNull((String)rs.getString("fom_scheme")));
// 				vecRecord1.add(Helper.correctNull((String)rs.getString("other_numeric")));
// 				vecRecord1.add(Helper.correctNull((String)rs.getString("payment_int")));
// 				vecRecord1.add(Helper.correctNull((String)rs.getString("loan_back")));
//				vecDataAnnexure.add(vecRecord1);
//			} 			
// 			hshRecord.put("vecDataAnnexure", vecDataAnnexure);
//		}
//		catch(Exception ce)
//		{
//			throw new EJBException("Error in getData "+ce.toString());
//		}
//		finally
//		{
//			try
//			{
//				if(rs != null)
//				{
//					rs.close();					 
//				}				
//			}
//			catch(Exception cf)
//			{
//				throw new EJBException("Error closing the connection "+cf.getMessage());
//			}
//		}
//		return hshRecord;		
//	}
	
	/**
	*	Function  updateOperatingExpenses List This Method is insert the all Operating Expenses data for mechanised boat laon.
	*	@param hshMapValues     
	*   @return void		 
	*	@exception java.ejb.EJBException
	*/
	
//	public void updateAnnexureIII(HashMap hshValues) 
//	{
//		HashMap hshQuery = new HashMap();
//		HashMap hshQueryValues = new HashMap();
//		HashMap hshquery2 = new HashMap();
//		ArrayList arrValues ;
//		String strAction=null;			
//		try
//		{
//			String appno=correctNull((String)hshValues.get("appno"));	
//			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
//			{
//				appno = Helper.correctNull((String)hshValues.get("strappno"));
//			}
//			String []strLoanRec=null;
//			String []strLoanOut=null;
//			String []strFromScheme=null;
//			String []strOther=null;
//			String []strPayInt=null;
//			String []strloanBack=null;			
//			int intUpdatesize = 0;	
//			intUpdatesize=intUpdatesize+1;	
//			strAction =correctNull((String)hshValues.get("hidAction"));			
//			strLoanRec = (String[])hshValues.get("txt_loan_receive");
//			strLoanOut = (String[])hshValues.get("txt_loan_out_stand");
//			strFromScheme = (String[])hshValues.get("txt_from_scheme");
//			strOther = (String[])hshValues.get("txt_other");
//			strPayInt = (String[])hshValues.get("txt_pay_interest");
//			strloanBack = (String[])hshValues.get("txt_pri_bank");
//			
//			if(strAction.equals("update"))
//			{
//				hshQueryValues = new HashMap();
//				hshQuery=new HashMap();				
//				arrValues=new ArrayList();	
//				hshQuery.put("strQueryId","del_agrMachAnnexure");		
//				arrValues.add(appno);
//				hshQuery.put("arrValues", arrValues);
//				hshQuery.put("size","1");
//				hshQueryValues.put("1", hshQuery);
//				hshQueryValues.put("size","1");
//				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//				hshQueryValues = new HashMap();
//				hshQuery.put("strQueryId","ins_agrMachAnnexure");
//				arrValues=new ArrayList();
//				for(int k=0;k<strLoanRec.length;k++)
//				{
//					arrValues=new ArrayList();
//					int z=0;
//					arrValues.add(appno);
//					z=k+1;
//					arrValues.add(Integer.toString(z));
//					arrValues.add(strLoanRec[k]);
//					arrValues.add(strLoanOut[k]);
//					arrValues.add(strFromScheme[k]);
//					arrValues.add(strOther[k]);
//					arrValues.add(strPayInt[k]);
//					arrValues.add(strloanBack[k]);
//					hshQuery.put("arrValues",arrValues);
//					hshQueryValues.put("1",hshQuery);
//					hshQueryValues.put("size","1");
//					hshquery2.put("appno",appno);
//					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//				}				
//			}	
//		}
//		catch(Exception e)
//		{
//			throw new EJBException(e.getMessage());
//		}			
//	}
	
//	public HashMap getQuestion(HashMap hshValues) 
//	{
//		HashMap hshRecord=new HashMap();
//		ResultSet rs = null;
//		ArrayList vecRecord1= new ArrayList();
//		ArrayList vecDataQuestion = new ArrayList();
//		String strProductType="";
//		try
//		{			
//			strProductType=correctNull((String)hshValues.get("hidProductType"));
//			rs=DBUtils.executeLAPSQuery("sel_appconfparamerters^"+strProductType);
// 			while(rs.next())
//			{
// 				vecRecord1 = new ArrayList();
// 				vecRecord1.add(Helper.correctNull((String)rs.getString("gene_slno")));
// 				vecRecord1.add(Helper.correctNull((String)rs.getString("gene_question")));
//				vecDataQuestion.add(vecRecord1);
//			} 			
// 			hshRecord.put("vecDataQuestion", vecDataQuestion);
//		}
//		catch(Exception ce)
//		{
//			throw new EJBException("Error in getData "+ce.toString());
//		}
//		finally
//		{
//			try
//			{
//				if(rs != null)
//				{
//					rs.close();					 
//				}				
//			}
//			catch(Exception cf)
//			{
//				throw new EJBException("Error closing the connection "+cf.getMessage());
//			}
//		}
//		return hshRecord;		
//	}
	
//	public void updateIncomeExp1223(HashMap hshValues) 
//	{
//		HashMap hshQuery = new HashMap();
//		HashMap hshQueryValues = new HashMap();
//		HashMap hshquery2 = new HashMap();
//		ArrayList arrValues ;
//		String strAction=null;			
//		try
//		{
//			String appno=correctNull((String)hshValues.get("appno"));	
//			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
//			{
//				appno = Helper.correctNull((String)hshValues.get("strappno"));
//			}
//			String []strIncEco=null;
//			String []strInc=null;
//			String []strExp=null;
//			String strYear="";			
//			int intUpdatesize = 0;	
//			intUpdatesize=intUpdatesize+1;	
//			strAction =correctNull((String)hshValues.get("hidAction"));			
//			strIncEco = (String[])hshValues.get("txt_inc_eco");
//			strInc = (String[])hshValues.get("txt_inc");
//			strExp = (String[])hshValues.get("txt_exp");
//			strYear=Helper.correctNull((String)hshValues.get("txt_inc_year"));
//			
//			if(strAction.equals("update"))
//			{
//				hshQueryValues = new HashMap();
//				hshQuery=new HashMap();				
//				arrValues=new ArrayList();	
//				hshQuery.put("strQueryId","del_agrFormIncExp");		
//				arrValues.add(appno);
//				hshQuery.put("arrValues", arrValues);
//				hshQuery.put("size","1");
//				hshQueryValues.put("1", hshQuery);
//				hshQueryValues.put("size","1");
//				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//				
//				hshQueryValues = new HashMap();
//				hshQuery.put("strQueryId","ins_agrFormIncExp");
//				arrValues=new ArrayList();
//				arrValues.add(appno);
//				for(int k=0;k<strIncEco.length;k++)
//				{
//					arrValues.add(strIncEco[k]);
//				}
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("1",hshQuery);
//				hshQueryValues.put("size","1");
//				hshquery2.put("appno",appno);
//				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//				
//				hshQueryValues = new HashMap();
//				hshQuery=new HashMap();				
//				arrValues=new ArrayList();	
//				hshQuery.put("strQueryId","del_agrMachIncome23");		
//				arrValues.add(appno);
//				arrValues.add(strYear);
//				hshQuery.put("arrValues", arrValues);
//				hshQuery.put("size","1");
//				hshQueryValues.put("1", hshQuery);
//				hshQueryValues.put("size","1");
//				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//				
//				hshQueryValues = new HashMap();
//				hshQuery.put("strQueryId","ins_agrMachIncome23");
//				arrValues=new ArrayList();
//				arrValues.add(appno);
//				arrValues.add(strYear);
//				for(int k=0;k<strInc.length;k++)
//				{
//					arrValues.add(strInc[k]);
//				}
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("1",hshQuery);
//				hshQueryValues.put("size","1");
//				hshquery2.put("appno",appno);
//				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//				
//				hshQueryValues = new HashMap();
//				hshQuery=new HashMap();				
//				arrValues=new ArrayList();	
//				hshQuery.put("strQueryId","del_agrMachExpenses23");		
//				arrValues.add(appno);
//				arrValues.add(strYear);
//				hshQuery.put("arrValues", arrValues);
//				hshQuery.put("size","1");
//				hshQueryValues.put("1", hshQuery);
//				hshQueryValues.put("size","1");
//				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//				
//				hshQueryValues = new HashMap();
//				hshQuery.put("strQueryId","ins_agrMachExpenses23");
//				arrValues=new ArrayList();
//				arrValues.add(appno);
//				arrValues.add(strYear);
//				for(int k=0;k<strExp.length;k++)
//				{
//					arrValues.add(strExp[k]);
//				}
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("1",hshQuery);
//				hshQueryValues.put("size","1");
//				hshquery2.put("appno",appno);
//				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");				
//			}	
//		}
//		catch(Exception e)
//		{
//			throw new EJBException(e.getMessage());
//		}			
//	}
	
//	public HashMap getIncomeExp1223(HashMap hshValues) 
//	{
//		HashMap hshRecord=new HashMap();
//		ResultSet rs = null;
//		ResultSet rs1 = null;
//		ResultSet rs2 = null;
//		ResultSet rs3 = null;
//		ArrayList vecRecord1= new ArrayList();
//		ArrayList vecIncomeExp = new ArrayList();
//		ArrayList vecExp = new ArrayList();
//		ArrayList vecIncome = new ArrayList();
//		ArrayList vecExpYear = new ArrayList();
//		String strYear="%";
//		
//		try
//		{
//			String appno=correctNull((String)hshValues.get("appno"));
//			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
//			{
//				appno = Helper.correctNull((String)hshValues.get("strappno"));
//			}
//			rs=DBUtils.executeLAPSQuery("sel_agrFormIncExp^"+appno);
// 			while(rs.next())
//			{
// 				vecRecord1 = new ArrayList();
// 				vecRecord1.add(Helper.correctNull((String)rs.getString("appno")));
// 				vecRecord1.add(Helper.correctNull((String)rs.getString("wool_adult")));
// 				vecRecord1.add(Helper.correctNull((String)rs.getString("wool_young")));
// 				vecRecord1.add(Helper.correctNull((String)rs.getString("manure_adult")));
// 				vecRecord1.add(Helper.correctNull((String)rs.getString("manure_young")));
// 				vecRecord1.add(Helper.correctNull((String)rs.getString("penning_aduilt")));
// 				vecRecord1.add(Helper.correctNull((String)rs.getString("penning_young")));
// 				vecRecord1.add(Helper.correctNull((String)rs.getString("eco_year")));
// 				vecRecord1.add(Helper.correctNull((String)rs.getString("orginal_stock")));
// 				vecRecord1.add(Helper.correctNull((String)rs.getString("young_born")));
// 				vecRecord1.add(Helper.correctNull((String)rs.getString("lambs_died")));
// 				vecRecord1.add(Helper.correctNull((String)rs.getString("lambs_sold")));
// 				vecRecord1.add(Helper.correctNull((String)rs.getString("closing_stock")));
// 				vecIncomeExp.add(vecRecord1);
//			} 			
// 			hshRecord.put("vecIncomeExp", vecIncomeExp); 			
// 			if(correctNull((String)hshValues.get("hidParamSel")).equalsIgnoreCase("selectBox"))
//			{
//				strYear=correctNull((String)hshValues.get("sel_year"));
//				rs1=DBUtils.executeLAPSQuery("sel_agrMachIncomeYear23^"+appno+"^"+strYear);
//				rs2=DBUtils.executeLAPSQuery("sel_agrMachExpensesYear23^"+appno+"^"+strYear);
//			}
//			else
//			{
//				rs1=DBUtils.executeLAPSQuery("sel_agrMachIncome23^"+appno);
//				rs2=DBUtils.executeLAPSQuery("sel_agrMachExpenses23^"+appno);
//			}
// 			while(rs1.next())
//			{
// 				vecRecord1 = new ArrayList();
// 				vecRecord1.add(Helper.correctNull((String)rs1.getString("inc_app_no")));
// 				vecRecord1.add(Helper.correctNull((String)rs1.getString("inc_year")));
// 				vecRecord1.add(Helper.correctNull((String)rs1.getString("lamb")));
// 				vecRecord1.add(Helper.correctNull((String)rs1.getString("wool")));
// 				vecRecord1.add(Helper.correctNull((String)rs1.getString("manure")));
// 				vecRecord1.add(Helper.correctNull((String)rs1.getString("milk")));
// 				vecRecord1.add(Helper.correctNull((String)rs1.getString("penning")));
// 				vecIncome.add(vecRecord1);
//			}
// 			hshRecord.put("vecIncome", vecIncome);
// 			while(rs2.next())
//			{
// 				vecRecord1 = new ArrayList();
// 				vecRecord1.add(Helper.correctNull((String)rs2.getString("exp_appno")));
// 				vecRecord1.add(Helper.correctNull((String)rs2.getString("exp_year")));
// 				vecRecord1.add(Helper.correctNull((String)rs2.getString("val1")));
// 				vecRecord1.add(Helper.correctNull((String)rs2.getString("val2")));
// 				vecRecord1.add(Helper.correctNull((String)rs2.getString("val3")));
// 				vecRecord1.add(Helper.correctNull((String)rs2.getString("val4")));
// 				vecRecord1.add(Helper.correctNull((String)rs2.getString("val5")));
// 				vecRecord1.add(Helper.correctNull((String)rs2.getString("val6")));
// 				vecExp.add(vecRecord1);
//			}
// 			hshRecord.put("vecExp", vecExp); 			
// 			rs3=DBUtils.executeLAPSQuery("sel_agrMachExpenses23^"+appno);
// 			while(rs3.next())
//			{
// 				vecRecord1 = new ArrayList(); 				
// 				vecRecord1.add(Helper.correctNull((String)rs3.getString("exp_year")));
// 				vecExpYear.add(vecRecord1);
//			}
// 			hshRecord.put("vecExpYear", vecExpYear); 			
//		}
//		catch(Exception ce)
//		{
//			throw new EJBException("Error in getData "+ce.toString());
//		}
//		finally
//		{
//			try
//			{
//				if(rs != null)
//				{
//					rs.close();
//				}
//				if(rs1 != null)
//				{
//					rs1.close();					 
//				}
//				if(rs2 != null)
//				{
//					rs2.close();					 
//				}
//				if(rs3 != null)
//				{
//					rs3.close();					 
//				}				
//			}
//			catch(Exception cf)
//			{
//				throw new EJBException("Error closing the connection "+cf.getMessage());
//			}
//		}
//		return hshRecord;		
//	}

	public void updatebullockdata(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery =  new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String appno=correctNull((String)hshValues.get("appno"));
		String sel_cart="";
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
		ResultSet rs = null;
		String strschemetype="",strfacsno="",stragrschemetype="";
		HashMap hshScheme = new HashMap();
		try
		{	
			strschemetype	= Helper.correctNull((String )hshValues.get("schemetype"));
			hshScheme = Helper.splitScheme(strschemetype);
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","bullockdatadel");
				arrValues.add(appno);
				arrValues.add(stragrschemetype);
				arrValues.add(strfacsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				sel_cart=Helper.correctNull((String) hshValues.get("sel_cart"));
				if(sel_cart.equalsIgnoreCase(""))
				{
					sel_cart="0";
				}
				arrValues.add(sel_cart);				
				arrValues.add(correctNull((String) hshValues.get("txt_others")));
				arrValues.add(correctNull((String) hshValues.get("txt_manufacture")));
				String txt_distance=Helper.correctNull((String) hshValues.get("txt_distance"));
				if(txt_distance.equalsIgnoreCase(""))
				{
					txt_distance="0";
				}
				arrValues.add(txt_distance);
				//arrValues.add(correctNull((String) hshValues.get("txt_noofcart")));
				String txt_costcart=Helper.correctNull((String) hshValues.get("txt_costcart"));
				if(txt_costcart.equalsIgnoreCase(""))
				{
					txt_costcart="0.00";
				}
				arrValues.add(txt_costcart);
				arrValues.add(correctNull((String) hshValues.get("txt_unitsize")));
				String txt_costbullock=Helper.correctNull((String) hshValues.get("txt_costbullock"));
				if(txt_costbullock.equalsIgnoreCase(""))
				{
					txt_costbullock="0.00";
				}
				arrValues.add(txt_costbullock);
				
				String sel_scope=Helper.correctNull((String) hshValues.get("sel_scope"));
				if(sel_scope.equalsIgnoreCase(""))
				{
					sel_scope="0";
				}
				arrValues.add(sel_scope);
				
				String txt_earnings1=Helper.correctNull((String) hshValues.get("txt_earnings1"));
				if(txt_earnings1.equalsIgnoreCase(""))
				{
					txt_earnings1="0.00";
				}
				arrValues.add(txt_earnings1);
				//
				String txt_acre1=Helper.correctNull((String) hshValues.get("txt_acre1"));
				if(txt_acre1.equalsIgnoreCase(""))
				{
					txt_acre1="0";
				}
				arrValues.add(txt_acre1);
				String txt_guntas1=Helper.correctNull((String) hshValues.get("txt_guntas1"));
				if(txt_guntas1.equalsIgnoreCase(""))
				{
					txt_guntas1="0";
				}
				arrValues.add(txt_guntas1);
				String txt_acre2=Helper.correctNull((String) hshValues.get("txt_acre2"));
				if(txt_acre2.equalsIgnoreCase(""))
				{
					txt_acre2="0";
				}
				arrValues.add(txt_acre2);
				String txt_guntas2=Helper.correctNull((String) hshValues.get("txt_guntas2"));
				if(txt_guntas2.equalsIgnoreCase(""))
				{
					txt_guntas2="0";
				}
				arrValues.add(txt_guntas2);
				String txt_earnings2=Helper.correctNull((String) hshValues.get("txt_earnings2"));
				if(txt_earnings2.equalsIgnoreCase(""))
				{
					txt_earnings2="0.00";
				}
				arrValues.add(txt_earnings2);
				String txt_earnings3=Helper.correctNull((String) hshValues.get("txt_earnings3"));
				if(txt_earnings3.equalsIgnoreCase(""))
				{
					txt_earnings3="0.00";
				}
				arrValues.add(txt_earnings3);
				
				arrValues.add(correctNull((String) hshValues.get("txt_noofcart")));
				String txt_workdays=Helper.correctNull((String) hshValues.get("txt_workdays"));
				if(txt_workdays.equalsIgnoreCase(""))
				{
					txt_workdays="0";
				}
				arrValues.add(txt_workdays);
							
				String txt_unit=Helper.correctNull((String) hshValues.get("txt_unit"));
				if(txt_unit.equalsIgnoreCase(""))
				{
					txt_unit="0";
				}
				arrValues.add(txt_unit);
				String txt_amount=Helper.correctNull((String) hshValues.get("txt_amount"));
				if(txt_amount.equalsIgnoreCase(""))
				{
					txt_amount="0";
				}
				arrValues.add(txt_amount);
				String sel_requirement=Helper.correctNull((String) hshValues.get("sel_requirement"));
				arrValues.add(sel_requirement);
				
				arrValues.add(stragrschemetype);
				arrValues.add(strfacsno);
				
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "bullockdatains");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","bullockdatadel");
				arrValues.add(appno);
				arrValues.add(stragrschemetype);
				arrValues.add(strfacsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");  
			}			
			
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equals("insert") || strAction.equals("update"))
			{
			
				sbAuditTrial
				.append("~Type/Model of cart =")
				.append(correctNull((String) hshValues.get("sel_cart_text")));
				if(correctNull((String) hshValues.get("sel_cart_text")).equalsIgnoreCase("Others"))
				{
				sbAuditTrial
				.append("~If Others Specify  =")
				.append(correctNull((String) hshValues.get("txt_others")));
				}
				sbAuditTrial
				.append("~Place of Manufacture of Cart =")
				.append(correctNull((String) hshValues.get("txt_manufacture")))
				.append("~Distance From Branch  =")
				.append(correctNull((String) hshValues.get("txt_distance")))
				.append(" Km")
				.append("~No. of Carts =")
				.append(correctNull((String) hshValues.get("txt_noofcart")))
				.append("~Unit Cost of Cart =")
				.append(correctNull((String) hshValues.get("txt_costcart")))
				.append("~No. of Bullocks/Camels/Horses/Donkeys =")
				.append(correctNull((String) hshValues.get("txt_unitsize")))
				.append("~Cost per Bullock/Camel/Horse/Donkey =")
				.append(correctNull((String) hshValues.get("txt_costbullock")))
				.append("~Other requirement if any specify =")
				.append(correctNull((String) hshValues.get("sel_requirement")))
				.append(" ")
				.append(correctNull((String) hshValues.get("txt_unit")))
				.append(" ")
				.append("Units")
				.append("~Amount =")
				.append(correctNull((String) hshValues.get("txt_amount")))
				.append("~Techno-Economic Data ^ ")
				.append("~Scope for utilising cart for transportation of own/others ,Commodities =")
				.append(ApplicantParams.getApplicantParams("Liabilities",correctNull((String) hshValues.get("sel_scope"))));
				if((correctNull((String) hshValues.get("sel_cart_text")).equalsIgnoreCase("Others")) && (correctNull((String) hshValues.get("sel_scope")).equalsIgnoreCase("2")))
				{
					sbAuditTrial
				.append("~Expected earning per year =")
				.append(correctNull((String) hshValues.get("txt_earnings1")));
				}
				sbAuditTrial
				.append("~Total lands to be put to Bullocks/Camels/Horses/Donkeys [ Own Land] =")
				.append(correctNull((String) hshValues.get("txt_acre1")))
				.append(" ")
				.append("(Acres)")
				.append(" ")
				.append(correctNull((String) hshValues.get("txt_guntas1")));
				if(Helper.correctNull((String)hshValues.get("land_measurement")).equalsIgnoreCase("c"))
				{
					sbAuditTrial
					.append(" ")
					.append("Cents");
				}
				else if (Helper.correctNull((String)hshValues.get("land_measurement")).equalsIgnoreCase("g"))
				{
					sbAuditTrial
					.append(" ")
					.append("Guntas");
				}
				sbAuditTrial
				.append("~Total lands to be put to Bullocks/Camels/Horses/Donkeys [Other's Land]] =")
				.append(correctNull((String) hshValues.get("txt_acre2")))
				.append(" ")
				.append("(Acres)")
				.append(" ")
				.append(correctNull((String) hshValues.get("txt_guntas2")));
				if(Helper.correctNull((String)hshValues.get("land_measurement")).equalsIgnoreCase("c"))
				{
					sbAuditTrial
					.append(" ")
					.append("Cents");
				}
				else if (Helper.correctNull((String)hshValues.get("land_measurement")).equalsIgnoreCase("g"))
				{
					sbAuditTrial
					.append(" ")
					.append("Guntas");
				}
				
				if (Helper.correctNull((String)hshValues.get("audit_flag")).equalsIgnoreCase("Y"))
				{
					hshValues.put("strAction","update");
				}
				
				sbAuditTrial
				.append("~Expected earning from ploughing per year [Own Land] =")
				.append(correctNull((String) hshValues.get("txt_earnings2"))).append(" ").append("(per Year)")
				.append("~Expected earning from ploughing per year [Other's Land] =")
				.append(correctNull((String) hshValues.get("txt_earnings3"))).append(" ").append("(per Year)")
				.append("~No. of days Bullocks/Camels/Horses/Donkeys put into work =")
				.append(correctNull((String) hshValues.get("txt_workdays")))
				.append(" ")
				.append("(days per year)");
			}
				
				AuditTrial.auditLog(hshValues,"273",appno,sbAuditTrial.toString());
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

	public  HashMap getbullockdata(HashMap hshValues) 
	{		
		String strQuery="";
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		HashMap hshResult = new HashMap();
		String strschemetype="",strfacsno="",stragrschemetype="";
		HashMap hshScheme = new HashMap();
		try
		{
			java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
			jtn.setGroupingUsed(false);
			
			strschemetype	= Helper.correctNull((String )hshValues.get("schemetype"));	
			hshScheme = Helper.splitScheme(strschemetype);
			
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			
			String appno=correctNull((String)hshValues.get("appno"));	
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			//String appstatus=Helper.correctNull((String)hshValues.get("appstatus1"));
			//hshResult.put("appstatus",appstatus);
			strQuery = SQLParser.getSqlQuery("agrgetbullockdata^"+appno+"^"+stragrschemetype+"^"+strfacsno);			
			rs2 =DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				hshResult.put("sel_cart",correctNull(rs2.getString("sel_cart")));
				hshResult.put("txt_others",correctNull(rs2.getString("cart_others")));
				hshResult.put("txt_manufacture",correctNull(rs2.getString("cart_manufacture")));
				hshResult.put("txt_distance",correctNull(rs2.getString("cart_distance")));
				hshResult.put("txt_costcart",correctNull(rs2.getString("cart_costcart")));
				hshResult.put("txt_noofcart",correctNull(rs2.getString("cart_unitsize")));
				hshResult.put("txt_costbullock",correctNull(rs2.getString("cart_costbullock")));
				hshResult.put("sel_scope",correctNull(rs2.getString("sel_scope")));
				hshResult.put("txt_earnings1",correctNull(rs2.getString("cart_earnings1")));
				hshResult.put("txt_acre1",correctNull(rs2.getString("cart_acre1")));
				hshResult.put("txt_guntas1",correctNull(rs2.getString("cart_guntas1")));
				hshResult.put("txt_acre2",correctNull(rs2.getString("cart_acre2")));
				hshResult.put("txt_guntas2",correctNull(rs2.getString("cart_guntas2")));
				hshResult.put("txt_earnings2",correctNull(rs2.getString("cart_earnings2")));
				hshResult.put("txt_earnings3",correctNull(rs2.getString("cart_earnings3")));
				hshResult.put("txt_unitsize",correctNull(rs2.getString("cart_noofbullocks")));
				hshResult.put("txt_workdays",correctNull(rs2.getString("cart_workingdays")));
				
				hshResult.put("cart_requirement",correctNull(rs2.getString("cart_requirement")));
				hshResult.put("cart_unit",correctNull(rs2.getString("cart_unit")));
				hshResult.put("cart_amount",correctNull(rs2.getString("cart_amount")));
				hshResult.put("audit_flag","Y");
				
				
			}	
			/*strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
			rs2 = DBUtils.executeQuery(strQuery);
			if(rs2.next())
			{
				 hshResult.put("land_measurement",Helper.correctNull(rs2.getString("land_measurement")));
			}*/
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
	public void updateBullockFinancial(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery =  new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		
		String appno=correctNull((String)hshValues.get("appno"));
		
		
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
		ResultSet rs = null;
		String strschemetype="",strfacsno="",stragrschemetype="";
		HashMap hshScheme = new HashMap();
		try
		{	
			strschemetype	= Helper.correctNull((String )hshValues.get("schemetype"));	
			hshScheme = Helper.splitScheme(strschemetype);
			
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","bullockfinancialdatadel");
				arrValues.add(appno);
				arrValues.add(stragrschemetype);
				arrValues.add(strfacsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				String txt_greenfodder=Helper.correctNull((String) hshValues.get("txt_greenfodderwork"));
				if(txt_greenfodder.equalsIgnoreCase(""))
				{
					txt_greenfodder="0.00";
				}
				arrValues.add(txt_greenfodder);	
				String txt_dryfodder=Helper.correctNull((String) hshValues.get("txt_dryfodderwork"));
				if(txt_dryfodder.equalsIgnoreCase(""))
				{
					txt_dryfodder="0.00";
				}
				arrValues.add(txt_dryfodder);			
				String txt_concentratefood=Helper.correctNull((String) hshValues.get("txt_concentratefoodwork"));
				if(txt_concentratefood.equalsIgnoreCase(""))
				{
					txt_concentratefood="0.00";
				}
				arrValues.add(txt_concentratefood);		
				
				String txt_total=Helper.correctNull((String) hshValues.get("txt_totalwork"));
				if(txt_total.equalsIgnoreCase(""))
				{
					txt_total="0.00";
				}
				arrValues.add(txt_total);	
				String txt_veterinaryaid=Helper.correctNull((String) hshValues.get("txt_veterinaryaid"));
				if(txt_veterinaryaid.equalsIgnoreCase(""))
				{
					txt_veterinaryaid="0.00";
				}
				arrValues.add(txt_veterinaryaid);	
				String txt_insurancebullock=Helper.correctNull((String) hshValues.get("txt_insurancebullock"));
				if(txt_insurancebullock.equalsIgnoreCase(""))
				{
					txt_insurancebullock="0.00";
				}
				arrValues.add(txt_insurancebullock);
				String txt_insurancecart=Helper.correctNull((String) hshValues.get("txt_insurancecart"));
				if(txt_insurancecart.equalsIgnoreCase(""))
				{
					txt_insurancecart="0.00";
				}
				arrValues.add(txt_insurancecart);
				arrValues.add(correctNull((String) hshValues.get("txt_other")));
				String txt_expenses=Helper.correctNull((String) hshValues.get("txt_otherexpenses"));
				if(txt_expenses.equalsIgnoreCase(""))
				{
					txt_expenses="0.00";
				}
				arrValues.add(txt_expenses);
				String txt_costbullock=Helper.correctNull((String) hshValues.get("txt_costbullock"));
				if(txt_costbullock.equalsIgnoreCase(""))
				{
					txt_costbullock="0.00";
				}
				arrValues.add(txt_costbullock);
				String txt_costcart=Helper.correctNull((String) hshValues.get("txt_costcart"));
				if(txt_costcart.equalsIgnoreCase(""))
				{
					txt_costcart="0.00";
				}
				arrValues.add(txt_costcart);
				String txt_insurancepremium=Helper.correctNull((String) hshValues.get("txt_insurancepremium"));
				if(txt_insurancepremium.equalsIgnoreCase(""))
				{
					txt_insurancepremium="0.00";
				}
				arrValues.add(txt_insurancepremium);
				String txt_others1=Helper.correctNull((String) hshValues.get("txt_others1"));
				if(txt_others1.equalsIgnoreCase(""))
				{
					txt_others1="0.00";
				}
				arrValues.add(txt_others1);
				String txt_total1=Helper.correctNull((String) hshValues.get("txt_total1"));
				if(txt_total1.equalsIgnoreCase(""))
				{
					txt_total1="0.00";
				}
				arrValues.add(txt_total1);
				String txt_loanamount=Helper.correctNull((String) hshValues.get("txt_loanamount"));
				if(txt_loanamount.equalsIgnoreCase(""))
				{
					txt_loanamount="0.00";
				}
				arrValues.add(txt_loanamount);
				
				arrValues.add(correctNull((String) hshValues.get("txt_others2")));
				String txt_margin=Helper.correctNull((String) hshValues.get("txt_margin"));
				if(txt_margin.equalsIgnoreCase(""))
				{
					txt_margin="0";
				}
				arrValues.add(txt_margin);
				String txt_marginval=Helper.correctNull((String) hshValues.get("txt_marginval"));
				if(txt_marginval.equalsIgnoreCase(""))
				{
					txt_marginval="0";
				}
				arrValues.add(txt_marginval);
				String txt_subsidy=Helper.correctNull((String) hshValues.get("txt_subsidy"));
				if(txt_subsidy.equalsIgnoreCase(""))
				{
					txt_subsidy="0";
				}
				arrValues.add(txt_subsidy);
				String txt_subsidyval=Helper.correctNull((String) hshValues.get("txt_subsidyval"));
				if(txt_subsidyval.equalsIgnoreCase(""))
				{
					txt_subsidyval="0";
				}
				arrValues.add(txt_subsidyval);
				
				String txt_greenfoddernonwork=Helper.correctNull((String) hshValues.get("txt_greenfoddernonwork"));
				if(txt_greenfoddernonwork.equalsIgnoreCase(""))
				{
					txt_greenfoddernonwork="0.00";
				}
				arrValues.add(txt_greenfoddernonwork);	
				
			
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_dryfoddernonwork")));			
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_concentratefoodnonwork")));	
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_mainten")));	
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_totalnonwork")));	
					
				arrValues.add(stragrschemetype);
				arrValues.add(strfacsno);
												
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "bullockfinancialdatains");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				arrValues=new ArrayList(); 
				hshQuery=new HashMap();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","bullockfinancialdatadel");
				arrValues.add(appno);
				arrValues.add(stragrschemetype);
				arrValues.add(strfacsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");  
			}
			
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equals("insert") || strAction.equals("update"))
			{
			
			sbAuditTrial
				.append("~ Expenses on feeding Bullocks/Camels/Horses/Donkeys (per day / per Bullock/Camel/Horse/Donkey) ^ ")
				.append("~ Working days ^")
				.append("~ Green Fodder=")
				.append(correctNull((String) hshValues.get("txt_greenfodderwork")))
				.append("~ Dry Fodder=")
				.append(correctNull((String) hshValues.get("txt_dryfodderwork")))
				.append("~Concentrate Food =")
				.append(correctNull((String) hshValues.get("txt_concentratefoodwork")))
				.append("~Total =")
				.append(correctNull((String) hshValues.get("txt_totalwork")))
				.append("~ Non-Working days ^")
				.append("~Green Fodder =")
				.append(correctNull((String) hshValues.get("txt_greenfoddernonwork")))
				.append("~Dry Fodder =")
				.append(correctNull((String) hshValues.get("txt_dryfoddernonwork")))
				.append("~Concentrate Food =")
				.append(correctNull((String) hshValues.get("txt_concentratefoodnonwork")))
				.append("~Total =")
				.append(correctNull((String) hshValues.get("txt_totalnonwork")))
				.append("~Veterinary Aid Expenses (per annum/Bullock/Camel/Horse/Donkey) =")
				.append(correctNull((String) hshValues.get("txt_veterinaryaid")))
				.append("~Insurance of Bullocks/Camels/Horses/Donkeys(per annum / Bullock/Camel/Horse/Donkey) =")
				.append(correctNull((String) hshValues.get("txt_insurancebullock")))
				.append("~Insurance of Cart (per annum / cart) =")
				.append(correctNull((String) hshValues.get("txt_insurancecart")))
				.append("~Repair and Maintenance of Cart(per day / Bullock/Camel/Horse/Donkey) =")
				.append(correctNull((String) hshValues.get("txt_mainten")))
				.append("~Others ( Specify) =")
				.append(correctNull((String) hshValues.get("txt_other")))
				.append("(per day)")
				.append(correctNull((String) hshValues.get("txt_otherexpenses")));
				if (Helper.correctNull((String)hshValues.get("audit_flag")).equalsIgnoreCase("Y"))
				{
					hshValues.put("strAction","update");
				}
			
				
			}
				AuditTrial.auditLog(hshValues,"274",appno,sbAuditTrial.toString());
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

	public  HashMap getBullockFinancial(HashMap hshValues) 
	{		
		String strQuery="";
		ResultSet rs = null;
		HashMap hshResult = new HashMap();
		String strschemetype="",strfacsno="",stragrschemetype="";
		HashMap hshScheme = new HashMap();
		try
		{	
			String appstatus=Helper.correctNull((String)hshValues.get("appstatus1"));
			hshResult.put("appstatus",appstatus);
			java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
			jtn.setGroupingUsed(false);
			
			strschemetype	= Helper.correctNull((String )hshValues.get("schemetype"));	
			hshScheme = Helper.splitScheme(strschemetype);
			
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			String appno=correctNull((String)hshValues.get("appno"));
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
			if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
			{
				prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
			}
			strQuery = SQLParser.getSqlQuery("agrgetbullockdata^"+appno+"^"+stragrschemetype+"^"+strfacsno);			
			rs =DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshResult.put("sel_cart",correctNull(rs.getString("sel_cart")));
				
			}	
			strQuery = SQLParser.getSqlQuery("agrgetfinancialbullockdata^"+appno+"^"+stragrschemetype+"^"+strfacsno);	
			if(rs!=null)
				rs.close();
			rs =DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshResult.put("txt_greenfodderwork",correctNull(rs.getString("bullock_greenfodder")));
				hshResult.put("txt_dryfodderwork",correctNull(rs.getString("bullock_dryfodder")));
				hshResult.put("txt_concentratefoodwork",correctNull(rs.getString("bullock_concentratefood")));
				hshResult.put("txt_totalwork",correctNull(rs.getString("bullock_total")));
				hshResult.put("txt_veterinaryaid",correctNull(rs.getString("bullock_veterinaryaid")));
				hshResult.put("txt_insurancebullock",correctNull(rs.getString("bullock_insurancebullock")));
				hshResult.put("txt_insurancecart",correctNull(rs.getString("bullock_insurancecart")));
				hshResult.put("txt_other",correctNull(rs.getString("bullock_other")));
							
				hshResult.put("txt_otherexpenses",correctNull(rs.getString("bullock_expenses")));
				hshResult.put("txt_costbullock",correctNull(rs.getString("bullock_costbullock")));
				hshResult.put("txt_costcart",correctNull(rs.getString("bullock_costcart")));
				hshResult.put("txt_insurancepremium",correctNull(rs.getString("bullock_insurancepremium")));
				hshResult.put("txt_others1",correctNull(rs.getString("bullock_others1")));
				hshResult.put("txt_total1",correctNull(rs.getString("bullock_total1")));
				hshResult.put("txt_loanamount",correctNull(rs.getString("bullock_loanamount")));
				hshResult.put("txt_others2",correctNull(rs.getString("bullock_others2")));
				hshResult.put("txt_margin",correctNull(rs.getString("bullock_margin")));
				hshResult.put("txt_marginval",correctNull(rs.getString("bullock_marginval")));
				hshResult.put("txt_subsidy",correctNull(rs.getString("bullock_subsidy")));
				hshResult.put("txt_subsidyval",correctNull(rs.getString("bullock_subsidyval")));
				
				hshResult.put("txt_greenfoddernonwork",correctNull(rs.getString("bullock_greenonworkdays")));
				hshResult.put("txt_dryfoddernonwork",correctNull(rs.getString("bullock_drynonworkdays")));
				hshResult.put("txt_concentratefoodnonwork",correctNull(rs.getString("bullock_concentrate")));
				hshResult.put("txt_mainten",correctNull(rs.getString("bullock_cartrepair")));
				hshResult.put("txt_totalnonwork",correctNull(rs.getString("bullock_totalnonworkdays")));
				hshResult.put("audit_flag","Y");
				
				
				
				
				
				
			}	
			/*strQuery = SQLParser.getSqlQuery("agr_sel_bullockrepay^"+appno+ "^" +prd_type);			
			rs2 =DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				hshResult.put("txt_roi",correctNull(rs2.getString("bullock_roi")));
				hshResult.put("txt_holiday",correctNull(rs2.getString("bullock_holiday")));
				hshResult.put("sel_payment",correctNull(rs2.getString("bullock_payment")));
				hshResult.put("txt_installment",correctNull(rs2.getString("bullock_installment")));
				hshResult.put("txt_date",correctNull(rs2.getString("bullock_date")));
				hshResult.put("txt_lastinstallment",correctNull(rs2.getString("bullock_lastinstallment")));
			}*/
			return hshResult;
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getBullockFinancial "+ce.toString());
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
	
	public void updateLDdata(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery =  new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String appno=correctNull((String)hshValues.get("appno"));	
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
		ResultSet rs = null;
		try
		{			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","LDdatadel");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				String txt_lactrationdays=Helper.correctNull((String) hshValues.get("txt_lactrationdays"));
				if(txt_lactrationdays.equalsIgnoreCase(""))
				{
					txt_lactrationdays="280";
				}
				arrValues.add(txt_lactrationdays);	
				String txt_drydays=Helper.correctNull((String) hshValues.get("txt_drydays"));
				if(txt_drydays.equalsIgnoreCase(""))
				{
					txt_drydays="60";
				}
				arrValues.add(txt_drydays);			
				String txt_months=Helper.correctNull((String) hshValues.get("txt_months"));
				if(txt_months.equalsIgnoreCase(""))
				{
					txt_months="0";
				}
				arrValues.add(txt_months);		
				String txt_firstltotal=Helper.correctNull((String) hshValues.get("txt_firstltotal"));
				if(txt_firstltotal.equalsIgnoreCase(""))
				{
					txt_firstltotal="0";
				}
				arrValues.add(txt_firstltotal);	
				String txt_firstdtotal=Helper.correctNull((String) hshValues.get("txt_firstdtotal"));
				if(txt_firstdtotal.equalsIgnoreCase(""))
				{
					txt_firstdtotal="0";
				}
				arrValues.add(txt_firstdtotal);	
				String txt_secondltotal=Helper.correctNull((String) hshValues.get("txt_secondltotal"));
				if(txt_secondltotal.equalsIgnoreCase(""))
				{
					txt_secondltotal="0";
				}
				arrValues.add(txt_secondltotal);
				String txt_seconddtotal=Helper.correctNull((String) hshValues.get("txt_seconddtotal"));
				if(txt_seconddtotal.equalsIgnoreCase(""))
				{
					txt_seconddtotal="0";
				}
				arrValues.add(txt_seconddtotal);
				String txt_thirdltotal=Helper.correctNull((String) hshValues.get("txt_thirdltotal"));
				if(txt_thirdltotal.equalsIgnoreCase(""))
				{
					txt_thirdltotal="0";
				}
				arrValues.add(txt_thirdltotal);
				String txt_thirddtotal=Helper.correctNull((String) hshValues.get("txt_thirddtotal"));
				if(txt_thirddtotal.equalsIgnoreCase(""))
				{
					txt_thirddtotal="0";
				}
				arrValues.add(txt_thirddtotal);
				String txt_fourthltotal=Helper.correctNull((String) hshValues.get("txt_fourthltotal"));
				if(txt_fourthltotal.equalsIgnoreCase(""))
				{
					txt_fourthltotal="0";
				}
				arrValues.add(txt_fourthltotal);
				String txt_fourthdtotal=Helper.correctNull((String) hshValues.get("txt_fourthdtotal"));
				if(txt_fourthdtotal.equalsIgnoreCase(""))
				{
					txt_fourthdtotal="0";
				}
				arrValues.add(txt_fourthdtotal);
				String txt_fifthltotal=Helper.correctNull((String) hshValues.get("txt_fifthltotal"));
				if(txt_fifthltotal.equalsIgnoreCase(""))
				{
					txt_fifthltotal="0";
				}
				arrValues.add(txt_fifthltotal);
				String txt_fifthdtotal=Helper.correctNull((String) hshValues.get("txt_fifthdtotal"));
				if(txt_fifthdtotal.equalsIgnoreCase(""))
				{
					txt_fifthdtotal="0";
				}
				arrValues.add(txt_fifthdtotal);
				String txt_sixthltotal=Helper.correctNull((String) hshValues.get("txt_sixthltotal"));
				if(txt_sixthltotal.equalsIgnoreCase(""))
				{
					txt_sixthltotal="0";
				}
				arrValues.add(txt_sixthltotal);
				String txt_sixthdtotal=Helper.correctNull((String) hshValues.get("txt_sixthdtotal"));
				if(txt_sixthdtotal.equalsIgnoreCase(""))
				{
					txt_sixthdtotal="0";
				}
				arrValues.add(txt_sixthdtotal);
				String txt_seventhltotal=Helper.correctNull((String) hshValues.get("txt_seventhltotal"));
				if(txt_seventhltotal.equalsIgnoreCase(""))
				{
					txt_seventhltotal="0";
				}
				arrValues.add(txt_seventhltotal);
				String txt_seventhdtotal=Helper.correctNull((String) hshValues.get("txt_seventhdtotal"));
				if(txt_seventhdtotal.equalsIgnoreCase(""))
				{
					txt_seventhdtotal="0";
				}
				arrValues.add(txt_seventhdtotal);
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "LDdatains");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","LDdatadel");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");  
			}			
			
			hshValues.put("strCheck","yes");
			
			UpdateDairyData updateDairyData = new UpdateDairyData();
			updateDairyData.updateDataForDairy(hshValues);
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{
			sbAuditTrial
			.append("~Lactation Days = ").append(Helper.correctNull((String) hshValues.get("txt_lactrationdays"))).append("   (280 Days-360 Days)")
			.append("~Dry Days = ").append(Helper.correctNull((String) hshValues.get("txt_drydays"))).append("   (0 Days- 80 Days)")
			.append("~Interval Between Batches in Months = ").append(Helper.correctNull((String) hshValues.get("txt_months")));
			
			if(correctNull((String)hshValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
			{
				hshValues.put("strAction", "update");
			}
			else
			{
				hshValues.put("strAction", "insert");
			}
			}
			AuditTrial.auditLog(hshValues,"241",appno,sbAuditTrial.toString());
				
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

	public  HashMap getLDdata(HashMap hshValues) 
	{		
		String strQuery="";
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		HashMap hshResult = new HashMap();	
		try
		{
			java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
			jtn.setGroupingUsed(false);
			String appno=correctNull((String)hshValues.get("appno"));	
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			strQuery = SQLParser.getSqlQuery("getLDdata^"+appno);			
			rs2 =DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				String txt_lactrationdays=correctNull((String)rs2.getString("lactationdays"));
				if(txt_lactrationdays.equalsIgnoreCase(""))
				{
					txt_lactrationdays="280";	
				}
				else
				{
					hshResult.put("txt_lactrationdays",correctNull(rs2.getString("lactationdays")));
				}
				String txt_drydays=correctNull((String)rs2.getString("drydays"));
				if(txt_drydays.equalsIgnoreCase(""))
				{
					txt_drydays="60";	
				}
				else
				{
					hshResult.put("txt_drydays",correctNull(rs2.getString("drydays")));
				}
				hshResult.put("txt_months",correctNull(rs2.getString("months")));
				hshResult.put("auditFlag", "Y");
			}
			if(rs2 != null)
			{
				rs2.close();
			}	
			strQuery = SQLParser.getSqlQuery("agrsel_stockdetails^" + appno);
			rs2 = DBUtils.executeQuery(strQuery);
		
			if (rs2.next()) 
			{	
				hshResult.put("agr_batch_purchased",correctNull((String)rs2.getString("agr_batch_purchased")));
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

	public HashMap getcapldata(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;ResultSet rs2 = null;
		HashMap hshRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		double totmarketval=0.00,totloanamt=0.00;
		String appno=correctNull((String)hshValues.get("appno"));
		
		String schemetype="";
		schemetype = Helper.correctNull((String) hshValues.get("schemetype"));
		String strschemetype="",strfacsno="",stragrschemetype="";
		HashMap hshScheme = new HashMap();
		hshScheme = Helper.splitScheme(schemetype);
		if(hshScheme!=null)
		{
			strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
			if(strfacsno.equalsIgnoreCase(""))
				strfacsno = Helper.correctNull((String)hshValues.get("facsno"));
			stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			if(stragrschemetype.equalsIgnoreCase(""))
				stragrschemetype = Helper.correctNull((String)hshValues.get("schemetype"));
		}
		
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
		String capl_invoicedate="";
        String PageType=Helper.correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
        {
        	 PageType=Helper.correctNull((String)hshValues.get("hidpagetype"));
        }
        
		try 
		{
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}
			strQuery = SQLParser.getSqlQuery("agr_get_capldata^"+appno+"^"+stragrschemetype+"^"+strfacsno);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) 
			{
				hshRecord.put("txt_warehouse", Helper.correctDoubleQuote(correctNull(rs1.getString("capl_warehouse"))));
				hshRecord.put("txtgodownno", Helper.correctDoubleQuote(correctNull(rs1.getString("capl_godownno"))));
				hshRecord.put("txr_address", Helper.correctDoubleQuote(correctNull(rs1.getString("capl_address"))));
				hshRecord.put("sel_warehouse", Helper.correctDoubleQuote(correctNull(rs1.getString("capl_selwarehouse"))));
				hshRecord.put("txt_distance", Helper.correctDoubleQuote(correctNull(rs1.getString("capl_distance"))));
				hshRecord.put("txt_accesibilty", Helper.correctDoubleQuote(correctNull(rs1.getString("capl_accesibility"))));
				hshRecord.put("sel_applicant", Helper.correctDoubleQuote(correctNull(rs1.getString("capl_applicant"))));
				hshRecord.put("sel_license", Helper.correctDoubleQuote(correctNull(rs1.getString("capl_license"))));
				hshRecord.put("txt_licenseno", Helper.correctDoubleQuote(correctNull(rs1.getString("capl_licenseno"))));
				//hshRecord.put("agr_units", correctNull(rs1.getString("agr_units")));
				hshRecord.put("capl_weightmeasure1", correctNull(rs1.getString("capl_weightmeasure1")));
				hshRecord.put("capl_weightmeasure2", correctNull(rs1.getString("capl_weightmeasure2")));
				hshRecord.put("capl_weightmeasure3", correctNull(rs1.getString("capl_weightmeasure3")));
				hshRecord.put("sel_warehouse_owned", Helper.correctDoubleQuote(correctNull(rs1.getString("capl_selwarehouse_owned"))));
				
				
			}
			else
			{
				hshRecord.put("auditFlag", "Y");
			}
			
				 if (rs1 != null)
				    {
					rs1.close();
				    }
				 			
				 strQuery = SQLParser.getSqlQuery("agr_get_caplinsdata^"+appno+"^"+stragrschemetype+"^"+strfacsno);
					rs2= DBUtils.executeQuery(strQuery);
					String txt_date="";String txt_duedate="";
					if (rs2.next()) 
					{
						hshRecord.put("sel_insurance", Helper.correctDoubleQuote(correctNull(rs2.getString("capl_insurance"))));
						hshRecord.put("txt_insurance", Helper.correctDoubleQuote(correctNull(rs2.getString("capl_insurancename"))));
						hshRecord.put("txt_policyno", Helper.correctDoubleQuote(correctNull(rs2.getString("capl_policyno"))));
						txt_date=correctNull((String)rs2.getString("capl_date"));
						if(txt_date.equalsIgnoreCase("01/01/1900"))
						{
							txt_date="";
						}
						else
						{
						
						txt_date=Helper.correctDoubleQuote(correctNull(rs2.getString("capl_date")));
							}

						hshRecord.put("txt_date", txt_date);
				
						hshRecord.put("txt_amount", Helper.correctDoubleQuote(correctNull(rs2.getString("capl_amount"))));
						txt_duedate=correctNull((String)rs2.getString("capl_duedate"));
						if(txt_duedate.equalsIgnoreCase("01/01/1900"))
						{
							txt_duedate="";
						}
						else
						{
							txt_duedate=Helper.correctDoubleQuote(correctNull(rs2.getString("capl_duedate")));	
						}

						hshRecord.put("txt_duedate", txt_duedate);
						
				     	}
					         
						 if (rs2 != null)
						    {
							rs2.close();
						    }
						 							 
			strQuery = SQLParser.getSqlQuery("per_get_capldata^"+appno+"^"+stragrschemetype+"^"+strfacsno);
			rs = DBUtils.executeQuery(strQuery);
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
			
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("PageType", PageType);
			hshRecord.put("totloanamt", Helper.formatDoubleValue(totloanamt));
			hshRecord.put("totmarketval",Helper.formatDoubleValue(totmarketval));
			
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

	public HashMap updatecapldata(HashMap hshValues)  
	{
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshQuery5 = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strAction = null;		
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
		String sel_applicant= correctNull((String) hshValues.get("sel_applicant"));
		String strScheme= correctNull((String) hshValues.get("hidscheme"));
		String strSno= correctNull((String) hshValues.get("hidSno"));		
		String strUnits=correctNull((String) hshValues.get("sel_units"));
		String strMeasureunit1=correctNull((String)hshValues.get("sel_unitsy1"));
		String strMeasureunit2=correctNull((String)hshValues.get("sel_unitsy2"));
		String strMeasureunit3=correctNull((String)hshValues.get("sel_unitsy3"));
		
		if(sel_applicant.equalsIgnoreCase(""))
		{
			sel_applicant="0";	
		}
		else
		{
			sel_applicant= correctNull((String) hshValues.get("sel_applicant"));
		}
		String sel_license= correctNull((String) hshValues.get("sel_license"));
		if(sel_license.equalsIgnoreCase(""))
		{
			sel_license="0";	
		}
		else
		{
			sel_license= correctNull((String) hshValues.get("sel_license"));
		}
		String txt_warehouse = correctNull((String) hshValues.get("txt_warehouse"));
		String  txtgodownno = correctNull((String) hshValues.get("txtgodownno"));
		String  txr_address= correctNull((String) hshValues.get("txr_address"));
		String sel_warehouse= correctNull((String) hshValues.get("sel_warehouse"));
		String sel_warehouse_ownedother=correctNull((String)hshValues.get("sel_ownedother"));
		if(sel_warehouse.equalsIgnoreCase(""))
		{
			sel_warehouse="0";	
		}
		else
		{
			sel_warehouse= correctNull((String) hshValues.get("sel_warehouse"));
		}
		String txt_distance = correctNull((String) hshValues.get("txt_distance"));
		String txt_accesibilty = correctNull((String) hshValues.get("txt_accesibilty"));
		String txt_insurance = correctNull((String) hshValues.get("txt_insurance"));
		String  txt_policyno = correctNull((String) hshValues.get("txt_policyno"));
		String  txt_amount= correctNull((String) hshValues.get("txt_amount"));
		String sel_insurance= correctNull((String) hshValues.get("sel_insurance"));
		String  txt_date= correctNull((String) hshValues.get("txt_date"));
		String txt_duedate= correctNull((String) hshValues.get("txt_duedate"));
		
		if(sel_insurance.equalsIgnoreCase(""))
		{
			sel_insurance="0";	
		}
		else
		{
			sel_insurance= correctNull((String) hshValues.get("sel_insurance"));
		}
		
		String txt_licenseno = correctNull((String) hshValues.get("txt_licenseno"));
		
		String strMarPrice=Helper.correctDouble((String) hshValues.get("txt_totmarketval"));
		String strWareHouseTotal=Helper.correctDouble((String) hshValues.get("txt_totlreciptvalue"));
		String strFinal="";
		if(Double.parseDouble(strMarPrice)<Double.parseDouble(strWareHouseTotal))
		{
			strFinal=strMarPrice;
		}
		else
		{
			strFinal=strWareHouseTotal;
		}
		
		try 
		{
			String[] txt_namewarehouse1 = null;
			String[]txt_warehousedoc1 = null;
			String[] txt_units1 = null;
			String[] txt_weight1 = null;
			String[]txt_marketrate1 = null;
			String[] txt_marketval1 = null;
			String[] txt_invoiceval1 = null;
			String[] txt_invoicedate1 = null;
			String[] txt_loanamt = null;
			txt_namewarehouse1 = (String[]) hshValues.get("txt_namewarehouse1");
			txt_warehousedoc1= (String[]) hshValues.get("txt_warehousedoc1");
			txt_units1 = (String[]) hshValues.get("txt_units1");
			strid = correctNull((String) hshValues.get("hid_sno"));
			txt_weight1 = (String[]) hshValues.get("txt_weight1");
			txt_marketrate1 = (String[]) hshValues.get("txt_marketrate1");
			txt_marketval1  = (String[]) hshValues.get("txt_marketval1");
			txt_invoiceval1 = (String[]) hshValues.get("txt_invoiceval1");
			txt_invoicedate1  = (String[]) hshValues.get("txt_invoicedate1");
			txt_loanamt = (String[]) hshValues.get("txt_loanamt");
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshResult.put("applicantid", rs.getString("demo_appid"));
			}
							
			if (strAction.equals("delete"))
			{
				hshQuery4 = new HashMap();
				HashMap hshQueryValues4 = new HashMap();
				ArrayList arrValues4 = new ArrayList();
				hshQueryValues4.put("size", "1");
				hshQuery4.put("strQueryId", "per_del_capldata");
				arrValues4.add(appno);
				arrValues4.add(strScheme);
				arrValues4.add(strSno);
				hshQuery4.put("arrValues", arrValues4);
				hshQueryValues4.put("1", hshQuery4);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
				
				HashMap hshPhysical=new HashMap();
				hshPhysical.put("scheme_sno", "1");		//Sand Casting
				hshPhysical.put("scheme_type", Helper.correctNull((String)hshValues.get("schemetype")));
				hshPhysical.put("total_cost", "");
				hshPhysical.put("hidAction", "delete");
				hshPhysical.put("appno",appno);
				hshPhysical.put("page_id","LL");
				HashMap hshValuesAgri = (HashMap) EJBInvoker.executeStateLess("agrlandholdings", hshPhysical, "updatePhysicalProgramme");
			}
			if (strAction.equals("delete"))
			{
				hshQuery5 = new HashMap();
				HashMap hshQueryValues5 = new HashMap();
				ArrayList arrValues5 = new ArrayList();
				hshQueryValues5.put("size", "1");
				hshQuery5.put("strQueryId", "agr_del_capldata");
				arrValues5.add(appno);
				arrValues5.add(strScheme);
				arrValues5.add(strSno);
				hshQuery5.put("arrValues", arrValues5);
				hshQueryValues5.put("1", hshQuery5);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues5,"updateData");
			}
			if (strAction.equals("delete"))
			{
				hshQuery5 = new HashMap();
				HashMap hshQueryValues5 = new HashMap();
				ArrayList arrValues5 = new ArrayList();
				hshQueryValues5.put("size", "1");
				hshQuery5.put("strQueryId", "agr_del_caplinsdata");
				arrValues5.add(appno);
				arrValues5.add(strScheme);
				arrValues5.add(strSno);
				hshQuery5.put("arrValues", arrValues5);
				hshQueryValues5.put("1", hshQuery5);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues5,"updateData");
			}
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQuery= new HashMap();
				 arrValues = new ArrayList();
				hshQuery.put("size", "2");
				hshQuery.put("strQueryId", "agr_del_capldata");
				arrValues.add(appno);
				arrValues.add(strScheme);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);	
				hshQueryValues.put("1",hshQuery);
				hshQuery= new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(txt_warehouse);
				arrValues.add(txtgodownno);
				arrValues.add(txr_address);
				arrValues.add(sel_warehouse);
				arrValues.add(txt_distance);
				arrValues.add(txt_accesibilty);
				arrValues.add(sel_applicant);
				arrValues.add(sel_license);
				arrValues.add(txt_licenseno);
				arrValues.add(strScheme);
				arrValues.add(strSno);
				arrValues.add(strUnits);
				arrValues.add(strMeasureunit1);
				arrValues.add(strMeasureunit2);
				arrValues.add(strMeasureunit3);
				arrValues.add(sel_warehouse_ownedother);
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agr_ins_capldata");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				HashMap hshPhysical=new HashMap();
				hshPhysical.put("scheme_sno", "1");		//Sand Casting
				hshPhysical.put("scheme_type", Helper.correctNull((String)hshValues.get("schemetype")));
				hshPhysical.put("total_cost", Helper.correctDouble(strFinal));
				hshPhysical.put("hidAction", "insert");
				hshPhysical.put("appno",appno);
				hshPhysical.put("page_id","SC");
				hshPhysical.put("plant_sno", "");
				HashMap hshValuesAgri = (HashMap) EJBInvoker.executeStateLess("agrlandholdings", hshPhysical, "updatePhysicalProgramme");
				
			}
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQuery= new HashMap();
				 arrValues = new ArrayList();
				hshQuery.put("size", "2");
				hshQuery.put("strQueryId", "agr_del_caplinsdata");
				arrValues.add(appno);
				arrValues.add(strScheme);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);	
				hshQueryValues.put("1",hshQuery);
				hshQuery= new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(sel_insurance);
				arrValues.add(txt_insurance);
				arrValues.add(txt_policyno);
				if (correctNull(txt_date).equals(""))
				{
					arrValues.add("01/01/1900");
				} 
				else 
				{
					arrValues.add(correctNull(txt_date));
				}
				arrValues.add(txt_amount);
				if (correctNull(txt_duedate).equals(""))
				{
					arrValues.add("01/01/1900");
				} 
				else 
				{
					arrValues.add(correctNull(txt_duedate));
				}
				arrValues.add(strScheme);
				arrValues.add(strSno);
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agr_ins_caplinsdata");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if (strAction.equals("insert"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "2");
				hshQuery3.put("strQueryId", "per_del_capldata");
				arrValues3.add(appno);
				arrValues3.add(strScheme);
				arrValues3.add(strSno);
				hshQuery3.put("arrValues", arrValues3);
				strQuery1 = SQLParser.getSqlQuery("sel_maxid_capldata");
				rs = DBUtils.executeQuery(strQuery1);
				if (rs.next())
				{
					strid = correctNull((String) rs.getString("maxid"));
					f = Integer.parseInt(strid);
				}
				intUpdatesize = 1;

				for (int i = 0; i < txt_namewarehouse1.length; i++)
				{					
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "per_ins_capldata");
					arrValues.add(Integer.toString(f));
					arrValues.add(appno);
					arrValues.add(new Integer(i + 1).toString());
					if (i + 1 == 1) 
					{
						arrValues.add("w1");
					}
					if (i + 1 == 2) 
					{
						arrValues.add("w1");
					}
					if (i + 1 == 3)
					{
						arrValues.add("w1");
					}
					
					if (correctNull( txt_namewarehouse1[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_namewarehouse1[i]));
					}
					if (correctNull(txt_warehousedoc1[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_warehousedoc1[i]));
					}
					if (correctNull(txt_units1[i]).equals("")) 
					{
						arrValues.add("");
					}
					else 
					{
						arrValues.add(correctNull(txt_units1[i]));
					}
					if (correctNull(txt_weight1[i]).equals(""))
					{
						arrValues.add("");
					} 
					else
					{
						arrValues.add(correctNull(txt_weight1[i]));
					}
					if (correctNull(txt_marketrate1[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_marketrate1[i]));
					}
					if (correctNull(txt_marketval1[i]).equals(""))
					{
						arrValues.add("");
					} 
					else
					{
						arrValues.add(correctNull(txt_marketval1[i]));
					}
					if (correctNull(txt_invoiceval1[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_invoiceval1[i]));
					}
				
					if (correctNull(txt_invoicedate1[i]).equals(""))
					{
						arrValues.add("01/01/1900");
					} 
					else 
					{
						arrValues.add(correctNull(txt_invoicedate1[i]));
					}
					if (correctNull(txt_loanamt[i]).equals(""))
					{
						arrValues.add("0.00");
					} 
					else 
					{
						arrValues.add(correctNull(txt_loanamt[i]));
					}	
					arrValues.add(strScheme);
					arrValues.add(strSno);
					hshQuery.put("arrValues", arrValues);
					f = f + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);					
				}
				hshQueryValues.put("1", hshQuery3);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
						
			hshpasValues.put("appno", appno);
			hshpasValues.put("schemetype", Helper.correctNull((String)hshValues.get("schemetype")));
			hshResult = getcapldata(hshpasValues);
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
	//economics
	public  HashMap getBullockEconomic(HashMap hshValues) 
	{		
		String strQuery="";
		ResultSet rs = null;
		HashMap hshResult = new HashMap();	
		double txt_total=0.00,txt_veterinaryaid=0.00,txt_insurancebullock=0.00;
		double txt_insurancecart=0.00,txt_expenses=0.00;
		double txt_unitsize=0.00,txt_earnings1=0.00,txt_earnings2=0.00,txt_earnings3=0.00;
		double feed=0.00,vtaid=0.00,insbullock=0.00,inscart=0.00,ploughing=0.00;
		double nobullocks=0.00,nontotal=0.00,feednon=0.00;
		int noworkdays=0;
		double totexp=0.00; double totinc=0.00,surplus=0.00,txt_maint=0.00;
		String strschemetype="",strfacsno="",stragrschemetype="";
		HashMap hshScheme = new HashMap();
		
		
		try
		{
			strschemetype	= Helper.correctNull((String )hshValues.get("schemetype"));	
			hshScheme = Helper.splitScheme(strschemetype);
			
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
			jtn.setGroupingUsed(false);
			String appno=correctNull((String)hshValues.get("appno"));
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			strQuery = SQLParser.getSqlQuery("agrgetfinancialbullockdata^"+appno+"^"+stragrschemetype+"^"+strfacsno);			
			rs =DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				hshResult.put("txt_total",correctNull(rs.getString("bullock_total")));
				txt_total=Double.parseDouble(Helper.correctDouble(rs.getString("bullock_total")));
				
				hshResult.put("txt_veterinaryaid",correctNull(rs.getString("bullock_veterinaryaid")));
				txt_veterinaryaid=Double.parseDouble(Helper.correctDouble(rs.getString("bullock_veterinaryaid")));
				
				hshResult.put("txt_insurancebullock",correctNull(rs.getString("bullock_insurancebullock")));
				txt_insurancebullock=Double.parseDouble(Helper.correctDouble(rs.getString("bullock_insurancebullock")));
				
				hshResult.put("txt_insurancecart",correctNull(rs.getString("bullock_insurancecart")));
				txt_insurancecart=Double.parseDouble(Helper.correctDouble(rs.getString("bullock_insurancecart")));
				
				hshResult.put("txt_specify",correctNull(rs.getString("bullock_other")));
				
				hshResult.put("txt_specifycost",correctNull(rs.getString("bullock_expenses")));
				txt_expenses=Double.parseDouble(Helper.correctDouble(rs.getString("bullock_expenses")));
				
				hshResult.put("bullock_totalnonworkdays",correctNull(rs.getString("bullock_totalnonworkdays")));
				nontotal=Double.parseDouble(Helper.correctDouble(rs.getString("bullock_totalnonworkdays")));
				
				hshResult.put("bullock_cartrepair",correctNull(rs.getString("bullock_cartrepair")));
				txt_maint=Double.parseDouble(Helper.correctDouble(rs.getString("bullock_cartrepair")));
				
				
			}	
			strQuery = SQLParser.getSqlQuery("agrgetbullockdata^"+appno+"^"+stragrschemetype+"^"+strfacsno);			
			rs =DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshResult.put("txt_unitsize",correctNull(rs.getString("cart_unitsize")));
				txt_unitsize=Double.parseDouble(Helper.correctDouble(rs.getString("cart_unitsize")));
				
				hshResult.put("txt_carttransport",correctNull(rs.getString("cart_earnings1")));
				txt_earnings1=Double.parseDouble(Helper.correctDouble(rs.getString("cart_earnings1")));
				
				hshResult.put("txt_earnings2",correctNull(rs.getString("cart_earnings2")));
				txt_earnings2=Double.parseDouble(Helper.correctDouble(rs.getString("cart_earnings2")));
				
				hshResult.put("txt_earnings3",correctNull(rs.getString("cart_earnings3")));
				txt_earnings3=Double.parseDouble(Helper.correctDouble(rs.getString("cart_earnings3")));
				
				hshResult.put("cart_workingdays",correctNull(rs.getString("cart_workingdays")));
				noworkdays=(int)Double.parseDouble(Helper.correctDouble(rs.getString("cart_workingdays")));
				
				hshResult.put("cart_noofbullocks",correctNull(rs.getString("cart_noofbullocks")));
				nobullocks=Double.parseDouble(Helper.correctDouble(rs.getString("cart_noofbullocks")));
				
				
			}	
			feed=txt_total*noworkdays*txt_unitsize;
			
			feednon=nontotal*txt_unitsize*(365-noworkdays);
			
			
			vtaid=txt_veterinaryaid*txt_unitsize;
			
			insbullock=txt_insurancebullock*txt_unitsize;
			
			inscart=txt_insurancecart*nobullocks;
			
			ploughing=txt_earnings2+txt_earnings3;
			
			
			
			
			txt_expenses=txt_expenses*365;
			
			txt_maint=txt_maint*nobullocks;
			
			totexp=feed+feednon+vtaid+insbullock+inscart+txt_maint+txt_expenses;
			
			totinc=ploughing+txt_earnings1;
			surplus=totinc-totexp;
			hshResult.put("surplus",Helper.formatDoubleValue(surplus));
			hshResult.put("totinc",Helper.formatDoubleValue(totinc));
			hshResult.put("totexp",Helper.formatDoubleValue(totexp));
			hshResult.put("noworkdays",Integer.toString(noworkdays));
			hshResult.put("nonworkdays",Integer.toString(365-noworkdays));
			
			hshResult.put("txt_bullockfeed",Helper.formatDoubleValue(feed));
			hshResult.put("txt_bullockfeednon",Helper.formatDoubleValue(feednon));
			hshResult.put("txt_vtaidexpenses",Helper.formatDoubleValue(vtaid));
			hshResult.put("txt_insurancebullocks",Helper.formatDoubleValue(insbullock));
			hshResult.put("txt_insurancecart",Helper.formatDoubleValue(inscart));
			
			hshResult.put("txt_bullockplough",Helper.formatDoubleValue(ploughing));
			
			hshResult.put("txt_specifycost",Helper.formatDoubleValue(txt_expenses));
			
			hshResult.put("txt_maint",Helper.formatDoubleValue(txt_maint));
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
	//caly details
//	public HashMap getcalydata(HashMap hshValues)  
//	{
//		String strQuery = "";
//		ResultSet rs = null;
//		ResultSet rs1 = null;
//		HashMap hshRecord = new HashMap();
//		//ArrayList arryRow = new ArrayList();
//		//ArrayList arryCol = null;
//	  	String appno=correctNull((String)hshValues.get("appno"));
//		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
//		{
//			appno = Helper.correctNull((String)hshValues.get("strappno"));
//		}
//	     String PageType=Helper.correctNull((String)hshValues.get("hidpagetype1"));
//        if(PageType.equalsIgnoreCase(""))
//        {
//        	 PageType=Helper.correctNull((String)hshValues.get("hidpagetype"));
//        }
//        
//		try 
//		{
//			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
//			rs = DBUtils.executeQuery(strQuery);
//			if (rs.next()) 
//			{
//				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
//				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
//				hshRecord.put("applicantid", rs.getString("demo_appid"));
//			}
//			strQuery = SQLParser.getSqlQuery("agr_get_calydata^"+appno);
//			rs1 = DBUtils.executeQuery(strQuery);
//			if (rs1.next()) 
//			{
//				hshRecord.put("txt_name", Helper.correctDoubleQuote(correctNull(rs1.getString("caly_name"))));
//				hshRecord.put("txr_address", Helper.correctDoubleQuote(correctNull(rs1.getString("caly_address"))));
//				hshRecord.put("txt_period", Helper.correctDoubleQuote(correctNull(rs1.getString("caly_period"))));
//				hshRecord.put("txt_validupto", Helper.correctDoubleQuote(correctNull(rs1.getString("caly_validupto"))));
//				hshRecord.put("sel_license", Helper.correctDoubleQuote(correctNull(rs1.getString("caly_license"))));
//				hshRecord.put("txt_specify", Helper.correctDoubleQuote(correctNull(rs1.getString("caly_specify"))));
//				hshRecord.put("txt_licenseno", Helper.correctDoubleQuote(correctNull(rs1.getString("caly_licenseno"))));
//				hshRecord.put("txt_licensedate", Helper.correctDoubleQuote(correctNull(rs1.getString("caly_licensedate"))));
//				hshRecord.put("sel_book", Helper.correctDoubleQuote(correctNull(rs1.getString("caly_book"))));
//				hshRecord.put("txt_reasons", Helper.correctDoubleQuote(correctNull(rs1.getString("caly_reasons"))));
//				hshRecord.put("txt_fromdate", Helper.correctDoubleQuote(correctNull(rs1.getString("caly_fromdate"))));
//				hshRecord.put("txt_todate", Helper.correctDoubleQuote(correctNull(rs1.getString("caly_todate"))));
//				hshRecord.put("txt_amount", Helper.correctDoubleQuote(correctNull(rs1.getString("caly_amount"))));
//				hshRecord.put("txt_marginval", Helper.correctDoubleQuote(correctNull(rs1.getString("caly_marginval"))));
//				hshRecord.put("txt_loanamount", Helper.correctDoubleQuote(correctNull(rs1.getString("caly_loanamount"))));
//				hshRecord.put("txt_caname", Helper.correctDoubleQuote(correctNull(rs1.getString("caly_caname"))));
//				hshRecord.put("txt_amountsec", Helper.correctDoubleQuote(correctNull(rs1.getString("caly_amountsec"))));
//				hshRecord.put("txt_valdate", Helper.correctDoubleQuote(correctNull(rs1.getString("caly_valdate"))));
//				
//			}
//			
//				 
//			hshRecord.put("appno", appno);
//			hshRecord.put("PageType", PageType);
//			
//		} 
//		catch (Exception ce)
//		{
//			throw new EJBException("Error in closing getData" + ce.getMessage());
//		}
//		finally 
//		{
//			try
//			{
//				if (rs != null) 
//				{
//					rs.close();
//					rs = null;
//				}
//				 if (rs1 != null)
//				    {
//					rs1.close();
//				    }
//			}
//			catch (Exception e)
//			{
//				throw new EJBException("Error in closing Connection "+ e.getMessage());
//			}
//		}
//		return hshRecord;
//	}

//	public HashMap updatecalydata(HashMap hshValues)  
//	{
//		String strQuery = "";
//		HashMap hshQueryValues = new HashMap();
//		//HashMap hshQueryValues6 = new HashMap();
//		HashMap hshpasValues = new HashMap();
//		HashMap hshQuery = new HashMap();
//		//HashMap hshQuery5 = new HashMap();
//		ArrayList arrValues = new ArrayList();
//		ResultSet rs = null;
//		String strAction = null;		
//		//String strAction1 = null;	
//		//String strAction2 = null;	
//		HashMap hshResult = new HashMap();
//		HashMap hshQuery4 = new HashMap();
//		//int intUpdatesize = 0;
//		//int f = 0;
//		String appno=correctNull((String)hshValues.get("appno"));
//		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
//		{
//			appno = Helper.correctNull((String)hshValues.get("strappno"));
//		}
//	   strAction = correctNull((String) hshValues.get("hidAction"));
//	   String txt_name= correctNull((String) hshValues.get("txt_name"));
//	   String  txr_address = correctNull((String) hshValues.get("txr_address"));
//	   String  txt_period= correctNull((String) hshValues.get("txt_period"));
//	   String  txt_validupto= correctNull((String) hshValues.get("txt_validupto"));
//	   if(txt_validupto.equalsIgnoreCase(""))
//		{
//		   txt_validupto="01/01/1900";	
//		}
//		else
//		{
//			txt_validupto= correctNull((String) hshValues.get("txt_validupto"));
//		}
//	   String sel_license= correctNull((String) hshValues.get("sel_license"));
//		if(sel_license.equalsIgnoreCase(""))
//		{
//			sel_license="0";	
//		}
//		else
//		{
//			sel_license= correctNull((String) hshValues.get("sel_license"));
//		}
//		
//		String txt_specify = correctNull((String) hshValues.get("txt_specify"));
//		String txt_licenseno= correctNull((String) hshValues.get("txt_licenseno"));
//		String txt_licensedate = correctNull((String) hshValues.get("txt_licensedate"));
//		 if(txt_licensedate.equalsIgnoreCase(""))
//			{
//			 txt_licensedate="01/01/1900";	
//			}
//			else
//			{
//				txt_licensedate= correctNull((String) hshValues.get("txt_licensedate"));
//			}
//		String sel_book= correctNull((String) hshValues.get("sel_book"));
//		if(sel_book.equalsIgnoreCase(""))
//		{
//			sel_book="0";	
//		}
//		else
//		{
//			sel_book= correctNull((String) hshValues.get("sel_book"));
//		}
//		String txt_reasons = correctNull((String) hshValues.get("txt_reasons"));
//		String  txt_fromdate = correctNull((String) hshValues.get("txt_fromdate"));
//		 if(txt_fromdate.equalsIgnoreCase(""))
//			{
//			 txt_fromdate="01/01/1900";	
//			}
//			else
//			{
//				txt_fromdate= correctNull((String) hshValues.get("txt_fromdate"));
//			}
//		String  txt_todate= correctNull((String) hshValues.get("txt_todate"));
//		 if(txt_todate.equalsIgnoreCase(""))
//			{
//			 txt_todate="01/01/1900";	
//			}
//			else
//			{
//				txt_todate= correctNull((String) hshValues.get("txt_todate"));
//			}
//		String  txt_amount= correctNull((String) hshValues.get("txt_amount"));
//		String txt_marginval= correctNull((String) hshValues.get("txt_marginval"));
//		String  txt_loanamount= correctNull((String) hshValues.get("txt_loanamount"));
//		String txt_caname= correctNull((String) hshValues.get("txt_caname"));
//		String  txt_amountsec= correctNull((String) hshValues.get("txt_amountsec"));
//		String txt_valdate= correctNull((String) hshValues.get("txt_valdate"));
//		 if(txt_valdate.equalsIgnoreCase(""))
//			{
//			 txt_valdate="01/01/1900";	
//			}
//			else
//			{
//				txt_valdate= correctNull((String) hshValues.get("txt_valdate"));
//			}
//		try 
//		{
//		 strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
//			rs = DBUtils.executeQuery(strQuery);
//			if (rs.next()) 
//			{
//				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
//				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
//				hshResult.put("applicantid", rs.getString("demo_appid"));
//			}
//			if (strAction.equals("delete"))
//			{
//				hshQuery4 = new HashMap();
//				HashMap hshQueryValues4 = new HashMap();
//				ArrayList arrValues4 = new ArrayList();
//				hshQueryValues4.put("size", "1");
//				hshQuery4.put("strQueryId", "agr_del_calydata");
//				arrValues4.add(appno);
//				hshQuery4.put("arrValues", arrValues4);
//				hshQueryValues4.put("1", hshQuery4);
//				EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
//			}
//			
//			
//			if(strAction.equalsIgnoreCase("insert"))
//			{
//				hshQuery= new HashMap();
//				 arrValues = new ArrayList();
//				hshQuery.put("size", "2");
//				hshQuery.put("strQueryId", "agr_del_calydata");
//				arrValues.add(appno);
//				hshQuery.put("arrValues",arrValues);	
//				hshQueryValues.put("1",hshQuery);
//				hshQuery= new HashMap();
//				arrValues = new ArrayList();
//				arrValues.add(appno);
//				arrValues.add(txt_name);
//				arrValues.add(txr_address);
//				arrValues.add(txt_period);
//				arrValues.add(txt_validupto);
//				arrValues.add(sel_license);
//				arrValues.add(txt_specify);
//				arrValues.add(txt_licenseno);
//				arrValues.add(txt_licensedate);
//				arrValues.add(sel_book);
//				arrValues.add(txt_reasons);
//				arrValues.add(txt_fromdate);
//				arrValues.add(txt_todate);
//				arrValues.add(txt_amount);
//				arrValues.add(txt_marginval);
//				arrValues.add(txt_loanamount);
//				arrValues.add(txt_caname);
//				arrValues.add(txt_amountsec);
//				arrValues.add(txt_valdate);
//				hshQueryValues.put("size", "2");
//				hshQuery.put("arrValues", arrValues);
//				hshQuery.put("strQueryId", "agr_ins_calydata");
//				hshQueryValues.put("2", hshQuery);
//				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//			}
//			
//			hshpasValues.put("appno", appno);
//			hshResult = getcalydata(hshpasValues);
//		}
//		catch (Exception e)
//		{
//			throw new EJBException("Error in Insert Data " + e.getMessage());
//		} 
//		finally 
//		{
//			try 
//			{
//				if (rs != null) 
//				{
//					rs.close();
//					rs = null;
//				}
//			} 
//			catch (Exception e1) 
//			{
//				throw new EJBException("Error in closing Connection "+ e1.getMessage());
//			}
//		}
//		return hshResult;
//	}
	//gobar gas

	public HashMap getgobartechdata(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;
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
        String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}
        
		try 
		{
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}
			strQuery = SQLParser.getSqlQuery("agr_get_gobartechdata^"+appno);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) 
			{
				hshRecord.put("txt_syno", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_syno"))));
				hshRecord.put("txt_acreage", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_acreage"))));
				hshRecord.put("txt_village", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_village"))));
				hshRecord.put("txt_taluk", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_taluk"))));
				hshRecord.put("txt_ownership", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_ownership"))));
				hshRecord.put("txt_distance", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_distance"))));
				hshRecord.put("txt_sizeplant", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_sizeplant"))));
				hshRecord.put("sel_design", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_design"))));
				hshRecord.put("txt_specify", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_specify"))));
				hshRecord.put("txt_investment", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_investment"))));
				String txt_subsidy=Helper.correctDoubleQuote(correctNull(rs1.getString("gg_subsidy")));
				if(txt_subsidy.equalsIgnoreCase(""))
				{
					txt_subsidy="0";	
				}
				hshRecord.put("txt_subsidy",txt_subsidy);
				String txt_subsidyper=Helper.correctDoubleQuote(correctNull(rs1.getString("gg_subsidyper")));
				if(txt_subsidyper.equalsIgnoreCase(""))
				{
					txt_subsidyper="0";	
				}
				hshRecord.put("txt_subsidyper",txt_subsidyper);
				String txt_margin=Helper.correctDoubleQuote(correctNull(rs1.getString("gg_margin")));
				if(txt_margin.equalsIgnoreCase(""))
				{
					txt_margin="0";	
				}
				hshRecord.put("txt_margin",txt_margin);
				String txt_marginper=Helper.correctDoubleQuote(correctNull(rs1.getString("gg_marginper")));
				if(txt_marginper.equalsIgnoreCase(""))
				{
					txt_marginper="0";	
				}
				hshRecord.put("txt_marginper",txt_marginper);
				hshRecord.put("txt_animalsowned", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_animalsowned"))));
				hshRecord.put("txt_animalsstallfed", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_animalsstallfed"))));
				hshRecord.put("txt_animalsgrazing", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_animalsgrazing"))));
				hshRecord.put("txt_animalsnorms", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_animalsnorms"))));
				hshRecord.put("txt_shortfall", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_shortfall"))));
				hshRecord.put("txt_agency", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_agency"))));
				hshRecord.put("txt_agencygas", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_agencygas"))));
				hshRecord.put("txt_agencyapproved", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_agencyapproved"))));
				hshRecord.put("txt_persons", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_persons"))));
				hshRecord.put("txt_purpose1", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_purpose1"))));
				hshRecord.put("txt_hrs1", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_hrs1"))));
				hshRecord.put("txt_purpose2", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_purpose2"))));
				hshRecord.put("txt_hrs2", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_hrs2"))));
				hshRecord.put("txt_purpose3", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_purpose3"))));
				hshRecord.put("txt_hrs3", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_hrs3"))));
				hshRecord.put("txt_savings", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_savings"))));
				hshRecord.put("txt_netannualincome", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_netannualincome"))));
				hshRecord.put("txt_date1", Helper.correctDoubleQuote(correctNull(rs1.getString("gg_date"))));
				
			}
			else
			{
				hshRecord.put("auditFlag", "Y");
			}
			String txt_date="";
//			strQuery = SQLParser.getSqlQuery("agr_sel_cklslimit^" + appno+"^"+prd_type);
//			rs = DBUtils.executeQuery(strQuery);
//			while (rs.next())
//			{
//				arryCol = new ArrayList();
//				arryCol.add(rs.getString("seqno"));
//				arryCol.add(appno);
//				arryCol.add(rs.getString("sno"));
//				arryCol.add(rs.getString("ckls_limit"));
//				arryCol.add(rs.getString("ckls_amount"));
//				txt_date=correctNull((String)rs.getString("ckls_date"));
//				if(txt_date.equalsIgnoreCase("01/01/1900"))
//				{
//					arryCol.add("");
//				}
//				else
//				{
//					arryCol.add(txt_date);
//				}
//				arryCol.add(rs.getString("ckls_balance"));
//				arryCol.add(rs.getString("ckls_comments"));
//				arryRow.add(arryCol);
//			   }
			strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				hshRecord.put("land_measurement",Helper.correctNull(rs1.getString("land_measurement")));
			}
			hshRecord.put("appno", appno);
			hshRecord.put("PageType", PageType);
			hshRecord.put("arryRow", arryRow);
			strQuery = SQLParser.getSqlQuery("agr_sel_bullockrepay^"+appno+ "^" +prd_type);			
			rs1 =DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				hshRecord.put("txt_roi",correctNull(rs1.getString("bullock_roi")));
				hshRecord.put("txt_holiday",correctNull(rs1.getString("bullock_holiday")));
				hshRecord.put("sel_payment",correctNull(rs1.getString("bullock_payment")));
				hshRecord.put("txt_installment",correctNull(rs1.getString("bullock_installment")));
				hshRecord.put("txt_date",correctNull(rs1.getString("bullock_date")));
				hshRecord.put("txt_lastinstallment",correctNull(rs1.getString("bullock_lastinstallment")));
				hshRecord.put("txt_loanamount",correctNull(rs1.getString("loanamount")));
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
				 if (rs1 != null)
				    {
					rs1.close();
				    }
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap updategobartechdata(HashMap hshValues)  
	{
		String strQuery = "";
		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}
		HashMap hshQueryValues = new HashMap();
		//HashMap hshQueryValues6 = new HashMap();
		HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		//HashMap hshQuery5 = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strAction = null;		
		//String strAction1 = null;	
			
		HashMap hshResult = new HashMap();
		HashMap hshQuery4 = new HashMap();
		//int intUpdatesize = 0;
		//int f = 0;
		//String strid = "", strQuery1 = "";
		String appno=correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
	   strAction = correctNull((String) hshValues.get("hidAction"));
	   		    
	   String txt_syno= correctNull((String) hshValues.get("txt_syno"));
	   String  txt_acreage = correctNull((String) hshValues.get("txt_acreage"));
	   String  txt_village= correctNull((String) hshValues.get("txt_village"));
	   String  txt_taluk= correctNull((String) hshValues.get("txt_taluk"));
	   String txt_ownership= correctNull((String) hshValues.get("txt_ownership"));
	   String txt_distance= correctNull((String) hshValues.get("txt_distance"));
		String txt_sizeplant= correctNull((String) hshValues.get("txt_sizeplant"));
		String sel_design = correctNull((String) hshValues.get("sel_design"));
		if(sel_design.equalsIgnoreCase(""))
		{
			sel_design="0";	
		}
		else
		{
			sel_design= correctNull((String) hshValues.get("sel_design"));
		}
	
		String txt_specify= correctNull((String) hshValues.get("txt_specify"));
		String  txt_investment = correctNull((String) hshValues.get("txt_investment"));
		String  txt_subsidy= correctNull((String) hshValues.get("txt_subsidy"));
		if(txt_subsidy.equalsIgnoreCase(""))
		{
			txt_subsidy="0";	
		}
		else
		{
			txt_subsidy= correctNull((String) hshValues.get("txt_subsidy"));
		}
		String  txt_subsidyper= correctNull((String) hshValues.get("txt_subsidyper"));
		String txt_margin= correctNull((String) hshValues.get("txt_margin"));
		if(txt_margin.equalsIgnoreCase(""))
		{
			txt_margin="0";	
		}
		else
		{
			txt_margin= correctNull((String) hshValues.get("txt_margin"));
		}
		String  txt_marginper= correctNull((String) hshValues.get("txt_marginper"));
		String txt_animalsowned= correctNull((String) hshValues.get("txt_animalsowned"));
		String  txt_animalsstallfed= correctNull((String) hshValues.get("txt_animalsstallfed"));
		String txt_animalsgrazing= correctNull((String) hshValues.get("txt_animalsgrazing"));
		String  txt_animalsnorms= correctNull((String) hshValues.get("txt_animalsnorms"));
		String  txt_shortfall= correctNull((String) hshValues.get("txt_shortfall"));
		String  txt_agency= correctNull((String) hshValues.get("txt_agency"));
		String txt_agencygas= correctNull((String) hshValues.get("txt_agencygas"));
		String  txt_agencyapproved= correctNull((String) hshValues.get("txt_agencyapproved"));
		String txt_persons= correctNull((String) hshValues.get("txt_persons"));
		String  txt_purpose1= correctNull((String) hshValues.get("txt_purpose1"));
		String txt_hrs1= correctNull((String) hshValues.get("txt_hrs1"));
		String  txt_purpose2= correctNull((String) hshValues.get("txt_purpose2"));
		String txt_hrs2= correctNull((String) hshValues.get("txt_hrs2"));
		String  txt_purpose3= correctNull((String) hshValues.get("txt_purpose3"));
		String txt_hrs3= correctNull((String) hshValues.get("txt_hrs3"));
		String txt_savings= correctNull((String) hshValues.get("txt_savings"));
		String  txt_netannualincome= correctNull((String) hshValues.get("txt_netannualincome"));
		String  txt_date1= correctNull((String) hshValues.get("txt_date1"));
		if(txt_date1.equalsIgnoreCase(""))
		{
			txt_date1="01/01/1900";	
		}
		else
		{
			txt_date1= correctNull((String) hshValues.get("txt_date1"));
		}
		
		//String[] txt_limit = null;
		//String[]txt_amount = null;
		//String[] txt_date = null;
		//String[] txt_balance = null;
		//String[]txt_comments = null;
		//txt_limit= (String[]) hshValues.get("txt_limit");
		//txt_amount= (String[]) hshValues.get("txt_amount");
		//txt_date = (String[]) hshValues.get("txt_date");
		//strid = correctNull((String) hshValues.get("hid_sno"));
		//txt_balance= (String[]) hshValues.get("txt_balance");
		//txt_comments = (String[]) hshValues.get("txt_comments");
		
		try 
		{
			String design="";
		 strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshResult.put("applicantid", rs.getString("demo_appid"));
			}
			if(correctNull((String) hshValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
			{
				strAction="insert";
			}
			else
			{
				if(!strAction.equalsIgnoreCase("delete"))
				{
				strAction="update";
				}
			}
			StringBuilder sbAuditTrialOld=new StringBuilder();
			if(!strAction.equalsIgnoreCase("insert"))
			{
				
				strQuery = SQLParser.getSqlQuery("agr_get_gobartechdata^"+appno);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) 
				{
					if(Helper.correctDoubleQuote(correctNull(rs.getString("gg_design"))).equalsIgnoreCase("1"))
					{
						design="KVK/KVIB";
					}
					else if(Helper.correctDoubleQuote(correctNull(rs.getString("gg_design"))).equalsIgnoreCase("2"))
					{
						design="Agriculture Dept/University";
					}
					else if(Helper.correctDoubleQuote(correctNull(rs.getString("gg_design"))).equalsIgnoreCase("3"))
					{
						design="Others";
					}
					sbAuditTrialOld
					.append("Location of Gobar Gas Plant ^")
					.append("~Survey No= ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_syno"))))
					.append("~Extend Land = ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_acreage"))))
					.append("~Village = ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_village"))))
					.append("~Taluk = ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_taluk"))))
					.append("~Ownership = ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_ownership"))))
					.append("~Distance from the Branch to Plant = ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_distance"))))
					.append("~Size of the Plant = ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_sizeplant"))))
					.append("~Design of the Plant = ")
					.append(design);
				if(design.equalsIgnoreCase("Others"))
				{
					sbAuditTrialOld
					.append("~Specify = ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_specify"))));
				}
				sbAuditTrialOld
					.append("~Cost of Investment Rs. = ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_investment"))))
					.append("~Margin Money = ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_margin"))))
					.append(" ")
					.append("&")
					.append(" ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_marginper"))))
					.append(" ")
					.append("%")
					.append(" ")
					.append("~No. of Animals Owned (cows/buffaloes/bullocks) = ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_animalsowned"))))
					.append("~of which stallfed= ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_animalsstallfed"))))
					.append("~of which allowed for grazing = ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_animalsgrazing"))))
					.append("~No. of Animals as per Norms = ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_animalsnorms"))))
					.append("~How the shortfall has occured  = ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_shortfall"))))
					.append("~Name of agency  = ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_agency"))))
					.append("~Name of agency Supply gas holder,pipelines = ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_agencygas"))))
					.append("~Agency Supplying Equipment is approved by = ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_agencyapproved"))))
					.append("~No. of persons benefited by the construction of proposed plant = ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_persons"))))
					.append("~Purpose gas is used for = ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_purpose1"))))
					.append("~No. of Hrs. gas is used for = ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_hrs1"))))
					.append("~Purpose gas is used for = ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_purpose2"))))
					.append("~No. of Hrs. gas is used for = ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_hrs2"))))
					.append("~Purpose gas is used for = ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_purpose3"))))
					.append("~No. of Hrs. gas is used for = ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_hrs3"))))
					.append("~Savings on fuel due to implementation of G.G Plant = ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_savings"))))
					.append("~Net Annual Income = ")
					.append(Helper.correctDoubleQuote(correctNull(rs.getString("gg_netannualincome"))));
					
				}
				//AuditTrial.auditLog(hshValues,"275",appno,sbAuditTrialOld.toString());
			}
			if (strAction.equals("delete"))
			{
				hshQuery4 = new HashMap();
				HashMap hshQueryValues4 = new HashMap();
				ArrayList arrValues4 = new ArrayList();
				hshQueryValues4.put("size", "1");
				hshQuery4.put("strQueryId", "agr_del_gobartechdata");
				arrValues4.add(appno);
				hshQuery4.put("arrValues", arrValues4);
				hshQueryValues4.put("1", hshQuery4);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
			}
			
			/*if (strAction.equals("delete"))
			{
				hshQuery5 = new HashMap();
				HashMap hshQueryValues5 = new HashMap();
				ArrayList arrValues5 = new ArrayList();
				hshQueryValues5.put("size", "1");
				hshQuery5.put("strQueryId", "agr_del_cklslimit");
				arrValues5.add(appno);
				arrValues5.add(prd_type);
				hshQuery5.put("arrValues", arrValues5);
				hshQueryValues5.put("1", hshQuery5);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues5,"updateData");
			}*/
			
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update") )
			{
				hshQuery= new HashMap();
				 arrValues = new ArrayList();
				hshQuery.put("size", "2");
				hshQuery.put("strQueryId", "agr_del_gobartechdata");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);	
				hshQueryValues.put("1",hshQuery);
				hshQuery= new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(txt_syno);
				arrValues.add(txt_acreage);
				arrValues.add(txt_village);
				arrValues.add(txt_taluk);
				arrValues.add(txt_ownership);
				arrValues.add(txt_distance);
				arrValues.add(txt_sizeplant);
				arrValues.add(sel_design);
				arrValues.add(txt_specify);
				arrValues.add(txt_investment);
				arrValues.add(txt_subsidy);
				arrValues.add(txt_subsidyper);
				arrValues.add(txt_margin);
				arrValues.add(txt_marginper);
				arrValues.add(txt_animalsowned);
				arrValues.add(txt_animalsstallfed);
				arrValues.add(txt_animalsgrazing);
				arrValues.add(txt_animalsnorms);
				arrValues.add(txt_shortfall);
				arrValues.add(txt_agency);
				arrValues.add(txt_agencygas);
				arrValues.add(txt_agencyapproved);
				arrValues.add(txt_persons);
				arrValues.add(txt_purpose1);
				arrValues.add(txt_hrs1);
				arrValues.add(txt_purpose2);
				arrValues.add(txt_hrs2);
				arrValues.add(txt_purpose3);
				arrValues.add(txt_hrs3);
				arrValues.add(txt_savings);
				arrValues.add(txt_netannualincome);
				arrValues.add(txt_date1);
				
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agr_ins_gobartechdata");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			/*if(strAction.equalsIgnoreCase("insert"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "2");
				hshQuery3.put("strQueryId", "agr_del_cklslimit");
				arrValues3.add(appno);
				arrValues3.add(prd_type);
				hshQuery3.put("arrValues", arrValues3);
				strQuery1 = SQLParser.getSqlQuery("sel_maxid_cklslimit");
				rs = DBUtils.executeQuery(strQuery1);
				if (rs.next())
				{
					strid = correctNull((String) rs.getString("maxid"));
					f = Integer.parseInt(strid);
				}
				intUpdatesize = 1;

				for (int i = 0; i < txt_limit.length; i++)
				{					
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "agr_ins_cklslimit");
					arrValues.add(Integer.toString(f));
					arrValues.add(appno);
					arrValues.add(new Integer(i + 1).toString());
								
					if (correctNull( txt_limit[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_limit[i]));
					}
					if (correctNull(txt_amount[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_amount[i]));
					}
					if (correctNull(txt_date[i]).equals("")) 
					{
						arrValues.add("01/01/1900");
					}
					else 
					{
						arrValues.add(correctNull(txt_date[i]));
					}
					if (correctNull(txt_balance[i]).equals(""))
					{
						arrValues.add("");
					} 
					else
					{
						arrValues.add(correctNull(txt_balance[i]));
					}
					if (correctNull(txt_comments[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_comments[i]));
					}
					arrValues.add(prd_type);
				
					hshQuery.put("arrValues", arrValues);
					f = f + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);					
				}
				hshQueryValues.put("1", hshQuery3);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}*/
			StringBuilder sbAuditTrial=new StringBuilder();
			
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update") )
			{
			
				sbAuditTrial
				.append("Location of Gobar Gas Plant ^")
				.append("~Survey No= ")
				.append(txt_syno)
				.append("~Extend Land = ")
				.append(txt_acreage)
				.append("~Village = ")
				.append(txt_village)
				.append("~Taluk = ")
				.append(txt_taluk)
				.append("~Ownership = ")
				.append(txt_ownership)
				.append("~Distance from the Branch to Plant = ")
				.append(txt_distance)
				.append("~Size of the Plant = ")
				.append(txt_sizeplant)
				.append("~Design of the Plant = ")
				.append(Helper.correctNull((String)hshValues.get("sel_designtext")));
			if(Helper.correctNull((String)hshValues.get("sel_designtext")).equalsIgnoreCase("Others"))
			{
				sbAuditTrial
				.append("~Specify = ")
				.append(txt_specify);
			}
			sbAuditTrial
				.append("~Cost of Investment Rs. = ")
				.append(txt_investment)
				.append("~Margin Money = ")
				.append(txt_margin)
				.append(" ")
				.append("&")
				.append(" ")
				.append(txt_marginper)
				.append(" ")
				.append("%")
				.append(" ")
				.append("~No. of Animals Owned (cows/buffaloes/bullocks) = ")
				.append(txt_animalsowned)
				.append("~of which stallfed= ")
				.append(txt_animalsstallfed)
				.append("~of which allowed for grazing = ")
				.append(txt_animalsgrazing)
				.append("~No. of Animals as per Norms = ")
				.append(txt_animalsnorms)
				.append("~How the shortfall has occured  = ")
				.append(txt_shortfall)
				.append("~Name of agency  = ")
				.append(txt_agency)
				.append("~Name of agency Supply gas holder,pipelines = ")
				.append(txt_agencygas)
				.append("~Agency Supplying Equipment is approved by = ")
				.append(txt_agencyapproved)
				.append("~No. of persons benefited by the construction of proposed plant = ")
				.append(txt_persons)
				.append("~Purpose gas is used for = ")
				.append(txt_purpose1)
				.append("~No. of Hrs. gas is used for = ")
				.append(txt_hrs1)
				.append("~Purpose gas is used for = ")
				.append(txt_purpose2)
				.append("~No. of Hrs. gas is used for = ")
				.append(txt_hrs2)
				.append("~Purpose gas is used for = ")
				.append(txt_purpose3)
				.append("~No. of Hrs. gas is used for = ")
				.append(txt_hrs3)
				.append("~Savings on fuel due to implementation of G.G Plant = ")
				.append(txt_savings)
				.append("~Net Annual Income = ")
				.append(txt_netannualincome);
			if(strAction.equalsIgnoreCase("update"))
			{
				hshValues.put("strAction", "update");
			}
			else
			{
				hshValues.put("strAction", "insert");
			}
				
			}
			AuditTrial.auditNewLog(hshValues, "275", appno, sbAuditTrial.toString(), sbAuditTrialOld.toString());	
			hshpasValues.put("appno", appno);
			hshpasValues.put("prd_type", prd_type);
			hshResult = getgobartechdata(hshpasValues);
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
	//gobar eligibility
	public void updategobarseligibilitydata(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery =  new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=correctNull((String)hshValues.get("hidAction"));
		
		String strAction2=correctNull((String)hshValues.get("hidAction2"));
		String appno=correctNull((String)hshValues.get("strappno"));
		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}
		
		if(appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("appno"));
		}
		ResultSet rs = null;
		try
		{			
			
			if(strAction2.equalsIgnoreCase("delete2"))
			{
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_del_bullockrepay");
				arrValues.add(appno);
				arrValues.add(prd_type);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");  
			}	
			 // ArrayList arrValues1 = new ArrayList();
             if(strAction.equalsIgnoreCase("insert"))
				
			   {
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
	
	public void updateBullockParticulars(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String appno="";
		int intindex=1;
		int intLoop=1;
		String [] strUnit; 
		String [] strBreed;
		String []strAmount;
		String [] strNo;
		String [] strAge;
		String [] strYear;
		String [] strRate;
		String  strReason;
		String  strInfrastructure;
		ResultSet rs = null;
		String strschemetype="",strfacsno="",stragrschemetype="";
		HashMap hshScheme = new HashMap();
		try
		{	
			strschemetype	= Helper.correctNull((String )hshValues.get("schemetype"));
			hshScheme = Helper.splitScheme(strschemetype);
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			
			appno =	Helper.correctNull((String)hshValues.get("strappno"));
			
			if(appno.equalsIgnoreCase("") || appno.equalsIgnoreCase("null"))
			{
				appno =	Helper.correctNull((String)hshValues.get("appno"));
			}
			
			strUnit				= 	(String [])hshValues.get("txt_bull_unit");	
			strAge				= 	(String [])hshValues.get("txt_bull_age");	
			strYear				= 	(String [])hshValues.get("txt_bull_year");
			strReason			=   (String)hshValues.get("txtarea_reason");
			strInfrastructure	=   (String)hshValues.get("txtarea_infra");
			strBreed			= 	(String [])hshValues.get("txt_bull_breed");	
			strNo				= 	(String [])hshValues.get("txt_bull_no");
			strRate				=  	(String [])hshValues.get("txt_bull_rate");
			strAmount			=   (String [])hshValues.get("txt_bull_amt");
		
			if(hshValues.get("hidAction").toString().equals("insert"))
			{		
					hshQuery.put("strQueryId","del_bullockparticulars");			
					arrValues.add(appno);
					arrValues.add(stragrschemetype);
					arrValues.add(strfacsno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
				
				        while(intLoop<=2)
				        {
				        	arrValues = null;
							hshQuery = null;
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","ins_bullockparticulars");
					        arrValues.add(appno);
					        arrValues.add(stragrschemetype);
							arrValues.add(strfacsno);
					        arrValues.add(Helper.correctDouble(strUnit[intLoop-1]));
				        	arrValues.add(Helper.correctDouble(strAge[intLoop-1]));
				        	arrValues.add(Helper.correctDouble(strYear[intLoop-1]));
				        	arrValues.add("");
				        	arrValues.add("own");
				        	
				        	hshQuery.put("arrValues",arrValues);
					        hshQueryValues.put(Integer.toString(intLoop+1),hshQuery);
					        intLoop++; 
					        
				        }
				        
			        	if(strReason != null && !strReason.equals(""))
			        	{
			        		arrValues = null;
							hshQuery = null;
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","ins_bullockparticulars");
							arrValues.add(appno);
							arrValues.add(stragrschemetype);
							arrValues.add(strfacsno);
					       	arrValues.add("0");
				        	arrValues.add("0");
				        	arrValues.add("0");
				        	arrValues.add(Helper.correctNull(strReason));
				        	arrValues.add("reason");
				        	hshQuery.put("arrValues",arrValues);
					        hshQueryValues.put(Integer.toString(intLoop+1),hshQuery);
					        intLoop++; 
			        	}
				       
				        
			        	if(strInfrastructure != null && !strInfrastructure.equals(""))
			        	{
			        		arrValues = null;
							hshQuery = null;
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","ins_bullockparticulars");
							arrValues.add(appno);
							arrValues.add(stragrschemetype);
							arrValues.add(strfacsno);
					        arrValues.add("0");
				        	arrValues.add("0");
				        	arrValues.add("0");
				        	arrValues.add(Helper.correctNull(strInfrastructure));
				        	arrValues.add("infra");
				        	hshQuery.put("arrValues",arrValues);
					        hshQueryValues.put(Integer.toString(intLoop+1),hshQuery);
					        intLoop++; 
			        	}
			        	
				        	
				        	while(intindex<=strBreed.length)
					        {
					        	if(strBreed[intindex-1] != null && !strBreed[intindex-1].equals(""))
					        	{
					        		arrValues = null;
									hshQuery = null;
									hshQuery=new HashMap();
									arrValues=new ArrayList();
									hshQuery.put("strQueryId","ins_bullockparticulars");
									arrValues.add(appno);
									arrValues.add(stragrschemetype);
									arrValues.add(strfacsno);
							       	arrValues.add(Helper.correctDouble(strNo[intindex-1]));
						        	arrValues.add(Helper.correctDouble(strRate[intindex-1]));
						        	arrValues.add(Helper.correctDouble(strAmount[intindex-1]));
						        	arrValues.add(Helper.correctNull(strBreed[intindex-1]));
						        	arrValues.add("esti");
						        	hshQuery.put("arrValues",arrValues);
							        hshQueryValues.put(Integer.toString(intLoop+1),hshQuery);
							        intLoop++;
					        	}
					        	intindex++;
					        	
					        }
			        	
			    	hshQueryValues.put("size",Integer.toString(intLoop));
			}
			
			else if(hshValues.get("hidAction").toString().equals("delete"))
			{
				    hshQuery.put("strQueryId","del_bullockparticulars");			
				    arrValues.add(appno);
				    arrValues.add(stragrschemetype);
					arrValues.add(strfacsno);
				    hshQuery.put("arrValues",arrValues);
				    hshQueryValues.put("1",hshQuery);
				    hshQueryValues.put("size","1");
				    
			}	
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateBullockParticulars"+ce.toString());
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
	
	public HashMap getBullockParticulars(HashMap hshValues)  
	{
		String strQuery="";
		ResultSet rs = null; 
		HashMap hshRecord = new HashMap();
		ArrayList arrData = new ArrayList();
		ArrayList arrVal;
		String strappno="";
		String strType="";
		String strschemetype="",strfacsno="",stragrschemetype="";
		HashMap hshScheme = new HashMap();
		try 
		{
			strschemetype	= Helper.correctNull((String )hshValues.get("schemetype"));
			hshScheme = Helper.splitScheme(strschemetype);
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			
			strappno=Helper.correctNull((String)hshValues.get("strappno"));
			if(strappno.equalsIgnoreCase("") || strappno.equalsIgnoreCase("null"))
			{
				strappno=Helper.correctNull((String)hshValues.get("appno"));
			}
			
			strQuery = SQLParser.getSqlQuery("sel_agr_bullockparticulars^"+strappno+"^"+stragrschemetype+"^"+strfacsno+"^"+"own");	
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
				{
					arrVal = new ArrayList();
					arrVal.add(Helper.correctNull(rs.getString("abp_unit")));
					arrVal.add(Helper.correctNull(rs.getString("abp_number1")));
					arrVal.add(Helper.correctNull(rs.getString("abp_number2")));
					arrData.add(arrVal);
				}
			hshRecord.put("arrData",arrData);
			strQuery = SQLParser.getSqlQuery("sel_agr_bullockparticularscomment^"+strappno+"^"+stragrschemetype+"^"+strfacsno+"^"+"reason"+"^"+"infra");	
			
			if(rs!=null)
				rs.close();	
				rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strType=Helper.correctNull(rs.getString("abp_type"));
				if(strType.equals("reason"))
				{
					hshRecord.put("Reason",(Helper.correctNull(rs.getString("abp_details"))));
				}
				else if(strType.equals("infra"))
				{
					hshRecord.put("Infrastructure",(Helper.correctNull(rs.getString("abp_details"))));
				}	
			
			}	
			if(rs!=null){
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("sel_agr_bullockparticulars^"+strappno+"^"+stragrschemetype+"^"+strfacsno+"^"+"esti");	
			arrData = new ArrayList();
			
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
					arrVal = new ArrayList();
					arrVal.add(Helper.correctNull(rs.getString("abp_unit")));
					arrVal.add(Helper.correctNull(rs.getString("abp_number1")));
					arrVal.add(Helper.correctNull(rs.getString("abp_number2")));
					arrVal.add(Helper.correctNull(rs.getString("abp_details")));
					arrData.add(arrVal);
			}
			if(rs!=null){
				rs.close();
			}
			hshRecord.put("arrPart",arrData);
			
				strQuery = SQLParser.getSqlQuery("sel_agr_bullockparticulars_total^"+strappno+"^"+stragrschemetype+"^"+strfacsno+"^"+"esti");
				rs=DBUtils.executeQuery(strQuery);
				if (rs.next()) 
				{
					hshRecord.put("total_estimate_unit",Helper.correctNull((String)rs.getString("total_unit")));
					hshRecord.put("total_estimate_cost",Helper.correctNull((String)rs.getString("total_cost")));
					hshRecord.put("total_estimate_rate",Helper.correctNull((String)rs.getString("total_rate")));
			
				}
				if(rs!=null){
					rs.close();
				}
			    hshRecord.put("appno",strappno);
			    
		} 
		catch (Exception e) 
		{		
			throw new EJBException("Error in getBullockParticulars - AgriMechanisedBoatBean"+e.toString());
			
		}
		finally
		{
			try 
			{	
				if(rs!=null){
					rs.close();
				}
			}
			catch (Exception e) 
			{		
				throw new EJBException("Error in getBullockParticulars - AgriMechanisedBoatBean "+e.toString());
			}
		}
		return hshRecord;
		
	}
	/**AUTHOR 	: ARSATH AYUB.M
	*  DATE		: 05/03/2014 
	* PURPOSE	: To get income & expense details for Net Income page
	*/
	public HashMap getNetincome(HashMap hshValues)  
	{
		String strQuery="";
		ResultSet rs = null,rs1=null; 
		HashMap hshRecord = new HashMap();
		String strappno="";
		String strschemetype="",strfacsno="",stragrschemetype="";
		HashMap hshScheme = new HashMap();
		java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		double dblincyear1 = 0.00,dblincyear2=0.00,dblincyear3=0.00,dblincyear4=0.00;
		double dblexpyear1 = 0.00,dblexpyear2=0.00,dblexpyear3=0.00,dblexpyear4=0.00;
		double dblnetyear1 = 0.00,dblnetyear2=0.00,dblnetyear3=0.00,dblnetyear4=0.00;
		try 
		{
			strschemetype	= Helper.correctNull((String )hshValues.get("schemetype"));
			hshScheme = Helper.splitScheme(strschemetype);
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			if(stragrschemetype.equalsIgnoreCase("") || strfacsno.equalsIgnoreCase(""))
			{
				strfacsno = Helper.correctNull((String)hshValues.get("strFacSno"));
				stragrschemetype = Helper.correctNull((String)hshValues.get("strSchemeType"));
			}
			
			strappno=Helper.correctNull((String)hshValues.get("strappno"));
			if(strappno.equalsIgnoreCase("") || strappno.equalsIgnoreCase("null"))
			{
				strappno=Helper.correctNull((String)hshValues.get("appno"));
			}
			/*Below query used to get the total income details*/
			if(rs!=null)
			{
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("sel_totgrossinc^"+strappno+"^"+stragrschemetype+"^"+strfacsno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("income_year1", Helper.checkDecimal(Helper.correctDouble((String)rs.getString("income_year1"))));
				hshRecord.put("income_year2", Helper.checkDecimal(Helper.correctDouble((String)rs.getString("income_year2"))));
				hshRecord.put("income_year3", Helper.checkDecimal(Helper.correctDouble((String)rs.getString("income_year3"))));
				hshRecord.put("income_year4", Helper.checkDecimal(Helper.correctDouble((String)rs.getString("income_year4"))));
				dblincyear1 = Double.parseDouble(Helper.correctDouble((String)rs.getString("income_year1")));
				dblincyear2 = Double.parseDouble(Helper.correctDouble((String)rs.getString("income_year2")));
				dblincyear3 = Double.parseDouble(Helper.correctDouble((String)rs.getString("income_year3")));
				dblincyear4 = Double.parseDouble(Helper.correctDouble((String)rs.getString("income_year4")));
			}
			
			/*Below query used to get the total expense details*/
			if(rs1!=null)
			{
				rs1.close();
			}
			
			strQuery = SQLParser.getSqlQuery("sel_totexpenses^"+strappno+"^"+stragrschemetype+"^"+strfacsno);
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				hshRecord.put("expyear1", Helper.checkDecimal(Helper.correctDouble((String)rs1.getString("year1"))));
				hshRecord.put("expyear2", Helper.checkDecimal(Helper.correctDouble((String)rs1.getString("year2"))));
				hshRecord.put("expyear3", Helper.checkDecimal(Helper.correctDouble((String)rs1.getString("year3"))));
				hshRecord.put("expyear4", Helper.checkDecimal(Helper.correctDouble((String)rs1.getString("year4"))));
				dblexpyear1 = Double.parseDouble(Helper.correctDouble((String)rs1.getString("year1")));
				dblexpyear2 = Double.parseDouble(Helper.correctDouble((String)rs1.getString("year2")));
				dblexpyear3 = Double.parseDouble(Helper.correctDouble((String)rs1.getString("year3")));
				dblexpyear4 = Double.parseDouble(Helper.correctDouble((String)rs1.getString("year4")));
			}
			/* Calculation for Net Income (1 to 4years)*/
			dblnetyear1 = ((dblincyear1)-(dblexpyear1));
			dblnetyear2 = ((dblincyear2)-(dblexpyear2));
			dblnetyear3 = ((dblincyear3)-(dblexpyear3));
			dblnetyear4 = ((dblincyear4)-(dblexpyear4));
			hshRecord.put("netyear1",Helper.formatDoubleValue(dblnetyear1));
			hshRecord.put("netyear2",Helper.formatDoubleValue(dblnetyear2));
			hshRecord.put("netyear3",Helper.formatDoubleValue(dblnetyear3));
			hshRecord.put("netyear4",Helper.formatDoubleValue(dblnetyear4));
				
			    
		} 
		catch (Exception e) 
		{		
			throw new EJBException("Error in getNetIncomedetails - AgriMechanisedBoatBean"+e.toString());
			
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
			catch (Exception e) 
			{		
				throw new EJBException("Error in getNetIncomedetails - AgriMechanisedBoatBean "+e.toString());
			}
		}
		return hshRecord;
		
	}
	
	
	public HashMap getcaplGoodsdata(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		ArrayList arrVal = new ArrayList();
		ArrayList arrRow = new ArrayList();
		double dbltotmarketval=0.00,dbltotwarehouseval=0.00,dbltotalLoanAmt=0.00,dbltotalMargin=0.00;
		String appno=correctNull((String)hshValues.get("appno"));
		
		String schemetype="";
		schemetype = Helper.correctNull((String) hshValues.get("schemetype"));
		String strschemetype="",strfacsno="",stragrschemetype="",strMeasure="";
		HashMap hshScheme = new HashMap();
		hshScheme = Helper.splitScheme(schemetype);
		if(hshScheme!=null)
		{
			strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
			if(strfacsno.equalsIgnoreCase(""))
				strfacsno = Helper.correctNull((String)hshValues.get("facsno"));
			stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			if(stragrschemetype.equalsIgnoreCase(""))
				stragrschemetype = Helper.correctNull((String)hshValues.get("schemetype"));
		}
		
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
		java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		java.text.NumberFormat nf1 = java.text.NumberFormat.getNumberInstance();
		nf1.setGroupingUsed(false);
		nf1.setMaximumFractionDigits(2);
		nf1.setMinimumFractionDigits(2);
        
		try 
		{	
			strQuery = SQLParser.getSqlQuery("sel_goodsdetails^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrVal = new ArrayList();
				arrVal.add(correctNull(rs.getString("capl_goods_sno")));
				arrVal.add(correctNull(rs.getString("capl_goods_name")));
				arrVal.add(correctNull(rs.getString("capl_goods_document")));
				arrVal.add(correctNull(rs.getString("capl_goods_units")));
				arrVal.add(correctNull(rs.getString("capl_goods_weight")));
				arrVal.add(correctNull(rs.getString("capl_goods_measurement")));
				arrVal.add(correctNull(rs.getString("capl_goods_marketprice")));//6
				arrVal.add(correctNull(rs.getString("capl_goods_totalmarketvalue")));//7
				arrVal.add(correctNull(rs.getString("capl_goods_valueperwarehouse")));//8
				arrVal.add(correctNull(rs.getString("capl_goods_dateofreceipt")));
				
				strMeasure = correctNull(rs.getString("capl_goods_measurement"));
				
				strQuery = SQLParser.getSqlQuery("sel_staticdata_goodsdesc^"+"136^"+strMeasure);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					arrVal.add(correctNull(rs1.getString("stat_data_desc1")));
				}else{
					arrVal.add(" ");
				}
				arrVal.add(correctNull(rs.getString("capl_bankloan")));//9
				String strGoodsMargin = nf1.format(Double.parseDouble(Helper.correctDouble(rs.getString("capl_goods_margin"))));
				arrVal.add(strGoodsMargin);//10
				arrRow.add(arrVal);
				
				dbltotmarketval=dbltotmarketval+Double.parseDouble((String)Helper.correctDouble((String)rs.getString("capl_goods_totalmarketvalue")));
				dbltotwarehouseval=dbltotwarehouseval+Double.parseDouble((String)Helper.correctDouble((String)rs.getString("capl_goods_valueperwarehouse")));
				dbltotalLoanAmt=dbltotalLoanAmt+Double.parseDouble((String)Helper.correctDouble((String)rs.getString("capl_bankloan")));
				dbltotalMargin=dbltotalMargin+Double.parseDouble(strGoodsMargin);
				if(rs1!=null){ rs1.close(); }
			}
			
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("totmarketval",nf.format(dbltotmarketval));
			hshRecord.put("totwarehouseval",nf.format(dbltotwarehouseval));
			hshRecord.put("dbltotalLoanAmt",nf.format(dbltotalLoanAmt));			
			hshRecord.put("dbltotalMargin",nf1.format(dbltotalMargin));			
		} 
		catch (Exception ce)
		{
			throw new EJBException("Error in closing getcaplGoodsdata" + ce.getMessage());
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
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}
	
	
	public void updatecaplGoodsdata(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs=null;
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		String strAction = null;		
		String strid = "", strQuery1 = "";
		ArrayList arrValues = new ArrayList();
		int maxsno=0;
		
		String appno=correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
		
		strAction = correctNull((String) hshValues.get("hidAction"));
		String strScheme= correctNull((String) hshValues.get("hidscheme"));
		String strSno= correctNull((String) hshValues.get("hidsno"));		
		
		try 
		{
			java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
			nf.setGroupingUsed(false);
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			String strNamewarehouse = correctNull((String)hshValues.get("txt_namewarehouse"));
			String strWarehousedoc = correctNull((String)hshValues.get("txt_warehousedoc"));
			String strUnits = correctNull((String)hshValues.get("txt_units"));
			String strWeight = correctNull((String) hshValues.get("txt_weight"));
			String strMarketrate = correctNull((String)hshValues.get("txt_marketrate"));
			String strMarketval  = correctNull((String)hshValues.get("txt_marketval"));
			String strInvoiceval = correctNull((String)hshValues.get("txt_invoiceval"));
			String strInvoicedate  = correctNull((String)hshValues.get("txt_invoicedate"));
			String strLoanamt = correctNull((String)hshValues.get("txt_loanamt"));
			String strselUnits=correctNull((String) hshValues.get("sel_units"));
			String strLoanAmount=correctNull((String) hshValues.get("txt_loanAmount"));			
			String strMargin= nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_margin"))));
			if (strAction.equals("delete"))
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_goodsdetails");
				arrValues.add(appno);
				arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			rs = DBUtils.executeLAPSQuery("sel_maxsno_goodsdetails^"+appno);
			if(rs.next()){
				maxsno = rs.getInt("capl_goods_sno");
			}
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQuery= new HashMap();
				arrValues = new ArrayList();
				
				arrValues.add(appno);
				arrValues.add(""+maxsno);
				arrValues.add(strNamewarehouse);
				arrValues.add(strWarehousedoc);
				arrValues.add(strUnits);
				arrValues.add(strWeight);
				arrValues.add(strselUnits);
				arrValues.add(strMarketrate);
				arrValues.add(strMarketval);
				arrValues.add(strInvoiceval);
				arrValues.add(strInvoicedate);
				arrValues.add(strLoanAmount);				
				arrValues.add(strMargin);				
				hshQueryValues.put("size", "1");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "ins_goodsdetails");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
			if(strAction.equalsIgnoreCase("update"))
			{
				hshQuery= new HashMap();
				arrValues = new ArrayList();
				
				arrValues.add(strNamewarehouse);
				arrValues.add(strWarehousedoc);
				arrValues.add(strUnits);
				arrValues.add(strWeight);
				arrValues.add(strselUnits);
				arrValues.add(strMarketrate);
				arrValues.add(strMarketval);
				arrValues.add(strInvoiceval);
				arrValues.add(strInvoicedate);
				arrValues.add(strLoanAmount);
				arrValues.add(strMargin);
				arrValues.add(appno);
				arrValues.add(strSno);
				
				hshQueryValues.put("size", "1");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "upd_goodsdetails");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
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
				if(rs!=null){ rs.close(); }
			} 
			catch (Exception e1) 
			{
				throw new EJBException("Error in closing Connection "+ e1.getMessage());
			}
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
