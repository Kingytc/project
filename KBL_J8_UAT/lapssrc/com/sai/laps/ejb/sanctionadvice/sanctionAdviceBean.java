package com.sai.laps.ejb.sanctionadvice;

import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.ejb.commdocument.CommDocumentBean;
import com.sai.laps.ejb.comrepayschedule.ComRepayScheduleBean;
import com.sai.laps.ejb.lapsReport.lapsReportBean;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.tagdatahelper.TagDataHelper5;
@Stateless(name = "sanctionAdviceBean", mappedName = "sanctionAdviceHome")
@Remote (sanctionAdviceRemote.class)
public class sanctionAdviceBean extends BeanAdapter
{
	
	/**
	 * 
	 */
	
	private static final long serialVersionUID = 920356174414057157L;
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(sanctionAdviceBean.class);


	public  HashMap getsanctionAdvice(HashMap hshValues) 
	{
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		String strQuery="";
		
		ResultSet rs = null;
		ResultSet rs1=null;
		
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=new ArrayList();
		ArrayList vecData_doc = new ArrayList();
		ArrayList vecVal_doc=new ArrayList();
		
		ArrayList arrTerms=new ArrayList();
		ArrayList arrTermsId=new ArrayList();
		ArrayList arrTermsType=new ArrayList();
		ArrayList arrRow=new ArrayList();
        ArrayList arrCol=new ArrayList();
		
		String prdtype=correctNull((String)hshValues.get("strProductType"));
		
		String strAppid="";
		String strCoguaid="";
		String appno=correctNull((String)hshValues.get("appno"));
		if(appno.equals(""))
		{
			appno=correctNull((String)hshValues.get("strappno"));
		}
		
		String strprdtype = correctNull((String)hshValues.get("strProductType"));
		try
		{
			
			strQuery = SQLParser.getSqlQuery("selapplicant_byappno^"+appno+"^a");
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{	
				hshRecord.put("perapp_title",correctNull(rs.getString("perapp_title")));
				hshRecord.put("perapp_fname",correctNull(rs.getString("perapp_fname")));
				hshRecord.put("perapp_address1",correctNull(rs.getString("perapp_address1")));
				hshRecord.put("perapp_address2",correctNull(rs.getString("perapp_address2")));
				hshRecord.put("perapp_address3",correctNull(rs.getString("perapp_address3")));
				hshRecord.put("perapp_city",correctNull(rs.getString("comm_city")));
				hshRecord.put("perapp_state",correctNull(rs.getString("comm_state")));
				hshRecord.put("perapp_zip",correctNull(rs.getString("perapp_zip")));
				hshRecord.put("perapp_phone",correctNull(rs.getString("perapp_phone")));
				hshRecord.put("perinc_selfincometype",correctNull(rs.getString("perapp_constitution")));
				hshRecord.put("constitutiondesc",correctNull(rs.getString("constitutiondesc")));
				strAppid=correctNull(rs.getString("perapp_id"));
			}
			if(rs != null)
			{
				rs.close();
				rs=null;
			}
			
			strQuery = SQLParser.getSqlQuery("selcreditreport2^"+appno+"^"+"a"+strAppid);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{	
				hshRecord.put("applntmeans",correctNull(rs.getString("CR_Total_MEANS")));
				hshRecord.put("applntmeansason",correctNull(rs.getString("cr_meansason")));
			}
			
			if(rs != null)
			{
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("selBranchCityName^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("org_name",correctNull(rs.getString("org_name")));
				hshRecord.put("orgadd1",correctNull(rs.getString("org_add1")));
	           	hshRecord.put("orgadd2",correctNull(rs.getString("org_add2")));
	           	hshRecord.put("orgcity",correctNull(rs.getString("city_name")));
	           	hshRecord.put("orgstate",correctNull(rs.getString("state_name")));
	           	hshRecord.put("orgzip",correctNull(rs.getString("org_zip")));
	           	hshRecord.put("orgphone",correctNull(rs.getString("org_phone")));
			}
			
			if(rs != null)
			{
				rs.close();
				rs=null;
			}
			
			strQuery = SQLParser.getSqlQuery("selapplicant_byappno^"+appno+"^g");
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{	
				vecData = new ArrayList();
				vecData.add(correctNull(rs.getString("perapp_title")));
				vecData.add(correctNull(rs.getString("perapp_fname")));
				strCoguaid=correctNull(rs.getString("perapp_id"));
				strQuery = SQLParser.getSqlQuery("selcreditreport2^"+appno+"^"+"g"+strCoguaid);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{	
					vecData .add(correctNull(rs1.getString("CR_Total_MEANS")));
					vecData.add(correctNull(rs1.getString("cr_meansason")));
				}
				else
				{
					vecData .add("0.00");
					vecData.add("");
				}
				vecVal.add(vecData);
			}
			hshRecord.put("vecVal",vecVal);
			
			
			strQuery = SQLParser.getSqlQuery("selapplicant_byappno^"+appno+"^c");
			rs=DBUtils.executeQuery(strQuery);
			vecVal=new ArrayList();
			while(rs.next())
			{	
				vecData = new ArrayList();
				vecData.add(correctNull(rs.getString("perapp_title")));
				vecData.add(correctNull(rs.getString("perapp_fname")));
				strCoguaid=correctNull(rs.getString("perapp_id"));
				strQuery = SQLParser.getSqlQuery("selcreditreport2^"+appno+"^"+"c"+strCoguaid);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{	
					vecData .add(correctNull(rs1.getString("CR_Total_MEANS")));
					vecData.add(correctNull(rs1.getString("cr_meansason")));
				}
				else
				{
					vecData .add("0.00");
					vecData.add("");
				}
				vecVal.add(vecData);
			}
			hshRecord.put("vecReport",vecVal);
			
			if(rs != null)
			{
				rs.close();
				rs=null;
			}
			
			strQuery = SQLParser.getSqlQuery("appdocssel^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{	
				vecData_doc = new ArrayList();
				vecData_doc.add(correctNull(rs.getString("doc_desc")));
				vecVal_doc.add(vecData_doc);
			}
			hshRecord.put("vecVal_doc",vecVal_doc);
			
			if(rs != null)
			{
				rs.close();
				rs=null;
			}
			hshRecord.put("prdtype",strprdtype);
			
			if(rs != null)
			{
				rs.close();
				
			}
			rs=DBUtils.executeLAPSQuery("sel_employee_estabilishdate^"+appno);
			if(rs.next())
			{
				hshRecord.put("peremp_establish", correctNull(rs.getString("estdate")));
			}
			
			
			if(rs !=null)
			{
				rs.close();
			}
			String strProdPurpose="",strVehicleType="";
			strQuery = SQLParser.getSqlQuery("selprodpurpose^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()){strProdPurpose=Helper.correctNull((String)rs.getString("prd_purpose"));
			strVehicleType=Helper.correctNull((String)rs.getString("prd_vehitype"));}
			/*
			 * 			For Purchase of Ready Built House and Used Vehicle loan, 
			 * 				Margin is based on age of the building / vehicle respectively
			 */
			if(strProdPurpose.equalsIgnoreCase("H") || strProdPurpose.equalsIgnoreCase("U")||strVehicleType.equalsIgnoreCase("2")) 
			{
				strQuery = SQLParser.getSqlQuery("pergetloanProductbymargin^" + appno);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("pergetloanProduct^" + appno);
			}
			if(rs !=null)
			{
				rs.close();
			}
			
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{	
				hshRecord.put("lreqterms",correctNull(rs.getString("lreqterms")));
				hshRecord.put("loan_purposeofloan",Helper.CLOBToString(rs.getClob("loan_purposeofloan")));
				hshRecord.put("loan_modintrate",correctNull(rs.getString("mintrate")));
				hshRecord.put("loan_costloanprd",correctNull(rs.getString("cloanprd")));
				hshRecord.put("loan_margin",correctNull(rs.getString("loan_margin")));
				hshRecord.put("loan_facility",correctNull(rs.getString("loan_facility")));
				hshRecord.put("loan_reqterms",correctNull(rs.getString("lreqterms")));
				hshRecord.put("loan_recmdamt",correctNull(rs.getString("sancamount")));
				hshRecord.put("loan_sub", correctNull(rs.getString("loan_sub")));
				hshRecord.put("app_processdate",correctNull(rs.getString("app_processdate")));
				hshRecord.put("offeredmargin",correctNull(rs.getString("offeredmargin")));
				
			}
			if(rs!=null) 
			{
				rs.close();
			}
			
			strQuery=SQLParser.getSqlQuery("getmonthreview^"+appno); 
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{	
				hshRecord.put("review_month",correctNull(rs.getString("review_month")));
				
			}
			if(rs != null)
			{
				rs.close();
				rs=null;
			}
			rs=DBUtils.executeLAPSQuery("apptermscondsel^"+appno);
			while(rs.next())
			{
				arrTermsId.add(correctNull(rs.getString(1)));
				arrTerms.add(correctNull(rs.getString(2)));
				arrTermsType.add(correctNull(rs.getString(3)));
			}
			hshRecord.put("arrTermsId",arrTermsId);
			hshRecord.put("arrTerms",arrTerms);
			hshRecord.put("arrTermsType",arrTermsType);
			
			if(rs != null)
			{
				rs.close();
				rs=null;
			}
			strQuery=SQLParser.getSqlQuery("agr_sel_bullockrepay^"+appno+"^"+prdtype); 
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("agr_security1",correctNull(rs.getString("agr_security1")));
				hshRecord.put("agr_securityval1",correctNull(rs.getString("agr_securityval1")));
				hshRecord.put("agr_security2",correctNull(rs.getString("agr_security2")));
				hshRecord.put("agr_securityval2",correctNull(rs.getString("agr_securityval2")));
				hshRecord.put("agr_security3",correctNull(rs.getString("agr_security3")));
				hshRecord.put("agr_securityval3",correctNull(rs.getString("agr_securityval3")));
				hshRecord.put("bullock_holiday",correctNull(rs.getString("bullock_holiday")));
				hshRecord.put("bullock_payment",correctNull(rs.getString("bullock_payment")));
				hshRecord.put("bullock_date",correctNull(rs.getString("bullock_date")));
			}
			if(rs != null)
			{
				rs.close();
				rs=null;
			}
			strQuery=SQLParser.getSqlQuery("agrgettechdetails^"+appno); 
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("tech_ugc",correctNull(rs.getString("tech_ugc")));
			}
			if(rs != null)
			{
				rs.close();
				rs=null;
			}
			
			if(rs!=null)rs.close();
	           rs = DBUtils.executeLAPSQuery("selcommworkflowsancdetails^"+appno);
	        if(rs.next())
	        {
	        	hshRecord.put("sancofficercomments",correctNull(rs.getString("app_sanctioningcomments")));
	        	hshRecord.put("sancauth",correctNull(rs.getString("usr_fname")));
	        }
	        if(rs!=null)rs.close();
	        rs = DBUtils.executeLAPSQuery("selmaiboxcomments^"+appno);
	        while(rs.next())
	        {
	     	   arrCol=new ArrayList();
	     	   arrCol.add(correctNull(rs.getString("usr_fname")));
	     	   arrCol.add(correctNull(Helper.CLOBToString(rs.getClob("mail_comments"))));
	     	   arrRow.add(arrCol);
	        }
	        hshRecord.put("mailcomments",arrRow);
	        if(strprdtype.equalsIgnoreCase("aL"))
	        {
	        	double dblTotMarketValue=0.0;
	        	double dblTotLoanAmt=0.0;
		        rs = DBUtils.executeLAPSQuery("per_get_capldata^"+appno);
		        arrRow=new ArrayList();
		        while(rs.next())
		        {
		     	   arrCol=new ArrayList();
		     	   if(!correctNull(rs.getString("capl_namewarehouse")).equals("")){
		     	   arrCol.add(correctNull(rs.getString("capl_namewarehouse")));
		     	   arrCol.add(correctNull(rs.getString("capl_warehousedoc")));
		     	   arrCol.add(correctNull(rs.getString("capl_units")));
		     	   arrCol.add(correctNull(rs.getString("capl_weight")));
		     	   arrCol.add(correctNull(rs.getString("capl_marketrate")));
		     	   arrCol.add(correctNull(rs.getString("capl_marketvalue")));
		     	   arrCol.add(correctNull(rs.getString("capl_loanamt")));
		     	   arrCol.add(correctNull(rs.getString("capl_invoicevalue")));
		     	   arrCol.add(correctNull(rs.getString("capl_invoicedate")));
		     	   double dblMarketValue=Double.parseDouble(Helper.correctDouble(rs.getString("capl_marketvalue")));
		     	   dblTotMarketValue=dblTotMarketValue+dblMarketValue;
		       	   double dblLoanAmt=Double.parseDouble(Helper.correctDouble(rs.getString("capl_loanamt")));
		     	   dblTotLoanAmt=dblTotLoanAmt+dblLoanAmt;
		    	   arrRow.add(arrCol);}
		        }
		        
		        hshRecord.put("arrwarehouse",arrRow);
		        hshRecord.put("totMarketValue",jtn.format(dblTotMarketValue));
		        hshRecord.put("totLoanAmt",jtn.format(dblTotLoanAmt));
	        }
	        
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
		hshRecord.put("appno",appno);
		return hshRecord;
	}	


	public HashMap updatesanctionAdvice(HashMap hshValues) 
	{
		//HashMap hshQueryValues = new HashMap();
		//HashMap hshQuery = null;
		//ArrayList arrValues=new ArrayList();
		//String strAction=(String)hshValues.get("hidAction");
		//String strGradeId = "";
		//String appno=correctNull((String)hshValues.get("strappno"));
		try
		{
		   /*if(strAction.equals("insert"))
			{
				
				hshQueryValues = new HashMap();
							
				int intUpdateSize=0;
				
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				intUpdateSize++;
				hshQuery.put("strQueryId","addparameterinsval");
				arrValues.add(appno);
				arrValues.add(correctNull((String )hshValues.get("sel_occupationlist")));
				arrValues.add(correctNull((String )hshValues.get("txt_guardian")));
				arrValues.add(correctNull((String )hshValues.get("sel_minor")));
				arrValues.add(correctNull((String )hshValues.get("txt_permanent")));
				arrValues.add(correctNull((String )hshValues.get("txt_nonresident")));
				
				arrValues.add(correctNull((String )hshValues.get("sel_trade")));
				arrValues.add(correctNull((String )hshValues.get("sel_inland")));
				arrValues.add(correctNull((String )hshValues.get("txt_ititle")));
				arrValues.add(correctNull((String )hshValues.get("txt_iname")));
				
				arrValues.add(correctNull((String )hshValues.get("sel_constitution")));
				arrValues.add(correctNull((String )hshValues.get("txt_relation")));
				arrValues.add(correctNull((String )hshValues.get("txt_employer")));
				arrValues.add(hidapptype);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);	
				hshQueryValues.put("size",Integer.toString(intUpdateSize));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("delete"))
			{
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","addparameterdelval");
				arrValues.add(appno);
				arrValues.add(hidapptype);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}else  if(strAction.equals("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","addparameterdelval");
				arrValues.add(appno);
				arrValues.add(hidapptype);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQueryValues = new HashMap();
				
				int intUpdateSize=0;
				
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				intUpdateSize++;
				hshQuery.put("strQueryId","addparameterinsval");
				arrValues.add(appno);
				arrValues.add(correctNull((String )hshValues.get("sel_occupationlist")));
				arrValues.add(correctNull((String )hshValues.get("txt_guardian")));
				arrValues.add(correctNull((String )hshValues.get("sel_minor")));
				arrValues.add(correctNull((String )hshValues.get("txt_permanent")));
				arrValues.add(correctNull((String )hshValues.get("txt_nonresident")));
				
				arrValues.add(correctNull((String )hshValues.get("sel_trade")));
				arrValues.add(correctNull((String )hshValues.get("sel_inland")));
				arrValues.add(correctNull((String )hshValues.get("txt_ititle")));
				arrValues.add(correctNull((String )hshValues.get("txt_iname")));
				
				arrValues.add(correctNull((String )hshValues.get("sel_constitution")));
				arrValues.add(correctNull((String )hshValues.get("txt_relation")));
				arrValues.add(correctNull((String )hshValues.get("txt_employer")));
				arrValues.add(hidapptype);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);	
				hshQueryValues.put("size",Integer.toString(intUpdateSize));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
				
			}*/
			HashMap hshRecord = getsanctionAdvice(hshValues);
			return hshRecord;
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
	}
	
	public HashMap getCorpSanLetterAnnexureone(HashMap hshValues) 
	{
		HashMap hshResult = new HashMap();
		String strQuery=null;
		String strQuery1=null;
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		String city_name="";
		String state_name="";
		String city_code="";
		String state_code="";
		String comappid="";
		String strAppno="";
		ArrayList arrVal = null;
		ArrayList arrData = null;
		ArrayList arrSecRow=null;
		ArrayList arrSecCol =null;
		ArrayList arrSecRemarkscol = null;
		ArrayList arrSecRemarksrow = null;
		int	intGroup =0;
		HashMap hshResult1=null;
		
		
		try
		{
			
			strAppno=(String)hshValues.get("appno");
			comappid=correctNull((String)hshValues.get("comappid"));
			strQuery = SQLParser.getSqlQuery("comfunsel3^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);	
			if (rs.next())
			{
				comappid=correctNull(rs.getString("demo_appid"));
				hshResult.put("proposalvaluesin",correctNull(rs.getString("app_valuesin")));
			}
		
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("comappmastersel^"+comappid);
			rs = DBUtils.executeQuery(strQuery);	
			while (rs.next())
			{ 
				hshResult.put("comapp_companyname",correctNull(rs.getString("comapp_companyname")));
				hshResult.put("comapp_ownership",correctNull(rs.getString("comapp_ownership")));//Organisation
				hshResult.put("comapp_businessnature",correctNull(rs.getString("comapp_businessnature")));
				hshResult.put("comapp_yrsinbusiness",correctNull(rs.getString("comapp_yrsinbusiness")));
				hshResult.put("comapp_regadd1",correctNull(rs.getString("comapp_regadd1")));
				hshResult.put("comapp_regadd2",correctNull(rs.getString("comapp_regadd2")));
				hshResult.put("comapp_regcity",correctNull(rs.getString("comapp_regcity")));
				hshResult.put("comapp_companyid",correctNull(rs.getString("comapp_companyid")));
				hshResult.put("comapp_regpin",correctNull(rs.getString("comapp_regpin")));
				city_code=correctNull(rs.getString("comapp_regcity"));
				if(rs1!=null)
				rs1.close();
				if(!city_code.equalsIgnoreCase(""))
				{
					strQuery = SQLParser.getSqlQuery("selcitycode^"+city_code);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						city_name = correctNull((String)rs1.getString(1));
						state_code = correctNull((String)rs1.getString(2));
						if(!state_code.equalsIgnoreCase(""))
						{
							strQuery = SQLParser.getSqlQuery("selstatecode^"+state_code);
							if(rs1!=null)
							{
								rs1.close();
							}
							rs1 = DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{
								state_name = correctNull((String)rs1.getString(1));
						
							}
						}
					}
				}
			}
			hshResult.put("city_name",city_name);
			hshResult.put("state_name",state_name);
			arrData = new ArrayList();
			arrSecRemarkscol = new ArrayList();
			arrSecRemarksrow = new ArrayList();
			strQuery = SQLParser.getSqlQuery("facilities_select_approvestatus^" + strAppno +"^"+intGroup);
 			if(rs!=null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{	
  				intGroup = rs.getInt("facility_sno");
 				arrVal = new ArrayList();
				arrVal.add(correctNull(rs.getString("facility_headid")));
				arrVal.add(correctNull(rs.getString("facheaddesc")));
				arrVal.add(correctNull(rs.getString("facility_id")));
				arrVal.add(correctNull(rs.getString("facdesc")));
				arrVal.add(correctNull(rs.getString("facility_existing")));
				arrVal.add(correctNull(rs.getString("facility_proposed")));
				arrVal.add(correctNull(rs.getString("facility_sancamt")));
				arrVal.add(correctNull(rs.getString("facility_group")));
				arrVal.add(correctNull(rs.getString("facility_intremarks")));
				arrVal.add(correctNull(rs.getString("facility_sancintremarks")));
				
				arrSecRow=new ArrayList();//For Security Details
				strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^" + intGroup
						+ "^" + strAppno);
				if(rs2!=null)
					rs2.close();
				rs2 = DBUtils.executeQuery(strQuery);
				int j=0;
				while (rs2.next()) {
					arrSecCol=new ArrayList();
					arrSecRemarkscol=new ArrayList();
					arrSecCol.add(correctNull(rs2.getString("sec_desc_details"))); 
					arrSecCol.add(correctNull(rs2.getString("sec_margin"))); 
					if(!correctNull(rs2.getString("sec_remarks")).equals(""))
					{
						arrSecRemarkscol.add(correctNull(rs2.getString("sec_remarks")));
						arrSecRemarksrow.add(arrSecRemarkscol);
					}
					arrSecRow.add(arrSecCol);
					j++;
				}
				arrVal.add(arrSecRow);
				arrVal.add(Integer.toString(j));
				arrData.add(arrVal);		

				if(rs1!=null)
					rs1.close();
				strQuery1 = SQLParser.getSqlQuery("facilities_select_approvestatus^" + strAppno+"^"+intGroup);
				rs1 = DBUtils.executeQuery(strQuery1);
				while(rs1.next())
				{
					arrVal = new ArrayList();
					arrVal.add(correctNull(rs1.getString("facility_headid")));
					arrVal.add(correctNull(rs1.getString("facheaddesc")));
					arrVal.add(correctNull(rs1.getString("facility_id")));
					arrVal.add(correctNull(rs1.getString("facdesc")));
					arrVal.add(correctNull(rs1.getString("facility_existing")));
					arrVal.add(correctNull(rs1.getString("facility_proposed")));
					arrVal.add(correctNull(rs1.getString("facility_sancamt")));
					arrVal.add(correctNull(rs1.getString("facility_group")));
					arrVal.add(correctNull(rs1.getString("facility_intremarks")));
					arrVal.add(correctNull(rs1.getString("facility_sancintremarks")));
					String strFacSno = correctNull((String)rs1.getString("facility_sno"));
					
					arrSecRow=new ArrayList();//For Security Details
					strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^" + strFacSno
							+ "^" + strAppno);
					if(rs2!=null)
						rs2.close();
					rs2 = DBUtils.executeQuery(strQuery);
					int k=0;
					while (rs2.next()) {
						arrSecCol=new ArrayList();
						arrSecRemarkscol=new ArrayList();
						arrSecCol.add(correctNull(rs2.getString("sec_desc_details"))); 
						arrSecCol.add(correctNull(rs2.getString("sec_margin"))); 
						if(!correctNull(rs2.getString("sec_remarks")).equals(""))
						{
							arrSecRemarkscol.add(correctNull(rs2.getString("sec_remarks")));
							arrSecRemarksrow.add(arrSecRemarkscol);
						}
						arrSecRow.add(arrSecCol);
						k++;
					}
					arrVal.add(arrSecRow);
					arrVal.add(Integer.toString(k));
					arrData.add(arrVal);			

				}
			}

			
			if (rs != null)
				rs.close();
			
			hshResult.put("arrFacilityDetails",arrData);
			hshResult.put("arrPrimarySecRemars",arrSecRemarksrow);
			
			
			// for documents by bank
			
			arrData=new ArrayList();
			rs = DBUtils.executeLAPSQuery("select_doc_allfacility^"+strAppno);
			while (rs.next()) 
			{
				arrVal = new ArrayList();
				arrVal.add(rs.getString("doc_code"));  
				arrVal.add(rs.getString("doc_desc")); 
				arrData.add(arrVal);
			}
			
			hshResult.put("arrDocbybankdet", arrData);	
			if(rs!=null)
				rs.close();
			
			
			
			// for fetching total Means
			
			
			
			String curDate="";
			String strDesc="";
			String strCurDate="";
			String cma="";
			
			
			
			
			if(rs!=null)
				rs.close();
			
			String baseyear_query = SQLParser.getSqlQuery("sel_financial_baseyear^"+strAppno);
			rs = DBUtils.executeQuery(baseyear_query);
			
			if(rs.next())
			{	
				curDate=Helper.correctNull((String)rs.getString("base_year"));
				hshResult.put("base_year",correctNull((String)rs.getString("base_year")));
			}
			
			
			strQuery = SQLParser.getSqlQuery("executive_finselect9^"+strAppno+"^"+"0"+"^"+curDate);
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			
			
			if(rs.next())
			{
				if(rs.getDouble("sumaudit")>0)
				{
					strDesc="a";
				}
				else if(rs.getDouble("sumunaudit")>0)
				{
					strDesc="u";
				}
				else if(rs.getDouble("sumestimated")>0)
				{
					strDesc="e";
				}
				else if(rs.getDouble("sumprojection")>0)
				{
					strDesc="p";
				}
				strCurDate=rs.getString("fin_year");

			}
			
			strQuery = SQLParser.getSqlQuery("comfintrendsel1^"+strAppno);

			if(rs!=null)
				rs.close();

			rs = DBUtils.executeQuery(strQuery);
				 
			if(rs.next())
			{  
				cma=rs.getString("demo_finstandard");					
			}
			
			if(cma !="")
			{
				strQuery = SQLParser.getSqlQuery("sel_tangiblenetworth^"+cma);
			}
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
		
			String strRowtype="";
			String strRowid="";
			int strRowformula=0;
			int strRowformula2=0;
			String strTangibleNetworth="";
			
			if (rs.next())
			{
				strRowtype=correctNull(rs.getString("fin_rowtype"));
				strRowid=correctNull(rs.getString("fin_rowid"));
				strRowformula=rs.getInt("fin_formula");
				strRowformula2=rs.getInt("fin_formula2");
				
				if (strRowtype.trim().equals("C") && strRowformula>0 && !strDesc.trim().equals(""))
				{						
					HashMap hashformula =  new HashMap();
					hashformula.put("appno",strAppno);
					hashformula.put("sel_divID","0");
					hashformula.put("formulaid",Integer.toString(strRowformula));
					hashformula.put("curryear",strCurDate);
					hashformula.put("prevyear","");
					hashformula.put("currfinancialtype",strDesc);
					hashformula.put("prevfinancialtype","");
					hshResult1 = (HashMap)EJBInvoker.executeStateLess("comformula",hashformula,"GetFinValue");
					strTangibleNetworth=correctNull((String)hshResult1.get("strTotalValue"));
				}
			 }
			hshResult.put("hshResult1",hshResult1);
			hshResult.put("TangibleNetworth",strTangibleNetworth);
			hshResult.put("meansason",strCurDate);
			
			if(rs1!=null)
			{
				rs1.close();
			}	
			
			
			
		
	//Collateral Security	
		if (rs != null)
			rs.close();
		arrData=new ArrayList();
	    rs = DBUtils.executeLAPSQuery("selsecuritybytype^" + strAppno+"^Collateral");
		while (rs.next()) {
			arrVal = new ArrayList();
			arrVal.add(rs.getString("sec_desc_details"));
			arrVal.add(rs.getString("sec_desc_value"));
			arrVal.add(rs.getString("as_on_date"));
			arrVal.add(rs.getString("sec_valuersname"));
			arrVal.add(rs.getString("sec_insuranceamt"));
			arrVal.add(rs.getString("sec_insexpirydate"));
			arrVal.add(rs.getString("sec_remarks"));
    		arrData.add(arrVal);

		}
		hshResult.put("arrColldetails", arrData);
		
		
		if (rs != null)
			rs.close();
		
		//for terms and conditions
		arrData=new ArrayList();
		strQuery=SQLParser.getSqlQuery("seltermsandconditionval^"+strAppno);
		rs=DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			ArrayList arrCol = new ArrayList();
			arrCol.add(correctNull(rs.getString("terms_termdesc")));
			arrData.add(arrCol);
		}
		hshResult.put("appterms",arrData);		
		
		
		
		//Personal Guarantee & Corporate Guarantee
		ArrayList arrGuarantors = new ArrayList();
		ArrayList arrCorpguarantee = new ArrayList();
		strQuery = SQLParser.getSqlQuery("compromoterselectionpromoters^"+strAppno);
    	if (rs != null)
			rs.close();
		rs = DBUtils.executeQuery(strQuery);
		String strCoAppExID="",strCoAppExType="",strCoAppID="",strCoAppType="";
		
		while (rs.next()) 
		{
			arrVal = new ArrayList();
			arrVal.add(correctNull(rs.getString("com_compdtfname")));
			arrVal.add(correctNull(rs.getString("com_compdtlname")));
			arrVal.add(correctNull(rs.getString("com_compdtmname")));
			arrVal.add(correctNull(rs.getString("com_compdaca")));
			String company_id = correctNull((String) rs.getString("com_compdtid"));
			
			strCoAppType			= correctNull(rs.getString("com_compdttype"));
			strCoAppID			= correctNull(rs.getString("com_oldlapsid"));
			if((strCoAppID.equalsIgnoreCase(strCoAppExID)) && (strCoAppType.equalsIgnoreCase(strCoAppExType)))
			continue;
			
			strQuery = SQLParser.getSqlQuery("selcreditreport2^" + strAppno + "^" + company_id);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) 
			{
				arrVal.add(correctNull(rs1.getString("CR_Total_MEANS")));
				arrVal.add(correctNull(rs1.getString("cr_meansason")));
			} 
			else
			{
				arrVal.add("0.00");
			}
			if(rs1!=null)
				rs1.close();
			arrVal.add(correctNull(rs.getString("com_compdexp")));
			arrVal.add(correctNull(rs.getString("com_background")));
			
			String strpromgua[] = correctNull(rs.getString("com_compdttype")).split("@");
			for (int i = 0; i < strpromgua.length; i++) 
			{
				if(strpromgua[i].equals("G")) 
				{
					String strGuaType=correctNull(rs.getString("COM_COMPDSEX"));
					if(strGuaType.trim().equals("Male") || strGuaType.trim().equals("Female"))
					  arrGuarantors.add(arrVal);
					else
						arrCorpguarantee.add(arrVal);
					
				}

			}
			
			strCoAppExID			= correctNull(rs.getString("com_oldlapsid"));
			strCoAppExType			= correctNull(rs.getString("com_compdttype"));
			
		}

