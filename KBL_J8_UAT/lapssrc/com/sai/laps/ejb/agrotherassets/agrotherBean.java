package com.sai.laps.ejb.agrotherassets;

import java.text.SimpleDateFormat;

import java.util.ArrayList;

import java.rmi.RemoteException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.perpropertydetails.PropertyDetailsBean;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.securitymaster.SecurityMasterBean;
@Stateless(name = "agrotherBean", mappedName = "agrotherHome")
@Remote (agrotherRemote.class)
public class agrotherBean extends BeanAdapter
{


	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(agrotherBean.class);	

	public void updateagrassets(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		
		ResultSet rs = null;
		
		String strAction = "";
		String strApplicationNo = "";
		String strAppid="";
		StringBuilder sbolddata=new StringBuilder();
		
		
		String strchobank_accnttype_text = null;	
		String strsno="";
		int intUpdatesize = 0;
		try
		{
			strAction = correctNull((String) hshValues.get("hidAction"));
			strApplicationNo = correctNull((String) hshValues.get("appno"));
			strAppid=correctNull((String) hshValues.get("selapptype"));
			if (strApplicationNo.equalsIgnoreCase(""))
			{
				strApplicationNo = correctNull((String) hshValues.get("strappno"));
			}
			
			strchobank_accnttype_text = correctNull((String)hshValues.get("chobank_apptype1"));
			strsno= correctNull((String)hshValues.get("hidsno"));
			//agr_selotherassetsbysno
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				String strQuery=SQLParser.getSqlQuery("agr_selotherassetsbysno^"+strsno+"^"+strAppid+"^"+strApplicationNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					sbolddata.append("S.No. =").append(strsno).append(" ~Applicant Type  =")
					.append(correctNull(strchobank_accnttype_text))
					.append(" ~ Security Details =").append(correctNull(rs.getString("agr_security")))
					.append(" ~ Particulars =").append(correctNull(rs.getString("agr_particular")))
					.append(" ~ Purchase Price (Rs.) =").append((Helper.formatDoubleValue(rs.getDouble("agr_purchase"))))
					.append(" ~ Market Value (Rs.) =").append(Helper.formatDoubleValue(rs.getDouble("agr_market")))
					.append(" ~ Valuation Date =").append(correctNull(rs.getString("agr_valuationdate")))
					.append(" ~ Valuation Done By =").append(correctNull(rs.getString("agr_valuedby")));
				}
			}
			if(strAction.equals("insert"))
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				
				String strQuery=SQLParser.getSqlQuery("agr_maxotherassets^"+strApplicationNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strsno=correctNull(rs.getString("cnt"));
				}
				
				hshQuery.put("strQueryId", "agr_insotherassets");
				
				arrValues.add(strApplicationNo);
				arrValues.add(strAppid);
				arrValues.add(strsno);
				arrValues.add(correctNull((String)hshValues.get("txt_security")));
				arrValues.add(correctNull((String)hshValues.get("txt_particular")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_purchase")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_market")));
				arrValues.add(correctNull((String)hshValues.get("txt_valuationdate")));
				arrValues.add(correctNull((String)hshValues.get("txt_valuername")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
			if(strAction.equals("update"))
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				
				hshQuery.put("strQueryId", "agr_updotherassets");
				
				arrValues.add(strAppid);
				arrValues.add(correctNull((String)hshValues.get("txt_security")));
				arrValues.add(correctNull((String)hshValues.get("txt_particular")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_purchase")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_market")));
				arrValues.add(correctNull((String)hshValues.get("txt_valuationdate")));
				arrValues.add(correctNull((String)hshValues.get("txt_valuername")));
				
				arrValues.add(strsno);
				arrValues.add(strApplicationNo);
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
					
			}
			if (strAction.equals("delete"))
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				
				
				hshQuery.put("strQueryId", "agr_delotherassets");
				
