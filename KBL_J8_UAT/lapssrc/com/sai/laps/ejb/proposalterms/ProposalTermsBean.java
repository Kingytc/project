package com.sai.laps.ejb.proposalterms;

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

@Stateless(name = "ProposalTermsBean", mappedName = "ProposalTermsHome")
@Remote (ProposalTermsRemote.class)
public class ProposalTermsBean extends BeanAdapter {

	
	/**
	 * For Proposal Terms 
	 * 
	 */
	static Logger log=Logger.getLogger(ProposalTermsBean.class);
	private static final long serialVersionUID = 1L;
	
	
	/**
	 * For retrieving data Conducts of operation
	 * 
	 * @param hshValues
	 * @return
	 * @
	 */
	public HashMap getConduct(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		ResultSet rs = null;
		String strApplicationNo = "";
		String strQuery = "";
		
		try{
			strApplicationNo = correctNull((String) hshValues.get("appno"));
			strQuery = SQLParser.getSqlQuery("sel_conductoperation^"+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next()){
				hshRecord.put("CON_COMPLIANCE",Helper.correctNull((String) rs.getString("CON_COMPLIANCE")));
				hshRecord.put("CON_INTERNALINSPECTION",Helper.correctNull((String) rs.getString("CON_INTERNALINSPECTION")));
				hshRecord.put("CON_RBIINSPECTION", Helper.correctNull((String) rs.getString("CON_RBIINSPECTION")));
				hshRecord.put("CON_AUDITSOBSER",Helper.correctNull((String) rs.getString("CON_AUDITSOBSER")));
				hshRecord.put("CON_OFFSITEOBSERV", Helper.correctNull((String) rs.getString("CON_OFFSITEOBSERV")));
				hshRecord.put("CON_ROCLREPORT",Helper.correctNull((String) rs.getString("CON_ROCLREPORT")));
				hshRecord.put("CON_PERIODCOVERED",Helper.correctNull((String) rs.getString("CON_PERIODCOVERED")));
				hshRecord.put("CON_ROCREASON",Helper.correctNull((String) rs.getString("CON_ROCREASON")));
				hshRecord.put("CON_EMREG",Helper.correctNull((String) rs.getString("CON_EMREG")));
				hshRecord.put("CON_EMREASON",Helper.correctNull((String) rs.getString("CON_EMREASON")));
				hshRecord.put("CON_CHARGESNOTED",Helper.correctNull((String) rs.getString("CON_CHARGESNOTED")));
				hshRecord.put("CON_CHARGESREASON",Helper.correctNull((String) rs.getString("CON_CHARGESREASON")));
				hshRecord.put("CON_CONDUCTTLDPN", Helper.correctNull((String) rs.getString("CON_CONDUCTTLDPN")));
			}
		}
		catch(Exception ce){
			log.error(ce.toString());
			throw new EJBException("Error in getConduct "+ce.toString());
		}
		return hshRecord;	
	}
	
	
	/**
	 * For inserting data Conduct of operations
	 * 
	 * @param hshValues
	 * @
	 */
	public void updateConduct(HashMap hshValues)  {
		
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strApplicationNo = "";
		String strQuery = "";
		String strAction = "";
		
		try{
			
			strAction = correctNull((String) hshValues.get("hidAction"));	
			strApplicationNo = correctNull((String) hshValues.get("appno"));
			
			if (strAction.equalsIgnoreCase("update")) {
				
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","del_conductoperation");		
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","2");
				
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_conductoperation");
				arrValues.add(strApplicationNo);
				arrValues.add(correctNull((String) hshValues.get("txt_sanctionterms")));
				arrValues.add(correctNull((String) hshValues.get("txt_intinspection")));
				arrValues.add(correctNull((String) hshValues.get("txt_rbiinspection")));
				arrValues.add(correctNull((String) hshValues.get("txt_auditobservation")));
				arrValues.add(correctNull((String) hshValues.get("txt_offobservation")));
				arrValues.add(correctNull((String) hshValues.get("sel_regcharge")));
				arrValues.add(correctNull((String) hshValues.get("txt_periodcovered")));
				arrValues.add(correctNull((String) hshValues.get("txt_reason1")));
				arrValues.add(correctNull((String) hshValues.get("sel_regEM")));
				arrValues.add(correctNull((String) hshValues.get("txt_reason2")));
				arrValues.add(correctNull((String) hshValues.get("sel_chargenoted")));
				arrValues.add(correctNull((String) hshValues.get("txt_reason3")));
				arrValues.add(correctNull((String) hshValues.get("txt_tldpn")));

				hshQuery.put("arrValues", arrValues);			
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}

			if(strAction.equals("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","del_conductoperation");		
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch (Exception e) {
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} 
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				throw new EJBException("Error in closing Connection "
						+ e.getMessage());
			}
		}
		
	}
	
	
	
