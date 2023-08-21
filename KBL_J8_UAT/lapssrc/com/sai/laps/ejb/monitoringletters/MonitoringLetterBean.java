package com.sai.laps.ejb.monitoringletters;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "MonitoringLetterBean", mappedName = "MonitoringLetterHome")
@Remote (MonitoringLetterRemote.class)
public class MonitoringLetterBean extends BeanAdapter {
	/**
	 * 
	 */
	// static Logger log=Logger.getLogger(MonitoringLetterBean.class);
	private static final long serialVersionUID = 1L;

	// public HashMap getFollowupInspectionCorporate(HashMap hshValues) throws
	// EJBException
	// {
	// HashMap hshRecord=new HashMap();
	// String strQuery="";
	// ArrayList arrCol = new ArrayList();
	// ArrayList arrRow = new ArrayList();
	// ArrayList arrRow1 = new ArrayList();
	// ArrayList arrCol1 = new ArrayList();
	// ResultSet rs = null;
	// ResultSet rs1 = null;
	// try
	// {
	// String strcbsid =correctNull((String) hshValues.get("cbsidno"));
	// //String stryear=Helper.correctNull((String)hshValues.get("mon_year"));
	// String strmonth=Helper.correctNull((String)hshValues.get("mon_month"));
	// String strmmrno=Helper.correctNull((String)hshValues.get("mmrno"));
	//			
	// strQuery=SQLParser.getSqlQuery("sel_personalinfo^"+strcbsid);
	// rs=DBUtils.executeQuery(strQuery);
	// String
	// strPersonalAddress="",strPersonalAddress1="",strCity="",strState="",strPincode="",
	// strPerSolid="";
	// if(rs.next())
	// {
	// strPerSolid=Helper.correctNull(rs.getString("personal_solid"));
	// strPersonalAddress=Helper.correctNull(rs.getString("personal_address"));
	// strPersonalAddress1=Helper.correctNull(rs.getString("personal_address1"));
	// strCity=Helper.correctNull(rs.getString("city"));
	// strState=Helper.correctNull(rs.getString("state"));
	// strPincode=Helper.correctNull(rs.getString("personal_pincode"));
	// }
	// hshRecord.put("strPersonalAddress",strPersonalAddress+", "+strPersonalAddress1+", "+strCity+", "+strState+" - "+strPincode);
	//			
	// if(rs!=null) rs.close();
	//			
	// strQuery=SQLParser.getSqlQuery("sel_org_name^"+strPerSolid);
	// rs=DBUtils.executeQuery(strQuery);
	// if(rs.next())
	// {
	// hshRecord.put("org_name",Helper.correctNull(rs.getString("org_name")));
	// }
	// if(rs!=null) rs.close();
	// strQuery=SQLParser.getSqlQuery("selinspectionreport^"+strcbsid+"^"+strmonth+"^"+stryear);
	// rs=DBUtils.executeQuery(strQuery);
	// if(rs.next())
	// {
	//
	// hshRecord.put("mmr_insvisitdate",correctNull(rs.getString("mmr_insvisitdate")));
	// hshRecord.put("mmr_insnorth",correctNull(rs.getString("mmr_insnorth")));
	// hshRecord.put("mmr_inseast",correctNull(rs.getString("mmr_inseast")));
	// hshRecord.put("mmr_inswest",correctNull(rs.getString("mmr_inswest")));
	// hshRecord.put("mmr_inssouth",correctNull(rs.getString("mmr_inssouth")));
	// hshRecord.put("mmr_insprimarysecurity",correctNull(rs.getString("mmr_insprimarysecurity")));
	// hshRecord.put("mmr_inscollsecurity",correctNull(rs.getString("mmr_inscollsecurity")));
	// hshRecord.put("mmr_inspresentstatus",correctNull(rs.getString("mmr_inspresentstatus")));
	// hshRecord.put("mmr_inscomments",correctNull(rs.getString("mmr_inscomments")));
	// hshRecord.put("mmr_insdocument",correctNull(rs.getString("mmr_insdocument")));
	// hshRecord.put("mmr_insfeatures",correctNull(rs.getString("mmr_insfeatures")));
	// if("1".equals(correctNull(rs.getString("mmr_insbanknameboard"))))
	// hshRecord.put("mmr_insbanknameboard","Yes");
	// else if("2".equals(correctNull(rs.getString("mmr_insbanknameboard"))))
	// hshRecord.put("mmr_insbanknameboard","No");
	// else
	// hshRecord.put("mmr_insbanknameboard","");
	//				
	// if("1".equals(correctNull(rs.getString("mmr_insborrowernamebord"))))
	// hshRecord.put("mmr_insborrowernamebord","Yes");
	// else if("2".equals(correctNull(rs.getString("mmr_insborrowernamebord"))))
	// hshRecord.put("mmr_insborrowernamebord","No");
	// else
	// hshRecord.put("mmr_insborrowernamebord","");
	//				
	// if("1".equals(correctNull(rs.getString("mmr_insmaintanance"))))
	// hshRecord.put("mmr_insmaintanance","Yes");
	// else if("2".equals(correctNull(rs.getString("mmr_insmaintanance"))))
	// hshRecord.put("mmr_insmaintanance","No");
	// else
	// hshRecord.put("mmr_insmaintanance","");
	// hshRecord.put("mmr_month",correctNull(rs.getString("mmr_month")));
	// hshRecord.put("mmr_year",correctNull(rs.getString("mmr_year")));
	// hshRecord.put("mmr_security",correctNull(rs.getString("mmr_security")));
	// }
	// if(rs!=null) rs.close();
	//			
	// rs=DBUtils.executeLAPSQuery("getmmrfundbased^"+strmmrno);
	// while(rs.next())
	// {
	//				
	// arrCol1=new ArrayList();
	// arrCol1.add(correctNull((String)rs.getString("MMRFUND_FACILITY")));
	// arrCol1.add(correctNull((String)rs.getString("MMRFUND_SANCAMT")));
	// arrCol1.add(correctNull((String)rs.getString("MMRFUND_OSAMT")));
	// arrCol1.add(correctNull((String)rs.getString("MMRFUND_OVERDUEAMT")));
	// arrRow1.add(arrCol1);
	// }
	// hshRecord.put("arrRow",arrRow1);
	// if(rs!=null) rs.close();
	// strQuery=SQLParser.getSqlQuery("sel_monitoring_security^"+strcbsid);
	// rs=DBUtils.executeQuery(strQuery);
	//			
	// while(rs.next())
	// {
	// if(!"".equals(correctNull((String)rs.getString("MONSEC_SECURITYTYPE"))))
	// {
	// arrCol = new ArrayList();
	// if("1".equals(correctNull((String)rs.getString("MONSEC_SECURITYTYPE"))))
	// arrCol.add("Primary");
	// else
	// arrCol.add("Collateral");
	// arrCol.add(correctNull((String)rs.getString("MONSEC_OTHERDETAILS")));
	//					
	//					
	// String insno=correctNull((String)rs.getString("MONSEC_INSURANCENO"));
	// strQuery=SQLParser.getSqlQuery("monitoring_insur^"+insno+"^"+strcbsid);
	// rs1=DBUtils.executeQuery(strQuery);
	// if(rs1.next())
	// {
	// arrCol.add(correctNull((String)rs1.getString("ins_coveramt")));
	// arrCol.add(correctNull((String)rs1.getString("ins_expirydate")));
	// }
	// else
	// {
	// arrCol.add("");
	// arrCol.add("");
	// }
	// arrCol.add(correctNull((String)rs.getString("stat_data_desc1")));
	// arrCol.add(correctNull((String)rs.getString("monsec_valuatamount")));
	// if(rs1!=null) rs1.close();
	// arrRow.add(arrCol);
	// }
	// }
	// hshRecord.put("arrSecurity",arrRow);
	//			
	// if(rs!=null) rs.close();
	//			
	// strQuery=SQLParser.getSqlQuery("sel_limit_custwise^"+strcbsid);
	// rs=DBUtils.executeQuery(strQuery);
	//			
	// if(rs.next())
	// {
	// hshRecord.put("limit_reviewdate",correctNull((String)rs.getString("limit_reviewdate")));
	// }
	// if(rs!=null) rs.close();
	// hshRecord.put("cbsname",Helper.correctNull((String)hshValues.get("cbsname")));
	// //
	// hshRecord.put("strOrgName",Helper.correctNull((String)hshValues.get("strOrgName")));
	// }
	// catch(Exception e1)
	// {
	// throw new EJBException("Error in getConsortium :: "+e1.getMessage());
	// }
	// finally
	// {
	// try
	// {
	// if(rs!=null)
	// {
	// rs.close();
	// }
	// if(rs1!=null)
	// {
	// rs1.close();
	// }
	// }
	// catch(Exception e)
	// {
	// e.printStackTrace();
	// }
	// }
	// return hshRecord;
	// }