		hshResult.put("arrGuarantors", arrGuarantors);
		hshResult.put("arrCorpguarantee", arrCorpguarantee);
		//End
		strQuery = SQLParser.getSqlQuery("execsel_port^" + strAppno);
		if (rs != null)
			rs.close();
		rs = DBUtils.executeQuery(strQuery);
		if (rs.next()) {
			hshResult.put("cmd_searchreport", correctNull(rs.getString("cmd_searchreport")));
			hshResult.put("exec_borrowertype", correctNull(rs.getString("exec_borrowertype")));
			hshResult.put("audit_notes", correctNull(Helper.CLOBToString(rs.getClob("audit_notes"))));
			hshResult.put("exec_date", correctNull(rs.getString("exec_date")));
			hshResult.put("sel_guaranteoffered", correctNull(rs.getString("exec_offercorpguarantee")));
			hshResult.put("sel_applicantguarantee", correctNull(rs.getString("exec_whetherapplco")));
			hshResult.put("exec_comments", correctNull(rs.getString("exec_comments_sisterconcern")).equals("")?"Nil":correctNull(rs.getString("exec_comments_sisterconcern")));
			hshResult.put("exec_sancauth", correctNull(rs.getString("exec_sancauth")));
			hshResult.put("exec_refno", correctNull(rs.getString("exec_refno")));
			hshResult.put("exec_mcm", correctNull(rs.getString("exec_mcm")));
			hshResult.put("exec_agendano", correctNull(rs.getString("exec_agendano")));
		}
		
		
		}
		catch(Exception e1)
		{
			throw new EJBException("Error closing connection.."+e1.toString());
		}
		finally
		{
			try
			{
				if(rs!=null)
					rs.close();
				
				if(rs1!=null)
					rs1.close();
				
				if(rs2!=null)
					rs2.close();
			
			}
			catch(Exception e)
			{
				log.error(e.toString());
			}
		}
	return hshResult;

	}
	public HashMap getCorpSanLetterAnnexuretwo(HashMap hshValues) 
	{
		HashMap hshResult = new HashMap();
		String strQuery=null;
		String strQuery1=null;
		ResultSet rs,rs1=null;
		String city_name="";
		String state_name="";
		String city_code="";
		String state_code="";
		String comappid="";
		String strAppno="";
		String comapporg_scode="";
		ArrayList arrVal = null;
		ArrayList arrData = null;
		int	intGroup =0;
		
		try
		{
			strAppno=(String)hshValues.get("appno");
			comappid=correctNull((String)hshValues.get("comappid"));
			strQuery = SQLParser.getSqlQuery("comfunsel3^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);	
			if (rs.next())
			{
				comappid=correctNull(rs.getString("demo_appid"));
				hshResult.put("proposalvaluesin",correctNull(rs.getString("app_valuesin")));
			}
		
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("comappmastersel^"+comappid);
			rs = DBUtils.executeQuery(strQuery);	
			if (rs.next())
			{ 
				hshResult.put("comapp_companyname",correctNull(rs.getString("comapp_companyname")));
				hshResult.put("comapp_ownership",correctNull(rs.getString("comapp_ownership")));//Organisation
				hshResult.put("comapp_businessnature",correctNull(rs.getString("comapp_businessnature")));
				hshResult.put("comapp_yrsinbusiness",correctNull(rs.getString("comapp_yrsinbusiness")));
				hshResult.put("comapp_regadd1",correctNull(rs.getString("comapp_regadd1")));
				hshResult.put("comapp_regadd2",correctNull(rs.getString("comapp_regadd2")));
				hshResult.put("comapp_regcity",correctNull(rs.getString("comapp_regcity")));
				hshResult.put("comapp_companyid",correctNull(rs.getString("comapp_companyid")));
				hshResult.put("comapp_regpin",correctNull(rs.getString("comapp_regpin")));
				city_code=correctNull(rs.getString("comapp_regcity"));
				comapporg_scode=correctNull(rs.getString("comapp_org_scode"));
				if(rs1!=null)
				rs1.close();
				if(!city_code.equalsIgnoreCase(""))
				{
					strQuery = SQLParser.getSqlQuery("selcitycode^"+city_code);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						city_name = correctNull((String)rs1.getString(1));
						state_code = correctNull((String)rs1.getString(2));
						if(!state_code.equalsIgnoreCase(""))
						{
							strQuery = SQLParser.getSqlQuery("selstatecode^"+state_code);
							if(rs1!=null)
							{
								rs1.close();
							}
							rs1 = DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{
								state_name = correctNull((String)rs1.getString(1));
						
							}
						}
					}
				}
			}
			hshResult.put("city_name",city_name);
			hshResult.put("state_name",state_name);
			arrData = new ArrayList();
			strQuery = SQLParser.getSqlQuery("facilities_select_approvestatus^" + strAppno +"^"+intGroup);
 			if(rs!=null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{	
  				intGroup = rs.getInt("facility_sno");
 				arrVal = new ArrayList();
				arrVal.add(correctNull(rs.getString("facility_headid")));
				arrVal.add(correctNull(rs.getString("facheaddesc")));
				arrVal.add(correctNull(rs.getString("facility_id")));
				arrVal.add(correctNull(rs.getString("facdesc")));
				arrVal.add(correctNull(rs.getString("facility_existing")));
				arrVal.add(correctNull(rs.getString("facility_proposed")));
				arrVal.add(correctNull(rs.getString("facility_sancamt")));
				arrVal.add(correctNull(rs.getString("facility_group")));
				arrData.add(arrVal);		

				if(rs1!=null)
					rs1.close();
				strQuery1 = SQLParser.getSqlQuery("facilities_select_approvestatus^" + strAppno+"^"+intGroup);
				rs1 = DBUtils.executeQuery(strQuery1);
				while(rs1.next())
				{
					arrVal = new ArrayList();
					arrVal.add(correctNull(rs1.getString("facility_headid")));
					arrVal.add(correctNull(rs1.getString("facheaddesc")));
					arrVal.add(correctNull(rs1.getString("facility_id")));
					arrVal.add(correctNull(rs1.getString("facdesc")));
					arrVal.add(correctNull(rs1.getString("facility_existing")));
					arrVal.add(correctNull(rs1.getString("facility_proposed")));
					arrVal.add(correctNull(rs1.getString("facility_sancamt")));
					arrVal.add(correctNull(rs1.getString("facility_group")));
					arrData.add(arrVal);			

				}
			}

		hshResult.put("arrFacilityDetails",arrData);
		hshResult.put("facAppno",strAppno);
		
		
		if(rs1!=null){
			rs1.close();
		}
		strQuery = SQLParser.getSqlQuery("setorgselectscode^"+comapporg_scode);
		rs1 = DBUtils.executeQuery(strQuery);
		if(rs1.next())
		{
			hshResult.put("organisationname",correctNull(rs1.getString("org_name")));
			hshResult.put("organisationaddr1",correctNull(rs1.getString("org_add1")));
			hshResult.put("organisationaddr2",correctNull(rs1.getString("org_add2")));
			hshResult.put("organisationcity",correctNull(rs1.getString("city_name")));
			hshResult.put("organisationstate",correctNull(rs1.getString("state_name")));
			hshResult.put("organisationpin",correctNull(rs1.getString("org_zip")));
			hshResult.put("organisationphone",correctNull(rs1.getString("org_phone")));
		}
		
		}
		catch(Exception e1)
		{
			throw new EJBException("Error in updateTermsofSanctionFacilityData method"+e1);
		}
		finally
		{
			try
			{
				if(rs1!=null)
					rs1.close();
			
			}
			catch(Exception e)
			{
				log.error(e.toString());
			}
		}
	return hshResult;

	}
	public HashMap getTertiarySanctionletter(HashMap hshValues) 
	{
		HashMap hshResult = new HashMap();
		String strQuery="";
		String processeddate="";
		//String approvedby="";
		ResultSet rs,rs2=null;
		ResultSet rs1=null;
		ResultSet rs3=null;
		ResultSet rs4=null;
		String OrgCode="";
		String city_name="";
		String state_name="";
		String city_code="";
		String state_code="";
		String comappid="";
		String strAppno="";
		String strSelsno="";
		//double dblExist=0.00,dblProposed=0.00,dblMargin=0.00;
		//ArrayList vecVal = null;
		ArrayList vecVal1 = null;
		//ArrayList vecData = new ArrayList();
		ArrayList vecData1 = new ArrayList();
		ArrayList arrRow=new ArrayList();
		ArrayList arrFac=null;
		ArrayList arrFac1=new ArrayList();
		//String strrepay="";
		int dblinstall=0;
		int dblinstall1=0;
		String strWC="12 months";
		String strAppid="";
		try
		{
			OrgCode=correctNull((String) hshValues.get("strOrgCode"));
			strAppno=(String)hshValues.get("appno");
			comappid=correctNull((String)hshValues.get("comappid"));
			strSelsno ="0"; //correctNull((String)hshValues.get("selsno"));
			strAppid="N";
			strQuery = SQLParser.getSqlQuery("comfunsel4^"+strAppno+"^"+strAppid);
			rs = DBUtils.executeQuery(strQuery);	
			if (rs.next())
			{
				comappid=correctNull(rs.getString("demo_appid"));
			}
			if(rs!=null)
				rs.close();
			
			strQuery = SQLParser.getSqlQuery("setorgselect^"+OrgCode);//Location-->branchin from organisation 
			rs = DBUtils.executeQuery(strQuery);	
			if (rs.next())
			{
				hshResult.put("org_name",correctNull(rs.getString("org_name")));
				hshResult.put("org_add1",correctNull(rs.getString("org_add1")));
				hshResult.put("org_add2",correctNull(rs.getString("org_add2")));
				hshResult.put("org_cityname",correctNull(rs.getString("city_name")));
				hshResult.put("org_statename",correctNull(rs.getString("state_name")));
				hshResult.put("org_zip",correctNull(rs.getString("org_zip")));
				hshResult.put("org_phone",correctNull(rs.getString("org_phone")));
			}
			if(rs!=null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("selapproved^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				processeddate=correctNull((String)rs.getString("app_processdate"));
				//approvedby=correctNull((String)rs.getString("app_approvedby"));
				hshResult.put("appcreatedate",correctNull(rs.getString("appcreatedate")));
			}
		
			hshResult.put("processeddate",processeddate);	
		
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("mastgetdemographics^"+comappid);
			rs = DBUtils.executeQuery(strQuery);	
			while (rs.next())
			{ 
				hshResult.put("perapp_title",correctNull(rs.getString("perapp_title")));
				hshResult.put("perapp_fname",correctNull(rs.getString("perapp_fname")));
				hshResult.put("perapp_address1",correctNull(rs.getString("perapp_address1")));//Organisation
				hshResult.put("perapp_address2",correctNull(rs.getString("perapp_address2")));
				hshResult.put("perapp_address3",correctNull(rs.getString("perapp_address3")));
				hshResult.put("perapp_city",correctNull(rs.getString("perapp_city")));
				hshResult.put("perapp_state",correctNull(rs.getString("perapp_state")));
				hshResult.put("perapp_zip",correctNull(rs.getString("perapp_zip")));
								
				city_code=correctNull(rs.getString("perapp_city"));
				if(rs1!=null)
				{
					rs1.close();
				}
				if(!city_code.equalsIgnoreCase(""))
				{
					strQuery = SQLParser.getSqlQuery("selcitycode^"+city_code);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						city_name = correctNull((String)rs1.getString(1));
						state_code = correctNull((String)rs1.getString(2));
						if(!state_code.equalsIgnoreCase(""))
						{
							strQuery = SQLParser.getSqlQuery("selstatecode^"+state_code);
							if(rs1!=null)
							{
								rs1.close();
							}
							rs1 = DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{
								state_name = correctNull((String)rs1.getString(1));
						
							}
						}
					}
				}
			}
			hshResult.put("city_name",city_name);
			hshResult.put("state_name",state_name);
			
			
			if(rs1!=null)
			{
				rs1.close();
			}	
		if(rs!=null)
		{
			rs.close();
		}
		
		strQuery = SQLParser.getSqlQuery("selopsfacilitylist^" + strAppno+"^"+strSelsno);					
		rs = DBUtils.executeQuery(strQuery);
		while (rs.next())
		{
			
				 arrFac=new ArrayList();
				
				 arrFac.add(correctNull((String)rs.getString("facdesc")));	
				 arrFac.add(correctNull((String)rs.getString("facility_existing")));
				 arrFac.add(correctNull((String)rs.getString("facility_proposed")));
				 arrFac.add(correctNull((String)rs.getString("facility_difference")));
				
				 		
				
					String strcode=correctNull((String)rs.getString("facility_code"));
					if(strcode.equalsIgnoreCase("TF"))
					{
						
						String facsno=correctNull((String)rs.getString("facility_sno")); 
						
						strQuery=SQLParser.getSqlQuery("selfacrepaymentvalue^"+strAppno+"^"+facsno);
						rs3=DBUtils.executeQuery(strQuery);
						boolean facstate=rs3.next();
						if(facstate)
						{
							
							String strinstall=correctNull((String)rs3.getString("repay_no_instalmt"));
							String strperiodicity=correctNull((String)rs3.getString("repay_periodicity"));
							dblinstall=Integer.parseInt(strinstall);
							
							if(strperiodicity.equalsIgnoreCase("M"))
							{
								dblinstall1=dblinstall*1;
							}
							else if(strperiodicity.equalsIgnoreCase("Q"))
							{
								dblinstall1=dblinstall*3;
							}
							else if(strperiodicity.equalsIgnoreCase("H"))
							{
								dblinstall1=dblinstall*6;
							}
							else if(strperiodicity.equalsIgnoreCase("Y"))
							{
								dblinstall1=dblinstall*12;
							}
							else
							{
								dblinstall1=12;
							}
							String strTinstall=Integer.toString(dblinstall1)+" "+"months";
							arrFac.add(correctNull((String)rs.getString("facility_margin")));
							arrFac.add(strTinstall);
						}
						else
						{
							arrFac.add("");
							arrFac.add("");
						}
					}
					else
					{
						arrFac.add("N.A");
						arrFac.add(strWC);
					}
					
					String strcatid=correctNull((String)rs.getString("facility_id"));
					strQuery=SQLParser.getSqlQuery("sel_sanction_details^"+strAppno+"^"+strcatid);
					rs4=DBUtils.executeQuery(strQuery);
					boolean bstate=rs4.next();
					
						if(bstate)
						{
							 arrFac.add(correctNull((String)rs4.getString("sanctioned_amt")));
						}
						else
							arrFac.add("");
				 
		 		 arrFac1.add(arrFac);
				}
					hshResult.put("arrFac1",arrFac1);
				 
					//for subsidy	 
				 
					 strQuery=SQLParser.getSqlQuery("sel_opssubsidy^"+strAppno);
					 rs2=DBUtils.executeQuery(strQuery);
					 if(rs2.next())
					 {
						 hshResult.put("subsidy",correctNull((String)rs2.getString("OPS_SUBSIDYAMT"))); 
						 						 
					 }
		
		strQuery = SQLParser.getSqlQuery("sel_corporatesanctioned_amount^" + strAppno);					
		rs = DBUtils.executeQuery(strQuery);
		while (rs.next())
		{
			
	     
		 vecVal1 = new ArrayList();
			
			vecVal1.add(correctNull((String)rs.getString("facility_name")));	
			vecVal1.add(correctNull((String)rs.getString("sanctioned_amt")));	
		//	vecVal1.add(correctNull((String)rs.getString("facility_proposed")));	
		//	vecVal1.add(correctNull((String)rs.getString("facility_difference")));	
			vecData1.add(vecVal1);	

		
		
		
		}
		hshResult.put("vecData1",vecData1);
		//For Terms and condition
		strQuery=SQLParser.getSqlQuery("seltermsandconditionval^"+strAppno);
		rs=DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			ArrayList arrCol = new ArrayList();
			arrCol.add(correctNull(rs.getString("terms_termdesc")));
			arrRow.add(arrCol);
		}
		hshResult.put("arrRow",arrRow);
		
		
		}

		catch(Exception e1)
		{
			throw new EJBException("Error closing connection.."+e1);
		}
		finally
		{
			try
			{
				if(rs1!=null)
					rs1.close();
			
			}
			catch(Exception e)
			{
				log.error(e.toString());
			}
		}
	return hshResult;

	}
	public HashMap getStaffLoanSanctionAdvice(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		String strQuery="";
		ResultSet rs = null;
				
		ArrayList vecData_doc = new ArrayList();
		ArrayList vecVal_doc=new ArrayList();
		
		ArrayList arrTerms=new ArrayList();
		ArrayList arrTermsId=new ArrayList();
		ArrayList arrTermsType=new ArrayList();
		
		String appno=correctNull((String)hshValues.get("strappno"));
		
		//String strOrgAdd1="",strOrgAdd2="",strOrgzip="",strOrgstate="",strOrgphone="",strOrgfax="",strOrgurl="",strorgname="";
		//String strCityName="",strOrgtaxid="",strBranchName="";
		
		String sancamount="";
		String code="";
		if(appno.equals(""))
		{
			appno=correctNull((String)hshValues.get("appno"));
		}
		
		
		//String strprdtype = correctNull((String)hshValues.get("strProductType"));
		//String comappid=correctNull((String)hshValues.get("comappid"));
		try
		{
			
			strQuery = SQLParser.getSqlQuery("selapplicant_byappno^"+appno+"^a");
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{	
				hshRecord.put("perapp_title",correctNull((String)rs.getString("perapp_title")));
				hshRecord.put("perapp_fname",correctNull((String)rs.getString("perapp_fname")));
				hshRecord.put("perapp_staffusrid",correctNull((String)rs.getString("perapp_staffusrid")));
				
									
			}
			
//			if(rs != null)
//			{
//				rs.close();
//				rs=null;
//			}
//			
//			
//			strQuery = SQLParser.getSqlQuery("selsanction_advicebranch^"+appno);
//			rs=DBUtils.executeQuery(strQuery);
//			if(rs.next())
//			{
//				hshRecord.put("org_name",correctNull((String)rs.getString("org_name")));
//			}
			
			if(rs !=null)
			{
				rs.close();
			}
			String strProdPurpose="",strVehicleType="";
			strQuery = SQLParser.getSqlQuery("selprodpurpose^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()){strProdPurpose=Helper.correctNull((String)rs.getString("prd_purpose"));
			strVehicleType=Helper.correctNull((String)rs.getString("prd_vehitype"));}
			/*
			 * 			For Purchase of Ready Built House and Used Vehicle loan, 
			 * 				Margin is based on age of the building / vehicle respectively
			 */
			if(strProdPurpose.equalsIgnoreCase("H") || strProdPurpose.equalsIgnoreCase("U")||strVehicleType.equalsIgnoreCase("2")) 
			{
				strQuery = SQLParser.getSqlQuery("pergetloanProductbymargin^" + appno);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("pergetloanProduct^" + appno);
			}
			if(rs !=null)
			{
				rs.close();
			}
			
			
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{					
				hshRecord.put("loan_purposeofloan",Helper.CLOBToString(rs.getClob("loan_purposeofloan")));
				hshRecord.put("loan_modintrate",correctNull((String)rs.getString("mintrate")));
				hshRecord.put("loan_costloanprd",correctNull((String)rs.getString("cloanprd")));
				hshRecord.put("loan_margin",correctNull((String)rs.getString("loan_margin")));
				hshRecord.put("loan_facility",correctNull((String)rs.getString("loan_facility")));
				hshRecord.put("loan_reqterms",correctNull((String)rs.getString("lreqterms")));
				sancamount=correctNull((String)rs.getString("sancamount"));
				code=correctNull((String)rs.getString("prdcode"));
				hshRecord.put("loan_recmdamt",sancamount);
			}
			
			strQuery = SQLParser.getSqlQuery("securesel^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
				hshRecord.put("loan_secure",correctNull((String)rs.getString("loan_secure")));
			}
			
			if(rs != null)
			{
				rs.close();
				rs=null;
			}
			strQuery = SQLParser.getSqlQuery("appdocssel^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{	
				vecData_doc = new ArrayList();
				vecData_doc.add(correctNull((String)rs.getString("doc_desc")));
				vecVal_doc.add(vecData_doc);
			}
			hshRecord.put("vecVal_doc",vecVal_doc);
			
			if(rs != null)
			{
				rs.close();
				rs=null;
			}
			rs=DBUtils.executeLAPSQuery("apptermscondsel^"+appno);
			while(rs.next())
			{
				arrTermsId.add(correctNull(rs.getString(1)));
				arrTerms.add(correctNull(rs.getString(2)));
				arrTermsType.add(correctNull(rs.getString(3)));
			}
			hshRecord.put("arrTermsId",arrTermsId);
			hshRecord.put("arrTerms",arrTerms);
			hshRecord.put("arrTermsType",arrTermsType);
			
//			String strorglevel="";
//			if(rs!=null)
//			{
//				rs.close();
//			}			
//			rs=DBUtils.executeLAPSQuery("selBranchCityName^"+appno);
//			if (rs.next())
//			{ 
//				strorgname=correctNull(rs.getString("org_name"));
//				strorglevel=correctNull(rs.getString("org_level"));
//				strCityName=correctNull(rs.getString("org_city"));
//				strOrgAdd1=correctNull(rs.getString("org_add1"));
//				strOrgAdd2=correctNull(rs.getString("org_add2"));
//				strOrgzip=correctNull(rs.getString("org_Zip"));
//				strOrgstate=correctNull(rs.getString("org_state"));
//				strOrgphone=correctNull(rs.getString("org_phone"));
//				strOrgfax=correctNull(rs.getString("org_fax"));
//				strOrgurl=correctNull(rs.getString("org_url"));		
//				strOrgtaxid=correctNull(rs.getString("org_taxid"));		
//			}
			
//			String orgcode=correctNull((String)hshValues.get("strOrgCode"));
//			String strRegion="";
//			if(!strorglevel.equalsIgnoreCase("C")){
//				String orgStartcode=orgcode.substring(0,6);
//				orgStartcode=orgStartcode+"%";
//				if(rs!=null)
//				{
//					rs.close();
//				}
//				rs=DBUtils.executeLAPSQuery("sel_region^"+orgStartcode);
//			if (rs.next())  
//			{ 
//				strRegion=rs.getString("org_name");
//			}
//		}
//		hshRecord.put("Region_Name",strRegion);	
		
		
//		rs3=DBUtils.executeLAPSQuery("getbranchname^"+appno);
//					
//		String flag = "";
//		while(rs3.next())
//		{
//			strBranchName=correctNull(rs3.getString("perapp_recfrom"));
//			flag="0";
//		}
//		if(rs3!=null)rs3.close();
//		
//		if(strBranchName==null || strBranchName.equals(""))
//		{
//			strBranchName=strorgname; 
//
//			flag="1";
//		}	
//		if(flag=="1")
//		{
//			hshRecord.put("cityName",strCityName);
//			hshRecord.put("strOrgAdd1",strOrgAdd1);
//			hshRecord.put("strOrgAdd2",strOrgAdd2);
//			hshRecord.put("strOrgzip",strOrgzip);
//			hshRecord.put("strOrgstate",strOrgstate);
//			hshRecord.put("strOrgphone",strOrgphone);
//			hshRecord.put("strOrgfax",strOrgfax);
//			hshRecord.put("strOrgurl",strOrgurl);
//			hshRecord.put("strOrgtaxid",strOrgtaxid);
//		}
//		hshRecord.put("flag",flag);
//		hshRecord.put("branchName",strBranchName);			
		if(rs != null)
		{
			rs.close();
			
		}
		
		ArrayList arrRowslab=new ArrayList();
		ArrayList arrColslab=new ArrayList();
		strQuery = SQLParser.getSqlQuery("sel_calslabrateRange2^" + code + "^" + sancamount + "^" + sancamount
				+ "^" + sancamount);
		if(rs!=null)
		{
			rs.close();
		}
		
		rs= DBUtils.executeQuery(strQuery); 
		while(rs.next())
		{  
			arrColslab = new ArrayList();
			arrColslab.add(rs.getString(1));
			arrColslab.add(rs.getString(2));
			arrColslab.add(rs.getString(3));
			arrRowslab.add(arrColslab);
		}
		hshRecord.put("arrRowslab",arrRowslab);
		
		//For From address
		strQuery = SQLParser.getSqlQuery("selapproved^"+appno);
		rs=DBUtils.executeQuery(strQuery);
		
		if(rs.next())
		{	
			hshRecord.put("usr_fname",correctNull((String)rs.getString("usr_fname")));
			hshRecord.put("user_designation",correctNull((String)rs.getString("user_designation")));
			hshRecord.put("app_processdate",correctNull((String)rs.getString("app_processdate")));
		}
		
		strQuery = SQLParser.getSqlQuery("approvedbyorgcode^"+appno);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{	
			hshRecord.put("approved_orgname",correctNull((String)rs.getString("org_name")));
			
			hshRecord.put("orgadd1",correctNull((String)rs.getString("org_add1")));
			hshRecord.put("orgadd2",correctNull((String)rs.getString("org_add2")));
			hshRecord.put("cityname",correctNull((String)rs.getString("city_name")));
			hshRecord.put("statename",correctNull((String)rs.getString("state_name")));
			hshRecord.put("orgzip",correctNull((String)rs.getString("org_zip")));
			hshRecord.put("orgphone",correctNull((String)rs.getString("org_phone")));
		}
		}
		catch(Exception e1)
		{
			throw new EJBException("Error closing connection.."+e1);
		}
		finally
		{
			try
			{
				if(rs!=null)
					rs.close();
			
			}
			catch(Exception e)
			{
				log.error(e.toString());
			}
		}
		return hshRecord;
	
		
	}
	
	public HashMap getCorporateSanctionAdvice(HashMap hshValues)
	{
		
		java.text.NumberFormat jtn= java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);	
		
		String cattype="";
		
		
		HashMap hshResult=new HashMap();
		HashMap hshResult1=new HashMap();
		ResultSet rs=null;
		ResultSet rs1=null;
		
		String strQuery="";
		String strAppno="";
		
		String comappid="";
		String city_code="",state_code="",city_name="",state_name="",comapporg_scode="";
		//String OrgCode="";
		
		
		//ArrayList OurBank_WC_Funded = new ArrayList();
		
		ArrayList OurBank_TL = new ArrayList();
		ArrayList arrRow6=new ArrayList();
		try
		{
				cattype=correctNull((String) hshValues.get("cattype"));
				if(cattype.equalsIgnoreCase(""))
				{
					cattype=correctNull((String) hshValues.get("cattype1"));
				}
				//OrgCode=correctNull((String) hshValues.get("strOrgCode"));
				strAppno = correctNull((String) hshValues.get("comm_appno"));
				if(strAppno.equalsIgnoreCase(""))
				{
					strAppno = correctNull((String) hshValues.get("appno"));
				}
				if(rs!=null)
				{
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("comfunsel3^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
					comappid=correctNull(rs.getString("demo_appid"));
					hshResult.put("proposalvaluesin",correctNull(rs.getString("app_valuesin")));
				}
				if(rs!=null)
				{
					rs.close();
				}
				//strQuery = SQLParser.getSqlQuery("setorgselect^"+OrgCode);//Location-->branchin from organisation 
			//	rs = DBUtils.executeQuery(strQuery);	
				//if (rs.next())
				//{
				//	hshResult.put("org_branchIn",correctNull(rs.getString("org_branchIn")));
			//	}
				//if(rs!=null)
			//	{
			//		rs.close();
			//	}
				
				strQuery = SQLParser.getSqlQuery("comappmastersel^"+comappid);
				rs = DBUtils.executeQuery(strQuery);	
				while (rs.next())
				{ 
					hshResult.put("comapp_companyname",correctNull(rs.getString("comapp_companyname")));
					hshResult.put("comapp_ownership",correctNull(rs.getString("comapp_ownership")));//Organisation
					hshResult.put("comapp_businessnature",correctNull(rs.getString("comapp_businessnature")));
					hshResult.put("comapp_yrsinbusiness",correctNull(rs.getString("comapp_yrsinbusiness")));
					hshResult.put("comapp_regadd1",correctNull(rs.getString("comapp_regadd1")));
					hshResult.put("comapp_regadd2",correctNull(rs.getString("comapp_regadd2")));
					hshResult.put("comapp_regcity",correctNull(rs.getString("comapp_regcity")));
					hshResult.put("comapp_companyid",correctNull(rs.getString("comapp_companyid")));
					hshResult.put("comapp_regpin",correctNull(rs.getString("comapp_regpin")));
					//hshResult.put("comapp_scode",correctNull(rs.getString("comapp_scode")));
					
					comapporg_scode=correctNull(rs.getString("comapp_org_scode"));
					if(rs1!=null){
						rs1.close();
					}
					strQuery = SQLParser.getSqlQuery("setorgselectapp^"+comapporg_scode);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						hshResult.put("org_branchIn",correctNull(rs1.getString("org_branchIn")));	
					}
					
					city_code=correctNull(rs.getString("comapp_regcity"));
					if(rs1!=null)
					{
						rs1.close();
					}
					if(!city_code.equalsIgnoreCase(""))
					{
					strQuery = SQLParser.getSqlQuery("selcitycode^"+city_code);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						city_name = Helper.correctNull((String)rs1.getString(1));
						state_code = Helper.correctNull((String)rs1.getString(2));
						if(!state_code.equalsIgnoreCase(""))
						{
							strQuery = SQLParser.getSqlQuery("selstatecode^"+state_code);
							rs1 = DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{
								state_name = Helper.correctNull((String)rs1.getString(1));
								
							}
						}
					}
					}
				}
					hshResult.put("city_name",city_name);
					hshResult.put("state_name",state_name);
					if(rs1!=null)
					{
						rs1.close();
					}	
					strQuery = SQLParser.getSqlQuery("selapproved^"+strAppno);//processed date and by
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						
						hshResult.put("app_processdate",correctNull((String)rs.getString("app_processdate")));
						hshResult.put("app_approvedby",correctNull((String)rs.getString("app_approvedby")));
						hshResult.put("sanctionedauthority",correctNull((String)rs.getString("usr_fname")));
						hshResult.put("sanc_auth_design",correctNull((String)rs.getString("user_designation")));
						hshResult.put("halfyearreview",correctNull((String)rs.getString("halfyearreview")));
						hshResult.put("nextreviewdate",correctNull((String)rs.getString("app_reviewdate")));
						hshResult.put("appcreatedate",correctNull((String)rs.getString("appcreatedate")));
					}
					if(rs!=null)
					{
						rs.close();
					}
					strQuery = SQLParser.getSqlQuery("execsel_port^"+strAppno);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						
						hshResult.put("exec_date",correctNull((String)rs.getString("exec_date")));
						hshResult.put("sel_applicantguarantee", correctNull(rs.getString("exec_whetherapplco")));
					}
					
					String curDate="";
					String strDesc="";
					String strCurDate="";
					String cma="";
					
					
					curDate=Helper.getCurrentDateTime();
					
					if(rs!=null)
						rs.close();
					
					String baseyear_query = SQLParser.getSqlQuery("sel_financial_baseyear^"+strAppno);
					rs = DBUtils.executeQuery(baseyear_query);
					
					if(rs.next())
					{	
						curDate=Helper.correctNull((String)rs.getString("base_year"));
						hshResult.put("base_year",correctNull((String)rs.getString("base_year")));
					}
					
					
					strQuery = SQLParser.getSqlQuery("executive_finselect9^"+strAppno+"^"+"0"+"^"+curDate);
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeQuery(strQuery);
					
					
					if(rs.next())
					{
						if(rs.getDouble("sumaudit")>0)
						{
							strDesc="a";
						}
						else if(rs.getDouble("sumunaudit")>0)
						{
							strDesc="u";
						}
						else if(rs.getDouble("sumestimated")>0)
						{
							strDesc="e";
						}
						else if(rs.getDouble("sumprojection")>0)
						{
							strDesc="p";
						}
						strCurDate=rs.getString("fin_year");

					}
					
					strQuery = SQLParser.getSqlQuery("comfintrendsel1^"+strAppno);

					if(rs!=null)
						rs.close();

					rs = DBUtils.executeQuery(strQuery);
						 
					if(rs.next())
					{  
						cma=rs.getString("demo_finstandard");					
					}
					
					if(cma !="")
					{
						strQuery = SQLParser.getSqlQuery("sel_tangiblenetworth^"+cma);
					}
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeQuery(strQuery);
				
					String strRowtype="";
					String strRowid="";
					int strRowformula=0;
					int strRowformula2=0;
					String strTangibleNetworth="";
					
					if (rs.next())
					{
						strRowtype=correctNull(rs.getString("fin_rowtype"));
						strRowid=correctNull(rs.getString("fin_rowid"));
						strRowformula=rs.getInt("fin_formula");
						strRowformula2=rs.getInt("fin_formula2");
						
						if (strRowtype.trim().equals("C") && strRowformula>0 && !strDesc.trim().equals(""))
						{						
							HashMap hashformula =  new HashMap();
							hashformula.put("appno",strAppno);
							hashformula.put("sel_divID","0");
							hashformula.put("formulaid",Integer.toString(strRowformula));
							hashformula.put("curryear",strCurDate);
							hashformula.put("prevyear","");
							hashformula.put("currfinancialtype",strDesc);
							hashformula.put("prevfinancialtype","");
							hshResult1 = (HashMap)EJBInvoker.executeStateLess("comformula",hashformula,"GetFinValue");
							strTangibleNetworth=correctNull((String)hshResult1.get("strTotalValue"));
						}
					 }
					hshResult.put("hshResult1",hshResult1);
					hshResult.put("TangibleNetworth",strTangibleNetworth);
					hshResult.put("meansason",strCurDate);
					
					if(rs1!=null)
					{
						rs1.close();
					}	
					strQuery = SQLParser.getSqlQuery("compropform8^"+strAppno);//status-->Asset classification
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshResult.put("com_propassettype",correctNull((String)rs.getString("com_propassettype")));
					}
					if(rs1!=null)
					{
						rs1.close();
					}	
					strQuery = SQLParser.getSqlQuery("sel_rocchargedate^"+strAppno);//ROC-details
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshResult.put("roccharges",correctNull((String)rs.getString("roccharges")));
						hshResult.put("rocchargedate",correctNull((String)rs.getString("rocchargedate")));
						
						
					}
					if(rs1!=null)
					{
						rs1.close();
					}
					
					//ArrayList document=null;
					//ArrayList documents=new ArrayList();
					//OurBank_WC_Funded = new ArrayList();
					OurBank_TL = new ArrayList();
					//int d2b=0;
					//int d2=0;
					
					
					
					
					if(rs!=null)
					{	rs.close();	
					}	
					double dblExist=0.00;
					double dblproposed=0.00;
					String disp="";
					int intGroup=0;
					//String strExist="",strProposed="";
					strQuery = SQLParser.getSqlQuery("facilities_select_approvestatus^" + strAppno +"^"+intGroup);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						
						ArrayList TL_Funded_NonFunded=new ArrayList();
						String strFacSno = Helper.correctNull((String)rs.getString("facility_sno"));
						TL_Funded_NonFunded.add(strFacSno);
						TL_Funded_NonFunded.add(correctNull(rs.getString("facdesc")));
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_existing")));
						
						dblExist =rs.getDouble("facility_existing");
						
						dblproposed =rs.getDouble("facility_proposed");
						
						if(dblExist==0.0 && dblproposed>0.0)
						{
							disp="New";
						}
						
						else if(dblExist!=0.0 && dblproposed==dblExist)
						{
							disp="Renewal";
						}
						else if(dblExist!=0.0 && (dblproposed<dblExist || dblproposed>dblExist))
						{
							disp="Modification";
						}
						
						TL_Funded_NonFunded.add(disp);
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_sancamt")));
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_margin")));
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_sancintremarks")));	
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_dp")));
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_outstanding")));
						TL_Funded_NonFunded.add(correctNull(rs.getString("security_value")));
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_desc")));
						//TL_Funded_NonFunded.add(correctNull(rs.getString("sec_security_mode")));
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_interest")));
						TL_Funded_NonFunded.add(correctNull(rs.getString("bplr")));
						
				//By venu for sublimit & security
						ArrayList arrSubFac = new ArrayList();
						arrSubFac = getSubFacilitiesData(strAppno,strFacSno);
						TL_Funded_NonFunded.add(arrSubFac);
			    // End of sublimit			
					
						ArrayList arrDocuments=new ArrayList();
						if(rs1!=null)
						{	rs1.close();	
						}	
						strQuery = SQLParser.getSqlQuery("selcomfacilitydocuments_corsanctionadvice^"+strFacSno+"^"+strAppno);
						rs1 = DBUtils.executeQuery(strQuery);
						while(rs1.next())
						{	
							arrDocuments.add(correctNull(rs1.getString(1)));
							 
						}
						TL_Funded_NonFunded.add(arrDocuments);
						ArrayList arrSecurity=new ArrayList();					
						strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^"+strFacSno+"^"+strAppno);
						if(rs1!=null)
						{	rs1.close();	
						}	
						rs1 = DBUtils.executeQuery(strQuery);
						int j=0;
						while(rs1.next())
						{
							ArrayList arrCol=new ArrayList();
							arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
							arrCol.add(correctNull(rs1.getString("sec_margin")));
							arrCol.add(correctNull(rs1.getString("sec_charge")));
							arrSecurity.add(arrCol);
							j++;
						
						}
					
						TL_Funded_NonFunded.add(arrSecurity);
				    	TL_Funded_NonFunded.add(correctNull(rs.getString("facility_headid")));
				    	TL_Funded_NonFunded.add(correctNull(rs.getString("facility_category")));
				    	TL_Funded_NonFunded.add(correctNull(rs.getString("facility_months")));
				    	TL_Funded_NonFunded.add(""+j);
						OurBank_TL.add(TL_Funded_NonFunded);
					}
					
					// for getting the organisation code of the approved authority
					String  approvedorgscode="", comapp_org_scode="",
					//String approvedorgcode="";
						comapp_org_code="";
					if(rs1 != null)
					{
						rs1.close();
					}
					strQuery = SQLParser.getSqlQuery("approvedbyorgcode^"+strAppno);
					rs1 = DBUtils.executeQuery(strQuery);
					
					if(rs1.next())
					{
						//approvedorgcode=correctNull((String)rs1.getString("usr_orgcode"));
						approvedorgscode=correctNull((String)rs1.getString("org_scode"));
					}
					
					
					
					if(rs1 != null)
					{
						rs1.close();
					}
					
					strQuery = SQLParser.getSqlQuery("applicant_create_code^"+strAppno);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						comapp_org_scode=correctNull((String)rs1.getString("comapp_org_scode"));
						comapp_org_code=correctNull((String)rs1.getString("comapp_org_code"));
						hshResult.put("appCreationBranch",Helper.correctNull((String)rs1.getString("org_name")));
						hshResult.put("appCreationAddress",Helper.correctNull((String)rs1.getString("address")));
						hshResult.put("appCreationCity",Helper.correctNull((String)rs1.getString("org_city")));
						hshResult.put("appCreationState",Helper.correctNull((String)rs1.getString("org_state")));
						hshResult.put("appCreationpin",Helper.correctNull((String)rs1.getString("org_zip")));
						
						
						
					}
					
					if(comapp_org_scode.equalsIgnoreCase(approvedorgscode))
					{
						int code=comapp_org_code.length();
						if(code==12)
						{
							comapp_org_code=comapp_org_code+"000";
						}
						if(code==9)
						{
							comapp_org_code=comapp_org_code+"000000";
						}
						if(code==6)
						{
							comapp_org_code=comapp_org_code+"000000000";
						}
						if(code==3)
						{
							comapp_org_code=comapp_org_code+"000000000000";
						}
						strQuery = SQLParser.getSqlQuery("setorgselect^"+comapp_org_code);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							hshResult.put("RespectiveBranch",Helper.correctNull((String)rs.getString("org_name")));
							hshResult.put("org_add1",correctNull(rs.getString("org_add1")));
							hshResult.put("org_add2",correctNull(rs.getString("org_add2")));
							hshResult.put("org_cityname",correctNull(rs.getString("city_name")));
							hshResult.put("org_statename",correctNull(rs.getString("state_name")));
							hshResult.put("org_zip",correctNull(rs.getString("org_zip")));
							hshResult.put("org_phone",correctNull(rs.getString("org_phone")));
							
						}
					}
					else
					{
						int code=comapp_org_code.length();
						if(code==12)
						{
							comapp_org_code=comapp_org_code.substring(0,9);
							comapp_org_code=comapp_org_code+"000000";
						}
						if(code==9)
						{
							comapp_org_code=comapp_org_code.substring(0,6);
							comapp_org_code=comapp_org_code+"000000000";
									
						}
						if(code==6)
						{
							comapp_org_code=comapp_org_code.substring(0,3);
							comapp_org_code=comapp_org_code+"000000000000";
						}
						if(code==3)
						{
							//comapp_org_code=comapp_org_code.substring(0,5);
							comapp_org_code=comapp_org_code+"000000000000";
						}
						strQuery = SQLParser.getSqlQuery("setorgselect^"+comapp_org_code);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							hshResult.put("RespectiveBranch",Helper.correctNull((String)rs.getString("org_name")));
							hshResult.put("org_add1",correctNull(rs.getString("org_add1")));
							hshResult.put("org_add2",correctNull(rs.getString("org_add2")));
							hshResult.put("org_cityname",correctNull(rs.getString("city_name")));
							hshResult.put("org_statename",correctNull(rs.getString("state_name")));
							hshResult.put("org_zip",correctNull(rs.getString("org_zip")));
							hshResult.put("org_phone",correctNull(rs.getString("org_phone")));
						}
						
					}
					
							//For Corporate Guarantor
								strQuery = SQLParser.getSqlQuery("compromoterselectionguar1^"+strAppno);
								
								if(rs!=null)
									rs.close();
									rs = DBUtils.executeQuery(strQuery);
									while(rs.next())
									{
										ArrayList arrVec6 = new ArrayList();
										
										arrVec6.add(correctNull(rs.getString("com_compdtfname")));
										arrVec6.add(correctNull(rs.getString("com_compdtlname")));
										String company_id = Helper.correctNull((String)rs.getString("com_compdtid"));
										if(rs1!=null)
										{
											rs1.close();
										}
										strQuery = SQLParser.getSqlQuery("selcreditreport2^"+strAppno+"^"+company_id);
										rs1 = DBUtils.executeQuery(strQuery);
										if(rs1.next())
										{
											arrVec6.add(correctNull(rs1.getString("CR_Total_MEANS")));
											arrVec6.add(correctNull(rs1.getString("cr_meansason")));
										}
										else
										{
											arrVec6.add("0.00");
											arrVec6.add("");
										}
										arrRow6.add(arrVec6);
									}
									hshResult.put("arrRow6",arrRow6);
									//Added by Mercy for including Collateral Security
									
									ArrayList arrColl = new ArrayList();
									strQuery = SQLParser.getSqlQuery("selsecuritybytype^"+strAppno+"^Collateral");
									if(rs1!=null)rs1.close();
									rs1 = DBUtils.executeQuery(strQuery);
									while(rs1.next())
									{
										arrColl.add(correctNull(rs1.getString("sec_desc_details")));
									}		
					hshResult.put("arrColl",arrColl);				
					hshResult.put("OurBank_TL",OurBank_TL);
					hshResult.put("strAppno",strAppno);
					hshResult.put("cattype",cattype);
			}
			catch(Exception ce)
			{
				throw new EJBException("Error in getCorporateSanctionAdvice-- "+ce.toString());
			}
			finally
			{
				try
				{	if(rs != null)
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
					throw new EJBException("Error closing the connection -getCorporateSanctionAdvice"+cf.getMessage());
				}
			}
			return hshResult;
		}
	
	public HashMap getTertiarySanctionAdvice(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		HashMap hshResult1=new HashMap();
		
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		
		String cattype="";
		String strQuery="";
		String strAppno="";
		String comappid="";
		String city_code="";
		String state_code="";
		String city_name="";
		String state_name="";
		String comapporg_scode="";
		//String OrgCode="";
		String strconstitution="";
		
		//ArrayList arrOurBank = new ArrayList();
		//ArrayList OurBank_WC_Funded = new ArrayList();
		//ArrayList OurBank_WC_NonFunded = new ArrayList();
		ArrayList OurBank_TL = new ArrayList();
		ArrayList arrRow4=new ArrayList();
		try
		{
			cattype=correctNull((String) hshValues.get("cattype"));
			if(cattype.equalsIgnoreCase(""))
			{
				cattype=correctNull((String) hshValues.get("cattype1"));
			}
			//OrgCode=correctNull((String) hshValues.get("strOrgCode"));
			strAppno = correctNull((String) hshValues.get("appno"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno = correctNull((String) hshValues.get("comm_appno"));
			}

			if(rs2!=null)
				rs2.close();
			String apptype="N";
			strQuery = SQLParser.getSqlQuery("comfunsel4^"+strAppno+"^"+apptype);
			rs2=DBUtils.executeQuery(strQuery);
			if(rs2.next())
				comappid=correctNull(rs2.getString("demo_appid"));
			
			if(rs2!=null)
				rs2.close();
				
			//for retrieving customer information from perapplicant
			strQuery = SQLParser.getSqlQuery("mastgetdemographics^"+comappid);
			rs = DBUtils.executeQuery(strQuery);	
			while (rs.next())
			{ 
				hshResult.put("comapp_companyname",correctNull(rs.getString("perapp_title"))+". "+correctNull(rs.getString("perapp_fname")));
				strconstitution=correctNull(rs.getString("perapp_constitution"));
				hshResult.put("comapp_ownership",strconstitution);//Constituition
				hshResult.put("comapp_businessnature",correctNull(rs.getString("perapp_eduothers")));
				hshResult.put("comapp_yrsinbusiness",correctNull(rs.getString("perapp_dob")));
				hshResult.put("comapp_regadd1",correctNull(rs.getString("perapp_address1")));
				hshResult.put("comapp_regadd2",correctNull(rs.getString("perapp_address2")));
				hshResult.put("comapp_regcity",correctNull(rs.getString("perapp_city")));
				hshResult.put("comapp_regpin",correctNull(rs.getString("perapp_zip")));
				//hshResult.put("org_branchIn",correctNull(rs.getString("org_name")));	
				
				hshResult.put("comapp_companyid",correctNull(rs.getString("perapp_indcode"))+"-"+correctNull(rs.getString("perapp_companyname")));	
				comapporg_scode=correctNull(rs.getString("perapp_branchcode"));
				if(rs1!=null){
					rs1.close();
				}
				strQuery = SQLParser.getSqlQuery("setorgselectapp^"+comapporg_scode);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					hshResult.put("org_branchIn",correctNull(rs1.getString("org_branchIn")));	
				}
				
				city_code=correctNull(rs.getString("perapp_city"));
				if(rs1!=null)
				{
					rs1.close();
				}
				if(!city_code.equalsIgnoreCase(""))
				{
					strQuery = SQLParser.getSqlQuery("selcitycode^"+city_code);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						city_name = Helper.correctNull((String)rs1.getString(1));
						state_code = Helper.correctNull((String)rs1.getString(2));
						if(!state_code.equalsIgnoreCase(""))
						{
							strQuery = SQLParser.getSqlQuery("selstatecode^"+state_code);
							rs1 = DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{
								state_name = Helper.correctNull((String)rs1.getString(1));
								
							}
						}
					}
				}
			}
			hshResult.put("city_name",city_name);
			hshResult.put("state_name",state_name);
			if(rs1!=null)
				rs1.close();

			strQuery = SQLParser.getSqlQuery("selapproved^"+strAppno);//processed date and by
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("app_processdate",correctNull((String)rs.getString("app_processdate")));
				hshResult.put("app_approvedby",correctNull((String)rs.getString("app_approvedby")));
				hshResult.put("sanctionedauthority",correctNull((String)rs.getString("usr_fname")));
				hshResult.put("sanc_auth_design",correctNull((String)rs.getString("user_designation")));
				hshResult.put("halfyearreview",correctNull((String)rs.getString("halfyearreview")));
				hshResult.put("nextreviewdate",correctNull((String)rs.getString("app_reviewdate")));
				hshResult.put("yearreview",correctNull((String)rs.getString("yearreview")));
				hshResult.put("appcreatedate",correctNull((String)rs.getString("appcreatedate")));
			}
					
					/**********************************************************************************
					 * By sureshkumar Ganapathy
					 * Logic for getting the Networth of the applicant
					 * 
					 * if the applicant's constitution is individual or joint individual then take the
					 * networth from credit report
					 * else
					 * take networth from financial (Tangible NetWorth) 
					 *************************************************************************************/
					if(rs!=null)
					{
						rs.close();
					}
					if(strconstitution.equalsIgnoreCase("01") || strconstitution.equalsIgnoreCase("02"))
					{
						strQuery=SQLParser.getSqlQuery("selcreditreport2^"+strAppno+"^"+comappid); 
						if(rs!=null)
						{
							rs.close();
						}
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							hshResult.put("TangibleNetworth",correctNull((String)rs.getString("CR_Total_MEANS")));
							hshResult.put("base_year",correctNull((String)rs.getString("cr_meansason")));
							hshResult.put("meansason",correctNull((String)rs.getString("cr_meansason")));
						}
					}
					else
					{
						strQuery = SQLParser.getSqlQuery("execsel_port^"+strAppno);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							hshResult.put("exec_date",correctNull((String)rs.getString("exec_date")));
						}
						
						String curDate="";
						String strDesc="";
						String strCurDate="";
						String cma="";
						
						curDate=Helper.getCurrentDateTime();
					
						if(rs!=null)
							rs.close();
					
						String baseyear_query = SQLParser.getSqlQuery("sel_financial_baseyear^"+strAppno);
						rs = DBUtils.executeQuery(baseyear_query);
						if(rs.next())
						{	
							curDate=Helper.correctNull((String)rs.getString("base_year"));
							hshResult.put("base_year",correctNull((String)rs.getString("base_year")));
						}
						
						strQuery = SQLParser.getSqlQuery("executive_finselect9^"+strAppno+"^"+"0"+"^"+curDate);
						if(rs!=null) rs.close();
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							if(rs.getDouble("sumaudit")>0)
								strDesc="a";
							else if(rs.getDouble("sumunaudit")>0)
								strDesc="u";
							else if(rs.getDouble("sumestimated")>0)
								strDesc="e";
							else if(rs.getDouble("sumprojection")>0)
								strDesc="p";
							strCurDate=rs.getString("fin_year");
						}
					
						strQuery = SQLParser.getSqlQuery("comfintrendsel1^"+strAppno);
						if(rs!=null)
							rs.close();
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{  
							cma=rs.getString("demo_finstandard");					
						}
					
						if(cma !="")
						{
							strQuery = SQLParser.getSqlQuery("sel_tangiblenetworth^"+cma);
						}
						if(rs!=null)
							rs.close();
						rs=DBUtils.executeQuery(strQuery);
				
						String strRowtype="";
						String strRowid="";
						int strRowformula=0;
						int strRowformula2=0;
						String strTangibleNetworth="";
						
						if (rs.next())
						{
							strRowtype=correctNull(rs.getString("fin_rowtype"));
							strRowid=correctNull(rs.getString("fin_rowid"));
							strRowformula=rs.getInt("fin_formula");
							strRowformula2=rs.getInt("fin_formula2");
							
							if (strRowtype.trim().equals("C") && strRowformula>0 && !strDesc.trim().equals(""))
							{						
								HashMap hashformula =  new HashMap();
								hashformula.put("appno",strAppno);
								hashformula.put("sel_divID","0");
								hashformula.put("formulaid",Integer.toString(strRowformula));
								hashformula.put("curryear",strCurDate);
								hashformula.put("prevyear","");
								hashformula.put("currfinancialtype",strDesc);
								hashformula.put("prevfinancialtype","");
								hshResult1 = (HashMap)EJBInvoker.executeStateLess("comformula",hashformula,"GetFinValue");
								strTangibleNetworth=correctNull((String)hshResult1.get("strTotalValue"));
							}
						 }
						hshResult.put("hshResult1",hshResult1);
						hshResult.put("TangibleNetworth",strTangibleNetworth);
						hshResult.put("base_year",strCurDate);
					}
					
					/********************************************************************************************
					 * End of networth logic
					 * 
					 * ******************************************************************************************/
					
					
					if(rs1!=null)
					{
						rs1.close();
					}	
					strQuery = SQLParser.getSqlQuery("sel_opsaccountdetails^"+strAppno);//status-->Asset classification
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshResult.put("ops_accountbusinessnature",correctNull((String)rs.getString("ops_accountbusinessnature")));
						strQuery = SQLParser.getSqlQuery("sel_static_desc^31^"+correctNull((String)rs.getString("ops_accountassetclassification")));
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
							hshResult.put("com_propassettype",correctNull((String)rs1.getString("stat_data_desc1")));
					}
					if(rs1!=null)
					{
						rs1.close();
					}	
					strQuery = SQLParser.getSqlQuery("sel_rocchargedate^"+strAppno);//ROC-details
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshResult.put("roccharges",correctNull((String)rs.getString("roccharges")));
						hshResult.put("rocchargedate",correctNull((String)rs.getString("rocchargedate")));
					}
					if(rs1!=null)
						rs1.close();

					//arrOurBank = new ArrayList();
					//OurBank_WC_Funded = new ArrayList();
					//OurBank_WC_NonFunded = new ArrayList();
					OurBank_TL = new ArrayList();
					if(rs!=null)
						rs.close();	
					double dblExist=0.00;
					double dblproposed=0.00;
					String disp="";
					int intGroup = 0;
					strQuery = SQLParser.getSqlQuery("facilities_select_approvestatus^" + strAppno +"^"+intGroup);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						ArrayList TL_Funded_NonFunded=new ArrayList();
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_sno")));
						TL_Funded_NonFunded.add(correctNull(rs.getString("facdesc")));
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_existing")));
						
						dblExist =rs.getDouble("facility_existing");
						
						dblproposed =rs.getDouble("facility_proposed");
						
						if(dblExist==0.0 && dblproposed>0.0)
						{
							disp="New";
						}
						
						else if(dblExist!=0.0 && dblproposed==dblExist)
						{
							disp="Renewal";
						}
						else if(dblExist!=0.0 && (dblproposed<dblExist || dblproposed>dblExist))
						{
							disp="Modification";
						}
						
						TL_Funded_NonFunded.add(disp);
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_sancamt")));
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_margin")));
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_intremarks")));	
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_dp")));
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_outstanding")));
						TL_Funded_NonFunded.add(correctNull(rs.getString("security_value")));
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_desc")));
						//TL_Funded_NonFunded.add(correctNull(rs.getString("sec_security_mode")));
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_interest")));
						TL_Funded_NonFunded.add(correctNull(rs.getString("bplr")));
						
				//By venu for sublimit & security
						String strFacSno = Helper.correctNull((String)rs.getString("facility_sno"));
						ArrayList arrSubFac = new ArrayList();
						arrSubFac = getSubFacilitiesData(strAppno,strFacSno);
						TL_Funded_NonFunded.add(arrSubFac);
			    // End of sublimit			
					
						String strfacheadid = correctNull(rs.getString("facility_headid"));	
						String strfacsubid = correctNull(rs.getString("facility_id"));
								
						ArrayList arrDocuments=new ArrayList();
						if(rs1!=null)
						{	rs1.close();	
						}	
						strQuery = SQLParser.getSqlQuery("selcomfacilitydocuments_corsanctionadvice^"+strFacSno+"^"+strAppno);
						rs1 = DBUtils.executeQuery(strQuery);
						while(rs1.next())
						{	
							arrDocuments.add(correctNull(rs1.getString(1)));
							 
						}
						TL_Funded_NonFunded.add(arrDocuments);
						ArrayList arrSecurity=new ArrayList();					
						strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^"+strFacSno+"^"+strAppno);
						if(rs1!=null)
						{	rs1.close();	
						}	
						rs1 = DBUtils.executeQuery(strQuery);
						int j=0;
						while(rs1.next())
						{
							ArrayList arrCol=new ArrayList();
							arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
							arrCol.add(correctNull(rs1.getString("sec_margin")));
							arrCol.add(correctNull(rs1.getString("sec_charge")));
							arrSecurity.add(arrCol);
							j++;				
						}
					
						TL_Funded_NonFunded.add(arrSecurity);
				    	TL_Funded_NonFunded.add(correctNull(rs.getString("facility_headid")));
				    	TL_Funded_NonFunded.add(correctNull(rs.getString("facility_category")));
				    	TL_Funded_NonFunded.add(correctNull(rs.getString("facility_months")));
				    	TL_Funded_NonFunded.add(""+j);
						OurBank_TL.add(TL_Funded_NonFunded);
					}
					
					// for getting the organisation code of the approved authority
					String approvedorgscode="", comapp_org_scode="",
						comapp_org_code="";
					//String approvedorgcode="";
					if(rs1 != null)
					{
						rs1.close();
					}
					strQuery = SQLParser.getSqlQuery("approvedbyorgcode^"+strAppno);
					rs1 = DBUtils.executeQuery(strQuery);
					
					if(rs1.next())
					{
						//approvedorgcode=correctNull((String)rs1.getString("usr_orgcode"));
						approvedorgscode=correctNull((String)rs1.getString("org_scode"));
					}
					
					if(rs1 != null)
						rs1.close();
					
					strQuery = SQLParser.getSqlQuery("applicantioncreatedbranch^"+strAppno);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						comapp_org_scode=correctNull((String)rs1.getString("org_scode"));
						comapp_org_code=correctNull((String)rs1.getString("org_code"));
						hshResult.put("appCreationBranch",Helper.correctNull((String)rs1.getString("org_name")));
						hshResult.put("appCreationAddress",Helper.correctNull((String)rs1.getString("address")));
						hshResult.put("appCreationCity",Helper.correctNull((String)rs1.getString("org_city")));
						hshResult.put("appCreationState",Helper.correctNull((String)rs1.getString("org_state")));
						hshResult.put("appCreationpin",Helper.correctNull((String)rs1.getString("org_zip")));
					}
					
					if(comapp_org_scode.equalsIgnoreCase(approvedorgscode))
					{
						int code=comapp_org_code.length();
						if(code==12)
						{
							comapp_org_code=comapp_org_code+"000";
						}
						if(code==9)
						{
							comapp_org_code=comapp_org_code+"000000";
						}
						if(code==6)
						{
							comapp_org_code=comapp_org_code+"000000000";
						}
						if(code==3)
						{
							comapp_org_code=comapp_org_code+"000000000000";
						}
						strQuery = SQLParser.getSqlQuery("setorgselect^"+comapp_org_code);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							hshResult.put("RespectiveBranch",Helper.correctNull((String)rs.getString("org_name")));
							hshResult.put("org_add1",correctNull(rs.getString("org_add1")));
							hshResult.put("org_add2",correctNull(rs.getString("org_add2")));
							hshResult.put("org_cityname",correctNull(rs.getString("city_name")));
							hshResult.put("org_statename",correctNull(rs.getString("state_name")));
							hshResult.put("org_zip",correctNull(rs.getString("org_zip")));
							hshResult.put("org_phone",correctNull(rs.getString("org_phone")));
						}
					}
					else
					{
						int code=comapp_org_code.length();
						if(code==12)
						{
							comapp_org_code=comapp_org_code.substring(0,9);
							comapp_org_code=comapp_org_code+"000000";
						}
						if(code==9)
						{
							comapp_org_code=comapp_org_code.substring(0,6);
							comapp_org_code=comapp_org_code+"000000000";
									
						}
						if(code==6)
						{
							comapp_org_code=comapp_org_code.substring(0,3);
							comapp_org_code=comapp_org_code+"000000000000";
						}
						if(code==3)
						{
							//comapp_org_code=comapp_org_code.substring(0,5);
							comapp_org_code=comapp_org_code+"000000000000";
						}
						strQuery = SQLParser.getSqlQuery("setorgselect^"+comapp_org_code);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							hshResult.put("RespectiveBranch",Helper.correctNull((String)rs.getString("org_name")));
							hshResult.put("org_add1",correctNull(rs.getString("org_add1")));
							hshResult.put("org_add2",correctNull(rs.getString("org_add2")));
							hshResult.put("org_cityname",correctNull(rs.getString("city_name")));
							hshResult.put("org_statename",correctNull(rs.getString("state_name")));
							hshResult.put("org_zip",correctNull(rs.getString("org_zip")));
							hshResult.put("org_phone",correctNull(rs.getString("org_phone")));
						}
						
					}
						
									//for credit report means
							strQuery = SQLParser.getSqlQuery("sel_terpromoters^'"+strAppno+"' and demo_apptype like '%G@%'");
					
							if(rs!=null)
							rs.close();
							rs = DBUtils.executeQuery(strQuery);
							while(rs.next())
							{
								ArrayList arrVec4 = new ArrayList();								
								arrVec4.add(correctNull(rs.getString("perapp_title"))+". "+correctNull(rs.getString("perapp_fname")));
								arrVec4.add("");
								arrVec4.add("");
								arrVec4.add("");
								arrVec4.add("");
								arrVec4.add("");
								arrVec4.add("");
								arrVec4.add("");
								String ssi_prinid = Helper.correctNull((String)rs.getString("perapp_id"));
								if(rs1!=null)
								{
									rs1.close();
								}
								strQuery = SQLParser.getSqlQuery("selcreditreport2^"+strAppno+"^"+ssi_prinid);
								rs1 = DBUtils.executeQuery(strQuery);
								if(rs1.next())
								{
									arrVec4.add(correctNull(rs1.getString("CR_Total_MEANS")));
									arrVec4.add(correctNull(rs1.getString("cr_meansason")));
								}
								else
								{
									arrVec4.add("0.00");
									arrVec4.add("");
								}
								arrRow4.add(arrVec4);
							}
							hshResult.put("arrRow4",arrRow4);
						
									
									//Added by Mercy for including Collateral Security
									//ArrayList arrCollRow = new ArrayList();
									ArrayList arrColl = new ArrayList();
									strQuery = SQLParser.getSqlQuery("selsecuritybytype^" + strAppno+"^Collateral");
									if(rs1!=null)rs1.close();
									rs1 = DBUtils.executeQuery(strQuery);
									while(rs1.next())
									{
										arrColl.add(correctNull(rs1.getString("sec_desc_details")));
									}	
									if(rs1!=null)
									{
										rs1.close();
									}	
									
					hshResult.put("arrColl",arrColl);				
					hshResult.put("OurBank_TL",OurBank_TL);
					hshResult.put("strAppno",strAppno);
					hshResult.put("cattype",cattype);
			}
			catch(Exception ce)
			{
				throw new EJBException("Error in getTertiraySanctionAdvice-- "+ce.toString());
			}
			finally
			{
				try
				{	if(rs != null)
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
					throw new EJBException("Error closing the connection -getTertiraySanctionAdvice"+cf.getMessage());
				}
			}
			return hshResult;
		}
	/**
	 * Method to get the sub facilities under each major facility
	 * Added by VENUGOPAL
	 */	
		private ArrayList getSubFacilitiesData(String strAppno, String strFacSno) throws Exception{
			ArrayList arrSubFac = new ArrayList();
			ArrayList TL_Funded_NonFunded = new ArrayList();
			String strQuery="";
			ResultSet rs =null;
			ResultSet rs1=null;
			try{
				double dblExist=0.00;
				double dblproposed=0.00;
				String disp="";
				
				strQuery = SQLParser.getSqlQuery("facilities_select_approvestatus^"+strAppno+"^"+strFacSno);
			    if(rs!=null)
			    	rs.close();
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					//int d3=0;
				    TL_Funded_NonFunded=new ArrayList();
				    String strFacsno=correctNull(rs.getString("facility_sno"));
					TL_Funded_NonFunded.add(correctNull(rs.getString("facility_sno")));
					TL_Funded_NonFunded.add(correctNull(rs.getString("facdesc")));
					TL_Funded_NonFunded.add(correctNull(rs.getString("facility_existing")));
					
					dblExist =rs.getDouble("facility_existing");
					
					dblproposed =rs.getDouble("facility_proposed");
					
					if(dblExist==0.0 && dblproposed>0.0)
					{
						disp="New";
					}
					
					else if(dblExist!=0.0 && dblproposed==dblExist)
					{
						disp="Renewal";
					}
					else if(dblExist!=0.0 && (dblproposed<dblExist || dblproposed>dblExist))
					{
						disp="Modification";
					}
									
					TL_Funded_NonFunded.add(disp);
					TL_Funded_NonFunded.add(correctNull(rs.getString("facility_sancamt")));
					TL_Funded_NonFunded.add(correctNull(rs.getString("facility_margin")));
					TL_Funded_NonFunded.add(correctNull(rs.getString("facility_sancintremarks")));	
					TL_Funded_NonFunded.add(correctNull(rs.getString("facility_dp")));
					TL_Funded_NonFunded.add(correctNull(rs.getString("facility_outstanding")));
					TL_Funded_NonFunded.add(correctNull(rs.getString("security_value")));
					TL_Funded_NonFunded.add(correctNull(rs.getString("facility_desc")));
					//TL_Funded_NonFunded.add(correctNull(rs.getString("sec_security_mode")));
					TL_Funded_NonFunded.add(correctNull(rs.getString("facility_interest")));
					TL_Funded_NonFunded.add(correctNull(rs.getString("bplr")));
					
					
					ArrayList arrDocuments=new ArrayList();
					if(rs1!=null)
					{	rs1.close();	
					}
					//String strfacheadid = correctNull(rs.getString("facility_headid"));
					//String strfacsubid = correctNull(rs.getString("facility_id"));
					
					strQuery = SQLParser.getSqlQuery("selcomfacilitydocuments_corsanctionadvice^"+strFacsno+"^"+strAppno);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{	
						arrDocuments.add(correctNull(rs1.getString(1)));
						 
					}
					TL_Funded_NonFunded.add(arrDocuments);
					ArrayList arrSecurity=new ArrayList();					
					strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^"+strFacsno+"^"+strAppno);
					if(rs1!=null)
					{	rs1.close();	
					}	
					rs1 = DBUtils.executeQuery(strQuery);
					int j=0;
					while(rs1.next())
					{
						ArrayList arrCol=new ArrayList();
						arrCol.add(correctNull(rs1.getString("sec_desc_details")));
						arrCol.add(correctNull(rs1.getString("sec_margin")));
						arrCol.add(correctNull(rs1.getString("sec_charge")));
						arrSecurity.add(arrCol);
						j++;
					}
					TL_Funded_NonFunded.add(arrSecurity);
					TL_Funded_NonFunded.add(correctNull(rs.getString("facility_headid")));
					TL_Funded_NonFunded.add(""+j);
					arrSubFac.add(TL_Funded_NonFunded);
				}
			}catch(Exception e)
			{
				log.error("Exception in getSubFacilitiesData of ExcutiveBean "+e.getMessage());
			}finally{
				try{
					if(rs!=null)
						rs.close();
				}catch(Exception ce)
				{
					log.error("Exception in closing connection in getSubFacilitiesData of ExcutiveBean"+ce.getMessage());
				}
			}
			return arrSubFac;
		}
