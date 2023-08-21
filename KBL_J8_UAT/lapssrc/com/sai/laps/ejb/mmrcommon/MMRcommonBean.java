package com.sai.laps.ejb.mmrcommon;

import java.rmi.RemoteException;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;

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
import com.sai.laps.helper.SetupParams;

@Stateless(name = "MMRcommonBean", mappedName = "MMRcommonHome")
@Remote (MMRcommonRemote.class)
public class MMRcommonBean extends BeanAdapter
{	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1313820960349153234L;
	static Logger log=Logger.getLogger(MMRcommonBean.class);
	
	public void updateBookdebitsvalue(HashMap hshValues)
	{
		ResultSet rs = null;
		
		String strQuery=null;
		
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery = new HashMap();
		
		ArrayList arrValues = new ArrayList();
		
		try
		{
			String strAction = correctNull((String)hshValues.get("hidAction"));
			String strcbsid=correctNull((String)hshValues.get("hidcbsid"));
			String straccountno = correctNull((String)hshValues.get("mon_accno"));
			String Strmmrno=correctNull((String)hshValues.get("mmrno"));
			String strpropertyname = correctNull((String)hshValues.get("txt_propertyname"));
			String strinvicedate = correctNull((String)hshValues.get("txt_invicedate"));
			String strupto90= correctNull((String)hshValues.get("txt_upto90"));	
			String strupto180 = correctNull((String)hshValues.get("txt_upto180"));
			String strabove180 = correctNull((String)hshValues.get("txt_above180"));
			String strtotaldaysamount = correctNull((String)hshValues.get("txt_totaldaysamount"));
			String strmonth = correctNull((String)hshValues.get("mon_month"));
			String stryear = correctNull((String)hshValues.get("mon_year"));
			String strSno = correctNull((String)hshValues.get("hidsno"));
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				strQuery=SQLParser.getSqlQuery("selmaxbookdebits^"+Strmmrno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strSno=correctNull(rs.getString("snorelmax"));
				}
				
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				
				hshQuery.put("strQueryId","insbookdebits");
				
				arrValues.add(strSno);
				arrValues.add(strcbsid);
				arrValues.add(straccountno);
				arrValues.add(strpropertyname);
				arrValues.add(strinvicedate);
				arrValues.add(strupto90);
				arrValues.add(strupto180);
				arrValues.add(strabove180);
				arrValues.add(strtotaldaysamount);
				arrValues.add(strmonth);
				arrValues.add(stryear);
				arrValues.add(Strmmrno); 
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}	
			else if(strAction.equalsIgnoreCase("update"))
			{
				 hshQueryValues = new HashMap();
				 hshQuery=new HashMap();
				 
				 hshQuery.put("strQueryId","updbookdebits"); 
				 
				   	arrValues.add(strpropertyname);
					arrValues.add(strinvicedate);
					arrValues.add(strupto90);
					arrValues.add(strupto180);
					arrValues.add(strabove180);
					arrValues.add(strtotaldaysamount);
					arrValues.add(strSno);
					arrValues.add(Strmmrno);
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
				
				
				hshQuery.put("strQueryId","delbookdebits"); 
				arrValues.add(strSno);
				arrValues.add(Strmmrno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updateBookdebitsvalue "+e.getMessage());
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
				throw new EJBException("Error closing in updateBookdebitsvalue connection "+cf.getMessage());						
			}
		}
	}

