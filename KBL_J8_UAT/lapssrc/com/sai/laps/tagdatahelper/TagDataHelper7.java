package com.sai.laps.tagdatahelper;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.jms.Session;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

public class TagDataHelper7 extends BeanAdapter {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(TagDataHelper7.class);
	
	public HashMap getStaticDataHeads(HashMap hshValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
		try
		{
			
			rs = DBUtils.executeLAPSQuery("getstaticdataheads");
			
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));
				vecCol.add(correctNull(rs.getString(2)));
				vecRow.add(vecCol);	
			}
			hshRecord.put("vecRow",vecRow);	
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getStaticDataHeads "+ce.toString());
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
	
	public HashMap getRestrAccounts(HashMap hshValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
		try
		{			
			String strQuery = SQLParser.getSqlQuery("sel_restracc^"+Helper.correctNull((String)hshValues.get("appno")));
			rs = DBUtils.executeQuery(strQuery);
			
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));
				vecCol.add(correctNull(rs.getString(1)));
				vecRow.add(vecCol);	
			}
			hshRecord.put("vecRow",vecRow);	
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getStaticDataHeads "+ce.toString());
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
	public HashMap getintDefermentAccounts(HashMap hshValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
		String appid= Helper.correctNull((String)hshValues.get("appid"));
		try
		{			
			if(!appid.equalsIgnoreCase(""))
			{
			String strQuery = SQLParser.getSqlQuery("sel_intdefermentacc^"+appid+"^"+appid);
			rs = DBUtils.executeQuery(strQuery);
			
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString("cbs_accountno")));
				vecCol.add(correctNull(rs.getString("cbs_accountno")));
				vecRow.add(vecCol);	
			}
			}
			hshRecord.put("vecRow",vecRow);	
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getStaticDataHeads "+ce.toString());
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
	
  public HashMap getCBSStaticData(HashMap hshValues) 
	{
	
	    ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol= new ArrayList();
		ArrayList vecRow= new ArrayList();	
		try
		{
			
			rs = DBUtils.executeLAPSQuery("cbsgetstaticdataheads");
			
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));
				vecCol.add(correctNull(rs.getString(2)));
				vecRow.add(vecCol);	
			}
			hshRecord.put("vecRow",vecRow);	
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getStaticDataHeads "+ce.toString());
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
	
	public HashMap getHouseLoanData(HashMap hshValues) 
	{	
		
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
		
		try
		{
		
			rs = DBUtils.executeLAPSQuery("sel_houseloandate");
			
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));
				vecRow.add(vecCol);	
			}
			hshRecord.put("vecRow",vecRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getHouseLoanData "+ce.toString());
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
	
	public HashMap getstaticdataData(HashMap hshValues) 
	{	
		
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
		
		try
		{
			
			String strstatecode= correctNull((String)hshValues.get("apptype"));
			rs = DBUtils.executeLAPSQuery("selstaticdata^"+strstatecode);
			
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));
				vecCol.add(correctNull(rs.getString(2)));
				vecRow.add(vecCol);	
			}
			hshRecord.put("vecRow",vecRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getDataHoliday "+ce.toString());
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
	
	
	public HashMap getstaticdataDataNew(HashMap hshValues) 
	{	
		
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
		
		try
		{
			
			String strstatecode= correctNull((String)hshValues.get("apptype"));
			String strQuery1 = SQLParser.getSqlQuery("selstaticdatanew^"+strstatecode);
			rs = DBUtils.executeQuery(strQuery1);
			
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));
				vecCol.add(correctNull(rs.getString(2)));
				vecRow.add(vecCol);	
			}
			hshRecord.put("vecRow",vecRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getDataHoliday "+ce.toString());
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
	
	
	
	public HashMap getFacilityName(HashMap hshValues) 
	{		
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol= new ArrayList();
		ArrayList vecRow= new ArrayList();	
		
		try
		{	

			String appno= correctNull((String)hshValues.get("appno"));
			rs = DBUtils.executeLAPSQuery("facilities_ramfacilitylist_select^"+appno);
			hshRecord = new HashMap();
				while(rs.next())
				{
					vecCol = new ArrayList();
					vecCol.add(correctNull(rs.getString("facility_sno")));
					vecCol.add(correctNull(rs.getString("facilityhead")) + " - " +
							correctNull(rs.getString("fac_desc")) +" - " +
							rs.getDouble("facility_sancamt"));
					vecRow.add(vecCol);	
				}

			hshRecord.put("vecRow",vecRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in TagDataHelper7 --> getFacilityName "+ce.toString());
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
	public HashMap getTerFacilityName(HashMap hshValues) 
	{		
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol= new ArrayList();
		ArrayList vecRow= new ArrayList();	
		
		try
		{	
			
			String appno= correctNull((String)hshValues.get("appno"));
			//for corporate sanctiondetails
			
			rs = DBUtils.executeLAPSQuery("facilities_ramfacilitylist_select^"+appno);
				
				hshRecord = new HashMap();
				while(rs.next())
				{
					vecCol = new ArrayList();
					vecCol.add(correctNull(rs.getString("facility_sno")));
					vecCol.add(correctNull(rs.getString("facilityhead")) + " - " +
							correctNull(rs.getString("fac_desc")) +" - " +
							rs.getDouble("facility_sancamt"));
					vecRow.add(vecCol);	
				}
			
				hshRecord.put("vecRow",vecRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in TagDataHelper7 --> getTerFacilityName "+ce.toString());
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
/*	public HashMap getNPAapplicationno(HashMap hshValues) 
	{
		
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecRow = new ArrayList();	
		String strAppid=Helper.correctNull((String)hshValues.get("appid"));
		String strApptype=Helper.correctNull((String)hshValues.get("apptype"));
		String strModuletype=Helper.correctNull((String)hshValues.get("moduletype"));
		try
		{
			
			//rs = DBUtils.executeLAPSQuery("sel_npaapplicationno^"+strModuletype+"^"+strAppid+"^"+strApptype);
			
			//strQuery=SQLParser.getSqlQuery("sel_npaapplicationno^"+strModuletype+"^"+strAppid+"^"+strApptype);
			rs =DBUtils.executeLAPSQuery("sel_npaapplicationno^"+strModuletype+"^"+strAppid+"^"+strApptype);
			
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecRow.add(correctNull(rs.getString("npa_appno")));
			}
			hshRecord.put("vecRow",vecRow);	
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getNPAAppno "+ce.toString());
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
	}*/
	public HashMap getMonAccno(HashMap hshValues) 
	{
		
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecRow = new ArrayList();	
		String strcbsid=Helper.correctNull((String)hshValues.get("cbsid"));
		//String strcbsid="214";
		try
		{
			rs =DBUtils.executeLAPSQuery("sel_monitoraccno^"+strcbsid);
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecRow.add(correctNull(rs.getString("limit_cutaccno")));
			}
			hshRecord.put("vecRow",vecRow);	
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getNPAAppno "+ce.toString());
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
	
	/** Method to get the Description of Data based on the 'Id' and 'Value'
	 * Added by Gokulakrishnan.C
	 * @param strId
	 * @param strDesc
	 * @return
	 * @
	 */
	public String getStaticDataDesc(String strId,String strDesc) 
	{
		String strValue = "";
		ResultSet rs = null;
		try{
			rs =DBUtils.executeLAPSQuery("sel_static_desc^"+strId+"^"+strDesc);
			if(rs.next())
			{
				strValue  = Helper.correctNull((String)rs.getString("stat_data_desc1"));
			}
		}catch(Exception e)
		{
			log.error("Exception in getStaticData in TagDataHelper7 "+e.getMessage());
		}finally{
			try{
				if(rs!=null)
					rs.close();
			}catch(Exception ce)
			{
				log.error("Exception in closing connection in getStaticData of TagDataHelper7 "
						+ce.getMessage());
			}
		}
		return strValue;
	}
	
	/** Method to get the Description of Data based on the 'Id' and 'Value'
	 * Added by R.Paulraj
	 * @param strId
	 * @param strDesc
	 * @return
	 * @
	 */
	
	public HashMap getFacilityDataDesc(String strNpaAppno) 
	{
		
		HashMap hshValues = new HashMap();
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol = new ArrayList();
		ResultSet rs = null;
		
		try
		{
			rs =DBUtils.executeLAPSQuery("get_npafacility_data_tag^"+strNpaAppno);
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString("PRE_NATURE")));
				vecCol.add(correctNull(rs.getString("facility")));
				vecRow.add(vecCol);	
			}
			
			hshValues.put("vecRow",vecRow);
		}
		catch(Exception e)
		{
			log.error("Exception in getFacilityDataDesc in TagDataHelper7 "+e.getMessage());
		}
		finally
		{
			try
			{
				if(rs!=null)
					rs.close();
			}
			catch(Exception ce)
			{
				
				log.error("Exception in closing connection in getFacilityDataDesc of TagDataHelper7"+ce.getMessage());
			}
		}
		return hshValues;
	}
	
	public HashMap getPrimeSecurities(HashMap hshValues) 
	{	
		
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList arrCol= new ArrayList();
		ArrayList arrRow= new ArrayList();	
		
		try
		{
			
			String strAppno= correctNull((String)hshValues.get("appno"));
			rs = DBUtils.executeLAPSQuery("selsecuritybytype^"+strAppno+"^Primary");
			
			hshRecord = new HashMap();
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("sec_srlno")));
				arrCol.add(correctNull(rs.getString("sec_desc_details")));
				arrRow.add(arrCol);	
			}
			hshRecord.put("vecRow",arrRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getDataHoliday "+ce.toString());
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
	
	
	public HashMap getSecInsuMapData(HashMap hshValues) 
	{	
		
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
		
		try
		{
			
			String strAccNo= correctNull((String)hshValues.get("Accno"));
			rs = DBUtils.executeLAPSQuery("sel_monsecurity^"+strAccNo);
			
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString("SECURITYTYPE")));//0
				log.info("====>>>>>>>........"+correctNull(rs.getString("SECURITYTYPE")));
				vecCol.add(correctNull(rs.getString("STAT_DATA_DESC1")));//1
				vecCol.add(correctNull(rs.getString("MONSEC_VALUATAMOUNT")));//2
				vecCol.add(correctNull(rs.getString("MONSEC_SNO")));//3
				log.info("====>>>>>>>........"+correctNull(rs.getString("MONSEC_SNO")));
				vecRow.add(vecCol);	
			}
			hshRecord.put("vecRow",vecRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getDataHoliday "+ce.toString());
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
	
	
	public HashMap getMonInsurance(HashMap hshValues) 
	{	
		
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList arrCol= new ArrayList();
		ArrayList arrRow= new ArrayList();	
		
		try
		{
			
			String strAppno= correctNull((String)hshValues.get("accno"));
			String strCbsid= correctNull((String)hshValues.get("cbsid"));
			
			rs = DBUtils.executeLAPSQuery("get_insurance_register^"+strAppno+"^"+strCbsid);
			
			hshRecord = new HashMap();
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("ins_seqid")));
				arrCol.add(correctNull(rs.getString("ins_policyno")));
				arrCol.add(correctNull(rs.getString("ins_coveramt")));
				arrRow.add(arrCol);	
			}
			hshRecord.put("vecRow",arrRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getMonInsurance "+ce.toString());
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
	public HashMap getTermLoanReviewFacilities(HashMap hshRequestValues)
	 {
ResultSet rs = null;
ArrayList arrFacilities = new ArrayList();
ArrayList arrFacilityId = new ArrayList();
ArrayList arrFacAccno = new ArrayList();
HashMap hshRecord = new HashMap();
String appno = correctNull((String) hshRequestValues.get("appno"));

try {
	hshRecord = new HashMap();
	rs = DBUtils.executeLAPSQuery("tlr_facilities_select^" + appno);
	while (rs.next()) {
		arrFacilityId.add(correctNull(rs.getString("tlr_facno")));
		arrFacilities.add(correctNull(rs.getString("tlr_facname")));
		arrFacAccno.add(correctNull(rs.getString("tlr_cbsaccno")));
	}
	hshRecord.put("arrFacilities", arrFacilities);
	hshRecord.put("arrFacilityId", arrFacilityId);
	hshRecord.put("arrFacAccno",arrFacAccno);
} catch (Exception ce) {
	throw new EJBException("Error in getData login  " + ce.toString());
} finally {
	try {
		if (rs != null)
			rs.close();
	} catch (Exception cf) {
		throw new EJBException("Error closing the connection "
				+ cf.getMessage());
	}
}
return hshRecord;
}
	// Created By Venkat Prasad Chowdary for Securities on 26-APR-2013
	public HashMap getstaticdataSecurities(HashMap hshValues) 
	{	
		
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	

		try
		{
			String strParenttype= correctNull((String)hshValues.get("parenttype"));
			if(rs !=null)
				rs.close();
			
			if(strParenttype.equals("!0"))
				rs = DBUtils.executeLAPSQuery("selSecurityType_valuers^0");
			else
				rs = DBUtils.executeLAPSQuery("selstaticdata_security^"+strParenttype);

			hshRecord = new HashMap();
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));
				vecCol.add(correctNull(rs.getString(2)));
				vecRow.add(vecCol);	
			}
			hshRecord.put("vecRow",vecRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getDataHoliday "+ce.toString());
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
	public HashMap getSchemeStaticdataData(HashMap hshValues) 
	{	
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol=null;
		ArrayList vecRow=null;	
		
		try
		{
			vecRow		= new ArrayList();
			String strstatecode= correctNull((String)hshValues.get("apptype"));
			rs = DBUtils.executeLAPSQuery("set_staticdata_tag7_scheme_select^"+strstatecode);
			
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull((String)rs.getString(2)));
				vecCol.add(correctNull((String)rs.getString(3)));
				vecCol.add(correctNull((String)rs.getString(4)));
				vecCol.add(correctNull((String)rs.getString(5)));
				vecRow.add(vecCol);	
			}
			hshRecord.put("vecRow",vecRow);				
		}
		catch(Exception ce)
		{
			throw new EJBException("Exception in getSchemeStaticdataData"+ce.toString());
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
				throw new EJBException("Exception in ResultSet "+cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	//Added by Arsath on 28/06/2013
	
	public HashMap getCBSstaticdataDataNew(HashMap hshValues) 
	{	
		
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
		
		try
		{
			
			String strstatecode= correctNull((String)hshValues.get("apptype"));
			rs = DBUtils.executeLAPSQuery("selCBSstaticdatanew^"+strstatecode);
			
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));
				vecCol.add(correctNull(rs.getString(2)));
				vecRow.add(vecCol);	
			}
			hshRecord.put("vecRow",vecRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getDataHoliday "+ce.toString());
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
	
	  public HashMap getMISStaticData(HashMap hshValues) 
		{
		
		    ResultSet rs = null;
			HashMap hshRecord = null;
			ArrayList vecCol= new ArrayList();
			ArrayList vecRow= new ArrayList();	
			try
			{
				
				rs = DBUtils.executeLAPSQuery("misgetstaticdataheads");
				
				hshRecord = new HashMap();
				while(rs.next())
				{
					vecCol = new ArrayList();
					vecCol.add(correctNull(rs.getString(1)));
					vecCol.add(correctNull(rs.getString(2)));
					vecRow.add(vecCol);	
				}
				hshRecord.put("vecRow",vecRow);	
			}
			catch(Exception ce)
			{
				log.error(ce.toString());
				throw new EJBException("Error in getMISStaticDataHeads "+ce.toString());
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
	  
	//Added by Arsath on 28/06/2013
		
		public HashMap getBanksSchemestaticdataDataNew(HashMap hshValues) 
		{	
			
			ResultSet rs = null;
			HashMap hshRecord = null;
			ArrayList vecCol		= new ArrayList();
			ArrayList vecRow		= new ArrayList();	
			String strStatus=Helper.correctNull(((String)hshValues.get("strStatus")));
			try
			{
				String strstatecode= correctNull((String)hshValues.get("apptype"));
				rs = DBUtils.executeLAPSQuery("sel_misstaticdata_common1^"+strstatecode);
				
				hshRecord = new HashMap();
				while(rs.next())
				{
					if(strStatus.equalsIgnoreCase("ca")||strStatus.equalsIgnoreCase("pa")||strStatus.equalsIgnoreCase("pr")||strStatus.equalsIgnoreCase("cr"))
					{
						vecCol = new ArrayList();
						vecCol.add(correctNull(rs.getString(1)));
						vecCol.add(correctNull(rs.getString(2)));
						vecRow.add(vecCol);	
					}
					else if(Helper.correctNull(rs.getString("mis_static_data_show")).equalsIgnoreCase("E"))
					{
						vecCol = new ArrayList();
						vecCol.add(correctNull(rs.getString(1)));
						vecCol.add(correctNull(rs.getString(2)));
						vecRow.add(vecCol);
					}
				}
				hshRecord.put("vecRow",vecRow);				
			}
			catch(Exception ce)
			{
				log.error(ce.toString());
				throw new EJBException("Error in getBanksSchemestaticdataDataNew "+ce.toString());
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
		/*
		 * Added by Karthikeyan.S for MISDataTag on 25/07/2013
		 */
	public HashMap getMISData(HashMap hshValues) 
	{	
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
		try
		{
			String strstatecode= correctNull((String)hshValues.get("apptype"));
			rs = DBUtils.executeLAPSQuery("sel_misstaticdatamaster^"+strstatecode);
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));
				vecCol.add(correctNull(rs.getString(2)));
				vecRow.add(vecCol);	
			}
			hshRecord.put("vecRow",vecRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getMISData "+ce.toString());
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
	public HashMap getBSRCodeData(HashMap hshValues) 
	{	
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
		try
		{
			String strstatecode= correctNull((String)hshValues.get("apptype"));
			rs = DBUtils.executeLAPSQuery("sel_BSRCode");
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));
				vecCol.add(correctNull(rs.getString(2)));
				vecRow.add(vecCol);	
			}
			hshRecord.put("vecRow",vecRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getMISData "+ce.toString());
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
	/*
	 * Added by Karthikeyan.S for MISDataTag on 25/07/2013
	 */
	public HashMap getMISPurposeData(HashMap hshValues) 
	{	
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
		try
		{
			String strstatecode= correctNull((String)hshValues.get("apptype"));
			rs = DBUtils.executeLAPSQuery("sel_misstaticdatamaster^"+strstatecode);
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));
				vecCol.add(correctNull(rs.getString(2)));
				vecCol.add(correctNull(rs.getString(4)));
				vecRow.add(vecCol);	
			}
			hshRecord.put("vecRow",vecRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getMISData "+ce.toString());
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
	/*
	 * Added by Karthikeyan.S for MISActivityCodeTag on 28/09/2013
	 */
	public HashMap getMISActivityCodeData(HashMap hshValues) 
	{	
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
		try
		{
			String strstatecode= correctNull((String)hshValues.get("apptype"));
			rs = DBUtils.executeLAPSQuery("sel_ActivityCode^3");
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));
				vecCol.add(correctNull(rs.getString(2)));
				vecCol.add(correctNull(rs.getString(3)));
				vecRow.add(vecCol);	
			}
			hshRecord.put("vecRow",vecRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getMISData "+ce.toString());
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
	public HashMap getRetailQuestionMast(HashMap hshValues) 
	{	
		
		String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
		
		try
		{
			
			String strstatecode= correctNull((String)hshValues.get("apptype"));
			if(strstatecode.equalsIgnoreCase("5"))
			{
			rs = DBUtils.executeLAPSQuery("SelStaticDataCorpQuestionMastIndustry^"+strstatecode);
			}
			else	
			{
			rs = DBUtils.executeLAPSQuery("SelStaticDataCorpQuestionMast^"+strstatecode);
			}
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));
				vecCol.add(correctNull(rs.getString(2)));
				vecCol.add(correctNull(rs.getString(3)));
				vecRow.add(vecCol);	
			}
			hshRecord.put("vecRow",vecRow);				
		}
		catch(Exception ce)
		{
			
			throw new EJBException("Error in getDataHoliday "+ce.toString());
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
	//Added By Karthikeyan.S For Listing Working Capital Facilities on 23/11/2013
	public HashMap getWCFacilitiesData(HashMap hshValues) 
	{	
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
		try
		{
			String strWCVal= correctNull((String)hshValues.get("apptype"));
			rs = DBUtils.executeLAPSQuery("sel_Facilities_WC^c^c^"+strWCVal);
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));
				vecCol.add(correctNull(rs.getString(2)));
				vecRow.add(vecCol);	
			}
			hshRecord.put("vecRow",vecRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getMISData "+ce.toString());
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
	public HashMap getFacilitySno(HashMap hshValues) 
	{	
		
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList arrCol= new ArrayList();
		ArrayList arrRow= new ArrayList();	
		
		try
		{
			
			String strAppno= correctNull((String)hshValues.get("apptype"));
			String strPage=correctNull((String)hshValues.get("pagefrom"));
			
			if(strPage.equalsIgnoreCase("FVC"))
			{
				rs = DBUtils.executeLAPSQuery("sel_facilitycodedesc_FVC^"+strAppno);
			}
			else if(strPage.equalsIgnoreCase("PS"))
			{
				rs = DBUtils.executeLAPSQuery("sel_facilitycodedesc_PS^"+strAppno);
			}
			else if(strPage.equalsIgnoreCase("restr"))
			{
				rs = DBUtils.executeLAPSQuery("sel_facilitycodedesc_restr^"+strAppno);
			}
			else if(strPage.equalsIgnoreCase("pro"))
			{
				rs = DBUtils.executeLAPSQuery("sel_facilitycodedesc_promotors^"+strAppno);
			}
			else if(strPage.equalsIgnoreCase("mclr"))
			{
				rs = DBUtils.executeLAPSQuery("sel_facilitycodedesc_mclr^"+strAppno);
			}
			else if(strPage.equalsIgnoreCase("dds"))
			{
			    rs = DBUtils.executeLAPSQuery("sel_dds^"+strAppno);
			}			
			else if(strPage.equalsIgnoreCase("CGTMSE"))
			{
				rs = DBUtils.executeLAPSQuery("sel_facilityfilterdesc^"+strAppno);
			}
			else if(strPage.equalsIgnoreCase("dpn"))
			{
			    rs = DBUtils.executeLAPSQuery("sel_dpnfacilities^"+strAppno);
			}			
			else if(!strPage.equalsIgnoreCase("rat") && !strPage.equalsIgnoreCase("NCGTC"))
			{
			    rs = DBUtils.executeLAPSQuery("sel_facilitycodedesc^"+strAppno);
			}
			else if(!strPage.equalsIgnoreCase("cgssd") && !strPage.equalsIgnoreCase("NCGTC"))
			{
			    rs = DBUtils.executeLAPSQuery("sel_facilityfilterdesc_cgssd^"+strAppno);
			}
			else if(strPage.equalsIgnoreCase("NCGTC"))
			{
			    rs = DBUtils.executeLAPSQuery("sel_facilitycodedesc_ncgtccode^"+strAppno);
			}
			else
			{
				rs = DBUtils.executeLAPSQuery("sel_facilitycodedesc_groupby^"+strAppno);	
			}
			
			
			hshRecord = new HashMap();
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("facility_sno")));
				arrCol.add(correctNull(rs.getString("com_facdesc")));
				arrRow.add(arrCol);	
			}
			hshRecord.put("arrRow",arrRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getFacilitySno "+ce.toString());
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
 
	//Added By Karthikeyan.S For Listing All Facilities on 26/11/2013
	public HashMap getGCFacilitiesData(HashMap hshValues) 
	{	
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
		try
		{
			rs = DBUtils.executeLAPSQuery("sel_Facilities_GC^c^c");
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));
				vecCol.add(correctNull(rs.getString(2)));
				vecCol.add(correctNull(rs.getString(3)));
				vecRow.add(vecCol);	
			}
			hshRecord.put("vecRow",vecRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getMISData "+ce.toString());
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
	//for BA Facility Description by Amaravathi
	public HashMap getBAFacilitiesData(HashMap hshValues) 
	{	
		ResultSet rs = null , rs1=null;
		HashMap hshRecord = null;
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
		try
		{
			String appno= correctNull((String)hshValues.get("appno"));
			String bankflag= correctNull((String)hshValues.get("bankflag"));
			
			if(bankflag.equalsIgnoreCase("our"))
			{
			//Facilities
			rs = DBUtils.executeLAPSQuery("sel_BAFacilityName^"+appno);
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString("facility_id")));
				vecCol.add(correctNull(rs.getString("facility_nature")));
				vecCol.add(correctNull(rs.getString("com_facdesc")));
				vecCol.add(correctNull(rs.getString("facility_sno")));
				vecCol.add("P");
				vecCol.add(correctNull(rs.getString("facility_propbanktype")));
				vecRow.add(vecCol);	
			
			}
			
			//Our
				if(rs!=null){rs.close();}
				rs = DBUtils.executeLAPSQuery("sel_BAFacilityNameOur^"+appno);
				hshRecord = new HashMap();
				while(rs.next())
				{
					String strFacility=Helper.correctNull((String)rs.getString("combk_facility"));
					String strFacilityCode[]=strFacility.split("~");
					String strFacilityId=strFacilityCode[1];
					String strFacilityFor=Helper.correctNull((String)rs.getString("combk_modtype"));
					String strFacilityDesc="";
					if(strFacilityFor.equalsIgnoreCase("r"))
					{
						rs1	= DBUtils.executeLAPSQuery("selLoanPurpose^"+strFacilityId);
					}
					else
					{
						rs1	= DBUtils.executeLAPSQuery("sel_facilitycorp^"+strFacilityId);
					}
					if(rs1.next())
					{
						strFacilityDesc=Helper.correctNull((String)rs1.getString("prddesc"));
					}
					
					vecCol = new ArrayList();
					vecCol.add(correctNull(rs.getString("combk_facility")));
					vecCol.add(correctNull(rs.getString("combk_type")));
					vecCol.add(strFacilityDesc);
					vecCol.add(correctNull(rs.getString("combk_id")));
					vecCol.add(correctNull(rs.getString("combk_credittype")));
					vecCol.add(correctNull(rs.getString("combk_bnktype")));
					vecRow.add(vecCol);	
				}
			}
			
			//Other
			if(bankflag.equalsIgnoreCase("other"))
			{
				if(rs!=null){rs.close();}
				rs = DBUtils.executeLAPSQuery("sel_BAFacilityNameOther^"+appno);
				hshRecord = new HashMap();
				while(rs.next())
				{
					vecCol = new ArrayList();
					vecCol.add("0");
					vecCol.add(correctNull(rs.getString("combk_type")));
					vecCol.add(correctNull(rs.getString("combk_facility")));
					vecCol.add(correctNull(rs.getString("combk_id")));
					vecCol.add(correctNull(rs.getString("combk_credittype")));
					vecCol.add(correctNull(rs.getString("combk_bnktype")));
					vecRow.add(vecCol);	
				}
			}
			
			hshRecord.put("vecRow",vecRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getBAFacilitiesData "+ce.toString());
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
	
	//Added By Venkata Prasad Chowdary For Listing All Facilities on 03/12/2013
	public HashMap getFacilitiesData(HashMap hshValues) 
	{			
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
			String moduletype = Helper.correctNull((String)hshValues.get("moduletype"));
		try
		{
			rs = DBUtils.executeLAPSQuery("sel_Facilities_GC^"+moduletype+"^"+"c");
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));
				vecCol.add(correctNull(rs.getString(2)));
				vecCol.add(correctNull(rs.getString(3)));
				if(Helper.correctNull(rs.getString(4)).equalsIgnoreCase("1"))
					vecCol.add("Disabled");
				else
					vecCol.add("Enabled");
				vecRow.add(vecCol);	
			}
			hshRecord.put("vecRow",vecRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getFacilitiesData "+ce.toString());
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
 
	
	public HashMap getSchemeSecurities(HashMap hshValues) 
	{	
		
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
		
		try
		{
			String strSecID="",strQuery="";
			String strParenttype= correctNull((String)hshValues.get("parenttype"));
			String strSchemeCode= correctNull((String)hshValues.get("schemecode"));
			
			if (strSchemeCode.equalsIgnoreCase("H"))
			{
				strSecID = "in (10,11,12,13,14,15,16,17)";
			}
			if(rs !=null)
				rs.close();
			
			strQuery=SQLParser.getSqlQuery("selSchemeSecurity^"+strParenttype+"^"+strSecID);
			rs=DBUtils.executeQuery(strQuery);
						
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));
				vecCol.add(correctNull(rs.getString(2)));
				vecRow.add(vecCol);	
			}
			hshRecord.put("vecRow",vecRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getSchemeSecurities "+ce.toString());
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
 
	// added by Anees on 11/12/13 for fetching financial Years in Agriculture
	public HashMap getAgriFinancialYear(String strappno,String strPage) 
	{			
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList arrCol		= new ArrayList();
		ArrayList arrRow		= new ArrayList();	
		try
		{
			if(strPage.equalsIgnoreCase("RP"))
			{
				rs = DBUtils.executeLAPSQuery("sel_rating_financialyears^"+strappno);
				hshRecord = new HashMap();
				while(rs.next())
				{
					arrCol	= new ArrayList();
					arrCol.add(correctNull(rs.getString("DEMO_APPNO")));//0
					arrCol.add(correctNull(rs.getString("COM_FROMDATE")));//1
					arrCol.add(correctNull(rs.getString("COM_TODATE")));//2
					arrCol.add(correctNull(rs.getString("FINRATEYEAR_SELSNO")));//3
					arrRow.add(arrCol);	
				}
				hshRecord.put("arrRow",arrRow);
			}
			else if(strPage.equalsIgnoreCase("RO"))
			{
				rs = DBUtils.executeLAPSQuery("sel_rating_financialyears_OFR^"+strappno);
				hshRecord = new HashMap();
				while(rs.next())
				{
					arrCol	= new ArrayList();
					arrCol.add(correctNull(rs.getString("FINRATEYEAR_APPNO")));//0
					arrCol.add(correctNull(rs.getString("COM_FROMDATE")));//1
					arrCol.add(correctNull(rs.getString("COM_TODATE")));//2
					arrCol.add(correctNull(rs.getString("FINRATEYEAR_SELSNO")));//3
					arrRow.add(arrCol);	
				}
				hshRecord.put("arrRow",arrRow);
			}
			else
			{
				rs = DBUtils.executeLAPSQuery("sel_agr_financialyears^"+strappno);
				hshRecord = new HashMap();
				while(rs.next())
				{
					arrCol	= new ArrayList();
					arrCol.add(correctNull(rs.getString("COM_APPNO")));//0
					arrCol.add(correctNull(rs.getString("COM_FROMDATE")));//1
					arrCol.add(correctNull(rs.getString("COM_TODATE")));//2
					arrCol.add(correctNull(rs.getString("COM_SNO")));//3
					arrRow.add(arrCol);	
				}
				hshRecord.put("arrRow",arrRow);
			}
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getFacilitiesData "+ce.toString());
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
	//added by bhaskar for business rule id
	public HashMap getBusinessRules(HashMap hshValues) 
	{			
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList arrCol= new ArrayList();
		ArrayList arrRow= new ArrayList();	
		try
		{
			if(rs!=null)
				rs.close();
			String strPage=Helper.correctNull((String)hshValues.get("page"));
			if(strPage.equalsIgnoreCase("set"))
			{
			   rs=DBUtils.executeLAPSQuery("selgetrulesall");
			}
			else
			{
		    	rs=DBUtils.executeLAPSQuery("selgetrulesall_Corp");	
			}
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("rsk_rule_id")));//0
				arrCol.add(Helper.correctNull((String)rs.getString("rsk_rule_desc")));//1
				arrCol.add(Helper.correctNull((String)rs.getString("rsk_rule_params")));//2
				arrRow.add(arrCol);
				
			}
			hshRecord = new HashMap();
			hshRecord.put("arrRow", arrRow);	
				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getBusinessRules "+ce.toString());
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
	
	
	//Added by Arsath for Customer Profile Banking Arrangements
	public HashMap getCustProfBankArrangement(HashMap hshValues) 
	{			
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList arrCol= new ArrayList();
		ArrayList arrRow= new ArrayList();	
		try
		{
			if(rs!=null)
			{
				rs.close();
			}
			String strPage=Helper.correctNull((String)hshValues.get("pagevalue"));
			rs=DBUtils.executeLAPSQuery("sel_custprofBAstaticdata^"+strPage);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("stat_data_sno")));//0
				arrCol.add(Helper.correctNull((String)rs.getString("stat_data_desc")));//1
				arrCol.add(Helper.correctNull((String)rs.getString("stat_data_desc1")));//2
				arrRow.add(arrCol);
			}
			hshRecord = new HashMap();
			hshRecord.put("arrRow", arrRow);	
				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getBusinessRules "+ce.toString());
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
	public HashMap getCustomerFacility(HashMap hshValues) 
	{			
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList arrCol= new ArrayList();
		ArrayList arrRow= new ArrayList();
		String strapptype=Helper.correctNull((String)hshValues.get("strapptype"));
		try
		{
			if(rs!=null)
				rs.close();
			 rs=DBUtils.executeLAPSQuery("perconstbankingsel^"+strapptype);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("cus_factype")));//0
				arrCol.add(Helper.correctNull((String)rs.getString("cus_facname")));//1
				arrCol.add(Helper.correctNull((String)rs.getString("cus_typecredit")));//2
				arrCol.add(Helper.correctNull((String)rs.getString("cus_bnkarrn")));//3
				arrCol.add(Helper.correctNull((String)rs.getString("cus_sno")));//4
				arrRow.add(arrCol);
				
			}
			hshRecord = new HashMap();
			hshRecord.put("arrRow", arrRow);	
				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getCustomerFacility "+ce.toString());
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
	
	public HashMap getStaticDataFacility(HashMap hshValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
		try
		{
			
			rs = DBUtils.executeLAPSQuery("sel_static_facility");
			
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));
				vecCol.add(correctNull(rs.getString(2)));
				vecRow.add(vecCol);	
			}
			hshRecord.put("vecRow",vecRow);	
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getStaticDataFacility "+ce.toString());
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
	
	public HashMap getLimitOfData(HashMap hshValues) 
	{	
		ResultSet rs = null, rs1 = null;
		HashMap hshRecord = null;
		ArrayList arrRow	= new ArrayList();
		ArrayList arrCol	= new ArrayList();
		
		try
		{
			String appno	= correctNull((String)hshValues.get("appno"));
			String strbankcode = correctNull((String)hshValues.get("bankcode"));
			
			rs = DBUtils.executeLAPSQuery("sel_FacNature^"+appno+"^"+strbankcode);
			hshRecord = new HashMap();
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("com_con_fac_nature")));
				
				if(rs1!=null){rs1.close();}
				rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^144^"+correctNull(rs.getString("com_con_fac_nature")));
				
				if(!rs1.next())
				{
					arrCol.add("");
				}
				rs1.beforeFirst();
				while(rs1.next())
				{
					arrCol.add(correctNull(rs1.getString("stat_data_desc1")));
					break;
				}
				
				arrRow.add(arrCol);	
			}
			
			
			hshRecord.put("arrRow",arrRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getLimitOfData "+ce.toString());
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
	
	
	public HashMap getLimitOfTLData(HashMap hshValues) 
	{	
		ResultSet rs = null, rs1 = null;
		HashMap hshRecord = null;
		ArrayList arrRow	= new ArrayList();
		ArrayList arrCol	= new ArrayList();
		
		try
		{
			String appno	= correctNull((String)hshValues.get("appno"));
			String strbankcode = correctNull((String)hshValues.get("bankcode"));
			
			rs = DBUtils.executeLAPSQuery("sel_FacNature_tl^"+appno+"^"+strbankcode);
			hshRecord = new HashMap();
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("com_con_fac_nature")));
				
				if(rs1!=null){rs1.close();}
				rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^144^"+correctNull(rs.getString("com_con_fac_nature")));
				
				if(!rs1.next())
				{
					arrCol.add("");
				}
				rs1.beforeFirst();
				while(rs1.next())
				{
					arrCol.add(correctNull(rs1.getString("stat_data_desc1")));
					break;
				}
				
				arrRow.add(arrCol);	
			}
			
			
			hshRecord.put("arrRow",arrRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getLimitOfData "+ce.toString());
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
	
	public HashMap getBAConsorDet(HashMap hshValues) 
	{	
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList arrRow	= new ArrayList();
		ArrayList arrCol	= new ArrayList();
		
		int intVal	 =0, intNoOfCons	= 0;
		
		try
		{
			String appno		= correctNull((String)hshValues.get("appno"));
			String strConsType	= correctNull((String)hshValues.get("strConsType"));
			
			rs = DBUtils.executeLAPSQuery("sel_consDet^"+appno);
			hshRecord = new HashMap();
			
			if(rs.next())
			{
				if(strConsType.equalsIgnoreCase("WC"))
				{
					intNoOfCons	= Integer.parseInt(Helper.correctInt(rs.getString("com_wc_no")));
				}
				else if(strConsType.equalsIgnoreCase("TL"))
				{
					intNoOfCons	= Integer.parseInt(Helper.correctInt(rs.getString("com_tl_no")));
				}
			}
			
			for(int i=0;i<intNoOfCons;i++)
			{
				arrCol = new ArrayList();
				intVal++;
				
				arrCol.add(String.valueOf(intVal));
				arrCol.add("Consortium "+String.valueOf(intVal));
				
				arrRow.add(arrCol);	
			}
			
			
			hshRecord.put("arrRow",arrRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getLimitOfData "+ce.toString());
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
	public HashMap getFacilityApprovedDetails(HashMap hshValues) 
	{	
		
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList arrCol= new ArrayList();
		ArrayList arrRow= new ArrayList();	
		
		try
		{
			
			String strAppno= correctNull((String)hshValues.get("apptype"));
			
				rs = DBUtils.executeLAPSQuery("sel_approvedfacility^"+strAppno+"^"+strAppno+"^"+strAppno+"^"+strAppno);	
			
			hshRecord = new HashMap();
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("facility_sno")));
				//arrCol.add(correctNull(rs.getString("facheaddesc")));
				arrCol.add(correctNull(rs.getString("com_facdesc")).toUpperCase());
				arrCol.add(correctNull(rs.getString("FACILITY_WHT_CGTMSEAPPLY")));
				arrRow.add(arrCol);	
			}
			hshRecord.put("arrRow",arrRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getFacilitySno "+ce.toString());
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
	
	public HashMap getBusinessRuleid(HashMap hshValues) 
	{	
		
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList  arrCol		= new ArrayList();
		ArrayList arrRow		= new ArrayList();	
		
		try
		{
			
			rs = DBUtils.executeLAPSQuery("selriskparamrule");
			
			hshRecord = new HashMap();
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString(1)));
				arrCol.add(correctNull(rs.getString(2)));
				arrRow.add(arrCol);	
			}
			hshRecord.put("arrRowId",arrRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getRuleid "+ce.toString());
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
	
	public HashMap getPrmotorsDetails(HashMap hshValues) 
	{	
		String strQuery=null,oldappid=null;
		ResultSet rs = null,rs2 = null;
		HashMap hshRecord = null;
		ArrayList arrCol= new ArrayList();
		ArrayList arrRow= new ArrayList();	
		
		try
		{
			
			String strAppno= correctNull((String)hshValues.get("appno"));
			
				rs = DBUtils.executeLAPSQuery("selPromotorsdetails^"+strAppno+"^"+strAppno);	
			
			hshRecord = new HashMap();
			while(rs.next())
			{
				arrCol = new ArrayList();
				String appid=correctNull(rs.getString(1));
				if(!appid.equalsIgnoreCase(""))
				{
					strQuery= SQLParser.getSqlQuery("seloldrefidforapp^"+appid);
					rs2=DBUtils.executeQuery(strQuery);
					if(rs2.next())
					{
						oldappid=Helper.correctNull(rs2.getString("perapp_oldid")); 
					}
				}
				else
				{
					oldappid = "";
				}
				arrCol.add(oldappid);
				arrCol.add(correctNull(rs.getString("appname")));
				arrRow.add(arrCol);	
			}
			hshRecord.put("arrRow",arrRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getPrmotorsDetails "+ce.toString());
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
	public HashMap getGeneralDetails(HashMap hshValues) 
	{
		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arrCol= new ArrayList();
		ArrayList arrRow= new ArrayList();	
		
		try
		{
			
			String strRange_val= correctNull((String)hshValues.get("value"));
			
			rs=DBUtils.executeLAPSQuery("sel_perm_assessment_rangeparam11^"+strRange_val);	
				while (rs.next()) {
					arrCol = new ArrayList();
					arrCol.add(Helper.correctNull(rs.getString("PERM_MAXVALUE")));
					arrCol.add(Helper.correctNull(rs.getString("PERM_RANGE")));
					arrCol.add(Helper.correctNull(rs.getString("perm_sno")));
					arrRow.add(arrCol);
				}
				hshRecord.put("arrRow", arrRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getPrmotorsDetails "+ce.toString());
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
	public HashMap getSecAttachedtoProposal(HashMap hshValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
		String appno=Helper.correctNull((String)hshValues.get("appno"));
		try
		{
			
			rs = DBUtils.executeLAPSQuery("sel_propSecAttachedtoprop^"+appno);
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));
				vecCol.add(correctNull(rs.getString(2)));
				vecRow.add(vecCol);	
			}
			hshRecord.put("vecRow",vecRow);	
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getSecAttachedtoProposal "+ce.toString());
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
	
	public HashMap getPmayData(HashMap hshValues) 
	{
		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arrCol= new ArrayList();
		ArrayList arrRow= new ArrayList();	
		String strPrdCode="";
		
		try
		{	
			String strMain_val= correctNull((String)hshValues.get("value"));
			rs=DBUtils.executeLAPSQuery("selPermissionType^"+strMain_val);	
				while (rs.next()) {
					arrCol = new ArrayList();
					arrCol.add(Helper.correctNull(rs.getString("per_id")));
					arrCol.add(Helper.correctNull(rs.getString("per_name")));
					arrRow.add(arrCol);
				}
				hshRecord.put("arrRow", arrRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getPrmotorsDetails "+ce.toString());
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
	
	//////
	
	public HashMap getAgriunitcostMast(HashMap hshValues) 
	{	
		
		String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
		
		try
		{
			
			String strstatecode= correctNull((String)hshValues.get("apptype"));
			
			rs = DBUtils.executeLAPSQuery("SelStaticAgriunitcostMast^"+strstatecode);
			
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));
				vecCol.add(correctNull(rs.getString(2)));
				vecCol.add(correctNull(rs.getString(3)));
				vecRow.add(vecCol);	
			}
			hshRecord.put("vecRow",vecRow);				
		}
		catch(Exception ce)
		{
			
			throw new EJBException("Error in getDataHoliday "+ce.toString());
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
 