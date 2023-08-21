package com.sai.laps.ejb.workflowmaster;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
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
//import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;


@Stateless(name = "WorkflowMasterBean", mappedName = "WorkflowMasterHome")
@Remote (WorkflowMasterRemote.class)
public class WorkflowMasterBean extends BeanAdapter {
	/**
	 * 
	 */
	private static final long serialVersionUID = 7322281569586592474L;

	/**
	 * 
	 */
	static Logger log=Logger.getLogger(WorkflowMasterBean.class);	
	

	public HashMap updateData(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshRecord = new HashMap();
		ArrayList arrValues = new ArrayList();
		int count = 0;
		String strTemp = null;
		String strAction = null;
		String strWrkFlowname = null;
		String strWrkFlowtype = null;
		int intTempCount = 0;
		String strMsg = "";
		StringBuilder sbAuditTrial=new StringBuilder();
		ResultSet rs = null;
		String strValue = "";
		StringBuilder sbolddata=new StringBuilder();
		String strKeyId = "";
		try {
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			strAction = Helper.correctNull((String)hshValues.get("hidAction"));
			if(strAction.equalsIgnoreCase("UPDATE") || strAction.equalsIgnoreCase("DELETE"))
			{
				strValue = Helper.correctNull((String) hshValues.get("hidwrk_flowid"));
				rs = DBUtils.executeLAPSQuery("sel_wrkflow_audit^" + strValue);
				while (rs.next()) 
				{
					if(Helper.correctNull((String)rs.getString("wrk_flowtype")).equalsIgnoreCase("p"))
					{
						sbolddata.append("Workflow Type=").append("In Process");
					}
					else if(Helper.correctNull((String)rs.getString("wrk_flowtype")).equalsIgnoreCase("a"))
					{
						sbolddata.append("Workflow Type=").append("Post Approval");
					}
					else if(Helper.correctNull((String)rs.getString("wrk_flowtype")).equalsIgnoreCase("r"))
					{
						sbolddata.append("Workflow Type=").append("Post Rejection");
					}
					sbolddata.append("~Workflow Action=").append(correctNull((String)rs.getString("wrk_flowname")));
				}
			}
			hshQueryValues.put("size", "1");
			strAction = correctNull((String) hshValues.get("hidAction"));
			strWrkFlowname = (String) hshValues.get("txtwrk_flowname");
			strWrkFlowtype = (String) hshValues.get("hidwrk_flowtype");

			if (strAction.equalsIgnoreCase("Insert")) {
				if (getProductid("count", strWrkFlowname, strWrkFlowtype, "0") == 0) {

					hshQuery.put("strQueryId", "InsertWorkflow");
					count = getProductid("max", strWrkFlowname, strWrkFlowtype,
							"0");
					count = count + 1;
					strTemp = java.lang.String.valueOf(count);

					arrValues.add(strTemp);
					arrValues.add(hshValues.get("txtwrk_flowname").toString().toUpperCase());
					arrValues.add(hshValues.get("hidwrk_flowtype"));

					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					intTempCount = 0;
				} else {
					intTempCount = intTempCount + 1;
					strMsg = "Workflow Already Exist";
				}
			} else if (strAction.equalsIgnoreCase("Update")) {
				if (getProductid("del", strWrkFlowname, strWrkFlowtype,
						(String) hshValues.get("hidwrk_flowid")) == 0) {
					hshQuery.put("strQueryId", "UpdateWorkflow");
					arrValues.add(hshValues.get("hidwrk_flowid"));
					arrValues.add(hshValues.get("txtwrk_flowname").toString().toUpperCase());
					arrValues.add(hshValues.get("hidwrk_flowtype"));
					arrValues.add(hshValues.get("hidwrk_flowid"));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					intTempCount = 0;
				} else {
					intTempCount = intTempCount + 1;
					strMsg = "Cannot update this Workflow because Product Exist";
				}

			} else if (strAction.equalsIgnoreCase("Delete")) {
				if (getProductid("del", strWrkFlowname, strWrkFlowtype,
						(String) hshValues.get("hidwrk_flowid")) == 0) {
					hshQuery.put("strQueryId", "DeleteWorkflow");
					arrValues.add(hshValues.get("hidwrk_flowid"));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					intTempCount = 0;
				} else {
					intTempCount = intTempCount + 1;
					strMsg = "Cannot delete this Workflow because Product Exist";
				}
			}


/** For Audit trial */
			if(!strAction.equalsIgnoreCase("Delete"))
			{
				String strType = "";
				if(strWrkFlowtype.trim().equalsIgnoreCase("P"))
				{
					strType = "In Process";
				}else if(strWrkFlowtype.trim().equalsIgnoreCase("a")){
					strType = "Post Approval";
				}else if(strWrkFlowtype.trim().equalsIgnoreCase("r")){
					strType = "Post Rejection";
				}
				if(intTempCount==0){
		       	sbAuditTrial.append("Workflow Type=").append(correctNull((String)strType))
		       	.append("~Workflow Action=").append(correctNull((String)strWrkFlowname).toUpperCase());
		       	if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
					hshValues.put("hidAction", "update");				
				}
			}
			AuditTrial.auditNewLog(hshValues,"82",strKeyId,sbAuditTrial.toString(),sbolddata.toString());
			
/** End */			
			
			if (intTempCount == 0) {
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				hshRecord.put("action", "done");
				hshRecord.put("Msg", strMsg);
			} else {
				hshRecord.put("action", "failed");
				hshRecord.put("Msg", strMsg);
			}
		} catch (Exception ce) {
			throw new EJBException("inside update" + ce.toString());
		}
		return hshRecord;
	}