	public HashMap getBookdebitsvalue(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		String strQuery="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		ResultSet rs = null;
		
		//String strcbsid =correctNull((String)hshValues.get("cbsid"));
		//String stryear=correctNull((String)hshValues.get("mon_year"));
		//String strmonth=correctNull((String)hshValues.get("mon_month"));
		String straccno=correctNull((String)hshValues.get("mon_accno"));
		String Strmmrno=correctNull((String)hshValues.get("mmrno"));
		
		String mon_msod=correctNull((String)hshValues.get("mon_msod"));
		String mon_stock=correctNull((String)hshValues.get("mon_stock"));
		String mon_bkdebts=correctNull((String)hshValues.get("mon_bkdebts"));
		String mon_qpr=correctNull((String)hshValues.get("mon_qpr"));
		try
		{
			strQuery=SQLParser.getSqlQuery("selbookdebits^"+straccno+"^"+Strmmrno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("mmr_sno")));
				arrCol.add(correctNull(rs.getString("mmr_cbsid")));
				arrCol.add(correctNull(rs.getString("mmr_cbsaccountno")));
				arrCol.add(correctNull(rs.getString("mmr_propertyname")));
				arrCol.add(correctNull(rs.getString("mmr_invoicedate")));
				arrCol.add(correctNull(rs.getString("mmr_uptoninetyamount")));
				arrCol.add(correctNull(rs.getString("mmr_uptooneeightyamount")));
				arrCol.add(correctNull(rs.getString("mmr_abvoneeightyamount")));
				arrCol.add(correctNull(rs.getString("mmr_totalamount")));
				arrCol.add(correctNull(rs.getString("mmr_month")));
				arrCol.add(correctNull(rs.getString("mmr_year")));
				
				
				arrRow.add(arrCol);
			}			
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("mon_msod",mon_msod);
			hshRecord.put("mon_stock",mon_stock);
			hshRecord.put("mon_bkdebts",mon_bkdebts);
			hshRecord.put("mon_qpr",mon_qpr);
		}
		catch(Exception e1)
		{
			throw new EJBException("Error in getBookdebitsvalue :: "+e1.getMessage());
		}
		finally
		{
			try
			{
				if(rs!=null)
				{
					rs.close();
				}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		return hshRecord;
	}

	public void updateStockeligible(HashMap hshValues) 
	{

		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		
		ArrayList arrValues= new ArrayList();
		
			
		ResultSet rs=null;
		
				
		String strAction =correctNull((String)hshValues.get("hidAction"));
		
		String strcbsaccountno =correctNull((String)hshValues.get("mon_accno"));
		String strcbsid = correctNull((String) hshValues.get("hidcbsid"));
		String strmonth = correctNull((String)hshValues.get("mon_month"));
		String stryear = correctNull((String)hshValues.get("mon_year"));
		String Strmmrno=correctNull((String)hshValues.get("mmrno"));
		
		
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","delstockeligble");
				arrValues.add(strcbsaccountno);
				arrValues.add(Strmmrno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				
				hshQuery.put("strQueryId","insstockeligible");
				arrValues.add(strcbsid);
				arrValues.add(strcbsaccountno);
				arrValues.add(correctNull((String)hshValues.get("txt_stocklc")));
				arrValues.add(correctNull((String)hshValues.get("txt_stockcreditor")));
				arrValues.add(correctNull((String)hshValues.get("txt_totalunpaidstock")));
				arrValues.add(correctNull((String)hshValues.get("txt_stocknotdp")));
				arrValues.add(correctNull((String)hshValues.get("txt_otherasset")));
				arrValues.add(correctNull((String)hshValues.get("txt_packingcredit")));
				arrValues.add(correctNull((String)hshValues.get("txt_stockearmarked")));
				arrValues.add(correctNull((String)hshValues.get("txt_totalstock")));
				arrValues.add(correctNull((String)hshValues.get("txt_stockeligible")));
			
				arrValues.add(correctNull((String)hshValues.get("txt_days")));
				arrValues.add(correctNull((String)hshValues.get("sel_packingcredit")));
				
				arrValues.add(strmonth);
				arrValues.add(stryear);
				arrValues.add(Strmmrno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strcbsaccountno);
				arrValues.add(Strmmrno);
				hshQuery.put("strQueryId","delstockeligble");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data in updateStockeligible :: " + e.getMessage());
		} finally
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
				throw new EJBException("Error closing in updateStockeligible :: "+cf.getMessage());						
			}
		}
	}
	
	
	
	public 	HashMap getstockeligible(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		
		String strQuery ="";
		String mon_msod=correctNull((String)hshValues.get("mon_msod"));
		String mon_stock=correctNull((String)hshValues.get("mon_stock"));
		String mon_bkdebts=correctNull((String)hshValues.get("mon_bkdebts"));
		String mon_qpr=correctNull((String)hshValues.get("mon_qpr"));
		
		String Strmmrno=correctNull((String)hshValues.get("mmrno"));
		
		try
		{
			String straccno=correctNull((String)hshValues.get("mon_accno"));
	 		//String stryear=correctNull((String)hshValues.get("mon_year"));
			//String strmonth=correctNull((String)hshValues.get("mon_month"));
			//String strcbsid =correctNull((String)hshValues.get("cbsid"));
			
			strQuery = SQLParser.getSqlQuery("selstockeligible^"+straccno+"^"+Strmmrno);
			rs = DBUtils.executeQuery(strQuery);	
			if (rs.next())
			{ 
				hshResult.put("mmr_cbsid",correctNull(rs.getString("mmr_cbsid")));
				hshResult.put("mmr_cbsaccountno",correctNull(rs.getString("mmr_cbsaccountno")));
				hshResult.put("mmr_stocklc",correctNull(rs.getString("mmr_stocklc")));
				hshResult.put("mmr_stockcreditor",correctNull(rs.getString("mmr_stockcreditor")));
				hshResult.put("mmr_totalunpaidstock",correctNull(rs.getString("mmr_totalunpaidstock")));
				hshResult.put("mmr_stocknotdp",correctNull(rs.getString("mmr_stocknotdp")));
				hshResult.put("mmr_otherasset",correctNull(rs.getString("mmr_otherasset")));
				hshResult.put("mmr_packingcredit",correctNull(rs.getString("mmr_packingcredit")));
				hshResult.put("mmr_stockearmarked",correctNull(rs.getString("mmr_stockearmarked")));
				hshResult.put("mmr_totalstock",correctNull(rs.getString("mmr_totalstock")));
				hshResult.put("mmr_stockeligible",correctNull(rs.getString("mmr_stockeligible")));
				hshResult.put("stock_selpackingcredit",correctNull(rs.getString("stock_selpackingcredit")));
				hshResult.put("mmrdays",correctNull(rs.getString("mmrdays")));
				hshResult.put("mmr_month",correctNull(rs.getString("mmr_month")));
				hshResult.put("mmr_year",correctNull(rs.getString("mmr_year")));
				
				
			}
			hshResult.put("mon_msod",mon_msod);
 			hshResult.put("mon_stock",mon_stock);
 			hshResult.put("mon_bkdebts",mon_bkdebts);	
 			hshResult.put("mon_qpr",mon_qpr);
			if(rs!=null)
			{
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("selstocktotal^"+straccno+"^"+Strmmrno);
			rs = DBUtils.executeQuery(strQuery);
			double stockvalue=0.00;
			
			
			String strtotalvalue="";
			while (rs.next())
			{ 
				stockvalue+=Double.parseDouble(Helper.correctDouble(rs.getString("stock_value")));
			}
			
			strtotalvalue=Helper.formatDoubleValue(stockvalue);
			hshResult.put("totalvalue",strtotalvalue);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getstockeligible :: "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection in getstockeligible :: "+cf.getMessage());
			}
		}
		return hshResult;
			
	}
	
	public void updateConsortium(HashMap hshValues)
	{
		ResultSet rs = null;
		
		String strQuery=null;
		
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery = new HashMap();
		
		ArrayList arrValues = new ArrayList();
		
		
		try
		{
			String strAction = correctNull((String)hshValues.get("hidAction"));
			String strmmrno=correctNull((String)hshValues.get("mmrno"));
			
			String strcbsid=correctNull((String)hshValues.get("cbsid"));
			String straccountno =correctNull((String)hshValues.get("cbsid"));
			
			String strbankname = correctNull((String)hshValues.get("txt_bankname"));
			String strbranch = correctNull((String)hshValues.get("txt_branch"));
			String strsharepercent = correctNull((String)hshValues.get("txt_sharepercent"));
			String txt_nonfundsharepercent = correctNull((String)hshValues.get("txt_nonfundsharepercent"));
			String txt_fundsharepercent = correctNull((String)hshValues.get("txt_fundsharepercent"));
			
			String strassetclasification = correctNull((String)hshValues.get("txt_assetclasification"));
			String strfundbasedname = correctNull((String)hshValues.get("txt_fundbasedname"));
			
			//Amount are stored in Rupees
			String strfundbasedamount = String.valueOf(( Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_fundbasedamount"))) * 10000000 ));
			//End
			
			String strnonfundbasedname = correctNull((String)hshValues.get("txt_nonfundbasedname"));
			
			//Amount are stored in Rupees
			String strnonfundbasedamount = String.valueOf(( Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_nonfundbasedamount"))) * 10000000 ));
			//End
			
			//Amount are stored in Rupees
			String stroverdue = String.valueOf((Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_overdue"))) * 10000000 ));
			//End
			
			String strremarks = correctNull((String)hshValues.get("txt_remarks"));
			String strleadbank = correctNull((String)hshValues.get("txt_leadbank"));
			String strmonth = correctNull((String)hshValues.get("mon_month"));
			String stryear = correctNull((String)hshValues.get("mon_year"));
		
		
			
			String strSno = correctNull((String)hshValues.get("hidsno"));
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				//strQuery="selmaxconsortium";
				rs=DBUtils.executeLAPSQuery("selmaxconsortium^"+strcbsid); //------------- strcbsid - added in the query by kamal (Remaining code is not changed)
				if(rs.next())
				{
					strSno=correctNull(rs.getString("snorelmax"));
				}
				
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				
				hshQuery.put("strQueryId","insconsortium");
				
				arrValues.add(strSno);
				arrValues.add(strcbsid);
				arrValues.add(straccountno);
				arrValues.add(strbankname);
				arrValues.add(strbranch);
				arrValues.add(strsharepercent);
				arrValues.add(strassetclasification);
				arrValues.add(strfundbasedname);
				arrValues.add(strfundbasedamount);
				arrValues.add(strnonfundbasedname);
				arrValues.add(strnonfundbasedamount);
				arrValues.add(stroverdue);
				arrValues.add(strremarks);
				arrValues.add(strleadbank);
				arrValues.add(strmonth);
				arrValues.add(stryear);
				arrValues.add(txt_nonfundsharepercent);
				arrValues.add(txt_fundsharepercent);
				arrValues.add(strmmrno);
				 
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}	
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
			 
				hshQuery.put("strQueryId","updconsortium"); 

				arrValues.add(strbankname);
				arrValues.add(strbranch);
				arrValues.add(strsharepercent);
				arrValues.add(strassetclasification);
				arrValues.add(strfundbasedname);
				arrValues.add(strfundbasedamount);
				arrValues.add(strnonfundbasedname);
				arrValues.add(strnonfundbasedamount);
				arrValues.add(stroverdue);
				arrValues.add(strremarks);
				arrValues.add(strleadbank);
				arrValues.add(txt_nonfundsharepercent);
				arrValues.add(txt_fundsharepercent);
				arrValues.add(strSno);
			    arrValues.add(strmmrno);
			    
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
				
				
				hshQuery.put("strQueryId","delconsortium"); 
				arrValues.add(strSno);
				arrValues.add(strmmrno);
				
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updateDocumentRegister "+e.getMessage());
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
				throw new EJBException("Error closing in updateDocumentRegister the connection "+cf.getMessage());						
			}
		}
	}

	public HashMap getConsortium(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		String strQuery="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		ResultSet rs = null;
		DecimalFormat dc=new DecimalFormat();
		dc.setGroupingUsed(false);
		dc.setMaximumFractionDigits(7);
		dc.setMinimumFractionDigits(2);
		try
		{
			//String strcbsid =correctNull((String) hshValues.get("cbsid"));
			//String stryear=correctNull((String)hshValues.get("mon_year"));
			//String strmonth=correctNull((String)hshValues.get("mon_month"));
			String strmmrno=correctNull((String)hshValues.get("mmrno"));
			
			strQuery=SQLParser.getSqlQuery("selconsortium^"+strmmrno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("mmr_sno")));
				arrCol.add(correctNull(rs.getString("mmr_bankname")));
				arrCol.add(correctNull(rs.getString("mmr_branch")));
				arrCol.add(correctNull(rs.getString("mmr_sharepercent")));
				arrCol.add(correctNull(rs.getString("mmr_assetclasification")));
				arrCol.add(correctNull(rs.getString("mmr_fundbasedname")));
				arrCol.add(dc.format(Double.parseDouble(Helper.correctDouble(rs.getString("mmr_fundbasedamount"))) / 10000000));
				arrCol.add(correctNull(rs.getString("mmr_nonfundbasedname")));
				arrCol.add(dc.format(Double.parseDouble(Helper.correctDouble(rs.getString("mmr_nonfundbasedamount"))) / 10000000));
				arrCol.add(dc.format(Double.parseDouble(Helper.correctDouble(rs.getString("mmr_overdue"))) / 10000000));
				arrCol.add(correctNull(rs.getString("mmr_remarks")));
				arrCol.add(correctNull(rs.getString("mmr_leadbank")));
				arrCol.add(correctNull(rs.getString("stat_data_desc1")));
				arrCol.add(correctNull(rs.getString("mmr_nonfundsharepercent")));
				arrCol.add(correctNull(rs.getString("mmr_fundsharepercent")));
				arrRow.add(arrCol);
			}			
			hshRecord.put("arrRow",arrRow);
		}
		catch(Exception e1)
		{
			throw new EJBException("Error in getConsortium :: "+e1.getMessage());
		}
		finally
		{
			try
			{
				if(rs!=null)
				{
					rs.close();
				}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		return hshRecord;
	}

	
	
	public void updateInspectionReport(HashMap hshValues) 
	{

		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		
		ArrayList arrValues= new ArrayList();
	
			
		ResultSet rs=null;
	
	
		
		String strAction =correctNull((String)hshValues.get("hidAction"));
		String strAccid =correctNull((String)hshValues.get("cbsid"));
		String stryear=correctNull((String)hshValues.get("mon_year"));
		String strmonth=correctNull((String)hshValues.get("mon_month"));
		
		
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();					
			hshQueryValues.put("size","2");
			hshQuery.put("strQueryId","delinspectionreport");
			arrValues.add(strAccid);
			arrValues.add(strmonth);
			arrValues.add(stryear);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			
			hshQuery.put("strQueryId","insinspectionreport");
			arrValues.add(strAccid);
	
			arrValues.add(correctNull((String)hshValues.get("txt_visitdate")));
			arrValues.add(correctNull((String)hshValues.get("txt_name1")));
			arrValues.add(correctNull((String)hshValues.get("txt_name2")));
			arrValues.add(correctNull((String)hshValues.get("txt_name3")));
			arrValues.add(correctNull((String)hshValues.get("txt_designation1")));
			arrValues.add(correctNull((String)hshValues.get("txt_designation2")));
			arrValues.add(correctNull((String)hshValues.get("txt_designation3")));
			
			arrValues.add(correctNull((String)hshValues.get("txt_north")));
			arrValues.add(correctNull((String)hshValues.get("txt_east")));
			arrValues.add(correctNull((String)hshValues.get("txt_west")));
			arrValues.add(correctNull((String)hshValues.get("txt_south")));
			arrValues.add(correctNull((String)hshValues.get("txt_primarysecurity")));
			arrValues.add(correctNull((String)hshValues.get("txt_collsecurity")));
			arrValues.add(correctNull((String)hshValues.get("txt_presentstatus")));
			arrValues.add(correctNull((String)hshValues.get("txt_comments")));
			arrValues.add(correctNull((String)hshValues.get("txt_document")));
			arrValues.add(correctNull((String)hshValues.get("txt_features")));
			
			arrValues.add(correctNull((String)hshValues.get("sel_banknameboard")));
			arrValues.add(correctNull((String)hshValues.get("sel_borrowernamebord")));
			arrValues.add(correctNull((String)hshValues.get("sel_maintanance")));
			
			arrValues.add(strmonth);
			arrValues.add(stryear);
			arrValues.add(correctNull((String)hshValues.get("txt_security")));
			arrValues.add(correctNull((String)hshValues.get("mmr_shorfalldeficiency")));
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("2",hshQuery);	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strAccid);
				arrValues.add(strmonth);
				arrValues.add(stryear);
				
				hshQuery.put("strQueryId","delinspectionreport");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} finally
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
				throw new EJBException("Error closing in updateInspectionReport"+cf.getMessage());						
			}
		}
	}
	
	
	
	public 	HashMap getInspectionReport(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		
		String strQuery ="";
		
		
		String strcbsid =correctNull((String)hshValues.get("cbsid"));
		
		
		
		String stryear=correctNull((String)hshValues.get("mon_year"));
		String strmonth=correctNull((String)hshValues.get("mon_month"));
	
		try
		{
				strQuery = SQLParser.getSqlQuery("selinspectionreport^"+strcbsid+"^"+strmonth+"^"+stryear);
		        rs = DBUtils.executeQuery(strQuery);	
		        
			if (rs.next())
			{ 
				hshResult.put("mmr_cbsid",correctNull(rs.getString("mmr_cbsid")));
				
				hshResult.put("mmr_insvisitdate",correctNull(rs.getString("mmr_insvisitdate")));
				hshResult.put("mmr_insname1",correctNull(rs.getString("mmr_insname1")));
				hshResult.put("mmr_insname2",correctNull(rs.getString("mmr_insname2")));
				hshResult.put("mmr_insname3",correctNull(rs.getString("mmr_insname3")));
				hshResult.put("mmr_insdesign1",correctNull(rs.getString("mmr_insdesign1")));
				hshResult.put("mmr_insdesign2",correctNull(rs.getString("mmr_insdesign2")));
				hshResult.put("mmr_insdesign3",correctNull(rs.getString("mmr_insdesign3")));
				
				hshResult.put("mmr_insnorth",correctNull(rs.getString("mmr_insnorth")));
				hshResult.put("mmr_inseast",correctNull(rs.getString("mmr_inseast")));
				hshResult.put("mmr_inswest",correctNull(rs.getString("mmr_inswest")));
				hshResult.put("mmr_inssouth",correctNull(rs.getString("mmr_inssouth")));
				hshResult.put("mmr_insprimarysecurity",correctNull(rs.getString("mmr_insprimarysecurity")));
				hshResult.put("mmr_inscollsecurity",correctNull(rs.getString("mmr_inscollsecurity")));
				hshResult.put("mmr_inspresentstatus",correctNull(rs.getString("mmr_inspresentstatus")));
				hshResult.put("mmr_inscomments",correctNull(rs.getString("mmr_inscomments")));
				hshResult.put("mmr_insdocument",correctNull(rs.getString("mmr_insdocument")));
				hshResult.put("mmr_insfeatures",correctNull(rs.getString("mmr_insfeatures")));
				hshResult.put("mmr_insbanknameboard",correctNull(rs.getString("mmr_insbanknameboard")));
				hshResult.put("mmr_insborrowernamebord",correctNull(rs.getString("mmr_insborrowernamebord")));
				hshResult.put("mmr_insmaintanance",correctNull(rs.getString("mmr_insmaintanance")));
				
				hshResult.put("mmr_month",correctNull(rs.getString("mmr_month")));
				hshResult.put("mmr_year",correctNull(rs.getString("mmr_year")));
				hshResult.put("mmr_security",correctNull(rs.getString("mmr_security")));
				
				hshResult.put("mmr_shorfalldeficiency",correctNull(rs.getString("mmr_shorfalldeficiency")));
				
				
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getBookdebitseligible-- "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshResult;
			
	}
		
	public void updateBookdebitseligible(HashMap hshValues) 
	{

		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		
		ArrayList arrValues= new ArrayList();
					
		ResultSet rs=null;
		
		String strAction =correctNull((String)hshValues.get("hidAction"));
		
		
		
		String strcbsid=correctNull((String)hshValues.get("cbsid"));
		String strcbsaccountno = correctNull((String)hshValues.get("mon_accno"));
		String strmonth = correctNull((String) hshValues.get("mon_month"));
		String stryear = correctNull((String) hshValues.get("mon_year"));
		String Strmmrno=correctNull((String)hshValues.get("mmrno"));
		
		
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();					
			hshQueryValues.put("size","2");
			hshQuery.put("strQueryId","delbookdebitseligble");
			arrValues.add(strcbsaccountno);
			arrValues.add(Strmmrno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			
			hshQuery.put("strQueryId","insbookdebitseligible");
			arrValues.add(strcbsid);
			arrValues.add(strcbsaccountno);
			arrValues.add(correctNull((String)hshValues.get("txt_bkdbtolderamount")));
			arrValues.add(correctNull((String)hshValues.get("txt_bkdbdiscountamount")));
			arrValues.add(correctNull((String)hshValues.get("txt_bkdbfactoramount")));
			arrValues.add(correctNull((String)hshValues.get("txt_bkdbdoubtfulamount")));
			arrValues.add(correctNull((String)hshValues.get("txt_bkdbassociateamount")));
			arrValues.add(correctNull((String)hshValues.get("txt_bkdbfinanceamount")));
			arrValues.add(correctNull((String)hshValues.get("txt_bkdbtotaleligibleamount")));
			
			arrValues.add(strmonth);
			arrValues.add(stryear);
			arrValues.add(Strmmrno);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("2",hshQuery);	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strcbsaccountno);
				arrValues.add(Strmmrno);
				hshQuery.put("strQueryId","delbookdebitseligble");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} finally
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
				throw new EJBException("Error closing in updateBookdebitseligible"+cf.getMessage());						
			}
		}
		
	}
	
	
	
		
	public 	HashMap getBookdebitseligible(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery ="";
		//String strcbsid =correctNull((String)hshValues.get("cbsid"));
		//String stryear=correctNull((String)hshValues.get("mon_year"));
		//String strmonth=correctNull((String)hshValues.get("mon_month"));
		String straccno=correctNull((String)hshValues.get("mon_accno"));
		String Strmmrno=correctNull((String)hshValues.get("mmrno"));
		
		String mon_msod=correctNull((String)hshValues.get("mon_msod"));
		String mon_stock=correctNull((String)hshValues.get("mon_stock"));
		String mon_bkdebts=correctNull((String)hshValues.get("mon_bkdebts"));
		String mon_qpr=correctNull((String)hshValues.get("mon_qpr"));
		
		
	
		try
		{
			strQuery = SQLParser.getSqlQuery("selbookdebitseligible^"+straccno+"^"+Strmmrno);
			rs = DBUtils.executeQuery(strQuery);	
			if (rs.next())
			{ 
				hshResult.put("mmr_cbsid",correctNull(rs.getString("mmr_cbsid")));
				hshResult.put("mmr_cbsaccountno",correctNull(rs.getString("mmr_cbsaccountno")));
				hshResult.put("mmr_bkdbtolderamount",correctNull(rs.getString("mmr_bkdbtolderamount")));
				hshResult.put("mmr_bkdbdiscountamount",correctNull(rs.getString("mmr_bkdbdiscountamount")));
				hshResult.put("mmr_bkdbfactoramount",correctNull(rs.getString("mmr_bkdbfactoramount")));
				hshResult.put("mmr_bkdbdoubtfulamount",correctNull(rs.getString("mmr_bkdbdoubtfulamount")));
				hshResult.put("mmr_bkdbassociateamount",correctNull(rs.getString("mmr_bkdbassociateamount")));
				hshResult.put("mmr_bkdbfinanceamount",correctNull(rs.getString("mmr_bkdbfinanceamount")));
				hshResult.put("mmr_bkdbtotaleligibleamount",correctNull(rs.getString("mmr_bkdbtotaleligibleamount")));
				hshResult.put("mmr_month",correctNull(rs.getString("mmr_month")));
				hshResult.put("mmr_year",correctNull(rs.getString("mmr_year")));
			}
			
			
			
			strQuery = SQLParser.getSqlQuery("sel_bookoldernintyvalue^"+straccno+"^"+Strmmrno);
			rs = DBUtils.executeQuery(strQuery);	
			if (rs.next())
			{ 
				hshResult.put("oldernintyvalue",correctNull(rs.getString("oldernintyvalue")));
				hshResult.put("grant_total",correctNull(rs.getString("grant_total")));
			}
			
			
			
			
			
			if(rs!=null)
			{
				rs.close();
			}
				hshResult.put("mon_msod",mon_msod);
	 			hshResult.put("mon_stock",mon_stock);
	 			hshResult.put("mon_bkdebts",mon_bkdebts);
	 			hshResult.put("mon_qpr",mon_qpr);
	 			
	 			
	 			
	 			
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getBookdebitseligible-- "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshResult;
			
	}


	public HashMap getmsodestimate(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		//String strcbsid =correctNull((String)hshValues.get("cbsid"));
		//String stryear=correctNull((String)hshValues.get("mon_year"));
		//String strmonth=correctNull((String)hshValues.get("mon_month"));
		String straccno=correctNull((String)hshValues.get("mon_accno"));
		String Strmmrno=correctNull((String)hshValues.get("mmrno"));
		boolean recordflag=false;
		try
		{	
				strQuery = SQLParser.getSqlQuery("sel_msodestimate^"+straccno+"^"+Strmmrno);
				rs = DBUtils.executeQuery(strQuery);	
				while (rs.next())
				{ 
					recordflag=true;
					hshResult.put("mon_msodaccountingyear",correctNull(rs.getString("mon_msodaccountingyear")));
					hshResult.put("mon_msodproduction",correctNull(rs.getString("mon_msodproduction")));
					hshResult.put("mon_msodgrosssales",correctNull(rs.getString("mon_msodgrosssales")));
					hshResult.put("mon_msodnetsales",correctNull(rs.getString("mon_msodnetsales")));
					hshResult.put("mon_msodprodqty",correctNull(rs.getString("mon_msodprodqty")));
					hshResult.put("mon_msodprodcurrent",correctNull(rs.getString("mon_msodprodcurrent")));
					hshResult.put("mon_msodsalesmonth",correctNull(rs.getString("mon_msodsalesmonth")));
					hshResult.put("mon_msodsalescurrent",correctNull(rs.getString("mon_msodsalescurrent")));
					hshResult.put("mon_msodtradingstock",correctNull(rs.getString("mon_msodtradingstock")));
					hshResult.put("mon_msodtradingpurchase",correctNull(rs.getString("mon_msodtradingpurchase")));
					hshResult.put("mon_msodtradingsale",correctNull(rs.getString("mon_msodtradingsale")));
					hshResult.put("mon_msodtradingendstock",correctNull(rs.getString("mon_msodtradingendstock")));
					
				}
			
				strQuery = SQLParser.getSqlQuery("sel_monchecklist^"+straccno);
				rs = DBUtils.executeQuery(strQuery);	
				if (rs.next())
				{ 
					hshResult.put("mon_checkmsod",correctNull(rs.getString("mon_checkmsod")));
					hshResult.put("mon_checkstock",correctNull(rs.getString("mon_checkstock")));
					hshResult.put("mon_checkbkdebts",correctNull(rs.getString("mon_checkbkdebts")));
					hshResult.put("mon_checkqpr",correctNull(rs.getString("mon_checkqpr")));
					
				}
				
				if(rs!=null)
				{
					rs.close();
				}
				
				if(recordflag)
					hshResult.put("recordflag","Y");
				else
					hshResult.put("recordflag","N");
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getmsodestimate ::  "+ce.toString());
		}
		finally
		{
			try
			{	
				if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection in getmsodestimate :: "+cf.getMessage());
			}
		}
		return hshResult;
	}
	
	public void updatemsodestimate(HashMap hshValues)
	{
		HashMap hshQuery=null;
		HashMap hshQueryValues=null;
		ArrayList arrValues=new ArrayList();
		ResultSet rs=null;
		String strAction =correctNull((String)hshValues.get("hidAction"));
		String strAccid =correctNull((String)hshValues.get("cbsid"));
		String stryear=correctNull((String)hshValues.get("mon_year"));
		String strmonth=correctNull((String)hshValues.get("mon_month"));
		String straccno=correctNull((String)hshValues.get("mon_accno"));
		String Strmmrno=correctNull((String)hshValues.get("mmrno"));
		String strRecordFlag = Helper.correctNull((String)hshValues.get("hidAuditFlag"));
		try
		{
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","del_msodestimate");
				arrValues.add(straccno);
				arrValues.add(Strmmrno);
				//arrValues.add(stryear);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				
				hshQuery.put("strQueryId","ins_msodestimate");
				arrValues.add(strAccid);
				arrValues.add(straccno);
				arrValues.add(strmonth);
				arrValues.add(stryear);
				arrValues.add(correctNull((String)hshValues.get("txt_accountingyear")));
				arrValues.add(correctNull((String)hshValues.get("txt_production")));
				arrValues.add(correctNull((String)hshValues.get("txt_grosssales")));
				arrValues.add(correctNull((String)hshValues.get("txt_netsales")));
				arrValues.add(correctNull((String)hshValues.get("txt_prodqty")));
				arrValues.add(correctNull((String)hshValues.get("txt_prodcurrent")));
				arrValues.add(correctNull((String)hshValues.get("txt_salesmonth")));
				arrValues.add(correctNull((String)hshValues.get("txt_salescurrent")));
				arrValues.add(correctNull((String)hshValues.get("txt_tradingstock")));
				arrValues.add(correctNull((String)hshValues.get("txt_tradingpurchase")));
				arrValues.add(correctNull((String)hshValues.get("txt_tradingsale")));
				arrValues.add(correctNull((String)hshValues.get("txt_tradingendstock")));
				arrValues.add(Strmmrno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
			}
			
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","del_msodestimate");
				arrValues.add(straccno);
				arrValues.add(Strmmrno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			// Audit Trial
			StringBuilder sbAt = new StringBuilder();
			if(!strAction.equals("delete"))
			{
				sbAt.append("A) ESTIMATES for the CURRENT ACCOUNTING YEAR  </b>");
				sbAt.append("~ Commencing from as indicated in the Annual Balance plan/Quartely information system  =").append(correctNull((String)hshValues.get("txt_accountingyear")));
				sbAt.append("~ a) Production (Qty in MT /Units)  =").append(correctNull((String)hshValues.get("txt_production")));
				sbAt.append("~ b) Gross Sales (In lac Rs. )  =").append(correctNull((String)hshValues.get("txt_grosssales")));
				sbAt.append("~ c) Net Sales ( In lac Rs. ) =").append(correctNull((String)hshValues.get("txt_netsales")));
				sbAt.append("~ B) PRODUCTION  </b>");
				sbAt.append("~ a) During the Month (Qty in MT /Units)  =").append(correctNull((String)hshValues.get("txt_prodqty")));
				sbAt.append("~ b) During the current accounting year upto the end of the month(Cummulative-in Qty)  =").append(correctNull((String)hshValues.get("txt_prodcurrent")));
				sbAt.append("~ C) NET SALES (Excl. Excise duty):  </b>");
				sbAt.append("~ a) During the Month  =").append(correctNull((String)hshValues.get("txt_salesmonth")));
				sbAt.append("~ b) During the current accounting year upto the end of the month (cummulative- In lac Rs. )  =").append(correctNull((String)hshValues.get("txt_salescurrent")));
				sbAt.append("~ D) IN CASE OF TRADING ACTIVITIES  </b>");
				sbAt.append("~ a) Operating stock at the begining of the month  =").append(correctNull((String)hshValues.get("txt_tradingstock")));
				sbAt.append("~ b) Purchase during the month  =").append(correctNull((String)hshValues.get("txt_tradingpurchase")));
				sbAt.append("~ c) Sale during the month  =").append(correctNull((String)hshValues.get("txt_tradingsale")));
				sbAt.append("~ Closing Stock at the end of the month. =").append(correctNull((String)hshValues.get("txt_tradingendstock")));
				
				if(strRecordFlag.equalsIgnoreCase("Y")){
					hshValues.put("hidAction", "update");
				}else if(strRecordFlag.equalsIgnoreCase("N")){
					hshValues.put("hidAction", "insert");
				}
			}
			AuditTrial.auditLog(hshValues,"419",Strmmrno,sbAt.toString());
		}
		catch(Exception e1)
		{
			e1.printStackTrace();
		}finally
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
				throw new EJBException("Error closing in updatemsodestimate"+cf.getMessage());						
			}
		}
	}

	
	
	public void updatehedgeddetails (HashMap hshValues)
	{
		HashMap hshQuery=null;
		HashMap hshQueryValues=null;
		ArrayList arrValues=new ArrayList();
		String strQuery="";
		ResultSet rs=null;
		String strsno =  correctNull((String)hshValues.get("strsno"));
		String Strmmrno=correctNull((String)hshValues.get("mmrno"));
		String strAction =correctNull((String)hshValues.get("hidAction"));
		String strAccid =correctNull((String)hshValues.get("cbsid"));
		String stryear=correctNull((String)hshValues.get("mon_year"));
		String strmonth=correctNull((String)hshValues.get("mon_month"));
		try
		{
			
			if(strAction.equalsIgnoreCase("new"))
			{
				
				strsno="";
				
				strQuery=SQLParser.getSqlQuery("selmaxhedgedapplication^"+Strmmrno);
				rs=DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
					strsno=correctNull(rs.getString("slno"));
				}
				if(strsno.equalsIgnoreCase(""))
				{
					strsno="0";
				}
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues=new HashMap();
				hshQuery.put("strQueryId","ins_monhedgeddetails");
				arrValues.add(strsno);
				arrValues.add(strAccid);
				arrValues.add(correctNull((String)hshValues.get("txt_accno")));
				arrValues.add(strmonth);
				arrValues.add(stryear);
				arrValues.add(correctNull((String)hshValues.get("txt_salesquarter")));
				arrValues.add(correctNull((String)hshValues.get("txt_salesamount")));
				arrValues.add(correctNull((String)hshValues.get("txt_nature")));
				arrValues.add(correctNull((String)hshValues.get("txt_amount")));
				arrValues.add(correctNull((String)hshValues.get("txt_whetherhedged")));
				arrValues.add(correctNull((String)hshValues.get("txt_excessmonth")));
				arrValues.add(correctNull((String)hshValues.get("txt_excesscurrent")));
				arrValues.add(Strmmrno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
			}
			
			if(strAction.equalsIgnoreCase("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","del_monhedgeddetails");
				arrValues.add(strsno);
				arrValues.add(Strmmrno);
				//arrValues.add(strAccid);
				//arrValues.add(strmonth);
				//arrValues.add(stryear);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				
				hshQuery.put("strQueryId","ins_monhedgeddetails");
				arrValues.add(strsno);
				arrValues.add(strAccid);
				arrValues.add(correctNull((String)hshValues.get("txt_accno")));
				arrValues.add(strmonth);
				arrValues.add(stryear);
				arrValues.add(correctNull((String)hshValues.get("txt_salesquarter")));
				arrValues.add(correctNull((String)hshValues.get("txt_salesamount")));
				arrValues.add(correctNull((String)hshValues.get("txt_nature")));
				arrValues.add(correctNull((String)hshValues.get("txt_amount")));
				arrValues.add(correctNull((String)hshValues.get("txt_whetherhedged")));
				arrValues.add(correctNull((String)hshValues.get("txt_excessmonth")));
				arrValues.add(correctNull((String)hshValues.get("txt_excesscurrent")));
				arrValues.add(Strmmrno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
			}
			
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","del_monhedgeddetails");
				arrValues.add(strsno);
				arrValues.add(Strmmrno);
				//arrValues.add(strAccid);
				//arrValues.add(strmonth);
				//arrValues.add(stryear);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			// Audit Trial
			StringBuilder sbAt = new StringBuilder();
			if(!strAction.equals("delete"))
			{
				sbAt.append("Nature =").append(correctNull((String)hshValues.get("txt_nature")));
				sbAt.append("~ Amount =").append(correctNull((String)hshValues.get("txt_amount")));
			}
			if(strAction.equalsIgnoreCase("new"))
			{
				hshValues.put("hidAction", "insert");
			}
			AuditTrial.auditLog(hshValues,"417",correctNull((String)hshValues.get("mmrno")),sbAt.toString());
		}
		catch(Exception e1)
		{
			e1.printStackTrace();
		}finally
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
				throw new EJBException("Error closing in updatehedgeddetails"+cf.getMessage());						
			}
		}
	}

	public HashMap gethedgeddetails(HashMap hshValues) 
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		//String strcbsid =correctNull((String)hshValues.get("cbsid"));
		String Strmmrno=correctNull((String)hshValues.get("mmrno"));
		ArrayList 	vecCol= new ArrayList();
		ArrayList vecRow = new ArrayList();
		//String stryear=correctNull((String)hshValues.get("mon_year"));
		//String strmonth=correctNull((String)hshValues.get("mon_month"));
	
		try
		{
				strQuery = SQLParser.getSqlQuery("sel_monhedgeddetails^"+Strmmrno);
				rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString("slno")));//0
				vecCol.add(correctNull(rs.getString("mon_hedgeddetailscbsid")));//1
				vecCol.add(correctNull(rs.getString("mon_hedgeddetailscbsaccountno")));//2
				vecCol.add(correctNull(rs.getString("mon_hedgeddetailsmonth")));//3
				vecCol.add(correctNull(rs.getString("mon_hedgeddetailsyear")));//4
				vecCol.add(correctNull(rs.getString("mon_hedgeddetailssalesquarter")));//5
				vecCol.add(correctNull(rs.getString("mon_hedgeddetailssalesamount")));//6
				vecCol.add(correctNull(rs.getString("mon_hedgeddetailsnature")));//7
				vecCol.add(correctNull(rs.getString("mon_hedgeddetailsamount")));//8
				vecCol.add(correctNull(rs.getString("mon_hedgeddetailswhetherhedged")));//9
				vecCol.add(correctNull(rs.getString("mon_hedgeddetailsexcessmonth")));//10
				vecCol.add(correctNull(rs.getString("mon_hedgeddetailsexcesscurrent")));//11
				
				vecRow.add(vecCol);
			}			
			hshResult.put("vecRow",vecRow);
		}
		catch(Exception e1)
		{
			throw new EJBException("Error in getHedgedDetails :: "+e1.getMessage());
		}
		finally
		{
			try
			{
				if(rs!=null)
				{
					rs.close();
				}
			}
		
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		return hshResult;
	}
	
	
	public HashMap updateAccountwise(HashMap hshValues) 
	{

		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		
		ArrayList arrValues= new ArrayList();
		HashMap hshResult=new HashMap();
			
		ResultSet rs=null;
		String strQuery ="";
		
		
		String strAction 			=	correctNull((String)hshValues.get("hidAction"));
		String straccno 			=	correctNull((String) hshValues.get("sel_accno"));
		String  bookdebtsdate		=	correctNull((String) hshValues.get("txt_bookdebtsdate"));
		String  stockdate			=	correctNull((String) hshValues.get("txt_stockdate"));
		String  year				=	correctNull((String) hshValues.get("mon_year"));
		String  month				=	correctNull((String) hshValues.get("mon_month"));
		String 	strsno				=	null;
		String 	strcbsid			=	correctNull((String) hshValues.get("cbsid"));
		String	bookdebtsdue		=	correctNull((String) hshValues.get("txt_nextbookdebtsdue"));
		String 	stockdatedue		=	correctNull((String) hshValues.get("txt_nextstockdue"));
		String 	qpr_receiptdate		=	correctNull((String) hshValues.get("txt_qprdate"));
		String 	qpr_receiptdue		=	correctNull((String) hshValues.get("txt_nextqprdue"));
		String Strmmrno=correctNull((String)hshValues.get("mmrno"));
		String strRecordFlag = Helper.correctNull((String)hshValues.get("hidAuditFlag"));
		try
		{
			strQuery = SQLParser.getSqlQuery("sel_max_accwisesno^"+Strmmrno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strsno	=	correctNull(rs.getString("accwisesno"));
			}
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","del_acountwisedetails");
				arrValues.add(straccno);
				arrValues.add(Strmmrno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				
				hshQuery.put("strQueryId","ins_acountwisedetails");
				arrValues.add(strsno);
				arrValues.add(straccno);
				arrValues.add(bookdebtsdate);
				arrValues.add(stockdate);
				arrValues.add(year);
				arrValues.add(month);
				arrValues.add(strcbsid);
				arrValues.add(bookdebtsdue);
				arrValues.add(stockdatedue);
				arrValues.add(qpr_receiptdate);
				arrValues.add(qpr_receiptdue);
				arrValues.add(Strmmrno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			hshValues.put("mon_accno",straccno);
			
			// Audit Trial
			StringBuilder sbAt = new StringBuilder();
			sbAt.append("Select Account Number =").append(correctNull((String)hshValues.get("sel_accno")));
			sbAt.append("~ QPR Receipt date =").append(correctNull((String)hshValues.get("txt_qprdate")));
			sbAt.append("~ Next QPR due date =").append(correctNull((String)hshValues.get("txt_nextqprdue")));
			
			if(strRecordFlag.equalsIgnoreCase("Y")){
				hshValues.put("hidAction", "update");
			}else if(strRecordFlag.equalsIgnoreCase("N")){
				hshValues.put("hidAction", "insert");
			}
			AuditTrial.auditLog(hshValues,"418",Strmmrno,sbAt.toString());
			
			// End
			
			hshResult=(HashMap)getAccountwise(hshValues);
			hshResult.put("flagapply","1");
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		}finally
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
				throw new EJBException("Error closing in updateAccountwise"+cf.getMessage());						
			}
		} 
		return hshResult;
	}

	public 	HashMap getAccountwise(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		
		String strQuery ="";
		String accno="";
		//String 	month			=	null;
		//String	year			=	null;
		String mon_accno		= 	null;
		String Strmmrno=null;
		boolean recordflag=false;
		try
		{
			mon_accno=correctNull((String) hshValues.get("mon_accno"));
			//year				=	correctNull((String) hshValues.get("mon_year"));
			//month				=	correctNull((String) hshValues.get("mon_month"));
			Strmmrno=correctNull((String)hshValues.get("mmrno"));
			
			strQuery = SQLParser.getSqlQuery("sel_acountwisedetails^"+mon_accno+"^"+Strmmrno);
			rs = DBUtils.executeQuery(strQuery);	
			if (rs.next())
			{ 
				recordflag=true;
				accno=correctNull(rs.getString("mon_accwiseaccountno"));
				hshResult.put("mon_accwiseaccountno",accno);
				hshResult.put("bookdebtsdate",correctNull(rs.getString("bookdebtsdate")));
				hshResult.put("stockdate",correctNull(rs.getString("stockdate")));
				hshResult.put("nextbookdebtsdue",correctNull(rs.getString("bookdebtsdue")));
				hshResult.put("nextstockdue",correctNull(rs.getString("stockdue")));
				hshResult.put("qprdate",correctNull(rs.getString("qprdate")));
				hshResult.put("nextqprdue",correctNull(rs.getString("nextqprdue")));
			}
			hshResult.put("mon_accno",mon_accno);
			hshResult.put("flagapply","0");
			if(rs!=null)
			{
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("sel_monchecklist^"+mon_accno);
			rs = DBUtils.executeQuery(strQuery);	
			if (rs.next())
			{ 
				hshResult.put("mon_checkmsod",correctNull(rs.getString("mon_checkmsod")));
				hshResult.put("mon_checkstock",correctNull(rs.getString("mon_checkstock")));
				hshResult.put("mon_checkbkdebts",correctNull(rs.getString("mon_checkbkdebts")));
				hshResult.put("mon_checkqpr",correctNull(rs.getString("mon_checkqpr")));
				
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			if(recordflag)
				hshResult.put("recordflag","Y");
			else
				hshResult.put("recordflag","N");
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getAccountwisedetails-- "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshResult;
			
	}
	

	
	public 	HashMap getMonitoringInfo(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery ="";
		//String strcbsid =correctNull((String)hshValues.get("cbsid"));
		//String stryear=correctNull((String)hshValues.get("mon_year"));
		//String strmonth=correctNull((String)hshValues.get("mon_month"));
		String Strmmrno=correctNull((String)hshValues.get("mmrno"));
		boolean recordflag=false;
		try
		{
			strQuery = SQLParser.getSqlQuery("selmonitoringinfo^"+Strmmrno);
			rs = DBUtils.executeQuery(strQuery);	
			if (rs.next())
			{ 
				recordflag=true;
				hshResult.put("mmr_cbsid",correctNull(rs.getString("mmr_cbsid")));
				hshResult.put("mmr_infoinspectiondate",correctNull(rs.getString("mmr_infoinspectiondate")));
				hshResult.put("mmr_infotermscond",correctNull(rs.getString("mmr_infotermscond")));
				hshResult.put("mmr_infoprofitabilty",correctNull(rs.getString("mmr_infoprofitabilty")));
				hshResult.put("mmr_infocolenders",correctNull(rs.getString("mmr_infocolenders")));
				
				hshResult.put("mmr_infomanageperson",correctNull(rs.getString("mmr_infomanageperson")));
				hshResult.put("mmr_infotermreason",correctNull(rs.getString("mmr_infotermreason")));
				hshResult.put("mmr_infoadversedreason",correctNull(rs.getString("mmr_infoadversedreason")));
				hshResult.put("mmr_infoprofitabiltyreason",correctNull(rs.getString("mmr_infoprofitabiltyreason")));
				hshResult.put("mmr_infocolendersreason",correctNull(rs.getString("mmr_infocolendersreason")));
				hshResult.put("mmr_infomanagepersonreason",correctNull(rs.getString("mmr_infomanagepersonreason")));
				
				hshResult.put("mmr_infomonth",correctNull(rs.getString("mmr_infomonth")));
				hshResult.put("mmr_infoyear",correctNull(rs.getString("mmr_infoyear")));
				
				hshResult.put("mon_salesquarter",correctNull(rs.getString("mon_salesquarter")));
				hshResult.put("mon_salesamount",correctNull(rs.getString("mon_salesamount")));
			}
			if(recordflag)
				hshResult.put("recordflag","Y");
			else
				hshResult.put("recordflag","N");
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getBookdebitseligible-- "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshResult;
	}


 public void updateMonitoringInfo(HashMap hshValues) 
	{
       	HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		
		ArrayList arrValues= new ArrayList();
		
		ResultSet rs=null;
		
		String strcbsid =correctNull((String)hshValues.get("cbsid"));
		String stryear=correctNull((String)hshValues.get("mon_year"));
		String strmonth=correctNull((String)hshValues.get("mon_month"));
		String Strmmrno=correctNull((String)hshValues.get("mmrno"));
		String strAction =correctNull((String)hshValues.get("hidAction"));
		String strRecordFlag = Helper.correctNull((String)hshValues.get("hidAuditFlag"));
		
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","delmonitoringinfo");
				//arrValues.add(strcbsid);
				//arrValues.add(strmonth);
				//arrValues.add(stryear);
				arrValues.add(Strmmrno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				
				hshQuery.put("strQueryId","insmonitoringinfo");
				arrValues.add(strcbsid);
			
				arrValues.add(correctNull((String)hshValues.get("txt_inspectiondate")));
				arrValues.add(correctNull((String)hshValues.get("sel_termscond")));
				arrValues.add(correctNull((String)hshValues.get("sel_profitabilty")));
				arrValues.add(correctNull((String)hshValues.get("sel_colenders")));
				arrValues.add(correctNull((String)hshValues.get("sel_manageperson")));
				arrValues.add(correctNull((String)hshValues.get("txt_termreason")));
				arrValues.add(correctNull((String)hshValues.get("txt_adversedreason")));
				
				arrValues.add(correctNull((String)hshValues.get("txt_profitabiltyreason")));
				arrValues.add(correctNull((String)hshValues.get("txt_colendersreason")));
				arrValues.add(correctNull((String)hshValues.get("txt_managepersonreason")));
				arrValues.add(strmonth);
				arrValues.add(stryear);
				arrValues.add(correctNull((String)hshValues.get("txt_salesquarter")));
				arrValues.add(correctNull((String)hshValues.get("txt_salesamount")));
				arrValues.add(Strmmrno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				//arrValues.add(strcbsid);
				//arrValues.add(strmonth);
				//arrValues.add(stryear);
				arrValues.add(Strmmrno);
				
				hshQuery.put("strQueryId","delmonitoringinfo");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			// Audit Trial
			StringBuilder sbAt = new StringBuilder();
			if(!strAction.equals("delete"))
			{
				sbAt.append("Terms and conditions not complied if any? =").append(SetupParams.getSetupParams("YesNoFlag", correctNull((String)hshValues.get("sel_termscond"))));
				sbAt.append("~ Date of latest factory /unit inspection =").append(correctNull((String)hshValues.get("txt_inspectiondate")));
				sbAt.append("~ Whether sales/profitability is showing downward trend =").append(SetupParams.getSetupParams("YesNoFlag", correctNull((String)hshValues.get("sel_profitabilty"))));
				sbAt.append("~ Sales from 1st April upto the previous quarter =").append(correctNull((String)hshValues.get("txt_salesquarter")));
				sbAt.append("~ Sales from 1st April upto the previous quarter amount =").append(correctNull((String)hshValues.get("txt_salesamount")));
				sbAt.append("~ Any adverse report from the co-lenders/market, about the borrower. =").append(SetupParams.getSetupParams("YesNoFlag", correctNull((String)hshValues.get("sel_colenders"))));
				sbAt.append("~ Any change in the key management persons? =").append(SetupParams.getSetupParams("YesNoFlag", correctNull((String)hshValues.get("sel_manageperson"))));
				
				if(strRecordFlag.equalsIgnoreCase("Y")){
					hshValues.put("hidAction", "update");
				}else if(strRecordFlag.equalsIgnoreCase("N")){
					hshValues.put("hidAction", "insert");
				}
			}
			AuditTrial.auditLog(hshValues,"428",correctNull((String)hshValues.get("mmrno")),sbAt.toString());
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updateMonitoringInfo :: " + e.getMessage());
		}finally
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
				throw new EJBException("Error closing in updateMonitoringInfo"+cf.getMessage());						
			}
		} 
	}
	
	
 	public void updateMonitoringInformation(HashMap hshValues) 
 	{
	 	HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		
		ArrayList arrValues= new ArrayList();
			
		ResultSet rs=null;
		
		String strAction =correctNull((String)hshValues.get("hidAction"));
		
		String strcbsid =correctNull((String)hshValues.get("cbsid"));
		String stryear=correctNull((String)hshValues.get("mon_year"));
		String strmonth=correctNull((String)hshValues.get("mon_month"));
		String Strmmrno=correctNull((String)hshValues.get("mmrno"));
		String strRecordFlag = Helper.correctNull((String)hshValues.get("hidAuditFlag"));
		
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","delmonitoringinformatiom");
				//arrValues.add(strcbsid);
				//arrValues.add(strmonth);
				//arrValues.add(stryear);
				arrValues.add(Strmmrno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				
				hshQuery.put("strQueryId","insmonitoringinformatiom");
				arrValues.add(strcbsid);
			
				arrValues.add(correctNull((String)hshValues.get("sel_govtpolicy")));
				arrValues.add(correctNull((String)hshValues.get("sel_qpr")));
				arrValues.add(correctNull((String)hshValues.get("sel_penalinterst")));
				arrValues.add(correctNull((String)hshValues.get("sel_ledgeroperation")));
				arrValues.add(correctNull((String)hshValues.get("sel_rectification")));
				
				arrValues.add(correctNull((String)hshValues.get("txt_govtpolicyreason")));
				arrValues.add(correctNull((String)hshValues.get("txt_penalinterstreason")));
				arrValues.add(correctNull((String)hshValues.get("txt_rectificationreason")));
				arrValues.add(correctNull((String)hshValues.get("txt_nonsecrutinisereason")));
				arrValues.add(strmonth);
				arrValues.add(stryear);
				arrValues.add(correctNull((String)hshValues.get("sel_turnover")));
				arrValues.add(correctNull((String)hshValues.get("txt_turnoverreasons")));
				arrValues.add(Strmmrno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				//arrValues.add(strcbsid);
				//arrValues.add(strmonth);
				//arrValues.add(stryear);
				arrValues.add(Strmmrno);
				
				hshQuery.put("strQueryId","delmonitoringinformatiom");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			// Audit Trial
			StringBuilder sbAt = new StringBuilder();
			if(!strAction.equals("delete"))
			{
				sbAt.append("Any labour / legal problems / natural calamities / change in Govt.policy that may affect unit's viability =").append(SetupParams.getSetupParams("YesNoFlag", correctNull((String)hshValues.get("sel_govtpolicy"))));
				sbAt.append("~ Whether submission of Monthly / Quarterly statements / data such as Stock / Book Bebt statements MSOD / QPRs etc is regular? =").append(SetupParams.getSetupParams("YesNoFlag", correctNull((String)hshValues.get("sel_qpr"))));
				if(correctNull((String)hshValues.get("sel_qpr")).equalsIgnoreCase("2"))
				{
					sbAt.append("~ Whether penal interest recovered? =").append(SetupParams.getSetupParams("YesNoFlag", correctNull((String)hshValues.get("sel_penalinterst"))));
				}
				sbAt.append("~ Whether ledger operations are scrutinized by nominated Officer? =").append(SetupParams.getSetupParams("YesNoFlag", correctNull((String)hshValues.get("sel_ledgeroperation"))));
				sbAt.append("~ Any adverse feature observed and action initiated for rectification =").append(SetupParams.getSetupParams("YesNoFlag", correctNull((String)hshValues.get("sel_rectification"))));
				
				if(strRecordFlag.equalsIgnoreCase("Y")){
					hshValues.put("hidAction", "update");
				}else if(strRecordFlag.equalsIgnoreCase("N")){
					hshValues.put("hidAction", "insert");
				}
			}
			AuditTrial.auditLog(hshValues,"429",correctNull((String)hshValues.get("mmrno")),sbAt.toString());
			
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} finally
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
				throw new EJBException("Error closing in updateMonitoringInformation"+cf.getMessage());						
			}
		}
	}
	
	
 public HashMap getMonitoringInformation(HashMap hshValues)
 
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		
		String strQuery ="";
		
		//String strcbsid =correctNull((String)hshValues.get("cbsid"));
		//String stryear=correctNull((String)hshValues.get("mon_year"));
		//String strmonth=correctNull((String)hshValues.get("mon_month"));
		String Strmmrno=correctNull((String)hshValues.get("mmrno"));
		boolean recordflag=false;
		
		try
		{
			
			strQuery = SQLParser.getSqlQuery("selmonitoringinformatiom^"+Strmmrno);
			rs = DBUtils.executeQuery(strQuery);	
			if (rs.next())
			{ 
				recordflag=true;
				hshResult.put("mon_monitinfcbsid",correctNull(rs.getString("mon_monitinfcbsid")));
				hshResult.put("mon_monitinfgovtpolicy",correctNull(rs.getString("mon_monitinfgovtpolicy")));
				hshResult.put("mon_monitinfqpr",correctNull(rs.getString("mon_monitinfqpr")));
				hshResult.put("mon_monitinfpenalinterst",correctNull(rs.getString("mon_monitinfpenalinterst")));
				hshResult.put("mmr_infocolenders",correctNull(rs.getString("mon_monitinfledger")));
				hshResult.put("mon_monitinfrectification",correctNull(rs.getString("mon_monitinfrectification")));
				
				hshResult.put("mon_monitinfgovtpolicyrson",correctNull(rs.getString("mon_monitinfgovtpolicyrson")));
				hshResult.put("mon_monitinfpenalinterstrson",correctNull(rs.getString("mon_monitinfpenalinterstrson")));
				hshResult.put("mon_monitinfrectificationrson",correctNull(rs.getString("mon_monitinfrectificationrson")));
				hshResult.put("mon_monitinfnonsecrutiniserson",correctNull(rs.getString("mon_monitinfnonsecrutiniserson")));
				
				hshResult.put("mon_monitinfmonth",correctNull(rs.getString("mon_monitinfmonth")));
				hshResult.put("mon_monitinfyear",correctNull(rs.getString("mon_monitinfyear")));
				
				hshResult.put("mon_turnover",correctNull(rs.getString("mon_turnover")));
				hshResult.put("mon_turnoverreasons",correctNull(rs.getString("mon_turnoverreasons")));
			}
			if(recordflag)
				hshResult.put("recordflag","Y");
			else
				hshResult.put("recordflag","N");
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getBookdebitseligible-- "+ce.toString());
		}
		finally
		{
			try
			{	
				if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshResult;
	}
 
//added by ramesh for Mon_msod Borrowing
	
	
	public void updatemonmsodBorrowing(HashMap hshValues) 
	 {
		 	HashMap hshQueryValues=new HashMap();
			HashMap hshQuery=new HashMap();
			ArrayList arrValues= new ArrayList();
				
			ResultSet rs=null;
			String strQuery ="";
			String strsno="";
			
			String stryear=correctNull((String)hshValues.get("mon_year"));
			String strmonth=correctNull((String)hshValues.get("mon_month"));
			String cbsid=correctNull((String)hshValues.get("cbsid"));
		
			String strAction =correctNull((String)hshValues.get("hidAction"));
			
			String strsource=correctNull((String)hshValues.get("sel_sourcebank"));
			String strstocktype=correctNull((String)hshValues.get("txt_nature"));
			String strmatdesc=correctNull((String)hshValues.get("txt_limit"));
			String strstorplace=correctNull((String)hshValues.get("txt_Balance"));
			
			String balancedate=correctNull((String)hshValues.get("txtmon_balancedate"));
			String hidsno=correctNull((String)hshValues.get("hidsno"));
			
			String straccno=correctNull((String)hshValues.get("mon_accno"));
			
			String Strmmrno=correctNull((String)hshValues.get("mmrno"));
			
			try
			{
				if(strAction.equalsIgnoreCase("insert"))
				{	
					if(rs!=null)
					{
						rs.close();
					}
					strQuery=SQLParser.getSqlQuery("sel_maxmoniID^"+Strmmrno);
					rs=DBUtils.executeQuery(strQuery);
					
					if(rs.next())
					{
						strsno=correctNull(rs.getString("mon_msodsno"));
					}
					hshQuery=new HashMap();
					hshQueryValues=new HashMap();
					arrValues=new ArrayList();
					

					hshQuery.put("strQueryId","ins_monstatement");
					arrValues.add(straccno);
					arrValues.add(cbsid);
					arrValues.add(strsno);
					
					arrValues.add(strsource);
					arrValues.add(strstocktype);
					arrValues.add(strmatdesc);
					arrValues.add(strstorplace);
			
					arrValues.add(balancedate);
					
					arrValues.add(strmonth);
					arrValues.add(stryear);
					arrValues.add(Strmmrno);
					
					hshQuery.put("arrValues",arrValues);
					
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					

					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				else if(strAction.equalsIgnoreCase("update"))
				{
					hshQuery=new HashMap();
					hshQueryValues=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","upd_monstatement");
					arrValues.add(strsource);
					arrValues.add(strstocktype);
					arrValues.add(strmatdesc);
					arrValues.add(strstorplace);
			
					arrValues.add(balancedate);
					
					arrValues.add(hidsno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				
				else if(strAction.equalsIgnoreCase("delete"))
				{
					hshQuery=new HashMap();
					hshQueryValues=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(hidsno);
					arrValues.add(straccno);
					arrValues.add(Strmmrno);
					hshQuery.put("strQueryId","del_monstatement");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
				}
				
				// Audit Trial
				StringBuilder sbAt = new StringBuilder();
				if(!strAction.equals("delete"))
				{
					sbAt.append("E) SHORT TERM BORROWING FROM BANKS/ OTHER SOURCES (Incl. Bills Discounted / Negotiated) (Rs. in lacs). </b> ");
					sbAt.append("~ </b>").append(correctNull((String)hshValues.get("sel_sourcebank")));
					sbAt.append("~ Nature of Facility  =").append(correctNull((String)hshValues.get("txt_nature")));
					sbAt.append("~ Limit =").append(correctNull((String)hshValues.get("txt_limit")));
					sbAt.append("~ Balance outstanding with Banks / Others as on  =").append(correctNull((String)hshValues.get("txtmon_balancedate")));
					sbAt.append("~ Balance outstanding with Banks / Others amount  =").append(correctNull((String)hshValues.get("txt_Balance")));
				}
				AuditTrial.auditLog(hshValues,"420",Strmmrno,sbAt.toString());
			}catch(Exception e)
			{
				throw new EJBException("Error in updatemonitoring Statement"+e.getMessage());
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
					throw new EJBException("Error closing in the updatemonitoring Statement connection "+cf.getMessage());
							
				}
			}
	 }
	
	
	
	
	public HashMap getmonmsodBorrowing(HashMap hshValues)
	 {
	 	HashMap hshResult=new HashMap();
	 	ResultSet rs = null;
	 	ArrayList vecCol = new ArrayList();
	 	ArrayList vecRow=new ArrayList();
	 	
	 	String strQuery="";
	 	//String stryear=correctNull((String)hshValues.get("mon_year"));
		//String strmonth=correctNull((String)hshValues.get("mon_month"));
		String straccno=correctNull((String)hshValues.get("mon_accno"));
		String mon_msod=correctNull((String)hshValues.get("mon_msod"));
		String mon_stock=correctNull((String)hshValues.get("mon_stock"));
		String mon_bkdebts=correctNull((String)hshValues.get("mon_bkdebts"));
		String mon_qpr=correctNull((String)hshValues.get("mon_qpr"));
		String Strmmrno=correctNull((String)hshValues.get("mmrno"));
	 	try
	 	{
	 		//String strcbsid=correctNull((String)hshValues.get("cbsid"));
	 		strQuery=SQLParser.getSqlQuery("sel_monstatement^"+straccno+"^"+Strmmrno);
	 		rs=DBUtils.executeQuery(strQuery);
	 		while(rs.next())
	 			{
	 				vecCol = new ArrayList();
					

	 				vecCol.add(correctNull(rs.getString("mon_msodsno")));
					vecCol.add(correctNull(rs.getString("MON_MSODSOURCE")));
					vecCol.add(correctNull(rs.getString("MON_MSODNATURE")));
					vecCol.add(correctNull(rs.getString("MON_MSODLIMIT")));
					vecCol.add(correctNull(rs.getString("MON_MSODBALANCE")));
					vecCol.add(correctNull(rs.getString("mon_balancedate")));
					vecRow.add(vecCol);
				}			
	 			hshResult.put("vecRow",vecRow);
	 			hshResult.put("mon_msod",mon_msod);
	 			hshResult.put("mon_stock",mon_stock);
	 			hshResult.put("mon_bkdebts",mon_bkdebts);
	 			hshResult.put("mon_qpr",mon_qpr);
	 	
	 	}catch (Exception exp){
	 		throw new EJBException("Error in getmonitoring"+exp.getMessage());
	 	}finally
	 	{
	 		try
	 		{
	 			if(rs!=null)
	 				rs.close();
	 		}catch(Exception exp)
	 		{
	 			throw new EJBException("Error in closing the connection in getmonitoring "+ exp.toString()); 
	 		}
	 	}
	 	
	 	return hshResult;
	 }

	
	 
	public void updatemonConsortiumMeeting(HashMap hshValues) 
	 {
		 	HashMap hshQueryValues=new HashMap();
			HashMap hshQuery=new HashMap();
			ArrayList arrValues= new ArrayList();
				
			ResultSet rs=null;
			
			String stryear=correctNull((String)hshValues.get("mon_year"));
			String strmonth=correctNull((String)hshValues.get("mon_month"));
			String cbsid=correctNull((String)hshValues.get("cbsid"));
			String strAction =correctNull((String)hshValues.get("hidAction"));
			String strdateofmetting=correctNull((String)hshValues.get("txtmon_dateofmet"));
			String strminutesmet=correctNull((String)hshValues.get("txtmon_minutesmet"));
			String strreceived=correctNull((String)hshValues.get("txtmon_received"));
			String str_noofmeetings=correctNull((String)hshValues.get("meetingheld"));
			String hidsno=correctNull((String)hshValues.get("hidsno"));
			String strmmrno=correctNull((String)hshValues.get("mmrno"));
			
			try
			{
				if(strAction.equalsIgnoreCase("insert"))
				{	
					hshQuery=new HashMap();
					hshQueryValues=new HashMap();
					arrValues=new ArrayList();
					
					arrValues.add(strmmrno);
					
					hshQuery.put("strQueryId","del_mettingstatement");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					
					hshQuery=new HashMap();
					hshQueryValues=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","ins_mettingstatement");
					
					arrValues.add(cbsid);
					arrValues.add(strdateofmetting);
					arrValues.add(strminutesmet);
					arrValues.add(strreceived);
					arrValues.add(strmonth);
					arrValues.add(stryear);
					arrValues.add(str_noofmeetings);
					arrValues.add(strmmrno);
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
								
				else if(strAction.equalsIgnoreCase("delete"))
				{
					hshQuery=new HashMap();
					hshQueryValues=new HashMap();
					arrValues=new ArrayList();
					
					arrValues.add(strmmrno);
					
					hshQuery.put("strQueryId","del_mettingstatement");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
				}
			}catch(Exception e)
			{
				throw new EJBException("Error in updatemonitoring Statement"+e.getMessage());
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
					throw new EJBException("Error closing in the updatemonitoring Statement connection "+cf.getMessage());
							
				}
				}
	 }
	
	public HashMap getmonConsortiumMeeting(HashMap hshValues)
	{
	 	HashMap hshResult=new HashMap();
	 	ResultSet rs = null;
	
	 	String strQuery="";
	 	
		String strmmrno=correctNull((String)hshValues.get("mmrno"));
	 	
	 	try
	 	{
	 		
	 		strQuery=SQLParser.getSqlQuery("sel_mettingstatement^"+strmmrno);
	 		rs=DBUtils.executeQuery(strQuery);
	 		if(rs.next())
 			{
 			   	hshResult.put("mon_sno",correctNull(rs.getString("mon_sno")));
 			   	hshResult.put("mon_dateofmet",correctNull(rs.getString("mon_dateofmet")));
 				hshResult.put("mon_minutesmet",correctNull(rs.getString("mon_minutesmet")));
 				hshResult.put("mon_received",correctNull(rs.getString("mon_received")));
 				hshResult.put("mon_noofmeetingheld",correctNull(rs.getString("mon_noofmeetingheld")));
			}			
	 	
	 	}catch (Exception exp){
	 		throw new EJBException("Error in getmonConsortiumMeeting :: "+ exp.getMessage());
	 	}finally
	 	{
	 		try
	 		{
	 			if(rs!=null)
	 				rs.close();
	 		}catch(Exception exp)
	 		{
	 			throw new EJBException("Error in closing the connection in getmonConsortiumMeeting ::  "+ exp.toString()); 
	 		}
	 	}
	 	return hshResult;
	 }
	
	
	
	//end

//add by ramesh for Recovered Statement 

public void updateRecoveredStatement(HashMap hshValues) {
		
				HashMap hshQueryValues=new HashMap();
				HashMap hshQuery=new HashMap();
				ArrayList arrValues= new ArrayList();
					
				ResultSet rs=null;
				String cbsid=correctNull((String)hshValues.get("cbsid"));
				String Strmmrno=correctNull((String)hshValues.get("mmrno"));
				String strAction =correctNull((String)hshValues.get("hidAction"));
				
				String strmonworkmonth=correctNull((String)hshValues.get("txt_monworkmonth"));
				String strmonworkvalue=correctNull((String)hshValues.get("txt_monworkvalue"));
				String strmontermmonth=correctNull((String)hshValues.get("txt_montermmonth"));
				
				String strmontermvalue=correctNull((String)hshValues.get("txt_montermvalue"));
				String strmontermins=correctNull((String)hshValues.get("txt_montermins"));
				String strmonterminsvalue=correctNull((String)hshValues.get("txt_monterminsvalue"));
				
				String strmonage=correctNull((String)hshValues.get("txt_monage"));
				
				String strmonth = correctNull((String)hshValues.get("mon_month"));
				String stryear = correctNull((String)hshValues.get("mon_year"));
				
				String strServiceInstalment = correctNull((String)hshValues.get("seviceMonth"));
				String recoverArrears = correctNull((String)hshValues.get("txt_recoverarrears"));
				
				String txt_inlandthreemonth = correctNull((String)hshValues.get("txt_inlandthreemonth"));
				String txt_foreignthreemonth = correctNull((String)hshValues.get("txt_foreignthreemonth"));
				String txt_inlandsixmonth = correctNull((String)hshValues.get("txt_inlandsixmonth"));
				String txt_foreignsixmonth = correctNull((String)hshValues.get("txt_foreignsixmonth"));
				String txt_inlandmorethansixmonth = correctNull((String)hshValues.get("txt_inlandmorethansixmonth"));
				String txt_foreignmorethansixmonth = correctNull((String)hshValues.get("txt_foreignmorethansixmonth"));
				String txt_inlandtota1 = correctNull((String)hshValues.get("txt_inlandtota1"));
				String txt_foreigntotal = correctNull((String)hshValues.get("txt_foreigntotal"));
				
				String strRecordFlag = Helper.correctNull((String)hshValues.get("hidAuditFlag"));
				
				try {
						
						if(strAction.equalsIgnoreCase("insert"))
						{
							
							hshQuery=new HashMap();
							hshQueryValues=new HashMap();
							arrValues=new ArrayList();
							
							//arrValues.add(cbsid);
							//arrValues.add(strmonth);
							//arrValues.add(stryear);
							arrValues.add(Strmmrno);
							hshQuery.put("arrValues",arrValues);
							hshQuery.put("strQueryId","del_recoveredstatement");
							
							hshQueryValues.put("1",hshQuery);
							
							arrValues = new ArrayList();
							hshQuery = new HashMap();
							
							
							
							arrValues.add(cbsid);
							arrValues.add(strmonth);
							arrValues.add(stryear);
							arrValues.add(strmonworkmonth);
							arrValues.add(strmonworkvalue);
							arrValues.add(strmontermmonth);
							arrValues.add(strmontermvalue);
							arrValues.add(strmontermins);
							arrValues.add(strmonterminsvalue);
							arrValues.add(strmonage);
							
							arrValues.add(strServiceInstalment);
							arrValues.add(recoverArrears);
							
							arrValues.add(txt_inlandthreemonth);
							arrValues.add(txt_foreignthreemonth);
							arrValues.add(txt_inlandsixmonth);
							arrValues.add(txt_foreignsixmonth);
							arrValues.add(txt_inlandmorethansixmonth);
							arrValues.add(txt_foreignmorethansixmonth);
							arrValues.add(txt_inlandtota1);
							arrValues.add(txt_foreigntotal);
							arrValues.add(Strmmrno);
							
							hshQuery.put("arrValues",arrValues);
							hshQuery.put("strQueryId","ins_recoveredstatement");
							
							hshQueryValues.put("2",hshQuery);
							hshQueryValues.put("size","2");
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						
						}
//						else if(strAction.equalsIgnoreCase("update"))
//						{
//							hshQuery=new HashMap();
//							hshQueryValues=new HashMap();
//							arrValues=new ArrayList();
//							hshQuery.put("strQueryId","upd_recoveredstatement");
//							arrValues.add(strmonworkmonth);
//							arrValues.add(strmonworkvalue);
//							arrValues.add(strmontermmonth);
//							arrValues.add(strmontermvalue);
//							arrValues.add(strmonterminsvalue);
//							arrValues.add(strmontermins);
//							arrValues.add(strmonterminsvalue);
//							arrValues.add(strmonage);
//							//arrValues.add(strstorplace);
//							arrValues.add(cbsid);
//							arrValues.add(strServiceInstalment);
//							arrValues.add(recoverArrears);
//							hshQuery.put("arrValues",arrValues);
//							hshQueryValues.put("1",hshQuery);
//							hshQueryValues.put("size","1");
//							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//						}				
						else if(strAction.equalsIgnoreCase("delete"))
						{
							hshQuery=new HashMap();
							hshQueryValues=new HashMap();
							arrValues=new ArrayList();
							//arrValues.add(cbsid);
							//arrValues.add(strmonth);
							//arrValues.add(stryear);
							arrValues.add(Strmmrno);
							hshQuery.put("strQueryId","del_recoveredstatement");
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							hshQueryValues.put("size","1");
								
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
							
						}
						// Audit Trial
						StringBuilder sbAt = new StringBuilder();
						if(!strAction.equals("delete"))
						{
							sbAt.append("Interest on working capital recovered upto =").append(correctNull((String)hshValues.get("txt_monworkmonth")));
							sbAt.append("~ Quantify arrears if any  =").append(correctNull((String)hshValues.get("txt_monworkvalue")));
							sbAt.append("~ Interest on Term Loan recovered upto =").append(correctNull((String)hshValues.get("txt_montermmonth")));
							sbAt.append("~ Quantify arrears if any =").append(correctNull((String)hshValues.get("txt_montermvalue")));
							sbAt.append("~ Term Loan installments recovered upto =").append(correctNull((String)hshValues.get("txt_montermins")));
							sbAt.append("~ Quantify arrears if any =").append(correctNull((String)hshValues.get("txt_monterminsvalue")));
							sbAt.append("~ Age-wise break up of overdue bills </b>");
							sbAt.append("~ Up to 3 Months Inland =").append(correctNull((String)hshValues.get("txt_inlandthreemonth")));
							sbAt.append("~ Up to 3 Months Foreign =").append(correctNull((String)hshValues.get("txt_foreignthreemonth")));
							sbAt.append("~ 3 Months to 6 Months Inland =").append(correctNull((String)hshValues.get("txt_inlandsixmonth")));
							sbAt.append("~ 3 Months to 6 Months Foreign =").append(correctNull((String)hshValues.get("txt_foreignsixmonth")));
							sbAt.append("~ More than 6 Months Inland =").append(correctNull((String)hshValues.get("txt_inlandmorethansixmonth")));
							sbAt.append("~ More than 6 Months Foreign =").append(correctNull((String)hshValues.get("txt_foreignmorethansixmonth")));
							sbAt.append("~ Inland Total =").append(correctNull((String)hshValues.get("txt_inlandtota1")));
							sbAt.append("~ Foreign Total =").append(correctNull((String)hshValues.get("txt_foreigntotal")));
							if(strRecordFlag.equalsIgnoreCase("Y")){
								hshValues.put("hidAction", "update");
							}else if(strRecordFlag.equalsIgnoreCase("N")){
								hshValues.put("hidAction", "insert");
							}
						}
						AuditTrial.auditLog(hshValues,"416",correctNull((String)hshValues.get("mmrno")),sbAt.toString());
					}catch(Exception e)
				{
					throw new EJBException("Error in updatemonitoring Statement"+e.getMessage());
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
						throw new EJBException("Error closing in the updatemonitoring Statement connection "+cf.getMessage());
								
					}
					}
	
	
	}	

	
	public HashMap getRecoveredStatement(HashMap hshValues)
	 {
	 	HashMap hshResult=new HashMap();
	 	ResultSet rs = null;
	 	String strQuery="";
	 
	 	//String stryear=correctNull((String)hshValues.get("mon_year"));
		//String strmonth=correctNull((String)hshValues.get("mon_month"));
		String Strmmrno=correctNull((String)hshValues.get("mmrno"));
		boolean recordflag=false;
	 	try
	 	{
	 		//String strcbsid=correctNull((String)hshValues.get("cbsid"));
	 		
	 		strQuery=SQLParser.getSqlQuery("sel_recoveredstatement^"+Strmmrno);
	 		rs=DBUtils.executeQuery(strQuery);
	 		while(rs.next())
	 			{
	 				recordflag=true;
					hshResult.put("mon_recworkmonth",correctNull(rs.getString("mon_recworkmonth")));
					hshResult.put("mon_recworkvalue",correctNull(rs.getString("mon_recworkvalue")));
					hshResult.put("mon_rectermmonth",correctNull(rs.getString("mon_rectermmonth")));
					hshResult.put("mon_rectermvalue",correctNull(rs.getString("mon_rectermvalue")));
					hshResult.put("mon_rectermins",correctNull(rs.getString("mon_rectermins")));
					hshResult.put("mon_recterminsvalue",correctNull(rs.getString("mon_recterminsvalue")));
					hshResult.put("mon_recage",correctNull(rs.getString("mon_recage")));
					hshResult.put("mon_seviceMonth",correctNull(rs.getString("mon_seviceMonth")));
					hshResult.put("mon_recoverarrears",correctNull(rs.getString("mon_recoverarrears")));
					
					hshResult.put("mon_inlandthreemonth",correctNull(rs.getString("mon_inlandthreemonth")));
					hshResult.put("mon_foreignthreemonth",correctNull(rs.getString("mon_foreignthreemonth")));
					hshResult.put("mon_inlandsixmonth",correctNull(rs.getString("mon_inlandsixmonth")));
					hshResult.put("mon_foreignsixmonth",correctNull(rs.getString("mon_foreignsixmonth")));
					hshResult.put("mon_inlandmorethansixmonth",correctNull(rs.getString("mon_inlandmorethansixmonth")));
					hshResult.put("mon_foreignmorethansixmonth",correctNull(rs.getString("mon_foreignmorethansixmonth")));
					hshResult.put("mon_inlandtotal",correctNull(rs.getString("mon_inlandtotal")));
					hshResult.put("mon_foreigntotal",correctNull(rs.getString("mon_foreigntotal")));
					
		
	 			
				}			
	 		
	 		if(recordflag)
				hshResult.put("recordflag","Y");
			else
				hshResult.put("recordflag","N");
	 	
	 	
	 	}
	 	catch (Exception exp)
	 	{
	 		
	 		throw new EJBException("Error in getRecoveredStatement"+ exp.getMessage());
	 		
	 	}
	 	finally
	 	{
	 		try
	 		{
	 			if(rs!=null)
	 				rs.close();
	 		}catch(Exception exp)
	 		{
	 			throw new EJBException("Error in closing the connection in getmonitoring "+ exp.toString()); 
	 		}
	 	}
	 	
	 	return hshResult;
	 }
	
 
 //add by ramesh for QPR-Performance
	
	public void updateQprPerformance(HashMap hshValues) {
		
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		
		ArrayList arrValues= new ArrayList();
		
		ResultSet rs=null;
		
		String stryear=correctNull((String)hshValues.get("mon_year"));
		String strmonth=correctNull((String)hshValues.get("mon_month"));
		String cbsid=correctNull((String)hshValues.get("cbsid"));
		String strAction =correctNull((String)hshValues.get("hidAction"));
		String straccno=correctNull((String)hshValues.get("mon_accno"));
		String Strmmrno=correctNull((String)hshValues.get("mmrno"));
		String strRecordFlag = Helper.correctNull((String)hshValues.get("hidAuditFlag"));
		try 
		{
			if(strAction.equalsIgnoreCase("insert"))
			{
			
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(straccno);
				arrValues.add(Strmmrno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_qprstatement");
				
				hshQueryValues.put("1",hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
			
				arrValues.add(cbsid);
				arrValues.add(straccno);
				arrValues.add(strmonth);
				arrValues.add(stryear);
				arrValues.add(correctNull((String)hshValues.get("txt_monproann")));
				arrValues.add(correctNull((String)hshValues.get("txt_monprocurrent")));
				arrValues.add(correctNull((String)hshValues.get("txt_monprocum")));
				arrValues.add(correctNull((String)hshValues.get("txt_monproachieve")));
				
				arrValues.add(correctNull((String)hshValues.get("txt_monprodomann")));
				arrValues.add(correctNull((String)hshValues.get("txt_mondomcurrent")));
				arrValues.add(correctNull((String)hshValues.get("txt_mondomcum")));
				arrValues.add(correctNull((String)hshValues.get("txt_mondomachieve")));
				
				arrValues.add(correctNull((String)hshValues.get("txt_monexpann")));
				arrValues.add(correctNull((String)hshValues.get("txt_monexpcurrent")));
				arrValues.add(correctNull((String)hshValues.get("txt_monexpcum")));
				arrValues.add(correctNull((String)hshValues.get("txt_monexpachieve")));
				arrValues.add(Strmmrno);
				
				
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_qprstatement");
				
				hshQueryValues.put("2",hshQuery);
				hshQueryValues.put("size","2");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(straccno);
				arrValues.add(Strmmrno);
				hshQuery.put("strQueryId","del_qprstatement");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
					
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
			// Audit Trial
			StringBuilder sbAt = new StringBuilder();
			if(!strAction.equals("delete"))
			{
				sbAt.append("Production(Quantity) - Annual Plan(1) =").append(correctNull((String)hshValues.get("txt_monproann")));
				sbAt.append("~ Production(Quantity) - Current Year(2)  =").append(correctNull((String)hshValues.get("txt_monprocurrent")));
				sbAt.append("~ Production(Quantity) - Cumulative upto quarter ending(3) =").append(correctNull((String)hshValues.get("txt_monprocum")));
				sbAt.append("~ Production(Quantity) - % of achievement =").append(correctNull((String)hshValues.get("txt_monproachieve")));
				sbAt.append("~ NET SALES </b>");
				sbAt.append("~ a)Domestic - Annual Plan(1) =").append(correctNull((String)hshValues.get("txt_monprodomann")));
				sbAt.append("~ a)Domestic - Current Year(2) =").append(correctNull((String)hshValues.get("txt_mondomcurrent")));
				sbAt.append("~ a)Domestic - Cumulative upto quarter ending(3) =").append(correctNull((String)hshValues.get("txt_mondomcum")));
				sbAt.append("~ a)Domestic - % of achievement =").append(correctNull((String)hshValues.get("txt_mondomachieve")));
				sbAt.append("~ b)Exports - Annual Plan(1) =").append(correctNull((String)hshValues.get("txt_monexpann")));
				sbAt.append("~ b)Exports - Current Year(2) =").append(correctNull((String)hshValues.get("txt_monexpcurrent")));
				sbAt.append("~ b)Exports - Cumulative upto quarter ending(3) =").append(correctNull((String)hshValues.get("txt_monexpcum")));
				sbAt.append("~ b)Exports - % of achievement =").append(correctNull((String)hshValues.get("txt_monexpachieve")));
				
				if(strRecordFlag.equalsIgnoreCase("Y")){
					hshValues.put("hidAction", "update");
				}else if(strRecordFlag.equalsIgnoreCase("N")){
					hshValues.put("hidAction", "insert");
				}
			}
			AuditTrial.auditLog(hshValues,"424",Strmmrno,sbAt.toString());
		}catch(Exception e)
		{
			throw new EJBException("Error in updatemonitoring Statement"+e.getMessage());
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
				throw new EJBException("Error closing in the updatemonitoring Statement connection "+cf.getMessage());
						
			}
		}
	}	


		public HashMap getQprPerformance(HashMap hshValues)
		{
			HashMap hshResult=new HashMap();
			ResultSet rs = null;
			String strQuery="";
			
			//String stryear=correctNull((String)hshValues.get("mon_year"));
			//String strmonth=correctNull((String)hshValues.get("mon_month"));
			String straccno=correctNull((String)hshValues.get("mon_accno"));
			String Strmmrno=correctNull((String)hshValues.get("mmrno"));
			boolean recordflag=false;
			
			try
			{
				//String strcbsid=correctNull((String)hshValues.get("cbsid"));
				
				strQuery=SQLParser.getSqlQuery("sel_qprstatement^"+straccno+"^"+Strmmrno);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
					{
					recordflag=true;
				hshResult.put("mon_qprproann",correctNull(rs.getString("mon_qprproann")));
				hshResult.put("mon_qprprocurrent",correctNull(rs.getString("mon_qprprocurrent")));
				hshResult.put("mon_qprprocum",correctNull(rs.getString("mon_qprprocum")));
				hshResult.put("mon_qprproachieve",correctNull(rs.getString("mon_qprproachieve")));
				
				hshResult.put("mon_qprdomann",correctNull(rs.getString("mon_qprdomann")));
				hshResult.put("mon_qprdomcurrent",correctNull(rs.getString("mon_qprdomcurrent")));
				hshResult.put("mon_qprdomcum",correctNull(rs.getString("mon_qprdomcum")));
				hshResult.put("mon_qprdomachieve",correctNull(rs.getString("mon_qprdomachieve")));
				
				hshResult.put("mon_qprexpann",correctNull(rs.getString("mon_qprexpann")));
				hshResult.put("mon_qprexpcurrent",correctNull(rs.getString("mon_qprexpcurrent")));
				hshResult.put("mon_qprexpcum",correctNull(rs.getString("mon_qprexpcum")));
				hshResult.put("mon_qprexpachieve",correctNull(rs.getString("mon_qprexpachieve")));
				
				}			
				
				strQuery = SQLParser.getSqlQuery("sel_monchecklist^"+straccno);
				rs = DBUtils.executeQuery(strQuery);	
				if (rs.next())
				{ 
					hshResult.put("mon_checkmsod",correctNull(rs.getString("mon_checkmsod")));
					hshResult.put("mon_checkstock",correctNull(rs.getString("mon_checkstock")));
					hshResult.put("mon_checkbkdebts",correctNull(rs.getString("mon_checkbkdebts")));
					hshResult.put("mon_checkqpr",correctNull(rs.getString("mon_checkqpr")));
					
				}
				
				if(recordflag)
					hshResult.put("recordflag","Y");
				else
					hshResult.put("recordflag","N");   
			
			}catch (Exception exp){
				
				throw new EJBException("Error in getmonitoring"+exp.getMessage());
				
			}finally
			{
				try
				{
					if(rs!=null)
						rs.close();
				}catch(Exception exp)
				{
					throw new EJBException("Error in closing the connection in getmonitoring "+ exp.toString()); 
				}
			}
			
			return hshResult;
		}


		public HashMap getDataInsurancecovered(HashMap hshValues)  
		{ 
				ResultSet rs = null;
			ResultSet rs1 = null;
			HashMap hshRecord = new HashMap();	
			ArrayList vecData = new ArrayList();
			ArrayList vecRec1 = new ArrayList();
			ArrayList vecData2=new ArrayList();
			ArrayList vecRec2=new ArrayList();
			String hidAction=null;	
			String strQuery="";
			int vecsize=0;
			int vecsize1=0;
			
			try 
			{ 
				hidAction ="select";
				//String strcbsid =correctNull((String)hshValues.get("cbsid"));
				//String stryear=correctNull((String)hshValues.get("mon_year"));
				//String strmonth=correctNull((String)hshValues.get("mon_month"));
				String straccno=correctNull((String)hshValues.get("mon_accno"));
				String mon_msod=correctNull((String)hshValues.get("mon_msod"));
				String mon_stock=correctNull((String)hshValues.get("mon_stock"));
				String mon_bkdebts=correctNull((String)hshValues.get("mon_bkdebts"));
				String strcbsname=correctNull((String)hshValues.get("strcbsname"));
				String mon_qpr=correctNull((String)hshValues.get("mon_qpr"));
				String print=correctNull((String)hshValues.get("print"));
				
				String Strmmrno=correctNull((String)hshValues.get("mmrno"));
				if(print.equalsIgnoreCase("print"))
				{
					strQuery = SQLParser.getSqlQuery("sel_acountwisedetails^"+straccno+"^"+Strmmrno);
					rs = DBUtils.executeQuery(strQuery);	
					if (rs.next())
					{ 
						hshRecord.put("stockdate",correctNull(rs.getString("stockdate")));
						
					}
					if (rs != null) 
					{
						rs.close();					 
					}
					
				}
				strQuery = SQLParser.getSqlQuery("sel_securitycovered^"+"39"+"^"+straccno+"^"+Strmmrno);	
				rs = DBUtils.executeQuery(strQuery);
				vecData=new ArrayList();
				vecRec2=new ArrayList();
				vecData2=new ArrayList();			
				while (rs.next()) 
				{				
					vecRec1=new ArrayList();
					vecRec1.add(correctNull(rs.getString("stat_data_desc1")));
					vecData.add(vecRec1);				
				}	
				if (rs != null) 
				{
					rs.close();					 
				}
				vecsize1=vecData.size();
				if(hidAction.equals("select"))
				{			
				strQuery=SQLParser.getSqlQuery("sel_insurancecovered^"+straccno+"^"+Strmmrno);	
				rs1 = DBUtils.executeQuery(strQuery);
					while (rs1.next()) 
					{
						vecRec2=new ArrayList();
					    vecRec2.add(correctNull(rs1.getString("mon_insucbsid")));//0
						vecRec2.add(correctNull(rs1.getString("mon_insucbsaccountno")));//1
						vecRec2.add(correctNull(rs1.getString("mon_insumonth")));//2
						vecRec2.add(correctNull(rs1.getString("mon_insuyear")));//3
						vecRec2.add(correctNull(rs1.getString("mon_insuamount")));//4
						vecRec2.add(correctNull(rs1.getString("mon_insuexpirydate")));//5
						vecRec2.add(correctNull(rs1.getString("mon_insuendorsed")));//6
						vecRec2.add(correctNull(rs1.getString("mon_insupolicies")));//7
						vecRec2.add(correctNull(rs1.getString("mon_insuremarks")));//8
						vecRec2.add(correctNull(rs1.getString("mon_securitycover")));//9
						vecRec2.add(correctNull(rs1.getString("mon_insunumber")));//10
						vecData2.add(vecRec2);
					}
					
					if (rs1!= null) 
					{
						rs1.close();
					}
				}
				strQuery=SQLParser.getSqlQuery("sel_sumofinsurancecovered^"+straccno+"^"+Strmmrno);	
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("insuamount",correctNull(rs.getString("insuamount")));
				}
				if (rs!= null) 
				{
					rs.close();
				}
				
				vecsize=vecData2.size();
				if(vecsize1!=vecsize)
				{
					int i=vecsize1-vecsize;
					for(int l=1; l<=i; l++)
					{
						vecRec2=new ArrayList();
						vecRec2.add("");
						vecRec2.add("");
						vecRec2.add("");
						vecRec2.add("");
						vecRec2.add("");
						vecRec2.add("");
						vecRec2.add("");
						vecRec2.add("");
						vecRec2.add("");
						vecRec2.add("");
						vecRec2.add("");
						vecData2.add(vecRec2);
					}
				}		
				vecsize=vecData2.size();
				String str=Integer.toString(vecsize);
				hshRecord.put("mon_msod",mon_msod);
				hshRecord.put("mon_stock",mon_stock);
				hshRecord.put("mon_bkdebts",mon_bkdebts);
				hshRecord.put("vecData2",vecData2);
				hshRecord.put("str",str);
				hshRecord.put("vecData",vecData);
				hshRecord.put("mon_accno",straccno);
				hshRecord.put("mon_qpr",mon_qpr);
				hshRecord.put("strcbsname",strcbsname);
			} 		
			catch (Exception e) 
			{
				throw new EJBException(e.getMessage());
			} 
			finally 
			{
				try 
				{
					if (rs != null) 
					{
						rs.close();					 
					}
					if (rs1!= null) 
					{
						rs1.close();
					}
				} 			
				catch (Exception cf) 
				{
					throw new EJBException("Error closing the connection "+ cf.getMessage());
				}
			}		
			return hshRecord;
		}

		public void updateDataInsurancecovered(HashMap hshValues)  
		{
			HashMap hshQuery = new HashMap();
			HashMap hshQueryValues = new HashMap();
			
			ArrayList arrValues ;		 
			ResultSet rs=null;
			
			try
			{ 
				String[] strAmount=null;
				String[] strExpirydate=null;
				String[] strendorsed=null;
				String[] strPolicies=null;
				String[] strRemarks=null;
				String[] strInsuno=null;
				String[] strSecuritycover=null;
				int intUpdatesize = 0;	
				intUpdatesize=intUpdatesize+1;	
			
				String strAction =correctNull((String)hshValues.get("hidAction"));
				String strAccid =correctNull((String)hshValues.get("cbsid"));
				String strmonth = correctNull((String) hshValues.get("mon_month"));
				String stryear = correctNull((String) hshValues.get("mon_year"));
				String straccno=correctNull((String)hshValues.get("mon_accno"));
				
				String Strmmrno=correctNull((String)hshValues.get("mmrno"));
				
				if (rs != null) 
				{
					rs.close();					 
				}
				if(hshValues.get("txt_insuamount") instanceof String)
				{
					strAmount=new String[1];
					strAmount[0]=(String)hshValues.get("txt_insuamount");
				}
				else
				{
					strAmount =(String[])hshValues.get("txt_insuamount");
				}
				if(hshValues.get("txt_insuexpirydate") instanceof String)
				{
					strExpirydate=new String[1];
					strExpirydate[0]=(String)hshValues.get("txt_insuexpirydate");
				}
				else
				{
					strExpirydate =(String[])hshValues.get("txt_insuexpirydate");
				}
				if(hshValues.get("sel_endorsed") instanceof String)
				{
					strendorsed=new String[1];
					strendorsed[0]=(String)hshValues.get("sel_endorsed");
				}
				else
				{
					strendorsed =(String[])hshValues.get("sel_endorsed");
				}
				if(hshValues.get("sel_policies") instanceof String)
				{
					strPolicies=new String[1];
					strPolicies[0]=(String)hshValues.get("sel_policies");
				}
				else
				{
					strPolicies =(String[])hshValues.get("sel_policies");
				}
				
				if(hshValues.get("txt_insuremarks") instanceof String)
				{
					strRemarks=new String[1];
					strRemarks[0]=(String)hshValues.get("txt_insuremarks");
				}
				else
				{
					strRemarks =(String[])hshValues.get("txt_insuremarks");
				}
				
				if(hshValues.get("txt_insuno") instanceof String)
				{
					strInsuno=new String[1];
					strInsuno[0]=(String)hshValues.get("txt_insuno");
				}
				else
				{
					strInsuno =(String[])hshValues.get("txt_insuno");
				}
				
				if(hshValues.get("txt_staticdataid") instanceof String)
				{
					strSecuritycover=new String[1];
					strSecuritycover[0]=(String)hshValues.get("txt_staticdataid");
				}
				else
				{
					strSecuritycover=(String[])hshValues.get("txt_staticdataid");
				}
				int len=strSecuritycover.length;
				if(strAction.equals("insert"))
				{
					hshQueryValues = new HashMap();
					hshQuery=new HashMap();				
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","del_insurancecovered");	
					arrValues.add(straccno);
					arrValues.add(Strmmrno);
					//arrValues.add(strSecuritycover);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					if(len!=0)
					{
						for(int k=0;k<len;k++)
						{
							//if(!strAmount[k].equals(""))
							//{
								arrValues=new ArrayList();	
								hshQuery = new HashMap();
								hshQueryValues = new HashMap();
								arrValues.add(strAccid);
								arrValues.add(straccno);
								arrValues.add(strmonth);
								arrValues.add(stryear);
								arrValues.add(strAmount[k]);
								arrValues.add(strExpirydate[k]);
								arrValues.add(strendorsed[k]);
								arrValues.add(strPolicies[k]);
								arrValues.add(strRemarks[k]);
								arrValues.add(strSecuritycover[k]);
								arrValues.add(strInsuno[k]);
								arrValues.add(Strmmrno);
								hshQuery.put("strQueryId","ins_insurancecovered");
								hshQuery.put("arrValues",arrValues);					
								hshQueryValues.put("1",hshQuery);
								hshQueryValues.put("size","1");
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
							//}
						}
					}
				}
				if(strAction.equals("delete"))
				{
					//if(len!=0)
						
					//{
						//for(int k=0;k<len;k++)
						//{
								hshQueryValues = new HashMap();
								hshQuery=new HashMap();				
								arrValues=new ArrayList();	
								hshQuery.put("strQueryId","upd_insurancecovered");	
								arrValues.add("0.00");
								arrValues.add("");
								arrValues.add("");
								arrValues.add("0");
								arrValues.add("");
								arrValues.add("");
								//arrValues.add(strSecuritycover[k]);
								arrValues.add(straccno);
								arrValues.add(Strmmrno);
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("1", hshQuery);
								hshQueryValues.put("size","1");
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
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

public void updateCurrentAssetfinanced(HashMap hshValues) 
{

    HashMap hshQueryValues=new HashMap();
	HashMap hshQuery=new HashMap();
	
	ArrayList arrValues= new ArrayList();

		
	ResultSet rs=null;
	
	String strAction =correctNull((String)hshValues.get("hidAction"));
	
	String strcbsaccountno =correctNull((String)hshValues.get("mon_accno"));
	String strcbsid = correctNull((String) hshValues.get("cbsid"));
	String strmonth = correctNull((String)hshValues.get("mon_month"));
	String stryear = correctNull((String)hshValues.get("mon_year"));
	String Strmmrno=correctNull((String)hshValues.get("mmrno"));
	String strRecordFlag = Helper.correctNull((String)hshValues.get("hidAuditFlag"));
	
	
	try
	{
		if(strAction.equalsIgnoreCase("insert"))
		{
		hshQueryValues = new HashMap();
		hshQuery = new HashMap();					
		hshQueryValues.put("size","2");
		hshQuery.put("strQueryId","del_currentassetfinanced");
		arrValues.add(strcbsaccountno);
		arrValues.add(Strmmrno);
		
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);
		
		arrValues = new ArrayList();
		hshQuery = new HashMap();
		
		hshQuery.put("strQueryId","ins_currentassetfinanced");
		
		arrValues.add(strcbsid);
		arrValues.add(strcbsaccountno);
		arrValues.add(correctNull((String)hshValues.get("txt_banklast")));
		arrValues.add(correctNull((String)hshValues.get("txt_bankquater")));
		arrValues.add(correctNull((String)hshValues.get("txt_bankestimate")));
		arrValues.add(correctNull((String)hshValues.get("txt_sundrylast")));
		arrValues.add(correctNull((String)hshValues.get("txt_sundryquater")));
		arrValues.add(correctNull((String)hshValues.get("txt_sundryestimate")));
		arrValues.add(correctNull((String)hshValues.get("txt_otherlast")));
		arrValues.add(correctNull((String)hshValues.get("txt_otherquater")));
		arrValues.add(correctNull((String)hshValues.get("txt_otherestimate")));
		arrValues.add(correctNull((String)hshValues.get("txt_nwclast")));
		arrValues.add(correctNull((String)hshValues.get("txt_nwcquater")));
		arrValues.add(correctNull((String)hshValues.get("txt_nwcestimate")));
		arrValues.add(correctNull((String)hshValues.get("txt_totallast")));
		arrValues.add(correctNull((String)hshValues.get("txt_totalquater")));
		arrValues.add(correctNull((String)hshValues.get("txt_totalestimate")));
		
		arrValues.add(strmonth);
		arrValues.add(stryear);
		arrValues.add(Strmmrno);
		
		
		
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("2",hshQuery);	
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		if(strAction.equalsIgnoreCase("delete"))
		{
			hshQueryValues = new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			arrValues.add(strcbsaccountno);
			arrValues.add(Strmmrno);			
			hshQuery.put("strQueryId","del_currentassetfinanced");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		
		// Audit Trial
		/*StringBuilder sbAt = new StringBuilder();
		if(!strAction.equals("delete"))
		{
			sbAt.append("k.Bank Borrowings(e/d%) - At the end of last year =").append(correctNull((String)hshValues.get("txt_banklast")));
			sbAt.append("~ k.Bank Borrowings(e/d%) - At the current quarter ending =").append(correctNull((String)hshValues.get("txt_bankquater")));
			sbAt.append("~ k.Bank Borrowings(e/d%) - Estimates at the end of current year =").append(correctNull((String)hshValues.get("txt_bankestimate")));
			sbAt.append("~ l.Sundry Creditors(f/d%) - At the end of last year =").append(correctNull((String)hshValues.get("txt_sundrylast")));
			sbAt.append("~ l.Sundry Creditors(f/d%) - At the current quarter ending =").append(correctNull((String)hshValues.get("txt_sundryquater")));
			sbAt.append("~ l.Sundry Creditors(f/d%) - Estimates at the end of current year =").append(correctNull((String)hshValues.get("txt_sundryestimate")));
			sbAt.append("~ m.Other CLs(g/d%) - At the end of last year =").append(correctNull((String)hshValues.get("txt_otherlast")));
			sbAt.append("~ m.Other CLs(g/d%) - At the current quarter ending =").append(correctNull((String)hshValues.get("txt_otherquater")));
			sbAt.append("~ m.Other CLs(g/d%) - Estimates at the end of current year =").append(correctNull((String)hshValues.get("txt_otherestimate")));
			sbAt.append("~ n.NWC (i/d%) - At the end of last year =").append(correctNull((String)hshValues.get("txt_nwclast")));
			sbAt.append("~ n.NWC (i/d%) - At the current quarter ending =").append(correctNull((String)hshValues.get("txt_nwcquater")));
			sbAt.append("~ n.NWC (i/d%) - Estimates at the end of current year =").append(correctNull((String)hshValues.get("txt_nwcestimate")));
			sbAt.append("~ Total - At the end of last year =").append(correctNull((String)hshValues.get("txt_totallast")));
			sbAt.append("~ Total - At the current quarter ending =").append(correctNull((String)hshValues.get("txt_totalquater")));
			sbAt.append("~ Total - Estimates at the end of current year =").append(correctNull((String)hshValues.get("txt_totalestimate")));
			
			if(strRecordFlag.equalsIgnoreCase("Y")){
				hshValues.put("hidAction", "update");
			}else if(strRecordFlag.equalsIgnoreCase("N")){
				hshValues.put("hidAction", "insert");
			}
		}
		AuditTrial.auditLog(hshValues,"426",Strmmrno,sbAt.toString());*/
		
	}
	catch (Exception e)
	{
		throw new EJBException("Error in Insert Data " + e.getMessage());
	} finally
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
			throw new EJBException("Error closing in updateCurrentAssetfinanced"+cf.getMessage());						
		}
	}
}


	public 	HashMap getCurrentAssetfinanced(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
 		ResultSet rs = null;
 		
 		String strQuery="";
 		
 		int size=0;
		double totyear1=0.00,totyear2=0.00,totyear4=0.00;
		double eyear1=0.00,eyear2=0.00,eyear4=0.00;
		double fyear1=0.00,fyear2=0.00,fyear4=0.00;
		double gyear1=0.00,gyear2=0.00,gyear4=0.00;
		double iyear1=0.00,iyear2=0.00,iyear4=0.00;
		double kyear1=0.00,kyear2=0.00,kyear4=0.00;
		double lyear1=0.00,lyear2=0.00,lyear4=0.00;
		double myear1=0.00,myear2=0.00,myear4=0.00;
		double nyear1=0.00,nyear2=0.00,nyear4=0.00;
		
		double total1=0.00,total2=0.00,total4=0.00;
 		
 		boolean bstate =true;
 		boolean recordflag=false;
 		try
 		{
 			String straccno=correctNull((String)hshValues.get("mon_accno"));
 	 		//String stryear=correctNull((String)hshValues.get("mon_year"));
 			//String strmonth=correctNull((String)hshValues.get("mon_month"));
 			//String strcbsid =correctNull((String)hshValues.get("cbsid"));
 			String Strmmrno=correctNull((String)hshValues.get("mmrno"));
 			
 			String mon_msod=correctNull((String)hshValues.get("mon_msod"));
 			String mon_stock=correctNull((String)hshValues.get("mon_stock"));
 			String mon_bkdebts=correctNull((String)hshValues.get("mon_bkdebts"));
 			String mon_qpr=correctNull((String)hshValues.get("mon_qpr"));
 			
 		     	
 			strQuery=SQLParser.getSqlQuery("sel_workingcapitalfunds^"+straccno+"^"+Strmmrno);
 			rs=DBUtils.executeQuery(strQuery);
 			
 			bstate = rs.next();
 			if(bstate == true)
 			{
 				recordflag=true;
 				size=rs.getFetchSize();
 				do
 				{
	 				if(size==3) {
	 				
	 					totyear1=Double.parseDouble(Helper.correctDouble(rs.getString("mon_workyear1")));
	 					totyear2=Double.parseDouble(Helper.correctDouble(rs.getString("mon_workyear2")));
	 					totyear4=Double.parseDouble(Helper.correctDouble(rs.getString("mon_workyear4")));
	 				
	 				}
	 				else if(size==4) 
	 				{
	 					eyear1=Double.parseDouble(Helper.correctDouble(rs.getString("mon_workyear1")));
	 					eyear2=Double.parseDouble(Helper.correctDouble(rs.getString("mon_workyear2")));
	 					eyear4=Double.parseDouble(Helper.correctDouble(rs.getString("mon_workyear4")));
	 					if(!(eyear1==0.0 &&totyear1==0.0)){
	 						if(totyear1!=0.0){
	 							kyear1=eyear1/totyear1*100;
	 						}
	 					}
	 					if(!(eyear2==0.0 &&totyear2==0.0)){
	 						if(totyear2!=0.0){
	 							kyear2=eyear2/totyear2*100;
	 						}
	 					}
	 					if(!(eyear4==0.0 &&totyear4==0.0)){
	 						if(totyear4!=0.0){
	 							kyear4=eyear4/totyear4*100;
	 						}
	 					}
	 				}
	 				else if(size==5)
	 				{
	 					fyear1=Double.parseDouble(Helper.correctDouble(rs.getString("mon_workyear1")));
	 					fyear2=Double.parseDouble(Helper.correctDouble(rs.getString("mon_workyear2")));
	 					fyear4=Double.parseDouble(Helper.correctDouble(rs.getString("mon_workyear4")));
	 					
	 					if(!(lyear1==0.0 &&totyear1==0.0)){
	 						if(totyear1!=0.0){
	 							lyear1=fyear1/totyear1*100;
	 						}
	 					}
	 					if(!(lyear2==0.0 &&totyear2==0.0)){
	 						if(totyear2!=0.0){
	 							lyear2=fyear2/totyear2*100;
	 						}
	 					}
	 					if(!(lyear4==0.0 &&totyear4==0.0)){
	 						if(totyear4!=0.0){
 							lyear4=fyear4/totyear4*100;
 						}
 					}
	 			}
	 			else if(size==6){
 					gyear1=Double.parseDouble(Helper.correctDouble(rs.getString("mon_workyear1")));
 					gyear2=Double.parseDouble(Helper.correctDouble(rs.getString("mon_workyear2")));
 					gyear4=Double.parseDouble(Helper.correctDouble(rs.getString("mon_workyear4")));
 					
 					if(!(myear1==0.0 &&totyear1==0.0)){
 						if(totyear1!=0.0){
 							myear1=gyear1/totyear1*100;
 						}
 					}
 					if(!(myear2==0.0 &&totyear2==0.0)){
 						if(totyear2!=0.0){
 							myear2=gyear2/totyear2*100;
 						}
 					}
 					if(!(myear4==0.0 &&totyear4==0.0)){
 						if(totyear4!=0.0){
 							myear4=gyear4/totyear4*100;
 						}
 					}
 					
 				}else if(size==8){
 					iyear1=Double.parseDouble(Helper.correctDouble(rs.getString("mon_workyear1")));
 					iyear2=Double.parseDouble(Helper.correctDouble(rs.getString("mon_workyear2")));
 					iyear4=Double.parseDouble(Helper.correctDouble(rs.getString("mon_workyear4")));
 					
 					if(!(nyear1==0.0 &&totyear1==0.0)){
 						if(totyear1!=0.0){
 							nyear1=iyear1/totyear1*100;
 						}
 					}
 					if(!(nyear2==0.0 &&totyear2==0.0)){
 						if(totyear2!=0.0){
 							nyear2=iyear2/totyear2*100;
 						}
 					}
 					if(!(nyear4==0.0 &&totyear4==0.0)){
 						if(totyear4!=0.0){
 							nyear4=iyear4/totyear4*100;
 						}
 					}
 				}
 				
 				
 				
 				size++;
 				
 			}while(rs.next());
 			
 			
 			if(kyear1==0.0){
 				kyear1=0.00;
 			}
 			if(kyear2==0.0){
 				kyear2=0.00;
 			}
 			if(kyear4==0.0){
 				kyear4=0.00;
 			}
 			
 			hshResult.put("current_banklast",Helper.formatDoubleValue(kyear1));
			hshResult.put("current_bankquater",Helper.formatDoubleValue(kyear2));
			hshResult.put("current_bankestimate",Helper.formatDoubleValue(kyear4));
			
			
			if(lyear1==0.0){
				lyear1=0.00;
 			}
 			if(lyear2==0.0){
 				lyear2=0.00;
 			}
 			if(lyear4==0.0){
 				lyear4=0.00;
 			}
			
			hshResult.put("current_sundrylast",Helper.formatDoubleValue(lyear1));
			hshResult.put("current_sundryquater",Helper.formatDoubleValue(lyear2));
			hshResult.put("current_sundryestimate",Helper.formatDoubleValue(lyear4));
			
			if(myear1==0.0){
				myear1=0.00;
 			}
 			if(myear2==0.0){
 				myear2=0.00;
 			}
 			if(myear4==0.0){
 				myear4=0.00;
 			}
			
			hshResult.put("current_otherlast",Helper.formatDoubleValue(myear1));
			hshResult.put("current_otherquater",Helper.formatDoubleValue(myear2));
			hshResult.put("current_otherestimate",Helper.formatDoubleValue(myear4));
			
			if(nyear1==0.0){
				nyear1=0.00;
 			}
 			if(nyear2==0.0){
 				nyear2=0.00;
 			}
 			if(nyear4==0.0){
 				nyear4=0.00;
 			}
			
			hshResult.put("current_nwclast",Helper.formatDoubleValue(nyear1));
			hshResult.put("current_nwcquater",Helper.formatDoubleValue(nyear2));
			hshResult.put("current_nwcestimate",Helper.formatDoubleValue(nyear4));
			
			
 		 total1=kyear1+lyear1+myear1+nyear1;
 		 total2=kyear2+lyear2+myear2+nyear2;
		 total4=kyear4+lyear4+myear4+nyear4;	
		
		hshResult.put("current_totallast",Helper.formatDoubleValue(total1));
		hshResult.put("current_totalquater",Helper.formatDoubleValue(total2));
		hshResult.put("current_totalestimate",Helper.formatDoubleValue(total4));
		
			
			
			
 			}
 			hshResult.put("mon_msod",mon_msod);
			hshResult.put("mon_stock",mon_stock);
			hshResult.put("mon_bkdebts",mon_bkdebts);
			hshResult.put("mon_qpr",mon_qpr);
 			
 			
 			
 			if(rs!=null)rs.close();
 			if(recordflag)
				hshResult.put("recordflag","Y");
			else
				hshResult.put("recordflag","N");
 			
 		}catch (Exception exp){
 			
 			throw new EJBException("Error in getmonitoring"+exp.getMessage());
 			
 		}finally
 		{
 			try
 			{
 				if(rs!=null)
 					rs.close();
 			}catch(Exception exp)
 			{
 				throw new EJBException("Error in closing the connection in getmonitoring "+ exp.toString()); 
 			}
 		}
 		
 		return hshResult;
 	}

 	



// add by ramesh 

public void updateinventory(HashMap hshValues) 
{

    HashMap hshQueryValues=new HashMap();
	HashMap hshQuery=new HashMap();
	
	ArrayList arrValues= new ArrayList();
	ResultSet rs=null;
		
	String strAction =correctNull((String)hshValues.get("hidAction"));
	
	
	String strcbsaccountno =correctNull((String)hshValues.get("mon_accno"));
	String strcbsid = correctNull((String) hshValues.get("cbsid"));
	String strmonth = correctNull((String)hshValues.get("mon_month"));
	String stryear = correctNull((String)hshValues.get("mon_year"));
	
	String Strmmrno=correctNull((String)hshValues.get("mmrno"));
	String strRecordFlag = Helper.correctNull((String)hshValues.get("hidAuditFlag"));
	
	try
	{
		if(strAction.equalsIgnoreCase("insert"))
		{
		hshQueryValues = new HashMap();
		hshQuery = new HashMap();					
		hshQueryValues.put("size","2");
		hshQuery.put("strQueryId","del_inventory");
		arrValues.add(strcbsaccountno);
		arrValues.add(Strmmrno);
		
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);
		
		arrValues = new ArrayList();
		hshQuery = new HashMap();
		
		hshQuery.put("strQueryId","ins_inventory");
		
		arrValues.add(strcbsid);
		arrValues.add(strcbsaccountno);
		arrValues.add(correctNull((String)hshValues.get("txt_inlastyear")));
		arrValues.add(correctNull((String)hshValues.get("txt_inquarter")));
		arrValues.add(correctNull((String)hshValues.get("txt_incuryear")));
		
		arrValues.add(correctNull((String)hshValues.get("txt_reclastyear")));
		arrValues.add(correctNull((String)hshValues.get("txt_recquarter")));
		arrValues.add(correctNull((String)hshValues.get("txt_reccuryear")));
		
		arrValues.add(correctNull((String)hshValues.get("txt_sunlastyear")));
		arrValues.add(correctNull((String)hshValues.get("txt_sunquarter")));
		arrValues.add(correctNull((String)hshValues.get("txt_suncuryear")));
	
		arrValues.add(strmonth);
		arrValues.add(stryear);
		arrValues.add(Strmmrno);
		
		
		
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("2",hshQuery);	
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		if(strAction.equalsIgnoreCase("delete"))
		{
			hshQueryValues = new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			
			arrValues.add(strcbsaccountno);
			arrValues.add(Strmmrno);
			
			hshQuery.put("strQueryId","del_inventory");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		// Audit Trial
		StringBuilder sbAt = new StringBuilder();
		if(!strAction.equals("delete"))
		{
			sbAt.append("o.Inventory - At the end of last year =").append(correctNull((String)hshValues.get("txt_inlastyear")));
			sbAt.append("~ o.Inventory - At the current quarter ending =").append(correctNull((String)hshValues.get("txt_inquarter")));
			sbAt.append("~ o.Inventory - Estimates at the end of current year =").append(correctNull((String)hshValues.get("txt_incuryear")));
			sbAt.append("~ p.Receivables - At the end of last year =").append(correctNull((String)hshValues.get("txt_reclastyear")));
			sbAt.append("~ p.Receivables - At the current quarter ending =").append(correctNull((String)hshValues.get("txt_recquarter")));
			sbAt.append("~ p.Receivables - Estimates at the end of current year =").append(correctNull((String)hshValues.get("txt_reccuryear")));
			sbAt.append("~ q.Sundry Creditors - At the end of last year =").append(correctNull((String)hshValues.get("txt_sunlastyear")));
			sbAt.append("~ q.Sundry Creditors - At the current quarter ending =").append(correctNull((String)hshValues.get("txt_sunquarter")));
			sbAt.append("~ q.Sundry Creditors - Estimates at the end of current year =").append(correctNull((String)hshValues.get("txt_suncuryear")));
			
			if(strRecordFlag.equalsIgnoreCase("Y")){
				hshValues.put("hidAction", "update");
			}else if(strRecordFlag.equalsIgnoreCase("N")){
				hshValues.put("hidAction", "insert");
			}
		}
		AuditTrial.auditLog(hshValues,"427",Strmmrno,sbAt.toString());
	}
	catch (Exception e)
	{
		throw new EJBException("Error in Insert Data " + e.getMessage());
	} finally
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
			throw new EJBException("Error closing in updateinventory"+cf.getMessage());						
		}
	}
}



public HashMap getinventory(HashMap hshValues)
{
	HashMap hshResult=new HashMap();
	ResultSet rs = null;
	String strQuery="";
	
	//String stryear=correctNull((String)hshValues.get("mon_year"));
	//String strmonth=correctNull((String)hshValues.get("mon_month"));
	String straccno=correctNull((String)hshValues.get("mon_accno"));
	String Strmmrno=correctNull((String)hshValues.get("mmrno"));
	
	String mon_msod=correctNull((String)hshValues.get("mon_msod"));
	String mon_stock=correctNull((String)hshValues.get("mon_stock"));
	String mon_bkdebts=correctNull((String)hshValues.get("mon_bkdebts"));
	String mon_qpr=correctNull((String)hshValues.get("mon_qpr"));
	boolean recordflag=false;
	
	
	try
	{
		//String strcbsid=correctNull((String)hshValues.get("cbsid"));
		
		strQuery=SQLParser.getSqlQuery("sel_inventory^"+straccno+"^"+Strmmrno);
		rs=DBUtils.executeQuery(strQuery);
		while(rs.next())
			{
			recordflag=true;
		hshResult.put("mon_inlastyear",correctNull(rs.getString("mon_inlastyear")));
		hshResult.put("mon_inquarter",correctNull(rs.getString("mon_inquarter")));
		hshResult.put("mon_incuryear",correctNull(rs.getString("mon_incuryear")));
		
		hshResult.put("mon_reclastyear",correctNull(rs.getString("mon_reclastyear")));
		hshResult.put("mon_recquarter",correctNull(rs.getString("mon_recquarter")));
		hshResult.put("mon_reccuryear",correctNull(rs.getString("mon_reccuryear")));
		
		hshResult.put("mon_sunlastyear",correctNull(rs.getString("mon_sunlastyear")));
		hshResult.put("mon_sunquarter",correctNull(rs.getString("mon_sunquarter")));
		hshResult.put("mon_suncuryear",correctNull(rs.getString("mon_suncuryear")));
		
		
		
		}			
		
		    hshResult.put("mon_msod",mon_msod);
			hshResult.put("mon_stock",mon_stock);
			hshResult.put("mon_bkdebts",mon_bkdebts);
			hshResult.put("mon_qpr",mon_qpr);	
			
			if(recordflag)
				hshResult.put("recordflag","Y");
			else
				hshResult.put("recordflag","N");
	
	}catch (Exception exp){
		
		throw new EJBException("Error in getmonitoring"+exp.getMessage());
		
	}finally
	{
		try
		{
			if(rs!=null)
				rs.close();
		}catch(Exception exp)
		{
			throw new EJBException("Error in closing the connection in getmonitoring "+ exp.toString()); 
		}
	}
	
	return hshResult;
}




// end

// add by rameh for workingcapitalfunds details
public void updateworkingcapitalfunds(HashMap hshRequestValues) {
	
	HashMap hshQuery=new HashMap();
	ArrayList arrValues=new ArrayList();
	HashMap hshQueryValues=new HashMap();
	ResultSet rs=null;
	
	
	String cbsid=correctNull((String)hshRequestValues.get("cbsid"));
	
	String strAction =correctNull((String)hshRequestValues.get("hidAction"));
	
	
	String straccno =correctNull((String)hshRequestValues.get("mon_accno"));
	
	String strmonth = correctNull((String)hshRequestValues.get("mon_month"));
	String stryear = correctNull((String)hshRequestValues.get("mon_year"));
	String Strmmrno=correctNull((String)hshRequestValues.get("mmrno"));
	String strRecordFlag = Helper.correctNull((String)hshRequestValues.get("hidAuditFlag"));
	
	String[] year1 = null;
	String[] year2 = null;
	String[] yearsub = null;
	String[] year4 = null;
	
	int intUpdatesize = 0;
	try
	{		
		year1 = (String[]) hshRequestValues.get("txt_monyear1");
		year2 = (String[])hshRequestValues.get("txt_monyear2");
		yearsub	 = (String[])hshRequestValues.get("txt_monyearsub");
		year4 = (String[])hshRequestValues.get("txt_monyear4");
		
		
		if(strAction.equalsIgnoreCase("insert"))
		{
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues=new HashMap();
			hshQuery.put("size", "1");
			hshQuery.put("strQueryId", "delworkingcapitalfunds");
			//arrValues.add(cbsid);
			arrValues.add(straccno);
			//arrValues3.add(strmonth);
			//arrValues3.add(stryear);
			arrValues.add(Strmmrno);
		
			
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			hshQueryValues.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
			intUpdatesize = 1;
			
			
			for (int i = 0; i < year1.length; i++)
			{
				intUpdatesize = intUpdatesize + 1;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues=new HashMap();
				hshQuery.put("strQueryId", "ins_workingcapitalfunds");
				
				arrValues.add(cbsid);
				arrValues.add(straccno);
				arrValues.add(strmonth);
				arrValues.add(stryear);
				
				if(year1[i].equalsIgnoreCase("")||year1[i].equalsIgnoreCase("Infinity")||year1[i].equalsIgnoreCase("NaN"))
				{
					year1[i] = "0.00";
				}
				arrValues.add(year1[i]);
				if(year2[i].equalsIgnoreCase("")||year2[i].equalsIgnoreCase("Infinity")||year2[i].equalsIgnoreCase("NaN"))
				{
					year2[i] = "0.00";
				}
				arrValues.add(year2[i]);
				if(yearsub[i].equalsIgnoreCase("")||yearsub[i].equalsIgnoreCase("Infinity")||yearsub[i].equalsIgnoreCase("NaN"))
				{
					yearsub[i] = "0.00";
				}
				arrValues.add(yearsub[i]);
				if(year4[i].equalsIgnoreCase("")||year4[i].equalsIgnoreCase("Infinity")||year4[i].equalsIgnoreCase("NaN"))
				{
					year4[i] = "0.00";
				}
				arrValues.add(year4[i]);
				arrValues.add(Strmmrno);
				
				
			
				hshQuery.put("arrValues", arrValues);	
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
			}	
		}
		else if(strAction.equalsIgnoreCase("delete"))
		{
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues=new HashMap();
			hshQuery.put("size", "1");
			hshQuery.put("strQueryId", "delworkingcapitalfunds");
			
			arrValues.add(straccno);
			arrValues.add(Strmmrno);
					
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			hshQueryValues.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
		}
		// Audit Trial
		StringBuilder sbAt = new StringBuilder();
		if(!strAction.equals("delete"))
		{
			
			for (int i = 0; i < year1.length; i++)
			{
				if(i==0)
				{
					sbAt.append("Current Assets(CA)  </b>");
					sbAt.append("~ a)Inventory - At the end of last year(1)  =").append(year1[i]);
					sbAt.append("~ a)Inventory - At the current quarter ending(2)  =").append(year2[i]);
					sbAt.append("~ a)Inventory - Change during the current year(2)-(1)  =").append(yearsub[i]);
					sbAt.append("~ a)Inventory - Estimates of the end of the current year(4)  =").append(year4[i]);
				}
				if(i==1)
				{
					sbAt.append("~ b)Receivables - At the end of last year(1)  =").append(year1[i]);
					sbAt.append("~ b)Receivables - At the current quarter ending(2)  =").append(year2[i]);
					sbAt.append("~ b)Receivables - Change during the current year(2)-(1)  =").append(yearsub[i]);
					sbAt.append("~ b)Receivables - Estimates of the end of the current year(4)  =").append(year4[i]);
				}
				if(i==2)
				{
					sbAt.append("~ c)Other CA - At the end of last year(1)  =").append(year1[i]);
					sbAt.append("~ c)Other CA - At the current quarter ending(2)  =").append(year2[i]);
					sbAt.append("~ c)Other CA - Change during the current year(2)-(1)  =").append(yearsub[i]);
					sbAt.append("~ c)Other CA - Estimates of the end of the current year(4)  =").append(year4[i]);
				}
				if(i==3)
				{
					sbAt.append("~ d)TOTAL CA - At the end of last year(1)  =").append(year1[i]);
					sbAt.append("~ d)TOTAL CA - At the current quarter ending(2)  =").append(year2[i]);
					sbAt.append("~ d)TOTAL CA - Change during the current year(2)-(1)  =").append(yearsub[i]);
					sbAt.append("~ d)TOTAL CA - Estimates of the end of the current year(4)  =").append(year4[i]);
				}
				if(i==4)
				{
					sbAt.append("~ Current Liabilities(CL)  </b>");
					sbAt.append("~ e)Bank Borrowings for WC - At the end of last year(1)  =").append(year1[i]);
					sbAt.append("~ e)Bank Borrowings for WC - At the current quarter ending(2)  =").append(year2[i]);
					sbAt.append("~ e)Bank Borrowings for WC - Change during the current year(2)-(1)  =").append(yearsub[i]);
					sbAt.append("~ e)Bank Borrowings for WC - Estimates of the end of the current year(4)  =").append(year4[i]);
				}
				if(i==5)
				{
					sbAt.append("~ f)Sundry Creditors - At the end of last year(1)  =").append(year1[i]);
					sbAt.append("~ f)Sundry Creditors - At the current quarter ending(2)  =").append(year2[i]);
					sbAt.append("~ f)Sundry Creditors - Change during the current year(2)-(1)  =").append(yearsub[i]);
					sbAt.append("~ f)Sundry Creditors - Estimates of the end of the current year(4)  =").append(year4[i]);
				}
				if(i==6)
				{
					sbAt.append("~ g)Other CL - At the end of last year(1)  =").append(year1[i]);
					sbAt.append("~ g)Other CL - At the current quarter ending(2)  =").append(year2[i]);
					sbAt.append("~ g)Other CL - Change during the current year(2)-(1)  =").append(yearsub[i]);
					sbAt.append("~ g)Other CL - Estimates of the end of the current year(4)  =").append(year4[i]);
				}
				if(i==7)
				{
					sbAt.append("~ h)TOTAL CL - At the end of last year(1)  =").append(year1[i]);
					sbAt.append("~ h)TOTAL CL - At the current quarter ending(2)  =").append(year2[i]);
					sbAt.append("~ h)TOTAL CL - Change during the current year(2)-(1)  =").append(yearsub[i]);
					sbAt.append("~ h)TOTAL CL - Estimates of the end of the current year(4)  =").append(year4[i]);
				}
				if(i==8)
				{
					sbAt.append("~ i)NWC(d-h) - At the end of last year(1)  =").append(year1[i]);
					sbAt.append("~ i)NWC(d-h) - At the current quarter ending(2)  =").append(year2[i]);
					sbAt.append("~ i)NWC(d-h) - Change during the current year(2)-(1)  =").append(yearsub[i]);
					sbAt.append("~ i)NWC(d-h) - Estimates of the end of the current year(4)  =").append(year4[i]);
				}
				if(i==9)
				{
					sbAt.append("~ j)Current ratio(d/h) - At the end of last year(1)  =").append(year1[i]);
					sbAt.append("~ j)Current ratio(d/h) - At the current quarter ending(2)  =").append(year2[i]);
					sbAt.append("~ j)Current ratio(d/h) - Change during the current year(2)-(1)  =").append(yearsub[i]);
					sbAt.append("~ j)Current ratio(d/h) - Estimates of the end of the current year(4)  =").append(year4[i]);
				}
			}
			if(strRecordFlag.equalsIgnoreCase("Y")){
				hshRequestValues.put("hidAction", "update");
			}else if(strRecordFlag.equalsIgnoreCase("N")){
				hshRequestValues.put("hidAction", "insert");
			}
		}
		AuditTrial.auditLog(hshRequestValues,"425",Strmmrno,sbAt.toString());
	}catch(Exception e)
	{
		throw new EJBException("Error in updatemonitoring Statement"+e.getMessage());
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
			throw new EJBException("Error closing in the updatemonitoring Statement connection "+cf.getMessage());
					
		}
	}

	
}

public HashMap getworkingcapitalfunds(HashMap hshValues)
{
	HashMap hshResult=new HashMap();
	ResultSet rs = null;
	
	ArrayList vecRow=new ArrayList();
	
	String strQuery="";
	
	boolean bstate =true;
	ArrayList vecData = new ArrayList();
	
	
	String mon_msod=correctNull((String)hshValues.get("mon_msod"));
	String mon_stock=correctNull((String)hshValues.get("mon_stock"));
	String mon_bkdebts=correctNull((String)hshValues.get("mon_bkdebts"));
	String mon_qpr=correctNull((String)hshValues.get("mon_qpr"));
	
	if(mon_qpr.equalsIgnoreCase(""))
	{
		mon_qpr=correctNull((String)hshValues.get("mon_checkqpr"));
	}
	boolean recordflag=false;
	
	try
	{
		String straccno=correctNull((String)hshValues.get("mon_accno"));
		String Strmmrno=correctNull((String)hshValues.get("mmrno"));
 		//String stryear=correctNull((String)hshValues.get("mon_year"));
		//String strmonth=correctNull((String)hshValues.get("mon_month"));
		//String strcbsid =correctNull((String)hshValues.get("cbsid"));
		
	     	hshResult.put("mon_msod",mon_msod);
			hshResult.put("mon_stock",mon_stock);
			hshResult.put("mon_bkdebts",mon_bkdebts);
			hshResult.put("mon_qpr",mon_qpr);
		
	
		strQuery=SQLParser.getSqlQuery("sel_workingcapitalfunds^"+straccno+"^"+Strmmrno);
		rs=DBUtils.executeQuery(strQuery);

		int size=0;
		bstate = rs.next();
		if(bstate == true)
		{
			recordflag=true;
			size=rs.getFetchSize();
			do
			{
				vecRow = new ArrayList();
				
				if(correctNull(rs.getString("mon_workyear1")).equalsIgnoreCase("0.00"))
				{
					vecRow.add("");
				}
				else
				{
					vecRow.add(correctNull(rs.getString("mon_workyear1")));
				}
				
				if(correctNull(rs.getString("mon_workyear2")).equalsIgnoreCase("0.00"))
				{
					vecRow.add("");
				}
				else
				{
					vecRow.add(correctNull(rs.getString("mon_workyear2")));
				}
				
				if(correctNull(rs.getString("mon_workyearsub")).equalsIgnoreCase("0.00"))
				{
					vecRow.add("");
				}
				else
				{
					vecRow.add(correctNull(rs.getString("mon_workyearsub")));
				}
			
				if(correctNull(rs.getString("mon_workyear4")).equalsIgnoreCase("0.00"))
				{
					vecRow.add("");
				}
				else
				{
					vecRow.add(correctNull(rs.getString("mon_workyear4")));
				}
			
				vecData.add(vecRow);
				size++;
			}while(rs.next());
		}
		if(vecData==null || vecData.size()==0)
		{
			for(int i=0;i<4;i++){
				vecData.add("");
			}
		}
		
		hshResult.put("vecData",vecData);
		hshResult.put("intyearsize","10");
		hshResult.put("strqpr","strqpr");
		if(rs!=null)rs.close();
		strQuery = SQLParser.getSqlQuery("sel_monchecklist^"+straccno);
		rs = DBUtils.executeQuery(strQuery);	
		if (rs.next())
		{ 
			hshResult.put("mon_checkmsod",correctNull(rs.getString("mon_checkmsod")));
			hshResult.put("mon_checkstock",correctNull(rs.getString("mon_checkstock")));
			hshResult.put("mon_checkbkdebts",correctNull(rs.getString("mon_checkbkdebts")));
			hshResult.put("mon_checkqpr",correctNull(rs.getString("mon_checkqpr")));
			
		}
		if(recordflag)
			hshResult.put("recordflag","Y");
		else
			hshResult.put("recordflag","N");
	}catch (Exception exp){
		
		throw new EJBException("Error in getmonitoring"+exp.getMessage());
		
	}finally
	{
		try
		{
			if(rs!=null)
				rs.close();
		}catch(Exception exp)
		{
			throw new EJBException("Error in closing the connection in getmonitoring "+ exp.toString()); 
		}
	}
	
	return hshResult;
}

// add  by ramesh for getting report details
public 	HashMap getstockReport(HashMap hshValues)
{
	HashMap hshResult=new HashMap();
	ResultSet rs=null;
	ResultSet rs1=null;
	ArrayList vecCol=new ArrayList();
	ArrayList vecRow=new ArrayList();
	String strQuery ="";
	String strstocktype="";
	
	
	try
	{
		String straccno=correctNull((String)hshValues.get("accno"));
 		String stryear=correctNull((String)hshValues.get("year"));
		String strmonth=correctNull((String)hshValues.get("month"));
		String strcbsid =correctNull((String)hshValues.get("cbsid"));
		
		
			
		strQuery = SQLParser.getSqlQuery("selstockeligible^"+strcbsid+"^"+straccno+"^"+strmonth+"^"+stryear);
		rs = DBUtils.executeQuery(strQuery);	
		if (rs.next())
		{ 
			hshResult.put("mmr_cbsid",correctNull(rs.getString("mmr_cbsid")));
			hshResult.put("mmr_cbsaccountno",correctNull(rs.getString("mmr_cbsaccountno")));
			hshResult.put("mmr_stocklc",correctNull(rs.getString("mmr_stocklc")));
			hshResult.put("mmr_stockcreditor",correctNull(rs.getString("mmr_stockcreditor")));
			hshResult.put("mmr_totalunpaidstock",correctNull(rs.getString("mmr_totalunpaidstock")));
			hshResult.put("mmr_stocknotdp",correctNull(rs.getString("mmr_stocknotdp")));
			hshResult.put("mmr_otherasset",correctNull(rs.getString("mmr_otherasset")));
			hshResult.put("mmr_packingcredit",correctNull(rs.getString("mmr_packingcredit")));
			hshResult.put("mmr_stockearmarked",correctNull(rs.getString("mmr_stockearmarked")));
			hshResult.put("mmr_totalstock",correctNull(rs.getString("mmr_totalstock")));
			hshResult.put("mmr_stockeligible",correctNull(rs.getString("mmr_stockeligible")));
			hshResult.put("mmrdays",correctNull(rs.getString("mmrdays")));
			hshResult.put("mmr_month",correctNull(rs.getString("mmr_month")));
			hshResult.put("mmr_year",correctNull(rs.getString("mmr_year")));
			
			
		}
			
		
		if(rs!=null)
		{
			rs.close();
		}
		
		strQuery=SQLParser.getSqlQuery("sel_stockstatement^"+strcbsid+"^"+straccno+"^"+strmonth+"^"+stryear);
 		rs=DBUtils.executeQuery(strQuery);
 		while(rs.next())
 			{
 				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString("stock_sno")));
				vecCol.add(correctNull(rs.getString("stock_accno")));
				
				
				
				strstocktype=correctNull(rs.getString("stock_type"));
			//	vecCol.add(correctNull(rs.getString("stock_type")));
				
				
				
				strQuery = SQLParser.getSqlQuery("sel_printstatement^"+"39"+"^"+straccno+"^"+strcbsid+"^"+strstocktype);	
				rs1 = DBUtils.executeQuery(strQuery);
			
				if (rs1.next()) 
				{				
					//vecRec1=new ArrayList();
					vecCol.add(correctNull(rs1.getString("stat_data_desc1")));
					//vecData.add(vecRec1);				
				}	
				if (rs1 != null) 
				{
					rs1.close();					 
				}
				
				
				
				
				
				vecCol.add(correctNull(rs.getString("stock_desc")));
				vecCol.add(correctNull(rs.getString("stock_storplace")));
				vecCol.add(correctNull(rs.getString("stock_noofpackage")));
				vecCol.add(correctNull(rs.getString("stock_quantity")));
				vecCol.add(correctNull(rs.getString("stock_rate")));
				vecCol.add(correctNull(rs.getString("stock_value")));
				vecRow.add(vecCol);
			}			
 			hshResult.put("vecRow",vecRow);
 	
 			if(rs!=null)
 			{
 				rs.close();
 			}
		strQuery = SQLParser.getSqlQuery("selstocktotal^"+strcbsid+"^"+straccno+"^"+strmonth+"^"+stryear);
		rs = DBUtils.executeQuery(strQuery);
		double stockvalue=0.00;
		
		double temp=0.00;
		
		String strtotalvalue="";
		double margin=0.00;
		double marginpercent=0.00;
		double amount=0.00;
		while (rs.next())
		{ 
			stockvalue=Double.parseDouble(Helper.correctDouble(rs.getString("stock_value")));
			temp+=stockvalue;
			//mmr_total=Double.parseDouble(Helper.correctDouble(rs.getString("mmr_totalstock")));
			//totalvalue=stockvalue-mmr_total;
				
			
		}
		strtotalvalue=Helper.formatDoubleValue(temp);
		hshResult.put("totalvalue",strtotalvalue);
		
		if(rs!=null)
		{
			rs.close();
		}
		
		rs=DBUtils.executeLAPSQuery("sel_monlimitregister^"+straccno);
		if(rs.next())

		{
					
				amount=Double.parseDouble(Helper.correctDouble(rs.getString("limit_sanctamt")));
				
				margin=Double.parseDouble(Helper.correctDouble(rs.getString("limit_margin")));
				
				marginpercent=margin/amount*100;
				String s=Helper.formatDoubleValue(marginpercent);
				
				hshResult.put("marginpercent",s.substring(0,2));
				
		
		}
		if(rs!=null){
			rs.close();
		}
		
		strQuery=SQLParser.getSqlQuery("selconsortium1^"+strcbsid);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			
			hshResult.put("cons_bankname",correctNull(rs.getString("cons_bankname")));
			hshResult.put("cons_pershare",correctNull(rs.getString("cons_pershare")));
			
		}
	
		if(rs!=null){
			rs.close();
		}
		
		

		
		
	}
	catch(Exception ce)
	{
		throw new EJBException("Error in getBookdebitseligible-- "+ce.toString());
	}
	finally
	{
		try
		{	if(rs != null)
				rs.close();
			if(rs1 != null)
				rs1.close();
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	return hshResult;
		
}


//end

//add by ramesh for Book print statement

public HashMap getBookprint(HashMap hshValues) 
{
	HashMap hshRecord=new HashMap();
	String strQuery="";
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	ResultSet rs = null;
	double bkdbtolderamount=0.00,bkdbdiscountamount=0.00,bkdbfactoramount=0.00,bkdbdoubtfulamount=0.00;
	double bkdbassociateamount=0.00,bkdbfinanceamount=0.00,bkdbtotaleligibleamount=0.00;
	
	//String strcbsid =correctNull((String)hshValues.get("cbsid"));
	//String stryear=correctNull((String)hshValues.get("year"));
	//String strmonth=correctNull((String)hshValues.get("month"));
	String straccno=correctNull((String)hshValues.get("accno"));
	String Strmmrno=correctNull((String)hshValues.get("mmrno"));
	try
	{
		double mon_marginbookdebt=0.00,mon_marginbookdebtpercent=0.00,mon_totaldrawing=0.00,temptotal=0.00;
		rs=DBUtils.executeLAPSQuery("sel_monlimitregister^"+straccno);
		if(rs.next())
		{
			mon_marginbookdebt = Double.parseDouble(Helper.correctDouble(rs.getString("mon_marginbookdebt")));
			
		}
		hshRecord.put("mon_marginbookdebt",""+mon_marginbookdebt);
		strQuery=SQLParser.getSqlQuery("selbookdebits^"+straccno+"^"+Strmmrno);
		rs=DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			arrCol = new ArrayList();
			arrCol.add(correctNull(rs.getString("mmr_propertyname")));
			arrCol.add(correctNull(rs.getString("mmr_invoicedate")));
			arrCol.add(correctNull(rs.getString("mmr_uptoninetyamount")));
			arrCol.add(correctNull(rs.getString("mmr_uptooneeightyamount")));
			arrCol.add(correctNull(rs.getString("mmr_abvoneeightyamount")));
			arrCol.add(correctNull(rs.getString("mmr_totalamount")));
			
			temptotal = Double.parseDouble(Helper.correctDouble(rs.getString("mmr_totalamount")));
			
			arrRow.add(arrCol);
		}			
		hshRecord.put("arrRow",arrRow);
		
		strQuery = SQLParser.getSqlQuery("selbookdebitseligible^"+straccno+"^"+Strmmrno);
		rs = DBUtils.executeQuery(strQuery);	
		if (rs.next()){
			hshRecord.put("mmr_cbsaccountno",correctNull(rs.getString("mmr_cbsaccountno")));
			hshRecord.put("mmr_bkdbtolderamount",correctNull(rs.getString("mmr_bkdbtolderamount")));
			hshRecord.put("mmr_bkdbdiscountamount",correctNull(rs.getString("mmr_bkdbdiscountamount")));
			hshRecord.put("mmr_bkdbfactoramount",correctNull(rs.getString("mmr_bkdbfactoramount")));
			hshRecord.put("mmr_bkdbdoubtfulamount",correctNull(rs.getString("mmr_bkdbdoubtfulamount")));
			hshRecord.put("mmr_bkdbassociateamount",correctNull(rs.getString("mmr_bkdbassociateamount")));
			hshRecord.put("mmr_bkdbfinanceamount",correctNull(rs.getString("mmr_bkdbfinanceamount")));
			
			 bkdbtolderamount=Double.parseDouble(Helper.correctDouble(rs.getString("mmr_bkdbtolderamount")));
			
			 bkdbdiscountamount=Double.parseDouble(Helper.correctDouble(rs.getString("mmr_bkdbdiscountamount")));
			 bkdbfactoramount=Double.parseDouble(Helper.correctDouble(rs.getString("mmr_bkdbfactoramount")));
			 bkdbdoubtfulamount=Double.parseDouble(Helper.correctDouble(rs.getString("mmr_bkdbdoubtfulamount")));
			 bkdbassociateamount=Double.parseDouble(Helper.correctDouble(rs.getString("mmr_bkdbassociateamount")));
			
			 bkdbfinanceamount=Double.parseDouble(Helper.correctDouble(rs.getString("mmr_bkdbfinanceamount")));
			
			
			 bkdbtotaleligibleamount=bkdbtolderamount+bkdbdiscountamount+bkdbfactoramount+bkdbdoubtfulamount+bkdbassociateamount+bkdbfinanceamount;
			 
			 temptotal = temptotal - bkdbtotaleligibleamount;
			 
			 mon_marginbookdebtpercent = (mon_marginbookdebt/100) * temptotal;
			 
			 mon_totaldrawing = temptotal - mon_marginbookdebtpercent;
			 
			 hshRecord.put("mon_totaldrawing",Helper.formatDoubleValue(mon_totaldrawing)); 
			 
			 hshRecord.put("mon_marginbookdebtpercent",Helper.formatDoubleValue(mon_marginbookdebtpercent)); 
			 
			hshRecord.put("mmr_bkdbtotaleligibleamount",Helper.formatDoubleValue(bkdbtotaleligibleamount));
		//hshResult.put("mmr_month",correctNull(rs.getString("mmr_month")));
		//hshResult.put("mmr_year",correctNull(rs.getString("mmr_year")));
	}
	
	if(rs!=null)
	{
		rs.close();
	}
		
		
		
	}
	catch(Exception e1)
	{
		throw new EJBException("Error in getDocumentRegister :: "+e1.getMessage());
	}
	finally
	{
		try
		{
			if(rs!=null)
			{
				rs.close();
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	return hshRecord;
}

/* This method is added to get information 
* about borrower from  mon_personinfo table from DB to display
* in Borrower Info page
*/
public HashMap getBorrowerinfo(HashMap hshValues) 
{
	HashMap	hshBorrowinfo	=	null;
	ResultSet	rset		=	null;
	String	strQuery		=	null;
	String	cbsid			=	correctNull((String)hshValues.get("hidcbsid"));
	//String strmonth = correctNull((String)hshValues.get("mon_month"));
	//String stryear = correctNull((String)hshValues.get("mon_year"));
	String Strmmrno=correctNull((String)hshValues.get("mmrno"));
	boolean recordflag=false;
	try
	{
		hshBorrowinfo	=	new	HashMap();
		if(cbsid.equals(""))
		{
			cbsid=correctNull((String)hshValues.get("cbsid"));
		}
		strQuery=SQLParser.getSqlQuery("sel_personalinfo^"+cbsid);
		rset	=	DBUtils.executeQuery(strQuery);
		if(rset.next())
		{
			hshBorrowinfo.put("cbsid",(correctNull((String)rset.getString("PERSONAL_CBSID"))));
			hshBorrowinfo.put("name",(correctNull((String)rset.getString("PERSONAL_CUSTNAME"))));
			hshBorrowinfo.put("branch",(correctNull((String)rset.getString("PERSONAL_SOLID"))));
			hshBorrowinfo.put("activity",(correctNull((String)rset.getString("PERSONAL_NATOFACTIVITY"))));
			hshBorrowinfo.put("address",(correctNull((String)rset.getString("PERSONAL_ADDRESS"))));
			hshBorrowinfo.put("address1",(correctNull((String)rset.getString("PERSONAL_ADDRESS1"))));
			hshBorrowinfo.put("city",(correctNull((String)rset.getString("city"))));
			hshBorrowinfo.put("state",(correctNull((String)rset.getString("state"))));
			hshBorrowinfo.put("pincode",(correctNull((String)rset.getString("PERSONAL_PINCODE"))));
			hshBorrowinfo.put("phoneno",(correctNull((String)rset.getString("PERSONAL_PHONE"))));
			hshBorrowinfo.put("mobile",(correctNull((String)rset.getString("PERSONAL_MOBILE"))));
			hshBorrowinfo.put("constitution",(correctNull((String)rset.getString("PERSONAL_CONSTITUTION"))));
			hshBorrowinfo.put("since",(correctNull((String)rset.getString("PERSONAL_BANKINGSINCE"))));
		}
		
		strQuery=SQLParser.getSqlQuery("sel_borrowerinfo_detail^"+Strmmrno);
		rset=DBUtils.executeQuery(strQuery);
		if(rset.next())
		{
			recordflag=true;
			hshBorrowinfo.put("arrange",(correctNull((String)rset.getString("borrower_bankarrangement"))));
			hshBorrowinfo.put("contactname",(correctNull((String)rset.getString("borrower_contactname"))));
			hshBorrowinfo.put("contact_per_design",(correctNull((String)rset.getString("borrower_contperdesign"))));
			hshBorrowinfo.put("contact_landline",(correctNull((String)rset.getString("borrower_landline"))));
			hshBorrowinfo.put("contact_mobile",(correctNull((String)rset.getString("borrower_contpermobile"))));
			hshBorrowinfo.put("personal_leadbankvetted",(correctNull((String)rset.getString("borrower_leadbankvetted"))));
			hshBorrowinfo.put("personal_stipdocuments",(correctNull((String)rset.getString("borrower_stipdocuments"))));
		}	

		//hshBorrowinfo.put("mon_year",stryear);
		//hshBorrowinfo.put("mon_month",strmonth);
		if(recordflag)
			hshBorrowinfo.put("recordflag","Y");
		else
			hshBorrowinfo.put("recordflag","N");
						
	}
	catch(Exception e)
	{
		throw new EJBException("Error in getBorrowerinfo  :: "+ e.getMessage());
	}
	finally
	{
		try
		{
			if(rset!=null)
			{
				rset.close();
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	return hshBorrowinfo;
}

public 	HashMap getDPexcludingPC(HashMap hshValues)
{
	HashMap hshResult=new HashMap();
	ResultSet rs=null;
	String strQuery ="";
	double margin=0.00;
	//double amount=0.00;
	//double marginpercent=0.00;
	String strcbsid =correctNull((String)hshValues.get("cbsid"));
	//String stryear=correctNull((String)hshValues.get("year"));
	//String strmonth=correctNull((String)hshValues.get("month"));
	String straccno=correctNull((String)hshValues.get("accno"));
	
	String strmmrno=correctNull((String)hshValues.get("mmrno"));

	try
	{
		strQuery = SQLParser.getSqlQuery("selstockgrandtotal^"+straccno+"^"+strmmrno);
		rs = DBUtils.executeQuery(strQuery);	
		if (rs.next())
		{ 
			
			hshResult.put("grand_total",correctNull(rs.getString("grand_total")));
			
		}
		strQuery = SQLParser.getSqlQuery("selstockeligible^"+straccno+"^"+strmmrno);
		rs = DBUtils.executeQuery(strQuery);	
		if (rs.next())
		{
			hshResult.put("mmr_totalstock",correctNull(rs.getString("mmr_totalstock")));
			
			hshResult.put("mmr_totalunpaidstock",correctNull(rs.getString("mmr_totalunpaidstock")));
		}
		
		
		
		
		if(rs!=null)
		{
			rs.close();
		}
		
		strQuery = SQLParser.getSqlQuery("sel_monlimitregister^"+straccno);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())

		{
					
				//amount=Double.parseDouble(Helper.correctDouble(rs.getString("limit_sanctamt")));
				//Logger.log("Amount---->"+amount);
				margin=Double.parseDouble(Helper.correctDouble(rs.getString("limit_margin")));
				//Logger.log("margin---->"+margin);
//				marginpercent=margin/amount*100;
//				Logger.log("marginpercent---->"+marginpercent);
//				String s=Helper.formatDoubleValue(marginpercent);
				
				hshResult.put("marginpercent",Helper.formatDoubleValue(margin));
				
		
		}
		if(rs!=null){
			rs.close();
		}
		
		strQuery=SQLParser.getSqlQuery("selconsortium1^"+strcbsid);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			
			hshResult.put("mmr_bankname",correctNull(rs.getString("mmr_bankname")));
			hshResult.put("mmr_sharepercent",correctNull(rs.getString("mmr_sharepercent")));
			
		}
		
	}
	catch(Exception ce)
	{
		throw new EJBException("Error in getDPexcludingPC-- "+ce.toString());
	}
	finally
	{
		try
		{	if(rs != null)
				rs.close();
			
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	return hshResult;
		
}

public HashMap getMonfacility(HashMap hshValues)
{	HashMap hshRecord=new HashMap();
	//ResultSet rs2=null;
	ResultSet rs=null;
	//ResultSet rs1=null;
	String cbsid=correctNull((String)hshValues.get("cbsid"));
	ArrayList arrRow=new ArrayList();
	ArrayList arrCol=null;
	//String facility="";
	double sanction_amount = 0.00,os_amount=0.00,grandsanction_amount=0.00,grandos_amount=0.00;
	String mon_month=correctNull((String)hshValues.get("mon_month"));
	if(mon_month.equalsIgnoreCase(""))
	{
		mon_month=correctNull((String)hshValues.get("mon_smonth"));
	}
	String mon_year=correctNull((String)hshValues.get("mon_year"));
	if(mon_year.equalsIgnoreCase(""))
	{
		mon_year=correctNull((String)hshValues.get("mon_syear"));
	}
	
	String strEXI=correctNull((String)hshValues.get("hidEXCheck"));
	//String strExists="N";
	String strQuery="";
	String mon_cbsname=correctNull((String)hshValues.get("mon_cbsname"));
	//String strSolid=correctNull((String)hshValues.get("solid"));
	if(mon_cbsname.equalsIgnoreCase(""))
	{
		mon_cbsname=correctNull((String)hshValues.get("cbsname"));
	}
	int intmaxmonth=1;
	int intmaxyear=0;
	String strCanPrepare="Y";
	String strReason="";
	try
	{
		if(strEXI.equalsIgnoreCase("EXI"))
		{
			Calendar cal = Calendar.getInstance();
			
			String strSysMonth = String.valueOf(cal.get(Calendar.MONTH) + 1);
			String strSysYear = String.valueOf(cal.get(Calendar.YEAR));

			if(Integer.parseInt(mon_year)==Integer.parseInt(strSysYear) && Integer.parseInt(mon_month)>=Integer.parseInt(strSysMonth))
			{
				strCanPrepare="N";
				strReason="You are not allowed to create MMR of a particular month befor expiry of the month";
			}
			else if(Integer.parseInt(mon_year)>Integer.parseInt(strSysYear))
			{
				strCanPrepare="N";
				strReason="You are not allowed to create MMR of a particular month befor expiry of the month";
			}

			if(strCanPrepare.equals("Y"))
			{
				//boolean flag = false;
				strQuery = SQLParser.getSqlQuery("getSearchData^"+cbsid+"^"+mon_month+"^"+mon_year);
				rs = DBUtils.executeQuery(strQuery);	
				if(rs.next())
				{
					//strExists="Y";
					strCanPrepare="N";
					strReason="Data Already Exists for "+ Helper.getMonths(Integer.parseInt(Helper.correctInt(mon_month))) + " " +mon_year;
				}
				//hshRecord.put("exists",strExists);
				if(strCanPrepare.equals("Y"))
				{
					strQuery = SQLParser.getSqlQuery("selmaxmonth^"+cbsid);
					rs = DBUtils.executeQuery(strQuery);	
					if(rs.next())
					{
						intmaxmonth=(rs.getInt("max_month"));
						intmaxyear=(rs.getInt("max_year"));
					}
					if(intmaxyear>Integer.parseInt(mon_year))
					{
						strCanPrepare="N";
						strReason=Helper.getMonths(intmaxmonth)+" "+intmaxyear+" MMR already prepared. So MMR for"+ 
						Helper.getMonths(Integer.parseInt(Helper.correctInt(mon_month)))+" "+mon_year+" cannot be prepared."; 
					}
					if((intmaxyear)==(Integer.parseInt(mon_year)) && intmaxmonth>=(Integer.parseInt(mon_month)))
					{
						strCanPrepare="N";
						strReason=Helper.getMonths(intmaxmonth)+" "+intmaxyear+" MMR already prepared. So MMR for"+ 
						Helper.getMonths(Integer.parseInt(Helper.correctInt(mon_month)))+" "+mon_year+" cannot be prepared."; 
					}
					/*else if(intmaxyear!=0 && intmaxyear<(Integer.parseInt(mon_year)) && Integer.parseInt(mon_month)>intmaxmonth)
					{
						strCanPrepare="N";
						strReason=Helper.getMonths(intmaxmonth)+" "+intmaxyear+" MMR already prepared. So MMR for"+ 
						Helper.getMonths(Integer.parseInt(Helper.correctInt(mon_month)))+" "+mon_year+" cannot be prepared."; 
					}*/
				/*else if((intmaxmonth)>(Integer.parseInt(mon_month)))
				{
					strCanPrepare="N";
					strReason=Helper.getMonths(intmaxmonth)+" "+intmaxyear+" MMR already prepared. So MMR for"+ 
						Helper.getMonths(Integer.parseInt(Helper.correctInt(mon_month)))+" "+mon_year+" cannot be prepared."; 
				}*/
					hshRecord.put("perparedmonth",String.valueOf(intmaxmonth));
					hshRecord.put("perparedyear",String.valueOf(intmaxyear));
				}
			}
			hshRecord.put("canprepare",strCanPrepare);
			hshRecord.put("mmrreason",strReason);
		}
		else
		{	
			rs=DBUtils.executeLAPSQuery("getfundbased^"+cbsid);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs.getString("FUND_CUSTID")));
				arrCol.add(correctNull(rs.getString("FUND_ACCNO")));
				/*String fac_schemecode=correctNull(rs.getString("FUND_SCHEMECODE"));
				//for getting scheme code from static data master
				if(rs2!=null)
				{
					rs2.close();
				}
				rs2=DBUtils.executeLAPSQuery("getmonfacility^"+fac_schemecode);
				if(rs2.next())
				{
					facility=correctNull((String)rs2.getString("stat_data_desc1"));
				}
				
				   	  	arrCol.add(facility);*/
				arrCol.add(rs.getString("stat_data_desc1"));
				arrCol.add(correctNull(rs.getString("FUND_SANCAMT")));
				arrCol.add(correctNull(rs.getString("FUND_DRAWINGPOWER")));
				arrCol.add(correctNull(rs.getString("FUND_OSAMT")));
				arrCol.add(correctNull(rs.getString("FUND_OVERDUEAMT")));
				arrCol.add(correctNull(rs.getString("FUND_OVERDUESINCE")).equals("01/01/1900")?"":correctNull(rs.getString("FUND_OVERDUESINCE")));
				arrCol.add(correctNull(rs.getString("FUND_DEBITCURRMONTH")));
				arrCol.add(correctNull(rs.getString("FUND_CREDITCURRMONTH")));
				arrCol.add(correctNull(rs.getString("FUND_CREDITURNOVER")));
				arrCol.add(correctNull(rs.getString("FUND_INSTALMENT")));
				
				sanction_amount = sanction_amount + Double.parseDouble(Helper.correctDouble(rs.getString("FUND_SANCAMT")));
					
				if(Double.parseDouble(Helper.correctDouble(rs.getString("FUND_OSAMT")))<0)
				{	
					os_amount = os_amount + Double.parseDouble(Helper.correctDouble(rs.getString("FUND_OSAMT")));
				}
				arrRow.add(arrCol);
			}
					
		}
		
		grandsanction_amount = sanction_amount;
		grandos_amount = os_amount;
		
		hshRecord.put("grandsanction_amount",""+grandsanction_amount);
		hshRecord.put("grandos_amount",""+grandos_amount);
		
		
		hshRecord.put("sanction_amount",""+sanction_amount);
		hshRecord.put("os_amount",""+os_amount);
		hshRecord.put("arrRow",arrRow);
		hshRecord.put("mon_month",mon_month);
		hshRecord.put("mon_year",mon_year);
		hshRecord.put("cbsid",cbsid);
		hshRecord.put("cbsname",mon_cbsname);
		//hshRecord.put("Solid",strSolid);
		
	}
	catch(Exception e)
	{
		throw new EJBException("Error in getMonfacility"+e.getMessage());
	}
	finally
	{
		try
		{	if(rs != null)
				rs.close();
			//if(rs1 != null)
				//rs1.close();
			//if(rs2 != null)
				//rs2.close();
			
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	return hshRecord;
}

public void updateMMRFacility(HashMap hshValues)
{
	ResultSet rs=null;
	String cbsid=correctNull((String)hshValues.get("cbsid"));
	HashMap hshQueryValues=new HashMap();
	HashMap hshQuery=new HashMap();
	ArrayList arrValues=new ArrayList();
	String strappno[]=null;
	String strfacility[]=null;
	String strsanctionlimit[]=null;
	String strdp[]=null;
	String stroustanding[]=null;
	String strovedueamount[]=null;
	String strsince[]=null;
	String strdebit[]=null;
	String strcurrent[]=null;
	String strcummulative[]=null;
	String strinstalment[]=null;
	
	
	String strAction=correctNull((String)hshValues.get("hidAction"));
	String year=correctNull((String)hshValues.get("mon_year"));
	String month=correctNull((String)hshValues.get("mon_month"));
	String strUserId = correctNull((String)hshValues.get("strUserId"));
	String applyflag = correctNull((String)hshValues.get("applyflag"));
	String strOrgShortCode = correctNull((String)hshValues.get("strOrgShortCode"));
	String Strmmrno = correctNull((String)hshValues.get("mmrno"));
	String strcbsname=correctNull((String)hshValues.get("strcbsname"));
	int intUpdateSize=0;
	String strQuery="";
	String strFlag="N";
	try
	{
		
		String strcbsid=correctNull((String)hshValues.get("cbsid"));
		//String strappno[]=(String[])hshValues.get("cbsaccno");
		if(hshValues.get("txt_cbsaccno") instanceof java.lang.String)
		{
			strappno= new String[1];
			strappno[0]=(String)hshValues.get("txt_cbsaccno");
		}else{
			strappno=(String[])hshValues.get("txt_cbsaccno");
		}
		//strfacility=(String[])hshValues.get("txt_facility");
		if(hshValues.get("txt_facility") instanceof java.lang.String)
		{
			strfacility= new String[1];
			strfacility[0]=(String)hshValues.get("txt_facility");
		}else{
			strfacility=(String[])hshValues.get("txt_facility");
		}
		//strsanctionlimit=(String[])hshValues.get("txt_sanctionlimit");
		if(hshValues.get("txt_sanctionlimit") instanceof java.lang.String)
		{
			strsanctionlimit= new String[1];
			strsanctionlimit[0]=(String)hshValues.get("txt_sanctionlimit");
		}else{
			strsanctionlimit=(String[])hshValues.get("txt_sanctionlimit");
		}
		//strdp=(String[])hshValues.get("txt_dp");
		if(hshValues.get("txt_dp") instanceof java.lang.String)
		{
			strdp= new String[1];
			strdp[0]=(String)hshValues.get("txt_dp");
		}else{
			strdp=(String[])hshValues.get("txt_dp");
		}
		//stroustanding=(String[])hshValues.get("txt_oustanding");
		if(hshValues.get("txt_oustanding") instanceof java.lang.String)
		{
			stroustanding= new String[1];
			stroustanding[0]=(String)hshValues.get("txt_oustanding");
		}else{
			stroustanding=(String[])hshValues.get("txt_oustanding");
		}
		//strovedueamount=(String[])hshValues.get("txt_ovedueamount");
		if(hshValues.get("txt_ovedueamount") instanceof java.lang.String)
		{
			strovedueamount= new String[1];
			strovedueamount[0]=(String)hshValues.get("txt_ovedueamount");
		}else{
			strovedueamount=(String[])hshValues.get("txt_ovedueamount");
		}
		//strsince=(String[])hshValues.get("txt_since");
		if(hshValues.get("txt_since") instanceof java.lang.String)
		{
			strsince= new String[1];
			strsince[0]=(String)hshValues.get("txt_since");
		}else{
			strsince=(String[])hshValues.get("txt_since");
		}
		//strdebit=(String[])hshValues.get("txt_debit");
		if(hshValues.get("txt_debit") instanceof java.lang.String)
		{
			strdebit= new String[1];
			strdebit[0]=(String)hshValues.get("txt_debit");
		}else{
			strdebit=(String[])hshValues.get("txt_debit");
		}
		//strcurrent=(String[])hshValues.get("txt_current");
		if(hshValues.get("txt_current") instanceof java.lang.String)
		{
			strcurrent= new String[1];
			strcurrent[0]=(String)hshValues.get("txt_current");
		}else{
			strcurrent=(String[])hshValues.get("txt_current");
		}
		//strcummulative=(String[])hshValues.get("txt_cummulative");
		if(hshValues.get("txt_cummulative") instanceof java.lang.String)
		{
			strcummulative= new String[1];
			strcummulative[0]=(String)hshValues.get("txt_cummulative");
		}else{
			strcummulative=(String[])hshValues.get("txt_cummulative");
		}
		if(hshValues.get("txt_instalment") instanceof java.lang.String)
		{
			strinstalment= new String[1];
			strinstalment[0]=(String)hshValues.get("txt_instalment");
		}else{
			strinstalment=(String[])hshValues.get("txt_instalment");
		}
		
		
		if(rs!=null)rs.close();
		strQuery = SQLParser.getSqlQuery("getSearchData^"+cbsid+"^"+month+"^"+year);
		rs = DBUtils.executeQuery(strQuery);	
		if(rs.next())
		{
			strFlag="Y";
		}
		if(!strFlag.equalsIgnoreCase("Y"))
		{
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdateSize++;
			hshQuery.put("strQueryId","ins_mmrsearch");
			arrValues.add(month);
			arrValues.add(year);
			arrValues.add(strcbsid);
			arrValues.add("O");
			arrValues.add(strOrgShortCode);
			Strmmrno=getMMRNo(hshValues);
			arrValues.add(Strmmrno);
			arrValues.add(strUserId);
			arrValues.add(strUserId);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdateSize++;
			hshQuery.put("strQueryId","insmonmailbox");
			arrValues.add(strUserId);
			arrValues.add(strUserId);
			arrValues.add("1");
			arrValues.add("1");
			arrValues.add(strcbsname);
			arrValues.add(Strmmrno); 
			arrValues.add("C"); 
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
			
			
			hshQueryValues.put("size",Integer.toString(intUpdateSize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
		}
		if(strAction.equalsIgnoreCase("insert"))
		{
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","delnonfundbasedfacilities");
			//arrValues.add(strcbsid);
			//arrValues.add(month);
			//arrValues.add(year);
			arrValues.add(Strmmrno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
			GregorianCalendar cal = new GregorianCalendar(Integer.parseInt(Helper.correctInt(year)),Integer.parseInt(Helper.correctInt(month)),01);
			cal.add(cal.MONTH,-1);
						
			String lastDateofMonth = cal.getActualMaximum(GregorianCalendar.DAY_OF_MONTH)+"/"+(cal.get(cal.MONTH)+1)+"/"+cal.get(cal.YEAR);
			
			
			for(int i=0;i<strfacility.length;i++)
			{
				
				    hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","ins_mmrfundbased");
					arrValues.add(strcbsid);
					arrValues.add("");
					arrValues.add(strfacility[i]);
					arrValues.add(strsanctionlimit[i]);
					arrValues.add(strdp[i]);
					arrValues.add(stroustanding[i]);
					arrValues.add(strovedueamount[i]);
					arrValues.add(strsince[i]);
					arrValues.add(strdebit[i]);
					arrValues.add(strcurrent[i]);
					arrValues.add(strcummulative[i]);
					arrValues.add(strinstalment[i]);
					arrValues.add(strUserId);
					arrValues.add(lastDateofMonth);
					arrValues.add(month);
					arrValues.add(year);
					arrValues.add(Strmmrno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
					
					
		}
		if(strAction.equalsIgnoreCase("delete"))
		{
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","delnonfundbasedwithscheme");
			//arrValues.add(strcbsid);
			//arrValues.add(month);
			//arrValues.add(year);
			arrValues.add(Strmmrno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
		}
		
		if(!applyflag.equals("1"))
		{
			/*int prevmonth = Integer.parseInt(correctNull(month));
			int prevyear = Integer.parseInt(correctNull(year));
			
			
			
			if(prevmonth==1)
			{
				prevmonth = 12;
				prevyear =  prevyear -1;
			}
			else
			{
				prevmonth = prevmonth -1;
			}*/
			
			
			String strprevmmrno="";
			boolean checkData = false;
			String strprevmonth="";
			String strprevyear="";
			rs=DBUtils.executeLAPSQuery("getpendingmmrreport^"+cbsid+"^"+Strmmrno);
			if(rs.next())
			{
				checkData = true;
				strprevmmrno=correctNull(rs.getString("mmr_no"));
				strprevmonth=correctNull(rs.getString("mmr_month"));
				strprevyear=correctNull(rs.getString("mmr_year"));
			}
			
			if(checkData)
			{
				updateCopyOfMMR(hshValues,cbsid,strprevyear,strprevmonth,strprevmmrno,Strmmrno);
				
			}	
			
			/*if(!strFlag.equalsIgnoreCase("Y"))
			{
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_mmrssearchstatus");
				
				arrValues.add("C");
				arrValues.add(strcbsid);
				arrValues.add(strOrgShortCode);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}*/
			
		}
		
	}
	catch(Exception e)
	{
		throw new EJBException("Error in updateMMRFacility"+e.getMessage());
	}
	finally
	{
		try
		{	if(rs != null)
				rs.close();
			
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
}

	private String getMMRNo(HashMap hshValues)
	{
		java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
		nf.setMinimumIntegerDigits(2);
		nf.setGroupingUsed(false);
		String year=correctNull((String)hshValues.get("mon_year"));
		double month=Double.parseDouble(Helper.correctDouble((String)hshValues.get("mon_month")));
		String strcbsid=correctNull((String)hshValues.get("cbsid"));
		String strOrgShortCode = correctNull((String)hshValues.get("strOrgShortCode"));
		
		return (String)(year+nf.format(month)+strOrgShortCode+strcbsid);
	}

	private void updateCopyOfMMR(HashMap hshValues,String strcbsid,String prevyear,String prevmonth,String prevmmrno,String strmmrno)
	{
		String year=correctNull((String)hshValues.get("mon_year"));
		String month=correctNull((String)hshValues.get("mon_month"));
		String strOrgShortCode=correctNull((String)hshValues.get("strOrgShortCode"));
		
		try
		{
			int intSize =0;
		//-----------------------	
			intSize++;
			HashMap hshQueryValues=new HashMap();
			HashMap hshQuery=new HashMap();
			ArrayList arrValues=new ArrayList();
			
			hshQuery.put("strQueryId","copyreasonforexcess");
			arrValues.add(month);
			arrValues.add(year);
			arrValues.add(strmmrno);
			arrValues.add(prevmmrno);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intSize,hshQuery);
			hshQueryValues.put("size",""+intSize);
//	------------------------------------------------------	
			
			intSize++;
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			
			hshQuery.put("strQueryId","copyborrowerinfo");
			
			arrValues.add(year);
			arrValues.add(month);
			arrValues.add(strmmrno);
			arrValues.add(prevmmrno);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intSize,hshQuery);
			hshQueryValues.put("size",""+intSize);
	//------------------------------------------------------
		
			intSize++;
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			
			hshQuery.put("strQueryId","copygeneralinfo");
			arrValues.add(month);
			arrValues.add(year);
			arrValues.add(strmmrno);
			arrValues.add(prevmmrno);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intSize,hshQuery);
			hshQueryValues.put("size",""+intSize);
	
//------------------------------------------------------
			intSize++;
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			
			hshQuery.put("strQueryId","copymonhedgeddetails");
			arrValues.add(month);
			arrValues.add(year);
			arrValues.add(strmmrno);
			arrValues.add(prevmmrno);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intSize,hshQuery);
			hshQueryValues.put("size",""+intSize);
	
	//-----------------------------------------------------------------
		
			intSize++;
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			
			hshQuery.put("strQueryId","copymonmonitoringinfo");
			arrValues.add(month);
			arrValues.add(year);
			arrValues.add(strmmrno);
			arrValues.add(prevmmrno);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intSize,hshQuery);
			hshQueryValues.put("size",""+intSize);
	
	//---------------------------------------------------------------------
		
			intSize++;
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			
			hshQuery.put("strQueryId","copymonmonitorinformation");
			arrValues.add(month);
			arrValues.add(year);
			arrValues.add(strmmrno);
			arrValues.add(prevmmrno);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intSize,hshQuery);
			hshQueryValues.put("size",""+intSize);
	
//			-----------------------------------------------
		
			intSize++;
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			
			hshQuery.put("strQueryId","copyauditorinspection");
			arrValues.add(month);
			arrValues.add(year);
			arrValues.add(strmmrno);
			arrValues.add(prevmmrno);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intSize,hshQuery);
			hshQueryValues.put("size",""+intSize);
	
		//-------------------------------------------------
			
			intSize++;
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			
			hshQuery.put("strQueryId","copyconsortiumdetails");
			
			arrValues.add(month);
			arrValues.add(year);
			arrValues.add(strmmrno);
			arrValues.add(prevmmrno);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intSize,hshQuery);
			hshQueryValues.put("size",""+intSize);
	//-------------------------------------------------------	
			
			intSize++;
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","copyconsortiummeetings");
			arrValues.add(month);
			arrValues.add(year);
			arrValues.add(strmmrno);
			arrValues.add(prevmmrno);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intSize,hshQuery);
			hshQueryValues.put("size",""+intSize);
			
//-------------------------------------------------------------------- 	
			
			intSize++;
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","copyannexurefacilities");
			arrValues.add(month);
			arrValues.add(year);
			arrValues.add(strmmrno);
			arrValues.add(prevmmrno);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intSize,hshQuery);
			hshQueryValues.put("size",""+intSize);
			
//			------------------------------------------------
			
			intSize++;
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","copymsodestimates");
			arrValues.add(month);
			arrValues.add(year);
			arrValues.add(strmmrno);
			arrValues.add(prevmmrno);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intSize,hshQuery);
			hshQueryValues.put("size",""+intSize);
	
//-----------------------------------------------------
			
			intSize++;
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","copymsodborrowing");
			arrValues.add(month);
			arrValues.add(year);
			arrValues.add(strmmrno);
			arrValues.add(prevmmrno);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intSize,hshQuery);
			hshQueryValues.put("size",""+intSize);
	
	//------------------------------------------------------------
			
			intSize++;
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","copymsodworkingcapital");
			arrValues.add(month);
			arrValues.add(year);
			arrValues.add(strmmrno);
			arrValues.add(prevmmrno);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intSize,hshQuery);
			hshQueryValues.put("size",""+intSize);
			

	//----------------------------------------------------------
		
			intSize++;
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","copycurrentassets");
			arrValues.add(month);
			arrValues.add(year);
			arrValues.add(strmmrno);
			arrValues.add(prevmmrno);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intSize,hshQuery);
			hshQueryValues.put("size",""+intSize);
	
	//-------------------------------------------------------------------- 	
			
			intSize++;
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","copyinventory");
			arrValues.add(month);
			arrValues.add(year);
			arrValues.add(strmmrno);
			arrValues.add(prevmmrno);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intSize,hshQuery);
			hshQueryValues.put("size",""+intSize);
	
	//-------------------------------------------------------------
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intSize++;
			hshQuery.put("strQueryId","upd_mmrssearchstatus");
			
			arrValues.add("C");
			arrValues.add(strcbsid);
			arrValues.add(strOrgShortCode);
			arrValues.add(strmmrno);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intSize,hshQuery);
			hshQueryValues.put("size",""+intSize);
			//EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			hshQueryValues=new HashMap();
		
		}
		catch(Exception e)
		{
			
		}
	
	}


