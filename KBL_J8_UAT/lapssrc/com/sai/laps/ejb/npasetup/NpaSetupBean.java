package com.sai.laps.ejb.npasetup; 

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.SetupParams;
import com.sai.laps.tagdatahelper.TagDataHelper7;

@Stateless(name = "NpaSetupBean", mappedName = "NpaSetupHome")
@Remote (NpaSetupRemote.class)
public class NpaSetupBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(NpaSetupBean.class);

	public void updateaggregatemeansData(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues= new ArrayList();
			
		ResultSet rs=null;
		String strQuery ="",strExp="$";
		String strsno="";
		String strKeyId = "";
		StringBuilder sbolddata = new StringBuilder();
		String strAction =Helper.correctNull((String)hshValues.get("hidAction"));
		String minvalue=Helper.correctNull((String)hshValues.get("txt_minpercent"));
		String maxvalue=Helper.correctNull((String)hshValues.get("txt_maxpercent"));
		String strpoints=Helper.correctNull((String)hshValues.get("txt_points"));
		String aggrid=Helper.correctNull((String)hshValues.get("hidAggregate_ID"));
		try
		{
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				rs = DBUtils.executeLAPSQuery("selectaggregate_audit^"+aggrid);
				if(rs.next())
				{
					sbolddata.append("~ Minimum Percentage of Crystallised dues = "+Helper.correctNull((String)rs.getString("MIN_PERCENTAGE")));
					sbolddata.append("~ Maximum Percentage of Crystallised dues = "+Helper.correctNull((String)rs.getString("MAX_PERCENTAGE")));
					sbolddata.append("~ Points to be given = "+Helper.correctNull((String)rs.getString("POINTS")));
				}
				if(rs!=null)
				rs.close();
			}
			
			
			
			if(strAction.equalsIgnoreCase("insert"))
			{	
				
				strQuery = SQLParser.getSqlQuery("chknpaaggregate^"+minvalue);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					    strExp = strExp + " Check the existing percentage range ";
						throw new Exception(strExp);
					
				}
				if(rs!=null)
				{
					rs.close();
				}
				strQuery="sel_maxaggregatemeans";
				rs=DBUtils.executeLAPSQuery(strQuery);
				if(rs.next())
				{
					 strsno=Helper.correctNull((String)rs.getString("aggregate_id"));
				}
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insaggregatemeans");
				arrValues.add(strsno);
				arrValues.add(minvalue);
				arrValues.add(maxvalue);
				arrValues.add(strpoints);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				strQuery = SQLParser.getSqlQuery("chknpaaggregate^"+minvalue);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					    strExp = strExp + " Check the existing percentage range ";
						throw new Exception(strExp);
					
				}
				if(rs!=null)
				{
					rs.close();
				}
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","updaggregatemeans");
				arrValues.add(minvalue);
				arrValues.add(maxvalue);
				arrValues.add(strpoints);
				arrValues.add(aggrid);
				
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
				arrValues.add(aggrid);
				hshQuery.put("strQueryId","delaggregatemeans");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
					
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
			
			
		
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("Insert"))
			{
			sbAuditTrial.append("Minimum Percentage of Crystallised dues=").append(correctNull((String )hshValues.get("txt_minpercent")))
			.append("~Maximum Percentage of Crystallised dues =").append(correctNull((String )hshValues.get("txt_maxpercent")))
			.append("~Points to be given =").append(correctNull((String )hshValues.get("txt_points")));
			}
			//if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
			//	hshValues.put("hidAction", "update");
			AuditTrial.auditNewLog(hshValues,"98",strKeyId,sbAuditTrial.toString(),sbolddata.toString());
		}catch(Exception e)
		{
			throw new EJBException("Error in updatePresentPosition"+e.getMessage());
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
				log.error("error occured"+e1.toString());
			}
		}
}
	public HashMap getaggregatemeansData(HashMap hshValues) 
	{
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		boolean recordflag=false;
			
		try
		{
			
			if(rs!=null)
			{
					rs.close();

			}
			rs=DBUtils.executeLAPSQuery("selaggregatemeanspercent");
			while(rs.next())
			{
				recordflag=true;
				vecCol = new ArrayList();
				vecCol.add(correctNull((String)rs.getString("AGGREGATE_ID")));
				vecCol.add(correctNull((String)rs.getString("MIN_PERCENTAGE")));
				vecCol.add(correctNull((String)rs.getString("MAX_PERCENTAGE")));
				vecCol.add(correctNull((String)rs.getString("POINTS")));
				vecRow.add(vecCol);
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
	public void updateAgeofNpa(HashMap hshValues)
	{
			HashMap hshQueryValues=null;
			HashMap hshQuery=null;
			ArrayList arrValues=null;
			String strQuery="";
			ResultSet rs=null;
			String hidAction=Helper.correctNull((String)hshValues.get("hidAction"));
			String sno=Helper.correctNull((String)hshValues.get("hidsno"));
			String minage_npa=Helper.correctNull((String)hshValues.get("minage_npa"));
			String maxage_npa=Helper.correctNull((String)hshValues.get("maxage_npa"));
			String points_npa=Helper.correctNull((String)hshValues.get("points_npa"));
			String strKeyId = "",strExp="$";
			StringBuilder sbolddata = new StringBuilder();
			try
			{
				strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
				if(hidAction.equalsIgnoreCase("update") || hidAction.equalsIgnoreCase("delete"))
				{
					rs = DBUtils.executeLAPSQuery("selageofnpa_audit^"+sno);
					if(rs.next())
					{
						sbolddata.append("~ Minimum Age of NPA = "+Helper.correctNull((String)rs.getString("npa_minofage")));
						sbolddata.append("~ Maximum Age of NPA = "+Helper.correctNull((String)rs.getString("npa_maxage")));
						sbolddata.append("~ Points of NPA = "+Helper.correctNull((String)rs.getString("npa_point")));
					}
					if(rs!=null)
					rs.close();
				}
			if(hidAction.equalsIgnoreCase("insert"))
			{
					if(rs!=null)
					{
						rs.close();
					}
					strQuery = SQLParser.getSqlQuery("chkageofnpa^"+minage_npa);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next())
					{
						    strExp = strExp + " Check the existing Age range";
							throw new Exception(strExp);
						
					}
					if(rs!=null)
					{
						rs.close();
					}
					
					strQuery="selmaxageofnpa";
					rs=DBUtils.executeLAPSQuery(strQuery);
					if(rs.next())
					{
						 sno=Helper.correctNull((String)rs.getString(1));	
					}

					
					hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(sno);
					arrValues.add(minage_npa);
					arrValues.add(maxage_npa);
					arrValues.add(points_npa);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","insageofnpa");
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updatedata");
			}
			else if(hidAction.equalsIgnoreCase("update"))
				{
					hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					
					arrValues.add(minage_npa);
					arrValues.add(maxage_npa);
					arrValues.add(points_npa);
					arrValues.add(sno);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","updageofnpa");
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updatedata");
				}
			else if(hidAction.equalsIgnoreCase("delete"))
				{
					hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(sno);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","delageofnpa");
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updatedata");
				}
			
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(!hidAction.equalsIgnoreCase("delete"))
			{
				sbAuditTrial.append("Minimum Age of NPA=").append(correctNull((String )hshValues.get("minage_npa"))).append("~Maximum Age of NPA =").append(correctNull((String )hshValues.get("maxage_npa")))
				.append("~Points of NPA =").append(correctNull((String )hshValues.get("points_npa")));	
			}
			
			AuditTrial.auditNewLog(hshValues,"99",strKeyId,sbAuditTrial.toString(),sbolddata.toString());
			
			}catch(Exception e)
				{
					throw new EJBException("Connection Error in UpdateAgeofNp"+e.getMessage());
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
					log.error("error occured"+e1.toString());
				}
			}
	}	


	public HashMap getAgeofNpa(HashMap hshValues)
	{
			HashMap hshRecord=new HashMap();
			ArrayList arrRow=new ArrayList();
			ArrayList arrCol=new ArrayList();
			ResultSet rs=null;
			boolean recordflag=false;
			try
			{
				if(rs!=null)
				{
						rs.close();

				}
				rs=DBUtils.executeLAPSQuery("selageofnpa");
				while(rs.next())
				{
					recordflag=true;
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull((String)rs.getString(1)));
					arrCol.add(Helper.correctNull((String)rs.getString(2)));
					arrCol.add(Helper.correctNull((String)rs.getString(3)));
					arrCol.add(Helper.correctNull((String)rs.getString(4)));
					arrRow.add(arrCol);
				}
				hshRecord.put("arrRow",arrRow);
				if(recordflag)
					hshRecord.put("recordflag","Y");
				else
					hshRecord.put("recordflag","N");
			}
			catch (Exception e)
			{
				throw new EJBException("Connection Error in getAgeofNpa"+e.getMessage());
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
					log.error("error occured"+e1.toString());
				}
			}
			return hshRecord;

	}
	
	
	public void updateMethodology(HashMap hshValues)
	{
			HashMap hshQueryValues=null;
			HashMap hshQuery=null;
			ArrayList arrValues=null;
			String strQuery="";
			ResultSet rs=null;
			String hidAction=Helper.correctNull((String)hshValues.get("hidAction"));
			String sno=Helper.correctNull((String)hshValues.get("hidsno"));
			String minpoint_scored=Helper.correctNull((String)hshValues.get("minpoint_scored"));
			String maxpoint_scored=Helper.correctNull((String)hshValues.get("maxpoint_scored"));
			String min_runledger=Helper.correctNull((String)hshValues.get("min_runledger"));
			String max_runledger=Helper.correctNull((String)hshValues.get("max_runledger"));
			String rate_interest=Helper.correctNull((String)hshValues.get("rate_interest"));
			String strKeyId = "";
			StringBuilder sbolddata = new StringBuilder();
			try
			{
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			if(hidAction.equalsIgnoreCase("update") || hidAction.equalsIgnoreCase("delete"))
			{
				rs = DBUtils.executeLAPSQuery("selnpamethodology_audit^"+sno);
				if(rs.next())
				{
					sbolddata.append("~ Minimum Points Scored = "+Helper.correctNull((String)rs.getString("npamehod_minscore")));
					sbolddata.append("~ Maximum Points Scored = "+Helper.correctNull((String)rs.getString("npamehod_maxscore")));
					sbolddata.append("~ Minimum O/S R.L (%) = "+Helper.correctNull((String)rs.getString("npamehod_minledger")));
					sbolddata.append("~ Maximum O/S R.L (%) = "+Helper.correctNull((String)rs.getString("npamehod_maxledger")));
					sbolddata.append("~ Rate of Applicable Interest = "+Helper.correctNull((String)rs.getString("npamethd_rateinterest")));
				}
				if(rs!=null)
				rs.close();
			}
			if(hidAction.equalsIgnoreCase("insert"))
			{
					if(rs!=null)
					{
						rs.close();
					}
					strQuery="selmaxnpamethodology";
					rs=DBUtils.executeLAPSQuery(strQuery);
					if(rs.next())
					{
						 sno=Helper.correctNull((String)rs.getString(1));	
					}

					
					hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(sno);
					arrValues.add(minpoint_scored);
					arrValues.add(maxpoint_scored);
					arrValues.add(min_runledger);
					arrValues.add(max_runledger);
					arrValues.add(rate_interest);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","insnpamethodology");
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updatedata");
			}
			else if(hidAction.equalsIgnoreCase("update"))
				{
					hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					
					arrValues.add(minpoint_scored);
					arrValues.add(maxpoint_scored);
					arrValues.add(min_runledger);
					arrValues.add(max_runledger);
					arrValues.add(rate_interest);
					arrValues.add(sno);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","updnpamethodology");
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updatedata");
				}
			else if(hidAction.equalsIgnoreCase("delete"))
				{
					hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(sno);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","delnpamethodology");
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updatedata");
				}
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(!hidAction.equalsIgnoreCase("delete"))
			{
			sbAuditTrial.append("Minimum Points Scored =").append(correctNull((String )hshValues.get("minpoint_scored")))
			.append("~Maximum Points Scored =").append(correctNull((String )hshValues.get("maxpoint_scored")))
			.append("~Minimum O/S R.L (%) =").append(correctNull((String )hshValues.get("min_runledger")))
			.append("~Maximum O/S R.L (%) =").append(correctNull((String )hshValues.get("max_runledger")))
			.append("~Rate of Applicable Interest  =").append(correctNull((String )hshValues.get("rate_interest")));
			}
			//if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
			//	hshValues.put("hidAction", "update");
			AuditTrial.auditNewLog(hshValues,"101",strKeyId,sbAuditTrial.toString(),sbolddata.toString());
			
			}catch(Exception e)
				{
					throw new EJBException("Connection Error in updateMethodology"+e.getMessage());
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
					log.error("error occured"+e1.toString());
				}
			}
	}	


	public HashMap getMethodology(HashMap hshValues)
	{
			HashMap hshRecord=new HashMap();
			ArrayList arrRow=new ArrayList();
			ArrayList arrCol=new ArrayList();
			ResultSet rs=null;
			boolean recordflag=false;  
			try
			{
				if(rs!=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("selnpamethodology");
				while(rs.next())
				{
					recordflag=true;
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull((String)rs.getString("npamethod_sno")));
					arrCol.add(Helper.correctNull((String)rs.getString("npamehod_minscore")));
					arrCol.add(Helper.correctNull((String)rs.getString("npamehod_maxscore")));
					arrCol.add(Helper.correctNull((String)rs.getString("npamehod_minledger")));
					arrCol.add(Helper.correctNull((String)rs.getString("npamehod_maxledger")));
					arrCol.add(Helper.correctNull((String)rs.getString("npamethd_rateinterest")));
					arrRow.add(arrCol);
				}
				hshRecord.put("arrRow",arrRow);
				if(recordflag)
					hshRecord.put("recordflag","Y");
				else
					hshRecord.put("recordflag","N");
			}
			catch (Exception e)
			{
				throw new EJBException("Connection Error in getMethodology"+e.getMessage());
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
					log.error("error occured"+e1.toString());
				}
			}
			return hshRecord;

	}           
	public void updateNpainterest(HashMap hshValues)
	{
		HashMap hshQueryValues=null;
		HashMap hshQuery=null;
		ArrayList arrValues=null;
		String strQuery="";
		ResultSet rs=null;
		ResultSet rs1=null;
		String hidAction=Helper.correctNull((String)hshValues.get("hidAction"));
		String sno=Helper.correctNull((String)hshValues.get("hidno"));
		String str_interest=Helper.correctNull((String)hshValues.get("sel_interest"));
		String str_rate=Helper.correctNull((String)hshValues.get("txtrate"));
		String str_circrefno=Helper.correctNull((String)hshValues.get("txtcircrefno"));
		String str_circdate=Helper.correctNull((String)hshValues.get("txtcircdate"));
		String str_circulartext=Helper.correctNull((String)hshValues.get("circulartext"));
		String strint="";
		String strKeyId = "";
		StringBuilder sbolddata = new StringBuilder();
		java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		try
		{
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("N"))
			{
				hshValues.put("hidAction","Insert");
			}
			else if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
			{
				hshValues.put("hidAction","Update");
			}
			
			if(hidAction.equalsIgnoreCase("update") || hidAction.equalsIgnoreCase("delete"))
			{
				rs = DBUtils.executeLAPSQuery("getnpainterest^"+str_interest);
				if(rs.next())
				{
					if(!Helper.correctNull((String)rs.getString("npa_interest")).equalsIgnoreCase("")){
						rs1=DBUtils.executeLAPSQuery("getstaticdata_soldid^"+"30^"+Helper.correctNull((String)rs.getString("npa_interest")));
						if(rs1.next()){
							sbolddata.append("~ Interest Description ="+correctNull((String)rs1.getString("stat_data_desc1")));
						}else{
							sbolddata.append("~Interest Description="+"");
						}}else{
							sbolddata.append("~Interest Description="+"");
						}
						if(rs1 != null){
							rs1.close();
						}
					
					
					sbolddata.append("~ Interest Rate (%) = "+nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("npa_intrate")))));
					sbolddata.append("~ Circular Reference No = "+Helper.correctNull((String)rs.getString("npa_circrefno")));
					sbolddata.append("~ Circular Date = "+Helper.correctNull((String)rs.getString("npa_circdate")));
				}
				if(rs!=null)
				rs.close();
			}
		if(hidAction.equalsIgnoreCase("update"))
		{
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("getnpainterest^"+str_interest);
			if(rs.next())
			{
				 strint=Helper.correctNull((String)rs.getString("npa_interest"));	
			}
			if(strint.equalsIgnoreCase(str_interest))
			{
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				
				arrValues.add(str_interest);
				arrValues.add(str_rate);
				arrValues.add(str_circrefno);
				arrValues.add(str_circdate);
				arrValues.add(str_circulartext);
				arrValues.add(str_interest);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","updnpainterest");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updatedata");
			}
			else
			{
				if(rs!=null)
				{
					rs.close();
				}
				strQuery="selmaxnpainterest";
				rs=DBUtils.executeLAPSQuery(strQuery);
				if(rs.next())
				{
					 sno=Helper.correctNull((String)rs.getString(1));	
				}
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(sno);
				arrValues.add(str_interest);
				arrValues.add(str_rate);
				arrValues.add(str_circrefno);
				arrValues.add(str_circdate);
				arrValues.add(str_circulartext);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","insnpainterest");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updatedata");
			}
			
		}
		
		if(hidAction.equalsIgnoreCase("delete")){
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			arrValues.add(sno);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","delnpainterest");
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updatedata");
		}
		
		hidAction =Helper.correctNull((String)hshValues.get("hidAction"));
		StringBuilder sbAuditTrial=new StringBuilder();
		if(!hidAction.equalsIgnoreCase("delete"))
		{
			sbAuditTrial.append("Interest Descrption =").append(correctNull((String )hshValues.get("sel_interest1"))).append("~Interest Rate (%) =").append(correctNull((String )hshValues.get("txtrate")))
			.append("~Circular Reference No =").append(correctNull((String )hshValues.get("txtcircrefno")))
			.append("~Circular Date  =").append(correctNull((String )hshValues.get("txtcircdate")));
		}
	//	if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
	//		hshValues.put("hidAction", "update");
		AuditTrial.auditNewLog(hshValues,"100",strKeyId,sbAuditTrial.toString(),sbolddata.toString());
		}catch(Exception e)
			{
				throw new EJBException("Connection Error in updateNpainterest"+e.getMessage());
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
				log.error("error occured"+e1.toString());
			}
		}
	}
	public HashMap getNpainterest(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		String str_interest=Helper.correctNull((String)hshValues.get("sel_interest"));
		if(str_interest.equals(""))
				{
			str_interest="0";
				}
		boolean recordflag=false; 
		try
		{
			if(rs!=null)
			{
					rs.close();

			}
		
			//if(hidAction.equalsIgnoreCase("get"))
			//{
				rs=DBUtils.executeLAPSQuery("getnpainterest^"+str_interest);
				
				while(rs.next())
				{
					recordflag=true;
					hshRecord.put("npa_intsno",Helper.correctNull((String)rs.getString("npa_intsno")));
					hshRecord.put("npa_interest",Helper.correctNull((String)rs.getString("npa_interest")));
					hshRecord.put("npa_intrate",Helper.correctNull((String)rs.getString("npa_intrate")));
					hshRecord.put("npa_circrefno",Helper.correctNull((String)rs.getString("npa_circrefno")));
					hshRecord.put("npa_circdate",Helper.correctNull((String)rs.getString("npa_circdate")));
					hshRecord.put("npa_circtext",Helper.correctNull((String)rs.getString("npa_circtext")));
					
				}
			//}
			/*else
			{
				if(rs!=null)
				{
						rs.close();

				}
				rs=DBUtils.executeLAPSQuery("selnpainterest");
				while(rs.next())
				{
					hshRecord.put("npa_intsno",Helper.correctNull((String)rs.getString("npa_intsno")));
					hshRecord.put("npa_interest",Helper.correctNull((String)rs.getString("npa_interest")));
					hshRecord.put("npa_intrate",Helper.correctNull((String)rs.getString("npa_intrate")));
					hshRecord.put("npa_circrefno",Helper.correctNull((String)rs.getString("npa_circrefno")));
					hshRecord.put("npa_circdate",Helper.correctNull((String)rs.getString("npa_circdate")));
					hshRecord.put("npa_circtext",Helper.correctNull((String)rs.getString("npa_circtext")));
				}
			}*/
			hshRecord.put("str_interest",str_interest);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
		}
		catch (Exception e)
		{
			throw new EJBException("Connection Error in getNpainterest"+e.getMessage());
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
				log.error("error occured"+e1.toString());
			}
		}
		return hshRecord;
		
	}
	public void updateRealisible(HashMap hshValues)
	{
		HashMap hshQueryValues=null;
		HashMap hshQuery=null;
		ArrayList arrValues=null;
		String strQuery="",strExp="$";
		ResultSet rs=null;
		String hidAction=Helper.correctNull((String)hshValues.get("hidAction"));
		String sno=Helper.correctNull((String)hshValues.get("hidsno"));
		String Realisible_id=Helper.correctNull((String)hshValues.get("hidRealisible_ID"));
		String sel_marketability=Helper.correctNull((String)hshValues.get("sel_marketability"));
		String str_minper=Helper.correctNull((String)hshValues.get("txt_minpercentage"));
		String str_maxper=Helper.correctNull((String)hshValues.get("txt_maxpercentage"));
		String str_points=Helper.correctNull((String)hshValues.get("txt_points"));
		String strKeyId = "";
		StringBuilder sbolddata = new StringBuilder();
		try
		{
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			if(hidAction.equalsIgnoreCase("update") || hidAction.equalsIgnoreCase("delete"))
			{
				rs = DBUtils.executeLAPSQuery("selsetrelisible_audit^"+Realisible_id);
				if(rs.next())
				{
					if(Helper.correctNull((String)rs.getString("realisible_value")).equalsIgnoreCase("1"))
					{
						sbolddata.append("~ Marketability of Security = EASILY MARKETABLE");
					}
					else if(Helper.correctNull((String)rs.getString("realisible_value")).equalsIgnoreCase("2"))
					{
						sbolddata.append("~ Marketability of Security = NOT EASILY MARKETABLE");
					}
					else if(Helper.correctNull((String)rs.getString("realisible_value")).equalsIgnoreCase("3"))
					{
						sbolddata.append("~ Marketability of Security = VERY DIFFICULT TO MARKET");
					}
					sbolddata.append("~ Minimum Percentage of Crystallised dues = "+Helper.correctNull((String)rs.getString("min_percentage")));
					sbolddata.append("~ Maximum Percentage of Crystallised dues = "+Helper.correctNull((String)rs.getString("max_percentage")));
					sbolddata.append("~ Points to be given = "+Helper.correctNull((String)rs.getString("points")));
				}
				if(rs!=null)
				rs.close();
			}
			if(hidAction.equalsIgnoreCase("insert"))
		 	{
			if(rs!=null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("chknparealisible^"+str_minper+"^"+sel_marketability);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				    strExp = strExp + " Check the existing percentage range ";
					throw new Exception(strExp);
				
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery="selmaxrealisible";
			rs=DBUtils.executeLAPSQuery(strQuery);
			if(rs.next())
			{
				 sno=Helper.correctNull((String)rs.getString(1));	
			}

			
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			arrValues.add(sno);
			arrValues.add(sel_marketability);
			arrValues.add(str_minper);
			arrValues.add(str_maxper);
			arrValues.add(str_points);
			
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","insrealisible");
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updatedata");
		 	}
	
			else if(hidAction.equalsIgnoreCase("update"))
			{
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				
				arrValues.add(sel_marketability);
				arrValues.add(str_minper);
				arrValues.add(str_maxper);
				arrValues.add(str_points);
				
				arrValues.add(Realisible_id);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","updrealisible");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updatedata");
			}
			else if(hidAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(Realisible_id);
				hshQuery.put("strQueryId","delrealisible");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
		
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(!hidAction.equalsIgnoreCase("delete"))
			{
				sbAuditTrial.append("Marketability of Security =").append(correctNull((String )hshValues.get("sel_marketability1")))
				.append("~Minimum Percentage of Crystallised dues =").append(correctNull((String )hshValues.get("txt_minpercentage")))
				.append("~Maximum Percentage of Crystallised dues =").append(correctNull((String )hshValues.get("txt_maxpercentage")))
				.append("~Points to be given =").append(correctNull((String )hshValues.get("txt_points")));
			}
		//	if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
		//		hshValues.put("hidAction", "update");
			AuditTrial.auditNewLog(hshValues,"356",strKeyId,sbAuditTrial.toString(),sbolddata.toString());
		}
		catch(Exception e)
			{
				throw new EJBException("Connection Error in updateNpainterest"+e.getMessage());
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
				log.error("error occured"+e1.toString());
			}
		}
	}
	public HashMap getRealisible(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String s1;
		ResultSet rs=null,rs1=null;
		boolean recordflag=false;  
		String hidAction=Helper.correctNull((String)hshValues.get("hidAction"));
		String str_marketability=Helper.correctNull((String)hshValues.get("hidRealisible_ID"));
		if(str_marketability.equals(""))
				{
			str_marketability="0";
				}
		try
		{
				if(rs!=null)
				{
						rs.close();
	
				}
		
				if(hidAction.equalsIgnoreCase("get"))
				{
				rs=DBUtils.executeLAPSQuery("getrealisible^"+str_marketability);
				
				while(rs.next())
				{
					{
						recordflag=true;
						vecCol = new ArrayList();
						vecCol.add(correctNull((String)rs.getString("realisible_id")));
						s1=correctNull((String)rs.getString("realisible_value"));
						vecCol.add(s1);
						vecCol.add(correctNull((String)rs.getString("min_percentage")));
						vecCol.add(correctNull((String)rs.getString("max_percentage")));
						vecCol.add(correctNull((String)rs.getString("points")));
						
						vecRow.add(vecCol);
					}
				}
				}
		
	    else
			{
				if(rs!=null)
				{
						rs.close();
	
				}
				rs=DBUtils.executeLAPSQuery("selrealisible");
				while(rs.next())
				{
					{
						recordflag=true;
						vecCol = new ArrayList();
						vecCol.add(correctNull((String)rs.getString("realisible_id")));
						s1=correctNull((String)rs.getString("realisible_value"));
						vecCol.add(s1);
						vecCol.add(correctNull((String)rs.getString("min_percentage")));
						vecCol.add(correctNull((String)rs.getString("max_percentage")));
						vecCol.add(correctNull((String)rs.getString("points")));
						rs1=DBUtils.executeLAPSQuery("getstaticdesc^28^"+s1);
						if(rs1.next())
						{
							vecCol.add(correctNull((String)rs1.getString("stat_data_desc1")));
						}
						else
						{
							vecCol.add("");
						}
						vecRow.add(vecCol);
					}
				}
				hshRecord.put("vecRow",vecRow);
				
				if(recordflag)
					hshRecord.put("recordflag","Y");
				else
					hshRecord.put("recordflag","N");
			
			}
			}
		catch (Exception e)
		{
			throw new EJBException("Connection Error in getNpainterest"+e.getMessage());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
				
				if(rs1!= null)
				{
					rs1.close();
				}
				
			}
			catch (Exception e1)
			{
				log.error("error occured"+e1.toString());
			}
		}
		return hshRecord;
		
	}
	public HashMap getLegalPosition(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		
		ResultSet rs=null;
		
		String strQuery="";
		String strLegalposition="";
		boolean recordflag=false;
		try
		{
			strLegalposition=correctNull((String)hshValues.get("sel_legalposition"));
			strQuery = SQLParser.getSqlQuery("sel_npalegal^"+strLegalposition);
			rs = DBUtils.executeQuery(strQuery);	
			if (rs.next())
			{ 
				recordflag=true;
				hshResult.put("legalposition",correctNull((rs.getString("NPA_LEGALPOSITION"))));
				hshResult.put("point",correctNull((rs.getString("NPA_POINT"))));
			}
			hshResult.put("legalposition",strLegalposition);
			if(recordflag)
				hshResult.put("recordflag","Y");
			else
				hshResult.put("recordflag","N");
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getLegalPosition ::  "+ce.toString());
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
	

	public void updateLegalPosition(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues= new ArrayList();
		String strKeyId = "";
		String strAction =Helper.correctNull((String)hshValues.get("hidAction"));
		ResultSet rs = null;
		StringBuilder sbolddata = new StringBuilder();
		TagDataHelper7 tagData = new TagDataHelper7();
		try
		{
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				rs = DBUtils.executeLAPSQuery("sel_npalegal^"+Helper.correctNull((String)hshValues.get("sel_legalposition")));
				if(rs.next())
				{
					sbolddata.append("~ Legal Position = "+Helper.correctNull((String)tagData.getStaticDataDesc("29",Helper.correctNull((String)rs.getString("npa_legalposition")))));
					sbolddata.append("~ Points to be given = "+Helper.correctNull((String)rs.getString("npa_point")));
				}
				if(rs!=null)
				rs.close();
			}
			if(strAction.equalsIgnoreCase("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","del_npalegal");
				arrValues.add(correctNull((String)hshValues.get("sel_legalposition")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId","ins_npalegal");
				arrValues.add(correctNull((String)hshValues.get("sel_legalposition")));
				arrValues.add(correctNull((String)hshValues.get("txt_points")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","del_npalegal");
				arrValues.add(correctNull((String)hshValues.get("sel_legalposition")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(!strAction.equalsIgnoreCase("delete"))
			{
			sbAuditTrial.append("Legal Position=").append(correctNull((String )hshValues.get("sel_legalposition1")))
			.append("~Points to be given =").append(correctNull((String )hshValues.get("txt_points")));
			}

			if(correctNull((String)hshValues.get("hidRecordflag")).equals("N"))
				hshValues.put("hidAction", "Insert");

			AuditTrial.auditNewLog(hshValues,"102",strKeyId,sbAuditTrial.toString(),sbolddata.toString());
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updateLegalPosition :: " + e.getMessage());
		} 
	}
}