	/**
	 * 
	 * @param hshValues
	 * @return
	 * @
	 */
	public HashMap getRBIGuidelines (HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		ResultSet rs = null;
		HashMap hshResult = new HashMap();
		String strApplicationNo = "";
		String strQuery="";
		
		try{
			strApplicationNo = correctNull((String) hshValues.get("appno"));
			strQuery = SQLParser.getSqlQuery("sel_rbiguidelines^"+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next()){
				hshRecord.put("creditproposal", Helper.replaceForJavaScriptString(Helper.correctNull((String) rs.getString("rbi_creditproposal"))));
			}
		}
		catch(Exception ce){
			log.error(ce.toString());
			throw new EJBException("Error in getRBIGuidelines "+ce.toString());
		}
		return hshRecord;
		
	}
	
	/**
	 * 
	 * @param hshValues
	 * @
	 */
	public void updateRBIGuidelines(HashMap hshValues)  {
		
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strApplicationNo = "";
		String strQuery = "";
		String strAction = "";
		
		try{
			
			strAction = correctNull((String) hshValues.get("hidAction"));		
			strApplicationNo = correctNull((String) hshValues.get("appno"));
			
			if (strAction.equalsIgnoreCase("update")) {
				
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","del_rbiguidelines");		
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","2");
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_rbiguidelines");
				arrValues.add(strApplicationNo);
				arrValues.add(correctNull((String) hshValues.get("txt_rbiguidelines")));
				hshQuery.put("arrValues", arrValues);			
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			if(strAction.equals("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","del_rbiguidelines");		
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch (Exception e) {
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} 
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				throw new EJBException("Error in closing Connection "
						+ e.getMessage());
			}
		}
		
	}

	/**
	 * 
	 * @param hshValues
	 * @return
	 * @
	 */
	
	public HashMap getInspection(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		ResultSet rs = null;
		HashMap hshResult = new HashMap();
		String strApplicationNo = "";
		String strQuery="";		
		try{
			strApplicationNo = correctNull((String) hshValues.get("appno"));
			strQuery = SQLParser.getSqlQuery("sel_inspectioncomments^"+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next()){
				hshRecord.put("INS_INTERNALCOMMENT",Helper.replaceForJavaScriptString((String) rs.getString("INS_INTERNALCOMMENT")));
				hshRecord.put("INS_INTERNALACTION", Helper.replaceForJavaScriptString((String) rs.getString("INS_INTERNALACTION")));
				hshRecord.put("INS_RBICOMMENT", Helper.replaceForJavaScriptString((String) rs.getString("INS_RBICOMMENT")));
				hshRecord.put("INS_RBIACTION", Helper.replaceForJavaScriptString((String) rs.getString("INS_RBIACTION")));
				hshRecord.put("INS_UNITCOMMENT", Helper.replaceForJavaScriptString((String) rs.getString("INS_UNITCOMMENT")));
				hshRecord.put("INS_UNITACTION", Helper.replaceForJavaScriptString((String) rs.getString("INS_UNITACTION")));
				hshRecord.put("INS_RMDCOMMENT", Helper.replaceForJavaScriptString((String) rs.getString("INS_RMDCOMMENT")));
				hshRecord.put("INS_RMDACTION", Helper.replaceForJavaScriptString((String) rs.getString("INS_RMDACTION")));
				hshRecord.put("INS_AUDITCOMMENT", Helper.replaceForJavaScriptString((String) rs.getString("INS_AUDITCOMMENT")));
				hshRecord.put("INS_AUDITACTION", Helper.replaceForJavaScriptString((String) rs.getString("INS_AUDITACTION")));
				hshRecord.put("INS_OFFSITECOMMENT",Helper.replaceForJavaScriptString((String) rs.getString("INS_OFFSITECOMMENT")));
				hshRecord.put("INS_OFFSITEACTION", Helper.replaceForJavaScriptString((String) rs.getString("INS_OFFSITEACTION")));
				hshRecord.put("INS_INTERNALDATE", correctNull((String) rs.getString("INS_INTERNALDATE")));
				hshRecord.put("INS_RBIASONDATE", correctNull((String) rs.getString("INS_RBIASONDATE")));
			}
		}
		catch(Exception ce){
			log.error(ce.toString());
			throw new EJBException("Error in getInspection "+ce.toString());
		}
		return hshRecord;
		
	}
	
	/**
	 * 
	 * @param hshValues
	 * @
	 */
	public void updateInspection(HashMap hshValues)  {
		
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strApplicationNo = "";
		String strQuery = "";
		String strAction = "";
		
		
		try{
			strAction = correctNull((String) hshValues.get("hidAction"));	
			strApplicationNo = correctNull((String) hshValues.get("appno"));
			
			if (strAction.equalsIgnoreCase("update")) {
				
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","del_inspectioncomments");		
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","2");
				
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_inspectioncomments");
				arrValues.add(strApplicationNo);
				arrValues.add(correctNull((String) hshValues.get("txt_comment1")));
				arrValues.add(correctNull((String) hshValues.get("txt_action1")));
				arrValues.add(correctNull((String) hshValues.get("txt_comment2")));
				arrValues.add(correctNull((String) hshValues.get("txt_action2")));
				arrValues.add(correctNull((String) hshValues.get("txt_comment3")));
				arrValues.add(correctNull((String) hshValues.get("txt_action3")));
				arrValues.add(correctNull((String) hshValues.get("txt_comment4")));
				arrValues.add(correctNull((String) hshValues.get("txt_action4")));
				arrValues.add(correctNull((String) hshValues.get("txt_comment5")));
				arrValues.add(correctNull((String) hshValues.get("txt_action5")));
				arrValues.add(correctNull((String) hshValues.get("txt_comment6")));
				arrValues.add(correctNull((String) hshValues.get("txt_action6")));
				arrValues.add(correctNull((String) hshValues.get("txt_innternaldate")));
				arrValues.add(correctNull((String) hshValues.get("txt_rbiasondate")));
				hshQuery.put("arrValues", arrValues);			
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}

			if(strAction.equals("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","del_inspectioncomments");		
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch (Exception e) {
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} 
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				throw new EJBException("Error in closing Connection "
						+ e.getMessage());
			}
		}
		
	}

	/**
	 * 
	 * @param hshValues
	 * @return
	 * @
	 */
	public HashMap getCersaiCibil(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		ResultSet rs = null;
		HashMap hshResult = new HashMap();
		String strApplicationNo = "";
		String strQuery="";
		
		try{
			strApplicationNo = correctNull((String) hshValues.get("appno"));
			strQuery = SQLParser.getSqlQuery("sel_cersaicibildetails^"+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()){
				hshRecord.put("CER_CERSAIDETAILS",Helper.replaceForJavaScriptString((String) rs.getString("CER_CERSAIDETAILS")));
				hshRecord.put("CER_OTHERINFORMATION", Helper.replaceForJavaScriptString((String) rs.getString("CER_OTHERINFORMATION")));

			}
		}
		catch(Exception ce){
			log.error(ce.toString());
			throw new EJBException("Error in getCersaiCibil "+ce.toString());
		}
		return hshRecord;
		
	}
	public HashMap getNpaScheme(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		ResultSet rs = null;
		HashMap hshResult = new HashMap();
		String strApplicationNo = "";
		String strQuery="";
		java.text.NumberFormat jtn= java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		double npa_amtwise=0.00;
		double npa_accwise=0.00;
		
		try{
			strApplicationNo = correctNull((String) hshValues.get("appno"));
			strQuery = SQLParser.getSqlQuery("sel_npascheme^"+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next()){
				hshRecord.put("npa_amtwise",jtn.format(Double.parseDouble(Helper.correctDouble((String) rs.getString("npa_amtwise")))));
				hshRecord.put("npa_accwise",jtn.format(Double.parseDouble(Helper.correctDouble((String) rs.getString("npa_accwise")))));
				hshRecord.put("npa_ratification", Helper.CLOBToString(rs.getClob("npa_ratification")));
				hshRecord.put("npa_concession", Helper.CLOBToString(rs.getClob("npa_concession")));
				hshRecord.put("npa_date", Helper.correctNull((String) rs.getString("npa_date")));
			}
		}
		catch(Exception ce){
			log.error(ce.toString());
			throw new EJBException("Error in getNpaScheme "+ce.toString());
		}
		return hshRecord;
		
	}
	
	/**
	 * 
	 * @param hshValues
	 * @
	 */
	public void updateCersaiCibil(HashMap hshValues)  {
		
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strApplicationNo = "";
		String strQuery = "";
		String strAction = "";
		
		try{
			
			strAction = correctNull((String) hshValues.get("hidAction"));		
			strApplicationNo = correctNull((String) hshValues.get("appno"));
			
			if (strAction.equalsIgnoreCase("update")) {
				
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","del_cersaicibildetails");		
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","2");
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_cersaicibildetails");
				arrValues.add(strApplicationNo);
				arrValues.add(correctNull((String) hshValues.get("txt_cersaidetails")));
				arrValues.add(correctNull((String) hshValues.get("txt_relevantinfo")));
				hshQuery.put("arrValues", arrValues);			
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			if(strAction.equals("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","del_cersaicibildetails");		
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch (Exception e) {
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} 
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				throw new EJBException("Error in closing Connection "
						+ e.getMessage());
			}
		}
		
	}
public void updateNpaScheme(HashMap hshValues)  {
		
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strApplicationNo = "";
		String strQuery = "";
		String strAction = "";
		
		try{
			
			strAction = correctNull((String) hshValues.get("hidAction"));		
			strApplicationNo = correctNull((String) hshValues.get("appno"));
			
			if (strAction.equalsIgnoreCase("update")) {
				
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","del_npascheme");		
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","2");
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_npascheme");
				arrValues.add(strApplicationNo);
				arrValues.add(correctNull((String) hshValues.get("txt_amtwise")));
				arrValues.add(correctNull((String) hshValues.get("txt_accwise")));
				arrValues.add(correctNull((String) hshValues.get("txt_ratification")));
				arrValues.add(correctNull((String) hshValues.get("txt_concession")));
				arrValues.add(correctNull((String) hshValues.get("txt_npadate")));
				hshQuery.put("arrValues", arrValues);			
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			if(strAction.equals("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","del_npascheme");		
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch (Exception e) {
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} 
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				throw new EJBException("Error in closing Connection "
						+ e.getMessage());
			}
		}
		
	}
}