/**
 * Method to get the  facilities data & security details
 * for short term loan only
 */	
		public HashMap getAdhocLimitSanctionAdvice(HashMap hshValues)
		{
			
			java.text.NumberFormat jtn= java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
			jtn.setGroupingUsed(false);	
			
			String cattype="";
			
			
			HashMap hshResult=new HashMap();
			HashMap hshResult1=new HashMap();
			ResultSet rs=null;
			ResultSet rs1=null;
			
			String strQuery="";
			String strAppno="";
			
			String comappid="";
			String Strproposalvaluesin="L";
			String city_code="",state_code="",city_name="",state_name="",comapporg_scode="";
			//String OrgCode="";
			
			
			//ArrayList OurBank_WC_Funded = new ArrayList();
			
			ArrayList OurBank_TL = new ArrayList();
			ArrayList arrRow6=new ArrayList();
			try
			{
					cattype=correctNull((String) hshValues.get("cattype"));
					if(cattype.equalsIgnoreCase(""))
					{
						cattype=correctNull((String) hshValues.get("cattype1"));
					}
					//OrgCode=correctNull((String) hshValues.get("strOrgCode"));
					strAppno = correctNull((String) hshValues.get("comm_appno"));
					if(strAppno.equalsIgnoreCase(""))
					{
						strAppno = correctNull((String) hshValues.get("appno"));
					}
					if(rs!=null)
					{
						rs.close();
					}
					strQuery = SQLParser.getSqlQuery("comfunsel3^"+strAppno);
					rs=DBUtils.executeQuery(strQuery);
					
					if(rs.next())
					{
						comappid=correctNull(rs.getString("demo_appid"));
						Strproposalvaluesin=correctNull(rs.getString("app_valuesin"));
						hshResult.put("proposalvaluesin",Strproposalvaluesin);
					}
					if(rs!=null)
					{
						rs.close();
					}
					//strQuery = SQLParser.getSqlQuery("setorgselect^"+OrgCode);//Location-->branchin from organisation 
				//	rs = DBUtils.executeQuery(strQuery);	
					//if (rs.next())
					//{
					//	hshResult.put("org_branchIn",correctNull(rs.getString("org_branchIn")));
				//	}
					//if(rs!=null)
				//	{
				//		rs.close();
				//	}
					
					strQuery = SQLParser.getSqlQuery("comappmastersel^"+comappid);
					rs = DBUtils.executeQuery(strQuery);	
					while (rs.next())
					{ 
						hshResult.put("comapp_companyname",correctNull(rs.getString("comapp_companyname")));
						hshResult.put("comapp_ownership",correctNull(rs.getString("comapp_ownership")));//Organisation
						hshResult.put("comapp_businessnature",correctNull(rs.getString("comapp_businessnature")));
						hshResult.put("comapp_yrsinbusiness",correctNull(rs.getString("comapp_yrsinbusiness")));
						hshResult.put("comapp_regadd1",correctNull(rs.getString("comapp_regadd1")));
						hshResult.put("comapp_regadd2",correctNull(rs.getString("comapp_regadd2")));
						hshResult.put("comapp_regcity",correctNull(rs.getString("comapp_regcity")));
						hshResult.put("comapp_companyid",correctNull(rs.getString("comapp_companyid")));
						hshResult.put("comapp_regpin",correctNull(rs.getString("comapp_regpin")));
						//hshResult.put("comapp_scode",correctNull(rs.getString("comapp_scode")));
						
						comapporg_scode=correctNull(rs.getString("comapp_org_scode"));
						if(rs1!=null){
							rs1.close();
						}
						strQuery = SQLParser.getSqlQuery("setorgselectapp^"+comapporg_scode);
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							hshResult.put("org_branchIn",correctNull(rs1.getString("org_branchIn")));	
						}
						
						city_code=correctNull(rs.getString("comapp_regcity"));
						if(rs1!=null)
						{
							rs1.close();
						}
						if(!city_code.equalsIgnoreCase(""))
						{
						strQuery = SQLParser.getSqlQuery("selcitycode^"+city_code);
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							city_name = Helper.correctNull((String)rs1.getString(1));
							state_code = Helper.correctNull((String)rs1.getString(2));
							if(!state_code.equalsIgnoreCase(""))
							{
								strQuery = SQLParser.getSqlQuery("selstatecode^"+state_code);
								rs1 = DBUtils.executeQuery(strQuery);
								if(rs1.next())
								{
									state_name = Helper.correctNull((String)rs1.getString(1));
									
								}
							}
						}
						}
					}
						hshResult.put("city_name",city_name);
						hshResult.put("state_name",state_name);
						if(rs1!=null)
						{
							rs1.close();
						}	
						strQuery = SQLParser.getSqlQuery("selapproved^"+strAppno);//processed date and by
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							
							hshResult.put("app_processdate",correctNull((String)rs.getString("app_processdate")));
							hshResult.put("app_approvedby",correctNull((String)rs.getString("app_approvedby")));
							hshResult.put("sanctionedauthority",correctNull((String)rs.getString("usr_fname")));
							hshResult.put("sanc_auth_design",correctNull((String)rs.getString("user_designation")));
							hshResult.put("halfyearreview",correctNull((String)rs.getString("halfyearreview")));
							hshResult.put("yearreview",correctNull((String)rs.getString("yearreview")));
							hshResult.put("appcreatedate",correctNull((String)rs.getString("appcreatedate")));
						}
						if(rs!=null)
						{
							rs.close();
						}
						strQuery = SQLParser.getSqlQuery("execsel_port^"+strAppno);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							
							hshResult.put("exec_date",correctNull((String)rs.getString("exec_date")));
							hshResult.put("sel_applicantguarantee", correctNull(rs.getString("exec_whetherapplco")));
						}
						
						String curDate="";
						String strDesc="";
						String strCurDate="";
						String cma="";
						
						
						curDate=Helper.getCurrentDateTime();
						
						if(rs!=null)
							rs.close();
						
						String baseyear_query = SQLParser.getSqlQuery("sel_financial_baseyear^"+strAppno);
						rs = DBUtils.executeQuery(baseyear_query);
						
						if(rs.next())
						{	
							curDate=Helper.correctNull((String)rs.getString("base_year"));
							hshResult.put("base_year",correctNull((String)rs.getString("base_year")));
						}
						
						
						strQuery = SQLParser.getSqlQuery("executive_finselect9^"+strAppno+"^"+"0"+"^"+curDate);
						if(rs!=null)
							rs.close();
						rs=DBUtils.executeQuery(strQuery);
						
						
						if(rs.next())
						{
							if(rs.getDouble("sumaudit")>0)
							{
								strDesc="a";
							}
							else if(rs.getDouble("sumunaudit")>0)
							{
								strDesc="u";
							}
							else if(rs.getDouble("sumestimated")>0)
							{
								strDesc="e";
							}
							else if(rs.getDouble("sumprojection")>0)
							{
								strDesc="p";
							}
							strCurDate=rs.getString("fin_year");

						}
						
						strQuery = SQLParser.getSqlQuery("comfintrendsel1^"+strAppno);

						if(rs!=null)
							rs.close();

						rs = DBUtils.executeQuery(strQuery);
							 
						if(rs.next())
						{  
							cma=rs.getString("demo_finstandard");					
						}
						
						if(cma !="")
						{
							strQuery = SQLParser.getSqlQuery("sel_tangiblenetworth^"+cma);
						}
						if(rs!=null)
							rs.close();
						rs=DBUtils.executeQuery(strQuery);
					
						String strRowtype="";
						String strRowid="";
						int strRowformula=0;
						int strRowformula2=0;
						String strTangibleNetworth="";
						
						if (rs.next())
						{
							strRowtype=correctNull(rs.getString("fin_rowtype"));
							strRowid=correctNull(rs.getString("fin_rowid"));
							strRowformula=rs.getInt("fin_formula");
							strRowformula2=rs.getInt("fin_formula2");
							
							if (strRowtype.trim().equals("C") && strRowformula>0 && !strDesc.trim().equals(""))
							{						
								HashMap hashformula =  new HashMap();
								hashformula.put("appno",strAppno);
								hashformula.put("sel_divID","0");
								hashformula.put("formulaid",Integer.toString(strRowformula));
								hashformula.put("curryear",strCurDate);
								hashformula.put("prevyear","");
								hashformula.put("currfinancialtype",strDesc);
								hashformula.put("prevfinancialtype","");
								hshResult1 = (HashMap)EJBInvoker.executeStateLess("comformula",hashformula,"GetFinValue");
								strTangibleNetworth=correctNull((String)hshResult1.get("strTotalValue"));
							}
						 }
						hshResult.put("hshResult1",hshResult1);
						hshResult.put("TangibleNetworth",strTangibleNetworth);
						hshResult.put("meansason",strCurDate);
						
						
						if (rs != null)
							rs.close();
						rs = DBUtils.executeLAPSQuery("selcreditreport2^"+strAppno+"^"+"1");
						if (rs.next())
						{
							hshResult.put("means",correctNull(rs.getString("CR_Total_MEANS")));
							hshResult.put("asondate",correctNull(rs.getString("cr_meansason")));
						}
						if (rs != null)
							rs.close();
						strQuery = SQLParser.getSqlQuery("compropform8^"+strAppno);//status-->Asset classification
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							hshResult.put("com_propassettype",correctNull((String)rs.getString("com_propassettype")));
						}
						if (rs != null)
							rs.close();
						strQuery = SQLParser.getSqlQuery("sel_rocchargedate^"+strAppno);//ROC-details
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							hshResult.put("roccharges",correctNull((String)rs.getString("roccharges")));
							hshResult.put("rocchargedate",correctNull((String)rs.getString("rocchargedate")));
							
							
						}
						if(rs1!=null)
						{
							rs1.close();
						}
						
						//ArrayList document=null;
						//ArrayList documents=new ArrayList();
						//OurBank_WC_Funded = new ArrayList();
						OurBank_TL = new ArrayList();
						//int d2b=0;
						//int d2=0;
						
						
						
						
						if(rs!=null)
						{	rs.close();	
						}	
						double dblExist=0.00;
						double dblproposed=0.00;
						String disp="";
						//String strExist="",strProposed="";
						strQuery = SQLParser.getSqlQuery("com_adhocwctl_funded_nonfunded_sanctionadvice^"+strAppno+"^"+strAppno+"^"+strAppno);
						rs=DBUtils.executeQuery(strQuery);
						while(rs.next())
						{
							
							ArrayList TL_Funded_NonFunded=new ArrayList();
							String strFacSno = Helper.correctNull((String)rs.getString("facility_sno"));
							TL_Funded_NonFunded.add(strFacSno);
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_catdesc")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_existing")));
							
							dblExist =rs.getDouble("facility_existing");
							
							dblproposed =rs.getDouble("facility_proposed");
							
							if(dblExist==0.0 && dblproposed>0.0)
							{
								disp="New";
							}
							
							else if(dblExist!=0.0 && dblproposed==dblExist)
							{
								disp="Renewal";
							}
							else if(dblExist!=0.0 && (dblproposed<dblExist || dblproposed>dblExist))
							{
								disp="Modification";
							}
							
							TL_Funded_NonFunded.add(disp);
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_sancamt")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_margin")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_sancintremarks")));	
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_dp")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_outstanding")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("security_value")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_desc")));
							//TL_Funded_NonFunded.add(correctNull(rs.getString("sec_security_mode")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_interest")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("bplr")));
							
					//By venu for sublimit & security
							ArrayList arrSubFac = new ArrayList();
							arrSubFac = getAdhocSubFacilitiesData(strAppno,strFacSno);
							TL_Funded_NonFunded.add(arrSubFac);
				    // End of sublimit			
						
							ArrayList arrDocuments=new ArrayList();
							if(rs1!=null)
							{	rs1.close();	
							}	
							strQuery = SQLParser.getSqlQuery("selcomfacilitydocuments_corsanctionadvice^"+strFacSno+"^"+strAppno);
							rs1 = DBUtils.executeQuery(strQuery);
							while(rs1.next())
							{	
								arrDocuments.add(correctNull(rs1.getString(1)));
								 
							}
							TL_Funded_NonFunded.add(arrDocuments);
							ArrayList arrSecurity=new ArrayList();					
							strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^"+strFacSno+"^"+strAppno);
							if(rs1!=null)
							{	rs1.close();	
							}	
							rs1 = DBUtils.executeQuery(strQuery);
							int j=0;
							while(rs1.next())
							{
								ArrayList arrCol=new ArrayList();
								arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
								arrCol.add(correctNull(rs1.getString("sec_margin")));
								arrCol.add(correctNull(rs1.getString("sec_charge")));
								arrCol.add(correctNull(rs1.getString("sec_remarks")));
								arrSecurity.add(arrCol);
								j++;
							
							}
						
							TL_Funded_NonFunded.add(arrSecurity);
					    	TL_Funded_NonFunded.add(correctNull(rs.getString("facility_headid")));
					    	TL_Funded_NonFunded.add(correctNull(rs.getString("facility_category")));
					    	TL_Funded_NonFunded.add(correctNull(rs.getString("facility_months")));
					    	TL_Funded_NonFunded.add(""+j);
							OurBank_TL.add(TL_Funded_NonFunded);
						}
						
						// for getting the organisation code of the approved authority
						String  approvedorgscode="", comapp_org_scode="",
						//String approvedorgcode="";
							comapp_org_code="";
						if(rs1 != null)
						{
							rs1.close();
						}
						strQuery = SQLParser.getSqlQuery("approvedbyorgcode^"+strAppno);
						rs1 = DBUtils.executeQuery(strQuery);
						
						if(rs1.next())
						{
							//approvedorgcode=correctNull((String)rs1.getString("usr_orgcode"));
							approvedorgscode=correctNull((String)rs1.getString("org_scode"));
						}
						
						
						
						if(rs1 != null)
						{
							rs1.close();
						}
						
						strQuery = SQLParser.getSqlQuery("applicant_create_code^"+strAppno);
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							comapp_org_scode=correctNull((String)rs1.getString("comapp_org_scode"));
							comapp_org_code=correctNull((String)rs1.getString("comapp_org_code"));
							hshResult.put("appCreationBranch",Helper.correctNull((String)rs1.getString("org_name")));
							hshResult.put("appCreationAddress",Helper.correctNull((String)rs1.getString("address")));
							hshResult.put("appCreationCity",Helper.correctNull((String)rs1.getString("org_city")));
							hshResult.put("appCreationState",Helper.correctNull((String)rs1.getString("org_state")));
							hshResult.put("appCreationpin",Helper.correctNull((String)rs1.getString("org_zip")));
							
							
							
						}
						
						if(comapp_org_scode.equalsIgnoreCase(approvedorgscode))
						{
							int code=comapp_org_code.length();
							if(code==12)
							{
								comapp_org_code=comapp_org_code+"000";
							}
							if(code==9)
							{
								comapp_org_code=comapp_org_code+"000000";
							}
							if(code==6)
							{
								comapp_org_code=comapp_org_code+"000000000";
							}
							if(code==3)
							{
								comapp_org_code=comapp_org_code+"000000000000";
							}
							strQuery = SQLParser.getSqlQuery("setorgselect^"+comapp_org_code);
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								hshResult.put("RespectiveBranch",Helper.correctNull((String)rs.getString("org_name")));
								hshResult.put("org_add1",correctNull(rs.getString("org_add1")));
								hshResult.put("org_add2",correctNull(rs.getString("org_add2")));
								hshResult.put("org_cityname",correctNull(rs.getString("city_name")));
								hshResult.put("org_statename",correctNull(rs.getString("state_name")));
								hshResult.put("org_zip",correctNull(rs.getString("org_zip")));
								hshResult.put("org_phone",correctNull(rs.getString("org_phone")));
								
							}
						}
						else
						{
							int code=comapp_org_code.length();
							if(code==12)
							{
								comapp_org_code=comapp_org_code.substring(0,9);
								comapp_org_code=comapp_org_code+"000000";
							}
							if(code==9)
							{
								comapp_org_code=comapp_org_code.substring(0,6);
								comapp_org_code=comapp_org_code+"000000000";
										
							}
							if(code==6)
							{
								comapp_org_code=comapp_org_code.substring(0,3);
								comapp_org_code=comapp_org_code+"000000000000";
							}
							if(code==3)
							{
								//comapp_org_code=comapp_org_code.substring(0,5);
								comapp_org_code=comapp_org_code+"000000000000";
							}
							strQuery = SQLParser.getSqlQuery("setorgselect^"+comapp_org_code);
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								hshResult.put("RespectiveBranch",Helper.correctNull((String)rs.getString("org_name")));
								hshResult.put("org_add1",correctNull(rs.getString("org_add1")));
								hshResult.put("org_add2",correctNull(rs.getString("org_add2")));
								hshResult.put("org_cityname",correctNull(rs.getString("city_name")));
								hshResult.put("org_statename",correctNull(rs.getString("state_name")));
								hshResult.put("org_zip",correctNull(rs.getString("org_zip")));
								hshResult.put("org_phone",correctNull(rs.getString("org_phone")));
							}
							
						}
						
								//For Corporate Guarantor
									strQuery = SQLParser.getSqlQuery("compromoterselectionguar1^"+strAppno);
									
									if(rs!=null)
										rs.close();
										rs = DBUtils.executeQuery(strQuery);
										while(rs.next())
										{
											ArrayList arrVec6 = new ArrayList();
											
											arrVec6.add(correctNull(rs.getString("com_compdtfname")));
											arrVec6.add(correctNull(rs.getString("com_compdtlname")));
											String company_id = Helper.correctNull((String)rs.getString("com_compdtid"));
											if(rs1!=null)
											{
												rs1.close();
											}
											strQuery = SQLParser.getSqlQuery("selcreditreport2^"+strAppno+"^"+company_id);
											rs1 = DBUtils.executeQuery(strQuery);
											if(rs1.next())
											{
												arrVec6.add(correctNull(rs1.getString("CR_Total_MEANS")));
												arrVec6.add(correctNull(rs1.getString("cr_meansason")));
											}
											else
											{
												arrVec6.add("0.00");
												arrVec6.add("");
											}
											arrRow6.add(arrVec6);
										}
										hshResult.put("arrRow6",arrRow6);
										//Added by Mercy for including Collateral Security
										
										ArrayList arrColl = new ArrayList();
										strQuery = SQLParser.getSqlQuery("selsecuritybytype^"+strAppno+"^Collateral");
										if(rs1!=null)rs1.close();
										rs1 = DBUtils.executeQuery(strQuery);
										while(rs1.next())
										{
											arrColl.add(correctNull(rs1.getString("sec_desc_details")));
										}		
						hshResult.put("arrColl",arrColl);				
						hshResult.put("OurBank_TL",OurBank_TL);
						hshResult.put("strAppno",strAppno);
						hshResult.put("cattype",cattype);
				}
				catch(Exception ce)
				{
					throw new EJBException("Error in getCorporateSanctionAdvice-- "+ce.toString());
				}
				finally
				{
					try
					{	if(rs != null)
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
						throw new EJBException("Error closing the connection -getCorporateSanctionAdvice"+cf.getMessage());
					}
				}
				return hshResult;
			}
