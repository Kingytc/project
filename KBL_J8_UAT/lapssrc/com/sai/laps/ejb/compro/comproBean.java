package com.sai.laps.ejb.compro;
import java.io.ByteArrayOutputStream;
import java.rmi.RemoteException;
import java.sql.Blob;
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
import com.sai.laps.ejb.ComProposal.ComProposalBean;
import com.sai.laps.ejb.bankapp.BankAppBean;
import com.sai.laps.ejb.comassestsliab.ComAssetsLiabBean;
import com.sai.laps.ejb.commdocument.CommDocumentBean;
import com.sai.laps.ejb.dscr.DscrBean;
import com.sai.laps.ejb.financial.FinancialBean;
import com.sai.laps.ejb.lapsReport.lapsReportBean;
import com.sai.laps.ejb.mastapplicant.MastApplicantBean;
import com.sai.laps.helper.SAILogger;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.ApplicantParams;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.securitymaster.SecurityMasterBean;

@Stateless(name = "comproBean", mappedName = "comproHome")
@Remote (comproRemote.class)
public class comproBean extends BeanAdapter
{

	private static final long serialVersionUID = 1L;
	
	

static Logger log=Logger.getLogger(comproBean.class);	


	public HashMap updatePromoter(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQuery ;
		HashMap hshRecord = new HashMap();
		ArrayList arrValues ; 
		ArrayList arr= new ArrayList() ;
		ResultSet rs=null,rs1=null;
		String strAction="",strQuery ="";
		int intValue = 0;
		String appno="";
		String cho="", strExcep="$";
		String strType="",strProlen="",strProlen1="",strMeans="";
		String strPromType=null;
		int intUpdatesize=0;
		StringBuilder sbolddata=new StringBuilder();
		int Paramlen=0;
		String strFacilitySno="";
		String strModuleType="";
		try
		{
			strAction=correctNull((String)hsh.get("hidAction"));				
			appno=(String)hsh.get("appno");
			cho=correctNull((String)hsh.get("cho"));
			strFacilitySno=Helper.correctInt((String)hsh.get("sel_facility"));
			strModuleType=Helper.correctInt((String)hsh.get("sessionModuleType"));
			
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("Delete"))
			{
				strQuery=SQLParser.getSqlQuery("compromoterselection^"+appno+"^"+cho+"^"+strFacilitySno);
				rs=DBUtils.executeQuery(strQuery);	
				if(rs.next())
				{
					
					strPromType=correctNull(rs.getString("COM_COMPDTTYPE"));
					String strProGua[]=strPromType.split("@");
					sbolddata.append("~Type=");
					for(int j=0;j<strProGua.length;j++){
						if(j!=(strProGua.length-1))
						{
							strProlen=strProlen+(ApplicantParams.getApplicantParams("PROMOTORTYPE",correctNull(strProGua[j])))+", ";
						}
						else
						{
							strProlen=strProlen+(ApplicantParams.getApplicantParams("PROMOTORTYPE",correctNull(strProGua[j])))+" ";
						}
						
						
						Paramlen=strProlen.length();
						if(Paramlen>0)
						{
							strProlen=strProlen.substring(0,Paramlen-1);
						}
					}
					if(!correctNull(rs.getString("com_compdtid")).equalsIgnoreCase(""))
					{
						strQuery=SQLParser.getSqlQuery("selcreditreport2^"+appno+"^"+correctNull(rs.getString("com_compdtid")));
						rs1=DBUtils.executeQuery(strQuery);	
						if(rs1.next())
						{
							strMeans=correctNull(rs1.getString("CR_Total_MEANS"));
						}
					}
					if(rs1!=null)
					{
						rs1.close();
					}
					sbolddata.append(strProlen);
					String strstake="";
					if(correctNull(rs.getString("COM_COMPDSTKHOLDER")).equalsIgnoreCase("Yes"))
					{
						strstake="Yes";
					}
					else if(correctNull(rs.getString("COM_COMPDSTKHOLDER")).equalsIgnoreCase("No"))
					{
						strstake="No";
					}
					sbolddata.append("~First Name=").append(correctNull(rs.getString("com_compdtfname"))).append(
					"~Middle Name=").append(correctNull(rs.getString("com_compdtmname"))).append(
					"~Last Name=").append(correctNull(rs.getString("com_compdtlname"))).append(
					"~Date of Birth=").append(correctNull(rs.getString("com_compdtdob"))).append(
					"~Sex of Promoter/Directors/Partners=").append(correctNull(rs.getString("COM_COMPDSEX"))).append(
					"~Academic Qualification=").append(correctNull(rs.getString("COM_COMPDACA"))).append(
					"~Designation=").append(correctNull(rs.getString("com_compdtdesignation"))).append(
					"~Experience of Promoters/Directors=").append(correctNull(rs.getString("COM_COMPDEXP"))).append(
					"~Whether the promoter is major stake holder=").append(strstake).append(
					"~Address1=").append(correctNull(rs.getString("com_compdtaddress1"))).append(
					"~Address2=").append(correctNull(rs.getString("com_compdtaddress2"))).append(
					"~City=").append(correctNull(rs.getString("com_compdtcity"))).append(
					"~State=").append(correctNull(rs.getString("com_compdtstate"))).append(
					"~Pin Code=").append(correctNull(rs.getString("com_compdtpin"))).append(
					"~Phone=").append(correctNull(rs.getString("com_compdtphone"))).append(
					"~Fax=").append(correctNull(rs.getString("com_compdtfax"))).append(
					"~Email=").append(correctNull(rs.getString("com_compdtemail"))).append(
					"~Means=").append(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(strMeans)))).append(
					"~DIN=").append(correctNull((String)rs.getString("COM_COMPDTDIN"))).append(
					"~Share(%)=").append(correctNull(rs.getString("com_comdtpershare"))).append(
					"~Shares Held=").append(correctNull(rs.getString("com_compdtshareheld"))).append(
					"~Total Value of Shares=").append(correctNull(rs.getString("com_facevalue"))).append(
					"~Capital Contribution=").append(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(rs.getString("CapContribution"))))).append(
					"~As on Date=").append(correctNull(rs.getString("com_compdate")));
				}
			}
			if (strAction.equals("delete"))
			{
				intUpdatesize=1;
				String StrComappiD="",StrregSno="";
				boolean DelFlag=true;
				strQuery = SQLParser.getSqlQuery("getFacilityData^"+appno+"^"+strFacilitySno);
				rs =DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
				   String strtAdhocChk=Helper.correctNull(rs.getString("facility_category"));
				   String strAdhocAddFacility=Helper.correctNull(rs.getString("FACILITY_ADHOCFAC"));
				   
				   if(Helper.correctNull(rs.getString("facility_group")).equalsIgnoreCase("0"))
				   {
					   if(rs1!=null)
						   rs1.close();
					   	strQuery = SQLParser.getSqlQuery("selsublimfacilities^"+appno+"^"+Helper.correctNull(rs.getString("facility_sno")));
						rs1 =DBUtils.executeQuery(strQuery);
						while(rs1.next())
						{
							{
								hshqueryval.put("size",Integer.toString(intUpdatesize));

								hshquery = new HashMap();
								arr = new ArrayList();
								arr.add(Helper.correctNull(rs1.getString("facility_sno")));
								arr.add(appno);
								arr.add(cho);
								hshquery.put("strQueryId","compromoterdel");
								hshquery.put("arrValues",arr);
								hshqueryval.put(Integer.toString(intUpdatesize),hshquery);
								
								intUpdatesize=intUpdatesize+1;
								arr=new ArrayList();
								hshquery=new HashMap();
								hshqueryval.put("size",Integer.toString(intUpdatesize));
								hshquery.put("strQueryId","delcoappguarpropsec");
								arr.add(appno);
								arr.add(cho);
								arr.add(Helper.correctNull(rs1.getString("facility_sno")));
								hshquery.put("arrValues",arr);
								hshqueryval.put("size",Integer.toString(intUpdatesize));
								hshqueryval.put(Integer.toString(intUpdatesize),hshquery);
								
								intUpdatesize=intUpdatesize+1;
								
							}
						}
				   }
				   if(strtAdhocChk.equalsIgnoreCase("R"))
				   {
					   hshquery = new HashMap();
						arr = new ArrayList();
						hshquery.put("strQueryId","compromoterdel");
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						arr.add(strFacilitySno);
						arr.add(appno);
						arr.add(cho);
						hshquery.put("arrValues",arr);
						hshqueryval.put(Integer.toString(intUpdatesize),hshquery);  
						
						String StrSubQuery=appno+"~"+strFacilitySno+"~";
						strQuery = SQLParser.getSqlQuery("sel_regularlimit^"+appno+"^"+StrSubQuery);
						rs1 =DBUtils.executeQuery(strQuery);
						while(rs1.next())
						{
							StrregSno=Helper.correctNull((String)rs1.getString("FACILITY_SNO"));
							if(!StrregSno.equalsIgnoreCase(""))
							{
								intUpdatesize=intUpdatesize+1;
								hshqueryval.put("size",Integer.toString(intUpdatesize));

								hshquery = new HashMap();
								arr = new ArrayList();
								arr.add(StrregSno);
								arr.add(appno);
								arr.add(cho);
								hshquery.put("strQueryId","compromoterdel");
								hshquery.put("arrValues",arr);
								hshqueryval.put(Integer.toString(intUpdatesize),hshquery);  
								
								intUpdatesize=intUpdatesize+1;
								arr=new ArrayList();
								hshquery=new HashMap();
								hshqueryval.put("size",Integer.toString(intUpdatesize));
								hshquery.put("strQueryId","delcoappguarpropsec");
								arr.add(appno);
								arr.add(cho);
								arr.add(StrregSno);
								hshquery.put("arrValues",arr);
								hshqueryval.put("size",Integer.toString(intUpdatesize));
								hshqueryval.put(Integer.toString(intUpdatesize),hshquery);
								
							}
						}
				   }
				   else
				   {
					   if(!strAdhocAddFacility.equalsIgnoreCase(""))
					   {
							String[] strAdhocArr=strAdhocAddFacility.split("~");
							if(strAdhocArr.length>1)
							{
							   strQuery = SQLParser.getSqlQuery("sel_companydetail_other^"+appno+"^"+strFacilitySno+"^"+appno+"^"+strAdhocArr[1]);
							   rs1 =DBUtils.executeQuery(strQuery);
							   if(rs1.next())
							   {
								    DelFlag=false;
									strExcep=strExcep+"You Can't Delete, Please detach from the Base facility";
									throw new Exception(strExcep);  
							   }
							}
						}
					   
					   if(DelFlag)
					   {
						   hshquery = new HashMap();
						   hshqueryval.put("size",Integer.toString(intUpdatesize));
							arr = new ArrayList();
							arr.add(strFacilitySno);
							arr.add(appno);
							arr.add(cho);
							hshquery.put("strQueryId","compromoterdel");
							hshquery.put("arrValues",arr);
							hshqueryval.put(Integer.toString(intUpdatesize),hshquery);  
					   }
				   }
				}
				
				

				intUpdatesize=intUpdatesize+1;
				arr=new ArrayList();
				hshquery=new HashMap();
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshquery.put("strQueryId","delcreditreport");
				arr.add(appno);
				arr.add(cho);
				hshquery.put("arrValues",arr);
				hshqueryval.put(Integer.toString(intUpdatesize),hshquery);
				
				intUpdatesize=intUpdatesize+1;
				arr=new ArrayList();
				hshquery=new HashMap();
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshquery.put("strQueryId","delcreditreport2");
				arr.add(appno);
				arr.add(cho);
				hshquery.put("arrValues",arr);
				hshqueryval.put(Integer.toString(intUpdatesize),hshquery); 
				
				intUpdatesize=intUpdatesize+1;
				arr=new ArrayList();
				hshquery=new HashMap();
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshquery.put("strQueryId","delcreditreport3");
				arr.add(appno);
				arr.add(cho);
				hshquery.put("arrValues",arr);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshquery);
				
				if(Helper.correctNull((String)hsh.get("strAppType")).equalsIgnoreCase("P"))
				{
//			By Guhan Tamilvanan on 22.01.2015					
//					intUpdatesize=intUpdatesize+1;
//					arr=new ArrayList();
//					hshquery=new HashMap();
//					hshqueryval.put("size",Integer.toString(intUpdatesize));
//					hshquery.put("strQueryId","upd_dettachflag_coappguarfacwise");
//					arr.add(cho);
//					arr.add(appno);
//					arr.add(strFacilitySno);
//					hshquery.put("arrValues",arr);
//					hshqueryval.put("size",Integer.toString(intUpdatesize));
//					hshqueryval.put(Integer.toString(intUpdatesize),hshquery);
//					
//					intUpdatesize=intUpdatesize+1;
//					arr=new ArrayList();
//					hshquery=new HashMap();
//					hshqueryval.put("size",Integer.toString(intUpdatesize));
//					hshquery.put("strAppendString"," and APP_SEC_SECUTYPE=?");
//					hshquery.put("strQueryId","delcoappguarfacwisesec");
//					arr.add(appno);
//					arr.add(cho);
//					arr.add(strFacilitySno);
//					arr.add("P");
//					arr.add("P");
//					hshquery.put("arrValues",arr);
//					hshqueryval.put("size",Integer.toString(intUpdatesize));
//					hshqueryval.put(Integer.toString(intUpdatesize),hshquery);
					
				}
				else
				{
					intUpdatesize=intUpdatesize+1;
					arr=new ArrayList();
					hshquery=new HashMap();
					hshqueryval.put("size",Integer.toString(intUpdatesize));
					hshquery.put("strQueryId","delcoappguarpropsec");
					arr.add(appno);
					arr.add(cho);
					arr.add(strFacilitySno);
					hshquery.put("arrValues",arr);
					hshqueryval.put("size",Integer.toString(intUpdatesize));
					hshqueryval.put(Integer.toString(intUpdatesize),hshquery);
					
				}
				
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				
				strQuery = SQLParser.getSqlQuery("selpromotorsidfromappprofile^"+cho+"^"+appno+"^"+cho+"^"+appno);
				
				if(rs!=null)
					rs.close();
				rs =DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					intUpdatesize=0;
					hshqueryval=new HashMap();
					
					intUpdatesize=intUpdatesize+1;
					arr=new ArrayList();
					hshquery=new HashMap();
					hshqueryval.put("size",Integer.toString(intUpdatesize));
					hshquery.put("strQueryId","delcoappguarexistingsec");
					arr.add(appno);
					arr.add("E");
					arr.add(cho);
					hshquery.put("arrValues",arr);
					hshqueryval.put("size",Integer.toString(intUpdatesize));
					hshqueryval.put(Integer.toString(intUpdatesize),hshquery);
					
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				}
				
				
				
				
			}
			else if (strAction.equals("update"))
			{
				intUpdatesize=1;
				hshquery.put("strQueryId","compromoterdel");
				arr.add(strFacilitySno);
				arr.add(appno);
				arr.add(cho);
				hshquery.put("arrValues",arr);
				hshqueryval.put(Integer.toString(intUpdatesize),hshquery);
				//EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");

				intUpdatesize=intUpdatesize+1;
				hshquery = new HashMap();
				arr=new ArrayList();
				hshquery.put("strQueryId","compromoterdelbyname");
				arr.add(appno);
				arr.add("gen");
				hshquery.put("arrValues",arr);
				hshqueryval.put(Integer.toString(intUpdatesize),hshquery);
				
					intUpdatesize=intUpdatesize+1;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					strType=Helper.correctNull((String)hsh.get("hid_str_type"));  //by balaji as per req. specification
					//intUpdatesize=intUpdatesize+1;
				
				
					arrValues.add(appno);
					arrValues.add(cho);
					arrValues.add(Helper.correctNull((String)hsh.get("Type")));			
					arrValues.add(correctNull((String)hsh.get("fname")));
					arrValues.add(correctNull((String)hsh.get("lname")));	
					arrValues.add(correctNull((String)hsh.get("mname")));	
					arrValues.add(correctNull((String)hsh.get("dob")));	
					arrValues.add(correctNull((String)hsh.get("addr1")));	
					arrValues.add(correctNull((String)hsh.get("addr2")));	
					arrValues.add(correctNull((String)hsh.get("city")));	
					arrValues.add(correctNull((String)hsh.get("state")));	
					arrValues.add(correctNull((String)hsh.get("pin")));	
					arrValues.add(correctNull((String)hsh.get("phone")));	
					arrValues.add(correctNull((String)hsh.get("fax")));	
					arrValues.add(correctNull((String)hsh.get("email")));	
					arrValues.add(correctNull((String)hsh.get("share")));	
					arrValues.add(correctNull((String)hsh.get("held")));	
					arrValues.add(correctNull((String)hsh.get("networth")));	
					arrValues.add(correctNull((String)hsh.get("valdate")));	
					arrValues.add(Helper.correctDouble((String)hsh.get("txt_capital")));	
					arrValues.add(Helper.correctInt((String)hsh.get("txt_percent")));	
					arrValues.add(correctNull((String)hsh.get("selemp")));	
					arrValues.add(correctNull((String)hsh.get("txt_academic")));	
					arrValues.add(correctNull((String)hsh.get("txt_exp")));
					arrValues.add(correctNull((String)hsh.get("selstake")));	
					arrValues.add(correctNull((String)hsh.get("txt_background")));			
					arrValues.add(correctNull((String)hsh.get("facevalue")));
					arrValues.add(correctNull((String)hsh.get("txt_desig")));
					arrValues.add(correctNull((String)hsh.get("txt_din")));
					arrValues.add(correctNull((String)hsh.get("hidDemoId")));
					arrValues.add(correctNull((String)hsh.get("hidOldId")));
					
					arrValues.add(correctNull((String)hsh.get("sel_CBSrelation")));
					arrValues.add(correctNull((String)hsh.get("txt_ratinggrade1")));
					arrValues.add(correctNull((String)hsh.get("txt_ratingdate1")));
					arrValues.add(correctNull((String)hsh.get("rating_type1")));
					arrValues.add(correctNull((String)hsh.get("txt_ratinggrade2")));
					arrValues.add(correctNull((String)hsh.get("txt_ratingdate2")));
					arrValues.add(correctNull((String)hsh.get("rating_type2")));
					arrValues.add(correctNull((String)hsh.get("txt_relshipthemselves")));
					arrValues.add(correctNull((String)hsh.get("sel_relation_type")));
					arrValues.add(strFacilitySno);
					arrValues.add(Helper.correctNull((String)hsh.get("Type")));	// for DOCPRINT
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","compromoterins");
					hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
					hshqueryval.put("size",Integer.toString(intUpdatesize));
				
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");	
				
				if(Helper.correctNull((String)hsh.get("hidCategoryType")).equalsIgnoreCase("STL")
						|| Helper.correctNull((String)hsh.get("hidCategoryType")).equalsIgnoreCase("ADC")
						|| Helper.correctNull((String)hsh.get("hidCategoryType")).equalsIgnoreCase("SRE"))
				{
					intUpdatesize=intUpdatesize+1;
					hshqueryval = new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					
					arrValues.add("");//CR_APPNAME
					arrValues.add("");//CR_Gurantee
					arrValues.add("");//CR_LIAB_Partner
					arrValues.add("");//CR_Business_ability
					arrValues.add("");//CR_Business_Conducted
					arrValues.add("");//CR_Business_Reputation
					arrValues.add("");//CR_Business_Condition
					arrValues.add("");//CR_DEALINGS_BANK
					arrValues.add("");//CR_SECURITIES_CHARGED
					arrValues.add("");//CR_REPORT_ON_MEANS
					arrValues.add(correctNull((String)hsh.get("valdate")));//CR_DATE	
					arrValues.add(correctNull((String)hsh.get("txt_means")));//CR_APPTYPE
					arrValues.add(correctNull((String)hsh.get("valdate")));
					arrValues.add(appno);//CR_APPNO
					arrValues.add(cho);//cr_slno
					
					hshQuery.put("strQueryId","updcreditreport2");
					hshQuery.put("arrValues",arrValues);
					hshqueryval.put("1",hshQuery);
					hshqueryval.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
					
					
					}
				String StrregSno="";
				String StrSubQuery=appno+"~"+strFacilitySno+"~";
				strQuery = SQLParser.getSqlQuery("sel_regularlimit^"+appno+"^"+StrSubQuery);
				rs =DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					StrregSno=Helper.correctNull((String)rs.getString("FACILITY_SNO"));
					if(!StrregSno.equalsIgnoreCase(""))
					{
						hshqueryval = new HashMap();
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						arrValues.add(StrregSno);
						arrValues.add(appno);
						arrValues.add(cho);
						hshQuery.put("strQueryId","compromoterdel");
						hshQuery.put("arrValues",arrValues);
						hshqueryval.put("1",hshQuery);	
						
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId","updcom_companydetails_aa");
						arrValues.add(appno);
						arrValues.add(StrregSno);	
						arrValues.add(strFacilitySno);
						arrValues.add(appno);
						arrValues.add(cho);
						hshQuery.put("arrValues",arrValues);
						hshqueryval.put("2",hshQuery);	
						hshqueryval.put("size","2");
			    		EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
					}
				}
				
				if(Helper.correctNull((String)hsh.get("hidFacgroup")).equalsIgnoreCase("0"))
				{
					   if(rs1!=null)
						   rs1.close();
					   	strQuery = SQLParser.getSqlQuery("selsublimfacilities^"+appno+"^"+strFacilitySno);
						rs1 =DBUtils.executeQuery(strQuery);
						while(rs1.next())
						{
							hshqueryval = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							arrValues.add(Helper.correctNull(rs1.getString("facility_sno")));
							arrValues.add(appno);
							arrValues.add(cho);
							hshQuery.put("strQueryId","compromoterdel");
							hshQuery.put("arrValues",arrValues);
							hshqueryval.put("1",hshQuery);	
							
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							hshQuery.put("strQueryId","updcom_companydetails_aa");
							arrValues.add(appno);
							arrValues.add(Helper.correctNull(rs1.getString("facility_sno")));	
							arrValues.add(strFacilitySno);
							arrValues.add(appno);
							arrValues.add(cho);
							hshQuery.put("arrValues",arrValues);
							hshqueryval.put("2",hshQuery);	
							hshqueryval.put("size","2");
				    		EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
						}
				}
				
			}	
			if(strAction.equals("insert"))
			{
				
				if(rs!=null)
					rs.close();
				
					strQuery = SQLParser.getSqlQuery("chkpromotorchk^"+Helper.correctInt((String)hsh.get("hidOldId"))+"^"+strFacilitySno+"^"+appno);
				
					rs =DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strExcep=strExcep+"the Customer already attached for this Facility";
						throw new Exception(strExcep);
					}
				
				strQuery = SQLParser.getSqlQuery("compromotermax^"+appno);
				
				rs =DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					intValue = (rs.getInt(1));
				}
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();				
	
					strType=Helper.correctNull((String)hsh.get("hid_str_type"));         //by balaji as per req. specification
					intUpdatesize=intUpdatesize+1;
					hshQuery.put("strQueryId","compromoterins");
					
					//intValue=intValue+1;
					String i=Integer.toString(intValue);
					arrValues.add(appno);
					arrValues.add(i);
					arrValues.add(Helper.correctNull((String)hsh.get("Type")));
					arrValues.add(correctNull((String)hsh.get("fname")));							
					arrValues.add(correctNull((String)hsh.get("lname")));
					arrValues.add(correctNull((String)hsh.get("mname")));
					arrValues.add(correctNull((String)hsh.get("dob")));
					arrValues.add(correctNull((String)hsh.get("addr1")));
					arrValues.add(correctNull((String)hsh.get("addr2")));
					arrValues.add(correctNull((String)hsh.get("city")));
					arrValues.add(correctNull((String)hsh.get("state")));
					arrValues.add(correctNull((String)hsh.get("pin")));
					arrValues.add(correctNull((String)hsh.get("phone")));
					arrValues.add(correctNull((String)hsh.get("fax")));
					arrValues.add(correctNull((String)hsh.get("email")));
					arrValues.add(correctNull((String)hsh.get("share")));
					arrValues.add(correctNull((String)hsh.get("held")));
					arrValues.add(correctNull((String)hsh.get("networth")));
					arrValues.add(correctNull((String)hsh.get("valdate")));
					arrValues.add(correctNull((String)hsh.get("txt_capital")));	
					arrValues.add(correctNull((String)hsh.get("txt_percent")));	
					arrValues.add(correctNull((String)hsh.get("selemp")));
					arrValues.add(correctNull((String)hsh.get("txt_academic")));
					arrValues.add(correctNull((String)hsh.get("txt_exp")));
					arrValues.add(correctNull((String)hsh.get("selstake")));
					arrValues.add(correctNull((String)hsh.get("txt_background")));
					arrValues.add(correctNull((String)hsh.get("facevalue")));
					arrValues.add(correctNull((String)hsh.get("txt_desig")));
					arrValues.add(correctNull((String)hsh.get("txt_din")));
					arrValues.add(correctNull((String)hsh.get("hidDemoId")));
					arrValues.add(correctNull((String)hsh.get("hidOldId")));
					
					arrValues.add(correctNull((String)hsh.get("sel_CBSrelation")));
					arrValues.add(correctNull((String)hsh.get("txt_ratinggrade1")));
					arrValues.add(correctNull((String)hsh.get("txt_ratingdate1")));
					arrValues.add(correctNull((String)hsh.get("rating_type1")));
					arrValues.add(correctNull((String)hsh.get("txt_ratinggrade2")));
					arrValues.add(correctNull((String)hsh.get("txt_ratingdate2")));
					arrValues.add(correctNull((String)hsh.get("rating_type2")));
					arrValues.add(correctNull((String)hsh.get("txt_relshipthemselves")));
					arrValues.add(correctNull((String)hsh.get("sel_relation_type")));
					arrValues.add(strFacilitySno);
					arrValues.add(Helper.correctNull((String)hsh.get("Type")));// for DOCPRINT
					hshQuery.put("arrValues",arrValues);
					hshqueryval.put("size",Integer.toString(intUpdatesize));
					hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");	
					String StrregSno="";
					
					String StrSubQuery=appno+"~"+strFacilitySno+"~";
					strQuery = SQLParser.getSqlQuery("sel_regularlimit^"+appno+"^"+StrSubQuery);
					rs =DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						StrregSno=Helper.correctNull((String)rs.getString("FACILITY_SNO"));
						if(!StrregSno.equalsIgnoreCase(""))
						{
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							hshQuery.put("strQueryId","updcom_companydetails_aa");
							arrValues.add(appno);
							arrValues.add(StrregSno);	
							arrValues.add(strFacilitySno);
							arrValues.add(appno);
							arrValues.add(correctNull((String)hsh.get("hidOldId")));
							hshQuery.put("arrValues",arrValues);
							hshqueryval.put("1",hshQuery);	
							hshqueryval.put("size","1");
				    		EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
						}
					}
					
					if(Helper.correctNull((String)hsh.get("hidFacgroup")).equalsIgnoreCase("0"))
					{
						   if(rs1!=null)
							   rs1.close();
						   	strQuery = SQLParser.getSqlQuery("selsublimfacilities^"+appno+"^"+strFacilitySno);
							rs1 =DBUtils.executeQuery(strQuery);
							while(rs1.next())
							{
								hshqueryval = new HashMap();
								
								hshQuery = new HashMap();
								arrValues = new ArrayList();
								hshQuery.put("strQueryId","updcom_companydetails_aa");
								arrValues.add(appno);
								arrValues.add(Helper.correctNull(rs1.getString("facility_sno")));	
								arrValues.add(strFacilitySno);
								arrValues.add(appno);
								arrValues.add(correctNull((String)hsh.get("hidOldId")));
								hshQuery.put("arrValues",arrValues);
								hshqueryval.put("1",hshQuery);	
								hshqueryval.put("size","1");
					    		EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
							}
					}
					
					
				
				if(Helper.correctNull((String)hsh.get("hidCategoryType")).equalsIgnoreCase("STL")
						|| Helper.correctNull((String)hsh.get("hidCategoryType")).equalsIgnoreCase("ADC")
						|| Helper.correctNull((String)hsh.get("hidCategoryType")).equalsIgnoreCase("SRE"))
				{
					hshqueryval = new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					
					arrValues.add(appno);//CR_APPNO
					arrValues.add("");//CR_APPNAME
					arrValues.add("");//CR_Gurantee
					arrValues.add("");//CR_LIAB_Partner
					arrValues.add("");//CR_Business_ability
					arrValues.add("");//CR_Business_Conducted
					arrValues.add("");//CR_Business_Reputation
					arrValues.add("");//CR_Business_Condition
					arrValues.add("");//CR_DEALINGS_BANK
					arrValues.add("");//CR_SECURITIES_CHARGED
					arrValues.add("");//CR_REPORT_ON_MEANS
					arrValues.add(correctNull((String)hsh.get("valdate")));//CR_DATE	
					arrValues.add(correctNull((String)hsh.get("txt_means")));//CR_Total_MEANS
					arrValues.add(i);//CR_APPTYPE
					arrValues.add(correctNull((String)hsh.get("inwardno")));//cr_inwardno
					arrValues.add("");//cr_slno
					arrValues.add("");//cr_crdinvestigator
					arrValues.add("");//cr_branchmanager
					arrValues.add(correctNull((String)hsh.get("valdate")));
					hshQuery.put("strQueryId","inscreditreport2");
					hshQuery.put("arrValues",arrValues);
					hshqueryval.put("1",hshQuery);
					hshqueryval.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				}
			}
			if(strAction.equals("Undo"))
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshqueryval=new HashMap();
				arrValues.add("N");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upd_PERAPPLICANT_freeze");//added by ganesan
				hshqueryval.put("size","4");
				hshqueryval.put("1",hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_groupconcern_freeze");//added by ganesan
				hshqueryval.put("size","4");
				hshqueryval.put("2",hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add("E");
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_banking_freeze");
				hshqueryval.put("size","4");
				hshqueryval.put("3",hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_appsecurities_freeze");
				hshqueryval.put("size","4");
				hshqueryval.put("4",hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add("E");
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_comfacility_details");
				hshqueryval.put("size","5");
				hshqueryval.put("5",hshQuery);
				
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				arrValues.add(appno);
//				arrValues.add(appno);
//				hshQuery.put("arrValues",arrValues);
//				hshQuery.put("strQueryId","del_appsecurities_freeze_corp");
//				hshqueryval.put("size","5");
//				hshqueryval.put("5",hshQuery);
				
				if(strModuleType.equalsIgnoreCase("AGR"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(appno);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","agr_dssassessment_delete");
					hshqueryval.put("size","6");
					hshqueryval.put("6",hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(appno);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","agr_dssaveragenetsurplus_delete");
					hshqueryval.put("size","7");
					hshqueryval.put("7",hshQuery);
				}
				
		  		EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			
			 //------------------------------AuditTrial-------------------------------
			StringBuilder sbAuditTrial=new StringBuilder();
			String strstakeholder="";
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("insert")){
			strPromType=correctNull((String)hsh.get("hid_str_type"));
			String strProGua[]=strPromType.split("@");
			sbAuditTrial.append("~Type=");
			for(int j=0;j<strProGua.length;j++){
				
			 if(j!=(strProGua.length-1))
			{
				 strProlen1=strProlen1+(ApplicantParams.getApplicantParams("PROMOTORTYPE",correctNull(strProGua[j])))+", ";
			}
			else
			{
				strProlen1=strProlen1+(ApplicantParams.getApplicantParams("PROMOTORTYPE",correctNull(strProGua[j])))+" ";
			}
				
			 }
			Paramlen=strProlen1.length();
			if(Paramlen>0)
			{
				strProlen1=strProlen1.substring(0,Paramlen-1);							
			}
			sbAuditTrial.append(strProlen1);
			if(cho.equalsIgnoreCase(""))
			{
				cho=String.valueOf(intValue);	
			}
			if(!cho.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("selcreditreport2^"+appno+"^"+cho);
				rs1=DBUtils.executeQuery(strQuery);	
				if(rs1.next())
				{
					strMeans=correctNull(rs1.getString("CR_Total_MEANS"));
				}
			}
			if(rs1!=null)
			{
				rs1.close();
			}
			String strstake="";
			if(correctNull((String)hsh.get("selstake")).equalsIgnoreCase("Yes"))
			{
				strstake="Yes";
			}
			else if(correctNull((String)hsh.get("selstake")).equalsIgnoreCase("No"))
			{
				strstake="No";
			}
			sbAuditTrial.append("~First Name=").append(correctNull((String)hsh.get("fname"))).append(
			"~Middle Name=").append(correctNull((String)hsh.get("mname"))).append(
			"~Last Name=").append(correctNull((String)hsh.get("lname"))).append(
			"~Date of Birth=").append(correctNull((String)hsh.get("dob"))).append(
			"~Sex of Promoter/Directors/Partners=").append(correctNull((String)hsh.get("selemp"))).append(
			"~Academic Qualification=").append(correctNull((String)hsh.get("txt_academic"))).append(
			"~Designation=").append(correctNull((String)hsh.get("txt_desig"))).append(
			"~Experience of Promoters/Directors=").append(correctNull((String)hsh.get("txt_exp"))).append(
			"~Whether the promoter is major stake holder=").append(strstake).append(
			"~Address1=").append(correctNull((String)hsh.get("addr1"))).append(
			"~Address2=").append(correctNull((String)hsh.get("addr2"))).append(
			"~City=").append(correctNull((String)hsh.get("city"))).append(
			"~State=").append(correctNull((String)hsh.get("state"))).append(
			"~Pin Code=").append(correctNull((String)hsh.get("pin"))).append(
			"~Phone=").append(correctNull((String)hsh.get("phone"))).append(
			"~Fax=").append(correctNull((String)hsh.get("fax"))).append(
			"~Email=").append(correctNull((String)hsh.get("email"))).append(
			"~Means=").append(correctNull((String)hsh.get("txt_means"))).append(
			"~DIN=").append(correctNull((String)hsh.get("txt_din"))).append(
			"~Share(%)=").append(correctNull((String)hsh.get("share"))).append(
			"~Shares Held=").append(correctNull((String)hsh.get("held"))).append(
			"~Total Value of Shares=").append(correctNull((String)hsh.get("facevalue"))).append(
			"~Capital Contribution=").append(correctNull((String)hsh.get("txt_capital"))).append(
			"~As on Date=").append(correctNull((String)hsh.get("valdate")));
			}
			AuditTrial.auditNewLog(hsh,"143",appno,sbAuditTrial.toString(),sbolddata.toString());	
		}
		catch (Exception e)
		{
			throw new EJBException(e.getMessage());
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
				throw new EJBException("Error closing the connection "+cf);						
			}
		}
		return hshRecord;	
	}
	
	public HashMap getValues(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs=null;
		ResultSet rs1=null;
		//HashMap hshValues = new HashMap();
		String recordflag="N";
		String StrAppno="";
		String strFreeze="";
		int cho_promoter=0;
		String strFacilitySno="",strattachavail="N",cgtmseGrpMgmt="";
		int cgtmseGrpMgmtcnt=0;
		try
		{
			StrAppno=correctNull((String)hshValues.get("appno"));
			String strPromoter=correctNull((String)hshValues.get("cho_promoter"));
			strFacilitySno=Helper.correctInt((String)hshValues.get("sel_facility"));
			rs=DBUtils.executeLAPSQuery("selcapitalstructure^"+StrAppno);
			if(rs.next())
			{
				hshValues.put("comapp_totalshares",correctNull(rs.getString("com_paidshares")));
			}
			
			strQuery = SQLParser.getSqlQuery("selcorpatepromotershare^"+StrAppno);				
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshValues.put("totalsharevalue",correctNull(rs.getString("totalsharevalue")));
			}
			if (!strPromoter.trim().equals("") && !strPromoter.trim().equalsIgnoreCase("S"))
			{
				cho_promoter=Integer.parseInt((String)hshValues.get("cho_promoter"));
			}
			if(rs!=null) {rs.close();}
			if (cho_promoter>0)
			{
				strQuery = SQLParser.getSqlQuery("compromoterselection^"+StrAppno+"^"+cho_promoter+"^"+strFacilitySno);
				rs =DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{
					strattachavail="Y";
				    recordflag="Y";	
					hshValues.put("com_compdtappno",correctNull(rs.getString("com_compdtappno")));
					hshValues.put("com_compdtid",correctNull(rs.getString("com_compdtid")));
					hshValues.put("com_compdttype",correctNull(rs.getString("com_compdttype").trim()));
					hshValues.put("com_compdtfname",correctNull(rs.getString("com_compdtfname")));
					hshValues.put("com_compdtlname",correctNull(rs.getString("com_compdtlname")));
					hshValues.put("com_compdtmname",correctNull(rs.getString("com_compdtmname")));
					if (correctNull(rs.getString("com_compdtdob")).equals("01/01/1900"))
					{
						hshValues.put("com_compdtdob","");
					}
					else
					{
							hshValues.put("com_compdtdob",correctNull(rs.getString("com_compdtdob")));
					}
					hshValues.put("com_compdtaddress1",correctNull(rs.getString("com_compdtaddress1")));
					hshValues.put("com_compdtaddress2",correctNull(rs.getString("com_compdtaddress2")));
					hshValues.put("com_compdtcity",correctNull(rs.getString("com_compdtcity")));
					hshValues.put("com_compdtstate",correctNull(rs.getString("com_compdtstate")));
					hshValues.put("com_compdtpin",correctNull(rs.getString("com_compdtpin")));
					hshValues.put("com_compdtphone",correctNull(rs.getString("com_compdtphone")));
					hshValues.put("com_compdtfax",correctNull(rs.getString("com_compdtfax")));
					hshValues.put("com_compdtemail",correctNull(rs.getString("com_compdtemail")));
					hshValues.put("com_comdtpershare",correctNull(rs.getString("com_comdtpershare")));
					hshValues.put("com_compdtshareheld",correctNull(rs.getString("com_compdtshareheld")));
					hshValues.put("com_compdtnetworth",correctNull(rs.getString("com_compdtnetworth")));
					if (correctNull(rs.getString("com_compdate")).equals("01/01/1900"))
					{
						hshValues.put("com_compdate","");
					}
					else
					{
							hshValues.put("com_compdate",correctNull(rs.getString("com_compdate")));
					}	
					
					hshValues.put("capcontribution",correctNull(rs.getString("capcontribution")));
					hshValues.put("com_percent",correctNull(rs.getString("com_percent")));
					hshValues.put("COM_COMPDSEX",correctNull(rs.getString("COM_COMPDSEX")));
					hshValues.put("COM_COMPDACA",correctNull(rs.getString("COM_COMPDACA")));
					hshValues.put("COM_COMPDEXP",correctNull(rs.getString("COM_COMPDEXP")));
					hshValues.put("COM_COMPDSTKHOLDER",correctNull(rs.getString("COM_COMPDSTKHOLDER")));
					hshValues.put("com_background",correctNull(rs.getString("com_background")));
					hshValues.put("com_facevalue",correctNull(rs.getString("com_facevalue")));
					hshValues.put("com_compdtdesignation",correctNull(rs.getString("com_compdtdesignation")));
					hshValues.put("COM_COMPDTDIN",correctNull(rs.getString("COM_COMPDTDIN")));
					hshValues.put("com_compdtappid",Helper.correctNull((String)rs.getString("com_compdtappid")));
					hshValues.put("com_oldlapsid",Helper.correctNull((String)rs.getString("com_oldlapsid")));
					
					hshValues.put("txt_relationship",Helper.correctNull((String)rs.getString("com_comprelationship")));
					hshValues.put("txt_ratinggrade1",Helper.correctNull((String)rs.getString("com_compratinggrade1")));
					hshValues.put("txt_ratingdate1",Helper.correctNull((String)rs.getString("com_compratingason1")));
					hshValues.put("rating_type1",Helper.correctNull((String)rs.getString("com_compratingtype1")));
					hshValues.put("txt_ratinggrade2",Helper.correctNull((String)rs.getString("com_compratinggrade2")));
					hshValues.put("txt_ratingdate2",Helper.correctNull((String)rs.getString("com_compratingason2")));
					hshValues.put("rating_type2",Helper.correctNull((String)rs.getString("com_compratingtype2")));
					hshValues.put("com_relthemselves",Helper.correctNull((String)rs.getString("com_compborrname")));
					hshValues.put("cbs_borr_relation",Helper.correctNull((String)rs.getString("COM_CBSRELATIONTYPE")));
					
					
					if(correctNull((String)hshValues.get("hidCategoryType")).equalsIgnoreCase("STL")
							|| correctNull((String)hshValues.get("hidCategoryType")).equalsIgnoreCase("ADC")
							|| correctNull((String)hshValues.get("hidCategoryType")).equalsIgnoreCase("SRE"))
					{
						String company_id = correctNull((String)rs.getString("com_compdtid"));
						if (rs1 != null)
						{
							rs1.close();
						}
						strQuery = SQLParser.getSqlQuery("selcreditreport2^" + StrAppno + "^" + company_id);
						rs1 = DBUtils.executeQuery(strQuery);
						if (rs1.next())
						{
							hshValues.put("means",correctNull(rs1.getString("CR_Total_MEANS")));
						}
						else 
						{
							hshValues.put("means","0.00");
						}
					}
					if(rs1!=null)
						rs1.close();
				
					rs1 = DBUtils.executeLAPSQuery("creditreport_appidcheck^"+StrAppno+"^"+cho_promoter);
					if(rs1.next())
						hshValues.put("creditAppidCheck","Y");
					else
						hshValues.put("creditAppidCheck","N");
					
					if(rs1!=null)
						rs1.close();
					
					//Check Security attachment in post sanction
					strQuery=SQLParser.getSqlQuery("sel_guarantorsec^"+Helper.correctNull((String)rs.getString("com_oldlapsid"))+"^"+strFacilitySno+"^"+StrAppno);
					ResultSet rsSec=DBUtils.executeQuery(strQuery);
					if(rsSec.next())
					{
						if(Integer.parseInt(Helper.correctInt((String)rsSec.getString(1)))>0)
						{hshValues.put("Sec_available", "Y");}
						else{hshValues.put("Sec_available", "N");}
					}
					
				}
				 
				if(rs1!=null){rs1.close();}
				rs1 = DBUtils.executeLAPSQuery("select_perappoldid^"+cho_promoter);
				if(rs1.next())
				{
					hshValues.put("PromotorsCBSID",correctNull(rs1.getString("perapp_cbsid")));
				}
				
			}
			hshValues.put("strFacilitySno",strFacilitySno);
			strQuery = SQLParser.getSqlQuery("sel_applications_freeze_flag^"+StrAppno);
    		rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				strFreeze = Helper.correctNull((String)rs.getString("app_freeze_flag"));
			}
			hshValues.put("strFreeze",strFreeze);
			hshValues.put("recordflag",recordflag);
			hshValues.put("hidapplicantid",Helper.correctNull((String)hshValues.get("hidapplicantid")));
			hshValues.put("Prmotorsid",Integer.toString(cho_promoter));
			

			if(rs!=null) rs.close();
			int strFreezecount=0;
		   	String strFreezeflag="N";
		   	strQuery = SQLParser.getSqlQuery("sel_freezecount^" + StrAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{	
				strFreezecount=Integer.parseInt(Helper.correctInt(rs.getString("freezecount")));
				if(strFreezecount!=0 )
				{
					strFreezeflag="Y";
				}
			}
			hshValues.put("strSecFreezeflag",strFreezeflag);
			
			
			//To select the post sanction parameters
			String strTemp=" ",strParameters="";
			strTemp = " and PS_APP_SNO='"+strFacilitySno+"'";
			String strQueryPS = SQLParser.getSqlQuery("sel_PS_oldaccnum^"+StrAppno+"^"+strTemp);
			ResultSet rsPS = DBUtils.executeQuery(strQueryPS);
			while(rsPS.next())
			{
				strParameters=strParameters+Helper.correctNull(rsPS.getString("PS_MODIFY_TERMS"));
			}
			hshValues.put("strPostSancParam",strParameters);
			
			if(rs!=null)
				rs.close();
			
			String strInCompleteID="";
			strQuery = SQLParser.getSqlQuery("incomplete_perappid^"+StrAppno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(strInCompleteID.equalsIgnoreCase(""))
					strInCompleteID=Helper.correctNull(rs.getString("id"));
				else
					strInCompleteID+=","+Helper.correctNull(rs.getString("id"));
			}
			
			if(rs!=null)
				rs.close();
			
			strQuery = SQLParser.getSqlQuery("sel_promotorsids^"+StrAppno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(!strInCompleteID.contains(Helper.correctNull(rs.getString("id"))))
				{
					if(rs1!=null)
					{
						rs1.close();
					}
					if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
					{
						strQuery=SQLParser.getCBSSqlQuery("cbs_custdetails_select_newconnection^"+Helper.correctNull(rs.getString("id")));
						rs1=DBUtils.executeQueryCBSConnection(strQuery);
					}
					else
					{
						strQuery= SQLParser.getSqlQuery("cbs_custdetails_select^"+Helper.correctNull(rs.getString("id")));
						rs1=DBUtils.executeQuery(strQuery); 
					}
					if(!rs1.next())
					{
						if(strInCompleteID.equalsIgnoreCase(""))
							strInCompleteID=Helper.correctNull(rs.getString("id"));
						else
							strInCompleteID+=","+Helper.correctNull(rs.getString("id"));
					}
				}
			}
			hshValues.put("strInCompleteID",strInCompleteID);
			
			if(rs!=null){rs.close();}
			rs = DBUtils.executeLAPSQuery("sel_facility_details^"+StrAppno+"^"+strFacilitySno);
			if(rs.next())
			{
				hshValues.put("FACILITY_WHT_CGTMSEAPPLY",correctNull(rs.getString("FACILITY_WHT_CGTMSEAPPLY")));
				hshValues.put("facility_group",correctNull(rs.getString("facility_group")));
				hshValues.put("facility_category",correctNull(rs.getString("facility_category")));
			}
			
//			int a=0;
//			if(rs!=null)
//                rs.close();
//				rs=DBUtils.executeLAPSQuery("incomplete_perappid^"+StrAppno);
// 			while(rs.next())
// 			{
// 		 		a++;
// 			}
// 			if(a>0){
// 				hshValues.put("strGuarantor_corp","N");
// 				}
// 			else{
// 				hshValues.put("strGuarantor_corp","Y");
// 				}

			ArrayList arrCol = new ArrayList();
			ArrayList arrRow = new ArrayList();
			ArrayList arrCol1 = new ArrayList();
			ArrayList arrCol2 = new ArrayList();
			ArrayList arrRow1= new ArrayList();
			String strQuery1 = "";
			int strAppHuntScore=0;
			int intHuntScore = 0;
			int intHuntScore1 = 0;
			String strAppHuntStatus="";
			strQuery1 = SQLParser.getSqlQuery("sel_hunterscore");
			rs = DBUtils.executeQuery(strQuery1);

			if (rs.next()) {
				intHuntScore = Integer.parseInt(Helper.correctInt((String) rs
						.getString("LOAN_PARAMVAL")));
			}
			
			strQuery1 = SQLParser.getSqlQuery("sel_appdetails_hunterscore^" + StrAppno);
			rs = DBUtils.executeQuery(strQuery1);
			if (rs.next()) {
				arrCol.add(Helper.correctNull((String) rs
						.getString("DEMO_COMAPPID")));
				arrCol.add(Helper.correctInt((String) rs
						.getString("DEF_HUNTER_SCORE")));
				arrCol.add(Helper.correctNull((String) rs
						.getString("PERAPP_FNAME")));
				strAppHuntScore=Integer.parseInt(Helper.correctInt((String) rs
						.getString("DEF_HUNTER_SCORE")));
				arrRow.add(arrCol);
			}
		
			if (rs != null) {
				rs.close();
			}
		
			ArrayList HSCorelist = new ArrayList();
			
			if(strAppHuntScore<intHuntScore)
			{
				strAppHuntStatus="Y";
				
			}
			else
			{
				strAppHuntStatus="N";
			}
			for (int i = 0; i < arrRow.size(); i++) {

				arrCol1 = (ArrayList) arrRow.get(i);
				if(strAppHuntScore<intHuntScore)
				{
				arrCol2 = new ArrayList();
				arrCol2.add(arrCol1.get(0));
				arrCol2.add(arrCol1.get(2));
				HSCorelist.add(arrCol2);
				}
			}
			
			// boolean flag=false;
			strQuery1 = SQLParser.getSqlQuery("sel_coappdetails^" + StrAppno);
			rs = DBUtils.executeQuery(strQuery1);
             int intcopHunterscore=0;
			while (rs.next()) {
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull((String) rs
						.getString("COM_COMPDTID")));
				arrCol.add(Helper.correctInt((String) rs
						.getString("DEF_HUNTER_SCORE")));

				arrCol.add(Helper.correctNull((String) rs
						.getString("PERAPP_FNAME")));
				intcopHunterscore=Integer.parseInt(Helper.correctInt((String) rs
						.getString("DEF_HUNTER_SCORE")));
				arrRow1.add(arrCol);
			}
			
			
			ArrayList HSCorelist1=new ArrayList();
			String strcophunterStatus="";
			
			for (int i = 0; i < arrRow1.size(); i++) {
				ArrayList	arrCol11 = (ArrayList) arrRow1.get(i);
				if(Integer.parseInt((String)arrCol11.get(1))<intHuntScore){
				ArrayList	arrCol12 = new ArrayList();
				arrCol12.add(arrCol11.get(0));
				arrCol12.add(arrCol11.get(2));
				HSCorelist1.add(arrCol12);
				}
			}
			hshValues.put("HSCorelist", HSCorelist);//applicant less score
			hshValues.put("HSCorelist1", HSCorelist1);//coapplicant less score

			hshValues.put("dblHuntScore", String.valueOf(intHuntScore));//min hunt score
			
			if (rs != null)
				rs.close();
			strQuery1=SQLParser.getSqlQuery("sel_corpropcheck^"+StrAppno);
			rs = DBUtils.executeQuery(strQuery1);
			if(rs.next())
			{
				hshValues.put("APP_PERM_NO",Helper.correctNull(rs.getString("APP_PERM_NO")));
			}
			if(rs!=null){
				rs.close();
			}
			String strQuery8=null;
			ResultSet  rs4=null;
			   ArrayList arrCol4 = new ArrayList();
			strQuery1=SQLParser.getSqlQuery("sel_permissionmaster");
			rs = DBUtils.executeQuery(strQuery1);
			while(rs.next()){
				strQuery8=SQLParser.getSqlQuery("sel_huntercheck^"+StrAppno+"^"+Helper.correctInt((String) rs.getString("PER_ID")));
				rs4 = DBUtils.executeQuery(strQuery8);
				while(rs4.next())
				{
					
					
					   arrCol4.add(correctNull(rs.getString(1)));
					   arrCol4.add(correctNull(rs.getString(2)));
				}
			 
			}
			hshValues.put("arrCol4", arrCol4);
			
			
			hshValues.put("strAppHuntStatus", strAppHuntStatus);//applicant status
			//hshValues.put("strcophunterStatus", strcophunterStatus);//

			hshValues.put("strAppHuntScore", String.valueOf(strAppHuntScore));// applicant hunt score
			
			StringBuffer strFac=new StringBuffer();
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("sel_facadditionaldetails^"+StrAppno);
			while(rs.next()){
				boolean bflag=true;
				
				if(rs4!=null)
					rs4.close();
				rs4=DBUtils.executeLAPSQuery("sel_doc_FacRejCheck^"+Helper.correctNull(rs.getString("FAC_ADDAPPNO"))+"^"+Helper.correctNull(rs.getString("FAC_ADDAPPSNO")));
				if(rs4.next())
				{
					if(Helper.correctNull(rs.getString("fac_factype")).equalsIgnoreCase("D") && Double.parseDouble(Helper.correctDouble(rs.getString("FACILITY_PROPOSED")))>Double.parseDouble(Helper.correctDouble(rs4.getString("FACILITY_PROPOSED"))))
					{
						if(bflag)
						strFac.append(Helper.correctNull(rs.getString("FAC_SNO"))).append(",");
						bflag=false;
					}
					if(!Helper.correctNull(rs.getString("duedate")).equalsIgnoreCase("")&&!Helper.correctNull(rs4.getString("duedate")).equalsIgnoreCase(""))
					{
					if(Integer.parseInt(Helper.correctInt(rs.getString("facility_months")))>Integer.parseInt(Helper.correctInt(rs4.getString("duemonths"))))
					{
						if(bflag)
						strFac.append(Helper.correctNull(rs.getString("FAC_SNO"))).append(",");
						bflag=false;
					}
					}
					if(!Helper.correctNull(rs.getString("duedate")).equalsIgnoreCase("")&&!Helper.correctNull(rs4.getString("duedate")).equalsIgnoreCase("")
							&&(Helper.dateDiff(Helper.correctNull(rs.getString("duedate")), Helper.correctNull(rs4.getString("duedate"))))<0)
					{
						if(bflag)
						strFac.append(Helper.correctNull(rs.getString("FAC_SNO"))).append(",");
						bflag=false;
					}
				}
				
			}
			if(!(strFac.toString()).equalsIgnoreCase(""))
				strFac.delete(strFac.length()-1, strFac.length());
			hshValues.put("strAdhocFacDetails",strFac.toString());
			
				strQuery = SQLParser.getSqlQuery("compromoterselectionpromoters_cgtmse^"+StrAppno);
				rs =DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					strattachavail="Y";
					String strcbsid="";
					strQuery=SQLParser.getSqlQuery("sel_perapp_memberslist^"+Helper.correctNull((String)rs.getString("com_compdtappid")));
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						strcbsid=Helper.correctNull(rs1.getString("PERAPP_CBSID"));
					}
					
					
					String strCGTMSE_CONCERNTYPE="",PERAPP_CONSTITUTION="";
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("selcustomerdetails^"+Helper.correctInt((String)hshValues.get("hidapplicantid")));
					if(rs1.next())
					{
						strCGTMSE_CONCERNTYPE=Helper.correctNull(rs1.getString("CBS_STATIC_CGTMSE_CONCERNTYPE"));
						PERAPP_CONSTITUTION=Helper.correctNull(rs1.getString("PERAPP_CONSTITUTION"));
					}
					
					String arrCGTMSE_CONCERNTYPE[]=null;
					String concernType="";
					if(!strCGTMSE_CONCERNTYPE.equals(""))
					{
						arrCGTMSE_CONCERNTYPE=strCGTMSE_CONCERNTYPE.split("@");
						
						for(int i=0;i<arrCGTMSE_CONCERNTYPE.length;i++)
						{
							concernType=concernType+",'"+arrCGTMSE_CONCERNTYPE[i]+"'";
							
						}
					}
					
					if(!concernType.equals(""))
						concernType=concernType.replaceFirst(",", "");
					else
						concernType="''";
					
					
					
					if(PERAPP_CONSTITUTION.equals("01"))
					{
						cgtmseGrpMgmt="Y";//group management people
						cgtmseGrpMgmtcnt++;
					}
					else
					{
						strQuery = SQLParser.getSqlQuery("sel_corp_grpmnmt^"+StrAppno+"^"+strcbsid+"^"+concernType);
						rs1 =DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							cgtmseGrpMgmt="Y";//group management people
						}
						else
						{
							cgtmseGrpMgmt="N";//not group management people
							cgtmseGrpMgmtcnt++;
						} 
					}
				}
				
				if(cgtmseGrpMgmtcnt>0)
				{
					cgtmseGrpMgmt="N";
				}
				else
				{
					cgtmseGrpMgmt="Y";
				}
			
			String strcgtmseavail="N";
			strQuery1=SQLParser.getSqlQuery("sel_facility_details_CGTMSE^"+StrAppno);
			rs = DBUtils.executeQuery(strQuery1);
			while(rs.next())
			{
				if(Helper.correctNull(rs.getString("FACILITY_WHT_CGTMSEAPPLY")).equalsIgnoreCase("Y"))
				{
					if((strattachavail.equalsIgnoreCase("Y") && cgtmseGrpMgmt.equals("N")))
					{
						strcgtmseavail="Y";
						break;
					}
				}
			}
			if(rs!=null)
				rs.close();
			hshValues.put("strcgtmseavail",strcgtmseavail);
			String strcgtmseavailmsg="";
			if(strcgtmseavail.equalsIgnoreCase("Y"))
			{
				String appId="";
				String strCGTMSE_CONCERNTYPE="",PERAPP_CONSTITUTION="";
				strQuery = SQLParser.getSqlQuery("compromoterselectionpromoters_cgtmse_new1^"+StrAppno);
				rs =DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					appId=Helper.correctNull(rs.getString("DEMO_COMAPPNEWID"));
					strCGTMSE_CONCERNTYPE=Helper.correctNull(rs.getString("CBS_STATIC_CGTMSE_CONCERNTYPE"));
				}
				String arrCGTMSE_CONCERNTYPE[]=null;
				String concernType="";
				if(!strCGTMSE_CONCERNTYPE.equals(""))
				{
					arrCGTMSE_CONCERNTYPE=strCGTMSE_CONCERNTYPE.split("@");
					
					for(int i=0;i<arrCGTMSE_CONCERNTYPE.length;i++)
					{
						concernType=concernType+",'"+arrCGTMSE_CONCERNTYPE[i]+"'";
						
					}
				}
				
				if(!concernType.equals(""))
					concernType=concernType.replaceFirst(",", "");
				else
					concernType="''";
				
				String strName="",strappId="",strFacId="",strDesc="";
				strQuery = SQLParser.getSqlQuery("compromoterselectionpromoters_cgtmse_new2^"+StrAppno+"^"+appId+"^"+concernType);
				rs1 =DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					//strcgtmseavailmsg=strcgtmseavailmsg.concat("\n");
					strName=Helper.correctNull(rs1.getString("PERAPP_FNAME"));
					strcgtmseavailmsg=strcgtmseavailmsg.concat("Customer Name:"+strName+"\t");
					strappId=Helper.correctNull(rs1.getString("PERAPP_CBSID"));
					strcgtmseavailmsg=strcgtmseavailmsg.concat("Customer id:"+strappId+"\t");
					strFacId=Helper.correctNull(rs1.getString("COM_FACILITY_SNO"));
					strcgtmseavailmsg=strcgtmseavailmsg.concat("Facility sl no:"+strFacId+"\t");
					strDesc=Helper.correctNull(rs1.getString("STAT_DATA_DESC1"));
					strcgtmseavailmsg=strcgtmseavailmsg.concat("Facility description:"+strDesc+"\t");
				}
				
			}
			hshValues.put("strcgtmseavailmsg",strcgtmseavailmsg);
			String strappidApplicant="";
			strQuery = SQLParser.getSqlQuery("sel_CoappCheckFor_CGTMSE_Corp^"+StrAppno);
    		rs4 = DBUtils.executeQuery(strQuery);
			if(rs4.next()) 
			{
				strappidApplicant=Helper.correctNull(rs4.getString("DEMO_COMAPPNEWID"));
			}
			String strappid="",strNOtRequiredAppid="",strNOtRequiredFlag="",strAPPNAMES="",strFacNo="";
			strQuery1=SQLParser.getSqlQuery("sel_CoappCheckFor_CGTMSE_CorpAPP^"+StrAppno);
			rs = DBUtils.executeQuery(strQuery1);
			while(rs.next())
			{
				strappid=Helper.correctNull(rs.getString("COM_COMPDTAPPID"));
				strAPPNAMES=Helper.correctNull(rs.getString("COM_COMPDTFNAME"));
				strFacNo=Helper.correctNull(rs.getString("FACILITY_SNO"));
				if(!strappid.equalsIgnoreCase(""))
				{	
					//strNOtRequiredAppid=strNOtRequiredAppid.concat("\n");
					strQuery = SQLParser.getSqlQuery("sel_CoappCheckForAPPIDS_CGTMSE^"+strappid+"^"+strappidApplicant);
		    		rs4 = DBUtils.executeQuery(strQuery);
					if(rs4.next()) 
					{
					}
					else
					{
						strNOtRequiredAppid=strNOtRequiredAppid.concat(strAPPNAMES).concat(" for Facility NO:"+strFacNo).concat(",");
						strNOtRequiredFlag="Y";
					}
				}
				
			}
			hshValues.put("strNOtRequiredAppid",strNOtRequiredAppid);
			hshValues.put("strNOtRequiredFlag",strNOtRequiredFlag);
			
			String strCoApp_Gua_cbs="",StrCoappGuaCbs1="";
			if(rs!=null)
			{ rs.close(); }
			strQuery = SQLParser.getSqlQuery("sel_coAppGua_cbs_Corp^"+StrAppno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strCoApp_Gua_cbs+=","+Helper.correctNull(rs.getString("COMAPP_CBSID"));
			}
			strCoApp_Gua_cbs=strCoApp_Gua_cbs.replaceFirst(",", "");
			
			if(rs!=null)
				{ rs.close(); }
			strQuery=SQLParser.getSqlQuery("sel_proposedLimit_facility^"+StrAppno);
			rs=DBUtils.executeQuery(strQuery);	
			while(rs.next())
			{
				hshValues.put("FACILITY_WHT_CGTMSEAPPLY",Helper.correctNull(rs.getString("FACILITY_WHT_CGTMSEAPPLY")));
				hshValues.put("facility_group",correctNull(rs.getString("facility_group")));
				String strFacSno=Helper.correctNull(rs.getString("facility_sno"));
				if(Helper.correctNull(rs.getString("FACILITY_WHT_CGTMSEAPPLY")).equalsIgnoreCase("Y"))
				{
					strQuery = SQLParser.getSqlQuery("sel_coAppGua_Corp_fac^"+strFacSno+"^"+StrAppno);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						if(!strCoApp_Gua_cbs.contains(Helper.correctNull(rs1.getString("PERAPP_CBSID"))))
						{
							System.out.println("==="+Helper.correctNull(rs1.getString("PERAPP_CBSID")));
							StrCoappGuaCbs1+=","+Helper.correctNull(rs1.getString("PERAPP_CBSID"))+"-"+correctNull(rs1.getString("appname"));
						}
					}
				}
			}
			hshValues.put("StrCoappGuaCbs", StrCoappGuaCbs1.replaceFirst(",", ""));
			
			
			//exposure limit check for PAN check Except Gold Loan, Deposit Loan, Agriculture, SHG/JLG Borrowers begin 
			//checking limit amount 
			String sessionModuleType = correctNull((String) hshValues.get("sessionModuleType"));
			 double dblchecklimit = 0.0;
			 double dblchecklimit3 = 0.0;
			 String strQuery11="";
			 String strQuery12="";
			 java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
				jtn.setMaximumFractionDigits(2);
				jtn.setMinimumFractionDigits(2);
				jtn.setGroupingUsed(false);
			 if (sessionModuleType.equalsIgnoreCase("AGR")) {
			 strQuery11 = SQLParser.getSqlQuery("sel_lapsapplicationparameters^133");
				rs = DBUtils.executeQuery(strQuery11);
				if (rs.next()) {
					dblchecklimit = Double.parseDouble((String) Helper.correctDouble(rs.getString("LOAN_PARAMVAL")));
				}
				
			 }
			 else if (sessionModuleType.equalsIgnoreCase("CORP")) {
				 strQuery11 = SQLParser.getSqlQuery("sel_lapsapplicationparameters^134");
					rs = DBUtils.executeQuery(strQuery11);
					if (rs.next()) {
						dblchecklimit = Double.parseDouble((String) Helper.correctDouble(rs.getString("LOAN_PARAMVAL")));
					}
				 }
			 else
			 {
				 strQuery11 = SQLParser.getSqlQuery("sel_lapsapplicationparameters^135");
					rs = DBUtils.executeQuery(strQuery11);
					if (rs.next()) {
						dblchecklimit = Double.parseDouble((String) Helper.correctDouble(rs.getString("LOAN_PARAMVAL")));
					}
			}
			//checking limit amount
			String strPanCheck="";
			String strPanCheckcount="";
			if (rs != null)
				rs.close();

			strQuery = SQLParser
					.getSqlQuery("sel_lapsapplicationparameters^132"); 
			rs = DBUtils.executeQuery(strQuery);		
			
			if (rs.next()) {
				strPanCheck = Helper.correctNull(rs.getString("LOAN_PARAMVAL"));
				hshValues.put("strPanCheck", strPanCheck);
			}
			double dblExplimit = 0.0;
			if (!sessionModuleType.equalsIgnoreCase("AGR")) {
				
				dblExplimit = getExposureTotalLimit(StrAppno, "R",sessionModuleType);

				hshValues.put("strdblExplimit", jtn.format(dblExplimit));
				//if (dblExplimit >= 50000)
				if (dblExplimit>= dblchecklimit)
					hshValues.put("strExplimitchk", "F");
				else
					hshValues.put("strExplimitchk", "S");			
				
			}
			double dblExplimitagr = 0.0;
			if (sessionModuleType.equalsIgnoreCase("AGR")) {
				String strmainactcheck="";
				String strQuery2="";
				if (rs1 != null)
					rs1.close();

				strQuery2 = SQLParser
						.getSqlQuery("getmis_appdetailsagr^"+StrAppno);
				rs1 = DBUtils.executeQuery(strQuery2);
				if (rs1.next()) {
					strmainactcheck = Helper.correctNull(rs1.getString("reccount"));					
					hshValues.put("strmainactcheck", strmainactcheck);
				}
				if(strmainactcheck.equals("0"))
				{
					//vindhya 08052023begin
					strQuery2 = SQLParser
							.getSqlQuery("getmis_appdetailsagrall^"+StrAppno);
					rs1 = DBUtils.executeQuery(strQuery2);
					if (rs1.next()) {
						strQuery12 = SQLParser.getSqlQuery("sel_lapsapplicationparameters^136");
						rs = DBUtils.executeQuery(strQuery12);
						if (rs.next()) {
							dblchecklimit = Double.parseDouble((String) Helper.correctDouble(rs.getString("LOAN_PARAMVAL")));
						}
					}
					else
					{	strQuery12 = SQLParser.getSqlQuery("sel_lapsapplicationparameters^133");
						rs = DBUtils.executeQuery(strQuery12);
						if (rs.next()) {
							dblchecklimit = Double.parseDouble((String) Helper.correctDouble(rs.getString("LOAN_PARAMVAL")));
						}
					}
					/*
					strQuery12 = SQLParser.getSqlQuery("sel_lapsapplicationparameters^136");
					rs = DBUtils.executeQuery(strQuery12);
					if (rs.next()) {
						dblchecklimit = Double.parseDouble((String) Helper.correctDouble(rs.getString("LOAN_PARAMVAL")));
					}*/
				}
				
				dblExplimitagr = getExposureTotalLimitagri(StrAppno, "R",strmainactcheck);

				hshValues.put("strdblExplimitagr", jtn.format(dblExplimitagr));
				if (dblExplimitagr >= dblchecklimit)
					hshValues.put("strExplimitagrchk", "F");
				else
					hshValues.put("strExplimitagrchk", "S");
			}
			hshValues.put("strChecklimit", jtn.format(dblchecklimit));
			if (rs != null)
				rs.close();
			int pancount=0;
			strQuery = SQLParser.getSqlQuery("sel_for_pandetails^" + StrAppno+ "^" + StrAppno+ "^" + StrAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				if ((correctNull(rs.getString("PERAPP_PANNO")).equalsIgnoreCase("") || correctNull(rs.getString("PERAPP_PANNO")).equalsIgnoreCase("NOPAN")))
						{
							pancount++;
						}
				if(pancount>0)
				{
					hshValues.put("Pancount", "N");
				}
				else
					hshValues.put("Pancount", "Y");
				
			}
			
			//exposure limit check for PAN check Except Gold Loan, Depoist Loan, Agriculture, SHG/JLG Borrowers end 
			
		}
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
			throw new EJBException("error occured in getValues"+e.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
			}
			catch (Exception e1)
			{
				log.error("error occured"+e1.toString());
			}
		}
		return hshValues;
	}



	public HashMap getProData(HashMap hsh) 
	{
		String strQuery="";
		ResultSet rs=null,rs1=null;
		ResultSet rs3=null;
		//String strQuery1="";
		String strPromoId="";
		HashMap hshValues = new HashMap();
		boolean recordflag=false;
		String strattachavail="N",cgtmseGrpMgmt="";
		//ArrayList arr = new ArrayList();
		//ArrayList arr1 = new ArrayList();
		//ArrayList arr3 = new ArrayList();
		//ArrayList arr4 = new ArrayList();
		int cgtmseGrpMgmtcnt=0;
		String StrAppno="";
		//String strExeappno="",strGroupcheck="",strcom_appid="";
		//HashMap hshQueryValues=new HashMap();
		//HashMap hshQuery=new HashMap();
		//ArrayList arrValues=new ArrayList();
		String strFacilitySno="";
		try
		{
			StrAppno=correctNull((String)hsh.get("appno"));
			strPromoId=correctNull((String)hsh.get("cho"));
			strFacilitySno=Helper.correctInt((String)hsh.get("sel_facility"));
			rs=DBUtils.executeLAPSQuery("selcapitalstructure^"+StrAppno);
			if(rs.next())
			{
				hshValues.put("comapp_totalshares",correctNull(rs.getString("com_paidshares")));
			}
			
			strQuery = SQLParser.getSqlQuery("selcorpatepromotershare^"+StrAppno);				
			rs = DBUtils.executeQuery(strQuery);
			//int Count=0;
			if (rs.next())
			{
				hshValues.put("totalsharevalue",correctNull(rs.getString("totalsharevalue")));
			}
			
			if(!strPromoId.equals(""))
			{
				strQuery=SQLParser.getSqlQuery("compromoterselection^"+StrAppno+"^"+strPromoId+"^"+strFacilitySno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshValues.put("com_compdtappno",correctNull(rs.getString("com_compdtappno")));
					hshValues.put("com_compdtid",correctNull(rs.getString("com_compdtid")));
					hshValues.put("com_compdttype",correctNull(rs.getString("com_compdttype").trim()));
					hshValues.put("com_compdtfname",correctNull(rs.getString("com_compdtfname")));
					hshValues.put("com_compdtlname",correctNull(rs.getString("com_compdtlname")));
					hshValues.put("com_compdtmname",correctNull(rs.getString("com_compdtmname")));
					hshValues.put("com_compdtdob",correctNull(rs.getString("com_compdtdob")));
					hshValues.put("com_compdtaddress1",correctNull(rs.getString("com_compdtaddress1")));
					hshValues.put("com_compdtaddress2",correctNull(rs.getString("com_compdtaddress2")));
					hshValues.put("com_compdtcity",correctNull(rs.getString("com_compdtcity")));
					hshValues.put("com_compdtstate",correctNull(rs.getString("com_compdtstate")));
					hshValues.put("com_compdtpin",correctNull(rs.getString("com_compdtpin")));
					hshValues.put("com_compdtphone",correctNull(rs.getString("com_compdtphone")));
					hshValues.put("com_compdtfax",correctNull(rs.getString("com_compdtfax")));
					hshValues.put("com_compdtemail",correctNull(rs.getString("com_compdtemail")));
					hshValues.put("com_comdtpershare",correctNull(rs.getString("com_comdtpershare")));
					hshValues.put("com_compdtshareheld",correctNull(rs.getString("com_compdtshareheld")));
					hshValues.put("com_compdtnetworth",correctNull(rs.getString("com_compdtnetworth")));
					hshValues.put("com_compdate",correctNull(rs.getString("com_compdate")));
					hshValues.put("capcontribution",correctNull(rs.getString("capcontribution")));
					hshValues.put("com_percent",correctNull(rs.getString("com_percent")));
					hshValues.put("COM_COMPDSEX",correctNull(rs.getString("COM_COMPDSEX")));
					hshValues.put("COM_COMPDACA",correctNull(rs.getString("COM_COMPDACA")));
					hshValues.put("COM_COMPDEXP",correctNull(rs.getString("COM_COMPDEXP")));
					hshValues.put("COM_COMPDSTKHOLDER",correctNull(rs.getString("COM_COMPDSTKHOLDER")));
					hshValues.put("com_background",correctNull(rs.getString("com_background")));
					hshValues.put("com_facevalue",correctNull(rs.getString("com_facevalue")));
					hshValues.put("com_compdtdesignation",correctNull(rs.getString("com_compdtdesignation")));
					hshValues.put("COM_COMPDTDIN",correctNull(rs.getString("COM_COMPDTDIN")));
					hshValues.put("com_compdtappid",Helper.correctNull((String)rs.getString("com_compdtappid")));
					hshValues.put("com_oldlapsid",Helper.correctNull((String)rs.getString("com_oldlapsid")));
					
					hshValues.put("txt_relationship",correctNull((String)rs.getString("com_comprelationship")));
					hshValues.put("txt_ratinggrade1",correctNull((String)rs.getString("com_compratinggrade1")));
					hshValues.put("txt_ratingdate1",correctNull((String)rs.getString("com_compratingason1")));
					hshValues.put("rating_type1",correctNull((String)rs.getString("com_compratingtype1")));
					hshValues.put("txt_ratinggrade2",correctNull((String)rs.getString("com_compratinggrade2")));
					hshValues.put("txt_ratingdate2",correctNull((String)rs.getString("com_compratingason2")));
					hshValues.put("rating_type2",correctNull((String)rs.getString("com_compratingtype2")));
					hshValues.put("com_relthemselves",Helper.correctNull((String)rs.getString("com_compborrname")));
					hshValues.put("cbs_borr_relation",Helper.correctNull((String)rs.getString("COM_CBSRELATIONTYPE")));
					
					if(correctNull((String)hsh.get("hidCategoryType")).equalsIgnoreCase("STL")
							|| correctNull((String)hsh.get("hidCategoryType")).equalsIgnoreCase("ADC")
							|| correctNull((String)hsh.get("hidCategoryType")).equalsIgnoreCase("SRE"))
					{
						String company_id = correctNull((String)rs.getString("com_compdtid"));
						if (rs != null)
						{
							rs.close();
						}
						strQuery = SQLParser.getSqlQuery("selcreditreport2^" + StrAppno + "^" + company_id);
						rs = DBUtils.executeQuery(strQuery);
						if (rs.next())
						{
							hshValues.put("means",correctNull(rs.getString("CR_Total_MEANS")));
						}
						else 
						{
							hshValues.put("means","0.00");
						}
					}
					
					recordflag=true;
					
					//Check Security attachment in post sanction
					strQuery=SQLParser.getSqlQuery("sel_guarantorsec^"+Helper.correctNull((String)rs.getString("com_oldlapsid"))+"^"+strFacilitySno+"^"+StrAppno);
					ResultSet rsSec=DBUtils.executeQuery(strQuery);
					if(rsSec.next())
					{
						if(Integer.parseInt(Helper.correctInt((String)rsSec.getString(1)))>0)
						{hshValues.put("Sec_available", "Y");}
						else{hshValues.put("Sec_available", "N");}
					}
				}
				if(rs1!=null){rs1.close();}
				rs1 = DBUtils.executeLAPSQuery("select_perappoldid^"+strPromoId);
				if(rs1.next())
				{
					hshValues.put("PromotorsCBSID",correctNull(rs1.getString("perapp_cbsid")));
				}
			}
			hshValues.put("strFacilitySno",strFacilitySno);
			hshValues.put("hidapplicantid",Helper.correctNull((String)hsh.get("hidapplicantid")));
			String strFreeze="";
	  		strQuery = SQLParser.getSqlQuery("sel_applications_freeze_flag^"+StrAppno);
    		rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				strFreeze = Helper.correctNull((String)rs.getString("app_freeze_flag"));
			}
			hshValues.put("strFreeze",strFreeze);
//			------------New Commerical To Fetch Details and insert into database for Group Company
//				namrata
				/*strQuery = SQLParser.getSqlQuery("selfacexeappno^"+appno);
				rs3 = DBUtils.executeQuery(strQuery);
				if(rs3.next())
				{
					strExeappno=correctNull((String)rs3.getString("exeappno"));
					strGroupcheck=correctNull((String)rs3.getString("grp_check"));
					
					if((!strExeappno.equalsIgnoreCase("")) && (!strGroupcheck.equalsIgnoreCase("")))
					{
					String strValue1=strExeappno;
					hshQueryValues.put("size","1");	
					hshQuery.put("strQueryId","updfgroupexecappno");
					arrValues.add(correctNull(strExeappno));
					arrValues.add("");
					arrValues.add(correctNull(appno));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					strQuery1 = SQLParser.getSqlQuery("compromotersel^"+strValue1);
					rs = DBUtils.executeQuery(strQuery1);
						while(rs.next())
						{
							String com_compdtid=correctNull(rs.getString("com_compdtid"));
							String com_compdtfname=correctNull(rs.getString("com_compdtfname"));
							String com_compdtlname=correctNull(rs.getString("com_compdtlname"));
							String com_compdtmname=correctNull(rs.getString("com_compdtmname"));
							String com_compdtdob=correctNull(rs.getString("com_compdtdob"));
							String com_compdtaddress1=correctNull(rs.getString("com_compdtaddress1"));
							String com_compdtaddress2=correctNull(rs.getString("com_compdtaddress2"));
							String com_compdtcity=correctNull(rs.getString("com_compdtcity"));
							String com_compdtstate=correctNull(rs.getString("com_compdtstate"));
							String com_compdtpin=correctNull(rs.getString("com_compdtpin"));
							String com_compdtphone=correctNull(rs.getString("com_compdtphone"));
							String com_compdtfax=correctNull(rs.getString("com_compdtfax"));
							String com_compdtemail=correctNull(rs.getString("com_compdtemail"));
							String com_comdtpershare=correctNull(rs.getString("com_comdtpershare"));
							String com_compdtshareheld=correctNull(rs.getString("com_compdtshareheld"));
							String com_compdtnetworth=correctNull(rs.getString("com_compdtnetworth"));
							String com_compdate=correctNull(rs.getString("com_compdate"));
							
							
						    hshQuery = new HashMap();
						    arrValues=new ArrayList();
						    hshQueryValues=new HashMap();
						    hshQueryValues.put("size","1");	
							hshQuery.put("strQueryId","compromoterins");
							arrValues.add(appno);
							arrValues.add(com_compdtid);
							arrValues.add(com_compdtfname);
							arrValues.add(com_compdtlname);
							arrValues.add(com_compdtmname);
							arrValues.add(com_compdtdob);
							arrValues.add(com_compdtaddress1);
							arrValues.add(com_compdtaddress2);
							arrValues.add(com_compdtcity);
							arrValues.add(com_compdtstate);
							arrValues.add(com_compdtpin);
							arrValues.add(com_compdtphone);
							arrValues.add(com_compdtfax);
							arrValues.add(com_compdtemail);
							arrValues.add(com_comdtpershare);
							arrValues.add(com_compdtshareheld);
							arrValues.add(com_compdtnetworth);
							arrValues.add(com_compdate);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}	
					}	
				}	
				//namrata
				strQuery = SQLParser.getSqlQuery("compromotertagsel^"+appno);
				rs =DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
						arr.add(correctNull(rs.getString("com_compdtappno")));
						arr1.add(correctNull(rs.getString("com_compdtid")));
						arr3.add(correctNull(rs.getString("com_compdtfname")));
						arr4.add(correctNull(rs.getString("com_compdtlname")));
								
				}

				hshValues.put("arr",arr);
				hshValues.put("arr1",arr1);
				hshValues.put("arr3",arr3);
				hshValues.put("arr4",arr4);*/
			 if(recordflag)
				 hshValues.put("recordflag","Y");
				else
					hshValues.put("recordflag","N");
			 
			 hshValues.put("Prmotorsid",strPromoId);
			 hshValues.put("appno",StrAppno);
			 
			 if(rs!=null) rs.close();
				int strFreezecount=0;
			   	String strFreezeflag="N";
			   	strQuery = SQLParser.getSqlQuery("sel_freezecount^" + StrAppno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{	
					strFreezecount=Integer.parseInt(Helper.correctInt(rs.getString("freezecount")));
					if(strFreezecount!=0 )
					{
						strFreezeflag="Y";
					}
				}
				hshValues.put("strSecFreezeflag",strFreezeflag);
				
				//To select the post sanction parameters
				String strTemp=" ",strParameters="";
				
				strTemp = " and PS_APP_SNO='"+strFacilitySno+"'";
				String strQueryPS = SQLParser.getSqlQuery("sel_PS_oldaccnum^"+StrAppno+"^"+strTemp);
				ResultSet rsPS = DBUtils.executeQuery(strQueryPS);
				while(rsPS.next())
				{
					strParameters=strParameters+Helper.correctNull(rsPS.getString("PS_MODIFY_TERMS"));
				}
				hshValues.put("strPostSancParam",strParameters);
				
				if(rs!=null)
					rs.close();
				
				String strInCompleteID="";
				strQuery = SQLParser.getSqlQuery("incomplete_perappid^"+StrAppno);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					if(strInCompleteID.equalsIgnoreCase(""))
						strInCompleteID=Helper.correctNull(rs.getString("id"));
					else
						strInCompleteID+=","+Helper.correctNull(rs.getString("id"));
				}
				if(rs!=null)
					rs.close();
				
				strQuery = SQLParser.getSqlQuery("sel_promotorsids^"+StrAppno);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					if(!strInCompleteID.contains(Helper.correctNull(rs.getString("id"))))
					{
						if(rs1!=null)
						{
							rs1.close();
						}
						if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
						{
							strQuery=SQLParser.getCBSSqlQuery("cbs_custdetails_select_newconnection^"+Helper.correctNull(rs.getString("id")));
							rs1=DBUtils.executeQueryCBSConnection(strQuery);
						}
						else
						{
							strQuery= SQLParser.getSqlQuery("cbs_custdetails_select^"+Helper.correctNull(rs.getString("id")));
							rs1=DBUtils.executeQuery(strQuery); 
						}
						if(!rs1.next())
						{
							if(strInCompleteID.equalsIgnoreCase(""))
								strInCompleteID=Helper.correctNull(rs.getString("id"));
							else
								strInCompleteID+=","+Helper.correctNull(rs.getString("id"));
						}
					}
				}
				hshValues.put("strInCompleteID",strInCompleteID);
				
				if(rs!=null){rs.close();}
				rs = DBUtils.executeLAPSQuery("sel_facility_details^"+StrAppno+"^"+strFacilitySno);
				if(rs.next())
				{
					hshValues.put("FACILITY_WHT_CGTMSEAPPLY",correctNull(rs.getString("FACILITY_WHT_CGTMSEAPPLY")));
					hshValues.put("facility_group",correctNull(rs.getString("facility_group")));
					hshValues.put("facility_category",correctNull(rs.getString("facility_category")));
				}
				

				ArrayList arrCol = new ArrayList();
				ArrayList arrRow = new ArrayList();
				ArrayList arrCol1 = new ArrayList();
				ArrayList arrCol2 = new ArrayList();
				ArrayList arrRow1= new ArrayList();
				String strQuery1 = "";
				int strAppHuntScore=0;
				int intHuntScore = 0;
				int intHuntScore1 = 0;
				String strAppHuntStatus="";
				strQuery1 = SQLParser.getSqlQuery("sel_hunterscore");
				rs = DBUtils.executeQuery(strQuery1);

				if (rs.next()) {
					intHuntScore = Integer.parseInt(Helper.correctInt((String) rs
							.getString("LOAN_PARAMVAL")));
				}
				
				strQuery1 = SQLParser.getSqlQuery("sel_appdetails_hunterscore^" + StrAppno);
				rs = DBUtils.executeQuery(strQuery1);
				if (rs.next()) {
					arrCol.add(Helper.correctNull((String) rs
							.getString("DEMO_COMAPPID")));
					arrCol.add(Helper.correctInt((String) rs
							.getString("DEF_HUNTER_SCORE")));
					arrCol.add(Helper.correctNull((String) rs
							.getString("PERAPP_FNAME")));
					strAppHuntScore=Integer.parseInt(Helper.correctInt((String) rs
							.getString("DEF_HUNTER_SCORE")));
					arrRow.add(arrCol);
				}
				if(rs!=null){
					rs.close();
				}
				strQuery1 = SQLParser.getSqlQuery("sel_coappdetails^" + StrAppno);
				rs = DBUtils.executeQuery(strQuery1);
	             int intcopHunterscore=0;
				while (rs.next()) {
					arrCol = new ArrayList();
					arrCol.add(Helper.correctNull((String) rs
							.getString("COM_COMPDTID")));
					arrCol.add(Helper.correctInt((String) rs
							.getString("DEF_HUNTER_SCORE")));

					arrCol.add(Helper.correctNull((String) rs
							.getString("PERAPP_FNAME")));
					intcopHunterscore=Integer.parseInt(Helper.correctInt((String) rs
							.getString("DEF_HUNTER_SCORE")));
					arrRow1.add(arrCol);
				}
				if (rs != null) {
					rs.close();
				}
			
				ArrayList HSCorelist = new ArrayList();
				
				if(strAppHuntScore<intHuntScore)
				{
					strAppHuntStatus="Y";
					
				}
				else
				{
					strAppHuntStatus="N";
				}
				for (int i = 0; i < arrRow.size(); i++) {

					arrCol1 = (ArrayList) arrRow.get(i);
					if(strAppHuntScore<intHuntScore)
					{
					arrCol2 = new ArrayList();
					arrCol2.add(arrCol1.get(0));
					arrCol2.add(arrCol1.get(2));
					HSCorelist.add(arrCol2);
					}
				}
				
				// co applicant huntscore checking 
				
				
				
				ArrayList HSCorelist1=new ArrayList();
				String strcophunterStatus="";
				
				for (int i = 0; i < arrRow1.size(); i++) {
					ArrayList	arrCol11 = (ArrayList) arrRow1.get(i);
					if(Integer.parseInt((String)arrCol11.get(1))<intHuntScore){
					ArrayList	arrCol12 = new ArrayList();
					arrCol12.add(arrCol11.get(0));
					arrCol12.add(arrCol11.get(2));
					HSCorelist1.add(arrCol12);
					}
				}
				hshValues.put("HSCorelist", HSCorelist);//applicant less score
				hshValues.put("HSCorelist1", HSCorelist1);//coapplicant less score

				hshValues.put("dblHuntScore", String.valueOf(intHuntScore));//min hunt score
				
				if (rs != null)
					rs.close();
				strQuery1=SQLParser.getSqlQuery("sel_corpropcheck^"+StrAppno);
				rs = DBUtils.executeQuery(strQuery1);
				if(rs.next())
				{
					hshValues.put("APP_PERM_NO",Helper.correctNull(rs.getString("APP_PERM_NO")));
				}
				if(rs!=null){
					rs.close();
				}
				/*strQuery1=SQLParser.getSqlQuery("sel_huntercheck^"+StrAppno);
				rs = DBUtils.executeQuery(strQuery1);
				if(rs.next())
				{
					hshValues.put("DEV_DEVPARAM",Helper.correctNull(rs.getString("DEV_DEVPARAM")));
				}*/
				String strQuery8=null;
				ResultSet  rs4=null;
				   ArrayList arrCol4 = new ArrayList();
				strQuery1=SQLParser.getSqlQuery("sel_permissionmaster");
				rs = DBUtils.executeQuery(strQuery1);
				while(rs.next()){
					strQuery8=SQLParser.getSqlQuery("sel_huntercheck^"+StrAppno+"^"+Helper.correctInt((String) rs.getString("PER_ID")));
					rs4 = DBUtils.executeQuery(strQuery8);
					while(rs4.next())
					{
						
						
						   arrCol4.add(correctNull(rs.getString(1)));
						   arrCol4.add(correctNull(rs.getString(2)));
					}
				 
			}
				hshValues.put("arrCol4", arrCol4);
				
				hshValues.put("strAppHuntStatus", strAppHuntStatus);//applicant status

				hshValues.put("strAppHuntScore", String.valueOf(strAppHuntScore));// applicant hunt score
				
				StringBuffer strFac=new StringBuffer();
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeLAPSQuery("sel_facadditionaldetails^"+StrAppno);
				while(rs.next()){
					boolean bflag=true;
					if(rs4!=null)
						rs4.close();
					rs4=DBUtils.executeLAPSQuery("sel_doc_FacRejCheck^"+Helper.correctNull(rs.getString("FAC_ADDAPPNO"))+"^"+Helper.correctNull(rs.getString("FAC_ADDAPPSNO")));
					if(rs4.next())
					{
						if(Helper.correctNull(rs.getString("fac_factype")).equalsIgnoreCase("D") && Double.parseDouble(Helper.correctDouble(rs.getString("FACILITY_PROPOSED")))>Double.parseDouble(Helper.correctDouble(rs4.getString("FACILITY_PROPOSED"))))
						{
							if(bflag)
							strFac.append(Helper.correctNull(rs.getString("FAC_SNO"))).append(",");
							bflag=false;
						}
						if(!Helper.correctNull(rs.getString("duedate")).equalsIgnoreCase("")&&!Helper.correctNull(rs4.getString("duedate")).equalsIgnoreCase(""))
						{
						if(Integer.parseInt(Helper.correctInt(rs.getString("facility_months")))>Integer.parseInt(Helper.correctInt(rs4.getString("duemonths"))))
						{
							if(bflag)
							strFac.append(Helper.correctNull(rs.getString("FAC_SNO"))).append(",");
							bflag=false;
						}
						}
						if(!Helper.correctNull(rs.getString("duedate")).equalsIgnoreCase("")&&!Helper.correctNull(rs4.getString("duedate")).equalsIgnoreCase("")
								&&(Helper.dateDiff(Helper.correctNull(rs.getString("duedate")), Helper.correctNull(rs4.getString("duedate"))))<0)
						{
							if(bflag)
							strFac.append(Helper.correctNull(rs.getString("FAC_SNO"))).append(",");
							bflag=false;
						}
					}
					
				}
				
				if(!(strFac.toString()).equalsIgnoreCase(""))
					strFac.delete(strFac.length()-1, strFac.length());
				
				hshValues.put("strAdhocFacDetails",strFac.toString());
				
				strQuery = SQLParser.getSqlQuery("compromoterselectionpromoters_cgtmse^"+StrAppno);
				rs =DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					strattachavail="Y";
					String strcbsid="";
					strQuery=SQLParser.getSqlQuery("sel_perapp_memberslist^"+Helper.correctNull((String)rs.getString("com_compdtappid")));
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						strcbsid=Helper.correctNull(rs1.getString("PERAPP_CBSID"));
					}
					
					
					String strCGTMSE_CONCERNTYPE="",PERAPP_CONSTITUTION="";
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("selcustomerdetails^"+Helper.correctInt((String)hshValues.get("hidapplicantid")));
					if(rs1.next())
					{
						strCGTMSE_CONCERNTYPE=Helper.correctNull(rs1.getString("CBS_STATIC_CGTMSE_CONCERNTYPE"));
						PERAPP_CONSTITUTION=Helper.correctNull(rs1.getString("PERAPP_CONSTITUTION"));
					}
					
					String arrCGTMSE_CONCERNTYPE[]=null;
					String concernType="";
					if(!strCGTMSE_CONCERNTYPE.equals(""))
					{
						arrCGTMSE_CONCERNTYPE=strCGTMSE_CONCERNTYPE.split("@");
						
						for(int i=0;i<arrCGTMSE_CONCERNTYPE.length;i++)
						{
							concernType=concernType+",'"+arrCGTMSE_CONCERNTYPE[i]+"'";
							
						}
					}
					
					if(!concernType.equals(""))
						concernType=concernType.replaceFirst(",", "");
					else
						concernType="''";
					
					
					
					if(PERAPP_CONSTITUTION.equals("01"))
					{
						cgtmseGrpMgmt="Y";//group management people
						cgtmseGrpMgmtcnt++;
					}
					else
					{
						strQuery = SQLParser.getSqlQuery("sel_corp_grpmnmt^"+StrAppno+"^"+strcbsid+"^"+concernType);
						rs1 =DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							cgtmseGrpMgmt="Y";//group management people
						}
						else
						{
							cgtmseGrpMgmt="N";//not group management people
							cgtmseGrpMgmtcnt++;
						} 
					}
				}
				
				if(cgtmseGrpMgmtcnt>0)
				{
					cgtmseGrpMgmt="N";
				}
				else
				{
					cgtmseGrpMgmt="Y";
				}
			
			String strcgtmseavail="N";
			strQuery1=SQLParser.getSqlQuery("sel_facility_details_CGTMSE^"+StrAppno);
			rs = DBUtils.executeQuery(strQuery1);
			while(rs.next())
			{
				if(Helper.correctNull(rs.getString("FACILITY_WHT_CGTMSEAPPLY")).equalsIgnoreCase("Y"))
				{
					if((strattachavail.equalsIgnoreCase("Y") && cgtmseGrpMgmt.equals("N")))
					{
						strcgtmseavail="Y";
						break;
					}
				}
			}
			if(rs!=null)
				rs.close();
			hshValues.put("strcgtmseavail",strcgtmseavail);
			//vindhya
			//exposure limit check for PAN check Except Gold Loan, Deposit Loan, Agriculture, SHG/JLG Borrowers begin 
			//checking limit amount 
			String sessionModuleType = correctNull((String) hsh.get("sessionModuleType"));
			 double dblchecklimit = 0.0;
			 double dblchecklimit3 = 0.0;
			 String strQuery11="";
			 String strQuery12="";
			 java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
				jtn.setMaximumFractionDigits(2);
				jtn.setMinimumFractionDigits(2);
				jtn.setGroupingUsed(false);
			 if (sessionModuleType.equalsIgnoreCase("AGR")) {
			 strQuery11 = SQLParser.getSqlQuery("sel_lapsapplicationparameters^133");
				rs = DBUtils.executeQuery(strQuery11);
				if (rs.next()) {
					dblchecklimit = Double.parseDouble((String) Helper.correctDouble(rs.getString("LOAN_PARAMVAL")));
				}
				
			 }
			 else if (sessionModuleType.equalsIgnoreCase("CORP")) {
				 strQuery11 = SQLParser.getSqlQuery("sel_lapsapplicationparameters^134");
					rs = DBUtils.executeQuery(strQuery11);
					if (rs.next()) {
						dblchecklimit = Double.parseDouble((String) Helper.correctDouble(rs.getString("LOAN_PARAMVAL")));
					}
				 }
			 else
			 {
				 strQuery11 = SQLParser.getSqlQuery("sel_lapsapplicationparameters^135");
					rs = DBUtils.executeQuery(strQuery11);
					if (rs.next()) {
						dblchecklimit = Double.parseDouble((String) Helper.correctDouble(rs.getString("LOAN_PARAMVAL")));
					}
			}
			//checking limit amount
			String strPanCheck="";
			String strPanCheckcount="";
			if (rs != null)
				rs.close();

			strQuery = SQLParser
					.getSqlQuery("sel_lapsapplicationparameters^132"); 
			rs = DBUtils.executeQuery(strQuery);		
			
			if (rs.next()) {
				strPanCheck = Helper.correctNull(rs.getString("LOAN_PARAMVAL"));
				hshValues.put("strPanCheck", strPanCheck);
			}
			double dblExplimit = 0.0;
			if (!sessionModuleType.equalsIgnoreCase("AGR")) {
				
				dblExplimit = getExposureTotalLimit(StrAppno, "R",sessionModuleType);

				hshValues.put("strdblExplimit", jtn.format(dblExplimit));
				//if (dblExplimit >= 50000)
				if (dblExplimit>= dblchecklimit)
					hshValues.put("strExplimitchk", "F");
				else
					hshValues.put("strExplimitchk", "S");			
				
			}
			double dblExplimitagr = 0.0;
			if (sessionModuleType.equalsIgnoreCase("AGR")) {
				String strmainactcheck="";
				String strQuery2="";
				if (rs1 != null)
					rs1.close();

				strQuery2 = SQLParser
						.getSqlQuery("getmis_appdetailsagr^"+StrAppno);
				rs1 = DBUtils.executeQuery(strQuery2);
				if (rs1.next()) {
					strmainactcheck = Helper.correctNull(rs1.getString("reccount"));					
					hshValues.put("strmainactcheck", strmainactcheck);
				}
				if(strmainactcheck.equals("0"))
				{//vindhya 08052023begin
					strQuery2 = SQLParser
							.getSqlQuery("getmis_appdetailsagrall^"+StrAppno);
					rs1 = DBUtils.executeQuery(strQuery2);
					if (rs1.next()) {
						strQuery12 = SQLParser.getSqlQuery("sel_lapsapplicationparameters^136");
						rs = DBUtils.executeQuery(strQuery12);
						if (rs.next()) {
							dblchecklimit = Double.parseDouble((String) Helper.correctDouble(rs.getString("LOAN_PARAMVAL")));
						}
					}
					else
					{	strQuery12 = SQLParser.getSqlQuery("sel_lapsapplicationparameters^133");
						rs = DBUtils.executeQuery(strQuery12);
						if (rs.next()) {
							dblchecklimit = Double.parseDouble((String) Helper.correctDouble(rs.getString("LOAN_PARAMVAL")));
						}
					}
					//vindhya 08052023begin	
					/*strQuery12 = SQLParser.getSqlQuery("sel_lapsapplicationparameters^136");
					rs = DBUtils.executeQuery(strQuery12);
					if (rs.next()) {
						dblchecklimit = Double.parseDouble((String) Helper.correctDouble(rs.getString("LOAN_PARAMVAL")));
					}*/
				}
				
				dblExplimitagr = getExposureTotalLimitagri(StrAppno, "R",strmainactcheck);

				hshValues.put("strdblExplimitagr", jtn.format(dblExplimitagr));
				if (dblExplimitagr >= dblchecklimit)
					hshValues.put("strExplimitagrchk", "F");
				else
					hshValues.put("strExplimitagrchk", "S");
			}
			hshValues.put("strChecklimit", jtn.format(dblchecklimit));
			if (rs != null)
				rs.close();
			int pancount=0;
			strQuery = SQLParser.getSqlQuery("sel_for_pandetails^" + StrAppno+ "^" + StrAppno+ "^" + StrAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				if ((correctNull(rs.getString("PERAPP_PANNO")).equalsIgnoreCase("") || correctNull(rs.getString("PERAPP_PANNO")).equalsIgnoreCase("NOPAN")))
						{
							pancount++;
						}
				if(pancount>0)
				{
					hshValues.put("Pancount", "N");
				}
				else
					hshValues.put("Pancount", "Y");
				
			}
			
			//exposure limit check for PAN check Except Gold Loan, Depoist Loan, Agriculture, SHG/JLG Borrowers end 
			
				
		}
		catch (Exception e)
		{
			throw new EJBException("error occured in getProData"+e.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
				if(rs3!= null)
				{
					rs3.close();
				}
			}
			catch (Exception e1)
			{
				throw new EJBException("error occured in getProData"+e1.toString());
			}
		}
		return hshValues;
	}



public HashMap getActivity(HashMap hsh) 
	{
		String strQuery="";
		ResultSet rs=null;
		
		HashMap hshValues = new HashMap();
		ArrayList vecVal = new ArrayList();
		ArrayList vecVal1 = new ArrayList();
		ArrayList vecRec= new ArrayList();
		ArrayList vecRec1= new ArrayList();
		String appno="";
		
		boolean recordflag=false;
		
		try
			{
			
				appno=(String)hsh.get("appno");
				strQuery = SQLParser.getSqlQuery("comactsel^"+appno);

				rs =DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
						vecRec = new ArrayList();
						vecRec1 = new ArrayList();
						if (correctNull(rs.getString(3)).trim().equalsIgnoreCase("M"))
						{
						vecRec.add(correctNull(rs.getString(1)));
						vecRec.add(correctNull(rs.getString(2)));
						vecRec.add(correctNull(rs.getString(3)));
						vecRec.add(correctNull(rs.getString(4)));
						
						
						vecVal.add(vecRec);
						}
					
						else
						{
						vecRec1.add(correctNull(rs.getString(1)));
						vecRec1.add(correctNull(rs.getString(2)));
						vecRec1.add(correctNull(rs.getString(3)));
						vecRec1.add(correctNull(rs.getString(4)));
						
						
						vecVal1.add(vecRec1);
						}
						recordflag=true;
				}
				
				hshValues.put("vecVal",vecVal);
				hshValues.put("vecVal1",vecVal1);
				hshValues.put("comapp_id",correctNull((String)hsh.get("comapp_id")));
				hshValues.put("hidPageType",correctNull((String)hsh.get("hidPageType")));
				hshValues.put("hidCategoryType",correctNull((String)hsh.get("hidCategoryType")));
				hshValues.put("hidSSIType",correctNull((String)hsh.get("hidSSIType")));		
				if(recordflag)
					hshValues.put("recordflag","Y");
				else
					hshValues.put("recordflag","N");
				
			}
		
		catch (Exception e)
			{
			log.error("error occured"+e.toString());
			}

			finally
			{
				try
				{
					if(rs!= null)
					{
						rs.close();
					}
					
				}
				catch (Exception e1)
				{
					log.error("error occured"+e1.toString());
				}
			}
			return hshValues;
	}

public HashMap getCharges(HashMap hsh) 
	{
		
		String strQuery="";
		ResultSet rs=null;
		
		HashMap hshValues = new HashMap();
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec= new ArrayList();
		String appno="";
		try
			{
			
				appno=(String)hsh.get("appno");
				
				strQuery = SQLParser.getSqlQuery("comcharges3^"+appno);

				rs =DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
						vecRec = new ArrayList();
						
						vecRec.add(correctNull(rs.getString(1)));
						vecVal.add(vecRec);
					
				}
				hshValues.put("first",vecVal);
				vecVal = new ArrayList();
				strQuery = SQLParser.getSqlQuery("comcharges4^"+appno);
				
				if(rs!= null)
				{
					rs.close();
				}
				
				rs =DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
						vecRec = new ArrayList();
						
						vecRec.add(correctNull(rs.getString(1)));
						vecVal.add(vecRec);
					
				}

				hshValues.put("second",vecVal);

				
				vecVal = new ArrayList();
				strQuery = SQLParser.getSqlQuery("comchargessel^"+appno);

				if(rs!= null)
				{
					rs.close();
				}
				
				rs =DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					vecRec = new ArrayList();
						
						vecRec.add(correctNull(rs.getString(1)));
						vecRec.add(correctNull(rs.getString(2)));
						vecRec.add(correctNull(rs.getString(3)));
						vecRec.add(correctNull(rs.getString(4)));
						vecRec.add(correctNull(rs.getString(5)));
						vecVal.add(vecRec);
				}
				hshValues.put("third",vecVal);
				strQuery = SQLParser.getSqlQuery("comdetailssel^"+appno);

				if(rs!= null)
				{
					rs.close();
				}
				
				rs =DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					hshValues.put("Exclusive Charge",correctNull(rs.getString(3)));
				}

			hshValues.put("comapp_id",correctNull((String)hsh.get("comapp_id")));
			hshValues.put("hidPageType",correctNull((String)hsh.get("hidPageType")));
			hshValues.put("hidCategoryType",correctNull((String)hsh.get("hidCategoryType")));
			hshValues.put("hidSSIType",correctNull((String)hsh.get("hidSSIType")));
				
			}
		
		catch (Exception e)
			{
			log.error("error occured"+e.toString());
			}

			finally
			{
				try
				{
					if(rs!= null)
					{
						rs.close();
					}
					
				}
				catch (Exception e1)
				{
					log.error("error occured"+e1.toString());
				}
			}
			return hshValues;
	}



	public HashMap getGroup(HashMap hsh) 
	{
		String strQuery="";
		ResultSet rs=null;
		
		HashMap hshValues = new HashMap();
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec= new ArrayList();
		String appno="";
		try
			{
				appno=(String)hsh.get("appno");
				strQuery = SQLParser.getSqlQuery("comgroupsel^"+appno);
				rs =DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{
						vecRec = new ArrayList();
						
						vecRec.add(correctNull(rs.getString(1)));
						vecRec.add(correctNull(rs.getString(2)));
						vecRec.add(correctNull(rs.getString(3)));
						vecRec.add(correctNull(rs.getString(4)));
						vecRec.add(correctNull(rs.getString(5)));
						
						vecVal.add(vecRec);
				
				}

				hshValues.put("vecVal",vecVal);
				
			}
		
		catch (Exception e)
			{
			log.error("error occured"+e.toString());
			}

			finally
			{
				try
				{
					if(rs!= null)
					{
						rs.close();
					}
					
				}
				catch (Exception e1)
				{
					log.error("error occured"+e1.toString());
				}
			}
			return hshValues;
	}

	public HashMap getEquity(HashMap hsh) 
		{
			
			String strQuery="";
			ResultSet rs=null;
			
			HashMap hshValues = new HashMap();
			ArrayList vecVal = new ArrayList();
			ArrayList vecRec= new ArrayList();
			String appno="";
			boolean recordflag=false;
			try
				{
				
					appno=(String)hsh.get("appno");
					strQuery = SQLParser.getSqlQuery("comequisel^"+appno);

					rs =DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
							vecRec = new ArrayList();
							
						
							vecRec.add(correctNull(rs.getString(1)));
							vecRec.add(correctNull(rs.getString(2)));
							vecRec.add(correctNull(rs.getString(3)));
							vecRec.add(correctNull(rs.getString(4)));
							vecRec.add(correctNull(rs.getString(5)));
							vecRec.add(correctNull(rs.getString(6)));
							vecRec.add(correctNull(rs.getString(7)));
							vecRec.add(correctNull(rs.getString(8)));
							vecRec.add(correctNull(rs.getString(9)));
							
							vecVal.add(vecRec);
							recordflag=true;
					}

					hshValues.put("vecVal",vecVal);
					
				
				if(recordflag)
					hshValues.put("recordflag","Y");
				else
					hshValues.put("recordflag","N");
				
					
				}
			
			catch (Exception e)
				{
				log.error("error occured"+e.toString());
				}

				finally
				{
					try
					{
						if(rs!= null)
						{
							rs.close();
						}
						
					}
					catch (Exception e1)
					{
						log.error("error occured"+e1.toString());
					}
				}
				return hshValues;
		}

	public HashMap getLitigation(HashMap hsh) 
	{
		String strQuery="";
		ResultSet rs=null;
		
		HashMap hshValues = new HashMap();
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec= new ArrayList();
		String appno="";
		boolean recordflag=false;
		
		try
			{
			
				appno=(String)hsh.get("appno");
				strQuery = SQLParser.getSqlQuery("comlitsel^"+appno);

				rs =DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
						vecRec = new ArrayList();
						
						vecRec.add(correctNull(rs.getString(1)));
						vecRec.add(correctNull(rs.getString(2)));
						vecRec.add(correctNull(rs.getString(3)));
						vecRec.add(correctNull(rs.getString(4)));
						vecRec.add(correctNull(rs.getString(5)));
						vecRec.add(correctNull(rs.getString(6)));
						vecRec.add(correctNull(rs.getString(7)));
												
						vecVal.add(vecRec);
						recordflag=true;
				}
                
				hshValues.put("vecVal",vecVal);
				if(recordflag)
					hshValues.put("recordflag","Y");
				else
					hshValues.put("recordflag","N");
				
				
			}
		
		catch (Exception e)
			{
			log.error("error occured"+e.toString());
			}

			finally
			{
				try
				{
					if(rs!= null)
					{
						rs.close();
					}
			
				}
				catch (Exception e1)
				{
					log.error("error occured"+e1.toString());
				}
			}
			return hshValues;
	}

	/*public void updateActivity(HashMap hsh) 
	{
		
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQuery ;
		ArrayList arr = new ArrayList();
		ArrayList arrValues ;
		ResultSet rs=null;
		ResultSet rs1=null;
		String strQuery1="";
		int intUpdatesize_audit=0;
		String strActionData="";
		String val="",strQuery ="";
		int intValue = 0;
		int intVal = 0;
		String appno="";
		
		try
		{
								
				val=(String)hsh.get("hidAction");
				appno=(String)hsh.get("appno");
					
					String []manufacturing=null;
					
					String []mfgtype=null;

					String []trading=null;
					
					String []trdtype=null;
					
					// -------------------------- audit trial ---------------------------------------------------------//
				
				strQuery1 = SQLParser.getSqlQuery("comactsel^"+appno);
				if(rs1 != null)
				{
					rs1.close();
				}
				
				rs1 =DBUtils.executeQuery(strQuery1);
				while(rs1.next())
				{
						log.info("=========strQuery1=======");
							hshqueryval= new HashMap();
						
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize_audit=1;
						hshQuery.put("strQueryId","audittrial");
						arrValues.add("47");
						arrValues.add(correctNull((String)hsh.get("strUserId")));
						arrValues.add(correctNull((String)hsh.get("strClientIP")));
						arrValues.add(appno);
										
						
strActionData="Details of Manufacturing Activities ="+correctNull(rs1.getString(4))+"~Details of Trading Activities="+correctNull(rs1.getString(4))+"~Type="+correctNull(rs1.getString(3))+
						"~id="+correctNull(rs1.getString(2));
					arrValues.add(strActionData);
					if(val.equalsIgnoreCase("delete"))
					{
						arrValues.add("delete");
					}
					else
					{
						arrValues.add("insert");
					}
	
						hshQuery.put("arrValues",arrValues);
						
						hshqueryval.put("size",Integer.toString(intUpdatesize_audit));
						hshqueryval.put(Integer.toString(intUpdatesize_audit),hshQuery);	
						log.info("hshqueryval==select======="+hshqueryval);
						EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");	
						
				}

				hshqueryval=new HashMap();	
				
// -------------------------- audit trial ---------------------------------------------------------//

					int intUpdatesize=0;
					intUpdatesize=1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));

				hshquery.put("strQueryId","comactdel");
				arr.add(appno);
				hshquery.put("arrValues",arr);
				hshqueryval.put(Integer.toString(intUpdatesize),hshquery);

				
				


				if (val.equals("update"))
				{
					
			
			strQuery = SQLParser.getSqlQuery("comactmax1");
			if(rs != null)
			{
				rs.close();
			}
			//rs = stmt.executeQuery(strQuery);
			rs =DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				intValue = (rs.getInt(1));
				
			}
			
			
			
			strQuery = SQLParser.getSqlQuery("comactmax2");
			if(rs != null)
			{
				rs.close();
			}
		
			rs =DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				intVal = (rs.getInt(1));
				
			}
					manufacturing= (String [])hsh.get("manufacturing");
					mfgtype= (String [])hsh.get("mfgtype");
					
					trading = (String [])hsh.get("trading");
					trdtype= (String [])hsh.get("trdtype");
					

					hshQuery = new HashMap();
						arrValues=new ArrayList();
						int len=manufacturing.length;
						for(int k=0;k<len;k++)
							{				
								if(!manufacturing[k].equals(""))
									{
										hshQuery = new HashMap();
										arrValues=new ArrayList();
										intUpdatesize=intUpdatesize+1;
										hshQuery.put("strQueryId","comactins");
										arrValues.add(appno);
										intValue=intValue+1;
										String i=Integer.toString(intValue);
										arrValues.add(i);
										
										arrValues.add(correctNull(mfgtype[k]));
										arrValues.add(correctNull(manufacturing[k]));
										
										
										hshQuery.put("arrValues",arrValues);
										
										hshqueryval.put("size",Integer.toString(intUpdatesize));
										hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
									}
									if(!manufacturing[k].equals(""))
									{
											log.info("audit trail"+k);
										HashMap hshqueryval_audit= new HashMap();
									HashMap	hshQuery_audit = new HashMap();
									ArrayList	arrValues_audit=new ArrayList();
									
							
										intUpdatesize_audit=1;
											intValue=intValue+1;
										String i=Integer.toString(intValue);
										hshQuery_audit.put("strQueryId","audittrial");
										arrValues_audit.add("47");
										arrValues_audit.add(correctNull((String)hsh.get("strUserId")));
										arrValues_audit.add(correctNull((String)hsh.get("strClientIP")));
										arrValues_audit.add(appno);
										strActionData="id="+i+"~Type="+correctNull(mfgtype[k])+"~Details of Manufacturing Activities="+correctNull(manufacturing[k]);
										arrValues_audit.add(strActionData);
										if(val.equalsIgnoreCase("delete"))
										{
											arrValues_audit.add("delete");
										}
										else
										{
											arrValues_audit.add("insert");
										}
						
											hshQuery_audit.put("arrValues",arrValues_audit);
											
											hshqueryval_audit.put("size",Integer.toString(intUpdatesize_audit));
											hshqueryval_audit.put(Integer.toString(intUpdatesize_audit),hshQuery_audit);	
										log.info("hshqueryval_audit===="+hshqueryval_audit);	EJBInvoker.executeStateLess("dataaccess",hshqueryval_audit,"updateData");	
									}
							}
							int len1=trading.length;
							for(int x=0;x<len1;x++)
							{				
								if(!trading[x].equals(""))
									{
										hshQuery = new HashMap();
										arrValues=new ArrayList();
										intUpdatesize=intUpdatesize+1;
										hshQuery.put("strQueryId","comactins");
										arrValues.add(appno);
										intVal=intVal+1;
										String i=Integer.toString(intVal);
										arrValues.add(i);
										arrValues.add(correctNull(trdtype[x]));
										arrValues.add(correctNull(trading[x]));
									
										hshQuery.put("arrValues",arrValues);
										
										hshqueryval.put("size",Integer.toString(intUpdatesize));
										hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
									}
									if(!trading[x].equals(""))
									{
											log.info("audit trail"+x);
										HashMap hshqueryval_audit= new HashMap();
									HashMap	hshQuery_audit = new HashMap();
									ArrayList	arrValues_audit=new ArrayList();
									
							
										intUpdatesize_audit=1;
											intVal=intVal+1;
										String i=Integer.toString(intValue);
										hshQuery_audit.put("strQueryId","audittrial");
										arrValues_audit.add("47");
										arrValues_audit.add(correctNull((String)hsh.get("strUserId")));
										arrValues_audit.add(correctNull((String)hsh.get("strClientIP")));
										arrValues_audit.add(appno);
										strActionData="id="+i+"~Type="+correctNull(trdtype[x])+"~Details of Manufacturing Activities="+correctNull(trading[x]);
										arrValues_audit.add(strActionData);
										if(val.equalsIgnoreCase("delete"))
										{
											arrValues_audit.add("delete");
										}
										else
										{
											arrValues_audit.add("insert");
										}
						
											hshQuery_audit.put("arrValues",arrValues_audit);
											
											hshqueryval_audit.put("size",Integer.toString(intUpdatesize_audit));
											hshqueryval_audit.put(Integer.toString(intUpdatesize_audit),hshQuery_audit);	
										log.info("hshqueryval_audit===="+hshqueryval_audit);	EJBInvoker.executeStateLess("dataaccess",hshqueryval_audit,"updateData");	
									}
							}
				
				
				}	
				
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			
		}
		catch (Exception e)
		{
			log.info("in bean"+e);
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
		
		
	}*/
	public void updateActivity(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQuery ;
		ArrayList arr = new ArrayList();
		ArrayList arrValues ;
		ResultSet rs=null;
		ResultSet rs1=null;
		String strQuery1="";
		int intUpdatesize_audit=0;
		String strActionData="";
		String val="",strQuery ="";
		int intValue;
		int intVal;
		String appno="";
		String manufacturing=Helper.correctNull((String)hsh.get("manufacturing"));
		String mfgtype=Helper.correctNull((String)hsh.get("mfgtype"));
		
		String trading =Helper.correctNull((String)hsh.get("trading"));
		String trdtype=Helper.correctNull((String)hsh.get("trdtype"));
		appno=Helper.correctNull((String)hsh.get("appno"));
		String hidAction=Helper.correctNull((String)hsh.get("hidAction"));
		int intUpdatesize;
		try
		{
			if(hidAction.equalsIgnoreCase("update"))
			{
				hshqueryval.put("size","1");
				hshquery.put("strQueryId","comactdel");
				arr.add(appno);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				
				
					if( !manufacturing.equals("") && !manufacturing.equals(null))
					{
						hshQuery 	=	new HashMap();
						arrValues	=	new ArrayList();
						hshqueryval	=	new HashMap();
						hshQuery.put("strQueryId","comactins");
						intUpdatesize=1;
						arrValues.add(appno);
						intValue=1;
						String i=Integer.toString(intValue);
						arrValues.add(i);
						arrValues.add(mfgtype);
						arrValues.add(manufacturing);
						hshQuery.put("arrValues",arrValues);
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
						EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
					}
							
					if(!trading.equals("")&& !trading.equals(null))
					{
						hshQuery 	= 	new HashMap();
						arrValues	=	new ArrayList();
						hshqueryval	=	new HashMap();
						intUpdatesize=1;
						hshQuery.put("strQueryId","comactins");
						arrValues.add(appno);
						intVal=2;
						String i=Integer.toString(intVal);
						arrValues.add(i);
						arrValues.add(trdtype);
						arrValues.add(trading);
						hshQuery.put("arrValues",arrValues);
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
						EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
					}
				
			}
			else if(hidAction.equalsIgnoreCase("delete"))
			{
				hshqueryval.put("size","1");
				hshquery.put("strQueryId","comactdel");
				arr.add(appno);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}finally
		{
			try
			{
				if(rs!=null)
					rs.close();
				if(rs1!=null)
					rs1.close();
			}catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in updateActivity "+ exp.toString()); 
			}
		}
	}

public void updateComments(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		
		HashMap hshQry = new HashMap();
	
		ArrayList arr = new ArrayList();
		ArrayList arrVal = new ArrayList();
	
		String val="";
		String appno="";
		
		try
		{
								
				val=(String)hsh.get("hidAction");
				appno=(String)hsh.get("appno");
					
							
				int intUpdatesize=0;
				intUpdatesize=1;
				
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshquery.put("strQueryId","comcommentdel");
				arr.add(appno);
				hshquery.put("arrValues",arr);
				hshqueryval.put(Integer.toString(intUpdatesize),hshquery);
				
				if (val.equals("update"))
				{
				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry.put("strQueryId","comcommentins");
				arrVal.add(appno);
				arrVal.add("Adverse Remarks");
				arrVal.add(hsh.get("adverse"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put(Integer.toString(intUpdatesize),hshQry);

				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","comcommentins");
				arrVal.add(appno);
				arrVal.add("Company Comments");
				arrVal.add(hsh.get("comments"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put(Integer.toString(intUpdatesize),hshQry);

				}	
				
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
		}
		
	
		
		finally
		{
			try
			{
				
				/*if(rs != null)
				{
					rs.close();
				}
				*/

			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
		
		
	}



public HashMap getComments(HashMap hsh) 
	{
		
		String strQuery="";
		ResultSet rs=null;
		
		HashMap hshValues = new HashMap();
				
		String appno="";
		try
			{
			
				appno=(String)hsh.get("appno");
				strQuery = SQLParser.getSqlQuery("comcommentsel^"+appno);

				rs =DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
												
						if(correctNull(rs.getString(2)).equalsIgnoreCase("Adverse Remarks"))
						{
							hshValues.put("Adverse Remarks",correctNull(rs.getString(3)).trim());
						}
						
						else
						{
							
							hshValues.put("Company Comments",correctNull(rs.getString(3)).trim());
						}
					
				}
				
			}
		
		catch (Exception e)
			{
			log.error("error occured"+e.toString());
			}

			finally
			{
				try
				{
					if(rs!= null)
					{
						rs.close();
					}
				
				}
				catch (Exception e1)
				{
					log.error("error occured"+e1.toString());
				}
			}
			return hshValues;
	}

	public void updateEquity(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQuery ;
		ArrayList arr = new ArrayList();
		ArrayList arrValues ;
		ResultSet rs=null;
		String val="",strQuery ="";
		int intValue = 0;
		String appno="";
		StringBuilder sbAt = new StringBuilder();
		try
		{
			val=correctNull((String)hsh.get("hidAction"));
			appno=correctNull((String)hsh.get("appno"));
					
			String []concern=null;
			String []nature = null;
			String []amount = null;
			String []remarks = null;
			String []type = null;
			String []marvalue = null;
			String []marketdate = null;
			
			concern= (String [])hsh.get("concern");
			nature= (String [])hsh.get("nature");
			amount = (String [])hsh.get("amount");
			remarks= (String [])hsh.get("remarks");
			type = (String [])hsh.get("type");
			marvalue = (String [])hsh.get("marketvalue");
			marketdate = (String [])hsh.get("mardate");

			int intUpdatesize=0;
			if (val.equals("update"))
			{
				intUpdatesize=1;
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshqueryval=new HashMap();
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshquery.put("strQueryId","comequidel");
				arr.add(appno);
				hshquery.put("arrValues",arr);
				hshqueryval.put(Integer.toString(intUpdatesize),hshquery);
				
				strQuery = SQLParser.getSqlQuery("comequimax^"+appno);
				rs =DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					intValue = (rs.getInt(1));
				}
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				int len=concern.length;
				for(int k=0;k<len;k++)
				{				
					if(!concern[k].equals(""))
					{
						//added by Ilakkiya to remove comma from amount fields
						if(amount[k]!="")
						{
							amount[k]=amount[k].replaceAll(",","");
						}
						if(marvalue[k]!="")
						{
							marvalue[k]=marvalue[k].replaceAll(",","");
						}
						//end
						
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","comequiins");
						arrValues.add(appno);
						intValue=intValue+1;
						String i=Integer.toString(intValue);
						arrValues.add(i);
						arrValues.add(correctNull(concern[k]));
						arrValues.add(correctNull(nature[k]));
						arrValues.add(Helper.correctDouble(amount[k]));
						arrValues.add(correctNull(remarks[k]));
						arrValues.add(correctNull(type[k]));
						arrValues.add(correctNull(marvalue[k]));
						arrValues.add(correctNull(marketdate[k]));
						hshQuery.put("arrValues",arrValues);
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
					}
				}
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			if(val.equals("delete"))
			{
				intUpdatesize=1;
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshqueryval=new HashMap();
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshquery.put("strQueryId","comequidel");
				arr.add(appno);
				hshquery.put("arrValues",arr);
				hshqueryval.put(Integer.toString(intUpdatesize),hshquery);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			//   audit trial  for equity 
			int len=concern.length;
			if(val.equals("update"))
			{
				for(int k=0;k<len;k++)
				{				
					if(!concern[k].equals(""))
					{
						//added by Ilakkiya to remove comma from amount fields
						if(amount[k]!="")
						{
							amount[k]=amount[k].replaceAll(",","");
						}
						if(marvalue[k]!="")
						{
							marvalue[k]=marvalue[k].replaceAll(",","");
						}
						//end
						if(k==0)
						{
							sbAt.append("Name of the Concern=").append(correctNull(concern[k]));
						}
						else
						{
							sbAt.append("~ Name of the Concern=").append(correctNull(concern[k]));
						}
						sbAt.append(" ~ Nature and details of transaction=").append(correctNull(nature[k]));
						sbAt.append(" ~ Amount invested=").append(Helper.correctDouble(amount[k]));
						sbAt.append(" ~ Market Value=").append(correctNull(marvalue[k]));
						sbAt.append(" ~ Date =").append(correctNull(marketdate[k]));
						sbAt.append(" ~ Remarks=").append(correctNull(remarks[k]));
						sbAt.append(" </b>");
					}
				}
			}
			if(correctNull((String)hsh.get("hidRecordflag")).equals("Y"))
				hsh.put("hidAction", "update");
			else if(correctNull((String)hsh.get("hidRecordflag")).equals("N"))
				hsh.put("hidAction", "insert");
			
			AuditTrial.auditLog(hsh,"156",appno,sbAt.toString());			
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
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
	}
public void updateLitigation(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQuery ;
		
		ArrayList arr = new ArrayList();
		ArrayList arrValues ;
		ResultSet rs=null;
		String val="",strQuery ="";
		int intValue = 0;
		String appno="";
		StringBuilder sbAt = new StringBuilder();
		try
		{
			val=correctNull((String)hsh.get("hidAction"));
			appno=correctNull((String)hsh.get("appno"));
				
			String []bank=null;
			String []reasons = null;
			String []amount = null;
			String []remarks = null;
			String []type = null;
			
			bank= (String [])hsh.get("bank");
			reasons= (String [])hsh.get("reasons");
			amount = (String [])hsh.get("amount");
			remarks= (String [])hsh.get("remarks");
			type = (String [])hsh.get("type");

			int intUpdatesize=0;
			
			if (val.equals("update"))
			{
				intUpdatesize=1;
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshqueryval=new HashMap();
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshquery.put("strQueryId","comlitdel");
				arr.add(appno);
				hshquery.put("arrValues",arr);
				hshqueryval.put(Integer.toString(intUpdatesize),hshquery);
	
				strQuery = SQLParser.getSqlQuery("comlitmax^"+appno);
				rs =DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					intValue = (rs.getInt(1));
				}
			
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				int len=bank.length;
				for(int k=0;k<len;k++)
				{				
					if(!bank[k].equals(""))
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","comlitins");
						arrValues.add(appno);
						intValue=intValue+1;
						String i=Integer.toString(intValue);
						arrValues.add(i);
						arrValues.add(correctNull(bank[k]));
						arrValues.add(correctNull(reasons[k]));
						arrValues.add(Helper.correctDouble(amount[k]));
						arrValues.add(correctNull(remarks[k]));
						arrValues.add(correctNull(type[k]));
						hshQuery.put("arrValues",arrValues);
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
					}
				}
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}	
			if(val.equals("delete"))
			{
				intUpdatesize=1;
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshqueryval=new HashMap();
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshquery.put("strQueryId","comlitdel");
				arr.add(appno);
				hshquery.put("arrValues",arr);
				hshqueryval.put(Integer.toString(intUpdatesize),hshquery);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			
			int	len_audit=bank.length;
			if(val.equals("update"))
			{
				for(int at=0;at<len_audit;at++)
				{	
					if(!bank[at].equals(""))
					{
						sbAt.append("Name of the Bank / Financial Institution / Others=").append(correctNull(bank[at]));
						sbAt.append(" ~Amount Claimed =").append(amount[at]);
						sbAt.append(" ~Reasons for litigation=").append(reasons[at]);
						sbAt.append(" ~Remarks=").append(remarks[at]);
						sbAt.append("<br>~");
					}
				}	
			}
			if(correctNull((String)hsh.get("hidRecordflag")).equals("Y"))
				hsh.put("hidAction", "update");
			else if(correctNull((String)hsh.get("hidRecordflag")).equals("N"))
				hsh.put("hidAction", "insert");
			
			AuditTrial.auditLog(hsh,"157",appno,sbAt.toString());					
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
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
	}

	public void updateGroup(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQuery ;
		
		ArrayList arr = new ArrayList();
		ArrayList arrValues ;
		
		ResultSet rs=null;
		String val="",strQuery ="";
		int intValue = 0;
		String appno="";
		
		try
		{
				
				val=(String)hsh.get("hidAction");
				appno=(String)hsh.get("appno");
					
				String []name=null;
				String []nature = null;
				String []banking = null;
				
				int intUpdatesize=0;
				intUpdatesize=1;
				
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshquery.put("strQueryId","comgroupdel");
				arr.add(appno);
				hshquery.put("arrValues",arr);
				hshqueryval.put(Integer.toString(intUpdatesize),hshquery);

				if (val.equals("update"))
				{
				strQuery = SQLParser.getSqlQuery("comgroupmax^"+appno);
				//rs = stmt.executeQuery(strQuery);
				rs =DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					intValue = (rs.getInt(1));
				
				}
			
					name= (String [])hsh.get("name");
					nature= (String [])hsh.get("nature");
					banking = (String [])hsh.get("banking");
					
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						int len=name.length;
						for(int k=0;k<len;k++)
							{				
								if(!name[k].equals(""))
									{
										hshQuery = new HashMap();
										arrValues=new ArrayList();
										intUpdatesize=intUpdatesize+1;
										hshQuery.put("strQueryId","comgroupins");
										arrValues.add(appno);
										intValue=intValue+1;
										String i=Integer.toString(intValue);
										arrValues.add(i);
										arrValues.add(correctNull(name[k]));
										arrValues.add(correctNull(nature[k]));
										arrValues.add(correctNull(banking[k]));
										
										hshQuery.put("arrValues",arrValues);
										
										hshqueryval.put("size",Integer.toString(intUpdatesize));
										hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
									}
							}
							
				
				}	
				
		
				
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
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
	}

	public void updateRawMajor(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQuery ;
		ArrayList arr = new ArrayList();
		ArrayList arrValues ;
		ResultSet rs=null;
		String val="",strQuery ="";
		int intValue = 0;
		String appno="";
		
		try
		{
			val=correctNull((String)hsh.get("hidAction"));
			appno=correctNull((String)hsh.get("appno"));
					
			String []inputs=null;
			String []inputunit = null;
			String []inputcostperunit = null;
			String []inputpurity = null;
			String []inputpercost = null;
			String []inputperrawcost = null;
			String []inputtype = null;
			String []inputlocation = null;
			String []from = null;
			String []totalquantity=null;
			inputs= (String [])hsh.get("inputs");
			inputunit = (String [])hsh.get("inputunit");
			inputcostperunit = (String [])hsh.get("inputcostperunit");
			inputpurity=(String [])hsh.get("inputpurity");
			inputpercost=(String [])hsh.get("inputpercost");
			inputperrawcost=(String [])hsh.get("inputperrawcost");
			inputtype=(String [])hsh.get("inputtype");
			inputlocation=(String [])hsh.get("inputlocation");
			from=(String [])hsh.get("from");
            totalquantity=(String [])hsh.get("totalquantity");

			int intUpdatesize=0;
			intUpdatesize=1;
			hshqueryval.put("size",Integer.toString(intUpdatesize));

			hshquery.put("strQueryId","comrawdel1");
			arr.add(appno);
			hshquery.put("arrValues",arr);
			hshqueryval.put("1",hshquery);

			if (val.equals("update"))
			{
				strQuery = SQLParser.getSqlQuery("comrawmax1");
				rs =DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					intValue = (rs.getInt(1));
				}
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				int len1=inputs.length;
				for(int x=0;x<len1;x++)
				{				
					if(!inputs[x].equals(""))
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","comrawins");
						arrValues.add(appno);
						intValue=intValue+1;
						String i=Integer.toString(intValue);
						arrValues.add(i);
					
						arrValues.add(correctNull(inputs[x]));
						arrValues.add(correctNull(inputunit[x]));
						arrValues.add(Helper.correctDouble((String)inputcostperunit[x]));
						arrValues.add(Helper.correctDouble((String)inputpurity[x]));
						arrValues.add(Helper.correctDouble((String)inputpercost[x]));
						arrValues.add(Helper.correctDouble((String)inputperrawcost[x]));
						arrValues.add(correctNull(inputtype[x]));
						arrValues.add(correctNull(inputlocation[x]));
						arrValues.add(correctNull(from[x]));
						arrValues.add(correctNull(totalquantity[x]));
						hshQuery.put("arrValues",arrValues);
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
					}
				}
			}	
				
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");

			StringBuilder sbAuditTrial=new StringBuilder();
			
			int len=inputs.length;
			if (val.equals("update"))
			{
				for(int k=0;k<len;k++)
				{				
					if(!inputs[k].equals(""))
					{	
						if(k==0)
						{	
							sbAuditTrial.append("~S.No  =").append(k+1);
						}
						else
						{
							sbAuditTrial.append("~S.No  =").append(k+1);
						}
						sbAuditTrial.append("~List of Raw materials and Stores required   =").append(correctNull(inputs[k])).append("~Imported / Indigenous   =").append(ApplicantParams.getApplicantParams("RawMaterials",from[k]))
						.append("~Approximate cost per unit : Unit =").append(correctNull((String )inputunit[k])).append("~Approximate cost per unit : Total Quantity of units =").append(correctNull(totalquantity[k]))
						.append("~Approximate cost per unit : Cost per unit =").append(correctNull(inputcostperunit[k])).append("~Approximate cost per unit : Purity Level % =").append(correctNull(inputpurity[k]))
						.append("~% to cost of production  =").append(correctNull(inputpercost[k])).append("~% to raw material cost =").append(correctNull(inputperrawcost[k]))
						.append("~Availability along with location  =").append(correctNull(inputlocation[k]));
					}
				}	
			}
			if(correctNull((String)hsh.get("hidRecordflag")).equals("Y"))
				hsh.put("hidAction", "update");
			else if(correctNull((String)hsh.get("hidRecordflag")).equals("N"))
				hsh.put("hidAction", "insert");
				
			AuditTrial.auditLog(hsh,"150",appno,sbAuditTrial.toString());
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
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
	}
	
	public HashMap getRawMajorData(HashMap hsh) 
	{
		String strQuery="";
		ResultSet rs=null;
		HashMap hshValues = new HashMap();
		ArrayList vecVal1 = new ArrayList();
		ArrayList vecRec1= new ArrayList();
		String appno="";
		String recflag="N";
		try
		{
			appno=(String)hsh.get("appno");
			strQuery = SQLParser.getSqlQuery("comrawsel1^"+appno);
			rs =DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecRec1 = new ArrayList();
				vecRec1.add(correctNull(rs.getString(1)));
				vecRec1.add(correctNull(rs.getString(2)));
				vecRec1.add(correctNull(rs.getString(3)));
				vecRec1.add(correctNull(rs.getString(4)));
				vecRec1.add(correctNull(rs.getString(5)));
				vecRec1.add(correctNull(rs.getString(6)));
				vecRec1.add(correctNull(rs.getString(7)));
				vecRec1.add(correctNull(rs.getString(8)));
				vecRec1.add(correctNull(rs.getString(9)));
				vecRec1.add(correctNull(rs.getString(10)));
				vecRec1.add(correctNull(rs.getString(11)));
				vecRec1.add(correctNull(rs.getString(12)));
				vecVal1.add(vecRec1);
				recflag="Y";
			}
			hshValues.put("vecVal1",vecVal1);
			hshValues.put("recflag",recflag);
		}
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
			}
			catch (Exception e1)
			{
				log.error("error occured"+e1.toString());
			}
		}
		return hshValues;
	}

	public HashMap getSupplyIndiData(HashMap hsh) 
	{		
		String strQuery="";
		ResultSet rs=null;		
		HashMap hshValues = new HashMap();		
		ArrayList vecVal1 = new ArrayList();		
		ArrayList vecRec1= new ArrayList();
		String appno="";
		try
			{
				appno=(String)hsh.get("appno");
				strQuery = SQLParser.getSqlQuery("comsupselection_new1^"+appno);			
				rs =DBUtils.executeQuery(strQuery);
				while(rs.next())				
				{						
						vecRec1 = new ArrayList();							
						vecRec1.add(correctNull(rs.getString(1)));
						vecRec1.add(correctNull(rs.getString(2)));
						if(rs.getString(3).equalsIgnoreCase("0"))
						{
							vecRec1.add("");
						}
						else
						{
							vecRec1.add(correctNull(rs.getString(3)));
						}
						vecRec1.add(correctNull(rs.getString(4)));
						vecRec1.add(correctNull(rs.getString(5)));
						if( (Helper.correctNull((String)rs.getString(6)).equalsIgnoreCase("0.00")) || (Helper.correctNull((String)rs.getString(6)).equalsIgnoreCase("")))
						{
							vecRec1.add("");
						}
						else
						{
							vecRec1.add(correctNull(rs.getString(6)));
						}
						vecRec1.add(correctNull(rs.getString(7)));
						vecVal1.add(vecRec1);					
				}				
				hshValues.put("vecVal1",vecVal1);				
			}
		
		catch (Exception e)
			{
			log.error("error occured"+e.toString());
			}

			finally
			{
				try
				{
					if(rs!= null)
					{
						rs.close();
					}
				
				}
				catch (Exception e1)
				{
					log.error("error occured"+e1.toString());
				}
			}
			return hshValues;
	}


public void updateSupplyIndi(HashMap hsh) 
{
	
	HashMap hshqueryval = new HashMap();
	HashMap hshquery = new HashMap();
	HashMap hshQuery ;
	ArrayList arr = new ArrayList();
	ArrayList arrValues ;		
	ResultSet rs=null;
	String val="";
	int intValue = 0;
	String appno="";
	
	try
	{			
			val=(String)hsh.get("hidAction");
			appno=(String)hsh.get("appno");								

			String []indsupply=null;
			String []indlocation=null;
			String []indmaterials = null;
			String []indcredit = null;
			String []indtype = null;
			String []sno = null;
				
			indsupply= (String [])hsh.get("indsupply");				
			indlocation= (String [])hsh.get("indlocation");				
			indmaterials = (String [])hsh.get("indmaterials");					
			indcredit = (String [])hsh.get("indcredit");					
			indtype=(String [])hsh.get("indtype");
			sno=(String [])hsh.get("sno");
			
			int intUpdatesize=0;
			intUpdatesize=1;
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery.put("strQueryId","comsupdel1");
			arr.add(appno);
			hshquery.put("arrValues",arr);
			hshqueryval.put("1",hshquery);

			if (val.equals("update"))
			{
					
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							int len1=indsupply.length;
								for(int x=0;x<len1;x++)
								{				
									if(!indmaterials[x].equals(""))
										{
											hshQuery = new HashMap();
											arrValues=new ArrayList();
											intUpdatesize=intUpdatesize+1;
											hshQuery.put("strQueryId","comsupins");
											arrValues.add(appno);
											arrValues.add(correctNull(indtype[x]));
											intValue=Integer.parseInt(sno[x]);
											arrValues.add(Integer.toString(intValue));
											if(indsupply[x].equals(""))
											{
												arrValues.add("0");
											}
											else
											{
												arrValues.add(correctNull(indsupply[x]));
											}
											arrValues.add(correctNull(indlocation[x]));
											arrValues.add(correctNull(indmaterials[x]));
											arrValues.add(Helper.correctDouble((String)indcredit[x]));
											hshQuery.put("arrValues",arrValues);												
											hshqueryval.put("size",Integer.toString(intUpdatesize));
											hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
										}
								}
			}	
			
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");


				// audit trial  
			hshqueryval= new HashMap();
			String strActionData = "";
			hshQuery = new HashMap();
					arrValues=new ArrayList();
					int len_audit=indsupply.length;

					for(int at=0;at<len_audit;at++)
						{	
						
							if(!indsupply[at].equals(""))
							{
									hshqueryval= new HashMap();
									hshQuery = new HashMap();
									arrValues=new ArrayList();
									//intUpdatesize_audit=intUpdatesize_audit;
									hshQuery.put("strQueryId","audittrial");
									arrValues.add("52");
									arrValues.add(correctNull((String)hsh.get("strUserId")));
									arrValues.add(correctNull((String)hsh.get("strClientIP")));
									arrValues.add(appno);
									
									
								strActionData="indsupply="+correctNull(indsupply[at])+"~indlocation="+
									correctNull(indlocation[at])+"~indmaterials="+correctNull(indmaterials[at])+
									"~indcredit="+correctNull(indcredit[at]);
								arrValues.add(strActionData);
								if(val.equalsIgnoreCase("delete"))
								{
									arrValues.add("delete");
								}
								else
								{
									arrValues.add("insert");
								}
									
									
									hshQuery.put("arrValues",arrValues);
									
									hshqueryval.put("size","1");
									hshqueryval.put("1",hshQuery);	
									EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");	
							}
								
						}
				
			//   audit trial  
		
	}
	catch (Exception e)
	{
		log.error("in bean"+e);
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
	
}

	public HashMap getOtherSubstData(HashMap hsh) 
	{
		
		String strQuery="";
		ResultSet rs=null;
		
		HashMap hshValues = new HashMap();
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec= new ArrayList();
		String appno="";
		try
			{
			
				appno=(String)hsh.get("appno");
				strQuery = SQLParser.getSqlQuery("comotherselection^"+appno+"^"+appno+"^"+appno);

				rs =DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
						vecRec = new ArrayList();
						vecRec.add(correctNull(rs.getString(1)));
						vecRec.add(correctNull(rs.getString(2)));
						vecRec.add(correctNull(rs.getString(3)));
						vecRec.add(correctNull(rs.getString(4)));
						
						
						vecVal.add(vecRec);
					
				}
				hshValues.put("vecVal",vecVal);

			
			}
		
		catch (Exception e)
			{
			log.error("error occured"+e.toString());
			}

			finally
			{
				try
				{
					if(rs!= null)
					{
						rs.close();
					}
					
				}
				catch (Exception e1)
				{
					log.error("error occured"+e1.toString());
				}
			}
			return hshValues;
	}
	
public void updateOtherDetailsSubst(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQuery = new HashMap();
			
		ArrayList arr = new ArrayList();
				
		ArrayList arrValues ;
		
		ResultSet rs=null;
		String val="",strQuery ="";
		int intValue = 0;
		String appno="";
		
		try
		{
				
				val=(String)hsh.get("hidAction");
				appno=(String)hsh.get("appno");
					
				String []substitute=null;
				String []costoriginal = null;
				String []yieldoriginal = null;
				int intUpdatesize=0;
				intUpdatesize=1;
										
				
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshquery.put("strQueryId","comotherdel");
				arr.add(appno);
				hshquery.put("arrValues",arr);
				hshqueryval.put(Integer.toString(intUpdatesize),hshquery);

				if (val.equals("update"))
				{
				
				strQuery = SQLParser.getSqlQuery("comothermax^"+appno);
			
				rs =DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					intValue = (rs.getInt(1));
				
				}
			
					substitute= (String [])hsh.get("substitute");
					costoriginal= (String [])hsh.get("costoriginal");
					yieldoriginal = (String [])hsh.get("yieldoriginal");
					
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						int len=substitute.length;
						for(int k=0;k<len;k++)
							{				
								if(!substitute[k].equals(""))
									{
										hshQuery = new HashMap();
										arrValues=new ArrayList();
										intUpdatesize=intUpdatesize+1;
										hshQuery.put("strQueryId","comotherins");
										arrValues.add(appno);
										intValue=intValue+1;
										String i=Integer.toString(intValue);
										arrValues.add(i);
										arrValues.add(correctNull(substitute[k]));
										arrValues.add(correctNull((String)costoriginal[k]));
										arrValues.add(correctNull((String)yieldoriginal[k]));
										
										hshQuery.put("arrValues",arrValues);
										
										hshqueryval.put("size",Integer.toString(intUpdatesize));
										hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
									}
							}
							
				
				}	
				
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
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
		
		
	}

public void updateSegmentEnd(HashMap hsh) 
	{
		
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
	
		HashMap hshQuery ;
		ArrayList arr = new ArrayList();
		ArrayList arrValues ;
		
		ResultSet rs=null;
		String val="",strQuery ="";
		int intValue = 0;
		String appno="";
		
		try
		{
				
				val=(String)hsh.get("hidAction");
				appno=(String)hsh.get("appno");
					
					
					String []endproducts=null;
					String []endlocation = null;
					String []endtype = null;
				
					int intUpdatesize=0;
					intUpdatesize=1;

				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshquery.put("strQueryId","comsegmentdel1");
				arr.add(appno);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);

				
		if (val.equals("update"))
		{
			
				
			strQuery = SQLParser.getSqlQuery("comsegmentmax1");
			
			rs =DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				intValue = (rs.getInt(1));
				
			}
					endproducts= (String [])hsh.get("endproducts");
					endlocation= (String [])hsh.get("endlocation");
					endtype=(String [])hsh.get("endtype");
					
					hshQuery = new HashMap();
						arrValues=new ArrayList();
						int len1=endproducts.length;
							for(int x=0;x<len1;x++)
							{				
								if(!endproducts[x].equals(""))
									{
										hshQuery = new HashMap();
										arrValues=new ArrayList();
										intUpdatesize=intUpdatesize+1;
										hshQuery.put("strQueryId","comsegmentins");
										arrValues.add(appno);
										intValue=intValue+1;
										String i=Integer.toString(intValue);
										arrValues.add(i);
										
										arrValues.add(correctNull(endproducts[x]));
										arrValues.add(correctNull(endlocation[x]));
										arrValues.add(correctNull(endtype[x]));
										
										hshQuery.put("arrValues",arrValues);
										
										hshqueryval.put("size",Integer.toString(intUpdatesize));
										hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
									}
							}
								
				}	
				
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
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
		
		
	}
	public HashMap getSegmentEndData(HashMap hsh) 
	{
		
		String strQuery="";
		ResultSet rs=null;
		
		HashMap hshValues = new HashMap();
	
		ArrayList vecVal1 = new ArrayList();
		ArrayList vecRec1= new ArrayList();
		String appno="";
		try
			{
			
				appno=(String)hsh.get("appno");
				strQuery = SQLParser.getSqlQuery("comsegmentsel1^"+appno);

				rs =DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
						
						vecRec1 = new ArrayList();
						
						vecRec1.add(correctNull(rs.getString(1)));
						vecRec1.add(correctNull(rs.getString(2)));
						vecRec1.add(correctNull(rs.getString(3)));
						vecRec1.add(correctNull(rs.getString(4)));
						vecRec1.add(correctNull(rs.getString(5)));
						
						vecVal1.add(vecRec1);
					
				}
				
			
				hshValues.put("vecVal1",vecVal1);
				
			}
		
		catch (Exception e)
			{
			log.error("error occured"+e.toString());
			}

			finally
			{
				try
				{
					if(rs!= null)
					{
						rs.close();
					}
					
				}
				catch (Exception e1)
				{
					log.error("error occured"+e1.toString());
				}
			}
			return hshValues;
	}

	
	public HashMap getDistLocalData(HashMap hsh) 
	{
		String strQuery="";
		ResultSet rs=null;
		HashMap hshValues = new HashMap();
		ArrayList vecVal1 = new ArrayList();
		ArrayList vecRec1= new ArrayList();
		String appno="";
		boolean recordflag=false;
		try
		{
			appno=(String)hsh.get("appno");
			strQuery = SQLParser.getSqlQuery("comdistsel1^"+appno);
			rs =DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecRec1 = new ArrayList();
				vecRec1.add(correctNull(rs.getString(1)));
				vecRec1.add(correctNull(rs.getString(2)));
				vecRec1.add(correctNull(rs.getString(3)));
				vecRec1.add(correctNull(rs.getString(4)));
				vecRec1.add(correctNull(rs.getString(5)));
				vecRec1.add(correctNull(rs.getString(6)));
				vecVal1.add(vecRec1);
				recordflag=true;
			}
			hshValues.put("vecVal1",vecVal1);
			if(recordflag)
				hshValues.put("recordflag","Y");
			else
				hshValues.put("recordflag","N");
		}		
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
				
			}
			catch (Exception e1)
			{
				log.error("error occured"+e1.toString());
			}
		}
		return hshValues;
	}

	public void updateDistLocal(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQuery ;
		ArrayList arr = new ArrayList();
		ArrayList arrValues ;
		ResultSet rs=null;
		String val="",strQuery ="";
		
		ResultSet rs1=null;
		int intUpdatesize_audit=0;
		String strActionData="";
		String strQuery1="";
		int intValue = 0;
		String appno="";
		
		try
		{
			StringBuilder sbAt = new StringBuilder();
			val=correctNull((String)hsh.get("hidAction"));
			appno=correctNull((String)hsh.get("appno"));
		
			String []localname=null;
			String []localproduct = null;
			String []localtotal = null;
			String []localtype = null;
			int intUpdatesize=0;
			
			if(val.equals("delete"))
			{
				hshqueryval=new HashMap();	
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshqueryval.put("size","1");
				hshquery.put("strQueryId","comdistdel1");
				arr.add(appno);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			if (val.equals("update"))
			{
				hshqueryval=new HashMap();	
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize=1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshquery.put("strQueryId","comdistdel1");
				arr.add(appno);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				
				strQuery = SQLParser.getSqlQuery("comdistmax1^"+appno);
				rs =DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					intValue = (rs.getInt(1));
				}
				localname= (String [])hsh.get("localname");
				localproduct = (String [])hsh.get("localproduct");
				localtotal = (String [])hsh.get("localtotal");
				localtype=(String [])hsh.get("localtype");
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				int len1=localname.length;
				for(int x=0;x<len1;x++)
				{				
					if(!localname[x].equals(""))
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","comdistins");
						arrValues.add(appno);
						intValue=intValue+1;
						String i=Integer.toString(intValue);
						arrValues.add(i);
						arrValues.add(correctNull(localtype[x]));
						arrValues.add(correctNull(localname[x]));
						arrValues.add(correctNull(localproduct[x]));
						arrValues.add(Helper.correctDouble((String)localtotal[x]));
						arrValues.add("india");
						hshQuery.put("arrValues",arrValues);
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
						
						sbAt.append("~Customer Name=").append(correctNull(localname[x])).append(
						"~Product=").append(correctNull(localproduct[x])).append(
						"~% of total turnover=").append(correctNull(localtotal[x]));
					}
				}
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}	
			
		        //----------------------------------AuditTrial---------------------------------
			if(val.equals("update"))
			{
				sbAt=new StringBuilder();
				localname= (String [])hsh.get("localname");
				localproduct = (String [])hsh.get("localproduct");
				localtotal = (String [])hsh.get("localtotal");
				localtype=(String [])hsh.get("localtype");
				
				int len1=localname.length;
				for(int x=0;x<len1;x++)
				{		
					if(!localname[x].equals(""))
					{
						sbAt.append("~Customer Name=").append(correctNull(localname[x])).append(
						"~Product=").append(correctNull(localproduct[x])).append(
					"~% of total turnover=").append(correctNull(localtotal[x]));
						
				  }
				}
	    	}	
			if(correctNull((String)hsh.get("hidRecordflag")).equals("Y"))
				hsh.put("hidAction", "update");
			else if(correctNull((String)hsh.get("hidRecordflag")).equals("N"))
				hsh.put("hidAction", "insert");
			
			AuditTrial.auditLog(hsh,"152",appno,sbAt.toString());
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
		}
		
		finally
		{
			try
			{
				if(rs1 != null)
				{
					rs1.close();
				}
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
	}

	public void updateCapitalStructure(HashMap hshValues)
	{
		String strAppno="";
		String strAction="";
		HashMap hshqueryval = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues=new ArrayList();
		String strCategory = "";
		try{
			strAppno=correctNull((String)hshValues.get("appno"));
			strAction=correctNull((String)hshValues.get("hidAction"));
			strCategory = Helper.correctNull((String)hshValues.get("hid_categoryType"));
			if(strAction.equals("update"))
			{
				arrValues.add(strAppno);
				hshQuery.put("strQueryId","delcapitalstructure");
				hshQuery.put("arrValues",arrValues);
				hshqueryval.put("size","1");
				hshqueryval.put("1",hshQuery);
				
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hshValues.get("txt_ason")));
				arrValues.add(correctNull((String)hshValues.get("txt_captial")));
				arrValues.add(correctNull((String)hshValues.get("txt_subcapital")));
				arrValues.add(correctNull((String)hshValues.get("comapp_totsharevalue")));
				arrValues.add(correctNull((String)hshValues.get("book_value")));
				arrValues.add(correctNull((String)hshValues.get("market_value")));
				arrValues.add(correctNull((String)hshValues.get("txt_reserve")));
				
				hshQuery.put("strQueryId","inscapitalstructure");
				hshQuery.put("arrValues",arrValues);
				hshqueryval.put("size","2");
				hshqueryval.put("2",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			else if(strAction.equals("delete"))
			{
				arrValues.add(strAppno);
				hshQuery.put("strQueryId","delcapitalstructure");
				hshQuery.put("arrValues",arrValues);
				hshqueryval.put("size","1");
				hshqueryval.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			StringBuilder sbAt = new StringBuilder();
			if(strAction.equals("update"))
			{
				sbAt.append("Details As on =").append(correctNull((String) hshValues.get("txt_ason")));
				sbAt.append(" ~ Authorised Capital (in Lacs) =").append(correctNull((String) hshValues.get("txt_captial")));
				sbAt.append(" ~ Issued/Subscribed Capital (in Lacs) =").append(correctNull((String) hshValues.get("txt_subcapital")));
				if(strCategory.equalsIgnoreCase("OPS"))
				{
					sbAt.append(" ~ Paid Up Caital (in Lacs)=").append(correctNull((String) hshValues.get("comapp_totsharevalue")));
					sbAt.append(" ~ Reserve capital (in Lacs)=").append(correctNull((String) hshValues.get("txt_reserve")));
				}else{
					sbAt.append(" ~ Total No. of Paid Up Shares=").append(correctNull((String) hshValues.get("comapp_totsharevalue")));
					sbAt.append(" ~ Book Value =").append(ApplicationParams.getCurrency() +" " +correctNull((String) hshValues.get("book_value")));
					sbAt.append(" ~ Market value=").append(ApplicationParams.getCurrency() +" " +correctNull((String) hshValues.get("market_value")));
				}
				if(correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("N"))
				{
					hshValues.put("hidAction","insert");
				}	
			}
			AuditTrial.auditLog(hshValues,"209",strAppno,sbAt.toString());
		}catch(Exception ex)
		{
			throw new EJBException("Error in updateCapitalStructure :: " +ex.toString());
		}
	}
	
	public HashMap getCapitalStructure(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		String strAppno="";
		String strQuery="";
		ResultSet rs=null;
		boolean recordflag=false;
		try{
			strAppno=correctNull((String)hshValues.get("appno"));
			strQuery=SQLParser.getSqlQuery("selcapitalstructure^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("detailsason",correctNull(rs.getString("com_ason")));
				hshRecord.put("auth_capital",correctNull(rs.getString("com_authcapital")));
				hshRecord.put("sub_capital",correctNull(rs.getString("com_subisscapital")));
				hshRecord.put("paidshares",correctNull(rs.getString("com_paidshares")));
				hshRecord.put("book_value",correctNull(rs.getString("com_bookvalue")));
				hshRecord.put("market_value",correctNull(rs.getString("com_marketvalue")));
				hshRecord.put("reservecapital",correctNull(rs.getString("com_reservecapital")));
				recordflag=true;
			}
			 if(recordflag)
					hshRecord.put("recordflag","Y");
				else
					hshRecord.put("recordflag","N");
		}catch(Exception ex)
		{
			throw new EJBException("Error in getCapitalStructure :: " +ex.toString());
		}
		finally
		{
			try{
			}catch(Exception ex)
			{
				throw new EJBException("Error in closing the connection :: "+ex.toString());
			}
		}
		return hshRecord;
	}
	
	public HashMap getCompanyBackground(HashMap hshValues)  {
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strAppno = "";

		try {
			strAppno = correctNull((String) hshValues.get("appno"));
			strQuery = SQLParser.getSqlQuery("sel_companybackground^"+strAppno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("comback_comment", correctNull(Helper.CLOBToString(rs.getClob("comback_comment"))));
			}
		} catch (Exception ce) {
				throw new EJBException("Error in getCompanyBackground " + ce.toString());
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
	
	public void updateCompanyBackground(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		String strAction = correctNull((String) hshValues.get("hidAction"));
		String strappno = correctNull((String) hshValues.get("appno"));

		if (strappno.equalsIgnoreCase(null) || strappno.equals("")) {
			strappno = correctNull((String) hshValues.get("hidappno"));
		}
		try {
			if (strAction.trim().equals("update")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId","del_companybackground");
				arrValues.add(strappno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				
				hshQuery = new HashMap();
				hshQueryValues.put("size", "2");
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_companybackground");
				arrValues.add(strappno);
				arrValues.add(correctNull((String) hshValues.get("company_background")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			else if (strAction.trim().equals("delete")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_companybackground");
				arrValues.add(strappno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
		}
		catch (Exception ce) {
			throw new EJBException("inside update" + ce.toString());
		} 
	}

	public void update_Others(HashMap hshValues)  {
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQuery;
		ArrayList arrValues = new ArrayList();

		try {
			String val = correctNull((String) hshValues.get("hidAction"));
			String appno = correctNull((String) hshValues.get("appno"));
			String strPageType = correctNull((String) hshValues.get("hidpage"));
			String strSrno=correctNull((String) hshValues.get("hidSrno"));
			String strindustryanalysis = Helper.correctNull((String) hshValues.get("txt_industryanalysis"));
			if (!val.equalsIgnoreCase("delete")) {
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			hshQuery.put("strQueryId", "del_comments");
			arrValues.add(appno);
			arrValues.add(strPageType);
			hshQuery.put("arrValues", arrValues);
			hshqueryval.put("size", "2");
			hshqueryval.put("1", hshQuery);

			arrValues = new ArrayList();
			hshQuery = new HashMap();
			hshQuery.put("strQueryId", "ins_comments");
			arrValues.add(appno);
			arrValues.add(strSrno);
			arrValues.add(strindustryanalysis);
			arrValues.add(strPageType);
			hshQuery.put("arrValues", arrValues);
			hshqueryval.put("2", hshQuery);
			}
			if (val.equalsIgnoreCase("delete")) {
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "del_comments");
				arrValues.add(appno);
				arrValues.add(strPageType);
				hshQuery.put("arrValues", arrValues);
				hshqueryval.put("size", "1");
				hshqueryval.put("1", hshQuery);
			}
		EJBInvoker.executeStateLess("dataaccess", hshqueryval, "updateData");

		} catch (Exception ce) {
			throw new EJBException(ce);
		} finally {

		}
		
	}
	public void update_Management(HashMap hshValues)  {
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQuery;
		ArrayList arrValues = new ArrayList();

		try {
			String val = (String) hshValues.get("hidAction");
			String appno = (String) hshValues.get("appno");
			String strPageType = (String) hshValues.get("PageType");
			String strSrno=(String) hshValues.get("sel_finposition");
			String strindustryanalysis = Helper.correctNull((String) hshValues.get("txt_comments"));
			int intsize=0;
			if (!val.equalsIgnoreCase("delete")) {
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			hshQuery.put("strQueryId", "del_management");
			arrValues.add("Management");
			arrValues.add(strSrno);
			arrValues.add(appno);
			hshQuery.put("arrValues", arrValues);
			hshqueryval.put("size",String.valueOf(++intsize));					
			hshqueryval.put(String.valueOf(intsize),hshQuery);

			arrValues = new ArrayList();
			hshQuery = new HashMap();
			hshQuery.put("strQueryId", "ins_management");
			arrValues.add(appno);
			arrValues.add(strSrno);
			arrValues.add(strindustryanalysis);
			arrValues.add("Management");
			arrValues.add(Helper.correctNull((String) hshValues.get("txt_creditdate")));
			arrValues.add(Helper.correctNull((String) hshValues.get("txt_emaildate")));
			hshQuery.put("arrValues", arrValues);
			hshqueryval.put("size",String.valueOf(++intsize));					
			hshqueryval.put(String.valueOf(intsize),hshQuery);
			}
			if (val.equalsIgnoreCase("delete")) {
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "del_management");
				arrValues.add("Management");
				arrValues.add(strSrno);
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshqueryval.put("size",String.valueOf(++intsize));					
				hshqueryval.put(String.valueOf(intsize),hshQuery);
				
				if( strSrno.equalsIgnoreCase("22")){
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "del_management_assementAll");
					arrValues.add("Management");
					arrValues.add(strSrno);
					arrValues.add(appno);
					hshQuery.put("arrValues", arrValues);
					hshqueryval.put("size",String.valueOf(++intsize));					
					hshqueryval.put(String.valueOf(intsize),hshQuery);
				
			}
			}
			
			if(val.equalsIgnoreCase("update") && strSrno.equalsIgnoreCase("22")){
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "del_management_assementAll");
				arrValues.add("Management");
				arrValues.add(strSrno);
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshqueryval.put("size",String.valueOf(++intsize));					
				hshqueryval.put(String.valueOf(intsize),hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				int size=0;
				if(hshValues.get("txt_Observation") instanceof String[])
				{
					String strObservation[]=(String[])hshValues.get("txt_Observation");
					String strCompliance[]=(String[])hshValues.get("txt_Compliance");
					for(int i=0;i<strObservation.length;i++)
					{
						++intsize;
						hshQuery=new HashMap();
						arrValues = new ArrayList();
						arrValues.add(appno);
						arrValues.add(strSrno);
						arrValues.add(String.valueOf(i+1));
						arrValues.add(strObservation[i]);
						arrValues.add(strCompliance[i]);
						arrValues.add("Management");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						hshQuery.put("arrValues", arrValues);
						hshQuery.put("strQueryId", "ins_management_assement");
						hshqueryval.put("size",String.valueOf(intsize));					
						hshqueryval.put(String.valueOf(intsize),hshQuery);
					}
				}
				else if(!Helper.correctNull((String)hshValues.get("txt_Observation")).equalsIgnoreCase("")||!Helper.correctNull((String)hshValues.get("txt_Compliance")).equalsIgnoreCase(""))
				{
					++intsize;
					hshQuery=new HashMap();
					arrValues = new ArrayList();
					arrValues.add(appno);
					arrValues.add(strSrno);
					arrValues.add("1");
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_Observation")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_Compliance")));
					arrValues.add("Management");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "ins_management_assement");
					hshqueryval.put("size",String.valueOf(intsize));					
					hshqueryval.put(String.valueOf(intsize),hshQuery);
			}
			}
		EJBInvoker.executeStateLess("dataaccess", hshqueryval, "updateData");
			
					
		}
		catch (Exception ce) {
			throw new EJBException(ce);
		} finally {

		}
		
	}
	public HashMap get_Others(HashMap hshValues)  {
		ResultSet rs = null;
		HashMap hshRecord = null;
		hshRecord = new HashMap();
		Blob b = null;
		byte[] aBlob = null;
		ByteArrayOutputStream bios = new ByteArrayOutputStream();
		String strAppNo = correctNull((String) hshValues.get("appno"));
		String strPageType = correctNull((String) hshValues.get("hidpage"));
		if (strAppNo.equalsIgnoreCase("") || strAppNo.equalsIgnoreCase("null")) {
			strAppNo = correctNull((String) hshValues.get("appno"));
		}
		try {
			rs = DBUtils.executeLAPSQuery("sel_comments^"+strPageType+"^"+ strAppNo);
			if (rs.next()) {
			hshRecord.put("comments", Helper.CLOBToString(rs.getClob("com_comments")));
			}

		} catch (Exception e) {
			log.error("error occured" + e.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				log.error("error occured" + e1.toString());
			}
		}
		return hshRecord;
	}
	public HashMap get_Management(HashMap hshValues)  {
		ResultSet rs = null;
		HashMap hshRecord = null;
		hshRecord = new HashMap();
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String strSrno=correctNull((String) hshValues.get("sel_finposition"));
		String strAppNo = correctNull((String) hshValues.get("appno"));
		String strPageType = (String) hshValues.get("PageType");
		if (strAppNo.equalsIgnoreCase("") || strAppNo.equalsIgnoreCase("null")) {
			strAppNo = correctNull((String) hshValues.get("appno"));
		}
		try {
			if(!strSrno.equalsIgnoreCase("")){
			rs = DBUtils.executeLAPSQuery("sel_management^Management^"+strSrno+"^"+strAppNo);
			if (rs.next()) {
				hshRecord.put("strSrno", Helper.correctNull(rs.getString("com_sno")));
				hshRecord.put("comments", Helper.CLOBToString(rs.getClob("com_comments")));
				hshRecord.put("COM_DATE",Helper.correctNull((String)rs.getString("COM_DATE")));	
				hshRecord.put("COM_DACCODATE",Helper.correctNull((String)rs.getString("COM_DACCODATE")));
			
			}
			}
			if(strSrno.equalsIgnoreCase("22")){
				 if (rs != null) {
						rs.close();
					}//s.no-->facilityNo
				rs = DBUtils.executeLAPSQuery("sel_management_Assement^Management^"+strSrno+"^"+strAppNo);
				while(rs.next()){
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull(rs.getString("ASSEMENT_SNO")));//0
					arrCol.add(Helper.correctNull(rs.getString("ASSEMENT_COMMENT")));//1
					arrCol.add(Helper.correctNull(rs.getString("ASSEMENT_COMMENT1")));//2
					arrCol.add(Helper.correctNull(rs.getString("ASSEMENT_PAGETYPE")));//3
					arrCol.add(Helper.correctNull(rs.getString("ASSEMENT_FNO")));//4
					arrRow.add(arrCol);
				}
			}
			
			rs = DBUtils.executeLAPSQuery("sel_corporate_breifbackground^"+strAppNo);
			if(rs.next())
			{
				hshRecord.put("com_griddate",correctNull(rs.getString("com_griddate")));
			}
			hshRecord.put("arrRow", arrRow);
			hshRecord.put("fieldstrSrno", strSrno);
		} catch (Exception e) {
			log.error("error occured" + e.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				log.error("error occured" + e1.toString());
			}
		}
		return hshRecord;
	}
	
	public void update_swotanalysis(HashMap hshValues)  {
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		HashMap hshquery2 = new HashMap();
		ArrayList arrValues ;		 
		ResultSet rs=null;
		String strAction="",strpagetype="";			
		String strappno="",strselect="",strWeak="",strOppur="",strThreats="",strcomments="";			
		try
		{ 
			int intUpdatesize = 0;	
			intUpdatesize=intUpdatesize+1;	
			
			strpagetype =correctNull((String)hshValues.get("PageType"));
			strAction =correctNull((String)hshValues.get("hidAction"));
			strselect=Helper.correctNull((String)hshValues.get("sel_swot"));
			strcomments=(String)hshValues.get("txt_comments");
			strappno = Helper.correctNull((String)hshValues.get("appno"));	
			if(strappno.equals("") || strappno.equals("null"))
			{
				strappno = Helper.correctNull((String)hshValues.get("strappno"));	
			}
		
			if(strAction.equals("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","del_swotanalysis");		
				arrValues.add(strappno);
				arrValues.add(strselect);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","2");
												
			
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ins_swotanalysis");
				arrValues.add(strappno);
				arrValues.add(strcomments);
				arrValues.add(strselect);
				hshQuery.put("arrValues",arrValues);					
				hshQueryValues.put("2",hshQuery);
				hshQueryValues.put("size","2");
													
			}	
			if (strAction.equalsIgnoreCase("delete")) {
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "del_swotanalysis");
				arrValues.add(strappno);
				arrValues.add(strselect);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
		
			}
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}catch (Exception e) {
			log.error("in bean" + e);
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
				 hshQuery = null;
				 hshQueryValues =null ;
				 hshquery2 =null;
				 arrValues =null;	
			}
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}		
	}
	public HashMap get_swotanalysis(HashMap hshValues)  {
		ResultSet rs = null;
		HashMap hshRecord = null;
		hshRecord = new HashMap();
		String strAppNo = correctNull((String) hshValues.get("appno"));
		String strPageType = (String) hshValues.get("PageType");
		if (strAppNo.equalsIgnoreCase("") || strAppNo.equalsIgnoreCase("null")) {
			strAppNo = correctNull((String) hshValues.get("appno"));
		}
		String strsel =correctNull((String) hshValues.get("sel_swot"));
		try {
			rs = DBUtils.executeLAPSQuery("sel_swotanalysis^" +strAppNo+"^"+strsel);
			if (rs.next()) {
			hshRecord.put("com_comments", Helper.CLOBToString(rs.getClob("com_comments")));
			hshRecord.put("selswot", Helper.correctNull(rs.getString("com_selswot")));
			}
			hshRecord.put("selswot",strsel);

		} catch (Exception e) {
			log.error("error occured" + e.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				log.error("error occured" + e1.toString());
			}
		}
		return hshRecord;
		
		}
	
	
	
	public void updatecom_externalratingdata(HashMap hshValues)  
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		
		String [] strtxt_facility=null;
		String [] strtxt_pre_agency=null;
		String [] strtxt_pre_longsymbol=null;
		String [] txt_description=null;  
		String [] txt_deleteondate1=null; 
		String [] txt_ratingamt=null;
		String strAction = correctNull((String) hshValues.get("hidAction"));
		String strappno = correctNull((String) hshValues.get("appno"));
		
		String strhidtype = correctNull((String) hshValues.get("hidtype"));
		
		
		String strtxt_facility1=null;
		String strtxt_pre_agency1=null;
		String strtxt_pre_longsymbol1=null;
		String strtxt_ratingamt1=null;
		String strtxt_description1=null;
		String strtxt_deleteondate11=null;
		
		String strQuery = "",strQuery1="";
		ResultSet rs = null,rs1 = null;
		int incount=0;
		try {
			strQuery = SQLParser.getSqlQuery("selcount_comapp_externalrating^"+strappno);
			rs = DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
				incount=rs.getInt("facility_id");
			}
			
			if(incount>1)
			{
				strtxt_facility=(String [])hshValues.get ("txt_facility");
				strtxt_pre_agency= (String [])hshValues.get("txt_pre_agency");
				strtxt_pre_longsymbol= (String [])hshValues.get("txt_pre_longsymbol");
				txt_ratingamt= (String [])hshValues.get("txt_ratingamt");
				txt_description= (String [])hshValues.get("txt_description");
				txt_deleteondate1= (String [])hshValues.get("txt_deleteondate1");
			}
			
				else
				{
					strtxt_facility1 =Helper.correctNull((String) hshValues.get("txt_facility"));
					strtxt_pre_agency1 =Helper.correctNull((String) hshValues.get("txt_pre_agency"));
					strtxt_pre_longsymbol1 =Helper.correctNull((String) hshValues.get("txt_pre_longsymbol"));
					strtxt_ratingamt1 =Helper.correctNull((String) hshValues.get("txt_ratingamt"));
					strtxt_description1 =Helper.correctNull((String) hshValues.get("txt_description"));
					strtxt_deleteondate11 =Helper.correctNull((String) hshValues.get("txt_deleteondate1"));
				}
			
			if ((strAction.trim().equals("update"))||(strAction.trim().equals("delete"))) {
				
				
				hshQueryValues=new HashMap();	
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_comapp_externalrating");
				arrValues.add(strappno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
			
			
			if (strAction.trim().equals("update"))
			{
			
			if(incount>1)
			{
				
					
					
					for(int i=0;i<incount;i++)
					{
					hshQuery = new HashMap();
					
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_comapp_externalrating");
					arrValues.add(strappno);
					arrValues.add(strtxt_facility[i]);
					arrValues.add(strtxt_pre_agency[i]);
					arrValues.add(txt_ratingamt[i]);
					arrValues.add(strtxt_pre_longsymbol[i]);
					arrValues.add(txt_description[i]);
					arrValues.add(txt_deleteondate1[i]);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size", "1");
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					}
					}
			
			else
			{
				hshQuery = new HashMap();
			
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "ins_comapp_externalrating");
			arrValues.add(strappno);
			arrValues.add(strtxt_facility1);
			arrValues.add(strtxt_pre_agency1);
			arrValues.add(strtxt_ratingamt1);
			arrValues.add(strtxt_pre_longsymbol1);
			arrValues.add(strtxt_description1);
			arrValues.add(strtxt_deleteondate11);
			
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("size", "1");
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
		}
		
			}
			
		}
		catch (Exception ce) {
			throw new EJBException("inside update" + ce.toString());
		} 
		
	}
	
	public HashMap getcom_externalratingdata(HashMap hshValues)  
	{
		String strQuery = "",strQuery1="";
		String strFacilitySno="";
		ResultSet rs = null,rs1 = null;
		HashMap hshRecord = new HashMap();
		String strAppno = "";
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol= new ArrayList();
		String strfacility_proposed=null;
		ArrayList vecRow1 = new ArrayList();
		ArrayList vecCol1= new ArrayList();
		try {
			
			strAppno = correctNull((String) hshValues.get("appno"));
			strQuery = SQLParser.getSqlQuery("get_FacilityData^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			
		while(rs.next()) 
		{
			vecCol= new ArrayList();
			vecCol.add(Helper.correctNull(rs.getString("com_facdesc")));//0
			vecCol.add(Helper.correctNull(rs.getString("facility_proposed")));//1
			vecCol.add(Helper.correctNull(rs.getString("facility_sno")));//2
			strFacilitySno=Helper.correctNull(rs.getString("facility_sno"));//3
			strQuery1 = SQLParser.getSqlQuery("selapp_comapp_externalrating^"+strAppno+'^'+strFacilitySno);
			rs1 = DBUtils.executeQuery(strQuery1);
			if(rs1.next())
			{
				vecCol.add(Helper.correctNull(rs1.getString("COM_FACILITYSNO")));//3
				vecCol.add(Helper.correctNull(rs1.getString("COM_AGENCY")));//4
				vecCol.add(Helper.correctDouble(rs1.getString("COM_AMOUNT")));//5
				vecCol.add(Helper.correctNull(rs1.getString("COM_RATING")));//6
				vecCol.add(Helper.CLOBToString(rs1.getClob("COM_DESC")));//7
				vecCol.add(Helper.correctNull(rs1.getString("COM_DUEDATE")));//8
			}
			else
			{
				vecCol.add("");
				vecCol.add("");
				vecCol.add(Helper.correctNull(rs.getString("facility_proposed")));//1
				vecCol.add("");
				vecCol.add("");
				vecCol.add("");	
			}
			vecRow.add(vecCol);
		}
			hshRecord.put("vecRow",vecRow);
			hshRecord.put("appno",strAppno);
	}
	catch (Exception ce) {
			throw new EJBException("inside update" + ce.toString());
		} 
		return hshRecord;
	}
	

	public void updateFinancialComments(HashMap hsh) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshQry = new HashMap();
		ArrayList arrValues = new ArrayList();
		ArrayList arrVal = new ArrayList();
		String strAction="";
		String appno="",strcommenttype="",pagetype="",comments="";
		
		try
		{
								
				strAction=(String)hsh.get("hidAction");
				appno=Helper.correctNull((String)hsh.get("appno"));
				//Added by Kishan
				String strFinID = "0";
				//String cma="0";
				/*String strQuery = SQLParser.getSqlQuery("sel_financeid^"+appno);
				ResultSet rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					//strFinID=Helper.correctNull((String)rs.getString("DEMO_FINSTANDARD"));
					/*if(!strFinID.equals("")) {
						strQuery = SQLParser.getSqlQuery("fin_cmano_select^"+strFinID);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next()) {
							cma = Helper.correctNull((String)rs.getString("FIN_CMANO"));
						}
					}*/
				//}*/
				strcommenttype=(String)hsh.get("sel_commentstype");
				pagetype=(String)hsh.get("hidPage");
				comments=(String)hsh.get("txt_comments");
				
				if (strAction.trim().equals("insert")) 
				{
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId","del_financial_comments");
					arrValues.add(appno);
					arrValues.add(pagetype);
					arrValues.add(strcommenttype);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					
					hshQuery = new HashMap();
					hshQueryValues.put("size", "2");
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_financial_comments");
					arrValues.add(appno);
					arrValues.add(strcommenttype);
					arrValues.add(comments);
					arrValues.add(pagetype);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("2", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				else if(strAction.trim().equals("delete"))
				{
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","del_financial_comments");
					arrValues.add(appno);
					arrValues.add(pagetype);
					arrValues.add(strcommenttype);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					
					if(pagetype.equalsIgnoreCase("MangementInfo")||pagetype.equalsIgnoreCase("assmntcomments")||pagetype.equalsIgnoreCase("salesjustify"))
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size","2");
						hshQuery.put("strQueryId","del_management_assementAll");
						arrValues.add(pagetype);
						arrValues.add(strcommenttype);
						arrValues.add(appno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("2", hshQuery);
					}
					
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				
				if(strAction.equalsIgnoreCase("insert") && ((pagetype.equalsIgnoreCase("MangementInfo") && 
						(strcommenttype.equalsIgnoreCase("5")||strcommenttype.equalsIgnoreCase("6")||strcommenttype.equalsIgnoreCase("15")))
						|| (pagetype.equalsIgnoreCase("assmntcomments") && strcommenttype.equalsIgnoreCase("15"))
						|| (pagetype.equalsIgnoreCase("salesjustify") && (strcommenttype.equalsIgnoreCase("2")||strcommenttype.equalsIgnoreCase("1")))))
				{
					int intsize=0;
					hshQueryValues = new HashMap();
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "del_management_assementAll");
					arrValues.add(pagetype);
					arrValues.add(strcommenttype);
					arrValues.add(appno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size",String.valueOf(++intsize));					
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
					
					
					if(pagetype.equalsIgnoreCase("MangementInfo") &&  (strcommenttype.equalsIgnoreCase("5")||strcommenttype.equalsIgnoreCase("6")))
					{
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					if(hsh.get("txt_domestic") instanceof String[])
					{
						String strDomestic[]=(String[])hsh.get("txt_domestic");
						String strDomesticPlace[]=(String[])hsh.get("txt_domesticplace");
						String strOverseas[]=(String[])hsh.get("txt_overseas");
						String strOverseasPlace[]=(String[])hsh.get("txt_overseasplace");
						for(int i=0;i<strDomestic.length;i++)
						{
							++intsize;
							hshQuery=new HashMap();
							arrValues = new ArrayList();
							arrValues.add(appno);
							arrValues.add(strcommenttype);
							arrValues.add(String.valueOf(i+1));
							arrValues.add(strDomestic[i]);
							arrValues.add(strDomesticPlace[i]);
							arrValues.add("MangementInfo");
							arrValues.add(strOverseas[i]);
							arrValues.add(strOverseasPlace[i]);
							arrValues.add("");
							arrValues.add("");
							hshQuery.put("arrValues", arrValues);
							hshQuery.put("strQueryId", "ins_management_assement");
							hshQueryValues.put("size",String.valueOf(intsize));					
							hshQueryValues.put(String.valueOf(intsize),hshQuery);
						}
					}
					else if(!Helper.correctNull((String)hsh.get("txt_domestic")).equalsIgnoreCase("")||!Helper.correctNull((String)hsh.get("txt_domesticplace")).equalsIgnoreCase("")
							||!Helper.correctNull((String)hsh.get("txt_overseas")).equalsIgnoreCase("")||!Helper.correctNull((String)hsh.get("txt_overseasplace")).equalsIgnoreCase(""))
					{
						++intsize;
						hshQuery=new HashMap();
						arrValues = new ArrayList();
						arrValues.add(appno);
						arrValues.add(strcommenttype);
						arrValues.add("1");
						arrValues.add(Helper.correctNull((String)hsh.get("txt_domestic")));
						arrValues.add(Helper.correctNull((String)hsh.get("txt_domesticplace")));
						arrValues.add("MangementInfo");
						arrValues.add(Helper.correctNull((String)hsh.get("txt_overseas")));
						arrValues.add(Helper.correctNull((String)hsh.get("txt_overseasplace")));
						arrValues.add("");
						arrValues.add("");
						hshQuery.put("arrValues", arrValues);
						hshQuery.put("strQueryId", "ins_management_assement");
						hshQueryValues.put("size",String.valueOf(intsize));					
						hshQueryValues.put(String.valueOf(intsize),hshQuery);
				}
					}
					else if(pagetype.equalsIgnoreCase("MangementInfo") &&  strcommenttype.equalsIgnoreCase("15"))
					{
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					if(hsh.get("txt_name") instanceof String[])
					{
						String strName[]=(String[])hsh.get("txt_name");
						String strAge[]=(String[])hsh.get("txt_age");
						String strQuali[]=(String[])hsh.get("txt_qualification");
						String strExpenses[]=(String[])hsh.get("txt_experience");
						for(int i=0;i<strName.length;i++)
						{
							++intsize;
							hshQuery=new HashMap();
							arrValues = new ArrayList();
							arrValues.add(appno);
							arrValues.add(strcommenttype);
							arrValues.add(String.valueOf(i+1));
							arrValues.add(strName[i]);
							arrValues.add(strAge[i]);
							arrValues.add("MangementInfo");
							arrValues.add(strQuali[i]);
							arrValues.add(strExpenses[i]);
							arrValues.add("");
							arrValues.add("");
							hshQuery.put("arrValues", arrValues);
							hshQuery.put("strQueryId", "ins_management_assement");
							hshQueryValues.put("size",String.valueOf(intsize));					
							hshQueryValues.put(String.valueOf(intsize),hshQuery);
						}
					}
					else if(!Helper.correctNull((String)hsh.get("txt_name")).equalsIgnoreCase("")||!Helper.correctNull((String)hsh.get("txt_age")).equalsIgnoreCase("")
							||!Helper.correctNull((String)hsh.get("txt_qualification")).equalsIgnoreCase("")||!Helper.correctNull((String)hsh.get("txt_experience")).equalsIgnoreCase(""))
					{
						++intsize;
						hshQuery=new HashMap();
						arrValues = new ArrayList();
						arrValues.add(appno);
						arrValues.add(strcommenttype);
						arrValues.add("1");
						arrValues.add(Helper.correctNull((String)hsh.get("txt_name")));
						arrValues.add(Helper.correctNull((String)hsh.get("txt_age")));
						arrValues.add("MangementInfo");
						arrValues.add(Helper.correctNull((String)hsh.get("txt_qualification")));
						arrValues.add(Helper.correctNull((String)hsh.get("txt_experience")));
						arrValues.add("");
						arrValues.add("");
						hshQuery.put("arrValues", arrValues);
						hshQuery.put("strQueryId", "ins_management_assement");
						hshQueryValues.put("size",String.valueOf(intsize));					
						hshQueryValues.put(String.valueOf(intsize),hshQuery);
				}
					}
					else if(pagetype.equalsIgnoreCase("salesjustify") &&  (strcommenttype.equalsIgnoreCase("2")||strcommenttype.equalsIgnoreCase("1")))
					{
						if(strcommenttype.equalsIgnoreCase("2"))
						{
							String strParticulars[]=(String[])hsh.get("txt_desc");
							String strEstimated[]=(String[])hsh.get("txt_estimated");
							String strAccepted[]=(String[])hsh.get("txt_accepted");
							for(int i=0;i<strParticulars.length;i++)
							{
								++intsize;
								hshQuery=new HashMap();
								arrValues = new ArrayList();
								arrValues.add(appno);
								arrValues.add(strcommenttype);
								arrValues.add(String.valueOf(i+1));
								arrValues.add(strParticulars[i]);
								arrValues.add(strEstimated[i]);
								arrValues.add("salesjustify");
								arrValues.add(strAccepted[i]);
								arrValues.add(Helper.correctNull((String)hsh.get("txt_yearfrom"))+"-"+Helper.correctNull((String)hsh.get("txt_yearto")));
								arrValues.add("");
								arrValues.add("");
								hshQuery.put("arrValues", arrValues);
								hshQuery.put("strQueryId", "ins_management_assement");
								hshQueryValues.put("size",String.valueOf(intsize));					
								hshQueryValues.put(String.valueOf(intsize),hshQuery);
							}
							
							String strParticulars1[]=(String[])hsh.get("txt_ndesc");
							String strEstimated1[]=(String[])hsh.get("txt_nestimated");
							String strAccepted1[]=(String[])hsh.get("txt_naccepted");
							for(int i=0;i<strParticulars.length;i++)
							{
								++intsize;
								hshQuery=new HashMap();
								arrValues = new ArrayList();
								arrValues.add(appno);
								arrValues.add(strcommenttype);
								arrValues.add(String.valueOf(i+1));
								arrValues.add(strParticulars1[i]);
								arrValues.add(strEstimated1[i]);
								arrValues.add("salesjustify");
								arrValues.add(strAccepted1[i]);
								arrValues.add(Helper.correctNull((String)hsh.get("txt_nyearfrom"))+"-"+Helper.correctNull((String)hsh.get("txt_nyearto")));
								arrValues.add("");
								arrValues.add("");
								hshQuery.put("arrValues", arrValues);
								hshQuery.put("strQueryId", "ins_management_assement");
								hshQueryValues.put("size",String.valueOf(intsize));					
								hshQueryValues.put(String.valueOf(intsize),hshQuery);
							}
							String strParticulars2[]=(String[])hsh.get("txt_IINdesc");
							String strEstimated2[]=(String[])hsh.get("txt_IINestimated");
							String strAccepted2[]=(String[])hsh.get("txt_IINaccepted");
							for(int i=0;i<strParticulars.length;i++)
							{
								++intsize;
								hshQuery=new HashMap();
								arrValues = new ArrayList();
								arrValues.add(appno);
								arrValues.add(strcommenttype);
								arrValues.add(String.valueOf(i+1));
								arrValues.add(strParticulars2[i]);
								arrValues.add(strEstimated2[i]);
								arrValues.add("salesjustify");
								arrValues.add(strAccepted2[i]);
								arrValues.add(Helper.correctNull((String)hsh.get("txt_IINyearfrom"))+"-"+Helper.correctNull((String)hsh.get("txt_IINyearto")));
								arrValues.add("");
								arrValues.add("");
								hshQuery.put("arrValues", arrValues);
								hshQuery.put("strQueryId", "ins_management_assement");
								hshQueryValues.put("size",String.valueOf(intsize));					
								hshQueryValues.put(String.valueOf(intsize),hshQuery);
							}
						}
						else if(strcommenttype.equalsIgnoreCase("1"))
						{
							if(Integer.parseInt(Helper.correctInt((String)hsh.get("hidRowSize")))>=1){
								
								arrValues = new ArrayList();
								hshQuery = new HashMap();
								if(hsh.get("txt_year") instanceof String[])
								{
									String strDomestic[]=(String[])hsh.get("txt_year");
									String strDomesticPlace[]=(String[])hsh.get("txt_proj");
									String strOverseas[]=(String[])hsh.get("txt_actual");
									String strOverseasPlace[]=(String[])hsh.get("txt_achievement");
									String strGrowth[]=(String[])hsh.get("txt_growth");
									for(int i=0;i<strDomestic.length;i++)
									{
										++intsize;
										hshQuery=new HashMap();
										arrValues = new ArrayList();
										arrValues.add(appno);
										arrValues.add(strcommenttype);
										arrValues.add(String.valueOf(i+1));
										arrValues.add(strDomestic[i]);
										arrValues.add(strDomesticPlace[i]);
										arrValues.add("salesjustify");
										arrValues.add(strOverseas[i]);
										arrValues.add(strOverseasPlace[i]);
										arrValues.add(strGrowth[i]);
										arrValues.add("");
										hshQuery.put("arrValues", arrValues);
										hshQuery.put("strQueryId", "ins_management_assement");
										hshQueryValues.put("size",String.valueOf(intsize));					
										hshQueryValues.put(String.valueOf(intsize),hshQuery);
									}
								}
								else if(!Helper.correctNull((String)hsh.get("txt_year")).equalsIgnoreCase(""))
								{
									++intsize;
									hshQuery=new HashMap();
									arrValues = new ArrayList();
									arrValues.add(appno);
									arrValues.add(strcommenttype);
									arrValues.add("1");
									arrValues.add(Helper.correctNull((String)hsh.get("txt_year")));
									arrValues.add(Helper.correctNull((String)hsh.get("txt_proj")));
									arrValues.add("salesjustify");
									arrValues.add(Helper.correctNull((String)hsh.get("txt_actual")));
									arrValues.add(Helper.correctNull((String)hsh.get("txt_achievement")));
									arrValues.add(Helper.correctNull((String)hsh.get("txt_growth")));
									arrValues.add("");
									hshQuery.put("arrValues", arrValues);
									hshQuery.put("strQueryId", "ins_management_assement");
									hshQueryValues.put("size",String.valueOf(intsize));					
									hshQueryValues.put(String.valueOf(intsize),hshQuery);
							}
								
								
							}
							
						}
					}
					else
					{
						String strParticulars[]=(String[])hsh.get("txt_desc");
						String strAmount[]=(String[])hsh.get("txt_amt");
						for(int i=0;i<strParticulars.length;i++)
						{
							++intsize;
							hshQuery=new HashMap();
							arrValues = new ArrayList();
							arrValues.add(appno);
							arrValues.add(strcommenttype);
							arrValues.add(String.valueOf(i+1));
							arrValues.add(strParticulars[i]);
							arrValues.add(strAmount[i]);
							arrValues.add(pagetype);
							arrValues.add("");
							arrValues.add("");
							arrValues.add("");
							arrValues.add("");
							hshQuery.put("arrValues", arrValues);
							hshQuery.put("strQueryId", "ins_management_assement");
							hshQueryValues.put("size",String.valueOf(intsize));					
							hshQueryValues.put(String.valueOf(intsize),hshQuery);
						}
					}
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
				
				if(strAction.equalsIgnoreCase("insert") && ((pagetype.equalsIgnoreCase("MangementInfo") &&  (strcommenttype.equalsIgnoreCase("17")))))
				{
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","upd_managementcomments");
					arrValues.add(Helper.correctNull((String)hsh.get("sel_constitchanges")));
					if(Helper.correctNull((String)hsh.get("sel_constitchanges")).equalsIgnoreCase("Y"))
						arrValues.add(Helper.correctNull((String)hsh.get("txt_comments")));
					else
						arrValues.add("");
					arrValues.add(appno);
					arrValues.add(strcommenttype);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
		}
		
	
		
		finally
		{
			try
			{
				
				/*if(rs != null)
				{
					rs.close();
				}
				*/

			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
		
		
	}



public HashMap getFinancialComments(HashMap hsh) 
	{
		
		String strQuery="";
		ResultSet rs=null;
		ResultSet rs1=null;
		HashMap hshValues = new HashMap();
		String strAppno="",strpage="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		try
			{
				strAppno =correctNull((String) hsh.get("appno"));
				
				String strsel =Helper.correctInt((String) hsh.get("sel_commentstype"));
				strpage=Helper.correctNull((String) hsh.get("hidPage"));
				//Added by Kishan
				/*String strFinID = "0";
				strQuery = SQLParser.getSqlQuery("sel_financeid^"+strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
					strFinID=Helper.correctNull((String)rs.getString("DEMO_FINSTANDARD"));
				
			*/
				if(!strpage.equalsIgnoreCase("")&& !strsel.equalsIgnoreCase(""))
				{
					strQuery=SQLParser.getSqlQuery("sel_financial_comments^"+strpage+"^"+strsel+"^"+strAppno);
					rs1=DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						hshValues.put("selcoment",Helper.correctNull((String)rs1.getString("COM_SNO")));
						hshValues.put("comments",Helper.CLOBToString(rs1.getClob("com_comments")));
						hshValues.put("COM_CHANGECONST",Helper.correctNull((String)rs1.getString("COM_CHANGECONST")));
					}	
					
					if(strpage.equalsIgnoreCase("MangementInfo") && (strsel.equalsIgnoreCase("5")||strsel.equalsIgnoreCase("6")||strsel.equalsIgnoreCase("15"))){
						 if (rs != null) {
								rs.close();
							}//s.no-->facilityNo
						rs = DBUtils.executeLAPSQuery("sel_management_Assement^MangementInfo^"+strsel+"^"+strAppno);
						while(rs.next()){
							arrCol=new ArrayList();
							arrCol.add(Helper.correctNull(rs.getString("ASSEMENT_SNO")));//0
							arrCol.add(Helper.correctNull(rs.getString("ASSEMENT_COMMENT")));//1
							arrCol.add(Helper.correctNull(rs.getString("ASSEMENT_COMMENT1")));//2
							arrCol.add(Helper.correctNull(rs.getString("ASSEMENT_PAGETYPE")));//3
							arrCol.add(Helper.correctNull(rs.getString("ASSEMENT_FNO")));//4
							arrCol.add(Helper.correctNull(rs.getString("assess_comments2")));//5
							arrCol.add(Helper.correctNull(rs.getString("assess_comments3")));//6
							arrRow.add(arrCol);
						}
					}
					else if(strpage.equalsIgnoreCase("assmntcomments") && strsel.equalsIgnoreCase("15")){
						 if (rs != null) {
								rs.close();
							}//s.no-->facilityNo
						rs = DBUtils.executeLAPSQuery("sel_management_Assement^assmntcomments^"+strsel+"^"+strAppno);
						while(rs.next()){
							hshValues.put("strComments"+Helper.correctNull(rs.getString("ASSEMENT_COMMENT")),Helper.correctNull(rs.getString("ASSEMENT_COMMENT1")));
						}
					}
					else if(strpage.equalsIgnoreCase("salesjustify") && strsel.equalsIgnoreCase("1")){
						
						ArrayList arrSalesAct=new ArrayList();
						ArrayList arrSalesProj=new ArrayList();
						ArrayList arrYear=new ArrayList();
						ArrayList arrGrowth=new ArrayList();
						ArrayList arrAchievement=new ArrayList();
						
						boolean bflag=true;
						
						if (rs != null) {
							rs.close();
						}
					rs = DBUtils.executeLAPSQuery("sel_management_Assement^salesjustify^"+strsel+"^"+strAppno);
					while(rs.next()){
						bflag=false;
						arrSalesAct.add(Helper.correctNull(rs.getString("ASSESS_COMMENTS2")));
						arrSalesProj.add(Helper.correctNull(rs.getString("ASSEMENT_COMMENT1")));
						arrYear.add(Helper.correctNull(rs.getString("ASSEMENT_COMMENT")));
						arrGrowth.add(Helper.correctNull(rs.getString("ASSESS_COMMENT4")));
						arrAchievement.add(Helper.correctNull(rs.getString("ASSESS_COMMENTS3")));
					}
					
					if(bflag)
						{
						String strFinID = "0";
						String cma = "0";
						rs = DBUtils.executeLAPSQuery("sel_financeid^" + strAppno);
						if (rs.next()) {
							strFinID = Helper.correctNull((String) rs
									.getString("DEMO_FINSTANDARD"));
							if (!strFinID.equals("")) {
								if(rs!=null)
									rs.close();
								
								rs = DBUtils.executeLAPSQuery("fin_cmano_select^"
										+ strFinID);
								if (rs.next()) {
									cma = Helper.correctNull((String) rs
											.getString("FIN_CMANO"));
								}
								
							}
						}
						
						int i=0;
						if(rs!=null)
							rs.close();
						
						strQuery = SQLParser.getSqlQuery("com_finappvalues_audit_select^"
								+ strFinID + "^<=^<");
						rs = DBUtils.executeQuery(strQuery);
						while (rs.next()) 
						{
							if(i<=3)
							{
								if(rs1!=null)
									rs1.close();
								
								strQuery = SQLParser.getSqlQuery("sel_financial_saleval^"
										+ strFinID + "^"+Helper.correctNull(rs.getString("audityear"))+"^"+cma);
								rs1 = DBUtils.executeQuery(strQuery);
								if (rs1.next()) 
								{
									arrSalesAct.add(Helper.correctNull(rs1.getString("auditval")));
								}
								else
								{
									arrSalesAct.add("0");
								}
								arrYear.add(Helper.correctNull(rs.getString("audityear")));
								arrGrowth.add("");
								arrAchievement.add("");
								arrSalesProj.add("");
								i++;
							}
							
						}
						}
					
					hshValues.put("arrYear",arrYear);
					hshValues.put("arrGrowth",arrGrowth);
					hshValues.put("arrAchievement",arrAchievement);
					hshValues.put("arrSalesProj",arrSalesProj);
					hshValues.put("arrSalesAct",arrSalesAct);
						
						
					}
					else if(strpage.equalsIgnoreCase("salesjustify") && strsel.equalsIgnoreCase("2")){
						
						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeLAPSQuery("sel_management_Assement^salesjustify^"+strsel+"^"+strAppno);
						while(rs.next())
						{
							String[] strArr=Helper.correctNull(rs.getString("assess_comments3")).split("-");
							if(strArr!=null && strArr.length>1)
							{
								if(Helper.correctNull(rs.getString("ASSEMENT_COMMENT")).equalsIgnoreCase("CEXPORT"))
								{
									hshValues.put("strCYearFrom",strArr[0]);
									hshValues.put("strCYearTo",strArr[1]);
								}
								else if(Helper.correctNull(rs.getString("ASSEMENT_COMMENT")).equalsIgnoreCase("NEXPORT"))
								{
									hshValues.put("strNYearFrom",strArr[0]);
									hshValues.put("strNYearTo",strArr[1]);
								}
								else if(Helper.correctNull(rs.getString("ASSEMENT_COMMENT")).equalsIgnoreCase("IINEXPORT"))
								{
									hshValues.put("strIINYearFrom",strArr[0]);
									hshValues.put("strIINYearTo",strArr[1]);
								}
							}
							
							hshValues.put("strEstimated"+Helper.correctNull(rs.getString("ASSEMENT_COMMENT")),Helper.correctNull(rs.getString("ASSEMENT_COMMENT1")));
							hshValues.put("strAccepted"+Helper.correctNull(rs.getString("ASSEMENT_COMMENT")),Helper.correctNull(rs.getString("assess_comments2")));
						}
						
					}
				}
				hshValues.put("selcoment",strsel);
				
				
				hshValues.put("arrRow",arrRow);
				
				String strFinID="0",strValuesin="";
				rs = DBUtils.executeLAPSQuery("sel_financeid^" + strAppno);
				if (rs.next()) {
					strFinID = Helper.correctInt((String) rs
							.getString("DEMO_FINSTANDARD"));
				}
				if (!strFinID.equals("0")) {
					rs = DBUtils.executeLAPSQuery("fin_cmano_select^" + strFinID);
					if (rs.next()) {
						strValuesin = Helper.correctNull((String) rs
								.getString("fin_valuesarein"));
					}
				}
				if(strValuesin.equalsIgnoreCase("C"))
				{
					hshValues.put("strValuesin", "Crore");
				}
				else if(strValuesin.equalsIgnoreCase("L"))
				{
					hshValues.put("strValuesin", "Lacs");
				}else{
					hshValues.put("strValuesin", "Rupees");
				}
			}
		
		catch (Exception e)
			{
			log.error("error occured"+e.toString());
			}

			finally
			{
				try
				{
					if(rs!= null)
					{
						rs.close();
					}
				
				}
				catch (Exception e1)
				{
					log.error("error occured"+e1.toString());
				}
			}
			return hshValues;
	}

	
	public void updatecom_Rbiloanpolicyguidedata(HashMap hshValues)  
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		
		String [] strtxt_asdate=null;
		String [] strhidtype=null;
		String [] strtxt_comments=null;
		String [] strtxt_Compliance=null; 
		String [] strtxt_ProcessnotCmts=null;
		String [] strConductedBy=null;
		
		
		String strAction =Helper.correctNull((String) hshValues.get("hidAction"));
		String strappno =null;
		String strMaxId=null;
		String strQuery=null;
		ResultSet rs = null;
		
		try {
			strappno =Helper.correctNull((String) hshValues.get("appno"));
			strtxt_asdate=(String [])hshValues.get ("txt_asdate");
			
			strhidtype=(String [])hshValues.get("hidtype");
			strtxt_comments=(String [])hshValues.get("txt_comments");
			strtxt_Compliance=(String [])hshValues.get("txt_cCompliance");
			strtxt_ProcessnotCmts=(String [])hshValues.get("txt_processnotecmts");
			strConductedBy=(String [])hshValues.get("txt_conductedby");
			
			
			if ((strAction.trim().equals("update"))||(strAction.trim().equals("delete"))) 
			{
				hshQueryValues=new HashMap();	
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","delcom_Rbiloanpolicyguide");
				arrValues.add(strappno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
			


		if (strAction.trim().equals("update"))
			{
			for(int i=0;i<8;i++)
			{
				
				strQuery = SQLParser.getSqlQuery("max_com_Rbiloanpolicyguide^"+strappno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strMaxId=Helper.correctNull(rs.getString("maxid"));
				}
				
			hshQuery = new HashMap();
			
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "inscom_Rbiloanpolicyguide");
			arrValues.add(strappno);
			arrValues.add(strMaxId);
			
			arrValues.add(Helper.correctNull(strhidtype[i]));
			arrValues.add(Helper.correctNull(strtxt_asdate[i]));
			arrValues.add(Helper.correctNull(strtxt_comments[i]));
			arrValues.add(Helper.correctNull(strtxt_Compliance[i]));
			arrValues.add(Helper.correctNull(strtxt_ProcessnotCmts[i]));
			arrValues.add(Helper.correctNull(strConductedBy[i]));
		
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("size", "1");
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
			}
			
			}
			
		
		
	}
	catch (Exception ce) {
		throw new EJBException("inside update" + ce.toString());
	} 
	
	}
	
	
	public HashMap getcom_Rbiloanpolicyguidedata(HashMap hshValues)  
	{
		String strQuery = "";
		String strFacilitySno="";
		ResultSet rs = null,rs1 = null;
		HashMap hshRecord = new HashMap();
		String strAppno=null;
		String strpagef=null;
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		
	try {
			
			strAppno = correctNull((String) hshValues.get("appno"));
			strQuery = SQLParser.getSqlQuery("selcom_Rbiloanpolicyguide^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			
			
			while(rs.next()) 
			{
				strpagef=Helper.correctNull(rs.getString("comrbi_pagetype"));
				hshRecord.put("COMRBI_ASDATE"+strpagef,correctNull(rs.getString("COMRBI_ASDATE")));
				hshRecord.put("COMRBI_COMMENTS"+strpagef,Helper.CLOBToString(rs.getClob("COMRBI_COMMENTS")));
				hshRecord.put("COMRBI_COMPLIANCE"+strpagef,Helper.CLOBToString(rs.getClob("COMRBI_COMPLIANCE")));
				hshRecord.put("COMRBI_CMDPROCESS"+strpagef,Helper.CLOBToString(rs.getClob("COMRBI_CMDPROCESS")));
				hshRecord.put("COM_AUDITCONDUCTEDBY"+strpagef,correctNull(rs.getString("com_auditconductedby")));
				
				
			}
			
			
				
			}
			
		
	
	catch (Exception ce) {
		throw new EJBException("inside update" + ce.toString());
	}
	return hshRecord;

}
	
	public void updatecom_Rbicommentsdata(HashMap hshValues)  
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		String strAction =Helper.correctNull((String) hshValues.get("hidAction"));
		String strappno=null;
		String pagename=null;//"RBICOM";
		String strQuery="";
		ResultSet rs = null;
		String strMaxId=null;


		try {
			pagename=Helper.correctNull((String) hshValues.get("hidpagetype"));
			strappno =Helper.correctNull((String) hshValues.get("appno"));
			String exec_summ_company =Helper.correctNull((String) hshValues.get("exec_summ_company"));
			String strsessionModuleType=Helper.correctNull((String)hshValues.get("sessionModuleType"));


			if(pagename.equalsIgnoreCase("RBICOM")&& (strsessionModuleType.equalsIgnoreCase("AGR")||strsessionModuleType.equalsIgnoreCase("CORP")))
			{
				if ((strAction.trim().equals("update"))||(strAction.trim().equals("delete"))) 
				{
					hshQueryValues=new HashMap();	
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","del_comcomments");
					arrValues.add(pagename);
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_option")));
					arrValues.add(strappno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					
					if(Helper.correctNull((String)hshValues.get("sel_option")).equalsIgnoreCase("3"))
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size","2");
						hshQuery.put("strQueryId","delcom_cust_profit");
						arrValues.add(strappno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("2",hshQuery);

						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size","3");
						hshQuery.put("strQueryId","del_com_ftp_breakupoflimits");
						arrValues.add(strappno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("3",hshQuery);
						hshQueryValues.put("size","3");
					}
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}

				if (strAction.trim().equals("update"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","ins_comments");
					arrValues.add(strappno);
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_option")));
					arrValues.add(exec_summ_company);
					arrValues.add(pagename);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size","1");
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				
				if(Helper.correctNull((String)hshValues.get("sel_option")).equalsIgnoreCase("3"))
				{
					String [] strFromYear=null;
					String [] strToYear=null;
					String [] strFTPPL=null; 
					String [] strFTPYield=null;
					String [] strRORAC=null;

					String [] strDesc=null;
					String [] strAmt=null;


					hshQueryValues=new HashMap();	
					int intSize=0;
					if(hshValues.get("txt_fromyear") instanceof java.lang.String)
					{
						if(!Helper.correctNull((String)hshValues.get("txt_fromyear")).equalsIgnoreCase(""))
						{
							hshQuery = new HashMap();
							++intSize;
							arrValues = new ArrayList();
							hshQuery.put("strQueryId", "inscom_cust_profit");
							arrValues.add(strappno);
							arrValues.add(String.valueOf(intSize));
							
							arrValues.add(Helper.correctNull((String)hshValues.get("txt_fromyear")));
							arrValues.add(Helper.correctNull((String)hshValues.get("txt_toyear")));
							arrValues.add(Helper.correctNull((String)hshValues.get("txt_ftppl")));
							arrValues.add(Helper.correctNull((String)hshValues.get("txt_ftpyield")));
							arrValues.add(Helper.correctNull((String)hshValues.get("txt_rorac")));
						
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", String.valueOf(intSize));
							hshQueryValues.put(String.valueOf(intSize), hshQuery);
						}
					}
					else
					{
						strFromYear=(String [])hshValues.get("txt_fromyear");
						strToYear=(String [])hshValues.get("txt_toyear");
						strFTPPL=(String [])hshValues.get("txt_ftppl");
						strFTPYield=(String [])hshValues.get("txt_ftpyield");
						strRORAC=(String [])hshValues.get("txt_rorac");
						
						for(int i=0;i<strFromYear.length;i++)
						{
							if(!strFromYear[i].equalsIgnoreCase(""))
							{
								hshQuery = new HashMap();
								++intSize;
								arrValues = new ArrayList();
								hshQuery.put("strQueryId", "inscom_cust_profit");
								arrValues.add(strappno);
								arrValues.add(String.valueOf(intSize));
								
								arrValues.add(Helper.correctNull(strFromYear[i]));
								arrValues.add(Helper.correctNull(strToYear[i]));
								arrValues.add(Helper.correctNull(strFTPPL[i]));
								arrValues.add(Helper.correctNull(strFTPYield[i]));
								arrValues.add(Helper.correctNull(strRORAC[i]));
							
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", String.valueOf(intSize));
								hshQueryValues.put(String.valueOf(intSize), hshQuery);
							}
						}
					}


					strDesc=(String [])hshValues.get("txt_desc");
					strAmt=(String [])hshValues.get("txt_amt");

					for(int i=0;i<strDesc.length;i++)
					{
							hshQuery = new HashMap();
							++intSize;
							arrValues = new ArrayList();
							hshQuery.put("strQueryId", "ins_com_ftp_breakupoflimits");
							arrValues.add(strappno);
							arrValues.add(String.valueOf(intSize));
							
							arrValues.add(Helper.correctNull(strDesc[i]));
							arrValues.add(Helper.correctNull(strAmt[i]));
						
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", String.valueOf(intSize));
							hshQueryValues.put(String.valueOf(intSize), hshQuery);
					}

					if(intSize>0)
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				}
			}
			else
			{
				if ((strAction.trim().equals("update"))||(strAction.trim().equals("delete")))
				{
					hshQueryValues=new HashMap();	
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","del_com_comments");
					arrValues.add(pagename);
					arrValues.add(strappno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}

				if (strAction.trim().equals("update"))
				{
					strQuery = SQLParser.getSqlQuery("max_com_comments^"+" "+"^"+strappno);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strMaxId=Helper.correctNull(rs.getString("maxid"));
					}

					hshQuery = new HashMap();

					arrValues = new ArrayList();
					hshQuery.put("strQueryId","ins_com_comments");
					arrValues.add(strappno);
					arrValues.add(strMaxId);

					arrValues.add(exec_summ_company);
					arrValues.add(pagename);


					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size","1");
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

				}
			}





		}
		catch (Exception ce) {
			throw new EJBException("inside update" + ce.toString());
		} 




	}
	public HashMap getcom_Rbicommentsdata(HashMap hshValues)  
	{
		String pagename="RBICOM";
		String strQuery = "";
		String strFacilitySno="",sessionModuleType="";
		ResultSet rs = null,rs1 = null;
		HashMap hshRecord = new HashMap();
		String strAppno=null;
		String strpagef=null;
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		
	try {
			//pagename=Helper.correctNull((String) hshValues.get("hidpagetype"));
			strAppno = correctNull((String) hshValues.get("appno"));
			sessionModuleType=correctNull((String)hshValues.get("sessionModuleType"));
			
			if(pagename.equalsIgnoreCase("RBICOM") && (sessionModuleType.equalsIgnoreCase("CORP")||sessionModuleType.equalsIgnoreCase("AGR")) )
			{
				strQuery = SQLParser.getSqlQuery("sel_comcomments^"+pagename+"^"+Helper.correctNull((String)hshValues.get("sel_option"))+"^"+strAppno);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next()) 
				{
					hshRecord.put("COM_COMMENTS",Helper.CLOBToString(rs.getClob("COM_COMMENTS")));
				}
				
				if(Helper.correctNull((String)hshValues.get("sel_option")).equalsIgnoreCase("3"))
				{
					if(rs!=null)
						rs.close();

					rs=DBUtils.executeLAPSQuery("selcom_cust_profit^"+strAppno);
					while(rs.next())
					{
						arrCol=new ArrayList();
						arrCol.add(Helper.correctNull(rs.getString("COM_YEARFROM")));
						arrCol.add(Helper.correctNull(rs.getString("COM_YEARTO")));
						arrCol.add(Helper.correctNull(rs.getString("COM_FTP_PROFIT")));
						arrCol.add(Helper.correctNull(rs.getString("COM_FTP_YIELD")));
						arrCol.add(Helper.correctNull(rs.getString("COM_RAROC")));
						arrRow.add(arrCol);
					}
					hshRecord.put("arrRow",arrRow);

					if(rs!=null)
						rs.close();

					rs=DBUtils.executeLAPSQuery("sel_com_ftp_breakupoflimits^"+strAppno);
					while(rs.next())
					{
						hshRecord.put("strAmt"+Helper.correctNull(rs.getString("COM_ftp_desc")),Helper.correctNull(rs.getString("COM_FTP_amount")));
					}
				}
				
				hshRecord.put("strOptVal",Helper.correctNull((String)hshValues.get("sel_option")));
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("sel_com_comments^"+pagename+"^"+strAppno);
				rs = DBUtils.executeQuery(strQuery);
				
				
				while(rs.next()) 
				{
					hshRecord.put("COM_SNO",Helper.correctNull(rs.getString("COM_SNO")));
					hshRecord.put("COM_COMMENTS",Helper.CLOBToString(rs.getClob("COM_COMMENTS")));
					hshRecord.put("COM_PAGE",Helper.correctNull(rs.getString("COM_PAGE")));
					
				}
			}
				
			}
			
		
	
	catch (Exception ce) {
		throw new EJBException("inside update" + ce.toString());
	}
	return hshRecord;
		
	}
	
	
	public void updatecom_nonfundloanlcdata(HashMap hshValues)  
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		String strAction =Helper.correctNull((String) hshValues.get("hidAction"));
		String strappno=null;
		String strQuery="";
		ResultSet rs = null;
		String strMaxId=null;
		
		String strpagetype=null;
		String strsno=null;
		
		try
		{
			strappno =Helper.correctNull((String) hshValues.get("appno"));
			strpagetype=Helper.correctNull((String)hshValues.get("sel_nonfund"));
			strsno=Helper.correctNull((String)hshValues.get("hidsno"));
			
         if ((strAction.trim().equalsIgnoreCase("update"))||(strAction.trim().equalsIgnoreCase("delete"))) 
         {  	hshQueryValues=new HashMap();	
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_com_nonfundloanlc");
				arrValues.add(strappno);
				arrValues.add(strpagetype);
				arrValues.add(strsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
         
         if (strAction.trim().equalsIgnoreCase("update"))
        	{
        	 if(strpagetype.equalsIgnoreCase("1"))
				{
        		hshQueryValues=new HashMap();	
 				hshQuery = new HashMap();
 				arrValues=new ArrayList();
 				hshQueryValues.put("size","1");
 				hshQuery.put("strQueryId","ins_com_nonfundloanlc");
 				arrValues.add(strappno);
 				arrValues.add(strsno);
 				arrValues.add(strpagetype);
 				arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcamt")));
 				arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcdpno")));
 				arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcdpamt")));
 				arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcdano")));
 				arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcdaamt")));
 				arrValues.add(Helper.correctNull((String) hshValues.get("txt_imlcdano")));
 				arrValues.add(Helper.correctNull((String) hshValues.get("txt_imlcdaamt")));
 				
 				arrValues.add(Helper.correctNull((String) hshValues.get("txt_imlcdpno")));
 				arrValues.add(Helper.correctNull((String) hshValues.get("txt_imlcdpamt")));
 				arrValues.add(Helper.correctNull((String) hshValues.get("txt_devano")));
 				arrValues.add(Helper.correctNull((String) hshValues.get("txt_devamt")));
 				arrValues.add(Helper.correctNull((String) hshValues.get("txt_occasionano")));
 				arrValues.add(Helper.correctNull((String) hshValues.get("txt_Commentslc")));
 				arrValues.add(Helper.correctNull((String) hshValues.get("sel_date1")));
 				arrValues.add(Helper.correctNull((String) hshValues.get("txt_CommentsPerformance")));
 				hshQuery.put("arrValues",arrValues);
 				hshQueryValues.put("1",hshQuery);
 				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
        	if(strpagetype.equalsIgnoreCase("4"))
			{
        		hshQueryValues=new HashMap();	
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","ins_com_nonfundloanlc");
				arrValues.add(strappno);
				arrValues.add(strsno);
				arrValues.add(strpagetype);
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcamt")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcdpno")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcdpamt")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcdano")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcdaamt")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_imlcdano")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_imlcdaamt")));
				
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_imlcdpno")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_imlcdpamt")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_devano")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_devamt")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_occasionano")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_Commentslc")));
				arrValues.add(Helper.correctNull((String) hshValues.get("sel_date1")));
 				arrValues.add(Helper.correctNull((String) hshValues.get("txt_CommentsPerformance")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
        	 if(strpagetype.equalsIgnoreCase("2"))
				{
					hshQueryValues=new HashMap();	
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","ins_com_nonfundloanlcl");
					arrValues.add(strappno);
					arrValues.add(strsno);
					arrValues.add(strpagetype);
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_bclamt")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcbuyersno")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcbuyersamt")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_nlcbuyersno")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_nlcbuyersamt")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_dvbuyersno")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_dvbuyersamt")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_sacremarks")));
					arrValues.add(Helper.correctNull((String) hshValues.get("sel_date2")));
	 				arrValues.add(Helper.correctNull((String) hshValues.get("txt_CommentsPerformancebc")));
	 				hshQuery.put("arrValues",arrValues);
	 				hshQueryValues.put("1",hshQuery);
	 				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				if(strpagetype.equalsIgnoreCase("3"))
				{
					hshQueryValues=new HashMap();	
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","ins_com_nonfundloanlc2");
					arrValues.add(strappno);
					arrValues.add(strsno);
					arrValues.add(strpagetype);
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_bglamt")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_gurissued")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_aggregateamt")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_guarantessno")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_totaamt")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_remarks")));
					arrValues.add(Helper.correctNull((String) hshValues.get("sel_date3")));
	 				arrValues.add(Helper.correctNull((String) hshValues.get("txt_CommentsPerformancebg")));
	 				hshQuery.put("arrValues",arrValues);
	 				hshQueryValues.put("1",hshQuery);
	 				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				
        	       	 
            }
         
         if (strAction.trim().equalsIgnoreCase("insert"))
     	  {
        	 strQuery = SQLParser.getSqlQuery("max_com_nonfundloanlc^"+strappno+"^"+strpagetype);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strMaxId=Helper.correctNull(rs.getString("maxid"));
				}
				
				if(strpagetype.equalsIgnoreCase("1"))
				{
				hshQueryValues=new HashMap();	
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","ins_com_nonfundloanlc");
				arrValues.add(strappno);
				arrValues.add(strMaxId);
				arrValues.add(strpagetype);
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcamt")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcdpno")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcdpamt")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcdano")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcdaamt")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_imlcdano")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_imlcdaamt")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_imlcdpno")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_imlcdpamt")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_devano")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_devamt")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_occasionano")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_Commentslc")));
				arrValues.add(Helper.correctNull((String) hshValues.get("sel_date1")));
 				arrValues.add(Helper.correctNull((String) hshValues.get("txt_CommentsPerformance")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				if(strpagetype.equalsIgnoreCase("4"))
				{
					hshQueryValues=new HashMap();	
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","ins_com_nonfundloanlc");
					arrValues.add(strappno);
					arrValues.add(strMaxId);
					arrValues.add(strpagetype);
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcamt")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcdpno")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcdpamt")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcdano")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcdaamt")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_imlcdano")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_imlcdaamt")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_imlcdpno")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_imlcdpamt")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_devano")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_devamt")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_occasionano")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_Commentslc")));
					arrValues.add(Helper.correctNull((String) hshValues.get("sel_date1")));
	 				arrValues.add(Helper.correctNull((String) hshValues.get("txt_CommentsPerformance")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				if(strpagetype.equalsIgnoreCase("2"))
				{
					hshQueryValues=new HashMap();	
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","ins_com_nonfundloanlcl");
					arrValues.add(strappno);
					arrValues.add(strMaxId);
					arrValues.add(strpagetype);
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_bclamt")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcbuyersno")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcbuyersamt")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_nlcbuyersno")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_nlcbuyersamt")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_dvbuyersno")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_dvbuyersamt")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_sacremarks")));
					arrValues.add(Helper.correctNull((String) hshValues.get("sel_date2")));
	 				arrValues.add(Helper.correctNull((String) hshValues.get("txt_CommentsPerformancebc")));
	 				hshQuery.put("arrValues",arrValues);
	 				hshQueryValues.put("1",hshQuery);
	 				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				if(strpagetype.equalsIgnoreCase("3"))
				{
					hshQueryValues=new HashMap();	
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","ins_com_nonfundloanlc2");
					arrValues.add(strappno);
					arrValues.add(strMaxId);
					arrValues.add(strpagetype);
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_bglamt")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_gurissued")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_aggregateamt")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_guarantessno")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_totaamt")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_remarks")));
					arrValues.add(Helper.correctNull((String) hshValues.get("sel_date3")));
	 				arrValues.add(Helper.correctNull((String) hshValues.get("txt_CommentsPerformancebg")));
	 				hshQuery.put("arrValues",arrValues);
	 				hshQueryValues.put("1",hshQuery);
	 				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				
     	       	 
         }
         
      	
		}
	
	catch (Exception ce) {
		throw new EJBException("inside update" + ce.toString());
	} 
	}
	
	public HashMap getcom_nonfundloanlcdata(HashMap hshValues)  
	{
		
		String strQuery = "";
		String strFacilitySno="";
		ResultSet rs = null,rs1 = null;
		HashMap hshRecord = new HashMap();
		String strAppno=null;
		String strpagef=null;
		String strpagetype=null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol= new ArrayList();
		
		ArrayList vecRow1 = new ArrayList();
		ArrayList vecCol1= new ArrayList();
		String pagetype=null;
		
try {
	
			strAppno = correctNull((String) hshValues.get("appno"));
			strpagetype=Helper.correctNull((String)hshValues.get("sel_nonfund"));
			strQuery = SQLParser.getSqlQuery("sel_com_nonfundloanlc^"+strAppno+"^"+strpagetype);
			rs = DBUtils.executeQuery(strQuery);
			
			
			while(rs.next()) 
			{
				vecCol= new ArrayList();
				vecCol.add(Helper.correctNull(rs.getString("COM_SNO")));//0
				vecCol.add(Helper.correctNull(rs.getString("COM_PAGETYPE")));//1
				vecCol.add(Helper.correctDouble(rs.getString("COM_SANCTIONEDAMT")));//2
				vecCol.add(Helper.correctNull(rs.getString("COM_INLANDLCDPNO")));//3
				vecCol.add(Helper.correctDouble(rs.getString("COM_INLANDLCDPAMT")));//4
				vecCol.add(Helper.correctNull(rs.getString("COM_INLANDLCDANO")));//5
				vecCol.add(Helper.correctDouble(rs.getString("COM_INLANDLCDAAMT")));//6
				vecCol.add(Helper.correctNull(rs.getString("COM_IMPORTLCDANO")));//7
				vecCol.add(Helper.correctDouble(rs.getString("COM_IMPORTLCDAAMT")));//8
				vecCol.add(Helper.correctNull(rs.getString("COM_IMPORTLCDPNO")));//9
				vecCol.add(Helper.correctDouble(rs.getString("COM_IMPORTLCDPAMT")));//10
				vecCol.add(Helper.correctNull(rs.getString("COM_DEVOLVEMENTNO")));//11
				vecCol.add(Helper.correctDouble(rs.getString("COM_DEVOLVEMENTAMT")));//12
				vecCol.add(Helper.correctNull(rs.getString("COM_PERMITTEDNO")));//13
				vecCol.add(Helper.replaceForJavaScriptString(Helper.CLOBToString(rs.getClob("COM_REMARK"))));//14
				vecCol.add(Helper.correctNull(rs.getString("COM_YEAR_SNO")));//15
				vecCol.add(Helper.replaceForJavaScriptString(Helper.CLOBToString(rs.getClob("COM_PERFOR_COMMENTS"))));//16
	
				vecRow.add(vecCol);
			}
			
			
			
	        hshRecord.put("vecRow",vecRow);
	        hshRecord.put("vecRow1",vecRow1);
	        
	        hshRecord.put("COM_PAGETYPE",strpagetype);
				
			}
			
		
	
	catch (Exception ce) {
		throw new EJBException("inside update" + ce.toString());
	}
	return hshRecord;
		
	}
	
	
	
	public HashMap getcom_Bankingdetacommentdata(HashMap hshValues)  
	{
		String pagename=null;//"RBICOM";
		String strQuery = "";
		String strFacilitySno="";
		ResultSet rs = null,rs1 = null;
		HashMap hshRecord = new HashMap();
		String strAppno=null;
		String strpagef=null;
		
	try {
			pagename=Helper.correctNull((String) hshValues.get("hidpagetype"));
			strAppno = correctNull((String) hshValues.get("appno"));
			strQuery = SQLParser.getSqlQuery("sel_com_comments^"+pagename+"^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			
			
			while(rs.next()) 
			{
				
				hshRecord.put("COM_SNO",Helper.correctNull(rs.getString("COM_SNO")));
				hshRecord.put("COM_COMMENTS",Helper.CLOBToString(rs.getClob("COM_COMMENTS")));
				hshRecord.put("COM_PAGE",Helper.correctNull(rs.getString("COM_PAGE")));
				
				
			}
				
			}
			
		
	
	catch (Exception ce) {
		throw new EJBException("inside update" + ce.toString());
	}
	return hshRecord;
		
	}
	
	public void updateSHGAssessment(HashMap hshValues) 
	{
		String strAppno="";
		String strAction="";
		HashMap hshqueryval = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues=new ArrayList();
		String strCategory = "";
		try{
			strAppno=correctNull((String)hshValues.get("appno"));
			strAction=correctNull((String)hshValues.get("hidAction"));			
			if(strAction.equals("insert"))
			{
				arrValues.add(strAppno);
				hshQuery.put("strQueryId","delshgassessment");
				hshQuery.put("arrValues",arrValues);
				hshqueryval.put("size","1");
				hshqueryval.put("1",hshQuery);				
				arrValues=new ArrayList();
				hshQuery=new HashMap();				
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hshValues.get("txt_amnreq")));
				arrValues.add(correctNull((String)hshValues.get("txt_corpsvalue")));
				arrValues.add(correctNull((String)hshValues.get("txt_recmamunt")));							
				hshQuery.put("strQueryId","insshgassessment");
				hshQuery.put("arrValues",arrValues);
				hshqueryval.put("size","2");
				hshqueryval.put("2",hshQuery);				
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			else if(strAction.equals("delete"))
			{
				arrValues.add(strAppno);
				hshQuery.put("strQueryId","delshgassessment");
				hshQuery.put("arrValues",arrValues);
				hshqueryval.put("size","1");
				hshqueryval.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			StringBuilder sbAt = new StringBuilder();
			if(strAction.equals("update"))
			{
				sbAt.append("Amount Requested =").append(correctNull((String) hshValues.get("txt_amnreq")));
				sbAt.append(" ~ Total value in corpus of the group").append(correctNull((String) hshValues.get("txt_corpsvalue")));
				sbAt.append(" ~ Loan Amount").append(correctNull((String) hshValues.get("txt_recmamunt")));			
			}
			AuditTrial.auditLog(hshValues,"209",strAppno,sbAt.toString());
		}catch(Exception ex)
		{
			throw new EJBException("Error in updateSHGAssessment :: " +ex.toString());
		}
		
	}
	
	
	public void updategroupcomments(HashMap hshValues) 
	{
		String strAppno="";
		String strAction="";
		HashMap hshqueryval = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues=new ArrayList();
		String strCategory = "",strAppid="",strComment="";
		int intupdsize=0;
		try{
			strAppno=correctNull((String)hshValues.get("appno"));
			strAppid=Helper.correctNull((String)hshValues.get("cho_promoter"));
			strComment=Helper.correctNull((String)hshValues.get("sel_commentstype"));
			strAction=correctNull((String)hshValues.get("hidAction"));			
			if(strAction.equals("insert"))
			{
				if(!strComment.equalsIgnoreCase("") && !strComment.equalsIgnoreCase("s"))
				{
					arrValues.add(strAppno);
					arrValues.add(strAppid);
					arrValues.add(strComment);
					hshQuery.put("strQueryId","del_GROUPCOMMENTS");
					hshQuery.put("arrValues",arrValues);
					hshqueryval.put(String.valueOf(++intupdsize),hshQuery);
				}
				
				arrValues=new ArrayList();
				hshQuery=new HashMap();				
				arrValues.add(strAppno);//0
				arrValues.add(strAppid);
				hshQuery.put("strQueryId","del_GROUPASSETS");
				hshQuery.put("arrValues",arrValues);
				hshqueryval.put(String.valueOf(++intupdsize),hshQuery);
				
				if(!strComment.equalsIgnoreCase("") && !strComment.equalsIgnoreCase("s"))
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();				
					arrValues.add(strAppno);//0
					arrValues.add(strAppid);
					arrValues.add(strComment);
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_comments")));//3
					hshQuery.put("strQueryId","ins_GROUPCOMMENTS");
					hshQuery.put("arrValues",arrValues);
					hshqueryval.put(String.valueOf(++intupdsize),hshQuery);
				}
				
				
				arrValues=new ArrayList();
				hshQuery=new HashMap();				
				arrValues.add(strAppno);//0
				arrValues.add(strAppid);
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_assetclass")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_assdate")));//3
				hshQuery.put("strQueryId","ins_GROUPASSETS");
				hshQuery.put("arrValues",arrValues);
				hshqueryval.put(String.valueOf(++intupdsize),hshQuery);
				
				hshqueryval.put("size",String.valueOf(intupdsize));
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			else if(strAction.equals("delete"))
			{
				if(!strComment.equalsIgnoreCase("") && !strComment.equalsIgnoreCase("s"))
				{
					arrValues.add(strAppno);
					arrValues.add(strAppid);
					arrValues.add(strComment);
					hshQuery.put("strQueryId","del_GROUPCOMMENTS");
					hshQuery.put("arrValues",arrValues);
					hshqueryval.put(String.valueOf(++intupdsize),hshQuery);
				}
				
				arrValues=new ArrayList();
				hshQuery=new HashMap();				
				arrValues.add(strAppno);//0
				arrValues.add(strAppid);
				hshQuery.put("strQueryId","del_GROUPASSETS");
				hshQuery.put("arrValues",arrValues);
				hshqueryval.put(String.valueOf(++intupdsize),hshQuery);
				hshqueryval.put("size",String.valueOf(intupdsize));
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			/*StringBuilder sbAt = new StringBuilder();
			if(strAction.equals("update"))
			{
				sbAt.append("Amount Requested =").append(correctNull((String) hshValues.get("txt_amnreq")));
				sbAt.append(" ~ Total value in corpus of the group").append(correctNull((String) hshValues.get("txt_corpsvalue")));
				sbAt.append(" ~ Loan Amount").append(correctNull((String) hshValues.get("txt_recmamunt")));			
			}
			AuditTrial.auditLog(hshValues,"209",strAppno,sbAt.toString());*/
		}catch(Exception ex)
		{
			throw new EJBException("Error in updategroupcomments :: " +ex.toString());
		}
		
	}
	
	
	public HashMap getSHGAssessment(HashMap hshValues) 
	{
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		HashMap hshRecord=new HashMap();
		String strAppno="";
		String strQuery="";
		ResultSet rs=null;
		boolean recordflag=false;
		String strAppIdNew="";
		double dbltotalA=Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_totalA")));
		if(dbltotalA==0.00)
		{
			dbltotalA=Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_corpsvalue")));
		}
		try{
			strAppno=correctNull((String)hshValues.get("appno"));
			rs=DBUtils.executeLAPSQuery("sellatestnewid^"+strAppno);
			if(rs.next())
			{
				strAppIdNew=Helper.correctNull((String)rs.getString("PERAPP_ID"));
			}
			if(rs!=null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("selshgassesmentdetailsNew^"+strAppIdNew+"^"+"SFM");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				//hshRecord.put("LOAN_AMTREQD",correctNull(rs.getString("LOAN_AMTREQD")));
				hshRecord.put("COMFIN_AMOUNT",correctNull(rs.getString("COMFIN_AMOUNT")));			
			}
			if(rs!=null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("selshgproposedlimt^"+strAppno+"^"+"0"+"^"+"aS");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("LOAN_AMTREQD",correctNull(rs.getString("FACILITY_PROPOSED")));
				//hshRecord.put("COMFIN_AMOUNT",correctNull(rs.getString("COMFIN_AMOUNT")));			
			}
			if(rs!=null)
				rs.close();
			
			strQuery=SQLParser.getSqlQuery("selshgassesmentdetailsapp^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);			
			if(rs.next())
			{
				//hshRecord.put("LOAN_AMTREQD",correctNull(rs.getString("ASA_AMNTREQ")));
				//hshRecord.put("COMFIN_AMOUNT",correctNull(rs.getString("ASA_CORPUS")));	
				hshRecord.put("ASA_LOANAMNT",correctNull(rs.getString("ASA_LOANAMNT")));		
			}
			hshRecord.put("dbltotalA",jtn.format(dbltotalA));	
			
		
		}catch(Exception ex)
		{
			throw new EJBException("Error in getSHGAssessment :: " +ex.toString());
		}
		finally
		{
			try{
			}catch(Exception ex)
			{
				throw new EJBException("Error in closing the connection :: "+ex.toString());
			}
		}
		return hshRecord;
		
	}
	
	
	public HashMap getgroupcomments(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String strAppno="";
		String strQuery="";
		ResultSet rs=null;
		boolean recordflag=false;
		String strAppIdNew="",strcommentype="";
		try{
			strAppno=correctNull((String)hshValues.get("appno"));
			strAppIdNew=correctNull((String)hshValues.get("cho_promoter")); 
			strcommentype=correctNull((String)hshValues.get("sel_commentstype")); 
				strQuery=SQLParser.getSqlQuery("sel_GROUPASSETS^"+strAppno+"^"+strAppIdNew);
				rs=DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					hshRecord.put("COM_ASSETCLASS",Helper.correctNull(rs.getString("COM_ASSETCLASSIFICATION")));	
					hshRecord.put("com_asscladate",Helper.correctNull(rs.getString("COM_ASONDATE")));
				}
				if(!strcommentype.equalsIgnoreCase(""))
				{
					hshRecord.put("COM_COMMENTSTYPE",strcommentype);
					strQuery=SQLParser.getSqlQuery("sel_GROUPCOMMENTS^"+strAppno+"^"+strAppIdNew+"^"+strcommentype);
					rs=DBUtils.executeQuery(strQuery);			
					if(rs.next())
					{
						 
						 hshRecord.put("com_groupcomments",Helper.CLOBToString(rs.getClob("COM_COMMENTS")));
					}
				}
			hshRecord.put("com_compdtappid",strAppIdNew);
		}catch(Exception ex)
		{
			throw new EJBException("Error in getgroupcomments :: " +ex.toString());
		}
		finally
		{
			try{
			}catch(Exception ex)
			{
				throw new EJBException("Error in closing the connection :: "+ex.toString());
			}
		}
		return hshRecord;
		
	}
	public HashMap getPromotorsList(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String strAppno="";
		String strQuery="";
		ResultSet rs=null;
		ResultSet rs1=null;
		boolean recordflag=false;
		String strFacSno="";
		try{
			strAppno=correctNull((String)hshValues.get("appno"));
			strFacSno=Helper.correctInt((String)hshValues.get("strFacility"));
			String strCoApp_Gua_cbs="",StrCoappGuaCbs1="";
			strQuery = SQLParser.getSqlQuery("sel_coAppGua_cbs_Corp^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strCoApp_Gua_cbs+=","+Helper.correctNull(rs.getString("COMAPP_CBSID"));
			}
			strCoApp_Gua_cbs=strCoApp_Gua_cbs.replaceFirst(",", "");
			
			if(rs!=null)
			{ rs.close(); }
			strQuery = SQLParser.getSqlQuery("sel_coAppGua_Corp_fac^"+strFacSno+"^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(!strCoApp_Gua_cbs.contains(Helper.correctNull(rs.getString("PERAPP_CBSID"))))
				{
					StrCoappGuaCbs1+=","+Helper.correctNull(rs.getString("PERAPP_CBSID"))+"-"+correctNull(rs.getString("appname"));
				}
			}
			//strCoApp_Gua_cbs=strCoApp_Gua_cbs.replaceFirst(",", "");
			if(rs!=null)
			{ rs.close(); }
			strQuery=SQLParser.getSqlQuery("selcompromotertag^"+strFacSno+"^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);	
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("com_oldlapsid")));
				arrCol.add(Helper.correctNull(rs.getString("com_compdtfname")));
				arrRow.add(arrCol);
			}
			
			hshRecord.put("arrRow", arrRow);
			hshRecord.put("strFacilitysno", strFacSno);
			hshRecord.put("strPromotorID", Helper.correctNull((String)hshValues.get("strProId")));
			
			//To select the post sanction parameters
			String strTemp=" ",strParameters="";
			strTemp = " and PS_APP_SNO='"+strFacSno+"'";
			String strQueryPS = SQLParser.getSqlQuery("sel_PS_oldaccnum^"+strAppno+"^"+strTemp);
			ResultSet rsPS = DBUtils.executeQuery(strQueryPS);
			while(rsPS.next())
			{
				strParameters=strParameters+Helper.correctNull(rsPS.getString("PS_MODIFY_TERMS"));
				hshRecord.put("strPostSancFlag","Y");
			}
			hshRecord.put("strPostSancParam",strParameters);
			
			if(rs!=null)
			{ rs.close(); }
			strQuery = SQLParser.getSqlQuery("sel_coAppGua_cbs_Corp^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strCoApp_Gua_cbs+=","+Helper.correctNull(rs.getString("COMAPP_CBSID"));
			}
			strCoApp_Gua_cbs=strCoApp_Gua_cbs.replaceFirst(",", "");
			
			if(rs!=null)
				{ rs.close(); }
			strQuery=SQLParser.getSqlQuery("sel_proposedLimit^"+strAppno+"^"+strFacSno);
			rs=DBUtils.executeQuery(strQuery);	
			while(rs.next())
			{
				hshRecord.put("FACILITY_WHT_CGTMSEAPPLY",Helper.correctNull(rs.getString("FACILITY_WHT_CGTMSEAPPLY")));
				hshRecord.put("facility_group",correctNull(rs.getString("facility_group")));
				if(Helper.correctNull(rs.getString("FACILITY_WHT_CGTMSEAPPLY")).equalsIgnoreCase("Y"))
				{
					strQuery = SQLParser.getSqlQuery("sel_coAppGua_Corp_fac^"+strFacSno+"^"+strAppno);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						if(!strCoApp_Gua_cbs.contains(Helper.correctNull(rs1.getString("PERAPP_CBSID"))))
						{
							System.out.println("==="+Helper.correctNull(rs1.getString("PERAPP_CBSID")));
							StrCoappGuaCbs1+=","+Helper.correctNull(rs1.getString("PERAPP_CBSID"))+"-"+correctNull(rs1.getString("appname"));
						}
					}
				}
			}
			
			hshRecord.put("StrCoappGuaCbs", StrCoappGuaCbs1.replaceFirst(",", ""));
		}catch(Exception ex)
		{
			throw new EJBException("Error in getPromotorsList :: " +ex.toString());
		}
		finally
		{
			try{
			}catch(Exception ex)
			{
				throw new EJBException("Error in closing the connection :: "+ex.toString());
			}
		}
		return hshRecord;
		
	}
	public void updateOtherLimits(HashMap hshValues)  
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		String strAction =Helper.correctNull((String) hshValues.get("hidAction"));
		String strappno=null;
		String strQuery="";
		ResultSet rs = null;
		String strMaxId=null;
		
		String strpagetype=null;
		String strsno=null;
		
		try
		{
			strappno =Helper.correctNull((String) hshValues.get("appno"));
			strpagetype=Helper.correctNull((String)hshValues.get("sel_nonfund"));
			strsno=Helper.correctNull((String)hshValues.get("hidsno"));
			
         if ((strAction.trim().equalsIgnoreCase("update"))||(strAction.trim().equalsIgnoreCase("delete"))) 
         {  	hshQueryValues=new HashMap();	
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_com_nonfundloanothers");
				arrValues.add(strappno);
				arrValues.add(strpagetype);
				arrValues.add(strsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
         
         if (strAction.trim().equalsIgnoreCase("update"))
        	{
        		hshQueryValues=new HashMap();	
 				hshQuery = new HashMap();
 				arrValues=new ArrayList();
 				hshQueryValues.put("size","1");
 				hshQuery.put("strQueryId","ins_com_nonfundloanothers");
 				arrValues.add(strappno);
 				arrValues.add(strsno);
 				arrValues.add(strpagetype);
 				arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcdpno")));
 				arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcdpamt")));
 				arrValues.add(Helper.correctNull((String) hshValues.get("txt_Comments")));
 				arrValues.add(Helper.correctNull((String) hshValues.get("sel_date1")));
 				hshQuery.put("arrValues",arrValues);
 				hshQueryValues.put("1",hshQuery);
 				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
        	       	 
            }
         
         if (strAction.trim().equalsIgnoreCase("insert"))
     	  {
        	 strQuery = SQLParser.getSqlQuery("max_com_nonfundloanlc^"+strappno+"^"+strpagetype);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strMaxId=Helper.correctNull(rs.getString("maxid"));
				}
				
				hshQueryValues=new HashMap();	
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","ins_com_nonfundloanothers");
				arrValues.add(strappno);
				arrValues.add(strMaxId);
				arrValues.add(strpagetype);
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcdpno")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_lcdpamt")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_Comments")));
				arrValues.add(Helper.correctNull((String) hshValues.get("sel_date1")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
     	       	 
         }
         
      	
		}
	
		catch (Exception ce)
		{
			throw new EJBException("Exception in Compro Bean   updateOtherLimits Method === " + ce.toString());
		} 
	}
	
	public HashMap getOtherLimits(HashMap hshValues)  
	{
		
		String strQuery = "";
		String strFacilitySno="";
		ResultSet rs = null,rs1 = null;
		HashMap hshRecord = new HashMap();
		String strAppno=null;
		String strpagef=null;
		String strpagetype=null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol= new ArrayList();
		
		ArrayList vecRow1 = new ArrayList();
		ArrayList vecCol1= new ArrayList();
		String pagetype=null;
		
		try {
	
			strAppno = correctNull((String) hshValues.get("appno"));
			strpagetype=Helper.correctNull((String)hshValues.get("sel_nonfund"));
			strQuery = SQLParser.getSqlQuery("sel_com_nonfundloanothers^"+strAppno+"^"+strpagetype);
			rs = DBUtils.executeQuery(strQuery);
			
			
			while(rs.next()) 
			{
				vecCol= new ArrayList();
				vecCol.add(Helper.correctNull(rs.getString("COM_SNO")));//0
				vecCol.add(Helper.correctNull(rs.getString("COM_PAGETYPE")));//1
				vecCol.add(Helper.correctNull(rs.getString("COM_PERMITTEDNO")));//2
				vecCol.add(Helper.correctDouble(rs.getString("COM_PERMITTEDAMT")));//3
				vecCol.add(Helper.replaceForJavaScriptString(Helper.CLOBToString(rs.getClob("COM_REMARK"))));//4
				vecCol.add(Helper.correctNull(rs.getString("COM_YEAR_SNO")));//5
				
				vecRow.add(vecCol);
			}
			
			
			
	        hshRecord.put("vecRow",vecRow);
	        
	        hshRecord.put("COM_PAGETYPE",strpagetype);
				
			}
			
		
	
	catch (Exception ce) {
		throw new EJBException("inside update" + ce.toString());
	}
	return hshRecord;
		
	}
	
	
	public HashMap getRenewalProcessNote(HashMap hshReqValues) 
	{
		
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		ResultSet rs 		= null,rs1	= null, rs2	= null,rscmmt=null,rscmtdesc=null,rs3=null,rs4=null,rs6=null,rs5=null;
		HashMap hshValues	= new HashMap();
		HashMap	hshFacVal	= new HashMap();
		HashMap	hshFinValues= new HashMap();
		HashMap	hshFinSenValues= new HashMap();
		HashMap hshBenchValues	= new HashMap();
		DscrBean dscrobj	= new DscrBean();
		double dblGrpExp=0;
		String strFinID="0";
		String strAppId="",strAppNo="", strOrgCode="";
		String strVal	= "",strValuesIn="", strVal1="", strVal2="",strVal3="",str_arr="",strValuesIn1="",strFinvaluesIn="",strAmountValue="",strAmtValueIn="";
		String strCommentMgmtSno[]	= {"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"};
		String strProposalType="",strAppStatus="",strQuery2="";
		String strFacSno="";
		ArrayList arrOutCol	= new ArrayList();
		ArrayList arrOutRow	= new ArrayList();
		ArrayList arrOutRowCons	= new ArrayList();
		ArrayList arrCOPCol	= new ArrayList();
		ArrayList arrCOPRow	= new ArrayList();
		ArrayList arrMOFCol	= new ArrayList();
		ArrayList arrMOFRow	= new ArrayList();
		ArrayList arrRelPatCol	= new ArrayList();
		ArrayList arrRelPatRow	= new ArrayList();
		ArrayList arrImplSchRow = new ArrayList();
		ArrayList arrImplSchCol = new ArrayList();
		
		ArrayList arrIncomeFromCropRow=new ArrayList();
		ArrayList arrIncomeFromCropCol=new ArrayList();
		
		ArrayList arrGrpExpDet = new ArrayList();
		ArrayList arrcolGrpExpDet = new ArrayList();
		ArrayList arrExistingWC	= new ArrayList();
		ArrayList arrPresentWC	= new ArrayList();
		ArrayList arrPresentTL	= new ArrayList();
		
		DecimalFormat dc = new DecimalFormat();
		dc.setGroupingUsed(false);
		dc.setMaximumFractionDigits(2);
		dc.setMinimumFractionDigits(2);
		
		String strSeasonType="",strSeasonName="",ApprUserid="",FACILITY_SEL_TYPE="";
		String strQuery="",strfacno="";
		double dblGrpExposure	= 0.00,dblTotalExposure	= 0.00;
		
		double dblTotal=0.00,dblTotalAmt=0.00,dbl_exitot=0.00,dbl_exialltot=0.00,dbl_protot=0.00,dbl_proalltot=0.00;
		String strTotalAmt="",strCropType="",strCropName="",strexiprotype="";
		
		String strCommentSno[]	= {"1","3","5","6"};
		double dblTotCOP	= 0.00,dblRPTotCost=0.00,dblRPTotMargin=0.00, dblRPTotLoan=0.00;
		
		String strLoanType="",cma="";
		
		ArrayList arrLimit = new ArrayList();
		ArrayList arrRowLimit = new ArrayList();
		
		ArrayList arrInland = new ArrayList();
		ArrayList arrRowInland = new ArrayList();
		ArrayList arrInlandYr = new ArrayList();
		ArrayList arrRowInlandYr = new ArrayList();

		// Added by vinoth kumar on March 08 2014
		HashMap	hshPhysicsAndFinValues = new HashMap();
		HashMap	hshDSSData = new HashMap();
		HashMap hshCropAss=new HashMap();
		HashMap hshkccIntSubVen=new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecRec = new ArrayList();
		HashMap hshRes= new HashMap();	
		
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
		
		
		ArrayList arrRowNonBr=new ArrayList();
		ArrayList arrColNonBr=new ArrayList();
		ArrayList arrOutpropCol	= new ArrayList();
		ArrayList arrOutpropRow	= new ArrayList();
		ArrayList arrRowcgssd = new ArrayList();
		ArrayList arrColCgssd= new ArrayList();
		int strPatentid=0;
		String[] peakDeficit=null;
		
		double dbl_allopnBal=0.00 ,dbl_opnBal=0.00 ,dbl_allproEqt=0.00 ,dbl_proEqt=0.00 ,dbl_bnkFin=0.00 ,dbl_allbnkFin=0.00 ,dbl_unsec=0.00 ,dbl_allunsec=0.00;
		double dbl_allsaleProc=0.00 ,dbl_saleProc=0.00 ,dbl_other=0.00 ,dbl_allother=0.00 ,dbl_allsofTot=0.00 ,dbl_sofTot=0.00 ,dbl_costLand=0.00 ,dbl_allcostLand=0.00;
		double dbl_adminexp=0.00 ,dbl_alladminexp=0.00 ,dbl_marketexp=0.00 ,dbl_allmarketexp=0.00 ,dbl_constcost=0.00 ,dbl_allconstcost=0.00 ,dbl_premiumfsi=0.00;
		double dbl_allpremiumfsi=0.00 ,dbl_provTax=0.00 ,dbl_allprovTax=0.00 ,dbl_allrepayment=0.00 ,dbl_repayment=0.00 ,dbl_allinterest=0.00 ,dbl_interest=0.00;
		double dbl_allotherFin=0.00 ,dbl_otherFin=0.00 ,dbl_allappfinTot=0.00 ,dbl_appfinTot=0.00 ,dbl_closingBal=0.00 ,dbl_allclosingBal=0.00;
		
		String srrBaseRate="",strInterestType="",strInterestRate="",strWhetherBRAvail="N",strHoliday="0";
		double dblBaseRate=0.00,dblInterestRate=0.00,dblDiffIntRate=0.00;
		String mainactivity="",subactivity="";
		String strFinancialrequired="";
		
		ArrayList arrMISRow	= new ArrayList();
		ArrayList arrMISCol	= new ArrayList();
		HashMap hshGoods=new HashMap();
		String strusername="";
		ArrayList arrFinSnoRow = new ArrayList();
		ArrayList arrFinSnoCol = new ArrayList();
		String strSancBranch="",strAppOrgCode="",strMCLRFlag="Y";
		String strVerifyWithCFR="",strNamApprCFR="",strStatusVer="";
		String strRoiType="",StrInsCompanyName="";
		ArrayList arrRow11 = new ArrayList();
		ArrayList arrCol11 = new ArrayList();
		
		try
		{
			strAppId	= correctNull((String)hshReqValues.get("appid"));
			strAppNo	= correctNull((String)hshReqValues.get("appno"));
			strusername=Helper.correctNull((String)hshReqValues.get("strUserId"));
			String strSessionModuleType=Helper.correctNull((String)hshReqValues.get("sessionModuleType"));
			
			rs=DBUtils.executeLAPSQuery("sanctiondate_mclr^"+strAppNo);
			if(rs.next())
			{
				if(Integer.parseInt(Helper.correctInt(rs.getString("datediff")))<0)
				{
					strMCLRFlag="N";
				}
			}
			
			String strOldAppId="";
			rs=DBUtils.executeLAPSQuery("selgetveryoldid^"+strAppId);
			if(rs.next())
			{
				strOldAppId=Helper.correctNull((String)rs.getString("perapp_oldid"));
			}
			//Assessments selected
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("com_assessmentselection_select^"+strAppNo);
			
			if(rs.next())
			{
				str_arr=Helper.correctNull(rs.getString("COM_ASSESSMENTTYPE"));
			}
			hshValues.put("str_arr",str_arr);
			
			//Branch Name
			rs	= DBUtils.executeLAPSQuery("selmcbReportprint^"+strAppNo);
			
			if(rs.next())
			{
				hshValues.put("org_name", correctNull(rs.getString("org_name")));
			}
			
			//Orgcode
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("sel_appstatus^"+strAppNo);
			if(rs.next())
			{
				strLoanType=Helper.correctNull((String)rs.getString("app_loantype"));
				strLoanType=strLoanType.toLowerCase();
				hshValues.put("app_renew_flag", Helper.correctNull((String)rs.getString("app_renew_flag")));
				if(Helper.correctNull((String)rs.getString("app_renew_flag")).equalsIgnoreCase("F"))
					strProposalType="Fresh";
				else if(Helper.correctNull((String)rs.getString("app_renew_flag")).equalsIgnoreCase("R"))
					strProposalType="Renewal";
				else if(Helper.correctNull((String)rs.getString("app_renew_flag")).equalsIgnoreCase("S"))
					strProposalType="Restructuring";
				else if(Helper.correctNull((String)rs.getString("app_renew_flag")).equalsIgnoreCase("P"))
					strProposalType="Post Sanction";
				
				hshValues.put("strProposalType", strProposalType);
				
				strAppStatus=Helper.correctNull(rs.getString("app_status"));
			}
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("selorgno^"+strAppNo);
			if(rs.next())
			{
				strOrgCode 	= correctNull(rs.getString("app_orgcode"));
				strValuesIn	= correctNull(rs.getString("app_valuesin"));
				strValuesIn1= correctNull(rs.getString("app_valuesin"));
				strFinancialrequired= correctNull(rs.getString("APP_FACILITYREQUIRED"));
			}
			hshReqValues.put("valuesin", strValuesIn1);
			hshReqValues.put("Financialrequired", strFinancialrequired);
			hshValues.put("Financialrequired", strFinancialrequired);
			if(rs!=null){rs.close();}
			String strKccFlag="";
			if(strLoanType.equalsIgnoreCase("a"))
			{				
				rs=DBUtils.executeLAPSQuery("sel_agr_facilities^"+strAppNo);
				while(rs.next())
				{
					
					String strFacAgrSchem=Helper.correctNull((String)rs.getString("facscheme"));
					if(strFacAgrSchem.equalsIgnoreCase("aQ"))
					{
						strKccFlag="Y";
					}					
				}		
				
		  	}	
	
			hshValues.put("strKccFlag", strKccFlag);
			
			hshValues.put("username", correctNull((String)hshReqValues.get("strOrgName")));
			//added by bhaskar for Crop Loan Aseesment
			
			if(strKccFlag.equalsIgnoreCase("Y"))
			{
				
			hshReqValues.put("hidapplicantid", strAppId);
			hshCropAss = (HashMap)EJBInvoker.executeStateLess("comproposal",hshReqValues,"getCropLoan");
			hshValues.put("hshCropAss",hshCropAss);
			
			//added for interest subvention details
			
			hshReqValues.put("hidapplicantid", strAppId);
			hshkccIntSubVen=(HashMap)EJBInvoker.executeStateLess("agrcrops",hshReqValues,"getInterestSubventionDetails");
			hshValues.put("hshkccIntSubVen",hshkccIntSubVen);			
			
			}			
			
			//Values In
			if(strValuesIn.equals("C")){strValuesIn			= "Crore";}
			else if(strValuesIn.equals("L")){strValuesIn	= "Lacs";}
			else if(strValuesIn.equals("R")){strValuesIn	= "Rs";}
			
			hshValues.put("strValuesIn", strValuesIn);
			rs	= DBUtils.executeLAPSQuery("sel_amountvalue^"+strAppNo);
			if(rs.next())
			{
		     hshValues.put("com_amountvalue", Helper.correctNull(rs.getString("com_amountvalue")));
		     strAmountValue=Helper.correctNull(rs.getString("com_amountvalue"));
			}
			
			if(strAmountValue.equalsIgnoreCase("C"))
			{strAmtValueIn ="Crore";}
			else if(strAmountValue.equalsIgnoreCase("L")){strAmtValueIn ="Lacs";}
			else {strAmtValueIn ="Rs";}
			
			hshValues.put("strAmountValue", strAmountValue);
			hshValues.put("strAmtValueIn", strAmtValueIn);
			
			if(!strOrgCode.equals(""))
			{
				strOrgCode	= strOrgCode.substring(0, 6)+"%";
			}
			rs	= DBUtils.executeLAPSQuery("sel_financeid^"+strAppNo);
			if(rs.next())
			{
				strFinID = Helper.correctInt((String) rs
				 		.getString("DEMO_FINSTANDARD"));
			}
			if(rs!=null){rs.close();}
			
			rs	= DBUtils.executeLAPSQuery("comfinance_finappid^"+strFinID);
			if(rs.next())
			{
				strFinvaluesIn	= correctNull(rs.getString("fin_valuesarein"));
			}
			else{
				strFinvaluesIn="R";
			}
			if(rs!=null){rs.close();}
			
			//Financail Values In
			if(strFinvaluesIn.equals("C")){strFinvaluesIn = "Crore";}
			else if(strFinvaluesIn.equals("L")){strFinvaluesIn	= "Lacs";}
			else if(strFinvaluesIn.equals("R")){strFinvaluesIn	= "Rs";}
			hshValues.put("strFinvaluesIn", strFinvaluesIn);
			//Region
			if(rs != null)
			{
				rs.close();
			}
			String livedate=ApplicationParams.getStrCLPHdate();
			String postsanctionflag="";
			String applicationStatus="";
			// check when application is created
			String appcreatedate="";
			
				strQuery = SQLParser.getSqlQuery("getcreatedate^"+strAppNo);
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
			rs = DBUtils.executeLAPSQuery("sel_ApplnBranch^" + strAppNo);
					}else{
						rs = DBUtils.executeLAPSQuery("sel_ApplnBranchnewchk^" + strAppNo);
					}
					}
			if(rs.next())
			{
				hshValues.put("org_name", correctNull(rs.getString("org_name")));
				hshValues.put("org_scode", correctNull(rs.getString("org_scode")));
				strAppOrgCode=Helper.correctNull(rs.getString("org_code"));
				hshValues.put("strLodgedDate", correctNull(rs.getString("app_lodgeddate")));
				hshValues.put("strDelodgedDate", correctNull(rs.getString("app_delodgeddate")));
				
				if(Helper.correctNull(rs.getString("APP_ORGLEVEL")).equalsIgnoreCase("C")||Helper.correctNull(rs.getString("APP_ORGLEVEL")).equalsIgnoreCase("D"))
				{
					if(rs != null)
					{
						rs.close();
					}
					rs = DBUtils.executeLAPSQuery("sel_pertainingbr^" + strAppNo);
					if(rs.next())
					{
						hshValues.put("org_name", correctNull(rs.getString("org_name")));
						hshValues.put("org_scode", correctNull(rs.getString("org_scode")));
						strAppOrgCode=Helper.correctNull(rs.getString("org_code"));
					}
				}
			}
			
			
			if(!strAppOrgCode.equals(""))
			{
				strAppOrgCode	= strAppOrgCode.substring(0, 6)+"%";
			}
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("sel_region^"+strAppOrgCode);
			if(rs.next())
			{
				hshValues.put("Reg_org_name", correctNull(rs.getString("org_name")));
			}
			
			//Date of Credit Application
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("com_selectinwardcusttype^"+strAppNo);
			if(rs.next())
			{
				hshValues.put("inward_appliedon", correctNull(rs.getString("inward_appliedon")));
				hshValues.put("INW_LEADNO", correctNull(rs.getString("INW_LEADNO")));
			}
			
			// Internal RMD Rating
			if(rs!=null){rs.close();}
			String cre_weight="";
			rs	= DBUtils.executeLAPSQuery("sel_rate_userid^"+strAppNo);
			if(rs.next())
			{
				hshValues.put("cre_rating", correctNull(rs.getString("cre_rating")));
				cre_weight=correctNull(rs.getString("cre_weight"));
				if(cre_weight.equalsIgnoreCase("KB1"))
				{
					cre_weight+=" - Minimal Risk";
				}else if(cre_weight.equalsIgnoreCase("KB2"))
				{
					cre_weight+=" - Lowest Risk";
				}else if(cre_weight.equalsIgnoreCase("KB3"))
				{
					cre_weight+=" - Lower Risk";
				}else if(cre_weight.equalsIgnoreCase("KB4"))
				{
					cre_weight+=" - Low Risk";
				}else if(cre_weight.equalsIgnoreCase("KB5"))
				{
					cre_weight+=" - Moderate Risk";
				}else if(cre_weight.equalsIgnoreCase("KB6"))
				{
					cre_weight+=" - Average Risk";
				}else if(cre_weight.equalsIgnoreCase("KB7"))
				{
					cre_weight+=" - High Risk";
				}else if(cre_weight.equalsIgnoreCase("KB8"))
				{
					cre_weight+=" - Very high Risk";
				}else if(cre_weight.equalsIgnoreCase("KB9"))
				{
					cre_weight+=" - Sub standard (highest)";
				}else if(cre_weight.equalsIgnoreCase("KB10"))
				{
					cre_weight+=" - Doubt full/ loss (critical)";
				}
				hshValues.put("cre_weight", cre_weight);
				hshValues.put("crermd_rating", correctNull(rs.getString("cre_rating")));
				hshValues.put("crermd_rating_year", correctNull(rs.getString("rating_year")));
				
				if(correctNull(rs.getString("rating_yeartype")).equalsIgnoreCase("A"))
					hshValues.put("crermd_rating_yeartype", "Audited");
				else if(correctNull(rs.getString("rating_yeartype")).equalsIgnoreCase("U"))
					hshValues.put("crermd_rating_yeartype", "Unaudited");
				else if(correctNull(rs.getString("rating_yeartype")).equalsIgnoreCase("E"))
					hshValues.put("crermd_rating_yeartype", "Estimated");
				else
					hshValues.put("crermd_rating_yeartype", " ");
			}
			
			if(rs!=null){rs.close();}
			cre_weight="";
			rs	= DBUtils.executeLAPSQuery("sel_crerating^"+strAppNo);
			if(rs.next())
			{
				cre_weight=correctNull(rs.getString("cre_weight"));
				if(cre_weight.equalsIgnoreCase("KB1"))
				{
					cre_weight+=" - Minimal Risk";
				}else if(cre_weight.equalsIgnoreCase("KB2"))
				{
					cre_weight+=" - Lowest Risk";
				}else if(cre_weight.equalsIgnoreCase("KB3"))
				{
					cre_weight+=" - Lower Risk";
				}else if(cre_weight.equalsIgnoreCase("KB4"))
				{
					cre_weight+=" - Low Risk";
				}else if(cre_weight.equalsIgnoreCase("KB5"))
				{
					cre_weight+=" - Moderate Risk";
				}else if(cre_weight.equalsIgnoreCase("KB6"))
				{
					cre_weight+=" - Average Risk";
				}else if(cre_weight.equalsIgnoreCase("KB7"))
				{
					cre_weight+=" - High Risk";
				}else if(cre_weight.equalsIgnoreCase("KB8"))
				{
					cre_weight+=" - Very high Risk";
				}else if(cre_weight.equalsIgnoreCase("KB9"))
				{
					cre_weight+=" - Sub standard (highest)";
				}else if(cre_weight.equalsIgnoreCase("KB10"))
				{
					cre_weight+=" - Doubt full/ loss (critical)";
				}
				hshValues.put("creweight_recent", cre_weight);
				hshValues.put("creratyear_recent", correctNull(rs.getString("rating_year")));
				String cre_ratingType=correctNull(rs.getString("rating_yeartype"));
				
				if(cre_ratingType.equalsIgnoreCase("A"))
				{
					cre_ratingType="AUDITED";
				}else if(cre_ratingType.equalsIgnoreCase("U"))
				{
					cre_ratingType="UNAUDITED";
				}else if(cre_ratingType.equalsIgnoreCase("E"))
				{
					cre_ratingType="ESTIMATED";
				}else if(cre_ratingType.equalsIgnoreCase("P"))
				{
					cre_ratingType="PROJECTION";
				}
				else{
					cre_ratingType="";
				}
				hshValues.put("crerattype_recent", cre_ratingType);
			}
			
			//Brief Background
			String strsancdept="";
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("sel_corporate_breifbackground^"+strAppNo);
			if(rs.next())
			{
				strVal	= correctNull(rs.getString("com_submittedto"));
				strsancdept= correctNull(rs.getString("com_sancdept"));
				hshValues.put("com_sancdeptcode", strsancdept);
				if(strsancdept.equalsIgnoreCase("011"))
				{
					hshValues.put("com_sancdept", "Central Processing Centre");
				}
				else if(strsancdept.equalsIgnoreCase("008"))
				{
					hshValues.put("com_sancdept", "Credit A ");
				}
				else if(strsancdept.equalsIgnoreCase("010"))
				{
					hshValues.put("com_sancdept", "Credit B ");
				}
				else if(strsancdept.equalsIgnoreCase("007"))
				{
					hshValues.put("com_sancdept", "Branch");
				}
				else if(strsancdept.equalsIgnoreCase("006"))
				{
					hshValues.put("com_sancdept", "Regional Office");
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
						hshValues.put("strSanctiondept",Helper.correctNull(rs1.getString("cbs_static_data_desc")));
					}
				}
				if(rs1!=null)
				{
					rs1.close();
				}
				if(!strVal.equalsIgnoreCase(""))
				{
				rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^"+"21"+"^"+strVal);
				if(rs1.next())
				{
					strVal=Helper.correctNull(rs1.getString("stat_data_desc1"));
				}
				else
				{
					strVal="";
				}
				}
				else
				{
					strVal="";
				}
				
				/*if(strVal.equalsIgnoreCase("adm")){strVal		= "Administrator";}
				else if(strVal.equalsIgnoreCase("999")){strVal	= "DGM Admin";}
				else if(strVal.equalsIgnoreCase("001")){strVal	= "Officer";}
				else if(strVal.equalsIgnoreCase("002")){strVal	= "General Manager";}
				else if(strVal.equalsIgnoreCase("003")){strVal	= "Chief Manager";}
				else{strVal	= "";}*/			
				
				hshValues.put("com_partyfileno", correctNull(rs.getString("com_partyfileno")));
				hshValues.put("com_meeting", correctNull(rs.getString("com_meeting")));
				hshValues.put("com_meetingdate", correctNull(rs.getString("com_meetingdate")));
				hshValues.put("com_submittedto", strVal);
				hshValues.put("com_branchrcvddate", correctNull(rs.getString("com_branchrcvddate")));
				hshValues.put("com_branchcompletedate", correctNull(rs.getString("com_branchcompletedate")));
				hshValues.put("com_sancauthority", correctNull(rs.getString("com_sancauthority")));
				hshValues.put("com_processnotedate", correctNull(rs.getString("com_processnotedate")));
				hshValues.put("com_sancauthorityVal",Helper.CLOBToString(rs.getClob("com_comments")));
				hshValues.put("com_roho", correctNull(rs.getString("com_roho")));
				hshValues.put("com_sancbranchcode", correctNull(rs.getString("com_sancbranch")));
				strSancBranch=correctNull(rs.getString("com_sancbranch"));
				if(strSancBranch.equalsIgnoreCase("RFD")){
					hshValues.put("com_sancbranch", "Retail Finance Department");
				}else if(strSancBranch.equalsIgnoreCase("MCFD")){
					hshValues.put("com_sancbranch", "MID CORPORATE FINANCE DIVISION");
				}else if(strSancBranch.equalsIgnoreCase("ASG")){
					hshValues.put("com_sancbranch", "AGRICULTURE SUPPORT GROUP");
				}else if(strSancBranch.equalsIgnoreCase("LCFD")){
					hshValues.put("com_sancbranch", "LCFD");
				}else if(strSancBranch.equalsIgnoreCase("FS")){
					hshValues.put("com_sancbranch", "FOREX SUPPORT");
				}
				
				hshValues.put("com_griddate",correctNull(rs.getString("com_griddate")));
				hshValues.put("com_processingfee",jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("com_processingfee")))));
				
				
				hshValues.put("COM_CFR_VERIFIED", correctNull(rs.getString("COM_CFR_VERIFIED")));
				hshValues.put("COM_CFR_BORNAME", correctNull(rs.getString("COM_CFR_BORNAME")));			
				hshValues.put("COM_CFR_DEV_RENFO", correctNull(rs.getString("COM_CFR_DEV_RENFO")));
				
				hshValues.put("STATUS_VERIFIED",correctNull(rs.getString("STATUS_VERIFIED")));
				
				if(correctNull(rs.getString("STATUS_VERIFIED")).equalsIgnoreCase("A"))
				{
					strStatusVer="APPROVED";					
				}else if(correctNull(rs.getString("STATUS_VERIFIED")).equalsIgnoreCase("R"))
				{
					strStatusVer="REJECTED";	
				}
				
				hshValues.put("LOAN_APPR_DATE",correctNull(rs.getString("COM_APPR_DATE")));
				ApprUserid = correctNull(rs.getString("COM_USERID2"));

				if(ApprUserid!="")
				{
					if(rs1!=null)
						{
							rs1.close();
						}
						
				strQuery = SQLParser.getSqlQuery("selectusername^"+ApprUserid);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
					{
					hshValues.put("appuserid",correctNull((String)rs1.getString("name")));
					}
				}
				
				hshValues.put("strStatusVer", strStatusVer);
				if(rs1!=null)
				{
					rs1.close();
				}
				if(!Helper.correctNull(rs.getString("com_sancauthority")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_cbsstaticdescbycode^"+"15"+"^"+rs.getString("com_sancauthority"));
					if(rs1.next())
					{
						hshValues.put("strSanctionAuthDesc",Helper.correctNull(rs1.getString("cbs_static_data_desc")));
					}
				}
				hshValues.put("COM_CSLMSNO", correctNull(rs.getString("COM_CSLMSNO")));
			}
			
			lapsReportBean xtemp=new lapsReportBean();
			hshFacVal	= xtemp.getFacilityDetails(strAppNo);
			
			hshValues.put("dblFBLimitTot", hshFacVal.get("dblFBLimitTot"));
			hshValues.put("dblFBOutstandTot", hshFacVal.get("dblFBOutstandTot"));
			hshValues.put("dblFBExposureTot", hshFacVal.get("dblFBExposureTot"));
			hshValues.put("dblFBBorrLimit", hshFacVal.get("dblFBBorrLimit"));
			hshValues.put("dblFBPropLiimitTot", hshFacVal.get("dblFBPropLiimitTot"));
			
			hshValues.put("dblNFBLimitTot", hshFacVal.get("dblNFBLimitTot"));
			hshValues.put("dblNFBOutstandTot", hshFacVal.get("dblNFBOutstandTot"));
			hshValues.put("dblNFBExposureTot", hshFacVal.get("dblNFBExposureTot"));
			hshValues.put("dblNFBBorrLimit", hshFacVal.get("dblNFBBorrLimit"));
			hshValues.put("dblNFBPropLiimitTot", hshFacVal.get("dblNFBPropLiimitTot"));
			
			hshValues.put("dblLimitTot", hshFacVal.get("dblLimitTot"));
			hshValues.put("dblOutstandTot", hshFacVal.get("dblOutstandTot"));
			hshValues.put("dblExposureTot", hshFacVal.get("dblExposureTot"));
			hshValues.put("dblBorrLimit", hshFacVal.get("dblBorrLimit"));
			hshValues.put("dblPropLiimitTot", hshFacVal.get("dblPropLiimitTot"));
			hshValues.put("dblTotExp", hshFacVal.get("dblTotExp"));
			hshValues.put("strOutstandingDate", hshFacVal.get("strOutstandingDate"));
			hshValues.put("dblFreshLimit",  hshFacVal.get("dblFreshLimit"));
			hshValues.put("dblPropLimitTot",  hshFacVal.get("dblPropLimitTot"));
			
			hshValues.put("arrFacRow", hshFacVal.get("arrFacRow"));
			
			// For Finding Main or Sub Limit by DINESH
			
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("com_FACSel_new^"+strAppNo+"^"+strLoanType+"^0");
			while(rs.next())
			{
				arrLimit	= new ArrayList();
				strVal		= Helper.correctInt(rs.getString("facility_sno"));
				strVal1		= Helper.correctInt(rs.getString("facility_group"));
				strVal2		= Helper.correctInt(rs.getString("facility_repaytype"));
				strVal3		= Helper.correctInt(rs.getString("facheaddesc"));
				
				if(strVal1.equals("0"))
				{
					strVal1	= "Main-Limit";
				}
				else
				{
					strVal1	= "Sub-Limit";
				}
				
				arrLimit.add(strVal1);
				arrRowLimit.add(arrLimit);
				
				if(rs1!=null){rs1.close();}
				rs1	= DBUtils.executeLAPSQuery("com_FACSel_new^"+strAppNo+"^"+strLoanType+"^"+strVal);
				while(rs1.next())
				{
					arrLimit	= new ArrayList();
					strVal		= "";
					strVal1		= Helper.correctInt(rs1.getString("facility_group"));
					strVal2		= Helper.correctInt(rs1.getString("facility_repaytype"));
					strVal3		= Helper.correctInt(rs1.getString("facheaddesc"));
					
					if(strVal1.equals("0"))
					{
						strVal1	= "Main-Limit";
					}
					else
					{
						strVal1	= "Sub-Limit";
					}
					
					arrLimit.add(strVal1);
					arrRowLimit.add(arrLimit);
					
					
					
				}
				
			}
			hshValues.put("arrRowLimit",arrRowLimit);
			
			//Present Proposal
			String strPresentWC ="",strPreWClimit="";
			arrOutRow	=  new ArrayList();
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("com_FACSel_modeofrepay^"+strAppNo+"^"+strLoanType);
			while(rs.next())
			{
				strPresentWC="";
				arrOutCol	= new ArrayList();
				
				strVal	= correctNull(rs.getString("facility_repaytype"));
				
				if(strVal.equalsIgnoreCase("E")){	  strVal	= "EMI";}
				else if(strVal.equalsIgnoreCase("NE")){strVal	= "Non EMI";}
				else if(strVal.equalsIgnoreCase("OD")){strVal	= "On Demand";}
				else if(strVal.equalsIgnoreCase("LC")){strVal	= "As Per LC Terms";}
				else if(strVal.equalsIgnoreCase("CO")){strVal	= "As Per Contract Terms";}
				else if(strVal.equalsIgnoreCase("BG")){strVal	= "As Per BG Rules";}
				else if(strVal.equalsIgnoreCase("DD")){strVal	= "On Due Date";}
				else if(strVal.equalsIgnoreCase("PC")){strVal	= "From the proceeds of PSC / by realization of bill";}
				else if(strVal.equalsIgnoreCase("PS")){strVal	= "By Realization of Export Bills";}
				else if(strVal.equalsIgnoreCase("PR")){strVal	= "By Realization of Respective Bills";}
				else if(strVal.equalsIgnoreCase("TG")){strVal	= "As per TCBG Rules";}
				else{strVal	= "";}
				
				arrOutCol.add(correctNull(rs.getString("facility_displaydesc")));
				arrOutCol.add(strVal);
				arrOutCol.add(Helper.correctDouble(rs.getString("facility_proposed")));
				arrOutCol.add(correctNull(rs.getString("facility_for")));
				arrOutCol.add(correctNull(rs.getString("facility_facnature")));
				arrOutRow.add(arrOutCol);
			}
			double dblAmount=0.00;
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("sel_fundbasedfacility^"+strAppNo+"^"+strLoanType);
			while(rs.next()){
				arrOutCol	= new ArrayList();
				arrOutCol.add(correctNull(rs.getString("com_facdesc")));
				arrOutCol.add(Helper.checkDecimal(Helper.correctDouble((String)rs.getString("facility_proposed"))));
				arrPresentWC.add(arrOutCol);
				dblAmount=Double.parseDouble(Helper.correctDouble((String)rs.getString("facility_proposed")));
				if(strAmountValue.equalsIgnoreCase("C"))
				{dblAmount =dblAmount/10000000;}
				else if(strAmountValue.equalsIgnoreCase("L")){dblAmount =dblAmount/100000;}
				strPresentWC = correctNull(rs.getString("com_facdesc"))+" - "+jtn.format(dblAmount);
				strPreWClimit = strPreWClimit+strPresentWC+"@";
			}
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("sel_fundbasedfacilityTL^"+strAppNo+"^"+strLoanType);
			while(rs.next()){
				arrOutCol	= new ArrayList();
				arrOutCol.add(correctNull(rs.getString("com_facdesc")));
				arrOutCol.add(Helper.checkDecimal(Helper.correctDouble((String)rs.getString("facility_proposed"))));
				arrPresentTL.add(arrOutCol);
			}
			hshValues.put("strPreWClimit",strPreWClimit);
			hshValues.put("arrFAConlyRow",arrOutRow);
			hshValues.put("arrPresentWC",arrPresentWC);
			hshValues.put("arrPresentTL",arrPresentTL);
			
			//Existing Proposal
			String strExiWC ="",strExiWClimit="",strProcnoteExiWC="",strProcnoteWClimit="";
			arrOutRow	=  new ArrayList();
			if(rs!=null){rs.close();}
			//String strQuery="";
			strQuery = SQLParser.getSqlQuery("com_FACSel_existing^"+strAppNo+"^"+strLoanType);
			rs	= DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				dblAmount=0.00;
				strExiWC ="";
				arrOutCol	= new ArrayList();
				arrOutCol.add(correctNull(rs.getString("com_facdesc")));
				arrOutCol.add("");
				arrOutCol.add(Helper.correctDouble(rs.getString("facility_proposed")));
				arrOutCol.add(correctNull(rs.getString("facility_for")));
				
				arrOutRow.add(arrOutCol);
				dblAmount=Double.parseDouble(Helper.correctDouble(rs.getString("facility_proposed")));
				if(strAmountValue.equalsIgnoreCase("C"))
				{dblAmount =dblAmount/10000000;}
				else if(strAmountValue.equalsIgnoreCase("L")){dblAmount =dblAmount/100000;}
				arrOutCol	= new ArrayList();
				strExiWC = correctNull(rs.getString("com_facdesc"))+" - "+jtn.format(dblAmount);
				dblAmount=Double.parseDouble(Helper.correctDouble(rs.getString("facility_existing")));
				if(strAmountValue.equalsIgnoreCase("C"))
				{dblAmount =dblAmount/10000000;}
				else if(strAmountValue.equalsIgnoreCase("L")){dblAmount =dblAmount/100000;}
				strProcnoteExiWC= correctNull(rs.getString("com_facdesc"))+" - "+jtn.format(dblAmount);
				strExiWClimit = strExiWClimit+strExiWC+"@";
				strProcnoteWClimit = strProcnoteWClimit+strProcnoteExiWC+"@";
				arrOutCol.add(correctNull(rs.getString("com_facdesc")));
				arrOutCol.add(Helper.checkDecimal(Helper.correctInt(rs.getString("facility_existing"))));
				arrExistingWC.add(arrOutCol);
				
			}
			hshValues.put("strExiWClimit",strExiWClimit);
			hshValues.put("arrFACexistingRow",arrOutRow);
			hshValues.put("strProcnoteWClimit",strProcnoteWClimit);
			hshValues.put("arrExistingWC", arrExistingWC);
			//Gist of Proposal
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("sel_comments^gist^"+strAppNo);
			if(rs.next())
			{
				hshValues.put("GistOfProp", correctNull(Helper.CLOBToString(rs.getClob(("com_comments")))));
			}
			
			//Customer Profile
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("sel_common_customer^"+strAppId);
			strVal	= "";
			
			if(rs.next())
			{
				hshValues.put("perapp_name", correctNull(rs.getString("perapp_fname")));
				hshValues.put("perapp_banksince", correctNull(rs.getString("perapp_banksince")));
				hshValues.put("perapp_bank", correctNull(rs.getString("perapp_bank")));
				hshValues.put("perapp_cbsid", correctNull(rs.getString("perapp_cbsid")));
				hshValues.put("perapp_constitution_type", correctNull(rs.getString("perapp_constitution")));
				hshValues.put("perapp_dob", correctNull(rs.getString("perapp_dob")));
				hshValues.put("cominfo_incorporation_date", correctNull(rs.getString("cominfo_incorporation_date")));
				hshValues.put("PERAPP_UDYOG_AADHAR", correctNull(rs.getString("PERAPP_UDYOG_AADHAR")));
				hshValues.put("cominfo_cin", Helper.correctNull(rs.getString("cominfo_cin")));
				hshValues.put("PERAPP_LEGAL_ENTITYID", Helper.correctNull(rs.getString("PERAPP_LEGAL_ENTITYID")));
				hshValues.put("PERAPP_LEGAL_EXPIRYDATE", Helper.correctNull(rs.getString("PERAPP_LEGAL_EXPIRYDATE")));
				hshValues.put("PERAPP_UDYAM_REGNO", Helper.correctNull(rs.getString("PERAPP_UDYAM_REGNO")));
				hshValues.put("PERAPP_CERTIFICATION_DATE",Helper.correctNull((String)rs.getString("PERAPP_CERTIFICATION_DATE")));
				rs2=DBUtils.executeLAPSQuery("selmiscust^249^"+Helper.correctNull((String)rs.getString("PERAPP_MSME_CLASSIFICATION")));
				if(rs2.next())
				{	
					hshValues.put("PERAPP_MSME_CLASSIFICATION", Helper.correctNull(rs2.getString("stat_data_desc1")));

				}
				if(rs1!=null){rs1.close();}
				rs1	= DBUtils.executeLAPSQuery("selCBSstaticdatanew^1");
				while(rs1.next())
				{
					if(correctNull((String)rs1.getString("cbs_static_data_code")).trim().equals(correctNull((String)rs.getString("perapp_title")).trim()))
					{
						hshValues.put("perapp_title", correctNull(rs1.getString("cbs_static_data_desc")));
						break;
					}
				}
				
				if(rs1!=null){rs1.close();}
				rs1	= DBUtils.executeLAPSQuery("selCBSstaticdatanew^2");
				while(rs1.next())
				{
					if(correctNull((String)rs1.getString("cbs_static_data_code")).trim().equals(correctNull((String)rs.getString("perapp_constitution")).trim()))
					{
						hshValues.put("perapp_constitution", correctNull(rs1.getString("cbs_static_data_desc")));
					}
				}
				if(rs2!=null){rs2.close();}
				rs2=DBUtils.executeLAPSQuery("selmiscust^109^"+Helper.correctNull((String)rs.getString("perapp_status")));
				if(rs2.next())
				{	
					hshValues.put("perapp_status", Helper.correctNull(rs2.getString("stat_data_desc1")));

				}
				if(rs2!=null){rs2.close();}
				hshValues.put("perapp_relat_staffid", Helper.correctNull((String) rs
						.getString("perapp_relat_staffid")));
				rs3=DBUtils.executeLAPSQuery("selmiscust^110^"+Helper.correctNull((String)rs.getString("perapp_relation_bankstaff")));
				if(rs3.next())
				{	
					hshValues.put("perapp_relation_bankstaff", Helper.correctNull(rs3.getString("stat_data_desc1")));

				}
				if(rs3!=null){rs3.close();}
				if(Helper.correctNull((String)rs.getString("perapp_relation_bankstaff")).equalsIgnoreCase("005")||Helper.correctNull((String)rs.getString("perapp_relation_bankstaff")).equalsIgnoreCase("006")){
					hshValues.put("perapp_relation_staffname", Helper.correctNull((String) rs.getString("perapp_relation_staffname")));

			   }else{
				rs4=DBUtils.executeLAPSQuery("selmiscust^153^"+Helper.correctNull((String)rs.getString("perapp_relation_staffname")));
				if(rs4.next())
				{	
					hshValues.put("perapp_relation_staffname", Helper.correctNull(rs4.getString("stat_data_desc1")));

				}
			   }
				rs1=DBUtils.executeLAPSQuery("selmiscust^111^"+Helper.correctNull((String)rs.getString("perapp_blood_relation")));
				if(rs1.next())
				{	
					hshValues.put("perapp_blood_relation", Helper.correctNull(rs1.getString("stat_data_desc1")));

				}
				hshValues.put("PEREMP_ID", Helper.correctNull((String) rs
						.getString("PEREMP_ID")));
				hshValues.put("PEREMP_ESTABLISH", Helper.correctNull((String) rs
						.getString("PEREMP_ESTABLISH")));
				hshValues.put("peremp_department", Helper.correctNull((String) rs
						.getString("peremp_department")));
				hshValues.put("peremp_retdate", Helper.correctNull((String) rs
						.getString("peremp_retdate")));
				hshValues.put("perapp_relation_bankstaff_val", Helper.correctNull((String) rs
						.getString("perapp_relation_bankstaff")));
				hshValues.put("indinfo_is_staff", Helper.correctNull((String) rs
						.getString("indinfo_is_staff")));
			}
			
			//Recommendations
			ArrayList arrMCLR=new ArrayList();
			ArrayList arrBanking=new ArrayList();
			String strType="",strfacsel="",strFac="",StrIntType="",strFacGroup="",strAdhocFac="";
			String strAdhocArr[]=null;
			arrOutRow	=  new ArrayList();
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("com_FACSel_new^"+strAppNo+"^"+strLoanType+"^0");
			while(rs.next())
			{
				arrOutCol	= new ArrayList();
				strVal		= "";strType="";
				strFacGroup = Helper.correctInt(rs.getString("facility_sno"));
				strVal1		= Helper.correctInt(rs.getString("facility_group"));
				strVal2		= Helper.correctInt(rs.getString("facility_repaytype"));
				
				dblBaseRate=Double.parseDouble(Helper.correctDouble((String)rs.getString("facility_baserate")));
				dblInterestRate=Double.parseDouble(Helper.correctDouble((String)rs.getString("facility_sancinterest")));
				strInterestType=Helper.correctNull((String)rs.getString("facility_intsubtype"));
				strAdhocFac=Helper.correctNull(rs.getString("facility_adhocfac"));
				strAdhocArr=strAdhocFac.split("~");
				
				if(!arrBanking.contains(Helper.correctNull(rs.getString("FACILITY_PROPBANKTYPE"))))
						arrBanking.add(Helper.correctNull(rs.getString("FACILITY_PROPBANKTYPE")));
				
				
				if(rs1!=null){rs1.close();}
				rs1	= DBUtils.executeLAPSQuery("sel_facility_mclrspread^"+strFacGroup+"^"+strAppNo);
				
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
					strVal1	= "Main-Limit";
					strFac = correctNull(rs.getString("facility_desc"));
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
				
				/*if(strType.equalsIgnoreCase("1"))
				{
					arrOutCol.add(correctNull(rs.getString("com_facdesc")));//0
				}
				else
				{
					arrOutCol.add(correctNull(rs.getString("com_facdesc")));//0
				}
				*/
//				if(strType.equalsIgnoreCase("1"))
//				{
//					arrOutCol.add(correctNull(rs.getString("facility_desc")));
//				}
//				else
//				{
					arrOutCol.add(correctNull(rs.getString("facility_desc")));
				//}
				if(correctNull(rs.getString("com_headfac")).equalsIgnoreCase("1"))
				{
					double dblAmt=Double.parseDouble(Helper.correctDouble(rs.getString("facility_sancamt")));
					dblAmt=dblAmt/50;
					arrOutCol.add(String.valueOf(dblAmt));
				}else{
				arrOutCol.add(Helper.correctDouble(rs.getString("facility_sancamt")));//1
				}
				arrOutCol.add(Helper.correctDouble(rs.getString("facility_existing")));//2
				arrOutCol.add(strInterestRate);//3
				arrOutCol.add(Helper.correctInt(rs.getString("facility_sno")));//4
				arrOutCol.add(strVal1);//5
				arrOutCol.add(Helper.correctInt(rs.getString("facility_months")));//6
				arrOutCol.add(correctNull(rs.getString("facility_for")));//7
			//	arrOutCol.add(strVal);
				arrOutCol.add(strfacsel);//8
				arrOutCol.add(strVal2);//9
				arrOutCol.add(correctNull(Helper.CLOBToString(rs.getClob("facility_margin"))));//10
				strHoliday=Helper.correctInt(rs.getString("facility_holidayperiod"));
				if(strHoliday.equalsIgnoreCase("0"))
					arrOutCol.add("Not Applicable");//11
				else
					arrOutCol.add(Helper.correctInt(rs.getString("facility_holidayperiod")));
				arrOutCol.add(strInterestType);//12	
				arrOutCol.add(correctNull(rs.getString("facility_duedate")));	//13	
				String strComments="";
				strFacSno=Helper.correctNull(rs.getString("facility_sno"));
					if(rs1!=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeLAPSQuery("sel_commentsoninterestrate^commentsonintrestrate^"+strFacSno+"^"+strAppNo);
					if(rs1.next())
					{
						strComments = correctNull(Helper.CLOBToString(rs1.getClob("COM_COMMENTS")));
						if(true){
							arrOutCol.add(correctNull(Helper.CLOBToString(rs1.getClob("COM_COMMENTS"))));//14				
					}
					}
					else
					{
						arrOutCol.add("");//14
					}
					arrOutCol.add(Helper.correctNull(rs.getString("facility_duedate"))); //15
					StrIntType=Helper.correctNull(rs.getString("facility_inttype"));
					if(StrIntType.equalsIgnoreCase("flo"))
					{
						StrIntType="Floating";
					}else if(StrIntType.equalsIgnoreCase("fix")){
						StrIntType="Fixed";
					}
					arrOutCol.add(StrIntType);//16
					arrOutCol.add(Helper.correctDouble(rs.getString("fac_metlifepremiumamt")));//17
					//for CBS Branch display
					String strOrg_Name="";
					strQuery =SQLParser.getSqlQuery("sel_cbsdetails^" +strAppNo+"^"+strFacSno);
					if(rs3!=null)
					rs3.close();
					rs3 = DBUtils.executeQuery(strQuery);
					if(rs3.next())
					{
						strOrgCode=Helper.correctNull(rs3.getString("LOANDISBBRANCH"));
						strOrg_Name="";
						if(!strOrgCode.equalsIgnoreCase(""))
						{
							if(rs4!=null)
							{
								rs4.close();
							}
							strQuery=SQLParser.getSqlQuery("selectorgname^"+strOrgCode);
							rs4=DBUtils.executeQuery(strQuery);
							if(rs4.next())
							{
								strOrg_Name=Helper.correctNull((String)rs4.getString("org_name"));
								arrOutCol.add(strOrg_Name);
							//	hshRecord.put("strOrg_Name", strOrg_Name);
							}
							else{arrOutCol.add("");}
						}
						else{arrOutCol.add("");}
						}
						else{arrOutCol.add("");}
					strRoiType=Helper.correctNull(rs.getString("FAC_INS_COMPANY_NAME"));
					if(rs4!=null){rs4.close();}
					if(!strRoiType.equalsIgnoreCase(""))
					{
						rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^223^"+ strRoiType);
						if (rs4.next()) {
							arrOutCol.add(Helper.correctNull(rs4.getString("STAT_DATA_DESC1")));//19
						}
						else{arrOutCol.add("");}
					}
					else{arrOutCol.add("");}
					
					arrOutCol.add(strRoiType);//20
					
					arrOutCol.add(Helper.correctDouble(rs.getString("FAC_PREMIUM_TENOR")));//21
					arrOutCol.add(Helper.correctDouble(rs.getString("FAC_PREMIUM_LOAN_AMOUNT")));//22
					arrOutCol.add(Helper.correctDouble(rs.getString("FAC_INS_ACCOUNT_NO")));//23
					arrOutCol.add(Helper.correctDouble(rs.getString("FAC_PREMIUM_AMOUNT")));//24
					StrInsCompanyName=Helper.correctNull(rs.getString("FAC_INS_FUNDED_COMPANY_NAME"));
					if(rs4!=null){rs4.close();}
					if(!StrInsCompanyName.equalsIgnoreCase(""))
					{
						rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^223^"+ StrInsCompanyName);
						if (rs4.next()) {
							arrOutCol.add(Helper.correctNull(rs4.getString("STAT_DATA_DESC1")));//25
						}
						else{arrOutCol.add("");}
					}
					else{arrOutCol.add("");}
					//end
					
					if(Helper.correctNull(rs.getString("facility_category")).equalsIgnoreCase("A"))
						arrOutCol.add("Adhoc Limit");
					else if(Helper.correctNull(rs.getString("facility_category")).equalsIgnoreCase("R"))
						arrOutCol.add("Regular Limit");
					else if(Helper.correctNull(rs.getString("facility_category")).equalsIgnoreCase("O"))
						arrOutCol.add("One Time Limit");
					else if(Helper.correctNull(rs.getString("facility_category")).equalsIgnoreCase("D"))
						arrOutCol.add("Additional Limit");
					else
						arrOutCol.add(" ");//26
					
					if(rs4!=null){rs4.close();}
					if(!Helper.correctNull(rs.getString("fac_actualmargin")).equalsIgnoreCase(""))
					{
						rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^235^"+ Helper.correctNull(rs.getString("fac_actualmargin")));
						if (rs4.next()) {
							arrOutCol.add(Helper.correctNull(rs4.getString("STAT_DATA_DESC1")));//27
						}
						else{arrOutCol.add("");}
					}
					else{arrOutCol.add("");}
					if(rs4!=null){rs4.close();}
					if(!Helper.correctNull(rs.getString("fac_actualrelaxed")).equalsIgnoreCase(""))
					{
						rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^236^"+ Helper.correctNull(rs.getString("fac_actualrelaxed")));
						if (rs4.next()) {
							arrOutCol.add(Helper.correctNull(rs4.getString("STAT_DATA_DESC1")));//28
						}
						else{arrOutCol.add("");}
					}
					else{arrOutCol.add("");}
					
					if(Helper.correctNull(rs.getString("fac_marginrelax")).equalsIgnoreCase("Y"))
						arrOutCol.add("Yes");
					else if(Helper.correctNull(rs.getString("fac_marginrelax")).equalsIgnoreCase("N"))
						arrOutCol.add("No");
					else
						arrOutCol.add("");//29
					
					if(Helper.correctNull(rs.getString("facility_sel_type")).equalsIgnoreCase("2"))
					{
						if(rs4!=null)
						{
							rs4.close();
						}
						rs4=DBUtils.executeLAPSQuery("sel_facility_mclrreldate^"+Helper.correctInt(rs.getString("facility_oldappno"))+"^"+Helper.correctInt(rs.getString("facility_oldappsno")));
						if(rs4.next())
						{
							arrOutCol.add(Helper.correctDouble(rs4.getString("facility_sancinterest")));//30
							
							if(rs3!=null)
								rs3.close();
							rs3=DBUtils.executeLAPSQuery("sel_facility_mclrspread^"+Helper.correctInt(rs.getString("facility_oldappsno"))+"^"+Helper.correctInt(rs.getString("facility_oldappno")));
							if(rs3.next())
							{
								arrOutCol.add(Helper.correctDouble(rs3.getString("mclr_spread")));//21
								arrOutCol.add(String.valueOf(Double.parseDouble(Helper.correctDouble(rs3.getString("mclr_crp_total")))+Double.parseDouble(Helper.correctDouble(rs3.getString("mclr_bsp_total")))));//21
							}
							else
							{
								arrOutCol.add("");
								arrOutCol.add("");
							}
						}
						else
						{
							arrOutCol.add("");
							arrOutCol.add("");
							arrOutCol.add("");
						}
					}
					else
					{
						arrOutCol.add("");
						arrOutCol.add("");
						arrOutCol.add("");
					}
					
					arrOutCol.add(Helper.correctDouble(rs.getString("FACILITY_DEVIATION")));
					arrOutCol.add(Helper.correctDouble(rs.getString("FACILITY_CONCESSION")));
					arrOutCol.add(Helper.correctDouble(rs.getString("FACILITY_AS_PER_CIRCULAR")));
					
					
					if(!Helper.correctNull(rs.getString("FACILITY_MOD_INTRATE_REASON")).equalsIgnoreCase(""))
					{
						String strIntReason=Helper.correctNull(rs.getString("FACILITY_MOD_INTRATE_REASON"));
						String strArr[]=strIntReason.split("@");
						String strTemp="";
						if(strArr!=null && strArr.length>0)
						{
							for(int a=0;a<strArr.length;a++)
							{
								if(rs4!=null)
								{
									rs4.close();
								}
								rs4=DBUtils.executeLAPSQuery("getstaticdata_soldid^240^"+strArr[a]);
								if(rs4.next())
								{
									if(strTemp.equalsIgnoreCase(""))
										strTemp=Helper.correctNull(rs4.getString("stat_data_desc1"));
									else
										strTemp=strTemp+"<br/>"+Helper.correctNull(rs4.getString("stat_data_desc1"));
								}
							}
						}
						
						arrOutCol.add(strTemp);
					}
					else
					{
						arrOutCol.add("");
					}
					if(!Helper.correctNull(rs.getString("FACILITY_MOD_INTRATE_CONC")).equalsIgnoreCase(""))
					{
						String strIntReason=Helper.correctNull(rs.getString("FACILITY_MOD_INTRATE_CONC"));
						String strArr[]=strIntReason.split("@");
						String strTemp="";
						if(strArr!=null && strArr.length>0)
						{
							for(int a=0;a<strArr.length;a++)
							{
								if(rs4!=null)
								{
									rs4.close();
								}
								rs4=DBUtils.executeLAPSQuery("getstaticdata_soldid^240^"+strArr[a]);
								if(rs4.next())
								{
									if(strTemp.equalsIgnoreCase(""))
									strTemp=Helper.correctNull(rs4.getString("stat_data_desc1"));
									else
									strTemp=strTemp+"<br/>"+Helper.correctNull(rs4.getString("stat_data_desc1"));
								}
							}
						}
						
						arrOutCol.add(strTemp);
					}
					else
					{
						arrOutCol.add("");
					}
					if(!Helper.correctNull(rs.getString("FACILITY_MODE_INTRATE_CIR")).equalsIgnoreCase(""))
					{
						String strIntReason=Helper.correctNull(rs.getString("FACILITY_MODE_INTRATE_CIR"));
						String strArr[]=strIntReason.split("@");
						String strTemp="";
						if(strArr!=null && strArr.length>0)
						{
							for(int a=0;a<strArr.length;a++)
							{
								if(rs4!=null)
								{
									rs4.close();
								}
								rs4=DBUtils.executeLAPSQuery("getstaticdata_soldid^240^"+strArr[a]);
								if(rs4.next())
								{
									if(strTemp.equalsIgnoreCase(""))
										strTemp=Helper.correctNull(rs4.getString("stat_data_desc1"));
									else
										strTemp=strTemp+"<br/>"+Helper.correctNull(rs4.getString("stat_data_desc1"));
								}
							}
						}
						
						arrOutCol.add(strTemp);
					}
					else
					{
						arrOutCol.add("");
					}
					
					arrOutCol.add(Helper.correctDouble(rs.getString("facility_sancinterest")));
					
					if(rs3!=null)
						rs3.close();
					rs3=DBUtils.executeLAPSQuery("sel_facility_mclrspread^"+Helper.correctNull(rs.getString("facility_sno"))+"^"+strAppNo);
					if(rs3.next())
					{
						arrOutCol.add(Helper.correctDouble(rs3.getString("mclr_spread")));//21
						arrOutCol.add(String.valueOf(Double.parseDouble(Helper.correctDouble(rs3.getString("mclr_crp_total")))+Double.parseDouble(Helper.correctDouble(rs3.getString("mclr_bsp_total")))));//21
					}
					else
					{
						arrOutCol.add("");
						arrOutCol.add("");
					}
					arrOutCol.add(Helper.correctNull(rs.getString("facility_sel_type")));
				arrOutRow.add(arrOutCol);
				
				if(rs2!=null){rs2.close();}
				rs2	= DBUtils.executeLAPSQuery("com_FACSel_new^"+strAppNo+"^"+strLoanType+"^"+strFacGroup);
				while(rs2.next())
				{

					arrOutCol	= new ArrayList();
					strVal		= "";strType="";
					strVal1		= Helper.correctInt(rs2.getString("facility_group"));
					strVal2		= Helper.correctInt(rs2.getString("facility_repaytype"));
					
					dblBaseRate=Double.parseDouble(Helper.correctDouble((String)rs2.getString("facility_baserate")));
					dblInterestRate=Double.parseDouble(Helper.correctDouble((String)rs2.getString("facility_sancinterest")));
					strInterestType=Helper.correctNull((String)rs2.getString("facility_intsubtype"));
					strAdhocFac=Helper.correctNull(rs2.getString("facility_adhocfac"));
					strAdhocArr=strAdhocFac.split("~");
					
					if(!arrBanking.contains(Helper.correctNull(rs2.getString("FACILITY_PROPBANKTYPE"))))
						arrBanking.add(Helper.correctNull(rs2.getString("FACILITY_PROPBANKTYPE")));
					
					
					if(rs1!=null){rs1.close();}
					rs1	= DBUtils.executeLAPSQuery("sel_facility_mclrspread^"+Helper.correctInt(rs2.getString("facility_sno"))+"^"+strAppNo);
					
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
							strInterestRate=Helper.correctDouble(rs2.getString("facility_interest"));
						}
					}
					
					{
							strVal1	= "Sub-Limit";
							
							if(rs1!=null){rs1.close();}
							rs1	= DBUtils.executeLAPSQuery("sel_sublimitVal^"+strAppNo+"^"+Helper.correctInt(rs2.getString("facility_group")));
							
							if(rs1.next())
							{
								strVal1	= strVal1+" -> "+correctNull(rs1.getString("com_facdesc")).toUpperCase();
							}
						
						
						
						strType = "1";
					}
					
					if(rs1!=null){rs1.close();}
					rs1	= DBUtils.executeLAPSQuery("sel_facilityremarks^"+Helper.correctInt(rs2.getString("facility_sel_type")));
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
					
					/*if(strType.equalsIgnoreCase("1"))
					{
						arrOutCol.add(correctNull(rs.getString("com_facdesc")));//0
					}
					else
					{
						arrOutCol.add(correctNull(rs.getString("com_facdesc")));//0
					}
					*/
//					if(strType.equalsIgnoreCase("1"))
//					{
//						arrOutCol.add(correctNull(rs2.getString("facility_desc")));
//					}
//					else
//					{
						arrOutCol.add(correctNull(rs2.getString("facility_desc")));
//					}
					if(correctNull(rs2.getString("com_headfac")).equalsIgnoreCase("1"))
					{
						double dblAmt=Double.parseDouble(Helper.correctDouble(rs2.getString("facility_sancamt")));
						dblAmt=dblAmt/50;
						arrOutCol.add(String.valueOf(dblAmt));
					}else{
					arrOutCol.add(Helper.correctDouble(rs2.getString("facility_sancamt")));//1
					}
					arrOutCol.add(Helper.correctDouble(rs2.getString("facility_existing")));//2
					arrOutCol.add(strInterestRate);//3
					arrOutCol.add(Helper.correctInt(rs2.getString("facility_sno")));//4
					arrOutCol.add(strVal1);//5
					arrOutCol.add(Helper.correctInt(rs2.getString("facility_months")));//6
					arrOutCol.add(correctNull(rs2.getString("facility_for")));//7
				//	arrOutCol.add(strVal);
					arrOutCol.add(strfacsel);//8
					arrOutCol.add(strVal2);//9
					arrOutCol.add(correctNull(Helper.CLOBToString(rs2.getClob("facility_margin"))));//10
					strHoliday=Helper.correctInt(rs2.getString("facility_holidayperiod"));
					if(strHoliday.equalsIgnoreCase("0"))
						arrOutCol.add("Not Applicable");//11
					else
						arrOutCol.add(Helper.correctInt(rs2.getString("facility_holidayperiod")));
					arrOutCol.add(strInterestType);//12	
					arrOutCol.add(correctNull(rs2.getString("facility_duedate")));	//13	
					strComments="";
					strFacSno=Helper.correctNull(rs2.getString("facility_sno"));
						if(rs1!=null)
						{
							rs1.close();
						}
						rs1=DBUtils.executeLAPSQuery("sel_commentsoninterestrate^commentsonintrestrate^"+strFacSno+"^"+strAppNo);
						if(rs1.next())
						{
							strComments = correctNull(Helper.CLOBToString(rs1.getClob("COM_COMMENTS")));
							if(true){
								arrOutCol.add(correctNull(Helper.CLOBToString(rs1.getClob("COM_COMMENTS"))));//14				
						}
						}
						else
						{
							arrOutCol.add("");//14
						}
						arrOutCol.add(Helper.correctNull(rs2.getString("facility_duedate"))); //15
						StrIntType=Helper.correctNull(rs2.getString("facility_inttype"));
						if(StrIntType.equalsIgnoreCase("flo"))
						{
							StrIntType="Floating";
						}else if(StrIntType.equalsIgnoreCase("fix")){
							StrIntType="Fixed";
						}
						arrOutCol.add(StrIntType);//16
						arrOutCol.add(Helper.correctDouble(rs2.getString("fac_metlifepremiumamt")));
						//for CBS Branch display
						//String strOrg_Name="";
						strQuery =SQLParser.getSqlQuery("sel_cbsdetails^" +strAppNo+"^"+strFacSno);
						if(rs3!=null)
						rs3.close();
						rs3 = DBUtils.executeQuery(strQuery);
						if(rs3.next())
						{
							strOrgCode=Helper.correctNull(rs3.getString("LOANDISBBRANCH"));
							strOrg_Name="";
							if(!strOrgCode.equalsIgnoreCase(""))
							{
								if(rs4!=null)
								{
									rs4.close();
								}
								strQuery=SQLParser.getSqlQuery("selectorgname^"+strOrgCode);
								rs4=DBUtils.executeQuery(strQuery);
								if(rs4.next())
								{
									strOrg_Name=Helper.correctNull((String)rs4.getString("org_name"));
									arrOutCol.add(strOrg_Name);
								//	hshRecord.put("strOrg_Name", strOrg_Name);
								}
								else{arrOutCol.add("");}
							}
							else{arrOutCol.add("");}
							}
							else{arrOutCol.add("");}
						strRoiType=Helper.correctNull(rs2.getString("FAC_INS_COMPANY_NAME"));
						if(rs4!=null){rs4.close();}
						if(!strRoiType.equalsIgnoreCase(""))
						{
							rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^223^"+ strRoiType);
							if (rs4.next()) {
								arrOutCol.add(Helper.correctNull(rs4.getString("STAT_DATA_DESC1")));//19
							}
							else{arrOutCol.add("");}
						}
						else{arrOutCol.add("");}
						arrOutCol.add(strRoiType);//20
						
						arrOutCol.add(Helper.correctDouble(rs2.getString("FAC_PREMIUM_TENOR")));//21
						arrOutCol.add(Helper.correctDouble(rs2.getString("FAC_PREMIUM_LOAN_AMOUNT")));//22
						arrOutCol.add(Helper.correctDouble(rs2.getString("FAC_INS_ACCOUNT_NO")));//23
						arrOutCol.add(Helper.correctDouble(rs2.getString("FAC_PREMIUM_AMOUNT")));//24
						StrInsCompanyName=Helper.correctNull(rs2.getString("FAC_INS_FUNDED_COMPANY_NAME"));
						if(rs4!=null){rs4.close();}
						if(!StrInsCompanyName.equalsIgnoreCase(""))
						{
							rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^223^"+ StrInsCompanyName);
							if (rs4.next()) {
								arrOutCol.add(Helper.correctNull(rs4.getString("STAT_DATA_DESC1")));//25
							}
							else{arrOutCol.add("");}
						}
						else{arrOutCol.add("");}
						
						if(Helper.correctNull(rs2.getString("facility_category")).equalsIgnoreCase("A"))
							arrOutCol.add("Adhoc Limit");
						else if(Helper.correctNull(rs2.getString("facility_category")).equalsIgnoreCase("R"))
							arrOutCol.add("Regular Limit");
						else if(Helper.correctNull(rs2.getString("facility_category")).equalsIgnoreCase("O"))
							arrOutCol.add("One Time Limit");
						else if(Helper.correctNull(rs2.getString("facility_category")).equalsIgnoreCase("D"))
							arrOutCol.add("Additional Limit");
						else
							arrOutCol.add(" ");
						
						if(rs4!=null){rs4.close();}
						if(!Helper.correctNull(rs2.getString("fac_actualmargin")).equalsIgnoreCase(""))
						{
							rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^235^"+ Helper.correctNull(rs2.getString("fac_actualmargin")));
							if (rs4.next()) {
								arrOutCol.add(Helper.correctNull(rs4.getString("STAT_DATA_DESC1")));//27
							}
							else{arrOutCol.add("");}
						}
						else{arrOutCol.add("");}
						if(rs4!=null){rs4.close();}
						if(!Helper.correctNull(rs2.getString("fac_actualrelaxed")).equalsIgnoreCase(""))
						{
							rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^236^"+ Helper.correctNull(rs2.getString("fac_actualrelaxed")));
							if (rs4.next()) {
								arrOutCol.add(Helper.correctNull(rs4.getString("STAT_DATA_DESC1")));//28
							}
							else{arrOutCol.add("");}
						}
						else{arrOutCol.add("");}
						
						if(Helper.correctNull(rs2.getString("fac_marginrelax")).equalsIgnoreCase("Y"))
							arrOutCol.add("Yes");
						else if(Helper.correctNull(rs2.getString("fac_marginrelax")).equalsIgnoreCase("N"))
							arrOutCol.add("No");
						else
							arrOutCol.add("");
						/*String strmodeofrepay=Helper.correctNull(rs2.getString("facility_modeofrepay"));
						if(!strmodeofrepay.equalsIgnoreCase(""))
						{
							rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^217^"+ strmodeofrepay);
							if (rs4.next()) {
								arrOutCol.add(Helper.correctNull(rs4.getString("STAT_DATA_DESC1")));//29
							}
							else{arrOutCol.add("");}
						}*/
						if(Helper.correctNull(rs2.getString("facility_sel_type")).equalsIgnoreCase("2"))
						{
							if(rs4!=null)
							{
								rs4.close();
							}
							rs4=DBUtils.executeLAPSQuery("sel_facility_mclrreldate^"+Helper.correctInt(rs2.getString("facility_oldappno"))+"^"+Helper.correctInt(rs2.getString("facility_oldappsno")));
							if(rs4.next())
							{
								arrOutCol.add(Helper.correctDouble(rs4.getString("facility_sancinterest")));//21
								
								if(rs3!=null)
									rs3.close();
								rs3=DBUtils.executeLAPSQuery("sel_facility_mclrspread^"+Helper.correctInt(rs2.getString("facility_oldappsno"))+"^"+Helper.correctInt(rs2.getString("facility_oldappno")));
								if(rs3.next())
								{
									arrOutCol.add(Helper.correctDouble(rs3.getString("mclr_spread")));//21
									arrOutCol.add(String.valueOf(Double.parseDouble(Helper.correctDouble(rs3.getString("mclr_crp_total")))+Double.parseDouble(Helper.correctDouble(rs3.getString("mclr_bsp_total")))));//21
								}
								else
								{
									arrOutCol.add("");
									arrOutCol.add("");
								}
								
							}
							else
							{
								arrOutCol.add("");
								arrOutCol.add("");
								arrOutCol.add("");
							}
						}
						else
						{
							arrOutCol.add("");
							arrOutCol.add("");
							arrOutCol.add("");
						}
						
						arrOutCol.add(Helper.correctDouble(rs2.getString("FACILITY_DEVIATION")));
						arrOutCol.add(Helper.correctDouble(rs2.getString("FACILITY_CONCESSION")));
						arrOutCol.add(Helper.correctDouble(rs2.getString("FACILITY_AS_PER_CIRCULAR")));
						
						if(!Helper.correctNull(rs2.getString("FACILITY_MOD_INTRATE_REASON")).equalsIgnoreCase(""))
						{
							String strIntReason=Helper.correctNull(rs2.getString("FACILITY_MOD_INTRATE_REASON"));
							String strArr[]=strIntReason.split("@");
							String strTemp="";
							if(strArr!=null && strArr.length>1)
							{
								for(int a=0;a<strArr.length;a++)
								{
									if(rs4!=null)
									{
										rs4.close();
									}
									rs4=DBUtils.executeLAPSQuery("getstaticdata_soldid^240^"+strArr[a]);
									if(rs4.next())
									{
										strTemp=strTemp+"<br/>"+Helper.correctNull(rs4.getString("stat_data_desc1"));
									}
								}
							}
							
							arrOutCol.add(strTemp);
						}
						else
						{
							arrOutCol.add("");
						}
						if(!Helper.correctNull(rs2.getString("FACILITY_MOD_INTRATE_CONC")).equalsIgnoreCase(""))
						{
							String strIntReason=Helper.correctNull(rs2.getString("FACILITY_MOD_INTRATE_CONC"));
							String strArr[]=strIntReason.split("@");
							String strTemp="";
							if(strArr!=null && strArr.length>1)
							{
								for(int a=0;a<strArr.length;a++)
								{
									if(rs4!=null)
									{
										rs4.close();
									}
									rs4=DBUtils.executeLAPSQuery("getstaticdata_soldid^240^"+strArr[a]);
									if(rs4.next())
									{
										strTemp=strTemp+"<br/>"+Helper.correctNull(rs4.getString("stat_data_desc1"));
									}
								}
							}
							
							arrOutCol.add(strTemp);
						}
						else
						{
							arrOutCol.add("");
						}
						if(!Helper.correctNull(rs2.getString("FACILITY_MODE_INTRATE_CIR")).equalsIgnoreCase(""))
						{
							String strIntReason=Helper.correctNull(rs2.getString("FACILITY_MODE_INTRATE_CIR"));
							String strArr[]=strIntReason.split("@");
							String strTemp="";
							if(strArr!=null && strArr.length>1)
							{
								for(int a=0;a<strArr.length;a++)
								{
									if(rs4!=null)
									{
										rs4.close();
									}
									rs4=DBUtils.executeLAPSQuery("getstaticdata_soldid^240^"+strArr[a]);
									if(rs4.next())
									{
										strTemp=strTemp+"<br/>"+Helper.correctNull(rs4.getString("stat_data_desc1"));
									}
								}
							}
							
							arrOutCol.add(strTemp);
						}
						else
						{
							arrOutCol.add("");
						}
						arrOutCol.add(Helper.correctDouble(rs2.getString("facility_sancinterest")));
						//end
						
						if(rs3!=null)
							rs3.close();
						rs3=DBUtils.executeLAPSQuery("sel_facility_mclrspread^"+Helper.correctNull(rs2.getString("facility_sno"))+"^"+strAppNo);
						if(rs3.next())
						{
							arrOutCol.add(Helper.correctDouble(rs3.getString("mclr_spread")));//21
							arrOutCol.add(String.valueOf(Double.parseDouble(Helper.correctDouble(rs3.getString("mclr_crp_total")))+Double.parseDouble(Helper.correctDouble(rs3.getString("mclr_bsp_total")))));//21
						}
						else
						{
							arrOutCol.add("");
							arrOutCol.add("");
						}
						arrOutCol.add(Helper.correctNull(rs2.getString("facility_sel_type")));
						arrOutRow.add(arrOutCol);
				}
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			ArrayList arrOutCol1	= new ArrayList();
			ArrayList arrOutRow1	= new ArrayList();
			
			strQuery = SQLParser.getSqlQuery("sel_facility_allcomments^"+strAppNo);
			rs = DBUtils.executeQuery(strQuery);
  			while(rs.next())
			{
  				if(rs1!=null)
  				{
  					rs1.close();
  				}
  					String str_repay="repaycomment";
  					rs1 = DBUtils.executeLAPSQuery("sel_allcomments1^" + strAppNo + "^repaycomment^"+ Helper.correctNull(rs.getString("facility_sno")));
  					if (rs1.next()) 
  					{
  						arrOutCol1 = new ArrayList();
  	  					arrOutCol1.add(Helper.correctNull(rs.getString("facility_sno")));
  	  					arrOutCol1.add(Helper.correctNull(rs.getString("fac_desc")));
  						arrOutCol1.add(Helper.CLOBToString(rs1.getClob("fin_comments"))); 
  						arrOutCol1.add(Helper.correctNull(rs1.getString("FIN_STAGEWISE_RELEASE")));
  						arrOutRow1.add(arrOutCol1);
  					}
			}
  			hshValues.put("arrOutRow1", arrOutRow1);
  			
  			if(rs!=null)
  			{rs.close();}
  			
  			rs = DBUtils.executeLAPSQuery("sel_allcomments^"+strAppNo+"^repaycomment");
  			if (rs.next()) 
  			{
  				hshValues.put("fin_comments_repay", Helper.CLOBToString(rs.getClob("fin_comments")));
  			}
			
			hshValues.put("arrRecommRow", arrOutRow);
			hshValues.put("arrMCLR", arrMCLR);
			hshValues.put("arrBanking", arrBanking);
			hshValues.put("strWhetherBRAvail", strWhetherBRAvail);
			
			//MIS information
			String strSector="",strSubSector="",strcrtsales="";
			if(rs!=null){rs.close();}
			arrMISRow	= new ArrayList();
			rs	= DBUtils.executeLAPSQuery("sel_misapp_desc^"+strAppNo+"^"+strLoanType);
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
					rs1=DBUtils.executeLAPSQuery("sel_cusdetails^"+strAppId);
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
					strQuery=SQLParser.getSqlQuery("sel_minorityconstitutionchk^"+strAppId);
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
			
			//Group Concen Exposure
			arrOutRow	= new ArrayList();
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("comgroupconcernsselect_NEW^"+strOldAppId+"^"+strAppNo);
			while(rs.next())
			{
				arrOutCol		= new ArrayList();
				dblGrpExposure	= Double.parseDouble(Helper.correctDouble(rs.getString("exposure")))+dblGrpExposure;
				
				arrOutCol.add(correctNull(rs.getString("comapp_divisiontype")));
				arrOutCol.add(correctNull(rs.getString("comapp_div_name")));
				arrOutCol.add(Helper.correctDouble(rs.getString("exposure")));
				
				arrOutRow.add(arrOutCol);
			}
			
			dblTotalExposure	= dblGrpExposure+Double.parseDouble((String)hshFacVal.get("dblTotExp"));
			hshValues.put("arrGroupRow", arrOutRow);
			hshValues.put("dblGrpExposure", String.valueOf(dblGrpExposure));
			hshValues.put("dblTotalExposure", String.valueOf(dblTotalExposure));
			
			//External Rating
			arrOutRow	= new ArrayList();
			if(rs!=null){rs.close();}
			
			//String max_perappid="";
			//rs	= DBUtils.executeLAPSQuery("sel_externalRating^"+strAppNo);
			
			/*rs	= DBUtils.executeLAPSQuery("sel_max_perappid^"+strAppId);
			if(rs.next())
			{
				max_perappid = Helper.correctInt(rs.getString("max_appid"));
			}*/
			
			// Comments
			if(rs!=null){rs.close();}
			String strpgType[] = {"secoverage","secoverage1","BDCOM1","BDCOM2","brief","brief2"};
			for(int i=0;i<6;i++)
			{
				rs	= DBUtils.executeLAPSQuery("sel_comments^"+strpgType[i]+"^"+strAppNo);
				if(rs.next())
				{
					hshValues.put("com_comments"+strpgType[i], correctNull(Helper.CLOBToString(rs.getClob(("com_comments")))));
				}
			}
			
			// Agri Comments
			if(rs!=null){rs.close();}
			String strAgrType[] = {"cropincome","physicalfin","agrifarmbudget","croploan","cropass"};
			for(int i=0;i<strAgrType.length;i++)
			{
				rs	= DBUtils.executeLAPSQuery("sel_retailcomments^"+strAppNo+"^"+strAgrType[i]);
				if(rs.next())
				{
					hshValues.put("cmt_comments"+strAgrType[i], correctNull(Helper.CLOBToString(rs.getClob(("cmt_comments")))));
					hshValues.put("cmt_intercomments"+strAgrType[i], correctNull(Helper.CLOBToString(rs.getClob("cmt_intercomments"))));
				}
			}
			
			//DSS Comments
			if(rs!=null){rs.close();}
			String strAgrType1[] = {"cropass","assdss"};
			for(int i=0;i<strAgrType1.length;i++)
			{
				rs	= DBUtils.executeLAPSQuery("sel_allcomments^"+strAppNo+"^"+strAgrType1[i]);
				if(rs.next())
					hshValues.put("cmt_comments"+strAgrType1[i], correctNull(Helper.CLOBToString(rs.getClob(("fin_comments")))));
			}
			//BA Fund Total 
			/* if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("sel_BAFundTot^"+strAppNo);
			if(rs.next())
			{
				hshValues.put("fundtotal", Helper.correctDouble(rs.getString("fundtotal")));
			}*/
			hshValues.put("fundtotal","0.00");

			
			//Financial Comments 
			for(int i=0;i<strCommentSno.length;i++)
			{
				if(rs!=null){rs.close();}
				rs	= DBUtils.executeLAPSQuery("sel_financial_comments^FPComments^"+strCommentSno[i]+"^"+strAppNo);
				
				if(rs.next())
				{
					hshValues.put("FIComments"+correctNull(rs.getString("com_sno")), correctNull(Helper.CLOBToString(rs.getClob("com_comments"))));
				}
			}
			
			//Assessment Comments
			String strassmntCommentsno[]= {"1","2"};
			for(int i=0;i<strassmntCommentsno.length;i++)
			{
				if(rs!=null){rs.close();}
				rs	= DBUtils.executeLAPSQuery("sel_financial_comments^assmntcomments^"+strassmntCommentsno[i]+"^"+strAppNo);
				
				if(rs.next())
				{
					hshValues.put("AssmntComments"+correctNull(rs.getString("com_sno")), correctNull(Helper.CLOBToString(rs.getClob("com_comments"))));
				}
			}
			
			//Other Assessment Comments
			String strFlowType[]= {"35","37"};
			for(int i=0;i<strFlowType.length;i++)
			{
				if(strFlowType[i].equalsIgnoreCase("35"))
				{
					if(rs!=null){rs.close();}
					rs=DBUtils.executeLAPSQuery("sel_assessment_tl^"+strAppNo+"^"+strFlowType[i]);
					if(rs.next())
					{
						hshValues.put("com_assessment_comments"+strFlowType[i],correctNull(Helper.CLOBToString(rs.getClob("com_assessment_comments"))));
					}
				}
				if(strFlowType[i].equalsIgnoreCase("37"))
				{
					if(rs!=null){rs.close();}
					rs=DBUtils.executeLAPSQuery("sel_assessment_tl^"+strAppNo+"^"+strFlowType[i]);
					if(rs.next())
					{
						hshValues.put("strAdhocFacAssessment",correctNull(Helper.CLOBToString(rs.getClob("com_assessment_comments"))));
					}
				}
			}
			
			//Assessment Inland , Turnover comments , Repayment Schd.
			String strpage="";
			String strpageAsmt[]={"inlandComments","turnover","expenditure","cashbudget","assdscr","repaycomment","bankargmnt"};
			for(int i=0;i<strpageAsmt.length;i++)
			{
				if(rs!=null){rs.close();}
				rs = DBUtils.executeLAPSQuery("sel_allcomments^" + strAppNo + "^"+ strpageAsmt[i]);
				if (rs.next()) 
				{
					hshValues.put("fin_comments"+strpageAsmt[i], Helper.CLOBToString(rs.getClob("fin_comments")));
					hshValues.put("fin_comments1"+strpageAsmt[i], Helper.CLOBToString(rs.getClob("fin_comments1")));
				}
			}
				
			//Delegation
			arrOutRow	= new ArrayList();
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("sel_delegation^"+strAppNo);
			while(rs.next())
			{
				arrOutCol = new ArrayList();
				
				arrOutCol.add(correctNull(rs.getString("com_userid")));
				if(rs1!=null){rs1.close();}
				rs1	= DBUtils.executeLAPSQuery("sel_CBSStaticDataPassingCode^27^"+correctNull((String)rs.getString("com_userdes")));
				if(rs1.next())
				{
					//if(correctNull((String)rs1.getString("cbs_static_data_code")).trim().equals(correctNull((String)rs.getString("com_userdes")).trim()))
					//{
						arrOutCol.add(correctNull(rs1.getString("cbs_static_data_desc")));
						//break;
					//}
				}
				else
				{
					arrOutCol.add(correctNull(rs.getString("com_userdes")));
				}
				arrOutCol.add(correctNull(rs.getString("com_userdes")));
				arrOutRow.add(arrOutCol);
			}
			hshValues.put("arrDeleRow", arrOutRow);
			
			
			if(str_arr.contains("EXPORTCF@"))
			{
				ArrayList arrCOPNewRow=new ArrayList();
				//Assessment of TL: COP
				dblTotCOP	= 0.00; int m=0,z=0;
				arrOutRow	= new ArrayList();
				if(rs2!=null){rs.close();}
				rs2	= DBUtils.executeLAPSQuery("sel_termloan_facilities_fund^"+strAppNo);
				while(rs2.next())
				{
					arrCOPCol	= new ArrayList();
					
					int termSno=Integer.parseInt(Helper.correctInt(rs2.getString("term_sno")));
					arrCOPCol.add(Helper.correctInt(rs2.getString("term_sno")));
					arrCOPCol.add(correctNull(rs2.getString("term_desc")));
					arrCOPCol.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs2.getString("facility_sancamt")))));//10
					dblTotCOP=0.00;
					if(rs!=null){rs.close();}
					rs	= DBUtils.executeLAPSQuery("sel_com_copmof_desc^"+strAppNo+"^"+correctNull(rs2.getString("term_sno")));
					while(rs.next())
					{
						arrOutCol		= new ArrayList();
						
						if(correctNull(rs.getString("com_type")).equalsIgnoreCase("C"))
						{
							if(rs1!=null){rs1.close();}
							rs1	= DBUtils.executeLAPSQuery("SelStaticDataCorpQuestionMast^132");
							while(rs1.next())
							{
								if(correctNull((String)rs1.getString("stat_data_desc")).trim().equals(correctNull((String)rs.getString("com_desc_sno")).trim()))
								{
									arrOutCol.add(correctNull(rs1.getString("stat_data_desc1")));
									break;
								}
							}
							
							arrOutCol.add(Helper.correctDouble(rs.getString("com_totalvalue")));
							arrOutCol.add(Helper.correctInt(rs.getString("com_facsno")));
							dblTotCOP	= dblTotCOP+Double.parseDouble(Helper.correctDouble(rs.getString("com_totalvalue")));
						}
						
						if(arrOutCol.size()>0)
						{
							arrOutRow.add(arrOutCol);
						}
					}
					arrCOPCol.add(String.valueOf(dblTotCOP));
					if(arrOutRow.size()>0)
					{
						arrCOPRow.add(arrCOPCol);
					}
					
					arrCOPNewRow.add(arrCOPCol);
					
					String strFacilities = Helper.correctInt(rs2.getString("term_sno"));
					
					if (strFacilities!="s" && strFacilities!="")
					{
						if(rs!=null)
							rs.close();
						rs=DBUtils.executeLAPSQuery("sel_management^BreifDetaisTL"+"^"+strFacilities+"^"+strAppNo);
						if(rs.next())
						{
							hshValues.put("COM_COMMENTS_COP"+termSno,Helper.CLOBToString(rs.getClob("COM_COMMENTS")));	
							hshValues.put("COM_DATE_COP"+termSno,Helper.correctNull((String)rs.getString("COM_DATE")));
							hshValues.put("COM_PROJECTLOAN"+termSno,Helper.correctNull((String)rs.getString("com_projectloan")));
							z=m;
						}
						if(rs!=null)
							rs.close();
						rs=DBUtils.executeLAPSQuery("sel_comcomments^ExistingTerm^"+strFacilities+"^"+strAppNo);
						if (rs.next()) 
						{
							hshValues.put("COM_COMMENTS_ETL"+termSno, Helper.CLOBToString(rs.getClob("com_comments")));
							z=m;
						}
						if(rs!=null)
							rs.close();
						rs=DBUtils.executeLAPSQuery("sel_comcomments^SOM^"+strFacilities+"^"+strAppNo);
						if (rs.next()) 
						{
							hshValues.put("COM_COMMENTS_SOM"+termSno, Helper.CLOBToString(rs.getClob("com_comments")));
							z=m;
						}
						if(rs!=null)
							rs.close();
						strQuery=SQLParser.getSqlQuery("sel_comcomments1^CommentsProj^"+strFacilities+"^"+strAppNo+"^12");
						rs = DBUtils.executeQuery(strQuery);
						if (rs.next()) 
						{
							hshValues.put("COM_COMMENTS_COProj"+termSno,Helper.CLOBToString(rs.getClob("com_comments")));
						}
						for(int c=1;c<12;c++)
						{
							strQuery=SQLParser.getSqlQuery("sel_comcomments1^CommentsProj^"+strFacilities+"^"+strAppNo+"^"+c);
							rs = DBUtils.executeQuery(strQuery);
							if (rs.next()) 
							{
								hshValues.put("COM_COMMENTS_"+c+"_COProj"+termSno,Helper.CLOBToString(rs.getClob("com_comments")));
							}
						}
						
						ArrayList arrMechRow=new ArrayList();
						ArrayList arrMechcol=new ArrayList();
						strQuery=SQLParser.getSqlQuery("selcom_machineryDet^"+strAppNo+"^"+termSno);
						rs = DBUtils.executeQuery(strQuery);
						while (rs.next()) 
						{
							arrMechcol=new ArrayList();
							arrMechcol.add(Helper.correctNull(rs.getString("COM_particulars")));
							arrMechcol.add(Helper.correctNull(rs.getString("COM_supplier")));
							arrMechcol.add(Helper.correctNull(rs.getString("COM_quantity")));
							arrMechcol.add(Helper.correctNull(rs.getString("COM_unitpercost")));
							arrMechcol.add(Helper.correctNull(rs.getString("COM_amount")));
							arrMechRow.add(arrMechcol);
						}
						hshValues.put("arrMechRow"+termSno,arrMechRow);
						
					}								
					if(rs!=null)
					{				
						rs.close();
					}
					m++;
				}
				hshValues.put("ValofM",String.valueOf(z));
				hshValues.put("arrCOPMjrRow", arrCOPRow);
				hshValues.put("arrCOPRow", arrOutRow);
				hshValues.put("dblTotCOP", String.valueOf(dblTotCOP));
				hshValues.put("arrCOPNewRow",arrCOPNewRow);
				
				//Assessment of TL: MOF
				String strFlag	 = "false",strdescSno="";
				double dbl_BankSubLoan=0.00;
				double dbl_Othermfinance=0.00;
				double dbl_Debit=0.00;
				m=0;
				dblTotCOP	= 0.00;
				arrOutRow	= new ArrayList();
				if(rs2!=null){rs.close();}
				rs2	= DBUtils.executeLAPSQuery("sel_termloan_facilities_fund^"+strAppNo);
				while(rs2.next())
				{
					arrMOFCol	= new ArrayList();
					dbl_Debit=0.00;
					dbl_Othermfinance=0.00;
					dbl_BankSubLoan=0.00;
					dblTotCOP=0.00;
					arrMOFCol.add(Helper.correctInt(rs2.getString("term_sno")));
					arrMOFCol.add(correctNull(rs2.getString("term_desc")));
					if(rs!=null){rs.close();}
					rs	= DBUtils.executeLAPSQuery("sel_com_copmof_desc^"+strAppNo+"^"+correctNull(rs2.getString("term_sno")));
					while(rs.next())
					{
						arrOutCol		= new ArrayList();
						strdescSno = Helper.correctNull(rs.getString("COM_DESC_SNO"));
						
						if(correctNull(rs.getString("com_type")).equalsIgnoreCase("M"))
						{
							if(rs1!=null){rs1.close();}
							rs1	= DBUtils.executeLAPSQuery("SelStaticDataCorpQuestionMast^137");
							while(rs1.next())
							{
								if(correctNull((String)rs1.getString("stat_data_desc")).trim().equals(correctNull((String)rs.getString("com_desc_sno")).trim()))
								{
									strFlag	= "true";
									arrOutCol.add(correctNull(rs1.getString("stat_data_desc1")));
									break;
								}
							}
							
							arrOutCol.add(Helper.correctDouble(rs.getString("com_totalvalue")));
							arrOutCol.add(Helper.correctInt(rs.getString("com_facsno")));
							dblTotCOP	= dblTotCOP+Double.parseDouble(Helper.correctDouble(rs.getString("com_totalvalue")));
						}
						
						if((strdescSno.endsWith("1"))||(strdescSno.endsWith("2")))
						{
							if(correctNull(rs.getString("com_type")).equalsIgnoreCase("M"))
							{
								dbl_BankSubLoan+=Double.parseDouble(Helper.correctDouble(rs.getString("COM_TOTALVALUE")));
							}
						}
						else 
						{
							if(correctNull(rs.getString("com_type")).equalsIgnoreCase("M"))
							{
								dbl_Othermfinance+=Double.parseDouble(Helper.correctDouble(rs.getString("COM_TOTALVALUE")));
							}
						}
						
						if(arrOutCol.size()>0)
						{
							arrOutRow.add(arrOutCol);
						}
						
					}
					arrMOFCol.add(String.valueOf(dblTotCOP));
					if(dbl_Othermfinance!=0.0)
					{
						dbl_Debit=dbl_BankSubLoan/dbl_Othermfinance;  
					}
					else
					{
						dbl_Debit=dbl_BankSubLoan;
					}
					hshValues.put("dbl_Debit"+correctNull(rs2.getString("term_sno")),""+dc.format(dbl_Debit));
					if(arrOutRow.size()>0)
					{
						arrMOFRow.add(arrMOFCol);
					}
					m++;
				}
				
				hshValues.put("arrMOFMjrRow", arrMOFRow);
				hshValues.put("arrMOFRow", arrOutRow);
				hshValues.put("dblTotMOF", String.valueOf(dblTotCOP));
				
				//Release Pattern 
				
				ArrayList arrReleaseRow=new ArrayList();
				ArrayList arrRowPattern	=	new ArrayList();
				
				if(rs2!=null){rs.close();}
				rs2	= DBUtils.executeLAPSQuery("sel_termloan_facilities_fund^"+strAppNo);
				int y=0;int x=0;
				dblRPTotCost=0.0;
				dblRPTotMargin=0.0;
				dblRPTotLoan=0.0;
				boolean boorelflag=true;
				int abc=0;
				while(rs2.next())
				{
					boorelflag=true;
					arrImplSchRow=new ArrayList();
					ArrayList arrReleaseCol=new ArrayList();
					ArrayList arrColPattern=new ArrayList();
					String strTermSno=Helper.correctInt(rs2.getString("term_sno"));
					
					arrReleaseCol.add(correctNull(rs2.getString("term_sno")));	//0
					arrReleaseCol.add(correctNull(rs2.getString("term_desc")));	//1
					arrFinSnoRow.add(arrReleaseCol);
					abc++;
					if(rs!=null){rs.close();}
					rs	= DBUtils.executeLAPSQuery("sel_com_copmof_margin1_new^"+strAppNo+"^"+correctNull(rs2.getString("term_sno")));
					while(rs.next())
					{
						arrColPattern=new ArrayList();
						if(boorelflag)
						{ 
							arrReleaseCol.add("ReleasePattern");//2
						}
						
						boorelflag=false;
						if(rs1!=null){rs1.close();}
						rs1	= DBUtils.executeLAPSQuery("SelStaticDataCorpQuestionMast^132");
						while(rs1.next())
						{
							if(correctNull((String)rs1.getString("stat_data_desc")).trim().equals(correctNull((String)rs.getString("com_sno")).trim()))
							{
								arrColPattern.add(correctNull(rs1.getString("stat_data_desc1")));//0
								break;
							}
						}
						
						dblRPTotCost	= dblRPTotCost+Double.parseDouble(Helper.correctDouble(rs.getString("com_amount")));
						dblRPTotMargin	= dblRPTotMargin+Double.parseDouble(Helper.correctDouble(rs.getString("com_margin")));
						dblRPTotLoan	= dblRPTotLoan+Double.parseDouble(Helper.correctDouble(rs.getString("com_bankloan")));
					
						arrColPattern.add(Helper.correctDouble(rs.getString("com_amount")));//1
						arrColPattern.add(Helper.correctDouble(rs.getString("com_margin")));//2
						arrColPattern.add(Helper.correctDouble(rs.getString("com_marginamt")));//3
						arrColPattern.add(Helper.correctDouble(rs.getString("com_bankloan")));//4
						arrColPattern.add(Helper.correctDouble(rs.getString("com_bankloanamt")));//5
						arrColPattern.add(Helper.correctInt(rs.getString("com_facsno")));//6
						arrRowPattern.add(arrColPattern);
					}
					if(boorelflag)
					{ 
						arrReleaseCol.add("0");//2
						boorelflag=true;
					}
					
					hshValues.put("arrRowPattern"+x,arrRowPattern);
					arrRowPattern=new ArrayList();
					hshValues.put("dblRPTotCost"+x, String.valueOf(dblRPTotCost));
					hshValues.put("dblRPTotMargin"+x, String.valueOf(dblRPTotMargin));
					hshValues.put("dblRPTotLoan"+x, String.valueOf(dblRPTotLoan));
					dblRPTotCost=0.0;
					dblRPTotMargin=0.0;
					dblRPTotLoan=0.0;
					if (strTermSno!="s" && strTermSno!="")
					{
						rs=DBUtils.executeLAPSQuery("sel_management^BreifDetaisTL"+"^"+strTermSno+"^"+strAppNo);
						if(rs.next())
						{
							arrReleaseCol.add(correctNull(rs.getString("com_date")));	//8
							arrReleaseCol.add("Estimate");								//9
						}
						else
						{
							arrReleaseCol.add("0");//8
							arrReleaseCol.add("0");//9
						}
						
					}
					arrReleaseCol.add(jtn.format(Double.parseDouble((String)Helper.correctDouble(rs2.getString("facility_sancamt")))));//10
					arrReleaseRow.add(arrReleaseCol);
					x++;
				}
				
				hshValues.put("arrReleaseRow",arrReleaseRow);
				
				if(rs!=null)
				{rs.close();}
				if(rs!=null){rs.close();}
				if(rs2!=null){rs.close();}
				
				rs2	= DBUtils.executeLAPSQuery("sel_termloan_facilities_fund^"+strAppNo);
				while(rs2.next())
				{
					boorelflag=true;
					arrImplSchCol	= new ArrayList();
					arrOutRow	= new ArrayList();
					String strTermSno=Helper.correctInt(rs2.getString("term_sno"));
					arrImplSchCol.add(strTermSno);
					arrImplSchCol.add(correctNull(rs2.getString("term_desc")));
					rs	= DBUtils.executeLAPSQuery("sel_implnschedulesno^"+strAppNo+"^"+"^"+strTermSno);
					while(rs.next())
						{
							arrOutCol		= new ArrayList();
							arrOutCol.add(correctNull(rs2.getString("term_desc")));
							arrOutCol.add(correctNull(rs.getString("com_desc")));
							arrOutCol.add(correctNull(rs.getString("com_commencedate")));
							arrOutCol.add(correctNull(rs.getString("com_completiondate")));
							arrOutCol.add(correctNull(rs.getString("com_status")));
							
							arrOutRow.add(arrOutCol);
						}
					arrImplSchCol.add(arrOutRow);
					arrImplSchCol.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs2.getString("facility_sancamt")))));
					arrImplSchRow.add(arrImplSchCol);
				}		
				hshValues.put("arrImplSchRow", arrImplSchRow);
			
				
				//Source of Margin
				if(rs!=null){rs.close();}
				rs	= DBUtils.executeLAPSQuery("sel_comments^SOM^"+strAppNo);
				if(rs.next())
				{
					hshValues.put("SOMComments", correctNull(Helper.CLOBToString(rs.getClob(("com_comments")))));
				}
			}
			
			//Release Pattern
			dblTotCOP	= 0.00;
			String termSno="";
			int abc=1;
			arrOutRow	= new ArrayList();
			if(rs2!=null){rs.close();}
			rs2	= DBUtils.executeLAPSQuery("sel_termloan_facilities_fund^"+strAppNo);
			if(rs!=null){rs.close();}
			
			while(rs2.next())
			{
				arrRelPatCol	= new ArrayList();
				termSno=Helper.correctInt(rs2.getString("term_sno"));
				arrRelPatCol.add(Helper.correctInt(rs2.getString("term_sno")));
				arrRelPatCol.add(correctNull(rs2.getString("term_desc")));
				
				rs	= DBUtils.executeLAPSQuery("sel_com_copmof_margin1_new^"+strAppNo+"^"+correctNull(rs2.getString("term_sno")));
				while(rs.next())
				{
					arrOutCol		= new ArrayList();
					
					if(rs1!=null){rs1.close();}
					rs1	= DBUtils.executeLAPSQuery("SelStaticDataCorpQuestionMast^132");
					while(rs1.next())
					{
						if(correctNull((String)rs1.getString("stat_data_desc")).trim().equals(correctNull((String)rs.getString("com_sno")).trim()))
						{
							arrOutCol.add(correctNull(rs1.getString("stat_data_desc1")));
							break;
						}
					}
					
					arrOutCol.add(Helper.correctDouble(rs.getString("com_amount")));
					arrOutCol.add(Helper.correctDouble(rs.getString("com_margin")));
					arrOutCol.add(Helper.correctDouble(rs.getString("com_marginamt")));
					arrOutCol.add(Helper.correctDouble(rs.getString("com_bankloan")));
					arrOutCol.add(Helper.correctDouble(rs.getString("com_bankloanamt")));
					arrOutCol.add(Helper.correctInt(rs.getString("com_facsno")));
					
					dblRPTotCost	= dblRPTotCost+Double.parseDouble(Helper.correctDouble(rs.getString("com_amount")));
					dblRPTotMargin	= dblRPTotMargin+Double.parseDouble(Helper.correctDouble(rs.getString("com_margin")));
					dblRPTotLoan	= dblRPTotLoan+Double.parseDouble(Helper.correctDouble(rs.getString("com_bankloan")));
					abc++;
					if(arrOutCol.size()>0)
					{
						arrOutRow.add(arrOutCol);
					}
				}
				
			}
			if(arrOutRow.size()>0)
			{
				arrRelPatRow.add(arrRelPatCol);
			}
			hshValues.put("dblRPTotCost", String.valueOf(dblRPTotCost));
			hshValues.put("dblRPTotMargin", String.valueOf(dblRPTotMargin));
			hshValues.put("dblRPTotLoan", String.valueOf(dblRPTotLoan));
			hshValues.put("arrRelPatrnMjrRow", arrRelPatRow);
			hshValues.put("arrRelPatrnRow", arrOutRow);
			hshValues.put("arrRelPatColNew", arrRelPatCol);
			
			//DSCR
			if(str_arr.contains("DSCR@"))
			{
				hshFinValues	= new HashMap();
				hshFinValues.put("appno", strAppNo);
				hshFinValues	= dscrobj.getPrintValues(hshFinValues);
				hshValues.put("DSCRhshFinValues",hshFinValues);
			
				//SENSITIVITY -  Added by DINESH on 31/03/2014
				hshFinSenValues	= new HashMap();
				hshFinSenValues.put("appno", strAppNo);
				hshFinSenValues	= dscrobj.getPrintSensitivityVal(hshFinSenValues);
				hshValues.put("SENSITIVITYhshFinValues",hshFinSenValues);
			}
			
			//For Security Coverage display by Guhan T
			HashMap hshsec = new HashMap();
			SecurityMasterBean sec = new SecurityMasterBean();
			hshReqValues.put("hidapplicantid", strOldAppId);
			hshsec = sec.getCollateralSecurityDisplaynew(hshReqValues);
			ArrayList arrRow = new ArrayList();
			arrRow = (ArrayList)hshsec.get("arrRow");
			hshValues.put("arrRow", arrRow);
			hshValues.put("dbl_exifundostot", hshsec.get("dbl_exifundostot"));
			hshValues.put("dbl_exinonfundostot", hshsec.get("dbl_exinonfundostot"));
			hshValues.put("dbl_propfundostot", hshsec.get("dbl_propfundostot"));
			hshValues.put("dbl_propnonfundostot", hshsec.get("dbl_propnonfundostot"));
			hshValues.put("dbl_totvalexis", hshsec.get("dbl_totvalexis"));
			hshValues.put("dbl_totvalproposed", hshsec.get("dbl_totvalproposed"));
			hshValues.put("dbl_secexitot", hshsec.get("dbl_secexitot"));
			hshValues.put("dbl_secexicoverage", hshsec.get("dbl_secexicoverage"));
			hshValues.put("dbl_secpropcoverage", hshsec.get("dbl_secpropcoverage"));
			
			
			//For Comments by Guhan T
			if(rs!=null)rs.close();
			String strQuery5 = SQLParser.getSqlQuery("selexistingfaccomm^"+strAppNo);
			rs = DBUtils.executeQuery(strQuery5);
			while(rs.next())
			{hshValues.put("existing_comments",Helper.CLOBToString(rs.getClob("CMT_COMMENTS")));}
			if(rs!=null)rs.close();
			String strQuery6 = SQLParser.getSqlQuery("selpriseccomm^"+strAppNo);
			rs = DBUtils.executeQuery(strQuery6);
			while(rs.next())
			{hshValues.put("prisec_comments",Helper.CLOBToString(rs.getClob("CMT_COMMENTS")));}
			if(rs!=null)rs.close();
			String strQuery7 = SQLParser.getSqlQuery("selcollseccomm^"+strAppNo);
			rs = DBUtils.executeQuery(strQuery7);
			while(rs.next())
			{hshValues.put("collsec_comments",Helper.CLOBToString(rs.getClob("CMT_COMMENTS")));}
			
			if(rs!=null)rs.close();
			strQuery5 = SQLParser.getSqlQuery("sel_comcommentscopmof^COPMOF^20^"+strAppNo);
			rs = DBUtils.executeQuery(strQuery5);
			if(rs.next())
			{
				hshValues.put("copmofcomments",Helper.CLOBToString(rs.getClob("com_comments")));
			}
			ArrayList arrCol=new ArrayList();
			 arrRow=new ArrayList();
			//com_assessmentselection_select
			 FinancialBean financial=new FinancialBean();
			 ComProposalBean comproposal=new ComProposalBean();
			 HashMap hshRequestValues=new HashMap();
			
			if(str_arr.contains("TO@"))
			{
				/*
				 * 
    TO@Exp@CFS@MED1@MED2@WCGMED@EXPORTCF@DSCR@CASHBUD@NFA@AOA@ASR@ 
				 */
				 
				 arrRow=new ArrayList();
				if(rs!=null){rs.close();}
				rs	= DBUtils.executeLAPSQuery("sel_turnoverMethod^"+strAppNo);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull(rs.getString("COM_TO_YEAR")));
					arrCol.add(Helper.correctNull(rs.getString("COM_TO_PROJSALES")));
					arrCol.add(Helper.correctNull(rs.getString("COM_TO_ACPTPROJSALES")));
					arrCol.add(Helper.correctNull(rs.getString("COM_TO_PERCENTACPTPROJSALES")));
					arrCol.add(Helper.correctNull(rs.getString("COM_TO_MINMARGIN")));
					arrCol.add(Helper.correctNull(rs.getString("COM_TO_ELIGIBLEFIN")));
					arrCol.add(Helper.correctNull(rs.getString("COM_TO_ACTUALMARGIN")));
					arrCol.add(Helper.correctNull(rs.getString("COM_TO_ELIGIBLEBANKFIN")));
					arrCol.add(Helper.correctNull(rs.getString("COM_TO_PERMISIBLEFIN")));
					arrCol.add(Helper.correctNull(rs.getString("COM_TO_LIMITSOUGHT")));
					arrCol.add(Helper.correctNull(rs.getString("COM_TO_LIMITPROPOSED")));
					arrCol.add(Helper.correctNull(rs.getString("COM_TO_REQMARGIN")));
					arrCol.add(Helper.correctNull(rs.getString("COM_TO_SURPLUS")));
					arrRow.add(arrCol);
				}
				hshValues.put("TurnOver",arrRow);
			}
			if(str_arr.contains("Exp@"))
			{
				//Expenditure Method
				arrOutRow	= new ArrayList();
				if(rs!=null){rs.close();}
				rs	= DBUtils.executeLAPSQuery("sel_expenditureMethod^"+strAppNo);
				while(rs.next())
				{
					arrOutCol	= new ArrayList();
					
					arrOutCol.add(correctNull(rs.getString("com_exp_year")));
					arrOutCol.add(Helper.correctDouble(rs.getString("com_exp_projexpnd")));
					arrOutCol.add(Helper.correctDouble(rs.getString("com_exp_acptprojexpnd")));
					arrOutCol.add(Helper.correctDouble(rs.getString("com_exp_operationcycle")));
					arrOutCol.add(Helper.correctDouble(rs.getString("com_exp_eligibleexpnd")));
					arrOutCol.add(Helper.correctDouble(rs.getString("com_exp_permisiblefin")));
					arrOutCol.add(Helper.correctDouble(rs.getString("com_exp_limitsought")));
					arrOutCol.add(Helper.correctDouble(rs.getString("com_exp_limitproposed")));
					
					arrOutRow.add(arrOutCol);
				}
				hshValues.put("arrExpRow", arrOutRow);
			}
			if(str_arr.contains("CFS@"))
			{
				if(rs!=null){rs.close();}
				int c=1,d=0,n=1;
				rs1	= DBUtils.executeLAPSQuery("sel_finYear^"+strAppNo);
				while(rs1.next())
				{d++;n=2; arrRow=new ArrayList();
				rs	= DBUtils.executeLAPSQuery("sel_cashflowMethod^"+strAppNo+"^"+Helper.correctNull(rs1.getString(1)));
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_YEAR")));
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_OPENINGBAL")));
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_PROMOTEREQUITY")));
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_BANKFINANCE")));
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_UNSECLOAN")));
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_SALEPROCEEDS")));
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_OTHER")));
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_SOF_TOTAL"))); 
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_COSTOFLAND")));
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_PREMIUMFSI")));
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_CONSTRUCTCOST")));
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_MARKETEXPENSES")));
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_ADMINEXPENSES")));
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_OTHERFIN")));
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_INTEREST")));
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_REPAYMENT")));
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_PROVISIONTAX")));
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_APPFIN_TOTAL")));
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_CLOSINGBALANCE")));
					arrRow.add(arrCol);
					if(!Helper.correctNull(rs.getString("COM_CF_YEAR")).equalsIgnoreCase(""))//0)
					{
					hshValues.put("rowcount"+(d),""+(n++));
					}
					hshValues.put("finyear"+(d),Helper.correctNull(rs.getString("COM_CF_FINYEAR")));
				}
				for(int h=0;arrRow.size()<15;h++)
				{
					arrCol=new ArrayList();
					for(int k=0;k<16;k++)
					{
					arrCol.add("");
					}
					arrRow.add(arrCol);
				}
				hshValues.put("CashFlow"+(c),arrRow);
				c++;
				}
				hshValues.put("CashCount",""+(d));
				
				rs	= DBUtils.executeLAPSQuery("sel_cashflow_projTot^"+strAppNo+"^"+"1");
				while(rs.next())
				{
					dbl_opnBal=Double.parseDouble((String)rs.getString("COM_CF_OPENINGBAL"));
					dbl_allopnBal=dbl_allopnBal+dbl_opnBal;
					
					dbl_proEqt=Double.parseDouble((String)rs.getString("COM_CF_PROMOTEREQUITY"));
					dbl_allproEqt=dbl_allproEqt+dbl_proEqt;
					
					dbl_bnkFin=Double.parseDouble((String)rs.getString("COM_CF_BANKFINANCE"));
					dbl_allbnkFin=dbl_allbnkFin+dbl_bnkFin;
					
					dbl_unsec=Double.parseDouble((String)rs.getString("COM_CF_UNSECLOAN"));
					dbl_allunsec=dbl_allunsec+dbl_unsec;
					
					dbl_saleProc=Double.parseDouble((String)rs.getString("COM_CF_SALEPROCEEDS"));
					dbl_allsaleProc=dbl_allsaleProc+dbl_saleProc;
					
					dbl_other=Double.parseDouble((String)rs.getString("COM_CF_OTHER"));
					dbl_allother=dbl_allother+dbl_other;
					
					dbl_sofTot=Double.parseDouble((String)rs.getString("COM_CF_SOF_TOTAL"));
					dbl_allsofTot=dbl_allsofTot+dbl_sofTot;
					
					dbl_costLand=Double.parseDouble((String)rs.getString("COM_CF_COSTOFLAND"));
					dbl_allcostLand=dbl_allcostLand+dbl_costLand;
					
					dbl_premiumfsi=Double.parseDouble((String)rs.getString("COM_CF_PREMIUMFSI"));
					dbl_allpremiumfsi=dbl_allpremiumfsi+dbl_premiumfsi;
					
					dbl_constcost=Double.parseDouble((String)rs.getString("COM_CF_CONSTRUCTCOST"));
					dbl_allconstcost=dbl_allconstcost+dbl_constcost;
					
					dbl_marketexp=Double.parseDouble((String)rs.getString("COM_CF_MARKETEXPENSES"));
					dbl_allmarketexp=dbl_allmarketexp+dbl_marketexp;
					
					dbl_adminexp=Double.parseDouble((String)rs.getString("COM_CF_ADMINEXPENSES"));
					dbl_alladminexp=dbl_alladminexp+dbl_adminexp;
					
					dbl_interest=Double.parseDouble((String)rs.getString("COM_CF_INTEREST"));
					dbl_allinterest=dbl_allinterest+dbl_interest;
					
					dbl_repayment=Double.parseDouble((String)rs.getString("COM_CF_REPAYMENT"));
					dbl_allrepayment=dbl_allrepayment+dbl_repayment;
					
					dbl_provTax=Double.parseDouble((String)rs.getString("COM_CF_PROVISIONTAX"));
					dbl_allprovTax=dbl_allprovTax+dbl_provTax;
					
					dbl_otherFin=Double.parseDouble((String)rs.getString("COM_CF_OTHERFIN"));
					dbl_allotherFin=dbl_allotherFin+dbl_otherFin;
					
					dbl_appfinTot=Double.parseDouble((String)rs.getString("COM_CF_APPFIN_TOTAL"));
					dbl_allappfinTot=dbl_allappfinTot+dbl_appfinTot;
					
					dbl_closingBal=Double.parseDouble((String)rs.getString("COM_CF_CLOSINGBALANCE"));
					dbl_allclosingBal=dbl_allclosingBal+dbl_closingBal;
					
				}
				arrRow=new ArrayList();
				arrCol=new ArrayList();
				arrCol.add("Projected");
				arrCol.add(""+dc.format(dbl_allopnBal));
				arrCol.add(""+dc.format(dbl_allproEqt));
				arrCol.add(""+dc.format(dbl_allbnkFin));
				arrCol.add(""+dc.format(dbl_allunsec));
				arrCol.add(""+dc.format(dbl_allsaleProc));
				arrCol.add(""+dc.format(dbl_allother));
				arrCol.add(""+dc.format(dbl_allsofTot));
				arrCol.add(""+dc.format(dbl_allcostLand));
				arrCol.add(""+dc.format(dbl_allpremiumfsi));
				arrCol.add(""+dc.format(dbl_allconstcost));
				arrCol.add(""+dc.format(dbl_allmarketexp));
				arrCol.add(""+dc.format(dbl_alladminexp));
				arrCol.add(""+dc.format(dbl_allotherFin));
				arrCol.add(""+dc.format(dbl_allinterest));
				arrCol.add(""+dc.format(dbl_allrepayment));
				arrCol.add(""+dc.format(dbl_allprovTax));
				arrCol.add(""+dc.format(dbl_allappfinTot));
				arrCol.add(""+dc.format(dbl_allclosingBal));
				arrRow.add(arrCol);
				
				hshValues.put("CashFlowTOT",arrRow);
							
			}
			if(str_arr.contains("MED1@"))
			{
				hshRequestValues=new HashMap();
				hshRequestValues.put("appno", strAppNo);
				hshRequestValues.put("page", "MU");
				hshRequestValues.put("pagefrom1", "M1");
				hshRequestValues.put("printYear", "Y");
				hshRequestValues=	financial.getDataRatio(hshRequestValues);
				hshRequestValues.put("page", "Method I of lending other than export limits");
				hshValues.put("method1",hshRequestValues);
				
				HashMap hshassess=new HashMap();
				hshassess.put("appno",strAppNo);
				hshassess.put("page","INV");
				hshassess.put("pagefrom1","I1");
				hshassess.put("printYear", "Y");
				hshassess.put("pagename", "M1");
				hshassess=	financial.getDataAssessment(hshassess);
				hshassess.put("pageType", "processnote");
				hshValues.put("hshnewM1",hshassess);
			}
			if(str_arr.contains("MED2@"))
			{
				hshRequestValues=new HashMap();
				hshRequestValues.put("appno", strAppNo);
				hshRequestValues.put("page", "MU");
				hshRequestValues.put("pagefrom1", "M2");
				hshRequestValues.put("printYear", "Y");
				hshRequestValues=	financial.getDataRatio(hshRequestValues);
				hshRequestValues.put("page", "Method II of lending other than export limits");
				hshValues.put("method2",hshRequestValues);
				
				HashMap hshassess=new HashMap();
				hshassess.put("appno",strAppNo);
				hshassess.put("page","INV");
				hshassess.put("pagefrom1","I1");
				hshassess.put("printYear", "Y");
				hshassess.put("pagename", "M2");
				hshassess=	financial.getDataAssessment(hshassess);
				hshassess.put("pageType", "processnote");
				hshValues.put("hshnewM2",hshassess);
			}
			if(str_arr.contains("WCGMED@"))
			{
				hshRequestValues=new HashMap();
				hshRequestValues.put("appno", strAppNo);
				hshRequestValues.put("page", "FL");
				hshRequestValues.put("pagefrom1", "AFL");
				hshRequestValues.put("printYear", "Y");
				hshRequestValues=	financial.getDataRatio(hshRequestValues);
				hshRequestValues.put("page", "Assessment of working capital limits");
				hshValues.put("method3",hshRequestValues);
				
				HashMap hshassess=new HashMap();
				hshassess.put("appno",strAppNo);
				hshassess.put("page","INV");
				hshassess.put("pagefrom1","I1");
				hshassess.put("printYear", "Y");
				hshassess.put("pagename", "AFL");
				hshassess=	financial.getDataAssessment(hshassess);
				hshassess.put("pageType", "processnote");
				hshValues.put("hshnewAFL",hshassess);
			}
			
			if(str_arr.contains("AOI@"))
			{
				if(rs!=null){rs.close();}
				int c=1,d=0,n=1;
				String strDate="";
				arrOutRowCons=new ArrayList();
				rs1	= DBUtils.executeLAPSQuery("sel_inland_finYear^"+strAppNo);
				while(rs1.next())
				{
					
					strDate="";
					strDate=Helper.correctNull(rs1.getString("com_ia_year"));
					if(!strDate.equalsIgnoreCase(""))
					{
						d++;n=2; 
						arrRow=new ArrayList();
						rs	= DBUtils.executeLAPSQuery("sel_fin_inlandAssessment^"+strAppNo+"^"+strDate);
						while(rs.next())
						{
							arrCol=new ArrayList();
							arrCol.add(Helper.correctNull(rs.getString("COM_IA_YEAR")));
							arrCol.add(Helper.correctNull(rs.getString("COM_IA_SALES")));
							arrCol.add(Helper.correctNull(rs.getString("COM_IA_PURCHASES")));
							arrCol.add(Helper.correctNull(rs.getString("COM_IA_PROJPURCHASES")));
							arrCol.add(Helper.correctNull(rs.getString("COM_IA_AVGMONPURCHASES")));
							arrCol.add(Helper.correctNull(rs.getString("COM_IA_CREDITPERIOD")));
							arrCol.add(Helper.correctNull(rs.getString("COM_IA_TRANSITPERIOD")));
							arrCol.add(Helper.correctNull(rs.getString("COM_IA_LCREQUIRED")));
							arrCol.add(Helper.correctNull(rs.getString("COM_IA_APPLIEDLIMIT")));
							arrCol.add(Helper.correctNull(rs.getString("COM_IA_RECOMMLIMIT")));
						//	arrCol.add(Helper.correctNull(rs.getString("COM_IA_YEAR")));
							arrRow.add(arrCol);
						}
						arrOutRowCons.add(arrRow);
					}
				}
				hshValues.put("Inland",arrOutRowCons);
				hshValues.put("InlandCount",""+(d));
			}
			if(str_arr.contains("CASHBUD@"))
			{
				int i=0,j=1,k=0;
				 arrRow=new ArrayList();
				if(rs!=null){rs.close();}
				rs	= DBUtils.executeLAPSQuery("sel_count_cashbudgetyear^"+strAppNo);
				while(rs.next())
				{
					i+=1;j=2;
					arrRow=new ArrayList();
					if(rs1!=null){rs1.close();}
					rs1	= DBUtils.executeLAPSQuery("com_cash_budget_method_sel^"+strAppNo+"^"+Helper.correctNull(rs.getString("CCBM_YEAR")));
					while(rs1.next())
					{
						arrCol=new ArrayList();
						hshValues.put("rowtype"+(i),Helper.correctNull(rs1.getString("CCBM_TYPE")));
						if(rs1.isLast()){arrCol.add("Total");//0}
						}
						else
						{
							arrCol.add(Helper.correctNull(rs1.getString("CCBM_VAL")));//0
						}
						arrCol.add(Helper.checkDecimal(Helper.correctNull(rs1.getString("CCBM_NT_CONTRCT_RCPT"))));
						arrCol.add(Helper.checkDecimal(Helper.correctNull(rs1.getString("CCBM_SB_CONTRCT_RCPT"))));
						arrCol.add(Helper.checkDecimal(Helper.correctNull(rs1.getString("CCBM_OTHR_RCPT"))));
						arrCol.add(Helper.checkDecimal(Helper.correctNull(rs1.getString("CCBM_TOT_RCPT"))));
						arrCol.add(Helper.checkDecimal(Helper.correctNull(rs1.getString("CCBM_MATERIALS"))));//5
						arrCol.add(Helper.checkDecimal(Helper.correctNull(rs1.getString("CCBM_SAL_WGS"))));
						arrCol.add(Helper.checkDecimal(Helper.correctNull(rs1.getString("CCBM_SB_CONTRCT"))));
						arrCol.add(Helper.checkDecimal(Helper.correctNull(rs1.getString("CCBM_HIRE_CHRG"))));
						arrCol.add(Helper.checkDecimal(Helper.correctNull(rs1.getString("CCBM_LBR_CHRG"))));
						arrCol.add(Helper.checkDecimal(Helper.correctNull(rs1.getString("CCBM_DSL_PTRL_CHRG"))));//10
						arrCol.add(Helper.checkDecimal(Helper.correctNull(rs1.getString("CCBM_RPR_MNT"))));
						arrCol.add(Helper.checkDecimal(Helper.correctNull(rs1.getString("CCBM_TRVL_EXP"))));
						arrCol.add(Helper.checkDecimal(Helper.correctNull(rs1.getString("CCBM_OTHR_OPRTNG_EXP"))));
						arrCol.add(Helper.checkDecimal(Helper.correctNull(rs1.getString("CCBM_BNK_INT_CHRG"))));
						arrCol.add(Helper.checkDecimal(Helper.correctNull(rs1.getString("CCBM_TAX_PAY"))));
						arrCol.add(Helper.checkDecimal(Helper.correctNull(rs1.getString("CCBM_ADMN_EXP"))));//16
						arrCol.add(Helper.checkDecimal(Helper.correctNull(rs1.getString("CCBM_OTHR_EXP"))));
						arrCol.add(Helper.checkDecimal(Helper.correctNull(rs1.getString("CCBM_TOT_OFLW"))));
						arrCol.add(Helper.checkDecimal(Helper.correctNull(rs1.getString("CCBM_SRPLS_DFCT"))));
					//	arrCol.add(Helper.checkDecimal(Helper.correctNull(rs1.getString("CCBM_OPN_CRDT_CSH"))));
					//	arrCol.add(Helper.checkDecimal(Helper.correctNull(rs1.getString("CCBM_SRPLS_DFTC_TOT"))));//21
						arrCol.add(Helper.checkDecimal(Helper.correctNull(rs1.getString("CCBM_BNK_FIN"))));
						arrRow.add(arrCol);
						if(!Helper.correctNull(rs1.getString("CCBM_VAL")).equalsIgnoreCase(""))//0)
						{
						hshValues.put("rowcount"+(i),""+(j++));
						}
						k++;
						
						hshValues.put("cb_finyear"+(i),Helper.correctNull(rs1.getString("CCBM_FIN_YEAR")));
					}
					hshValues.put("y"+(i),arrRow);
				}
				hshValues.put("count",""+(i));
			}
			if(str_arr.contains("AOW@"))
			{
				if(rs1 != null){	rs1.close();}
				rs1	= DBUtils.executeLAPSQuery("sel_assessment_tl^"+strAppNo+"^20");
				if(rs1.next())
				{
					hshValues.put("com_wcassessment_comments",Helper.CLOBToString(rs1.getClob("com_assessment_comments")));
				}
			}
			if(str_arr.contains("AOA@"))
			{
				if(rs1 != null){	rs1.close();}
				rs1	= DBUtils.executeLAPSQuery("sel_assessment_tl^"+strAppNo+"^6");
				if(rs1.next())
				{
					hshValues.put("com_tlassessment_comments",Helper.CLOBToString(rs1.getClob("com_assessment_comments")));
				}
			}
			hshRequestValues=new HashMap();
			hshRequestValues.put("appno", strAppNo);
			hshValues.put("sensitiveAnalysis",financial.getSensitiveData(hshRequestValues));
			if(rs1 != null){	rs1.close();}
				rs1	= DBUtils.executeLAPSQuery("sel_tlothers^"+strAppNo);
				while(rs1.next())
				{
					hshValues.put("estimated_date",Helper.correctNull(rs1.getString("com_date")));
					hshValues.put("estimated_remarks",Helper.CLOBToString(rs1.getClob("com_comments")));
				}			
				strQuery2 = SQLParser.getSqlQuery("combankingselectNEW^"+strAppNo+"^ ");
				if(rs!=null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery2);
				while(rs.next())
				{

					String strcombk_modtype=Helper.correctNull((String)rs.getString("combk_modtype"));
					String strFacility=Helper.correctNull((String)rs.getString("combk_facility"));
					String[] strFacilityArr=strFacility.split("~");
					if(strFacilityArr.length>0)
					{
						if(strcombk_modtype.equalsIgnoreCase("r"))
						{
							strQuery2=SQLParser.getSqlQuery("sel_retProductDesc^"+strFacilityArr[0]);
							rs1 = DBUtils.executeQuery(strQuery2);
							if(rs1.next())
							{
								Helper.correctNull(rs1.getString("com_facdesc"));//18
							}
							
							
						}
						else if(strcombk_modtype.equalsIgnoreCase("c"))
						{
							strQuery2=SQLParser.getSqlQuery("sel_FacilityCorpDesc^"+strFacilityArr[0]+"^c");
							rs1 = DBUtils.executeQuery(strQuery2);
							if(rs1.next())
							{
							Helper.correctNull(rs1.getString("com_facdesc"));//18
							}
						}
						else if(strcombk_modtype.equalsIgnoreCase("a"))
						{
							strQuery2=SQLParser.getSqlQuery("sel_FacilityCorpDesc^"+strFacilityArr[0]+"^a");
							rs1 = DBUtils.executeQuery(strQuery2);
							if(rs1.next())
							{
								Helper.correctNull(rs1.getString("com_facdesc"));//18
							}
						}
					}
					Helper.correctDouble((String)rs.getString("combk_limit"));
					Helper.correctDouble((String)rs.getString("combk_limit"));
					Helper.correctDouble((String)rs.getString("combk_sancrefno"));
					Helper.correctDouble((String)rs.getString("combk_inttype"));
					Helper.correctDouble((String)rs.getString("combk_spread"));
					Helper.correctDouble((String)rs.getString("combk_os"));
					Helper.correctDouble((String)rs.getString("combk_duedate"));
					Helper.correctDouble((String)rs.getString("combk_arrears"));
				}
				strQuery = SQLParser.getSqlQuery("sel_combankingdetails^"+strAppNo);
				if(rs!=null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshValues.put("COM_ASSETCLASS",correctNull(rs.getString("COM_ASSETCLASS")));
				}
				if(rs!=null)
				{
					rs.close();
				}
				
				//Added by bhaskar for income from cropsfor agriculture
				arrRow=new ArrayList();
				rs=DBUtils.executeLAPSQuery("seldistfinayearsofcropincome^"+strAppNo);
				while(rs.next())
				{				
				  arrCol=new ArrayList();
				  arrCol.add(Helper.correctNull((String)rs.getString("AGR_CRP_FINYR")));//0
				  if(rs2!=null)
				  {
					  rs2.close();
				  }
				  if(!Helper.correctNull((String)rs.getString("AGR_CRP_FINYR")).equalsIgnoreCase(""))
				  {
				  rs2=DBUtils.executeLAPSQuery("selincomefromcrops^"+strAppNo+"^"+Helper.correctNull((String)rs.getString("AGR_CRP_FINYR")));
				  arrIncomeFromCropRow=new ArrayList();
				  while(rs2.next())
				  {
				    arrIncomeFromCropCol=new ArrayList();
				    strSeasonType=rs2.getString("agr_crp_season");//0
					if(rs1 !=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeLAPSQuery("getstaticdatavaldispcorporate^"+"131"+'^'+strSeasonType);
					if(rs1.next())
					{
						strSeasonName=Helper.correctNull((String)rs1.getString("stat_data_desc1"));
					}
					arrIncomeFromCropCol.add(strSeasonName);//0
					strSeasonName="";
					arrIncomeFromCropCol.add(rs2.getString("agr_crp_cropname"));//1
					arrIncomeFromCropCol.add(rs2.getString("agr_crp_area"));//2		
					arrIncomeFromCropCol.add(rs2.getString("agr_crp_yieldperacre"));//3
					arrIncomeFromCropCol.add(rs2.getString("agr_crp_totalyield"));//4
					arrIncomeFromCropCol.add(rs2.getString("agr_crp_priceperqtl"));//5
					arrIncomeFromCropCol.add(rs2.getString("agr_crp_totalinc"));//6
					arrIncomeFromCropCol.add(rs2.getString("agr_crp_costofcult"));//7
					arrIncomeFromCropCol.add(rs2.getString("agr_crp_totcostofcult"));//8	
					arrIncomeFromCropCol.add(rs2.getString("agr_crp_surplus"));//9
					String strTotal=rs2.getString("agr_crp_surplus");
					dblTotal=Double.parseDouble(strTotal);
					dblTotalAmt+=dblTotal;
					strTotalAmt=dc.format(dblTotalAmt);
					arrIncomeFromCropCol.add(rs2.getString("agr_crp_season"));//10
					arrIncomeFromCropCol.add(rs2.getString("agr_crp_sno"));//11
					strCropType=rs2.getString("agr_crp_cropname");
					if(rs1 !=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeLAPSQuery("getstaticdatavaldispcorporate^"+"130"+'^'+strCropType);
					if(rs1.next())
					{
						strCropName=Helper.correctNull((String)rs1.getString("stat_data_desc1"));
					}
					arrIncomeFromCropCol.add(strCropName);//12
					strexiprotype=Helper.correctNull(rs2.getString("agr_crp_exiprotype"));
					arrIncomeFromCropCol.add(strexiprotype);//13 added by ganesan  for the type 
					
					if(rs1 !=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeLAPSQuery("getstaticdata_soldid^"+"135"+'^'+Helper.correctNull((String)rs2.getString("agr_crp_areaunit")));
					if(rs1.next())
					{
						arrIncomeFromCropCol.add(Helper.correctNull((String)rs1.getString("stat_data_desc1")));
					}
					else
					{
						arrIncomeFromCropCol.add("");
					}
					
					if(rs1 !=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeLAPSQuery("getstaticdata_soldid^"+"136"+'^'+Helper.correctNull((String)rs2.getString("agr_crp_yieldunit")));
					if(rs1.next())
					{
						arrIncomeFromCropCol.add(Helper.correctNull((String)rs1.getString("stat_data_desc1")));
					}
					else
					{
						arrIncomeFromCropCol.add("");
					}		  	
				  
				  	if(Helper.correctNull(strexiprotype).equalsIgnoreCase("1"))
				  	{
				  		
				  		//rs1=DBUtils.executeLAPSQuery("sel_exiproagr_croppingpattern^"+strAppNo+'^'+strexiprotype);
				  		dbl_exitot=Double.parseDouble((String)rs2.getString("agr_crp_surplus"));
				  		dbl_exialltot=dbl_exialltot+dbl_exitot;
				  		
				  	}
				  	else if(Helper.correctNull(strexiprotype).equalsIgnoreCase("2"))
				  	{
				  		//rs1=DBUtils.executeLAPSQuery("sel_exiproagr_croppingpattern^"+strAppNo+'^'+strexiprotype);
				  		
				  		dbl_protot=Double.parseDouble((String)rs2.getString("agr_crp_surplus"));
				  		dbl_proalltot=dbl_proalltot+dbl_protot;
				  		
				  	}				  				  	
					strCropName="";					
					arrIncomeFromCropRow.add(arrIncomeFromCropCol);
				  }
				  }
				  arrCol.add(arrIncomeFromCropRow);//1
				  arrRow.add(arrCol);
				}
				hshValues.put("total",strTotalAmt);
				hshValues.put("arrData",arrRow);
				hshValues.put("Exis_Tootal",dc.format(dbl_exialltot));
				hshValues.put("prop_Tootal",dc.format(dbl_proalltot));				
				hshValues.put("strLoanTypeNew", strLoanType);
				
				HashMap hshFarmBudget=new HashMap();				
				ComProposalBean cpb=new ComProposalBean();
				hshReqValues.put("callform","Processnote");
				hshFarmBudget=cpb.getFarmBudget(hshReqValues);
				hshValues.put("hshFarm", hshFarmBudget);
				
				arrRow=new ArrayList();
				rs=DBUtils.executeLAPSQuery("selcropassementforappno^"+strAppNo);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull((String)rs.getString("AGR_CAS_SEASON")));//0
					arrCol.add(Helper.correctNull((String)rs.getString("AGR_CAS_CROP")));//1					
					arrCol.add(Helper.correctNull((String)rs.getString("AGR_CAS_AREACUL")));//2					
					arrCol.add(Helper.correctNull((String)rs.getString("AGR_CAS_AMOUNT")));//3
					arrCol.add(Helper.correctNull((String)rs.getString("AGR_CAS_ELIGIBILITY")));//4
					arrRow.add(arrCol);			
				}
				hshValues.put("arrCropAssessment", arrRow);	
				
				/** Added by: Vinoth kumar
				 *  Date    : March 08 2014 
				 *  Purpose : Display Physical and Financial Programe and DSS page Details in Appraisal Note */ 
				
				
				
				String modtype=Helper.correctNull((String)hshReqValues.get("sessionModuleType"));
				if(modtype.equalsIgnoreCase("AGR"))
				{
					hshPhysicsAndFinValues = (HashMap)EJBInvoker.executeStateLess("lapsReport",hshReqValues,"getFinProgrammePrint");
					hshValues.put("hshPhysicsAndFinValues",hshPhysicsAndFinValues);
					
					hshReqValues.put("hidapplicantid", strAppId);
					hshReqValues.put("strPrintFlag", "Y");
					hshDSSData = (HashMap)EJBInvoker.executeStateLess("comproposal",hshReqValues,"getDSS");
					hshValues.put("hshDSSData",hshDSSData);
				}
				//added by bhaskar for Crop Loan Aseesment
				
				// Added by DINESH for Introduction : Remarks on 10/03/2014
				
				String strPage = "gist";
				strQuery = SQLParser.getSqlQuery("sel_comments^" +strPage+"^"+strAppNo);

				if (rs != null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) 
				{
					hshValues.put("com_comments"+strPage, correctNull(Helper.CLOBToString(rs.getClob("com_comments"))));
				}
				
				// For Benchmark Values by DINESH on 11/03/2014
				if (rs != null)
					rs.close();
				strQuery = SQLParser.getSqlQuery("com_demographics_cma_sel^" + strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) 
				{
					if(correctNull((String)rs.getString("demo_finstandard")).equalsIgnoreCase("")||correctNull((String)rs.getString("demo_finstandard")).equalsIgnoreCase("null"))
					{
						cma="0";
					}
					else
					{
						cma = correctNull((String)rs.getString("demo_finstandard"));
					}
				}
				
				String yearselect="";
				
				/** Take last audited year in Bench Mark Ratio */
				if(rs!=null)
				rs.close();
				
				strQuery = SQLParser.getSqlQuery("com_finappvalues_audit_select^"+strAppNo+"^<=^<");
				 rs=DBUtils.executeQuery(strQuery);
				 if(rs.next())
				 {
						yearselect=correctNull((String)rs.getString("audityear"));
				 }
				 else
				 {
					 yearselect="";
				 }		
				if(rs1!=null)
				rs1.close();
		
				String strDSCRYear=null,desc="a",formuladesc="";
				rs =DBUtils.executeLAPSQuery("com_benchmarkrows^" +strAppNo +"^"+cma);
				while (rs.next()) 
				{	
					vecRec=new ArrayList();
					vecRec.add(correctNull(rs.getString("BENCH_ROWID")));
					vecRec.add(correctNull(rs.getString("BENCH_CMANO")));					
					vecRec.add(correctNull(rs.getString("BENCH_ROWDESC")));
					vecRec.add(correctNull(rs.getString("BENCH_POLICY")));
					vecRec.add(correctNull(rs.getString("BENCH_DEPENDSON")));
					formuladesc=(correctNull(rs.getString("BENCH_FORMULA")));
					
						if(Helper.correctNull(rs.getString("BENCH_DEPENDSON")).equalsIgnoreCase("FI"))
						{
							if(!yearselect.trim().equalsIgnoreCase(""))
							{
								HashMap hshformula =  new HashMap();
								hshformula.put("appno",strAppNo);
								hshformula.put("formulaid",formuladesc);
								hshformula.put("curryear",yearselect);
								hshformula.put("prevyear","");
								hshformula.put("currfinancialtype",desc);
								hshformula.put("prevfinancialtype","a");
								hshformula.put("internalcalc","N");
								hshformula.put("hshdata",new HashMap());
								hshRes = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
								vecRec.add(Helper.correctNull((String)hshRes.get("strTotalValue")));
							}
							else
							{
								vecRec.add("0.00");
							}
						}
						else if(Helper.correctNull(rs.getString("BENCH_DEPENDSON")).equalsIgnoreCase("DSCR"))
						{
							/**Take Minimum DSCR value of all the financial  year in Bench Mark Ratio*/
							//vecRec.add("0.0");
						}
						
						else
						{
							vecRec.add("0.00");
						}
					
					vecRec.add(correctNull(rs.getString("BENCHMARK_FINVALUES_STATUS")));
					vecData.add(vecRec);
				}	
				hshValues.put("vecData",vecData);
				
				// For Ratification
				String strsel ="";
				strpage="ratification";int i=0;
				String strstatecode= "133";
				if(rs!=null)rs.close();
				rs = DBUtils.executeLAPSQuery("selstaticdata^"+strstatecode);
				
				while(rs.next())
				{
					hshValues.put("rati_desc"+i,Helper.correctNull(rs.getString("stat_data_desc1")));
					
					strsel =Helper.correctNull(rs.getString("stat_data_sno"));
					if(rs1!=null)rs1.close();
					
					strQuery=SQLParser.getSqlQuery("sel_ratification_comments^"+strpage+"^"+strsel+"^"+strAppNo);
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						hshValues.put("rati_comments"+i,Helper.CLOBToString(rs1.getClob("com_comments")));
						i++;
					}
					
				}
				hshValues.put("rati_Count",""+i);
				//For T&C - Specific , Inst. to the Branch
				
				String strQuery1="";
				
				
		// For Financial & Business Performance by DINESH on 31/03/2014		
				
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec1 = new ArrayList();
		ArrayList vecRec2 = new ArrayList();
		String strcomappid = correctNull((String) hshValues.get("comappid"));
		String strCompanyname = "0";
		String strindtype = correctNull((String) hshValues.get("industryType"));
			
		if(strcomappid.equalsIgnoreCase(""))
		{
			rs = DBUtils.executeLAPSQuery("comfunsel3^" + strAppNo);
			if(rs.next())
			{
				strcomappid=Helper.correctNull((String)rs.getString("demo_appid"));
			}
		}
		if(rs!=null)
		{
			rs.close();
		}

		rs = DBUtils.executeLAPSQuery("com_interfirm_select^" + strindtype + "^" + strcomappid);
		while (rs.next()) 
		{
			vecRec1.add(correctNull((String) rs.getString("comapp_id")));
			vecRec2.add(correctNull((String) rs.getString("comapp_companyname")));
		}
		
		vecVal.add(vecRec1);
		vecVal.add(vecRec2);
		hshValues.put("vecVal", vecVal);
		hshValues.put("vecname", vecRec2);
		hshValues.put("vecid", vecRec1);

		if(!strCompanyname.equalsIgnoreCase(""))
		{
			strQuery = SQLParser.getSqlQuery("selfingrpconcernval^" + strAppNo+"^"+strCompanyname);
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshValues.put("intcompfreetxt_txt1", correctNull(rs.getString("COM_FREETEXT1"))); // 1
				hshValues.put("intcompfreetxt_txt2", correctNull(rs.getString("COM_FREETEXT2")));// 2
				hshValues.put("intcompfreetxt_txt3", correctNull(rs.getString("COM_FREETEXT3")));// 3
				hshValues.put("COM_FREETEXT4", correctNull(rs.getString("COM_FREETEXT4")));// 4 
			}
	
			strQuery = SQLParser.getSqlQuery("selfingrpconcerncompare^" + strAppNo+"^"+strCompanyname);
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			int k = 0;
			while (rs.next()) 
			{
				k = k + 1;
				hshValues.put("txt_compname" + k, correctNull(rs.getString("fingrpconcern_comname"))); // 1
				hshValues.put("txt_year" + k, correctNull(rs.getString("fingrpconcern_year")));// 2
				hshValues.put("txt_type" + k, correctNull(rs.getString("fingrpconcern_fintype")));// 3
				hshValues.put("txt_gross" + k, correctNull(rs.getString("fingrpconcern_grosssales")));// 4
				hshValues.put("txt_netsales" + k, correctNull(rs.getString("fingrpconcern_netsales")));// 5
				hshValues.put("txt_netprofit" + k, correctNull(rs.getString("fingrpconcern_netprofit"))); // 6
				hshValues.put("txt_capital" + k, correctNull(rs.getString("fingrpconcern_capital")));// 7
				hshValues.put("txt_tangnet" + k, correctNull(rs.getString("fingrpconcern_tangnetworth")));// 8
				hshValues.put("txt_network" + k, correctNull(rs.getString("fingrpconcern_networkcap"))); // 9
				hshValues.put("txt_toltnw" + k, correctNull(rs.getString("fingrpconcern_toltnw")));// 10
	
				hshValues.put("txt_currratio" + k, correctNull(rs.getString("fingrpconcern_currratio"))); // 11
				hshValues.put("txt_estproturn" + k, correctNull(rs.getString("fingrpconcern_estproturn")));// 12
				hshValues.put("txt_totwork" + k, correctNull(rs.getString("fingrpconcern_totcapital")));// 13
				hshValues.put("txt_seccoverinclude" + k, correctNull(rs.getString("fingrpconcern_seccoverinclude")));// 14
				hshValues.put("txt_seccoverexclude" + k, correctNull(rs.getString("fingrpconcern_seccoverexclude")));// 15
				hshValues.put("txt_lastcredit" + k, correctNull(rs.getString("fingrpconcern_lastcredit")));// 16
				hshValues.put("txt_freetext" + k, correctNull(rs.getString("fingrpconcern_freetext1")));// 17
				hshValues.put("txt_freetext1" + k, correctNull(rs.getString("fingrpconcern_freetext2")));// 18
				hshValues.put("txt_freetext2" + k, correctNull(rs.getString("fingrpconcern_freetext3")));// 19
				hshValues.put("FINGRPCONCERN_FREETEXT4" + k, correctNull(rs.getString("FINGRPCONCERN_FREETEXT4")));// 19
			}
		}
		hshValues.put("companyname",strCompanyname);

		// For Security Coverage by DINESH on 31/03/2014		
		HashMap hshsecdet = new HashMap();
     	HashMap hshsecdetFrom = new HashMap();
     	hshsecdetFrom.put("valuesin", strValuesIn1);
    	hshsecdetFrom.put("appno", strAppNo);
    	hshsecdetFrom.put("hidapplicantid", strOldAppId);
		hshsecdet = new SecurityMasterBean().getCollateralSecurityDisplaynew(hshsecdetFrom);
		hshValues.put("hshsecdet",hshsecdet);
		
		hshValues.put("arrNewRow", (ArrayList)hshsecdet.get("arrNewRow"));
		
		hshValues.put("dbl_totvalexis", (String)hshsecdet.get("dbl_totvalexis"));
		hshValues.put("dbl_totvalproposed", (String)hshsecdet.get("dbl_totvalproposed"));
		
		hshValues.put("dbl_secexitot", (String)hshsecdet.get("dbl_secexitot"));
		hshValues.put("dbl_secproptot", (String)hshsecdet.get("dbl_secproptot"));
		
		hshValues.put("dbl_secexicoverage", (String)hshsecdet.get("dbl_secexicoverage"));
		hshValues.put("dbl_secpropcoverage", (String)hshsecdet.get("dbl_secpropcoverage"));
		
		//Customer Banking Arrangement Info by DINESH on 01/04/2014
		
		rs=DBUtils.executeLAPSQuery("sel_common_customer^"+strAppId);				 
		if(rs.next())
		{
			strVal	= correctNull(rs.getString("indinfo_bankarrangement"));
			hshValues.put("info_bankArng",Helper.correctInt((String)rs.getString("indinfo_bankarrangement")));
			
			if(strVal.equals("2"))
			{
				strVal	= "Multiple";
			}
			else if(strVal.equals("3"))
			{
				strVal	= "Consortium";
			}
			else
			{
				strVal	= "Sole";
			}
			hshValues.put("presentBankArng",strVal);
		}		
		
		ArrayList arrRow12 = new ArrayList();
		ArrayList arrCol12 = new ArrayList();
		String strBreakup="",strInv="",strExpd="",strReceiv="",strTurnover="",strCreditors="",strProfit="",strOtherAssets="",strOthr="",strCashmargin="",strStockAss="",strDebitorAnalysis="",strPeerconcerns="",strRetireCapacity="",strPerformCapacity="",strOfferCashMargin="",strExpiredBG="";;
		String strQuery12 = SQLParser.getSqlQuery("sel_assessmnt_comments^assmntcomments^"+strAppNo);
		ResultSet rs12 = DBUtils.executeQuery(strQuery12);
		while(rs12.next())
		{
			arrCol12 = new ArrayList();
			String strComment="";
			String strsno = Helper.correctNull((String)rs12.getString("COM_SNO"));
			if(strsno.equalsIgnoreCase("1"))
			{
				strComment = "Break up of limits";
				strBreakup=Helper.CLOBToString(rs12.getClob("COM_COMMENTS"));
			}
			else if(strsno.equalsIgnoreCase("2"))
			{
				strComment = "Cash Margin";
				strCashmargin=Helper.CLOBToString(rs12.getClob("COM_COMMENTS"));
			}
			else if(strsno.equalsIgnoreCase("3"))
			{
				strComment = "Inventory";
				strInv=Helper.CLOBToString(rs12.getClob("COM_COMMENTS"));
			}
			else if(strsno.equalsIgnoreCase("4"))
			{
				strComment = "Expenditure";
				strExpd=Helper.CLOBToString(rs12.getClob("COM_COMMENTS"));
			}
			else if(strsno.equalsIgnoreCase("5"))
			{
				strComment = "Receivables";
				strReceiv=Helper.CLOBToString(rs12.getClob("COM_COMMENTS"));
			}
			else if(strsno.equalsIgnoreCase("6"))
			{
				strComment = "Turnover";
				strTurnover=Helper.CLOBToString(rs12.getClob("COM_COMMENTS"));
			}
			else if(strsno.equalsIgnoreCase("7"))
			{
				strComment = "Creditors";
				strCreditors=Helper.CLOBToString(rs12.getClob("COM_COMMENTS"));
			}
			else if(strsno.equalsIgnoreCase("8"))
			{
				strComment = "Profit and Loss";
				strProfit=Helper.CLOBToString(rs12.getClob("COM_COMMENTS"));
			}
			else if(strsno.equalsIgnoreCase("9"))
			{
				strComment = "Other Current Assets and Liabilitie";
				strOtherAssets=Helper.CLOBToString(rs12.getClob("COM_COMMENTS"));
			}
			else if(strsno.equalsIgnoreCase("12"))
			{
				strComment = "Others";
				strOthr=Helper.CLOBToString(rs12.getClob("COM_COMMENTS"));
			}
			else if(strsno.equalsIgnoreCase("13"))
			{
				strComment = "comments on stock of work in process/progress";
				strStockAss=Helper.CLOBToString(rs12.getClob("COM_COMMENTS"));
			}
			else if(strsno.equalsIgnoreCase("16"))
			{
				strComment = "Age wise Debtor Analysis";
				strDebitorAnalysis=Helper.CLOBToString(rs12.getClob("COM_COMMENTS"));
			}
			else if(strsno.equalsIgnoreCase("14"))
			{
				strComment = "Comment on Comparison with Peer Concerns in the Industry with particular reference to Working Capital Cycle as well as comments on bank's exposure to the Sector (Industry Exposure) and experience";
				strPeerconcerns=Helper.CLOBToString(rs12.getClob("COM_COMMENTS"));
			}
			else if(strsno.equalsIgnoreCase("15"))
			{
				strComment = "Availability of drawing power/ calculation of DP for the assessment period";
				strPeerconcerns=Helper.CLOBToString(rs12.getClob("COM_COMMENTS"));
			}
			else if(strsno.equalsIgnoreCase("16"))
			{
				strComment = "Age wise Debtor Analysis";
				strPeerconcerns=Helper.CLOBToString(rs12.getClob("COM_COMMENTS"));
			}
			else if(strsno.equalsIgnoreCase("17"))
			{
				strComment = "Capacity to retire the obligations under LC/BG/Buyers Credit";
				strRetireCapacity=Helper.CLOBToString(rs12.getClob("COM_COMMENTS"));
			}
			else if(strsno.equalsIgnoreCase("18"))
			{
				strComment = "Capacity to Perform under Bank Guarantee";
				strPerformCapacity=Helper.CLOBToString(rs12.getClob("COM_COMMENTS"));
			}
			else if(strsno.equalsIgnoreCase("19"))
			{
				strComment = "Offer comments about Cash margin";
				strOfferCashMargin=Helper.CLOBToString(rs12.getClob("COM_COMMENTS"));
			}
			else if(strsno.equalsIgnoreCase("20"))
			{
				strComment = "Comments on Expired BG's";
				strExpiredBG=Helper.CLOBToString(rs12.getClob("COM_COMMENTS"));
			}
			arrCol12.add(strComment);
			arrCol12.add(Helper.CLOBToString(rs12.getClob("COM_COMMENTS")));
			arrCol12.add(strsno);
			arrRow12.add(arrCol12);
		}
		
		if(rs12!=null)
			rs12.close();
		rs12 = DBUtils.executeLAPSQuery("sel_assessmnt_comments^Industry^"+strAppNo);
		if(rs12.next())
		{
			hshValues.put("strIndustryAnalysis",Helper.correctNull(Helper.CLOBToString(rs12.getClob("COM_COMMENTS"))));
		}
		
		hshValues.put("arrAssmntRow",arrRow12);
		hshValues.put("strBreakup",strBreakup);
		hshValues.put("strInv",strInv);
		hshValues.put("strExpd",strExpd);
		hshValues.put("strReceiv",strReceiv);
		hshValues.put("strTurnover",strTurnover);
		hshValues.put("strCreditors",strCreditors);
		hshValues.put("strProfit",strProfit);
		hshValues.put("strOtherAssets",strOtherAssets);
		hshValues.put("strOthr",strOthr);
		hshValues.put("strCashmargin",strCashmargin);
		hshValues.put("strStockAss",strStockAss);
		hshValues.put("strDebitorAnalysis",strDebitorAnalysis);
		hshValues.put("strPeerconcerns",strPeerconcerns);
		hshValues.put("strRetireCapacity",strRetireCapacity);
		hshValues.put("strPerformCapacity",strPerformCapacity);
		hshValues.put("strOfferCashMargin",strOfferCashMargin);
		hshValues.put("strExpiredBG",strExpiredBG);
		
		String strQuery13 = SQLParser.getSqlQuery("sel_assessmnt_comments^Management^"+strAppNo);
		ResultSet rs13 = DBUtils.executeQuery(strQuery13);
		while(rs13.next())
		{
			String strsno = Helper.correctNull((String)rs13.getString("COM_SNO"));
			if(strsno.equalsIgnoreCase("8"))
				hshValues.put("MgmtComments8",Helper.CLOBToString(rs13.getClob("COM_COMMENTS")));
			else if(strsno.equalsIgnoreCase("9"))
				hshValues.put("MgmtComments9",Helper.CLOBToString(rs13.getClob("COM_COMMENTS")));
			else if(strsno.equalsIgnoreCase("10"))
				hshValues.put("MgmtComments10",Helper.CLOBToString(rs13.getClob("COM_COMMENTS")));
			else if(strsno.equalsIgnoreCase("11"))
				hshValues.put("MgmtComments11",Helper.CLOBToString(rs13.getClob("COM_COMMENTS")));
			else if(strsno.equalsIgnoreCase("12"))
				hshValues.put("MgmtComments12",Helper.CLOBToString(rs13.getClob("COM_COMMENTS")));
			else if(strsno.equalsIgnoreCase("13"))
				hshValues.put("MgmtComments13",Helper.CLOBToString(rs13.getClob("COM_COMMENTS")));
			else if(strsno.equalsIgnoreCase("16"))
				hshValues.put("MgmtComments16",Helper.CLOBToString(rs13.getClob("COM_COMMENTS")));
			else if(strsno.equalsIgnoreCase("18"))
				hshValues.put("MgmtComments18",Helper.CLOBToString(rs13.getClob("COM_COMMENTS")));
			else if(strsno.equalsIgnoreCase("19"))
				hshValues.put("MgmtComments19",Helper.CLOBToString(rs13.getClob("COM_COMMENTS")));
			else if(strsno.equalsIgnoreCase("20"))
				hshValues.put("MgmtComments20",Helper.CLOBToString(rs13.getClob("COM_COMMENTS")));
			else if(strsno.equalsIgnoreCase("21"))
				hshValues.put("MgmtComments21",Helper.CLOBToString(rs13.getClob("COM_COMMENTS")));
			else if(strsno.equalsIgnoreCase("22"))
				hshValues.put("strEmailDate",Helper.correctNull(rs13.getString("COM_DACCODATE")));
			else if(strsno.equalsIgnoreCase("23"))
				hshValues.put("MgmtComments23",Helper.CLOBToString(rs13.getClob("COM_COMMENTS")));
			else if(strsno.equalsIgnoreCase("24"))
				hshValues.put("MgmtComments24",Helper.CLOBToString(rs13.getClob("COM_COMMENTS")));
			
			hshValues.put("OtherRelevantInfo","1");
		}	
		
		// BG Assessment
		
		if(str_arr.contains("BGA@"))
		{
			if (rs12 != null)
				rs12.close();
			String strbnkGurnt="";
			strQuery = SQLParser.getSqlQuery("sel_assessmnt_comments^bgassessment^"+strAppNo);
			rs12 = DBUtils.executeQuery(strQuery);
			while(rs12.next())
			{
				String strComment="";
				String strsno = Helper.correctNull((String)rs12.getString("COM_SNO"));
				if(strsno.equalsIgnoreCase("1"))
				{
					strComment = "Bank Guarantee";
					strbnkGurnt=Helper.CLOBToString(rs12.getClob("COM_COMMENTS"));
				}
			}
			hshValues.put("strbnkGurnt",strbnkGurnt);
		}
		if(str_arr.contains("AOR@"))
		{
			rs=DBUtils.executeLAPSQuery("sel_com_restr_assessment^"+strAppNo);
			if(rs.next())
			{
				hshValues.put("com_proj_details",Helper.correctNull(Helper.CLOBToString(rs.getClob("com_proj_details"))));
				hshValues.put("com_restr_reasons",Helper.correctNull(Helper.CLOBToString(rs.getClob("com_restr_reasons"))));
				hshValues.put("com_restr_justification",Helper.correctNull(Helper.CLOBToString(rs.getClob("com_restr_justification"))));
				hshValues.put("com_exi_repayschedule",Helper.correctNull(Helper.CLOBToString(rs.getClob("com_exi_repayschedule"))));
				hshValues.put("com_revised_repayschedule",Helper.correctNull(Helper.CLOBToString(rs.getClob("com_revised_repayschedule"))));
				hshValues.put("strRestrAss","true");
			}
			else
			{
				hshValues.put("strRestrAss","false");
			}
		}
		
		// Sales Justification
		
		if (rs12 != null)
			rs12.close();
		String strLastYrEst="",strCurrYrEst="",strJustification="";
		strQuery = SQLParser.getSqlQuery("sel_assessmnt_comments^salesjustify^"+strAppNo);
		rs12 = DBUtils.executeQuery(strQuery);
		while(rs12.next())
		{
			String strComment="";
			String strsno = Helper.correctNull((String)rs12.getString("COM_SNO"));
			if(strsno.equalsIgnoreCase("1"))
			{
				strComment = "Estimates and actual for last three years";
				strLastYrEst=Helper.CLOBToString(rs12.getClob("COM_COMMENTS"));
			}
			else if(strsno.equalsIgnoreCase("2"))
			{
				strComment = "Estimates of sales for the current year & for the next year I and II";
				strCurrYrEst=Helper.CLOBToString(rs12.getClob("COM_COMMENTS"));
			}
			else if(strsno.equalsIgnoreCase("3"))
			{
				strComment = "Justification for sales";
				strJustification=Helper.CLOBToString(rs12.getClob("COM_COMMENTS"));
			}
		}
		hshValues.put("strLastYrEst",strLastYrEst);
		hshValues.put("strCurrYrEst",strCurrYrEst);
		hshValues.put("strJustification",strJustification);
		
		// Other Non Funded Assessment
		
		strQuery=SQLParser.getSqlQuery("sel_nonfundassessment^"+strAppNo);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshValues.put("com_nonfund_comments",correctNull(Helper.CLOBToString(rs.getClob("com_nonfund_comments"))));
		}
		
		//Term of sanction
		
		strQuery = SQLParser.getSqlQuery("sel_comments^commentsTrans^" + strAppNo);
		if (rs != null)
			rs.close();
		rs = DBUtils.executeQuery(strQuery);
		if (rs.next())
		{
			hshValues.put("term_com_comments", correctNull(Helper.CLOBToString(rs.getClob("COM_COMMENTS"))));
		}
		if (rs != null)
			rs.close();
		
		strQuery = SQLParser.getSqlQuery("sel_comments^presentproposal^" + strAppNo);
		if (rs != null)
			rs.close();
		rs = DBUtils.executeQuery(strQuery);
		if (rs.next())
		{
			hshValues.put("presentproposal_comment", correctNull(Helper.CLOBToString(rs.getClob("COM_COMMENTS"))));
		}

		if(rs!=null)
		{rs.close();}
		
		rs = DBUtils.executeLAPSQuery("sel_allcomments^" + strAppNo + "^"+ "assdscr");
		if (rs.next()) 
		{
			hshValues.put("fin_comments_dscr", Helper.CLOBToString(rs .getClob("fin_comments")));
			
			hshValues.put("fin_comments1_dscr", Helper.CLOBToString(rs .getClob("fin_comments1")));
		}
		if(rs!=null)
		{rs.close();}
		
		rs = DBUtils.executeLAPSQuery("sel_allcomments^" + strAppNo + "^"+ "cashflow");
		if (rs.next()) 
		{
			hshValues.put("fin_comments_cashflow", Helper.CLOBToString(rs .getClob("fin_comments")));
			
			hshValues.put("fin_comments1_cashflow", Helper.CLOBToString(rs .getClob("fin_comments1")));
		}	
		if(rs!=null)
		{rs.close();}
		
		rs = DBUtils.executeLAPSQuery("sel_allcomments^" + strAppNo + "^"+ "dscrsensvty");
		if (rs.next()) 
		{
			hshValues.put("fin_comments_sensitive", Helper.CLOBToString(rs .getClob("fin_comments")));
			
			hshValues.put("fin_comments1_sensitive", Helper.CLOBToString(rs .getClob("fin_comments1")));
		}
		if(rs!=null)
		{rs.close();}
		
		rs = DBUtils.executeLAPSQuery("sel_allcomments^" + strAppNo + "^"+ "Method1");
		if (rs.next()) 
		{
			hshValues.put("fin_comments_method1", Helper.CLOBToString(rs .getClob("fin_comments")));
			
			hshValues.put("fin_comments1_method1", Helper.CLOBToString(rs .getClob("fin_comments1")));
		}	
		if(rs!=null)
		{rs.close();}
		
		rs = DBUtils.executeLAPSQuery("sel_allcomments^" + strAppNo + "^"+ "Method2");
		if (rs.next()) 
		{
			hshValues.put("fin_comments_method2", Helper.CLOBToString(rs .getClob("fin_comments")));
			
			hshValues.put("fin_comments1_method2", Helper.CLOBToString(rs .getClob("fin_comments1")));
		}	
		
		if(rs!=null)
		{rs.close();}
		
		rs = DBUtils.executeLAPSQuery("sel_comcomments^InterFirmComparsion^0^"+ strAppNo );
		if (rs.next()) 
		{
			hshValues.put("fin_comments_interfirm", Helper.CLOBToString(rs .getClob("com_comments")));
		}
		if(rs!=null)
		{rs.close();}
		
		rs = DBUtils.executeLAPSQuery("sel_comcomments^InterFirmComparsion1^0^"+strAppNo );
		if (rs.next()) 
		{
			hshValues.put("fin_comments_interfirm1", Helper.CLOBToString(rs .getClob("com_comments")));
		}
		
		if(rs!=null)
		{rs.close();}
		
		rs = DBUtils.executeLAPSQuery("sel_allcomments^" + strAppNo + "^"+ "Assessmentofwc");
		if (rs.next()) 
		{
			hshValues.put("fin_comments_wcg", Helper.CLOBToString(rs .getClob("fin_comments")));
			
			hshValues.put("fin_comments1_wcg", Helper.CLOBToString(rs .getClob("fin_comments1")));
		}	
		
		if (rs != null)
			rs.close();
		String strProjection="";
		rs	= DBUtils.executeLAPSQuery("sel_projectiondata^"+strAppNo);
		if(rs.next())
		{
			strProjection="Projection";
		}
		if(rs!=null)
		{rs.close();}
		hshValues.put("strProjection",strProjection);
		
		//added by bhaskar for non base rate facilities
		if(rs!=null)
		{
			rs.close();
		}
		String strComments="";
		rs=DBUtils.executeLAPSQuery("sel_faclityforcommentsonintrate^"+strAppNo);
		while(rs.next())
		{
						
			 strFacSno=Helper.correctNull(rs.getString("term_sno"));
			arrColNonBr=new ArrayList();
			if(rs1!=null)
			{
				rs1.close();
			}
			rs1=DBUtils.executeLAPSQuery("sel_commentsoninterestrate^commentsonintrestrate"+"^"+strFacSno+"^"+strAppNo);
			if(rs1.next())
			{
				strComments = correctNull(Helper.CLOBToString(rs1.getClob("COM_COMMENTS")));
				if(!strComments.equalsIgnoreCase("")){
				arrColNonBr.add(Helper.correctNull(rs.getString("term_desc")));
				arrColNonBr.add(correctNull(Helper.CLOBToString(rs1.getClob("COM_COMMENTS"))));	
				if(correctNull(rs.getString("com_headfac")).equalsIgnoreCase("1"))
				{
					double dblAmt=Double.parseDouble(Helper.correctDouble(rs.getString("facility_sancamt")));
					dblAmt=dblAmt/50;
					arrColNonBr.add(String.valueOf(dblAmt));
				}else{
					arrColNonBr.add(Helper.correctDouble(rs.getString("facility_sancamt")));
				}
			}
				if(rs1!=null)
				{
					rs1.close();
				}	
			}
			if(arrColNonBr.size()>0)
			arrRowNonBr.add(arrColNonBr);					
		}
		hshValues.put("arrRowNonBr",arrRowNonBr);
		
		// exposure for group concerns
		
		if(rs1!=null)
		{
			rs1.close();
		}
		rs1=DBUtils.executeLAPSQuery("sel_grpexpgorgrpconcerns^"+strAppNo+"^"+strAppNo);
		while(rs1.next())
		{
			arrcolGrpExpDet=new ArrayList();
			arrcolGrpExpDet.add(Helper.changetoTitlecase(Helper.correctNull(rs1.getString("perapp_title")))+"."+Helper.changetoTitlecase(Helper.correctNull(rs1.getString("perapp_fname"))));
			if(Helper.correctNull(rs1.getString("rate_grade")).equals("")){
				arrcolGrpExpDet.add("NA");	
			}
			else
			{
			arrcolGrpExpDet.add(Helper.correctNull(rs1.getString("rate_grade")));
			}
			if( Helper.correctNull(rs1.getString("rate_type")).equals("") || Helper.correctNull(rs1.getString("rate_type")).equals("s") )
			{
				arrcolGrpExpDet.add("NA");
			}
			else
			{
				arrcolGrpExpDet.add(Helper.correctNull(rs1.getString("rate_date")) +" ("+Helper.correctNull(rs1.getString("rate_type"))+")");
			}
			arrcolGrpExpDet.add(Helper.correctDouble(rs1.getString("exp")));
			dblGrpExp+=Double.parseDouble(Helper.correctDouble(rs1.getString("exp")));
			arrGrpExpDet.add(arrcolGrpExpDet);
				
		}
		
		if(rs1!=null)
		{
			rs1.close();
		}
		rs1=DBUtils.executeLAPSQuery("com_ind_grp_permit^"+strAppNo);
		if(rs1.next())
		{
			hshValues.put("dblIndVal",Helper.correctDouble(rs1.getString("com_individual")));
			hshValues.put("dblGrpVal",Helper.correctDouble(rs1.getString("com_group")));
		}
		
		
		hshValues.put("dblGrpExpVal",jtn.format(dblGrpExp));
		hshValues.put("arrGrpExpDet",arrGrpExpDet);
		
		String pgType = Helper.correctNull((String)hshReqValues.get("pgType"));
		boolean finacial_flag=false;
		
		if(strLoanType.equalsIgnoreCase("a"))
		{
			if(strFinancialrequired.equalsIgnoreCase("Y"))
					{				
				finacial_flag=true;
						
					}
			
		}
		else
		{
			finacial_flag=true;	
		}
        
			{
			
			if(finacial_flag)
	        {
				hshRequestValues	= new HashMap();
				hshRequestValues.put("appno",strAppNo);
				hshRequestValues.put("appidnew",strAppId);
				hshRequestValues.put("pageval","LIABILITIES");
				hshRequestValues.put("printtype","Y1");
				hshRequestValues.put("strFormat","EAN10");
				hshRequestValues=financial.getAnnexureIX(hshRequestValues);
				hshValues.put("hshReqValues",hshRequestValues);
				
				hshRequestValues	= new HashMap();
				hshRequestValues.put("appno",strAppNo);
				hshRequestValues.put("pageval","ASSETS");
				hshRequestValues.put("printtype","Y1");
				hshRequestValues.put("strFormat","EAN10");
				hshRequestValues=financial.getAnnexureIX(hshRequestValues);
				hshValues.put("hshReqValues1",hshRequestValues);
		
				hshRequestValues	= new HashMap();
				hshRequestValues.put("appno",strAppNo);
				hshRequestValues.put("pageval","PROFIT AND LOSS ACCOUNT");
				hshRequestValues.put("printtype","Y1");
				hshRequestValues.put("strFormat","EAN10");
				hshRequestValues=financial.getAnnexureIX(hshRequestValues);
				hshRequestValues.put("page","PROFIT AND LOSS ACCOUNT");
				hshValues.put("hshReqValues2",hshRequestValues);
				
		
				hshRequestValues	= new HashMap();
				hshRequestValues.put("appno",strAppNo);
				hshRequestValues.put("pageval","CAPITALISATION/COVERAGE/LIQUIDITY RATIOS");
				hshRequestValues.put("printtype","Y1");
				hshRequestValues.put("pagefrom","RA1");
				hshRequestValues.put("pageType","EAN10");
				hshRequestValues.put("printYear", "Y");
				hshRequestValues=financial.getDataRatio(hshRequestValues);
				hshRequestValues.put("page","CAPITALISATION/COVERAGE/LIQUIDITY RATIOS");
				hshValues.put("hshReqValues3",hshRequestValues);
				
				hshRequestValues	= new HashMap();
				hshRequestValues.put("appno",strAppNo);
				hshRequestValues.put("pagefr","RA2");
				
				hshRequestValues.put("hidfinid",strFinID);
				hshRequestValues.put("hid_appid",strAppId);
				hshRequestValues.put("pagefrom","RA2");
				hshRequestValues.put("pageType","EAN10");
				hshRequestValues.put("printYear", "Y");
				hshRequestValues=financial.getDataRatio(hshRequestValues);
				hshRequestValues.put("page","PROFITABILITY/TURN OVER/ OPERATING");
				hshValues.put("hshReqValues4",hshRequestValues);
				
				
        }
				
				CommDocumentBean commdocument = new CommDocumentBean();
				
				HashMap hshReqVal = new HashMap();
				hshReqVal.put("appno", strAppNo);
				hshReqVal.put("appid", strAppId);
				hshReqVal.put("PageType", "PROPOSALLC");
				hshReqVal.put("strPageType", "annexure");
				hshReqVal =	commdocument.getAnnexureII(hshReqVal);
				hshReqVal.put("page", "PROPOSAL LC");
				hshValues.put("PROPOSALLC",hshReqVal);
				
				hshReqVal = new HashMap();
				hshReqVal.put("appno", strAppNo);
				hshReqVal.put("appid", strAppId);
				hshReqVal.put("PageType", "PROPOSALLC");
				hshReqVal =	commdocument.getAnnexureIII(hshReqVal);
				hshReqVal.put("page", "AN3");
				hshValues.put("AN3",hshReqVal);
				
				BankAppBean bankapp = new BankAppBean();
				
				hshReqVal = new HashMap();
				hshReqVal.put("hidAppNo", strAppNo);
				hshReqVal.put("PageType", "ANN3");
				hshReqVal =	bankapp.getConsortiumDetails(hshReqVal);
				hshReqVal.put("page", "ANNEXUREIII");
				hshValues.put("ANN3",hshReqVal);
				
				
				hshReqVal = new HashMap();
				hshReqVal.put("appno", strAppNo);
				hshReqVal.put("appid", strAppId);
				hshReqVal.put("PageType", "ANN5");
				hshReqVal =	commdocument.getAnnexureV(hshReqVal);
				hshReqVal.put("page", "ANN5");
				hshValues.put("ANN5",hshReqVal);
				
				//For T&C - General 						
				HashMap hshTermsandcond = new HashMap();
				HashMap hshTermsval = new HashMap();
				hshTermsval.put("appno", strAppNo);
				hshTermsandcond=new CommDocumentBean().getAnnexureVII(hshTermsval);
				hshValues.put("hshTermsandcond", hshTermsandcond);
				// For Mis Details
				HashMap hshReqMis = new HashMap();
				hshReqMis.put("appno", strAppNo);
				hshReqMis.put("appid", strAppId);
				hshReqMis.put("LoanType", strLoanType);
				hshReqMis.put("strAmountValue", strAmountValue);
				hshReqMis.put("strAmtValueIn", strAmtValueIn);
				hshReqMis =	getmisprocessnotedetails(hshReqMis);
				hshReqMis.put("page", "MIS");
				hshValues.put("MIS",hshReqMis);
			
				
				if(rs!=null) { rs.close(); }
				String fincommcheck="N";
				ArrayList arrFinRow=new ArrayList();
				rs=DBUtils.executeLAPSQuery("sel_common_comments^"+strAppNo);
				while(rs.next())
				{
					String finsno=Helper.correctNull((String)rs.getString("com_sno"));
					{
					arrCol=new ArrayList();

					
					if(rs1!=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeLAPSQuery("getstaticdatavaldispcorporate^141^"+finsno);
					if(rs1.next())
					{
						arrCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));
					}
					else
					{
						arrCol.add("");
					}
					arrCol.add(Helper.correctNull(Helper.CLOBToString(rs.getClob(("com_comments")))));
					hshValues.put("fincommcheck","Y");
					arrFinRow.add(arrCol);
					}
				}
				hshValues.put("arrfinComments",arrFinRow);
			}
			
			if(rs!=null){rs.close();}
			String strGoodsFlag="";
			if(strLoanType.equalsIgnoreCase("a"))
			{				
				rs=DBUtils.executeLAPSQuery("sel_agr_facilities^"+strAppNo);
				while(rs.next())
				{
					
					String strFacAgrSchem=Helper.correctNull((String)rs.getString("facscheme"));
					if(strFacAgrSchem.equalsIgnoreCase("aK"))
					{
						strGoodsFlag="Y";
					}					
				}		
				
		  	}	
	
			hshValues.put("strGoodsFlag", strGoodsFlag);
			
			//added by bhaskar for Crop Loan Aseesment
			
			if(strGoodsFlag.equalsIgnoreCase("Y"))
			{
				
			hshReqValues.put("hidapplicantid", strAppId);
			hshGoods = (HashMap)EJBInvoker.executeStateLess("agriculture",hshReqValues,"getcaplGoodsdata");
			hshValues.put("hshGoods",hshGoods);
			}	
			
			//Added by Kishan for Repayment Schedule for Non-EMI
	        ArrayList arrCodeDescCol = new ArrayList();
	        ArrayList arrCodeDescRow = new ArrayList();
	        arrRow = new ArrayList();
			String strValue="'NE','OD','LC','CO','BG','DD','PC','PS'";
			String strLoanaccount="";  
			strQuery = SQLParser.getSqlQuery("seltermfinfac_NE^"+strAppNo+"^"+strValue);
			rs = DBUtils.executeQuery(strQuery);
  			while(rs.next())
			{
  				arrCodeDescCol = new ArrayList();
  				strLoanaccount="";
				String strCode= correctNull((String)rs.getString(1));
				String strName= correctNull((String)rs.getString(2));
				arrCodeDescCol.add(strCode);
  				arrCodeDescCol.add(strName);
  				arrCodeDescRow.add(arrCodeDescCol);
			}
			arrRow = new ArrayList();
  			arrCol = new ArrayList();
  			HashMap hshRepayNE = new HashMap();
  			String schCode="";
  			boolean flag1=false;
  			if(arrCodeDescRow!=null) {
  				for(i=0;i<arrCodeDescRow.size();i++) {
  					arrRow = new ArrayList();
  					arrCol = new ArrayList();
  					arrCodeDescCol = (ArrayList) arrCodeDescRow.get(i);
  					schCode=(String)arrCodeDescCol.get(0);
					String strQuery8 = SQLParser.getSqlQuery("sel_tl_repayschedule^"+strAppNo+"^"+schCode);
					rs=DBUtils.executeQuery(strQuery8);
					while(rs.next())
					{
						arrCol = new ArrayList();
						arrCol.add(correctNull(rs.getString(1)));
						arrCol.add(correctNull(rs.getString(2)));
						arrCol.add(correctNull(rs.getString(3)));
						arrCol.add(correctNull(rs.getString(4)));
						arrCol.add(correctNull(rs.getString(5)));
						arrCol.add(correctNull(rs.getString(6)));
						String strQuery9 = SQLParser.getSqlQuery("sel_tl_spfac^"+strAppNo+"^"+correctNull((String)rs.getString(2)));
						rs1=DBUtils.executeQuery(strQuery9);
						if(rs1.next())
						{
							arrCol.add(correctNull(rs1.getString("fac_desc")));
						}
						else
						{
							arrCol.add("");
						}
						arrCol.add((String)arrCodeDescCol.get(1));
						arrRow.add(arrCol);
					}
					hshRepayNE.put(schCode,arrRow);
  				}
  			}
  			hshValues.put("arrCodeDescRow",arrCodeDescRow);
  			hshValues.put("hshRepayNE",hshRepayNE);
				
  			//Get Presanction Security Comments
			strQuery=SQLParser.getSqlQuery("sel_comments^secoverage^"+strAppNo);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("cmt_presanccomments",Helper.CLOBToString(rs.getClob("com_comments")));
			}
			//Get Postsanction Security Comments
			strQuery=SQLParser.getSqlQuery("sel_comments^secoverage1^"+strAppNo);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("cmt_postsanccomments",Helper.CLOBToString(rs.getClob("com_comments")));
			}
			if(rs != null){	rs.close();}
			arrRow = new ArrayList();
			String strFacno="";
			rs=DBUtils.executeLAPSQuery("sel_termloan_facilities_fund^"+strAppNo);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("term_desc")));
				strFacno=correctNull(rs.getString("term_sno"));
				strQuery=SQLParser.getSqlQuery("sel_comcomments1^CommentsProj^"+strFacno+"^"+strAppNo+"^12");
				rs1 = DBUtils.executeQuery(strQuery);
				if (rs1.next()) 
				{
					arrCol.add(Helper.CLOBToString(rs1.getClob("com_comments")));
				}else{
					arrCol.add("Nil");
				}
				arrRow.add(arrCol);
			}
			hshValues.put("COP_comments",arrRow);
			
			if (rs != null)
				rs.close();
			
			strQuery = SQLParser.getSqlQuery("sel_seccomments^" + strAppNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshValues.put("COMSEC_APPCOVERAGE", Helper.correctNull(rs.getString("COMSEC_APPCOVERAGE")));
				hshValues.put("COMSEC_APPCOMMENTS", correctNull(Helper.CLOBToString(rs.getClob("COMSEC_APPCOMMENTS"))));
				hshValues.put("COMSEC_GROUPCOVERAGE",Helper.correctNull(rs.getString("COMSEC_GROUPCOVERAGE")));
				hshValues.put("COMSEC_GROUPCOMMENTS", correctNull(Helper.CLOBToString(rs.getClob("COMSEC_GROUPCOMMENTS"))));
				hshValues.put("COMSEC_ADDITIONALSECCOVERAGE", Helper.correctNull(rs.getString("COMSEC_ADDITIONALSECCOVERAGE")));
				hshValues.put("COMSEC_ADDITIONALSECCOMMENTS", correctNull(Helper.CLOBToString(rs.getClob("COMSEC_ADDITIONALSECCOMMENTS"))));
				hshValues.put("COMSEC_SECTYPE", Helper.correctNull(rs.getString("COMSEC_SECTYPE")));
				hshValues.put("COMSEC_FACGROUPCONCERN", Helper.correctNull(rs.getString("COMSEC_FACGROUPCONCERN")));
				hshValues.put("COMSEC_FACGROUPCONCERNCOMMENTS", correctNull(Helper.CLOBToString(rs.getClob("COMSEC_FACGROUPCONCERNCOMMENTS"))));
			}
			if((modtype.equalsIgnoreCase("CORP")||(modtype.equalsIgnoreCase("AGR") && strFinancialrequired.equalsIgnoreCase("Y")))&& strFinID!="0"){
			hshBenchValues	= new HashMap();
			hshBenchValues.put("appno",strAppNo);
			hshBenchValues=financial.getBenchMarkParam(hshBenchValues);
			hshValues.put("hshBenchValues",hshBenchValues);
			}
			strpage="benchmark";
			rs = DBUtils.executeLAPSQuery("sel_allcomments^" + strAppNo + "^"+ strpage);
			
			if (rs.next()) 
			{
				hshValues.put("fin_benchmarkcmts", Helper.CLOBToString(rs.getClob("fin_comments")));
			}
			
			
			arrRow=new ArrayList();
			strQuery = SQLParser.getSqlQuery("rbiguidelines_restr_processnote^"+strAppNo);
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("restr_rbi_slno")));
				arrCol.add(Helper.correctNull(rs.getString("restr_rbi_guidelines")));
				arrCol.add(Helper.correctNull(rs.getString("restr_rbi_compliance")));
				arrCol.add(Helper.correctNull(rs.getString("restr_rbi_comments")));
				arrCol.add(Helper.correctNull(rs.getString("restr_pagetype")));
				arrRow.add(arrCol);
			}
			
			hshValues.put("arrRBIGuidliness",arrRow);
			
			if(rs!=null)
				rs.close();
			strpage="fvccmts";
			rs = DBUtils.executeLAPSQuery("sel_retailcomments^" + strAppNo + "^"+ strpage);
			if (rs.next()) 
			{
				hshValues.put("strFVCComments", Helper.CLOBToString(rs.getClob("cmt_comments")));
			}
			
			arrRow = new ArrayList();
			strQuery=SQLParser.getSqlQuery("sel_rating_year_audited^"+ strAppNo);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				hshValues.put("IntRat","Y");
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("rdr_year")));
				if(Helper.correctNull(rs.getString("rdr_financial")).equals("a"))
				{
					arrCol.add("Audited");
				}
				else if(Helper.correctNull(rs.getString("rdr_financial")).equals("e"))
				{
					arrCol.add("Estimated");
				}
				else if(Helper.correctNull(rs.getString("rdr_financial")).equals("u"))
				{
					arrCol.add("Unaudited");
				}
				else if(Helper.correctNull(rs.getString("rdr_financial")).equals("p"))
				{
					arrCol.add("Projection");
				}else{
					arrCol.add(" ");
				}
				
				if(rs1!=null)
					rs1.close();
				rs1=DBUtils.executeLAPSQuery("sel_ratingCode_desc^"+Helper.correctNull(rs.getString("rdr_rating")));
				if(rs1.next())
					arrCol.add(Helper.correctNull(rs1.getString("RATING_DESC")));
				else
					arrCol.add(Helper.correctNull(rs.getString("rdr_rating")));
				arrRow.add(arrCol);
			}
			hshValues.put("arrRowRatingRMD",arrRow);
			
			//To get the inward proposed amount
			if (rs != null)
				rs.close();
			
			strQuery = SQLParser.getSqlQuery("sel_inward_proposed_values^" + strAppNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshValues.put("INWARD_TERMLOANAMT", Helper.correctDouble((String)rs.getString("INWARD_TERMLOANAMT")));
				hshValues.put("INWARD_WCLOANAMT", Helper.correctDouble((String)rs.getString("INWARD_WCLOANAMT")));
				hshValues.put("INWARD_NONWCLOANAMT",Helper.correctDouble((String)rs.getString("INWARD_NONWCLOANAMT")));
				hshValues.put("inward_no",Helper.correctNull((String)rs.getString("inward_no")));
				hshValues.put("inw_leadno",Helper.correctNull((String)rs.getString("inw_leadno")));

				
			}
			
			if(rs!=null)
  			{rs.close();}
  			
  			ArrayList arrCol2 = new ArrayList();
			ArrayList arrRow2 = new ArrayList();
			 strQuery1 = "";
			strQuery1 = SQLParser.getSqlQuery("sel_appdetails_hunterscore^" + strAppNo);
			rs = DBUtils.executeQuery(strQuery1);
			if (rs.next()) {
				arrCol2.add(Helper.correctNull((String) rs
						.getString("DEMO_COMAPPID")));
				arrCol2.add(Helper.correctInt((String) rs
						.getString("DEF_HUNTER_SCORE")));
				arrCol2.add(Helper.correctNull((String) rs
						.getString("PERAPP_FNAME")));
				arrRow2.add(arrCol2);
			}
			if (rs != null) {
				rs.close();
			}

			ArrayList arrCol1 = new ArrayList();
		//	ArrayList arrCol2 = new ArrayList();
			// boolean flag=false;
			strQuery1 = SQLParser.getSqlQuery("sel_coappdetails^" + strAppNo);
			rs = DBUtils.executeQuery(strQuery1);

			while (rs.next()) {
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull((String) rs
						.getString("COM_COMPDTID")));
				arrCol.add(Helper.correctInt((String) rs
						.getString("DEF_HUNTER_SCORE")));

				arrCol.add(Helper.correctNull((String) rs
						.getString("PERAPP_FNAME")));
				arrRow2.add(arrCol);
			}
			hshValues.put("arrRow2", arrRow2);
			
			if(rs1!=null){rs1.close();}
			strQuery = SQLParser.getSqlQuery("selQueryraised^"+strAppNo);
			rs1=DBUtils.executeQuery(strQuery);
			
			if(rs1.next())
			{
				hshValues.put("strQRaisedOn",correctNull(rs1.getString("queryraiseddate")));
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_comcommentscopmof^otherfac^7^"+strAppNo);
			if(rs.next())
			{
				hshValues.put("cesComments", correctNull(Helper.CLOBToString(rs.getClob("com_comments"))));
				
			}
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_comcommentscopmof^Management^17^"+strAppNo);
			if(rs.next())
			{
				hshValues.put("strGovtPolicy", correctNull(Helper.CLOBToString(rs.getClob("com_comments"))));
				
			}
			//Assets Classification
			if(rs!=null){rs.close();}
			rs=DBUtils.executeLAPSQuery("sel_combankingdetails^"+strAppNo);
			if(rs.next())
			{
				String strAssetClassification	= correctNull(rs.getString("com_assetclass"));
				if(strAssetClassification.equalsIgnoreCase("S"))
				{
					strAssetClassification="Standard";
				}
				else if(strAssetClassification.equalsIgnoreCase("SS"))
				{
					strAssetClassification="Sub Standard";
				}
				else if(strAssetClassification.equalsIgnoreCase("D"))
				{
					strAssetClassification="Doubtful";
				}
				else if(strAssetClassification.equalsIgnoreCase("L"))
				{
					strAssetClassification="Loss";
				}
				else
				{
					strAssetClassification="NIL";
				}
				
				hshValues.put("strAssetClassification",strAssetClassification);
				hshValues.put("com_asscladate", correctNull(rs.getString("com_asscladate")));
			}
			
			//Defaulter Det
			if(rs!=null){rs.close();}
			rs=DBUtils.executeLAPSQuery("sel_defid^"+strAppId);
			if(rs.next())
			{
				if(Helper.correctNull(rs.getString("DEF_SUITFILED")).equalsIgnoreCase("Y"))
				{
					hshValues.put("strSuitFiled","Yes");
					hshValues.put("strSuitFiledCmts",Helper.correctNull(Helper.CLOBToString(rs.getClob("DEF_SUITFILEDCOMM"))));
				}
				else if(Helper.correctNull(rs.getString("DEF_SUITFILED")).equalsIgnoreCase("N"))
				{
					hshValues.put("strSuitFiled","No");
				}
				if(Helper.correctNull(rs.getString("DEF_PROBE")).equalsIgnoreCase("Y"))
				{
					hshValues.put("strProbe","Yes");
					hshValues.put("strProbeCmts",Helper.correctNull(Helper.CLOBToString(rs.getClob("DEF_PROBECMT"))));
				}
				else if(Helper.correctNull(rs.getString("DEF_PROBE")).equalsIgnoreCase("N"))
				{
					hshValues.put("strProbe","No");
				}
			}
			
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("selcom_Rbiloanpolicyguide^"+strAppNo);
			
			while(rs.next())
			{
				hshValues.put(correctNull(rs.getString("comrbi_pagetype"))+"CMDPROCESSNOTE", Helper.correctNull(Helper.CLOBToString(rs.getClob("COMRBI_CMDPROCESS"))));
			}
			
			arrRow=new ArrayList();
			if(rs!=null)
				rs.close();
			
			rs=DBUtils.executeLAPSQuery("selcom_cust_profit^"+strAppNo);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("COM_YEARFROM")));
				arrCol.add(Helper.correctNull(rs.getString("COM_YEARTO")));
				arrCol.add(Helper.correctNull(rs.getString("COM_FTP_PROFIT")));
				arrCol.add(Helper.correctNull(rs.getString("COM_FTP_YIELD")));
				arrCol.add(Helper.correctNull(rs.getString("COM_RAROC")));
				arrRow.add(arrCol);
			}
			
			hshValues.put("arrProfitability",arrRow);
			
			if(rs!=null)
				rs.close();
			
			rs=DBUtils.executeLAPSQuery("sel_com_ftp_breakupoflimits^"+strAppNo);
			while(rs.next())
			{
				hshValues.put("strFTPAmt"+Helper.correctNull(rs.getString("COM_ftp_desc")),Helper.correctNull(rs.getString("COM_FTP_amount")));
			}
			
			
			if (rs != null) {
				rs.close();
			}//s.no-->facilityNo
		rs = DBUtils.executeLAPSQuery("sel_management_Assement^assmntcomments^15^"+strAppNo);
		while(rs.next()){
			hshValues.put("strAssCmts"+Helper.correctNull(rs.getString("ASSEMENT_COMMENT")),Helper.correctNull(rs.getString("ASSEMENT_COMMENT1")));
		}
		
		rs = DBUtils.executeLAPSQuery("sel_management_Assement^salesjustify^2^"+strAppNo);
		while(rs.next())
		{
			String[] strArr=Helper.correctNull(rs.getString("assess_comments3")).split("-");
			if(strArr!=null && strArr.length>1)
			{
				if(Helper.correctNull(rs.getString("ASSEMENT_COMMENT")).equalsIgnoreCase("CEXPORT"))
				{
					hshValues.put("strCYearFrom",strArr[0]);
					hshValues.put("strCYearTo",strArr[1]);
				}
				else if(Helper.correctNull(rs.getString("ASSEMENT_COMMENT")).equalsIgnoreCase("NEXPORT"))
				{
					hshValues.put("strNYearFrom",strArr[0]);
					hshValues.put("strNYearTo",strArr[1]);
				}
				else if(Helper.correctNull(rs.getString("ASSEMENT_COMMENT")).equalsIgnoreCase("IINEXPORT"))
				{
					hshValues.put("txt_IINyearfrom",strArr[0]);
					hshValues.put("txt_IINyearTo",strArr[1]);
				}
			}
			
			hshValues.put("strEstimated"+Helper.correctNull(rs.getString("ASSEMENT_COMMENT")),Helper.correctNull(rs.getString("ASSEMENT_COMMENT1")));
			hshValues.put("strAccepted"+Helper.correctNull(rs.getString("ASSEMENT_COMMENT")),Helper.correctNull(rs.getString("assess_comments2")));
		}
		
		ArrayList arrSalesAct=new ArrayList();
		ArrayList arrSalesProj=new ArrayList();
		ArrayList arrYear=new ArrayList();
		ArrayList arrGrowth=new ArrayList();
		ArrayList arrAchievement=new ArrayList();
		
		
		if (rs != null) {
			rs.close();
		}
		rs = DBUtils.executeLAPSQuery("sel_management_Assement^salesjustify^1^"+strAppNo);
		while(rs.next()){
			arrSalesAct.add(Helper.correctNull(rs.getString("ASSESS_COMMENTS2")));
			arrSalesProj.add(Helper.correctNull(rs.getString("ASSEMENT_COMMENT1")));
			arrYear.add(Helper.correctNull(rs.getString("ASSEMENT_COMMENT")));
			arrGrowth.add(Helper.correctNull(rs.getString("ASSESS_COMMENT4")));
			arrAchievement.add(Helper.correctNull(rs.getString("ASSESS_COMMENTS3")));
		}
		
		hshValues.put("arrYear",arrYear);
		hshValues.put("arrGrowth",arrGrowth);
		hshValues.put("arrAchievement",arrAchievement);
		hshValues.put("arrSalesProj",arrSalesProj);
		hshValues.put("arrSalesAct",arrSalesAct);
		
		arrRow=new ArrayList();
		if (rs != null) {
			rs.close();
		}
		rs=DBUtils.executeLAPSQuery("sel_management_Assement^SecCoverage^1^"+strAppNo);
		while(rs.next())
		{
			arrCol=new ArrayList();
			arrCol.add(Helper.correctNull(rs.getString("ASSEMENT_COMMENT")));
			arrCol.add(Helper.correctNull(rs.getString("ASSESS_CMT5")));
			arrCol.add(Helper.correctNull(rs.getString("ASSEMENT_COMMENT1")));
			arrCol.add(Helper.correctNull(rs.getString("ASSESS_COMMENTS2")));
			arrCol.add(Helper.correctNull(rs.getString("ASSESS_COMMENTS3")));
			arrCol.add(Helper.correctNull(rs.getString("ASSESS_COMMENT4")));
			arrRow.add(arrCol);
		}
		
		hshValues.put("arrSecMovement",arrRow);
		
		if(rs!=null){rs.close();}
		strQuery2 = SQLParser.getSqlQuery("sel_summultiplebanking_appno^"+strAppNo);
		rs=DBUtils.executeQuery(strQuery2);
		if(rs.next())
		{	hshValues.put("FbSum1",Helper.correctDouble((String)rs.getString("FbSum")));
			hshValues.put("ProFbSum1",Helper.correctDouble((String)rs.getString("ProFbSum")));
		}
		
		if(rs!=null)
			rs.close();
		strQuery = SQLParser.getSqlQuery("sel_comcomments^RBICOM^2^"+strAppNo);
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next()) 
		{
			hshValues.put("strConductOffAcccmts",Helper.CLOBToString(rs.getClob("COM_COMMENTS")));
		}
		if(rs!=null)
			rs.close();
		strQuery = SQLParser.getSqlQuery("sel_comcomments^RBICOM^3^"+strAppNo);
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next()) 
		{
			hshValues.put("strFTPcmts",Helper.CLOBToString(rs.getClob("COM_COMMENTS")));
		}
		
		ArrayList listRow=new ArrayList();
		ArrayList listCol=new ArrayList();
		if(rs!=null)
			rs.close();
		rs=DBUtils.executeLAPSQuery("sel_com_assesmentdetails^"+strAppNo+"^MMithra");
		while(rs.next())
		{
			listCol=new ArrayList();
			listCol.add(Helper.correctNull(rs.getString("com_description")));
			listCol.add(Helper.correctNull(rs.getString("com_details")));
			listRow.add(listCol);
		}
		hshValues.put("listMMithra",listRow);

		 HashMap hshReqDetails=new HashMap();
		 HashMap hshRespDetails=new HashMap();
		 
		 MastApplicantBean msb=new MastApplicantBean();
		 hshReqDetails=new HashMap();
		 hshReqDetails.put("strPageType", "annexure");
		 hshReqDetails.put("hidapplicantnewid", strAppId);
		 hshRespDetails=msb.getAddressDetails(hshReqDetails); 
		 hshValues.put("hshRespDetails", hshRespDetails);
		 
		 
		//Non Fund based Limits Inland LC Limit
			arrOutRow	=  new ArrayList();
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("sel_com_nonfundloanlc^"+strAppNo+"^1");
			
			while(rs.next())
			{
				arrOutCol	= new ArrayList();
				
				arrOutCol.add(Helper.correctDouble(rs.getString("com_sanctionedamt")));
				arrOutCol.add(Helper.correctInt(rs.getString("com_inlandlcdpno")));
				arrOutCol.add(Helper.correctDouble(rs.getString("com_inlandlcdpamt")));
				arrOutCol.add(Helper.correctInt(rs.getString("com_inlandlcdano")));
				arrOutCol.add(Helper.correctDouble(rs.getString("com_inlandlcdaamt")));
				arrOutCol.add(Helper.correctInt(rs.getString("com_importlcdano")));
				arrOutCol.add(Helper.correctDouble(rs.getString("com_importlcdaamt")));
				arrOutCol.add(Helper.correctInt(rs.getString("com_importlcdpno")));
				arrOutCol.add(Helper.correctDouble(rs.getString("com_importlcdpamt")));
				arrOutCol.add(Helper.correctInt(rs.getString("com_devolvementno")));
				arrOutCol.add(Helper.correctDouble(rs.getString("com_devolvementamt")));
				arrOutCol.add(Helper.correctInt(rs.getString("com_permittedno")));
				arrOutCol.add(correctNull(Helper.CLOBToString(rs.getClob("com_remark"))));
				arrOutCol.add(Helper.correctNull((String)rs.getString("COM_YEAR_SNO")));
				arrOutCol.add(correctNull(Helper.CLOBToString(rs.getClob("COM_PERFOR_COMMENTS"))));
		
				arrOutRow.add(arrOutCol);
			}
			hshValues.put("arrNFBRow", arrOutRow);
			
			//Non Fund based Limits Import LC Limit - by DINESH on 11/04/2014
			arrOutRow	=  new ArrayList();
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("sel_com_nonfundloanlc^"+strAppNo+"^4");
			
			while(rs.next())
			{
				arrOutCol	= new ArrayList();
				
				arrOutCol.add(Helper.correctDouble(rs.getString("com_sanctionedamt")));
				arrOutCol.add(Helper.correctInt(rs.getString("com_inlandlcdpno")));
				arrOutCol.add(Helper.correctDouble(rs.getString("com_inlandlcdpamt")));
				arrOutCol.add(Helper.correctInt(rs.getString("com_inlandlcdano")));
				arrOutCol.add(Helper.correctDouble(rs.getString("com_inlandlcdaamt")));
				arrOutCol.add(Helper.correctInt(rs.getString("com_importlcdano")));
				arrOutCol.add(Helper.correctDouble(rs.getString("com_importlcdaamt")));
				arrOutCol.add(Helper.correctInt(rs.getString("com_importlcdpno")));
				arrOutCol.add(Helper.correctDouble(rs.getString("com_importlcdpamt")));
				arrOutCol.add(Helper.correctInt(rs.getString("com_devolvementno")));
				arrOutCol.add(Helper.correctDouble(rs.getString("com_devolvementamt")));
				arrOutCol.add(Helper.correctInt(rs.getString("com_permittedno")));
				arrOutCol.add(correctNull(Helper.CLOBToString(rs.getClob("com_remark"))));
				arrOutCol.add(Helper.correctNull((String)rs.getString("COM_YEAR_SNO")));
				arrOutCol.add(correctNull(Helper.CLOBToString(rs.getClob("COM_PERFOR_COMMENTS"))));
				
				arrOutRow.add(arrOutCol);
			}
			hshValues.put("arrNFBRowIM", arrOutRow);
			
			//Sanctioned Bank Guarantee Limit
			arrOutRow	=  new ArrayList();
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("sel_com_nonfundloanlc^"+strAppNo+"^3");
			
			while(rs.next())
			{
				arrOutCol	= new ArrayList();
				
				arrOutCol.add(Helper.correctDouble(rs.getString("com_sanctionedamt")));
				arrOutCol.add(Helper.correctInt(rs.getString("com_inlandlcdpno")));
				arrOutCol.add(Helper.correctDouble(rs.getString("com_inlandlcdpamt")));
				arrOutCol.add(Helper.correctInt(rs.getString("com_inlandlcdano")));
				arrOutCol.add(Helper.correctDouble(rs.getString("com_inlandlcdaamt")));
				arrOutCol.add(correctNull(Helper.CLOBToString(rs.getClob("com_remark"))));
				arrOutCol.add(Helper.correctNull((String)rs.getString("COM_YEAR_SNO")));
				arrOutCol.add(correctNull(Helper.CLOBToString(rs.getClob("COM_PERFOR_COMMENTS"))));
				arrOutRow.add(arrOutCol);
			}
			hshValues.put("arrBGLmtRow", arrOutRow);
			
			//Sanctioned Buyers credit limit
			arrOutRow	=  new ArrayList();
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("sel_com_nonfundloanlc^"+strAppNo+"^2");
			
			while(rs.next())
			{
				arrOutCol	= new ArrayList();
				
				arrOutCol.add(Helper.correctDouble(rs.getString("com_sanctionedamt")));
				arrOutCol.add(Helper.correctInt(rs.getString("com_inlandlcdpno")));
				arrOutCol.add(Helper.correctDouble(rs.getString("com_inlandlcdpamt")));
				arrOutCol.add(Helper.correctInt(rs.getString("com_inlandlcdano")));
				arrOutCol.add(Helper.correctDouble(rs.getString("com_inlandlcdaamt")));
				arrOutCol.add(Helper.correctInt(rs.getString("com_importlcdano")));
				arrOutCol.add(Helper.correctDouble(rs.getString("com_importlcdaamt")));
				arrOutCol.add(correctNull(Helper.CLOBToString(rs.getClob("com_remark"))));
				arrOutCol.add(Helper.correctNull((String)rs.getString("COM_YEAR_SNO")));
				arrOutCol.add(correctNull(Helper.CLOBToString(rs.getClob("COM_PERFOR_COMMENTS"))));

				arrOutRow.add(arrOutCol);
			}
			hshValues.put("arrBCLmtRow", arrOutRow);
		 
			// For Business Operation Details - by DINESH on 11/04/2014
			arrOutRow	=  new ArrayList();
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("selothercommentsdetails^"+strAppNo);
			while(rs.next())
			{
				arrOutCol	= new ArrayList();
				arrOutCol.add(Helper.correctDouble(rs.getString("com_interest")));	//0	
				arrOutCol.add(Helper.correctDouble(rs.getString("com_otherincome"))); //1
				arrOutCol.add(Helper.CLOBToString(rs.getClob("com_recoverystatus"))); //2
				arrOutCol.add(Helper.correctDouble(rs.getString("com_fromdate"))); //3
				arrOutCol.add(Helper.correctDouble(rs.getString("com_todate"))); //4
				arrOutCol.add(Helper.correctNull((String)rs.getString("COM_SNO"))); //5
				arrOutCol.add(Helper.correctNull((String)rs.getString("com_odinterest"))); //6
				arrOutCol.add(Helper.correctNull((String)rs.getString("com_forexincome"))); //7
				arrOutCol.add(Helper.correctNull((String)rs.getString("com_tlinterest"))); //8
				arrOutCol.add(Helper.correctNull((String)rs.getString("com_otherfacincome"))); //9
				arrOutRow.add(arrOutCol);
			}
			hshValues.put("arrOthDetRow", arrOutRow);
			
			
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("sel_recom_sancauth^"+strAppNo);
			if(rs.next())
			{
				hshValues.put("Compliance_recom_sancauth", "Yes");
			}
			else
			{
				hshValues.put("Compliance_recom_sancauth", "No");
			}
			
			
			if(rs!=null){rs.close();}
			strQuery = SQLParser.getSqlQuery("selcom_Rbiloanpolicyguide^"+strAppNo);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				String strpagef=Helper.correctNull(rs.getString("comrbi_pagetype"));
				//if(strpagef.equals("UNINR"))
				{
				hshValues.put("COMRBI_ASDATE"+strpagef,correctNull(rs.getString("COMRBI_ASDATE")));
				hshValues.put("COMRBI_COMMENTS"+strpagef,Helper.CLOBToString(rs.getClob("COMRBI_COMMENTS")));
				}
			}
			
			
				if(rs1!=null){rs1.close();}
				strQuery=SQLParser.getSqlQuery("sel_ratification_comments^ratification^5^"+strAppNo);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					hshValues.put("selratification",Helper.correctNull((String)rs1.getString("COM_SNO")));
					hshValues.put("COM_COMMENTS",Helper.CLOBToString(rs1.getClob("COM_COMMENTS")));
					
				}
				
				if(rs1!=null){rs1.close();}
				strQuery=SQLParser.getSqlQuery("sel_ratification_comments^ratification^6^"+strAppNo);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					hshValues.put("strSanctionTerms",Helper.CLOBToString(rs1.getClob("COM_COMMENTS")));
					
				}
				
				if(rs1!=null){rs1.close();}
				arrRow= new ArrayList();
				strQuery=SQLParser.getSqlQuery("sel_com_ratiftod^"+strAppNo+"^5");
				rs1=DBUtils.executeQuery(strQuery);
				
				while(rs1.next())
				{
					arrCol=new ArrayList();
				
					arrCol.add(Helper.correctNull(rs1.getString("com_ratif_serialno")));//0
					arrCol.add(Helper.correctNull(rs1.getString("com_ratif_accountno")));//1
					arrCol.add(Helper.correctNull(rs1.getString("com_ratif_todsanctef")));//2
					arrCol.add(Helper.correctNull(rs1.getString("com_ratif_todamount")));//3
					arrCol.add(Helper.correctNull(rs1.getString("com_ratif_duedate")));//4
					arrCol.add(Helper.correctNull(rs1.getString("com_ratif_reguldate")));//5
					arrCol.add(Helper.correctNull(rs1.getString("com_ratif_regularcomments")));//6
					arrRow.add(arrCol);
				}
				
				hshValues.put("ratificationarrRow",arrRow);
				
				arrRow=new ArrayList();
				if(rs1!=null){rs1.close();}
				strQuery=SQLParser.getSqlQuery("sel_approvedby_appno^"+strAppNo);
				rs1=DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					arrCol=new ArrayList();
					arrCol.add(correctNull(rs1.getString("USR_FNAME")));
					arrCol.add(correctNull(rs1.getString("USER_DESIGNATION")));
					arrCol.add(correctNull(rs1.getString("COM_DATE")));
					arrCol.add(correctNull(rs1.getString("COM_DETAILS")));
					arrRow.add(arrCol);
				}
				
				hshValues.put("arrPropFlow",arrRow);
				
				
				arrRow11=new ArrayList();
				//arrCol=new ArrayList();
				if(rs1!=null){rs1.close();}
				strQuery=SQLParser.getSqlQuery("sel_rpn_legalopinon^"+strAppNo);
				rs1=DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{  
					arrCol11=new ArrayList();
					arrCol11.add(Helper.correctNull(rs1.getString("APP_SEC_SECID")));//0
					arrCol11.add(Helper.correctNull(rs1.getString("APP_SEC_SECURITYVALUE")));//1
					arrCol11.add(Helper.correctNull(rs1.getString("CUS_SEC_VALUATION_DATE")));//2
					arrCol11.add(Helper.correctNull(rs1.getString("CUS_SEC_VALUER_NAME")));//3
					arrCol11.add(Helper.correctNull(rs1.getString("SEC_PL_LEGOPDATE")));//4
					arrCol11.add(Helper.correctNull(rs1.getString("SEC_PL_LAWNAME")));//5
					arrCol11.add(Helper.correctNull(rs1.getString("SEC_PL_LEGOPSUPDATE")));//6
					arrCol11.add(Helper.correctNull(rs1.getString("SEC_PL_LEGALAUDREPDATE")));//7
					arrCol11.add(Helper.correctNull(rs1.getString("SEC_LEGALAUDIT_LAWYERNAME")));//8
					arrRow11.add(arrCol11);
				}
				hshValues.put("legalopinonarrRow1",arrRow11);
				strQuery=SQLParser.getSqlQuery("sel_facility_type^"+strAppNo);

				rs1=DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					 FACILITY_SEL_TYPE=Helper.correctNull(rs1.getString("FACILITY_SEL_TYPE"));

					 //hshValues.put("facility_renewaljustif", Helper.correctNull(Helper.CLOBToString(rs1.getClob("facility_renewaljustif"))));
					hshValues.put("facility_renewaljustif", Helper.correctNull((rs1.getString("facility_renewaljustif"))));


					
				}
				if(FACILITY_SEL_TYPE.equalsIgnoreCase("2"))
				{
					FACILITY_SEL_TYPE="Renew";
				}
				else if(FACILITY_SEL_TYPE.equalsIgnoreCase("3"))
				{
					FACILITY_SEL_TYPE="Restructured";
				}
				else if(FACILITY_SEL_TYPE.equalsIgnoreCase("4"))
				{
					FACILITY_SEL_TYPE="Post Sanction";
				}
				else
				{
					FACILITY_SEL_TYPE="Fresh";
				}
				strQuery=SQLParser.getSqlQuery("sel_manag_comments^"+strAppNo);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					hshValues.put("COM_COMMENTS", Helper.correctNull(Helper.CLOBToString(rs1.getClob("COM_COMMENTS"))));
					
				}
				if(rs1!=null){rs1.close();}
				strQuery=SQLParser.getSqlQuery("sel_inward_no^"+strAppNo);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					hshValues.put("APP_INWARDNO", Helper.correctNull(rs1.getString("APP_INWARDNO")));
					
				}
				strQuery=SQLParser.getSqlQuery("sel_app_perm_no^"+strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshValues.put("APP_PERM_NO",Helper.correctNull(rs.getString("APP_PERM_NO")));
				}
				if(rs!=null){rs.close();}
				strQuery = SQLParser.getSqlQuery("sel_corporate_breifbackground^"+strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{ 
	                hshValues.put("com_interest_refno",correctNull(rs.getString("com_interest_refno")));

				}
				strQuery = SQLParser.getSqlQuery("sel_facno^"+strAppNo);
				rs1 = DBUtils.executeQuery(strQuery);
	  			while(rs1.next())
				{
	  				strfacno=Helper.correctNull(rs1.getString("facility_sno"));
				
	  				strQuery = SQLParser.getSqlQuery("sel_cgssd_asses^"+ strAppNo+"^"+strfacno);
				     rs = DBUtils.executeQuery(strQuery);
					 while(rs.next())
					    {
					    
					    	/* hshValues.put("com_capita",correctNull(rs.getString("com_capita")));
					    	 hshValues.put("com_promoter",correctNull(rs.getString("com_promoter")));
							hshValues.put("com_eligamount",correctNull(rs.getString("com_eligamount")));
							hshValues.put("com_amountappl",correctNull(rs.getString("com_amountappl")));
							hshValues.put("com_liability",correctNull(rs.getString("com_liability")));
							hshValues.put("com_maxloan",correctNull(rs.getString("com_maxloan")));
							hshValues.put("com_recamount",correctNull(rs.getString("com_recamount")));
							hshValues.put("com_entiry_name",correctNull(rs.getString("com_entiry_name")));
							hshValues.put("com_operaccountnum",correctNull(rs.getString("com_operaccountnum")));
							hshValues.put("com_status",correctNull(rs.getString("com_status")));
							hshValues.put("com_npadate",correctNull(rs.getString("com_npadate")));
						*/
					    	   arrColCgssd= new ArrayList();
					            arrColCgssd.add(Helper.correctDouble(rs.getString("com_capita")));
								arrColCgssd.add(Helper.correctDouble(rs.getString("com_promoter")));
								arrColCgssd.add(Helper.correctDouble(rs.getString("com_eligamount")));
								arrColCgssd.add(Helper.correctDouble(rs.getString("com_amountappl")));
								arrColCgssd.add(Helper.correctDouble(rs.getString("com_liability")));
								arrColCgssd.add(Helper.correctDouble(rs.getString("com_maxloan")));	
								arrColCgssd.add(Helper.correctDouble(rs.getString("com_recamount")));
								arrColCgssd.add(Helper.correctNull(rs.getString("com_entiry_name")));
								arrColCgssd.add(Helper.correctNull(rs.getString("com_operaccountnum")));
								arrColCgssd.add(Helper.correctNull(rs.getString("com_status")));
								arrColCgssd.add(Helper.correctNull(rs.getString("com_npadate")));
								arrRowcgssd.add(arrColCgssd);  
					    	 
						}
				
					     hshValues.put("arrRowcgssd",arrRowcgssd);
				if(rs!=null){
					rs.close();
				}
				 strQuery = SQLParser.getSqlQuery("sel_cgssdperc^"+ strAppNo+"^"+strfacno);
			     rs = DBUtils.executeQuery(strQuery);
			     while(rs.next())
			    {
			    	 hshValues.put("COM_CGSSDPERC",correctNull(rs.getString("COM_CGSSDPERC")));
			    	 hshValues.put("COM_RANGETO",correctNull(rs.getString("COM_RANGETO")));
					//hshRecord.put("com_eligamount",correctNull(rs.getString("com_eligamount")));
			    }
				}
			     String strUser="",strUserdesig="";
			     strQuery=SQLParser.getSqlQuery("sel_delegation^"+strAppNo);
					rs=DBUtils.executeQuery(strQuery);
					arrRow=new ArrayList();

					while(rs.next())
					{
						arrCol = new ArrayList();
						arrCol.add(correctNull(rs.getString("COM_APPNO"))); //0
						strUser=correctNull(rs.getString("COM_USERID"));
						arrCol.add(strUser);//1
						strUserdesig=correctNull(rs.getString("COM_USERDES"));
						arrCol.add(strUserdesig);//2
						arrCol.add(correctNull(rs.getString("COM_SNO")));//3
						
						if(Helper.isNumeric(strUserdesig))
						{
							strQuery = SQLParser.getSqlQuery("sel_CBSStaticDataPassingCode^"+"27^"+strUserdesig);
							rs1 = DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{
								arrCol.add(Helper.correctNull((String)rs1.getString("CBS_STATIC_DATA_DESC")));//13
							}
							else{
								arrCol.add(strUserdesig);
							}
						}
						else
						{
							if(strUserdesig.equals("adm"))	
							{
								arrCol.add("Administrator");
							}
							else if(strUserdesig.equals("999"))	
							{
								arrCol.add("DGM Admin");
							}
							else if(strUserdesig.equals("001"))	
							{
								arrCol.add("Officer");
							}
							else if(strUserdesig.equals("002"))	
							{
								arrCol.add("General Manager");
							}
							else if(strUserdesig.equals("003"))	
							{
								arrCol.add("Chief Manager");
							}
							else
							{
								arrCol.add(strUserdesig);
							}
						}
						arrCol.add(correctNull(rs.getString("COM_USER")));//5
						strQuery = SQLParser.getSqlQuery("setusername_byuserid^"+correctNull(rs.getString("COM_USER")));
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							arrCol.add(Helper.correctNull((String)rs1.getString("usrname")));//13
						}
						else{
							arrCol.add("");
						}
						arrCol.add(correctNull(rs.getString("COM_DETAILS")));
						arrCol.add(correctNull(rs.getString("COM_DATE")));

						arrRow.add(arrCol);	
					}
				hshValues.put("FACILITY_SEL_TYPE","Renewal");
				hshValues.put("arrRowprop",arrRow);
				
				String strFacsno[] ={"97"};
				String srModuleType="",mode="",strFacCode="",termType="";
				String strPrePost = "s";
				hshValues.put("strPrePost",strPrePost);
				
				for(i=0;i<strFacsno.length;i++)
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
						strQuery = SQLParser.getSqlQuery("sel_termscond_specific^"+strAppNo+"^"+termType+"^"+mode+"^"+srModuleType+"^"+"0");	
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
							
							
							strQuery1 = SQLParser.getSqlQuery("sel_termscond_specific^"+strAppNo+"^"+termType+"^"+mode+"^"+srModuleType+"^"+strPatentid);	
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
						hshValues.put("arrFacilityTerm"+i,arrFacilityTerm);
						hshValues.put("arrFacilityTermType"+i,arrFacilityTermType);
						hshValues.put("arrFacilityIdVal"+i,arrFacilityId);
						hshValues.put("arrFacilityId"+i,strFacsno[i]);
						hshValues.put("arrFacilityTermStatus"+i,arrFacilityTermStatus);
						hshValues.put("arrParentID"+i,arrParentID);
						if(rs!=null)rs.close();
						termType="A";
						strQuery = SQLParser.getSqlQuery("sel_termscond_specific^"+strAppNo+"^"+termType+"^"+mode+"^"+srModuleType+"^"+"0");	
						rs=DBUtils.executeQuery(strQuery);
						while (rs.next())
						{  
							arrFacilityTermApp.add(correctNull(rs.getString(1)));
							arrFacilityTermTypeApp.add(correctNull(rs.getString(2)));
							arrFacilityIdApp.add(correctNull(rs.getString(3)));	
							arrFacilityTermStatusapp.add(correctNull(rs.getString(4)));
						}
				
						hshValues.put("arrFacilityTermApp"+i,arrFacilityTermApp);
						hshValues.put("arrFacilityTermTypeApp"+i,arrFacilityTermTypeApp);
						hshValues.put("arrFacilityIdAppVal"+i,arrFacilityIdApp);	
						hshValues.put("arrFacilityTermStatusapp"+i,arrFacilityTermStatusapp);
				}
				
				
				//Management Comments
				for(int a=0;a<strCommentMgmtSno.length;a++)
				{
					if(rs!=null){rs.close();}
					rs	= DBUtils.executeLAPSQuery("sel_management^MangementInfo^"+strCommentMgmtSno[a]+"^"+strAppNo);
					if(rs.next())
					{
						hshValues.put("MgmtComments"+correctNull(rs.getString("com_sno")), correctNull(Helper.CLOBToString(rs.getClob("com_comments"))));
					}
				}
				
				arrRow=new ArrayList();
				//Buyer Information
				rs = DBUtils.executeLAPSQuery("sel_management_Assement^MangementInfo^6^" + strAppNo);
				while (rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull(rs.getString("ASSEMENT_COMMENT")));//0
					arrCol.add(Helper.correctNull(rs.getString("ASSEMENT_COMMENT1")));//5
					arrCol.add(Helper.correctNull(rs.getString("assess_comments2")));//6
					arrCol.add(Helper.correctNull(rs.getString("assess_comments3")));//7
					arrRow.add(arrCol);
				}
				
				hshValues.put("arrBuyerInfo", arrRow);
				
				arrRow=new ArrayList();
				//Seller Information  
				rs = DBUtils.executeLAPSQuery("sel_management_Assement^MangementInfo^5^" + strAppNo);
				while (rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull(rs.getString("ASSEMENT_COMMENT")));//0
					arrCol.add(Helper.correctNull(rs.getString("ASSEMENT_COMMENT1")));//5
					arrCol.add(Helper.correctNull(rs.getString("assess_comments2")));//6
					arrCol.add(Helper.correctNull(rs.getString("assess_comments3")));//7
					arrRow.add(arrCol);
				}
				
				hshValues.put("arrSellerInfo", arrRow);
				
				arrRow=new ArrayList();
				//Key Managerial Person  
				rs = DBUtils.executeLAPSQuery("sel_management_Assement^MangementInfo^15^" + strAppNo);
				while (rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull(rs.getString("ASSEMENT_COMMENT")));//0
					arrCol.add(Helper.correctNull(rs.getString("ASSEMENT_COMMENT1")));//5
					arrCol.add(Helper.correctNull(rs.getString("assess_comments2")));//6
					arrCol.add(Helper.correctNull(rs.getString("assess_comments3")));//7
					arrRow.add(arrCol);
				}
				
				hshValues.put("arrKeyPersonInfo", arrRow);
				
				if(rs!=null)
				{
					rs.close();
				}
				strPage="brief2";
				strQuery = SQLParser.getSqlQuery("sel_comments^"+strPage+"^"+ strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) 
				{
					hshValues.put("cmt_Briefhistory2", Helper.CLOBToString(rs.getClob("COM_COMMENTS")));
				}

		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getRenewalProcessNote login  "+ce.toString());
		}
		finally
		{
			try
			{	
				if(rs != null){	rs.close();}
				if(rs1 != null){	rs1.close();}
				if(rs2 != null){	rs2.close();}
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshValues; 
	}
	public HashMap getmisprocessnotedetails(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs=null;
		ResultSet rs1=null,rs4=null,rs2=null,rs6=null;
		//HashMap hshValues = new HashMap();
		String recordflag="N";
		String StrAppno="",strLoanType="";
		String strFreeze="";
		int cho_promoter=0;
		String strFacilitySno="";
		ArrayList arrMISRow	= new ArrayList();
		ArrayList arrMISCol	= new ArrayList();
		String strSector="",strSubSector="",strcrtsales="";
		String mainactivity="",subactivity="";
		try
		{
			StrAppno=correctNull((String)hshValues.get("appno"));
			 strLoanType=correctNull((String)hshValues.get("LoanType"));
			String strAmountValue=correctNull((String)hshValues.get("strAmountValue"));
			String strAmtValueIn=correctNull((String)hshValues.get("strAmtValueIn"));
			String strAppId=correctNull((String)hshValues.get("appid"));
			//MIS information
			if(rs!=null){rs.close();}
			arrMISRow	= new ArrayList();
			rs	= DBUtils.executeLAPSQuery("sel_misapp_desc^"+StrAppno+"^"+strLoanType);
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
					rs1=DBUtils.executeLAPSQuery("sel_cusdetails^"+strAppId);
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
					strQuery=SQLParser.getSqlQuery("sel_minorityconstitutionchk^"+strAppId);
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
			
			hshValues.put("strAmountValue", strAmountValue);
			hshValues.put("strAmtValueIn", strAmtValueIn);
		}
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
			throw new EJBException("error occured in getValues"+e.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
			}
			catch (Exception e1)
			{
				log.error("error occured"+e1.toString());
			}
		}
		return hshValues;
	}
	
	public HashMap getSvanidhiAssess(HashMap hshValues) 
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null,rs1=null;
		String strQuery="";
		String strAppno="";
		String strFacSno="";
		String strAppId="";
		String strType="";
		String san_amt="";
		String prop_amt="";
		String flow_type="";
		String prdcode="";
		try
		{ 
			strAppno=correctNull((String)hshValues.get("appno"));//
			strAppId=correctNull((String)hshValues.get("hidapplicantid"));
			String ass_type="";
			flow_type=correctNull((String)hshValues.get("flowtype"));
			if(("PMS3").equals(flow_type)){
				strType="2";
				ass_type="3";
			}
			if(("").equalsIgnoreCase(strType)){
				strType=Helper.correctNull((String)hshValues.get("hid_strType"));
				 if(("3").equals(strType)){
					strType="2";
					ass_type="3";

				}
			}
			
			
			if(rs!=null)
				rs.close();	
			double sanct_amt=0.0;
			double req_amt=0.0;
			double prd_range=0.0;
			String acc_num="";
			String fac_id="";
			rs= DBUtils.executeQuery(SQLParser.getSqlQuery("sel_Svanidhifacilities^"+strAppId+"^"+strType));
			if(rs.next())
			{
				sanct_amt=(Double) rs.getDouble("FACILITY_SANCTIONED");				
				hshResult.put("SVANIDHI_SANCTIONED_AMOUNT",  Helper.correctNull(rs.getString("FACILITY_SANCTIONED")));
				acc_num=Helper.correctNull(rs.getString("CBS_ACCOUNTNO"));
				hshResult.put("SVANIDHI_ACCNUMBER",  Helper.correctNull(acc_num));
				
					
			} 
			if(rs!=null)
				rs.close();
			rs= DBUtils.executeQuery(SQLParser.getSqlQuery("sel_SvanidhiStatus^"+strAppno+"^"+ass_type));
			if(rs.next())
			{
				strFacSno=Helper.correctNull(rs.getString("FACILITY_SNO"));
				fac_id=Helper.correctNull(rs.getString("FACILITY_CODE"));
				req_amt=(Double) rs.getDouble("FACILITY_PROPOSED");				
				hshResult.put("SVANIDHI_BORROWER_AMOUNT",  Helper.correctNull(rs.getString("FACILITY_PROPOSED")));
				prd_range=(Double) rs.getDouble("COM_RANGETO");		
			} 

			if(rs!=null)
			rs.close();
			
			if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
			{
				strQuery=SQLParser.getCBSSqlQuery("sel_acct_datedetails_newcon^"+acc_num);
				rs=DBUtils.executeQueryCBSConnection(strQuery);
			}
			else
			{
				strQuery=SQLParser.getCBSSqlQuery("sel_acct_datedetails^"+acc_num);
				rs=DBUtils.executeQueryCBSConnection(strQuery); 
			}
			
			
			String acc_opened_date="";
			String acc_closed_date="";
			
			if(rs.next()) 
			{
				acc_opened_date= Helper.correctNull(rs.getString("acct_opn_date"));
				acc_closed_date=Helper.correctNull(rs.getString("acct_cls_date"));
				hshResult.put("SVANIDHI_OPENED_DATE", acc_opened_date);
				hshResult.put("SVANIDHI_CLOSED_DATE",acc_closed_date );
							
			}
						
			String Pattern="dd/MM/yyyy";
			String repay_days="";
			long diffDays=0;
			DateFormat df=new SimpleDateFormat(Pattern);
			if(!("").equalsIgnoreCase(acc_opened_date)&& !("").equalsIgnoreCase(acc_closed_date)){
			Date acccreationdate=df.parse(acc_opened_date);
			Date acccloseddate=df.parse(acc_closed_date);
			
			long diff = acccloseddate.getTime() - acccreationdate.getTime();
			diffDays = diff / (24 * 60 * 60 * 1000);
			repay_days=String.valueOf(diffDays);
			}
			hshResult.put("SVANIDHI_REPAY_DAYS", Helper.correctNull(repay_days));
			
			
			double eligible_percentage=0.0;
			
			if(rs!=null)
				rs.close();
			rs= DBUtils.executeQuery(SQLParser.getSqlQuery("get_eligibile_percentage^"+fac_id+"^"+ass_type+"^"+repay_days));
			if(rs.next())
			{
				eligible_percentage=(Double) rs.getDouble("SVANIDHI_ELIGIBILE_PERCENTAGE");
						
			} else{
				hshResult.put("Eligible_percentage","N"  );
				
			}
			
			double eligibleamt=0.0;
			
			eligible_percentage=eligible_percentage/100;
			eligibleamt=sanct_amt * eligible_percentage;
			
			san_amt=String.valueOf(eligibleamt);
			hshResult.put("SVANIDHI_ELIGIBLE_AMOUNT",  Helper.correctNull(san_amt));
			
			//least of eligibleamt,req_amt and prd_range
			Double proposed_amt=0.0;
			proposed_amt=prd_range < (eligibleamt < req_amt ? eligibleamt : req_amt )? prd_range :
				 ((eligibleamt < req_amt) ? eligibleamt : req_amt);
			prop_amt=String.valueOf(proposed_amt);
			hshResult.put("SVANIDHI_PROPOSED_AMOUNT",  Helper.correctNull(prop_amt));
			hshResult.put("recordFlag",  correctNull((String)hshValues.get("recordFlag")));
		
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getSvanidhiAssess" + e.getMessage());
		}
		finally
		{
			try
			{
				if(rs!=null)
				{
					rs.close();
				}
				if(rs1!=null)
				{
					rs1.close();
				}
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshResult;
	}
	public void updateSvanidhiAssess(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String appno=Helper.correctNull((String)hshValues.get("appno"));
		String sno=Helper.correctNull((String)hshValues.get("hid_sno"));
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		String strAss=Helper.correctNull((String)hshValues.get("hid_strType"));
		String perappid=Helper.correctNull((String)hshValues.get("hidapplicantid"));	
		ResultSet rs=null;
		String unique_no="";
		String strFacSno="";
		try
		{
			if(rs!=null)
				rs.close();
		
			 
			rs = DBUtils.executeQuery(SQLParser.getSqlQuery("sel_svanidhidetails^"+perappid));
			if(rs.next())
			{
				unique_no=Helper.correctNull(rs.getString("per_svanidhiappno"));
			}
			rs= DBUtils.executeQuery(SQLParser.getSqlQuery("sel_SvanidhiStatus^"+appno+"^"+strAss));
			if(rs.next())
			{
				strFacSno=Helper.correctNull(rs.getString("FACILITY_SNO"));
					
			} 
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size", "2");
				hshQuery.put("strQueryId", "del_SvanidhiAssess_details");
				arrValues.add(appno);
				arrValues.add(strAss);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId", "ins_SvanidhiAssess_details");
				arrValues.add(appno);
				arrValues.add(strFacSno);
				arrValues.add(strAss);
				arrValues.add(unique_no);				
				arrValues.add(correctNull((String) hshValues.get("txt_svanidhi_accnumber")));
				arrValues.add(correctNull((String) hshValues.get("txt_svanidhi_opened_date")));
				arrValues.add(correctNull((String) hshValues.get("txt_svanidhi_closed_date")));
				arrValues.add(correctNull((String) hshValues.get("txt_svanidhi_sanctioned_amount")));
				arrValues.add(correctNull((String) hshValues.get("txt_svanidhi_repay_days")));
				arrValues.add(correctNull((String) hshValues.get("txt_svanidhi_eligible_amount")));
				arrValues.add(correctNull((String) hshValues.get("txt_svanidhi_borrower_amount")));
				arrValues.add(correctNull((String) hshValues.get("txt_svanidhi_proposed_amount")));
				
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				
			}
			
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_SvanidhiAssess_details");
				arrValues.add(appno);
				arrValues.add(strAss);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
			}
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updatedata");
	
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updateSvanidhiAssess Data " + e.getMessage());
		}

	

}	
	public double getExposureTotalLimit(String strAppID, String strValuesin ,String strSessionModuleType)
	 {
		ResultSet rs = null;
		String strQuery = "";
		String strExposureTotalLimit = "";
		String strAppOldID = "";
		double dblExposuretotallimit = 0.00;
		
		try {
			/*strQuery = SQLParser.getSqlQuery("select_perappoldid^" + strAppID);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strAppOldID = Helper.correctNull((String) rs
						.getString("perapp_oldid"));
			}
			if (!strAppOldID.equalsIgnoreCase("")) {
				if (rs != null) {
					rs.close();
				}*/
			
			 if(strSessionModuleType.equalsIgnoreCase("CORP"))
			 {	 
				strQuery = SQLParser.getSqlQuery("sel_exposurelimit_corp^" +strAppID+"^"+strAppID+"^"+strAppID+"^"+strAppID+"^"+strAppID+"^"+strAppID+"^"+strAppID);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					dblExposuretotallimit = Double.parseDouble((String) Helper
							.correctDouble(rs.getString("totexp")));
				}
			 }
			 else
			 {
				 strQuery = SQLParser.getSqlQuery("sel_exposurelimit_ret^" +strAppID+"^"+strAppID+"^"+strAppID+"^"+strAppID+"^"+strAppID+"^"+strAppID+"^"+strAppID);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						dblExposuretotallimit = Double.parseDouble((String) Helper
								.correctDouble(rs.getString("totexp")));
					}
			 }
				
			//}
			strExposureTotalLimit = Helper.convertSetupToApplicationValues(strValuesin,
					dblExposuretotallimit);
		} catch (Exception ce) {
			throw new EJBException("Error in getExposureTotalLimit "
					+ ce.toString());
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
	return Double.parseDouble(strExposureTotalLimit);
}
	public double getExposureTotalLimitagri(String strAppID, String strValuesin, String misactcode)
	 {
		ResultSet rs = null;
		ResultSet rs1 = null;
		String strQuery2 = "";
		String strQuery = "";
		String strExposureTotalLimitagr = "";
		String strAppOldID = "";
		double dblExposuretotallimitagr = 0.00;
		try {
			/*strQuery = SQLParser.getSqlQuery("select_perappoldid^" + strAppID);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strAppOldID = Helper.correctNull((String) rs
						.getString("perapp_oldid"));
			}
			if (!strAppOldID.equalsIgnoreCase("")) {
				if (rs != null) {
					rs.close();
				}*/
			
				if(misactcode.equals("0"))
				{
					strQuery2 = SQLParser.getSqlQuery("getmis_appdetailsagrall^"+strAppID);
					rs1 = DBUtils.executeQuery(strQuery2);					
					if (rs1.next()) {
					strQuery = SQLParser.getSqlQuery("sel_exposurelimit_agrother^" +strAppID+"^"+strAppID+"^"+strAppID+"^"+strAppID+"^"+strAppID);
					}
					else
					{
					 strQuery = SQLParser.getSqlQuery("sel_exposurelimit_corp^" +strAppID+"^"+strAppID+"^"+strAppID+"^"+strAppID+"^"+strAppID+"^"+strAppID+"^"+strAppID);
					}
					
				}
				else
				{
					strQuery = SQLParser.getSqlQuery("sel_exposurelimit_agr^" +strAppID+"^"+strAppID+"^"+strAppID+"^"+strAppID+"^"+strAppID);
				}
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					dblExposuretotallimitagr = Double.parseDouble((String) Helper
							.correctDouble(rs.getString("totexp")));
				}
				
			//}
			strExposureTotalLimitagr = Helper.convertSetupToApplicationValues(strValuesin,
					dblExposuretotallimitagr);
		} catch (Exception ce) {
			throw new EJBException("Error in getExposureTotalLimitagri "
					+ ce.toString());
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
	return Double.parseDouble(strExposureTotalLimitagr);
}	
	
	//vindhya end	
	
}
