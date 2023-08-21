package com.sai.laps.ejb.corpupload;

import com.sai.laps.helper.*;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.SQLParser;


@Stateless(name = "corpuploadBean", mappedName = "corpuploadHome")
@Remote (corpuploadRemote.class)
public class corpuploadBean extends BeanAdapter
{

    /**
	 * 
	 */
	public static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(corpuploadBean.class);
		
	public HashMap getAppno(HashMap hashmap) 
    {
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		
		ResultSet resultset = null;
        HashMap hashmap1 = new HashMap();
        
        String strorgcode="";
        String strQuery="";
        String strOrgscode="";
        String strFilelocation="";
        String strFilename="";
        String strAppid="";
        String strAppno="";
        String strCusttype="";
        String check_String = ""; 
        String strAppname="";
        String strOrglevel="";
        String strissaral="";
        String strInwardno="";
        String strApplicationRecd="";
        String strExp="$";
        String str_ApplicationRecd="";
        String strIsSaral="";
        String strOrgShortCode="";
        ResultSet resultset1=null;
        ResultSet resultset2=null;
        String strValuesin="";
        
        
        HashMap hshQuery=new HashMap();
        HashMap hshQueryValues=new HashMap();
        
        ArrayList arrValues=new ArrayList();
        Connection connection1 =  null;
        Statement statement1 = null;
        Statement statement2 = null;
        ResultSet rs=null;
        
        
        int intUpdateSize=0;
        try
        {
            strorgcode=correctNull((String)hashmap.get("strOrgCode"));
            strCusttype=correctNull((String)hashmap.get("custtype"));
            strInwardno=correctNull((String)hashmap.get("inwardno"));
            strFilelocation=correctNull((String)hashmap.get("MDB_FILE_PATH"));
            strFilename=correctNull((String)hashmap.get("MDB_FILE_NAME"));
            strOrglevel=correctNull((String)hashmap.get("strOrgLevel"));
            strissaral=correctNull((String)hashmap.get("strIsSaral"));
            str_ApplicationRecd=correctNull((String)hashmap.get("comapp_scode"));
            strOrgShortCode=correctNull((String)hashmap.get("strOrgShortCode"));
            strQuery=SQLParser.getSqlQuery("selorgsortcode^'" + strorgcode+"'");
            resultset = DBUtils.executeQuery(strQuery);
            HashMap tempMap = new HashMap();
            
            if(resultset.next())
            	strOrgscode = correctNull(resultset.getString("org_scode"));
            
            
            
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
             connection1 = DriverManager.getConnection("jdbc:odbc:Driver={MicroSoft Access Driver (*.mdb)};DBQ="+strFilelocation+"\\"+strFilename, "", "");
             statement1 = connection1.createStatement();
         
            strQuery=SQLParser.getSqlQuery("sel_comapplicant_offline");
            resultset1 = statement1.executeQuery(strQuery);
           
            int intsno=0;
            if(strCusttype.equalsIgnoreCase("New"))
            {
            	           	
            	if(resultset1.next())
            	{
            		hshQuery=new HashMap();
            		hshQuery.put("strQueryId", "comappmasterins");
            		arrValues=new ArrayList();
            		intUpdateSize++;
            		
            		strAppname=correctNull(resultset1.getString("compName"));
            		strApplicationRecd=correctNull(resultset1.getString("Location"));
            		if(rs != null)
            			rs.close();
            		strQuery=SQLParser.getSqlQuery("selcomapplicant^"+strAppname+"^"+strApplicationRecd);
                          		rs = DBUtils.executeQuery(strQuery);
            		if(!rs.next())
            		{
            			if(((str_ApplicationRecd.equals("")&& strApplicationRecd.equals(strOrgShortCode)))||((strissaral.equals("Y")&& str_ApplicationRecd.equals(strApplicationRecd))))
            			{
            				
            			
                	/*if(resultset!=null)
                		resultset.close();
                	
                	resultset=DBUtils.executeQuery("^"+strAppname);
                	
                	if(resultset.next())
                	{
                		throw new EJBException("The Customer Already created in LAPS");
                	}*/
            		strAppid=getApplicantCode();
            		
            		arrValues.add(strAppid);//comapp_id
            		arrValues.add(strAppname);
            		arrValues.add(correctNull(resultset1.getString("IndBSRCode_activity")));
            		arrValues.add(correctNull(resultset1.getString("CAdd1")));
            		arrValues.add(correctNull(resultset1.getString("CAdd2")));
            		arrValues.add(correctNull(resultset1.getString("CCity")));
            		arrValues.add(correctNull(resultset1.getString("CState")));
            		arrValues.add(correctNull(resultset1.getString("CPin")));
            		arrValues.add(correctNull(resultset1.getString("CPhno")));
            		arrValues.add(correctNull(resultset1.getString("CFaxNo")));
            		arrValues.add(correctNull(resultset1.getString("NatOfActivity")));
            		arrValues.add(correctNull(resultset1.getString("Panno")).toUpperCase());
            		arrValues.add(correctNull(resultset1.getString("ROCNo")));
            		String DateYear=correctNull(resultset1.getString("InCorpDate"));
            		if(!DateYear.equals("__/__/____"))
	        		{	
	        			arrValues.add(DateYear);
	        		}
	        		else
	        		{
	        			arrValues.add("");
	        		}
            		arrValues.add(correctNull(resultset1.getString("OwnType")));
            		arrValues.add(correctNull(resultset1.getString("totEmp")));
            		arrValues.add(correctNull(resultset1.getString("ContName")));
            		arrValues.add(correctNull(resultset1.getString("email")));
            		
            		arrValues.add(correctNull(resultset1.getString("grp")));
            		arrValues.add(correctNull(resultset1.getString("CPremises")));
            		arrValues.add(correctNull(resultset1.getString("RPremises")));
            		arrValues.add(correctNull(resultset1.getString("RAdd1")));
            		arrValues.add(correctNull(resultset1.getString("RAdd2")));
            		arrValues.add(correctNull(resultset1.getString("RCity")));
            		arrValues.add(correctNull(resultset1.getString("RState")));
            		arrValues.add(correctNull(resultset1.getString("RPhno")));
            		arrValues.add(correctNull(resultset1.getString("RFaxNo")));
            		arrValues.add(correctNull(resultset1.getString("RPin")));
            		arrValues.add(correctNull(resultset1.getString("comapp_indcode")));
            		arrValues.add(correctNull(resultset1.getString("DealingSince")));
            		arrValues.add("");
            		arrValues.add(correctNull(resultset1.getString("corpType")));//comapp_comtype
            		arrValues.add(correctNull(resultset1.getString("SMEType")));//comapp_ssitype
            		arrValues.add(strApplicationRecd);//comapp_org_scode
            		arrValues.add(hashmap.get("strOrgSelect"));//comapp_org_code
            		arrValues.add(correctNull(resultset1.getString("IndType")));//scale
            		arrValues.add(correctNull(resultset1.getString("FAdd1")));//comapp_admadd1
            		arrValues.add(correctNull(resultset1.getString("FAdd2")));//comapp_admadd2
            		arrValues.add(correctNull(resultset1.getString("FCity")));//comapp_admcity
            		arrValues.add(correctNull(resultset1.getString("FState")));//comapp_admstate
            		arrValues.add(correctNull(resultset1.getString("FPhno")));//comapp_admphone
            		arrValues.add(correctNull(resultset1.getString("FFaxno")));//comapp_admfax
            		arrValues.add(correctNull(resultset1.getString("FPin")));//comapp_admpin
            		arrValues.add(correctNull(resultset1.getString("rbino")));//comapp_rbino
            		arrValues.add(correctNull(resultset1.getString("nbfcSubCategory")));//comapp_subnbfc
            		arrValues.add(correctNull(resultset1.getString("Authorised_Capital")));//auth_captial
            		arrValues.add("");//CBS_COMPANYCODE
            		arrValues.add(correctNull(resultset1.getString("cbs_status")));//company_status
            		arrValues.add(correctNull(resultset1.getString("cbs_trade_finance")));//company_staff
            		arrValues.add(correctNull(resultset1.getString("cbs_inland_trade")));//company_inland
            		arrValues.add(correctNull(resultset1.getString("cbs_introducer_title")));//company_introtitle
            		arrValues.add(correctNull(resultset1.getString("cbs_introducer_name")));//company_introname
            		arrValues.add(correctNull(resultset1.getString("RCountryCode")));//comapp_regcountry
            		arrValues.add(correctNull(resultset1.getString("Subscribed_Capital")));//comapp_subcapital
            		arrValues.add(correctNull(resultset1.getString("totalshare")));//comapp_totalshares
            		arrValues.add(strAppid);
              		String strPublicType=correctNull(resultset1.getString("publictype"));
            		if(strPublicType.trim().equals("Closely Held"))
            			strPublicType="C";
            		else if(strPublicType.trim().equals("Widely Held"))
            			strPublicType="W";
            		else
            			strPublicType="S";
            		arrValues.add(strPublicType);
            		arrValues.add(correctNull(resultset1.getString("IECcode")));//COMAPP_IECCODE
            		arrValues.add("");
            		arrValues.add("");
               		hshQuery.put("arrValues",arrValues);
            		hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
            		
            		
             /**For insert into applicant_kycnorms table from the MS Access DB*/		
	            	 if(resultset1!=null)
	                    	resultset1.close();
	                    strQuery=SQLParser.getSqlQuery("sel_KYCNorms_offline");
	                    resultset1 = statement1.executeQuery(strQuery);
	                    if(resultset1.next())
	                	{
	                		hshQuery=new HashMap();
	                		hshQuery.put("strQueryId", "ins_applKYCNorms");
	                		arrValues=new ArrayList();
	                		intUpdateSize++;
	                		arrValues.add(strAppid);
	                		String custType=correctNull(resultset1.getString("CorporateCustomer"));
	                		if(custType.trim().equals("Yes"))
	                			custType="Y";
	                		else if(custType.trim().equals("No"))
	                			custType="N";
	                		arrValues.add(custType);
	                		arrValues.add(correctNull(resultset1.getString("Occupation")));
	                		arrValues.add(correctNull(resultset1.getString("AnnualIncome_Code")));
	                		arrValues.add(correctNull(resultset1.getString("CountryResidence_code")));
	                		arrValues.add(correctNull(resultset1.getString("Form60")));
	                		arrValues.add(correctNull(resultset1.getString("RefNo")));
	                		arrValues.add(correctNull(resultset1.getString("IDProofType_code")));
	                		arrValues.add(correctNull(resultset1.getString("IDReference")));
	                		arrValues.add(correctNull(resultset1.getString("ResidenceProofType_code")));
	                		arrValues.add(correctNull(resultset1.getString("ResidenceIDReference")));
	                	    arrValues.add(correctNull(resultset1.getString("SourceIncome_code")));
	                		arrValues.add(correctNull(resultset1.getString("Networth_code")));
	                		arrValues.add(correctNull(resultset1.getString("AnnualTurnOver_code")));
	                		arrValues.add(correctNull(resultset1.getString("AnnualTurnOverEstimated_code")));
	                		String strAccType=correctNull(resultset1.getString("PooledAccount"));
	                		if(strAccType.trim().equals("Yes"))
	                			strAccType="Y";
	                		else if(strAccType.trim().equals("No"))
	                			strAccType="N";
	                		arrValues.add(strAccType);
	                		arrValues.add(correctNull(resultset1.getString("NatureActivity_code")).trim());
	                		String strofac=correctNull(resultset1.getString("OFAC_UNSCAN"));
	                		if(strofac.trim().equals("Yes"))
	                			strofac="Y";
	                		else if(strofac.trim().equals("No"))
	                			strofac="N";
	                		arrValues.add(strofac);
	                		String strForeign=correctNull(resultset1.getString("ForeignInward"));
	                		if(strForeign.trim().equals("Yes"))
	                			strForeign="Y";
	                		else if(strForeign.trim().equals("No"))
	                			strForeign="N";
	                		arrValues.add(strForeign);
	                		arrValues.add(correctNull(resultset1.getString("RemitCountry_code")));
	                		arrValues.add(correctNull(resultset1.getString("Client1Name")));
	                		arrValues.add(correctNull(resultset1.getString("Client1Address")));
	                		arrValues.add(correctNull(resultset1.getString("Client1CityCode")));
	                		arrValues.add("");
	                		arrValues.add(correctNull(resultset1.getString("Client1CountryCode")));
	                		arrValues.add(correctNull(resultset1.getString("Client2Name")));
	                		arrValues.add(correctNull(resultset1.getString("Client2Address")));
	                		arrValues.add(correctNull(resultset1.getString("Client2CityCode")));
	                		arrValues.add("");
	                		arrValues.add(correctNull(resultset1.getString("Client2CountryCode")));
	                		arrValues.add(correctNull(resultset1.getString("Client3Name")));
	                		arrValues.add(correctNull(resultset1.getString("Client3Address")));
	                		arrValues.add(correctNull(resultset1.getString("Client3CityCode")));
	                		arrValues.add("");
	                		arrValues.add(correctNull(resultset1.getString("Client3CountryCode")));
	                		arrValues.add(correctNull(resultset1.getString("RiskCategorization_code")));
	                		arrValues.add(correctNull(resultset1.getString("CustomerOccupation_code")));
	                		
	                		String strSleepPartner=correctNull(resultset1.getString("SleepingPartners"));
	                		if(strSleepPartner.trim().equalsIgnoreCase("Yes"))
	                			strSleepPartner="Y";
	                		else if(strSleepPartner.trim().equalsIgnoreCase("No"))
	                			strSleepPartner="N";
	                		
	                		String strPolitical=correctNull(resultset1.getString("PoliticalExposed"));
	                		if(strPolitical.trim().equalsIgnoreCase("Yes"))
	                			strPolitical="Y";
	                		else if(strPolitical.trim().equalsIgnoreCase("No"))
	                			strPolitical="N";
	                		
	                		String strFamilyShare=correctNull(resultset1.getString("FamilyShare"));
	                		if(strFamilyShare.trim().equalsIgnoreCase("Yes"))
	                			strFamilyShare="Y";
	                		else if(strFamilyShare.trim().equalsIgnoreCase("No"))
	                			strFamilyShare="N";
	                		
	                   		arrValues.add(strSleepPartner);
	                		arrValues.add(strPolitical);
	                		arrValues.add(strFamilyShare);
	                  		hshQuery.put("arrValues",arrValues);
	                  		hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
	                		
	                	}
	                    
            	/**End*/	
            	
            	/*****************************************
            	 * 										 *
            	 * For Insert into table Factory Details *
            	 * table from the MS Access DB           *
            	 *  									 *
            	 ******************************************/
            	if(resultset1!=null)
                	resultset1.close();
                strQuery=SQLParser.getSqlQuery("sel_branches_offline");
                resultset1 = statement1.executeQuery(strQuery);
                intsno=0;
                while(resultset1.next())
                {
                	hshQuery=new HashMap();
            		hshQuery.put("strQueryId", "insfactorydetails");
            		arrValues=new ArrayList();
            		intUpdateSize++;
            		intsno++;
            		//Comappfactorydetails
            		
            		arrValues.add(strAppid);//COMAPP_ID
            		arrValues.add(Integer.toString(intsno));//COMAPP_SNO
            		arrValues.add(correctNull(resultset1.getString("branch_type")));//COMAPP_DETAILTYPE
            		arrValues.add(correctNull(resultset1.getString("Name_of_Factory")));//COMAPP_NAME
            		arrValues.add(correctNull(resultset1.getString("Address1")));//COMAPP_ADD
            		arrValues.add(correctNull(resultset1.getString("City")));//COMAPP_CITY
            		arrValues.add(correctNull(resultset1.getString("State")));//COMAPP_STATE
            		arrValues.add(correctNull(resultset1.getString("Pincode")));//COMAPP_PINCODE
            		arrValues.add(correctNull(resultset1.getString("Phone")));//COMAPP_PHONENO
            		arrValues.add(correctNull(resultset1.getString("Fax")));//COMAPP_FAX
            		arrValues.add(correctNull(resultset1.getString("premises")));//COMAPP_FACTPREMISES
            		hshQuery.put("arrValues",arrValues);
            		hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
                }
                
                if(resultset1!=null)
                	resultset1.close();
                strQuery=SQLParser.getSqlQuery("sel_division_offline");
                resultset1 = statement1.executeQuery(strQuery);
                intsno=0;
                while(resultset1.next())
                {
                	String tempName="";
                	hshQuery=new HashMap();
            		hshQuery.put("strQueryId", "insdivisiondetails");
            		arrValues=new ArrayList();
            		intsno++;
            		intUpdateSize++;
            		
            		tempName = correctNull(resultset1.getString("Division_Name")).toUpperCase();
            		tempMap.put(tempName,Integer.toString(intsno));
            		
                	//comapp_company_divisions
            		arrValues.add(Integer.toString(intsno));//COMAPP_DIV_ID
            		arrValues.add(strAppid);//COMAPP_ID
            		arrValues.add(tempName);//COMAPP_DIV_NAME
            		arrValues.add(correctNull(resultset1.getString("Address1")));//COMAPP_DIV_ADDRESS
            		arrValues.add(correctNull(resultset1.getString("City")));//COMAPP_DIV_CITY
            		arrValues.add(correctNull(resultset1.getString("State")));//COMAPP_DIV_STATE
            		arrValues.add(correctNull(resultset1.getString("Pincode")));//COMAPP_DIV_PIN
            		arrValues.add(correctNull(resultset1.getString("Phone")));//COMAPP_DIV_PHONE
            		arrValues.add(correctNull(resultset1.getString("fax")));//COMAPP_DIV_FAX
            		arrValues.add(correctNull(resultset1.getString("Division_type")));//COMAPP_DIVISIONTYPE
               		arrValues.add(correctNull(resultset1.getString("bsrCode")));//COMAPP_DIV_BSRCODE
               		hshQuery.put("arrValues",arrValues);
            		hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
                }
                
                if(resultset1!=null)
                	resultset1.close();
                strQuery=SQLParser.getSqlQuery("sel_relationship_offline");
                resultset1 = statement1.executeQuery(strQuery);
                
                intsno=0;
                while(resultset1.next())
                {
                	hshQuery=new HashMap();
            		hshQuery.put("strQueryId", "insreldetails");
            		arrValues=new ArrayList();
            		intsno++;
            		intUpdateSize++;
            		//com_apprelationship
            		arrValues.add(strAppid);//COMAPP_ID
            		arrValues.add(correctNull(resultset1.getString("Employee_No")));//COMAPP_EMPRELNO
            		arrValues.add(correctNull(resultset1.getString("Relationship_to_Borrower")));//COMAPP_BORREL
            		arrValues.add(correctNull(resultset1.getString("Scale_Grade")));//COMAPP_SCALE
            		arrValues.add(correctNull(resultset1.getString("Place_posting")));//COMAPP_PLACEPOST
            		arrValues.add(correctNull(resultset1.getString("loan_Staff")));//COMAPP_LOANCOMMENTS
            		arrValues.add(Integer.toString(intsno));//COMAPP_RELSNO
            		
            		hshQuery.put("arrValues",arrValues);
            		hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
            		
                }
            		}
            		else
            		{
            			strExp =strExp + "Organisation code is different from uploaded branch";
        				throw new Exception(strExp);
            		}
            	}
        		else
        		{
        			strExp =strExp + "Applicant "+strAppname+" is already existing";
    				throw new Exception(strExp);
        		}
            }
            	if(rs != null)
        			rs.close();
            }
            else
            {
            	if(resultset1.next())
            	{
            		intUpdateSize++;
            		hshQuery=new HashMap();
            		hshQuery.put("strQueryId", "comappmasterupd");
            		arrValues=new ArrayList();
            		
            		arrValues.add(correctNull(resultset1.getString("compName")));
            		arrValues.add(correctNull(resultset1.getString("IndBSRCode_activity")));
            		arrValues.add(correctNull(resultset1.getString("CAdd1")));
            		arrValues.add(correctNull(resultset1.getString("CAdd2")));
            		arrValues.add(correctNull(resultset1.getString("CCity")));
            		arrValues.add(correctNull(resultset1.getString("CState")));
            		arrValues.add(correctNull(resultset1.getString("CPin")));
            		arrValues.add(correctNull(resultset1.getString("CPhno")));
            		arrValues.add(correctNull(resultset1.getString("CFaxNo")));
            		arrValues.add(correctNull(resultset1.getString("NatOfActivity")));
            		arrValues.add(correctNull(resultset1.getString("Panno")).toUpperCase());
            		arrValues.add(correctNull(resultset1.getString("ROCNo")));
            		String DateYear=correctNull(resultset1.getString("InCorpDate"));
            		if(!DateYear.equals("__/__/____"))
	        		{	
	        			arrValues.add(DateYear);
	        		}
	        		else
	        		{
	        			arrValues.add("");
	        		}
            		arrValues.add(correctNull(resultset1.getString("OwnType")));
            		arrValues.add(correctNull(resultset1.getString("totEmp")));
            		arrValues.add(correctNull(resultset1.getString("ContName")));
            		arrValues.add(correctNull(resultset1.getString("email")));
            		arrValues.add(correctNull(resultset1.getString("grp")));
            		arrValues.add(correctNull(resultset1.getString("CPremises")));
            		arrValues.add(correctNull(resultset1.getString("RPremises")));
            		arrValues.add(correctNull(resultset1.getString("RAdd1")));
            		arrValues.add(correctNull(resultset1.getString("RAdd2")));
            		arrValues.add(correctNull(resultset1.getString("RCity")));
            		arrValues.add(correctNull(resultset1.getString("RState")));
            		arrValues.add(correctNull(resultset1.getString("RPhno")));
            		arrValues.add(correctNull(resultset1.getString("RFaxNo")));
            		arrValues.add(correctNull(resultset1.getString("RPin")));
            		arrValues.add(correctNull(resultset1.getString("DealingSince")));
            		arrValues.add(correctNull(resultset1.getString("IndBSRCode")));
            		arrValues.add("");
            		arrValues.add(correctNull(resultset1.getString("IndType")));//scale
            		arrValues.add(correctNull(resultset1.getString("FAdd1")));//comapp_admadd1
            		arrValues.add(correctNull(resultset1.getString("FAdd2")));//comapp_admadd2
            		arrValues.add(correctNull(resultset1.getString("FCity")));//comapp_admcity
            		arrValues.add(correctNull(resultset1.getString("FState")));//comapp_admstate
            		arrValues.add(correctNull(resultset1.getString("FPhno")));//comapp_admphone
            		arrValues.add(correctNull(resultset1.getString("FFaxno")));//comapp_admfax
            		arrValues.add(correctNull(resultset1.getString("FPin")));//comapp_admpin
            		arrValues.add(correctNull(resultset1.getString("corpType")));//comapp_comtype
            		arrValues.add(correctNull(resultset1.getString("SMEType")));//comapp_ssitype
            		arrValues.add(correctNull(resultset1.getString("Location")));//comapp_org_scode
            		arrValues.add(hashmap.get("strOrgSelect"));//comapp_org_code
            		arrValues.add(correctNull(resultset1.getString("rbino")));//comapp_rbino
            		arrValues.add(correctNull(resultset1.getString("nbfcSubCategory")));//comapp_subnbfc
            		arrValues.add(correctNull(resultset1.getString("Authorised_Capital")));//auth_captial
            		arrValues.add("");//CBS_COMPANYCODE
            		arrValues.add(correctNull(resultset1.getString("cbs_status")));//company_status
            		arrValues.add(correctNull(resultset1.getString("cbs_trade_finance")));//company_staff
            		arrValues.add(correctNull(resultset1.getString("cbs_inland_trade")));//company_inland
            		arrValues.add(correctNull(resultset1.getString("cbs_introducer_title")));//company_introtitle
            		arrValues.add(correctNull(resultset1.getString("cbs_introducer_name")));//company_introname
            		arrValues.add(correctNull(resultset1.getString("RCountryCode")));//comapp_regcountry
            		arrValues.add(correctNull(resultset1.getString("Subscribed_Capital")));//comapp_subcapital
            		arrValues.add(correctNull(resultset1.getString("totalshare")));//comapp_totalshares
            		String strPublicType=correctNull(resultset1.getString("publictype"));
            		if(strPublicType.trim().equals("Closely Held"))
            			strPublicType="C";
            		else if(strPublicType.trim().equals("Widely Held"))
            			strPublicType="W";
            		else
            			strPublicType="S";
            		arrValues.add(strPublicType);
            		arrValues.add(correctNull(resultset1.getString("IECcode")));
            		arrValues.add("");
            		arrValues.add("");
               		arrValues.add(strCusttype.trim());//comapp_id
               		strAppid=strCusttype.trim();
               		hshQuery.put("arrValues",arrValues);
             		hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
            	}
            	
            	/*****************************************
            	 * 										 *
            	 * For Insert into table Factory Details *
            	 * table from the MS Access DB           *
            	 *  									 *
            	 ******************************************/
            	
            	intUpdateSize++;
                hshQuery=new HashMap();
         		hshQuery.put("strQueryId", "delfactorydetails_access");
         		arrValues=new ArrayList();
         		arrValues.add(strAppid);//COMAPP_ID
         		hshQuery.put("arrValues",arrValues);
         		hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
            	
            	if(resultset1!=null)
                	resultset1.close();
                strQuery=SQLParser.getSqlQuery("sel_branches_offline");
                resultset1 = statement1.executeQuery(strQuery);
                intsno=0;
                while(resultset1.next())
                {
                	intUpdateSize++;
            		intsno++;
            		
                	hshQuery=new HashMap();
            		hshQuery.put("strQueryId", "insfactorydetails");
            		arrValues=new ArrayList();
            		
            		//Comappfactorydetails
            		arrValues.add(strAppid);//COMAPP_ID
            		arrValues.add(Integer.toString(intsno));//COMAPP_SNO
            		arrValues.add(correctNull(resultset1.getString("branch_type")));//COMAPP_DETAILTYPE
            		arrValues.add(correctNull(resultset1.getString("Name_of_Factory")));//COMAPP_NAME
            		arrValues.add(correctNull(resultset1.getString("Address1")));//COMAPP_ADD
            		arrValues.add(correctNull(resultset1.getString("City")));//COMAPP_CITY
            		arrValues.add(correctNull(resultset1.getString("State")));//COMAPP_STATE
            		arrValues.add(correctNull(resultset1.getString("Pincode")));//COMAPP_PINCODE
            		arrValues.add(correctNull(resultset1.getString("Phone")));//COMAPP_PHONENO
            		arrValues.add(correctNull(resultset1.getString("Fax")));//COMAPP_FAX
            		arrValues.add(correctNull(resultset1.getString("premises")));//COMAPP_FACTPREMISES
            		hshQuery.put("arrValues",arrValues);
            		hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
                }
                /**Update KYC Norms*/
                intUpdateSize++;
                hshQuery=new HashMap();
         		hshQuery.put("strQueryId", "del_applKYCNorms");
         		arrValues=new ArrayList();
         		arrValues.add(strAppid);//COMAPP_ID
         		hshQuery.put("arrValues",arrValues);
         		hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
         		
           	 if(resultset1!=null)
             	resultset1.close();
             strQuery=SQLParser.getSqlQuery("sel_KYCNorms_offline");
             resultset1 = statement1.executeQuery(strQuery);
             if(resultset1.next())
         	 {
         		hshQuery=new HashMap();
         		hshQuery.put("strQueryId", "ins_applKYCNorms");
         		arrValues=new ArrayList();
         		intUpdateSize++;
         		arrValues.add(strAppid);
         		String custType=correctNull(resultset1.getString("CorporateCustomer"));
         		if(custType.trim().equals("Yes"))
         			custType="Y";
         		else if(custType.trim().equals("No"))
         			custType="N";
         		arrValues.add(custType);
         		arrValues.add(correctNull(resultset1.getString("Occupation")));
         		arrValues.add(correctNull(resultset1.getString("AnnualIncome_Code")));
         		arrValues.add(correctNull(resultset1.getString("CountryResidence_code")));
         		arrValues.add(correctNull(resultset1.getString("Form60")));
         		arrValues.add(correctNull(resultset1.getString("RefNo")));
         		arrValues.add(correctNull(resultset1.getString("IDProofType_code")));
         		arrValues.add(correctNull(resultset1.getString("IDReference")));
         		arrValues.add(correctNull(resultset1.getString("ResidenceProofType_code")));
         		arrValues.add(correctNull(resultset1.getString("ResidenceIDReference")));
         	    arrValues.add(correctNull(resultset1.getString("SourceIncome_code")));
         		arrValues.add(correctNull(resultset1.getString("Networth_code")));
         		arrValues.add(correctNull(resultset1.getString("AnnualTurnOver_code")));
         		arrValues.add(correctNull(resultset1.getString("AnnualTurnOverEstimated_code")));
         		String strAccType=correctNull(resultset1.getString("PooledAccount"));
         		if(strAccType.trim().equals("Yes"))
         			strAccType="Y";
         		else if(strAccType.trim().equals("No"))
         			strAccType="N";
         		arrValues.add(strAccType);
         		arrValues.add(correctNull(resultset1.getString("NatureActivity_code")).trim());
         		String strofac=correctNull(resultset1.getString("OFAC_UNSCAN"));
         		if(strofac.trim().equals("Yes"))
         			strofac="Y";
         		else if(strofac.trim().equals("No"))
         			strofac="N";
         		arrValues.add(strofac);
         		String strForeign=correctNull(resultset1.getString("ForeignInward"));
         		if(strForeign.trim().equals("Yes"))
         			strForeign="Y";
         		else if(strForeign.trim().equals("No"))
         			strForeign="N";
         		arrValues.add(strForeign);
         		arrValues.add(correctNull(resultset1.getString("RemitCountry_code")));
         		arrValues.add(correctNull(resultset1.getString("Client1Name")));
         		arrValues.add(correctNull(resultset1.getString("Client1Address")));
         		arrValues.add(correctNull(resultset1.getString("Client1CityCode")));
         		arrValues.add("");
         		arrValues.add(correctNull(resultset1.getString("Client1CountryCode")));
         		arrValues.add(correctNull(resultset1.getString("Client2Name")));
         		arrValues.add(correctNull(resultset1.getString("Client2Address")));
         		arrValues.add(correctNull(resultset1.getString("Client2CityCode")));
         		arrValues.add("");
         		arrValues.add(correctNull(resultset1.getString("Client2CountryCode")));
         		arrValues.add(correctNull(resultset1.getString("Client3Name")));
         		arrValues.add(correctNull(resultset1.getString("Client3Address")));
         		arrValues.add(correctNull(resultset1.getString("Client3CityCode")));
         		arrValues.add("");
         		arrValues.add(correctNull(resultset1.getString("Client3CountryCode")));
         		arrValues.add(correctNull(resultset1.getString("RiskCategorization_code")));
         		arrValues.add(correctNull(resultset1.getString("CustomerOccupation_code")));
        		String strSleepPartner=correctNull(resultset1.getString("SleepingPartners"));
        		if(strSleepPartner.trim().equalsIgnoreCase("Yes"))
        			strSleepPartner="Y";
        		else if(strSleepPartner.trim().equalsIgnoreCase("No"))
        			strSleepPartner="N";
        		
        		String strPolitical=correctNull(resultset1.getString("PoliticalExposed"));
        		if(strPolitical.trim().equalsIgnoreCase("Yes"))
        			strPolitical="Y";
        		else if(strPolitical.trim().equalsIgnoreCase("No"))
        			strPolitical="N";
        		
        		String strFamilyShare=correctNull(resultset1.getString("FamilyShare"));
        		if(strFamilyShare.trim().equalsIgnoreCase("Yes"))
        			strFamilyShare="Y";
        		else if(strFamilyShare.trim().equalsIgnoreCase("No"))
        			strFamilyShare="N";
        		
           		arrValues.add(strSleepPartner);
        		arrValues.add(strPolitical);
        		arrValues.add(strFamilyShare);
           		hshQuery.put("arrValues",arrValues);
           		hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
         		
         	}
         		
                /**End of KYC Norms update*/
                
                intUpdateSize++;
                hshQuery=new HashMap();
         		hshQuery.put("strQueryId", "deldivisiondetails_access");
         		arrValues=new ArrayList();
         		arrValues.add(strAppid);//COMAPP_ID
         		hshQuery.put("arrValues",arrValues);
         		hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
                
         		
         		String tempString = "",tempName="";
                if(resultset1!=null)
                	resultset1.close();
                strQuery=SQLParser.getSqlQuery("sel_division_offline");
                resultset1 = statement1.executeQuery(strQuery);
                intsno=0;
                while(resultset1.next())
                {
               
                	hshQuery=new HashMap();
            		hshQuery.put("strQueryId", "insdivisiondetails");
            		arrValues=new ArrayList();
            		
            		
            		
            		
            		intsno++;
            		intUpdateSize++;
            		tempName = correctNull(resultset1.getString("Division_Name")).toUpperCase();
            		tempString = correctNull(resultset1.getString("slno"));
            		tempMap.put(tempName,tempString);
                	//comapp_company_divisions
            		arrValues.add(tempString);//COMAPP_DIV_ID
            		arrValues.add(strAppid);//COMAPP_ID
            		arrValues.add(tempName);//COMAPP_DIV_NAME
            		arrValues.add(correctNull(resultset1.getString("Address1")));//COMAPP_DIV_ADDRESS
            		arrValues.add(correctNull(resultset1.getString("City")));//COMAPP_DIV_CITY
            		arrValues.add(correctNull(resultset1.getString("State")));//COMAPP_DIV_STATE
            		arrValues.add(correctNull(resultset1.getString("Pincode")));//COMAPP_DIV_PIN
            		arrValues.add(correctNull(resultset1.getString("Phone")));//COMAPP_DIV_PHONE
            		arrValues.add(correctNull(resultset1.getString("fax")));//COMAPP_DIV_FAX
            		arrValues.add(correctNull(resultset1.getString("Division_type")));//COMAPP_DIVISIONTYPE
            		arrValues.add(correctNull(resultset1.getString("bsrCode")));//COMAPP_DIV_BSRCODE
            		
            		hshQuery.put("arrValues",arrValues);
            		hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
                }
                
                intUpdateSize++;
                hshQuery=new HashMap();
         		hshQuery.put("strQueryId", "delreldetails_access");
         		arrValues=new ArrayList();
         		arrValues.add(strAppid);//COMAPP_ID
         		hshQuery.put("arrValues",arrValues);
         		hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
                
                if(resultset1!=null)
                	resultset1.close();
                strQuery=SQLParser.getSqlQuery("sel_relationship_offline");
                resultset1 = statement1.executeQuery(strQuery);
                
                intsno=0;
                while(resultset1.next())
                {
                	hshQuery=new HashMap();
            		hshQuery.put("strQueryId", "insreldetails");
            		arrValues=new ArrayList();
            		intsno++;
            		intUpdateSize++;
            		//com_apprelationship
            		arrValues.add(strAppid);//COMAPP_ID
            		arrValues.add(correctNull(resultset1.getString("Employee_No")));//COMAPP_EMPRELNO
            		arrValues.add(correctNull(resultset1.getString("Relationship_to_Borrower")));//COMAPP_BORREL
            		arrValues.add(correctNull(resultset1.getString("Scale_Grade")));//COMAPP_SCALE
            		arrValues.add(correctNull(resultset1.getString("Place_posting")));//COMAPP_PLACEPOST
            		arrValues.add(correctNull(resultset1.getString("loan_Staff")));//COMAPP_LOANCOMMENTS
            		arrValues.add(Integer.toString(intsno));//COMAPP_RELSNO
            		
            		hshQuery.put("arrValues",arrValues);
            		hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
            		
                }
            }
            hshQueryValues.put("size",Integer.toString(intUpdateSize));
			
			String strLoanAmt ="",strLimitId="";
			boolean booProcess = false;//to check data is avail or not
			if(resultset1 != null)
				resultset1.close();
			strQuery=SQLParser.getSqlQuery("sel_KYCNorms_offline");
			resultset1 = statement1.executeQuery(strQuery);
			if(resultset1.next())
			{
				booProcess = true;
			}	
			else
			{
				 strExp="$" + "Data not entered in KYC Norms"; 
			throw new Exception(strExp);
			}
			
			strQuery=SQLParser.getSqlQuery("sel_sum_facility_offline");
			resultset1 = statement1.executeQuery(strQuery);
			if(resultset1.next())
			{
				strLoanAmt = correctNull((String)resultset1.getString("sum_proposed"));
			}
			
			if(!strLoanAmt.trim().equals(""))
			{
				rs=DBUtils.executeLAPSQuery("selautolimitid^C^"+strLoanAmt);
				if(rs.next())
				{
					strLimitId =rs.getString(1);
					booProcess = true;
				}
				
				if(!strLimitId.equals(""))
				{
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
		            
		            intUpdateSize=0;
		            hshQueryValues=new HashMap();
		            hashmap1=new HashMap();
		            
		            String strType="C";
		            hashmap1.put("comapp_id",strAppid);
		            hashmap1.put("apptype",strType);
					strAppno=(String)EJBInvoker.executeStateLess("appeditlock",hashmap1,"getAppno");
				}
				else
				{
					 strExp="$" + "Proposed Limit not defined in Setup"; 
					throw new Exception(strExp);
				}
				
			}
			else
			{
				strLoanAmt="0";
				strExp="$" + "Data not entered in Facilities"; 
				throw new Exception(strExp);
			}
			//Added by prashanth to take valuesin from ProposalValues table
			
			if(resultset1!=null)
            	resultset1.close();
            strQuery=SQLParser.getSqlQuery("sel_ProposalValues_offline");
            resultset1 = statement1.executeQuery(strQuery);
            if(resultset1.next())
			{
            	strValuesin = correctNull((String)resultset1.getString("valuesin"));
			}
            if(strValuesin.equalsIgnoreCase("Lacs"))
            {
            	strValuesin="L";
            }
            else
            {
            	strValuesin="C";
            }
			if(booProcess)
			{	
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdateSize = intUpdateSize+1;
				hshQuery.put("strQueryId","insapplications");
				arrValues.add(strAppno);
				arrValues.add(strLimitId);
				arrValues.add(correctNull((String)hashmap.get("strUserId")));
				arrValues.add(hashmap.get("strOrgCode"));
				arrValues.add("C");
				arrValues.add(strInwardno);
				arrValues.add(strValuesin);//values_in
				arrValues.add((strOrglevel.equalsIgnoreCase("D") && strissaral.equalsIgnoreCase("Y"))?"S":strOrglevel);
				arrValues.add(correctNull((String)hashmap.get("strUserId")));
				arrValues.add("Y");
				arrValues.add(null);
				arrValues.add(null);
				arrValues.add(null);
				arrValues.add(correctNull((String)hashmap.get("sel_facilityrequired")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdateSize));
				hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
			
				String strcma="0";
				if(rs!=null)rs.close();
				rs=DBUtils.executeLAPSQuery("selcmabycomappid^"+strAppid);
				if(rs.next())
				{
					strcma =rs.getString("cma_no");
				}
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdateSize = intUpdateSize+1;
				hshQuery.put("strQueryId","commapplicantloanins2");
				arrValues.add(strAppno);
				arrValues.add(strAppid);
				arrValues.add(strcma);
				arrValues.add("");
				arrValues.add("");
				arrValues.add("N");
				arrValues.add("");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdateSize));
				hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
	            
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdateSize = intUpdateSize+1;
				hshQuery.put("strQueryId","updfintype");
				arrValues.add(strcma);
				arrValues.add("2");
				arrValues.add(strAppno);
				arrValues.add("N");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdateSize));
				hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
				
				if(!strInwardno.equals(""))
				{
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					intUpdateSize = intUpdateSize+1;
					hshQuery.put("strQueryId","updinwardappatached");
					arrValues.add("Y");
					arrValues.add("");
					arrValues.add(strInwardno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdateSize));
					hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
				}
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdateSize = intUpdateSize+1;
				hshQuery.put("strQueryId","commworkflowins");
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hashmap.get("strUserId")));
				arrValues.add(correctNull((String)hashmap.get("strUserId")));
				arrValues.add("1");
				arrValues.add("1");
				arrValues.add("C");
				
				arrValues.add(correctNull((String)hashmap.get("strOrgShortCode")));
				if(correctNull((String)hashmap.get("strOrgLevel")).equalsIgnoreCase("C"))
					arrValues.add(correctNull((String)hashmap.get("strUserDepartment")));
				else if(correctNull((String)hashmap.get("strOrgLevel")).equalsIgnoreCase("D"))
					arrValues.add(correctNull((String)hashmap.get("strRLPFUser")));
				else
					arrValues.add("");
				
				arrValues.add(correctNull((String)hashmap.get("strOrgShortCode")));
				if(correctNull((String)hashmap.get("strOrgLevel")).equalsIgnoreCase("C"))
					arrValues.add(correctNull((String)hashmap.get("strUserDepartment")));
				else if(correctNull((String)hashmap.get("strOrgLevel")).equalsIgnoreCase("D"))
					arrValues.add(correctNull((String)hashmap.get("strRLPFUser")));
				else
					arrValues.add("");
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdateSize));
				hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
				
				
				/*
				 * To Store the facility Datas in Facilities Table.
				 * 
				 */
				intsno=0;
				int intsecsno=0;
				if(resultset1!=null)
					resultset1.close();
				ArrayList arrfacdetailsrow= new ArrayList();
				ArrayList arrfacdetailscol= new ArrayList();
				strQuery=SQLParser.getSqlQuery("sel_facility_offline");
				resultset1 = statement1.executeQuery(strQuery);
				while(resultset1.next())
				{	
					//facilities
					arrfacdetailscol=new ArrayList();
					hshQuery=new HashMap();
					hshQuery.put("strQueryId", "insfacility");
					arrValues=new ArrayList();
	        	
					intsno++;
					intUpdateSize = intUpdateSize+1;
		        	arrValues.add(strAppno);//FACILITY_APPNO
		        	
		        	String strfacilityheadid="";
		        	String strfacilityid="";
		        	
		        	strQuery=SQLParser.getSqlQuery("sel_facilitydetails_offline^"+Helper.correctDot(correctNull(resultset1.getString("app_facility"))));
		        	rs=DBUtils.executeQuery(strQuery);
		        	if(rs.next())
		        	{
		        		strfacilityid=rs.getString("facility_catid");
		        		strfacilityheadid=rs.getString("facility_parent");
		        	}
		        	
		    		arrValues.add(strfacilityheadid);//FACILITY_HEADID
		    		arrValues.add(strfacilityid);//FACILITY_ID 
		    		arrValues.add(strAppid);//BORROWER_ID
		    		arrValues.add(correctNull(resultset1.getString("existing_limit")));//FACILITY_EXISTING
		    		arrValues.add(correctNull(resultset1.getString("proposed_limit")));//FACILITY_PROPOSED
		    		arrValues.add("0");//FACILITY_DIFFERENCE
		    		String strAdjustment = Helper.correctDouble(resultset1.getString("discount"));
		    		arrValues.add(strAdjustment);//facility_intadjustment
		    		arrValues.add(""+intsno);//FACILITY_SNO
		    		arrValues.add("0");//FACILITY_GROUP
		    		arrValues.add(correctNull(resultset1.getString("irregularities")));//FACILITY_DESC
		    		arrValues.add("R");//FACILITY_CATEGORY
		    		arrValues.add(correctNull(resultset1.getString("Tenor")));//FACILITY_MONTHS
		    		String strInterest = Helper.correctDouble(resultset1.getString("interest"));
		    		double dblActualInt = 0.00;
		    		dblActualInt = Double.parseDouble(strInterest)+Double.parseDouble(strAdjustment);
		    		arrValues.add(jtn.format(dblActualInt));//FACILITY_INTEREST
		    		arrValues.add("");//FACILITY_BRANCHNAME
		    		arrValues.add(correctNull(resultset1.getString("margin")));//FACILITY_MARGIN
		    		arrValues.add(strInterest);//BPLR
		    		arrValues.add(correctNull(resultset1.getString("dp")));//FACILITY_DP
		    		arrValues.add(correctNull(resultset1.getString("outstanding")));//FACILITY_OUTSTANDING
		    		arrValues.add(correctNull(resultset1.getString("securities")));//SECURITY_VALUE
		    		arrValues.add("");
		    		arrValues.add(correctNull(resultset1.getString("InterestDiscountCommissionRemark")));
		       		arrValues.add("");//FACILITY_OUTSTANDING DATE
		       		
		       		String strExistBkArrange=correctNull(resultset1.getString("ExistingBankingArrangement"));
		       		if(strExistBkArrange.trim().equalsIgnoreCase("Sole"))
		       			strExistBkArrange="S";
		       		else if(strExistBkArrange.trim().equalsIgnoreCase("Consortium"))
		       			strExistBkArrange="C";
		       		else if(strExistBkArrange.trim().equalsIgnoreCase("Multiple Banking"))
		       			strExistBkArrange="M";
		       		arrValues.add(strExistBkArrange);//FACILITY_EXISTINGBANKTYPE
		       		String strProposedBkArrange=correctNull(resultset1.getString("ProposedBankingArrangement"));
		       		if(strProposedBkArrange.trim().equalsIgnoreCase("Sole"))
		       			strProposedBkArrange="S";
		       		else if(strProposedBkArrange.trim().equalsIgnoreCase("Consortium"))
		       			strProposedBkArrange="C";
		       		else if(strProposedBkArrange.trim().equalsIgnoreCase("Multiple Banking"))
		       			strProposedBkArrange="M";
		    		arrValues.add(strProposedBkArrange);//FACILITY_PROPBANKTYPE
		    		arrValues.add(correctNull(resultset1.getString("Purpose")));//FACILITY_PURPOSE
		    		
		    		hshQuery.put("arrValues",arrValues);
		    		hshQueryValues.put("size",Integer.toString(intUpdateSize));
					hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
				    String strFacID = correctNull(resultset1.getString("facility_id"));
					
					arrfacdetailscol.add(""+intsno);
					arrfacdetailscol.add(strFacID);
					arrfacdetailsrow.add(arrfacdetailscol);
								
					//start
					
		  /**For insert into fac_security_details table from the MS Access table Securities*/
					 statement2 = connection1.createStatement();
				     strQuery=SQLParser.getSqlQuery("sel_facilitysno_offline^"+strFacID);
		             resultset2 = statement2.executeQuery(strQuery);
		            while(resultset2.next())
		            {
		               	hshQuery=new HashMap();
		        		hshQuery.put("strQueryId", "inssecuritydetails");
		        		arrValues=new ArrayList();
		        		intsecsno++;
		            	intUpdateSize = intUpdateSize+1;
		            	arrValues.add(strAppno);
		        		arrValues.add(Integer.toString(intsecsno));
		        		arrValues.add(Integer.toString(intsecsno));
		        		arrValues.add(correctNull(resultset2.getString("SecurityID")));
		        		arrValues.add(correctNull(resultset2.getString("SecurityDetails")));
		        		arrValues.add(correctNull(resultset2.getString("SecurityValue")));
		        		String strSecason = correctNull(resultset2.getString("SecurityValueOn"));
	            		if(!strSecason.equals("__/__/____"))
		        		{	
		        			arrValues.add(strSecason);
		        		}
		        		else
		        		{
		        			arrValues.add("");
		        		}
		        		
		        		arrValues.add(correctNull(resultset2.getString("SecurityTenor")));
		        		arrValues.add(correctNull(resultset2.getString("SecurityType")));
		        		arrValues.add(correctNull(resultset2.getString("ValuersName")));
		        	    arrValues.add(correctNull(resultset2.getString("InsuranceAmount")));
		        	    String strExpiryDate = correctNull(resultset2.getString("InsuranceExpiryDate"));
	            		if(!strExpiryDate.equals("__/__/____"))
		        		{	
		        			arrValues.add(strExpiryDate);
		        		}
		        		else
		        		{
		        			arrValues.add("");
		        		}
	            		
		        		arrValues.add(correctNull(resultset2.getString("RemarksEncumbrance")));
		           		arrValues.add(Integer.toString(intsno));
		        		arrValues.add(correctNull(resultset2.getString("Margin")));
		        		String secCharge=correctNull(resultset2.getString("NatureCharge"));
		        		if(secCharge.trim().equals("Exclusive"))
		        			secCharge="1";
		        		else if(secCharge.trim().equals("First & Parri-passu"))
		        			secCharge="2";
		        		else if(secCharge.trim().equals("Second & Exclusive"))
		        			secCharge="3";
		        		else if(secCharge.trim().equals("Second & Parri-passu"))
		        			secCharge="4";
		        	    else if(secCharge.trim().equals("Subservient & Exclusive"))
	        				secCharge="5";
		        		else if(secCharge.trim().equals("Subservient & Parri-passu"))	
		        			secCharge="6";
		        		else if(secCharge.trim().equals("Unsecured"))	
		        			secCharge="7";
		        			
		        		arrValues.add(secCharge);
		                arrValues.add("");//sec_ownedby
		        		arrValues.add("");//sec_legalopinion
		        		hshQuery.put("arrValues",arrValues);
		        		hshQueryValues.put("size",Integer.toString(intUpdateSize));
		    			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
		    			
		
		            }
	                /**End*/
					
					//end

				}
			
	     		strQuery=SQLParser.getSqlQuery("sel_Sub_Facility_offline");
	     		if(resultset1 != null)
	     			resultset1.close();
				resultset1 = statement1.executeQuery(strQuery);
				arrfacdetailscol=new ArrayList();
				while(resultset1.next())
				{	
					//facilities
					hshQuery=new HashMap();
					String strFacilitygrp="0";
					hshQuery.put("strQueryId", "insfacility");
					arrValues=new ArrayList();
	        	
					intsno++;
					intUpdateSize = intUpdateSize+1;
		        	
		        	
		        	String strfacilityheadid="";
		        	String strfacilityid="";
		        	strQuery=SQLParser.getSqlQuery("sel_facilitydetails_offline^"+Helper.correctDot(correctNull(resultset1.getString("sub_app_facility"))));
		        	rs=DBUtils.executeQuery(strQuery);
		        	if(rs.next())
		        	{
		        		strfacilityid=rs.getString("facility_catid");
		        		strfacilityheadid =rs.getString("facility_parent");
		        	}
		        	arrValues.add(strAppno);//FACILITY_APPNO
		    		arrValues.add(strfacilityheadid);//FACILITY_HEADID
		    		arrValues.add(strfacilityid);//FACILITY_ID
		    		arrValues.add(strAppid);//BORROWER_ID
		    		arrValues.add(correctNull(resultset1.getString("sub_existing_limit")));//FACILITY_EXISTING
		    		arrValues.add(correctNull(resultset1.getString("sub_proposed_limit")));//FACILITY_PROPOSED
		    		arrValues.add("0");//FACILITY_DIFFERENCE
		    		String strSubAdjustInterest = Helper.correctDouble(resultset1.getString("sub_discount"));
		    		arrValues.add(strSubAdjustInterest);//facility_intadjustment
		    		
		    		arrValues.add(""+intsno);//FACILITY_SNO
		    		
		    		check_String = correctNull(resultset1.getString("facility_id"));	    		
		    		for(int i=0;arrfacdetailsrow!=null && i<arrfacdetailsrow.size();i++)
		    		{
		    			arrfacdetailscol=(ArrayList)arrfacdetailsrow.get(i);
		    			if(arrfacdetailscol.get(1).toString().equalsIgnoreCase(check_String))
		    			{
		    				strFacilitygrp=arrfacdetailscol.get(0).toString();
		    				break;
		    			}
		    		}
		    		arrValues.add(strFacilitygrp);//FACILITY_GROUP
		    		arrValues.add(correctNull(resultset1.getString("sub_irregularities")));//FACILITY_DESC
		    		arrValues.add("R");//FACILITY_CATEGORY
		    		arrValues.add(correctNull(resultset1.getString("sub_Tenor")));//arrValues.add(correctNull(resultset1.getString("sub_noOfmonths")));//FACILITY_MONTHS
		     		String strSubInterest = Helper.correctDouble(resultset1.getString("sub_interest"));
		      		double dblsubActualInt = 0.00;
		    		dblsubActualInt = Double.parseDouble(strSubInterest)+Double.parseDouble(strSubAdjustInterest);
		       		arrValues.add(jtn.format(dblsubActualInt));//FACILITY_INTEREST
		    		arrValues.add("");//FACILITY_BRANCHNAME
		    		arrValues.add(correctNull(resultset1.getString("sub_margin")));//FACILITY_MARGIN
		    		arrValues.add(strSubInterest);//BPLR
		    		arrValues.add(correctNull(resultset1.getString("sub_dp")));//FACILITY_DP
		    		arrValues.add(correctNull(resultset1.getString("sub_outstanding")));//FACILITY_OUTSTANDING
		    		arrValues.add(correctNull(resultset1.getString("sub_securities")));//SECURITY_VALUE
		    		arrValues.add("");
		    		arrValues.add(correctNull(resultset1.getString("sub_InterestDiscountCommissionRemark")));
		    		
		    		arrValues.add(""); //FACILITY_OUTSTANDING DATE 
		    		String strSubExistBkArrange=correctNull(resultset1.getString("sub_ExistingBankingArrangement"));
		       		if(strSubExistBkArrange.trim().equalsIgnoreCase("Sole"))
		       			strSubExistBkArrange="S";
		       		else if(strSubExistBkArrange.trim().equalsIgnoreCase("Consortium"))
		       			strSubExistBkArrange="C";
		       		else if(strSubExistBkArrange.trim().equalsIgnoreCase("Multiple Banking"))
		       			strSubExistBkArrange="M";
		       		
		    		arrValues.add(strSubExistBkArrange);//FACILITY_EXISTINGBANKTYPE
		    		String strSubProposedBkArrange=correctNull(resultset1.getString("sub_ProposedBankingArrangement"));
		       		if(strSubProposedBkArrange.trim().equalsIgnoreCase("Sole"))
		       			strSubProposedBkArrange="S";
		       		else if(strSubProposedBkArrange.trim().equalsIgnoreCase("Consortium"))
		       			strSubProposedBkArrange="C";
		       		else if(strSubProposedBkArrange.trim().equalsIgnoreCase("Multiple Banking"))
		       			strSubProposedBkArrange="M";
		       		
		    		arrValues.add(strSubProposedBkArrange);//FACILITY_PROPBANKTYPE
		    		arrValues.add(correctNull(resultset1.getString("sub_Purpose")));//FACILITY_PURPOSE
		    		String strSubFacID=correctNull(resultset1.getString("sub_facility_id"));
		    		
		    
		    		hshQuery.put("arrValues",arrValues);
		    		hshQueryValues.put("size",Integer.toString(intUpdateSize));
					hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
					
					
					 /**For insert into fac_security_details table from the MS Access table Securities*/
				
					 if(resultset2 != null)
		             resultset2.close();
					 statement2 = connection1.createStatement();
		             strQuery=SQLParser.getSqlQuery("sel_subfacilitysno_offline^"+strSubFacID);
		             resultset2 = statement2.executeQuery(strQuery);
		            while(resultset2.next())
		            {
		               	hshQuery=new HashMap();
		        		hshQuery.put("strQueryId", "inssecuritydetails");
		        		arrValues=new ArrayList();
		        		intsecsno++;
		            	intUpdateSize = intUpdateSize+1;
		            	arrValues.add(strAppno);
		        		arrValues.add(Integer.toString(intsecsno));
		        		arrValues.add(Integer.toString(intsecsno));
		        		arrValues.add(correctNull(resultset2.getString("SecurityID")));
		        		arrValues.add(correctNull(resultset2.getString("SecurityDetails")));
		        		arrValues.add(correctNull(resultset2.getString("SecurityValue")));
		        		String strSecason = correctNull(resultset2.getString("SecurityValueOn"));
	            		if(!strSecason.equals("__/__/____"))
		        		{	
		        			arrValues.add(strSecason);
		        		}
		        		else
		        		{
		        			arrValues.add("");
		        		}
		        		
		        		arrValues.add(correctNull(resultset2.getString("SecurityTenor")));
		        		arrValues.add(correctNull(resultset2.getString("SecurityType")));
		        		arrValues.add(correctNull(resultset2.getString("ValuersName")));
		        	    arrValues.add(correctNull(resultset2.getString("InsuranceAmount")));
		        	    String strExpiryDate = correctNull(resultset2.getString("InsuranceExpiryDate"));
	            		if(!strExpiryDate.equals("__/__/____"))
		        		{	
		        			arrValues.add(strExpiryDate);
		        		}
		        		else
		        		{
		        			arrValues.add("");
		        		}
	            		
		        		arrValues.add(correctNull(resultset2.getString("RemarksEncumbrance")));
		           		arrValues.add(Integer.toString(intsno));
		        		arrValues.add(correctNull(resultset2.getString("Margin")));
		        		String secCharge=correctNull(resultset2.getString("NatureCharge"));
		        		if(secCharge.trim().equals("Exclusive"))
		        			secCharge="1";
		        		else if(secCharge.trim().equals("First & Parri-passu"))
		        			secCharge="2";
		        		else if(secCharge.trim().equals("Second & Exclusive"))
		        			secCharge="3";
		        		else if(secCharge.trim().equals("Second & Parri-passu"))
		        			secCharge="4";
		        	    else if(secCharge.trim().equals("Subservient & Exclusive"))
	        				secCharge="5";
		        		else if(secCharge.trim().equals("Subservient & Parri-passu"))	
		        			secCharge="6";
		        		else if(secCharge.trim().equals("Unsecured"))	
		        			secCharge="7";
		        			
		        		arrValues.add(secCharge);
		                arrValues.add("");//sec_ownedby
		        		arrValues.add("");//sec_legalopinion
		        		hshQuery.put("arrValues",arrValues);
		        		hshQueryValues.put("size",Integer.toString(intUpdateSize));
		    			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
		    		
		
		            }
	                /**End*/
				}
				
	        /***Insert collatoral security*/
				 if(resultset1 != null)
					 resultset1.close();
				     strQuery=SQLParser.getSqlQuery("sel_collateralsec_offline");
				     resultset1 = statement1.executeQuery(strQuery);
		            while(resultset1.next())
		            {
		               	hshQuery=new HashMap();
		        		hshQuery.put("strQueryId", "inssecuritydetails");
		        		arrValues=new ArrayList();
		        		intsecsno++;
		            	intUpdateSize = intUpdateSize+1;
		            	arrValues.add(strAppno);
		        		arrValues.add(Integer.toString(intsecsno));
		        		arrValues.add(Integer.toString(intsecsno));
		        		arrValues.add(correctNull(resultset1.getString("SecurityID")));
		        		arrValues.add(correctNull(resultset1.getString("SecurityDetails")));
		        		arrValues.add(correctNull(resultset1.getString("SecurityValue")));
		        		String strSecason = correctNull(resultset1.getString("SecurityValueOn"));
	            		if(!strSecason.equals("__/__/____"))
		        		{	
		        			arrValues.add(strSecason);
		        		}
		        		else
		        		{
		        			arrValues.add("");
		        		}
		        		
		        		arrValues.add(correctNull(resultset1.getString("SecurityTenor")));
		        		arrValues.add(correctNull(resultset1.getString("SecurityType")));
		        		arrValues.add(correctNull(resultset1.getString("ValuersName")));
		        	    arrValues.add(correctNull(resultset1.getString("InsuranceAmount")));
		        	    String strExpiryDate = correctNull(resultset1.getString("InsuranceExpiryDate"));
	            		if(!strExpiryDate.equals("__/__/____"))
		        		{	
		        			arrValues.add(strExpiryDate);
		        		}
		        		else
		        		{
		        			arrValues.add("");
		        		}
	            		
		        		arrValues.add(correctNull(resultset1.getString("RemarksEncumbrance")));
		           		arrValues.add("0");
		        		arrValues.add(correctNull(resultset1.getString("Margin")));
		        		String secCharge=correctNull(resultset1.getString("NatureCharge"));
		        		if(secCharge.trim().equals("Exclusive"))
		        			secCharge="1";
		        		else if(secCharge.trim().equals("First & Parri-passu"))
		        			secCharge="2";
		        		else if(secCharge.trim().equals("Second & Exclusive"))
		        			secCharge="3";
		        		else if(secCharge.trim().equals("Second & Parri-passu"))
		        			secCharge="4";
		        	    else if(secCharge.trim().equals("Subservient & Exclusive"))
	        				secCharge="5";
		        		else if(secCharge.trim().equals("Subservient & Parri-passu"))	
		        			secCharge="6";
		        		else if(secCharge.trim().equals("Unsecured"))	
		        			secCharge="7";
		        			
		        		arrValues.add(secCharge);
		                arrValues.add("");//sec_ownedby
		        		arrValues.add("");//sec_legalopinion
		        		hshQuery.put("arrValues",arrValues);
		        		hshQueryValues.put("size",Integer.toString(intUpdateSize));
		    			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
  		
		
		            }
		        	
			/**End*/	
	            /************************************************	
	        	 * 										 		*
	        	 * For Insert into table promoters directors 	*
	        	 * table from the MS Access DB           		*
	        	 *  									 		*
	        	 ************************************************/
	           
				String DateYear="",DateYear1="";
				if(resultset1!=null)
	             	resultset1.close();
	            intsno = 0;
	             strQuery=SQLParser.getSqlQuery("sel_PromotersAndDirectors_offline");
	             resultset1 = statement1.executeQuery(strQuery);
	            while(resultset1.next())
	            {
	            	//com_companydetails
	            	DateYear = correctNull(resultset1.getString("Date_of_Birth"));
	            	DateYear1 = correctNull(resultset1.getString("As_on_Date"));
	            	hshQuery=new HashMap();
	        		hshQuery.put("strQueryId", "compromoterins");
	        		arrValues=new ArrayList();
	            	
	        		
	            	intUpdateSize = intUpdateSize+1;
	            	intsno++;
	        		arrValues.add(strAppno);//COM_COMPDTAPPNO
	        		arrValues.add(""+intsno);//COM_COMPDTID
	        		arrValues.add(correctNull(resultset1.getString("Pro_Type")));//COM_COMPDTTYPE
	        		arrValues.add(correctNull(resultset1.getString("First_Name")));//COM_COMPDTFNAME
	        		arrValues.add(correctNull(resultset1.getString("Last_Name")));//COM_COMPDTLNAME
	        		arrValues.add(correctNull(resultset1.getString("Middle_Name")));//COM_COMPDTMNAME
	        		if(!DateYear.equals("__/__/____"))
	        		{	
	        			arrValues.add(DateYear);//COM_COMPDTDOB
	        		}
	        		else
	        		{
	        			arrValues.add("");//COM_COMPDTDOB
	        		}
	        		arrValues.add(correctNull(resultset1.getString("Address1")));//COM_COMPDTADDRESS1
	        		arrValues.add(correctNull(resultset1.getString("Address2")));//COM_COMPDTADDRESS2
	        		arrValues.add(correctNull(resultset1.getString("City")));//COM_COMPDTCITY
	        		arrValues.add(correctNull(resultset1.getString("State")));//COM_COMPDTSTATE
	        		arrValues.add(correctNull(resultset1.getString("Pin")));//COM_COMPDTPIN
	        		arrValues.add(correctNull(resultset1.getString("Phone")));//COM_COMPDTPHONE
	        		arrValues.add(correctNull(resultset1.getString("Fax")));//COM_COMPDTFAX
	        		arrValues.add(correctNull(resultset1.getString("Email")));//COM_COMPDTEMAIL
	        		arrValues.add(correctNull(resultset1.getString("Share_percent")));//COM_COMDTPERSHARE
	        		arrValues.add(correctNull(resultset1.getString("Shares_Held")));//COM_COMPDTSHAREHELD
	        		arrValues.add("");//COM_COMPDTNETWORTH
	        		if(!DateYear1.equals("__/__/____"))
	        		{
	        			arrValues.add(DateYear1);//COM_COMPDATE
	        		}
	        		else
	        		{
	        			arrValues.add("");//COM_COMPDATE
	        		}
	        		arrValues.add(correctNull(resultset1.getString("Capital_Contribution")));//CAPCONTRIBUTION
	        		arrValues.add("");//COM_PERCENT
	        		arrValues.add(correctNull(resultset1.getString("Sex_of_Promoter")));//COM_COMPDSEX
	        		arrValues.add(correctNull(resultset1.getString("Academic_Qualification")));//COM_COMPDACA
	        		arrValues.add(correctNull(resultset1.getString("Experience")));//COM_COMPDEXP
	        		arrValues.add(correctNull(resultset1.getString("is_stake_holder")));//COM_COMPDSTKHOLDER
	        		arrValues.add(correctNull(resultset1.getString("BriefBackground")));//COM_BACKGROUND
	        		arrValues.add(correctNull(resultset1.getString("Face_Value")));//COM_FACEVALUE
	        		arrValues.add(correctNull(resultset1.getString("designation")));
	        		arrValues.add("");
	        		
	        		arrValues.add("");
	        		arrValues.add("");
	        		arrValues.add("");
	        		arrValues.add("");
	        		arrValues.add("");
	        		arrValues.add("");
	        		arrValues.add("");
	        		arrValues.add("");
	        		arrValues.add("");
	        		arrValues.add("");
	        		arrValues.add("");
	        		
	        		hshQuery.put("arrValues",arrValues);
	        		hshQueryValues.put("size",Integer.toString(intUpdateSize));
	    			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
	
	            }
	            /**For insert into com_capitalstructure table from the MS Access table CapitalStructure*/	
	            if(resultset1!=null)
                	resultset1.close();
                strQuery=SQLParser.getSqlQuery("sel_CapitalStructure_offline");
                resultset1 = statement1.executeQuery(strQuery);
                if(resultset1.next())
            	{
                	hshQuery=new HashMap();
            		hshQuery.put("strQueryId", "inscapitalstructure");
            		arrValues=new ArrayList();
            		intUpdateSize++;
            		arrValues.add(strAppno);
            		String strAson = correctNull(resultset1.getString("DetailsAsOn"));
            		if(!strAson.equals("__/__/____"))
	        		{	
	        			arrValues.add(strAson);
	        		}
	        		else
	        		{
	        			arrValues.add("");
	        		}
            	
            	    arrValues.add(correctNull(resultset1.getString("AuthorisedCapital")));
            		arrValues.add(correctNull(resultset1.getString("SubscribedCapital")));
            		arrValues.add(correctNull(resultset1.getString("TotalPaidShares")));
            		arrValues.add(correctNull(resultset1.getString("BookValue")));
            		arrValues.add(correctNull(resultset1.getString("MarketValue")));
            		arrValues.add("0");
            		hshQuery.put("arrValues",arrValues);
              		hshQueryValues.put("size",Integer.toString(intUpdateSize));
              		hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
            	}
              
	            /**End*/
            	
                /**For insert into com_compproposal table from the MS Access table BankingDetails*/
                if(resultset1!=null)
                	resultset1.close();
                strQuery=SQLParser.getSqlQuery("sel_BankingDetails_offline");
                resultset1 = statement1.executeQuery(strQuery);
                if(resultset1.next())
            	{
                	hshQuery=new HashMap();
            		hshQuery.put("strQueryId", "com_bankingdetails_insert");
            		arrValues=new ArrayList();
            		intUpdateSize++;
            		arrValues.add(strAppno);
            		String strAssestClassify=correctNull(resultset1.getString("AssetClassification"));
            		if(strAssestClassify.trim().equalsIgnoreCase("Standard"))
            			strAssestClassify="Standard";
            		else if(strAssestClassify.trim().equalsIgnoreCase("SubStandard"))
            			strAssestClassify="SubStandard";
            		else if(strAssestClassify.trim().equalsIgnoreCase("Doubtful"))
            			strAssestClassify="Doubtful";
            		else if(strAssestClassify.trim().equalsIgnoreCase("Loss"))
            			strAssestClassify="Loss";
            		else if(strAssestClassify.trim().equalsIgnoreCase("Not Applicable"))
            			strAssestClassify="N.A.";
            	
            		arrValues.add(strAssestClassify);
            		String strNPASince = correctNull(resultset1.getString("NPASince"));
            		if(!strNPASince.equals("__/__/____"))
	        		{	
	        			arrValues.add(strNPASince);
	        		}
	        		else
	        		{
	        			arrValues.add("");
	        		}
            		String strBankArrangeType=correctNull(resultset1.getString("Sole_Consortium_MultipleBanking"));
            		if(strBankArrangeType.trim().equalsIgnoreCase("Sole"))
            			strBankArrangeType="1";
            		else if(strBankArrangeType.trim().equalsIgnoreCase("Consortium"))
            			strBankArrangeType="2";
            		else if(strBankArrangeType.trim().equalsIgnoreCase("Multiple"))
            			strBankArrangeType="3";
            		else if(strBankArrangeType.trim().equalsIgnoreCase("Sole/Consortium"))
            			strBankArrangeType="4";
            		else if(strBankArrangeType.trim().equalsIgnoreCase("Sole/Multiple"))
            			strBankArrangeType="5";
            		else if(strBankArrangeType.trim().equalsIgnoreCase("Consortium/Multiple"))
            			strBankArrangeType="6";
            		else if(strBankArrangeType.trim().equalsIgnoreCase("Sole/Consortium/Multiple"))
            			strBankArrangeType="7";
            		else
            			strBankArrangeType="0";
            	
            	 	arrValues.add(strBankArrangeType);
            		arrValues.add(correctNull(resultset1.getString("LeadBank")));
            		arrValues.add(correctNull(resultset1.getString("FundBased_Existing")));
            		arrValues.add(correctNull(resultset1.getString("FundNonBased_Existing")));
            		arrValues.add(correctNull(resultset1.getString("FundBased_Proposed")));
            		arrValues.add(correctNull(resultset1.getString("FundNonBased_Proposed")));
            		String strLastReview = correctNull(resultset1.getString("DateLastReview"));
            		if(!strLastReview.equals("__/__/____"))
	        		{	
	        			arrValues.add(strLastReview);
	        		}
	        		else
	        		{
	        			arrValues.add("");
	        		}
            	    arrValues.add(correctNull(resultset1.getString("PeriodReviewed")));
            	    String strDueDate = correctNull(resultset1.getString("DueDateReview"));
            		if(!strDueDate.equals("__/__/____"))
	        		{	
	        			arrValues.add(strDueDate);
	        		}
	        		else
	        		{
	        			arrValues.add("");
	        		}
            		arrValues.add(correctNull(resultset1.getString("BankComments")));
               		hshQuery.put("arrValues",arrValues);
              		hshQueryValues.put("size",Integer.toString(intUpdateSize));
              		hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
            	}
                /**End*/
               
	            /****************************************	
	        	 * 										*
	        	 * For Insert table into group concerns	*
	        	 * table from the MS Access DB          *
	        	 *  									*
	        	 ****************************************/
	            
	            intsno = 0;
	            String tempString="";
	            if(resultset1!=null)
	             	resultset1.close();
	             strQuery=SQLParser.getSqlQuery("sel_GroupConcerns_offline");
	             resultset1 = statement1.executeQuery(strQuery);
	           while(resultset1.next())
	            {
	        		//EXEC_EXPGROUPCONCERNS
	            	hshQuery=new HashMap();
	        		hshQuery.put("strQueryId", "execgrpconins");
	        		arrValues=new ArrayList();
	        		intsno++;
	            	intUpdateSize = intUpdateSize+1;
	            	tempString = correctNull(resultset1.getString("Company_Name")).toUpperCase();
	        		arrValues.add(strAppno);//EXEC_GCAPPNO
	        		arrValues.add(""+intsno);//EXEC_GCSNO
	        		log.info(tempMap.get(tempString));
	        		log.info(tempMap.get("Visual Basic Division"));
	        		log.info(tempMap.get("Sister Visual Basic"));
	        		arrValues.add(tempMap.get(tempString));//EXEC_GCCONNAME
	        		arrValues.add(correctNull(resultset1.getString("Branch_Name")));//EXEC_GCBRANCH
	        		arrValues.add(correctNull(resultset1.getString("CoA")));//EXCE_GCCOA
	        		arrValues.add(correctNull(resultset1.getString("Contingent_Limit")));//EXEC_GCCOMLIMIT
	        		arrValues.add(correctNull(resultset1.getString("Contingent_OS")));//EXEC_GCCOMOS
	        		arrValues.add(correctNull(resultset1.getString("FBWC_Limit")));//EXEC_GCFBWCLT
	        		arrValues.add(correctNull(resultset1.getString("FBWC_DP")));//EXEC_GCFBWCDP
	        		arrValues.add(correctNull(resultset1.getString("FBWC_OS")));//EXEC_GCFBWCOS
	        		arrValues.add(correctNull(resultset1.getString("TermLoan_Limit")));//EXEC_GCTLLT
	        		arrValues.add(correctNull(resultset1.getString("TermLoan_OS")));//EXEC_GCTLOS
	        		arrValues.add(correctNull(resultset1.getString("Investment")));//EXEC_GCINS
	        		arrValues.add(correctNull(resultset1.getString("MOR")));//EXEC_GCMOR
	        		arrValues.add(correctNull(resultset1.getString("Irregularity")));//EXEC_GCIRREG
	        		
	        		hshQuery.put("arrValues",arrValues);
	        		hshQueryValues.put("size",Integer.toString(intUpdateSize));
	    			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
	            }
	          
	           /*********************************************	
		       	 * 											*
		       	 * For Insert table into working capital	*
		       	 * table from the MS Access DB          	*
		       	 *  										*
		       	 ********************************************/
	           
	           	//         banking arrangement
	           intsno = 0;
	           if(resultset1!=null)
	           resultset1.close();
	           strQuery=SQLParser.getSqlQuery("sel_Working_Capital_offline");
	           resultset1 = statement1.executeQuery(strQuery);
	           while(resultset1.next())
	            {
	        		//com_banking
	            	hshQuery=new HashMap();
	        		hshQuery.put("strQueryId", "combankinginsert");
	        		arrValues=new ArrayList();
	        		intsno++;
	            	intUpdateSize = intUpdateSize+1;
	        		arrValues.add(strAppno);//COMBK_APPNO
	        		arrValues.add(""+intsno);//COMBK_ID
	        		arrValues.add(correctNull(resultset1.getString("Bank_name")));//COMBK_BANKNAME
	        		//arrValues.add("");//COMBK_SHAREFUNDEXIST
	        		//arrValues.add("");//COMBK_SHAREFUNDPROP
	        		//arrValues.add("");//COMBK_SHARENONFUNDEXIST
	        		//arrValues.add("");//COMBK_SHARENONFUNDPROP
	        		arrValues.add(correctNull(resultset1.getString("Existing_limit_funded")));//COMBK_LMTFUNDEXIST   
	        		arrValues.add(correctNull(resultset1.getString("Proposed_limit_funded")));//COMBK_LMTFUNDPROP
	        		arrValues.add(correctNull(resultset1.getString("Existing_limit_nonfunded")));//COMBK_LMTNONFUNDEXIST
	        		arrValues.add(correctNull(resultset1.getString("Proposed_limit_nonfunded")));//COMBK_LMTNONFUNDPROP
	        		//arrValues.add("");//COMBK_OSFUNDEXIST
	        		//arrValues.add("");//COMBK_OSFUNDPROP
	        		//arrValues.add("");//COMBK_OSNONFUNDEXIST
	        		//arrValues.add("");//COMBK_OSNONFUNDPROP
	        		arrValues.add(correctNull(resultset1.getString("Remarks")));//COMBK_OVERDUE
	        		arrValues.add("W");//COMBK_TYPE
	        		//arrValues.add("");//COMBK_SECURITY
	        		arrValues.add("");//COMBK_EXCESS
	        		arrValues.add("0");//COMBK_COMPNAME
	        		arrValues.add("Other");//COMBK_SELBANK
	           		String strConsortium=correctNull(resultset1.getString("UnderConsortium"));
		       		if(strConsortium.trim().equals("Yes"))
		       			strConsortium="Y";
		       		else if(strConsortium.trim().equals("No"))
		       			strConsortium="N";
		       		else
		       			strConsortium="S";
		       		
	        		arrValues.add(strConsortium);//COMBK_CONSORTIUM
	        		
	        		hshQuery.put("arrValues",arrValues);
	        		hshQueryValues.put("size",Integer.toString(intUpdateSize));
	    			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
	            }
	           
	           /*********************************************	
		       	 * 											*
		       	 * For Insert table into term finance		*
		       	 * table from the MS Access DB          	*
		       	 *  										*
		       	 ********************************************/
	          
	          	//         banking arrangement
	          intsno = 0;
	          if(resultset1!=null)
	          resultset1.close();
	          strQuery=SQLParser.getSqlQuery("sel_TermFinance_offline");
	          resultset1 = statement1.executeQuery(strQuery);
	          while(resultset1.next())
	          {
	       		//com_banking
	           	hshQuery=new HashMap();
	       		hshQuery.put("strQueryId", "combankinginsert");
	       		arrValues=new ArrayList();
	       		intsno++;
	           	intUpdateSize = intUpdateSize+1;
	       		arrValues.add(strAppno);//COMBK_APPNO
	       		arrValues.add(""+intsno);//COMBK_ID
	       		arrValues.add(correctNull(resultset1.getString("Bank_name")));//COMBK_BANKNAME
	       		//arrValues.add("");//COMBK_SHAREFUNDEXIST
        		//arrValues.add("");//COMBK_SHAREFUNDPROP
        		//arrValues.add("");//COMBK_SHARENONFUNDEXIST
        		//arrValues.add("");//COMBK_SHARENONFUNDPROP
        		arrValues.add(correctNull(resultset1.getString("Existing_limit_funded")));//COMBK_LMTFUNDEXIST   
        		arrValues.add(correctNull(resultset1.getString("Proposed_limit_funded")));//COMBK_LMTFUNDPROP
        		arrValues.add(correctNull(resultset1.getString("Existing_limit_nonfunded")));//COMBK_LMTNONFUNDEXIST
        		arrValues.add(correctNull(resultset1.getString("Proposed_limit_nonfunded")));//COMBK_LMTNONFUNDPROP
        		//arrValues.add("");//COMBK_OSFUNDEXIST
	       		//arrValues.add("");//COMBK_OSFUNDPROP
	       		//arrValues.add("");//COMBK_OSNONFUNDEXIST
	       		//arrValues.add("");//COMBK_OSNONFUNDPROP
	       		arrValues.add(correctNull(resultset1.getString("Remarks")));//COMBK_OVERDUE
	       		arrValues.add("T");//COMBK_TYPE
	       		//arrValues.add(correctNull(resultset1.getString("Security")));//COMBK_SECURITY
	       		arrValues.add(correctNull(resultset1.getString("Excess")));//COMBK_EXCESS
	       		arrValues.add("0");//COMBK_COMPNAME
	       		String strFinIns=correctNull(resultset1.getString("Other_Financial_Institute"));
	       		if(strFinIns.trim().equals("Other Bank"))
	       			strFinIns="Other";
	       		else if(strFinIns.trim().equals("Financial Institutions"))
	       		 	strFinIns="FI";
	       		arrValues.add(strFinIns);//COMBK_SELBANK
	       		String strConsortium=correctNull(resultset1.getString("UnderConsortium"));
	       		if(strConsortium.trim().equals("Yes"))
	       			strConsortium="Y";
	       		else if(strConsortium.trim().equals("No"))
	       			strConsortium="N";
	       		else
	       			strConsortium="S";
	       		arrValues.add(strConsortium);//COMBK_CONSORTIUM
	       		
	       		hshQuery.put("arrValues",arrValues);
	       		hshQueryValues.put("size",Integer.toString(intUpdateSize));
	   			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
	           }
	            
	          
	           //repayment of existing of loans
	
	           intsno = 0;
	           if(resultset1!=null)
	           resultset1.close();
	           strQuery=SQLParser.getSqlQuery("sel_TermFinance_offline");
	           resultset1 = statement1.executeQuery(strQuery);
	           while(resultset1.next())
	            {
	
	        		//com_loanrepayments
	        	   	hshQuery=new HashMap();
	        	   	hshQuery.put("strQueryId", "comrepaymentins");
	       			arrValues=new ArrayList();
	       			intsno++;
	       			intUpdateSize = intUpdateSize+1;
	        	   	arrValues.add(strAppno);//COMPANY_APPNO
	        		arrValues.add(""+intsno);//COMPANY_ID
	        		arrValues.add(correctNull(resultset1.getString("Repayment_Schedule")));//COMPANY_REPAYSCHEDULE
	        		arrValues.add(correctNull(resultset1.getString("Commencing_From")));//COMPANY_COMMENCE
	        		arrValues.add(correctNull(resultset1.getString("Repayment_upto")));//COMPANY_REPAYUPTO
	        		arrValues.add(correctNull(resultset1.getString("Whether_rescheduled")));//COMPANY_SCHEDULE
	        		arrValues.add(correctNull(resultset1.getString("repayment_Remarks")));//COMPANY_DETAILSRESCHEDULE
	        		
	        		hshQuery.put("arrValues",arrValues);
	        		hshQueryValues.put("size",Integer.toString(intUpdateSize));
	    			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
	            }
	           
	          intsno = 0;
	           if(resultset1!=null)
	           resultset1.close();
	           strQuery=SQLParser.getSqlQuery("sel_CostofProject_offline");
	           resultset1 = statement1.executeQuery(strQuery);
	           while(resultset1.next())
	           {
	        	   	check_String = correctNull(resultset1.getString("RowDesc"));
	        	    if(!(check_String.equalsIgnoreCase("a) Cost of Project") 
	        	    	|| check_String.equalsIgnoreCase("Plant and Machinery (incl. Stores and Spares)")
	        	    	|| check_String.equalsIgnoreCase("Total Capital Cost of the Scheme")
	        	    	|| check_String.equalsIgnoreCase("Total Cost of the Scheme")
	        	    	|| check_String.equalsIgnoreCase("b) Source of Finance")
	        	    	|| check_String.equalsIgnoreCase("Total")
	        	    ))
	        	    {	
	        			hshQuery=new HashMap();
		        	   	hshQuery.put("strQueryId", "costofprojectins");
		       			arrValues=new ArrayList();
		       			intsno++;
		       			intUpdateSize = intUpdateSize+1;
		        		//com_costofproject
		        		arrValues.add(strAppno);//COM_APPNO
		        		arrValues.add(""+intsno);//COM_ID
		        		arrValues.add(correctNull(resultset1.getString("column1")));//COM_COSTINCURRED
		        		arrValues.add(correctNull(resultset1.getString("column2")));//COM_COSTTOBE
		        		arrValues.add(correctNull(resultset1.getString("repayment_schedule")));//COM_REPAY
		        		arrValues.add(check_String);//COM_OTHERS
		        		
		        		hshQuery.put("arrValues",arrValues);
		        		hshQueryValues.put("size",Integer.toString(intUpdateSize));
		    			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
	        	    }	
	            }
	         
	           intsno = 0;
	           if(resultset1!=null)
	           resultset1.close();
	           strQuery=SQLParser.getSqlQuery("sel_activities_offline");
	           resultset1 = statement1.executeQuery(strQuery);
	           while(resultset1.next())
	           {
	        		//com_activities
	        	   	hshQuery=new HashMap();
	        	   	hshQuery.put("strQueryId", "comactins");
					arrValues=new ArrayList();
					intsno++;
					intUpdateSize = intUpdateSize+1;
					arrValues.add(strAppno);//COM_ACTAPPNO
					arrValues.add(""+intsno);//COM_ACTID
					arrValues.add("M");//COM_ACTTYPE
					arrValues.add(correctNull(resultset1.getString("Manufacturing")));//COM_ACTDESC
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdateSize));
	    			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
	            }	
	           
	           intsno = 0;
	           if(resultset1!=null)
	           resultset1.close();
	           strQuery=SQLParser.getSqlQuery("sel_activities_offline");
	           resultset1 = statement1.executeQuery(strQuery);
	           while(resultset1.next())
	           {
	        		//com_activities
	        	   	hshQuery=new HashMap();
	        	   	hshQuery.put("strQueryId", "comactins");
					arrValues=new ArrayList();
					intsno++;
					intUpdateSize = intUpdateSize+1;
					arrValues.add(strAppno);//COM_ACTAPPNO
					arrValues.add(""+intsno);//COM_ACTID
					arrValues.add("T");//COM_ACTTYPE
					arrValues.add(correctNull(resultset1.getString("Trading")));//COM_ACTDESC
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdateSize));
	    			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
	            }	
	            
	           intsno = 0;
	           
	           if(resultset1!=null)
	           resultset1.close();
	           strQuery=SQLParser.getSqlQuery("sel_AboutProducts_offline");
	           resultset1 = statement1.executeQuery(strQuery);
	          
	           while(resultset1.next())
	           	{	
	        	   check_String = correctNull(resultset1.getString("Description"));
	        	   if(!check_String.equals(""))
	        	   {   
		        		//com_products
		           		hshQuery=new HashMap();
		        	   	hshQuery.put("strQueryId", "comproductins");
						arrValues=new ArrayList();
						intsno++;
						intUpdateSize = intUpdateSize+1;
		        		arrValues.add(strAppno);//COM_PRDAPPNO
		        		arrValues.add(""+intsno);//COM_PRDID
		        		arrValues.add(check_String);//COM_PRDDESC
		        		arrValues.add(correctNull(resultset1.getString("Units")));//COM_PRDUNITS
		        		arrValues.add(correctNull(resultset1.getString("LCapacity")));//COM_PRDLICENCEDCAPACITY
		        		arrValues.add(correctNull(resultset1.getString("ACapacity")));//COM_PRDACTUALCAPACITY
		        		arrValues.add(correctNull(resultset1.getString("ICapacity")));//COM_PRDINSTALLEDCAPACITY
		        		arrValues.add(correctNull(resultset1.getString("appproducts")));//COM_PRDUSES
		        		arrValues.add(correctNull(resultset1.getString("com_prdprevlicencedcap")));//COM_PRDPREVLICENCEDCAP
		        		arrValues.add(correctNull(resultset1.getString("com_prdprevactualcap")));//COM_PRDPREVACTUALCAP
		        		arrValues.add(correctNull(resultset1.getString("com_prdinstalledcap")));//COM_PRDINSTALLEDCAP
		        		arrValues.add(correctNull(resultset1.getString("Shutdown_remarks")));//COM_REMARKS
		        		
		        		hshQuery.put("arrValues",arrValues);
		        		hshQueryValues.put("size",Integer.toString(intUpdateSize));
		    			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
	        	   }
	            }
	           //com_rawmaterialinput
	           intsno = 0;
	           if(resultset1!=null)
	           resultset1.close();
	           strQuery=SQLParser.getSqlQuery("sel_Rawmaterialsandoinput_offline");
	           resultset1 = statement1.executeQuery(strQuery);
	           while(resultset1.next())
	            {	
	        	    check_String = correctNull(resultset1.getString("Rawmaterials"));
	            	if(!check_String.equals(""))
	            	{
		        	   	hshQuery=new HashMap();
		       	   		hshQuery.put("strQueryId", "comrawins");
						arrValues=new ArrayList();
						intsno++;
						intUpdateSize = intUpdateSize+1;
		        		arrValues.add(strAppno);//COM_RMAPPNO
		        		arrValues.add(""+intsno);//COM_RMID
		        		arrValues.add(check_String);//COM_RMDESC
		        		arrValues.add(correctNull(resultset1.getString("unit")));//COM_RMUNIT
		        		arrValues.add(correctNull(resultset1.getString("cost")));//COM_RMUNITCOST
		        		arrValues.add(correctNull(resultset1.getString("perpurity")));//COM_RMPURITYLEVEL
		        		arrValues.add(correctNull(resultset1.getString("perprod")));//COM_RMCOSTPROD
		        		arrValues.add(correctNull(resultset1.getString("perraw")));//COM_RMRAWMATCOST
		        		arrValues.add(correctNull(resultset1.getString("com_rmtype")));//COM_RMTYPE
		        		arrValues.add(correctNull(resultset1.getString("location")));//COM_RMLOCATION
		        		arrValues.add(correctNull(resultset1.getString("com_rmfrom")));//COM_RMFROM
		        		arrValues.add(correctNull(resultset1.getString("TotalQuantity")));//TOTALQUANTITY
		        		
		        		hshQuery.put("arrValues",arrValues);
		        		hshQueryValues.put("size",Integer.toString(intUpdateSize));
		    			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
		    		}	
	            }	
	        		//com_rawmatlsupplied
	           
	           	String check_String1="";
	         	intsno = 0;
	           	if(resultset1!=null)
	           	resultset1.close();
	           	strQuery=SQLParser.getSqlQuery("sel_Importedandindigenous_offline");
	           	resultset1 = statement1.executeQuery(strQuery);
	           	while(resultset1.next())
	            {	
	           		check_String = correctNull(resultset1.getString("com_rmmsupptype"));
	           		check_String1 = correctNull(resultset1.getString("SuppName"));
	           		if(!check_String.equals("") && !check_String1.equals(""))
	           		{	
	           		
		            	hshQuery=new HashMap();
		       	   		hshQuery.put("strQueryId", "comsupins");
						arrValues=new ArrayList();
						intsno++;
						intUpdateSize = intUpdateSize+1;
		        		arrValues.add(strAppno);//COM_RMSUPPAPPNO
		        		arrValues.add(check_String);//COM_RMMSUPPTYPE
		        		arrValues.add(correctNull(resultset1.getString("slno")));//COM_RMSUPPID
		        		arrValues.add(check_String1);//COM_RMSUPPDESC
		        		arrValues.add(correctNull(resultset1.getString("SLocation")));//COM_RMSUPPLOCATION
		        		arrValues.add(correctNull(resultset1.getString("Supplied")));//COM_RMSUPPMATL
		        		arrValues.add(correctNull(resultset1.getString("CrPeriod")));//COM_SUPPCREDITPRD
		        		
		        		hshQuery.put("arrValues",arrValues);
		        		hshQueryValues.put("size",Integer.toString(intUpdateSize));
		    			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
	           		}	
	            }	
	           	
	           	// substitutes
	           	intsno = 0;
	           	if(resultset1!=null)
		        	resultset1.close();
		        strQuery=SQLParser.getSqlQuery("sel_substitutes");
		        resultset1 = statement1.executeQuery(strQuery);
		        while(resultset1.next())
		        {
		        	hshQuery=new HashMap();
			       	hshQuery.put("strQueryId", "comotherins");
					arrValues=new ArrayList();
					intsno++;
					intUpdateSize = intUpdateSize+1;
			        arrValues.add(strAppno);//com_rmavappno
			        arrValues.add(""+intsno);//com_rmavid
			        arrValues.add(correctNull(resultset1.getString("desc")));//com_rmavdesc
			        arrValues.add(correctNull(resultset1.getString("originalcost")));//com_rmavorgcost
			        arrValues.add(correctNull(resultset1.getString("orgyield")));//com_rmavorgyield
			        
			        hshQuery.put("arrValues",arrValues);
			        hshQueryValues.put("size",Integer.toString(intUpdateSize));
			    	hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
			    }	
		        
	        	/*
	           	//com_applntcomments
	            {	
	        		arrValues.add(correctNull(resultset1.getString("")));//COM_APPLNTAPPNO
	        		arrValues.add(correctNull(resultset1.getString("com_applnttype")));//COM_APPLNTTYPE
	        		arrValues.add(correctNull(resultset1.getString("comments")));//COM_APPLNTCOMMENTS
	            }
	            
	            */
	        	//com_prdsegment
	         	intsno = 0;
	           	if(resultset1!=null)
	           	resultset1.close();
	           	strQuery=SQLParser.getSqlQuery("sel_mkt_products_offline");
	           	resultset1 = statement1.executeQuery(strQuery);
	        	while(resultset1.next())
	            {	
	            	hshQuery=new HashMap();
	       	   		hshQuery.put("strQueryId", "comsegmentins");
					arrValues=new ArrayList();
					intsno++;
					intUpdateSize = intUpdateSize+1;
	            	arrValues.add(strAppno);//COM_MKAPPNO
	        		arrValues.add(""+intsno);//COM_MKPRDID
	        		arrValues.add(correctNull(resultset1.getString("mkt_prod")));//COM_MKPRDDESC
	        		arrValues.add(correctNull(resultset1.getString("mkt_loc")));//COM_MKPRDCUSTOMER
	        		arrValues.add(correctNull(resultset1.getString("com_mkprdendwise")));//COM_MKPRDLOCATION
	        		arrValues.add(correctNull(resultset1.getString("com_mkprdcustomer")));//COM_MKPRDENDWISE
	        		arrValues.add(correctNull(resultset1.getString("com_mkprduse")));//COM_MKPRDUSE
	        		
	        		hshQuery.put("arrValues",arrValues);
	        		hshQueryValues.put("size",Integer.toString(intUpdateSize));
	    			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
	            }	
	        		//com_mktdistribution
	            
	            intsno = 0;
	           	if(resultset1!=null)
	           	resultset1.close();
	           	strQuery=SQLParser.getSqlQuery("sel_mkt_cust_export_offline");
	           	resultset1 = statement1.executeQuery(strQuery);
	        	while(resultset1.next())
	            {	
	        		hshQuery=new HashMap();
	       	   		hshQuery.put("strQueryId", "comdistins");
					arrValues=new ArrayList();
					
					intUpdateSize = intUpdateSize+1;
	        		arrValues.add(strAppno);//COM_MKTDISTAPPNO
	        		arrValues.add(correctNull(resultset1.getString("slno")));//COM_MKTDISTID
	        		arrValues.add(correctNull(resultset1.getString("com_mktdisttype")));//COM_MKTDISTTYPE
	        		arrValues.add(correctNull(resultset1.getString("mkt_cust_name")));//COM_MKTDISTCUSTNAME
	        		arrValues.add(correctNull(resultset1.getString("mkt_cust_prod")));//COM_MKTDISTPRODUCT
	        		arrValues.add(correctNull(resultset1.getString("mkt_cust_turnover")));//COM_MKTDISTTOTAL
	        		arrValues.add(correctNull(resultset1.getString("mkt_country")));//COM_MKTDISTCOUNTRYNAME
	        		
	        		hshQuery.put("arrValues",arrValues);
	        		hshQueryValues.put("size",Integer.toString(intUpdateSize));
	    			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
	            }	
	        	
	        	
	        	intsno = 0;
	           	if(resultset1!=null)
	           	resultset1.close();
	           	strQuery=SQLParser.getSqlQuery("sel_mkt_competition_offline");
	           	resultset1 = statement1.executeQuery(strQuery);
	        	while(resultset1.next())
	            {	
	        		
					
					tempString = correctNull(resultset1.getString("mkt_compt_name"));
					
					if(!tempString.equals(""))
					{	
						hshQuery=new HashMap();
		       	   		hshQuery.put("strQueryId", "comcompins");
						arrValues=new ArrayList();
						intUpdateSize = intUpdateSize+1;
		        		arrValues.add(strAppno);//COM_MKTDISTAPPNO
		        		arrValues.add(correctNull(resultset1.getString("slno")));//COM_MKTDISTID
		        		arrValues.add(tempString);//COM_MKTDISTTYPE
		        		arrValues.add(correctNull(resultset1.getString("mkt_compt_prod")));//COM_MKTDISTCUSTNAME
		        		arrValues.add(correctNull(resultset1.getString("mkt_compt_turnover")));//COM_MKTDISTPRODUCT
		        		arrValues.add(correctNull(resultset1.getString("mkt_compt_player")));//COM_MKTDISTTOTAL
		        		arrValues.add(correctNull(resultset1.getString("mkt_compt_mkt_share")));//COM_MKTDISTCOUNTRYNAME
		        		
		        		hshQuery.put("arrValues",arrValues);
		        		hshQueryValues.put("size",Integer.toString(intUpdateSize));
		    			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
					}	
		    			
	            }	
	        	/*intsno = 0;
	           	if(resultset1!=null)
	           	resultset1.close();
	           	strQuery=SQLParser.getSqlQuery("sel_comdist_access");
	           	resultset1 = statement1.executeQuery(strQuery);
	        	while(resultset1.next())
	            {	
	        		hshQuery=new HashMap();
	       	   		hshQuery.put("strQueryId", "comdistins");
					arrValues=new ArrayList();
					intsno++;
					intUpdateSize = intUpdateSize+1;
	        		arrValues.add(strAppno);//COM_MKTDISTAPPNO
	        		arrValues.add(""+intsno);//COM_MKTDISTID
	        		arrValues.add("local");//COM_MKTDISTTYPE
	        		arrValues.add(correctNull(resultset1.getString("mkt_cust_name")));//COM_MKTDISTCUSTNAME
	        		arrValues.add(correctNull(resultset1.getString("mkt_cust_prod")));//COM_MKTDISTPRODUCT
	        		arrValues.add(correctNull(resultset1.getString("mkt_cust_turnover")));//COM_MKTDISTTOTAL
	        		arrValues.add(correctNull(resultset1.getString("mkt_country")));//COM_MKTDISTCOUNTRYNAME
	        		
	        		hshQueryValues.put("size",Integer.toString(intUpdateSize));
	    			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
	            }*/	

	        	//com_employees
	           	intsno = 0;
	        	if(resultset1!=null)
	        	resultset1.close();
	        	strQuery=SQLParser.getSqlQuery("sel_Organisations_offline");
	        	resultset1 = statement1.executeQuery(strQuery);
	         	while(resultset1.next())
	            {	
	         		hshQuery=new HashMap();
	       	   		hshQuery.put("strQueryId", "comorgins");
					arrValues=new ArrayList();
					intsno++;
					intUpdateSize = intUpdateSize+1;
	        		arrValues.add(strAppno); //COM_EMPAPPNO
	        		arrValues.add(Integer.toString(intsno));//COM_EMDID
	        		arrValues.add(correctNull(resultset1.getString("TechBack")));//COM_EMPDESC
	        		arrValues.add(correctNull(resultset1.getString("Responsibilities")));//COM_EMPRESP
	        		arrValues.add(correctNull(resultset1.getString("WorkingSince")));//COM_EMPWORKING
	        		arrValues.add(correctNull(resultset1.getString("Experience")));//COM_EMPEXPERIENCE
	        		arrValues.add(correctNull(resultset1.getString("ReportTo")));//COM_EMPREPORT
	           		hshQuery.put("arrValues",arrValues);
	        		hshQueryValues.put("size",Integer.toString(intUpdateSize));
	    			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
	            }
	         	