/**
 * Method to get the sub facilities under each major facility
 */	
			private ArrayList getAdhocSubFacilitiesData(String strAppno, String strFacSno) throws Exception{
				ArrayList arrSubFac = new ArrayList();
				ArrayList TL_Funded_NonFunded = new ArrayList();
				String strQuery="";
				ResultSet rs =null;
				ResultSet rs1=null;
				try{
					double dblExist=0.00;
					double dblproposed=0.00;
					String disp="";
					
					strQuery = SQLParser.getSqlQuery("com_sublimit_adhocwctl_funded_nonfunded_sanctionadvice^"+strAppno+"^"+strFacSno);
				    if(rs!=null)
				    	rs.close();
					rs = DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						//int d3=0;
					    TL_Funded_NonFunded=new ArrayList();
					    String strFacsno=correctNull(rs.getString("facility_sno"));
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_sno")));
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_catdesc")));
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_existing")));
						
						dblExist =rs.getDouble("facility_existing");
						
						dblproposed =rs.getDouble("facility_proposed");
						
						if(dblExist==0.0 && dblproposed>0.0)
						{
							disp="New";
						}
						
						else if(dblExist!=0.0 && dblproposed==dblExist)
						{
							disp="Renewal";
						}
						else if(dblExist!=0.0 && (dblproposed<dblExist || dblproposed>dblExist))
						{
							disp="Modification";
						}
										
						TL_Funded_NonFunded.add(disp);
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_sancamt")));
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_margin")));
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_intremarks")));	
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_dp")));
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_outstanding")));
						TL_Funded_NonFunded.add(correctNull(rs.getString("security_value")));
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_desc")));
						//TL_Funded_NonFunded.add(correctNull(rs.getString("sec_security_mode")));
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_interest")));
						TL_Funded_NonFunded.add(correctNull(rs.getString("bplr")));
							
						ArrayList arrDocuments=new ArrayList();
						if(rs1!=null)
						{	rs1.close();	
						}
						//String strfacheadid = correctNull(rs.getString("facility_headid"));
						//String strfacsubid = correctNull(rs.getString("facility_id"));
						
						strQuery = SQLParser.getSqlQuery("selcomfacilitydocuments_corsanctionadvice^"+strFacsno+"^"+strAppno);
						rs1 = DBUtils.executeQuery(strQuery);
						while(rs1.next())
						{	
							arrDocuments.add(correctNull(rs1.getString(1)));
							 
						}
						TL_Funded_NonFunded.add(arrDocuments);
						ArrayList arrSecurity=new ArrayList();					
						strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^"+strFacsno+"^"+strAppno);
						if(rs1!=null)
						{	rs1.close();	
						}	
						rs1 = DBUtils.executeQuery(strQuery);
						int j=0;
						while(rs1.next())
						{
							ArrayList arrCol=new ArrayList();
							arrCol.add(correctNull(rs1.getString("sec_desc_details")));
							arrCol.add(correctNull(rs1.getString("sec_margin")));
							arrCol.add(correctNull(rs1.getString("sec_charge")));
							arrCol.add(correctNull(rs1.getString("sec_remarks")));
							arrSecurity.add(arrCol);
							j++;
						}
						TL_Funded_NonFunded.add(arrSecurity);
						TL_Funded_NonFunded.add(correctNull(rs.getString("facility_headid")));
						TL_Funded_NonFunded.add(""+j);
						arrSubFac.add(TL_Funded_NonFunded);
					}
				}catch(Exception e)
				{
					log.error("Exception in getAdhocSubFacilitiesData of ExcutiveBean "+e.getMessage());
				}finally{
					try{
						if(rs!=null)
							rs.close();
					}catch(Exception ce)
					{
						log.error("Exception in closing connection in getAdhocSubFacilitiesData of ExcutiveBean"+ce.getMessage());
					}
				}
				return arrSubFac;
			}
		
