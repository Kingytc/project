package com.sai.laps.ejb.staticdata;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.fw.management.utils.FwHelper;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.SetupParams;

@Stateless(name = "staticdataBean", mappedName = "staticdataHome")
@Remote (staticdataRemote.class)
public class staticdataBean extends BeanAdapter
{	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6247830558007536603L;
	static Logger log=Logger.getLogger(staticdataBean.class);
	/**
	 * 
	 */
	
	public void updateData(HashMap hshValues)
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshQry = new HashMap();
		ArrayList arrVal = new ArrayList();
		ResultSet rs=null;
		String getMaxGradeId = "",strStatId="";	
		String hidslno="";
		String action = correctNull((String)hshValues.get("hidAction"));
		strStatId = correctNull((String)hshValues.get("seldataheadtype"));
		hidslno = correctNull((String)hshValues.get("hidsno"));
		String strKeyId = "";
		StringBuilder sbolddata=new StringBuilder();   
		String strExp="$";
		ResultSet rs1=null;

		try
		{		
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			if(action.equalsIgnoreCase("update") || action.equalsIgnoreCase("delete"))
			{
				rs = DBUtils.executeLAPSQuery("getstatdatavalue^"+strStatId+"^"+hidslno);
				while(rs.next())
				{
					sbolddata.append("~ Data Heads = "+Helper.correctNull((String)hshValues.get("seldataheadtype1")));
					sbolddata.append("~ Data Value = "+Helper.correctNull((String)rs.getString("stat_data_desc")));
					sbolddata.append("~ Data Description = "+Helper.correctNull((String)rs.getString("stat_data_desc1")));
					sbolddata.append("~ Shown to User = "+Helper.correctNull((String)rs.getString("stat_data_active")));
					sbolddata.append("~ Data Limit Value = "+Helper.correctNull((String)rs.getString("stat_data_value")));
					sbolddata.append("~ Input Value = "+Helper.correctNull((String)rs.getString("stat_data_valuedesc")));
				}
				if(rs!=null)
				rs.close();
			}
			if(action.equalsIgnoreCase("insert"))
			{
				if(strStatId.equalsIgnoreCase("41") || strStatId.equalsIgnoreCase("42") || strStatId.equalsIgnoreCase("32"))
					rs=DBUtils.executeLAPSQuery("getstaticdata_soldid^"+strStatId+"^"+correctNull((String)hshValues.get("txt_datavalues")));
				else
					rs=DBUtils.executeLAPSQuery("getstaticdata_soldid^"+strStatId+"^"+correctNull((String)hshValues.get("txt_datavalues")).toUpperCase());
				if(rs.next())
				{
					strExp = strExp + "Data Value already exist";
					throw new Exception(strExp);
				}
				
				rs1=DBUtils.executeLAPSQuery("sel_headchk^"+correctNull((String)hshValues.get("txt_datavalues")).toUpperCase()+"^"+Helper.correctNull((String)hshValues.get("sel_gecltype")));
				if(rs1.next())
				{
					strExp = strExp + "Name of Sector already exist";
					throw new Exception(strExp);
				}
				String qry="Staticdatavaluesmax^";
				getMaxGradeId = Integer.toString(getMaxGradeId(strStatId,qry));				
				hshqueryval.put("size","1");
				hshQry.put("strQueryId","inssataticdtaval");
				arrVal.add(strStatId);
				arrVal.add(getMaxGradeId);
				if(strStatId.equalsIgnoreCase("41") || strStatId.equalsIgnoreCase("42") || strStatId.equalsIgnoreCase("32"))
				{
					arrVal.add(correctNull((String)hshValues.get("txt_datavalues")));
					arrVal.add(correctNull((String)hshValues.get("txt_datavalues1")));
					arrVal.add(correctNull((String)hshValues.get("selactive")));
				}
				else
				{
					arrVal.add(correctNull((String)hshValues.get("txt_datavalues")));
					arrVal.add(correctNull((String)hshValues.get("txt_datavalues1")));
					arrVal.add(correctNull((String)hshValues.get("selactive")));
				}
				if(strStatId.equalsIgnoreCase("205"))
					arrVal.add(correctNull((String)hshValues.get("txt_value")));
				else if(strStatId.equalsIgnoreCase("218")||strStatId.equalsIgnoreCase("252"))
					arrVal.add(correctNull((String)hshValues.get("selSMS")));
				else if(strStatId.equalsIgnoreCase("283"))
					arrVal.add(correctNull((String)hshValues.get("sel_Industry")));
				else if(strStatId.equalsIgnoreCase("211"))
					arrVal.add(correctNull((String)hshValues.get("sel_act")));
				else if(strStatId.equalsIgnoreCase("144"))
					arrVal.add(correctNull((String)hshValues.get("sel_type")));
				else if(strStatId.equalsIgnoreCase("225")||strStatId.equalsIgnoreCase("226")||strStatId.equalsIgnoreCase("227")||strStatId.equalsIgnoreCase("228")||strStatId.equalsIgnoreCase("229")||strStatId.equalsIgnoreCase("230"))
					arrVal.add(correctNull((String)hshValues.get("sel_inputtype")));
				else if(strStatId.equalsIgnoreCase("234"))
					arrVal.add(correctNull((String)hshValues.get("sel_eligibility")));
				else if(strStatId.equalsIgnoreCase("240")||strStatId.equalsIgnoreCase("264")||strStatId.equalsIgnoreCase("265"))
					arrVal.add(correctNull((String)hshValues.get("hidsel_reasonfor")));
				//else if(strStatId.equalsIgnoreCase("233")||strStatId.equalsIgnoreCase("234"))
				//	arrVal.add(correctNull((String)hshValues.get("sel_gecltype")));
				else
					arrVal.add("");
				if(strStatId.equalsIgnoreCase("234"))
					arrVal.add(correctNull((String)hshValues.get("sel_inputtype1")));	
				else if(strStatId.equalsIgnoreCase("240")||strStatId.equalsIgnoreCase("264")||strStatId.equalsIgnoreCase("265") || strStatId.equalsIgnoreCase("245") || strStatId.equalsIgnoreCase("246"))
					arrVal.add(correctNull((String)hshValues.get("hidsel_module")));	
				else
					arrVal.add(correctNull((String)hshValues.get("txt_inputvalue")));
				
				arrVal.add(correctNull((String)hshValues.get("txt_inputvalue1")));
				 if(strStatId.equalsIgnoreCase("233")||strStatId.equalsIgnoreCase("234")||strStatId.equalsIgnoreCase("247"))
					arrVal.add(correctNull((String)hshValues.get("sel_gecltype")));
				 else
				arrVal.add("");
				 if(strStatId.equalsIgnoreCase("234")){
					arrVal.add(correctNull((String)hshValues.get("txt_inputvalue2")));
				 arrVal.add(correctNull((String)hshValues.get("sel_sector")));
				 }else{
					arrVal.add("");
					arrVal.add("");

				 }
				 
				 if(strStatId.equalsIgnoreCase("252"))
						arrVal.add(correctNull((String)hshValues.get("sel_bankscheme")));
				 else{
						arrVal.add("");
 
				 }
				 if(strStatId.equalsIgnoreCase("256")||strStatId.equalsIgnoreCase("257")|| strStatId.equalsIgnoreCase("278")){
						arrVal.add(correctNull((String)hshValues.get("txt_inputsolvalue1")));
					 arrVal.add(correctNull((String)hshValues.get("txt_inputsolvalue2")));
					 }else{
						arrVal.add("");
						arrVal.add("");

					 }
				 if(strStatId.equalsIgnoreCase("267")){
						arrVal.add(correctNull((String)hshValues.get("sel_CersaiReq")));
				 }else{
					 arrVal.add("");
				 }
				 arrVal.add("");
				arrVal.add("");
				hshQry.put("arrValues",arrVal);							
				hshqueryval.put("1",hshQry);
				
				
				if(strStatId.equalsIgnoreCase("224"))
				{
					rs=DBUtils.executeLAPSQuery("sel_mclrspreadmaster^"+correctNull((String)hshValues.get("txt_datavalues")));
					if(rs.next())
					{
						strExp = strExp + "Data Value already exist in MCLR Spread Master";
						throw new Exception(strExp);
					}
					else
					{
						arrVal=new ArrayList();
						hshQry=new HashMap();
						hshqueryval.put("size","2");
						hshQry.put("strQueryId","ins_mclr_spreadmaster");
						arrVal.add(correctNull((String)hshValues.get("txt_datavalues")));
						arrVal.add(correctNull((String)hshValues.get("txt_datavalues1")));
						arrVal.add("0");
						arrVal.add(correctNull((String)hshValues.get("selactive")));
						hshQry.put("arrValues",arrVal);							
						hshqueryval.put("2",hshQry);
					}
				}
				
				
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				
				
				
			}
			else if(action.equalsIgnoreCase("update"))
			{
				if(strStatId.equalsIgnoreCase("41") || strStatId.equalsIgnoreCase("42") || strStatId.equalsIgnoreCase("32"))
					rs=DBUtils.executeLAPSQuery("getstaticdata_soldid^"+strStatId+"^"+correctNull((String)hshValues.get("txt_datavalues")));
				else
					rs=DBUtils.executeLAPSQuery("getstaticdata_soldid^"+strStatId+"^"+correctNull((String)hshValues.get("txt_datavalues")).toUpperCase());
				if(rs.next())
				{
					if(!Helper.correctNull(rs.getString("stat_data_sno")).equalsIgnoreCase(hidslno))
					{
						strExp = strExp + "Data Value already exist";
						throw new Exception(strExp);
					}
				}
				rs1=DBUtils.executeLAPSQuery("sel_headchk^"+correctNull((String)hshValues.get("sel_sector")));
				if(rs1.next())
				{
					strExp = strExp + "Name of Sector already exist";
					throw new Exception(strExp);
				}
				hshqueryval.put("size","1");
				hshQry.put("strQueryId","updsataticdtaval");
				if(strStatId.equals("42") || strStatId.equals("41") || strStatId.equalsIgnoreCase("32"))
				{
					arrVal.add(correctNull((String)hshValues.get("txt_datavalues")));
					arrVal.add(correctNull((String)hshValues.get("txt_datavalues1")));
					arrVal.add(correctNull((String)hshValues.get("selactive")));
				}
				else
				{
					arrVal.add(correctNull((String)hshValues.get("txt_datavalues")));
					arrVal.add(correctNull((String)hshValues.get("txt_datavalues1")));
					arrVal.add(correctNull((String)hshValues.get("selactive")));
				}
				if(strStatId.equalsIgnoreCase("205"))
					arrVal.add(correctNull((String)hshValues.get("txt_value")));
				else if(strStatId.equalsIgnoreCase("218")||strStatId.equalsIgnoreCase("252"))
					arrVal.add(correctNull((String)hshValues.get("selSMS")));
				else if(strStatId.equalsIgnoreCase("283"))	
					arrVal.add(correctNull((String)hshValues.get("sel_Industry")));	
				else if(strStatId.equalsIgnoreCase("211"))	
					arrVal.add(correctNull((String)hshValues.get("sel_act")));
				/*else if(strStatId.equalsIgnoreCase("211"))
					arrVal.add(correctNull((String)hshValues.get("sel_Industry")));*/
				else if(strStatId.equalsIgnoreCase("144"))
					arrVal.add(correctNull((String)hshValues.get("sel_type")));
				else if(strStatId.equalsIgnoreCase("225")||strStatId.equalsIgnoreCase("226")||strStatId.equalsIgnoreCase("227")||strStatId.equalsIgnoreCase("228")||strStatId.equalsIgnoreCase("229")||strStatId.equalsIgnoreCase("230"))
					arrVal.add(correctNull((String)hshValues.get("sel_inputtype")));
				else if(strStatId.equalsIgnoreCase("234"))
					arrVal.add(correctNull((String)hshValues.get("sel_eligibility")));
				else if(strStatId.equalsIgnoreCase("240")||strStatId.equalsIgnoreCase("264")||strStatId.equalsIgnoreCase("265"))
					arrVal.add(correctNull((String)hshValues.get("hidsel_reasonfor")));
				//else if(strStatId.equalsIgnoreCase("233")||strStatId.equalsIgnoreCase("234"))
				//	arrVal.add(correctNull((String)hshValues.get("sel_gecltype")));
				else
					arrVal.add("");
				if(strStatId.equalsIgnoreCase("234"))
					arrVal.add(correctNull((String)hshValues.get("sel_inputtype1")));	
				else if(strStatId.equalsIgnoreCase("240")||strStatId.equalsIgnoreCase("264")||strStatId.equalsIgnoreCase("265") || strStatId.equalsIgnoreCase("245") || strStatId.equalsIgnoreCase("246"))
					arrVal.add(correctNull((String)hshValues.get("hidsel_module")));	
				else
					arrVal.add(correctNull((String)hshValues.get("txt_inputvalue")));
				
				arrVal.add(correctNull((String)hshValues.get("txt_inputvalue1")));	
				 if(strStatId.equalsIgnoreCase("233")||strStatId.equalsIgnoreCase("234")||strStatId.equalsIgnoreCase("247"))
					arrVal.add(correctNull((String)hshValues.get("sel_gecltype")));
				 else
					arrVal.add("");
				 if(strStatId.equalsIgnoreCase("234")){
						arrVal.add(correctNull((String)hshValues.get("txt_inputvalue2")));
					 arrVal.add(correctNull((String)hshValues.get("sel_sector")));
					 }else{
						arrVal.add("");
						arrVal.add("");
					 }
				 if(strStatId.equalsIgnoreCase("252"))
						arrVal.add(correctNull((String)hshValues.get("sel_bankscheme")));
				 else{
						arrVal.add("");

				 }
				 if(strStatId.equalsIgnoreCase("256")||strStatId.equalsIgnoreCase("257") || strStatId.equalsIgnoreCase("278")){
						arrVal.add(correctNull((String)hshValues.get("txt_inputsolvalue1")));
					 arrVal.add(correctNull((String)hshValues.get("txt_inputsolvalue2")));
					 }else{
						arrVal.add("");
						arrVal.add("");

					 }
				 if(strStatId.equalsIgnoreCase("267")){
						arrVal.add(correctNull((String)hshValues.get("sel_CersaiReq")));
				 }else{
					 arrVal.add("");
				 }
				 arrVal.add("");
				 arrVal.add("");
				arrVal.add(strStatId);
				arrVal.add(hidslno);
				hshQry.put("arrValues",arrVal);
							
				hshqueryval.put("1",hshQry);
				
				
				if(strStatId.equalsIgnoreCase("224"))
				{
						arrVal=new ArrayList();
						hshQry=new HashMap();
						hshqueryval.put("size","2");
						hshQry.put("strQueryId","upd_mclr_spreadmaster");
						arrVal.add(correctNull((String)hshValues.get("txt_datavalues1")));
						arrVal.add("0");
						arrVal.add(correctNull((String)hshValues.get("selactive")));
						arrVal.add(correctNull((String)hshValues.get("txt_datavalues")));
						hshQry.put("arrValues",arrVal);							
						hshqueryval.put("2",hshQry);
				}
				
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			else if(action.equalsIgnoreCase("delete"))
			{
				hshqueryval.put("size","1");
				hshQry.put("strQueryId","staticdatadel");
				arrVal.add(strStatId);
				arrVal.add(hidslno);
				hshQry.put("arrValues",arrVal);
							
				hshqueryval.put("1",hshQry);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			
			StringBuilder sbAuditTrial=new StringBuilder();
			sbAuditTrial.append("~ Data Heads=").append(correctNull((String )hshValues.get("seldataheadtype1"))).append("~Data Value =").append(correctNull((String )hshValues.get("txt_datavalues")))
			.append("~ Data Description =").append(correctNull((String )hshValues.get("txt_datavalues1"))).append("~ Shown to User=").append(correctNull((String)hshValues.get("selactive")))
			.append("~ Data Limit Value").append(correctNull((String)hshValues.get("txt_value"))).append("~ SMS Trigger=").append(correctNull((String)hshValues.get("selSMS")))
			.append("~ Nature of industry").append(correctNull((String)hshValues.get("sel_Industry"))).append("~input value will be =").append(correctNull((String)hshValues.get("sel_inputtype")))
			.append(correctNull((String)hshValues.get("txt_inputvalue")));
			
			if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
				hshValues.put("hidAction", "update");		
			AuditTrial.auditNewLog(hshValues,"350",strKeyId,sbAuditTrial.toString(),sbolddata.toString());
		}
		catch (Exception e)
		{
			throw new EJBException("Error in bean "+e.toString());
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
	
	public HashMap getDataonselect(HashMap hshValues) 
	{	
		
		String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord =new HashMap();
		String strsno = "";
		String strdatahead = "";
		
		try
		{
			
			strdatahead = correctNull((String)hshValues.get("statdatahead"));
			strsno = correctNull((String)hshValues.get("statsno"));
			
			strQuery=SQLParser.getSqlQuery("getstaticdatavaldisp^"+strdatahead+"^"+strsno);		
			rs = DBUtils.executeQuery(strQuery);
		
			if(rs.next())
			{
				hshRecord.put("sno",correctNull(rs.getString("stat_data_sno")));
				hshRecord.put("datavalue",correctNull(rs.getString("stat_data_desc")));
				hshRecord.put("datadesc",correctNull(rs.getString("stat_data_desc1")));
				hshRecord.put("dataactive",correctNull(rs.getString("stat_data_active")));
				hshRecord.put("datavalue1",correctNull(rs.getString("stat_data_value")));
				hshRecord.put("stat_data_valuedesc",correctNull(rs.getString("stat_data_valuedesc")));
				hshRecord.put("dataId",correctNull(rs.getString("stat_data_id")));
				hshRecord.put("stat_data_descvalue1",correctNull(rs.getString("stat_data_descvalue1")));
				hshRecord.put("STATIC_DATA_GECLDESC",correctNull(rs.getString("STATIC_DATA_GECLDESC")));
				hshRecord.put("STATIC_DATA_MAXVAL",correctNull(rs.getString("STATIC_DATA_MAXVAL")));
				hshRecord.put("STATIC_DATA_SECTOR",correctNull(rs.getString("STATIC_DATA_SECTOR")));
				hshRecord.put("STATIC_BANK_SCHEME",correctNull(rs.getString("STATIC_BANK_SCHEME")));
				hshRecord.put("STATIC_DATA_RANGE_FROM",correctNull(rs.getString("STATIC_DATA_RANGE_FROM")));
				hshRecord.put("STATIC_DATA_RANGE_TO",correctNull(rs.getString("STATIC_DATA_RANGE_TO")));
				hshRecord.put("STATIC_DATA_CERSAIREQ",correctNull(rs.getString("STATIC_DATA_CERSAIREQ")));
				

			}	
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getDataonselect "+ce.toString());
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
	
	
	public HashMap getgeclidentification(HashMap hshValues) 
	{	
		
		String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord =new HashMap();
		String strgecltype = "";
		String strdatahead = "";
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=null;
		try
		{
			
			strdatahead = correctNull((String)hshValues.get("statheadcode"));
			strgecltype = correctNull((String)hshValues.get("GeclType"));
			
			strQuery=SQLParser.getSqlQuery("sel_geclstatidnt^"+strdatahead+"^"+strgecltype);		
			rs = DBUtils.executeQuery(strQuery);
			arrRow=new ArrayList();
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("stat_data_desc")));
				arrCol.add(Helper.correctNull((String)rs.getString("stat_data_desc1")));
				
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getgeclidentification "+ce.toString());
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
	
	
	public HashMap getData(HashMap hshValues) 
	{	
				String strQuery="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord =new HashMap();
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
		String hidslno = "";
		
		try
		{
			String strStatId = "";
			hidslno = correctNull((String)hshValues.get("hidsno"));
			if(hidslno==""){
				hidslno="0";
			}
			strStatId = correctNull((String)hshValues.get("seldataheadtype"));
			if(!(strStatId.trim().equalsIgnoreCase("")))
			{
				strStatId = correctNull((String)hshValues.get("seldataheadtype"));
			}
			else
			{
				strStatId = "0";
			}
			strQuery=SQLParser.getSqlQuery("getstaticdatavalues^"+strStatId);		
			rs = DBUtils.executeQuery(strQuery);
		
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));
				vecCol.add(correctNull(rs.getString(2)));
				vecCol.add(correctNull(rs.getString(3)));
				vecCol.add(correctNull(rs.getString(4)));
				vecCol.add(correctNull(rs.getString(5)));
				if(strStatId.equalsIgnoreCase("234"))
				{
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("getstaticdata_soldid^233^"+correctNull(rs.getString(6)));
					if(rs1.next())
						vecCol.add(correctNull(rs1.getString("stat_data_desc1")));
					else
						vecCol.add("");
				}
				else if(strStatId.equalsIgnoreCase("283")){
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("getstaticdata_soldid^210^"+correctNull(rs.getString(6)));
					if(rs1.next())
						//vecCol.addElement(correctNull(rs.getString(6))+"-"+correctNull(rs1.getString("stat_data_desc1")));
						vecCol.add(correctNull(rs1.getString("stat_data_desc1")));
					else
						vecCol.add("");
				}
				else if(strStatId.equalsIgnoreCase("211")){
					if(rs1!=null)
						rs1.close();
				//	rs1=DBUtils.executeLAPSQuery("getstaticdata_soldid^210^"+correctNull(rs.getString(6)));
					rs1=DBUtils.executeLAPSQuery("getstaticdata_soldid^283^"+correctNull(rs.getString(6)));
					if(rs1.next())
						vecCol.add(correctNull(rs1.getString("stat_data_desc1")));
					else
						vecCol.add("");
				}
				else
					vecCol.add(correctNull(rs.getString(6)));
				vecCol.add(correctNull(rs.getString(7)));
				vecCol.add(correctNull(rs.getString(8)));
				vecCol.add(correctNull(rs.getString(9)));
				vecCol.add(correctNull(rs.getString(10)));
				vecCol.add(correctNull(rs.getString(11)));
				vecCol.add(correctNull(rs.getString(12)));
				vecCol.add(correctNull(rs.getString(13)));
				vecCol.add(correctNull(rs.getString(14)));
				vecCol.add(correctNull(rs.getString(15)));
				vecRow.add(vecCol);							
			}	
			
			hshRecord.put("vecRow",vecRow);
			hshRecord.put("strStatId",strStatId);

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
	 
	public int getMaxGradeId(String strStatId,String qry)
	{
		
		ResultSet rs = null;
		int termId = 0;

		try
		{	
			String strQuery=SQLParser.getSqlQuery(qry+strStatId);
			rs =DBUtils.executeQuery(strQuery);	
			
			while(rs.next())
			{
				if(rs.getString(1) != null)
				{
					termId = Integer.parseInt(rs.getString(1)) + 1;
				}
				else
				{
					termId = 1;
				}
			}
			rs.close();			
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
		return termId;
	}
	
	//Adding Masters page Methods
	
	public void updateLawyerMasterData(HashMap hshValues)
	{		 
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();	 
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		ResultSet rs1 = null;
		String strOrgCode=""; 
	 	String strAction = null;		 
		String strslno = "";
		String strlawyername = "";
		String strlawyeradd1 = "";
		String strlawyeradd2 = "";
		String strlawyeradd3 = "";
		String strlawyercity ="";
		String strlawyerstate ="";
		String strpincode ="";
		String strlawyer_country ="";
		String strlawyer_off_phoneno ="";
		String strlawyer_off_faxno ="";
		String strlawyer_res_phoneno ="";
		String strlawyer_res_mobno ="";
		String strlawyer_contper ="";
		String strlawyer_contper_phmobno="";		
		String strlawyer_design ="";
		String strlawyer_email ="";
		String strlawyer_empaneleddt ="";
		String strlawyer_active ="";
		String strlawyer_comments ="";
		String strlawyer_blacklistdate ="";
		String strlawyer_blacklist ="";
		String strRegionalcode="";
		String strseqno="";
		
		String lawhistsno="";
		
		
		String strQuery2="";
		
		
		
		String str_elitepanel="";
		try
		{
				
			strOrgCode = correctNull((String)hshValues.get("org_code"));
			if(!strOrgCode.equalsIgnoreCase(""))
			strRegionalcode=strOrgCode.substring(0,9);
			strAction = correctNull((String)hshValues.get("hidAction"));
			strslno	= correctNull((String )hshValues.get("hidsno"));
			strlawyername = correctNull((String)hshValues.get("txt_name")).toUpperCase();
			strlawyeradd1 = correctNull((String)hshValues.get("txt_address1")).toUpperCase();
			strlawyeradd2 = correctNull((String)hshValues.get("txt_address2")).toUpperCase();
			strlawyeradd3 = correctNull((String)hshValues.get("txt_address3")).toUpperCase();
			strlawyercity = correctNull((String)hshValues.get("hidcity")).toUpperCase();
			strlawyerstate = correctNull((String)hshValues.get("hidstate")).toUpperCase();
			strpincode = correctNull((String)hshValues.get("txt_zip"));
			strlawyer_country = correctNull((String)hshValues.get("txt_country")).toUpperCase();
			strlawyer_off_phoneno = correctNull((String)hshValues.get("txt_offphone"));
			strlawyer_off_faxno = correctNull((String)hshValues.get("txt_offfaxno"));
			strlawyer_res_phoneno = correctNull((String)hshValues.get("txt_resphone"));
			strlawyer_res_mobno = correctNull((String)hshValues.get("txt_resmobileno"));
			strlawyer_contper = correctNull((String)hshValues.get("txt_contactperson")).toUpperCase();			
			strlawyer_contper_phmobno = correctNull((String)hshValues.get("txt_contactmobilephone"));
			strlawyer_design = correctNull((String)hshValues.get("txt_desig1"));
			strlawyer_email = correctNull((String)hshValues.get("txt_emailid"));
			strlawyer_empaneleddt = correctNull((String)hshValues.get("txt_empaneledon"));
			if(strlawyer_empaneleddt.equalsIgnoreCase(""))
			{
				strlawyer_empaneleddt=null;
			}
			strlawyer_active = correctNull((String)hshValues.get("txt_action"));
			strlawyer_comments = correctNull((String)hshValues.get("txt_comments"));
			strlawyer_blacklist = correctNull((String)hshValues.get("sel_blacklist"));
			strlawyer_blacklistdate = correctNull((String)hshValues.get("txt_blacklistdate"));
			str_elitepanel=correctNull((String)hshValues.get("sel_elitepanel"));
			
			
			strseqno= correctNull((String)hshValues.get("hidseqno"));
			
			if(strlawyer_blacklistdate.equalsIgnoreCase(""))
			{
				strlawyer_blacklistdate="01/01/1900";
			}
			
			StringBuilder sbAuditTrialOld=new StringBuilder();
			if(strAction.equalsIgnoreCase("update"))
			{
				if(rs != null){
					rs.close();
				}
				String cityname="",statename="";
				String strQuery = SQLParser.getSqlQuery("getlawyerdet^"+strseqno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()){
					rs1 =DBUtils.executeLAPSQuery("sel_cityname^"+correctNull(rs.getString("lawyer_city")));
					if(rs1.next())
					{
						cityname=correctNull(rs1.getString("city_name"));
					}
					if(rs1!=null)
					rs1.close();
					rs1 =DBUtils.executeLAPSQuery("sel_statename^"+correctNull(rs.getString("lawyer_state")));
					if(rs1.next())
					{
						statename=correctNull(rs1.getString("state_name"));
					}
					if(rs1!=null)
					rs1.close();
					sbAuditTrialOld.append("Lawyer Name =").append(correctNull(rs.getString("lawyer_name")))
					.append("~Contact Person Name  =").append(correctNull(rs.getString("lawyer_contper")))
					.append("~Lawyer Address =").append(correctNull(rs.getString("lawyer_address1")))
					.append("").append(",")
					.append(" "+correctNull(rs.getString("lawyer_address2")))
					.append("").append(",")
					.append(correctNull(rs.getString("lawyer_address3")))
					.append("~Contact Person Mobile /Phone No. =").append(correctNull(rs.getString("lawyer_contper_phmobno")))
					.append("~Contact Person's Designation =").append(correctNull(rs.getString("lawyer_design"))).append("~City  =").append(cityname)
					.append("~"+ApplicationParams.getZipName()+" =").append(correctNull(rs.getString("lawyer_pincode")))
					.append("~State =").append(statename)
					.append("~Country =").append(correctNull(rs.getString("lawyer_country")))
					.append("~Empanelled on =").append(correctNull(rs.getString("lawyer_empaneleddt")))
					.append("~Residential Phone No. =").append(correctNull(rs.getString("lawyer_res_phoneno")))
					.append("~Mobile No. =").append(correctNull(rs.getString("lawyer_res_mobno")))
					.append("~Office Phone No. =").append(correctNull(rs.getString("lawyer_off_phoneno")))
					.append("~Office Fax No. =").append(correctNull(rs.getString("lawyer_off_faxno")))
					.append("~Action =").append(correctNull(SetupParams.getSetupParams("MasterAction",(String)rs.getString("lawyer_active"))))
					.append("~Email Id =").append(correctNull(rs.getString("lawyer_off_faxno")))
					.append("~If he is Black Listed =").append(SetupParams.getSetupParams("SacrificeLimit",(String)rs.getString("lawyer_blacklist")));
					
					if(((String)rs.getString("lawyer_blacklist")).equals("Y"))
					{	
						sbAuditTrialOld.append("~Black Listed Date =").append(correctNull(rs.getString("lawyer_blacklistdate")));
					}
				}
			}
			if (strAction.equalsIgnoreCase("insert"))
			{
				rs1 =DBUtils.executeLAPSQuery("max_lawyermaster");
				
				
				while(rs1.next())
				{	
					strslno = rs1.getString("MAXID");
				}	
				if(strlawyer_design.equalsIgnoreCase(""))
				{
					strlawyer_design = "0";
				}
				arrValues.add(strOrgCode);
				arrValues.add(strslno);
				arrValues.add(strlawyername);
				arrValues.add(strlawyeradd1);
				arrValues.add(strlawyeradd2);
				arrValues.add(strlawyeradd3);
				arrValues.add(strlawyercity);
				arrValues.add(strlawyerstate);
				arrValues.add(strpincode);
				arrValues.add(strlawyer_country);
				arrValues.add(strlawyer_off_phoneno);
				arrValues.add(strlawyer_off_faxno);
				arrValues.add(strlawyer_res_phoneno);
				arrValues.add(strlawyer_res_mobno);
				arrValues.add(strlawyer_contper);
				arrValues.add(strlawyer_contper_phmobno);				
				arrValues.add(strlawyer_design);
				arrValues.add(strlawyer_email);
				arrValues.add(strlawyer_empaneleddt);
				arrValues.add(strlawyer_active);
				arrValues.add(strlawyer_comments);
				arrValues.add(strlawyer_blacklist);
				arrValues.add(strlawyer_blacklistdate);
				arrValues.add(strRegionalcode);
				arrValues.add(str_elitepanel);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_lawyermaster");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				
				
				
				arrValues=new ArrayList();
				hshQuery=new HashMap();
			
				if(rs != null){
					rs.close();
				}
				
				strQuery2=SQLParser.getSqlQuery("sel_max_lawyerhistorysno^"+strslno);
				rs=DBUtils.executeQuery(strQuery2);
				
				if(rs.next()){
					lawhistsno=correctNull((String)rs.getString("lawyer_history_sno"));
				}
				
				
				arrValues.add(strslno);
				arrValues.add(lawhistsno);
				arrValues.add(str_elitepanel);
				arrValues.add(correctNull((String)hshValues.get("strUserId")));
				arrValues.add(strOrgCode);
				
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_lawyermasterhistory");
				hshQueryValues.put("size","2");
				hshQueryValues.put("2",hshQuery);
				
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}			
			else if(strAction.equalsIgnoreCase("update"))
			{
				/*String strExRegCode="";
				String strExOrgCode=Helper.correctNull((String)hshValues.get("hidExorgcode"));
				if(!strExOrgCode.equalsIgnoreCase(""))
					strExRegCode=strExOrgCode.substring(0, 9);*/
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strOrgCode);
				arrValues.add(strslno);
				arrValues.add(strlawyername);
				arrValues.add(strlawyeradd1);
				arrValues.add(strlawyeradd2);
				arrValues.add(strlawyeradd3);
				arrValues.add(strlawyercity);
				arrValues.add(strlawyerstate);
				arrValues.add(strpincode);
				arrValues.add(strlawyer_country);
				arrValues.add(strlawyer_off_phoneno);
				arrValues.add(strlawyer_off_faxno);
				arrValues.add(strlawyer_res_phoneno);
				arrValues.add(strlawyer_res_mobno);
				arrValues.add(strlawyer_contper);
				arrValues.add(strlawyer_contper_phmobno);				
				arrValues.add(strlawyer_design);
				arrValues.add(strlawyer_email);
				arrValues.add(strlawyer_empaneleddt);
				arrValues.add(strlawyer_active);
				arrValues.add(strlawyer_comments);
				arrValues.add(strlawyer_blacklist);
				arrValues.add(strlawyer_blacklistdate);
				arrValues.add(strOrgCode.substring(0, 6));
				arrValues.add(str_elitepanel);
				arrValues.add(strseqno);
				//arrValues.add(correctNull((String)hshValues.get("strOrgCode")));
				//arrValues.add(strslno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upd_lawyermaster");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				
				if(!str_elitepanel.equalsIgnoreCase(correctNull((String)hshValues.get("hidelitepanel"))))
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					
					if(rs != null){
						rs.close();
					}
					
					strQuery2=SQLParser.getSqlQuery("sel_max_lawyerhistorysno^"+strslno);
					rs=DBUtils.executeQuery(strQuery2);
					
					if(rs.next()){
						lawhistsno=correctNull((String)rs.getString("lawyer_history_sno"));
					}
					
					arrValues.add(strslno);
					arrValues.add(lawhistsno);
					arrValues.add(str_elitepanel);
					arrValues.add(correctNull((String)hshValues.get("strUserId")));
					arrValues.add(strOrgCode);
					
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","ins_lawyermasterhistory");
					hshQueryValues.put("size","2");
					hshQueryValues.put("2",hshQuery);
				}
				
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}	
			
			if(rs!=null)
			{
				rs.close();
			}
			
			String strQuery1="sel_lawyercode^"+strRegionalcode+"^"+strslno;
			rs = DBUtils.executeLAPSQuery(strQuery1);
			if(rs.next())
			{
				strseqno = Helper.correctNull((String)rs.getString("lawyer_seqno"));
			}
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update")){
			sbAuditTrial.append("Lawyer Name =").append(correctNull((String )hshValues.get("txt_name"))).append("~Contact Person Name  =").append(correctNull((String )hshValues.get("txt_contactperson")))
			.append("~Lawyer Address =").append(correctNull((String )hshValues.get("txt_address1")))
			.append("").append(",")
			.append(" "+correctNull((String )hshValues.get("txt_address2")))
			.append("").append(",")
			.append(" "+correctNull((String )hshValues.get("txt_address3"))).append("~Contact Person Mobile /Phone No. =").append(correctNull((String )hshValues.get("txt_contactmobilephone")))
			.append("~Contact Person's Designation  =").append(correctNull((String )hshValues.get("txt_desig1"))).append("~City  =").append(correctNull((String )hshValues.get("txt_city")))
			.append("~"+ApplicationParams.getZipName()+" =").append(correctNull((String )hshValues.get("txt_zip"))).append("~State  =").append(correctNull((String )hshValues.get("txt_state")))
			.append("~Country  =").append(correctNull((String )hshValues.get("txt_country"))).append("~Empanelled on  =").append(correctNull((String )hshValues.get("txt_empaneledon")))
			.append("~Residential Phone No.  =").append(correctNull((String )hshValues.get("txt_resphone"))).append("~Mobile No.  =").append(correctNull((String )hshValues.get("txt_resmobileno")))
			.append("~Office Phone No.  =").append(correctNull((String )hshValues.get("txt_offphone"))).append("~Office Fax No.  =").append(correctNull((String )hshValues.get("txt_offfaxno")))
			.append("~Action  =").append(correctNull(SetupParams.getSetupParams("MasterAction",(String)hshValues.get("txt_action")))).append("~Email Id =").append(correctNull((String )hshValues.get("txt_emailid")))
			.append("~If he is Black Listed  =").append(SetupParams.getSetupParams("SacrificeLimit",(String)hshValues.get("sel_blacklist"))
					);
			
			if(((String)hshValues.get("sel_blacklist")).equals("Y"))
			{	
				sbAuditTrial.append("~Black Listed Date =").append(correctNull((String )hshValues.get("txt_blacklistdate")));
			}
			}
			
			
			AuditTrial.auditNewLog(hshValues,"133",strseqno,sbAuditTrial.toString(),sbAuditTrialOld.toString());
		}
		catch (Exception ce)
		{
			throw new EJBException("Error on found in u'r bean <-- "+ce.toString());
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
	}
	
	public HashMap getLawyerMasterList(HashMap hshValues) 
	{
	
		String strQuery="",scode="",svalue="";
 		ResultSet rs = null;
 		HashMap hshRecord = new HashMap();
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();
		String strOrgCode ="";
		String strAction = null;
		String strRegionalcode="";
		try
		{
			
			strAction   = correctNull((String)hshValues.get("hidAction"));
			String strsno	= correctNull((String )hshValues.get("hidsno"));
			strOrgCode = correctNull((String) hshValues.get("strOrgCode"));
			strRegionalcode=correctNull((String) hshValues.get("strOrgCode")).substring(0,9);
					
			if((strsno.trim().equals("")))
			{
				strsno="0";
			}
			if(strAction.equalsIgnoreCase("Edit")||strAction.equalsIgnoreCase("Cancel"))
			{
				strQuery = SQLParser.getSqlQuery("sel_lawyermaster^"+strOrgCode+"^"+strsno);
				rs = DBUtils.executeQuery(strQuery);				
				if(rs.next())
				{					
					hshRecord.put("ORG_CODE",(correctNull(rs.getString("ORG_CODE"))));
					hshRecord.put("LAWYER_CODE",(correctNull(rs.getString("LAWYER_CODE"))));
					hshRecord.put("LAWYER_NAME",(correctNull(rs.getString("LAWYER_NAME"))));
					hshRecord.put("LAWYER_ADDRESS1",(correctNull(rs.getString("LAWYER_ADDRESS1"))));
					hshRecord.put("LAWYER_ADDRESS2",(correctNull(rs.getString("LAWYER_ADDRESS2"))));
					hshRecord.put("LAWYER_ADDRESS3",(correctNull(rs.getString("LAWYER_ADDRESS3"))));
					hshRecord.put("LAWYER_CITY_CODE",(correctNull(rs.getString("LAWYER_CITY"))));
					hshRecord.put("LAWYER_STATE_CODE",(correctNull(rs.getString("LAWYER_STATE"))));
					hshRecord.put("LAWYER_PINCODE",(correctNull(rs.getString("LAWYER_PINCODE"))));
					hshRecord.put("LAWYER_COUNTRY",(correctNull(rs.getString("LAWYER_COUNTRY"))));
					hshRecord.put("LAWYER_OFF_PHONENO",(correctNull(rs.getString("LAWYER_OFF_PHONENO"))));
					hshRecord.put("LAWYER_OFF_FAXNO",(correctNull(rs.getString("LAWYER_OFF_FAXNO"))));
					hshRecord.put("LAWYER_RES_PHONENO",(correctNull(rs.getString("LAWYER_RES_PHONENO"))));
					hshRecord.put("LAWYER_RES_MOBNO",(correctNull(rs.getString("LAWYER_RES_MOBNO"))));
					hshRecord.put("LAWYER_CONTPER",(correctNull(rs.getString("LAWYER_CONTPER"))));
					hshRecord.put("LAWYER_CONTPER_PHMOBNO",(correctNull(rs.getString("LAWYER_CONTPER_PHMOBNO"))));					
					hshRecord.put("LAWYER_DESIGN",(correctNull(rs.getString("LAWYER_DESIGN"))));
					hshRecord.put("LAWYER_EMAIL",(correctNull(rs.getString("LAWYER_EMAIL"))));
					String empaneldate=(correctNull(rs.getString("LAWYER_EMPANELEDDT")));
					if(empaneldate.equalsIgnoreCase("01/01/1900"))
					{
						hshRecord.put("LAWYER_EMPANELEDDT","");
					}
					else
					{
						hshRecord.put("LAWYER_EMPANELEDDT",(correctNull(rs.getString("LAWYER_EMPANELEDDT"))));
					}
					hshRecord.put("LAWYER_ACTIVE",(correctNull(rs.getString("LAWYER_ACTIVE"))));
					hshRecord.put("LAWYER_COMMENTS",(correctNull(rs.getString("LAWYER_COMMENTS"))));
					hshRecord.put("lawyer_blacklist",(correctNull(rs.getString("lawyer_blacklist"))));
					String blacklistdate=(correctNull(rs.getString("lawyer_blacklistdate")));
					if(blacklistdate.equalsIgnoreCase("01/01/1900"))
					{
						hshRecord.put("lawyer_blacklistdate","");
					}
					else
					{
						hshRecord.put("lawyer_blacklistdate",(correctNull(rs.getString("lawyer_blacklistdate"))));
					}
					
					hshRecord.put("LAWYER_ELITEPANEL", (correctNull(rs.getString("LAWYER_ELITEPANEL"))));
				//	hshRecord.put("DESIGN_NAME",(correctNull(rs.getString("DESIGN_NAME"))));
					hshRecord.put("LAWYER_CITY",(correctNull(rs.getString("CITY_NAME"))));
					hshRecord.put("LAWYER_STATE",(correctNull(rs.getString("STATE_NAME"))));
					hshRecord.put("lawyer_seqno",(correctNull(rs.getString("lawyer_seqno"))));
					hshRecord.put("trapedit","E");
				}
			}
			else if(strAction.equalsIgnoreCase("search"))
			{
				scode=correctNull((String)hshValues.get("stype"));
				svalue=correctNull((String)hshValues.get("svalue"));
				String strPagefrom=Helper.correctNull((String)hshValues.get("strfrom"));
				
				if(strPagefrom.equalsIgnoreCase("LawyerMaster"))
				{
					if(scode.equals(""))
					{
						rs=DBUtils.executeLAPSQuery("sel_lawyermasterall");
					}				
					else if(scode.equals("N"))
					{
						strQuery = SQLParser.getSqlQuery("sel_lawyermastername^"+svalue);
						rs = DBUtils.executeQuery(strQuery);
					}	
				}
				else
				{
					if(scode.equals(""))
					{
						rs=DBUtils.executeLAPSQuery("sel_lawyermasterall_search^"+strOrgCode);
					}				
					else if(scode.equals("N"))
					{
						strQuery = SQLParser.getSqlQuery("sel_lawyermastername_search^"+strOrgCode+"^"+svalue);
						rs = DBUtils.executeQuery(strQuery);
					}	
				}
				while(rs.next())
				{
					
					vecCol = new ArrayList();
					vecCol.add(correctNull(rs.getString(1)));//0	org_code		 		
					vecCol.add(correctNull(rs.getString(2)));//1	lawyer_code				
					vecCol.add(correctNull(rs.getString(3)));//2 lawyer_name
					vecCol.add(correctNull(rs.getString(4)));//3 lawyer_address1
					vecCol.add(correctNull(rs.getString(5)));//4 lawyer_address2
					vecCol.add(correctNull(rs.getString(6)));//5 lawyer_address3
					vecCol.add(correctNull(rs.getString(7)));//6 lawyer_city
					vecCol.add(correctNull(rs.getString(8)));//7 lawyer_state
					vecCol.add(correctNull(rs.getString(9)));//8 lawyer_pincode 
					vecCol.add(correctNull(rs.getString(10)));//9 lawyer_country
					vecCol.add(correctNull(rs.getString(11)));//10 lawyer_off_phoneno
					vecCol.add(correctNull(rs.getString(12)));//11 lawyer_off_faxno
					vecCol.add(correctNull(rs.getString(13)));//12 lawyer_res_phoneno
					vecCol.add(correctNull(rs.getString(14)));//13 lawyer_res_mobno
					vecCol.add(correctNull(rs.getString(15)));//14 lawyer_contper
					vecCol.add(correctNull(rs.getString(16)));//15 lawyer_contper_phmobno
					vecCol.add(correctNull(rs.getString(17)));//16 lawyer_design			
					vecCol.add(correctNull(rs.getString(18)));//17 lawyer_email
					vecCol.add(correctNull(rs.getString(19)));//18 lawyer_empaneleddt
					vecCol.add(correctNull(rs.getString(20)));//19 lawyer_active
					vecCol.add(correctNull(rs.getString(21)));//20 lawyer_comments
					vecCol.add(correctNull(rs.getString(22)));//21 lawyer_blacklist
					vecCol.add(correctNull(rs.getString(23)));//22 lawyer_blacklistdate
					//vecCol.add(correctNull(rs.getString(24)));//23 design_name
					vecCol.add(correctNull(rs.getString(24)));//23 city_name
					vecCol.add(correctNull(rs.getString(25)));//24 state_name
					vecCol.add(correctNull(rs.getString(26)));//25 lawyer_seqno
					vecCol.add(correctNull(rs.getString(27)));//26 elitepanel
					vecRow.add(vecCol);
				}
				hshRecord.put("vecRow",vecRow);
				hshRecord.put("svalue", svalue);
				hshRecord.put("scode", scode);
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getLawyerMasterList "+ce.toString());
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
	
	
	
	public HashMap getLawyerMaster_legal(HashMap hshValues) 
	{
	
		String strQuery="",scode="",svalue="";
 		ResultSet rs = null;
 		HashMap hshRecord = new HashMap();
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();
		String strOrgCode ="",strCode="";
		String strAction = null;
		String strName="";
		String strOrgLevel="";
		try
		{
			
			strOrgCode = correctNull((String)hshValues.get("strOrgCode"));
			strAction   = correctNull((String)hshValues.get("hidAction"));
			strName= Helper.correctNull((String)hshValues.get("txt_ser"));
			strOrgLevel = correctNull((String) hshValues.get("strOrgLevel"));
			/*if(strOrgLevel.equalsIgnoreCase("C"))
			{
				strCode=strOrgCode.substring(0,3)+"0000000000000";
			}
			else if(strOrgLevel.equalsIgnoreCase("R"))
			{
				strCode=strOrgCode.substring(0,6)+"00000000000";
			}
			else if(strOrgLevel.equalsIgnoreCase("D"))
			{
				strCode=strOrgCode.substring(0,9)+"0000000";
			}
			else if(strOrgLevel.equalsIgnoreCase("A"))
			{
				strCode=strOrgCode.substring(0,12)+"000";
			}
			else
			{
				strCode=strOrgCode;
			}*/
			if(strAction.equalsIgnoreCase("search"))
			{
				strQuery = SQLParser.getSqlQuery("Sel_lawyername^'"+strOrgCode+"','"+strOrgCode.substring(0, 9)+"000000','"+strOrgCode.substring(0, 6)+"000000000','"+strOrgCode.substring(0, 3)+"000000000000'^"+strName);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					
					vecCol = new ArrayList();
					vecCol.add(correctNull(rs.getString(1)));//0			 		
					vecCol.add(correctNull(rs.getString("lawyer_seqno")));//1	lawyer_code				
					vecCol.add(correctNull(rs.getString(3)));//2 lawyer_name
					vecCol.add(correctNull(rs.getString(4)));
					vecRow.add(vecCol);
				}
				hshRecord.put("vecRow",vecRow);
			}
			else if(strAction.equalsIgnoreCase("legal"))
			{
				strQuery = SQLParser.getSqlQuery("Sel_lawyerlist^'"+strOrgCode+"','"+strOrgCode.substring(0, 9)+"000000','"+strOrgCode.substring(0, 6)+"000000000','"+strOrgCode.substring(0, 3)+"000000000000'");
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					
					vecCol = new ArrayList();
					vecCol.add(correctNull(rs.getString(1)));//0	org_code		 		
					vecCol.add(correctNull(rs.getString("lawyer_seqno")));//1	lawyer_code				
					vecCol.add(correctNull(rs.getString(3)));//2 lawyer_name
					vecCol.add(correctNull(rs.getString(4)));
					vecRow.add(vecCol);
				}
				hshRecord.put("vecRow",vecRow);
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getLawyerMasterList "+ce.toString());
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
	
	public void updateValuerMasterData(HashMap hshValues)
	{		 
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();	 
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		ResultSet rs1 = null;
		String strOrgCode=""; 
	 	String strAction = null;		 
		String strslno = "";
		String strvaluername = "";
		String strvalueradd1 = "";
		String strvalueradd2 = "";
		String strvalueradd3 = "";
		String strvaluercity ="";
		String strvaluerstate ="";
		String strpincode ="";
		String strvaluer_country ="";
		String strvaluer_off_phoneno ="";
		String strvaluer_off_faxno ="";
		String strvaluer_res_phoneno ="";
		String strvaluer_res_mobno ="";
		String strvaluer_contper ="";
		String strvaluer_contper_phmobno="";		
		String strvaluer_design ="";
		String strvaluer_email ="";
		String strvaluer_empaneleddt ="";
		String strvaluer_active ="";
		String strvaluer_comments ="";
		String strvaluer_blacklist ="";
		String strvaluer_blacklistdate ="";
		String strAppVal="";
		String strRegionalcode="";
		String strSeqno="";
		String strSancRefNo="";
		String strExpdateofsanc="";
		String strDetofsecdep="";
		String strDateofjewelappr="";
		String strvaluationNature="";
		String strCateforyCode="";
		String strAppvalue = "";
		String strQuery="",strExp="$",strsno="",strCBSID="";
		
		//strOrgCode=Helper.correctNull((String)hshValues.get("hidarea"));
		strsno=Helper.correctNull((String)hshValues.get("hidseqno"));
		strAppvalue=correctNull((String) hshValues.get("hidAppVal"));	
		strCBSID=Helper.correctNull((String)hshValues.get("txt_cbscustid"));
		String txt_Branchcodeappend="";
		String[] txt_Branchcode=null;
		String[] strExpiry=null;
		try
		{
				
			
			strSeqno=correctNull((String) hshValues.get("hidseqno"));
			
			if(!strCBSID.equalsIgnoreCase("") && (correctNull((String)hshValues.get("hidAction")).equalsIgnoreCase("insert")||correctNull((String)hshValues.get("hidAction")).equalsIgnoreCase("Update")))
			{
				String strTemp=" ";
				
				strQuery = SQLParser.getSqlQuery("sel_valuermaster1^"+strCBSID+"^"+strAppvalue+"^"+strTemp);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					if(correctNull((String)hshValues.get("hidAction")).equalsIgnoreCase("insert"))
					{
						strExp = strExp + " The CBSID  already exist";
						throw new Exception(strExp);
					}
					else
					{
						if(!Helper.correctNull(rs.getString("valuers_seqno")).equalsIgnoreCase(strSeqno))
						{
							strExp = strExp + " The CBSID  already exist";
							throw new Exception(strExp);
						}
					}
				}
			}
			
			if(hshValues.get("hidarea") instanceof String[])
			{
				txt_Branchcode = (String[])hshValues.get("hidarea");
				  for(int i=0;i<txt_Branchcode.length;i++)
				  {
					  if(!txt_Branchcode[i].equals(""))
					  txt_Branchcodeappend=txt_Branchcodeappend+"@"+txt_Branchcode[i];
				  }
				  txt_Branchcodeappend=txt_Branchcodeappend.replaceFirst("@","");
			}
			else
			{
				txt_Branchcodeappend=Helper.correctNull((String) hshValues.get("hidarea"));
			}
			
			String[] statecode=null;
			String[] strdistrictcode=null;
			String valloctemp="";
			
			if(hshValues.get("sel_state") instanceof String[])
			{
				statecode=(String[])hshValues.get("sel_state");
				strdistrictcode=(String[])hshValues.get("txt_districtcode");
				for(int i=0;i<statecode.length;i++)
				{
					 if(!statecode[i].equals("") && !strdistrictcode[i].equals(""))
					valloctemp=valloctemp+"@"+statecode[i]+"~"+strdistrictcode[i];
				}
				valloctemp=valloctemp.replaceFirst("@","");
			}
			else
			{
				valloctemp=Helper.correctNull((String) hshValues.get("sel_state"))+"~"+Helper.correctNull((String) hshValues.get("txt_districtcode"));;
			}
						
			strOrgCode = txt_Branchcodeappend;
			if(!strOrgCode.equalsIgnoreCase(""))
			strRegionalcode=strOrgCode.substring(0,9)+"000000";
			strAction = correctNull((String)hshValues.get("hidAction"));
			strslno	= correctNull((String )hshValues.get("hidsno"));
			strvaluername = correctNull((String)hshValues.get("txt_name"));
			strvalueradd1 = correctNull((String)hshValues.get("txt_address1"));
			strvalueradd2 = correctNull((String)hshValues.get("txt_address2"));
			strvalueradd3 = correctNull((String)hshValues.get("txt_address3"));
			strvaluercity = correctNull((String)hshValues.get("hidcity"));
			strvaluerstate = correctNull((String)hshValues.get("hidstate"));
			if(strAppvalue.equalsIgnoreCase("J"))
			{
				strpincode = correctNull((String)hshValues.get("txt_zip"));
			}
			else
			{
			strpincode = correctNull((String)hshValues.get("txt_zip1"));
			}
			strvaluer_country = correctNull((String)hshValues.get("txt_country"));
			strvaluer_off_phoneno = correctNull((String)hshValues.get("txt_offphone"));
			strvaluer_off_faxno = correctNull((String)hshValues.get("txt_offfaxno"));
			strvaluer_res_phoneno = correctNull((String)hshValues.get("txt_resphone"));
			strvaluer_res_mobno = correctNull((String)hshValues.get("txt_resmobileno"));
			strvaluer_contper = correctNull((String)hshValues.get("txt_contactperson"));			
			strvaluer_contper_phmobno = correctNull((String)hshValues.get("txt_contactmobilephone"));
			strvaluer_design = correctNull((String)hshValues.get("txt_desig1"));
			strvaluer_email = correctNull((String)hshValues.get("txt_emailid"));
			strvaluer_empaneleddt = correctNull((String)hshValues.get("txt_empaneledon"));
			strvaluer_active = correctNull((String)hshValues.get("txt_action"));
			strvaluer_comments    = correctNull((String)hshValues.get("txt_comments"));
			strvaluer_blacklist= correctNull((String)hshValues.get("sel_blacklist"));
			strvaluer_blacklistdate= correctNull((String)hshValues.get("txt_blacklistdate"));
			strAppVal=correctNull((String) hshValues.get("hidAppVal"));			
			//Added by Arsath on 30/07/2013 for Jewel Appraiser given by Prakash
			strSancRefNo = Helper.correctInt((String)hshValues.get("txt_sancrefno"));
			strExpdateofsanc = Helper.correctNull((String)hshValues.get("txt_expdateofsanc"));
			strDetofsecdep = Helper.correctDouble((String)hshValues.get("txt_detofsecdep"));
			strDateofjewelappr = Helper.correctNull((String)hshValues.get("txt_dofjewelappr"));
			String strExOrgCode= txt_Branchcodeappend;
			strvaluationNature= Helper.correctNull((String)hshValues.get("hidNatureValuation"));
			strCateforyCode= Helper.correctNull((String)hshValues.get("sel_CategoryCode"));
			//End
			
			StringBuilder strOldAudit = new StringBuilder();
			if(strAction.equalsIgnoreCase("Update"))
			{
				if(rs!=null)
				{
					rs.close();
				}
				rs = DBUtils.executeLAPSQuery("sel_valuerdet_audittrial^"+strExOrgCode+"^"+strslno);
				if(rs.next()){
					if(strAppVal.equals("V"))
					{
						strOldAudit.append("Valuer Details = Yes");
					}
					else
					{
						strOldAudit.append("Appraiser Details = Yes");
					}
					strOldAudit.append("~Appraiser / Valuer  Name = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("valuers_name")));
					strOldAudit.append("~Contact Person Name  = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("valuers_contper")));
					strOldAudit.append("~Appraiser / Valuer  Address = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("valuers_address1"))+ " "+
							Helper.correctNull((String)rs.getString("valuers_address2"))+ " "+
							Helper.correctNull((String)rs.getString("valuers_address3")));
					strOldAudit.append("~Contact Person Mobile /Phone No. = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("valuers_contper_phmobno")));
					strOldAudit.append("~Contact Person's Designation = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("valuers_design")));
					strOldAudit.append("~City   = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("city_name")));
					strOldAudit.append("~"+ApplicationParams.getZipName()+" =");
					strOldAudit.append(Helper.correctNull((String)rs.getString("valuers_pincode")));
					strOldAudit.append("~State = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("state_name")));
					strOldAudit.append("~Country = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("valuers_country")));
					strOldAudit.append("~Empanelled on = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("valuers_empaneleddt")));
					strOldAudit.append("~Residential Phone No.= ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("valuers_res_phoneno")));
					strOldAudit.append("~Mobile No. = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("valuers_res_mobno")));
					strOldAudit.append("~Office Phone No.= ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("valuers_off_phoneno")));
					strOldAudit.append("~Office Fax No.= ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("valuers_off_faxno")));
					strOldAudit.append("~Email Id= ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("valuers_email")));
					strOldAudit.append("~Action = ");
					if(Helper.correctNull((String)rs.getString("valuers_active")).equals("1"))
					{
						strOldAudit.append("Enabled");
					}else if(Helper.correctNull((String)rs.getString("valuers_active")).equals("2"))
					{
						strOldAudit.append("Disabled");
					}else{
						strOldAudit.append("");
					}
					strOldAudit.append("~If he is Black Listed = ");
					if(Helper.correctNull((String)rs.getString("valuers_blacklist")).equals("Y"))
					{
						strOldAudit.append("Yes");
					}else if(Helper.correctNull((String)rs.getString("valuers_blacklist")).equals("N"))
					{
						strOldAudit.append("No");
					}else{
						strOldAudit.append("");
					}
					if(((String)rs.getString("valuers_blacklist")).equals("Y"))
					{	
						strOldAudit.append("~Black Listed Date =").append(correctNull(rs.getString("valuers_blacklistdate")));
					}
				}
			}
			if (strAction.equalsIgnoreCase("insert"))
			{
				rs1 = DBUtils.executeLAPSQuery("max_valuermaster");				
				
				while(rs1.next())
				{	
					strslno = rs1.getString("MAXID");
				}
				if(strvaluer_design.equalsIgnoreCase(""))
				{
					strvaluer_design = "0";
				}
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strOrgCode);//0
				arrValues.add(strslno);//1
				arrValues.add(strvaluername);//2
				arrValues.add(strvalueradd1);//3
				arrValues.add(strvalueradd2);//4
				arrValues.add(strvalueradd3);//5
				arrValues.add(strvaluercity);//6
				arrValues.add(strvaluerstate);//7
				if(strAppvalue.equalsIgnoreCase("J"))
				{
					strpincode = correctNull((String)hshValues.get("txt_zip"));
				}
				else
				{
				strpincode = correctNull((String)hshValues.get("txt_zip1"));
				}
				arrValues.add(strpincode);//8
				arrValues.add(strvaluer_country);//9
				arrValues.add(strvaluer_off_phoneno);//10
				arrValues.add(strvaluer_off_faxno);//11
				arrValues.add(strvaluer_res_phoneno);//12
				arrValues.add(strvaluer_res_mobno);//13
				arrValues.add(strvaluer_contper);//14
				arrValues.add(strvaluer_contper_phmobno);//15				
				arrValues.add(strvaluer_design);//16
				arrValues.add(strvaluer_email);//17
				arrValues.add(strvaluer_empaneleddt);//18
				arrValues.add(strvaluer_active);//19
				arrValues.add(strvaluer_comments);	//20
				arrValues.add(strvaluer_blacklist);//21
				arrValues.add(strvaluer_blacklistdate);//22
				arrValues.add(strAppVal);//23
				arrValues.add(strRegionalcode);//24
				//Added by Arsath on 30/07/2013 for Jewel Appraiser given by Prakash
				arrValues.add(strSancRefNo);//25
				arrValues.add(strExpdateofsanc);//26
				arrValues.add(strDetofsecdep);//27
				arrValues.add(strDateofjewelappr);//28
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_cbscustid")));
				arrValues.add(strvaluationNature);
				arrValues.add(strCateforyCode);
				arrValues.add(valloctemp);
				if(rs1!=null)
					rs1.close();
				rs1 = DBUtils.executeLAPSQuery("sel_valuerseqno");				
				if(rs1.next())
				{	
					strSeqno=Helper.correctInt(rs1.getString("MAXID"));
				}
				
				arrValues.add(strSeqno);
				//End
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_valuermaster");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				
				int intSize=1;
				if(strAppvalue.equalsIgnoreCase("J"))
				{
					if(hshValues.get("hidarea") instanceof String[])
					{
						  txt_Branchcode = (String[])hshValues.get("hidarea");
						  strExpiry = (String[])hshValues.get("txt_Jexpdateofsanc");
						  for(int i=0;i<txt_Branchcode.length;i++)
						  {
							  intSize++;
							  arrValues=new ArrayList();
							  hshQuery = new HashMap();
							  hshQuery.put("strQueryId","ins_valuer_orgdetails");
							  arrValues.add(txt_Branchcode[i]);
							  arrValues.add(strSeqno);
							  arrValues.add(strExpiry[i]);
							  arrValues.add(strAppvalue);
							  hshQuery.put("arrValues", arrValues);
							  hshQueryValues.put(String.valueOf(intSize), hshQuery);
						  }
					}
					else
					{
						  intSize++;
						  arrValues=new ArrayList();
						  hshQuery = new HashMap();
						  hshQuery.put("strQueryId","ins_valuer_orgdetails");
						  arrValues.add(Helper.correctNull((String)hshValues.get("hidarea")));
						  arrValues.add(strSeqno);
						  arrValues.add(Helper.correctNull((String)hshValues.get("txt_Jexpdateofsanc")));
						  arrValues.add(strAppvalue);
						  hshQuery.put("arrValues", arrValues);
						  hshQueryValues.put(String.valueOf(intSize), hshQuery);
					}
				}
				
				hshQueryValues.put("size",String.valueOf(intSize));
				
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}			
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strOrgCode);
				arrValues.add(strslno);
				arrValues.add(strvaluername);
				arrValues.add(strvalueradd1);
				arrValues.add(strvalueradd2);
				arrValues.add(strvalueradd3);
				arrValues.add(strvaluercity);
				arrValues.add(strvaluerstate);
				arrValues.add(strpincode);
				arrValues.add(strvaluer_country);
				arrValues.add(strvaluer_off_phoneno);
				arrValues.add(strvaluer_off_faxno);
				arrValues.add(strvaluer_res_phoneno);
				arrValues.add(strvaluer_res_mobno);
				arrValues.add(strvaluer_contper);
				arrValues.add(strvaluer_contper_phmobno);
				
				arrValues.add(strvaluer_design);
				arrValues.add(strvaluer_email);
				arrValues.add(strvaluer_empaneleddt);
				arrValues.add(strvaluer_active);
				arrValues.add(strvaluer_comments);
				arrValues.add(strvaluer_blacklist);
				arrValues.add(strvaluer_blacklistdate);
				//Added by Arsath on 30/07/2013 for Jewel Appraiser given by Prakash
				arrValues.add(strSancRefNo);
				arrValues.add(strExpdateofsanc);
				arrValues.add(strDetofsecdep);
				arrValues.add(strDateofjewelappr);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_cbscustid")));
				arrValues.add(strvaluationNature);
				arrValues.add(strCateforyCode);
				arrValues.add(valloctemp);
				//End
				//arrValues.add(strExOrgCode);
				arrValues.add(strSeqno);
				//arrValues.add(strAppVal);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upd_valuermaster");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				
				int intSize=1;
				if(strAppvalue.equalsIgnoreCase("J"))
				{
					  intSize++;
					  arrValues=new ArrayList();
					  hshQuery = new HashMap();
					  hshQuery.put("strQueryId","del_valuer_orgdetails");
					  arrValues.add(strSeqno);
					  hshQuery.put("arrValues", arrValues);
					  hshQueryValues.put(String.valueOf(intSize), hshQuery);
					  
					if(hshValues.get("hidarea") instanceof String[])
					{
						  txt_Branchcode = (String[])hshValues.get("hidarea");
						  strExpiry = (String[])hshValues.get("txt_Jexpdateofsanc");
						  for(int i=0;i<txt_Branchcode.length;i++)
						  {
							  intSize++;
							  arrValues=new ArrayList();
							  hshQuery = new HashMap();
							  hshQuery.put("strQueryId","ins_valuer_orgdetails");
							  arrValues.add(txt_Branchcode[i]);
							  arrValues.add(strSeqno);
							  arrValues.add(strExpiry[i]);
							  arrValues.add(strAppvalue);
							  hshQuery.put("arrValues", arrValues);
							  hshQueryValues.put(String.valueOf(intSize), hshQuery);
						  }
					}
					else
					{
						  intSize++;
						  arrValues=new ArrayList();
						  hshQuery = new HashMap();
						  hshQuery.put("strQueryId","ins_valuer_orgdetails");
						  arrValues.add(Helper.correctNull((String)hshValues.get("hidarea")));
						  arrValues.add(strSeqno);
						  arrValues.add(Helper.correctNull((String)hshValues.get("txt_Jexpdateofsanc")));
						  arrValues.add(strAppvalue);
						  hshQuery.put("arrValues", arrValues);
						  hshQueryValues.put(String.valueOf(intSize), hshQuery);
					}
				}
				
				hshQueryValues.put("size",String.valueOf(intSize));
				
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}		
			   
			StringBuilder sbAuditTrial=new StringBuilder();
			sbAuditTrial.append((strAppVal.equals("V"))?"Valuer Details = Yes":"Appraiser Details=Yes").append("~Appraiser /Valuer Name =").append(correctNull((String )hshValues.get("txt_name"))).append("~Contact Person Name  =").append(correctNull((String )hshValues.get("txt_contactperson")))
			.append("~Appraiser /Valuer Address  =").append(correctNull((String )hshValues.get("txt_address1"))).append(" "+correctNull((String )hshValues.get("txt_address2")))
			.append(" "+correctNull((String )hshValues.get("txt_address3"))).append("~Contact Person Mobile /Phone No. =").append(correctNull((String )hshValues.get("txt_contactmobilephone")))
			.append("~Contact Person's Designation  =").append(correctNull((String )hshValues.get("txt_desig1"))).append("~City  =").append(correctNull((String )hshValues.get("txt_city")))
			.append("~"+ApplicationParams.getZipName()+" =").append(correctNull((String )hshValues.get("txt_zip"))).append("~State  =").append(correctNull((String )hshValues.get("txt_state")))
			.append("~Country  =").append(correctNull((String )hshValues.get("txt_country"))).append("~Empanelled on  =").append(correctNull((String )hshValues.get("txt_empaneledon")))
			.append("~Residential Phone No.  =").append(correctNull((String )hshValues.get("txt_resphone"))).append("~Mobile No.  =").append(correctNull((String )hshValues.get("txt_resmobileno")))
			.append("~Office Phone No.  =").append(correctNull((String )hshValues.get("txt_offphone"))).append("~Office Fax No.  =").append(correctNull((String )hshValues.get("txt_offfaxno")))
			.append("~Action  =").append(correctNull(SetupParams.getSetupParams("MasterAction",(String)hshValues.get("txt_action")))).append("~Email Id =").append(correctNull((String )hshValues.get("txt_emailid")))
			.append("~If he is Black Listed  =").append(SetupParams.getSetupParams("SacrificeLimit",(String)hshValues.get("sel_blacklist")));
			
			if(((String)hshValues.get("sel_blacklist")).equals("Y"))
			{	
				sbAuditTrial.append("~Black Listed Date =").append(correctNull((String )hshValues.get("txt_blacklistdate")));
			}
			AuditTrial.auditNewLog(hshValues,"135",strslno,sbAuditTrial.toString(),strOldAudit.toString());
		}
		catch (Exception ce)
		{
			throw new EJBException(ce.toString());
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
	}
	
	public void updateBSADSAmasterData(HashMap hshValues)
	{		 
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();	 
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		ResultSet rs1 = null;
		String strOrgCode=""; 
	 	String strAction = null;		 
		String strslno = "",strSeqno="";
		
		String strAppvalue = "";
		String strQuery="",strExp="$",strsno="",strCBSID="";
		
		strOrgCode=Helper.correctNull((String)hshValues.get("org_code"));
		strsno=Helper.correctNull((String)hshValues.get("hidseqno"));
		strAppvalue=correctNull((String) hshValues.get("hidAppVal"));	
		strCBSID=Helper.correctNull((String)hshValues.get("txt_cbscustid"));
		String[] txt_regno;
		String txt_regnoappend="";
		String[] txt_bankname;
		String txt_banknameappend="";
		String[] txt_bankcode;
		String txt_bankcodeappend="";
		String[] txt_dsaservbankcode;
		String txt_dsaservbankcodeappend="";
		String[] txt_dsaservbankname;
		String txt_dsaservbanknameappend="";
		String[] txt_empsincedate;
		String txt_empsincedateappend="";
		try
		{
			strSeqno=correctNull((String) hshValues.get("hidAgentID"));
			
			strOrgCode = correctNull((String)hshValues.get("org_code"));
			strAction = correctNull((String)hshValues.get("hid_action"));
			strslno	= correctNull((String )hshValues.get("hidsno"));
			hshValues.put("strAction", strAction);
			if(hshValues.get("txt_regno") instanceof String[])
			{
					txt_regno = (String[])hshValues.get("txt_regno");
				  for(int i=0;i<txt_regno.length;i++)
				  {
					  if(!txt_regno[i].equals(""))
					  txt_regnoappend=txt_regnoappend+"@"+txt_regno[i];
				  }
				  txt_regnoappend=txt_regnoappend.replaceFirst("@","");
			}
			else
			{
				txt_regnoappend=Helper.correctNull((String) hshValues.get("txt_regno"));
			}
			//bank code
			if(hshValues.get("hid_empnameBankcode") instanceof String[])
			{
					txt_bankcode = (String[])hshValues.get("hid_empnameBankcode");
					txt_empsincedate = (String[])hshValues.get("txt_empanelsince");
				for(int i=0;i<txt_bankcode.length;i++)
				  {
					  if(!txt_bankcode[i].equals(""))
					  {
						  txt_bankcodeappend=txt_bankcodeappend+"@"+txt_bankcode[i];
						  txt_empsincedateappend=txt_empsincedateappend+"@"+txt_empsincedate[i];
					  }
				  }
				  txt_bankcodeappend=txt_bankcodeappend.replaceFirst("@","");
				  txt_empsincedateappend=txt_empsincedateappend.replaceFirst("@","");
			}
			else
			{
				txt_bankcodeappend=Helper.correctNull((String) hshValues.get("hid_empnameBankcode"));
				txt_empsincedateappend=Helper.correctNull((String) hshValues.get("txt_empanelsince"));
			}
			if(hshValues.get("hid_dsaservBankcode") instanceof String[])
			{
				txt_dsaservbankcode = (String[])hshValues.get("hid_dsaservBankcode");
				  for(int i=0;i<txt_dsaservbankcode.length;i++)
				  {
					  if(!txt_dsaservbankcode[i].equals(""))
					  txt_dsaservbankcodeappend=txt_dsaservbankcodeappend+"@"+txt_dsaservbankcode[i];
				  }
				  txt_dsaservbankcodeappend=txt_dsaservbankcodeappend.replaceFirst("@","");
			}
			else
			{
				txt_dsaservbankcodeappend=Helper.correctNull((String) hshValues.get("hid_dsaservBankcode"));
			}
			
			//Bank name
			
			if(hshValues.get("txt_empnameBank") instanceof String[])
			{
				  txt_bankname = (String[])hshValues.get("txt_empnameBank");
				  for(int i=0;i<txt_bankname.length;i++)
				  {
					  if(!txt_bankname[i].equals(""))
						  txt_banknameappend=txt_banknameappend+"@"+txt_bankname[i];
				  }
				  txt_banknameappend=txt_banknameappend.replaceFirst("@","");
			}
			else
			{
				txt_banknameappend=Helper.correctNull((String) hshValues.get("txt_empnameBank"));
			}
			
			if(hshValues.get("txt_dsaservBank") instanceof String[])
			{
				txt_dsaservbankname = (String[])hshValues.get("txt_dsaservBank");
				  for(int i=0;i<txt_dsaservbankname.length;i++)
				  {
					  if(!txt_dsaservbankname[i].equals(""))
					  txt_dsaservbanknameappend=txt_dsaservbanknameappend+"@"+txt_dsaservbankname[i];
				  }
				  txt_dsaservbanknameappend=txt_dsaservbanknameappend.replaceFirst("@","");
			}
			else
			{
				txt_dsaservbanknameappend=Helper.correctNull((String) hshValues.get("txt_dsaservBank"));
			}
			
			
			//emp since
			/*if(hshValues.get("txt_empanelsince") instanceof String[])
			{
				txt_empsincedate = (String[])hshValues.get("txt_empanelsince");
				  for(int i=0;i<txt_empsincedate.length;i++){
					  txt_empsincedateappend=txt_empsincedateappend+"@"+txt_empsincedate[i];
				  }
				  txt_empsincedateappend=txt_empsincedateappend.replaceFirst("@","");
			}
			else
			{
				txt_empsincedateappend=Helper.correctNull((String) hshValues.get("txt_empanelsince"));
			}*/
			
			StringBuilder strOldAudit = new StringBuilder();
			if(strAction.equalsIgnoreCase("Update"))
			{
				if(rs!=null)
				{
					rs.close();
				}
				rs = DBUtils.executeLAPSQuery("sel_BSADSAmaster_id^"+strSeqno);
				if(rs.next()){
					if(strAppvalue.equals("BSA"))
					{
						strOldAudit.append("Business Sourcing Agents");
					}
					else if(strAppvalue.equals("DSA"))
					{
						strOldAudit.append("Direct Selling Agents");
					}
					else
					{
						strOldAudit.append("Others");
					}
					strOldAudit.append("~BSA / DSA  Name = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("BSADSA_NAME")));
					strOldAudit.append("~BSA / DSA  Address = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("BSADSA_ADDRESS1"))+ " "+Helper.correctNull((String)rs.getString("BSADSA_ADDRESS2")));
					strOldAudit.append("~ City   = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BSADSA_CITY")));
					strOldAudit.append("~ State  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BSADSA_STATE")));
					strOldAudit.append("~ Country  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BSADSA_COUNTRY")));
					strOldAudit.append("~ PINCODE  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BSADSA_PINCODE")));
					strOldAudit.append("~ CONSTITUTION  = ");	
					if(rs1 != null)
						rs1.close();					
					strQuery = SQLParser.getSqlQuery("selconstitutiondesc^"+Helper.correctNull((String)rs.getString("BSADSA_CONSTITUTION")));
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						strOldAudit.append(correctNull(rs1.getString("cbs_static_data_desc")));
					}
					
					strOldAudit.append("~ NONINDVNAME  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BSADSA_NONINDVNAME")));
					strOldAudit.append("~ MOBILENON  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BSADSA_MOBILENON")));
					strOldAudit.append("~ TELEPHONENO  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BSADSA_TELEPHONENO")));
					strOldAudit.append("~ EMAILID  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BSADSA_EMAILID")));
					strOldAudit.append("~ PAN  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BSADSA_PAN")));
					strOldAudit.append("~ KEY PERSON  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BSADSA_KEYPERSON")));
					strOldAudit.append("~ Designation of Key Person  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BSADSA_DESIGN_KEYPERSON")));
					strOldAudit.append("~ Bank Type   = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BSADSA_ACCTYPE")).equals("S")?"Savings":"Current");
					strOldAudit.append("~ Name of the Bank = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BSADSA_BANKNAME")));
					strOldAudit.append("~ Bank Branch = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BSADSA_BANKBRANCH")));
					strOldAudit.append("~ IFSC code   = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BSADSA_IFSC")));
					strOldAudit.append("~ Bank Account number   = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BSADSA_ACCNO")));
					strOldAudit.append("~ Empanelment details   = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BSADSA_EMPANEL_DET")));
					strOldAudit.append("~ Empanelment Date   = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BSADSA_EMPANEL_DATE")));
					strOldAudit.append("~ Empanelment since  = ");	
					strOldAudit.append( Helper.correctNull((String)rs.getString("BSADSA_EMPANEL_SINCE")).replace("@",","));
					strOldAudit.append("~ Expiry Date   = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BSADSA_EXPIRY_DATE")));
					strOldAudit.append("~ ACTION  = ");	
					if(Helper.correctNull((String)rs.getString("BSADSA_ACTION")).equals("E"))
						strOldAudit.append("Enabled");
					else	
						strOldAudit.append("Disabled");
					strOldAudit.append("~ Reference Name   = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BSA_REF_NAME")));
					strOldAudit.append("~ DOB  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BSA_DOB")));
					strOldAudit.append("~ RERA Registration Number = ");	
					strOldAudit.append( (Helper.correctNull((String)rs.getString("BSA_RERA_REGNO")).replace("@",",")));
					strOldAudit.append("~ Whether empanelled   = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BSA_WHTEMP")));
					strOldAudit.append("~ Name of the Bank  = ");	
					String bankname="";
					if(!correctNull(rs.getString("BSA_EMP_BANKNAME")).equals(""))
					{
						String[] bankcode=(Helper.correctNull(rs.getString("BSA_EMP_BANKNAME"))).split("@");
						for(int i=0;i<bankcode.length;i++)
						{
							if(rs1 != null)
								rs1.close();					
							strQuery = SQLParser.getSqlQuery("sel_banknamemaster^"+bankcode[i]);
							rs1 = DBUtils.executeQuery(strQuery);
							while(rs1.next())
							{
								bankname=bankname+","+(correctNull(rs1.getString("staticbankname")));
							}
						}
					}
					strOldAudit.append(bankname.replaceFirst(",",""));
					strOldAudit.append("~ Presently providing DSA services = ");	
					String dsaservbankname="";
					if(!correctNull(rs.getString("DSA_SERVICE_BANK")).equals(""))
					{
						
						String[] bankcode=(Helper.correctNull(rs.getString("DSA_SERVICE_BANK"))).split("@");
						for(int i=0;i<bankcode.length;i++)
						{
							if(rs1 != null)
								rs1.close();					
							strQuery = SQLParser.getSqlQuery("sel_banknamemaster^"+bankcode[i]);
							rs1 = DBUtils.executeQuery(strQuery);
							while(rs1.next())
							{
								dsaservbankname=dsaservbankname+","+(correctNull(rs1.getString("staticbankname")));
							}
						}
					}
					strOldAudit.append(dsaservbankname.replaceFirst(",",""));
					strOldAudit.append("~ Past experience   = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("DSA_PAST_EXP")));
					strOldAudit.append("~ Office Premises   = ");	
					strOldAudit.append(!Helper.correctNull((String)rs.getString("DSA_OFFICE_PREMISES")).equals("")?(Helper.correctNull((String)rs.getString("DSA_OFFICE_PREMISES")).equals("O")?"Owned":"Rented"):" ");
					strOldAudit.append("~ Registration under statutory = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("DSA_REG_STATUTORY")));
					strOldAudit.append("~ Region Scode = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bsadsa_scode")));
					strOldAudit.append("~ Type  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bsadsa_othtype")));
					strOldAudit.append("~Authorised Dealership Registration Number  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bsadsa_dealershipno")));
					strOldAudit.append("~Registration Valid from  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bsadsa_regnovalidfrom")));
					strOldAudit.append("~Registration Valid upto  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bsadsa_regnovalidto")));
					strOldAudit.append("~TEXT FIELD1  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bsadsa_textfield1")));
					strOldAudit.append("~TEXT FIELD1 VALUE  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bsadsa_textfieldval1")));
					strOldAudit.append("~TEXT FIELD2  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bsadsa_textfield2")));
					strOldAudit.append("~TEXT FIELD2 VALUE  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bsadsa_textfieldval2")));
					strOldAudit.append("~TEXT FIELD3  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bsadsa_textfield3")));
					strOldAudit.append("~TEXT FIELD3 VALUE  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bsadsa_textfieldval3")));
					strOldAudit.append("~TEXT FIELD4  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bsadsa_textfield4")));
					strOldAudit.append("~TEXT FIELD4 VALUE  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bsadsa_textfieldval4")));
					strOldAudit.append("~TEXT FIELD5  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bsadsa_textfield5")));
					strOldAudit.append("~TEXT FIELD5 VALUE  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bsadsa_textfieldval5")));
					strOldAudit.append("~MASTER FIELD1  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bsadsa_masterfield1")));
					strOldAudit.append("~MASTER FIELD1 VALUE  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bsadsa_masterfieldval1")));
					strOldAudit.append("~MASTER FIELD2  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bsadsa_masterfield2")));
					strOldAudit.append("~MASTER FIELD2 VALUE  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bsadsa_masterfieldval2")));
					strOldAudit.append("~MASTER FIELD3  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bsadsa_masterfield3")));
					strOldAudit.append("~MASTER FIELD3 VALUE  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bsadsa_masterfieldval3")));
					strOldAudit.append("~MASTER FIELD4  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bsadsa_masterfield4")));
					strOldAudit.append("~MASTER FIELD4 VALUE  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bsadsa_masterfieldval4")));
					strOldAudit.append("~MASTER FIELD5  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bsadsa_masterfield5")));
					strOldAudit.append("~MASTER FIELD5 VALUE  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bsadsa_masterfieldval5")));
				}
			}
			
			
			if (strAction.equalsIgnoreCase("insert"))
			{
				rs1 = DBUtils.executeLAPSQuery("getmaxBSADSAmasterno");				
				while(rs1.next())
				{	
					strslno = rs1.getString("maxno");
				}
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppvalue);//0
				arrValues.add(strslno);//1
				arrValues.add(strAppvalue.concat(strslno));
				//arrValues.add("Y");
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_name")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_address1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_address2")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidcity")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidstate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidperapp_country")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_zip")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_applt_constitutionnew")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_nonindname")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_mobile")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_telephone")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_email")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_pannum")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_keyperson")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_designkeyperson")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_banktype")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_LeadBankcode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_branch")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_ifsccode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_accno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_empaneldet")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_empaneledon")));
				arrValues.add(txt_empsincedateappend);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_expirydate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_action")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_reference")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_dob")));
				arrValues.add(txt_regnoappend);
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_whtempanalled")));
				arrValues.add(txt_bankcodeappend);
				arrValues.add(txt_dsaservbankcodeappend);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_pastexp")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_officepremises")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_regis")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_referenceno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_region")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_type")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_dealershipregno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_regdatefrom")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_regdateto")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield2")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield3")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield4")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield5")));
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield2")));
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield3")));
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield4")));
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield5")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfieldval1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfieldval2")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfieldval3")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfieldval4")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfieldval5")));
				arrValues.add(Helper.correctNull((String)hshValues.get("selmasterfield1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("selmasterfield2")));
				arrValues.add(Helper.correctNull((String)hshValues.get("selmasterfield3")));
				arrValues.add(Helper.correctNull((String)hshValues.get("selmasterfield4")));
				arrValues.add(Helper.correctNull((String)hshValues.get("selmasterfield5")));
				arrValues.add("");
				//End
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_BSADSA_master");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}			
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				//arrValues.add("Y");
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_name")));//0
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_address1")));//1
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_address2")));//2
				arrValues.add(Helper.correctNull((String)hshValues.get("hidcity")));//3
				arrValues.add(Helper.correctNull((String)hshValues.get("hidstate")));//4
				arrValues.add(Helper.correctNull((String)hshValues.get("hidperapp_country")));//5
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_zip")));//6
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_applt_constitutionnew")));//7
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_nonindname")));//8
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_mobile")));//9
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_telephone")));//10
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_email")));//11
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_pannum")));//12
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_keyperson")));//13
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_designkeyperson")));//14
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_banktype")));//15
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_LeadBankcode")));//16
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_branch")));//17
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_ifsccode")));//18
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_accno")));//19
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_empaneldet")));//20
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_empaneledon")));//21
				arrValues.add(txt_empsincedateappend);///22
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_expirydate")));//23
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_action")));//24
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_reference")));//25
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_dob")));//
				arrValues.add(txt_regnoappend);
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_whtempanalled")));
				arrValues.add(txt_bankcodeappend);
				arrValues.add(txt_dsaservbankcodeappend);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_pastexp")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_officepremises")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_regis")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_referenceno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_region")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_type")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_dealershipregno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_regdatefrom")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_regdateto")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield2")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield3")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield4")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield5")));
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield2")));
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield3")));
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield4")));
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield5")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfieldval1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfieldval2")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfieldval3")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfieldval4")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfieldval5")));
				arrValues.add(Helper.correctNull((String)hshValues.get("selmasterfield1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("selmasterfield2")));
				arrValues.add(Helper.correctNull((String)hshValues.get("selmasterfield3")));
				arrValues.add(Helper.correctNull((String)hshValues.get("selmasterfield4")));
				arrValues.add(Helper.correctNull((String)hshValues.get("selmasterfield5")));
				arrValues.add("");
				arrValues.add(strSeqno);

				//End
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upd_BSADSA_master");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
			
			if(strAction.equalsIgnoreCase("insert")||strAction.equalsIgnoreCase("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield2")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield3")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield4")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield5")));
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield2")));
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield3")));
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield4")));
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield5")));
				arrValues.add(strAppvalue);
				//End
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upd_masterdynamicfields");
				if(strAppvalue.equalsIgnoreCase("OTH"))
				hshQuery.put("strAppendString"," and bsadsa_othtype='"+Helper.correctNull((String)hshValues.get("sel_type"))+"'");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			
			String auditconstitution="";
			if(rs1 != null)
				rs1.close();					
			strQuery = SQLParser.getSqlQuery("selconstitutiondesc^"+correctNull((String)hshValues.get("sel_applt_constitutionnew")));
			rs1 = DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				auditconstitution=correctNull(rs1.getString("cbs_static_data_desc"));
			}
			
			StringBuilder sbAuditTrial=new StringBuilder();
			sbAuditTrial.append(
				 (strAppvalue.equals("BSA"))?"Business Sourcing Agents = Yes":"Direct Selling Agents Master=Yes")
				.append("~BSA / DSA  Name = ").append(correctNull((String)hshValues.get("txt_name")))
				.append("~BSA / DSA  Address = ").append(correctNull((String)hshValues.get("txt_address1")))
				.append("~ City  = ").append(correctNull((String)hshValues.get("txt_city")))
				.append("~ State  = ").append(correctNull((String)hshValues.get("txt_state")))
				.append("~ Country = ").append(correctNull((String)hshValues.get("txt_country")))
				.append("~ PINCODE = ").append(correctNull((String)hshValues.get("txt_zip")))
				.append("~ CONSTITUTION = ").append(auditconstitution)
				.append("~ NONINDVNAME = ").append(correctNull((String)hshValues.get("txt_nonindname")))
				.append("~ MOBILENON = ").append(correctNull((String)hshValues.get("txt_mobile")))
				.append("~ TELEPHONENO = ").append(correctNull((String)hshValues.get("txt_telephone")))
				.append("~ EMAILID  = ").append(correctNull((String)hshValues.get("txt_email")))
				.append("~ PAN  = ").append(correctNull((String)hshValues.get("txt_pannum")))
				.append("~ KEY PERSON = ").append(correctNull((String)hshValues.get("txt_keyperson")))
				.append("~ Designation of Key Person = ").append(correctNull((String)hshValues.get("txt_designkeyperson")))
				.append("~ Bank Type = ")	.append(correctNull((String)hshValues.get("sel_banktype")))
				.append("~ Name of the Bank = ").append(correctNull((String)hshValues.get("txt_bankname")))
				.append("~ Bank Branch = ").append(correctNull((String)hshValues.get("txt_branch")))
				.append("~ IFSC code = ").append(correctNull((String)hshValues.get("txt_ifsccode")))
				.append("~ Bank Account number = ").append(correctNull((String)hshValues.get("txt_accno")))
				.append("~ Empanelment details = ").append(correctNull((String)hshValues.get("txt_empaneldet")))
				.append("~ Empanelment Date = ").append(correctNull((String)hshValues.get("txt_empaneledon")))
				.append("~ Empanelment since = ").append(txt_empsincedateappend.replace("@",","))
				.append("~ Expiry Date = ").append(correctNull((String)hshValues.get("txt_expirydate")))
				.append("~ ACTION = ").append(!correctNull((String)hshValues.get("sel_action")).equals("")?(correctNull((String)hshValues.get("sel_action")).equals("E")?"Enabled":"Disabled"):" ")
				.append("~ Reference Name = ").append(correctNull((String)hshValues.get("txt_reference")))
				.append("~ DOB  = ").append(correctNull((String)hshValues.get("txt_dob")))
				.append("~ RERA Registration Number = ").append(txt_regnoappend.replace("@",","))	
				.append("~ Whether empanelled = ").append(correctNull((String)hshValues.get("sel_whtempanalled")))
				.append("~ Name of the Bank  = ").append(txt_banknameappend.replace("@",","))	
				.append("~ Presently providing DSA services = ").append(txt_dsaservbanknameappend.replace("@",","))		
				.append("~ Past experience = ").append(correctNull((String)hshValues.get("txt_pastexp")))
				.append("~ Office Premises = ").append(!correctNull((String)hshValues.get("sel_officepremises")).equals("")?(correctNull((String)hshValues.get("sel_officepremises")).equals("O")?"Owned":"Rented"):" ")
				.append("~ Registration under statutory = ").append(correctNull((String)hshValues.get("txt_regis")));
			
			AuditTrial.auditNewLog(hshValues,"431",strSeqno,sbAuditTrial.toString(),strOldAudit.toString());
		}
		catch (Exception ce)
		{
			throw new EJBException(ce.toString());
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
	}
	
	
	
	public HashMap getValuerMasterList(HashMap hshValues) 
	{
		String strQuery = "",scode = "",svalue = "";
 		ResultSet rs = null;
 		ResultSet rs1 = null;
 		HashMap hshRecord = new HashMap();
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();
		String strOrgCode ="",strCode="",strCBSID="",strExp="";
		strCBSID=Helper.correctNull((String)hshValues.get("hidCBSID"));
		String strAction = null;
		String strAppVal="";
		String strRegionalcode="";
		String strOrgLevel="",strSecValue="";
		String strAppraiser = Helper.correctNull((String)hshValues.get("appraiser"));
		StringBuffer strOrgNames=new StringBuffer();
		StringBuffer strOrgCodes=new StringBuffer();
		StringBuffer strExpiry=new StringBuffer();
		try
		{
			scode=correctNull((String)hshValues.get("stype"));
			svalue=correctNull((String)hshValues.get("svalue"));
			strAction   = correctNull((String)hshValues.get("hidAction"));
			String strsno	= correctNull((String )hshValues.get("hidseqno"));
			strOrgCode = correctNull((String) hshValues.get("strOrgCode"));
			strOrgLevel = correctNull((String) hshValues.get("strOrgLevel"));
			strSecValue = Helper.correctDouble((String) hshValues.get("strSecValue"));
			strRegionalcode=correctNull((String) hshValues.get("strOrgCode")).substring(0,9)+"000000";
			String strRegionalOffice=strRegionalcode;
			if(strOrgLevel.equalsIgnoreCase("C"))
			{
				strRegionalcode=strOrgCode.substring(0,3)+"%%%";
				strCode=strOrgCode.substring(0,3)+"%%%";
			}
			else if(strOrgLevel.equalsIgnoreCase("R"))
			{
				strRegionalcode=strOrgCode.substring(0,6);
				
				HashMap hshRo=new HashMap();
				hshRo.put("strRegionalOffice", strRegionalOffice);
				hshRo.put("strPage", "mastsearch");
				strRegionalOffice=(String)EJBInvoker.executeStateLess("setorg",hshRo,"getRegionalOffice");
				strRegionalcode=strRegionalOffice;
				
				strRegionalcode=strRegionalcode+"%%%";
				strCode=strOrgCode.substring(0,6)+"%%%";
			}
			else if(strOrgLevel.equalsIgnoreCase("D"))
			{
				//strRegionalcode=strOrgCode.substring(0,9)+"%%%";
				strRegionalcode=strOrgCode.substring(0,6)+"%%%";
				strCode=strOrgCode.substring(0,9)+"%%%";
			}
			else if(strOrgLevel.equalsIgnoreCase("A"))
			{
				//strRegionalcode=strOrgCode.substring(0,12)+"%%%";
				strRegionalcode=strOrgCode.substring(0,6)+"%%%";
				strCode=strOrgCode.substring(0,12)+"%%%";
			}
			else
			{
				strRegionalcode=strOrgCode.substring(0,15);
			}
			strAppVal=correctNull((String) hshValues.get("hidAppVal"));
			if((strsno.trim().equals("")))
			{
				strsno="0";
			}
			
			
			
			if(strAction.equalsIgnoreCase("update")||strAction.equalsIgnoreCase("Cancel") || strAction.equalsIgnoreCase("insert"))
			{
				
			}
			else if(strAction.equalsIgnoreCase("search"))
			{
				String strPagefrom=Helper.correctNull((String)hshValues.get("strfrom"));
				String strType=Helper.correctNull((String)hshValues.get("rad"));
				
				if(strAppraiser.equalsIgnoreCase("appraiser") || strPagefrom.equalsIgnoreCase("Securities") || strPagefrom.equalsIgnoreCase("ValuerEntry") || strAppraiser.equalsIgnoreCase("reappraiser"))
				{	
					scode=correctNull((String)hshValues.get("stype"));
					svalue=correctNull((String)hshValues.get("svalue"));
					if(scode.equals(""))
					{
						//String strTemp=" ";
						if(strAppVal.equalsIgnoreCase("V"))
							strOrgCode="001";
							//strTemp="or valuers_code='601'";
						if(strAppraiser.equalsIgnoreCase("reappraiser"))
							strOrgCode="001";
						
						if(strAppVal.equalsIgnoreCase("J"))
							strQuery = SQLParser.getSqlQuery("sel_validJappraisername^"+strOrgCode+"^"+strAppVal);
						else 
							strQuery = SQLParser.getSqlQuery("sel_validappraisername^"+strOrgCode+"^"+strAppVal);
					}				
					else if(strType.equals("Name") || scode.equals("Name"))
					{
						if(strAppVal.equalsIgnoreCase("J"))
							strQuery = SQLParser.getSqlQuery("sel_validJappraisernamewithsearchid^"+strOrgCode+"^"+svalue+"^"+strAppVal);
						else
							strQuery = SQLParser.getSqlQuery("sel_validappraisernamewithsearchid^"+strOrgCode+"^"+svalue+"^"+strAppVal);
					}			
					else if(strType.equals("CBSID"))
					{
						if(strAppVal.equalsIgnoreCase("J"))
							strQuery = SQLParser.getSqlQuery("sel_validJappraisernamewithsearchcbsid^"+strOrgCode+"^"+svalue+"^"+strAppVal);
						else
							strQuery = SQLParser.getSqlQuery("sel_validappraisernamewithsearchcbsid^"+strOrgCode+"^"+svalue+"^"+strAppVal);
					}			
					rs = DBUtils.executeQuery(strQuery);
					while(rs.next())				
					{
						vecCol = new ArrayList();
						vecCol.add(correctNull(rs.getString(1)));//0 org_code
						vecCol.add(correctNull(rs.getString(2)));//1 valuers_code
						vecCol.add(correctNull(rs.getString(3)));//2 valuers_name
						vecCol.add(correctNull(rs.getString(4)));//3 valuers_address1
						vecCol.add(correctNull(rs.getString(5)));//4 valuers_address2
						vecCol.add(correctNull(rs.getString(6)));//5 valuers_address3
						vecCol.add(correctNull(rs.getString(7)));//6 valuers_city
						vecCol.add(correctNull(rs.getString(8)));//7 valuers_state
						vecCol.add(correctNull(rs.getString(9)));//8 valuers_pincode
						vecCol.add(correctNull(rs.getString(10)));//9 valuers_country
						vecCol.add(correctNull(rs.getString(11)));//10 valuers_off_phoneno
						vecCol.add(correctNull(rs.getString(12)));//11 valuers_off_faxno
						vecCol.add(correctNull(rs.getString(13)));//12 valuers_res_phoneno
						vecCol.add(correctNull(rs.getString(14)));//13 valuers_res_mobno
						vecCol.add(correctNull(rs.getString(15)));//14 valuers_contper
						vecCol.add(correctNull(rs.getString(16)));//15 valuers_contper_phmobno
						vecCol.add(correctNull(rs.getString(17)));//16 valuers_design
						vecCol.add(correctNull(rs.getString(18)));//17 valuers_email
						vecCol.add(correctNull(rs.getString(19)));///18 valuers_empaneleddt
						vecCol.add(correctNull(rs.getString(20)));//19 valuers_active
						vecCol.add(correctNull(rs.getString(21)));//20 valuers_comments
						vecCol.add(correctNull(rs.getString(22)));//21 valuers_blacklist
						vecCol.add(correctNull(rs.getString(23)));//22 valuers_blacklistdate
						vecCol.add(correctNull(rs.getString(24)));//23 city_name
					//	vecCol.add(correctNull(rs.getString(25)));//
						vecCol.add(correctNull(rs.getString(25)));//24 state_name
						vecCol.add(correctNull(rs.getString(26)));//25 valuers_seqno
						vecCol.add(correctNull(rs.getString(27)));//26 Ref Number
						vecCol.add(correctNull(rs.getString(28)));//27 Expected Date of Sanction
						vecCol.add(correctNull(rs.getString(29)));//28 Security Deposit
						vecCol.add(correctNull(rs.getString(30)));//29 Jewel Appraiser Date
						vecCol.add(correctNull(rs.getString(31)));//30 
						
						String branchname="";
						if(!correctNull(rs.getString("ORG_CODE")).equals(""))
						{
							String[] bankcode=(Helper.correctNull(rs.getString("ORG_CODE"))).split("@");
							for(int i=0;i<bankcode.length;i++)
							{
								if(rs1 != null)
									rs1.close();					
								strQuery = SQLParser.getSqlQuery("repbankname^"+bankcode[i]);
								rs1 = DBUtils.executeQuery(strQuery);
								while(rs1.next())
								{
									branchname=branchname+"@"+((correctNull(rs1.getString("org_name")))+" - "+(correctNull(rs1.getString("org_scode"))));
								}
							}
						}
						vecCol.add(branchname.replaceFirst("@",""));//31
						vecCol.add(correctNull(rs.getString(32)));//32
						vecCol.add(correctNull(rs.getString(33)));//33
						vecCol.add(correctNull(rs.getString("VALUER_VALUEDLOC")));//34
						
						if(strPagefrom.equalsIgnoreCase("Securities"))
						{
							if(rs1 != null)
								rs1.close();					
							rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^205^"+correctNull(rs.getString(33)));
							if(rs1.next())
							{
								if(Double.parseDouble(strSecValue)<=Double.parseDouble(Helper.correctDouble(rs1.getString("stat_data_value"))))
								{
									vecCol.add("Y");//35
									vecCol.add(Helper.correctDouble(rs1.getString("stat_data_value")));//36
								}
								else
								{
									vecCol.add("N");//35
									vecCol.add(Helper.correctDouble(rs1.getString("stat_data_value")));//36
								}
							}
							else
							{
								vecCol.add("");//35
								vecCol.add("");//36
							}
						}
						else
						{
							vecCol.add("");//35
							vecCol.add("");//36
						}
						vecCol.add(String.valueOf(Helper.dateDiff(Helper.getCurrentDateTime(),correctNull(rs.getString("valuers_expdateofsanc")))));//37
						vecCol.add("");
						vecCol.add("");
						vecCol.add("");
						vecRow.add(vecCol);	
					}
				}
				else
				{
				scode=correctNull((String)hshValues.get("stype"));
				svalue=correctNull((String)hshValues.get("svalue"));
				if(strPagefrom.equalsIgnoreCase("ValuersMaster1"))
				{
					if(scode.equals(""))
					{
						strQuery = SQLParser.getSqlQuery("sel_valuermasterall^"+strAppVal);
					}				
					else if(strType.equalsIgnoreCase("Name"))
					{
						strQuery = SQLParser.getSqlQuery("sel_valuermastername^"+svalue+"^"+strAppVal);
					}	
					else if(strType.equalsIgnoreCase("CBSID"))
					{
						strQuery = SQLParser.getSqlQuery("sel_valuermastercbsid_search^"+svalue+"^"+strAppVal);
					}
				}
				else
				{
					if(scode.equals(""))
					{
						strQuery = SQLParser.getSqlQuery("sel_valuermasterall_search^'"+strOrgCode+"','"+strOrgCode.substring(0, 9)+"000000','"+strOrgCode.substring(0, 6)+"000000000','"+strOrgCode.substring(0, 3)+"000000000000'^"+strAppVal);
					}				
					else if(scode.equals("N"))
					{
						strQuery = SQLParser.getSqlQuery("sel_valuermastername_search^'"+strOrgCode+"','"+strOrgCode.substring(0, 9)+"000000','"+strOrgCode.substring(0, 6)+"000000000','"+strOrgCode.substring(0, 3)+"000000000000'^"+svalue+"^"+strAppVal);
					}
					
				}
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					
					
					vecCol = new ArrayList();
					vecCol.add(correctNull(rs.getString(1)));//0 org_code
					vecCol.add(correctNull(rs.getString(2)));//1 valuers_code
					vecCol.add(correctNull(rs.getString(3)));//2 valuers_name
					vecCol.add(correctNull(rs.getString(4)));//3 valuers_address1
					vecCol.add(correctNull(rs.getString(5)));//4 valuers_address2
					vecCol.add(correctNull(rs.getString(6)));//5 valuers_address3
					vecCol.add(correctNull(rs.getString(7)));//6 valuers_city
					vecCol.add(correctNull(rs.getString(8)));//7 valuers_state
					vecCol.add(correctNull(rs.getString(9)));//8 valuers_pincode
					vecCol.add(correctNull(rs.getString(10)));//9 valuers_country
					vecCol.add(correctNull(rs.getString(11)));//10 valuers_off_phoneno
					vecCol.add(correctNull(rs.getString(12)));//11 valuers_off_faxno
					vecCol.add(correctNull(rs.getString(13)));//12 valuers_res_phoneno
					vecCol.add(correctNull(rs.getString(14)));//13 valuers_res_mobno
					vecCol.add(correctNull(rs.getString(15)));//14 valuers_contper
					vecCol.add(correctNull(rs.getString(16)));//15 valuers_contper_phmobno
					vecCol.add(correctNull(rs.getString(17)));//16 valuers_design
					vecCol.add(correctNull(rs.getString(18)));//17 valuers_email
					vecCol.add(correctNull(rs.getString(19)));///18 valuers_empaneleddt
					vecCol.add(correctNull(rs.getString(20)));//19 valuers_active
					vecCol.add(correctNull(rs.getString(21)));//20 valuers_comments
					vecCol.add(correctNull(rs.getString(22)));//21 valuers_blacklist
					vecCol.add(correctNull(rs.getString(23)));//22 valuers_blacklistdate
					vecCol.add(correctNull(rs.getString(24)));//23 city_name
				//	vecCol.add(correctNull(rs.getString(25)));//
					vecCol.add(correctNull(rs.getString(25)));//24 state_name
					vecCol.add(correctNull(rs.getString(26)));//25 valuers_seqno
					vecCol.add(correctNull(rs.getString(27)));//26 Ref Number
					vecCol.add(correctNull(rs.getString(28)));//27 Expected Date of Sanction
					vecCol.add(correctNull(rs.getString(29)));//28 Security Deposit
					vecCol.add(correctNull(rs.getString(30)));//29 Jewel Appraiser Date
				
					vecCol.add(correctNull(rs.getString(31)));//30 CBS ID
						String branchname="";
						if(!correctNull(rs.getString("ORG_CODE")).equals(""))
						{
							String[] bankcode=(Helper.correctNull(rs.getString("ORG_CODE"))).split("@");
							for(int i=0;i<bankcode.length;i++)
							{
								if(rs1 != null)
									rs1.close();					
								strQuery = SQLParser.getSqlQuery("repbankname^"+bankcode[i]);
								rs1 = DBUtils.executeQuery(strQuery);
								while(rs1.next())
								{
									branchname=branchname+"@"+((correctNull(rs1.getString("org_name")))+" - "+(correctNull(rs1.getString("org_scode"))));
								}
							}
						}
					 vecCol.add(branchname.replaceFirst("@",""));//31
					vecCol.add(correctNull(rs.getString(32)));//32 Valuer nature
					vecCol.add(correctNull(rs.getString(33)));//33 Valuer code
					//vecCol.add(correctNull(rs.getString("VALUER_VALUEDLOC")));//34 Valuer location
					
					String strLoc="";
					if(!correctNull(rs.getString("VALUER_VALUEDLOC")).equals(""))
					{
						String[] strLocation=(Helper.correctNull(rs.getString("VALUER_VALUEDLOC"))).split("@");
						for(int i=0;i<strLocation.length;i++)
						{
							String[] strDet=strLocation[i].split("~");
							if(strDet.length>1)
							{
								if(rs1 != null)
									rs1.close();					
								strQuery = SQLParser.getSqlQuery("sel_districtmaster^"+strDet[1]);
								rs1 = DBUtils.executeQuery(strQuery);
								if(rs1.next())
								{
									strLoc=strLoc+strLocation[i]+"~"+(correctNull(rs1.getString("district_desc")))+"@";
								}
							}
						}
					}
					if(strLoc.equalsIgnoreCase(""))
						vecCol.add(strLoc);
					else
						vecCol.add(strLoc.substring(0, (strLoc.length()-1)));
					vecCol.add("");//35
					vecCol.add("");//36
					if(!correctNull(rs.getString("valuers_expdateofsanc")).equalsIgnoreCase(""))
					vecCol.add(String.valueOf(Helper.dateDiff(Helper.getCurrentDateTime(),correctNull(rs.getString("valuers_expdateofsanc")))));//37
					else
						vecCol.add("0");	
					
					strOrgNames=new StringBuffer();
					strOrgCodes=new StringBuffer();
					strExpiry=new StringBuffer();
					if(strAppVal.equalsIgnoreCase("J"))
					{
						if(rs1 != null)
						rs1.close();					
						strQuery = SQLParser.getSqlQuery("sel_valuer_orgdetails^"+correctNull(rs.getString(26)));
						rs1 = DBUtils.executeQuery(strQuery);
						while(rs1.next())
						{
							if(strOrgNames.length()==0)
							{
								strOrgNames.append(Helper.correctNull(rs1.getString("names")));
								strOrgCodes.append(Helper.correctNull(rs1.getString("valuer_orgcode")));
								strExpiry.append(Helper.correctNull(rs1.getString("valuer_expirydate")));
							}
							else
							{
								strOrgNames.append("~").append(Helper.correctNull(rs1.getString("names")));
								strOrgCodes.append("~").append(Helper.correctNull(rs1.getString("valuer_orgcode")));
								strExpiry.append("~").append(Helper.correctNull(rs1.getString("valuer_expirydate")));
							}
						}
					}
					vecCol.add(strOrgNames.toString());//38
					vecCol.add(strOrgCodes.toString());//39
					vecCol.add(strExpiry.toString());//40
				
					vecRow.add(vecCol);	
				}
				
			}
				hshRecord.put("vecRow",vecRow);
				hshRecord.put("svalue", svalue);
				hshRecord.put("scode", scode);
				hshRecord.put("appraiser",Helper.correctNull((String)hshValues.get("appraiser")));
				hshRecord.put("hidAppVal",Helper.correctNull((String)hshValues.get("hidAppVal")));
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getValuerMasterList "+ce.toString());
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
	
	
	public HashMap getBSADSAList(HashMap hshValues) 
	{
		String strQuery = "",scode = "",svalue = "";
 		ResultSet rs = null;
 		ResultSet rs1 = null;
 		HashMap hshRecord = new HashMap();
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();
		String strOrgCode ="",strCode="",strCBSID="",strExp="",strLeadScode="";
		strCBSID=Helper.correctNull((String)hshValues.get("hidCBSID"));
		String strAction = null;
		String strAppVal="";
		String strRegionalcode="";
		String strOrgLevel="";
		ArrayList arrCol		= new ArrayList();
		ArrayList arrRow		= new ArrayList();
		try
		{
			scode=correctNull((String)hshValues.get("stype"));
			svalue=correctNull((String)hshValues.get("svalue"));
			strAction   = correctNull((String)hshValues.get("hidAction"));
			String strsno	= correctNull((String )hshValues.get("hidseqno"));
			strOrgCode = correctNull((String) hshValues.get("strOrgCode"));
			strOrgLevel = correctNull((String) hshValues.get("strOrgLevel"));
			strRegionalcode=correctNull((String) hshValues.get("strOrgCode")).substring(0,9)+"000000";
			
			strAppVal=correctNull((String) hshValues.get("hidAppVal"));
			if((strsno.trim().equals("")))
			{
				strsno="0";
			}

			if(strAction.equalsIgnoreCase("search"))
			{
				String strPagefrom=Helper.correctNull((String)hshValues.get("strfrom"));
				String strType=Helper.correctNull((String)hshValues.get("rad"));
				scode=correctNull((String)hshValues.get("stype"));
				svalue=correctNull((String)hshValues.get("svalue"));
				strLeadScode=correctNull((String)hshValues.get("strScode"));
				String desc=" ";
				if(strPagefrom.equalsIgnoreCase("BSADSAmaster") || strPagefrom.equalsIgnoreCase("LAR"))
				{
					if(strPagefrom.equalsIgnoreCase("LAR"))
					{
						if(!strLeadScode.equalsIgnoreCase("") && !strLeadScode.equalsIgnoreCase("All"))
							desc=" and BSADSA_ACTION='E' and BSADSA_SCODE='"+strLeadScode+"'";
						else
							desc=" and BSADSA_ACTION='E'";
						
						if(!(strAppVal.equalsIgnoreCase("BSA")||strAppVal.equalsIgnoreCase("DSA")))
						{
							desc=desc+"and bsadsa_othtype='"+strAppVal+"'";
							strAppVal="OTH";
							
						}
					}
					else
					{
						if(!(strAppVal.equalsIgnoreCase("BSA")||strAppVal.equalsIgnoreCase("DSA")))
						{
							desc=desc+"and bsadsa_othtype='"+Helper.correctNull((String)hshValues.get("strType"))+"'";
							
						}
					}
					
					if(scode.equals(""))
					{
						strQuery = SQLParser.getSqlQuery("sel_BSADSAmasterall^"+strAppVal+"^"+desc);
					}				
					else
					{
						strQuery = SQLParser.getSqlQuery("sel_BSADSAmaster_name^"+svalue+"^"+strAppVal+"^"+desc);
					}	
				}
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					vecCol = new ArrayList();
					vecCol.add(correctNull(rs.getString("BSADSA_TYPE")));
					vecCol.add(correctNull(rs.getString("BSADSA_ID")));//1 
					vecCol.add(correctNull(rs.getString("BSADSA_NAME")));//2 
					vecCol.add(correctNull(rs.getString("BSADSA_ADDRESS1")));//3 
					vecCol.add(correctNull(rs.getString("BSADSA_ADDRESS2")));//4 
					vecCol.add(correctNull(rs.getString("city_name")));//5
					vecCol.add(correctNull(rs.getString("state_name")));//6
					vecCol.add(correctNull(rs.getString("CON_COUNTRY")));//7 
					vecCol.add(correctNull(rs.getString("BSADSA_PINCODE")));//8 
					vecCol.add(correctNull(rs.getString("BSADSA_CONSTITUTION")));//9 
					vecCol.add(correctNull(rs.getString("BSADSA_NONINDVNAME")));//10 
					vecCol.add(correctNull(rs.getString("BSADSA_MOBILENON")));//11 
					vecCol.add(correctNull(rs.getString("BSADSA_TELEPHONENO")));//12 
					vecCol.add(correctNull(rs.getString("BSADSA_EMAILID")));//13 
					vecCol.add(correctNull(rs.getString("BSADSA_PAN")));//14 
					vecCol.add(correctNull(rs.getString("BSADSA_KEYPERSON")));//15 
					vecCol.add(correctNull(rs.getString("BSADSA_DESIGN_KEYPERSON")));//16 
					vecCol.add(correctNull(rs.getString("BSADSA_ACCTYPE")));///17 
					if(!correctNull(rs.getString("BSADSA_BANKNAME")).equals(""))
					{
						if(rs1 != null)
							rs1.close();					
						strQuery = SQLParser.getSqlQuery("sel_banknamemaster^"+Helper.correctInt(rs.getString("BSADSA_BANKNAME")));
						rs1 = DBUtils.executeQuery(strQuery);
						while(rs1.next())
						{
							vecCol.add(correctNull(rs1.getString("staticbankname")));//18 
						}
					}
					else
					{
						vecCol.add("");
					}
					
					vecCol.add(correctNull(rs.getString("BSADSA_BANKBRANCH")));//19 
					vecCol.add(correctNull(rs.getString("BSADSA_IFSC")));//20
					vecCol.add(correctNull(rs.getString("BSADSA_ACCNO")));//21
					vecCol.add(correctNull(rs.getString("BSADSA_EMPANEL_DET")));//22
					vecCol.add(correctNull(rs.getString("BSADSA_EMPANEL_DATE")));//23 
					vecCol.add(correctNull(rs.getString("BSADSA_EMPANEL_SINCE")));//24 
					vecCol.add(correctNull(rs.getString("BSADSA_EXPIRY_DATE")));//25  
					vecCol.add(correctNull(rs.getString("BSADSA_ACTION")));//26 
					vecCol.add(correctNull(rs.getString("BSA_REF_NAME")));//27  
					vecCol.add(correctNull(rs.getString("BSA_DOB")));//28   
					vecCol.add(correctNull(rs.getString("BSA_WHTEMP")));//29
					vecCol.add(correctNull(rs.getString("DSA_PAST_EXP")));//30
					vecCol.add(correctNull(rs.getString("DSA_OFFICE_PREMISES")));//31 
					vecCol.add(correctNull(rs.getString("DSA_REG_STATUTORY")));//32
					String bankname="";
					if(!correctNull(rs.getString("BSA_EMP_BANKNAME")).equals(""))
					{
						
						String[] bankcode=(Helper.correctNull(rs.getString("BSA_EMP_BANKNAME"))).split("@");
						for(int i=0;i<bankcode.length;i++)
						{
							if(rs1 != null)
								rs1.close();					
							strQuery = SQLParser.getSqlQuery("sel_banknamemaster^"+bankcode[i]);
							rs1 = DBUtils.executeQuery(strQuery);
							while(rs1.next())
							{
								bankname=bankname+"@"+(correctNull(rs1.getString("staticbankname")));
							}
						}
					}
					vecCol.add(bankname.replaceFirst("@",""));//33 
					String dsaservbankname="";
					if(!correctNull(rs.getString("DSA_SERVICE_BANK")).equals(""))
					{
						
						String[] bankcode=(Helper.correctNull(rs.getString("DSA_SERVICE_BANK"))).split("@");
						for(int i=0;i<bankcode.length;i++)
						{
							if(rs1 != null)
								rs1.close();					
							strQuery = SQLParser.getSqlQuery("sel_banknamemaster^"+bankcode[i]);
							rs1 = DBUtils.executeQuery(strQuery);
							while(rs1.next())
							{
								dsaservbankname=dsaservbankname+"@"+(correctNull(rs1.getString("staticbankname")));
							}
						}
					}
					vecCol.add(dsaservbankname.replaceFirst("@",""));//34 
					vecCol.add(correctNull(rs.getString("BSA_RERA_REGNO")));//35
					vecCol.add(correctNull(rs.getString("BSA_EMP_BANKNAME")));//36 bankcode
					vecCol.add(correctNull(rs.getString("DSA_SERVICE_BANK")));//37  dsaservicebankcode
					vecCol.add(correctNull(rs.getString("bsa_ref_contactno")));//38
					vecCol.add(correctNull(rs.getString("BSADSA_CITY")));//39
					vecCol.add(correctNull(rs.getString("BSADSA_STATE")));//40 
					vecCol.add(correctNull(rs.getString("BSADSA_COUNTRY")));//41 
					vecCol.add(correctNull(rs.getString("BSADSA_BANKNAME")));//42 
					vecCol.add(correctNull(rs.getString("bsadsa_scode")));//43
					vecCol.add(correctNull(rs.getString("bsadsa_othtype")));//44
					vecCol.add(correctNull(rs.getString("bsadsa_dealershipno")));//45
					vecCol.add(correctNull(rs.getString("bsadsa_regnovalidfrom")));//46
					vecCol.add(correctNull(rs.getString("bsadsa_regnovalidto")));//47
					vecCol.add(correctNull(rs.getString("bsadsa_textfield1")));//48
					vecCol.add(correctNull(rs.getString("bsadsa_textfield2")));//49
					vecCol.add(correctNull(rs.getString("bsadsa_textfield3")));//50
					vecCol.add(correctNull(rs.getString("bsadsa_textfield4")));//51
					vecCol.add(correctNull(rs.getString("bsadsa_textfield5")));//52
					vecCol.add(correctNull(rs.getString("bsadsa_masterfield1")));//53
					vecCol.add(correctNull(rs.getString("bsadsa_masterfield2")));//54
					vecCol.add(correctNull(rs.getString("bsadsa_masterfield3")));//55
					vecCol.add(correctNull(rs.getString("bsadsa_masterfield4")));//56
					vecCol.add(correctNull(rs.getString("bsadsa_masterfield5")));//57
					vecCol.add(correctNull(rs.getString("bsadsa_textfieldval1")));//58
					vecCol.add(correctNull(rs.getString("bsadsa_textfieldval2")));//59
					vecCol.add(correctNull(rs.getString("bsadsa_textfieldval3")));//60
					vecCol.add(correctNull(rs.getString("bsadsa_textfieldval4")));//61
					vecCol.add(correctNull(rs.getString("bsadsa_textfieldval5")));//62
					vecCol.add(correctNull(rs.getString("bsadsa_masterfieldval1")));//63
					vecCol.add(correctNull(rs.getString("bsadsa_masterfieldval2")));//64
					vecCol.add(correctNull(rs.getString("bsadsa_masterfieldval3")));//65
					vecCol.add(correctNull(rs.getString("bsadsa_masterfieldval4")));//66
					vecCol.add(correctNull(rs.getString("bsadsa_masterfieldval5")));//67
					vecRow.add(vecCol);	
				}

				hshRecord.put("vecRow",vecRow);
				hshRecord.put("svalue", svalue);
				hshRecord.put("scode", scode);
				hshRecord.put("strLeadScode", strLeadScode);
				hshRecord.put("appraiser",Helper.correctNull((String)hshValues.get("appraiser")));
			}
			
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("sel_masterdynamicfields");
			while(rs.next())
			{
				arrCol= new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("type")));
				arrCol.add(Helper.correctNull(rs.getString("bsadsa_othtype")));
				arrCol.add(Helper.correctNull(rs.getString("bsadsa_textfield1")));
				arrCol.add(Helper.correctNull(rs.getString("bsadsa_textfield2")));
				arrCol.add(Helper.correctNull(rs.getString("bsadsa_textfield3")));
				arrCol.add(Helper.correctNull(rs.getString("bsadsa_textfield4")));
				arrCol.add(Helper.correctNull(rs.getString("bsadsa_textfield5")));
				arrCol.add(Helper.correctNull(rs.getString("bsadsa_masterfield1")));
				arrCol.add(Helper.correctNull(rs.getString("bsadsa_masterfield2")));
				arrCol.add(Helper.correctNull(rs.getString("bsadsa_masterfield3")));
				arrCol.add(Helper.correctNull(rs.getString("bsadsa_masterfield4")));
				arrCol.add(Helper.correctNull(rs.getString("bsadsa_masterfield5")));
				arrRow.add(arrCol);
			}
			
			hshRecord.put("arrRow", arrRow);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getValuerMasterList "+ce.toString());
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
		
	public void updateUserPageControl(HashMap hshValues)
	{
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strAction = Helper.correctNull((String)hshValues.get("hidAction"));
		String strQuery = "",strSno="";
		ResultSet rs = null;
		
		try
		{
			String strPageName = Helper.correctNull((String)hshValues.get("sel_pagenames"));
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				strQuery = SQLParser.getSqlQuery("sel_useraccess_sno");
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strSno = Helper.correctInt((String)rs.getString("maxsno"));
				}
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_useraccess");
				arrValues.add(strSno);				
				arrValues.add(strPageName);				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_user_id")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));	
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_useraccess");
				arrValues.add(Helper.correctNull((String)hshValues.get("hidSno_Val")));				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
			}
			if(hshQueryValues != null && hshQueryValues.size()>0)
			{
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getUserPageControl=="+e.toString());
		}
	}
	
	public HashMap getUserPageControl(HashMap hshValues)
	{
		HashMap hshResult = new HashMap();
		String strQuery = "",strSno="";
		ResultSet rs = null;
		
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		
		try
		{
			String strPageName = Helper.correctNull((String)hshValues.get("sel_pagenames"));
			
			strQuery = SQLParser.getSqlQuery("sel_useraccess^"+strPageName);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(Helper.correctInt((String)rs.getString("USER_SNO")));
				arrCol.add(Helper.correctInt((String)rs.getString("USER_PAGE_VAL")));
				arrCol.add(Helper.correctInt((String)rs.getString("USER_STAFF_ID")));
				arrCol.add(Helper.correctInt((String)rs.getString("USR_FNAME")));
				arrCol.add(Helper.correctInt((String)rs.getString("ORG_NAME")));
				arrRow.add(arrCol);
			}
			
			hshResult.put("strPageName", strPageName);
			hshResult.put("arrRow", arrRow);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getUserPageControl=="+e.toString());
		}
		return hshResult;
	}
	
	public void updateBuilderMasterData(HashMap hshValues)
	{		 
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();	 
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		ResultSet rs1 = null;
		String strOrgCode=""; 
	 	String strAction = null;		 
		String strslno = "";
		String strbuildername = "";
		String strbuilderadd1 = "";
		String strbuilderadd2 = "";
		String strbuilderadd3 = "";
		String strbuildercity ="";
		String strbuilderstate ="";
		String strbuilderpincode ="";
		String strbuilder_country ="";
		String strbuilder_off_phoneno ="";
		String strbuilder_off_faxno ="";
		String strbuilder_res_phoneno ="";
		String strbuilder_res_mobno ="";
		String strbuilder_contper ="";
		String strbuilder_contper_phmobno="";		
		String strbuilder_contper_design ="";
		String strbuilder_email ="";
		String strbuilder_reputed_status ="";
		String strbuilder_active ="";
		String strbuilder_comments ="";
		String strbuilder_blacklist ="";
		String strbuilder_blacklistdate ="";
		String strProjectName ="";
		String strExOrgCode=Helper.correctNull((String)hshValues.get("hidExorgcode"));
		try
		{
					
			strOrgCode = correctNull((String)hshValues.get("org_code"));
			strAction      = correctNull((String)hshValues.get("hidAction"));
			strslno	= correctNull((String )hshValues.get("hidsno"));
			strbuildername	    = correctNull((String)hshValues.get("txt_name")).toUpperCase();
			strbuilderadd1	= correctNull((String)hshValues.get("txt_address1")).toUpperCase();
			strbuilderadd2		= correctNull((String)hshValues.get("txt_address2")).toUpperCase();
			strbuilderadd3     = correctNull((String)hshValues.get("txt_address3")).toUpperCase();
			strbuildercity    = correctNull((String)hshValues.get("hidcity"));
			strbuilderstate   = correctNull((String)hshValues.get("hidstate"));
			strbuilderpincode    = correctNull((String)hshValues.get("txt_zip"));
			strbuilder_country    = correctNull((String)hshValues.get("txt_country")).toUpperCase();
			strbuilder_off_phoneno  = correctNull((String)hshValues.get("txt_offphone"));
			strbuilder_off_faxno  = correctNull((String)hshValues.get("txt_offfaxno"));
			strbuilder_res_phoneno    = correctNull((String)hshValues.get("txt_resphone"));
			strbuilder_res_mobno = correctNull((String)hshValues.get("txt_resmobileno"));
			strbuilder_contper    = correctNull((String)hshValues.get("txt_contactperson")).toUpperCase();			
			strbuilder_contper_phmobno    = correctNull((String)hshValues.get("txt_contactmobilephone"));
			strbuilder_contper_design  = correctNull((String)hshValues.get("txt_desig1")).toUpperCase();
			strbuilder_email  = correctNull((String)hshValues.get("txt_emailid"));
			strbuilder_reputed_status    = correctNull((String)hshValues.get("txt_reputedstatus"));
			strbuilder_active = correctNull((String)hshValues.get("txt_action"));
			strbuilder_comments    = correctNull((String)hshValues.get("txt_comments"));
			strbuilder_blacklist= correctNull((String)hshValues.get("sel_blacklist"));
			strbuilder_blacklistdate= correctNull((String)hshValues.get("txt_blacklistdate"));
			strProjectName= correctNull((String)hshValues.get("txt_projectName"));
			if(strbuilder_blacklistdate.equalsIgnoreCase(""))
			{
				strbuilder_blacklistdate = "01/01/1900";
			}
			if(strbuilder_contper_design.equalsIgnoreCase(""))
			{
				strbuilder_contper_design = "0";
			}
			////sel_buildermaster
			StringBuilder strOldAudit = new StringBuilder();
			if(strAction.equalsIgnoreCase("Update"))
			{
				if(rs!=null)
				{
					rs.close();
				}
				rs = DBUtils.executeLAPSQuery("sel_buildermaster^"+strExOrgCode+"^"+strslno);
				if(rs.next()){
					strOldAudit.append("~Builder Name = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("builder_name")));
					strOldAudit.append("~Contact Person Name  = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("builder_contper")));
					strOldAudit.append("~Builder Address = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("builder_address1"))+ " "+
							Helper.correctNull((String)rs.getString("builder_address2"))+ " "+
							Helper.correctNull((String)rs.getString("builder_address3")));
					strOldAudit.append("~Contact Person Mobile /Phone No. = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("builder_contper_phmobno")));
					strOldAudit.append("~Contact Person's Designation = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("builder_contper_design")));
					strOldAudit.append("~City   = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("city_name")));
					strOldAudit.append("~"+ApplicationParams.getZipName()+" =");
					strOldAudit.append(Helper.correctNull((String)rs.getString("builder_pincode")));
					strOldAudit.append("~State = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("state_name")));
					strOldAudit.append("~Country = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("builder_country")));
					strOldAudit.append("~Reputed status = ");
					if(Helper.correctNull((String)rs.getString("builder_reputed_status")).equals("1"))
					{
					strOldAudit.append("Yes");
					}else if(Helper.correctNull((String)rs.getString("builder_reputed_status")).equals("2"))
					{
						strOldAudit.append("No");
					}else{
						strOldAudit.append("");
					}
					strOldAudit.append("~Residential Phone No.= ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("builder_res_phoneno")));
					strOldAudit.append("~Mobile No. = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("builder_res_mobno")));
					strOldAudit.append("~Office Phone No.= ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("builder_off_phoneno")));
					strOldAudit.append("~Office Fax No.= ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("builder_off_faxno")));
					strOldAudit.append("~Email Id= ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("builder_email")));
					strOldAudit.append("~Action = ");
					if(Helper.correctNull((String)rs.getString("builder_active")).equals("1"))
					{
						strOldAudit.append("Enabled");
					}else if(Helper.correctNull((String)rs.getString("builder_active")).equals("2"))
					{
						strOldAudit.append("Disabled");
					}else{
						strOldAudit.append("");
					}
					strOldAudit.append("~If he is Black Listed = ");
					if(Helper.correctNull((String)rs.getString("builder_blacklist")).equals("Y"))
					{
						strOldAudit.append("Yes");
					}else if(Helper.correctNull((String)rs.getString("builder_blacklist")).equals("N"))
					{
						strOldAudit.append("No");
					}else{
						strOldAudit.append("");
					}
					if(((String)rs.getString("builder_blacklist")).equals("Y"))
					{	
						strOldAudit.append("~Black Listed Date =").append(correctNull(rs.getString("builder_blacklistdate")));
					}
				}
			}
			if (strAction.equalsIgnoreCase("insert"))
			{
				rs1 =DBUtils.executeLAPSQuery("max_buildermaster");
				
				
				while(rs1.next())
				{	
					strslno = rs1.getString("MAXID");
				}
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strOrgCode);
				arrValues.add(strslno);
				arrValues.add(strbuildername);
				arrValues.add(strbuilderadd1);
				arrValues.add(strbuilderadd2);
				arrValues.add(strbuilderadd3);
				arrValues.add(strbuildercity);
				arrValues.add(strbuilderstate);
				arrValues.add(strbuilderpincode);
				arrValues.add(strbuilder_country);
				arrValues.add(strbuilder_off_phoneno);
				arrValues.add(strbuilder_off_faxno);
				arrValues.add(strbuilder_res_phoneno);
				arrValues.add(strbuilder_res_mobno);
				arrValues.add(strbuilder_contper);
				arrValues.add(strbuilder_contper_phmobno);				
				arrValues.add(strbuilder_contper_design);
				arrValues.add(strbuilder_email);
				arrValues.add(strbuilder_reputed_status);
				arrValues.add(strbuilder_active);
				arrValues.add(strbuilder_comments);
				arrValues.add(strbuilder_blacklist);
				arrValues.add(strbuilder_blacklistdate);
				arrValues.add(strProjectName);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_buildermaster");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}			
			else if(strAction.equalsIgnoreCase("update"))
			{
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strOrgCode);
				arrValues.add(strslno);
				arrValues.add(strbuildername);
				arrValues.add(strbuilderadd1);
				arrValues.add(strbuilderadd2);
				arrValues.add(strbuilderadd3);
				arrValues.add(strbuildercity);
				arrValues.add(strbuilderstate);
				arrValues.add(strbuilderpincode);
				arrValues.add(strbuilder_country);
				arrValues.add(strbuilder_off_phoneno);
				arrValues.add(strbuilder_off_faxno);
				arrValues.add(strbuilder_res_phoneno);
				arrValues.add(strbuilder_res_mobno);
				arrValues.add(strbuilder_contper);
				arrValues.add(strbuilder_contper_phmobno);				
				arrValues.add(strbuilder_contper_design);
				arrValues.add(strbuilder_email);
				arrValues.add(strbuilder_reputed_status);
				arrValues.add(strbuilder_active);
				arrValues.add(strbuilder_comments);
				arrValues.add(strbuilder_blacklist);
				arrValues.add(strbuilder_blacklistdate);
				arrValues.add(strProjectName);
				arrValues.add(strslno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upd_buildermaster");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}			
			
			
			
			StringBuilder sbAuditTrial=new StringBuilder();
			sbAuditTrial.append("Builder Name =").append(correctNull((String )hshValues.get("txt_name"))).append("~Contact Person Name  =").append(correctNull((String )hshValues.get("txt_contactperson")))
			.append("~Builder Address =").append(correctNull((String )hshValues.get("txt_address1"))).append(" "+correctNull((String )hshValues.get("txt_address2")))
			.append(" "+correctNull((String )hshValues.get("txt_address3"))).append("~Contact Person Mobile /Phone No. =").append(correctNull((String )hshValues.get("txt_contactmobilephone")))
			.append("~Contact Person's Designation  =").append(correctNull((String )hshValues.get("txt_desig1"))).append("~City  =").append(correctNull((String )hshValues.get("txt_city")))
			.append("~"+ApplicationParams.getZipName()+" =").append(correctNull((String )hshValues.get("txt_zip"))).append("~State  =").append(correctNull((String )hshValues.get("txt_state")))
			.append("~Country  =").append(correctNull((String )hshValues.get("txt_country"))).append("~Reputed Status  =").append(SetupParams.getSetupParams("SAABranch",(String)hshValues.get("txt_reputedstatus")))
			.append("~Residential Phone No.  =").append(correctNull((String )hshValues.get("txt_resphone"))).append("~Mobile No.  =").append(correctNull((String )hshValues.get("txt_resmobileno")))
			.append("~Office Phone No.  =").append(correctNull((String )hshValues.get("txt_offphone"))).append("~Office Fax No.  =").append(correctNull((String )hshValues.get("txt_offfaxno")))
			.append("~Action  =").append(correctNull(SetupParams.getSetupParams("MasterAction",(String)hshValues.get("txt_action")))).append("~Email Id =").append(correctNull((String )hshValues.get("txt_emailid")))
			.append("~If he is Black Listed  =").append(SetupParams.getSetupParams("SacrificeLimit",(String)hshValues.get("sel_blacklist")));
			if(((String)hshValues.get("sel_blacklist")).equals("Y"))
			{	
				sbAuditTrial.append("~Black Listed Date =").append(correctNull((String )hshValues.get("txt_blacklistdate")));
			}
			AuditTrial.auditNewLog(hshValues,"134",strslno,sbAuditTrial.toString(),strOldAudit.toString());
		}
		catch (Exception ce)
		{
			throw new EJBException("Error on found in u'r bean <-- "+ce.toString());
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
	}
	
	public HashMap getBuilderMasterList(HashMap hshValues) 
	{
		
		String strQuery="", scode="", svalue="",strCat="",desc="";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();
		String strOrgCode ="";
		String strAction = null;
		try
		{
			
			scode=correctNull((String)hshValues.get("stype"));
			svalue=correctNull((String)hshValues.get("svalue"));
			strAction   = correctNull((String)hshValues.get("hidAction"));
			String strsno	= correctNull((String )hshValues.get("hidsno"));
			strOrgCode = correctNull((String) hshValues.get("strOrgCode"));
			if((strsno.trim().equals("")))
			{
				strsno="0";
			}
			
			
			if(strAction.equalsIgnoreCase("Edit")||strAction.equalsIgnoreCase("Cancel"))
			{
				strQuery = SQLParser.getSqlQuery("sel_buildermaster^"+strOrgCode+"^"+strsno);
				rs = DBUtils.executeQuery(strQuery);
				hshRecord = new HashMap();
				if(rs.next())
				{				
					hshRecord.put("ORG_CODE",(correctNull(rs.getString("ORG_CODE"))));
					hshRecord.put("BUILDER_CODE",(correctNull(rs.getString("BUILDER_CODE"))));
					hshRecord.put("BUILDER_NAME",(correctNull(rs.getString("BUILDER_NAME"))));
					hshRecord.put("BUILDER_ADDRESS1",(correctNull(rs.getString("BUILDER_ADDRESS1"))));
					hshRecord.put("BUILDER_ADDRESS2",(correctNull(rs.getString("BUILDER_ADDRESS2"))));
					hshRecord.put("BUILDER_ADDRESS3",(correctNull(rs.getString("BUILDER_ADDRESS3"))));
					hshRecord.put("BUILDER_CITY_CODE",(correctNull(rs.getString("BUILDER_CITY"))));
					hshRecord.put("BUILDER_STATE_CODE",(correctNull(rs.getString("BUILDER_STATE"))));
					hshRecord.put("BUILDER_PINCODE",(correctNull(rs.getString("BUILDER_PINCODE"))));
					hshRecord.put("BUILDER_COUNTRY",(correctNull(rs.getString("BUILDER_COUNTRY"))));
					hshRecord.put("BUILDER_OFF_PHONENO",(correctNull(rs.getString("BUILDER_OFF_PHONENO"))));
					hshRecord.put("BUILDER_OFF_FAXNO",(correctNull(rs.getString("BUILDER_OFF_FAXNO"))));
					hshRecord.put("BUILDER_RES_PHONENO",(correctNull(rs.getString("BUILDER_RES_PHONENO"))));
					hshRecord.put("BUILDER_RES_MOBNO",(correctNull(rs.getString("BUILDER_RES_MOBNO"))));
					hshRecord.put("BUILDER_CONTPER",(correctNull(rs.getString("BUILDER_CONTPER"))));
					hshRecord.put("BUILDER_CONTPER_PHMOBNO",(correctNull(rs.getString("BUILDER_CONTPER_PHMOBNO"))));					
					hshRecord.put("BUILDER_CONTPER_DESIGN",(correctNull(rs.getString("BUILDER_CONTPER_DESIGN"))));
					hshRecord.put("BUILDER_EMAIL",(correctNull(rs.getString("BUILDER_EMAIL"))));
					hshRecord.put("BUILDER_REPUTED_STATUS",(correctNull(rs.getString("BUILDER_REPUTED_STATUS"))));
					hshRecord.put("BUILDER_ACTIVE",(correctNull(rs.getString("BUILDER_ACTIVE"))));
					hshRecord.put("BUILDER_COMMENTS",(correctNull(rs.getString("BUILDER_COMMENTS"))));
					hshRecord.put("builder_blacklist",(correctNull(rs.getString("builder_blacklist"))));
					hshRecord.put("BUILDER_PROJECTNAME",(correctNull(rs.getString("BUILDER_PROJECTNAME"))));
					String blacklistdate=(correctNull(rs.getString("builder_blacklistdate")));
					if(blacklistdate.equalsIgnoreCase("01/01/1900"))
					{
						hshRecord.put("builder_blacklistdate","");
					}
					else
					{
						hshRecord.put("builder_blacklistdate",(correctNull(rs.getString("builder_blacklistdate"))));
					}
					
					//hshRecord.put("DESIGN_NAME",(correctNull(rs.getString("DESIGN_NAME"))));
					hshRecord.put("BUILDER_CITY",(correctNull(rs.getString("city_name"))));
					hshRecord.put("BUILDER_STATE",(correctNull(rs.getString("state_name"))));
					hshRecord.put("trapedit","E");
					}
			}
			else if(strAction.equalsIgnoreCase("search"))
			{		
				desc="";
				scode=correctNull((String)hshValues.get("stype"));
				svalue=correctNull((String)hshValues.get("svalue"));
				String strPagefrom=Helper.correctNull((String)hshValues.get("strfrom"));
				strCat=correctNull((String)hshValues.get("hidcat"));
				if(strPagefrom.equalsIgnoreCase("BuilderMaster"))
				{
					if(scode.equals(""))
					{
						strQuery = SQLParser.getSqlQuery("sel_buildermasterall");
					}				
					else if(scode.equals("N"))
					{
						if(strCat.equalsIgnoreCase("2")){
							 desc= " and upper(BUILDER_PROJECTNAME) like upper('%"+svalue+"%')";
						}else{
							desc= " and upper(builder_name) like upper('%"+svalue+"%')";
						}
							strQuery = SQLParser.getSqlQuery("sel_buildermasterall");
							strQuery=strQuery.concat(desc);
					}	
				}
				else
				{
					if(scode.equals(""))
					{
						
						strQuery = SQLParser.getSqlQuery("sel_buildermasterall_search^'"+strOrgCode+"','"+strOrgCode.substring(0, 9)+"000000','"+strOrgCode.substring(0, 6)+"000000000','"+strOrgCode.substring(0, 3)+"000000000000'");
					}				
					else if(scode.equals("N"))
					{
						if(strCat.equalsIgnoreCase("2")){
							 desc= " and upper(BUILDER_PROJECTNAME) like upper('%"+svalue+"%')";
						}else{
							desc= " and upper(builder_name) like upper('%"+svalue+"%')";
						}
							
						strQuery = SQLParser.getSqlQuery("sel_buildermasterall_search^'"+strOrgCode+"','"+strOrgCode.substring(0, 9)+"000000','"+strOrgCode.substring(0, 6)+"000000000','"+strOrgCode.substring(0, 3)+"000000000000'");
						strQuery=strQuery.concat(desc);
					}
				}
				rs = DBUtils.executeQuery(strQuery);
				hshRecord = new HashMap();
				while(rs.next())
				{
					
					vecCol = new ArrayList();
					vecCol.add(correctNull(rs.getString(1)));//0 org_code
					vecCol.add(correctNull(rs.getString(2)));//1 builder_code
					vecCol.add(correctNull(rs.getString(3)));//2 builder_name
					vecCol.add(correctNull(rs.getString(4)));//3 builder_address1
					vecCol.add(correctNull(rs.getString(5)));//4 builder_address2
					vecCol.add(correctNull(rs.getString(6)));//5 builder_address3
					vecCol.add(correctNull(rs.getString(7)));//6 builder_city
					vecCol.add(correctNull(rs.getString(8)));//7 builder_state
					vecCol.add(correctNull(rs.getString(9)));//8 builder_pincode
					vecCol.add(correctNull(rs.getString(10)));//9 builder_country
					vecCol.add(correctNull(rs.getString(11)));//10 builder_off_phoneno
					vecCol.add(correctNull(rs.getString(12)));//11 builder_off_faxno
					vecCol.add(correctNull(rs.getString(13)));//12 builder_res_phoneno
					vecCol.add(correctNull(rs.getString(14)));//13 builder_res_mobno
					vecCol.add(correctNull(rs.getString(15)));//14 builder_contper
					vecCol.add(correctNull(rs.getString(16)));//15 builder_contper_phmobno
					vecCol.add(correctNull(rs.getString(17)));//16 builder_contper_design
					vecCol.add(correctNull(rs.getString(18)));//17 builder_email
					vecCol.add(correctNull(rs.getString(19)));//18 builder_reputed_status
					vecCol.add(correctNull(rs.getString(20)));//19 builder_active
					vecCol.add(correctNull(rs.getString(21)));//20 builder_comments
					vecCol.add(correctNull(rs.getString(22)));//21 builder_blacklist
					vecCol.add(correctNull(rs.getString(23)));//22 builder_blacklistdate
					//vecCol.add(correctNull(rs.getString(24)));//23 design_name
					vecCol.add(correctNull(rs.getString(24)));//23 city_name
					vecCol.add(correctNull(rs.getString(25)));//24 state_name
					vecCol.add(correctNull(rs.getString("BUILDER_PROJECTNAME")));//25 Project_name
					vecRow.add(vecCol);	
				}
				hshRecord.put("vecRow",vecRow);
				hshRecord.put("svalue", svalue);
				hshRecord.put("scode", scode);
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getBuilderMasterList "+ce.toString());
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

	public void updateCompanyMasterData(HashMap hshValues)
	{		 
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();	 
		ArrayList arrValues = new ArrayList();
		
		ResultSet rs = null;
		ResultSet rs1 = null;
		String strQuery1="";
		String strOrgCode=""; 
	 	String strAction = null;		 
		String strslno = "";
		String strcompanyname = "";
		String strcompanyadd1 = "";
		String strcompanyadd2 = "";
		String strcompanyadd3 = "";
		String strcompanycity = "";
		String strcompanystate = "";
		String strcompanypincode = "";
		String strcompany_country = "";
		String strcompany_off_phoneno = "";
		String strcompany_off_faxno = "";
		String strcompany_res_phoneno = "";
		String strcompany_res_mobno = "";
		String strcompany_contper = "";
		String strcompany_contper_phmobno= "";		
		String strcompany_contper_design = "";
		String strcompany_email = "";
		String strcompany_comments = "";
		String strcompany_blacklist = "";
		String strcompany_blacklistdate = "";
		try
		{
					
			strOrgCode = correctNull((String)hshValues.get("org_code"));
			strAction      = correctNull((String)hshValues.get("hidAction"));
			strslno	= correctNull((String)hshValues.get("hidsno"));
			strcompanyname	    = correctNull((String)hshValues.get("txt_name"));
			strcompanyadd1	= correctNull((String)hshValues.get("txt_address1"));
			strcompanyadd2		= correctNull((String)hshValues.get("txt_address2"));
			strcompanyadd3     = correctNull((String)hshValues.get("txt_address3"));
			strcompanycity    = correctNull((String)hshValues.get("hidcity"));
			strcompanystate   = correctNull((String)hshValues.get("hidstate"));
			strcompanypincode    = correctNull((String)hshValues.get("txt_zip"));
			strcompany_country    = correctNull((String)hshValues.get("txt_country"));
			strcompany_off_phoneno  = correctNull((String)hshValues.get("txt_offphone"));
			strcompany_off_faxno  = correctNull((String)hshValues.get("txt_offfaxno"));
			strcompany_res_phoneno    = correctNull((String)hshValues.get("txt_resphone"));
			strcompany_res_mobno = correctNull((String)hshValues.get("txt_resmobileno"));
			strcompany_contper    = correctNull((String)hshValues.get("txt_contactperson"));			
			strcompany_contper_phmobno    = correctNull((String)hshValues.get("txt_contactmobilephone"));
			strcompany_contper_design  = correctNull((String)hshValues.get("txt_desig1"));
			strcompany_email  = correctNull((String)hshValues.get("txt_emailid"));			
			strcompany_comments    = correctNull((String)hshValues.get("txt_comments"));
			strcompany_blacklist= correctNull((String)hshValues.get("sel_blacklist"));
			strcompany_blacklistdate= correctNull((String)hshValues.get("txt_blacklistdate"));
			String strExOrgCode=Helper.correctNull((String)hshValues.get("hidExorgcode"));
			if(strcompany_blacklistdate.equalsIgnoreCase(""))
			{
				strcompany_blacklistdate="01/01/1900";
			}
			StringBuilder strOldAudit = new StringBuilder();
			if(strAction.equalsIgnoreCase("Update"))
			{
				strQuery1 =  SQLParser.getSqlQuery("sel_companymaster^"+strExOrgCode+"^"+strslno);
				rs = DBUtils.executeQuery(strQuery1);
				if(rs.next())
				{
					strOldAudit.append("~Company Name = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("company_name")));
					strOldAudit.append("~Contact Person Name  = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("company_contper")));
					strOldAudit.append("~Company  Address = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("company_address1"))+ " "+
							Helper.correctNull((String)rs.getString("company_address2"))+ " "+
							Helper.correctNull((String)rs.getString("company_address3")));
					strOldAudit.append("~Contact Person Mobile /Phone No. = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("company_contper_phmobno")));
					strOldAudit.append("~Contact Person Designation = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("company_contper_design")));
					strOldAudit.append("~City   = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("city_name")));
					strOldAudit.append("~"+ApplicationParams.getZipName()+" =");
					strOldAudit.append(Helper.correctNull((String)rs.getString("company_pincode")));
					strOldAudit.append("~State = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("state_name")));
					strOldAudit.append("~Country = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("company_country")));
					strOldAudit.append("~Residential Phone No.= ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("company_res_phoneno")));
					strOldAudit.append("~Mobile No. = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("company_res_mobno")));
					strOldAudit.append("~Office Phone No.= ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("company_off_phoneno")));
					strOldAudit.append("~Office Fax No.= ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("company_off_faxno")));
					strOldAudit.append("~Email Id= ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("company_email")));
					strOldAudit.append("~If he is Black Listed = ");
					if(Helper.correctNull((String)rs.getString("company_blacklist")).equals("Y"))
					{
						strOldAudit.append("Yes");
					}else if(Helper.correctNull((String)rs.getString("company_blacklist")).equals("N"))
					{
						strOldAudit.append("No");
					}else{
						strOldAudit.append("");
					}
					if(((String)rs.getString("company_blacklist")).equals("Y"))
					{	
						strOldAudit.append("~Black Listed Date =").append(correctNull(rs.getString("company_blacklistdate")));
					}
				}
			}
			if(rs1!=null)
			{
				rs1.close();
			}
			if (strAction.equalsIgnoreCase("insert"))
			{
				
				strQuery1 = SQLParser.getSqlQuery("max_companymaster");
				
				rs1 =DBUtils.executeQuery(strQuery1);
				while(rs1.next())
				{	
					strslno = rs1.getString("MAXID");
				}
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strOrgCode);
				arrValues.add(strslno);
				arrValues.add(strcompanyname);
				arrValues.add(strcompanyadd1);
				arrValues.add(strcompanyadd2);
				arrValues.add(strcompanyadd3);
				arrValues.add(strcompanycity);
				arrValues.add(strcompanystate);
				arrValues.add(strcompanypincode);
				arrValues.add(strcompany_country);
				arrValues.add(strcompany_off_phoneno);
				arrValues.add(strcompany_off_faxno);
				arrValues.add(strcompany_res_phoneno);
				arrValues.add(strcompany_res_mobno);
				arrValues.add(strcompany_contper);
				arrValues.add(strcompany_contper_phmobno);				
				arrValues.add(strcompany_contper_design);
				arrValues.add(strcompany_email);
				arrValues.add(strcompany_comments);
				arrValues.add(strcompany_blacklist);
				arrValues.add(strcompany_blacklistdate);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_companymaster");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}			
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strOrgCode);
				arrValues.add(strslno);
				arrValues.add(strcompanyname);
				arrValues.add(strcompanyadd1);
				arrValues.add(strcompanyadd2);
				arrValues.add(strcompanyadd3);
				arrValues.add(strcompanycity);
				arrValues.add(strcompanystate);
				arrValues.add(strcompanypincode);
				arrValues.add(strcompany_country);
				arrValues.add(strcompany_off_phoneno);
				arrValues.add(strcompany_off_faxno);
				arrValues.add(strcompany_res_phoneno);
				arrValues.add(strcompany_res_mobno);
				arrValues.add(strcompany_contper);
				arrValues.add(strcompany_contper_phmobno);				
				arrValues.add(strcompany_contper_design);
				arrValues.add(strcompany_email);
				arrValues.add(strcompany_comments);
				arrValues.add(strcompany_blacklist);
				arrValues.add(strcompany_blacklistdate);
				arrValues.add(strslno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upd_companymaster");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			StringBuilder sbAuditTrial=new StringBuilder();
			sbAuditTrial.append("Company Name =").append(correctNull((String )hshValues.get("txt_name"))).append("~Contact Person Name  =").append(correctNull((String )hshValues.get("txt_contactperson")))
			.append("~Company Address =").append(correctNull((String )hshValues.get("txt_address1"))).append(" "+correctNull((String )hshValues.get("txt_address2")))
			.append(" "+correctNull((String )hshValues.get("txt_address3"))).append("~Contact Person Mobile /Phone No. =").append(correctNull((String )hshValues.get("txt_contactmobilephone")))
			.append("~Contact Person's Designation  =").append(correctNull((String )hshValues.get("txt_desig1"))).append("~City  =").append(correctNull((String )hshValues.get("txt_city")))
			.append("~"+ApplicationParams.getZipName()+" =").append(correctNull((String )hshValues.get("txt_zip"))).append("~State  =").append(correctNull((String )hshValues.get("txt_state")))
			.append("~Country  =").append(correctNull((String )hshValues.get("txt_country")))
			.append("~Residential Phone No.  =").append(correctNull((String )hshValues.get("txt_resphone"))).append("~Mobile No.  =").append(correctNull((String )hshValues.get("txt_resmobileno")))
			.append("~Office Phone No.  =").append(correctNull((String )hshValues.get("txt_offphone"))).append("~Office Fax No.  =").append(correctNull((String )hshValues.get("txt_offfaxno")))
			.append("~Email Id =").append(correctNull((String )hshValues.get("txt_emailid")))
			.append("~If he is Black Listed  =").append(SetupParams.getSetupParams("SacrificeLimit",(String)hshValues.get("sel_blacklist")));
			
			if(((String)hshValues.get("sel_blacklist")).equals("Y"))
			{	
				sbAuditTrial.append("~Black Listed Date =").append(correctNull((String )hshValues.get("txt_blacklistdate")));
			}
			
			AuditTrial.auditNewLog(hshValues,"137",strslno,sbAuditTrial.toString(),strOldAudit.toString());
		}
		catch (Exception ce)
		{
			throw new EJBException("Error on found in u'r bean <-- "+ce.toString());
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
	}
	
	public HashMap getCompanyMasterList(HashMap hshValues) 
	{
		
		String strQuery = "", scode = "",svalue = "";
 		ResultSet rs = null;
 		HashMap hshRecord = new HashMap();
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();
		String strOrgCode ="",strCode="";
		String strAction = null;
		String strOrgLevel="";
		try
		{
			
			scode=correctNull((String)hshValues.get("stype"));
			svalue=correctNull((String)hshValues.get("svalue"));
			strAction   = correctNull((String)hshValues.get("hidAction"));
			String strsno	= correctNull((String )hshValues.get("hidsno"));
			strOrgCode = correctNull((String) hshValues.get("strOrgCode"));
			strOrgLevel = correctNull((String) hshValues.get("strOrgLevel"));
			if(strOrgLevel.equalsIgnoreCase("C"))
			{
				strCode=strOrgCode.substring(0,3)+"%%%";
			}
			else if(strOrgLevel.equalsIgnoreCase("R"))
			{
				strCode=strOrgCode.substring(0,6)+"%%%";
			}
			else if(strOrgLevel.equalsIgnoreCase("D"))
			{
				strCode=strOrgCode.substring(0,9)+"%%%";
			}
			else if(strOrgLevel.equalsIgnoreCase("A"))
			{
				strCode=strOrgCode.substring(0,12)+"%%%";
			}
			else
			{
				strCode=strOrgCode;
			}
					
			if((strsno.trim().equals("")))
			{
				strsno="0";
			}
			if(strAction.equalsIgnoreCase("Edit")||strAction.equalsIgnoreCase("Cancel"))
			{
				strQuery = SQLParser.getSqlQuery("sel_companymaster^"+strOrgCode+"^"+strsno);
				rs = DBUtils.executeQuery(strQuery);
				hshRecord = new HashMap();
				if(rs.next())
				{
					hshRecord.put("org_code",(correctNull(rs.getString("org_code"))));
					hshRecord.put("company_code",(correctNull(rs.getString("company_code"))));
					hshRecord.put("company_name",(correctNull(rs.getString("company_name"))));
					hshRecord.put("company_address1",(correctNull(rs.getString("company_address1"))));
					hshRecord.put("company_address2",(correctNull(rs.getString("company_address2"))));
					hshRecord.put("company_address3",(correctNull(rs.getString("company_address3"))));
					hshRecord.put("company_city_code",(correctNull(rs.getString("company_city"))));
					hshRecord.put("company_state_code",(correctNull(rs.getString("company_state"))));
					hshRecord.put("company_city",(correctNull(rs.getString("city_name"))));
					hshRecord.put("company_state",(correctNull(rs.getString("state_name"))));
					hshRecord.put("company_pincode",(correctNull(rs.getString("company_pincode"))));
					hshRecord.put("company_country",(correctNull(rs.getString("company_country"))));
					hshRecord.put("company_off_phoneno",(correctNull(rs.getString("company_off_phoneno"))));
					hshRecord.put("company_off_faxno",(correctNull(rs.getString("company_off_faxno"))));
					hshRecord.put("company_res_phoneno",(correctNull(rs.getString("company_res_phoneno"))));
					hshRecord.put("company_res_mobno",(correctNull(rs.getString("company_res_mobno"))));
					hshRecord.put("company_contper",(correctNull(rs.getString("company_contper"))));
					hshRecord.put("company_contper_phmobno",(correctNull(rs.getString("company_contper_phmobno"))));					
					hshRecord.put("company_contper_design",(correctNull(rs.getString("company_contper_design"))));
					hshRecord.put("company_email",(correctNull(rs.getString("company_email"))));
					hshRecord.put("company_comments",(correctNull(rs.getString("company_comments"))));
					hshRecord.put("company_blacklist",(correctNull(rs.getString("company_blacklist"))));
					String blacklistdate=(correctNull(rs.getString("company_blacklistdate")));
					if(blacklistdate.equalsIgnoreCase("01/01/1900"))
					{
						hshRecord.put("company_blacklistdate","");
					}
					else
					{
						hshRecord.put("company_blacklistdate",(correctNull(rs.getString("company_blacklistdate"))));
					}
					//hshRecord.put("design_name",(correctNull(rs.getString("design_name"))));
					hshRecord.put("trapedit","E");
										
				}
			}
			else if((strAction.equalsIgnoreCase("search"))||(strAction.equalsIgnoreCase("")))
			{				
				scode=correctNull((String)hshValues.get("stype"));
				svalue=correctNull((String)hshValues.get("svalue"));
			
				String strPagefrom=Helper.correctNull((String)hshValues.get("strfrom"));
				
				if(strPagefrom.equalsIgnoreCase("CompanyMaster"))
				{
					if(scode.equals(""))
					{
						rs =DBUtils.executeLAPSQuery("sel_companymasterall");
					}
					else if(scode.equals("N"))
					{
						strQuery = SQLParser.getSqlQuery("sel_companymastername^"+svalue);
						rs=DBUtils.executeQuery(strQuery);
					}
				}
				else
				{
					if(scode.equals(""))
					{
						strQuery = SQLParser.getSqlQuery("sel_companymasterall_search^'"+strOrgCode+"','"+strOrgCode.substring(0, 9)+"000000','"+strOrgCode.substring(0, 6)+"000000000','"+strOrgCode.substring(0, 3)+"000000000000'");
						rs=DBUtils.executeQuery(strQuery);
					}
					else if(scode.equals("N"))
					{
						strQuery = SQLParser.getSqlQuery("sel_companymastername_search^'"+strOrgCode+"','"+strOrgCode.substring(0, 9)+"000000','"+strOrgCode.substring(0, 6)+"000000000','"+strOrgCode.substring(0, 3)+"000000000000'^"+svalue);
						rs=DBUtils.executeQuery(strQuery);
					}	
				}
				
				hshRecord = new HashMap();
				while(rs.next())
				{
					
					vecCol = new ArrayList();
					vecCol.add(correctNull(rs.getString(1)));//0 org_code
					vecCol.add(correctNull(rs.getString(2)));//1 company_code
					vecCol.add(correctNull(rs.getString(3)));//2 company_name
					vecCol.add(correctNull(rs.getString(4)));//3 company_address1
					vecCol.add(correctNull(rs.getString(5)));//4 company_address2
					vecCol.add(correctNull(rs.getString(6)));//5 company_address3
					vecCol.add(correctNull(rs.getString(7)));//6 company_city
					vecCol.add(correctNull(rs.getString(8)));//7 company_state
					vecCol.add(correctNull(rs.getString(9)));//8 company_pincode
					vecCol.add(correctNull(rs.getString(10)));//9 company_country
					vecCol.add(correctNull(rs.getString(11)));//10 company_off_phoneno
					vecCol.add(correctNull(rs.getString(12)));//11 company_off_faxno
					vecCol.add(correctNull(rs.getString(13)));//12 company_res_phoneno
					vecCol.add(correctNull(rs.getString(14)));//13 company_res_mobno
					vecCol.add(correctNull(rs.getString(15)));//14 company_contper
					vecCol.add(correctNull(rs.getString(16)));//15 company_contper_phmobno
					vecCol.add(correctNull(rs.getString(17)));//16 company_contper_design
					vecCol.add(correctNull(rs.getString(18)));//17 company_email
					vecCol.add(correctNull(rs.getString(19)));//18 company_comments
					vecCol.add(correctNull(rs.getString(20)));//19 company_blacklist
					vecCol.add(correctNull(rs.getString(21)));//20 company_blacklistdate
					//vecCol.add(correctNull(rs.getString(22)));
					vecCol.add(correctNull(rs.getString(22)));//21 city_name
					vecCol.add(correctNull(rs.getString(23)));//22 state_name
					vecRow.add(vecCol);
				}
				hshRecord.put("vecRow",vecRow);
				hshRecord.put("svalue", svalue);
				hshRecord.put("scode", scode);
				hshRecord.put("COMPANY_CODE",strsno);
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getCompanyMasterList "+ce.toString());
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
	
	public void updateCoopSocietyMasterData(HashMap hshValues)
	{		 
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();	 
		ArrayList arrValues = new ArrayList();
		
		ResultSet rs = null;
		ResultSet rs1 = null;
		String strOrgCode=""; 
	 	String strAction = null;		 
		String strslno = "";
		String strcoopsocno ="";
		String strcoopsocname = "";
		String strcoopsocadd1 = "";
		String strcoopsocadd2 = "";
		String strcoopsocadd3 = "";
		String strcoopsoccity ="";
		String strcoopsocstate ="";
		String strcoopsocpincode ="";
		String strcoopsoc_country ="";
		String strcoopsoc_off_phoneno ="";
		String strcoopsoc_off_faxno ="";
		String strcoopsoc_res_phoneno ="";
		String strcoopsoc_res_mobno ="";
		String strcoopsoc_contper ="";
		String strcoopsoc_contper_phmobno="";	
		String strcoopsoc_email ="";
		String strcoopsoc_approvedflag="";
		String strcoopsoc_approvedby ="";
		String strcoopsoc_blacklist="";
		String strcoopsoc_blacklistdate ="";
		String strQuery = "";
		try
		{
					
			strOrgCode                 = correctNull((String) hshValues.get("strOrgCode"));					
			strAction      = correctNull((String)hshValues.get("hidAction"));
			strslno	= correctNull((String )hshValues.get("hidsno"));
			strcoopsocno  = correctNull((String)hshValues.get("txt_code"));
			strcoopsocname	    = correctNull((String)hshValues.get("txt_name"));
			strcoopsocadd1	= correctNull((String)hshValues.get("txt_address1"));
			strcoopsocadd2		= correctNull((String)hshValues.get("txt_address2"));
			strcoopsocadd3     = correctNull((String)hshValues.get("txt_address3"));
			strcoopsoccity    = correctNull((String)hshValues.get("hidcity"));
			strcoopsocstate   = correctNull((String)hshValues.get("hidstate"));
			strcoopsocpincode    = correctNull((String)hshValues.get("txt_zip"));
			strcoopsoc_country    = correctNull((String)hshValues.get("txt_country"));
			strcoopsoc_off_phoneno  = correctNull((String)hshValues.get("txt_offphone"));
			strcoopsoc_off_faxno  = correctNull((String)hshValues.get("txt_offfaxno"));
			strcoopsoc_res_phoneno    = correctNull((String)hshValues.get("txt_resphone"));
			strcoopsoc_res_mobno = correctNull((String)hshValues.get("txt_resmobileno"));
			strcoopsoc_contper    = correctNull((String)hshValues.get("txt_contactperson"));			
			strcoopsoc_contper_phmobno    = correctNull((String)hshValues.get("txt_contactmobilephone"));
			strcoopsoc_email  = correctNull((String)hshValues.get("txt_emailid"));			
			strcoopsoc_approvedflag = correctNull((String)hshValues.get("hid_chk"));
			strcoopsoc_approvedby = correctNull((String)hshValues.get("txt_approvedby"));
			strcoopsoc_blacklist= correctNull((String)hshValues.get("sel_blacklist"));
			strcoopsoc_blacklistdate= correctNull((String)hshValues.get("txt_blacklistdate"));
			
			StringBuilder strOldAudit = new StringBuilder();
			if(strAction.equalsIgnoreCase("Update"))
			{
				strQuery = SQLParser.getSqlQuery("sel_coopsoc_master^"+strOrgCode+"^"+strslno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strOldAudit.append("~Co-Op Housing Societies Registration No = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("coopsoc_no")));
					strOldAudit.append("~Name of the society = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("coopsoc_name")));
					strOldAudit.append("~Contact Person Name  = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("coopsoc_contper")));
					strOldAudit.append("~Society  Address = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("coopsoc_address1"))+ " "+
							Helper.correctNull((String)rs.getString("coopsoc_address2"))+ " "+
							Helper.correctNull((String)rs.getString("coopsoc_address3")));
					strOldAudit.append("~Contact Person Mobile /Phone No. = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("coopsoc_contper_phmobno")));
					strOldAudit.append("~City   = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("city_name")));
					strOldAudit.append("~"+ApplicationParams.getZipName()+" =");
					strOldAudit.append(Helper.correctNull((String)rs.getString("coopsoc_pincode")));
					strOldAudit.append("~State = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("state_name")));
					strOldAudit.append("~Country = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("coopsoc_country")));
					strOldAudit.append("~Approved by a competent state Govt. Authority = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("approvedflag")));
					strOldAudit.append("~Residential Phone No.= ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("coopsoc_res_phoneno")));
					strOldAudit.append("~Mobile No. = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("coopsoc_res_mobno")));
					strOldAudit.append("~Office Phone No.= ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("coopsoc_off_phoneno")));
					strOldAudit.append("~Office Fax No.= ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("coopsoc_off_faxno")));
					strOldAudit.append("~Email Id= ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("coopsoc_email")));
					strOldAudit.append("~Approved by = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("approvedby")));
					strOldAudit.append("~If he is Black Listed = ");
					if(Helper.correctNull((String)rs.getString("coopsoc_blacklist")).equals("Y"))
					{
						strOldAudit.append("Yes");
					}else if(Helper.correctNull((String)rs.getString("coopsoc_blacklist")).equals("N"))
					{
						strOldAudit.append("No");
					}else{
						strOldAudit.append("");
					}
					if(((String)rs.getString("coopsoc_blacklist")).equals("Y"))
					{	
						strOldAudit.append("~Black Listed Date =").append(correctNull(rs.getString("coopsoc_blacklistdate")));
					}
				}
			}
			if (strAction.equalsIgnoreCase("insert"))
			{
				rs1 = DBUtils.executeLAPSQuery("max_coopsoc_master^"+strOrgCode);
				
				
				while(rs1.next())
				{	
					strslno = rs1.getString("MAXID");
				}
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strOrgCode);
				arrValues.add(strslno);
				arrValues.add(strcoopsocno);				
				arrValues.add(strcoopsocname);
				arrValues.add(strcoopsocadd1);
				arrValues.add(strcoopsocadd2);
				arrValues.add(strcoopsocadd3);
				arrValues.add(strcoopsoccity);
				arrValues.add(strcoopsocstate);
				arrValues.add(strcoopsocpincode);
				arrValues.add(strcoopsoc_country);
				arrValues.add(strcoopsoc_off_phoneno);
				arrValues.add(strcoopsoc_off_faxno);
				arrValues.add(strcoopsoc_res_phoneno);
				arrValues.add(strcoopsoc_res_mobno);
				arrValues.add(strcoopsoc_contper);
				arrValues.add(strcoopsoc_contper_phmobno);	
				arrValues.add(strcoopsoc_email);
				arrValues.add(strcoopsoc_approvedflag);
				arrValues.add(strcoopsoc_approvedby);
				arrValues.add(strcoopsoc_blacklist);
				arrValues.add(strcoopsoc_blacklistdate);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_coopsoc_master");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}			
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strOrgCode);
				arrValues.add(strslno);
				arrValues.add(strcoopsocno);
				arrValues.add(strcoopsocname);
				arrValues.add(strcoopsocadd1);
				arrValues.add(strcoopsocadd2);
				arrValues.add(strcoopsocadd3);
				arrValues.add(strcoopsoccity);
				arrValues.add(strcoopsocstate);
				arrValues.add(strcoopsocpincode);
				arrValues.add(strcoopsoc_country);
				arrValues.add(strcoopsoc_off_phoneno);
				arrValues.add(strcoopsoc_off_faxno);
				arrValues.add(strcoopsoc_res_phoneno);
				arrValues.add(strcoopsoc_res_mobno);
				arrValues.add(strcoopsoc_contper);
				arrValues.add(strcoopsoc_contper_phmobno);	
				arrValues.add(strcoopsoc_email);
				arrValues.add(strcoopsoc_approvedflag);
				arrValues.add(strcoopsoc_approvedby);
				arrValues.add(strcoopsoc_blacklist);
				arrValues.add(strcoopsoc_blacklistdate);
				arrValues.add(strOrgCode);
				arrValues.add(strslno);
				
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upd_coopsoc_master");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}	
			
			StringBuilder sbAuditTrial=new StringBuilder();
			sbAuditTrial.append("Co-Op Housing Societies Registration No =").append(correctNull((String )hshValues.get("txt_code"))).append("~Name of the Society =").append(correctNull((String )hshValues.get("txt_name"))).append("~Contact Person Name  =").append(correctNull((String )hshValues.get("txt_contactperson")))
			.append("~Address =").append(correctNull((String )hshValues.get("txt_address1"))).append(" "+correctNull((String )hshValues.get("txt_address2")))
			.append(" "+correctNull((String )hshValues.get("txt_address3"))).append("~Contact Person Mobile /Phone No. =").append(correctNull((String )hshValues.get("txt_contactmobilephone")))
			.append("~City  =").append(correctNull((String )hshValues.get("txt_city")))
			.append("~"+ApplicationParams.getZipName()+" =").append(correctNull((String )hshValues.get("txt_zip"))).append("~State  =").append(correctNull((String )hshValues.get("txt_state")))
			.append("~Country  =").append(correctNull((String )hshValues.get("txt_country"))).append("~Approved by a competent State Govt. Authority  =").append((correctNull((String)hshValues.get("chk_approved")).equalsIgnoreCase("checkbox"))?"Yes":"No")
			.append("~Approved by   =").append(correctNull((String )hshValues.get("txt_approvedby"))).append("~Residential Phone No.  =").append(correctNull((String )hshValues.get("txt_resphone"))).append("~Mobile No.  =").append(correctNull((String )hshValues.get("txt_resmobileno")))
			.append("~Office Phone No.  =").append(correctNull((String )hshValues.get("txt_offphone"))).append("~Office Fax No.  =").append(correctNull((String )hshValues.get("txt_offfaxno")))
			.append("~Email Id =").append(correctNull((String )hshValues.get("txt_emailid")))
			.append("~If he is Black Listed  =").append(SetupParams.getSetupParams("SacrificeLimit",correctNull((String)hshValues.get("sel_blacklist"))));
			
			if(((String)hshValues.get("sel_blacklist")).equals("Y"))
			{	
				sbAuditTrial.append("~Black Listed Date =").append(correctNull((String )hshValues.get("txt_blacklistdate")));
			}
			
			AuditTrial.auditNewLog(hshValues,"136",strslno,sbAuditTrial.toString(),strOldAudit.toString());
		}
		catch (Exception ce)
		{
			throw new EJBException("Error on found in u'r bean <-- "+ce.toString());
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
	}
	
	public HashMap getCoopSocietyMasterList(HashMap hshValues) 
	{
		
		String strQuery="",scode="",svalue="";
 		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();
		String strOrgCode ="";
		String strAction = null;
		try
		{
			
			scode=correctNull((String)hshValues.get("stype"));
			svalue=correctNull((String)hshValues.get("svalue"));
			strAction   = correctNull((String)hshValues.get("hidAction"));
			String strsno	= correctNull((String )hshValues.get("hidsno"));
			strOrgCode = correctNull((String) hshValues.get("strOrgCode"));
			if(strAction.trim().equals("New"))
			{
				rs = DBUtils.executeLAPSQuery("max_coopsoc_master1^"+strOrgCode);				
				
				while(rs.next())
				{	
					strsno = rs.getString("MAXID");
					strAction="Edit";
				}
			}		
			if((strsno.trim().equals("")))
			{
				strsno="0";
			}
			if(strAction.equalsIgnoreCase("Edit")||strAction.equalsIgnoreCase("Cancel"))
			{
				strQuery = SQLParser.getSqlQuery("sel_coopsoc_master^"+strOrgCode+"^"+strsno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("ORG_CODE",(correctNull(rs.getString("ORG_CODE"))));
					hshRecord.put("COOPSOC_CODE",(correctNull(rs.getString("COOPSOC_CODE"))));
					hshRecord.put("COOPSOC_NO",(correctNull(rs.getString("COOPSOC_NO"))));
					hshRecord.put("COOPSOC_NAME",(correctNull(rs.getString("COOPSOC_NAME"))));
					hshRecord.put("COOPSOC_ADDRESS1",(correctNull(rs.getString("COOPSOC_ADDRESS1"))));
					hshRecord.put("COOPSOC_ADDRESS2",(correctNull(rs.getString("COOPSOC_ADDRESS2"))));
					hshRecord.put("COOPSOC_ADDRESS3",(correctNull(rs.getString("COOPSOC_ADDRESS3"))));
					hshRecord.put("COOPSOC_CITY_CODE",(correctNull(rs.getString("COOPSOC_CITY"))));
					hshRecord.put("COOPSOC_CITY",(correctNull(rs.getString("CITY_NAME"))));
					hshRecord.put("COOPSOC_STATE_CODE",(correctNull(rs.getString("COOPSOC_STATE"))));
					hshRecord.put("COOPSOC_STATE",(correctNull(rs.getString("STATE_NAME"))));
					hshRecord.put("COOPSOC_PINCODE",(correctNull(rs.getString("COOPSOC_PINCODE"))));
					hshRecord.put("COOPSOC_COUNTRY",(correctNull(rs.getString("COOPSOC_COUNTRY"))));
					hshRecord.put("COOPSOC_OFF_PHONENO",(correctNull(rs.getString("COOPSOC_OFF_PHONENO"))));
					hshRecord.put("COOPSOC_OFF_FAXNO",(correctNull(rs.getString("COOPSOC_OFF_FAXNO"))));
					hshRecord.put("COOPSOC_RES_PHONENO",(correctNull(rs.getString("COOPSOC_RES_PHONENO"))));
					hshRecord.put("COOPSOC_RES_MOBNO",(correctNull(rs.getString("COOPSOC_RES_MOBNO"))));
					hshRecord.put("COOPSOC_CONTPER",(correctNull(rs.getString("COOPSOC_CONTPER"))));					
					hshRecord.put("COOPSOC_CONTPER_PHMOBNO",(correctNull(rs.getString("COOPSOC_CONTPER_PHMOBNO"))));
					hshRecord.put("COOPSOC_EMAIL",(correctNull(rs.getString("COOPSOC_EMAIL"))));
					hshRecord.put("APPROVEDFLAG",(correctNull(rs.getString("APPROVEDFLAG"))));	
					hshRecord.put("APPROVEDBY",(correctNull(rs.getString("APPROVEDBY"))));
					hshRecord.put("coopsoc_blacklist",(correctNull(rs.getString("coopsoc_blacklist"))));
					String blacklistdate=(correctNull(rs.getString("coopsoc_blacklistdate")));
					if(blacklistdate.equalsIgnoreCase("01/01/1900"))
					{
						hshRecord.put("coopsoc_blacklistdate","");
					}
					else
					{
						hshRecord.put("coopsoc_blacklistdate",(correctNull(rs.getString("coopsoc_blacklistdate"))));
					}
					hshRecord.put("trapedit","E");
				}
			}
			else if(strAction.equalsIgnoreCase("search"))
			{				
				scode=correctNull((String)hshValues.get("stype"));
				svalue=correctNull((String)hshValues.get("svalue"));
			
				if(scode.equals(""))
				{
					strQuery = SQLParser.getSqlQuery("sel_coopsoc_master_all^"+strOrgCode);
				}				
				else if(scode.equals("N"))
				{
					strQuery = SQLParser.getSqlQuery("sel_coopsoc_mastername^"+strOrgCode+"^"+svalue);
				}			
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					vecCol = new ArrayList();
					vecCol.add(correctNull(rs.getString(1)));
					vecCol.add(correctNull(rs.getString(2)));
					vecCol.add(correctNull(rs.getString(3)));
					vecCol.add(correctNull(rs.getString(4)));
					vecCol.add(correctNull(rs.getString(5)));
					vecCol.add(correctNull(rs.getString(6)));
					vecCol.add(correctNull(rs.getString(7)));
					vecCol.add(correctNull(rs.getString(8)));
					vecCol.add(correctNull(rs.getString(9)));
					vecCol.add(correctNull(rs.getString(10)));
					vecCol.add(correctNull(rs.getString(11)));
					vecCol.add(correctNull(rs.getString(12)));
					vecCol.add(correctNull(rs.getString(13)));
					vecCol.add(correctNull(rs.getString(14)));
					vecCol.add(correctNull(rs.getString(15)));
					vecCol.add(correctNull(rs.getString(16)));
					vecCol.add(correctNull(rs.getString(17)));
					vecCol.add(correctNull(rs.getString(18)));
					vecCol.add(correctNull(rs.getString(19)));
					vecCol.add(correctNull(rs.getString(20)));
					vecCol.add(correctNull(rs.getString(21)));
					vecCol.add(correctNull(rs.getString(22)));
					vecCol.add(correctNull(rs.getString(23)));
					vecCol.add(correctNull(rs.getString(24)));
					vecRow.add(vecCol);	
				}
				hshRecord.put("vecRow",vecRow);
				hshRecord.put("svalue", svalue);
				hshRecord.put("scode", scode);
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
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());						
			}
		}
		return hshRecord;
	}
	
//	public void updateOccupationMasterData(HashMap hshValues)
//	{		 
//		HashMap hshQueryValues = new HashMap();
//		HashMap hshQuery = new HashMap();	 
//		ArrayList arrValues = new ArrayList();
//		ResultSet rs   = null;
//	 	String strAction = null;		 
//		String stroccup_code = "";
//		String stroccup_name ="";
//		try
//		{
//			
//			strAction      = correctNull((String)hshValues.get("hidAction"));
//			stroccup_code	= correctNull((String )hshValues.get("hidsno"));
//			stroccup_name  = correctNull((String)hshValues.get("txt_datavalues"));
//						
//			if (strAction.equalsIgnoreCase("New"))
//			{
//				rs = DBUtils.executeLAPSQuery("max_occupationmaster");
//				
//				
//				while(rs.next())
//				{	
//					stroccup_code = rs.getString("MAXID");
//				}
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				arrValues.add(stroccup_code);
//				arrValues.add(stroccup_name);
//				hshQuery.put("arrValues",arrValues);
//				hshQuery.put("strQueryId","ins_occupationmaster");
//				hshQueryValues.put("size","1");
//				hshQueryValues.put("1",hshQuery);
//		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//			}			
//			else if(strAction.equalsIgnoreCase("Edit"))
//			{
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				arrValues.add(stroccup_name);	
//				arrValues.add(stroccup_code);							
//				hshQuery.put("arrValues",arrValues);
//				hshQuery.put("strQueryId","upd_occupationmaster");
//				hshQueryValues.put("size","1");
//				hshQueryValues.put("1",hshQuery);
//		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//			}			
//		}
//		catch (Exception ce)
//		{
//			throw new EJBException("Error on found in u'r bean <-- "+ce.toString());
//		}
//		finally
//		{
//			try
//			{
//				if(rs != null)
//				{
//					rs.close();
//				}				
//				
//			}
//			catch(Exception cf)
//			{
//				throw new EJBException("Error closing the connection "+cf.getMessage());
//			}
//		}
//	}
	
//	public HashMap getOccupationMasterList(HashMap hshValues) 
//	{
//		
// 		ResultSet rs = null;
//		HashMap hshRecord = new HashMap();
//		ArrayList vecCol		= new ArrayList();
//		ArrayList vecRow		= new ArrayList();
//		String strAction = null;
//		try
//		{
//			
//			strAction   = correctNull((String)hshValues.get("hidAction"));
//			String strsno	= correctNull((String )hshValues.get("hidsno"));
//			if(strAction.trim().equals("New"))
//			{
//				rs = DBUtils.executeLAPSQuery("max_occupationmaster1");				
//				
//				while(rs.next())
//				{	
//					strsno = rs.getString("MAXID");
//					strAction="Edit";
//				}
//			}		
//			if(strsno.trim().equals(""))
//			{
//				strsno="0";
//			}
//			if(strAction.equalsIgnoreCase("Edit")||strAction.equalsIgnoreCase("Cancel"))
//			{
//				rs = DBUtils.executeLAPSQuery("sel_occupationmaster^"+strsno);
//						
//				if(rs.next())
//				{
//					hshRecord.put("OCCUP_CODE",(correctNull(rs.getString("OCCUP_CODE"))));
//					hshRecord.put("OCCUP_NAME",(correctNull(rs.getString("OCCUP_NAME"))));				
//				}
//			}							
//			rs = DBUtils.executeLAPSQuery("sel_occupationmasterall");
//				
//			while(rs.next())
//			{
//				vecCol = new ArrayList();
//				vecCol.add(correctNull(rs.getString(1)));
//				vecCol.add(correctNull(rs.getString(2)));
//				vecRow.add(vecCol);	
//			}
//			hshRecord.put("vecRow",vecRow);				
//		}
//		catch(Exception ce)
//		{
//			throw new EJBException("Error in getOccupationMasterList "+ce.toString());
//		}
//		finally
//		{
//			try
//			{
//				if(rs != null)
//				{
//					rs.close();
//				}				
//				
//			}
//			catch(Exception cf)
//			{
//				throw new EJBException("Error closing the connection "+cf.getMessage());						
//			}
//		}
//		return hshRecord;
//	}
	
//	public void updateDesignationMasterData(HashMap hshValues)
//	{		 
//		HashMap hshQueryValues = new HashMap();
//		HashMap hshQuery = new HashMap();	 
//		ArrayList arrValues = new ArrayList();
//		
//		ResultSet rs   = null;
//	 	String strAction = null;		 
//		String stroccup_code = "";
//		String stroccup_name ="";
//		String strquery="";
//		String strExp="$";
//		int count=0;
//		try
//		{
//		
//			strAction      = correctNull((String)hshValues.get("hidAction"));
//			stroccup_code	= correctNull((String )hshValues.get("hidsno"));
//			stroccup_name  = correctNull((String)hshValues.get("txt_datavalues")).toUpperCase();
//			strquery=SQLParser.getSqlQuery("getdesignname^"+stroccup_name);
//			rs=DBUtils.executeQuery(strquery);
//			if(rs.next())
//				{
//				count=rs.getInt(1);
//				}
//			if(count!=0)
//				{	
//					strExp = strExp + "Designation Already Exists";
//					throw new Exception(strExp);
//				}
//			else
//				{
//				rs=null;
//				if (strAction.equalsIgnoreCase("insert")) 
//					{
//					rs =DBUtils.executeLAPSQuery("max_designationmaster");
//					while(rs.next())
//						{	
//						stroccup_code = rs.getString("MAXID");
//						}
//					hshQuery = new HashMap();
//					arrValues = new ArrayList();
//					arrValues.add(stroccup_code);
//					arrValues.add(stroccup_name);
//					hshQuery.put("arrValues",arrValues);
//					hshQuery.put("strQueryId","ins_designationmaster");
//					hshQueryValues.put("size","1");
//					hshQueryValues.put("1",hshQuery);
//					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//					}			
//				else if(strAction.equalsIgnoreCase("update"))
//					{
//					hshQuery = new HashMap();
//					arrValues = new ArrayList();				
//					arrValues.add(stroccup_name);
//					arrValues.add(stroccup_code);
//					hshQuery.put("arrValues",arrValues);
//					hshQuery.put("strQueryId","upd_designationmaster");
//					hshQueryValues.put("size","1");
//					hshQueryValues.put("1",hshQuery);
//					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//					}			
//				}
//			
//				if(count==0)
//				{	
//				
//					StringBuilder sbAuditTrial=new StringBuilder();
//					sbAuditTrial.append("Designation ="+correctNull((String )hshValues.get("txt_datavalues")));
//					
//					AuditTrial.auditLog(hshValues,"138","",sbAuditTrial.toString());
//				}	
//			
//		}
//		catch (Exception ce)
//		{
//			throw new EJBException("Error on found in u'r bean <-- "+ce.toString());
//		}
//		finally
//		{
//			try
//			{
//				if(rs != null)
//				{
//					rs.close();
//				}				
//				
//			}
//			catch(Exception cf)
//			{
//				throw new EJBException("Error closing the connection "+cf.getMessage());
//			}
//		}
//	}
	
//	public HashMap getDesignationMasterList(HashMap hshValues) 
//	{
//		
// 		ResultSet rs = null;
//		HashMap hshRecord = new HashMap();
//		ArrayList vecCol		= new ArrayList();
//		ArrayList vecRow		= new ArrayList();
//		String strAction = null;
//		String strQuery="";
//		try
//		{
//			
//			strAction   = correctNull((String)hshValues.get("hidAction"));
//			String sername=correctNull((String)hshValues.get("txt_ser"));
//			
//			
//			if(strAction.equalsIgnoreCase("search"))
//			{	
//				strQuery=SQLParser.getSqlQuery("sel_designationmasterall1^"+sername);
//				rs = DBUtils.executeQuery(strQuery);
//				while(rs.next())
//				{	
//					vecCol = new ArrayList();
//					vecCol.add(correctNull(rs.getString(1)));
//					vecCol.add(correctNull(rs.getString(2)));
//					vecRow.add(vecCol);	
//				}
//			}
//			else
//			{	
//				rs =DBUtils.executeLAPSQuery("sel_designationmasterall");
//				
//				while(rs.next())
//				{
//					vecCol = new ArrayList();
//					vecCol.add(correctNull(rs.getString(1)));
//					vecCol.add(correctNull(rs.getString(2)));
//					vecRow.add(vecCol);	
//				}
//			
//			}
//			
//			hshRecord.put("vecRow",vecRow);
//		}	
//		catch(Exception ce)
//		{
//			throw new EJBException("Error in getDesignationMasterList "+ce.toString());
//		}
//		finally
//		{
//			try
//			{
//				if(rs != null)
//				{
//					rs.close();
//				}				
//				
//			}
//			catch(Exception cf)
//			{
//				throw new EJBException("Error closing the connection "+cf.getMessage());						
//			}
//		}
//		return hshRecord;
//	}
	
	public void updateRejectReasonMasterData(HashMap hshValues)
	{		 
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();	 
		ArrayList arrValues = new ArrayList();
		String strKeyId = "";
		ResultSet rs   = null;
	 	String strAction = null;		 
		String strrej_code = "";
		String strrej_desc ="";
		try
		{
			StringBuilder sbAt = new StringBuilder();
			strAction      = correctNull((String)hshValues.get("hidAction"));
			strrej_code	= correctNull((String )hshValues.get("hidsno"));
			strrej_desc  = correctNull((String)hshValues.get("txttrmcontent")).toUpperCase();
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			StringBuilder sbolddata=new StringBuilder();
			if(strAction.equalsIgnoreCase("Edit"))
			{
				rs = DBUtils.executeLAPSQuery("sel_rejreasons_audit^"+strrej_code);
				if(rs.next())
				{
					sbolddata.append("~ Rejection Reasons = "+Helper.correctNull((String)rs.getString("rej_desc")));
				}
				if(rs!=null)
				{
					rs.close();
				}
			}						
			if (strAction.equalsIgnoreCase("New"))
			{
				rs = DBUtils.executeLAPSQuery("max_reject_reasons");				
				
				while(rs.next())
				{	
					strrej_code = rs.getString("MAXID");
				}
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strrej_code);
				arrValues.add(strrej_desc);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_reject_reasons");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}			
			else if(strAction.equalsIgnoreCase("Edit"))
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();				
				arrValues.add(strrej_desc);	
				arrValues.add(strrej_code);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upd_reject_reasons");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}	
			sbAt.append("~ Rejection Reasons = "+Helper.correctNull((String)hshValues.get("txttrmcontent")).toUpperCase());
			if(strAction.equalsIgnoreCase("New")){
				hshValues.put("hidAction", "insert");
			}else if(strAction.equalsIgnoreCase("Edit")){
				hshValues.put("hidAction", "update");
			}
			
			AuditTrial.auditNewLog(hshValues,"73",strKeyId,sbAt.toString(),sbolddata.toString());
		}
		catch (Exception ce)
		{
			throw new EJBException("Error on found in u'r bean <-- "+ce.toString());
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
	
	public HashMap getRejectReasonMasterList(HashMap hshValues) 
	{
 		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();
		boolean recordflag=false;
		try
		{			
			rs =DBUtils.executeLAPSQuery("sel_reject_reasonsall");
			
			while(rs.next())
			{
				recordflag=true;
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));
				vecCol.add(correctNull(rs.getString(2)));
				vecRow.add(vecCol);	
			}
			hshRecord.put("vecRow",vecRow);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getRejectreasonsMasterList "+ce.toString());
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
	
	public void updatenpaprovcoverpercnt(HashMap hshValues)  
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshQry = new HashMap();
		ArrayList arrVal = new ArrayList();
		int intArrSize = 1;
		
		try 
		{
			hshQry = new HashMap();				
			arrVal=new ArrayList();	
			hshQry.put("strQueryId","del_npaprovmaster");
			hshQry.put("arrValues", arrVal);
			hshqueryval.put("1", hshQry);

			for(int i=1;i<=6;i++)
			{
				hshQry = new HashMap();				
				arrVal=new ArrayList();	
				arrVal.add(""+i);
				hshQry.put("strQueryId","ins_npaprovmaster");	
				if(i==1){
				arrVal.add("SS");
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_ss_sec")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_ss_unsec")));}
				if(i==2){
				arrVal.add("DS1");
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_ds1_sec")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_ds1_unsec")));}
				if(i==3){
				arrVal.add("DS2");
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_ds2_sec")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_ds2_unsec")));}
				if(i==4){
				arrVal.add("DS3");
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_ds3_sec")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_ds3_unsec")));}
				if(i==5){
				arrVal.add("LOSS");
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_loss_sec")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_loss_unsec")));}
				if(i==6){
				arrVal.add("ABINTIO");
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_ab_sec")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_ab_unsec")));}
				hshQry.put("arrValues", arrVal);
				hshqueryval.put(""+(i+1), hshQry);
				intArrSize++;
			}
			
			hshqueryval.put("size",""+intArrSize);
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
		} 
		catch (Exception e) 
		{
			throw new EJBException("Error in bean "+e.toString());
		}		
	}
	
	public HashMap updateDataHouseParameters(HashMap hshValues)  
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshQry = new HashMap();
		ArrayList arrVal = new ArrayList();
		StringBuilder sbAuditTrial=new StringBuilder();
		StringBuilder sboldAuditTrial=new StringBuilder();
		String strKeyId = "",strRecordFlag = "",strQuery="",strParams="";
		ResultSet rs=null;
		try 
		{
			int intUpdatesize = 0;			
			hshqueryval = new HashMap();
			String []strNoofyears = null;
			String []strglobalslno=null;		
			String []strglobalsdesc=null;
			String []strglobalslno1=null;
			String []strglobalslno2=null;
			if(hshValues.get("txt_noofyears") instanceof java.lang.String)
			{
				strNoofyears=new String[1];
				strNoofyears[0]=Helper.correctNull((String)hshValues.get("txt_noofyears"));				
			}
			else
			{			
			      strNoofyears =(String[])hshValues.get("txt_noofyears");
			}
			
			if(hshValues.get("txt_id") instanceof java.lang.String)
			{
				strglobalslno=new String[1];
				strglobalslno[0]=Helper.correctNull((String)hshValues.get("txt_id"));				
			}
			else
			{			
				strglobalslno =(String[])hshValues.get("txt_id");
			}
			
			if(hshValues.get("txt_class_desc") instanceof java.lang.String)
			{
				strglobalsdesc=new String[1];
				strglobalsdesc[0]=Helper.correctNull((String)hshValues.get("txt_class_desc"));				
			}
			else
			{			
				strglobalsdesc =(String[])hshValues.get("txt_class_desc");
			}
			
			if(Helper.correctNull((String)hshValues.get("hidfrom")).equalsIgnoreCase("LP"))
			{
				if(hshValues.get("txt_maxid") instanceof java.lang.String)
				{
					strglobalslno1=new String[1];
					strglobalslno1[0]=Helper.correctNull((String)hshValues.get("txt_maxid"));				
				}
				else
				{			
					strglobalslno1 =(String[])hshValues.get("txt_maxid");
				}
			}
			if(hshValues.get("hidtxt_orgLevel") instanceof java.lang.String)
			{
				strglobalslno2=new String[1];
				strglobalslno2[0]=Helper.correctNull((String)hshValues.get("hidtxt_orgLevel"));				
			}
			else
			{			
				strglobalslno2 =(String[])hshValues.get("hidtxt_orgLevel");
			}
			if(strglobalslno.length>0){
			for(int i=0;i<strglobalslno.length;i++){
				strParams=strParams+"','"+strglobalslno[i];
			}
				strParams=strParams.replaceFirst("','", "");	
			}
			strKeyId = Helper.correctNull((String)hshValues.get("strOrgCode"));
			strRecordFlag = Helper.correctNull((String)hshValues.get("auditflag"));
			int len=strNoofyears.length;
			
			String strmaxcapkbl=Helper.correctNull((String)hshValues.get("hidMaxcap_kbl"));
			String strMaxcapoth=Helper.correctNull((String)hshValues.get("hidMaxcap_oth"));
			String newmaxcapkbl="",newMaxcapoth="";
			String strupdateparam="";
			boolean flagupd=false;
			/*for(int i=0;i<len;i++)
			{
				if(strglobalslno[i].equals("109"))
				{
					newmaxcapkbl=strNoofyears[i];
					if(!newmaxcapkbl.equals(strmaxcapkbl))
					{ 	strupdateparam=strupdateparam+"109@";
						flagupd=true; }
				}
				if(strglobalslno[i].equals("110"))
				{
					newMaxcapoth=strNoofyears[i];
					if(!newMaxcapoth.equals(strMaxcapoth))
					{	strupdateparam=strupdateparam+"110@";
						flagupd=true; }
				}
			}
					if(flagupd)
					{
						String strarr[]=strupdateparam.split("@");
						for(int i=0;i<strarr.length;i++)
						{
							hshQry = new HashMap();
							arrVal = new ArrayList();
							intUpdatesize=intUpdatesize+1;				
							arrVal.add(strarr[i]);
							hshQry.put("arrValues",arrVal);
							hshQry.put("strQueryId","upd_loanparam_houseparam");
							hshqueryval.put("size",String.valueOf(intUpdatesize));
							hshqueryval.put(String.valueOf(intUpdatesize),hshQry);
						}
					}*/
					
		if(Helper.correctNull((String)hshValues.get("hidfrom")).equalsIgnoreCase("HP")||Helper.correctNull((String)hshValues.get("hidfrom")).equalsIgnoreCase("RP")){	
			if(Helper.correctNull((String)hshValues.get("hidfrom")).equalsIgnoreCase("HP"))
			{
				strQuery=SQLParser.getSqlQuery("sel_houseloanparameter");
			}
			else if(Helper.correctNull((String)hshValues.get("hidfrom")).equalsIgnoreCase("RP"))
			{
				strQuery=SQLParser.getSqlQuery("sel_houseloanparameter_rating");
			}				
			/*else if(Helper.correctNull((String)hshValues.get("hidfrom")).equalsIgnoreCase("LP"))
			{
				strQuery=SQLParser.getSqlQuery("sel_lapsapplicationparameters^"+strParams);
			}*/
			if(!strQuery.equalsIgnoreCase("")){
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					sboldAuditTrial.append("~").append(rs.getString("LOAN_PARAMSLNO"));
					sboldAuditTrial.append("=").append(rs.getString("LOAN_PARAMVAL"));
				}
			}		
			intUpdatesize=intUpdatesize+1;		
			hshQry = new HashMap();				
			arrVal=new ArrayList();	
			if(Helper.correctNull((String)hshValues.get("hidfrom")).equalsIgnoreCase("HP"))
			{
				hshQry.put("strQueryId","del_houseloanparameter");	
				
			}
			else if(Helper.correctNull((String)hshValues.get("hidfrom")).equalsIgnoreCase("RP"))
			{
				
				hshQry.put("strQueryId","del_houseloanparameter_rating");	
			}				
			/*else if(Helper.correctNull((String)hshValues.get("hidfrom")).equalsIgnoreCase("LP"))
			{
				
				hshQry.put("strQueryId","del_lapsapplicationparamerters^"+strParams);	
			}	*/			
			hshQry.put("arrValues", arrVal);
			hshqueryval.put("size",String.valueOf(intUpdatesize));
			hshqueryval.put(String.valueOf(intUpdatesize),hshQry);
			
			for(int k=0;k<len;k++)
			{
					hshQry = new HashMap();
					arrVal = new ArrayList();
					intUpdatesize=intUpdatesize+1;				
					arrVal.add(strglobalslno[k]);
					arrVal.add(strNoofyears[k]);
					if(Helper.correctNull((String)hshValues.get("hidfrom")).equalsIgnoreCase("LP"))
					{
						arrVal.add(strglobalslno1[k]);
						arrVal.add(strglobalslno2[k]);
						hshQry.put("arrValues",arrVal);
						hshQry.put("strQueryId","ins_houseparameters1");
					}
					else
					{
						hshQry.put("arrValues",arrVal);
						hshQry.put("strQueryId","ins_houseparameters");
					}
					hshqueryval.put("size",String.valueOf(intUpdatesize));
					hshqueryval.put(String.valueOf(intUpdatesize),hshQry);
					sbAuditTrial.append("~").append(strglobalslno[k]);
					sbAuditTrial.append("=").append(strNoofyears[k]);
					sbAuditTrial.append("@").append(strglobalsdesc[k]);	
			}
		}
			// For updation
		String strOldParam="";
		String strsplitParams[]=null;
		
		HashMap hshTemp=new HashMap();
		int count=0;
		 if(Helper.correctNull((String)hshValues.get("hidfrom")).equalsIgnoreCase("LP"))
			{
				strQuery=SQLParser.getSqlQuery("sel_lapsapplicationparameters^"+strParams);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					sboldAuditTrial.append("~").append(rs.getString("LOAN_PARAMSLNO"));
					sboldAuditTrial.append("=").append(rs.getString("LOAN_PARAMVAL"));
					
					strOldParam=strOldParam+","+rs.getString("LOAN_PARAMVAL");
					hshTemp.put(Helper.correctNull(rs.getString("LOAN_PARAMSLNO")), Helper.correctNull(rs.getString("LOAN_PARAMVAL")));
				}
				strOldParam=strOldParam.replaceFirst("," ,"");
				strsplitParams=strOldParam.split(",");
					for (int a=0;a<strNoofyears.length;a++)
					{
						//if(!strNoofyears[a].equals(Helper.correctNull((String)hshTemp.get(strglobalslno[a]))))
					//	{
							if(strglobalslno[a].equals("109"))
							{
								newmaxcapkbl=strNoofyears[a];
								if(!newmaxcapkbl.equals(strmaxcapkbl))
								{ 	strupdateparam=strupdateparam+"109@";
									flagupd=true; }
							}
							if(strglobalslno[a].equals("110"))
							{
								newMaxcapoth=strNoofyears[a];
								if(!newMaxcapoth.equals(strMaxcapoth))
								{	strupdateparam=strupdateparam+"110@";
									flagupd=true; }
							}
							if(strglobalslno[a].equals("122"))
							{
								newMaxcapoth=strNoofyears[a];
								if(!newMaxcapoth.equals(strMaxcapoth))
								{	strupdateparam=strupdateparam+"122@";
									flagupd=true; }
							}
							if(strglobalslno[a].equals("131"))
							{
								newMaxcapoth=strNoofyears[a];
								if(!newMaxcapoth.equals(strMaxcapoth))
								{	strupdateparam=strupdateparam+"131@";
									flagupd=true; }
							}
							if(flagupd)
							{
								String strarr[]=strupdateparam.split("@");
								for(int i=0;i<strarr.length;i++)
								{
									hshQry = new HashMap();
									arrVal = new ArrayList();
									intUpdatesize=intUpdatesize+1;				
									arrVal.add(strarr[i]);
									hshQry.put("arrValues",arrVal);
									hshQry.put("strQueryId","upd_loanparam_houseparam");
									hshqueryval.put("size",String.valueOf(intUpdatesize));
									hshqueryval.put(String.valueOf(intUpdatesize),hshQry);
								}
							}
							
							strQuery=SQLParser.getSqlQuery("sel_lapsapplicationparameters^"+strglobalslno[a]);
							rs=DBUtils.executeQuery(strQuery);
							if(!rs.next())
							{
								hshQry = new HashMap();
								arrVal = new ArrayList();
								intUpdatesize=intUpdatesize+1;				
								arrVal.add(strglobalslno[a]);
								arrVal.add(strNoofyears[a]);
								arrVal.add(strglobalslno1[a]);
								arrVal.add(strglobalslno2[a]);
								hshQry.put("arrValues",arrVal);
								hshQry.put("strQueryId","ins_houseparameters1");
								hshqueryval.put("size",String.valueOf(intUpdatesize));
								hshqueryval.put(String.valueOf(intUpdatesize),hshQry);
								sbAuditTrial.append("~").append(strglobalslno[a]);
								sbAuditTrial.append("=").append(strNoofyears[a]);
								sbAuditTrial.append("@").append(strglobalsdesc[a]);	
								
							}
							else
							{
								hshQry = new HashMap();
								arrVal = new ArrayList();
								intUpdatesize=intUpdatesize+1;				
								arrVal.add(strNoofyears[a]);
								arrVal.add(strglobalslno1[a]);
								arrVal.add(strglobalslno2[a]);
								arrVal.add(strglobalslno[a]);
								hshQry.put("arrValues",arrVal);
								hshQry.put("strQueryId","upd_houseparameters1");
								hshqueryval.put("size",String.valueOf(intUpdatesize));
								hshqueryval.put(String.valueOf(intUpdatesize),hshQry);
								sbAuditTrial.append("~").append(strglobalslno[a]);
								sbAuditTrial.append("=").append(strNoofyears[a]);
								sbAuditTrial.append("@").append(strglobalsdesc[a]);	
							}
						//}
						
					}
				/*intUpdatesize=intUpdatesize+1;		
				hshQry = new HashMap();				
				arrVal=new ArrayList();	
				hshQry.put("strQueryId","del_lapsapplicationparamerters^"+strParams);
				hshQry.put("arrValues", arrVal);
				hshqueryval.put("size",String.valueOf(intUpdatesize));
				hshqueryval.put(String.valueOf(intUpdatesize),hshQry);
					for(int k=0;k<len;k++)
					{
							hshQry = new HashMap();
							arrVal = new ArrayList();
							intUpdatesize=intUpdatesize+1;				
							arrVal.add(strglobalslno[k]);
							arrVal.add(strNoofyears[k]);
							arrVal.add(strglobalslno1[k]);
							hshQry.put("arrValues",arrVal);
							hshQry.put("strQueryId","ins_houseparameters1");
							hshqueryval.put("size",String.valueOf(intUpdatesize));
							hshqueryval.put(String.valueOf(intUpdatesize),hshQry);
							sbAuditTrial.append("~").append(strglobalslno[k]);
							sbAuditTrial.append("=").append(strNoofyears[k]);
							sbAuditTrial.append("@").append(strglobalsdesc[k]);	
					}*/	
			
			}
			
					
			//-------------------------------Audittrial-------------------------------
			if(strRecordFlag.equalsIgnoreCase("Y")){
				hshValues.put("hidAction", "update");
			}else if(strRecordFlag.equalsIgnoreCase("N")){
				hshValues.put("hidAction", "insert");
			}
			
			if(intUpdatesize>0)
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			
			AuditTrial.auditNewLog(hshValues,"78",strKeyId,sbAuditTrial.toString(),sboldAuditTrial.toString());
			//----------------------------------End-----------------------------------
			hshqueryval.put("hidfrom", Helper.correctNull((String)hshValues.get("hidfrom")));
			hshqueryval = getDataHouseParameters(hshqueryval);
		} 
		catch (Exception e) 
		{
			throw new EJBException("Error in bean "+e.toString());
		}		
		return hshqueryval;
	}
	
	public HashMap getDataHouseParameters(HashMap hshValues)  
	{
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		ResultSet rs = null,rs1=null;
		HashMap hshRecord = new HashMap();		
		ArrayList vecData2 = new ArrayList();
		ArrayList vecRec2 = new ArrayList();
		
		ArrayList arrRow1 = new ArrayList();
		ArrayList arrCol1 = new ArrayList();
		boolean recordflag=false; 
		String strPageFrom="";
		String strParams="",strMaxParams="",strQuery="",strMSMEParams="";
		try 
		{			
			strPageFrom=Helper.correctNull((String)hshValues.get("hidfrom"));
			
			rs1 =DBUtils.executeLAPSQuery("sel_static_sanc_depart");
			while (rs1.next()) 
			{
				arrCol1 = new ArrayList();
				arrCol1.add(correctNull(rs1.getString("CBS_STATIC_DATA_ID")));
				arrCol1.add(correctNull(rs1.getString("CBS_STATIC_DATA_CODE")));
				arrCol1.add(correctNull(rs1.getString("CBS_STATIC_DATA_DESC")));
				arrCol1.add(correctNull(rs1.getString("CBS_STATIC_DATA_PASSING_CODE")));
				strParams=strParams+"','C"+correctNull(rs1.getString("CBS_STATIC_DATA_PASSING_CODE"));
				strMaxParams=strMaxParams+"','P"+correctNull(rs1.getString("CBS_STATIC_DATA_PASSING_CODE"));
				strMSMEParams=strMSMEParams+"','M"+correctNull(rs1.getString("CBS_STATIC_DATA_PASSING_CODE"));
				arrRow1.add(arrCol1);
			}
			strParams=strParams.replaceFirst("','", "");
			strMaxParams=strMaxParams.replaceFirst("','", "");
 			if(strPageFrom.equalsIgnoreCase("LP"))
			{
				//rs =DBUtils.executeLAPSQuery("sel_lapsapplicationparamerters^"+strParams);
				strQuery = SQLParser.getSqlQuery("sel_lapsapplicationparamerters^"+strParams+"^"+strMaxParams+"^"+strMSMEParams);
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) 
				{	
					if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("101"))
					{
						hshRecord.put("strExpirePeriod", Helper.correctNull(rs.getString("loan_paramval")));
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("102"))
					{
						hshRecord.put("strExpireIn", Helper.correctNull(rs.getString("loan_paramval")));
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("103"))
					{
						hshRecord.put("strIntDev_retail_sch", jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("loan_paramval")))));
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("105"))
					{
						hshRecord.put("strIntDev_retail_nonsch", jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("loan_paramval")))));
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("104"))
					{
						hshRecord.put("strIntDev_CorpAgri", jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("loan_paramval")))));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("106"))
					{
						hshRecord.put("strmclradhocpremium", jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("loan_paramval")))));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("107"))
					{
						hshRecord.put("strMaxDOCsize",Helper.correctNull((String)rs.getString("loan_paramval")));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("108"))
					{
						hshRecord.put("strMaxDocPrint",Helper.correctNull((String)rs.getString("loan_paramval")));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("9"))
					{
						hshRecord.put("strMSMElimit", jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("loan_paramval")))));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("10"))
					{
						hshRecord.put("strMSMEpercnt", jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("loan_paramval")))));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("KALYPTO"))
					{
						hshRecord.put("strKalypto", Helper.correctNull(rs.getString("loan_paramval")));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("109"))
					{
						hshRecord.put("strLASBankMargin", Helper.correctNull(rs.getString("loan_paramval")));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("110"))
					{
						hshRecord.put("strLASOtherMargin", Helper.correctNull(rs.getString("loan_paramval")));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("113"))
					{
						hshRecord.put("strLASPhysicalLmt", Helper.correctNull(rs.getString("loan_paramval")));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("114"))
					{
						hshRecord.put("strLASDematLmt", Helper.correctNull(rs.getString("loan_paramval")));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("115"))
					{
						hshRecord.put("strBorLmt", Helper.correctNull(rs.getString("loan_paramval")));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("116"))
					{
						hshRecord.put("strCgtInt", Helper.correctNull(rs.getString("loan_paramval")));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("117"))
					{
						hshRecord.put("strGstfee", Helper.correctNull(rs.getString("loan_paramval")));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("P001"))
					{
						hshRecord.put("strDoc", Helper.correctNull(rs.getString("loan_paramval")));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("118"))
					{
						hshRecord.put("strGoldDate", Helper.correctNull(rs.getString("loan_paramval")));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("119"))
					{
						hshRecord.put("strEduAppCnt", Helper.correctNull(rs.getString("loan_paramval")));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("120"))
					{
						hshRecord.put("strEduMort", Helper.correctNull(rs.getString("loan_paramval")));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("122"))
					{
						hshRecord.put("strLMSAvail", Helper.correctNull(rs.getString("loan_paramval")));					
						hshRecord.put("strLMSRemarks", Helper.correctNull(rs.getString("loan_paramval1")));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("123"))
					{
						hshRecord.put("strHunterScore", Helper.correctNull(rs.getString("loan_paramval")));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("124"))
					{
						hshRecord.put("strHunterPeriodicity", Helper.correctNull(rs.getString("loan_paramval")));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("125"))
					{
						hshRecord.put("strBusinessLoanAssess", Helper.correctNull(rs.getString("loan_paramval")));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("126"))
					{
						hshRecord.put("strBusinessLoanPercent", Helper.correctNull(rs.getString("loan_paramval")));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("127"))
					{
						hshRecord.put("strMithraAssessment", Helper.correctNull(rs.getString("loan_paramval")));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("128"))
					{
						hshRecord.put("strUserRestrict", Helper.correctNull(rs.getString("loan_paramval")));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("U001"))
					{
						hshRecord.put("strBranchUserCnt", Helper.correctNull(rs.getString("loan_paramval")));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("U002"))
					{
						hshRecord.put("strRLPCUserCnt", Helper.correctNull(rs.getString("loan_paramval")));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("U003"))
					{
						hshRecord.put("strROUserCnt", Helper.correctNull(rs.getString("loan_paramval")));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("U004"))
					{
						hshRecord.put("strHOUserCnt", Helper.correctNull(rs.getString("loan_paramval")));					
					}
					/*else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("129"))
					{
						hshRecord.put("strLmtBrwr", Helper.correctNull(rs.getString("loan_paramval")));					
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("130"))
					{
						hshRecord.put("strLmtNOC", Helper.correctNull(rs.getString("loan_paramval")));					
					}*/
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("131"))
					{
						hshRecord.put("strMSMEExpiry", Helper.correctNull(rs.getString("loan_paramval")));
						hshRecord.put("strMSMERemarks", Helper.correctNull(rs.getString("loan_paramval1")));
					}//VINDHYA ADDED pan check
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("132"))
					{
						hshRecord.put("strPancheck", Helper.correctNull(rs.getString("loan_paramval")));	
						System.out.println("Pancheck flag"+Helper.correctNull(rs.getString("loan_paramval")));
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("133"))
					{
						hshRecord.put("stragrilimit", Helper.correctNull(rs.getString("loan_paramval")));						
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("134"))
					{
						hshRecord.put("strcorplimit", Helper.correctNull(rs.getString("loan_paramval")));
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("135"))
					{
						hshRecord.put("strretaillimit", Helper.correctNull(rs.getString("loan_paramval")));
					}
					else if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("136"))
					{
						hshRecord.put("stragrilimit2", Helper.correctNull(rs.getString("loan_paramval")));
					}
					//VINDHYA ADDED pan check
					else
					{
						hshRecord.put("strSOCParam"+Helper.correctNull(rs.getString("loan_paramslno")), Helper.correctNull(rs.getString("loan_paramval")));
						hshRecord.put("strMaxParam"+Helper.correctNull(rs.getString("loan_paramslno")), Helper.correctNull(rs.getString("LOAN_PARAMVAL1")));
						hshRecord.put("strParam"+Helper.correctNull(rs.getString("loan_paramslno")), Helper.correctNull(rs.getString("LOAN_PARAMVAL2")));
					}
						
				}
			}
			else
			{
				rs =DBUtils.executeLAPSQuery("sel_otherparameters1");
				while (rs.next()) 
				{	
					recordflag=true;
					vecRec2=new ArrayList();
					vecRec2.add(correctNull(rs.getString("stat_data_sno")));
					vecRec2.add(correctNull(rs.getString("stat_data_desc1")));					
					vecRec2.add(correctNull(rs.getString("loan_paramslno")));
					if(correctNull(rs.getString("loan_paramval")).equalsIgnoreCase("0"))
					{
						vecRec2.add("");
					}
					else
					{
						vecRec2.add(correctNull(rs.getString("loan_paramval")));
					}
					vecData2.add(vecRec2);
				}	
				if(rs!=null)
				{
					rs.close();
				}
				rs =DBUtils.executeLAPSQuery("sel_otherparamerters");
				while (rs.next()) 
				{
					vecRec2 = new ArrayList();
					vecRec2.add(correctNull(rs.getString("STAT_DATA_SNO")));
					vecRec2.add(correctNull(rs.getString("STAT_DATA_DESC1")));
					vecRec2.add("");
					vecRec2.add("");
					vecData2.add(vecRec2);
				}				
				hshRecord.put("vecData2",vecData2);
				if(recordflag)
					hshRecord.put("recordflag","Y");
				else
					hshRecord.put("recordflag","N");
			}
 							
			hshRecord.put("arrRow1",arrRow1);
			
		} 
		catch (Exception e) 
		{
			throw new EJBException(e.getMessage());
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
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	public HashMap getMCLRMSMEmasterdata(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		ResultSet rs = null;
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = new ArrayList();
		
		try
		{
			strQuery = SQLParser.getSqlQuery("sel_mclrmsmemastervalues");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("mclrmsme_SNO")));
				arrCol.add(Helper.correctNull((String)rs.getString("mclrmsme_amt_FROM")));
				arrCol.add(Helper.correctNull((String)rs.getString("mclrmsme_amt_TO")));
				arrCol.add(Helper.correctNull((String)rs.getString("mclrmsme_int_rate")));
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow", arrRow);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getmclrmsmemasterdata == "+e.toString());
		}
		return hshRecord;
	}
	
	public void updateMCLRMSMEmasterdata(HashMap hshValues) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshQry = new HashMap();
		ArrayList arrVal = new ArrayList();
		
		String strAction="",strQuery="",strMaxId="";
		ResultSet rs = null;
		try
		{
			strAction = Helper.correctNull((String)hshValues.get("hidAction"));
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{
				if(strAction.equalsIgnoreCase("insert"))
				{
					strQuery = SQLParser.getSqlQuery("sel_mclrmsmemaster_maxid");
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strMaxId = Helper.correctInt((String)rs.getString("maxid"));
						hshQry.put("strQueryId","ins_mclrmsmemasterdata");
					}
				}
				else if(strAction.equalsIgnoreCase("update"))
				{
					strMaxId = Helper.correctNull((String)hshValues.get("txt_selID"));
					hshQry.put("strQueryId","upd_mclrmsmemasterdata");
				}
				
				hshqueryval.put("size","1");
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_amtfrom")));	
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_amtto")));				
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_intrate")));
				arrVal.add(Helper.correctNull((String)hshValues.get("strUserId")));
				arrVal.add(strMaxId);
				hshQry.put("arrValues",arrVal);							
				hshqueryval.put("1",hshQry);
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshqueryval.put("size","1");
				hshQry.put("strQueryId","del_mclrmsmemasterdata");
				arrVal.add(strMaxId);
				hshQry.put("arrValues",arrVal);							
				hshqueryval.put("1",hshQry);
			}
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getmclrmsmemasterdata == "+e.toString());
		}
	}
	
	public HashMap getnpaprovcoverpercnt(HashMap hshValues)  
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();		
		String strQuery = "";
		
		try 
		{			
			strQuery = SQLParser.getSqlQuery("sel_npaprovmaster");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(Helper.correctNull((String)rs.getString("NPA_SNO")).equalsIgnoreCase("1")){
					hshRecord.put("txt_ss_sec", Helper.correctNull((String)rs.getString("SEC_PERCNT")));
					hshRecord.put("txt_ss_unsec", Helper.correctNull((String)rs.getString("UNSEC_PERCNT")));}
				if(Helper.correctNull((String)rs.getString("NPA_SNO")).equalsIgnoreCase("2")){
					hshRecord.put("txt_ds1_sec", Helper.correctNull((String)rs.getString("SEC_PERCNT")));
					hshRecord.put("txt_ds1_unsec", Helper.correctNull((String)rs.getString("UNSEC_PERCNT")));}
				if(Helper.correctNull((String)rs.getString("NPA_SNO")).equalsIgnoreCase("3")){
					hshRecord.put("txt_ds2_sec", Helper.correctNull((String)rs.getString("SEC_PERCNT")));
					hshRecord.put("txt_ds2_unsec", Helper.correctNull((String)rs.getString("UNSEC_PERCNT")));}
				if(Helper.correctNull((String)rs.getString("NPA_SNO")).equalsIgnoreCase("4")){
					hshRecord.put("txt_ds3_sec", Helper.correctNull((String)rs.getString("SEC_PERCNT")));
					hshRecord.put("txt_ds3_unsec", Helper.correctNull((String)rs.getString("UNSEC_PERCNT")));}
				if(Helper.correctNull((String)rs.getString("NPA_SNO")).equalsIgnoreCase("5")){
					hshRecord.put("txt_loss_sec", Helper.correctNull((String)rs.getString("SEC_PERCNT")));
					hshRecord.put("txt_loss_unsec", Helper.correctNull((String)rs.getString("UNSEC_PERCNT")));}
				if(Helper.correctNull((String)rs.getString("NPA_SNO")).equalsIgnoreCase("6")){
					hshRecord.put("txt_ab_sec", Helper.correctNull((String)rs.getString("SEC_PERCNT")));
					hshRecord.put("txt_ab_unsec", Helper.correctNull((String)rs.getString("UNSEC_PERCNT")));}
			}
		} 
		catch (Exception e) 
		{
			throw new EJBException(e.getMessage());
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
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	public void updateInstructions(HashMap hshValues) 
	{	
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues ;
		
		ResultSet rs=null;	
		String strAction=null;
		String strsno = null;	
		String strInstructions=null;	
		String strTilldate="";
		String strUserID ="";
		String strBullId="";
		try
		{
			
			strAction =correctNull((String)hshValues.get("hidAction"));
			strsno = correctNull((String)hshValues.get("hidsno"));
			strInstructions = correctNull((String)hshValues.get("txr_Instructions"));
			strTilldate= correctNull((String)hshValues.get("txt_dateupto"));
			strUserID = correctNull((String)hshValues.get("strUserId"));
			if(strAction.equals("New"))
			{	
				rs = DBUtils.executeLAPSQuery("max_bullet_info");
				
				while(rs.next())
				{	
					strBullId = rs.getString("maxid");
				}
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","ins_bull_mast");
				arrValues=new ArrayList();
				arrValues.add(strBullId);
				arrValues.add(strInstructions);
				arrValues.add(strTilldate);
				arrValues.add(strUserID);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("Edit"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","upd_bull_mast");
				arrValues=new ArrayList();	
				arrValues.add(strInstructions);
				arrValues.add(strTilldate);
				arrValues.add(strUserID);
				arrValues.add(strsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}		
			else if(strAction.equals("Delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","del_bull_mast");
				arrValues=new ArrayList();			
				arrValues.add(strsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}						
			
			
			
			//AuditTrial.auditLog(hshValues,"97","",sbAuditTrial.toString());
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

	public HashMap getInstructionsData(HashMap hshRequestValues) 
	{
		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
		String strsno="";
		try
		{		
			
			strsno=correctNull((String)hshRequestValues.get("hidsno"));
			if(strsno.equalsIgnoreCase(""))
		    {
		    	strsno="0";
			}
			rs = DBUtils.executeLAPSQuery("sel_bull_mast_values");
			
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString("bull_id")));
				vecCol.add(correctNull(rs.getString("bull_desc")));
				String date = correctNull(rs.getString("bull_disp_upto"));
				if(date.trim().equals("01/01/1900"))
				{
					date = "";
					vecCol.add(date);
				}
				else
				{
					vecCol.add(date);
				}
				vecCol.add(correctNull(rs.getString("bull_cdate")));
				vecCol.add(correctNull(rs.getString("bull_createdby")));
				vecRow.add(vecCol);	
			}
				
			hshRecord.put("vecRow",vecRow);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
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
	
	public void updategeneralinfoData(HashMap hshValues)
	{		 
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();	 
		ArrayList arrValues = new ArrayList();
		
		ResultSet rs = null;
		ResultSet rs1 = null;
	 	String strAction = null;		 
		String strslno = "";
		String strPrdID = "";
		String strQuestion = "";
		String strDescription = "";
		StringBuilder sbolddata = new StringBuilder();
		StringBuilder sbAt=new StringBuilder();
		String strKeyId = "";
		try
		{
			strAction = correctNull((String)hshValues.get("hidAction"));
			strslno	= correctNull((String )hshValues.get("hidsno"));
			strPrdID = correctNull((String)hshValues.get("hid_ProductID"));
			strQuestion = (correctNull((String)hshValues.get("txt_question"))).toUpperCase();
			strDescription = correctNull((String)hshValues.get("txt_comments")).toUpperCase();	
			String strsno	= correctNull((String )hshValues.get("hidsno"));
			String module = correctNull((String )hshValues.get("prd_type"));
			String SelectType = correctNull((String )hshValues.get("sel_active"));
			
			if(module.equalsIgnoreCase("p")){
				module ="Retail Products ";
			}else if(module.equalsIgnoreCase("a")){
				module ="Agriculture Products";
			}else{
				module ="";
			}
			
			if(strAction.equalsIgnoreCase("Edit") || strAction.equalsIgnoreCase("delete"))
			{
				rs =DBUtils.executeLAPSQuery("sel_generalinfo^"+strPrdID+"^"+strsno);
				if(rs.next())
				{	
					sbolddata.append("~ Module = "+module);
					sbolddata.append("~ Product = "+Helper.correctNull((String)rs.getString("prd_desc")));
					sbolddata.append("~ Question = "+Helper.correctNull((String)rs.getString("gene_question")));
				}
				if(rs!=null)
					rs.close();
			}
			if(strAction.equalsIgnoreCase("Edit") || strAction.equalsIgnoreCase("New"))
			{
				sbAt.append("~ Module = "+module);
				rs =DBUtils.executeLAPSQuery("setproductssel^"+strPrdID);
				if(rs.next())
				{
					sbAt.append("~ Product = "+Helper.correctNull((String)rs.getString("prd_desc")));
				}
				else
				{
					sbAt.append("~ Product Code = "+Helper.correctNull((String)hshValues.get("hid_ProductID")));
				}
				if(rs!=null)
					rs.close();
				sbAt.append("~ Question = "+Helper.correctNull((String)hshValues.get("txt_question")).toUpperCase());
			}
			if (strAction.equalsIgnoreCase("New"))
			{
				strAction="insert";			
			}
			else if(strAction.equalsIgnoreCase("Edit"))
			{
				strAction="update";		
			}
			hshValues.put("strAction", strAction);
			AuditTrial.auditNewLog(hshValues,"348",strKeyId,sbAt.toString(),sbolddata.toString());
			if (strAction.equalsIgnoreCase("insert"))
			{
				rs1 = DBUtils.executeLAPSQuery("max_generalinfo^"+strPrdID);
				
				
				while(rs1.next())
				{	
					strslno = rs1.getString("maxid");
				}					
				arrValues.add(strPrdID);
				arrValues.add(strslno);
				arrValues.add(strQuestion);
				arrValues.add(strDescription);
				arrValues.add(SelectType);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_generalinfo");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}			
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();				
				arrValues.add(strQuestion);
				arrValues.add(strDescription);
				arrValues.add(SelectType);
				arrValues.add(strPrdID);
				arrValues.add(strslno);
			    hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upd_generalinfo");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}	
			
			else if(strAction.equalsIgnoreCase("delete"))
			
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","del_generalinfo");
				arrValues.add(strPrdID);
				arrValues.add(strsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}			
		}
		catch (Exception ce)
		{
			throw new EJBException("Error on found in u'r bean <-- "+ce.toString());
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
	}
	
	public HashMap getgeneralinfoData(HashMap hshValues) 
	{		
		String strQuery="";
 		ResultSet rs = null;
 		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();
		String strAction = null;
		boolean recordflag=false;
		try
		{
			
			strAction   = "";			
			String strsno	= correctNull((String )hshValues.get("hidsno"));
			String strPrdcode = correctNull((String)hshValues.get("hid_ProductID"));
			String sel_productID = correctNull((String)hshValues.get("sel_productID"));
			String prdtype=correctNull((String)hshValues.get("prdtype"));
			if(prdtype.equalsIgnoreCase(""))
			{
				prdtype=correctNull((String)hshValues.get("prd_type"));
			}
			if(prdtype.equalsIgnoreCase(""))
			{
				prdtype="p";
			}
			if(strPrdcode.equalsIgnoreCase(""))
			{
				strPrdcode="0";
			}
			if(strAction.trim().equals("New"))
			{
				rs = DBUtils.executeLAPSQuery("max_generalinfo1^"+strPrdcode);				
				
				while(rs.next())
				{	
					strsno = rs.getString("maxid");
					strAction="Edit";
				}
			}		
			if((strsno.trim().equals("")))
			{
				strsno="0";
			}
 			if(strAction.equalsIgnoreCase("Edit")||strAction.equalsIgnoreCase("Cancel"))
			{
				if(!strsno.equalsIgnoreCase(""))
				{
					strQuery = SQLParser.getSqlQuery("sel_generalinfo^"+strPrdcode+"^"+strsno);
					rs =DBUtils.executeQuery(strQuery);				
					if(rs.next())
					{	
						recordflag=true;
						hshRecord.put("prd_code",(correctNull(rs.getString("prd_code"))));
						hshRecord.put("gene_slno",(correctNull(rs.getString("gene_slno"))));
						hshRecord.put("gene_question",(correctNull(rs.getString("gene_question"))).toUpperCase());
						hshRecord.put("gene_info_desc",(correctNull(rs.getString("gene_info_desc"))));
						
						String prd_code=correctNull(rs.getString("prd_code"));
						if(!prd_code.equalsIgnoreCase("")) 					
						{
							rs1 = DBUtils.executeLAPSQuery("sel_generalInfoproducts1^"+prd_code);
							
							if(rs1.next())
							{
								String category=correctNull((String)rs1.getString("category"));
								String subcategory=correctNull((String)rs1.getString("subcategory"));
								String rangefrom=correctNull((String)rs1.getString("rangefrom"));
								String rangeto=correctNull((String)rs1.getString("rangeto"));
								String Product=category+" - "+subcategory+" - "+rangefrom+" - "+rangeto;
								hshRecord.put("Product",Product);
							}
							else
							{
								hshRecord.put("Product","");
							}						
							if(rs1!=null)
							{
								rs1.close();
							}
						}
						else
						{
							hshRecord.put("Product","");
						}						
					}
					if(rs!=null)
					{
						rs.close();
					}
				}
			}		
			if(!strAction.equalsIgnoreCase("Onload") && !sel_productID.equalsIgnoreCase("0"))
			{
				rs = DBUtils.executeLAPSQuery("sel_generalinfoall^"+strPrdcode);
				
				while(rs.next())
				{
					recordflag=true;
					vecCol = new ArrayList();
					vecCol.add(correctNull(rs.getString(1)));					
					vecCol.add(correctNull(rs.getString(2)));					
					vecCol.add(correctNull(rs.getString(3)));
					vecCol.add(correctNull(rs.getString(4)));
					vecCol.add(correctNull(rs.getString(5)));
					String prd_code=correctNull(rs.getString("prd_code"));
					if(!prd_code.equalsIgnoreCase("")) 					
					{
						rs1=DBUtils.executeLAPSQuery("sel_generalInfoproducts1^"+prd_code);
						
						if(rs1.next())
						{
							String category=correctNull((String)rs1.getString("category"));
							String subcategory=correctNull((String)rs1.getString("subcategory"));
							String rangefrom=correctNull((String)rs1.getString("rangefrom"));
							String rangeto=correctNull((String)rs1.getString("rangeto"));
							String Product=category+" - "+subcategory+" - "+rangefrom+" - "+rangeto;
							vecCol.add(Product);
						}
						else
						{
							vecCol.add("");
						}						
						if(rs1!=null)
						{
							rs1.close();
						}
					}
					else
					{
						vecCol.add("");
					}
					vecRow.add(vecCol);
				}
			}
			hshRecord.put("vecRow",vecRow);
			hshRecord.put("strPrdcode",strPrdcode);
			hshRecord.put("sel_productID",sel_productID);
			hshRecord.put("prdtype",prdtype);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
			if(rs!=null)
			{
				rs.close();
			}			
		}		
		catch(Exception ce)
		{
			throw new EJBException("Error in getgeneralinfo "+ce.toString());
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
	
	public void updateReject(HashMap hshValues)
	{		
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();	 
		ArrayList arrValues = new ArrayList();
		
		ResultSet rs = null;
		ResultSet rs1 = null;
	 	String strAction = null;		 
		String strappno = "";
		String strslno = null;

		try
		{	
			
			strAction   = (String)hshValues.get("hidAction");
			strslno= (String)hshValues.get("txt_usrid");
			strappno=(String)hshValues.get("appno");	
			int intUpdatesize=0;
			hshQueryValues.put("1",hshQuery);
			int len=0;
			String []slno=null;
			if (strAction.equalsIgnoreCase("apply"))
			{  
				hshQuery.put("strQueryId","del_reject");				
				arrValues.add(strappno);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				if(!strslno.equals("")){
					len=strslno.split(",").length;
					slno=strslno.split(",");
					for(int k=0;k<len;k++)
					{				
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize=intUpdatesize+1;
						arrValues.add(correctNull(strappno));
						arrValues.add(correctNull((String)slno[k]));
						hshQuery.put("arrValues",arrValues);
						hshQuery.put("strQueryId","ins_reject");
						hshQueryValues.put("size","1");
						hshQueryValues.put("1",hshQuery);			
				  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}	
				}
			}		
		}
		catch (Exception ce)
		{
			throw new EJBException("Error on found in u'r bean <-- "+ce.toString());
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
	}
	
	
//	public HashMap getBankReferenceList(HashMap hshValues) 
//	{
// 		ResultSet rs = null;
//		HashMap hshRecord = new HashMap();
//		ArrayList vecCol		= new ArrayList();
//		ArrayList vecRow		= new ArrayList();
//		String strOrgCode = "";
//		try
//		{
//			strOrgCode   = correctNull((String)hshValues.get("strOrgCode"));
//				
//			rs = DBUtils.executeLAPSQuery("sel_app_history^"+strOrgCode);				
//					
//			while(rs.next())
//			{
//				vecRow = new ArrayList();
//				vecRow.add(rs.getString(1));
//				vecRow.add(rs.getString(2));
//				vecRow.add(rs.getString(3));
//				vecCol.add(vecRow);
//			}
//			hshRecord.put("vecCol",vecCol);		
//		}
//		catch(Exception ce)
//		{
//			throw new EJBException("Error in getBranchReferenceList "+ce.toString());
//		}
//		finally
//		{
//			try
//			{
//				if(rs != null)
//				{
//					rs.close();
//				}				
//				
//			}
//			catch(Exception cf)
//			{
//				throw new EJBException("Error closing the connection "+cf.getMessage());						
//			}
//		}
//		return hshRecord;
//	}	
	public HashMap getState(HashMap hshValues)
	{		 
		ResultSet rs=null;
		HashMap hshRecord=null;
		String strQuery = null;
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = null;
			
		try
		{			
			strQuery=SQLParser.getSqlQuery("getstatetype1");
			rs =DBUtils.executeQuery(strQuery);
       
			while(rs.next())
			{				
				arrCol = new ArrayList();
				arrCol.add(correctNull((String)rs.getString(1)));
				arrCol.add(correctNull((String)rs.getString(2)));
				arrCol.add(correctNull((String)rs.getString("state_code")));
				arrCol.add(correctNull(rs.getString("state_action")));
				arrRow.add(arrCol);
			}
			hshRecord = new HashMap();
			arrCol = new ArrayList();
			hshRecord.put("arrRow",arrRow);
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
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
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
		return hshRecord;
	}
	public HashMap getState1(HashMap hshValues)
	{		 
		ResultSet rs=null;
		HashMap hshRecord=null;
		String strQuery = null;
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = null;
			
		try
		{			
			strQuery=SQLParser.getSqlQuery("getstatetype1");
			rs =DBUtils.executeQuery(strQuery);
       
			while(rs.next())
			{				
				arrCol = new ArrayList();
				arrCol.add(correctNull((String)rs.getString(1)));
				arrCol.add(correctNull((String)rs.getString(2)));
				arrRow.add(arrCol);
			}
			hshRecord = new HashMap();
			arrCol = new ArrayList();
			hshRecord.put("arrRow",arrRow);
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
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
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
		return hshRecord;
	}
	public void updateDistrictMasterData(HashMap hshValues)
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshQry = new HashMap();
		ArrayList arrVal = new ArrayList();
		
		ResultSet rs=null;
		String getMaxGradeId = "",strStatId="";		
		String hidslno="";
		String action = (String)hshValues.get("hidAction");
		strStatId = correctNull((String)hshValues.get("sel_state"));
		hidslno = correctNull((String)hshValues.get("hidsno"));
		String strExp="$";
		String strKeyId = "";
		StringBuilder sbolddata = new StringBuilder();
		try
		{		
			if(action.equalsIgnoreCase("update") || action.equalsIgnoreCase("delete"))
			{
				rs = DBUtils.executeLAPSQuery("sel_districtmaster_audit^"+strStatId+"^"+hidslno);
				if(rs.next())
				{
					sbolddata.append("~ State = "+Helper.correctNull((String)hshValues.get("sel_state1")));
					sbolddata.append("~ District Code = "+Helper.correctNull((String)rs.getString("district_code")));
					sbolddata.append("~ District = "+Helper.correctNull((String)rs.getString("district_desc")));
				}
				if(rs!=null)
					rs.close();
			}
			if(action.equalsIgnoreCase("insert"))
			{
				if(checkdistrictavailability(hshValues))
				{
					String qry="sel_max_districtid^";
					getMaxGradeId = Integer.toString(getMaxGradeId(strStatId,qry));				
					hshqueryval.put("size","1");
					hshQry.put("strQueryId","ins_district_master");
					arrVal.add(strStatId);
					arrVal.add(correctNull((String)hshValues.get("txt_districtcode")));
					arrVal.add(correctNull((String)hshValues.get("txt_district")));
					arrVal.add(getMaxGradeId);
					arrVal.add(correctNull((String)hshValues.get("sel_active")));
					hshQry.put("arrValues",arrVal);							
					hshqueryval.put("1",hshQry);
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				}
				else
				{
					strExp=strExp+"District Code Exists";
					throw new EJBException(strExp);
				}
			}
			else if(action.equalsIgnoreCase("update"))
			{
				if(checkdistrictavailability(hshValues))
				{
					hshqueryval.put("size","1");
					hshQry.put("strQueryId","upd_district_master");
					arrVal.add(correctNull((String)hshValues.get("txt_district")));
					arrVal.add(correctNull((String)hshValues.get("txt_districtcode")));
					arrVal.add(correctNull((String)hshValues.get("sel_active")));
					arrVal.add(strStatId);
					arrVal.add(hidslno);
					hshQry.put("arrValues",arrVal);							
					hshqueryval.put("1",hshQry);
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				}
				else
				{
					strExp=strExp+"District Code Exists";
					throw new EJBException(strExp);
				}
			}
			else if(action.equalsIgnoreCase("delete"))
			{
				hshqueryval.put("size","1");
				hshQry.put("strQueryId","del_district_master");
				arrVal.add(strStatId);
				arrVal.add(hidslno);
				hshQry.put("arrValues",arrVal);							
				hshqueryval.put("1",hshQry);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			
			StringBuilder sbAuditTrial=new StringBuilder();
			sbAuditTrial.append("State  =").append(correctNull((String )hshValues.get("sel_state1")))
			.append("~ District Code  =").append(correctNull((String )hshValues.get("txt_districtcode"))).append("~ District =").append(correctNull((String )hshValues.get("txt_district")));
			if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
				hshValues.put("hidAction", "update");
			AuditTrial.auditNewLog(hshValues,"139",strKeyId,sbAuditTrial.toString(),sbolddata.toString());
		}
		catch (Exception e)
		{
			throw new EJBException("Error in bean "+e.toString());
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
	
	
	private boolean checkdistrictavailability(HashMap hshValues) 
	{
		boolean boolresult=true;
		String strDistrictCode=correctNull((String)hshValues.get("txt_districtcode"));
		String strDistrictsrno=correctNull((String)hshValues.get("hidsno"));
		String strQuery="";
		ResultSet rs=null;
		try
		{
			if(strDistrictsrno.equals(""))
			{
				strQuery=SQLParser.getSqlQuery("checkdistrictcode^"+strDistrictCode+"^ ");
			}
			else
			{
				strQuery=SQLParser.getSqlQuery("checkdistrictcode^"+strDistrictCode+"^ and district_srno!="+strDistrictsrno);
			}
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolresult=false;
			}
		}catch(Exception ex)
		{
			throw new EJBException("Error in checkdistrictavailability :: "+ex.toString());
		}
		return boolresult;
	}
	
	public HashMap getDistrictMasterList(HashMap hshValues) 
	{			
		//String strQuery="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord =new HashMap();
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
		String strAction="",str_pagename="";
		String strQuery="";
		String strDistrictCode="";
		boolean recordflag=false; 
		try
		{
			String strStatId = "";
			strStatId = correctNull((String)hshValues.get("strStatId"));
			strAction=correctNull((String)hshValues.get("hidAction"));
			strDistrictCode=correctNull((String)hshValues.get("txt_districtcode"));
			str_pagename = Helper.correctNull((String)hshValues.get("strfrom"));
			
			if(strStatId.trim().equalsIgnoreCase(""))
			{
				strStatId = "0";
				
			}
			if(strAction.equals("insert") || strAction.equals("update"))
			{
				strQuery=SQLParser.getSqlQuery("sel_districtmaster^"+strDistrictCode);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("sel_state",correctNull(rs.getString("state_code")));
					hshRecord.put("districtsrno",correctNull(rs.getString("district_srno")));
					hshRecord.put("districtcode",correctNull(rs.getString("district_code")));
					hshRecord.put("district",correctNull(rs.getString("district_desc")));
					hshRecord.put("district_action",correctNull(rs.getString("district_active")));
				}
			}
			else
			{	
				if(!str_pagename.equalsIgnoreCase(""))
				{
				rs = DBUtils.executeLAPSQuery("sel_district_master^"+strStatId);
				}
				else{
					rs = DBUtils.executeLAPSQuery("sel_district_master_enable^"+strStatId);
				}
				while(rs.next())
				{
					recordflag=true;
					vecCol = new ArrayList();
					vecCol.add(correctNull(rs.getString("state_code")));
					/*String statename = "";
					if(!strStatId.equalsIgnoreCase(""))
					{
						strQuery = SQLParser.getSqlQuery("selstatecode^"+strStatId);
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							statename = correctNull((String)rs1.getString(1));
						}
					}
					if(rs1!=null)
						rs1.close();*/
					vecCol.add(correctNull(rs.getString("district_srno")));
					vecCol.add(correctNull(rs.getString("district_code")));
					vecCol.add(correctNull(rs.getString("district_desc")));
					vecCol.add(correctNull(rs.getString("district_active")));
					//vecCol.add(statename);
					
					vecRow.add(vecCol);							
				}	
			
				hshRecord.put("vecRow",vecRow);
				hshRecord.put("strStatId",strStatId);
				if(recordflag)
					hshRecord.put("recordflag","Y");
				else
					hshRecord.put("recordflag","N");
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
	
	
	public  HashMap getFinanceData(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs3 = null;
		HashMap hshRecord = new HashMap();
		ArrayList arrData = new ArrayList();
		ArrayList arrVal=new ArrayList();
		String strCropType="";
		String strCropName="";
		String strSeasonType="";
		String strSeasonName="";
		String strScaleoffin="",strSOFType="";
		try
		{
			String strStatId = correctNull((String)hshValues.get("sel_state"));
			strSOFType=correctNull((String)hshValues.get("sel_type"));
			if(strStatId.trim().equalsIgnoreCase(""))
			{
				strStatId = "0";
			}
			String hidslno = correctNull((String)hshValues.get("hidsno"));
			if(hidslno.trim().equalsIgnoreCase(""))
			{
				hidslno = "0";
			}
			
			if(strSOFType.equalsIgnoreCase("130"))
				strQuery = SQLParser.getSqlQuery("agrscaleoffinance_select^"+strStatId+"^"+hidslno);
			else
				strQuery = SQLParser.getSqlQuery("sel_agrscaleoffinance^"+strSOFType);
			rs2 = DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				arrVal = new ArrayList();
				arrVal.add(correctNull(rs2.getString("agr_sof_state")));//0
				String statecode = correctNull(rs2.getString("agr_sof_state"));
				String statename = "";
				if(!statecode.equalsIgnoreCase(""))
				{
					strQuery = SQLParser.getSqlQuery("selstatecode^"+statecode);


					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						statename = correctNull((String)rs1.getString(1));
					}
				}
				if(rs1!=null)
					rs1.close();
				
				arrVal.add(correctNull(rs2.getString("agr_sof_district")));//1
				String districtcode = correctNull(rs2.getString("agr_sof_district"));
				String districtname="";
				if(!statecode.equalsIgnoreCase("") && !districtcode.equalsIgnoreCase(""))
				{
					strQuery = SQLParser.getSqlQuery("sel_district_name^"+statecode+"^"+districtcode);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						districtname = Helper.correctNull((String)rs1.getString("district_desc"));
					}
				}	
				strCropType=correctNull(rs2.getString("agr_sof_crop"));
				arrVal.add(correctNull(rs2.getString("agr_sof_crop")));//2
				arrVal.add(correctNull(rs2.getString("agr_sof_sno")));//3
				arrVal.add(districtname);//4
				arrVal.add(statename);//5
				arrVal.add(correctNull(rs2.getString("agr_sof_type")));//6	
				arrVal.add(correctNull(rs2.getString("agr_sof_amount")));//7
				arrVal.add(correctNull(rs2.getString("agr_sof_fromdate")));//8
				arrVal.add(correctNull(rs2.getString("agr_sof_todate")));//9
				strSeasonType=correctNull(rs2.getString("agr_sof_type")); //10
			
				
				if(!strSeasonType.equalsIgnoreCase(""))
				{
					if(rs3 !=null)
					{
						rs3.close();
					}
					rs3=DBUtils.executeLAPSQuery("getstaticdatavaldispcorporate1^"+"131"+'^'+strSeasonType);
					if(rs3.next())
					{
						strSeasonName=Helper.correctNull((String)rs3.getString("stat_data_desc1"));
					}
				}
				arrVal.add(strSeasonName);//11
				strSeasonName="";
				
				if(rs3 !=null)
				{
					rs3.close();
				}
				rs3=DBUtils.executeLAPSQuery("getstaticdatavaldispcorporate1^"+strSOFType+'^'+strCropType);
				if(rs3.next())
				{
					strCropName=Helper.correctNull((String)rs3.getString("stat_data_desc1"));
				}
				arrVal.add(strCropName);//12
				arrVal.add(Helper.correctInt(((String)rs2.getString("agr_sof_plants"))));//13
				strScaleoffin=Helper.correctInt(((String)rs2.getString("agr_sof_sofperplant")));
				arrVal.add(strScaleoffin);//14
				arrVal.add(Helper.correctInt(((String)rs2.getString("agr_type"))));//15
				strCropName="";
				arrData.add(arrVal);		
	
			}	
			hshRecord.put("sel_state",correctNull((String)hshValues.get("sel_state")));
			hshRecord.put("txt_district",correctNull((String)hshValues.get("txt_district")));
			hshRecord.put("txt_districtcode",correctNull((String)hshValues.get("txt_districtcode")));
	    	hshRecord.put("arrData",arrData);
	    	hshRecord.put("strStatId",strStatId);
	    	hshRecord.put("hidslno",hidslno);
	    	hshRecord.put("strScaleoffin",strScaleoffin);
	    	hshRecord.put("strSOFType",strSOFType);
		}
		catch(Exception ce)
		{
			ce.printStackTrace();
			throw new EJBException("Error in getFinanceData "+ce.toString());
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
		return hshRecord;
	}		
		
	
	private int getMaxGradeId1(String strStatId,String hidslno,String strType)
	{
		
		String strQuery="";
		ResultSet rs = null;
		int termId = 0;

		try
		{	
			
			if(strType.equalsIgnoreCase("130"))
			{
				strQuery = SQLParser.getSqlQuery("agrscaleoffinancemaxid_sel^"+strStatId+"^"+hidslno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					if(rs.getString(1) != null)
					{
						termId = Integer.parseInt(rs.getString(1)) + 1;
					}
					else
					{
						termId = 1;
					}
				}
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("sel_maxagrscaleoffinanceid^"+strType);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					termId = Integer.parseInt(rs.getString(1)) + 1;
				}
			}
			rs.close();			
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
		return termId;
	}
	
	public HashMap getDistrictMasterList1(HashMap hshValues) 
	{			
		String strQuery="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord =new HashMap();
		ArrayList vecCol1		= new ArrayList();
		ArrayList vecRow1		= new ArrayList();	
		String strStatId = "";
		
		try
		{	
		
			strStatId = correctNull((String)hshValues.get("strStatId"));
			
			if(strStatId.trim().equalsIgnoreCase(""))
			{
				strStatId = correctNull((String)hshValues.get("strStatId1"));
			}
			rs = DBUtils.executeLAPSQuery("sel_district_master^"+strStatId);		
			while(rs.next())
			{
				vecCol1 = new ArrayList();
				vecCol1.add(correctNull(rs.getString(1)));
				String statename = "";
				if(!strStatId.equalsIgnoreCase(""))
				{
					strQuery = SQLParser.getSqlQuery("getstatetype1^"+strStatId);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						statename = correctNull((String)rs1.getString("state_name"));
					}
				}
				if(rs1!=null)
					rs1.close();
				vecCol1.add(correctNull(rs.getString(2)));
				vecCol1.add(correctNull(rs.getString("district_desc")));
				vecCol1.add(correctNull(rs.getString("district_active")));
				vecCol1.add(statename);
				vecRow1.add(vecCol1);							
			}	
			hshRecord.put("vecRow1",vecRow1);
			hshRecord.put("strStatId",strStatId);
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
	
	public void updateFinanceData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strGradeId = "";
		ResultSet rs = null;
		String strStatId="";		
		String hidslno="",distCode="";
		strStatId = correctNull((String)hshValues.get("sel_state"));
		String strStatId1=correctNull((String)hshValues.get("strStatId1"));
		hidslno = correctNull((String)hshValues.get("hidsno")); //District
		String txt_finance=Helper.correctNull((String )hshValues.get("txt_finance"));
		String txt_date = Helper.correctNull((String)hshValues.get("txt_date"));
		if(txt_date.equalsIgnoreCase(""))
	    {
			txt_date="01/01/1900";
	    }
		try
		{
			if(strAction.equals("update"))
			{
				strGradeId =  correctNull((String )hshValues.get("selsno"));				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				arrValues=new ArrayList();
				if(Helper.correctNull((String)hshValues.get("sel_type")).equalsIgnoreCase("130"))
					hshQuery.put("strQueryId","agrscaleoffinance_update");	
				else
					hshQuery.put("strQueryId","agrscaleoffinance_update1");
				
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_crop")));
				if(txt_finance.equalsIgnoreCase(""))
				{
					 txt_finance="0.00";
				}
				arrValues.add(txt_finance);
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_fromdate")));
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_todate")));
				arrValues.add(Helper.correctNull((String )hshValues.get("type")));				
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_noofplants")));
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_scaleoffinperplant")));
				
				if(strStatId.equalsIgnoreCase(""))
				{
					arrValues.add(strStatId1);
				}
				else
				{
					arrValues.add(strStatId);	
				}
				arrValues.add(hidslno);
				arrValues.add(strGradeId);
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_type")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);			
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.trim().equals("insert"))
			{	
				strGradeId = Integer.toString(getMaxGradeId1(strStatId,hidslno,Helper.correctNull((String)hshValues.get("sel_type"))));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");	
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agrscaleoffinance_insert");	
				if(Helper.correctNull((String)hshValues.get("sel_type")).equalsIgnoreCase("130"))
				{
					arrValues.add(strStatId);//1
					arrValues.add(hidslno);//2
				}
				else
				{
					arrValues.add("");
					arrValues.add("");
				}
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_crop")));//3
				if(Helper.correctNull((String )hshValues.get("txt_finance")).equals(""))
				{
					arrValues.add("0");//5		
				}
				else
				{
					arrValues.add(Helper.correctNull((String )hshValues.get("txt_finance")));//5		
				}
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_fromdate")).trim());//8
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_todate")).trim());//9
				arrValues.add(strGradeId);//10
				arrValues.add(Helper.correctNull((String )hshValues.get("type")));//11
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_noofplants")));//14
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_scaleoffinperplant")));//15
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_type")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);			
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("delete"))
			{
				strGradeId =  correctNull((String )hshValues.get("selsno"));
				strStatId=  correctNull((String )hshValues.get("strStatId1"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				
				if(Helper.correctNull((String)hshValues.get("sel_type")).equalsIgnoreCase("130"))
				{
					hshQuery.put("strQueryId","agrscaleoffinance_delete");	
					arrValues.add(strStatId);
					arrValues.add(hidslno);
				}
				else
				{
					hshQuery.put("strQueryId","agrscaleoffinance_delete1");
				}
				
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_type")));
				arrValues.add(strGradeId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch(Exception ce)
		{
			ce.printStackTrace();
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
	
	
	public HashMap  getaccountheld1(HashMap hshValues)
	{		 
		ResultSet rs=null;
		HashMap hshRecord=null;
		String strQuery = null;
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = null;
			
		try
		{				
			strQuery=SQLParser.getSqlQuery("getaccountheld");
			rs =DBUtils.executeQuery(strQuery);
       
			while(rs.next())
			{				
				arrCol = new ArrayList();
				arrCol.add(correctNull((String)rs.getString(1)));
				arrCol.add(correctNull((String)rs.getString(2)));
				arrRow.add(arrCol);
			}
			hshRecord = new HashMap();
			arrCol = new ArrayList();
			hshRecord.put("arrRow",arrRow);
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
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
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
		return hshRecord;
	}
	public void updateCoffeeData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strGradeId = "";
		ResultSet rs = null;
		String strStatId="";		
		String txt_finance="";
		String txt_date="";
		strStatId = correctNull((String)hshValues.get("sel_coffeeplant"));
		String strStatId1=correctNull((String)hshValues.get("sel_type"));
		txt_finance=correctNull((String )hshValues.get("txt_value"));
		if(txt_finance.equalsIgnoreCase(""))
	    {
			txt_finance="0";
	    }
		String strKeyId = "";
		StringBuilder sbolddata = new StringBuilder();
		txt_date = correctNull((String)hshValues.get("txt_valdate"));
		if(txt_date.equalsIgnoreCase(""))
	    {
			txt_date="01/01/1900";
	    }
		try
		{
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				rs = DBUtils.executeLAPSQuery("selCoffeecode_audit^"+Helper.correctNull((String)hshValues.get("hidsno")));
				while(rs.next())
				{
					sbolddata.append(" ~Type of Coffee Crop = ") .append(SetupParams.getSetupParams("CoffeeCrop",correctNull((String)rs.getString("coffee_name"))));
					sbolddata.append(" ~Type = ") .append(SetupParams.getSetupParams("CoffeeType",correctNull((String)rs.getString("coffee_type"))));
					sbolddata.append(" ~Value / Tonne (Rs.)=") .append(correctNull((String)rs.getString("coffee_value")));
					sbolddata.append(" ~Valid Upto=") .append(correctNull((String)rs.getString("coffee_date")));
				}
				if(rs!=null)
					rs.close();
			}
			if(strAction.equals("update"))
			{
				 strGradeId = correctNull((String )hshValues.get("hidsno"));
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","coffeevaluationupdate");	
				arrValues.add(txt_finance);
				arrValues.add(txt_date);
				arrValues.add(strGradeId);
			
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.trim().equals("insert"))
			{	
				strGradeId = Integer.toString(getMaxGradeId2(strStatId));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");	
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","coffeevaluationinsert");
				arrValues.add(strGradeId);
				arrValues.add(strStatId);
				arrValues.add(strStatId1);
				arrValues.add(txt_finance);
				arrValues.add(txt_date);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("delete"))
			{
				ArrayList arrValues1=new ArrayList();
				strGradeId =  correctNull((String )hshValues.get("hidsno"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","coffeevaluationdelete");
				arrValues1.add(strGradeId);
				arrValues1.add(strStatId);
				arrValues1.add(strStatId1);
				hshQuery.put("arrValues",arrValues1);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
//			FOR AUDIT TRIAL
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(!strAction.equals("delete"))
			{
				sbAuditTrial.append(" ~Type of Coffee Crop = ") .append(SetupParams.getSetupParams("CoffeeCrop",correctNull((String)hshValues.get("sel_coffeeplant"))));
				sbAuditTrial.append(" ~Type = ") .append(SetupParams.getSetupParams("CoffeeType",correctNull((String)hshValues.get("sel_type"))));
				sbAuditTrial.append(" ~Value / Tonne (Rs.)=") .append(correctNull((String)hshValues.get("txt_value")));
				sbAuditTrial.append(" ~Valid Upto=") .append(correctNull((String)hshValues.get("txt_valdate")));
			}
			if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
				hshValues.put("hidAction", "update");
			AuditTrial.auditNewLog(hshValues,"346",strKeyId,sbAuditTrial.toString(),sbolddata.toString());
			
//			END OF AUDIT TRIAL

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
	public  HashMap getCoffeeData(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=new ArrayList();
		boolean recordflag=false;
		try
		{
			String strStatId = correctNull((String)hshValues.get("sel_coffeeplant"));
			if(strStatId.trim().equalsIgnoreCase(""))
			{
				strStatId = "0";
			}
			String hidslno = correctNull((String)hshValues.get("hidsno"));
			if(hidslno.trim().equalsIgnoreCase(""))
			{
				hidslno = "0";
			}
			strQuery = SQLParser.getSqlQuery("sel_coffeevalue");
			rs2 = DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				recordflag=true;
				vecVal = new ArrayList();
				vecVal.add(correctNull(rs2.getString("sno")));
				vecVal.add(correctNull(rs2.getString("coffee_name")));
				vecVal.add(correctNull(rs2.getString("coffee_type")));
				vecVal.add(correctNull(rs2.getString("coffee_value")));
				vecVal.add(correctNull(rs2.getString("coffee_date")));
				vecData.add(vecVal);							
			}			
	    	hshRecord.put("vecData",vecData);
	    	hshRecord.put("strStatId",strStatId);
	    	if(recordflag)
	    		hshRecord.put("recordflag","Y");
	    	else
	    		hshRecord.put("recordflag","N");

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
		return hshRecord;
	}
	private int getMaxGradeId2(String strStatId)
	{		
		String strQuery="";
		ResultSet rs = null;
		int termId = 0;
		try
		{	
			strQuery = SQLParser.getSqlQuery("coffeevalmax");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(rs.getString(1) != null)
				{
					termId = Integer.parseInt(rs.getString(1)) + 1;
				}
				else
				{
					termId = 1;
				}
			}
			rs.close();			
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
		return termId;
	}
	//for flex states
	public HashMap getflexState(HashMap hshValues)
	{		 
		ResultSet rs=null;
		HashMap hshRecord=null;
		String strQuery = null;
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = null;
			
		try
		{			
			strQuery=SQLParser.getSqlQuery("getflexstatetype");
			rs =DBUtils.executeQuery(strQuery);
       
			while(rs.next())
			{				
				arrCol = new ArrayList();
				arrCol.add(correctNull((String)rs.getString(1)));
				arrCol.add(correctNull((String)rs.getString(2)));
				arrCol.add(correctNull((String)rs.getString(3)));
				
				arrRow.add(arrCol);
			}
			hshRecord = new HashMap();
			arrCol = new ArrayList();
			hshRecord.put("arrRow",arrRow);
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
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
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
		return hshRecord;
	}
//ugc parameters
	public void updateUGCData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strGradeId = "";
		ResultSet rs = null;
		String strStatId="";		
		String txt_value="";
		String txt_minacre=correctNull((String)hshValues.get("txt_minacre"));
		String txt_maxacre=correctNull((String)hshValues.get("txt_maxacre"));
		txt_value=correctNull((String )hshValues.get("txt_value"));
		if(txt_value.equalsIgnoreCase(""))
	    {
			txt_value="0";
	    }
		StringBuilder sbolddata=new StringBuilder();
		String strKeyId = "";
		java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		nf.setGroupingUsed(false);
		try
		{
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			if(strAction.equals("update") || strAction.equals("delete"))
			{
				rs = DBUtils.executeLAPSQuery("selUGCvalue_audit^"+Helper.correctNull((String)hshValues.get("hidsno")));
				while(rs.next())
				{
					sbolddata.append("~Minimum Acre = "+nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("UGC_minacre")))));
					sbolddata.append("~Maximum Acre = "+nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("UGC_maxacre")))));
					sbolddata.append("~Eligible Loan Amount = "+nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("UGC_value")))));
				}
				if(rs!=null)
				rs.close();
			}
			if(strAction.equals("update"))
			{
				strGradeId =  correctNull((String )hshValues.get("hidsno"));				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","UGCvaluationupdate");	
				arrValues.add(txt_minacre);
				arrValues.add(txt_maxacre);
				arrValues.add(txt_value);
				arrValues.add(strGradeId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.trim().equals("insert"))
			{	
				strGradeId = Integer.toString(getUGCMaxGradeId(strStatId));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");	
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","UGCvaluationinsert");
				arrValues.add(strGradeId);
				arrValues.add(txt_minacre);
				arrValues.add(txt_maxacre);
				arrValues.add(txt_value);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("delete"))
			{
				ArrayList arrValues1=new ArrayList();
				strGradeId =  correctNull((String )hshValues.get("hidsno"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","UGCvaluationdelete");
				arrValues1.add(strGradeId);
				hshQuery.put("arrValues",arrValues1);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
//			FOR AUDIT TRIAL
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(!strAction.equals("delete"))
			{
				sbAuditTrial.append("~Minimum Acre = ") .append(nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_minacre")))));
				sbAuditTrial.append("~Maximum Acre  = ") .append(nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_maxacre")))));
				sbAuditTrial.append("~Eligible Loan Amount(Rs.) = ") .append(nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_value")))));
			}
			hshValues.put("hidAction",strAction);	
			if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
				hshValues.put("hidAction", "update");
			AuditTrial.auditNewLog(hshValues,"347",strKeyId,sbAuditTrial.toString(),sbolddata.toString());
			
//			END OF AUDIT TRIAL
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
	public  HashMap getUGCData(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=new ArrayList();
		try
		{
			
			String hidslno = correctNull((String)hshValues.get("hidsno"));
			if(hidslno.trim().equalsIgnoreCase(""))
			{
				hidslno = "0";
			}
			strQuery = SQLParser.getSqlQuery("sel_UGCvalue");
			rs2 = DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				vecVal = new ArrayList();
				vecVal.add(correctNull(rs2.getString("sno")));
				vecVal.add(correctNull(rs2.getString("UGC_minacre")));
				vecVal.add(correctNull(rs2.getString("UGC_maxacre")));
				vecVal.add(correctNull(rs2.getString("UGC_value")));
				vecData.add(vecVal);							
			}	
	    	hshRecord.put("vecData",vecData);
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
		return hshRecord;
	}
	private int getUGCMaxGradeId(String strStatId)
	{		
		String strQuery="";
		ResultSet rs = null;
		int termId = 0;
		try
		{	
			strQuery = SQLParser.getSqlQuery("UGCvalmax");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(rs.getString(1) != null)
				{
					termId = Integer.parseInt(rs.getString(1)) + 1;
				}
				else
				{
					termId = 1;
				}
			}
			rs.close();			
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
		return termId;
	}
	public HashMap getSancrefno(HashMap hshValues)
	{		 
		ResultSet rs=null;
		HashMap hshRecord=null;
		String strQuery = null;
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = null;
		String strappno=(String)hshValues.get("appno");	
		String strSaral=(String)hshValues.get("Saral");	
		try
		{	
			if(strSaral.equals("saral"))
			{
				strQuery=SQLParser.getSqlQuery("getsancrefnobyinwardno^"+strappno);
			
			}
			else
			{
				strQuery=SQLParser.getSqlQuery("getsancrefno^"+strappno);
			}
			rs =DBUtils.executeQuery(strQuery);
       
			while(rs.next())
			{				
				arrCol = new ArrayList();
				arrCol.add(correctNull((String)rs.getString(1)));
				arrCol.add(correctNull((String)rs.getString(2)));
				arrRow.add(arrCol);
			}
			hshRecord = new HashMap();
			arrCol = new ArrayList();
			hshRecord.put("arrRow",arrRow);
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
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
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
		return hshRecord;
	}
	public  HashMap getGoldRateData(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		String strQuery="",strActiveFlag="";
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		try
		{
			strActiveFlag=Helper.correctNull((String)hshValues.get("hidActiveFlag"));
			strQuery=SQLParser.getSqlQuery("selgoldratemaster^"+strActiveFlag);
			rs =DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(rs.getString("grm_sno"));
				arrCol.add(rs.getString("grm_moddate"));
				arrCol.add(Helper.correctDouble(rs.getString("grm_retglquick")));
				arrCol.add(Helper.correctDouble(rs.getString("grm_agriglquick")));
				arrCol.add(Helper.correctDouble(rs.getString("grm_retglclassic")));
				arrCol.add(Helper.correctDouble(rs.getString("grm_agriglclassic")));
				arrCol.add(Helper.correctDouble(rs.getString("grm_retglcomfort")));
				arrCol.add(Helper.correctDouble(rs.getString("grm_agriglcomfort")));
				arrCol.add(Helper.correctDouble(rs.getString("grm_retglstaff")));
				arrCol.add(Helper.correctDouble(rs.getString("grm_agriglstaff")));
				arrCol.add(rs.getString("grm_comments"));
				arrCol.add(rs.getString("grm_maxnetweight"));
				arrCol.add(rs.getString("grm_maxgoldloans"));
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("grm_avgmargin")))));
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("grm_latestmargin")))));
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("grm_recurrexpmargin")))));
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("grm_agridevelopmargin")))));
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("grm_agriavgmargin_ibja")))));
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("grm_agrilatestmargin_ibja")))));
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
			if(rs!=null){rs.close();}
			strQuery=SQLParser.getSqlQuery("selgoldratevalue");
			rs =DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("strGoldRate",nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("PER_GOLDRATE")))));
				hshRecord.put("strAvgGoldRate",nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("PER_AVG_RATE")))));
			}
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
		}
		return hshRecord;
	}
	public void updateGoldRateData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs=null;
		String strQuery="", strID="";
		boolean boolDate=false;
		try
		{
			//String strHidId=Helper.correctNull((String)hshValues.get("hidSNo"));
			String strModDate=Helper.correctNull((String)hshValues.get("hidModDate"));
			String strretglquick=Helper.correctDouble((String)hshValues.get("txt_retglquick"));
			String stragriglquick=Helper.correctDouble((String)hshValues.get("txt_agriglquick"));
			String strretglclassic=Helper.correctDouble((String)hshValues.get("txt_retglclassic"));
			String stragriglclassic=Helper.correctDouble((String)hshValues.get("txt_agriglclassic"));
			String strretglcomfort=Helper.correctDouble((String)hshValues.get("txt_retglcomfort"));
			String stragriglcomfort=Helper.correctDouble((String)hshValues.get("txt_agriglcomfort"));
			String strretglstaff=Helper.correctDouble((String)hshValues.get("txt_retglstaff"));
			String stragriglstaff=Helper.correctDouble((String)hshValues.get("txt_agriglstaff"));
			String strcomments=Helper.correctNull((String)hshValues.get("txtarea_comments"));
			String strMaxNetWeight=Helper.correctNull((String)hshValues.get("txt_MaxNetWeight"));
			String strMaxGoldLoans=Helper.correctNull((String)hshValues.get("txt_MaxGoldLoans"));
			String strAvgMargin=Helper.correctNull((String)hshValues.get("txt_avgmargin"));
			String strLatestMargin=Helper.correctNull((String)hshValues.get("txt_latestmargin"));
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();					
			hshQueryValues.put("size","2");
			hshQuery.put("strQueryId","updgoldratemaster");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			strID=getGoldRateMasterMaxId();
			hshQuery = new HashMap();					
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","insgoldratemaster");	
			arrValues.add(strID);
			arrValues.add(strretglquick);
			arrValues.add(stragriglquick);
			arrValues.add(strretglclassic);
			arrValues.add(stragriglclassic);
			arrValues.add(strretglcomfort);
			arrValues.add(stragriglcomfort);
			arrValues.add(strretglstaff);
			arrValues.add(stragriglstaff);
			arrValues.add(strcomments);
			arrValues.add("Y");
			arrValues.add(strMaxNetWeight);
			arrValues.add(strMaxGoldLoans);
			arrValues.add(strAvgMargin);
			arrValues.add(strLatestMargin);
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_recurexpmargin")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_maragridevelop")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_avgmargin_agri")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_latestmargin_agri")));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("2",hshQuery);	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
		}
	}
	private String getGoldRateMasterMaxId()
	{
		String strQuery="";
		ResultSet rs = null;
		String termId = "";
		try
		{	
			strQuery = SQLParser.getSqlQuery("selmaxgoldratemasterid");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(rs.getString(1) != null)
				{
					termId = Helper.correctNull(rs.getString("maxid"));
				}
			}
			rs.close();			
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
		return termId;
	}
	public HashMap getInterfaceSchemeData(HashMap hshValues) 
	{	
		String strQuery="";
		String strAction ="";
		ResultSet rs = null;
		HashMap hshRecord =new HashMap();
		ArrayList vecCol= new ArrayList();
		ArrayList vecRow=new ArrayList();	
		String hidslno = "";
		String strStatId = "";
		try
		{
			hshRecord =new HashMap();
			vecRow=new ArrayList();	
			hidslno = Helper.correctInt((String)hshValues.get("hidsno"));
			strAction = Helper.correctNull((String)hshValues.get("hidAction"));
			strStatId = Helper.correctNull((String)hshValues.get("seldataheadtype"));
			if(!strStatId.trim().equalsIgnoreCase(""))
			{
				strStatId = Helper.correctNull((String)hshValues.get("seldataheadtype"));
			}
			else
			{
				strStatId = "0";
			}
			if(strAction.trim().equals("New"))
			{
				strQuery = SQLParser.getSqlQuery("sel_schemecodeid^"+strStatId);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{	
					hidslno = rs.getString("maxid");
					strAction="Edit";
				}
			}	
			else
			{
				hidslno = Helper.correctInt((String)hshValues.get("hidsno"));
			}	
			if(rs != null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("set_intrfschstaticdata_all_select^"+strStatId);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(Helper.correctNull(rs.getString("sch_datasno")));
				vecCol.add(Helper.correctNull(rs.getString("sch_datavalue")));
				vecCol.add(Helper.correctNull(rs.getString("sch_dataid")));
				vecCol.add(Helper.correctNull(rs.getString("sch_datadescription")));
				vecCol.add(Helper.correctNull(rs.getString("sch_tenorfrom")));
				vecCol.add(Helper.correctNull(rs.getString("sch_tenorto")));
				vecCol.add(Helper.correctNull(rs.getString("sch_typeadv")));
				vecCol.add(Helper.correctNull(rs.getString("sch_subsector")));
				vecRow.add(vecCol);							
			}
			if(rs != null)
			{
				rs.close();
			}
			if(strAction.equalsIgnoreCase("Edit"))
			{										
				strQuery = SQLParser.getSqlQuery("set_intrfschstaticdata_select_one^"+strStatId+"^"+hidslno);
				rs = DBUtils.executeQuery(strQuery);				
				if(rs.next())
				{			
					hshRecord.put("stat_data_id",Helper.correctNull(rs.getString("sch_datasno")));
					hshRecord.put("stat_data_sno",Helper.correctNull(rs.getString("sch_datavalue")));
					hshRecord.put("stat_data_desc",Helper.correctNull(rs.getString("sch_dataid")));
					hshRecord.put("stat_data_desc1",Helper.correctNull(rs.getString("sch_datadescription")));
					hshRecord.put("stat_tenor_from",Helper.correctNull(rs.getString("sch_tenorfrom")));
					hshRecord.put("stat_tenor_to",Helper.correctNull(rs.getString("sch_tenorto")));
					hshRecord.put("sch_typeadv",Helper.correctNull(rs.getString("SCH_TYPEADV")));
					hshRecord.put("sch_subsector",Helper.correctNull(rs.getString("sch_subsector")));
				}		
			}
			hshRecord.put("vecRow",vecRow);
			hshRecord.put("strStatId",strStatId);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getInterfaceSchemeData "+ce.toString());
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
	public void updateInterfaceSchemeData(final HashMap hshValues)
	{
		final HashMap hshqueryval = new HashMap();
		HashMap hshqueryValues = new HashMap();
		final HashMap hshQry = new HashMap();
		HashMap hshquery = new HashMap();
		final ArrayList arrVal = new ArrayList();
		ArrayList arrValues = new ArrayList();
		final ResultSet rs=null;
		String getMaxGradeId =null,strStatId=null;		
		String hidslno=null;
		String action = null;
		try
		{
			strStatId = correctNull((String)hshValues.get("seldataheadtype"));
			hidslno = correctNull((String)hshValues.get("hidsno"));
			action = correctNull((String)hshValues.get("hidAction"));
			strStatId = correctNull((String)hshValues.get("seldataheadtype"));
			hidslno = correctNull((String)hshValues.get("hidsno"));
			if(action.equalsIgnoreCase("New"))
			{
				String qry="sel_schemecodeid^";
				getMaxGradeId = Integer.toString(getMaxGradeId(strStatId,qry));				
				hshqueryval.put("size","1");
				hshQry.put("strQueryId","set_intrfschstaticdata_insert");
				arrVal.add(strStatId);
				arrVal.add(getMaxGradeId);
				arrVal.add(correctNull((String)hshValues.get("txt_datavalues")));
				arrVal.add(correctNull((String)hshValues.get("txt_datavalues1")));
				arrVal.add(correctNull((String)hshValues.get("txt_tenorfrom")));
				arrVal.add(correctNull((String)hshValues.get("txt_tenorto")));
				arrVal.add(correctNull((String)hshValues.get("sel_typeadvance")));
				arrVal.add(correctNull((String)hshValues.get("hid_SubSector")));
				hshQry.put("arrValues",arrVal);							
				hshqueryval.put("1",hshQry);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			else if(action.equalsIgnoreCase("Edit"))
			{
				hshqueryval.put("size","1");
				hshQry.put("strQueryId","set_intrfschstaticdata_update");
				arrVal.add(correctNull((String)hshValues.get("txt_datavalues")));
				arrVal.add(correctNull((String)hshValues.get("txt_datavalues1")));
				arrVal.add(correctNull((String)hshValues.get("txt_tenorfrom")));
				arrVal.add(correctNull((String)hshValues.get("txt_tenorto")));
				arrVal.add(correctNull((String)hshValues.get("sel_typeadvance")));
				arrVal.add(correctNull((String)hshValues.get("hid_SubSector")));
				arrVal.add(strStatId);
				arrVal.add(hidslno);
				hshQry.put("arrValues",arrVal);
				action="update";	
				hshqueryval.put("1",hshQry);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			else if(action.equalsIgnoreCase("delete"))
			{
				hshqueryval.put("size","1");
				hshQry.put("strQueryId","set_intrfschstaticdata_update_del");
				arrVal.add(strStatId);
				arrVal.add(hidslno);
				hshQry.put("arrValues",arrVal);
							
				hshqueryval.put("1",hshQry);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateInterfaceSchemeData "+ce.toString());
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
	public HashMap getSchemeCodeRangeCheck(HashMap hshValues) 
	{
 		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strRangeExist="N";
		int intcount=0;
		try
		{
			/*
			 * Tenor Based Changes
			 */
			
			/*String strTenorFrom	= Helper.correctInt((String )hshValues.get("strTenorFrom"));
			String strTenorTo=Helper.correctInt((String)hshValues.get("strTenorTo"));
			String strSchemeCode=Helper.correctNull((String)hshValues.get("strSchemeCode"));
			String strLoanType=Helper.correctNull((String)hshValues.get("strLoanType"));
			String strAction=Helper.correctNull((String)hshValues.get("strAction"));
			String strSubGl=Helper.correctNull((String)hshValues.get("strSubGl"));
			String strSno=Helper.correctInt((String)hshValues.get("strSno"));
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("sel_schemecode_range_insert^"+strSchemeCode+"^"+strSubGl
										+"^"+strLoanType+"^"+strTenorFrom+"^"+strTenorTo+"^Y");
			if(rs.next())
			{
				intcount=rs.getInt(1);
			}
			if(rs!=null)
				rs.close();
			if(strAction.equalsIgnoreCase("New"))
			{
				if(intcount>0)
					strRangeExist="Y";
			}
			else if(strAction.equalsIgnoreCase("Edit"))
			{
				String strExistTenorFrom="",strtempSNO="";
				String strExistTenorTo="";
				int intTempCount=0;				
				strRangeExist="N";
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("sel_schemecode_bysno^"+strSchemeCode+"^"+strSubGl+"^"+strLoanType+"^"+strSno+"^"+strTenorFrom+"^"+strTenorTo+"^Y");
				while(rs.next())
				{
					intTempCount=(rs.getInt(1));
					if(intTempCount>0)
					{
						strRangeExist="Y";
					}
				}
			}
			hshRecord.put("strRangeExist", strRangeExist);*/
			
			/*
			 * End - Tenor Based Changes
			 */
			

			String strQuery="";
			String strDesc="";
			String strSubSectorList="";
			String strSchemeCode=Helper.correctNull((String)hshValues.get("strSchemeCode"));
			String strLoanType=Helper.correctNull((String)hshValues.get("strLoanType"));
			String strAction=Helper.correctNull((String)hshValues.get("strAction"));
			String strSno=Helper.correctInt((String)hshValues.get("strSno"));
			String strSelSubSectorList=Helper.correctInt((String)hshValues.get("hidSubSector"));
			String[] strSelSubSectorArr=new String[100];
			strSelSubSectorArr=strSelSubSectorList.split("@");
			if(strAction.equalsIgnoreCase("New"))
			{
				strQuery=SQLParser.getSqlQuery("sel_schemecode_sector_insert^"+strLoanType+"^"+strSchemeCode+"^y");
			}
			else if(strAction.equalsIgnoreCase("Edit"))
			{
				strQuery=SQLParser.getSqlQuery("sel_schemecode_sector_bysno^"+strLoanType+"^"+strSchemeCode+"^"+strSno+"^y");
			}
			if(strAction.equalsIgnoreCase("New")||strAction.equalsIgnoreCase("Edit"))
			{
				if(rs!=null)
				{
					rs.close();
				}
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					if(!strRangeExist.equalsIgnoreCase("Y"))
					{
						strDesc="";
						strSubSectorList="";
						strDesc=Helper.correctNull((String)rs.getString("sch_datadescription"));
						strSubSectorList=Helper.correctNull((String)rs.getString("sch_subsector"));
						String[] strSubSectorArr=new String[100];
						strSubSectorArr=strSubSectorList.split("@");
						for(int i=0;i<strSelSubSectorArr.length;i++)
						{
							if(!strRangeExist.equalsIgnoreCase("Y"))
							{
								for(int j=0;j<strSubSectorArr.length;j++)
								{
									if(strSelSubSectorArr[i].equals(strSubSectorArr[j]))
									{
										strRangeExist="Y";
										hshRecord.put("strDesc", strDesc);
										break;
									}
								}
							}
							else
							{
								break;
							}
						}
					}
				}
			}
			hshRecord.put("strRangeExist", strRangeExist);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getSchemeCodeRangeCheck "+ce.toString());
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

	public HashMap getFreeCode(HashMap hshValues)  {
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery="";
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = new ArrayList();
		String strCode = "";
		String strParentLevel = "";
		String strParentLevel7 = "";
		String strParentLevel8 = "";
		String strParentRefNo = "";
		String strRefNo="";		
		String strRefNo6="";
		String strRefNo7="";
		String strRefNo8="";
		String strCommonRefNo="";
		try{
			strParentLevel = Helper.correctNull((String)hshValues.get("hidParentLevel"));
			strParentLevel7 = Helper.correctNull((String)hshValues.get("hidParentLevel7"));
			strParentLevel8 = Helper.correctNull((String)hshValues.get("hidParentLevel8"));
			strParentRefNo = Helper.correctNull((String)hshValues.get("hidParentRef"));
			strRefNo = Helper.correctNull((String)hshValues.get("hidRefNo"));
			strRefNo6 = Helper.correctNull((String)hshValues.get("sel_freecode6"));
			strRefNo7 = Helper.correctNull((String)hshValues.get("sel_freecode7"));
			strRefNo8 = Helper.correctNull((String)hshValues.get("sel_freecode8"));
			if(strParentLevel.equalsIgnoreCase("0"))
			{
				hshRecord.put("strReferenceNo",Helper.correctNull((String)hshValues.get("sel_freecode6")));
				hshRecord.put("strParentReferenceNo",Helper.correctNull((String)hshValues.get("sel_freecode6")));
				strQuery = SQLParser.getSqlQuery("getstatdatavalue^" + "127"+"^"+strRefNo6);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("strCode",Helper.correctNull((String)rs.getString("stat_data_desc")));
					hshRecord.put("strDesc",Helper.correctNull((String)rs.getString("stat_data_desc1")));
				}
			}
			else if(strParentLevel.equalsIgnoreCase("1"))
			{
				strCommonRefNo=strRefNo7;
				strQuery = SQLParser.getSqlQuery("sel_freecodedesc^" + strParentLevel7+"^"+strCommonRefNo);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("strCode",Helper.correctNull((String)rs.getString("fc_code")));
					hshRecord.put("strDesc",Helper.correctNull((String)rs.getString("fc_desc")));
					hshRecord.put("strReferenceNo",Helper.correctNull((String)rs.getString("fc_refno")));
					hshRecord.put("strParentReferenceNo",Helper.correctNull((String)rs.getString("fc_parentrefno")));
				}
			}
			else if(strParentLevel.equalsIgnoreCase("2"))
			{
				strCommonRefNo=strRefNo8;
				strQuery = SQLParser.getSqlQuery("sel_freecodedesc^" + strParentLevel8+"^"+strCommonRefNo);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("strCode",Helper.correctNull((String)rs.getString("fc_code")));
					hshRecord.put("strDesc",Helper.correctNull((String)rs.getString("fc_desc")));
					hshRecord.put("strReferenceNo",Helper.correctNull((String)rs.getString("fc_refno")));
					hshRecord.put("strParentReferenceNo",Helper.correctNull((String)rs.getString("fc_parentrefno")));
				}
			}
			hshRecord.put("refno6",strRefNo6);
			hshRecord.put("refno7",strRefNo7);
			hshRecord.put("refno8",strRefNo8);
			hshRecord.put("strParentLevel",strParentLevel);
		}
		catch (Exception cf) {
			throw new EJBException("Error closing the connection "+cf.getMessage());
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
	
	public void updateFreeCode(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs=null;
		String strCode = "";
		String strMaxId = "";
		String strQuery="";
		String strAction = "";
		String strRefNo = "";
		String strParentLevel = "";
		String strCodeDescription = "";
		String strExp="$";
		try
		{
			strRefNo = correctNull((String)hshValues.get("hidCommonRefNo"));
			strAction = correctNull((String)hshValues.get("hidAction"));
			strParentLevel = correctNull((String)hshValues.get("hidCommonLevel"));
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				strCode=Helper.correctNull((String)hshValues.get("txt_code"));
				strCodeDescription=Helper.correctNull((String)hshValues.get("txt_desc"));
				strQuery=SQLParser.getSqlQuery("sel_maxfreecoderefno^"+strParentLevel);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strMaxId = rs.getString("maxid");
				}
				arrValues.add(strMaxId);
				arrValues.add(strCode);
				arrValues.add(strCodeDescription);
				arrValues.add(strParentLevel);
				arrValues.add(strRefNo);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_freecode");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				if(strParentLevel.equalsIgnoreCase("0"))
				{
					strCode=Helper.correctNull((String)hshValues.get("txt_code"));
					strCodeDescription=Helper.correctNull((String)hshValues.get("txt_desc"));
				}
				else if(strParentLevel.equalsIgnoreCase("1"))
				{
					strCode=Helper.correctNull((String)hshValues.get("txt_code"));
					strCodeDescription=Helper.correctNull((String)hshValues.get("txt_desc"));
				}
				else if(strParentLevel.equalsIgnoreCase("2"))
				{
					strCode=Helper.correctNull((String)hshValues.get("txt_code"));
					strCodeDescription=Helper.correctNull((String)hshValues.get("txt_desc"));
				}
				arrValues.add(strCode);
				arrValues.add(strCodeDescription);
				arrValues.add(strRefNo);
				arrValues.add(strParentLevel);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upd_freecode");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				if(strParentLevel.equalsIgnoreCase("0"))
				{
					//strExp=strExp+"Cannot delete this freecode. Its coming from data master";
					//throw new Exception(strExp);
				}
				if(strParentLevel.equalsIgnoreCase("1"))
				{
					int parent = Integer.parseInt(strParentLevel);
					parent++;
					String strparent = Integer.toString(parent++);
					strQuery = SQLParser.getSqlQuery("sel_freecodes^"+strparent+"^"+strRefNo);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strExp=strExp+"Cannot delete this freecode It has children";
						throw new Exception(strExp);
					}else{
						hshQueryValues = new HashMap();
						hshQuery = new HashMap();
						hshQueryValues.put("size", "1");
						hshQuery.put("strQueryId", "del_freecode");
						arrValues.add(strRefNo);
						arrValues.add(strParentLevel);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1", hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					}
				}
				if(strParentLevel.equalsIgnoreCase("2"))
				{
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "del_freecode");
					arrValues.add(strRefNo);
					arrValues.add(strParentLevel);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
			}
		}
		catch (Exception e) 
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
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	}
	
	
	
	public void updateCBSstaticdata(HashMap hshValues)
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshQry = new HashMap();
		ArrayList arrVal = new ArrayList();
		ResultSet rs=null;
		String getCBSDataMaxid = "",strStatId="";		
		String hidslno="";
		String action = correctNull((String)hshValues.get("hidAction"));
		strStatId = correctNull((String)hshValues.get("seldataheadtype"));
		hidslno = correctNull((String)hshValues.get("hidsno"));
		String strKeyId = "";
		StringBuilder sbolddata=new StringBuilder();  
		String strhidsno = Helper.correctNull((String)hshValues.get("txt_hidsno"));
		try
		{
			if(action.equalsIgnoreCase("insert"))
			{
				getCBSDataMaxid = Integer.toString(getCBSDataMaxid(strStatId));				
				hshqueryval.put("size","1");
				hshQry.put("strQueryId","ins_cbsstaticdatamaster");
				arrVal.add(Helper.correctInt((String)hshValues.get("seldataheadtype")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_datacode")));	
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_datavalues")));				
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_visibility")));
				if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("20"))
					arrVal.add(Helper.correctNull((String)hshValues.get("userlist")));
				else if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("6"))
					arrVal.add(Helper.correctNull((String)hshValues.get("sel_introducer_type")));
				else if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("26"))
					arrVal.add(Helper.correctNull((String)hshValues.get("sel_department")));
				else if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("34"))
					arrVal.add(Helper.correctNull((String)hshValues.get("txt_interestcode")));
				else 
					arrVal.add(Helper.correctNull((String)hshValues.get("txt_datacodepass")));
				arrVal.add(getCBSDataMaxid);
				if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("2"))
					arrVal.add(Helper.correctNull((String)hshValues.get("sel_const_type")));
				else if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("26"))
					arrVal.add(Helper.correctNull((String)hshValues.get("hidsubdept")));
				else if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("131")||(Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("130"))
					arrVal.add(Helper.correctNull((String)hshValues.get("txt_sancrefno")));
				else if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("34"))
					arrVal.add(Helper.correctNull((String)hshValues.get("sel_spread1")));
				else
					arrVal.add(Helper.correctNull((String)hshValues.get("txt_refno")));
				if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("26"))
					arrVal.add(Helper.correctNull((String)hshValues.get("sel_orglevel")));
				else if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("34"))
					arrVal.add(Helper.correctNull((String)hshValues.get("sel_spread2")));
				else
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_cg")));
				arrVal.add(Helper.correctNull((String)hshValues.get("hidsel_ConcernType")));
				if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("2"))
				{
					arrVal.add(Helper.correctNull((String)hshValues.get("beneficial_owner_cap")));
				}
				else
				{
					arrVal.add("");
				}
				if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("27"))
				{
					arrVal.add(Helper.correctNull((String)hshValues.get("legalopinion")));
				}
				else
				{
					arrVal.add("");
				}

				if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("27"))
				{
					arrVal.add(Helper.correctNull((String)hshValues.get("ddrbir")));
				}
				else
				{
					arrVal.add("");
				}
				if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("2"))
				{
					arrVal.add(Helper.correctNull((String)hshValues.get("sel_CGTMSE_CONS")));
				}
				else
				{
					arrVal.add("");
				}


				
				hshQry.put("arrValues",arrVal);							
				hshqueryval.put("1",hshQry);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			else if(action.equalsIgnoreCase("update"))
			{
				hshqueryval.put("size","1");
				hshQry.put("strQueryId","upd_cbsstaticdatamaster");			
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_datacode")));	
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_datavalues")));				
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_visibility")));
				if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("20"))
					arrVal.add(Helper.correctNull((String)hshValues.get("userlist")));
				else if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("6"))
					arrVal.add(Helper.correctNull((String)hshValues.get("sel_introducer_type")));
				else if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("26"))
					arrVal.add(Helper.correctNull((String)hshValues.get("sel_department")));
				else if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("34"))
					arrVal.add(Helper.correctNull((String)hshValues.get("txt_interestcode")));
				else 
					arrVal.add(Helper.correctNull((String)hshValues.get("txt_datacodepass")));
				
				if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("2"))
					arrVal.add(Helper.correctNull((String)hshValues.get("sel_const_type")));
				else if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("26"))
					arrVal.add(Helper.correctNull((String)hshValues.get("hidsubdept")));
				else if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("131")||(Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("130"))
					arrVal.add(Helper.correctNull((String)hshValues.get("txt_sancrefno")));
				else if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("34"))
					arrVal.add(Helper.correctNull((String)hshValues.get("sel_spread1")));
				else
					arrVal.add(Helper.correctNull((String)hshValues.get("txt_refno")));
				if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("26"))
					arrVal.add(Helper.correctNull((String)hshValues.get("sel_orglevel")));
				else if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("34"))
					arrVal.add(Helper.correctNull((String)hshValues.get("sel_spread2")));
				else
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_cg")));
				arrVal.add(Helper.correctNull((String)hshValues.get("hidsel_ConcernType")));
				if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("2"))
				{
					arrVal.add(Helper.correctNull((String)hshValues.get("beneficial_owner_cap")));
				}
				else
				{
					arrVal.add("");
				}
				if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("27"))
				{
					arrVal.add(Helper.correctNull((String)hshValues.get("legalopinion")));
				}
				else
				{
					arrVal.add("");
				}
				if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("27"))
				{
					arrVal.add(Helper.correctNull((String)hshValues.get("ddrbir")));
				}
				else
				{
					arrVal.add("");
				}
				if((Helper.correctInt((String)hshValues.get("seldataheadtype"))).equalsIgnoreCase("2"))
				{
					arrVal.add(Helper.correctNull((String)hshValues.get("sel_CGTMSE_CONS")));
				}
				else
				{
					arrVal.add("");
				}	
	
				arrVal.add(Helper.correctInt((String)hshValues.get("seldataheadtype")));
				arrVal.add(strhidsno);
				hshQry.put("arrValues",arrVal);							
				hshqueryval.put("1",hshQry);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			else if(action.equalsIgnoreCase("delete"))
			{
				hshqueryval.put("size","1");
				hshQry.put("strQueryId","del_cbsstaticdatamaster");
				arrVal.add(Helper.correctInt((String)hshValues.get("seldataheadtype")));
				arrVal.add(strhidsno);
				hshQry.put("arrValues",arrVal);							
				hshqueryval.put("1",hshQry);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}			
			hshQry.put("strSelDataHeads",Helper.correctInt((String)hshValues.get("seldataheadtype")));	
			
		}
		catch (Exception e)
		{
			throw new EJBException("Error in bean "+e.toString());
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
	
	
	private int getCBSDataMaxid(String strStatId)
	{		
		String strQuery="";
		ResultSet rs = null;
		int termId = 0;
		try
		{	
			strQuery = SQLParser.getSqlQuery("CBSStaticDataMaxid^"+strStatId);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(rs.getString(1) != null)
				{
					termId = Integer.parseInt(rs.getString(1)) + 1;
				}
				else
				{
					termId = 1;
				}
			}
			rs.close();			
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
		return termId;
	}
	
	
	
	public HashMap getCBSstaticdata(HashMap hshValues) 
	{	
		
		String strQuery="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord =new HashMap();
		ArrayList arrCol= new ArrayList();
		ArrayList arrRow= new ArrayList();	
		String hidslno = "";		
		try
		{
			String strStatId = "";
			hidslno = correctNull((String)hshValues.get("hidsno"));
			if(hidslno=="")
			{
				hidslno="0";
			}
			String strSelDataHeads = Helper.correctNull((String)hshValues.get("DataHeads"));	
			if(strSelDataHeads.equalsIgnoreCase(""))
			{
				strSelDataHeads = Helper.correctNull((String)hshValues.get("seldataheadtype"));	
			}
				
				
				
			strQuery=SQLParser.getSqlQuery("sel_cbsstaticdatamaster^"+strSelDataHeads);		
			rs = DBUtils.executeQuery(strQuery);		
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("cbs_static_data_code")));
				arrCol.add(Helper.correctNull((String)rs.getString("cbs_static_data_desc")));
				arrCol.add(Helper.correctNull((String)rs.getString("cbs_static_data_show")));
				arrCol.add(Helper.correctNull((String)rs.getString("cbs_slno")));
				arrCol.add(Helper.correctNull((String)rs.getString("cbs_static_data_id")));				
				arrCol.add(Helper.correctNull((String)rs.getString("cbs_static_data_passing_code")));
				arrCol.add(Helper.correctNull((String)rs.getString("cbs_static_cgtmse")));
				hshRecord.put("cbs_static_cgtmse", correctNull(rs.getString("cbs_static_cgtmse")));
				arrCol.add(Helper.correctNull((String)rs.getString("cbs_static_sanc_refno")));				
				arrCol.add(Helper.correctNull((String)rs.getString("cbs_static_sanc_refno")));		
				arrCol.add(Helper.correctNull((String)rs.getString("CBS_STATIC_CGTMSE_CONCERNTYPE")));	
				arrCol.add(Helper.correctNull((String)rs.getString("CBS_BEN")));
				arrCol.add(Helper.correctNull((String)rs.getString("LEG_OPI")));
				arrCol.add(Helper.correctNull((String)rs.getString("DDR_BIR")));
				arrCol.add(Helper.correctNull((String)rs.getString("CBS_STATIC_CGTMSE_CONST")));

				arrRow.add(arrCol);							
			}	
			
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("strStatId",strStatId);
			hshRecord.put("strSelDataHeads", strSelDataHeads);
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

	
	
	public void updateHorticultureFinanceMasterData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strGradeId = "";
		ResultSet rs = null;
		
		try
		{
			
			if(strAction.equals("update"))
			{
				strGradeId =  correctNull((String )hshValues.get("selsno"));				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agr_scaleoffinancehorticulture_update");	
				
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_plant")));
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_maxnoofunits")));
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_todate")));
				
				arrValues.add(strGradeId);//serial no
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.trim().equals("insert"))
			{	
				strGradeId = Integer.toString(getMaxGradeIdFromHorticulture());
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");	
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agr_scaleoffinancehorticulture_insert");

				arrValues.add(Helper.correctNull((String )hshValues.get("txt_plant")));
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_maxnoofunits")).trim());
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_todate")).trim());
				arrValues.add(strGradeId);//serial no
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("delete"))
			{
				strGradeId =  correctNull((String )hshValues.get("selsno"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_scaleoffinancehorticulture_delete");
				
				arrValues.add(strGradeId);	//serial no
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			/*StringBuilder sbAuditTrial=new StringBuilder();
			sbAuditTrial.
			append("~Plant= ").append(Helper.correctNull((String )hshValues.get("txt_plant")))
			.append("~spacing= ").append(Helper.correctNull((String )hshValues.get("sel_spacing")))
			.append("~Maximum no of units= ").append(Helper.correctDouble((String )hshValues.get("txt_maxnoofunits")))
			.append("~To date= ").append(Helper.correctDouble((String )hshValues.get("txt_todate")))
			.append("~S No= ").append(Helper.correctDouble((String )hshValues.get("strGradeId")));
		
			
			AuditTrial.auditLog(hshValues,"240",correctNull((String)hshValues.get("chkappno")),sbAuditTrial.toString());*/
		}
		catch(Exception ce)
		{
			ce.printStackTrace();
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
	
	
	
	
	
	private int getMaxGradeIdFromHorticulture()
	{		
		String strQuery="";
		ResultSet rs = null;
		int termId = 0;
		try
		{	
			strQuery = SQLParser.getSqlQuery("agr_scaleoffinancehorticulturemaxid_sel");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(rs.getString(1) != null)
				{
					termId = Integer.parseInt(rs.getString(1)) + 1;
				}
				else
				{
					termId = 1;
				}
			}
			rs.close();			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error  "+ce.toString());
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
		return termId;
	}
	
	private int getMaxGradeIdfromactivitymasterdata()
	{		
		String strQuery="";
		ResultSet rs = null;
		int termId = 0;
		try
		{	
			strQuery = SQLParser.getSqlQuery("sel_maxactivitymasterdata");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(rs.getString(1) != null)
				{
					termId = Integer.parseInt(rs.getString(1));
				}
				else
				{
					termId = 1;
				}
			}
			rs.close();			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error  "+ce.toString());
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
		return termId;
	}
	
	
	public  HashMap getHorticultureFinanceMasterData(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs2 = null;
		HashMap hshRecord = new HashMap();
		ArrayList arrData = new ArrayList();
		ArrayList arrVal=new ArrayList();
		try
		{
			
			strQuery = SQLParser.getSqlQuery("agr_scaleoffinancehorticulture_sel");
			rs2 = DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				arrVal = new ArrayList();
				
				arrVal.add(correctNull(rs2.getString("agr_sfh_sno")));	//0
				arrVal.add(correctNull(rs2.getString("agr_sfh_plant")));	//1
				arrVal.add(correctNull(rs2.getString("agr_sfh_maxnoofunits")));	//2
				arrVal.add(correctNull(rs2.getString("agr_sfh_uptodate")));	//3
				
				arrData.add(arrVal);		
			}	
	    	hshRecord.put("arrData",arrData);
		}
		catch(Exception ce)
		{
			ce.printStackTrace();
			throw new EJBException("Error in getHorticultureFinanceMasterData "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs2 != null)
				{
					rs2.close();
				}			
			}
			catch(Exception cf)
			{
				cf.printStackTrace();
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	public void updateCorpMasterList(HashMap hshValues) 
	{
		HashMap HashMap1 = new HashMap();
		HashMap HashMap2 = new HashMap();
		ArrayList arraylist = new ArrayList();
		ArrayList arrRow = new ArrayList();
		ArrayList arrRow1 = new ArrayList();

		ResultSet rs = null;
		String values []=(String[]) hshValues.get("txt_value");
		try
		{
			StringBuilder strOldAudit = new StringBuilder();
			
				if(rs!=null)
				{
					rs.close();
				}
				rs = DBUtils.executeLAPSQuery("sel_corploanMaster");
				while(rs.next())
				{
						arraylist = new ArrayList();
						arraylist.add(Helper.correctNull(rs.getString("CORPLOAN_PERCENTAGE")));
						arrRow.add(arraylist);
				}		
				
					strOldAudit.append(" Post harvest expenses = ");
					strOldAudit.append(arrRow.get(0));
					strOldAudit.append("~ Farm maintenance = ");
					strOldAudit.append(arrRow.get(1));
					strOldAudit.append("~ Second year eligibility = ");
					strOldAudit.append(arrRow.get(2));
					strOldAudit.append("~ Third year eligibility = ");
					strOldAudit.append(arrRow.get(3));
					strOldAudit.append("~ Fourth year eligibility = ");
					strOldAudit.append(arrRow.get(4));
					strOldAudit.append("~ Fifth year and above eligibility = ");
					strOldAudit.append(arrRow.get(5));
					strOldAudit.append("~ Maximum Interest subvention limit eligible for Crops (in Rs.) = ");
					strOldAudit.append(arrRow.get(6));
					strOldAudit.append("~ Rate of Interest for Crop subvention = ");
					strOldAudit.append(arrRow.get(7));
					if(arrRow.size()>8)
					{
						strOldAudit.append("~ Maximum Interest subvention limit eligible for Other than Crops (in Rs.) = ");
						strOldAudit.append(arrRow.get(8));
						strOldAudit.append("~ Rate of Interest for Other than Crop subvention = ");
						strOldAudit.append(arrRow.get(9));
					}
					
			
			HashMap1 = new HashMap();
			HashMap2 = new HashMap();
			arraylist = new ArrayList();
			HashMap1.put("size","1");
			HashMap2.put("strQueryId", "del_corploanMaster");
			HashMap2.put("arrValues", arraylist);
			HashMap1.put("1", HashMap2);
			EJBInvoker.executeStateLess("dataaccess",HashMap1,"updateData");
			for(int i=0;i<10;i++)
			{
			HashMap1=new HashMap();
			HashMap2=new HashMap();
			arraylist = new ArrayList();
			HashMap1.put("strQueryId","ins_corploanMaster");
			arraylist.add(Integer.toString(i+1));
			arraylist.add(Helper.correctDouble(values[i]));
			HashMap1.put("arrValues",arraylist);
			HashMap2.put("size","1");
			HashMap2.put("1",HashMap1);
			EJBInvoker.executeStateLess("dataaccess",HashMap2,"updateData");
			}
			
			StringBuilder strAuditTrial=new StringBuilder();
			
			strAuditTrial.append(" Post harvest expenses =").append(Helper.correctDouble(values[0]))
			.append("~Farm maintenance   =").append(Helper.correctDouble(values[1]))
			.append("~Second year eligibility =").append(Helper.correctDouble(values[2]))
			.append("~Third year eligibility =").append(Helper.correctDouble(values[3]))
			.append("~Fourth year eligibility =").append(Helper.correctDouble(values[4]))
			.append("~Fifth year and above eligibility =").append(Helper.correctDouble(values[5]))
			.append("~Maximum Interest subvention limit eligible for Crops (in Rs.) =").append(Helper.correctDouble(values[6]))
			.append("~Rate of Interest for Crop subvention =").append(Helper.correctDouble(values[7]))
			.append("~Maximum Interest subvention limit eligible for Other than Crops (in Rs.)  =").append(Helper.correctDouble(values[8]))
			.append("~Rate of Interest for Other than Crop subvention=").append(Helper.correctDouble(values[9]));
			
			AuditTrial.auditNewLog(hshValues,"433","croploan",strAuditTrial.toString(),strOldAudit.toString());
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
	}
	
	public void updateActivityMasterData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strGradeId = "";
		ResultSet rs = null;
		
		try
		{			
			if(strAction.equals("update"))
			{
				strGradeId =  correctNull((String )hshValues.get("selsno"));				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_activitymasterdata");	
				
				arrValues.add(Helper.correctNull((String )hshValues.get("sel_activityname")));
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_activity")));
				arrValues.add(Helper.correctNull((String )hshValues.get("sel_applicable")));
				if((Helper.correctNull((String )hshValues.get("sel_applicable"))).equalsIgnoreCase("Y"))
				{
					arrValues.add(Helper.correctNull((String )hshValues.get("txt_rangefrom")));
					arrValues.add(Helper.correctNull((String )hshValues.get("txt_rangeto")));
				}
				else
				{
					arrValues.add("0.00");
					arrValues.add("0.00");
				}
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_years")));
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_secondactivity")));
				if(Helper.correctNull((String )hshValues.get("sel_secondyear")).equalsIgnoreCase("Y"))
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_secondunitcost")));
				else arrValues.add("0.00");
				arrValues.add(Helper.correctNull((String )hshValues.get("sel_secondyear")));
				arrValues.add(Helper.correctNull((String )hshValues.get("sel_Action")));
				
				arrValues.add(Helper.correctNull((String )hshValues.get("sel_specifications")));
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_rangeper")));
				
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_datefrom")));
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_dateto")));
				arrValues.add(Helper.correctNull((String )hshValues.get("sel_state")));
				
				
				arrValues.add(strGradeId);//serial no
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.trim().equals("insert"))
			{	
				strGradeId = Integer.toString(getMaxGradeIdfromactivitymasterdata());
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");	
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ins_activitymasterdata");
				
				arrValues.add(strGradeId);//serial no
				arrValues.add(Helper.correctNull((String )hshValues.get("sel_activityname")));
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_activity")));
				arrValues.add(Helper.correctNull((String )hshValues.get("sel_applicable")));
				if((Helper.correctNull((String )hshValues.get("sel_applicable"))).equalsIgnoreCase("Y"))
				{
					arrValues.add(Helper.correctNull((String )hshValues.get("txt_rangefrom")));
					arrValues.add(Helper.correctNull((String )hshValues.get("txt_rangeto")));
				}
				else
				{
					arrValues.add("0.00");
					arrValues.add("0.00");
				}
				String strMaxSchemeSno = "";
				String strQuery2 = SQLParser.getSqlQuery("sel_maxshemeSno^"+Helper.correctNull((String )hshValues.get("sel_activityname")));
				ResultSet rs2 = DBUtils.executeQuery(strQuery2);
				if(rs2.next())
				{
					strMaxSchemeSno = Helper.correctNull((String)rs2.getString("maxscheme"));
				}
				arrValues.add(strMaxSchemeSno);
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_years")));
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_secondactivity")));
				if(Helper.correctNull((String )hshValues.get("sel_secondyear")).equalsIgnoreCase("Y"))
					arrValues.add(Helper.correctNull((String )hshValues.get("txt_secondunitcost")));
					else arrValues.add("0.00");
				arrValues.add(Helper.correctNull((String )hshValues.get("sel_secondyear")));
				arrValues.add(Helper.correctNull((String )hshValues.get("sel_Action")));

				arrValues.add(Helper.correctNull((String )hshValues.get("sel_specifications")));
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_rangeper")));
				
				
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_datefrom")));
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_dateto")));
				arrValues.add(Helper.correctNull((String )hshValues.get("sel_state")));
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("delete"))
			{
				strGradeId =  correctNull((String )hshValues.get("selsno"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_activitymasterdata");
				
				arrValues.add(strGradeId);	//serial no
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			/*StringBuilder sbAuditTrial=new StringBuilder();
			sbAuditTrial.
			append("~Plant= ").append(Helper.correctNull((String )hshValues.get("txt_plant")))
			.append("~spacing= ").append(Helper.correctNull((String )hshValues.get("sel_spacing")))
			.append("~Maximum no of units= ").append(Helper.correctDouble((String )hshValues.get("txt_maxnoofunits")))
			.append("~To date= ").append(Helper.correctDouble((String )hshValues.get("txt_todate")))
			.append("~S No= ").append(Helper.correctDouble((String )hshValues.get("strGradeId")));
		
			
			AuditTrial.auditLog(hshValues,"240",correctNull((String)hshValues.get("chkappno")),sbAuditTrial.toString());*/
		}
		catch(Exception ce)
		{
			ce.printStackTrace();
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
	
	public  HashMap getActivityMasterData(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs2 = null,rs1=null;
		HashMap hshRecord = new HashMap();
		ArrayList arrData = new ArrayList();
		ArrayList arrVal=new ArrayList();
		try
		{
			
			strQuery = SQLParser.getSqlQuery("sel_activitymasterdata");
			rs2 = DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				arrVal = new ArrayList();
				
				arrVal.add(correctNull(rs2.getString("ACT_SNO")));	//0
				arrVal.add(correctNull(rs2.getString("ACT_SCHEME")));	//1
				arrVal.add(correctNull(rs2.getString("ACT_DESC")));	//2
				arrVal.add(correctNull(rs2.getString("ACT_AVAILABLE")));	//3
				arrVal.add(correctNull(rs2.getString("ACT_RANGEFROM")));	//4
				arrVal.add(correctNull(rs2.getString("ACT_RANGETO")));	//5
				arrVal.add(correctNull(rs2.getString("ACT_YEARS")));	//6
				arrVal.add(correctNull(rs2.getString("ACT_DESC2")));	//7
				arrVal.add(correctNull(rs2.getString("ACT_AMT2")));	//8
				arrVal.add(correctNull(rs2.getString("ACT_WHETHER2")));	//9
				arrVal.add(correctNull(rs2.getString("ACT_ACTION")));//10
				arrVal.add(correctNull(rs2.getString("ACT_SPECIFICATIONS")));	//11
				arrVal.add(correctNull(rs2.getString("ACT_RANGEPER")));	//12
				arrVal.add(correctNull(rs2.getString("ACT_DATEFROM")));	//13
				arrVal.add(correctNull(rs2.getString("ACT_DATETO")));//14
				arrVal.add(correctNull(rs2.getString("act_state")));//15
				//arrVal.add(correctNull(rs2.getString("ACT_SCHEME")));//16
				
				strQuery = SQLParser.getSqlQuery("sel_static_data_masterauc1^"+"286"+"^"+correctNull(rs2.getString("ACT_DESC")));
				rs1 = DBUtils.executeQuery(strQuery);
				
				if(rs1.next())
				{
					arrVal.add(Helper.correctNull((String)rs1.getString("stat_data_desc1")));//16
				}
				else
				{
					arrVal.add(correctNull(rs2.getString("ACT_DESC")));//16
				}
					
					
				
				if(rs1!=null){
					rs1.close();
				}
				
				strQuery = SQLParser.getSqlQuery("sel_static_data_masterauc1^"+"287"+"^"+correctNull(rs2.getString("ACT_SPECIFICATIONS")));
				rs1 = DBUtils.executeQuery(strQuery);
				
				if(rs1.next())
				{
					arrVal.add(Helper.correctNull((String)rs1.getString("stat_data_desc1"))); //17
				}
				
				else
				{
					arrVal.add(correctNull(rs2.getString("ACT_SPECIFICATIONS")));//17
				}	
				
				
				strQuery = SQLParser.getSqlQuery("sel_static_data_masterauc1^"+"285"+"^"+correctNull(rs2.getString("ACT_SCHEME")));
				rs1 = DBUtils.executeQuery(strQuery);
				
				if(rs1.next())
				{
					arrVal.add(Helper.correctNull((String)rs1.getString("stat_data_desc1"))); //17
				}
				
				else
				{
					arrVal.add("");//17
				}
				
				if(rs1!=null){
					rs1.close();
				}
				arrData.add(arrVal);		
			}	
	    	hshRecord.put("arrData",arrData);
		}
		catch(Exception ce)
		{
			ce.printStackTrace();
			throw new EJBException("Error in getActivityMasterData "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs2 != null)
				{
					rs2.close();
				}			
			}
			catch(Exception cf)
			{
				cf.printStackTrace();
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	
	public HashMap getCorpMasterList(HashMap hshValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strQuery="";
		try
		{
			strQuery = SQLParser.getSqlQuery("sel_corploanMaster");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				String percentage=Helper.correctNull(rs.getString("CORPLOAN_PERCENTAGE"));
				arrValues.add(percentage);
			}
			hshRecord.put("vec",arrValues);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return hshRecord;
	}
	
	

	public void updateTypepoultrymastersdata(HashMap hshValues )
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		
	
		
		
		try
		{
			String strsel_poultry= Helper.correctNull((String)hshValues.get("sel_poultry"));
			hshQueryValues = new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			arrValues.add(strsel_poultry);
			hshQuery.put("strQueryId","del_Typepoultrymasters");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
				
		
			hshQueryValues = new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			arrValues.add(strsel_poultry);
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_Starter")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_Grower")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_FinisherMash")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_Mortality")));
			hshQuery.put("strQueryId","ins_Typepoultrymasters");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getActivityMasterData "+e.toString());
		}
		
		
	}
	
	public HashMap getTypepoultrymastersdata(HashMap hshValues) 
	{
		
		String strQuery="";
		ResultSet rs2 = null;
		HashMap hshRecord = new HashMap();
		ArrayList arrData = new ArrayList();
		ArrayList arrVal=new ArrayList();
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		try
		{
			
			String strsel_poultry=Helper.correctNull((String)hshValues.get("sel_poultry"));
			
			if(!strsel_poultry.equalsIgnoreCase(""))
			
			{
			
			strQuery = SQLParser.getSqlQuery("sel_Typepoultrymasters^"+strsel_poultry);
			rs2 = DBUtils.executeQuery(strQuery);
			if(rs2.next())
			{
				hshRecord.put("poultry_Startermash",jtn.format(Double.parseDouble(Helper.correctDouble(rs2.getString("poultry_Startermash")))));
				hshRecord.put("poultry_Growermash",jtn.format(Double.parseDouble(Helper.correctDouble(rs2.getString("poultry_Growermash")))));
				hshRecord.put("poultry_Finishermash",jtn.format(Double.parseDouble(Helper.correctDouble(rs2.getString("poultry_Finishermash")))));
				hshRecord.put("poultry_Mortality",jtn.format(Double.parseDouble(Helper.correctDouble(rs2.getString("poultry_Mortality")))));
				
			}	
			}
			hshRecord.put("strsel_poultry",strsel_poultry);
	    	
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getActivityMasterData "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs2 != null)
				{
					rs2.close();
				}			
			}
			catch(Exception cf)
			{
				cf.printStackTrace();
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
		
	}
	
	public void updateRatingCode(HashMap hshValues)
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshQry = new HashMap();
		ArrayList arrVal = new ArrayList();
		ResultSet rs=null;
		String getMaxGradeId = "",strStatId="";		
		String hidslno="";
		String action = correctNull((String)hshValues.get("hidAction"));
		strStatId = correctNull((String)hshValues.get("seldataheadtype"));
		hidslno = Helper.correctInt((String)hshValues.get("hidsno"));
		String strKeyId = "";
		StringBuilder sbolddata=new StringBuilder();   
		try
		{		
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			/*if(action.equalsIgnoreCase("update") || action.equalsIgnoreCase("delete"))
			{
				rs = DBUtils.executeLAPSQuery("getstatdatavalue^"+strStatId+"^"+hidslno);
				while(rs.next())
				{
					sbolddata.append("~ Data Heads = "+Helper.correctNull((String)hshValues.get("seldataheadtype1")));
					sbolddata.append("~ Data Value = "+Helper.correctNull((String)rs.getString("stat_data_desc")));
					sbolddata.append("~ Data Description = "+Helper.correctNull((String)rs.getString("stat_data_desc1")));
					sbolddata.append("~ Shown to User = "+Helper.correctNull((String)rs.getString("stat_data_active")));
				}
				if(rs!=null)
				rs.close();
			}*/
			if(action.equalsIgnoreCase("insert"))
			{
				
				rs=DBUtils.executeLAPSQuery("selmax_ratingCode");
				if(rs.next())
				{
					getMaxGradeId=Helper.correctInt((String)rs.getString("maxno"));
				}
				
				hshqueryval.put("size","1");
				hshQry.put("strQueryId","ins_ratingCode");
				
				arrVal.add(Helper.correctInt((String)getMaxGradeId));
				arrVal.add(correctNull((String)hshValues.get("txt_code")));
				arrVal.add(correctNull((String)hshValues.get("txt_desc")));
				hshQry.put("arrValues",arrVal);							
				hshqueryval.put("1",hshQry);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			else if(action.equalsIgnoreCase("update"))
			{
				hshqueryval.put("size","1");
				hshQry.put("strQueryId","upd_ratingCode");
				arrVal.add(correctNull((String)hshValues.get("txt_code")));
				arrVal.add(correctNull((String)hshValues.get("txt_desc")));
				arrVal.add(hidslno);
				hshQry.put("arrValues",arrVal);
							
				hshqueryval.put("1",hshQry);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			else if(action.equalsIgnoreCase("delete"))
			{
				hshqueryval.put("size","1");
				hshQry.put("strQueryId","del_ratingCode");
				arrVal.add(hidslno);
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("1",hshQry);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			
			/*StringBuilder sbAuditTrial=new StringBuilder();
			sbAuditTrial.append("~ Data Heads=").append(correctNull((String )hshValues.get("seldataheadtype1"))).append("~Data Value =").append(correctNull((String )hshValues.get("txt_datavalues")))
			.append("~ Data Description =").append(correctNull((String )hshValues.get("txt_datavalues1"))).append("~ Shown to User=").append(correctNull((String)hshValues.get("selactive")));
			if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
				hshValues.put("hidAction", "update");		
			AuditTrial.auditNewLog(hshValues,"350",strKeyId,sbAuditTrial.toString(),sbolddata.toString());*/
		}
		catch (Exception e)
		{
			throw new EJBException("Error in bean "+e.toString());
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
	
	public HashMap getRatingCode(HashMap hshValues) 
	{	
		
		String strQuery="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord =new HashMap();
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
		String hidslno = "";
		
		try
		{
			String strStatId = "";
			strQuery=SQLParser.getSqlQuery("sel_ratingCode");		
			rs = DBUtils.executeQuery(strQuery);
		
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));
				vecCol.add(correctNull(rs.getString(2)));
				vecCol.add(correctNull(rs.getString(3)));
				vecRow.add(vecCol);							
			}	
			
			hshRecord.put("vecRow",vecRow);
			hshRecord.put("strStatId",strStatId);
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
	public void updateFVCMaster(HashMap hshValues)
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshQry = new HashMap();
		ArrayList arrVal = new ArrayList();
		ResultSet rs=null;
		String getMaxGradeId = "",strChkVal="";		
		int intsize=0;
		String action = correctNull((String)hshValues.get("hidAction"));
		strChkVal = correctNull((String)hshValues.get("rad"));
		intsize = Integer.parseInt(Helper.correctInt((String)hshValues.get("txtarrlen")));
		String strKeyId = "";
		StringBuilder sbolddata=new StringBuilder(); 
		int intUpdatesize=0;
		String[] strDesc = null;
		String[] strPremium = null;
		try
		{		
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			if(action.equalsIgnoreCase("insert"))
			{
				if(strChkVal.equalsIgnoreCase("DP"))
				{
					intUpdatesize++;
					hshQry=new HashMap();
					arrVal=new ArrayList();
				
					hshQry.put("strQueryId","delfvcmaster");
					arrVal.add(strChkVal);
					hshQry.put("arrValues",arrVal);
					hshqueryval.put("size",Integer.toString(intUpdatesize));
					hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
					
					intUpdatesize++;
					hshQry=new HashMap();
					arrVal=new ArrayList();
				
					hshQry.put("strQueryId","insfvcmaster");
					arrVal.add(strChkVal);
					arrVal.add("");
					arrVal.add("1");
					arrVal.add(Helper.correctNull((String)hshValues.get("txtproposedpremiumdp")));
					arrVal.add("");
					arrVal.add("");
					hshQry.put("arrValues",arrVal);
					hshqueryval.put("size",Integer.toString(intUpdatesize));
				
					hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
					
				}else if(strChkVal.equalsIgnoreCase("TP"))
				{
					intUpdatesize++;
					hshQry=new HashMap();
					arrVal=new ArrayList();
				
					hshQry.put("strQueryId","deletefvcmastersno");
					arrVal.add(strChkVal);
					arrVal.add(Helper.correctNull((String)hshValues.get("seltenor_range")));
					hshQry.put("arrValues",arrVal);
					hshqueryval.put("size",Integer.toString(intUpdatesize));
					hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
					
					intUpdatesize++;
					hshQry=new HashMap();
					arrVal=new ArrayList();
				
					hshQry.put("strQueryId","insfvcmaster");
					arrVal.add(strChkVal);
					arrVal.add("");
					arrVal.add(Helper.correctNull((String)hshValues.get("seltenor_range")));
					arrVal.add(Helper.correctNull((String)hshValues.get("txtproposedpremiumtp")));
					arrVal.add(Helper.correctNull((String)hshValues.get("txtamtfrom")));
					arrVal.add(Helper.correctNull((String)hshValues.get("txtamtto")));
					hshQry.put("arrValues",arrVal);
					hshqueryval.put("size",Integer.toString(intUpdatesize));
				
					hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
				}
				else if(strChkVal.equalsIgnoreCase("RP"))
				{
					intUpdatesize++;
					hshQry=new HashMap();
					arrVal=new ArrayList();
				
					hshQry.put("strQueryId","delfvcmaster");
					arrVal.add(strChkVal);
					hshQry.put("arrValues",arrVal);
					hshqueryval.put("size",Integer.toString(intUpdatesize));
					hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
					
					strDesc= (String[]) hshValues.get("txtratdescrp");
					strPremium= (String[]) hshValues.get("txtproposedpremiumrp");
					for(int j=0;j<intsize;j++)
					{
					intUpdatesize++;
					hshQry=new HashMap();
					arrVal=new ArrayList();
				
					hshQry.put("strQueryId","insfvcmaster");
					arrVal.add(strChkVal);
					arrVal.add(strDesc[j]);
					arrVal.add(String.valueOf(j+1));
					arrVal.add(strPremium[j]);
					arrVal.add("");
					arrVal.add("");
					hshQry.put("arrValues",arrVal);
					hshqueryval.put("size",Integer.toString(intUpdatesize));
				
					hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
					}
				}
				if(intUpdatesize>0)
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			else if(action.equalsIgnoreCase("delete"))
			{
				if(strChkVal.equalsIgnoreCase("TP"))
				{
					hshqueryval.put("size","1");
					hshQry.put("strQueryId","deletefvcmastersno");
					arrVal.add(strChkVal);
					arrVal.add(Helper.correctNull((String)hshValues.get("seltenor_range")));
					hshQry.put("arrValues",arrVal);
					hshqueryval.put("1",hshQry);
				}else{
					hshqueryval.put("size","1");
					hshQry.put("strQueryId","delfvcmaster");
					arrVal.add(strChkVal);
					hshQry.put("arrValues",arrVal);
					hshqueryval.put("1",hshQry);
				}
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			else if(action.equalsIgnoreCase("new"))
			{
				if(rs!=null)
					rs.close();
				
				rs=DBUtils.executeLAPSQuery("selmax_fvcmaster");
				if(rs.next())
				{
					getMaxGradeId=Helper.correctInt((String)rs.getString("maxno"));
				}
				
				 if(strChkVal.equalsIgnoreCase("TP"))
				{
					intUpdatesize++;
					hshQry=new HashMap();
					arrVal=new ArrayList();
				
					hshQry.put("strQueryId","insfvcmaster");
					arrVal.add(strChkVal);
					arrVal.add("");
					arrVal.add(getMaxGradeId);
					arrVal.add(Helper.correctNull((String)hshValues.get("txtproposedpremiumtp")));
					arrVal.add(Helper.correctNull((String)hshValues.get("txtamtfrom")));
					arrVal.add(Helper.correctNull((String)hshValues.get("txtamtto")));
					hshQry.put("arrValues",arrVal);
					hshqueryval.put("size",Integer.toString(intUpdatesize));
				
					hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
				}
				 if(intUpdatesize>0)
				 EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			
		}
		catch (Exception e)
		{
			throw new EJBException("Error in bean "+e.toString());
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
	public HashMap getFVCMaster(HashMap hshValues) 
	{	
		
		java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.setGroupingUsed(false);
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		ResultSet rs = null;
		HashMap hshRecord =new HashMap();
		ArrayList arrCol		= new ArrayList();
		ArrayList arrRow		= new ArrayList();	
		String hidslno = "";
		String strChkbox="";
		
		try
		{
			boolean strFlag=false;
			String strStatId = "";
			strChkbox=Helper.correctNull((String)hshValues.get("rad"));
			if(strChkbox.equalsIgnoreCase(""))
				strChkbox="DP";
			if(rs!=null)
				rs.close();
			
			rs = DBUtils.executeLAPSQuery("selfvcmaster^"+strChkbox);
		
			while(rs.next())
			{
				strFlag=true;
				if(strChkbox.equalsIgnoreCase("DP"))
					hshRecord.put("strPremiumAmtDP",nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("fvc_premium")))));
				else if(strChkbox.equalsIgnoreCase("RP"))
				{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("fvc_desc")));
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("fvc_premium")))));
				arrRow.add(arrCol);	
				}
			}
			if(strChkbox.equalsIgnoreCase("TP"))
			{
				if(rs!=null)
				rs.close();
				rs = DBUtils.executeLAPSQuery("selectfvcmaster^"+strChkbox+"^"+Helper.correctInt((String)hshValues.get("seltenor_range")));
				
				if(rs.next())
				{
					strFlag=true;
					hshRecord.put("strPremiumAmtTP",nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("fvc_premium")))));
					hshRecord.put("strTenorfrom",Helper.correctNull(rs.getString("fvc_tnr_from")));
					hshRecord.put("strTenorto",Helper.correctNull(rs.getString("fvc_tnr_to")));
					hshRecord.put("strTenor",Helper.correctNull((String)hshValues.get("seltenor_range")));
				}
			}
			if(strFlag==false)
			{
				if(rs!=null)
				rs.close();
				arrRow = new ArrayList();
				rs = DBUtils.executeLAPSQuery("sel_ratingCode");
				
				while(rs.next())
				{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("rating_code")));
				arrCol.add("0.00");
				arrRow.add(arrCol);	
				}
			}

			
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("strChkbox",strChkbox);
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
	public HashMap getUserApplicationCount(HashMap hshValues) 
	{	
		
		ResultSet rs = null;
		ArrayList arrCol		= new ArrayList();
		ArrayList arrRow		= new ArrayList();	
		String hidslno = "";
		String strValue="";
		
		try
		{
			if(rs!=null)
				rs.close();
			
			strValue=Helper.correctNull((String)hshValues.get("txtFromUserId"));
			
			if(Helper.correctNull((String)hshValues.get("txtapplicationno")).equalsIgnoreCase(""))
			{
			
				rs = DBUtils.executeLAPSQuery("sel_userapplicationcount^"+strValue+"^"+strValue+"^"+strValue+"^"+strValue+"^"+strValue+"^"+strValue);
				
				while(rs.next())
				{
					if(!correctNull(rs.getString("count")).equalsIgnoreCase("0"))
					{
						arrCol = new ArrayList();
						arrCol.add(correctNull(rs.getString("loantype")));
						arrCol.add(correctNull(rs.getString("count")));
						arrRow.add(arrCol);	
					}
				}
				if(rs!=null)
					rs.close();
				
				rs = DBUtils.executeLAPSQuery("sel_userappcount^"+strValue+"^"+strValue+"^"+strValue+"^"+strValue);
				
				while(rs.next())
				{
					if(!correctNull(rs.getString("count")).equalsIgnoreCase("0"))
					{
						arrCol = new ArrayList();
						arrCol.add(correctNull(rs.getString("loantype")));
						arrCol.add(correctNull(rs.getString("count")));
						arrRow.add(arrCol);	
						}
				}
			}
			
			hshValues.put("arrRow",arrRow);
			
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
		return hshValues;
	}
	public HashMap updateUserApplicationTransfer(HashMap hshValues)
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshQry = new HashMap();
		ArrayList arrVal = new ArrayList();
		ResultSet rs=null;
		int intsize=0;
		String strFromUserID = correctNull((String)hshValues.get("txtFromUserId"));
		String strToUserID = correctNull((String)hshValues.get("txttousrid"));
		String str_appno=Helper.correctNull((String)hshValues.get("txtapplicationno"));
		String strTransferedBy=Helper.correctNull((String)hshValues.get("strUserId"));
		String strTransOrgCode=Helper.correctNull((String)hshValues.get("strOrgShortCode"));
		String strTransOrgDept="",strTransToOrgCode="",strTransToOrgDept="";
		
		if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
			strTransOrgDept=correctNull((String)hshValues.get("strUserDepartment"));
		else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
			strTransOrgDept=correctNull((String)hshValues.get("strRLPFUser"));
		
		if(Helper.correctNull((String)hshValues.get("strUserGrpId")).equalsIgnoreCase("1"))
		{
			strTransferedBy="ADMIN";
			strTransOrgCode="001";
			strTransOrgDept="006";
		}
		String strAppNo_val[]=str_appno.split(",");
		int intUpdatesize=0;
		String strQuery="";
		String strappno="",strVal_Appno="";
		strappno=str_appno.replaceAll(",", "','");
		try
		{	
			
			
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("workflowusersanlimit^"+strToUserID);
			if(rs.next())
			{
				strTransToOrgCode=Helper.correctNull(rs.getString("org_scode"));
				if(Helper.correctNull(rs.getString("org_level")).equalsIgnoreCase("C"))
					strTransToOrgDept=Helper.correctNull(rs.getString("USR_DEPARTMENT"));
				else if(Helper.correctNull(rs.getString("org_level")).equalsIgnoreCase("D"))
					strTransToOrgDept=Helper.correctNull(rs.getString("USR_RLPFTYPE"));
			}
			
			// retail,corporate, agri	
		
			if(rs!=null)
				rs.close();
			if(!Helper.correctNull((String)hshValues.get("txtapplicationno")).equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("seluser_proposal^"+strFromUserID+"^"+strFromUserID+"^"+strFromUserID+"^"+strFromUserID+"^ and MAIL_APPNO in('"+strappno+"')");
				rs = DBUtils.executeQuery(strQuery);
			}
			else
			{
				strQuery=SQLParser.getSqlQuery("seluser_proposal^"+strFromUserID+"^"+strFromUserID+"^"+strFromUserID+"^"+strFromUserID+"^ ");		
				rs = DBUtils.executeQuery(strQuery);
			}
			while(rs.next())
			{
 				intUpdatesize++;
				hshQry=new HashMap();
				arrVal=new ArrayList();
				arrVal.add(Helper.correctNull((String)rs.getString("appnumber")));
				//arrVal.add(strFromUserID);
				arrVal.add(strTransferedBy);
				arrVal.add(strToUserID);
				arrVal.add(Helper.correctNull((String)rs.getString("MAIL_FROMFLOWPOINT")));
				arrVal.add(Helper.correctNull((String)rs.getString("MAIL_TOFLOWPOINT")));
				arrVal.add("C");
				arrVal.add(strTransOrgCode);
				arrVal.add(strTransOrgDept);
				arrVal.add(strTransToOrgCode);
				arrVal.add(strTransToOrgDept);
				arrVal.add("Y");
				hshQry.put("strQueryId","commworkflowins1");
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
			}
			if(!Helper.correctNull((String)hshValues.get("txtapplicationno")).equalsIgnoreCase(""))
			{
				for(int i=0;i<strAppNo_val.length;i++)
				{
					strVal_Appno="";
					strVal_Appno=strAppNo_val[i];
					intUpdatesize++;
					hshQry=new HashMap();
					arrVal=new ArrayList();
					arrVal.add(strToUserID);
					arrVal.add(strFromUserID);
					arrVal.add(strFromUserID);
					arrVal.add(strVal_Appno);	
					hshQry.put("strQueryId","updapplications_userapptransfer");
					hshQry.put("arrValues",arrVal);
					hshqueryval.put("size",Integer.toString(intUpdatesize));
					hshQry.put("strAppendString","and  app_no=?");
					hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
				}
			}
			else
			{
				intUpdatesize++;
				hshQry=new HashMap();
				arrVal=new ArrayList();
				arrVal.add(strToUserID);
				arrVal.add(strFromUserID);
				arrVal.add(strFromUserID);
				hshQry.put("strQueryId","updapplications_userapptransfer");
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
			}
				//solvency 	
					
					if(rs!=null)
						rs.close();
					if(!Helper.correctNull((String)hshValues.get("txtapplicationno")).equalsIgnoreCase(""))
					{
						strQuery=SQLParser.getSqlQuery("seluser_solproposal_apptransfer^"+strFromUserID+"^ and AS_APPNO in('"+strappno+"')");		
						rs = DBUtils.executeQuery(strQuery);
					}
					else
					{
						strQuery=SQLParser.getSqlQuery("seluser_solproposal_apptransfer^"+strFromUserID+"^ ");		
						rs = DBUtils.executeQuery(strQuery);
					}
					while(rs.next())
					{
						intUpdatesize++;
						hshQry=new HashMap();
						arrVal=new ArrayList();
						arrVal.add(Helper.correctNull((String)rs.getString("appno")));
						//arrVal.add(strFromUserID);
						arrVal.add(strTransferedBy);
						arrVal.add(strToUserID);
						arrVal.add("C");
						arrVal.add(Helper.correctNull((String)rs.getString("AS_FROMFLWPT")));
						arrVal.add(Helper.correctNull((String)rs.getString("AS_TOFLWPT")));
						arrVal.add("Y");
						arrVal.add(strTransOrgCode);
						arrVal.add(strTransOrgDept);
						arrVal.add(strTransToOrgCode);
						arrVal.add(strTransToOrgDept);
						hshQry.put("strQueryId","solappmailins");
						hshQry.put("arrValues",arrVal);
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
					}
					
				if(!Helper.correctNull((String)hshValues.get("txtapplicationno")).equalsIgnoreCase(""))
				{
					for(int i=0;i<strAppNo_val.length;i++)
					{
						strVal_Appno="";
						strVal_Appno=strAppNo_val[i];
						intUpdatesize++;
						hshQry=new HashMap();
						arrVal=new ArrayList();
						arrVal.add(strToUserID);
						arrVal.add(strFromUserID);
						arrVal.add(strVal_Appno);	
						hshQry.put("strQueryId","updapplications_solapptransfer");
						hshQry.put("arrValues",arrVal);
						if(!Helper.correctNull((String)hshValues.get("txtapplicationno")).equalsIgnoreCase(""))
						hshQry.put("strAppendString"," and SOL_APPL_NO=?");
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
					}
				}
				else{
					intUpdatesize++;
					hshQry=new HashMap();
					arrVal=new ArrayList();
					arrVal.add(strToUserID);
					arrVal.add(strFromUserID);
					hshQry.put("strQueryId","updapplications_solapptransfer");
					hshQry.put("arrValues",arrVal);
					hshqueryval.put("size",Integer.toString(intUpdatesize));
					hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
				}
				
					// kpower
					if(rs!=null)
						rs.close();
					if(!Helper.correctNull((String)hshValues.get("txtapplicationno")).equalsIgnoreCase(""))
					{
						strQuery=SQLParser.getSqlQuery("seluser_kpowproposal_apptransfer^"+strFromUserID+"^ and AK_APPNO in('"+strappno+"')");		
						rs = DBUtils.executeQuery(strQuery);
					}
					else
					{
						strQuery=SQLParser.getSqlQuery("seluser_kpowproposal_apptransfer^"+strFromUserID+"^ ");		
						rs = DBUtils.executeQuery(strQuery);
					}
				
					while(rs.next())
					{
						intUpdatesize++;
						hshQry=new HashMap();
						arrVal=new ArrayList();
						arrVal.add(Helper.correctNull((String)rs.getString("appno")));
						//arrVal.add(strFromUserID);
						arrVal.add(strTransferedBy);
						arrVal.add(strToUserID);
						arrVal.add("C");
						arrVal.add(Helper.correctNull((String)rs.getString("ak_fromflwpt")));
						arrVal.add(Helper.correctNull((String)rs.getString("ak_toflwpt")));
						arrVal.add("Y");
						arrVal.add(strTransOrgCode);
						arrVal.add(strTransOrgDept);
						arrVal.add(strTransToOrgCode);
						arrVal.add(strTransToOrgDept);
						hshQry.put("strQueryId","ins_appmailbox_kpow");
						hshQry.put("arrValues",arrVal);
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
					}
			if(!Helper.correctNull((String)hshValues.get("txtapplicationno")).equalsIgnoreCase(""))
			{
				for(int i=0;i<strAppNo_val.length;i++)
				{
					strVal_Appno="";
					strVal_Appno=strAppNo_val[i];						
					intUpdatesize++;
					hshQry=new HashMap();
					arrVal=new ArrayList();
					arrVal.add(strToUserID);
					arrVal.add(strFromUserID);
					arrVal.add(strVal_Appno);	
					hshQry.put("strQueryId","updapplications_kpowertransfer");
					hshQry.put("arrValues",arrVal);
					hshQry.put("strAppendString","and ADDKBOW_APP_NO=?");
					hshqueryval.put("size",Integer.toString(intUpdatesize));
					hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
				}
			}else{
				intUpdatesize++;
				hshQry=new HashMap();
				arrVal=new ArrayList();
				arrVal.add(strToUserID);
				arrVal.add(strFromUserID);
				hshQry.put("strQueryId","updapplications_kpowertransfer");
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
			}
					//financial rating
					
					if(rs!=null)
						rs.close();
					if(!Helper.correctNull((String)hshValues.get("txtapplicationno")).equalsIgnoreCase(""))
					{
						strQuery=SQLParser.getSqlQuery("seluser_finratproposal_apptransfer^"+strFromUserID+"^"+strFromUserID+"^ and af_appno in('"+strappno+"')");		
						rs = DBUtils.executeQuery(strQuery);
					}
					else
					{
						strQuery=SQLParser.getSqlQuery("seluser_finratproposal_apptransfer^"+strFromUserID+"^ "+strFromUserID+"^ ");		
						rs = DBUtils.executeQuery(strQuery);
					}
					while(rs.next())
					{
						intUpdatesize++;
						hshQry=new HashMap();
						arrVal=new ArrayList();
						arrVal.add(Helper.correctNull((String)rs.getString("appno")));
						//arrVal.add(strFromUserID);
						arrVal.add(strTransferedBy);
						arrVal.add(strToUserID);
						arrVal.add("C");
						arrVal.add("Y");
						arrVal.add(strTransOrgCode);
						arrVal.add(strTransOrgDept);
						arrVal.add(strTransToOrgCode);
						arrVal.add(strTransToOrgDept);
						hshQry.put("strQueryId","insert_appmailbox1");
						hshQry.put("arrValues",arrVal);
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
					}	
			if(!Helper.correctNull((String)hshValues.get("txtapplicationno")).equalsIgnoreCase(""))
			{
				for(int i=0;i<strAppNo_val.length;i++)
				{
					strVal_Appno="";
					strVal_Appno=strAppNo_val[i];		
					intUpdatesize++;
					hshQry=new HashMap();
					arrVal=new ArrayList();
					arrVal.add(strToUserID);
					arrVal.add(strFromUserID);
					arrVal.add(strFromUserID);
					arrVal.add(strVal_Appno);	
					hshQry.put("strQueryId","updapplications_financialratingtransfer");
					hshQry.put("arrValues",arrVal);
					hshQry.put("strAppendString","and fin_ratappno=?");
					hshqueryval.put("size",Integer.toString(intUpdatesize));
					hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
				}
			}
			else{
				intUpdatesize++;
				hshQry=new HashMap();
				arrVal=new ArrayList();
				arrVal.add(strToUserID);
				arrVal.add(strFromUserID);
				arrVal.add(strFromUserID);
				hshQry.put("strQueryId","updapplications_financialratingtransfer");
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
			}
					//Permission
					
					if(rs!=null)
						rs.close();
					if(!Helper.correctNull((String)hshValues.get("txtapplicationno")).equalsIgnoreCase(""))
					{
						strQuery=SQLParser.getSqlQuery("seluser_permission_apptransfer^"+strFromUserID+"^ and DEV_APPNO in('"+strappno+"')");		
						rs = DBUtils.executeQuery(strQuery);
					}
					else
					{
						strQuery=SQLParser.getSqlQuery("seluser_permission_apptransfer^"+strFromUserID+"^ ");		
						rs = DBUtils.executeQuery(strQuery);
					}
					while(rs.next())
					{
						intUpdatesize++;
						hshQry=new HashMap();
						arrVal=new ArrayList();
						arrVal.add(Helper.correctNull(rs.getString("appno")));
						//arrVal.add(strFromUserID);
						arrVal.add(strTransferedBy);
						arrVal.add(strToUserID);
						arrVal.add(Helper.correctNull(rs.getString("DEV_FROMFLOWPOINT")));
						arrVal.add(Helper.correctNull(rs.getString("DEV_TOFLOWPOINT")));
						arrVal.add("C");
						arrVal.add(strTransOrgCode);
						arrVal.add(strTransOrgDept);
						arrVal.add(strTransToOrgCode);
						arrVal.add(strTransToOrgDept);
						arrVal.add("Y");
						hshQry.put("strQueryId","ins_dev_appmailbox1");
						hshQry.put("arrValues",arrVal);
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
					}	
			if(!Helper.correctNull((String)hshValues.get("txtapplicationno")).equalsIgnoreCase(""))
			{
				for(int i=0;i<strAppNo_val.length;i++)
				{
					strVal_Appno="";
					strVal_Appno=strAppNo_val[i];		
					intUpdatesize++;		
					hshQry=new HashMap();
					arrVal=new ArrayList();
					arrVal.add(strToUserID);
					arrVal.add(strFromUserID);
					arrVal.add(strVal_Appno);	
					hshQry.put("strQueryId","updapplications_permissiontransfer");
					hshQry.put("arrValues",arrVal);
					hshQry.put("strAppendString","and DEV_APPNO=?");
					hshqueryval.put("size",Integer.toString(intUpdatesize));
					hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
				}
			}
			else{
				intUpdatesize++;		
				hshQry=new HashMap();
				arrVal=new ArrayList();
				arrVal.add(strToUserID);
				arrVal.add(strFromUserID);
				hshQry.put("strQueryId","updapplications_permissiontransfer");
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
			}
				if(intUpdatesize>0)
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
	
				hshValues=getUserApplicationCount(hshValues);
				if(Helper.correctNull((String)hshValues.get("hidAction")).equalsIgnoreCase("Transfer"))
				{
					
					if(Helper.correctNull((String)hshValues.get("txtapplicationno")).equalsIgnoreCase(""))
					{
						String strTemp="";
						if(rs!=null)
							rs.close();
						
						rs=DBUtils.executeLAPSQuery("selratingpendingapp^"+strFromUserID);
						while(rs.next())
						{
							if(strTemp.equalsIgnoreCase(""))
							strTemp=strTemp+Helper.correctNull(rs.getString("cre_appno"));
							else
								strTemp=strTemp+","+Helper.correctNull(rs.getString("cre_appno"));
						}
						hshValues.put("strPendingProp",strTemp);
					}
					hshValues.put("status","Success");
				}
				
				return hshValues;
			
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updateUserApplicationTransfer "+e.toString());
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
	public HashMap getUserApplicationList(HashMap hshValues) 
	{	
		
		ResultSet rs = null;
		ArrayList arrCol		= new ArrayList();
		ArrayList arrRow		= new ArrayList();	
		String hidslno = "";
		String strValue="",strQuery="";
		
		try
		{
			if(rs!=null)
				rs.close();
			
			strValue=Helper.correctNull((String)hshValues.get("strFromUser"));
			
				strQuery = SQLParser.getSqlQuery("seluser_proposal^"+strValue+"^"+strValue+"^"+strValue+"^"+strValue+"^ ");
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrRow.add(correctNull(rs.getString("appnumber")));	
				}
				if(rs!=null)
					rs.close();
				
				strQuery = SQLParser.getSqlQuery("seluser_solproposal^"+strValue+"^"+strValue+"^"+strValue+"^"+strValue+"^"+strValue);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
						arrRow.add(correctNull(rs.getString("appno")));
				}
			
			hshValues.put("arrRow",arrRow);
			
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
		return hshValues;
	}
	public void updateAFOSetBranchMaster(HashMap hshValues) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshQry = new HashMap();
		ArrayList arrVal = new ArrayList();
		String action = correctNull((String)hshValues.get("hidAction"));
		int intUpdatesize=0;
		String strUserID=Helper.correctNull((String)hshValues.get("strUserId"));
		try
		{		
			if(action.equalsIgnoreCase("insert"))
			{
					intUpdatesize++;
					hshQry=new HashMap();
					arrVal=new ArrayList();
					hshQry.put("strQueryId","del_setafobranchmaster");
					arrVal.add(Helper.correctNull((String)hshValues.get("selafo_name")));
					hshQry.put("arrValues",arrVal);
					hshqueryval.put("size",Integer.toString(intUpdatesize));
					hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
					
					intUpdatesize++;
					hshQry=new HashMap();
					arrVal=new ArrayList();
					hshQry.put("strQueryId","ins_setafobranchmaster");
					arrVal.add(Helper.correctNull((String)hshValues.get("selafo_name")));
					arrVal.add(Helper.correctNull((String)hshValues.get("selafo_homebranch")));
					arrVal.add(Helper.correctNull((String)hshValues.get("hidClusterOrgcode")));
					arrVal.add(strUserID);
					hshQry.put("arrValues",arrVal);
					hshqueryval.put("size",Integer.toString(intUpdatesize));
					hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
					
			}
			else if(action.equalsIgnoreCase("delete"))
			{
					intUpdatesize++;
					hshQry=new HashMap();
					arrVal=new ArrayList();
					hshqueryval.put("size",String.valueOf(intUpdatesize));
					hshQry.put("strQueryId","del_setafobranchmaster");
					arrVal.add(Helper.correctNull((String)hshValues.get("selafo_name")));
					hshQry.put("arrValues",arrVal);
					hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
			}
			
			if(intUpdatesize>0)
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updateAFOSetBranchMaster "+e.toString());
		}
	}
	public HashMap getAFOSetBranchMaster(HashMap hshValues) 
	{	
		
		ResultSet rs = null;
		String strQuery="";
		
		try
		{
			if(!Helper.correctNull((String)hshValues.get("selafo_name")).equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("sel_setafobranchmaster^"+Helper.correctNull((String)hshValues.get("selafo_name")));
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshValues.put("strAFOUserID",Helper.correctNull(rs.getString("sbm_userid")));
					hshValues.put("strAFOHomeBranch",Helper.correctNull(rs.getString("sbm_homeorgcode")));
					hshValues.put("strClusterBranch",Helper.correctNull(rs.getString("sbm_clusterbranchcode")));
				}
				else
				{
					hshValues.put("strAFOUserID",Helper.correctNull((String)hshValues.get("selafo_name")));
				}
			}
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getAFOSetBranchMaster "+ce.toString());
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
		return hshValues;
	}
	public HashMap updateAFOClusterBranchSelection(HashMap hshValues) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshQry = new HashMap();
		ArrayList arrVal = new ArrayList();
		String action = correctNull((String)hshValues.get("hidAction"));
		int intUpdatesize=0;
		String strUserID=Helper.correctNull((String)hshValues.get("strUserId"));
		ResultSet rs=null;
		String strBranchCode="";
		try
		{		
			if(action.equalsIgnoreCase("HomeBranch"))
			{
					rs=DBUtils.executeLAPSQuery("sel_setafobranchmaster^"+strUserID);
					if(rs.next())
					{
						strBranchCode=Helper.correctNull(rs.getString("sbm_homeorgcode"));
					}
				
					intUpdatesize++;
					hshQry=new HashMap();
					arrVal=new ArrayList();
					hshQry.put("strQueryId","upduserorgcode");
					arrVal.add(strBranchCode);
					arrVal.add(strUserID);
					hshQry.put("arrValues",arrVal);
					hshqueryval.put("size",Integer.toString(intUpdatesize));
					hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
			}
			else if(action.equalsIgnoreCase("ClusterBranch"))
			{
				
					strBranchCode=Helper.correctNull((String)hshValues.get("selcluster_name"));
					if(!strBranchCode.equalsIgnoreCase(""))
					{
						intUpdatesize++;
						hshQry=new HashMap();
						arrVal=new ArrayList();
						hshQry.put("strQueryId","upduserorgcode");
						arrVal.add(strBranchCode);
						arrVal.add(strUserID);
						hshQry.put("arrValues",arrVal);
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
					}
			}
			
			if(intUpdatesize>0)
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			
			hshValues=getAFOClusterBranchSelection(hshValues);	
			if(action.equalsIgnoreCase("HomeBranch"))
			{
				hshValues.put("strHomeFlag","Y");
			}
			else if(action.equalsIgnoreCase("ClusterBranch"))
			{
				hshValues.put("strClusterFlag","Y");
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updateAFOSetBranchMaster "+e.toString());
		}
		return hshValues;
	}
	public HashMap getAFOClusterBranchSelection(HashMap hshValues) 
	{	
		
		ResultSet rs = null;
		String strQuery="";
		String strUserId=Helper.correctNull((String)hshValues.get("strUserId"));
		int applicationsCount=0;
		try
		{
			rs = DBUtils.executeLAPSQuery("applications_mailbox_totcount^" + strUserId);
			if(rs.next())
				applicationsCount=rs.getInt("cnt");
			
			if(applicationsCount < 1)
			{
				if(rs!=null) 
					rs.close();
				rs = DBUtils.executeLAPSQuery("sel_userappcount^" + strUserId+"^"+strUserId+"^"+strUserId);
				while(rs.next())
				{
					applicationsCount=applicationsCount+rs.getInt("count");	
				}
			}
			if(applicationsCount>0)
				hshValues.put("mailboxcount","Y");
			else
				hshValues.put("mailboxcount","N");
			
			
			if(rs!=null)
				rs.close();
			
			rs=DBUtils.executeLAPSQuery("selratingpendingapp^"+strUserId);
			if(rs.next())
			{
				hshValues.put("strKalyptoFlag","Y");
			}
			else
			{
				hshValues.put("strKalyptoFlag","N");
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getAFOSetBranchMaster "+ce.toString());
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
		return hshValues;
	}
	public HashMap updateShareValueMasterData(HashMap hshValues)
	{	
		
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery =null;
		ArrayList arrValues = null;
		String strAction =null,strMaxSno="";
		ResultSet rs=null;
		try
		{
			strAction = Helper.correctNull((String)hshValues.get("hidAction"));
			if (strAction.equalsIgnoreCase("insert"))
			{
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeLAPSQuery("selmaxcompanycode");
				if(rs.next()){
					strMaxSno = Helper.correctNull(rs.getString("companycode"));
				}
				
				hshValues.put("hidcompanycode",strMaxSno);
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(strMaxSno);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_CIN_no")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Companyname")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_facevalue")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_networth")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_networthasondate")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_avgmarketval")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_marketval")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_marketvalasondate")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_paidupcapital")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_paidupcapitalasondate")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("hidtype")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_approve")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_reservescapital")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_active")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));				
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","inssharevaluemaster");
				hshQueryValues.put("size","1");					
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
			else if (strAction.equalsIgnoreCase("update"))
			{
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(Helper.correctNull((String)hshValues.get("hidcompanycode")));
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","inssharemaster_history");
				hshQueryValues.put("size","1");					
				hshQueryValues.put("1",hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_CIN_no")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Companyname")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_facevalue")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_networth")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_networthasondate")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_avgmarketval")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_marketval")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_marketvalasondate")));					
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_paidupcapital")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_paidupcapitalasondate")));	
				arrValues.add(Helper.correctNull((String)hshValues.get("hidtype")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_approve")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_reservescapital")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_active")));
				arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidcompanycode")));
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","updsharevaluemaster");
				hshQueryValues.put("size","2");					
				hshQueryValues.put("2",hshQuery);
				
				if(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_avgmarketval")))!=Double.parseDouble(Helper.correctDouble((String)hshValues.get("hid_avgmarketval"))))
				{
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_avgmarketval")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_avgmarketval")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_avgmarketval")));
					arrValues.add(Helper.correctNull((String)hshValues.get("hidcompanycode")));
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","updsecval_loanagainstshare");
					hshQueryValues.put("size","3");					
					hshQueryValues.put("3",hshQuery);
				}
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
			else if (strAction.equalsIgnoreCase("delete"))
			{
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(Helper.correctNull((String)hshValues.get("hidcompanycode")));
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","delsharevaluemaster");
				hshQueryValues.put("size","1");					
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
			
			hshValues=getShareValueMasterData(hshValues);
		}
		catch (Exception ce)
		{
			throw new EJBException("Error in updateShareValueMasterData --> "+ce.toString());
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
		return hshValues;
	}
	public HashMap getShareValueMasterData(HashMap hshValues) 
	{
		String strQuery=null;
		ResultSet rs=null,rs1=null;
		String strAction=null,strSearchBy=null,strTemp=" ",strSearchString="",strSecType="",strHidparam="";
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		try
		{
			strAction=Helper.correctNull((String)hshValues.get("hidAction"));
			strSearchBy=Helper.correctNull((String)hshValues.get("SearchStatus"));
			strSearchString=Helper.correctNull((String)hshValues.get("txt_company_name"));
			strSecType=Helper.correctNull((String)hshValues.get("SecType"));
			strHidparam=Helper.correctNull((String)hshValues.get("hidparam"));
			if(strAction.equalsIgnoreCase("search"))
			{
				if(strSearchBy.equalsIgnoreCase("cinno"))
				{
					strTemp=" where svm_companycinno='"+strSearchString+"'";
				}
				else if(strSearchBy.equalsIgnoreCase("name"))
				{
					strTemp=" where upper(svm_companyname) like '"+strSearchString.toUpperCase()+"%%%%'";
				}
				
				if(Helper.correctNull((String)hshValues.get("pagefrom")).equalsIgnoreCase("securitymaster") && !strSecType.equalsIgnoreCase(""))
				{
					if(strTemp.equalsIgnoreCase(""))
						strTemp=" where svm_sharetype  like '%@"+strSecType+"@%'  and svm_companyactiveflag='y'";
					else
						strTemp=strTemp+ " and svm_sharetype  like '%@"+strSecType+"@%' and svm_companyactiveflag='y'";
				}
				if(Helper.correctNull((String)hshValues.get("hidparam")).equalsIgnoreCase("allValues")){
					strQuery=SQLParser.getSqlQuery("selcompanymasterdetails1");
					rs=DBUtils.executeQuery(strQuery);
				}else{
				strQuery=SQLParser.getSqlQuery("selcompanymasterdetails^"+strTemp);
				rs=DBUtils.executeQuery(strQuery);
				}
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull(rs.getString("svm_companycode")));//0
					arrCol.add(Helper.correctNull(rs.getString("svm_companycinno")));//1
					arrCol.add(Helper.correctNull(rs.getString("svm_companyname")));//2
					arrCol.add(Helper.correctNull(rs.getString("svm_facevalue")));//3
					arrCol.add(Helper.correctNull(rs.getString("svm_companynetworth")));//4
					arrCol.add(Helper.correctNull(rs.getString("svm_companynetworthason")));//5
					arrCol.add(Helper.correctNull(rs.getString("svm_companyavgmarketval")));//6
					arrCol.add(Helper.correctNull(rs.getString("svm_companymarketval")));//7
					arrCol.add(Helper.correctNull(rs.getString("svm_companymarketvalason")));//8
					arrCol.add(Helper.correctNull(rs.getString("svm_companypaidup")));//9
					arrCol.add(Helper.correctNull(rs.getString("svm_companypaidupason")));//10
					arrCol.add(Helper.correctNull(rs.getString("svm_sharetype")));//11
					arrCol.add(Helper.correctNull(rs.getString("svm_companyapproveflag")));//12
					arrCol.add(Helper.correctNull(rs.getString("svm_companyreservescapital")));//13
					arrCol.add(Helper.correctNull(rs.getString("svm_companyactiveflag")));//14
					String strShareName="";
					if(Helper.correctNull((String)hshValues.get("hidparam")).equalsIgnoreCase("allValues")){
						String Strshare=Helper.correctNull(rs.getString("svm_sharetype"));
						String []Sharedata=Strshare.split("@");
						for(int i=0;i<Sharedata.length-1;i++)
						{
							if(rs1!=null)
								rs1.close();
							strQuery=SQLParser.getSqlQuery("sel_Securityvalues^"+Sharedata[i+1]);
							rs1=DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{	
								strShareName=strShareName+"@"+(Helper.correctNull(rs1.getString("sec_id"))+"~"+Helper.correctNull(rs1.getString("sec_name")));//01
							}
							
						}
					}
					arrCol.add(strShareName.replaceFirst("@", ""));//15
					arrRow.add(arrCol);
				}
				
				hshValues.put("arrRow",arrRow);
			}
			else if(strAction.equalsIgnoreCase("insert")||strAction.equalsIgnoreCase("update"))
			{
				strQuery=SQLParser.getSqlQuery("selcompanymaster_comname^"+Helper.correctNull((String)hshValues.get("hidcompanycode")));
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshValues.put("svm_companycode", Helper.correctNull(rs.getString("svm_companycode")));
					hshValues.put("svm_companycinno", Helper.correctNull(rs.getString("svm_companycinno")));
					hshValues.put("svm_companyname", Helper.correctNull(rs.getString("svm_companyname")));
					hshValues.put("svm_facevalue", Helper.correctNull(rs.getString("svm_facevalue")));
					hshValues.put("svm_companynetworth", Helper.correctNull(rs.getString("svm_companynetworth")));
					hshValues.put("svm_companynetworthason", Helper.correctNull(rs.getString("svm_companynetworthason")));
					hshValues.put("svm_companyavgmarketval", Helper.correctNull(rs.getString("svm_companyavgmarketval")));
					hshValues.put("SVM_COMPANYMARKETVALASON", Helper.correctNull(rs.getString("SVM_COMPANYMARKETVALASON")));
					hshValues.put("svm_companypaidup", Helper.correctNull(rs.getString("svm_companypaidup")));
					hshValues.put("svm_companypaidupason", Helper.correctNull(rs.getString("svm_companypaidupason")));
					hshValues.put("svm_companymarketval", Helper.correctNull(rs.getString("svm_companymarketval")));
					hshValues.put("svm_sharetype", Helper.correctNull(rs.getString("svm_sharetype")));
					hshValues.put("svm_companyapproveflag", Helper.correctNull(rs.getString("svm_companyapproveflag")));
					hshValues.put("svm_companyreservescapital", Helper.correctNull(rs.getString("svm_companyreservescapital")));
					hshValues.put("svm_companyactiveflag", Helper.correctNull(rs.getString("svm_companyactiveflag")));
				}
			}
			hshValues.put("strAction", strAction);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getShareValueMasterData "+ce.toString());
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
		return hshValues;
	}
	public HashMap getShareMasterHistory(HashMap hshValues) 
	{
		
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		String strQuery=null,strTemp="",strType="";
		ResultSet rs=null,rs1=null;
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		try
		{
			strTemp=Helper.correctNull((String)hshValues.get("strCompanyNo"));
			if(!strTemp.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("selsharemasterhistory^"+strTemp);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull(rs.getString("svm_companycode")));//0
					arrCol.add(Helper.correctNull(rs.getString("svm_companycinno")));//1
					arrCol.add(Helper.correctNull(rs.getString("svm_companyname")));//2
					arrCol.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("svm_facevalue")))));//3
					arrCol.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("svm_companynetworth")))));//4
					arrCol.add(Helper.correctNull(rs.getString("svm_companynetworthason")));//5
					arrCol.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("svm_companyavgmarketval")))));//6
					arrCol.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("svm_companymarketval")))));//7
					arrCol.add(Helper.correctNull(rs.getString("svm_companymarketvalason")));//8
					arrCol.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("svm_companypaidup")))));//9
					arrCol.add(Helper.correctNull(rs.getString("svm_companypaidupason")));//10
					strType="";
					if(!Helper.correctNull(rs.getString("svm_sharetype")).equalsIgnoreCase(""))
					{
						String strTemp1=Helper.correctNull(rs.getString("svm_sharetype"));
						strTemp1=strTemp1.substring(1, strTemp1.length()-1);
						strTemp1=strTemp1.replaceAll("@", ",");
						
						if(rs1!=null)
							rs1.close();
						strQuery=SQLParser.getSqlQuery("selSchemeSecurity^6^ in ("+strTemp1+")");
						rs1=DBUtils.executeQuery(strQuery);
						while(rs1.next())
						{
							strType=strType+Helper.correctNull(rs1.getString("sec_name"))+"\n";
						}
					}
					arrCol.add(strType);//11
					arrCol.add(Helper.correctNull(rs.getString("svm_companyapproveflag")));//12
					arrCol.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("svm_companyreservescapital")))));//13
					arrCol.add(Helper.correctNull(rs.getString("svm_companyactiveflag")));//14
					arrCol.add(Helper.correctNull(rs.getString("svm_modifieduser")));//15
					arrCol.add(Helper.correctNull(rs.getString("svm_modifieddate")));//16
					arrRow.add(arrCol);
				}
			}
			
			hshValues.put("arrRow",arrRow);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getShareMasterHistory "+ce.toString());
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
		return hshValues;
	}
	public void updateSMSMaster(HashMap hshValues)
	{	
		
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery =null;
		ArrayList arrValues = null;
		try
		{
			if(Helper.correctNull((String)hshValues.get("hidPageFrom")).equalsIgnoreCase("O"))
			{
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upd_sms_master");
				hshQueryValues.put("1",hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_LARSubmission")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_approval")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_rejectionmsg")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_CBSIdCreation")));	
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_AccountCreation")));	
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_FieldInvestigation")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_KycNotCompleted")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_smsforcar")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_smsforabm")));
				//arrValues.add(Helper.correctNull((String)hshValues.get("txt_ProvisionMessage")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_smsforppa")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_smsforpspa")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_smsforppr")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_smsforpspr")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_smsforpps")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_smsforpsps")));
				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_security_90")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_security_60")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_security_30")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_security_07")));
				
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_sms_master");
				hshQueryValues.put("size","2");					
				hshQueryValues.put("2",hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
			else if(Helper.correctNull((String)hshValues.get("hidPageFrom")).equalsIgnoreCase("L"))
			{
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(Helper.correctNull((String)hshValues.get("seltype")));
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upd_sms_master_others");
				hshQueryValues.put("1",hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_LARCreation")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_LARApproval")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_LARRejection")));	
				arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
				arrValues.add(Helper.correctNull((String)hshValues.get("seltype")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_ProvisionMessage")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_sendsms")));
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_sms_master_others");
				hshQueryValues.put("size","2");					
				hshQueryValues.put("2",hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
		}
		catch (Exception ce)
		{
			throw new EJBException("Error in updateSMSMaster --> "+ce.toString());
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
	public HashMap getSMSMaster(HashMap hshValues) 
	{
		String strQuery=null;
		ResultSet rs=null;
		try
		{
			if(Helper.correctNull((String)hshValues.get("hidPageFrom")).equalsIgnoreCase("O"))
			{
				rs=DBUtils.executeLAPSQuery("sel_sms_master");
				if(rs.next())
				{
					hshValues.put("strProcessMsg", Helper.correctNull(rs.getString("sms_process")));
					hshValues.put("strApprovedMsg", Helper.correctNull(rs.getString("sms_approved")));
					hshValues.put("strRejectMsg", Helper.correctNull(rs.getString("sms_reject")));
					hshValues.put("strDSAProcessMsg", Helper.correctNull(rs.getString("sms_dsabsa_inprocess")));
					hshValues.put("strDSAApprovedMsg", Helper.correctNull(rs.getString("sms_dsabsa_approved")));
					hshValues.put("strDSARejectMsg", Helper.correctNull(rs.getString("sms_dsabsa_reject")));
					hshValues.put("strCBSIdMsg", Helper.correctNull(rs.getString("SMS_CBS_ID_CREATION")));
					hshValues.put("strAccountMsg", Helper.correctNull(rs.getString("SMS_CBS_ACCOUNT_CREATION")));
					hshValues.put("strMessage", Helper.correctNull(rs.getString("FIELD_INVESTIGATION_COMPLETED")));
					hshValues.put("strKycNotComptdMsg", Helper.correctNull(rs.getString("KYC_NOT_COMPLETED")));
					hshValues.put("SMS_CARLOAN", Helper.correctNull(rs.getString("SMS_CARLOAN")));
					hshValues.put("SMS_ABMQUERY", Helper.correctNull(rs.getString("SMS_ABMQUERY")));
					hshValues.put("SMS_PERMIS_APPROVED", Helper.correctNull(rs.getString("SMS_PERMIS_APPROVED")));
					hshValues.put("SMS_POST_APPROVED", Helper.correctNull(rs.getString("SMS_POST_APPROVED")));
					hshValues.put("SMS_PERMIS_REJECT", Helper.correctNull(rs.getString("SMS_PERMIS_REJECT")));
					hshValues.put("SMS_POST_REJECT", Helper.correctNull(rs.getString("SMS_POST_REJECT")));
					hshValues.put("SMS_PERMIS_SEND", Helper.correctNull(rs.getString("SMS_PERMIS_SEND")));
					hshValues.put("SMS_POST_SEND", Helper.correctNull(rs.getString("SMS_POST_SEND")));
					
					hshValues.put("SMS_SECURITY_90", Helper.correctNull(rs.getString("SMS_SECURITY_90")));
					hshValues.put("SMS_SECURITY_60", Helper.correctNull(rs.getString("SMS_SECURITY_60")));
					hshValues.put("SMS_SECURITY_30", Helper.correctNull(rs.getString("SMS_SECURITY_30")));
					hshValues.put("SMS_SECURITY_07", Helper.correctNull(rs.getString("SMS_SECURITY_07")));
					

				}
			}
			else if(Helper.correctNull((String)hshValues.get("hidPageFrom")).equalsIgnoreCase("L"))
			{
				rs=DBUtils.executeLAPSQuery("sel_sms_master_others^"+Helper.correctInt((String)hshValues.get("seltype")));
				if(rs.next())
				{
					hshValues.put("strLARProcess", Helper.correctNull(rs.getString("sms_inprocess")));
					hshValues.put("strLARApproval", Helper.correctNull(rs.getString("sms_approved")));
					hshValues.put("strLARRejection", Helper.correctNull(rs.getString("sms_rejected")));
					hshValues.put("strLARProvision", Helper.correctNull(rs.getString("sms_provision")));
					//hshValues.put("SMS_TRIGGRING", Helper.correctNull(rs.getString("SMS_TRIGGRING")));
				}
				if(rs!=null)
				{
					rs.close();					
				}
				rs=DBUtils.executeLAPSQuery("sel_sms_masterss^"+Helper.correctInt((String)hshValues.get("seltype")));
				if(rs.next())
				{
					hshValues.put("SMS_CARLOAN", Helper.correctNull(rs.getString("SMS_CARLOAN")));	
					hshValues.put("SMS_ABMQUERY", Helper.correctNull(rs.getString("SMS_ABMQUERY")));
					hshValues.put("SMS_TRIGGRING", Helper.correctNull(rs.getString("SMS_TRIGGRING")));
				}
				if(rs!=null)
				{
					rs.close();					
				}
				rs=DBUtils.executeLAPSQuery("sel_sendsms^"+Helper.correctInt((String)hshValues.get("seltype")));
				if(rs.next())
				{
					hshValues.put("stat_data_desc", Helper.correctNull(rs.getString("stat_data_desc")));	
					
				}
				hshValues.put("strType", Helper.correctInt((String)hshValues.get("seltype")));
			}
				
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getSMSMaster "+ce.toString());
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
		return hshValues;
	}
	
	public HashMap getPostSancParameters(HashMap hshValues)  
	{
		ResultSet rs1 = null; 
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=new ArrayList();
		String strPageFrom="",strForm="";
		String strTemp="";
		try 
		{		 strForm=Helper.correctNull((String)hshValues.get("hidParam"));
				if(strForm.equalsIgnoreCase("P"))
					strTemp="'P'";
				else
					strTemp="'C'";
				String strQuery = SQLParser.getSqlQuery("sel_PostSancparamerters^"+strTemp);
				rs1=DBUtils.executeQuery(strQuery);				
				while (rs1.next()) 
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull(rs1.getString("PS_PARAM_DESC")));//0
					arrCol.add(Helper.correctNull(rs1.getString("PS_PARAM")));//1
					arrCol.add(Helper.correctNull(rs1.getString("PS_PARAM_ORGLEVEL")));//2
					arrCol.add(Helper.correctNull(rs1.getString("PS_PARAM_MINCLASS")));//3
					String flag=Helper.correctNull(rs1.getString("PS_ENABLE_DISABLE_FLAG"));
					//4 added newly starts
					if(flag.equalsIgnoreCase("")){
						arrCol.add("S");
					}else{
						arrCol.add(Helper.correctNull(rs1.getString("PS_ENABLE_DISABLE_FLAG")));
					}
					//4 ends
					arrRow.add(arrCol);
				}
				hshValues.put("arrRow",arrRow);
				
		} 
		catch (Exception e) 
		{
			throw new EJBException("Error in getPostSancParameters "+e.toString());
		} 
		return hshValues;
	}
	
	public HashMap updatePostSancParameters(HashMap hshValues)  
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshQry = new HashMap();
		ArrayList arrVal = new ArrayList();
		StringBuilder sbAuditTrial=new StringBuilder();
		String strKeyId = "",strRecordFlag = "";
		String strForm="";
		try 
		{
			int intUpdatesize = 0;			
			hshqueryval = new HashMap();
			String []strNoofyears = null;
			String []strglobalslno=null;		
			String []strglobalsdesc=null;
			String []strMinClass=null;
			String []strModule=null;
			
			// added newely starts
			String []strenableDisable=null; 
			if(hshValues.get("txt_enabledisable") instanceof java.lang.String)
			{
				strenableDisable=new String[1];
				strenableDisable[0]=Helper.correctNull((String)hshValues.get("txt_enabledisable"));				
			}
			else
			{			
				strenableDisable =(String[])hshValues.get("txt_enabledisable");
			}
			// ends 
			
			if(hshValues.get("hidtxt_orgLevel") instanceof java.lang.String)
			{
				strNoofyears=new String[1];
				strNoofyears[0]=Helper.correctNull((String)hshValues.get("hidtxt_orgLevel"));				
			}
			else
			{			
			      strNoofyears =(String[])hshValues.get("hidtxt_orgLevel");
			}
			if(hshValues.get("txt_minClass") instanceof java.lang.String)
			{
				strMinClass=new String[1];
				strMinClass[0]=Helper.correctNull((String)hshValues.get("txt_minClass"));				
			}
			else
			{			
				strMinClass =(String[])hshValues.get("txt_minClass");
			}
			
			if(hshValues.get("hidparam_desc") instanceof java.lang.String)
			{
				strglobalslno=new String[1];
				strglobalslno[0]=Helper.correctNull((String)hshValues.get("hidparam_desc"));				
			}
			else
			{			
				strglobalslno =(String[])hshValues.get("hidparam_desc");
			}
			
			if(hshValues.get("txt_class_desc") instanceof java.lang.String)
			{
				strglobalsdesc=new String[1];
				strglobalsdesc[0]=Helper.correctNull((String)hshValues.get("txt_class_desc"));				
			}
			else
			{			
				strglobalsdesc =(String[])hshValues.get("txt_class_desc");
			}
					
			strKeyId = Helper.correctNull((String)hshValues.get("org_code"));
			strRecordFlag = Helper.correctNull((String)hshValues.get("auditflag"));
			strForm=Helper.correctNull((String)hshValues.get("hidParam"));
			int len=strNoofyears.length;
			
			intUpdatesize=intUpdatesize+1;		
			hshQry = new HashMap();				
			arrVal=new ArrayList();	
			if(strForm.equalsIgnoreCase("P")){
			hshQry.put("strQueryId","del_postSancParameter_ret");	
			}else
			{hshQry.put("strQueryId","del_postSancParameter_corp");}
			hshQry.put("arrValues", arrVal);
			hshqueryval.put("size",String.valueOf(intUpdatesize));
			hshqueryval.put(String.valueOf(intUpdatesize),hshQry);
			
			for(int k=0;k<len;k++)
			{
					hshQry = new HashMap();
					arrVal = new ArrayList();
					intUpdatesize=intUpdatesize+1;				
					arrVal.add(strglobalslno[k]);
					arrVal.add(strNoofyears[k]);
					arrVal.add(strMinClass[k]);
					if(strForm.equalsIgnoreCase("P")){
						arrVal.add("P");
						}else
						{arrVal.add("");}
					//arrVal.add("P");
					arrVal.add(strenableDisable[k]); // added newly
					hshQry.put("arrValues",arrVal);
					hshQry.put("strQueryId","ins_PostSancParameters");
					hshqueryval.put("size",String.valueOf(intUpdatesize));
					hshqueryval.put(String.valueOf(intUpdatesize),hshQry);
					sbAuditTrial.append("~").append(strglobalsdesc[k]);
					sbAuditTrial.append("=").append(strNoofyears[k]);	
			}
			
			//-------------------------------Audittrial-------------------------------
			if(strRecordFlag.equalsIgnoreCase("Y")){
				hshValues.put("hidAction", "update");
			}else if(strRecordFlag.equalsIgnoreCase("N")){
				hshValues.put("hidAction", "insert");
			}
			
			if(intUpdatesize>0)
 				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			
			AuditTrial.auditLog(hshValues,"78",strKeyId,sbAuditTrial.toString());
			//----------------------------------End-----------------------------------
			hshqueryval.put("hidfrom", Helper.correctNull((String)hshValues.get("hidfrom")));
			hshqueryval = getPostSancParameters(hshValues);
		} 
		catch (Exception e) 
		{
			throw new EJBException("Error in bean "+e.toString());
		}		
		return hshqueryval;
	}
	
	
	public HashMap getTownMasterList(HashMap hshValues) 
	{			
		ResultSet rs = null;
		HashMap hshRecord =new HashMap();
		ArrayList vecRow = new ArrayList();	
		try
		{
			String strdistId = "";
			String str_pagename="";
			strdistId = Helper.correctInt((String)hshValues.get("strdistId"));
			
			str_pagename = Helper.correctNull((String)hshValues.get("mastername"));
			if(!str_pagename.equalsIgnoreCase(""))
			{
				rs = DBUtils.executeLAPSQuery("sel_town_master^"+strdistId);
				
			}else
			{
				rs = DBUtils.executeLAPSQuery("sel_gentown_master^"+strdistId);
			}
			while(rs.next())
				{
					ArrayList vecCol= new ArrayList();
					vecCol.add(correctNull(rs.getString("DISTRICT_CODE")));
					vecCol.add(correctNull(rs.getString("TOWN_CODE")));
					vecCol.add(correctNull(rs.getString("TOWN_DESC")));
					vecCol.add(correctNull(rs.getString("TOWN_SNO")));
					vecCol.add(correctNull(rs.getString("TOWN_ACTION")));

					vecRow.add(vecCol);							
				}	
			
				hshRecord.put("vecRow",vecRow);
				
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getTownMasterList "+ce.toString());
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
	
	
	
	
	public void updateTownMasterData(HashMap hshValues)
	{	
		ResultSet rs = null;
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrval = new ArrayList();
		String strTownCode="",strExcep="$",strsId="";
		int strsId1=0;
		
		try
		{
			String strFlag = Helper.correctNull((String) hshValues.get("hidAction"));
			
			if(strFlag.equalsIgnoreCase("Insert"))
			{
				strTownCode=Helper.correctNull((String) hshValues.get("txt_towncode"));
				
				rs=DBUtils.executeLAPSQuery("selTownCodeCheckDuplication^"+strTownCode);
				if(rs.next())
				{
					if(!rs.getString(1).equalsIgnoreCase(""))
					{
						strExcep=strExcep+"Already the Town Code Exist.";
						throw new Exception(strExcep);
					}
				}
				if(rs!=null)
					rs.close();

				rs=DBUtils.executeLAPSQuery("selmaxtownid");
				if(rs.next())
				{
					strsId = Helper.correctInt((String)rs.getString("townidmax"));
					strsId1=Integer.parseInt(strsId);
					strsId1=strsId1+1;
				}
				else
				{
					strsId1 = 1;
				}
			}	
			if(strFlag.equalsIgnoreCase("Insert"))
			{
				arrval.add(Helper.correctNull((String) hshValues.get("txt_district")));
				arrval.add(Helper.correctNull((String) hshValues.get("txt_towncode")));
				arrval.add(Helper.correctNull((String) hshValues.get("txt_town")));
				arrval.add(Helper.correctNull((String) hshValues.get("sel_active")));

				arrval.add(String.valueOf(strsId1));
				
				hshQuery.put("arrValues",arrval);
				hshQueryValues.put("1", hshQuery);
				hshQuery.put("strQueryId","ins_town_desc");
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}else if(strFlag.equalsIgnoreCase("Update"))
			{
				arrval.add(Helper.correctNull((String) hshValues.get("txt_town")));
				arrval.add(Helper.correctNull((String) hshValues.get("sel_active")));
				arrval.add(Helper.correctNull((String) hshValues.get("hidtownid")));
				
				hshQuery.put("arrValues",arrval);
				hshQueryValues.put("1", hshQuery);
				hshQuery.put("strQueryId","upd_town_desc");
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
		}
		catch (Exception ce)
		{
			throw new EJBException("Error in updateTownMasterData --> "+ce.toString());
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
	
	//==============================================BIR MASTER CHANGES=================================================//
	public void updateBIRmasterData(HashMap hshValues)
	{	 
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();	 
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		ResultSet rs1 = null;
		String strOrgCode=""; 
	 	String strAction = null;		 
		String strslno = "",strSeqno="";
		
		String strAppvalue = "";
		String strQuery="",strExp="$",strsno="",strCBSID="";
		
		strOrgCode=Helper.correctNull((String)hshValues.get("org_code"));
		strsno=Helper.correctNull((String)hshValues.get("hidseqno"));
		strAppvalue=correctNull((String) hshValues.get("hidAppVal"));	
		strCBSID=Helper.correctNull((String)hshValues.get("txt_cbscustid"));
		String[] txt_regno;
		String txt_regnoappend="";
		String[] txt_bankname;
		String txt_banknameappend="";
		String[] txt_bankcode;
		String txt_bankcodeappend="";
		String[] txt_dsaservbankcode;
		String txt_dsaservbankcodeappend="";
		String[] txt_dsaservbankname;
		String txt_dsaservbanknameappend="";
		String[] txt_empsincedate;
		String txt_empsincedateappend="";
		try
		{
			strSeqno=correctNull((String) hshValues.get("hidAgentID"));
			
			strOrgCode = correctNull((String)hshValues.get("org_code"));
			strAction = correctNull((String)hshValues.get("hid_action"));
			strslno	= correctNull((String )hshValues.get("hidsno"));
			hshValues.put("strAction", strAction);
			
			//bank code
			if(hshValues.get("txt_dsaservBank") instanceof String[])
			{
				txt_dsaservbankname = (String[])hshValues.get("txt_dsaservBank");
				  for(int i=0;i<txt_dsaservbankname.length;i++)
				  {
					  if(!txt_dsaservbankname[i].equals(""))
					  txt_dsaservbanknameappend=txt_dsaservbanknameappend+"@"+txt_dsaservbankname[i];
				  }
				  txt_dsaservbanknameappend=txt_dsaservbanknameappend.replaceFirst("@","");
			}
			else
			{
				txt_dsaservbanknameappend=Helper.correctNull((String) hshValues.get("txt_dsaservBank"));
			}
			
			if(hshValues.get("hid_dsaservBankcode") instanceof String[])
			{
				txt_dsaservbankcode = (String[])hshValues.get("hid_dsaservBankcode");
				  for(int i=0;i<txt_dsaservbankcode.length;i++)
				  {
					  if(!txt_dsaservbankcode[i].equals(""))
					  txt_dsaservbankcodeappend=txt_dsaservbankcodeappend+"@"+txt_dsaservbankcode[i];
				  }
				  txt_dsaservbankcodeappend=txt_dsaservbankcodeappend.replaceFirst("@","");
			}
			else
			{
				txt_dsaservbankcodeappend=Helper.correctNull((String) hshValues.get("hid_dsaservBankcode"));
			}
			StringBuilder strOldAudit = new StringBuilder();
			if(strAction.equalsIgnoreCase("Update"))
			{
				if(rs!=null)
				{
					rs.close();
				}
				rs = DBUtils.executeLAPSQuery("sel_BSADSAmaster_id^"+strSeqno);
				if(rs.next()){
					
					strOldAudit.append("~BSA / DSA  Name = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("BIR_NAME")));
					strOldAudit.append("~BSA / DSA  Address = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("BIR_ADDRESS1"))+ " "+Helper.correctNull((String)rs.getString("BIR_ADDRESS2")));
					strOldAudit.append("~ City   = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BIR_CITY")));
					strOldAudit.append("~ State  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BIR_STATE")));
					strOldAudit.append("~ Country  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BIR_COUNTRY")));
					strOldAudit.append("~ PINCODE  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BIR_PINCODE")));
					strOldAudit.append("~ CONSTITUTION  = ");	
					if(rs1 != null)
						rs1.close();					
					strQuery = SQLParser.getSqlQuery("selconstitutiondesc^"+Helper.correctNull((String)rs.getString("BIR_CONSTITUTION")));
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						strOldAudit.append(correctNull(rs1.getString("cbs_static_data_desc")));
					}
					
					strOldAudit.append("~ NONINDVNAME  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BIR_NONINDVNAME")));
					strOldAudit.append("~ MOBILENON  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BIR_MOBILENON")));
					strOldAudit.append("~ TELEPHONENO  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BIR_TELEPHONENO")));
					strOldAudit.append("~ EMAILID  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BIR_EMAILID")));
					strOldAudit.append("~ GST  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BIR_GST")));
					strOldAudit.append("~ KEY PERSON  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BIR_KEYPERSON")));
					strOldAudit.append("~ Designation of Key Person  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BIR_DESIGN_KEYPERSON")));
					strOldAudit.append("~ Bank Type   = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BIR_ACCTYPE")).equals("S")?"Savings":"Current");
					strOldAudit.append("~ Name of the Bank = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BIR_BANKNAME")));
					strOldAudit.append("~ Bank Branch = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BIR_BANKBRANCH")));
					strOldAudit.append("~ IFSC code   = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BIR_IFSC")));
					strOldAudit.append("~ Bank Account number   = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BIR_ACCNO")));
					strOldAudit.append(Helper.correctNull((String)rs.getString("BIR_EXPIRY_DATE")));
					strOldAudit.append("~ ACTION  = ");	
					if(Helper.correctNull((String)rs.getString("BIR_ACTION")).equals("E"))
						strOldAudit.append("Enabled");
					else	
						strOldAudit.append("Disabled");
					strOldAudit.append("~ Presently providing BIR services = ");	
					String dsaservbankname="";
					if(!correctNull(rs.getString("BIR_SERVICE_BANK")).equals(""))
					{
						
						String[] bankcode=(Helper.correctNull(rs.getString("BIR_SERVICE_BANK"))).split("@");
						for(int i=0;i<bankcode.length;i++)
						{
							if(rs1 != null)
								rs1.close();					
							strQuery = SQLParser.getSqlQuery("sel_banknamemaster^"+bankcode[i]);
							rs1 = DBUtils.executeQuery(strQuery);
							while(rs1.next())
							{
								dsaservbankname=dsaservbankname+","+(correctNull(rs1.getString("staticbankname")));
							}
						}
					}
					strOldAudit.append(dsaservbankname.replaceFirst(",",""));
					strOldAudit.append("~ Past experience   = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BIR_PAST_EXP")));
					strOldAudit.append("~ Office Premises   = ");	
					strOldAudit.append(!Helper.correctNull((String)rs.getString("BIR_OFFICE_PREMISES")).equals("")?(Helper.correctNull((String)rs.getString("BIR_OFFICE_PREMISES")).equals("O")?"Owned":"Rented"):" ");
					strOldAudit.append("~ Registration under statutory = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BIR_REG_STATUTORY")));
					strOldAudit.append("~ Region Scode = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("BIR_scode")));
					strOldAudit.append("~TEXT FIELD1  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bir_textfield1")));
					strOldAudit.append("~TEXT FIELD1 VALUE  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bir_textfieldval1")));
					strOldAudit.append("~TEXT FIELD2  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bir_textfield2")));
					strOldAudit.append("~TEXT FIELD2 VALUE  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bir_textfieldval2")));
					strOldAudit.append("~TEXT FIELD3  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bir_textfield3")));
					strOldAudit.append("~TEXT FIELD3 VALUE  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bir_textfieldval3")));
					strOldAudit.append("~TEXT FIELD4  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bir_textfield4")));
					strOldAudit.append("~TEXT FIELD4 VALUE  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bir_textfieldval4")));
					strOldAudit.append("~TEXT FIELD5  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bir_textfield5")));
					strOldAudit.append("~TEXT FIELD5 VALUE  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bir_textfieldval5")));
					strOldAudit.append("~MASTER FIELD1  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bir_masterfield1")));
					strOldAudit.append("~MASTER FIELD1 VALUE  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bir_masterfieldval1")));
					strOldAudit.append("~MASTER FIELD2  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bir_masterfield2")));
					strOldAudit.append("~MASTER FIELD2 VALUE  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bir_masterfieldval2")));
					strOldAudit.append("~MASTER FIELD3  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bir_masterfield3")));
					strOldAudit.append("~MASTER FIELD3 VALUE  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bir_masterfieldval3")));
					strOldAudit.append("~MASTER FIELD4  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bir_masterfield4")));
					strOldAudit.append("~MASTER FIELD4 VALUE  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bir_masterfieldval4")));
					strOldAudit.append("~MASTER FIELD5  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bir_masterfield5")));
					strOldAudit.append("~MASTER FIELD5 VALUE  = ");	
					strOldAudit.append(Helper.correctNull((String)rs.getString("bir_masterfieldval5")));
				}
			}
			
			
			if (strAction.equalsIgnoreCase("insert"))
			{
				String strbrval="BIR";
				rs1 = DBUtils.executeLAPSQuery("getmaxBIRmasterno");				
				while(rs1.next())
				{	
					strslno = rs1.getString("maxno");
				}
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strslno);//1
				arrValues.add(strbrval.concat(strslno));//2
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_name")));//3
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_address1")));//4
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_address2")));//5
				arrValues.add(Helper.correctNull((String)hshValues.get("hidcity")));//6
				arrValues.add(Helper.correctNull((String)hshValues.get("hidstate")));//7
				arrValues.add(Helper.correctNull((String)hshValues.get("hidperapp_country")));//8
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_zip")));//9
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_applt_constitutionnew")));//10
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_nonindname")));//11
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_mobile")));//12
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_telephone")));//13
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_email")));//14
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_pannum")));//15
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_keyperson")));//16
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_designkeyperson")));//17
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_banktype")));//18
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_LeadBankcode")));//19
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_branch")));//20
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_ifsccode")));//21
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_accno")));//22
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_empaneldet")));//23
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_empaneledon")));//24
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_expirydate")));//25
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_action")));//26
				arrValues.add(txt_dsaservbankcodeappend);//27
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_pastexp")));//28
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_officepremises")));//29
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_regis")));//30
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_region")));//31
				//arrValues.add(Helper.correctNull((String)hshValues.get("txt_dealershipregno")));//32
				//arrValues.add(Helper.correctNull((String)hshValues.get("txt_regdatefrom")));//33
			//	arrValues.add(Helper.correctNull((String)hshValues.get("txt_regdateto")));//34
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield1")));//35
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield2")));//36
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield3")));//37
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield4")));//38
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield5")));//39
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield1")));//40
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield2")));//41
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield3")));//42
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield4")));//43
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield5")));//44
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfieldval1")));//45
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfieldval2")));//46
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfieldval3")));//47
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfieldval4")));//48
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfieldval5")));//49
				arrValues.add(Helper.correctNull((String)hshValues.get("selmasterfield1")));//50
				arrValues.add(Helper.correctNull((String)hshValues.get("selmasterfield2")));//51
				arrValues.add(Helper.correctNull((String)hshValues.get("selmasterfield3")));//52
				arrValues.add(Helper.correctNull((String)hshValues.get("selmasterfield4")));//53
				arrValues.add(Helper.correctNull((String)hshValues.get("selmasterfield5")));//54
				//End
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_BIR_master");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}			
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQuery = new HashMap();
				 arrValues = new ArrayList();
				//arrValues.add("Y");
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_name")));//0
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_address1")));//1
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_address2")));//2
				arrValues.add(Helper.correctNull((String)hshValues.get("hidcity")));//3
				arrValues.add(Helper.correctNull((String)hshValues.get("hidstate")));//4
				arrValues.add(Helper.correctNull((String)hshValues.get("hidperapp_country")));//5
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_zip")));//6
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_applt_constitutionnew")));//7
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_nonindname")));//8
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_mobile")));//9
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_telephone")));//10
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_email")));//11
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_pannum")));//12
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_keyperson")));//13
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_designkeyperson")));//14
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_banktype")));//15
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_LeadBankcode")));//16
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_branch")));//17
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_ifsccode")));//18
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_accno")));//19
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_empaneldet")));//20
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_empaneledon")));//21
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_expirydate")));//22
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_action")));//23
				arrValues.add(txt_dsaservbankcodeappend);//24
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_pastexp")));//25
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_officepremises")));//26
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_regis")));//27
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_region")));////28
				//arrValues.add("");//29
				//arrValues.add(Helper.correctNull((String)hshValues.get("txt_dealershipregno")));//30
				//arrValues.add(Helper.correctNull((String)hshValues.get("txt_regdatefrom")));//31
				//arrValues.add(Helper.correctNull((String)hshValues.get("txt_regdateto")));//32
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield1")));//33
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield2")));//34
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield3")));//35
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield4")));//36
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield5")));//37
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield1")));//38
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield2")));//39
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield3")));//40
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield4")));//41
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield5")));//42
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfieldval1")));//43
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfieldval2")));//44
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfieldval3")));//45
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfieldval4")));//46
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfieldval5")));//47
				arrValues.add(Helper.correctNull((String)hshValues.get("selmasterfield1")));//48
				arrValues.add(Helper.correctNull((String)hshValues.get("selmasterfield2")));//49
				arrValues.add(Helper.correctNull((String)hshValues.get("selmasterfield3")));//50
				arrValues.add(Helper.correctNull((String)hshValues.get("selmasterfield4")));///51
				arrValues.add(Helper.correctNull((String)hshValues.get("selmasterfield5")));//52
				arrValues.add(strSeqno);
				//End
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upd_BIR_master");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
			
			if(strAction.equalsIgnoreCase("insert")||strAction.equalsIgnoreCase("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield2")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield3")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield4")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtfield5")));
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield2")));
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield3")));
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield4")));
				arrValues.add(Helper.correctNull((String)hshValues.get("masterfield5")));
				arrValues.add(strSeqno);
				//End
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upd_BIRmasterdynamicfields");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			
			String auditconstitution="";
			if(rs1 != null)
				rs1.close();					
			strQuery = SQLParser.getSqlQuery("selconstitutiondesc^"+correctNull((String)hshValues.get("sel_applt_constitutionnew")));
			rs1 = DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				auditconstitution=correctNull(rs1.getString("cbs_static_data_desc"));
			}
			
			StringBuilder sbAuditTrial=new StringBuilder();
			sbAuditTrial.append("~BSA / DSA  Name = ").append(correctNull((String)hshValues.get("txt_name")))
				.append("~BSA / DSA  Address = ").append(correctNull((String)hshValues.get("txt_address1")))
				.append("~ City  = ").append(correctNull((String)hshValues.get("txt_city")))
				.append("~ State  = ").append(correctNull((String)hshValues.get("txt_state")))
				.append("~ Country = ").append(correctNull((String)hshValues.get("txt_country")))
				.append("~ PINCODE = ").append(correctNull((String)hshValues.get("txt_zip")))
				.append("~ CONSTITUTION = ").append(auditconstitution)
				.append("~ NONINDVNAME = ").append(correctNull((String)hshValues.get("txt_nonindname")))
				.append("~ MOBILENON = ").append(correctNull((String)hshValues.get("txt_mobile")))
				.append("~ TELEPHONENO = ").append(correctNull((String)hshValues.get("txt_telephone")))
				.append("~ EMAILID  = ").append(correctNull((String)hshValues.get("txt_email")))
				.append("~ PAN  = ").append(correctNull((String)hshValues.get("txt_pannum")))
				.append("~ KEY PERSON = ").append(correctNull((String)hshValues.get("txt_keyperson")))
				.append("~ Designation of Key Person = ").append(correctNull((String)hshValues.get("txt_designkeyperson")))
				.append("~ Bank Type = ")	.append(correctNull((String)hshValues.get("sel_banktype")))
				.append("~ Name of the Bank = ").append(correctNull((String)hshValues.get("txt_bankname")))
				.append("~ Bank Branch = ").append(correctNull((String)hshValues.get("txt_branch")))
				.append("~ IFSC code = ").append(correctNull((String)hshValues.get("txt_ifsccode")))
				.append("~ Bank Account number = ").append(correctNull((String)hshValues.get("txt_accno")))
				.append("~ Empanelment details = ").append(correctNull((String)hshValues.get("txt_empaneldet")))
				.append("~ Empanelment Date = ").append(correctNull((String)hshValues.get("txt_empaneledon")))
				.append("~ Empanelment since = ").append(txt_empsincedateappend.replace("@",","))
				.append("~ Expiry Date = ").append(correctNull((String)hshValues.get("txt_expirydate")))
				.append("~ ACTION = ").append(!correctNull((String)hshValues.get("sel_action")).equals("")?(correctNull((String)hshValues.get("sel_action")).equals("E")?"Enabled":"Disabled"):" ")
				.append("~ Name of the Bank  = ").append(txt_banknameappend.replace("@",","))	
				.append("~ Presently providing BIR services = ").append(txt_dsaservbanknameappend.replace("@",","))		
				.append("~ Past experience = ").append(correctNull((String)hshValues.get("txt_pastexp")))
				.append("~ Office Premises = ").append(!correctNull((String)hshValues.get("sel_officepremises")).equals("")?(correctNull((String)hshValues.get("sel_officepremises")).equals("O")?"Owned":"Rented"):" ")
				.append("~ Registration under statutory = ").append(correctNull((String)hshValues.get("txt_regis")));
			
			AuditTrial.auditNewLog(hshValues,"558",strSeqno,sbAuditTrial.toString(),strOldAudit.toString());
		}
		catch (Exception ce)
		{
			throw new EJBException(ce.toString());
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
	}
	
	public HashMap getBIRList(HashMap hshValues) 
	{
		String strQuery = "",scode = "",svalue = "";
 		ResultSet rs = null;
 		ResultSet rs1 = null;
 		HashMap hshRecord = new HashMap();
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();
		String strOrgCode ="",strCode="",strCBSID="",strExp="",strLeadScode="";
		strCBSID=Helper.correctNull((String)hshValues.get("hidCBSID"));
		String strAction = null;
		String strAppVal="",strflag="";
		String strRegionalcode="";
		String strOrgLevel="";
		ArrayList arrCol		= new ArrayList();
		ArrayList arrRow		= new ArrayList();
		try
		{
			scode="";
			//correctNull((String)hshValues.get("stype"));
			svalue=correctNull((String)hshValues.get("svalue"));
			strAction   = correctNull((String)hshValues.get("hidAction"));
			String strsno	= correctNull((String )hshValues.get("hidseqno"));
			strOrgCode = correctNull((String) hshValues.get("strOrgCode"));
			strOrgLevel = correctNull((String) hshValues.get("strOrgLevel"));
			strRegionalcode=correctNull((String) hshValues.get("strOrgCode")).substring(0,9)+"000000";
			
			 strflag=correctNull((String) hshValues.get("strflag"));
			if(strflag.equalsIgnoreCase("")){
				 strflag=correctNull((String) hshValues.get("hidstrflag"));

			}
				
			strAppVal=correctNull((String) hshValues.get("hidAppVal"));
			if((strsno.trim().equals("")))
			{
				strsno="0";
			}

			if(strAction.equalsIgnoreCase("search"))
			{
				String strPagefrom=Helper.correctNull((String)hshValues.get("strfrom"));
				String strType=Helper.correctNull((String)hshValues.get("rad"));
				scode=correctNull((String)hshValues.get("stype"));
				svalue=correctNull((String)hshValues.get("svalue"));
				strLeadScode=correctNull((String)hshValues.get("strScode"));
				String desc=" ";
				//desc=desc+"and BIR_TYPE='"+Helper.correctNull((String)hshValues.get("strType"))+"'";
				if(scode.equals(""))
				{
					strQuery = SQLParser.getSqlQuery("sel_BIRmasterall");
				}else{	
				strQuery = SQLParser.getSqlQuery("sel_BIRmaster_name^"+svalue);
				}
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					vecCol = new ArrayList();
					vecCol.add("");
					vecCol.add(correctNull(rs.getString("BIR_ID")));//1 
					vecCol.add(correctNull(rs.getString("BIR_NAME")));//2 
					vecCol.add(correctNull(rs.getString("BIR_ADDRESS1")));//3 
					vecCol.add(correctNull(rs.getString("BIR_ADDRESS2")));//4 
					vecCol.add(correctNull(rs.getString("city_name")));//5
					vecCol.add(correctNull(rs.getString("state_name")));//6
					vecCol.add(correctNull(rs.getString("CON_COUNTRY")));//7 
					vecCol.add(correctNull(rs.getString("BIR_PINCODE")));//8 
					vecCol.add(correctNull(rs.getString("BIR_CONSTITUTION")));//9 
					vecCol.add(correctNull(rs.getString("BIR_NONINDVNAME")));//10 
					vecCol.add(correctNull(rs.getString("BIR_MOBILENON")));//11 
					vecCol.add(correctNull(rs.getString("BIR_TELEPHONENO")));//12 
					vecCol.add(correctNull(rs.getString("BIR_EMAILID")));//13 
					vecCol.add(correctNull(rs.getString("BIR_GST")));//14 
					vecCol.add(correctNull(rs.getString("BIR_KEYPERSON")));//15 
					vecCol.add(correctNull(rs.getString("BIR_DESIGN_KEYPERSON")));//16 
					vecCol.add(correctNull(rs.getString("BIR_ACCTYPE")));///17 
					if(!correctNull(rs.getString("BIR_BANKNAME")).equals(""))
					{
						if(rs1 != null)
							rs1.close();					
						strQuery = SQLParser.getSqlQuery("sel_banknamemaster^"+Helper.correctInt(rs.getString("BIR_BANKNAME")));
						rs1 = DBUtils.executeQuery(strQuery);
						while(rs1.next())
						{
							vecCol.add(correctNull(rs1.getString("staticbankname")));//18 
						}
					}
					else
					{
						vecCol.add("");
					}
					
					vecCol.add(correctNull(rs.getString("BIR_BANKBRANCH")));//19 
					vecCol.add(correctNull(rs.getString("BIR_IFSC")));//20
					vecCol.add(correctNull(rs.getString("BIR_ACCNO")));//21
					vecCol.add(correctNull(rs.getString("BIR_EMPANEL_DET")));//22
					vecCol.add(correctNull(rs.getString("BIR_EMPANEL_DATE")));//23 
					vecCol.add(correctNull(rs.getString("BIR_EXPIRY_DATE")));//25  
					vecCol.add(correctNull(rs.getString("BIR_ACTION")));//26 
					vecCol.add(correctNull(rs.getString("BIR_PAST_EXP")));//30
					vecCol.add(correctNull(rs.getString("BIR_OFFICE_PREMISES")));//31 
					vecCol.add(correctNull(rs.getString("BIR_REG_STATUTORY")));//32
					String bankname="";
					
					vecCol.add(bankname.replaceFirst("@",""));//33 
					String dsaservbankname="";
					if(!correctNull(rs.getString("BIR_SERVICE_BANK")).equals(""))
					{
						
						String[] bankcode=(Helper.correctNull(rs.getString("BIR_SERVICE_BANK"))).split("@");
						for(int i=0;i<bankcode.length;i++)
						{
							if(rs1 != null)
								rs1.close();					
							strQuery = SQLParser.getSqlQuery("sel_banknamemaster^"+bankcode[i]);
							rs1 = DBUtils.executeQuery(strQuery);
							while(rs1.next())
							{
								dsaservbankname=dsaservbankname+"@"+(correctNull(rs1.getString("staticbankname")));
							}
						}
					}
					vecCol.add(dsaservbankname.replaceFirst("@",""));//34 
					vecCol.add(correctNull(rs.getString("BIR_SERVICE_BANK")));//37  dsaservicebankcode
					vecCol.add(correctNull(rs.getString("BIR_CITY")));//39
					vecCol.add(correctNull(rs.getString("BIR_STATE")));//40 
					vecCol.add(correctNull(rs.getString("BIR_COUNTRY")));//41 
					vecCol.add(correctNull(rs.getString("BIR_BANKNAME")));//42 
					vecCol.add(correctNull(rs.getString("BIR_SCODE")));//43
					vecCol.add("");//45
					vecCol.add("");//46
					vecCol.add("");//47
					vecCol.add(correctNull(rs.getString("BIR_TEXTFIELD1")));//48
					vecCol.add(correctNull(rs.getString("BIR_TEXTFIELD2")));//49
					vecCol.add(correctNull(rs.getString("BIR_TEXTFIELD3")));//50
					vecCol.add(correctNull(rs.getString("BIR_TEXTFIELD4")));//51
					vecCol.add(correctNull(rs.getString("BIR_TEXTFIELD5")));//52
					vecCol.add(correctNull(rs.getString("BIR_masterfield1")));//53
					vecCol.add(correctNull(rs.getString("BIR_masterfield2")));//54
					vecCol.add(correctNull(rs.getString("BIR_masterfield3")));//55
					vecCol.add(correctNull(rs.getString("BIR_masterfield4")));//56
					vecCol.add(correctNull(rs.getString("BIR_masterfield5")));//57
					vecCol.add(correctNull(rs.getString("BIR_textfieldval1")));//58
					vecCol.add(correctNull(rs.getString("BIR_textfieldval2")));//59
					vecCol.add(correctNull(rs.getString("BIR_textfieldval3")));//60
					vecCol.add(correctNull(rs.getString("BIR_textfieldval4")));//61
					vecCol.add(correctNull(rs.getString("BIR_textfieldval5")));//62
					vecCol.add(correctNull(rs.getString("BIR_masterfieldval1")));//63
					vecCol.add(correctNull(rs.getString("BIR_masterfieldval2")));//64
					vecCol.add(correctNull(rs.getString("BIR_masterfieldval3")));//65
					vecCol.add(correctNull(rs.getString("BIR_masterfieldval4")));//66
					vecCol.add(correctNull(rs.getString("BIR_masterfieldval5")));//67
					vecRow.add(vecCol);	
				}
                log.info("<<<<<<====================vecRow===========================>>>>>>>"+vecRow); 
                
                if(!svalue.equalsIgnoreCase("")){/*
                	strQuery = SQLParser.getSqlQuery("sel_birname^"+svalue);
				
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next()){

					vecCol = new ArrayList();
					vecCol.add(correctNull(rs.getString("BIR_TYPE")));
					vecCol.add(correctNull(rs.getString("BIR_ID")));//1 
					vecCol.add(correctNull(rs.getString("BIR_NAME")));//2 
					vecCol.add(correctNull(rs.getString("BIR_ADDRESS1")));//3 
					vecCol.add(correctNull(rs.getString("BIR_ADDRESS2")));//4 
					vecCol.add(correctNull(rs.getString("city_name")));//5
					vecCol.add(correctNull(rs.getString("state_name")));//6
					vecCol.add(correctNull(rs.getString("CON_COUNTRY")));//7 
					vecCol.add(correctNull(rs.getString("BIR_PINCODE")));//8 
					vecCol.add(correctNull(rs.getString("BIR_CONSTITUTION")));//9 
					vecCol.add(correctNull(rs.getString("BIR_NONINDVNAME")));//10 
					vecCol.add(correctNull(rs.getString("BIR_MOBILENON")));//11 
					vecCol.add(correctNull(rs.getString("BIR_TELEPHONENO")));//12 
					vecCol.add(correctNull(rs.getString("BIR_EMAILID")));//13 
					vecCol.add(correctNull(rs.getString("BIR_GST")));//14 
					vecCol.add(correctNull(rs.getString("BIR_KEYPERSON")));//15 
					vecCol.add(correctNull(rs.getString("BIR_DESIGN_KEYPERSON")));//16 
					vecCol.add(correctNull(rs.getString("BIR_ACCTYPE")));///17 
					if(!correctNull(rs.getString("BIR_BANKNAME")).equals(""))
					{
						if(rs1 != null)
							rs1.close();					
						strQuery = SQLParser.getSqlQuery("sel_banknamemaster^"+Helper.correctInt(rs.getString("BIR_BANKNAME")));
						rs1 = DBUtils.executeQuery(strQuery);
						while(rs1.next())
						{
							vecCol.add(correctNull(rs1.getString("staticbankname")));//18 
						}
					}
					else
					{
						vecCol.add("");
					}
					
					vecCol.add(correctNull(rs.getString("BIR_BANKBRANCH")));//19 
					vecCol.add(correctNull(rs.getString("BIR_IFSC")));//20
					vecCol.add(correctNull(rs.getString("BIR_ACCNO")));//21
					vecCol.add(correctNull(rs.getString("BIR_EMPANEL_DET")));//22
					vecCol.add(correctNull(rs.getString("BIR_EMPANEL_DATE")));//23 
					vecCol.add(correctNull(rs.getString("BIR_EXPIRY_DATE")));//25  
					vecCol.add(correctNull(rs.getString("BIR_ACTION")));//26 
					vecCol.add(correctNull(rs.getString("BIR_PAST_EXP")));//30
					vecCol.add(correctNull(rs.getString("BIR_OFFICE_PREMISES")));//31 
					vecCol.add(correctNull(rs.getString("BIR_REG_STATUTORY")));//32
					String bankname="";
					
					vecCol.add(bankname.replaceFirst("@",""));//33 
					String dsaservbankname="";
					if(!correctNull(rs.getString("BIR_SERVICE_BANK")).equals(""))
					{
						
						String[] bankcode=(Helper.correctNull(rs.getString("BIR_SERVICE_BANK"))).split("@");
						for(int i=0;i<bankcode.length;i++)
						{
							if(rs1 != null)
								rs1.close();					
							strQuery = SQLParser.getSqlQuery("sel_banknamemaster^"+bankcode[i]);
							rs1 = DBUtils.executeQuery(strQuery);
							while(rs1.next())
							{
								dsaservbankname=dsaservbankname+"@"+(correctNull(rs1.getString("staticbankname")));
							}
						}
					}
					vecCol.add(dsaservbankname.replaceFirst("@",""));//34 
					vecCol.add(correctNull(rs.getString("BIR_SERVICE_BANK")));//37  dsaservicebankcode
					vecCol.add(correctNull(rs.getString("BIR_CITY")));//39
					vecCol.add(correctNull(rs.getString("BIR_STATE")));//40 
					vecCol.add(correctNull(rs.getString("BIR_COUNTRY")));//41 
					vecCol.add(correctNull(rs.getString("BIR_BANKNAME")));//42 
					vecCol.add(correctNull(rs.getString("BIR_SCODE")));//43
					vecCol.add(correctNull(rs.getString("BIR_dealershipno")));//45
					vecCol.add(correctNull(rs.getString("BIR_regnovalidfrom")));//46
					vecCol.add(correctNull(rs.getString("BIR_regnovalidto")));//47
					vecCol.add(correctNull(rs.getString("BIR_TEXTFIELD1")));//48
					vecCol.add(correctNull(rs.getString("BIR_TEXTFIELD2")));//49
					vecCol.add(correctNull(rs.getString("BIR_TEXTFIELD3")));//50
					vecCol.add(correctNull(rs.getString("BIR_TEXTFIELD4")));//51
					vecCol.add(correctNull(rs.getString("BIR_TEXTFIELD5")));//52
					vecCol.add(correctNull(rs.getString("BIR_masterfield1")));//53
					vecCol.add(correctNull(rs.getString("BIR_masterfield2")));//54
					vecCol.add(correctNull(rs.getString("BIR_masterfield3")));//55
					vecCol.add(correctNull(rs.getString("BIR_masterfield4")));//56
					vecCol.add(correctNull(rs.getString("BIR_masterfield5")));//57
					vecCol.add(correctNull(rs.getString("BIR_textfieldval1")));//58
					vecCol.add(correctNull(rs.getString("BIR_textfieldval2")));//59
					vecCol.add(correctNull(rs.getString("BIR_textfieldval3")));//60
					vecCol.add(correctNull(rs.getString("BIR_textfieldval4")));//61
					vecCol.add(correctNull(rs.getString("BIR_textfieldval5")));//62
					vecCol.add(correctNull(rs.getString("BIR_masterfieldval1")));//63
					vecCol.add(correctNull(rs.getString("BIR_masterfieldval2")));//64
					vecCol.add(correctNull(rs.getString("BIR_masterfieldval3")));//65
					vecCol.add(correctNull(rs.getString("BIR_masterfieldval4")));//66
					vecCol.add(correctNull(rs.getString("BIR_masterfieldval5")));//67
					vecRow.add(vecCol);	
				
				}
                */}
				hshRecord.put("vecRow",vecRow);
				hshRecord.put("svalue", svalue);
				hshRecord.put("scode", scode);
				hshRecord.put("strLeadScode", strLeadScode);
				hshRecord.put("appraiser",Helper.correctNull((String)hshValues.get("appraiser")));
				hshRecord.put("strflag", strflag);
			}
			
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("sel_BIRmasterdynamicfields");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol= new ArrayList();
				arrCol.add("");
				arrCol.add(Helper.correctNull(rs.getString("BIR_TEXTFIELD1")));
				arrCol.add(Helper.correctNull(rs.getString("BIR_TEXTFIELD2")));
				arrCol.add(Helper.correctNull(rs.getString("BIR_TEXTFIELD3")));
				arrCol.add(Helper.correctNull(rs.getString("BIR_TEXTFIELD4")));
				arrCol.add(Helper.correctNull(rs.getString("BIR_TEXTFIELD5")));
				arrCol.add(Helper.correctNull(rs.getString("BIR_MASTERFIELD1")));
				arrCol.add(Helper.correctNull(rs.getString("BIR_MASTERFIELD2")));
				arrCol.add(Helper.correctNull(rs.getString("BIR_MASTERFIELD3")));
				arrCol.add(Helper.correctNull(rs.getString("BIR_MASTERFIELD4")));
				arrCol.add(Helper.correctNull(rs.getString("BIR_MASTERFIELD5")));
				arrRow.add(arrCol);
			}
			log.info("<<<<===============================arrRow==========================>>>>"+arrRow);
			hshRecord.put("arrRow", arrRow);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getBIRList "+ce.toString());
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
	//======================================================end===============================================//
	
	public HashMap getBIRListprop(HashMap hshValues) 
	{
	String strQuery = "",scode = "",svalue = "";
	ResultSet rs = null;
	ResultSet rs1 = null;
	HashMap hshRecord = new HashMap();
	ArrayList vecCol		= new ArrayList();
	ArrayList vecRow		= new ArrayList();
	String strOrgCode ="",strCode="",strCBSID="",strExp="",strLeadScode="";
	strCBSID=Helper.correctNull((String)hshValues.get("hidCBSID"));
	String strAction = null;
	String strAppVal="",strflag="";
	String strRegionalcode="";
	String strOrgLevel="";
	ArrayList arrCol		= new ArrayList();
	ArrayList arrRow		= new ArrayList();
	try
	{
		scode="";
		//correctNull((String)hshValues.get("stype"));
		svalue=correctNull((String)hshValues.get("svalue"));
		strAction   = correctNull((String)hshValues.get("hidAction"));
		String strsno	= correctNull((String )hshValues.get("hidseqno"));
		strOrgCode = correctNull((String) hshValues.get("strOrgCode"));
		strOrgLevel = correctNull((String) hshValues.get("strOrgLevel"));
		strRegionalcode=correctNull((String) hshValues.get("strOrgCode")).substring(0,9)+"000000";
		
		 strflag=correctNull((String) hshValues.get("strflag"));
		if(strflag.equalsIgnoreCase("")){
			 strflag=correctNull((String) hshValues.get("hidstrflag"));

		}
			
		strAppVal=correctNull((String) hshValues.get("hidAppVal"));
		if((strsno.trim().equals("")))
		{
			strsno="0";
		}

		if(strAction.equalsIgnoreCase("search"))
		{
			String desc="";
			String strPagefrom=Helper.correctNull((String)hshValues.get("strfrom"));
			String strType=Helper.correctNull((String)hshValues.get("rad"));
			scode=correctNull((String)hshValues.get("stype"));
			svalue=correctNull((String)hshValues.get("svalue"));
			strLeadScode=correctNull((String)hshValues.get("strScode"));
			String strCat=correctNull((String)hshValues.get("hidcat"));
				
				 if(strCat.equalsIgnoreCase("1"))
				{
					strQuery = SQLParser.getSqlQuery("sel_BIRmaster_id^"+svalue);
				}
				else if(strCat.equalsIgnoreCase("2")){
					strQuery = SQLParser.getSqlQuery("sel_BIRmasterprop_name^"+svalue);
				}else{
					strQuery = SQLParser.getSqlQuery("sel_BIRmasterallproplevel");

				}
			
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add("");
				vecCol.add(correctNull(rs.getString("BIR_ID")));//1 
				vecCol.add(correctNull(rs.getString("BIR_NAME")));//2 
				vecCol.add(correctNull(rs.getString("BIR_ADDRESS1")));//3 
				vecCol.add(correctNull(rs.getString("BIR_ADDRESS2")));//4 
				vecCol.add(correctNull(rs.getString("city_name")));//5
				vecCol.add(correctNull(rs.getString("state_name")));//6
				vecCol.add(correctNull(rs.getString("CON_COUNTRY")));//7 
				vecCol.add(correctNull(rs.getString("BIR_PINCODE")));//8 
				vecCol.add(correctNull(rs.getString("BIR_CONSTITUTION")));//9 
				vecCol.add(correctNull(rs.getString("BIR_NONINDVNAME")));//10 
				vecCol.add(correctNull(rs.getString("BIR_MOBILENON")));//11 
				vecCol.add(correctNull(rs.getString("BIR_TELEPHONENO")));//12 
				vecCol.add(correctNull(rs.getString("BIR_EMAILID")));//13 
				vecCol.add(correctNull(rs.getString("BIR_GST")));//14 
				vecCol.add(correctNull(rs.getString("BIR_KEYPERSON")));//15 
				vecCol.add(correctNull(rs.getString("BIR_DESIGN_KEYPERSON")));//16 
				vecCol.add(correctNull(rs.getString("BIR_ACCTYPE")));///17 
				if(!correctNull(rs.getString("BIR_BANKNAME")).equals(""))
				{
					if(rs1 != null)
						rs1.close();					
					strQuery = SQLParser.getSqlQuery("sel_banknamemaster^"+Helper.correctInt(rs.getString("BIR_BANKNAME")));
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						vecCol.add(correctNull(rs1.getString("staticbankname")));//18 
					}
				}
				else
				{
					vecCol.add("");
				}
				
				vecCol.add(correctNull(rs.getString("BIR_BANKBRANCH")));//19 
				vecCol.add(correctNull(rs.getString("BIR_IFSC")));//20
				vecCol.add(correctNull(rs.getString("BIR_ACCNO")));//21
				vecCol.add(correctNull(rs.getString("BIR_EMPANEL_DET")));//22
				vecCol.add(correctNull(rs.getString("BIR_EMPANEL_DATE")));//23 
				vecCol.add(correctNull(rs.getString("BIR_EXPIRY_DATE")));//25  
				vecCol.add(correctNull(rs.getString("BIR_ACTION")));//26 
				vecCol.add(correctNull(rs.getString("BIR_PAST_EXP")));//30
				vecCol.add(correctNull(rs.getString("BIR_OFFICE_PREMISES")));//31 
				vecCol.add(correctNull(rs.getString("BIR_REG_STATUTORY")));//32
				String bankname="";
				
				vecCol.add(bankname.replaceFirst("@",""));//33 
				String dsaservbankname="";
				if(!correctNull(rs.getString("BIR_SERVICE_BANK")).equals(""))
				{
					
					String[] bankcode=(Helper.correctNull(rs.getString("BIR_SERVICE_BANK"))).split("@");
					for(int i=0;i<bankcode.length;i++)
					{
						if(rs1 != null)
							rs1.close();					
						strQuery = SQLParser.getSqlQuery("sel_banknamemaster^"+bankcode[i]);
						rs1 = DBUtils.executeQuery(strQuery);
						while(rs1.next())
						{
							dsaservbankname=dsaservbankname+"@"+(correctNull(rs1.getString("staticbankname")));
						}
					}
				}
				vecCol.add(dsaservbankname.replaceFirst("@",""));//34 
				vecCol.add(correctNull(rs.getString("BIR_SERVICE_BANK")));//37  dsaservicebankcode
				vecCol.add(correctNull(rs.getString("BIR_CITY")));//39
				vecCol.add(correctNull(rs.getString("BIR_STATE")));//40 
				vecCol.add(correctNull(rs.getString("BIR_COUNTRY")));//41 
				vecCol.add(correctNull(rs.getString("BIR_BANKNAME")));//42 
				vecCol.add(correctNull(rs.getString("BIR_SCODE")));//43
				vecCol.add("");//45
				vecCol.add("");//46
				vecCol.add("");//47
				vecCol.add(correctNull(rs.getString("BIR_TEXTFIELD1")));//48
				vecCol.add(correctNull(rs.getString("BIR_TEXTFIELD2")));//49
				vecCol.add(correctNull(rs.getString("BIR_TEXTFIELD3")));//50
				vecCol.add(correctNull(rs.getString("BIR_TEXTFIELD4")));//51
				vecCol.add(correctNull(rs.getString("BIR_TEXTFIELD5")));//52
				vecCol.add(correctNull(rs.getString("BIR_masterfield1")));//53
				vecCol.add(correctNull(rs.getString("BIR_masterfield2")));//54
				vecCol.add(correctNull(rs.getString("BIR_masterfield3")));//55
				vecCol.add(correctNull(rs.getString("BIR_masterfield4")));//56
				vecCol.add(correctNull(rs.getString("BIR_masterfield5")));//57
				vecCol.add(correctNull(rs.getString("BIR_textfieldval1")));//58
				vecCol.add(correctNull(rs.getString("BIR_textfieldval2")));//59
				vecCol.add(correctNull(rs.getString("BIR_textfieldval3")));//60
				vecCol.add(correctNull(rs.getString("BIR_textfieldval4")));//61
				vecCol.add(correctNull(rs.getString("BIR_textfieldval5")));//62
				vecCol.add(correctNull(rs.getString("BIR_masterfieldval1")));//63
				vecCol.add(correctNull(rs.getString("BIR_masterfieldval2")));//64
				vecCol.add(correctNull(rs.getString("BIR_masterfieldval3")));//65
				vecCol.add(correctNull(rs.getString("BIR_masterfieldval4")));//66
				vecCol.add(correctNull(rs.getString("BIR_masterfieldval5")));//67
				vecRow.add(vecCol);	
			}
            log.info("<<<<<<====================vecRow===========================>>>>>>>"+vecRow); 
            
			hshRecord.put("vecRow",vecRow);
			hshRecord.put("svalue", svalue);
			hshRecord.put("scode", scode);
			hshRecord.put("strLeadScode", strLeadScode);
			hshRecord.put("appraiser",Helper.correctNull((String)hshValues.get("appraiser")));
			hshRecord.put("strflag", strflag);
		}
		
		if(rs!=null)
			rs.close();
		strQuery = SQLParser.getSqlQuery("sel_BIRmasterdynamicfields");
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			arrCol= new ArrayList();
			//arrCol.add(Helper.correctNull(rs.getString("type")));
			arrCol.add(Helper.correctNull(rs.getString("BIR_TEXTFIELD1")));
			arrCol.add(Helper.correctNull(rs.getString("BIR_TEXTFIELD2")));
			arrCol.add(Helper.correctNull(rs.getString("BIR_TEXTFIELD3")));
			arrCol.add(Helper.correctNull(rs.getString("BIR_TEXTFIELD4")));
			arrCol.add(Helper.correctNull(rs.getString("BIR_TEXTFIELD5")));
			arrCol.add(Helper.correctNull(rs.getString("BIR_MASTERFIELD1")));
			arrCol.add(Helper.correctNull(rs.getString("BIR_MASTERFIELD2")));
			arrCol.add(Helper.correctNull(rs.getString("BIR_MASTERFIELD3")));
			arrCol.add(Helper.correctNull(rs.getString("BIR_MASTERFIELD4")));
			arrCol.add(Helper.correctNull(rs.getString("BIR_MASTERFIELD5")));
			arrRow.add(arrCol);
		}
		log.info("<<<<===============================arrRow==========================>>>>"+arrRow);
		hshRecord.put("arrRow", arrRow);
	}
	catch(Exception ce)
	{
		throw new EJBException("Error in getBIRList "+ce.toString());
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
	public HashMap getNameofsectorgeclident(HashMap hshValues) 
	{	
		
		String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord =new HashMap();
		String strgecltype = "";
		String strdatahead = "";
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=null;
		try
		{
			
			strdatahead = correctNull((String)hshValues.get("statheadcode"));
			strgecltype = correctNull((String)hshValues.get("GeclType"));
			
			strQuery=SQLParser.getSqlQuery("sel_nameofsectorident^"+strgecltype+"^"+strdatahead);		
			rs = DBUtils.executeQuery(strQuery);
			arrRow=new ArrayList();
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("stat_mast_id")));
				arrCol.add(Helper.correctNull((String)rs.getString("stat_data_desc1")));
				
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getNameofsectorgeclident "+ce.toString());
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
	
	public HashMap getValuerMasterListList(HashMap hshValues) 
	{
		String strQuery = "",scode = "",svalue = "";
 		ResultSet rs = null;
 		ResultSet rs1 = null;
 		HashMap hshRecord = new HashMap();
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();
		String strOrgCode ="",strCode="",strCBSID="",strExp="";
		strCBSID=Helper.correctNull((String)hshValues.get("hidCBSID"));
		String strAction = null;
		String strAppVal="";
		String strRegionalcode="";
		String strOrgLevel="",strSecValue="";
		String strAppraiser = Helper.correctNull((String)hshValues.get("appraiser"));
		StringBuffer strOrgNames=new StringBuffer();
		StringBuffer strOrgCodes=new StringBuffer();
		StringBuffer strExpiry=new StringBuffer();
		String name="";
		String unique="";
		try
		{
			scode=correctNull((String)hshValues.get("stype"));
			svalue=correctNull((String)hshValues.get("svalue"));
			strAction   = correctNull((String)hshValues.get("hidAction"));
			String strsno	= correctNull((String )hshValues.get("hidseqno"));
			strOrgCode = correctNull((String) hshValues.get("strOrgCode"));
			strOrgLevel = correctNull((String) hshValues.get("strOrgLevel"));
			strSecValue = Helper.correctDouble((String) hshValues.get("strSecValue"));
			strRegionalcode=correctNull((String) hshValues.get("strOrgCode")).substring(0,9)+"000000";
			String strRegionalOffice=strRegionalcode;
			name=correctNull((String) hshValues.get("apprainame"));
			if(strOrgLevel.equalsIgnoreCase("C"))
			{
				strRegionalcode=strOrgCode.substring(0,3)+"%%%";
				strCode=strOrgCode.substring(0,3)+"%%%";
			}
			else if(strOrgLevel.equalsIgnoreCase("R"))
			{
				strRegionalcode=strOrgCode.substring(0,6);
				
				HashMap hshRo=new HashMap();
				hshRo.put("strRegionalOffice", strRegionalOffice);
				hshRo.put("strPage", "mastsearch");
				strRegionalOffice=(String)EJBInvoker.executeStateLess("setorg",hshRo,"getRegionalOffice");
				strRegionalcode=strRegionalOffice;
				
				strRegionalcode=strRegionalcode+"%%%";
				strCode=strOrgCode.substring(0,6)+"%%%";
			}
			else if(strOrgLevel.equalsIgnoreCase("D"))
			{
				//strRegionalcode=strOrgCode.substring(0,9)+"%%%";
				strRegionalcode=strOrgCode.substring(0,6)+"%%%";
				strCode=strOrgCode.substring(0,9)+"%%%";
			}
			else if(strOrgLevel.equalsIgnoreCase("A"))
			{
				//strRegionalcode=strOrgCode.substring(0,12)+"%%%";
				strRegionalcode=strOrgCode.substring(0,6)+"%%%";
				strCode=strOrgCode.substring(0,12)+"%%%";
			}
			else
			{
				strRegionalcode=strOrgCode.substring(0,15);
			}
			strAppVal=correctNull((String) hshValues.get("hidAppVal"));
			if((strsno.trim().equals("")))
			{
				strsno="0";
			}
			
			
			
			if(strAction.equalsIgnoreCase("update")||strAction.equalsIgnoreCase("Cancel") || strAction.equalsIgnoreCase("insert"))
			{
				
			}
			else if(strAction.equalsIgnoreCase("search"))
			{
				String strPagefrom=Helper.correctNull((String)hshValues.get("strfrom"));
				String strType=Helper.correctNull((String)hshValues.get("rad"));
				
				if(strAppraiser.equalsIgnoreCase("appraiser") || strPagefrom.equalsIgnoreCase("Securities") || strPagefrom.equalsIgnoreCase("ValuerEntry") || strAppraiser.equalsIgnoreCase("reappraiser"))
				{	
					scode=correctNull((String)hshValues.get("stype"));
					svalue=correctNull((String)hshValues.get("svalue"));
					if(scode.equals(""))
					{
						//String strTemp=" ";
						if(strAppVal.equalsIgnoreCase("V"))
							strOrgCode="001";
							//strTemp="or valuers_code='601'";
						if(strAppraiser.equalsIgnoreCase("reappraiser"))
							strOrgCode="001";
						
						if(strAppVal.equalsIgnoreCase("J"))
							strQuery = SQLParser.getSqlQuery("sel_validJappraisername^"+strOrgCode+"^"+strAppVal);
						else 
							strQuery = SQLParser.getSqlQuery("sel_validappraisername^"+strOrgCode+"^"+strAppVal);
					}				
					else if(strType.equals("Name") || scode.equals("Name"))
					{
						if(strAppVal.equalsIgnoreCase("J"))
							strQuery = SQLParser.getSqlQuery("sel_validJappraisernamewithsearchid^"+strOrgCode+"^"+svalue+"^"+strAppVal);
						else
							strQuery = SQLParser.getSqlQuery("sel_validappraisernamewithsearchid^"+strOrgCode+"^"+svalue+"^"+strAppVal);
					}			
					else if(strType.equals("CBSID"))
					{
						if(strAppVal.equalsIgnoreCase("J"))
							strQuery = SQLParser.getSqlQuery("sel_validJappraisernamewithsearchcbsid^"+strOrgCode+"^"+svalue+"^"+strAppVal);
						else
							strQuery = SQLParser.getSqlQuery("sel_validappraisernamewithsearchcbsid^"+strOrgCode+"^"+svalue+"^"+strAppVal);
					}			
					rs = DBUtils.executeQuery(strQuery);
					while(rs.next())				
					{
						String name2=Helper.correctNull((String)rs.getString("VALUER_CBSID"));
						if(!name.equalsIgnoreCase(name2))
						{
							if(!unique.equalsIgnoreCase(name2))
							{
						vecCol = new ArrayList();
						vecCol.add(correctNull(rs.getString(1)));//0 org_code
						vecCol.add(correctNull(rs.getString(2)));//1 valuers_code
						vecCol.add(correctNull(rs.getString(3)));//2 valuers_name
						vecCol.add(correctNull(rs.getString(4)));//3 valuers_address1
						vecCol.add(correctNull(rs.getString(5)));//4 valuers_address2
						vecCol.add(correctNull(rs.getString(6)));//5 valuers_address3
						vecCol.add(correctNull(rs.getString(7)));//6 valuers_city
						vecCol.add(correctNull(rs.getString(8)));//7 valuers_state
						vecCol.add(correctNull(rs.getString(9)));//8 valuers_pincode
						vecCol.add(correctNull(rs.getString(10)));//9 valuers_country
						vecCol.add(correctNull(rs.getString(11)));//10 valuers_off_phoneno
						vecCol.add(correctNull(rs.getString(12)));//11 valuers_off_faxno
						vecCol.add(correctNull(rs.getString(13)));//12 valuers_res_phoneno
						vecCol.add(correctNull(rs.getString(14)));//13 valuers_res_mobno
						vecCol.add(correctNull(rs.getString(15)));//14 valuers_contper
						vecCol.add(correctNull(rs.getString(16)));//15 valuers_contper_phmobno
						vecCol.add(correctNull(rs.getString(17)));//16 valuers_design
						vecCol.add(correctNull(rs.getString(18)));//17 valuers_email
						vecCol.add(correctNull(rs.getString(19)));///18 valuers_empaneleddt
						vecCol.add(correctNull(rs.getString(20)));//19 valuers_active
						vecCol.add(correctNull(rs.getString(21)));//20 valuers_comments
						vecCol.add(correctNull(rs.getString(22)));//21 valuers_blacklist
						vecCol.add(correctNull(rs.getString(23)));//22 valuers_blacklistdate
						vecCol.add(correctNull(rs.getString(24)));//23 city_name
					//	vecCol.add(correctNull(rs.getString(25)));//
						vecCol.add(correctNull(rs.getString(25)));//24 state_name
						vecCol.add(correctNull(rs.getString(26)));//25 valuers_seqno
						vecCol.add(correctNull(rs.getString(27)));//26 Ref Number
						vecCol.add(correctNull(rs.getString(28)));//27 Expected Date of Sanction
						vecCol.add(correctNull(rs.getString(29)));//28 Security Deposit
						vecCol.add(correctNull(rs.getString(30)));//29 Jewel Appraiser Date
						vecCol.add(correctNull(rs.getString(31)));//30 
						
						String branchname="";
						if(!correctNull(rs.getString("ORG_CODE")).equals(""))
						{
							String[] bankcode=(Helper.correctNull(rs.getString("ORG_CODE"))).split("@");
							for(int i=0;i<bankcode.length;i++)
							{
								if(rs1 != null)
									rs1.close();					
								strQuery = SQLParser.getSqlQuery("repbankname^"+bankcode[i]);
								rs1 = DBUtils.executeQuery(strQuery);
								while(rs1.next())
								{
									branchname=branchname+"@"+((correctNull(rs1.getString("org_name")))+" - "+(correctNull(rs1.getString("org_scode"))));
								}
							}
						}
						vecCol.add(branchname.replaceFirst("@",""));//31
						vecCol.add(correctNull(rs.getString(32)));//32
						vecCol.add(correctNull(rs.getString(33)));//33
						vecCol.add(correctNull(rs.getString("VALUER_VALUEDLOC")));//34
						
						if(strPagefrom.equalsIgnoreCase("Securities"))
						{
							if(rs1 != null)
								rs1.close();					
							rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^205^"+correctNull(rs.getString(33)));
							if(rs1.next())
							{
								if(Double.parseDouble(strSecValue)<=Double.parseDouble(Helper.correctDouble(rs1.getString("stat_data_value"))))
								{
									vecCol.add("Y");//35
									vecCol.add(Helper.correctDouble(rs1.getString("stat_data_value")));//36
								}
								else
								{
									vecCol.add("N");//35
									vecCol.add(Helper.correctDouble(rs1.getString("stat_data_value")));//36
								}
							}
							else
							{
								vecCol.add("");//35
								vecCol.add("");//36
							}
						}
						else
						{
							vecCol.add("");//35
							vecCol.add("");//36
						}
						vecCol.add(String.valueOf(Helper.dateDiff(Helper.getCurrentDateTime(),correctNull(rs.getString("valuers_expdateofsanc")))));//37
						vecCol.add("");
						vecCol.add("");
						vecCol.add("");
						vecRow.add(vecCol);	
						unique =Helper.correctNull((String)rs.getString("VALUER_CBSID"));
							}
					}
					}
				}
				else
				{
				scode=correctNull((String)hshValues.get("stype"));
				svalue=correctNull((String)hshValues.get("svalue"));
				if(strPagefrom.equalsIgnoreCase("ValuersMaster1"))
				{
					if(scode.equals(""))
					{
						strQuery = SQLParser.getSqlQuery("sel_valuermasterall^"+strAppVal);
					}				
					else if(strType.equalsIgnoreCase("Name"))
					{
						strQuery = SQLParser.getSqlQuery("sel_valuermastername^"+svalue+"^"+strAppVal);
					}	
					else if(strType.equalsIgnoreCase("CBSID"))
					{
						strQuery = SQLParser.getSqlQuery("sel_valuermastercbsid_search^"+svalue+"^"+strAppVal);
					}
				}
				else
				{
					if(scode.equals(""))
					{
						strQuery = SQLParser.getSqlQuery("sel_valuermasterall_search^'"+strOrgCode+"','"+strOrgCode.substring(0, 9)+"000000','"+strOrgCode.substring(0, 6)+"000000000','"+strOrgCode.substring(0, 3)+"000000000000'^"+strAppVal);
					}				
					else if(scode.equals("N"))
					{
						strQuery = SQLParser.getSqlQuery("sel_valuermastername_search^'"+strOrgCode+"','"+strOrgCode.substring(0, 9)+"000000','"+strOrgCode.substring(0, 6)+"000000000','"+strOrgCode.substring(0, 3)+"000000000000'^"+svalue+"^"+strAppVal);
					}
					
				}
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					
					
					vecCol = new ArrayList();
					vecCol.add(correctNull(rs.getString(1)));//0 org_code
					vecCol.add(correctNull(rs.getString(2)));//1 valuers_code
					vecCol.add(correctNull(rs.getString(3)));//2 valuers_name
					vecCol.add(correctNull(rs.getString(4)));//3 valuers_address1
					vecCol.add(correctNull(rs.getString(5)));//4 valuers_address2
					vecCol.add(correctNull(rs.getString(6)));//5 valuers_address3
					vecCol.add(correctNull(rs.getString(7)));//6 valuers_city
					vecCol.add(correctNull(rs.getString(8)));//7 valuers_state
					vecCol.add(correctNull(rs.getString(9)));//8 valuers_pincode
					vecCol.add(correctNull(rs.getString(10)));//9 valuers_country
					vecCol.add(correctNull(rs.getString(11)));//10 valuers_off_phoneno
					vecCol.add(correctNull(rs.getString(12)));//11 valuers_off_faxno
					vecCol.add(correctNull(rs.getString(13)));//12 valuers_res_phoneno
					vecCol.add(correctNull(rs.getString(14)));//13 valuers_res_mobno
					vecCol.add(correctNull(rs.getString(15)));//14 valuers_contper
					vecCol.add(correctNull(rs.getString(16)));//15 valuers_contper_phmobno
					vecCol.add(correctNull(rs.getString(17)));//16 valuers_design
					vecCol.add(correctNull(rs.getString(18)));//17 valuers_email
					vecCol.add(correctNull(rs.getString(19)));///18 valuers_empaneleddt
					vecCol.add(correctNull(rs.getString(20)));//19 valuers_active
					vecCol.add(correctNull(rs.getString(21)));//20 valuers_comments
					vecCol.add(correctNull(rs.getString(22)));//21 valuers_blacklist
					vecCol.add(correctNull(rs.getString(23)));//22 valuers_blacklistdate
					vecCol.add(correctNull(rs.getString(24)));//23 city_name
				//	vecCol.add(correctNull(rs.getString(25)));//
					vecCol.add(correctNull(rs.getString(25)));//24 state_name
					vecCol.add(correctNull(rs.getString(26)));//25 valuers_seqno
					vecCol.add(correctNull(rs.getString(27)));//26 Ref Number
					vecCol.add(correctNull(rs.getString(28)));//27 Expected Date of Sanction
					vecCol.add(correctNull(rs.getString(29)));//28 Security Deposit
					vecCol.add(correctNull(rs.getString(30)));//29 Jewel Appraiser Date
				
					vecCol.add(correctNull(rs.getString(31)));//30 CBS ID
						String branchname="";
						if(!correctNull(rs.getString("ORG_CODE")).equals(""))
						{
							String[] bankcode=(Helper.correctNull(rs.getString("ORG_CODE"))).split("@");
							for(int i=0;i<bankcode.length;i++)
							{
								if(rs1 != null)
									rs1.close();					
								strQuery = SQLParser.getSqlQuery("repbankname^"+bankcode[i]);
								rs1 = DBUtils.executeQuery(strQuery);
								while(rs1.next())
								{
									branchname=branchname+"@"+((correctNull(rs1.getString("org_name")))+" - "+(correctNull(rs1.getString("org_scode"))));
								}
							}
						}
					 vecCol.add(branchname.replaceFirst("@",""));//31
					vecCol.add(correctNull(rs.getString(32)));//32 Valuer nature
					vecCol.add(correctNull(rs.getString(33)));//33 Valuer code
					//vecCol.add(correctNull(rs.getString("VALUER_VALUEDLOC")));//34 Valuer location
					
					String strLoc="";
					if(!correctNull(rs.getString("VALUER_VALUEDLOC")).equals(""))
					{
						String[] strLocation=(Helper.correctNull(rs.getString("VALUER_VALUEDLOC"))).split("@");
						for(int i=0;i<strLocation.length;i++)
						{
							String[] strDet=strLocation[i].split("~");
							if(strDet.length>1)
							{
								if(rs1 != null)
									rs1.close();					
								strQuery = SQLParser.getSqlQuery("sel_districtmaster^"+strDet[1]);
								rs1 = DBUtils.executeQuery(strQuery);
								if(rs1.next())
								{
									strLoc=strLoc+strLocation[i]+"~"+(correctNull(rs1.getString("district_desc")))+"@";
								}
							}
						}
					}
					if(strLoc.equalsIgnoreCase(""))
						vecCol.add(strLoc);
					else
						vecCol.add(strLoc.substring(0, (strLoc.length()-1)));
					vecCol.add("");//35
					vecCol.add("");//36
					if(!correctNull(rs.getString("valuers_expdateofsanc")).equalsIgnoreCase(""))
					vecCol.add(String.valueOf(Helper.dateDiff(Helper.getCurrentDateTime(),correctNull(rs.getString("valuers_expdateofsanc")))));//37
					else
						vecCol.add("0");	
					
					strOrgNames=new StringBuffer();
					strOrgCodes=new StringBuffer();
					strExpiry=new StringBuffer();
					if(strAppVal.equalsIgnoreCase("J"))
					{
						if(rs1 != null)
						rs1.close();					
						strQuery = SQLParser.getSqlQuery("sel_valuer_orgdetails^"+correctNull(rs.getString(26)));
						rs1 = DBUtils.executeQuery(strQuery);
						while(rs1.next())
						{
							if(strOrgNames.length()==0)
							{
								strOrgNames.append(Helper.correctNull(rs1.getString("names")));
								strOrgCodes.append(Helper.correctNull(rs1.getString("valuer_orgcode")));
								strExpiry.append(Helper.correctNull(rs1.getString("valuer_expirydate")));
							}
							else
							{
								strOrgNames.append("~").append(Helper.correctNull(rs1.getString("names")));
								strOrgCodes.append("~").append(Helper.correctNull(rs1.getString("valuer_orgcode")));
								strExpiry.append("~").append(Helper.correctNull(rs1.getString("valuer_expirydate")));
							}
						}
					}
					vecCol.add(strOrgNames.toString());//38
					vecCol.add(strOrgCodes.toString());//39
					vecCol.add(strExpiry.toString());//40
				
					vecRow.add(vecCol);	
				}
				
			}
				hshRecord.put("vecRow",vecRow);
				hshRecord.put("svalue", svalue);
				hshRecord.put("scode", scode);
				hshRecord.put("appraiser",Helper.correctNull((String)hshValues.get("appraiser")));
				hshRecord.put("hidAppVal",Helper.correctNull((String)hshValues.get("hidAppVal")));
				hshRecord.put("nameidapp",name);
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getValuerMasterList "+ce.toString());
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
	public HashMap updateBSADmasterapi(HashMap hshValues)
	{
		ArrayList arrValues= new ArrayList();
		ArrayList arrResValues= new ArrayList();
		HashMap hshQuery= new HashMap();
		HashMap hshQueryValues= new HashMap();
		int intUpdatesize=0;
		
		try{
			
			ArrayList arrinsmaster=new ArrayList();
			ArrayList arrinsmasterval=new ArrayList();
			arrinsmaster=(ArrayList) hshValues.get("arrMaster");
			
			int arrmasterlen=arrinsmaster.size();
			
			if(arrmasterlen>0)
			{
				for(int i=0;i<arrmasterlen;i++)
				{
					
					arrinsmasterval=(ArrayList) arrinsmaster.get(i);
					
					if(!correctNull((String) arrinsmasterval.get(61)).equalsIgnoreCase(""))
					{
						arrValues = new ArrayList();
						hshQuery = new HashMap();
						intUpdatesize++;
						arrValues.add(correctNull((String) arrinsmasterval.get(1)));
						arrValues.add(correctNull((String) arrinsmasterval.get(2)));
						arrValues.add(correctNull((String) arrinsmasterval.get(3)));
						arrValues.add(correctNull((String) arrinsmasterval.get(4)));
						arrValues.add(correctNull((String) arrinsmasterval.get(5)));
						arrValues.add(correctNull((String) arrinsmasterval.get(6)));
						arrValues.add(correctNull((String) arrinsmasterval.get(7)));
						arrValues.add(correctNull((String) arrinsmasterval.get(8)));
						arrValues.add(correctNull((String) arrinsmasterval.get(9)));
						arrValues.add(correctNull((String) arrinsmasterval.get(10)));
						arrValues.add(correctNull((String) arrinsmasterval.get(11)));
						arrValues.add(correctNull((String) arrinsmasterval.get(12)));
						arrValues.add(correctNull((String) arrinsmasterval.get(13)));
						arrValues.add(correctNull((String) arrinsmasterval.get(14)));
						arrValues.add(correctNull((String) arrinsmasterval.get(15)));
						arrValues.add(correctNull((String) arrinsmasterval.get(16)));
						arrValues.add(correctNull((String) arrinsmasterval.get(17)));
						arrValues.add(correctNull((String) arrinsmasterval.get(18)));
						arrValues.add(correctNull((String) arrinsmasterval.get(19)));
						arrValues.add(correctNull((String) arrinsmasterval.get(20)));
						arrValues.add(correctNull((String) arrinsmasterval.get(21)));
						arrValues.add(correctNull((String) arrinsmasterval.get(22)));
						arrValues.add(correctNull((String) arrinsmasterval.get(23)));
						arrValues.add(correctNull((String) arrinsmasterval.get(24)));
						arrValues.add(correctNull((String) arrinsmasterval.get(25)));
						arrValues.add(correctNull((String) arrinsmasterval.get(26)));
						arrValues.add(correctNull((String) arrinsmasterval.get(27)));
						arrValues.add(correctNull((String) arrinsmasterval.get(28)));
						arrValues.add(correctNull((String) arrinsmasterval.get(29)));
						arrValues.add(correctNull((String) arrinsmasterval.get(30)));
						arrValues.add(correctNull((String) arrinsmasterval.get(31)));
						arrValues.add(correctNull((String) arrinsmasterval.get(32)));
						arrValues.add(correctNull((String) arrinsmasterval.get(33)));
						arrValues.add(correctNull((String) arrinsmasterval.get(34)));
						arrValues.add(correctNull((String) arrinsmasterval.get(35)));
						arrValues.add(correctNull((String) arrinsmasterval.get(36)));
						arrValues.add(correctNull((String) arrinsmasterval.get(37)));
						arrValues.add(correctNull((String) arrinsmasterval.get(38)));
						arrValues.add(correctNull((String) arrinsmasterval.get(39)));
						arrValues.add(correctNull((String) arrinsmasterval.get(40)));
						arrValues.add(correctNull((String) arrinsmasterval.get(41)));
						arrValues.add(correctNull((String) arrinsmasterval.get(42)));
						arrValues.add(correctNull((String) arrinsmasterval.get(43)));
						arrValues.add(correctNull((String) arrinsmasterval.get(44)));
						arrValues.add(correctNull((String) arrinsmasterval.get(45)));
						arrValues.add(correctNull((String) arrinsmasterval.get(46)));
						arrValues.add(correctNull((String) arrinsmasterval.get(47)));
						arrValues.add(correctNull((String) arrinsmasterval.get(48)));
						arrValues.add(correctNull((String) arrinsmasterval.get(49)));
						arrValues.add(correctNull((String) arrinsmasterval.get(50)));
						arrValues.add(correctNull((String) arrinsmasterval.get(51)));
						arrValues.add(correctNull((String) arrinsmasterval.get(52)));
						arrValues.add(correctNull((String) arrinsmasterval.get(53)));
						arrValues.add(correctNull((String) arrinsmasterval.get(54)));
						arrValues.add(correctNull((String) arrinsmasterval.get(55)));
						arrValues.add(correctNull((String) arrinsmasterval.get(56)));
						arrValues.add(correctNull((String) arrinsmasterval.get(57)));
						arrValues.add(correctNull((String) arrinsmasterval.get(58)));
						arrValues.add(correctNull((String) arrinsmasterval.get(59)));
						arrValues.add(correctNull((String) arrinsmasterval.get(60)));
						arrValues.add("Y");
						arrValues.add(correctNull((String) arrinsmasterval.get(61)));
						hshQuery.put("arrValues", arrValues);
						hshQuery.put("strQueryId", "upd_BSADSA_master");
						hshQueryValues.put(""+intUpdatesize, hshQuery);
						
						arrResValues.add("Master id : "+(correctNull((String) arrinsmasterval.get(61))+" has been Updated Successfully"));
					}else{
					ResultSet rs1=null;
					String strslno ="";
					rs1 = DBUtils.executeLAPSQuery("getmaxBSADSAmasterno");				
					while(rs1.next())
					{	
						strslno = rs1.getString("maxno");
					}
					
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					intUpdatesize++;
					String type = correctNull((String) arrinsmasterval.get(0));
					arrValues.add(type);
					arrValues.add(strslno);
					arrValues.add(type.concat(strslno));//BSADSA_ID			
					arrValues.add(correctNull((String) arrinsmasterval.get(1)));
					arrValues.add(correctNull((String) arrinsmasterval.get(2)));
					arrValues.add(correctNull((String) arrinsmasterval.get(3)));
					arrValues.add(correctNull((String) arrinsmasterval.get(4)));
					arrValues.add(correctNull((String) arrinsmasterval.get(5)));
					arrValues.add(correctNull((String) arrinsmasterval.get(6)));
					arrValues.add(correctNull((String) arrinsmasterval.get(7)));
					arrValues.add(correctNull((String) arrinsmasterval.get(8)));
					arrValues.add(correctNull((String) arrinsmasterval.get(9)));
					arrValues.add(correctNull((String) arrinsmasterval.get(10)));
					arrValues.add(correctNull((String) arrinsmasterval.get(11)));
					arrValues.add(correctNull((String) arrinsmasterval.get(12)));
					arrValues.add(correctNull((String) arrinsmasterval.get(13)));
					arrValues.add(correctNull((String) arrinsmasterval.get(14)));
					arrValues.add(correctNull((String) arrinsmasterval.get(15)));
					arrValues.add(correctNull((String) arrinsmasterval.get(16)));
					arrValues.add(correctNull((String) arrinsmasterval.get(17)));
					arrValues.add(correctNull((String) arrinsmasterval.get(18)));
					arrValues.add(correctNull((String) arrinsmasterval.get(19)));
					arrValues.add(correctNull((String) arrinsmasterval.get(20)));
					arrValues.add(correctNull((String) arrinsmasterval.get(21)));
					arrValues.add(correctNull((String) arrinsmasterval.get(22)));
					arrValues.add(correctNull((String) arrinsmasterval.get(23)));
					arrValues.add(correctNull((String) arrinsmasterval.get(24)));
					arrValues.add(correctNull((String) arrinsmasterval.get(25)));
					arrValues.add(correctNull((String) arrinsmasterval.get(26)));
					arrValues.add(correctNull((String) arrinsmasterval.get(27)));
					arrValues.add(correctNull((String) arrinsmasterval.get(28)));
					arrValues.add(correctNull((String) arrinsmasterval.get(29)));
					arrValues.add(correctNull((String) arrinsmasterval.get(30)));
					arrValues.add(correctNull((String) arrinsmasterval.get(31)));
					arrValues.add(correctNull((String) arrinsmasterval.get(32)));
					arrValues.add(correctNull((String) arrinsmasterval.get(33)));
					arrValues.add(correctNull((String) arrinsmasterval.get(34)));
					arrValues.add(correctNull((String) arrinsmasterval.get(35)));
					arrValues.add(correctNull((String) arrinsmasterval.get(36)));
					arrValues.add(correctNull((String) arrinsmasterval.get(37)));
					arrValues.add(correctNull((String) arrinsmasterval.get(38)));
					arrValues.add(correctNull((String) arrinsmasterval.get(39)));
					arrValues.add(correctNull((String) arrinsmasterval.get(40)));
					arrValues.add(correctNull((String) arrinsmasterval.get(41)));
					arrValues.add(correctNull((String) arrinsmasterval.get(42)));
					arrValues.add(correctNull((String) arrinsmasterval.get(43)));
					arrValues.add(correctNull((String) arrinsmasterval.get(44)));
					arrValues.add(correctNull((String) arrinsmasterval.get(45)));
					arrValues.add(correctNull((String) arrinsmasterval.get(46)));
					arrValues.add(correctNull((String) arrinsmasterval.get(47)));
					arrValues.add(correctNull((String) arrinsmasterval.get(48)));
					arrValues.add(correctNull((String) arrinsmasterval.get(49)));
					arrValues.add(correctNull((String) arrinsmasterval.get(50)));
					arrValues.add(correctNull((String) arrinsmasterval.get(51)));
					arrValues.add(correctNull((String) arrinsmasterval.get(52)));
					arrValues.add(correctNull((String) arrinsmasterval.get(53)));
					arrValues.add(correctNull((String) arrinsmasterval.get(54)));
					arrValues.add(correctNull((String) arrinsmasterval.get(55)));
					arrValues.add(correctNull((String) arrinsmasterval.get(56)));
					arrValues.add(correctNull((String) arrinsmasterval.get(57)));
					arrValues.add(correctNull((String) arrinsmasterval.get(58)));
					arrValues.add(correctNull((String) arrinsmasterval.get(59)));
					arrValues.add(correctNull((String) arrinsmasterval.get(60)));
					arrValues.add("Y");
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "ins_BSADSA_master");
					hshQueryValues.put(""+intUpdatesize, hshQuery);
					
					arrResValues.add("Master id : "+type.concat(strslno+" has been Created Successfully"));
					}
				}
			}
			
			hshQueryValues.put("size",String.valueOf(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
			
			hshValues.put("masterId", arrResValues);
			hshValues.put("strResponseCode", "LAPS-1013");
			hshValues.put("strResponseMsg", "Success");
			
		}catch (Exception A){
			throw new EJBException("Error in updateBSADmasterapi method in staticdataBean "+A.toString());						
		}
		return hshValues;
	}
	public HashMap getmiborbranchlist(HashMap hshValues)
	{
	
		
		String strQuery="";
		String strQuery2="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord =new HashMap();
		String strgecltype = "";
		String strdatahead = "";
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=null;
		
		try
		{
			
			strdatahead = correctNull((String)hshValues.get("statheadcode"));
			strgecltype = correctNull((String)hshValues.get("GeclType"));
			
			strQuery=SQLParser.getSqlQuery("getallorganizationformibor");		
			rs = DBUtils.executeQuery(strQuery);
			arrRow=new ArrayList();
			while(rs.next())
			//if(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("ORG_NAME")));//1
				arrCol.add(Helper.correctNull((String)rs.getString("ORG_CODE")));//2
				arrCol.add(Helper.correctNull((String)rs.getString("ORG_SCODE")));//3
				arrCol.add(Helper.correctNull((String)rs.getString("ORG_LEVEL")));//4
				if(rs1 != null)
				{
					rs1.close();
				}
				strQuery2=SQLParser.getSqlQuery("getscodebasedon_sel_mibore^" + Helper.correctNull((String)rs.getString("ORG_SCODE")) );		
				rs1 = DBUtils.executeQuery(strQuery2);
				if(rs1.next())
				{
					arrCol.add(Helper.correctNull((String)rs1.getString("ORG_MIBOR_SEL")));//5
				}
				else
				{
					arrCol.add("");
				}
                
				
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getmiborbranchlist "+ce.toString());
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
	
	public void updatemiborbranchlist(HashMap hshValues)
	{
	
		
		String strQuery="";
		String strQuery2="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		//HashMap hshRecord =new HashMap();
		HashMap	hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		
	
		try
		{
			String[] org_name=null;
			String[] org_code=null;
			String[] org_scode=null;
			String[] org_level=null;
			String[] chk_mibor2=null;
			
			
			
			if(hshValues.get("org_name") instanceof String[])
			{
				org_name= ((String[]) hshValues.get("org_name"));		
			}else
			{
				org_name=new String[1];
				org_name[0]= ((String) hshValues.get("org_name"));
			}
			if(hshValues.get("org_code") instanceof String[])
			{
				org_code= ((String[]) hshValues.get("org_code"));		
			}else
			{
				org_code=new String[1];
				org_code[0]= ((String) hshValues.get("org_code"));
			}
			if(hshValues.get("org_scode") instanceof String[])
			{
				org_scode= ((String[]) hshValues.get("org_scode"));		
			}else
			{
				org_scode=new String[1];
				org_scode[0]= ((String) hshValues.get("org_scode"));
			}
			if(hshValues.get("org_level") instanceof String[])
			{
				org_level= ((String[]) hshValues.get("org_level"));		
			}else
			{
				org_level=new String[1];
				org_level[0]= ((String) hshValues.get("org_level"));
			}
			if(hshValues.get("chk_mibor2") instanceof String[])
			{
				chk_mibor2= ((String[]) hshValues.get("chk_mibor2"));		
			}else
			{
				chk_mibor2=new String[1];
				chk_mibor2[0]= ((String) hshValues.get("chk_mibor2"));
			}
			
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "delmibordata");
				arrValues = new ArrayList();
				//arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
				int TotalNo = chk_mibor2.length;
				for(int j=0;j<TotalNo;j++)
				{
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "insertmibordata");
					
					arrValues.add(org_name[j]);
					arrValues.add(org_code[j]);
					arrValues.add(org_scode[j]);
					arrValues.add(org_level[j]);
					arrValues.add(chk_mibor2[j]);
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);			
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				}
				
			
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updatemiborbranchlist "+ce.toString());
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


 
public HashMap getActivityMasterList(HashMap hshValues) 
{

	String strQuery="",scode="",svalue="";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
	ArrayList vecCol		= new ArrayList();
	ArrayList vecRow		= new ArrayList();
	String strOrgCode ="";
	String strAction = null;
	String strRegionalcode="";
	try
	{
		
		strAction   = correctNull((String)hshValues.get("hidAction"));
		String strsno	= correctNull((String )hshValues.get("hidsno"));
		strOrgCode = correctNull((String) hshValues.get("strOrgCode"));
		strRegionalcode=correctNull((String) hshValues.get("strOrgCode")).substring(0,9);
				
		if((strsno.trim().equals("")))
		{
			strsno="0";
		}
		if(strAction.equalsIgnoreCase("Edit")||strAction.equalsIgnoreCase("Cancel"))
		{
			strQuery = SQLParser.getSqlQuery("sel_lawyermaster^"+strOrgCode+"^"+strsno);
			rs = DBUtils.executeQuery(strQuery);				
			if(rs.next())
			{					
				hshRecord.put("ORG_CODE",(correctNull(rs.getString("ORG_CODE"))));
				hshRecord.put("LAWYER_CODE",(correctNull(rs.getString("LAWYER_CODE"))));
				hshRecord.put("LAWYER_NAME",(correctNull(rs.getString("LAWYER_NAME"))));
				hshRecord.put("LAWYER_ADDRESS1",(correctNull(rs.getString("LAWYER_ADDRESS1"))));
				hshRecord.put("LAWYER_ADDRESS2",(correctNull(rs.getString("LAWYER_ADDRESS2"))));
				hshRecord.put("LAWYER_ADDRESS3",(correctNull(rs.getString("LAWYER_ADDRESS3"))));
				hshRecord.put("LAWYER_CITY_CODE",(correctNull(rs.getString("LAWYER_CITY"))));
				hshRecord.put("LAWYER_STATE_CODE",(correctNull(rs.getString("LAWYER_STATE"))));
				hshRecord.put("LAWYER_PINCODE",(correctNull(rs.getString("LAWYER_PINCODE"))));
				hshRecord.put("LAWYER_COUNTRY",(correctNull(rs.getString("LAWYER_COUNTRY"))));
				hshRecord.put("LAWYER_OFF_PHONENO",(correctNull(rs.getString("LAWYER_OFF_PHONENO"))));
				hshRecord.put("LAWYER_OFF_FAXNO",(correctNull(rs.getString("LAWYER_OFF_FAXNO"))));
				hshRecord.put("LAWYER_RES_PHONENO",(correctNull(rs.getString("LAWYER_RES_PHONENO"))));
				hshRecord.put("LAWYER_RES_MOBNO",(correctNull(rs.getString("LAWYER_RES_MOBNO"))));
				hshRecord.put("LAWYER_CONTPER",(correctNull(rs.getString("LAWYER_CONTPER"))));
				hshRecord.put("LAWYER_CONTPER_PHMOBNO",(correctNull(rs.getString("LAWYER_CONTPER_PHMOBNO"))));					
				hshRecord.put("LAWYER_DESIGN",(correctNull(rs.getString("LAWYER_DESIGN"))));
				hshRecord.put("LAWYER_EMAIL",(correctNull(rs.getString("LAWYER_EMAIL"))));
				String empaneldate=(correctNull(rs.getString("LAWYER_EMPANELEDDT")));
				if(empaneldate.equalsIgnoreCase("01/01/1900"))
				{
					hshRecord.put("LAWYER_EMPANELEDDT","");
				}
				else
				{
					hshRecord.put("LAWYER_EMPANELEDDT",(correctNull(rs.getString("LAWYER_EMPANELEDDT"))));
				}
				hshRecord.put("LAWYER_ACTIVE",(correctNull(rs.getString("LAWYER_ACTIVE"))));
				hshRecord.put("LAWYER_COMMENTS",(correctNull(rs.getString("LAWYER_COMMENTS"))));
				hshRecord.put("lawyer_blacklist",(correctNull(rs.getString("lawyer_blacklist"))));
				String blacklistdate=(correctNull(rs.getString("lawyer_blacklistdate")));
				if(blacklistdate.equalsIgnoreCase("01/01/1900"))
				{
					hshRecord.put("lawyer_blacklistdate","");
				}
				else
				{
					hshRecord.put("lawyer_blacklistdate",(correctNull(rs.getString("lawyer_blacklistdate"))));
				}
				
				hshRecord.put("LAWYER_ELITEPANEL", (correctNull(rs.getString("LAWYER_ELITEPANEL"))));
			//	hshRecord.put("DESIGN_NAME",(correctNull(rs.getString("DESIGN_NAME"))));
				hshRecord.put("LAWYER_CITY",(correctNull(rs.getString("CITY_NAME"))));
				hshRecord.put("LAWYER_STATE",(correctNull(rs.getString("STATE_NAME"))));
				hshRecord.put("lawyer_seqno",(correctNull(rs.getString("lawyer_seqno"))));
				hshRecord.put("trapedit","E");
			}
		}
		else if(strAction.equalsIgnoreCase("search"))
		{
			scode=correctNull((String)hshValues.get("stype"));
			svalue=correctNull((String)hshValues.get("svalue"));
			String strPagefrom=Helper.correctNull((String)hshValues.get("strfrom"));
			
			if(strPagefrom.equalsIgnoreCase("LawyerMaster"))
			{
				if(scode.equals(""))
				{
					rs=DBUtils.executeLAPSQuery("sel_lawyermasterall");
				}				
				else if(scode.equals("N"))
				{
					strQuery = SQLParser.getSqlQuery("sel_lawyermastername^"+svalue);
					rs = DBUtils.executeQuery(strQuery);
				}	
			}
			else
			{
				if(scode.equals(""))
				{
					rs=DBUtils.executeLAPSQuery("sel_lawyermasterall_search^"+strOrgCode);
				}				
				else if(scode.equals("N"))
				{
					strQuery = SQLParser.getSqlQuery("sel_lawyermastername_search^"+strOrgCode+"^"+svalue);
					rs = DBUtils.executeQuery(strQuery);
				}	
			}
			while(rs.next())
			{
				
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));//0	org_code		 		
				vecCol.add(correctNull(rs.getString(2)));//1	lawyer_code				
				vecCol.add(correctNull(rs.getString(3)));//2 lawyer_name
				vecCol.add(correctNull(rs.getString(4)));//3 lawyer_address1
				vecCol.add(correctNull(rs.getString(5)));//4 lawyer_address2
				vecCol.add(correctNull(rs.getString(6)));//5 lawyer_address3
				vecCol.add(correctNull(rs.getString(7)));//6 lawyer_city
				vecCol.add(correctNull(rs.getString(8)));//7 lawyer_state
				vecCol.add(correctNull(rs.getString(9)));//8 lawyer_pincode 
				vecCol.add(correctNull(rs.getString(10)));//9 lawyer_country
				vecCol.add(correctNull(rs.getString(11)));//10 lawyer_off_phoneno
				vecCol.add(correctNull(rs.getString(12)));//11 lawyer_off_faxno
				vecCol.add(correctNull(rs.getString(13)));//12 lawyer_res_phoneno
				vecCol.add(correctNull(rs.getString(14)));//13 lawyer_res_mobno
				vecCol.add(correctNull(rs.getString(15)));//14 lawyer_contper
				vecCol.add(correctNull(rs.getString(16)));//15 lawyer_contper_phmobno
				vecCol.add(correctNull(rs.getString(17)));//16 lawyer_design			
				vecCol.add(correctNull(rs.getString(18)));//17 lawyer_email
				vecCol.add(correctNull(rs.getString(19)));//18 lawyer_empaneleddt
				vecCol.add(correctNull(rs.getString(20)));//19 lawyer_active
				vecCol.add(correctNull(rs.getString(21)));//20 lawyer_comments
				vecCol.add(correctNull(rs.getString(22)));//21 lawyer_blacklist
				vecCol.add(correctNull(rs.getString(23)));//22 lawyer_blacklistdate
				//vecCol.add(correctNull(rs.getString(24)));//23 design_name
				vecCol.add(correctNull(rs.getString(24)));//23 city_name
				vecCol.add(correctNull(rs.getString(25)));//24 state_name
				vecCol.add(correctNull(rs.getString(26)));//25 lawyer_seqno
				vecCol.add(correctNull(rs.getString(27)));//26 elitepanel
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow",vecRow);
			hshRecord.put("svalue", svalue);
			hshRecord.put("scode", scode);
		}
	}
	catch(Exception ce)
	{
		throw new EJBException("Error in getLawyerMasterList "+ce.toString());
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

public HashMap getActivityDetails(HashMap hshValues) throws EJBException
{		
	String strQuery="";
	ResultSet rs=null,rs1 = null;
	HashMap hshRecord = new HashMap();
	ArrayList vecCatid = new ArrayList();
	ArrayList vecCatName = new ArrayList();
	String strValue = "";
	String strParent = "1";
	String strPage="";
	String strid="";

	try
	{		
		if(FwHelper.correctNull((String)hshValues.get("strtype")).equalsIgnoreCase("Actname"))
		{
				strQuery = SQLParser.getSqlQuery("selagriunitcostmasterschstateType^"+FwHelper.correctNull((String)hshValues.get("sel_activityname"))+"^"+FwHelper.correctNull((String)hshValues.get("sel_state")));
			
		
		

		rs = DBUtils.executeQuery(strQuery);
		
		while(rs.next())
		{
			vecCatid=new ArrayList();
			String selScheme= Helper.correctNull((String)rs.getString("AGR_DATA_SCHEME"));
			String sel_state = Helper.correctNull((String)rs.getString("AGR_DATA_STATE"));
			String sel_actname = Helper.correctNull((String)rs.getString("AGR_DATA_ACTNAME"));
			String sel_specifica=Helper.correctNull((String)rs.getString("AGR_DATA_SPECIFICATIONS"));
			String sel_Action=Helper.correctNull((String)rs.getString("AGR_ACTIVE"));
			String strSno = Helper.correctNull((String)rs.getString("AGR_DATA_ID"));
			
			vecCatid.add(sel_actname);
			//vecCatName.add(sel_actname);
			
			strQuery = SQLParser.getSqlQuery("sel_static_data_masterauc1^"+"286"+"^"+sel_actname);
			rs1 = DBUtils.executeQuery(strQuery);
			
			if(rs1.next())
			{
				sel_actname=Helper.correctNull((String)rs1.getString("stat_data_desc1"));
			}
			
				
				
			
			if(rs1!=null){
				rs1.close();
			}
			vecCatid.add(sel_actname);
				
			vecCatName.add(vecCatid);		
				
		}
		}
		
		
		if(FwHelper.correctNull((String)hshValues.get("strtype")).equalsIgnoreCase("Specname"))
		{
				strQuery = SQLParser.getSqlQuery("selagriunitcostmasterschstateActType^"+FwHelper.correctNull((String)hshValues.get("sel_activityname"))+"^"+FwHelper.correctNull((String)hshValues.get("sel_state"))+"^"+FwHelper.correctNull((String)hshValues.get("txt_activity")));
			
		

		rs = DBUtils.executeQuery(strQuery);
		
		while(rs.next())
		{
			vecCatid=new ArrayList();
			String selScheme= Helper.correctNull((String)rs.getString("AGR_DATA_SCHEME"));
			String sel_state = Helper.correctNull((String)rs.getString("AGR_DATA_STATE"));
			String sel_actname = Helper.correctNull((String)rs.getString("AGR_DATA_ACTNAME"));
			String sel_specifica=Helper.correctNull((String)rs.getString("AGR_DATA_SPECIFICATIONS"));
			String sel_Action=Helper.correctNull((String)rs.getString("AGR_ACTIVE"));
			String strSno = Helper.correctNull((String)rs.getString("AGR_DATA_ID"));
			
			vecCatid.add(sel_specifica);
			//vecCatName.add(sel_actname);
			
			strQuery = SQLParser.getSqlQuery("sel_static_data_masterauc1^"+"287"+"^"+sel_specifica);
			rs1 = DBUtils.executeQuery(strQuery);
			
			if(rs1.next())
			{
				sel_specifica=Helper.correctNull((String)rs1.getString("stat_data_desc1"));
			}
			
				
				
			
			if(rs1!=null){
				rs1.close();
			}
			vecCatid.add(sel_specifica);
				
			vecCatName.add(vecCatid);		
				
		}
		}
		
		hshRecord.put("vecCodes",vecCatid);
		hshRecord.put("vecValues",vecCatName);
		hshRecord.put("strtype",FwHelper.correctNull((String)hshValues.get("strtype")));
	}
	catch(Exception ce)
	{
		System.out.println(ce.toString());
		throw new EJBException("Error in help "+ce.toString());
	}
	finally
	{
		try
		{
			if(rs !=null)
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



public HashMap getActivitySpecificationbtdetails(HashMap hshValues) 
{

	String strQuery="",scode="",svalue="";
		ResultSet rs = null,rs1=null;
		HashMap hshRecord = new HashMap();
	ArrayList vecCol		= new ArrayList();
	ArrayList vecRow		= new ArrayList();
	String strOrgCode ="";
	String strAction = Helper.correctNull((String)hshValues.get("hidAction"));
	String strRegionalcode="";
	try
	{
		 if(strAction.equalsIgnoreCase("search"))
		{
			 if(FwHelper.correctNull((String)hshValues.get("strfrom")).equalsIgnoreCase("activityname"))
				{
			 strQuery = SQLParser.getSqlQuery("selagriunitcostmasterschstateType^"+FwHelper.correctNull((String)hshValues.get("sel_activityname"))+"^"+FwHelper.correctNull((String)hshValues.get("sel_state")));
				}
			 if(FwHelper.correctNull((String)hshValues.get("strfrom")).equalsIgnoreCase("specifications"))
				{
						strQuery = SQLParser.getSqlQuery("selagriunitcostmasterschstateActType^"+FwHelper.correctNull((String)hshValues.get("sel_activityname"))+"^"+FwHelper.correctNull((String)hshValues.get("sel_state"))+"^"+FwHelper.correctNull((String)hshValues.get("txt_activity")));
				}
			 rs = DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{
					vecCol= new ArrayList();
					String selScheme= Helper.correctNull((String)rs.getString("AGR_DATA_SCHEME"));
					String sel_state = Helper.correctNull((String)rs.getString("AGR_DATA_STATE"));
					String sel_actname = Helper.correctNull((String)rs.getString("AGR_DATA_ACTNAME"));
					String sel_specifica=Helper.correctNull((String)rs.getString("AGR_DATA_SPECIFICATIONS"));
					String sel_Action=Helper.correctNull((String)rs.getString("AGR_ACTIVE"));
					String strSno = Helper.correctNull((String)rs.getString("AGR_DATA_ID"));
					hshRecord.put("selScheme", Helper.correctNull((String)rs.getString("AGR_DATA_SCHEME")));
					hshRecord.put("sel_state", Helper.correctNull((String)rs.getString("AGR_DATA_STATE")));
					hshRecord.put("sel_actname", Helper.correctNull((String)rs.getString("AGR_DATA_ACTNAME")));
					
					hshRecord.put("sel_specifica",Helper.correctNull((String)rs.getString("AGR_DATA_SPECIFICATIONS")));
					//hshRecord.put("sel_state", Helper.correctNull((String)rs.getString("AGR_DATA_STATE")));
					if(FwHelper.correctNull((String)hshValues.get("strfrom")).equalsIgnoreCase("activityname"))
					{
					vecCol.add(sel_actname);
					//vecCatName.add(sel_actname);
					}	
					
					if(FwHelper.correctNull((String)hshValues.get("strfrom")).equalsIgnoreCase("specifications"))
					{
						vecCol.add(sel_specifica);
					}
						
					if(FwHelper.correctNull((String)hshValues.get("strfrom")).equalsIgnoreCase("activityname"))
					{
					strQuery = SQLParser.getSqlQuery("sel_static_data_masterauc1^"+"286"+"^"+sel_actname);
					rs1 = DBUtils.executeQuery(strQuery);
					
					if(rs1.next())
					{
						sel_actname=Helper.correctNull((String)rs1.getString("stat_data_desc1"));
					}
					
					if(rs1!=null)							
					{
						rs1.close();
					}
					vecCol.add(sel_actname);
					}
					if(FwHelper.correctNull((String)hshValues.get("strfrom")).equalsIgnoreCase("specifications"))
					{
					strQuery = SQLParser.getSqlQuery("sel_static_data_masterauc1^"+"287"+"^"+sel_specifica);
					rs1 = DBUtils.executeQuery(strQuery);
					
					if(rs1.next())
					{
						sel_specifica=Helper.correctNull((String)rs1.getString("stat_data_desc1"));
					}
					
					if(rs1!=null)							
					{
						rs1.close();
					}
					vecCol.add(sel_specifica);
					}
					
					vecRow.add(vecCol);	
				
				}
		}
		 
		 
		 if(strAction.equalsIgnoreCase("search"))
			{
			 
		 if(FwHelper.correctNull((String)hshValues.get("stype")).equalsIgnoreCase("Actname") && (!FwHelper.correctNull((String)hshValues.get("svalue")).equalsIgnoreCase("")))
			{
					strQuery = SQLParser.getSqlQuery("selagriunitcostmasterschstateActTypelike^"+FwHelper.correctNull((String)hshValues.get("hidscheme"))+"^"+FwHelper.correctNull((String)hshValues.get("hidstate"))+"^"+FwHelper.correctNull((String)hshValues.get("svalue")));
				
			
			

			rs = DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				vecCol= new ArrayList();
				String selScheme= Helper.correctNull((String)rs.getString("AGR_DATA_SCHEME"));
				String sel_state = Helper.correctNull((String)rs.getString("AGR_DATA_STATE"));
				String sel_actname = Helper.correctNull((String)rs.getString("AGR_DATA_ACTNAME"));
				String sel_specifica=Helper.correctNull((String)rs.getString("AGR_DATA_SPECIFICATIONS"));
				String sel_Action=Helper.correctNull((String)rs.getString("AGR_ACTIVE"));
				String strSno = Helper.correctNull((String)rs.getString("AGR_DATA_ID"));
				
				hshRecord.put("sel_specifica",Helper.correctNull((String)rs.getString("AGR_DATA_SPECIFICATIONS")));
				hshRecord.put("selScheme", Helper.correctNull((String)rs.getString("AGR_DATA_SCHEME")));
				hshRecord.put("sel_state", Helper.correctNull((String)rs.getString("AGR_DATA_STATE")));
				hshRecord.put("sel_actname", Helper.correctNull((String)rs.getString("AGR_DATA_ACTNAME")));
				
				vecCol.add(sel_actname);
				//vecCatName.add(sel_actname);
				
				strQuery = SQLParser.getSqlQuery("sel_static_data_masterauc1^"+"286"+"^"+sel_actname);
				rs1 = DBUtils.executeQuery(strQuery);
				
				if(rs1.next())
				{
					sel_actname=Helper.correctNull((String)rs1.getString("stat_data_desc1"));
				}
				
				vecCol.add(sel_actname);
				if(rs1!=null)							
				{
					rs1.close();
				}
					
				vecRow.add(vecCol);		
					
			}
			}
			
			
		 if(FwHelper.correctNull((String)hshValues.get("stype")).equalsIgnoreCase("specifications") && (!FwHelper.correctNull((String)hshValues.get("svalue")).equalsIgnoreCase("")))
			{
			
					strQuery = SQLParser.getSqlQuery("selagriunitcostmasterschstateActSpecTypelike^"+FwHelper.correctNull((String)hshValues.get("hidscheme"))+"^"+FwHelper.correctNull((String)hshValues.get("hidstate"))+"^"+FwHelper.correctNull((String)hshValues.get("hidactivity"))+"^"+FwHelper.correctNull((String)hshValues.get("svalue")));
				
			

			rs = DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				vecCol=new ArrayList();
				String selScheme= Helper.correctNull((String)rs.getString("AGR_DATA_SCHEME"));
				String sel_state = Helper.correctNull((String)rs.getString("AGR_DATA_STATE"));
				String sel_actname = Helper.correctNull((String)rs.getString("AGR_DATA_ACTNAME"));
				String sel_specifica=Helper.correctNull((String)rs.getString("AGR_DATA_SPECIFICATIONS"));
				String sel_Action=Helper.correctNull((String)rs.getString("AGR_ACTIVE"));
				String strSno = Helper.correctNull((String)rs.getString("AGR_DATA_ID"));
				
				hshRecord.put("selScheme", Helper.correctNull((String)rs.getString("AGR_DATA_SCHEME")));
				hshRecord.put("sel_state", Helper.correctNull((String)rs.getString("AGR_DATA_STATE")));
				hshRecord.put("sel_specifica",Helper.correctNull((String)rs.getString("AGR_DATA_SPECIFICATIONS")));
				hshRecord.put("sel_actname", Helper.correctNull((String)rs.getString("AGR_DATA_ACTNAME")));
				
				
				vecCol.add(sel_specifica);
				//vecCatName.add(sel_actname);
				
				strQuery = SQLParser.getSqlQuery("sel_static_data_masterauc1^"+"287"+"^"+sel_specifica);
				rs1 = DBUtils.executeQuery(strQuery);
				
				if(rs1.next())
				{
					sel_specifica=Helper.correctNull((String)rs1.getString("stat_data_desc1"));
				}
				
				vecCol.add(sel_specifica);
				
				if(rs1!=null)							
				{
					rs1.close();
				}
					
				vecRow.add(vecCol);			
					
			}
			}
			}
			hshRecord.put("vecRow",vecRow);
			hshRecord.put("svalue", FwHelper.correctNull((String)hshValues.get("svalue")));
			if(FwHelper.correctNull((String)hshValues.get("strfrom")).equalsIgnoreCase(""))
			{
			hshRecord.put("strfrom", FwHelper.correctNull((String)hshValues.get("strfrom")));
			}
			else
			{
				hshRecord.put("strfrom", FwHelper.correctNull((String)hshValues.get("stype")));
			}
			//hshRecord.put("scode", scode);
		
			hshRecord.put("strfrom", FwHelper.correctNull((String)hshValues.get("strfrom")));
	}
	catch(Exception ce)
	{
		throw new EJBException("Error in getActivitySpecificationbtdetails "+ce.toString());
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



public HashMap getDetailsActivitySpecifications(HashMap hshValues) 
{

	String strQuery="",scode="",svalue="";
		ResultSet rs = null,rs1=null;
		HashMap hshRecord = new HashMap();
	ArrayList vecCol		= new ArrayList();
	ArrayList vecRow		= new ArrayList();
	String strOrgCode ="";
	String strAction = Helper.correctNull((String)hshValues.get("hidAction"));
	String strRegionalcode="";
	try
	{
		
		/*	{hidBeanGetMethod=getDetailsActivitySpecifications, strOrgSelect=001,
		 strGrpPrivilege=w, strUserId=K10197, strfrom=specifications, strUserDesignation=1989,
		 txt_activity=Contour bunding, strPwdExpiryDate=03/03/2049, strServerPort=8188,
		 strUserGrpId=1, strKalypto=192.168.0.224, c_password=laps1234, strPwdExpiryDays=9583,
		 strUserDepartment=008, stype=ACT, strOrgCode=001000000000000, NSDL=Y, strlastlogindate=08/12/2022 14:53:29,
		 sel_state=6, irb_desc=Test, strRLPFUser=, strlastlogoutdate=30/11/2022 10:18:26, hidlogincount=1,
		 strServerIP=192.168.0.27, strSolid=001, FVC=Y, strOrgLevel=C,
		 sel_specifications=depending on type of land, hidAction=search,
		 strOrgName=HEAD OFFICE, strUserName=Harish Venkat, sel_activityname=depending on type of land,
		 strGroupRights=111101100001100001w011111111111, sessionModuleType=, hidBeanId=staticdata,
		 strONLINELAPS=Test, strIsSaral=0,
		 NPA=, strOrgShortCode=001, strUserClass=130, strClientIP=192.168.0.27}*/
			 
		 if(FwHelper.correctNull((String)hshValues.get("stype")).equalsIgnoreCase("ACT") )
			{
					strQuery = SQLParser.getSqlQuery("selagriunitcostmasterschstateActTypelike^"+FwHelper.correctNull((String)hshValues.get("sel_activityname"))+"^"+FwHelper.correctNull((String)hshValues.get("sel_state"))+"^"+FwHelper.correctNull((String)hshValues.get("txt_activity")));
				
			
			

			rs = DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				vecCol= new ArrayList();
				String selScheme= Helper.correctNull((String)rs.getString("AGR_DATA_SCHEME"));
				String sel_state = Helper.correctNull((String)rs.getString("AGR_DATA_STATE"));
				String sel_actname = Helper.correctNull((String)rs.getString("AGR_DATA_ACTNAME"));
				String sel_specifica=Helper.correctNull((String)rs.getString("AGR_DATA_SPECIFICATIONS"));
				String sel_Action=Helper.correctNull((String)rs.getString("AGR_ACTIVE"));
				String strSno = Helper.correctNull((String)rs.getString("AGR_DATA_ID"));
				
				
				hshRecord.put("selScheme", Helper.correctNull((String)rs.getString("AGR_DATA_SCHEME")));
				hshRecord.put("sel_state", Helper.correctNull((String)rs.getString("AGR_DATA_STATE")));
				hshRecord.put("sel_actname", Helper.correctNull((String)rs.getString("AGR_DATA_ACTNAME")));
				
				vecCol.add(sel_actname);
				//vecCatName.add(sel_actname);
				
				strQuery = SQLParser.getSqlQuery("sel_static_data_masterauc1^"+"286"+"^"+sel_actname);
				rs1 = DBUtils.executeQuery(strQuery);
				
				if(rs1.next())
				{
					hshRecord.put("sel_actnamedesc",Helper.correctNull((String)rs1.getString("stat_data_desc1")));
				}
				else
				{
					hshRecord.put("sel_actnamedesc",sel_actname);
				}
				
				vecCol.add(sel_actname);
				if(rs1!=null)							
				{
					rs1.close();
				}
					
				vecRow.add(vecCol);		
					
			}
			}
			
			
		 if(FwHelper.correctNull((String)hshValues.get("stype")).equalsIgnoreCase("SPEC"))
			{
			
					strQuery = SQLParser.getSqlQuery("selagriunitcostmasterschstateActSpecTypelike^"+FwHelper.correctNull((String)hshValues.get("sel_activityname"))+"^"+FwHelper.correctNull((String)hshValues.get("sel_state"))+"^"+FwHelper.correctNull((String)hshValues.get("txt_activity"))+"^"+FwHelper.correctNull((String)hshValues.get("sel_specifications")));
				
					
			rs = DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				vecCol=new ArrayList();
				String selScheme= Helper.correctNull((String)rs.getString("AGR_DATA_SCHEME"));
				String sel_state = Helper.correctNull((String)rs.getString("AGR_DATA_STATE"));
				String sel_actname = Helper.correctNull((String)rs.getString("AGR_DATA_ACTNAME"));
				String sel_specifica=Helper.correctNull((String)rs.getString("AGR_DATA_SPECIFICATIONS"));
				String sel_Action=Helper.correctNull((String)rs.getString("AGR_ACTIVE"));
				String strSno = Helper.correctNull((String)rs.getString("AGR_DATA_ID"));
				
				hshRecord.put("selScheme", Helper.correctNull((String)rs.getString("AGR_DATA_SCHEME")));
				hshRecord.put("sel_state", Helper.correctNull((String)rs.getString("AGR_DATA_STATE")));
				hshRecord.put("sel_specifica",Helper.correctNull((String)rs.getString("AGR_DATA_SPECIFICATIONS")));
				hshRecord.put("sel_actname", Helper.correctNull((String)rs.getString("AGR_DATA_ACTNAME")));
				
				strQuery = SQLParser.getSqlQuery("sel_static_data_masterauc1^"+"286"+"^"+sel_actname);
				rs1 = DBUtils.executeQuery(strQuery);
				
				if(rs1.next())
				{
					hshRecord.put("sel_actnamedesc",Helper.correctNull((String)rs1.getString("stat_data_desc1")));
				}
				else
				{
					hshRecord.put("sel_actnamedesc",sel_actname);
				}
				
				vecCol.add(sel_specifica);
				if(rs1!=null)							
				{
					rs1.close();
				}
				
				vecCol.add(sel_specifica);
				//vecCatName.add(sel_actname);
				
				strQuery = SQLParser.getSqlQuery("sel_static_data_masterauc1^"+"287"+"^"+sel_specifica);
				rs1 = DBUtils.executeQuery(strQuery);
				
				if(rs1.next())
				{
					hshRecord.put("sel_specificadesc",Helper.correctNull((String)rs1.getString("stat_data_desc1")));
				}
				
				vecCol.add(sel_specifica);
				if(rs1!=null)							
				{
					rs1.close();
				}
					
				vecRow.add(vecCol);			
					
			}
			}
			
			hshRecord.put("vecRow",vecRow);
			hshRecord.put("svalue", FwHelper.correctNull((String)hshValues.get("svalue")));
			if(FwHelper.correctNull((String)hshValues.get("strfrom")).equalsIgnoreCase(""))
			{
			hshRecord.put("strfrom", FwHelper.correctNull((String)hshValues.get("strfrom")));
			}
			else
			{
				hshRecord.put("strfrom", FwHelper.correctNull((String)hshValues.get("stype")));
			}
			//hshRecord.put("scode", scode);
		
			hshRecord.put("stype", FwHelper.correctNull((String)hshValues.get("stype")));
	}
	catch(Exception ce)
	{
		throw new EJBException("Error in getActivitySpecificationbtdetails "+ce.toString());
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
 
}