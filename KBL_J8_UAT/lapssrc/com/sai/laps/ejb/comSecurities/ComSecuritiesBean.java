package com.sai.laps.ejb.comSecurities;

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
import com.sai.laps.helper.SetupParams;

@Stateless(name = "ComSecuritiesBean", mappedName = "ComSecuritiesHome")
@Remote (ComSecuritiesRemote.class)
public class ComSecuritiesBean extends BeanAdapter
{	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6664302505940162746L;
	
	


	static Logger log=Logger.getLogger(ComSecuritiesBean.class);	

	/**
	 * 
	 */

	public void updateData(HashMap hshValues)
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		
		String strAppno="";
		String strAction="";
		String strSecno="";
		String strFacsno="";
		String strSectype="";
		int intUpdatesize=0;
		String strQuery="",strsecvalue="",strsecnewval="";
		StringBuilder sbolddata=new StringBuilder();
		ResultSet rs=null,rs1 = null;
		try
		{
			strAction=correctNull((String)hshValues.get("hidAction"));
			strAppno=correctNull((String)hshValues.get("appno"));
			strSecno=correctNull((String)hshValues.get("hidsno"));
			strSectype=correctNull((String)hshValues.get("selsectype"));
			
			if(strSectype.equalsIgnoreCase("Primary"))
			{
				strFacsno=correctNull((String)hshValues.get("selfacility"));
			}
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				strQuery=SQLParser.getSqlQuery("selsecuritydetailsbysno^"+strSecno+"^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);	
				if(rs.next())
				{
					sbolddata.append("Security Type =").append(correctNull(rs.getString("sec_type")));
					if(correctNull(rs.getString("sec_type")).equalsIgnoreCase("Primary"))
					{
						String strFacilityName= "";
						strQuery=SQLParser.getSqlQuery("sel_facility_security_audit^"+strAppno+"^"+strAppno+"^"+strSecno);
						rs1=DBUtils.executeQuery(strQuery);	
						if(rs1.next()){
							strFacilityName = correctNull(rs1.getString("fac_desc")) +" - "+
							correctNull(rs1.getString("facilityhead")) +" - "+ correctNull(rs1.getString("facility_proposed"));
						}
						sbolddata.append(" ~ Facility type =").append(strFacilityName);
						sbolddata.append(" ~ Margin=").append(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(rs.getString("sec_margin")))));
					}
					sbolddata.append(" ~ Security =").append(correctNull(rs.getString("sec_name")));
					String strNature_charge=correctNull(rs.getString("sec_charge"));
					if(strNature_charge.equals("1"))
					{
						strNature_charge ="Exclusive";
					}else if(strNature_charge.equals("2"))
					{
						strNature_charge ="First & parri-passu";
					}else if(strNature_charge.equals("3"))
					{
						strNature_charge ="Second & Exclusive";
					}else if(strNature_charge.equals("4"))
					{
						strNature_charge ="Second & parri-passu";
					}else if(strNature_charge.equals("5"))
					{
						strNature_charge ="Subservient & Exclusive";
					}else if(strNature_charge.equals("6"))
					{
						strNature_charge ="Subservint & parri-passu";
					}else if(strNature_charge.equals("7"))
					{
						strNature_charge ="Unsecured";
					}
					sbolddata.append(" ~ Nature of Charge=").append(strNature_charge);
					
					sbolddata.append(" ~ Security Value=").append(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(rs.getString("sec_desc_value")))));
					sbolddata.append(" ~ Security Value as On =").append(correctNull(rs.getString("as_on_date")));
					sbolddata.append(" ~ Valuers Name=").append(correctNull(rs.getString("sec_valuersname")));
					sbolddata.append(" ~ Security Tenor=").append(correctNull(rs.getString("sec_tenor")));
					sbolddata.append(" ~ Insurance Amount=").append(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(rs.getString("sec_insuranceamt")))));
					sbolddata.append(" ~ Insurance Expiry Date=").append(correctNull(rs.getString("sec_insexpirydate")));
				}
			}
			
			if(strAction.equals("Insert"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
				strSecno=getMaxsecno(strAppno);
				arrValues.add(strAppno);
				arrValues.add(strSecno);
				arrValues.add(strSecno);
				arrValues.add(correctNull((String)hshValues.get("hidsecid")));
				arrValues.add(correctNull((String)hshValues.get("txtsecdetails")));
				arrValues.add(correctNull((String)hshValues.get("txtsecvalue")));
				arrValues.add(correctNull((String)hshValues.get("txtsecvaldate")));
				arrValues.add(correctNull((String)hshValues.get("txtsectenor")));
				arrValues.add(correctNull((String)hshValues.get("selsectype")));
				
				arrValues.add(correctNull((String)hshValues.get("txtvaluername")));
				arrValues.add(correctNull((String)hshValues.get("txtinsuranceamt")));
				arrValues.add(correctNull((String)hshValues.get("txtinsexpdate")));
				arrValues.add(correctNull((String)hshValues.get("txtremarks")));
				arrValues.add(strFacsno);
				
				arrValues.add(correctNull((String)hshValues.get("txtsecmargin")));
				arrValues.add(correctNull((String)hshValues.get("selcharge")));
				arrValues.add(correctNull((String)hshValues.get("txt_propertyownded")));
				arrValues.add(correctNull((String)hshValues.get("txt_legalopinion")));
				
				hshQuery.put("strQueryId","inssecuritydetails");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			else if(strAction.equals("Update"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
				
				arrValues.add(correctNull((String)hshValues.get("hidsecid")));
				arrValues.add(correctNull((String)hshValues.get("txtsecdetails")));
				strsecvalue=correctNull((String)hshValues.get("txtsecvalue"));
				if(strsecvalue!="")
				{
					strsecvalue=strsecvalue.replaceAll("," , "");
				}
				
				arrValues.add(correctNull(strsecvalue));
				arrValues.add(correctNull((String)hshValues.get("txtsecvaldate")));
				arrValues.add(correctNull((String)hshValues.get("txtsectenor")));
				arrValues.add(correctNull((String)hshValues.get("selsectype")));
				
				arrValues.add(correctNull((String)hshValues.get("txtvaluername")));
				arrValues.add(correctNull((String)hshValues.get("txtinsuranceamt")));
				arrValues.add(correctNull((String)hshValues.get("txtinsexpdate")));
				arrValues.add(correctNull((String)hshValues.get("txtremarks")));
				arrValues.add(strFacsno);
				
				arrValues.add(correctNull((String)hshValues.get("txtsecmargin")));
				arrValues.add(correctNull((String)hshValues.get("selcharge")));
				arrValues.add(correctNull((String)hshValues.get("txt_propertyownded")));
				arrValues.add(correctNull((String)hshValues.get("txt_legalopinion")));
				
				arrValues.add(strAppno);
				arrValues.add(strSecno);
				hshQuery.put("strQueryId","updsecuritydetails");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			else if(strAction.equals("Delete"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
				
				arrValues.add(strAppno);
				arrValues.add(strSecno);
				hshQuery.put("strQueryId","delsecuritydetails");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			
			hshQueryValues.put("size",""+intUpdatesize);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			StringBuilder sbAt = new StringBuilder();
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("Insert")){
			sbAt.append("Security Type =").append(correctNull((String) hshValues.get("selsectype")));
			if(strSectype.equalsIgnoreCase("Primary"))
			{
				sbAt.append(" ~ Facility type =").append(correctNull((String) hshValues.get("hid_txt_facility_head")));
				sbAt.append(" ~ Margin=").append(correctNull((String) hshValues.get("txtsecmargin")));
			}
			sbAt.append(" ~ Security =").append(correctNull((String) hshValues.get("txtsecdesc")));
			sbAt.append(" ~ Nature of Charge=").append(correctNull((String) hshValues.get("hid_txt_nature_charge")));
			strsecnewval=correctNull((String) hshValues.get("txtsecvalue"));
			if(strsecnewval!="")
			{
				strsecnewval=strsecnewval.replaceAll("," , "");
			}
			sbAt.append(" ~ Security Value=").append(strsecnewval);
			sbAt.append(" ~ Security Value as On =").append(correctNull((String) hshValues.get("txtsecvaldate")));
			sbAt.append(" ~ Valuers Name=").append(correctNull((String) hshValues.get("txtvaluername")));
			sbAt.append(" ~ Security Tenor=").append(correctNull((String)hshValues.get("txtsectenor")));
			sbAt.append(" ~ Insurance Amount=").append(correctNull((String)hshValues.get("txtinsuranceamt")));
			sbAt.append(" ~ Insurance Expiry Date=").append(correctNull((String) hshValues.get("txtinsexpdate")));
			}
			
			AuditTrial.auditNewLog(hshValues,"208",strAppno,sbAt.toString(),sbolddata.toString());
		}catch(Exception ex)
		{
			throw new EJBException("Error in updateData of ComSecuritiesBean :: "+ex.toString());
		}
	}
	
	private String getMaxsecno(String strAppno) 
	{
		String strSecno="";
		ResultSet rs=null;
		String strQuery="";
		try
		{
			strQuery=SQLParser.getSqlQuery("selmaxsecuritydetails^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strSecno=rs.getString("snomax");
			}
			
		}catch(Exception ex)
		{
			throw new EJBException("Error in getMaxsecno :: "+ex.toString());
		}
		finally
		{
			try{
				if(rs!=null)
					rs.close();
			}catch(Exception ex)
			{
				throw new EJBException("Error in Closing Connection"+ex.toString());
			}
		}
		return strSecno;
	}
	
	public HashMap getData(HashMap hshValues)
	{
		HashMap hshRecord=null;
		
		ResultSet rs=null;
		
		String strAppno="";
		String strQuery="";
		
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		boolean recordflag=false;
		try
		{
			hshRecord=new HashMap();
			strAppno=correctNull((String)hshValues.get("appno"));
			
			strQuery=SQLParser.getSqlQuery("selsecuritydetails^"+strAppno);
			
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs.getString("sec_srlno")));
				arrCol.add(correctNull(rs.getString("sec_desc_id")));
				arrCol.add(correctNull(rs.getString("sec_name")));
				arrCol.add(correctNull(rs.getString("sec_desc_details")));
				arrCol.add(correctNull(rs.getString("sec_desc_value")));
				arrCol.add(correctNull(rs.getString("as_on_date")));
				arrCol.add(correctNull(rs.getString("sec_tenor")));
				arrCol.add(correctNull(rs.getString("sec_type")));
				arrCol.add(correctNull(rs.getString("sec_valuersname")));
				arrCol.add(correctNull(rs.getString("sec_insuranceamt")));
				arrCol.add(correctNull(rs.getString("sec_insexpirydate")));
				arrCol.add(correctNull(rs.getString("sec_remarks")));
				arrCol.add(correctNull(rs.getString("sec_facsno")));
				arrCol.add(correctNull(rs.getString("sec_margin")));
				arrCol.add(correctNull(rs.getString("sec_charge")));
				arrCol.add(correctNull(rs.getString("sec_ownedby")));
				arrCol.add(correctNull(rs.getString("sec_legalopinion")));
				arrRow.add(arrCol);
				recordflag=true;
			}
			hshRecord.put("arrRow",arrRow);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
		}catch(Exception ex)
		{
			throw new EJBException("Error in updateData of ComSecuritiesBean :: "+ex.toString());
		}
		return hshRecord;
	}
	public void updateChargeData(HashMap hshValues)
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		
		String strAppno="";
		String strAction="";
		String strFacility="";
		String strCharge="";
		String strSecurities[]=null;
		int intUpdatesize=0;
		try
		{
			strAction=correctNull((String)hshValues.get("hidAction"));
			strAppno=correctNull((String)hshValues.get("appno"));
			strFacility=correctNull((String)hshValues.get("selfacility"));
			strCharge=correctNull((String)hshValues.get("selcharge"));
			strSecurities=correctNull((String)hshValues.get("hidsecurities")).split("@");
			
			if(strAction.equals("Update"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
				
				arrValues.add(strCharge);
				arrValues.add(strFacility);
				arrValues.add(strAppno);
				hshQuery.put("strQueryId","delsecuritychargedetails");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
				for(int i=0;i<strSecurities.length;i++)
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
				
					arrValues.add(strAppno);
					arrValues.add(strFacility);
					arrValues.add(strCharge);
					arrValues.add(strSecurities[i]);
					arrValues.add(strSecurities[i]);
					hshQuery.put("strQueryId","inssecuritychargedetails");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
				}
			}
			else if(strAction.equals("Delete"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
				
				arrValues.add(strCharge);
				arrValues.add(strFacility);
				arrValues.add(strAppno);
				hshQuery.put("strQueryId","delsecuritychargedetails");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			hshQueryValues.put("size",""+intUpdatesize);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
		
		}catch(Exception ex)
		{
			throw new EJBException("Error in updateChargeData of ComSecuritiesBean :: "+ex.toString());
		}
	}
	
	public HashMap getChargeData(HashMap hshValues)
	{
		HashMap hshRecord=null;
		
		ResultSet rs=null;
		
		String strAppno="";
		String strQuery="";
		String strFacility="";
		String strCharge="";
		String strSecurities="";
		
		try
		{
			hshRecord=new HashMap();
			strAppno=correctNull((String)hshValues.get("appno"));
			strFacility=correctNull((String)hshValues.get("selfacility"));
			strCharge=correctNull((String)hshValues.get("selcharge"));
			
			if(!strFacility.equals("") && !strCharge.equals(""))
			{
				strQuery=SQLParser.getSqlQuery("selsecuritychargedetails^"+strCharge+"^"+strFacility+"^"+strAppno);
				
				rs=DBUtils.executeQuery(strQuery);
			
				while(rs.next())
				{
					strSecurities=strSecurities+correctNull(rs.getString("sec_srlno"))+"@";
				}
			}
			
			hshRecord.put("facilitysno",strFacility);
			hshRecord.put("naturecharge",strCharge);
			hshRecord.put("secutities",strSecurities);
			
		}catch(Exception ex)
		{
			throw new EJBException("Error in updateData of ComSecuritiesBean :: "+ex.toString());
		}
		return hshRecord;
	}
	
	/*public HashMap getSeuritiesData(HashMap hshValues)
	{
		HashMap hshRecord=null;
		
		ResultSet rs=null;
		
		String strAppno="";
		String strQuery="";
		
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		try
		{
			hshRecord=new HashMap();
			strAppno=correctNull((String)hshValues.get("appno"));
			
			strQuery=SQLParser.getSqlQuery("selsecuritybytype^"+strAppno+"^Collateral");
			
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(rs.getString("sec_srlno"));
				arrCol.add(rs.getString("sec_name"));
				arrCol.add(rs.getString("sec_desc_details"));
				arrCol.add(rs.getString("sec_desc_value"));
				arrCol.add(rs.getString("as_on_date"));
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
		}catch(Exception ex)
		{
			throw new EJBException("Error in getSeuritiesData of ComSecuritiesBean :: "+ex.toString());
		}
		return hshRecord;
	}*/
}