/**
 * Method to get the  facilities data & security details
 * for short term loan only
 */				
			public HashMap getShortTermLoanLimitSanctionAdvice(HashMap hshValues)
			{
				
				java.text.NumberFormat jtn= java.text.NumberFormat.getInstance();
				jtn.setMaximumFractionDigits(2);
				jtn.setMinimumFractionDigits(2);
				jtn.setGroupingUsed(false);	
				
				String cattype="";
				
				
				HashMap hshResult=new HashMap();
				HashMap hshResult1=new HashMap();
				ResultSet rs=null;
				ResultSet rs1=null;
				
				String strQuery="";
				String strAppno="";
				
				String comappid="";
				String Strproposalvaluesin="L";
				String city_code="",state_code="",city_name="",state_name="",comapporg_scode="";
				//String OrgCode="";
				
				
				//ArrayList OurBank_WC_Funded = new ArrayList();
				
				ArrayList OurBank_TL = new ArrayList();
				ArrayList arrRow6=new ArrayList();
				try
				{
						cattype=correctNull((String) hshValues.get("cattype"));
						if(cattype.equalsIgnoreCase(""))
						{
							cattype=correctNull((String) hshValues.get("cattype1"));
						}
						//OrgCode=correctNull((String) hshValues.get("strOrgCode"));
						strAppno = correctNull((String) hshValues.get("comm_appno"));
						if(strAppno.equalsIgnoreCase(""))
						{
							strAppno = correctNull((String) hshValues.get("appno"));
						}
						if(rs!=null)
						{
							rs.close();
						}
						strQuery = SQLParser.getSqlQuery("comfunsel3^"+strAppno);
						rs=DBUtils.executeQuery(strQuery);
						
						if(rs.next())
						{
							comappid=correctNull(rs.getString("demo_appid"));
							Strproposalvaluesin=correctNull(rs.getString("app_valuesin"));
							hshResult.put("proposalvaluesin",Strproposalvaluesin);
						}
						if(rs!=null)
						{
							rs.close();
						}
						//strQuery = SQLParser.getSqlQuery("setorgselect^"+OrgCode);//Location-->branchin from organisation 
					//	rs = DBUtils.executeQuery(strQuery);	
						//if (rs.next())
						//{
						//	hshResult.put("org_branchIn",correctNull(rs.getString("org_branchIn")));
					//	}
						//if(rs!=null)
					//	{
					//		rs.close();
					//	}
						
						strQuery = SQLParser.getSqlQuery("comappmastersel^"+comappid);
						rs = DBUtils.executeQuery(strQuery);	
						while (rs.next())
						{ 
							hshResult.put("comapp_companyname",correctNull(rs.getString("comapp_companyname")));
							hshResult.put("comapp_ownership",correctNull(rs.getString("comapp_ownership")));//Organisation
							hshResult.put("comapp_businessnature",correctNull(rs.getString("comapp_businessnature")));
							hshResult.put("comapp_yrsinbusiness",correctNull(rs.getString("comapp_yrsinbusiness")));
							hshResult.put("comapp_regadd1",correctNull(rs.getString("comapp_regadd1")));
							hshResult.put("comapp_regadd2",correctNull(rs.getString("comapp_regadd2")));
							hshResult.put("comapp_regcity",correctNull(rs.getString("comapp_regcity")));
							hshResult.put("comapp_companyid",correctNull(rs.getString("comapp_companyid")));
							hshResult.put("comapp_regpin",correctNull(rs.getString("comapp_regpin")));
							//hshResult.put("comapp_scode",correctNull(rs.getString("comapp_scode")));
							
							comapporg_scode=correctNull(rs.getString("comapp_org_scode"));
							if(rs1!=null){
								rs1.close();
							}
							strQuery = SQLParser.getSqlQuery("setorgselectapp^"+comapporg_scode);
							rs1 = DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{
								hshResult.put("org_branchIn",correctNull(rs1.getString("org_branchIn")));	
							}
							
							city_code=correctNull(rs.getString("comapp_regcity"));
							if(rs1!=null)
							{
								rs1.close();
							}
							if(!city_code.equalsIgnoreCase(""))
							{
							strQuery = SQLParser.getSqlQuery("selcitycode^"+city_code);
							rs1 = DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{
								city_name = Helper.correctNull((String)rs1.getString(1));
								state_code = Helper.correctNull((String)rs1.getString(2));
								if(!state_code.equalsIgnoreCase(""))
								{
									strQuery = SQLParser.getSqlQuery("selstatecode^"+state_code);
									rs1 = DBUtils.executeQuery(strQuery);
									if(rs1.next())
									{
										state_name = Helper.correctNull((String)rs1.getString(1));
										
									}
								}
							}
							}
						}
							hshResult.put("city_name",city_name);
							hshResult.put("state_name",state_name);
							if(rs1!=null)
							{
								rs1.close();
							}	
							strQuery = SQLParser.getSqlQuery("selapproved^"+strAppno);//processed date and by
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								
								hshResult.put("app_processdate",correctNull((String)rs.getString("app_processdate")));
								hshResult.put("app_approvedby",correctNull((String)rs.getString("app_approvedby")));
								hshResult.put("sanctionedauthority",correctNull((String)rs.getString("usr_fname")));
								hshResult.put("sanc_auth_design",correctNull((String)rs.getString("user_designation")));
								hshResult.put("halfyearreview",correctNull((String)rs.getString("halfyearreview")));
								hshResult.put("nextreviewdate",correctNull((String)rs.getString("app_reviewdate")));
								hshResult.put("appcreatedate",correctNull((String)rs.getString("appcreatedate")));
							}
							if(rs!=null)
							{
								rs.close();
							}
							strQuery = SQLParser.getSqlQuery("execsel_port^"+strAppno);
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								
								hshResult.put("exec_date",correctNull((String)rs.getString("exec_date")));
								hshResult.put("sel_applicantguarantee", correctNull(rs.getString("exec_whetherapplco")));
							}
							
							String curDate="";
							String strDesc="";
							String strCurDate="";
							String cma="";
							
							
							curDate=Helper.getCurrentDateTime();
							
							if(rs!=null)
								rs.close();
							
							String baseyear_query = SQLParser.getSqlQuery("sel_financial_baseyear^"+strAppno);
							rs = DBUtils.executeQuery(baseyear_query);
							
							if(rs.next())
							{	
								curDate=Helper.correctNull((String)rs.getString("base_year"));
								hshResult.put("base_year",correctNull((String)rs.getString("base_year")));
							}
							
							
							strQuery = SQLParser.getSqlQuery("executive_finselect9^"+strAppno+"^"+"0"+"^"+curDate);
							if(rs!=null)
								rs.close();
							rs=DBUtils.executeQuery(strQuery);
							
							
							if(rs.next())
							{
								if(rs.getDouble("sumaudit")>0)
								{
									strDesc="a";
								}
								else if(rs.getDouble("sumunaudit")>0)
								{
									strDesc="u";
								}
								else if(rs.getDouble("sumestimated")>0)
								{
									strDesc="e";
								}
								else if(rs.getDouble("sumprojection")>0)
								{
									strDesc="p";
								}
								strCurDate=rs.getString("fin_year");

							}
							
							strQuery = SQLParser.getSqlQuery("comfintrendsel1^"+strAppno);

							if(rs!=null)
								rs.close();

							rs = DBUtils.executeQuery(strQuery);
								 
							if(rs.next())
							{  
								cma=rs.getString("demo_finstandard");					
							}
							
							if(cma !="")
							{
								strQuery = SQLParser.getSqlQuery("sel_tangiblenetworth^"+cma);
							}
							if(rs!=null)
								rs.close();
							rs=DBUtils.executeQuery(strQuery);
						
							String strRowtype="";
							String strRowid="";
							int strRowformula=0;
							int strRowformula2=0;
							String strTangibleNetworth="";
							
							if (rs.next())
							{
								strRowtype=correctNull(rs.getString("fin_rowtype"));
								strRowid=correctNull(rs.getString("fin_rowid"));
								strRowformula=rs.getInt("fin_formula");
								strRowformula2=rs.getInt("fin_formula2");
								
								if (strRowtype.trim().equals("C") && strRowformula>0 && !strDesc.trim().equals(""))
								{						
									HashMap hashformula =  new HashMap();
									hashformula.put("appno",strAppno);
									hashformula.put("sel_divID","0");
									hashformula.put("formulaid",Integer.toString(strRowformula));
									hashformula.put("curryear",strCurDate);
									hashformula.put("prevyear","");
									hashformula.put("currfinancialtype",strDesc);
									hashformula.put("prevfinancialtype","");
									hshResult1 = (HashMap)EJBInvoker.executeStateLess("comformula",hashformula,"GetFinValue");
									strTangibleNetworth=correctNull((String)hshResult1.get("strTotalValue"));
								}
							 }
							hshResult.put("hshResult1",hshResult1);
							hshResult.put("TangibleNetworth",strTangibleNetworth);
							hshResult.put("meansason",strCurDate);
							
							if (rs != null)
								rs.close();
							rs = DBUtils.executeLAPSQuery("selcreditreport2^"+strAppno+"^"+"1");
							if (rs.next())
							{
								hshResult.put("means",correctNull(rs.getString("CR_Total_MEANS")));
								hshResult.put("asondate",correctNull(rs.getString("cr_meansason")));
							}
							if (rs != null)
								rs.close();
							strQuery = SQLParser.getSqlQuery("compropform8^"+strAppno);//status-->Asset classification
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								hshResult.put("com_propassettype",correctNull((String)rs.getString("com_propassettype")));
							}
							if (rs != null)
								rs.close();
							strQuery = SQLParser.getSqlQuery("sel_rocchargedate^"+strAppno);//ROC-details
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								hshResult.put("roccharges",correctNull((String)rs.getString("roccharges")));
								hshResult.put("rocchargedate",correctNull((String)rs.getString("rocchargedate")));
								
								
							}
							if (rs != null)
								rs.close();
							
							//ArrayList document=null;
							//ArrayList documents=new ArrayList();
							//OurBank_WC_Funded = new ArrayList();
							OurBank_TL = new ArrayList();
							//int d2b=0;
							//int d2=0;
							
							
							
							
							if(rs!=null)
							{	rs.close();	
							}	
							double dblExist=0.00;
							double dblproposed=0.00;
							String disp="";
							//String strExist="",strProposed="";
							strQuery = SQLParser.getSqlQuery("com_stl_funded_sanctionadvice^"+strAppno+"^"+strAppno+"^"+strAppno);
							rs=DBUtils.executeQuery(strQuery);
							while(rs.next())
							{
								
								ArrayList TL_Funded_NonFunded=new ArrayList();
								String strFacSno = Helper.correctNull((String)rs.getString("facility_sno"));
								TL_Funded_NonFunded.add(strFacSno);
								TL_Funded_NonFunded.add(correctNull(rs.getString("facility_catdesc")));
								TL_Funded_NonFunded.add(correctNull(rs.getString("facility_existing")));
								
								dblExist =rs.getDouble("facility_existing");
								
								dblproposed =rs.getDouble("facility_proposed");
								
								if(dblExist==0.0 && dblproposed>0.0)
								{
									disp="New";
								}
								
								else if(dblExist!=0.0 && dblproposed==dblExist)
								{
									disp="Renewal";
								}
								else if(dblExist!=0.0 && (dblproposed<dblExist || dblproposed>dblExist))
								{
									disp="Modification";
								}
								
								TL_Funded_NonFunded.add(disp);
								TL_Funded_NonFunded.add(correctNull(rs.getString("facility_sancamt")));
								TL_Funded_NonFunded.add(correctNull(rs.getString("facility_margin")));
								TL_Funded_NonFunded.add(correctNull(rs.getString("facility_intremarks")));	
								TL_Funded_NonFunded.add(correctNull(rs.getString("facility_dp")));
								TL_Funded_NonFunded.add(correctNull(rs.getString("facility_outstanding")));
								TL_Funded_NonFunded.add(correctNull(rs.getString("security_value")));
								TL_Funded_NonFunded.add(correctNull(rs.getString("facility_desc")));
								//TL_Funded_NonFunded.add(correctNull(rs.getString("sec_security_mode")));
								TL_Funded_NonFunded.add(correctNull(rs.getString("facility_interest")));
								TL_Funded_NonFunded.add(correctNull(rs.getString("bplr")));
								
						//By venu for sublimit & security
								ArrayList arrSubFac = new ArrayList();
								arrSubFac = getShortTermLoanSubFacilitiesData(strAppno,strFacSno);
								TL_Funded_NonFunded.add(arrSubFac);
					    // End of sublimit			
							
								ArrayList arrDocuments=new ArrayList();
								if(rs1!=null)
								{	rs1.close();	
								}	
								strQuery = SQLParser.getSqlQuery("selcomfacilitydocuments_corsanctionadvice^"+strFacSno+"^"+strAppno);
								rs1 = DBUtils.executeQuery(strQuery);
								while(rs1.next())
								{	
									arrDocuments.add(correctNull(rs1.getString(1)));
									 
								}
								TL_Funded_NonFunded.add(arrDocuments);
								ArrayList arrSecurity=new ArrayList();					
								strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^"+strFacSno+"^"+strAppno);
								if(rs1!=null)
								{	rs1.close();	
								}	
								rs1 = DBUtils.executeQuery(strQuery);
								int j=0;
								while(rs1.next())
								{
									ArrayList arrCol=new ArrayList();
									arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
									arrCol.add(correctNull(rs1.getString("sec_margin")));
									arrCol.add(correctNull(rs1.getString("sec_charge")));
									arrCol.add(correctNull(rs1.getString("sec_remarks")));
									arrSecurity.add(arrCol);
									j++;
								
								}
							
								TL_Funded_NonFunded.add(arrSecurity);
						    	TL_Funded_NonFunded.add(correctNull(rs.getString("facility_headid")));
						    	TL_Funded_NonFunded.add(correctNull(rs.getString("facility_category")));
						    	TL_Funded_NonFunded.add(correctNull(rs.getString("facility_months")));
						    	TL_Funded_NonFunded.add(""+j);
								OurBank_TL.add(TL_Funded_NonFunded);
							}
							
							// for getting the organisation code of the approved authority
							String  approvedorgscode="", comapp_org_scode="",
							//String approvedorgcode="";
								comapp_org_code="";
							if(rs1 != null)
							{
								rs1.close();
							}
							strQuery = SQLParser.getSqlQuery("approvedbyorgcode^"+strAppno);
							rs1 = DBUtils.executeQuery(strQuery);
							
							if(rs1.next())
							{
								//approvedorgcode=correctNull((String)rs1.getString("usr_orgcode"));
								approvedorgscode=correctNull((String)rs1.getString("org_scode"));
							}
							
							
							
							if(rs1 != null)
							{
								rs1.close();
							}
							
							strQuery = SQLParser.getSqlQuery("applicant_create_code^"+strAppno);
							rs1 = DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{
								comapp_org_scode=correctNull((String)rs1.getString("comapp_org_scode"));
								comapp_org_code=correctNull((String)rs1.getString("comapp_org_code"));
								hshResult.put("appCreationBranch",Helper.correctNull((String)rs1.getString("org_name")));
								hshResult.put("appCreationAddress",Helper.correctNull((String)rs1.getString("address")));
								hshResult.put("appCreationCity",Helper.correctNull((String)rs1.getString("org_city")));
								hshResult.put("appCreationState",Helper.correctNull((String)rs1.getString("org_state")));
								hshResult.put("appCreationpin",Helper.correctNull((String)rs1.getString("org_zip")));
								
								
								
							}
							
							if(comapp_org_scode.equalsIgnoreCase(approvedorgscode))
							{
								int code=comapp_org_code.length();
								if(code==12)
								{
									comapp_org_code=comapp_org_code+"000";
								}
								if(code==9)
								{
									comapp_org_code=comapp_org_code+"000000";
								}
								if(code==6)
								{
									comapp_org_code=comapp_org_code+"000000000";
								}
								if(code==3)
								{
									comapp_org_code=comapp_org_code+"000000000000";
								}
								strQuery = SQLParser.getSqlQuery("setorgselect^"+comapp_org_code);
								rs = DBUtils.executeQuery(strQuery);
								if(rs.next())
								{
									hshResult.put("RespectiveBranch",Helper.correctNull((String)rs.getString("org_name")));
									hshResult.put("org_add1",correctNull(rs.getString("org_add1")));
									hshResult.put("org_add2",correctNull(rs.getString("org_add2")));
									hshResult.put("org_cityname",correctNull(rs.getString("city_name")));
									hshResult.put("org_statename",correctNull(rs.getString("state_name")));
									hshResult.put("org_zip",correctNull(rs.getString("org_zip")));
									hshResult.put("org_phone",correctNull(rs.getString("org_phone")));
									
								}
							}
							else
							{
								int code=comapp_org_code.length();
								if(code==12)
								{
									comapp_org_code=comapp_org_code.substring(0,9);
									comapp_org_code=comapp_org_code+"000000";
								}
								if(code==9)
								{
									comapp_org_code=comapp_org_code.substring(0,6);
									comapp_org_code=comapp_org_code+"000000000";
											
								}
								if(code==6)
								{
									comapp_org_code=comapp_org_code.substring(0,3);
									comapp_org_code=comapp_org_code+"000000000000";
								}
								if(code==3)
								{
									//comapp_org_code=comapp_org_code.substring(0,5);
									comapp_org_code=comapp_org_code+"000000000000";
								}
								strQuery = SQLParser.getSqlQuery("setorgselect^"+comapp_org_code);
								rs = DBUtils.executeQuery(strQuery);
								if(rs.next())
								{
									hshResult.put("RespectiveBranch",Helper.correctNull((String)rs.getString("org_name")));
									hshResult.put("org_add1",correctNull(rs.getString("org_add1")));
									hshResult.put("org_add2",correctNull(rs.getString("org_add2")));
									hshResult.put("org_cityname",correctNull(rs.getString("city_name")));
									hshResult.put("org_statename",correctNull(rs.getString("state_name")));
									hshResult.put("org_zip",correctNull(rs.getString("org_zip")));
									hshResult.put("org_phone",correctNull(rs.getString("org_phone")));
								}
								
							}
							
									//For Corporate Guarantor
										strQuery = SQLParser.getSqlQuery("compromoterselectionguar1^"+strAppno);
										
										if(rs!=null)
											rs.close();
											rs = DBUtils.executeQuery(strQuery);
											while(rs.next())
											{
												ArrayList arrVec6 = new ArrayList();
												
												arrVec6.add(correctNull(rs.getString("com_compdtfname")));
												arrVec6.add(correctNull(rs.getString("com_compdtlname")));
												String company_id = Helper.correctNull((String)rs.getString("com_compdtid"));
												if(rs1!=null)
												{
													rs1.close();
												}
												strQuery = SQLParser.getSqlQuery("selcreditreport2^"+strAppno+"^"+company_id);
												rs1 = DBUtils.executeQuery(strQuery);
												if(rs1.next())
												{
													arrVec6.add(correctNull(rs1.getString("CR_Total_MEANS")));
													arrVec6.add(correctNull(rs1.getString("cr_meansason")));
												}
												else
												{
													arrVec6.add("0.00");
													arrVec6.add("");
												}
												arrRow6.add(arrVec6);
											}
											hshResult.put("arrRow6",arrRow6);
											//Added by Mercy for including Collateral Security
											
											ArrayList arrColl = new ArrayList();
											strQuery = SQLParser.getSqlQuery("selsecuritybytype^"+strAppno+"^Collateral");
											if(rs1!=null)rs1.close();
											rs1 = DBUtils.executeQuery(strQuery);
											while(rs1.next())
											{
												arrColl.add(correctNull(rs1.getString("sec_desc_details")));
											}		
							hshResult.put("arrColl",arrColl);				
							hshResult.put("OurBank_TL",OurBank_TL);
							hshResult.put("strAppno",strAppno);
							hshResult.put("cattype",cattype);
					}
					catch(Exception ce)
					{
						throw new EJBException("Error in getShortTermLoanLimitSanctionAdvice-- "+ce.toString());
					}
					finally
					{
						try
						{	if(rs != null)
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
							throw new EJBException("Error closing the connection -getShortTermLoanLimitSanctionAdvice"+cf.getMessage());
						}
					}
					return hshResult;
				}