				arrValues.add(strsno);
				arrValues.add(strApplicationNo);
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");	
			}
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("insert"))
			{
			sbAuditTrial.append("S.No. =").append(strsno).append("~Applicant Type  =")
				.append(correctNull(strchobank_accnttype_text))
				.append("~Security Details =").append(correctNull((String)hshValues.get("txt_security")))
				.append("~Particulars =").append(correctNull((String)hshValues.get("txt_particular")))
				.append("~Purchase Price (Rs.) =").append(Helper.correctDouble((String)hshValues.get("txt_purchase")))
				.append("~Market Value (Rs.) =").append(Helper.correctDouble((String)hshValues.get("txt_market")))
				.append("~Valuation Date =").append(correctNull((String)hshValues.get("txt_valuationdate")))
				.append("~Valuation Done By =").append(correctNull((String)hshValues.get("txt_valuername")));;
					
			//AuditTrial.auditLog(hshValues,"56",strApplicationNo,sbAuditTrial.toString());
			}	
			AuditTrial.auditNewLog(hshValues,"56",strApplicationNo,sbAuditTrial.toString(),sbolddata.toString());	
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
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection " + e.getMessage());
			}
		}
	}

	public void updategolddetails(HashMap hshValues) 
	{
		ResultSet rs = null;
		
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues1 = new ArrayList();
		ArrayList arrValues = new ArrayList();
		String strQuery="";
		String strsno = "";
		String strAppno = "";
		StringBuilder sbolddata=new StringBuilder();
		String strSecId="";
		String noOfCustomers="1";
		HashMap hshQuery = new HashMap();
		HashMap hshRecord = new HashMap();
		boolean boolStatus=false;
		try
		{
			String strAction = Helper.correctNull((String) hshValues.get("hidAction"));
			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			String strsel_arttype = Helper.correctNull((String) hshValues.get("sel_ArticleType"));
			String strtxt_artdesc = Helper.correctNull((String) hshValues.get("txt_artdesc"));
			String strQuantity= Helper.correctNull((String) hshValues.get("txt_quantity"));
			String strtxt_gross = Helper.correctNull((String) hshValues.get("txt_gross"));
			String strtxt_net = Helper.correctNull((String) hshValues.get("txt_net"));
			String strtxt_qtytouch = Helper.correctNull((String) hshValues.get("txt_qtytouch"));
			String strtxt_totmktrate = Helper.correctNull((String) hshValues.get("txt_totmktrate"));
			String strtxt_rate = Helper.correctNull((String) hshValues.get("txt_rate"));
			String strtxt_esti = Helper.correctNull((String) hshValues.get("txt_esti"));
			String strtxt_bankvalue = Helper.correctNull((String) hshValues.get("txt_bankvalue"));
			String strGRSNo= Helper.correctNull((String) hshValues.get("hidGRSNo"));
			strsno = (String) hshValues.get("hidgoldsno");
			String strAppid=Helper.correctNull((String)hshValues.get("hidapplicantid"));
			String strGoldValue=Helper.correctNull((String) hshValues.get("txt_estimated"));
			SecurityMasterBean SM=new SecurityMasterBean();
			rs = DBUtils.executeLAPSQuery("select_perappoldid^" + strAppid);
			if(rs.next())
			{
				strAppid=Helper.correctNull((String)rs.getString("perapp_oldid"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			if(rs !=null){
				rs.close();
			}
			//selgolddetailsbyartno
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				strQuery=SQLParser.getSqlQuery("selgolddetailsbyartno^"+strsno+"^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					sbolddata.append(
					"~Description of Articles =").append(correctNull(rs.getString("AGR_ARTDESC"))).append(
					"~Quantity =").append(correctNull(rs.getString("agr_quantity"))).append(
					"~Weight Of Articles(gm.) Gross =").append(correctNull(rs.getString("AGR_ARTGROSSWT"))).append(
					"~Weight Of Articles(gm.) Net =").append(correctNull(rs.getString("AGR_ARTNETWT"))).append(
					"~Purity  =").append(correctNull(rs.getString("AGR_ARTQTYTOUCH"))).append(
					"~Last Market Rate as per IBJA=").append(correctNull(rs.getString("AGR_ARTMKTRATE"))).append(
					"~Average of previous 30 day's closing Gold Rate as per IBJA =").append(correctNull(rs.getString("AGR_ARTRATE"))).append(
					"~Estimated value of the article =").append(correctNull(rs.getString("AGR_ESTRATE")));
				}
			}
			if (strAction.equals("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				rs = DBUtils.executeLAPSQuery("selmaxgoldloan^" + strAppno);
				if (rs.next())
				{
					strsno = correctNull((String) rs.getString("snoagrmax"));
				}
				else
				{
					strsno = "1";
				}
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "insgoldloan");
				arrValues.add(strAppno);
				arrValues.add(strsno);
				arrValues.add(strtxt_artdesc);
				arrValues.add(strtxt_gross);
				arrValues.add(strtxt_net);
				arrValues.add(strtxt_qtytouch);
				arrValues.add(strtxt_totmktrate);
				arrValues.add(strtxt_rate);
				arrValues.add(strtxt_esti);
				arrValues.add(strtxt_bankvalue);
				arrValues.add(strQuantity);
				arrValues.add(strGRSNo);
				//strSecId=SM.getOldAppidWithSno(strAppid);
				arrValues.add(strSecId);
				arrValues.add(strsel_arttype);
				arrValues.add(strGoldValue);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				/* Changes by Karthikeyan.S
				 * For inserting Gold Ornaments details in Securities
				 */
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				hshQuery.put("strQueryId", "ins_securitiesgolddep");
//				arrValues.add(strSecId);
//				arrValues.add("8");
//				arrValues.add("52");
//				arrValues.add("N");
//				arrValues.add(strtxt_esti);
//				hshQuery.put("arrValues", arrValues);
//				hshQueryValues.put("2", hshQuery);
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				hshQuery.put("strQueryId", "ins_ownership_securities");
//				arrValues.add(strSecId);
//				arrValues.add(strAppid);
//				arrValues.add(noOfCustomers);
//				hshQuery.put("arrValues", arrValues);
//				hshQueryValues.put("3", hshQuery);
//				hshQueryValues.put("size", "3");
				/* End */
				
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
			else if (strAction.equalsIgnoreCase("update"))
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "updgolddetails");
				arrValues.add(strtxt_artdesc);
				arrValues.add(strtxt_gross);
				arrValues.add(strtxt_net);
				arrValues.add(strtxt_qtytouch);
				arrValues.add(strtxt_totmktrate);
				arrValues.add(strtxt_rate);
				arrValues.add(strtxt_esti);
				arrValues.add(strtxt_bankvalue);
				arrValues.add(strQuantity);
				arrValues.add(strGRSNo);
				strSecId=correctNull((String)hshValues.get("hidSecurityId"));
				arrValues.add(strSecId);
				arrValues.add(strsel_arttype);
				arrValues.add(strGoldValue);
				arrValues.add(strAppno);
				arrValues.add(strsno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				/* Changes by Karthikeyan.S
				 * For updating Gold Ornaments details in Securities
				 */
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				hshQuery.put("strQueryId", "del_securities");
//				arrValues.add(strSecId);
//				hshQuery.put("arrValues", arrValues);
//				hshQueryValues.put("2", hshQuery);
//				
//				arrValues = new ArrayList();
//				hshQuery = new HashMap();
//				hshQuery.put("strQueryId", "del_ownership_securities");
//				arrValues.add(strSecId);
//				hshQuery.put("arrValues", arrValues);
//				hshQueryValues.put("3", hshQuery);
//				
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				hshQuery.put("strQueryId", "ins_securitiesgolddep");
//				arrValues.add(strSecId);
//				arrValues.add("8");
//				arrValues.add("52");
//				arrValues.add("N");
//				arrValues.add(strtxt_esti);
//				hshQuery.put("arrValues", arrValues);
//				hshQueryValues.put("4", hshQuery);
//				
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				hshQuery.put("strQueryId", "ins_ownership_securities");
//				arrValues.add(strSecId);
//				arrValues.add(strAppid);
//				arrValues.add(noOfCustomers);
//				hshQuery.put("arrValues", arrValues);
//				hshQueryValues.put("5", hshQuery);
//				hshQueryValues.put("size", "5");
				/* End */
				
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
			else if (strAction.equalsIgnoreCase("Delete"))
			{
				hshQuery.put("strQueryId", "delgolddetails");
				arrValues1.add(strAppno);
				arrValues1.add(strsno);
				hshQuery.put("arrValues", arrValues1);
				hshQueryValues.put("1", hshQuery);
				/* Changes by Karthikeyan.S
				 * For deleting Gold Ornaments details in Securities
				 */
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				strSecId=correctNull((String) hshValues.get("hidSecurityId"));
//				hshQuery.put("strQueryId", "del_securities");
//				arrValues.add(strSecId);
//				hshQuery.put("arrValues", arrValues);
//				hshQueryValues.put("2", hshQuery);
//				
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				hshQuery.put("strQueryId", "del_ownership_securities");
//				arrValues.add(strSecId);
//				hshQuery.put("arrValues", arrValues);
//				hshQueryValues.put("3", hshQuery);
//				hshQueryValues.put("size", "3");
				/* End */
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
			
			
			
			hshQueryValues=new HashMap();
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "del_date");
			arrValues.add(strAppno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			
			
			if (strAction.equals("insert")||strAction.equals("update"))
			{
				if(rs!=null)
				rs.close();
				strQuery = SQLParser.getSqlQuery("sel_goldwight^" + strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "upd_per_cuscbsaccountdata");
					arrValues.add("Pledge of Gold ornaments of Net weight "+Helper.correctNull(rs.getString("netweight"))+" gm with Market value Rs. "+Helper.formatDoubleValue(rs.getDouble("netval")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size","2");
					hshQueryValues.put("2",hshQuery);
				}
			}
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			hshRecord.put("hidSecurityId",strSecId);
			hshRecord.put("hidAction",strAction);
			hshRecord.put("txt_descjewel",strtxt_artdesc);
			hshRecord.put("txt_quality",strtxt_qtytouch);
			hshRecord.put("txt_netweight",strtxt_net);
			hshRecord.put("txt_marketrate",strtxt_totmktrate);
			hshRecord.put("txt_amount",strtxt_esti);
			//SM.updateJewelDetail(hshRecord);
			
//			---------------------------------------Audittrial------------------------
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{
			sbAuditTrial.append(
			"~Description of Articles =").append(correctNull((String)hshValues.get("txt_artdesc"))).append(
			"~Quantity =").append(correctNull((String )hshValues.get("txt_quantity"))).append(
			"~Weight Of Articles(gm.) Gross =").append(correctNull((String )hshValues.get("txt_gross"))).append(
			"~Weight Of Articles(gm.) Net =").append(correctNull((String )hshValues.get("txt_net"))).append(
			"~Purity  =").append(correctNull((String )hshValues.get("txt_qtytouch"))).append(
			"~Last Market Rate as per IBJA =").append(correctNull((String )hshValues.get("txt_totmktrate"))).append(
			"~RAverage of previous 30 day's closing Gold Rate as per IBJA =").append(correctNull((String )hshValues.get("txt_rate"))).append(
			"~Estimated value of the article (in Rs.)=").append(correctNull((String )hshValues.get("txt_esti")));
			}
			AuditTrial.auditNewLog(hshValues,"226",strAppno,sbAuditTrial.toString(),sbolddata.toString());
			
			//-------------------------------------------End---------------------------
			
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updategolddetails " + e.getMessage());
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
				throw new EJBException("Error in closing Connection " + e.getMessage());
			}
		}

	}

	public HashMap getgolddetails(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		ArrayList arrRow = new ArrayList();
		ResultSet rs = null;
		String strQuery="";
		String appno="", strAppId="", strRecmdAmt="";
		String AccoutNo="", strGoldCoinNetweight="", strMaxNetWeight="";
		try
		{
			appno=Helper.correctNull((String)hshValues.get("appno"));
			if(appno.equalsIgnoreCase("") || appno.equalsIgnoreCase("null")){
				appno=Helper.correctNull((String)hshValues.get("strappno"));
			}
			strAppId=Helper.correctNull((String)hshValues.get("hidapplicantid"));
			if(strAppId.equalsIgnoreCase("") || strAppId.equalsIgnoreCase("null")){
				strAppId=Helper.correctNull((String)hshValues.get("hidDemoId"));
			}
			rs = DBUtils.executeLAPSQuery("select_perappoldid^" + strAppId);
			if(rs.next())
			{
				strAppId=Helper.correctNull((String)rs.getString("perapp_oldid"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("selgolddetails^" + appno);
			double dbESTRATE=0.00;
			double  dbESTRATE1=0.00;
			double dbNetWeight=0.00;
			while (rs.next())
			{
				ArrayList arrCol = new ArrayList();
				arrCol.add(correctNull((String) rs.getString("AGR_ARTCATID")));
				arrCol.add(correctNull((String) rs.getString("AGR_ARTNO")));
				arrCol.add(correctNull((String) rs.getString("AGR_ARTDESC")));
				arrCol.add(correctNull((String) rs.getString("AGR_ARTGROSSWT")));
				arrCol.add(correctNull((String) rs.getString("AGR_ARTNETWT")));
				arrCol.add(correctNull((String) rs.getString("AGR_ARTQTYTOUCH")));
				arrCol.add(correctNull((String) rs.getString("AGR_ARTMKTRATE")));
				arrCol.add(correctNull((String) rs.getString("AGR_ARTRATE")));
				arrCol.add(correctNull((String) rs.getString("AGR_ESTRATE")));
				arrCol.add(correctNull((String)rs.getString("agr_quantity")));
				arrCol.add(correctNull((String)rs.getString("AGR_BANKVALUE")));
				arrCol.add(correctNull((String)rs.getString("agr_grsno")));
				arrCol.add(correctNull((String)rs.getString("agr_secid")));
				arrCol.add(correctNull((String)rs.getString("agr_articletype")));
				arrCol.add(correctNull((String)rs.getString("agr_netvalue")));
				 dbESTRATE=Double.parseDouble(Helper.correctDouble((String) rs.getString("AGR_ESTRATE")));
				dbESTRATE1=dbESTRATE1+dbESTRATE;
				dbNetWeight=dbNetWeight+Double.parseDouble(Helper.correctDouble((String) rs.getString("AGR_ARTNETWT")));
				arrRow.add(arrCol);
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_sumofnetgold^"+"G"+"^"+strAppId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strGoldCoinNetweight=Helper.correctNull((String)rs.getString("agr_artnetwttotal"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("selgoldratemaster^Y");
			rs =DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strMaxNetWeight=Helper.correctNull((String)rs.getString("grm_maxnetweight"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			String APP_PARENT_APPNO="";
			strQuery=SQLParser.getSqlQuery("sel_parentappno_renewal^"+appno);
			rs =DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				APP_PARENT_APPNO=Helper.correctNull((String)rs.getString("APP_PARENT_APPNO"));
			}
			String oldapp_goldcoin_netgm="";
			if(!APP_PARENT_APPNO.equals(""))
			{
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_sumofnetgold_oldapp^"+"G"+"^"+strAppId+"^"+APP_PARENT_APPNO);
				rs =DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strGoldCoinNetweight=Helper.correctNull((String)rs.getString("agr_artnetwttotal"));
				}
			}			
			PropertyDetailsBean PDB=new PropertyDetailsBean();
			PDB.updateLoanRecmdAmtData(appno, dbESTRATE1);		//Updating Loan Recommended Amount
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("getlreq^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strRecmdAmt=Helper.correctDouble((String)rs.getString("loan_recmdamt"));
			}
			hshRecord.put("arrRow", arrRow);
			hshRecord.put("appno", appno);
			hshRecord.put("dbESTRATE1", Helper.formatDoubleValue(dbESTRATE1));
			hshRecord.put("strRecmdAmt",strRecmdAmt);
			hshRecord.put("prdcode", Helper.correctNull((String)hshValues.get("prdcode")));
			hshRecord.put("strAppId", strAppId);
			hshRecord.put("strGoldCoinNetweight", strGoldCoinNetweight);
			hshRecord.put("strMaxNetWeight", strMaxNetWeight);
			hshRecord.put("strNetWeight", Helper.formatDoubleValue(dbNetWeight));
			updateSecurityValue(appno, dbESTRATE1);				//Updating Securities
			hshRecord=getGoldRateDetails(hshRecord);			//Fetching Gold Rate Details
			hshRecord=getRentInsuranceCalculation(hshRecord);	//Rent & Insurance Calculation
			hshRecord=getJewelAppraisalCalculation(hshRecord);	//Jewel Appraisal Calculation
		if(rs !=null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_Gold_loanAccountNo^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				AccoutNo=Helper.correctNull((String)rs.getString("CBS_ACCOUNTNO"));
			}
			if (rs != null)
			{
				rs.close();
			}
			hshRecord.put("AccoutNo",AccoutNo);
		}
		catch (Exception e1)
		{
			throw new EJBException(e1.getMessage());
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
				throw new EJBException("Error in closing Connection " + e.getMessage());
			}
		}

		hshRecord.put("comapp_id", appno);
		return hshRecord;
	}

	public HashMap getagrassets(HashMap hshValues) 
	{
		ResultSet rs = null;
		
		HashMap hshResult = new HashMap();
		
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		
		String strApplicationNo="";
		String strQuery="";
		String strApptype="";
		try
		{
			strApplicationNo = correctNull((String)hshValues.get("appno"));
			if (strApplicationNo.equalsIgnoreCase(""))
			{
				strApplicationNo = correctNull((String)hshValues.get("strappno"));
			}
			strApptype=correctNull((String)hshValues.get("selapptype"));
			
			if(!strApptype.equals("") && !strApplicationNo.equals(""))
			{
				strQuery=SQLParser.getSqlQuery("agr_selotherassets^"+strApptype+"^"+strApplicationNo);
				
				rs = DBUtils.executeQuery(strQuery);
				
				while (rs.next())
				{
					arryCol = new ArrayList();
					arryCol.add(correctNull(rs.getString("sno")));
					arryCol.add(correctNull(rs.getString("agr_security")));
					arryCol.add(correctNull(rs.getString("agr_particular")));
					arryCol.add(Helper.formatDoubleValue(rs.getDouble("agr_purchase")));
					arryCol.add(Helper.formatDoubleValue(rs.getDouble("agr_market")));
					arryCol.add(correctNull(rs.getString("agr_valuationdate")));
					arryCol.add(correctNull(rs.getString("agr_valuedby")));
					arryRow.add(arryCol);
				}
			}
			hshResult.put("arryRow", arryRow);
			hshResult.put("strAppValue",strApptype);
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
				throw new EJBException("Error in closing Connection " + e.getMessage());
			}
		}
		return hshResult;
	}
	
	
	public HashMap getgolddetailsprint(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		ResultSet rs = null;
		
		String appno="";
		String strQuery="";

		try
		{
			if(appno.equalsIgnoreCase("")){
				appno=correctNull((String)hshValues.get("appno"));
			}
			if(appno.equalsIgnoreCase("") || appno.equalsIgnoreCase("null")){
				appno=correctNull((String)hshValues.get("strappno"));
			}
			strQuery=SQLParser.getSqlQuery("selgolddetails^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			double dbESTRATE=0.00;
			double  dbESTRATE1=0.00;
			while (rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull((String) rs.getString("AGR_ARTCATID")));
				vecCol.add(correctNull((String) rs.getString("AGR_ARTNO")));
				vecCol.add(correctNull((String) rs.getString("AGR_ARTDESC")));
				vecCol.add(correctNull((String) rs.getString("AGR_ARTGROSSWT")));
				vecCol.add(correctNull((String) rs.getString("AGR_ARTNETWT")));
				vecCol.add(correctNull((String) rs.getString("AGR_ARTQTYTOUCH")));
				vecCol.add(correctNull((String) rs.getString("AGR_ARTMKTRATE")));
				vecCol.add(correctNull((String) rs.getString("AGR_ARTRATE")));
				vecCol.add(correctNull((String) rs.getString("AGR_ESTRATE")));
				vecCol.add(correctNull((String) rs.getString("agr_quantity")));
				vecCol.add(correctNull((String) rs.getString("agr_grsno")));
				vecCol.add(correctNull((String) rs.getString("agr_secid")));
				dbESTRATE=Double.parseDouble(Helper.correctDouble((String) rs.getString("AGR_ESTRATE")));
				dbESTRATE1=dbESTRATE1+dbESTRATE;
					
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow", vecRow);
			hshRecord.put("dbESTRATE1", Helper.formatDoubleValue(dbESTRATE1));
			
			strQuery = SQLParser.getSqlQuery("agr_sel_bullockrepay^"+appno+ "^" +"aH");	
			if(rs!=null)
				rs.close();
			rs =DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshRecord.put("txt_holiday",correctNull(rs.getString("bullock_holiday")));
				hshRecord.put("sel_payment",correctNull(rs.getString("bullock_payment")));
				hshRecord.put("txt_installment",correctNull(rs.getString("bullock_installment")));
				hshRecord.put("txt_date",correctNull(rs.getString("bullock_date")));
				hshRecord.put("txt_lastinstallment",correctNull(rs.getString("bullock_lastinstallment")));
				hshRecord.put("recommendedamt",correctNull(rs.getString("loanamount")));
				hshRecord.put("txt_farmdate",correctNull(rs.getString("agr_farmdate")));
				hshRecord.put("txt_hypo",correctNull(rs.getString("agr_hypo")));
				hshRecord.put("sel_insurance",correctNull(rs.getString("agr_insurance")));
			}
			if(rs!=null)
			{
				rs.close();
			}
			if(rs !=null)
			{
				rs.close();
			}
			String strProdPurpose="";
			rs = DBUtils.executeLAPSQuery("selprodpurpose^" +appno);
			if(rs.next()){strProdPurpose=Helper.correctNull((String)rs.getString("prd_purpose"));}
			/*
			 * 			For Purchase of Ready Built House and Used Vehicle loan, 
			 * 				Margin is based on age of the building / vehicle respectively
			 */
			if(strProdPurpose.equalsIgnoreCase("H") || strProdPurpose.equalsIgnoreCase("U")) 
			{
				rs = DBUtils.executeLAPSQuery("pergetloanProductbymargin^" +appno);
			}
			else
			{
				rs = DBUtils.executeLAPSQuery("pergetloanProduct^" +appno);
			}
			if(rs.next())
			{
				hshRecord.put("txt_installment", correctNull(rs.getString("lreqterms")));
				hshRecord.put("mintrate", correctNull(rs.getString("mintrate")));
				hshRecord.put("sancamount", correctNull(rs.getString("sancamount")));
				hshRecord.put("ProductType", correctNull(rs.getString("prd_type")));
				
			
			}
			if(rs!=null)
				rs.close();
			
			rs=DBUtils.executeLAPSQuery("securesel^"+appno);
			
			if(rs.next())
			{
				hshRecord.put("sel_payment", correctNull(rs.getString("loan_periodicity")));
				hshRecord.put("loan_noofinstallment", correctNull(rs.getString("loan_noofinstallment")));
			}
			if(rs!=null)
				rs.close();
			
			rs=DBUtils.executeLAPSQuery("get_Appstat^"+appno);
			
			if(rs.next())
			{
				hshRecord.put("app_processdate", correctNull(rs.getString("app_processdate")));
			}
			
			
			
			// hshRecord.put("comapp_id",comapp_id);
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("selBranchCityName^"+appno);
			while (rs.next())
			{ 
				
				hshRecord.put("strorgname",correctNull(rs.getString("org_name")));
			}
			if(rs!=null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("selapplicant_byappno^"+appno+"^a");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("appname",correctNull(rs.getString("perapp_title"))+ " . " +correctNull(rs.getString("perapp_fname")));
			}
			hshRecord.put("appno",appno);
			
			 hshRecord.putAll((HashMap)EJBInvoker.executeStateLess("perapplicant",hshRecord,"checkEligibility"));
		}
		catch (Exception e1)
		{
			throw new EJBException(e1.getMessage());
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
				throw new EJBException("Error in closing Connection " + e.getMessage());
			}
		}

		hshRecord.put("comapp_id", appno);
		return hshRecord;
	}
	public HashMap getGoldRateDetails(HashMap hshRecord) 
	{
		ResultSet rs=null;
		String strGoldValue="", prdcode="", strSchemeType="", strGoldRate="",strAvgRate="";
		String strQuery="", strGRSNo="", strAppId="", strEmpStatus=""; 
		try
		{
			prdcode=Helper.correctNull((String)hshRecord.get("prdcode"));
			strAppId=Helper.correctNull((String)hshRecord.get("strAppId"));
			rs = DBUtils.executeLAPSQuery("selcustomerdetails^"+strAppId);
			if(rs.next())
			{
				strEmpStatus=Helper.correctNull(rs.getString("perapp_employment"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("selschemetype^"+prdcode);
			if(rs.next())
			{
				strSchemeType=Helper.correctNull((String)rs.getString("prd_schemetype"));
				if(strEmpStatus.equalsIgnoreCase("4"))
				{
					if(strSchemeType.equalsIgnoreCase("Q"))
					{
						strGoldValue="grm_agriglquick";
					}
					else if(strSchemeType.equalsIgnoreCase("C"))
					{
						strGoldValue="grm_agriglclassic";
					}
					else if(strSchemeType.equalsIgnoreCase("T"))
					{
						strGoldValue="grm_agriglcomfort";
					}
					else if(strSchemeType.equalsIgnoreCase("M"))
					{
						strGoldValue="grm_agriglstaff";
					}
					else
					{
						strGoldValue="0";
					}
				}
				else
				{
					if(strSchemeType.equalsIgnoreCase("Q"))
					{
						strGoldValue="grm_retglquick";
					}
					else if(strSchemeType.equalsIgnoreCase("C"))
					{
						strGoldValue="grm_retglclassic";
					}
					else if(strSchemeType.equalsIgnoreCase("T"))
					{
						strGoldValue="grm_retglcomfort";
					}
					else if(strSchemeType.equalsIgnoreCase("S"))
					{
						strGoldValue="grm_retglstaff";
					}
					else
					{
						strGoldValue="0";
					}
				}
			}
			if(rs!=null)
			{
				rs.close();
			}
			if(!strGoldValue.equalsIgnoreCase(""))
			{
				strQuery = SQLParser.getSqlQuery("selgoldratevalue");
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strGoldRate=Helper.correctDouble((String)rs.getString("PER_GOLDRATE"));
					strAvgRate=Helper.correctDouble((String)rs.getString("PER_AVG_RATE"));
				}
				hshRecord.put("strGoldRate", strGoldRate);
				hshRecord.put("strAvgRate", strAvgRate);
			}
		}
		catch (Exception e1)
		{
			throw new EJBException(e1.getMessage());
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
				throw new EJBException("Error in closing Connection " + e.getMessage());
			}
		}
		return hshRecord;
	}
	private HashMap getRentInsuranceCalculation(HashMap hshRecord) 
	{
		ResultSet rs=null;
		double dblEstAmount=0.00;
		double dblPerQuart=0.00;
		double dblCharge=0.00;
		double dblRentInsureVal=0.00;
		int dblHolidayPeriod=0;
		int dblLoanPeriod=0;
		int dblFinalLoanPeriod=0;
		String strQuery="", strPrdCode="", strAppno="";
		try
		{
			strPrdCode=Helper.correctNull((String)hshRecord.get("prdcode"));
			strAppno=Helper.correctNull((String)hshRecord.get("appno"));
			dblEstAmount=Double.parseDouble(Helper.correctDouble((String)hshRecord.get("dbESTRATE1")));
			strQuery = SQLParser.getSqlQuery("selrentinsurance^"+strPrdCode+"^"+dblEstAmount);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				dblCharge=Double.parseDouble(Helper.correctDouble((String)rs.getString("richrg_chrgcollect1")));
				dblPerQuart=Double.parseDouble(Helper.correctDouble((String)rs.getString("richrg_chrgcollect2")));
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("selloanterms^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				dblLoanPeriod=Integer.parseInt(Helper.correctInt((String)rs.getString("loan_reqterms")));
				dblHolidayPeriod=Integer.parseInt(Helper.correctInt((String)rs.getString("loan_noofinstallment")));
				dblFinalLoanPeriod=dblLoanPeriod-dblHolidayPeriod;
			}
			if(dblPerQuart!=0.00)
			{
				dblRentInsureVal=(dblEstAmount/dblPerQuart)*dblCharge*(dblFinalLoanPeriod/4.0);
			}
			hshRecord.put("dblRentInsureVal",Helper.formatDoubleValue(dblRentInsureVal));
		}
		catch (Exception e1)
		{
			throw new EJBException(e1.getMessage());
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
				throw new EJBException("Error in closing Connection " + e.getMessage());
			}
		}
		return hshRecord;
	}
	private HashMap getJewelAppraisalCalculation(HashMap hshRecord) 
	{
		ResultSet rs=null;
		double dblEstAmount=0.00;
		double dblPercent=0.00;
		double dblMinActualCharge=0.00;
		double dblMaxActualCharge=0.00;
		double dblStaticVal=0.00;
		double dblJewelAppraisal=0.00;
		double dblTemp=0.00;
		double dblRangeFrom=0.00;
		String strQuery="", strPrdCode="", strAppno="";
		try
		{
			strPrdCode=Helper.correctNull((String)hshRecord.get("prdcode"));
			strAppno=Helper.correctNull((String)hshRecord.get("appno"));
			dblEstAmount=Double.parseDouble(Helper.correctDouble((String)hshRecord.get("strRecmdAmt")));
			strQuery = SQLParser.getSqlQuery("seljewelappraisal^"+strPrdCode+"^"+dblEstAmount);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				dblPercent=Double.parseDouble(Helper.correctDouble((String)rs.getString("jachrg_percentchrg")));
				dblMinActualCharge=Double.parseDouble(Helper.correctDouble((String)rs.getString("jachrg_minactualchrg")));
				dblMaxActualCharge=Double.parseDouble(Helper.correctDouble((String)rs.getString("jachrg_maxactualchrg")));
				dblStaticVal=Double.parseDouble(Helper.correctDouble((String)rs.getString("jachrg_staticval")));
				dblRangeFrom=Double.parseDouble(Helper.correctDouble((String)rs.getString("jachrg_rangefrom")));
			}
			dblTemp=dblEstAmount-dblRangeFrom+1;
			dblJewelAppraisal=dblStaticVal+((dblPercent*dblTemp)/100.0);
			if(dblJewelAppraisal<dblMinActualCharge)
			{
				dblJewelAppraisal=dblMinActualCharge;
			}
			else if(dblJewelAppraisal>dblMaxActualCharge)
			{
				dblJewelAppraisal=dblMaxActualCharge;
			}
			hshRecord.put("dblJewelAppraisal",Helper.formatDoubleValue(dblJewelAppraisal));
		}
		catch (Exception e1)
		{
			throw new EJBException(e1.getMessage());
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
				throw new EJBException("Error in closing Connection " + e.getMessage());
			}
		}
		return hshRecord;
	}
	public static void updateSecurityValue(String strAppNo, double dblTotalRate) 
	{
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs=null;
		String strQuery="";
		double dblDownPay=0.00, dblMarginByBorrower=0.00, dblMarginPerc=0.00, dblAmountReq=0.00;
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_margindetails^"+strAppNo);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				dblMarginPerc=rs.getDouble("loan_margin");
				dblAmountReq=rs.getDouble("loan_amtreqd");
			}
			if(rs!=null)
			{
				rs.close();
			}
			dblDownPay=(dblAmountReq*dblMarginPerc)/100.0;
			dblMarginByBorrower=dblTotalRate-dblAmountReq;
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId", "upd_loandetailsmargin");
			arrValues.add(jtn.format(dblTotalRate));
			arrValues.add(jtn.format(dblDownPay));
			arrValues.add(jtn.format(dblMarginByBorrower));
			arrValues.add(strAppNo);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updateSecurityValue " + e.getMessage());
		}
		
	}
	//Added by Arsath on 01/08/2013 for Gold Appraiser Details
	public void updateGoldAppraiserdet(HashMap hshValues) 
	{
		ResultSet rs = null;		
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues1 = new ArrayList();
		ArrayList arrValues = new ArrayList();
		String strQuery="";
		String strsno = "";
		String strAppno = "";
		StringBuilder sbolddata=new StringBuilder();
		String strSecId="";
		String noOfCustomers="1";
		HashMap hshQuery = new HashMap();
		HashMap hshRecord = new HashMap();
		boolean boolStatus=false;		
		try
		{
			String strAppraiserName = Helper.correctNull((String) hshValues.get("txt_appraisername"));
			String strAppraisedon = Helper.correctNull((String) hshValues.get("txt_appraisedon"));
			String strComments= Helper.correctNull((String) hshValues.get("txt_comments"));
			String strAction = Helper.correctNull((String) hshValues.get("hidAction"));
			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno = Helper.correctNull((String) hshValues.get("strappno"));
			}			
			if (strAction.equals("insert"))
			{
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_appraiserdet");
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_appraiserdet");
				arrValues.add(strAppno);
				arrValues.add(strAppraiserName);
				arrValues.add(strAppraisedon);			
				arrValues.add(strComments);			
				arrValues.add(Helper.correctNull((String)hshValues.get("hidAppraiserID")));			
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);			
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}		
			else if (strAction.equalsIgnoreCase("Delete"))
			{
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_appraiserdet");
				arrValues1.add(strAppno);
				hshQuery.put("arrValues", arrValues1);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
			hshRecord.put("hidSecurityId",strSecId);
			hshRecord.put("hidAction",strAction);

			
			//---------------------------------------Audittrial------------------------//
			StringBuilder sbAuditTrial = new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("Delete"))
			{
			sbAuditTrial.append(
			"~Appraiser Name =").append(correctNull((String )hshValues.get("txt_appraisername"))).append(
			"~Appraised On =").append(correctNull((String )hshValues.get("txt_appraisedon"))).append(
			"~Comments =").append(correctNull((String )hshValues.get("txt_comments")));
			}
			AuditTrial.auditNewLog(hshValues,"87",strAppno,sbAuditTrial.toString(),sbolddata.toString());
			
			//-------------------------------------------End---------------------------//
			
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updategolddetails " + e.getMessage());
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
				throw new EJBException("Error in closing Connection " + e.getMessage());
			}
		}

	}
	
	
	public HashMap getGoldAppraiserdet(HashMap hshValues) 
	{
		ResultSet rs = null;		
		HashMap hshResult = new HashMap();      
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;		
		String strApplicationNo="";
		String strQuery="";
		String strApptype="";
		String strOrgCode = "";
		String strDemoappId="";
		try
		{
			strApplicationNo = correctNull((String)hshValues.get("appno"));
			if (strApplicationNo.equalsIgnoreCase(""))
			{
				strApplicationNo = correctNull((String)hshValues.get("strappno"));		
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_appraiserdet^"+strApplicationNo);				
			rs = DBUtils.executeQuery(strQuery);				
			if (rs.next())
			{
				hshResult.put("ja_name",Helper.correctNull((String)rs.getString("ja_name")));
				hshResult.put("ja_appraiseon",Helper.correctNull((String)rs.getString("ja_appraiseon")));
				hshResult.put("ja_comments",Helper.CLOBToString((rs.getClob("ja_comments"))));
				hshResult.put("ja_appraisercbsid",Helper.correctNull(rs.getString("ja_appraisercbsid")));
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_perappid^"+strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);	
			if(rs.next())
			{
				strDemoappId=correctNull(rs.getString("DEMO_APPID"));
				
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_perappintrocbsid12^"+strDemoappId);				
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshResult.put("ja_percbsid",Helper.correctNull((String)rs.getString("PERAPP_INTROCBSID")));
				hshResult.put("ja_perfname",Helper.correctNull((String)rs.getString("NameofApp")));
			}
			
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
				throw new EJBException("Error in closing Connection " + e.getMessage());
			}
		}
		return hshResult;
	}
	public HashMap getGoldReAppraiserdet(HashMap hshValues) 
	{
		ResultSet rs = null;		
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;		
		String strApplicationNo="";
		String strQuery="";
		String strApptype="";
		String strOrgCode = "";
		String strGoldRate="";
		ArrayList ArrRow = new ArrayList();
		ArrayList ArrCol = new ArrayList();
		String date="";
		String appraisal="";
		ResultSet rs1 = null;
		String appraisall="";
		String userid=Helper.correctNull((String)hshValues.get("strUserId"));
		String orgcode="";
		String orgcode1="";
		String appraisername=Helper.correctNull((String)hshValues.get("appraisername"));
		String cbsid=Helper.correctNull((String)hshValues.get("txt_appraisernameid"));
		try
		{
			strApplicationNo = correctNull((String)hshValues.get("appno"));
			
			
			if (strApplicationNo.equalsIgnoreCase(""))
			{
				strApplicationNo = correctNull((String)hshValues.get("strappno"));		
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_appraiserdet^"+strApplicationNo);				
			rs = DBUtils.executeQuery(strQuery);				
			if (rs.next())
			{
				hshValues.put("ja_name",Helper.correctNull(rs.getString("ja_name")));
				hshValues.put("ja_appraiseon",Helper.correctNull(rs.getString("ja_appraiseon")));
				hshValues.put("ja_comments",Helper.CLOBToString((rs.getClob("ja_comments"))));
				hshValues.put("ja_appraisercbsid",Helper.correctNull(rs.getString("ja_appraisercbsid")));
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_Gold_rEApprasial^"+strApplicationNo);				
			rs = DBUtils.executeQuery(strQuery);				
			while (rs.next())
			{
				ArrCol = new ArrayList();
				ArrCol.add(Helper.correctNull(rs.getString("GOLD_SLNO")));
				ArrCol.add(Helper.correctNull(rs.getString("GOLD_DESC")));
				ArrCol.add(Helper.correctNull(rs.getString("GOLD_QUANTITY")));
				ArrCol.add(Helper.correctNull(rs.getString("GOLD_GROSSWEIGHT")));
				ArrCol.add(Helper.correctNull(rs.getString("GOLD_NETWEIGHT")));
		        ArrCol.add(Helper.correctNull(rs.getString("GOLD_CURRMARVAL")));
				ArrCol.add(Helper.CLOBToString(rs.getClob("GOLD_REMARKS")));
				ArrRow.add(ArrCol);
				hshValues.put("GOLD_REAPRNAME", Helper.correctNull(rs.getString("GOLD_REAPRNAME")));
				hshValues.put("GOLD_REAPPDATE", Helper.correctNull(rs.getString("GOLD_REAPPDATE")));
				hshValues.put("GOLD_REAPPBY", Helper.correctNull(rs.getString("GOLD_REAPPBY")));
				hshValues.put("GOLD_USERID", Helper.correctNull(rs.getString("GOLD_USERID")));
				hshValues.put("GOLD_REAPRCUSTID", Helper.correctNull(rs.getString("GOLD_REAPRCUSTID")));
				hshValues.put("STATUS", Helper.correctNull(rs.getString("STATUS")));
				hshValues.put("REASON_FOR_REJECT", Helper.correctNull(rs.getString("REASON_FOR_REJECT")));
				
			}
			hshValues.put("ArrRow", ArrRow);
			
			if(ArrRow.size()==0)
			{
				strQuery = SQLParser.getSqlQuery("selgoldratevalue");
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strGoldRate=Helper.correctDouble((String)rs.getString("PER_GOLDRATE"));
				}
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_GoldRate_value_alreadyappoved^"+strApplicationNo);				
				rs = DBUtils.executeQuery(strQuery);				
				while (rs.next())
				{
					ArrCol = new ArrayList();
					ArrCol.add(Helper.correctNull(rs.getString("AGR_ARTNO")));
					ArrCol.add(Helper.correctNull(rs.getString("AGR_ARTDESC")));
					ArrCol.add(Helper.correctNull(rs.getString("AGR_QUANTITY")));
					ArrCol.add(Helper.correctNull(rs.getString("AGR_ARTGROSSWT")));
					ArrCol.add(Helper.correctNull(rs.getString("AGR_ARTNETWT")));
					
					if(date!="")
					{
						ArrCol.add(appraisall);
					}
					else
					{
						ArrCol.add(strGoldRate);	
					}
					
					ArrCol.add("");
					ArrRow.add(ArrCol);
				}
				hshValues.put("ArrRow", ArrRow);
				if(rs!=null)
				{
					rs.close();
				}
			}
			strQuery=SQLParser.getSqlQuery("selloanagainstparams^P006");
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshValues.put("GOLD_MAKER", Helper.correctNull(rs.getString("LOAN_PARAMVAL")));
				hshValues.put("GOLD_CHEKER", Helper.correctNull(rs.getString("LOAN_PARAMVAL1")));
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("getorgcodefromuser^"+userid);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				orgcode=Helper.correctDouble((String)rs.getString("ORG_SCODE"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("checkuserid^"+strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				orgcode1=Helper.correctDouble((String)rs.getString("ORG_SCODE"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			if(orgcode.equalsIgnoreCase(orgcode1))
			{
				hshValues.put("checkid","Y");
			}
			else
			{
				hshValues.put("checkid","N");
			}
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
				if (rs1 != null)
				{
					rs1.close();
				}
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection " + e.getMessage());
			}
		}
		return hshValues;
	}
	
	//@SuppressWarnings("unchecked")
	public HashMap getgoldpenddingreapp(HashMap hshValues) 
	{
		String strQuery ="";
		ResultSet rs= null;
		ResultSet rs1= null;
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol= null;
		String userid=Helper.correctNull((String)hshValues.get("strUserId"));
		String fromdate=Helper.correctNull((String)hshValues.get("fromdate"));
		String todate=Helper.correctNull((String)hshValues.get("todate"));
		String orgcode="";
		
		  try {
				strQuery=SQLParser.getSqlQuery("getorgcodefromuser^"+userid);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					orgcode=Helper.correctDouble((String)rs.getString("ORG_SCODE"));
				}
           try {
				    
				    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
				    SimpleDateFormat sdf2 = new SimpleDateFormat("dd-MMM-yyyy");
				    fromdate=sdf2.format(sdf.parse(fromdate));
				} catch (Exception e) {
				    e.printStackTrace();

				}
           try {
				    
				    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
				    SimpleDateFormat sdf2 = new SimpleDateFormat("dd-MMM-yyyy");
				    todate=sdf2.format(sdf.parse(todate));
				} catch (Exception e) {
				    e.printStackTrace();

				}
				strQuery=SQLParser.getSqlQuery("getpenddingreapp^"+fromdate+"^"+todate+"^"+orgcode);
				rs1=DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					String dateformate="";
					arrCol=new ArrayList();
					
					arrCol.add(Helper.correctNull((String)rs1.getString("Proposal_Number")));
					arrCol.add(Helper.correctNull((String)rs1.getString("Borrower_Name")));
					arrCol.add(Helper.correctNull((String)rs1.getString("Account_Number")));
					//arrCol.add(Helper.correctNull((String)rs1.getString("Date_of_Reappraisal")));
					dateformate=Helper.correctDouble((String)rs1.getString("Date_of_Reappraisal"));
					 try {
						    
						    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						    SimpleDateFormat sdf2 = new SimpleDateFormat("dd/MM/yyyy");
						    dateformate=sdf2.format(sdf.parse(dateformate));
						} catch (Exception e) {
						    e.printStackTrace();

						}
						arrCol.add(dateformate);
						arrCol.add(Helper.correctNull((String)rs1.getString("Entered_userid")));
					arrRow.add(arrCol);
					
				}
				hshValues.put("arrRow", arrRow);
				
				if(rs!=null)
				{
					rs.close();
				}
				if(rs1!=null)
				{
					rs1.close();
				}
	     }
	     catch(Exception m) {
	         System.out.println("Error in  getgoldpenddingreapp Method : "+m);
	     }
		return hshValues;
	}
	public HashMap getgoldpenddingreappforreport(HashMap hshValues) 
	{
		String strQuery ="";
		ResultSet rs= null;
		ResultSet rs1= null;
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol= null;
		String userid=Helper.correctNull((String)hshValues.get("strUserId"));
		String fromdate=Helper.correctNull((String)hshValues.get("fromdate"));
		String todate=Helper.correctNull((String)hshValues.get("todate"));
		String cbsid=Helper.correctNull((String)hshValues.get("cbsid"));
		//String cbsid="542025759";
		String orgcode="";
		int slno=0;
		
		  try {
				strQuery=SQLParser.getSqlQuery("getorgcodefromuser^"+userid);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					orgcode=Helper.correctDouble((String)rs.getString("ORG_SCODE"));
					//orgcode="513";
				}
           try {
				    
				    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
				    SimpleDateFormat sdf2 = new SimpleDateFormat("dd-MMM-yyyy");
				    fromdate=sdf2.format(sdf.parse(fromdate));
				} catch (Exception e) {
				    e.printStackTrace();

				}
           try {
				    
				    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
				    SimpleDateFormat sdf2 = new SimpleDateFormat("dd-MMM-yyyy");
				    todate=sdf2.format(sdf.parse(todate));
				} catch (Exception e) {
				    e.printStackTrace();

				}
				strQuery=SQLParser.getSqlQuery("getpenddingreappforgoldornaments^"+fromdate+"^"+todate+"^"+orgcode+"^"+cbsid);
				rs1=DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					int k=++slno;
					String s=Integer.toString(k);
					String dateformate="";
					arrCol=new ArrayList();
					arrCol.add(s);
					arrCol.add(Helper.correctNull((String)rs1.getString("Party_Name")));
					
					arrCol.add(Helper.correctNull((String)rs1.getString("Account_Number")));
					
					arrCol.add(Helper.correctNull((String)rs1.getString("Total_Gross_Weight")));
					
					arrCol.add(Helper.correctNull((String)rs1.getString("Total_Net_Weight")));
					
					dateformate=Helper.correctDouble((String)rs1.getString("Date_of_Reappraisal"));
					 try {
						    
					    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					    SimpleDateFormat sdf2 = new SimpleDateFormat("dd/MM/yyyy");
						    dateformate=sdf2.format(sdf.parse(dateformate));
						} catch (Exception e) {
						    e.printStackTrace();
					
						}
					
						arrCol.add(dateformate);
						arrCol.add("");
					arrRow.add(arrCol);
				}
				hshValues.put("arrRow", arrRow);
				if(rs!=null)
				{
					rs.close();
				}
				if(rs1!=null)
				{
					rs1.close();
				}
	     }
	     catch(Exception m) {
	         System.out.println("Error in  getgoldpenddingreappforreport Method : "+m);
	     }
		return hshValues;
	}
	public void updateGoldReAppraiserdet(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strsno = "";
		String strAppno = "";
		StringBuilder sbolddata=new StringBuilder();
		HashMap hshQuery = new HashMap();
		HashMap hshRecord = new HashMap();
		String remarks="";
		String strQuery="";
		String cbsid="";
		boolean boolStatus=false;	
		ResultSet rs = null;
		String appraisal="";
		ResultSet rs1= null;
		String appraisall="";
		String deluserid="";
		try
		{
			String[] AppraisalId=null;
			String[] AppraisalDesc=null;
			String[] AppraisalGross=null;
			String[] AppraisalNet=null;
			String[] AppraisalRate=null;
			String[] AppraisalComments=null;
			String[] AppraisalQuantity=null;
			
			if(hshValues.get("appraisal_id") instanceof String[])
			{
				AppraisalId= ((String[]) hshValues.get("appraisal_id"));		
			}else
			{
				AppraisalId=new String[1];
				AppraisalId[0]= ((String) hshValues.get("appraisal_id"));
			}
			if(hshValues.get("appraisal_desc") instanceof String[])
			{
				AppraisalDesc= ((String[]) hshValues.get("appraisal_desc"));		
			}else
			{
				AppraisalDesc=new String[1];
				AppraisalDesc[0]= ((String) hshValues.get("appraisal_desc"));
			}
			if(hshValues.get("appraisal_quantity") instanceof String[])
			{
				AppraisalQuantity= ((String[]) hshValues.get("appraisal_quantity"));		
			}else
			{
				AppraisalQuantity=new String[1];
				AppraisalQuantity[0]= ((String) hshValues.get("appraisal_quantity"));
			}
			if(hshValues.get("appraisal_grs") instanceof String[])
			{
				AppraisalGross= ((String[]) hshValues.get("appraisal_grs"));		
			}else
			{
				AppraisalGross=new String[1];
				AppraisalGross[0]= ((String) hshValues.get("appraisal_grs"));
			}
			if(hshValues.get("appraisal_nth") instanceof String[])
			{
				AppraisalNet= ((String[]) hshValues.get("appraisal_nth"));		
			}else
			{
				AppraisalNet=new String[1];
				AppraisalNet[0]= ((String) hshValues.get("appraisal_nth"));
			}
			if(hshValues.get("appraisal_rate") instanceof String[])
			{
				AppraisalRate= ((String[]) hshValues.get("appraisal_rate"));		
			}else
			{
				AppraisalRate=new String[1];
				AppraisalRate[0]= ((String) hshValues.get("appraisal_rate"));
			}
			if(hshValues.get("txt_comments") instanceof String[])
			{
				AppraisalComments= ((String[]) hshValues.get("txt_comments"));		
			}else
			{
				AppraisalComments=new String[1];
				AppraisalComments[0]= ((String) hshValues.get("txt_comments"));
			}
			
			
			String strAction = Helper.correctNull((String) hshValues.get("hidAction"));
			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			String appraisername = Helper.correctNull((String) hshValues.get("txt_appraisername"));
			String appraisedon = Helper.correctNull((String) hshValues.get("txt_appraisedon"));
			String strUserId = Helper.correctNull((String) hshValues.get("strUserId"));
			String strOrgShortCode = Helper.correctNull((String) hshValues.get("strOrgShortCode"));
			remarks = Helper.correctNull((String) hshValues.get("remarks"));
			cbsid=Helper.correctNull((String) hshValues.get("txt_appraisernameid"));
			String date =Helper.correctNull((String) hshValues.get("txt_appraisedon"));
			
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno = Helper.correctNull((String) hshValues.get("strappno"));
			}	
			if(strAction.equalsIgnoreCase("insert"))
			{
				if(date!="")
				{
					
					try {
					    
					    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
					    SimpleDateFormat sdf2 = new SimpleDateFormat("dd-MMM-yyyy");
					    appraisal=sdf2.format(sdf.parse(date));
					} catch (Exception e) {
					    e.printStackTrace();

					}
					strQuery=SQLParser.getSqlQuery("currentgoldrate^"+appraisal);
					rs1 = DBUtils.executeQuery(strQuery);
					if (rs1.next())
					{
						appraisall    =(Helper.correctNull(rs1.getString("PER_GOLDRATE")));	
					}
					
				}
			}
			
			if (strAction.equalsIgnoreCase("insert")||strAction.equalsIgnoreCase("Delete"))
			{
				strQuery=SQLParser.getSqlQuery("selectgoldpreviousdata^"+strAppno);
				rs = DBUtils.executeQuery(strQuery);
			     while(rs.next())
				{
			    	 deluserid=Helper.correctNull(rs.getString("GOLD_USERID"));
			    	 if(!deluserid.equalsIgnoreCase(strUserId))
			    	 {
			    		    hshQueryValues.put("size", "1");
							hshQuery.put("strQueryId", "insdeluserid_goldREAPPRISAL_HISTORY");
							arrValues = new ArrayList();
							arrValues.add(Helper.correctNull(rs.getString("GOLD_APPNO")));
							arrValues.add(Helper.correctNull(rs.getString("GOLD_SLNO")));
							arrValues.add(Helper.correctNull(rs.getString("GOLD_DESC")));
							arrValues.add(Helper.correctNull(rs.getString("GOLD_QUANTITY")));
							arrValues.add(Helper.correctNull(rs.getString("GOLD_CURRMARVAL")));
							arrValues.add(Helper.CLOBToString(rs.getClob("GOLD_REMARKS")));
							arrValues.add(Helper.correctNull(rs.getString("GOLD_REAPRNAME")));
							arrValues.add(Helper.correctNull(rs.getString("GOLD_REAPPDATE")));
							arrValues.add(strOrgShortCode);
							arrValues.add(Helper.correctNull(rs.getString("GOLD_USERID")));
							arrValues.add(Helper.correctNull(rs.getString("GOLD_REAPRCUSTID")));
							arrValues.add(strUserId);
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData"); 
					
			    	 }
			    	 else if(strAction.equalsIgnoreCase("insert"))
			    	 {
			    		    hshQueryValues.put("size", "1");
							hshQuery.put("strQueryId", "ins_goldREAPPRISAL_HISTORY");
							arrValues = new ArrayList();
							arrValues.add(Helper.correctNull(rs.getString("GOLD_APPNO")));
							arrValues.add(Helper.correctNull(rs.getString("GOLD_SLNO")));
							arrValues.add(Helper.correctNull(rs.getString("GOLD_DESC")));
							arrValues.add(Helper.correctNull(rs.getString("GOLD_QUANTITY")));
							arrValues.add(Helper.correctNull(rs.getString("GOLD_CURRMARVAL")));
							arrValues.add(Helper.CLOBToString(rs.getClob("GOLD_REMARKS")));
							arrValues.add(Helper.correctNull(rs.getString("GOLD_REAPRNAME")));
							arrValues.add(Helper.correctNull(rs.getString("GOLD_REAPPDATE")));
							arrValues.add(strOrgShortCode);
							arrValues.add(Helper.correctNull(rs.getString("GOLD_USERID")));
							arrValues.add(Helper.correctNull(rs.getString("GOLD_REAPRCUSTID")));
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			    	 }
			    	 
				}
			}
			if (strAction.equals("insert"))
			{
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_Gold_rEApprasial");
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
				int TotalNo = AppraisalId.length;
				for(int j=0;j<TotalNo;j++)
				{
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "ins_Gold_rEApprasial");
					
					arrValues.add(strAppno);
					arrValues.add(AppraisalId[j]);
					arrValues.add(AppraisalDesc[j]);
					arrValues.add(AppraisalQuantity[j]);
					arrValues.add(AppraisalGross[j]);
					arrValues.add(AppraisalNet[j]);
					arrValues.add(appraisall);
					arrValues.add(AppraisalComments[j]);
					arrValues.add(appraisername);
					
					arrValues.add(appraisedon);
					arrValues.add(strUserId);
					arrValues.add("op");
					arrValues.add(cbsid);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);			
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				}
			}		
			else if (strAction.equalsIgnoreCase("approve"))
			{
				//hshQueryValues = new HashMap();
				//hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "upd_GOLD_REAPPRISAL_appno");
				arrValues = new ArrayList();
				arrValues.add(strUserId);
				arrValues.add("pa");
				arrValues.add(strAppno);
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
			else if (strAction.equalsIgnoreCase("Delete"))
			{
				//hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_Gold_rEApprasial");
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
			else if (strAction.equalsIgnoreCase("reject"))
			{
				//hshQueryValues = new HashMap();
				//hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "upd_GOLD_REAPPRISAL_appno_for_reject");
				arrValues = new ArrayList();
				arrValues.add(strUserId);
				arrValues.add("pr");
				arrValues.add(remarks);
				arrValues.add(strAppno);
				
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
			
			
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updategolddetails " + e.getMessage());
		}
		finally
		{
			try
			{
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection " + e.getMessage());
			}
		}
	}
	
	public HashMap getcertificateforpa(HashMap hshValues) 
	{
		String strQuery ="";
		ResultSet rs= null;
		ResultSet rs1= null;
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol= null;
		String appno=Helper.correctNull((String)hshValues.get("appno"));
		String appraname=Helper.correctNull((String)hshValues.get("appraname"));
		String branchname="";
		int slno=0;
		
		  try {
				
				strQuery=SQLParser.getSqlQuery("getcertificatereportforpa^"+appno);
				rs1=DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					
				
					
					String dateformate="";
					arrCol=new ArrayList();
					
					arrCol.add(Helper.correctNull((String)rs1.getString("SL_NO")));
					
					arrCol.add(Helper.correctNull((String)rs1.getString("DESCRIPTION_OF_GOLD_ORNAMENTS")));
					arrCol.add(Helper.correctNull((String)rs1.getString("NO")));
					arrCol.add(Helper.correctNull((String)rs1.getString("GROSS_WEIGHT")));
					
					arrCol.add(Helper.correctNull((String)rs1.getString("NET_WEIGHT")));
					arrCol.add(Helper.correctNull((String)rs1.getString("REMARKS")));
					arrRow.add(arrCol);
					dateformate=Helper.correctDouble((String)rs1.getString("DATE_OF_REAPPRAISAL"));
					branchname=  Helper.correctNull(rs1.getString("BRANCH"));
					
					try {
					    
					    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					    SimpleDateFormat sdf2 = new SimpleDateFormat("dd/MM/yyyy");
						    dateformate=sdf2.format(sdf.parse(dateformate));
						} catch (Exception e) {
						    e.printStackTrace();
					
						}
					hshValues.put("DATE_OF_REAPPRAISAL",dateformate);
					hshValues.put("PARTY_NAME", Helper.correctNull(rs1.getString("PARTY_NAME")));
					hshValues.put("ACCOUNT_NUMBER", Helper.correctNull(rs1.getString("ACCOUNT_NUMBER")));
					hshValues.put("TOTAL_QTY", Helper.correctNull(rs1.getString("TOTAL_QTY")));
					hshValues.put("TOTAL_GROSS_WEIGHT", Helper.correctNull(rs1.getString("TOTAL_GROSS_WEIGHT")));
					hshValues.put("TOTAL_NET_WEIGHT", Helper.correctNull(rs1.getString("TOTAL_NET_WEIGHT")));
					
				}
				hshValues.put("appraisername", appraname);
				hshValues.put("arrRow", arrRow);
				
				strQuery=SQLParser.getSqlQuery("selectbranchname^"+branchname);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshValues.put("BRANCH", Helper.correctNull(rs.getString("org_name")));	
				}
				
				if(rs!=null)
				{
					rs.close();
				}
				if(rs1!=null)
				{
					rs1.close();
				}
	     }
	     catch(Exception m) {
	         System.out.println("Error in  getcertificateforpa Method : "+m);
	     }
		return hshValues;
	}
}