	private int getProductid(String strVal, String flowname, String flowtype,
			String workid)  {
		ResultSet rs = null;
		String strQuery = null;
		int count = 0;

		try {
			if (strVal.equalsIgnoreCase("max")) {
				strQuery = SQLParser.getSqlQuery("maxworkflow");
			} else if (strVal.equalsIgnoreCase("count")) {
				strQuery = SQLParser.getSqlQuery("checkworkflow^" + flowname
						+ "^" + flowtype);
			} else if (strVal.equalsIgnoreCase("del")) {
				strQuery = SQLParser.getSqlQuery("checkdelworkflow^"
						+ Integer.parseInt(workid));
			}
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				count = rs.getInt(1);
			}
			if (rs != null) {
				rs.close();
			}
		} catch (Exception e) {
			throw new EJBException("close" + e.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				throw new EJBException("close" + e.toString());
			}
		}
		return count;
	}

	private HashMap getWork(HashMap hshValues)  {
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecCatid = new ArrayList();
		ArrayList vecCatName = new ArrayList();
		String strValue = "";
		try {
			strValue = (String) hshValues.get("select");
			rs = DBUtils.executeLAPSQuery("sel_workflow^" + strValue);
			while (rs.next()) {
				String catid = correctNull(rs.getString("wrk_flowid"));
				String catpa = correctNull(rs.getString("wrk_flowtype"));
				catpa = catid + "-" + catpa;
				vecCatid.add(catpa);
				vecCatName
						.add(correctNull(rs.getString("wrk_flowname")));

			}

			hshRecord.put("vecCodes", vecCatid);
			hshRecord.put("vecValues", vecCatName);
			
			if (rs != null) {
				rs.close();
			}
		} catch (Exception ce) {
			throw new EJBException("Error in help " + ce.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}
		}
		return hshRecord;
	}

	public HashMap getData(HashMap hshValues)  {
		HashMap hshRecord = new HashMap();
		String strMethod = "";

		try {
			strMethod = (String) hshValues.get("hidMethod");

			if (strMethod.equalsIgnoreCase("getWork")) {
				hshRecord = (HashMap) getWork(hshValues);
			}

		} catch (Exception ce) {
			throw new EJBException("Error in getdata " + ce.toString());
		}

		return hshRecord;

	}
}