/**
 * Method to get the sub facilities under each major facility
 * for short term loan only
 */	
				private ArrayList getShortTermLoanSubFacilitiesData(String strAppno, String strFacSno) throws Exception{
					ArrayList arrSubFac = new ArrayList();
					ArrayList TL_Funded_NonFunded = new ArrayList();
					String strQuery="";
					ResultSet rs =null;
					ResultSet rs1=null;
					try{
						double dblExist=0.00;
						double dblproposed=0.00;
						String disp="";
						
						strQuery = SQLParser.getSqlQuery("com_sublimit_stl_funded_sanctionadvice^"+strAppno+"^"+strFacSno);
					    if(rs!=null)
					    	rs.close();
						rs = DBUtils.executeQuery(strQuery);
						while(rs.next())
						{
							//int d3=0;
						    TL_Funded_NonFunded=new ArrayList();
						    String strFacsno=correctNull(rs.getString("facility_sno"));
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_sno")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_catdesc")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_existing")));
							
							dblExist =rs.getDouble("facility_existing");
							
							dblproposed =rs.getDouble("facility_proposed");
							
							if(dblExist==0.0 && dblproposed>0.0)
							{
								disp="New";
							}
							
							else if(dblExist!=0.0 && dblproposed==dblExist)
							{
								disp="Renewal";
							}
							else if(dblExist!=0.0 && (dblproposed<dblExist || dblproposed>dblExist))
							{
								disp="Modification";
							}
											
							TL_Funded_NonFunded.add(disp);
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_sancamt")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_margin")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_intremarks")));	
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_dp")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_outstanding")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("security_value")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_desc")));
							//TL_Funded_NonFunded.add(correctNull(rs.getString("sec_security_mode")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_interest")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("bplr")));
								
							ArrayList arrDocuments=new ArrayList();
							if(rs1!=null)
							{	rs1.close();	
							}
							//String strfacheadid = correctNull(rs.getString("facility_headid"));
							//String strfacsubid = correctNull(rs.getString("facility_id"));
							
							strQuery = SQLParser.getSqlQuery("selcomfacilitydocuments_corsanctionadvice^"+strFacsno+"^"+strAppno);
							rs1 = DBUtils.executeQuery(strQuery);
							while(rs1.next())
							{	
								arrDocuments.add(correctNull(rs1.getString(1)));
								 
							}
							TL_Funded_NonFunded.add(arrDocuments);
							ArrayList arrSecurity=new ArrayList();					
							strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^"+strFacsno+"^"+strAppno);
							if(rs1!=null)
							{	rs1.close();	
							}	
							rs1 = DBUtils.executeQuery(strQuery);
							int j=0;
							while(rs1.next())
							{
								ArrayList arrCol=new ArrayList();
								arrCol.add(correctNull(rs1.getString("sec_desc_details")));
								arrCol.add(correctNull(rs1.getString("sec_margin")));
								arrCol.add(correctNull(rs1.getString("sec_charge")));
								arrCol.add(correctNull(rs1.getString("sec_remarks")));
								arrSecurity.add(arrCol);
								j++;
							}
							TL_Funded_NonFunded.add(arrSecurity);
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_headid")));
							TL_Funded_NonFunded.add(""+j);
							arrSubFac.add(TL_Funded_NonFunded);
						}
					}catch(Exception e)
					{
						log.error("Exception in getShortTermLoanSubFacilitiesData of ExcutiveBean "+e.getMessage());
					}finally{
						try{
							if(rs!=null)
								rs.close();
						}catch(Exception ce)
						{
							log.error("Exception in closing connection in getShortTermLoanSubFacilitiesData of ExcutiveBean"+ce.getMessage());
						}
					}
					return arrSubFac;
				}
				/**AUTHOR : ARSATH AYUB
				 * DATE   : 22/12/2013
				 * PURPOSE: TO GET CORP SANC LETTER DETAILS
				 * TASK GIVEN : N. PRAKASH
				 */
				public  HashMap getCorpSanctiondata(HashMap hshValues) 
				{
					HashMap hshResult = new HashMap();
					String strQuery=null,strType=null,strAppid=null,comapporg_scode="";
					String strQuery1=null;
					ResultSet rs = null;
					ResultSet rs1 = null;
					ResultSet rs2 = null,rs3=null,rs6=null,rs5=null;
					String city_name="";
					String state_name="";
					String city_code="";
					String state_code="";
					String comappid="";
					String strAppno="",strOrglevel="";
					ArrayList arrRow = new ArrayList();
					ArrayList arrCol = new ArrayList();
					ArrayList arrData=new ArrayList();
					ArrayList arrOutRow =new ArrayList();
					ArrayList arrOutRownew =new ArrayList();
					ArrayList arrOutCol = new ArrayList();
					ArrayList arrSecRemarksrow = null;
					ArrayList arrReval = new ArrayList();
					int	intGroup =0,strPatentid=0;;
					HashMap hshResult1=null;
					strType = Helper.correctNull((String)hshValues.get("type"));
					
					String srrBaseRate="",strInterestType="",strInterestRate="",strWhetherBRAvail="N",strHoliday="0",strLoanType="";
					String strVal3="",strValuesIn="";
					double dblBaseRate=0.00,dblInterestRate=0.00,dblDiffIntRate=0.00;
					String strfacsel="",strVal="",strVal1="",strVal2="",strSign="";
					
					DecimalFormat dc = new DecimalFormat();
					dc.setGroupingUsed(false);
					dc.setMaximumFractionDigits(2);
					dc.setMinimumFractionDigits(2);
					
					ArrayList arrRowNonBr=new ArrayList();
					ArrayList arrColNonBr=new ArrayList();
					ArrayList arrFacilityTermApp=new ArrayList();
					ArrayList arrFacilityTerm=new ArrayList();
					ArrayList arrFacilityTermType=new ArrayList();
					ArrayList arrParentID=new ArrayList();
					ArrayList arrFacilityId=new ArrayList();
					ArrayList arrFacilityTermStatus=new ArrayList();
					ArrayList arrFacilityPrepost=new ArrayList();
					ArrayList arrFacilityTermTypeApp=new ArrayList();
					ArrayList arrFacilityIdApp=new ArrayList();	
					ArrayList arrFacilityTermStatusapp=new ArrayList();
					String strAppNewId="0";
					String strMCLRFlag="Y";
					String mainactivity="",subactivity="";
					
					ArrayList arrMISRow	= new ArrayList();
					ArrayList arrMISCol	= new ArrayList();
					try
					{
						strAppno=(String)hshValues.get("appno");
						comappid=correctNull((String)hshValues.get("comappid"));
						String strSessionModuleType=Helper.correctNull((String)hshValues.get("sessionModuleType"));
						if(rs!=null)
						{
							rs.close();
						}
						strQuery = SQLParser.getSqlQuery("comfunsel3^"+strAppno);
						rs = DBUtils.executeQuery(strQuery);	
						if (rs.next())
						{
							comappid=correctNull(rs.getString("demo_appid"));
							strValuesIn	= correctNull(rs.getString("app_valuesin"));
							hshResult.put("proposalvaluesin",correctNull(rs.getString("app_valuesin")));
							strAppNewId=correctNull(rs.getString("demo_comappnewid"));
						}
						
						//Values In
						if(strValuesIn.equals("C")){strValuesIn			= "Crore";}
						else if(strValuesIn.equals("L")){strValuesIn	= "Lacs";}
						else if(strValuesIn.equals("R")){strValuesIn	= "Rs";}
						
						hshResult.put("strValuesIn", strValuesIn);
						
						//To get Organization Details	
						strQuery=SQLParser.getSqlQuery("sel_HeadOfficeDet");
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							hshResult.put("strHeadOffAddr1",Helper.correctNull((String)rs.getString("org_add1")));
							hshResult.put("strHeadOffAddr2",Helper.correctNull((String)rs.getString("org_add2")));
							hshResult.put("strHeadOffCity",Helper.correctNull((String)rs.getString("city_name")));
							hshResult.put("strHeadOffState",Helper.correctNull((String)rs.getString("state_name")));
							hshResult.put("strHeadOffZip",Helper.correctNull((String)rs.getString("org_zip")));
						}
						if(rs!=null)
						{
							rs.close();
						}
						strQuery=SQLParser.getSqlQuery("selBranchCityName^"+strAppno);
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{ 
							hshResult.put("orgname",correctNull(rs.getString("org_name")));
				           	hshResult.put("orgadd1",correctNull(rs.getString("org_add1")));
				           	hshResult.put("orgadd2",correctNull(rs.getString("org_add2")));
				           	hshResult.put("orgcity",correctNull(rs.getString("city_name")));
				           	hshResult.put("orgstate",correctNull(rs.getString("state_name")));
				           	hshResult.put("orgzip",correctNull(rs.getString("org_zip")));
				           	hshResult.put("orgphone",correctNull(rs.getString("org_phone")));
						}
							
						if(rs!=null){rs.close();}
						rs	= DBUtils.executeLAPSQuery("sel_appstatus^"+strAppno);
						if(rs.next())
						{
							strLoanType=Helper.correctNull((String)rs.getString("app_loantype"));
							strLoanType=strLoanType.toLowerCase();
							hshResult.put("APP_LOANSUBTYPE_DIGI",Helper.correctNull((String)rs.getString("APP_LOANSUBTYPE_DIGI")));
						}
						
							//To get the Sanction Ref Details
							if(rs!=null)
							{
								rs.close();
							}
							strQuery=SQLParser.getSqlQuery("sel_SancRefNo^"+strAppno);
							rs=DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								hshResult.put("sanctionrefno",Helper.correctNull((String)rs.getString("sanctionrefno")));
							}	
							//End of Sanction Ref Details
							
							//To get Process Date 
							if(rs!=null)
							{
								rs.close();
							}
							strQuery=SQLParser.getSqlQuery("sanctiondate_mclr^"+strAppno);
							rs=DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								hshResult.put("processdate",Helper.correctNull((String)rs.getString("app_processdate")));
								if(Integer.parseInt(Helper.correctInt(rs.getString("datediff")))<0)
								{
									strMCLRFlag="N";
								}
							}
							hshResult.put("strMCLRFlag",strMCLRFlag);
							
							//To get the Application Received Branch Details
							
							if(rs!=null)
							{
								rs.close();
							}
							String livedate=ApplicationParams.getStrCLPHdate();
							String postsanctionflag="";
							String applicationStatus="";
							// check when application is created
							String appcreatedate="";
							
								strQuery = SQLParser.getSqlQuery("getcreatedate^"+strAppno);
								rs5= DBUtils.executeQuery(strQuery);
								if (rs5.next()){
									
									appcreatedate= rs5.getString("createddate");
									applicationStatus= rs5.getString("APP_STATUS");
								}
								System.out.println("Application created date-->"+appcreatedate);
								System.out.println("Sanction  Live Date-->"+livedate);
						       if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
								 String Pattern="dd/MM/yyyy";
									DateFormat df=new SimpleDateFormat(Pattern);
									Date appcreationdate=df.parse(appcreatedate);
									Date postsanclivedate=df.parse(livedate);
									
									if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
									{
							strQuery=SQLParser.getSqlQuery("sel_ApplnBranch^"+strAppno);
									}else{
										strQuery=SQLParser.getSqlQuery("sel_ApplnBranchnewchk^"+strAppno);
									}
						       }
							rs=DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								hshResult.put("homebranch",Helper.correctNull((String)rs.getString("org_name")));
								hshResult.put("branchcode",Helper.correctNull((String)rs.getString("org_scode")));
								strOrglevel=Helper.correctNull((String)rs.getString("org_level"));
								
								if(Helper.correctNull(rs.getString("APP_ORGLEVEL")).equalsIgnoreCase("C")||Helper.correctNull(rs.getString("APP_ORGLEVEL")).equalsIgnoreCase("D"))
								{
									if(rs != null)
									{
										rs.close();
									}
									rs = DBUtils.executeLAPSQuery("sel_pertainingbr^" + strAppno);
									if(rs.next())
									{
										hshResult.put("homebranch", correctNull(rs.getString("org_name")));
									}
								}
							}	
							//End of Application Received
							
							
							//To get Part File(PF NO from Brief Background)
							if(rs!=null)
							{
								rs.close();
							}
							String strsancdept="",strSancBranch="";
							strQuery=SQLParser.getSqlQuery("sel_corporate_breifbackground^"+strAppno);
							rs=DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
									hshResult.put("BR_pfno",Helper.correctNull((String)rs.getString("com_partyfileno")));
									hshResult.put("HO_pfno",Helper.correctNull((String)rs.getString("com_roho")));
								hshResult.put("com_sector",Helper.correctNull((String)rs.getString("com_sector")));
								strsancdept= Helper.correctNull((String)rs.getString("com_sancdept"));
								hshResult.put("com_sancdeptcode", strsancdept);
								
								if(strsancdept.equalsIgnoreCase("011"))
								{
									hshResult.put("com_sancdept", "Central Processing Centre");
								}
								else if(strsancdept.equalsIgnoreCase("008"))
								{
									hshResult.put("com_sancdept", "Credit A ");
								}
								else if(strsancdept.equalsIgnoreCase("010"))
								{
									hshResult.put("com_sancdept", "Credit B ");
								}
								else if(strsancdept.equalsIgnoreCase("007"))
								{
									hshResult.put("com_sancdept", "Branch");
								}
								else if(strsancdept.equalsIgnoreCase("006"))
								{
									hshResult.put("com_sancdept", "Regional Office");
								}
								
								if(rs1!=null)
								{
									rs1.close();
								}
								if(!strsancdept.equalsIgnoreCase(""))
								{
									rs1=DBUtils.executeLAPSQuery("sel_cbsstaticdescbycode^"+"26"+"^"+strsancdept);
									if(rs1.next())
									{
										hshResult.put("strSanctiondept",Helper.correctNull(rs1.getString("cbs_static_data_desc")));
									}
								}
								strSancBranch=correctNull(rs.getString("com_sancbranch"));
								if(strSancBranch.equalsIgnoreCase("RFD")){
									hshResult.put("com_sancbranch", "Retail Finance Department");
								}else if(strSancBranch.equalsIgnoreCase("MCFD")){
									hshResult.put("com_sancbranch", "MID CORPORATE FINANCE DIVISION");
								}else if(strSancBranch.equalsIgnoreCase("ASG")){
									hshResult.put("com_sancbranch", "AGRICULTURE SUPPORT GROUP");
								}else if(strSancBranch.equalsIgnoreCase("LCFD")){
									hshResult.put("com_sancbranch", "LCFD");
								}else if(strSancBranch.equalsIgnoreCase("FS")){
									hshResult.put("com_sancbranch", "FOREX SUPPORT");
								}
								
								hshResult.put("com_processingfee",Helper.checkDecimal(Helper.correctDouble(rs.getString("com_processingfee"))));
							}
							//End
							
							//To get App name
							if(rs!=null)
							{
								rs.close();
							}
							strQuery=SQLParser.getSqlQuery("getAppName^"+strAppNewId);
							rs=DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								hshResult.put("appname",Helper.correctNull((String)rs.getString("perapp_name")));
							}
							//End
							
							//To get Base Rate
							if(rs!=null)
							{
								rs.close();
							}
							strQuery=SQLParser.getSqlQuery("sel_baserateasperfac^"+strAppno);
							rs=DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								hshResult.put("intrate",Helper.correctNull((String)rs.getString("intvalue")));
								hshResult.put("processeddate",Helper.correctNull((String)rs.getString("app_processdate")));
							}
							//End
							
							if(!Helper.correctNull((String)hshValues.get("strFormat")).equalsIgnoreCase("postsanc"))
							{
							if(rs!=null)
							{
								rs.close();
							}
							/*
							 * Applicant/Joint Applicant's Address
							 */
							strQuery=SQLParser.getSqlQuery("sel_sanccustdetforcorp^"+strAppno);
							rs=DBUtils.executeQuery(strQuery);
							while(rs.next())
							{
								String strDistrict="";
								String strCity="";
								String strState="";
								String strCountry="";
								arrCol=new ArrayList();
								arrCol.add(Helper.correctNull((String)rs.getString("perapp_name")));//0
								arrCol.add(Helper.correctNull((String)rs.getString("con_comaddr1")));//1
								arrCol.add(Helper.correctNull((String)rs.getString("con_comaddr2")));//2
								arrCol.add(Helper.correctNull((String)rs.getString("con_comvillage")));//3
								String strDistCode=Helper.correctNull((String)rs.getString("con_comdist"));
								if(!strDistCode.equalsIgnoreCase(""))
								{
									if(rs1!=null)
									{
										rs1.close();
									}
									strQuery1=SQLParser.getSqlQuery("sel_districtmaster^"+strDistCode);
									rs1=DBUtils.executeQuery(strQuery1);
									if(rs1.next())
									{
										strDistrict=Helper.correctNull((String)rs1.getString("district_desc"));
									}
								}
								arrCol.add(strDistrict);//4
								String strCityCode=Helper.correctNull((String)rs.getString("con_comcity"));
								if(!strCityCode.equalsIgnoreCase(""))
								{
									if(rs1!=null)
									{
										rs1.close();
									}
									strQuery1=SQLParser.getSqlQuery("selcitycode^"+strCityCode);
									rs1=DBUtils.executeQuery(strQuery1);
									if(rs1.next())
									{
										strCity=Helper.correctNull((String)rs1.getString("city_name"));
									}
								}
								arrCol.add(strCity);//5
								arrCol.add(Helper.correctNull((String)rs.getString("con_comzip")));//6
								String strStateCode=Helper.correctNull((String)rs.getString("con_comstate"));
								if(!strStateCode.equalsIgnoreCase(""))
								{
									if(rs1!=null)
									{
										rs1.close();
									}
									strQuery1=SQLParser.getSqlQuery("sel_statenamebycode^"+strStateCode);
									rs1=DBUtils.executeQuery(strQuery1);
									if(rs1.next())
									{
										strState=Helper.correctNull((String)rs1.getString("state_name"));
									}
								}
								arrCol.add(strState);//7
								String strCountryCode=Helper.correctNull((String)rs.getString("con_comcountry"));
								if(!strCountryCode.equalsIgnoreCase(""))
								{
									if(rs1!=null)
									{
										rs1.close();
									}
									strQuery1=SQLParser.getSqlQuery("sel_countryList^where con_countrycode='"+strCountryCode+"'");
									rs1=DBUtils.executeQuery(strQuery1);
									if(rs1.next())
									{
										strCountry=Helper.correctNull((String)rs1.getString("con_country"));
									}
								}
								arrCol.add(strCountry);//8
								
							}
							arrRow.add(arrCol);
							hshResult.put("arrRow",arrRow);
							/*
							 * End - Applicant/Joint Applicant's Address
							 */
						
						//Recommendations
					/*	arrOutRow	=  new ArrayList();
						String strVal= "",strVal1="",strVal2="";
						if(rs!=null){rs.close();}
						rs	= DBUtils.executeLAPSQuery("com_facselforsanc^"+strAppno);
						while(rs.next())
						{
							arrOutCol	= new ArrayList();
							strVal		= "";
							strVal1		= Helper.correctInt(rs.getString("facility_group"));
							strVal2		= Helper.correctInt(rs.getString("facility_repaytype"));
							
							if(strVal1.equals("0"))
							{
								strVal1	= "Main-Limit";
							}
							else
							{
								strVal1	= "Sub-Limit";
								
								if(rs1!=null){rs1.close();}
								rs1	= DBUtils.executeLAPSQuery("sel_sublimitVal^"+strAppno+"^"+Helper.correctInt(rs.getString("facility_group")));
								
								if(rs1.next())
								{
									strVal1	= strVal1+" ("+correctNull(rs1.getString("com_facdesc"))+")";
								}
							}
							
							 if(Double.parseDouble(Helper.correctDouble((String)rs.getString(("facility_existing"))))==0
									&& Double.parseDouble(Helper.correctDouble((String)rs.getString(("facility_proposed"))))>0)
									{
										strVal	= "Fresh limit";
									}
							
							 else if(Double.parseDouble(Helper.correctDouble((String)rs.getString(("facility_existing"))))
							<Double.parseDouble(Helper.correctDouble((String)rs.getString(("facility_proposed")))))
							{
								strVal	= "Renewal with Enhancement in limit";
							}
							else if(Double.parseDouble(Helper.correctDouble((String)rs.getString(("facility_existing"))))
							>Double.parseDouble(Helper.correctDouble((String)rs.getString(("facility_proposed")))))
							{
								strVal	= "Renewal with Reduction in limit";
							}
							else if(Double.parseDouble(Helper.correctDouble((String)rs.getString(("facility_existing"))))
							==Double.parseDouble(Helper.correctDouble((String)rs.getString(("facility_proposed")))))
							{
								strVal	= "Renewal with existing limit";
							}
							
							
							if(strVal2.equalsIgnoreCase("E")){	  strVal2	= "EMI";}
							else if(strVal2.equalsIgnoreCase("NE")){strVal2	= "Non EMI";}
							else{strVal2	= "";}
							
							arrOutCol.add(correctNull(rs.getString("com_facdesc")));//0
							arrOutCol.add(Helper.correctDouble(rs.getString("facility_proposed")));//1
							arrOutCol.add(Helper.correctDouble(rs.getString("facility_existing")));//2
							arrOutCol.add(Helper.correctDouble(rs.getString("facility_interest")));//3
							arrOutCol.add(Helper.correctInt(rs.getString("facility_sno")));//4
							arrOutCol.add(strVal1);//5
							arrOutCol.add(Helper.correctInt(rs.getString("facility_months")));//6
							arrOutCol.add(correctNull(rs.getString("facility_for")));//7
							arrOutCol.add(strVal);//8
							arrOutCol.add(strVal2);//9
							arrOutCol.add(correctNull(Helper.CLOBToString(rs.getClob("facility_margin"))));//10
							arrOutCol.add(Helper.correctInt(rs.getString("facility_holidayperiod")));//11
							arrOutRow.add(arrOutCol);//12
						}
						
						
						
						*/
						
						
						// For Credit Facilities - by DINESH on 25/04/2014
						
						strfacsel="";strVal="";strVal1="";strVal2="";String strAdhocFac="";
						arrOutRow	=  new ArrayList();
						ArrayList arrMCLR	=  new ArrayList();
						String strAdhocArr[]=null;
						if(rs!=null){rs.close();}
						rs	= DBUtils.executeLAPSQuery("com_FACSel_approved^"+strAppno+"^"+strLoanType);
						while(rs.next())
						{
							arrOutCol	= new ArrayList();
							strVal		= "";strType="";
							strVal1		= Helper.correctInt(rs.getString("facility_group"));
							strVal2		= Helper.correctInt(rs.getString("facility_repaytype"));
							
							dblBaseRate=Double.parseDouble(Helper.correctDouble((String)rs.getString("facility_baserate")));
							dblInterestRate=Double.parseDouble(Helper.correctDouble((String)rs.getString("facility_sancinterest")));
							strInterestType=Helper.correctNull((String)rs.getString("facility_intsubtype"));
							
							strAdhocFac=Helper.correctNull(rs.getString("facility_adhocfac"));
							strAdhocArr=strAdhocFac.split("~");
							
							if(rs1!=null){rs1.close();}
							rs1	= DBUtils.executeLAPSQuery("sel_facility_mclrspread^"+Helper.correctInt(rs.getString("facility_sno"))+"^"+strAppno);
							
							if(rs1.next())
							{
								dblDiffIntRate=dblInterestRate - dblBaseRate;
								String strTemp=Helper.correctNull(rs1.getString("facility_mclrtype"));
								String strTempforfbil=Helper.correctNull(rs1.getString("facility_mclrtype"));
								String strfbildate=Helper.correctNull(rs1.getString("FBILL_DATE"));
								if(!strTemp.equalsIgnoreCase(""))
								{
									String[] strArr=strTemp.split("@");
			 						if(strArr.length>1)
			 						{
			 							if(rs3!=null)
			 								rs3.close();
			 							rs3=DBUtils.executeLAPSQuery("selcbsiddatadesc^34^"+strArr[0]);
			 							if(rs3.next())
			 							{
			 								strTemp=Helper.correctNull(rs3.getString("cbs_static_data_desc"));
			 							}
			 						}
			 						else
			 						{
			 							strTemp="";
			 						}
								}
								else
								{
									strTemp="";
								}
								strInterestRate=strTemp+" + "+dc.format(dblDiffIntRate)+"% p.a presently at "+dc.format(dblInterestRate)+"% p.a";
								strWhetherBRAvail="Y";
								if(!arrMCLR.contains("Rate of interest is subject to change from time to time.Present applicable "+strTemp+" is "+dc.format(dblBaseRate)+" %"))
								{
									if(strTempforfbil.contains("FD")||strTempforfbil.contains("FM"))
									{
								    arrMCLR.add("Rate of interest is subject to change from time to time.Present applicable "+strTemp+" is "+dc.format(dblBaseRate)+" %"+ " as on "+ strfbildate);
									}
									else
									{
									arrMCLR.add("Rate of interest is subject to change from time to time.Present applicable "+strTemp+" is "+dc.format(dblBaseRate)+" %");		
									}
								}
							}
							else
							{
								if(strInterestType.equalsIgnoreCase("BR"))
								{
									dblDiffIntRate=dblInterestRate - dblBaseRate;
									strInterestRate="BR + "+dc.format(dblDiffIntRate)+"% p.a presently at "+dc.format(dblInterestRate)+"% p.a";
									strWhetherBRAvail="Y";
								}
								else
								{
									strInterestRate=Helper.correctDouble(rs.getString("facility_interest"));
								}
							}
							
							if(strVal1.equals("0"))
							{
									strVal1	= "Main Limit";
								
							}
							else
							{
								strVal1	= "Sub Limit";
								
								if(rs1!=null){rs1.close();}
								rs1	= DBUtils.executeLAPSQuery("sel_sublimitVal^"+strAppno+"^"+Helper.correctInt(rs.getString("facility_group")));
								
								if(rs1.next())
								{
									strVal1	= strVal1+" -> "+correctNull(rs1.getString("com_facdesc"));
								}
								
								strType = "1";
							}
							
							if(rs1!=null){rs1.close();}
							rs1	= DBUtils.executeLAPSQuery("sel_facilityremarks^"+Helper.correctInt(rs.getString("facility_sel_type")));
							if(rs1.next())
							{
								strfacsel	= Helper.correctNull(rs1.getString("STAT_DATA_DESC1"));
							}
							
							if(strVal2.equalsIgnoreCase("E")){	  strVal2	= "EMI";}
							else if(strVal2.equalsIgnoreCase("NE")){strVal2	= "Non EMI";}
							else if(strVal2.equalsIgnoreCase("OD")){strVal2	= "On Demand";}
							else if(strVal2.equalsIgnoreCase("LC")){strVal2	= "As Per LC Terms";}
							else if(strVal2.equalsIgnoreCase("CO")){strVal2	= "As Per Contract Terms";}
							else if(strVal2.equalsIgnoreCase("BG")){strVal2	= "As Per BG Rules";}
							else if(strVal2.equalsIgnoreCase("DD")){strVal2	= "On Due Date";}
							else if(strVal2.equalsIgnoreCase("PC")){strVal2	= "From the proceeds of PSC / by realization of bill";}
							else if(strVal2.equalsIgnoreCase("PS")){strVal2	= "By Realization of Export Bills";}
							else if(strVal2.equalsIgnoreCase("PR")){strVal2	= "By Realization of Respective Bills";}
							else if(strVal2.equalsIgnoreCase("TG")){strVal2	= "As per TCBG Rules";}
							else{strVal2	= "";}
							
							if(strType.equalsIgnoreCase("1"))
							{
								arrOutCol.add(correctNull(rs.getString("facility_displaydesc")));
							}
							else
							{
								arrOutCol.add(correctNull(rs.getString("facility_displaydesc")));
							}
							if(correctNull(rs.getString("com_headfac")).equalsIgnoreCase("1"))
							{
								Double dblAmount=Double.parseDouble(Helper.correctDouble(rs.getString("facility_sancamt")));
								dblAmount=dblAmount/50;
								arrOutCol.add(String.valueOf(dblAmount));
							}else{
								arrOutCol.add(Helper.correctDouble(rs.getString("facility_sancamt")));
							}
							arrOutCol.add(Helper.correctDouble(rs.getString("facility_existing")));
							arrOutCol.add(strInterestRate);
							arrOutCol.add(Helper.correctInt(rs.getString("facility_sno")));
							arrOutCol.add(strVal1);
							arrOutCol.add(Helper.correctInt(rs.getString("facility_months")));
							arrOutCol.add(correctNull(rs.getString("facility_for")));
						//	arrOutCol.add(strVal);
							arrOutCol.add(strfacsel);
							arrOutCol.add(strVal2);
							arrOutCol.add(correctNull(Helper.CLOBToString(rs.getClob("facility_margin"))));
							strHoliday=Helper.correctInt(rs.getString("facility_holidayperiod"));
							if(strHoliday.equalsIgnoreCase("0"))
								arrOutCol.add("Not Applicable");
							else
								arrOutCol.add(Helper.correctInt(rs.getString("facility_holidayperiod")));
							arrOutCol.add(strInterestType);	
							arrOutCol.add(Helper.correctNull((String)rs.getString("facility_duedate")));
							arrOutCol.add(Helper.correctDouble((String)rs.getString("facility_sancinterest")));

				  			rs1 = DBUtils.executeLAPSQuery("sel_modeofoperation^"+strAppno+"^"+Helper.correctInt(rs.getString("facility_sno")));
				  			if (rs1.next()) 
				  			{
				  				arrOutCol.add(Helper.correctNull((String)rs1.getString("CBS_STATIC_DATA_DESC")));
				  			}else{
				  				arrOutCol.add("");
				  			}
				  			arrOutCol.add(correctNull(Helper.CLOBToString(rs.getClob("facility_purpose"))));
				  			arrOutCol.add(Helper.correctDouble(rs.getString("fac_metlifepremiumamt")));
				  			
				  			
							if(rs1!=null){rs1.close();}
							if(!Helper.correctNull(rs.getString("FAC_INS_COMPANY_NAME")).equalsIgnoreCase(""))
							{
								rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^223^"+ Helper.correctNull(rs.getString("FAC_INS_COMPANY_NAME")));
								if (rs1.next()) {
									arrOutCol.add(Helper.correctNull(rs1.getString("STAT_DATA_DESC1")));//18
								}
								else{arrOutCol.add("");}
							}
							else{arrOutCol.add("");}
							
							arrOutCol.add(Helper.correctNull(rs.getString("FAC_INS_COMPANY_NAME")));//19

							arrOutCol.add(Helper.correctDouble(rs.getString("FAC_PREMIUM_TENOR")));//20
							arrOutCol.add(Helper.correctDouble(rs.getString("FAC_PREMIUM_LOAN_AMOUNT")));//21
							arrOutCol.add(Helper.correctDouble(rs.getString("FAC_INS_ACCOUNT_NO")));//22
							arrOutCol.add(Helper.correctDouble(rs.getString("FAC_PREMIUM_AMOUNT")));//23
							if(rs1!=null){rs1.close();}
							if(!Helper.correctNull(rs.getString("FAC_INS_FUNDED_COMPANY_NAME")).equalsIgnoreCase(""))
							{
								rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^223^"+ Helper.correctNull(rs.getString("FAC_INS_FUNDED_COMPANY_NAME")));
								if (rs1.next()) {
									arrOutCol.add(Helper.correctNull(rs1.getString("STAT_DATA_DESC1")));//24
								}
								else{arrOutCol.add("");}
							}
							else{arrOutCol.add("");}
							
							if(Helper.correctInt(rs.getString("facility_category")).equalsIgnoreCase("R"))
								arrOutCol.add("Regular Limit");
							else if(Helper.correctInt(rs.getString("facility_category")).equalsIgnoreCase("D"))
								arrOutCol.add("Additional Limit");
							else if(Helper.correctInt(rs.getString("facility_category")).equalsIgnoreCase("O"))
								arrOutCol.add("One Time Limit");
							else if(Helper.correctInt(rs.getString("facility_category")).equalsIgnoreCase("A"))
								arrOutCol.add("Adhoc Limit");
							else
								arrOutCol.add(" ");
							
							if(rs1!=null){rs1.close();}
							if(!Helper.correctNull(rs.getString("fac_actualmargin")).equalsIgnoreCase(""))
							{
								rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^235^"+ Helper.correctNull(rs.getString("fac_actualmargin")));
								if (rs1.next()) {
									arrOutCol.add(Helper.correctNull(rs1.getString("STAT_DATA_DESC1")));//25
								}
								else{arrOutCol.add("");}
							}
							else{arrOutCol.add("");}
							if(rs1!=null){rs1.close();}
							if(!Helper.correctNull(rs.getString("fac_actualrelaxed")).equalsIgnoreCase(""))
							{
								rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^236^"+ Helper.correctNull(rs.getString("fac_actualrelaxed")));
								if (rs1.next()) {
									arrOutCol.add(Helper.correctNull(rs1.getString("STAT_DATA_DESC1")));//25
								}
								else{arrOutCol.add("");}
							}
							else{arrOutCol.add("");}
							
							if(Helper.correctNull(rs.getString("fac_marginrelax")).equalsIgnoreCase("Y"))
								arrOutCol.add("Yes");
							else if(Helper.correctNull(rs.getString("fac_marginrelax")).equalsIgnoreCase("N"))
								arrOutCol.add("No");
							else
								arrOutCol.add("");
							
							arrOutRow.add(arrOutCol);
						}
						hshResult.put("arrRecommRow", arrOutRow);
						hshResult.put("arrMCLR", arrMCLR);
						hshResult.put("strWhetherBRAvail", strWhetherBRAvail);
						
						// For non base rate facilities
						if(rs!=null)
						{
							rs.close();
						}
						String strComments="";
						rs=DBUtils.executeLAPSQuery("sel_faclityforcommentsonintrate^"+strAppno);
						while(rs.next())
						{
										
							String strFacSno=Helper.correctNull(rs.getString("term_sno"));
							if(rs1!=null)
							{
								rs1.close();
							}
							rs1=DBUtils.executeLAPSQuery("sel_commentsoninterestrate^commentsonintrestrate^"+strFacSno+"^"+strAppno);
							if(rs1.next())
							{
								strComments=correctNull(Helper.CLOBToString(rs1.getClob("COM_COMMENTS")));
								if(!strComments.equalsIgnoreCase("")){
								arrColNonBr=new ArrayList();
								arrColNonBr.add(Helper.correctNull(rs.getString("facility_displaydesc")).toUpperCase());
								arrColNonBr.add(correctNull(Helper.CLOBToString(rs1.getClob("COM_COMMENTS"))));				
							}}
							arrRowNonBr.add(arrColNonBr);					
						}
						hshResult.put("arrRowNonBr",arrRowNonBr);
							}
						
						//For T&C - Specific , Inst. to the Branch by DINESH on 25/04/2014
						
						String strFacsno[] ={"97"};
						String srModuleType="",mode="",strFacCode="",termType="";
						String strPrePost = "s";
						hshResult.put("strPrePost",strPrePost);
						
						for(int i=0;i<strFacsno.length;i++)
						{
							if(strFacsno[i].equals("0"))
								mode="G";
							else if(strFacsno[i].equals("99")){
								mode="O";
							}
							else if(strFacsno[i].equals("98")){
								mode="B";
							}
							else if(strFacsno[i].equals("97")){
								mode="P";
							}
							else{
								mode="S";
							}
							if(strSessionModuleType.equalsIgnoreCase("AGR")){
								srModuleType="A";
							}else{
								srModuleType="C";
							}
							
							arrFacilityTerm=new ArrayList();
							arrFacilityTermType=new ArrayList();
							arrFacilityId=new ArrayList();
							arrFacilityTermStatus=new ArrayList();
							arrFacilityPrepost=new ArrayList();
							arrParentID=new ArrayList();
							arrFacilityTermStatusapp=new ArrayList();
							
								termType="P";
								strQuery = SQLParser.getSqlQuery("sel_termscond_specific^"+strAppno+"^"+termType+"^"+mode+"^"+srModuleType+"^"+"0");	
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
									strPatentid=Integer.parseInt(Helper.correctInt((String)rs.getString(3)));
									
									
									strQuery1 = SQLParser.getSqlQuery("sel_termscond_specific^"+strAppno+"^"+termType+"^"+mode+"^"+srModuleType+"^"+strPatentid);	
									rs1=DBUtils.executeQuery(strQuery1);
									while(rs1.next()){
										arrFacilityTerm.add(correctNull(rs1.getString(1)));
										arrFacilityTermType.add(correctNull(rs1.getString(2)));
										arrFacilityId.add(correctNull(rs1.getString(3)));
										arrFacilityTermStatus.add(correctNull(rs1.getString(4)));
										arrParentID.add(correctNull(rs1.getString(5)));
									}
									if(rs1 != null)
										rs1.close();
									
									}while(rs.next());
								}
								hshResult.put("arrFacilityTerm"+i,arrFacilityTerm);
								hshResult.put("arrFacilityTermType"+i,arrFacilityTermType);
								hshResult.put("arrFacilityIdVal"+i,arrFacilityId);
								hshResult.put("arrFacilityId"+i,strFacsno[i]);
								hshResult.put("arrFacilityTermStatus"+i,arrFacilityTermStatus);
								hshResult.put("arrParentID"+i,arrParentID);
								if(rs!=null)rs.close();
								termType="A";
								strQuery = SQLParser.getSqlQuery("sel_termscond_specific^"+strAppno+"^"+termType+"^"+mode+"^"+srModuleType+"^"+"0");	
								rs=DBUtils.executeQuery(strQuery);
								while (rs.next())
								{  
									arrFacilityTermApp.add(correctNull(rs.getString(1)));
									arrFacilityTermTypeApp.add(correctNull(rs.getString(2)));
									arrFacilityIdApp.add(correctNull(rs.getString(3)));	
									arrFacilityTermStatusapp.add(correctNull(rs.getString(4)));
								}
						
								hshResult.put("arrFacilityTermApp"+i,arrFacilityTermApp);
								hshResult.put("arrFacilityTermTypeApp"+i,arrFacilityTermTypeApp);
								hshResult.put("arrFacilityIdAppVal"+i,arrFacilityIdApp);	
								hshResult.put("arrFacilityTermStatusapp"+i,arrFacilityTermStatusapp);
						}
						
						
						if (rs != null)
						{
							rs.close();
						}
						
						if(!Helper.correctNull((String)hshValues.get("strFormat")).equalsIgnoreCase("postsanc"))
						{
						//Added by Arsath to get the terms and conditions 						
						HashMap hshTermsandcond = new HashMap();
						HashMap hshTermsval = new HashMap();
						hshTermsval.put("appno", strAppno);
						hshTermsandcond=new CommDocumentBean().getAnnexureVII(hshTermsval);
						hshResult.put("hshTermsandcond", hshTermsandcond);
						
						
				         ArrayList arrfacwisecol=new ArrayList();
				         ArrayList arrOutCol1=new ArrayList();
				         ArrayList arrOutColPro=new ArrayList();
//				         int k=0,j=0;
//				         String strSecid="";
//				         String strPrimaryFlag="false",strCollateralFlag="false";
//				         if(rs!=null) {rs.close();}
//				      // proposed facilities details
//				         if(rs!=null) {rs.close();}
//				         rs1=DBUtils.executeLAPSQuery("sel_facilitycodedesc_groupby^"+strAppno) ;
//					         while(rs1.next()) 
//					         {
//					        	    arrOutRow=new ArrayList();
//					        	    arrOutCol= new ArrayList();
//					        	    arrOutCol1=new ArrayList();
//					        	    arrOutRow1=new ArrayList();
//					        	    arrOutRowPro=new ArrayList();
//					        	   k=0;
//					        	 j=0;
//						         rs=DBUtils.executeLAPSQuery("secExisFacilityDetailsView_facwise^"+strAppno+"^"+"P^A"+"^"+Helper.correctInt((String)rs1.getString("facility_sno")));
//						         while(rs.next())
//						         {
//					        	    arrOutCol= new ArrayList();
//					        	    if(correctNull(rs.getString("app_sec_securitytype")).equalsIgnoreCase("1"))
//					        	    {
//					        	    	if(k==0) {
//					        	    		k++;
//						        	    	arrOutCol.add(correctNull(rs1.getString("com_facdesc")));//0
//						        	    	arrOutCol.add("");//1
//											arrOutCol.add("");	//2				
//											arrOutCol.add("");//3
//											arrOutRow.add(arrOutCol);
//						        	    	}
//					        	    	arrOutCol= new ArrayList();
//					        	    	arrOutCol.add(correctNull(Helper.CLOBToString(rs.getClob("CUS_SEC_SECURITY_DESCRIPTION"))));//1
//										arrOutCol.add(correctNull(rs.getString("app_sec_securityvalue")));	//2				
//										arrOutCol.add(correctNull(rs.getString("cus_sec_valuation_date")));//3
//										if(strSecid.equalsIgnoreCase(""))
//										{
//											strSecid= "'"+Helper.correctNull((String)rs.getString("CUS_SEC_ID"))+"'";
//										}else
//										{
//											strSecid = strSecid+",'"+Helper.correctNull((String)rs.getString("CUS_SEC_ID"))+"'";
//										}
//										arrOutRow.add(arrOutCol);
//					        	    }
//					        	    if(correctNull(rs.getString("app_sec_securitytype")).equalsIgnoreCase("2"))
//					        	    {
//					        	    	if(j==0) {
//					        	    		j++;
//						        	    	arrOutCol.add(correctNull(rs1.getString("com_facdesc")));//0
//						        	    	arrOutCol.add("");//1
//											arrOutCol.add("");	//2				
//											arrOutCol.add("");//3
//											arrOutRowPro.add(arrOutCol);
//						        	    	}
//					        	    	arrOutCol= new ArrayList();
//					        	    	arrOutCol.add(correctNull(Helper.CLOBToString(rs.getClob("CUS_SEC_SECURITY_DESCRIPTION"))));//1
//										arrOutCol.add(correctNull(rs.getString("app_sec_securityvalue")));	//2				
//										arrOutCol.add(correctNull(rs.getString("cus_sec_valuation_date")));//3
//										if(strSecid.equalsIgnoreCase(""))
//										{
//											strSecid= "'"+Helper.correctNull((String)rs.getString("CUS_SEC_ID"))+"'";
//										}else
//										{
//											strSecid = strSecid+",'"+Helper.correctNull((String)rs.getString("CUS_SEC_ID"))+"'";
//										}
//										arrOutRowPro.add(arrOutCol);
//					        	    }
//					        	 }
//						         if(arrOutRow.size()>0)
//						         arrfacwisecol.add(arrOutRow);
//						         if(arrOutRowPro.size()>0)
//						        	 arrOutColPro.add(arrOutRowPro);
//					        }
//					         hshResult.put("arrproposedSecfacwise", arrfacwisecol);
//					         hshResult.put("arrRowCollSec", arrOutColPro);
						
						
						arrfacwisecol=new ArrayList();
				         if(rs!=null) {rs.close();}
				         strQuery1 = SQLParser.getSqlQuery("seluniqueprimary_sec^and  a.APP_SEC_LOANTYPE='P'^A^"+strAppno);
				         rs=DBUtils.executeQuery(strQuery1);
				         while(rs.next())
				         {
							
				        	 arrOutRow=new ArrayList();
								if(rs1!=null)
								rs1.close();
							 strQuery1 = SQLParser.getSqlQuery("seluniqueprimarysec_facdetails^and  a.APP_SEC_LOANTYPE='P'^A^"+correctNull(rs.getString("secid"))+"^"+strAppno);
							 rs1=DBUtils.executeQuery(strQuery1) ;
					         while(rs1.next()) 
					         {
				        	    	arrOutCol= new ArrayList();
				        	    	arrOutCol.add(correctNull(rs1.getString("facility_catdesc")));//0
									arrOutCol.add(correctNull(rs1.getString("facility_proposed")));//1
									arrOutCol.add(correctNull(rs.getString("secdescription")));//2
									arrOutCol.add(correctNull(rs.getString("app_sec_securityvalue")));	//3				
									arrOutCol.add(correctNull(rs.getString("cus_sec_valuation_date")));//4
									arrOutRow.add(arrOutCol);
					         }
					         
					         
					         if(arrOutRow.size()>0)
					         {
					        	 arrfacwisecol.add(arrOutRow); 
					         }
								
			        	 }
				         
				         hshResult.put("arrproposedSecfacwise", arrfacwisecol);
					         
					         arrOutColPro=new ArrayList();
					         if(rs!=null) {rs.close();}
					         strQuery1 = SQLParser.getSqlQuery("secExisFacilityDetailsView^"+strAppno+"^"+strAppno+"^"+"P"+"^and app_sec_attached='A' ");	 
					         rs = DBUtils.executeQuery(strQuery1);
					         while(rs.next())
					         {
			        	    	arrOutCol1= new ArrayList();
			        	    	arrOutCol1.add(correctNull(Helper.CLOBToString(rs.getClob("CUS_SEC_SECURITY_DESCRIPTION"))));//1
								arrOutCol1.add(correctNull(rs.getString("cus_sec_netsecurity")));	//2				
								arrOutCol1.add(correctNull(rs.getString("cus_sec_valuation_date")));//3
								arrOutColPro.add(arrOutCol1);
							 }
					         hshResult.put("arrRowCollSec", arrOutColPro);
					         
						//Added by Kishan to get Repayment Schedule for Non-EMI
				        HashMap hshVal1 = new HashMap();
				        HashMap hshVal2 = new HashMap();
				        ArrayList arrCodeDescCol = new ArrayList();
				        ArrayList arrCodeDescRow = new ArrayList();
						String strValue="'NE','OD','LC','CO','BG','DD','PC','PS'";
						String strLoanaccount="";  
						strQuery = SQLParser.getSqlQuery("seltermfinancefac_NE_new^"+strAppno+"^"+strValue);
						rs = DBUtils.executeQuery(strQuery);
			  			while(rs.next())
						{
			  				arrCodeDescCol = new ArrayList();
			  				strLoanaccount="";
							String strCode= correctNull((String)rs.getString(1));
							String strName= correctNull((String)rs.getString(2));
							String strFaccode= correctNull((String)rs.getString(4));
							strQuery1 = SQLParser.getSqlQuery("sel_otherdetails^"+strFaccode);
							rs1 = DBUtils.executeQuery(strQuery1);
				  			if(rs1.next())
							{
				  				strLoanaccount=Helper.correctNull((String)rs1.getString("COM_LOANACC"));
							}
				  			if(strLoanaccount.equalsIgnoreCase("Y"))
				  			{
				  				arrCodeDescCol.add(strCode);
				  				arrCodeDescCol.add(strName);
				  				arrCodeDescRow.add(arrCodeDescCol);
				  			}
						}
			  			
			  			arrRow = new ArrayList();
			  			arrCol = new ArrayList();
			  			if(arrCodeDescRow!=null) {
			  				for(int i=0;i<arrCodeDescRow.size();i++) {
			  					arrCodeDescCol = (ArrayList) arrCodeDescRow.get(i);
								String strQuery2 = SQLParser.getSqlQuery("sel_tl_repayschedule^"+strAppno+"^"+(String)arrCodeDescCol.get(0));
								rs=DBUtils.executeQuery(strQuery2);
								while(rs.next())
								{
									arrCol = new ArrayList();
									arrCol.add(correctNull(rs.getString(1)));
									arrCol.add(correctNull(rs.getString(2)));
									arrCol.add(correctNull(rs.getString(3)));
									arrCol.add(correctNull(rs.getString(4)));
									arrCol.add(correctNull(rs.getString(5)));
									arrCol.add(correctNull(rs.getString(6)));
									String strQuery6 = SQLParser.getSqlQuery("sel_tl_spfac^"+strAppno+"^"+correctNull((String)rs.getString(2)));
									rs1=DBUtils.executeQuery(strQuery6);
									if(rs1.next())
									{
										arrCol.add(correctNull(rs1.getString("fac_desc")));
									}
									else
									{
										arrCol.add("");
									}
									arrRow.add(arrCol);
								}
			  				}
			  			}
			  			hshResult.put("arrtlrec",arrRow);
			  			if(rs!=null)
			  			{rs.close();}
			  			
			  			rs = DBUtils.executeLAPSQuery("sel_allcomments^"+strAppno+"^repaycomment");
			  			if (rs.next()) 
			  			{
			  				hshResult.put("fin_comments_repay", Helper.CLOBToString(rs.getClob("fin_comments")));
			  			}
			  			
			  			ArrayList arrOutCol2	= new ArrayList();
			  			ArrayList arrOutRow2	= new ArrayList();
			  			
			  			strQuery = SQLParser.getSqlQuery("sel_facility_allcomments^"+strAppno);
			  			rs = DBUtils.executeQuery(strQuery);
		  				while(rs.next())
		  				{
		  					if(rs1!=null)
		  					{
		  						rs1.close();
		  					}
		  						String str_repay="repaycomment";
		  						rs1 = DBUtils.executeLAPSQuery("sel_allcomments1^" + strAppno + "^repaycomment^"+ Helper.correctNull(rs.getString("facility_sno")));
		  						if (rs1.next()) 
		  						{
		  							arrOutCol2 = new ArrayList();
		  							arrOutCol2.add(Helper.correctNull(rs.getString("facility_sno")));
		  							arrOutCol2.add(Helper.correctNull(rs.getString("fac_desc")));
		  							arrOutCol2.add(Helper.CLOBToString(rs1.getClob("fin_comments"))); 
		  							arrOutRow2.add(arrOutCol2);
		  						}
		  				}
		  				hshResult.put("arrOutRow1", arrOutRow2);
			  			if(rs!=null)
			  			{rs.close();}
			  			
			  			rs = DBUtils.executeLAPSQuery("sel_appdocdate^"+strAppno);
			  			if (rs.next()) 
			  			{
			  				hshResult.put("app_inwrddocdate", Helper.correctNull((String)rs.getString("inward_docreceivedon")));
			  			}
			  			if(rs!=null)
			  			{rs.close();}
			  			
			  		//Promoter/ Director /Co-Obligants/ Guarantors 
			  			
			  			String strCoAppExID="",strCoAppExType="",strCoAppID="";
						arrRow	= new ArrayList();
						ArrayList arrProRow	= new ArrayList();
						if(rs!=null){rs.close();}
						String strTypeArr[]	= null;
						String strTypecheck[]	= null;
						String strPromoterChk="",strTitle="";
						rs	= DBUtils.executeLAPSQuery("compromoterselectionpromoters^"+strAppno);
						String strid="0";
						while(rs.next())
						{
							strVal			= "";
							strPromoterChk	= "false";
							strTitle="";
							
							strType			= correctNull(rs.getString("com_compdttype"));
							strCoAppID			= correctNull(rs.getString("com_oldlapsid"));
							if((strCoAppID.equalsIgnoreCase(strCoAppExID)) && (strType.equalsIgnoreCase(strCoAppExType)))
							continue;
							if(!strType.equals(""))
							{
								strTypeArr			= strType.split("@");
							}
							
							if(strTypeArr!=null)
							{
								for(int i=0;i<strTypeArr.length;i++)
								{
									if(strTypeArr[i].equalsIgnoreCase("G")||strTypeArr[i].equalsIgnoreCase("CO"))
									{
										if(strPromoterChk.equals("false"))
										{
											strVal1	= strTypeArr[i];
											arrCol	= new ArrayList();
											arrCol.add(Helper.changetoTitlecase(correctNull(rs.getString("com_compdtfname"))));//0
											if(strVal1.equalsIgnoreCase("G"))
												strVal1 = "Guarantor";
											else if(strVal1.equalsIgnoreCase("CO"))
												strVal1 = "Co Obligant";
											arrCol.add(strVal1);
											
											arrRow.add(arrCol);
										}
									}
									if(strTypeArr[i].equalsIgnoreCase("C"))
									{
										if(rs2!=null){rs2.close();}
										strQuery1=SQLParser.getSqlQuery("coapdetails^"+Helper.correctInt(rs.getString("com_compdtappid")));
										rs2=DBUtils.executeQuery(strQuery1);
										if(rs2.next())
										{
											strTitle=correctNull(rs2.getString("perapp_title"));
										}
										arrProRow.add(strTitle+"&nbsp;"+Helper.changetoTitlecase(correctNull(rs.getString("com_compdtfname"))));
									}
									
								}
							}
							
							strCoAppExID			= correctNull(rs.getString("com_oldlapsid"));
							strCoAppExType			= correctNull(rs.getString("com_compdttype"));
							
						}
						hshResult.put("arrPromoterRow", arrRow);
						hshResult.put("arrProRow", arrProRow);
						
						if (rs != null)
							rs.close();
						
						strQuery = SQLParser.getSqlQuery("sel_seccomments^" + strAppno);
						rs = DBUtils.executeQuery(strQuery);
						if (rs.next()) {
							hshResult.put("strProposedSecurity", Helper.correctNull(rs.getString("COMSEC_ADDITIONALSECCOVERAGE")));
							hshResult.put("strProposedSecurityComments", correctNull(Helper.CLOBToString(rs.getClob("COMSEC_ADDITIONALSECCOMMENTS"))));
						}
						if (rs != null)
							rs.close();
			  			
						strQuery = SQLParser.getSqlQuery("selborrowerdet_company^" + strAppNewId);
						rs = DBUtils.executeQuery(strQuery);
						if (rs.next()) {
							if(Helper.correctNull((String)rs.getString("cominfo_ownership_type")).equalsIgnoreCase("004")){
								hshResult.put("companyinfo_typeofliability", correctNull(Helper.CLOBToString(rs.getClob("companyinfo_typeofliability"))));
							}
						}
						if (rs != null)
							rs.close();
						strQuery = SQLParser.getSqlQuery("sel_baseRatefrommaster");
						rs = DBUtils.executeQuery(strQuery);
						if (rs.next()) {
								hshResult.put("strBaseRate", Helper.checkDecimal(Helper.correctDouble(rs.getString("int_intvalue"))));
						}
						if (rs != null)
							rs.close();
						
						strQuery=SQLParser.getSqlQuery("select_corpfacdetails^"+strAppno);
						rs=DBUtils.executeQuery(strQuery);
						while(rs.next()){
							arrCol=new ArrayList();
							arrCol.add(Helper.correctNull(rs.getString("facility_sno")));
							arrCol.add(Helper.correctNull(rs.getString("desc1")));
							arrCol.add(Helper.correctNull(rs.getString("APP_REFERENCENO")));
							arrCol.add(Helper.correctNull(rs.getString("APP_PROCESSDATE")));
							arrReval.add(arrCol);
						}
						hshResult.put("arrReval",arrReval);
						}
						else
						{
							String strReviewDate="",strModifiedTerms="";
							if (rs != null)
								rs.close();
							
							strQuery = SQLParser.getSqlQuery("sel_facilityreviewdate^" + strAppno);
							rs = DBUtils.executeQuery(strQuery);
							while(rs.next())
							{
								if(strReviewDate.equalsIgnoreCase(""))
									strReviewDate=Helper.correctNull(rs.getString("facility_reviewdate"));
								else
								{
									if(!strReviewDate.contains(Helper.correctNull(rs.getString("facility_reviewdate"))))
									strReviewDate=strReviewDate+","+Helper.correctNull(rs.getString("facility_reviewdate"));
								}
							}
							
							hshResult.put("strReviewDate",strReviewDate);
						}
						
						//MIS information
						
						String strSector="",strSubSector="",strcrtsales="";
						if(rs!=null){rs.close();}
						rs	= DBUtils.executeLAPSQuery("sel_misapp_desc^"+strAppno+"^"+strLoanType);
						while(rs.next())
						{
							arrMISCol		= new ArrayList();
							arrMISCol.add(Helper.correctNull(rs.getString("FACILITY_DISPLAYDESC")));
							mainactivity	= Helper.correctNull(rs.getString("app_mainactivity"));
							subactivity	= Helper.correctNull(rs.getString("app_subactivity"));
						
							if(rs1!=null)
							{
							  rs1.close();				  
							}
							rs1=DBUtils.executeLAPSQuery("sel_guarantee^"+"7"+"^"+Helper.correctNull((String)rs.getString("app_subsector")));
							if(rs1.next())
							{
								strSubSector = Helper.correctNull((String)rs1.getString("mis_static_data_desc"));					
							}
							else
							{
								if(rs1!=null)
								{
								  rs1.close();				  
								}
								rs1=DBUtils.executeLAPSQuery("sel_guarantee^"+"8"+"^"+Helper.correctNull((String)rs.getString("app_subsector")));
								if(rs1.next())
								{
									strSubSector = Helper.correctNull((String)rs1.getString("mis_static_data_desc"));					
								}
								else
								{
									strSubSector = "";
								}
							}
							
							if(mainactivity.equalsIgnoreCase("01") || mainactivity.equalsIgnoreCase("02"))
							{
								arrMISCol.add(strSubSector);
							}
							else
							{
								if(rs1!=null){rs1.close();}
								rs1	= DBUtils.executeLAPSQuery("sel_activity_codedetails^"+"2"+"^"+mainactivity);
								if(rs1.next())
								{
									arrMISCol.add(Helper.correctNull(rs1.getString("mis_static_data_desc")));
								}
								else
								{
									arrMISCol.add("");
								}
							}
							if(rs1!=null){rs1.close();}
							if(rs2!=null){rs2.close();}
							
							rs1	= DBUtils.executeLAPSQuery("sel_MISSubActivityDesc^"+mainactivity+"^"+subactivity);
							if(rs1.next())
							{
								arrMISCol.add(Helper.correctNull(rs1.getString("mis_subactdesc")));
							}
							else
							{
								arrMISCol.add("");
							}
							arrMISCol.add(Helper.correctNull((String)rs.getString("app_activitycode")));
							strSector=Helper.correctNull((String)rs.getString("app_sector"));
							if(strSector.equalsIgnoreCase("01") || strSector.equalsIgnoreCase("1"))
							{					
								arrMISCol.add("Priority Sector");
							}
							else if(strSector.equalsIgnoreCase("02") || strSector.equalsIgnoreCase("2"))
							{
								arrMISCol.add("Non Priority Sector");	
							}
							else
							{
								arrMISCol.add(" ");
							}
							arrMISCol.add(strSubSector);
							
							if(rs1!=null)
							{
							  rs1.close();				  
							}
							rs1=DBUtils.executeLAPSQuery("sel_guarantee^"+"11"+"^"+Helper.correctNull((String)rs.getString("app_sensitivesector")));
							if(rs1.next())
							{
								arrMISCol.add(Helper.correctNull((String)rs1.getString("mis_static_data_desc")));					
							}
							else
							{
								arrMISCol.add("Nil");	
							}	
							if(Helper.correctNull(rs.getString("APP_STANDUP_INDIA")).equalsIgnoreCase("Y"))
								arrMISCol.add("Yes");
							else if(Helper.correctNull(rs.getString("APP_STANDUP_INDIA")).equalsIgnoreCase("N"))
								arrMISCol.add("No");
							else
								arrMISCol.add("");
							
							if(rs1!=null)
							{
							  rs1.close();				  
							}
							rs1=DBUtils.executeLAPSQuery("sel_guarantee^"+"23"+"^"+Helper.correctNull((String)rs.getString("APP_GOVTANNOUNCESCHEME")));
							if(rs1.next())
							{
								arrMISCol.add(Helper.correctNull((String)rs1.getString("mis_static_data_desc")));					
							}
							else
							{
								arrMISCol.add("Nil");	
							}
							if(rs1!=null)
							{
							  rs1.close();				  
							}
							rs1=DBUtils.executeLAPSQuery("sel_guarantee^"+"17"+"^"+Helper.correctNull((String)rs.getString("APP_GUARANTEE")));
							if(rs1.next())
							{
								arrMISCol.add(Helper.correctNull((String)rs1.getString("mis_static_data_desc")));					
							}
							else
							{
								arrMISCol.add("Nil");	
							}
							
							arrMISCol.add(Helper.correctNull(rs.getString("app_guarantee")));
							arrMISCol.add(Helper.correctNull(rs.getString("APP_GUARANTEEAMT")));
							if(rs1!=null)
							{
							  rs1.close();				  
							}
							rs1=DBUtils.executeLAPSQuery("sel_cusdetails^"+strAppNewId);
							if(rs1.next())
							{
								arrMISCol.add(Helper.correctNull(rs1.getString("PERAPP_UDYAM_REGNO")));
								arrMISCol.add(Helper.correctNull(rs1.getString("PERAPP_SALES_TURNOVER")));
								arrMISCol.add(Helper.correctNull(rs1.getString("PERAPP_SALES_TURNOVER_DATE")));

								strcrtsales=Helper.correctNull((String)rs1.getString("PERAPP_CRITERIA_SALES_TURNOVER"));
								rs2=DBUtils.executeLAPSQuery("selmiscust^243^"+strcrtsales);
								if(rs2.next())
								{	
									arrMISCol.add(Helper.correctNull(rs2.getString("STAT_DATA_DESC1")));
					
								}
								else{
									arrMISCol.add("");	
								}

							}else{
								arrMISCol.add("");	
								arrMISCol.add("");	
								arrMISCol.add("");	

							}
							if(rs1!=null)
							{
							  rs1.close();				  
							}
							arrMISCol.add(Helper.correctNull(rs.getString("app_plantval")));
							arrMISCol.add(Helper.correctNull(rs.getString("app_indname")));
							rs1=DBUtils.executeLAPSQuery("sel_guarantee^"+"12"+"^"+Helper.correctNull((String)rs.getString("APP_AGRICULTURE")));
							if(rs1.next())
							{
								arrMISCol.add(Helper.correctNull((String)rs1.getString("mis_static_data_desc")));					
							}
							else
							{
								arrMISCol.add("");	
							}
							arrMISCol.add(Helper.correctNull(rs.getString("APP_INVESTMENT_DATE")));
							rs2=DBUtils.executeLAPSQuery("selmiscust^248^"+Helper.correctNull((String)rs.getString("APP_CRITERIA_INVESTMENT")));
							if(rs2.next())
							{	
								arrMISCol.add(Helper.correctNull(rs2.getString("STAT_DATA_DESC1")));

							}
							else
							{
								arrMISCol.add("");
							}
							arrMISCol.add(Helper.correctNull((String)rs.getString("facility")));					
							if(rs1!=null)
							{
							  rs1.close();				  
							}
							rs1=DBUtils.executeLAPSQuery("sel_guarantee^"+"9"+"^"+Helper.correctNull((String)rs.getString("app_weakersec")));
							if(rs1.next())
							{
								arrMISCol.add(Helper.correctNull((String)rs1.getString("mis_static_data_desc")));					
							}else
							{
								arrMISCol.add("");
							}
							arrMISCol.add(Helper.correctNull(rs.getString("APP_MINISTRY_INDUSTRY")));
							if(rs6!=null)
							{
								rs6.close();
							}
							strQuery=SQLParser.getSqlQuery("sel_minorityconstitutionchk^"+strAppNewId);
							rs6=DBUtils.executeQuery(strQuery);
							if(rs6.next())
							{
								arrMISCol.add("Y");

							}else{
								arrMISCol.add("");
							}
							arrMISRow.add(arrMISCol);
					}
						hshValues.put("arrMISRow", arrMISRow);
						
						strQuery = SQLParser.getSqlQuery("chk_geclfacchk^"+strAppno);
						if(rs != null)
							rs.close();
						rs = DBUtils.executeQuery(strQuery);
						while(rs.next())
						{
							if(Helper.correctNull(rs.getString("com_bankscheme")).equalsIgnoreCase("061"))
								hshValues.put("strgeclavailable","Y");	
						}
						
