package com.sai.laps.ejb.setgroups;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.SetupParams;


@Stateless(name = "SetGroupsBean", mappedName = "SetGroupsHome")
@Remote (SetGroupsRemote.class)

public class SetGroupsBean extends BeanAdapter {
	static Logger log=Logger.getLogger(SetGroupsBean.class);
	private static final long serialVersionUID = -8657032016507917623L;

	public void updateData(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ArrayList arrVal = new ArrayList();
		String strAction = (String) hshValues.get("hidAction");
		String strExp = "$";
		StringBuilder sbolddata=new StringBuilder();
		String strKeyId = "";
		String strQuery = "";
		ResultSet rs1 = null;
		String strGrpAccess ="";
		try {
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				strQuery=SQLParser.getSqlQuery("setgroupssel_audit^"+hshValues.get("grp_id"));				
				rs1=DBUtils.executeQuery(strQuery);	
				if(rs1.next())
				{
					
					sbolddata.append("~ Group Name = ").append(Helper.correctNull((String)rs1.getString("grp_name")).toUpperCase());
					sbolddata.append("~ Group Rights = ");
					sbolddata.append("Navigational Security Access Only To ");
					String strGrprights = Helper.correctNull((String)rs1.getString("grp_rights"));
					String strGroup = "";
					strGroup = strGrprights.substring(0,1);
					if(!strGroup.equals("1")){sbolddata.append("");}else{ sbolddata.append("Setup - Vital,");}
					strGroup = strGrprights.substring(1,2);
					if(!strGroup.equals("1")){sbolddata.append("");}else{ sbolddata.append("Setup - Non Vital,");}
					strGroup = strGrprights.substring(2,3);
					if(!strGroup.equals("1")){sbolddata.append(""); }else{sbolddata.append("Masters,");}
					strGroup = strGrprights.substring(3,4);
					if(!strGroup.equals("1")){sbolddata.append("");}else{ sbolddata.append("Defaulters List,");}
				  /* if(strGrprights.substring(4,5).equalsIgnoreCase("1") || strGrprights.substring(5,6).equalsIgnoreCase("1")
							|| strGrprights.substring(6,7).equalsIgnoreCase("1")){
					sbolddata.append("Retail - ");} */
					strGroup = strGrprights.substring(4,5);
					if(!strGroup.equals("1")){sbolddata.append("");}else{ sbolddata.append("Retail Customer Profile,");}
					strGroup = strGrprights.substring(5,6);
					if(!strGroup.equals("1")){sbolddata.append("");}else{ sbolddata.append("Retail Application,");}
					strGroup = strGrprights.substring(6,7);
					if(!strGroup.equals("1")){sbolddata.append("");}else{ sbolddata.append("Retail Appraisal,");}
					//for agriculture
					int intGroupLen = strGrprights.length();
					if(intGroupLen>19)
					{
						/*if(strGrprights.substring(19,20).equalsIgnoreCase("1") || strGrprights.substring(20,21).equalsIgnoreCase("1")
								|| strGrprights.substring(21,22).equalsIgnoreCase("1")){
						sbolddata.append("Agriculture - ");}*/
						strGroup = strGrprights.substring(19,20);
						if(!strGroup.equals("1")){sbolddata.append("");}else{ sbolddata.append("Agriculture Customer Profile,");}
						strGroup = strGrprights.substring(20,21);
						if(!strGroup.equals("1")){sbolddata.append("");}else{ sbolddata.append("Agriculture Application,");}
						strGroup = strGrprights.substring(21,22);
						if(!strGroup.equals("1")){sbolddata.append("");}else{ sbolddata.append("Agriculture Appraisal,");}
					}
					
					//end
					/*if(strGrprights.substring(7,8).equalsIgnoreCase("1") || strGrprights.substring(8,9).equalsIgnoreCase("1")){
					sbolddata.append("Tertiary - ");}*/
					strGroup = strGrprights.substring(7,8);
					if(!strGroup.equals("1")){sbolddata.append(""); }else{sbolddata.append("Tertiary Customer Profile,");}
					strGroup = strGrprights.substring(8,9);
					if(!strGroup.equals("1")){sbolddata.append(""); }else{sbolddata.append("Tertiary Application,");}
					
					/*if(strGrprights.substring(10,11).equalsIgnoreCase("1") || strGrprights.substring(11,12).equalsIgnoreCase("1")
							|| strGrprights.substring(12,13).equalsIgnoreCase("1");}*/
					strGroup = strGrprights.substring(10,11);
					if(!strGroup.equals("1")){sbolddata.append(""); }else{sbolddata.append("Corporate & SME Customer Profile,");}
					strGroup = strGrprights.substring(11,12);
					if(!strGroup.equals("1")){sbolddata.append(""); }else{sbolddata.append("Corporate & SME Application,");}
					strGroup = strGrprights.substring(12,13);
					if(!strGroup.equals("1")){sbolddata.append("");}else{ sbolddata.append("Corporate & SME Proposal,");}
					
				/*	if(strGrprights.substring(14,15).equalsIgnoreCase("1") || strGrprights.substring(15,16).equalsIgnoreCase("1")
							|| strGrprights.substring(16,17).equalsIgnoreCase("1")){
					sbolddata.append("Post Disbursal - ");}*/
					
					strGroup = strGrprights.substring(14,15);
					if(!strGroup.equals("1")){sbolddata.append(""); }else{sbolddata.append("Post Disbursal Monitoring Register,");}
					strGroup = strGrprights.substring(15,16);
					if(!strGroup.equals("1")){sbolddata.append(""); }else{sbolddata.append("Post Disbursal Monitoring Report, ");}
					strGroup = strGrprights.substring(9,10);
					if(!strGroup.equals("1")){sbolddata.append("");}else{ sbolddata.append("Post Disbursal Term Loan Review,");}
					strGroup = strGrprights.substring(13,14);
					if(!strGroup.equals("1")){sbolddata.append(""); }else{sbolddata.append("Post/ Follow up Inspection,");}
					strGroup = strGrprights.substring(16,17);
					if(!strGroup.equals("1")){sbolddata.append("");}else{ sbolddata.append("Post Disbursal NPA,");}
					strGroup = strGrprights.substring(17,18);
					if(!strGroup.equals("1")){sbolddata.append("");}else{ sbolddata.append("MIS - Reports, ");}
					sbolddata.append("Data Security");
					strGroup = strGrprights.substring(18,19);
					if(strGroup.equals("r"))sbolddata.append(" Read"); 
					else if(strGroup.equals("w")) sbolddata.append(" Write");
					
					strGroup = strGrprights.substring(22,23);
					if(!strGroup.equals("1")){sbolddata.append("");}else{ sbolddata.append("Customer Profile, ");}
					strGroup = strGrprights.substring(23,24);
					if(!strGroup.equals("1")){sbolddata.append("");}else{ sbolddata.append("Securities, ");}
					strGroup = strGrprights.substring(24,25);
					if(!strGroup.equals("1")){sbolddata.append("");}else{ sbolddata.append("Gold & Deposit Loan Application, ");}
					strGroup = strGrprights.substring(25,26);
					if(!strGroup.equals("1")){sbolddata.append("");}else{ sbolddata.append("Gold & Deposit Loan Appraisal, ");}
					strGroup = strGrprights.substring(26,27);
					if(!strGroup.equals("1")){sbolddata.append("");}else{ sbolddata.append("Application Lodge, ");}
					strGroup = strGrprights.substring(27,28);
					if(!strGroup.equals("1")){sbolddata.append("");}else{ sbolddata.append("Online Inbox, ");}
					strGroup = strGrprights.substring(28,29);
					if(!strGroup.equals("1")){sbolddata.append("");}else{ sbolddata.append("NSDL Inbox, ");}
					strGroup = strGrprights.substring(29,30);
					if(!strGroup.equals("1")){sbolddata.append("");}else{ sbolddata.append("Document Print, ");}
					
					if(strGrprights.length()>30)
					{
						strGroup = strGrprights.substring(strGrprights.length()-1,strGrprights.length());
						if(!strGroup.equals("1")){sbolddata.append("");}else{ sbolddata.append("Branch Inbox, ");}
					}
					
					strGrpAccess = SetupParams.getSetupParams("accessfor", Helper.correctNull((String) rs1.getString("grp_accessfor")));
				}
				
				String strGroupLimit = Helper.correctNull((String)rs1.getString("grouplimitslist"));
				if(rs1!=null)
				rs1.close();
				if(!strGroupLimit.equalsIgnoreCase("0"))
				{
					strQuery = SQLParser.getSqlQuery("selgrplimitlist_audit^"+strGroupLimit);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next()){
						sbolddata.append("~ Lending Power = ").append(Helper.correctNull((String)rs1.getString("disc_grpname")));
					}
				}else{
					sbolddata.append("~ Lending Power = ").append("");
				}
				
				sbolddata.append("~ Access For = ").append(strGrpAccess);
			}

