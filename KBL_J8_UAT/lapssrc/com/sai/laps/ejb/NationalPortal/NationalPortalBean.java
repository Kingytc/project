package com.sai.laps.ejb.NationalPortal;

import java.net.ConnectException;
import java.rmi.RemoteException;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Vector;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import com.google.gson.Gson;
import com.sai.laps.ejb.attachphoto.AttachPhotoBean;
import com.sai.laps.ejb.commappmaster.CommAppMasterBean;
import com.sai.laps.ejb.commworkflow.CommWorkflowBean;
import com.sai.laps.ejb.inwardRegister.InwardRegisterBean;
import com.sai.laps.ejb.mastapplicant.MastApplicantBean;
import com.sai.laps.ejb.perapplicant.PerApplicantRemote;
import com.sai.laps.helper.AES_Encryption;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.FileManager;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.HttpConnections;
import com.sai.laps.helper.Logger;
import com.sai.laps.helper.SQLParser;

//import org.apache.tika.io.FilenameUtils;
@Stateless(name = "NationalPortalBean", mappedName = "NationalPortalHome")
@Remote (NationalPortalRemote.class)

public class NationalPortalBean extends BeanAdapter
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public HashMap getNpMailbox(HashMap hshValues) 
	{
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		String strQuery = "",strQuery1 = "";
		String strbranchcode=Helper.correctNull((String)hshValues.get("strOrgShortCode"));
		String strOrgCode=Helper.correctNull((String)hshValues.get("strOrgCode"));
		String strusrid=Helper.correctNull((String)hshValues.get("strUserId"));
		String strsegment=Helper.correctNull((String)hshValues.get("selsegment"));
		String SegType=Helper.correctNull((String)hshValues.get("selsegment"));
		if(strsegment.equalsIgnoreCase(""))
		{
			strsegment=correctNull((String) hshValues.get("sel_nsdlStatus")); 
		}
		String strUser="";
		strUser=Helper.correctNull((String)hshValues.get("strUserId"));
		String status="",apprefid="",IsAuthorized="",authStatus="";
		ArrayList arrCol = new ArrayList();
		
		ArrayList arrRow = new ArrayList();
		try
		{
			String strBranch_code =Helper.correctNull((String)hshValues.get("strOrgCode"));
			String strOrgLevl="",strSearchText="",strSearchRecText="";
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("sel_org_level^"+strBranch_code);
			rs =DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strOrgLevl=Helper.correctNull((String)rs.getString("org_level"));
			}
			
			
			String strZone="",strSuborg="",encryptpan="";
			if(strOrgLevl.equals("C"))
			{
				strSuborg="001%%%%";
			}
			else if(strOrgLevl.equals("R"))
			{
				strSuborg=strBranch_code.substring(0,6);
				strSuborg=strSuborg+"%%%%%%%%%";
			}
			else if(strOrgLevl.equals("D"))
			{
				strSuborg=strBranch_code.substring(0,9);
				strSuborg=strSuborg+"%%%%%%";
			}
			else if(strOrgLevl.equals("A"))
			{
				strSuborg=strBranch_code.substring(0,12);
				strSuborg=strSuborg+"%%%";
			}
			else if(strOrgLevl.equals("B"))
			{
				strSuborg=strBranch_code;
			}
			strSearchRecText = "b.ORG_CODE LIKE '"+strSuborg+"'";
			
			ArrayList arrval = new ArrayList();
			ArrayList arrdata = new ArrayList();
			
			if(strsegment.equalsIgnoreCase("AGRI"))
			{
				strQuery = SQLParser.getSqlQuery("sel_npapplicationdetagri^"+strSuborg+"^"+strSuborg);
			}else 
			if(strsegment.equalsIgnoreCase("HL"))
			{
					strQuery = SQLParser.getSqlQuery("sel_npapplicationdet^"+strSuborg);
			}else 
			if(strsegment.equalsIgnoreCase("LHD"))
			{
					strQuery = SQLParser.getSqlQuery("sel_npapplicationdetlhd^"+strSuborg+"^"+strSuborg);
			}else if(strsegment.equalsIgnoreCase("BS"))
			{
				strQuery = SQLParser.getSqlQuery("sel_npapplicationdetbs^"+strSuborg+"^"+strSuborg+"^"+strSuborg+"^"+strSuborg+"^"+strSuborg);
			} 
			else if(strsegment.equalsIgnoreCase("EDU"))
			{
				System.out.println("Hello-----------");
				strQuery = SQLParser.getSqlQuery("sel_npapplicationdetedu^"+strSuborg);
			} 
			ArrayList arrval1 = new ArrayList();
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				if(!arrval1.contains(correctNull(rs.getString("NPDT_APPLICATIONREFERENCEID"))))
				{
				arrval1.add(correctNull(rs.getString("NPDT_APPLICATIONREFERENCEID")));// APP REFERENCE NO
				arrval = new ArrayList();
				arrval.add(correctNull(rs.getString("NPDT_APPLICATIONREFERENCEID")));// APP REFERENCE NO 0
				arrval.add(correctNull(rs.getString("NPDT_APPLICATIONCODE")));// APPLICATION CODE 1
				arrval.add(correctNull(rs.getString("NPDT_SCHEMEID")));// SCHEME ID 2
				arrval.add(correctNull(rs.getString("NPDT_SCHEMENAME")));// SCHEME NAME 3
				arrval.add(correctNull(rs.getString("NPDT_CREATEDDATETIME")));// APP DATE  4
				if(!strsegment.equalsIgnoreCase("LHD")) 
				{
				arrval.add(correctNull(rs.getString("APPLICANTNAME")));// APPLICANTNAME 5
				}else{
					arrval.add(""); //5
				}
				arrval.add(correctNull(rs.getString("NPDT_APPHOLDER")));//INWARD HOLDER 6
				arrval.add(correctNull(rs.getString("NPDT_INWARDNO")));//INWARD NO 7
		 		arrval.add(correctNull(rs.getString("NPDT_INWSTATUS")));//INWARD STATUS 8
				
				String inwstatus="";
				/*if(rs1 != null){rs1.close();}
				strQuery1 = SQLParser.getSqlQuery("sel_npappinwardregdet^"+correctNull(rs.getString("NPDT_INWARDNO")));
				rs1 = DBUtils.executeQuery(strQuery1);			
				if(rs1.next())
				{			
					inwstatus = Helper.correctNull((String)rs1.getString("inward_brstatus"));	
				}*/
				
				arrval.add(inwstatus);//INWARD LAPS vSTATUS	 9
				/*if(rs1 != null){rs1.close();}
				strQuery1 = SQLParser.getSqlQuery("sel_npdedupemailbxdet^"+correctNull(rs.getString("NPDT_APPLICATIONREFERENCEID")));
				rs1 = DBUtils.executeQuery(strQuery1);			
				if(rs1.next())
				{			
					arrval.add("Y");//DEDUPE STATUS 10
				}
				else
				{
					arrval.add("N");//DEDUPE STATUS 10
				}*/

				arrval.add("");
				arrval.add(correctNull(rs.getString("NPDT_NP_SCHEME_NAME")));//NPDT_NP_SCHEME_NAME	 11
				String strInwardNo="",strAppNoNp="";
				if(!Helper.correctNull(rs.getString("NPDT_INWARDNO")).equalsIgnoreCase(""))
				{
					strInwardNo=Helper.correctNull(rs.getString("NPDT_INWARDNO"));
				}
				if(!Helper.correctNull(rs.getString("NPDT_APPNO")).equalsIgnoreCase(""))
				{
					strAppNoNp=Helper.correctNull(rs.getString("NPDT_APPNO"));
				}
				if(strInwardNo.equalsIgnoreCase("")&&strAppNoNp.equalsIgnoreCase(""))
				{
					arrval.add("-");
				}
				else
				{
					arrval.add(strInwardNo+"/"+strAppNoNp);
				}
				arrdata.add(arrval);
				}
			}
			hshRecord.put("ApplDetails", arrdata);
			
			arrdata = new ArrayList();
		//	strQuery = SQLParser.getSqlQuery("sel_nprcvapplicationdet^"+strbranchcode+"^"+strusrid+"^"+strsegment);
			
			
			if(strsegment.equalsIgnoreCase("AGRI"))
			{
				strQuery = SQLParser.getSqlQuery("sel_npapplicationdetagri^"+strSuborg+"^"+strSuborg);
			}else 
			if(strsegment.equalsIgnoreCase("HL"))
			{
					strQuery = SQLParser.getSqlQuery("sel_npapplicationdet^"+strSuborg);
			}else 
			if(strsegment.equalsIgnoreCase("LHD"))
			{
					strQuery = SQLParser.getSqlQuery("sel_npapplicationdetlhd^"+strSuborg+"^"+strSuborg);
			}else if(strsegment.equalsIgnoreCase("BS"))
			{
				strQuery = SQLParser.getSqlQuery("sel_npapplicationdetbs^"+strSuborg+"^"+strSuborg+"^"+strSuborg+"^"+strSuborg);
			} 
			else if(strsegment.equalsIgnoreCase("EDU"))
			{
				strQuery = SQLParser.getSqlQuery("sel_npapplicationdetedu1^"+strSuborg+"^"+strusrid);
			}
			arrval1 = new ArrayList();
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				if(correctNull(rs.getString("NPDT_APPNO")).equalsIgnoreCase("")){
					if(!correctNull(rs.getString("NPDT_APPHOLDER")).equalsIgnoreCase("")){
						if(!arrval1.contains(correctNull(rs.getString("NPDT_APPLICATIONREFERENCEID"))))
						{
				arrval1.add(correctNull(rs.getString("NPDT_APPLICATIONREFERENCEID")));// APP REFERENCE NO
										
				arrval = new ArrayList();
				arrval.add(correctNull(rs.getString("NPDT_APPLICATIONREFERENCEID")));// APP REFERENCE NO
				arrval.add(correctNull(rs.getString("NPDT_APPLICATIONCODE")));// APPLICATION CODE
				arrval.add(correctNull(rs.getString("NPDT_SCHEMEID")));// SCHEME ID
				arrval.add(correctNull(rs.getString("NPDT_SCHEMENAME")));// SCHEME NAME
				arrval.add(correctNull(rs.getString("NPDT_CREATEDDATETIME")));// APP DATE 
				if(!strsegment.equalsIgnoreCase("LHD"))
				{
				arrval.add(correctNull(rs.getString("APPLICANTNAME")));// APPLICANTNAME 5
				}else{
					arrval.add("");
				}
				arrval.add(correctNull(rs.getString("NPDT_APPHOLDER")));// INWARD HOLDER
				arrval.add(correctNull(rs.getString("NPDT_INWARDNO")));//INWARD NO
				arrval.add(correctNull(rs.getString("NPDT_INWSTATUS")));//INWARD STATUS
				String inwstatus="";
				if(rs1 != null){rs1.close();}
				/*strQuery1 = SQLParser.getSqlQuery("sel_npappinwardregdet^"+correctNull(rs.getString("NPDT_INWARDNO")));
				rs1 = DBUtils.executeQuery(strQuery1);			
				if(rs1.next())
				{			
					inwstatus = Helper.correctNull((String)rs1.getString("inward_brstatus"));	
				}*/
				arrval.add(inwstatus);//INWARD LAPS vSTATUS 9	
				/*if(rs1 != null){rs1.close();}
				strQuery1 = SQLParser.getSqlQuery("sel_npdedupemailbxdet^"+correctNull(rs.getString("NPDT_APPLICATIONREFERENCEID")));
				rs1 = DBUtils.executeQuery(strQuery1);			
				if(rs1.next())
				{			
					arrval.add("Y");//DEDUPE STATUS 10
				}
				else
				{
					arrval.add("N");//DEDUPE STATUS
				}	*/

				arrval.add("");
				arrval.add(correctNull(rs.getString("NPDT_APPNO")));//appno 11
				arrval.add("");
				
				if(Helper.correctNull(rs.getString("NPDT_LAPS_ACCEPTED")).equalsIgnoreCase("105")){
					status="Hold";
				}else if(Helper.correctNull(rs.getString("NPDT_LAPS_ACCEPTED")).equalsIgnoreCase("102")){
					status="Rejection";
				}else if(Helper.correctNull(rs.getString("NPDT_LAPS_ACCEPTED")).equalsIgnoreCase("104") && Helper.correctNull(rs.getString("NPDT_APPLICATIONSTATUS")).equalsIgnoreCase("")){
					status="Rejection";
				}else if(Helper.correctNull(rs.getString("NPDT_LAPS_ACCEPTED")).equalsIgnoreCase("104") && Helper.correctNull(rs.getString("NPDT_APPLICATIONSTATUS")).equalsIgnoreCase("04")){
					status="Rejected";
				}else if(Helper.correctNull(rs.getString("NPDT_LAPS_ACCEPTED")).equalsIgnoreCase("105")){
					status="Hold";
				}
				else{
					status="";
				}
				if(Helper.correctNull(rs.getString("NPDT_APPLICATIONSTATUS")).equalsIgnoreCase("02")){
					status="Sanctioned";
				}else if(Helper.correctNull(rs.getString("NPDT_APPLICATIONSTATUS")).equalsIgnoreCase("03")){
					status="Disbursed";
				}
				arrval.add(status);
				arrval.add(correctNull(rs.getString("NPDT_NP_SCHEME_NAME")));//NPDT_NP_SCHEME_NAME	
				arrdata.add(arrval);
				}
				}
				}
				}
			
				
			hshRecord.put("RcvApplDetails", arrdata);
			hshRecord.put("NPSegment",strsegment);
			hshRecord.put("INWARDNOCR",Helper.correctNull((String)hshValues.get("InwardNo")));
			hshRecord.put("REFERENCEIDCR",Helper.correctNull((String)hshValues.get("REFERENCEID")));
			hshRecord.put("strOrgLevel", strOrgLevl);
			
			
			}
		catch(Exception ex)
		{
			Logger.log("Exception in getNpapplications"+ex);
		}	
	return hshRecord;
	}
	public HashMap getNPStatusUpdate(HashMap hshValues) 
	{
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		HashMap hsh = new HashMap();
		String strQuery = "";
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		HashMap hshQueryValues = new HashMap();
		String strbranchcode=Helper.correctNull((String)hshValues.get("strOrgShortCode"));
		String strusrid=Helper.correctNull((String)hshValues.get("strUserId"));
		String strStatus=Helper.correctNull((String)hshValues.get("hidaction"));
		String strRefno = Helper.correctNull((String)hshValues.get("hidRefId"));
		if(strRefno.equalsIgnoreCase("")){
		strRefno = Helper.correctNull((String)hshValues.get("hidApplicantId"));
		}
		String selsegment = Helper.correctNull((String)hshValues.get("selsegment"));
		String strMethod="";
		try
		{
			strMethod="getNPStatusUpdate";
			System.out.println("--------------In Method: "+strMethod+"-----------");
			if(strStatus.equalsIgnoreCase("Receive"))
			{
				System.out.println("--------------In Method: "+strMethod+" Section: "+strStatus+"-----------");
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_nplarrcvid");
				arrValues.add(strusrid);
				arrValues.add(strRefno);	
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
				System.out.println("--------------In Method: "+strMethod+" Value Inserted-----------");
			}
			if(strStatus.equalsIgnoreCase("Hold"))
			{
				System.out.println("--------------In Method: "+strMethod+" Section: "+strStatus+"-----------");
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_npstatusdet");
				arrValues.add("H");
				arrValues.add(strRefno);	
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
				System.out.println("--------------In Method: "+strMethod+" Value Inserted-----------");
			}
			if(strStatus.equalsIgnoreCase("Reject"))
			{
				System.out.println("--------------In Method: "+strMethod+" Section: "+strStatus+"-----------");
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_npstatusdet");
				arrValues.add("R");
				arrValues.add(strRefno);	
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
				System.out.println("--------------In Method: "+strMethod+" Value Inserted-----------");
			}
			
			invokeProposalStatusAPI(hshValues);
			
			hsh = getNpMailbox(hshValues);
			
		}
		catch(Exception ex)
		{
			System.out.println("--------------In Method: | Exception "+ex.getLocalizedMessage()+"-----------");
			Logger.log("Exception in getNpapplications"+ex);
		}	
		return hsh;
	}
	public HashMap getNPInwardCreation(HashMap hshValues) 
	{
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs3 = null;
		HashMap hshRecord = new HashMap();
		HashMap hsh = new HashMap();
		String strQuery = "",strquery1="";
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		HashMap hshQueryValues = new HashMap();
		String strbranchcode=Helper.correctNull((String)hshValues.get("strOrgShortCode"));
		String strusrid=Helper.correctNull((String)hshValues.get("strUserId"));
		String strStatus=Helper.correctNull((String)hshValues.get("hidaction"));
		String strRefno = Helper.correctNull((String)hshValues.get("hidRefId"));
		
		if(strRefno.equalsIgnoreCase("")){
		strRefno = Helper.correctNull((String)hshValues.get("hidApplicantId"));
		}
		InwardRegisterBean inwardregister = new InwardRegisterBean(); 
		String selsegment=Helper.correctNull((String)hshValues.get("selsegment"));
		try
		{
			String Schemetype="";
			strQuery = SQLParser.getSqlQuery("sel_applicationscheme_np^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				Schemetype=Helper.correctNull((String)rs.getString("NPDT_NP_SCHEME_NAME"));
			}
			

			String strCur_Address="";
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","ins_npinwarddet");	
			String strInqno = inwardregister.getMaxInwardno(strbranchcode);
			arrValues.add(strInqno);
			arrValues.add(strRefno);			
			strQuery = SQLParser.getSqlQuery("sel_nppersonaldetails^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_FIRST_NAME"))+" "
						+Helper.correctNull((String)rs.getString("NPPD_MIDDLE_NAME"))
						+" "+Helper.correctNull((String)rs.getString("NPPD_LAST_NAME")));
				arrValues.add(getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("NPPD_GENDER"))));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_DOB")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_EMAIL")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MOBILE_NUMBER")));
				arrValues.add(getNPtoLAPSListOfValue("6",Helper.correctNull((String)rs.getString("NPPD_EMP_TYPE"))));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_VOTER_NO")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_PAN_NO")));
				strCur_Address = Helper.correctNull((String)rs.getString("NPPD_AADHAR_ADD_SEQ_NO"));
			}
			if(rs != null){rs.close();}
			
			if(!strCur_Address.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+strCur_Address);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT")));
				String district=Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME"));
				//District Code added by kannan
				if(!district.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_District_Name^"+district);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("DISTRICT_CODE")));
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				String city=Helper.correctNull((String)rs.getString("NPAD_CITY_NAME"));
				String state=Helper.correctNull((String)rs.getString("NPAD_STATE_NAME"));
				
				if(!state.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
				
				rs3 = DBUtils.executeQuery(strQuery);	
				
				if(rs3.next())
				{
					arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
					
				}else{
					arrValues.add("");
				}
				}else{
					arrValues.add("");
				}
				String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
				if(!city.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				arrValues.add("IN");
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
			}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("IN");
				arrValues.add("");
			}}else{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("IN");
				arrValues.add("");

			}
			double dblloanamnt=0.00,dblsubsidyamnt=0.00;
			if(rs != null){rs.close();}
			strQuery = SQLParser.getSqlQuery("sel_npprincdet^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				arrValues.add(Helper.correctNull((String)rs.getString("NPID_LOAN_AMT")));
				dblloanamnt = Double.parseDouble(Helper.correctDouble((String)rs.getString("NPID_LOAN_AMT")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPID_TENOR")));	
				dblsubsidyamnt = Double.parseDouble(Helper.correctDouble((String)rs.getString("NPID_SUBSIDY_AMT")));
			}else{
				arrValues.add("");	
				arrValues.add("");	
			}
			
			if(selsegment.equalsIgnoreCase("AGRI")||selsegment.equalsIgnoreCase("LHD"))
			{
				arrValues.add("a");
			}
			else
			{
			    arrValues.add("p");
			}
			arrValues.add(getNPtoLAPSCommonLOV(Helper.correctNull((String)hshValues.get("SchemeName")),
					Helper.correctNull((String)hshValues.get("selsegment")),"PROCESSINGAT"));//to be change
			arrValues.add(strbranchcode);
			arrValues.add(strusrid);
			arrValues.add(strusrid);
			if(rs != null){rs.close();}
			strQuery = SQLParser.getSqlQuery("sel_npcoappdet^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				arrValues.add("1");
			}
			else
			{
				arrValues.add("");
			}
			//UBI Functionality for Branch
			String StrForward="";
			strQuery = SQLParser.getSqlQuery("sel_orghead^"+Helper.correctNull((String)hshValues.get("strOrgCode")) );
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				StrForward = correctNull((String) rs.getString("org_head"));
			}
			if (rs != null) {
				rs.close();
			}
			String StrForwardorg = "";
			if (StrForward != null) 
			{
				strQuery = SQLParser.getSqlQuery("sel_orghead_User^"+StrForward);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					StrForwardorg = correctNull((String)rs.getString("USR_ORGCODE"));
				}		
			}
			arrValues.add(Helper.correctNull((String)hshValues.get("strOrgCode")));//changed
			if(Schemetype.equalsIgnoreCase("")){
			arrValues.add(getNPtoLAPSCommonLOV(Helper.correctNull((String)hshValues.get("SchemeName")),
					Helper.correctNull((String)hshValues.get("selsegment")),"PRODUCTCODE"));
			}else{
				arrValues.add(getNPtoLAPSCommonLOV1(Helper.correctNull((String)hshValues.get("SchemeName")),
						Helper.correctNull((String)hshValues.get("selsegment")),"PRODUCTCODE",Schemetype));
			}
			arrValues.add(strbranchcode);
			arrValues.add(strbranchcode);
			arrValues.add(String.valueOf(dblloanamnt));
			arrValues.add(Helper.correctNull((String)hshValues.get("strOrgbankFlag")));//changed			
			arrValues.add("Y");//constraint issue
			arrValues.add(String.valueOf(dblsubsidyamnt));
			if(Schemetype.equalsIgnoreCase("csis"))
			{
			   arrValues.add("t"); // scheme loan type. 31
			   arrValues.add("006");// bank scheme Name 32
			   arrValues.add("1");
		    }
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}
			MastApplicantBean CustPrfAppID = new MastApplicantBean();
			
			String strAppCode = CustPrfAppID.getApplicantCode();
			
			arrValues.add("");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
			
			String StrOffadd="",strappcoappid="";			
			//Insertion for Employment Details
	 		hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","ins_npempdetails");	
			arrValues.add("0");
			strQuery = SQLParser.getSqlQuery("sel_nppersonaldetails^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_ORG_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MOBILE_NUMBER")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_EMAIL")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_DESIGNATION")));
				arrValues.add("A");
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_RETIRE_AGE")));
				StrOffadd = Helper.correctNull((String)rs.getString("NPPD_CURR_ADD_SEQ_NO"));
				strappcoappid = Helper.correctNull((String)rs.getString("NPPD_APPID"));
			}
			arrValues.add("IN");
			arrValues.add(strInqno);
			arrValues.add("0");
			if(rs != null){rs.close();}
			if(!StrOffadd.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
				//arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT")));
				String district=Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME"));
			
				if(!district.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_District_Name^"+district);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("DISTRICT_CODE")));
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				arrValues.add("");
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_CITY_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STATE_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
			}	
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}
			}else{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");	
			}
			arrValues.add(strappcoappid);
			System.out.println("emp1----------------------"+arrValues);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
			
			//Insertion block for Coapplicant Data
			
			//INSERT INTO APPINWARDREG_COAPP(INWARD_NO,INWARD_SECTOR,INWARD_CREATEDON,INWARD_APPLIEDON,INWARD_BORROWERTYPE
				//	,INWARD_ORGSCODE,INWARD_USRID,INWARD_APPTYPE,
			//INWARD_APPID,INWARD_BANKNAME,INWARD_INCLUDEINCOME,INWARD_MODIFIEDBY, NWARD_MODIFIEDDATE,
			//INWARD_CUSTNAME,INWARD_CUSTLNAME,INWARD_MOBILE,INWARD_EMAIL,INWARD_ADD1,INWARD_ADD2,INWARD_STATE,INWARD_CITY
			//,INWARD_ZIPCODE,INWARD_RELATIONSHIP,
			//INWARD_GENDER,INWARD_DOB,INWARD_EMPLOYMENT)
			//VALUES(?,'p',SYSDATE,SYSDATE,'N',?,?,'1',?,'U','1',?,SYSDATE,?,?,?,?,?,?,?,?,?,?,?,?,?)

			String strsId="",strCur_Add="";
			strQuery = SQLParser.getSqlQuery("sel_npcoappdet^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			while(rs.next())
			{		
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","ins_npcoappdet");	
				arrValues.add(strInqno);
				arrValues.add(strbranchcode);
				arrValues.add(strusrid);
				rs1 = DBUtils.executeLAPSQuery("selmax_cibilcoapp^"+ strInqno);
				if (rs1.next()) {
					strsId = correctNull((String) rs1.getString("inward_appid"));
				} else {
					strsId = "1";
				}
				arrValues.add(strsId);
				arrValues.add(Helper.correctNull((String)hshValues.get("strOrgbankFlag")));//changed
				arrValues.add(strusrid);
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_FNAME"))+" "
								+Helper.correctNull((String)rs.getString("NPCD_MNAME"))
								+" "+Helper.correctNull((String)rs.getString("NPCD_LNAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_LNAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_MOBILE")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_EMAIL")));
				strCur_Add = Helper.correctNull((String)rs.getString("NPCD_AADHAR_ADD_SEQ"));
				
				if(rs1 != null){rs1.close();}
				if(!strCur_Add.equalsIgnoreCase("")){
				strquery1 = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+strCur_Add);
				rs1 = DBUtils.executeQuery(strquery1);			
				if(rs1.next())
				{
					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STREET_NAME"))+" " +
							""+Helper.correctNull((String)rs1.getString("NPAD_LANDMARK")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_SUB_DISTRICT"))+"" + " "+Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME")));
					String district=Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME"));
					//District Code added by kannan
					if(!district.equalsIgnoreCase("")){
						strQuery = SQLParser.getSqlQuery("NP_District_Name^"+district);
						rs3 = DBUtils.executeQuery(strQuery);			
						if(rs3.next())
						{
							arrValues.add(Helper.correctNull((String)rs3.getString("DISTRICT_CODE")));
						}else{
							arrValues.add("");
						}
						}else{
							arrValues.add("");
						}
					String city=Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME"));
					String state=Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME"));
					
					if(!state.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
					String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
					if(!city.equalsIgnoreCase("")){
						strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
						rs3 = DBUtils.executeQuery(strQuery);			
						if(rs3.next())
						{
							arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
						}else{
							arrValues.add("");
						}
						}else{
							arrValues.add("");
						}
					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE")));
				}
				else
				{
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
				}}else{
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
				}
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_RELATION")));
				arrValues.add(getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("NPCD_GENDER"))));
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_DOB")));			
				arrValues.add(getNPtoLAPSListOfValue("6",Helper.correctNull((String)rs.getString("NPCD_EMPLOY_TYPE"))));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
				
				
				//Insertion for Applicant Employment Details
				String stroffadd="";
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","ins_npempdetails");	
				arrValues.add("0");
				strquery1 = SQLParser.getSqlQuery("sel_npcoappdet^"+strRefno);
				rs1 = DBUtils.executeQuery(strquery1);			
				if(rs1.next())
				{
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_ORG_NAME")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_MOBILE")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_EMAIL")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_DESIGNATION")));
					arrValues.add("");
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_RETIRE_AGE")));
					strappcoappid = Helper.correctNull((String)rs1.getString("NPCD_COAPP_ID"));
					stroffadd = Helper.correctNull((String)rs1.getString("NPCD_OFFICE_ADD_SEQ"));
					
				}
				arrValues.add("");
				arrValues.add(strInqno);
				arrValues.add(strsId);
				if(rs1 != null){rs1.close();}
				if(!stroffadd.equalsIgnoreCase("")){
				strquery1 = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+stroffadd);
				rs1 = DBUtils.executeQuery(strquery1);			
				if(rs1.next())
				{
					
					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs1.getString("NPAD_LANDMARK")));
					//arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME")));
					String district=Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME"));
					//District Code added by kannan
					if(!district.equalsIgnoreCase("")){
						strQuery = SQLParser.getSqlQuery("NP_District_Name^"+district);
						rs3 = DBUtils.executeQuery(strQuery);			
						if(rs3.next())
						{
							arrValues.add(Helper.correctNull((String)rs3.getString("DISTRICT_CODE")));
						}else{
							arrValues.add("");
						}
						}else{
							arrValues.add("");
						}
					arrValues.add("");
					String city=Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME"));
					String state=Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME"));
					if(!state.equalsIgnoreCase("")){
						strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
						rs3 = DBUtils.executeQuery(strQuery);			
						if(rs3.next())
						{
							arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
						}else{
							arrValues.add("");
						}
						}else{
							arrValues.add("");
						}
					String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
					if(!city.equalsIgnoreCase("")){
						strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
						rs3 = DBUtils.executeQuery(strQuery);			
						if(rs3.next())
						{
							arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
						}else{
							arrValues.add("");
						}
						}else{
							arrValues.add("");
						}
					
				
					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE")));
				}
				else
				{
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
				}}else{
					
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
				}
				arrValues.add(strappcoappid);
				System.out.println("emp12345----------------------"+arrValues);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
			}
			
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","upd_nppdinwdetails");	
			arrValues.add(strInqno);	
			arrValues.add("P");
			arrValues.add(strRefno);			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
			
			hshValues.put("InwardNo",strInqno);
			hshValues.put("REFERENCEID",strRefno);
			String app_id="0";
			Double grossincome=0.0,otherincome=0.0,incometax=0.0;
			String grossincome1="0",net_monthly_income="0",salary_income="0";
			String house_property="0",other_source="0",capital_gain="0",Taxincome="0";
			 
			strquery1 = SQLParser.getSqlQuery("sel_npFinancial1^"+strRefno);
			rs1 = DBUtils.executeQuery(strquery1);			
			if(rs1.next())
			{
				
				grossincome1=Helper.correctNull((String)rs1.getString("NPFD_GROSS_MONTHLY_INCOME"));
				 net_monthly_income=Helper.correctNull((String)rs1.getString("NPFD_NET_MONTHLY_INCOME"));
				 salary_income=Helper.correctNull((String)rs1.getString("NPFD_SALARY_INCOME"));
				
				 house_property=Helper.correctNull((String)rs1.getString("NPFD_HOUSE_PROPERTY"));
				 other_source=Helper.correctNull((String)rs1.getString("NPFD_OTHER_SOURCE"));
				 capital_gain=Helper.correctNull((String)rs1.getString("NPFD_CAPITAL_GAIN"));
				 app_id=Helper.correctNull((String)rs1.getString("NPFD_ID"));
				 Taxincome=Helper.correctNull((String)rs1.getString("NPFD_TAXABLE_INCOME"));
				 if(!Taxincome.equalsIgnoreCase("")){
				 incometax=Double.valueOf(Taxincome);
				 }
				 if(grossincome1.equalsIgnoreCase("")){
					 grossincome1="0";
				 }
					 if(net_monthly_income.equalsIgnoreCase("")){
						 net_monthly_income="0";
					 }
						 if(salary_income.equalsIgnoreCase("")){
							 salary_income="0";
						 }
				grossincome=Double.valueOf(grossincome1)+Double.valueOf(net_monthly_income)+Double.valueOf(salary_income);
										 
				
				 if(house_property.equalsIgnoreCase("")){
					 house_property="0";
				 }
					 if(other_source.equalsIgnoreCase("")){
						 other_source="0";
					 }
						 if(capital_gain.equalsIgnoreCase("")){
							 capital_gain="0";
						 }
				 otherincome=Double.valueOf(house_property)+Double.valueOf(other_source)+Double.valueOf(capital_gain);
				
			}
			
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","ins_incomeexpene_np");
			arrValues.add(app_id);
			arrValues.add("0");	
			arrValues.add(strInqno);	
			arrValues.add(String.valueOf(grossincome));
			arrValues.add(String.valueOf(otherincome));
			arrValues.add(String.valueOf(incometax));
			System.out.println("income--------"+arrValues);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
			
			hsh = getNpMailbox(hshValues);

			
		}
		catch(Exception ex)
		{
			Logger.log("Exception in getNpapplications"+ex);
		}	
		return hsh;
	}

	public HashMap getNPAgriInwardCreation(HashMap hshValues) 
	{
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs3 = null;
		HashMap hshRecord = new HashMap();
		HashMap hsh = new HashMap();
		String strQuery = "",strquery1="";
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		HashMap hshQueryValues = new HashMap();
		String strbranchcode=Helper.correctNull((String)hshValues.get("strOrgShortCode"));
		String strusrid=Helper.correctNull((String)hshValues.get("strUserId"));
		String strStatus=Helper.correctNull((String)hshValues.get("hidaction"));
		String strRefno = Helper.correctNull((String)hshValues.get("hidRefId"));
		
		if(strRefno.equalsIgnoreCase("")){
		strRefno = Helper.correctNull((String)hshValues.get("hidApplicantId"));
		}
		InwardRegisterBean inwardregister = new InwardRegisterBean(); 
		String selsegment=Helper.correctNull((String)hshValues.get("selsegment"));
		try
		{	
			String Schemetype="";
			strQuery = SQLParser.getSqlQuery("sel_applicationscheme_np^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				Schemetype=Helper.correctNull((String)rs.getString("NPDT_NP_SCHEME_NAME"));
			}
			String strCur_Address="";
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","ins_npinwarddet");	
			String strInqno = inwardregister.getMaxInwardno(strbranchcode);
			arrValues.add(strInqno);
			arrValues.add(strRefno);			
			strQuery = SQLParser.getSqlQuery("sel_nppersonaldetails^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_FIRST_NAME"))+" "
						+Helper.correctNull((String)rs.getString("NPPD_MIDDLE_NAME"))
						+" "+Helper.correctNull((String)rs.getString("NPPD_LAST_NAME")));
				arrValues.add(getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("NPPD_GENDER"))));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_DOB")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_EMAIL")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MOBILE_NUMBER")));
				arrValues.add(getNPtoLAPSListOfValue("6",Helper.correctNull((String)rs.getString("NPPD_EMP_TYPE"))));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_VOTER_NO")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_PAN_NO")));
				strCur_Address = Helper.correctNull((String)rs.getString("NPPD_AADHAR_ADD_SEQ_NO"));
			}else{
			strQuery = SQLParser.getSqlQuery("getAgriPersonalDetails^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
			arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_FIRST_NAME"))+" "
					+Helper.correctNull((String)rs.getString("NPAAPD_MIDDLE_NAME"))
					+" "+Helper.correctNull((String)rs.getString("NPAAPD_LAST_NAME")));
			
			arrValues.add(getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("NPAAPD_GENDER"))));
			arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_DATE_OF_BIRTH")));
			arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_EMAIL")));
			arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_MOBILE")));
			arrValues.add("");
			arrValues.add("");
			arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_PAN")));
			strCur_Address = Helper.correctNull((String)rs.getString("NPAAPD_AADHAR_ADD_SEQ_NO"));
			}
			}
			if(rs != null){rs.close();}
			
			if(!strCur_Address.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+strCur_Address);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT")));
				String district=Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME"));
				//District Code added by kannan
				if(!district.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_District_Name^"+district);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("DISTRICT_CODE")));
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				String city=Helper.correctNull((String)rs.getString("NPAD_CITY_NAME"));
				String state=Helper.correctNull((String)rs.getString("NPAD_STATE_NAME"));
				
				if(!state.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
				rs3 = DBUtils.executeQuery(strQuery);			
				if(rs3.next())
				{
					arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
				}else{
					arrValues.add("");
				}
				}else{
					arrValues.add("");
				}
				String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
				if(!city.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				arrValues.add("IN");
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
			}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("IN");
				arrValues.add("");
			}}else{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("IN");
				arrValues.add("");

			}
			double dblloanamnt=0.00,dblsubsidyamnt=0.00;
			if(rs != null){rs.close();}
			strQuery = SQLParser.getSqlQuery("sel_npprincdet^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				arrValues.add(Helper.correctNull((String)rs.getString("NPID_LOAN_AMT")));
				dblloanamnt = Double.parseDouble(Helper.correctDouble((String)rs.getString("NPID_LOAN_AMT")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPID_TENOR")));	
				dblsubsidyamnt = Double.parseDouble(Helper.correctDouble((String)rs.getString("NPID_SUBSIDY_AMT")));
			}else{
				arrValues.add("");	
				arrValues.add("");	
			}
			
			if(selsegment.equalsIgnoreCase("AGRI")||selsegment.equalsIgnoreCase("LHD"))
			{
				arrValues.add("a");
			}
			else
			{
			    arrValues.add("p");
			}
			arrValues.add(getNPtoLAPSCommonLOV(Helper.correctNull((String)hshValues.get("SchemeName")),
					Helper.correctNull((String)hshValues.get("selsegment")),"PROCESSINGAT"));//to be change
			arrValues.add(strbranchcode);
			arrValues.add(strusrid);
			arrValues.add(strusrid);
			if(rs != null){rs.close();}
			strQuery = SQLParser.getSqlQuery("sel_npcoappdet^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				arrValues.add("1");
			}
			else
			{
				arrValues.add("");
			}
			//UBI Functionality for Branch
			String StrForward="";
			strQuery = SQLParser.getSqlQuery("sel_orghead^"+Helper.correctNull((String)hshValues.get("strOrgCode")) );
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				StrForward = correctNull((String) rs.getString("org_head"));
			}
			if (rs != null) {
				rs.close();
			}
			String StrForwardorg = "";
			if (StrForward != null) 
			{
				strQuery = SQLParser.getSqlQuery("sel_orghead_User^"+StrForward);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					StrForwardorg = correctNull((String)rs.getString("USR_ORGCODE"));
				}		
			}
			arrValues.add(Helper.correctNull((String)hshValues.get("strOrgCode")));//changed
			if(Schemetype.equalsIgnoreCase("")){
				arrValues.add(getNPtoLAPSCommonLOV(Helper.correctNull((String)hshValues.get("SchemeName")),
						Helper.correctNull((String)hshValues.get("selsegment")),"PRODUCTCODE"));
				}else{
					arrValues.add(getNPtoLAPSCommonLOV1(Helper.correctNull((String)hshValues.get("SchemeName")),
							Helper.correctNull((String)hshValues.get("selsegment")),"PRODUCTCODE",Schemetype));
				}
			arrValues.add(strbranchcode);
			arrValues.add(strbranchcode);
			arrValues.add(String.valueOf(dblloanamnt));
			arrValues.add(Helper.correctNull((String)hshValues.get("strOrgbankFlag")));//changed			
			arrValues.add("Y");//constraint issue
			arrValues.add(String.valueOf(dblsubsidyamnt));
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
            MastApplicantBean CustPrfAppID = new MastApplicantBean();
			
			String strAppCode = CustPrfAppID.getApplicantCode();
			
			arrValues.add(strAppCode);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
			
			String StrOffadd="",strappcoappid="";			
			//Insertion for Employment Details
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","ins_npempdetails");	
			arrValues.add("0");
			
			
			
			
			
			strQuery = SQLParser.getSqlQuery("sel_nppersonaldetails^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_FIRST_NAME"))+" "
						+Helper.correctNull((String)rs.getString("NPPD_MIDDLE_NAME"))
						+" "+Helper.correctNull((String)rs.getString("NPPD_LAST_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MOBILE_NUMBER")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_EMAIL")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_DESIGNATION")));
				arrValues.add("A");
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_RETIRE_AGE")));
				StrOffadd = Helper.correctNull((String)rs.getString("NPPD_CURR_ADD_SEQ_NO"));
				strappcoappid = Helper.correctNull((String)rs.getString("NPPD_APPID"));
			}else{
			
			strQuery = SQLParser.getSqlQuery("getAgriPersonalDetails^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
			
				arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_FIRST_NAME"))+" "
						+Helper.correctNull((String)rs.getString("NPAAPD_MIDDLE_NAME"))
						+" "+Helper.correctNull((String)rs.getString("NPAAPD_LAST_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_MOBILE")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_EMAIL")));
				arrValues.add("");
				arrValues.add("A");
				arrValues.add("");
				StrOffadd = Helper.correctNull((String)rs.getString("NPAAPD_CURR_ADD_SEQ_NO"));
				strappcoappid = Helper.correctNull((String)rs.getString("NPAAPD_ID"));
			}
			}
			arrValues.add("IN");
			arrValues.add(strInqno);
			arrValues.add("0");
			if(rs != null){rs.close();}
			if(!StrOffadd.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
				//arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME")));
				String district=Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME"));
				
				if(!district.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_District_Name^"+district);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("DISTRICT_CODE")));
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				arrValues.add("");
				
				String city=Helper.correctNull((String)rs.getString("NPAD_CITY_NAME"));
				String state=Helper.correctNull((String)rs.getString("NPAD_STATE_NAME"));
				if(!state.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
				if(!city.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				
			

				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
			}	
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}
			}else{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");	
			}
			arrValues.add(strappcoappid);
			System.out.println("emp1----------------------"+arrValues);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
			
			//Insertion block for Coapplicant Data
			
			String strsId="",strCur_Add="";
			strQuery = SQLParser.getSqlQuery("sel_npcoappdet^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			while(rs.next())
			{		
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","ins_npcoappdet");	
				arrValues.add(strInqno);
				arrValues.add(strbranchcode);
				arrValues.add(strusrid);
				rs1 = DBUtils.executeLAPSQuery("selmax_cibilcoapp^"+ strInqno);
				if (rs1.next()) {
					strsId = correctNull((String) rs1.getString("inward_appid"));
				} else {
					strsId = "1";
				}
				arrValues.add(strsId);
				arrValues.add(Helper.correctNull((String)hshValues.get("strOrgbankFlag")));//changed
				arrValues.add(strusrid);
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_FNAME"))+" "
								+Helper.correctNull((String)rs.getString("NPCD_MNAME"))
								+" "+Helper.correctNull((String)rs.getString("NPCD_LNAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_LNAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_MOBILE")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_EMAIL")));
				strCur_Add = Helper.correctNull((String)rs.getString("NPCD_AADHAR_ADD_SEQ"));
				
				if(rs1 != null){rs1.close();}
				if(!strCur_Add.equalsIgnoreCase("")){
				strquery1 = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+strCur_Add);
				rs1 = DBUtils.executeQuery(strquery1);			
				if(rs1.next())
				{
					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs1.getString("NPAD_LANDMARK")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME")));
					String district=Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME"));
					//District Code added by kannan
					if(!district.equalsIgnoreCase("")){
						strQuery = SQLParser.getSqlQuery("NP_District_Name^"+district);
						rs3 = DBUtils.executeQuery(strQuery);			
						if(rs3.next())
						{
							arrValues.add(Helper.correctNull((String)rs3.getString("DISTRICT_CODE")));
						}else{
							arrValues.add("");
						}
						}else{
							arrValues.add("");
						}
					String city=Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME"));
					String state=Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME"));
					
					if(!state.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
					if(!city.equalsIgnoreCase("")){
						strQuery = SQLParser.getSqlQuery("NP_city_name^"+city);
						rs3 = DBUtils.executeQuery(strQuery);			
						if(rs3.next())
						{
							arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
						}else{
							arrValues.add("");
						}
						}else{
							arrValues.add("");
						}					
					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE")));
				}
				else
				{
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
				}}else{
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
				}
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_RELATION")));
				arrValues.add(getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("NPCD_GENDER"))));
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_DOB")));			
				arrValues.add(getNPtoLAPSListOfValue("6",Helper.correctNull((String)rs.getString("NPCD_EMPLOY_TYPE"))));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
				
				
				//Insertion for Applicant Employment Details
				String stroffadd="";
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","ins_npempdetails");	
				arrValues.add("0");
				strquery1 = SQLParser.getSqlQuery("sel_npcoappdet^"+strRefno);
				rs1 = DBUtils.executeQuery(strquery1);			
				if(rs1.next())
				{
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_ORG_NAME")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_MOBILE")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_EMAIL")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_DESIGNATION")));
					arrValues.add("");
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_RETIRE_AGE")));
					strappcoappid = Helper.correctNull((String)rs1.getString("NPCD_COAPP_ID"));
					stroffadd = Helper.correctNull((String)rs1.getString("NPCD_OFFICE_ADD_SEQ"));
					
				}
				arrValues.add("");
				arrValues.add(strInqno);
				arrValues.add(strsId);
				if(rs1 != null){rs1.close();}
				if(!stroffadd.equalsIgnoreCase("")){
				strquery1 = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+stroffadd);
				rs1 = DBUtils.executeQuery(strquery1);			
				if(rs1.next())
				{
					
					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs1.getString("NPAD_LANDMARK")));
					//arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME")));
					String district=Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME"));
					
					if(!district.equalsIgnoreCase("")){
						strQuery = SQLParser.getSqlQuery("NP_District_Name^"+district);
						rs3 = DBUtils.executeQuery(strQuery);			
						if(rs3.next())
						{
							arrValues.add(Helper.correctNull((String)rs3.getString("DISTRICT_CODE")));
						}else{
							arrValues.add("");
						}
						}else{
							arrValues.add("");
						}
					arrValues.add("");
					String city=Helper.correctNull((String)rs.getString("NPAD_CITY_NAME"));
					String state=Helper.correctNull((String)rs.getString("NPAD_STATE_NAME"));
					if(!state.equalsIgnoreCase("")){
						strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
						rs3 = DBUtils.executeQuery(strQuery);			
						if(rs3.next())
						{
							arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
						}else{
							arrValues.add("");
						}
						}else{
							arrValues.add("");
						}
					String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
					if(!city.equalsIgnoreCase("")){
						strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
						rs3 = DBUtils.executeQuery(strQuery);			
						if(rs3.next())
						{
							arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
						}else{
							arrValues.add("");
						}
						}else{
							arrValues.add("");
						}
					
				

					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE")));
				}
				else
				{
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
				}}else{
					
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
				}
				arrValues.add(strappcoappid);
				System.out.println("emp12345----------------------"+arrValues);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
			}
			
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","upd_nppdinwdetails");	
			arrValues.add(strInqno);	
			arrValues.add("P");
			arrValues.add(strRefno);			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
			
			hshValues.put("InwardNo",strInqno);
			hshValues.put("REFERENCEID",strRefno);
			String app_id="0";
			Double grossincome=0.0,otherincome=0.0,incometax=0.0;
			strquery1 = SQLParser.getSqlQuery("sel_npFinancial1^"+strRefno);
			rs1 = DBUtils.executeQuery(strquery1);			
			if(rs1.next())
			{
				
				String grossincome1="0",net_monthly_income="0",salary_income="0";
				String house_property="0",other_source="0",capital_gain="0";
				 grossincome1=Helper.correctNull((String)rs1.getString("NPFD_GROSS_MONTHLY_INCOME"));
				 net_monthly_income=Helper.correctNull((String)rs1.getString("NPFD_NET_MONTHLY_INCOME"));
				 salary_income=Helper.correctNull((String)rs1.getString("NPFD_SALARY_INCOME"));
				
				 house_property=Helper.correctNull((String)rs1.getString("NPFD_HOUSE_PROPERTY"));
				 other_source=Helper.correctNull((String)rs1.getString("NPFD_OTHER_SOURCE"));
				 capital_gain=Helper.correctNull((String)rs1.getString("NPFD_CAPITAL_GAIN"));
				
				 app_id=Helper.correctNull((String)rs1.getString("NPFD_ID"));
				String Taxincome=Helper.correctNull((String)rs1.getString("NPFD_TAXABLE_INCOME"));
				 
				 if(!Taxincome.equalsIgnoreCase("")){
					 incometax=Double.valueOf(Taxincome);
					 }
					 if(grossincome1.equalsIgnoreCase("")){
						 grossincome1="0";
					 }
						 if(net_monthly_income.equalsIgnoreCase("")){
							 net_monthly_income="0";
						 }
							 if(salary_income.equalsIgnoreCase("")){
								 salary_income="0";
							 }
					grossincome=Double.valueOf(grossincome1)+Double.valueOf(net_monthly_income)+Double.valueOf(salary_income);
											 
					
					 if(house_property.equalsIgnoreCase("")){
						 house_property="0";
					 }
						 if(other_source.equalsIgnoreCase("")){
							 other_source="0";
						 }
							 if(capital_gain.equalsIgnoreCase("")){
								 capital_gain="0";
							 }
					 otherincome=Double.valueOf(house_property)+Double.valueOf(other_source)+Double.valueOf(capital_gain);
					
			}
			
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","ins_incomeexpene_np");
			arrValues.add(app_id);
			arrValues.add("0");	
			arrValues.add(strInqno);	
			arrValues.add(String.valueOf(grossincome));
			arrValues.add(String.valueOf(otherincome));
			arrValues.add(String.valueOf(incometax));
			System.out.println("income--------"+arrValues);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
			
			hsh = getNpMailbox(hshValues);

			
		}
		catch(Exception ex)
		{
			Logger.log("Exception in getNpapplications"+ex);
		}	
		return hsh;
	}
	public HashMap getNPALiveliwoodInwardCreation(HashMap hshValues)
	{
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs3 = null;
		HashMap hshRecord = new HashMap();
		HashMap hsh = new HashMap();
		String strQuery = "",strquery1="";
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		HashMap hshQueryValues = new HashMap();
		String strbranchcode=Helper.correctNull((String)hshValues.get("strOrgShortCode"));
		String strusrid=Helper.correctNull((String)hshValues.get("strUserId"));
		String strStatus=Helper.correctNull((String)hshValues.get("hidaction"));
		String strRefno = Helper.correctNull((String)hshValues.get("hidRefId"));
		
		if(strRefno.equalsIgnoreCase("")){
		strRefno = Helper.correctNull((String)hshValues.get("hidApplicantId"));
		}
		InwardRegisterBean inwardregister = new InwardRegisterBean(); 
		String selsegment=Helper.correctNull((String)hshValues.get("selsegment"));
		try
		{	
			String Schemetype="";
			strQuery = SQLParser.getSqlQuery("sel_applicationscheme_np^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				Schemetype=Helper.correctNull((String)rs.getString("NPDT_NP_SCHEME_NAME"));
			}
			String strCur_Address="";
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","ins_npinwarddet");	
			String strInqno = inwardregister.getMaxInwardno(strbranchcode);
			arrValues.add(strInqno);
			arrValues.add(strRefno);			
			
				strQuery = SQLParser.getSqlQuery("getPersonalDetails_NPUM^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
				arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_LHPD_F_NAME"))+" "
						+Helper.correctNull((String)rs.getString("NPLPD_LHPD_M_NAME"))
						+" "+Helper.correctNull((String)rs.getString("NPLPD_LHPD_L_NAME")));
				arrValues.add(getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("NPLPD_GENDER"))));
				
				arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_DATE_OF_BIRTH")));
				
				arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_EMAIL")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_MOBILE")));
				arrValues.add("");
				arrValues.add("");
				arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_LHPD_PAN")));
				strCur_Address = Helper.correctNull((String)rs.getString("NPLPD_AADHAR_ADD_SEQ_NO"));
				}
			
			if(rs != null){rs.close();}
			
			if(!strCur_Address.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+strCur_Address);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME")));
				String district=Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME"));
				//District Code added by kannan
				if(!district.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_District_Name^"+district);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("DISTRICT_CODE")));
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				String city=Helper.correctNull((String)rs.getString("NPAD_CITY_NAME"));
				String state=Helper.correctNull((String)rs.getString("NPAD_STATE_NAME"));
				
				if(!state.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
				rs3 = DBUtils.executeQuery(strQuery);			
				if(rs3.next())
				{
					arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
				}else{
					arrValues.add("");
				}
				}else{
					arrValues.add("");
				}
				String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
				if(!city.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				arrValues.add("IN");
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
			}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("IN");
				arrValues.add("");
			}}else{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("IN");
				arrValues.add("");

			}
			double dblloanamnt=0.00,dblsubsidyamnt=0.00;
			if(rs != null){rs.close();}
			strQuery = SQLParser.getSqlQuery("sel_npprincdet^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				arrValues.add(Helper.correctNull((String)rs.getString("NPID_LOAN_AMT")));
				dblloanamnt = Double.parseDouble(Helper.correctDouble((String)rs.getString("NPID_LOAN_AMT")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPID_TENOR")));	
				dblsubsidyamnt = Double.parseDouble(Helper.correctDouble((String)rs.getString("NPID_SUBSIDY_AMT")));
			}else{
				arrValues.add("");	
				arrValues.add("");	
			}
			arrValues.add("c");
			arrValues.add(getNPtoLAPSCommonLOV(Helper.correctNull((String)hshValues.get("SchemeName")),
					Helper.correctNull((String)hshValues.get("selsegment")),"PROCESSINGAT"));//to be change
			arrValues.add(strbranchcode);
			arrValues.add(strusrid);
			arrValues.add(strusrid);
			if(rs != null){rs.close();}
			strQuery = SQLParser.getSqlQuery("sel_npcoappdet^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				arrValues.add("1");
			}
			else
			{
				arrValues.add("");
			}
			//UBI Functionality for Branch
			String StrForward="";
			strQuery = SQLParser.getSqlQuery("sel_orghead^"+Helper.correctNull((String)hshValues.get("strOrgCode")) );
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				StrForward = correctNull((String) rs.getString("org_head"));
			}
			if (rs != null) {
				rs.close();
			}
			String StrForwardorg = "";
			if (StrForward != null) 
			{
				strQuery = SQLParser.getSqlQuery("sel_orghead_User^"+StrForward);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					StrForwardorg = correctNull((String)rs.getString("USR_ORGCODE"));
				}		
			}
			arrValues.add(Helper.correctNull((String)hshValues.get("strOrgCode")));//changed
			if(Schemetype.equalsIgnoreCase("")){
				arrValues.add(getNPtoLAPSCommonLOV(Helper.correctNull((String)hshValues.get("SchemeName")),
						Helper.correctNull((String)hshValues.get("selsegment")),"PRODUCTCODE"));
				}else{
					arrValues.add(getNPtoLAPSCommonLOV1(Helper.correctNull((String)hshValues.get("SchemeName")),
							Helper.correctNull((String)hshValues.get("selsegment")),"PRODUCTCODE",Schemetype));
				}
			arrValues.add(strbranchcode);
			arrValues.add(strbranchcode);
			arrValues.add(String.valueOf(dblloanamnt));
			arrValues.add(Helper.correctNull((String)hshValues.get("strOrgbankFlag")));//changed			
			arrValues.add("Y");//constraint issue
			arrValues.add(String.valueOf(dblsubsidyamnt));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
			
			String StrOffadd="",strappcoappid="";			
			//Insertion for Employment Details
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","ins_npempdetails");	
			arrValues.add("0");
			
				strQuery = SQLParser.getSqlQuery("getPersonalDetails_NPUM^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
				arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_LHPD_F_NAME"))+" "
						+Helper.correctNull((String)rs.getString("NPLPD_LHPD_M_NAME"))
						+" "+Helper.correctNull((String)rs.getString("NPLPD_LHPD_L_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_MOBILE")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_EMAIL")));
				arrValues.add("");
				arrValues.add("A");
				arrValues.add("");
				StrOffadd = Helper.correctNull((String)rs.getString("NPLPD_AADHAR_ADD_SEQ_NO"));
				strappcoappid = Helper.correctNull((String)rs.getString("NPLPD_ID"));
				}
			
			
			arrValues.add("IN");
			arrValues.add(strInqno);
			arrValues.add("0");
			if(rs != null){rs.close();}
			if(!StrOffadd.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME")));
				//arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME")));
				arrValues.add("");
				String city=Helper.correctNull((String)rs.getString("NPAD_CITY_NAME"));
				String state=Helper.correctNull((String)rs.getString("NPAD_STATE_NAME"));
				if(!city.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_city_name^"+city);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				if(!state.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
				rs3 = DBUtils.executeQuery(strQuery);			
				if(rs3.next())
				{
					arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
				}else{
					arrValues.add("");
				}
				}else{
					arrValues.add("");
				}
			

				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
			}	
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}
			}else{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");	
			}
			arrValues.add(strappcoappid);
			System.out.println("emp1----------------------"+arrValues);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
			
			//Insertion block for Coapplicant Data
			
			String strsId="",strCur_Add="";
			strQuery = SQLParser.getSqlQuery("sel_npcoappdet^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			while(rs.next())
			{		
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","ins_npcoappdet");	
				arrValues.add(strInqno);
				arrValues.add(strbranchcode);
				arrValues.add(strusrid);
				rs1 = DBUtils.executeLAPSQuery("selmax_cibilcoapp^"+ strInqno);
				if (rs1.next()) {
					strsId = correctNull((String) rs1.getString("inward_appid"));
				} else {
					strsId = "1";
				}
				arrValues.add(strsId);
				arrValues.add(Helper.correctNull((String)hshValues.get("strOrgbankFlag")));//changed
				arrValues.add(strusrid);
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_FNAME"))+" "
								+Helper.correctNull((String)rs.getString("NPCD_MNAME"))
								+" "+Helper.correctNull((String)rs.getString("NPCD_LNAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_LNAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_MOBILE")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_EMAIL")));
				strCur_Add = Helper.correctNull((String)rs.getString("NPCD_AADHAR_ADD_SEQ"));
				
				if(rs1 != null){rs1.close();}
				if(!strCur_Add.equalsIgnoreCase("")){
				strquery1 = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+strCur_Add);
				rs1 = DBUtils.executeQuery(strquery1);			
				if(rs1.next())
				{
					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs1.getString("NPAD_LANDMARK")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME")));
					String district=Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME"));
					//District Code added by kannan
					if(!district.equalsIgnoreCase("")){
						strQuery = SQLParser.getSqlQuery("NP_District_Name^"+district);
						rs3 = DBUtils.executeQuery(strQuery);			
						if(rs3.next())
						{
							arrValues.add(Helper.correctNull((String)rs3.getString("DISTRICT_CODE")));
						}else{
							arrValues.add("");
						}
						}else{
							arrValues.add("");
						}
					String city=Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME"));
					String state=Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME"));
					
					if(!state.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
					if(!city.equalsIgnoreCase("")){
						strQuery = SQLParser.getSqlQuery("NP_city_name^"+city);
						rs3 = DBUtils.executeQuery(strQuery);			
						if(rs3.next())
						{
							arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
						}else{
							arrValues.add("");
						}
						}else{
							arrValues.add("");
						}
					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE")));
				}
				else
				{
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
				}}else{
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
				}
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_RELATION")));
				arrValues.add(getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("NPCD_GENDER"))));
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_DOB")));			
				arrValues.add(getNPtoLAPSListOfValue("6",Helper.correctNull((String)rs.getString("NPCD_EMPLOY_TYPE"))));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
				
				
				//Insertion for Applicant Employment Details
				String stroffadd="";
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","ins_npempdetails");	
				arrValues.add("0");
				strquery1 = SQLParser.getSqlQuery("sel_npcoappdet^"+strRefno);
				rs1 = DBUtils.executeQuery(strquery1);			
				if(rs1.next())
				{
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_ORG_NAME")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_MOBILE")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_EMAIL")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_DESIGNATION")));
					arrValues.add("");
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_RETIRE_AGE")));
					strappcoappid = Helper.correctNull((String)rs1.getString("NPCD_COAPP_ID"));
					stroffadd = Helper.correctNull((String)rs1.getString("NPCD_OFFICE_ADD_SEQ"));
					
				}
				arrValues.add("");
				arrValues.add(strInqno);
				arrValues.add(strsId);
				if(rs1 != null){rs1.close();}
				if(!stroffadd.equalsIgnoreCase("")){
				strquery1 = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+stroffadd);
				rs1 = DBUtils.executeQuery(strquery1);			
				if(rs1.next())
				{
					
					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs1.getString("NPAD_LANDMARK")));
					//arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME")));
					String district=Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME"));
					//District Code added by kannan
					if(!district.equalsIgnoreCase("")){
						strQuery = SQLParser.getSqlQuery("NP_District_Name^"+district);
						rs3 = DBUtils.executeQuery(strQuery);			
						if(rs3.next())
						{
							arrValues.add(Helper.correctNull((String)rs3.getString("DISTRICT_CODE")));
						}else{
							arrValues.add("");
						}
						}else{
							arrValues.add("");
						}
					arrValues.add("");
					String city=Helper.correctNull((String)rs.getString("NPAD_CITY_NAME"));
					String state=Helper.correctNull((String)rs.getString("NPAD_STATE_NAME"));
					if(!city.equalsIgnoreCase("")){
						strQuery = SQLParser.getSqlQuery("NP_city_name^"+city);
						rs3 = DBUtils.executeQuery(strQuery);			
						if(rs3.next())
						{
							arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
						}else{
							arrValues.add("");
						}
						}else{
							arrValues.add("");
						}
					if(!state.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				

					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE")));
				}
				else
				{
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
				}}else{
					
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
				}
				arrValues.add(strappcoappid);
				System.out.println("emp12345----------------------"+arrValues);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
			}
			
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","upd_nppdinwdetails");	
			arrValues.add(strInqno);	
			arrValues.add("P");
			arrValues.add(strRefno);			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
			
			hshValues.put("InwardNo",strInqno);
			hshValues.put("REFERENCEID",strRefno);
			String app_id="0";
			Double grossincome=0.0,otherincome=0.0,incometax=0.0;
			strquery1 = SQLParser.getSqlQuery("sel_npFinancial1^"+strRefno);
			rs1 = DBUtils.executeQuery(strquery1);			
			if(rs1.next())
			{
				
				String grossincome1="0",net_monthly_income="0",salary_income="0";
				String house_property="0",other_source="0",capital_gain="0";
				 grossincome1=Helper.correctNull((String)rs1.getString("NPFD_GROSS_MONTHLY_INCOME"));
				 net_monthly_income=Helper.correctNull((String)rs1.getString("NPFD_NET_MONTHLY_INCOME"));
				 salary_income=Helper.correctNull((String)rs1.getString("NPFD_SALARY_INCOME"));
				
				 house_property=Helper.correctNull((String)rs1.getString("NPFD_HOUSE_PROPERTY"));
				 other_source=Helper.correctNull((String)rs1.getString("NPFD_OTHER_SOURCE"));
				 capital_gain=Helper.correctNull((String)rs1.getString("NPFD_CAPITAL_GAIN"));
				
				 app_id=Helper.correctNull((String)rs1.getString("NPFD_ID"));
				 String Taxincome=Helper.correctNull((String)rs1.getString("NPFD_TAXABLE_INCOME"));
				 
				 if(!Taxincome.equalsIgnoreCase("")){
					 incometax=Double.valueOf(Taxincome);
					 }
					 if(grossincome1.equalsIgnoreCase("")){
						 grossincome1="0";
					 }
						 if(net_monthly_income.equalsIgnoreCase("")){
							 net_monthly_income="0";
						 }
							 if(salary_income.equalsIgnoreCase("")){
								 salary_income="0";
							 }
					grossincome=Double.valueOf(grossincome1)+Double.valueOf(net_monthly_income)+Double.valueOf(salary_income);
											 
					
					 if(house_property.equalsIgnoreCase("")){
						 house_property="0";
					 }
						 if(other_source.equalsIgnoreCase("")){
							 other_source="0";
						 }
							 if(capital_gain.equalsIgnoreCase("")){
								 capital_gain="0";
							 }
					 otherincome=Double.valueOf(house_property)+Double.valueOf(other_source)+Double.valueOf(capital_gain);
							 
				 
			}
			
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","ins_incomeexpene_np");
			arrValues.add(app_id);
			arrValues.add("0");	
			arrValues.add(strInqno);	
			arrValues.add(String.valueOf(grossincome));
			arrValues.add(String.valueOf(otherincome));
			arrValues.add(String.valueOf(incometax));
			System.out.println("income--------"+arrValues);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
			
			hsh = getNpMailbox(hshValues);

			
		}
		catch(Exception ex)
		{
			Logger.log("Exception in getNpapplications"+ex);
		}	
		return hsh;
	}
	private String getNPtoLAPSListOfValue(String strparamId, String strnpval) 
	{
		 ResultSet rs = null;
		 String strQuery = "";
		 String strlapsoptionval = "";
		 
		 try{
		 System.out.print("strnpval"+strnpval);
			 if(!strnpval.equalsIgnoreCase("")){
			 strQuery = SQLParser.getSqlQuery("sel_nplistofval1^"+strparamId+"^"+strnpval);
			 rs = DBUtils.executeQuery(strQuery);
			 if (rs.next()) 
			 {
				 strlapsoptionval = Helper.correctNull((String)rs.getString("NPLOV_LPCODE"));
			 }
			 }else{
				 strlapsoptionval="";
			 }
		 }
		 catch(Exception ce)
		 {
			 throw new EJBException("Error in getCBStoLAPSListOfValue" + ce.toString());
		 }
		 finally 
		 {
			try 
			{
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection " 	+ cf.getMessage());
			}
		 }
		 return strlapsoptionval;
	}
	
	public HashMap getEmplyomentdetails(HashMap hshValues) {
		
		ResultSet rs=null,rs1=null;
		String strQuery="";
		int sno=0;
		String strApplicationRefNo=Helper.correctNull((String) hshValues.get("strApplicationRefNo"));
		
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_npemploy^"+strApplicationRefNo);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				
				
				hshValues.put("NPPD_EMP_TYPE", Helper.correctNull(rs.getString("NPPD_EMP_TYPE")));
				hshValues.put("NPPD_ORG_TYPE", Helper.correctNull(rs.getString("NPPD_ORG_TYPE")));
				hshValues.put("NPPD_ORG_NAME", Helper.correctNull(rs.getString("NPPD_ORG_NAME")));
				hshValues.put("NPPD_DESIGNATION", Helper.correctNull(rs.getString("NPPD_DESIGNATION")));
				hshValues.put("NPPD_WORKING_SINCE_YEAR", Helper.correctNull(rs.getString("NPPD_WORKING_SINCE_YEAR")));
				hshValues.put("NPPD_WORKING_SINCE_MONTH", Helper.correctNull(rs.getString("NPPD_WORKING_SINCE_MONTH")));
				hshValues.put("NPPD_RETIRE_AGE", Helper.correctNull(rs.getString("NPPD_RETIRE_AGE")));
				hshValues.put("NPPD_BUSS_ESTA_YEAR", Helper.correctNull(rs.getString("NPPD_BUSS_ESTA_YEAR")));
				hshValues.put("NPPD_BUSS_ESTA_MONTH", Helper.correctNull(rs.getString("NPPD_BUSS_ESTA_MONTH")));
				hshValues.put("NPPD_CURR_BUSS_YEAR", Helper.correctNull(rs.getString("NPPD_CURR_BUSS_YEAR")));
				
			}
			hshValues.put("strApplicationRefNo",strApplicationRefNo);
			if(rs != null)
			{
				rs.close();
			}	
			
		}
		catch(Exception ex)
		{
			Logger.log("Exception in getNpapplications"+ex);
		}	
	return hshValues;
	}
	public HashMap getFinancialITRDetails(HashMap hshValues) {
		
		ResultSet rs=null,rs1=null;
		String strQuery="";
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = new ArrayList();
		int sno=0;
		String strApplicationRefNo=Helper.correctNull((String) hshValues.get("strApplicationRefNo"));
		String strId=Helper.correctNull((String) hshValues.get("strApplicationRefNo"));
		
		try
		{
			
			strQuery=SQLParser.getSqlQuery("sel_npFinancial^"+strApplicationRefNo+"^"+strId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("NPFD_GROSS_MONTHLY_INCOME", Helper.correctNull(rs.getString("NPFD_GROSS_MONTHLY_INCOME")));
				hshValues.put("NPFD_SALARY_INCOME", Helper.correctNull(rs.getString("NPFD_SALARY_INCOME")));
				hshValues.put("NPFD_HOUSE_PROPERTY", Helper.correctNull(rs.getString("NPFD_HOUSE_PROPERTY")));
				hshValues.put("NPFD_PGBP", Helper.correctNull(rs.getString("NPFD_PGBP")));
				hshValues.put("NPFD_OTHER_SOURCE", Helper.correctNull(rs.getString("NPFD_OTHER_SOURCE")));
				hshValues.put("NPFD_GROSS_INCOME", Helper.correctNull(rs.getString("NPFD_GROSS_INCOME")));
				hshValues.put("NPFD_IS_MANUALLY_FILLED", Helper.correctNull(rs.getString("NPFD_IS_MANUALLY_FILLED")));
				hshValues.put("NPFD_TAXABLE_INCOME", Helper.correctNull(rs.getString("NPFD_TAXABLE_INCOME")));
				
			}
			strQuery=SQLParser.getSqlQuery("sel_npFinancial1^"+strApplicationRefNo);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol= new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("NPFD_ID")));
				arrCol.add( Helper.correctNull(rs.getString("NPFD_GROSS_MONTHLY_INCOME")));
				arrCol.add(Helper.correctNull(rs.getString("NPFD_SALARY_INCOME")));
				arrCol.add(Helper.correctNull(rs.getString("NPFD_HOUSE_PROPERTY")));
				arrCol.add(Helper.correctNull(rs.getString("NPFD_PGBP")));
				arrCol.add(Helper.correctNull(rs.getString("NPFD_OTHER_SOURCE")));
				arrCol.add(Helper.correctNull(rs.getString("NPFD_GROSS_INCOME")));
				arrCol.add(Helper.correctNull(rs.getString("NPFD_IS_MANUALLY_FILLED")));
				arrCol.add(Helper.correctNull(rs.getString("NPFD_TAXABLE_INCOME")));
				arrCol.add(Helper.correctNull(rs.getString("NPFD_TYPE")));
				arrRow.add(arrCol);
				
				
				
			}
			hshValues.put("strApplicationRefNo",strApplicationRefNo);
			hshValues.put("arrRow",arrRow);
			if(rs != null)
			{
				rs.close();
			}	
			
		}
		catch(Exception ex)
		{
			Logger.log("Exception in getNpapplications"+ex);
		}	
	return hshValues;
	}
	public HashMap getBREmatch(HashMap hshValues) {
		String strQuery="";
		ResultSet rs = null;
		HashMap hshResult = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arrCol = null;
		String strApplicationRefNo=Helper.correctNull((String) hshValues.get("strApplicationRefNo"));
		
		try
		{
				    strQuery = SQLParser.getSqlQuery("getBREDetails^"+strApplicationRefNo);
					rs = DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						arrCol = new ArrayList();
						arrCol.add(Helper.correctNull((String) rs.getString("NPMD_ROW_ID")));//0
						arrCol.add(Helper.correctNull((String) rs.getString("NPMD_APPLICATION_REFERENCE_ID")));//1
						arrCol.add(Helper.correctNull((String) rs.getString("NPMD_PARAMETER_NAME")));//2
						arrCol.add(Helper.CLOBToString(rs.getClob("NPMD_FS_VALUE")));//3
						arrCol.add(Helper.CLOBToString(rs.getClob("NPMD_FP_VALUE")));//4
						arrCol.add(Helper.correctNull((String) rs.getString("NPMD_APPLICANT_TYPE")));//5
						arrCol.add(Helper.correctNull((String) rs.getString("NPMD_IS_MANDATORY")));//6
						arrCol.add(Helper.correctNull((String) rs.getString("NPMD_IS_MATCHED")));//7
						arryRow.add(arrCol);
					}
			hshValues.put("strApplicationRefNo",strApplicationRefNo);
			hshValues.put("arryRow", arryRow);	
		}
		catch(Exception ex)
		{
			Logger.log("Exception in getNpapplications"+ex);
		}	
	return hshValues;	
	}
	
	public HashMap getNPDedupeChk(HashMap hshValues) 
	{
		ResultSet rs=null;
		ResultSet rs1=null;
		
		String strQuery="";
		String refno=correctNull((String)hshValues.get("refID"));
		if(refno.equalsIgnoreCase(""))
		{
			refno=correctNull((String)hshValues.get("hidref"));
		}
		String strSegment=correctNull((String)hshValues.get("SegType"));
		if(strSegment.equalsIgnoreCase(""))
		{
			strSegment=correctNull((String)hshValues.get("varsegment"));
		}
		
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow1=new ArrayList();
		ArrayList arrCol1=new ArrayList();
		String name="";
		String strScheme="";
		try
		{
			
			strQuery = SQLParser.getSqlQuery("sel_applicationscheme_np^"+refno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				strScheme=Helper.correctNull((String)rs.getString("NPDT_NP_SCHEME_NAME"));
			}
			
			 
			
			hshValues.put("strSegment",strSegment);
			if(strSegment.equalsIgnoreCase("BS")){
				if(strScheme.equalsIgnoreCase("STD") || strScheme.equalsIgnoreCase("PMMY")){
					
				strQuery = SQLParser.getSqlQuery("select_npapp_dedupechk_MUDRA^"+refno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					 name=(correctNull(rs.getString("np_name")));
					
					hshValues.put("NP_NAME",correctNull(rs.getString("NP_NAME")));
					hshValues.put("NPPD_DOB",correctNull(rs.getString("NPPD_DOB")));
					hshValues.put("NP_DRIVING",correctNull(rs.getString("NP_DRIVING")));
					hshValues.put("NP_ADHAR",correctNull(rs.getString("NP_ADHAR")));
					hshValues.put("NP_PAN",correctNull(rs.getString("NP_PAN")));
					hshValues.put("NP_VOTE",correctNull(rs.getString("NP_VOTE")));
					
				}
				} 
				if(strScheme.equalsIgnoreCase("SWMS")){
					strQuery = SQLParser.getSqlQuery("select_npapp_dedupechk_SWMS^"+refno);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						 name=(correctNull(rs.getString("np_name")));
						
						hshValues.put("NP_NAME",correctNull(rs.getString("NP_NAME")));
						hshValues.put("NPPD_DOB",correctNull(rs.getString("NPPD_DOB")));
						hshValues.put("NP_DRIVING",correctNull(rs.getString("NP_DRIVING")));
						hshValues.put("NP_ADHAR",correctNull(rs.getString("NP_ADHAR")));
						hshValues.put("NP_PAN",correctNull(rs.getString("NP_PAN")));
						hshValues.put("NP_VOTE",correctNull(rs.getString("NP_VOTE")));
						
					}
					} 	else if(strScheme.equalsIgnoreCase("SRMS")){
					strQuery = SQLParser.getSqlQuery("select_npapp_dedupechk_SWMS^"+refno);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						 name=(correctNull(rs.getString("np_name")));
						
						hshValues.put("NP_NAME",correctNull(rs.getString("NP_NAME")));
						hshValues.put("NPPD_DOB",correctNull(rs.getString("NPPD_DOB")));
						hshValues.put("NP_DRIVING",correctNull(rs.getString("NP_DRIVING")));
						hshValues.put("NP_ADHAR",correctNull(rs.getString("NP_ADHAR")));
						hshValues.put("NP_PAN",correctNull(rs.getString("NP_PAN")));
						hshValues.put("NP_VOTE",correctNull(rs.getString("NP_VOTE")));
						
					}
					}
				
				
				} else if(strSegment.equalsIgnoreCase("LHD")){
				strQuery = SQLParser.getSqlQuery("sel_npapp_dedupechk_lhd^"+refno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					 name=(correctNull(rs.getString("np_name")));
					
					hshValues.put("NP_NAME",correctNull(rs.getString("NP_NAME")));
					hshValues.put("NPPD_DOB",correctNull(rs.getString("NPPD_DOB")));
					hshValues.put("NP_DRIVING",correctNull(rs.getString("NP_DRIVING")));
					hshValues.put("NP_ADHAR",correctNull(rs.getString("NP_ADHAR")));
					hshValues.put("NP_PAN",correctNull(rs.getString("NP_PAN")));
					hshValues.put("NP_VOTE",correctNull(rs.getString("NP_VOTE")));
					
				}
				} else if(strSegment.equalsIgnoreCase("AGRI")){
			strQuery = SQLParser.getSqlQuery("sel_npapp_dedupechk_agri^"+refno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				 name=(correctNull(rs.getString("np_name")));
				hshValues.put("NP_NAME",correctNull(rs.getString("NP_NAME")));
				hshValues.put("NPPD_DOB",correctNull(rs.getString("NPPD_DOB")));
				hshValues.put("NP_DRIVING",correctNull(rs.getString("NP_DRIVING")));
				hshValues.put("NP_ADHAR",correctNull(rs.getString("NP_ADHAR")));
				hshValues.put("NP_PAN",correctNull(rs.getString("NP_PAN")));
				hshValues.put("NP_VOTE",correctNull(rs.getString("NP_VOTE")));
				
			}
			}else{
			strQuery = SQLParser.getSqlQuery("sel_npapp_dedupechk^"+refno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				 name=(correctNull(rs.getString("np_name")));
				
				    hshValues.put("NP_NAME",correctNull(rs.getString("np_name")));
					hshValues.put("NPPD_DOB",correctNull(rs.getString("NPPD_DOB")));
					hshValues.put("NP_DRIVING",correctNull(rs.getString("driving")));
					hshValues.put("NP_ADHAR",correctNull(rs.getString("adhar")));
					hshValues.put("NP_PAN",correctNull(rs.getString("NPPD_PAN_NO")));
					hshValues.put("NP_VOTE",correctNull(rs.getString("NPPD_VOTER_NO")));
				
			}
			}
			strQuery = SQLParser.getSqlQuery("sel_np_dedupechk^"+refno+"^"+name.trim());
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				hshValues.put("NP_LAPSID",correctNull(rs1.getString("NP_LAPSID")));
				hshValues.put("NP_ISNEW",correctNull(rs1.getString("NP_ISNEW")));
				hshValues.put("NP_CBSID",correctNull(rs1.getString("NP_CBSID")));
				hshValues.put("NP_ISDEDUPE",correctNull(rs1.getString("NP_ISDEDUPE")));
			
			}
			
			strQuery = SQLParser.getSqlQuery("sel_npcoapp_dedupechk^"+refno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol1=new ArrayList();
				 name=(correctNull(rs.getString("np_name")));
				arrCol1.add(correctNull(rs.getString("np_name")));
				arrCol1.add(correctNull(rs.getString("NPCD_DOB")));
				arrCol1.add(correctNull(rs.getString("driving")));
				arrCol1.add(correctNull(rs.getString("adhar")));
				arrCol1.add(correctNull(rs.getString("NPPD_PAN_NO")));
				arrCol1.add(correctNull(rs.getString("NPPD_VOTER_NO")));
				
				
				strQuery = SQLParser.getSqlQuery("sel_np_dedupechk^"+refno+"^"+name.trim());
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
				arrCol1.add(correctNull(rs1.getString("NP_LAPSID")));
				arrCol1.add(correctNull(rs1.getString("NP_ISNEW")));
				arrCol1.add(correctNull(rs1.getString("NP_CBSID")));
				arrCol1.add(correctNull(rs1.getString("NP_ISDEDUPE")));
				
				}else{
					arrCol1.add("");
					arrCol1.add("");
					arrCol1.add("");
					arrCol1.add("");
				}
				arrRow1.add(arrCol1);
			}
			hshValues.put("arrRow", arrRow);
			hshValues.put("arrRow1", arrRow1);
			hshValues.put("strrefno", refno);
			hshValues.put("strrefno", refno);
			
			if(correctNull((String)hshValues.get("strDedupeflag")).equalsIgnoreCase("N"))
			{
				hshValues.put("strActionflag", "N");
			}else{
				hshValues.put("strActionflag", correctNull((String)hshValues.get("strActionflag")));
			}
			if(correctNull((String)hshValues.get("strActionflag")).equalsIgnoreCase("Y"))
			{
				hshValues.put("PERAPP_ID", correctNull((String)hshValues.get("PERAPP_ID")));
				hshValues.put("PERAPP_DOB", correctNull((String)hshValues.get("PERAPP_DOB")));
				
				
				String strdriving = Helper.correctNull((String)hshValues.get("PERAPP_DRIVINGLICENCENUMBER"));
            	if(strdriving.length()<24)
            	{
            		hshValues.put("PERAPP_DRIVINGLICENCENUMBER", strdriving);
            	}
            	else
            	{
            		String strDecryptedpan="";
            		String key=ApplicationParams.getStrAadharkey();
            		String initVector=ApplicationParams.getStrAadharvector();
            		strDecryptedpan = AES_Encryption.AESdecrypt(key,initVector,strdriving);
            		hshValues.put("PERAPP_DRIVINGLICENCENUMBER",strDecryptedpan);
            	}
				
            	String straadhar = Helper.correctNull((String)hshValues.get("PERAPP_AADHAAR"));
            	if(straadhar.length()<24)
            	{
            		hshValues.put("PERAPP_AADHAAR", straadhar);
            	}
            	else
            	{
            		String strDecryptedpan="";
            		String key=ApplicationParams.getStrAadharkey();
            		String initVector=ApplicationParams.getStrAadharvector();
            		strDecryptedpan = AES_Encryption.AESdecrypt(key,initVector,straadhar);
            		hshValues.put("PERAPP_AADHAAR",strDecryptedpan);
            	}
				
            	String strpanno = Helper.correctNull((String)hshValues.get("PERAPP_PANNO"));  
            	if(strpanno.length()<24)
            	{
            		hshValues.put("PERAPP_PANNO", strpanno);
            	}
            	else
            	{
            		String strDecryptedpan="";
            		String key=ApplicationParams.getStrAadharkey();
            		String initVector=ApplicationParams.getStrAadharvector();
            		strDecryptedpan = AES_Encryption.AESdecrypt(key,initVector,strpanno);
            		hshValues.put("PERAPP_PANNO",strDecryptedpan);
            	}
				
            	String PERAPP_VOTERID =Helper.correctNull((String)hshValues.get("PERAPP_VOTERID")); 
            	if(PERAPP_VOTERID.length()<24)
            	{
            		hshValues.put("PERAPP_VOTERID", PERAPP_VOTERID);
            	}
            	else
            	{
            		String strDecryptedpan="";
            		String key=ApplicationParams.getStrAadharkey();
            		String initVector=ApplicationParams.getStrAadharvector();
            		strDecryptedpan = AES_Encryption.AESdecrypt(key,initVector,PERAPP_VOTERID);
            		hshValues.put("PERAPP_VOTERID",strDecryptedpan);
            	}
				
				String strcbsid = Helper.correctNull((String)hshValues.get("PERAPP_CBSID"));
            	if(strcbsid.length()<24)
            	{
            		hshValues.put("PERAPP_CBSID", strcbsid);
            	}
            	else
            	{
            		String strDecryptedpan="";
            		String key=ApplicationParams.getStrAadharkey();
            		String initVector=ApplicationParams.getStrAadharvector();
            		strDecryptedpan = AES_Encryption.AESdecrypt(key,initVector,strcbsid);
            		hshValues.put("PERAPP_CBSID",strDecryptedpan);
            	}
				hshValues.put("hid_dif", correctNull((String)hshValues.get("hid_dif")));
				hshValues.put("hid_col", correctNull((String)hshValues.get("hid_col")));
			}
			
		}
		catch(Exception ex)
		{
			Logger.log("Exception in getNPDedupeChk"+ex);
		}	
	return hshValues;
	}
	
	
	public HashMap  updateNPDedupeChk(HashMap hshValues) throws RemoteException
	{		
		ResultSet rs=null;
		String strQuery="";
		HashMap hshQuery =new HashMap();		
		HashMap hshQueryValues =new HashMap();	
		ArrayList arrValues = new ArrayList();
		String strDedupeflag = Helper.correctNull((String)hshValues.get("hid_dedupe"));
		String strRef = Helper.correctNull((String)hshValues.get("hidref"));
		String strdob="",strDR="",stradhar="",strPAN="",strVoter="",strflag="",strlapsid="",strName="",strEncryptedpanNo="",strdif="",strcbs="",strapptype="";
		String strDet="";
		String key=ApplicationParams.getStrAadharkey();
		String initVector=ApplicationParams.getStrAadharvector();
		
		try
		{
				strdif=Helper.correctNull((String)hshValues.get("hid_dif"));
				if(strdif.equalsIgnoreCase("coapp"))
				{
					strapptype = "C";
				}else if(strdif.equalsIgnoreCase("coapp1"))
				{
					strapptype = "C";
				}else if(strdif.equalsIgnoreCase("coapp2"))
				{
					strapptype = "C";
				}else{
					strapptype = "A";
				}
				strdob=Helper.correctNull((String)hshValues.get("hid_dob"));
				strDR=Helper.correctNull((String)hshValues.get("hid_dr"));
				stradhar=Helper.correctNull((String)hshValues.get("hid_adhar"));
				strVoter=Helper.correctNull((String)hshValues.get("hid_voter"));
				strPAN=Helper.correctNull((String)hshValues.get("hid_pan"));
				String strSegment=Helper.correctNull((String)hshValues.get("SegType"));
				
				
				
				//if(!strSegment.equalsIgnoreCase("BS") && !strSegment.equalsIgnoreCase("LHD"))
				if(!strSegment.equalsIgnoreCase("LHD"))
				{
				if(!strPAN.equalsIgnoreCase(""))
				{
					strEncryptedpanNo  =  Helper.correctNull(AES_Encryption.AESencrypt(key,initVector,strPAN));
				}else{
					strEncryptedpanNo ="";
				}
				if(!strPAN.equalsIgnoreCase(""))
				{
					if(strDet.equalsIgnoreCase(""))
					{
						strDet = strDet + " upper(rtrim(ltrim(PERAPP_PANNO)))=upper(rtrim(ltrim('"+strEncryptedpanNo+"')))";
					}else{
						strDet = strDet + " and upper(rtrim(ltrim(PERAPP_PANNO)))=upper(rtrim(ltrim('"+strEncryptedpanNo+"')))";
					}
				}
				if(!strDR.equalsIgnoreCase(""))
				{
					if(strDet.equalsIgnoreCase(""))
					{
					strDet = strDet + " upper(rtrim(ltrim(PERAPP_DRIVINGLICENCENUMBER))) = upper(rtrim(ltrim('"+strDR+"')))";
					}else{
						strDet = strDet + "and upper(rtrim(ltrim(PERAPP_DRIVINGLICENCENUMBER))) = upper(rtrim(ltrim('"+strDR+"')))";
					}
				}
				
				if(!stradhar.equalsIgnoreCase(""))
				{
					if(strDet.equalsIgnoreCase(""))
					{
					strDet = strDet + " upper(rtrim(ltrim(PERAPP_AADHAAR)))=upper(rtrim(ltrim('"+stradhar+"')))";
					}else{
					strDet = strDet + "and upper(rtrim(ltrim(PERAPP_AADHAAR)))=upper(rtrim(ltrim('"+stradhar+"')))";		
					}
				}
				if(!strVoter.equalsIgnoreCase(""))
				{
					if(strDet.equalsIgnoreCase(""))
					{
					strDet = strDet + " upper(rtrim(ltrim(PERAPP_VOTERID)))=upper(rtrim(ltrim('"+strVoter+"')))";
					}else{
					strDet = strDet + "and upper(rtrim(ltrim(PERAPP_VOTERID)))=upper(rtrim(ltrim('"+strVoter+"')))";		
					}
				}
				
				if(!strdob.equalsIgnoreCase(""))
				{
					
					if(strDet.equalsIgnoreCase(""))
					{
					strDet = strDet + "  perapp_dob=to_date('"+strdob+"','dd/mm/yyyy')";
					}else{
					strDet = strDet + " and perapp_dob=to_date('"+strdob+"','dd/mm/yyyy')";		
					}
				}
				
				if(!strDet.equalsIgnoreCase("")){
				strQuery= SQLParser.getSqlQuery("sel_np_perappdup^"+strDet);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strflag = "Y";
					hshValues.put("PERAPP_ID",correctNull(rs.getString("PERAPP_ID")));
					strlapsid = correctNull(rs.getString("PERAPP_ID"));
					strName = correctNull(rs.getString("name"));
					hshValues.put("PERAPP_DOB",correctNull(rs.getString("PERAPP_DOB")));
					//hshValues.put("PERAPP_DRIVINGLICENCENUMBER",correctNull(rs.getString("PERAPP_DRIVINGLICENCENUMBER")));
					hshValues.put("PERAPP_AADHAAR",correctNull(rs.getString("PERAPP_AADHAAR")));
					hshValues.put("PERAPP_PANNO",strPAN);
				    //hshValues.put("PERAPP_VOTERID",correctNull(rs.getString("PERAPP_VOTERID")));
					hshValues.put("PERAPP_CBSID",correctNull(rs.getString("PERAPP_CBSID")));
					strcbs = correctNull(rs.getString("PERAPP_CBSID"));
					
				}else{
					strflag = "N";
				}}else{
					strflag = "N";
				}
		}else{
			
			if(!strPAN.equalsIgnoreCase(""))
			{
				strEncryptedpanNo  =  Helper.correctNull(AES_Encryption.AESencrypt(key,initVector,strPAN));
			}else{
				strEncryptedpanNo ="";
			}
			if(!strPAN.equalsIgnoreCase(""))
			{
				if(strDet.equalsIgnoreCase(""))
				{
					strDet = strDet + " upper(rtrim(ltrim(comapp_corpstructure)))=upper(rtrim(ltrim('"+strEncryptedpanNo+"')))";
				}else{
					strDet = strDet + " and upper(rtrim(ltrim(comapp_corpstructure)))=upper(rtrim(ltrim('"+strEncryptedpanNo+"')))";
				}
			}
			
			if(!stradhar.equalsIgnoreCase(""))
			{
				if(strDet.equalsIgnoreCase(""))
				{
				strDet = strDet + " upper(rtrim(ltrim(COMAPP_AADHARNO)))=upper(rtrim(ltrim('"+stradhar+"')))";
				}else{
				strDet = strDet + "and upper(rtrim(ltrim(COMAPP_AADHARNO)))=upper(rtrim(ltrim('"+stradhar+"')))";		
				}
			}
			
			if(!strdob.equalsIgnoreCase(""))
			{
				
				if(strDet.equalsIgnoreCase(""))
				{
				strDet = strDet + "  COMAPP_YRSINBUSINESS=to_date('"+strdob+"','dd/mm/yyyy')";
				}else{
				strDet = strDet + " and COMAPP_YRSINBUSINESS=to_date('"+strdob+"','dd/mm/yyyy')";		
				}
			}
			
			if(!strDet.equalsIgnoreCase("")){
			strQuery= SQLParser.getSqlQuery("select_npapp_dedupechk_lhdbs^"+strDet);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strflag = "Y";
				hshValues.put("PERAPP_ID",correctNull(rs.getString("PERAPP_ID")));
				strlapsid = correctNull(rs.getString("PERAPP_ID"));
				strName = correctNull(rs.getString("name"));
				hshValues.put("PERAPP_DOB",correctNull(rs.getString("PERAPP_DOB")));
				//hshValues.put("PERAPP_DRIVINGLICENCENUMBER",correctNull(rs.getString("PERAPP_DRIVINGLICENCENUMBER")));
				hshValues.put("PERAPP_AADHAAR",correctNull(rs.getString("PERAPP_AADHAAR")));
				hshValues.put("PERAPP_PANNO",strPAN);
				//hshValues.put("PERAPP_VOTERID",correctNull(rs.getString("PERAPP_VOTERID")));
				hshValues.put("PERAPP_CBSID",correctNull(rs.getString("PERAPP_CBSID")));
				strcbs = correctNull(rs.getString("PERAPP_CBSID"));
				
			}else{
				strflag = "N";
			}}else{
				strflag = "N";
			}
		}
				
			
			if(strDedupeflag.equalsIgnoreCase("U") || strDedupeflag.equalsIgnoreCase("N") || strDedupeflag.equalsIgnoreCase("D"))
			{
				if(strlapsid.equalsIgnoreCase(""))
				{
						strlapsid = Helper.correctNull((String)hshValues.get("hid_appid"));
				}
			}
			
			if(strDedupeflag.equalsIgnoreCase("U") || strDedupeflag.equalsIgnoreCase("N") || strDedupeflag.equalsIgnoreCase("D"))
			{
				strQuery= SQLParser.getSqlQuery("sel_np_dedupechk^"+strRef+"^"+Helper.correctNull((String)hshValues.get("hid_name")));
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					
					if(strDedupeflag.equalsIgnoreCase("U"))
					{
						arrValues.add("Y");
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_sel1")));
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_cbs")));
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_appid")));
						arrValues.add(strRef);
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_name")));
					}else if(strDedupeflag.equalsIgnoreCase("N"))
					{
						arrValues.add("N");
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_sel1")));
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_cbs")));
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_appid")));
						arrValues.add(strRef);
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_name")));
					}else{
						arrValues.add("Y");
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_sel1")));
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_cbs")));
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_appid")));
						arrValues.add(strRef);
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_name")));
					}
					
					hshQueryValues.put("size","1");
					if(strDedupeflag.equalsIgnoreCase("N"))
					{
						//hshQuery.put("strQueryId","delete_npUndoDedupe");
						hshQuery.put("strQueryId","update_npDedupe");
					}else{
						hshQuery.put("strQueryId","update_npDedupe");
					}
					System.out.print("arrValues----"+arrValues);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
				}else{
				
					hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					
					if(strDedupeflag.equalsIgnoreCase("U"))
					{
						arrValues.add(strRef);
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_name")));
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_appid")));
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_sel1")));
						arrValues.add("N");
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_cbs")));
						arrValues.add(strapptype);
					}else if(strDedupeflag.equalsIgnoreCase("D"))
					{
						arrValues.add(strRef);
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_name")));
						arrValues.add(strlapsid);
						arrValues.add("Y");
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_cbs")));
						arrValues.add(strapptype);
					}else
					{
						arrValues.add(strRef);
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_name")));
						arrValues.add(strlapsid);
						arrValues.add("N");
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_cbs")));
						arrValues.add(strapptype);
					}
					System.out.print("arrValues========="+arrValues);
					hshQueryValues.put("size","1");
					if(strDedupeflag.equalsIgnoreCase("U"))
					{
					hshQuery.put("strQueryId","insert_npDedupe");
					}else{
						hshQuery.put("strQueryId","insert_npDedupe1");	
					}
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				
				hshValues.put("strActionflag", strflag);			
			}else{
				
				hshValues.put("strActionflag", "N");			
			}
			hshValues.put("hid_dif",Helper.correctNull((String)hshValues.get("hid_dif")));
			hshValues.put("hid_col",Helper.correctNull((String)hshValues.get("hid_col")));
			hshValues.put("strDedupeflag", strDedupeflag);	
			hshValues = getNPDedupeChk(hshValues);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updateNPDedupeChk "+e.getMessage());	
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshValues;
	}
	
	
	public HashMap getNPSearchList(HashMap hshValues) 
	{
		ResultSet rs=null;
		String strQuery="";
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		String strSearchText = correctNull((String)hshValues.get("txt_ackname"));
		String strSearchFlag = correctNull((String)hshValues.get("NPflag"));
		String SegType=Helper.correctNull((String)hshValues.get("SegType"));
		try
		{
			//if(SegType.equalsIgnoreCase("BS") ||  SegType.equalsIgnoreCase("LHD") )
			if( SegType.equalsIgnoreCase("LHD"))
			{
			if(strSearchFlag.equalsIgnoreCase("CBS"))
			{				
				
				String key=ApplicationParams.getStrAadharkey();
				String initVector=ApplicationParams.getStrAadharvector();
				strSearchText  =  Helper.correctNull(AES_Encryption.AESencrypt(key,initVector,strSearchText));
				
				strSearchText = "CBS_COMPANYCODE = '"+strSearchText+"'";
			}else{
				strSearchText = "COMAPP_ID = '"+strSearchText+"'";
			}	
			}
			else
			{
			if(strSearchFlag.equalsIgnoreCase("CBS"))
			{
				String key=ApplicationParams.getStrAadharkey();
				String initVector=ApplicationParams.getStrAadharvector();
				strSearchText  =  Helper.correctNull(AES_Encryption.AESencrypt(key,initVector,strSearchText));
				
				strSearchText = "PERAPP_CBSID = '"+strSearchText+"'";
			}else{
				strSearchText = "PERAPP_ID = '"+strSearchText+"'";
			}
			}
			//if(SegType.equalsIgnoreCase("BS") ||  SegType.equalsIgnoreCase("LHD") )
			if(SegType.equalsIgnoreCase("LHD"))
			{
				strQuery= SQLParser.getSqlQuery("get_NPcbsid_BS^"+strSearchText);
				rs=DBUtils.executeQuery(strQuery); 
				if(rs.next())
				{
					String CBS_COMPANYCODE = correctNull(rs.getString("CBS_COMPANYCODE"));
					if(CBS_COMPANYCODE.length()<24)
					{
						CBS_COMPANYCODE = correctNull(rs.getString("CBS_COMPANYCODE"));
					}
					else
					{
						String strDecryptedCBSID="";
						String key=ApplicationParams.getStrAadharkey();
						String initVector=ApplicationParams.getStrAadharvector();
						strDecryptedCBSID = AES_Encryption.AESdecrypt(key,initVector,CBS_COMPANYCODE);
						CBS_COMPANYCODE = strDecryptedCBSID;
					}
					
					hshValues.put("PERAPP_CBSID", CBS_COMPANYCODE);
					hshValues.put("PERAPP_ID", correctNull(rs.getString("COMAPP_ID")));
					hshValues.put("NAME", correctNull(rs.getString("COMAPP_COMPANYNAME")));
				}	
			}
			else
			{
			strQuery= SQLParser.getSqlQuery("get_NPcbsid^"+strSearchText);
			rs=DBUtils.executeQuery(strQuery); 
			if(rs.next())
			{
				
				
				String CBS_COMPANYCODE = correctNull(rs.getString("PERAPP_CBSID"));
				if(CBS_COMPANYCODE.length()<24)
				{
					CBS_COMPANYCODE = correctNull(rs.getString("PERAPP_CBSID"));
				}
				else
				{
					String strDecryptedCBSID="";
					String key=ApplicationParams.getStrAadharkey();
					String initVector=ApplicationParams.getStrAadharvector();
					strDecryptedCBSID = AES_Encryption.AESdecrypt(key,initVector,CBS_COMPANYCODE);
					CBS_COMPANYCODE = strDecryptedCBSID;
				}
				
				hshValues.put("PERAPP_CBSID", CBS_COMPANYCODE);
				hshValues.put("PERAPP_ID", correctNull(rs.getString("PERAPP_ID")));
				hshValues.put("NAME", correctNull(rs.getString("name")));
			}
			}
			
			
		
		}
		catch(Exception ex)
		{
			Logger.log("Exception in getNPSearchList"+ex);
		}	
	return hshValues;
	}
	
	public HashMap getInprincipleDetails(HashMap hshValues) {
	
				
			
			ResultSet rs=null,rs1=null;
			String strQuery="";
			int sno=0;
			String strApplicationRefNo=Helper.correctNull((String) hshValues.get("strApplicationRefNo"));
			
			try
			{
				strQuery=SQLParser.getSqlQuery("sel_npInprincipaldat^"+strApplicationRefNo);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					
					hshValues.put("NPID_LOAN_AMT", Helper.correctNull(rs.getString("NPID_LOAN_AMT")));
					hshValues.put("NPID_SUBSIDY_AMT", Helper.correctNull(rs.getString("NPID_SUBSIDY_AMT")));
					hshValues.put("NPID_EMI", Helper.correctNull(rs.getString("NPID_EMI")));
					hshValues.put("NPID_ROI", Helper.correctNull(rs.getString("NPID_ROI")));
					hshValues.put("NPID_TENOR", Helper.correctNull(rs.getString("NPID_TENOR")));
					hshValues.put("NPID_PROCESS_FEE", Helper.correctNull(rs.getString("NPID_PROCESS_FEE")));
					hshValues.put("NPID_BRANCH_NAME", Helper.correctNull(rs.getString("NPID_BRANCH_NAME")));
					hshValues.put("NPID_BRANCH_CODE", Helper.correctNull(rs.getString("NPID_BRANCH_CODE")));
					hshValues.put("NPID_IFSC_CODE", Helper.correctNull(rs.getString("NPID_IFSC_CODE")));
					hshValues.put("NPID_CONTACT_NUM", Helper.correctNull(rs.getString("NPID_CONTACT_NUM")));
					hshValues.put("NPID_ADDRESS", Helper.correctNull(rs.getString("NPID_ADDRESS")));
					hshValues.put("NPID_JOURNEY_CMPLT_DT", Helper.correctNull(rs.getString("NPID_JOURNEY_CMPLT_DT")));
					
				}hshValues.put("strApplicationRefNo",strApplicationRefNo);
				
				if(rs != null)
				{
					rs.close();
				}	
				
			}
		catch(Exception ex)
		{
			Logger.log("Exception in getNpapplications"+ex);
		}	
	return hshValues;
	}
	
	public HashMap getNP_ApplicantDeatis(HashMap hshValues) 
	{
		ResultSet rs = null;
		String strQuery="";
		HashMap hshResult = new HashMap();
		String strApplicationRefNo=Helper.correctNull((String) hshValues.get("hidRefId"));
		if(strApplicationRefNo.equalsIgnoreCase(""))
		{
			strApplicationRefNo=Helper.correctNull((String) hshValues.get("hidApplicantId"));
		}
		if(strApplicationRefNo.equalsIgnoreCase(""))
		{
			strApplicationRefNo=Helper.correctNull((String) hshValues.get("strapprefid"));
		}
		if(strApplicationRefNo.equalsIgnoreCase(""))
		{
			strApplicationRefNo=Helper.correctNull((String) hshValues.get("strApplicationRefNo"));
		}
		hshResult.put("hidRefId",strApplicationRefNo);
		hshResult.put("Refno",strApplicationRefNo);
		try
		{
				strQuery = SQLParser.getSqlQuery("sel_npapplicationDetails1^"+strApplicationRefNo);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshResult.put("NPPD_SALUTATION", Helper.correctNull(rs.getString("NPPD_SALUTATION")));
					hshResult.put("NPPD_APPLICATION_REFERENCE_ID", Helper.correctNull(rs.getString("NPPD_APPLICATION_REFERENCE_ID")));
					hshResult.put("NPPD_FIRST_NAME", Helper.correctNull(rs.getString("NPPD_FIRST_NAME")));
					hshResult.put("NPPD_LAST_NAME", Helper.correctNull(rs.getString("NPPD_LAST_NAME")));
					hshResult.put("NPPD_MIDDLE_NAME", Helper.correctNull(rs.getString("NPPD_MIDDLE_NAME")));
					hshResult.put("NPPD_GENDER", Helper.correctNull(rs.getString("NPPD_GENDER")));
					hshResult.put("NPPD_DOB", Helper.correctNull(rs.getString("NPPD_DOB")));
					hshResult.put("NPPD_EMAIL", Helper.correctNull(rs.getString("NPPD_EMAIL")));
					hshResult.put("NPPD_SOCIAL_CATEGORY", Helper.correctNull(rs.getString("NPPD_SOCIAL_CATEGORY")));
					hshResult.put("NPPD_MOBILE_NUMBER", Helper.correctNull(rs.getString("NPPD_MOBILE_NUMBER")));
					hshResult.put("NPPD_MARITAL_STATUS", Helper.correctNull(rs.getString("NPPD_MARITAL_STATUS")));
					hshResult.put("NPPD_IS_CHAIRMAN", Helper.correctNull(rs.getString("NPPD_IS_CHAIRMAN")));
					hshResult.put("NPPD_RELATIONSHIP", Helper.correctNull(rs.getString("NPPD_RELATIONSHIP")));
					hshResult.put("NPPD_OCCUPATION", Helper.correctNull(rs.getString("NPPD_OCCUPATION")));
					hshResult.put("NPPD_GROSS_MONTHLY_INCOME", Helper.correctNull(rs.getString("NPPD_GROSS_MONTHLY_INCOME")));
					hshResult.put("NPPD_RESITANT_STATUS", Helper.correctNull(rs.getString("NPPD_RESITANT_STATUS")));
					hshResult.put("NPPD_VOTER_NO", Helper.correctNull(rs.getString("NPPD_VOTER_NO")));
					hshResult.put("NPPD_PAN_NO", Helper.correctNull(rs.getString("NPPD_PAN_NO")));
					hshResult.put("NPPD_IS_CURR_ADD_SAME", Helper.correctNull(rs.getString("NPPD_IS_CURR_ADD_SAME")));
					hshResult.put("NPPD_EDU_QUALIFICATION", Helper.correctNull(rs.getString("NPPD_EDU_QUALIFICATION")));
					//hshResult.put("NPPD_REMARKS", Helper.correctNull(rs.getString("NPPD_REMARKS")));
					hshResult.put("NPPD_MARKS", Helper.correctNull(rs.getString("NPPD_MARKS")));
					String StrOffadd= Helper.correctNull(rs.getString("NPPD_MARKS"));
					String StrAadharadd= Helper.correctNull(rs.getString("NPPD_MARKS"));
				
				if(!StrAadharadd.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strApplicationRefNo+"^"+StrAadharadd);
					rs = DBUtils.executeQuery(strQuery);			
					if(rs.next())
					{
						
						hshResult.put("NPAA_STREET_NAME", Helper.correctNull(rs.getString("NPAD_STREET_NAME")));
						hshResult.put("NPAA_LAND_MARK", Helper.correctNull(rs.getString("NPAD_LANDMARK")));
						hshResult.put("NPAA_VILLAGE", Helper.correctNull(rs.getString("NPAD_VILLAGE")));
						hshResult.put("NPAA_SUB_DISTRICT", Helper.correctNull(rs.getString("NPAD_SUB_DISTRICT")));
						hshResult.put("NPAA_DISTRICT_NAME", Helper.correctNull(rs.getString("NPAD_DISTRICT_NAME")));
						hshResult.put("NPAA_STATE_NAME", Helper.correctNull(rs.getString("NPAD_STATE_NAME")));
						hshResult.put("NPAA_CITY_NAME", Helper.correctNull(rs.getString("NPAD_CITY_NAME")));
						hshResult.put("NPAA_PIN_CODE", Helper.correctNull(rs.getString("NPAD_PIN_CODE")));
						hshResult.put("NPAA_COUNTRY_NAME", Helper.correctNull(rs.getString("NPAD_COUNTRY_NAME")));
						
					}
				}
				if(!StrOffadd.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strApplicationRefNo+"^"+StrOffadd);
					rs = DBUtils.executeQuery(strQuery);			
					if(rs.next())
					{
						hshResult.put("NPOA_STREET_NAME", Helper.correctNull(rs.getString("NPAD_STREET_NAME")));
						hshResult.put("NPOA_LANDMARK", Helper.correctNull(rs.getString("NPAD_LANDMARK")));
						hshResult.put("NPOA_VILLAGE", Helper.correctNull(rs.getString("NPAD_VILLAGE")));
						hshResult.put("NPOA_SUB_DISTRICT", Helper.correctNull(rs.getString("NPAD_SUB_DISTRICT")));
						hshResult.put("NPOA_DISTRICT_NAME", Helper.correctNull(rs.getString("NPAD_DISTRICT_NAME")));
						hshResult.put("NPOA_CITY_NAME", Helper.correctNull(rs.getString("NPAD_CITY_NAME")));
						hshResult.put("NPOA_PIN_CODE", Helper.correctNull(rs.getString("NPAD_PIN_CODE")));
						hshResult.put("NPOA_STATE_NAME", Helper.correctNull(rs.getString("NPAD_STATE_NAME")));
						hshResult.put("NPOA_COUNTRY_NAME", Helper.correctNull(rs.getString("NPAD_COUNTRY_NAME")));
					}	
				}
				}
				strQuery=SQLParser.getSqlQuery("sel_npemploy^"+strApplicationRefNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshResult.put("NPPD_EMP_TYPE", Helper.correctNull(rs.getString("NPPD_EMP_TYPE")));
					hshResult.put("NPPD_ORG_TYPE", Helper.correctNull(rs.getString("NPPD_ORG_TYPE")));
					hshResult.put("NPPD_ORG_NAME", Helper.correctNull(rs.getString("NPPD_ORG_NAME")));
					hshResult.put("NPPD_DESIGNATION", Helper.correctNull(rs.getString("NPPD_DESIGNATION")));
					hshResult.put("NPPD_WORKING_SINCE_YEAR", Helper.correctNull(rs.getString("NPPD_WORKING_SINCE_YEAR")));
					hshResult.put("NPPD_WORKING_SINCE_MONTH", Helper.correctNull(rs.getString("NPPD_WORKING_SINCE_MONTH")));
					hshResult.put("NPPD_RETIRE_AGE", Helper.correctNull(rs.getString("NPPD_RETIRE_AGE")));
					hshResult.put("NPPD_BUSS_ESTA_YEAR", Helper.correctNull(rs.getString("NPPD_BUSS_ESTA_YEAR")));
					hshResult.put("NPPD_BUSS_ESTA_MONTH", Helper.correctNull(rs.getString("NPPD_BUSS_ESTA_MONTH")));
					hshResult.put("NPPD_CURR_BUSS_YEAR", Helper.correctNull(rs.getString("NPPD_CURR_BUSS_YEAR")));
				}
				hshResult.put("strApplicationRefNo",strApplicationRefNo);
		}
		catch(Exception ex)
		{
			Logger.log("Exception in getNpapplications"+ex);
		}	
	return hshResult;
	}
	public HashMap getNP_Education(HashMap hshValues) 
	{
		ResultSet rs = null;
		String strQuery="";
		HashMap hshResult = new HashMap();
		ArrayList arrRow = new ArrayList();
		ArrayList arrRec = new ArrayList();
		ArrayList arrCol = new ArrayList();
		ArrayList arrRec1 = new ArrayList();
		String strApplicationRefNo=Helper.correctNull((String) hshValues.get("strApplicationRefNo"));
		
		try
		{
			
			
			strQuery = SQLParser.getSqlQuery("sel_npeducation^"+strApplicationRefNo);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("NPED_INSITITUTE_NAME")));
				arrCol.add(Helper.correctNull(rs.getString("NPED_YEAR")));
				arrCol.add(Helper.correctNull(rs.getString("NPED_MARKS")));
				arrCol.add(Helper.correctNull(rs.getString("NPED_NO_OF_ATTEMPTS")));
				arrCol.add(Helper.correctNull(rs.getString("NPED_CLASS_OBTAINED")));
				arrCol.add(Helper.correctNull(rs.getString("NPED_SPECIALIZATION")));
				arrRow.add(arrCol);
			}
			hshResult.put("arrRow", arrRow);
			if(rs!=null){rs.close();}
			strQuery = SQLParser.getSqlQuery("sel_npsecuritydet^"+strApplicationRefNo);
			rs = DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("NPSD_SEC_TYPE")));
				arrCol.add(Helper.correctNull(rs.getString("NPSD_SEC_AMOUNT")));
				arrRec.add(arrCol);
			}
			hshResult.put("arrRec", arrRec);
			
			if(rs!=null){rs.close();}
			strQuery = SQLParser.getSqlQuery("sel_npscholarshpdetails^"+strApplicationRefNo);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("NPSCL_SCHOLARSHIP_FIELD")));
				arrCol.add(Helper.correctNull(rs.getString("NPSCL_SCHOLARSHIP_NAME")));
				arrCol.add(Helper.correctNull(rs.getString("NPSCL_SCHOLARSHIP_AMOUNT")));
				arrCol.add(Helper.correctNull(rs.getString("NPSCL_SEQ_NO")));
				arrCol.add("Yes");
				arrRec1.add(arrCol);
			}
			hshResult.put("arrRec1", arrRec1);
			hshResult.put("strApplicationRefNo",strApplicationRefNo);
		}
		catch(Exception ex)
		{
			Logger.log("Exception in getNpapplications"+ex);
		}
		
		
	return hshResult;
	}
	public HashMap getNP_CourseDetails(HashMap hshValues) 
	{
		ResultSet rs = null;
		String strQuery="";
		HashMap hshResult = new HashMap();
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = new ArrayList();
		
		String strApplicationRefNo=Helper.correctNull((String) hshValues.get("strApplicationRefNo"));
		String strSno=Helper.correctNull((String) hshValues.get("hidsno"));
		try
		{
			strQuery = SQLParser.getSqlQuery("sel_npCourseDetails^"+strApplicationRefNo);
			
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshResult.put("NPCD_COURSE_NAME", Helper.correctNull(rs.getString("NPCD_COURSE_NAME")));
					hshResult.put("NPCD_UNIV_NAME", Helper.correctNull(rs.getString("NPCD_UNIV_NAME")));
					hshResult.put("NPCD_QUOTA_SELE", Helper.correctNull(rs.getString("NPCD_QUOTA_SELE")));
					hshResult.put("NPCD_INSIT_NAME", Helper.correctNull(rs.getString("NPCD_INSIT_NAME")));
					hshResult.put("NPCD_INSIT_LOC", Helper.correctNull(rs.getString("NPCD_INSIT_LOC")));
					
					hshResult.put("NPCD_TYPE_OF_COURSE", Helper.correctNull(rs.getString("NPCD_TYPE_OF_COURSE")));
					hshResult.put("NPCD_COURSE_START_DATE", Helper.correctNull(rs.getString("NPCD_COURSE_START_DATE")));
					hshResult.put("NPCD_COURSE_END_DATE", Helper.correctNull(rs.getString("NPCD_COURSE_END_DATE")));
					hshResult.put("NPCD_COURSE_DURATION", Helper.correctNull(rs.getString("NPCD_COURSE_DURATION")));
					hshResult.put("NPCD_APPLICANT_CONTRIBUTION", Helper.correctNull(rs.getString("NPCD_APPLICANT_CONTRIBUTION")));
					hshResult.put("NPCD_LOAN_AMT_REQ", Helper.correctNull(rs.getString("NPCD_LOAN_AMT_REQ")));
					hshResult.put("NPCD_IS_REPAY_INTEREST", Helper.correctNull(rs.getString("NPCD_IS_REPAY_INTEREST")));
					hshResult.put("NPCD_IS_SECURITY", Helper.correctNull(rs.getString("NPCD_IS_SECURITY")));
					hshResult.put("NPCD_REPAYMENT_BY", Helper.correctNull(rs.getString("NPCD_REPAYMENT_BY")));
					hshResult.put("NPCD_TENURE", Helper.correctNull(rs.getString("NPCD_TENURE")));
					
					hshResult.put("NPCD_AMOUNT", Helper.correctNull(rs.getString("NPCD_AMOUNT")));
					hshResult.put("NPCD_PASSPORT_OBTAINED", Helper.correctNull(rs.getString("NPCD_PASSPORT_OBTAINED")));
					hshResult.put("NPCD_PASSPORT_NO", Helper.correctNull(rs.getString("NPCD_PASSPORT_NO")));
					hshResult.put("NPCD_IS_PART_TIME_EMP", Helper.correctNull(rs.getString("NPCD_IS_PART_TIME_EMP")));
					hshResult.put("NPCD_EMPLOYEMENT_DESC", Helper.correctNull(rs.getString("NPCD_EMPLOYEMENT_DESC")));
					hshResult.put("NPCD_IS_SCHOLARSHIP_AVAILED", Helper.correctNull(rs.getString("NPCD_IS_SCHOLARSHIP_AVAILED")));
				}
		
				hshResult.put("strApplicationRefNo",strApplicationRefNo);
			
				
				strQuery = SQLParser.getSqlQuery("sel_npCourseDetailsforsno^"+strApplicationRefNo);
				rs = DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(Helper.correctNull(rs.getString("NPCC_COURSE_SEQ")));
					arrCol.add(Helper.correctNull(rs.getString("NPCC_COURSE_TYPE")));
					arrCol.add(Helper.correctNull(rs.getString("NPCC_COURSE_YEAR")));
					arrCol.add(Helper.correctNull(rs.getString("NPCC_COURSE_AMOUNT")));
					arrRow.add(arrCol);
				}
				hshResult.put("arrRow", arrRow);
		}
		catch(Exception ex)
		{
			Logger.log("Exception in getNpapplications"+ex);
		}
		
	return hshResult;
	}
	public HashMap getNP_Document(HashMap hshValues) 
	{
		ResultSet rs = null;
		String strQuery="";
		HashMap hshResult = new HashMap();
		ArrayList arrRec = new ArrayList();
		ArrayList arrCol = new ArrayList();
		String strApplicationRefNo=Helper.correctNull((String) hshValues.get("strApplicationRefNo"));
		
		try
		{
			strQuery = SQLParser.getSqlQuery("sel_npdocuments^"+strApplicationRefNo);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("NPUD_APP_REFER_ID")));
				arrCol.add(Helper.correctNull(rs.getString("NPUD_DOC_TYPE")));
				arrCol.add(Helper.correctNull(rs.getString("NPUD_APP_TYPE")));
				arrCol.add(Helper.correctNull(rs.getString("NPUD_DOCUMENT")));
				arrRec.add(arrCol);
			}
			hshResult.put("arrRec", arrRec);
			hshResult.put("strApplicationRefNo",strApplicationRefNo);
		}
		catch(Exception ex)
		{
			Logger.log("Exception in getNpapplications"+ex);
		}
		
	return hshResult;
	}
	
	public HashMap getNP_CoApplicantDeatils(HashMap hshValues) 
	{
		ResultSet rs = null;
		ResultSet rs1 = null;
		String strQuery="";
		HashMap hshResult = new HashMap();
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		ArrayList arrEmpRec = new ArrayList();
		String strApplicationRefNo=Helper.correctNull((String) hshValues.get("strApplicationRefNo"));
		
		try
		{
				strQuery = SQLParser.getSqlQuery("sel_npcoapplicationDetails^"+strApplicationRefNo);
				rs = DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(Helper.correctNull(rs.getString("NPCD_SALUTATION")));
					arrCol.add(Helper.correctNull(rs.getString("NPCD_APPLICATION_REFERENCE_ID")));
					arrCol.add(Helper.correctNull(rs.getString("NPCD_FNAME")));
					arrCol.add(Helper.correctNull(rs.getString("NPCD_MNAME")));
					arrCol.add(Helper.correctNull(rs.getString("NPCD_LNAME")));
					arrCol.add(Helper.correctNull(rs.getString("NPCD_GENDER")));
					arrCol.add(Helper.correctNull(rs.getString("NPCD_DOB")));
					arrCol.add(Helper.correctNull(rs.getString("NPCD_EMAIL")));
					arrCol.add(Helper.correctNull(rs.getString("NPCD_SOCIAL_CAT")));
					arrCol.add(Helper.correctNull(rs.getString("NPCD_MOBILE")));
					arrCol.add(Helper.correctNull(rs.getString("NPCD_MARITAL_STAT")));
					String StrAadharadd=Helper.correctNull(rs.getString("NPCD_AADHAR_ADD_SEQ"));
					String StrOffadd=Helper.correctNull(rs.getString("NPCD_OFFICE_ADD_SEQ"));
					
					if(!StrAadharadd.equalsIgnoreCase("")){
						strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strApplicationRefNo+"^"+StrAadharadd);
						rs1 = DBUtils.executeQuery(strQuery);			
						if(rs1.next())
						{
							arrCol.add(Helper.correctNull(rs1.getString("NPAD_STREET_NAME")));
							arrCol.add( Helper.correctNull(rs1.getString("NPAD_LANDMARK")));
							arrCol.add(Helper.correctNull(rs1.getString("NPAD_VILLAGE")));
							arrCol.add(Helper.correctNull(rs1.getString("NPAD_SUB_DISTRICT")));
							arrCol.add(Helper.correctNull(rs1.getString("NPAD_DISTRICT_NAME")));
							arrCol.add(Helper.correctNull(rs1.getString("NPAD_CITY_NAME")));
							arrCol.add(Helper.correctNull(rs1.getString("NPAD_PIN_CODE")));
							arrCol.add(Helper.correctNull(rs1.getString("NPAD_STATE_NAME")));
							arrCol.add(Helper.correctNull(rs1.getString("NPAD_COUNTRY_NAME")));
						}else{
							arrCol.add("");
							arrCol.add("");
							arrCol.add("");
							arrCol.add("");
							arrCol.add("");
							arrCol.add("");
							arrCol.add("");
							arrCol.add("");
							arrCol.add("");
						}
					}else{
						arrCol.add("");
						arrCol.add("");
						arrCol.add("");
						arrCol.add("");
						arrCol.add("");
						arrCol.add("");
						arrCol.add("");
						arrCol.add("");
						arrCol.add("");
					}
					
				if(!StrOffadd.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strApplicationRefNo+"^"+StrOffadd);
					rs1 = DBUtils.executeQuery(strQuery);			
					if(rs1.next())
					{
						arrCol.add(Helper.correctNull(rs1.getString("NPAD_STREET_NAME")));
						arrCol.add(Helper.correctNull(rs1.getString("NPAD_LANDMARK")));
						arrCol.add(Helper.correctNull(rs1.getString("NPAD_VILLAGE")));
						arrCol.add(Helper.correctNull(rs1.getString("NPAD_SUB_DISTRICT")));
						arrCol.add(Helper.correctNull(rs1.getString("NPAD_DISTRICT_NAME")));
						arrCol.add(Helper.correctNull(rs1.getString("NPAD_CITY_NAME")));
						arrCol.add(Helper.correctNull(rs1.getString("NPAD_PIN_CODE")));
						arrCol.add(Helper.correctNull(rs1.getString("NPAD_STATE_NAME")));
						arrCol.add(Helper.correctNull(rs1.getString("NPAD_COUNTRY_NAME")));
					}else{
						arrCol.add("");
						arrCol.add("");
						arrCol.add("");
						arrCol.add("");
						arrCol.add("");
						arrCol.add("");
						arrCol.add("");
						arrCol.add("");
						arrCol.add("");
					}
					}else{
						arrCol.add("");
						arrCol.add("");
						arrCol.add("");
						arrCol.add("");
						arrCol.add("");
						arrCol.add("");
						arrCol.add("");
						arrCol.add("");
						arrCol.add("");
					}
					
					arrCol.add(Helper.correctNull(rs.getString("NPCD_EMPLOY_TYPE")));//29
					arrCol.add(Helper.correctNull(rs.getString("NPCD_MON_INCOME")));//30
					arrCol.add(Helper.correctNull(rs.getString("NPCD_RESI_TYPE")));//31
					arrCol.add(Helper.correctNull(rs.getString("NPCD_IS_CUR_ADDR")));//32
					arrCol.add(Helper.correctNull(rs.getString("NPCD_EDU_QUALIFY")));
					
					arrRow.add(arrCol);
					ArrayList arrEmpCol = new ArrayList(); 
					arrEmpCol.add(Helper.correctNull(rs.getString("NPCD_EMPLOY_TYPE")));
					arrEmpCol.add("");//orgtype
					arrEmpCol.add(Helper.correctNull(rs.getString("NPCD_ORG_NAME")));
					arrEmpCol.add(Helper.correctNull(rs.getString("NPCD_DESIGNATION")));
					arrEmpCol.add(Helper.correctNull(rs.getString("NPCD_WORK_SINCE")));
					arrEmpCol.add(Helper.correctNull(rs.getString("NPCD_WORK_SINCE_MON")));
					arrEmpCol.add(Helper.correctNull(rs.getString("NPCD_RETIRE_AGE")));
					arrEmpCol.add(Helper.correctNull(rs.getString("NPCD_BUSI_EST_YR")));
					arrEmpCol.add(Helper.correctNull(rs.getString("NPCD_CUR_BUSI_MON")));
					arrEmpCol.add(Helper.correctNull(rs.getString("NPCD_YRS_CUR_BUSI")));
					arrEmpRec.add(arrEmpCol);
				}
				hshResult.put("arrRow", arrRow);
				hshResult.put("arrEmpRec", arrEmpRec);
				hshResult.put("strApplicationRefNo",strApplicationRefNo);
		}
		catch(Exception ex)
		{
			Logger.log("Exception in getNpapplications"+ex);
		}
		finally{
			if(rs!=null){try {
				rs.close();
			} catch (java.sql.SQLException e) {
				e.printStackTrace();
			}}
		}
	return hshResult;
	}
	private String getNPtoLAPSCommonLOV1(String strscheme,String strsegment,String strparamId,String strschemetype) 
	{
		 ResultSet rs = null;
		 String strQuery = "";
		 String strlapsoptionval = "";
		 
		 try{
			 //strQuery = SQLParser.getSqlQuery("np_commonlovdet11^"+strscheme+"^"+strsegment+"^"+strparamId+"^"+strschemetype);
			 strQuery = SQLParser.getSqlQuery("sel_nplistofval^"+strsegment+"^"+strscheme+"^"+strparamId);
			 rs = DBUtils.executeQuery(strQuery);
			 if (rs.next()) 
			 {
				 strlapsoptionval = Helper.correctNull((String)rs.getString("NPCL_LOVVAL"));
			 }
		 }
		 catch(Exception ce)
		 {
			 throw new EJBException("Error in getNPtoLAPSCommonLOV" + ce.toString());
		 }
		 finally 
		 {
			try 
			{
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection " 	+ cf.getMessage());
			}
		 }
		 return strlapsoptionval;
	}
	private String getNPtoLAPSCommonLOV(String strscheme,String strsegment,String strparamId) 
	{
		 ResultSet rs = null;
		 String strQuery = "";
		 String strlapsoptionval = "";
		 
		 try{
			 strQuery = SQLParser.getSqlQuery("np_commonlovdet^"+strscheme+"^"+strsegment+"^"+strparamId);
			 rs = DBUtils.executeQuery(strQuery);
			 if (rs.next()) 
			 {
				 strlapsoptionval = Helper.correctNull((String)rs.getString("NPCL_LOVVAL"));
			 }
		 }
		 catch(Exception ce)
		 {
			 throw new EJBException("Error in getNPtoLAPSCommonLOV" + ce.toString());
		 }
		 finally 
		 {
			try 
			{
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection " 	+ cf.getMessage());
			}
		 }
		 return strlapsoptionval;
	}
	public HashMap getNPCustProfileCreation(HashMap hshValues) 
	{
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs3 = null;
		HashMap hshRecord = new HashMap();
		HashMap hsh = new HashMap();
		String strQuery = "",strquery1="";
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		HashMap hshQueryValues = new HashMap();
		String strbranchcode=Helper.correctNull((String)hshValues.get("strOrgShortCode"));
		String strusrid=Helper.correctNull((String)hshValues.get("strUserId"));
		String strStatus=Helper.correctNull((String)hshValues.get("hidaction"));
		String strRefno = Helper.correctNull((String)hshValues.get("hidRefId"));
		if(strRefno.equalsIgnoreCase("")){
		 strRefno = Helper.correctNull((String)hshValues.get("hidApplicantId"));
		}
		String selsegment = Helper.correctNull((String)hshValues.get("selsegment"));
		if(selsegment.equalsIgnoreCase("")){
			selsegment = Helper.correctNull((String)hshValues.get("SegType"));
		}
		
		
		MastApplicantBean CustPrfAppID = new MastApplicantBean();
		String LapsAppid="";
		HashMap hshappcr = new HashMap();

		try
		{		
			String strappcoappid="";
			String StrName1="",strNewapp="",strLapsid="",strCbsid="";
			
			
			strQuery = SQLParser.getSqlQuery("seldedupecheck_np^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				strLapsid=Helper.correctNull((String)rs.getString("NP_LAPSID"));
				strNewapp=Helper.correctNull((String)rs.getString("NP_ISNEW"));
				strCbsid=Helper.correctNull((String)rs.getString("NP_CBSID"));
				StrName1=Helper.correctNull((String)rs.getString("NP_APPLICANTNAME"));
			}
			
			String StrOffadd="",StrCut_add="";
			if(strNewapp.equalsIgnoreCase("Y") || strNewapp.equalsIgnoreCase(""))
			{
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","ins_npcustprofile");	
			strQuery = SQLParser.getSqlQuery("sel_nppersonaldetails^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_FIRST_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_FIRST_NAME"))+" "+Helper.correctNull((String)rs.getString("NPPD_LAST_NAME")));
				//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MIDDLE_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_LAST_NAME")));
				arrValues.add(getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("NPPD_GENDER"))));
				/*String strgender=Helper.correctNull((String)rs.getString("NPPD_GENDER"));
				if(strgender.equalsIgnoreCase("Male"))
				{
				arrValues.add("M");	
				}
				else
				{
				arrValues.add("F");
				}*/
				
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_DOB")));
				//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_EMAIL")));
				//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_SOCIAL_CATEGORY")));				
				//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MOBILE_NUMBER")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_FATHERS_NAME")));
				//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MOTHERS_NAME")));
				//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MOTHERS_NAME")));
				arrValues.add(getNPtoLAPSListOfValue("4",Helper.correctNull((String)rs.getString("NPPD_SALUTATION"))));
				arrValues.add(getNPtoLAPSListOfValue("5",Helper.correctNull((String)rs.getString("NPPD_MARITAL_STATUS"))));
				/*String strtitle=Helper.correctNull((String)rs.getString("NPPD_SALUTATION"));
				if(strtitle.equalsIgnoreCase("Mrs."))
				{
				arrValues.add("MRS");	
				}
				else if(strtitle.equalsIgnoreCase("Mr."))
				{
				arrValues.add("MR");
				}
				else
				{
				arrValues.add("");
				}*/
				/*String strstatus=Helper.correctNull((String)rs.getString("NPPD_MARITAL_STATUS"));
				if(strstatus.equalsIgnoreCase("Married"))
				{
				arrValues.add("MARID");	
				}
				else
				{
				arrValues.add("SINGL");
				}*/
				//arrValues.add(getNPtoLAPSListOfValue("7",Helper.correctNull((String)rs.getString("NPPD_EDU_QUALIFICATION"))));
				//arrValues.add(getNPtoLAPSListOfValue("6",Helper.correctNull((String)rs.getString("NPPD_EMP_TYPE"))));
				//arrValues.add(getNPtoLAPSListOfValue("8",Helper.correctNull((String)rs.getString("NPPD_RESITANT_STATUS"))));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_EMP_TYPE")));	
				arrValues.add("001");	
				//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_RESITANT_STATUS")));	
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_PAN_NO")));				
				//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_VOTER_NO")));
				//arrValues.add("");
				//arrValues.add("");
				//arrValues.add(strbranchcode);
				/*arrValues.add(getNPtoLAPSCommonLOV(Helper.correctNull((String)hshValues.get("SchemeName")),
						Helper.correctNull((String)hshValues.get("selsegment")),"CUSTPRFSTATUS"));*/
				arrValues.add("Y");
				
				//arrValues.add(Helper.correctNull((String)hshValues.get("strOrgbankFlag")));
				LapsAppid = CustPrfAppID.getApplicantCode();
				arrValues.add(LapsAppid);
				arrValues.add(LapsAppid);
				strappcoappid = Helper.correctNull((String)rs.getString("NPPD_APPID"));
				
				StrOffadd = Helper.correctNull((String)rs.getString("NPPD_CURR_ADD_SEQ_NO"));
				StrCut_add = Helper.correctNull((String)rs.getString("NPPD_AADHAR_ADD_SEQ_NO"));
				arrValues.add(strbranchcode);
				arrValues.add("099");
				
				
			}
			/*if(rs != null){rs.close();}
			if(!StrCut_add.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrCut_add);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_VILLAGE")));
				
				String city=Helper.correctNull((String)rs.getString("NPAD_CITY_NAME"));
				String state=Helper.correctNull((String)rs.getString("NPAD_STATE_NAME"));
				if(!state.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
				rs3 = DBUtils.executeQuery(strQuery);			
				if(rs3.next())
				{
					arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
				}else{
					arrValues.add("");
				}
				}else{
					arrValues.add("");
				}
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_COUNTRY_NAME")));
				if(!city.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_city_name^"+city);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
				
				
			}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}}else{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
	
			}
			if(rs != null){rs.close();}
			if(!StrOffadd.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_VILLAGE")));
				String city=Helper.correctNull((String)rs.getString("NPAD_CITY_NAME"));
				String state=Helper.correctNull((String)rs.getString("NPAD_STATE_NAME"));
				if(!state.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
				rs3 = DBUtils.executeQuery(strQuery);			
				if(rs3.next())
				{
					arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
				}else{
					arrValues.add("");
				}
				}else{
					arrValues.add("");
				}
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_COUNTRY_NAME")));
				if(!city.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_city_name^"+city);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
			}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				
			}}else{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}
			arrValues.add("");*/
			System.out.print("arrValues cust profile --"+arrValues);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
			
			
			
			//DEDUPE LEVEL UPDATE
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","updperappid_np");	
			arrValues.add(LapsAppid);	
			arrValues.add(strRefno);
			arrValues.add(StrName1);
			System.out.print("arrValues dedupe old id --"+arrValues);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			
			
			
			
			//Insertion for Employment Details
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","ins_npempdetails1");	
			arrValues.add(LapsAppid);
			strQuery = SQLParser.getSqlQuery("sel_nppersonaldetails^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_ORG_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MOBILE_NUMBER")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_EMAIL")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_DESIGNATION")));
				arrValues.add("A");
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_RETIRE_AGE")));
				strappcoappid = Helper.correctNull((String)rs.getString("NPPD_APPID"));
				StrOffadd = Helper.correctNull((String)rs.getString("NPPD_CURR_ADD_SEQ_NO"));
				
				
				
			}
			arrValues.add("");
			//arrValues.add("");
			//arrValues.add("0");
			if(rs != null){rs.close();}
			if(!StrOffadd.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
				//arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME")));
				String district=Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME"));
				//District Code added by kannan
				if(!district.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_District_Name^"+district);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("DISTRICT_CODE")));
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_VILLAGE")));
				String city=Helper.correctNull((String)rs.getString("NPAD_CITY_NAME"));
				String state=Helper.correctNull((String)rs.getString("NPAD_STATE_NAME"));
				if(!state.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
				if(!city.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				
			

				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
			}	
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}}else{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}
			System.out.print("arrValues employment details --"+arrValues);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
			
			
			Double grossincome=0.0;
			String grossincome1="0",net_monthly_income="0",earnemi="0",emi="0";
			strquery1 = SQLParser.getSqlQuery("getEligibilityDetails^"+strRefno);
			rs1 = DBUtils.executeQuery(strquery1);			
			if(rs1.next())
			{
				 grossincome1=Helper.correctNull((String)rs1.getString("EPD_GROSSMONTHLYINCOME"));
				  net_monthly_income=Helper.correctNull((String)rs1.getString("EPD_NETMONTLYINCOME"));
				  earnemi=Helper.correctNull((String)rs1.getString("EPD_INCOMEFOREMI"));
				  emi=Helper.correctNull((String)rs1.getString("EPD_EMI"));
				
				 if(grossincome1.equalsIgnoreCase("")){
					 grossincome1="0";
				 }
				 if(earnemi.equalsIgnoreCase("")){
					 earnemi="0";
				 }
				 grossincome=Double.valueOf(grossincome1)+Double.valueOf(earnemi);
				 
			}
			//income and expence
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","ins_incomeexpeneperagriapp_np");
			arrValues.add(LapsAppid);	
			arrValues.add(String.valueOf(grossincome));
			arrValues.add((net_monthly_income));
			arrValues.add((emi));
			arrValues.add("A");
			arrValues.add("1");
			System.out.print("arrValues income details --"+arrValues);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
			
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","upd_nplapsappid");	
			arrValues.add(LapsAppid);	
			arrValues.add(strRefno);			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			
			
			
			}else{
				
				//ex.application creation for applicant
				
				String strOldAppId=strLapsid;
				String strAppCode = CustPrfAppID.getApplicantCode();
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				arrValues.add(strAppCode);
				arrValues.add(strAppCode);
				arrValues.add("n");
				arrValues.add(Helper.correctNull((String)hshValues.get("strOrgShortCode")));
				arrValues.add(strOldAppId);	
				//arrValues.add(strOldAppId);	
				System.out.print("arrValues perapplication  --"+arrValues);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","perapplicantrenew1");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
				
				
				// update renew column in perapplicant table
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				arrValues.add("y");
				arrValues.add(strOldAppId);
				System.out.print("arrValues perapplication1 --"+arrValues);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","perapplicantupdaterenew");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
				// insert data in to perincexpences table
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				arrValues.add(strAppCode);
				arrValues.add(strOldAppId);
				System.out.print("arrValues income  --"+arrValues);
				
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","perincomerenew");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
				// insert data in to peremployer table
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				arrValues.add(strAppCode);
				arrValues.add(strOldAppId);
				System.out.print("arrValues employment  --"+arrValues);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","peremployerrenew");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
			arrValues=new ArrayList();
				hshQuery=new HashMap();			
				arrValues.add(strOldAppId);
				arrValues.add(strAppCode);
				System.out.print("arrValues ins_perapplicant_idmap  --"+arrValues);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_perapplicant_idmap");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
				
				
				// insert data in to KYC norms table
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				arrValues.add(strAppCode);
				arrValues.add(strOldAppId);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","kycnormsrenew");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");			
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
				
				
				//update nationalportal data
				String strgender="",stremployeestatus="";
				
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_npcustprofile");					
				strQuery = SQLParser.getSqlQuery("sel_nppersonaldetails^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_FIRST_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_FIRST_NAME"))+" "+Helper.correctNull((String)rs.getString("NPPD_LAST_NAME")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MIDDLE_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_LAST_NAME")));
					arrValues.add(getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("NPPD_GENDER"))));
					/*strgender=Helper.correctNull((String)rs.getString("NPPD_GENDER"));
					if(strgender.equalsIgnoreCase("Male"))
					{
					arrValues.add("M");	
					}
					else
					{
					arrValues.add("F");
					}*/
					
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_DOB")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPCD_EMAIL")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPCD_SOCIAL_CAT")));				
					//arrValues.add(Helper.correctNull((String)rs.getString("NPCD_MOBILE")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_FATHERS_NAME")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPCD_MOTHER_NAME")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPCD_MOTHER_NAME")));
					arrValues.add(getNPtoLAPSListOfValue("4",Helper.correctNull((String)rs.getString("NPPD_SALUTATION"))));
					arrValues.add(getNPtoLAPSListOfValue("5",Helper.correctNull((String)rs.getString("NPPD_MARITAL_STATUS"))));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPCD_SALUTATION")));
					/*String strtitle=Helper.correctNull((String)rs.getString("NPPD_SALUTATION"));
					if(strtitle.equalsIgnoreCase("Mrs."))
					{
					arrValues.add("MRS");	
					}
					else if(strtitle.equalsIgnoreCase("Mr."))
					{
					arrValues.add("MR");
					}
					else
					{
					arrValues.add("");
					}*/
					/*String strstatus=Helper.correctNull((String)rs.getString("NPPD_MARITAL_STATUS"));
					if(strstatus.equalsIgnoreCase("Married"))
					{
					arrValues.add("MARID");	
					}
					else
					{
					arrValues.add("SINGL");
					}*/
					//arrValues.add(getNPtoLAPSListOfValue("7",Helper.correctNull((String)rs.getString("NPCD_EDU_QUALIFY"))));
					arrValues.add(getNPtoLAPSListOfValue("6",Helper.correctNull((String)rs.getString("NPPD_EMP_TYPE"))));
					//arrValues.add(getNPtoLAPSListOfValue("8",Helper.correctNull((String)rs.getString("NPCD_RESI_TYPE"))));	
					/*stremployeestatus=Helper.correctNull((String)rs.getString("NPPD_EMP_TYPE"));	
					if(stremployeestatus.equalsIgnoreCase("Others"))
					{
					arrValues.add("11");	
					}
					else
					{
					arrValues.add("");
					}*/
					arrValues.add("003");
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_PAN_NO")));				
					//arrValues.add("");
					//arrValues.add("");
					//arrValues.add("");
					//arrValues.add(strbranchcode);
					arrValues.add(getNPtoLAPSCommonLOV(Helper.correctNull((String)hshValues.get("SchemeName")),
							Helper.correctNull((String)hshValues.get("selsegment")),"CUSTPRFSTATUS"));
					//arrValues.add(Helper.correctNull((String)hshValues.get("strOrgbankFlag")));
					arrValues.add(strAppCode);
					strappcoappid = Helper.correctNull((String)rs.getString("NPPD_APPID")); 
					
					StrOffadd = Helper.correctNull((String)rs.getString("NPPD_CURR_ADD_SEQ_NO"));
					StrCut_add = Helper.correctNull((String)rs.getString("NPPD_AADHAR_ADD_SEQ_NO"));
			}
			/*if(rs != null){rs.close();}
			if(!StrCut_add.equalsIgnoreCase("")){
				
			strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrCut_add);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_VILLAGE")));
				String city=Helper.correctNull((String)rs.getString("NPAD_CITY_NAME"));
				String state=Helper.correctNull((String)rs.getString("NPAD_STATE_NAME"));
				if(!state.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
				rs3 = DBUtils.executeQuery(strQuery);			
				if(rs3.next())
				{
					arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
				}else{
					arrValues.add("");
				}
				}else{
					arrValues.add("");
				}
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_COUNTRY_NAME")));
				if(!city.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_city_name^"+city);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
				
				
			}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}}else{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");	
			}
			if(rs != null){rs.close();}
			if(!StrOffadd.equalsIgnoreCase("")){
				
			strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_VILLAGE")));
				String city=Helper.correctNull((String)rs.getString("NPAD_CITY_NAME"));
				String state=Helper.correctNull((String)rs.getString("NPAD_STATE_NAME"));
				if(!state.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
				rs3 = DBUtils.executeQuery(strQuery);			
				if(rs3.next())
				{
					arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
				}else{
					arrValues.add("");
				}
				}else{
					arrValues.add("");
				}
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_COUNTRY_NAME")));
				if(!city.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_city_name^"+city);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
			}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				
			}}else{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}
				arrValues.add("");
				arrValues.add(strAppCode);
				System.out.print("arrValues update demo "+arrValues);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
				
				//Insertion for Employment Details
				hshQuery = new HashMap();
 				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_npempdetails1");	
				
				strQuery = SQLParser.getSqlQuery("sel_nppersonaldetails^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_ORG_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MOBILE_NUMBER")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_EMAIL")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_DESIGNATION")));
					arrValues.add("A");
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_RETIRE_AGE")));
					StrOffadd = Helper.correctNull((String)rs.getString("NPPD_CURR_ADD_SEQ_NO"));
				}
				arrValues.add("");
				arrValues.add("");
				arrValues.add("0");
				if(rs != null){rs.close();}
				if(!StrOffadd.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_VILLAGE")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_CITY_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STATE_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
				}	
				else
				{
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
				}}else{
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
				}
				arrValues.add(strAppCode);*/
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
				
				
				
				
				
				String app_id="0";
				Double grossincome=0.0,otherincome=0.0,incometax=0.0;
				strquery1 = SQLParser.getSqlQuery("sel_npFinancial1^"+strRefno);
				rs1 = DBUtils.executeQuery(strquery1);			
				if(rs1.next())
				{
					
					String grossincome1="0",net_monthly_income="0",salary_income="0";
					String house_property="0",other_source="0",capital_gain="0";
					 grossincome1=Helper.correctNull((String)rs1.getString("NPFD_GROSS_MONTHLY_INCOME"));
					 net_monthly_income=Helper.correctNull((String)rs1.getString("NPFD_NET_MONTHLY_INCOME"));
					 salary_income=Helper.correctNull((String)rs1.getString("NPFD_SALARY_INCOME"));
					
					 house_property=Helper.correctNull((String)rs1.getString("NPFD_HOUSE_PROPERTY"));
					 other_source=Helper.correctNull((String)rs1.getString("NPFD_OTHER_SOURCE"));
					 capital_gain=Helper.correctNull((String)rs1.getString("NPFD_CAPITAL_GAIN"));
					
					 app_id=Helper.correctNull((String)rs1.getString("NPFD_ID"));
					 String Taxincome=Helper.correctNull((String)rs1.getString("NPFD_TAXABLE_INCOME"));
					 
					 if(!Taxincome.equalsIgnoreCase("")){
						 incometax=Double.valueOf(Taxincome);
						 }
						 if(grossincome1.equalsIgnoreCase("")){
							 grossincome1="0";
						 }
							 if(net_monthly_income.equalsIgnoreCase("")){
								 net_monthly_income="0";
							 }
								 if(salary_income.equalsIgnoreCase("")){
									 salary_income="0";
								 }
						grossincome=Double.valueOf(grossincome1)+Double.valueOf(net_monthly_income)+Double.valueOf(salary_income);
												 
						
						 if(house_property.equalsIgnoreCase("")){
							 house_property="0";
						 }
							 if(other_source.equalsIgnoreCase("")){
								 other_source="0";
							 }
								 if(capital_gain.equalsIgnoreCase("")){
									 capital_gain="0";
								 }
						 otherincome=Double.valueOf(house_property)+Double.valueOf(other_source)+Double.valueOf(capital_gain);
								 
					 
				}
				//income and expence
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_incomeexpeneperapp_np");
				arrValues.add(String.valueOf(grossincome));
				arrValues.add(String.valueOf(otherincome));
				arrValues.add(String.valueOf(incometax));
				arrValues.add("A");
				arrValues.add("1");
				arrValues.add(strAppCode);
				System.out.print("arrValues update INCOME "+arrValues);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
				
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_nplapsappid");	
				arrValues.add(strAppCode);	
				arrValues.add(strRefno);			
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			
				
				//DEDUPE LEVEL UPDATE
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","updperappid_np1");	
				arrValues.add(strAppCode);	
				arrValues.add(strRefno);
				//arrValues.add(StrName1);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
				
			}
			
			//Insertion block for Coapplicant Data
		
			strQuery = SQLParser.getSqlQuery("sel_npcoappdet^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			while(rs.next())
			{	
				String name="";
				if(!Helper.correctNull((String)rs.getString("NPCD_FNAME")).equalsIgnoreCase(""))
				{
					name=Helper.correctNull((String)rs.getString("NPCD_FNAME"));
				}
				if(!Helper.correctNull((String)rs.getString("NPCD_LNAME")).equalsIgnoreCase(""))
				{
					name=name+" "+Helper.correctNull((String)rs.getString("NPCD_LNAME"));
				}
				if(!Helper.correctNull((String)rs.getString("NPCD_MNAME")).equalsIgnoreCase(""))
				{
					name=name+" "+Helper.correctNull((String)rs.getString("NPCD_MNAME"));
				}
				
				String StrName=name;
				String strLapsid1="",strNewapp1="",strCbsid1="";
				strQuery = SQLParser.getSqlQuery("seldedupecheckco_np^"+strRefno+"^"+StrName.trim());
				rs1 = DBUtils.executeQuery(strQuery);			
				if(rs1.next())
				{
					strLapsid1=Helper.correctNull((String)rs1.getString("NP_LAPSID"));
					strNewapp1=Helper.correctNull((String)rs1.getString("NP_ISNEW"));
					strCbsid1=Helper.correctNull((String)rs1.getString("NP_CBSID"));
				}
				if(strNewapp1.equalsIgnoreCase("Y") || strNewapp1.equalsIgnoreCase(" "))
				{
				String strsId="";
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","ins_npcustprofile");	
				//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_FIRST_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_FIRST_NAME"))+" "+Helper.correctNull((String)rs.getString("NPPD_LAST_NAME")));
				//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MIDDLE_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_LAST_NAME")));
				arrValues.add(getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("NPPD_GENDER"))));
				/*String strgender=Helper.correctNull((String)rs.getString("NPPD_GENDER"));
				if(strgender.equalsIgnoreCase("Male"))
				{
				arrValues.add("M");	
				}
				else
				{
				arrValues.add("F");
				}*/
				
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_DOB")));
				//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_EMAIL")));
				//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_SOCIAL_CATEGORY")));				
				//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MOBILE_NUMBER")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_FATHERS_NAME")));
				//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MOTHERS_NAME")));
				//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MOTHERS_NAME")));
				arrValues.add(getNPtoLAPSListOfValue("4",Helper.correctNull((String)rs.getString("NPPD_SALUTATION"))));
				arrValues.add(getNPtoLAPSListOfValue("5",Helper.correctNull((String)rs.getString("NPPD_MARITAL_STATUS"))));
				/*String strtitle=Helper.correctNull((String)rs.getString("NPPD_SALUTATION"));
				if(strtitle.equalsIgnoreCase("Mrs."))
				{
				arrValues.add("MRS");	
				}
				else if(strtitle.equalsIgnoreCase("Mr."))
				{
				arrValues.add("MR");
				}
				else
				{
				arrValues.add("");
				}
				String strstatus=Helper.correctNull((String)rs.getString("NPPD_MARITAL_STATUS"));
				if(strstatus.equalsIgnoreCase("Married"))
				{
				arrValues.add("MARID");	
				}
				else
				{
				arrValues.add("SINGL");
				}*/
				//arrValues.add(getNPtoLAPSListOfValue("7",Helper.correctNull((String)rs.getString("NPPD_EDU_QUALIFICATION"))));
				//arrValues.add(getNPtoLAPSListOfValue("6",Helper.correctNull((String)rs.getString("NPPD_EMP_TYPE"))));
				//arrValues.add(getNPtoLAPSListOfValue("8",Helper.correctNull((String)rs.getString("NPPD_RESITANT_STATUS"))));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_EMP_TYPE")));	
				arrValues.add("001");	
				//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_RESITANT_STATUS")));	
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_PAN_NO")));				
				//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_VOTER_NO")));
				//arrValues.add("");
				//arrValues.add("");
				//arrValues.add(strbranchcode);
				/*arrValues.add(getNPtoLAPSCommonLOV(Helper.correctNull((String)hshValues.get("SchemeName")),
						Helper.correctNull((String)hshValues.get("selsegment")),"CUSTPRFSTATUS"));*/
				arrValues.add("Y");
				//arrValues.add(Helper.correctNull((String)hshValues.get("strOrgbankFlag")));
				LapsAppid = CustPrfAppID.getApplicantCode();
				arrValues.add(LapsAppid);
				arrValues.add(LapsAppid);
				strappcoappid = Helper.correctNull((String)rs.getString("NPPD_APPID"));
				
				StrOffadd = Helper.correctNull((String)rs.getString("NPPD_CURR_ADD_SEQ_NO"));
				StrCut_add = Helper.correctNull((String)rs.getString("NPPD_AADHAR_ADD_SEQ_NO"));
				arrValues.add(strbranchcode);
				arrValues.add("099");
				
			
			/*if(rs1 != null){rs1.close();}
			if(!StrCut_add.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrCut_add);
			rs1 = DBUtils.executeQuery(strQuery);			
			if(rs1.next())
			{
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs1.getString("NPAD_LANDMARK")));
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME")));
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_VILLAGE")));
				String city=Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME"));
				String state=Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME"));
				if(!state.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
				rs3 = DBUtils.executeQuery(strQuery);			
				if(rs3.next())
				{
					arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
				}else{
					arrValues.add("");
				}
				}else{
					arrValues.add("");
				}
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_COUNTRY_NAME")));
				if(!city.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_city_name^"+city);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE")));
				
				
			}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}
			if(rs1 != null){rs1.close();}
			if(!StrOffadd.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
			rs1 = DBUtils.executeQuery(strQuery);			
			if(rs1.next())
			{
				
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs1.getString("NPAD_LANDMARK")));
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME")));
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_VILLAGE")));
				String city=Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME"));
				String state=Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME"));
				if(!state.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
				rs3 = DBUtils.executeQuery(strQuery);			
				if(rs3.next())
				{
					arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
				}else{
					arrValues.add("");
				}
				}else{
					arrValues.add("");
				}
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_COUNTRY_NAME")));
				if(!city.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_city_name^"+city);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE")));
			}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				
			}}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}
				
				
				
				arrValues.add("");*/
				System.out.print("arrValues update INCOME "+arrValues);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
				
				
				//DEDUPE LEVEL UPDATE
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","updperappid_np");	
				arrValues.add(LapsAppid);	
				arrValues.add(strRefno);
				arrValues.add(StrName);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
			
				//Insertion for Applicant Employment Details
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","ins_npempdetails1");	
				arrValues.add(LapsAppid);
				strquery1 = SQLParser.getSqlQuery("sel_npcoappdet^"+strRefno);
				rs1 = DBUtils.executeQuery(strquery1);			
				if(rs1.next())
				{
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_ORG_NAME")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_MOBILE")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_EMAIL")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_DESIGNATION")));
					arrValues.add("");
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_RETIRE_AGE")));
					strappcoappid = Helper.correctNull((String)rs1.getString("NPCD_COAPP_ID"));
					StrOffadd = Helper.correctNull((String)rs1.getString("NPCD_OFFICE_ADD_SEQ"));
					
					
				}
				arrValues.add("");
				arrValues.add("");
				arrValues.add(strsId);
				if(rs1 != null){rs1.close();}
				if(!StrOffadd.equalsIgnoreCase("")){
				strquery1 = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
				rs1 = DBUtils.executeQuery(strquery1);			
				if(rs1.next())
				{
					
					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs1.getString("NPAD_LANDMARK")));
					//arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME")));
					String district=Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME"));
					//District Code added by kannan
					if(!district.equalsIgnoreCase("")){
						strQuery = SQLParser.getSqlQuery("NP_District_Name^"+district);
						rs3 = DBUtils.executeQuery(strQuery);			
						if(rs3.next())
						{
							arrValues.add(Helper.correctNull((String)rs3.getString("DISTRICT_CODE")));
						}else{
							arrValues.add("");
						}
						}else{
							arrValues.add("");
						}
					arrValues.add("");
					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE")));
				}
				else
				{
					//arrValues.add(getaddArrayValues(6));
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");

				}}
				else
				{
					//arrValues.add(getaddArrayValues(6));
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");

				}
				System.out.print("arrValues update EMP "+arrValues);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
				
				
				
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_nplapscoappid");	
				arrValues.add(LapsAppid);	
				arrValues.add(strRefno);
				arrValues.add(strappcoappid);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","updperappid_np");	
				arrValues.add(LapsAppid);	
				arrValues.add(strRefno);
				arrValues.add(StrName);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				}else{
					
					//ex.coapp application details insert
					String strOldAppId=strLapsid;
					String strAppCode = CustPrfAppID.getApplicantCode();
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					arrValues.add(strAppCode);
					arrValues.add(strAppCode);
					arrValues.add("n");
					arrValues.add(Helper.correctNull((String)hshValues.get("strOrgShortCode")));
					arrValues.add(strOldAppId);	
					//arrValues.add(strOldAppId);	
					System.out.print("arrValues update co-app perapplicent "+arrValues);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","perapplicantrenew1");
					hshQueryValues.put("1",hshQuery);
					
					
					
					
					// update renew column in perapplicant table
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					arrValues.add("y");
					arrValues.add(strOldAppId);
					System.out.print("arrValues update co-app perapplicent "+arrValues);
					
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","perapplicantupdaterenew");
					hshQueryValues.put("2",hshQuery);

					// insert data in to perincexpences table
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					arrValues.add(strAppCode);
					arrValues.add(strOldAppId);
					System.out.print("arrValues update copy co-app income "+arrValues);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","perincomerenew");
					hshQueryValues.put("3",hshQuery);
					
					// insert data in to peremployer table
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					arrValues.add(strAppCode);
					arrValues.add(strOldAppId);
					hshQuery.put("arrValues",arrValues);
					System.out.print("arrValues update copy co-app employ "+arrValues);
					
					hshQuery.put("strQueryId","peremployerrenew");
					hshQueryValues.put("4",hshQuery);
					hshQueryValues.put("size","4");
					
					
					
					// insert data in to KYC norms table
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					arrValues.add(strAppCode);
					arrValues.add(strOldAppId);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","kycnormsrenew");
					System.out.print("arrValues update copy co-app kyc "+arrValues);
					
					hshQueryValues.put("5",hshQuery);
					hshQueryValues.put("size","5");
								
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
					
					String strsId="";
					String strgender="";
					String stremployeestatus="";
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","upd_npcustprofile");	
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_FNAME")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPCD_MNAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_LNAME")));
					arrValues.add(getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("NPCD_GENDER"))));
					/*strgender=Helper.correctNull((String)rs.getString("NPCD_GENDER"));
					if(strgender.equalsIgnoreCase("Male"))
					{
					arrValues.add("M");	
					}
					else
					{
					arrValues.add("F");
					}*/
					
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_DOB")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPCD_EMAIL")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPCD_SOCIAL_CAT")));				
					//arrValues.add(Helper.correctNull((String)rs.getString("NPCD_MOBILE")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_FATORHUSB_NAME")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPCD_MOTHER_NAME")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPCD_MOTHER_NAME")));
					arrValues.add(getNPtoLAPSListOfValue("4",Helper.correctNull((String)rs.getString("NPCD_SALUTATION"))));
					arrValues.add(getNPtoLAPSListOfValue("5",Helper.correctNull((String)rs.getString("NPCD_MARITAL_STAT"))));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPCD_SALUTATION")));
					/*String strtitle=Helper.correctNull((String)rs.getString("NPCD_SALUTATION"));
					if(strtitle.equalsIgnoreCase("Mrs."))
					{
					arrValues.add("MRS");	
					}
					else if(strtitle.equalsIgnoreCase("Mr."))
					{
					arrValues.add("MR");
					}
					else
					{
					arrValues.add("");
					}
					String strstatus=Helper.correctNull((String)rs.getString("NPCD_MARITAL_STAT"));
					if(strstatus.equalsIgnoreCase("Married"))
					{
					arrValues.add("MARID");	
					}
					else
					{
					arrValues.add("SINGL");
					}*/
					//arrValues.add(getNPtoLAPSListOfValue("7",Helper.correctNull((String)rs.getString("NPCD_EDU_QUALIFY"))));
					arrValues.add(getNPtoLAPSListOfValue("6",Helper.correctNull((String)rs.getString("NPCD_EMPLOY_TYPE"))));
					//arrValues.add(getNPtoLAPSListOfValue("8",Helper.correctNull((String)rs.getString("NPCD_RESI_TYPE"))));	
					/*stremployeestatus=Helper.correctNull((String)rs.getString("NPCD_EMPLOY_TYPE"));	
					if(stremployeestatus.equalsIgnoreCase("Others"))
					{
					arrValues.add("11");	
					}
					else
					{
					arrValues.add("");
					}*/
					arrValues.add("003");
					arrValues.add("");				
					//arrValues.add("");
					//arrValues.add("");
					//arrValues.add("");
					//arrValues.add(strbranchcode);
					/*arrValues.add(getNPtoLAPSCommonLOV(Helper.correctNull((String)hshValues.get("SchemeName")),
							Helper.correctNull((String)hshValues.get("selsegment")),"CUSTPRFSTATUS"));*/
					arrValues.add("Y");
					//arrValues.add(Helper.correctNull((String)hshValues.get("strOrgbankFlag")));
					arrValues.add(strAppCode);
					strappcoappid = Helper.correctNull((String)rs.getString("NPCD_COAPP_REF_ID")); 
					
					StrOffadd = Helper.correctNull((String)rs.getString("NPCD_OFFICE_ADD_SEQ"));
					StrCut_add = Helper.correctNull((String)rs.getString("NPCD_AADHAR_ADD_SEQ"));
					
				
					/*if(rs != null){rs.close();}
					if(!StrCut_add.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrCut_add);
					rs = DBUtils.executeQuery(strQuery);			
					if(rs.next())
					{
						arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
						arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME")));
						arrValues.add(Helper.correctNull((String)rs.getString("NPAD_VILLAGE")));
						String city=Helper.correctNull((String)rs.getString("NPAD_CITY_NAME"));
						String state=Helper.correctNull((String)rs.getString("NPAD_STATE_NAME"));
						if(!state.equalsIgnoreCase("")){
						strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
						rs3 = DBUtils.executeQuery(strQuery);			
						if(rs3.next())
						{
							arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
						}else{
							arrValues.add("");
						}
						}else{
							arrValues.add("");
						}
						arrValues.add(Helper.correctNull((String)rs.getString("NPAD_COUNTRY_NAME")));
						if(!city.equalsIgnoreCase("")){
							strQuery = SQLParser.getSqlQuery("NP_city_name^"+city);
							rs3 = DBUtils.executeQuery(strQuery);			
							if(rs3.next())
							{
								arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
							}else{
								arrValues.add("");
							}
							}else{
								arrValues.add("");
							}
						arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
						
						
					}
					else
					{
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
					}}
					else
					{
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
					}
					if(rs1 != null){rs1.close();}
					if(!StrOffadd.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
					rs1 = DBUtils.executeQuery(strQuery);			
					if(rs1.next())
					{
						
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs1.getString("NPAD_LANDMARK")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_VILLAGE")));
						String city=Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME"));
						String state=Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME"));
						if(!state.equalsIgnoreCase("")){
						strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
						rs3 = DBUtils.executeQuery(strQuery);			
						if(rs3.next())
						{
							arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
						}else{
							arrValues.add("");
						}
						}else{
							arrValues.add("");
						}
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_COUNTRY_NAME")));
						if(!city.equalsIgnoreCase("")){
							strQuery = SQLParser.getSqlQuery("NP_city_name^"+city);
							rs3 = DBUtils.executeQuery(strQuery);			
							if(rs3.next())
							{
								arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
							}else{
								arrValues.add("");
							}
							}else{
								arrValues.add("");
							}
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE")));
					}
					else
					{
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
					}}
					else
					{
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
					}
					arrValues.add("");
					arrValues.add(strAppCode);*/
					System.out.print("arrValues update co-app perapllicent "+arrValues);
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
					
					
					
					//DEDUPE LEVEL UPDATE
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","updperappid_np");	
					arrValues.add(strAppCode);	
					arrValues.add(strRefno);
					arrValues.add(StrName);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
					
					
					//Insertion for Applicant Employment Details
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","upd_npempdetails1");	
					
					strquery1 = SQLParser.getSqlQuery("sel_npcoappdet^"+strRefno);
					rs1 = DBUtils.executeQuery(strquery1);			
					if(rs1.next())
					{
						arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_ORG_NAME")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_MOBILE")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_EMAIL")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_DESIGNATION")));
						arrValues.add("");
						arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_RETIRE_AGE")));
						StrOffadd = Helper.correctNull((String)rs1.getString("NPCD_OFFICE_ADD_SEQ"));
						
						
						
					}
					//arrValues.add("");
					//arrValues.add("");
					arrValues.add(strsId);
					if(rs != null){rs.close();}
					if(!StrOffadd.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
					rs1 = DBUtils.executeQuery(strQuery);			
					if(rs1.next())
					{
						
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs1.getString("NPAD_LANDMARK")));
						//arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME")));
						String district=Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME"));
						//District Code added by kannan
						if(!district.equalsIgnoreCase("")){
							strQuery = SQLParser.getSqlQuery("NP_District_Name^"+district);
							rs3 = DBUtils.executeQuery(strQuery);			
							if(rs3.next())
							{
								arrValues.add(Helper.correctNull((String)rs3.getString("DISTRICT_CODE")));
							}else{
								arrValues.add("");
							}
							}else{
								arrValues.add("");
							}
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_VILLAGE")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE")));
					}	
					else
					{
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");

					}}	
					else
					{
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");

					}
					arrValues.add(strAppCode);
					hshQuery.put("arrValues",arrValues);
					System.out.print("arrValues update copy co-app emp "+arrValues);
					
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
					
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","upd_nplapscoappid");	
					arrValues.add(strAppCode);	
					arrValues.add(strRefno);
					arrValues.add(strappcoappid);
					hshQuery.put("arrValues",arrValues);
					
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
					
				
					
				}
			}
			if(selsegment.equalsIgnoreCase("EDU")){
			hshappcr=getNPApplicationCreation(hshValues);			
			}else if(selsegment.equalsIgnoreCase("HL")){
				hshappcr=getNPHLApplicationCreation(hshValues);				
			}
			else if(selsegment.equalsIgnoreCase("AGRI")||selsegment.equalsIgnoreCase("LHD"))
			{
			hshappcr=getNP_AgriApplicationCreation(hshValues);	
			}
			/*if(selsegment.equalsIgnoreCase("EDU")){
				hshappcr=getNPInwardCreation(hshValues);			
				}else if(selsegment.equalsIgnoreCase("HL")){
					hshappcr=getNPHLApplicationCreation(hshValues);				
				}
				else if(selsegment.equalsIgnoreCase("AGRI")||selsegment.equalsIgnoreCase("LHD"))
				{
				hshappcr=getNP_AgriApplicationCreation(hshValues);	
				}*/
			hsh = getNpMailbox(hshValues);
			
		}
		catch(Exception ex)
		{
			Logger.log("Exception in getNpapplications"+ex);
		}	
		return hsh;
	}
	public HashMap getNPAgriCustProfileCreation(HashMap hshValues) 
	{
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs3 = null;
		HashMap hshRecord = new HashMap();
		HashMap hsh = new HashMap();
		String strQuery = "",strquery1="";
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		HashMap hshQueryValues = new HashMap();
		String strbranchcode=Helper.correctNull((String)hshValues.get("strOrgShortCode"));
		String strusrid=Helper.correctNull((String)hshValues.get("strUserId"));
		String strStatus=Helper.correctNull((String)hshValues.get("hidaction"));
		String strRefno = Helper.correctNull((String)hshValues.get("hidRefId"));
		if(strRefno.equalsIgnoreCase("")){
		 strRefno = Helper.correctNull((String)hshValues.get("hidApplicantId"));
		}
		String selsegment = Helper.correctNull((String)hshValues.get("selsegment"));
		if(selsegment.equalsIgnoreCase("")){
			selsegment = Helper.correctNull((String)hshValues.get("SegType"));
			}
		
		
		MastApplicantBean CustPrfAppID = new MastApplicantBean();
		String LapsAppid="";
		HashMap hshappcr = new HashMap();

		try
		{		
			String strappcoappid="";
			String StrName1="",strNewapp="",strLapsid="",strCbsid="";
			
			
			strQuery = SQLParser.getSqlQuery("seldedupecheck_np^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				strLapsid=Helper.correctNull((String)rs.getString("NP_LAPSID"));
				strNewapp=Helper.correctNull((String)rs.getString("NP_ISNEW"));
				strCbsid=Helper.correctNull((String)rs.getString("NP_CBSID"));
				StrName1=Helper.correctNull((String)rs.getString("NP_APPLICANTNAME"));
			}
			
			String StrOffadd="",StrCut_add="";
			if(strNewapp.equalsIgnoreCase("Y"))
			{
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","ins_npcustprofile");					
			strQuery = SQLParser.getSqlQuery("sel_nppersonaldetails^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_FIRST_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_FIRST_NAME"))+" "+Helper.correctNull((String)rs.getString("NPPD_LAST_NAME")));
				//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MIDDLE_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_LAST_NAME")));
				arrValues.add(getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("NPPD_GENDER"))));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_DOB")));
				//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_EMAIL")));
				//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_SOCIAL_CATEGORY")));				
				//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MOBILE_NUMBER")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_FATHERS_NAME")));
				//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MOTHERS_NAME")));
				//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MOTHERS_NAME")));
				arrValues.add(getNPtoLAPSListOfValue("4",Helper.correctNull((String)rs.getString("NPPD_SALUTATION"))));
				arrValues.add(getNPtoLAPSListOfValue("5",Helper.correctNull((String)rs.getString("NPPD_MARITAL_STATUS"))));
				//arrValues.add(getNPtoLAPSListOfValue("7",Helper.correctNull((String)rs.getString("NPPD_EDU_QUALIFICATION"))));
				//arrValues.add(getNPtoLAPSListOfValue("6",Helper.correctNull((String)rs.getString("NPPD_EMP_TYPE"))));
				arrValues.add(getNPtoLAPSListOfValue("8",Helper.correctNull((String)rs.getString("NPPD_RESITANT_STATUS"))));
                arrValues.add("001");				
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_PAN_NO")));				
				//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_VOTER_NO")));
				//arrValues.add("");
				//arrValues.add("");
				//arrValues.add(strbranchcode);
				/*arrValues.add(getNPtoLAPSCommonLOV(Helper.correctNull((String)hshValues.get("SchemeName")),
						Helper.correctNull((String)hshValues.get("selsegment")),"CUSTPRFSTATUS"));*/
				//arrValues.add(Helper.correctNull((String)hshValues.get("strOrgbankFlag")));//new		
				arrValues.add("Y");
				
				
				LapsAppid = CustPrfAppID.getApplicantCode();
				arrValues.add(LapsAppid);
				arrValues.add(LapsAppid);
				strappcoappid = Helper.correctNull((String)rs.getString("NPPD_APPID"));
				
				StrOffadd = Helper.correctNull((String)rs.getString("NPPD_CURR_ADD_SEQ_NO"));
				StrCut_add = Helper.correctNull((String)rs.getString("NPPD_AADHAR_ADD_SEQ_NO"));
				
			}else{
				strQuery = SQLParser.getSqlQuery("getAgriPersonalDetails^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					
					
					arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_FIRST_NAME")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_MIDDLE_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_LAST_NAME")));
					arrValues.add(getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("NPAAPD_GENDER"))));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_DATE_OF_BIRTH")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_EMAIL")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_SOCIAL_CATEGORY")));				
					//arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_MOBILE")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_FATHER_OR_HUSBAND_NAME")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_MOTHER_NAME")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_MOTHER_NAME")));
					arrValues.add(getNPtoLAPSListOfValue("4",Helper.correctNull((String)rs.getString("NPAAPD_SALUTATION"))));
					arrValues.add(getNPtoLAPSListOfValue("5",Helper.correctNull((String)rs.getString("NPAAPD_MARITAL_STATUS"))));
					//arrValues.add(getNPtoLAPSListOfValue("7",Helper.correctNull((String)rs.getString("NPAAPD_EDU_QUALIFICATION"))));
					//arrValues.add(getNPtoLAPSListOfValue("6",Helper.correctNull((String)rs.getString("NPAAPD_INSTITUTION"))));
					//arrValues.add(getNPtoLAPSListOfValue("8",Helper.correctNull((String)rs.getString("NPAAPD_RESIDENTIAL_STATUS"))));				
					//arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_PAN")));				
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					/*arrValues.add(getNPtoLAPSCommonLOV(Helper.correctNull((String)hshValues.get("SchemeName")),
							Helper.correctNull((String)hshValues.get("selsegment")),"CUSTPRFSTATUS"));
					arrValues.add(Helper.correctNull((String)hshValues.get("strOrgbankFlag")));*/
					LapsAppid = CustPrfAppID.getApplicantCode();
					arrValues.add(LapsAppid);
					arrValues.add(LapsAppid);
					strappcoappid = Helper.correctNull((String)rs.getString("NPAAPD_ID"));
					
					StrOffadd = Helper.correctNull((String)rs.getString("NPAAPD_CURR_ADD_SEQ_NO"));
					StrCut_add = Helper.correctNull((String)rs.getString("NPAAPD_AADHAR_ADD_SEQ_NO"));
						
				}	
			}
			/*if(rs != null){rs.close();}
			if(!StrCut_add.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrCut_add);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_VILLAGE")));
				String city=Helper.correctNull((String)rs.getString("NPAD_CITY_NAME"));
				String state=Helper.correctNull((String)rs.getString("NPAD_STATE_NAME"));
				if(!state.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
				rs3 = DBUtils.executeQuery(strQuery);			
				if(rs3.next())
				{
					arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
				}else{
					arrValues.add("");
				}
				}else{
					arrValues.add("");
				}
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_COUNTRY_NAME")));
				if(!city.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_city_name^"+city);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
				
				
			}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}}else{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
	
			}
			if(rs != null){rs.close();}
			if(!StrOffadd.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_VILLAGE")));
				String city=Helper.correctNull((String)rs.getString("NPAD_CITY_NAME"));
				String state=Helper.correctNull((String)rs.getString("NPAD_STATE_NAME"));
				if(!state.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
				rs3 = DBUtils.executeQuery(strQuery);			
				if(rs3.next())
				{
					arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
				}else{
					arrValues.add("");
				}
				}else{
					arrValues.add("");
				}
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_COUNTRY_NAME")));
				if(!city.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_city_name^"+city);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
			}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				
			}}else{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}
			arrValues.add("");*/
			System.out.print("arrValues cust profile --"+arrValues);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
			
			
			//DEDUPE LEVEL UPDATE
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","updperappid_np");	
			arrValues.add(LapsAppid);	
			arrValues.add(strRefno);
			arrValues.add(StrName1);
			System.out.print("arrValues dedupe old id --"+arrValues);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			
			
			
			
			//Insertion for Employment Details
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","ins_npempdetails1");	
			arrValues.add(LapsAppid);
			strQuery = SQLParser.getSqlQuery("sel_nppersonaldetails^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_ORG_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MOBILE_NUMBER")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_EMAIL")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_DESIGNATION")));
				arrValues.add("A");
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_RETIRE_AGE")));
				strappcoappid = Helper.correctNull((String)rs.getString("NPPD_APPID"));
				StrOffadd = Helper.correctNull((String)rs.getString("NPPD_CURR_ADD_SEQ_NO"));
			
			}else{
				
				strQuery = SQLParser.getSqlQuery("getAgriPersonalDetails^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
				arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_FIRST_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAAPD_MIDDLE_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAAPD_LAST_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_MOBILE")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_EMAIL")));
				arrValues.add("");
				arrValues.add("A");
				arrValues.add("");
				strappcoappid = Helper.correctNull((String)rs.getString("NPAAPD_ID"));
				StrOffadd = Helper.correctNull((String)rs.getString("NPAAPD_CURR_ADD_SEQ_NO"));
				}
			}
			arrValues.add("");
			//arrValues.add("");
			//arrValues.add("0");
			if(rs != null){rs.close();}
			if(!StrOffadd.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_VILLAGE")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_CITY_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STATE_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
			}	
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}}else{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}
			System.out.print("arrValues employment details --"+arrValues);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
			
			
			String app_id="0";
			Double grossincome=0.0,otherincome=0.0,incometax=0.0;
			strquery1 = SQLParser.getSqlQuery("sel_npFinancial1^"+strRefno);
			rs1 = DBUtils.executeQuery(strquery1);			
			if(rs1.next())
			{
				
				String grossincome1="0",net_monthly_income="0",salary_income="0";
				String house_property="0",other_source="0",capital_gain="0";
				 grossincome1=Helper.correctNull((String)rs1.getString("NPFD_GROSS_MONTHLY_INCOME"));
				 net_monthly_income=Helper.correctNull((String)rs1.getString("NPFD_NET_MONTHLY_INCOME"));
				 salary_income=Helper.correctNull((String)rs1.getString("NPFD_SALARY_INCOME"));
				
				 house_property=Helper.correctNull((String)rs1.getString("NPFD_HOUSE_PROPERTY"));
				 other_source=Helper.correctNull((String)rs1.getString("NPFD_OTHER_SOURCE"));
				 capital_gain=Helper.correctNull((String)rs1.getString("NPFD_CAPITAL_GAIN"));
				
				 app_id=Helper.correctNull((String)rs1.getString("NPFD_ID"));
				 String Taxincome=Helper.correctNull((String)rs1.getString("NPFD_TAXABLE_INCOME"));
				 
				 if(!Taxincome.equalsIgnoreCase("")){
					 incometax=Double.valueOf(Taxincome);
					 }
					 if(grossincome1.equalsIgnoreCase("")){
						 grossincome1="0";
					 }
						 if(net_monthly_income.equalsIgnoreCase("")){
							 net_monthly_income="0";
						 }
							 if(salary_income.equalsIgnoreCase("")){
								 salary_income="0";
							 }
					grossincome=Double.valueOf(grossincome1)+Double.valueOf(net_monthly_income)+Double.valueOf(salary_income);
											 
					
					 if(house_property.equalsIgnoreCase("")){
						 house_property="0";
					 }
						 if(other_source.equalsIgnoreCase("")){
							 other_source="0";
						 }
							 if(capital_gain.equalsIgnoreCase("")){
								 capital_gain="0";
							 }
					 otherincome=Double.valueOf(house_property)+Double.valueOf(other_source)+Double.valueOf(capital_gain);
							 
				 
			}
			//income and expence
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","ins_incomeexpeneperapp_np");
			arrValues.add(LapsAppid);	
			arrValues.add(String.valueOf(grossincome));
			arrValues.add(String.valueOf(otherincome));
			arrValues.add(String.valueOf(incometax));
			arrValues.add("A");
			arrValues.add("1");
			System.out.print("arrValues income details --"+arrValues);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
			
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","upd_nplapsappid");	
			arrValues.add(LapsAppid);	
			arrValues.add(strRefno);			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","upd_nplapsappid5");	
			arrValues.add(LapsAppid);	
			arrValues.add(strRefno);			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			
			}else{
				
				//ex.application creation for applicant
				
				String strOldAppId=strLapsid;
				String strAppCode = CustPrfAppID.getApplicantCode();
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				arrValues.add(strAppCode);
				arrValues.add(Helper.correctNull((String)hshValues.get("strOrgShortCode")));
				arrValues.add("n");
				arrValues.add(Helper.correctNull((String)hshValues.get("strOrgShortCode")));
				arrValues.add(strOldAppId);	
				System.out.print("arrValues perapplication  --"+arrValues);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","perapplicantrenew1");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
				
				
				// update renew column in perapplicant table
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				arrValues.add("y");
				arrValues.add(strOldAppId);
				System.out.print("arrValues perapplication1 --"+arrValues);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","perapplicantupdaterenew");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
				// insert data in to perincexpences table
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				arrValues.add(strAppCode);
				arrValues.add(strOldAppId);
				System.out.print("arrValues income  --"+arrValues);
				
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","perincomerenew");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
				// insert data in to peremployer table
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				arrValues.add(strAppCode);
				arrValues.add(strOldAppId);
				System.out.print("arrValues employment  --"+arrValues);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","peremployerrenew");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
				arrValues=new ArrayList();
				hshQuery=new HashMap();			
				arrValues.add(strOldAppId);
				arrValues.add(strAppCode);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_perapplicant_idmap");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
				
				
				// insert data in to KYC norms table
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				arrValues.add(strAppCode);
				arrValues.add(strOldAppId);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","kycnormsrenew");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");			
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
				
				
				//update nationalportal data
				
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_npcustprofile");					
				strQuery = SQLParser.getSqlQuery("sel_nppersonaldetails^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_FIRST_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_FIRST_NAME"))+" "+Helper.correctNull((String)rs.getString("NPPD_LAST_NAME")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MIDDLE_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_LAST_NAME")));
					arrValues.add(getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("NPPD_GENDER"))));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_DOB")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_EMAIL")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_SOCIAL_CATEGORY")));				
					//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MOBILE_NUMBER")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_FATHERS_NAME")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MOTHERS_NAME")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MOTHERS_NAME")));
					arrValues.add(getNPtoLAPSListOfValue("4",Helper.correctNull((String)rs.getString("NPPD_SALUTATION"))));
					arrValues.add(getNPtoLAPSListOfValue("5",Helper.correctNull((String)rs.getString("NPPD_MARITAL_STATUS"))));
					//arrValues.add(getNPtoLAPSListOfValue("7",Helper.correctNull((String)rs.getString("NPPD_EDU_QUALIFICATION"))));
				    arrValues.add(getNPtoLAPSListOfValue("6",Helper.correctNull((String)rs.getString("NPPD_EMP_TYPE"))));
					//arrValues.add(getNPtoLAPSListOfValue("8",Helper.correctNull((String)rs.getString("NPPD_RESITANT_STATUS"))));
                    arrValues.add("003");					
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_PAN_NO")));				
					//arrValues.add(Helper.correctNull((String)rs.getString("NPPD_VOTER_NO")));
					/*arrValues.add("");
					arrValues.add("");
					arrValues.add(strbranchcode);*/
					arrValues.add(getNPtoLAPSCommonLOV(Helper.correctNull((String)hshValues.get("SchemeName")),
							Helper.correctNull((String)hshValues.get("selsegment")),"CUSTPRFSTATUS"));
					//arrValues.add(Helper.correctNull((String)hshValues.get("strOrgbankFlag")));
					arrValues.add(strAppCode);
					strappcoappid = Helper.correctNull((String)rs.getString("NPPD_APPID"));
				
					StrOffadd = Helper.correctNull((String)rs.getString("NPPD_CURR_ADD_SEQ_NO"));
					StrCut_add = Helper.correctNull((String)rs.getString("NPPD_AADHAR_ADD_SEQ_NO"));
					
			}else{
				strQuery = SQLParser.getSqlQuery("getAgriPersonalDetails^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_FIRST_NAME")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_MIDDLE_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_LAST_NAME")));
					arrValues.add(getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("NPAAPD_GENDER"))));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_DATE_OF_BIRTH")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_EMAIL")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_SOCIAL_CATEGORY")));				
					//arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_MOBILE")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_FATHER_OR_HUSBAND_NAME")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_MOTHER_NAME")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_MOTHER_NAME")));
					arrValues.add(getNPtoLAPSListOfValue("4",Helper.correctNull((String)rs.getString("NPAAPD_SALUTATION"))));
					arrValues.add(getNPtoLAPSListOfValue("5",Helper.correctNull((String)rs.getString("NPAAPD_MARITAL_STATUS"))));
					//arrValues.add(getNPtoLAPSListOfValue("7",Helper.correctNull((String)rs.getString("NPAAPD_EDU_QUALIFICATION"))));
					arrValues.add(getNPtoLAPSListOfValue("6",Helper.correctNull((String)rs.getString("NPAAPD_INSTITUTION"))));
					//arrValues.add(getNPtoLAPSListOfValue("8",Helper.correctNull((String)rs.getString("NPAAPD_RESIDENTIAL_STATUS"))));	
                    arrValues.add("003");						
					arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_PAN")));				
					/*arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add(strbranchcode);*/
					arrValues.add(getNPtoLAPSCommonLOV(Helper.correctNull((String)hshValues.get("SchemeName")),
							Helper.correctNull((String)hshValues.get("selsegment")),"CUSTPRFSTATUS"));
					//arrValues.add(Helper.correctNull((String)hshValues.get("strOrgbankFlag")));
					arrValues.add(strAppCode);
					strappcoappid = Helper.correctNull((String)rs.getString("NPAAPD_ID"));
					
					StrOffadd = Helper.correctNull((String)rs.getString("NPAAPD_CURR_ADD_SEQ_NO"));
					StrCut_add = Helper.correctNull((String)rs.getString("NPAAPD_AADHAR_ADD_SEQ_NO"));
						
				}	
			}
			/*if(rs != null){rs.close();}
			if(!StrCut_add.equalsIgnoreCase("")){
				
			strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrCut_add);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_VILLAGE")));
				String city=Helper.correctNull((String)rs.getString("NPAD_CITY_NAME"));
				String state=Helper.correctNull((String)rs.getString("NPAD_STATE_NAME"));
				if(!state.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
				rs3 = DBUtils.executeQuery(strQuery);			
				if(rs3.next())
				{
					arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
				}else{
					arrValues.add("");
				}
				}else{
					arrValues.add("");
				}
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_COUNTRY_NAME")));
				if(!city.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_city_name^"+city);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
				
				
			}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}}else{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");	
			}
			if(rs != null){rs.close();}
			if(!StrOffadd.equalsIgnoreCase("")){
				
			strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_VILLAGE")));
				String city=Helper.correctNull((String)rs.getString("NPAD_CITY_NAME"));
				String state=Helper.correctNull((String)rs.getString("NPAD_STATE_NAME"));
				if(!state.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
				rs3 = DBUtils.executeQuery(strQuery);			
				if(rs3.next())
				{
					arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
				}else{
					arrValues.add("");
				}
				}else{
					arrValues.add("");
				}
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_COUNTRY_NAME")));
				if(!city.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_city_name^"+city);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
			}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				
			}}else{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}
				arrValues.add("");
				arrValues.add(strAppCode);*/
				System.out.print("arrValues update demo "+arrValues);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
				
				//Insertion for Employment Details
				hshQuery = new HashMap();
 				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_npempdetails1");	
				
				strQuery = SQLParser.getSqlQuery("sel_nppersonaldetails^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_ORG_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MOBILE_NUMBER")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_EMAIL")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_DESIGNATION")));
					arrValues.add("A");
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_RETIRE_AGE")));
					StrOffadd = Helper.correctNull((String)rs.getString("NPPD_CURR_ADD_SEQ_NO"));
				}else{
					
					strQuery = SQLParser.getSqlQuery("getAgriPersonalDetails^"+strRefno);
					rs = DBUtils.executeQuery(strQuery);			
					if(rs.next())
					{
					arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_FIRST_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAAPD_MIDDLE_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAAPD_LAST_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_MOBILE")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAAPD_EMAIL")));
					arrValues.add("");
					arrValues.add("A");
					arrValues.add("");
					strappcoappid = Helper.correctNull((String)rs.getString("NPAAPD_ID"));
					StrOffadd = Helper.correctNull((String)rs.getString("NPAAPD_CURR_ADD_SEQ_NO"));
					}
				}
				arrValues.add("");
				///arrValues.add("");
				//arrValues.add("0");
				if(rs != null){rs.close();}
				if(!StrOffadd.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_VILLAGE")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_CITY_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STATE_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
				}	
				else
				{
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
				}}else{
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
				}
				arrValues.add(strAppCode);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
				
				
				String app_id="0";
				Double grossincome=0.0,otherincome=0.0,incometax=0.0;
				strquery1 = SQLParser.getSqlQuery("sel_npFinancial1^"+strRefno);
				rs1 = DBUtils.executeQuery(strquery1);			
				if(rs1.next())
				{
					
					String grossincome1="0",net_monthly_income="0",salary_income="0";
					String house_property="0",other_source="0",capital_gain="0";
					 grossincome1=Helper.correctNull((String)rs1.getString("NPFD_GROSS_MONTHLY_INCOME"));
					 net_monthly_income=Helper.correctNull((String)rs1.getString("NPFD_NET_MONTHLY_INCOME"));
					 salary_income=Helper.correctNull((String)rs1.getString("NPFD_SALARY_INCOME"));
					
					 house_property=Helper.correctNull((String)rs1.getString("NPFD_HOUSE_PROPERTY"));
					 other_source=Helper.correctNull((String)rs1.getString("NPFD_OTHER_SOURCE"));
					 capital_gain=Helper.correctNull((String)rs1.getString("NPFD_CAPITAL_GAIN"));
					
					 app_id=Helper.correctNull((String)rs1.getString("NPFD_ID"));
					 String Taxincome=Helper.correctNull((String)rs1.getString("NPFD_TAXABLE_INCOME"));
					 
					 if(!Taxincome.equalsIgnoreCase("")){
						 incometax=Double.valueOf(Taxincome);
						 }
						 if(grossincome1.equalsIgnoreCase("")){
							 grossincome1="0";
						 }
							 if(net_monthly_income.equalsIgnoreCase("")){
								 net_monthly_income="0";
							 }
								 if(salary_income.equalsIgnoreCase("")){
									 salary_income="0";
								 }
						grossincome=Double.valueOf(grossincome1)+Double.valueOf(net_monthly_income)+Double.valueOf(salary_income);
												 
						
						 if(house_property.equalsIgnoreCase("")){
							 house_property="0";
						 }
							 if(other_source.equalsIgnoreCase("")){
								 other_source="0";
							 }
								 if(capital_gain.equalsIgnoreCase("")){
									 capital_gain="0";
								 }
						 otherincome=Double.valueOf(house_property)+Double.valueOf(other_source)+Double.valueOf(capital_gain);
								 
					 
				}
				//income and expence
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_incomeexpeneperapp_np");
				arrValues.add(String.valueOf(grossincome));
				arrValues.add(String.valueOf(otherincome));
				arrValues.add(String.valueOf(incometax));
				arrValues.add("A");
				arrValues.add("1");
				arrValues.add(strAppCode);
				System.out.print("arrValues update INCOME "+arrValues);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
				
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_nplapsappid");	
				arrValues.add(strAppCode);	
				arrValues.add(strRefno);			
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_nplapsappid5");	
				arrValues.add(strAppCode);	
				arrValues.add(strRefno);			
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				//DEDUPE LEVEL UPDATE
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","updperappid_np1");	
				arrValues.add(strAppCode);	
				arrValues.add(strRefno);
				//arrValues.add(StrName1);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
				
			}
			
			//Insertion block for Coapplicant Data
		
			strQuery = SQLParser.getSqlQuery("sel_npcoappdet^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			while(rs.next())
			{	
				String name="";
				if(!Helper.correctNull((String)rs.getString("NPCD_FNAME")).equalsIgnoreCase(""))
				{
					name=Helper.correctNull((String)rs.getString("NPCD_FNAME"));
				}
				if(!Helper.correctNull((String)rs.getString("NPCD_LNAME")).equalsIgnoreCase(""))
				{
					name=name+" "+Helper.correctNull((String)rs.getString("NPCD_LNAME"));
				}
				if(!Helper.correctNull((String)rs.getString("NPCD_MNAME")).equalsIgnoreCase(""))
				{
					name=name+" "+Helper.correctNull((String)rs.getString("NPCD_MNAME"));
				}
				
				String StrName=name;
				
				String strLapsid1="",strNewapp1="",strCbsid1="";
				strQuery = SQLParser.getSqlQuery("seldedupecheckco_np^"+strRefno+"^"+StrName);
				rs1 = DBUtils.executeQuery(strQuery);			
				if(rs1.next())
				{
					strLapsid1=Helper.correctNull((String)rs1.getString("NP_LAPSID"));
					strNewapp1=Helper.correctNull((String)rs1.getString("NP_ISNEW"));
					strCbsid1=Helper.correctNull((String)rs1.getString("NP_CBSID"));
				}
				if(strNewapp1.equalsIgnoreCase("Y"))
				{
				String strsId="";
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","ins_npcustprofile");	
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_FNAME")));
				//arrValues.add(Helper.correctNull((String)rs.getString("NPCD_MNAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_LNAME")));
				arrValues.add(getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("NPCD_GENDER"))));
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_DOB")));
				//arrValues.add(Helper.correctNull((String)rs.getString("NPCD_EMAIL")));
				//arrValues.add(Helper.correctNull((String)rs.getString("NPCD_SOCIAL_CAT")));				
				//arrValues.add(Helper.correctNull((String)rs.getString("NPCD_MOBILE")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_FATORHUSB_NAME")));
				//arrValues.add(Helper.correctNull((String)rs.getString("NPCD_MOTHER_NAME")));
				//arrValues.add(Helper.correctNull((String)rs.getString("NPCD_MOTHER_NAME")));
				arrValues.add(getNPtoLAPSListOfValue("4",Helper.correctNull((String)rs.getString("NPCD_SALUTATION"))));
				arrValues.add(getNPtoLAPSListOfValue("5",Helper.correctNull((String)rs.getString("NPCD_MARITAL_STAT"))));
				//arrValues.add(getNPtoLAPSListOfValue("7",Helper.correctNull((String)rs.getString("NPCD_EDU_QUALIFY"))));
				arrValues.add(getNPtoLAPSListOfValue("6",Helper.correctNull((String)rs.getString("NPCD_EMPLOY_TYPE"))));
				//arrValues.add(getNPtoLAPSListOfValue("8",Helper.correctNull((String)rs.getString("NPCD_RESI_TYPE"))));
                arrValues.add("001");					
				arrValues.add("");				
				/*arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add(strbranchcode);*/
				arrValues.add(getNPtoLAPSCommonLOV(Helper.correctNull((String)hshValues.get("SchemeName")),
						Helper.correctNull((String)hshValues.get("selsegment")),"CUSTPRFSTATUS"));
				//arrValues.add(Helper.correctNull((String)hshValues.get("strOrgbankFlag")));
				LapsAppid = CustPrfAppID.getApplicantCode();
				arrValues.add(LapsAppid);
				arrValues.add(LapsAppid);
				strappcoappid = Helper.correctNull((String)rs.getString("NPCD_COAPP_REF_ID")); 
				
				StrOffadd = Helper.correctNull((String)rs.getString("NPCD_OFFICE_ADD_SEQ"));
				StrCut_add = Helper.correctNull((String)rs.getString("NPCD_AADHAR_ADD_SEQ"));
				
			
			/*if(rs1 != null){rs1.close();}
			if(!StrCut_add.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrCut_add);
			rs1 = DBUtils.executeQuery(strQuery);			
			if(rs1.next())
			{
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs1.getString("NPAD_LANDMARK")));
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME")));
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_VILLAGE")));
				String city=Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME"));
				String state=Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME"));
				if(!state.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
				rs3 = DBUtils.executeQuery(strQuery);			
				if(rs3.next())
				{
					arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
				}else{
					arrValues.add("");
				}
				}else{
					arrValues.add("");
				}
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_COUNTRY_NAME")));
				if(!city.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_city_name^"+city);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE")));
				
				
			}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}
			if(rs1 != null){rs1.close();}
			if(!StrOffadd.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
			rs1 = DBUtils.executeQuery(strQuery);			
			if(rs1.next())
			{
				
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs1.getString("NPAD_LANDMARK")));
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME")));
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_VILLAGE")));
				String city=Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME"));
				String state=Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME"));
				if(!state.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
				rs3 = DBUtils.executeQuery(strQuery);			
				if(rs3.next())
				{
					arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
				}else{
					arrValues.add("");
				}
				}else{
					arrValues.add("");
				}
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_COUNTRY_NAME")));
				if(!city.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_city_name^"+city);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE")));
			}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				
			}}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}
				
				
				
				arrValues.add("");*/
				System.out.print("arrValues update INCOME "+arrValues);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
				
				
				
				//DEDUPE LEVEL UPDATE
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","updperappid_np");	
				arrValues.add(LapsAppid);	
				arrValues.add(strRefno);
				arrValues.add(StrName);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
			
				//Insertion for Applicant Employment Details
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","ins_npempdetails1");	
				arrValues.add(LapsAppid);
				strquery1 = SQLParser.getSqlQuery("sel_npcoappdet^"+strRefno);
				rs1 = DBUtils.executeQuery(strquery1);			
				if(rs1.next())
				{
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_ORG_NAME")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_MOBILE")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_EMAIL")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_DESIGNATION")));
					arrValues.add("");
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_RETIRE_AGE")));
					strappcoappid = Helper.correctNull((String)rs1.getString("NPCD_COAPP_ID"));
					StrOffadd = Helper.correctNull((String)rs1.getString("NPCD_OFFICE_ADD_SEQ"));
					
					
				}
				arrValues.add("");
				arrValues.add("");
				arrValues.add(strsId);
				if(rs1 != null){rs1.close();}
				if(!StrOffadd.equalsIgnoreCase("")){
				strquery1 = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
				rs1 = DBUtils.executeQuery(strquery1);			
				if(rs1.next())
				{
					
					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs1.getString("NPAD_LANDMARK")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME")));
					arrValues.add("");
					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE")));
				}
				else
				{
					//arrValues.add(getaddArrayValues(6));
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");

				}}
				else
				{
					//arrValues.add(getaddArrayValues(6));
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");

				}
				System.out.print("arrValues update EMP "+arrValues);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
				
				
				
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_nplapscoappid");	
				arrValues.add(LapsAppid);	
				arrValues.add(strRefno);
				arrValues.add(strappcoappid);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
				}else{
					
					//ex.coapp application details insert
					String strOldAppId=strLapsid1;
					String strAppCode = CustPrfAppID.getApplicantCode();
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					arrValues.add(strAppCode);
					arrValues.add(Helper.correctNull((String)hshValues.get("strOrgShortCode")));
					arrValues.add("n");
					arrValues.add(strOldAppId);	
					arrValues.add(strOldAppId);	
					System.out.print("arrValues update co-app perapplicent "+arrValues);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","perapplicantrenew1");
					hshQueryValues.put("1",hshQuery);
					
					
					
					
					// update renew column in perapplicant table
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					arrValues.add("y");
					arrValues.add(strOldAppId);
					System.out.print("arrValues update co-app perapplicent "+arrValues);
					
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","perapplicantupdaterenew");
					hshQueryValues.put("2",hshQuery);

					// insert data in to perincexpences table
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					arrValues.add(strAppCode);
					arrValues.add(strOldAppId);
					System.out.print("arrValues update copy co-app income "+arrValues);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","perincomerenew");
					hshQueryValues.put("3",hshQuery);
					
					// insert data in to peremployer table
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					arrValues.add(strAppCode);
					arrValues.add(strOldAppId);
					hshQuery.put("arrValues",arrValues);
					System.out.print("arrValues update copy co-app employ "+arrValues);
					
					hshQuery.put("strQueryId","peremployerrenew");
					hshQueryValues.put("4",hshQuery);
					hshQueryValues.put("size","4");
					
					
					
					// insert data in to KYC norms table
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					arrValues.add(strAppCode);
					arrValues.add(strOldAppId);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","kycnormsrenew");
					System.out.print("arrValues update copy co-app kyc "+arrValues);
					
					hshQueryValues.put("5",hshQuery);
					hshQueryValues.put("size","5");
								
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
					
					String strsId="";
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","upd_npcustprofile");	
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_FNAME")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPCD_MNAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_LNAME")));
					arrValues.add(getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("NPCD_GENDER"))));
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_DOB")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPCD_EMAIL")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPCD_SOCIAL_CAT")));				
					//arrValues.add(Helper.correctNull((String)rs.getString("NPCD_MOBILE")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_FATORHUSB_NAME")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPCD_MOTHER_NAME")));
					//arrValues.add(Helper.correctNull((String)rs.getString("NPCD_MOTHER_NAME")));
					arrValues.add(getNPtoLAPSListOfValue("4",Helper.correctNull((String)rs.getString("NPCD_SALUTATION"))));
					arrValues.add(getNPtoLAPSListOfValue("5",Helper.correctNull((String)rs.getString("NPCD_MARITAL_STAT"))));
					//arrValues.add(getNPtoLAPSListOfValue("7",Helper.correctNull((String)rs.getString("NPCD_EDU_QUALIFY"))));
					arrValues.add(getNPtoLAPSListOfValue("6",Helper.correctNull((String)rs.getString("NPCD_EMPLOY_TYPE"))));
					//arrValues.add(getNPtoLAPSListOfValue("8",Helper.correctNull((String)rs.getString("NPCD_RESI_TYPE"))));				
					/*arrValues.add("");				
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add(strbranchcode);*/
					arrValues.add("003");
					arrValues.add("");	
					arrValues.add(getNPtoLAPSCommonLOV(Helper.correctNull((String)hshValues.get("SchemeName")),
							Helper.correctNull((String)hshValues.get("selsegment")),"CUSTPRFSTATUS"));
					//arrValues.add(Helper.correctNull((String)hshValues.get("strOrgbankFlag")));
					arrValues.add(strAppCode);
					strappcoappid = Helper.correctNull((String)rs.getString("NPCD_COAPP_REF_ID")); 
					
					StrOffadd = Helper.correctNull((String)rs.getString("NPCD_OFFICE_ADD_SEQ"));
					StrCut_add = Helper.correctNull((String)rs.getString("NPCD_AADHAR_ADD_SEQ"));
					
				
					/*if(rs != null){rs.close();}
					if(!StrCut_add.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrCut_add);
					rs = DBUtils.executeQuery(strQuery);			
					if(rs.next())
					{
						arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
						arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME")));
						arrValues.add(Helper.correctNull((String)rs.getString("NPAD_VILLAGE")));
						String city=Helper.correctNull((String)rs.getString("NPAD_CITY_NAME"));
						String state=Helper.correctNull((String)rs.getString("NPAD_STATE_NAME"));
						if(!state.equalsIgnoreCase("")){
						strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
						rs3 = DBUtils.executeQuery(strQuery);			
						if(rs3.next())
						{
							arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
						}else{
							arrValues.add("");
						}
						}else{
							arrValues.add("");
						}
						arrValues.add(Helper.correctNull((String)rs.getString("NPAD_COUNTRY_NAME")));
						if(!city.equalsIgnoreCase("")){
							strQuery = SQLParser.getSqlQuery("NP_city_name^"+city);
							rs3 = DBUtils.executeQuery(strQuery);			
							if(rs3.next())
							{
								arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
							}else{
								arrValues.add("");
							}
							}else{
								arrValues.add("");
							}	arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
						
						
					}
					else
					{
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
					}}
					else
					{
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
					}
					if(rs1 != null){rs1.close();}
					if(!StrOffadd.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
					rs1 = DBUtils.executeQuery(strQuery);			
					if(rs1.next())
					{
						
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs1.getString("NPAD_LANDMARK")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_VILLAGE")));
						String city=Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME"));
						String state=Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME"));
						if(!state.equalsIgnoreCase("")){
						strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
						rs3 = DBUtils.executeQuery(strQuery);			
						if(rs3.next())
						{
							arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
						}else{
							arrValues.add("");
						}
						}else{
							arrValues.add("");
						}
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_COUNTRY_NAME")));
						if(!city.equalsIgnoreCase("")){
							strQuery = SQLParser.getSqlQuery("NP_city_name^"+city);
							rs3 = DBUtils.executeQuery(strQuery);			
							if(rs3.next())
							{
								arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
							}else{
								arrValues.add("");
							}
							}else{
								arrValues.add("");
							}arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE")));
					}
					else
					{
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
					}}
					else
					{
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
					}
					arrValues.add("");
					arrValues.add(strAppCode);*/
					System.out.print("arrValues update co-app perapllicent "+arrValues);
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
					
					
					
					//DEDUPE LEVEL UPDATE
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","updperappid_np");	
					arrValues.add(strAppCode);	
					arrValues.add(strRefno);
					arrValues.add(StrName);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
					
					
					//Insertion for Applicant Employment Details
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","upd_npempdetails1");	
					
					strquery1 = SQLParser.getSqlQuery("sel_npcoappdet^"+strRefno);
					rs1 = DBUtils.executeQuery(strquery1);			
					if(rs1.next())
					{
						arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_ORG_NAME")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_MOBILE")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_EMAIL")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_DESIGNATION")));
						arrValues.add("");
						arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_RETIRE_AGE")));
						StrOffadd = Helper.correctNull((String)rs1.getString("NPCD_OFFICE_ADD_SEQ"));
						
						
						
					}
					arrValues.add("");
					arrValues.add("");
					arrValues.add(strsId);
					if(rs != null){rs.close();}
					if(!StrOffadd.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
					rs1 = DBUtils.executeQuery(strQuery);			
					if(rs1.next())
					{
						
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs1.getString("NPAD_LANDMARK")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_VILLAGE")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE")));
					}	
					else
					{
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");

					}}	
					else
					{
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");

					}
					arrValues.add(strAppCode);
					hshQuery.put("arrValues",arrValues);
					System.out.print("arrValues update copy co-app emp "+arrValues);
					
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
					
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","upd_nplapscoappid");	
					arrValues.add(strAppCode);	
					arrValues.add(strRefno);
					arrValues.add(strappcoappid);
					hshQuery.put("arrValues",arrValues);
					
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
					
				
					
				}
			}
				
				
			
		
			if(selsegment.equalsIgnoreCase("EDU")){
			hshappcr=getNPApplicationCreation(hshValues);			
			}else if(selsegment.equalsIgnoreCase("HL")){
				hshappcr=getNPHLApplicationCreation(hshValues);				
			}
			else if(selsegment.equalsIgnoreCase("AGRI")||selsegment.equalsIgnoreCase("LHD"))
			{
			hshappcr=getNP_AgriApplicationCreation(hshValues);	
			}
			hsh = getNpMailbox(hshValues);
			
		}
		catch(Exception ex)
		{
			Logger.log("Exception in getNpapplications"+ex);
		}	
		return hsh;
	}
	public HashMap getNPLiveliwoodCustProfileCreation(HashMap hshValues) 
	{
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs3 = null;
		HashMap hshRecord = new HashMap();
		HashMap hsh = new HashMap();
		String strQuery = "",strquery1="";
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		HashMap hshQueryValues = new HashMap();
		String strbranchcode=Helper.correctNull((String)hshValues.get("strOrgShortCode"));
		String strusrid=Helper.correctNull((String)hshValues.get("strUserId"));
		String strStatus=Helper.correctNull((String)hshValues.get("hidaction"));
		String strRefno = Helper.correctNull((String)hshValues.get("hidRefId"));
		if(strRefno.equalsIgnoreCase("")){
		 strRefno = Helper.correctNull((String)hshValues.get("hidApplicantId"));
		}
		String selsegment = Helper.correctNull((String)hshValues.get("selsegment"));
		if(selsegment.equalsIgnoreCase("")){
			selsegment = Helper.correctNull((String)hshValues.get("SegType"));
			}
		
		
		MastApplicantBean CustPrfAppID = new MastApplicantBean();
		String LapsAppid="";
		HashMap hshappcr = new HashMap();

		try
		{		
			String strappcoappid="";
			String StrName1="",strNewapp="",strLapsid="",strCbsid="";
			
			
			strQuery = SQLParser.getSqlQuery("seldedupecheck_np^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				strLapsid=Helper.correctNull((String)rs.getString("NP_LAPSID"));
				strNewapp=Helper.correctNull((String)rs.getString("NP_ISNEW"));
				strCbsid=Helper.correctNull((String)rs.getString("NP_CBSID"));
				StrName1=Helper.correctNull((String)rs.getString("NP_APPLICANTNAME"));
			}
			
			String StrOffadd="",StrCut_add="";
			if(strNewapp.equalsIgnoreCase("Y"))
			{
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","ins_npcustprofile");					
				strQuery = SQLParser.getSqlQuery("getPersonalDetails_NPUM^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					
					
					arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_LHPD_F_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_LHPD_M_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_LHPD_L_NAME")));
					arrValues.add(getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("NPLPD_GENDER"))));
					arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_DATE_OF_BIRTH")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_EMAIL")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_SOCI_CATE")));				
					arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_MOBILE")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_FATHER_NAME")));
					arrValues.add("");
					arrValues.add("");
					arrValues.add(getNPtoLAPSListOfValue("4",Helper.correctNull((String)rs.getString("NPLPD_SALUTION"))));
					arrValues.add(getNPtoLAPSListOfValue("5",Helper.correctNull((String)rs.getString("NPLPD_MARITAL_STATUS"))));
					arrValues.add((Helper.correctNull((String)rs.getString("NPLPD_EDU_QUAL_ID"))));
					arrValues.add("");
					arrValues.add("");
					arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_LHPD_PAN")));				
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add(strbranchcode);
					arrValues.add(getNPtoLAPSCommonLOV(Helper.correctNull((String)hshValues.get("SchemeName")),
							Helper.correctNull((String)hshValues.get("selsegment")),"CUSTPRFSTATUS"));
					arrValues.add(Helper.correctNull((String)hshValues.get("strOrgbankFlag")));
					LapsAppid = CustPrfAppID.getApplicantCode();
					arrValues.add(LapsAppid);
					arrValues.add(LapsAppid);
					strappcoappid = Helper.correctNull((String)rs.getString("NPLPD_APPID"));
					
					StrOffadd = Helper.correctNull((String)rs.getString("NPLPD_CURR_ADD_SEQ_NO"));
					StrCut_add = Helper.correctNull((String)rs.getString("NPLPD_AADHAR_ADD_SEQ_NO"));
						
				}	
			
			if(rs != null){rs.close();}
			if(!StrCut_add.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrCut_add);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_VILLAGE")));
				String city=Helper.correctNull((String)rs.getString("NPAD_CITY_NAME"));
				String state=Helper.correctNull((String)rs.getString("NPAD_STATE_NAME"));
				if(!state.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
				rs3 = DBUtils.executeQuery(strQuery);			
				if(rs3.next())
				{
					arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
				}else{
					arrValues.add("");
				}
				}else{
					arrValues.add("");
				}
				String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_COUNTRY_NAME")));
				if(!city.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
				
				
			}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}}else{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
	
			}
			if(rs != null){rs.close();}
			if(!StrOffadd.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_VILLAGE")));
				String city=Helper.correctNull((String)rs.getString("NPAD_CITY_NAME"));
				String state=Helper.correctNull((String)rs.getString("NPAD_STATE_NAME"));
				if(!state.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
				rs3 = DBUtils.executeQuery(strQuery);			
				if(rs3.next())
				{
					arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
				}else{
					arrValues.add("");
				}
				}else{
					arrValues.add("");
				}
				String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_COUNTRY_NAME")));
				if(!city.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
			}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				
			}}else{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}
			arrValues.add("");
			System.out.print("arrValues cust profile --"+arrValues);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
			
			
			//DEDUPE LEVEL UPDATE
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","updperappid_np");	
			arrValues.add(LapsAppid);	
			arrValues.add(strRefno);
			arrValues.add(StrName1);
			System.out.print("arrValues dedupe old id --"+arrValues);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			
			
			
			
			//Insertion for Employment Details
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","ins_npempdetails1");	
			arrValues.add(LapsAppid);
			
				strQuery = SQLParser.getSqlQuery("getPersonalDetails_NPUM^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_LHPD_F_NAME"))+" "+Helper.correctNull((String)rs.getString("NPLPD_LHPD_M_NAME"))+" "+Helper.correctNull((String)rs.getString("NPLPD_LHPD_L_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_MOBILE")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_EMAIL")));
					arrValues.add("");
					arrValues.add("A");
					arrValues.add("");
					strappcoappid = Helper.correctNull((String)rs.getString("NPLPD_APPID"));
					StrOffadd = Helper.correctNull((String)rs.getString("NPLPD_AADHAR_ADD_SEQ_NO"));
				}
			
			arrValues.add("");
			arrValues.add("");
			arrValues.add("0");
			if(rs != null){rs.close();}
			if(!StrOffadd.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_VILLAGE")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_CITY_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STATE_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
			}	
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}}else{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}
			System.out.print("arrValues employment details --"+arrValues);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
			
			
			String app_id="0";
			Double grossincome=0.0,otherincome=0.0,incometax=0.0;
			strquery1 = SQLParser.getSqlQuery("sel_npFinancial1^"+strRefno);
			rs1 = DBUtils.executeQuery(strquery1);			
			if(rs1.next())
			{
				
				String grossincome1="0",net_monthly_income="0",salary_income="0";
				String house_property="0",other_source="0",capital_gain="0";
				 grossincome1=Helper.correctNull((String)rs1.getString("NPFD_GROSS_MONTHLY_INCOME"));
				 net_monthly_income=Helper.correctNull((String)rs1.getString("NPFD_NET_MONTHLY_INCOME"));
				 salary_income=Helper.correctNull((String)rs1.getString("NPFD_SALARY_INCOME"));
				
				 house_property=Helper.correctNull((String)rs1.getString("NPFD_HOUSE_PROPERTY"));
				 other_source=Helper.correctNull((String)rs1.getString("NPFD_OTHER_SOURCE"));
				 capital_gain=Helper.correctNull((String)rs1.getString("NPFD_CAPITAL_GAIN"));
				
				 app_id=Helper.correctNull((String)rs1.getString("NPFD_ID"));
				 String Taxincome=Helper.correctNull((String)rs1.getString("NPFD_TAXABLE_INCOME"));
				 
				 if(!Taxincome.equalsIgnoreCase("")){
					 incometax=Double.valueOf(Taxincome);
					 }
					 if(grossincome1.equalsIgnoreCase("")){
						 grossincome1="0";
					 }
						 if(net_monthly_income.equalsIgnoreCase("")){
							 net_monthly_income="0";
						 }
							 if(salary_income.equalsIgnoreCase("")){
								 salary_income="0";
							 }
					grossincome=Double.valueOf(grossincome1)+Double.valueOf(net_monthly_income)+Double.valueOf(salary_income);
											 
					
					 if(house_property.equalsIgnoreCase("")){
						 house_property="0";
					 }
						 if(other_source.equalsIgnoreCase("")){
							 other_source="0";
						 }
							 if(capital_gain.equalsIgnoreCase("")){
								 capital_gain="0";
							 }
					 otherincome=Double.valueOf(house_property)+Double.valueOf(other_source)+Double.valueOf(capital_gain);
							 
				 
			}
			//income and expence
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","ins_incomeexpeneperapp_np");
			arrValues.add(LapsAppid);	
			arrValues.add(String.valueOf(grossincome));
			arrValues.add(String.valueOf(otherincome));
			arrValues.add(String.valueOf(incometax));
			arrValues.add("A");
			arrValues.add("1");
			System.out.print("arrValues income details --"+arrValues);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
			
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","upd_nplapsappid");	
			arrValues.add(LapsAppid);	
			arrValues.add(strRefno);			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","upd_nplapsappid6");	
			arrValues.add(LapsAppid);	
			arrValues.add(strRefno);			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			
			}else{
				
				//ex.application creation for applicant
				
				String strOldAppId=strLapsid;
				String strAppCode = CustPrfAppID.getApplicantCode();
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				arrValues.add(strAppCode);
				arrValues.add(Helper.correctNull((String)hshValues.get("strOrgShortCode")));
				arrValues.add("n");
				arrValues.add(strOldAppId);	
				arrValues.add(strOldAppId);	
				System.out.print("arrValues perapplication  --"+arrValues);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","perapplicantrenew1");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
				
				
				// update renew column in perapplicant table
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				arrValues.add("y");
				arrValues.add(strOldAppId);
				System.out.print("arrValues perapplication1 --"+arrValues);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","perapplicantupdaterenew");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
				// insert data in to perincexpences table
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				arrValues.add(strAppCode);
				arrValues.add(strOldAppId);
				System.out.print("arrValues income  --"+arrValues);
				
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","perincomerenew");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
				// insert data in to peremployer table
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				arrValues.add(strAppCode);
				arrValues.add(strOldAppId);
				System.out.print("arrValues employment  --"+arrValues);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","peremployerrenew");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
				arrValues=new ArrayList();
				hshQuery=new HashMap();			
				arrValues.add(strOldAppId);
				arrValues.add(strAppCode);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_perapplicant_idmap");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
				
				
				// insert data in to KYC norms table
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				arrValues.add(strAppCode);
				arrValues.add(strOldAppId);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","kycnormsrenew");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");			
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
				
				
				//update nationalportal data
				
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_npcustprofile");					
			
				strQuery = SQLParser.getSqlQuery("getPersonalDetails_NPUM^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_LHPD_F_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_LHPD_M_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_LHPD_L_NAME")));
					arrValues.add(getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("NPLPD_GENDER"))));
					arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_DATE_OF_BIRTH")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_EMAIL")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_SOCI_CATE")));				
					arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_MOBILE")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_FATHER_NAME")));
					arrValues.add("");
					arrValues.add("");
					arrValues.add(getNPtoLAPSListOfValue("4",Helper.correctNull((String)rs.getString("NPLPD_SALUTION"))));
					arrValues.add(getNPtoLAPSListOfValue("5",Helper.correctNull((String)rs.getString("NPLPD_MARITAL_STATUS"))));
					arrValues.add((Helper.correctNull((String)rs.getString("NPLPD_EDU_QUAL_ID"))));
					arrValues.add("");
					arrValues.add("");
					arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_LHPD_PAN")));				
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add(strbranchcode);
					arrValues.add(getNPtoLAPSCommonLOV(Helper.correctNull((String)hshValues.get("SchemeName")),
							Helper.correctNull((String)hshValues.get("selsegment")),"CUSTPRFSTATUS"));
					arrValues.add(Helper.correctNull((String)hshValues.get("strOrgbankFlag")));
					arrValues.add(strAppCode);
					strappcoappid = Helper.correctNull((String)rs.getString("NPLPD_APPID"));
					
					StrOffadd = Helper.correctNull((String)rs.getString("NPLPD_CURR_ADD_SEQ_NO"));
					StrCut_add = Helper.correctNull((String)rs.getString("NPLPD_AADHAR_ADD_SEQ_NO"));
				}
			
			if(rs != null){rs.close();}
			if(!StrCut_add.equalsIgnoreCase("")){
				
			strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrCut_add);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_VILLAGE")));
				String city=Helper.correctNull((String)rs.getString("NPAD_CITY_NAME"));
				String state=Helper.correctNull((String)rs.getString("NPAD_STATE_NAME"));
				if(!state.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
				rs3 = DBUtils.executeQuery(strQuery);			
				if(rs3.next())
				{
					arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
				}else{
					arrValues.add("");
				}
				}else{
					arrValues.add("");
				}
				String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_COUNTRY_NAME")));
				if(!city.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
				
				
			}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}}else{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");	
			}
			if(rs != null){rs.close();}
			if(!StrOffadd.equalsIgnoreCase("")){
				
			strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_VILLAGE")));
				String city=Helper.correctNull((String)rs.getString("NPAD_CITY_NAME"));
				String state=Helper.correctNull((String)rs.getString("NPAD_STATE_NAME"));
				if(!state.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
				rs3 = DBUtils.executeQuery(strQuery);			
				if(rs3.next())
				{
					arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
				}else{
					arrValues.add("");
				}
				}else{
					arrValues.add("");
				}
				String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_COUNTRY_NAME")));
				if(!city.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}	arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
			}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				
			}}else{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}
				arrValues.add("");
				arrValues.add(strAppCode);
				System.out.print("arrValues update demo "+arrValues);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
				
				//Insertion for Employment Details
				hshQuery = new HashMap();
 				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_npempdetails1");	
			
					strQuery = SQLParser.getSqlQuery("getPersonalDetails_NPUM^"+strRefno);
					rs = DBUtils.executeQuery(strQuery);			
					if(rs.next())
					{
					arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_LHPD_F_NAME"))+" "+Helper.correctNull((String)rs.getString("NPLPD_LHPD_M_NAME"))+" "+Helper.correctNull((String)rs.getString("NPLPD_LHPD_L_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_MOBILE")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPLPD_EMAIL")));
					arrValues.add("");
					arrValues.add("A");
					arrValues.add("");
					strappcoappid = Helper.correctNull((String)rs.getString("NPLPD_APPID"));
					StrOffadd = Helper.correctNull((String)rs.getString("NPLPD_AADHAR_ADD_SEQ_NO"));
					}
					
				arrValues.add("");
				arrValues.add("");
				arrValues.add("0");
				if(rs != null){rs.close();}
				if(!StrOffadd.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_VILLAGE")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_CITY_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STATE_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
				}	
				else
				{
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
				}}else{
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
				}
				arrValues.add(strAppCode);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
				
				
				String app_id="0";
				Double grossincome=0.0,otherincome=0.0,incometax=0.0;
				strquery1 = SQLParser.getSqlQuery("sel_npFinancial1^"+strRefno);
				rs1 = DBUtils.executeQuery(strquery1);			
				if(rs1.next())
				{
					
					String grossincome1="0",net_monthly_income="0",salary_income="0";
					String house_property="0",other_source="0",capital_gain="0";
					 grossincome1=Helper.correctNull((String)rs1.getString("NPFD_GROSS_MONTHLY_INCOME"));
					 net_monthly_income=Helper.correctNull((String)rs1.getString("NPFD_NET_MONTHLY_INCOME"));
					 salary_income=Helper.correctNull((String)rs1.getString("NPFD_SALARY_INCOME"));
					
					 house_property=Helper.correctNull((String)rs1.getString("NPFD_HOUSE_PROPERTY"));
					 other_source=Helper.correctNull((String)rs1.getString("NPFD_OTHER_SOURCE"));
					 capital_gain=Helper.correctNull((String)rs1.getString("NPFD_CAPITAL_GAIN"));
					
					 app_id=Helper.correctNull((String)rs1.getString("NPFD_ID"));
					 String Taxincome=Helper.correctNull((String)rs1.getString("NPFD_TAXABLE_INCOME"));
					 
					 if(!Taxincome.equalsIgnoreCase("")){
						 incometax=Double.valueOf(Taxincome);
						 }
						 if(grossincome1.equalsIgnoreCase("")){
							 grossincome1="0";
						 }
							 if(net_monthly_income.equalsIgnoreCase("")){
								 net_monthly_income="0";
							 }
								 if(salary_income.equalsIgnoreCase("")){
									 salary_income="0";
								 }
						grossincome=Double.valueOf(grossincome1)+Double.valueOf(net_monthly_income)+Double.valueOf(salary_income);
												 
						
						 if(house_property.equalsIgnoreCase("")){
							 house_property="0";
						 }
							 if(other_source.equalsIgnoreCase("")){
								 other_source="0";
							 }
								 if(capital_gain.equalsIgnoreCase("")){
									 capital_gain="0";
								 }
						 otherincome=Double.valueOf(house_property)+Double.valueOf(other_source)+Double.valueOf(capital_gain);
								 
					 
				}
				//income and expence
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_incomeexpeneperapp_np");
				arrValues.add(String.valueOf(grossincome));
				arrValues.add(String.valueOf(otherincome));
				arrValues.add(String.valueOf(incometax));
				arrValues.add("A");
				arrValues.add("1");
				arrValues.add(strAppCode);
				System.out.print("arrValues update INCOME "+arrValues);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
				
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_nplapsappid");	
				arrValues.add(strAppCode);	
				arrValues.add(strRefno);			
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_nplapsappid6");	
				arrValues.add(strAppCode);	
				arrValues.add(strRefno);			
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				//DEDUPE LEVEL UPDATE
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","updperappid_np1");	
				arrValues.add(strAppCode);	
				arrValues.add(strRefno);
				//arrValues.add(StrName1);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
				
			}
			
			//Insertion block for Coapplicant Data
		
			strQuery = SQLParser.getSqlQuery("sel_npcoappdet^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			while(rs.next())
			{	
				String name="";
				if(!Helper.correctNull((String)rs.getString("NPCD_FNAME")).equalsIgnoreCase(""))
				{
					name=Helper.correctNull((String)rs.getString("NPCD_FNAME"));
				}
				if(!Helper.correctNull((String)rs.getString("NPCD_LNAME")).equalsIgnoreCase(""))
				{
					name=name+" "+Helper.correctNull((String)rs.getString("NPCD_LNAME"));
				}
				if(!Helper.correctNull((String)rs.getString("NPCD_MNAME")).equalsIgnoreCase(""))
				{
					name=name+" "+Helper.correctNull((String)rs.getString("NPCD_MNAME"));
				}
				
				String StrName=name;
				String strLapsid1="",strNewapp1="",strCbsid1="";
				strQuery = SQLParser.getSqlQuery("seldedupecheckco_np^"+strRefno+"^"+StrName);
				rs1 = DBUtils.executeQuery(strQuery);			
				if(rs1.next())
				{
					strLapsid1=Helper.correctNull((String)rs1.getString("NP_LAPSID"));
					strNewapp1=Helper.correctNull((String)rs1.getString("NP_ISNEW"));
					strCbsid1=Helper.correctNull((String)rs1.getString("NP_CBSID"));
				}
				if(strNewapp1.equalsIgnoreCase("Y"))
				{
				String strsId="";
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","ins_npcustprofile");	
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_FNAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_MNAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_LNAME")));
				arrValues.add(getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("NPCD_GENDER"))));
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_DOB")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_EMAIL")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_SOCIAL_CAT")));				
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_MOBILE")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_FATORHUSB_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_MOTHER_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_MOTHER_NAME")));
				arrValues.add(getNPtoLAPSListOfValue("4",Helper.correctNull((String)rs.getString("NPCD_SALUTATION"))));
				arrValues.add(getNPtoLAPSListOfValue("5",Helper.correctNull((String)rs.getString("NPCD_MARITAL_STAT"))));
				arrValues.add(getNPtoLAPSListOfValue("7",Helper.correctNull((String)rs.getString("NPCD_EDU_QUALIFY"))));
				arrValues.add(getNPtoLAPSListOfValue("6",Helper.correctNull((String)rs.getString("NPCD_EMPLOY_TYPE"))));
				arrValues.add(getNPtoLAPSListOfValue("8",Helper.correctNull((String)rs.getString("NPCD_RESI_TYPE"))));				
				arrValues.add("");				
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add(strbranchcode);
				arrValues.add(getNPtoLAPSCommonLOV(Helper.correctNull((String)hshValues.get("SchemeName")),
						Helper.correctNull((String)hshValues.get("selsegment")),"CUSTPRFSTATUS"));
				arrValues.add(Helper.correctNull((String)hshValues.get("strOrgbankFlag")));
				LapsAppid = CustPrfAppID.getApplicantCode();
				arrValues.add(LapsAppid);
				arrValues.add(LapsAppid);
				strappcoappid = Helper.correctNull((String)rs.getString("NPCD_COAPP_REF_ID")); 
				
				StrOffadd = Helper.correctNull((String)rs.getString("NPCD_OFFICE_ADD_SEQ"));
				StrCut_add = Helper.correctNull((String)rs.getString("NPCD_AADHAR_ADD_SEQ"));
				
			
			if(rs1 != null){rs1.close();}
			if(!StrCut_add.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrCut_add);
			rs1 = DBUtils.executeQuery(strQuery);			
			if(rs1.next())
			{
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs1.getString("NPAD_LANDMARK")));
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME")));
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_VILLAGE")));
				String city=Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME"));
				String state=Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME"));
				if(!state.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
				rs3 = DBUtils.executeQuery(strQuery);			
				if(rs3.next())
				{
					arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
				}else{
					arrValues.add("");
				}
				}else{
					arrValues.add("");
				}
				String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_COUNTRY_NAME")));
				if(!city.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE")));
				
				
			}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}
			if(rs1 != null){rs1.close();}
			if(!StrOffadd.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
			rs1 = DBUtils.executeQuery(strQuery);			
			if(rs1.next())
			{
				
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs1.getString("NPAD_LANDMARK")));
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME")));
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_VILLAGE")));
				String city=Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME"));
				String state=Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME"));
				if(!state.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
				rs3 = DBUtils.executeQuery(strQuery);			
				if(rs3.next())
				{
					arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
				}else{
					arrValues.add("");
				}
				}else{
					arrValues.add("");
				}
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_COUNTRY_NAME")));
				if(!city.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_city_name^"+city);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE")));
			}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				
			}}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}
				
				
				
				arrValues.add("");
				System.out.print("arrValues update INCOME "+arrValues);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
				
				
				
				//DEDUPE LEVEL UPDATE
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","updperappid_np");	
				arrValues.add(LapsAppid);	
				arrValues.add(strRefno);
				arrValues.add(StrName);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
			
				//Insertion for Applicant Employment Details
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","ins_npempdetails1");	
				arrValues.add(LapsAppid);
				strquery1 = SQLParser.getSqlQuery("sel_npcoappdet^"+strRefno);
				rs1 = DBUtils.executeQuery(strquery1);			
				if(rs1.next())
				{
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_ORG_NAME")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_MOBILE")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_EMAIL")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_DESIGNATION")));
					arrValues.add("");
					arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_RETIRE_AGE")));
					strappcoappid = Helper.correctNull((String)rs1.getString("NPCD_COAPP_ID"));
					StrOffadd = Helper.correctNull((String)rs1.getString("NPCD_OFFICE_ADD_SEQ"));
					
					
				}
				arrValues.add("");
				arrValues.add("");
				arrValues.add(strsId);
				if(rs1 != null){rs1.close();}
				if(!StrOffadd.equalsIgnoreCase("")){
				strquery1 = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
				rs1 = DBUtils.executeQuery(strquery1);			
				if(rs1.next())
				{
					
					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs1.getString("NPAD_LANDMARK")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME")));
					arrValues.add("");
					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME")));
					arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE")));
				}
				else
				{
					//arrValues.add(getaddArrayValues(6));
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");

				}}
				else
				{
					//arrValues.add(getaddArrayValues(6));
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");

				}
				System.out.print("arrValues update EMP "+arrValues);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
				
				
				
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_nplapscoappid");	
				arrValues.add(LapsAppid);	
				arrValues.add(strRefno);
				arrValues.add(strappcoappid);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
				}else{
					
					//ex.coapp application details insert
					String strOldAppId=strLapsid;
					String strAppCode = CustPrfAppID.getApplicantCode();
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					arrValues.add(strAppCode);
					arrValues.add(Helper.correctNull((String)hshValues.get("strOrgShortCode")));
					arrValues.add("n");
					arrValues.add(strOldAppId);	
					arrValues.add(strOldAppId);	
					System.out.print("arrValues update co-app perapplicent "+arrValues);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","perapplicantrenew1");
					hshQueryValues.put("1",hshQuery);
					
					
					
					
					// update renew column in perapplicant table
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					arrValues.add("y");
					arrValues.add(strOldAppId);
					System.out.print("arrValues update co-app perapplicent "+arrValues);
					
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","perapplicantupdaterenew");
					hshQueryValues.put("2",hshQuery);

					// insert data in to perincexpences table
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					arrValues.add(strAppCode);
					arrValues.add(strOldAppId);
					System.out.print("arrValues update copy co-app income "+arrValues);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","perincomerenew");
					hshQueryValues.put("3",hshQuery);
					
					// insert data in to peremployer table
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					arrValues.add(strAppCode);
					arrValues.add(strOldAppId);
					hshQuery.put("arrValues",arrValues);
					System.out.print("arrValues update copy co-app employ "+arrValues);
					
					hshQuery.put("strQueryId","peremployerrenew");
					hshQueryValues.put("4",hshQuery);
					hshQueryValues.put("size","4");
					
					
					
					// insert data in to KYC norms table
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					arrValues.add(strAppCode);
					arrValues.add(strOldAppId);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","kycnormsrenew");
					System.out.print("arrValues update copy co-app kyc "+arrValues);
					
					hshQueryValues.put("5",hshQuery);
					hshQueryValues.put("size","5");
								
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
					
					String strsId="";
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","s");	
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_FNAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_MNAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_LNAME")));
					arrValues.add(getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("NPCD_GENDER"))));
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_DOB")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_EMAIL")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_SOCIAL_CAT")));				
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_MOBILE")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_FATORHUSB_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_MOTHER_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_MOTHER_NAME")));
					arrValues.add(getNPtoLAPSListOfValue("4",Helper.correctNull((String)rs.getString("NPCD_SALUTATION"))));
					arrValues.add(getNPtoLAPSListOfValue("5",Helper.correctNull((String)rs.getString("NPCD_MARITAL_STAT"))));
					arrValues.add(getNPtoLAPSListOfValue("7",Helper.correctNull((String)rs.getString("NPCD_EDU_QUALIFY"))));
					arrValues.add(getNPtoLAPSListOfValue("6",Helper.correctNull((String)rs.getString("NPCD_EMPLOY_TYPE"))));
					arrValues.add(getNPtoLAPSListOfValue("8",Helper.correctNull((String)rs.getString("NPCD_RESI_TYPE"))));				
					arrValues.add("");				
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add(strbranchcode);
					arrValues.add(getNPtoLAPSCommonLOV(Helper.correctNull((String)hshValues.get("SchemeName")),
							Helper.correctNull((String)hshValues.get("selsegment")),"CUSTPRFSTATUS"));
					arrValues.add(Helper.correctNull((String)hshValues.get("strOrgbankFlag")));
					arrValues.add(strAppCode);
					strappcoappid = Helper.correctNull((String)rs.getString("NPCD_COAPP_REF_ID")); 
					
					StrOffadd = Helper.correctNull((String)rs.getString("NPCD_OFFICE_ADD_SEQ"));
					StrCut_add = Helper.correctNull((String)rs.getString("NPCD_AADHAR_ADD_SEQ"));
					
				
					if(rs != null){rs.close();}
					if(!StrCut_add.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrCut_add);
					rs = DBUtils.executeQuery(strQuery);			
					if(rs.next())
					{
						arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
						arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME")));
						arrValues.add(Helper.correctNull((String)rs.getString("NPAD_VILLAGE")));
						String city=Helper.correctNull((String)rs.getString("NPAD_CITY_NAME"));
						String state=Helper.correctNull((String)rs.getString("NPAD_STATE_NAME"));
						if(!state.equalsIgnoreCase("")){
						strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
						rs3 = DBUtils.executeQuery(strQuery);			
						if(rs3.next())
						{
							arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
						}else{
							arrValues.add("");
						}
						}else{
							arrValues.add("");
						}
						arrValues.add(Helper.correctNull((String)rs.getString("NPAD_COUNTRY_NAME")));
						if(!city.equalsIgnoreCase("")){
							strQuery = SQLParser.getSqlQuery("NP_city_name^"+city);
							rs3 = DBUtils.executeQuery(strQuery);			
							if(rs3.next())
							{
								arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
							}else{
								arrValues.add("");
							}
							}else{
								arrValues.add("");
							}arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
						
						
					}
					else
					{
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
					}}
					else
					{
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
					}
					if(rs1 != null){rs1.close();}
					if(!StrOffadd.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
					rs1 = DBUtils.executeQuery(strQuery);			
					if(rs1.next())
					{
						
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs1.getString("NPAD_LANDMARK")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_VILLAGE")));
						String city=Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME"));
						String state=Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME"));
						if(!state.equalsIgnoreCase("")){
						strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
						rs3 = DBUtils.executeQuery(strQuery);			
						if(rs3.next())
						{
							arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
						}else{
							arrValues.add("");
						}
						}else{
							arrValues.add("");
						}
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_COUNTRY_NAME")));
						if(!city.equalsIgnoreCase("")){
							strQuery = SQLParser.getSqlQuery("NP_city_name^"+city);
							rs3 = DBUtils.executeQuery(strQuery);			
							if(rs3.next())
							{
								arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
							}else{
								arrValues.add("");
							}
							}else{
								arrValues.add("");
							}arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE")));
					}
					else
					{
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
					}}
					else
					{
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
					}
					arrValues.add("");
					arrValues.add(strAppCode);
					System.out.print("arrValues update co-app perapllicent "+arrValues);
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
					
					
					
					//DEDUPE LEVEL UPDATE
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","updperappid_np");	
					arrValues.add(strAppCode);	
					arrValues.add(strRefno);
					arrValues.add(StrName);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
					
					
					//Insertion for Applicant Employment Details
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","upd_npempdetails1");	
					
					strquery1 = SQLParser.getSqlQuery("sel_npcoappdet^"+strRefno);
					rs1 = DBUtils.executeQuery(strquery1);			
					if(rs1.next())
					{
						arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_ORG_NAME")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_MOBILE")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_EMAIL")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_DESIGNATION")));
						arrValues.add("");
						arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_RETIRE_AGE")));
						StrOffadd = Helper.correctNull((String)rs1.getString("NPCD_OFFICE_ADD_SEQ"));
						
						
						
					}
					arrValues.add("");
					arrValues.add("");
					arrValues.add(strsId);
					if(rs != null){rs.close();}
					if(!StrOffadd.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
					rs1 = DBUtils.executeQuery(strQuery);			
					if(rs1.next())
					{
						
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs1.getString("NPAD_LANDMARK")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_VILLAGE")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME")));
						arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE")));
					}	
					else
					{
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");

					}}	
					else
					{
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");

					}
					arrValues.add(strAppCode);
					hshQuery.put("arrValues",arrValues);
					System.out.print("arrValues update copy co-app emp "+arrValues);
					
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
					
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","upd_nplapscoappid");	
					arrValues.add(strAppCode);	
					arrValues.add(strRefno);
					arrValues.add(strappcoappid);
					hshQuery.put("arrValues",arrValues);
					
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
					
				
					
				}
			}
				
				
			
			hshappcr=getNPApplicationCreation_BS(hshValues);	
			hsh = getNpMailbox(hshValues);
			
		}
		catch(Exception ex)
		{
			Logger.log("Exception in getNpapplications"+ex);
		}	
		return hsh;
	}
	private String getaddArrayValues(int intval) 
	{
		 ResultSet rs = null;
		 String strarrayval="";
		 try
		 {
			 for(int k=0;k<intval-1;k++)
			 {
				 strarrayval=strarrayval+", ";
			 }
		 }
		 catch(Exception ce)
		 {
			 throw new EJBException("Error in getAddArrayList" + ce.toString());
		 }
		 finally 
		 {
			try 
			{
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection " 	+ cf.getMessage());
			}
		 }
		 return strarrayval;
	}
	public HashMap getNPApplicationCreation(HashMap hshValues) 
	{
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		HashMap hsh = new HashMap();
		String strQuery = "",strquery1="";
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		HashMap hshQueryValues = new HashMap();
		String strbranchcode=Helper.correctNull((String)hshValues.get("strOrgShortCode"));
		String strusrid=Helper.correctNull((String)hshValues.get("strUserId"));
		String strStatus=Helper.correctNull((String)hshValues.get("hidaction"));
		String strRefno = Helper.correctNull((String)hshValues.get("hidRefId"));
		MastApplicantBean CustPrfAppID = new MastApplicantBean();
		String LapsAppid="";
		HashMap hshResult = new HashMap();
		HashMap hshLoanProduct = new HashMap();
		HashMap hshlockvalues = new HashMap();
		String strApplicationNo="";
		int intUpdatesize=0;
		String hidApploanType = Helper.correctNull((String)hshValues.get("hidloanapptype"));
		String strOrglevel=correctNull((String)hshValues.get("strOrgLevel"));
        String strissaral=correctNull((String)hshValues.get("strIsSaral"));
		String strOrgbankFlag=correctNull((String)hshValues.get("strOrgbankFlag"));
		String strAppBankName=correctNull((String)hshValues.get("strAppBankName"));
        String strFromuserid=Helper.correctNull((String)hshValues.get("strUserId"));
        if(strRefno.equalsIgnoreCase("")){
        	strRefno  = Helper.correctNull((String)hshValues.get("hidApplicantId"));
        }
        
		HashMap hshqueryval = new HashMap();
		ArrayList arr = new ArrayList();

		try
		{	
			String Schemetype="";
			strQuery = SQLParser.getSqlQuery("sel_applicationscheme_np^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				Schemetype=Helper.correctNull((String)rs.getString("NPDT_NP_SCHEME_NAME"));
			}
			String strInwardno="",strappno="",strLapsappid="";
			if(rs != null){rs.close();}
			strQuery = SQLParser.getSqlQuery("sel_npapplicationdetails^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{			
				strInwardno = Helper.correctNull((String)rs.getString("NPDT_INWARDNO"));	
			}
			if(rs != null){rs.close();}
			String StrName1="";
			strQuery = SQLParser.getSqlQuery("sel_nppersonaldetails^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{	
				String name="";
				if(!Helper.correctNull((String)rs.getString("NPPD_FIRST_NAME")).equalsIgnoreCase(""))
				{
					name=Helper.correctNull((String)rs.getString("NPPD_FIRST_NAME"));
				}
				if(!Helper.correctNull((String)rs.getString("NPPD_LAST_NAME")).equalsIgnoreCase(""))
				{
					name=name+" "+Helper.correctNull((String)rs.getString("NPPD_LAST_NAME"));
				}
				if(!Helper.correctNull((String)rs.getString("NPPD_MIDDLE_NAME")).equalsIgnoreCase(""))
				{
					name=name+" "+Helper.correctNull((String)rs.getString("NPPD_MIDDLE_NAME"));
				}
				
				 StrName1=name;
				strLapsappid=Helper.correctNull((String)rs.getString("NPPD_LAPSAPPID"));
			}
           String StrNames="",strNewapp="",strLapsid="",strCbsid="";
			
			
			strQuery = SQLParser.getSqlQuery("seldedupecheck_np^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				strLapsid=Helper.correctNull((String)rs.getString("NP_LAPSID"));
				strNewapp=Helper.correctNull((String)rs.getString("NP_ISNEW"));
				strCbsid=Helper.correctNull((String)rs.getString("NP_CBSID"));
				StrNames=Helper.correctNull((String)rs.getString("NP_APPLICANTNAME"));
			}
			/*strQuery = SQLParser.getSqlQuery("selperappid_np^"+strRefno+"^"+StrName1);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				strLapsappid=Helper.correctNull((String)rs1.getString("NP_LAPSID"));
			}*/
			
			int intappno=0;
			hshlockvalues = new HashMap();
			hshlockvalues.put("apptype",Helper.correctNull((String)hshValues.get("hidloanapptype")));//to be pass
			hshlockvalues.put("comapp_id",strLapsappid);
			hshlockvalues.put("orgscode",correctNull((String) hshValues.get("strOrgShortCode")));
			double dblloanamnt=0.00,dblsubsidyamnt=0.00,dblROI=0.00,dblEMI=0.00;
			String strtenor="";			
			
			
			//strApplicationNo = (String) EJBInvoker.executeStateLess("appeditlock", hshlockvalues, "getAppno");
				String strOrgShortCode="",strBorrowerId="",strorgcode="",strscode="";
				String strAppno="";
				long longAppno=0;
				int intLen=0;
				String neworgscode ="";
				neworgscode= correctNull((String)hshValues.get("sel_neworg"));
				java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
				nf.setMinimumIntegerDigits(7);
				nf.setGroupingUsed(false);
						strQuery=SQLParser.getSqlQuery("findBorrowerOrgPer^"+strLapsappid);
						if(rs != null)
						{
							rs.close();
						}
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strOrgShortCode =correctNull((String)rs.getString(1));
						}
					
					
					if(strOrgShortCode.equalsIgnoreCase(""))
					{
						
						strOrgShortCode=correctNull((String) hshValues.get("strOrgShortCode"));
					}
					strOrgShortCode = strOrgShortCode.trim();
					
					int scodeLength=strOrgShortCode.length();
					
					if(scodeLength==1){
						strOrgShortCode="000"+strOrgShortCode;
					}
					if(scodeLength==2){
						strOrgShortCode="00"+strOrgShortCode;
					}
					if(scodeLength==3){
						strOrgShortCode="0"+strOrgShortCode;
					}
					intLen=strOrgShortCode.length();
					//intLen=neworgscode.length();
					strQuery=SQLParser.getSqlQuery("getAppno^"+(intLen+1)+"^"+intLen+"^"+strOrgShortCode);
					//strQuery=SQLParser.getSqlQuery("getAppno^"+(intLen+1)+"^"+intLen+"^"+neworgscode);
					//strQuery=SQLParser.getSqlQuery("getAppno^"+intLen+"^"+strOrgShortCode);
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						longAppno=(rs.getLong(1));
					}
					longAppno++;
					strApplicationNo=strOrgShortCode+nf.format(longAppno);
					//strApplicationNo=neworgscode + nf.format(longAppno);
				
			if(!strApplicationNo.equalsIgnoreCase(""))
			{
				intappno = Integer.parseInt(strApplicationNo.substring((strApplicationNo.length()-7), strApplicationNo.length()));
			}
			if (!(strApplicationNo.equalsIgnoreCase("new") && hidApploanType.equalsIgnoreCase("")))
			{
				intUpdatesize++;
				arrValues.add(strApplicationNo);
				
				String strGender="";
                strQuery = SQLParser.getSqlQuery("sel_npGender^"+strRefno);

	rs = DBUtils.executeQuery(strQuery);			
	if(rs.next())
	{
		strGender=Helper.correctNull((String)rs.getString("NPPD_GENDER"));
	}
	
	if(Schemetype.equalsIgnoreCase("csis")){//schemeTypeName
	  if(strGender.equalsIgnoreCase("Male"))
	   {
		 arrValues.add("139");
		 //arrValues.add("434");//male prdCode					
	   }
	  else
	   {
		 arrValues.add("141");
		// arrValues.add("593");//Female prdCode 
	   }
	}
				
				/*if(Schemetype.equalsIgnoreCase("")){
					arrValues.add(getNPtoLAPSCommonLOV(Helper.correctNull((String)hshValues.get("SchemeName")),
							Helper.correctNull((String)hshValues.get("selsegment")),"PRODUCT CODE"));
					}else{
						arrValues.add(getNPtoLAPSCommonLOV1(Helper.correctNull((String)hshValues.get("SchemeName")),
								Helper.correctNull((String)hshValues.get("selsegment")),"PRODUCT CODE",Schemetype));
					}*/
				arrValues.add(correctNull((String) hshValues.get("strUserId")));
				arrValues.add(correctNull((String) hshValues.get("strOrgCode")));									
				arrValues.add(hidApploanType.toUpperCase());
				arrValues.add(strInwardno);
				arrValues.add("A");
				arrValues.add((strOrglevel.equalsIgnoreCase("D") && strissaral.equalsIgnoreCase("Y"))?"S":strOrglevel);
				arrValues.add(correctNull((String)hshValues.get("strUserId")));
				arrValues.add("Y");
				arrValues.add(correctNull((String)hshValues.get("sel_sustenance")));
				arrValues.add(strAppBankName);
				arrValues.add(String.valueOf(intappno));
				arrValues.add((strRefno));
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "insapplications_ret1");
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				
				/* For inserting in demographic table */
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				intUpdatesize++;
				arrValues.add(strApplicationNo);
				arrValues.add(strLapsappid);
				arrValues.add("a");
				arrValues.add("");
				arrValues.add("2");
				arrValues.add("");
				System.out.print("arrValues demo  --"+arrValues);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "perloandetailsdemoins1");
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				 
				//Communication Details
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				intUpdatesize++;
				/*int intLapsappids=0;
				intLapsappids=Integer.parseInt(strLapsappid);
				arrValues.add(intLapsappids);*/
				arrValues.add(strLapsappid);
				if(rs != null){rs.close();}
				
				strQuery = SQLParser.getSqlQuery("selnpdetails^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_VILLAGE")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_CITY_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STATE_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
					arrValues.add("44");
					
				}
				else{
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					
				}
				System.out.print("arrValues dedupe old id --"+arrValues);
				
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "inscustinfo");
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				intUpdatesize++;
				arrValues.add(strLapsappid);
                if(rs != null){rs.close();}
				
                strQuery = SQLParser.getSqlQuery("sel_nppersonaldetails^"+strRefno);
    			rs = DBUtils.executeQuery(strQuery);			
    			if(rs.next())
    			{
				arrValues.add(getNPtoLAPSListOfValue("3",Helper.correctNull((String)rs.getString("NPPD_SOCIAL_CATEGORY"))));
				arrValues.add(getNPtoLAPSListOfValue("7",Helper.correctNull((String)rs.getString("NPPD_EDU_QUALIFICATION"))));
    			}
				System.out.print("arrValues demo  --"+arrValues);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "ins_otherdetails");
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				intUpdatesize++;
				arrValues.add(strLapsappid);
				System.out.print("arrValues demo  --"+arrValues);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "perloandetailscompany");
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				
				/*arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(strAppno);
				arrValues.add(strCBSId);
				arrValues.add(strBorrowId);
				arrValues.add(correctNull((String) hshValues
						.get("hidfinanceid")));
				arrValues.add(correctNull((String) hshValues
						.get("strUserId")));
				arrValues.add(strBusId);
				arrValues.add("OP");
				arrValues.add(struserid);
				arrValues.add(strAppName);
				arrValues.add(correctNull((String) hshValues.get("strOrgCode")));
				arrValues.add(correctNull((String) hshValues
						.get("sel_partyfiledet")));
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "ins_finrating");
				hshQueryValues.put(""+intUpdatesize, hshQuery);*/
				
				
				hshqueryval = new HashMap();
				HashMap hshquery = new HashMap();
				arrValues = new ArrayList();
				hshquery.put("strQueryId","updateapplicationsno_np");
				arrValues.add(strApplicationNo);
				arrValues.add(strRefno);//9
				hshquery.put("arrValues",arrValues);
				hshqueryval.put("size","1");
				hshqueryval.put("1",hshquery);						
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");

				
				/****
				 * For Updating in inward register
				 */
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","updinwardappatached1");
				arrValues.add("Y");//strCbsid
				arrValues.add("E");
				arrValues.add(strCbsid);
				arrValues.add(strInwardno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize, hshQuery);
								
				if(rs != null){rs.close();}
				strQuery = SQLParser.getSqlQuery("sel_npprincdet^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					String loanamt=Helper.correctNull((String)rs.getString("NPID_LOAN_AMT"));
					String emi=Helper.correctNull((String)rs.getString("NPID_EMI"));
					String roi=Helper.correctNull((String)rs.getString("NPID_ROI"));
					String subsidy_amt=Helper.correctNull((String)rs.getString("NPID_SUBSIDY_AMT"));
					if(!loanamt.equalsIgnoreCase("")){
						dblloanamnt = Double.parseDouble(loanamt);	
					}
					if(!emi.equalsIgnoreCase("")){
						dblEMI = Double.parseDouble(emi);	
					}
					if(!roi.equalsIgnoreCase("")){
						dblROI = Double.parseDouble(roi);	
					}
					if(!subsidy_amt.equalsIgnoreCase("")){
						dblsubsidyamnt =Double.parseDouble(subsidy_amt);	
					}
					
					strtenor = Helper.correctNull((String)rs.getString("NPID_TENOR"));
				}
				
				double dblReqamnt=0.00,dbltenure=0.00,dblcourseamnt=0.00,dblrepayint1=0.00,dblappcont=0.00;
				String strissecurity="",strrepaymentby="",dblrepayint="";
				if(rs != null){rs.close();}
				strQuery = SQLParser.getSqlQuery("sel_npCourseDetails^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					
					String reqamt=Helper.correctNull((String)rs.getString("NPCD_LOAN_AMT_REQ"));
					if(!reqamt.equalsIgnoreCase("")){
						dblReqamnt = Double.parseDouble(reqamt);	
					}	
					String tenure=Helper.correctNull((String)rs.getString("NPCD_TENURE"));
					if(!tenure.equalsIgnoreCase("")){
						dbltenure = Double.parseDouble(tenure);	
					}
					String courseamnt=Helper.correctNull((String)rs.getString("NPCD_AMOUNT"));
					if(!courseamnt.equalsIgnoreCase("")){
						dblcourseamnt = Double.parseDouble(courseamnt);	
					}
					String appcont=Helper.correctNull((String)rs.getString("NPCD_APPLICANT_CONTRIBUTION"));
					if(!appcont.equalsIgnoreCase("")){
						dblappcont = Double.parseDouble(appcont);	
					}
					
					dblrepayint = (Helper.correctNull((String)rs.getString("NPCD_IS_REPAY_INTEREST")));
					strrepaymentby = Helper.correctNull((String)rs.getString("NPCD_REPAYMENT_BY"));	
					
				
				}
								
				
				// For inserting in loandetails table 
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				intUpdatesize++;//
				arrValues.add(strApplicationNo);//1
				arrValues.add(String.valueOf(dblROI));//2
				arrValues.add(String.valueOf(dblReqamnt));//3
				arrValues.add(String.valueOf(dblcourseamnt));//4
				arrValues.add(String.valueOf(dbltenure));//5
				arrValues.add(String.valueOf(dblROI));//6
				arrValues.add(correctNull((String) hshValues.get("selrepaymenttype")));		//7		
				arrValues.add(Helper.correctDouble((String) hshValues.get("txtMarginpercent")));//8
				arrValues.add(correctNull((String) hshValues.get("txt_branchreference")));	//9			
				if (strissecurity.equalsIgnoreCase(""))
				{
					arrValues.add("1");
				}
				else
				{
					arrValues.add("1");
				}
				arrValues.add(String.valueOf(dblROI));//11
				arrValues.add(String.valueOf(dblsubsidyamnt));//12
				arrValues.add(String.valueOf(dblappcont));//13
				//arrValues.add(String.valueOf(dblcourseamnt));//14
				hshQuery.put("arrValues", arrValues);
				System.out.print("arrValues insert loan details "+arrValues);
				
				hshQuery.put("strQueryId", "perloandetailsinsnp");
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				
			
				
				String toorgcode="",togrpid="",fromgrpid="";
				if(rs != null){rs.close();}
				strQuery = SQLParser.getSqlQuery("sel_userorg_grpidapp1^"+strFromuserid);
				rs= DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					toorgcode=Helper.correctNull((String)rs.getString("USR_ORGCODE"));
					togrpid=Helper.correctNull((String)rs.getString("USR_GRPID"));
				}
				if(rs != null){rs.close();}
				strQuery = SQLParser.getSqlQuery("sel_userorg_grpidapp1^"+strFromuserid);
				rs= DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					fromgrpid=Helper.correctNull((String)rs.getString("USR_GRPID"));
				}
				
				ArrayList arrIds=new CommWorkflowBean().getFromToOrgLevel(strFromuserid,strFromuserid); // From To Org Level
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId","commworkflowins");
				arrValues.add(strApplicationNo);
				arrValues.add(strFromuserid);
				arrValues.add(strFromuserid);
				arrValues.add("1");
				arrValues.add("1");
				arrValues.add("C");
				arrValues.add(Helper.correctNull((String)hshValues.get("strOrgCode")));			
				arrValues.add(toorgcode);			
				arrValues.add(fromgrpid);			
				arrValues.add(togrpid);
				//arrValues.add(arrIds.get(0));			
				//arrValues.add(arrIds.get(1));
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				//	
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				intUpdatesize++;
				arrValues.add(strApplicationNo);
				if (strtenor.equals(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(strtenor);
				}
				arrValues.add("");
				arrValues.add(strissecurity);
				arrValues.add("");
				arrValues.add("");
				hshQuery.put("arrValues", arrValues);
				System.out.print("arrValues insert workflow "+arrValues);
				
				hshQuery.put("strQueryId", "secureins");
				hshQueryValues.put(""+intUpdatesize, hshQuery);				
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");

				hshLoanProduct.put("appno", strApplicationNo);
				
				if(Schemetype.equalsIgnoreCase("")){
					hshLoanProduct.put("prdcode",getNPtoLAPSCommonLOV(Helper.correctNull((String)hshValues.get("SchemeName")),
							Helper.correctNull((String)hshValues.get("selsegment")),"PRODUCTCODE"));
				;
					}else{
						hshLoanProduct.put("prdcode",getNPtoLAPSCommonLOV1(Helper.correctNull((String)hshValues.get("SchemeName")),
								Helper.correctNull((String)hshValues.get("selsegment")),"PRODUCTCODE",Schemetype));
					}
				hshLoanProduct.put("radLoan", "Y");
				hshLoanProduct.put("hidapplicantid",strLapsappid);
				hshLoanProduct.put("page", "ep");
				hshLoanProduct.put("strUserId", correctNull((String) hshValues.get("strUserId")));
				hshLoanProduct.put("strGroupRights", correctNull((String) hshValues.get("strGroupRights")));
				
				if(rs != null){rs.close();}
				strQuery = SQLParser.getSqlQuery("sel_npcoappdet^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				while(rs.next())
				{		
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","perloandetailsdemoins1");	
					arrValues.add(strApplicationNo);
					

					String name="";
					if(!Helper.correctNull((String)rs.getString("NPCD_FNAME")).equalsIgnoreCase(""))
					{
						name=Helper.correctNull((String)rs.getString("NPCD_FNAME"));
					}
					if(!Helper.correctNull((String)rs.getString("NPCD_LNAME")).equalsIgnoreCase(""))
					{
						name=name+" "+Helper.correctNull((String)rs.getString("NPCD_LNAME"));
					}
					if(!Helper.correctNull((String)rs.getString("NPCD_MNAME")).equalsIgnoreCase(""))
					{
						name=name+" "+Helper.correctNull((String)rs.getString("NPCD_MNAME"));
					}
					String StrName=name;
					String PerAppid="";
					strQuery = SQLParser.getSqlQuery("selperappid_np^"+strRefno+"^"+StrName);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						PerAppid=Helper.correctNull((String)rs1.getString("NP_LAPSID"));
					}
					
					arrValues.add(PerAppid);
					if(Helper.correctNull((String)rs.getString("NPCD_ISGUARANTOR")).equalsIgnoreCase("2"))
					{
						arrValues.add("g");
					}
					else
					{
						arrValues.add("c");
					}
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_RELATION")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_INCOME_CONSIDER")));
					arrValues.add("");			
					hshQuery.put("arrValues",arrValues);
					System.out.print("arrValues insert perdemo--- "+arrValues);		
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
				}
				
				//Scholarship details
				if(rs != null){rs.close();}
				strQuery = SQLParser.getSqlQuery("sel_npscholarshpdetails^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				while(rs.next())
				{
					String strGradeId = "";
					strGradeId = Integer.toString(getMaxGradeId(strApplicationNo));
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();			
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","eduscholarsinsert");
					arrValues.add(strApplicationNo);
					arrValues.add(strGradeId);
					arrValues.add("");
					arrValues.add("");
					arrValues.add(Helper.correctNull((String)rs.getString("NPSCL_SCHOLARSHIP_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPSCL_SCHOLARSHIP_AMOUNT")));
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					hshQuery.put("arrValues",arrValues);
					System.out.print("arrValues insert eduction"+arrValues);
					
					hshQueryValues.put("1",hshQuery);	
					hshQueryValues.put("size","1");	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				
				// Course Details
				if(rs != null){rs.close();}
				strQuery = SQLParser.getSqlQuery("sel_npCourseDetails^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					hshqueryval = new HashMap();
					 hshquery = new HashMap();
					arrValues = new ArrayList();
					hshquery.put("strQueryId","eduparticularsinsnp");
					String typecourse=Helper.correctNull((String)rs.getString("NPCD_TYPE_OF_COURSE"));
					if(typecourse.equalsIgnoreCase("Part Time"))	
					{
						typecourse="1";
					}else if(typecourse.equalsIgnoreCase("Full Time"))	
					{
						typecourse="2";
					}else if(typecourse.equalsIgnoreCase("Evening Course"))	
					{
						typecourse="3";
					}else if(typecourse.equalsIgnoreCase("Correspondense"))	
					{
						typecourse="4";
					}else if(typecourse.equalsIgnoreCase("Vocational"))	
					{
						typecourse="5";
					}else{
						typecourse="0";
					}
				String coursedurationyrs=Helper.correctNull((String)rs.getString("NPCD_COURSE_DURATION"));
				if(coursedurationyrs.equalsIgnoreCase(""))
						coursedurationyrs="0";
						String courseduration="";
						if(courseduration.equalsIgnoreCase(""))
							courseduration="0";
						courseduration=coursedurationyrs+"~"+courseduration;
						
					String location=Helper.correctNull((String)rs.getString("NPCD_INSIT_LOC"));
					if(location.equalsIgnoreCase("In India"))	
					{
						location="1";
					}else	
					{
						location="2";
					}
					String quota=Helper.correctNull((String)rs.getString("NPCD_QUOTA_SELE"));
					if(quota.equalsIgnoreCase("Merit"))	
					{
						quota="1";
					}else	
					{
						quota="2";
					}
					arrValues.add(strApplicationNo);//appno//1
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_COURSE_NAME")));// name of the //2
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_UNIV_NAME")));//3
					arrValues.add(typecourse);//4
					arrValues.add(courseduration);//5
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_COURSE_START_DATE")));//6
					arrValues.add(location);//7
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_COURSE_END_DATE")));//8
					arrValues.add(quota);//9
					hshquery.put("arrValues",arrValues);
					hshqueryval.put("size","1");
					hshqueryval.put("1",hshquery);	
					System.out.print("arrValues insert course"+arrValues);
					
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");	
				}
				
				for(int j=1; j<=13; j++)
				{
					hshqueryval = new HashMap();
					 hshquery = new HashMap();
					arrValues = new ArrayList();
					hshquery.put("strQueryId","ins_npedu_costdetails");
					arrValues.add(strApplicationNo);//appno//1
					arrValues.add(String.valueOf(j));
					int courseamount=0;
					String curamt="";
					strQuery = SQLParser.getSqlQuery("sel_npedu_costdetails^"+strRefno+"^"+j);
					rs = DBUtils.executeQuery(strQuery);			
					while(rs.next())
					{
						
						curamt=Helper.correctNull((String)rs.getString("NPCC_COURSE_AMOUNT"));
						if(!curamt.equalsIgnoreCase("")){
							courseamount=courseamount+Integer.parseInt(curamt);	
						}
						arrValues.add(curamt);		
					}
					String years="0";
					strQuery = SQLParser.getSqlQuery("max_npedu_costdetails^"+strRefno+"^"+j);
					rs1 = DBUtils.executeQuery(strQuery);			
					if(rs1.next())
					{
						years=Helper.correctNull((String)rs1.getString("yearcount"));
					}
					int len=6;
					if(!years.equalsIgnoreCase("")){
					 len=6-Integer.parseInt(years);
					}
					for(int i=1; i<=len; i++)
					{
						arrValues.add("");	
					}
					arrValues.add(String.valueOf(courseamount));
					arrValues.add("e");
					
					hshquery.put("arrValues",arrValues);
					hshqueryval.put("size","1");
					hshqueryval.put("1",hshquery);	
					System.out.print("arrValues insert course"+arrValues);
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				
				}
				int n=0;
				strQuery = SQLParser.getSqlQuery("sel_npdocuments^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					n++;
					hshqueryval = new HashMap();
					hshquery = new HashMap();
					arrValues = new ArrayList();
					hshquery.put("strQueryId","ins_Dcouments_np");
					arrValues.add(strApplicationNo);
					arrValues.add(String.valueOf(n));
					arrValues.add(Helper.correctNull((String)rs.getString("NPUD_DOC_TYPE")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPUD_DOCUMENT")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPUD_DOC_TYPE")));
					hshquery.put("arrValues",arrValues);
					System.out.print("arrValues insert documents"+arrValues);
					
					hshqueryval.put("size","1");
					hshqueryval.put("1",hshquery);						
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				}
				
				//eduction Detail
				int  p=0;
				strQuery = SQLParser.getSqlQuery("sel_npeducation^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					p++;
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();			
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","edudetailsinsert");
					arrValues = new ArrayList();
					arrValues.add(strApplicationNo);
					arrValues.add(String.valueOf(p));
					arrValues.add(Helper.correctNull(rs.getString("NPED_SPECIALIZATION")));
					arrValues.add(Helper.correctNull(rs.getString("NPED_INSITITUTE_NAME")));
					arrValues.add(Helper.correctNull(rs.getString("NPED_YEAR")));
					arrValues.add(Helper.correctNull(rs.getString("NPED_NO_OF_ATTEMPTS")));
					arrValues.add(Helper.correctNull(rs.getString("NPED_MARKS")));
					arrValues.add("");
					hshQuery.put("arrValues",arrValues);
					System.out.print("arrValues insert eduction"+arrValues);
					hshQueryValues.put("1",hshQuery);	
					hshQueryValues.put("size","1");	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				int intSize=0;
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				String prdcode="";
				
				
				strQuery = SQLParser.getSqlQuery("sel_productcode^"+ strApplicationNo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					prdcode=correctNull((String)rs.getString("app_prdcode"));
				}
				if(!prdcode.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("getprodcode^"+prdcode);
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next())
				{
					intSize++;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("arrValues", arrValues);
					String status = "N";
					arrValues.add(correctNull((String)rs.getString("doc_code")));						
					arrValues.add(correctNull((String)rs.getString("doc_create_date")));
					
					if (correctNull(rs.getString("Doc_type")).equalsIgnoreCase("a"))
					{
						arrValues.add("PA");
					}
					else if (correctNull(rs.getString("Doc_type")).equalsIgnoreCase("i"))
					{
						arrValues.add("PI");
					}
					
					arrValues.add(correctNull(strApplicationNo));
					arrValues.add(status);
					hshQuery.put("strQueryId", "insappdocuments");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intSize),hshQuery);
					
				}
			
			
			hshQueryValues.put("size",String.valueOf(intSize));
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				//hshResult = getLoanProducts(hshLoanProduct);
				//hsh = getNpMailbox(hshValues);
			}
			//hsh = getNpMailbox(hshValues);
		}
		
		catch(Exception ex)
		{
			Logger.log("Exception in getNpapplications"+ex);
		}	
		return hsh;
	}

public HashMap getNP_EligibilityDeatils(HashMap hshValues) {
		
		ResultSet rs = null;
		String strQuery="";
		HashMap hshResult = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arrCol = new ArrayList();
		String strApplicationRefNo=Helper.correctNull((String) hshValues.get("strApplicationRefNo"));
				
		try
		{
			strQuery = SQLParser.getSqlQuery("sel_npeligiblity_details^"+strApplicationRefNo);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
				{
				    arrCol = new ArrayList();
					arrCol.add(Helper.correctNull(rs.getString("NPBE_ANSWER")));
					arrCol.add(Helper.correctNull(rs.getString("NPBE_QUESTION")));
					arryRow.add(arrCol);
				}
			hshResult.put("arryRow", arryRow);
			hshResult.put("strApplicationRefNo",strApplicationRefNo);
		}
		catch(Exception ex)
		{
			Logger.log("Exception in getNpapplications"+ex);
		}
				
			return hshResult;
	}

public HashMap getData(HashMap hshValues) 
{
	HashMap hshRecord = new HashMap();
	String strMethod ="";

	try
	{
		strMethod=(String)hshValues.get("hidMethod");

		 if (strMethod.equalsIgnoreCase("getNPReportList"))
		{
			hshRecord =(HashMap)getNPReportList(hshValues);
		} 
	
	}
	catch(Exception ce)
	{
		throw new EJBException("Error in getdata "+ce.toString());
	}
	
	return hshRecord;

}
public HashMap getNPReportList(HashMap hshValues) 
{
	ResultSet rs = null;
	ResultSet rs1 = null;
	Vector vecRecords=null;
	HashMap hshRec=null;
	Vector vecVal =null;
	String strQuery=null,strQuery1=null;
	String strOrgCode = null;
	String strOpFields = null;
	String strSelFields=null;
	String strStatus=null;
	String strTemp=null;
	String strDate=null;
	String strToDate=null;
	String strFromDate=null;
	Vector vecT = new Vector();
	String strSaveDate=null;
	String strGen=null;
	String strFromAmt=null;
	String strToAmt=null;
	String strOrgName=null,strDatetype=null;
	int count=0;
	String strmodtype="";
	String strOrglevel=null;
	String strUserId=null;
	StringBuffer strbufOrgcode=new StringBuffer();
				
		try
		{
			strSaveDate =(String)hshValues.get("txtSaveDate");
			strGen =(String)hshValues.get("strUserId");
			strOrgCode =(String)hshValues.get("org_name");
			strSelFields =(String)hshValues.get("hidSelFields");
			strOpFields =(String)hshValues.get("hidOpFields");
			
			strStatus =(String)hshValues.get("hidStatus");
			strDate =(String)hshValues.get("txtDate");
			
			strOrglevel=correctNull((String)hshValues.get("strOrgLevel"));
			strFromAmt=correctNull((String)hshValues.get("fromamt"));
			strToAmt=correctNull((String)hshValues.get("toamt"));
			strOrgName=correctNull((String)hshValues.get("hidOrgName"));
			strmodtype=correctNull((String)hshValues.get("modtype"));
			strUserId=correctNull((String)hshValues.get("hidAppno"));
			
			String strsegment=correctNull((String)hshValues.get("segment"));
			String strscheme=correctNull((String)hshValues.get("scheme"));
			
			
			
			strOrgCode=strOrgCode.replaceAll("'","");
			if(strOrglevel.equalsIgnoreCase("C"))
			{
				strbufOrgcode.append("orgs.org_code like '001%'");
			}
			else if(strOrglevel.equalsIgnoreCase("R"))
			{
				strbufOrgcode.append("orgs.org_code like '").append(strOrgCode.substring(0,6)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("D"))
			{
				strbufOrgcode.append("orgs.org_code like '").append(strOrgCode.substring(0,9)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("A"))
			{
				strbufOrgcode.append("orgs.org_code like '").append(strOrgCode.substring(0,12)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("B"))
			{
				strbufOrgcode.append("orgs.org_code = '").append(strOrgCode).append("'");
			}
			
			
		
			
			//loantype based Query
			if(strStatus.equalsIgnoreCase("O"))
			{
				strbufOrgcode.append(" and  APP_STATUS='op' ");
			}else if(strStatus.equalsIgnoreCase("H"))
			{
				strbufOrgcode.append(" and  UPPER(APP_STATUS)='H' ");
			}else if(strStatus.equalsIgnoreCase("SA"))
			{
				strbufOrgcode.append(" and  APP_STATUS='pa' ");
			}else if(strStatus.equalsIgnoreCase("R"))
			{
				strbufOrgcode.append(" and  APP_STATUS='pr' ");
			}
			
			
			strDatetype="APP_CREATEDATE";
			if(!strDate.equalsIgnoreCase("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				strbufOrgcode.append(" and (TO_DATE(to_char(").append(strDatetype).append(",'DD/MM/YYYY'),'DD/MM/YYYY')between TO_DATE('")
				.append(strFromDate).append("','DD/MM/YYYY') and TO_DATE('").append(strToDate).append("','DD/MM/YYYY'))");
			}
			
				strQuery = SQLParser.getSqlQuery("sel_npreport^"+strbufOrgcode.toString()+"^"+strsegment+"^"+strscheme);
			
			if(rs != null)
				rs.close();
			if(rs != null)
			{
				
				rs.close();
			}
			ArrayList arrval =  new ArrayList();
			ArrayList arrdata =  new ArrayList();
			rs= DBUtils.executeQuery(strQuery);
			hshRec = new HashMap();
			arrval = new ArrayList();

			while (rs.next())
			{
					arrval =  new ArrayList();
				
				arrval.add(Helper.correctNull((String)rs.getString("BRANCH")));//0
				arrval.add(Helper.correctNull((String)rs.getString("branchsolid")));//1
				arrval.add(Helper.correctNull((String)rs.getString("REGION")));//2
				arrval.add(Helper.correctNull((String)rs.getString("regionsolid")));//3 
				arrval.add(Helper.correctNull((String)rs.getString("FGMO")));//4
				arrval.add(Helper.correctNull((String)rs.getString("fgmosolid")));//5
				arrval.add(Helper.correctNull((String)rs.getString("APP_NPREFID")));//6
				arrval.add(Helper.correctNull((String)rs.getString("APP_NO")));//7
				arrval.add(Helper.correctNull((String)rs.getString("APP_CREATEDATE")));//8
				arrval.add(Helper.correctNull((String)rs.getString("NPSCH_SCHEMENAME")));//9
				arrval.add(Helper.correctNull((String)rs.getString("appstatus")));//10
				arrval.add("");//11
				arrval.add(Helper.correctNull((String)rs.getString("app_processdate")));//12
				arrval.add(Helper.correctNull((String)rs.getString("CUST_ACCOUNTOPENDATE")));//13
				String  strComments="";
				if(strStatus.equalsIgnoreCase("h")){
					
				strQuery = SQLParser.getSqlQuery("sel_npreportcomnt^"+Helper.correctNull((String)rs.getString("APP_NO")));
				rs1= DBUtils.executeQuery(strQuery);
				while (rs1.next())
				{
					strComments =correctNull(Helper.CLOBToString(rs1.getClob("MAIL_COMMENTS")))+","+strComments;
				}
			}else if(strStatus.equalsIgnoreCase("R")){
				 
				strQuery = SQLParser.getSqlQuery("sel_npreportrejcomnt^"+Helper.correctNull((String)rs.getString("APP_NO")));
				rs1= DBUtils.executeQuery(strQuery);
				while (rs1.next())
				{
					strComments =correctNull((String)(rs1.getString("REJ_DESC")))+","+strComments;
				}
			}else{
				  strComments="";
			}
			
				
				
				
				arrval.add(strComments);//14
				arrval.add(Helper.correctNull((String)rs.getString("APP_CBSACCOUNT_NO")));//15
				
				
				
				arrdata.add(arrval);
			}
			
			hshRec.put("arrdata", arrdata);
			
			
			
			
			if((strStatus.equalsIgnoreCase("RS")))
			{
				
				strStatus="Replied";
			}else if((strStatus.equalsIgnoreCase("RI")))
			{
				
				strStatus="Raised";
			}
			else if((strStatus.equalsIgnoreCase("CL")))
			{
				strStatus="Close";
				
			}
			hshRec.put("txtDate",strDate);
			hshRec.put("vecValues",vecVal);
			hshRec.put("labels",strSelFields);
			hshRec.put("genby",strGen);
			hshRec.put("txtSaveDate",strSaveDate);
			hshRec.put("count",Integer.toString(count));
			hshRec.put("Org_Name",strOrgName);
			hshRec.put("strStatus",strStatus);	
		}
		catch(Exception ex)
		{
			Logger.log("Exception in getNPReportList"+ex);
		}
		return hshRec;
}

private int getMaxGradeId(String appno)
{
	ResultSet rs = null;
	int termId = 0;

	try
	{	
		rs=DBUtils.executeLAPSQuery("eduscholarsmax^"+appno);
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
		if(rs != null)rs.close();
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

public HashMap getPSB59ApplicantListDtls(HashMap hshValues) 
{
	String strQuery = "";
	String strQuery1 = "";
	String strQuery2 = "";
	String strQuery3 = "";
	ResultSet rs = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	ResultSet rs3 = null;
	HashMap hshResult = new HashMap();
	
	
	String appnumber = "",appID="",CICValue="";
	String CbsId="";
	String AppId = Helper.correctNull((String)hshValues.get("hidApplicantId"));
	if(AppId.equalsIgnoreCase(""))
	{
		AppId=Helper.correctNull((String)hshValues.get("strapprefid")); 
	}
	String aadharaddress="",currentaddress="",officeaddress="";
	ArrayList arrValues = new ArrayList();
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = new HashMap();
	String SchemeId="";
	int intUpdateSize=0;
	int intUpdateSize1=0;
       try {
    	   strQuery = SQLParser.getSqlQuery("sel_applicationscheme_np^"+AppId);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				SchemeId=Helper.correctNull((String)rs.getString("NPDT_NP_SCHEME_NAME"));
			}
			 hshValues.put("POP_SCHEME_ID",SchemeId);	
    	    hshValues.put("hidRefId",AppId);
    	    hshValues.put("Refno",AppId);
    	   strQuery = SQLParser.getSqlQuery("get_psbapplicantdtls^"+AppId);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshValues.put("NPPD_APPLICATION_REFERENCE_ID", Helper.correctNull((String) rs.getString("NPPD_APPLICATION_REFERENCE_ID")));
				hshValues.put("NPPD_BUSS_ESTA_MONTH", Helper.correctNull((String) rs.getString("NPPD_BUSS_ESTA_MONTH")));
				hshValues.put("NPPD_BUSS_ESTA_YEAR", Helper.correctNull((String) rs.getString("NPPD_BUSS_ESTA_YEAR")));
				hshValues.put("NPPD_CURR_BUSS_YEAR", Helper.correctNull((String) rs.getString("NPPD_CURR_BUSS_YEAR")));
				hshValues.put("NPPD_DOB", Helper.correctNull((String) rs.getString("NPPD_DOB")));
				hshValues.put("NPPD_DESIGNATION", Helper.correctNull((String) rs.getString("NPPD_DESIGNATION")));
				hshValues.put("NPPD_EDU_QUALIFICATION", Helper.correctNull((String) rs.getString("NPPD_EDU_QUALIFICATION")));
				hshValues.put("NPPD_EMAIL", Helper.correctNull((String) rs.getString("NPPD_EMAIL")));
				hshValues.put("NPPD_EMP_TYPE", Helper.correctNull((String) rs.getString("NPPD_EMP_TYPE")));
				hshValues.put("NPPD_FATHERS_NAME", Helper.correctNull((String) rs.getString("NPPD_FATHERS_NAME")));
				hshValues.put("NPPD_FIRST_NAME", Helper.correctNull((String) rs.getString("NPPD_FIRST_NAME")));
				hshValues.put("NPPD_GENDER", Helper.correctNull((String) rs.getString("NPPD_GENDER")));
				hshValues.put("NPPD_GROSS_MONTHLY_INCOME", Helper.correctNull((String) rs.getString("NPPD_GROSS_MONTHLY_INCOME")));
				hshValues.put("NPPD_IS_CHAIRMAN", Helper.correctNull((String) rs.getString("NPPD_IS_CHAIRMAN")));
				hshValues.put("NPPD_LAST_NAME", Helper.correctNull((String) rs.getString("NPPD_LAST_NAME")));
				
				hshValues.put("NPPD_MARITAL_STATUS", Helper.correctNull((String) rs.getString("NPPD_MARITAL_STATUS")));
				hshValues.put("NPPD_MARKS", Helper.correctNull((String) rs.getString("NPPD_MARKS")));
				hshValues.put("NPPD_MIDDLE_NAME", Helper.correctNull((String) rs.getString("NPPD_MIDDLE_NAME")));
				hshValues.put("NPPD_MOBILE_NUMBER", Helper.correctNull((String) rs.getString("NPPD_MOBILE_NUMBER")));
				hshValues.put("NPPD_MOTHERS_NAME", Helper.correctNull((String) rs.getString("NPPD_MOTHERS_NAME")));
				hshValues.put("NPPD_OCCUPATION", Helper.correctNull((String) rs.getString("NPPD_OCCUPATION")));
				hshValues.put("NPPD_ORG_NAME", Helper.correctNull((String) rs.getString("NPPD_ORG_NAME")));
				hshValues.put("NPPD_ORG_TYPE", Helper.correctNull((String) rs.getString("NPPD_ORG_TYPE")));
				hshValues.put("NPPD_RELATIONSHIP", Helper.correctNull((String) rs.getString("NPPD_RELATIONSHIP")));
				hshValues.put("NPPD_RESITANT_STATUS", Helper.correctNull((String) rs.getString("NPPD_RESITANT_STATUS")));
				hshValues.put("NPPD_RETIRE_AGE", Helper.correctNull((String) rs.getString("NPPD_RETIRE_AGE")));
				hshValues.put("NPPD_SALUTATION", Helper.correctNull((String) rs.getString("NPPD_SALUTATION")));
				hshValues.put("NPPD_SOCIAL_CATEGORY", Helper.correctNull((String) rs.getString("NPPD_SOCIAL_CATEGORY")));
				hshValues.put("NPPD_WORKING_SINCE_MONTH", Helper.correctNull((String) rs.getString("NPPD_WORKING_SINCE_MONTH")));
				hshValues.put("NPPD_WORKING_SINCE_YEAR", Helper.correctNull((String) rs.getString("NPPD_WORKING_SINCE_YEAR")));
				hshValues.put("NPPD_VOTER_NO", Helper.correctNull((String) rs.getString("NPPD_VOTER_NO")));
				hshValues.put("NPPD_PAN_NO", Helper.correctNull((String) rs.getString("NPPD_PAN_NO")));
				hshValues.put("NPPD_IS_CURR_ADD_SAME", Helper.correctNull((String) rs.getString("NPPD_IS_CURR_ADD_SAME")));
			
				aadharaddress=Helper.correctNull((String) rs.getString("NPPD_AADHAR_ADD_SEQ_NO"));
				currentaddress=Helper.correctNull((String) rs.getString("NPPD_CURR_ADD_SEQ_NO"));
				officeaddress=Helper.correctNull((String) rs.getString("NPPD_OFFICE_ADD_SEQ_NO"));
				
			   }if(rs != null)
			   {
				rs.close();
			   }
    	   if(!aadharaddress.equalsIgnoreCase(""))
    	   {
			   strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+AppId+'^'+aadharaddress);
				rs1 = DBUtils.executeQuery(strQuery);
				if (rs1.next())
				{
						hshValues.put("NPAA_CITY_NAME", Helper.correctNull((String) rs1.getString("NPAD_CITY_NAME")));
						hshValues.put("NPAA_COUNTRY_NAME", Helper.correctNull((String) rs1.getString("NPAD_COUNTRY_NAME")));
						hshValues.put("NPAA_DISTRICT_NAME", Helper.correctNull((String) rs1.getString("NPAD_DISTRICT_NAME")));
						hshValues.put("NPAA_LAND_MARK", Helper.correctNull((String) rs1.getString("NPAD_LANDMARK")));
						hshValues.put("NPAA_PIN_CODE", Helper.correctNull((String) rs1.getString("NPAD_PIN_CODE")));
						hshValues.put("NPAA_STATE_NAME", Helper.correctNull((String) rs1.getString("NPAD_STATE_NAME")));
						hshValues.put("NPAA_STREET_NAME", Helper.correctNull((String) rs1.getString("NPAD_STREET_NAME")));
						hshValues.put("NPAA_SUB_DISTRICT", Helper.correctNull((String) rs1.getString("NPAD_SUB_DISTRICT")));
						hshValues.put("NPAA_VILLAGE", Helper.correctNull((String) rs1.getString("NPAD_VILLAGE")));
						hshValues.put("NPAA_STATE_CODE", Helper.correctNull((String) rs1.getString("NPAD_STATE_CODE")));
						hshValues.put("NPAA_CITYCODE", Helper.correctNull((String) rs1.getString("NPAD_CITY_ID")));
						hshValues.put("NPAA_VILLAGE_CODE", Helper.correctNull((String) rs1.getString("NPAD_VILLAGE_CODE")));
						hshValues.put("NPAA_DISTRICT_CODE", Helper.correctNull((String) rs1.getString("NPAD_DISTRICT_CODE")));
						hshValues.put("NPAA_SUB_DISTRICT_CODE", Helper.correctNull((String) rs1.getString("NPAD_SUB_DISTRICT_CODE")));
						


				} 
				if(rs1 != null)
				   {
					rs1.close();
				   }
	    	   
    	   }  
    	   if(!currentaddress.equalsIgnoreCase(""))
    	   {
				strQuery2 = SQLParser.getSqlQuery("sel_npaddrdetails5^"+AppId+'^'+currentaddress);
				rs1 = DBUtils.executeQuery(strQuery2);
				if (rs1.next())
				{
					
					hshValues.put("NPCA_CITY_NAME", Helper.correctNull((String) rs1.getString("NPAD_CITY_NAME")));
					hshValues.put("NPCA_COUNTRY_NAME", Helper.correctNull((String) rs1.getString("NPAD_COUNTRY_NAME")));
					hshValues.put("NPCA_DISTRICT_NAME", Helper.correctNull((String) rs1.getString("NPAD_DISTRICT_NAME")));
					hshValues.put("NPCA_LAND_MARK", Helper.correctNull((String) rs1.getString("NPAD_LANDMARK")));
					hshValues.put("NPCA_PIN_CODE", Helper.correctNull((String) rs1.getString("NPAD_PIN_CODE")));
					hshValues.put("NPCA_STATE_NAME", Helper.correctNull((String) rs1.getString("NPAD_STATE_NAME")));
					hshValues.put("NPCA_STREET_NAME", Helper.correctNull((String) rs1.getString("NPAD_STREET_NAME")));
					hshValues.put("NPCA_SUB_DISTRICT", Helper.correctNull((String) rs1.getString("NPAD_SUB_DISTRICT")));
					hshValues.put("NPCA_VILLAGE", Helper.correctNull((String) rs1.getString("NPAD_VILLAGE")));
					hshValues.put("NPCA_STATE_CODE", Helper.correctNull((String) rs1.getString("NPAD_STATE_CODE")));
					hshValues.put("NPCA_CITYCODE", Helper.correctNull((String) rs1.getString("NPAD_CITY_ID")));
					hshValues.put("NPCA_VILLAGE_CODE", Helper.correctNull((String) rs1.getString("NPAD_VILLAGE_CODE")));
					hshValues.put("NPCA_DISTRICT_CODE", Helper.correctNull((String) rs1.getString("NPAD_DISTRICT_CODE")));
					hshValues.put("NPCA_SUB_DISTRICT_CODE", Helper.correctNull((String) rs1.getString("NPAD_SUB_DISTRICT_CODE")));
					
				
				}if(rs2 != null)
				   {
					rs2.close();
				   }
    	   }
    	   if(!officeaddress.equalsIgnoreCase(""))
    	   {
				strQuery3 = SQLParser.getSqlQuery("sel_npaddrdetails5^"+AppId+'^'+officeaddress);
				rs3 = DBUtils.executeQuery(strQuery3);
				if (rs3.next())
				{
					hshValues.put("NPOA_CITY_NAME", Helper.correctNull((String) rs3.getString("NPAD_CITY_NAME")));
					hshValues.put("NPOA_COUNTRY_NAME", Helper.correctNull((String) rs3.getString("NPAD_COUNTRY_NAME")));
					hshValues.put("NPOA_DISTRICT_NAME", Helper.correctNull((String) rs3.getString("NPAD_DISTRICT_NAME")));
					hshValues.put("NPOA_LANDMARK", Helper.correctNull((String) rs3.getString("NPAD_LANDMARK")));
					hshValues.put("NPOA_PIN_CODE", Helper.correctNull((String) rs3.getString("NPAD_PIN_CODE")));
					hshValues.put("NPOA_STATE_NAME", Helper.correctNull((String) rs3.getString("NPAD_STATE_NAME")));
					hshValues.put("NPOA_STREET_NAME", Helper.correctNull((String) rs3.getString("NPAD_STREET_NAME")));
					hshValues.put("NPOA_SUB_DISTRICT", Helper.correctNull((String) rs3.getString("NPAD_SUB_DISTRICT")));
					hshValues.put("NPOA_VILLAGE", Helper.correctNull((String) rs3.getString("NPAD_VILLAGE")));
				}
				
				if(rs3 != null)
				   {
					rs3.close();
				   }
    	   }
				getPSB59CoapplicanrDtls(hshValues);
	              }
	            catch(Exception m) {
	            System.out.println("Error in PSB59Bean -> getPSB59ApplicantListDtls Method -> get_applicantofficeaddress : "+m);
	              }
	return hshValues;
	
}

@SuppressWarnings("unchecked")
public HashMap getPSB59CoapplicanrDtls(HashMap hshValues) 
{
	String strQuery = "";
	ResultSet rs = null;
	HashMap hshResult = new HashMap();
	String appnumber = "",appID="",CICValue="";
	String AppId = Helper.correctNull((String)hshValues.get("hidApplicantId"));
	if(AppId.equalsIgnoreCase(""))
	{
		AppId=Helper.correctNull((String)hshValues.get("strapprefid")); 
	}
	String CbsId="";
	ArrayList arrValues = new ArrayList();
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = new HashMap();
	int intUpdateSize=0;
	int intUpdateSize1=0;
	ArrayList arrcol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	
	ArrayList arrcolaad = new ArrayList();
	ArrayList arrRowaad = new ArrayList();
	String strCurrAddress="",strCo_appid="",strAadharAdd="",StrOffAddress="";
       try {
    	   strQuery = SQLParser.getSqlQuery("get_psbcoapplicantdtls^"+AppId);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshValues.put("NPCD_FNAME",Helper.correctNull(rs.getString("NPCD_FNAME")));//0
				hshValues.put("NPCD_MNAME",Helper.correctNull(rs.getString("NPCD_MNAME")));//1
				hshValues.put("NPCD_LNAME",Helper.correctNull(rs.getString("NPCD_LNAME")));//2
				hshValues.put("NPCD_MOBILE",Helper.correctNull(rs.getString("NPCD_MOBILE")));//3
				hshValues.put("NPCD_EMAIL",Helper.correctNull(rs.getString("NPCD_EMAIL")));//4
				hshValues.put("NPCD_DRIVING_LIC",Helper.correctNull(rs.getString("NPCD_DRIVING_LIC")));//6
				hshValues.put("NPCD_AADHAR_NAME",Helper.correctNull(rs.getString("NPCD_AADHAR_NAME")));//7
				hshValues.put("NPCD_FATORHUSB_NAME",Helper.correctNull(rs.getString("NPCD_FATORHUSB_NAME")));//8
				hshValues.put("NPCD_MOTHER_NAME",Helper.correctNull(rs.getString("NPCD_MOTHER_NAME")));//9
				hshValues.put("NPCD_COMPANY_NAME",Helper.correctNull(rs.getString("NPCD_COMPANY_NAME")));//10
				hshValues.put("NPCD_AADHAR_ADDR_ID",Helper.correctNull(rs.getString("NPCD_AADHAR_ADDR_ID")));//11	
				hshValues.put("NPCD_CUR_ADDR_ID",Helper.correctNull(rs.getString("NPCD_CUR_ADDR_ID")));//12
				strAadharAdd=Helper.correctNull(rs.getString("NPCD_AADHAR_ADDR_ID"));
				strCurrAddress=Helper.correctNull(rs.getString("NPCD_CUR_ADDR_ID"));
				hshValues.put("NPCD_OFC_ADDR_ID",Helper.correctNull(rs.getString("NPCD_OFC_ADDR_ID")));//13
				StrOffAddress=Helper.correctNull(rs.getString("NPCD_OFC_ADDR_ID"));
				hshValues.put("NPCD_RELATION",Helper.correctNull(rs.getString("NPCD_RELATION_WITH")));//14
				
				hshValues.put("NPCD_SALUTATION",Helper.correctNull(rs.getString("NPCD_SALUTATION")));//15
				hshValues.put("NPCD_GENDER",Helper.correctNull(rs.getString("NPCD_GENDER")));//16
				hshValues.put("NPCD_DOB",Helper.correctNull(rs.getString("NPCD_DOB")));//17
				hshValues.put("NPCD_SOCIAL_CAT",Helper.correctNull(rs.getString("NPCD_SOCIAL_CAT")));//18
				hshValues.put("NPCD_MARITAL_STAT",Helper.correctNull(rs.getString("NPCD_MARITAL_STAT")));//19
				hshValues.put("NPCD_NOOF_CHILD",Helper.correctNull(rs.getString("NPCD_NOOF_CHILD")));//20
				hshValues.put("NPCD_NOOF_DEPENDENT",Helper.correctNull(rs.getString("NPCD_NOOF_DEPENDENT")));//21
				hshValues.put("NPCD_EDU_QUALIFY",Helper.correctNull(rs.getString("NPCD_EDU_QUALIFY")));//22
				hshValues.put("NPCD_RESI_TYPE",Helper.correctNull(rs.getString("NPCD_RESI_TYPE")));//23
				hshValues.put("NPCD_RESI_SINCE",Helper.correctNull(rs.getString("NPCD_RESI_SINCE")));//24
				hshValues.put("NPCD_RESI_SINCE_MON",Helper.correctNull(rs.getString("NPCD_RESI_SINCE_MON")));//25
				hshValues.put("NPCD_IS_CUR_ADDR",Helper.correctNull(rs.getString("NPCD_IS_CUR_ADDR")));//26
				hshValues.put("NPCD_EMPLOY_TYPE",Helper.correctNull(rs.getString("NPCD_EMPLOY_TYPE")));//27
				hshValues.put("NPCD_ORG_NAME",Helper.correctNull(rs.getString("NPCD_ORG_NAME")));//28
				
				hshValues.put("NPCD_DESIGNATION",Helper.correctNull(rs.getString("NPCD_DESIGNATION")));//29
				hshValues.put("NPCD_WORK_WITH",Helper.correctNull(rs.getString("NPCD_WORK_WITH")));//30
				hshValues.put("NPCD_WORK_SINCE",Helper.correctNull(rs.getString("NPCD_WORK_SINCE")));//31
				hshValues.put("NPCD_WORK_SINCE_MON",Helper.correctNull(rs.getString("NPCD_WORK_SINCE_MON")));//32
				hshValues.put("NPCD_RETIRE_AGE",Helper.correctNull(rs.getString("NPCD_RETIRE_AGE")));//33
				hshValues.put("NPCD_BUSI_EST_YR",Helper.correctNull(rs.getString("NPCD_BUSI_EST_YR")));//34
				hshValues.put("NPCD_YRS_CUR_BUSI",Helper.correctNull(rs.getString("NPCD_YRS_CUR_BUSI")));//35
				hshValues.put("NPCD_MON_INCOME",Helper.correctNull(rs.getString("NPCD_MON_INCOME")));//36
				hshValues.put("NPCD_ISGUARANTOR",Helper.correctNull(rs.getString("NPCD_ISGUARANTOR")));//37
				hshValues.put("NPCD_DOR",Helper.correctNull(rs.getString("NPCD_DOR")));//38
				hshValues.put("NPCD_BUSI_EST_MON",Helper.correctNull(rs.getString("NPCD_BUSI_EST_MON")));//39
				hshValues.put("NPCD_CUR_BUSI_MON",Helper.correctNull(rs.getString("NPCD_CUR_BUSI_MON")));//40
				hshValues.put("NPCD_RESI_STAT",Helper.correctNull(rs.getString("NPCD_RESI_STAT")));//41
				hshValues.put("NPCD_INCOME_CONSIDER",Helper.correctNull(rs.getString("NPCD_INCOME_CONSIDER")));//42
				
				hshValues.put("NPCD_IS_AADHAR_DOB",Helper.correctNull(rs.getString("NPCD_IS_AADHAR_DOB")));//43
				hshValues.put("NPCD_APPLICATION_REFERENCE_ID",Helper.correctNull(rs.getString("NPCD_APPLICATION_REFERENCE_ID")));//44
				hshValues.put("NPCD_CREATED_BY",Helper.correctNull(rs.getString("NPCD_CREATED_BY")));//45
				hshValues.put("NPCD_CREATED_DT",Helper.correctNull(rs.getString("NPCD_CREATED_DT")));//46
				hshValues.put("NPCD_MODIFIED_BY",Helper.correctNull(rs.getString("NPCD_MODIFIED_BY")));//47
				hshValues.put("NPCD_MODIFIED_DT",Helper.correctNull(rs.getString("NPCD_MODIFIED_DT")));//48
				hshValues.put("NPCD_COAPP_REF_ID",Helper.correctNull(rs.getString("NPCD_COAPP_REF_ID")));//49
				hshValues.put("NPCD_ROW_ID",Helper.correctNull(rs.getString("NPCD_ROW_ID")));//50
				hshValues.put("NPCD_COAPP_ID",Helper.correctNull(rs.getString("NPCD_COAPP_ID")));//51
				strCo_appid=Helper.correctNull(rs.getString("NPCD_COAPP_ID"));
				
			}if(rs != null)
			{
				rs.close();
			}
			if(!strAadharAdd.equalsIgnoreCase("")&&!strCo_appid.equalsIgnoreCase(""))
			{
				strQuery = SQLParser.getSqlQuery("sel_aadhar_address^" + strAadharAdd+"^"+strCo_appid);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshValues.put("AD_NPAA_ID", rs.getString("NPAA_ID"));
					hshValues.put("AD_NPAA_STREET_NAME", rs.getString("NPAA_STREET_NAME"));
					hshValues.put("AD_NPAA_LAND_MARK", rs.getString("NPAA_LAND_MARK"));
					hshValues.put("AD_NPAA_COUNTRY_NAME", rs.getString("NPAA_COUNTRY_NAME"));
					hshValues.put("AD_NPAA_SUB_DISTRICT", rs.getString("NPAA_SUB_DISTRICT"));
					hshValues.put("AD_NPAA_VILLAGE", rs.getString("NPAA_VILLAGE"));
					hshValues.put("AD_NPAA_STATE_NAME", rs.getString("NPAA_STATE_NAME"));
					hshValues.put("AD_NPAA_CITY_NAME", rs.getString("NPAA_CITY_NAME"));
					hshValues.put("AD_NPAA_DISTRICT_NAME", rs.getString("NPAA_DISTRICT_NAME"));
					hshValues.put("AD_NPAA_PIN_CODE", rs.getString("NPAA_PIN_CODE"));
					hshValues.put("AD_NPAA_ROW_ID", rs.getString("NPAA_ROW_ID"));
					hshValues.put("AD_NPAA_CREATED_BY", rs.getString("NPAA_CREATED_BY"));
					hshValues.put("AD_NPAA_CREATED_ON", rs.getString("NPAA_CREATED_ON"));
					hshValues.put("AD_NPAA_MODIFIED_BY", rs.getString("NPAA_MODIFIED_BY"));
					hshValues.put("AD_NPAA_MODIFIED_ON", rs.getString("NPAA_MODIFIED_ON"));
					hshValues.put("AD_NPAA_COAPP_ID", rs.getString("NPAA_COAPP_ID"));
					hshValues.put("AD_NPAA_APP_REF_ID", rs.getString("NPAA_APP_REF_ID"));
					hshValues.put("AD_NPAA_COAPPREF_ID", rs.getString("NPAA_COAPPREF_ID"));
				}
			}
			if(!strCurrAddress.equalsIgnoreCase("")&&!strCo_appid.equalsIgnoreCase(""))
			{
				strQuery = SQLParser.getSqlQuery("sel_Curr_address^" + strCurrAddress+"^"+strCo_appid);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshValues.put("CU_NPCA_ID", rs.getString("NPCA_ID"));
					hshValues.put("CU_NPCA_STREET_NAME", rs.getString("NPCA_STREET_NAME"));
					hshValues.put("CU_NPCA_LAND_MARK", rs.getString("NPCA_LAND_MARK"));
					hshValues.put("CU_NPCA_COUNTRY_NAME", rs.getString("NPCA_COUNTRY_NAME"));
					hshValues.put("CU_NPCA_SUB_DISTRICT", rs.getString("NPCA_SUB_DISTRICT"));
					hshValues.put("CU_NPCA_VILLAGE", rs.getString("NPCA_VILLAGE"));
					hshValues.put("CU_NPCA_STATE_NAME", rs.getString("NPCA_STATE_NAME"));
					hshValues.put("CU_NPCA_CITY_NAME", rs.getString("NPCA_CITY_NAME"));
					hshValues.put("CU_NPCA_DISTRICT_NAME", rs.getString("NPCA_DISTRICT_NAME"));
					hshValues.put("CU_NPCA_PIN_CODE", rs.getString("NPCA_PIN_CODE"));
					hshValues.put("CU_NPCA_ROW_ID", rs.getString("NPCA_ROW_ID"));
					hshValues.put("CU_NPCA_CREATED_BY", rs.getString("NPCA_CREATED_BY"));
					hshValues.put("CU_NPCA_CREATED_ON", rs.getString("NPCA_CREATED_ON"));
					hshValues.put("CU_NPCA_MODIFIED_BY", rs.getString("NPCA_MODIFIED_BY"));
					hshValues.put("CU_NPCA_MODIFIED_ON", rs.getString("NPCA_MODIFIED_ON"));
					hshValues.put("CU_NPCA_COAPP_ID", rs.getString("NPCA_COAPP_ID"));
					hshValues.put("CU_NPCA_APP_REF_ID", rs.getString("NPCA_APP_REF_ID"));
					hshValues.put("CU_NPCA_COAPPREF_ID", rs.getString("NPCA_COAPPREF_ID"));
				}
			}
			if(!strCurrAddress.equalsIgnoreCase("")&&!strCo_appid.equalsIgnoreCase(""))
			{
				strQuery = SQLParser.getSqlQuery("sel_off_address^" + strCurrAddress+"^"+strCo_appid);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshValues.put("off_NPOA_ID", rs.getString("NPOA_ID"));
					hshValues.put("off_NPOA_STREET_NAME", rs.getString("NPOA_STREET_NAME"));
					hshValues.put("off_NPOA_LAND_MARK", rs.getString("NPOA_LAND_MARK"));
					hshValues.put("off_NPOA_COUNTRY_NAME", rs.getString("NPOA_COUNTRY_NAME"));
					hshValues.put("off_NPOA_SUB_DISTRICT", rs.getString("NPOA_SUB_DISTRICT"));
					hshValues.put("off_NPOA_VILLAGE", rs.getString("NPOA_VILLAGE"));
					hshValues.put("off_NPOA_STATE_NAME", rs.getString("NPOA_STATE_NAME"));
					hshValues.put("off_NPOA_CITY_NAME", rs.getString("NPOA_CITY_NAME"));
					hshValues.put("off_NPOA_DISTRICT_NAME", rs.getString("NPOA_DISTRICT_NAME"));
					hshValues.put("off_NPOA_PIN_CODE", rs.getString("NPOA_PIN_CODE"));
					hshValues.put("off_NPOA_ROW_ID", rs.getString("NPOA_ROW_ID"));
					hshValues.put("off_NPOA_CREATED_BY", rs.getString("NPOA_CREATED_BY"));
					hshValues.put("off_NPOA_CREATED_ON", rs.getString("NPOA_CREATED_ON"));
					hshValues.put("off_NPOA_MODIFIED_BY", rs.getString("NPOA_MODIFIED_BY"));
					hshValues.put("off_NPOA_MODIFIED_ON", rs.getString("NPOA_MODIFIED_ON"));
					hshValues.put("off_NPOA_COAPP_ID", rs.getString("NPOA_COAPP_ID"));
					hshValues.put("off_NPOA_APP_REF_ID", rs.getString("NPOA_APP_REF_ID"));
					hshValues.put("off_NPOA_COAPPREF_ID", rs.getString("NPOA_COAPPREF_ID"));
				}
			}
			String SchemeId="";
			strQuery = SQLParser.getSqlQuery("sel_applicationscheme_np^"+AppId);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				SchemeId=Helper.correctNull((String)rs.getString("NPDT_NP_SCHEME_NAME"));
			}
			 hshValues.put("POP_SCHEME_ID",SchemeId);
			
       }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> getPSB59ApplicantListDtls Method"+m);
       }
	return hshValues;
	
}

public HashMap getPSB59CourseDtls(HashMap hshValues) 
{
	String strQuery = "";
	ResultSet rs = null;
	String AppId = Helper.correctNull((String)hshValues.get("hidApplicantId"));
	String SegType = Helper.correctNull((String)hshValues.get("SegType"));
	
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	ArrayList arrInsCol = new ArrayList();
	ArrayList arrInsRow = new ArrayList();
	ArrayList arrSecCol = new ArrayList();
	ArrayList arrSecRow = new ArrayList();
	ArrayList arrSchCol = new ArrayList();
	ArrayList arrSchRow = new ArrayList();
       try {
    	   strQuery = SQLParser.getSqlQuery("getcostofcourse^"+AppId);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();

				arrCol.add(Helper.correctNull((String) rs.getString("NPCC_ROWID")));//0
				arrCol.add(Helper.correctNull((String) rs.getString("NPCC_COURSE_AMOUNT")));//1
				arrCol.add(Helper.correctNull((String) rs.getString("NPCC_COURSE_TYPE")));//2
				arrCol.add(Helper.correctNull((String) rs.getString("NPCC_COURSE_YEAR")));//3
				arrCol.add(Helper.correctNull((String) rs.getString("NPCC_ID")));//4
				
				arrRow.add(arrCol);
			}
			hshValues.put("arrRow", arrRow);
			
			if(rs != null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("getcourseDtls^"+AppId);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshValues.put("ID", Helper.correctNull((String) rs.getString("NPCD_ROW_ID")));
				hshValues.put("APPLICANTS_CONTRIBUTION", Helper.correctNull((String) rs.getString("NPCD_APPLICANT_CONTRIBUTION")));
				hshValues.put("COURSE_DURATION", Helper.correctNull((String) rs.getString("NPCD_COURSE_DURATION")));
				hshValues.put("COURSE_END_DATE", Helper.correctNull((String) rs.getString("NPCD_COURSE_END_DATE")));
				hshValues.put("COURSE_NAME", Helper.correctNull((String) rs.getString("NPCD_COURSE_NAME")));
				hshValues.put("COURSE_START_DATE", Helper.correctNull((String) rs.getString("NPCD_COURSE_START_DATE")));
				hshValues.put("EMPLOYEMENT_DESCRIPTION", Helper.correctNull((String) rs.getString("NPCD_EMPLOYEMENT_DESC")));
				hshValues.put("INSTITUTE_LOCATION", Helper.correctNull((String) rs.getString("NPCD_INSIT_LOC")));
				hshValues.put("INSTITUTE_NAME", Helper.correctNull((String) rs.getString("NPCD_INSIT_NAME")));
				hshValues.put("IS_PART_TIME_EMPLOYMENT", Helper.correctNull((String) rs.getString("NPCD_IS_PART_TIME_EMP")));
				
				hshValues.put("IS_PASSPORT_OBTAINED", Helper.correctNull((String) rs.getString("NPCD_PASSPORT_OBTAINED")));
				hshValues.put("IS_REPAY_INTEREST", Helper.correctNull((String) rs.getString("NPCD_IS_REPAY_INTEREST")));
				hshValues.put("IS_SCHOLARSHIP_AVAILED", Helper.correctNull((String) rs.getString("NPCD_IS_SCHOLARSHIP_AVAILED")));
				hshValues.put("IS_SECURITY", Helper.correctNull((String) rs.getString("NPCD_IS_SECURITY")));
				hshValues.put("LOAN_AMOUNT_REQUIRED", Helper.correctNull((String) rs.getString("NPCD_LOAN_AMT_REQ")));
				hshValues.put("PASSPORT_NO", Helper.correctNull((String) rs.getString("NPCD_PASSPORT_NO")));
				hshValues.put("PROPOSED_REPAYMENT_AMOUNT", Helper.correctNull((String) rs.getString("NPCD_AMOUNT")));
				hshValues.put("PROPOSED_REPAYMENT_BY", Helper.correctNull((String) rs.getString("NPCD_REPAYMENT_BY")));
				hshValues.put("PROPOSED_REPAYMENT_TENURE", Helper.correctNull((String) rs.getString("NPCD_TENURE")));
				hshValues.put("QUOTA_SELECTION", Helper.correctNull((String) rs.getString("NPCD_QUOTA_SELE")));
				hshValues.put("TYPE_OF_COURSE", Helper.correctNull((String) rs.getString("NPCD_TYPE_OF_COURSE")));
				hshValues.put("UNIVERSITY_NAME", Helper.correctNull((String) rs.getString("NPCD_UNIV_NAME")));
				
			}if(rs != null)
			{
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("sel_NPEduDetails^"+AppId);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arrInsCol = new ArrayList();
                //arrInsRow = new ArrayList();
                   
                arrInsCol.add(Helper.correctNull((String) rs.getString("NPED_ID")));//0
                arrInsCol.add(Helper.correctNull((String) rs.getString("NPED_ROW_ID")));//1
                arrInsCol.add(Helper.correctNull((String) rs.getString("NPED_APP_REF_ID")));//2
                arrInsCol.add(Helper.correctNull((String) rs.getString("NPED_INSITITUTE_NAME")));//3
                arrInsCol.add(Helper.correctNull((String) rs.getString("NPED_YEAR")));//4
				arrInsCol.add(Helper.correctNull((String) rs.getString("NPED_MARKS")));//5
				arrInsCol.add(Helper.correctNull((String) rs.getString("NPED_NO_OF_ATTEMPTS")));//6
				arrInsCol.add(Helper.correctNull((String) rs.getString("NPED_CLASS_OBTAINED")));//7
				arrInsCol.add(Helper.correctNull((String) rs.getString("NPED_SPECIALIZATION")));//8
				arrInsCol.add(Helper.correctNull((String) rs.getString("NPED_APPCOREFID")));//9
				arrInsCol.add(Helper.correctNull((String) rs.getString("NPED_TRANSACTION_ID")));//10
				arrInsCol.add(Helper.correctNull((String) rs.getString("NPED_SCHEDULER_ID")));//11
				arrInsCol.add(Helper.correctNull((String) rs.getString("NPED_SERVICE_ROW_ID")));//12
				arrInsCol.add(Helper.correctNull((String) rs.getString("NPED_INSTITUTION_ID")));//13
				
				arrInsRow.add(arrInsCol);
			}
			hshValues.put("arrInsRow", arrInsRow);
			if(rs != null)
			{
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("sel_NPEduSholarship^"+AppId);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arrSchCol = new ArrayList();
				//arrSchRow = new ArrayList();
                   
				arrSchCol.add(Helper.correctNull((String) rs.getString("NPSCL_ROWID")));//0
				arrSchCol.add(Helper.correctNull((String) rs.getString("NPSCL_APPLICATION_REFERENCE_ID")));//1
				arrSchCol.add(Helper.correctNull((String) rs.getString("NPSCL_SCHOLARSHIP_FIELD")));//2
				arrSchCol.add(Helper.correctNull((String) rs.getString("NPSCL_ID")));//3
				arrSchCol.add(Helper.correctNull((String) rs.getString("NPSCL_SCHOLARSHIP_NAME")));//4
				arrSchCol.add(Helper.correctNull((String) rs.getString("NPSCL_SCHOLARSHIP_AMOUNT")));//5
				arrSchCol.add(Helper.correctNull((String) rs.getString("NPSCL_SEQ_NO")));//6
				
				arrSchRow.add(arrSchCol);
			}
			hshValues.put("arrSchRow", arrSchRow);
			if(rs != null)
			{
				rs.close();
			}
    	   
			strQuery = SQLParser.getSqlQuery("sel_NPEduSecurity^"+AppId);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arrSecCol = new ArrayList();
				//arrSecRow = new ArrayList();
                   
				arrSecCol.add(Helper.correctNull((String) rs.getString("NPSD_ROWID")));//0
				arrSecCol.add(Helper.correctNull((String) rs.getString("NPSD_APPLICATION_REFERENCE_ID")));//1
				arrSecCol.add(Helper.correctNull((String) rs.getString("NPSD_SEC_TYPE")));//2
				arrSecCol.add(Helper.correctNull((String) rs.getString("NPSD_SEC_AMOUNT")));//3
				arrSecCol.add(Helper.correctNull((String) rs.getString("NPSD_SEC_SEQ")));//4
				arrSecCol.add(Helper.correctNull((String) rs.getString("NPSD_ID")));//5
				arrSecCol.add(Helper.correctNull((String) rs.getString("NPSD_TYPE_ID")));//6
				
				arrSecRow.add(arrSecCol);
			}
			
			hshValues.put("arrSecRow", arrSecRow);
			hshValues.put("SegType", SegType);
			if(rs != null)
			{
				rs.close();
			}
    	   
       }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> getPSB59CourseDtls Method"+m);
       }
	return hshValues;
	
}
@SuppressWarnings("unchecked")
public HashMap getITRDETAILS(HashMap hshValues) 
{
	String strQuery = "";
	ResultSet rs = null;
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow =new ArrayList();
	String AppId = Helper.correctNull((String)hshValues.get("hidApplicantId"));
       try {
    	   strQuery = SQLParser.getSqlQuery("getITRdetails^"+AppId);
			rs = DBUtils.executeQuery(strQuery);
			/*if (rs.next())
			{
				hshValues.put("ID", Helper.correctNull((String) rs.getString("NPFD_ROW_ID")));
				hshValues.put("APPLICATION_REFERENCE_ID", Helper.correctNull((String) rs.getString("NPFD_APP_REF_ID")));
				hshValues.put("CAPITAL_GAIN", Helper.correctNull((String) rs.getString("NPFD_CAPITAL_GAIN")));
				hshValues.put("GROSS_INCOME", Helper.correctNull((String) rs.getString("NPFD_GROSS_INCOME")));
				hshValues.put("GROSS_MONTHLY_INCOME", Helper.correctNull((String) rs.getString("NPFD_GROSS_MONTHLY_INCOME")));
				hshValues.put("HOUSE_PROPERTY", Helper.correctNull((String) rs.getString("NPFD_HOUSE_PROPERTY")));
				hshValues.put("IS_MANUAL_FILLED", Helper.correctNull((String) rs.getString("NPFD_IS_MANUALLY_FILLED")));
				hshValues.put("NET_MONTHLY_INCOME", Helper.correctNull((String) rs.getString("NPFD_NET_MONTHLY_INCOME")));
				hshValues.put("OTHER_SOURCE", Helper.correctNull((String) rs.getString("NPFD_OTHER_SOURCE")));
				hshValues.put("PGBP", Helper.correctNull((String) rs.getString("NPFD_PGBP")));
				hshValues.put("SALARY_INCOME", Helper.correctNull((String) rs.getString("NPFD_SALARY_INCOME")));
				hshValues.put("TAXABLE_INCOME", Helper.correctNull((String) rs.getString("NPFD_TAXABLE_INCOME")));
				
			}*/
			while (rs.next())
			{
				arrCol = new ArrayList();
                   
				arrCol.add(Helper.correctNull((String) rs.getString("NPFD_ROW_ID")));//0
				arrCol.add(Helper.correctNull((String) rs.getString("NPFD_APP_REF_ID")));//1
				arrCol.add(Helper.correctNull((String) rs.getString("NPFD_CAPITAL_GAIN")));//2
				arrCol.add(Helper.correctNull((String) rs.getString("NPFD_GROSS_INCOME")));//3
				arrCol.add(Helper.correctNull((String) rs.getString("NPFD_GROSS_MONTHLY_INCOME")));//4
				arrCol.add(Helper.correctNull((String) rs.getString("NPFD_HOUSE_PROPERTY")));//5
				arrCol.add(Helper.correctNull((String) rs.getString("NPFD_IS_MANUALLY_FILLED")));//6
				arrCol.add(Helper.correctNull((String) rs.getString("NPFD_NET_MONTHLY_INCOME")));//7
				arrCol.add(Helper.correctNull((String) rs.getString("NPFD_OTHER_SOURCE")));//8
				arrCol.add(Helper.correctNull((String) rs.getString("NPFD_PGBP")));//9
				arrCol.add(Helper.correctNull((String) rs.getString("NPFD_SALARY_INCOME")));//10
				arrCol.add(Helper.correctNull((String) rs.getString("NPFD_TAXABLE_INCOME")));//11
				
				arrRow.add(arrCol);
			}
			hshValues.put("arrRow", arrRow);
			if(rs != null)
			{
				rs.close();
			}
    	   
       }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> getITRDETAILS Method"+m);
       }
	return hshValues;
	
}
@SuppressWarnings("unchecked")
public HashMap getDOCDETAILS(HashMap hshValues) 
{
	String strQuery = "";
	ResultSet rs = null;
	
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	String strFileExtension="";
	String AppId = Helper.correctNull((String)hshValues.get("hidApplicantId"));
	if(AppId.equalsIgnoreCase("")){
	AppId = Helper.correctNull((String)hshValues.get("strapprefid"));
	
	}
	if(AppId.equalsIgnoreCase("")){
		AppId = Helper.correctNull((String)hshValues.get("txt_apprefid"));
		
		}
	if(AppId.equalsIgnoreCase("")){
		AppId = Helper.correctNull((String)hshValues.get("strApplicationRefNo"));
		
		}
       try {
    	   strQuery = SQLParser.getSqlQuery("getNPDocDetails1^"+AppId);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull((String) rs.getString("NPDD_ROW_ID")));//0
				arrCol.add(Helper.correctNull((String) rs.getString("NPDD_SEQ_NO")));//1
				arrCol.add(Helper.correctNull((String) rs.getString("NPDD_DOCUMENT_NAME")));//2
				arrCol.add("");
				arrCol.add(Helper.correctNull((String) rs.getString("NPDD_APP_REF_ID")));//4					
				//strFileExtension =FilenameUtils.getExtension(Helper.correctNull((String) rs.getString("NPDD_DOCUMENT_NAME")));
				arrCol.add(strFileExtension);//6
				arrRow.add(arrCol);
			}
			hshValues.put("arrRow", arrRow);
			if(rs != null)
			{
				rs.close();
			}
			hshValues.put("hidApplicantId", AppId);
			hshValues.put("strApplicationRefNo", AppId);
			
       }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> getDOCDETAILS Method"+m);
       }
	return hshValues;
	
}
@SuppressWarnings("unchecked")
public HashMap getBREMATCHDETAILS(HashMap hshValues) 
{
	String strQuery = "";
	ResultSet rs = null;
	HashMap hshResult = new HashMap();
	ArrayList arryRow = new ArrayList();
	ArrayList arrCol = null;
	String strApplicationRefNo=Helper.correctNull((String) hshValues.get("hidApplicantId"));
	if(strApplicationRefNo.equalsIgnoreCase("")){
		strApplicationRefNo=Helper.correctNull((String) hshValues.get("strApplicationRefNo"));
	}
	try
	{
			    strQuery = SQLParser.getSqlQuery("getBREDetails^"+strApplicationRefNo);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(Helper.correctNull((String) rs.getString("NPMD_APPLICATION_REFERENCE_ID")));//1
					arrCol.add(Helper.correctNull((String) rs.getString("NPMD_ROW_ID")));//0
					arrCol.add(Helper.correctNull((String) rs.getString("NPMD_PARAMETER_NAME")));//2
					arrCol.add("");//3
					arrCol.add("");//4
					arrCol.add(Helper.correctNull((String) rs.getString("NPMD_APPLICANT_TYPE")));//5
					arrCol.add(Helper.correctNull((String) rs.getString("NPMD_IS_MANDATORY")));//6
					arrCol.add(Helper.correctNull((String) rs.getString("NPMD_IS_MATCHED")));//7
					arryRow.add(arrCol);
				}
		hshValues.put("strApplicationRefNo",strApplicationRefNo);
		hshValues.put("arryRow", arryRow);	
	}
	catch(Exception ex)
	{
		Logger.log("Exception in getNpapplications"+ex);
	}	
return hshValues;	

}

@SuppressWarnings("unchecked")
public HashMap PSB59getApplicationDetailsList(HashMap hshValues) 
{
	String strQuery = "";
	String status = "",authStatus="",IsAuthorized="",strOrgCode="";
	ResultSet rs = null;
	String apprefid="";
	ArrayList arrRow=new ArrayList();
	ArrayList arrCol=new ArrayList();
	String strUser=correctNull((String) hshValues.get("strUserId"));
	String strOrgLevel = correctNull((String) hshValues.get("strOrgLevel"));
	String SegType=correctNull((String) hshValues.get("sel_nsdlStatus")); 
	if(SegType.equalsIgnoreCase(""))
	{
		SegType=correctNull((String) hshValues.get("selsegment")); 
	}
	
	strOrgCode = correctNull((String) hshValues.get("strOrgCode"));
		try
	{
	   /*if(strOrgLevel.equalsIgnoreCase("A"))
	   {*/
		
		if(SegType.equalsIgnoreCase("EDU") || SegType.equalsIgnoreCase("HL"))
		{
		strQuery = SQLParser.getSqlQuery("selNPIApplications^"+strOrgCode+"^"+SegType);
		rs = DBUtils.executeQuery(strQuery);
		}
		else if(SegType.equalsIgnoreCase("LHD"))
		{
		strQuery = SQLParser.getSqlQuery("selNPIApplications_LHD^"+strOrgCode+"^"+SegType+"^"+strOrgCode+"^"+SegType+"^"+strOrgCode+"^"+SegType);
		rs = DBUtils.executeQuery(strQuery);
		}
		else if(SegType.equalsIgnoreCase("AGRI"))
		{
		strQuery = SQLParser.getSqlQuery("selNPIApplications_AGRI^"+strOrgCode+"^"+SegType+"^"+strOrgCode+"^"+SegType);
		rs = DBUtils.executeQuery(strQuery);
		}
		else if(SegType.equalsIgnoreCase("BS"))
		{
		strQuery = SQLParser.getSqlQuery("selNPIApplications_BS^"+strOrgCode+"^"+SegType+"^"+strOrgCode+"^"+SegType+"^"+strOrgCode+"^"+SegType);
		rs = DBUtils.executeQuery(strQuery);
		}
		while(rs.next())
		{
			arrCol = new ArrayList();
			arrCol.add(Helper.correctNull(rs.getString("NPDT_ROWID")));//0
			arrCol.add(Helper.correctNull(rs.getString("NPDT_APPLICATIONCODE")));	//1
			arrCol.add(Helper.correctNull(rs.getString("NPDT_CREATEDDATETIME")));//2
			arrCol.add(Helper.correctNull(rs.getString("NPDT_APPLICATIONREFERENCEID")));//3
			apprefid=Helper.correctNull(rs.getString("NPDT_APPLICATIONREFERENCEID"));
			arrCol.add(Helper.correctNull(rs.getString("NPDT_SCHEMEID")));//4
			arrCol.add(Helper.correctNull(rs.getString("NPDT_SCHEMENAME")));//5
			if(Helper.correctNull(rs.getString("NPDT_LAPS_ACCEPTED")).equalsIgnoreCase("105")){
				status="Hold";
			}else if(Helper.correctNull(rs.getString("NPDT_LAPS_ACCEPTED")).equalsIgnoreCase("102")){
				status="Rejection Recommended for RO";
			}else if(Helper.correctNull(rs.getString("NPDT_LAPS_ACCEPTED")).equalsIgnoreCase("104") && Helper.correctNull(rs.getString("NPDT_APPLICATIONSTATUS")).equalsIgnoreCase("")){
				status="Rejection Recommended for RO";
			}else if(Helper.correctNull(rs.getString("NPDT_LAPS_ACCEPTED")).equalsIgnoreCase("104") && Helper.correctNull(rs.getString("NPDT_APPLICATIONSTATUS")).equalsIgnoreCase("04")){
				status="Rejected";
			}else if(Helper.correctNull(rs.getString("NPDT_LAPS_ACCEPTED")).equalsIgnoreCase("105")){
				status="Hold";
			}
			else{
				status="";
			}
			
			if(Helper.correctNull(rs.getString("NPDT_APPLICATIONSTATUS")).equalsIgnoreCase("02")){
				status="Sanctioned";
			}else if(Helper.correctNull(rs.getString("NPDT_APPLICATIONSTATUS")).equalsIgnoreCase("03")){
				status="Disbursed";
			}
			
			arrCol.add(status);//6
			arrCol.add(Helper.correctNull(rs.getString("CUST_NAME")));//7
			authStatus = Helper.correctNull(rs.getString("NPDT_AUTHORIZE_FLAG"));
			
			if(authStatus.equalsIgnoreCase("Y"))
			{
			IsAuthorized = "Authorized";
			}
			else if(authStatus.equalsIgnoreCase("N"))
			{
			IsAuthorized = "UnAuthorized";
			}
			else
			{
		    IsAuthorized = "";
			}
			arrCol.add(IsAuthorized);//8
			arrCol.add(Helper.correctNull(rs.getString("NPDT_NP_SCHEME_NAME")));//9
			
			arrRow.add(arrCol);
		}
		hshValues.put("arrRow", arrRow);
		hshValues.put("apprefid", apprefid);
		
		hshValues.put("SegType", SegType);
	   /*}
	   else if(strOrgLevel.equalsIgnoreCase("R") || strOrgLevel.equalsIgnoreCase("C"))
	   {
		   strQuery = SQLParser.getSqlQuery("selNPIApplications_RO");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
			arrCol = new ArrayList();
			
			arrCol.add(Helper.correctNull(rs.getString("NPDT_ROWID")));//0
			arrCol.add(Helper.correctNull(rs.getString("NPDT_APPLICATIONCODE")));	//1
			arrCol.add(Helper.correctNull(rs.getString("NPDT_CREATEDDATETIME")));//2
			arrCol.add(Helper.correctNull(rs.getString("NPDT_APPLICATIONREFERENCEID")));//3
			arrCol.add(Helper.correctNull(rs.getString("NPDT_SCHEMEID")));//4
			arrCol.add(Helper.correctNull(rs.getString("NPDT_SCHEMENAME")));//5
			if(Helper.correctNull(rs.getString("NPDT_LAPS_ACCEPTED")).equalsIgnoreCase("08")){
				status="Rejection Recommended for RO";
			}
			arrCol.add(status);//6
			arrCol.add(Helper.correctNull(rs.getString("CUST_NAME")));//7
			arrRow.add(arrCol);
		   }
		hshValues.put("arrRow", arrRow);
	   }*/
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	finally
	{
		try {
			if (rs != null) {
				rs.close();
			}

		} catch (Exception e1) {
			throw new EJBException("Error closing connection..." + e1);
		}
	}
	return hshValues;
}
@SuppressWarnings("unchecked")
public HashMap getReallocationList(HashMap hshValues) 
{
	String strQuery = "";
	String strOrgCode="";
	ResultSet rs = null;
	ArrayList arrRow=new ArrayList();
	ArrayList arrCol=new ArrayList();
	String strUser=correctNull((String) hshValues.get("strUserId"));
	String strOrgLevel = correctNull((String) hshValues.get("strOrgLevel")); 
	String apprefid = correctNull((String) hshValues.get("hidapprefid")); 
		try
	{
		strQuery = SQLParser.getSqlQuery("selOrgCode^"+strUser);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strOrgCode = Helper.correctNull(rs.getString("orgcode"));
		}
		if(rs!=null)
		{
			rs.close();
		}
		strQuery = SQLParser.getSqlQuery("selNPIApplicationsrealloac^"+strOrgCode+"^"+apprefid);
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			arrCol = new ArrayList();
			arrCol.add(Helper.correctNull(rs.getString("NPDT_ROWID")));//0
			arrCol.add(Helper.correctNull(rs.getString("NPDT_APPLICATIONCODE")));//1
			arrCol.add(Helper.correctNull(rs.getString("NPDT_CREATEDDATETIME")));//2
			arrCol.add(Helper.correctNull(rs.getString("NPDT_APPLICATIONREFERENCEID")));//3
			arrCol.add(Helper.correctNull(rs.getString("NPDT_SCHEMEID")));//4
			arrCol.add(Helper.correctNull(rs.getString("NPDT_SCHEMENAME")));//5
			arrCol.add(Helper.correctNull(rs.getString("CUST_NAME")));//6
			arrCol.add(Helper.correctNull(rs.getString("NPDT_ORGCODE")));//7
			
			arrRow.add(arrCol);
		}
		hshValues.put("arrRow", arrRow);
		hshValues.put("apprefid", apprefid);
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	finally
	{
		try {
			if (rs != null) {
				rs.close();
			}

		} catch (Exception e1) {
			throw new EJBException("Error closing connection..." + e1);
		}
	}
	return hshValues;
}

@SuppressWarnings("unchecked")
public HashMap updateReallocationList(HashMap hshValues) 
{
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = null;
	ArrayList arrValues = null;
	
	try
	{
		hshQuery = new HashMap();
		arrValues = new ArrayList();
		
		hshQuery.put("strQueryId", "upd_npreallocapp");
		
		arrValues.add(correctNull((String) hshValues.get("org_alphacode")));
		arrValues.add(correctNull((String) hshValues.get("strUserId")));
		arrValues.add(correctNull((String) hshValues.get("hidReferId")));
		
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);
		hshQueryValues.put("size","1");
		
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	}
	catch(Exception e)
	{
	   Logger.log("Error in PSB59 Bean -> updateReallocationList : " +e);
	}
	return hshValues;
}

public HashMap NP_viewAttachedDocument(HashMap hshValues) 
{
	HashMap hshResult=new HashMap();
	ResultSet rs=null;
	String strQuery;	
	Connection connection = null;
	Statement statement = null;
	String strFileExtension="",strMimeType="",strFileName1="";
	String strRefId=Helper.correctNull((String)hshValues.get("strRefId"));
	if(strRefId.equalsIgnoreCase(""))
	{
		strRefId=Helper.correctNull((String)hshValues.get("strRefId"));
	}
	String strSlno=Helper.correctNull((String)hshValues.get("hidSno"));
	byte[] byteDocData = null;
	Blob Blobdata=null;
	String strFileName="";
	try
	{			strFileName1 = strRefId+"_RESPONSE";
	strQuery=SQLParser.getSqlQuery("sel_NPdocView^"+strRefId+"^"+strSlno );			
	rs=DBUtils.executeQuery(strQuery);
	if(rs.next())
	{
		 Blobdata =rs.getBlob("NPDD_DOCUMENT");
		 strFileName = Helper.correctNull(rs.getString("NPDD_DOCUMENT_NAME"));
	}
		String file_extension = strFileName.substring(strFileName.lastIndexOf(".") + 1, strFileName.length());
		if(file_extension.equalsIgnoreCase("pdf")){
		strMimeType = "application/stream";
		if(Blobdata!=null && Blobdata.length()>0)
		{ 
			byteDocData = Blobdata.getBytes(0, (int) Blobdata.length());
			strFileExtension="pdf";
			MastApplicantBean mstApplicantBean = new MastApplicantBean();
			strMimeType = mstApplicantBean.getMimeType(strFileExtension);
			strMimeType="application/pdf";
			Logger.log("Inside the view National portal method  Manasa Jannivaram strMimeType ::::"+strMimeType);
		}
		else
		{
			hshResult.put("Message","No Document Attached To View");
		}
	}else if(file_extension.equalsIgnoreCase("jpg")){
		byteDocData =  Blobdata.getBytes(1, (int) Blobdata.length());
		MastApplicantBean mstApplicantBean = new MastApplicantBean();
		strFileExtension ="jpg";
		strMimeType = mstApplicantBean.getMimeType(strFileExtension);
		strMimeType="image/gif";
		Logger.log("Inside the view National portal method  Manasa Jannivaram strMimeType ::::"+strMimeType);
	}
	else if(file_extension.equalsIgnoreCase("gif")){
		byteDocData =  Blobdata.getBytes(1, (int) Blobdata.length());
		MastApplicantBean mstApplicantBean = new MastApplicantBean();
		strFileExtension ="gif";
		strMimeType = mstApplicantBean.getMimeType(strFileExtension);
		strMimeType="image/gif";
		Logger.log("Inside the view National portal method  Manasa Jannivaram strMimeType ::::"+strMimeType);
	}
	else if(file_extension.equalsIgnoreCase("png")){
		byteDocData =  Blobdata.getBytes(1, (int) Blobdata.length());
		MastApplicantBean mstApplicantBean = new MastApplicantBean();
		strFileExtension ="png";
		strMimeType = mstApplicantBean.getMimeType(strFileExtension);
		strMimeType="image/gif";
		Logger.log("Inside the view National portal method  Manasa Jannivaram strMimeType ::::"+strMimeType);
	}
	else if(file_extension.equalsIgnoreCase("xls")){
		byteDocData =  Blobdata.getBytes(1, (int) Blobdata.length());
		MastApplicantBean mstApplicantBean = new MastApplicantBean();
		strFileExtension ="xls";
		strMimeType = mstApplicantBean.getMimeType(strFileExtension);
		strMimeType="application/vnd.ms-excel";
		Logger.log("Inside the view National portal method  Manasa Jannivaram strMimeType ::::"+strMimeType);
	}	
	
	if(byteDocData!=null)
	{
		
		Logger.log("Inside the if block  byteDocData ::::"+byteDocData);
		hshResult.put("photoimg", byteDocData);
		hshResult.put("FILE_STREAM_NAME",strFileName1);
		hshResult.put("FILE_STREAM", byteDocData);
		hshResult.put("FILE_STREAM_TYPE",strMimeType);
		hshResult.put("BLOB_IMAGE",Blobdata);
		hshResult.put("FILE_STREAM_DISPOSITION_TYPE","inline");
		
	
	}
		
		
	}
	catch(Exception e)
	{
		throw new EJBException("Error in ApplicationBean ===> viewAttachedDocument method"+e.getMessage());		
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
		catch(Exception e)
		{
			throw new EJBException("Error in closing Connection (AttachDocumentBean ==> viewAttachedDocument)"+e.getMessage());
		}
	}
	return hshResult;
}
public HashMap getPSB59applicaionSearch(HashMap hshValues) 
{
	HashMap hshResult=new HashMap();
	ResultSet rs=null;
	String strQuery;	
	Connection connection = null;
	Statement statement = null;
	String strFileExtension="",strMimeType="",strFileName1="";
	String strRefId=Helper.correctNull((String)hshValues.get("strRefId"));		
	String strSlno=Helper.correctNull((String)hshValues.get("hidSno"));
	byte[] byteDocData = null;
	Blob Blobdata=null;
	try
	{		strFileName1 = strRefId+"_RESPONSE";
		strQuery=SQLParser.getSqlQuery("sel_NPdocView^"+strRefId+"^"+strSlno );			
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			 Blobdata =rs.getBlob("NPDD_DOCUMENT");
			//String strFileName = Helper.correctNull(rs.getString("nd_docname"));
			/*if(!strFileName.equals(""))
			{
				if(strFileName.length()>=4)
				{
					strFileExtension = strFileName.substring(strFileName.length() - 3, strFileName.length());
					strMimeType =Helper.getMimeType(strFileExtension.trim());
				}
				else
				{
					strMimeType = "application/stream";
				}
			}	*/	
			strMimeType = "application/stream";
			if(Blobdata!=null && Blobdata.length()>0)
			{ byteDocData = Blobdata.getBytes(0, (int) Blobdata.length());
				strFileExtension="pdf";
				MastApplicantBean mstApplicantBean = new MastApplicantBean();
				strMimeType="application/pdf";
				Logger.log("Inside the view equifax method  shyam2 strMimeType ::::"+strMimeType);
				if(byteDocData!=null)
				{
					
					Logger.log("Inside the if block shyam3 byteDocData ::::"+byteDocData);
					hshResult.put("photoimg", byteDocData);
					hshResult.put("FILE_STREAM_NAME",strFileName1);
					hshResult.put("FILE_STREAM", byteDocData);
					hshResult.put("FILE_STREAM_TYPE",strMimeType);
					hshResult.put("BLOB_IMAGE",Blobdata);
					hshResult.put("FILE_STREAM_DISPOSITION_TYPE","inline");
					
				
				}
			}
			else
			{
				hshResult.put("Message","No Document Attached To View");
			}
		}
		
		
	}
	catch(Exception e)
	{
		throw new EJBException("Error in ApplicationBean ===> viewAttachedDocument method"+e.getMessage());		
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
		catch(Exception e)
		{
			throw new EJBException("Error in closing Connection (AttachDocumentBean ==> viewAttachedDocument)"+e.getMessage());
		}
	}
	return hshResult;
}



@SuppressWarnings("unchecked")
public HashMap PSB59getPrincipleDetailsList(HashMap hshValues) 
{
	String strQuery = "";
	ResultSet rs = null;
	String AppId = Helper.correctNull((String)hshValues.get("hidApplicantId"));
       try {
    	   strQuery = SQLParser.getSqlQuery("selpeincipledetails^"+AppId);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshValues.put("ADDRESS", Helper.correctNull((String) rs.getString("NPID_ADDRESS")));
				hshValues.put("ID", Helper.correctNull((String) rs.getString("NPID_ROWID")));
				hshValues.put("APPLICATION_REFERENCE_ID", Helper.correctNull((String) rs.getString("NPID_APPLICATION_REFERENCE_ID")));
				hshValues.put("BRANCH_CODE", Helper.correctNull((String) rs.getString("NPID_BRANCH_CODE")));
				hshValues.put("BRANCH_NAME", Helper.correctNull((String) rs.getString("NPID_BRANCH_NAME")));
				hshValues.put("CONTACT_NUMBER", Helper.correctNull((String) rs.getString("NPID_CONTACT_NUM")));
				hshValues.put("EL_AMOUNT", Helper.correctNull((String) rs.getString("NPID_LOAN_AMT")));
				hshValues.put("EL_EMI", Helper.correctNull((String) rs.getString("NPID_EMI")));
				hshValues.put("EL_PROCESSING_FEE", Helper.correctNull((String) rs.getString("NPID_PROCESS_FEE")));
				hshValues.put("EL_ROI", Helper.correctNull((String) rs.getString("NPID_ROI")));
				hshValues.put("EL_TENURE", Helper.correctNull((String) rs.getString("NPID_TENOR")));
				hshValues.put("IFSC_CODE", Helper.correctNull((String) rs.getString("NPID_IFSC_CODE")));
				hshValues.put("JOURNEY_COMPLETION_DATE", Helper.correctNull((String) rs.getString("NPID_JOURNEY_CMPLT_DT")));
				hshValues.put("SUBSIDY_AMOUNT", Helper.correctNull((String) rs.getString("NPID_SUBSIDY_AMT")));
				
			}if(rs != null)
			{
				rs.close();
			}
    	   
       }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> getDOCDETAILS Method"+m);
       }
	return hshValues;
	
}

@SuppressWarnings("unchecked")
public HashMap getNPInboxDetails(HashMap hshValues) 
{
	String strQuery = "",status="",strBranchHead="",strBranchHeadflag="";
	ResultSet rs = null;
	
	ArrayList arrRow=new ArrayList();
	ArrayList arrCol=new ArrayList();
	
	String strUsrid =  Helper.correctNull((String)hshValues.get("strUserId"));
	try
	{
		strQuery=SQLParser.getSqlQuery("sel_branchHeadrestrict1^"+strUsrid);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strBranchHead=Helper.correctNull((String)rs.getString("ORG_HEAD"));
		}
		if(rs!=null)
		{
			rs.close();
		}
		if(strUsrid.equals(strBranchHead))
		{
			strBranchHeadflag="Y";
		}else{
			strBranchHeadflag="N";
		}
		hshValues.put("strBranchHead",strBranchHeadflag);
		
		strQuery = SQLParser.getSqlQuery("selnpinboxappdetails");
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			arrCol = new ArrayList();
			arrCol.add(Helper.correctNull(rs.getString("NPDT_ROWID")));//0
			arrCol.add(Helper.correctNull(rs.getString("NPDT_APPLICATIONCODE")));	//1
			arrCol.add(Helper.correctNull(rs.getString("NPDT_CREATEDDATETIME")));//2
			arrCol.add(Helper.correctNull(rs.getString("NPDT_APPLICATIONREFERENCEID")));//3
			arrCol.add(Helper.correctNull(rs.getString("NPDT_SCHEMEID")));//4
			arrCol.add(Helper.correctNull(rs.getString("NPDT_SCHEMENAME")));//5
			arrCol.add(Helper.correctNull(rs.getString("LAPS_APPID")));//6
			arrCol.add(Helper.correctNull(rs.getString("LAPS_CBSID")));//7
			arrCol.add(Helper.correctNull(rs.getString("CUST_NAME")));//8
			arrCol.add(Helper.correctNull(rs.getString("NPPD_PAN_NO")));//9
			arrCol.add(Helper.correctNull(rs.getString("NPPD_ORG_NAME")));//10
			/*if(Helper.correctNull(rs.getString("NP_ACCEPT_FLAG")).equals("Y")){
				arrCol.add("Accepted");
			}else{
				arrCol.add("");
			}*/
			if(Helper.correctNull(rs.getString("NPDT_LAPS_ACCEPTED")).equalsIgnoreCase("105")){
				status="Hold";
			}else if(Helper.correctNull(rs.getString("NPDT_LAPS_ACCEPTED")).equalsIgnoreCase("102")){
				status="Rejection Recommended for RO";
			}else if(Helper.correctNull(rs.getString("NPDT_LAPS_ACCEPTED")).equalsIgnoreCase("104") && Helper.correctNull(rs.getString("NPDT_APPLICATIONSTATUS")).equalsIgnoreCase("")){
				status="Rejection Recommended for RO";
			}else if(Helper.correctNull(rs.getString("NPDT_LAPS_ACCEPTED")).equalsIgnoreCase("104") && Helper.correctNull(rs.getString("NPDT_APPLICATIONSTATUS")).equalsIgnoreCase("04")){
				status="Rejected";
			}else if(Helper.correctNull(rs.getString("NPDT_LAPS_ACCEPTED")).equalsIgnoreCase("105")){
				status="Hold";
			}
			else{
				status="";
			}
			
			if(Helper.correctNull(rs.getString("NPDT_APPLICATIONSTATUS")).equalsIgnoreCase("02")){
				status="Sanctioned";
			}else if(Helper.correctNull(rs.getString("NPDT_APPLICATIONSTATUS")).equalsIgnoreCase("03")){
				status="Disbursed";
			}
			arrCol.add(status);
			//arrCol.add(Helper.correctNull(rs.getString("NP_ACCEPT_FLAG")));//11
			arrCol.add(Helper.correctNull(rs.getString("APPNUMBER")));//12
			
			arrRow.add(arrCol);
		}
		hshValues.put("arrRow", arrRow);
		 
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	finally
	{
		try {
			if (rs != null) {
				rs.close();
			}

		} catch (Exception e1) {
			throw new EJBException("Error closing connection..." + e1);
		}
	}
	return hshValues;
}

@SuppressWarnings("unchecked")
public HashMap PSB59updatenpinbox(HashMap hshValues)  {
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = null;
	ArrayList arrValues = null;
	
	String strQuery = "",strQuery1 = "",strQuery2 = "",strQuery3 = "";
	ResultSet rs = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	ResultSet rs3 = null;
	String AppRefId = Helper.correctNull((String)hshValues.get("hidrefId"));
	String AppId = Helper.correctNull((String)hshValues.get("hidId"));
	try {
		    strQuery3 = SQLParser.getSqlQuery("selDisbursementDone^"+AppRefId);
		    rs3 = DBUtils.executeQuery(strQuery3);
		    strQuery2 = SQLParser.getSqlQuery("sel_mapping_check_null^"+AppRefId);
		    rs2 = DBUtils.executeQuery(strQuery2);
			strQuery = SQLParser.getSqlQuery("sel_mapping_check^"+AppRefId);
			rs = DBUtils.executeQuery(strQuery);
			strQuery1 = SQLParser.getSqlQuery("sel_perappprofile_check^"+AppId);
			rs1 = DBUtils.executeQuery(strQuery1);
			if(rs3.next())
			{
				String strExp ="Application has already been Disbursed";
				hshValues.put("showAlerMsg",strExp);
			}
			else if(!rs2.next())
			{
				String strExp ="You Cannot Accept the Profile, Kindly Map CBSID for Applicant/Co-Applicant -> CBSID";
				hshValues.put("showAlerMsg",strExp);
			}
			else if(rs.next())
			{
				String strExp ="You Cannot Accept the Profile, Kindly Map CBSID for Applicant/Co-Applicant -> CBSID";
				hshValues.put("showAlerMsg",strExp);
			}
			else if(rs1.next())
			{
				String strExp ="Customer Profile Creation is Incomplete, Cannot Accept the Application";
				hshValues.put("showAlerMsg",strExp);
			}
			else{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				
				hshQuery.put("strQueryId", "upd_np_applications");
				
				arrValues.add(correctNull((String) hshValues.get("strOrgCode")));
				//arrValues.add(correctNull((String) hshValues.get("strUserId")));
				arrValues.add(correctNull((String) hshValues.get("hidId")));
				arrValues.add(correctNull((String) hshValues.get("hidrefId")));
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
		}
	catch (Exception e)
	{
		Logger.log("Error in PSB59Bean -> PSB59updatenpinbox method.." + e);
		
	}finally
	{
		try
		{
			if(rs!=null)rs.close();
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in Closing Connection "+e.toString());
		}
		
		
	}
	PSB59getApplicationDetailsList(hshValues);
	return hshValues;
}


@SuppressWarnings("unchecked")
public HashMap PSB59getHoldRejStatus(HashMap hshValues) 
{
	String strQuery ="",strBranchHead="",strBranchHeadflag="";
	ResultSet rs= null;
	String strUsrid =  Helper.correctNull((String)hshValues.get("strUserId"));
	String AppId = Helper.correctNull((String)hshValues.get("hidApplicantId"));
	String ApplicationNo = Helper.correctNull((String)hshValues.get("hidApplicationNo"));
	String strAppcallflg="";
	String strBranchHead1=Helper.correctNull((String)hshValues.get("strBranchHead"));
	String strOrgLevel=Helper.correctNull((String)hshValues.get("strOrgLevel"));
	   try {
			strQuery=SQLParser.getSqlQuery("sel_branchHeadrestrict1^"+strUsrid);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strBranchHead=Helper.correctNull((String)rs.getString("ORG_HEAD"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			if(strUsrid.equals(strBranchHead))
			{
				strBranchHeadflag="Y";
			}else{
				strBranchHeadflag="N";
			}
			hshValues.put("strBranchHead",strBranchHeadflag);
			
    	   strQuery = SQLParser.getSqlQuery("selHoldRejStatus^"+AppId);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshValues.put("STATUS", Helper.correctNull((String) rs.getString("NPDT_LAPS_ACCEPTED")));
				hshValues.put("REMARKS", Helper.correctNull((String) rs.getString("NPDT_REMARKS")));
				hshValues.put("AUTH_FLAG", Helper.correctNull((String) rs.getString("NPDT_AUTHORIZE_FLAG")));
				
			}if(rs != null)
			{
				rs.close();
			}
			
			
			strQuery = SQLParser.getSqlQuery("selDisbursementDone^"+AppId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				String strExp ="Application has already been Disbursed";
				hshValues.put("showDisbMsg",strExp);
			}
			if(rs != null)
			{
				rs.close();
			}
			if(!ApplicationNo.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("selSanctionDone^"+ApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if(!rs.next())
			{
				String strExp ="Kindly Create The Applicaion Before Proceeding for Disbursement Update";
				hshValues.put("showAlerMsg",strExp);
			}if(rs != null)
			{
				rs.close();
			}
			}
		//	if(strOrgLevel.equalsIgnoreCase("A") && strBranchHead.equalsIgnoreCase("Y")||((strOrgLevel.equalsIgnoreCase("C") || strOrgLevel.equalsIgnoreCase("R"))))
		//	{
			 strQuery = SQLParser.getSqlQuery("sel_updateproposalflag^"+AppId);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					strAppcallflg=Helper.correctNull((String) rs.getString("NPDT_APPLICATIONSTATUS"));
				}
				if(rs != null)
				{
					rs.close();
				}
				hshValues.put("strAppcallflg",strAppcallflg);
				if(strAppcallflg.equalsIgnoreCase("04") || strAppcallflg.equalsIgnoreCase("05")){
                    NationalPortalBean npapi= new NationalPortalBean();
					npapi.invokeProposalStatusAPI(hshValues);
					//nationalPortalBean.invokeProposalStatusAPI(hshValues);
				}
      // }
			 strQuery = SQLParser.getSqlQuery("sel_updateproposalflag^"+AppId);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					hshValues.put("FlagDisSTATUS",Helper.correctNull((String) rs.getString("NPDT_APPLICATIONSTATUS")));
				}
				if(rs != null)
				{
					rs.close();
				}	
				hshValues.put("hidApplicantId",AppId);
       }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> PSB59getHoldRejStatus Method : "+m);
       }
	return hshValues;
	
}

@SuppressWarnings("unchecked")
public HashMap updatePSB59HoldRejStatus(HashMap hshValues)  {
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = null;
	ArrayList arrValues = null;
	boolean insFlag=false;
	
	String strQuery ="",strAuth="",strAuthFlag="",strProposalFlag="",strApp="",strAppUpd="Y";
	try
	{			
		hshQuery = new HashMap();
		arrValues = new ArrayList();
		
		hshQuery.put("strQueryId", "ins_HoldRejStatusHist");
		
		arrValues.add(correctNull((String) hshValues.get("hidApplicantId")));
		arrValues.add(correctNull((String) hshValues.get("sel_nsdlStatus")));
		arrValues.add(correctNull((String) hshValues.get("hidOldStatus")));
		arrValues.add(correctNull((String) hshValues.get("txt_remarks")));
		arrValues.add(correctNull((String) hshValues.get("strUserId")));
		arrValues.add(correctNull((String) hshValues.get("hidAppStatus")));
		if(correctNull((String) hshValues.get("sel_nsdlStatus")).equalsIgnoreCase("104") || correctNull((String) hshValues.get("hidHoldAuth")).equalsIgnoreCase("Y"))
		{
			strAuth= correctNull((String) hshValues.get("strUserId"));
			strAuthFlag="Y";
		}
		else
		{
			strAuth="";
			strAuthFlag="";
		}
		arrValues.add(strAuth);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);
		hshQueryValues.put("size","1");
		
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		
		insFlag = true;
		
		if(insFlag)
		{
		
		hshQuery = new HashMap();
		arrValues = new ArrayList();
		
		hshQuery.put("strQueryId", "upd_HoldRejStatus");
		if(correctNull((String) hshValues.get("sel_nsdlStatus")).equalsIgnoreCase("102"))
		{
			strApp= "04";
		}
		else
		{
			strApp= "05";
		}
		arrValues.add(strApp);
		//arrValues.add(correctNull((String) hshValues.get("hidAppStatus")));
		arrValues.add(correctNull((String) hshValues.get("sel_nsdlStatus")));
		arrValues.add(correctNull((String) hshValues.get("txt_remarks")));
		if(correctNull((String) hshValues.get("sel_nsdlStatus")).equalsIgnoreCase("102") || (correctNull((String) hshValues.get("sel_nsdlStatus")).equalsIgnoreCase("105") && !strAuthFlag.equalsIgnoreCase("Y")))
		{
			strAuthFlag= "N";
		}
		arrValues.add(strAuthFlag);
		arrValues.add(strAppUpd);
		//arrValues.add(correctNull((String) hshValues.get("hidOnlinestatus")));
		arrValues.add(strProposalFlag);
		arrValues.add(correctNull((String) hshValues.get("hidApplicantId")));
		
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);
		hshQueryValues.put("size","1");
		
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
  return hshValues;
}


//get cbs id record in np
@SuppressWarnings("unchecked")
public HashMap PSB59getcbsidrecord(HashMap hshValues) 
{
	String strQuery = "";
	ResultSet rs = null;
	int intUpdatesize=0;
	HashMap hshQuery=null, hshQueryValues = new HashMap();
	ArrayList arrRow=new ArrayList();
	ArrayList arrCol=new ArrayList();
	ArrayList arrValues=new ArrayList();
	String strRefid="",strCBSidCompl="",strCus_applicanttype="",strName="";
	try
	{   
		strRefid=correctNull((String)hshValues.get("RefId"));
		if(strRefid.equals("")){
			strRefid=correctNull((String)hshValues.get("strRefId"));
		}
		if(strRefid.equals("")){
			strRefid=correctNull((String)hshValues.get("hidRefId"));
		}
		strQuery=SQLParser.getSqlQuery("selNPcustreceivelist^"+strRefid);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strCBSidCompl="N";
		}
		else
		{
			strCBSidCompl="Y";
			
			intUpdatesize++;
			hshQuery= new HashMap();
			arrValues = new ArrayList();
				hshQuery.put("strQueryId", "delNPCBSList"); 
				arrValues = new ArrayList();
				arrValues.add(strRefid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),	hshQuery);
		}	
		if(strCBSidCompl.equals("Y")){
		strQuery = SQLParser.getSqlQuery("selnpcustdata^"+strRefid+"^"+strRefid);
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			arrCol = new ArrayList();
			arrCol.add(Helper.correctNull(rs.getString("First_Name")));//0
			arrCol.add(Helper.correctNull(rs.getString("NP_App_Type")));//1
			arrCol.add(Helper.correctNull(rs.getString("Ref_no")));//2
			arrCol.add(Helper.correctNull(rs.getString("sno")));//3
			arrCol.add("");//4
			arrCol.add("");//5
			
			arrRow.add(arrCol);
			
				
			intUpdatesize++;
			arrValues = new ArrayList();
			hshQuery= new HashMap();
			arrValues.add((Helper.correctNull(rs.getString("Ref_no"))));
			arrValues.add(Helper.correctNull(rs.getString("NP_App_Type")));
			arrValues.add(Helper.correctNull(rs.getString("First_Name")));
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId","insNPCBSList");
			hshQueryValues.put(String.valueOf(intUpdatesize), hshQuery);
		}if(intUpdatesize>0)
		{
		hshQueryValues.put("size",String.valueOf(intUpdatesize));
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		}if(strCBSidCompl.equals("N")){
			strQuery=SQLParser.getSqlQuery("selNPcustreceivelist^"+strRefid);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("CUST_NAME")));//0
				arrCol.add(Helper.correctNull(rs.getString("APPLICANT_TYPE")));//2
				arrCol.add(Helper.correctNull(rs.getString("NP_APP_REFID")));//2
				arrCol.add(Helper.correctNull(rs.getString("sno")));//2
				arrCol.add(Helper.correctNull(rs.getString("LAPS_CBSID")));//2
				arrCol.add(Helper.correctNull(rs.getString("LAPS_APPID")));//2
				
				arrRow.add(arrCol);
			}
		}
		hshValues.put("arrRow", arrRow);
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	finally
	{
		try {
			if (rs != null) {
				rs.close();
			}

		} catch (Exception e1) {
			throw new EJBException("Error closing connection..." + e1);
		}
	}
	return hshValues;
}
public HashMap updateMapCBSidforNationalPortal(HashMap hshValues) 
{
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = null;	 
	ArrayList arrValues =null;
	
	ResultSet rs=null;
	String strUserId = null,strRefId="",strLapsID="" , strcuscbsid="",strStatusFlag="" , strCusNo="" ,strCus_applicanttype="";
	String strOrgCode="" , strOrgShortCode="" , strCBSidCompl="" , strQuery="" ,strName="";
	int intUpdatesize=0;
	
	try
	{

		strRefId 			=	Helper.correctNull((String)hshValues.get("refid"));
		strLapsID			=	Helper.correctNull((String)hshValues.get("hidAppid")); 
		strcuscbsid			=	Helper.correctNull((String)hshValues.get("hidcbsID"));
		strStatusFlag		=	Helper.correctNull((String)hshValues.get("cus_statusflag"));
		strCusNo			=	Helper.correctNull((String)hshValues.get("cus_sno"));			
		strCus_applicanttype=	Helper.correctNull((String)hshValues.get("cus_applicanttype"));

		
		intUpdatesize++;
		hshQuery = new HashMap();
		arrValues = new ArrayList();
		arrValues.add("Y");
		arrValues.add(strcuscbsid);
		arrValues.add(strLapsID);
		arrValues.add(strRefId);
		arrValues.add(strCus_applicanttype);
		hshQuery.put("arrValues", arrValues);
		hshQuery.put("strQueryId","updNPCBSComplete");
		hshQueryValues.put(String.valueOf(intUpdatesize), hshQuery);
		
		
		hshValues.put("strRefId",strRefId);
		 
		if(intUpdatesize>0)
		{
			hshQueryValues.put("size",String.valueOf(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		
		strQuery=SQLParser.getSqlQuery("selNPcustreceive^"+strRefId);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strCBSidCompl="N";
		}
		else
		{
			strCBSidCompl="Y";
		}			
		
		
		
		PSB59getcbsidrecord(hshValues);
		
	}		
	catch (Exception ce)
	{
		
		throw new EJBException("EXCEPTION IN NsdlApplicationBean -> updateMapCBSidforNSDL method"+ce.toString());
	}
	finally
	{
		try {
			if (rs != null) {
				rs.close();
			}
			
		} catch (Exception e1) {
			throw new EJBException("Error closing connection..." + e1);
		}
	}
	return hshValues;
}

@SuppressWarnings("unchecked")
public HashMap updatePSB59SanctionDetails(HashMap hshValues) 
{
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = null;
	ArrayList arrValues = null;

	try
	{			
		hshQuery = new HashMap();
		arrValues = new ArrayList();
		
		hshQuery.put("strQueryId", "del_SancDetails");
		
		arrValues.add(Helper.correctNull((String)hshValues.get("hidReferId")));
		
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);
		hshQueryValues.put("size","1");
		
		//EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		
		hshQuery = new HashMap();
		arrValues = new ArrayList();
		
		hshQuery.put("strQueryId", "ins_SancDetails");
		
		arrValues.add(Helper.correctNull((String)hshValues.get("hidReferId")));
		arrValues.add(Helper.correctNull((String)hshValues.get("txtappnum")));
		arrValues.add(Helper.correctNull((String)hshValues.get("hidSchName")));
		arrValues.add(Helper.correctNull((String)hshValues.get("txtsanamount")));
		arrValues.add(Helper.correctNull((String)hshValues.get("txtroi")));
		arrValues.add(Helper.correctNull((String)hshValues.get("txtprocfees")));
		arrValues.add(Helper.correctNull((String)hshValues.get("txttenure")));
		arrValues.add(Helper.correctNull((String)hshValues.get("txtsandate")));
		arrValues.add(Helper.correctNull((String)hshValues.get("txtemi")));
		arrValues.add(Helper.correctNull((String)hshValues.get("txtremarks")));
		arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
		
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("2",hshQuery);
		hshQueryValues.put("size","2");
		
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	return hshValues;
}
public HashMap invokeUpdateDsibursmentAPI(HashMap hshValues)  {

	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = null;
	ArrayList arrValues = null;
	ResultSet rs = null;
	ResultSet rs1 = null;
	HashMap hshRecord = new HashMap();
	String strQuery = "";
	String strComappid = Helper.correctNull((String) hshValues
			.get("hidBorrowerAppid"));
	// String strAppno="";
	ArrayList arrColOur = new ArrayList();
	ArrayList arrRowOur = new ArrayList();

	ArrayList arrColOther = new ArrayList();
	ArrayList arrRowOther = new ArrayList();
	int lib_bank = 0;
	int lib_other_bank = 0;

	String strUsrid =  Helper.correctNull((String)hshValues.get("strUserId"));
	
	String strAppno = Helper.correctNull((String) hshValues.get("hidAppno"));
	if (strAppno.equalsIgnoreCase("")) {
		strAppno = Helper.correctNull((String) hshValues.get("strappno"));
	}
	if (strAppno.equalsIgnoreCase("")) {
		strAppno = Helper.correctNull((String) hshValues.get("appno"));
	}
	if (strAppno.equalsIgnoreCase("")) {
		strAppno = Helper.correctNull((String) hshValues.get("appno1"));
	}
	String pag_status = Helper.correctNull((String) hshValues.get("pag_Status"));
	String varcbsid = Helper.correctNull((String) hshValues.get("varcbsid"));
	if (pag_status.equalsIgnoreCase("")) {
		pag_status = Helper.correctNull((String) hshValues.get("pag_status"));
	}
	String strapprefid=Helper.correctNull((String) hshValues.get("hidApplicantId")); 
	if (strapprefid.equalsIgnoreCase("")) {
		strapprefid = Helper.correctNull((String) hshValues.get("REFERENCE_ID"));
	}
	if (strapprefid.equalsIgnoreCase("")) {
		strapprefid = Helper.correctNull((String) hshValues.get("hidrefidno"));
	}
	String strHidsegType=Helper.correctNull((String) hshValues.get("hidsegtype")); 
	String strRequest="",id="0",DISBURSEMENTDATE="",TRANSACTIONNO="",DISBURSEDAMOUNT="",TOTALDISBURSEDAMOUNT="",REMARKS="",EMI="",schemeType="",
	STATUS="",ACCOUNTNUMBER="",TENURE="",SCHEMETYPE="",DISP_UPDATEFLAG="",DISPSTATUSFLAG="",APPREFID="",MODETYPE="",disbursementId="2",
	strOutput="",schemeName="",strAPIName="",StrAPIURL="",strAPIname="DISPURSMENT",ReqAPIName="updateDisbursementDetails";
	String respmesg="",respmesg1="",resdata="",strstatus="";
	String SuccessResponse = "";
	Gson gson = new Gson();
	try {
		if (strHidsegType.equalsIgnoreCase("")) {
			strHidsegType = Helper.correctNull((String) hshValues.get("hidsegtypeval"));
		}
		
		if(!strAppno.equalsIgnoreCase(""))
		{
			strQuery=SQLParser.getSqlQuery("findapptype^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strapprefid = correctNull((String)rs.getString("app_nprefid"));
				
			}
		}
		
		strQuery=SQLParser.getSqlQuery("sel_npSchemename1^"+strapprefid);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			schemeName=Helper.correctNull((String) rs.getString("NPDT_NP_SCHEME_NAME")); 
			strHidsegType=Helper.correctNull((String) rs.getString("NPDT_NP_SCHEME_TYPE"));  
		}
		if(rs != null)
		{
			rs.close();
		}
	   
		 strQuery=SQLParser.getSqlQuery("sel_npupdate_url^"+ReqAPIName);
		rs1=DBUtils.executeQuery(strQuery);
		if(rs1.next())
		{
			StrAPIURL=Helper.correctNull((String) rs1.getString("URLS"));
		}
		if(rs1 != null)
		{
			rs1.close();
		}
		if(strHidsegType.equalsIgnoreCase(""))
		{
			strHidsegType="EDU";	
		}
		
		
		strQuery = SQLParser.getSqlQuery("sel_npdispreq^" + strapprefid);
		rs = DBUtils.executeQuery(strQuery);
		if (rs.next()) {
			
			
			DISBURSEMENTDATE=Helper.correctNull((String) rs.getString("DISBURSEMENTDATE"));// 1
			TRANSACTIONNO=Helper.correctNull((String) rs.getString("TRANSACTIONNO"));// 2
			DISBURSEDAMOUNT=Helper.correctNull((String) rs.getString("DISBURSEDAMOUNT"));// 3
			TOTALDISBURSEDAMOUNT=Helper.correctNull((String) rs.getString("TOTALDISBURSEDAMOUNT"));// 4
			REMARKS=Helper.correctNull((String) rs.getString("REMARKS"));// 5
			EMI=Helper.correctNull((String) rs.getString("EMI"));// 6
			STATUS=Helper.correctNull((String) rs.getString("STATUS"));// 7
			ACCOUNTNUMBER=Helper.correctNull((String) rs.getString("ACCOUNTNUMBER"));// 8
			TENURE=Helper.correctNull((String) rs.getString("TENURE"));// 9
			DISP_UPDATEFLAG=Helper.correctNull((String) rs.getString("DISP_UPDATEFLAG"));// 12
			DISPSTATUSFLAG=Helper.correctNull((String) rs.getString("DISPSTATUSFLAG"));// 13
			MODETYPE=Helper.correctNull((String) rs.getString("MODETYPE"));//15
			

		}if (rs1 != null) {
			rs1.close();
		}
		strRequest="{ " +
				//"\"id\": \""+id+"\", " +
				"\"applicationReferenceId\": \""+strapprefid+"\", " +
				"\"disbursementDate\": \""+DISBURSEMENTDATE+"\", " +
		"\"transactionNo\": \""+TRANSACTIONNO+"\"," +
				" \"disbursedAmount\": \""+DISBURSEDAMOUNT+"\", " +
						//"\"totalDisbursedAmount\": \""+TOTALDISBURSEDAMOUNT+"\", " +
		 "\"mode\": \""+MODETYPE+"\", " +
		 		"\"remarks\": \""+REMARKS+"\", " +
		 				"\"emi\": \""+EMI+"\", " +
		 						"\"accountNumber\": \""+ACCOUNTNUMBER+"\", " +
		 								"\"status\": \""+STATUS+"\"," +
		 		" \"tenure\": \""+TENURE+"\"," +
		 				" \"disbursementId\": \""+disbursementId+"\", " +
		 						"\"schemeName\": \""+schemeName+"\"," +
		 								" \"schemeType\": \""+strHidsegType+"\", " +
		 				"\"apiName\": \""+ReqAPIName+"\"},";
		
		Logger.log("Update Sanction API Request =========>"+strRequest);
		Logger.log("Update Sanction API URL =========>"+StrAPIURL);
		strOutput =HttpConnections.PostConnection(StrAPIURL, strRequest);
		
		/*File fXmlFile = new
		  File("E:/interface_Test_manasa/API Resp/Nationalportalresp.txt"); Reader
		  fileReader = new FileReader(fXmlFile); BufferedReader bufReader =
		 new BufferedReader(fileReader);
		 
		  StringBuilder sb = new StringBuilder(); String line =
		  bufReader.readLine();
		  
		 while( line != null){ sb.append(line).append("\n"); line =
		  bufReader.readLine(); } String xml2String = sb.toString();
		
		 
		 strOutput = xml2String;
		 
		  System.out.print(xml2String);
		*/
		Logger.log("National Portal get Disbursment Response=========>"+strOutput);
		NationalPortalResponse response = new NationalPortalResponse();
		response=gson.fromJson(strOutput, NationalPortalResponse.class);
		if(! strOutput.equalsIgnoreCase("")|| strOutput.equals(null)){
			//respmesg=response.getBody();
			//Logger.log("National Portal get Sanction Response Message=========>"+respmesg);
			
			resdata=response.getData();
			Logger.log("National Portal get Sanction Response Data=========>"+resdata);
			
			respmesg1=response.getNpMessage();
			Logger.log("National Portal get Sanction Response Message=========>"+respmesg1);
			
			strstatus=response.getNpStatus();
			Logger.log("National Portal get Sanction Req staus=========>"+strstatus);
			
			respmesg=respmesg1.concat(resdata);
		}
	
		if(strstatus.equalsIgnoreCase("200")){
		
		SuccessResponse = "Y";
		hshQuery = new HashMap();
		arrValues = new ArrayList();
		hshQuery.put("strQueryId", "upd_disbAPIhit");
		arrValues.add("Y");
		arrValues.add(strapprefid);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);
		hshQueryValues.put("size","1");
		hshValues.put("respmesg",respmesg);
		
		hshQuery = new HashMap();
		arrValues = new ArrayList();
		
		hshQuery.put("strQueryId", "updt_Applicationsts");
		arrValues.add("03");
		arrValues.add(strapprefid);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("2",hshQuery);
		hshQueryValues.put("size","2");
		hshValues.put("respmesg",respmesg);
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}else{
			SuccessResponse = "N";
			
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "upd_disbAPIhit");
			arrValues.add("N");
			arrValues.add(strapprefid);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			hshValues.put("respmesg",respmesg);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		hshQuery = new HashMap();
		arrValues = new ArrayList();
		hshQuery.put("strQueryId", "ins_disbAPIhitHistory");
		
		arrValues.add(DISBURSEMENTDATE);
		arrValues.add(TRANSACTIONNO);
		arrValues.add(DISBURSEDAMOUNT);
		arrValues.add(TOTALDISBURSEDAMOUNT);
		arrValues.add(REMARKS);
		arrValues.add(EMI);
		arrValues.add(STATUS);
		arrValues.add(ACCOUNTNUMBER);
		arrValues.add(TENURE);
		arrValues.add("");
		arrValues.add(SCHEMETYPE);
		arrValues.add(strapprefid);
		arrValues.add(MODETYPE);
		arrValues.add(SuccessResponse);
		arrValues.add(strUsrid);
		
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);
		hshQueryValues.put("size","1");
		
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		
	}
		catch (ConnectException e) {
	    	   respmesg="Cannot Connect to Server!!!";
	   	}
	   	catch(Exception e)
	   	{
	   		Logger.log("*********** Inside the Catch Block ***********"+e.getMessage());
	   		respmesg="Exception From LAPS"+e.getMessage();
	   	}
		 finally {
		try {
			hshValues.put("hidAction", "");
			
			getNP_Dsibursment(hshValues);
			if(respmesg.equals("")){
				 respmesg="Failed"; 
			 }
			try {
				if (rs != null) {
					rs.close();
				}
				
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}
		} catch (Exception e1) {
			throw new EJBException("Error closing connection");
		}
	}
		 
		 hshValues.put("respmesg",respmesg);
	return hshValues;
}
@SuppressWarnings("unchecked")
public HashMap invokeUpdateSanctionAPI(HashMap hshValues) 
{
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = null;
	ArrayList arrValues = null;
	String strQuery ="",strOutput="";
	ResultSet rs= null,rs1= null,rs3= null;
	String strRequest="",APPREFID="",sanctionAmount="",roi="",pf="",tenure="",sanctionDate="",REMARKS="",schemeName="",
	schemeType="",emi="",id="0",strAPIName="";
	String strRefId =  Helper.correctNull((String)hshValues.get("hidReferId"));
	String strAPIname="SANCTION",StrAPIURL="",ReqSchemeName="updateSanctionDetail";
	String respmesg="",strstatus="";
	String strUserId= Helper.correctNull((String)hshValues.get("strUserId"));
	String strModuleType="";
	Gson gson = new Gson();
	String resdata="",respmesg1="";
	String strMonth="",strTenureType="";
	String strRepay="";
       try {
    	   schemeType =  Helper.correctNull((String)hshValues.get("SegType"));
    	   String Appno= Helper.correctNull((String)hshValues.get("hidapno"));
    	   strModuleType=Helper.correctNull((String)hshValues.get("strModuleType"));
    	   if(! Appno.equalsIgnoreCase("")){
    		   
    		   strQuery=SQLParser.getSqlQuery("sel_getedudtls^"+Appno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strRefId=Helper.correctNull((String) rs.getString("NPDT_APPLICATIONREFERENCEID")); 
					schemeType=Helper.correctNull((String) rs.getString("NPDT_NP_SCHEME_TYPE"));
				}
				if(rs != null)
				{
					rs.close();
				}
				if(strModuleType.equalsIgnoreCase("RET")||strModuleType.equalsIgnoreCase("AGR"))
				{

					strQuery=SQLParser.getSqlQuery("sel_NPEduloandtls^"+Appno);
				}
				else
				{

					strQuery=SQLParser.getSqlQuery("sel_NPOtherloandtls^"+Appno);
				}
				rs3=DBUtils.executeQuery(strQuery);
				if(rs3.next())
				{
					sanctionAmount= Helper.correctNull((String) rs3.getString("LOAN_COSTLOANPRD"));
					roi=Helper.correctNull((String) rs3.getString("LOAN_MODINTRATE"));
					pf= Helper.correctNull((String) rs3.getString("LOAN_PROFEE"));
					tenure= Helper.correctNull((String) rs3.getString("LOAN_REQTERMS"));
					sanctionDate= Helper.correctNull((String) rs3.getString("LOAN_FILEDON"));
					emi= Helper.correctNull((String) rs3.getString("LOAN_EMI"));
					strMonth=Helper.correctNull((String) rs3.getString("Month"));
					strTenureType=Helper.correctNull((String) rs3.getString("tenureType"));
					//REMARKS= Helper.correctNull((String) rs3.getString("LOAN_REMARKS"));
					strRepay=Helper.correctNull((String) rs3.getString("PA_REPAYMENT_PERIOD"));
				}
				if(rs != null)
				{
					rs.close();
				}
				Logger.log("\n sanctionAmount =========>"+sanctionAmount);
				Logger.log("\n roi =========>"+roi);
				Logger.log("\n pf =========>"+pf);
				Logger.log("\n tenure =========>"+tenure);
				Logger.log("\n sanctionDate =========>"+sanctionDate);
				Logger.log("\n emi =========>"+emi);
				Logger.log("\n strMonth =========>"+strMonth);
				
				
    	   }else{
    		   
    		   strQuery=SQLParser.getSqlQuery("sel_SancDetails_REQ^"+strRefId);
				rs3=DBUtils.executeQuery(strQuery);
				if(rs3.next())
				{
					APPREFID= Helper.correctNull((String) rs3.getString("APPREFID"));
				sanctionAmount= Helper.correctNull((String) rs3.getString("SANCTIONAMT"));
				roi=Helper.correctNull((String) rs3.getString("ROI"));
				pf= Helper.correctNull((String) rs3.getString("PROCESSFEE"));
				tenure= Helper.correctNull((String) rs3.getString("TENURE"));
				sanctionDate= Helper.correctNull((String) rs3.getString("SANCTIONDATE"));
				emi= Helper.correctNull((String) rs3.getString("EMI"));
				REMARKS= Helper.correctNull((String) rs3.getString("REMARKS"));
				//strMonth=Helper.correctNull((String) rs3.getString("Month"));
				//strTenureType=Helper.correctNull((String) rs3.getString("tenureType"));
				strRepay=Helper.correctNull((String) rs3.getString("TENURE"));
				}
				if(rs3 != null)
				{
					rs3.close();
				}
    	   }
    	   //PA_REPAYMENT_PERIOD=""
    	   int repay=0,repay1=0;
			if(!strRepay.equalsIgnoreCase(""))
			{
				repay = Integer.parseInt(strRepay)/12;
				repay1 = Integer.parseInt(strRepay) - (repay * 12);
				
				if(repay1 != 0)
				{
					strTenureType = "2";
					tenure = String.valueOf(repay);
					strMonth = String.valueOf(repay1);
				}else{
					strTenureType = "1";
					tenure = String.valueOf(repay);
					strMonth ="";
				}
			}
			Logger.log("\n strMonth =========>"+strMonth);
			Logger.log("\n strTenureType =========>"+strTenureType);
			
			Logger.log("\n System.out.println Logs");
			System.out.print("\n sanctionAmount =========>"+sanctionAmount);
			System.out.print("\n roi =========>"+roi);
			System.out.print("\n pf =========>"+pf);
			System.out.print("\n tenure =========>"+tenure);
			System.out.print("\n sanctionDate =========>"+sanctionDate);
			System.out.print("\n emi =========>"+emi);
			System.out.print("\n strMonth =========>"+strMonth);
			System.out.print("\n strMonth =========>"+strMonth);
			System.out.print("\n strTenureType =========>"+strTenureType);
    	   strQuery=SQLParser.getSqlQuery("sel_npSchemename^"+strRefId+"^"+schemeType);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				schemeName=Helper.correctNull((String) rs.getString("NPDT_NP_SCHEME_NAME")); 
			}
			if(rs != null)
			{
				rs.close();
			}
    	   
    	   strQuery=SQLParser.getSqlQuery("sel_npupdate_url^"+ReqSchemeName);
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				StrAPIURL=Helper.correctNull((String) rs1.getString("URLS"));
			}
			if(rs1 != null)
			{
				rs1.close();
			}
			
			
			
			
			strRequest="{ \"id\": \""+id+"\", \"applicationReferenceId\": \""+strRefId+"\", \"sanctionAmount\": \""+sanctionAmount+"\", " +
			"\"roi\": \""+roi+"\", \"pf\": \""+pf+"\", \"tenure\": \""+tenure+"\", " +
			 "\"sanctionDate\": \""+sanctionDate+"\", \"remarks\": \""+REMARKS+"\", \"schemeName\": \""+schemeName+"\" ,\"schemeType\": \""+schemeType+"\", " +
			 "\"apiName\": \""+ReqSchemeName+"\", \"emi\": \""+emi+"\", \"month\": \""+strMonth+"\" , \"tenureType\": \""+strTenureType+"\"}";
			
			/*strRequest="{\"requestType\": \"0\", \"msgid\": \""+id+"\", " +
			"\"data\": {\"applicationReferenceId\": \""+strRefId+"\", \"sanctionAmount\": \""+sanctionAmount+"\", " +
			"\"roi\": \""+roi+"\", \"pf\": \""+pf+"\", \"tenure\": \""+tenure+"\", " +
			 "\"sanctionDate\": \""+sanctionDate+"\", \"remarks\": \""+REMARKS+"\", " +
			" \"emi\": \""+emi+"\", \"month\": \""+strMonth+"\", \"tenureType\": \""+strTenureType+"\"}}";*/
			
			Logger.log("Update Sanction API Request =========>"+strRequest);
			Logger.log("Update Sanction API URL =========>"+StrAPIURL);
			
			System.out.print("<=========checking request=======>"+strRequest);
			System.out.print("<=========checking URL=======>"+StrAPIURL);
			strOutput =HttpConnections.PostConnection(StrAPIURL, strRequest);
			
			Logger.log("National Portal get Sanction Response=========>"+strOutput);
			NationalPortalResponse response = new NationalPortalResponse();
			response=gson.fromJson(strOutput, NationalPortalResponse.class);
			if(! strOutput.equalsIgnoreCase("")|| strOutput.equals(null)){
				
				resdata=response.getData();
				Logger.log("National Portal get Sanction Response Data=========>"+resdata);
				
				respmesg1=response.getNpMessage();
				Logger.log("National Portal get Sanction Response Message=========>"+respmesg1);
				
				strstatus=response.getNpStatus();
				Logger.log("National Portal get Sanction Req staus=========>"+strstatus);
				
				respmesg=respmesg1.concat(resdata);
			}
		
			
			if(strstatus.equalsIgnoreCase("200")){
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "upd_sancAPIhit");
				arrValues.add("Y");
				arrValues.add(strUserId);
				arrValues.add(strRefId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				hshValues.put("respmesg",respmesg);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "updt_Applicationsts");
				arrValues.add("02");
				arrValues.add(strRefId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				hshQueryValues.put("size","2");
				hshValues.put("respmesg",respmesg);
			}else{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "upd_sancAPIhit");
				arrValues.add("N");
				arrValues.add(strUserId);
				arrValues.add(strRefId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				
				hshValues.put("respmesg",respmesg);
			}
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			 if( Appno.equalsIgnoreCase("")){ 
			getPSB59SanctionDetails(hshValues); 
			 }
       }
       catch (ConnectException e) {
    	   respmesg="Cannot Connect to Server!!!";
   	}
   	catch(Exception e)
   	{
   		Logger.log("*********** Inside the Catch Block of Update Sanction ***********"+e.getMessage());
   		respmesg="Exception From LAPS"+e.getMessage();
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
	hshValues.put("respmesg", respmesg);
	return hshValues;
	
}
@SuppressWarnings("unchecked")
public HashMap getPSB59SanctionDetails(HashMap hshValues) 
{
	String strQuery ="",strBranchHead="",strBranchHeadflag="";
	ResultSet rs= null;
	String hidschemeName =  Helper.correctNull((String)hshValues.get("hidschemeName"));
	if(hidschemeName.equalsIgnoreCase(""))
	{
		hidschemeName =  Helper.correctNull((String)hshValues.get("hidschemeName"));
	}String strRefId =  Helper.correctNull((String)hshValues.get("hidReferId"));
	String strUsrid =  Helper.correctNull((String)hshValues.get("strUserId"));
	if(strRefId.equalsIgnoreCase(""))
	{
		strRefId =  Helper.correctNull((String)hshValues.get("hidApplicantId"));
	}
	if(strRefId.equalsIgnoreCase(""))
	{
		strRefId =  Helper.correctNull((String)hshValues.get("REFERENCE_ID"));
	}
	if(strRefId.equalsIgnoreCase(""))
	{
		strRefId =  Helper.correctNull((String)hshValues.get("strapprefid"));
	}
	  try {
    	    strQuery = SQLParser.getSqlQuery("selDisbursementDone^"+strRefId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				String strExp ="Application has already been Disbursed";
				hshValues.put("showDisbMsg",strExp);
			}
			if(rs != null)
			{
				rs.close();
			}
			
    	    strQuery=SQLParser.getSqlQuery("sel_branchHeadrestrict1^"+strUsrid);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strBranchHead=Helper.correctNull((String)rs.getString("ORG_HEAD"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			if(strUsrid.equals(strBranchHead))
			{
				strBranchHeadflag="Y";
			}else{
				strBranchHeadflag="N";
			}
			hshValues.put("strBranchHead",strBranchHeadflag);
			
			strQuery=SQLParser.getSqlQuery("sel_SancDetails^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("APPREFID", Helper.correctNull((String) rs.getString("APPREFID")));
			hshValues.put("APPNO", Helper.correctNull((String) rs.getString("APPNO")));
			hshValues.put("SCHEMETYPE", Helper.correctNull((String) rs.getString("SCHEMETYPE")));
			hshValues.put("SANCTIONAMT", Helper.correctNull((String) rs.getString("SANCTIONAMT")));
			hshValues.put("ROI", Helper.correctNull((String) rs.getString("ROI")));
			hshValues.put("PROCESSFEE", Helper.correctNull((String) rs.getString("PROCESSFEE")));
			hshValues.put("TENURE", Helper.correctNull((String) rs.getString("TENURE")));
			hshValues.put("SANCTIONDATE", Helper.correctNull((String) rs.getString("SANCTIONDATE")));
			hshValues.put("EMI", Helper.correctNull((String) rs.getString("EMI")));
			hshValues.put("REMARKS", Helper.correctNull((String) rs.getString("REMARKS")));
			hshValues.put("SANCFLAG", Helper.correctNull((String) rs.getString("SANCFLAG")));
			}
			if(rs != null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_NPsancAuthbutton^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("ButtondisableFalg",Helper.correctNull((String)rs.getString("SANCFLAG")));
			}
			if(rs!=null)
			{
				rs.close();
			}
			hshValues.put("strRefId", strRefId);
			hshValues.put("hidschemeName",hidschemeName );
			
       }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> getPSB59SanctionDetails Method : "+m);
       }
	return hshValues;
	
}

@SuppressWarnings("unchecked")
public HashMap getPSB59AllApplicationDetails(HashMap hshValues) 
{
	String SchemeId = Helper.correctNull((String)hshValues.get("hidpopSchemeId"));
       try {
				hshValues.put("POP_SCHEME_ID",SchemeId);	    	   
           }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> getPSB59AllApplicationDetails Method"+m);
       }
	return hshValues;
	
}

//shyam Added date on 03092021
@SuppressWarnings("unchecked")
public HashMap getPropertyDetails(HashMap hshValues) 
{
	String strQuery = "";
	ResultSet rs = null;
	String AppId = Helper.correctNull((String)hshValues.get("hidApplicantId"));
       try {
    	   strQuery = SQLParser.getSqlQuery("getPropertyDetails^"+AppId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("NPPRD_ID", Helper.correctNull((String) rs.getString("NPPRD_ID")));
				hshValues.put("NPPRD_ADD_SEQ_NO", Helper.correctNull((String) rs.getString("NPPRD_ADD_SEQ_NO")));
				hshValues.put("NPPRD_SEL_ADD_SEQ_NO", Helper.correctNull((String) rs.getString("NPPRD_SEL_ADD_SEQ_NO")));
				hshValues.put("NPPRD_APPLICATIONREFERENCEID", Helper.correctNull((String) rs.getString("NPPRD_APPLICATIONREFERENCEID")));
				hshValues.put("NPPRD_PURPOSEOFLOANID", Helper.correctNull((String) rs.getString("NPPRD_PURPOSEOFLOANID")));
				hshValues.put("NPPRD_PURPOSEOFLOAN", Helper.correctNull((String) rs.getString("NPPRD_PURPOSEOFLOAN")));
				hshValues.put("NPPRD_SELLERNAME", Helper.correctNull((String) rs.getString("NPPRD_SELLERNAME")));
				hshValues.put("NPPRD_TYPEOFPROPERTYID", Helper.correctNull((String) rs.getString("NPPRD_TYPEOFPROPERTYID")));
				hshValues.put("NPPRD_TYPEOFPROPERTY", Helper.correctNull((String) rs.getString("NPPRD_TYPEOFPROPERTY")));
				hshValues.put("NPPRD_TYPEOFAREAID", Helper.correctNull((String) rs.getString("NPPRD_TYPEOFAREAID")));
				hshValues.put("NPPRD_TYPEOFAREA", Helper.correctNull((String) rs.getString("NPPRD_TYPEOFAREA")));
				hshValues.put("NPPRD_AREAOFPROPERTY", Helper.correctNull((String) rs.getString("NPPRD_AREAOFPROPERTY")));
				hshValues.put("NPPRD_AGEOFPROPERTY", Helper.correctNull((String) rs.getString("NPPRD_AGEOFPROPERTY")));
				hshValues.put("NPPRD_COSTOFPROPERTY", Helper.correctNull((String) rs.getString("NPPRD_COSTOFPROPERTY")));
				hshValues.put("NPPRD_REGISTRATIONFEE", Helper.correctNull((String) rs.getString("NPPRD_REGISTRATIONFEE")));
				hshValues.put("NPPRD_STAMPDUTY", Helper.correctNull((String) rs.getString("NPPRD_STAMPDUTY")));
				hshValues.put("NPPRD_LOANAMOUNTREQUIRED", Helper.correctNull((String) rs.getString("NPPRD_LOANAMOUNTREQUIRED")));
				hshValues.put("NPPRD_APPLICANTCONTRIBUTION", Helper.correctNull((String) rs.getString("NPPRD_APPLICANTCONTRIBUTION")));
				hshValues.put("NPPRD_OTHERCOST", Helper.correctNull((String) rs.getString("NPPRD_OTHERCOST")));
				hshValues.put("NPPRD_REPAYMENTMODEID", Helper.correctNull((String) rs.getString("NPPRD_REPAYMENTMODEID")));
				hshValues.put("NPPRD_REPAYMENTMODE", Helper.correctNull((String) rs.getString("NPPRD_REPAYMENTMODE")));
				hshValues.put("NPPRD_TENURE", Helper.correctNull((String) rs.getString("NPPRD_TENURE")));
			}
			if(rs != null)
			{
				rs.close();
			}
			getPSB59AddressDetails(hshValues);
       }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> getPropertyDetails Method"+m);
       }
	return hshValues;
	
}


@SuppressWarnings("unchecked")
public HashMap getBankDetails(HashMap hshValues) 
{
	String strQuery = "";
	ResultSet rs = null;
	String AppId = Helper.correctNull((String)hshValues.get("hidApplicantId"));
       try {
    	    strQuery = SQLParser.getSqlQuery("getBankDetails^"+AppId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("BDL_ROW_ID", Helper.correctNull((String) rs.getString("BDL_ROW_ID")));
				hshValues.put("BDL_SEQUENCENUMBER", Helper.correctNull((String) rs.getString("BDL_SEQUENCENUMBER")));
				hshValues.put("BDL_APPCOAPPREFID", Helper.correctNull((String) rs.getString("BDL_APPCOAPPREFID")));
				hshValues.put("BDL_APPLICATIONREFERENCEID", Helper.correctNull((String) rs.getString("BDL_APPLICATIONREFERENCEID")));
				hshValues.put("BDL_HAVEBANKACCOUNT", Helper.correctNull((String) rs.getString("BDL_HAVEBANKACCOUNT")));
				hshValues.put("BDL_BANKDETAILSTYPE", Helper.correctNull((String) rs.getString("BDL_BANKDETAILSTYPE")));
				hshValues.put("BDL_ACCOUNTHOLDERNAME", Helper.correctNull((String) rs.getString("BDL_ACCOUNTHOLDERNAME")));
				hshValues.put("BDL_ACCOUNTSINCE", Helper.correctNull((String) rs.getString("BDL_ACCOUNTSINCE")));
				hshValues.put("BDL_BANKACCOUNTNUMBER", Helper.correctNull((String) rs.getString("BDL_BANKACCOUNTNUMBER")));
				hshValues.put("BDL_CONFIRMBANKACCOUNTNUMBER", Helper.correctNull((String) rs.getString("BDL_CONFIRMBANKACCOUNTNUMBER")));
				hshValues.put("BDL_IFSCCODE", Helper.correctNull((String) rs.getString("BDL_IFSCCODE")));
				hshValues.put("BDL_TYPE", Helper.correctNull((String) rs.getString("BDL_TYPE")));
				hshValues.put("BDL_COAPPLICANTID", Helper.correctNull((String) rs.getString("BDL_COAPPLICANTID")));
				hshValues.put("BDL_COAPPLICANTID_AGRLOAN", Helper.correctNull((String) rs.getString("BDL_COAPPLICANTID_AGRLOAN")));
			}
			if(rs != null)
			{
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("getBankStatementDetails^"+AppId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("BSL_ROW_ID", Helper.correctNull((String) rs.getString("BSL_ROW_ID")));
				hshValues.put("BSL_APPCOAPPREFID", Helper.correctNull((String) rs.getString("BSL_APPCOAPPREFID")));
				hshValues.put("BSL_APPLICATIONREFERENCEID", Helper.correctNull((String) rs.getString("BSL_APPLICATIONREFERENCEID")));
				hshValues.put("BSL_YEAR", Helper.correctNull((String) rs.getString("BSL_YEAR")));
				hshValues.put("BSL_MONTH", Helper.correctNull((String) rs.getString("BSL_MONTH")));
				hshValues.put("BSL_BANK", Helper.correctNull((String) rs.getString("BSL_BANK")));
				hshValues.put("BSL_TYPE", Helper.correctNull((String) rs.getString("BSL_TYPE")));
				hshValues.put("BSL_COAPPLICANTID", Helper.correctNull((String) rs.getString("BSL_COAPPLICANTID")));
				hshValues.put("BSL_COAPPLICANTID_AGRLOAN", Helper.correctNull((String) rs.getString("BSL_COAPPLICANTID_AGRLOAN")));
			}
			if(rs != null)
			{
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("getBankCustInfoDetails^"+AppId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("CI_ID", Helper.correctNull((String) rs.getString("CI_ID")));
				hshValues.put("CI_BSLSEQUENCENUMBER", Helper.correctNull((String) rs.getString("CI_BSLSEQUENCENUMBER")));
				hshValues.put("CI_APPLICATIONID", Helper.correctNull((String) rs.getString("CI_APPLICATIONID")));
				hshValues.put("CI_NAME", Helper.correctNull((String) rs.getString("CI_NAME")));
				hshValues.put("CI_ADDRESS", Helper.correctNull((String) rs.getString("CI_ADDRESS")));
				hshValues.put("CI_LANDIINE", Helper.correctNull((String) rs.getString("CI_LANDIINE")));
				hshValues.put("CI_MOBILE", Helper.correctNull((String) rs.getString("CI_MOBILE")));
				hshValues.put("CI_EMAIL", Helper.correctNull((String) rs.getString("CI_EMAIL")));
				hshValues.put("CI_PAN", Helper.correctNull((String) rs.getString("CI_PAN")));
				hshValues.put("CI_BANK", Helper.correctNull((String) rs.getString("CI_BANK")));
				hshValues.put("CI_INSTID", Helper.correctNull((String) rs.getString("CI_INSTID")));
				hshValues.put("CI_CHKBOUNCEFRLASTSIXMON", Helper.correctNull((String) rs.getString("CI_CHKBOUNCEFRLASTSIXMON")));
				hshValues.put("CI_CHKBOUNCEFRLASTONEMON", Helper.correctNull((String) rs.getString("CI_CHKBOUNCEFRLASTONEMON")));
				hshValues.put("CI_TOTCREDIT", Helper.correctNull((String) rs.getString("CI_TOTCREDIT")));
				hshValues.put("CI_BANKSTATEMENT", Helper.correctNull((String) rs.getString("CI_BANKSTATEMENT")));
				hshValues.put("CI_PERFIOSTRANID", Helper.correctNull((String) rs.getString("CI_PERFIOSTRANID")));
				hshValues.put("CI_CUSTOMERTRANID", Helper.correctNull((String) rs.getString("CI_CUSTOMERTRANID")));
				hshValues.put("CI_APPREFID", Helper.correctNull((String) rs.getString("CI_APPREFID")));
			}
			if(rs != null)
			{
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("getBankSummaryInfoDetails^"+AppId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("SI_ID", Helper.correctNull((String) rs.getString("SI_ID")));
				hshValues.put("SI_BSLSEQUENCENUMBER", Helper.correctNull((String) rs.getString("SI_BSLSEQUENCENUMBER")));
				hshValues.put("SI_APPLICATIONREFERENCEID", Helper.correctNull((String) rs.getString("SI_APPLICATIONREFERENCEID")));
				hshValues.put("SI_INSTNAME", Helper.correctNull((String) rs.getString("SI_INSTNAME")));
				hshValues.put("SI_ACCNO", Helper.correctNull((String) rs.getString("SI_ACCNO")));
				hshValues.put("SI_ACCTYPE", Helper.correctNull((String) rs.getString("SI_ACCTYPE")));
				hshValues.put("SI_FULLMONTHCOUNT", Helper.correctNull((String) rs.getString("SI_FULLMONTHCOUNT")));
				hshValues.put("SI_BALMAX", Helper.correctNull((String) rs.getString("SI_BALMAX")));
				hshValues.put("SI_BALMIN", Helper.correctNull((String) rs.getString("SI_BALMIN")));
				hshValues.put("SI_CASHDEPOSITE", Helper.correctNull((String) rs.getString("SI_CASHDEPOSITE")));
				hshValues.put("SI_CASHWITHDRAW", Helper.correctNull((String) rs.getString("SI_CASHWITHDRAW")));
				hshValues.put("SI_CHQDEPOSITS", Helper.correctNull((String) rs.getString("SI_CHQDEPOSITS")));
				hshValues.put("SI_CHQISSUE", Helper.correctNull((String) rs.getString("SI_CHQISSUE")));
				hshValues.put("SI_CHEDITS", Helper.correctNull((String) rs.getString("SI_CHEDITS")));
				hshValues.put("SI_DEBITS", Helper.correctNull((String) rs.getString("SI_DEBITS")));
				hshValues.put("SI_INWBOUNCES", Helper.correctNull((String) rs.getString("SI_INWBOUNCES")));
				hshValues.put("SI_OUTWBOUNCES", Helper.correctNull((String) rs.getString("SI_OUTWBOUNCES")));
				hshValues.put("SI_TOTCASHDEP", Helper.correctNull((String) rs.getString("SI_TOTCASHDEP")));
				hshValues.put("SI_TOTCASHWITHDRAW", Helper.correctNull((String) rs.getString("SI_TOTCASHWITHDRAW")));
				hshValues.put("SI_TOTCHQDEP", Helper.correctNull((String) rs.getString("SI_TOTCHQDEP")));
				hshValues.put("SI_TOTCHQISSUE", Helper.correctNull((String) rs.getString("SI_TOTCHQISSUE")));
				hshValues.put("SI_TOTCREDIT", Helper.correctNull((String) rs.getString("SI_TOTCREDIT")));
				hshValues.put("SI_TOTDEBIT", Helper.correctNull((String) rs.getString("SI_TOTDEBIT")));
				hshValues.put("SI_SUMMARYTYPE", Helper.correctNull((String) rs.getString("SI_SUMMARYTYPE")));
			}
			if(rs != null)
			{
				rs.close();
			}
       }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> getBankDetails Method"+m);
       }
	return hshValues;
	
}

//shyam Added date on 03092021
@SuppressWarnings("unchecked")
public HashMap getScoringDetails(HashMap hshValues) 
{
	String strQuery = "";
	ResultSet rs = null;
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	String AppId = Helper.correctNull((String)hshValues.get("hidApplicantId"));
       try {
    	   strQuery = SQLParser.getSqlQuery("getScoringDetails^"+AppId);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arrCol = new ArrayList();
                   
				arrCol.add(Helper.correctNull((String) rs.getString("NP_SCO_DET_ID")));//0
				arrCol.add(Helper.correctNull((String) rs.getString("NP_SCO_DET_PARAMETER")));//1
				arrCol.add(Helper.correctNull((String) rs.getString("NP_SCO_DET_ACTUALRANGE")));//2
				arrCol.add(Helper.correctNull((String) rs.getString("NP_SCO_DET_ACTUALVALBOR")));//3
				arrCol.add(Helper.correctNull((String) rs.getString("NP_SCO_DET_SCOREACTUAL")));
				arrCol.add(Helper.correctNull((String) rs.getString("NP_SCO_DET_SCOREOUTOF")));//4					
				arrCol.add(Helper.correctNull((String) rs.getString("NP_SCO_DET_TYPE")));//6
				arrRow.add(arrCol);
			}
			hshValues.put("arrRow", arrRow);
			
			if(rs != null)
			{
				rs.close();
			}
			
			getScalingDetails(hshValues);
    	   
       }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> getScoringDetails Method"+m);
       }
	return hshValues;
	
}

//shyam Added date on 03092021
@SuppressWarnings("unchecked")
public HashMap getScalingDetails(HashMap hshValues) 
{
	String strQuery = "";
	ResultSet rs = null;
	String AppId = Helper.correctNull((String)hshValues.get("hidApplicantId"));
       try {
    	   strQuery = SQLParser.getSqlQuery("getScalingDetails^"+AppId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("NSM_ROW_ID", Helper.correctNull((String) rs.getString("NSM_ROW_ID")));
				hshValues.put("NSM_APP_REF_ID", Helper.correctNull((String) rs.getString("NSM_APP_REF_ID")));
				hshValues.put("NSM_EFFECTIVE_ROI_CALC", Helper.correctNull((String) rs.getString("NSM_EFFECTIVE_ROI_CALC")));
				hshValues.put("NSM_SCORING_MODEL", Helper.correctNull((String) rs.getString("NSM_SCORING_MODEL")));
				hshValues.put("NSM_PF_BASEON", Helper.correctNull((String) rs.getString("NSM_PF_BASEON")));
				hshValues.put("NSM_TENORE_BASEON", Helper.correctNull((String) rs.getString("NSM_TENORE_BASEON")));
				hshValues.put("NSM_MARGIN_BASEON", Helper.correctNull((String) rs.getString("NSM_MARGIN_BASEON")));
				hshValues.put("NSM_ROI_BASEON", Helper.correctNull((String) rs.getString("NSM_ROI_BASEON")));
				hshValues.put("NSM_INTERPRETATION", Helper.correctNull((String) rs.getString("NSM_INTERPRETATION")));
				hshValues.put("NSM_SCALE", Helper.correctNull((String) rs.getString("NSM_SCALE")));
				hshValues.put("NSM_SCORE_RANGE", Helper.correctNull((String) rs.getString("NSM_SCORE_RANGE")));
				hshValues.put("NSM_MIN_PF", Helper.correctNull((String) rs.getString("NSM_MIN_PF")));
				hshValues.put("NSM_MAX_PF", Helper.correctNull((String) rs.getString("NSM_MAX_PF")));
				hshValues.put("NSM_PROCESSING_FEES", Helper.correctNull((String) rs.getString("NSM_PROCESSING_FEES")));
				hshValues.put("NSM_MARGIN", Helper.correctNull((String) rs.getString("NSM_MARGIN")));
				hshValues.put("NSM_SPREAD", Helper.correctNull((String) rs.getString("NSM_SPREAD")));
				hshValues.put("NSM_EFFECTIVE_ROI", Helper.correctNull((String) rs.getString("NSM_EFFECTIVE_ROI")));
				hshValues.put("NSM_TENORE", Helper.correctNull((String) rs.getString("NSM_TENORE")));
				hshValues.put("NSM_CO_APP_MIN_SCORE", Helper.correctNull((String) rs.getString("NSM_CO_APP_MIN_SCORE")));
				hshValues.put("NSM_APP_MIN_SCORE", Helper.correctNull((String) rs.getString("NSM_APP_MIN_SCORE")));
			}
			if(rs != null)
			{
				rs.close();
			}
    	   
       }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> getScalingDetails Method"+m);
       }
	return hshValues;
}

@SuppressWarnings("unchecked")
public HashMap getBasicEligibilityDetails(HashMap hshValues) 
{
	String strQuery = "";
	ResultSet rs = null;
	String AppId = Helper.correctNull((String)hshValues.get("hidApplicantId"));
	ArrayList arrCol = new ArrayList();
	ArrayList arryRow = new ArrayList();
       try {
			strQuery = SQLParser.getSqlQuery("getBasicEligibilityDetails^"+AppId);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
				    arrCol = new ArrayList();
				    arrCol.add(Helper.correctNull((String) rs.getString("NPBE_ID")));
				    arrCol.add(Helper.correctNull((String) rs.getString("NPBE_APPLICATION_REFERENCE_ID")));
					arrCol.add(Helper.correctNull((String) rs.getString("NPBE_ANSWER")));
					arrCol.add(Helper.correctNull((String) rs.getString("NPBE_QUESTION")));
					arryRow.add(arrCol);
				}
				hshValues.put("arryRow", arryRow);
			if(rs != null)
			{
				rs.close();
			}
			
			getEligibilityDetails(hshValues);
    	   
       }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> getScoringDetails Method"+m);
       }
	return hshValues;
	
}

@SuppressWarnings("unchecked")
public HashMap getEligibilityDetails(HashMap hshValues) 
{
	String strQuery = "";
	ResultSet rs = null;
	String AppId = Helper.correctNull((String)hshValues.get("hidApplicantId"));
       try {
    	   strQuery = SQLParser.getSqlQuery("getEligibilityDetails^"+AppId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("EPD_ROW_ID", Helper.correctNull((String) rs.getString("EPD_ROW_ID")));
				hshValues.put("EPD_SEQUENCE_NO", Helper.correctNull((String) rs.getString("EPD_SEQUENCE_NO")));
				hshValues.put("EPD_APPLICATIONREFID", Helper.correctNull((String) rs.getString("EPD_APPLICATIONREFID")));
				hshValues.put("EPD_FPPRODUCTID", Helper.correctNull((String) rs.getString("EPD_FPPRODUCTID")));
				hshValues.put("EPD_ACCOUNTBALANCE", Helper.correctNull((String) rs.getString("EPD_ACCOUNTBALANCE")));
				hshValues.put("EPD_LOANTRATIO", Helper.correctNull((String) rs.getString("EPD_LOANTRATIO")));
				hshValues.put("EPD_NETELIGIBLEFINANCE", Helper.correctNull((String) rs.getString("EPD_NETELIGIBLEFINANCE")));
				hshValues.put("EPD_REQUIREDLOANAMT", Helper.correctNull((String) rs.getString("EPD_REQUIREDLOANAMT")));
				hshValues.put("EPD_MAXLOANAMT", Helper.correctNull((String) rs.getString("EPD_MAXLOANAMT")));
				hshValues.put("EPD_MAXLOANCAP", Helper.correctNull((String) rs.getString("EPD_MAXLOANCAP")));
				hshValues.put("EPD_EXISTINGLOANAMT", Helper.correctNull((String) rs.getString("EPD_EXISTINGLOANAMT")));
				hshValues.put("EPD_ROI", Helper.correctNull((String) rs.getString("EPD_ROI")));
				hshValues.put("EPD_TENURE", Helper.correctNull((String) rs.getString("EPD_TENURE")));
				hshValues.put("EPD_FINALLOANAMT", Helper.correctNull((String) rs.getString("EPD_FINALLOANAMT")));
				hshValues.put("EPD_EMI", Helper.correctNull((String) rs.getString("EPD_EMI")));
				hshValues.put("EPD_APPLICATIONTYPE", Helper.correctNull((String) rs.getString("EPD_APPLICATIONTYPE")));
				hshValues.put("EPD_MACHINERYCOST", Helper.correctNull((String) rs.getString("EPD_MACHINERYCOST")));
				hshValues.put("EPD_PROMOTERCONTRIBUTION", Helper.correctNull((String) rs.getString("EPD_PROMOTERCONTRIBUTION")));
				hshValues.put("EPD_GROSSMONTHLYINCOME", Helper.correctNull((String) rs.getString("EPD_GROSSMONTHLYINCOME")));
				hshValues.put("EPD_NETMONTLYINCOME", Helper.correctNull((String) rs.getString("EPD_NETMONTLYINCOME")));
				hshValues.put("EPD_MARGIN", Helper.correctNull((String) rs.getString("EPD_MARGIN")));
				hshValues.put("EPD_INCOMEFOREMI", Helper.correctNull((String) rs.getString("EPD_INCOMEFOREMI")));
				hshValues.put("EPD_EXISTINGEMI", Helper.correctNull((String) rs.getString("EPD_EXISTINGEMI")));
				hshValues.put("EPD_AVAINCOMEFORNEWLOAN", Helper.correctNull((String) rs.getString("EPD_AVAINCOMEFORNEWLOAN")));
				hshValues.put("EPD_PERLAKHEMI", Helper.correctNull((String) rs.getString("EPD_PERLAKHEMI")));
				hshValues.put("EPD_VALTOCONSIDERFORLOANAMT", Helper.correctNull((String) rs.getString("EPD_VALTOCONSIDERFORLOANAMT")));
				hshValues.put("EPD_LENDERNMIMONTHS", Helper.correctNull((String) rs.getString("EPD_LENDERNMIMONTHS")));
				hshValues.put("EPD_LOANONNMI", Helper.correctNull((String) rs.getString("EPD_LOANONNMI")));
				hshValues.put("EPD_EMINMIRATE", Helper.correctNull((String) rs.getString("EPD_EMINMIRATE")));
				hshValues.put("EPD_LOANONEMINMI", Helper.correctNull((String) rs.getString("EPD_LOANONEMINMI")));
				hshValues.put("EPD_AVALOANAMT", Helper.correctNull((String) rs.getString("EPD_AVALOANAMT")));
				hshValues.put("EPD_FPMAXLOAN", Helper.correctNull((String) rs.getString("EPD_FPMAXLOAN")));
				hshValues.put("EPD_PROPOSEDFINALEMI", Helper.correctNull((String) rs.getString("EPD_PROPOSEDFINALEMI")));
				hshValues.put("EPD_FINALEMI", Helper.correctNull((String) rs.getString("EPD_FINALEMI")));
				hshValues.put("EPD_FINALEMINMI", Helper.correctNull((String) rs.getString("EPD_FINALEMINMI")));
				hshValues.put("EPD_FINALESTIMATEDSALES", Helper.correctNull((String) rs.getString("EPD_FINALESTIMATEDSALES")));
				hshValues.put("EPD_WORKINGCAPITALREQ", Helper.correctNull((String) rs.getString("EPD_WORKINGCAPITALREQ")));
				hshValues.put("EPD_TOTFINANCE", Helper.correctNull((String) rs.getString("EPD_TOTFINANCE")));
				hshValues.put("EPD_COSTOFMACHINERY", Helper.correctNull((String) rs.getString("EPD_COSTOFMACHINERY")));
			}
			if(rs != null)
			{
				rs.close();
			}
    	   
       }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> getEligibilityDetails Method"+m);
       }
	return hshValues;
}

@SuppressWarnings("unchecked")
public HashMap getNULMLoanDetails(HashMap hshValues) 
{
	String strQuery = "";
	ResultSet rs = null;
	String AppId = Helper.correctNull((String)hshValues.get("hidApplicantId"));
       try {
    	   strQuery = SQLParser.getSqlQuery("getNULMLoanDetails^"+AppId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("NULM_ROWID", Helper.correctNull((String) rs.getString("NULM_ROWID")));
				hshValues.put("NULM_ADDR_REFID", Helper.correctNull((String) rs.getString("NULM_ADDR_REFID")));
				hshValues.put("NULM_ID", Helper.correctNull((String) rs.getString("NULM_ID")));
				hshValues.put("NULM_APP_REF_ID", Helper.correctNull((String) rs.getString("NULM_APP_REF_ID")));
				hshValues.put("NULM_PURPOSE_OF_LOAN", Helper.correctNull((String) rs.getString("NULM_PURPOSE_OF_LOAN")));
				hshValues.put("NULM_LOAN_AMOUNT", Helper.correctNull((String) rs.getString("NULM_LOAN_AMOUNT")));
				hshValues.put("NULM_OWN_CONTRIBUTN", Helper.correctNull((String) rs.getString("NULM_OWN_CONTRIBUTN")));
				hshValues.put("NULM_TOTAL_COST", Helper.correctNull((String) rs.getString("NULM_TOTAL_COST")));
				hshValues.put("NULM_ULB_NAME", Helper.correctNull((String) rs.getString("NULM_ULB_NAME")));
				hshValues.put("NULM_ULB_CODE", Helper.correctNull((String) rs.getString("NULM_ULB_CODE")));
				hshValues.put("NULM_MICRO_ENTRPRSE_TYPE", Helper.correctNull((String) rs.getString("NULM_MICRO_ENTRPRSE_TYPE")));
				hshValues.put("NULM_INCOME_SOURCE", Helper.correctNull((String) rs.getString("NULM_INCOME_SOURCE")));
				hshValues.put("NULM_TYPE_OF_EMPLYMNT", Helper.correctNull((String) rs.getString("NULM_TYPE_OF_EMPLYMNT")));
				hshValues.put("NULM_ANNUAL_INCOME", Helper.correctNull((String) rs.getString("NULM_ANNUAL_INCOME")));
				hshValues.put("NULM_ANNUAL_EXPENDITURE", Helper.correctNull((String) rs.getString("NULM_ANNUAL_EXPENDITURE")));
				hshValues.put("NULM_NATURE_OF_ENTRPRISE_ID", Helper.correctNull((String) rs.getString("NULM_NATURE_OF_ENTRPRISE_ID")));
				hshValues.put("NULM_NATURE_OF_ENTRPRISE", Helper.correctNull((String) rs.getString("NULM_NATURE_OF_ENTRPRISE")));
				hshValues.put("NULM_AREA_OF_PREMISE", Helper.correctNull((String) rs.getString("NULM_AREA_OF_PREMISE")));
				hshValues.put("NULM_MICRO_ENTRPRSE_TYPE_ID", Helper.correctNull((String) rs.getString("NULM_MICRO_ENTRPRSE_TYPE_ID")));
				hshValues.put("NULM_AREA_OF_PREMISE_ID", Helper.correctNull((String) rs.getString("NULM_AREA_OF_PREMISE_ID")));
				hshValues.put("NULM_LOAN_TYPE_ID", Helper.correctNull((String) rs.getString("NULM_LOAN_TYPE_ID")));
				hshValues.put("NULM_LOAN_TYPE", Helper.correctNull((String) rs.getString("NULM_LOAN_TYPE")));
			}
			if(rs != null)
			{
				rs.close();
			}
			
			getPSB59NULMAddressDetails(hshValues);
    	   
       }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> getScoringDetails Method"+m);
       }
	return hshValues;
	
}

@SuppressWarnings("unchecked")
public HashMap getPSB59AddressDetails(HashMap hshValues) 
{
	String strQuery ="",strRefId="",AddSeqNo="",SellAddSeqNo="";
	ResultSet rs= null;

	strRefId =  Helper.correctNull((String)hshValues.get("hidApplicantId"));
	AddSeqNo =  Helper.correctNull((String)hshValues.get("NPPRD_ADD_SEQ_NO"));
	SellAddSeqNo =  Helper.correctNull((String)hshValues.get("NPPRD_SEL_ADD_SEQ_NO"));
	
       try {
			strQuery=SQLParser.getSqlQuery("getAddressDetails^"+strRefId+"^"+AddSeqNo);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("NPAD_ID", Helper.correctNull((String) rs.getString("NPAD_ID")));
			hshValues.put("NPAD_APPLICATION_REFERENCE_ID", Helper.correctNull((String) rs.getString("NPAD_APPLICATION_REFERENCE_ID")));
			hshValues.put("NPAD_ADD_SEQ_NO", Helper.correctNull((String) rs.getString("NPAD_ADD_SEQ_NO")));
			hshValues.put("NPAD_ADD_TYPE", Helper.correctNull((String) rs.getString("NPAD_ADD_TYPE")));
			hshValues.put("NPAD_STREET_NAME", Helper.correctNull((String) rs.getString("NPAD_STREET_NAME")));
			hshValues.put("NPAD_LANDMARK", Helper.correctNull((String) rs.getString("NPAD_LANDMARK")));
			hshValues.put("NPAD_COUNTRY_NAME", Helper.correctNull((String) rs.getString("NPAD_COUNTRY_NAME")));
			hshValues.put("NPAD_STATE_NAME", Helper.correctNull((String) rs.getString("NPAD_STATE_NAME")));
			hshValues.put("NPAD_DISTRICT_NAME", Helper.correctNull((String) rs.getString("NPAD_DISTRICT_NAME")));
			hshValues.put("NPAD_CITY_NAME", Helper.correctNull((String) rs.getString("NPAD_CITY_NAME")));
			hshValues.put("NPAD_SUB_DISTRICT", Helper.correctNull((String) rs.getString("NPAD_SUB_DISTRICT")));
			hshValues.put("NPAD_VILLAGE", Helper.correctNull((String) rs.getString("NPAD_VILLAGE")));
			hshValues.put("NPAD_PIN_CODE", Helper.correctNull((String) rs.getString("NPAD_PIN_CODE")));
			hshValues.put("NPAD_STATE_CODE", Helper.correctNull((String) rs.getString("NPAD_STATE_CODE")));
			hshValues.put("NPAD_DISTRICT_CODE", Helper.correctNull((String) rs.getString("NPAD_DISTRICT_CODE")));
			hshValues.put("NPAD_SUB_DISTRICT_CODE", Helper.correctNull((String) rs.getString("NPAD_SUB_DISTRICT_CODE")));
			hshValues.put("NPAD_VILLAGE_CODE", Helper.correctNull((String) rs.getString("NPAD_VILLAGE_CODE")));
			hshValues.put("NPAD_BLOCK_CODE", Helper.correctNull((String) rs.getString("NPAD_BLOCK_CODE")));
			hshValues.put("NPAD_BLOCK", Helper.correctNull((String) rs.getString("NPAD_BLOCK")));
			}
			if(rs != null)
			{
				rs.close();
			}
			
			strQuery=SQLParser.getSqlQuery("getAddressDetails^"+strRefId+"^"+SellAddSeqNo);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("SELL_NPAD_ID", Helper.correctNull((String) rs.getString("NPAD_ID")));
			hshValues.put("SELL_NPAD_APPLICATION_REFERENCE_ID", Helper.correctNull((String) rs.getString("NPAD_APPLICATION_REFERENCE_ID")));
			hshValues.put("SELL_NPAD_ADD_SEQ_NO", Helper.correctNull((String) rs.getString("NPAD_ADD_SEQ_NO")));
			hshValues.put("SELL_NPAD_ADD_TYPE", Helper.correctNull((String) rs.getString("NPAD_ADD_TYPE")));
			hshValues.put("SELL_NPAD_STREET_NAME", Helper.correctNull((String) rs.getString("NPAD_STREET_NAME")));
			hshValues.put("SELL_NPAD_LANDMARK", Helper.correctNull((String) rs.getString("NPAD_LANDMARK")));
			hshValues.put("SELL_NPAD_COUNTRY_NAME", Helper.correctNull((String) rs.getString("NPAD_COUNTRY_NAME")));
			hshValues.put("SELL_NPAD_STATE_NAME", Helper.correctNull((String) rs.getString("NPAD_STATE_NAME")));
			hshValues.put("SELL_NPAD_DISTRICT_NAME", Helper.correctNull((String) rs.getString("NPAD_DISTRICT_NAME")));
			hshValues.put("SELL_NPAD_CITY_NAME", Helper.correctNull((String) rs.getString("NPAD_CITY_NAME")));
			hshValues.put("SELL_NPAD_SUB_DISTRICT", Helper.correctNull((String) rs.getString("NPAD_SUB_DISTRICT")));
			hshValues.put("SELL_NPAD_VILLAGE", Helper.correctNull((String) rs.getString("NPAD_VILLAGE")));
			hshValues.put("SELL_NPAD_PIN_CODE", Helper.correctNull((String) rs.getString("NPAD_PIN_CODE")));
			hshValues.put("SELL_NPAD_STATE_CODE", Helper.correctNull((String) rs.getString("NPAD_STATE_CODE")));
			hshValues.put("SELL_NPAD_DISTRICT_CODE", Helper.correctNull((String) rs.getString("NPAD_DISTRICT_CODE")));
			hshValues.put("SELL_NPAD_SUB_DISTRICT_CODE", Helper.correctNull((String) rs.getString("NPAD_SUB_DISTRICT_CODE")));
			hshValues.put("SELL_NPAD_VILLAGE_CODE", Helper.correctNull((String) rs.getString("NPAD_VILLAGE_CODE")));
			hshValues.put("SELL_NPAD_BLOCK_CODE", Helper.correctNull((String) rs.getString("NPAD_BLOCK_CODE")));
			hshValues.put("SELL_NPAD_BLOCK", Helper.correctNull((String) rs.getString("NPAD_BLOCK")));
			}
			if(rs != null)
			{
				rs.close();
			}
       }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> getPSB59AddressDetails Method : "+m);
       }
	return hshValues;
	
}

@SuppressWarnings("unchecked")
public HashMap getPSB59NULMAddressDetails(HashMap hshValues) 
{
	String strQuery ="",strRefId="",nulmAddrRefId="";
	ResultSet rs= null;

	strRefId =  Helper.correctNull((String)hshValues.get("hidApplicantId"));
	nulmAddrRefId =  Helper.correctNull((String)hshValues.get("NULM_ADDR_REFID"));
	
       try {				
			strQuery=SQLParser.getSqlQuery("getAddressDetails^"+strRefId+"^"+nulmAddrRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("NPAD_ID", Helper.correctNull((String) rs.getString("NPAD_ID")));
			hshValues.put("NPAD_APPLICATION_REFERENCE_ID", Helper.correctNull((String) rs.getString("NPAD_APPLICATION_REFERENCE_ID")));
			hshValues.put("NPAD_ADD_SEQ_NO", Helper.correctNull((String) rs.getString("NPAD_ADD_SEQ_NO")));
			hshValues.put("NPAD_ADD_TYPE", Helper.correctNull((String) rs.getString("NPAD_ADD_TYPE")));
			hshValues.put("NPAD_STREET_NAME", Helper.correctNull((String) rs.getString("NPAD_STREET_NAME")));
			hshValues.put("NPAD_LANDMARK", Helper.correctNull((String) rs.getString("NPAD_LANDMARK")));
			hshValues.put("NPAD_COUNTRY_NAME", Helper.correctNull((String) rs.getString("NPAD_COUNTRY_NAME")));
			hshValues.put("NPAD_STATE_NAME", Helper.correctNull((String) rs.getString("NPAD_STATE_NAME")));
			hshValues.put("NPAD_DISTRICT_NAME", Helper.correctNull((String) rs.getString("NPAD_DISTRICT_NAME")));
			hshValues.put("NPAD_CITY_NAME", Helper.correctNull((String) rs.getString("NPAD_CITY_NAME")));
			hshValues.put("NPAD_SUB_DISTRICT", Helper.correctNull((String) rs.getString("NPAD_SUB_DISTRICT")));
			hshValues.put("NPAD_VILLAGE", Helper.correctNull((String) rs.getString("NPAD_VILLAGE")));
			hshValues.put("NPAD_PIN_CODE", Helper.correctNull((String) rs.getString("NPAD_PIN_CODE")));
			hshValues.put("NPAD_STATE_CODE", Helper.correctNull((String) rs.getString("NPAD_STATE_CODE")));
			hshValues.put("NPAD_DISTRICT_CODE", Helper.correctNull((String) rs.getString("NPAD_DISTRICT_CODE")));
			hshValues.put("NPAD_SUB_DISTRICT_CODE", Helper.correctNull((String) rs.getString("NPAD_SUB_DISTRICT_CODE")));
			hshValues.put("NPAD_VILLAGE_CODE", Helper.correctNull((String) rs.getString("NPAD_VILLAGE_CODE")));
			hshValues.put("NPAD_BLOCK_CODE", Helper.correctNull((String) rs.getString("NPAD_BLOCK_CODE")));
			hshValues.put("NPAD_BLOCK", Helper.correctNull((String) rs.getString("NPAD_BLOCK")));
			}
			if(rs != null)
			{
				rs.close();
			}
       }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> getPSB59NULMAddressDetails Method : "+m);
       }
	return hshValues;
	
}

//SWMS loan details
@SuppressWarnings("unchecked")
public HashMap getBusSWMSloandetails(HashMap hshValues) 
{
	String strQuery ="",strRefId="";
	ResultSet rs= null;

	strRefId =  Helper.correctNull((String)hshValues.get("hidApplicantId"));
	
	
       try {
    	   
			strQuery=SQLParser.getSqlQuery("sel_busswmsloandet^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("NPSL_APPREF_ID", Helper.correctNull((String) rs.getString("NPSL_APPREF_ID")));
			hshValues.put("NPSL_LOANPURPOSE_ID", Helper.correctNull((String) rs.getString("NPSL_LOANPURPOSE_ID")));
			hshValues.put("NPSL_LOANPURPOSE", Helper.correctNull((String) rs.getString("NPSL_LOANPURPOSE")));
			hshValues.put("NPSL_PROJECTCOST", Helper.correctNull((String) rs.getString("NPSL_PROJECTCOST")));
			hshValues.put("NPSL_PROJ_CONTRIBTN", Helper.correctNull((String) rs.getString("NPSL_PROJ_CONTRIBTN")));
			hshValues.put("NPSL_REQ_LOAN_AMT", Helper.correctNull((String) rs.getString("NPSL_REQ_LOAN_AMT")));
			hshValues.put("NPSL_IS_WEAVER", Helper.correctNull((String) rs.getString("NPSL_IS_WEAVER")));
			hshValues.put("NPSL_SOC_NAME", Helper.correctNull((String) rs.getString("NPSL_SOC_NAME")));
			hshValues.put("NPSL_MEMBER_NO", Helper.correctNull((String) rs.getString("NPSL_MEMBER_NO")));
			hshValues.put("NPSL_LOAN_AMT", Helper.correctNull((String) rs.getString("NPSL_LOAN_AMT")));
			hshValues.put("NPSL_OUT_AMT", Helper.correctNull((String) rs.getString("NPSL_OUT_AMT")));
			hshValues.put("NPSL_CREATED_BY", Helper.correctNull((String) rs.getString("NPSL_CREATED_BY")));
			hshValues.put("NPSL_CREATED_ON", Helper.correctNull((String) rs.getString("NPSL_CREATED_ON")));
			hshValues.put("NPSL_MODIFIED_BY", Helper.correctNull((String) rs.getString("NPSL_MODIFIED_BY")));
			hshValues.put("NPSL_MODIFIED_ON", Helper.correctNull((String) rs.getString("NPSL_MODIFIED_ON")));
			}
			if(rs != null)
			{
				rs.close();
			}

			strQuery=SQLParser.getSqlQuery("select_loan_check_SRMS^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("NPSL_CONTACT_NO", Helper.correctNull((String) rs.getString("NPSL_CONTACT_NO")));
			hshValues.put("NPSL_MECHANIZE_NAME", Helper.correctNull((String) rs.getString("NPSL_MECHANIZE_NAME")));
			hshValues.put("NPSL_EQUIP_PURPOSE", Helper.correctNull((String) rs.getString("NPSL_EQUIP_PURPOSE")));
			hshValues.put("NPSL_PROCUR_MECHANISM", Helper.correctNull((String) rs.getString("NPSL_PROCUR_MECHANISM")));
			hshValues.put("NPSL_EQUIP_COST", Helper.correctNull((String) rs.getString("NPSL_EQUIP_COST")));
			hshValues.put("NPSL_REPAY_PERIOD", Helper.correctNull((String) rs.getString("NPSL_REPAY_PERIOD")));
			hshValues.put("NPSL_LOAN_AMT", Helper.correctNull((String) rs.getString("NPSL_LOAN_AMT")));
			hshValues.put("NPSL_PREV_LOAN", Helper.correctNull((String) rs.getString("NPSL_PREV_LOAN")));
			hshValues.put("NPSL_STATUS", Helper.correctNull((String) rs.getString("NPSL_STATUS")));
			hshValues.put("NPSL_EQUIP_PURPOSE_ID", Helper.correctNull((String) rs.getString("NPSL_EQUIP_PURPOSE_ID")));
			hshValues.put("NPSL_PROCUR_MECHANISM_ID", Helper.correctNull((String) rs.getString("NPSL_PROCUR_MECHANISM_ID")));
			hshValues.put("NPSL_APP_REF_ID", Helper.correctNull((String) rs.getString("NPSL_APP_REF_ID")));

			}
			if(rs != null)
			{
				rs.close();
			}
			
       }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> getBusSWMSdetails Method : "+m);
       }
	return hshValues;
	
}

//SWMS personal details
@SuppressWarnings("unchecked")
public HashMap getBusSWMSpersonaldetails(HashMap hshValues) 
{
	String strQuery ="",strRefId="",CurrAddSeqNo="",OffAddSeqNo="";
	ResultSet rs= null;

	strRefId =  Helper.correctNull((String)hshValues.get("hidApplicantId"));
	String swms_appid="";
	
       try {
    	   
    	 String  SchemeId="";
			strQuery = SQLParser.getSqlQuery("sel_applicationscheme_np^"+strRefId);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				SchemeId=Helper.correctNull((String)rs.getString("NPDT_NP_SCHEME_NAME"));
			}
			 hshValues.put("POP_SCHEME_ID",SchemeId);	    	   
		    
    	   hshValues.put("hidRefId",strRefId);
    	   hshValues.put("Refno",strRefId);
			strQuery=SQLParser.getSqlQuery("sel_busswmspersdet^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("SWMS_CREATEDBY", Helper.correctNull((String) rs.getString("SWMS_CREATEDBY")));
			hshValues.put("SWMS_CREATEDON", Helper.correctNull((String) rs.getString("SWMS_CREATEDON")));
			hshValues.put("SWMS_MODIFIEDON", Helper.correctNull((String) rs.getString("SWMS_MODIFIEDON")));
			hshValues.put("SWMS_MODIFIEDBY", Helper.correctNull((String) rs.getString("SWMS_MODIFIEDBY")));
			hshValues.put("SWMS_CURR_ADDR_REFID", Helper.correctNull((String) rs.getString("SWMS_CURR_ADDR_REFID")));
			CurrAddSeqNo = Helper.correctNull((String) rs.getString("SWMS_CURR_ADDR_REFID"));
			hshValues.put("SWMS_OFFC_ADDR_REFID", Helper.correctNull((String) rs.getString("SWMS_OFFC_ADDR_REFID")));
			OffAddSeqNo = Helper.correctNull((String) rs.getString("SWMS_OFFC_ADDR_REFID"));
			hshValues.put("SWMS_ID", Helper.correctNull((String) rs.getString("SWMS_ID")));
			hshValues.put("SWMS_APP_REF_ID", Helper.correctNull((String) rs.getString("SWMS_APP_REF_ID")));
			hshValues.put("SWMS_SALUTATION_ID", Helper.correctNull((String) rs.getString("SWMS_SALUTATION_ID")));
			hshValues.put("SWMS_SALUTATION", Helper.correctNull((String) rs.getString("SWMS_SALUTATION")));
			hshValues.put("SWMS_FIRST_NAME", Helper.correctNull((String) rs.getString("SWMS_FIRST_NAME")));
			hshValues.put("SWMS_LAST_NAME", Helper.correctNull((String) rs.getString("SWMS_LAST_NAME")));
			hshValues.put("SWMS_MIDDLE_NAME", Helper.correctNull((String) rs.getString("SWMS_MIDDLE_NAME")));
			hshValues.put("SWMS_PAN", Helper.correctNull((String) rs.getString("SWMS_PAN")));
			hshValues.put("SWMS_FATHER_NAME", Helper.correctNull((String) rs.getString("SWMS_FATHER_NAME")));
			hshValues.put("SWMS_MOTHER_NAME", Helper.correctNull((String) rs.getString("SWMS_MOTHER_NAME")));
			hshValues.put("SWMS_DOB", Helper.correctNull((String) rs.getString("SWMS_DOB")));
			hshValues.put("SWMS_MODIFIEDON", Helper.correctNull((String) rs.getString("SWMS_MODIFIEDON")));
			hshValues.put("SWMS_GENDER_ID", Helper.correctNull((String) rs.getString("SWMS_GENDER_ID")));
			hshValues.put("SWMS_GENDER", Helper.correctNull((String) rs.getString("SWMS_GENDER")));
			hshValues.put("SWMS_SOCIAL_CATEGORY_ID", Helper.correctNull((String) rs.getString("SWMS_SOCIAL_CATEGORY_ID")));
			hshValues.put("SWMS_SOCIAL_CATEGORY", Helper.correctNull((String) rs.getString("SWMS_SOCIAL_CATEGORY")));
			hshValues.put("SWMS_EDU_QUALIFCTN_ID", Helper.correctNull((String) rs.getString("SWMS_EDU_QUALIFCTN_ID")));
			hshValues.put("SWMS_EDU_QUALIFCTN", Helper.correctNull((String) rs.getString("SWMS_EDU_QUALIFCTN")));
			hshValues.put("SWMS_MOBILE", Helper.correctNull((String) rs.getString("SWMS_MOBILE")));
			hshValues.put("SWMS_EMAIL", Helper.correctNull((String) rs.getString("SWMS_EMAIL")));
			hshValues.put("SWMS_MARITAL_STATUS_ID", Helper.correctNull((String) rs.getString("SWMS_MARITAL_STATUS_ID")));
			hshValues.put("SWMS_MARITAL_STATUS", Helper.correctNull((String) rs.getString("SWMS_MARITAL_STATUS")));
			hshValues.put("SWMS_PRESNT_MONTHLY_INCOME", Helper.correctNull((String) rs.getString("SWMS_PRESNT_MONTHLY_INCOME")));
			hshValues.put("SWMS_IS_CURRNT_ADD_SAME", Helper.correctNull((String) rs.getString("SWMS_IS_CURRNT_ADD_SAME")));
			hshValues.put("SWMS_WEAVER_CARD_NO", Helper.correctNull((String) rs.getString("SWMS_WEAVER_CARD_NO")));
			hshValues.put("SWMS_CARD_ISSUE_DATE", Helper.correctNull((String) rs.getString("SWMS_CARD_ISSUE_DATE")));
			hshValues.put("SWMS_WEAVNG_TYPE_ID", Helper.correctNull((String) rs.getString("SWMS_WEAVNG_TYPE_ID")));
			hshValues.put("SWMS_WEAVNG_TYPE", Helper.correctNull((String) rs.getString("SWMS_WEAVNG_TYPE")));
			hshValues.put("SWMS_WEAVNG_TYPE_NAME", Helper.correctNull((String) rs.getString("SWMS_WEAVNG_TYPE_NAME")));
			hshValues.put("SWMS_OWNG_HANDLOOM_ID", Helper.correctNull((String) rs.getString("SWMS_OWNG_HANDLOOM_ID")));
			hshValues.put("SWMS_OWNG_HANDLOOM", Helper.correctNull((String) rs.getString("SWMS_OWNG_HANDLOOM")));
			hshValues.put("EXP_HANDLOOM_WEAVNG_YRS", Helper.correctNull((String) rs.getString("EXP_HANDLOOM_WEAVNG_YRS")));
			hshValues.put("EXP_HANDLOOM_WEAVNG_MONTHS", Helper.correctNull((String) rs.getString("EXP_HANDLOOM_WEAVNG_MONTHS")));
			hshValues.put("SWMS_OTHR_BUSNSS_ID", Helper.correctNull((String) rs.getString("SWMS_OTHR_BUSNSS_ID")));
			hshValues.put("SWMS_OTHR_BUSNSS", Helper.correctNull((String) rs.getString("SWMS_OTHR_BUSNSS")));
			hshValues.put("SWMS_MARKTNG_ARRANGMNT_ID", Helper.correctNull((String) rs.getString("SWMS_MARKTNG_ARRANGMNT_ID")));
			hshValues.put("SWMS_MARKTNG_ARRANGMNT", Helper.correctNull((String) rs.getString("SWMS_MARKTNG_ARRANGMNT")));
			hshValues.put("SWMS_TOTAL_SALES", Helper.correctNull((String) rs.getString("SWMS_TOTAL_SALES")));
			hshValues.put("SWMS_MACHNRY_COST", Helper.correctNull((String) rs.getString("SWMS_MACHNRY_COST")));
			hshValues.put("SWMS_BUSNSS_PROSPECTS_ID", Helper.correctNull((String) rs.getString("SWMS_BUSNSS_PROSPECTS_ID")));
			hshValues.put("SWMS_BUSNSS_PROSPECTS", Helper.correctNull((String) rs.getString("SWMS_BUSNSS_PROSPECTS")));
			hshValues.put("SWMS_IS_DOB_FRM_AADHAR", Helper.correctNull((String) rs.getString("SWMS_IS_DOB_FRM_AADHAR")));
			swms_appid= Helper.correctNull((String) rs.getString("SWMS_IS_DOB_FRM_AADHAR"));
			}
			
			
			if(rs != null)
			{
				rs.close();
			}
			
			//asset details
			strQuery=SQLParser.getSqlQuery("sel_busswmsassetdet^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("SWMS_APP_REF_ID", Helper.correctNull((String) rs.getString("SWMS_APP_REF_ID")));
			hshValues.put("SWMS_ASSET_TYPE_ID", Helper.correctNull((String) rs.getString("SWMS_ASSET_TYPE_ID")));
			hshValues.put("SWMS_DESCRIPTION", Helper.correctNull((String) rs.getString("SWMS_DESCRIPTION")));
			hshValues.put("SWMS_PROPERTY_COUNT", Helper.correctNull((String) rs.getString("SWMS_PROPERTY_COUNT")));
			hshValues.put("SWMS_PRESENT_VALUE", Helper.correctNull((String) rs.getString("SWMS_PRESENT_VALUE")));
			hshValues.put("SWMS_ASSET_TYPE", Helper.correctNull((String) rs.getString("SWMS_ASSET_TYPE")));
		
             }
			
			if(rs != null)
			{
				rs.close();
			}
			
			//buyer details
			strQuery=SQLParser.getSqlQuery("sel_busswmsbuyerdet^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("SWMS_APP_REF_ID", Helper.correctNull((String) rs.getString("SWMS_APP_REF_ID")));
			hshValues.put("SWMS_BUYER_NAME", Helper.correctNull((String) rs.getString("SWMS_BUYER_NAME")));
			hshValues.put("SWMS_ADDRESS", Helper.correctNull((String) rs.getString("SWMS_ADDRESS")));
			hshValues.put("SWMS_MOBILE", Helper.correctNull((String) rs.getString("SWMS_MOBILE")));
			hshValues.put("SWMS_AVG_MONTHLY_RECIEPT", Helper.correctNull((String) rs.getString("SWMS_AVG_MONTHLY_RECIEPT")));
		
             }
			
			if(rs != null)
			{
				rs.close();
			}
			
			strQuery=SQLParser.getSqlQuery("sel_busswmspandet^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("SWMS_ROWID", Helper.correctNull((String) rs.getString("SWMS_ROWID")));
			hshValues.put("SWMS_APP_REF_ID", Helper.correctNull((String) rs.getString("SWMS_APP_REF_ID")));
			hshValues.put("SWMS_PAN", Helper.correctNull((String) rs.getString("SWMS_PAN")));
			hshValues.put("SWMS_FIRST_NAME", Helper.correctNull((String) rs.getString("SWMS_FIRST_NAME")));
			hshValues.put("SWMS_MIDDLE_NAME", Helper.correctNull((String) rs.getString("SWMS_MIDDLE_NAME")));
			hshValues.put("SWMS_LAST_NAME", Helper.correctNull((String) rs.getString("SWMS_LAST_NAME")));
			hshValues.put("SWMS_ENTITY_NAME", Helper.correctNull((String) rs.getString("SWMS_ENTITY_NAME")));
			hshValues.put("SWMS_ENTITY_TYPE", Helper.correctNull((String) rs.getString("SWMS_ENTITY_TYPE")));
            }
			
			if(rs != null)
			{
				rs.close();
			}
			if(!CurrAddSeqNo.equalsIgnoreCase(""))
			{
			strQuery=SQLParser.getSqlQuery("getAddressDetails^"+strRefId+"^"+CurrAddSeqNo);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("CURR_NPAD_ID", Helper.correctNull((String) rs.getString("NPAD_ID")));
			hshValues.put("CURR_NPAD_APPLICATION_REFERENCE_ID", Helper.correctNull((String) rs.getString("NPAD_APPLICATION_REFERENCE_ID")));
			hshValues.put("CURR_NPAD_ADD_SEQ_NO", Helper.correctNull((String) rs.getString("NPAD_ADD_SEQ_NO")));
			hshValues.put("CURR_NPAD_ADD_TYPE", Helper.correctNull((String) rs.getString("NPAD_ADD_TYPE")));
			hshValues.put("CURR_NPAD_STREET_NAME", Helper.correctNull((String) rs.getString("NPAD_STREET_NAME")));
			hshValues.put("CURR_NPAD_LANDMARK", Helper.correctNull((String) rs.getString("NPAD_LANDMARK")));
			hshValues.put("CURR_NPAD_COUNTRY_NAME", Helper.correctNull((String) rs.getString("NPAD_COUNTRY_NAME")));
			hshValues.put("CURR_NPAD_STATE_NAME", Helper.correctNull((String) rs.getString("NPAD_STATE_NAME")));
			hshValues.put("CURR_NPAD_DISTRICT_NAME", Helper.correctNull((String) rs.getString("NPAD_DISTRICT_NAME")));
			hshValues.put("CURR_NPAD_CITY_NAME", Helper.correctNull((String) rs.getString("NPAD_CITY_NAME")));
			hshValues.put("CURR_NPAD_SUB_DISTRICT", Helper.correctNull((String) rs.getString("NPAD_SUB_DISTRICT")));
			hshValues.put("CURR_NPAD_VILLAGE", Helper.correctNull((String) rs.getString("NPAD_VILLAGE")));
			hshValues.put("CURR_NPAD_PIN_CODE", Helper.correctNull((String) rs.getString("NPAD_PIN_CODE")));
			hshValues.put("CURR_NPAD_STATE_CODE", Helper.correctNull((String) rs.getString("NPAD_STATE_CODE")));
			hshValues.put("CURR_NPAD_DISTRICT_CODE", Helper.correctNull((String) rs.getString("NPAD_DISTRICT_CODE")));
			hshValues.put("CURR_NPAD_SUB_DISTRICT_CODE", Helper.correctNull((String) rs.getString("NPAD_SUB_DISTRICT_CODE")));
			hshValues.put("CURR_NPAD_VILLAGE_CODE", Helper.correctNull((String) rs.getString("NPAD_VILLAGE_CODE")));
			hshValues.put("CURR_NPAD_BLOCK_CODE", Helper.correctNull((String) rs.getString("NPAD_BLOCK_CODE")));
			hshValues.put("CURR_NPAD_BLOCK", Helper.correctNull((String) rs.getString("NPAD_BLOCK")));
			}
			if(rs != null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_aadhar_address^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("NPAA_ID", Helper.correctNull((String) rs.getString("NPAA_ID")));
			hshValues.put("NPAA_APPLICATION_REFERENCE_ID", strRefId);
			hshValues.put("NPAA_STREET_NAME", Helper.correctNull((String) rs.getString("NPAA_STREET_NAME")));
			hshValues.put("NPAA_LAND_MARK", Helper.correctNull((String) rs.getString("NPAA_LAND_MARK")));
			hshValues.put("NPAA_COUNTRY_NAME", Helper.correctNull((String) rs.getString("NPAA_COUNTRY_NAME")));
			hshValues.put("NPAA_STATE_NAME", Helper.correctNull((String) rs.getString("NPAA_STATE_NAME")));
			hshValues.put("NPAA_CITY_NAME", Helper.correctNull((String) rs.getString("NPAA_CITY_NAME")));
			hshValues.put("NPAA_DISTRICT_NAME", Helper.correctNull((String) rs.getString("NPAA_DISTRICT_NAME")));
			hshValues.put("NPAA_SUB_DISTRICT", Helper.correctNull((String) rs.getString("NPAA_SUB_DISTRICT")));
			hshValues.put("NPAA_VILLAGE", Helper.correctNull((String) rs.getString("NPAA_VILLAGE")));
			hshValues.put("NPAA_PIN_CODE", Helper.correctNull((String) rs.getString("NPAA_PIN_CODE")));
			}
			if(rs != null)
			{
				rs.close();
			}
			}
			
       }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> getBusSWMSpersonaldetails Method : "+m);
       }
	return hshValues;
	
}	

//Mudra personal details
@SuppressWarnings("unchecked")
public HashMap getBusmudrapersdetails(HashMap hshValues) 
{
	String strQuery ="",strRefId="",AddSeqNo="",AadhAddSeqNo="";
	ResultSet rs= null;

	  
	
	
	strRefId =  Helper.correctNull((String)hshValues.get("hidApplicantId"));
	hshValues.put("strRefId", strRefId);
	hshValues.put("Refno", strRefId);
	
       try {
    	   String SchemeId="";
			strQuery = SQLParser.getSqlQuery("sel_applicationscheme_np^"+strRefId);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				SchemeId=Helper.correctNull((String)rs.getString("NPDT_NP_SCHEME_NAME"));
			}
			 hshValues.put("POP_SCHEME_ID",SchemeId);	    	   
		    
			strQuery=SQLParser.getSqlQuery("sel_busmudrapersdet^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("SPD_ID", Helper.correctNull((String) rs.getString("SPD_ID")));
			hshValues.put("SPD_APPLN_REF_ID", Helper.correctNull((String) rs.getString("SPD_APPLN_REF_ID")));
			hshValues.put("SPD_NO_EMP_OR_WORKERS", Helper.correctNull((String) rs.getString("SPD_NO_EMP_OR_WORKERS")));
			hshValues.put("SPD_NO_EMP_OR_WORKERS_ID", Helper.correctNull((String) rs.getString("SPD_NO_EMP_OR_WORKERS_ID")));
			hshValues.put("SPD_OPERATING_BUSINESS_YEAR", Helper.correctNull((String) rs.getString("SPD_OPERATING_BUSINESS_YEAR")));
			hshValues.put("SPD_OPERATING_BUSINESS_MONTH", Helper.correctNull((String) rs.getString("SPD_OPERATING_BUSINESS_MONTH")));
			hshValues.put("SPD_ANY_PENSION_PLAN", Helper.correctNull((String) rs.getString("SPD_ANY_PENSION_PLAN")));
			hshValues.put("SPD_PENSION_PLAN_OR_INS_SCH", Helper.correctNull((String) rs.getString("SPD_PENSION_PLAN_OR_INS_SCH")));
			hshValues.put("SPD_SPECIFY_OTH_PENSION_PLAN", Helper.correctNull((String) rs.getString("SPD_SPECIFY_OTH_PENSION_PLAN")));
			hshValues.put("SPD_INPUTS_LABOUR_RAW_MAT_ID", Helper.correctNull((String) rs.getString("SPD_INPUTS_LABOUR_RAW_MAT_ID")));
			hshValues.put("SPD_INPUT_LABOUR_RAW_MAT", Helper.correctNull((String) rs.getString("SPD_INPUT_LABOUR_RAW_MAT")));
			hshValues.put("SPD_ANY_ASSOCIATE_CONCERN", Helper.correctNull((String) rs.getString("SPD_ANY_ASSOCIATE_CONCERN")));
			hshValues.put("SPD_NO_OF_ASSOCIATE_CONCERN", Helper.correctNull((String) rs.getString("SPD_NO_OF_ASSOCIATE_CONCERN")));
			hshValues.put("SPD_IS_RELATED_PARTY_SELECT", Helper.correctNull((String) rs.getString("SPD_IS_RELATED_PARTY_SELECT")));
			hshValues.put("SPD_BUSINESS_ENTERPRISES", Helper.correctNull((String) rs.getString("SPD_BUSINESS_ENTERPRISES")));
			hshValues.put("SPD_FIRST_TYM_ENTERPRENEUR", Helper.correctNull((String) rs.getString("SPD_FIRST_TYM_ENTERPRENEUR")));
			hshValues.put("SPD_GST_NO", Helper.correctNull((String) rs.getString("SPD_GST_NO")));
			hshValues.put("SPD_COMMENCEMENT_DATE", Helper.correctNull((String) rs.getString("SPD_COMMENCEMENT_DATE")));
			hshValues.put("SPD_IS_UNIT_REGISTRD", Helper.correctNull((String) rs.getString("SPD_IS_UNIT_REGISTRD")));
			hshValues.put("SPD_REG_NO", Helper.correctNull((String) rs.getString("SPD_REG_NO")));
			hshValues.put("SPD_REG_ACT", Helper.correctNull((String) rs.getString("SPD_REG_ACT")));
			hshValues.put("SPD_CONSTITUTION_ID", Helper.correctNull((String) rs.getString("SPD_CONSTITUTION_ID")));
			hshValues.put("SPD_CONSTITUTION_NAME", Helper.correctNull((String) rs.getString("SPD_CONSTITUTION_NAME")));
			hshValues.put("SPD_VOTER_ID", Helper.correctNull((String) rs.getString("SPD_VOTER_ID")));
			hshValues.put("SPD_DRIVING_LICENSE", Helper.correctNull((String) rs.getString("SPD_DRIVING_LICENSE")));
			hshValues.put("SPD_EMAIL_ID", Helper.correctNull((String) rs.getString("SPD_EMAIL_ID")));
			hshValues.put("SPD_APPID", Helper.correctNull((String) rs.getString("SPD_APPID")));
			hshValues.put("SPD_BUSINESS_ADDR_SEQ_NO", Helper.correctNull((String) rs.getString("SPD_BUSINESS_ADDR_SEQ_NO")));
			AddSeqNo = Helper.correctNull((String) rs.getString("SPD_BUSINESS_ADDR_SEQ_NO"));
			hshValues.put("SPD_BUS_UNIT_REG_ADDR_SEQ_NO", Helper.correctNull((String) rs.getString("SPD_BUS_UNIT_REG_ADDR_SEQ_NO")));

			}
			if(rs != null)
			{
				rs.close();
			}
	
		//partner details//residential details
			strQuery=SQLParser.getSqlQuery("sel_busmudrapartnerdet^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("MPDP_APPLN_REF_ID", Helper.correctNull((String) rs.getString("MPDP_APPLN_REF_ID")));
			hshValues.put("MPDP_RELATIONSHIP_TYPE", Helper.correctNull((String) rs.getString("MPDP_RELATIONSHIP_TYPE")));
			hshValues.put("MPDP_OWNERSHIP", Helper.correctNull((String) rs.getString("MPDP_OWNERSHIP")));
			hshValues.put("MPDP_FIRST_NAME", Helper.correctNull((String) rs.getString("MPDP_FIRST_NAME")));
			hshValues.put("MPDP_MIDDLE_NAME", Helper.correctNull((String) rs.getString("MPDP_MIDDLE_NAME")));
			hshValues.put("MPDP_LAST_NAME", Helper.correctNull((String) rs.getString("MPDP_LAST_NAME")));
			hshValues.put("MPDP_FATHERS_NAME", Helper.correctNull((String) rs.getString("MPDP_FATHERS_NAME")));
			hshValues.put("MPDP_DOB", Helper.correctNull((String) rs.getString("MPDP_DOB")));
			hshValues.put("MPDP_MOBILE", Helper.correctNull((String) rs.getString("MPDP_MOBILE")));
			hshValues.put("MPDP_GENDER", Helper.correctNull((String) rs.getString("MPDP_GENDER")));
			hshValues.put("MPDP_TOTAL_EXP", Helper.correctNull((String) rs.getString("MPDP_TOTAL_EXP")));
			hshValues.put("MPDP_NET_WORTH", Helper.correctNull((String) rs.getString("MPDP_NET_WORTH")));
			hshValues.put("MPDP_PAN", Helper.correctNull((String) rs.getString("MPDP_PAN")));
			hshValues.put("MPDP_EDU_STS", Helper.correctNull((String) rs.getString("MPDP_EDU_STS")));
			hshValues.put("MPDP_MAIN_PARTNER", Helper.correctNull((String) rs.getString("MPDP_MAIN_PARTNER")));
			hshValues.put("MPDP_IS_MAIN_PARTNER", Helper.correctNull((String) rs.getString("MPDP_IS_MAIN_PARTNER")));
			hshValues.put("MPDP_OWNING_HOUSE", Helper.correctNull((String) rs.getString("MPDP_OWNING_HOUSE")));
			hshValues.put("MPDP_CATEGORY", Helper.correctNull((String) rs.getString("MPDP_CATEGORY")));
			hshValues.put("MPDP_MINORITY_CATEGORY", Helper.correctNull((String) rs.getString("MPDP_MINORITY_CATEGORY")));
			hshValues.put("MPDP_NO_OF_DEPENDENT", Helper.correctNull((String) rs.getString("MPDP_NO_OF_DEPENDENT")));
			hshValues.put("MPDP_ACTIVE_PARTNER", Helper.correctNull((String) rs.getString("MPDP_ACTIVE_PARTNER")));
			hshValues.put("MPDP_NO_OF_EARNING_MEM", Helper.correctNull((String) rs.getString("MPDP_NO_OF_EARNING_MEM")));
			hshValues.put("MPDP_SALUTATION", Helper.correctNull((String) rs.getString("MPDP_SALUTATION")));
			hshValues.put("MPDP_EMAIL", Helper.correctNull((String) rs.getString("MPDP_EMAIL")));
			hshValues.put("MPDP_IS_DOB_FROM_AADHAR", Helper.correctNull((String) rs.getString("MPDP_IS_DOB_FROM_AADHAR")));
			hshValues.put("MPDP_VISUALLY_IMPAIRED", Helper.correctNull((String) rs.getString("MPDP_VISUALLY_IMPAIRED")));
			hshValues.put("MPDP_PHYSICALLY_CHALLENGED", Helper.correctNull((String) rs.getString("MPDP_PHYSICALLY_CHALLENGED")));
			hshValues.put("MPDP_RESIDENCE_STS", Helper.correctNull((String) rs.getString("MPDP_RESIDENCE_STS")));
			hshValues.put("SPD_BUSINESS_ADDR_SEQ_NO", Helper.correctNull((String) rs.getString("MPDP_AADHAR_ADD_SEQ_NO")));
			AadhAddSeqNo = Helper.correctNull((String) rs.getString("MPDP_AADHAR_ADD_SEQ_NO"));
			
			}
			if(rs != null)
			{
				rs.close();
			}		
			if(!AddSeqNo.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("getAddressDetails^"+strRefId+"^"+AddSeqNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
				hshValues.put("NPAD_ID", Helper.correctNull((String) rs.getString("NPAD_ID")));
				hshValues.put("NPAD_APPLICATION_REFERENCE_ID", Helper.correctNull((String) rs.getString("NPAD_APPLICATION_REFERENCE_ID")));
				hshValues.put("NPAD_ADD_SEQ_NO", Helper.correctNull((String) rs.getString("NPAD_ADD_SEQ_NO")));
				hshValues.put("NPAD_ADD_TYPE", Helper.correctNull((String) rs.getString("NPAD_ADD_TYPE")));
				hshValues.put("NPAD_STREET_NAME", Helper.correctNull((String) rs.getString("NPAD_STREET_NAME")));
				hshValues.put("NPAD_LANDMARK", Helper.correctNull((String) rs.getString("NPAD_LANDMARK")));
				hshValues.put("NPAD_COUNTRY_NAME", Helper.correctNull((String) rs.getString("NPAD_COUNTRY_NAME")));
				hshValues.put("NPAD_STATE_NAME", Helper.correctNull((String) rs.getString("NPAD_STATE_NAME")));
				hshValues.put("NPAD_DISTRICT_NAME", Helper.correctNull((String) rs.getString("NPAD_DISTRICT_NAME")));
				hshValues.put("NPAD_CITY_NAME", Helper.correctNull((String) rs.getString("NPAD_CITY_NAME")));
				hshValues.put("NPAD_SUB_DISTRICT", Helper.correctNull((String) rs.getString("NPAD_SUB_DISTRICT")));
				hshValues.put("NPAD_VILLAGE", Helper.correctNull((String) rs.getString("NPAD_VILLAGE")));
				hshValues.put("NPAD_PIN_CODE", Helper.correctNull((String) rs.getString("NPAD_PIN_CODE")));
				hshValues.put("NPAD_STATE_CODE", Helper.correctNull((String) rs.getString("NPAD_STATE_CODE")));
				hshValues.put("NPAD_DISTRICT_CODE", Helper.correctNull((String) rs.getString("NPAD_DISTRICT_CODE")));
				hshValues.put("NPAD_SUB_DISTRICT_CODE", Helper.correctNull((String) rs.getString("NPAD_SUB_DISTRICT_CODE")));
				hshValues.put("NPAD_VILLAGE_CODE", Helper.correctNull((String) rs.getString("NPAD_VILLAGE_CODE")));
				hshValues.put("NPAD_BLOCK_CODE", Helper.correctNull((String) rs.getString("NPAD_BLOCK_CODE")));
				hshValues.put("NPAD_BLOCK", Helper.correctNull((String) rs.getString("NPAD_BLOCK")));
				}
			}
			
			if(rs != null)
			{
				rs.close();
			}
			if(AadhAddSeqNo.equalsIgnoreCase("")){
				AadhAddSeqNo="0";
			}
			strQuery=SQLParser.getSqlQuery("getAddressDetails^"+strRefId+"^"+AadhAddSeqNo);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("AAD_NPAD_ID", Helper.correctNull((String) rs.getString("NPAD_ID")));
			hshValues.put("AAD_NPAD_APPLICATION_REFERENCE_ID", Helper.correctNull((String) rs.getString("NPAD_APPLICATION_REFERENCE_ID")));
			hshValues.put("AAD_NPAD_ADD_SEQ_NO", Helper.correctNull((String) rs.getString("NPAD_ADD_SEQ_NO")));
			hshValues.put("AAD_NPAD_ADD_TYPE", Helper.correctNull((String) rs.getString("NPAD_ADD_TYPE")));
			hshValues.put("AAD_NPAD_STREET_NAME", Helper.correctNull((String) rs.getString("NPAD_STREET_NAME")));
			hshValues.put("AAD_NPAD_LANDMARK", Helper.correctNull((String) rs.getString("NPAD_LANDMARK")));
			hshValues.put("AAD_NPAD_COUNTRY_NAME", Helper.correctNull((String) rs.getString("NPAD_COUNTRY_NAME")));
			hshValues.put("AAD_NPAD_STATE_NAME", Helper.correctNull((String) rs.getString("NPAD_STATE_NAME")));
			hshValues.put("AAD_NPAD_DISTRICT_NAME", Helper.correctNull((String) rs.getString("NPAD_DISTRICT_NAME")));
			hshValues.put("AAD_NPAD_CITY_NAME", Helper.correctNull((String) rs.getString("NPAD_CITY_NAME")));
			hshValues.put("AAD_NPAD_SUB_DISTRICT", Helper.correctNull((String) rs.getString("NPAD_SUB_DISTRICT")));
			hshValues.put("AAD_NPAD_VILLAGE", Helper.correctNull((String) rs.getString("NPAD_VILLAGE")));
			hshValues.put("AAD_NPAD_PIN_CODE", Helper.correctNull((String) rs.getString("NPAD_PIN_CODE")));
			hshValues.put("AAD_NPAD_STATE_CODE", Helper.correctNull((String) rs.getString("NPAD_STATE_CODE")));
			hshValues.put("AAD_NPAD_DISTRICT_CODE", Helper.correctNull((String) rs.getString("NPAD_DISTRICT_CODE")));
			hshValues.put("AAD_NPAD_SUB_DISTRICT_CODE", Helper.correctNull((String) rs.getString("NPAD_SUB_DISTRICT_CODE")));
			hshValues.put("AAD_NPAD_VILLAGE_CODE", Helper.correctNull((String) rs.getString("NPAD_VILLAGE_CODE")));
			hshValues.put("AAD_NPAD_BLOCK_CODE", Helper.correctNull((String) rs.getString("NPAD_BLOCK_CODE")));
			hshValues.put("AAD_NPAD_BLOCK", Helper.correctNull((String) rs.getString("NPAD_BLOCK")));
			}
			if(rs != null)
			{
				rs.close();
			}
			
     }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> getBusmudrapersdetails Method : "+m);
       }
	return hshValues;
	
}


//MSME mudra Loan details
@SuppressWarnings("unchecked")
public HashMap getBusMudraloandetails(HashMap hshValues) 
{
	String strQuery ="",strRefId="";
	ResultSet rs= null;

	strRefId =  Helper.correctNull((String)hshValues.get("hidApplicantId"));

	
       try {
    
			strQuery=SQLParser.getSqlQuery("sel_busmudraloandet^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("MUDRA_ID", Helper.correctNull((String) rs.getString("MUDRA_ID")));
			hshValues.put("MUDRA_APP_REF_ID", Helper.correctNull((String) rs.getString("MUDRA_APP_REF_ID")));
			hshValues.put("MUDRA_INDUSTRY_ID", Helper.correctNull((String) rs.getString("MUDRA_INDUSTRY_ID")));
			hshValues.put("MUDRA_INDUSTRY", Helper.correctNull((String) rs.getString("MUDRA_INDUSTRY")));
			hshValues.put("MUDRA_SECTOR_ID", Helper.correctNull((String) rs.getString("MUDRA_SECTOR_ID")));
			hshValues.put("MUDRA_SECTOR", Helper.correctNull((String) rs.getString("MUDRA_SECTOR")));
			hshValues.put("MUDRA_SUBSECTOR", Helper.correctNull((String) rs.getString("MUDRA_SUBSECTOR")));
			hshValues.put("MUDRA_SUBSECTOR_ID", Helper.correctNull((String) rs.getString("MUDRA_SUBSECTOR_ID")));
			hshValues.put("MUDRA_PRD_SERVCE_DESC", Helper.correctNull((String) rs.getString("MUDRA_PRD_SERVCE_DESC")));
			hshValues.put("MUDRA_REGN_NO", Helper.correctNull((String) rs.getString("MUDRA_REGN_NO")));
			hshValues.put("UDYOG_AADHAR_MEMORANDUMNO", Helper.correctNull((String) rs.getString("UDYOG_AADHAR_MEMORANDUMNO")));
			hshValues.put("MUDRA_BUSINESS_PREMISIES_ID", Helper.correctNull((String) rs.getString("MUDRA_BUSINESS_PREMISIES_ID")));
			hshValues.put("MUDRA_BUSINESS_PREMISIES", Helper.correctNull((String) rs.getString("MUDRA_BUSINESS_PREMISIES")));
			hshValues.put("ANY_MARKETING_ARRANGMNT_ID", Helper.correctNull((String) rs.getString("ANY_MARKETING_ARRANGMNT_ID")));
			hshValues.put("ANY_MARKETING_ARRANGMNT", Helper.correctNull((String) rs.getString("ANY_MARKETING_ARRANGMNT")));
			hshValues.put("BUSINESS_ACTIVITY_EXISTNG", Helper.correctNull((String) rs.getString("BUSINESS_ACTIVITY_EXISTNG")));
			hshValues.put("BUSINESS_ACTIVITY_PROPOSD", Helper.correctNull((String) rs.getString("BUSINESS_ACTIVITY_PROPOSD")));
			hshValues.put("LOAN_AMNT_REQURD", Helper.correctNull((String) rs.getString("LOAN_AMNT_REQURD")));
			hshValues.put("MUDRA_PROMOTR_CONTRIBUTION", Helper.correctNull((String) rs.getString("MUDRA_PROMOTR_CONTRIBUTION")));
			hshValues.put("MUDRA_PURPOSE_OF_LOANID", Helper.correctNull((String) rs.getString("MUDRA_PURPOSE_OF_LOANID")));
			hshValues.put("MUDRA_PURPOSE_OF_LOAN", Helper.correctNull((String) rs.getString("MUDRA_PURPOSE_OF_LOAN")));
			hshValues.put("MUDRA_AVG_MONTHLY_SALES", Helper.correctNull((String) rs.getString("MUDRA_AVG_MONTHLY_SALES")));
			hshValues.put("MUDRA_RAW_MATERIALS", Helper.correctNull((String) rs.getString("MUDRA_RAW_MATERIALS")));
			hshValues.put("MUDRA_WAGES", Helper.correctNull((String) rs.getString("MUDRA_WAGES")));
			hshValues.put("MUDRA_DRAWINGS_SUSTENANCE", Helper.correctNull((String) rs.getString("MUDRA_DRAWINGS_SUSTENANCE")));
			hshValues.put("MUDRA_OTHER_EXPENSES", Helper.correctNull((String) rs.getString("MUDRA_OTHER_EXPENSES")));
			hshValues.put("TOT_EXPNS_OF_WORKING_CAPTL", Helper.correctNull((String) rs.getString("TOT_EXPNS_OF_WORKING_CAPTL")));
			hshValues.put("MUDRA_MONTHLY_SALES", Helper.correctNull((String) rs.getString("MUDRA_MONTHLY_SALES")));
			hshValues.put("PROJECTD_TURNOVR", Helper.correctNull((String) rs.getString("PROJECTD_TURNOVR")));
			hshValues.put("PROJECTED_PROFIT", Helper.correctNull((String) rs.getString("PROJECTED_PROFIT")));
			hshValues.put("COMMERCIAL_OPERATN_DATE", Helper.correctNull((String) rs.getString("COMMERCIAL_OPERATN_DATE")));
			hshValues.put("MUDRA_ID_DRUG_LICENSE", Helper.correctNull((String) rs.getString("MUDRA_ID_DRUG_LICENSE")));
			hshValues.put("IS_STATUTORY_DUES", Helper.correctNull((String) rs.getString("IS_STATUTORY_DUES")));
			hshValues.put("TOT_EXPNS_OF_ASTS_ACQT", Helper.correctNull((String) rs.getString("TOT_EXPNS_OF_ASTS_ACQT")));
			hshValues.put("MUDRA_TENURE", Helper.correctNull((String) rs.getString("MUDRA_TENURE")));
			}
			if(rs != null)
			{
				rs.close();
			}
			
			strQuery=SQLParser.getSqlQuery("sel_busmudraloanasstacqdet^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("MUDRA_MACHINE_TYPE", Helper.correctNull((String) rs.getString("MUDRA_MACHINE_TYPE")));
			hshValues.put("MUDRA_PURPOSE_OF_REQUIRMNT", Helper.correctNull((String) rs.getString("MUDRA_PURPOSE_OF_REQUIRMNT")));
			hshValues.put("MUDRA_SUPPLIER_NAME", Helper.correctNull((String) rs.getString("MUDRA_SUPPLIER_NAME")));
			hshValues.put("MUDRA_MACHINE_COST", Helper.correctNull((String) rs.getString("MUDRA_MACHINE_COST")));
			}
			if(rs != null)
			{
				rs.close();
			}
			
       }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> getBusMudraloandetails Method : "+m);
       }
	return hshValues;
	
}

//MSME standindia loan details
@SuppressWarnings("unchecked")
public HashMap getBusstandindialoandet(HashMap hshValues) 
{
	String strQuery ="",strRefId="";
	ResultSet rs= null;

	strRefId =  Helper.correctNull((String)hshValues.get("hidApplicantId"));


       try {
    
    	   strQuery=SQLParser.getSqlQuery("sel_busstandloandetails^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("NPSL_IND", Helper.correctNull((String) rs.getString("NPSL_IND")));
			hshValues.put("NPSL_SECTOR", Helper.correctNull((String) rs.getString("NPSL_SECTOR")));
			hshValues.put("NPSL_SUBSEC", Helper.correctNull((String) rs.getString("NPSL_SUBSEC")));
			hshValues.put("NPSL_UDYOGNO", Helper.correctNull((String) rs.getString("NPSL_UDYOGNO")));
			hshValues.put("NPSL_BUS_PREM", Helper.correctNull((String) rs.getString("NPSL_BUS_PREM")));
			hshValues.put("NPSL_BUS_PREM_ID", Helper.correctNull((String) rs.getString("NPSL_BUS_PREM_ID")));
			hshValues.put("NPSL_PRO_CONTRBN", Helper.correctNull((String) rs.getString("NPSL_PRO_CONTRBN")));
			hshValues.put("NPSL_PRD_SER_DES", Helper.correctNull((String) rs.getString("NPSL_PRD_SER_DES")));
			hshValues.put("NPSL_EXIS_BUS_ACT", Helper.correctNull((String) rs.getString("NPSL_EXIS_BUS_ACT")));
			hshValues.put("NPSL_PRO_BUS_ACT", Helper.correctNull((String) rs.getString("NPSL_PRO_BUS_ACT")));
			hshValues.put("NPSL_TOT_LOAN", Helper.correctNull((String) rs.getString("NPSL_TOT_LOAN")));
			hshValues.put("NPSL_TOT_MAC_COST", Helper.correctNull((String) rs.getString("NPSL_TOT_MAC_COST")));
		
			}
			if(rs != null)
			{
				rs.close();
			}
			
			//stand india assest details
			strQuery=SQLParser.getSqlQuery("sel_busstandassetdet^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("NPSM_MAC_TYPE", Helper.correctNull((String) rs.getString("NPSM_MAC_TYPE")));
			hshValues.put("NPSM_REQ_PURP", Helper.correctNull((String) rs.getString("NPSM_REQ_PURP")));
			hshValues.put("NPSM_SUPP_NAME", Helper.correctNull((String) rs.getString("NPSM_SUPP_NAME")));
			hshValues.put("NPSM_TOT_MAC_COST", Helper.correctNull((String) rs.getString("NPSM_TOT_MAC_COST")));
					
			}
			if(rs != null)
			{
				rs.close();
			}
		
       }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> getBusstandindialoandet Method : "+m);
       }
	return hshValues;
	
}

@SuppressWarnings("unchecked")
public HashMap getAssoConcernDetails(HashMap hshValues) 
{
	String strQuery ="",strRefId="",AddSeqNo="";
	ResultSet rs= null;

	strRefId =  Helper.correctNull((String)hshValues.get("hidApplicantId"));

	
       try {
			strQuery=SQLParser.getSqlQuery("getAssoConcernDetails^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("NPACD_ROW_ID", Helper.correctNull((String) rs.getString("NPACD_ROW_ID")));
			hshValues.put("NPACD_ID", Helper.correctNull((String) rs.getString("NPACD_ID")));
			hshValues.put("NPACD_APPID", Helper.correctNull((String) rs.getString("NPACD_APPID")));
			hshValues.put("NPACD_APPLICATION_REF_ID", Helper.correctNull((String) rs.getString("NPACD_APPLICATION_REF_ID")));
			hshValues.put("NPACD_ANY_ASSOCIATE_CONCERN", Helper.correctNull((String) rs.getString("NPACD_ANY_ASSOCIATE_CONCERN")));
			hshValues.put("NPACD_NOOF_ASSOCIATE_CONCERN", Helper.correctNull((String) rs.getString("NPACD_NOOF_ASSOCIATE_CONCERN")));
			hshValues.put("NPACD_ASSOCIATE_NAME", Helper.correctNull((String) rs.getString("NPACD_ASSOCIATE_NAME")));
			hshValues.put("NPACD_BANKING_WITH", Helper.correctNull((String) rs.getString("NPACD_BANKING_WITH")));
			hshValues.put("NPACD_BANKING_WITH_ID", Helper.correctNull((String) rs.getString("NPACD_BANKING_WITH_ID")));
			hshValues.put("NPACD_STAKE", Helper.correctNull((String) rs.getString("NPACD_STAKE")));
			hshValues.put("NPACD_CONSTITUTION", Helper.correctNull((String) rs.getString("NPACD_CONSTITUTION")));
			hshValues.put("NPACD_CONSTITUTION_ID", Helper.correctNull((String) rs.getString("NPACD_CONSTITUTION_ID")));
			hshValues.put("NPACD_ASS_ADD_SEQ_NO", Helper.correctNull((String) rs.getString("NPACD_ASS_ADD_SEQ_NO")));
			AddSeqNo = Helper.correctNull((String) rs.getString("NPACD_ASS_ADD_SEQ_NO"));
			}
			if(rs != null)
			{
				rs.close();
			}
			if(!AddSeqNo.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("getAddressDetails^"+strRefId+"^"+AddSeqNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
				hshValues.put("NPAD_ID", Helper.correctNull((String) rs.getString("NPAD_ID")));
				hshValues.put("NPAD_APPLICATION_REFERENCE_ID", Helper.correctNull((String) rs.getString("NPAD_APPLICATION_REFERENCE_ID")));
				hshValues.put("NPAD_ADD_SEQ_NO", Helper.correctNull((String) rs.getString("NPAD_ADD_SEQ_NO")));
				hshValues.put("NPAD_ADD_TYPE", Helper.correctNull((String) rs.getString("NPAD_ADD_TYPE")));
				hshValues.put("NPAD_STREET_NAME", Helper.correctNull((String) rs.getString("NPAD_STREET_NAME")));
				hshValues.put("NPAD_LANDMARK", Helper.correctNull((String) rs.getString("NPAD_LANDMARK")));
				hshValues.put("NPAD_COUNTRY_NAME", Helper.correctNull((String) rs.getString("NPAD_COUNTRY_NAME")));
				hshValues.put("NPAD_STATE_NAME", Helper.correctNull((String) rs.getString("NPAD_STATE_NAME")));
				hshValues.put("NPAD_DISTRICT_NAME", Helper.correctNull((String) rs.getString("NPAD_DISTRICT_NAME")));
				hshValues.put("NPAD_CITY_NAME", Helper.correctNull((String) rs.getString("NPAD_CITY_NAME")));
				hshValues.put("NPAD_SUB_DISTRICT", Helper.correctNull((String) rs.getString("NPAD_SUB_DISTRICT")));
				hshValues.put("NPAD_VILLAGE", Helper.correctNull((String) rs.getString("NPAD_VILLAGE")));
				hshValues.put("NPAD_PIN_CODE", Helper.correctNull((String) rs.getString("NPAD_PIN_CODE")));
				hshValues.put("NPAD_STATE_CODE", Helper.correctNull((String) rs.getString("NPAD_STATE_CODE")));
				hshValues.put("NPAD_DISTRICT_CODE", Helper.correctNull((String) rs.getString("NPAD_DISTRICT_CODE")));
				hshValues.put("NPAD_SUB_DISTRICT_CODE", Helper.correctNull((String) rs.getString("NPAD_SUB_DISTRICT_CODE")));
				hshValues.put("NPAD_VILLAGE_CODE", Helper.correctNull((String) rs.getString("NPAD_VILLAGE_CODE")));
				hshValues.put("NPAD_BLOCK_CODE", Helper.correctNull((String) rs.getString("NPAD_BLOCK_CODE")));
				hshValues.put("NPAD_BLOCK", Helper.correctNull((String) rs.getString("NPAD_BLOCK")));
			}
			
			}
			if(rs != null)
			{
				rs.close();
			}
			
       }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> getAssoConcernDetails Method : "+m);
       }
	return hshValues;
	
}

//mudra gst details
@SuppressWarnings("unchecked")
public HashMap getBusmudragstdetails(HashMap hshValues) 
{
	String strQuery ="",strRefId="";
	ResultSet rs= null;

	strRefId =  Helper.correctNull((String)hshValues.get("hidApplicantId"));

       try {
    
    	   strQuery=SQLParser.getSqlQuery("sel_busgstcreditdet^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("NGCDI_ID", Helper.correctNull((String) rs.getString("NGCDI_ID")));
			hshValues.put("NGCDI_APP_REF_ID", Helper.correctNull((String) rs.getString("NGCDI_APP_REF_ID")));
			hshValues.put("NGCDI_MONTHS", Helper.correctNull((String) rs.getString("NGCDI_MONTHS")));
			hshValues.put("NGCDI_CREDIT_NOTE", Helper.correctNull((String) rs.getString("NGCDI_CREDIT_NOTE")));
			hshValues.put("NGCDI_SALES", Helper.correctNull((String) rs.getString("NGCDI_SALES")));
			hshValues.put("NGCDI_DEBIT_NOTE", Helper.correctNull((String) rs.getString("NGCDI_DEBIT_NOTE")));
			hshValues.put("NGCDI_PURCHASE", Helper.correctNull((String) rs.getString("NGCDI_PURCHASE")));
			hshValues.put("NGCDI_TOTAL", Helper.correctNull((String) rs.getString("NGCDI_TOTAL")));
			}
			if(rs != null)
			{
				rs.close();
			}
			
			//nogst or composite gst details
			strQuery=SQLParser.getSqlQuery("sel_busgstcompositedet^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
			hshValues.put("NGD_APP_REF_ID", Helper.correctNull((String) rs.getString("NGD_APP_REF_ID")));
			hshValues.put("NGD_GST_IN", Helper.correctNull((String) rs.getString("NGD_GST_IN")));
			hshValues.put("NGD_GST_TYPE", Helper.correctNull((String) rs.getString("NGD_GST_TYPE")));
			hshValues.put("NGD_GST_SUB_TYPE", Helper.correctNull((String) rs.getString("NGD_GST_SUB_TYPE")));
			hshValues.put("NGD_ENTITY_NAME", Helper.correctNull((String) rs.getString("NGD_ENTITY_NAME")));
			hshValues.put("NGD_PAN", Helper.correctNull((String) rs.getString("NGD_PAN")));
			hshValues.put("NGD_CITY", Helper.correctNull((String) rs.getString("NGD_CITY")));
			hshValues.put("NGD_STATE", Helper.correctNull((String) rs.getString("NGD_STATE")));
			hshValues.put("NGD_CONTITUTION", Helper.correctNull((String) rs.getString("NGD_CONTITUTION")));
			hshValues.put("NGD_HIGHEST_SALES_CUST", Helper.correctNull((String) rs.getString("NGD_HIGHEST_SALES_CUST")));
			hshValues.put("NGD_NUM_CUST", Helper.correctNull((String) rs.getString("NGD_NUM_CUST")));
			hshValues.put("NGD_REG_DATE", Helper.correctNull((String) rs.getString("NGD_REG_DATE")));
					
			}
			if(rs != null)
			{
				rs.close();
			}
			
			//inward gst details
			strQuery=SQLParser.getSqlQuery("sel_busgstinwarddet^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
			hshValues.put("NGISD_APP_REF_ID", Helper.correctNull((String) rs.getString("NGISD_APP_REF_ID")));
			hshValues.put("NGISD_MONTHS", Helper.correctNull((String) rs.getString("NGISD_MONTHS")));
			hshValues.put("NGISD_GET_GST", Helper.correctNull((String) rs.getString("NGISD_GET_GST")));
			hshValues.put("NGISD_GET_NONGST", Helper.correctNull((String) rs.getString("NGISD_GET_NONGST")));
			hshValues.put("NGISD_TOTAL", Helper.correctNull((String) rs.getString("NGISD_TOTAL")));
			hshValues.put("NGISD_INTER_ST_SPPLIER_GST", Helper.correctNull((String) rs.getString("NGISD_INTER_ST_SPPLIER_GST")));
			hshValues.put("NGISD_INTRA_ST_SPPLIER_GST", Helper.correctNull((String) rs.getString("NGISD_INTRA_ST_SPPLIER_GST")));
			hshValues.put("NGISD_INTER_ST_SPPLIER_NONGST", Helper.correctNull((String) rs.getString("NGISD_INTER_ST_SPPLIER_NONGST")));
			hshValues.put("NGISD_INTRA_ST_SPPLIER_NONGST", Helper.correctNull((String) rs.getString("NGISD_INTRA_ST_SPPLIER_NONGST")));
	
			}
			if(rs != null)
			{
				rs.close();
			}
			//gst key observation list	
			
			strQuery=SQLParser.getSqlQuery("sel_busgstkeyobservdet^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
			hshValues.put("NGKO_APP_REF_ID", Helper.correctNull((String) rs.getString("NGKO_APP_REF_ID")));
			hshValues.put("NGKO_OUTOF_TOTAL_SALES", Helper.correctNull((String) rs.getString("NGKO_OUTOF_TOTAL_SALES")));
			hshValues.put("NGKO_MARGIN_SALES", Helper.correctNull((String) rs.getString("NGKO_MARGIN_SALES")));
			hshValues.put("NGKO_CUST_CONCENTRATION", Helper.correctNull((String) rs.getString("NGKO_CUST_CONCENTRATION")));
			hshValues.put("NGKO_SUPPLIER_CONCENTRATION", Helper.correctNull((String) rs.getString("NGKO_SUPPLIER_CONCENTRATION")));
			hshValues.put("NGKO_OUTOF_TOTAL_INWARD", Helper.correctNull((String) rs.getString("NGKO_OUTOF_TOTAL_INWARD")));
			hshValues.put("NGKO_AVERAGE_SALES", Helper.correctNull((String) rs.getString("NGKO_AVERAGE_SALES")));
			hshValues.put("NGKO_MEDIAM_SALES", Helper.correctNull((String) rs.getString("NGKO_MEDIAM_SALES")));
			hshValues.put("NGKO_AVERAGE_PURCHASE", Helper.correctNull((String) rs.getString("NGKO_AVERAGE_PURCHASE")));
			hshValues.put("NGKO_MEDIAM_PURCHASE", Helper.correctNull((String) rs.getString("NGKO_MEDIAM_PURCHASE")));
			hshValues.put("NGKO_HIGHEST_SALES", Helper.correctNull((String) rs.getString("NGKO_HIGHEST_SALES")));
			hshValues.put("NGKO_HIGHEST_PURCHASE", Helper.correctNull((String) rs.getString("NGKO_HIGHEST_PURCHASE")));
			hshValues.put("NGKO_TOTAL_CREDIT", Helper.correctNull((String) rs.getString("NGKO_TOTAL_CREDIT")));
			hshValues.put("NGKO_TOTAL_DEBIT", Helper.correctNull((String) rs.getString("NGKO_TOTAL_DEBIT")));
			hshValues.put("NGKO_ORGANISATION_NAME", Helper.correctNull((String) rs.getString("NGKO_ORGANISATION_NAME")));
			
			}
			if(rs != null)
			{
				rs.close();
			}	
			
			//gst monthwise purchase list
			strQuery=SQLParser.getSqlQuery("sel_busgstpurchasedet^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("NGMWP_APP_REF_ID", Helper.correctNull((String) rs.getString("NGMWP_APP_REF_ID")));
			hshValues.put("NGMWP_MONTHS", Helper.correctNull((String) rs.getString("NGMWP_MONTHS")));
			hshValues.put("NGMWP_B2B", Helper.correctNull((String) rs.getString("NGMWP_B2B")));
			hshValues.put("NGMWP_TOTAL", Helper.correctNull((String) rs.getString("NGMWP_TOTAL")));
			}
			if(rs != null)
			{
				rs.close();
			}	
		    //gst month wise sale list	
			strQuery=SQLParser.getSqlQuery("sel_busgstsaledet^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("NGMWS_APP_REF_ID", Helper.correctNull((String) rs.getString("NGMWS_APP_REF_ID")));
			hshValues.put("NGMWS_MONTHS", Helper.correctNull((String) rs.getString("NGMWS_MONTHS")));
			hshValues.put("NGMWS_B2B", Helper.correctNull((String) rs.getString("NGMWS_B2B")));
			hshValues.put("NGMWS_B2CL", Helper.correctNull((String) rs.getString("NGMWS_B2CL")));
			hshValues.put("NGMWS_B2CS", Helper.correctNull((String) rs.getString("NGMWS_B2CS")));
			hshValues.put("NGMWS_EXPORTS", Helper.correctNull((String) rs.getString("NGMWS_EXPORTS")));
			hshValues.put("NGMWS_NILRATED_GOODS", Helper.correctNull((String) rs.getString("NGMWS_NILRATED_GOODS")));
			hshValues.put("NGMWS_EXEMPTED_GOODS", Helper.correctNull((String) rs.getString("NGMWS_EXEMPTED_GOODS")));
			hshValues.put("NGMWS_NONGST_OUTWARD_SUPPLIES", Helper.correctNull((String) rs.getString("NGMWS_NONGST_OUTWARD_SUPPLIES")));
			hshValues.put("NGMWS_TOTAL", Helper.correctNull((String) rs.getString("NGMWS_TOTAL")));
			hshValues.put("NGMWS_INTER_COMPANY_SALES", Helper.correctNull((String) rs.getString("NGMWS_INTER_COMPANY_SALES")));
			}
			if(rs != null)
			{
				rs.close();
			}		
			
		//gst overview list	
			strQuery=SQLParser.getSqlQuery("sel_busgstsaledet^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("NGO_APP_REF_ID", Helper.correctNull((String) rs.getString("NGO_APP_REF_ID")));
			hshValues.put("NGO_TOTAL_MONTHS", Helper.correctNull((String) rs.getString("NGO_TOTAL_MONTHS")));
			hshValues.put("NGO_TOTAL_CUSTOMERS", Helper.correctNull((String) rs.getString("NGO_TOTAL_CUSTOMERS")));
			hshValues.put("NGO_TOTAL_SUPLIERS", Helper.correctNull((String) rs.getString("NGO_TOTAL_SUPLIERS")));
			hshValues.put("NGO_TOTAL_SALES_INVOICE", Helper.correctNull((String) rs.getString("NGO_TOTAL_SALES_INVOICE")));
			hshValues.put("NGO_B2B", Helper.correctNull((String) rs.getString("NGO_B2B")));
			hshValues.put("NGO_B2CL", Helper.correctNull((String) rs.getString("NGO_B2CL")));
			hshValues.put("NGO_B2CS", Helper.correctNull((String) rs.getString("NGO_B2CS")));
			hshValues.put("NGO_EXPORTS", Helper.correctNull((String) rs.getString("NGO_EXPORTS")));
			hshValues.put("NGO_NILRATED_GOODS", Helper.correctNull((String) rs.getString("NGO_NILRATED_GOODS")));
			hshValues.put("NGO_EXEMPTED_GOODS", Helper.correctNull((String) rs.getString("NGO_EXEMPTED_GOODS")));
			hshValues.put("NGO_NONGST_OUT_SUPPLIES", Helper.correctNull((String) rs.getString("NGO_NONGST_OUT_SUPPLIES")));
			hshValues.put("NGO_TOTAL_PURCHASER", Helper.correctNull((String) rs.getString("NGO_TOTAL_PURCHASER")));
			hshValues.put("NGO_DIFF_SALES_MIN_PUR", Helper.correctNull((String) rs.getString("NGO_DIFF_SALES_MIN_PUR")));
			hshValues.put("NGO_MARGIN_INPERCENTAGE", Helper.correctNull((String) rs.getString("NGO_MARGIN_INPERCENTAGE")));
			}
			if(rs != null)
			{
				rs.close();
			}		
		
			//gst Top Five Customer List
			strQuery=SQLParser.getSqlQuery("sel_busgstcustomerdet^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("NGTFC_APP_REF_ID", Helper.correctNull((String) rs.getString("NGTFC_APP_REF_ID")));
			hshValues.put("NGTFC_GST_IN", Helper.correctNull((String) rs.getString("NGTFC_GST_IN")));
			hshValues.put("NGTFC_STATE_NAME", Helper.correctNull((String) rs.getString("NGTFC_STATE_NAME")));
			hshValues.put("NGTFC_TOTAL_INVOICE", Helper.correctNull((String) rs.getString("NGTFC_TOTAL_INVOICE")));
			hshValues.put("NGTFC_INVOICE_VALUE", Helper.correctNull((String) rs.getString("NGTFC_INVOICE_VALUE")));
			hshValues.put("NGTFC_TAXABLE_VALUE", Helper.correctNull((String) rs.getString("NGTFC_TAXABLE_VALUE")));
			hshValues.put("NGTFC_PERCENTAGE_SALES", Helper.correctNull((String) rs.getString("NGTFC_PERCENTAGE_SALES")));
			}
			if(rs != null)
			{
				rs.close();
			}	
		
			//gst Top Five Supplier List
			strQuery=SQLParser.getSqlQuery("sel_busgstsupplierlist^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("NGTFS_APP_REF_ID", Helper.correctNull((String) rs.getString("NGTFS_APP_REF_ID")));
			hshValues.put("NGTFS_GST_IN", Helper.correctNull((String) rs.getString("NGTFS_GST_IN")));
			hshValues.put("NGTFS_STATE_NAME", Helper.correctNull((String) rs.getString("NGTFS_STATE_NAME")));
			hshValues.put("NGTFS_TOTAL_INVOICE", Helper.correctNull((String) rs.getString("NGTFS_TOTAL_INVOICE")));
			hshValues.put("NGTFS_INVOICE_VALUE", Helper.correctNull((String) rs.getString("NGTFS_INVOICE_VALUE")));
			hshValues.put("NGTFS_TAXABLE_VALUE", Helper.correctNull((String) rs.getString("NGTFS_TAXABLE_VALUE")));
			hshValues.put("NGTFS_PERCENTAGE_PURCHASE", Helper.correctNull((String) rs.getString("NGTFS_PERCENTAGE_PURCHASE")));
			}
			if(rs != null)
			{
				rs.close();
			}	
       }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> getBusstandindialoandet Method : "+m);
       }
	return hshValues;
	
}

//MSME standindia personal details
@SuppressWarnings("unchecked")
public HashMap getBusstandindiapersonaldet(HashMap hshValues) 
{
	String strQuery ="",strRefId="";
	ResultSet rs= null;
	

	
	strRefId =  Helper.correctNull((String)hshValues.get("hidApplicantId"));
	hshValues.put("Refno",strRefId);
       try {
    	   String SchemeId="";
			strQuery = SQLParser.getSqlQuery("sel_applicationscheme_np^"+strRefId);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				SchemeId=Helper.correctNull((String)rs.getString("NPDT_NP_SCHEME_NAME"));
			}
			 hshValues.put("POP_SCHEME_ID",SchemeId);	    	   
		    

    
    	    strQuery=SQLParser.getSqlQuery("sel_busstandinddetails^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("APDP_PAN", Helper.correctNull((String) rs.getString("APDP_PAN")));
			hshValues.put("APDP_FIRST_NAME", Helper.correctNull((String) rs.getString("APDP_FIRST_NAME")));
			hshValues.put("APDP_LAST_NAME", Helper.correctNull((String) rs.getString("APDP_LAST_NAME")));
			hshValues.put("APDP_MIDDLE_NAME", Helper.correctNull((String) rs.getString("APDP_MIDDLE_NAME")));
			hshValues.put("APDP_ENTITY_NAME", Helper.correctNull((String) rs.getString("APDP_ENTITY_NAME")));
			hshValues.put("APDP_ENTITY_TYPE", Helper.correctNull((String) rs.getString("APDP_ENTITY_TYPE")));
            }
			if(rs != null)
			{
				rs.close();
			}
			
			strQuery=SQLParser.getSqlQuery("sel_busstandindloandetails^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("NPSL_ROW_ID", Helper.correctNull((String) rs.getString("NPSL_ROW_ID")));
			hshValues.put("NPSL_ID", Helper.correctNull((String) rs.getString("NPSL_ID")));
			hshValues.put("NPSL_APP_REFID", Helper.correctNull((String) rs.getString("NPSL_APP_REFID")));
			hshValues.put("NPSL_IND", Helper.correctNull((String) rs.getString("NPSL_IND")));
			hshValues.put("NPSL_SECTOR", Helper.correctNull((String) rs.getString("NPSL_SECTOR")));
			hshValues.put("NPSL_SUBSEC", Helper.correctNull((String) rs.getString("NPSL_SUBSEC")));
			hshValues.put("NPSL_UDYOGNO", Helper.correctNull((String) rs.getString("NPSL_UDYOGNO")));
			hshValues.put("NPSL_BUS_PREM", Helper.correctNull((String) rs.getString("NPSL_BUS_PREM")));
			hshValues.put("NPSL_BUS_PREM_ID", Helper.correctNull((String) rs.getString("NPSL_BUS_PREM_ID")));
			hshValues.put("NPSL_PRO_CONTRBN", Helper.correctNull((String) rs.getString("NPSL_PRO_CONTRBN")));
			hshValues.put("NPSL_PRD_SER_DES", Helper.correctNull((String) rs.getString("NPSL_PRD_SER_DES")));
			hshValues.put("NPSL_EXIS_BUS_ACT", Helper.correctNull((String) rs.getString("NPSL_EXIS_BUS_ACT")));
			hshValues.put("NPSL_PRO_BUS_ACT", Helper.correctNull((String) rs.getString("NPSL_PRO_BUS_ACT")));
			hshValues.put("NPSL_TOT_LOAN", Helper.correctNull((String) rs.getString("NPSL_TOT_LOAN")));
			hshValues.put("NPSL_TOT_MAC_COST", Helper.correctNull((String) rs.getString("NPSL_TOT_MAC_COST")));
            }
			if(rs != null)
			{
				rs.close();
			}
			
			strQuery=SQLParser.getSqlQuery("sel_busstandindloanmapdetails^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("NPSP_ROW_ID", Helper.correctNull((String) rs.getString("NPSP_ROW_ID")));
			hshValues.put("NPSP_ID", Helper.correctNull((String) rs.getString("NPSP_ID")));
			hshValues.put("NPSP_APP_REF_ID", Helper.correctNull((String) rs.getString("NPSP_APP_REF_ID")));
			hshValues.put("NPSP_FAC_TYPE_ID", Helper.correctNull((String) rs.getString("NPSP_FAC_TYPE_ID")));
			hshValues.put("NPSP_FAC_TYPE", Helper.correctNull((String) rs.getString("NPSP_FAC_TYPE")));
			hshValues.put("NPSP_REQ_AMT", Helper.correctNull((String) rs.getString("NPSP_REQ_AMT")));
			hshValues.put("NPSP_PURPOSE", Helper.correctNull((String) rs.getString("NPSP_PURPOSE")));
			hshValues.put("NPSP_PRIM_SEC_OFF", Helper.correctNull((String) rs.getString("NPSP_PRIM_SEC_OFF")));
			hshValues.put("NPSP_COLL_OFF", Helper.correctNull((String) rs.getString("NPSP_COLL_OFF")));
			hshValues.put("NPSP_COLL_OFF_ID", Helper.correctNull((String) rs.getString("NPSP_COLL_OFF_ID")));
			hshValues.put("NPSP_COLL_DET", Helper.correctNull((String) rs.getString("NPSP_COLL_DET")));
			hshValues.put("NPSP_SEQ_NO", Helper.correctNull((String) rs.getString("NPSP_SEQ_NO")));
            }
			if(rs != null)
			{
				rs.close();
			}
			
			strQuery=SQLParser.getSqlQuery("sel_busstandindMachidetails^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("NPSM_ROW_ID", Helper.correctNull((String) rs.getString("NPSM_ROW_ID")));
			hshValues.put("NPSM_ID", Helper.correctNull((String) rs.getString("NPSM_ID")));
			hshValues.put("NPSM_APP_REF_ID", Helper.correctNull((String) rs.getString("NPSM_APP_REF_ID")));
			hshValues.put("NPSM_MAC_TYPE", Helper.correctNull((String) rs.getString("NPSM_MAC_TYPE")));
			hshValues.put("NPSM_REQ_PURP", Helper.correctNull((String) rs.getString("NPSM_REQ_PURP")));
			hshValues.put("NPSM_IMP_INDI", Helper.correctNull((String) rs.getString("NPSM_IMP_INDI")));
			hshValues.put("NPSM_IMP_INDI_ID", Helper.correctNull((String) rs.getString("NPSM_IMP_INDI_ID")));
			hshValues.put("NPSM_SUPP_NAME", Helper.correctNull((String) rs.getString("NPSM_SUPP_NAME")));
			hshValues.put("NPSM_BASIC_COST", Helper.correctNull((String) rs.getString("NPSM_BASIC_COST")));
			hshValues.put("NPSM_FREIGHT", Helper.correctNull((String) rs.getString("NPSM_FREIGHT")));
			hshValues.put("NPSM_INSURANCE", Helper.correctNull((String) rs.getString("NPSM_INSURANCE")));
			hshValues.put("NPSM_CUST_DUTY", Helper.correctNull((String) rs.getString("NPSM_CUST_DUTY")));
			hshValues.put("NPSM_TOT_MAC_COST", Helper.correctNull((String) rs.getString("NPSM_TOT_MAC_COST")));
			hshValues.put("NPSM_SEQ_NO", Helper.correctNull((String) rs.getString("NPSM_SEQ_NO")));
            }
			if(rs != null)
			{
				rs.close();
			}
			
			strQuery=SQLParser.getSqlQuery("sel_busstandindStatudetails^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("NPSS_ROW_ID", Helper.correctNull((String) rs.getString("NPSS_ROW_ID")));
			hshValues.put("NPSS_ID", Helper.correctNull((String) rs.getString("NPSS_ID")));
			hshValues.put("NPSS_APP_REF_ID", Helper.correctNull((String) rs.getString("NPSS_APP_REF_ID")));
			hshValues.put("NPSS_TYPE_ID", Helper.correctNull((String) rs.getString("NPSS_TYPE_ID")));
			hshValues.put("NPSS_TYPE_NAME", Helper.correctNull((String) rs.getString("NPSS_TYPE_NAME")));
			hshValues.put("NPSS_COMP_ID", Helper.correctNull((String) rs.getString("NPSS_COMP_ID")));
			hshValues.put("NPSS_COMP", Helper.correctNull((String) rs.getString("NPSS_COMP")));
			hshValues.put("NPSS_REG_DATE", Helper.correctNull((String) rs.getString("NPSS_REG_DATE")));
			hshValues.put("NPSS_REG_NO", Helper.correctNull((String) rs.getString("NPSS_REG_NO")));
			hshValues.put("NPSS_DRUG_NO", Helper.correctNull((String) rs.getString("NPSS_DRUG_NO")));
			hshValues.put("NPSS_SEQ_NO", Helper.correctNull((String) rs.getString("NPSS_SEQ_NO")));
			hshValues.put("NPSS_AMOUNT", Helper.correctNull((String) rs.getString("NPSS_AMOUNT")));
            }
			if(rs != null)
			{
				rs.close();
			}
       }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> getBusstandindialoandet Method : "+m);
       }
	return hshValues;
	
}



@SuppressWarnings("unchecked")
public HashMap getNULMPersonalDetails(HashMap hshValues) 
{
	String strQuery = "";
	ResultSet rs = null;
	String AppId = Helper.correctNull((String)hshValues.get("hidApplicantId"));
	String popSchemeId = Helper.correctNull((String)hshValues.get("hidpopSchemeId"));
	
	
	hshValues.put("Refno",AppId);	    	   
  
	String AddSeqNo="",CurrAddSeqNo="";
       try {
    	   
    	 String SchemeId="";
			strQuery = SQLParser.getSqlQuery("sel_applicationscheme_np^"+AppId);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				SchemeId=Helper.correctNull((String)rs.getString("NPDT_NP_SCHEME_NAME"));
			}
			 hshValues.put("POP_SCHEME_ID",SchemeId);	    	   
		    

    	   strQuery = SQLParser.getSqlQuery("getPersonalDetails_NPUM^"+AppId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				//hshValues.put("NPLPD_ROW_ID", Helper.correctNull((String) rs.getString("NPLPD_ROW_ID")));
				hshValues.put("NPLPD_APP_REF_ID", Helper.correctNull((String) rs.getString("NPLPD_APP_REF_ID")));
				hshValues.put("NPLPD_APPID", Helper.correctNull((String) rs.getString("NPLPD_APPID")));
				hshValues.put("NPLPD_TRAINED_U_SCH", Helper.correctNull((String) rs.getString("NPLPD_TRAINED_U_SCH")));
				hshValues.put("NPLPD_BENF_CAT", Helper.correctNull((String) rs.getString("NPLPD_BENF_CAT")));
				hshValues.put("NPLPD_MAN_SCAVEN_ID", Helper.correctNull((String) rs.getString("NPLPD_MAN_SCAVEN_ID")));
				hshValues.put("NPLPD_TRAINING_DET", Helper.correctNull((String) rs.getString("NPLPD_TRAINING_DET")));
				hshValues.put("NPLPD_OTH_BENF_CAT", Helper.correctNull((String) rs.getString("NPLPD_OTH_BENF_CAT")));
				hshValues.put("NPLPD_GENDER_ID", Helper.correctNull((String) rs.getString("NPLPD_GENDER_ID")));
				hshValues.put("NPLPD_SAL_ID", Helper.correctNull((String) rs.getString("NPLPD_SAL_ID")));
				hshValues.put("NPLPD_SOC_CAT_ID", Helper.correctNull((String) rs.getString("NPLPD_SOC_CAT_ID")));
				hshValues.put("NPLPD_EDU_QUAL_ID", Helper.correctNull((String) rs.getString("NPLPD_EDU_QUAL_ID")));
				hshValues.put("NPLPD_TRA_U_SCH_ID", Helper.correctNull((String) rs.getString("NPLPD_TRA_U_SCH_ID")));
				hshValues.put("NPLPD_RELN_ID", Helper.correctNull((String) rs.getString("NPLPD_RELN_ID")));
				hshValues.put("NPLPD_BENF_CAT_ID", Helper.correctNull((String) rs.getString("NPLPD_BENF_CAT_ID")));
				hshValues.put("NPLPD_LHPD_PAN", Helper.correctNull((String) rs.getString("NPLPD_LHPD_PAN")));
				hshValues.put("NPLPD_LHPD_F_NAME", Helper.correctNull((String) rs.getString("NPLPD_LHPD_F_NAME")));
				hshValues.put("NPLPD_LHPD_L_NAME", Helper.correctNull((String) rs.getString("NPLPD_LHPD_L_NAME")));
				hshValues.put("NPLPD_LHPD_M_NAME", Helper.correctNull((String) rs.getString("NPLPD_LHPD_M_NAME")));
				hshValues.put("NPLPD_LHPD_ENT_NAME", Helper.correctNull((String) rs.getString("NPLPD_LHPD_ENT_NAME")));
				hshValues.put("NPLPD_LHPD_ENT_TYPE", Helper.correctNull((String) rs.getString("NPLPD_LHPD_ENT_TYPE")));
				hshValues.put("NPLPD_MINORITYID", Helper.correctNull((String) rs.getString("NPLPD_MINORITYID")));
				hshValues.put("NPLPD_MINORITY", Helper.correctNull((String) rs.getString("NPLPD_MINORITY")));
				hshValues.put("NPLPD_ALT_MOB", Helper.correctNull((String) rs.getString("NPLPD_ALT_MOB")));
				hshValues.put("NPLPD_IS_HANDICAP", Helper.correctNull((String) rs.getString("NPLPD_IS_HANDICAP")));
				hshValues.put("NPLPD_NO_DEPENDANTS", Helper.correctNull((String) rs.getString("NPLPD_NO_DEPENDANTS")));
				hshValues.put("NPLPD_NO_CHILDREN", Helper.correctNull((String) rs.getString("NPLPD_NO_CHILDREN")));
				hshValues.put("NPLPD_RESI_YEAR", Helper.correctNull((String) rs.getString("NPLPD_RESI_YEAR")));
				hshValues.put("NPLPD_RESI_MONTH", Helper.correctNull((String) rs.getString("NPLPD_RESI_MONTH")));
				hshValues.put("NPLPD_LT_EXP_YEAR", Helper.correctNull((String) rs.getString("NPLPD_LT_EXP_YEAR")));
				hshValues.put("NPLPD_LT_EXP_MONTH", Helper.correctNull((String) rs.getString("NPLPD_LT_EXP_MONTH")));
				hshValues.put("NPLPD_MARK_ARRANGE", Helper.correctNull((String) rs.getString("NPLPD_MARK_ARRANGE")));
				hshValues.put("NPLPD_HAS_PMSBY", Helper.correctNull((String) rs.getString("NPLPD_HAS_PMSBY")));
				hshValues.put("NPLPD_IS_REG_GOV", Helper.correctNull((String) rs.getString("NPLPD_IS_REG_GOV")));
				hshValues.put("NPLPD_IS_SKILL_CERT", Helper.correctNull((String) rs.getString("NPLPD_IS_SKILL_CERT")));
				hshValues.put("NPLPD_OTH_EARNING_MEM", Helper.correctNull((String) rs.getString("NPLPD_OTH_EARNING_MEM")));
				hshValues.put("NPLPD_SAVING_BAL", Helper.correctNull((String) rs.getString("NPLPD_SAVING_BAL")));
				hshValues.put("NPLPD_MARK_ARRANGE_ID", Helper.correctNull((String) rs.getString("NPLPD_MARK_ARRANGE_ID")));
				hshValues.put("NPLPD_IS_SHG_MEM", Helper.correctNull((String) rs.getString("NPLPD_IS_SHG_MEM")));
				hshValues.put("NPLPD_IS_STREET_VEND", Helper.correctNull((String) rs.getString("NPLPD_IS_STREET_VEND")));
				hshValues.put("NPLPD_MARITAL_STATUSID", Helper.correctNull((String) rs.getString("NPLPD_MARITAL_STATUSID")));
				hshValues.put("NPLPD_ID", Helper.correctNull((String) rs.getString("NPLPD_ID")));
				hshValues.put("NPLPD_AADHAR_ADD_SEQ_NO", Helper.correctNull((String) rs.getString("NPLPD_AADHAR_ADD_SEQ_NO")));
				AddSeqNo = Helper.correctNull((String) rs.getString("NPLPD_AADHAR_ADD_SEQ_NO"));
				hshValues.put("NPLPD_CURR_ADD_SEQ_NO", Helper.correctNull((String) rs.getString("NPLPD_CURR_ADD_SEQ_NO")));
				CurrAddSeqNo = Helper.correctNull((String) rs.getString("NPLPD_CURR_ADD_SEQ_NO"));
				hshValues.put("NPLPD_SALUTION", Helper.correctNull((String) rs.getString("NPLPD_SALUTION")));
				hshValues.put("NPLPD_DOB", Helper.correctNull((String) rs.getString("NPLPD_DOB")));
				hshValues.put("NPLPD_DATE_OF_BIRTH", Helper.correctNull((String) rs.getString("NPLPD_DATE_OF_BIRTH")));
				hshValues.put("NPLPD_FATHER_NAME", Helper.correctNull((String) rs.getString("NPLPD_FATHER_NAME")));
				hshValues.put("NPLPD_GENDER", Helper.correctNull((String) rs.getString("NPLPD_GENDER")));
				hshValues.put("NPLPD_MOBILE", Helper.correctNull((String) rs.getString("NPLPD_MOBILE")));
				hshValues.put("NPLPD_EMAIL", Helper.correctNull((String) rs.getString("NPLPD_EMAIL")));
				hshValues.put("NPLPD_EDU_QUAL", Helper.correctNull((String) rs.getString("NPLPD_EDU_QUAL")));
				hshValues.put("NPLPD_RELATION", Helper.correctNull((String) rs.getString("NPLPD_RELATION")));
				hshValues.put("NPLPD_SOCI_CATE", Helper.correctNull((String) rs.getString("NPLPD_SOCI_CATE")));
				hshValues.put("NPLPD_IS_CURR_ADD_SAME", Helper.correctNull((String) rs.getString("NPLPD_IS_CURR_ADD_SAME")));
				hshValues.put("NPLPD_MARITAL_STATUS", Helper.correctNull((String) rs.getString("NPLPD_MARITAL_STATUS")));
			}
			if(rs != null)
			{
				rs.close();
			}    	   
			if(!AddSeqNo.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("getAddressDetails^"+AppId+"^"+AddSeqNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
				hshValues.put("NPAD_ID", Helper.correctNull((String) rs.getString("NPAD_ID")));
				hshValues.put("NPAD_APPLICATION_REFERENCE_ID", Helper.correctNull((String) rs.getString("NPAD_APPLICATION_REFERENCE_ID")));
				hshValues.put("NPAD_ADD_SEQ_NO", Helper.correctNull((String) rs.getString("NPAD_ADD_SEQ_NO")));
				hshValues.put("NPAD_ADD_TYPE", Helper.correctNull((String) rs.getString("NPAD_ADD_TYPE")));
				hshValues.put("NPAD_STREET_NAME", Helper.correctNull((String) rs.getString("NPAD_STREET_NAME")));
				hshValues.put("NPAD_LANDMARK", Helper.correctNull((String) rs.getString("NPAD_LANDMARK")));
				hshValues.put("NPAD_COUNTRY_NAME", Helper.correctNull((String) rs.getString("NPAD_COUNTRY_NAME")));
				hshValues.put("NPAD_STATE_NAME", Helper.correctNull((String) rs.getString("NPAD_STATE_NAME")));
				hshValues.put("NPAD_DISTRICT_NAME", Helper.correctNull((String) rs.getString("NPAD_DISTRICT_NAME")));
				hshValues.put("NPAD_CITY_NAME", Helper.correctNull((String) rs.getString("NPAD_CITY_NAME")));
				hshValues.put("NPAD_SUB_DISTRICT", Helper.correctNull((String) rs.getString("NPAD_SUB_DISTRICT")));
				hshValues.put("NPAD_VILLAGE", Helper.correctNull((String) rs.getString("NPAD_VILLAGE")));
				hshValues.put("NPAD_PIN_CODE", Helper.correctNull((String) rs.getString("NPAD_PIN_CODE")));
				hshValues.put("NPAD_STATE_CODE", Helper.correctNull((String) rs.getString("NPAD_STATE_CODE")));
				hshValues.put("NPAD_DISTRICT_CODE", Helper.correctNull((String) rs.getString("NPAD_DISTRICT_CODE")));
				hshValues.put("NPAD_SUB_DISTRICT_CODE", Helper.correctNull((String) rs.getString("NPAD_SUB_DISTRICT_CODE")));
				hshValues.put("NPAD_VILLAGE_CODE", Helper.correctNull((String) rs.getString("NPAD_VILLAGE_CODE")));
				hshValues.put("NPAD_BLOCK_CODE", Helper.correctNull((String) rs.getString("NPAD_BLOCK_CODE")));
				hshValues.put("NPAD_BLOCK", Helper.correctNull((String) rs.getString("NPAD_BLOCK")));
				}
			}
			
			if(rs != null)
			{
				rs.close();
			}
			
			if(!CurrAddSeqNo.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("getAddressDetails^"+AppId+"^"+CurrAddSeqNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
				hshValues.put("CURR_NPAD_ID", Helper.correctNull((String) rs.getString("NPAD_ID")));
				hshValues.put("CURR_NPAD_APPLICATION_REFERENCE_ID", Helper.correctNull((String) rs.getString("NPAD_APPLICATION_REFERENCE_ID")));
				hshValues.put("CURR_NPAD_ADD_SEQ_NO", Helper.correctNull((String) rs.getString("NPAD_ADD_SEQ_NO")));
				hshValues.put("CURR_NPAD_ADD_TYPE", Helper.correctNull((String) rs.getString("NPAD_ADD_TYPE")));
				hshValues.put("CURR_NPAD_STREET_NAME", Helper.correctNull((String) rs.getString("NPAD_STREET_NAME")));
				hshValues.put("CURR_NPAD_LANDMARK", Helper.correctNull((String) rs.getString("NPAD_LANDMARK")));
				hshValues.put("CURR_NPAD_COUNTRY_NAME", Helper.correctNull((String) rs.getString("NPAD_COUNTRY_NAME")));
				hshValues.put("CURR_NPAD_STATE_NAME", Helper.correctNull((String) rs.getString("NPAD_STATE_NAME")));
				hshValues.put("CURR_NPAD_DISTRICT_NAME", Helper.correctNull((String) rs.getString("NPAD_DISTRICT_NAME")));
				hshValues.put("CURR_NPAD_CITY_NAME", Helper.correctNull((String) rs.getString("NPAD_CITY_NAME")));
				hshValues.put("CURR_NPAD_SUB_DISTRICT", Helper.correctNull((String) rs.getString("NPAD_SUB_DISTRICT")));
				hshValues.put("CURR_NPAD_VILLAGE", Helper.correctNull((String) rs.getString("NPAD_VILLAGE")));
				hshValues.put("CURR_NPAD_PIN_CODE", Helper.correctNull((String) rs.getString("NPAD_PIN_CODE")));
				hshValues.put("CURR_NPAD_STATE_CODE", Helper.correctNull((String) rs.getString("NPAD_STATE_CODE")));
				hshValues.put("CURR_NPAD_DISTRICT_CODE", Helper.correctNull((String) rs.getString("NPAD_DISTRICT_CODE")));
				hshValues.put("CURR_NPAD_SUB_DISTRICT_CODE", Helper.correctNull((String) rs.getString("NPAD_SUB_DISTRICT_CODE")));
				hshValues.put("CURR_NPAD_VILLAGE_CODE", Helper.correctNull((String) rs.getString("NPAD_VILLAGE_CODE")));
				hshValues.put("CURR_NPAD_BLOCK_CODE", Helper.correctNull((String) rs.getString("NPAD_BLOCK_CODE")));
				hshValues.put("CURR_NPAD_BLOCK", Helper.correctNull((String) rs.getString("NPAD_BLOCK")));
				}
			}
			
			if(rs != null)
			{
				rs.close();
			}
			hshValues.put("popSchemeId",popSchemeId );
			
       }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> getNULMPersonalDetails Method"+m);
       }
	return hshValues;
	
}

@SuppressWarnings("unchecked")
public HashMap getAGRIPersonalDetails(HashMap hshValues) 
{
	String strQuery ="",strRefId="",AddSeqNo="0",InstAddSeqNo="",CurrAddSeqNo="";
	ResultSet rs= null;

	strRefId =  Helper.correctNull((String)hshValues.get("hidRefId"));
	
	
	if(strRefId.equalsIgnoreCase("")){
		strRefId =  Helper.correctNull((String)hshValues.get("hidApplicantId"));
	}
	if(strRefId.equalsIgnoreCase("")){
		strRefId =  Helper.correctNull((String)hshValues.get("Refno"));
	}
	hshValues.put("Refno",strRefId);
       try {
    	    strQuery=SQLParser.getSqlQuery("getAgriPersonalDetails^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("NPAAPD_ROW_ID", Helper.correctNull((String) rs.getString("NPAAPD_ROW_ID")));
			hshValues.put("NPAAPD_APP_REF_ID", Helper.correctNull((String) rs.getString("NPAAPD_APP_REF_ID")));
			hshValues.put("NPAAPD_ID", Helper.correctNull((String) rs.getString("NPAAPD_ID")));
			hshValues.put("NPAAPD_SALUTATION_ID", Helper.correctNull((String) rs.getString("NPAAPD_SALUTATION_ID")));
			hshValues.put("NPAAPD_SALUTATION", Helper.correctNull((String) rs.getString("NPAAPD_SALUTATION")));
			hshValues.put("NPAAPD_FIRST_NAME", Helper.correctNull((String) rs.getString("NPAAPD_FIRST_NAME")));
			hshValues.put("NPAAPD_MIDDLE_NAME", Helper.correctNull((String) rs.getString("NPAAPD_MIDDLE_NAME")));
			hshValues.put("NPAAPD_LAST_NAME", Helper.correctNull((String) rs.getString("NPAAPD_LAST_NAME")));
			hshValues.put("NPAAPD_DATE_OF_BIRTH", Helper.correctNull((String) rs.getString("NPAAPD_DATE_OF_BIRTH")));
			hshValues.put("NPAAPD_FATHER_OR_HUSBAND_NAME", Helper.correctNull((String) rs.getString("NPAAPD_FATHER_OR_HUSBAND_NAME")));
			hshValues.put("NPAAPD_MOTHER_NAME", Helper.correctNull((String) rs.getString("NPAAPD_MOTHER_NAME")));
			hshValues.put("NPAAPD_MOBILE", Helper.correctNull((String) rs.getString("NPAAPD_MOBILE")));
			hshValues.put("NPAAPD_EMAIL", Helper.correctNull((String) rs.getString("NPAAPD_EMAIL")));
			hshValues.put("NPAAPD_EDU_QUALIFICATION_ID", Helper.correctNull((String) rs.getString("NPAAPD_EDU_QUALIFICATION_ID")));
			hshValues.put("NPAAPD_EDU_QUALIFICATION", Helper.correctNull((String) rs.getString("NPAAPD_EDU_QUALIFICATION")));
			hshValues.put("NPAAPD_IS_CURRENT_ADD_SAME", Helper.correctNull((String) rs.getString("NPAAPD_IS_CURRENT_ADD_SAME")));
			hshValues.put("NPAAPD_MARITAL_STATUS_ID", Helper.correctNull((String) rs.getString("NPAAPD_MARITAL_STATUS_ID")));
			hshValues.put("NPAAPD_MARITAL_STATUS", Helper.correctNull((String) rs.getString("NPAAPD_MARITAL_STATUS")));
			hshValues.put("NPAAPD_SOCIAL_CATEGORY_ID", Helper.correctNull((String) rs.getString("NPAAPD_SOCIAL_CATEGORY_ID")));
			hshValues.put("NPAAPD_SOCIAL_CATEGORY", Helper.correctNull((String) rs.getString("NPAAPD_SOCIAL_CATEGORY")));
			hshValues.put("NPAAPD_TOTAL_EXP_YEAR", Helper.correctNull((String) rs.getString("NPAAPD_TOTAL_EXP_YEAR")));
			hshValues.put("NPAAPD_RESIDENTIAL_STATUS_ID", Helper.correctNull((String) rs.getString("NPAAPD_RESIDENTIAL_STATUS_ID")));
			hshValues.put("NPAAPD_RESIDENTIAL_STATUS", Helper.correctNull((String) rs.getString("NPAAPD_RESIDENTIAL_STATUS")));
			hshValues.put("NPAAPD_INSTITUTION", Helper.correctNull((String) rs.getString("NPAAPD_INSTITUTION")));
			hshValues.put("NPAAPD_INSTITUTION_NAME", Helper.correctNull((String) rs.getString("NPAAPD_INSTITUTION_NAME")));
			hshValues.put("NPAAPD_MARKS_OBTAIN", Helper.correctNull((String) rs.getString("NPAAPD_MARKS_OBTAIN")));
			hshValues.put("NPAAPD_TRAINING_NAME", Helper.correctNull((String) rs.getString("NPAAPD_TRAINING_NAME")));
			hshValues.put("NPAAPD_TRAINING_ID", Helper.correctNull((String) rs.getString("NPAAPD_TRAINING_ID")));
			hshValues.put("NPAAPD_TRAINING_DESC", Helper.correctNull((String) rs.getString("NPAAPD_TRAINING_DESC")));
			hshValues.put("NPAAPD_GENDER_ID", Helper.correctNull((String) rs.getString("NPAAPD_GENDER_ID")));
			hshValues.put("NPAAPD_GENDER", Helper.correctNull((String) rs.getString("NPAAPD_GENDER")));
			hshValues.put("NPAAPD_AADHAR_ADD_SEQ_NO", Helper.correctNull((String) rs.getString("NPAAPD_AADHAR_ADD_SEQ_NO")));
			AddSeqNo = Helper.correctNull((String) rs.getString("NPAAPD_AADHAR_ADD_SEQ_NO"));
			hshValues.put("NPAAPD_INST_ADD_SEQ_NO", Helper.correctNull((String) rs.getString("NPAAPD_INST_ADD_SEQ_NO")));
			InstAddSeqNo = Helper.correctNull((String) rs.getString("NPAAPD_INST_ADD_SEQ_NO"));
			hshValues.put("NPAAPD_CURR_ADD_SEQ_NO", Helper.correctNull((String) rs.getString("NPAAPD_CURR_ADD_SEQ_NO")));
			CurrAddSeqNo = Helper.correctNull((String) rs.getString("NPAAPD_CURR_ADD_SEQ_NO"));
			hshValues.put("NPAAPD_APP_SEQ_ID", Helper.correctNull((String) rs.getString("NPAAPD_APP_SEQ_ID")));
            }
			if(rs != null)
			{
				rs.close();
			}
			
			strQuery=SQLParser.getSqlQuery("getAgriPersPANDetails^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("NPAAPDP_ROW_ID", Helper.correctNull((String) rs.getString("NPAAPDP_ROW_ID")));
			hshValues.put("NPAAPDP_APPL_REF_ID", Helper.correctNull((String) rs.getString("NPAAPDP_APPL_REF_ID")));
			hshValues.put("NPAAPDP_PAN", Helper.correctNull((String) rs.getString("NPAAPDP_PAN")));
			hshValues.put("NPAAPDP_FIRST_NAME", Helper.correctNull((String) rs.getString("NPAAPDP_FIRST_NAME")));
			hshValues.put("NPAAPDP_MIDDLE_NAME", Helper.correctNull((String) rs.getString("NPAAPDP_MIDDLE_NAME")));
			hshValues.put("NPAAPDP_LAST_NAME", Helper.correctNull((String) rs.getString("NPAAPDP_LAST_NAME")));
			hshValues.put("NPAAPDP_ENTITY_NAME", Helper.correctNull((String) rs.getString("NPAAPDP_ENTITY_NAME")));
			hshValues.put("NPAAPDP_ENTITY_TYPE", Helper.correctNull((String) rs.getString("NPAAPDP_ENTITY_TYPE")));
			hshValues.put("NPAAPDP_APP_SEQ_ID", Helper.correctNull((String) rs.getString("NPAAPDP_APP_SEQ_ID")));
			}
			if(rs != null)
			{
				rs.close();
			}
			
			//AADHAAR ADDRESS
			if(!AddSeqNo.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("getAddressDetails^"+strRefId+"^"+AddSeqNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
				hshValues.put("NPAD_ID", Helper.correctNull((String) rs.getString("NPAD_ID")));
				hshValues.put("NPAD_APPLICATION_REFERENCE_ID", Helper.correctNull((String) rs.getString("NPAD_APPLICATION_REFERENCE_ID")));
				hshValues.put("NPAD_ADD_SEQ_NO", Helper.correctNull((String) rs.getString("NPAD_ADD_SEQ_NO")));
				hshValues.put("NPAD_ADD_TYPE", Helper.correctNull((String) rs.getString("NPAD_ADD_TYPE")));
				hshValues.put("NPAD_STREET_NAME", Helper.correctNull((String) rs.getString("NPAD_STREET_NAME")));
				hshValues.put("NPAD_LANDMARK", Helper.correctNull((String) rs.getString("NPAD_LANDMARK")));
				hshValues.put("NPAD_COUNTRY_NAME", Helper.correctNull((String) rs.getString("NPAD_COUNTRY_NAME")));
				hshValues.put("NPAD_STATE_NAME", Helper.correctNull((String) rs.getString("NPAD_STATE_NAME")));
				hshValues.put("NPAD_DISTRICT_NAME", Helper.correctNull((String) rs.getString("NPAD_DISTRICT_NAME")));
				hshValues.put("NPAD_CITY_NAME", Helper.correctNull((String) rs.getString("NPAD_CITY_NAME")));
				hshValues.put("NPAD_SUB_DISTRICT", Helper.correctNull((String) rs.getString("NPAD_SUB_DISTRICT")));
				hshValues.put("NPAD_VILLAGE", Helper.correctNull((String) rs.getString("NPAD_VILLAGE")));
				hshValues.put("NPAD_PIN_CODE", Helper.correctNull((String) rs.getString("NPAD_PIN_CODE")));
				hshValues.put("NPAD_STATE_CODE", Helper.correctNull((String) rs.getString("NPAD_STATE_CODE")));
				hshValues.put("NPAD_DISTRICT_CODE", Helper.correctNull((String) rs.getString("NPAD_DISTRICT_CODE")));
				hshValues.put("NPAD_SUB_DISTRICT_CODE", Helper.correctNull((String) rs.getString("NPAD_SUB_DISTRICT_CODE")));
				hshValues.put("NPAD_VILLAGE_CODE", Helper.correctNull((String) rs.getString("NPAD_VILLAGE_CODE")));
				hshValues.put("NPAD_BLOCK_CODE", Helper.correctNull((String) rs.getString("NPAD_BLOCK_CODE")));
				hshValues.put("NPAD_BLOCK", Helper.correctNull((String) rs.getString("NPAD_BLOCK")));
				}
			}
			
			if(rs != null)
			{
				rs.close();
			}
			if(!InstAddSeqNo.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("getAddressDetails^"+strRefId+"^"+InstAddSeqNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
				hshValues.put("INST_NPAD_ID", Helper.correctNull((String) rs.getString("NPAD_ID")));
				hshValues.put("INST_NPAD_APPLICATION_REFERENCE_ID", Helper.correctNull((String) rs.getString("NPAD_APPLICATION_REFERENCE_ID")));
				hshValues.put("INST_NPAD_ADD_SEQ_NO", Helper.correctNull((String) rs.getString("NPAD_ADD_SEQ_NO")));
				hshValues.put("INST_NPAD_ADD_TYPE", Helper.correctNull((String) rs.getString("NPAD_ADD_TYPE")));
				hshValues.put("INST_NPAD_STREET_NAME", Helper.correctNull((String) rs.getString("NPAD_STREET_NAME")));
				hshValues.put("INST_NPAD_LANDMARK", Helper.correctNull((String) rs.getString("NPAD_LANDMARK")));
				hshValues.put("INST_NPAD_COUNTRY_NAME", Helper.correctNull((String) rs.getString("NPAD_COUNTRY_NAME")));
				hshValues.put("INST_NPAD_STATE_NAME", Helper.correctNull((String) rs.getString("NPAD_STATE_NAME")));
				hshValues.put("INST_NPAD_DISTRICT_NAME", Helper.correctNull((String) rs.getString("NPAD_DISTRICT_NAME")));
				hshValues.put("INST_NPAD_CITY_NAME", Helper.correctNull((String) rs.getString("NPAD_CITY_NAME")));
				hshValues.put("INST_NPAD_SUB_DISTRICT", Helper.correctNull((String) rs.getString("NPAD_SUB_DISTRICT")));
				hshValues.put("INST_NPAD_VILLAGE", Helper.correctNull((String) rs.getString("NPAD_VILLAGE")));
				hshValues.put("INST_NPAD_PIN_CODE", Helper.correctNull((String) rs.getString("NPAD_PIN_CODE")));
				hshValues.put("INST_NPAD_STATE_CODE", Helper.correctNull((String) rs.getString("NPAD_STATE_CODE")));
				hshValues.put("INST_NPAD_DISTRICT_CODE", Helper.correctNull((String) rs.getString("NPAD_DISTRICT_CODE")));
				hshValues.put("INST_NPAD_SUB_DISTRICT_CODE", Helper.correctNull((String) rs.getString("NPAD_SUB_DISTRICT_CODE")));
				hshValues.put("INST_NPAD_VILLAGE_CODE", Helper.correctNull((String) rs.getString("NPAD_VILLAGE_CODE")));
				hshValues.put("INST_NPAD_BLOCK_CODE", Helper.correctNull((String) rs.getString("NPAD_BLOCK_CODE")));
				hshValues.put("INST_NPAD_BLOCK", Helper.correctNull((String) rs.getString("NPAD_BLOCK")));
				}
			}
			
			if(rs != null)
			{
				rs.close();
			}
			if(!CurrAddSeqNo.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("getAddressDetails^"+strRefId+"^"+CurrAddSeqNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
				hshValues.put("CURR_NPAD_ID", Helper.correctNull((String) rs.getString("NPAD_ID")));
				hshValues.put("CURR_NPAD_APPLICATION_REFERENCE_ID", Helper.correctNull((String) rs.getString("NPAD_APPLICATION_REFERENCE_ID")));
				hshValues.put("CURR_NPAD_ADD_SEQ_NO", Helper.correctNull((String) rs.getString("NPAD_ADD_SEQ_NO")));
				hshValues.put("CURR_NPAD_ADD_TYPE", Helper.correctNull((String) rs.getString("NPAD_ADD_TYPE")));
				hshValues.put("CURR_NPAD_STREET_NAME", Helper.correctNull((String) rs.getString("NPAD_STREET_NAME")));
				hshValues.put("CURR_NPAD_LANDMARK", Helper.correctNull((String) rs.getString("NPAD_LANDMARK")));
				hshValues.put("CURR_NPAD_COUNTRY_NAME", Helper.correctNull((String) rs.getString("NPAD_COUNTRY_NAME")));
				hshValues.put("CURR_NPAD_STATE_NAME", Helper.correctNull((String) rs.getString("NPAD_STATE_NAME")));
				hshValues.put("CURR_NPAD_DISTRICT_NAME", Helper.correctNull((String) rs.getString("NPAD_DISTRICT_NAME")));
				hshValues.put("CURR_NPAD_CITY_NAME", Helper.correctNull((String) rs.getString("NPAD_CITY_NAME")));
				hshValues.put("CURR_NPAD_SUB_DISTRICT", Helper.correctNull((String) rs.getString("NPAD_SUB_DISTRICT")));
				hshValues.put("CURR_NPAD_VILLAGE", Helper.correctNull((String) rs.getString("NPAD_VILLAGE")));
				hshValues.put("CURR_NPAD_PIN_CODE", Helper.correctNull((String) rs.getString("NPAD_PIN_CODE")));
				hshValues.put("CURR_NPAD_STATE_CODE", Helper.correctNull((String) rs.getString("NPAD_STATE_CODE")));
				hshValues.put("CURR_NPAD_DISTRICT_CODE", Helper.correctNull((String) rs.getString("NPAD_DISTRICT_CODE")));
				hshValues.put("CURR_NPAD_SUB_DISTRICT_CODE", Helper.correctNull((String) rs.getString("NPAD_SUB_DISTRICT_CODE")));
				hshValues.put("CURR_NPAD_VILLAGE_CODE", Helper.correctNull((String) rs.getString("NPAD_VILLAGE_CODE")));
				hshValues.put("CURR_NPAD_BLOCK_CODE", Helper.correctNull((String) rs.getString("NPAD_BLOCK_CODE")));
				hshValues.put("CURR_NPAD_BLOCK", Helper.correctNull((String) rs.getString("NPAD_BLOCK")));
				}
			}
			
			if(rs != null)
			{
				rs.close();
			}
       }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> getAgriPersonalDetails Method : "+m);
       }
	return hshValues;
}

@SuppressWarnings("unchecked")
public HashMap getAgriProjLoanDetails(HashMap hshValues) 
{
	String strQuery ="",strRefId="",AddSeqNo="";
	ResultSet rs= null;

	strRefId =  Helper.correctNull((String)hshValues.get("hidApplicantId"));
	
       try {
    	    strQuery=SQLParser.getSqlQuery("getAgriProjectDetails^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("NPD_ROWID", Helper.correctNull((String) rs.getString("NPD_ROWID")));
			hshValues.put("NPD_ID", Helper.correctNull((String) rs.getString("NPD_ID")));
			hshValues.put("NPD_APP_REF_ID", Helper.correctNull((String) rs.getString("NPD_APP_REF_ID")));
			hshValues.put("NPD_TYPEOFCREDITID", Helper.correctNull((String) rs.getString("NPD_TYPEOFCREDITID")));
			hshValues.put("NPD_TYPEOFCREDIT", Helper.correctNull((String) rs.getString("NPD_TYPEOFCREDIT")));
			hshValues.put("NPD_TYPEOFACTIVITYID", Helper.correctNull((String) rs.getString("NPD_TYPEOFACTIVITYID")));
			hshValues.put("NPD_TYPEOFACTIVITY", Helper.correctNull((String) rs.getString("NPD_TYPEOFACTIVITY")));
			hshValues.put("NPD_TYPEID", Helper.correctNull((String) rs.getString("NPD_TYPEID")));
			hshValues.put("NPD_PURPOSE", Helper.correctNull((String) rs.getString("NPD_PURPOSE")));
			hshValues.put("NPD_FINANCIALOUTLAY", Helper.correctNull((String) rs.getString("NPD_FINANCIALOUTLAY")));
			hshValues.put("NPD_SEQNO", Helper.correctNull((String) rs.getString("NPD_SEQNO")));
			hshValues.put("NPD_OTHERACTIVITY", Helper.correctNull((String) rs.getString("NPD_OTHERACTIVITY")));
            }
			if(rs != null)
			{
				rs.close();
			}
			
			strQuery=SQLParser.getSqlQuery("getAgriLoanDetails^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshValues.put("NLD_ROWID", Helper.correctNull((String) rs.getString("NLD_ROWID")));
			hshValues.put("NLD_ID", Helper.correctNull((String) rs.getString("NLD_ID")));
			hshValues.put("NLD_APP_REF_ID", Helper.correctNull((String) rs.getString("NLD_APP_REF_ID")));
			hshValues.put("NLD_OWNCONTRIBUTION", Helper.correctNull((String) rs.getString("NLD_OWNCONTRIBUTION")));
			hshValues.put("NLD_REQUIREDLOANAMT", Helper.correctNull((String) rs.getString("NLD_REQUIREDLOANAMT")));
			hshValues.put("NLD_TENURE", Helper.correctNull((String) rs.getString("NLD_TENURE")));
			hshValues.put("NLD_ELIGIBLESUBSIDY", Helper.correctNull((String) rs.getString("NLD_ELIGIBLESUBSIDY")));
			hshValues.put("NLD_LOCATION", Helper.correctNull((String) rs.getString("NLD_LOCATION")));
			hshValues.put("NLD_TOTALPROJECTCOST", Helper.correctNull((String) rs.getString("NLD_TOTALPROJECTCOST")));
			hshValues.put("NLD_LANDOWNERSHIPID", Helper.correctNull((String) rs.getString("NLD_LANDOWNERSHIPID")));
			hshValues.put("NLD_LANDOWNERSHIP", Helper.correctNull((String) rs.getString("NLD_LANDOWNERSHIP")));
			hshValues.put("NLD_NOOFOWNERS", Helper.correctNull((String) rs.getString("NLD_NOOFOWNERS")));
			hshValues.put("NLD_TYPEOFPROJECTID", Helper.correctNull((String) rs.getString("NLD_TYPEOFPROJECTID")));
			hshValues.put("NLD_TYPEOFPROJECT", Helper.correctNull((String) rs.getString("NLD_TYPEOFPROJECT")));
			hshValues.put("NLD_TYPEOFBUSINESSID", Helper.correctNull((String) rs.getString("NLD_TYPEOFBUSINESSID")));
			hshValues.put("NLD_TYPEOFBUSINESS", Helper.correctNull((String) rs.getString("NLD_TYPEOFBUSINESS")));
			hshValues.put("NLD_STORAGECAPACITY", Helper.correctNull((String) rs.getString("NLD_STORAGECAPACITY")));
			hshValues.put("NLD_OTHERBUSINESSTYPE", Helper.correctNull((String) rs.getString("NLD_OTHERBUSINESSTYPE")));
			hshValues.put("NLD_INVESTPLANT_MACH", Helper.correctNull((String) rs.getString("NLD_INVESTPLANT_MACH")));
			hshValues.put("NLD_OWNERNAMES", Helper.correctNull((String) rs.getString("NLD_OWNERNAMES")));
			hshValues.put("NLD_ANNUALREVENUE", Helper.correctNull((String) rs.getString("NLD_ANNUALREVENUE")));
			hshValues.put("NLD_ISOTHERBEN_SCHEME", Helper.correctNull((String) rs.getString("NLD_ISOTHERBEN_SCHEME")));
			hshValues.put("NLD_OTHERBEN_SCHEME", Helper.correctNull((String) rs.getString("NLD_OTHERBEN_SCHEME")));
			hshValues.put("NLD_ADDRESS_SEQNO", Helper.correctNull((String) rs.getString("NLD_ADDRESS_SEQNO")));
			AddSeqNo = Helper.correctNull((String) rs.getString("NLD_ADDRESS_SEQNO"));
            }
			if(rs != null)
			{
				rs.close();
			}
			if(!AddSeqNo.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("getAddressDetails^"+strRefId+"^"+AddSeqNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
				hshValues.put("NPAD_ID", Helper.correctNull((String) rs.getString("NPAD_ID")));
				hshValues.put("NPAD_APPLICATION_REFERENCE_ID", Helper.correctNull((String) rs.getString("NPAD_APPLICATION_REFERENCE_ID")));
				hshValues.put("NPAD_ADD_SEQ_NO", Helper.correctNull((String) rs.getString("NPAD_ADD_SEQ_NO")));
				hshValues.put("NPAD_ADD_TYPE", Helper.correctNull((String) rs.getString("NPAD_ADD_TYPE")));
				hshValues.put("NPAD_STREET_NAME", Helper.correctNull((String) rs.getString("NPAD_STREET_NAME")));
				hshValues.put("NPAD_LANDMARK", Helper.correctNull((String) rs.getString("NPAD_LANDMARK")));
				hshValues.put("NPAD_COUNTRY_NAME", Helper.correctNull((String) rs.getString("NPAD_COUNTRY_NAME")));
				hshValues.put("NPAD_STATE_NAME", Helper.correctNull((String) rs.getString("NPAD_STATE_NAME")));
				hshValues.put("NPAD_DISTRICT_NAME", Helper.correctNull((String) rs.getString("NPAD_DISTRICT_NAME")));
				hshValues.put("NPAD_CITY_NAME", Helper.correctNull((String) rs.getString("NPAD_CITY_NAME")));
				hshValues.put("NPAD_SUB_DISTRICT", Helper.correctNull((String) rs.getString("NPAD_SUB_DISTRICT")));
				hshValues.put("NPAD_VILLAGE", Helper.correctNull((String) rs.getString("NPAD_VILLAGE")));
				hshValues.put("NPAD_PIN_CODE", Helper.correctNull((String) rs.getString("NPAD_PIN_CODE")));
				hshValues.put("NPAD_STATE_CODE", Helper.correctNull((String) rs.getString("NPAD_STATE_CODE")));
				hshValues.put("NPAD_DISTRICT_CODE", Helper.correctNull((String) rs.getString("NPAD_DISTRICT_CODE")));
				hshValues.put("NPAD_SUB_DISTRICT_CODE", Helper.correctNull((String) rs.getString("NPAD_SUB_DISTRICT_CODE")));
				hshValues.put("NPAD_VILLAGE_CODE", Helper.correctNull((String) rs.getString("NPAD_VILLAGE_CODE")));
				hshValues.put("NPAD_BLOCK_CODE", Helper.correctNull((String) rs.getString("NPAD_BLOCK_CODE")));
				hshValues.put("NPAD_BLOCK", Helper.correctNull((String) rs.getString("NPAD_BLOCK")));
				
			}
			}
			if(rs != null)
			{
				rs.close();
			}
       }
       catch(Exception m) {
           System.out.println("Error in PSB59Bean -> getAgriProjLoanDetails Method : "+m);
       }
	return hshValues;
}
public HashMap getNP_Dsibursment(HashMap hshValues)  {

	ResultSet rs = null;
	ResultSet rs1 = null;
	HashMap hshRecord = new HashMap();
	String strQuery = "",strBranchHead="",strBranchHeadflag="";
	String strComappid = Helper.correctNull((String) hshValues
			.get("hidBorrowerAppid"));
	// String strAppno="";
	ArrayList arrColOur = new ArrayList();
	ArrayList arrRowOur = new ArrayList();

	ArrayList arrColOther = new ArrayList();
	ArrayList arrRowOther = new ArrayList();
	int lib_bank = 0;
	int lib_other_bank = 0;
	String hidschemeName =  Helper.correctNull((String)hshValues.get("hidschemeName"));
	if (hidschemeName.equalsIgnoreCase("")) {
		hidschemeName = Helper.correctNull((String) hshValues.get("appschname"));
	}
	if (hidschemeName.equalsIgnoreCase("")) {
		hidschemeName = Helper.correctNull((String) hshValues.get("hidschName"));
	}
	
	String strUsrid =  Helper.correctNull((String)hshValues.get("strUserId"));
	
	String strAppno = Helper.correctNull((String) hshValues.get("hidAppno"));
	String pag_status = Helper.correctNull((String) hshValues.get("pag_Status"));
	String varcbsid = Helper.correctNull((String) hshValues.get("varcbsid"));
	if (pag_status.equalsIgnoreCase("")) {
		pag_status = Helper.correctNull((String) hshValues.get("pag_status"));
	}
	String strapprefid=Helper.correctNull((String) hshValues.get("hidApplicantId"));  
	String strHidsegType=Helper.correctNull((String) hshValues.get("hidsegtype")); 
	String hidAction=Helper.correctNull((String) hshValues.get("hidAction")); 
	
	try {
		if (strHidsegType.equals("")) {
			strHidsegType = correctNull((String) hshValues.get("SegType"));
		}if (strHidsegType.equals("")) {
			strHidsegType = correctNull((String) hshValues.get("strSegment"));
		}if (strHidsegType.equals("")) {
			strHidsegType = correctNull((String) hshValues.get("hidsegtypeval"));
		}
		
		if (strapprefid.equals("")) {
			strapprefid = correctNull((String) hshValues.get("REFERENCE_ID"));
		}
		if (strapprefid.equals("")) {
			strapprefid = correctNull((String) hshValues.get("hidrefidno"));
		}
		if (strapprefid.equals("")) {
			strapprefid = correctNull((String) hshValues.get("hidReferId"));
		}
		if (strAppno.equals("")) {
			strAppno = correctNull((String) hshValues.get("appno"));
		}
		if (strAppno.equals("")) {
			strAppno = correctNull((String) hshValues.get("hidappno"));
		}
		
		if (strAppno.equalsIgnoreCase("") ) {
			if (!strapprefid.equalsIgnoreCase("") ) {
			
		strQuery=SQLParser.getSqlQuery("get_applicationNumber^"+strapprefid);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strAppno=Helper.correctNull((String)rs.getString("NP_APPLICATION_NUMBER"));
		} else{
		strQuery=SQLParser.getSqlQuery("sel_applicationappno1_np^"+strapprefid);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strAppno=Helper.correctNull((String)rs.getString("APP_NO"));
		}
		
		}
		if(rs!=null)
		{
			rs.close();
		}
			}
		}
		
		if (!strapprefid.equalsIgnoreCase("") ) {
			if (strHidsegType.equalsIgnoreCase("") ) {
				
				strQuery = SQLParser.getSqlQuery("sel_applicationscheme_np^"+strapprefid);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					strHidsegType=Helper.correctNull((String)rs.getString("NPDT_NP_SCHEME_NAME"));
				}
			}
		}
		
		
		if(strHidsegType.equalsIgnoreCase(""))
		{
			strHidsegType="EDU";
		}
		hshValues.put("RefId", strapprefid);
		hshValues.put("app_no", strAppno);
		hshValues.put("hidappno", strAppno);

		hshValues.put("varcbsid", varcbsid);
		hshValues.put("pag_status", pag_status);
		hshValues.put("strapprefid", strapprefid);
		hshValues.put("strHidsegType", strHidsegType);
		hshValues.put("schemeName", hidschemeName);
		
		strQuery=SQLParser.getSqlQuery("sel_branchHeadrestrict1^"+strUsrid);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strBranchHead=Helper.correctNull((String)rs.getString("ORG_HEAD"));
		}
		if(rs!=null)
		{
			rs.close();
		}
		if(strUsrid.equals(strBranchHead))
		{
			strBranchHeadflag="Y";
		}else{
			strBranchHeadflag="N";
		}
		hshValues.put("strBranchHead",strBranchHeadflag);
		
		strQuery = SQLParser.getSqlQuery("sel_npdisp^" + strapprefid);
		rs = DBUtils.executeQuery(strQuery);
		while (rs.next()) {
			arrColOur = new ArrayList();
			arrColOur.add(Helper.correctNull((String) rs.getString("SNO")));// 0
			arrColOur.add(Helper.correctNull((String) rs.getString("DISBURSEMENTDATE")));// 1
			arrColOur.add(Helper.correctNull((String) rs.getString("TRANSACTIONNO")));// 2
			arrColOur.add(Helper.correctNull((String) rs.getString("DISBURSEDAMOUNT")));// 3
			arrColOur.add(Helper.correctNull((String) rs.getString("TOTALDISBURSEDAMOUNT")));// 4
			arrColOur.add(Helper.correctNull((String) rs.getString("REMARKS")));// 5
			arrColOur.add(Helper.correctNull((String) rs.getString("EMI")));// 6
			arrColOur.add(Helper.correctNull((String) rs.getString("STATUS")));// 7
			arrColOur.add(Helper.correctNull((String) rs.getString("ACCOUNTNUMBER")));// 8
			arrColOur.add(Helper.correctNull((String) rs.getString("TENURE")));// 9
			arrColOur.add(Helper.correctNull((String) rs.getString("APPNO")));// 10
			arrColOur.add(Helper.correctNull((String) rs.getString("SCHEMETYPE")));// 11
			arrColOur.add(Helper.correctNull((String) rs.getString("DISP_UPDATEFLAG")));// 12
			arrColOur.add(Helper.correctNull((String) rs.getString("DISPSTATUSFLAG")));// 13
			arrColOur.add(Helper.correctNull((String) rs.getString("APPREFID")));// 14
			arrColOur.add(Helper.correctNull((String) rs.getString("MODETYPE")));//15

			lib_bank++;
			arrRowOur.add(arrColOur);
		}
		hshValues.put("arrRow", arrRowOur);
		
		if (lib_bank == 0) {
			lib_bank = 1;
		}
		hshValues.put("lib_bank", Integer.toString(lib_bank));

		if (rs != null) {
			rs.close();
		}
	
		strQuery=SQLParser.getSqlQuery("sel_NPdisbAuthbutton^"+strapprefid);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshValues.put("ButtondisableFalg",Helper.correctNull((String)rs.getString("DISP_UPDATEFLAG")));
		}
		if(rs!=null)
		{
			rs.close();
		}
		
		strQuery=SQLParser.getSqlQuery("sel_getdisbstatus^"+strapprefid);
		rs=DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			arrColOther = new ArrayList();
			arrColOther.add(Helper.correctNull((String) rs.getString("DISBURSEMENTDATE")));// 1
			arrColOther.add(Helper.correctNull((String) rs.getString("ACCOUNTNUMBER")));// 2
			arrColOther.add(Helper.correctNull((String) rs.getString("DISBURSEDAMOUNT")));// 3
			arrColOther.add(Helper.correctNull((String) rs.getString("REMARKS")));// 4
			arrColOther.add(Helper.correctNull((String) rs.getString("EMI")));// 5
			arrColOther.add(Helper.correctNull((String) rs.getString("TENURE")));// 6
			arrColOther.add("");// 7
			if(Helper.correctNull((String) rs.getString("RESP_STATUS")).equalsIgnoreCase("Y")){
				arrColOther.add("Success");// 7
			}else{
				arrColOther.add("Failed");// 7
			}
		
			
			arrRowOther.add(arrColOther);
		}
		
	
		hshValues.put("arrRowOther", arrRowOther);
		if(rs!=null)
		{
			rs.close();
		}
	} catch (Exception e) {
		Logger
				.log("Exception in MSMESimplificationBean -> getMSME_Liabilities method.. "
						+ e);
		throw new EJBException(e.getMessage());
	} finally {
		try {
			try {
				if (rs != null) {
					rs.close();
				}
				if (rs1 != null) {
					rs1.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}
		} catch (Exception e1) {
			throw new EJBException("Error closing connection");
		}
	}
	return hshValues;
}
@SuppressWarnings("unchecked")
public HashMap updateNP_Dsibursment(HashMap hshValues)  {
	HashMap hshqueryval = new HashMap();
	HashMap hshQuery = new HashMap();
	HashMap hshQueryValues = new HashMap();
	ResultSet rs = null;
	String strQuery = "";
	String strAction = (String) hshValues.get("hidAction");
	ArrayList arrValues = new ArrayList();
	int intUpdatesize = 0;
	String appno = correctNull((String) (hshValues.get("hid_appno")));

	int get_Count = 0;

	int get_Count11 = 0;
	if (appno.equals("")) {
		appno = correctNull((String) (hshValues.get("appno")));
	}
	if (appno.equals("")) {
		appno = correctNull((String) (hshValues.get("hidappno")));
	}
	if (appno.equals("")) {
		appno = correctNull((String) (hshValues.get("hidapplino")));
	}
	
	
	String pag_status = Helper.correctNull((String) hshValues.get("pag_status"));
	String varcbsid = Helper.correctNull((String) hshValues.get("varcbsid"));
	String strAppRefId=Helper.correctNull((String) hshValues.get("hidApplicantId"));
	String strSegment=Helper.correctNull((String) hshValues.get("SegType"));
	if(strAppRefId.equals("")){
		strAppRefId=Helper.correctNull((String) hshValues.get("REFERENCE_ID"));
	}
	if(strAppRefId.equals("")){
		strAppRefId=Helper.correctNull((String) hshValues.get("hidrefidno"));
	}
	if(strSegment.equals("")){
		strSegment=Helper.correctNull((String) hshValues.get("hidsegtypeval"));
	}
	if(strSegment.equals("")){
		strSegment=Helper.correctNull((String) hshValues.get("hidsegtype"));
	}
	
	
	String strDisbDt[] = null;
	String strTransno[] = null;
	String strdisbamt[] = null;
	String strmode[] = null;
	String strRemark[] = null;
	String strEmi[] = null;
	String strStatus[] = null;
	String strAccno[] = null;
	String strTenure[] = null;
	
	try {
		/* if(! appno.equalsIgnoreCase("")){
    		   
    		   strQuery=SQLParser.getSqlQuery("sel_getedudtls^"+appno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					//strRefId=Helper.correctNull((String) rs.getString("NPDT_APPLICATIONREFERENCEID")); 
					strSegment=Helper.correctNull((String) rs.getString("NPDT_SCHEMETYPE"));
				}
				if(rs != null)
				{
					rs.close();
				}
		 }*/
		 
		 hshValues.put("strSegment", strSegment);
		if (strAction.equalsIgnoreCase("insert")) {
			
			
			
				if (hshValues.get("txt_date") instanceof String[]) {
				
					strDisbDt = (String[]) hshValues.get("txt_date");// txtloan_purposeofloan
					strTransno = (String[]) hshValues.get("txt_trans_no");
					strdisbamt = (String[]) hshValues.get("txt_disb_amt");
					strmode = (String[]) hshValues.get("mode");
					strRemark = (String[]) hshValues.get("txt_rem");
					strEmi = (String[]) hshValues.get("txt_emi");
					strStatus = (String[]) hshValues.get("txt_stat");
					strAccno = (String[]) hshValues.get("txt_acc_no");
					strTenure = (String[]) hshValues.get("txt_tenure");
				}else{
					
					strDisbDt = new String[1];
					 strDisbDt[0] = (String) hshValues.get("txt_date");
					 strTransno = new String[1];
					 strTransno[0] = (String) hshValues.get("txt_trans_no");
					 strdisbamt = new String[1];
					 strdisbamt[0] = (String) hshValues.get("txt_disb_amt");
					 strmode = new String[1];
					 strmode[0] = (String) hshValues.get("mode");
					 strRemark = new String[1];
					 strRemark[0] = (String) hshValues.get("txt_rem");
					 strEmi = new String[1];
					 strEmi[0] = (String) hshValues.get("txt_emi");
					 strStatus = new String[1];
					 strStatus[0] = (String) hshValues.get("txt_stat");
					 strAccno = new String[1];
					 strAccno[0] = (String) hshValues.get("txt_acc_no");
					 strTenure = new String[1];
					 strTenure[0] = (String) hshValues.get("txt_tenure");
				}

				if (rs != null) {
					rs.close();
				}

				strQuery = SQLParser.getSqlQuery("sel_npdisbcount^" + strAppRefId+ "^" + strSegment);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					get_Count = rs.getInt("count");
				}
				if (rs != null) {
					rs.close();
				}
				if (get_Count > 0) {

					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_npdisb");
					arrValues = new ArrayList();
					arrValues.add(strAppRefId);
					arrValues.add(strSegment);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),
							hshQuery);
				}

				for (int i = 0; i < strDisbDt.length; i++) {
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(Integer.toString(intUpdatesize));
					arrValues.add(strDisbDt[i]);
					arrValues.add(strTransno[i]);
					arrValues.add(strdisbamt[i]);
					arrValues.add(strmode[i]);
					arrValues.add("");
					arrValues.add(strRemark[i]);
					arrValues.add(strEmi[i]);
					arrValues.add(strStatus[i]);
					arrValues.add(strAccno[i]);
					arrValues.add(strTenure[i]);
					arrValues.add(appno);
					arrValues.add(strSegment);
					arrValues.add("Y");
					arrValues.add("");
					arrValues.add(strAppRefId);
					
					
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "ins_NPDisbursment");
					hshQueryValues.put("size", Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),
							hshQuery);
					
				

			}
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
		}
	} catch (Exception e1) {
		throw new EJBException(
				"Error in PSB59 -> updateNP_Dsibursment method"
						+ e1.getMessage());
	}
	try {
		if (rs != null)
			rs.close();
	} catch (Exception e2) {
		throw new EJBException("Exception while Closing ResultSet..."
				+ e2.getMessage());
	}
	return hshValues;

}

public HashMap NPAppnoSearch(HashMap hshRequestValues) 
{
	String strQuery = "";
	ResultSet rs = null;
	HashMap hshRecord = new HashMap();
	Vector hshAllRecords = new Vector();
	String strQuery1 = "",strAppRefID = "";
	ResultSet rs1 = null;
	String Mouleype="";
	try
	{
		String appno=correctNull((String)hshRequestValues.get("appno"));
		if(!appno.equalsIgnoreCase("")){
		if(Mouleype.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("sel_AgriLoanDetails^"+appno);
		}else{
			strQuery = SQLParser.getSqlQuery("sel_HOUSLoanDetails^"+appno);
		}
		rs = DBUtils.executeQuery(strQuery);
		if (rs.next())
		{
			hshRecord.put("LOAN_RECMDAMT", Helper.correctNull((String) rs.getString("LOAN_RECMDAMT")));
			hshRecord.put("LOAN_MODINTRATE", Helper.correctNull((String) rs.getString("LOAN_MODINTRATE")));
			hshRecord.put("LOAN_PROCFEE", Helper.correctNull((String) rs.getString("LOAN_PROCFEE")));
			hshRecord.put("LOAN_REQTERMS", Helper.correctNull((String) rs.getString("LOAN_REQTERMS")));
			hshRecord.put("LOAN_EMI", Helper.correctNull((String) rs.getString("LOAN_EMI")));
			hshRecord.put("LOAN_PAPER_DATE", Helper.correctNull((String) rs.getString("LOAN_PAPER_DATE")));
		}
		
	}
	}
	catch(Exception ce)
	{
		throw new EJBException("Error in getCourseDetailsData "+ce.toString());
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
@SuppressWarnings("unchecked")
public HashMap invokeProposalStatusAPI(HashMap hshValues) 
{	HashMap hshQueryValues = new HashMap();
HashMap hshQuery = null;
ArrayList arrValues = null;
String strQuery ="",ReqAPIname="updateProposalStatus";
ResultSet rs= null;
String strRequest="",APPREFID="",strAPIname="PROPOSAL",roi="",pf="",StrAPIURL="",sanctionDate="",REMARKS="",schemeName="",schemeType="",strAppcallflg="",id="0";
String strRefId =  Helper.correctNull((String)hshValues.get("hidApplicantId"));
String respmesg="",strstatus="",strPropStatus="";
Gson gson = new Gson();
String resdata="",respmesg1="";
String strOutput="",strStatus="";
   try {
	   
	   strStatus=  Helper.correctNull((String)hshValues.get("hidaction"));
	   
	   if(strStatus.equalsIgnoreCase(""))
	   {
		   strStatus=  Helper.correctNull((String)hshValues.get("hidAction"));
    	     
	   }
	   schemeType =  Helper.correctNull((String)hshValues.get("SegType"));
	   String Appno= Helper.correctNull((String)hshValues.get("hidapno"));
	   if(! Appno.equalsIgnoreCase("")){
		   
		   strQuery=SQLParser.getSqlQuery("sel_getedudtls^"+Appno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strRefId=Helper.correctNull((String) rs.getString("NPDT_APPLICATIONREFERENCEID")); 
				schemeType=Helper.correctNull((String) rs.getString("NPDT_NP_SCHEME_TYPE"));
			}
			if(rs != null)
			{
				rs.close();
			}
		
	   }else{
		   strQuery = SQLParser.getSqlQuery("sel_updateproposalflag^"+strRefId);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				strAppcallflg=Helper.correctNull((String) rs.getString("NPDT_APPLICATIONSTATUS"));
				REMARKS=Helper.correctNull((String) rs.getString("NPDT_REMARKS"));
			}
			if(rs != null)
			{
				rs.close();
			}
			
	   }
	   if(strAppcallflg.equalsIgnoreCase("")){
			if(strStatus.equalsIgnoreCase("Reject"))
			{
				strAppcallflg="04";
			}
			if(strStatus.equalsIgnoreCase("Hold"))
			{
				strAppcallflg="05";
			}
			}
		 strQuery=SQLParser.getSqlQuery("sel_npSchemename^"+strRefId+"^"+schemeType);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				schemeName=Helper.correctNull((String) rs.getString("NPDT_NP_SCHEME_NAME")); 
				//strAPIName=Helper.correctNull((String) rs.getString("NP_SER_MAS_API_NAME"));
			}
			if(rs != null)
			{
				rs.close();
			}
    	   
			strQuery=SQLParser.getSqlQuery("sel_npupdate_url^"+ReqAPIname);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				StrAPIURL=Helper.correctNull((String) rs.getString("URLS"));
			}
			if(rs != null)
			{
				rs.close();
			}
			
			if(strStatus.equalsIgnoreCase("Reject"))
			{
				strAppcallflg="04";
				REMARKS="04";
			}
			if(strStatus.equalsIgnoreCase("Hold"))
			{
				strAppcallflg="05";
				REMARKS="05";
			}
			REMARKS=strAppcallflg;
			
		strRequest="{ \"applicationReferenceId\": "+strRefId+", \"proposalStatusId\": \""+strAppcallflg+"\", " +
		" \"reason\": \""+REMARKS+"\", \"schemeName\": \""+schemeName+"\", \"schemeType\": \""+schemeType+"\", " +
		 				"\"apiName\": \""+ReqAPIname+"\"}";
		
		Logger.log("Update Sanction API Request =========>"+strRequest);
		Logger.log("Update Sanction API URL =========>"+StrAPIURL);
		
		System.out.print("<========Request==========>"+strRequest);
		System.out.print("<========URL==========>"+StrAPIURL);
		
		
		try{
			strOutput =HttpConnections.PostConnection(StrAPIURL, strRequest);
			
		}
		  catch(Exception ex)
		   	{
		   		Logger.log("*********** Inside the Catch Block ***********"+ex.getMessage());
		   		ex.printStackTrace();
		   		//respmesg="Exception From LAPS"+e.getMessage();
		   	}
		
		
	
		Logger.log("National Portal get Sanction Response=========>"+strOutput);
		NationalPortalResponse response = new NationalPortalResponse();
		response=gson.fromJson(strOutput, NationalPortalResponse.class);
		if(! strOutput.equalsIgnoreCase("")|| strOutput.equals(null)){
			
			resdata=response.getData();
			Logger.log("National Portal get Sanction Response Data=========>"+resdata);
			
			respmesg1=response.getNpMessage();
			Logger.log("National Portal get Sanction Response Message=========>"+respmesg1);
			
			strstatus=response.getNpStatus();
			Logger.log("National Portal get Sanction Req staus=========>"+strstatus);
			
			respmesg=respmesg1.concat(resdata);
		
		
		if(strstatus.equalsIgnoreCase("200")){
		hshQuery = new HashMap();
		arrValues = new ArrayList();
		hshQuery.put("strQueryId", "upd_prostsAPIhit");
		arrValues.add("N");
		arrValues.add("Y");//Proposal Status
		arrValues.add(strRefId);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);
		hshQueryValues.put("size","1");
		hshValues.put("respmesg",respmesg);
		
		hshQuery = new HashMap();
		arrValues = new ArrayList();
		hshQuery.put("strQueryId", "ins_np_proposalstatus");
		arrValues.add(strRefId);
		arrValues.add(schemeType);
		arrValues.add(schemeName);
		arrValues.add("Y");
		
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("2",hshQuery);
		hshQueryValues.put("size","2");
		hshValues.put("respmesg",respmesg);
					
		}else{
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "upd_prostsAPIhit");
			arrValues.add("Y");
			arrValues.add("N");//Proposal Status
			arrValues.add(strRefId);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			hshValues.put("respmesg",respmesg);
			

			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "ins_np_proposalstatus");
			arrValues.add(strRefId);
			arrValues.add(schemeType);
			arrValues.add(schemeName);
			arrValues.add("Y");
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("2",hshQuery);
			hshQueryValues.put("size","2");
			hshValues.put("respmesg",respmesg);
		}
		}else{
			hshValues.put("respmesg","No response");
		}
		
		
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	    PSB59getHoldRejStatus(hshValues);
			
   }
   catch (ConnectException e) {
	   respmesg="Cannot Connect to Server!!!";
	}
   catch(Exception e)
	{
		Logger.log("*********** Inside the Catch Block ***********"+e.getMessage());
		respmesg="Exception From LAPS"+e.getMessage();
		e.printStackTrace();
	}
	hshValues.put("respmesg", respmesg);
return hshValues;

 }
public HashMap getNPHLApplicationCreation(HashMap hshValues) 
{
	ResultSet rs = null;
	ResultSet rs1 = null;
	HashMap hshRecord = new HashMap();
	HashMap hsh = new HashMap();
	String strQuery = "",strquery1="";
	HashMap hshQuery = new HashMap();
	ArrayList arrValues = new ArrayList();
	HashMap hshQueryValues = new HashMap();
	String strbranchcode=Helper.correctNull((String)hshValues.get("strOrgShortCode"));
	String strusrid=Helper.correctNull((String)hshValues.get("strUserId"));
	String strStatus=Helper.correctNull((String)hshValues.get("hidaction"));
	String strRefno = Helper.correctNull((String)hshValues.get("hidRefId"));
	MastApplicantBean CustPrfAppID = new MastApplicantBean();
	String LapsAppid="";
	HashMap hshResult = new HashMap();
	HashMap hshLoanProduct = new HashMap();
	HashMap hshlockvalues = new HashMap();
	String strApplicationNo="";
	int intUpdatesize=0;
	String hidApploanType = Helper.correctNull((String)hshValues.get("hidloanapptype"));
	String strOrglevel=correctNull((String)hshValues.get("strOrgLevel"));
    String strissaral=correctNull((String)hshValues.get("strIsSaral"));
	String strOrgbankFlag=correctNull((String)hshValues.get("strOrgbankFlag"));
	String strAppBankName=correctNull((String)hshValues.get("strAppBankName"));
    String strFromuserid=Helper.correctNull((String)hshValues.get("strUserId"));
    if(strRefno.equalsIgnoreCase("")){
    	strRefno  = Helper.correctNull((String)hshValues.get("hidApplicantId"));
    }
    
	HashMap hshqueryval = new HashMap();
	ArrayList arr = new ArrayList();

	try
	{	
		String Schemetype="";
		strQuery = SQLParser.getSqlQuery("sel_applicationscheme_np^"+strRefno);
		rs = DBUtils.executeQuery(strQuery);			
		if(rs.next())
		{
			Schemetype=Helper.correctNull((String)rs.getString("NPDT_NP_SCHEME_NAME"));
		}
		String strInwardno="",strappno="",strLapsappid="";
		if(rs != null){rs.close();}
		strQuery = SQLParser.getSqlQuery("sel_npapplicationdetails^"+strRefno);
		rs = DBUtils.executeQuery(strQuery);			
		if(rs.next())
		{			
			strInwardno = Helper.correctNull((String)rs.getString("NPDT_INWARDNO"));	
		}
		if(rs != null){rs.close();}
		
		String StrName1="";
		strQuery = SQLParser.getSqlQuery("sel_nppersonaldetails^"+strRefno);
		rs = DBUtils.executeQuery(strQuery);			
		if(rs.next())
		{			
			StrName1 = Helper.correctNull((String)rs.getString("NPPD_FIRST_NAME"))+" "+Helper.correctNull((String)rs.getString("NPPD_LAST_NAME"))+" "+Helper.correctNull((String)rs.getString("NPPD_MIDDLE_NAME"));	
			strLapsappid=Helper.correctNull((String)rs.getString("NPPD_LAPSAPPID"));
		}
		
		int intappno=0;
		hshlockvalues = new HashMap();
		hshlockvalues.put("apptype",Helper.correctNull((String)hshValues.get("hidloanapptype")));//to be pass
		hshlockvalues.put("comapp_id",strLapsappid);
		hshlockvalues.put("orgscode",correctNull((String) hshValues.get("strOrgShortCode")));
		double dblloanamnt=0.00,dblsubsidyamnt=0.00,dblROI=0.00,dblEMI=0.00;
		String strtenor="";			
		
		
		//strApplicationNo = (String) EJBInvoker.executeStateLess("appeditlock", hshlockvalues, "getAppno");
		String strOrgShortCode="",strBorrowerId="",strorgcode="",strscode="";
		String strAppno="";
		long longAppno=0;
		int intLen=0;
		java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
		nf.setMinimumIntegerDigits(7);
		nf.setGroupingUsed(false);
				strQuery=SQLParser.getSqlQuery("findBorrowerOrgPer^"+strLapsappid);
				if(rs != null)
				{
					rs.close();
				}
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strOrgShortCode =correctNull((String)rs.getString(1));
				}
			
			
			if(strOrgShortCode.equalsIgnoreCase(""))
			{
				
				strOrgShortCode=correctNull((String) hshValues.get("strOrgShortCode"));
			}
			strOrgShortCode = strOrgShortCode.trim();
			
			int scodeLength=strOrgShortCode.length();
			
				if(scodeLength==1){
					strOrgShortCode="00"+strOrgShortCode;
				}
				if(scodeLength==2){
					strOrgShortCode="0"+strOrgShortCode;
				}
			
			intLen=strOrgShortCode.length();
			strQuery=SQLParser.getSqlQuery("getAppno^"+intLen+"^"+strOrgShortCode);
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				longAppno=(rs.getLong(1));
			}
			longAppno++;
			strApplicationNo=strOrgShortCode+nf.format(longAppno);
		
		
		if(!strApplicationNo.equalsIgnoreCase(""))
		{
			intappno = Integer.parseInt(strApplicationNo.substring((strApplicationNo.length()-7), strApplicationNo.length()));
		}
		if (!(strApplicationNo.equalsIgnoreCase("new") && hidApploanType.equalsIgnoreCase("")))
		{
			intUpdatesize++;
			arrValues.add(strApplicationNo);
			if(Schemetype.equalsIgnoreCase("")){
				arrValues.add(getNPtoLAPSCommonLOV(Helper.correctNull((String)hshValues.get("SchemeName")),
						Helper.correctNull((String)hshValues.get("selsegment")),"PRODUCTCODE"));
				}else{
					arrValues.add(getNPtoLAPSCommonLOV1(Helper.correctNull((String)hshValues.get("SchemeName")),
							Helper.correctNull((String)hshValues.get("selsegment")),"PRODUCTCODE",Schemetype));
				}
			
			arrValues.add(correctNull((String) hshValues.get("strUserId")));
			arrValues.add(correctNull((String) hshValues.get("strOrgCode")));									
			arrValues.add(hidApploanType.toUpperCase());
			arrValues.add(strInwardno);
			arrValues.add("A");
			arrValues.add((strOrglevel.equalsIgnoreCase("D") && strissaral.equalsIgnoreCase("Y"))?"S":strOrglevel);
			arrValues.add(correctNull((String)hshValues.get("strUserId")));
			arrValues.add("Y");
			arrValues.add(correctNull((String)hshValues.get("sel_sustenance")));
			arrValues.add(strAppBankName);
			arrValues.add(String.valueOf(intappno));
			arrValues.add((strRefno));
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "insapplications_ret1");
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			/* For inserting in demographic table */
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			intUpdatesize++;
			arrValues.add(strApplicationNo);
			arrValues.add(strLapsappid);
			arrValues.add("a");
			arrValues.add("");
			arrValues.add("2");
			arrValues.add("");
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "perloandetailsdemoins1");
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			hshqueryval = new HashMap();
			HashMap hshquery = new HashMap();
			arrValues = new ArrayList();
			hshquery.put("strQueryId","updateapplicationsno_np");
			arrValues.add(strApplicationNo);
			arrValues.add(strRefno);//9
			hshquery.put("arrValues",arrValues);
			hshqueryval.put("size","1");
			hshqueryval.put("1",hshquery);						
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");

			
			/****
			 * For Updating in inward register
			 */
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","updinwardappatached");
			arrValues.add("Y");
			arrValues.add(strInwardno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
					
			
			String repaymenttype="",strissecurity="";
			strQuery = SQLParser.getSqlQuery("getPropertyDetails^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				repaymenttype= Helper.correctNull((String) rs.getString("NPPRD_REPAYMENTMODEID"));
					
			}
			 dblROI=0.0;
			Double dblReqamnt=0.0,dbltenure=0.0,dblcourseamnt=0.0,dblappcont=0.0;
			if(rs != null){rs.close();}
			strQuery = SQLParser.getSqlQuery("sel_npprincdet^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				String loanamt=Helper.correctNull((String)rs.getString("NPID_LOAN_AMT"));
				String emi=Helper.correctNull((String)rs.getString("NPID_EMI"));
				String roi=Helper.correctNull((String)rs.getString("NPID_ROI"));
				String subsidy_amt=Helper.correctNull((String)rs.getString("NPID_SUBSIDY_AMT"));
				if(!loanamt.equalsIgnoreCase("")){
					dblloanamnt = Double.parseDouble(loanamt);	
				}
				if(!emi.equalsIgnoreCase("")){
					dblEMI = Double.parseDouble(emi);	
				}
				if(!roi.equalsIgnoreCase("")){
					dblROI = Double.parseDouble(roi);	
				}
				if(!subsidy_amt.equalsIgnoreCase("")){
					dblsubsidyamnt =Double.parseDouble(subsidy_amt);	
				}
				
				strtenor = Helper.correctNull((String)rs.getString("NPID_TENOR"));
			}
			// For inserting in loandetails table 
			
			
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			intUpdatesize++;//
			arrValues.add(strApplicationNo);//1
			arrValues.add(String.valueOf(dblROI));//2
			arrValues.add(String.valueOf(dblloanamnt));//3
			arrValues.add(String.valueOf(dblcourseamnt));//4
			arrValues.add(String.valueOf(dbltenure));//5
			arrValues.add(String.valueOf(dblROI));//6
			arrValues.add(repaymenttype);		//7		
			arrValues.add(Helper.correctDouble((String) hshValues.get("txtMarginpercent")));//8
			arrValues.add(correctNull((String) hshValues.get("txt_branchreference")));	//9			
			arrValues.add("1");
			arrValues.add(String.valueOf(dblROI));//11
			arrValues.add(String.valueOf(dblsubsidyamnt));//12
			arrValues.add(String.valueOf(dblappcont));//13
			arrValues.add(String.valueOf(dblcourseamnt));//14
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "perloandetailsinsnp");
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
		
			
			String toorgcode="",togrpid="",fromgrpid="";
			if(rs != null){rs.close();}
			strQuery = SQLParser.getSqlQuery("sel_userorg_grpidapp1^"+strFromuserid);
			rs= DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				toorgcode=Helper.correctNull((String)rs.getString("USR_ORGCODE"));
				togrpid=Helper.correctNull((String)rs.getString("USR_GRPID"));
			}
			if(rs != null){rs.close();}
			strQuery = SQLParser.getSqlQuery("sel_userorg_grpidapp1^"+strFromuserid);
			rs= DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				fromgrpid=Helper.correctNull((String)rs.getString("USR_GRPID"));
			}
			
			ArrayList arrIds=new CommWorkflowBean().getFromToOrgLevel(strFromuserid,strFromuserid); // From To Org Level
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","commworkflowins");
			arrValues.add(strApplicationNo);
			arrValues.add(strFromuserid);
			arrValues.add(strFromuserid);
			arrValues.add("1");
			arrValues.add("1");
			arrValues.add("C");
			arrValues.add(Helper.correctNull((String)hshValues.get("strOrgCode")));			
			arrValues.add(toorgcode);			
			arrValues.add(fromgrpid);			
			arrValues.add(togrpid);
			arrValues.add(arrIds.get(0));			
			arrValues.add(arrIds.get(1));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			//	
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			intUpdatesize++;
			arrValues.add(strApplicationNo);
			if (strtenor.equals(""))
			{
				arrValues.add("0");
			}
			else
			{
				arrValues.add(strtenor);
			}
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "secureins");
			hshQueryValues.put(""+intUpdatesize, hshQuery);				
			hshQueryValues.put("size", Integer.toString(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");

			hshLoanProduct.put("appno", strApplicationNo);
			hshLoanProduct.put("prdcode",getNPtoLAPSCommonLOV(Helper.correctNull((String)hshValues.get("SchemeName")),
					Helper.correctNull((String)hshValues.get("selsegment")),"PRODUCTCODE"));
			hshLoanProduct.put("radLoan", "Y");
			hshLoanProduct.put("hidapplicantid",strLapsappid);
			hshLoanProduct.put("page", "ep");
			hshLoanProduct.put("strUserId", correctNull((String) hshValues.get("strUserId")));
			hshLoanProduct.put("strGroupRights", correctNull((String) hshValues.get("strGroupRights")));
			
			
			
			strQuery = SQLParser.getSqlQuery("sel_npcoappdet^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			while(rs.next())
			{		
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","perloandetailsdemoins1");	
				arrValues.add(strApplicationNo);
				
				String StrName=Helper.correctNull((String)rs.getString("NPCD_FNAME"))+" "+Helper.correctNull((String)rs.getString("NPCD_LNAME"))+" "+Helper.correctNull((String)rs.getString("NPCD_MNAME"));
				String PerAppid="";
				strQuery = SQLParser.getSqlQuery("selperappid_np^"+strRefno+"^"+StrName);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					PerAppid=Helper.correctNull((String)rs1.getString("NP_LAPSID"));
				}
				
				arrValues.add(PerAppid);
				if(Helper.correctNull((String)rs.getString("NPCD_ISGUARANTOR")).equalsIgnoreCase("2"))
				{
					arrValues.add("g");
				}
				else
				{
					arrValues.add("c");
				}
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_RELATION")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPCD_INCOME_CONSIDER")));
				arrValues.add("");			
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
			}
			
		
			if(rs != null){rs.close();}
				strQuery = SQLParser.getSqlQuery("getPropertyDetails^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				while(rs.next())
				{
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();			
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","ins_Nportal_propdetails");
					arrValues.add(strApplicationNo);
					arrValues.add(Helper.correctNull((String)rs.getString("NPPRD_PURPOSEOFLOANID")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPRD_SELLERNAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPRD_TYPEOFPROPERTYID")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPRD_TYPEOFAREAID")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPRD_AREAOFPROPERTY")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPRD_AGEOFPROPERTY")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPRD_COSTOFPROPERTY")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPRD_REGISTRATIONFEE")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);	
					hshQueryValues.put("size","1");	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				int intSize=0;
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				String prdcode="";
				strQuery = SQLParser.getSqlQuery("sel_productcode^"+ strApplicationNo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					prdcode=correctNull((String)rs.getString("app_prdcode"));
				}
				if(!prdcode.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("getprodcode^"+prdcode);
					rs = DBUtils.executeQuery(strQuery);
					while (rs.next())
					{
						intSize++;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("arrValues", arrValues);
						String status = "N";
						arrValues.add(correctNull((String)rs.getString("doc_code")));						
						arrValues.add(correctNull((String)rs.getString("doc_create_date")));
						
						if (correctNull(rs.getString("Doc_type")).equalsIgnoreCase("a"))
						{
							arrValues.add("PA");
						}
						else if (correctNull(rs.getString("Doc_type")).equalsIgnoreCase("i"))
						{
							arrValues.add("PI");
						}
						
						arrValues.add(correctNull(strApplicationNo));
						arrValues.add(status);
						hshQuery.put("strQueryId", "insappdocuments");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intSize),hshQuery);
						
					}
					hshQueryValues.put("size",String.valueOf(intSize));
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
				}
		}
		
	}
	catch(Exception ex)
	{
		Logger.log("Exception in getNpapplications"+ex);
	}	
	return hsh;
}
public HashMap getNP_AgriApplicationCreation(HashMap hshValues) 
{
	ResultSet rs = null;
	ResultSet rs1 = null;
	HashMap hshRecord = new HashMap();
	HashMap hsh = new HashMap();
	String strQuery = "",strquery1="";
	HashMap hshQuery = new HashMap();
	ArrayList arrValues = new ArrayList();
	HashMap hshQueryValues = new HashMap();
	String strbranchcode=Helper.correctNull((String)hshValues.get("strOrgShortCode"));
	String strusrid=Helper.correctNull((String)hshValues.get("strUserId"));
	String strStatus=Helper.correctNull((String)hshValues.get("hidaction"));
	String strRefno = Helper.correctNull((String)hshValues.get("hidRefId"));
	MastApplicantBean CustPrfAppID = new MastApplicantBean();
	String LapsAppid="";
	HashMap hshResult = new HashMap();
	HashMap hshLoanProduct = new HashMap();
	HashMap hshlockvalues = new HashMap();
	String strApplicationNo="";
	int intUpdatesize=0;
	String hidApploanType = "A";
	String strOrglevel=correctNull((String)hshValues.get("strOrgLevel"));
    String strissaral=correctNull((String)hshValues.get("strIsSaral"));
	String strOrgbankFlag=correctNull((String)hshValues.get("strOrgbankFlag"));
	String strAppBankName=correctNull((String)hshValues.get("strAppBankName"));
    String strFromuserid=Helper.correctNull((String)hshValues.get("strUserId"));
    if(strRefno.equalsIgnoreCase("")){
    	strRefno  = Helper.correctNull((String)hshValues.get("hidApplicantId"));
    }
    String selsegment = Helper.correctNull((String)hshValues.get("selsegment"));
	if(selsegment.equalsIgnoreCase("")){
		selsegment = Helper.correctNull((String)hshValues.get("SegType"));
		}
	
	HashMap hshqueryval = new HashMap();
	ArrayList arr = new ArrayList();

	try
	{	String Schemetype="";
	strQuery = SQLParser.getSqlQuery("sel_applicationscheme_np^"+strRefno);
	rs = DBUtils.executeQuery(strQuery);			
	if(rs.next())
	{
		Schemetype=Helper.correctNull((String)rs.getString("NPDT_NP_SCHEME_NAME"));
	}		
		String strInwardno="",strappno="",strLapsappid="";
		if(rs != null){rs.close();}
		strQuery = SQLParser.getSqlQuery("sel_npapplicationdetails^"+strRefno);
		rs = DBUtils.executeQuery(strQuery);			
		if(rs.next())
		{			
			strInwardno = Helper.correctNull((String)rs.getString("NPDT_INWARDNO"));	
		}
		if(rs != null){rs.close();}
		String StrName1="";
		strQuery = SQLParser.getSqlQuery("sel_nppersonaldetails^"+strRefno);
		rs = DBUtils.executeQuery(strQuery);			
		if(rs.next())
		{			
			StrName1 = Helper.correctNull((String)rs.getString("NPPD_FIRST_NAME"))+" "+Helper.correctNull((String)rs.getString("NPPD_LAST_NAME"))+" "+Helper.correctNull((String)rs.getString("NPPD_MIDDLE_NAME"));	
			strLapsappid=Helper.correctNull((String)rs.getString("NPPD_LAPSAPPID"));
		}
		if(strLapsappid.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("getAgriPersonalDetails^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{			
				StrName1 = Helper.correctNull((String)rs.getString("NPAAPD_FIRST_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAAPD_LAST_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAAPD_MIDDLE_NAME"));	
				strLapsappid=Helper.correctNull((String)rs.getString("NPAAPD_LAPSID"));
			}
		}
		if(strLapsappid.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("getPersonalDetails_NPUM^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{			
				StrName1 = Helper.correctNull((String)rs.getString("NPLPD_LHPD_F_NAME"))+" "+Helper.correctNull((String)rs.getString("NPLPD_LHPD_L_NAME"))+" "+Helper.correctNull((String)rs.getString("NPLPD_LHPD_M_NAME"));	
				strLapsappid=Helper.correctNull((String)rs.getString("NPLPD_LAPSID"));
			}
		}
		
		
		
		
		int intappno=0;
		hshlockvalues = new HashMap();
		hshlockvalues.put("apptype",Helper.correctNull((String)hshValues.get("hidloanapptype")));//to be pass
		hshlockvalues.put("comapp_id",strLapsappid);
		hshlockvalues.put("orgscode",correctNull((String) hshValues.get("strOrgShortCode")));
		double dblloanamnt=0.00,dblsubsidyamnt=0.00,dblROI=0.00,dblEMI=0.00;
		String strtenor="";			
		
		
		//strApplicationNo = (String) EJBInvoker.executeStateLess("appeditlock", hshlockvalues, "getAppno");
			String strOrgShortCode="",strBorrowerId="",strorgcode="",strscode="";
			String strAppno="";
			long longAppno=0;
			int intLen=0;
			java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
			nf.setMinimumIntegerDigits(7);
			nf.setGroupingUsed(false);
					strQuery=SQLParser.getSqlQuery("findBorrowerOrgPer^"+strLapsappid);
					if(rs != null)
					{
						rs.close();
					}
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strOrgShortCode =correctNull((String)rs.getString(1));
					}
				
				
				if(strOrgShortCode.equalsIgnoreCase(""))
				{
					
					strOrgShortCode=correctNull((String) hshValues.get("strOrgShortCode"));
				}
				strOrgShortCode = strOrgShortCode.trim();
				
				int scodeLength=strOrgShortCode.length();
				
				if(scodeLength==1){
					strOrgShortCode="000"+strOrgShortCode;
				}
				if(scodeLength==2){
					strOrgShortCode="00"+strOrgShortCode;
				}
				if(scodeLength==3){
					strOrgShortCode="0"+strOrgShortCode;
				}
				intLen=strOrgShortCode.length();
				strQuery=SQLParser.getSqlQuery("getAppno^"+(intLen+1)+"^"+intLen+"^"+strOrgShortCode);
				//strQuery=SQLParser.getSqlQuery("getAppno^"+intLen+"^"+strOrgShortCode);
				if(rs!=null)
				{
					rs.close();
				}
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					longAppno=(rs.getLong(1));
				}
				longAppno++;
				strApplicationNo=strOrgShortCode+nf.format(longAppno);
				String StrNames="",strNewapp="",strLapsid="",strCbsid="";
				
				
				strQuery = SQLParser.getSqlQuery("seldedupecheck_np^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					strLapsid=Helper.correctNull((String)rs.getString("NP_LAPSID"));
					strNewapp=Helper.correctNull((String)rs.getString("NP_ISNEW"));
					strCbsid=Helper.correctNull((String)rs.getString("NP_CBSID"));
					StrNames=Helper.correctNull((String)rs.getString("NP_APPLICANTNAME"));
				}
			
		if(!strApplicationNo.equalsIgnoreCase(""))
		{
			intappno = Integer.parseInt(strApplicationNo.substring((strApplicationNo.length()-7), strApplicationNo.length()));
		}
		if (!(strApplicationNo.equalsIgnoreCase("new") && hidApploanType.equalsIgnoreCase("")))
		{
			intUpdatesize++;
			arrValues.add(strApplicationNo);
			if(Schemetype.equalsIgnoreCase("")){
				arrValues.add(getNPtoLAPSCommonLOV(Helper.correctNull((String)hshValues.get("SchemeName")),
						Helper.correctNull((String)hshValues.get("selsegment")),"PRODUCTCODE"));
				}else{
					arrValues.add(getNPtoLAPSCommonLOV1(Helper.correctNull((String)hshValues.get("SchemeName")),
							Helper.correctNull((String)hshValues.get("selsegment")),"PRODUCTCODE",Schemetype));
				}
			arrValues.add(correctNull((String) hshValues.get("strUserId")));
			arrValues.add(correctNull((String) hshValues.get("strOrgCode")));	
			arrValues.add(hidApploanType.toUpperCase());
			arrValues.add(strInwardno);
			arrValues.add("A");
			arrValues.add((strOrglevel.equalsIgnoreCase("D") && strissaral.equalsIgnoreCase("Y"))?"S":strOrglevel);
			arrValues.add(correctNull((String)hshValues.get("strUserId")));
			arrValues.add("Y");
			arrValues.add(correctNull((String)hshValues.get("sel_sustenance")));
			arrValues.add(strAppBankName);
			arrValues.add(String.valueOf(intappno));
			arrValues.add((strRefno));
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "insapplications_ret1");
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			/* For inserting in demographic table */
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			intUpdatesize++;
			arrValues.add(strApplicationNo);
			arrValues.add(strLapsappid);
			arrValues.add(strLapsappid);
			/*arrValues.add("a");
			arrValues.add("");
			arrValues.add("2");
			arrValues.add("");*/
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "facilitydemoins1");
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			hshqueryval = new HashMap();
			HashMap hshquery = new HashMap();
			arrValues = new ArrayList();
			hshquery.put("strQueryId","updateapplicationsno_np");
			arrValues.add(strApplicationNo);
			arrValues.add(strRefno);//9
			hshquery.put("arrValues",arrValues);
			hshqueryval.put("size","1");
			hshqueryval.put("1",hshquery);						
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");

			
			/****
			 * For Updating in inward register
			 */
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","updinwardappatached1");
			arrValues.add("Y");
			arrValues.add("E");
			arrValues.add(strCbsid);
			arrValues.add(strInwardno);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			
			
			
			
			if(selsegment.equalsIgnoreCase("LHD")){
				
				double dblmargin=0.00,dblperposeloan=0.00,dblrequestedamt=0.00;
				String strperposeloan="";
				if(rs != null){rs.close();}
				strQuery = SQLParser.getSqlQuery("getNULMLoanDetails^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					String requestedamt=Helper.correctNull((String)rs.getString("NULM_TOTAL_COST"));
					if(!requestedamt.equalsIgnoreCase("")){
						dblrequestedamt = Double.parseDouble(requestedamt);	
					}
					strperposeloan=Helper.correctNull((String)rs.getString("NULM_PURPOSE_OF_LOAN"));
					
					
				}
				Double dblEmi=0.0,dblMargin=0.0;
				if(rs != null){rs.close();}
				strQuery = SQLParser.getSqlQuery("sel_npprincdet^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					String loanamnt=Helper.correctNull((String)rs.getString("NPID_LOAN_AMT"));
					if(!loanamnt.equalsIgnoreCase("")){
						dblloanamnt = Double.parseDouble(loanamnt);	
					}
					String subsidyamnt=Helper.correctNull((String)rs.getString("NPID_SUBSIDY_AMT"));
					if(!subsidyamnt.equalsIgnoreCase("")){
						dblsubsidyamnt = Double.parseDouble(subsidyamnt);	
					}
					String ROI=Helper.correctNull((String)rs.getString("NPID_ROI"));
					if(!ROI.equalsIgnoreCase("")){
						dblROI = Double.parseDouble(ROI);	
					}
					String EMI=Helper.correctNull((String)rs.getString("NPID_EMI"));
					if(!EMI.equalsIgnoreCase("")){
						dblEmi = Double.parseDouble(EMI);	
					}
					strtenor = Helper.correctNull((String)rs.getString("NPID_TENOR"));
				}
				if(rs != null){rs.close();}
				strQuery = SQLParser.getSqlQuery("sel_marginval_np^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					String Margin=Helper.correctNull((String)rs.getString("minmargin"));
					if(!Margin.equalsIgnoreCase("")){
						dblMargin = Double.parseDouble(Margin);	
					}
					
				}
				Double dblReqamnt=0.0,dbltenure=0.0,dblcourseamnt=0.0,dblappcont=0.0;
				
				//insert into facilities
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				//intUpdatesize++;
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId", "insFacility_NP");
				/*arrValues.add(strApplicationNo);//1
				arrValues.add(String.valueOf(dblROI));//2
				arrValues.add(String.valueOf(dblloanamnt));//3
				arrValues.add(String.valueOf(dblrequestedamt));//4
				arrValues.add(String.valueOf(dbltenure));//5
				arrValues.add(String.valueOf(dblROI));//6
				arrValues.add(correctNull((String) hshValues.get("selrepaymenttype")));		//7		
				arrValues.add(String.valueOf(dblMargin));//8
				arrValues.add(correctNull((String) hshValues.get("txt_branchreference")));	//9			
				arrValues.add("1");
				arrValues.add(String.valueOf(dblROI));//11
				arrValues.add(String.valueOf(dblsubsidyamnt));//12
				arrValues.add(String.valueOf(dblappcont));//13
				arrValues.add(String.valueOf(dblcourseamnt));//14
*/				
				arrValues.add(strApplicationNo);
				arrValues.add("1");
				arrValues.add(String.valueOf(dbltenure));
				arrValues.add("");
				arrValues.add(String.valueOf(dblROI));
				arrValues.add(String.valueOf(dblloanamnt));
				arrValues.add("0");
				arrValues.add("180");
				arrValues.add("4");
				arrValues.add("32");
				arrValues.add(strLapsappid);
				arrValues.add(String.valueOf(dblloanamnt));
				arrValues.add("1");
				arrValues.add("R");
				arrValues.add(String.valueOf(dblROI));
				hshQuery.put("arrValues", arrValues);
				
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				
			
				
				String toorgcode="",togrpid="",fromgrpid="";
				if(rs != null){rs.close();}
				strQuery = SQLParser.getSqlQuery("sel_userorg_grpidapp1^"+strFromuserid);
				rs= DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					toorgcode=Helper.correctNull((String)rs.getString("USR_ORGCODE"));
					togrpid=Helper.correctNull((String)rs.getString("USR_GRPID"));
				}
				if(rs != null){rs.close();}
				strQuery = SQLParser.getSqlQuery("sel_userorg_grpidapp1^"+strFromuserid);
				rs= DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					fromgrpid=Helper.correctNull((String)rs.getString("USR_GRPID"));
				}
				
				//ArrayList arrIds=new CommWorkflowBean().getFromToOrgLevel(strFromuserid,strFromuserid); // From To Org Level
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId","commworkflowins");
				arrValues.add(strApplicationNo);
				arrValues.add(strFromuserid);
				arrValues.add(strFromuserid);
				arrValues.add("1");
				arrValues.add("1");
				arrValues.add("C");
				arrValues.add(Helper.correctNull((String)hshValues.get("strOrgCode")));			
				arrValues.add(toorgcode);			
				arrValues.add(fromgrpid);			
				arrValues.add(togrpid);
				//arrValues.add(arrIds.get(0));			
				//arrValues.add(arrIds.get(1));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				//	
			/*	arrValues = new ArrayList();
				hshQuery = new HashMap();
				intUpdatesize++;
				arrValues.add(strApplicationNo);
				if (strtenor.equals(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(strtenor);
				}
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "secureins");
				hshQueryValues.put(""+intUpdatesize, hshQuery);	*/			
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");

				
				if(rs != null){rs.close();}
				strQuery = SQLParser.getSqlQuery("sel_npcoappdet^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				while(rs.next())
				{		
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","facilitydemoins1");	
					arrValues.add(strApplicationNo);
					
					String StrName=Helper.correctNull((String)rs.getString("NPCD_FNAME"))+" "+Helper.correctNull((String)rs.getString("NPCD_LNAME"))+" "+Helper.correctNull((String)rs.getString("NPCD_MNAME"));
					String PerAppid="";
					strQuery = SQLParser.getSqlQuery("selperappid_np^"+strRefno+"^"+StrName);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						PerAppid=Helper.correctNull((String)rs1.getString("NP_LAPSID"));
					}
					
					arrValues.add(PerAppid);
					arrValues.add(PerAppid);
					/*if(Helper.correctNull((String)rs.getString("NPCD_ISGUARANTOR")).equalsIgnoreCase("2"))
					{
						arrValues.add("g");
					}
					else
					{
						arrValues.add("c");
					}
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_RELATION")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_INCOME_CONSIDER")));
					arrValues.add("");			*/
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
				}
				
			}else{
				Double dblEmi=0.0;
				if(rs != null){rs.close();}
				strQuery = SQLParser.getSqlQuery("sel_npprincdet^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					String loanamnt=Helper.correctNull((String)rs.getString("NPID_LOAN_AMT"));
					if(!loanamnt.equalsIgnoreCase("")){
						dblloanamnt = Double.parseDouble(loanamnt);	
					}
					String subsidyamnt=Helper.correctNull((String)rs.getString("NPID_SUBSIDY_AMT"));
					if(!subsidyamnt.equalsIgnoreCase("")){
						dblsubsidyamnt = Double.parseDouble(subsidyamnt);	
					}
					String ROI=Helper.correctNull((String)rs.getString("NPID_ROI"));
					if(!ROI.equalsIgnoreCase("")){
						dblROI = Double.parseDouble(ROI);	
					}
					String EMI=Helper.correctNull((String)rs.getString("NPID_EMI"));
					if(!EMI.equalsIgnoreCase("")){
						dblEmi = Double.parseDouble(EMI);	
					}
					strtenor = Helper.correctNull((String)rs.getString("NPID_TENOR"));
				}
				
				
				
				
				double dblReqamnt=0.00,dbltenure=0.00,dblcourseamnt=0.00,dblrepayint1=0.00,dblappcont=0.00,dblMargin=0.00,dblmaxmargin=0.00;
				String strissecurity="",strrepaymentby="",dblrepayint="";
				if(rs != null){rs.close();}
				strQuery = SQLParser.getSqlQuery("sel_reqamtownval_np^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					String Reqamnt=Helper.correctNull((String)rs.getString("NLD_REQUIREDLOANAMT"));
					if(!Reqamnt.equalsIgnoreCase("")){
						dblReqamnt = Double.parseDouble(Reqamnt);	
					}
					String maxmargin=Helper.correctNull((String)rs.getString("NLD_OWNCONTRIBUTION"));
					if(!maxmargin.equalsIgnoreCase("")){
						dblmaxmargin = Double.parseDouble(maxmargin);	
					}
				}
								
				if(rs != null){rs.close();}
				strQuery = SQLParser.getSqlQuery("sel_marginval_np^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					String Margin=Helper.correctNull((String)rs.getString("minmargin"));
					if(!Margin.equalsIgnoreCase("")){
						dblMargin = Double.parseDouble(Margin);	
					}
					
				}
				// For inserting in loandetails table 
				/*arrValues = new ArrayList();
				hshQuery = new HashMap();
				intUpdatesize++;//
				arrValues.add(strApplicationNo);//1
				arrValues.add(String.valueOf(dblROI));//2
				arrValues.add(String.valueOf(dblReqamnt));//3
				arrValues.add(String.valueOf(dblcourseamnt));//4
				arrValues.add(String.valueOf(dbltenure));//5
				arrValues.add(String.valueOf(dblROI));//6
				arrValues.add(correctNull((String) hshValues.get("selrepaymenttype")));		//7		
				arrValues.add(String.valueOf(dblMargin));//8
				arrValues.add(correctNull((String) hshValues.get("txt_branchreference")));	//9			
				arrValues.add("1");
				arrValues.add(String.valueOf(dblROI));//11
				arrValues.add(String.valueOf(dblsubsidyamnt));//12
				arrValues.add(String.valueOf(dblappcont));//13
				arrValues.add(String.valueOf(dblcourseamnt));//14
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "perloandetailsinsnp");
				hshQueryValues.put(""+intUpdatesize, hshQuery);*/
				
				
/*Double dblReqamnt=0.0,dbltenure=0.0,dblcourseamnt=0.0,dblappcont=0.0;*/
				
				//insert into facilities
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				intUpdatesize++;
				
				/*arrValues.add(strApplicationNo);//1
				arrValues.add(String.valueOf(dblROI));//2
				arrValues.add(String.valueOf(dblloanamnt));//3
				arrValues.add(String.valueOf(dblrequestedamt));//4
				arrValues.add(String.valueOf(dbltenure));//5
				arrValues.add(String.valueOf(dblROI));//6
				arrValues.add(correctNull((String) hshValues.get("selrepaymenttype")));		//7		
				arrValues.add(String.valueOf(dblMargin));//8
				arrValues.add(correctNull((String) hshValues.get("txt_branchreference")));	//9			
				arrValues.add("1");
				arrValues.add(String.valueOf(dblROI));//11
				arrValues.add(String.valueOf(dblsubsidyamnt));//12
				arrValues.add(String.valueOf(dblappcont));//13
				arrValues.add(String.valueOf(dblcourseamnt));//14
*/				
				arrValues.add(strApplicationNo);
				arrValues.add("1");
				arrValues.add(String.valueOf(dbltenure));
				arrValues.add("");
				arrValues.add(String.valueOf(dblROI));
				arrValues.add(String.valueOf(dblloanamnt));
				arrValues.add("0");
				arrValues.add("180");
				arrValues.add("4");
				arrValues.add("32");
				arrValues.add(strLapsappid);
				arrValues.add(String.valueOf(dblloanamnt));
				arrValues.add("1");
				arrValues.add("R");
				arrValues.add(String.valueOf(dblROI));
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "insFacility_NP");
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				
			
				
				String toorgcode="",togrpid="",fromgrpid="";
				if(rs != null){rs.close();}
				strQuery = SQLParser.getSqlQuery("sel_userorg_grpidapp1^"+strFromuserid);
				rs= DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					toorgcode=Helper.correctNull((String)rs.getString("USR_ORGCODE"));
					togrpid=Helper.correctNull((String)rs.getString("USR_GRPID"));
				}
				if(rs != null){rs.close();}
				strQuery = SQLParser.getSqlQuery("sel_userorg_grpidapp1^"+strFromuserid);
				rs= DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					fromgrpid=Helper.correctNull((String)rs.getString("USR_GRPID"));
				}
				
				//ArrayList arrIds=new CommWorkflowBean().getFromToOrgLevel(strFromuserid,strFromuserid); // From To Org Level
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId","commworkflowins");
				arrValues.add(strApplicationNo);
				arrValues.add(strFromuserid);
				arrValues.add(strFromuserid);
				arrValues.add("1");
				arrValues.add("1");
				arrValues.add("C");
				arrValues.add(Helper.correctNull((String)hshValues.get("strOrgCode")));			
				arrValues.add(toorgcode);			
				arrValues.add(fromgrpid);			
				arrValues.add(togrpid);
				//arrValues.add(arrIds.get(0));			
				//arrValues.add(arrIds.get(1));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				//	
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				intUpdatesize++;
				arrValues.add(strApplicationNo);
				if (strtenor.equals(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(strtenor);
				}
				arrValues.add("");
				arrValues.add(strissecurity);
				arrValues.add("");
				arrValues.add("");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "secureins");
				hshQueryValues.put(""+intUpdatesize, hshQuery);				
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");

				
				if(rs != null){rs.close();}
				strQuery = SQLParser.getSqlQuery("sel_npcoappdet^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				while(rs.next())
				{		
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","facilitydemoins1");	
					arrValues.add(strApplicationNo);
					
					String StrName=Helper.correctNull((String)rs.getString("NPCD_FNAME"))+" "+Helper.correctNull((String)rs.getString("NPCD_LNAME"))+" "+Helper.correctNull((String)rs.getString("NPCD_MNAME"));
					String PerAppid="";
					strQuery = SQLParser.getSqlQuery("selperappid_np^"+strRefno+"^"+StrName);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						PerAppid=Helper.correctNull((String)rs1.getString("NP_LAPSID"));
					}
					
					arrValues.add(PerAppid);
					arrValues.add(PerAppid);
					/*if(Helper.correctNull((String)rs.getString("NPCD_ISGUARANTOR")).equalsIgnoreCase("2"))
					{
						arrValues.add("g");
					}
					else
					{
						arrValues.add("c");
					}
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_RELATION")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_INCOME_CONSIDER")));
					arrValues.add("");		*/	
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
				}
				String AddSeqNo="";
				strQuery=SQLParser.getSqlQuery("getAgriLoanDetails^"+strRefno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
				AddSeqNo = Helper.correctNull((String) rs.getString("NLD_ADDRESS_SEQNO"));
	            }
				if(rs != null)
				{
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("getAddressDetails^"+strRefno+"^"+AddSeqNo);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					hshqueryval = new HashMap();
					hshquery = new HashMap();
					arrValues = new ArrayList();
					String strAppCode = CustPrfAppID.getApplicantCode();
					hshquery.put("strQueryId","int_agrilandholding_np");
					arrValues.add(strApplicationNo);
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_ADD_SEQ_NO")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_VILLAGE")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_CITY_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME")));
					arrValues.add(strAppCode);
					hshquery.put("arrValues",arrValues);
					hshqueryval.put("size","1");
					hshqueryval.put("1",hshquery);						
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				}
				
				
				int n=0;
				strQuery = SQLParser.getSqlQuery("sel_npdocuments^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					n++;
					hshqueryval = new HashMap();
					hshquery = new HashMap();
					arrValues = new ArrayList();
					hshquery.put("strQueryId","ins_Dcouments_np");
					arrValues.add(strApplicationNo);
					arrValues.add(String.valueOf(n));
					arrValues.add(Helper.correctNull((String)rs.getString("NPUD_DOC_TYPE")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPUD_DOCUMENT")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPUD_DOC_TYPE")));
					hshquery.put("arrValues",arrValues);
					hshqueryval.put("size","1");
					hshqueryval.put("1",hshquery);						
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				}
				
				}
			}
			int intSize=0;
			String prdcode="";
			HashMap hshquery = new HashMap();
			strQuery = SQLParser.getSqlQuery("sel_productcode^"+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				prdcode=correctNull((String)rs.getString("app_prdcode"));
			}
			if(!prdcode.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("getprodcode^"+prdcode);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				hshqueryval = new HashMap();
				hshquery = new HashMap();
				arrValues = new ArrayList();
				hshquery.put("strQueryId","insappdocuments");
				String status = "N";
				arrValues.add(correctNull((String)rs.getString("doc_code")));						
				arrValues.add(correctNull((String)rs.getString("doc_create_date")));
				
				if (correctNull(rs.getString("Doc_type")).equalsIgnoreCase("a"))
				{
					arrValues.add("PA");
				}
				else if (correctNull(rs.getString("Doc_type")).equalsIgnoreCase("i"))
				{
					arrValues.add("PI");
				}
				
				arrValues.add(correctNull(strApplicationNo));
				arrValues.add(status);
				hshquery.put("arrValues",arrValues);
				hshqueryval.put("size","1");
				hshqueryval.put("1",hshquery);						
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			
			
		}
		/*strQuery = SQLParser.getSqlQuery("sel_scoring_np^"+strRefno);
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			
			hshqueryval = new HashMap();
			hshquery = new HashMap();
			arrValues = new ArrayList();
			hshquery.put("strQueryId","int_riskscoring_np");
			arrValues.add(strApplicationNo);
			arrValues.add(Helper.correctNull((String)rs.getString("NP_SCO_DET_ACTUALRANGE")));
			arrValues.add(Helper.correctNull((String)rs.getString("NP_SCO_DET_ACTUALVALBOR")));
			arrValues.add(Helper.correctNull((String)rs.getString("NP_SCO_DET_PARAMETER")));
			arrValues.add(Helper.correctNull((String)rs.getString("NP_SCO_DET_TYPE")));
			hshquery.put("arrValues",arrValues);
			hshqueryval.put("size","1");
			hshqueryval.put("1",hshquery);						
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
		}*/
		
	}
	catch(Exception ex)
	{
		Logger.log("Exception in getNpapplications"+ex);
	}	
	return hsh;
}
public HashMap Nationalportaldocdownload(HashMap hshValues) 
{
	HashMap hshResult=new HashMap();
	ResultSet rs=null;
	String strQuery;	
	Connection connection = null;
	Statement statement = null;
	String strFileExtension="",strMimeType="",strFileName1="",FileName="",strFileName="";
	String strRefId=Helper.correctNull((String)hshValues.get("strRefId"));	
	if(strRefId.equalsIgnoreCase(""))
	{
		strRefId=Helper.correctNull((String)hshValues.get("strApplicationRefNo"));
	}
	String strSlno=Helper.correctNull((String)hshValues.get("hidSno"));
	byte[] byteDocData = null;
	Blob Blobdata=null;
	String strDocSize="";
	String downloadflag= Helper.correctNull((String)hshValues.get("download")); 
	String FilePath=ApplicationParams.getFinacialloaction();
	try
	{	
		AttachPhotoBean attatchPhotoBean = new AttachPhotoBean();
		connection=getConnection();
		statement=connection.createStatement();
		strFileName1 = strRefId+"_RESPONSE";
		Blob btemp = null;
		byte[] byteImgData = null;
					
		strQuery=SQLParser.getSqlQuery("sel_NPdocView1^"+strRefId+"^"+strSlno );			
		rs=DBUtils.executeQuery(strQuery);
		if(rs != null)
		{
		if(rs.next())
		{
				String strDocId = (String)(rs.getString(1));
				String strInwardNo = (String)(rs.getString(2));
				System.out.print("starting for image code"+btemp);
				btemp = (rs.getBlob(3));
				System.out.print("blob value"+btemp);
				byteImgData=btemp.getBytes(0, (int) btemp.length());
				strFileName = Helper.correctNull((String)(rs.getString(4)));
				System.out.print("file name"+strFileName);
				if(!strFileName.equalsIgnoreCase(""))
				{
					strFileExtension = strFileName.substring(strFileName.lastIndexOf(".")+1,strFileName.length());
				}
				System.out.print("file ext"+strFileExtension);
				strDocSize ="";
			}
			strMimeType = FileManager.getMimeType(strFileExtension.trim());
		
		}
		
		hshResult.put("retdoc_file",byteImgData);
		if(byteImgData!=null)
		{		
			hshResult.put("photoimg", byteImgData);
			hshResult.put("FILE_STREAM_NAME", strFileName );
			hshResult.put("FILE_STREAM_TYPE", strMimeType);
			hshResult.put("FILE_STREAM", byteImgData);
			hshResult.put("FILE_STREAM_DISPOSITION_TYPE","inline");
			hshResult.put("strDocSize", strDocSize);
			 System.out.println("photoimg   -"+byteImgData);
			 System.out.println("FILE_STREAM_NAME   -"+strFileName);
			 System.out.println("FILE_STREAM_TYPE   -"+strMimeType);
		}
		
	}
	catch(Exception e)
	{
		throw new EJBException("Error in ApplicationBean ===> viewAttachedDocument method"+e.getMessage());		
	}
	finally
	{
		try
		{
			if(connection!=null)
			{
				connection.close();
			}
			if(statement!=null)
			{
				statement.close();
			}
			if(rs!=null)
			{
				rs.close();
			}				 
		}
		catch(Exception e)
		{
			throw new EJBException("Error in closing Connection (AttachDocumentBean ==> viewAttachedDocument)"+e.getMessage());
		}
	}
	return hshResult;
}
public HashMap getNPCustProfileCreation_BS(HashMap hshValues) 
{
	ResultSet rs = null;
	ResultSet rs1 = null;
	ResultSet rs3 = null;
	HashMap hshRecord = new HashMap();
	HashMap hsh = new HashMap();
	String strQuery = "",strquery1="";
	HashMap hshQuery = new HashMap();
	ArrayList arrValues = new ArrayList();
	HashMap hshQueryValues = new HashMap();
	String strbranchcode=Helper.correctNull((String)hshValues.get("strOrgShortCode"));
	String strOrgSelect=Helper.correctNull((String)hshValues.get("strOrgSelect"));
	String strusrid=Helper.correctNull((String)hshValues.get("strUserId"));
	String strStatus=Helper.correctNull((String)hshValues.get("hidaction"));
	String strRefno = Helper.correctNull((String)hshValues.get("hidRefId"));
	String strRef = Helper.correctNull((String)hshValues.get("hidRefId"));
	String StrOfficeAddr1="",StrOfficeAddr2="",StrOfficeAddrCity="",StrOfficeAddrDist="",StrOfficeAddrState="",StrOfficeAddrCountry="",StrOfficeAddrPin="";
	String StrAadhaarAddr1="",StrAadhaarAddr2="",StrAadhaarAddrCity="",StrAadhaarAddrDist="",StrAadhaarAddrState="",StrAadhaarAddrCountry="",StrAadhaarAddrPin="";
	String StrCurrAddr1="",StrCurrAddr2="",StrCurrAddrACity="",StrCurrAddrDist="",StrCurrAddrState="",StrCurrAddrCountry="",StrCurrAddrPin="";
	String LapsAppid="";
	String stroccpation="",strcoappemptype="",StrAadhaarAddrSeq="",StrCurrAddrSeq="",StrOfficeAddrSeq="",StrEmail="",StrMobileNum="";
	String strBusinessEnterprise="0",strGSTNo="",strCommencementdate="",strIsunitreg="",
	strvoter_id="",str_mailid="",str_drivinglic="";
	String strRegistrationdate="";
	String strMudraindustrytype="";
	CommAppMasterBean CustPrfAppID = new CommAppMasterBean();
	HashMap hshappcr = new HashMap();
	String strEmail="";
	try
	{	
		String strLapsid="",strNewapp="",strCbsid="",StrName1="";
		strQuery = SQLParser.getSqlQuery("seldedupecheck_np^"+strRefno);
		rs = DBUtils.executeQuery(strQuery);			
		if(rs.next())
		{
			strLapsid=Helper.correctNull((String)rs.getString("NP_LAPSID"));
			strNewapp=Helper.correctNull((String)rs.getString("NP_ISNEW"));
			strCbsid=Helper.correctNull((String)rs.getString("NP_CBSID"));
			StrName1=Helper.correctNull((String)rs.getString("NP_APPLICANTNAME"));
		}
		String strSchemeName="",strSchemeName1="",strSchemeType="";
		strQuery = SQLParser.getSqlQuery("sel_npapplicationdetails^"+strRef);
		rs = DBUtils.executeQuery(strQuery);
		if (rs.next())
		{
			strSchemeName1=Helper.correctNull((String)rs.getString("NPDT_SCHEMENAME")); 
			strSchemeType=Helper.correctNull((String)rs.getString("NPDT_SCHEMETYPE"));
			strSchemeName=Helper.correctNull((String)rs.getString("NPDT_NP_SCHEME_NAME"));
		}
		if(rs!=null)
		{
			rs.close();					
		}
		String strAnyassociateconcern="",strAssociateName="",strConstitution="";
		strQuery = SQLParser.getSqlQuery("getAssConcernDetails_NP^"+strRef);
		rs = DBUtils.executeQuery(strQuery);			
		if(rs.next())
		{
			strAnyassociateconcern=Helper.correctNull((String)rs.getString("NPACD_ANY_ASSOCIATE_CONCERN"));
			strAssociateName=Helper.correctNull((String)rs.getString("NPACD_ASSOCIATE_NAME"));
			strConstitution=Helper.correctNull((String)rs.getString("NPACD_CONSTITUTION_ID"));
		
		}
		strQuery = SQLParser.getSqlQuery("sel_busmudrapersdet^"+strRef);
		rs = DBUtils.executeQuery(strQuery);			
		if(rs.next())
		{
			strAnyassociateconcern=Helper.correctNull((String)rs.getString("SPD_ANY_ASSOCIATE_CONCERN"));
			strAssociateName=Helper.correctNull((String)rs.getString("SPD_IS_RELATED_PARTY_SELECT"));
			strBusinessEnterprise=Helper.correctNull((String)rs.getString("SPD_BUSINESS_ENTERPRISES"));
			strGSTNo=Helper.correctNull((String)rs.getString("SPD_GST_NO"));
			strCommencementdate=Helper.correctNull((String)rs.getString("SPD_COMMENCEMENT_DATE"));
			strIsunitreg=Helper.correctNull((String)rs.getString("SPD_IS_UNIT_REGISTRD"));
			strvoter_id=Helper.correctNull((String)rs.getString("SPD_VOTER_ID"));
			str_mailid=Helper.correctNull((String)rs.getString("SPD_DRIVING_LICENSE"));//KYC_LEINO
			str_drivinglic=Helper.correctNull((String)rs.getString("SPD_EMAIL_ID"));//KYC_CLIENTDETAILS
		
		}
		if(rs!=null){rs.close();}
	
		String StrOffadd="",StrCut_add="";
		if(strNewapp.equalsIgnoreCase("Y"))
		{
		
		
			LapsAppid = CustPrfAppID.getId();//app id to msme
			
		
			if(strSchemeName.equalsIgnoreCase("PMMY") || strSchemeName.equalsIgnoreCase("STD") || strSchemeName.equalsIgnoreCase("SRMS") || strSchemeName.equalsIgnoreCase("SWMS") || strSchemeName.equalsIgnoreCase("NULM"))
			{
				strQuery = SQLParser.getSqlQuery("getAssConcernDetails_NP^"+strRef);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					strAnyassociateconcern=Helper.correctNull((String)rs.getString("NPACD_ANY_ASSOCIATE_CONCERN"));
					strAssociateName=Helper.correctNull((String)rs.getString("NPACD_ASSOCIATE_NAME"));
					strConstitution=Helper.correctNull((String)rs.getString("NPACD_CONSTITUTION_ID"));
				
				}		
				if(rs!=null){rs.close();}
				
				strQuery = SQLParser.getSqlQuery("select_loan_check_Mudra^"+strRef);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					strMudraindustrytype=Helper.correctNull((String)rs.getString("MUDRA_INDUSTRY_ID"));
				}
				if(rs!=null)
				{
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_busmudrapersdet^"+strRef);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					strAnyassociateconcern=Helper.correctNull((String)rs.getString("SPD_ANY_ASSOCIATE_CONCERN"));
					strAssociateName=Helper.correctNull((String)rs.getString("SPD_IS_RELATED_PARTY_SELECT"));
					strBusinessEnterprise=Helper.correctNull((String)rs.getString("SPD_BUSINESS_ENTERPRISES"));
					strGSTNo=Helper.correctNull((String)rs.getString("SPD_GST_NO"));
					strCommencementdate=Helper.correctNull((String)rs.getString("SPD_COMMENCEMENT_DATE"));
					strIsunitreg=Helper.correctNull((String)rs.getString("SPD_IS_UNIT_REGISTRD"));
					strvoter_id=Helper.correctNull((String)rs.getString("SPD_VOTER_ID"));
					str_mailid=Helper.correctNull((String)rs.getString("SPD_DRIVING_LICENSE"));//KYC_LEINO
					str_drivinglic=Helper.correctNull((String)rs.getString("SPD_EMAIL_ID"));//KYC_CLIENTDETAILS
				
				}
				if(rs!=null){rs.close();}
			
				if(strSchemeName.equalsIgnoreCase("PMMY"))
				{		
				strQuery = SQLParser.getSqlQuery("sel_busgstcompositedet^"+strRef);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					strRegistrationdate = Helper.correctNull((String)rs.getString("NGD_REG_DATE"));
					
				}
				if(rs != null){rs.close();}
				}
				else if(strSchemeName.equalsIgnoreCase("STD"))
				{
				strQuery = SQLParser.getSqlQuery("sel_busstandindStatudetails^"+strRef);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					strRegistrationdate = Helper.correctNull((String)rs.getString("NPSS_REG_DATE"));
					
				}
				if(rs != null){rs.close();}	
				}
			
			}
			String lapsid_new="",lapsid_coapp="";
			
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			
				if(strSchemeName.equalsIgnoreCase("PMMY") || strSchemeName.equalsIgnoreCase("STD"))
				{
					strQuery = SQLParser.getSqlQuery("sel_np_pmmyAppcheck^"+strRef);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next())
					{
						arrValues.add(LapsAppid);
						arrValues.add(Helper.correctNull((String) rs.getString("MPDP_FIRST_NAME"))+""+Helper.correctNull((String) rs.getString("MPDP_LAST_NAME")));//02
						arrValues.add(Helper.correctNull((String) rs.getString("MPDP_DOB")));//05
						arrValues.add(Helper.correctNull((String) rs.getString("MPDP_PAN")));//6
						//arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));//10
						arrValues.add("");
						arrValues.add("");
						arrValues.add(LapsAppid);
						StrAadhaarAddrSeq= Helper.correctNull((String) rs.getString("MPDP_AADHAR_ADD_SEQ_NO")) ;
						StrCurrAddrSeq = Helper.correctNull((String) rs.getString("MPDP_CURR_ADD_SEQ_NO")) ;
						strEmail=Helper.correctNull((String) rs.getString("MPDP_EMAIL"));
					}else{
						strQuery = SQLParser.getSqlQuery("np_applicantdetails_selct^"+strRef);
						rs = DBUtils.executeQuery(strQuery);
						if (rs.next())
						{
							lapsid_new=LapsAppid;
							arrValues.add(LapsAppid);
							arrValues.add(Helper.correctNull((String) rs.getString("NPPD_FIRST_NAME"))+""+Helper.correctNull((String) rs.getString("NPPD_MIDDLE_NAME")));//02
							arrValues.add(Helper.correctNull((String) rs.getString("NPPD_DOB")));//05
							arrValues.add(Helper.correctNull((String) rs.getString("NPPD_PAN_NO")));//6
							//arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));//10
							arrValues.add("");
							arrValues.add("");
							arrValues.add(LapsAppid);
							StrAadhaarAddrSeq= Helper.correctNull((String) rs.getString("NPPD_AADHAR_ADD_SEQ_NO")) ;
							StrCurrAddrSeq = Helper.correctNull((String) rs.getString("NPPD_CURR_ADD_SEQ_NO")) ;
							strEmail=Helper.correctNull((String) rs.getString("NPPD_EMAIL"));
						}
					}
				}
				else if(strSchemeName.equalsIgnoreCase("SWMS"))
				{
					strQuery = SQLParser.getSqlQuery("sel_np_SWMSAppcheck^"+strRef);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next())
					{
						lapsid_new=LapsAppid;
						arrValues.add(LapsAppid);//1
						arrValues.add(Helper.correctNull((String) rs.getString("NSPD_FIRST_NAME"))+""+Helper.correctNull((String) rs.getString("NSPD_LAST_NAME")));//02
						arrValues.add(Helper.correctNull((String) rs.getString("NSPD_DOB")));//05
						arrValues.add(Helper.correctNull((String) rs.getString("NSPD_PAN")));//6
						//arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));//10
						arrValues.add("");
						arrValues.add("");
						arrValues.add(LapsAppid);
						StrOfficeAddrSeq= Helper.correctNull((String) rs.getString("NSPD_OFFC_ADDR_REFID")) ;
						StrCurrAddrSeq = Helper.correctNull((String) rs.getString("NSPD_CURR_ADDR_REFID")) ;
						strEmail=Helper.correctNull((String) rs.getString("NSPD_EMAIL"));								
					}else{
						strQuery = SQLParser.getSqlQuery("np_applicantdetails_selct^"+strRef);
						rs = DBUtils.executeQuery(strQuery);
						if (rs.next())
						{
							lapsid_new=LapsAppid;
							arrValues.add(LapsAppid);
							arrValues.add(Helper.correctNull((String) rs.getString("NPPD_FIRST_NAME"))+""+Helper.correctNull((String) rs.getString("NPPD_MIDDLE_NAME")));//02
							arrValues.add(Helper.correctNull((String) rs.getString("NPPD_DOB")));//05
							arrValues.add(Helper.correctNull((String) rs.getString("NPPD_PAN_NO")));//6
							//arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));//10
							arrValues.add("");
							arrValues.add("");
							arrValues.add(LapsAppid);
							StrAadhaarAddrSeq= Helper.correctNull((String) rs.getString("NPPD_AADHAR_ADD_SEQ_NO")) ;
							StrCurrAddrSeq = Helper.correctNull((String) rs.getString("NPPD_CURR_ADD_SEQ_NO")) ;
							strEmail=Helper.correctNull((String) rs.getString("NPPD_EMAIL"));
						}
					}
				}else if(strSchemeName.equalsIgnoreCase("NULM"))
				{
					
					
					
					strQuery = SQLParser.getSqlQuery("getPersonalDetails_NPUM^"+strRef);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next())
					{
						lapsid_new=LapsAppid;
						arrValues.add(LapsAppid);//1
						arrValues.add(Helper.correctNull((String) rs.getString("NPLPD_LHPD_F_NAME"))+""+Helper.correctNull((String) rs.getString("NPLPD_LHPD_M_NAME")));//02
						arrValues.add(Helper.correctNull((String) rs.getString("NPLPD_DATE_OF_BIRTH")));//05
						arrValues.add(Helper.correctNull((String) rs.getString("NPLPD_LHPD_PAN")));//6
						//arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));//10
						arrValues.add("");
						arrValues.add("");
						arrValues.add(LapsAppid);
						
						
						StrAadhaarAddrSeq = Helper.correctNull((String)rs.getString("NPLPD_AADHAR_ADD_SEQ_NO"));
						StrCurrAddrSeq = Helper.correctNull((String)rs.getString("NPLPD_CURR_ADD_SEQ_NO"));
						strEmail=Helper.correctNull((String) rs.getString("NPLPD_EMAIL"));								
					}else{
						strQuery = SQLParser.getSqlQuery("np_applicantdetails_selct^"+strRef);
						rs = DBUtils.executeQuery(strQuery);
						if (rs.next())
						{
							lapsid_new=LapsAppid;
							arrValues.add(LapsAppid);
							arrValues.add(Helper.correctNull((String) rs.getString("NPPD_FIRST_NAME"))+""+Helper.correctNull((String) rs.getString("NPPD_MIDDLE_NAME")));//02
							arrValues.add(Helper.correctNull((String) rs.getString("NPPD_DOB")));//05
							arrValues.add(Helper.correctNull((String) rs.getString("NPPD_PAN_NO")));//6
							//arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));//10
							arrValues.add("");
							arrValues.add("");
							arrValues.add(LapsAppid);
							StrAadhaarAddrSeq= Helper.correctNull((String) rs.getString("NPPD_AADHAR_ADD_SEQ_NO")) ;
							StrCurrAddrSeq = Helper.correctNull((String) rs.getString("NPPD_CURR_ADD_SEQ_NO")) ;
							strEmail=Helper.correctNull((String) rs.getString("NPPD_EMAIL"));
						}
					}
				}else{
					strQuery = SQLParser.getSqlQuery("np_applicantdetails_selct^"+strRef);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next())
					{
						lapsid_new=LapsAppid;
						arrValues.add(LapsAppid);
						arrValues.add(Helper.correctNull((String) rs.getString("NPPD_FIRST_NAME"))+""+Helper.correctNull((String) rs.getString("NPPD_MIDDLE_NAME")));//02
						arrValues.add(Helper.correctNull((String) rs.getString("NPPD_DOB")));//05
						arrValues.add(Helper.correctNull((String) rs.getString("NPPD_PAN_NO")));//6
						//arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));//10
						arrValues.add("");
						arrValues.add("");
						arrValues.add(LapsAppid);
						StrAadhaarAddrSeq= Helper.correctNull((String) rs.getString("NPPD_AADHAR_ADD_SEQ_NO")) ;
						StrCurrAddrSeq = Helper.correctNull((String) rs.getString("NPPD_CURR_ADD_SEQ_NO")) ;
						strEmail=Helper.correctNull((String) rs.getString("NPPD_EMAIL"));
					}else{
						lapsid_new=LapsAppid;
						arrValues.add(LapsAppid);
						arrValues.add("");//10
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add(LapsAppid);
					}
				}
				
				if(rs != null){rs.close();}
				if(!StrAadhaarAddrSeq.equals(""))
				{
					strQuery = SQLParser.getSqlQuery("sel_NPAddressDetBySeq^"+strRef+'^'+StrAadhaarAddrSeq);
					rs1 = DBUtils.executeQuery(strQuery);
					if (rs1.next())
					{
						StrCurrAddr1=Helper.correctNull((String)rs1.getString("address1")) ;//
						StrCurrAddr2= Helper.correctNull((String)rs1.getString("address2"));//
						
						 String city=Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME"));
						 String state=Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME"));
							
							if(!state.equalsIgnoreCase("")){
							strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
							rs3 = DBUtils.executeQuery(strQuery);			
							if(rs3.next())
							{
								StrCurrAddrState=Helper.correctNull((String)rs3.getString("STATE_CODE"));
							}
							}
							String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
							if(!city.equalsIgnoreCase("")){
								strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
								rs3 = DBUtils.executeQuery(strQuery);			
								if(rs3.next())
								{
									StrCurrAddrACity=Helper.correctNull((String)rs3.getString("CITY_CODE"));	
								}
							}
						StrCurrAddrCountry=Helper.correctNull((String)rs1.getString("NPAD_COUNTRY_NAME"));//
						StrCurrAddrPin=Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE"));
					} 
				}
				/*arrValues.add(StrCurrAddr1);//15
				arrValues.add(StrCurrAddr2);//16
				arrValues.add(StrCurrAddrACity);//17
				arrValues.add(StrCurrAddrState);//18
				arrValues.add(StrCurrAddrPin);//19
				
				arrValues.add(strBusinessEnterprise);//20
*/				
				
				
				/*if(!StrCurrAddrSeq.equals(""))
				{
					strQuery = SQLParser.getSqlQuery("sel_NPAddressDetBySeq^"+strRef+'^'+StrCurrAddrSeq);
					rs1 = DBUtils.executeQuery(strQuery);
					if (rs1.next())
					{
						 StrOfficeAddr1=Helper.correctNull((String)rs1.getString("address1"))   ;
						 StrOfficeAddr2=Helper.correctNull((String)rs1.getString("address2"));
						 String city=Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME"));
						 String state=Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME"));
							
							if(!state.equalsIgnoreCase("")){
							strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
							rs3 = DBUtils.executeQuery(strQuery);			
							if(rs3.next())
							{
								StrOfficeAddrState=Helper.correctNull((String)rs3.getString("STATE_CODE"));
							}
							}String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
							if(!city.equalsIgnoreCase("")){
								strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
								rs3 = DBUtils.executeQuery(strQuery);			
								if(rs3.next())
								{
									StrOfficeAddrCity=Helper.correctNull((String)rs3.getString("CITY_CODE"));	
								}
							}
						 StrOfficeAddrCountry=Helper.correctNull((String)rs1.getString("NPAD_COUNTRY_NAME"));//
						 StrOfficeAddrPin=Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE"));
					} 
					 
				}*/
				/*arrValues.add(StrOfficeAddr1);//24
				arrValues.add(StrOfficeAddr2);//25
				arrValues.add(StrOfficeAddrCity);//26
				arrValues.add(StrOfficeAddrState);//27
				arrValues.add(StrOfficeAddrPin);//28
				arrValues.add("IN");//29
				arrValues.add(strEmail);
				arrValues.add(strMudraindustrytype);
				arrValues.add(strConstitution);
				arrValues.add(strRegistrationdate);
				if(strSchemeName.equalsIgnoreCase("NULM"))
				{
				arrValues.add("SME");
				}else{
				arrValues.add("CORP");
				}
				arrValues.add("OO");
				arrValues.add(strOrgSelect);*/
				System.out.println("arrValues"+arrValues);
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","ins_npcustprofile_BS");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				

			
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","com_division_ins_NP");	
			arrValues.add(LapsAppid);	
			arrValues.add(LapsAppid);	
			arrValues.add(strAssociateName);	
			arrValues.add(strAnyassociateconcern);	
			if(!StrOfficeAddrSeq.equals(""))
			{
				strQuery = SQLParser.getSqlQuery("sel_NPAddressDetBySeq^"+strRef+'^'+StrOfficeAddrSeq);
				rs1 = DBUtils.executeQuery(strQuery);
				if (rs1.next())
				{
					 StrOfficeAddr1=Helper.correctNull((String)rs1.getString("address1"))   ;
					 StrOfficeAddr2=Helper.correctNull((String)rs1.getString("address2"));
					 String city=Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME"));
					 String state=Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME"));
						
						if(!state.equalsIgnoreCase("")){
						strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
						rs3 = DBUtils.executeQuery(strQuery);			
						if(rs3.next())
						{
							StrOfficeAddrState=Helper.correctNull((String)rs3.getString("STATE_CODE"));
						}
						}String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
						if(!city.equalsIgnoreCase("")){
							strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
							rs3 = DBUtils.executeQuery(strQuery);			
							if(rs3.next())
							{
								StrOfficeAddrCity=Helper.correctNull((String)rs3.getString("CITY_CODE"));	
							}
						}
					 StrOfficeAddrPin=Helper.correctNull((String)rs.getString("NPAD_PIN_CODE"));
			}
				 
			}
			arrValues.add(StrOfficeAddr1);
			arrValues.add(StrOfficeAddrCity);
			arrValues.add(StrOfficeAddrState);
			arrValues.add(StrOfficeAddrPin);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","upd_nplapsappid");	
			arrValues.add(LapsAppid);	
			arrValues.add(strRefno);			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","upd_nplapsappid5");	
			arrValues.add(LapsAppid);	
			arrValues.add(strRefno);			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","updperappid_np");	
			arrValues.add(LapsAppid);	
			arrValues.add(strRefno);
			arrValues.add(StrName1);
			System.out.print("arrValues dedupe old id --"+arrValues);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
		}else{
			// Ravindra Kumar ex.appl 
			
			String strAppCode = CustPrfAppID.getId();//app id to msme
			int intUpdateQuerySize=0;
			String strAppId=strLapsid;
			
			
			String strOldAppId=strLapsid;
			//String strAppCode = CustPrfAppID.getApplicantCode();
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			intUpdateQuerySize++;
			arrValues.add(strAppCode);
			arrValues.add(strAppCode);
			arrValues.add("n");
			arrValues.add(Helper.correctNull((String)hshValues.get("strOrgShortCode")));
			arrValues.add(strAppId);	
			//arrValues.add(strOldAppId);	
			System.out.print("arrValues perapplication  --"+arrValues);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","perapplicantrenew1");
			hshQueryValues.put(""+intUpdateQuerySize,hshQuery);
			//hshQueryValues.put("1",hshQuery);
			//hshQueryValues.put("size","1");
			//EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			
			
			
			// update renew column in perapplicant table
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			intUpdateQuerySize++;
			arrValues.add("y");
			arrValues.add(strAppId);
			System.out.print("arrValues perapplication1 --"+arrValues);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","perapplicantupdaterenew");
			hshQueryValues.put(""+intUpdateQuerySize,hshQuery);
			//hshQueryValues.put("1",hshQuery);
			//hshQueryValues.put("size","1");
			//EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			
			
			
			/*//copying the datas with commap_id
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			intUpdateQuerySize++;
			arrValues.add(strAppCode);
			arrValues.add(strAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","comappmasterrenew");
			hshQueryValues.put(""+intUpdateQuerySize,hshQuery);
			
			// update renew column in comapplicant table
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			intUpdateQuerySize++;
			arrValues.add("Y");
			arrValues.add(strAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","comappmasterupdaterenew");
			hshQueryValues.put(""+intUpdateQuerySize,hshQuery);*/

			// insert data in to comappfactorydetails table
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			intUpdateQuerySize++;
			arrValues.add(strAppCode);
			arrValues.add(strAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","factorydetailsrenew");
			hshQueryValues.put(""+intUpdateQuerySize,hshQuery);
			
			// insert data in to comapp_company_divisions table
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			intUpdateQuerySize++;
			arrValues.add(strAppCode);
			arrValues.add(strAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","divisiondetailsrenew");
			hshQueryValues.put(""+intUpdateQuerySize,hshQuery);
			
			//insert data in to comapp_company_divisions table
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			intUpdateQuerySize++;
			arrValues.add(strAppCode);
			arrValues.add(strAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","reldetailsrenew");
			hshQueryValues.put(""+intUpdateQuerySize,hshQuery);
			
			//insert data in to KYC norms table
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			intUpdateQuerySize++;
			arrValues.add(strAppCode);
			arrValues.add(strAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","kycnormsrenew");
			hshQueryValues.put(""+intUpdateQuerySize,hshQuery);
			
			hshQueryValues.put("size",""+intUpdateQuerySize);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			
				
			if(rs!=null){rs.close();}
			
			
				if(strSchemeName.equalsIgnoreCase("PMMY") || strSchemeName.equalsIgnoreCase("STD") || strSchemeName.equalsIgnoreCase("SRMS") || strSchemeName.equalsIgnoreCase("SWMS") || strSchemeName.equalsIgnoreCase("NULM"))
				{
					
					strQuery = SQLParser.getSqlQuery("select_loan_check_Mudra^"+strRef);
					rs = DBUtils.executeQuery(strQuery);			
					if(rs.next())
					{
						strMudraindustrytype=Helper.correctNull((String)rs.getString("MUDRA_INDUSTRY_ID"));
					}
					if(rs!=null)
					{
						rs.close();
					}
					
					if(strSchemeName.equalsIgnoreCase("PMMY"))
					{		
					strQuery = SQLParser.getSqlQuery("sel_busgstcompositedet^"+strRef);
					rs = DBUtils.executeQuery(strQuery);			
					if(rs.next())
					{
						strRegistrationdate = Helper.correctNull((String)rs.getString("NGD_REG_DATE"));
						
					}
					if(rs != null){rs.close();}
					}
					else if(strSchemeName.equalsIgnoreCase("STD"))
					{
					strQuery = SQLParser.getSqlQuery("sel_busstandindStatudetails^"+strRef);
					rs = DBUtils.executeQuery(strQuery);			
					if(rs.next())
					{
						strRegistrationdate = Helper.correctNull((String)rs.getString("NPSS_REG_DATE"));
						
					}
					if(rs != null){rs.close();}	
					}
				
				}
				String lapsid_new="",lapsid_coapp="";
				LapsAppid=strAppCode;
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				
					if(strSchemeName.equalsIgnoreCase("PMMY") || strSchemeName.equalsIgnoreCase("STD"))
					{
						strQuery = SQLParser.getSqlQuery("sel_np_pmmyAppcheck^"+strRef);
						rs = DBUtils.executeQuery(strQuery);
						if (rs.next())
						{
							arrValues.add(LapsAppid);
							arrValues.add(Helper.correctNull((String) rs.getString("MPDP_FIRST_NAME"))+""+Helper.correctNull((String) rs.getString("MPDP_LAST_NAME")));//02
							arrValues.add(Helper.correctNull((String) rs.getString("MPDP_DOB")));//05
							arrValues.add(Helper.correctNull((String) rs.getString("MPDP_PAN")));//6
							arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));//10
							//arrValues.add("");
							arrValues.add("");
							arrValues.add("");
							StrAadhaarAddrSeq= Helper.correctNull((String) rs.getString("MPDP_AADHAR_ADD_SEQ_NO")) ;
							StrCurrAddrSeq = Helper.correctNull((String) rs.getString("MPDP_CURR_ADD_SEQ_NO")) ;
							strEmail=Helper.correctNull((String) rs.getString("MPDP_EMAIL"));
						}else{
							strQuery = SQLParser.getSqlQuery("np_applicantdetails_selct^"+strRef);
							rs = DBUtils.executeQuery(strQuery);
							if (rs.next())
							{
								lapsid_new=LapsAppid;
								arrValues.add(LapsAppid);
								arrValues.add(Helper.correctNull((String) rs.getString("NPPD_FIRST_NAME"))+""+Helper.correctNull((String) rs.getString("NPPD_MIDDLE_NAME")));//02
								arrValues.add(Helper.correctNull((String) rs.getString("NPPD_DOB")));//05
								arrValues.add(Helper.correctNull((String) rs.getString("NPPD_PAN_NO")));//6
								arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));//10
								//arrValues.add("");
								arrValues.add("");
								arrValues.add("");
								StrAadhaarAddrSeq= Helper.correctNull((String) rs.getString("NPPD_AADHAR_ADD_SEQ_NO")) ;
								StrCurrAddrSeq = Helper.correctNull((String) rs.getString("NPPD_CURR_ADD_SEQ_NO")) ;
								strEmail=Helper.correctNull((String) rs.getString("NPPD_EMAIL"));
							}
						}
					}
					else if(strSchemeName.equalsIgnoreCase("SWMS"))
					{
						strQuery = SQLParser.getSqlQuery("sel_np_SWMSAppcheck^"+strRef);
						rs = DBUtils.executeQuery(strQuery);
						if (rs.next())
						{
							lapsid_new=LapsAppid;
							arrValues.add(LapsAppid);//1
							arrValues.add(Helper.correctNull((String) rs.getString("NSPD_FIRST_NAME"))+""+Helper.correctNull((String) rs.getString("NSPD_LAST_NAME")));//02
							arrValues.add(Helper.correctNull((String) rs.getString("NSPD_DOB")));//05
							arrValues.add(Helper.correctNull((String) rs.getString("NSPD_PAN")));//6
							arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));//10
							//arrValues.add("");
							arrValues.add("");
							arrValues.add("");
							StrOfficeAddrSeq= Helper.correctNull((String) rs.getString("NSPD_OFFC_ADDR_REFID")) ;
							StrCurrAddrSeq = Helper.correctNull((String) rs.getString("NSPD_CURR_ADDR_REFID")) ;
							strEmail=Helper.correctNull((String) rs.getString("NSPD_EMAIL"));								
						}else{
							strQuery = SQLParser.getSqlQuery("np_applicantdetails_selct^"+strRef);
							rs = DBUtils.executeQuery(strQuery);
							if (rs.next())
							{
								lapsid_new=LapsAppid;
								arrValues.add(LapsAppid);
								arrValues.add(Helper.correctNull((String) rs.getString("NPPD_FIRST_NAME"))+""+Helper.correctNull((String) rs.getString("NPPD_MIDDLE_NAME")));//02
								arrValues.add(Helper.correctNull((String) rs.getString("NPPD_DOB")));//05
								arrValues.add(Helper.correctNull((String) rs.getString("NPPD_PAN_NO")));//6
								arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));//10
								//arrValues.add("");
								arrValues.add("");
								arrValues.add("");
								StrAadhaarAddrSeq= Helper.correctNull((String) rs.getString("NPPD_AADHAR_ADD_SEQ_NO")) ;
								StrCurrAddrSeq = Helper.correctNull((String) rs.getString("NPPD_CURR_ADD_SEQ_NO")) ;
								strEmail=Helper.correctNull((String) rs.getString("NPPD_EMAIL"));
							}
						}
					}else if(strSchemeName.equalsIgnoreCase("NULM"))
					{
						
						
						
						strQuery = SQLParser.getSqlQuery("getPersonalDetails_NPUM^"+strRef);
						rs = DBUtils.executeQuery(strQuery);
						if (rs.next())
						{
							lapsid_new=LapsAppid;
							arrValues.add(LapsAppid);//1
							arrValues.add(Helper.correctNull((String) rs.getString("NPLPD_LHPD_F_NAME"))+""+Helper.correctNull((String) rs.getString("NPLPD_LHPD_M_NAME")));//02
							arrValues.add(Helper.correctNull((String) rs.getString("NPLPD_DATE_OF_BIRTH")));//05
							arrValues.add(Helper.correctNull((String) rs.getString("NPLPD_LHPD_PAN")));//6
							arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));//10
							//arrValues.add("");
							arrValues.add("");
							arrValues.add("");
							
							
							 StrCurrAddrSeq= Helper.correctNull((String)rs.getString("NPLPD_CURR_ADD_SEQ_NO"));
							 StrAadhaarAddrSeq = Helper.correctNull((String)rs.getString("NPLPD_AADHAR_ADD_SEQ_NO"));
							strEmail=Helper.correctNull((String) rs.getString("NPLPD_EMAIL"));								
						}else{
							strQuery = SQLParser.getSqlQuery("np_applicantdetails_selct^"+strRef);
							rs = DBUtils.executeQuery(strQuery);
							if (rs.next())
							{
								lapsid_new=LapsAppid;
								arrValues.add(LapsAppid);
								arrValues.add(Helper.correctNull((String) rs.getString("NPPD_FIRST_NAME"))+""+Helper.correctNull((String) rs.getString("NPPD_MIDDLE_NAME")));//02
								arrValues.add(Helper.correctNull((String) rs.getString("NPPD_DOB")));//05
								arrValues.add(Helper.correctNull((String) rs.getString("NPPD_PAN_NO")));//6
								arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));//10
								//arrValues.add("");
								arrValues.add("");
								arrValues.add("");
								StrAadhaarAddrSeq= Helper.correctNull((String) rs.getString("NPPD_AADHAR_ADD_SEQ_NO")) ;
								StrCurrAddrSeq = Helper.correctNull((String) rs.getString("NPPD_CURR_ADD_SEQ_NO")) ;
								strEmail=Helper.correctNull((String) rs.getString("NPPD_EMAIL"));
							}
						}
					}else{
						strQuery = SQLParser.getSqlQuery("np_applicantdetails_selct^"+strRef);
						rs = DBUtils.executeQuery(strQuery);
						if (rs.next())
						{
							lapsid_new=LapsAppid;
							arrValues.add(LapsAppid);
							arrValues.add(Helper.correctNull((String) rs.getString("NPPD_FIRST_NAME"))+""+Helper.correctNull((String) rs.getString("NPPD_MIDDLE_NAME")));//02
							arrValues.add(Helper.correctNull((String) rs.getString("NPPD_DOB")));//05
							arrValues.add(Helper.correctNull((String) rs.getString("NPPD_PAN_NO")));//6
							arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));//10
							//arrValues.add("");
							arrValues.add("");
							arrValues.add("");
							StrAadhaarAddrSeq= Helper.correctNull((String) rs.getString("NPPD_AADHAR_ADD_SEQ_NO")) ;
							StrCurrAddrSeq = Helper.correctNull((String) rs.getString("NPPD_CURR_ADD_SEQ_NO")) ;
							strEmail=Helper.correctNull((String) rs.getString("NPPD_EMAIL"));
						}
					}
					
					if(rs != null){rs.close();}
					if(!StrAadhaarAddrSeq.equals(""))
					{
						strQuery = SQLParser.getSqlQuery("sel_NPAddressDetBySeq^"+strRef+'^'+StrAadhaarAddrSeq);
						rs1 = DBUtils.executeQuery(strQuery);
						if (rs1.next())
						{
							StrCurrAddr1=Helper.correctNull((String)rs1.getString("address1")) ;//
							StrCurrAddr2= Helper.correctNull((String)rs1.getString("address2"));//
							 String city=Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME"));
							 String state=Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME"));
								
								if(!state.equalsIgnoreCase("")){
								strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
								rs3 = DBUtils.executeQuery(strQuery);			
								if(rs3.next())
								{
									StrCurrAddrState=Helper.correctNull((String)rs3.getString("STATE_CODE"));
								}
								}String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
								if(!city.equalsIgnoreCase("")){
									strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
									rs3 = DBUtils.executeQuery(strQuery);			
									if(rs3.next())
									{
										StrCurrAddrACity=Helper.correctNull((String)rs3.getString("CITY_CODE"));	
									}
								}
							StrCurrAddrCountry=Helper.correctNull((String)rs1.getString("NPAD_COUNTRY_NAME"));//
							StrCurrAddrPin=Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE"));
						} 
					}
					/*arrValues.add(StrCurrAddr1);//15
					arrValues.add(StrCurrAddr2);//16
					arrValues.add(StrCurrAddrACity);//17
					arrValues.add(StrCurrAddrState);//18
					arrValues.add(StrCurrAddrPin);//19
					
					arrValues.add(strBusinessEnterprise);//20
*/					
					
					
					if(!StrCurrAddrSeq.equals(""))
					{
						strQuery = SQLParser.getSqlQuery("sel_NPAddressDetBySeq^"+strRef+'^'+StrCurrAddrSeq);
						rs1 = DBUtils.executeQuery(strQuery);
						if (rs1.next())
						{
							 StrOfficeAddr1=Helper.correctNull((String)rs1.getString("address1"))   ;
							 StrOfficeAddr2=Helper.correctNull((String)rs1.getString("address2"));
							 String city=Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME"));
							 String state=Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME"));
								
								if(!state.equalsIgnoreCase("")){
								strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
								rs3 = DBUtils.executeQuery(strQuery);			
								if(rs3.next())
								{
									StrOfficeAddrState=Helper.correctNull((String)rs3.getString("STATE_CODE"));
								}
								}String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
								if(!city.equalsIgnoreCase("")){
									strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
									rs3 = DBUtils.executeQuery(strQuery);			
									if(rs3.next())
									{
										StrOfficeAddrCity=Helper.correctNull((String)rs3.getString("CITY_CODE"));	
									}
								}
							 StrOfficeAddrCountry=Helper.correctNull((String)rs1.getString("NPAD_COUNTRY_NAME"));//
							 StrOfficeAddrPin=Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE"));
						} 
						 
					}
					/*arrValues.add(StrOfficeAddr1);//24
					arrValues.add(StrOfficeAddr2);//25
					arrValues.add(StrOfficeAddrCity);//26
					arrValues.add(StrOfficeAddrState);//27
					arrValues.add(StrOfficeAddrPin);//28
					arrValues.add("IN");//29
					arrValues.add(strEmail);
					arrValues.add(strMudraindustrytype);
					arrValues.add(strConstitution);
					arrValues.add(strRegistrationdate);
					arrValues.add("OO");*/
					arrValues.add(LapsAppid);
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","upd_npcustprofile_BS");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					

				
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","com_division_upd_NP");	
				arrValues.add(LapsAppid);	
				arrValues.add(LapsAppid);	
				arrValues.add(strAssociateName);	
				arrValues.add(strAnyassociateconcern);	
				if(!StrOfficeAddrSeq.equals(""))
				{
					strQuery = SQLParser.getSqlQuery("sel_NPAddressDetBySeq^"+strRef+'^'+StrOfficeAddrSeq);
					rs1 = DBUtils.executeQuery(strQuery);
					if (rs1.next())
					{
						 StrOfficeAddr1=Helper.correctNull((String)rs1.getString("address1"))   ;
						 StrOfficeAddr2=Helper.correctNull((String)rs1.getString("address2"));
						 String city=Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME"));
						 String state=Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME"));
							
							if(!state.equalsIgnoreCase("")){
							strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
							rs3 = DBUtils.executeQuery(strQuery);			
							if(rs3.next())
							{
								StrOfficeAddrState=Helper.correctNull((String)rs3.getString("STATE_CODE"));
							}
							}String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
							if(!city.equalsIgnoreCase("")){
								strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
								rs3 = DBUtils.executeQuery(strQuery);			
								if(rs3.next())
								{
									StrOfficeAddrCity=Helper.correctNull((String)rs3.getString("CITY_CODE"));	
								}
							}
				
						 StrOfficeAddrPin=Helper.correctNull((String)rs.getString("NPAD_PIN_CODE"));
					}
					 
				}
				arrValues.add(StrOfficeAddr1);
				arrValues.add(StrOfficeAddrCity);
				arrValues.add(StrOfficeAddrState);
				arrValues.add(StrOfficeAddrPin);
				arrValues.add(LapsAppid);	
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_nplapsappid");	
				arrValues.add(LapsAppid);	
				arrValues.add(strRefno);			
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_nplapsappid5");	
				arrValues.add(LapsAppid);	
				arrValues.add(strRefno);			
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","updperappid_np");	
				arrValues.add(LapsAppid);	
				arrValues.add(strRefno);
				arrValues.add(StrName1);
				System.out.print("arrValues dedupe old id --"+arrValues);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			
		}	
			//co applicaent msme 
		
		strQuery = SQLParser.getSqlQuery("sel_npcoappdet^"+strRefno);
		rs3 = DBUtils.executeQuery(strQuery);			
		while(rs3.next())
		{	
			String name="";
			if(!Helper.correctNull((String)rs3.getString("NPCD_FNAME")).equalsIgnoreCase(""))
			{
				name=Helper.correctNull((String)rs3.getString("NPCD_FNAME"));
			}
			if(!Helper.correctNull((String)rs3.getString("NPCD_LNAME")).equalsIgnoreCase(""))
			{
				name=name+" "+Helper.correctNull((String)rs3.getString("NPCD_LNAME"));
			}
			if(!Helper.correctNull((String)rs3.getString("NPCD_MNAME")).equalsIgnoreCase(""))
			{
				name=name+" "+Helper.correctNull((String)rs3.getString("NPCD_MNAME"));
			}
			
			String StrName=name;
			
			String strLapsid1="",strNewapp1="",strCbsid1="";
			strQuery = SQLParser.getSqlQuery("seldedupecheckco_np^"+strRefno+"^"+StrName);
			rs1 = DBUtils.executeQuery(strQuery);			
			if(rs1.next())
			{
				strLapsid1=Helper.correctNull((String)rs1.getString("NP_LAPSID"));
				strNewapp1=Helper.correctNull((String)rs1.getString("NP_ISNEW"));
				strCbsid1=Helper.correctNull((String)rs1.getString("NP_CBSID"));
			}
			if(strNewapp1.equalsIgnoreCase("Y"))
			{
			
				strQuery = SQLParser.getSqlQuery("np_coapplicantdetails_selct^"+strRef);
				rs = DBUtils.executeQuery(strQuery);			
				while(rs.next())
				{
					LapsAppid = CustPrfAppID.getId();//app id to msme
					arrValues = new ArrayList();
					arrValues.add(LapsAppid);//1
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_FNAME")) +""+Helper.correctNull((String)rs.getString("NPCD_LNAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_DOB")));//5
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_PAN_NO")));//6
					arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));//10
					arrValues.add("");
					arrValues.add(LapsAppid);
					
					StrAadhaarAddrSeq= Helper.correctNull((String) rs.getString("NPPD_AADHAR_ADD_SEQ_NO")) ;
					StrCurrAddrSeq = Helper.correctNull((String) rs.getString("NPPD_CURR_ADD_SEQ_NO")) ;
					strEmail=Helper.correctNull((String) rs.getString("NPPD_EMAIL"));
				StrAadhaarAddrSeq= Helper.correctNull((String) rs.getString("NPCD_AADHAR_ADD_SEQ")) ;
				StrCurrAddrSeq = Helper.correctNull((String) rs.getString("NPCD_CURRENT_ADD_SEQ")) ;
				StrOfficeAddrSeq= Helper.correctNull((String) rs.getString("NPCD_OFFICE_ADD_SEQ")); 
				strEmail=Helper.correctNull((String) rs.getString("NPCD_EMAIL"));		
				
				
				if(rs != null){rs.close();}
				
				if(rs != null){rs.close();}
				if(!StrAadhaarAddrSeq.equals(""))
				{
					strQuery = SQLParser.getSqlQuery("sel_NPAddressDetBySeq^"+strRef+'^'+StrAadhaarAddrSeq);
					rs1 = DBUtils.executeQuery(strQuery);
					if (rs1.next())
					{
						StrCurrAddr1=Helper.correctNull((String)rs1.getString("address1")) ;//
						StrCurrAddr2= Helper.correctNull((String)rs1.getString("address2"));//
						String city=Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME"));
						 String state=Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME"));
							
							if(!state.equalsIgnoreCase("")){
							strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
							rs3 = DBUtils.executeQuery(strQuery);			
							if(rs3.next())
							{
								StrCurrAddrState=Helper.correctNull((String)rs3.getString("STATE_CODE"));
							}
							}String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
							if(!city.equalsIgnoreCase("")){
								strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
								rs3 = DBUtils.executeQuery(strQuery);			
								if(rs3.next())
								{
									StrCurrAddrACity=Helper.correctNull((String)rs3.getString("CITY_CODE"));	
								}
							}
				
						StrCurrAddrCountry=Helper.correctNull((String)rs1.getString("NPAD_COUNTRY_NAME"));//
						StrCurrAddrPin=Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE"));
					} 
				}
				/*arrValues.add(StrCurrAddr1);//15
				arrValues.add(StrCurrAddr2);//16
				arrValues.add(StrCurrAddrACity);//17
				arrValues.add(StrCurrAddrState);//18
				arrValues.add(StrCurrAddrPin);//19
				
				arrValues.add(strBusinessEnterprise);//20
				*/
				
				
				if(!StrCurrAddrSeq.equals(""))
				{
					strQuery = SQLParser.getSqlQuery("sel_NPAddressDetBySeq^"+strRef+'^'+StrCurrAddrSeq);
					rs1 = DBUtils.executeQuery(strQuery);
					if (rs1.next())
					{
						 StrOfficeAddr1=Helper.correctNull((String)rs1.getString("address1"))   ;
						 StrOfficeAddr2=Helper.correctNull((String)rs1.getString("address2"));
						String city=Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME"));
						 String state=Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME"));
							
							if(!state.equalsIgnoreCase("")){
							strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
							rs3 = DBUtils.executeQuery(strQuery);			
							if(rs3.next())
							{
								StrOfficeAddrState=Helper.correctNull((String)rs3.getString("STATE_CODE"));
							}
							}String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
							if(!city.equalsIgnoreCase("")){
								strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
								rs3 = DBUtils.executeQuery(strQuery);			
								if(rs3.next())
								{
									StrOfficeAddrCity=Helper.correctNull((String)rs3.getString("CITY_CODE"));	
								}
							}
				
						 StrOfficeAddrCountry=Helper.correctNull((String)rs1.getString("NPAD_COUNTRY_NAME"));//
						 StrOfficeAddrPin=Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE"));
					} 
					 
				}
				/*arrValues.add(StrOfficeAddr1);//24
				arrValues.add(StrOfficeAddr2);//25
				arrValues.add(StrOfficeAddrCity);//26
				arrValues.add(StrOfficeAddrState);//27
				arrValues.add(StrOfficeAddrPin);//28
				arrValues.add("IN");//29
				arrValues.add(strEmail);
				arrValues.add(strMudraindustrytype);
				arrValues.add(strConstitution);
				arrValues.add(strRegistrationdate);
				arrValues.add("OO");*/
				System.out.print("arrValues"+arrValues);
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","ins_npcustprofile_BS");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				

		
		
		
		hshQuery = new HashMap();
		hshQueryValues = new HashMap();
		arrValues = new ArrayList();
		hshQuery.put("strQueryId","com_division_ins_NP");	
		arrValues.add(LapsAppid);	
		arrValues.add(LapsAppid);	
		arrValues.add(strAssociateName);	
		arrValues.add(strAnyassociateconcern);	
		
		if(!StrOfficeAddrSeq.equals(""))
		{
			strQuery = SQLParser.getSqlQuery("sel_NPAddressDetBySeq^"+strRef+'^'+StrOfficeAddrSeq);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next())
			{
				 StrOfficeAddr1=Helper.correctNull((String)rs1.getString("address1"))   ;
				 StrOfficeAddr2=Helper.correctNull((String)rs1.getString("address2"));
				 String city=Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME"));
				 String state=Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME"));
					
					if(!state.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						StrOfficeAddrState=Helper.correctNull((String)rs3.getString("STATE_CODE"));
					}
					}
					String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
					if(!city.equalsIgnoreCase("")){
						strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
						rs3 = DBUtils.executeQuery(strQuery);			
						if(rs3.next())
						{
							StrOfficeAddrCity=Helper.correctNull((String)rs3.getString("CITY_CODE"));	
						}
					}
		
				 StrOfficeAddrPin=Helper.correctNull((String)rs.getString("NPAD_PIN_CODE"));
		
			}
			 
		}
		arrValues.add(StrOfficeAddr1);
		arrValues.add(StrOfficeAddrCity);
		arrValues.add(StrOfficeAddrState);
		arrValues.add(StrOfficeAddrPin);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);
		hshQueryValues.put("size","1");	
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		 
		}
				
		}else{
			String strAppCode = CustPrfAppID.getId();//app id to msme
			int intUpdateQuerySize=0;
			String strAppId=strLapsid1;
			
			//copying the datas with commap_id
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			intUpdateQuerySize++;
			arrValues.add(strAppCode);
			arrValues.add(strAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","comappmasterrenew");
			hshQueryValues.put(""+intUpdateQuerySize,hshQuery);
			
			// update renew column in comapplicant table
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			intUpdateQuerySize++;
			arrValues.add("Y");
			arrValues.add(strAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","comappmasterupdaterenew");
			hshQueryValues.put(""+intUpdateQuerySize,hshQuery);

			// insert data in to comappfactorydetails table
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			intUpdateQuerySize++;
			arrValues.add(strAppCode);
			arrValues.add(strAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","factorydetailsrenew");
			hshQueryValues.put(""+intUpdateQuerySize,hshQuery);
			
			// insert data in to comapp_company_divisions table
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			intUpdateQuerySize++;
			arrValues.add(strAppCode);
			arrValues.add(strAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","divisiondetailsrenew");
			hshQueryValues.put(""+intUpdateQuerySize,hshQuery);
			
			//insert data in to comapp_company_divisions table
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			intUpdateQuerySize++;
			arrValues.add(strAppCode);
			arrValues.add(strAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","reldetailsrenew");
			hshQueryValues.put(""+intUpdateQuerySize,hshQuery);
			
			//insert data in to KYC norms table
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			intUpdateQuerySize++;
			arrValues.add(strAppCode);
			arrValues.add(strAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","kycnormsrenew");
			hshQueryValues.put(""+intUpdateQuerySize,hshQuery);
			
			hshQueryValues.put("size",""+intUpdateQuerySize);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			
				
			if(rs!=null){rs.close();}
			
			
				if(strSchemeName.equalsIgnoreCase("PMMY") || strSchemeName.equalsIgnoreCase("STD") || strSchemeName.equalsIgnoreCase("SRMS") || strSchemeName.equalsIgnoreCase("SWMS"))
				{
					
					strQuery = SQLParser.getSqlQuery("select_loan_check_Mudra^"+strRef);
					rs = DBUtils.executeQuery(strQuery);			
					if(rs.next())
					{
						strMudraindustrytype=Helper.correctNull((String)rs.getString("MUDRA_INDUSTRY_ID"));
					}
					if(rs!=null)
					{
						rs.close();
					}
					
					if(strSchemeName.equalsIgnoreCase("PMMY"))
					{		
					strQuery = SQLParser.getSqlQuery("sel_busgstcompositedet^"+strRef);
					rs = DBUtils.executeQuery(strQuery);			
					if(rs.next())
					{
						strRegistrationdate = Helper.correctNull((String)rs.getString("NGD_REG_DATE"));
						
					}
					if(rs != null){rs.close();}
					}
					else if(strSchemeName.equalsIgnoreCase("STD"))
					{
					strQuery = SQLParser.getSqlQuery("sel_busstandindStatudetails^"+strRef);
					rs = DBUtils.executeQuery(strQuery);			
					if(rs.next())
					{
						strRegistrationdate = Helper.correctNull((String)rs.getString("NPSS_REG_DATE"));
						
					}
					if(rs != null){rs.close();}	
					}
				
				}	
			
				strQuery = SQLParser.getSqlQuery("np_coapplicantdetails_selct^"+strRef);
				rs = DBUtils.executeQuery(strQuery);			
				while(rs.next())
				{
					arrValues=new ArrayList();
					LapsAppid = strAppCode;//app id to msme
					arrValues.add(LapsAppid);//1
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_FNAME")) +""+Helper.correctNull((String)rs.getString("NPCD_LNAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPCD_DOB")));//5
					arrValues.add("");//6
					arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));//10
					arrValues.add("0");
					arrValues.add(LapsAppid);
				StrAadhaarAddrSeq= Helper.correctNull((String) rs.getString("NPCD_AADHAR_ADD_SEQ")) ;
				StrCurrAddrSeq = Helper.correctNull((String) rs.getString("NPCD_CURRENT_ADD_SEQ")) ;
				StrOfficeAddrSeq= Helper.correctNull((String) rs.getString("NPCD_OFFICE_ADD_SEQ")); 
				strEmail=Helper.correctNull((String) rs.getString("NPCD_EMAIL"));		
				
				
				if(rs != null){rs.close();}
				
				if(rs != null){rs.close();}
				if(!StrAadhaarAddrSeq.equals(""))
				{
					strQuery = SQLParser.getSqlQuery("sel_NPAddressDetBySeq^"+strRef+'^'+StrAadhaarAddrSeq);
					rs1 = DBUtils.executeQuery(strQuery);
					if (rs1.next())
					{
						StrCurrAddr1=Helper.correctNull((String)rs1.getString("address1")) ;//
						StrCurrAddr2= Helper.correctNull((String)rs1.getString("address2"));//
						String city=Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME"));
						String state=Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME"));
						
						if(!state.equalsIgnoreCase("")){
						strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
						rs3 = DBUtils.executeQuery(strQuery);			
						if(rs3.next())
						{
							StrCurrAddrState=Helper.correctNull((String)rs3.getString("STATE_CODE"));
						}
						}
						String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
						if(!city.equalsIgnoreCase("")){
							strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
							rs3 = DBUtils.executeQuery(strQuery);			
							if(rs3.next())
							{
								StrCurrAddrACity=Helper.correctNull((String)rs3.getString("CITY_CODE"));	
							}
						}
			
						StrCurrAddrCountry=Helper.correctNull((String)rs1.getString("NPAD_COUNTRY_NAME"));//
						StrCurrAddrPin=Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE"));
					} 
				}
				/*arrValues.add(StrCurrAddr1);//15
				arrValues.add(StrCurrAddr2);//16
				arrValues.add(StrCurrAddrACity);//17
				arrValues.add(StrCurrAddrState);//18
				arrValues.add(StrCurrAddrPin);//19
				
				arrValues.add(strBusinessEnterprise);//20
*/				
				
				
				/*if(!StrCurrAddrSeq.equals(""))
				{
					strQuery = SQLParser.getSqlQuery("sel_NPAddressDetBySeq^"+strRef+'^'+StrCurrAddrSeq);
					rs1 = DBUtils.executeQuery(strQuery);
					if (rs1.next())
					{
						 StrOfficeAddr1=Helper.correctNull((String)rs1.getString("address1"))   ;
						 StrOfficeAddr2=Helper.correctNull((String)rs1.getString("address2"));
						 
						 String city=Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME"));
							String state=Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME"));
							
							if(!state.equalsIgnoreCase("")){
							strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
							rs3 = DBUtils.executeQuery(strQuery);			
							if(rs3.next())
							{
								StrOfficeAddrState=Helper.correctNull((String)rs3.getString("STATE_CODE"));
							}
							}
							String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
							if(!city.equalsIgnoreCase("")){
								strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
								rs3 = DBUtils.executeQuery(strQuery);			
								if(rs3.next())
								{
									StrOfficeAddrCity=Helper.correctNull((String)rs3.getString("CITY_CODE"));	
								}
							}
						 
						 StrOfficeAddrCountry=Helper.correctNull((String)rs1.getString("NPAD_COUNTRY_NAME"));//
						 StrOfficeAddrPin=Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE"));
					} 
					 
				}*/
				/*arrValues.add(StrOfficeAddr1);//24
				arrValues.add(StrOfficeAddr2);//25
				arrValues.add(StrOfficeAddrCity);//26
				arrValues.add(StrOfficeAddrState);//27
				arrValues.add(StrOfficeAddrPin);//28
				arrValues.add("IN");//29
				arrValues.add(strEmail);
				arrValues.add(strMudraindustrytype);
				arrValues.add(strConstitution);
				arrValues.add(strRegistrationdate);
				arrValues.add("OO");*/
				arrValues.add(LapsAppid);//1
				hshQueryValues.put("size","1");
				System.out.print(arrValues);
				hshQuery.put("strQueryId","upd_npcustprofile_BS");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				

		
		
		
		hshQuery = new HashMap();
		hshQueryValues = new HashMap();
		arrValues = new ArrayList();
		hshQuery.put("strQueryId","com_division_upd_NP");	
		arrValues.add(LapsAppid);	
		arrValues.add(LapsAppid);	
		arrValues.add(strAssociateName);	
		arrValues.add(strAnyassociateconcern);	
		
		if(!StrOfficeAddrSeq.equals(""))
		{
			strQuery = SQLParser.getSqlQuery("sel_NPAddressDetBySeq^"+strRef+'^'+StrOfficeAddrSeq);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next())
			{
				 StrOfficeAddr1=Helper.correctNull((String)rs1.getString("address1"))   ;
				 StrOfficeAddr2=Helper.correctNull((String)rs1.getString("address2"));
					String city=Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME"));
					String state=Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME"));
					
					if(!state.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						StrOfficeAddrState=Helper.correctNull((String)rs3.getString("STATE_CODE"));
					}
					}
					String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
					if(!city.equalsIgnoreCase("")){
						strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
						rs3 = DBUtils.executeQuery(strQuery);			
						if(rs3.next())
						{
							StrOfficeAddrCity=Helper.correctNull((String)rs3.getString("CITY_CODE"));	
						}
					}
				 StrOfficeAddrPin=Helper.correctNull((String)rs.getString("NPAD_PIN_CODE"));
				 
		
			}
			 
		}
		arrValues.add(StrOfficeAddr1);
		arrValues.add(StrOfficeAddrCity);
		arrValues.add(StrOfficeAddrState);
		arrValues.add(StrOfficeAddrPin);
		arrValues.add(LapsAppid);//1
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);
		hshQueryValues.put("size","1");	
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			
		}
		
		}
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","upd_nplapsappid");	
			arrValues.add(LapsAppid);	
			arrValues.add(strRefno);			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","upd_nplapsappid5");	
			arrValues.add(LapsAppid);	
			arrValues.add(strRefno);			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","updperappid_np");	
			arrValues.add(LapsAppid);	
			arrValues.add(strRefno);
			arrValues.add(StrName);
			System.out.print("arrValues dedupe old id --"+arrValues);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
		}
		hshappcr=getNPApplicationCreation_BS(hshValues);
		hsh = getNpMailbox(hshValues);

	}
	catch(Exception ex)
	{
		Logger.log("Exception in getNpapplications"+ex.toString());
	}	
	return hsh;
}
public HashMap getNPApplicationCreation_BS(HashMap hshValues) 
{
	ResultSet rs = null;
	ResultSet rs1 = null;
	HashMap hshRecord = new HashMap();
	HashMap hsh = new HashMap();
	String strQuery = "",strquery1="";
	HashMap hshQuery = new HashMap();
	ArrayList arrValues = new ArrayList();
	HashMap hshQueryValues = new HashMap();
	String strbranchcode=Helper.correctNull((String)hshValues.get("strOrgShortCode"));
	String strusrid=Helper.correctNull((String)hshValues.get("strUserId"));
	String strStatus=Helper.correctNull((String)hshValues.get("hidaction"));
	String strRefno = Helper.correctNull((String)hshValues.get("hidRefId"));
	MastApplicantBean CustPrfAppID = new MastApplicantBean();
	String LapsAppid="";
	HashMap hshResult = new HashMap();
	HashMap hshLoanProduct = new HashMap();
	HashMap hshlockvalues = new HashMap();
	String strApplicationNo="";
	int intUpdatesize=0;
	String hidApploanType = Helper.correctNull((String)hshValues.get("hidloanapptype"));
	String strOrglevel=correctNull((String)hshValues.get("strOrgLevel"));
    String strissaral=correctNull((String)hshValues.get("strIsSaral"));
	String strOrgbankFlag=correctNull((String)hshValues.get("strOrgbankFlag"));
	String strAppBankName=correctNull((String)hshValues.get("strAppBankName"));
    String strFromuserid=Helper.correctNull((String)hshValues.get("strUserId"));
	HashMap hshqueryval = new HashMap();
	ArrayList arr = new ArrayList();

	try
	{			
		String strInwardno="",strappno="",strLapsappid="";
		String strLapsid="",strNewapp="",strCbsid="",StrName2="";
		strQuery = SQLParser.getSqlQuery("seldedupecheck_np^"+strRefno);
		rs = DBUtils.executeQuery(strQuery);			
		if(rs.next())
		{
			strLapsid=Helper.correctNull((String)rs.getString("NP_LAPSID"));
			strNewapp=Helper.correctNull((String)rs.getString("NP_ISNEW"));
			strCbsid=Helper.correctNull((String)rs.getString("NP_CBSID"));
			StrName2=Helper.correctNull((String)rs.getString("NP_APPLICANTNAME"));
		}
		if(rs != null){rs.close();}
		strQuery = SQLParser.getSqlQuery("sel_npapplicationdetails^"+strRefno);//need to check query code
		rs = DBUtils.executeQuery(strQuery);			
		if(rs.next())
		{			
			strInwardno = Helper.correctNull((String)rs.getString("NPDT_INWARDNO"));	
		}
		String StrName1="";
		strQuery = SQLParser.getSqlQuery("sel_nppersonaldetails^"+strRefno);
		rs = DBUtils.executeQuery(strQuery);			
		if(rs.next())
		{	
			String name="";
			if(!Helper.correctNull((String)rs.getString("NPPD_FIRST_NAME")).equalsIgnoreCase(""))
			{
				name=Helper.correctNull((String)rs.getString("NPPD_FIRST_NAME"));
			}
			if(!Helper.correctNull((String)rs.getString("NPPD_LAST_NAME")).equalsIgnoreCase(""))
			{
				name=name+" "+Helper.correctNull((String)rs.getString("NPPD_LAST_NAME"));
			}
			if(!Helper.correctNull((String)rs.getString("NPPD_MIDDLE_NAME")).equalsIgnoreCase(""))
			{
				name=name+" "+Helper.correctNull((String)rs.getString("NPPD_MIDDLE_NAME"));
			}
			
			 StrName1=name;
			//strLapsappid=Helper.correctNull((String)rs.getString("NPPD_LAPSAPPID"));
		}
		if(strLapsappid.equalsIgnoreCase(""))
		{
			strQuery = SQLParser.getSqlQuery("sel_npdedupemailbxdet^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{	
				StrName1=Helper.correctNull((String)rs.getString("NP_APPLICANTNAME"));
				strLapsappid=Helper.correctNull((String)rs.getString("NP_LAPSID"));
			}
		}
		String strSchemeName1="";
		strQuery = SQLParser.getSqlQuery("sel_npapplicationdetails^"+strRefno);
		rs = DBUtils.executeQuery(strQuery);
		if (rs.next())
		{
			strSchemeName1=Helper.correctNull((String)rs.getString("NPDT_NP_SCHEME_NAME"));//NPDT_NP_SCHEME_NAME
		}
		if(rs!=null)
		{
			rs.close();					
		}
		
		int intappno=0;
		hshlockvalues = new HashMap();
		hshlockvalues.put("apptype",Helper.correctNull((String)hshValues.get("hidloanapptype")));//to be pass
		hshlockvalues.put("comapp_id",strLapsappid);//strSolid
		hshlockvalues.put("strSolid",correctNull((String) hshValues.get("strOrgShortCode")));
		hshlockvalues.put("orgscode",correctNull((String) hshValues.get("strOrgShortCode")));
		double dblloanamnt=0.00,dblsubsidyamnt=0.00,dblROI=0.00,dblEMI=0.00;
		String strtenor="";			
		String Schemetype="";
		strQuery = SQLParser.getSqlQuery("sel_applicationscheme_np^"+strRefno);
		rs = DBUtils.executeQuery(strQuery);			
		if(rs.next())
		{
			Schemetype=Helper.correctNull((String)rs.getString("NPDT_NP_SCHEME_NAME"));
		}
		//strApplicationNo = (String) EJBInvoker.executeStateLess("appeditlock", hshlockvalues, "getAppno");
		String strOrgShortCode="",strBorrowerId="",strorgcode="",strscode="";
		String strAppno="";
		long longAppno=0;
		int intLen=0;
		java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
		nf.setMinimumIntegerDigits(7);
		nf.setGroupingUsed(false);
				strQuery=SQLParser.getSqlQuery("findBorrowerOrgPer^"+strLapsappid);
				if(rs != null)
				{
					rs.close();
				}
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strOrgShortCode =correctNull((String)rs.getString(1));
				}
			
			
			if(strOrgShortCode.equalsIgnoreCase(""))
			{
				
				strOrgShortCode=correctNull((String) hshValues.get("strOrgShortCode"));
			}
			strOrgShortCode = strOrgShortCode.trim();
			
			int scodeLength=strOrgShortCode.length();
			
			if(scodeLength==1){
				strOrgShortCode="000"+strOrgShortCode;
			}
			if(scodeLength==2){
				strOrgShortCode="00"+strOrgShortCode;
			}
			if(scodeLength==3){
				strOrgShortCode="0"+strOrgShortCode;
			}
			
			intLen=strOrgShortCode.length();
			//strQuery=SQLParser.getSqlQuery("getAppno^"+intLen+"^"+strOrgShortCode);
			strQuery=SQLParser.getSqlQuery("getAppno^"+(intLen+1)+"^"+intLen+"^"+strOrgShortCode);
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				longAppno=(rs.getLong(1));
			}
			longAppno++;
			strApplicationNo=strOrgShortCode+nf.format(longAppno);
			
		
		
		if(!strApplicationNo.equalsIgnoreCase(""))
		{
			intappno = Integer.parseInt(strApplicationNo.substring((strApplicationNo.length()-7), strApplicationNo.length()));
		}
		if (!(strApplicationNo.equalsIgnoreCase("new") && hidApploanType.equalsIgnoreCase("")))
		{
			intUpdatesize++;
			arrValues.add(strApplicationNo);
			arrValues.add(getNPtoLAPSCommonLOV1(Helper.correctNull((String)hshValues.get("SchemeName")),
					Helper.correctNull((String)hshValues.get("selsegment")),"PRODUCTCODE",Schemetype));
			arrValues.add(correctNull((String) hshValues.get("strUserId")));
			arrValues.add(correctNull((String) hshValues.get("strOrgCode")));									
			arrValues.add("C");
			arrValues.add(strInwardno);
			arrValues.add("R");
			arrValues.add((strOrglevel.equalsIgnoreCase("D") && strissaral.equalsIgnoreCase("Y"))?"S":strOrglevel);
			arrValues.add(correctNull((String)hshValues.get("strUserId")));
			arrValues.add("Y");
			//arrValues.add(correctNull((String)hshValues.get("sel_sustenance")));
			arrValues.add(strAppBankName);
			arrValues.add(String.valueOf(intappno));
			arrValues.add((strRefno));
			/*arrValues.add(getNPtoLAPSCommonLOV1(Helper.correctNull((String)hshValues.get("SchemeName")),
					Helper.correctNull((String)hshValues.get("selsegment")),"SCHEMEID",Schemetype));*/
			/*if(strSchemeName1.equalsIgnoreCase("NULM"))
			{
				arrValues.add("ML");	
			}else{
				arrValues.add("");	
			}*/
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "insapplications_BS");
			System.out.print("arrValues application details "+arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			hshQueryValues.put("size", Integer.toString(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			
			
			
			
		
			
			/* For inserting in demographic table */
			 intUpdatesize=0;
			
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			intUpdatesize++;
			arrValues.add(strApplicationNo);
			arrValues.add(strLapsappid);
			arrValues.add("");
			arrValues.add("");
			arrValues.add("4");
			arrValues.add("N");
			arrValues.add("");
			arrValues.add(strLapsappid);
			
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "ins_comdemographics");
			System.out.print("arrValues demograghics details "+arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			hshQueryValues.put("size", Integer.toString(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			
			hshqueryval = new HashMap();
			HashMap hshquery = new HashMap();
			arrValues = new ArrayList();
			hshquery.put("strQueryId","updateapplicationsno_np");
			arrValues.add(strApplicationNo);
			arrValues.add(strRefno);//9
			hshquery.put("arrValues",arrValues);
			hshqueryval.put("size","1");
			hshqueryval.put("1",hshquery);						
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			
			//Communication Details
			 intUpdatesize=0;
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			intUpdatesize++;
			/*int intLapsappids=0;
			intLapsappids=Integer.parseInt(strLapsappid);
			arrValues.add(intLapsappids);*/
			arrValues.add(strLapsappid);
			if(rs != null){rs.close();}
			
			strQuery = SQLParser.getSqlQuery("selnpdetails^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_VILLAGE")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_CITY_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STATE_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
				arrValues.add("44");
				
			}
			else{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				
			}
			System.out.print("arrValues dedupe old id --"+arrValues);
			
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "inscustinfo");
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			hshQueryValues.put("size", Integer.toString(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			
			
			 intUpdatesize=0;
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			intUpdatesize++;
			arrValues.add(strLapsappid);
            if(rs != null){rs.close();}
			
            strQuery = SQLParser.getSqlQuery("sel_nppersonaldetails^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
			arrValues.add(getNPtoLAPSListOfValue("3",Helper.correctNull((String)rs.getString("NPPD_SOCIAL_CATEGORY"))));
			arrValues.add(getNPtoLAPSListOfValue("7",Helper.correctNull((String)rs.getString("NPPD_EDU_QUALIFICATION"))));
			}
			else 
			{
				arrValues.add("");
				arrValues.add("");	
			}
			System.out.print("arrValues demo  --"+arrValues);
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "ins_otherdetails");
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			hshQueryValues.put("size", Integer.toString(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			
			
			 intUpdatesize=0;
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			intUpdatesize++;
			arrValues.add(strLapsappid);
			System.out.print("arrValues demo  --"+arrValues);
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "perloandetailscompany");
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			hshQueryValues.put("size", Integer.toString(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			
			/****
			 * For Updating in inward register
			 */
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = 1;
			arrValues.add("Y");
			arrValues.add("E");
			arrValues.add(strCbsid);
			arrValues.add(strInwardno);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","updinwardappatached1");
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			hshQueryValues.put("size", Integer.toString(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
							
			if(rs != null){rs.close();}
			
			String toorgcode="",togrpid="",fromgrpid="";
			if(rs != null){rs.close();}
			strQuery = SQLParser.getSqlQuery("sel_userorg_grpidapp1^"+strFromuserid);
			rs= DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				toorgcode=Helper.correctNull((String)rs.getString("USR_ORGCODE"));
				togrpid=Helper.correctNull((String)rs.getString("USR_GRPID"));
			}
			if(rs != null){rs.close();}
			strQuery = SQLParser.getSqlQuery("sel_userorg_grpidapp1^"+strFromuserid);
			rs= DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				fromgrpid=Helper.correctNull((String)rs.getString("USR_GRPID"));
			}
			
			//ArrayList arrIds=new CommWorkflowBean().getFromToOrgLevel(strFromuserid,strFromuserid); // From To Org Level
			intUpdatesize=0;
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","commworkflowins");
			arrValues.add(strApplicationNo);
			arrValues.add(strFromuserid);
			arrValues.add(strFromuserid);
			arrValues.add("1");
			arrValues.add("1");
			arrValues.add("C");
			arrValues.add(Helper.correctNull((String)hshValues.get("strOrgCode")));			
			arrValues.add(toorgcode);			
			arrValues.add(fromgrpid);			
			arrValues.add(togrpid);
			/*arrValues.add(arrIds.get(0));			
			arrValues.add(arrIds.get(1));*/
			//arrValues.add("");
			//arrValues.add("");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			hshQueryValues.put("size", Integer.toString(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
		
			// Inserting promoter table
			
			String strSalutation="",strName="",strDob="",strPan="",strFathersname="",strGender="",strMobile="",strRelationshiptype="";
			int intTotalexp=0,intNetworth=0;
			strQuery = SQLParser.getSqlQuery("select_npapp_check_Mudra^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				
				strSalutation=getNPtoLAPSListOfValue("4",Helper.correctNull((String)rs.getString("MPDP_SALUTATION")));
				strName=Helper.correctNull((String)rs.getString("APPLICANTNAME"));
				strDob=Helper.correctNull((String)rs.getString("MPDP_DOB"));
				strPan=Helper.correctNull((String)rs.getString("MPDP_PAN"));			
				strFathersname=Helper.correctNull((String)rs.getString("MPDP_FATHERS_NAME"));
				strGender=getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("MPDP_GENDER")));
				strMobile=Helper.correctNull((String)rs.getString("MPDP_MOBILE"));
				String Totalexp=Helper.correctNull((String)rs.getString("MPDP_TOTAL_EXP"));
				if(!Totalexp.equalsIgnoreCase(""))
				{
				intTotalexp=Integer.parseInt(Helper.correctNull((String)rs.getString("MPDP_TOTAL_EXP")));
				}
				String Networth=Helper.correctNull((String)rs.getString("MPDP_NET_WORTH"));
				if(!Networth.equalsIgnoreCase(""))
				{
					intNetworth=Integer.parseInt(Helper.correctNull((String)rs.getString("MPDP_NET_WORTH")));
				}
				strRelationshiptype=Helper.correctNull((String)rs.getString("MPDP_RELATIONSHIP_TYPE"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			
			String strCurrentcity="",strCurrentcountry="",strCurrentdistrict="",strCurrentland="",strCurrentpincode="",strCurrentstate="",strCurrentstreet="",
					strCurrentsubdistrict="",strCurrentvillage=""; 
			strQuery = SQLParser.getSqlQuery("get_applicantcurrentaddress^"+strRefno); 
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				strCurrentcity=Helper.correctNull((String) rs.getString("NPCA_CITY_NAME"));
				strCurrentcountry= Helper.correctNull((String) rs.getString("NPCA_COUNTRY_NAME"));
				strCurrentdistrict= Helper.correctNull((String) rs.getString("NPCA_DISTRICT_NAME"));
				strCurrentland=Helper.correctNull((String) rs.getString("NPCA_LAND_MARK"));
				strCurrentpincode=Helper.correctNull((String) rs.getString("NPCA_PIN_CODE"));
				strCurrentstate= Helper.correctNull((String) rs.getString("NPCA_STATE_NAME"));
				strCurrentstreet= Helper.correctNull((String) rs.getString("NPCA_STREET_NAME"));
				strCurrentsubdistrict=Helper.correctNull((String) rs.getString("NPCA_SUB_DISTRICT"));
				strCurrentvillage= Helper.correctNull((String) rs.getString("NPCA_VILLAGE"));
			}if(rs != null)
			   {
				rs.close();
			   }
			intUpdatesize=0;
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			intUpdatesize++;
			arrValues.add(strApplicationNo);
			arrValues.add(strName);
			arrValues.add("P");
			arrValues.add(strDob);
			arrValues.add(strMobile);
			arrValues.add(strGender);
			arrValues.add(String.valueOf(intTotalexp));
			arrValues.add(String.valueOf(intNetworth));
			arrValues.add(strLapsappid);
			arrValues.add(strCurrentstreet);
			arrValues.add(strCurrentvillage);
			arrValues.add(strCurrentcity);
			arrValues.add(strCurrentstate);
			arrValues.add(strCurrentpincode);
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "com_promotor_ins_NP");
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			hshQueryValues.put("size", Integer.toString(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			
			
			
			String strMudramachinetype="",strMudrapurposereq="";
			strQuery = SQLParser.getSqlQuery("sel_busmudraloanasstacqdet^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				strMudramachinetype=Helper.correctNull((String)rs.getString("MUDRA_MACHINE_TYPE"));
				strMudrapurposereq=Helper.correctNull((String)rs.getString("MUDRA_PURPOSE_OF_REQUIRMNT"));
			
			}
			if(rs!=null){rs.close();}
			
			strQuery = SQLParser.getSqlQuery("sel_busstandindMachidetails^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				strMudramachinetype=Helper.correctNull((String)rs.getString("NPSM_MAC_TYPE"));
				strMudrapurposereq=Helper.correctNull((String)rs.getString("NPSM_REQ_PURP"));
			
			}
			if(rs!=null){rs.close();}
			
			
			
			String strAnyassociateconcern="",strAssociateName="",strConstitution="";
			strQuery = SQLParser.getSqlQuery("getAssoConcernDetails^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				strAnyassociateconcern=Helper.correctNull((String)rs.getString("NPACD_ANY_ASSOCIATE_CONCERN"));
				strAssociateName=Helper.correctNull((String)rs.getString("NPACD_ASSOCIATE_NAME"));
				strConstitution=Helper.correctNull((String)rs.getString("NPACD_CONSTITUTION_ID"));
			
			}
			if(rs!=null){rs.close();}	
			
			
			String strExisbankarrange="",strPropobankarrange="",strCommercialoperdate="";
			double dblPromcontri=0.00;
			strQuery = SQLParser.getSqlQuery("select_loan_check_Mudra^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				
				String loanamt=Helper.correctDouble((String)rs.getString("LOAN_AMNT_REQURD"));
				if(!loanamt.equalsIgnoreCase("")){
					dblloanamnt = Double.parseDouble(loanamt);
				}
				strtenor = Helper.correctNull((String)rs.getString("MUDRA_TENURE"));
				strExisbankarrange=Helper.correctNull((String)rs.getString("BUSINESS_ACTIVITY_EXISTNG"));
				strPropobankarrange=Helper.correctNull((String)rs.getString("BUSINESS_ACTIVITY_PROPOSD"));
				String promotr_contribution=Helper.correctDouble((String)rs.getString("MUDRA_PROMOTR_CONTRIBUTION"));
				if(!promotr_contribution.equalsIgnoreCase("")){
					dblPromcontri = Double.parseDouble(promotr_contribution);
				}
				strCommercialoperdate=Helper.correctNull((String)rs.getString("COMMERCIAL_OPERATN_DATE"));
			
			}if(rs != null){rs.close();}
			
			strQuery = SQLParser.getSqlQuery("select_loan_check_STD^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				String npsl_tot_loan=Helper.correctDouble((String)rs.getString("NPSL_PRO_CONTRBN"));
				if(!npsl_tot_loan.equalsIgnoreCase("")){
					dblPromcontri = Double.parseDouble(npsl_tot_loan);
				}
				strExisbankarrange=Helper.correctNull((String)rs.getString("NPSL_EXIS_BUS_ACT"));
				if(strExisbankarrange.equalsIgnoreCase(""))
				{
					strExisbankarrange="0";
				}
				strPropobankarrange=Helper.correctNull((String)rs.getString("NPSL_PRO_BUS_ACT"));
				if(strPropobankarrange.equalsIgnoreCase(""))
				{
					strPropobankarrange="0";
				}
			//	dblPromcontri = Double.parseDouble(Helper.correctDouble((String)rs.getString("NPSL_PRO_CONTRBN")));
			
			}if(rs != null){rs.close();}
			
			strQuery = SQLParser.getSqlQuery("select_loan_check_SRMS^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				String loanamt=Helper.correctDouble((String)rs.getString("NPSL_LOAN_AMT"));
				if(!loanamt.equalsIgnoreCase(""))
				{
				dblloanamnt = Double.parseDouble(loanamt);
				}
			}if(rs != null){rs.close();}
			
			strQuery = SQLParser.getSqlQuery("select_loan_check_SWMS^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				String loanamt=Helper.correctDouble((String)rs.getString("NPSL_REQ_LOAN_AMT"));
				if(!loanamt.equalsIgnoreCase(""))
				{
				dblloanamnt = Double.parseDouble(loanamt);
				}
			}if(rs != null){rs.close();}
			


			
			
			double dblmargin=0.00,dblspread=0.00,dblTenor=0.00,dblTotalfinance=0.00,dblPromotercontribution=0.00,dblExistingLoanAmnt=0.00;
			if(rs != null){rs.close();}
			strQuery = SQLParser.getSqlQuery("select_scalingdetails^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				String margin=Helper.correctDouble((String)rs.getString("NSM_MARGIN"));
			if(!margin.equalsIgnoreCase(""))
			{
				dblmargin = Double.parseDouble(margin);
			}
			String nsm_spread=Helper.correctDouble((String)rs.getString("NSM_SPREAD"));
			if(!nsm_spread.equalsIgnoreCase(""))
			{
				dblspread = Double.parseDouble(nsm_spread);
			}
			String nsm_tenore=Helper.correctDouble((String)rs.getString("NSM_TENORE"));
			if(!nsm_tenore.equalsIgnoreCase(""))
			{
				dblTenor = Double.parseDouble(nsm_tenore);
			}
				
			}
			if(rs != null){rs.close();}
			
			strQuery = SQLParser.getSqlQuery("sel_npprincdet^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				String npid_emi=Helper.correctDouble((String)rs.getString("NPID_EMI"));
				if(!npid_emi.equalsIgnoreCase(""))
				{
					dblEMI = Double.parseDouble(npid_emi);
				}
				String npid_roi=Helper.correctDouble((String)rs.getString("NPID_ROI"));
				if(!npid_roi.equalsIgnoreCase(""))
				{
					dblROI = Double.parseDouble(npid_roi);
				}
				String nsm_tenore=Helper.correctDouble((String)rs.getString("NPID_TENOR"));
				if(!nsm_tenore.equalsIgnoreCase(""))
				{
					dblTenor = Double.parseDouble(nsm_tenore);
				}
				String loanamt=Helper.correctDouble((String)rs.getString("NPID_LOAN_AMT"));
				if(!loanamt.equalsIgnoreCase(""))
				{
				dblloanamnt = Double.parseDouble(loanamt);
				}
				
			}
			if(rs != null){rs.close();}	
			strQuery = SQLParser.getSqlQuery("getEligibilityDetails^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				String npid_emi=Helper.correctDouble((String)rs.getString("EPD_EMI"));
				String epd_existingloanamt=Helper.correctDouble((String)rs.getString("EPD_EXISTINGLOANAMT"));
				if(!epd_existingloanamt.equalsIgnoreCase(""))
				{
					dblExistingLoanAmnt = Double.parseDouble(epd_existingloanamt);
				}
				String epd_promotercontribution=Helper.correctDouble((String)rs.getString("EPD_PROMOTERCONTRIBUTION"));
				if(!epd_promotercontribution.equalsIgnoreCase(""))
				{
					dblPromotercontribution = Double.parseDouble(epd_promotercontribution);
				}
				String epd_totfinance=Helper.correctDouble((String)rs.getString("EPD_TOTFINANCE"));
				if(!epd_totfinance.equalsIgnoreCase(""))
				{
					dblTotalfinance = Double.parseDouble(epd_totfinance);
				}
				
				
			}
			if(rs != null){rs.close();}	
			
			String strLenderName="",strPrimsecoff="",strColloff="",strColldetail="";
			double dblExilimitsancamt=0.00,dblPRocurrentbal=0.00;
			strQuery = SQLParser.getSqlQuery("sel_creditdetails_NP^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				strLenderName = Helper.correctNull((String)rs.getString("NPCFD_LENDER_NAME"));
				String npcfd_sanctioned_amt=Helper.correctDouble((String)rs.getString("NPCFD_SANCTIONED_AMT"));
				if(!npcfd_sanctioned_amt.equalsIgnoreCase(""))
				{
					dblExilimitsancamt = Double.parseDouble(npcfd_sanctioned_amt);
				}
				String EPD_TOTFINANCE=Helper.correctDouble((String)rs.getString("EPD_TOTFINANCE"));
				if(!EPD_TOTFINANCE.equalsIgnoreCase(""))
				{
					dblPRocurrentbal = Double.parseDouble(EPD_TOTFINANCE);
				}
					
			}
			if(rs != null){rs.close();}	
			
			strQuery = SQLParser.getSqlQuery("sel_busstandindloanmapdetails^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				strPrimsecoff = Helper.correctNull((String)rs.getString("NPSP_PRIM_SEC_OFF"));
				strColloff = Helper.correctNull((String)rs.getString("NPSP_COLL_OFF"));
				strColldetail = Helper.correctNull((String)rs.getString("NPSP_COLL_DET"));
					
			}
			if(rs != null){rs.close();}	
			intUpdatesize=0;
			
			//Inserting Bankarrangement table
			intUpdatesize=0;
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			intUpdatesize++;
			
			arrValues.add(strApplicationNo);	
			arrValues.add(strLenderName);
			arrValues.add(String.valueOf(dblExilimitsancamt));
			arrValues.add(String.valueOf(dblPRocurrentbal));
			arrValues.add("0");
			arrValues.add("W");
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "com_workingcapital_ins_NP");
			hshQueryValues.put(""+intUpdatesize, hshQuery);	
			hshQueryValues.put("size", Integer.toString(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
							
			
			// For inserting in Facility table 
			String fac_headid="",fac_id="",fac_code="";
			String loanpurpose="";
			 if(strSchemeName1.equalsIgnoreCase("SWMS"))
			{
				 
				 
				
				strQuery = SQLParser.getSqlQuery("sel_swms_loanpurpose^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					loanpurpose = Helper.correctNull((String)rs.getString("NPSL_LOANPURPOSE"));
					
				}
				if(rs != null){rs.close();}	
				
				
				
			}else  if(strSchemeName1.equalsIgnoreCase("NULM"))
			{
				double dblperposeloan=0.00,dblrequestedamt=0.00;
				String strperposeloan="";
				if(rs != null){rs.close();}
				strQuery = SQLParser.getSqlQuery("getNULMLoanDetails^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					loanpurpose=Helper.correctNull((String)rs.getString("NULM_PURPOSE_OF_LOAN"));
				}
				
				
			}
			else if(strSchemeName1.equalsIgnoreCase("STD") || strSchemeName1.equalsIgnoreCase("PMMY"))
			{
				strQuery = SQLParser.getSqlQuery("sel_pmmy_loanpurpose^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					loanpurpose = Helper.correctNull((String)rs.getString("MUDRA_PURPOSE_OF_LOAN"));
					
				}
				if(rs != null){rs.close();}	
				
			}
				fac_headid=getNPtoLAPSCommonLOV1(Helper.correctNull((String)hshValues.get("SchemeName")),
						Helper.correctNull((String)hshValues.get("selsegment")),"facheadid",strSchemeName1);
				fac_id=getNPtoLAPSCommonLOV1(Helper.correctNull((String)hshValues.get("SchemeName")),
						Helper.correctNull((String)hshValues.get("selsegment")),"facid",strSchemeName1);
				fac_code=getNPtoLAPSCommonLOV1(Helper.correctNull((String)hshValues.get("SchemeName")),
						Helper.correctNull((String)hshValues.get("selsegment")),"faccode",strSchemeName1);
				String prdcode=getNPtoLAPSCommonLOV1(Helper.correctNull((String)hshValues.get("SchemeName")),
						Helper.correctNull((String)hshValues.get("selsegment")),"PRODUCTCODE",strSchemeName1);
			
			intUpdatesize=0;
			
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			intUpdatesize++;
			arrValues.add(strApplicationNo);
			arrValues.add("1");
			//arrValues.add(strtenor);
			if (strtenor.equals(""))
			{
				arrValues.add("0");
			}
			else
			{
				arrValues.add(strtenor);
			}
			//arrValues.add(String.valueOf(dblmargin));
			arrValues.add(String.valueOf(dblspread));
			arrValues.add(String.valueOf(dblROI));
			//arrValues.add(String.valueOf(dblEMI));
			arrValues.add(String.valueOf(dblExistingLoanAmnt));
			arrValues.add("0");
			/*arrValues.add(fac_code);
			arrValues.add(fac_headid);
			arrValues.add(fac_id);*/
			arrValues.add("361");
			arrValues.add("4");
			arrValues.add("103");
			arrValues.add(strLapsappid);
			arrValues.add(String.valueOf(dblloanamnt));
			
			/*String fac_desc="";
			strQuery = SQLParser.getSqlQuery("selparentfacility^"+fac_id);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				fac_desc = Helper.correctNull((String)rs.getString("FACILITY_CATDESC"));
				
			}
			if(rs != null){rs.close();}	
			arrValues.add(fac_desc);*/
			//arrValues.add(prdcode);
			arrValues.add("1");
			arrValues.add("R");
			arrValues.add(String.valueOf(dblROI));
			//arrValues.add("");
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "insFacility_NP");
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			hshQueryValues.put("size", Integer.toString(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			
			
			hshLoanProduct.put("appno", strApplicationNo);
			
			hshLoanProduct.put("radLoan", "Y");
			hshLoanProduct.put("hidapplicantid",strLapsappid);
			hshLoanProduct.put("page", "ep");
			hshLoanProduct.put("strUserId", correctNull((String) hshValues.get("strUserId")));
			hshLoanProduct.put("strGroupRights", correctNull((String) hshValues.get("strGroupRights")));
			
			
			if(rs != null){rs.close();}
			strQuery = SQLParser.getSqlQuery("sel_npcoappdet^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			while(rs.next())
			{	
				String name="";
				if(!Helper.correctNull((String)rs.getString("NPCD_FNAME")).equalsIgnoreCase(""))
				{
					name=Helper.correctNull((String)rs.getString("NPCD_FNAME"));
				}
				if(!Helper.correctNull((String)rs.getString("NPCD_LNAME")).equalsIgnoreCase(""))
				{
					name=name+" "+Helper.correctNull((String)rs.getString("NPCD_LNAME"));
				}
				if(!Helper.correctNull((String)rs.getString("NPCD_MNAME")).equalsIgnoreCase(""))
				{
					name=name+" "+Helper.correctNull((String)rs.getString("NPCD_MNAME"));
				}
				String StrName=name;
				String PerAppid="";
				strQuery = SQLParser.getSqlQuery("selperappid_np^"+strRefno+"^"+StrName);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					PerAppid=Helper.correctNull((String)rs1.getString("NP_LAPSID"));
				}
				strLapsappid=PerAppid;
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","ins_comdemographics");				
				arrValues.add(strApplicationNo);
				arrValues.add(strLapsappid);
				arrValues.add("");
				arrValues.add("");
				arrValues.add("4");
				arrValues.add("g");
				arrValues.add("");
				arrValues.add(strLapsappid);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
				
			}
			/*hshqueryval = new HashMap();
			HashMap hshquery = new HashMap();
			arrValues = new ArrayList();
			hshquery.put("strQueryId","updateapplicationsno_np");
			arrValues.add(strApplicationNo);
			arrValues.add(strRefno);//9
			hshquery.put("arrValues",arrValues);
			hshqueryval.put("size","1");
			hshqueryval.put("1",hshquery);						
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			*/
					
		
			
		}
		
	}
	catch(Exception ex)
	{
		Logger.log("Exception in getNpapplications_BS "+ex.toString());
	}	
	return hsh;
}
public HashMap getNPBSInwardCreation(HashMap hshValues) 
{
	ResultSet rs = null;
	ResultSet rs1 = null;
	ResultSet rs3 = null;
	HashMap hshRecord = new HashMap();
	HashMap hsh = new HashMap();
	String strQuery = "",strquery1="";
	HashMap hshQuery = new HashMap();
	ArrayList arrValues = new ArrayList();
	HashMap hshQueryValues = new HashMap();
	String strbranchcode=Helper.correctNull((String)hshValues.get("strOrgShortCode"));
	String strusrid=Helper.correctNull((String)hshValues.get("strUserId"));
	String strStatus=Helper.correctNull((String)hshValues.get("hidaction"));
	String strRefno = Helper.correctNull((String)hshValues.get("hidRefId"));
	
	if(strRefno.equalsIgnoreCase("")){
	strRefno = Helper.correctNull((String)hshValues.get("hidApplicantId"));
	}
	InwardRegisterBean inwardregister = new InwardRegisterBean(); 
	String selsegment=Helper.correctNull((String)hshValues.get("selsegment"));
	try
	{
		String Schemetype="";
		strQuery = SQLParser.getSqlQuery("sel_applicationscheme_np^"+strRefno);
		rs = DBUtils.executeQuery(strQuery);			
		if(rs.next())
		{
			Schemetype=Helper.correctNull((String)rs.getString("NPDT_NP_SCHEME_NAME"));
		}
		
		String strCur_Address="";
		hshQuery = new HashMap();
		hshQueryValues = new HashMap();
		arrValues = new ArrayList();
		hshQuery.put("strQueryId","ins_npinwarddet");	
		String strInqno = inwardregister.getMaxInwardno(strbranchcode);
		arrValues.add(strInqno);
		arrValues.add(strRefno);
		if(Schemetype.equalsIgnoreCase("PMMY") || Schemetype.equalsIgnoreCase("STD"))
		{
			strQuery = SQLParser.getSqlQuery("sel_np_pmmyAppcheck^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{	
			arrValues.add(Helper.correctNull((String)rs.getString("MPDP_FIRST_NAME"))+" "
					+Helper.correctNull((String)rs.getString("MPDP_MIDDLE_NAME"))
					+" "+Helper.correctNull((String)rs.getString("MPDP_LAST_NAME")));
			arrValues.add(getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("MPDP_GENDER"))));
			arrValues.add(Helper.correctNull((String)rs.getString("MPDP_DOB")));
			arrValues.add(Helper.correctNull((String)rs.getString("MPDP_EMAIL")));
			arrValues.add(Helper.correctNull((String)rs.getString("MPDP_MOBILE")));
			arrValues.add("0");
			arrValues.add("");
			arrValues.add(Helper.correctNull((String)rs.getString("MPDP_PAN")));
			strCur_Address = Helper.correctNull((String)rs.getString("MPDP_AADHAR_ADD_SEQ_NO"));
			}else{
				strQuery = SQLParser.getSqlQuery("sel_nppersonaldetails^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_FIRST_NAME"))+" "
							+Helper.correctNull((String)rs.getString("NPPD_MIDDLE_NAME"))
							+" "+Helper.correctNull((String)rs.getString("NPPD_LAST_NAME")));
					arrValues.add(getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("NPPD_GENDER"))));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_DOB")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_EMAIL")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MOBILE_NUMBER")));
					arrValues.add(getNPtoLAPSListOfValue("6",Helper.correctNull((String)rs.getString("NPPD_EMP_TYPE"))));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_VOTER_NO")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_PAN_NO")));
					strCur_Address = Helper.correctNull((String)rs.getString("NPPD_AADHAR_ADD_SEQ_NO"));
					
				}
				if(rs != null){rs.close();}
				
			}
		if(rs != null){rs.close();}
		}else if(Schemetype.equalsIgnoreCase("SWMS"))
		{
				strQuery = SQLParser.getSqlQuery("sel_np_SWMSAppcheck^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					
					arrValues.add(Helper.correctNull((String)rs.getString("NSPD_FIRST_NAME"))+" "
							+Helper.correctNull((String)rs.getString("NSPD_MIDDLE_NAME"))
							+" "+Helper.correctNull((String)rs.getString("NSPD_LAST_NAME")));
					arrValues.add(getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("NSPD_GENDER"))));
					arrValues.add(Helper.correctNull((String)rs.getString("NSPD_DOB")));
					arrValues.add(Helper.correctNull((String)rs.getString("NSPD_EMAIL")));
					arrValues.add(Helper.correctNull((String)rs.getString("NSPD_MOBILE")));
					arrValues.add("0");
					arrValues.add("");
					arrValues.add(Helper.correctNull((String)rs.getString("NSPD_PAN")));
					strCur_Address = Helper.correctNull((String)rs.getString("NSPD_CURR_ADDR_REFID"));
				}else{
					
					strQuery = SQLParser.getSqlQuery("sel_nppersonaldetails^"+strRefno);
					rs = DBUtils.executeQuery(strQuery);			
					if(rs.next())
					{
						arrValues.add(Helper.correctNull((String)rs.getString("NPPD_FIRST_NAME"))+" "
								+Helper.correctNull((String)rs.getString("NPPD_MIDDLE_NAME"))
								+" "+Helper.correctNull((String)rs.getString("NPPD_LAST_NAME")));
						arrValues.add(getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("NPPD_GENDER"))));
						arrValues.add(Helper.correctNull((String)rs.getString("NPPD_DOB")));
						arrValues.add(Helper.correctNull((String)rs.getString("NPPD_EMAIL")));
						arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MOBILE_NUMBER")));
						arrValues.add(getNPtoLAPSListOfValue("6",Helper.correctNull((String)rs.getString("NPPD_EMP_TYPE"))));
						arrValues.add(Helper.correctNull((String)rs.getString("NPPD_VOTER_NO")));
						arrValues.add(Helper.correctNull((String)rs.getString("NPPD_PAN_NO")));
						strCur_Address = Helper.correctNull((String)rs.getString("NPPD_AADHAR_ADD_SEQ_NO"));
						
					}
					if(rs != null){rs.close();}
				}
		}else{
			strQuery = SQLParser.getSqlQuery("sel_nppersonaldetails^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_FIRST_NAME"))+" "
						+Helper.correctNull((String)rs.getString("NPPD_MIDDLE_NAME"))
						+" "+Helper.correctNull((String)rs.getString("NPPD_LAST_NAME")));
				arrValues.add(getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("NPPD_GENDER"))));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_DOB")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_EMAIL")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MOBILE_NUMBER")));
				arrValues.add(getNPtoLAPSListOfValue("6",Helper.correctNull((String)rs.getString("NPPD_EMP_TYPE"))));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_VOTER_NO")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_PAN_NO")));
				strCur_Address = Helper.correctNull((String)rs.getString("NPPD_AADHAR_ADD_SEQ_NO"));
				
			}
			if(rs != null){rs.close();}
		}
		if(!strCur_Address.equalsIgnoreCase("")){
		strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+strCur_Address);
		rs = DBUtils.executeQuery(strQuery);			
		if(rs.next())
		{
			
			arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
			arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT")));
			String district=Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME"));
			//District Code added by kannan
			if(!district.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("NP_District_Name^"+district);
				rs3 = DBUtils.executeQuery(strQuery);			
				if(rs3.next())
				{
					arrValues.add(Helper.correctNull((String)rs3.getString("DISTRICT_CODE")));
				}else{
					arrValues.add("");
				}
				}else{
					arrValues.add("");
				}
			String city=Helper.correctNull((String)rs.getString("NPAD_CITY_NAME"));
			String state=Helper.correctNull((String)rs.getString("NPAD_STATE_NAME"));
			if(!state.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
				rs3 = DBUtils.executeQuery(strQuery);			
				if(rs3.next())
				{
					arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
				}else{
					arrValues.add("");
				}
				}else{
					arrValues.add("");
				}
			String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
			if(!city.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
				rs3 = DBUtils.executeQuery(strQuery);			
				if(rs3.next())
				{
					arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
				}else{
					arrValues.add("");
				}
				}else{
					arrValues.add("");
				}
			
			
			arrValues.add("IN");
			arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
		}
		else
		{
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("IN");
			arrValues.add("");
		}}else{
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("IN");
			arrValues.add("");

		}double dblloanamnt=0.00,dblsubsidyamnt=0.00;
		if(rs != null){rs.close();}
		strQuery = SQLParser.getSqlQuery("sel_npprincdet^"+strRefno);
		rs = DBUtils.executeQuery(strQuery);			
		if(rs.next())
		{
			arrValues.add(Helper.correctNull((String)rs.getString("NPID_LOAN_AMT")));
			String loanamt=Helper.correctDouble((String)rs.getString("NPID_LOAN_AMT"));
			if(!loanamt.equalsIgnoreCase("")){
			dblloanamnt = Double.parseDouble(loanamt);
			}
			arrValues.add(Helper.correctNull((String)rs.getString("NPID_TENOR")));
			String subsidy_amt=Helper.correctDouble((String)rs.getString("NPID_SUBSIDY_AMT"));
			if(!subsidy_amt.equalsIgnoreCase("")){
				dblsubsidyamnt = Double.parseDouble(subsidy_amt);
			}
		//	dblsubsidyamnt = Double.parseDouble(Helper.correctDouble((String)rs.getString("NPID_SUBSIDY_AMT")));
		}else{
			arrValues.add("");	
			arrValues.add("");	
		}
		arrValues.add("c");
		arrValues.add(getNPtoLAPSCommonLOV(Helper.correctNull((String)hshValues.get("SchemeName")),
				Helper.correctNull((String)hshValues.get("selsegment")),"PROCESSINGAT"));//to be change
		arrValues.add(strbranchcode);
		arrValues.add(strusrid);
		arrValues.add(strusrid);
		if(rs != null){rs.close();}
		strQuery = SQLParser.getSqlQuery("sel_npcoappdet^"+strRefno);
		rs = DBUtils.executeQuery(strQuery);			
		if(rs.next())
		{
			arrValues.add("1");
		}
		else
		{
			arrValues.add("");
		}
		//UBI Functionality for Branch
		String StrForward="";
		strQuery = SQLParser.getSqlQuery("sel_orghead^"+Helper.correctNull((String)hshValues.get("strOrgCode")) );
		rs = DBUtils.executeQuery(strQuery);
		if (rs.next()) {
			StrForward = correctNull((String) rs.getString("org_head"));
		}
		if (rs != null) {
			rs.close();
		}
		String StrForwardorg = "";
		if (StrForward != null) 
		{
			strQuery = SQLParser.getSqlQuery("sel_orghead_User^"+StrForward);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				StrForwardorg = correctNull((String)rs.getString("USR_ORGCODE"));
			}		
		}
		arrValues.add(Helper.correctNull((String)hshValues.get("strOrgCode")));//changed
		if(Schemetype.equalsIgnoreCase("")){
		arrValues.add(getNPtoLAPSCommonLOV(Helper.correctNull((String)hshValues.get("SchemeName")),
				Helper.correctNull((String)hshValues.get("selsegment")),"PRODUCTCODE"));
		}else{
			arrValues.add(getNPtoLAPSCommonLOV1(Helper.correctNull((String)hshValues.get("SchemeName")),
					Helper.correctNull((String)hshValues.get("selsegment")),"PRODUCTCODE",Schemetype));
		}
		arrValues.add(strbranchcode);
		arrValues.add(strbranchcode);
		arrValues.add(String.valueOf(dblloanamnt));
		arrValues.add(Helper.correctNull((String)hshValues.get("strOrgbankFlag")));//changed			
		arrValues.add("Y");//constraint issue
		arrValues.add(String.valueOf(dblsubsidyamnt));
		if(Schemetype.equalsIgnoreCase("csis"))
		{
		   arrValues.add("t"); // scheme loan type. 31
		   arrValues.add("006");// bank scheme Name 32
		   arrValues.add("1");
	    }
		else
		{
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
		}
		MastApplicantBean CustPrfAppID = new MastApplicantBean();
		
		String strAppCode = CustPrfAppID.getApplicantCode();
		
		arrValues.add("");
		hshQuery.put("arrValues",arrValues);
		System.out.print("arrValues---------inward"+arrValues);
		hshQueryValues.put("1",hshQuery);
		hshQueryValues.put("size","1");	
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
		
		
		
		
		String StrOffadd="",strappcoappid="";			
		//Insertion for Employment Details
 		hshQuery = new HashMap();
		hshQueryValues = new HashMap();
		arrValues = new ArrayList();
		hshQuery.put("strQueryId","ins_npempdetails");	
		arrValues.add("0");
		
		if(Schemetype.equalsIgnoreCase("PMMY") || Schemetype.equalsIgnoreCase("STD"))
		{
			strQuery = SQLParser.getSqlQuery("sel_np_pmmyAppcheck^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{	
			arrValues.add(Helper.correctNull((String)rs.getString("MPDP_FIRST_NAME"))+" "
					+Helper.correctNull((String)rs.getString("MPDP_MIDDLE_NAME"))
					+" "+Helper.correctNull((String)rs.getString("MPDP_LAST_NAME")));
			arrValues.add(Helper.correctNull((String)rs.getString("MPDP_MOBILE")));
			arrValues.add(Helper.correctNull((String)rs.getString("MPDP_EMAIL")));
			arrValues.add("");
			arrValues.add("A");
			arrValues.add("");
			StrOffadd = Helper.correctNull((String)rs.getString("MPDP_CURR_ADD_SEQ_NO"));
			strappcoappid = Helper.correctNull((String)rs.getString("MPDP_APPLN_ID"));
	
			}else{
				strQuery = SQLParser.getSqlQuery("sel_nppersonaldetails^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_FIRST_NAME"))+" "
							+Helper.correctNull((String)rs.getString("NPPD_MIDDLE_NAME"))
							+" "+Helper.correctNull((String)rs.getString("NPPD_LAST_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MOBILE_NUMBER")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_EMAIL")));
					arrValues.add("");
					arrValues.add("A");
					arrValues.add("");
					StrOffadd = Helper.correctNull((String)rs.getString("NPPD_OFFICE_ADD_SEQ_NO"));
					strappcoappid = Helper.correctNull((String)rs.getString("NPPD_LAPSAPPID"));
				}
			}
		if(rs != null){rs.close();}
		}else if(Schemetype.equalsIgnoreCase("SWMS"))
		{
				strQuery = SQLParser.getSqlQuery("sel_np_SWMSAppcheck^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					arrValues.add(Helper.correctNull((String)rs.getString("NSPD_FIRST_NAME"))+" "
							+Helper.correctNull((String)rs.getString("NSPD_MIDDLE_NAME"))
							+" "+Helper.correctNull((String)rs.getString("NSPD_LAST_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NSPD_MOBILE")));
					arrValues.add(Helper.correctNull((String)rs.getString("NSPD_EMAIL")));
					arrValues.add("");
					arrValues.add("A");
					arrValues.add("");
					StrOffadd = Helper.correctNull((String)rs.getString("NSPD_OFFC_ADDR_REFID"));
					strappcoappid = Helper.correctNull((String)rs.getString("NSPD_APP_ID"));
					
					
				}else{
					strQuery = SQLParser.getSqlQuery("sel_nppersonaldetails^"+strRefno);
					rs = DBUtils.executeQuery(strQuery);			
					if(rs.next())
					{
						arrValues.add(Helper.correctNull((String)rs.getString("NPPD_FIRST_NAME"))+" "
								+Helper.correctNull((String)rs.getString("NPPD_MIDDLE_NAME"))
								+" "+Helper.correctNull((String)rs.getString("NPPD_LAST_NAME")));
						arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MOBILE_NUMBER")));
						arrValues.add(Helper.correctNull((String)rs.getString("NPPD_EMAIL")));
						arrValues.add("");
						arrValues.add("A");
						arrValues.add("");
						StrOffadd = Helper.correctNull((String)rs.getString("NPPD_OFFICE_ADD_SEQ_NO"));
						strappcoappid = Helper.correctNull((String)rs.getString("NPPD_LAPSAPPID"));
					}
				}
		}
		else if(Schemetype.equalsIgnoreCase("SRMS"))
		{
				strQuery = SQLParser.getSqlQuery("sel_np_SWMSAppcheck^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					arrValues.add(Helper.correctNull((String)rs.getString("NSPD_FIRST_NAME"))+" "
							+Helper.correctNull((String)rs.getString("NSPD_MIDDLE_NAME"))
							+" "+Helper.correctNull((String)rs.getString("NSPD_LAST_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NSPD_MOBILE")));
					arrValues.add(Helper.correctNull((String)rs.getString("NSPD_EMAIL")));
					arrValues.add("");
					arrValues.add("A");
					arrValues.add("");
					StrOffadd = Helper.correctNull((String)rs.getString("NSPD_OFFC_ADDR_REFID"));
					strappcoappid = Helper.correctNull((String)rs.getString("NSPD_APP_ID"));
					
					
				}else{
				strQuery = SQLParser.getSqlQuery("sel_nppersonaldetails^"+strRefno);
				rs = DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_FIRST_NAME"))+" "
							+Helper.correctNull((String)rs.getString("NPPD_MIDDLE_NAME"))
							+" "+Helper.correctNull((String)rs.getString("NPPD_LAST_NAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MOBILE_NUMBER")));
					arrValues.add(Helper.correctNull((String)rs.getString("NPPD_EMAIL")));
					arrValues.add("");
					arrValues.add("A");
					arrValues.add("");
					StrOffadd = Helper.correctNull((String)rs.getString("NPPD_OFFICE_ADD_SEQ_NO"));
					strappcoappid = Helper.correctNull((String)rs.getString("NPPD_LAPSAPPID"));
				}
				}
		}else{
			strQuery = SQLParser.getSqlQuery("sel_nppersonaldetails^"+strRefno);
			rs = DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_FIRST_NAME"))+" "
						+Helper.correctNull((String)rs.getString("NPPD_MIDDLE_NAME"))
						+" "+Helper.correctNull((String)rs.getString("NPPD_LAST_NAME")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_MOBILE_NUMBER")));
				arrValues.add(Helper.correctNull((String)rs.getString("NPPD_EMAIL")));
				arrValues.add("");
				arrValues.add("A");
				arrValues.add("");
				StrOffadd = Helper.correctNull((String)rs.getString("NPPD_OFFICE_ADD_SEQ_NO"));
				strappcoappid = Helper.correctNull((String)rs.getString("NPPD_LAPSAPPID"));
			}else{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}
		}
		
		arrValues.add("IN");
		arrValues.add(strInqno);
		arrValues.add("0");
		if(rs != null){rs.close();}
		if(!StrOffadd.equalsIgnoreCase("")){
		strQuery = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+StrOffadd);
		rs = DBUtils.executeQuery(strQuery);			
		if(rs.next())
		{
			arrValues.add(Helper.correctNull((String)rs.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs.getString("NPAD_LANDMARK")));
			arrValues.add(Helper.correctNull((String)rs.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME")));
			arrValues.add("");
			String city=Helper.correctNull((String)rs.getString("NPAD_CITY_NAME"));
			String state=Helper.correctNull((String)rs.getString("NPAD_STATE_NAME"));
			if(!state.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
				rs3 = DBUtils.executeQuery(strQuery);			
				if(rs3.next())
				{
					arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
				}else{
					arrValues.add("");
				}
				}else{
					arrValues.add("");
				}
			String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
			
			if(!city.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
				rs3 = DBUtils.executeQuery(strQuery);			
				if(rs3.next())
				{
					arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
				}else{
					arrValues.add("");
				}
				}else{
					arrValues.add("");
				}
			
			arrValues.add(Helper.correctNull((String)rs.getString("NPAD_PIN_CODE")));
		}	
		else
		{
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
		}
		}else{
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");	
		}
		arrValues.add(strappcoappid);
		System.out.println("emp1----------------------"+arrValues);
		
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);
		hshQueryValues.put("size","1");	
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
		
		
		
		
		String strsId="",strCur_Add="";
		strQuery = SQLParser.getSqlQuery("sel_npcoappdet^"+strRefno);
		rs = DBUtils.executeQuery(strQuery);			
		while(rs.next())
		{		
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","ins_npcoappdet");	
			arrValues.add(strInqno);
			arrValues.add(strbranchcode);
			arrValues.add(strusrid);
			rs1 = DBUtils.executeLAPSQuery("selmax_cibilcoapp^"+ strInqno);
			if (rs1.next()) {
				strsId = correctNull((String) rs1.getString("inward_appid"));
			} else {
				strsId = "1";
			}
			arrValues.add(strsId);
			arrValues.add(Helper.correctNull((String)hshValues.get("strOrgbankFlag")));//changed
			arrValues.add(strusrid);
			arrValues.add(Helper.correctNull((String)rs.getString("NPCD_FNAME"))+" "
							+Helper.correctNull((String)rs.getString("NPCD_MNAME"))
							+" "+Helper.correctNull((String)rs.getString("NPCD_LNAME")));
			arrValues.add(Helper.correctNull((String)rs.getString("NPCD_LNAME")));
			arrValues.add(Helper.correctNull((String)rs.getString("NPCD_MOBILE")));
			arrValues.add(Helper.correctNull((String)rs.getString("NPCD_EMAIL")));
			strCur_Add = Helper.correctNull((String)rs.getString("NPCD_AADHAR_ADD_SEQ"));
			
			if(rs1 != null){rs1.close();}
			if(!strCur_Add.equalsIgnoreCase("")){
			strquery1 = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+strCur_Add);
			rs1 = DBUtils.executeQuery(strquery1);			
			if(rs1.next())
			{
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs1.getString("NPAD_LANDMARK")));
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME")));
				String district=Helper.correctNull((String)rs.getString("NPAD_DISTRICT_NAME"));
				//District Code added by kannan
				if(!district.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_District_Name^"+district);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("DISTRICT_CODE")));
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				String city=Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME"));
				String state=Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME"));
				
				if(!state.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
					}else{
						arrValues.add("");
					}
					
					}else{
						arrValues.add("");
					}
				String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
				
				if(!city.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE")));
			}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}}else{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}
			arrValues.add(Helper.correctNull((String)rs.getString("NPCD_RELATION")));
			arrValues.add(getNPtoLAPSListOfValue("2",Helper.correctNull((String)rs.getString("NPCD_GENDER"))));
			arrValues.add(Helper.correctNull((String)rs.getString("NPCD_DOB")));			
			arrValues.add(getNPtoLAPSListOfValue("6",Helper.correctNull((String)rs.getString("NPCD_EMPLOY_TYPE"))));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
			
			
			//Insertion for Applicant Employment Details
			String stroffadd="";
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","ins_npempdetails");	
			arrValues.add("0");
			strquery1 = SQLParser.getSqlQuery("sel_npcoappdet^"+strRefno);
			rs1 = DBUtils.executeQuery(strquery1);			
			if(rs1.next())
			{
				arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_ORG_NAME")));
				arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_MOBILE")));
				arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_EMAIL")));
				arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_DESIGNATION")));
				arrValues.add("");
				arrValues.add(Helper.correctNull((String)rs1.getString("NPCD_RETIRE_AGE")));
				strappcoappid = Helper.correctNull((String)rs1.getString("NPCD_COAPP_ID"));
				stroffadd = Helper.correctNull((String)rs1.getString("NPCD_OFFICE_ADD_SEQ"));
				
			}
			arrValues.add("");
			arrValues.add(strInqno);
			arrValues.add(strsId);
			if(rs1 != null){rs1.close();}
			if(!stroffadd.equalsIgnoreCase("")){
			strquery1 = SQLParser.getSqlQuery("sel_npaddrdetails5^"+strRefno+"^"+stroffadd);
			rs1 = DBUtils.executeQuery(strquery1);			
			if(rs1.next())
			{
				
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_STREET_NAME"))+" "+Helper.correctNull((String)rs1.getString("NPAD_LANDMARK")));
				//arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_SUB_DISTRICT"))+" "+Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME")));
				String district=Helper.correctNull((String)rs1.getString("NPAD_DISTRICT_NAME"));
				//District Code added by kannan
				if(!district.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_District_Name^"+district);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("DISTRICT_CODE")));
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				arrValues.add("");
				String city=Helper.correctNull((String)rs1.getString("NPAD_CITY_NAME"));
				String state=Helper.correctNull((String)rs1.getString("NPAD_STATE_NAME"));
				if(!state.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_state_name^"+state);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("STATE_CODE")));
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				String stateid=Helper.correctNull((String)rs3.getString("STATE_ID"));
				if(!city.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("NP_city_name^"+city+"^"+stateid);
					rs3 = DBUtils.executeQuery(strQuery);			
					if(rs3.next())
					{
						arrValues.add(Helper.correctNull((String)rs3.getString("CITY_CODE")));	
					}else{
						arrValues.add("");
					}
					}else{
						arrValues.add("");
					}
				
				arrValues.add(Helper.correctNull((String)rs1.getString("NPAD_PIN_CODE")));
			}
			else
			{
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}}else{
				
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
			}
			arrValues.add(strappcoappid);
			System.out.println("emp12345----------------------"+arrValues);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
		}
		
		hshQuery = new HashMap();
		hshQueryValues = new HashMap();
		arrValues = new ArrayList();
		hshQuery.put("strQueryId","upd_nppdinwdetails");	
		arrValues.add(strInqno);	
		arrValues.add("P");
		arrValues.add(strRefno);			
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);
		hshQueryValues.put("size","1");	
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
		
		hshValues.put("InwardNo",strInqno);
		hshValues.put("REFERENCEID",strRefno);
		String app_id="0";
		Double grossincome=0.0,otherincome=0.0,incometax=0.0;
		strquery1 = SQLParser.getSqlQuery("sel_npFinancial1^"+strRefno);
		rs1 = DBUtils.executeQuery(strquery1);			
		if(rs1.next())
		{
			
			String grossincome1="0",net_monthly_income="0",salary_income="0";
			String house_property="0",other_source="0",capital_gain="0";
			 grossincome1=Helper.correctNull((String)rs1.getString("NPFD_GROSS_MONTHLY_INCOME"));
			 net_monthly_income=Helper.correctNull((String)rs1.getString("NPFD_NET_MONTHLY_INCOME"));
			 salary_income=Helper.correctNull((String)rs1.getString("NPFD_SALARY_INCOME"));
			
			 house_property=Helper.correctNull((String)rs1.getString("NPFD_HOUSE_PROPERTY"));
			 other_source=Helper.correctNull((String)rs1.getString("NPFD_OTHER_SOURCE"));
			 capital_gain=Helper.correctNull((String)rs1.getString("NPFD_CAPITAL_GAIN"));
			
			 app_id=Helper.correctNull((String)rs1.getString("NPFD_ID"));
			 String Taxincome=Helper.correctNull((String)rs1.getString("NPFD_TAXABLE_INCOME"));
			 
			 if(!Taxincome.equalsIgnoreCase("")){
				 incometax=Double.valueOf(Taxincome);
				 }
				 if(grossincome1.equalsIgnoreCase("")){
					 grossincome1="0";
				 }
					 if(net_monthly_income.equalsIgnoreCase("")){
						 net_monthly_income="0";
					 }
						 if(salary_income.equalsIgnoreCase("")){
							 salary_income="0";
						 }
				grossincome=Double.valueOf(grossincome1)+Double.valueOf(net_monthly_income)+Double.valueOf(salary_income);
										 
				
				 if(house_property.equalsIgnoreCase("")){
					 house_property="0";
				 }
					 if(other_source.equalsIgnoreCase("")){
						 other_source="0";
					 }
						 if(capital_gain.equalsIgnoreCase("")){
							 capital_gain="0";
						 }
				 otherincome=Double.valueOf(house_property)+Double.valueOf(other_source)+Double.valueOf(capital_gain);
						 
			 
		}
		
		hshQuery = new HashMap();
		hshQueryValues = new HashMap();
		arrValues = new ArrayList();
		hshQuery.put("strQueryId","ins_incomeexpene_np");
		arrValues.add(app_id);
		arrValues.add("0");	
		arrValues.add(strInqno);	
		arrValues.add(String.valueOf(grossincome));
		arrValues.add(String.valueOf(otherincome));
		arrValues.add(String.valueOf(incometax));
		System.out.println("income--------"+arrValues);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);
		hshQueryValues.put("size","1");	
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
		
		hsh = getNpMailbox(hshValues);
		
		
	}
	catch(Exception ex)
	{
		Logger.log("Exception in getNpapplications"+ex);
	}	
	return hsh;
}
public void updateNPReallocation(HashMap hshValues)
{
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = null;	 
	ArrayList arrValues =null;
	ResultSet rs=null;
	String strUserId = null,strRefId="",strAppID="";
	String strIfscCode="",strQuery="";
	try
	{	
		String strBranch_code=Helper.correctNull((String)hshValues.get("org_code"));
		
		if(rs!=null)
			rs.close();
		strQuery = SQLParser.getSqlQuery("sel_org_level^"+strBranch_code);
		rs =DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strIfscCode=Helper.correctNull((String)rs.getString("ORG_IFSCCODE"));
		}
		
		strRefId=correctNull((String)hshValues.get("hidRefIdnew"));
		String strRef[]=strRefId.split("@");
		int intsize=0;
		if(!Helper.correctNull(strIfscCode).equalsIgnoreCase(null))
		{
			if(strRef.length==1)
			{	
				++intsize;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","update_np_realloc");
				arrValues.add(Helper.correctNull(strIfscCode));
				arrValues.add(strRef[0]);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(intsize),hshQuery);
				hshQueryValues.put("size",String.valueOf(intsize));
				
			}
			else
			{
				for(int i=0;i<strRef.length;i++)
				{
					++intsize;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","update_np_realloc");
					arrValues.add(Helper.correctNull(strIfscCode));
					arrValues.add(strRef[i]);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
					hshQueryValues.put("size",String.valueOf(intsize));
				}
			}
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updatedata");
		}
	}
	catch (Exception ce)
	{
		Logger.log(ce);
		throw new EJBException(ce.toString());
	}
}
}