// code for RO
						strQuery="";
						strQuery = SQLParser.getSqlQuery("sel_com_sancdept^"+strAppno);
						if(rs != null)
							rs.close();
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							hshResult.put("selcom_sancdept",rs.getString("CBS_STATIC_DATA_DESC"));
						}
						else
						{
							strQuery = SQLParser.getSqlQuery("sel_sancref^"+strAppno);
							if(rs != null)
								rs.close();
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								String strcom_sandArr[]=null;
								String strcom_sand=rs.getString("SANCTIONREFNO");
								strcom_sandArr=strcom_sand.split("/");
								hshResult.put("selcom_sancdept",strcom_sandArr[0]);
							}
							else
							{
								hshResult.put("selcom_sancdept","");								
							}
						}

						hshResult.put("strOrgName", hshValues.get("strOrgName"));
						
						String strFacility		= "";
						String strFacilityId="";
						String strFacilityFor	="";
						String strFacilityDesc="";
						String strAppOldId="";
						String strValNew="";
						String strAssetClassification	= "";
						String strFacilityFC="";
						double strBankLimit=0.00,strBankOS=0.00,dblExposure=0.0;
						String strFacilityNature="";
						String strOutstandingDate="";
						
						if(rs !=null)
						{rs.close();}
						rs	= DBUtils.executeLAPSQuery("selectprocessnoteexistingfacilities^"+strAppno+"^"+strAppno);
						while(rs.next())
						{
							strFacilityFC=correctNull(rs.getString("com_headfac"));
							strBankLimit=Double.parseDouble(Helper.correctDouble(rs.getString("combk_limit")));
							strBankOS=Double.parseDouble(Helper.correctDouble(rs.getString("combk_os")));
							dblExposure=Double.parseDouble(Helper.correctDouble(rs.getString("com_exposure")));
							if(strFacilityFC.equalsIgnoreCase("1")){
								strBankLimit=strBankLimit/50;
								strBankOS=strBankOS/50;
								dblExposure=dblExposure/50;
							}
							arrOutCol	= new ArrayList();
							if(correctNull(rs.getString("facdesc")).equalsIgnoreCase("TL"))
								arrOutCol.add("Term Loan");
							else if(correctNull(rs.getString("facdesc")).equalsIgnoreCase("DL"))
								arrOutCol.add("DPN Loan");
							else if(correctNull(rs.getString("facdesc")).equalsIgnoreCase("OD"))
								arrOutCol.add("Overdraft");
							else 
								arrOutCol.add(correctNull(rs.getString("facdesc")));
							arrOutCol.add("");//1
							arrOutCol.add(String.valueOf(strBankLimit));//2
							arrOutCol.add(correctNull(rs.getString("combk_sancrefno")));//3
							arrOutCol.add(correctNull(rs.getString("combk_sancdate")));//4
							arrOutCol.add(correctNull(rs.getString("combk_spread")));//5
							arrOutCol.add(String.valueOf(strBankOS));//6
							arrOutCol.add(correctNull(rs.getString("combk_osasondate")));//7
							arrOutCol.add(correctNull(rs.getString("combk_duedate")));//8
							arrOutCol.add(correctNull(rs.getString("combk_arrears")));//9
							arrOutCol.add(correctNull(rs.getString("combk_purpose")));//10
							arrOutCol.add(correctNull(rs.getString("combk_inttype")));//11
							arrOutCol.add(correctNull(rs.getString("combk_interestrate")));//12
							arrOutCol.add(correctNull(rs.getString("combk_fac_grp")));//13
							String stringType=Helper.correctNull(rs.getString("combk_factype"));
							if(stringType.equalsIgnoreCase("M")){
								stringType="Main Limit";
							}else if(stringType.equalsIgnoreCase("S"))
							{
								stringType="Sub Limit";
							}
							arrOutCol.add(stringType);//14
							arrOutCol.add(correctNull(rs.getString("combk_remarks")));//15
							arrOutCol.add(correctNull(rs.getString("combk_factype")));//16
							arrOutCol.add(correctNull(rs.getString("combk_repaymentcmt")));//17
							arrOutCol.add(dblExposure+"");//18
							arrOutRow.add(arrOutCol);
							if(strOutstandingDate.equalsIgnoreCase(""))
								strOutstandingDate=correctNull(rs.getString("combk_osasondate"));
							
							
							if(Helper.correctNull(rs.getString("fac_type")).equalsIgnoreCase("P"))
							{
								if(rs1 !=null)
								{rs1.close();}
								rs1	= DBUtils.executeLAPSQuery("selectprocessnoteproposedsublimfacilities^"+Helper.correctNull(rs.getString("combk_parentappno"))+"^"+Helper.correctNull(rs.getString("combk_parentfacsno")));
								while(rs1.next())
								{
									strFacilityFC=correctNull(rs1.getString("com_headfac"));
									strBankLimit=Double.parseDouble(Helper.correctDouble(rs1.getString("combk_limit")));
									strBankOS=Double.parseDouble(Helper.correctDouble(rs1.getString("combk_os")));
									dblExposure=Double.parseDouble(Helper.correctDouble(rs1.getString("com_exposure")));
									if(strFacilityFC.equalsIgnoreCase("1")){
										strBankLimit=strBankLimit/50;
										strBankOS=strBankOS/50;
										dblExposure=dblExposure/50;
									}
									arrOutCol	= new ArrayList();
									
									if(rs2!=null)
										rs2.close();
									rs2	= DBUtils.executeLAPSQuery("getfacdetforsanction^"+Helper.correctInt(rs.getString("combk_parentappno"))+"^"+Helper.correctInt(rs.getString("combk_parentfacsno")));
										
									if(rs2.next())
									{
										arrOutCol.add(correctNull(rs1.getString("facdesc")) +"(Sub Limit of "+correctNull(rs2.getString("FACILITY_DISPLAYDESC"))+")");
									}
									else
									{
										arrOutCol.add(correctNull(rs1.getString("facdesc")));
									}
									arrOutCol.add("");//1
									arrOutCol.add(String.valueOf(strBankLimit));//2
									arrOutCol.add(correctNull(rs1.getString("combk_sancrefno")));//3
									arrOutCol.add(correctNull(rs1.getString("combk_sancdate")));//4
									arrOutCol.add(correctNull(rs1.getString("combk_spread")));//5
									arrOutCol.add(String.valueOf(strBankOS));//6
									arrOutCol.add(correctNull(rs1.getString("combk_osasondate")));//7
									arrOutCol.add(correctNull(rs1.getString("combk_duedate")));//8
									arrOutCol.add(correctNull(rs1.getString("combk_arrears")));//9
									arrOutCol.add(correctNull(rs1.getString("combk_purpose")));//10
									arrOutCol.add(correctNull(rs1.getString("combk_inttype")));//11
									arrOutCol.add(correctNull(rs1.getString("combk_interestrate")));//12
									arrOutCol.add(correctNull(rs1.getString("combk_fac_grp")));//13
									strType=Helper.correctNull(rs1.getString("combk_factype"));
									if(strType.equalsIgnoreCase("M")){
										strType="Main Limit";
									}else if(strType.equalsIgnoreCase("S"))
									{
										strType="Sub Limit";
									}
									arrOutCol.add(strType);//14
									arrOutCol.add(correctNull(rs1.getString("combk_remarks")));//15
									arrOutCol.add(correctNull(rs1.getString("combk_factype")));//16
									arrOutCol.add(correctNull(rs1.getString("combk_repaymentcmt")));//17
									arrOutCol.add(dblExposure+"");//18
									arrOutRow.add(arrOutCol);
								}
							}
							else
							{
								if(rs1 !=null)
								{rs1.close();}
								rs1	= DBUtils.executeLAPSQuery("selectprocessnoteexistingsublimfacilities^"+strAppno+"^"+Helper.correctNull(rs.getString("combk_parentappno"))+"^"+Helper.correctNull(rs.getString("combk_parentfacsno")));
								while(rs1.next())
								{
									strFacilityFC=correctNull(rs1.getString("com_headfac"));
									strBankLimit=Double.parseDouble(Helper.correctDouble(rs1.getString("combk_limit")));
									strBankOS=Double.parseDouble(Helper.correctDouble(rs1.getString("combk_os")));
									dblExposure=Double.parseDouble(Helper.correctDouble(rs1.getString("com_exposure")));
									if(strFacilityFC.equalsIgnoreCase("1")){
										strBankLimit=strBankLimit/50;
										strBankOS=strBankOS/50;
										dblExposure=dblExposure/50;
									}
									arrOutCol	= new ArrayList();

									if(rs2!=null)
										rs2.close();
									rs2	= DBUtils.executeLAPSQuery("getfacdetforsanction^"+Helper.correctInt(rs.getString("combk_parentappno"))+"^"+Helper.correctInt(rs.getString("combk_parentfacsno")));
										
									if(rs2.next())
									{
										arrOutCol.add(correctNull(rs1.getString("facdesc")) +"(Sub Limit of "+correctNull(rs2.getString("FACILITY_DISPLAYDESC"))+")");
									}
									else
									{
										arrOutCol.add(correctNull(rs1.getString("facdesc")));
									}
									
									arrOutCol.add("");//1
									arrOutCol.add(String.valueOf(strBankLimit));//2
									arrOutCol.add(correctNull(rs1.getString("combk_sancrefno")));//3
									arrOutCol.add(correctNull(rs1.getString("combk_sancdate")));//4
									arrOutCol.add(correctNull(rs1.getString("combk_spread")));//5
									arrOutCol.add(String.valueOf(strBankOS));//6
									arrOutCol.add(correctNull(rs1.getString("combk_osasondate")));//7
									arrOutCol.add(correctNull(rs1.getString("combk_duedate")));//8
									arrOutCol.add(correctNull(rs1.getString("combk_arrears")));//9
									arrOutCol.add(correctNull(rs1.getString("combk_purpose")));//10
									arrOutCol.add(correctNull(rs1.getString("combk_inttype")));//11
									arrOutCol.add(correctNull(rs1.getString("combk_interestrate")));//12
									arrOutCol.add(correctNull(rs1.getString("combk_fac_grp")));//13
									strType=Helper.correctNull(rs1.getString("combk_factype"));
									if(strType.equalsIgnoreCase("M")){
										strType="Main Limit";
									}else if(strType.equalsIgnoreCase("S"))
									{
										strType="Sub Limit";
									}
									arrOutCol.add(strType);//14
									arrOutCol.add(correctNull(rs1.getString("combk_remarks")));//15
									arrOutCol.add(correctNull(rs1.getString("combk_factype")));//16
									arrOutCol.add(correctNull(rs1.getString("combk_repaymentcmt")));//17
									arrOutCol.add(dblExposure+"");//18
									arrOutRownew.add(arrOutCol);
								}
							}
						}
						hshResult.put("arrBAOurRow", arrOutRownew);
						String strNoWC="0";
						String strConSno="";
						String intrate1="";
						String StrRemarksFlag="";
						String strBnkargWC="";
						String strTypeWC="";
						double dblMtplLimit=0.00,dblMtplOutstand=0.00,dblMtplIntRate=0.00,dblMultiExp=0.0;
						if(rs!=null){rs.close();}
						rs	= DBUtils.executeLAPSQuery("sel_BankingArrangement^"+strAppno);
						if(rs.next())
						{
							strNoWC = Helper.correctNull(rs.getString("com_wc_no"));
							strBnkargWC = Helper.correctNull(rs.getString("com_wc_bnkarg"));
							strTypeWC = Helper.correctNull(rs.getString("com_wc_type"));
						}
						if(strNoWC.equals("0"))
						{
							strConSno	= "1";
						}
						if(rs!=null){rs.close();}
						arrOutRow	= new ArrayList();
						strQuery = SQLParser.getSqlQuery("sel_BAConsortium^"+strAppno+"^"+strConSno);
						if(rs!=null){rs.close();}
						rs = DBUtils.executeQuery(strQuery);
						
						while(rs.next())
						{
							arrOutCol	= new ArrayList();
							
							arrOutCol.add(Helper.correctInt((String)rs.getString("com_con_sno")));//0
							arrOutCol.add(correctNull((String)rs.getString("com_con_bank_code")));//1
							arrOutCol.add(correctNull((String)rs.getString("com_con_fac_nature")));//2
							
							if(correctNull((String)rs.getString("com_con_fac_type")).equalsIgnoreCase("M"))
							{
								arrOutCol.add("Main-Limit");
							}
							else
							{
								arrOutCol.add("Sub-Limit");
							}
						//	arrOutCol.add(correctNull((String)rs.getString("com_con_fac_type")));//3
							
							arrOutCol.add(correctNull((String)rs.getString("com_con_fac_limitof")));//4
							arrOutCol.add(Helper.correctInt((String)rs.getString("com_con_limit")));//5
							arrOutCol.add(Helper.correctInt((String)rs.getString("com_con_outstanding")));//6
							
							intrate1=Helper.correctInt((String)rs.getString("com_con_int_rate"));
							if(intrate1.equalsIgnoreCase("0"))
							{
								arrOutCol.add("");
							}
							else
							{
								arrOutCol.add(Helper.checkDecimal(intrate1));//7
							}
							//arrOutCol.add(Helper.correctInt((String)rs.getString("com_con_int_rate")));//7
							if(correctNull((String)rs.getString("com_con_fac_type")).equalsIgnoreCase("M"))
							{
								dblMtplLimit = dblMtplLimit + Double.parseDouble((String)rs.getString("com_con_limit"));
								dblMtplOutstand = dblMtplOutstand + Double.parseDouble((String)rs.getString("com_con_outstanding"));
								dblMtplIntRate = dblMtplIntRate + Double.parseDouble((String)rs.getString("com_con_int_rate"));
							}
							
							arrOutCol.add(correctNull(Helper.CLOBToString(rs.getClob("com_con_remarks"))));//8
							if(!correctNull(Helper.CLOBToString(rs.getClob("com_con_remarks"))).equalsIgnoreCase(""))
							{
								StrRemarksFlag="Y";
							}
							
							if(rs1!=null){rs1.close();}
							if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
								 String Pattern="dd/MM/yyyy";
									DateFormat df=new SimpleDateFormat(Pattern);
									Date appcreationdate=df.parse(appcreatedate);
									Date postsanclivedate=df.parse(livedate);
									if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
									{
							rs1 = DBUtils.executeLAPSQuery("getstaticdescription^147^"+correctNull((String)rs.getString("com_con_bank_code")));
							if(!rs1.next())
							{
								arrOutCol.add("");
							}
							rs1.beforeFirst();
							while(rs1.next())
							{
								arrOutCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//9
								break;
							}
									}else{
										arrOutCol.add(correctNull((String)rs.getString("com_con_bank_code")));//9
									}
							}
							if(rs1!=null){rs1.close();}
							rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^144^"+correctNull((String)rs.getString("com_con_fac_nature")));
							if(!rs1.next())
							{
								arrOutCol.add("");
							}
							rs1.beforeFirst();
							while(rs1.next())
							{
								arrOutCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//10
								break;
							}
							arrOutCol.add(Helper.correctNull((String)rs.getString("COM_CON_BRANCH_NAME")));//13
							arrOutCol.add(Helper.correctNull((String)rs.getString("COM_CON_EMAIL_ID")));//14
							if(rs1!=null){rs1.close();}
							if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
								 String Pattern="dd/MM/yyyy";
									DateFormat df=new SimpleDateFormat(Pattern);
									Date appcreationdate=df.parse(appcreatedate);
									Date postsanclivedate=df.parse(livedate);
									if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
									{
							rs1 = DBUtils.executeLAPSQuery("getstaticdescription^259^"+correctNull((String)rs.getString("COM_CON_BRANCH_NAME")));
							if(rs1.next())
							{
								arrOutCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//12
							}else
							{
								arrOutCol.add("");
							}
									}else{
										arrOutCol.add(correctNull((String)rs.getString("COM_CON_BRANCH_NAME")));//12
									}
									}
							arrOutRow.add(arrOutCol);
						}
						
						
					}
					catch(Exception e1)
					{
						throw new EJBException("Error closing connection.."+e1.toString());
					}
					finally
					{
						try
						{
							if(rs!=null)
								rs.close();
							
							if(rs1!=null)
								rs1.close();
							
							if(rs2!=null)
								rs2.close();
						
						}
						catch(Exception e)
						{
							log.error(e.toString());
						}
					}
				return hshResult;

				}
				}		
				
				