public HashMap getMMRFacility(HashMap hshValues)
{
	HashMap hshRecord=new HashMap();
	ResultSet rs=null;
	String cbsid=correctNull((String)hshValues.get("cbsid"));
	ArrayList arrRow=new ArrayList();
	ArrayList arrCol=null;
	String	applyflag	=	"1";
	String mon_month=correctNull((String)hshValues.get("mon_month"));
	String Strmmrno=correctNull((String)hshValues.get("mmrno"));
	double sanction_amount=0.00, os_amount =0.00,nonfundbasedsanctionamout=0.00,nonfundbasedos_amount=0.00,grandsanction_amount=0.00,grandos_amount=0.00;
	double blsancamt=0.0, blosamt=0.0 ;
	String mon_year=correctNull((String)hshValues.get("mon_year"));
	String strQuery="";
	
		
	String cbsname=correctNull((String)hshValues.get("cbsname"));
	if(cbsname.equalsIgnoreCase(""))
	{
	cbsname=correctNull((String)hshValues.get("name"));
	}
    if(mon_month.equalsIgnoreCase(""))
    {
	 mon_month=correctNull((String)hshValues.get("month"));
    }
    else if(mon_month.equalsIgnoreCase(""))
    {
   	 mon_month=correctNull((String)hshValues.get("mon_smonth"));
     }
    if(mon_year.equalsIgnoreCase(""))
    {
	 mon_year=correctNull((String)hshValues.get("year"));
    }
    else if(mon_year.equalsIgnoreCase(""))
    {
	 mon_year=correctNull((String)hshValues.get("mon_syear"));
    }
    if(cbsid.equalsIgnoreCase(""))
    {
    cbsid=correctNull((String)hshValues.get("npa_appno"));
    }
	try
	{
		
		if(Strmmrno.equalsIgnoreCase(""))
		{
			Strmmrno=getMMRNo(hshValues);
		}
		
		/*
		 * In future may non fund based code may change for that u have to change in
		 * three places 
		 * 1. getmmrfacility
		 * 2. delnonfundbasedwithscheme in sqlmon.xml
		 * 3. getmmrreportprint
		 */
		strQuery=SQLParser.getSqlQuery("getmmrfundbased^"+Strmmrno);
		rs=DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			
			if(!correctNull(rs.getString("MMRFUND_FACILITY")).equals("LC") && !correctNull(rs.getString("MMRFUND_FACILITY")).equals("LG") && !correctNull(rs.getString("MMRFUND_FACILITY")).equals("BL"))
			{
			
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs.getString("MMRFUND_CUSTID")));
				arrCol.add(correctNull(rs.getString("MMRFUND_ACCNO")));
				arrCol.add(correctNull(rs.getString("MMRFUND_FACILITY")));
				arrCol.add(correctNull(rs.getString("MMRFUND_SANCAMT")));
				arrCol.add(correctNull(rs.getString("MMRFUND_DRAWINGPOWER")));
				arrCol.add(correctNull(rs.getString("MMRFUND_OSAMT")));
				arrCol.add(correctNull(rs.getString("MMRFUND_OVERDUEAMT")));
				if(correctNull(rs.getString("MMRFUND_OVERDUESINCE")).equals("01/01/1900"))
				{
					arrCol.add("");
				}
				else
				{	
					arrCol.add(correctNull(rs.getString("MMRFUND_OVERDUESINCE")));
				}
				arrCol.add(correctNull(rs.getString("MMRFUND_DEBITCURRMONTH")));
				arrCol.add(correctNull(rs.getString("MMRFUND_CREDITCURRMONTH")));
				arrCol.add(correctNull(rs.getString("MMRFUND_CREDITURNOVER")));
				arrCol.add(correctNull(rs.getString("MMRFUND_INSTALMENT")));
				
				
				sanction_amount = sanction_amount + Double.parseDouble(Helper.correctDouble(rs.getString("MMRFUND_SANCAMT")));
				if(Double.parseDouble(Helper.correctDouble(rs.getString("MMRFUND_OSAMT")))<0)
				{	
					os_amount = os_amount + Double.parseDouble(Helper.correctDouble(rs.getString("MMRFUND_OSAMT")));
				}	
				arrRow.add(arrCol);
			}
			else
			{
				if(correctNull(rs.getString("MMRFUND_FACILITY")).equals("LC"))
				{
					hshRecord.put("MMRLC_SANCAMT",correctNull(rs.getString("MMRFUND_SANCAMT")));
					hshRecord.put("MMRLC_DRAWINGPOWER",correctNull(rs.getString("MMRFUND_DRAWINGPOWER")));
					hshRecord.put("MMRLC_OSAMT",correctNull(rs.getString("MMRFUND_OSAMT")));
					hshRecord.put("MMRLC_OVERDUEAMT",correctNull(rs.getString("MMRFUND_OVERDUEAMT")));
					hshRecord.put("MMRLC_OVERDUESINCE",correctNull(rs.getString("MMRFUND_OVERDUESINCE")));
					hshRecord.put("MMRLC_DEBITCURRMONTH",correctNull(rs.getString("MMRFUND_DEBITCURRMONTH")));
					hshRecord.put("MMRLC_CREDITCURRMONTH",correctNull(rs.getString("MMRFUND_CREDITCURRMONTH")));
					hshRecord.put("MMRLC_CREDITURNOVER",correctNull(rs.getString("MMRFUND_CREDITURNOVER")));
					hshRecord.put("MMRLC_INSTALMENT",correctNull(rs.getString("MMRFUND_INSTALMENT")));
					
				}
				else if(correctNull(rs.getString("MMRFUND_FACILITY")).equals("LG"))
				{
					hshRecord.put("MMRLG_SANCAMT",correctNull(rs.getString("MMRFUND_SANCAMT")));
					hshRecord.put("MMRLG_DRAWINGPOWER",correctNull(rs.getString("MMRFUND_DRAWINGPOWER")));
					hshRecord.put("MMRLG_OSAMT",correctNull(rs.getString("MMRFUND_OSAMT")));
					hshRecord.put("MMRLG_OVERDUEAMT",correctNull(rs.getString("MMRFUND_OVERDUEAMT")));
					hshRecord.put("MMRLG_OVERDUESINCE",correctNull(rs.getString("MMRFUND_OVERDUESINCE")));
					hshRecord.put("MMRLG_DEBITCURRMONTH",correctNull(rs.getString("MMRFUND_DEBITCURRMONTH")));
					hshRecord.put("MMRLG_CREDITCURRMONTH",correctNull(rs.getString("MMRFUND_CREDITCURRMONTH")));
					hshRecord.put("MMRLG_CREDITURNOVER",correctNull(rs.getString("MMRFUND_CREDITURNOVER")));
					hshRecord.put("MMRLG_INSTALMENT",correctNull(rs.getString("MMRFUND_INSTALMENT")));
				}
				else if(correctNull(rs.getString("MMRFUND_FACILITY")).equals("BL"))
				{
					hshRecord.put("MMRBL_SANCAMT",correctNull(rs.getString("MMRFUND_SANCAMT")));
					hshRecord.put("MMRBL_DRAWINGPOWER",correctNull(rs.getString("MMRFUND_DRAWINGPOWER")));
					hshRecord.put("MMRBL_OSAMT",correctNull(rs.getString("MMRFUND_OSAMT")));
					hshRecord.put("MMRBL_OVERDUEAMT",correctNull(rs.getString("MMRFUND_OVERDUEAMT")));
					hshRecord.put("MMRBL_OVERDUESINCE",correctNull(rs.getString("MMRFUND_OVERDUESINCE")));
					hshRecord.put("MMRBL_DEBITCURRMONTH",correctNull(rs.getString("MMRFUND_DEBITCURRMONTH")));
					hshRecord.put("MMRBL_CREDITCURRMONTH",correctNull(rs.getString("MMRFUND_CREDITCURRMONTH")));
					hshRecord.put("MMRBL_CREDITURNOVER",correctNull(rs.getString("MMRFUND_CREDITURNOVER")));
					hshRecord.put("MMRBL_INSTALMENT",correctNull(rs.getString("MMRFUND_INSTALMENT")));
					blosamt=rs.getDouble("MMRFUND_OSAMT");
					if(blosamt>0)
					{
						blosamt=0;
					}
					blsancamt=rs.getDouble("MMRFUND_SANCAMT");
				}
				if(!correctNull(rs.getString("MMRFUND_FACILITY")).equals("BL")){
					nonfundbasedsanctionamout = nonfundbasedsanctionamout + Double.parseDouble(Helper.correctDouble(rs.getString("MMRFUND_SANCAMT")));
					if(Double.parseDouble(Helper.correctDouble(rs.getString("MMRFUND_OSAMT")))<0)
					{	
						nonfundbasedos_amount = nonfundbasedos_amount + Double.parseDouble(Helper.correctDouble(rs.getString("MMRFUND_OSAMT")));
					}	
				}
			}
			
			
		}
		
		grandsanction_amount = sanction_amount + nonfundbasedsanctionamout+blsancamt;
		grandos_amount = os_amount + nonfundbasedos_amount+blosamt;
		
		hshRecord.put("grandsanction_amount",""+grandsanction_amount);
		hshRecord.put("grandos_amount",""+grandos_amount);
		
		hshRecord.put("nonfundbasedsanctionamout",""+nonfundbasedsanctionamout);
		hshRecord.put("nonfundbasedos_amount",""+nonfundbasedos_amount);
		
		hshRecord.put("sanction_amount",""+sanction_amount);
		hshRecord.put("os_amount",""+os_amount);
		hshRecord.put("arrRow",arrRow);
		hshRecord.put("mon_month",mon_month);
		hshRecord.put("mon_year",mon_year);
		hshRecord.put("cbsid",cbsid);
		hshRecord.put("mmrno",Strmmrno);
		hshRecord.put("cbsname",cbsname);
		hshRecord.put("applyflag",applyflag);
		
	}
	catch(Exception e)
	{
		throw new EJBException("Error in getMMRFacility"+e.getMessage());
	}
	finally
	{
		try
		{	if(rs != null)
				rs.close();
			
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	return hshRecord;
}

public HashMap getMMRSearch(HashMap hshValues)
{
	HashMap hshRecord=new HashMap();
	ResultSet rs=null;

	ArrayList arrRow=new ArrayList();
	ArrayList arrCol=null;
	String pending_year="",pending_month="";
	String cbsaccno=correctNull((String)hshValues.get("cbsaccno"));
	String cbsid=correctNull((String)hshValues.get("cbsid"));
	String mon_month=correctNull((String)hshValues.get("mon_month"));
	String mon_year=correctNull((String)hshValues.get("mon_year"));
	String hidprinttype=correctNull((String)hshValues.get("strhidprinttype"));
	String flag="false"; 
	String strQuery="";
	try
	{
		if (!(mon_month.equalsIgnoreCase("S")&& (!mon_year.equalsIgnoreCase(""))))
		{
			strQuery=SQLParser.getSqlQuery("getmmrsearchbyyearmonth^"+cbsid+"^"+mon_month+"^"+mon_year);
		}
		else if((mon_month.equalsIgnoreCase("S")&& (!mon_year.equalsIgnoreCase(""))))
		{
			strQuery=SQLParser.getSqlQuery("getmmrsearchbyyear^"+cbsid+"^"+mon_year);
		}
		else
		{	
			strQuery=SQLParser.getSqlQuery("getmmrsearch^"+cbsid);
		}
		rs=DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			arrCol=new ArrayList();
			if((correctNull(rs.getString("mmr_status")).equalsIgnoreCase("P")))
			{
				pending_year=correctNull(rs.getString("mmr_year"));
				pending_month=correctNull(rs.getString("mmr_month"));
			}
			arrCol.add(correctNull(rs.getString("mmr_year")));
			arrCol.add(correctNull(rs.getString("mmr_month")));
			arrCol.add(correctNull(rs.getString("mmr_orgscode")));
			arrCol.add(correctNull(rs.getString("mmr_status")));
			arrCol.add(correctNull(rs.getString("mmr_no")));
			arrCol.add(correctNull(rs.getString("mmr_rptholder")));
			arrCol.add(correctNull(rs.getString("org_name")));
			arrRow.add(arrCol);
			flag="true";
		}
		if(!(pending_year.equalsIgnoreCase("")&& pending_month.equalsIgnoreCase("")))
		{
			strQuery=SQLParser.getSqlQuery("sel_mmrcurrrentuser^"+cbsid+"^"+pending_month+"^"+pending_year+"^"+cbsid+"^"+pending_month+"^"+pending_year);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("mail_user",correctNull(rs.getString("monmail_tousrid")));		
			}
		}
		
		hshRecord.put("arrRow",arrRow);
		hshRecord.put("mon_month",mon_month);
		hshRecord.put("mon_year",mon_year);
		hshRecord.put("cbsid",cbsid);
		hshRecord.put("cbsaccno",cbsaccno);
		hshRecord.put("hidprinttype",hidprinttype);
		hshRecord.put("flag",flag);
	}
	catch(Exception e)
	{
		throw new EJBException("Error in getMMRFacility"+e.getMessage());
	}
	finally
	{
		try
		{	if(rs != null)
				rs.close();
			
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	return hshRecord;
}

public void updateBorrowerinfo(HashMap hshValues) 
{
	HashMap hshQuery=new HashMap();
	HashMap hshQueryValues=new HashMap();
	ArrayList arrValues=new ArrayList();
	ResultSet rs=null;
	String strRecordFlag="";
	try
	{
		String strAction=correctNull((String)hshValues.get("hidAction"));
		strRecordFlag = Helper.correctNull((String)hshValues.get("hidAuditFlag"));
			if(strAction.equalsIgnoreCase("Edit"))
			{
			
				 hshQuery=new HashMap();
				 arrValues=new ArrayList();
				 arrValues.add(correctNull((String)hshValues.get("txt_bankarrange")));
				 arrValues.add(correctNull((String)hshValues.get("txt_contactname")));
				 arrValues.add(correctNull((String)hshValues.get("txt_contact_per_design")));
				 arrValues.add(correctNull((String)hshValues.get("txt_contact_landline")));
				 arrValues.add(correctNull((String)hshValues.get("txt_contact_mobile")));
				 arrValues.add(correctNull((String)hshValues.get("cbsid")));
				 hshQuery.put("arrValues",arrValues); 
				 hshQuery.put("strQueryId","upd_personalinfo"); 
				 hshQueryValues.put("1",hshQuery);
				 
				 
				 hshQuery=new HashMap();
				 arrValues=new ArrayList();
				 arrValues.add(correctNull((String)hshValues.get("mmrno")));
				 hshQuery.put("arrValues",arrValues); 
				 hshQuery.put("strQueryId","del_borrowerinfo_detail"); 
				 hshQueryValues.put("2",hshQuery);
			
				
				 hshQuery=new HashMap();
				 arrValues=new ArrayList();
				 arrValues.add(correctNull((String)hshValues.get("txt_bankarrange")));
				 arrValues.add(correctNull((String)hshValues.get("txt_contactname")));
				 arrValues.add(correctNull((String)hshValues.get("txt_contact_per_design")));
				 arrValues.add(correctNull((String)hshValues.get("txt_contact_landline")));
				 arrValues.add(correctNull((String)hshValues.get("txt_contact_mobile")));
				 arrValues.add(correctNull((String)hshValues.get("jointdocument")));
				 arrValues.add(correctNull((String)hshValues.get("stipulateddocument")));
				 arrValues.add(correctNull((String)hshValues.get("mmrno")));
				 arrValues.add(correctNull((String)hshValues.get("cbsid")));

				 hshQuery.put("arrValues",arrValues); 
				 hshQuery.put("strQueryId","ins_borrowerinfo_detail"); 
				 hshQueryValues.put("3",hshQuery);
				 hshQueryValues.put("size","3");	
				 
				 
				 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			/*if(strAction.equalsIgnoreCase("Delete"))
			{
				 hshQuery=new HashMap();
				 arrValues=new ArrayList();
				 arrValues.add(correctNull((String)hshValues.get("txt_bankarrange")));
				 arrValues.add(correctNull((String)hshValues.get("txt_contactname")));
				 arrValues.add(correctNull((String)hshValues.get("txt_contact_per_design")));
				 arrValues.add(correctNull((String)hshValues.get("txt_contact_landline")));
				 arrValues.add(correctNull((String)hshValues.get("txt_contact_mobile")));
				 arrValues.add(correctNull((String)hshValues.get("cbsid")));
				 hshQuery.put("arrValues",arrValues); 
				 hshQuery.put("strQueryId","upd_personalinfo"); 
				 hshQueryValues.put("1",hshQuery);
				 hshQueryValues.put("size","1");	
				 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}*/
			
			// Audit Trial
			StringBuilder sbAt = new StringBuilder();
			String strBankFac=correctNull((String)hshValues.get("txt_bankarrange"));
			if(strBankFac.equals("1"))strBankFac="Sole";
			if(strBankFac.equals("2"))strBankFac="Consortium";
			if(strBankFac.equals("3"))strBankFac="Multiple Banking";
			sbAt.append("Banking Arrangement =").append(strBankFac);
			sbAt.append("~ Nature of activity =").append(correctNull((String)hshValues.get("txt_natureactive")));
			if(strBankFac.equalsIgnoreCase("Consortium"))
			{
				sbAt.append("~ In case of joint documentation within lead bank has obtained and got vetted The stipulated documents =").append(SetupParams.getSetupParams("YesNo",correctNull((String)hshValues.get("jointdocument"))));
				sbAt.append("~ whether branch is holding confirmation to that effect =").append(SetupParams.getSetupParams("YesNo",correctNull((String)hshValues.get("stipulateddocument"))));
			}
			sbAt.append("~ Address =").append(correctNull((String)hshValues.get("txt_address")));
			sbAt.append("~ Phone =").append(correctNull((String)hshValues.get("txt_phno")));
			sbAt.append("~ Address 1 =").append(correctNull((String)hshValues.get("txt_address1")));
			sbAt.append("~ Mobile number =").append(correctNull((String)hshValues.get("txt_mobile")));
			sbAt.append("~ City =").append(correctNull((String)hshValues.get("txt_city")));
			sbAt.append("~ Constitution =").append(correctNull((String)hshValues.get("txt_const")));
			sbAt.append("~ State =").append(correctNull((String)hshValues.get("txt_state")));
			sbAt.append("~ Banking Since =").append(correctNull((String)hshValues.get("txt_sincedate")));
			sbAt.append("~ Pincode =").append(correctNull((String)hshValues.get("txt_pincode")));
			sbAt.append("~ Contact Person Name =").append(correctNull((String)hshValues.get("txt_contactname")));
			sbAt.append("~ Contact Person Designation =").append(correctNull((String)hshValues.get("txt_contact_per_design")));
			sbAt.append("~ Contact Person Land line Number =").append(correctNull((String)hshValues.get("txt_contact_landline")));
			sbAt.append("~ Contact Person Mobile =").append(correctNull((String)hshValues.get("txt_contact_mobile")));

			if(strRecordFlag.equalsIgnoreCase("Y")){
				hshValues.put("hidAction", "update");
			}else if(strRecordFlag.equalsIgnoreCase("N")){
				hshValues.put("hidAction", "insert");
			}
			AuditTrial.auditLog(hshValues,"414",correctNull((String)hshValues.get("mmrno")),sbAt.toString());
			
	}catch(Exception e)
	{
		throw new EJBException("Error in updateBorrowerinfo "+e.getMessage());
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
			throw new EJBException("Error closing in updateLimitRegisster the connection "+cf.getMessage());						
		}
	}
	
	
}
	public void updateGeneralInfo(HashMap hshValues) 
	{
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=new ArrayList();
		int intUpdateSize=0;
		String strRecordFlag="";
		String Strmmrno=correctNull((String)hshValues.get("mmrno"));
		try
		{
			String strAction=correctNull((String)hshValues.get("hidAction"));
			strRecordFlag = Helper.correctNull((String)hshValues.get("hidAuditFlag"));
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdateSize++;
				//arrValues.add(correctNull((String)hshValues.get("cbsid")));
				//arrValues.add(correctNull((String)hshValues.get("mon_month")));
				//arrValues.add(correctNull((String)hshValues.get("strYear")));
				arrValues.add(Strmmrno);
				hshQuery.put("arrValues",arrValues); 
				hshQuery.put("strQueryId","del_mon_generalinfo"); 
				hshQueryValues.put(""+intUpdateSize,hshQuery);
				
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdateSize++;
				arrValues.add(correctNull((String)hshValues.get("cbsid")));
				arrValues.add(correctNull((String)hshValues.get("mon_month")));
				arrValues.add(correctNull((String)hshValues.get("strYear")));
				arrValues.add(correctNull((String)hshValues.get("sel_acctclassification")));
				arrValues.add(correctNull((String)hshValues.get("sel_stress")));
				arrValues.add(correctNull((String)hshValues.get("txt_stressreasons")));
				arrValues.add(correctNull((String)hshValues.get("sel_restucture")));
				arrValues.add(correctNull((String)hshValues.get("sel_restruc_termscompiled")));
				arrValues.add(correctNull((String)hshValues.get("txt_restructterms_reasons")));
				arrValues.add(correctNull((String)hshValues.get("txt_prevrating")));
				arrValues.add(correctNull((String)hshValues.get("txt_presentrating")));
				arrValues.add(correctNull((String)hshValues.get("txt_downgrade_reason")));
				arrValues.add(correctNull((String)hshValues.get("sel_docstipulated")));
				arrValues.add(correctNull((String)hshValues.get("txt_creditauditdate")));
				arrValues.add(correctNull((String)hshValues.get("sel_docvetted")));
				arrValues.add(correctNull((String)hshValues.get("txt_docvettedreason")));
				arrValues.add(correctNull((String)hshValues.get("txt_docdeficiences")));
				arrValues.add(correctNull((String)hshValues.get("borrower_Date")));
				arrValues.add(correctNull((String)hshValues.get("roc_reasons")));
				arrValues.add(correctNull((String)hshValues.get("txt_deviation")));
				arrValues.add(correctNull((String)hshValues.get("txt_permittedcompliance")));
				arrValues.add(Strmmrno);
				arrValues.add(correctNull((String)hshValues.get("txt_lawyername")));
				hshQuery.put("arrValues",arrValues); 
				hshQuery.put("strQueryId","ins_mon_generalinfo"); 
				hshQueryValues.put(""+intUpdateSize,hshQuery);
				
				hshQueryValues.put("size",""+intUpdateSize);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			if(strAction.equalsIgnoreCase("delete"))
			{
				//arrValues.add(correctNull((String)hshValues.get("cbsid")));
				//arrValues.add(correctNull((String)hshValues.get("mon_month")));
				//arrValues.add(correctNull((String)hshValues.get("strYear")));
				arrValues.add(Strmmrno);
				hshQuery.put("arrValues",arrValues); 
				hshQuery.put("strQueryId","del_mon_generalinfo"); 
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			// Audit Trial
			StringBuilder sbAt = new StringBuilder();
			if(!strAction.equals("delete"))
			{
				sbAt.append("The account categorized as =").append(SetupParams.getSetupParams("AccountCategory", correctNull((String)hshValues.get("sel_acctclassification"))));
				sbAt.append("~ If account is Under Stress =").append(SetupParams.getSetupParams("YesNoFlag", correctNull((String)hshValues.get("sel_stress"))));
				sbAt.append("~ Whether the account is Restructured one =").append(SetupParams.getSetupParams("YesNoFlag", correctNull((String)hshValues.get("sel_restucture"))));
				if(correctNull((String)hshValues.get("sel_restucture")).equalsIgnoreCase("Y"))
				{
					sbAt.append("~ whether all the terms of restructuring complied with. =").append(SetupParams.getSetupParams("YesNoFlag", correctNull((String)hshValues.get("sel_restruc_termscompiled"))));
				}
				sbAt.append("~ Credit Ratings </b>");
				sbAt.append("~ Present Year Rating =").append(correctNull((String)hshValues.get("txt_prevrating")));
				sbAt.append("~ Previous Year Rating =").append(correctNull((String)hshValues.get("txt_presentrating")));
				sbAt.append("~ Whether documents as stipulated are obtained =").append(SetupParams.getSetupParams("YesNoFlag",correctNull((String)hshValues.get("sel_docstipulated"))));
				sbAt.append("~ Date of Credit Process Audit conducted (If applicable) =").append(correctNull((String)hshValues.get("txt_creditauditdate")));
				sbAt.append("~ Permitted date for compliance =").append(correctNull((String)hshValues.get("txt_permittedcompliance")));
				sbAt.append("~ Whether the above Documents are vetted by the Law Officer / Advocate =").append(SetupParams.getSetupParams("YesNoFlag",correctNull((String)hshValues.get("sel_docvetted"))));
				if(correctNull((String)hshValues.get("sel_docvetted")).equalsIgnoreCase("Y"))
				{
					sbAt.append("~ Law Officer / Advocate Name =").append(correctNull((String)hshValues.get("txt_lawyername")));
				}
				sbAt.append("~ Date of last meeting with the borrower =").append(correctNull((String)hshValues.get("borrower_Date")));
				
				if(strRecordFlag.equalsIgnoreCase("Y")){
					hshValues.put("hidAction", "update");
				}else if(strRecordFlag.equalsIgnoreCase("N")){
					hshValues.put("hidAction", "insert");
				}
			}
			AuditTrial.auditLog(hshValues,"415",correctNull((String)hshValues.get("mmrno")),sbAt.toString());
		}catch(Exception e)
		{
			throw new EJBException("Error in updateBorrowerinfo "+e.getMessage());
		}
		finally
		{
			
		}
	}
	public HashMap getGeneralInfo(HashMap hshValues) 
	{
		HashMap	hshRecord=null;
		ResultSet rs=null;
		String strQuery=null;
		String strCbsid=correctNull((String)hshValues.get("hidcbsid"));
		String strMonth=correctNull((String)hshValues.get("mon_month"));
		String stryear=correctNull((String)hshValues.get("strYear"));
		String Strmmrno=correctNull((String)hshValues.get("mmrno"));
		boolean recordflag=false;
		try
		{
			hshRecord=new	HashMap();
			
			strQuery=SQLParser.getSqlQuery("sel_mon_generalinfo^"+Strmmrno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				recordflag=true;
				hshRecord.put("acc_categorization",(correctNull(rs.getString("gen_acc_clasification"))));
				hshRecord.put("acc_stress",(correctNull(rs.getString("gen_accStressY"))));
				hshRecord.put("acc_stress_reason",(correctNull(rs.getString("gen_accstress_reason"))));
				hshRecord.put("acc_restructered",(correctNull(rs.getString("gen_accrestructY"))));
				hshRecord.put("acc_restructterms",(correctNull(rs.getString("gen_termscompiledY"))));
				hshRecord.put("acc_restructtermsreasons",(correctNull(rs.getString("gen_termscompiledreasons"))));
				hshRecord.put("presentrating",(correctNull(rs.getString("gen_presentyearrating"))));
				hshRecord.put("prevrating",(correctNull(rs.getString("gen_prevyearrating"))));
				hshRecord.put("downgradereason",(correctNull(rs.getString("gen_downgradereason"))));
				hshRecord.put("documentobtained",(correctNull(rs.getString("gen_docobtained"))));
				hshRecord.put("creditauditdate",(correctNull(rs.getString("gen_creditauditdate"))));
				hshRecord.put("documentvetted",(correctNull(rs.getString("gen_docvetted"))));
				hshRecord.put("docvettedreasons",(correctNull(rs.getString("gen_docvettedreasons"))));
				hshRecord.put("docdeficiencies",(correctNull(rs.getString("gen_docdeficiencies"))));
				hshRecord.put("borrower_Date",(correctNull(rs.getString("gen_borrowerdate"))));
				hshRecord.put("roc_reasons",(correctNull(rs.getString("roc_reasons"))));
				hshRecord.put("mon_deviation",(correctNull(rs.getString("mon_deviation"))));
				hshRecord.put("mon_compliance",(correctNull(rs.getString("mon_compliance"))));
				hshRecord.put("lawyer_name",(correctNull(rs.getString("gen_lawyername"))));
			}
			
			String checkString="",conString="", constitution="";
			int j=0;
			StringBuffer strAppend = new StringBuffer();
			strQuery = SQLParser.getSqlQuery("sel_monitoraccno^"+strCbsid);
			rs = DBUtils.executeQuery(strQuery);	
			while (rs.next())
			{ 
				
				
				if(j!=0)
				{
					strAppend.append(",");
				}
				
				strAppend.append("'").append(correctNull(rs.getString("LIMIT_CUTACCNO"))).append("'");
				j++;
			}
			
			if(!strAppend.toString().equals(""))
			{
				strQuery=SQLParser.getSqlQuery("sel_monchecklist_reason^"+strAppend.toString());
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					if(correctNull(rs.getString("mon_roc")).equals("n"))
					{
						checkString="y";
					}
				}
			}
			
			strQuery=SQLParser.getSqlQuery("sel_personalinfo^"+strCbsid);
			rs	=	DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				constitution= correctNull(rs.getString("new_personal_constitution"));
			}
			if(constitution.equals("005") || constitution.equals("006"))
			{
				conString="y";
			}
			
			
			if(checkString.equals("y") && conString.equals("y"))
			{
				checkString="y";
			}
			else
			{
				checkString="n";
			}
			
		hshRecord.put("checkString",checkString);
		hshRecord.put("mon_month",strMonth);
		hshRecord.put("mon_year",stryear);
		
		if(recordflag)
			hshRecord.put("recordflag","Y");
		else
			hshRecord.put("recordflag","N");
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getBorrowerinfo  :: "+ e.getMessage());
		}
		finally
		{
			try
			{
				if(rs!=null)
				{
					rs.close();
				}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
	return hshRecord;
	}

/*
 * THIS DONE BY PAUL AS PER SURESH GUIDANCE
 */
	
	public HashMap getMMRReportPrint(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		String cbsid=correctNull((String)hshValues.get("cbsid"));
		String Strmmrno=correctNull((String)hshValues.get("mmrno"));
		String mon_month=correctNull((String)hshValues.get("mon_month"));
		String mon_year=correctNull((String)hshValues.get("mon_year"));
		String org_Code_MMr="";
		hshRecord.put("cbsid",cbsid);
		hshRecord.put("str_Month_alp",Helper.getMonths(Integer.parseInt(Helper.correctInt(mon_month)))+" "+mon_year);
				
		
					
		String strAudittype=correctNull((String)hshValues.get("sel_audittype"));
		
		try
		{
			ArrayList arrRow = new ArrayList();
			ArrayList arrCol = null;
			
			String strQuery="";
		
			if (rs != null) {
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("getSearchData^"+cbsid+"^"+mon_month+"^"+mon_year);
			rs	=	DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				
				strQuery=SQLParser.getSqlQuery("setorgselectapp^"+(correctNull(rs.getString("mmr_orgscode"))));
				rs1	=	DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					hshRecord.put("branch",(correctNull((String)rs1.getString("org_name"))));
					
					org_Code_MMr = correctNull((String)rs1.getString("org_code"));
				}
				
				
				
				hshRecord.put("activity",(correctNull(rs.getString("PERSONAL_NATOFACTIVITY"))));
			
				hshRecord.put("address",(correctNull(rs.getString("PERSONAL_ADDRESS"))));
				hshRecord.put("address1",(correctNull(rs.getString("PERSONAL_ADDRESS1"))));
				hshRecord.put("city",(correctNull(rs.getString("city"))));
				hshRecord.put("state",(correctNull(rs.getString("state"))));
				hshRecord.put("pincode",(correctNull(rs.getString("PERSONAL_PINCODE"))));
				hshRecord.put("phoneno",(correctNull(rs.getString("PERSONAL_PHONE"))));
				hshRecord.put("mobile",(correctNull(rs.getString("PERSONAL_MOBILE"))));
				hshRecord.put("constitution",(correctNull(rs.getString("PERSONAL_CONSTITUTION"))));
				hshRecord.put("since",(correctNull(rs.getString("PERSONAL_BANKINGSINCE"))));
			
				
			}
			
			
			strQuery=SQLParser.getSqlQuery("sel_borrowerinfo_detail^"+Strmmrno);
			rs	=	DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("arrange",(correctNull(rs.getString("borrower_bankarrangement"))));
				hshRecord.put("contactname",(correctNull(rs.getString("borrower_contactname"))));
				hshRecord.put("contact_per_design",(correctNull(rs.getString("borrower_contperdesign"))));
				hshRecord.put("contact_landline",(correctNull(rs.getString("borrower_landline"))));
				hshRecord.put("contact_mobile",(correctNull(rs.getString("borrower_contpermobile"))));
				hshRecord.put("personal_leadbankvetted",(correctNull(rs.getString("borrower_leadbankvetted"))));
				hshRecord.put("personal_stipdocuments",(correctNull(rs.getString("borrower_stipdocuments"))));
			}	
			
			
			double sanction_amount=0.00,os_amount=0.00,nonfundbasedsanctionamout=0.00,
			nonfundbasedos_amount=0.00,grandsanction_amount=0.00,grandos_amount=0.00,excess_fundbasedoverdues=0.00,excess_nonfundbasedoverdues=0.00,grand_overduestotal=0.00;
			double blsancamt=0.0, blosamt=0.0,bloverdueamt=0.0;
			rs=DBUtils.executeLAPSQuery("getmmrfundbased^"+Strmmrno);
			while(rs.next())
			{
				if(!correctNull(rs.getString("MMRFUND_FACILITY")).equals("LC") && !correctNull(rs.getString("MMRFUND_FACILITY")).equals("LG") && !correctNull(rs.getString("MMRFUND_FACILITY")).equals("BL"))
				{
				
					arrCol=new ArrayList();
					arrCol.add(correctNull(rs.getString("MMRFUND_CUSTID")));
					arrCol.add(correctNull(rs.getString("MMRFUND_ACCNO")));
					arrCol.add(correctNull(rs.getString("MMRFUND_FACILITY")));
					arrCol.add(Helper.converToLakhs(rs.getString("MMRFUND_SANCAMT")));
					arrCol.add(Helper.converToLakhs(rs.getString("MMRFUND_DRAWINGPOWER")));
					arrCol.add(Helper.converToLakhs(rs.getString("MMRFUND_OSAMT")));
					arrCol.add(Helper.converToLakhs(rs.getString("MMRFUND_OVERDUEAMT")));
					arrCol.add(correctNull(rs.getString("MMRFUND_OVERDUESINCE")));
					arrCol.add(Helper.converToLakhs(rs.getString("MMRFUND_DEBITCURRMONTH")));
					arrCol.add(Helper.converToLakhs(rs.getString("MMRFUND_CREDITCURRMONTH")));
					arrCol.add(Helper.converToLakhs(rs.getString("MMRFUND_CREDITURNOVER")));
					arrCol.add(Helper.converToLakhs(rs.getString("MMRFUND_INSTALMENT")));
					
					
					sanction_amount = sanction_amount + Double.parseDouble(Helper.correctDouble(rs.getString("MMRFUND_SANCAMT")));
					os_amount = os_amount + Double.parseDouble(Helper.correctDouble(rs.getString("MMRFUND_OSAMT")));
					excess_fundbasedoverdues = excess_fundbasedoverdues + Double.parseDouble(Helper.correctDouble(rs.getString("MMRFUND_OVERDUEAMT")));
					hshRecord.put("appcreatedate",correctNull(rs.getString("MMRFUND_MODIFIEDDATE")));
				
					arrRow.add(arrCol);
				}
				else
				{
					if(correctNull(rs.getString("MMRFUND_FACILITY")).equals("LC"))
					{
						hshRecord.put("MMRLC_SANCAMT",Helper.converToLakhs(rs.getString("MMRFUND_SANCAMT")));
						hshRecord.put("MMRLC_DRAWINGPOWER",Helper.converToLakhs(rs.getString("MMRFUND_DRAWINGPOWER")));
						hshRecord.put("MMRLC_OSAMT",Helper.converToLakhs(rs.getString("MMRFUND_OSAMT")));
						hshRecord.put("MMRLC_OVERDUEAMT",Helper.converToLakhs(rs.getString("MMRFUND_OVERDUEAMT")));
						hshRecord.put("MMRLC_OVERDUESINCE",correctNull(rs.getString("MMRFUND_OVERDUESINCE")));
						hshRecord.put("MMRLC_DEBITCURRMONTH",Helper.converToLakhs(rs.getString("MMRFUND_DEBITCURRMONTH")));
						hshRecord.put("MMRLC_CREDITCURRMONTH",Helper.converToLakhs(rs.getString("MMRFUND_CREDITCURRMONTH")));
						hshRecord.put("MMRLC_CREDITURNOVER",Helper.converToLakhs(rs.getString("MMRFUND_CREDITURNOVER")));
						hshRecord.put("MMRLC_INSTALMENT",Helper.converToLakhs(rs.getString("MMRFUND_INSTALMENT")));
						
					}
					else if(correctNull(rs.getString("MMRFUND_FACILITY")).equals("LG"))
					{
						hshRecord.put("MMRLG_SANCAMT",Helper.converToLakhs(rs.getString("MMRFUND_SANCAMT")));
						hshRecord.put("MMRLG_DRAWINGPOWER",Helper.converToLakhs(rs.getString("MMRFUND_DRAWINGPOWER")));
						hshRecord.put("MMRLG_OSAMT",Helper.converToLakhs(rs.getString("MMRFUND_OSAMT")));
						hshRecord.put("MMRLG_OVERDUEAMT",Helper.converToLakhs(rs.getString("MMRFUND_OVERDUEAMT")));
						hshRecord.put("MMRLG_OVERDUESINCE",correctNull(rs.getString("MMRFUND_OVERDUESINCE")));
						hshRecord.put("MMRLG_DEBITCURRMONTH",Helper.converToLakhs(rs.getString("MMRFUND_DEBITCURRMONTH")));
						hshRecord.put("MMRLG_CREDITCURRMONTH",Helper.converToLakhs(rs.getString("MMRFUND_CREDITCURRMONTH")));
						hshRecord.put("MMRLG_CREDITURNOVER",Helper.converToLakhs(rs.getString("MMRFUND_CREDITURNOVER")));
						hshRecord.put("MMRLG_INSTALMENT",Helper.converToLakhs(rs.getString("MMRFUND_INSTALMENT")));
					}
					else if(correctNull(rs.getString("MMRFUND_FACILITY")).equals("BL"))
					{
						hshRecord.put("MMRBL_SANCAMT",Helper.converToLakhs(rs.getString("MMRFUND_SANCAMT")));
						hshRecord.put("MMRBL_DRAWINGPOWER",Helper.converToLakhs(rs.getString("MMRFUND_DRAWINGPOWER")));
						hshRecord.put("MMRBL_OSAMT",Helper.converToLakhs(rs.getString("MMRFUND_OSAMT")));
						hshRecord.put("MMRBL_OVERDUEAMT",Helper.converToLakhs(rs.getString("MMRFUND_OVERDUEAMT")));
						hshRecord.put("MMRBL_OVERDUESINCE",correctNull(rs.getString("MMRFUND_OVERDUESINCE")));
						hshRecord.put("MMRBL_DEBITCURRMONTH",Helper.converToLakhs(rs.getString("MMRFUND_DEBITCURRMONTH")));
						hshRecord.put("MMRBL_CREDITCURRMONTH",Helper.converToLakhs(rs.getString("MMRFUND_CREDITCURRMONTH")));
						hshRecord.put("MMRBL_CREDITURNOVER",Helper.converToLakhs(rs.getString("MMRFUND_CREDITURNOVER")));
						hshRecord.put("MMRBL_INSTALMENT",Helper.converToLakhs(rs.getString("MMRFUND_INSTALMENT")));
						blsancamt=rs.getDouble("MMRFUND_SANCAMT");
						blosamt=rs.getDouble("MMRFUND_OSAMT");
						bloverdueamt=rs.getDouble("MMRFUND_OVERDUEAMT");
					}
					if(!correctNull(rs.getString("MMRFUND_FACILITY")).equals("BL"))
					{
						nonfundbasedsanctionamout = nonfundbasedsanctionamout + Double.parseDouble(Helper.correctDouble(rs.getString("MMRFUND_SANCAMT")));
						nonfundbasedos_amount = nonfundbasedos_amount + Double.parseDouble(Helper.correctDouble(rs.getString("MMRFUND_OSAMT")));
						excess_nonfundbasedoverdues = excess_nonfundbasedoverdues + Double.parseDouble(Helper.correctDouble(rs.getString("MMRFUND_OVERDUEAMT")));
					}
				}
			}

			
			grandsanction_amount = sanction_amount + nonfundbasedsanctionamout+blsancamt;
			grandos_amount = os_amount + nonfundbasedos_amount+blosamt;
			grand_overduestotal = excess_fundbasedoverdues + excess_nonfundbasedoverdues+bloverdueamt;
			
			hshRecord.put("grandsanction_amount",Helper.converToLakhs(""+grandsanction_amount));
			hshRecord.put("grandos_amount",Helper.converToLakhs(""+grandos_amount));
			hshRecord.put("grand_overduestotal",Helper.converToLakhs(""+grand_overduestotal));
			
			hshRecord.put("nonfundbasedsanctionamout",Helper.converToLakhs(""+nonfundbasedsanctionamout));
			hshRecord.put("nonfundbasedos_amount",Helper.converToLakhs(""+nonfundbasedos_amount));
			
			hshRecord.put("excess_fundbasedoverdues",Helper.converToLakhs(""+excess_fundbasedoverdues));
			hshRecord.put("excess_nonfundbasedoverdues",Helper.converToLakhs(""+excess_nonfundbasedoverdues));
			
			hshRecord.put("sanction_amount",Helper.converToLakhs(""+sanction_amount));
			hshRecord.put("os_amount",Helper.converToLakhs(""+os_amount));
			
			hshRecord.put("arrRow",arrRow);
			
			
			
			String strcbsid=correctNull((String)hshValues.get("cbsid"));
				
			strQuery=SQLParser.getSqlQuery("sel_recoveredstatement^"+Strmmrno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
					hshRecord.put("mon_recworkmonth",correctNull(rs.getString("mon_recworkmonth")));
					hshRecord.put("mon_recworkvalue",Helper.converToLakhs(rs.getString("mon_recworkvalue")));
					hshRecord.put("mon_rectermmonth",correctNull(rs.getString("mon_rectermmonth")));
					hshRecord.put("mon_rectermvalue",Helper.converToLakhs(rs.getString("mon_rectermvalue")));
					hshRecord.put("mon_rectermins",correctNull(rs.getString("mon_rectermins")));
					hshRecord.put("mon_recterminsvalue",Helper.converToLakhs(rs.getString("mon_recterminsvalue")));
					hshRecord.put("mon_recage",correctNull(rs.getString("mon_recage")));
					
					
					hshRecord.put("mon_inlandthreemonth",Helper.converToLakhs(rs.getString("mon_inlandthreemonth")));
					hshRecord.put("mon_foreignthreemonth",Helper.converToLakhs(rs.getString("mon_foreignthreemonth")));
					hshRecord.put("mon_inlandsixmonth",Helper.converToLakhs(rs.getString("mon_inlandsixmonth")));
					hshRecord.put("mon_foreignsixmonth",Helper.converToLakhs(rs.getString("mon_foreignsixmonth")));
					hshRecord.put("mon_inlandmorethansixmonth",Helper.converToLakhs(rs.getString("mon_inlandmorethansixmonth")));
					hshRecord.put("mon_foreignmorethansixmonth",Helper.converToLakhs(rs.getString("mon_foreignmorethansixmonth")));
					hshRecord.put("mon_inlandtotal",Helper.converToLakhs(rs.getString("mon_inlandtotal")));
					hshRecord.put("mon_foreigntotal",Helper.converToLakhs(rs.getString("mon_foreigntotal")));
			}	
		
				arrRow = new ArrayList();
				strQuery = SQLParser.getSqlQuery("sel_monhedgeddetails^"+Strmmrno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				//arrCol.add(correctNull(rs.getString("slno")));//0
				//arrCol.add(correctNull(rs.getString("mon_hedgeddetailscbsid")));//1
				//arrCol.add(correctNull(rs.getString("mon_hedgeddetailscbsaccountno")));//2
				//arrCol.add(correctNull(rs.getString("mon_hedgeddetailsmonth")));//3
				//arrCol.add(correctNull(rs.getString("mon_hedgeddetailsyear")));//4
				//arrCol.add(correctNull(rs.getString("mon_hedgeddetailssalesquarter")));//5
				//arrCol.add(correctNull(rs.getString("mon_hedgeddetailssalesamount")));//6
				arrCol.add(correctNull(rs.getString("mon_hedgeddetailsnature")));//7
				arrCol.add(Helper.converToLakhs(rs.getString("mon_hedgeddetailsamount")));//8
				//arrCol.add(correctNull(rs.getString("mon_hedgeddetailswhetherhedged")));//9
				//arrCol.add(correctNull(rs.getString("mon_hedgeddetailsexcessmonth")));//10
				//arrCol.add(correctNull(rs.getString("mon_hedgeddetailsexcesscurrent")));//11
				
				arrRow.add(arrCol);
			}			
			hshRecord.put("arrRow1",arrRow);
			
			
			strQuery=SQLParser.getSqlQuery("sel_monauditcomments^"+strAudittype+"^"+Strmmrno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				//hshResult.put("mon_custid",correctNull(rs.getString("mon_custid")));
				hshRecord.put("auditorscomments",correctNull(rs.getString("mon_auditorcomments")));
				hshRecord.put("officercomments",correctNull(rs.getString("mon_officerscomments")));
				hshRecord.put("auditdate",correctNull(rs.getString("mon_auditdate")));
			}
			
			
			
			arrRow = new ArrayList();
			strQuery=SQLParser.getSqlQuery("selconsortium^"+Strmmrno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				//arrCol.add(correctNull(rs.getString("mmr_sno")));
				arrCol.add(correctNull(rs.getString("mmr_bankname")));
				//arrCol.add(correctNull(rs.getString("mmr_branch")));
				arrCol.add(correctNull(rs.getString("mmr_sharepercent")));
				//arrCol.add(correctNull(rs.getString("mmr_assetclasification")));
				//arrCol.add(correctNull(rs.getString("mmr_fundbasedname")));
				arrCol.add(correctNull(rs.getString("mmr_fundbasedamount")));
				//arrCol.add(correctNull(rs.getString("mmr_nonfundbasedname")));
				arrCol.add(correctNull(rs.getString("mmr_nonfundbasedamount")));
				//arrCol.add(correctNull(rs.getString("mmr_overdue")));
				//arrCol.add(correctNull(rs.getString("mmr_remarks")));
				if(correctNull(rs.getString("mmr_leadbank")).equals("1"))
				{
					hshRecord.put("LeadBankName",correctNull(rs.getString("mmr_branch")));
				}
				arrCol.add(correctNull(rs.getString("mmr_leadbank")));
				arrCol.add(correctNull(rs.getString("mmr_nonfundsharepercent")));
				arrCol.add(correctNull(rs.getString("mmr_fundsharepercent")));
				arrRow.add(arrCol);
			}			
			hshRecord.put("arrRow3",arrRow);
			
			int j=0;
			StringBuffer strAppend = new StringBuffer();
			StringBuffer strAppend1 = new StringBuffer();
			
			StringBuffer primeSecurities = new StringBuffer();
			StringBuffer colateralSecurity = new StringBuffer();
			arrRow = new ArrayList();
			//Code Changed By Kamal as per requirement on 31/03/2010
			strQuery = SQLParser.getSqlQuery("sel_monitoraccno^"+strcbsid);
			rs2 = DBUtils.executeQuery(strQuery);	
			while (rs2.next())
			{ 
				
				if(j!=0)
				{
					strAppend.append(",");
					strAppend1.append(",");
				}
				
				strAppend1.append("'").append(correctNull(rs2.getString("LIMIT_CUTACCNO"))).append("'");
				strAppend.append(correctNull(rs2.getString("LIMIT_CUTACCNO")));
				
					
			
			
				strQuery=SQLParser.getSqlQuery("selsecurityreg1^"+correctNull(rs2.getString("LIMIT_CUTACCNO"))+"^"+Strmmrno);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					if(correctNull(rs.getString("monsec_maskflag")).equalsIgnoreCase("N") || (correctNull(rs.getString("monsec_maskflag")).equalsIgnoreCase("Y") && !correctNull(rs.getString("mon_insuamt")).equalsIgnoreCase("")) )
					{
						arrCol = new ArrayList();
						arrCol.add(correctNull(rs.getString("MONSEC_SNO")));
						arrCol.add(correctNull(rs.getString("MONSEC_ACCOUNTNUMBER")));
						if(correctNull(rs.getString("MONSEC_SECURITYTYPE")).equals("1"))
						{
							primeSecurities.append(correctNull(rs.getString("STAT_DATA_DESC1"))).append(" - ").append(correctNull(rs.getString("monsec_shortfallnoticed"))).append("<br>&nbsp;");
						}
						else
						{
							colateralSecurity.append(correctNull(rs.getString("STAT_DATA_DESC1"))).append(" - ").append(correctNull(rs.getString("monsec_shortfallnoticed"))).append("<br>&nbsp;");
						}
						arrCol.add(correctNull(rs.getString("MONSEC_SECURITYTYPE")));
						arrCol.add(correctNull(rs.getString("MONSEC_SECURITYNATURE")));
						arrCol.add(correctNull(rs.getString("MONSEC_OTHERDETAILS")));
						//arrCol.add(correctNull(rs.getString("MONSEC_ADD1")));
						//arrCol.add(correctNull(rs.getString("MONSEC_ADD2")));
						//arrCol.add(correctNull(rs.getString("MONSEC_CITY")));
						//arrCol.add(correctNull(rs.getString("MONSEC_STATE")));
						//arrCol.add(correctNull(rs.getString("MONSEC_PINCODE")));
						arrCol.add(correctNull(rs.getString("MON_INSUSLRNO")));
						arrCol.add(Helper.converToLakhs(rs.getString("MONSEC_VALUATAMOUNT")));
						arrCol.add(correctNull(rs.getString("MONSEC_VALUATDATE")));
						arrCol.add(correctNull(rs.getString("MONSEC_VALUTDONEBY")));
						arrCol.add(correctNull(rs.getString("MONSEC_INSPECTEDBY")));
						arrCol.add(correctNull(rs.getString("MONSEC_INSPECTEDON")));
						
						arrCol.add(correctNull((String)rs.getString("MON_SECUINSUEXP")));
						arrCol.add(Helper.converToLakhs((String)rs.getString("MON_INSUAMT")));
						/*strQuery=SQLParser.getSqlQuery("sel_Mon_register_expYear^"+correctNull(rs.getString("MONSEC_ACCOUNTNUMBER"))+"^"+strcbsid+"^"+correctNull(rs.getString("MONSEC_INSURANCENO")));
						rs1=DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{	
							arrCol.add(correctNull((String)rs1.getString("ins_expirydate")));
							arrCol.add(Helper.converToLakhs((String)rs1.getString("ins_coveramt")));
						}
						else
						{
							arrCol.add("");
							arrCol.add("");
						}*/
						arrCol.add(correctNull(rs.getString("STAT_DATA_DESC1")));
						arrRow.add(arrCol);
					}
				}		
				j++;
			}	
			hshRecord.put("arrRow2",arrRow);
			
			hshRecord.put("primeSecurities",primeSecurities.toString());
			hshRecord.put("colateralSecurity",colateralSecurity.toString());
			
			strQuery=SQLParser.getSqlQuery("sel_mettingstatement^"+Strmmrno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("mon_dateofmet",correctNull(rs.getString("mon_dateofmet")));
					hshRecord.put("mon_minutesmet",correctNull(rs.getString("mon_minutesmet")));
					//hshRecord.put("mon_received",correctNull(rs.getString("mon_received")));
					hshRecord.put("mon_noofmeetingheld",correctNull(rs.getString("mon_noofmeetingheld")));
				}			
				
				
			hshRecord.put("mon_accwiseaccountno",strAppend.toString());
			
			
			strQuery = SQLParser.getSqlQuery("sel_branchheadcomments^"+Strmmrno);
			rs = DBUtils.executeQuery(strQuery);	
			if (rs.next())
			{ 
				hshRecord.put("mon_operation",correctNull(rs.getString("mon_operation")));
				hshRecord.put("mon_operationdetails",correctNull(rs.getString("mon_operationdetails")));
				hshRecord.put("mon_sanction",correctNull(rs.getString("mon_sanction")));
				hshRecord.put("mon_sanctiondetails",correctNull(rs.getString("mon_sanctiondetails")));
				hshRecord.put("mon_irregular",correctNull(rs.getString("mon_irregular")));
				hshRecord.put("mon_irregulardetails",correctNull(rs.getString("mon_irregulardetails")));
				hshRecord.put("mon_observation",correctNull(rs.getString("mon_observation")));
				hshRecord.put("mon_observationdetails",correctNull(rs.getString("mon_observationdetails")));		
			}
			
			
			
		
			
			strQuery = SQLParser.getSqlQuery("selmonitoringinfo^"+Strmmrno);
			rs = DBUtils.executeQuery(strQuery);	
			if (rs.next())
			{ 
				hshRecord.put("mmr_infoinspectiondate",correctNull(rs.getString("mmr_infoinspectiondate")));
				hshRecord.put("mmr_infotermscond",correctNull(rs.getString("mmr_infotermscond")));
				hshRecord.put("mmr_infoprofitabilty",correctNull(rs.getString("mmr_infoprofitabilty")));
				hshRecord.put("mmr_infocolenders",correctNull(rs.getString("mmr_infocolenders")));
				
				
				
				hshRecord.put("mmr_infomanageperson",correctNull(rs.getString("mmr_infomanageperson")));
				hshRecord.put("mmr_infotermreason",correctNull(rs.getString("mmr_infotermreason")));
				hshRecord.put("mmr_infoadversedreason",correctNull(rs.getString("mmr_infoadversedreason")));
				hshRecord.put("mmr_infoprofitabiltyreason",correctNull(rs.getString("mmr_infoprofitabiltyreason")));
				hshRecord.put("mmr_infocolendersreason",correctNull(rs.getString("mmr_infocolendersreason")));
				hshRecord.put("mmr_infomanagepersonreason",correctNull(rs.getString("mmr_infomanagepersonreason")));
				
				hshRecord.put("mmr_infomonth",correctNull(rs.getString("mmr_infomonth")));
				hshRecord.put("mmr_infoyear",correctNull(rs.getString("mmr_infoyear")));
				
				hshRecord.put("mon_salesquarter",correctNull(rs.getString("mon_salesquarter")));
				hshRecord.put("mon_salesamount",Helper.converToLakhs(rs.getString("mon_salesamount")));
			}
			
			
			arrRow = new ArrayList();
			
			
			
			strQuery = SQLParser.getSqlQuery("sel_facilty_mon_limit_register^"+strcbsid);
			rs = DBUtils.executeQuery(strQuery);	
			while(rs.next())
			{
				
				
				if(rs1!=null)
					rs1.close();
				
				strQuery=SQLParser.getSqlQuery("seldocumentregister^"+correctNull(rs.getString("LIMIT_CUTACCNO")));
				rs1=DBUtils.executeQuery(strQuery);
				int count = 0;
				if(rs1.next())
				{
					rs1.last();
					 count = rs1.getRow();
					rs1.beforeFirst();
				
					while(rs1.next())
					{
						arrCol = new ArrayList();
						arrCol.add(correctNull(rs.getString("stat_data_desc1")));
						arrCol.add(correctNull((String)rs1.getString("doc_documentname")));
						arrCol.add(correctNull((String)rs1.getString("doc_executeddate")));
						arrCol.add(""+count);
						arrRow.add(arrCol);
					}
				}
				
			}
			hshRecord.put("arrRow5",arrRow);
			
			
			
			arrRow = new ArrayList();
			
			strQuery = SQLParser.getSqlQuery("sel_monauditcomments_all_type^"+Strmmrno);
			rs = DBUtils.executeQuery(strQuery);	
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("mon_audittype")));
				arrCol.add(correctNull(rs.getString("mon_auditdate")));
				arrCol.add(correctNull(rs.getString("mon_auditorcomments")));
				arrCol.add(correctNull(rs.getString("mon_officerscomments")));
				arrRow.add(arrCol);
			}
			
			hshRecord.put("arrRow6",arrRow);
			
			
			
			strQuery=SQLParser.getSqlQuery("sel_Mon_Checklist_MaximumDbc^"+strAppend1.toString());
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("mon_dbcdate",correctNull(rs.getString("mon_dbcdate")));
			}
			
			strQuery=SQLParser.getSqlQuery("sel_Mon_Checklist_MaximumRoc^"+strAppend1.toString());
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("mon_rocdate",correctNull(rs.getString("mon_rocdate")));
				hshRecord.put("mon_roc",correctNull(rs.getString("mon_roc")));
			}
			/*strQuery=SQLParser.getSqlQuery("sel_monchecklist^"+strCustAccno);
			rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("mon_roc",correctNull(rs.getString("mon_roc")));
					hshRecord.put("mon_rocdate",correctNull(rs.getString("mon_rocdate")));
					hshRecord.put("mon_resolutiondate",correctNull(rs.getString("mon_resolutiondate")));
					
					hshRecord.put("mon_dbc",correctNull(rs.getString("mon_dbc")));
					hshRecord.put("mon_dbcdate",correctNull(rs.getString("mon_dbcdate")));
					hshRecord.put("mon_dbcamount",correctNull(rs.getString("mon_dbcamount")));
					hshRecord.put("mon_guarantor",correctNull(rs.getString("mon_guarantor")));
					hshRecord.put("mon_guarantorsigned",correctNull(rs.getString("mon_guarantorsigned")));
					hshRecord.put("mon_equitable",correctNull(rs.getString("mon_equitable")));
					hshRecord.put("mon_equitperfect",correctNull(rs.getString("mon_equitperfect")));
					
					hshRecord.put("mon_checkmsod",correctNull(rs.getString("mon_checkmsod")));
					hshRecord.put("mon_checkstock",correctNull(rs.getString("mon_checkstock")));
					hshRecord.put("mon_checkbkdebts",correctNull(rs.getString("mon_checkbkdebts")));
					hshRecord.put("mon_checkqpr",correctNull(rs.getString("mon_checkqpr")));
					hshRecord.put("mon_inspection",correctNull(rs.getString("mon_inspection")));
				}*/
		
				
			strQuery=SQLParser.getSqlQuery("sel_mon_generalinfo^"+Strmmrno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("acc_categorization",(correctNull(rs.getString("gen_acc_clasification"))));
				hshRecord.put("acc_stress",(correctNull(rs.getString("gen_accStressY"))));
				hshRecord.put("acc_stress_reason",(correctNull(rs.getString("gen_accstress_reason"))));
				hshRecord.put("acc_restructered",(correctNull(rs.getString("gen_accrestructY"))));
				hshRecord.put("acc_restructterms",(correctNull(rs.getString("gen_termscompiledY"))));
				hshRecord.put("acc_restructtermsreasons",(correctNull(rs.getString("gen_termscompiledreasons"))));
				hshRecord.put("presentrating",(correctNull(rs.getString("gen_presentyearrating"))));
				hshRecord.put("prevrating",(correctNull(rs.getString("gen_prevyearrating"))));
				hshRecord.put("downgradereason",(correctNull(rs.getString("gen_downgradereason"))));
				hshRecord.put("documentobtained",(correctNull(rs.getString("gen_docobtained"))));
				hshRecord.put("creditauditdate",(correctNull(rs.getString("gen_creditauditdate"))));
				hshRecord.put("documentvetted",(correctNull(rs.getString("gen_docvetted"))));
				hshRecord.put("docvettedreasons",(correctNull(rs.getString("gen_docvettedreasons"))));
				hshRecord.put("docdeficiencies",(correctNull(rs.getString("gen_docdeficiencies"))));
				hshRecord.put("borrower_Date",(correctNull(rs.getString("gen_borrowerdate"))));
				
				hshRecord.put("roc_reasons",(correctNull(rs.getString("roc_reasons"))));
				
				hshRecord.put("mon_deviation",(correctNull(rs.getString("mon_deviation"))));
				hshRecord.put("mon_compliance",(correctNull(rs.getString("mon_compliance"))));
				
				hshRecord.put("lawyername",(correctNull(rs.getString("gen_lawyername"))));
			}
			arrRow = new ArrayList();
			String limit_reviewdate ="";
			strQuery=SQLParser.getSqlQuery("sel_ReviewDate_sanction_auth^"+strcbsid);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("limit_sancauth")));
				arrCol.add(correctNull(rs.getString("limit_sanctionlevel")));
				
				limit_reviewdate = correctNull(rs.getString("limit_reviewdate"));
				if(limit_reviewdate.indexOf("/")!=-1)
				{
					limit_reviewdate = Helper.getMonths(Integer.parseInt(Helper.correctInt(limit_reviewdate.split("/")[1])))+" "+limit_reviewdate.split("/")[2];
				}
				arrCol.add(limit_reviewdate);
				arrRow.add(arrCol);
			}
			
			hshRecord.put("arrRow8",arrRow);
			
			String comapp_region_code="";
			
			int code=org_Code_MMr.length();
			if(code==15)
			{  
				comapp_region_code = org_Code_MMr.substring(0,9)+"000000";
				
			}
		    
			
			
			
			strQuery = SQLParser.getSqlQuery("setorgselect^"+comapp_region_code);
			rs = DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
				hshRecord.put("RespectiveRegion",correctNull(rs.getString("org_name")));
			}
			
			
			strQuery = SQLParser.getSqlQuery("selmonitoringinformatiom^"+Strmmrno);
			rs = DBUtils.executeQuery(strQuery);	
			if (rs.next())
			{ 
				hshRecord.put("mon_monitinfcbsid",correctNull(rs.getString("mon_monitinfcbsid")));
				hshRecord.put("mon_monitinfgovtpolicy",correctNull(rs.getString("mon_monitinfgovtpolicy")));
				hshRecord.put("mon_monitinfqpr",correctNull(rs.getString("mon_monitinfqpr")));
				hshRecord.put("mon_monitinfpenalinterst",correctNull(rs.getString("mon_monitinfpenalinterst")));
				hshRecord.put("mon_monitinfledger",correctNull(rs.getString("mon_monitinfledger")));
				hshRecord.put("mon_monitinfrectification",correctNull(rs.getString("mon_monitinfrectification")));
				
				hshRecord.put("mon_monitinfgovtpolicyrson",correctNull(rs.getString("mon_monitinfgovtpolicyrson")));
				hshRecord.put("mon_monitinfpenalinterstrson",correctNull(rs.getString("mon_monitinfpenalinterstrson")));
				hshRecord.put("mon_monitinfrectificationrson",correctNull(rs.getString("mon_monitinfrectificationrson")));
				hshRecord.put("mon_monitinfnonsecrutiniserson",correctNull(rs.getString("mon_monitinfnonsecrutiniserson")));
				
				hshRecord.put("mon_monitinfmonth",correctNull(rs.getString("mon_monitinfmonth")));
				hshRecord.put("mon_monitinfyear",correctNull(rs.getString("mon_monitinfyear")));
				
				
			}
		
			rs=DBUtils.executeLAPSQuery("sel_mon_excess_reason^"+Strmmrno);
			if(rs.next())
			{
				hshRecord.put("gen_reasons",(correctNull(rs.getString("gen_reasons"))));
				hshRecord.put("downgradecommencement",(correctNull(rs.getString("gen_commencements"))));
				
				hshRecord.put("renewalcompiled",(correctNull(rs.getString("renewalcompiled"))));
				hshRecord.put("ren_submitted",(correctNull(rs.getString("ren_submitted"))));
				hshRecord.put("ren_submitted_reasons",(correctNull(rs.getString("ren_submitted_reasons"))));
				
			}
			
			arrRow = new ArrayList();
			
			boolean checkData = true;
			
			strQuery=SQLParser.getSqlQuery("selmonaccountexcess^"+Strmmrno);
	 		
	 		rs=DBUtils.executeQuery(strQuery);
	 		while(rs.next())
			{
	 			arrCol = new ArrayList();
	 			arrCol.add(rs.getString("mon_facility"));
	 			arrCol.add(rs.getString("mon_duringmonth"));
	 			arrCol.add(rs.getString("mon_currentmonth"));
	 			arrRow.add(arrCol);
	 			checkData = false;
	 	    }
	 		if(checkData)
	 		{	
		 		strQuery=SQLParser.getSqlQuery("getaccountexcessfacilitydata^"+Strmmrno);
		 		
		 		rs=DBUtils.executeQuery(strQuery);
		 		while(rs.next())
				{
		 			arrCol = new ArrayList();
		 			arrCol.add(correctNull(rs.getString("MMRFUND_FACILITY")));
		 			arrCol.add("");
		 			arrCol.add("");
		 			arrRow.add(arrCol);
		 	    }
		 		
		 		arrCol = new ArrayList();
	 			arrCol.add("Letter of Credit");
	 			arrCol.add("");
	 			arrCol.add("");
	 			arrRow.add(arrCol);
	 			
	 			arrCol = new ArrayList();
	 			arrCol.add("Letter of Guatantee");
	 			arrCol.add("");
	 			arrCol.add("");
	 			arrRow.add(arrCol);
		 		
	 		}
	 		hshRecord.put("arrRow7",arrRow);
	 		
	 		
	 		
	 		if(rs!=null)rs.close();
	        rs = DBUtils.executeLAPSQuery("sel_mon_mail_comments^"+Strmmrno);
	        arrRow=new ArrayList();
	        arrCol=new ArrayList();
	        while(rs.next())
	        {
	     	   arrCol=new ArrayList();
	     	   arrCol.add(correctNull(rs.getString("usr_fname")));
	     	   arrCol.add(correctNull(Helper.correctNull((String)rs.getString("mail_comments"))));
	     	   arrRow.add(arrCol);
	        }
	        
	        hshRecord.put("mailcomments",arrRow);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getMMRReportPrint"+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
				if(rs1 != null)
				rs1.close();
				
				if(rs2!=null)
					rs2.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	/*
	 *  THIS METHOD ADDED BY SUBHA FOR MMR REPORT APRIL 2012 PRINT AS PER SURESHKUMAR SAID ON 04/04/2012 
	 */
		
		public HashMap getMMRReportApril2012Print(HashMap hshValues)
		{
			HashMap hshRecord=new HashMap();
			ResultSet rs=null;
			ResultSet rs1=null;
			ResultSet rs2=null;
			String cbsid=correctNull((String)hshValues.get("cbsid"));
			String Strmmrno=correctNull((String)hshValues.get("mmrno"));
			String mon_month=correctNull((String)hshValues.get("mon_month"));
			String mon_year=correctNull((String)hshValues.get("mon_year"));
			String org_Code_MMr="";
			hshRecord.put("cbsid",cbsid);
			hshRecord.put("str_Month_alp",Helper.getMonths(Integer.parseInt(Helper.correctInt(mon_month)))+" "+mon_year);
					
			
						
			String strAudittype=correctNull((String)hshValues.get("sel_audittype"));
			
			try
			{
				ArrayList arrRow = new ArrayList();
				ArrayList arrCol = null;
				
				String strQuery="";
			
				if (rs != null) {
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("getSearchData^"+cbsid+"^"+mon_month+"^"+mon_year);
				rs	=	DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					
					strQuery=SQLParser.getSqlQuery("setorgselectapp^"+(correctNull(rs.getString("mmr_orgscode"))));
					rs1	=	DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						hshRecord.put("branch",(correctNull((String)rs1.getString("org_name"))));
						
						org_Code_MMr = correctNull((String)rs1.getString("org_code"));
					}
					
					
					
					hshRecord.put("activity",(correctNull(rs.getString("PERSONAL_NATOFACTIVITY"))));
				
					hshRecord.put("address",(correctNull(rs.getString("PERSONAL_ADDRESS"))));
					hshRecord.put("address1",(correctNull(rs.getString("PERSONAL_ADDRESS1"))));
					hshRecord.put("city",(correctNull(rs.getString("city"))));
					hshRecord.put("state",(correctNull(rs.getString("state"))));
					hshRecord.put("pincode",(correctNull(rs.getString("PERSONAL_PINCODE"))));
					hshRecord.put("phoneno",(correctNull(rs.getString("PERSONAL_PHONE"))));
					hshRecord.put("mobile",(correctNull(rs.getString("PERSONAL_MOBILE"))));
					hshRecord.put("constitution",(correctNull(rs.getString("PERSONAL_CONSTITUTION"))));
					hshRecord.put("since",(correctNull(rs.getString("PERSONAL_BANKINGSINCE"))));
				
					
				}
				
				
				strQuery=SQLParser.getSqlQuery("sel_borrowerinfo_detail^"+Strmmrno);
				rs	=	DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("arrange",(correctNull(rs.getString("borrower_bankarrangement"))));
					hshRecord.put("contactname",(correctNull(rs.getString("borrower_contactname"))));
					hshRecord.put("contact_per_design",(correctNull(rs.getString("borrower_contperdesign"))));
					hshRecord.put("contact_landline",(correctNull(rs.getString("borrower_landline"))));
					hshRecord.put("contact_mobile",(correctNull(rs.getString("borrower_contpermobile"))));
					hshRecord.put("personal_leadbankvetted",(correctNull(rs.getString("borrower_leadbankvetted"))));
					hshRecord.put("personal_stipdocuments",(correctNull(rs.getString("borrower_stipdocuments"))));
				}	
				
				
				double sanction_amount=0.00,os_amount=0.00,nonfundbasedsanctionamout=0.00,
				nonfundbasedos_amount=0.00,grandsanction_amount=0.00,grandos_amount=0.00,excess_fundbasedoverdues=0.00,excess_nonfundbasedoverdues=0.00,grand_overduestotal=0.00;
				double blsancamt=0.0, blosamt=0.0,bloverdueamt=0.0;
				rs=DBUtils.executeLAPSQuery("getmmrfundbased^"+Strmmrno);
				while(rs.next())
				{
					if(!correctNull(rs.getString("MMRFUND_FACILITY")).equals("LC") && !correctNull(rs.getString("MMRFUND_FACILITY")).equals("LG") && !correctNull(rs.getString("MMRFUND_FACILITY")).equals("BL"))
					{
					
						arrCol=new ArrayList();
						arrCol.add(correctNull(rs.getString("MMRFUND_CUSTID")));
						arrCol.add(correctNull(rs.getString("MMRFUND_ACCNO")));
						arrCol.add(correctNull(rs.getString("MMRFUND_FACILITY")));
						arrCol.add(Helper.converToLakhs(rs.getString("MMRFUND_SANCAMT")));
						arrCol.add(Helper.converToLakhs(rs.getString("MMRFUND_DRAWINGPOWER")));
						arrCol.add(Helper.converToLakhs(rs.getString("MMRFUND_OSAMT")));
						arrCol.add(Helper.converToLakhs(rs.getString("MMRFUND_OVERDUEAMT")));
						arrCol.add(correctNull(rs.getString("MMRFUND_OVERDUESINCE")));
						arrCol.add(Helper.converToLakhs(rs.getString("MMRFUND_DEBITCURRMONTH")));
						arrCol.add(Helper.converToLakhs(rs.getString("MMRFUND_CREDITCURRMONTH")));
						arrCol.add(Helper.converToLakhs(rs.getString("MMRFUND_CREDITURNOVER")));
						arrCol.add(Helper.converToLakhs(rs.getString("MMRFUND_INSTALMENT")));
						
						
						sanction_amount = sanction_amount + Double.parseDouble(Helper.correctDouble(rs.getString("MMRFUND_SANCAMT")));
						os_amount = os_amount + Double.parseDouble(Helper.correctDouble(rs.getString("MMRFUND_OSAMT")));
						excess_fundbasedoverdues = excess_fundbasedoverdues + Double.parseDouble(Helper.correctDouble(rs.getString("MMRFUND_OVERDUEAMT")));
						hshRecord.put("appcreatedate",correctNull(rs.getString("MMRFUND_MODIFIEDDATE")));
					
						arrRow.add(arrCol);
					}
					else
					{
						if(correctNull(rs.getString("MMRFUND_FACILITY")).equals("LC"))
						{
							hshRecord.put("MMRLC_SANCAMT",Helper.converToLakhs(rs.getString("MMRFUND_SANCAMT")));
							hshRecord.put("MMRLC_DRAWINGPOWER",Helper.converToLakhs(rs.getString("MMRFUND_DRAWINGPOWER")));
							hshRecord.put("MMRLC_OSAMT",Helper.converToLakhs(rs.getString("MMRFUND_OSAMT")));
							hshRecord.put("MMRLC_OVERDUEAMT",Helper.converToLakhs(rs.getString("MMRFUND_OVERDUEAMT")));
							hshRecord.put("MMRLC_OVERDUESINCE",correctNull(rs.getString("MMRFUND_OVERDUESINCE")));
							hshRecord.put("MMRLC_DEBITCURRMONTH",Helper.converToLakhs(rs.getString("MMRFUND_DEBITCURRMONTH")));
							hshRecord.put("MMRLC_CREDITCURRMONTH",Helper.converToLakhs(rs.getString("MMRFUND_CREDITCURRMONTH")));
							hshRecord.put("MMRLC_CREDITURNOVER",Helper.converToLakhs(rs.getString("MMRFUND_CREDITURNOVER")));
							hshRecord.put("MMRLC_INSTALMENT",Helper.converToLakhs(rs.getString("MMRFUND_INSTALMENT")));
							
						}
						else if(correctNull(rs.getString("MMRFUND_FACILITY")).equals("LG"))
						{
							hshRecord.put("MMRLG_SANCAMT",Helper.converToLakhs(rs.getString("MMRFUND_SANCAMT")));
							hshRecord.put("MMRLG_DRAWINGPOWER",Helper.converToLakhs(rs.getString("MMRFUND_DRAWINGPOWER")));
							hshRecord.put("MMRLG_OSAMT",Helper.converToLakhs(rs.getString("MMRFUND_OSAMT")));
							hshRecord.put("MMRLG_OVERDUEAMT",Helper.converToLakhs(rs.getString("MMRFUND_OVERDUEAMT")));
							hshRecord.put("MMRLG_OVERDUESINCE",correctNull(rs.getString("MMRFUND_OVERDUESINCE")));
							hshRecord.put("MMRLG_DEBITCURRMONTH",Helper.converToLakhs(rs.getString("MMRFUND_DEBITCURRMONTH")));
							hshRecord.put("MMRLG_CREDITCURRMONTH",Helper.converToLakhs(rs.getString("MMRFUND_CREDITCURRMONTH")));
							hshRecord.put("MMRLG_CREDITURNOVER",Helper.converToLakhs(rs.getString("MMRFUND_CREDITURNOVER")));
							hshRecord.put("MMRLG_INSTALMENT",Helper.converToLakhs(rs.getString("MMRFUND_INSTALMENT")));
						}
						else if(correctNull(rs.getString("MMRFUND_FACILITY")).equals("BL"))
						{
							hshRecord.put("MMRBL_SANCAMT",Helper.converToLakhs(rs.getString("MMRFUND_SANCAMT")));
							hshRecord.put("MMRBL_DRAWINGPOWER",Helper.converToLakhs(rs.getString("MMRFUND_DRAWINGPOWER")));
							hshRecord.put("MMRBL_OSAMT",Helper.converToLakhs(rs.getString("MMRFUND_OSAMT")));
							hshRecord.put("MMRBL_OVERDUEAMT",Helper.converToLakhs(rs.getString("MMRFUND_OVERDUEAMT")));
							hshRecord.put("MMRBL_OVERDUESINCE",correctNull(rs.getString("MMRFUND_OVERDUESINCE")));
							hshRecord.put("MMRBL_DEBITCURRMONTH",Helper.converToLakhs(rs.getString("MMRFUND_DEBITCURRMONTH")));
							hshRecord.put("MMRBL_CREDITCURRMONTH",Helper.converToLakhs(rs.getString("MMRFUND_CREDITCURRMONTH")));
							hshRecord.put("MMRBL_CREDITURNOVER",Helper.converToLakhs(rs.getString("MMRFUND_CREDITURNOVER")));
							hshRecord.put("MMRBL_INSTALMENT",Helper.converToLakhs(rs.getString("MMRFUND_INSTALMENT")));
							blsancamt=rs.getDouble("MMRFUND_SANCAMT");
							blosamt=rs.getDouble("MMRFUND_OSAMT");
							bloverdueamt=rs.getDouble("MMRFUND_OVERDUEAMT");
						}
						if(!correctNull(rs.getString("MMRFUND_FACILITY")).equals("BL"))
						{
							nonfundbasedsanctionamout = nonfundbasedsanctionamout + Double.parseDouble(Helper.correctDouble(rs.getString("MMRFUND_SANCAMT")));
							nonfundbasedos_amount = nonfundbasedos_amount + Double.parseDouble(Helper.correctDouble(rs.getString("MMRFUND_OSAMT")));
							excess_nonfundbasedoverdues = excess_nonfundbasedoverdues + Double.parseDouble(Helper.correctDouble(rs.getString("MMRFUND_OVERDUEAMT")));
						}
					}
				}

				
				grandsanction_amount = sanction_amount + nonfundbasedsanctionamout+blsancamt;
				grandos_amount = os_amount + nonfundbasedos_amount+blosamt;
				grand_overduestotal = excess_fundbasedoverdues + excess_nonfundbasedoverdues+bloverdueamt;
				
				hshRecord.put("grandsanction_amount",Helper.converToLakhs(""+grandsanction_amount));
				hshRecord.put("grandos_amount",Helper.converToLakhs(""+grandos_amount));
				hshRecord.put("grand_overduestotal",Helper.converToLakhs(""+grand_overduestotal));
				
				hshRecord.put("nonfundbasedsanctionamout",Helper.converToLakhs(""+nonfundbasedsanctionamout));
				hshRecord.put("nonfundbasedos_amount",Helper.converToLakhs(""+nonfundbasedos_amount));
				
				hshRecord.put("excess_fundbasedoverdues",Helper.converToLakhs(""+excess_fundbasedoverdues));
				hshRecord.put("excess_nonfundbasedoverdues",Helper.converToLakhs(""+excess_nonfundbasedoverdues));
				
				hshRecord.put("sanction_amount",Helper.converToLakhs(""+sanction_amount));
				hshRecord.put("os_amount",Helper.converToLakhs(""+os_amount));
				
				hshRecord.put("arrRow",arrRow);
				
				
				
				String strcbsid=correctNull((String)hshValues.get("cbsid"));
					
				strQuery=SQLParser.getSqlQuery("sel_recoveredstatement^"+Strmmrno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
						hshRecord.put("mon_recworkmonth",correctNull(rs.getString("mon_recworkmonth")));
						hshRecord.put("mon_recworkvalue",Helper.converToLakhs(rs.getString("mon_recworkvalue")));
						hshRecord.put("mon_rectermmonth",correctNull(rs.getString("mon_rectermmonth")));
						hshRecord.put("mon_rectermvalue",Helper.converToLakhs(rs.getString("mon_rectermvalue")));
						hshRecord.put("mon_rectermins",correctNull(rs.getString("mon_rectermins")));
						hshRecord.put("mon_recterminsvalue",Helper.converToLakhs(rs.getString("mon_recterminsvalue")));
						hshRecord.put("mon_recage",correctNull(rs.getString("mon_recage")));
						
						
						hshRecord.put("mon_inlandthreemonth",Helper.converToLakhs(rs.getString("mon_inlandthreemonth")));
						hshRecord.put("mon_foreignthreemonth",Helper.converToLakhs(rs.getString("mon_foreignthreemonth")));
						hshRecord.put("mon_inlandsixmonth",Helper.converToLakhs(rs.getString("mon_inlandsixmonth")));
						hshRecord.put("mon_foreignsixmonth",Helper.converToLakhs(rs.getString("mon_foreignsixmonth")));
						hshRecord.put("mon_inlandmorethansixmonth",Helper.converToLakhs(rs.getString("mon_inlandmorethansixmonth")));
						hshRecord.put("mon_foreignmorethansixmonth",Helper.converToLakhs(rs.getString("mon_foreignmorethansixmonth")));
						hshRecord.put("mon_inlandtotal",Helper.converToLakhs(rs.getString("mon_inlandtotal")));
						hshRecord.put("mon_foreigntotal",Helper.converToLakhs(rs.getString("mon_foreigntotal")));
				}	
			
					arrRow = new ArrayList();
					strQuery = SQLParser.getSqlQuery("sel_monhedgeddetails^"+Strmmrno);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol = new ArrayList();
					//arrCol.add(correctNull(rs.getString("slno")));//0
					//arrCol.add(correctNull(rs.getString("mon_hedgeddetailscbsid")));//1
					//arrCol.add(correctNull(rs.getString("mon_hedgeddetailscbsaccountno")));//2
					//arrCol.add(correctNull(rs.getString("mon_hedgeddetailsmonth")));//3
					//arrCol.add(correctNull(rs.getString("mon_hedgeddetailsyear")));//4
					//arrCol.add(correctNull(rs.getString("mon_hedgeddetailssalesquarter")));//5
					//arrCol.add(correctNull(rs.getString("mon_hedgeddetailssalesamount")));//6
					arrCol.add(correctNull(rs.getString("mon_hedgeddetailsnature")));//7
					arrCol.add(Helper.converToLakhs(rs.getString("mon_hedgeddetailsamount")));//8
					//arrCol.add(correctNull(rs.getString("mon_hedgeddetailswhetherhedged")));//9
					//arrCol.add(correctNull(rs.getString("mon_hedgeddetailsexcessmonth")));//10
					//arrCol.add(correctNull(rs.getString("mon_hedgeddetailsexcesscurrent")));//11
					
					arrRow.add(arrCol);
				}			
				hshRecord.put("arrRow1",arrRow);
				
				
				strQuery=SQLParser.getSqlQuery("sel_monauditcomments^"+strAudittype+"^"+Strmmrno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					//hshResult.put("mon_custid",correctNull(rs.getString("mon_custid")));
					hshRecord.put("auditorscomments",correctNull(rs.getString("mon_auditorcomments")));
					hshRecord.put("officercomments",correctNull(rs.getString("mon_officerscomments")));
					hshRecord.put("auditdate",correctNull(rs.getString("mon_auditdate")));
				}
				
				
				
				arrRow = new ArrayList();
				strQuery=SQLParser.getSqlQuery("selconsortium^"+Strmmrno);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol = new ArrayList();
					//arrCol.add(correctNull(rs.getString("mmr_sno")));
					arrCol.add(correctNull(rs.getString("mmr_bankname")));
					//arrCol.add(correctNull(rs.getString("mmr_branch")));
					arrCol.add(correctNull(rs.getString("mmr_sharepercent")));
					//arrCol.add(correctNull(rs.getString("mmr_assetclasification")));
					//arrCol.add(correctNull(rs.getString("mmr_fundbasedname")));
					arrCol.add(String.valueOf(Double.parseDouble(Helper.correctDouble(rs.getString("mmr_fundbasedamount"))) / 10000000));
					//arrCol.add(correctNull(rs.getString("mmr_nonfundbasedname")));
					arrCol.add(String.valueOf(Double.parseDouble(Helper.correctDouble(rs.getString("mmr_nonfundbasedamount"))) / 10000000));
					//arrCol.add(correctNull(rs.getString("mmr_overdue")));
					//arrCol.add(correctNull(rs.getString("mmr_remarks")));
					if(correctNull(rs.getString("mmr_leadbank")).equals("1"))
					{
						hshRecord.put("LeadBankName",correctNull(rs.getString("mmr_branch")));
					}
					arrCol.add(correctNull(rs.getString("mmr_leadbank")));
					arrCol.add(correctNull(rs.getString("mmr_nonfundsharepercent")));
					arrCol.add(correctNull(rs.getString("mmr_fundsharepercent")));
					arrRow.add(arrCol);
				}			
				hshRecord.put("arrRow3",arrRow);
				
				int j=0;
				StringBuffer strAppend = new StringBuffer();
				StringBuffer strAppend1 = new StringBuffer();
				
				StringBuffer primeSecurities = new StringBuffer();
				StringBuffer colateralSecurity = new StringBuffer();
				arrRow = new ArrayList();
				//Code Changed By Kamal as per requirement on 31/03/2010
				strQuery = SQLParser.getSqlQuery("sel_monitoraccno^"+strcbsid);
				rs2 = DBUtils.executeQuery(strQuery);	
				while (rs2.next())
				{ 
					
					if(j!=0)
					{
						strAppend.append(",");
						strAppend1.append(",");
					}
					
					strAppend1.append("'").append(correctNull(rs2.getString("LIMIT_CUTACCNO"))).append("'");
					strAppend.append(correctNull(rs2.getString("LIMIT_CUTACCNO")));
					
						
				
				
					strQuery=SQLParser.getSqlQuery("selsecurityreg1^"+correctNull(rs2.getString("LIMIT_CUTACCNO"))+"^"+Strmmrno);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						if(correctNull(rs.getString("monsec_maskflag")).equalsIgnoreCase("N") || (correctNull(rs.getString("monsec_maskflag")).equalsIgnoreCase("Y") && !correctNull(rs.getString("mon_insuamt")).equalsIgnoreCase("")) )
						{
							arrCol = new ArrayList();
							arrCol.add(correctNull(rs.getString("MONSEC_SNO")));
							arrCol.add(correctNull(rs.getString("MONSEC_ACCOUNTNUMBER")));
							if(correctNull(rs.getString("MONSEC_SECURITYTYPE")).equals("1"))
							{
								primeSecurities.append(correctNull(rs.getString("STAT_DATA_DESC1"))).append(" - ").append(correctNull(rs.getString("monsec_shortfallnoticed"))).append("<br>&nbsp;");
							}
							else
							{
								colateralSecurity.append(correctNull(rs.getString("STAT_DATA_DESC1"))).append(" - ").append(correctNull(rs.getString("monsec_shortfallnoticed"))).append("<br>&nbsp;");
							}
							arrCol.add(correctNull(rs.getString("MONSEC_SECURITYTYPE")));
							arrCol.add(correctNull(rs.getString("MONSEC_SECURITYNATURE")));
							arrCol.add(correctNull(rs.getString("MONSEC_OTHERDETAILS")));
							//arrCol.add(correctNull(rs.getString("MONSEC_ADD1")));
							//arrCol.add(correctNull(rs.getString("MONSEC_ADD2")));
							//arrCol.add(correctNull(rs.getString("MONSEC_CITY")));
							//arrCol.add(correctNull(rs.getString("MONSEC_STATE")));
							//arrCol.add(correctNull(rs.getString("MONSEC_PINCODE")));
							arrCol.add(correctNull(rs.getString("MON_INSUSLRNO")));
							arrCol.add(Helper.converToLakhs(rs.getString("MONSEC_VALUATAMOUNT")));
							arrCol.add(correctNull(rs.getString("MONSEC_VALUATDATE")));
							arrCol.add(correctNull(rs.getString("MONSEC_VALUTDONEBY")));
							arrCol.add(correctNull(rs.getString("MONSEC_INSPECTEDBY")));
							arrCol.add(correctNull(rs.getString("MONSEC_INSPECTEDON")));
							
							arrCol.add(correctNull((String)rs.getString("MON_SECUINSUEXP")));
							arrCol.add(Helper.converToLakhs((String)rs.getString("MON_INSUAMT")));
							/*strQuery=SQLParser.getSqlQuery("sel_Mon_register_expYear^"+correctNull(rs.getString("MONSEC_ACCOUNTNUMBER"))+"^"+strcbsid+"^"+correctNull(rs.getString("MONSEC_INSURANCENO")));
							rs1=DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{	
								arrCol.add(correctNull((String)rs1.getString("ins_expirydate")));
								arrCol.add(Helper.converToLakhs((String)rs1.getString("ins_coveramt")));
							}
							else
							{
								arrCol.add("");
								arrCol.add("");
							}*/
							arrCol.add(correctNull(rs.getString("STAT_DATA_DESC1")));
							arrRow.add(arrCol);
						}
					}		
					j++;
				}	
				hshRecord.put("arrRow2",arrRow);
				
				hshRecord.put("primeSecurities",primeSecurities.toString());
				hshRecord.put("colateralSecurity",colateralSecurity.toString());
				
				strQuery=SQLParser.getSqlQuery("sel_mettingstatement^"+Strmmrno);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshRecord.put("mon_dateofmet",correctNull(rs.getString("mon_dateofmet")));
						hshRecord.put("mon_minutesmet",correctNull(rs.getString("mon_minutesmet")));
						//hshRecord.put("mon_received",correctNull(rs.getString("mon_received")));
						hshRecord.put("mon_noofmeetingheld",correctNull(rs.getString("mon_noofmeetingheld")));
					}			
					
					
				hshRecord.put("mon_accwiseaccountno",strAppend.toString());
				
				
				strQuery = SQLParser.getSqlQuery("sel_branchheadcomments^"+Strmmrno);
				rs = DBUtils.executeQuery(strQuery);	
				if (rs.next())
				{ 
					hshRecord.put("mon_operation",correctNull(rs.getString("mon_operation")));
					hshRecord.put("mon_operationdetails",correctNull(rs.getString("mon_operationdetails")));
					hshRecord.put("mon_sanction",correctNull(rs.getString("mon_sanction")));
					hshRecord.put("mon_sanctiondetails",correctNull(rs.getString("mon_sanctiondetails")));
					hshRecord.put("mon_irregular",correctNull(rs.getString("mon_irregular")));
					hshRecord.put("mon_irregulardetails",correctNull(rs.getString("mon_irregulardetails")));
					hshRecord.put("mon_observation",correctNull(rs.getString("mon_observation")));
					hshRecord.put("mon_observationdetails",correctNull(rs.getString("mon_observationdetails")));
					hshRecord.put("mon_limits",correctNull(rs.getString("mon_limits")));
					hshRecord.put("mon_limitsreason",correctNull(rs.getString("mon_limitsreason")));
					
					//Added By Zahoorunnisa.S as per Suresh on 19th April 2012
					hshRecord.put("mon_noname",correctNull(rs.getString("mon_noname")));
					hshRecord.put("mon_nodesgn",correctNull(rs.getString("mon_nodesgn")));
					hshRecord.put("mon_ainame",correctNull(rs.getString("mon_ainame")));
					hshRecord.put("mon_aidesgn",correctNull(rs.getString("mon_aidesgn")));
					hshRecord.put("mon_bhname",correctNull(rs.getString("mon_bhname")));
					hshRecord.put("mon_bhdesgn",correctNull(rs.getString("mon_bhdesgn")));
					//end
				}
				
				
				
			
				
				strQuery = SQLParser.getSqlQuery("selmonitoringinfo^"+Strmmrno);
				rs = DBUtils.executeQuery(strQuery);	
				if (rs.next())
				{ 
					hshRecord.put("mmr_infoinspectiondate",correctNull(rs.getString("mmr_infoinspectiondate")));
					hshRecord.put("mmr_infotermscond",correctNull(rs.getString("mmr_infotermscond")));
					hshRecord.put("mmr_infoprofitabilty",correctNull(rs.getString("mmr_infoprofitabilty")));
					hshRecord.put("mmr_infocolenders",correctNull(rs.getString("mmr_infocolenders")));
					
					
					
					hshRecord.put("mmr_infomanageperson",correctNull(rs.getString("mmr_infomanageperson")));
					hshRecord.put("mmr_infotermreason",correctNull(rs.getString("mmr_infotermreason")));
					hshRecord.put("mmr_infoadversedreason",correctNull(rs.getString("mmr_infoadversedreason")));
					hshRecord.put("mmr_infoprofitabiltyreason",correctNull(rs.getString("mmr_infoprofitabiltyreason")));
					hshRecord.put("mmr_infocolendersreason",correctNull(rs.getString("mmr_infocolendersreason")));
					hshRecord.put("mmr_infomanagepersonreason",correctNull(rs.getString("mmr_infomanagepersonreason")));
					
					hshRecord.put("mmr_infomonth",correctNull(rs.getString("mmr_infomonth")));
					hshRecord.put("mmr_infoyear",correctNull(rs.getString("mmr_infoyear")));
					
					hshRecord.put("mon_salesquarter",correctNull(rs.getString("mon_salesquarter")));
					hshRecord.put("mon_salesamount",Helper.converToLakhs(rs.getString("mon_salesamount")));
				}
				
				
				arrRow = new ArrayList();
				
				
				
				strQuery = SQLParser.getSqlQuery("sel_facilty_mon_limit_register^"+strcbsid);
				rs = DBUtils.executeQuery(strQuery);	
				while(rs.next())
				{
					
					
					if(rs1!=null)
						rs1.close();
					
					strQuery=SQLParser.getSqlQuery("seldocumentregister^"+correctNull(rs.getString("LIMIT_CUTACCNO")));
					rs1=DBUtils.executeQuery(strQuery);
					int count = 0;
					if(rs1.next())
					{
						rs1.last();
						 count = rs1.getRow();
						rs1.beforeFirst();
					
						while(rs1.next())
						{
							arrCol = new ArrayList();
							arrCol.add(correctNull(rs.getString("stat_data_desc1")));
							arrCol.add(correctNull((String)rs1.getString("doc_documentname")));
							arrCol.add(correctNull((String)rs1.getString("doc_executeddate")));
							arrCol.add(""+count);
							arrRow.add(arrCol);
						}
					}
					
				}
				hshRecord.put("arrRow5",arrRow);
				
				
				
				arrRow = new ArrayList();
				
				strQuery = SQLParser.getSqlQuery("sel_monauditcomments_all_type^"+Strmmrno);
				rs = DBUtils.executeQuery(strQuery);	
				while(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(correctNull(rs.getString("mon_audittype")));
					arrCol.add(correctNull(rs.getString("mon_auditdate")));
					arrCol.add(correctNull(rs.getString("mon_auditorcomments")));
					arrCol.add(correctNull(rs.getString("mon_officerscomments")));
					arrRow.add(arrCol);
				}
				
				hshRecord.put("arrRow6",arrRow);
				
				
				
				strQuery=SQLParser.getSqlQuery("sel_Mon_Checklist_MaximumDbc^"+strAppend1.toString());
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("mon_dbcdate",correctNull(rs.getString("mon_dbcdate")));
				}
				
				strQuery=SQLParser.getSqlQuery("sel_Mon_Checklist_MaximumRoc^"+strAppend1.toString());
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("mon_rocdate",correctNull(rs.getString("mon_rocdate")));
					hshRecord.put("mon_roc",correctNull(rs.getString("mon_roc")));
				}
				/*strQuery=SQLParser.getSqlQuery("sel_monchecklist^"+strCustAccno);
				rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshRecord.put("mon_roc",correctNull(rs.getString("mon_roc")));
						hshRecord.put("mon_rocdate",correctNull(rs.getString("mon_rocdate")));
						hshRecord.put("mon_resolutiondate",correctNull(rs.getString("mon_resolutiondate")));
						
						hshRecord.put("mon_dbc",correctNull(rs.getString("mon_dbc")));
						hshRecord.put("mon_dbcdate",correctNull(rs.getString("mon_dbcdate")));
						hshRecord.put("mon_dbcamount",correctNull(rs.getString("mon_dbcamount")));
						hshRecord.put("mon_guarantor",correctNull(rs.getString("mon_guarantor")));
						hshRecord.put("mon_guarantorsigned",correctNull(rs.getString("mon_guarantorsigned")));
						hshRecord.put("mon_equitable",correctNull(rs.getString("mon_equitable")));
						hshRecord.put("mon_equitperfect",correctNull(rs.getString("mon_equitperfect")));
						
						hshRecord.put("mon_checkmsod",correctNull(rs.getString("mon_checkmsod")));
						hshRecord.put("mon_checkstock",correctNull(rs.getString("mon_checkstock")));
						hshRecord.put("mon_checkbkdebts",correctNull(rs.getString("mon_checkbkdebts")));
						hshRecord.put("mon_checkqpr",correctNull(rs.getString("mon_checkqpr")));
						hshRecord.put("mon_inspection",correctNull(rs.getString("mon_inspection")));
					}*/
			
					
				strQuery=SQLParser.getSqlQuery("sel_mon_generalinfo^"+Strmmrno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("acc_categorization",(correctNull(rs.getString("gen_acc_clasification"))));
					hshRecord.put("acc_stress",(correctNull(rs.getString("gen_accStressY"))));
					hshRecord.put("acc_stress_reason",(correctNull(rs.getString("gen_accstress_reason"))));
					hshRecord.put("acc_restructered",(correctNull(rs.getString("gen_accrestructY"))));
					hshRecord.put("acc_restructterms",(correctNull(rs.getString("gen_termscompiledY"))));
					hshRecord.put("acc_restructtermsreasons",(correctNull(rs.getString("gen_termscompiledreasons"))));
					hshRecord.put("presentrating",(correctNull(rs.getString("gen_presentyearrating"))));
					hshRecord.put("prevrating",(correctNull(rs.getString("gen_prevyearrating"))));
					hshRecord.put("downgradereason",(correctNull(rs.getString("gen_downgradereason"))));
					hshRecord.put("documentobtained",(correctNull(rs.getString("gen_docobtained"))));
					hshRecord.put("creditauditdate",(correctNull(rs.getString("gen_creditauditdate"))));
					hshRecord.put("documentvetted",(correctNull(rs.getString("gen_docvetted"))));
					hshRecord.put("docvettedreasons",(correctNull(rs.getString("gen_docvettedreasons"))));
					hshRecord.put("docdeficiencies",(correctNull(rs.getString("gen_docdeficiencies"))));
					hshRecord.put("borrower_Date",(correctNull(rs.getString("gen_borrowerdate"))));
					
					hshRecord.put("roc_reasons",(correctNull(rs.getString("roc_reasons"))));
					
					hshRecord.put("mon_deviation",(correctNull(rs.getString("mon_deviation"))));
					hshRecord.put("mon_compliance",(correctNull(rs.getString("mon_compliance"))));
					
					hshRecord.put("lawyername",(correctNull(rs.getString("gen_lawyername"))));
				}
				arrRow = new ArrayList();
				String limit_reviewdate ="";
				strQuery=SQLParser.getSqlQuery("sel_ReviewDate_sanction_auth^"+strcbsid);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(correctNull(rs.getString("limit_sancauth")));
					arrCol.add(correctNull(rs.getString("limit_sanctionlevel")));
					
					limit_reviewdate = correctNull(rs.getString("limit_reviewdate"));
					if(limit_reviewdate.indexOf("/")!=-1)
					{
						limit_reviewdate = Helper.getMonths(Integer.parseInt(Helper.correctInt(limit_reviewdate.split("/")[1])))+" "+limit_reviewdate.split("/")[2];
					}
					arrCol.add(limit_reviewdate);
					arrRow.add(arrCol);
				}
				
				hshRecord.put("arrRow8",arrRow);
				
				String comapp_region_code="";
				
				int code=org_Code_MMr.length();
				if(code==15)
				{  
					comapp_region_code = org_Code_MMr.substring(0,9)+"000000";
					
				}
			    
				
				
				
				strQuery = SQLParser.getSqlQuery("setorgselect^"+comapp_region_code);
				rs = DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
					hshRecord.put("RespectiveRegion",correctNull(rs.getString("org_name")));
				}
				
				
				strQuery = SQLParser.getSqlQuery("selmonitoringinformatiom^"+Strmmrno);
				rs = DBUtils.executeQuery(strQuery);	
				if (rs.next())
				{ 
					hshRecord.put("mon_monitinfcbsid",correctNull(rs.getString("mon_monitinfcbsid")));
					hshRecord.put("mon_monitinfgovtpolicy",correctNull(rs.getString("mon_monitinfgovtpolicy")));
					hshRecord.put("mon_monitinfqpr",correctNull(rs.getString("mon_monitinfqpr")));
					hshRecord.put("mon_monitinfpenalinterst",correctNull(rs.getString("mon_monitinfpenalinterst")));
					hshRecord.put("mon_monitinfledger",correctNull(rs.getString("mon_monitinfledger")));
					hshRecord.put("mon_monitinfrectification",correctNull(rs.getString("mon_monitinfrectification")));
					
					hshRecord.put("mon_monitinfgovtpolicyrson",correctNull(rs.getString("mon_monitinfgovtpolicyrson")));
					hshRecord.put("mon_monitinfpenalinterstrson",correctNull(rs.getString("mon_monitinfpenalinterstrson")));
					hshRecord.put("mon_monitinfrectificationrson",correctNull(rs.getString("mon_monitinfrectificationrson")));
					hshRecord.put("mon_monitinfnonsecrutiniserson",correctNull(rs.getString("mon_monitinfnonsecrutiniserson")));
					
					hshRecord.put("mon_monitinfmonth",correctNull(rs.getString("mon_monitinfmonth")));
					hshRecord.put("mon_monitinfyear",correctNull(rs.getString("mon_monitinfyear")));
					
					
				}
			
				rs=DBUtils.executeLAPSQuery("sel_mon_excess_reason^"+Strmmrno);
				if(rs.next())
				{
					hshRecord.put("gen_reasons",(correctNull(rs.getString("gen_reasons"))));
					hshRecord.put("downgradecommencement",(correctNull(rs.getString("gen_commencements"))));
					
					hshRecord.put("renewalcompiled",(correctNull(rs.getString("renewalcompiled"))));
					hshRecord.put("ren_submitted",(correctNull(rs.getString("ren_submitted"))));
					hshRecord.put("ren_submitted_reasons",(correctNull(rs.getString("ren_submitted_reasons"))));
					
				}
				
				arrRow = new ArrayList();
				
				boolean checkData = true;
				
				strQuery=SQLParser.getSqlQuery("selmonaccountexcess^"+Strmmrno);
		 		
		 		rs=DBUtils.executeQuery(strQuery);
		 		while(rs.next())
				{
		 			arrCol = new ArrayList();
		 			arrCol.add(rs.getString("mon_facility"));
		 			arrCol.add(rs.getString("mon_duringmonth"));
		 			arrCol.add(rs.getString("mon_currentmonth"));
		 			arrRow.add(arrCol);
		 			checkData = false;
		 	    }
		 		if(checkData)
		 		{	
			 		strQuery=SQLParser.getSqlQuery("getaccountexcessfacilitydata^"+Strmmrno);
			 		
			 		rs=DBUtils.executeQuery(strQuery);
			 		while(rs.next())
					{
			 			arrCol = new ArrayList();
			 			arrCol.add(correctNull(rs.getString("MMRFUND_FACILITY")));
			 			arrCol.add("");
			 			arrCol.add("");
			 			arrRow.add(arrCol);
			 	    }
			 		
			 		arrCol = new ArrayList();
		 			arrCol.add("Letter of Credit");
		 			arrCol.add("");
		 			arrCol.add("");
		 			arrRow.add(arrCol);
		 			
		 			arrCol = new ArrayList();
		 			arrCol.add("Letter of Guatantee");
		 			arrCol.add("");
		 			arrCol.add("");
		 			arrRow.add(arrCol);
			 		
		 		}
		 		hshRecord.put("arrRow7",arrRow);
		 		
		 		
		 		
		 		if(rs!=null)rs.close();
		        rs = DBUtils.executeLAPSQuery("sel_mon_mail_comments^"+Strmmrno);
		        arrRow=new ArrayList();
		        arrCol=new ArrayList();
		        while(rs.next())
		        {
		     	   arrCol=new ArrayList();
		     	   arrCol.add(correctNull(rs.getString("usr_fname")));
		     	   arrCol.add(correctNull(Helper.correctNull((String)rs.getString("mail_comments"))));
		     	   arrRow.add(arrCol);
		        }
		        
		        hshRecord.put("mailcomments",arrRow);
			}
			catch(Exception e)
			{
				throw new EJBException("Error in getMMRReportPrint"+e.getMessage());
			}
			finally
			{
				try
				{	if(rs != null)
						rs.close();
					
					if(rs1 != null)
					rs1.close();
					
					if(rs2!=null)
						rs2.close();
				}
				catch(Exception cf)
				{
					throw new EJBException("Error closing the connection "+cf.getMessage());
				}
			}
			return hshRecord;
		}


