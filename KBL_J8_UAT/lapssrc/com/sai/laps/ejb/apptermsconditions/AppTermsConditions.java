package com.sai.laps.ejb.apptermsconditions;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;

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
//@SuppressWarnings("unchecked")

@Stateless(name = "AppTermsConditions", mappedName = "AppTermsConditionsHome")
@Remote (AppTermsConditionsRemote.class)
public class AppTermsConditions extends BeanAdapter
{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(AppTermsConditions.class);	

	public int getMaxGradeId(String strStatId,String qry)
	{
		
		ResultSet rs = null;
		int termId = 0;

		try
		{	
			rs =DBUtils.executeLAPSQuery(qry + strStatId);
			
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
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return termId;
	}
	
			
	
	public HashMap getComFacilities(HashMap hshRequestValues) 
	{		
		ResultSet rs = null;
		ArrayList arrFacilities=new ArrayList();
		ArrayList arrFacilityId=new ArrayList();		
		HashMap hshRecord = new HashMap();
		String appno = Helper.correctNull((String)hshRequestValues.get("appno"));
		try
		{	
			hshRecord = new HashMap();			
			rs=DBUtils.executeLAPSQuery("selBorrowerFacilities^"+appno);
			while (rs.next())
			{  
				arrFacilityId.add(correctNull(rs.getString(1)+"^"+Helper.correctNull((String)rs.getString(3))));
				arrFacilities.add(correctNull(rs.getString(2)+" - " + Helper.correctNull((String)rs.getString(4))));
			}
			hshRecord.put("arrFacilities",arrFacilities);
			hshRecord.put("arrFacilityId",arrFacilityId);			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
		}
		finally
		{	
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap getComFacilityTermData(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ArrayList arrFacilityTerm=new ArrayList();
		ArrayList arrFacilityTermType=new ArrayList();
		ArrayList arrFacilityId=new ArrayList();
		ArrayList arrFacilityTermApp=new ArrayList();
		ArrayList arrFacilityTermTypeApp=new ArrayList();
		ArrayList arrFacilityIdApp=new ArrayList();	
		ArrayList arrFacilityTermStatus=new ArrayList();	
		ArrayList arrFacilityTermStatusapp=new ArrayList();
		ArrayList arrFacilityDoc=new ArrayList();
		HashMap hshRecord = new HashMap();
		HashMap hshValue=new HashMap();boolean res=false,res1=false;
		String strQuery="",strFacType="",appno="",mode="",generalCond="",appStatus="",termType="",srModuleType="",strQuery1="";
		ArrayList arrFacilityPrepost=new ArrayList();
		ArrayList arrParentID=new ArrayList();
		ArrayList arrParentIDApp=new ArrayList();
		int strPatentid=0;
		String strFacCode="";
		String strQuery2="";
		String facility_proposed="";
		double sumoffacility=0;
		HashMap hshRecords = new HashMap();
		HashMap hshValues=new HashMap();
		ArrayList arrvaluess=new ArrayList();
		String checkforshgpro="";
		try
		{	
			hshRecord = new HashMap();
			appno = correctNull((String)hshRequestValues.get("appno"));
			generalCond = correctNull((String)hshRequestValues.get("general"));
			appStatus=correctNull((String)hshRequestValues.get("appstatus"));	
			String strFacsno = correctNull((String)hshRequestValues.get("seltermid"));
			srModuleType=correctNull((String)hshRequestValues.get("sessionModuleType"));
			String strPrePost = correctNull((String)hshRequestValues.get("sel_prepost"));
			if(strPrePost.equalsIgnoreCase(""))
				strPrePost = Helper.correctInt((String)hshRequestValues.get("hidprepost"));
			
			hshRecord.put("strPrePost",strPrePost);
			if(appStatus.equalsIgnoreCase(""))
			{
				appStatus=correctNull((String)hshRequestValues.get("appStatus"));	
			}
			
			if(strFacsno.equals("0"))
				mode="G";
			/*Adding Other Terms & Conditions so facility sno need here to pass so that we gave  99.
			why because for Single Application max 10 facilities will add */
			else if(strFacsno.equals("99")){
				mode="O";
			}
			else if(strFacsno.equals("98")){
				mode="B";
			}
			else if(strFacsno.equals("97")){
				mode="P";
			}
			else{
				mode="S";
			}
			if(srModuleType.equalsIgnoreCase("CORP")){
				srModuleType="C";
			}else if (srModuleType.equalsIgnoreCase("AGR")){
				srModuleType="A";
			}else{
				srModuleType="";
			}
			
			//Newly added Terms & Condition Updation
			if(Helper.correctNull((String)hshRequestValues.get("strappstatus")).equalsIgnoreCase("op"))
			{
				ArrayList arrAvail=new ArrayList();
				ArrayList arrValues=new ArrayList();
				HashMap hshQueryValues=new HashMap();
				HashMap hshQuery=new HashMap();
				int intSize=0,appterms=0;
				
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_termsandcondcorp^"+appno);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrAvail.add(Helper.correctNull(rs.getString("terms_mode"))+"~"+Helper.correctNull(rs.getString("terms_id")));
				}
				if(srModuleType.equalsIgnoreCase("A"))
				{
					 if(rs!=null){
							rs.close();
						}
				       strQuery = SQLParser.getSqlQuery("checkforblockprocesscharges^"+appno);
				       rs= DBUtils.executeQuery(strQuery);
						if (rs.next()){
							
							strQuery2 = SQLParser.getSqlQuery("getsecuritysumofvalue^"+appno);
							rs2 = DBUtils.executeQuery(strQuery2);
				    		if(rs2.next())
							{
				    			facility_proposed=Helper.correctNull((String)rs2.getString("FACILITY_PROPOSED"));
				    			sumoffacility=Double.parseDouble(facility_proposed);
				    			if(sumoffacility<=2000000)
								{
					    		hshRecord.put("sumoffacility","Y");
					    		checkforshgpro="Y";
								}
					    		else
					    		{
					    		hshRecord.put("sumoffacility","N");
					    		checkforshgpro="N";
					    		}
							}
						}
					
				
	    		else
	    		{
	    			hshRecord.put("sumoffacility","N");
	    			checkforshgpro="N";
	    		}
	    	    
				}
				if(rs!=null)
				{
					rs.close();
				}
				//vindhya begin
				///
				String strLoanType="";
				rs	= DBUtils.executeLAPSQuery("sel_appstatus^"+appno);
				if(rs.next())
				{
					strLoanType=Helper.correctNull((String)rs.getString("app_loantype"));
					strLoanType=strLoanType.toLowerCase();
				}
				if(rs !=null)
				{
					rs.close();
				}
				if(strLoanType.equalsIgnoreCase("A")||strLoanType.equalsIgnoreCase("C"))
				{
				 if(rs!=null){
							rs.close();
						}
					
					strQuery = SQLParser.getSqlQuery("get_distinctfacilitycode^"+appno);
					rs=DBUtils.executeQuery(strQuery);
					while (rs.next()) {
						strQuery2=SQLParser.getSqlQuery("getselectedterms^"+srModuleType+"^"+correctNull(rs.getString("facility_code"))); //terms and conditions changes
						rs2=DBUtils.executeQuery(strQuery2);
						while(rs2.next())
						{
							if(!arrAvail.contains(correctNull(rs2.getString("fac_mode"))+"~"+correctNull(rs2.getString("FAC_SNO"))))
							{
								hshQueryValues.put("size",String.valueOf(++intSize));
								hshQuery=new HashMap();
								//hshQuery.put("strQueryId","insfacterms");
								hshQuery.put("strQueryId","insfacterms_new");
								arrValues=new ArrayList();
								arrValues.add(appno);
								arrValues.add("");
								arrValues.add("");
								arrValues.add(srModuleType);
								arrValues.add(correctNull(rs2.getString("FAC_SNO")));
								arrValues.add(correctNull(rs2.getString("fac_terms")));
								//arrValues.add("P");
								arrValues.add("A");
								arrValues.add("N");
								arrValues.add("");
								//arrValues.add("N");
								arrValues.add("Y");
								arrValues.add(correctNull(rs2.getString("fac_prepost")));
								arrValues.add(correctNull(rs2.getString("fac_mode")));
								arrValues.add(correctNull(rs2.getString("FAC_PARENT_ID")));
								arrValues.add("N"); //vindhya
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put(String.valueOf(intSize),hshQuery);
							}
						}
						if(rs2!=null)
						{
							rs2.close();
						}
					}
				}
				
				/*
				strQuery=SQLParser.getSqlQuery("sel_setuptermandcond^"+srModuleType); //terms and conditions changes
				
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					if(!arrAvail.contains(correctNull(rs.getString("fac_mode"))+"~"+correctNull(rs.getString("FAC_SNO"))))
					{
						hshQueryValues.put("size",String.valueOf(++intSize));
						hshQuery=new HashMap();
						hshQuery.put("strQueryId","insfacterms");
						arrValues=new ArrayList();
						arrValues.add(appno);
						arrValues.add("");
						arrValues.add("");
						arrValues.add(srModuleType);
						arrValues.add(correctNull(rs.getString("FAC_SNO")));
						arrValues.add(correctNull(rs.getString("fac_terms")));
						arrValues.add("P");
						arrValues.add("N");
						arrValues.add("");
						arrValues.add("N");
						arrValues.add(correctNull(rs.getString("fac_prepost")));
						arrValues.add(correctNull(rs.getString("fac_mode")));
						arrValues.add(correctNull(rs.getString("FAC_PARENT_ID")));
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intSize),hshQuery);
					}
				}*/
				if(rs!=null)
				{
					rs.close();
				}
				//strQuery=SQLParser.getSqlQuery("sel_setuptermandcond1^"+appno);
				strQuery=SQLParser.getSqlQuery("get_setupterfacmandcond1^"+appno); 				
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					if(!arrAvail.contains(correctNull(rs.getString("fac_mode"))+"~"+correctNull(rs.getString("FAC_SNO"))))
					{
						hshQueryValues.put("size",String.valueOf(++intSize));
						hshQuery=new HashMap();
						//hshQuery.put("strQueryId","insfacterms");
						hshQuery.put("strQueryId","insfacterms_new");
						arrValues=new ArrayList();
						arrValues.add(appno);
						arrValues.add(correctNull(rs.getString("facility_sno")));
						arrValues.add(correctNull(rs.getString("facility_code")));
						arrValues.add(srModuleType);
						arrValues.add(correctNull(rs.getString("FAC_SNO")));
						arrValues.add(correctNull(rs.getString("fac_terms")));
						//arrValues.add("P");
						arrValues.add("A");
						arrValues.add("N");
						arrValues.add("");
						//arrValues.add("N");
						arrValues.add("Y");
						arrValues.add(correctNull(rs.getString("fac_prepost")));
						arrValues.add(correctNull(rs.getString("fac_mode")));
						arrValues.add(correctNull(rs.getString("FAC_PARENT_ID")));
						arrValues.add("N"); //vindhya
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intSize),hshQuery);
					}
				}
				if(intSize>0)
				{
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				if(srModuleType.equalsIgnoreCase("A"))
				{
				if(sumoffacility<=2000000 && checkforshgpro.equalsIgnoreCase("Y"))
				{
					hshRecord.put("Auto_security_type_of_Branch","Y");
					hshValues=new HashMap();
					hshRecords = new HashMap();
					arrvaluess=new ArrayList();
					hshValues.put("size","1");
					hshRecords.put("strQueryId","update_com_termscond_for_Y");
					arrvaluess.add(appno);
					hshRecords.put("arrValues",arrvaluess);
					hshValues.put("1",hshRecords);
					EJBInvoker.executeStateLess("dataaccess",hshValues,"updateData");
				}
				else
				{
					hshRecord.put("Auto_security_type_of_Branch","N");
					hshValues=new HashMap();
					hshRecords = new HashMap();
					arrvaluess=new ArrayList();
					hshValues.put("size","1");
					hshRecords.put("strQueryId","update_com_termscond_for_N");
					arrvaluess.add(appno);
					hshRecords.put("arrValues",arrvaluess);
					hshValues.put("1",hshRecords);
					EJBInvoker.executeStateLess("dataaccess",hshValues,"updateData");
					
				}
				}
				
			}
			
			arrFacilityTerm=new ArrayList();
			arrFacilityTermType=new ArrayList();
			arrFacilityId=new ArrayList();
			arrFacilityTermStatus=new ArrayList();
			arrFacilityPrepost=new ArrayList();
			arrFacilityDoc=new ArrayList();
			
			if(!strFacsno.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("select_facilityCode^"+appno+"^"+strFacsno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next()){
				strFacCode=Helper.correctNull((String)rs.getString("facility_code"));
				}
			}
			if(!strFacCode.equalsIgnoreCase("")){
				
				if(rs!=null)rs.close();
				termType="P";
				strQuery = SQLParser.getSqlQuery("selcomfacilityterms_Fac^"+strFacCode+"^"+appno+"^"+termType+"^"+mode+"^"+srModuleType+"^"+"0^"+strFacsno);
				rs=DBUtils.executeQuery(strQuery);
				boolean boolresultflag=rs.next();
				if(boolresultflag)
				{  
					do{
					arrFacilityTerm.add(correctNull(rs.getString(1)));
					arrFacilityTermType.add(correctNull(rs.getString(2)));
					arrFacilityId.add(correctNull(rs.getString(3)));
					arrFacilityTermStatus.add(correctNull(rs.getString(4)));
					arrParentID.add(correctNull(rs.getString(5)));
					arrFacilityDoc.add(correctNull(rs.getString(6)));
					strPatentid=Integer.parseInt(Helper.correctInt((String)rs.getString(3)));
					
					strQuery1 = SQLParser.getSqlQuery("selcomfacilityterms_Fac1^"+strFacCode+"^"+appno+"^"+mode+"^"+srModuleType+"^"+strPatentid+"^"+strFacsno);
					rs1=DBUtils.executeQuery(strQuery1);
					while(rs1.next())
					{
						arrFacilityTerm.add(correctNull(rs1.getString(1)));
						arrFacilityTermType.add(correctNull(rs1.getString(2)));
						arrFacilityId.add(correctNull(rs1.getString(3)));
						arrFacilityTermStatus.add(correctNull(rs1.getString(4)));
						arrParentID.add(correctNull(rs1.getString(5)));
						arrFacilityDoc.add(correctNull(rs1.getString(6)));
					}
					if(rs1 != null)
						rs1.close();
					
					}while(rs.next());
				}
				hshRecord.put("arrFacilityTerm",arrFacilityTerm);
				hshRecord.put("arrFacilityTermType",arrFacilityTermType);
				hshRecord.put("arrFacilityIdVal",arrFacilityId);
				hshRecord.put("arrFacilityId",strFacsno);
				hshRecord.put("arrFacilityTermStatus",arrFacilityTermStatus);
				hshRecord.put("arrParentID",arrParentID);
				hshRecord.put("arrFacilityDoc",arrFacilityDoc);
				
				if(rs!=null)rs.close();
				termType="A";
				strQuery = SQLParser.getSqlQuery("selcomfacilityterms_Fac^"+strFacCode+"^"+appno+"^"+termType+"^"+mode+"^"+srModuleType+"^"+"0^"+strFacsno);
				rs=DBUtils.executeQuery(strQuery);
				while (rs.next())
				{  
					arrFacilityTermApp.add(correctNull(rs.getString(1)));
					arrFacilityTermTypeApp.add(correctNull(rs.getString(2)));
					arrFacilityIdApp.add(correctNull(rs.getString(3)));	
					arrFacilityTermStatusapp.add(correctNull(rs.getString(4)));
					arrFacilityDoc.add(correctNull(rs.getString(6)));
					arrParentIDApp.add(correctNull(rs.getString(5)));
					strPatentid=Integer.parseInt(Helper.correctInt((String)rs.getString(3)));
					
					strQuery1 = SQLParser.getSqlQuery("selcomfacilityterms_Fac1^"+strFacCode+"^"+appno+"^"+mode+"^"+srModuleType+"^"+strPatentid+"^"+strFacsno);
					rs1=DBUtils.executeQuery(strQuery1);
					while(rs1.next())
					{
						arrFacilityTermApp.add(correctNull(rs1.getString(1)));
						arrFacilityTermTypeApp.add(correctNull(rs1.getString(2)));
						arrFacilityIdApp.add(correctNull(rs1.getString(3)));
						arrFacilityTermStatusapp.add(correctNull(rs1.getString(4)));
						arrFacilityDoc.add(correctNull(rs1.getString(6)));
						arrParentIDApp.add(correctNull(rs1.getString(5)));
					}
					if(rs1 != null)
						rs1.close();
				}
		
				hshRecord.put("arrFacilityTermApp",arrFacilityTermApp);
				hshRecord.put("arrFacilityTermTypeApp",arrFacilityTermTypeApp);
				hshRecord.put("arrFacilityIdAppVal",arrFacilityIdApp);	
				hshRecord.put("arrFacilityTermStatusapp",arrFacilityTermStatusapp);
				hshRecord.put("arrFacilityDoc",arrFacilityDoc);
				hshRecord.put("arrParentIDApp",arrParentIDApp);
				
			}else{
				
				if(rs!=null)rs.close();
				termType="P";
				if(mode.equalsIgnoreCase("B") || mode.equalsIgnoreCase("P") || mode.equalsIgnoreCase("O"))
				{
					strQuery = SQLParser.getSqlQuery("sel_Specifidtermsconditions_application^"+appno+"^"+termType+"^"+mode+"^"+srModuleType+"^"+"0");	
				}
				else
				{
					strQuery = SQLParser.getSqlQuery("selcomfacilitygeneralterms^"+appno+"^"+termType+"^"+strPrePost+"^"+mode+"^"+srModuleType+"^"+"0");	
				}
				rs=DBUtils.executeQuery(strQuery);
				boolean boolresultflag=rs.next();
				if(boolresultflag)
				{  
					do{
					arrFacilityTerm.add(correctNull(rs.getString(1)));
					arrFacilityTermType.add(correctNull(rs.getString(2)));
  					arrFacilityId.add(correctNull(rs.getString(3)));
					arrFacilityTermStatus.add(correctNull(rs.getString(4)));
					arrParentID.add(correctNull(rs.getString(5)));
					arrFacilityDoc.add(correctNull(rs.getString(6)));
					strPatentid=Integer.parseInt(Helper.correctInt((String)rs.getString(3)));
					
					if(mode.equalsIgnoreCase("B") || mode.equalsIgnoreCase("P") || mode.equalsIgnoreCase("O"))
					{
						strQuery1 = SQLParser.getSqlQuery("sel_Specifidtermsconditions_application1^"+appno+"^"+mode+"^"+srModuleType+"^"+strPatentid);	
					}
					else
					{
						strQuery1 = SQLParser.getSqlQuery("selcomfacilitygeneralterms1^"+appno+"^"+strPrePost+"^"+mode+"^"+srModuleType+"^"+strPatentid);	
					}
					rs1=DBUtils.executeQuery(strQuery1);
					while(rs1.next()){
						arrFacilityTerm.add(correctNull(rs1.getString(1)));
						arrFacilityTermType.add(correctNull(rs1.getString(2)));
						arrFacilityId.add(correctNull(rs1.getString(3)));
						arrFacilityTermStatus.add(correctNull(rs1.getString(4)));
						arrParentID.add(correctNull(rs1.getString(5)));
						arrFacilityDoc.add(correctNull(rs1.getString(6)));
					}
					if(rs1 != null)
						rs1.close();
					
					}while(rs.next());
				}
				hshRecord.put("arrFacilityTerm",arrFacilityTerm);
				hshRecord.put("arrFacilityTermType",arrFacilityTermType);
				hshRecord.put("arrFacilityIdVal",arrFacilityId);
				hshRecord.put("arrFacilityId",strFacsno);
				hshRecord.put("arrFacilityTermStatus",arrFacilityTermStatus);
				hshRecord.put("arrParentID",arrParentID);
				hshRecord.put("arrFacilityDoc",arrFacilityDoc);
				if(rs!=null)rs.close();
				termType="A";
				if(mode.equalsIgnoreCase("B") || mode.equalsIgnoreCase("P") || mode.equalsIgnoreCase("O"))
				{
					strQuery = SQLParser.getSqlQuery("sel_Specifidtermsconditions_application^"+appno+"^"+termType+"^"+mode+"^"+srModuleType+"^"+"0");	
				}
				else
				{
					strQuery = SQLParser.getSqlQuery("selcomfacilitygeneralterms^"+appno+"^"+termType+"^"+strPrePost+"^"+mode+"^"+srModuleType+"^"+"0");	
				}
				rs=DBUtils.executeQuery(strQuery);
				while (rs.next())
				{  
					arrFacilityTermApp.add(correctNull(rs.getString(1)));
					arrFacilityTermTypeApp.add(correctNull(rs.getString(2)));
					arrFacilityIdApp.add(correctNull(rs.getString(3)));	
					arrFacilityTermStatusapp.add(correctNull(rs.getString(4)));
					arrFacilityDoc.add(correctNull(rs.getString(6)));
					arrParentIDApp.add(correctNull(rs.getString(5)));
					
					strPatentid=Integer.parseInt(Helper.correctInt((String)rs.getString(3)));
					
					if(mode.equalsIgnoreCase("B") || mode.equalsIgnoreCase("P") || mode.equalsIgnoreCase("O"))
					{
						strQuery1 = SQLParser.getSqlQuery("sel_Specifidtermsconditions_application1^"+appno+"^"+mode+"^"+srModuleType+"^"+strPatentid);	
					}
					else
					{
						strQuery1 = SQLParser.getSqlQuery("selcomfacilitygeneralterms1^"+appno+"^"+strPrePost+"^"+mode+"^"+srModuleType+"^"+strPatentid);	
					}
					rs1=DBUtils.executeQuery(strQuery1);
					while(rs1.next()){
						arrFacilityTermApp.add(correctNull(rs1.getString(1)));
						arrFacilityTermTypeApp.add(correctNull(rs1.getString(2)));
						arrFacilityIdApp.add(correctNull(rs1.getString(3)));
						arrFacilityTermStatusapp.add(correctNull(rs1.getString(4)));
						arrFacilityDoc.add(correctNull(rs1.getString(6)));
						arrParentIDApp.add(correctNull(rs1.getString(5)));
					}
					if(rs1 != null)
						rs1.close();
				}
		
				hshRecord.put("arrFacilityTermApp",arrFacilityTermApp);
				hshRecord.put("arrFacilityTermTypeApp",arrFacilityTermTypeApp);
				hshRecord.put("arrFacilityIdAppVal",arrFacilityIdApp);	
				hshRecord.put("arrFacilityTermStatusapp",arrFacilityTermStatusapp);
				hshRecord.put("arrFacilityDoc",arrFacilityDoc);
				hshRecord.put("arrParentIDApp",arrParentIDApp);
				
			}			
			
			//To get the GECL facility
			strQuery = SQLParser.getSqlQuery("chk_geclfacchk^"+appno);
			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(Helper.correctNull(rs.getString("com_bankscheme")).equalsIgnoreCase("061"))
					hshRecord.put("strgeclavailable","Y");	
				hshRecord.put("strgecltype",correctNull(rs.getString("com_gecltype")));	
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
		}
		finally
		{	
			try
			{	
				if(rs != null)
					rs.close();
				
				if(rs1 != null)
					rs1.close();
				if(rs2!=null)
				{
					rs2.close();
				}
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}

	public void updateComFacilityTermData(HashMap hshRequestValues) 
	{		
		try
		{
			//Terms & Conditions Modified by Venkat Prasad Chowdary Mullamuri
			HashMap hshQueryValues = new HashMap();
			HashMap hshQuery = new HashMap();
			ArrayList arrValues = new ArrayList();
			String[] strchkstatus = null;
			String[] strhidtermsdesc=null;
			String[] strtermscode=null;
			String[] strTermsType=null;
			String[] strSupportDoc=null;
			ResultSet resulSet=null;
			String strFacCode="";
			ResultSet rs=null;
			String strAction = correctNull((String)hshRequestValues.get("hidAction"));
			String strAppno=Helper.correctNull((String)hshRequestValues.get("appno"));
			String strFacSno = Helper.correctNull((String)hshRequestValues.get("seltermid"));
			String termid = Helper.correctNull((String)hshRequestValues.get("hidtermid"));
			//strTermsType = ((String[])hshRequestValues.get("hidtermtype"));
			if(hshRequestValues.get("hidtermtype") instanceof java.lang.String)
			{
				strTermsType= new String[1];
				strTermsType[0]=(String)hshRequestValues.get("hidtermtype");
			}
			else
			{
				strTermsType=(String[])hshRequestValues.get("hidtermtype");
			}
			String strtermdesc=Helper.correctNull((String)hshRequestValues.get("txttrmdesc"));
			String strtermscode1=Helper.correctNull((String)hshRequestValues.get("hidtermid"));
			String strtermtype1=Helper.correctNull((String)hshRequestValues.get("hidterms"));	
			String strDocUpload1=Helper.correctNull((String)hshRequestValues.get("sel_req"));
						
			//strtermscode=(String[])hshRequestValues.get("doc_code");
			if(hshRequestValues.get("doc_code") instanceof java.lang.String)
			{
				strtermscode= new String[1];
				strtermscode[0]=(String)hshRequestValues.get("doc_code");
			}
			else
			{
				strtermscode=(String[])hshRequestValues.get("doc_code");
			}
			//strhidtermsdesc=(String[])hshRequestValues.get("hidText");
			if(hshRequestValues.get("hidText") instanceof java.lang.String)
			{
				strhidtermsdesc= new String[1];
				strhidtermsdesc[0]=(String)hshRequestValues.get("hidText");
			}
			else
			{
				strhidtermsdesc=(String[])hshRequestValues.get("hidText");
			}
			//strchkstatus=(String[])hshRequestValues.get("doc_chkstatus");
			if(hshRequestValues.get("doc_chkstatus") instanceof java.lang.String)
			{
				strchkstatus= new String[1];
				strchkstatus[0]=(String)hshRequestValues.get("doc_chkstatus");
			}
			else
			{
				strchkstatus=(String[])hshRequestValues.get("doc_chkstatus");
			}
			if(hshRequestValues.get("sel_DocUpload") instanceof java.lang.String)
			{
				strSupportDoc= new String[1];
				strSupportDoc[0]=(String)hshRequestValues.get("sel_DocUpload");
			}
			else
			{
				strSupportDoc=(String[])hshRequestValues.get("sel_DocUpload");
			}
			String strPrePost = correctNull((String)hshRequestValues.get("sel_prepost"));
			if(strPrePost.equalsIgnoreCase(""))
				strPrePost = correctNull((String)hshRequestValues.get("hidprepost"));
			
			String strMode="";
			if(strFacSno.equals("0"))
				strMode="G";
			else if(strFacSno.equals("99"))
				strMode="O";
			else if(strFacSno.equals("97"))
				strMode="P";
			else if(strFacSno.equals("98"))
				strMode="B";
			else 
				strMode="S";
			
			String strFacType=correctNull((String)hshRequestValues.get("sessionModuleType"));
			if(strFacType.equalsIgnoreCase("CORP")){
				strFacType="C";
			}else if(strFacType.equalsIgnoreCase("AGR")){
				strFacType="A";
			}else{
				strFacType="";
			}
			if(resulSet !=null){
				resulSet.close();
			}
			resulSet = DBUtils.executeLAPSQuery("select_facilityCode^"+strAppno+"^"+strFacSno);
			if(resulSet.next()){
				strFacCode=correctNull((String)resulSet.getString("facility_code"));
			}
			if(strAction.equals("insert"))
			{
				termid = Integer.toString(getTermId(hshRequestValues,"Corporate"));
				hshQueryValues.put("size","1");
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","comtermscondins");
				arrValues=new ArrayList();
				arrValues.add(strAppno);				
				arrValues.add(strFacCode);
				arrValues.add(strFacType);
				arrValues.add(termid);
				arrValues.add((String)hshRequestValues.get("txttrmdesc"));
				arrValues.add("A");
				arrValues.add("N");
				arrValues.add("Y");
				arrValues.add(strFacSno);
				arrValues.add(strPrePost);
				arrValues.add(strMode);
				arrValues.add("0");
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_req")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);

				//hshQuery=new HashMap();
				//arrValues=new ArrayList();
				hshQueryValues.put("size","1");
		
				//for Entering the values into auditrial
	
				/*String  strActionData= "Facilities="+strFacSno+"~Terms Description="+correctNull((String)hshRequestValues.get("txttrmdesc"))+
				"~Terms Type =A";	
				hshQuery.put("strQueryId","audittrial");
				arrValues.add("79");
				arrValues.add(correctNull((String)hshRequestValues.get("strUserId")));
				arrValues.add(correctNull((String)hshRequestValues.get("strClientIP")));
				arrValues.add(strAppno);
				arrValues.add(strActionData);			
				arrValues.add("Insert");			
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	*/
			}
			else if(strAction.equals("update"))
			{
				termid = Integer.toString(getTermId(hshRequestValues,"Corporate"));
				hshQueryValues.put("size","1");
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","comtermscondins");
				arrValues=new ArrayList();
				arrValues.add(strAppno);				
				arrValues.add(strFacCode);
				arrValues.add(strFacType);
				arrValues.add(termid);
				arrValues.add((String)hshRequestValues.get("txttrmdesc"));
				arrValues.add("A");
				arrValues.add("N");
				arrValues.add("Y");
				arrValues.add(strFacSno);
				arrValues.add(strPrePost);
				arrValues.add(strMode);
				arrValues.add("0");
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_req")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);

				//hshQuery=new HashMap();
				//arrValues=new ArrayList();
				hshQueryValues.put("size","1");
		
				//for Entering the values into auditrial
	
				/*String  strActionData= "Facilities="+strFacSno+"~Terms Description="+correctNull((String)hshRequestValues.get("txttrmdesc"))+
				"~Terms Type =A";	
				hshQuery.put("strQueryId","audittrial");
				arrValues.add("79");
				arrValues.add(correctNull((String)hshRequestValues.get("strUserId")));
				arrValues.add(correctNull((String)hshRequestValues.get("strClientIP")));
				arrValues.add(strAppno);
				arrValues.add(strActionData);			
				arrValues.add("Insert");			
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);*/
				
				
			}
			else if(strAction.equals("change"))
			{
				termid = Integer.toString(getTermId(hshRequestValues,"Corporate"));
				hshQueryValues.put("size","1");
				hshQuery=new HashMap();
				if(strFacCode.equalsIgnoreCase("")){
					hshQuery.put("strQueryId","comtermscondupdate");
					arrValues.add(strtermdesc);
					arrValues.add("Y");
					arrValues.add(strDocUpload1);
					arrValues.add(strAppno);
					arrValues.add(strtermscode1);
					arrValues.add(strMode);
					arrValues.add(strFacType);
				}else{
				hshQuery.put("strQueryId","comtermscondupd_facility");
				arrValues.add(strtermdesc);
				arrValues.add("Y");
				arrValues.add(strDocUpload1);
				arrValues.add(strAppno);
				arrValues.add(strtermscode1);
				arrValues.add(strMode);
				arrValues.add(strFacType);
				arrValues.add(strFacCode);
				arrValues.add(strFacSno);
				}
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);

				//hshQuery=new HashMap();
			//	arrValues=new ArrayList();
				hshQueryValues.put("size","1");
		
				//for Entering the values into auditrial
	
				/*String  strActionData= "Facilities="+strFacSno+"~Terms Description="+correctNull((String)hshRequestValues.get("txttrmdesc"))+
				"~Terms Type =A";	
				hshQuery.put("strQueryId","audittrial");
				arrValues.add("79");
				arrValues.add(correctNull((String)hshRequestValues.get("strUserId")));
				arrValues.add(correctNull((String)hshRequestValues.get("strClientIP")));
				arrValues.add(strAppno);
				arrValues.add(strActionData);			
				arrValues.add("Insert");			
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);*/
				
				
			}
			else if(strAction.equals("select"))
			{
				hshQueryValues.put("size","1");
				hshQuery=new HashMap();
				for(int i=0;i<strhidtermsdesc.length;i++)
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					hshQuery.put("strQueryId","comtermscondupd");
					arrValues.add(strhidtermsdesc[i]);
					arrValues.add(strchkstatus[i]);
					arrValues.add(strSupportDoc[i]);
					arrValues.add(strAppno);
					arrValues.add(strtermscode[i]);
					arrValues.add(strMode);
					arrValues.add(strFacType);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				}
				/*hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				String  strActionData= "Facilities="+strFacSno+"~Terms Description="+correctNull((String)hshRequestValues.get("txttrmdesc"))+
				"~Terms Type =A";
				hshQuery.put("strQueryId","audittrial");
				arrValues.add("79");
				arrValues.add(correctNull((String)hshRequestValues.get("strUserId")));
				arrValues.add(correctNull((String)hshRequestValues.get("strClientIP")));
				arrValues.add(strAppno);
				arrValues.add(strActionData);			
				arrValues.add("Update");			
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);		*/
			}
			else if(strAction.equals("delete"))
			{			
				String termremarks = correctNull((String)hshRequestValues.get("hidcomments"));
				hshQueryValues.put("size","1");
				hshQuery=new HashMap();
				
				arrValues=new ArrayList();
				if(strFacCode.equalsIgnoreCase(""))
				{
					if ((strtermtype1.equals("A"))||(strtermtype1.equals("P")))
					{
						hshQuery.put("strQueryId","comtermsconddel1");
						arrValues.add("Y");
						arrValues.add(termremarks);
					}
					arrValues.add(strAppno);
					arrValues.add(termid);
					arrValues.add(strMode);
				}
				else
				{
					if ((strtermtype1.equals("A"))||(strtermtype1.equals("P")))
					{
						hshQuery.put("strQueryId","comtermsconddel1_facility");
						arrValues.add("Y");
						arrValues.add(termremarks);
					}
					arrValues.add(strAppno);
					arrValues.add(termid);
					arrValues.add(strMode);
					arrValues.add(strFacSno);
				}
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				//hshQuery=new HashMap();
				//arrValues=new ArrayList();
				hshQueryValues.put("size","1");
		
				//for Entering the values into auditrial

				/*String  strActionData= "Facilities="+strFacSno+"~Terms Description="+correctNull((String)hshRequestValues.get("txttrmdesc"))+				
				"~Terms Type ="+strTermsType+"~Remarks  ="+termremarks;		
			
				hshQuery.put("strQueryId","audittrial");
				arrValues.add("79");
				arrValues.add(correctNull((String)hshRequestValues.get("strUserId")));
				arrValues.add(correctNull((String)hshRequestValues.get("strClientIP")));
				arrValues.add(strAppno);
				arrValues.add(strActionData);			
				arrValues.add("Delete");			
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);*/
			}
			else if(strAction.equals("undelete"))
			{
				String strLoanType = correctNull((String)hshRequestValues.get("hidLoanType"));
				String strTermId = Helper.correctNull((String)hshRequestValues.get("rdtermid"));
				hshQueryValues.put("size","1");
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				if(strFacCode.equalsIgnoreCase(""))
				{
					if(strLoanType.equals("Corporate"))
					{
						hshQuery.put("strQueryId","undeleteterms2");
						arrValues.add(strTermId);
						arrValues.add(strAppno);
						arrValues.add(strMode);
					}
				}
				else
				{
					if(strLoanType.equals("Corporate"))
					{
						hshQuery.put("strQueryId","undeleteterms2_facility");
						arrValues.add(strTermId);
						arrValues.add(strAppno);
						arrValues.add(strMode);
						arrValues.add(strFacSno);
					}
				}
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			/*	hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","2");		
				//for Entering the values into auditrial
				String  strActionData=  "Facilities="+strFacSno+			
				"~Terms Type ="+strTermsType;
				hshQuery.put("strQueryId","audittrial");
				arrValues.add("80");
				arrValues.add(correctNull((String)hshRequestValues.get("strUserId")));
				arrValues.add(correctNull((String)hshRequestValues.get("strClientIP")));
				arrValues.add(strAppno);
				arrValues.add(strActionData);			
				arrValues.add("UnDelete");			
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	*/
			}
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("sel_corptermandcond^"+strAppno);
			if(rs.next())
			{
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","upd_apptermflag");
				arrValues=new ArrayList();
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
		}		
	}
	
	
	public void UndeleteTermsData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		
		String strAction = correctNull((String)hshValues.get("hidAction"));
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strTermId = Helper.correctNull((String)hshValues.get("rdtermid"));
		
		try{
			
			hshQueryValues.put("size","1");
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			
			if(strAction.equals("undelete"))
			{
				hshQuery.put("strQueryId","undeleteterms1");
				arrValues.add(strTermId);
				arrValues.add(strAppno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
		}catch(Exception ex)
		{
			throw new EJBException(ex.toString());
		}
	}

	private HashMap getTokens(HashMap hshRequestValues)
	{
		HashMap hshRecord = new HashMap();
		try
		{
			String strseldata = Helper.correctNull((String)hshRequestValues.get("seltermid"));
			if(!strseldata.equals(""))
			{
				StringTokenizer st = new StringTokenizer(strseldata,"^");
				String strFacId = st.nextToken();
				String strFacType = st.nextToken();
				hshRecord.put("strToken1",strFacId);
				hshRecord.put("strToken2",strFacType);
			}
		}
		catch(Exception e)
		{
			throw new EJBException(e.toString());
		}
		return hshRecord;
	}
	
	public HashMap getTerms(HashMap hshValues)
	{	
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		String strAppno ="";
		String strQuery="";
		//strAppno = Helper.correctNull((String)hshValues.get("appno1"));		
		if(strAppno.equalsIgnoreCase(""))
		{
			strAppno = Helper.correctNull((String)hshValues.get("appno"));
		}
		//This condition is used for only dynamicTabs
		if(strAppno.equalsIgnoreCase(""))
		{
			strAppno = Helper.correctNull((String)hshValues.get("strappno"));
		}
		String strProductType=Helper.correctNull((String)hshValues.get("strProductType"));
		String strTermType=Helper.correctNull((String)hshValues.get("select_termstype"));
		String strPrePost=Helper.correctNull((String)hshValues.get("sel_prepost"));
		if(strTermType.equalsIgnoreCase(""))
		{
			strTermType=Helper.correctNull((String)hshValues.get("hid_select_termstype"));
		}
		if(strTermType.equalsIgnoreCase(""))
		{
			strPrePost=Helper.correctNull((String)hshValues.get("hid_select_termsubtype"));
		}
		ArrayList arrTerms=new ArrayList();
		ArrayList arrTermsId=new ArrayList();
		ArrayList arrTermsType=new ArrayList();
		/*ArrayList arrTermsTypeGeneral=new ArrayList();*/
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		int appterms = 0;
		String retailProdcode="";
		try
		{ 
			/*rs=DBUtils.executeLAPSQuery("apptermscondsel^"+strAppno);
			while(rs.next())
			{
				arrTermsId.add(correctNull(rs.getString(1)));
				arrTerms.add(correctNull(rs.getString(2)));
				arrTermsType.add(correctNull(rs.getString(3)));
				arrTermsTypeGeneral.add(correctNull(rs.getString(4)));
			}			
			if(arrTerms.size()==0)
			{*/
			//Newly added Terms & Condition Updation
			if(Helper.correctNull((String)hshValues.get("strappstatus")).equalsIgnoreCase("op"))
			{
				ArrayList arrAvail=new ArrayList();
				strQuery=SQLParser.getSqlQuery("apptermscondsel1^"+strAppno+"^S");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					appterms = rs.getInt(1);
					if(appterms>0)
						appterms=appterms+1;
				}
				if(rs!=null)
				{
					rs.close();
				}
				//vindhya begin
				strQuery=SQLParser.getSqlQuery("getretailprodcode^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					retailProdcode = Helper.correctNull(rs.getString("app_prdcode"));					
				}
				if(rs!=null)
				{
					rs.close();
				}
				
				//vindhya end
				strQuery=SQLParser.getSqlQuery("sel_termsandcond^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrAvail.add(Helper.correctNull(rs.getString("app_general_terms_type"))+"~"+Helper.correctNull(rs.getString("term_sno")));
				}
				if(rs!=null)
				{
					rs.close();
				}
				{
					int intSize=0;
					HashMap hshQueryValues = new HashMap();
					HashMap hshQuery = new HashMap();
					if(rs!=null)
					{
						rs.close();
					}
					//strQuery=SQLParser.getSqlQuery("prdtermscondsel^"+strAppno);
					strQuery=SQLParser.getSqlQuery("getselectedprdtermscond^"+strAppno+"^"+retailProdcode);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						arrTermsId.add(correctNull(rs.getString(1)));
						arrTerms.add(correctNull(rs.getString(2)));
						arrTermsType.add(correctNull(rs.getString(3)));
					}
					if(rs!=null)
					{
						rs.close();
					}
					ArrayList arrValues = null;
					if(!Helper.correctNull((String)hshValues.get("strAppType")).equalsIgnoreCase("P"))
					{
						int arrSize = arrTermsId.size();
						for(int i=0;i<arrSize;i++)
						{
							if(!arrAvail.contains("S~"+correctNull((String)arrTermsId.get(i))))
							{
								hshQueryValues.put("size",String.valueOf(++intSize));
								hshQuery=new HashMap();
								//hshQuery.put("strQueryId","apptermscondins");
								hshQuery.put("strQueryId","apptermscondins_new");
								
								arrValues=new ArrayList();
								arrValues.add(strAppno);
								arrValues.add(correctNull(Integer.toString(appterms++)));
								arrValues.add(correctNull((String)arrTerms.get(i)));
								//arrValues.add("P");
								arrValues.add("A");
								arrValues.add("N");
								arrValues.add("S");
								arrValues.add("");								
								arrValues.add(correctNull((String)arrTermsType.get(i)));
								arrValues.add(correctNull((String)arrTermsId.get(i)));
								arrValues.add("Y");	
								arrValues.add("N");	
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put(String.valueOf(intSize),hshQuery);
							}
						}
					}
					
					if(rs!=null)
					{
						rs.close();
					}
					//strQuery=SQLParser.getSqlQuery("sel_setuptermandcond^R");
					strQuery=SQLParser.getSqlQuery("getselectedterms^R^"+retailProdcode); 
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						if(!arrAvail.contains(correctNull(rs.getString("fac_mode"))+"~"+correctNull(rs.getString("FAC_SNO"))))
						{
							hshQueryValues.put("size",String.valueOf(++intSize));
							hshQuery=new HashMap();
							//hshQuery.put("strQueryId","apptermscondins");
							hshQuery.put("strQueryId","apptermscondins_new");
							
							arrValues=new ArrayList();
							arrValues.add(strAppno);
							arrValues.add(correctNull(Integer.toString(appterms++)));
							arrValues.add(correctNull(rs.getString("fac_terms")));
							//arrValues.add("P");
							arrValues.add("A");
							arrValues.add("N");
							arrValues.add(correctNull(rs.getString("fac_mode")));
							arrValues.add(correctNull(rs.getString("fac_prepost")));
							arrValues.add("");
							arrValues.add(correctNull(rs.getString("FAC_SNO")));
							arrValues.add("Y");
							arrValues.add("N");
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(String.valueOf(intSize),hshQuery);
						}
					}
					if(intSize>0)
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
			/*}
			if(appterms == 0)
			{
				hshRecord.put("arrTermsId",arrTermsId);
				hshRecord.put("arrTerms",arrTerms);
				hshRecord.put("arrTermsType",arrTermsType);
				hshRecord.put("arrTermsTypeGeneral",arrTermsTypeGeneral);
			}
			else
			{
				hshRecord.put("arrTermsId",new ArrayList());
				hshRecord.put("arrTerms",new ArrayList());
				hshRecord.put("arrTermsType",new ArrayList());
				hshRecord.put("arrTermsTypeGeneral",new ArrayList());
			}*/
			if(!strTermType.equalsIgnoreCase(""))
			{
				String strTerm=strTermType;
				if(!(strTermType.equalsIgnoreCase("B")||strTermType.equalsIgnoreCase("P")||strTermType.equalsIgnoreCase("G")
						||strTermType.equalsIgnoreCase("O")))
					strTerm="S";
				
				
				if(strTerm.equalsIgnoreCase("G"))
					strQuery=SQLParser.getSqlQuery("apptermscondgeneral^"+strAppno+"^"+strTerm+"^"+strPrePost);
				else
					strQuery=SQLParser.getSqlQuery("apptermscondsel2^"+strAppno+"^"+strTerm);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull((String)rs.getString("app_termid")));//0
					arrCol.add(Helper.correctNull((String)rs.getString("app_termscontent")));//1
					arrCol.add(Helper.correctNull((String)rs.getString("app_termstype")));//2
					arrCol.add(Helper.correctNull((String)rs.getString("app_general_terms_type")));//3
					arrCol.add(Helper.correctNull((String)rs.getString("app_termprint")));//4
					arrCol.add(Helper.correctNull((String)rs.getString("terms_supportdoc")));//5
					arrCol.add(Helper.correctNull((String)rs.getString("terms_prepost")));//6
					arrCol.add(Helper.correctNull((String)rs.getString("terms_prdcode")));//7
					arrRow.add(arrCol);
				}
			}
			hshRecord.put("appno", strAppno);
			hshRecord.put("strProductType", strProductType);
			hshRecord.put("arrRow", arrRow);
			hshRecord.put("strTermType", strTermType);
			hshRecord.put("strPrePost", strPrePost);
			
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("get_Appstat^"+strAppno);
			if(rs.next())
			{
				hshRecord.put("strProcessdate", Helper.correctNull(rs.getString("app_processdate")));
			}
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
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
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
		return hshRecord;
	}

