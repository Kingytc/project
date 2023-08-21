package com.sai.laps.ejb.agrloanassessment;

import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.StringTokenizer;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.fw.management.utils.FwHelper;
import com.sai.laps.ejb.agrlandInvestment.agrlandInvestRemote;
import com.sai.laps.ejb.rules.AgrLandHoldingsBO;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.LAlerts;
import com.sai.laps.helper.SQLParser;


@Stateless(name = "AgriLoanAssessmentBean", mappedName = "AgriLoanAssessmentHome")
@Remote (AgriLoanAssessmentRemote.class)
public class AgriLoanAssessmentBean extends BeanAdapter {
	
	static Logger log=Logger.getLogger(AgriLoanAssessmentBean.class);	
	/**
	 *  Added By Sheik Agriculture Poultry Dairy Scheme
	 *  Date : 04-12-2013
	 */
	private static final long serialVersionUID = 1L;
	
	
	
	public HashMap updatepoultrytechdata(HashMap hshValues)  
	{ 		
		HashMap hshQueryValues = new HashMap();
		HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshQuery5 = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strAction = null;
		HashMap hshResult = new HashMap();
		
		String schemetype = correctNull((String)hshValues.get("schemetype"));	
		String strFacSno = FwHelper.correctNull((String)hshValues.get("hidFacSNo"));		
		

		HashMap hshScheme = new HashMap();
		hshScheme = Helper.splitScheme(schemetype);
		if(hshScheme!=null)
		{
			strFacSno = Helper.correctNull((String)hshScheme.get("facility_sno"));
			schemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
		}
			
		
		HashMap hshQuery4 = new HashMap();
		int intUpdatesize = 0;
		int f = 0;
		String strid = "", strQuery1 = "";
		String appno= FwHelper.correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = FwHelper.correctNull((String)hshValues.get("strappno"));
		}
		strAction = FwHelper.correctNull((String) hshValues.get("hidAction"));		
		String sel_farm= FwHelper.correctNull((String) hshValues.get("sel_farm"));
		if(sel_farm.equalsIgnoreCase(""))
		{
			sel_farm="0";	
		}
		else
		{
			sel_farm= FwHelper.correctNull((String) hshValues.get("sel_farm"));
		}
		String sel_electricity= FwHelper.correctNull((String) hshValues.get("sel_electricity"));
		if(sel_electricity.equalsIgnoreCase(""))
		{
			sel_electricity="0";	
		}
		else
		{
			sel_electricity= FwHelper.correctNull((String) hshValues.get("sel_electricity"));
		}
		String sel_shed= FwHelper.correctNull((String) hshValues.get("sel_shed"));
		
		if(sel_shed.equalsIgnoreCase(""))
		{
			sel_shed="0";	
		}
		else
		{
			sel_shed= FwHelper.correctNull((String) hshValues.get("sel_shed"));
		}
		String sel_rearing= FwHelper.correctNull((String) hshValues.get("sel_rearing"));
		if(sel_rearing.equalsIgnoreCase(""))
		{
			sel_rearing="0";	
		}
		else
		{
			sel_rearing= FwHelper.correctNull((String) hshValues.get("sel_rearing"));
		}
		String txt_distbranch = FwHelper.correctNull((String) hshValues.get("txt_distbranch"));
		String  txr_location= FwHelper.correctNull((String) hshValues.get("txr_location"));
		String  sel_mortorable= FwHelper.correctNull((String) hshValues.get("sel_mortorable"));
		String txt_environment= FwHelper.correctNull((String) hshValues.get("txt_environment"));
		String txt_aidloc= FwHelper.correctNull((String) hshValues.get("txt_aidloc"));
		String txt_distfarm = FwHelper.correctNull((String) hshValues.get("txt_distfarm"));
		String  sel_watersrc= FwHelper.correctNull((String) hshValues.get("sel_watersrc"));
		String  txt_waterloc= FwHelper.correctNull((String) hshValues.get("txt_waterloc"));
		String txr_electricity= FwHelper.correctNull((String) hshValues.get("txr_electricity"));
		String  txt_marketingegg= FwHelper.correctNull((String) hshValues.get("txt_marketingegg"));
		String txt_distegg= FwHelper.correctNull((String) hshValues.get("txt_distegg"));
		String txt_feed = FwHelper.correctNull((String) hshValues.get("txt_feed"));
		String  txt_distfeed= FwHelper.correctNull((String) hshValues.get("txt_distfeed"));
		String  txt_chicks= FwHelper.correctNull((String) hshValues.get("txt_chicks"));
		String txt_distchicks= FwHelper.correctNull((String) hshValues.get("txt_distchicks"));
		String txr_farm= FwHelper.correctNull((String) hshValues.get("txr_farm"));
		String txt_specify1= FwHelper.correctNull((String) hshValues.get("txt_specify1"));
		String  txt_specify2= FwHelper.correctNull((String) hshValues.get("txt_specify2"));
		String  txt_broodershed= FwHelper.correctNull((String) hshValues.get("txt_broodershed"));
		String txt_growershed= FwHelper.correctNull((String) hshValues.get("txt_growershed"));
		String  txt_bgshed= FwHelper.correctNull((String) hshValues.get("txt_bgshed"));
		String txt_layershed= FwHelper.correctNull((String) hshValues.get("txt_layershed"));
		String sel_ashed= FwHelper.correctNull((String) hshValues.get("sel_ashed"));
		String  txt_time= FwHelper.correctNull((String) hshValues.get("txt_time"));
		String txt_breed= FwHelper.correctNull((String) hshValues.get("txt_breed"));
		String txt_purchasedate= FwHelper.correctNull((String) hshValues.get("txt_purchasedate"));
		