public void updateReasonsExcessData(HashMap hshValues) 
{
	HashMap hshQuery=new HashMap();
	HashMap hshQueryValues=new HashMap();
	ArrayList arrValues=new ArrayList();
	ResultSet rs=null;
	ResultSet rs1=null;
	String auditflag=Helper.correctNull((String)hshValues.get("auditflag"));
	try
	{
		StringBuilder strNewAudit=new StringBuilder();
		StringBuilder strOldAudit=new StringBuilder();
		String strAction=correctNull((String)hshValues.get("hidAction"));
		
		String mon_month=correctNull((String)hshValues.get("mon_month"));
		String mon_year=correctNull((String)hshValues.get("mon_year"));
		String Strmmrno=correctNull((String)hshValues.get("mmrno"));
		
		String[] strfacility = (String[]) hshValues.get("txt_facility");
 		String[] strexcessmonth = (String[]) hshValues.get("txt_excessmonth");
 		String[] strexcesscurrent = (String[]) hshValues.get("txt_excesscurrent");
		
		
 		rs=DBUtils.executeLAPSQuery("sel_mon_excess_reason^"+Strmmrno);
		if(rs.next())
		{
			strOldAudit.append("~If due for renewal, whether renewal proposal submitted  = ");
			if(Helper.correctNull((String)rs.getString("renewalcompiled")).equalsIgnoreCase("Y"))
			{
				strOldAudit.append("Yes");
				strOldAudit.append("~Date on which submitted = ");
				strOldAudit.append(correctNull((String)rs.getString("ren_submitted")));
			}
			else if(Helper.correctNull((String)rs.getString("renewalcompiled")).equalsIgnoreCase("N"))
			{
				strOldAudit.append("No");
			}
			else
			{
				strOldAudit.append("");
			}
			
		}
		rs1=DBUtils.executeLAPSQuery("selmonaccountexcess^"+Strmmrno);
		while(rs1.next())
		{
			strOldAudit.append("~Facility = ");
			strOldAudit.append(Helper.correctNull((String)rs1.getString("mon_facility")));
			strOldAudit.append("~During the month = ");
			strOldAudit.append(Helper.correctNull((String)rs1.getString("mon_duringmonth")));
			strOldAudit.append("~From 1st April till current month = ");
			strOldAudit.append(Helper.correctNull((String)rs1.getString("mon_currentmonth")));
		}
		if(strAction.equals("insert"))
		{	
			
			//arrValues.add(correctNull((String)hshValues.get("cbsid")));
			//arrValues.add(mon_month);
			//arrValues.add(mon_year);
			arrValues.add(Strmmrno);
			hshQuery.put("arrValues",arrValues); 
			hshQuery.put("strQueryId","del_mon_excess_reason"); 
			hshQueryValues.put("1",hshQuery);
			
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			arrValues.add(correctNull((String)hshValues.get("cbsid")));
			arrValues.add(correctNull((String)hshValues.get("reason_excess")));
			arrValues.add(correctNull((String)hshValues.get("reason_commencement")));
			arrValues.add(mon_month);
			arrValues.add(mon_year);
			
			arrValues.add(correctNull((String)hshValues.get("renewalcompiled")));
			arrValues.add(correctNull((String)hshValues.get("ren_submitted")));
			arrValues.add(correctNull((String)hshValues.get("ren_submitted_reasons")));
			arrValues.add(correctNull((String)hshValues.get("roc_reasons")));
			arrValues.add(Strmmrno);
			
			hshQuery.put("arrValues",arrValues); 
			hshQuery.put("strQueryId","ins_mon_excess_reason"); 
			hshQueryValues.put("2",hshQuery);
			
			
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			arrValues.add(Strmmrno);
			//arrValues.add(correctNull((String)hshValues.get("cbsid")));
			//arrValues.add(mon_month);
			//arrValues.add(mon_year);
			hshQuery.put("arrValues",arrValues); 
			hshQuery.put("strQueryId","delmonaccountexcess"); 
			hshQueryValues.put("3",hshQuery);
			
			hshQueryValues.put("size","3");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			strNewAudit.append("~If due for renewal, whether renewal proposal submitted  = ");
			if(correctNull((String)hshValues.get("renewalcompiled")).equalsIgnoreCase("Y"))
			{
				strNewAudit.append("Yes");
				strNewAudit.append("~Date on which submitted = ");
				strNewAudit.append(correctNull((String)hshValues.get("ren_submitted")));
			}
			else if(correctNull((String)hshValues.get("renewalcompiled")).equalsIgnoreCase("Y"))
			{
				strNewAudit.append("No");
			}
			else
			{
				strNewAudit.append("");
			}
			
			
			
			 hshQueryValues=new HashMap();
			for(int i=0;i<strfacility.length;i++)
			{
				 hshQuery = new HashMap();
			 	 arrValues=new ArrayList();
				 arrValues.add(""+i);
				 arrValues.add(correctNull((String)hshValues.get("cbsid")));
				 arrValues.add(mon_month);
				 arrValues.add(mon_year);
				 arrValues.add(strfacility[i]);
				 arrValues.add(strexcessmonth[i]);
				 arrValues.add(strexcesscurrent[i]);
				 arrValues.add(Strmmrno);
				 hshQuery.put("arrValues",arrValues);
				 hshQuery.put("strQueryId","insmonaccountexcess");
				 hshQueryValues.put(""+(i+1),hshQuery);
				 hshQueryValues.put("size",""+(i+1));
				 strNewAudit.append("~Facility = ");
				 strNewAudit.append(strfacility[i]);
				 strNewAudit.append("~During the month = ");
				 strNewAudit.append(strexcessmonth[i]);
				 strNewAudit.append("~From 1st April till current month = ");
				 strNewAudit.append(strexcesscurrent[i]);
			
			}
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			
		}	
		
		if(strAction.equals("delete"))
		{
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			//arrValues.add(correctNull((String)hshValues.get("cbsid")));
			//arrValues.add(mon_month);
			//arrValues.add(mon_year);
			arrValues.add(Strmmrno);
			hshQuery.put("arrValues",arrValues); 
			hshQuery.put("strQueryId","del_mon_excess_reason"); 
			hshQueryValues.put("1",hshQuery);
		
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			//arrValues.add(correctNull((String)hshValues.get("cbsid")));
			//arrValues.add(mon_month);
			//arrValues.add(mon_year);
			arrValues.add(Strmmrno);
			hshQuery.put("arrValues",arrValues); 
			hshQuery.put("strQueryId","delmonaccountexcess"); 
			hshQueryValues.put("2",hshQuery);
			
			hshQueryValues.put("size","2");	
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		
		if(auditflag.equalsIgnoreCase("N"))
		{
			if(!strAction.equalsIgnoreCase("delete"))
			{
			hshValues.put("strAction", "Insert");
			}
			AuditTrial.auditLog(hshValues, "411", Strmmrno, strNewAudit.toString());
		}
		else
		{
			if(!strAction.equalsIgnoreCase("delete"))
			{
			hshValues.put("strAction", "update");
			}
			AuditTrial.auditNewLog(hshValues, "411", Strmmrno, strNewAudit.toString(), strOldAudit.toString());
		}
		
	}
	catch(Exception e)
	{
		throw new EJBException("Error in updateReasonsExcessData "+e.getMessage());
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
			throw new EJBException("Error closing in updateReasonsExcessData the connection "+cf.getMessage());						
		}
	}
	
}