	public void updateTerms(HashMap hshValues)
	{		
		boolean boolterms = false;		 
		ResultSet rs=null;
		ResultSet rs1=null;
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = null;
		String strAppno=correctNull((String)hshValues.get("appno"));
		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
		}
		prd_type =prd_type.substring(0,1);
		if(strAppno.equalsIgnoreCase(""))
		{
			strAppno = Helper.correctNull((String)hshValues.get("strappno"));
		}
		String[] strTermId=null;
		String[] strtermText=null;
		String[] strselectTermsType=null;
		String[] strDoc_upload=null;
		String[] strTermSubType=null;
		String[] strTerm_prdcode=null;
		String actionType = (String)hshValues.get("hidAction");
		StringBuilder sbOldAudit=new StringBuilder();
		String strQuery="";
		try
		{
			rs=DBUtils.executeLAPSQuery("selapplicantterms^"+strAppno);
			if(rs.next())
			{
				boolterms = true;
			}
			
			if(Helper.correctNull((String)hshValues.get("strAppType")).equalsIgnoreCase("P"))
			{
				boolterms = true;
			}
			
			if(false)
			{
				strTermId=(String[])hshValues.get("hidsno");
				strtermText=(String[])hshValues.get("hidText");
				strselectTermsType=(String[])hshValues.get("hidtermtype_select");
				strTermSubType=(String[])hshValues.get("hidtermtype_subtype");
				strTerm_prdcode=(String[])hshValues.get("hidprdcode");
				int intSize=0;
				for(int i=0;i<strTermId.length;i++)
				{
					 hshQueryValues.put("size",String.valueOf(++intSize));
					 hshQuery=new HashMap();
					 hshQuery.put("strQueryId","apptermscondins");
					 arrValues=new ArrayList();
					 arrValues.add(strAppno);
					 arrValues.add(Integer.toString(i));
					 arrValues.add(strtermText[i]);
					 arrValues.add("P");
					 arrValues.add("N");
					 arrValues.add(strselectTermsType[i]);
					 arrValues.add(strTermSubType[i]);
					 arrValues.add(strTerm_prdcode[i]);
					 arrValues.add("");
					 hshQuery.put("arrValues",arrValues);
					 hshQueryValues.put(String.valueOf(intSize),hshQuery);
				}
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}		
			if(actionType.equals("insert"))
			{
				String termid = Integer.toString(getTermId(hshValues,"Retail"));
				hshQueryValues.put("size","1");
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","apptermscondins1");
				arrValues=new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(termid);
				arrValues.add((String)hshValues.get("txttrmdesc"));
				//if(prd_type.equalsIgnoreCase("A")){
				arrValues.add("A");
				/*}
				else{
					arrValues.add("P");
				}*/
				arrValues.add("N");
				if(!(Helper.correctNull((String)hshValues.get("select_termstype")).equalsIgnoreCase("B")
						||Helper.correctNull((String)hshValues.get("select_termstype")).equalsIgnoreCase("P")
						||Helper.correctNull((String)hshValues.get("select_termstype")).equalsIgnoreCase("G")
						||Helper.correctNull((String)hshValues.get("select_termstype")).equalsIgnoreCase("O")))
					arrValues.add("S");
				else
					arrValues.add(Helper.correctNull((String)hshValues.get("select_termstype")));
				arrValues.add((String)hshValues.get("sel_prepost"));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_req")));
				if(Helper.correctNull((String)hshValues.get("select_termstype")).equalsIgnoreCase("B")
						||Helper.correctNull((String)hshValues.get("select_termstype")).equalsIgnoreCase("P")
						||Helper.correctNull((String)hshValues.get("select_termstype")).equalsIgnoreCase("G")
						||Helper.correctNull((String)hshValues.get("select_termstype")).equalsIgnoreCase("O"))
					arrValues.add("");
					else
					arrValues.add(Helper.correctNull((String)hshValues.get("select_termstype")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
			}
			else if(actionType.equals("update"))
			{
				String termid = (String)hshValues.get("hidtermid");
				hshQueryValues.put("size","1");
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","apptermscondupd");
				arrValues=new ArrayList();
				arrValues.add((String)hshValues.get("txttrmdesc"));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_req")));
				arrValues.add("A");
				arrValues.add(strAppno);
				arrValues.add(termid);
				arrValues.add((String)hshValues.get("hid_select_termstype"));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			}
			else if(actionType.equals("delete"))
			{
				String strTermsType = (String)hshValues.get("hidterms");
				String termid = (String)hshValues.get("sno");
				String termremarks = (String)hshValues.get("hidcomments");
				hshQueryValues.put("size","1");
				hshQuery=new HashMap();
				arrValues=new ArrayList();
//				if(strTermsType.equals("P"))
//				{
					hshQuery.put("strQueryId","apptermsconddel1");
					arrValues.add("Y");
					arrValues.add(termremarks);
//				}
//				else if (strTermsType.equals("A"))
//				{
//					hshQuery.put("strQueryId","apptermsconddel2");
//				}
				arrValues.add(strAppno);
				arrValues.add(termid);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			}
			else if(actionType.equals("Print"))
			{
				String strTermID[]=null,strTermPrint[]=null,strTermType[]=null;
				if(hshValues.get("hidsno") instanceof java.lang.String)
				{
					strTermID= new String[1];
					strTermID[0]=(String)hshValues.get("hidsno");
				}
				else
				{
					strTermID=(String[])hshValues.get("hidsno");
				}
				if(hshValues.get("hidtermtype") instanceof java.lang.String)
				{
					strTermType= new String[1];
					strTermType[0]=(String)hshValues.get("hidtermtype");
				}
				else
				{
					strTermType=(String[])hshValues.get("hidtermtype");
				}
				if(hshValues.get("txt_print") instanceof java.lang.String)
				{
					strTermPrint= new String[1];
					strTermPrint[0]=(String)hshValues.get("txt_print");
				}
				else
				{
					strTermPrint=(String[])hshValues.get("txt_print");
				}
				if(hshValues.get("sel_DocUpload") instanceof java.lang.String)
				{
					strDoc_upload= new String[1];
					strDoc_upload[0]=(String)hshValues.get("sel_DocUpload");
				}
				else
				{
					strDoc_upload=(String[])hshValues.get("sel_DocUpload");
				}
				for(int i=0;i<strTermID.length;i++) 
				{
					String termid = (String)hshValues.get("hidtermid");
					hshQueryValues.put("size",String.valueOf(i+1));
					hshQuery=new HashMap();
					hshQuery.put("strQueryId","updapptermscondprint");
					arrValues=new ArrayList();
					arrValues.add(strTermPrint[i]);
					arrValues.add(strDoc_upload[i]);
					arrValues.add(strAppno);
					arrValues.add(strTermID[i]);
					arrValues.add(strTermType[i]);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(i+1),hshQuery);
				}
			}
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("apptermscondsel^"+strAppno);
			if(rs.next())
			{
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","upd_apptermflag");
				arrValues=new ArrayList();
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			StringBuilder sbAuditTrial = new StringBuilder();
			if(actionType.equals("update"))
			{
				/***
				 * For Audit Trial Old Data - By Karthikeyan.S on 20/09/2013
				 */
				strQuery=SQLParser.getSqlQuery("sel_termcontent^"+strAppno+"^"+Helper.correctNull((String)hshValues.get("hidtermid")));
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					sbOldAudit.append("Add Terms and Conditions = ")
					.append(Helper.correctNull((String)rs.getString("app_termscontent")))
					.append("~Terms Type = ")
					.append(Helper.correctNull((String)rs.getString("app_termstype")));
				}
				/***
				 * End - Audit Trial Old Data
				 */
				sbAuditTrial.append("Add Terms and Conditions = " +correctNull((String)hshValues.get("txttrmdesc"))+"~Terms Type ="+correctNull((String)hshValues.get("hidterms")));
			}
			else if(actionType.equals("insert"))
			{
				sbAuditTrial.append("Add Terms and Conditions = " +correctNull((String)hshValues.get("txttrmdesc"))+"~Terms Type =A");
			}
			else
			{
				sbAuditTrial.append("Add Terms and Conditions = " +correctNull((String)hshValues.get("txttrmdesc"))+"~Remarks For Deleted Terms ="+correctNull((String)hshValues.get("hidcomments"))+"~Terms Type ="+correctNull((String)hshValues.get("hidterms")));
			}
				
			if(actionType.equals("insert"))
			{
				hshValues.put("strAction", "Insert");
			}
			else if(actionType.equals("update"))
			{
				hshValues.put("strAction", "Update");
			}
			else if(actionType.equals("delete"))
			{
				hshValues.put("strAction", "Delete");
			}
			/***
			 * For Audit Trial Data - By Karthikeyan.S on 20/09/2013
			 */
			AuditTrial.auditNewLog(hshValues,"234",strAppno,sbAuditTrial.toString(),sbOldAudit.toString());
			/***
			 * End - Audit Trial Data
			 */
			
			//added by Sunil 
		
			String strMAxTermId="";
			strQuery=SQLParser.getSqlQuery("sel_maxTermId^"+strAppno);
			
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()){
			 strMAxTermId=Helper.correctNull((String)rs.getString("maxtermId"));
			}
			
			
			strQuery=SQLParser.getSqlQuery("sel_termId^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			int maxterm=Integer.parseInt(strMAxTermId);
			while(rs.next()){
				String termId=Helper.correctNull((String)rs.getString("APP_TERMID"));
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","upd_termId");
				arrValues=new ArrayList();
				arrValues.add(String.valueOf(++maxterm));
				arrValues.add(termId);
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
			}
			
			
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
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
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}			
			try
			{
				//EJBInvoker.executeStateLess("appeditlock",hshValues,"unLockApplication");
			}
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}			
		}
	}

	private int getTermId(HashMap hshValues,String type)
	{
		 
		ResultSet rs=null;
		String strQuery = "";
		int intTerm = 0;
		String strAppno=correctNull((String)hshValues.get("appno"));
		if(strAppno.equalsIgnoreCase(""))
		{
			strAppno = Helper.correctNull((String)hshValues.get("strappno"));
		}
		try
		{
			if(type.equals("Retail"))
			{
				 rs=DBUtils.executeLAPSQuery("selmaxappterm^"+strAppno);
			}
			else
			{
				//HashMap hshValue = (HashMap)getTokens(hshValues);
				//String strFacId = (String)hshValue.get("strToken1");
				//String strFacType = (String)hshValue.get("strToken2");
				String strFacSno=(String)hshValues.get("seltermid");
				strQuery=SQLParser.getSqlQuery("selmaxcomterm^"+strFacSno+"^"+strAppno);
				rs =DBUtils.executeQuery(strQuery);
			}
			if(rs.next())
			{
				intTerm = rs.getInt(1);
			}
			rs.close();
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
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
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
		return intTerm;
	}
	
	public HashMap getTermData(HashMap hshRequestValues) 
	{	 
		ResultSet rs = null;
		ArrayList arrTerms=new ArrayList();
		ArrayList arrTermsId=new ArrayList();
		HashMap hshRecord = new HashMap();
		try
		{				 
			hshRecord = new HashMap();
			rs=DBUtils.executeLAPSQuery("setmodtermcondterm");
			while (rs.next())
			{  
				arrTermsId.add(correctNull(rs.getString(1)));
				arrTerms.add(correctNull(rs.getString(2)));
			}
			hshRecord.put("arrTermsId",arrTermsId);
			hshRecord.put("arrTerms",arrTerms);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getTermData  "+ce.toString());
		}finally
		{
			try
			{
				if(rs!=null)
					rs.close();
			}catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in getTermData "+ exp.toString()); 
			}
		}
		return hshRecord;
	}

	public HashMap getDeletedTerms(HashMap hshRequestValues) 
	{	
		ResultSet rs = null,rs1=null;
		ArrayList arrTerms=new ArrayList();
		ArrayList arrTermsComments=new ArrayList();
		ArrayList arrTermId = new ArrayList();
		ArrayList arrTermType = new ArrayList();
		HashMap hshRecord = new HashMap();
		String strQuery="";
		String strAppno = correctNull((String)hshRequestValues.get("appno"));
		if(strAppno.equalsIgnoreCase(""))
		{
			strAppno = Helper.correctNull((String)hshRequestValues.get("strappno"));
		}
		String strAction = correctNull((String)hshRequestValues.get("hidAction"));
		try
		{	
			hshRecord = new HashMap();
			if(strAction.equals("Retail"))
			{
			    rs=DBUtils.executeLAPSQuery("deletedapptermscond^"+strAppno);
				while (rs.next())
				{  
					arrTerms.add(correctNull(rs.getString(1)));
					arrTermsComments.add(correctNull(rs.getString(2)));
					arrTermId.add(correctNull(rs.getString(3)));
					arrTermType.add(correctNull(rs.getString(4)));
				}				
				hshRecord.put("arrTerms",arrTerms);
				hshRecord.put("arrTermsComments",arrTermsComments);
				hshRecord.put("arrTermId",arrTermId);
				hshRecord.put("arrTermType",arrTermType);
				hshRecord.put("appno",strAppno);
			}
			else
			{
				//HashMap hshValue = (HashMap)getTokens(hshRequestValues);
				//String strFacId = (String)hshValue.get("strToken1");
				//String strFacType = (String)hshValue.get("strToken2");
				String strFacsno=(String)hshRequestValues.get("seltermid");
				strQuery = SQLParser.getSqlQuery("deletedcomtermscond^"+strAppno);
				rs =DBUtils.executeQuery(strQuery);
				while (rs.next())
				{  
					arrTerms.add(correctNull(rs.getString(1)));
					arrTermsComments.add(correctNull(rs.getString(2)));
					arrTermId.add(correctNull(rs.getString(3)));
					arrTermType.add(correctNull(rs.getString(4)));
				}			
				hshRecord.put("arrTerms",arrTerms);
				hshRecord.put("arrTermsComments",arrTermsComments);
				hshRecord.put("arrTermId",arrTermId);
				hshRecord.put("arrTermType",arrTermType);
				hshRecord.put("appno",strAppno);
				
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getDeletedTerms"+ce.toString());
		}finally
		{
			try
			{
				if(rs!=null)
					rs.close();
			}catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in getDeletedTerms "+ exp.toString()); 
			}
		}
		return hshRecord;
	}

	
}