			String grp_id=correctNull((String)hshValues.get("grp_id"));
			int intCount2=0;
			ResultSet rs=null;
			if(Helper.correctNull(ApplicationParams.getMONITORINGDBENABLED()).equalsIgnoreCase("YES"))
			{
				if (strAction.equalsIgnoreCase("insert")) 
				{
						hshQuery.put("strQueryId", "setgroupsins_mon");
						arrVal.add(getGroupId());
						arrVal.add(correctNull((String)hshValues.get("grp_name")));
						arrVal.add(getGroupRights(hshValues));
						arrVal.add(correctNull((String)hshValues.get("grp_discreteid")));
						arrVal.add(correctNull((String)hshValues.get("grouplimitslist")));
						hshQuery.put("arrValues",arrVal);
				       	hshQueryValues.put("1",hshQuery);
				       	hshQueryValues.put("size", "1");
				       	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateMonitoringData");
				}
				if(strAction.equalsIgnoreCase("update"))
				{
						hshQuery.put("strQueryId", "setgroupsupd_mon");
						arrVal.add(correctNull((String)hshValues.get("grp_name")));
						arrVal.add(getGroupRights(hshValues));
						arrVal.add(correctNull((String)hshValues.get("grp_discreteid")));
						arrVal.add(correctNull((String)hshValues.get("grouplimitslist")));
						arrVal.add(correctNull((String)hshValues.get("grp_id")));
						hshQuery.put("arrValues",arrVal);
				       	hshQueryValues.put("1",hshQuery);
				       	hshQueryValues.put("size", "1");
				       	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateMonitoringData");
				}
				
				if(strAction.equalsIgnoreCase("delete"))
				{
						rs=DBUtils.executeMonitoringQuery("setdelcheckgroup_mon^"+grp_id);
						if(rs.next())
						{
							intCount2 = Integer.parseInt(rs.getString(1));
						}
						if(rs!=null)
						{
							rs.close();
						}
						if(intCount2 == 0)
						{
							hshQuery=new HashMap();
							hshQuery.put("strQueryId", "setgroupsdel_mon");
							arrVal.add(hshValues.get("grp_id"));
						}
						else
						{
							strExp = strExp+"Cannot delete the group,it contains users";
							throw new Exception(strExp);
						}
						hshQuery.put("arrValues", arrVal);
						hshQueryValues.put("1", hshQuery);
						hshQueryValues.put("size", "1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateMonitoringData");
				}
			}
			