public HashMap getReasonsExcessData(HashMap hshValues)
{
	HashMap hshRecord=new HashMap();
	ResultSet rs=null;
	String cbsid=correctNull((String)hshValues.get("cbsid"));
	String mon_month=correctNull((String)hshValues.get("mon_month"));
	String mon_year=correctNull((String)hshValues.get("mon_year"));
	//String cbsname=correctNull((String)hshValues.get("cbsname"));
	String Strmmrno=correctNull((String)hshValues.get("mmrno"));
	String applyflag ="1",strQuery="";
	boolean checkData=true;
	try
	{
	
 		
		
		rs=DBUtils.executeLAPSQuery("sel_mon_excess_reason^"+Strmmrno);
		if(rs.next())
		{
			hshRecord.put("downgradereason",(correctNull(rs.getString("gen_reasons"))));
			hshRecord.put("downgradecommencement",(correctNull(rs.getString("gen_commencements"))));
			
			hshRecord.put("renewalcompiled",(correctNull(rs.getString("renewalcompiled"))));
			hshRecord.put("ren_submitted",(correctNull(rs.getString("ren_submitted"))));
			hshRecord.put("ren_submitted_reasons",(correctNull(rs.getString("ren_submitted_reasons"))));
			hshRecord.put("roc_reasons",(correctNull(rs.getString("roc_reasons"))));
			applyflag = "0";
		}
		else
		{
			hshRecord.put("audit_flag", "N");
		}
		
		
		ArrayList arrRow = new ArrayList();
 		ArrayList arrCol = new ArrayList();
		
 		strQuery=SQLParser.getSqlQuery("selmonaccountexcess^"+Strmmrno);
 		
 		rs=DBUtils.executeQuery(strQuery);
 		while(rs.next())
		{
 			arrCol = new ArrayList();
 			arrCol.add(correctNull(rs.getString("mon_facility")));
 			arrCol.add(correctNull(rs.getString("mon_duringmonth")));
 			arrCol.add(correctNull(rs.getString("mon_currentmonth")));
 			arrRow.add(arrCol);
 			checkData=false;
 			applyflag = "0";
 	    }
 		
 		if(checkData)
 		{	
	 		strQuery=SQLParser.getSqlQuery("getaccountexcessfacilitydata^"+Strmmrno);
	 		
	 		rs=DBUtils.executeQuery(strQuery);
	 		while(rs.next())
			{
	 			arrCol = new ArrayList();
	 			arrCol.add(correctNull(rs.getString("MMRFUND_FACILITY")));
	 			arrCol.add("");
	 			arrCol.add("");
	 			arrRow.add(arrCol);
	 	    }
	 		
	 		arrCol = new ArrayList();
 			arrCol.add("Letter of Credit");
 			arrCol.add("");
 			arrCol.add("");
 			arrRow.add(arrCol);
 			
 			arrCol = new ArrayList();
 			arrCol.add("Letter of Guatantee");
 			arrCol.add("");
 			arrCol.add("");
 			arrRow.add(arrCol);
 			
 			arrCol = new ArrayList();
 			arrCol.add("Bullion Loan");
 			arrCol.add("");
 			arrCol.add("");
 			arrRow.add(arrCol);
	 		
 		}
 		
 		
 		hshRecord.put("arrRow",arrRow);
 		hshRecord.put("applyflag",applyflag);
		hshRecord.put("mon_month",mon_month);
		hshRecord.put("mon_year",mon_year);
		hshRecord.put("cbsid",cbsid);
		//hshRecord.put("cbsname",cbsname);
		
	}
	catch(Exception e)
	{
		throw new EJBException("Error in getMMRFacility"+e.getMessage());
	}
	finally
	{
		try
		{	if(rs != null)
				rs.close();
			
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	return hshRecord;
}



public void updateAnnexureFacility(HashMap hshValues) 
{
	
	ResultSet rs = null;
	try
	{
		
		String strAction=correctNull((String)hshValues.get("hidAction"));
		String mon_month=correctNull((String)hshValues.get("mon_month"));
		String mon_year=correctNull((String)hshValues.get("mon_year"));
		String cbsid = correctNull((String)hshValues.get("cbsid"));
		String Strmmrno= correctNull((String)hshValues.get("mmrno"));
		
		String strQuery = "",strSno="",strFacHead="",strFacility="",strSubFacHead="",strSubFacility="";
		
		StringTokenizer stk = null;
 		strFacHead = correctNull((String) hshValues.get("facility_head"));
		stk = new StringTokenizer(strFacHead,"-");
		if(stk.hasMoreTokens())
		{
			strFacHead = (String)stk.nextToken();
		}

		strFacility =correctNull((String) hshValues.get("facility"));
		stk = new StringTokenizer(strFacility,"-");
		if(stk.hasMoreTokens())
		{
			strFacility = (String)stk.nextToken();
		}
		
		strSubFacHead =correctNull((String) hshValues.get("subfacility_head"));
		stk = new StringTokenizer(strSubFacHead,"-");
		if(stk.hasMoreTokens())
		{
			strSubFacHead = (String)stk.nextToken();
		}
		
		strSubFacility =correctNull((String) hshValues.get("subfacility"));
		stk = new StringTokenizer(strSubFacility,"-");
		if(stk.hasMoreTokens())
		{
			strSubFacility = (String)stk.nextToken();
		}
		int strGroupId =0;
		
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=new ArrayList();
		
		if(strAction.equals("insert"))
		{
		
			if(!correctNull((String)hshValues.get("checkSublimit")).equals(""))
			{	
				strQuery = SQLParser.getSqlQuery("maxannexurefacility^"+Strmmrno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strSno = rs.getString(1);
				}
				strGroupId = Integer.parseInt(Helper.correctInt(strSno));
				arrValues.add(cbsid);
				arrValues.add(mon_month);
				arrValues.add(mon_year);
				arrValues.add(strSno);
				arrValues.add(strFacHead);
				arrValues.add(strFacility);
				arrValues.add(""+strGroupId);
				arrValues.add(correctNull((String)hshValues.get("category")));
				arrValues.add(correctNull((String)hshValues.get("txt_exist_limit")));
				arrValues.add(correctNull((String)hshValues.get("txt_outstanding")));
				arrValues.add(correctNull((String)hshValues.get("txt_overdue")));
				arrValues.add(correctNull((String)hshValues.get("txt_dp")));
				
				arrValues.add(correctNull((String)hshValues.get("txt_adhocdate")));
				arrValues.add(correctNull((String)hshValues.get("txt_desc")));
				arrValues.add(Strmmrno);
				hshQuery.put("arrValues",arrValues); 
				hshQuery.put("strQueryId","ins_annexurefacility"); 
				
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				//strGroupId = Integer.parseInt(Helper.correctInt(strSno));
				strQuery = SQLParser.getSqlQuery("maxannexurefacility^"+Strmmrno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strSno = rs.getString(1);
				}
				if(!correctNull((String)hshValues.get("checkbox")).equals(""))
				{
					hshQueryValues = new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(cbsid);
					arrValues.add(mon_month);
					arrValues.add(mon_year);
					arrValues.add(strSno);
					arrValues.add(strSubFacHead);
					arrValues.add(strSubFacility);
					arrValues.add(""+strGroupId);
					arrValues.add(correctNull((String)hshValues.get("category")));
					arrValues.add(correctNull((String)hshValues.get("txt_subexist_limit")));
					arrValues.add(correctNull((String)hshValues.get("txt_sub_outstanding")));
					arrValues.add(correctNull((String)hshValues.get("txt_sub_overdue")));
					arrValues.add(correctNull((String)hshValues.get("txt_sub_dp")));
					
					arrValues.add(correctNull((String)hshValues.get("txt_adhocdate")));
					arrValues.add(correctNull((String)hshValues.get("txt_remarks")));
					arrValues.add(Strmmrno);
					hshQuery.put("arrValues",arrValues); 
					hshQuery.put("strQueryId","ins_annexurefacility"); 
					
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				
			}
			else
			{
				strSno = correctNull((String)hshValues.get("headSno"));
				//arrValues.add(cbsid);
				//arrValues.add(mon_year);
				//arrValues.add(mon_month);
				arrValues.add(Strmmrno);
				arrValues.add(strSno);
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_annexurefacility"); 
				hshQuery.put("arrValues",arrValues); 
				hshQueryValues.put("1",hshQuery);
				
				strGroupId = Integer.parseInt(Helper.correctInt(strSno));
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(cbsid);
				arrValues.add(mon_month);
				arrValues.add(mon_year);
				arrValues.add(strSno);
				arrValues.add(strFacHead);
				arrValues.add(strFacility);
				arrValues.add(""+strGroupId);
				arrValues.add(correctNull((String)hshValues.get("category")));
				arrValues.add(correctNull((String)hshValues.get("txt_exist_limit")));
				arrValues.add(correctNull((String)hshValues.get("txt_outstanding")));
				arrValues.add(correctNull((String)hshValues.get("txt_overdue")));
				arrValues.add(correctNull((String)hshValues.get("txt_dp")));
				
				arrValues.add(correctNull((String)hshValues.get("txt_adhocdate")));
				arrValues.add(correctNull((String)hshValues.get("txt_desc")));
				arrValues.add(Strmmrno);
				
				hshQuery.put("arrValues",arrValues); 
				hshQuery.put("strQueryId","ins_annexurefacility"); 
				
				hshQueryValues.put("size","2");
				hshQueryValues.put("2",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				//strGroupId = Integer.parseInt(Helper.correctInt(strSno));
				strQuery = SQLParser.getSqlQuery("maxannexurefacility^"+Strmmrno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strSno = rs.getString(1);
				}
				if(!correctNull((String)hshValues.get("checkbox")).equals(""))
				{
					hshQueryValues = new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(cbsid);
					arrValues.add(mon_month);
					arrValues.add(mon_year);
					arrValues.add(strSno);
					arrValues.add(strSubFacHead);
					arrValues.add(strSubFacility);
					arrValues.add(""+strGroupId);
					arrValues.add(correctNull((String)hshValues.get("category")));
					arrValues.add(correctNull((String)hshValues.get("txt_subexist_limit")));
					arrValues.add(correctNull((String)hshValues.get("txt_sub_outstanding")));
					arrValues.add(correctNull((String)hshValues.get("txt_sub_overdue")));
					arrValues.add(correctNull((String)hshValues.get("txt_sub_dp")));
					
					arrValues.add(correctNull((String)hshValues.get("txt_adhocdate")));
					arrValues.add(correctNull((String)hshValues.get("txt_remarks")));
					arrValues.add(Strmmrno);
					hshQuery.put("arrValues",arrValues); 
					hshQuery.put("strQueryId","ins_annexurefacility"); 
					
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(correctNull((String)hshValues.get("category")));
					//arrValues.add(cbsid);
					//arrValues.add(mon_month);
					//arrValues.add(mon_year);
					arrValues.add(Strmmrno);
					arrValues.add(""+strGroupId);
					hshQuery.put("strQueryId","upd_annexurefacility"); 
					hshQuery.put("arrValues",arrValues); 
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
		}
		else if(strAction.equals("update"))
		{
			
				
				strSno = correctNull((String)hshValues.get("headSno"));
				//arrValues.add(cbsid);
				//arrValues.add(mon_year);
				//arrValues.add(mon_month);
				arrValues.add(Strmmrno);
				arrValues.add(strSno);
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_annexurefacility"); 
				hshQuery.put("arrValues",arrValues); 
				hshQueryValues.put("1",hshQuery);
				
				strGroupId = Integer.parseInt(Helper.correctInt(strSno));
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				
				arrValues.add(cbsid);
				arrValues.add(mon_month);
				arrValues.add(mon_year);
				arrValues.add(strSno);
				arrValues.add(strFacHead);
				arrValues.add(strFacility);
				arrValues.add(""+strGroupId);
				arrValues.add(correctNull((String)hshValues.get("category")));
				arrValues.add(correctNull((String)hshValues.get("txt_exist_limit")));
				arrValues.add(correctNull((String)hshValues.get("txt_outstanding")));
				arrValues.add(correctNull((String)hshValues.get("txt_overdue")));
				arrValues.add(correctNull((String)hshValues.get("txt_dp")));
				
				arrValues.add(correctNull((String)hshValues.get("txt_adhocdate")));
				arrValues.add(correctNull((String)hshValues.get("txt_desc")));
				arrValues.add(Strmmrno);
				
				hshQuery.put("arrValues",arrValues); 
				hshQuery.put("strQueryId","ins_annexurefacility"); 
				
				hshQueryValues.put("size","2");
				hshQueryValues.put("2",hshQuery);
				//EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
				
				if(!correctNull((String)hshValues.get("checkbox")).equals(""))
				{
					
					
					strSno =correctNull((String)hshValues.get("subLimitSno"));
					
					if(strSno.equals(""))
					{
						strQuery = SQLParser.getSqlQuery("maxannexurefacility^"+Strmmrno);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strSno = rs.getString(1);
						}
					}
					strGroupId = Integer.parseInt(Helper.correctInt((String)hshValues.get("hidgrpno")));
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					//arrValues.add(cbsid);
					//arrValues.add(mon_year);
					//arrValues.add(mon_month);
					arrValues.add(Strmmrno);
					arrValues.add(strSno);
					hshQuery.put("strQueryId","del_annexurefacility"); 
					hshQuery.put("arrValues",arrValues); 
					hshQueryValues.put("size","3");
					hshQueryValues.put("3",hshQuery);
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(cbsid);
					arrValues.add(mon_month);
					arrValues.add(mon_year);
					arrValues.add(strSno);
					arrValues.add(strSubFacHead);
					arrValues.add(strSubFacility);
					arrValues.add(""+strGroupId);
					arrValues.add(correctNull((String)hshValues.get("category")));
					arrValues.add(correctNull((String)hshValues.get("txt_subexist_limit")));
					arrValues.add(correctNull((String)hshValues.get("txt_sub_outstanding")));
					arrValues.add(correctNull((String)hshValues.get("txt_sub_overdue")));
					arrValues.add(correctNull((String)hshValues.get("txt_sub_dp")));
					
					arrValues.add(correctNull((String)hshValues.get("txt_adhocdate")));
					arrValues.add(correctNull((String)hshValues.get("txt_remarks")));
					arrValues.add(Strmmrno);
					hshQuery.put("arrValues",arrValues); 
					hshQuery.put("strQueryId","ins_annexurefacility"); 
					
					hshQueryValues.put("size","4");
					hshQueryValues.put("4",hshQuery);
				}
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(correctNull((String)hshValues.get("category")));
				arrValues.add(Strmmrno);
				//arrValues.add(cbsid);
				//arrValues.add(mon_month);
				//arrValues.add(mon_year);
				arrValues.add(""+strGroupId);
				hshQuery.put("strQueryId","upd_annexurefacility"); 
				hshQuery.put("arrValues",arrValues); 
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
			
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		else if(strAction.equals("delete"))
		{
			if(!correctNull((String)hshValues.get("checkbox")).equals(""))
			{
				strSno =correctNull((String)hshValues.get("subLimitSno"));
			}
			else
			{
				strSno = correctNull((String)hshValues.get("headSno"));
			}
		
				
			arrValues.add(Strmmrno);
			arrValues.add(strSno);
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","del_annexurefacility"); 
			hshQuery.put("arrValues",arrValues); 
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		
		
		
		
		
	}
	catch(Exception e)
	{
		throw new EJBException("Error in updateAnnexureFacility "+e.getMessage());
	}
	
	finally
	{
		try
		{	if(rs != null)
				rs.close();
			
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
}


public HashMap getAnnexureFacility(HashMap hshValues)
{
	ResultSet rs=null;
	HashMap hshRecord=new HashMap();
	
	try
	{
		
		
		String cbsid=correctNull((String)hshValues.get("cbsid"));
		String mon_month=correctNull((String)hshValues.get("mon_month"));
		String mon_year=correctNull((String)hshValues.get("mon_year"));
		String cbsname=correctNull((String)hshValues.get("cbsname"));
		String Strmmrno=correctNull((String)hshValues.get("mmrno"));
		String strQuery ="",fac_validupto="";
		
		ArrayList arrRow = new ArrayList();
 		ArrayList arrCol = new ArrayList();
 		
		
 		strQuery=SQLParser.getSqlQuery("sel_annexurefacility^"+Strmmrno);
 		
 		
 		double totalSanction =0.00,totalOS = 0.00, totalOverDue =0.00;
 		
 		
 		rs=DBUtils.executeQuery(strQuery);
 		while(rs.next())
		{
 			arrCol = new ArrayList();
 			arrCol.add(correctNull(rs.getString("facility_headid"))); //0
 			arrCol.add(correctNull(rs.getString("facility")));
 			arrCol.add(correctNull(rs.getString("fac_parent")));
 			arrCol.add(correctNull(rs.getString("fac_facility")));
 			arrCol.add(correctNull(rs.getString("fac_group")));
 			arrCol.add(correctNull(rs.getString("fac_category")));
 			arrCol.add(correctNull(rs.getString("fac_sancamt")));
 			arrCol.add(correctNull(rs.getString("fac_os")));
 			arrCol.add(correctNull(rs.getString("fac_overdue")));
 			arrCol.add(correctNull(rs.getString("fac_dp")));
 			arrCol.add(correctNull(rs.getString("fac_validupto")));
 			arrCol.add(correctNull(rs.getString("fac_reasons")));
 			arrCol.add(correctNull(rs.getString("fac_sno")));
 			
 			if(correctNull(rs.getString("fac_group")).equals(correctNull(rs.getString("fac_sno"))))
 			{	
 				totalSanction = totalSanction + Double.parseDouble(Helper.correctDouble(correctNull(rs.getString("fac_sancamt"))));
 			}
 			
 			if(Double.parseDouble(Helper.correctDouble(correctNull(rs.getString("fac_os"))))<0)
 			{
 				totalOS = totalOS + Double.parseDouble(Helper.correctDouble(correctNull(rs.getString("fac_os"))));
 			
 			}
 			
 				totalOverDue = totalOverDue + Double.parseDouble(Helper.correctDouble(correctNull(rs.getString("fac_overdue"))));
 			
 			
 			fac_validupto = correctNull(rs.getString("fac_validupto"));
			if(fac_validupto.indexOf("/")!=-1)
			{
				fac_validupto = Helper.getMonths(Integer.parseInt(Helper.correctInt(fac_validupto.split("/")[1])))+" "+fac_validupto.split("/")[2];
			}
			
			arrCol.add(fac_validupto);
 			
 			arrRow.add(arrCol);
 			
 	    }
 		
 		String org_name ="";
 		
 		if(!correctNull((String)hshValues.get("checkPrint")).equals(""))
 		{	
 		
	 		strQuery=SQLParser.getSqlQuery("getmonborrowerbyid^"+cbsid+"^"+"and org_code like '001%'");
	 		rs=DBUtils.executeQuery(strQuery);
	 		if(rs.next())
			{
	 			org_name  = correctNull(rs.getString("org_name"));
			}
 		}
 		hshRecord.put("org_name",org_name);
 		 NumberFormat nf = NumberFormat.getInstance();
		 nf.setGroupingUsed(false);
		 nf.setMaximumFractionDigits(6);
		 nf.setMinimumFractionDigits(2);
		 
 		hshRecord.put("totalSanction",nf.format(totalSanction));
 		hshRecord.put("totalOS",nf.format(totalOS));
 		hshRecord.put("totalOverDue",nf.format(totalOverDue));
 		
 		
 		hshRecord.put("arrRow",arrRow);
 		hshRecord.put("mon_month",mon_month);
		hshRecord.put("mon_year",mon_year);
		hshRecord.put("cbsid",cbsid);
		hshRecord.put("cbsname",cbsname);
		
	}
	catch(Exception e)
	{
		throw new EJBException("Error in getMMRFacility"+e.getMessage());
	}
	finally
	{
		try
		{	if(rs != null)
				rs.close();
			
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	return hshRecord;

}




//end


}