	public HashMap getStandingCropsPrint(HashMap hshValues)  {
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		ResultSet rs = null;
		ResultSet rs1 = null;
		try {
			String strcbsid = correctNull((String) hshValues.get("cbsidno"));
			String stryear = Helper.correctNull((String) hshValues
					.get("mon_year"));
			String strmonth = Helper.correctNull((String) hshValues
					.get("mon_month"));

			strQuery = SQLParser.getSqlQuery("sel_standingcrops^" + strcbsid
					+ "^" + strmonth + "^" + stryear);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrCol = new ArrayList();
				arrCol.add(correctNull((String) rs.getString("MMR_SLNO")));
				arrCol.add(correctNull((String) rs.getString("CROP")));
				arrCol.add(correctNull((String) rs.getString("ACERAGE")));
				arrCol.add(correctNull((String) rs.getString("CONDITION")));
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow", arrRow);
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser
					.getSqlQuery("sel_monlimitregisterCustomerbased^"
							+ strcbsid);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrCol = new ArrayList();
				arrRow = new ArrayList();
				arrCol
						.add(correctNull((String) rs
								.getString("limit_sanctamt")));
				arrCol
						.add(correctNull((String) rs
								.getString("limit_sanctdate")));
				String accno = Helper.correctNull((String) rs
						.getString("limit_cutaccno"));

				strQuery = SQLParser
						.getSqlQuery("getmmrfundbasedCustomerbased^" + strcbsid
								+ "^" + accno);
				rs1 = DBUtils.executeQuery(strQuery);
				if (rs1.next()) {
					arrCol.add(correctNull((String) rs1
							.getString("MMRFUND_OSAMT")));

				} else {
					arrCol.add("");
				}
				if (rs1 != null)
					rs.close();

				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow1", arrRow);
			if (rs != null) {
				rs.close();
			}

			strQuery = SQLParser.getSqlQuery("sel_followupInspection^"
					+ strcbsid + "^" + strmonth + "^" + stryear);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("ADDRESS", correctNull((String) rs
						.getString("ADDRESS")));
				hshRecord.put("PRESENT_INS_DATE", correctNull((String) rs
						.getString("PRESENT_INS_DATE")));
				hshRecord.put("PRESENT_NAME", correctNull((String) rs
						.getString("PRESENT_NAME")));
				hshRecord.put("PREVIOUS_INS_DATE", correctNull((String) rs
						.getString("PREVIOUS_INS_DATE")));
				hshRecord.put("PREVIOUS_NAME", correctNull((String) rs
						.getString("PREVIOUS_NAME")));
				hshRecord.put("DEVIATION", correctNull((String) rs
						.getString("DEVIATION")));
				hshRecord.put("DEVELOPMENT_PURPOSE", correctNull((String) rs
						.getString("DEVELOPMENT_PURPOSE")));
				hshRecord.put("LOAN_FOR_SINKING", correctNull((String) rs
						.getString("LOAN_FOR_SINKING")));
				hshRecord.put("PURCHASE_OF_MACHINERY", correctNull((String) rs
						.getString("PURCHASE_OF_MACHINERY")));
				hshRecord.put("SEASONAL_OPERATION", correctNull((String) rs
						.getString("SEASONAL_OPERATION")));
				hshRecord.put("MEDIUM_TERM_LOAN", correctNull((String) rs
						.getString("MEDIUM_TERM_LOAN")));
				hshRecord.put("COMMENTS", correctNull((String) rs
						.getString("COMMENTS")));
				hshRecord.put("PLACE", correctNull((String) rs
						.getString("PLACE")));
				hshRecord.put("DATE_VALUE", correctNull((String) rs
						.getString("DATE_VALUE")));
				hshRecord.put("NAME_VALUE", correctNull((String) rs
						.getString("NAME_VALUE")));
				hshRecord.put("DESIGNATION", correctNull((String) rs
						.getString("DESIGNATION")));
			}
			if (rs != null)
				rs.close();
			hshRecord.put("cbsname", Helper.correctNull((String) hshValues
					.get("cbsname")));
		} catch (Exception e1) {
			throw new EJBException("Error in getConsortium :: "
					+ e1.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (rs1 != null) {
					rs1.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return hshRecord;
	}

	public HashMap getStandingCrops(HashMap hshValues)  {
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		ResultSet rs = null;
		try {
			String postinspec_no = correctNull((String) hshValues
					.get("hidpostins_no"));

			strQuery = SQLParser.getSqlQuery("sel_standingcrops^"
					+ postinspec_no);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrCol = new ArrayList();
				arrCol.add(correctNull((String) rs.getString("MMR_SLNO")));
				arrCol.add(correctNull((String) rs.getString("CROP")));
				arrCol.add(correctNull((String) rs.getString("ACERAGE")));
				arrCol.add(correctNull((String) rs.getString("CONDITION")));
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow", arrRow);
		} catch (Exception e1) {
			throw new EJBException("Error in getConsortium :: "
					+ e1.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return hshRecord;
	}

	public void updateStandingCrops(HashMap hshValues)  {
		ResultSet rs = null;

		String strQuery = null;

		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();

		ArrayList arrValues = new ArrayList();

		try {
			String strAction = correctNull((String) hshValues.get("hidAction"));
			// String strUserId =
			// correctNull((String)hshValues.get("strUserId"));

			String postinspec_no = correctNull((String) hshValues
					.get("hidpostins_no"));
			// String
			// mon_month=Helper.correctNull((String)hshValues.get("mon_month"));
			// String
			// strYear=Helper.correctNull((String)hshValues.get("strYear"));
			// String strcbsid = correctNull((String)hshValues.get("cbsid"));

			String strCrop = correctNull((String) hshValues.get("txt_crop"));
			String strAcerage = correctNull((String) hshValues
					.get("txt_acerage"));
			String strCondition = correctNull((String) hshValues
					.get("txt_condition"));

			String strSno = correctNull((String) hshValues.get("hidsno"));

			if (strAction.equalsIgnoreCase("insert")) {
				strQuery = "max_standingcrops^" + postinspec_no;
				rs = DBUtils.executeLAPSQuery(strQuery);
				if (rs.next()) {
					strSno = Helper.correctNull((String) rs.getString("maxid"));
				}

				hshQueryValues = new HashMap();
				hshQuery = new HashMap();

				hshQuery.put("strQueryId", "ins_standingcrops");

				arrValues.add(strSno);
				arrValues.add(strCrop);
				arrValues.add(strAcerage);
				arrValues.add(strCondition);
				arrValues.add(postinspec_no);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (strAction.equalsIgnoreCase("update")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();

				hshQuery.put("strQueryId", "upd_standingcrops");

				arrValues.add(strCrop);
				arrValues.add(strAcerage);
				arrValues.add(strCondition);
				arrValues.add(strSno);
				arrValues.add(postinspec_no);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

			} else if (strAction.equalsIgnoreCase("Delete")) {
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_standingcrops");
				arrValues.add(strSno);
				arrValues.add(postinspec_no);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
		} catch (Exception e) {
			throw new EJBException("Error in updateDocumentRegister "
					+ e.getMessage());
		}

		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException(
						"Error closing in updateDocumentRegister the connection "
								+ cf.getMessage());
			}
		}
	}

	// public HashMap getFollowupMonitoring(HashMap hshRequestValues) throws
	// EJBException
	// {
	// ResultSet rs = null;
	// HashMap hshRecord = new HashMap();
	// String strQuery="",mon_month="",strYear="";
	// mon_month=Helper.correctNull((String)hshRequestValues.get("mon_month"));
	// strYear=Helper.correctNull((String)hshRequestValues.get("strYear"));
	// String strcbsid = correctNull((String)hshRequestValues.get("cbsid"));
	// if(strcbsid.equalsIgnoreCase(""))
	// {
	// strcbsid = correctNull((String)hshRequestValues.get("id"));
	// }
	//		
	// try
	// {
	//			
	// hshRecord = new HashMap();
	// strQuery =
	// SQLParser.getSqlQuery("sel_followupInspection^"+strcbsid+"^"+mon_month+"^"+strYear);
	// rs = DBUtils.executeQuery(strQuery);
	// if (rs.next())
	// {
	// hshRecord.put("ADDRESS",correctNull((String)rs.getString("ADDRESS")));
	// hshRecord.put("PRESENT_INS_DATE",correctNull((String)rs.getString("PRESENT_INS_DATE")));
	// hshRecord.put("PRESENT_NAME",correctNull((String)rs.getString("PRESENT_NAME")));
	// hshRecord.put("PREVIOUS_INS_DATE",correctNull((String)rs.getString("PREVIOUS_INS_DATE")));
	// hshRecord.put("PREVIOUS_NAME",correctNull((String)rs.getString("PREVIOUS_NAME")));
	// hshRecord.put("DEVIATION",correctNull((String)rs.getString("DEVIATION")));
	// hshRecord.put("DEVELOPMENT_PURPOSE",correctNull((String)rs.getString("DEVELOPMENT_PURPOSE")));
	// hshRecord.put("LOAN_FOR_SINKING",correctNull((String)rs.getString("LOAN_FOR_SINKING")));
	// hshRecord.put("PURCHASE_OF_MACHINERY",correctNull((String)rs.getString("PURCHASE_OF_MACHINERY")));
	// hshRecord.put("SEASONAL_OPERATION",correctNull((String)rs.getString("SEASONAL_OPERATION")));
	// hshRecord.put("MEDIUM_TERM_LOAN",correctNull((String)rs.getString("MEDIUM_TERM_LOAN")));
	// hshRecord.put("COMMENTS",correctNull((String)rs.getString("COMMENTS")));
	// hshRecord.put("PLACE",correctNull((String)rs.getString("PLACE")));
	// hshRecord.put("DATE_VALUE",correctNull((String)rs.getString("DATE_VALUE")));
	// hshRecord.put("NAME_VALUE",correctNull((String)rs.getString("NAME_VALUE")));
	// hshRecord.put("DESIGNATION",correctNull((String)rs.getString("DESIGNATION")));
	// }
	// if(rs!=null)rs.close();
	// hshRecord.put("cbsname",Helper.correctNull((String)hshRequestValues.get("strcbsname")));
	// }
	// catch(Exception e)
	// {
	// throw new EJBException(e.getMessage());
	// }
	// finally
	// {
	// try
	// {
	// if(rs!=null)
	// {
	// rs.close();
	// }
	//				
	// }
	// catch(Exception cf)
	// {
	// throw new EJBException("Error closing the connection "+cf.getMessage());
	// }
	// }
	// return hshRecord;
	//	
	// }

	// public void updateFollowupMonitoring(HashMap hshRequestValues) throws
	// EJBException
	// {
	//
	// HashMap hshQueryValues=null;
	// HashMap hshQuery=null;
	//		
	// ArrayList arrValues=null;
	//		
	// String strAction="";
	// String strcpsapp="",mon_month="",strYear="";
	//				
	// int intUpdatesize=0;
	//		
	// ResultSet rs=null;
	//		
	// strAction=Helper.correctNull((String)hshRequestValues.get("hidAction"));
	// strcpsapp=Helper.correctNull((String)hshRequestValues.get("cbsid"));
	// mon_month=Helper.correctNull((String)hshRequestValues.get("mon_month"));
	// strYear=Helper.correctNull((String)hshRequestValues.get("strYear"));
	//				
	// try
	// {
	// if(strAction.equalsIgnoreCase("insert"))
	// {
	// hshQuery=new HashMap();
	// hshQueryValues=new HashMap();
	// arrValues=new ArrayList();
	//				
	// intUpdatesize++;
	//				
	// arrValues.add(strcpsapp);
	// arrValues.add(mon_month);
	// arrValues.add(strYear);
	//				
	// hshQuery.put("strQueryId","del_followupInspection");
	// hshQuery.put("arrValues",arrValues);
	//				
	// hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
	//				
	// hshQuery=new HashMap();
	//				
	// arrValues=new ArrayList();
	//				
	// intUpdatesize++;
	//				
	// arrValues.add(strcpsapp);
	// arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_address")));
	// arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_presentdate")));
	// arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_presentname")));
	// arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_previousdate")));
	// arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_previousname")));
	// arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_utilised")));
	// arrValues.add(Helper.correctNull((String)hshRequestValues.get("text_development")));
	// arrValues.add(Helper.correctNull((String)hshRequestValues.get("text_sinking")));
	// arrValues.add(Helper.correctNull((String)hshRequestValues.get("text_purpose")));
	// arrValues.add(Helper.correctNull((String)hshRequestValues.get("text_seasonal")));
	// arrValues.add(Helper.correctNull((String)hshRequestValues.get("text_availed")));
	// arrValues.add(Helper.correctNull((String)hshRequestValues.get("text_comments")));
	// arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_place")));
	// arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_date")));
	// arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_name")));
	// arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_designation")));
	// arrValues.add(mon_month);
	// arrValues.add(strYear);
	//								
	// hshQuery.put("arrValues",arrValues);
	// hshQuery.put("strQueryId","ins_followupInspection");
	//				
	// hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
	// hshQueryValues.put("size",Integer.toString(intUpdatesize));
	//				
	// EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updatedata");
	// }
	//	
	// else if(strAction.equalsIgnoreCase("delete"))
	// {
	// hshQuery=new HashMap();
	// hshQueryValues=new HashMap();
	//				
	// arrValues=new ArrayList();
	//				
	// intUpdatesize++;
	//				
	// arrValues.add(strcpsapp);
	// arrValues.add(mon_month);
	// arrValues.add(strYear);
	//				
	// hshQuery.put("strQueryId","del_followupInspection");
	// hshQuery.put("arrValues",arrValues);
	//				
	// hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
	// hshQueryValues.put("size",Integer.toString(intUpdatesize));
	//				
	// EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updatedata");
	// }
	//		
	// }
	// catch(Exception e)
	// {
	// throw new
	// EJBException("Connection Error in updateNpainterest"+e.getMessage());
	// }
	// finally
	// {
	// try
	// {
	// if(rs!= null)
	// {
	// rs.close();
	// }
	//				
	// }
	// catch (Exception e1)
	// {
	// Logger.log("error occured"+e1.toString());
	// }
	// }
	//	
	// }

	public HashMap getborrowerdetails(HashMap hshRequestValues)
			 {
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		String strcbsaccno = correctNull((String) hshRequestValues
				.get("cbsaccno"));
		String strcbsid = correctNull((String) hshRequestValues.get("cbsid"));
		if (strcbsid.equalsIgnoreCase("")) {
			strcbsid = correctNull((String) hshRequestValues.get("id"));
		}
		String strOrgCode = correctNull((String) hshRequestValues
				.get("org_code"));

		try {

			hshRecord = new HashMap();
			strQuery = SQLParser.getSqlQuery("sel_personalinfo^" + strcbsid);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("personal_custname", correctNull((String) rs
						.getString("personal_custname")));
				hshRecord.put("personal_address", correctNull((String) rs
						.getString("personal_address")));
				hshRecord.put("personal_address1", correctNull((String) rs
						.getString("personal_address1")));
				hshRecord.put("city",
						correctNull((String) rs.getString("city")));
				hshRecord.put("state", correctNull((String) rs
						.getString("state")));
				hshRecord.put("personal_pincode", correctNull((String) rs
						.getString("personal_pincode")));
			}
			if (rs != null)
				rs.close();
			// strQuery = SQLParser.getSqlQuery("sel_orgname^"+strcbsaccno);
			strQuery = SQLParser.getSqlQuery("setorgselect^" + strOrgCode);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("org_name", correctNull((String) rs
						.getString("org_name")));
				hshRecord.put("org_add1", correctNull((String) rs
						.getString("org_add1")));
				hshRecord.put("org_add2", correctNull((String) rs
						.getString("org_add2")));
				hshRecord.put("org_citycode", correctNull((String) rs
						.getString("org_city")));
				hshRecord.put("org_cityname", correctNull((String) rs
						.getString("city_name")));
				hshRecord.put("org_statecode", correctNull((String) rs
						.getString("org_state")));
				hshRecord.put("org_statename", correctNull((String) rs
						.getString("state_name")));
				hshRecord.put("org_zip", correctNull((String) rs
						.getString("org_zip")));
				hshRecord.put("org_phone", correctNull((String) rs
						.getString("org_phone")));

			}
			hshRecord.put("strcbsaccno", strcbsaccno);
		} catch (Exception e) {
			throw new EJBException(e.getMessage());
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

	public HashMap getLCDetails(HashMap hshRequestValues)  {
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		String strcbsid = correctNull((String) hshRequestValues.get("cbsid"));
		String strcbsaccno = correctNull((String) hshRequestValues
				.get("cbsaccno"));
		if (strcbsid.equalsIgnoreCase("")) {
			strcbsid = correctNull((String) hshRequestValues.get("id"));
		}
		// String strsolid="";
		String strOrgCode = correctNull((String) hshRequestValues
				.get("org_code"));

		try {

			hshRecord = new HashMap();
			strQuery = SQLParser.getSqlQuery("sel_personalinfo^" + strcbsid);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("personal_custname", correctNull((String) rs
						.getString("personal_custname")));
				hshRecord.put("personal_address", correctNull((String) rs
						.getString("personal_address")));
				hshRecord.put("personal_address1", correctNull((String) rs
						.getString("personal_address1")));
				hshRecord.put("city",
						correctNull((String) rs.getString("city")));
				hshRecord.put("state", correctNull((String) rs
						.getString("state")));
				hshRecord.put("personal_pincode", correctNull((String) rs
						.getString("personal_pincode")));
				// strsolid=correctNull((String)rs.getString("personal_solid"));
			}
			if (rs != null)
				rs.close();
			/*
			 * strQuery = SQLParser.getSqlQuery("sel_LCDetails^"+strcbsid); rs =
			 * DBUtils.executeQuery(strQuery); if (rs.next()) {
			 * hshRecord.put("LC_LCNumber"
			 * ,correctNull((String)rs.getString("LC_LCNumber")));
			 * hshRecord.put(
			 * "LC_LCopendate",correctNull((String)rs.getString("LC_LCopendate"
			 * )));
			 * 
			 * }
			 */
			strQuery = SQLParser.getSqlQuery("sel_osfromfundbased^"
					+ strcbsaccno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("FUND_OSAMT", correctNull((String) rs
						.getString("FUND_OSAMT")));
			}
			if (rs != null)
				rs.close();
			// strQuery = SQLParser.getSqlQuery("sel_orgname^"+strcbsaccno);
			strQuery = SQLParser.getSqlQuery("setorgselect^" + strOrgCode);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("org_name", correctNull((String) rs
						.getString("org_name")));
				hshRecord.put("org_add1", correctNull((String) rs
						.getString("org_add1")));
				hshRecord.put("org_add2", correctNull((String) rs
						.getString("org_add2")));
				hshRecord.put("org_citycode", correctNull((String) rs
						.getString("org_city")));
				hshRecord.put("org_cityname", correctNull((String) rs
						.getString("city_name")));
				hshRecord.put("org_statecode", correctNull((String) rs
						.getString("org_state")));
				hshRecord.put("org_statename", correctNull((String) rs
						.getString("state_name")));
				hshRecord.put("org_zip", correctNull((String) rs
						.getString("org_zip")));
				hshRecord.put("org_phone", correctNull((String) rs
						.getString("org_phone")));
			}

			hshRecord.put("strcbsaccno", strcbsaccno);

		} catch (Exception e) {
			throw new EJBException(e.getMessage());
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

	public HashMap getloandefaulter(HashMap hshRequestValues)
			 {
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		String strcbsid = correctNull((String) hshRequestValues.get("cbsid"));

		if (strcbsid.equalsIgnoreCase("")) {
			strcbsid = correctNull((String) hshRequestValues.get("id"));
		}
		String straccno = correctNull((String) hshRequestValues.get("cbsaccno"));
		String strOrgCode = correctNull((String) hshRequestValues
				.get("org_code"));

		try {

			hshRecord = new HashMap();
			strQuery = SQLParser.getSqlQuery("sel_personalinfo^" + strcbsid);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("personal_custname", correctNull((String) rs
						.getString("personal_custname")));
				hshRecord.put("personal_address", correctNull((String) rs
						.getString("personal_address")));
				hshRecord.put("personal_address1", correctNull((String) rs
						.getString("personal_address1")));
				hshRecord.put("city",
						correctNull((String) rs.getString("city")));
				hshRecord.put("state", correctNull((String) rs
						.getString("state")));
				hshRecord.put("personal_pincode", correctNull((String) rs
						.getString("personal_pincode")));

			}
			if (rs != null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("sel_overdefaults^" + strcbsid
					+ "^" + straccno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("FUND_OVERDUEAMT", correctNull((String) rs
						.getString("FUND_OVERDUEAMT")));
				hshRecord.put("fund_overduesince", correctNull((String) rs
						.getString("fund_overduesince")));

			}
			if (rs != null)
				rs.close();
			// strQuery = SQLParser.getSqlQuery("sel_orgname^"+straccno);
			strQuery = SQLParser.getSqlQuery("setorgselect^" + strOrgCode);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("org_name", correctNull((String) rs
						.getString("org_name")));
				hshRecord.put("org_add1", correctNull((String) rs
						.getString("org_add1")));
				hshRecord.put("org_add2", correctNull((String) rs
						.getString("org_add2")));
				hshRecord.put("org_citycode", correctNull((String) rs
						.getString("org_city")));
				hshRecord.put("org_cityname", correctNull((String) rs
						.getString("city_name")));
				hshRecord.put("org_statecode", correctNull((String) rs
						.getString("org_state")));
				hshRecord.put("org_statename", correctNull((String) rs
						.getString("state_name")));
				hshRecord.put("org_zip", correctNull((String) rs
						.getString("org_zip")));
				hshRecord.put("org_phone", correctNull((String) rs
						.getString("org_phone")));
			}
			hshRecord.put("straccno", straccno);
		} catch (Exception e) {
			throw new EJBException(e.getMessage());
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

	public HashMap getGuarantee(HashMap hshRequestValues)  {
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		String strcbsid = correctNull((String) hshRequestValues.get("cbsid"));
		if (strcbsid.equalsIgnoreCase("")) {
			strcbsid = correctNull((String) hshRequestValues.get("id"));
		}
		String straccno = correctNull((String) hshRequestValues.get("cbsaccno"));
		String strOrgCode = correctNull((String) hshRequestValues
				.get("org_code"));

		try {

			hshRecord = new HashMap();
			strQuery = SQLParser.getSqlQuery("sel_personalinfo^" + strcbsid);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("personal_custname", correctNull((String) rs
						.getString("personal_custname")));
				hshRecord.put("personal_address", correctNull((String) rs
						.getString("personal_address")));
				hshRecord.put("personal_address1", correctNull((String) rs
						.getString("personal_address1")));
				hshRecord.put("city",
						correctNull((String) rs.getString("city")));
				hshRecord.put("state", correctNull((String) rs
						.getString("state")));
				hshRecord.put("personal_pincode", correctNull((String) rs
						.getString("personal_pincode")));
			}
			if (rs != null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("sel_loandefaultsforgua^"
					+ strcbsid);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("GUARANTEE_NUMBER", correctNull((String) rs
						.getString("GUARANTEE_NUMBER")));
				hshRecord.put("GUARANTEE_INVOKEDATE", correctNull((String) rs
						.getString("GUARANTEE_INVOKEDATE")));
				hshRecord.put("GUARANTEE_BENEFICIARYNAME",
						correctNull((String) rs
								.getString("GUARANTEE_BENEFICIARYNAME")));
			}
			if (rs != null)
				rs.close();
			// strQuery = SQLParser.getSqlQuery("sel_orgname^"+straccno);
			strQuery = SQLParser.getSqlQuery("setorgselect^" + strOrgCode);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("org_name", correctNull((String) rs
						.getString("org_name")));
				hshRecord.put("org_add1", correctNull((String) rs
						.getString("org_add1")));
				hshRecord.put("org_add2", correctNull((String) rs
						.getString("org_add2")));
				hshRecord.put("org_citycode", correctNull((String) rs
						.getString("org_city")));
				hshRecord.put("org_cityname", correctNull((String) rs
						.getString("city_name")));
				hshRecord.put("org_statecode", correctNull((String) rs
						.getString("org_state")));
				hshRecord.put("org_statename", correctNull((String) rs
						.getString("state_name")));
				hshRecord.put("org_zip", correctNull((String) rs
						.getString("org_zip")));
				hshRecord.put("org_phone", correctNull((String) rs
						.getString("org_phone")));
			}
			hshRecord.put("straccno", straccno);

		} catch (Exception e) {
			throw new EJBException(e.getMessage());
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

	public HashMap getBillDetails(HashMap hshRequestValues)  {
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		String strcbsid = correctNull((String) hshRequestValues.get("cbsid"));
		if (strcbsid.equalsIgnoreCase("")) {
			strcbsid = correctNull((String) hshRequestValues.get("id"));
		}
		String straccno = correctNull((String) hshRequestValues.get("cbsaccno"));
		String strOrgCode = correctNull((String) hshRequestValues
				.get("org_code"));
		try {

			hshRecord = new HashMap();
			strQuery = SQLParser.getSqlQuery("sel_personalinfo^" + strcbsid);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("personal_custname", correctNull((String) rs
						.getString("personal_custname")));
				hshRecord.put("personal_address", correctNull((String) rs
						.getString("personal_address")));
				hshRecord.put("personal_address1", correctNull((String) rs
						.getString("personal_address1")));
				hshRecord.put("city",
						correctNull((String) rs.getString("city")));
				hshRecord.put("state", correctNull((String) rs
						.getString("state")));
				hshRecord.put("personal_pincode", correctNull((String) rs
						.getString("personal_pincode")));
			}
			if (rs != null)
				rs.close();
			if (correctNull((String) hshRequestValues.get("ltrcode"))
					.equalsIgnoreCase("BILDUE")) {
				strQuery = SQLParser.getSqlQuery("sel_defaultforbills^"
						+ straccno);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("LC_LCOPENDATE", correctNull((String) rs
							.getString("LC_LCOPENDATE")));
					hshRecord.put("LC_BILLS_NOTIONAL_DATE",
							correctNull((String) rs
									.getString("LC_BILLS_NOTIONAL_DATE")));
				}
			} else {
				hshRecord.put("billno", correctNull((String) hshRequestValues
						.get("billno")));
				hshRecord.put("billdate", correctNull((String) hshRequestValues
						.get("billdate")));
				hshRecord.put("billamt", correctNull((String) hshRequestValues
						.get("billamt")));
			}
			// strQuery = SQLParser.getSqlQuery("sel_orgname^"+straccno);
			strQuery = SQLParser.getSqlQuery("setorgselect^" + strOrgCode);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("org_name", correctNull((String) rs
						.getString("org_name")));
				hshRecord.put("org_add1", correctNull((String) rs
						.getString("org_add1")));
				hshRecord.put("org_add2", correctNull((String) rs
						.getString("org_add2")));
				hshRecord.put("org_citycode", correctNull((String) rs
						.getString("org_city")));
				hshRecord.put("org_cityname", correctNull((String) rs
						.getString("city_name")));
				hshRecord.put("org_statecode", correctNull((String) rs
						.getString("org_state")));
				hshRecord.put("org_statename", correctNull((String) rs
						.getString("state_name")));
				hshRecord.put("org_zip", correctNull((String) rs
						.getString("org_zip")));
				hshRecord.put("org_phone", correctNull((String) rs
						.getString("org_phone")));
			}

			hshRecord.put("straccno", straccno);
		} catch (Exception e) {
			throw new EJBException(e.getMessage());
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

	public HashMap getLimitRenewalDetails(HashMap hshRequestValues)
			 {
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		String strcbsid = correctNull((String) hshRequestValues.get("cbsid"));
		if (strcbsid.equalsIgnoreCase("")) {
			strcbsid = correctNull((String) hshRequestValues.get("id"));
		}
		String straccno = correctNull((String) hshRequestValues.get("cbsaccno"));
		String strltrcode = correctNull((String) hshRequestValues
				.get("ltrcode"));
		String strReviewdate = correctNull((String) hshRequestValues
				.get("revdate"));
		String strOrgCode = correctNull((String) hshRequestValues
				.get("org_code"));
		try {

			hshRecord = new HashMap();
			strQuery = SQLParser.getSqlQuery("sel_personalinfo^" + strcbsid);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("personal_custname", correctNull((String) rs
						.getString("personal_custname")));
				hshRecord.put("personal_address", correctNull((String) rs
						.getString("personal_address")));
				hshRecord.put("personal_address1", correctNull((String) rs
						.getString("personal_address1")));
				hshRecord.put("city",
						correctNull((String) rs.getString("city")));
				hshRecord.put("state", correctNull((String) rs
						.getString("state")));
				hshRecord.put("personal_pincode", correctNull((String) rs
						.getString("personal_pincode")));
			}
			if (strltrcode.equalsIgnoreCase("GENREV")) {
				/*
				 * if(rs!=null)rs.close(); ArrayList arrRow=new ArrayList();
				 * ArrayList arrCol=new ArrayList(); strQuery =
				 * SQLParser.getSqlQuery
				 * ("selrenewalaccounts^"+strReviewdate+"^"+strcbsid); rs =
				 * DBUtils.executeQuery(strQuery); while(rs.next()) { arrCol=new
				 * ArrayList();
				 * arrCol.add(correctNull(rs.getString("facility")));
				 * arrCol.add(correctNull(rs.getString("limit_sanctamt")));
				 * arrRow.add(arrCol); } hshRecord.put("arrRow",arrRow);
				 */
				hshRecord.put("revdate", strReviewdate);
			} else {
				if (rs != null)
					rs.close();
				strQuery = SQLParser.getSqlQuery("sel_nonrenewalforlimits^"
						+ strcbsid + "^" + straccno);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strReviewdate = correctNull((String) rs
							.getString("LIMIT_REVIEWDATE"));
					hshRecord.put("LIMIT_REVIEWDATE", strReviewdate);
					// hshRecord.put("BILLS_BILLDUEDATE",correctNull((String)rs.getString("BILLS_BILLDUEDATE")));

				}
			}

			if (rs != null)
				rs.close();
			ArrayList arrRow = new ArrayList();
			ArrayList arrCol = new ArrayList();
			strQuery = SQLParser.getSqlQuery("selrenewalaccounts^"
					+ strReviewdate + "^" + strcbsid);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("facility")));
				arrCol.add(correctNull(rs.getString("limit_sanctamt")));
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow", arrRow);

			if (rs != null)
				rs.close();
			// strQuery = SQLParser.getSqlQuery("sel_orgname^"+straccno);
			strQuery = SQLParser.getSqlQuery("setorgselect^" + strOrgCode);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("org_name", correctNull((String) rs
						.getString("org_name")));
				hshRecord.put("org_add1", correctNull((String) rs
						.getString("org_add1")));
				hshRecord.put("org_add2", correctNull((String) rs
						.getString("org_add2")));
				hshRecord.put("org_citycode", correctNull((String) rs
						.getString("org_city")));
				hshRecord.put("org_cityname", correctNull((String) rs
						.getString("city_name")));
				hshRecord.put("org_statecode", correctNull((String) rs
						.getString("org_state")));
				hshRecord.put("org_statename", correctNull((String) rs
						.getString("state_name")));
				hshRecord.put("org_zip", correctNull((String) rs
						.getString("org_zip")));
				hshRecord.put("org_phone", correctNull((String) rs
						.getString("org_phone")));
			}
			hshRecord.put("straccno", straccno);
		} catch (Exception e) {
			throw new EJBException(e.getMessage());
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

	public HashMap getInsuranceRecovered(HashMap hshRequestValues)
			 {
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		String strSrlno = "";
		String strcbsid = correctNull((String) hshRequestValues.get("cbsid"));
		if (strcbsid.equalsIgnoreCase("")) {
			strcbsid = correctNull((String) hshRequestValues.get("id"));
		}
		String straccno = correctNull((String) hshRequestValues.get("cbsaccno"));
		String strOrgCode = correctNull((String) hshRequestValues
				.get("org_code"));

		try {

			strSrlno = correctNull((String) hshRequestValues.get("strslno"));
			hshRecord = new HashMap();
			strQuery = SQLParser.getSqlQuery("sel_personalinfo^" + strcbsid);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("personal_custname", correctNull((String) rs
						.getString("personal_custname")));
				hshRecord.put("personal_address", correctNull((String) rs
						.getString("personal_address")));
				hshRecord.put("personal_address1", correctNull((String) rs
						.getString("personal_address1")));
				hshRecord.put("city",
						correctNull((String) rs.getString("city")));
				hshRecord.put("state", correctNull((String) rs
						.getString("state")));
				hshRecord.put("personal_pincode", correctNull((String) rs
						.getString("personal_pincode")));
			}
			if (rs != null)
				rs.close();

			strQuery = SQLParser.getSqlQuery("selinsregforletter^" + straccno
					+ "^" + strcbsid + "^" + strSrlno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("INS_EXPIRYDATE", correctNull((String) rs
						.getString("INS_EXPIRYDATE")));
				hshRecord.put("INS_COVERAMT", correctNull((String) rs
						.getString("INS_COVERAMT")));

			}
			// strQuery = SQLParser.getSqlQuery("sel_orgname^"+straccno);
			strQuery = SQLParser.getSqlQuery("setorgselect^" + strOrgCode);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("org_name", correctNull((String) rs
						.getString("org_name")));
				hshRecord.put("org_add1", correctNull((String) rs
						.getString("org_add1")));
				hshRecord.put("org_add2", correctNull((String) rs
						.getString("org_add2")));
				hshRecord.put("org_citycode", correctNull((String) rs
						.getString("org_city")));
				hshRecord.put("org_cityname", correctNull((String) rs
						.getString("city_name")));
				hshRecord.put("org_statecode", correctNull((String) rs
						.getString("org_state")));
				hshRecord.put("org_statename", correctNull((String) rs
						.getString("state_name")));
				hshRecord.put("org_zip", correctNull((String) rs
						.getString("org_zip")));
				hshRecord.put("org_phone", correctNull((String) rs
						.getString("org_phone")));
			}
			hshRecord.put("straccno", straccno);

		} catch (Exception e) {
			throw new EJBException(e.getMessage());
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

	public HashMap getNonsubmission(HashMap hshRequestValues)
			 {
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		String strcbsid = correctNull((String) hshRequestValues.get("cbsid"));
		if (strcbsid.equalsIgnoreCase("")) {
			strcbsid = correctNull((String) hshRequestValues.get("id"));
		}
		String straccno = correctNull((String) hshRequestValues.get("cbsaccno"));
		try {

			hshRecord = new HashMap();
			strQuery = SQLParser.getSqlQuery("sel_personalinfo^" + strcbsid);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("personal_custname", correctNull((String) rs
						.getString("personal_custname")));
				hshRecord.put("personal_address", correctNull((String) rs
						.getString("personal_address")));
				hshRecord.put("personal_address1", correctNull((String) rs
						.getString("personal_address1")));
				hshRecord.put("city",
						correctNull((String) rs.getString("city")));
				hshRecord.put("state", correctNull((String) rs
						.getString("state")));
				hshRecord.put("personal_pincode", correctNull((String) rs
						.getString("personal_pincode")));
			}
			if (rs != null)
				rs.close();
			/*
			 * strQuery =
			 * SQLParser.getSqlQuery("sel_msodestimateforlr^"+straccno); rs =
			 * DBUtils.executeQuery(strQuery); if (rs.next()) {
			 * hshRecord.put("mon_msodaccountingyear"
			 * ,correctNull((String)rs.getString("mon_msodaccountingyear"))); }
			 */

			if (rs != null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("sel_orgname^" + straccno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("org_name", correctNull((String) rs
						.getString("org_name")));
				hshRecord.put("org_add1", correctNull((String) rs
						.getString("org_add1")));
				hshRecord.put("org_add2", correctNull((String) rs
						.getString("org_add2")));
				hshRecord.put("org_citycode", correctNull((String) rs
						.getString("org_city")));
				hshRecord.put("org_cityname", correctNull((String) rs
						.getString("city_name")));
				hshRecord.put("org_statecode", correctNull((String) rs
						.getString("org_state")));
				hshRecord.put("org_statename", correctNull((String) rs
						.getString("state_name")));
				hshRecord.put("org_zip", correctNull((String) rs
						.getString("org_zip")));
				hshRecord.put("org_phone", correctNull((String) rs
						.getString("org_phone")));
			}
			hshRecord.put("straccno", straccno);

		} catch (Exception e) {
			throw new EJBException(e.getMessage());
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

	public HashMap getDrawingPower(HashMap hshRequestValues)
			 {
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		String strcbsid = correctNull((String) hshRequestValues.get("cbsid"));
		if (strcbsid.equalsIgnoreCase("")) {
			strcbsid = correctNull((String) hshRequestValues.get("id"));
		}
		String straccno = correctNull((String) hshRequestValues.get("cbsaccno"));
		try {

			hshRecord = new HashMap();
			strQuery = SQLParser.getSqlQuery("sel_personalinfo^" + strcbsid);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("personal_custname", correctNull((String) rs
						.getString("personal_custname")));
				hshRecord.put("personal_address", correctNull((String) rs
						.getString("personal_address")));
				hshRecord.put("personal_address1", correctNull((String) rs
						.getString("personal_address1")));
				hshRecord.put("city",
						correctNull((String) rs.getString("city")));
				hshRecord.put("state", correctNull((String) rs
						.getString("state")));
				hshRecord.put("personal_pincode", correctNull((String) rs
						.getString("personal_pincode")));
			}
			if (rs != null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("sel_msoddpforlr^" + strcbsid
					+ "^" + straccno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("dp", correctNull((String) rs.getString("dp")));
				hshRecord.put("mon_msodmonth", correctNull((String) rs
						.getString("mon_msodmonth")));
			}

		} catch (Exception e) {
			throw new EJBException(e.getMessage());
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
}