			//hshQueryValues.put("size", "1");
			if (strAction.equalsIgnoreCase("insert")) {			
				hshQuery.put("strQueryId", "setgroupsins");
				arrValues.add(getGroupId());
				arrValues.add(correctNull((String)hshValues.get("grp_name")));
				arrValues.add(getGroupRights(hshValues));
				arrValues.add(correctNull((String)hshValues.get("grp_discreteid")));
				arrValues.add(correctNull((String)hshValues.get("grouplimitslist")));
				arrValues.add(correctNull((String)hshValues.get("sel_accessfor")));
				arrValues.add(correctNull((String)hshValues.get("dscurrent")));
			}
			if (strAction.equalsIgnoreCase("update")) {
				hshQuery.put("strQueryId", "setgroupsupd");
				arrValues.add(correctNull((String)hshValues.get("grp_name")));
				arrValues.add(getGroupRights(hshValues));
				arrValues.add(correctNull((String)hshValues.get("grp_discreteid")));
				arrValues.add(correctNull((String)hshValues.get("grouplimitslist")));
				arrValues.add(correctNull((String)hshValues.get("sel_accessfor")));
				arrValues.add(correctNull((String)hshValues.get("dscurrent")));
				arrValues.add(correctNull((String)hshValues.get("grp_id")));
				
			}
			