//	         	    hshQuery=new HashMap();
//       			hshQuery.put("strQueryId", "comcommentins");
//       			arrValues=new ArrayList();
//       			intUpdateSize = intUpdateSize+1;
//       			arrValues.add(strAppno);
//       			arrValues.add("Experience");
//       			arrValues.add(check_String);
//       			hshQuery.put("arrValues",arrValues);
//       			hshQueryValues.put("size",Integer.toString(intUpdateSize));
//       			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
	         	
	         	intsno = 0;
	         	if(resultset1!=null)
	         	resultset1.close();
	         	strQuery=SQLParser.getSqlQuery("sel_MgmtEmployees_offline");
	         	resultset1 = statement1.executeQuery(strQuery);
	         	if(resultset1.next())
	         	{
	         		intUpdateSize = intUpdateSize+1;
	         		hshQuery=new HashMap();
	       	   		hshQuery.put("strQueryId", "comcommentins");
					arrValues=new ArrayList();
					arrValues.add(strAppno);
					arrValues.add("Succession plan");
					arrValues.add(correctNull(resultset1.getString("Succession")));
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
					
					intUpdateSize = intUpdateSize+1;
	         		hshQuery=new HashMap();
	       	   		hshQuery.put("strQueryId", "comcommentins");
					arrValues=new ArrayList();
					arrValues.add(strAppno);
					arrValues.add("Strategic initiatives");
					arrValues.add(correctNull(resultset1.getString("Strategic")));
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
					
					intUpdateSize = intUpdateSize+1;
	         		hshQuery=new HashMap();
	       	   		hshQuery.put("strQueryId", "comcommentins");
					arrValues=new ArrayList();
					arrValues.add(strAppno);
					arrValues.add("Skilled");
					arrValues.add(correctNull(resultset1.getString("Skilled")));
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
					
					intUpdateSize = intUpdateSize+1;
	         		hshQuery=new HashMap();
	       	   		hshQuery.put("strQueryId", "comcommentins");
					arrValues=new ArrayList();
					arrValues.add(strAppno);
					arrValues.add("Unskilled");
					arrValues.add(correctNull(resultset1.getString("Unskilled")));
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
					
					intUpdateSize = intUpdateSize+1;
	         		hshQuery=new HashMap();
	       	   		hshQuery.put("strQueryId", "comcommentins");
					arrValues=new ArrayList();
					arrValues.add(strAppno);
					arrValues.add("Employee welfare");
					arrValues.add(correctNull(resultset1.getString("Employee")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
					
					intUpdateSize = intUpdateSize+1;
	         		hshQuery=new HashMap();
	       	   		hshQuery.put("strQueryId", "comcommentins");
					arrValues=new ArrayList();
					arrValues.add(strAppno);
					arrValues.add("Any strike");
					arrValues.add(correctNull(resultset1.getString("Strike")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
					
					intUpdateSize = intUpdateSize+1;
	         		hshQuery=new HashMap();
	       	   		hshQuery.put("strQueryId", "comcommentins");
					arrValues=new ArrayList();
					arrValues.add(strAppno);
					arrValues.add("Comments");
					arrValues.add(correctNull(resultset1.getString("Comments")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
					
	         	}
	         	
	         	 intsno = 0;
	          	if(resultset1!=null)
	          	resultset1.close();
	          	strQuery=SQLParser.getSqlQuery("sel_OtherManagementDetails_offline");
	          	resultset1 = statement1.executeQuery(strQuery);
	          	if(resultset1.next())
	          	{
	          		intUpdateSize = intUpdateSize+1;
	          		hshQuery=new HashMap();
	        	   	hshQuery.put("strQueryId", "comcommentins");
	 				arrValues=new ArrayList();
	 				arrValues.add(strAppno);
	 				arrValues.add("Initiative of the Mgmt on QC");
	 				arrValues.add(correctNull(resultset1.getString("Welfare")));
	 				hshQuery.put("arrValues",arrValues);
	 				hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
	 				
	 				intUpdateSize = intUpdateSize+1;
	          		hshQuery=new HashMap();
	        	   	hshQuery.put("strQueryId", "comcommentins");
	 				arrValues=new ArrayList();
	 				arrValues.add(strAppno);
	 				arrValues.add("Reporting Control");
	 				arrValues.add(correctNull(resultset1.getString("PastStrike")));
	 				hshQuery.put("arrValues",arrValues);
	 				hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
	 				
	 				intUpdateSize = intUpdateSize+1;
	          		hshQuery=new HashMap();
	        	   	hshQuery.put("strQueryId", "comcommentins");
	 				arrValues=new ArrayList();
	 				arrValues.add(strAppno);
	 				arrValues.add("Project Implementation");
	 				arrValues.add(correctNull(resultset1.getString("Labour")));
	 				hshQuery.put("arrValues",arrValues);
	 				hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
	 				
	 				
	 				
	          	}
	          	
	          	 
	         	
	        	/*
	         	//com_applntcomments
	            {	
	        		arrValues.add(correctNull(resultset1.getString("")));//COM_APPLNTAPPNO
	        		arrValues.add(correctNull(resultset1.getString("")));//COM_APPLNTTYPE
	        		arrValues.add(correctNull(resultset1.getString("ceoAddress")));//COM_APPLNTCOMMENTS
	            }	
	        	*/	
	        		
	        		//com_otherinfo
	         	 intsno = 0;
	         	if(resultset1!=null)
	         	resultset1.close();
	         	strQuery=SQLParser.getSqlQuery("sel_OrgOtherInfo_offline");
	         	resultset1 = statement1.executeQuery(strQuery);
	          	while(resultset1.next())
	            {	
	          		hshQuery=new HashMap();
	       	   		hshQuery.put("strQueryId", "cominfoins");
					arrValues=new ArrayList();
					intsno++;
					intUpdateSize = intUpdateSize+1;
	          		
	          		arrValues.add(strAppno);//COM_OIAPPNO
	        		arrValues.add(""+intsno);//COM_OIID
	        		arrValues.add("guarantee");//COM_OITYPE
	        		arrValues.add(correctNull(resultset1.getString("on_behalf")));//COM_OIDESC
	        		arrValues.add(correctNull(resultset1.getString("Guarantee_amt")));//COM_OIAMOUNT
	        		
	        		hshQuery.put("arrValues",arrValues);
	        		hshQueryValues.put("size",Integer.toString(intUpdateSize));
	    			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
	            }	
	
	          	check_String="";
	          	 intsno = 0;
	          	if(resultset1!=null)
	          	resultset1.close();
	          	strQuery=SQLParser.getSqlQuery("sel_OrgOtherInfo_offline");
	          	resultset1 = statement1.executeQuery(strQuery);
	           	while(resultset1.next())
	             {	
	           		hshQuery=new HashMap();
	        	   	hshQuery.put("strQueryId", "cominfoins");
	 				arrValues=new ArrayList();
	 				intsno++;
	 				intUpdateSize = intUpdateSize+1;
	           		
	           		arrValues.add(strAppno);//COM_OIAPPNO
	         		arrValues.add(""+intsno);//COM_OIID
	         		arrValues.add("nature");//COM_OITYPE
	         		arrValues.add(correctNull(resultset1.getString("Due_Nature")));//COM_OIDESC
	         		arrValues.add(correctNull(resultset1.getString("due_amt")));//COM_OIAMOUNT
	         		check_String=correctNull(resultset1.getString("suit_filed"));
	         		hshQuery.put("arrValues",arrValues);
	         		hshQueryValues.put("size",Integer.toString(intUpdateSize));
	     			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
	             }	
	          	//com_applntcomments
	           	hshQuery=new HashMap();
       			hshQuery.put("strQueryId", "comcommentins");
       			arrValues=new ArrayList();
       			intUpdateSize = intUpdateSize+1;
       			arrValues.add(strAppno);
       			arrValues.add("Details of suit");
       			arrValues.add(check_String);
       			hshQuery.put("arrValues",arrValues);
       			hshQueryValues.put("size",Integer.toString(intUpdateSize));
       			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);	
	        		
	        		//com_eqinvlitigations
	            intsno = 0;
	          	if(resultset1!=null)
	          	resultset1.close();
	          	strQuery=SQLParser.getSqlQuery("sel_equity_invested_offline");
	          	resultset1 = statement1.executeQuery(strQuery);
	           	while(resultset1.next())
	            {	
	           		hshQuery=new HashMap();
	        	   	hshQuery.put("strQueryId", "comequiins");
	 				arrValues=new ArrayList();
	 				intsno++;
	 				intUpdateSize = intUpdateSize+1;
	 				
	           		arrValues.add(strAppno);//COM_EQINVAPPNO
	        		arrValues.add(""+intsno);//COM_EQINVID
	        		arrValues.add(correctNull(resultset1.getString("name_of_concern")));//COM_EQINVNAME
	        		arrValues.add(correctNull(resultset1.getString("nature_det_of_trans")));//COM_EQINVNATURE
	        		arrValues.add(correctNull(resultset1.getString("amount")));//COM_EQINVAMOUNT
	        		arrValues.add(correctNull(resultset1.getString("remarks")));//COM_EQINVREMARKS
	        		arrValues.add("company");//COM_EQINVTYPE
	        		
	        		arrValues.add(correctNull(resultset1.getString("market_value")));//MARKETVALUE
	        		DateYear=correctNull(resultset1.getString("equity_date"));
	        		if(!DateYear.equals("__/__/____"))
	        		{
	        			arrValues.add(DateYear);//equity_date
	        		}
	        		else
	        		{
	        			arrValues.add("");//equity_date
	        		}
	        				
	        		
	        		hshQuery.put("arrValues",arrValues);
	        		hshQueryValues.put("size",Integer.toString(intUpdateSize));
	     			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
	            }
	           	
	           	intsno = 0;
	          	if(resultset1!=null)
	          	resultset1.close();
	          	strQuery=SQLParser.getSqlQuery("sel_Litigations_offline");
	          	resultset1 = statement1.executeQuery(strQuery);
	           	while(resultset1.next())
	            {	
	           		hshQuery=new HashMap();
	        	   	hshQuery.put("strQueryId", "comequiins");
	 				arrValues=new ArrayList();
	 				intsno++;
	 				intUpdateSize = intUpdateSize+1;
	 				
	           		arrValues.add(strAppno);//COM_EQINVAPPNO
	        		arrValues.add(""+intsno);//COM_EQINVID
	        		arrValues.add(correctNull(resultset1.getString("name_of_concern")));//COM_EQINVNAME
	        		arrValues.add(correctNull(resultset1.getString("reason")));//COM_EQINVNATURE
	        		arrValues.add(correctNull(resultset1.getString("amount_claimed")));//COM_EQINVAMOUNT
	        		arrValues.add(correctNull(resultset1.getString("remarks")));//COM_EQINVREMARKS
	        		arrValues.add("bank");//COM_EQINVTYPE
	        		
	        		arrValues.add("");//MARKETVALUE
	        		arrValues.add("");//equity_date
	        		hshQuery.put("arrValues",arrValues);
	        		hshQueryValues.put("size",Integer.toString(intUpdateSize));
	     			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
	            }
	           	
	           	//applncomments
	           	
	           	
	          	if(resultset1!=null)
	          	resultset1.close();
	          	strQuery=SQLParser.getSqlQuery("sel_applncomments_offline");
	          	resultset1 = statement1.executeQuery(strQuery);
	           	while(resultset1.next())
	            {	
	           		check_String=correctNull(resultset1.getString("comments"));
	           		if(!check_String.equalsIgnoreCase(""))
	           		{
	           			hshQuery=new HashMap();
	           			hshQuery.put("strQueryId", "comcommentins");
	           			arrValues=new ArrayList();
	           			intUpdateSize = intUpdateSize+1;
	           			arrValues.add(strAppno);
	           			arrValues.add(correctNull(resultset1.getString("com_applnttype")));
	           			arrValues.add(check_String);
	           			hshQuery.put("arrValues",arrValues);
	           			hshQueryValues.put("size",Integer.toString(intUpdateSize));
	           			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
	           		}
	            }
	           	
	           	
	           	//To copy finnacials from MS Acess
	           	if(resultset1!=null)
		          	resultset1.close();
		          	strQuery=SQLParser.getSqlQuery("sel_financials_offline");
		          	resultset1 = statement1.executeQuery(strQuery);
		           	while(resultset1.next())
		            {	
		           		hshQuery=new HashMap();
		        	   	hshQuery.put("strQueryId", "finappvaluesins");
		 				arrValues=new ArrayList();
		 				String strFinAudit="";
		 				String strFinUnaudit="";
		 				String strFinEstimated="";
		 				String strFinProjected="";
		 				intsno++;
		 				intUpdateSize = intUpdateSize+1;
		 				arrValues.add(strAppno);
		 				arrValues.add(correctNull(resultset1.getString("fin_year")));
		        		arrValues.add(correctNull(resultset1.getString("fin_rowid")));
		        		
		        		strFinAudit=Helper.correctDouble(resultset1.getString("fin_audit"));
		        		strFinUnaudit=Helper.correctDouble(resultset1.getString("fin_unaudit"));
		        		strFinEstimated=Helper.correctDouble(resultset1.getString("fin_estimated"));
		        		strFinProjected=Helper.correctDouble(resultset1.getString("fin_projection"));
		        		
		        		arrValues.add(Helper.isNumeric(strFinAudit)?strFinAudit:"0.0");
		        		arrValues.add(Helper.isNumeric(strFinUnaudit)?strFinUnaudit:"0.0");
		 				arrValues.add(Helper.isNumeric(strFinEstimated)?strFinEstimated:"0.0");
		        		arrValues.add(Helper.isNumeric(strFinProjected)?strFinProjected:"0.0");
		        		arrValues.add("");
		        		arrValues.add("0");
		        		
		        		hshQuery.put("arrValues",arrValues);
		        		hshQueryValues.put("size",Integer.toString(intUpdateSize));
		     			hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
		            }
	      
	           	EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
	    /**Update Banking Arrangement - Our bank details*/       	
	           	double wc_funded_existing_cons=0.0;
	    		double wc_funded_proposed_cons=0.0;
	    		double wc_funded_existing_noncons=0.0;
	    		double wc_funded_proposed_noncons=0.0;
	    		
	    		double wc_nonfunded_existing_cons=0.0;
	    		double wc_nonfunded_proposed_cons=0.0;
	    		double wc_nonfunded_existing_noncons=0.0;
	    		double wc_nonfunded_proposed_noncons=0.0;
	    		
	    		double tl_funded_existing_cons=0.0;
	    		double tl_funded_proposed_cons=0.0;
	    		double tl_funded_existing_noncons=0.0;
	    		double tl_funded_proposed_noncons=0.0;
	    		
	    		double tl_nonfunded_existing_cons=0.0;
	    		double tl_nonfunded_proposed_cons=0.0;
	    		double tl_nonfunded_existing_noncons=0.0;
	    		double tl_nonfunded_proposed_noncons=0.0;
	    		if(resultset1!=null)
		        resultset1.close();
	            strQuery=SQLParser.getSqlQuery("sel_ourbankdetails_offline");
	            resultset1 = statement1.executeQuery(strQuery);
                while(resultset1.next())
                {
                	String strFacID=correctNull(resultset1.getString("facility_head"));
                	
                	if(strFacID.trim().equals("TERM FINANCE FUNDED"))
    				{
    					if(correctNull(resultset1.getString("ExistingBankingArrangement")).equals("Consortium"))
    						tl_funded_existing_cons=tl_funded_existing_cons+resultset1.getDouble("existinglimit");
    					else
    						tl_funded_existing_noncons=tl_funded_existing_noncons+resultset1.getDouble("existinglimit");
    					if(correctNull(resultset1.getString("ProposedBankingArrangement")).equals("Consortium"))
    						tl_funded_proposed_cons=tl_funded_proposed_cons+resultset1.getDouble("proposedlimit");
    					else
    						tl_funded_proposed_noncons=tl_funded_proposed_noncons+resultset1.getDouble("proposedlimit");
    				}
                	else if(strFacID.trim().equals("2"))
    				{
    					if(correctNull(rs.getString("facility_existbanktype")).equals("C"))
    						tl_nonfunded_existing_cons=tl_nonfunded_existing_cons+rs.getDouble("existinglimit");
    					else
    						tl_nonfunded_existing_noncons=tl_nonfunded_existing_noncons+rs.getDouble("existinglimit");
    					if(correctNull(rs.getString("facility_propbanktype")).equals("C"))
    						tl_nonfunded_proposed_cons=tl_nonfunded_proposed_cons+rs.getDouble("proposedlimit");
    					else
    						tl_nonfunded_proposed_noncons=tl_nonfunded_proposed_noncons+rs.getDouble("proposedlimit");
    				}
                	else if(strFacID.trim().equals("WORKING CAPITAL - FUNDED"))
    				{
    					if(correctNull(resultset1.getString("ExistingBankingArrangement")).equals("Consortium"))
    						wc_funded_existing_cons=wc_funded_existing_cons+resultset1.getDouble("existinglimit");
    					else
    						wc_funded_existing_noncons=wc_funded_existing_noncons+resultset1.getDouble("existinglimit");
    					if(correctNull(resultset1.getString("ProposedBankingArrangement")).equals("Consortium"))
    						wc_funded_proposed_cons=wc_funded_proposed_cons+resultset1.getDouble("proposedlimit");
    					else
    						wc_funded_proposed_noncons=wc_funded_proposed_noncons+resultset1.getDouble("proposedlimit");
    				}
                	else if(strFacID.trim().equals("WORKING CAPITAL - NON FUNDED"))
    				{
    					if(correctNull(resultset1.getString("ExistingBankingArrangement")).equals("Consortium"))
    						wc_nonfunded_existing_cons=wc_nonfunded_existing_cons+resultset1.getDouble("existinglimit");
    					else
    						wc_nonfunded_existing_noncons=resultset1.getDouble("existinglimit");
    					if(correctNull(resultset1.getString("ProposedBankingArrangement")).equals("Consortium"))
    						wc_nonfunded_proposed_cons=wc_nonfunded_proposed_cons+resultset1.getDouble("proposedlimit");
    					else
    						wc_nonfunded_proposed_noncons=wc_nonfunded_proposed_noncons+resultset1.getDouble("proposedlimit");
    				}
                }
                UpdateBankingdata(wc_funded_existing_cons,wc_funded_proposed_cons,wc_funded_existing_noncons,wc_funded_proposed_noncons,wc_nonfunded_existing_cons,
                wc_nonfunded_proposed_cons,wc_nonfunded_existing_noncons,wc_nonfunded_proposed_noncons,tl_funded_existing_cons,tl_funded_proposed_cons,
	    		tl_funded_existing_noncons,tl_funded_proposed_noncons,tl_nonfunded_existing_cons,tl_nonfunded_proposed_cons,tl_nonfunded_existing_noncons,
	    		tl_nonfunded_proposed_noncons,strAppno);
                /**end*/
	           
	           	hashmap1.put("strAppnoAccess",strAppno);
	           	hashmap1.put("checkFlagAccess","Y");
			}
        }
        catch(Exception exception)
        {
            log.error(exception.toString());
            throw new EJBException("Error in getData " + exception.toString());
        }
        finally
        {
	        try
	        {
	            if(resultset != null)
	                resultset.close();
	            if(statement1 != null)
	            	statement1.close();
	            if(resultset2 != null)
	                resultset2.close();
	            if(statement2 != null)
	            	statement2.close();
	             if(connection1!=null)
	            	 connection1.close();
	             
	             if(rs!=null)
	            	 rs.close();
	             boolean b=RemoteFileReader.removeFile(strFilelocation+"\\"+strFilename);
	             if(!b)
	            	 throw new Exception("Error in reading the file");
	        }
	        catch(Exception exception1)
	        {
	            throw new EJBException("Error closing the connection " + exception1.getMessage());
	        }
        } 
        
       
        return hashmap1;
    }
	

	
	
	
	
	private String getApplicantCode() throws Exception
	{
		String strAppCodeper="";
		String strAppCodecom="";
		String strAppCode="";
		ResultSet rs=null;
		try
		{ 
			rs=DBUtils.executeLAPSQuery("mastgetAppid");			 
			if(rs.next())
			{
				strAppCodeper=rs.getString(1);
			}
			/*rs=DBUtils.executeLAPSQuery("comappmastergetid");			 
			if(rs.next())
			{
				strAppCodecom=rs.getString(1);
			}
			if(Integer.parseInt(strAppCodeper)<Integer.parseInt(strAppCodecom))
				strAppCode=strAppCodecom;
			else*/
				strAppCode=strAppCodeper;
			
		}
		catch(Exception e)
		{
			throw e;
		}
		finally
		{
			if(rs!=null)
			{
				rs.close();				 
			}
		}
		return strAppCode;
	}
/**Update Banking arrangement-Our bank details*/	
	private void UpdateBankingdata(double wc_funded_existing_cons,double wc_funded_proposed_cons,double wc_funded_existing_noncons,double wc_funded_proposed_noncons,double wc_nonfunded_existing_cons,
			double wc_nonfunded_proposed_cons,double wc_nonfunded_existing_noncons,double wc_nonfunded_proposed_noncons,double tl_funded_existing_cons,double tl_funded_proposed_cons,
			double tl_funded_existing_noncons,double tl_funded_proposed_noncons,double tl_nonfunded_existing_cons,double tl_nonfunded_proposed_cons,double tl_nonfunded_existing_noncons,
			double tl_nonfunded_proposed_noncons,String strAppno)
	{
		
		ResultSet rs=null;
		ArrayList arrValues=new ArrayList();
	    HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
        String strId="";
		String checkid="";
		String strOverdue="";
		String strExcess="";
    	String strQuery="";
		
		int intUpdatesize=0;
		try
		{
			   
				
			if(!(wc_funded_existing_cons==0.0 && wc_funded_proposed_cons==0.0) || 
						!(wc_nonfunded_existing_cons==0.0 && wc_nonfunded_proposed_cons==0.0))
			{
				strQuery=SQLParser.getSqlQuery("sel_combanking_ourbank^"+strAppno+"^Y");
				rs=DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					strId=correctNull((String )rs.getString("combk_id"));
					strOverdue=correctNull((String )rs.getString("combk_overdue"));
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					intUpdatesize++;
					
					hshQueryValues.put("size",""+intUpdatesize);					
					hshQuery.put("strQueryId","combankingdelete");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String )strId));
					arrValues.add("W");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();							
					intUpdatesize++;
					
					hshQueryValues.put("size",""+intUpdatesize);
					hshQuery.put("strQueryId","combankinginsert1");
					arrValues.add(strAppno);
					arrValues.add(strId);
					arrValues.add("KBL");
					arrValues.add(""+wc_funded_existing_cons);
					arrValues.add(""+wc_funded_proposed_cons);
					arrValues.add(""+wc_nonfunded_existing_cons);
					arrValues.add(""+wc_nonfunded_proposed_cons);
					arrValues.add(correctNull((String )strOverdue));					
					arrValues.add("W");
					arrValues.add("0");
					arrValues.add("Our");
					arrValues.add("Y");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
				}
				else
				{
					strId = Integer.toString(getMaxGradeId(strAppno,"W"));
					checkid=strId;
					hshQuery = new HashMap();
					intUpdatesize++;
					arrValues=new ArrayList();
					
					hshQueryValues.put("size",""+intUpdatesize);
					hshQuery.put("strQueryId","combankinginsert1");
					arrValues.add(strAppno);
					arrValues.add(strId);
					arrValues.add("KBL");
					arrValues.add(""+wc_funded_existing_cons);
					arrValues.add(""+wc_funded_proposed_cons);
					arrValues.add(""+wc_nonfunded_existing_cons);
					arrValues.add(""+wc_nonfunded_proposed_cons);
					arrValues.add("");						
					arrValues.add("W");
					arrValues.add("0");
					arrValues.add("Our");
					arrValues.add("Y");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
				}
			}
			else
			{
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
						
				hshQueryValues.put("size",""+intUpdatesize);					
				hshQuery.put("strQueryId","delcombankingbyourbank");
				arrValues.add(strAppno);
				arrValues.add("Our");
				arrValues.add("W");
				arrValues.add("Y");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			
		if(!(wc_funded_existing_noncons==0.0 && wc_funded_proposed_noncons==0.0) || 
					!(wc_nonfunded_existing_noncons==0.0 && wc_nonfunded_proposed_noncons==0.0))
		{
			strQuery=SQLParser.getSqlQuery("sel_combanking_ourbank^"+strAppno+"^N");
			rs=DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				strId=correctNull((String )rs.getString("combk_id"));
				strOverdue=correctNull((String )rs.getString("combk_overdue"));
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
				
				hshQueryValues.put("size",""+intUpdatesize);					
				hshQuery.put("strQueryId","combankingdelete");
				arrValues.add(strAppno);
				arrValues.add(correctNull((String )strId));
				arrValues.add("W");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();	
				intUpdatesize++;
				
				hshQueryValues.put("size",""+intUpdatesize);
				hshQuery.put("strQueryId","combankinginsert1");
				arrValues.add(strAppno);
				arrValues.add(strId);
				arrValues.add("KBL");
				arrValues.add(""+wc_funded_existing_noncons);
				arrValues.add(""+wc_funded_proposed_noncons);
				arrValues.add(""+wc_nonfunded_existing_noncons);
				arrValues.add(""+wc_nonfunded_proposed_noncons);
				arrValues.add(correctNull((String )strOverdue));					
				arrValues.add("W");
				arrValues.add("0");
				arrValues.add("Our");
				arrValues.add("N");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
			}
			else
			{
				if(checkid.equals(""))
				{
					strId = Integer.toString(getMaxGradeId(strAppno,"W"));
				}
				else
				{
					strId=""+(Integer.parseInt(checkid)+1);
				}
			
				hshQuery = new HashMap();	
				arrValues=new ArrayList();
				intUpdatesize++;
				
				hshQueryValues.put("size",""+intUpdatesize);
				hshQuery.put("strQueryId","combankinginsert1");
				arrValues.add(strAppno);
				arrValues.add(strId);
				arrValues.add("KBL");
				arrValues.add(""+wc_funded_existing_noncons);
				arrValues.add(""+wc_funded_proposed_noncons);
				arrValues.add(""+wc_nonfunded_existing_noncons);
				arrValues.add(""+wc_nonfunded_proposed_noncons);
				arrValues.add("");						
				arrValues.add("W");
				arrValues.add("0");
				arrValues.add("Our");
				arrValues.add("N");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
		}
		else
		{
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			intUpdatesize++;
					
			hshQueryValues.put("size",""+intUpdatesize);					
			hshQuery.put("strQueryId","delcombankingbyourbank");
			arrValues.add(strAppno);
			arrValues.add("Our");
			arrValues.add("W");
			arrValues.add("N");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize,hshQuery);
		}
		checkid="";	
		if(!(tl_funded_existing_cons==0.0 && tl_funded_proposed_cons==0.0) ||
					!(tl_nonfunded_existing_cons==0.0 && tl_nonfunded_proposed_cons==0.0))
			{
				rs=DBUtils.executeLAPSQuery("sel_combanking_ourbank2^"+strAppno+"^Y");
				if (rs.next())
				{
					strId=correctNull((String )rs.getString("combk_id"));
					strOverdue=correctNull((String )rs.getString("combk_overdue"));
					strExcess=correctNull((String )rs.getString("combk_excess"));
					//strSecurity=correctNull((String )rs.getString("combk_security"));
					
					//1
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					intUpdatesize++;
									
					hshQueryValues.put("size","1");				
					hshQuery.put("strQueryId","combankingdelete");
					arrValues.add(strAppno);
					arrValues.add(strId);
					arrValues.add("T");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					//2
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					intUpdatesize++;
					
					hshQueryValues.put("size",""+intUpdatesize);						
					hshQuery.put("strQueryId","combankinginsert");
					arrValues.add(strAppno);
					arrValues.add(strId);
					arrValues.add("KBL");
					arrValues.add(""+tl_funded_existing_cons);
					arrValues.add(""+tl_funded_proposed_cons);
					arrValues.add(""+tl_nonfunded_existing_cons);
					arrValues.add(""+tl_nonfunded_proposed_cons);
					arrValues.add(correctNull((String )strOverdue));
					arrValues.add("T");
					arrValues.add(correctNull((String )strExcess));
					arrValues.add("0");
					arrValues.add("Our");
					arrValues.add("Y");
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);	
					
					//3
					/*hshQuery = new HashMap();
					arrValues=new ArrayList();
					intUpdatesize++;
					
					hshQueryValues.put("size",""+intUpdatesize);						
					hshQuery.put("strQueryId","combankingupd");				
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);*/	
						
				}
				else
				{
					strId = Integer.toString(getMaxGradeId(strAppno,"T"));
					checkid=strId;
					hshQuery = new HashMap();	
					arrValues=new ArrayList();
					intUpdatesize++;
					
					hshQueryValues.put("size",""+intUpdatesize);						
					hshQuery.put("strQueryId","combankinginsert");
					arrValues.add(strAppno);
					arrValues.add(strId);
					arrValues.add("KBL");
					arrValues.add(""+tl_funded_existing_cons);
					arrValues.add(""+tl_funded_proposed_cons);
					arrValues.add(""+tl_nonfunded_existing_cons);
					arrValues.add(""+tl_nonfunded_proposed_cons);
					arrValues.add("");
					arrValues.add("T");
					arrValues.add("");
					arrValues.add("0");
					arrValues.add("Our");
					arrValues.add("Y");
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					/*hshQuery = new HashMap();
					arrValues=new ArrayList();
					
					hshQueryValues.put("size",""+intUpdatesize);						
					hshQuery.put("strQueryId","combankingupd");				
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);*/	
				}
			}
			else
			{
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
				
				hshQueryValues.put("size",""+intUpdatesize);					
				hshQuery.put("strQueryId","delcombankingbyourbank");
				arrValues.add(strAppno);
				arrValues.add("Our");
				arrValues.add("T");
				arrValues.add("Y");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
		
		if(!(tl_funded_existing_noncons==0.0 && tl_funded_proposed_noncons==0.0) ||
				!(tl_nonfunded_existing_noncons==0.0 && tl_nonfunded_proposed_noncons==0.0))
		{
			rs=DBUtils.executeLAPSQuery("sel_combanking_ourbank2^"+strAppno+"^N");
			if (rs.next())
			{
				strId=correctNull((String )rs.getString("combk_id"));
				strOverdue=correctNull((String )rs.getString("combk_overdue"));
				strExcess=correctNull((String )rs.getString("combk_excess"));
				//strSecurity=correctNull((String )rs.getString("combk_security"));
				
				//1
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
								
						
				hshQuery.put("strQueryId","combankingdelete");
				arrValues.add(strAppno);
				arrValues.add(strId);
				arrValues.add("T");
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",""+intUpdatesize);		
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
				//2
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
				
									
				hshQuery.put("strQueryId","combankinginsert");
				arrValues.add(strAppno);
				arrValues.add(strId);
				arrValues.add("KBL");
				arrValues.add(""+tl_funded_existing_noncons);
				arrValues.add(""+tl_funded_proposed_noncons);
				arrValues.add(""+tl_nonfunded_existing_noncons);
				arrValues.add(""+tl_nonfunded_proposed_noncons);
				arrValues.add(correctNull((String )strOverdue));
				arrValues.add("T");
				arrValues.add(correctNull((String )strExcess));
				arrValues.add("0");
				arrValues.add("Our");
				arrValues.add("N");
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",""+intUpdatesize);	
				hshQueryValues.put(""+intUpdatesize,hshQuery);	
			}
			else
			{
				if(checkid.equals(""))
				{
					strId = Integer.toString(getMaxGradeId(strAppno,"T"));
				}
				else
				{
					strId=""+(Integer.parseInt(checkid)+1);
				}
			
				hshQuery = new HashMap();	
				arrValues=new ArrayList();
				intUpdatesize++;
				
								
				hshQuery.put("strQueryId","combankinginsert");
				arrValues.add(strAppno);
				arrValues.add(strId);
				arrValues.add("KBL");
				arrValues.add(""+tl_funded_existing_noncons);
				arrValues.add(""+tl_funded_proposed_noncons);
				arrValues.add(""+tl_nonfunded_existing_noncons);
				arrValues.add(""+tl_nonfunded_proposed_noncons);
				arrValues.add("");
				arrValues.add("T");
				arrValues.add("");
				arrValues.add("0");
				arrValues.add("Our");
				arrValues.add("N");
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",""+intUpdatesize);		
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
		}
		else
		{
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			intUpdatesize++;
			
			hshQuery.put("strQueryId","delcombankingbyourbank");
			arrValues.add(strAppno);
			arrValues.add("Our");
			arrValues.add("T");
			arrValues.add("N");
			
			hshQueryValues.put("size",""+intUpdatesize);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize,hshQuery);
		}
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
		}catch(Exception ex)
		{
			throw new EJBException("Error in UpdateBankData :: "+ex.toString());
		}
	}
	private int getMaxGradeId(String appno, String strLoantype)
	{
		ResultSet rs = null;
		int termId = 0;
		try
		{	
			rs=DBUtils.executeLAPSQuery("combankingmax^"+appno+"^"+strLoantype);
			
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
}