		try 
		{
			String[] txt_syno = null;
			String[]txt_land = null;
			String[] txt_village= null;
			String[] txt_taluk= null;
			String[] sel_Units=null;
	
			txt_syno = (String[]) hshValues.get("txt_syno");
			txt_village= (String[]) hshValues.get("txt_village");
			txt_land = (String[]) hshValues.get("txt_land");
			strid = FwHelper.correctNull((String) hshValues.get("hid_sno"));
			txt_taluk= (String[]) hshValues.get("txt_taluk");
			sel_Units=((String[]) hshValues.get("sel_units"));
			String[] sel_District={FwHelper.correctNull((String) hshValues.get("txtperapp_district")),
					               FwHelper.correctNull((String) hshValues.get("txtperapp_permdistrict"))};
			
			if (strAction.equals("delete"))
			{
				hshQuery4 = new HashMap();
				HashMap hshQueryValues4 = new HashMap();
				ArrayList arrValues4 = new ArrayList();
				hshQueryValues4.put("size", "1");
				hshQuery4.put("strQueryId", "per_del_poultrytechdata");
				arrValues4.add(appno);
				arrValues4.add(schemetype);
				arrValues4.add(strFacSno);
				hshQuery4.put("arrValues", arrValues4);
				hshQueryValues4.put("1", hshQuery4);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
			
				hshQuery5 = new HashMap();
				HashMap hshQueryValues5 = new HashMap();
				ArrayList arrValues5 = new ArrayList();
				hshQueryValues5.put("size", "1");
				hshQuery5.put("strQueryId", "agr_del_poultrylanddata");
				arrValues5.add(appno);
				arrValues5.add(schemetype);
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
				arrValues.add(schemetype);
				arrValues.add(strFacSno);
				hshQuery.put("arrValues",arrValues);	
				hshQueryValues.put("1",hshQuery);
				
				hshQuery= new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(txt_distbranch);
				arrValues.add(sel_farm);
				arrValues.add(txr_location);
				arrValues.add(sel_mortorable);
				arrValues.add(txt_environment);
				arrValues.add(txt_aidloc);
				arrValues.add(txt_distfarm);
				arrValues.add(sel_watersrc);
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
				arrValues.add(sel_ashed);
				arrValues.add(txt_time);
			    arrValues.add(txt_breed);
			    arrValues.add(FwHelper.correctDouble((String) hshValues.get("txt_noofbirdsperbatch")));
			    arrValues.add(FwHelper.correctDouble((String) hshValues.get("txt_weeklyprodcap")));
			    arrValues.add(FwHelper.correctNull((String) hshValues.get("txt_sourceofeggs")));
			    arrValues.add(FwHelper.correctNull((String) hshValues.get("txt_marketingofchicks")));
			    arrValues.add(FwHelper.correctDouble((String) hshValues.get("txt_costofhatcheggs")));
			    arrValues.add(FwHelper.correctDouble((String) hshValues.get("txt_salepriceofdayold")));
			    arrValues.add(FwHelper.correctNull((String) hshValues.get("txt_breed_owned")));
			    arrValues.add(FwHelper.correctNull((String) hshValues.get("txt_noofunits_owned")));
			    arrValues.add(FwHelper.correctNull((String) hshValues.get("txt_noofunits_purchased")));			    
			    arrValues.add(schemetype);
			    arrValues.add(strFacSno);
			    arrValues.add(FwHelper.correctNull((String) hshValues.get("sel_poultry")));	
			    arrValues.add(txt_purchasedate);
			    
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
				arrValues3.add(schemetype);
				hshQuery3.put("arrValues", arrValues3);
				strQuery1 = SQLParser.getSqlQuery("sel_maxid_poultrylanddata");
				rs = DBUtils.executeQuery(strQuery1);
				if (rs.next())
				{
					strid = FwHelper.correctNull((String) rs.getString("maxid"));
					f = Integer.parseInt(strid);
				}
				if(rs!=null){
					rs.close();
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
					if (FwHelper.correctNull( txt_syno[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(FwHelper.correctNull(txt_syno[i]));
					}
					if (FwHelper.correctNull(txt_land[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(FwHelper.correctNull(txt_land[i]));
					}
					if (FwHelper.correctNull(txt_village[i]).equals("")) 
					{
						arrValues.add("");
					}
					else 
					{
						arrValues.add(FwHelper.correctNull(txt_village[i]));
					}
					if (FwHelper.correctNull(txt_taluk[i]).equals(""))
					{
						arrValues.add("");
					} 
					else
					{
						arrValues.add(FwHelper.correctNull(txt_taluk[i]));
					}
					
				   arrValues.add(schemetype);
				   arrValues.add(strFacSno);
				   if (FwHelper.correctNull(sel_Units[i]).equals(""))
					{
						arrValues.add("0");
					} 
					else
					{
						arrValues.add(FwHelper.correctNull(sel_Units[i]));
					}
				   if (FwHelper.correctNull(sel_District[i]).equals(""))
					{
						arrValues.add("");
					} 
					else
					{
						arrValues.add(FwHelper.correctNull(sel_District[i]));
					}
				   
					hshQuery.put("arrValues", arrValues);
					f = f + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);					
				}
				hshQueryValues.put("1", hshQuery3);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
									
			hshpasValues.put("schemetype",schemetype);
			hshpasValues.put("appno", appno);
			//hshResult = getpoultrytechdata(hshpasValues);
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
	
	public HashMap getpoultrytechdata(HashMap hshValues)  
	{
		String strQuery = "",strFacSno="";
		ResultSet rs = null;
		ResultSet rs1 = null;		
		HashMap hshRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		String prd_type = FwHelper.correctNull((String)hshValues.get("strProductType"));
		        
		try 
		{		
			if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
			{
				prd_type = FwHelper.correctNull((String)hshValues.get("schemetype"));
			}
			
			HashMap hshScheme = new HashMap();
			hshScheme = Helper.splitScheme(prd_type);
			if(hshScheme!=null)
			{
				strFacSno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				prd_type = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			
			
			ArrayList arryCol = null;
			String appno= FwHelper.correctNull((String)hshValues.get("appno"));
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = FwHelper.correctNull((String)hshValues.get("strappno"));
			}
			
	        String PageType=FwHelper.correctNull((String)hshValues.get("hidpagetype1"));
	        if(PageType.equalsIgnoreCase(""))
	        {
	        	 PageType=FwHelper.correctNull((String)hshValues.get("hidpagetype"));
	        }
	        
			strQuery = SQLParser.getSqlQuery("sel_agr_poultrytechdata^"+appno+ "^" +prd_type+"^"+strFacSno);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) 
			{
				hshRecord.put("txt_distbranch", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_distbranch"))));
				hshRecord.put("sel_farm", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_farm"))));
				hshRecord.put("txr_location", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_location"))));
				hshRecord.put("txt_mortorable", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_mortorable"))));
				hshRecord.put("txt_environment", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_environment"))));
				hshRecord.put("txt_aidloc", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_aidloc"))));
				hshRecord.put("txt_distfarm", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_distfarm"))));
				hshRecord.put("txt_watersrc", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_watersrc"))));
				hshRecord.put("txt_waterloc", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_waterloc"))));
				hshRecord.put("sel_electricity", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_electricity"))));
				hshRecord.put("txr_electricity", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_electricityspec"))));
				hshRecord.put("txt_marketingegg", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_marketingegg"))));
				hshRecord.put("txt_distegg", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_distegg"))));
				hshRecord.put("txt_feed", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_feed"))));
				hshRecord.put("txt_distfeed", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_distfeed"))));
				hshRecord.put("txt_chicks", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_chicks"))));
				hshRecord.put("txt_distchicks", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_distchicks"))));
				hshRecord.put("txr_farm", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_farmspec"))));
				hshRecord.put("sel_shed", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_shed"))));
				hshRecord.put("txt_specify1", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_specify1"))));
				hshRecord.put("sel_rearing", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_rearing"))));
				hshRecord.put("txt_specify2", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_specify2"))));
				hshRecord.put("txt_broodershed", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_broodershed"))));
				hshRecord.put("txt_growershed", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_growershed"))));
				hshRecord.put("txt_bgshed", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_bgshed"))));
				hshRecord.put("txt_layershed", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_layershed"))));
				hshRecord.put("sel_ashed", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_ashed"))));
				hshRecord.put("txt_time", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_time"))));
				hshRecord.put("txt_breed", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_breed"))));
				hshRecord.put("txt_noofbirdsperbatch", FwHelper.correctDouble(FwHelper.correctNull(rs1.getString("POULTRY_NOOFBIRDSPERBATCH"))));
				hshRecord.put("txt_weeklyprodcap", FwHelper.correctDouble(FwHelper.correctNull(rs1.getString("POULTRY_WEEKLYPRODCAPACITY"))));
				hshRecord.put("txt_sourceofeggs", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("POULTRY_SOURCEOFEGGS"))));
				hshRecord.put("txt_marketingofchicks", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("POULTRY_MARKETINGOFCHICKS"))));
				hshRecord.put("txt_costofhatchableeggs", FwHelper.correctDouble(FwHelper.correctNull(rs1.getString("POULTRY_COSTOFHATCHABLEEGG"))));
				hshRecord.put("txt_salepriceofdayoldchick", FwHelper.correctDouble(FwHelper.correctNull(rs1.getString("POULTRY_SALEPRICEOFDAYOLDCHICK"))));
				hshRecord.put("txt_breed_owned", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_breedowned"))));
				hshRecord.put("txt_noofunits_owned", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_noofunitsowned"))));
				hshRecord.put("txt_noofunits_purchased", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_noofunitspurchased"))));
				hshRecord.put("poultry_poultrytype", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_poultrytype"))));
				hshRecord.put("poultry_purchasedate", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_purchasedate"))));
					
			}
			
			if (rs1 != null){
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
				arryCol.add(rs.getString("poultry_units"));
				arryCol.add(rs.getString("poultry_district"));
				arryRow.add(arryCol);
			}
			if(rs!=null){
				rs.close();
			}
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("PageType", PageType);
			
			
			strQuery = SQLParser.getSqlQuery("sel_agrbroiselflockrep^" + appno+ "^" + prd_type+"^"+strFacSno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshRecord.put("strPolutryFlag", "Y");
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

	
	public HashMap updatepoultrybroilerfindata(HashMap hshValues)  
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		HashMap hshQuery3 = new HashMap();
		ArrayList arrValues3 = new ArrayList();
		String strAction = null;
		HashMap hshResult = new HashMap();
		int intUpdatesize = 0;
		int intUpdatesize2=0;
		
		String prd_type = FwHelper.correctNull((String)hshValues.get("strProductType"));
		String strFacSno = FwHelper.correctNull((String)hshValues.get("hidFacSNo"));
		
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = FwHelper.correctNull((String)hshValues.get("schemetype"));
		}
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = FwHelper.correctNull((String)hshValues.get("prd_type"));
		}
		
		HashMap hshScheme = new HashMap();
		hshScheme = Helper.splitScheme(prd_type);
		if(hshScheme!=null)
		{
			strFacSno = Helper.correctNull((String)hshScheme.get("facility_sno"));
			prd_type = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
		}
		
		String appno= FwHelper.correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = FwHelper.correctNull((String)hshValues.get("strappno"));
		}
		strAction = FwHelper.correctNull((String) hshValues.get("hidAction"));		
		String txt_nochicks = FwHelper.correctNull((String) hshValues.get("txt_nochicks"));
		String  txt_costchicks= FwHelper.correctNull((String) hshValues.get("txt_costchicks"));
		String  txt_totalcostchicks= FwHelper.correctNull((String) hshValues.get("txt_totalcostchicks"));
		String  txt_costchickmash= FwHelper.correctNull((String) hshValues.get("txt_costchickmash"));
		String txt_conchickmash= FwHelper.correctNull((String) hshValues.get("txt_conchickmash"));
		String  txt_totalchickmash= FwHelper.correctNull((String) hshValues.get("txt_totalchickmash"));
		String txt_costgrowermash= FwHelper.correctNull((String) hshValues.get("txt_costgrowermash"));
		String txt_congrowermash = FwHelper.correctNull((String) hshValues.get("txt_congrowermash"));
		String  txt_totalgrowermash= FwHelper.correctNull((String) hshValues.get("txt_totalgrowermash"));
		String txt_costGrowermash= FwHelper.correctNull((String) hshValues.get("txt_costGrowermash"));
		String txt_conGrowermash = FwHelper.correctNull((String) hshValues.get("txt_conGrowermash"));
		String  txt_totalGrowermash= FwHelper.correctNull((String) hshValues.get("txt_totalGrowermash"));
		String txt_totalfeedcon= FwHelper.correctNull((String) hshValues.get("txt_totalfeedcon"));
		String txt_totalfeedcost = FwHelper.correctNull((String) hshValues.get("txt_totalfeedcost"));
		String  txt_broodingchicks= FwHelper.correctNull((String) hshValues.get("txt_broodingchicks"));
		String  txt_broodingmor= FwHelper.correctNull((String) hshValues.get("txt_broodingmor"));
		String txt_specify1= FwHelper.correctNull((String) hshValues.get("txt_specify1"));
		String txt_specify2= FwHelper.correctNull((String) hshValues.get("txt_specify2"));
		String  txt_electricitycharge= FwHelper.correctNull((String) hshValues.get("txt_electricitycharge"));
		if(txt_electricitycharge.equalsIgnoreCase(""))
		{
			txt_electricitycharge="0";	
		}
		else{
			txt_electricitycharge= FwHelper.correctNull((String) hshValues.get("txt_electricitycharge"));
		}
		
		String  txt_watercharge= FwHelper.correctNull((String) hshValues.get("txt_watercharge"));
		if(txt_watercharge.equalsIgnoreCase(""))
		{
			txt_watercharge="0";	
		}
		else{
			txt_watercharge= FwHelper.correctNull((String) hshValues.get("txt_watercharge"));
		}
		String txt_vtaid= FwHelper.correctNull((String) hshValues.get("txt_vtaid"));
		if(txt_vtaid.equalsIgnoreCase(""))
		{
			txt_vtaid="0";	
		}
		else{
			txt_vtaid= FwHelper.correctNull((String) hshValues.get("txt_vtaid"));
		}
		String txt_inspremium= FwHelper.correctNull((String) hshValues.get("txt_inspremium"));
		if(txt_inspremium.equalsIgnoreCase(""))
		{
			txt_inspremium="0";	
		}
		else{
			txt_inspremium= FwHelper.correctNull((String) hshValues.get("txt_inspremium"));
		}
		String  txt_yieldegg= FwHelper.correctNull((String) hshValues.get("txt_yieldegg"));
		String txt_yieldmanure= FwHelper.correctNull((String) hshValues.get("txt_yieldmanure"));
		String txt_salemanure= FwHelper.correctNull((String) hshValues.get("txt_salemanure"));
		if(txt_salemanure.equalsIgnoreCase(""))
		{
			txt_salemanure="0";	
		}
		else{
			txt_salemanure= FwHelper.correctNull((String) hshValues.get("txt_salemanure"));
		}
		
		String txt_totsalemanure= FwHelper.correctNull((String) hshValues.get("txt_totsalemanure"));
		
		String  txt_salegunny= FwHelper.correctNull((String) hshValues.get("txt_salegunny"));
		String txt_emptybag= FwHelper.correctNull((String) hshValues.get("txt_emptybag"));
		String txt_transportcharge= FwHelper.correctNull((String) hshValues.get("txt_transportcharge"));
		if(txt_transportcharge.equalsIgnoreCase(""))
		{
			txt_transportcharge="0";	
		}
		else{
			txt_transportcharge= FwHelper.correctNull((String) hshValues.get("txt_transportcharge"));
		}
	    String txt_totalvtaid= FwHelper.correctNull((String) hshValues.get("txt_totalvtaid"));
		String  txt_totalinspremium= FwHelper.correctNull((String) hshValues.get("txt_totalinspremium"));
		String txt_totsaleegg= FwHelper.correctNull((String) hshValues.get("txt_totsaleegg"));
		String txt_totsalebag= FwHelper.correctNull((String) hshValues.get("txt_totsalebag"));
		String strtxt_numberbatch= FwHelper.correctNull((String) hshValues.get("txt_numberbatch")); //added by gaensan 
		
		String[] txt_noperson = null;
		String[]txt_salarypm = null;
		
		String[] txt_exp = null;
		String[]txt_iyear= null;
		String[]txt_iiyear= null;
		String[]txt_iiiyear= null;
		String[]txt_ivyear= null;
		String[]txt_vyear= null;
		
		String[] txt_src = null;
		String[]txt_iyearsrc= null;
		String[]txt_iiyearsrc= null;
		String[]txt_iiiyearsrc= null;
		String[]txt_ivyearsrc= null;
		String[]txt_vyearsrc= null;
		
		String[] txt_item1 = null;
		String[]txt_unit= null;
		String[]txt_cost= null;
		String[] txt_specification = null;
		
		String[]txt_iyearegg= null;
		String[]txt_iiyearegg= null;
		String[]txt_iiiyearegg= null;
		String[]txt_ivyearegg= null;
		String[]txt_vyearegg= null;
		
		//
		String txt_eggperbatch = FwHelper.correctDouble((String) hshValues.get("txt_eggperbatch"));
		String txt_salepriceperegg = FwHelper.correctDouble((String) hshValues.get("txt_salepriceperegg"));
		String txt_eggrealisation = FwHelper.correctDouble((String) hshValues.get("txt_eggrealisation"));
		
		try 
		{
			txt_noperson = (String[]) hshValues.get("txt_noperson");
			txt_salarypm= (String[]) hshValues.get("txt_salarypm");
			txt_exp = (String[]) hshValues.get("txt_exp");
			txt_iyear= (String[]) hshValues.get("txt_iyear");
			txt_iiyear= (String[]) hshValues.get("txt_iiyear");
			txt_iiiyear= (String[]) hshValues.get("txt_iiiyear");
			txt_ivyear= (String[]) hshValues.get("txt_ivyear");
			txt_vyear= (String[]) hshValues.get("txt_vyear");
			txt_src = (String[]) hshValues.get("txt_src");
			txt_iyearsrc= (String[]) hshValues.get("txt_iyearsrc");
			txt_iiyearsrc= (String[]) hshValues.get("txt_iiyearsrc");
			txt_iiiyearsrc= (String[]) hshValues.get("txt_iiiyearsrc");
			txt_ivyearsrc= (String[]) hshValues.get("txt_ivyearsrc");
			txt_vyearsrc= (String[]) hshValues.get("txt_vyearsrc");
			
			txt_iyearegg= (String[]) hshValues.get("txt_iyearegg");
			txt_iiyearegg= (String[]) hshValues.get("txt_iiyearegg");
			txt_iiiyearegg= (String[]) hshValues.get("txt_iiiyearegg");
			txt_ivyearegg= (String[]) hshValues.get("txt_ivyearegg");
			txt_vyearegg= (String[]) hshValues.get("txt_vyearegg");
			
			txt_item1 = (String[]) hshValues.get("sel_equipmentname");//changed
			txt_unit = (String[])hshValues.get("txt_unit");
			txt_cost= (String[])hshValues.get("txt_cost");
			txt_specification = (String[])hshValues.get("txt_item1");//newly added
						
			if (strAction.equals("delete"))
			{
				
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(appno);
				arrValues.add(prd_type);
				arrValues.add(strFacSno);
				hshQuery.put("strQueryId","per_del_poultrybroifindata");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				
				arrValues.add(appno);
				arrValues.add(prd_type);
				arrValues.add(strFacSno);
				hshQuery.put("strQueryId", "agr_del_poultryfinperdata");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
			
				arrValues.add(appno);
				arrValues.add(prd_type);
				arrValues.add(strFacSno);
				hshQuery.put("strQueryId", "del_poultry_expenses");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				
				arrValues.add(appno);
				arrValues.add(prd_type);
				arrValues.add(strFacSno);
				hshQuery.put("strQueryId", "del_poultry_non_recurring");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQuery= new HashMap();
				intUpdatesize++;
				hshQuery.put("strQueryId", "per_del_poultrybroifindata");
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(prd_type);
				arrValues.add(strFacSno);
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
				arrValues.add(txt_totalfeedcost);//Feeding Expenses tottal
				arrValues.add(txt_broodingmor);
				arrValues.add(txt_broodingchicks);
				arrValues.add(txt_specify1);
				arrValues.add(txt_specify2);
				arrValues.add(txt_electricitycharge);
				arrValues.add(txt_watercharge);
				arrValues.add(txt_vtaid);
				arrValues.add(txt_inspremium);
				arrValues.add(txt_yieldegg);
				arrValues.add(txt_totsaleegg);//22
				arrValues.add(txt_yieldmanure);
				arrValues.add(txt_salemanure);
				arrValues.add(txt_salegunny);
				arrValues.add(txt_emptybag);
				arrValues.add(txt_transportcharge);
			    arrValues.add(txt_totalvtaid);
				
				arrValues.add(txt_totalinspremium);
				arrValues.add(txt_totsalemanure);
				arrValues.add(txt_totsalebag);
				arrValues.add(txt_eggperbatch);
				arrValues.add(txt_salepriceperegg);
				arrValues.add(txt_eggrealisation);
				arrValues.add(prd_type);
				arrValues.add(txt_costGrowermash);
				arrValues.add(txt_conGrowermash);
				arrValues.add(txt_totalGrowermash);
				arrValues.add(strFacSno);
				arrValues.add(strtxt_numberbatch); //added by gaensan Total Number of Batch
				
				
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agr_ins_poultrybroifindata");
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				
			
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				
				hshQuery.put("strQueryId", "agr_del_poultryfinperdata");
				arrValues.add(appno);
				arrValues.add(prd_type);
				arrValues.add(strFacSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				

				for (int i = 0; i < txt_noperson.length; i++)
				{					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;//intUpdatesize = intUpdatesize + 1;
					
					arrValues.add(appno);
					arrValues.add(new Integer(i + 1).toString());
					arrValues.add(FwHelper.correctNull(txt_noperson[i]));
					arrValues.add(FwHelper.correctNull(txt_salarypm[i]));
					arrValues.add(prd_type);
				   	arrValues.add("");
				   	arrValues.add(strFacSno);
					hshQuery.put("strQueryId", "per_ins_poultryfinperdata");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}
				hshQueryValues.put("size", ""+intUpdatesize);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
			}
			if (strAction.equals("insert"))
    		{
				hshQueryValues =new HashMap();
    			hshQuery3 = new HashMap();
    			arrValues3 = new ArrayList();
    			hshQuery3.put("size", "1");
    			hshQuery3.put("strQueryId", "del_poultry_expenses");
    			arrValues3.add(appno);
    			arrValues3.add(prd_type);
    			arrValues3.add(strFacSno);
    			hshQuery3.put("arrValues", arrValues3);
    			hshQueryValues.put("1", hshQuery3);
    			hshQueryValues.put("size", "1");
    			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
    			
    			intUpdatesize2 = 1;
    			
    			for (int j = 0; j<5; j++)
    			{
    				/*if(txt_exp[j].equalsIgnoreCase(""))
    					continue;*/
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
    				arrValues.add(txt_ivyear!=null ? txt_ivyear[j]:"");
    				arrValues.add(txt_vyear!=null ? txt_vyear[j]:"");
    				arrValues.add("E");
    				arrValues.add(prd_type);
    				arrValues.add(""+(j));
    				if(j<3)
    				{
    				if(txt_iyearegg[j].equalsIgnoreCase(""))
					{
						txt_iyearegg[j] = "0";
					}
					arrValues.add(txt_iyearegg[j]);
					if(txt_iiyearegg[j].equalsIgnoreCase(""))
					{
						txt_iiyearegg[j] = "0";
					}
					arrValues.add(txt_iiyearegg[j]);
					if(txt_iiiyearegg[j].equalsIgnoreCase(""))
					{
						txt_iiiyearegg[j] = "0";
					}
					arrValues.add(txt_iiiyearegg[j]);
					if(txt_ivyearegg[j].equalsIgnoreCase(""))
					{
						txt_ivyearegg[j] = "0";
					}
					arrValues.add(txt_ivyearegg[j]);
					if(txt_vyearegg[j].equalsIgnoreCase(""))
					{
						txt_vyearegg[j] = "0";
					}
					arrValues.add(txt_vyearegg[j]);
    				}
    				else{
    					arrValues.add("0");
    					arrValues.add("0");
    					arrValues.add("0");
    					arrValues.add("0");
    					arrValues.add("0");
    				}
    				arrValues.add(strFacSno);
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
    					if(txt_ivyearsrc[l].equalsIgnoreCase(""))
    					{
    						txt_ivyearsrc[l] = "0";
    					}
    					arrValues.add(txt_ivyearsrc[l]);
    					if(txt_vyearsrc[l].equalsIgnoreCase(""))
    					{
    						txt_vyearsrc[l] = "0";
    					}
    					arrValues.add(txt_vyearsrc[l]);
    					
    					arrValues.add("S");
    					arrValues.add(prd_type);
    					arrValues.add(""+(l+1));
    					
    					if(txt_iyearegg[l].equalsIgnoreCase(""))
    					{
    						txt_iyearegg[l] = "0";
    					}
    					arrValues.add(txt_iyearegg[l]);
    					if(txt_iiyearegg[l].equalsIgnoreCase(""))
    					{
    						txt_iiyearegg[l] = "0";
    					}
    					arrValues.add(txt_iiyearegg[l]);
    					if(txt_iiiyearegg[l].equalsIgnoreCase(""))
    					{
    						txt_iiiyearegg[l] = "0";
    					}
    					arrValues.add(txt_iiiyearegg[l]);
    					if(txt_ivyearegg[l].equalsIgnoreCase(""))
    					{
    						txt_ivyearegg[l] = "0";
    					}
    					arrValues.add(txt_ivyearegg[l]);
    					if(txt_vyearegg[l].equalsIgnoreCase(""))
    					{
    						txt_vyearegg[l] = "0";
    					}
    					arrValues.add(txt_vyearegg[l]);
    					arrValues.add(strFacSno);
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
    			arrValues3.add(strFacSno);
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
    				
    				if(txt_item1[i].equalsIgnoreCase(""))
    				{
    					txt_item1[i] = "";
    				}
    				arrValues.add(txt_item1[i]);
    				
    				if(txt_specification[i].equalsIgnoreCase(""))
    				{
    					txt_specification[i] = "";
    				}
    				arrValues.add(txt_specification[i]);
    				
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
    				arrValues.add(strFacSno);
    			    hshQuery.put("arrValues", arrValues);	
    				hshQueryValues.put("1", hshQuery);
    				hshQueryValues.put("size", "1");
    				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
    			}
    		
    		}
								
			hshpasValues.put("prd_type",prd_type);
			hshpasValues.put("appno", appno);
			//hshResult = getpoultrybroilerfindata(hshpasValues);
		}
		catch (Exception e)
		{	
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} 
		
		return hshResult;
	}
	
	public HashMap getpoultrybroilerfindata(HashMap hshValues)  
	{
		String strQuery = "",strfacsno="",strQuery1="";
		ResultSet rs = null;
		ResultSet rs1 = null;		
		HashMap hshRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryRowEgg = new ArrayList();
		ArrayList arryCol = null;
		ArrayList arryColEgg = null;
		ArrayList arryRow1 = new ArrayList();
		ArrayList arryRowEgg1 = new ArrayList();
		ArrayList arryCol11= new ArrayList();
		ArrayList  arryRow11= new ArrayList();
		ArrayList arryCol1 = null;
		ArrayList arryColEgg1 = null;
		String strsel_poultry=null;
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		double dbl_TotStartermash=0.00;
		
		String prd_type = FwHelper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = FwHelper.correctNull((String)hshValues.get("schemetype"));
			strfacsno = FwHelper.correctNull((String)hshValues.get("schemetype"));
		}
		

		HashMap hshScheme = new HashMap();
		hshScheme = Helper.splitScheme(prd_type);
		if(hshScheme!=null)
		{
			strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
			prd_type = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
		}
					
		String appno= FwHelper.correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = FwHelper.correctNull((String)hshValues.get("strappno"));
		}
	   
		String PageType=FwHelper.correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
        {
        	 PageType=FwHelper.correctNull((String)hshValues.get("hidpagetype"));
        }
        
		try 
		{
			if(rs!=null){
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("agr_get_poultrytechdata^"+appno+ "^" +prd_type);
			strQuery=strQuery+strQuery1;
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				 strsel_poultry=FwHelper.correctNull(rs.getString("poultry_poultrytype"));
				hshRecord.put("poultry_poultrytype", FwHelper.correctNull(rs.getString("poultry_poultrytype")));
			}
			
			
			if(rs!=null){
				rs.close();
			}
			
			
			if(!strsel_poultry.equalsIgnoreCase(""))
				
			{
			
			strQuery = SQLParser.getSqlQuery("sel_Typepoultrymasters^"+strsel_poultry);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("poultry_Startermash",jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("poultry_Startermash")))));
				hshRecord.put("poultry_Growermash",jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("poultry_Growermash")))));
				hshRecord.put("poultry_Finishermash",jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("poultry_Finishermash")))));
				hshRecord.put("poultry_Mortality",jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("poultry_Mortality")))));
				dbl_TotStartermash=Double.parseDouble(Helper.correctDouble(rs.getString("poultry_Startermash")))+
				Double.parseDouble(Helper.correctDouble(rs.getString("poultry_Growermash")))+
				Double.parseDouble(Helper.correctDouble(rs.getString("poultry_Finishermash")));
				hshRecord.put("Feeding_tot",jtn.format(dbl_TotStartermash));
				
			}	
			}
			
			strQuery1="and AGR_FACSNO="+strfacsno;
			strQuery = SQLParser.getSqlQuery("agr_get_poultrybroifindata^"+appno+ "^" +prd_type);
			strQuery=strQuery+strQuery1;
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) 
			{
				hshRecord.put("txt_nochicks", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_nochicks"))));
				hshRecord.put("txt_costchicks", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_costchicks"))));
				hshRecord.put("txt_totalcostchicks", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totalcostchicks"))));
				hshRecord.put("txt_costchickmash", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_costchickmash"))));
				hshRecord.put("txt_conchickmash", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_conchickmash"))));
				hshRecord.put("txt_totalchickmash", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totalchickmash"))));
				hshRecord.put("txt_costgrowermash", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_costgrowermash"))));
				hshRecord.put("txt_congrowermash", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_congrowermash"))));
				hshRecord.put("txt_totalgrowermash", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totalgrowermash"))));

				hshRecord.put("txt_costGrowermash", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_costgrower"))));
				hshRecord.put("txt_conGrowermash", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_congrower"))));
				hshRecord.put("txt_totalGrowermash", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totalgrower"))));
				
				hshRecord.put("txt_totalfeedcon", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totalfeedcon"))));
				hshRecord.put("txt_totalfeedcost", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totalfeedcost"))));
				hshRecord.put("poultry_Mortality", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_broodingmor"))));
				hshRecord.put("txt_broodingchicks", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_broodingchicks"))));
				hshRecord.put("txt_specify1", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_specify1"))));
				hshRecord.put("txt_specify2", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_specify2"))));
				hshRecord.put("txt_electricitycharge", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_electricitycharge"))));
				hshRecord.put("txt_watercharge", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_watercharge"))));
				hshRecord.put("txt_vtaid", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_vtaid"))));
				hshRecord.put("txt_inspremium", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_inspremium"))));
				hshRecord.put("txt_yieldegg", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_yieldegg"))));
				hshRecord.put("txt_totsaleegg", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totsaleegg"))));
				hshRecord.put("txt_yieldmanure", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_yieldmanure"))));
				hshRecord.put("txt_salemanure", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_salemanure"))));
				hshRecord.put("txt_salegunny", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_salegunny"))));
				hshRecord.put("txt_emptybag", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_emptybag"))));
				hshRecord.put("txt_transportcharge", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_transportcharge"))));
				hshRecord.put("txt_totalvtaid", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totalvtaid"))));
				hshRecord.put("txt_totalinspremium", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totalinspremium"))));
				hshRecord.put("txt_totsalemanure", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totsalemanure"))));
				hshRecord.put("txt_totsalebag", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totsalebag"))));
				hshRecord.put("poultry_eggperbatach", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_eggperbatach"))));
				hshRecord.put("poultry_eggsaleprice", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_eggsaleprice"))));
				hshRecord.put("poultry_eggrealisationvalue", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_eggrealisationvalue"))));
				hshRecord.put("poultry_totnobatch", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totnobatch"))));
				
				hshRecord.put("poultry_Startermash",jtn.format(Double.parseDouble(Helper.correctDouble(rs1.getString("poultry_totalchickmash")))));
				hshRecord.put("poultry_Growermash",jtn.format(Double.parseDouble(Helper.correctDouble(rs1.getString("poultry_totalgrower")))));
				hshRecord.put("poultry_Finishermash",jtn.format(Double.parseDouble(Helper.correctDouble(rs1.getString("poultry_totalgrowermash")))));
				hshRecord.put("Feeding_tot",jtn.format(Double.parseDouble(Helper.correctDouble(rs1.getString("poultry_totalfeedcost")))));
			}
			if(rs1!=null){
				rs1.close();
			}
						 							 
			strQuery = SQLParser.getSqlQuery("per_get_poultryfinperdata_facno^" + appno+ "^" +prd_type+"^"+strfacsno);
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
			if(rs!=null){
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_poultry_exp_facno^" + appno+ "^" +prd_type+"^E"+"^"+strfacsno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol1 = new ArrayList();
				arryColEgg= new ArrayList();
				arryCol1.add(rs.getString("poultry_expenses"));
				arryCol1.add(rs.getString("poultry_iyear"));
				arryCol1.add(rs.getString("poultry_iiyear"));
				arryCol1.add(rs.getString("poultry_iiiyear"));
				arryCol1.add(rs.getString("poultry_type"));
				arryCol1.add(rs.getString("poultry_ivyear"));
				arryCol1.add(rs.getString("poultry_vyear"));
				
				arryColEgg.add(rs.getString("poultry_iyearegg"));
				arryColEgg.add(rs.getString("poultry_iiyearegg"));
				arryColEgg.add(rs.getString("poultry_iiiyearegg"));
				arryColEgg.add(rs.getString("poultry_ivyearegg"));
				arryColEgg.add(rs.getString("poultry_vyearegg"));
				arryRow1.add(arryCol1);
				arryRowEgg.add(arryColEgg);
				
			}
			if(rs!=null){
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_poultry_inc_facno^" + appno+ "^" +prd_type+"^S"+"^"+strfacsno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol11 = new ArrayList();
				arryColEgg1= new ArrayList();
				arryCol11.add(rs.getString("poultry_expenses"));
				arryCol11.add(rs.getString("poultry_iyear"));
				arryCol11.add(rs.getString("poultry_iiyear"));
				arryCol11.add(rs.getString("poultry_iiiyear"));
				arryCol11.add(rs.getString("poultry_type"));
				arryCol11.add(rs.getString("poultry_ivyear"));
				arryCol11.add(rs.getString("poultry_vyear"));
				
				arryColEgg1.add(rs.getString("poultry_iyearegg"));
				arryColEgg1.add(rs.getString("poultry_iiyearegg"));
				arryColEgg1.add(rs.getString("poultry_iiiyearegg"));
				arryColEgg1.add(rs.getString("poultry_ivyearegg"));
				arryColEgg1.add(rs.getString("poultry_vyearegg"));
				arryRow11.add(arryCol11);
				arryRowEgg1.add(arryColEgg1);
			}
			if(rs!=null){
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("sel_poultry_non_recurring^" + appno+"^"+prd_type);
			strQuery=strQuery+strQuery1;
			rs = DBUtils.executeQuery(strQuery);
			ArrayList arryCol2 = new ArrayList();
			ArrayList arryRow2 = new ArrayList();
			while (rs.next())
			{
				arryCol2 = new ArrayList();
				arryCol2.add(appno);
				arryCol2.add(rs.getString("poultry_item"));			
				arryCol2.add(rs.getString("poultry_specification"));//newly added
				arryCol2.add(rs.getString("poultry_unit"));
				arryCol2.add(rs.getString("poultry_cost"));
				arryCol2.add(rs.getString("poultry_loan_amount"));
				arryRow2.add(arryCol2);
			}
			
			strQuery = SQLParser.getSqlQuery("sel_agrbroiselflockrep^" + appno+ "^" + prd_type+"^"+strfacsno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshRecord.put("strPolutryFlag", "Y");
			}
			
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("arryRow1", arryRow1);
			hshRecord.put("arryRow11",arryRow11);
			hshRecord.put("arryRow2", arryRow2);
			hshRecord.put("PageType", PageType);
			hshRecord.put("arryRowEgg", arryRowEgg);
			hshRecord.put("arryRowEgg1", arryRowEgg1);
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
			catch (Exception e){
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}
	
	
	//Added By Amaravathi for Poultry-Non-RecData
	public void updatebroinonrecurringData(HashMap hshRequestValues) 
	{
		String appno= FwHelper.correctNull((String)hshRequestValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno= FwHelper.correctNull((String)hshRequestValues.get("strappno"));
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
		String[] txt_equipmentname= null;		
		String schemetype = FwHelper.correctNull((String)hshRequestValues.get("strProductType"));
		
		if(schemetype.equalsIgnoreCase("null") || schemetype.equalsIgnoreCase(""))
		{
			schemetype = FwHelper.correctNull((String)hshRequestValues.get("schemetype"));
		}
		String strFacSno = FwHelper.correctNull((String)hshRequestValues.get("hidFacSNo"));
		

		HashMap hshScheme = new HashMap();
		hshScheme = Helper.splitScheme(schemetype);
		if(hshScheme!=null)
		{
			strFacSno = Helper.correctNull((String)hshScheme.get("facility_sno"));
			schemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
		}
					
					
		String strAction = FwHelper.correctNull((String)hshRequestValues.get("hidAction"));
		String txt_totalloanamount= FwHelper.correctNull((String)hshRequestValues.get("txt_totalloanamount"));
		int intUpdatesize = 0;
		try
		{		
			txt_sq = (String[])hshRequestValues.get("txt_sq");
			txt_value = (String[])hshRequestValues.get("txt_value");
			txt_specify= (String[])hshRequestValues.get("txt_specify");
			txt_unit= (String[])hshRequestValues.get("txt_unit");
			txt_cost = (String[])hshRequestValues.get("txt_cost");
			txt_loanamount = (String[])hshRequestValues.get("txt_loanamount");
			txt_equipmentname=(String[])hshRequestValues.get("txt_equipmentname");
			int intUpdatesize1=0;
			if (strAction.equals("insert"))
    		{
				   			
    			
    		    hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_poultry_broinonrecurring");
				arrValues.add(appno);
				arrValues.add(schemetype);
				arrValues.add(strFacSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
    			
    			intUpdatesize = 1;
    			for (int i =0; i <=9; i++)
    			{
    				hshQueryValues = new HashMap();
    				intUpdatesize = intUpdatesize + 1;
    				hshQuery = new HashMap();
    				arrValues = new ArrayList();
    				hshQuery.put("strQueryId", "ins_poultry_broinonrecurring");
    				arrValues.add(appno);
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
    				arrValues.add(schemetype);
    				arrValues.add(strFacSno);
    				
    				if(txt_equipmentname[i].equalsIgnoreCase(""))
    				{
    					txt_equipmentname[i] = "";
    				}
    				arrValues.add(txt_equipmentname[i]);
    				hshQuery.put("arrValues", arrValues);	
    				hshQueryValues.put("1", hshQuery);
    				hshQueryValues.put("size", "1");
    				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
    			}
    		}
         
			if(strAction.equalsIgnoreCase("delete"))
			{
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_poultry_broinonrecurring");
				arrValues.add(appno);
				arrValues.add(schemetype);
				arrValues.add(strFacSno);
				hshQuery.put("arrValues",arrValues);	
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				   
				
			}
									
		}		
		catch(Exception ce)
		{	
			throw new EJBException("inside update"+ce.toString());
		}
	}
	
	public HashMap getbroinonrecurringData(HashMap hshValues)  
	{
		String strQuery = "",strfacsno="";
		ResultSet rs = null;	
		HashMap hshRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		ArrayList arryRow1 = new ArrayList();
		ArrayList arryCol1 = null;
		double dbl_TotalNonrecExp=0.00;   
		String prd_type = FwHelper.correctNull((String)hshValues.get("strProductType"));
		
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = FwHelper.correctNull((String)hshValues.get("schemetype"));
		}
		

		HashMap hshScheme = new HashMap();
		hshScheme = Helper.splitScheme(prd_type);
		if(hshScheme!=null)
		{
			strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
			prd_type = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
		}
		
		String appno= FwHelper.correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = FwHelper.correctNull((String)hshValues.get("strappno"));
		}
	    
		String PageType=FwHelper.correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
        {
        	 PageType=FwHelper.correctNull((String)hshValues.get("hidpagetype"));
        }
        
		try 
		{
			strQuery = SQLParser.getSqlQuery("sel_poultry_broinonrecurring^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			arryCol = new ArrayList();
			arryRow = new ArrayList();
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(appno);//0
				arryCol.add(rs.getString("poultry_specify"));//1
				arryCol.add(rs.getString("poultry_sq"));//2
				arryCol.add(rs.getString("poultry_value"));//3
				arryCol.add(rs.getString("poultry_unit"));//4
				arryCol.add(rs.getString("poultry_cost"));//5
				arryCol.add(rs.getString("poultry_loanamount"));//6
				//dbl_TotalNonrecExp+=Double.parseDouble(FwHelper.correctDouble(rs.getString("poultry_loanamount")));
				arryCol.add(rs.getString("poultry_Equipments"));//7
				
				arryRow.add(arryCol);
			}
			if(rs!=null){
				rs.close();
			}
			
			
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow", arryRow);
			//hshRecord.put("dbl_TotalNonrecExp",dbl_TotalNonrecExp);
			
			
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
		return hshRecord;
	}
	
	//Added By Amaravathi for Poultry-RecData

	public void updatebroirecurringData(HashMap hshValues) 
	{
		String appno= FwHelper.correctNull((String)hshValues.get("appno"));
		String prd_type = FwHelper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = FwHelper.correctNull((String)hshValues.get("schemetype"));
		}
		if(appno.equalsIgnoreCase("null") ||  appno.equalsIgnoreCase(""))
		{
			appno = FwHelper.correctNull((String)hshValues.get("strappno"));
		}
		String strFacSno = FwHelper.correctNull((String)hshValues.get("hidFacSNo"));
		
		HashMap hshScheme = new HashMap();
		hshScheme = Helper.splitScheme(prd_type);
		if(hshScheme!=null)
		{
			strFacSno = Helper.correctNull((String)hshScheme.get("facility_sno"));
			prd_type = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
		}
		
		String strappno= FwHelper.correctNull((String)hshValues.get("strappno"));
		String strAction=null;
		strAction = FwHelper.correctNull((String) hshValues.get("hidAction"));		
		String strAction3 = FwHelper.correctNull((String) hshValues.get("hidAction3"));
		String  txt_totalloanamount = FwHelper.correctNull((String) hshValues.get("txt_totalloanamount"));		
		HashMap hshQueryValues = new HashMap();
		HashMap hshQueryValues1 = new HashMap();
		ArrayList arrValues3 = new ArrayList();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();	
		HashMap hshQuery3 = new HashMap();
		String[] txt_value1= null;
		String[] txt_value2 = null;
		String[] txt_value3=null;		
		String[] txt_item1= null;
		String[] txt_amount1 = null;
		String[] txt_amount = null;
		String[] txt_month1 = null;
		String[] txt_cost1= null;
		if(appno.equalsIgnoreCase(""))
		{
			appno=strappno;
		}		
		
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
			 //txt_costval1=(String[])hshValues.get("txt_costval1");
			txt_totalloanamount= FwHelper.correctNull((String)hshValues.get("txt_totalloanamount"));			
			if (strAction.equals("insert"))
			{
			
			 hshQuery = new HashMap();
			 arrValues = new ArrayList();
			hshQuery.put("size", "1");
			hshQuery.put("strQueryId", "del_poultry_broirecurring");
			arrValues.add(appno);
			arrValues.add(prd_type);
			arrValues.add(strFacSno);
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
				arrValues.add(prd_type);
				arrValues.add(strFacSno);
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
				arrValues.add(prd_type);
				arrValues.add(strFacSno);
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
				arrValues.add(prd_type);
				arrValues.add(strFacSno);
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
				arrValues.add(strFacSno);
			    hshQuery.put("arrValues", arrValues);	
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
		   
			}
			ArrayList arrValues4= new ArrayList();
			
				 
		}		
		catch(Exception ce)
		{	
			throw new EJBException("inside update"+ce.toString());
		}		
	}
	
	public  HashMap getbroirecurringData(HashMap hshValues) 
	{
 		ResultSet rs = null;
 		ResultSet rs1 = null; 		
 		String strQuery = "",strfacsno="";
 		String prd_type = FwHelper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = FwHelper.correctNull((String)hshValues.get("schemetype"));
		}
		

		HashMap hshScheme = new HashMap();
		hshScheme = Helper.splitScheme(prd_type);
		if(hshScheme!=null)
		{
			strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
			prd_type = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
		}
					
 		HashMap hshRecord = new HashMap();
 		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		ArrayList arryRow1 = new ArrayList();
		ArrayList arryCol1 = null;
		ArrayList arryRow2 = new ArrayList();
		ArrayList arryCol2 = null;
		String appno = FwHelper.correctNull((String) hshValues.get("appno"));
 		if(appno.equalsIgnoreCase("null") ||  appno.equalsIgnoreCase(""))
		{
			appno = FwHelper.correctNull((String)hshValues.get("strappno"));
		}
        String PageType=FwHelper.correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
         {
      	 PageType=FwHelper.correctNull((String)hshValues.get("hidpagetype"));
         }
 		try 
		{			
			strQuery = SQLParser.getSqlQuery("agr_get_sheeploanamountdata^"+appno+"^"+prd_type);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) 
			{
				hshRecord.put("txt_totalamount", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("sheep_totalamount"))));
				hshRecord.put("txt_margin", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("sheep_marginper"))));
				hshRecord.put("txt_marginper", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("sheep_margin"))));
				hshRecord.put("txt_subsidyper", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("sheep_subsidyper"))));
				hshRecord.put("txt_subsidy", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("sheep_subsidy"))));
				hshRecord.put("txt_totalloanamount1", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("sheep_totalloanamount"))));
				
			}
			if(rs1!=null){
				rs1.close();
			}
			strQuery = SQLParser.getSqlQuery("agr_get_poultrybroifindata^"+appno+ "^" +prd_type);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) 
			{
				hshRecord.put("txt_nochicks", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_nochicks"))));
				hshRecord.put("txt_costchicks", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_costchicks"))));
				hshRecord.put("txt_totalcostchicks", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totalcostchicks"))));
				hshRecord.put("txt_costchickmash", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_costchickmash"))));
				hshRecord.put("txt_conchickmash", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_conchickmash"))));
				hshRecord.put("txt_totalchickmash", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totalchickmash"))));
				hshRecord.put("txt_costgrowermash", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_costgrowermash"))));
				hshRecord.put("txt_congrowermash", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_congrowermash"))));
				hshRecord.put("txt_totalgrowermash", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totalgrowermash"))));
				hshRecord.put("txt_totalfeedcon", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totalfeedcon"))));
				hshRecord.put("txt_totalfeedcost", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totalfeedcost"))));
				hshRecord.put("txt_broodingmor", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_broodingmor"))));
				hshRecord.put("txt_broodingchicks", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_broodingchicks"))));
				hshRecord.put("txt_specify1", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_specify1"))));
				hshRecord.put("txt_specify2", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_specify2"))));
				hshRecord.put("txt_electricitycharge", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_electricitycharge"))));
				hshRecord.put("txt_watercharge", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_watercharge"))));
				hshRecord.put("txt_vtaid", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_vtaid"))));
				hshRecord.put("txt_inspremium", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_inspremium"))));
				hshRecord.put("txt_yieldegg", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_yieldegg"))));
				hshRecord.put("txt_totsaleegg", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totsaleegg"))));
				hshRecord.put("txt_yieldmanure", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_yieldmanure"))));
				hshRecord.put("txt_salemanure", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_salemanure"))));
				hshRecord.put("txt_salegunny", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_salegunny"))));
				hshRecord.put("txt_emptybag", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_emptybag"))));
				hshRecord.put("txt_transportcharge", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_transportcharge"))));
				hshRecord.put("txt_totalvtaid", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totalvtaid"))));
				hshRecord.put("txt_totalinspremium", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totalinspremium"))));
				hshRecord.put("txt_totsalemanure", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totsalemanure"))));
				hshRecord.put("txt_totsalebag", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totsalebag"))));
				
			}
			if(rs1!=null){
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
			if(rs!=null){
				rs.close();
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
			}
			if(rs!=null){
				rs.close();
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
			if(rs!=null){
				rs.close();
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
			if(rs!=null){
				rs.close();
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
			if(rs!=null){
				rs.close();
			}
			
			String strNonRecurringTotal=null;
			strQuery = SQLParser.getSqlQuery("get_nonrec_total^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				strNonRecurringTotal=rs.getString("tot_nonrec");
			}
			if(rs!=null){
				rs.close();
			}
			hshRecord.put("tot_non_recurring",FwHelper.formatDoubleValue(FwHelper.parseDouble(FwHelper.correctDouble(strNonRecurringTotal))));
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
	
	public HashMap updatebroiagrflock(HashMap hshValues)  
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshpasValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();		
		HashMap hshResult = new HashMap();
		String strAction="";		
		String strApplicationNo = FwHelper.correctNull((String) hshValues.get("strappno"));
		String schemetype = correctNull((String)hshValues.get("schemetype"));	
		String strSchemeType="";
		if(schemetype.equalsIgnoreCase("null") || schemetype.equalsIgnoreCase(""))
		{
			schemetype = FwHelper.correctNull((String)hshValues.get("schemetype"));
		}
		String strFacSno = FwHelper.correctNull((String)hshValues.get("hidFacSNo"));
		int inttenor= Integer.parseInt(Helper.correctInt((String)hshValues.get("hidstrPeriod")));

		strSchemeType=schemetype;
		HashMap hshScheme = new HashMap();
		hshScheme = Helper.splitScheme(schemetype);
		if(hshScheme!=null)
		{
			strFacSno = Helper.correctNull((String)hshScheme.get("facility_sno"));
			schemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
		}
		
		if(strApplicationNo.equalsIgnoreCase(""))
		{
			strApplicationNo = FwHelper.correctNull((String)hshValues.get("appno"));
		}
		 strAction = FwHelper.correctNull((String) hshValues.get("hidAction"));
		String[] strSno= null;
		String[] strNoofPatch= null;
		String[] strBrooderWk= null;
		String[] strGrowerWk= null;
		String[] strLayerWk= null;
		String[] strNoofPatchesSold= null;
		String[] strTableEgg= null;
		String[] strFertileEgg= null;
		String[] strIncomeTableEgg= null;
		String[] strIncomeFertileEgg= null;
		String[] strTotalIncome= null;
		String[] strBrooderWkExp= null;
		String[] strGrowerWkExp= null;
		String[] strLayerWkExp= null;
		String[] strTotalExp=null;
		int intUpdatesize=0;
		try
		{
			strApplicationNo= FwHelper.correctNull((String)hshValues.get("strappno"));
			if(strApplicationNo.equalsIgnoreCase(""))
			{
				strApplicationNo = FwHelper.correctNull((String)hshValues.get("appno"));
			}
			if(hshValues.get("hidSno") instanceof java.lang.String)
			 {
				strSno= new String[1];
				strSno[0]=(String)hshValues.get("hidSno");
			 }else{
				 strSno=(String [])hshValues.get("hidSno");
			 }
			if(hshValues.get("txt_batch") instanceof java.lang.String)
			 {
				strNoofPatch= new String[1];
				strNoofPatch[0]=(String)hshValues.get("txt_batch");
			 }else{
				 strNoofPatch=(String [])hshValues.get("txt_batch");
			 }
			if(hshValues.get("txtbrood") instanceof java.lang.String)
			 {
				strBrooderWk= new String[1];
				strBrooderWk[0]=(String)hshValues.get("txtbrood");
			 }else{
				 strBrooderWk=(String [])hshValues.get("txtbrood");
			 }
			if(hshValues.get("txtgrower") instanceof java.lang.String)
			 {
				strGrowerWk= new String[1];
				strGrowerWk[0]=(String)hshValues.get("txtgrower");
			 }else{
				 strGrowerWk=(String [])hshValues.get("txtgrower");
			 }
			if(hshValues.get("txtlayer") instanceof java.lang.String)
			 {
				strLayerWk= new String[1];
				strLayerWk[0]=(String)hshValues.get("txtlayer");
			 }else{
				 strLayerWk=(String [])hshValues.get("txtlayer");
			 }
			if(hshValues.get("txt_broodermon") instanceof java.lang.String)
			 {
				strNoofPatchesSold= new String[1];
				strNoofPatchesSold[0]=(String)hshValues.get("txt_broodermon");
			 }else{
				 strNoofPatchesSold=(String [])hshValues.get("txt_broodermon");
			 }
			if(hshValues.get("txttegg") instanceof java.lang.String)
			 {
				strTableEgg= new String[1];
				strTableEgg[0]=(String)hshValues.get("txttegg");
			 }else{
				 strTableEgg=(String [])hshValues.get("txttegg");
			 }
			if(hshValues.get("txtfegg") instanceof java.lang.String)
			 {
				strFertileEgg= new String[1];
				strFertileEgg[0]=(String)hshValues.get("txtfegg");
			 }else{
				 strFertileEgg=(String [])hshValues.get("txtfegg");
			 }
			if(hshValues.get("txttincome") instanceof java.lang.String)
			 {
				strIncomeTableEgg= new String[1];
				strIncomeTableEgg[0]=(String)hshValues.get("txttincome");
			 }else{
				 strIncomeTableEgg=(String [])hshValues.get("txttincome"); 
			 }
			if(hshValues.get("txtfincome") instanceof java.lang.String)
			 {
				strIncomeFertileEgg= new String[1];
				strIncomeFertileEgg[0]=(String)hshValues.get("txtfincome");
			 }else{
				 strIncomeFertileEgg=(String [])hshValues.get("txtfincome");
			 }
			if(hshValues.get("txttotalincome") instanceof java.lang.String)
			 {
				strTotalIncome= new String[1];
				strTotalIncome[0]=(String)hshValues.get("txttotalincome");
			 }else{
				 strTotalIncome=(String [])hshValues.get("txttotalincome");
			 }
			if(hshValues.get("txtbfeedingexp") instanceof java.lang.String)
			 {
				strBrooderWkExp= new String[1];
				strBrooderWkExp[0]=(String)hshValues.get("txtbfeedingexp");
			 }else{
				 strBrooderWkExp=(String [])hshValues.get("txtbfeedingexp");
			 }
			if(hshValues.get("txtgfeedingexp") instanceof java.lang.String)
			 {
				strGrowerWkExp= new String[1];
				strGrowerWkExp[0]=(String)hshValues.get("txtgfeedingexp");
			 }else{
				 strGrowerWkExp=(String [])hshValues.get("txtgfeedingexp");
			 }
			if(hshValues.get("txtlfeedingexp") instanceof java.lang.String)
			 {
				strLayerWkExp= new String[1];
				strLayerWkExp[0]=(String)hshValues.get("txtlfeedingexp");
			 }else{
				 strLayerWkExp=(String [])hshValues.get("txtlfeedingexp");
			 }
			if(hshValues.get("txttotalfeedingexp") instanceof java.lang.String)
			 {
				strTotalExp= new String[1];
				strTotalExp[0]=(String)hshValues.get("txttotalfeedingexp");
			 }else{
				 strTotalExp=(String [])hshValues.get("txttotalfeedingexp");
			 }
			if (strAction.equals("insert"))
			{			
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strApplicationNo);
				arrValues.add(schemetype);
				arrValues.add(strFacSno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","agr_broidelflockrep");
				intUpdatesize=1;
				hshQueryValues.put("1",hshQuery);
				
				intUpdatesize=intUpdatesize+1;
				hshQuery=new HashMap();
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","delagrbroiflockexp");
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize=intUpdatesize+1;
				arrValues.add(strApplicationNo);
				arrValues.add(schemetype);
				arrValues.add(strFacSno);
				arrValues.add(Helper.correctNull((String)hshValues.get("txtegg")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtegg1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtegg2")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtegg3")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtbrooderfeedexp")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtgrowerfeedexp")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtlayerfeedexp")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtbirdsperbatch")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtcostofbird")));
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","insagrbroiflockexp");
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				if(inttenor>0){
				for(int i=0;i<inttenor;i++)
				{
						intUpdatesize=intUpdatesize+1;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","insagrbroiselflockrep");
						arrValues.add(strApplicationNo);
						arrValues.add(schemetype);
						arrValues.add(strFacSno);
						arrValues.add(strSno[i]);
						arrValues.add(strNoofPatch[i]);
						arrValues.add(strBrooderWk[i]);
						arrValues.add(strGrowerWk[i]);
						arrValues.add(strLayerWk[i]);
						arrValues.add(strNoofPatchesSold[i]);
						arrValues.add(strTableEgg[i]);
						arrValues.add(strFertileEgg[i]);
						arrValues.add(strIncomeTableEgg[i]);
						arrValues.add(strIncomeFertileEgg[i]);
						arrValues.add(strTotalIncome[i]);
						arrValues.add(strBrooderWkExp[i]);
						arrValues.add(strGrowerWkExp[i]);
						arrValues.add(strLayerWkExp[i]);
						arrValues.add(strTotalExp[i]);
						hshQuery.put("arrValues",arrValues);	
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);		
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
				arrValues.add(schemetype);
				arrValues.add(strFacSno);
				hshQuery.put("arrValues",arrValues);	
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","delagrbroiflockexp");
				arrValues.add(strApplicationNo);
				arrValues.add(schemetype);
				arrValues.add(strFacSno);
				hshQuery.put("arrValues",arrValues);	
				hshQueryValues.put("size","2");
				hshQueryValues.put("2",hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			hshpasValues.put("appno",strApplicationNo);
			hshpasValues.put("schemetype",strSchemeType);
			hshResult=getbroiagrflock(hshpasValues);						
		} 
		catch (Exception ce) 
		{	
			throw new EJBException("Error in closing getData" + ce.getMessage());
		}		
		return hshResult;
	}
	
	public HashMap getbroiagrflock(HashMap hshValues)  
	{		 
		ResultSet rs=null;
		HashMap hshResult=new HashMap();
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=new ArrayList();
		ArrayList arryFeedRow=new ArrayList();
		ArrayList arryFeedCol=new ArrayList();
		String strApplicationNo= FwHelper.correctNull((String)hshValues.get("strappno"));		
		String schemetype = FwHelper.correctNull((String)hshValues.get("strProductType"));
		String strfacsno="",strQuery="";
		int intPeriod=0;
		
		if(schemetype.equalsIgnoreCase("null") || schemetype.equalsIgnoreCase(""))
		{
			schemetype = FwHelper.correctNull((String)hshValues.get("schemetype"));
		}
		

		HashMap hshScheme = new HashMap();
		hshScheme = Helper.splitScheme(schemetype);
		if(hshScheme!=null)
		{
			strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
			schemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
		}
					
		if(strApplicationNo.equalsIgnoreCase(""))
		{
			strApplicationNo = FwHelper.correctNull((String)hshValues.get("appno"));
		}
		try 
		{
			
			if(rs!=null){rs.close();}
			strQuery = SQLParser.getSqlQuery("agr_get_poultrybroifindata^"+strApplicationNo+ "^" +schemetype);
			strQuery=strQuery+"and agr_facsno="+strfacsno;
			rs=DBUtils.executeQuery(strQuery);			 
			if(rs.next())
			{
				hshResult.put("strnoofbirds",FwHelper.correctNull(rs.getString("poultry_broodingchicks")));
			}
			if(rs!=null){rs.close();}
			rs=DBUtils.executeLAPSQuery("getfacdetforsanction^"+strApplicationNo+"^"+strfacsno);			 
			if(rs.next())
			{
				intPeriod=Integer.parseInt(Helper.correctInt(rs.getString("facility_months")));
				intPeriod=intPeriod/12;
				if(intPeriod==0)
					intPeriod=1;
			}
			if(rs!=null){rs.close();}
			rs=DBUtils.executeLAPSQuery("sel_agrbroiselflockrep^"+strApplicationNo+"^"+schemetype+"^"+strfacsno);			 
			while (rs.next())
			{
				arryCol=new ArrayList();
				arryFeedCol=new ArrayList();
				arryCol.add(rs.getString("sno"));
				arryCol.add(rs.getString("agr_batch"));	
				arryCol.add(rs.getString("agr_brooderwk"));	
				arryCol.add(rs.getString("agr_growererwk"));	
				arryCol.add(rs.getString("agr_layerrwk"));	
				arryCol.add(rs.getString("agr_patchsold"));	
				arryCol.add(rs.getString("agr_tableeggamt"));	
				arryCol.add(rs.getString("agr_fertileeggamt"));	
				arryCol.add(rs.getString("agr_tableeggincome"));	
				arryCol.add(rs.getString("agr_fertileeggincome"));	
				arryCol.add(rs.getString("agr_totalincome"));
				arryFeedCol.add(rs.getString("agr_broodfeedexp"));	
				arryFeedCol.add(rs.getString("agr_growerfeedexp"));	
				arryFeedCol.add(rs.getString("agr_layerfeedexp"));	
				arryFeedCol.add(rs.getString("agr_totalfeedexp"));	
				arryRow.add(arryCol);
				arryFeedRow.add(arryFeedCol);
			}
			if(rs!=null){
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("selagrbroiflockexp^"+strApplicationNo+"^"+schemetype+"^"+strfacsno);			 
			if (rs.next())
			{
				hshResult.put("strtableegg",correctNull(rs.getString("agr_teggamt_peregg")));
				hshResult.put("strfertileegg",correctNull(rs.getString("agr_fertileeggamt_peregg")));
				hshResult.put("strtableeggincome",correctNull(rs.getString("agr_incomefromtegg_peregg")));
				hshResult.put("strfertileeggincome",correctNull(rs.getString("agr_incomefromfegg_peregg")));
				hshResult.put("strbrooderexp",correctNull(rs.getString("agr_brooderfeed_exp")));
				hshResult.put("strgrowererexp",correctNull(rs.getString("agr_growerfeed_exp")));
				hshResult.put("strlayerexp",correctNull(rs.getString("agr_layererfeed_exp")));
				hshResult.put("strnoofbirds",correctNull(rs.getString("agr_noofbirds")));
				hshResult.put("strcostofbird",correctNull(rs.getString("AGR_costofbird")));
			}
			if(rs!=null){rs.close();}
			if(rs!=null){rs.close();}
			rs=DBUtils.executeLAPSQuery("sel_agr_poultrytechdata^"+strApplicationNo+"^"+schemetype+"^"+strfacsno);			 
			if(rs.next())
			{
				hshResult.put("strPoultry",FwHelper.correctNull(rs.getString("poultry_poultrytype")));
			}
			hshResult.put("arryRow",arryRow);
			hshResult.put("arryFeedRow",arryFeedRow);
			hshResult.put("strPeriod",String.valueOf(intPeriod));
			hshResult.put("strAppno",strApplicationNo);
			
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
	
	
	public void updatepoultrybroiflowchartData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery =  new HashMap();
		ArrayList arrValues=new ArrayList();
		String schemetype = correctNull((String)hshValues.get("schemetype"));	
		String strFacSno = FwHelper.correctNull((String)hshValues.get("hidFacSNo"));
		String strAction= FwHelper.correctNull((String)hshValues.get("hidAction"));
		String appno= FwHelper.correctNull((String)hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = FwHelper.correctNull((String)hshValues.get("appno"));
		}
		String prd_type = FwHelper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = FwHelper.correctNull((String)hshValues.get("schemetype"));
		}
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = FwHelper.correctNull((String)hshValues.get("prd_type"));
		}
		HashMap hshScheme = new HashMap();
		hshScheme = Helper.splitScheme(schemetype);
		if(hshScheme!=null)
		{
			strFacSno = Helper.correctNull((String)hshScheme.get("facility_sno"));
			prd_type = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
		}
		try
		{			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","del_poultry_expenditure");
				arrValues.add(appno);
				arrValues.add(prd_type);
				arrValues.add(strFacSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(FwHelper.correctNull((String) hshValues.get("txt_totiyearu")));
				arrValues.add(FwHelper.correctNull((String) hshValues.get("txt_totaliiyearu")));
				arrValues.add(FwHelper.correctNull((String) hshValues.get("txt_totaliiiyearu")));
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add(FwHelper.correctNull((String) hshValues.get("txt_totaliyearl")));
				arrValues.add(FwHelper.correctNull((String) hshValues.get("txt_totaliiyearl")));
				arrValues.add(FwHelper.correctNull((String) hshValues.get("txt_totaliiiyearl")));
				arrValues.add(FwHelper.correctNull((String) hshValues.get("txt_totaliyear2")));
				arrValues.add(FwHelper.correctNull((String) hshValues.get("txt_totaliiyear2")));
				arrValues.add(FwHelper.correctNull((String) hshValues.get("txt_totaliiiyear2")));
				
				arrValues.add(prd_type);
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
				arrValues.add(strFacSno);
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
	
	//Added By Amaravathi for Poultry-StateOfIncome
	public HashMap getpoultrybroiflowchartData(HashMap hshValues)  
	{
		String strQuery = "";
		
		ResultSet rs = null;
		ResultSet rs1 = null;
		
		String prd_type = FwHelper.correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase(""))
		{
			prd_type = FwHelper.correctNull((String)hshValues.get("schemetype"));
		}
		String strFacSno = FwHelper.correctNull((String)hshValues.get("hidFacSNo"));
		
		HashMap hshScheme = new HashMap();
		hshScheme = Helper.splitScheme(prd_type);
		if(hshScheme!=null)
		{
			strFacSno = Helper.correctNull((String)hshScheme.get("facility_sno"));
			prd_type = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
		}
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
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
		ArrayList arrNonRecuExpe=new ArrayList();    
		ArrayList arrTotalExpenses=new ArrayList();
		double dbl_totnobatch=0.00;
		double dblexpforyear[]=new double[5];
		double dblPurchase[]=new double[5];
		double dblFeedCost[]=new double[5];
		java.text.NumberFormat nft= java.text.NumberFormat.getInstance();
    	nft= java.text.NumberFormat.getInstance();
    	nft.setMaximumFractionDigits(2);
    	nft.setMinimumFractionDigits(2);
    	String strPoultryType="";
		
		String appno= FwHelper.correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = FwHelper.correctNull((String)hshValues.get("strappno"));
		}
		
	    String PageType= FwHelper.correctNull((String)hshValues.get("hidpagetype1"));
	    
        if(PageType.equalsIgnoreCase(""))
        {
        	 PageType= FwHelper.correctNull((String)hshValues.get("hidpagetype"));
        }
        
		try 
		{			
			//strQuery = SQLParser.getSqlQuery("agr_broiselflockrep^" + appno);
			//rs = DBUtils.executeQuery(strQuery);
			
			if(rs!=null){rs.close();}
			rs=DBUtils.executeLAPSQuery("sel_agr_poultrytechdata^"+appno+"^"+prd_type+"^"+strFacSno);			 
			if (rs.next())
			{
				
				strPoultryType=Helper.correctNull(rs.getString("poultry_poultrytype"));
			}
			
			double dblCostperbird=0.00;
			String strNoofbirds="";
			if(!strPoultryType.equalsIgnoreCase("3"))
			{
				if(rs!=null){rs.close();}
				rs=DBUtils.executeLAPSQuery("selagrbroiflockexp^"+appno+"^"+prd_type+"^"+strFacSno);			 
				if(rs.next())
				{
					strNoofbirds=Helper.correctDouble(rs.getString("agr_noofbirds"));
					dblCostperbird=Double.parseDouble(Helper.correctDouble(rs.getString("AGR_costofbird")));
				}
				int k=0;
				if(rs!=null){rs.close();}
				rs=DBUtils.executeLAPSQuery("sel_agrbroiselflockrep^"+appno+"^"+prd_type+"^"+strFacSno);			 
				while(rs.next())
				{
					if(k<5){
					dblFeedCost[k]=FwHelper.parseDouble(Helper.correctDouble(rs.getString("agr_totalfeedexp")));
					dblPurchase[k]=FwHelper.parseDouble(Helper.correctDouble(rs.getString("agr_batch")));
					k++;
					}
				}
				if(dblFeedCost.length<5)
				{
					for(int j=dblFeedCost.length;j<5;j++)
					{
						dblFeedCost[j]=0.00;
					}
				}
				if(dblPurchase.length<5)
				{
					for(int j=dblPurchase.length;j<5;j++)
					{
						dblPurchase[j]=0.00;
					}
				}
			}
				strQuery = SQLParser.getSqlQuery("sel_poultry_exp_facno^" + appno+"^"+prd_type+"^E"+"^"+strFacSno);
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next())
				{
					int i=0;
					arryCol1 = new ArrayList();
					arryCol1.add(rs.getString("poultry_expenses"));
					dblexpforyear[i]=dblexpforyear[i]+FwHelper.parseDouble((FwHelper.correctDouble((String)rs.getString("poultry_iyear"))));
					arryCol1.add(FwHelper.formatDoubleValue(FwHelper.parseDouble((FwHelper.correctDouble((String)rs.getString("poultry_iyear"))))));
					i++;
					dblexpforyear[i]=dblexpforyear[i]+FwHelper.parseDouble((FwHelper.correctDouble((String)rs.getString("poultry_iiyear"))));
					arryCol1.add(FwHelper.formatDoubleValue(FwHelper.parseDouble((FwHelper.correctDouble((String)rs.getString("poultry_iiyear"))))));
					i++;
					dblexpforyear[i]=dblexpforyear[i]+FwHelper.parseDouble((FwHelper.correctDouble((String)rs.getString("poultry_iiiyear"))));
					arryCol1.add(FwHelper.formatDoubleValue(FwHelper.parseDouble((FwHelper.correctDouble((String)rs.getString("poultry_iiiyear"))))));
					arryCol1.add(rs.getString("poultry_type"));
					
					dblexpforyear[i]=dblexpforyear[i]+FwHelper.parseDouble((FwHelper.correctDouble((String)rs.getString("poultry_ivyear"))));
					arryCol1.add(FwHelper.formatDoubleValue(FwHelper.parseDouble((FwHelper.correctDouble((String)rs.getString("poultry_ivyear"))))));
					
					dblexpforyear[i]=dblexpforyear[i]+FwHelper.parseDouble((FwHelper.correctDouble((String)rs.getString("poultry_vyear"))));
					arryCol1.add(FwHelper.formatDoubleValue(FwHelper.parseDouble((FwHelper.correctDouble((String)rs.getString("poultry_vyear"))))));
					
					arryRow1.add(arryCol1);
				}
				if(rs!=null){
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_poultry_recurringdata^" + appno+"^"+prd_type);
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next())
				{
					arryCol = new ArrayList();                                                                         
					arryCol.add(rs.getString("poultry_loanamount"));
					arryRow.add(arryCol);
				}
				if(rs!=null){
					rs.close();
				}
				
				rs=DBUtils.executeLAPSQuery("agr_broiselflockrep_facno^"+appno+"^"+prd_type+"^"+strFacSno);
				arryCol2=new ArrayList();
				while (rs.next())
				{
					arryCol2.add(rs.getString("agr_batch"));			
				}
				if(rs!=null){
					rs.close();
				}
				if(arryCol2.size()<3)
				{
					hshRecord.put("nodata","Y");
					while(3-arryCol2.size()>0)
					{
						arryCol2.add("0.00");
					}
				}
				strQuery = SQLParser.getSqlQuery("agr_get_poultrybroifindata^"+appno+ "^" +prd_type);
				strQuery=strQuery+"and agr_facsno="+strFacSno;
				rs1 = DBUtils.executeQuery(strQuery);
				double txt_watercharge=0.00;double txt_electricitycharge=0.00;
				String totalChicks="",totalfeedcost="",watercharge="",electricitycharge="",
				vtaid="",inspremium="",transportcharge="",nochicks="";
				if (rs1.next()) 
				{
					nochicks=FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_broodingchicks")));
					hshRecord.put("txt_costchicks", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_costchicks"))));
					totalChicks=FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totalcostchicks"))); 
					hshRecord.put("txt_costchickmash", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_costchickmash"))));
					hshRecord.put("txt_conchickmash", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_conchickmash"))));
					hshRecord.put("txt_totalchickmash", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totalchickmash"))));
					hshRecord.put("txt_costgrowermash", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_costgrowermash"))));
					hshRecord.put("txt_congrowermash", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_congrowermash"))));
					hshRecord.put("txt_totalgrowermash", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totalgrowermash"))));
					hshRecord.put("txt_totalfeedcon", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totalfeedcon"))));
					totalfeedcost= FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totalfeedcost")));
					hshRecord.put("txt_broodingmor", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_broodingmor"))));
					hshRecord.put("txt_broodingchicks", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_broodingchicks"))));
					hshRecord.put("txt_specify1", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_specify1"))));
					hshRecord.put("txt_specify2", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_specify2"))));
					electricitycharge=FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_electricitycharge")));
					watercharge=FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_watercharge")));
					vtaid=FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_vtaid")));
					inspremium=FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_inspremium")));
					hshRecord.put("txt_yieldegg", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_yieldegg"))));
					hshRecord.put("txt_totsaleegg", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totsaleegg"))));
					hshRecord.put("txt_yieldmanure", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_yieldmanure"))));
					hshRecord.put("txt_salemanure", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_salemanure"))));
					hshRecord.put("txt_salegunny", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_salegunny"))));
					hshRecord.put("txt_emptybag", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_emptybag"))));
					transportcharge=FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_transportcharge")));
					//vtaid=FwHelper.correctDoubleQuote(FwHelper.correctDouble(rs1.getString("poultry_totalvtaid")));
					//inspremium=FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totalinspremium")));
					hshRecord.put("txt_totsalemanure", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totsalemanure"))));
					hshRecord.put("txt_totsalebag", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totsalebag"))));
					
					dbl_totnobatch=Double.parseDouble(FwHelper.correctDouble(rs1.getString("poultry_totnobatch"))); //added by ganesan for Total Number of Batch
					
					txt_electricitycharge = txt_watercharge+ FwHelper.parseDouble((FwHelper.correctDouble((String)rs1.getString("poultry_electricitycharge"))));
					txt_watercharge = txt_watercharge+ FwHelper.parseDouble((FwHelper.correctDouble((String)rs1.getString("poultry_watercharge"))));
					
					
				}
				if(rs1!=null){
					rs1.close();
				}
				if("".equals(nochicks))nochicks="0.00";
				if("".equals(totalChicks))totalChicks="0.00";
				if("".equals(totalfeedcost))totalfeedcost="0.00";
				if("".equals(electricitycharge))electricitycharge="0.00";
				if("".equals(watercharge))watercharge="0.00";
				if("".equals(transportcharge))transportcharge="0.00";
				if("".equals(vtaid))vtaid="0.00";
				if("".equals(inspremium))inspremium="0.00";
				strQuery = SQLParser.getSqlQuery("per_get_poultryfinperdata_facno^" + appno+"^"+prd_type+"^"+strFacSno);
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
					sal1=FwHelper.parseDouble((FwHelper.correctDouble((String)rs.getString("poultry_noperson"))));
					sal2=FwHelper.parseDouble((FwHelper.correctDouble((String)rs.getString("poultry_salarypm"))));
					sal3=sal1*sal2;
					arryCol3.add(rs.getString("poultry_salarypy"));
					salarypy=salarypy+sal3;
					arryRow3.add(arryCol3);
				}
				if(rs!=null){
					rs.close();
				}
				double dbl_TotNonExp=0.00;
				
				strQuery = SQLParser.getSqlQuery("sel_poultry_broinonrecurring^" + appno);
				strQuery=strQuery+"and agr_facsno="+strFacSno;
				rs = DBUtils.executeQuery(strQuery);
							
					while (rs.next())
							{
								
								dbl_TotNonExp=dbl_TotNonExp+(FwHelper.parseDouble(FwHelper.correctDouble((String)rs.getString("poultry_loanamount"))));//
								
							}
					  if(rs!=null){
						rs.close();
							}
							
				
				for(int i=0;i<5;i++)
				{
					dblexpforyear[i]=dblexpforyear[i]+(salarypy*12);
					arrSal.add(FwHelper.formatDoubleValue((salarypy)*12));
					
					if(!strPoultryType.equalsIgnoreCase("3"))
					{
						dbl_totnobatch=dblPurchase[i];
						totalChicks=strNoofbirds;
						dblexpforyear[i]=dblexpforyear[i]+(FwHelper.parseDouble((totalChicks))*dbl_totnobatch * dblCostperbird);
						arrChicks.add(FwHelper.checkDecimal(String.valueOf((FwHelper.parseDouble(totalChicks)) * (dbl_totnobatch)*(dblCostperbird))));
		
						dblexpforyear[i]=dblexpforyear[i]+dblFeedCost[i];
						arrFeedCost.add(nft.format(dblFeedCost[i]));
					}else{
						dblexpforyear[i]=dblexpforyear[i]+(FwHelper.parseDouble((totalChicks))*dbl_totnobatch);
						arrChicks.add(FwHelper.checkDecimal(String.valueOf((FwHelper.parseDouble(totalChicks)) * (dbl_totnobatch))));
			
						dblexpforyear[i]=dblexpforyear[i]+((FwHelper.parseDouble(nochicks))*(FwHelper.parseDouble(totalfeedcost))*(dbl_totnobatch));
						arrFeedCost.add(nft.format(((FwHelper.parseDouble(nochicks))*(dbl_totnobatch)*(FwHelper.parseDouble(totalfeedcost)))));	
					}
				
					
					dblexpforyear[i]=dblexpforyear[i]+(FwHelper.parseDouble(watercharge)*12.0);
					arrWaterCharge.add(nft.format(FwHelper.parseDouble(watercharge)*12.0));
					
					dblexpforyear[i]=dblexpforyear[i]+(FwHelper.parseDouble(electricitycharge)*12.0);
					arrElectric.add(FwHelper.checkDecimal(String.valueOf(FwHelper.parseDouble(electricitycharge)*12.0)));
					
					dblexpforyear[i]=dblexpforyear[i]+(FwHelper.parseDouble(vtaid)*(dbl_totnobatch));
					arrVetri.add(FwHelper.checkDecimal(String.valueOf(FwHelper.parseDouble(vtaid)*(dbl_totnobatch))));
					
					dblexpforyear[i]=dblexpforyear[i]+(FwHelper.parseDouble((inspremium))*(dbl_totnobatch));
					arrInsPre.add(FwHelper.checkDecimal(String.valueOf(FwHelper.parseDouble(inspremium)*(dbl_totnobatch))));
					
					dblexpforyear[i]=dblexpforyear[i]+(FwHelper.parseDouble(transportcharge)*(dbl_totnobatch));
					arrTransport.add(nft.format(FwHelper.parseDouble(transportcharge)*(dbl_totnobatch)));
					
					if(i<1)
					{
						dblexpforyear[i]=dblexpforyear[i]+(dbl_TotNonExp);
						arrNonRecuExpe.add(FwHelper.checkDecimal(jtn.format((dbl_TotNonExp))));
						
					}
					
					arrTotalExpenses.add(""+dblexpforyear[i]);
				}
				hshRecord.put("arrSal",arrSal);
				hshRecord.put("arrChicks",arrChicks);
				hshRecord.put("arrFeedCost",arrFeedCost);
				hshRecord.put("arrWaterCharge",arrWaterCharge);
				hshRecord.put("arrElectric",arrElectric);
				hshRecord.put("arrVetri",arrVetri);
				hshRecord.put("arrInsPre",arrInsPre);
				hshRecord.put("arrTransport",arrTransport);
				hshRecord.put("arrNonRecuExpe",arrNonRecuExpe);
				hshRecord.put("arrTotalExpenses",arrTotalExpenses);
				
				hshRecord.put("appno", appno);
				hshRecord.put("arryRow1", arryRow1);
				txt_watercharge=txt_watercharge*12;
				txt_electricitycharge=txt_electricitycharge*12;				
				hshRecord.put("arryRow", arryRow);
				hshRecord.put("arryRow2", arryRow2);
				hshRecord.put("PageType", PageType);
				
				strQuery = SQLParser.getSqlQuery("sel_poultry_recurring^" + appno+"^"+prd_type);
				strQuery=strQuery+"and agr_facsno="+strFacSno;
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
				if(rs!=null){
					rs.close();
				}
				hshRecord.put("arryRow5", arryRow5);
			 
				HashMap hshQueryValues=new HashMap();
				HashMap hshQuery=new HashMap();
				ArrayList arrValues=new ArrayList();
			 	hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","del_poultry_expenditure");
				arrValues.add(appno);
				arrValues.add(prd_type);
				arrValues.add(strFacSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(""+dblexpforyear[0]);
				arrValues.add(""+dblexpforyear[1]);
				arrValues.add(""+dblexpforyear[2]);
				arrValues.add(""+dblexpforyear[3]);
				arrValues.add(""+dblexpforyear[4]);
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add(""+dblexpforyear[0]);
				arrValues.add(""+dblexpforyear[1]);
				arrValues.add(""+dblexpforyear[2]);
				
				arrValues.add(prd_type);
				arrValues.add(strFacSno);
				arrValues.add(""+dblexpforyear[3]);
				arrValues.add(""+dblexpforyear[4]);
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "ins_poultry_expenditure");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			
		} 
		catch (Exception ce)
		{	
			throw new EJBException("Error in getpoultrybroiflowchartData" + ce.getMessage());
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
	
	
	public void updatepoultrybroiincomeflowData(HashMap hshValues)
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery =  new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction= FwHelper.correctNull((String)hshValues.get("hidAction"));
		String appno= FwHelper.correctNull((String)hshValues.get("strappno"));
		
		if(appno.equalsIgnoreCase(""))
		{
			appno = FwHelper.correctNull((String)hshValues.get("appno"));
		}
		String schemetype = correctNull((String)hshValues.get("schemetype"));	
		String strFacSno = FwHelper.correctNull((String)hshValues.get("hidFacSNo"));
		HashMap hshScheme = new HashMap();
		hshScheme = Helper.splitScheme(schemetype);
		if(hshScheme!=null)
		{
			strFacSno = Helper.correctNull((String)hshScheme.get("facility_sno"));
			schemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
		}
		try
		{			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","del_poultry_income");
				arrValues.add(appno);
				arrValues.add(schemetype);
				arrValues.add(strFacSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(FwHelper.correctNull((String) hshValues.get("txt_sur1")));
				arrValues.add(FwHelper.correctNull((String) hshValues.get("txt_sur2")));
				arrValues.add(FwHelper.correctNull((String) hshValues.get("txt_sur3")));
				arrValues.add(FwHelper.correctNull((String) hshValues.get("txt_sur3")));
				arrValues.add(FwHelper.correctNull((String) hshValues.get("txt_sur3")));
				arrValues.add(FwHelper.correctNull((String) hshValues.get("txt_sur3")));
				arrValues.add(FwHelper.correctNull((String) hshValues.get("txt_sur3")));
				arrValues.add(FwHelper.correctNull((String) hshValues.get("txt_sur3")));
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
				arrValues.add(schemetype);
				arrValues.add(strFacSno);
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
	
	public HashMap getpoultrybroiincomeflowData(HashMap hshValues) 
	{
		String strQuery = "";		
		ResultSet rs1 = null;
		ResultSet rs2=null;		
		HashMap hshRecord = new HashMap();		
		ArrayList arryRow1 = new ArrayList();
		ArrayList arryCol1 = new ArrayList();
		ArrayList arryColEgg=new ArrayList();
		ArrayList arryCol2=new ArrayList();
		
		ArrayList arrSalebirds=new ArrayList();
		ArrayList arrSalemanure=new ArrayList();
		ArrayList arrSalebag=new ArrayList();
		ArrayList arrSalesEgg=new ArrayList();
		
		ArrayList arrCalYear1=new ArrayList();
		ArrayList arrCalYear2=new ArrayList();
		ArrayList arrCalYear3=new ArrayList();
		ArrayList arrCalYear4=new ArrayList();
		ArrayList arrCalYear5=new ArrayList();
		ArrayList arryBrood=new ArrayList();
		double dbltotEgg=0.00;
		boolean dbltotEggFlag=true;
		double dblsold[]=new double[5];
		
		java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.	setGroupingUsed(false);
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		String strsel_poultry="";
		
		String strpagefrom = Helper.correctNull((String)hshValues.get("strpagefrom"));
		 
		String prd_type = FwHelper.correctNull((String)hshValues.get("strProductType"));
		
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = FwHelper.correctNull((String)hshValues.get("schemetype"));
		}
		
		String strFacSno = FwHelper.correctNull((String)hshValues.get("hidFacSNo"));
		
		HashMap hshScheme = new HashMap();
		hshScheme = Helper.splitScheme(prd_type);
		if(hshScheme!=null)
		{
			strFacSno = Helper.correctNull((String)hshScheme.get("facility_sno"));
			prd_type = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
		}
		
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = FwHelper.correctNull((String)hshValues.get("strschemetype"));
			strFacSno = FwHelper.correctNull((String)hshValues.get("strschemesno"));
		}
		
		String appno= FwHelper.correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = FwHelper.correctNull((String)hshValues.get("strappno"));
		}
	    String PageType=FwHelper.correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
        {
        	 PageType=FwHelper.correctNull((String)hshValues.get("hidpagetype"));
        }
       double dbl_Totnobatch=0.00;
		try 
		{		
			
			String totsalebirds="",totsalemanure="",totsalebag="",totsaleegg="";
			strQuery = SQLParser.getSqlQuery("agr_get_poultrybroifindata^"+appno+ "^" +prd_type);
			strQuery=strQuery+"and agr_facsno="+strFacSno;
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) 
			{
				totsalebirds=FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totsaleegg")));
				totsalemanure=FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totsalemanure")));
				totsalebag=FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_totsalebag")));
				totsaleegg=FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_eggperbatach")));
				dbl_Totnobatch=Double.parseDouble(FwHelper.correctDouble(rs1.getString("poultry_totnobatch")));//added by ganesank
			}
			if(rs1!=null){
				rs1.close();
			}
			if("".equals(totsalebirds))totsalebirds="0.00";
			if("".equals(totsalemanure))totsalemanure="0.00";
			if("".equals(totsalebag))totsalebag="0.00";
			if("".equals(totsaleegg))totsaleegg="0.00";
		
			
			String count="";
			int c=0;
			strQuery = SQLParser.getSqlQuery("sel_poultry_exp_facno^" + appno+ "^" +prd_type+"^S"+"^"+strFacSno);
			 rs2=DBUtils.executeQuery(strQuery);
			 while(rs2.next()) 
			{
				
				 count=(FwHelper.correctDouble((String)rs2.getString("poultry_sno")));
				arryColEgg = new ArrayList();
				
				arryColEgg.add(FwHelper.formatDoubleValue(FwHelper.parseDouble((FwHelper.correctDouble((String)rs2.getString("poultry_iyearegg"))))));
				dbltotEgg=dbltotEgg+Double.parseDouble(FwHelper.correctDouble(rs2.getString(("poultry_iyearegg"))));
								
				arryColEgg.add(FwHelper.formatDoubleValue(FwHelper.parseDouble((FwHelper.correctDouble((String)rs2.getString("poultry_iiyearegg"))))));
				dbltotEgg=dbltotEgg+Double.parseDouble(FwHelper.correctDouble(rs2.getString(("poultry_iiyearegg"))));
				
				arryColEgg.add(FwHelper.formatDoubleValue(FwHelper.parseDouble((FwHelper.correctDouble((String)rs2.getString("poultry_iiiyearegg"))))));
				dbltotEgg=dbltotEgg+Double.parseDouble(FwHelper.correctDouble(rs2.getString(("poultry_iiiyearegg"))));
				
				arryColEgg.add(FwHelper.formatDoubleValue(FwHelper.parseDouble((FwHelper.correctDouble((String)rs2.getString("poultry_ivyearegg"))))));
				dbltotEgg=dbltotEgg+Double.parseDouble(FwHelper.correctDouble(rs2.getString(("poultry_ivyearegg"))));
				
				arryColEgg.add(FwHelper.formatDoubleValue(FwHelper.parseDouble((FwHelper.correctDouble((String)rs2.getString("poultry_vyearegg"))))));
				dbltotEgg=dbltotEgg+Double.parseDouble(FwHelper.correctDouble(rs2.getString(("poultry_vyearegg"))));
				
			}
			 
			 if(rs1!=null){rs1.close();}	
				
				strQuery = SQLParser.getSqlQuery("agr_get_poultrytechdata^"+appno+ "^" +prd_type);
				strQuery=strQuery+"and agr_facsno="+strFacSno;
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					 strsel_poultry=FwHelper.correctNull(rs1.getString("poultry_poultrytype"));
					 hshRecord.put("poultry_poultrytype", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("poultry_poultrytype"))));
				}
				 if(rs1!=null){rs1.close();}
				 if(rs2!=null){
						rs2.close();
					}
			 int k=0;
			 
			 if(!strsel_poultry.equalsIgnoreCase("3"))
			 {
			 arryColEgg = new ArrayList();
			 strQuery = SQLParser.getSqlQuery("agr_broiselflockrep_facno^" + appno+ "^" +prd_type+"^"+strFacSno);
			 rs2=DBUtils.executeQuery(strQuery);
			 while(rs2.next()) 
			 {
				 if(k<5){
					arryCol2.add(rs2.getString("agr_batch"));
					arryColEgg.add(rs2.getString("agr_totalincome"));
					dblsold[k]=FwHelper.parseDouble(Helper.correctDouble(rs2.getString("agr_patchsold")));
					k++;
				 }
			 }
			 }
			if(rs2!=null){
				rs2.close();
			}
			if(dblsold.length<5)
			{
				for(int j=dblsold.length;j<5;j++)
				{
					dblsold[j]=0.00;
				}
			}
			 if(arryCol2!=null && arryCol2.size()<5)
				{
					hshRecord.put("nodata","Y");
					for(int j=arryCol2.size();j<5;j++)
					arryCol2.add("0.00");
				}
			 if(arryColEgg!=null && arryColEgg.size()<5)
				{
					hshRecord.put("nodata","Y");
					for(int j=arryColEgg.size();j<5;j++)
						arryColEgg.add("0.00");
				}
			 
			 
			 for(int i=0;i<5;i++)
				{
				 if(!strsel_poultry.equalsIgnoreCase("3"))
				 {
					 dbl_Totnobatch=dblsold[i];
				 }
				 arrSalebirds.add(nf.format(FwHelper.parseDouble(totsalebirds)*(dbl_Totnobatch)));
				 if(!strsel_poultry.equalsIgnoreCase("1"))
				 {
				 arrSalemanure.add(nf.format(dbl_Totnobatch*FwHelper.parseDouble(totsalemanure)));
				 arrSalebag.add(nf.format(dbl_Totnobatch*FwHelper.parseDouble(totsalebag)));
				 }
				 else
				 {
					 arrSalemanure.add("0.00");
					 arrSalebag.add("0.00");
					 
				 }
				 if(strsel_poultry.equalsIgnoreCase("3")&&(arryColEgg!=null))
				 {				 
					 arrSalesEgg.add(nf.format(dbl_Totnobatch*FwHelper.parseDouble((String)arryColEgg.get(i))));
				 }
				 else if(!strsel_poultry.equalsIgnoreCase("3")&&(arryColEgg!=null))
				 {				 
					 arrSalesEgg.add(nf.format(FwHelper.parseDouble((String)arryColEgg.get(i))));
				 }
				 else
				 {
					 arrSalesEgg.add("0.00");
					 
				 }
				}
			 /********eggs********/
				hshRecord.put("arrSalebirds",arrSalebirds);
				hshRecord.put("arrSalemanure",arrSalemanure);
				hshRecord.put("arrSalebag",arrSalebag);
				hshRecord.put("arrSalesEgg",arrSalesEgg);
				
				if(arrSalebirds.size()<5)
				{
					arrSalebirds.add("0.00");
					arrSalebirds.add("0.00");
					arrSalebirds.add("0.00");
					arrSalebirds.add("0.00");
					arrSalebirds.add("0.00");}
				if(arrSalemanure.size()<5)
				{
					arrSalemanure.add("0.00");
					arrSalemanure.add("0.00");
					arrSalemanure.add("0.00");
					arrSalemanure.add("0.00");
					arrSalemanure.add("0.00");
				}
				if(arrSalebag.size()<5)
				{
					arrSalebag.add("0.00");
					arrSalebag.add("0.00");
					arrSalebag.add("0.00");
					arrSalebag.add("0.00");
					arrSalebag.add("0.00");
				}
				if(arrSalesEgg.size()<5)
				{
					arrSalesEgg.add("0.00");
					arrSalesEgg.add("0.00");
					arrSalesEgg.add("0.00");
					arrSalesEgg.add("0.00");
					arrSalesEgg.add("0.00");
				}
				
			 strQuery = SQLParser.getSqlQuery("sel_poultry_income^" + appno+ "^" +prd_type);
			 strQuery=strQuery+"and agr_facsno="+strFacSno;
			 rs2 = DBUtils.executeQuery(strQuery);
				while (rs2.next())
				{
					arryCol1 = new ArrayList();
					arryCol1.add(rs2.getString("poultry_expenses"));
					arryCol1.add(rs2.getString("poultry_iyear"));
					arryCol1.add(rs2.getString("poultry_iiyear"));
					arryCol1.add(rs2.getString("poultry_iiiyear"));
					arryCol1.add(rs2.getString("poultry_type"));
					arryCol1.add(rs2.getString("poultry_ivyear"));
					arryCol1.add(rs2.getString("poultry_vyear"));
					arryRow1.add(arryCol1);
					arrCalYear1.add(rs2.getString("poultry_iyear"));
					arrCalYear2.add(rs2.getString("poultry_iiyear"));
					arrCalYear3.add(rs2.getString("poultry_iiiyear"));
					arrCalYear4.add(rs2.getString("poultry_ivyear"));
					arrCalYear5.add(rs2.getString("poultry_vyear"));
				}
				if(rs2!=null){
					rs2.close();
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
				if(arrCalYear4.size()<3)
				{
					arrCalYear4.add("0.00");
					arrCalYear4.add("0.00");
					arrCalYear4.add("0.00");
				}
				if(arrCalYear5.size()<3)
				{
					arrCalYear5.add("0.00");
					arrCalYear5.add("0.00");
					arrCalYear5.add("0.00");
				}
		 hshRecord.put("arryRow1",arryRow1);
		 
		 strQuery = SQLParser.getSqlQuery("sel_poultry_expenditure^" + appno+ "^" +prd_type);
		 strQuery=strQuery+"and agr_facsno="+strFacSno;
		 rs1 = DBUtils.executeQuery(strQuery);
		if (rs1.next()) 
		{
				hshRecord.put("txt_expenseyear1", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("totiyearexpenses"))));
				hshRecord.put("txt_expenseyear2", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("totiiyearexpenses"))));
				hshRecord.put("txt_expenseyear3", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("totiiiyearexpenses"))));
				hshRecord.put("totiyearbank", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("totiyearbank"))));
				hshRecord.put("totiiyearbank", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("totiiyearbank"))));
				hshRecord.put("totiiiyearbank", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("totiiiyearbank"))));
				hshRecord.put("totiyearlastexp", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("totiyearlastexp"))));
				hshRecord.put("totiiyearlastexp", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("totiiyearlastexp"))));
				hshRecord.put("totiiiyearlastexp", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("totiiiyearlastexp"))));
				hshRecord.put("totivyearlastexp", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("totivyearlastexp"))));
				hshRecord.put("totvyearlastexp", FwHelper.correctDoubleQuote(FwHelper.correctNull(rs1.getString("totvyearlastexp"))));
			
		}
		if(rs1!=null){
			rs1.close();
		}	
		
		
		
		
		double totalIncome1=FwHelper.parseDouble(FwHelper.correctDouble((String)arrSalebirds.get(0)))+FwHelper.parseDouble(FwHelper.correctDouble((String)arrSalemanure.get(0)))
					+FwHelper.parseDouble(FwHelper.correctDouble((String)arrSalebag.get(0)))+FwHelper.parseDouble((String)arrCalYear1.get(0))+
					FwHelper.parseDouble((String)arrCalYear1.get(1))+FwHelper.parseDouble((String)arrCalYear1.get(2))+
					FwHelper.parseDouble((String)arrSalesEgg.get(0));
		totalIncome1	= Double.parseDouble(nf.format(totalIncome1));
		
		double totalIncome2=FwHelper.parseDouble(FwHelper.correctDouble((String)arrSalebirds.get(1)))+FwHelper.parseDouble(FwHelper.correctDouble((String)arrSalemanure.get(1)))
					+FwHelper.parseDouble(FwHelper.correctDouble((String)arrSalebag.get(1)))+FwHelper.parseDouble(FwHelper.correctDouble((String)arrCalYear2.get(0)))+
					FwHelper.parseDouble(FwHelper.correctDouble((String)arrCalYear2.get(1)))+FwHelper.parseDouble(FwHelper.correctDouble((String)arrCalYear2.get(2)))+
					FwHelper.parseDouble((String)arrSalesEgg.get(1));
		totalIncome2	= Double.parseDouble(nf.format(totalIncome2));
		
		double totalIncome3=FwHelper.parseDouble(FwHelper.correctDouble((String)arrSalebirds.get(2)))+FwHelper.parseDouble(FwHelper.correctDouble((String)arrSalemanure.get(2)))
					+FwHelper.parseDouble(FwHelper.correctDouble((String)arrSalebag.get(2)))+FwHelper.parseDouble(FwHelper.correctDouble((String)arrCalYear3.get(0)))+
					FwHelper.parseDouble(FwHelper.correctDouble((String)arrCalYear3.get(1)))+FwHelper.parseDouble(FwHelper.correctDouble((String)arrCalYear3.get(2)))+
					FwHelper.parseDouble((String)arrSalesEgg.get(2));
		totalIncome3	= Double.parseDouble(nf.format(totalIncome3));
		
		double totalIncome4=FwHelper.parseDouble(FwHelper.correctDouble((String)arrSalebirds.get(3)))+FwHelper.parseDouble(FwHelper.correctDouble((String)arrSalemanure.get(3)))
		+FwHelper.parseDouble(FwHelper.correctDouble((String)arrSalebag.get(3)))+FwHelper.parseDouble(FwHelper.correctDouble((String)arrCalYear4.get(0)))+
		FwHelper.parseDouble(FwHelper.correctDouble((String)arrCalYear4.get(1)))+FwHelper.parseDouble(FwHelper.correctDouble((String)arrCalYear4.get(2)))+
		FwHelper.parseDouble((String)arrSalesEgg.get(3));
		totalIncome4	= Double.parseDouble(nf.format(totalIncome4));

		double totalIncome5=FwHelper.parseDouble(FwHelper.correctDouble((String)arrSalebirds.get(4)))+FwHelper.parseDouble(FwHelper.correctDouble((String)arrSalemanure.get(4)))
		+FwHelper.parseDouble(FwHelper.correctDouble((String)arrSalebag.get(4)))+FwHelper.parseDouble(FwHelper.correctDouble((String)arrCalYear5.get(0)))+
		FwHelper.parseDouble(FwHelper.correctDouble((String)arrCalYear5.get(1)))+FwHelper.parseDouble(FwHelper.correctDouble((String)arrCalYear5.get(2)))+
		FwHelper.parseDouble((String)arrSalesEgg.get(4));
		totalIncome5	= Double.parseDouble(nf.format(totalIncome5));
		
		double totalExp11=FwHelper.parseDouble(FwHelper.correctDouble((String)hshRecord.get("totiyearlastexp")));
		totalExp11	= Double.parseDouble(nf.format(totalExp11));
		double totalExp12=FwHelper.parseDouble(FwHelper.correctDouble((String)hshRecord.get("totiiyearlastexp")));
		totalExp12	= Double.parseDouble(nf.format(totalExp12));
		double totalExp13=FwHelper.parseDouble(FwHelper.correctDouble((String)hshRecord.get("totiiiyearlastexp")));
		totalExp13	= Double.parseDouble(nf.format(totalExp13));
		
		double totalExp14=FwHelper.parseDouble(FwHelper.correctDouble((String)hshRecord.get("totivyearlastexp")));
		totalExp14	= Double.parseDouble(nf.format(totalExp14));
		
		double totalExp15=FwHelper.parseDouble(FwHelper.correctDouble((String)hshRecord.get("totvyearlastexp")));
		totalExp15	= Double.parseDouble(nf.format(totalExp15));
		
		double dblsurplus1=totalIncome1-totalExp11;
		dblsurplus1	= Double.parseDouble(nf.format(dblsurplus1));
		String surplus1=nf.format(dblsurplus1);
		double dblsurplus2=totalIncome2-totalExp12;
		dblsurplus2	= Double.parseDouble(nf.format(dblsurplus2));
		String surplus2=nf.format(dblsurplus2);
		double dblsurplus3=totalIncome3-totalExp13;
		dblsurplus3	= Double.parseDouble(nf.format(dblsurplus3));
		String surplus3=nf.format(dblsurplus3);
		
		double dblsurplus4=totalIncome4-totalExp14;
		dblsurplus4	= Double.parseDouble(nf.format(dblsurplus4));
		String surplus4=nf.format(dblsurplus3);
		
		double dblsurplus5=totalIncome5-totalExp15;
		dblsurplus5	= Double.parseDouble(nf.format(dblsurplus5));
		String surplus5=nf.format(dblsurplus5);
		 
		if(!strpagefrom.equalsIgnoreCase("FarmBudget"))
		{
		 	HashMap hshQueryValues=new HashMap();
		 	HashMap hshQuery=new HashMap();
		 	ArrayList arrValues=new ArrayList();
		 	hshQueryValues.put("size","2");
			hshQuery.put("strQueryId","del_poultry_income");
			arrValues.add(appno);
			arrValues.add(prd_type);
			arrValues.add(strFacSno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			arrValues.add(appno);
			arrValues.add(String.valueOf(surplus1));
			arrValues.add(String.valueOf(surplus2));
			arrValues.add(String.valueOf(surplus3));
			arrValues.add(String.valueOf(surplus4));
			arrValues.add(String.valueOf(surplus5));
			arrValues.add(String.valueOf(surplus3));
			arrValues.add(String.valueOf(surplus3));
			arrValues.add(String.valueOf(surplus3));
			arrValues.add(prd_type);
			arrValues.add(strFacSno);
			
			hshQueryValues.put("size", "2");
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "ins_poultry_income");
			hshQueryValues.put("2", hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");  
		}
			
			hshRecord.put("surplus1",String.valueOf(surplus1));
			hshRecord.put("surplus2",String.valueOf(surplus2));
			hshRecord.put("surplus3",String.valueOf(surplus3));
			hshRecord.put("surplus4",String.valueOf(surplus4));
			hshRecord.put("surplus5",String.valueOf(surplus5));
			
			hshRecord.put("totalIncome1",String.valueOf(totalIncome1));
			hshRecord.put("totalIncome2",String.valueOf(totalIncome2));
			hshRecord.put("totalIncome3",String.valueOf(totalIncome3));
			hshRecord.put("totalIncome4",String.valueOf(totalIncome4));
			hshRecord.put("totalIncome5",String.valueOf(totalIncome5));
		
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
				}				
			}
			
			catch (Exception e)
			{	
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}
	
	
	public HashMap getAssessment(HashMap hshValues)
	{
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		String strAppNo="";
		String strQuery="";
		String strAppStatus="";
		String strSchemeType="",strSchemeFacSno="";
		String strApptype="";
		String strProductCode="";
		String strValuesin="0";
		HashMap hshRecord=new HashMap();
		HashMap hshQuery=new HashMap();
		HashMap hshhmesteadass=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrAgriMobile=new ArrayList();
		ArrayList arrFarmMech=new ArrayList();
		ArrayList arrMinorIrr=new ArrayList();
		ArrayList arrAgriLand=new ArrayList();
		ArrayList arrPlantation=new ArrayList();
		ArrayList arrLandDev=new ArrayList();
		ArrayList arrWareHouse=new ArrayList();
		ArrayList arrDairyFarm=new ArrayList();
		ArrayList arrFkcc = new ArrayList();
		ArrayList arrAMTL=new ArrayList();
		ArrayList arrSHG=new ArrayList();
		ArrayList arrValues=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=new ArrayList();
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rsScheme=null;
		ResultSet rsAssType=null;
		double dblrequestedAmount=0.00;
		double dblMargin=0.00;
		double dblTotalEligibleLoanAmount=0.00;
		ArrayList arrAlliedAss=new ArrayList();
		ArrayList arrRow1=new ArrayList();
		
		try
		{
			strAppNo=correctNull((String)hshValues.get("strappno"));
			if(strAppNo.trim().equalsIgnoreCase(""))
			{
				strAppNo=correctNull((String)hshValues.get("appno"));
			}
			if(strAppNo.trim().equalsIgnoreCase(""))
			{
				strAppNo=correctNull((String)hshValues.get("strAppno"));
			}

			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("getagrvaluesin^"+strAppNo);
			if (rs.next())
			{
				strValuesin=Helper.correctNull((String)rs.getString("app_valuesin"));
			}
			if(rsAssType!=null)
			{
				rsAssType.close();
			}
			rsAssType = DBUtils.executeLAPSQuery("com_assessmentselection_select^"+ strAppNo);
			
			if (rsAssType.next()) {

				String strassesttype = correctNull((String) rsAssType.getString("COM_ASSESSMENTTYPE"));
				StringTokenizer strassesttypesplit = new StringTokenizer(strassesttype, "@");
				while (strassesttypesplit.hasMoreTokens()) {
					String strfinalassesttype = (String) strassesttypesplit
							.nextToken();

			if(strfinalassesttype.equalsIgnoreCase("FB"))
			{
			/*Scheme Specific Assessment*/
			if(rsScheme!=null)
			{
				rsScheme.close();
			}
			rsScheme=DBUtils.executeLAPSQuery("sel_agriculture_facilities^"+strAppNo);
			while(rsScheme.next())
			{
				strSchemeType=Helper.correctNull((String)rsScheme.getString("facility_agrschemetype"));
				strSchemeFacSno=Helper.correctNull((String)rsScheme.getString("facility_sno"));
				strProductCode=Helper.correctNull((String)rsScheme.getString("facility_code"));
				arrRow=new ArrayList();
				
				/*Farm Mechanisation*/
				if(strSchemeType.trim().equalsIgnoreCase("aM"))
				{
					double dblincome=0.00;
					double dblNetincome=0.00;
					double dblTotalIncome=0.00;
					double dbldepriciationpercent=0.00;
					double dblProjectCost=0.00;
					double dbldepricilesscost=0.00;
					double dblEligibleAmount=0.00;
					double dblLoanAmt=0.00,dblLoanAmtinLakhs=0.00;
					String strLoanamt="",strMargin="",strFacilityCode="0",strAmount="0";
					arrRow=new ArrayList();
					arrRow.add("Farm Mechanisation");//0
					arrRow.add("Economic Viability");//1
					arrRow.add(" Incremental income after investment (I item)");//2
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("agrcropassessment_select^"+strAppNo+"^"+strSchemeType+"^"+strSchemeFacSno);
					if(rs.next())
					{
						dblincome=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("agr_cas_amount")));
					}
					arrRow.add(String.valueOf(dblincome));//3
					arrRow.add("Out of which income from machinery(II item)");//4
					
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("agrincomehireserv_select^"+strAppNo+"^"+strSchemeFacSno+"^"+strSchemeType);
					if(rs.next())
					{
						dblNetincome=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("agr_ihs_netincome")));
					}
					arrRow.add(String.valueOf(dblNetincome));//5
					arrRow.add("Total incremental income (I+II)");//6
					dblTotalIncome=dblincome+dblNetincome;
					arrRow.add(String.valueOf(dblTotalIncome));//7
					arrRow.add("Depreciation at");//8
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("agrfarmmachinery_select^"+strAppNo+"^"+strSchemeFacSno+"^"+strSchemeType);
					if(rs.next())
					{
						dbldepriciationpercent=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("agr_fam_depriciation")));
					}
					arrRow.add(String.valueOf(dbldepriciationpercent));//9
					rs=DBUtils.executeLAPSQuery("sel_agriculture_facilities_scheme^"+strAppNo+"^"+strSchemeType+"^"+strSchemeFacSno);		 
					if(rs.next())
					{
						dblrequestedAmount=FwHelper.parseDouble(Helper.correctDouble(rs.getString("facility_proposed")));
						//dblrequestedAmount=dblrequestedAmount*100000.00;
						//dblProjectCost=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("facility_proposed")));
						dblProjectCost=dblrequestedAmount;
						dblLoanAmt=dblProjectCost;
					}
					hshRecord.put("appno",strAppNo);
					double dbldepriciationcost=dblProjectCost*(dbldepriciationpercent/100);
					dbldepricilesscost=dblProjectCost-(dbldepriciationcost);
					strAmount=Helper.convertApplicationToSetup(strValuesin,dblLoanAmt);
					dblLoanAmtinLakhs=Double.parseDouble(strAmount);
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("getagrfacilitycode^"+strAppNo+"^"+strSchemeType);
					if(rs.next())
					{
						strFacilityCode=Helper.correctNull((String)rs.getString("facility_code"));
					}
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("getfacilityMargin^"+strFacilityCode+"^"+dblLoanAmtinLakhs+"^"+dblLoanAmtinLakhs);
					if(rs.next())
					{
						strMargin=Helper.correctNull((String)rs.getString("margin_perct"));
						dblMargin=Double.parseDouble(strMargin);
						//hshRecord.put("MarginPercent", Helper.correctDouble(strMargin));
					}
					dblProjectCost=dblProjectCost-(dblProjectCost*(dblMargin/100));
					dblEligibleAmount =Math.min(dblrequestedAmount,dblProjectCost);
					
					hshRecord.put("dbldepricilesscost",String.valueOf(dbldepricilesscost));
					arrRow.add(String.valueOf(dbldepriciationcost));//10
					arrRow.add("Surplus after depreciation");//11
					double dblSurplus=dblTotalIncome-dbldepriciationcost;
					arrRow.add(String.valueOf(dblSurplus));//12
					arrRow.add("Assessment");//13
					arrRow.add("Amount Of Loan Applied (A)");//14
					arrRow.add(jtn.format(dblrequestedAmount));//15
					arrRow.add("Farm Mechaniaation Cost(Less "+strMargin+"% Margin) (B)");//16
					arrRow.add(String.valueOf(dblProjectCost));//17
					arrRow.add("Eligibility As Per Assessment");//18
					
					arrRow.add(String.valueOf(dblEligibleAmount));//19
					dblTotalEligibleLoanAmount+=dblEligibleAmount;
					arrFarmMech.add(arrRow);
				}
				/*Minor Irrigation*/
				if(strSchemeType.trim().equalsIgnoreCase("aO"))
				{
					double dblNetincome=0.00;
					double dblElectricWorks=0.00;
					double dblWaterProposed=0.00;
					double dblNetAmt=0.00;
					double dblAddIncome=0.00;
					double dblProjectCost=0.00;
					double dblEligibleAmount=0.00;
					double dblIncome=0.00;
					String strLoanamt="",strMargin="",strFacilityCode="0",strAmount="0";
					double dblLoanAmt=0.00,dblLoanAmtinLakhs=0.00;
					arrRow=new ArrayList();
					arrRow.add("Minor Irrigation");//0
					arrRow.add("Economic Viability");//1
					arrRow.add("Net Incremental Income from Cropping (A) ");//2
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("agrcropassessment_select^"+strAppNo+"^"+strSchemeType+"^"+strSchemeFacSno);
					if(rs.next())
					{
						dblIncome=FwHelper.parseDouble((String)rs.getString("agr_cas_amount"));
						dblNetincome=FwHelper.parseDouble((String)rs.getString("agr_cas_amount"));
					}
					arrRow.add(String.valueOf(dblIncome));//3
					arrRow.add("Maintenance and Repair Charges including Fuel, Electricity charges per annum (D)");//4
					rs=DBUtils.executeLAPSQuery("agr_minorirrigation_select_assessment^"+strAppNo+"^"+strSchemeType+"^"+strSchemeFacSno);
					if(rs.next())
					{
						dblWaterProposed=Double.parseDouble(Helper.correctDouble((String)rs.getString("agr_waterproposedinc")));
						dblNetAmt=Double.parseDouble(Helper.correctDouble((String)rs.getString("agr_netamount")));
						dblAddIncome=Double.parseDouble(Helper.correctDouble((String)rs.getString("agr_exp_additional_income")));
						dblElectricWorks=Double.parseDouble(Helper.correctDouble((String)rs.getString("agr_elecWorks")));
						dblNetincome=dblNetincome+FwHelper.parseDouble((String)rs.getString("agr_waterproposedinc"))+
						FwHelper.parseDouble((String)rs.getString("agr_netamount"))+
						FwHelper.parseDouble((String)rs.getString("agr_exp_additional_income"))-
						FwHelper.parseDouble((String)rs.getString("agr_elecWorks"));
					}
					arrRow.add(String.valueOf(dblElectricWorks));//5
					arrRow.add("Net income from Sale of Water (B)");//6
					arrRow.add(String.valueOf(dblWaterProposed));//7
					arrRow.add("Income from other sources (C)");//8
					arrRow.add(String.valueOf(dblNetAmt));//9
					arrRow.add("Expected additional income after proposed development (E)");//10
					arrRow.add(String.valueOf(dblAddIncome));//11
					arrRow.add("Net Income per annum ((A + B + C + E) - D )");//12
					arrRow.add(String.valueOf(dblNetincome));//13
					arrRow.add("Assessment");//14
					arrRow.add("Amount of Loan Applied (A)");//15
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("sel_agriculture_facilities_scheme^"+strAppNo+"^"+strSchemeType+"^"+strSchemeFacSno);
					if(rs.next())
					{
						dblrequestedAmount=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("facility_proposed")));
						//dblrequestedAmount=dblrequestedAmount*100000.00;
						dblProjectCost=dblrequestedAmount;
						dblLoanAmt=dblProjectCost;
					}
					arrRow.add(String.valueOf(dblrequestedAmount));//16
					arrRow.add("Project Cost less margin at");//17
					strAmount=Helper.convertApplicationToSetup(strValuesin,dblLoanAmt);
					dblLoanAmtinLakhs=Double.parseDouble(strAmount);
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("getagrfacilitycode^"+strAppNo+"^"+strSchemeType);
					if(rs.next())
					{
						strFacilityCode=Helper.correctNull((String)rs.getString("facility_code"));
					}
				if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("getfacilityMargin^"+strFacilityCode+"^"+dblLoanAmtinLakhs+"^"+dblLoanAmtinLakhs);
					if(rs.next())
					{
						strMargin=Helper.correctNull((String)rs.getString("margin_perct"));
						dblMargin=Double.parseDouble(strMargin);
						hshRecord.put("MarginPercent", Helper.correctDouble(strMargin));
					}
					/*if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("agr_minorirrigation_select^"+strAppNo);	
					if(rs.next())
					{
						hshRecord.put("MarginPercent", Helper.correctDouble((String)rs.getString("agr_margin")));
						dblMargin=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("agr_margin")));
					}*/
					arrRow.add(String.valueOf(dblMargin));//18
					dblProjectCost=dblProjectCost-(dblProjectCost*(dblMargin/100));
					dblEligibleAmount =Math.min(dblrequestedAmount,dblProjectCost);
					arrRow.add(" % (B)");//19
					arrRow.add(String.valueOf(dblProjectCost));//20
					arrRow.add("Eligibility As Per Assessment(Least of the A & B)");//21
					dblEligibleAmount =Math.min(dblEligibleAmount,dblProjectCost);
					arrRow.add(String.valueOf(dblEligibleAmount));//22
					dblTotalEligibleLoanAmount+=dblEligibleAmount;
					arrMinorIrr.add(arrRow);
				}
				

				
				/*******/
				
				/*Plantation*/
				/*if(strSchemeType.trim().equalsIgnoreCase("aH"))
				{
					double dblEligibleAmount=0.00;
					arrRow=new ArrayList();
					arrRow.add("Plantation");//0
					arrRow.add("Amount Of Loan Applied (A)");//1
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("sel_agriculture_facilities_scheme^"+strAppNo+"^"+strSchemeType+"^"+strSchemeFacSno);
					if(rs.next())
					{
						dblrequestedAmount=FwHelper.parseDouble(Helper.correctDouble(rs.getString("facility_proposed")));
						dblrequestedAmount=dblrequestedAmount*100000.00;
					}
					arrRow.add(jtn.format(dblrequestedAmount));//2
					arrRow.add("Total Cost of Cultivation less Margin(B)");//3
					double dblcultivationcost=0;
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("agr_hortiyearcultivationcost_sumbankloan_select^"+strAppNo);
					if(rs.next())
					{
						dblcultivationcost=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("agr_horti_bankloan")));
						
					}
					arrRow.add(String.valueOf(dblcultivationcost));//4
					arrRow.add("Eligibility as per Assessment (Min of A&B)");//5
					dblEligibleAmount =Math.min(dblrequestedAmount,dblcultivationcost);
					arrRow.add(String.valueOf(dblEligibleAmount));//6
					dblTotalEligibleLoanAmount+=dblEligibleAmount;
					arrPlantation.add(arrRow);
				}*/
				/*Land Development*/
				if(strSchemeType.trim().equalsIgnoreCase("aV"))
				{
					String strselSlope="";
					String strSelInches="";
					String strSelSoil="";
					arrRow=new ArrayList();
					double dbldevelopacre=0.00;
					double dbllevelhectare=0.00;
					double dblEligibleAmount=0.00;
					String strLoanamt="",strMargin="",strFacilityCode="0",strAmount="0";
					double dblLoanAmt=0.00,dblLoanAmtinLakhs=0.00;
					arrRow.add("Land Development");//0
					arrRow.add("Cost of Land Leveling");//1
					arrRow.add("Land Leveling Cost");//2
					arrRow.add("% Margin");//3
					arrRow.add("Total Leveling Cost less margin(I)");//4
					arrRow.add("Cost of Land/Sand Casting");//5
					arrRow.add("Land/Sand Casting Cost");//6
					arrRow.add("Total Land/Sand Casting Cost less margin(II)");//7
					arrRow.add("Cost of Refixing Of Soil On Eroded Lands");//8
					arrRow.add("Refixing Of Soil On Eroded Lands Cost");//9
					arrRow.add("Total Refixing Of Soil On Eroded Lands cost less margin(III)");//10
					arrRow.add("Cost of Soil Reclamation ");//11
					arrRow.add("Reclamation Of Soil Cost");//12
					arrRow.add("Total Reclamation Of Soil Cost less margin(III)");//13
					arrRow.add("Assessment ");//14
					arrRow.add("Amount of Loan Applied (A)");//15
					arrRow.add("Total Land Development Cost (B)");//16
					arrRow.add("Eligibility as per Assessment (min A & B)");//17
					
					if(rs!=null)
					{
						rs.close();
					}
					rs = DBUtils.executeLAPSQuery("agr_landdevelop_assessparam_select^"+strAppNo+"^"+strSchemeType+"^"+strSchemeFacSno);
					if(rs.next())
					{
						strselSlope=correctNull((String)rs.getString("agr_landdevelop_slope"));
						strSelInches=correctNull((String)rs.getString("agr_landdevelop_inches"));
						strSelSoil=correctNull((String)rs.getString("agr_landdevelop_soiltype"));
						dbldevelopacre=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("agr_landdeveloped")));
						dbllevelhectare=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("agr_noofhectare")));
					}	
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("sel_agriculture_facilities_scheme^"+strAppNo+"^"+strSchemeType+"^"+strSchemeFacSno);	 
					if(rs.next())
					{
						dblrequestedAmount=FwHelper.parseDouble(Helper.correctDouble(rs.getString("facility_proposed")));
						dblLoanAmt=dblrequestedAmount;
						//dblrequestedAmount=dblrequestedAmount*100000.00;
					}
					arrRow.add(jtn.format(dblrequestedAmount));//18
					strAmount=Helper.convertApplicationToSetup(strValuesin,dblLoanAmt);
					dblLoanAmtinLakhs=Double.parseDouble(strAmount);
					if(rs!=null)
					{
						rs.close();
					}
					strQuery=SQLParser.getSqlQuery("getfacilityMargin^"+strFacilityCode+"^"+dblLoanAmtinLakhs+"^"+dblLoanAmtinLakhs);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						dblMargin=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("margin_perct")));
					}
					strAmount=Helper.convertApplicationToSetup(strValuesin,dblLoanAmt);
					dblLoanAmtinLakhs=Double.parseDouble(strAmount);
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("getagrfacilitycode^"+strAppNo+"^"+strSchemeType);
					if(rs.next())
					{
						strFacilityCode=Helper.correctNull((String)rs.getString("facility_code"));
					}
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("getfacilityMargin^"+strFacilityCode+"^"+dblLoanAmtinLakhs+"^"+dblLoanAmtinLakhs);
					if(rs.next())
					{
						strMargin=Helper.correctNull((String)rs.getString("margin_perct"));
						dblMargin=Double.parseDouble(strMargin);
						//hshRecord.put("MarginPercent", Helper.correctDouble(strMargin));
					}
					
					arrRow.add(String.valueOf(dblMargin));//19
					double dblslope1total=0,dblslope2total=0,dblslope3total=0;
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("agr_onfarmdevelopment_bysno_select^"+strAppNo+"^"+strSchemeType+"^"+strSchemeFacSno);
					if(rs.next())
					{
						dblslope1total=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("agr_slope1")));
						
					}
					double dbllandlevelingcost=0;
					dbllandlevelingcost=dblslope1total*dbllevelhectare;
					arrRow.add(String.valueOf(dbllandlevelingcost));//20
					double dblinchessix=0;
					double dblFencingCost=0;
					if(rs!=null) rs.close();
					rs=DBUtils.executeLAPSQuery("agr_sandcasting_bysno_select^"+strAppNo+"^"+strSchemeType+"^"+strSchemeFacSno);
					if(rs.next())
					{
						dblinchessix=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("agr_sixinches")));
						
					}
					if(rs!=null) rs.close();
					rs=DBUtils.executeLAPSQuery("agr_sandcasting_bysno_select^"+strAppNo+"^"+strSchemeType+"^"+strSchemeFacSno);
					if(rs.next())
					{
						dblFencingCost=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("agr_sixinches")));
					}
					double dblFencingCostMargin=0.00;
					double dblFencingCostTotal=0.00;
					dblFencingCostMargin=dblFencingCost*dblMargin/100;
					dblFencingCostTotal=dblFencingCost-dblFencingCostMargin;
					
					double dblsandcastingtotal=0;
					dblsandcastingtotal=dblinchessix*dbldevelopacre;
					arrRow.add(String.valueOf(dblsandcastingtotal));//21
					double dblSoilReclamationtotal=0;
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("agr_soilreclamation_select^"+strAppNo+"^"+strSchemeType+"^"+strSchemeFacSno);
					if(rs.next())
					{
						dblSoilReclamationtotal=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("agr_totalcost")))*dbldevelopacre;;
					}
					arrRow.add(String.valueOf(dblSoilReclamationtotal));//22
					double dbErodedLandcost=0;
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("agr_sandcastingparticulars_select_assessment^"+strAppNo+"^"+strSchemeType+"^"+strSchemeFacSno);
					if(rs.next())
					{
						dbErodedLandcost=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("agr_overalltot")))*dbldevelopacre;
					}
					arrRow.add(String.valueOf(dbErodedLandcost));//23
					double dbllandlevelingcostmargin=dbllandlevelingcost*dblMargin/100;
					arrRow.add(String.valueOf(dbllandlevelingcostmargin));//24
					arrRow.add(String.valueOf(dbllandlevelingcost-dbllandlevelingcostmargin));//25
					double dblSandCastingmargin=dblsandcastingtotal*dblMargin/100;
					arrRow.add(String.valueOf(dblSandCastingmargin));//26
					arrRow.add(String.valueOf(dblsandcastingtotal-dblSandCastingmargin));//27
					double dblErodedLandcostgmargin=dbErodedLandcost*dblMargin/100;
					arrRow.add(String.valueOf(dblErodedLandcostgmargin));//28
					arrRow.add(String.valueOf(dbErodedLandcost-dblErodedLandcostgmargin));//29
					double dblSoilReclamationcostgmargin=dblSoilReclamationtotal*dblMargin/100;
					arrRow.add(String.valueOf(dblSoilReclamationcostgmargin));//30
					arrRow.add(String.valueOf(dblSoilReclamationtotal-dblSoilReclamationcostgmargin));//31
					double dbltotalcost=0.0;
					if(rs!=null)
					{
						rs.close();
					}
					String strDryingCost="";
					double dblDryingCost=0.00;
					double dblDryingCostmargin=0.00;
					double dblDryingCostTotal=0.00;
					rs=DBUtils.executeLAPSQuery("agr_dryingyard_select^"+strAppNo+"^"+strSchemeType+"^"+strSchemeFacSno);
					if(rs.next())
					{
						strDryingCost=Helper.correctDouble((String)rs.getString("agr_cost"));
						dblDryingCost=Double.parseDouble(strDryingCost);
					}
					dblDryingCostmargin=dblDryingCost*dblMargin/100;
					dblDryingCostTotal=dblDryingCost-dblDryingCostmargin;
					dbltotalcost=dbllandlevelingcost-dbllandlevelingcostmargin+dblsandcastingtotal-dblSandCastingmargin+
								dbErodedLandcost-dblErodedLandcostgmargin+dblSoilReclamationtotal-dblSoilReclamationcostgmargin+dblDryingCostTotal+dblFencingCostTotal;
					arrRow.add(String.valueOf(dbltotalcost));//32
					dblEligibleAmount =Math.min(dblrequestedAmount, dbltotalcost);
					arrRow.add(String.valueOf(dblEligibleAmount));//33
					arrRow.add("Cost of Drying Yard");//34
					arrRow.add("Drying Yard Cost");//35
					arrRow.add("Total Drying Yard Cost less margin(IV)");//36
					arrRow.add(String.valueOf(dblDryingCost));//37
					arrRow.add(String.valueOf(dblDryingCostmargin));//38
					arrRow.add(String.valueOf(dblDryingCostTotal));//39
					arrRow.add("Cost of Fencing");//40
					arrRow.add("Fencing Cost");//41
					arrRow.add("Total Fencing Cost less margin(V)");//42
					arrRow.add(String.valueOf(dblFencingCost));//43
					arrRow.add(String.valueOf(dblFencingCostMargin));//44
					arrRow.add(String.valueOf(dblFencingCostTotal));//45
					dblTotalEligibleLoanAmount+=dblEligibleAmount;
					
					arrLandDev.add(arrRow);
				}
				
				/*Advance Against Warehouse Receipt*/
				if(strSchemeType.trim().equalsIgnoreCase("aK"))
				{
					HashMap hshCAPTL=new HashMap();
					double dblMarketValue=0.00;
					double dblEligibleAmount=0.00;
					double dblLoanAmt=0.00,dblLoanAmtinLakhs=0.00;
					String strLoanamt="",strMargin="",strFacilityCode="0",strAmount="0";
					arrRow=new ArrayList();
					arrRow.add("Advance Against Warehouse Receipt");//0
					arrRow.add("Assessment");//1
					arrRow.add("Amount Of Loan Applied (A)");//2
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("sel_agriculture_facilities_scheme^"+strAppNo+"^"+strSchemeType+"^"+strSchemeFacSno);
					if(rs.next())
					{
						dblrequestedAmount=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("facility_proposed")));
						//dblrequestedAmount=dblrequestedAmount*100000.00;
						dblLoanAmt=dblrequestedAmount;
					}
					arrRow.add(jtn.format(dblrequestedAmount));//3
					arrRow.add("Total Value of Produce(B)");//4
					
					hshCAPTL=new AgrLandHoldingsBO().getCPLDataByAppno(strAppNo,strSchemeType,strSchemeFacSno);
					
					double dblsupportprice=0,dblnoofunits=0.0,dblminimumeligible=0.0;
					
					dblMarketValue=FwHelper.parseDouble(Helper.correctDouble((String)hshCAPTL.get("capl_marketrate")));
					dblsupportprice=FwHelper.parseDouble(Helper.correctDouble((String)hshCAPTL.get("capl_marketvalue")));
					dblnoofunits=FwHelper.parseDouble(Helper.correctDouble((String)hshCAPTL.get("capl_units")));
					dblminimumeligible=FwHelper.parseDouble(Helper.correctDouble((String)hshCAPTL.get("capl_loanamt")));
					
					hshRecord.put("dblsupportprice",String.valueOf(dblsupportprice));
					hshRecord.put("dblMarketValue",String.valueOf(dblMarketValue));
					
					hshRecord.put("dblnoofunits",String.valueOf(dblnoofunits));
					arrRow.add(String.valueOf(dblminimumeligible));//5
					arrRow.add("Eligible Limit ( B -");//6
					strAmount=Helper.convertApplicationToSetup(strValuesin,dblLoanAmt);
					dblLoanAmtinLakhs=Double.parseDouble(strAmount);
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("getagrfacilitycode^"+strAppNo+"^"+strSchemeType);
					if(rs.next())
					{
						strFacilityCode=Helper.correctNull((String)rs.getString("facility_code"));
					}
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("getfacilityMargin^"+strFacilityCode+"^"+dblLoanAmtinLakhs+"^"+dblLoanAmtinLakhs);
					if(rs.next())
					{
						strMargin=Helper.correctNull((String)rs.getString("margin_perct"));
						dblMargin=Double.parseDouble(strMargin);
						//hshRecord.put("MarginPercent", Helper.correctDouble(strMargin));
					}
					double dblLessMargin=0.0;
					dblLessMargin=dblminimumeligible-(dblminimumeligible*(dblMargin/100));
					arrRow.add(String.valueOf(dblMargin));//7
					arrRow.add("% Margin Amount ) (C)");//8
					arrRow.add(String.valueOf(dblLessMargin));//9
					arrRow.add("Eligibility As Per Assessment(Least of the A&C)");//10
					dblEligibleAmount =Math.min(dblrequestedAmount,dblLessMargin);
					arrRow.add(String.valueOf(dblEligibleAmount));//11
					dblTotalEligibleLoanAmount+=dblEligibleAmount;
					arrWareHouse.add(arrRow);
				}
				
				/*Self Help Group*/
				if(strSchemeType.trim().equalsIgnoreCase("aS"))
				{
					HashMap hshSHGApp=new HashMap();
					double dblSHGTotal=0.00;
					double dblSHGTotalAmount=0.00;
					double dblEligibleAmount=0.00;
					arrRow=new ArrayList();
					arrRow.add("Self Help Group");//0
					arrRow.add("Amount Requested (A)");//1
					arrRow.add("Total value in corpus of the group");//2
					arrRow.add("Four times of total value in corpus of the group (B)");//3
					arrRow.add("Eligibility as per Assessment(Least of the A&B)");//4
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("sel_agriculture_facilities_scheme^"+strAppNo+"^"+strSchemeType+"^"+strSchemeFacSno);
					if(rs.next())
					{
						dblrequestedAmount=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("facility_proposed")));
					}
					arrRow.add(jtn.format(dblrequestedAmount));//5
					if(rs.next())
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("agrcorpustotal_select^"+strAppNo);
					if(rs.next())
					{
						dblSHGTotal=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("agr_cog_total")));
					}
					arrRow.add(jtn.format(dblSHGTotal));//6
					dblSHGTotalAmount=4*dblSHGTotal;
					arrRow.add(jtn.format(dblSHGTotalAmount));//7
					dblEligibleAmount =Math.min(dblrequestedAmount,dblSHGTotalAmount);
					arrRow.add(String.valueOf(dblEligibleAmount));//8
					dblTotalEligibleLoanAmount+=dblEligibleAmount;
					arrSHG.add(arrRow);
				}
				/*Dairy Farming*/
				if(strSchemeType.trim().equalsIgnoreCase("aD"))
				{
					double dblrequestedAmount1=0.00;
					String strLoanamt="",strMargin="",strFacilityCode="0",strAmount="0";
					double dblLoanAmt=0.00,dblLoanAmtinLakhs=0.00;
					arrRow=new ArrayList();
					double dblEligibleAmount=0.00;
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("sel_agriculture_facilities_scheme^"+strAppNo+"^"+strSchemeType+"^"+strSchemeFacSno);
					if(rs.next())
					{
						dblrequestedAmount1=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("facility_proposed")));
						dblrequestedAmount=dblrequestedAmount1;
						dblLoanAmt=dblrequestedAmount;
					}
					strAmount=Helper.convertApplicationToSetup(strValuesin,dblLoanAmt);
					dblLoanAmtinLakhs=Double.parseDouble(strAmount);
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("getagrfacilitycode^"+strAppNo+"^"+strSchemeType);
					if(rs.next())
					{
						strFacilityCode=Helper.correctNull((String)rs.getString("facility_code"));
					}
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("getfacilityMargin^"+strFacilityCode+"^"+dblLoanAmtinLakhs+"^"+dblLoanAmtinLakhs);
					if(rs.next())
					{
						strMargin=Helper.correctNull((String)rs.getString("margin_perct"));
						dblMargin=Double.parseDouble(strMargin);
						hshRecord.put("MarginPercent", Helper.correctDouble(strMargin));
					}
					double dbltotalunitcost=0,dblmarginamount=0,dblrequiredamount=0;
					rs=DBUtils.executeLAPSQuery("agr_dairycostofinvestment_adult_select^"+strAppNo+"^"+strSchemeType);
					if(rs.next())
					{
						dbltotalunitcost=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("agr_totunitcost")));
					}
					if(rs!=null) rs.close();
					dblmarginamount=dbltotalunitcost*dblMargin/100;
					dblrequiredamount=dbltotalunitcost-dblmarginamount;
					
					hshRecord.put("dbltotalunitcost",String.valueOf(dbltotalunitcost));
					hshRecord.put("dblmarginamount",String.valueOf(dblmarginamount));
					hshRecord.put("dblrequiredamount",String.valueOf(dblrequiredamount));
					
					dblEligibleAmount =Math.min(dblrequestedAmount,dblrequiredamount);
					hshRecord.put("dblEligibleAmount",String.valueOf(dblEligibleAmount));
					
					
					if(rs!=null) rs.close();
					arrRow.add("Eligibility Based on assessment");//0
					
					arrRow.add("Amount of Loan applied");//1
					arrRow.add(String.valueOf(dblrequestedAmount));//2
					arrRow.add("Total Unit Cost");//3
					arrRow.add(String.valueOf(dbltotalunitcost));//4
					arrRow.add("Applicants Margin @");//5
					arrRow.add(String.valueOf(dblMargin)+"%");//6
					arrRow.add(String.valueOf(dblmarginamount));//7
					arrRow.add("Loan Amount required");//8
					arrRow.add(String.valueOf(dblrequiredamount));//9
					arrRow.add("Eligible Loan Amount[Least of A&B]");//10
					arrRow.add(String.valueOf(dblEligibleAmount));//11
					arrRow.add("Dairy Farming");//12
					dblTotalEligibleLoanAmount+=dblEligibleAmount;
					arrDairyFarm.add(arrRow);
					
				}
				
				
				/*Allied Activity*/
				if(strSchemeType.trim().equalsIgnoreCase("aR"))
				{
					HashMap hshAllieApp=new HashMap();
					dblrequestedAmount=0.00;
					double dblEligibleAmount=0.00;
					double dblBankLoan=0,dblRecurringExptotal=0,dblcostMargin=0.00;
					double dblunitcost=0.00;
					double dblLoanAmt=0.00,dblLoanAmtinLakhs=0.00;
					String strLoanamt="",strMargin="",strFacilityCode="0",strAmount="0";
					arrRow.add("Allied Activity");//0
					//arrRow.add("Eligibility Based on Assessment");
					arrRow.add("Amount Of Loan Applied (A)");//1
					arrRow.add("Total Unit Cost");//2
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("sel_agriculture_facilities_scheme^"+strAppNo+"^"+strSchemeType+"^"+strSchemeFacSno);	 
					if(rs.next())
					{
						dblrequestedAmount=FwHelper.parseDouble(Helper.correctDouble(rs.getString("facility_proposed")));
						dblLoanAmt=dblrequestedAmount;
					}
					strAmount=Helper.convertApplicationToSetup(strValuesin,dblLoanAmt);
					dblLoanAmtinLakhs=Double.parseDouble(strAmount);
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("getagrfacilitycode^"+strAppNo+"^"+strSchemeType);
					if(rs.next())
					{
						strFacilityCode=Helper.correctNull((String)rs.getString("facility_code"));
					}
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("getfacilityMargin^"+strFacilityCode+"^"+dblLoanAmtinLakhs+"^"+dblLoanAmtinLakhs);
					if(rs.next())
					{
						strMargin=Helper.correctNull((String)rs.getString("margin_perct"));
						dblMargin=Double.parseDouble(strMargin);
						//hshRecord.put("MarginPercent", Helper.correctDouble(strMargin));
					}
					arrRow.add("Total unit cost (Less margin @ "+strMargin+"% (of Total unit cost)) (B)");//3
					arrRow.add("Eligibility as per Assessment (Min of A&B)");//4
					arrRow.add(jtn.format(dblrequestedAmount));//5
					
					if(rs!=null) rs.close();
					rs=DBUtils.executeLAPSQuery("agr_sheeprecurringexp_bankloan_select^"+strAppNo+"^"+strSchemeType+"^"+strSchemeFacSno);
					if(rs.next())
					{
						dblRecurringExptotal=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("agr_rec_totalb")));
					}
					if(rs!=null) rs.close();
					double dblfixedcost=0;
					rs=DBUtils.executeLAPSQuery("agr_sheepfixedcost_total_select^"+strAppNo+"^"+strSchemeType+"^"+strSchemeFacSno);
					if(rs.next())
					{
						dblfixedcost=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("agr_fxd_total")));
					}
					dblBankLoan=(dblfixedcost+dblRecurringExptotal)-((dblfixedcost+dblRecurringExptotal)*dblMargin/100);
					dblunitcost=dblfixedcost+dblRecurringExptotal;
					arrRow.add(""+dblunitcost);//6
					//hshRecord.put("totalunitcost",String.valueOf(dblfixedcost+dblRecurringExptotal));
					//hshRecord.put("totalunitcostlessmargin",String.valueOf(dblBankLoan));
					dblcostMargin=dblBankLoan*0.2;
					dblcostMargin=dblunitcost-(dblunitcost*(dblMargin/100));

					arrRow.add(""+dblcostMargin);//7
					
					dblEligibleAmount =Math.min(dblrequestedAmount,dblcostMargin);
					arrRow.add(""+dblEligibleAmount);//8
					dblTotalEligibleLoanAmount+=dblEligibleAmount;
					//hshRecord.put("dblEligibleAmount",String.valueOf(dblEligibleAmount));
					arrAlliedAss.add(arrRow);
					
				}
				
			}
			hshRecord.put("Total Eligible Loan Amount","Total Eligible Loan Amount");
			hshRecord.put("dblTotalEligibleLoanAmount",String.valueOf(dblTotalEligibleLoanAmount));
			hshRecord.put("arrAgriMobile",arrAgriMobile);
			hshRecord.put("arrFarmMech",arrFarmMech);
			hshRecord.put("arrMinorIrr",arrMinorIrr);
			hshRecord.put("arrPlantation",arrPlantation);
			hshRecord.put("arrLandDev",arrLandDev);
			hshRecord.put("arrAgriLand",arrAgriLand);
			hshRecord.put("arrAgriMobile",arrAgriMobile);
			hshRecord.put("arrWareHouse",arrWareHouse);
			hshRecord.put("arrDairyFarm",arrDairyFarm);
			hshRecord.put("arrAlliedAss",arrAlliedAss);
			hshRecord.put("arrAMTL",arrAMTL);
			hshRecord.put("arrSHG",arrSHG);
			}
			/***FKCC Assessment***/
			if(strfinalassesttype.equalsIgnoreCase("FKCC"))
			{
				double cropvalues=0.00;
				double sacleoffin=0.00;
				double grandtotal=0.00;
				double nonfarmturn=0.00;
				double nonfarmactiv=0.00;
				double alliedactiv=0.00;
				double contingactiv=0.00;
				double eligible1=0.00;
				double exceeding=0.00;
				double eligible2=0.00;
				double margin=0.00;
				double eligible3=0.00;
				double grossinc1=0.00;
				double grossinc2=0.00;
				double collateralsec1=0.00;
				double collateralsec2=0.00;
				String strFacilityCode="";
				String scaleper="",grossper="",collper="",strAmount="0";
				String strMargin="";
				 arrFkcc = new ArrayList();
				 double dblLoanAmt=0.00;
				 double dblLoanAmtinLakhs=0.00;
				 ResultSet rs2=null,rs3=null;
				 
				 if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("sel_agriculture_facilities_scheme^"+strAppNo+"^"+strSchemeType+"^"+strSchemeFacSno);	 
					if(rs.next())
					{
						dblrequestedAmount=FwHelper.parseDouble(Helper.correctDouble(rs.getString("facility_proposed")));
						dblLoanAmt=dblrequestedAmount;
					}
					strAmount=Helper.convertApplicationToSetup(strValuesin,dblLoanAmt);
					dblLoanAmtinLakhs=Double.parseDouble(strAmount);
				if(rs!=null)
				{
					rs.close();
				}

				rs=DBUtils.executeLAPSQuery("selfkccdetails^"+strAppNo);
				if(rs.next())
				{						
					cropvalues=FwHelper.parseDouble((String)rs.getString("AGR_CROPVALUES"));
					sacleoffin=FwHelper.parseDouble((String)rs.getString("AGR_SCALEFINANCE"));
					grandtotal=FwHelper.parseDouble((String)rs.getString("AGR_GRANDTOTAL"));
					nonfarmturn=FwHelper.parseDouble((String)rs.getString("AGR_NONFARMACT"));
					nonfarmactiv=FwHelper.parseDouble((String)rs.getString("AGR_NONFARMVALUE"));
					alliedactiv=FwHelper.parseDouble((String)rs.getString("AGR_ALLIEDACTVAL"));
					contingactiv=FwHelper.parseDouble((String)rs.getString("AGR_CONTACTVAL"));
					eligible1=FwHelper.parseDouble((String)rs.getString("AGR_ELIGIBLEAMOUNT"));
					exceeding=FwHelper.parseDouble((String)rs.getString("AGR_EXEEDING"));
					eligible2=FwHelper.parseDouble((String)rs.getString("AGR_ELIGIBLEAMOUNT2"));
					rs3=DBUtils.executeLAPSQuery("getagrfacilitycode^"+strAppNo+"^aQ");
					if(rs3.next())
					{
						strFacilityCode=Helper.correctNull((String)rs3.getString("facility_code"));
					}
					if(rs2!=null)
					{
						rs.close();
					}
					rs2=DBUtils.executeLAPSQuery("getfacilityMargin^"+strFacilityCode+"^"+dblLoanAmtinLakhs+"^"+dblLoanAmtinLakhs);
					if(rs2.next())
					{
						strMargin=Helper.correctNull((String)rs2.getString("margin_perct"));
						margin=Double.parseDouble(strMargin);
						//hshRecord.put("MarginPercent", Helper.correctDouble(strMargin));
					}
					//margin=FwHelper.parseDouble((String)rs.getString("AGR_MARGINVAL"));
					eligible3=FwHelper.parseDouble((String)rs.getString("AGR_ELIGIBLEAMOUNT3"));
					grossinc1=FwHelper.parseDouble((String)rs.getString("AGR_GROSSINCOME"));
					grossinc2=FwHelper.parseDouble((String)rs.getString("AGR_GROSSINCOME2"));
					collateralsec1=FwHelper.parseDouble((String)rs.getString("AGR_COLLATERALSEC"));
					collateralsec2=FwHelper.parseDouble((String)rs.getString("AGR_COLLATERALSEC2"));
					
					scaleper=Helper.correctNull((String)rs.getString("AGR_SCALFINPER"));
					grossper=Helper.correctNull((String)rs.getString("AGR_GROSSINCPER"));
					collper=Helper.correctNull((String)rs.getString("AGR_COLSECPER"));
					double limitrecomended=FwHelper.parseDouble((String)rs.getString("agr_limitrecommended"));
					
					arrRow=new ArrayList();
					arrRow.add("Total Amount based on Crop values");//0
					arrRow.add(String.valueOf(cropvalues));//1
					arrRow.add("Scale of finance value ");//2
					arrRow.add(String.valueOf(sacleoffin));//3
					arrRow.add("Grand Total");//4
					arrRow.add(String.valueOf(grandtotal));//5
					arrRow.add("Non Farm Activity Projected Turn Over");//6
					arrRow.add(String.valueOf(nonfarmturn));//7
					arrRow.add("Non-Farm Activities");//8
					arrRow.add(String.valueOf(nonfarmactiv));//9
					arrRow.add("Allied Activities");//10
					arrRow.add(String.valueOf(alliedactiv));//11
					arrRow.add("Contingent Needs");//12
					arrRow.add(String.valueOf(contingactiv));//13
					arrRow.add("Eligible Loan Amount");//14
					arrRow.add(String.valueOf(eligible1));//15
					arrRow.add("Exceeding Allowed in scale of finacne");//16
					arrRow.add(String.valueOf(exceeding));//17
					arrRow.add("Total eligible amout(excluding margin)");//18
					arrRow.add(String.valueOf(eligible2));//19
					arrRow.add("Margin");//20
					arrRow.add(String.valueOf(margin));//21
					arrRow.add("Total eligible amout");//22
					arrRow.add(String.valueOf(eligible3));//23
					//dblTotalEligibleLoanAmount+=eligible3;
					arrRow.add("Gross Income");//24
					arrRow.add(String.valueOf(grossinc1));//25
					arrRow.add("Gross Income ");//26
					arrRow.add(String.valueOf(grossinc2));//27
					arrRow.add("Value of Collateral Security");//28
					arrRow.add(String.valueOf(collateralsec1));//29
					arrRow.add("Value of Collateral security");//30
					arrRow.add(String.valueOf(collateralsec2));//31
					
					arrRow.add(scaleper);//32
					arrRow.add(grossper);//33
					arrRow.add(collper);//34
					arrRow.add("Limit Recommended");//35
					arrRow.add(String.valueOf(limitrecomended));//36
					arrFkcc.add(arrRow);
				}
				if(rs!=null)rs.close();
				rs=DBUtils.executeLAPSQuery("sel_allcomments^"+strAppNo+"^"+"MPBFAGR");	 
				if(rs.next())
				{
					hshRecord.put("fin_comments", Helper.CLOBToString(rs
							.getClob("fin_comments")));
					
					hshRecord.put("fin_comments1", Helper.CLOBToString(rs
							.getClob("fin_comments1")));
				}
				
				hshRecord.put("arrFkcc",arrFkcc);
				if(rs!=null)rs.close();
				rs=DBUtils.executeLAPSQuery("sel_allcomments^"+strAppNo+"^"+"FKCC");	 
				if(rs.next())
				{
					hshRecord.put("fin_commentsfkcc", Helper.CLOBToString(rs
							.getClob("fin_comments")));
					
					hshRecord.put("fin_comments1fkcc", Helper.CLOBToString(rs
							.getClob("fin_comments1")));
				}
			}
			if(strfinalassesttype.equalsIgnoreCase("RPSCHE"))
			{
			hshhmesteadass=gethomesteadassesmentdata(hshValues);
			hshRecord.put("hshhmesteadass", hshhmesteadass);
			}
				}
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_appstatus^"+strAppNo);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strAppStatus = correctNull((String)rs.getString(1));
			}
			else
			{
				strAppStatus="";
			}
			if(strAppStatus.trim().equalsIgnoreCase("op"))
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppNo);

				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "delmpbfeligibleamount");
				hshQueryValues.put("1", hshQuery);
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "insertmpbfeligibleamount");
				arrValues.add(strAppNo);
				arrValues.add(jtn.format(dblTotalEligibleLoanAmount));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			
			
			ArrayList arr=new ArrayList();ArrayList arr1=new ArrayList();
			ArrayList arrFin=new ArrayList();
			ArrayList arrNonFin=new ArrayList();
			if(rs1!=null)
				rs1.close();
			rs1=DBUtils.executeLAPSQuery("com_assessmentselection_select^"+strAppNo);
			if(rs1.next())
			{	
				arr= new ArrayList();				
				
			ArrayList arr2= new ArrayList();
			String strassesttype= correctNull((String)rs1.getString("COM_ASSESSMENTTYPE"));
			StringTokenizer strassesttypesplit= new StringTokenizer(strassesttype,"@");
			while(strassesttypesplit.hasMoreTokens())			
			{
				boolean blFlagFin=false;
				boolean blFlagnonFin=false;
				
				String strfinalassesttype=(String)strassesttypesplit.nextToken();
				String strfinalassesttype1="",strfinalassesttype2="";
				
				arr.add(strfinalassesttype);				
				if(strfinalassesttype.equalsIgnoreCase("PB"))
				{
					strfinalassesttype1="Performance BG";
					blFlagnonFin=true;
				}
				else if(strfinalassesttype.equalsIgnoreCase("O1"))
				{
					strfinalassesttype1="Other Assessment1";
					blFlagnonFin=true;
				}
				else if(strfinalassesttype.equalsIgnoreCase("O2"))
				{
					strfinalassesttype1="Other Assessment2";
					blFlagnonFin=true;
				}
				else if(strfinalassesttype.equalsIgnoreCase("FB"))
				{
					strfinalassesttype1="Financial BG";
					blFlagnonFin=true;
				}
				else if(strfinalassesttype.equalsIgnoreCase("DL"))
				{
					strfinalassesttype1="DisputeLiabilities";
					blFlagnonFin=true;
				}
				else if(strfinalassesttype.equalsIgnoreCase("BL"))
				{
					strfinalassesttype1="NFBL";
					blFlagnonFin=true;
				}
				else if(strfinalassesttype.equalsIgnoreCase("BG"))
				{
					strfinalassesttype1="NFBL-BG";
					blFlagnonFin=true;
				}
				
				else if(strfinalassesttype.equalsIgnoreCase("WH"))
				{
					strfinalassesttype1="WareHouse";
					blFlagnonFin=true;
				}
				else if(strfinalassesttype.equalsIgnoreCase("KC"))
				{
					strfinalassesttype1="KCC";
					blFlagnonFin=true;
					
				}
				else if(strfinalassesttype.equalsIgnoreCase("M1"))
				{
					strfinalassesttype1="MPBF1";
					blFlagFin=true;
				}
				else if(strfinalassesttype.equalsIgnoreCase("M2"))
				{
					strfinalassesttype1="MPBF2";
					blFlagFin=true;
				}
				else if(strfinalassesttype.equalsIgnoreCase("M3"))
				{
					strfinalassesttype1="MPBF3";
					blFlagFin=true;
				}
				else if(strfinalassesttype.equalsIgnoreCase("M4"))
				{
					strfinalassesttype1="MPBF4";
					blFlagFin=true;
				}
				else if(strfinalassesttype.equalsIgnoreCase("M5"))
				{
					strfinalassesttype1="MPBF5";
					blFlagFin=true;
				}
				else if(strfinalassesttype.equalsIgnoreCase("M6"))
				{
					strfinalassesttype1="MPBF6";
					blFlagFin=true;
				}
				else if(strfinalassesttype.equalsIgnoreCase("M7"))
				{
					strfinalassesttype1="MPBF7";
					blFlagFin=true;
				}
				else if(strfinalassesttype.equalsIgnoreCase("M8"))
				{
					strfinalassesttype1="MPBF8";
					blFlagFin=true;
				}
				else if(strfinalassesttype.equalsIgnoreCase("M9"))
				{
					strfinalassesttype1="MPBF9";
					blFlagFin=true;
				}
				else if(strfinalassesttype.equalsIgnoreCase("DL"))
				{
					strfinalassesttype1="DisputeLiabilities";
					blFlagFin=true;
				}
				else if(strfinalassesttype.equalsIgnoreCase("MA"))
				{
					strfinalassesttype1="Machinery";
					blFlagnonFin=true;
				}else if(strfinalassesttype.equalsIgnoreCase("TU"))
				{
					strfinalassesttype1="TufScheme";
					blFlagnonFin=true;
				}else if(strfinalassesttype.equalsIgnoreCase("AD"))
				{
					strfinalassesttype1="ApprovalDetails";
					blFlagnonFin=true;
				}else if(strfinalassesttype.equalsIgnoreCase("BD"))
				{
					strfinalassesttype1="BuildersDetails";
					blFlagnonFin=true;
				}else if(strfinalassesttype.equalsIgnoreCase("CC"))
				{
					strfinalassesttype1="Cost of Construction";
					blFlagnonFin=true;
				}
	             else if(strfinalassesttype.equalsIgnoreCase("P1"))
					{
						strfinalassesttype1="PBF1";
						blFlagFin=true;
					}
	             else if(strfinalassesttype.equalsIgnoreCase("P2"))
					{
						strfinalassesttype1="PBF2";
						blFlagFin=true;
					}
	             else if(strfinalassesttype.equalsIgnoreCase("P3"))
					{
						strfinalassesttype1="PBF3";
						blFlagFin=true;
					}
	             else if(strfinalassesttype.equalsIgnoreCase("P4"))
					{
						strfinalassesttype1="PBF4";
						blFlagFin=true;
					}
				else if(strfinalassesttype.equalsIgnoreCase("TO"))
				 {
					 strfinalassesttype1="TO";
					 blFlagFin=true;
				 }
				 else if(strfinalassesttype.equalsIgnoreCase("BGASSES"))
				 {
					 strfinalassesttype1="BGASSES";
					 blFlagFin=true;
				 }
				 else if(strfinalassesttype.equalsIgnoreCase("CSHBUD"))
				 {
					 strfinalassesttype1="CSHBUD";
					 blFlagFin=true;
				 }	
				 else if(strfinalassesttype.equalsIgnoreCase("LCASSES"))
				 {
					 strfinalassesttype1="LCASSES";
					 blFlagFin=true;
				 }
				 else if(strfinalassesttype.equalsIgnoreCase("WCCONT"))
				 {
					 strfinalassesttype1="WCCONT";
					 blFlagFin=true;
				 }
				 else if(strfinalassesttype.equalsIgnoreCase("MPBF"))
	             {
	            	 strfinalassesttype1="MPBF";
	            	 blFlagFin=true;
	             }
	             else if(strfinalassesttype.equalsIgnoreCase("ABF"))
	             {
	            	 strfinalassesttype1="ABF";
	            	 blFlagFin=true;
	             }
	             else if(strfinalassesttype.equalsIgnoreCase("EXPORTCF"))
	             {
	            	 strfinalassesttype1="EXPORTCF";
	            	 blFlagFin=true;
	             }
	             else if(strfinalassesttype.equalsIgnoreCase("BGSTOCK"))
	             {
	            	 strfinalassesttype1="BGSTOCK";
	            	 blFlagFin=true;
	             }
	             else if(strfinalassesttype.equalsIgnoreCase("OTHER"))
	             {
	            	 strfinalassesttype1="OTHER";
	            	 blFlagFin=true;
	             }
	             else if(strfinalassesttype.equalsIgnoreCase("MPBFAGR"))
	             {
	            	 strfinalassesttype1="MPBFAGR";
	            	 blFlagFin=true;
	             }
	             else if(strfinalassesttype.equalsIgnoreCase("RPSCHE"))
	             {
	            	 strfinalassesttype1="RPSCHE";
	            	 blFlagFin=true;
	             }
	             else if(strfinalassesttype.equalsIgnoreCase("DSCR"))
	             {
	            	 strfinalassesttype1="DSCR";
	            	 blFlagFin=true;
	             }
	             else if(strfinalassesttype.equalsIgnoreCase("IRR"))
	             {
	            	 strfinalassesttype1="IRR";
	            	 blFlagFin=true;
	             }
	             else if(strfinalassesttype.equalsIgnoreCase("FKCC"))
	             {
	            	 strfinalassesttype1="FKCC";
	            	 blFlagFin=true;
	             }
				arr1.add(strfinalassesttype1);
				if(blFlagFin && (!arrFin.contains(strfinalassesttype1)))
				{
					
					arrFin.add(strfinalassesttype1);

				}
				if(blFlagnonFin && (!arrNonFin.contains(strfinalassesttype1)))
				{
					arrNonFin.add(strfinalassesttype1);

				}
				
			}		
			hshValues.put("arr1",arr1);
		
			
			}
			hshRecord.put("arrFin",arrFin);
			hshRecord.put("arrNonFin",arrNonFin);			
			if (rs != null) {
				rs.close();
			}			 			
		hshRecord.put("strappno", strAppNo);
		
		}
		catch (Exception e) 
		{
			log.error(e.getMessage());
			throw new EJBException(LAlerts.EXCEPTION+"Error in Assessment"+e.toString());
		}
		return hshRecord;
	}
	
	public HashMap gethomesteadassesmentdata(HashMap hshValues)  
	{
		String strAppNo="";
		String strQuery="";
		String strAppStatus="";
		String strSchemeType="";
		String strApptype="";
		String strProductCode="";
		HashMap hshRecord=new HashMap();
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrHomesteadFarm=new ArrayList();
		ResultSet rs=null;
		double dblrequestedAmount=0.00;
		double dblEligibleLoanAmount=0.00;
		ArrayList arrAlliedAss=new ArrayList();
		ArrayList arrRow1=new ArrayList();
		arrRow=new ArrayList();
		double dblEligibleAmountasperassessment=0.00;
		double extentofland=0.00;
		String strValuesin="";
		strAppNo=correctNull((String)hshValues.get("strappno"));
		if(strAppNo.trim().equalsIgnoreCase(""))
		{
			strAppNo=correctNull((String)hshValues.get("appno"));
		}
		if(strAppNo.trim().equalsIgnoreCase(""))
		{
			strAppNo=correctNull((String)hshValues.get("strAppno"));
		}
		
		try
		{
		if(rs!=null)
			rs.close();
		rs=DBUtils.executeLAPSQuery("getagrvaluesin^"+strAppNo);
		if(rs.next())
		{
			strValuesin=Helper.correctNull((String)rs.getString("app_valuesin"));
		}
		if(rs!=null)
			rs.close();
		rs=DBUtils.executeLAPSQuery("sel_agriculture_facilities_scheme^"+strAppNo+"^"+"aQ");
		if(rs.next())
		{
			dblrequestedAmount=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("facility_proposed")));
		}
		if(rs!=null) rs.close();
		rs=DBUtils.executeLAPSQuery("sel_homesteadforfkcc^"+strAppNo+"^"+"aQ");
		if(rs.next())
		{
			extentofland=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("AGR_EXTENTOFLAND")));
		}
		if(rs!=null) rs.close();
		rs=DBUtils.executeLAPSQuery("select_agr_homesteadfarming");
		if(rs.next())
		{
			if(extentofland<0.25)
			{
			dblEligibleAmountasperassessment=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("AGR_HSF_UPTO25")));
			dblEligibleAmountasperassessment=Helper.correctRupeestoValues(strValuesin,dblEligibleAmountasperassessment);
			}
			else if(extentofland>=0.25 && extentofland<0.50 )
			{
			dblEligibleAmountasperassessment=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("AGR_HSF_UPTO50")));
			dblEligibleAmountasperassessment=Helper.correctRupeestoValues(strValuesin,dblEligibleAmountasperassessment);
			}
			else if(extentofland>=0.50 && extentofland<0.75)
			{
			dblEligibleAmountasperassessment=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("AGR_HSF_UPTO75")));
			dblEligibleAmountasperassessment=Helper.correctRupeestoValues(strValuesin,dblEligibleAmountasperassessment);
			}
			else if(extentofland>=0.75 && extentofland<1.00)
			{
			dblEligibleAmountasperassessment=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("AGR_HSF_75TO1")));
			dblEligibleAmountasperassessment=Helper.correctRupeestoValues(strValuesin,dblEligibleAmountasperassessment);
			}
			else if(extentofland>=1.00 && extentofland<2.00)
			{
			dblEligibleAmountasperassessment=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("AGR_HSF_1TO2")));
			dblEligibleAmountasperassessment=Helper.correctRupeestoValues(strValuesin,dblEligibleAmountasperassessment);
			}
			else if(extentofland>=2.00 && extentofland<5.00)
			{
			dblEligibleAmountasperassessment=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("AGR_HSF_2TO5")));
			dblEligibleAmountasperassessment=Helper.correctRupeestoValues(strValuesin,dblEligibleAmountasperassessment);
			}
			else if(extentofland>=5.00)
			{
			dblEligibleAmountasperassessment=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("AGR_HSF_ABOVE5")));
			dblEligibleAmountasperassessment=Helper.correctRupeestoValues(strValuesin,dblEligibleAmountasperassessment);
			}
		}
		dblEligibleLoanAmount =Math.min(dblrequestedAmount,dblEligibleAmountasperassessment);
		arrRow.add("HomeStead Farming ");//0
		arrRow.add("Requested loan amount");//1
		arrRow.add(String.valueOf(dblrequestedAmount));//2
		arrRow.add("Extent of land");//3
		arrRow.add(String.valueOf(extentofland));//4
		arrRow.add("Eligibility as per extent of cultivation");//5
		arrRow.add(String.valueOf(dblEligibleAmountasperassessment));//6
		arrRow.add("Eligibility as per Assessment");//7
		arrRow.add(String.valueOf(dblEligibleLoanAmount));//8
		arrHomesteadFarm.add(arrRow);	
		hshRecord.put("arrHomesteadFarm",arrHomesteadFarm);
		
		ArrayList arr=new ArrayList();ArrayList arr1=new ArrayList();
		ArrayList arrFin=new ArrayList();
		ArrayList arrNonFin=new ArrayList();
		
		if(rs!=null)
			rs.close();
		rs=DBUtils.executeLAPSQuery("com_assessmentselection_select^"+strAppNo);
		if(rs.next())
		{	
			arr= new ArrayList();				
			
		ArrayList arr2= new ArrayList();
		String strassesttype= correctNull((String)rs.getString("ca_assmtselect"));
		StringTokenizer strassesttypesplit= new StringTokenizer(strassesttype,"@");
		while(strassesttypesplit.hasMoreTokens())			
		{
			boolean blFlagFin=false;
			boolean blFlagnonFin=false;
			
			String strfinalassesttype=(String)strassesttypesplit.nextToken();
			String strfinalassesttype1="",strfinalassesttype2="";
			
			arr.add(strfinalassesttype);				
			if(strfinalassesttype.equalsIgnoreCase("PB"))
			{
				strfinalassesttype1="Performance BG";
				blFlagnonFin=true;
			}
			else if(strfinalassesttype.equalsIgnoreCase("O1"))
			{
				strfinalassesttype1="Other Assessment1";
				blFlagnonFin=true;
			}
			else if(strfinalassesttype.equalsIgnoreCase("O2"))
			{
				strfinalassesttype1="Other Assessment2";
				blFlagnonFin=true;
			}
			else if(strfinalassesttype.equalsIgnoreCase("FB"))
			{
				strfinalassesttype1="Financial BG";
				blFlagnonFin=true;
			}
			else if(strfinalassesttype.equalsIgnoreCase("DL"))
			{
				strfinalassesttype1="DisputeLiabilities";
				blFlagnonFin=true;
			}
			else if(strfinalassesttype.equalsIgnoreCase("BL"))
			{
				strfinalassesttype1="NFBL";
				blFlagnonFin=true;
			}
			else if(strfinalassesttype.equalsIgnoreCase("BG"))
			{
				strfinalassesttype1="NFBL-BG";
				blFlagnonFin=true;
			}
			
			else if(strfinalassesttype.equalsIgnoreCase("WH"))
			{
				strfinalassesttype1="WareHouse";
				blFlagnonFin=true;
			}
			else if(strfinalassesttype.equalsIgnoreCase("KC"))
			{
				strfinalassesttype1="KCC";
				blFlagnonFin=true;
				
			}
			else if(strfinalassesttype.equalsIgnoreCase("M1"))
			{
				strfinalassesttype1="MPBF1";
				blFlagFin=true;
			}
			else if(strfinalassesttype.equalsIgnoreCase("M2"))
			{
				strfinalassesttype1="MPBF2";
				blFlagFin=true;
			}
			else if(strfinalassesttype.equalsIgnoreCase("M3"))
			{
				strfinalassesttype1="MPBF3";
				blFlagFin=true;
			}
			else if(strfinalassesttype.equalsIgnoreCase("M4"))
			{
				strfinalassesttype1="MPBF4";
				blFlagFin=true;
			}
			else if(strfinalassesttype.equalsIgnoreCase("M5"))
			{
				strfinalassesttype1="MPBF5";
				blFlagFin=true;
			}
			else if(strfinalassesttype.equalsIgnoreCase("M6"))
			{
				strfinalassesttype1="MPBF6";
				blFlagFin=true;
			}
			else if(strfinalassesttype.equalsIgnoreCase("M7"))
			{
				strfinalassesttype1="MPBF7";
				blFlagFin=true;
			}
			else if(strfinalassesttype.equalsIgnoreCase("M8"))
			{
				strfinalassesttype1="MPBF8";
				blFlagFin=true;
			}
			else if(strfinalassesttype.equalsIgnoreCase("M9"))
			{
				strfinalassesttype1="MPBF9";
				blFlagFin=true;
			}
			else if(strfinalassesttype.equalsIgnoreCase("DL"))
			{
				strfinalassesttype1="DisputeLiabilities";
				blFlagFin=true;
			}
			else if(strfinalassesttype.equalsIgnoreCase("MA"))
			{
				strfinalassesttype1="Machinery";
				blFlagnonFin=true;
			}else if(strfinalassesttype.equalsIgnoreCase("TU"))
			{
				strfinalassesttype1="TufScheme";
				blFlagnonFin=true;
			}else if(strfinalassesttype.equalsIgnoreCase("AD"))
			{
				strfinalassesttype1="ApprovalDetails";
				blFlagnonFin=true;
			}else if(strfinalassesttype.equalsIgnoreCase("BD"))
			{
				strfinalassesttype1="BuildersDetails";
				blFlagnonFin=true;
			}else if(strfinalassesttype.equalsIgnoreCase("CC"))
			{
				strfinalassesttype1="Cost of Construction";
				blFlagnonFin=true;
			}
	         else if(strfinalassesttype.equalsIgnoreCase("P1"))
				{
					strfinalassesttype1="PBF1";
					blFlagFin=true;
				}
	         else if(strfinalassesttype.equalsIgnoreCase("P2"))
				{
					strfinalassesttype1="PBF2";
					blFlagFin=true;
				}
	         else if(strfinalassesttype.equalsIgnoreCase("P3"))
				{
					strfinalassesttype1="PBF3";
					blFlagFin=true;
				}
	         else if(strfinalassesttype.equalsIgnoreCase("P4"))
				{
					strfinalassesttype1="PBF4";
					blFlagFin=true;
				}
			else if(strfinalassesttype.equalsIgnoreCase("TO"))
			 {
				 strfinalassesttype1="TO";
				 blFlagFin=true;
			 }
			 else if(strfinalassesttype.equalsIgnoreCase("BGASSES"))
			 {
				 strfinalassesttype1="BGASSES";
				 blFlagFin=true;
			 }
			 else if(strfinalassesttype.equalsIgnoreCase("CSHBUD"))
			 {
				 strfinalassesttype1="CSHBUD";
				 blFlagFin=true;
			 }	
			 else if(strfinalassesttype.equalsIgnoreCase("LCASSES"))
			 {
				 strfinalassesttype1="LCASSES";
				 blFlagFin=true;
			 }
			 else if(strfinalassesttype.equalsIgnoreCase("WCCONT"))
			 {
				 strfinalassesttype1="WCCONT";
				 blFlagFin=true;
			 }
			 else if(strfinalassesttype.equalsIgnoreCase("MPBF"))
	         {
	        	 strfinalassesttype1="MPBF";
	        	 blFlagFin=true;
	         }
	         else if(strfinalassesttype.equalsIgnoreCase("ABF"))
	         {
	        	 strfinalassesttype1="ABF";
	        	 blFlagFin=true;
	         }
	         else if(strfinalassesttype.equalsIgnoreCase("EXPORTCF"))
	         {
	        	 strfinalassesttype1="EXPORTCF";
	        	 blFlagFin=true;
	         }
	         else if(strfinalassesttype.equalsIgnoreCase("BGSTOCK"))
	         {
	        	 strfinalassesttype1="BGSTOCK";
	        	 blFlagFin=true;
	         }
	         else if(strfinalassesttype.equalsIgnoreCase("OTHER"))
	         {
	        	 strfinalassesttype1="OTHER";
	        	 blFlagFin=true;
	         }
	         else if(strfinalassesttype.equalsIgnoreCase("MPBFAGR"))
	         {
	        	 strfinalassesttype1="MPBFAGR";
	        	 blFlagFin=true;
	         }
	         else if(strfinalassesttype.equalsIgnoreCase("RPSCHE"))
	         {
	        	 strfinalassesttype1="RPSCHE";
	        	 blFlagFin=true;
	         }
	         else if(strfinalassesttype.equalsIgnoreCase("DSCR"))
	         {
	        	 strfinalassesttype1="DSCR";
	        	 blFlagFin=true;
	         }
	         else if(strfinalassesttype.equalsIgnoreCase("IRR"))
	         {
	        	 strfinalassesttype1="IRR";
	        	 blFlagFin=true;
	         }
	         else if(strfinalassesttype.equalsIgnoreCase("FKCC"))
	         {
	        	 strfinalassesttype1="FKCC";
	        	 blFlagFin=true;
	         }
			arr1.add(strfinalassesttype1);
			if(blFlagFin && (!arrFin.contains(strfinalassesttype1)))
			{
				
				arrFin.add(strfinalassesttype1);

			}
			if(blFlagnonFin && (!arrNonFin.contains(strfinalassesttype1)))
			{
				arrNonFin.add(strfinalassesttype1);

			}
			
		}		
		hshValues.put("arr1",arr1);

		
		}
		hshRecord.put("arrFin",arrFin);
		hshRecord.put("arrNonFin",arrNonFin);
		if(rs!=null)rs.close();
		rs=DBUtils.executeLAPSQuery("sel_allcomments^"+strAppNo+"^"+"HOMESTEAD");	 
		if(rs.next())
		{
			hshRecord.put("fin_comments", Helper.CLOBToString(rs
					.getClob("fin_comments")));
			
			hshRecord.put("fin_comments1", Helper.CLOBToString(rs
					.getClob("fin_comments1")));
		}
		}
		catch (Exception e) 
		{
			log.error(e.getMessage());
			throw new EJBException(LAlerts.EXCEPTION+"Error in Assessment"+e.toString());
		}
		return hshRecord;
		
	}

	public HashMap getbroiagrflocknew(HashMap hshValues) 
{ 
	ResultSet rs=null;
	HashMap hshResult=new HashMap();
	HashMap hshQuery4=new HashMap();
	ArrayList arrCol = null;
	ArrayList arrRow = new ArrayList();
	ArrayList arrlist = new ArrayList();
	String strApplicationNo= FwHelper.correctNull((String)hshValues.get("strappno"));		
	String schemetype = FwHelper.correctNull((String)hshValues.get("strProductType"));
	if(strApplicationNo.equalsIgnoreCase(""))
		strApplicationNo=FwHelper.correctNull((String)hshValues.get("appno"));
	String strfacsno="";
	int intglayer=0,intlayersh=0,intFirstLay=0,intCulling=0;
	int intPeriod=0;
	String strSchemetype="";
	if(schemetype.equalsIgnoreCase("null") || schemetype.equalsIgnoreCase(""))
	{
		schemetype = FwHelper.correctNull((String)hshValues.get("schemetype"));
	}
	strSchemetype=schemetype;
	HashMap hshScheme = new HashMap();
	hshScheme = Helper.splitScheme(schemetype);
	if(hshScheme!=null)
	{
		strfacsno = Helper.correctInt((String)hshScheme.get("facility_sno"));
		schemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
	}
				
	if(strApplicationNo.equalsIgnoreCase(""))
	{
		strApplicationNo = FwHelper.correctNull((String)hshValues.get("appno"));
	}
	try 
	{
		String PurchasedDate="",strPoultryType="";
		int noofbatches=0;
		int bwk=0,gwk=0,lwk=0;
		int repayment_months=0,repaymentyrs=0,remaining_weeks=0;
		Date pur_date,yr_end_date,pur_date_new;
		long remaining_days=0;
		int intCheck=0;
		if(rs!=null){rs.close();}
		rs=DBUtils.executeLAPSQuery("sel_agr_poultrytechdata^"+strApplicationNo+"^"+schemetype+"^"+strfacsno);			 
		if(rs.next())
		{
			PurchasedDate=FwHelper.correctNull(rs.getString("poultry_purchasedate"));
			strPoultryType=FwHelper.correctNull(rs.getString("poultry_poultrytype"));
		}
		if(rs!=null){rs.close();}
		String strPurchasedDate=Helper.correctNull((String)hshValues.get("txt_purchasedate"));
		
		if(!strPurchasedDate.equalsIgnoreCase(""))
		{
			HashMap hshQueryValues4 = new HashMap();
			hshQuery4 = new HashMap();
			ArrayList arrValues4 = new ArrayList();
			hshQueryValues4.put("size", "1");
			hshQuery4.put("strQueryId", "updatepoultrytechdata");
			arrValues4.add(strPurchasedDate);
			arrValues4.add(strApplicationNo);
			arrValues4.add(schemetype);
			arrValues4.add(strfacsno);
			hshQuery4.put("arrValues", arrValues4);
			hshQueryValues4.put("1", hshQuery4);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
			PurchasedDate=strPurchasedDate;
		}
		
		rs=DBUtils.executeLAPSQuery("getfacdetforsanction^"+strApplicationNo+"^"+strfacsno);			 
		if(rs.next())
		{
			intPeriod=Integer.parseInt(Helper.correctInt(rs.getString("facility_months")));
		}
		if(intPeriod!=0)
			intPeriod=intPeriod/12;
		if(intPeriod==0)
			intPeriod=1;
		if(rs!=null){rs.close();}
		int Noofdays=0;
		int intShedCount=0;
		double intPatchDays=0.0,intPatchCount=0.0;
		if(!PurchasedDate.equalsIgnoreCase("")){
			String newdate="",strTempDate="";
			String endyear="31/12/"+PurchasedDate.substring(6, 10);
			SimpleDateFormat sdt1=new SimpleDateFormat("dd/MM/yyyy");
			pur_date=sdt1.parse(PurchasedDate);
			yr_end_date=sdt1.parse(endyear);
			remaining_days=(yr_end_date.getTime()-pur_date.getTime())/(1000*60*60*24);
		if(strPoultryType.equalsIgnoreCase("1"))
		{
			Noofdays=95;
			intPatchDays=(int) (remaining_days+((intPeriod-1)*365.25));
			noofbatches=(int) Math.abs(intPatchDays/Noofdays);
			intPatchCount=intPatchDays/Noofdays;
			if(intPatchCount>noofbatches)
				noofbatches++;
			//noofbatches=intPeriod*4;
			bwk=6;gwk=19;lwk=43;
			intCheck=4;
			intglayer=42;intlayersh=112;intFirstLay=175;intCulling=476;
			intShedCount=4;
		}
		else if(strPoultryType.equalsIgnoreCase("2"))
		{
			Noofdays=85;
			intPatchDays= (int) (remaining_days+((intPeriod-1)*365.25));
			bwk=8;gwk=12;lwk=52;
			noofbatches=(int) Math.abs(intPatchDays/Noofdays);
			intPatchCount=intPatchDays/Noofdays;
			if(intPatchCount>noofbatches)
				noofbatches++;
			//noofbatches=intPeriod*5;
			intCheck=5;
			intglayer=56;intlayersh=112;intFirstLay=140;intCulling=505;
			intShedCount=5;
		}
		else if(strPoultryType.equalsIgnoreCase("4"))
		{
			Noofdays=142;
			intPatchDays=(int) (remaining_days+((intPeriod-1)*365.25));
			noofbatches=(int) Math.abs(intPatchDays/Noofdays);
			intPatchCount=intPatchDays/Noofdays;
			if(intPatchCount>noofbatches)
				noofbatches++;
			//noofbatches=intPeriod*3;
			bwk=8;gwk=12;lwk=52;
			intCheck=3;
			intglayer=56;intlayersh=112;intFirstLay=140;intCulling=505;
			intShedCount=3;
		}
		int a[][]=new int[noofbatches][noofbatches];
		String date[]=new String[noofbatches];
		int bwkbal=0,gwkbal=0,lwkbal=0,bwkalloc=0,gwkalloc=0,lwkalloc=0;
		HashMap hshRemaining=new HashMap();
		HashMap hshallocated=new HashMap();
		int balweeks=0,balgweeks=0,ballweeks=0,intalloc=0;
		String oldyr="",newyr="";
		int oldyri=0,newyri=0,j=0;
		String strlayershed[]=new String[noofbatches];
		String strgrowershed[]=new String[noofbatches];
		String strfirstlay[]=new String[noofbatches];
		String strculling[]=new String[noofbatches];
		Calendar cal=Calendar.getInstance();
		String strShed[]=new String[intShedCount];
		String strShedNum[]=new String[noofbatches];
		for(int b=0;b<intShedCount;b++)
		{
			strShed[b]="0";
		}
		for(j=0;j<noofbatches;j++)
		{
			if(j==0){
			remaining_days=(yr_end_date.getTime()-pur_date.getTime())/(1000*60*60*24);
			remaining_weeks=(int) (remaining_days/7);
			date[j] = sdt1.format(pur_date);
			
			cal.setTime(pur_date);
			cal.add(cal.DATE, intglayer);
			strgrowershed[j]=sdt1.format(cal.getTime());
			
			cal.setTime(pur_date);
			cal.add(cal.DATE, intlayersh);
			strlayershed[j]=sdt1.format(cal.getTime());
			
			cal.setTime(pur_date);
			cal.add(cal.DATE, intFirstLay);
			strfirstlay[j]=sdt1.format(cal.getTime());
			
			cal.setTime(pur_date);
			cal.add(cal.DATE, intCulling);
			strculling[j]=sdt1.format(cal.getTime());
			
			hshRemaining.put(j+"bwk","0");
			hshRemaining.put(j+"gwk","0");
			hshRemaining.put(j+"lwk","0");
			hshallocated.put(j+"bwkallo","0");
			hshallocated.put(j+"gwkallo","0");
			hshallocated.put(j+"lwkallo","0");
			hshallocated.put(j+"alloc","0");
			hshRemaining.put(j+"remainingweeks",String.valueOf(remaining_weeks));
			}else 
			{
			cal.setTime(pur_date);
			cal.add(cal.DATE, Noofdays);
			newdate=sdt1.format(cal.getTime());
			endyear="31/12/"+newdate.substring(6, 10);
			pur_date=sdt1.parse(newdate);
			date[j] = sdt1.format(pur_date);
			yr_end_date=sdt1.parse(endyear);
			
			cal.setTime(pur_date);
			cal.add(cal.DATE, intglayer);
			strgrowershed[j]=sdt1.format(cal.getTime());
			
			cal.setTime(pur_date);
			cal.add(cal.DATE, intlayersh);
			strlayershed[j]=sdt1.format(cal.getTime());
			
			cal.setTime(pur_date);
			cal.add(cal.DATE, intFirstLay);
			strfirstlay[j]=sdt1.format(cal.getTime());
			
			cal.setTime(pur_date);
			cal.add(cal.DATE, intCulling);
			strculling[j]=sdt1.format(cal.getTime());
			
			remaining_days=(yr_end_date.getTime()-pur_date.getTime())/(1000*60*60*24);
			if(remaining_days<7)
				remaining_weeks=1;	
			else
			remaining_weeks=(int) (remaining_days/7);
			hshRemaining.put(j+"bwk","0");
			hshRemaining.put(j+"gwk","0");
			hshRemaining.put(j+"lwk","0");
			hshallocated.put(j+"bwkallo","0");
			hshallocated.put(j+"gwkallo","0");
			hshallocated.put(j+"lwkallo","0");
			hshallocated.put(j+"alloc","0");
			hshRemaining.put(j+"remainingweeks",String.valueOf(remaining_weeks));
			}
		}
		String strPurDate=PurchasedDate;
		int intPurYear=Integer.parseInt(strPurDate.substring(6, 10));
		for(int i=0;i<intPeriod;i++)
		{
			arrRow=new ArrayList();
			for(j=0;j<noofbatches;j++)
			{
				String strNo=Helper.correctInt(strShedNum[j]);
				int intShedNo=Integer.parseInt(strNo);
				arrCol=new ArrayList();
				arrCol.add(String.valueOf(j+1));
				arrCol.add(date[j]);
				bwkbal=Integer.parseInt(Helper.correctInt((String)hshRemaining.get(j+"bwk")));
				gwkbal=Integer.parseInt(Helper.correctInt((String)hshRemaining.get(j+"gwk")));
				lwkbal=Integer.parseInt(Helper.correctInt((String)hshRemaining.get(j+"lwk")));
				bwkalloc=Integer.parseInt(Helper.correctInt((String)hshallocated.get(j+"bwkallo")));
				gwkalloc=Integer.parseInt(Helper.correctInt((String)hshallocated.get(j+"gwkallo")));
				lwkalloc=Integer.parseInt(Helper.correctInt((String)hshallocated.get(j+"lwkallo")));
				intalloc=Integer.parseInt(Helper.correctInt((String)hshallocated.get(j+"alloc")));
				remaining_weeks=Integer.parseInt(Helper.correctInt((String)hshRemaining.get(j+"remainingweeks")));
				
				if(strNo.equalsIgnoreCase("0"))
				{
					for(int b=0;b<intShedCount;b++)
					{
						if(strShed[b]=="0")
						{
						strShedNum[j]=(b+1)+"";
						strShed[b]="1";
						break;
						}
					}
				}
				if(j>(i*intCheck))
				{
					String strNewDate=date[j];
					String strOldDate=date[j-1];
					newyr=strNewDate.substring(6, 10);
					oldyr=strOldDate.substring(6, 10);
					oldyri=Integer.parseInt(oldyr);
					newyri=Integer.parseInt(newyr);
				}
				if(intalloc==0 && remaining_weeks>0){
					if((j>(i*intCheck)) && oldyri!=newyri)
					{
						arrCol=new ArrayList();
						break;
					}
					if((remaining_weeks>=0)&& (bwkalloc==0))
					{
						if(remaining_weeks>=bwk)
						{
							remaining_weeks=remaining_weeks-bwk;
							arrCol.add(String.valueOf(bwk));
							hshallocated.put(j+"bwkallo","1");
						}
						else
						{
							bwkbal=bwk-remaining_weeks;
							arrCol.add(String.valueOf(remaining_weeks));
							remaining_weeks=0;
							hshRemaining.put(j+"bwk",String.valueOf(bwkbal));
						}
					}
					else{
						arrCol.add("0");
					}	
					if((remaining_weeks>=0) && (gwkalloc==0))
					{
						if(remaining_weeks>=gwk)
						{
							remaining_weeks=remaining_weeks-gwk;
							arrCol.add(String.valueOf(gwk));
							hshallocated.put(j+"gwkallo","1");
						
						}
						else
						{
							gwkbal=gwk-remaining_weeks;
							arrCol.add(String.valueOf(remaining_weeks));
							remaining_weeks=0;
							hshRemaining.put(j+"gwk",String.valueOf(gwkbal));
						}
					}
					else{
						arrCol.add("0");
					}
					if((remaining_weeks>=0) && (lwkalloc==0))
					{
						if(remaining_weeks>=lwk)
						{
							remaining_weeks=remaining_weeks-lwk;
							arrCol.add(String.valueOf(lwk));
							hshallocated.put(j+"lwkallo","1");
						}
						else
						{
							lwkbal=lwk-remaining_weeks;
							arrCol.add(String.valueOf(remaining_weeks));
							remaining_weeks=0;
							hshRemaining.put(j+"lwk",String.valueOf(lwkbal));
						}
					}
					else{
						arrCol.add("0");
					}
					if(bwkalloc==1 && gwkalloc==1 && lwkalloc==1){
						arrCol.add("cull");
						if(intShedNo==0)
							strShed[intShedNo]="0";
							else
								strShed[intShedNo-1]="0";
					}else{
						arrCol.add(" ");
					}
					hshallocated.put(j+"alloc","1");
				}
				else{
					remaining_weeks=52;
						if(bwkalloc==1 && gwkalloc==1 && lwkalloc==1){
							continue;
						}
						else if(bwkbal>0 || gwkbal>0 || lwkbal>0)
						{
							if((remaining_weeks>=bwk) && (bwkalloc==0))
							{
									remaining_weeks=remaining_weeks-bwkbal;
									arrCol.add(String.valueOf(bwkbal));
									bwkalloc=1;
									hshallocated.put(j+"bwkallo","1");
									hshRemaining.put(j+"bwk","0");
							}
							else if((remaining_weeks<bwk) && (bwkalloc==0)){
								if(remaining_weeks>=bwkbal)
								{
									remaining_weeks=remaining_weeks-bwkbal;
									arrCol.add(String.valueOf(bwkbal));
									bwkalloc=1;
									hshallocated.put(j+"bwkallo","1");
									hshRemaining.put(j+"bwk","0");
								}
								else
								{
								bwkbal=bwk-remaining_weeks;
								arrCol.add(String.valueOf(remaining_weeks));
								remaining_weeks=0;
								hshRemaining.put(j+"bwk",String.valueOf(bwkbal));
								}
								
							}
							else{
								arrCol.add("0");
							}
							if((remaining_weeks>=gwk) && (gwkalloc==0))
							{
								remaining_weeks=remaining_weeks-gwkbal;
								arrCol.add(String.valueOf(gwkbal));
								gwkalloc=1;
								hshallocated.put(j+"gwkallo","1");
								hshRemaining.put(j+"gwk","0");
							}
							else if((remaining_weeks<gwk) && (gwkalloc==0)){
								if(remaining_weeks>=gwkbal)
								{
									remaining_weeks=remaining_weeks-gwkbal;
									arrCol.add(String.valueOf(gwkbal));
									gwkalloc=1;
									hshallocated.put(j+"gwkallo","1");
									hshRemaining.put(j+"gwk","0");
								}else{
								gwkbal=gwk-remaining_weeks;
								arrCol.add(String.valueOf(remaining_weeks));
								remaining_weeks=0;
								hshRemaining.put(j+"gwk",String.valueOf(gwkbal));
								}
							}
							else{
								arrCol.add("0");
							}
							if((remaining_weeks>=lwk) && (lwkalloc==0))
							{
								remaining_weeks=remaining_weeks-lwkbal;
								arrCol.add(String.valueOf(lwkbal));
								lwkalloc=1;
								hshallocated.put(j+"lwkallo","1");
								hshRemaining.put(j+"lwk","0");
							}
							else if((remaining_weeks<lwk) && (lwkalloc==0))
							{
								if(remaining_weeks>=lwkbal)
								{
									remaining_weeks=remaining_weeks-lwkbal;
									arrCol.add(String.valueOf(lwkbal));
									lwkalloc=1;
									hshallocated.put(j+"lwkallo","1");
									hshRemaining.put(j+"lwk","0");
								}else{
								lwkbal=lwk-remaining_weeks;
								arrCol.add(String.valueOf(remaining_weeks));
								remaining_weeks=0;
								hshRemaining.put(j+"lwk",String.valueOf(lwkbal));
								}
							}
							else{
								arrCol.add("0");
							}
							if(bwkalloc==1 && gwkalloc==1 && lwkalloc==1){
								if(intShedNo==0)
								strShed[intShedNo]="0";
								else
									strShed[intShedNo-1]="0";
								arrCol.add("cull");
							}else{
								arrCol.add(" ");
							}
						}
						else{
							arrCol.add("0");
							arrCol.add("0");
							arrCol.add("0");
							arrCol.add(" ");
						}
				}
				
				arrCol.add(Helper.correctNull(strgrowershed[j]));//6
				arrCol.add(Helper.correctNull(strlayershed[j]));//7
				arrCol.add(Helper.correctNull(strfirstlay[j]));//8
				arrCol.add(Helper.correctNull(strculling[j]));//9
				arrCol.add("01/01/"+(intPurYear+i+1));//10
				arrCol.add(Helper.correctNull(strShedNum[j]));//11
				
				if(arrCol.size()>0)
			arrRow.add(arrCol);
			}
			arrlist.add(arrRow);
		}
		hshResult.put("arrlist",arrlist);
		hshResult.put("strNoofBatches",String.valueOf(noofbatches));
		hshResult.put("strArrShedNo",strShedNum);
	} 
		hshResult.put("strPurchaseDate",PurchasedDate);
		hshResult.put("strSchemetype",strSchemetype);
		hshResult.put("strAppno",strApplicationNo);
		hshResult.put("strPeriod",String.valueOf(intPeriod));
	}
	catch (Exception e) 
	{	
		throw new EJBException("Error in connection " + e.getMessage());
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
	
	
	
	
}