			if(strAction.equalsIgnoreCase("delete"))
			{
				rs=DBUtils.executeLAPSQuery("setdelcheckgroup^"+grp_id);
				if(rs.next())
				{
					intCount2 = Integer.parseInt(rs.getString(1));
				}
				if(rs!=null)
				{
					rs.close();
				}
				if(intCount2 == 0)
				{
					hshQuery=new HashMap();
					hshQuery.put("strQueryId", "setgroupsdel");
					arrValues.add(hshValues.get("grp_id"));
				}
				else
				{
					strExp = strExp+"Cannot delete the group,it contains users";
					throw new Exception(strExp);
				}
			}
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			hshQueryValues.put("size", "1");

			// for Entering the values into auditrial
			String strdiscretid = correctNull((String)hshValues.get("grouplimitslist"));
			
			try
			{
				rs = DBUtils.executeLAPSQuery("selgrouplimitsdetails^" + strdiscretid);
				if (rs.next())
				{
					strdiscretid  = correctNull((String)rs.getString("DISC_GRPNAME"));
				}
				if (strdiscretid.equalsIgnoreCase("0"))
				{
					strdiscretid="";
				}
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing getData" + e.getMessage());
			}
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			StringBuilder sbAt = new StringBuilder();
			if(!strAction.equalsIgnoreCase("delete"))
			{
				sbAt.append("Group Name ="+ correctNull((String) hshValues.get("grp_name")));
				sbAt.append("~Group Rights="+ correctNull((String) getGroupRight(hshValues)));
				sbAt.append("~Lending power ="+ strdiscretid);
				sbAt.append("~Access For  ="+ SetupParams.getSetupParams("accessfor", Helper.correctNull((String) hshValues.get("sel_accessfor"))));
			}			
			AuditTrial.auditNewLog(hshValues,"7",strKeyId,sbAt.toString(),sbolddata.toString());
		} 
		catch (Exception ce) {
			log.error("in bean... " + ce);
			throw new EJBException("Error in updateData " + ce.toString());
		}
	}

	public HashMap getData(HashMap hshRequestValues)  {
		ResultSet rs = null;
		HashMap hshRecord = null;
		String strId = "", strName = "", strRights = "", strDiscreteId = "",strGoupLimitList="";
		boolean recordflag=false;
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec = new ArrayList();

		try {
			rs = DBUtils.executeLAPSQuery("setgroupssel");
			hshRecord = new HashMap();
			while (rs.next()) {
				recordflag=true;
				strId = correctNull((String)rs.getString("grp_id"));
				strName = correctNull((String)rs.getString("grp_name"));
				strRights = correctNull((String)rs.getString("grp_rights"));
				strGoupLimitList=correctNull((String)rs.getString("grouplimitslist"));
				strDiscreteId = correctNull((String)rs.getString("grp_discreteid"));
				vecRec = new ArrayList();
				vecRec.add(strId);
				vecRec.add(strName);
				vecRec.add(strRights);
				vecRec.add(strDiscreteId);
				vecRec.add(strGoupLimitList);
				vecRec.add(correctNull((String)rs.getString("grp_accessfor")));
				vecVal.add(vecRec);
			}
			hshRecord.put("groups_data", vecVal);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
		} catch (Exception ce) {
			throw new EJBException("Error in getData " + ce.toString());
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

	private String getGroupId() {
		ResultSet rs = null;
		String strGroupId = "1";
		try {
			rs = DBUtils.executeLAPSQuery("setgroupsid");
			while (rs.next()) {
				strGroupId = rs.getString(1);
			}
		} catch (Exception e) {
			log.error("exception in geGroupId.. " + e);
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				log.error("Error closing the connection "+ cf.getMessage());
			}
		}
		return strGroupId;
	}

	private String getGroupRights(HashMap hshValues)
	{
		StringBuffer sbfRights=new StringBuffer();
		String strParam=null;
		strParam=(String)hshValues.get("chk_setupvital");//0
		sbfRights.append(getNavigationSecurity(strParam));
		strParam=(String)hshValues.get("chk_setupnonvital");//1
		sbfRights.append(getNavigationSecurity(strParam));
		strParam=(String)hshValues.get("chk_masters");//2
		sbfRights.append(getNavigationSecurity(strParam));
		strParam=(String)hshValues.get("chk_defaulterslist");//3
		sbfRights.append(getNavigationSecurity(strParam));
		strParam=(String)hshValues.get("chk_customerprofile");//4
		sbfRights.append(getNavigationSecurity(strParam));
		strParam=(String)hshValues.get("chk_branchapplication");//5
		sbfRights.append(getNavigationSecurity(strParam));
		strParam=(String)hshValues.get("chk_appraisal");//6
		sbfRights.append(getNavigationSecurity(strParam));
		strParam=(String)hshValues.get("chk_opscustomerprofile");//7		
		sbfRights.append(getNavigationSecurity(strParam));
		strParam=(String)hshValues.get("chk_opsapplication");//8		
		sbfRights.append(getNavigationSecurity(strParam));
		strParam=(String)hshValues.get("chk_TLR");//9		
		sbfRights.append(getNavigationSecurity(strParam));
		strParam=(String)hshValues.get("chk_CustomerProfile");//10		
		sbfRights.append(getNavigationSecurity(strParam));
		strParam=(String)hshValues.get("chk_application");//11		
		sbfRights.append(getNavigationSecurity(strParam));
		strParam=(String)hshValues.get("chk_Proposal");//12		
		sbfRights.append(getNavigationSecurity(strParam));
		strParam=(String)hshValues.get("chk_PIR");//13		
		sbfRights.append(getNavigationSecurity(strParam));		
		strParam=(String)hshValues.get("chk_monitoringregister");//14		
		sbfRights.append(getNavigationSecurity(strParam));
		strParam=(String)hshValues.get("chk_monitoringreport");//15	
		sbfRights.append(getNavigationSecurity(strParam));
		strParam=(String)hshValues.get("chk_NPA");//16		
		sbfRights.append(getNavigationSecurity(strParam));
		strParam=(String)hshValues.get("chk_Reports");//17		
		sbfRights.append(getNavigationSecurity(strParam));
		strParam=(String)hshValues.get("dscurrent");//18
		sbfRights.append(getOtherSecurity(strParam));
		strParam=(String)hshValues.get("chk_agrcustomerprofile");//19		
		sbfRights.append(getNavigationSecurity(strParam));
		strParam=(String)hshValues.get("chk_agrapplication");//20		
		sbfRights.append(getNavigationSecurity(strParam));
		strParam=(String)hshValues.get("chk_agrappraisal");//21		
		sbfRights.append(getNavigationSecurity(strParam));
		strParam=(String)hshValues.get("chk_allcustomerprofile");//22		
		sbfRights.append(getNavigationSecurity(strParam));
		strParam=(String)hshValues.get("chk_securities");//23		
		sbfRights.append(getNavigationSecurity(strParam));
		strParam=(String)hshValues.get("chk_golddepapplication");//24		
		sbfRights.append(getNavigationSecurity(strParam));
		strParam=(String)hshValues.get("chk_golddepappraisal");//25		
		sbfRights.append(getNavigationSecurity(strParam));
		strParam=(String)hshValues.get("chk_LODGE");//26		
		sbfRights.append(getNavigationSecurity(strParam));
		strParam=(String)hshValues.get("chk_onlinemailbox");//27		
		sbfRights.append(getNavigationSecurity(strParam));
		strParam=(String)hshValues.get("chk_nsdlappmailbox");//28		
		sbfRights.append(getNavigationSecurity(strParam));
		
		strParam=(String)hshValues.get("chk_print");//29		
		sbfRights.append(getNavigationSecurity(strParam));
		strParam=(String)hshValues.get("chk_branchinbox");//30		
		sbfRights.append(getNavigationSecurity(strParam));
		
		return sbfRights.toString();
	}

	private String getGroupRight(HashMap hshValues)
	{
		StringBuffer sbfRight=new StringBuffer();
		String strParam=null;
		String strNav =null;
		String strhidaction=null;
		strhidaction=(String)hshValues.get("hidAction");
		sbfRight.append("Navigational Security Access Only To ");
		strParam=(String)hshValues.get("chk_setupvital");
		strNav = getNavigationSecurity(strParam);
		if(strNav.equalsIgnoreCase("1"))
		{
			sbfRight.append("Setup - Vital");
			sbfRight.append(",");
		}
		
		strParam=(String)hshValues.get("chk_setupnonvital");
		strNav = getNavigationSecurity(strParam);
		if(strNav.equalsIgnoreCase("1"))
		{
			sbfRight.append("Setup - Non Vital");
			sbfRight.append(",");
		}
		
		strParam=(String)hshValues.get("chk_masters");
		strNav=getNavigationSecurity(strParam);
		if(strNav.equalsIgnoreCase("1"))
		{
			sbfRight.append("Masters");
			sbfRight.append(",");
		}
		
		strParam=(String)hshValues.get("chk_defaulterslist");
		strNav=getNavigationSecurity(strParam);
		if(strNav.equalsIgnoreCase("1"))
		{
			sbfRight.append("Defaulters List");
			sbfRight.append(",");
		}
		
		strParam=(String)hshValues.get("chk_customerprofile");
		strNav=getNavigationSecurity(strParam);
		if(strNav.equalsIgnoreCase("1"))
		{
			sbfRight.append("Retail Customer Profile");
			sbfRight.append(",");
		}
		
		strParam=(String)hshValues.get("chk_golddepapplication");
		strNav=getNavigationSecurity(strParam);
		if(strNav.equalsIgnoreCase("1"))
		{
			sbfRight.append("Gold & Deposit Application");
			sbfRight.append(",");
		}
		
		strParam=(String)hshValues.get("chk_golddepappraisal");
		strNav=getNavigationSecurity(strParam);
		if(strNav.equalsIgnoreCase("1"))
		{
			sbfRight.append("Gold & Deposit Appraisal");
			sbfRight.append(",");
		}
		
		strParam=(String)hshValues.get("chk_branchapplication");
		strNav=getNavigationSecurity(strParam);
		if(strNav.equalsIgnoreCase("1"))
		{
			sbfRight.append("Retail Application");
			sbfRight.append(",");
		}
		
		strParam=(String)hshValues.get("chk_appraisal");
		strNav=getNavigationSecurity(strParam);
		if(strNav.equalsIgnoreCase("1"))
		{
			sbfRight.append("Retail Appraisal");
			sbfRight.append(",");
		}
		
		strParam=(String)hshValues.get("chk_agrcustomerprofile");
		strNav=getNavigationSecurity(strParam);
		if(strNav.equalsIgnoreCase("1"))
		{
			sbfRight.append("Agriculture Customer Profile");
			sbfRight.append(",");
		}
			
		strParam=(String)hshValues.get("chk_agrapplication");
		strNav=getNavigationSecurity(strParam);
		if(strNav.equalsIgnoreCase("1"))
		{
			sbfRight.append("Agriculture Application");
			sbfRight.append(",");
		}
			
		strParam=(String)hshValues.get("chk_agrappraisal");
		strNav=getNavigationSecurity(strParam);
		if(strNav.equalsIgnoreCase("1"))
		{
			sbfRight.append("Agriculture Appraisal");
			sbfRight.append(",");
		}
					
		strParam=(String)hshValues.get("chk_opscustomerprofile");		
		strNav=getNavigationSecurity(strParam);
		if(strNav.equalsIgnoreCase("1"))
		{
			sbfRight.append("Tertiary Customer Profile");
			sbfRight.append(",");
		}
		
		strParam=(String)hshValues.get("chk_opsapplication");		
		strNav=getNavigationSecurity(strParam);
		if(strNav.equalsIgnoreCase("1"))
		{
			sbfRight.append("Tertiary Application");
			sbfRight.append(",");
		}
			
		strParam=(String)hshValues.get("chk_CustomerProfile");		
		strNav=getNavigationSecurity(strParam);
		if(strNav.equalsIgnoreCase("1"))
		{
			sbfRight.append(" Corporate & SME Customer Profile");
			sbfRight.append(",");
		}
		
		strParam=(String)hshValues.get("chk_application");		
		strNav=getNavigationSecurity(strParam);
		if(strNav.equalsIgnoreCase("1"))
		{
			sbfRight.append(" Corporate & SME Application");
			sbfRight.append(",");
		}
		
		strParam=(String)hshValues.get("chk_Proposal");		
		strNav=getNavigationSecurity(strParam);
		if(strNav.equalsIgnoreCase("1"))
		{
			sbfRight.append(" Corporate & SME  Proposal");
			sbfRight.append(",");
		}
		
		strParam=(String)hshValues.get("chk_monitoringregister");		
		strNav=getNavigationSecurity(strParam);
		if(strNav.equalsIgnoreCase("1"))
		{
			sbfRight.append("Post Disbursal Monitoring Register");
			sbfRight.append(",");
		}
		
		strParam=(String)hshValues.get("chk_monitoringreport");		
		strNav=getNavigationSecurity(strParam);
		if(strNav.equalsIgnoreCase("1"))
		{
			sbfRight.append("Post Disbursal Monitoring Report");
			sbfRight.append(",");
		}
		
		strParam=(String)hshValues.get("chk_TLR");		
		strNav=getNavigationSecurity(strParam);
		if(strNav.equalsIgnoreCase("1"))
		{
			sbfRight.append("Post Disbursal Term Loan Review");
			sbfRight.append(",");
		}
		
		strParam=(String)hshValues.get("chk_PIR");		
		strNav=getNavigationSecurity(strParam);
		if(strNav.equalsIgnoreCase("1"))
		{
			sbfRight.append(" Post Disbursal Post / Follow Up Inspection");
			sbfRight.append(",");
		}
		
		strParam=(String)hshValues.get("chk_NPA");		
		strNav=getNavigationSecurity(strParam);
		if(strNav.equalsIgnoreCase("1"))
		{
			sbfRight.append("Post Disbursal NPA");
			sbfRight.append(",");
		}
		
		strParam=(String)hshValues.get("chk_Reports");		
		strNav=getNavigationSecurity(strParam);
		if(strNav.equalsIgnoreCase("1"))
		{
			sbfRight.append("MIS - Reports");
			sbfRight.append(",");
		}
		sbfRight.append(" Data Security ");
		
		strParam=(String)hshValues.get("dscurrent");
		strNav=getOtherSecurity(strParam);		
		if(strNav.equalsIgnoreCase("r"))
		{
			sbfRight.append("Read");
		}
		if(strNav.equalsIgnoreCase("w"))
		{
			sbfRight.append("Write");
		}
		
		strParam=(String)hshValues.get("chk_LODGE");		
		strNav=getNavigationSecurity(strParam);
		if(strNav.equalsIgnoreCase("1"))
		{
			sbfRight.append("Proposal Lodging");
			sbfRight.append(",");
		}
		return sbfRight.toString();
	}
	
    private String getNavigationSecurity(String strParam)
	{
		if(strParam!=null && strParam.equals("1"))
		{
			return "1";
		}
		else
		{
			return "0";
		}
	}

	private String getOtherSecurity(String strParam)
	{
		if(strParam!=null && strParam.equalsIgnoreCase("r"))
		{
			return "r";
		}
		else if(strParam!=null && strParam.equalsIgnoreCase("w"))
		{
			return "w";
		}
		else
		{
			return "x";
		}
	}
}
