package com.sai.laps.ejb.solvency;

import java.awt.print.Printable;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.TimeZone;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.fw.management.utils.FwHelper;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "ComSolvencyBean", mappedName = "ComSolvencyHome")
@Remote (ComSolvencyRemote.class)
public class ComSolvencyBean extends BeanAdapter{
	
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(ComSolvencyBean.class);
	
	public HashMap updateSolvencyData(HashMap hsh) 
	{
		HashMap hshqueryval =new HashMap();
		HashMap hshquery = new HashMap();
		ArrayList arr = new ArrayList();
		ResultSet rs = null;
		int  strsno=0;
		String  strAction="";
		String OrgCode="",
		       strAppno="",
		       struserid="",
		       strOrgcode="",
		       year="",
		       strAppnum="",
		       strOldid=""; 
		try
		{
			String strcertno="";
			strAction=correctNull((String)hsh.get("hidAction"));
			struserid=correctNull((String)hsh.get("txt_usrid"));
			strOrgcode=correctNull((String)hsh.get("strOrgCode"));
			strAppnum=correctNull((String)hsh.get("txt_applno"));
			strAppno=correctNull((String)hsh.get("strappno"));
			strOldid=correctNull((String)hsh.get("old_appid"));
			
					
			OrgCode=Helper.correctNull((String)hsh.get("strSolid"));
			HashMap hshTemp = new HashMap();
		       hshTemp.put("prdcode", "1");
		       hshTemp.put("recamt",Helper.correctNull((String)hsh.get("txt_amtrs")));
		       hshTemp.put("appno", strAppno);
		       HashMap hshGetDocFee = (HashMap) EJBInvoker.executeStateLess("perlimitofloan", hshTemp, "getSolvencyDocFee");
		       double procfee1 = Math.ceil(Double.parseDouble(Helper.correctDouble((String) hshGetDocFee.get("procfee"))));
				String strLoanProcFee=String.valueOf(procfee1);
				
			if(strAppno.equalsIgnoreCase("") && strAction.equalsIgnoreCase("new"))
		    {	
				int scodeLength=OrgCode.length();
				if(scodeLength==1){
					OrgCode="000"+OrgCode;
				}
				if(scodeLength==2){
					OrgCode="00"+OrgCode;
				}
				if(scodeLength==3){
					OrgCode="0"+OrgCode;
				}
				
			    rs=DBUtils.executeLAPSQuery("sel_maxid_solvency^"+OrgCode);
				if(rs.next())
				{
					strsno=Integer.parseInt(rs.getString("sol_appl_no"));
				}	
				
				// int applength=strsno.length();
					
				java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
						nf.setMinimumIntegerDigits(6);
						nf.setGroupingUsed(false);
						strAppno=nf.format(strsno);
				 
					 strAppno=OrgCode+"S"+strAppno;
					 
					 hsh.put("strappno",strAppno);

		    }
			    
                			     
				hshquery=new HashMap();
				arr=new ArrayList();
				if(strAction.equalsIgnoreCase("new"))
				{
				hshquery.put("strQueryId","ins_com_solvency");
				arr.add(Helper.correctNull((String)hsh.get("txt_nameofappl")));
				arr.add(Helper.correctNull((String)hsh.get("txt_purpose")));
				arr.add(Helper.correctNull((String)hsh.get("txt_amtrs")));
				arr.add(strLoanProcFee);
				arr.add(Helper.correctNull((String)hsh.get("txt_networth")));
				arr.add(Helper.correctNull((String)hsh.get("txt_existacc")));
				arr.add(Helper.correctNull((String)hsh.get("txt_solcertf")));
				arr.add(Helper.correctNull((String)hsh.get("txt_issuedt")));
				arr.add(Helper.correctNull((String)hsh.get("sel_SancAuth")));
			    arr.add(Helper.correctNull((String)hsh.get("txt_address")));
				arr.add(Helper.correctNull((String)hsh.get("txt_addresstwo")));
				arr.add(Helper.correctNull((String)hsh.get("txt_village")));
				arr.add(Helper.correctNull((String)hsh.get("hidperapp_city")));
				arr.add(Helper.correctNull((String)hsh.get("hidperapp_permstate")));
				arr.add(Helper.correctNull((String)hsh.get("hidperapp_state")));
				arr.add(Helper.correctNull((String)hsh.get("txt_permzip")));
				arr.add(Helper.correctNull((String)hsh.get("hidperapp_country")));
				arr.add(Helper.correctNull((String)hsh.get("txt_cbsid")));
				arr.add(Helper.correctNull((String)hsh.get("hid_appid")));
			    arr.add(strAppno);
			    arr.add(struserid);
			    arr.add(struserid);
			    arr.add("Y");
			    arr.add("SOL");
			    arr.add(strOrgcode);
			    arr.add("OP");
			    arr.add(strOldid);
			    arr.add(Helper.correctNull((String)hsh.get("txt_solno")));
				arr.add(Helper.correctNull((String)hsh.get("sel_SancDept")));
				arr.add(Helper.correctNull((String)hsh.get("sel_SancBranch")));
				arr.add(Helper.correctNull((String)hsh.get("sanctiondate")));
				arr.add(Helper.correctNull((String)hsh.get("txt_sancrefno")));
			    hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				hshqueryval.put("size","1");
				}
				else if(strAction.equalsIgnoreCase("insert"))
				{
					hshquery.put("strQueryId","upd_com_solvency");
					arr.add(Helper.correctNull((String)hsh.get("txt_purpose")));
					arr.add(Helper.correctNull((String)hsh.get("txt_amtrs")));
					arr.add(strLoanProcFee);
					arr.add(Helper.correctNull((String)hsh.get("txt_existacc")));
					arr.add(Helper.correctNull((String)hsh.get("txt_issuedt")));
					arr.add(Helper.correctNull((String)hsh.get("sel_SancAuth")));
					arr.add(Helper.correctNull((String)hsh.get("txt_solcertf")));
					arr.add(Helper.correctNull((String)hsh.get("txt_solno")));
					arr.add(Helper.correctNull((String)hsh.get("sel_SancDept")));
					arr.add(Helper.correctNull((String)hsh.get("sel_SancBranch")));
					arr.add(Helper.correctNull((String)hsh.get("sanctiondate")));
					arr.add(Helper.correctNull((String)hsh.get("txt_sancrefno")));
				    arr.add(strAppno);
				    hshquery.put("arrValues",arr);
					hshqueryval.put("1",hshquery);
					hshqueryval.put("size","1");
				}
				else if(strAction.equalsIgnoreCase("delete"))
				{
					hshqueryval = new HashMap();
					hshquery = new HashMap();		
					arr=new ArrayList();
					hshquery.put("strQueryId","del_com_solvency");
					arr.add(strAppno);
					hshquery.put("arrValues",arr);
					hshqueryval.put("1",hshquery);
					hshqueryval.put("size","1");
					
					hshquery = new HashMap();		
					arr=new ArrayList();
					hshquery.put("strQueryId","del_solvency_appmailbox");
					arr.add(strAppno);
					hshquery.put("arrValues",arr);
					hshqueryval.put("2",hshquery);
					hshqueryval.put("size","2");
				}
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				
				
				if(strAppnum.equalsIgnoreCase(""))
			    {	
				hshqueryval=new HashMap();
				arr=new ArrayList();
				hshquery.put("strQueryId","ins_mail_sol");
				arr.add(strAppno);
				arr.add(struserid);
				arr.add(struserid);
				arr.add("1");
				arr.add("1");
				arr.add("C");
				arr.add(correctNull((String)hsh.get("strOrgShortCode")));
				if(correctNull((String)hsh.get("strOrgLevel")).equalsIgnoreCase("C"))
					arr.add(correctNull((String)hsh.get("strUserDepartment")));
				else if(correctNull((String)hsh.get("strOrgLevel")).equalsIgnoreCase("D"))
					arr.add(correctNull((String)hsh.get("strRLPFUser")));
				else
					arr.add("");
				arr.add(correctNull((String)hsh.get("strOrgShortCode")));
				if(correctNull((String)hsh.get("strOrgLevel")).equalsIgnoreCase("C"))
					arr.add(correctNull((String)hsh.get("strUserDepartment")));
				else if(correctNull((String)hsh.get("strOrgLevel")).equalsIgnoreCase("D"))
					arr.add(correctNull((String)hsh.get("strRLPFUser")));
				else
					arr.add("");
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				hshqueryval.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			    }
			
				
			  	 hsh = getSolvencyData(hsh);
			  	 System.out.println("***********processing fee****************"+hshGetDocFee);
		       
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs!=null)
					rs.close();
			}catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in updateCompany "+ exp.toString()); 
			}
		}
		return hsh;
		
	}
	
	public HashMap getSolvencyData(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		HashMap hshValues=new HashMap();
		
		HashMap hshQuery=null;
		HashMap hshQueryValues=null;
		ArrayList arrValues=null;
		String strQuery="",strQuery1,strCitycode="",strCountryCode="",strPermstatecode="";
		String strAppid="",strDistcode="";
		String appstatus="";
		String strAction=Helper.correctNull((String)hshRequestValues.get("hidAction"));
		String strAppno = Helper.correctNull((String) hshRequestValues.get("strappno"));
		double networth=0.0f;
		int month=0;
		int year1=0;
		int year2=0;
		String year="",StrCertificateNo="";
		
		java.text.NumberFormat jtn= java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		try
		{	
			
			strAppid=Helper.correctNull((String)hshRequestValues.get("appid"));	
			String strSolid=Helper.correctNull((String)hshRequestValues.get("strSolid"));
			if(strAppid.equalsIgnoreCase(""))
			{
				strAppid=Helper.correctNull((String)hshRequestValues.get("hid_appid"));	
			}
			if(strAppid.equalsIgnoreCase(""))
			{
				strAppid=Helper.correctNull((String)hshRequestValues.get("cattype"));	
			}
			if(strAppid.equalsIgnoreCase(""))
			{
				strAppid=Helper.correctNull((String)hshRequestValues.get("hidDemoId"));	
			}
			if(strAppid.equalsIgnoreCase(""))
			{
				strAppid=Helper.correctNull((String)hshRequestValues.get("hidAppid"));	
			}
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)hshRequestValues.get("hidapplno"));	
			}
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)hshRequestValues.get("hidApplno"));	
			}
			
			hshValues.put("SOL_APPID",strAppid);
			
			if(rs!=null)
				rs.close();
			
			strQuery = SQLParser.getSqlQuery("selmon_curyear");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{ 
				month=rs.getInt("mon_curryear");
				year1=rs.getInt("curryear");
			}
			
			if(month>3)
			{
			year2=year1+1;
			year=String.valueOf(year1)+"-"+String.valueOf(year2);
			}
			else
			{
			year2=year1-1;
			year=String.valueOf(year2)+"-"+String.valueOf(year1);	
			}
			StrCertificateNo=strSolid+"/ /"+year;
			hshValues.put("SOL_CERTF_NO",StrCertificateNo);
			if(!strAppno.equalsIgnoreCase(""))
			{
				
				strQuery1 = SQLParser.getSqlQuery("select_networth_cusprofile^"+strAppid);
				rs=DBUtils.executeQuery(strQuery1);
				
				if(rs.next()){
					networth=Double.parseDouble(Helper.correctDouble(rs.getString("PERAPP_NETWORTH")));
				}
				
				if(rs!=null)
					rs.close();
				strQuery = SQLParser.getSqlQuery("sel_com_solvency^"+strAppid+"^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{  
					
					if(Helper.correctNull(rs.getString("SOL_STATUS")).equals("OP"))
					{
						if(Double.parseDouble(Helper.correctDouble(rs.getString("SOL_NETWORTH")))!=networth)
						{
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							hshQueryValues=new HashMap();
							
							hshQuery.put("strQueryId","updt_solvency");
							
							arrValues.add(jtn.format(networth));
							arrValues.add(strAppno);
							hshQueryValues.put("size","1");
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
							
							hshValues.put("SOL_NETWORTH",jtn.format(networth));
						}
						else
						{
							hshValues.put("SOL_NETWORTH",Helper.correctDouble(rs.getString("SOL_NETWORTH")));
						}
					}
					else
					{
						hshValues.put("SOL_NETWORTH",Helper.correctDouble(rs.getString("SOL_NETWORTH")));
					}
					hshValues.put("SOL_APPLICANT_NAME",correctNull(rs.getString("SOL_APPLICANT_NAME")));
					//hshValues.put("SOL_ADDRESS",correctNull(rs.getString("SOL_ADDRESS")));
					hshValues.put("SOL_PURPOSE",correctNull(rs.getString("SOL_PURPOSE")));
					hshValues.put("SOL_AMOUNT",correctNull(rs.getString("SOL_AMOUNT")));
					hshValues.put("procfee",correctNull(rs.getString("SOL_COMMISSION_EARNED")));
					hshValues.put("SOL_EXISTING_ACCNO",correctNull(rs.getString("SOL_EXISTING_ACCNO")));
					hshValues.put("SOL_CERTF_NO",correctNull(rs.getString("SOL_CERTF_NO")));
					hshValues.put("SOL_DATE",correctNull(rs.getString("SOL_DATE")));
					hshValues.put("SOL_SANCTIONED_BY",correctNull(rs.getString("SOL_SANCTIONED_BY")));
					hshValues.put("SOL_ADDRESS_ONE",correctNull(rs.getString("SOL_ADDRESS_ONE")));
					hshValues.put("SOL_ADDRESS_TWO",correctNull(rs.getString("SOL_ADDRESS_TWO")));
					hshValues.put("SOL_VILLAGE_TALUK_TOWN",correctNull(rs.getString("SOL_VILLAGE_TALUK_TOWN")));
					hshValues.put("SOL_CITY",correctNull(rs.getString("SOL_CITY")));
					hshValues.put("SOL_DISTRICT",correctNull(rs.getString("SOL_DISTRICT")));
					hshValues.put("SOL_STATE",correctNull(rs.getString("SOL_STATE")));
					hshValues.put("SOL_PINCODE",correctNull(rs.getString("SOL_PINCODE")));
					hshValues.put("SOL_COUNTRY",correctNull(rs.getString("SOL_COUNTRY")));
					hshValues.put("SOL_CBS_ID",correctNull(rs.getString("SOL_CBS_ID")));
					hshValues.put("SOL_APPID",correctNull(rs.getString("SOL_APPID")));
					hshValues.put("SOL_APPL_NO",correctNull(rs.getString("SOL_APPL_NO")));
					hshValues.put("SOL_MAILCHKSTATUS",correctNull(rs.getString("SOL_MAILCHKSTATUS")));
					hshValues.put("SOL_LOANTYPE",correctNull(rs.getString("SOL_LOANTYPE")));
					hshValues.put("SOL_APPLNHOLDER",correctNull(rs.getString("SOL_APPLNHOLDER")));
					hshValues.put("SOL_USRID",correctNull(rs.getString("SOL_USRID")));
					hshValues.put("SOL_STATUS",correctNull(rs.getString("SOL_STATUS")));
					appstatus=correctNull(rs.getString("SOL_STATUS"));
					hshValues.put("SOL_NAME",correctNull(rs.getString("ORG_NAME")));
					hshValues.put("SOL_OLDID",correctNull(rs.getString("SOL_OLDID")));
					hshValues.put("sol_solvencyno",correctNull(rs.getString("sol_solvencyno")));
					hshValues.put("SOL_SANCTIONING_DEPT",correctNull(rs.getString("SOL_SANCTIONING_DEPT")));
					hshValues.put("SOL_SANCTIONING_BRANCH",correctNull(rs.getString("SOL_SANCTIONING_BRANCH")));
					hshValues.put("Sanction_Date",correctNull(rs.getString("Sanction_Date")));
					hshValues.put("Sanc_Ref_No",correctNull(rs.getString("Sanc_Ref_No")));
					strPermstatecode=Helper.correctNull(rs.getString("SOL_STATE"));
					strCitycode = Helper.correctNull(rs.getString("SOL_CITY"));
					strCountryCode =Helper.correctNull(rs.getString("SOL_COUNTRY"));
					strDistcode=Helper.correctNull(rs.getString("SOL_DISTRICT"));
					hshValues.put("hidAction","");
					strAction="";
				}
			}
			if(strAction.equalsIgnoreCase("new"))
			{
					hshValues.put("SOL_APPLICANT_NAME",Helper.correctNull((String)hshRequestValues.get("customername")));
				
					strQuery = SQLParser.getSqlQuery("sel_com_solvecncy_for_communication_details^"+strAppid);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						String NRIResidentStatus=correctNull(rs.getString("INDINFO_RESIDENT_STATUS"));
						hshValues.put("SOL_APPLICANT_NAME",correctNull(rs.getString("PERAPP_FNAME")));
						if(NRIResidentStatus.equals("N"))
						{
							hshValues.put("SOL_ADDRESS_ONE",correctNull(rs.getString("CON_COMADDR1")));
							hshValues.put("SOL_ADDRESS_TWO",correctNull(rs.getString("CON_COMADDR2")));
							hshValues.put("SOL_VILLAGE_TALUK_TOWN",correctNull(rs.getString("CON_COMVILLAGE")));
							hshValues.put("SOL_CITY",correctNull(rs.getString("CON_COMCITY")));					
							hshValues.put("SOL_DISTRICT",correctNull(rs.getString("CON_COMDIST")));
							hshValues.put("SOL_STATE",correctNull(rs.getString("CON_COMSTATE")));
							hshValues.put("SOL_PINCODE",correctNull(rs.getString("CON_COMZIP")));
							hshValues.put("SOL_COUNTRY",correctNull(rs.getString("CON_COMCOUNTRY")));
							hshValues.put("SOL_STATE",correctNull(rs.getString("CON_COMSTATE")));
						    strCountryCode =Helper.correctNull(rs.getString("CON_COMCOUNTRY"));
							strCitycode = Helper.correctNull(rs.getString("CON_COMCITY"));
						    strPermstatecode=Helper.correctNull(rs.getString("CON_COMSTATE"));
						    strDistcode=Helper.correctNull(rs.getString("CON_COMDIST"));
						}
						else 
						{
							hshValues.put("SOL_ADDRESS_ONE",correctNull(rs.getString("CON_PERMADDR1")));
							hshValues.put("SOL_ADDRESS_TWO",correctNull(rs.getString("CON_PERMADDR2")));
							hshValues.put("SOL_VILLAGE_TALUK_TOWN",correctNull(rs.getString("CON_PERMVILLAGE")));
							hshValues.put("SOL_CITY",correctNull(rs.getString("CON_PERMCITY")));					
							hshValues.put("SOL_DISTRICT",correctNull(rs.getString("CON_PERMDIST")));
							hshValues.put("SOL_STATE",correctNull(rs.getString("CON_PERMSTATE")));
							hshValues.put("SOL_PINCODE",correctNull(rs.getString("CON_PERMZIP")));
							hshValues.put("SOL_COUNTRY",correctNull(rs.getString("CON_PERMCOUNTRY")));
							hshValues.put("SOL_STATE",correctNull(rs.getString("CON_PERMSTATE")));
						    strCountryCode =Helper.correctNull(rs.getString("CON_PERMCOUNTRY"));
							strCitycode = Helper.correctNull(rs.getString("CON_PERMCITY"));
						    strPermstatecode=Helper.correctNull(rs.getString("CON_PERMSTATE"));
						    strDistcode=Helper.correctNull(rs.getString("CON_PERMDIST"));
						}
						hshValues.put("SOL_CBS_ID",correctNull(rs.getString("PERAPP_CBSID")));
				        hshValues.put("SOL_APPID",Helper.correctNull((String)rs.getString("PERAPP_ID")));
				        hshValues.put("SOL_NETWORTH",Helper.correctNull((String)rs.getString("PERAPP_NETWORTH")));
				        hshValues.put("SOL_OLDID",Helper.correctNull((String)rs.getString("PERAPP_OLDID")));
				     
					    hshValues.put("hidAction",strAction);
					    hshValues.put("strDataAvlFlag","Y");
					    
					 }	
			}
			
			if(!strCitycode.equals(""))
			{
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_citynamebycode^"+strCitycode);
			if(rs.next())
			{
				hshValues.put("txtperapp_city",correctNull(rs.getString("city_name")));
			}	
			}
			if(!strCountryCode.equals(""))
			{
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_countrynamebycode^"+strCountryCode);
			if(rs.next())
			{
				hshValues.put("txtperapp_country",correctNull(rs.getString("con_country")));
			}
			}
			if(!strPermstatecode.equals(""))
			{
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_statenamebycode^"+strPermstatecode);
			if(rs.next())
			{
				hshValues.put("txtperapp_permstate",correctNull(rs.getString("state_name")));
			}
			}
			if(!strDistcode.equals(""))
			{
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_distnamebycode^"+strDistcode);
			if(rs.next())
			{
				hshValues.put("txtperapp_district",correctNull(rs.getString("district_desc")));
			}
			}
			hshValues.put("strAppid",strAppid);
		
			if(!strAction.equalsIgnoreCase("new"))
			{
				hshValues.put("strDataAvlFlag","Y");
				char readFlag=correctNull((String)hshRequestValues.get("strGroupRights")).charAt(18);
				String btnenable=(""+readFlag).equals("r")?"N":(appstatus.equalsIgnoreCase("OP") && correctNull((String)hshValues.get("SOL_APPLNHOLDER")).equals(correctNull((String)hshRequestValues.get("strUserId"))))?"Y":"N";
				hshValues.put("btnenable",btnenable);
			}
			hshValues.put("procfee",correctNull((String)hshValues.get("procfee")));

			
			
			
			
			
		} 
		catch(Exception ce)
		{
			throw new EJBException("Error in getSolvencyData "+ce.toString());
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
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshValues; 
	}
	
	

public HashMap UpdateKpowerdetailsData(HashMap  hshValues)
{
	HashMap hshqueryval =new HashMap();
	HashMap hshquery = new HashMap();
	HashMap hshResult = new HashMap();
	ArrayList arrValues = new ArrayList();
	String  strAction="",Strappid="",strUserid="",strOrgcode="",strAvailDataFlg="N",strAppnum="",stroldid="";
	int strsno=0;
	
	try
	{
		  strAction=correctNull((String)hshValues.get("hidAction"));
		  Strappid=correctNull((String)hshValues.get("hid_appid"));
		  strUserid=correctNull((String)hshValues.get("strUserId"));
		  strOrgcode=correctNull((String)hshValues.get("strOrgCode"));
		  String OrgCode="",Strappno="",StrAppno="";
		  strAvailDataFlg = correctNull((String)hshValues.get("hidAvailFlg"));
	      StrAppno=correctNull((String)hshValues.get("hidAppno"));
	      strAppnum=correctNull((String)hshValues.get("txt_applno"));
	      stroldid=correctNull((String)hshValues.get("old_appid"));
	      
		   if(strAction.equalsIgnoreCase("new") && StrAppno.equalsIgnoreCase(""))
			{
			    hshqueryval = new HashMap();
				hshquery = new HashMap();		
				arrValues=new ArrayList();
			
				OrgCode=Helper.correctNull((String)hshValues.get("strSolid"));
				//int strlength = OrgCode.length()+2;
				int scodeLength=OrgCode.length();
				if(scodeLength==1){
					OrgCode="000"+OrgCode;
				}
				if(scodeLength==2){
					OrgCode="00"+OrgCode;
				}
				if(scodeLength==3){
					OrgCode="0"+OrgCode;
				}
				
				ResultSet rs = null;	
				rs=DBUtils.executeLAPSQuery("sel_maxid_addkbowerdetails^"+OrgCode);
				if(rs.next())
				{
					strsno=Integer.parseInt(rs.getString("ADDKBOW_APP_NO"));
					
					java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
					nf.setMinimumIntegerDigits(6);
					nf.setGroupingUsed(false);
					Strappno=nf.format(strsno);
					
					StrAppno=OrgCode+"K"+Strappno;
				}
				hshquery=new HashMap();
				arrValues=new ArrayList();
				hshquery.put("strQueryId","ins_addkbowerdetails");
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_nameborrower")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_limitsanc")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_primaryfinacno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_datesanction")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Duedate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_permonth")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_month")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_ratinterest")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_ratmaxmin")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_Interest")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_total")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_grossannincome")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_grossdate")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_Networth")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_netasondate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_SancAuth")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_address")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_addresstwo")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_village")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidperapp_city")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidperapp_permstate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidperapp_state")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_permzip")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidperapp_country")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_cbsid")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_appid")));
				arrValues.add(StrAppno);
				arrValues.add(strUserid);
				arrValues.add(strUserid);
				arrValues.add("Y");
				arrValues.add("KP");
				arrValues.add(strOrgcode);
				arrValues.add("OP");
				arrValues.add(stroldid);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_kpowno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_SancDept")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_SancBranch")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sanctiondate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_sancrefno")));
				hshquery.put("arrValues",arrValues);
				hshqueryval.put("1",hshquery);
				hshqueryval.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				
				if(strAppnum.equalsIgnoreCase(""))
			    {
				hshqueryval=new HashMap();
				arrValues=new ArrayList();
				hshquery.put("strQueryId","ins_appmail_kpower");
				arrValues.add(StrAppno);  
				arrValues.add(strUserid);
				arrValues.add(strUserid);
				arrValues.add("1");
				arrValues.add("1");
				arrValues.add("C");
				arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
				if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
					arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
				else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
					arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
				else
					arrValues.add("");
				arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
				if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
					arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
				else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
					arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
				else
					arrValues.add("");
				hshquery.put("arrValues",arrValues);
				hshqueryval.put("1",hshquery);
				hshqueryval.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			    }
			}
		   else if(strAction.equalsIgnoreCase("insert"))
		   {
			    hshqueryval = new HashMap();
				hshquery = new HashMap();		
				arrValues=new ArrayList();
				hshquery.put("strQueryId","upt_addkbowdetails");
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_limitsanc")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_primaryfinacno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_datesanction")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Duedate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_permonth")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_month")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_ratinterest")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_ratmaxmin")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_Interest")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_total")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_grossdate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_netasondate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_SancAuth")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_kpowno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_SancDept")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_SancBranch")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sanctiondate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_sancrefno")));
				arrValues.add(StrAppno);  
				hshquery.put("arrValues",arrValues);
				hshqueryval.put("1",hshquery);
				hshqueryval.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
		   }
		   
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshqueryval = new HashMap();
				hshquery = new HashMap();		
				arrValues=new ArrayList();
				hshquery.put("strQueryId","del_addkbowerdetails");
				arrValues.add(StrAppno);
				hshquery.put("arrValues",arrValues);
				hshqueryval.put("1",hshquery);
				hshqueryval.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				
				hshqueryval = new HashMap();
				hshquery = new HashMap();		
				arrValues=new ArrayList();
				hshquery.put("strQueryId","del_appmailbox_kpow");
				arrValues.add(StrAppno);
				hshquery.put("arrValues",arrValues);
				hshqueryval.put("1",hshquery);
				hshqueryval.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}		
		   hshValues.put("hidAppno", StrAppno);
		   hshValues = getKpowerdetailsData(hshValues);
	}
	catch(Exception e)
	{
		throw new EJBException("Error closing the connection "+e.getMessage());	
	}
	return hshValues;
}

public HashMap getKpowerdetailsData(HashMap hshRequestValues) 
{
	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	nf.setGroupingUsed(false);
	
	ResultSet rs = null;
	double networth=0.0f;
	double grossincome=0.0f;
	HashMap hshValues=new HashMap();
	HashMap hshQuery=null;
	HashMap hshQueryValues=null;
	ArrayList arrValues=null;
	String strQuery="",strQuery1="",strValue="",comapp_id="",strCitycode="",strCountryCode="",strAppid="";
	String strOrgCode="";
	String kpowercode="",strPermstatecode="",appstatus="";
	String kpowerapplno="",kpowerOrgCode="",strDistcode="";
	String strAppno=Helper.correctNull((String)hshRequestValues.get("txt_applno"));
	String strAction=Helper.correctNull((String)hshRequestValues.get("hidAction"));
	try
	{	
		strAppid=Helper.correctNull((String)hshRequestValues.get("appid"));	
		if(strAppid.equalsIgnoreCase(""))
		{
			strAppid=Helper.correctNull((String)hshRequestValues.get("hid_appid"));	
		}
		if(strAppid.equalsIgnoreCase(""))
		{
			strAppid=Helper.correctNull((String)hshRequestValues.get("hidDemoId"));	
		}
		
		if(strAppno.equalsIgnoreCase(""))
		{
			strAppno=Helper.correctNull((String)hshRequestValues.get("hidApplno"));	
		}
		if(strAppno.equalsIgnoreCase(""))
		{
			strAppno=Helper.correctNull((String)hshRequestValues.get("hidapplno"));	
		}
		if(strAppno.equalsIgnoreCase(""))
		{
			strAppno=Helper.correctNull((String)hshRequestValues.get("hidAppno"));	
		}
		
		if(!strAppno.equalsIgnoreCase("")) 
		{
			
			strQuery1 = SQLParser.getSqlQuery("sel_com_solvecncy_for_communication_details^"+strAppid);
			rs=DBUtils.executeQuery(strQuery1);
			
			if(rs.next()){
				networth=Double.parseDouble(Helper.correctDouble(rs.getString("PERAPP_NETWORTH")));
				
				if(Helper.correctNull(rs.getString("perapp_employment")).equalsIgnoreCase("1")||Helper.correctNull(rs.getString("perapp_employment")).equalsIgnoreCase("9"))
					grossincome=Double.parseDouble(Helper.correctDouble(rs.getString("perinc_takehome")));
				else
					grossincome=Double.parseDouble(Helper.correctDouble(rs.getString("PERINC_YEAR1_INCOME")));
			}
			
			strQuery = SQLParser.getSqlQuery("sel_addkbowerdetails^"+strAppid+"^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next()){
				if(Helper.correctNull(rs.getString("addkbow_status")).equalsIgnoreCase("OP")){
					
                  if(networth!=	Double.parseDouble(Helper.correctDouble(rs.getString("addkbow_Networth"))) || grossincome!=Double.parseDouble(Helper.correctDouble(rs.getString("addkbow_GrossAnnincome")))){
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues=new HashMap();
					
					hshQuery.put("strQueryId","updt_kpower");
					
					arrValues.add(String.valueOf(networth));
					arrValues.add(String.valueOf(grossincome));
					arrValues.add(strAppno);
					hshQueryValues.put("size","1");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					hshValues.put("addkbow_Networth",Helper.correctDouble(String.valueOf(networth)));
					hshValues.put("addkbow_GrossAnnincome",Helper.correctDouble(String.valueOf(grossincome)));
                  }
                  else{
                	  hshValues.put("addkbow_Networth",Helper.correctDouble(rs.getString("addkbow_Networth")));
  					  hshValues.put("addkbow_GrossAnnincome",Helper.correctDouble(rs.getString("addkbow_GrossAnnincome")));
                  }
				}
				
				else{
					hshValues.put("addkbow_Networth",Helper.correctDouble(rs.getString("addkbow_Networth")));
					  hshValues.put("addkbow_GrossAnnincome",Helper.correctDouble(rs.getString("addkbow_GrossAnnincome")));
				}
				hshValues.put("addkbow_BorrowerName",correctNull(rs.getString("addkbow_BorrowerName")));
				hshValues.put("addkbow_BorrowerAddress",correctNull(rs.getString("addkbow_BorrowerAddress")));
				hshValues.put("addkbow_LimitSanctioned",nf.format(rs.getDouble("addkbow_LimitSanctioned")));
				hshValues.put("addkbow_primaryFineacNo",correctNull(rs.getString("addkbow_primaryFineacNo")));
				hshValues.put("addkbow_DateSanctioned",correctNull(rs.getString("addkbow_DateSanctioned")));
				hshValues.put("addkbow_DueDate",correctNull(rs.getString("addkbow_DueDate")));
				hshValues.put("addkbow_Periodin",correctNull(rs.getString("addkbow_Periodin")));
				hshValues.put("addkbow_Periodmonth",correctNull(rs.getString("addkbow_Periodmonth")));
				hshValues.put("addkbow_RateofInterest",correctNull(rs.getString("addkbow_RateofInterest")));
				hshValues.put("addkbow_RateofIntaddmin",correctNull(rs.getString("addkbow_RateofIntaddmin")));
				hshValues.put("addkbow_RateofInt",nf.format(rs.getDouble("addkbow_RateofInt")));
				hshValues.put("addkbow_RateofInttotal",nf.format(rs.getDouble("addkbow_RateofInttotal")));
				
				hshValues.put("addkbow_grossAsonDate",correctNull(rs.getString("addkbow_grossAsonDate")));
			
				hshValues.put("addkbow_NetworthAsonDate",correctNull(rs.getString("addkbow_NetworthAsonDate")));
				hshValues.put("addkbow_Sanctioned",correctNull(rs.getString("addkbow_Sanctioned")));
				hshValues.put("addkbow_address_one",correctNull(rs.getString("addkbow_address_one")));
				hshValues.put("addkbow_address_two",correctNull(rs.getString("addkbow_address_two")));
				hshValues.put("addkbow_village",correctNull(rs.getString("addkbow_village")));
				hshValues.put("addkbow_city",correctNull(rs.getString("addkbow_city")));
				hshValues.put("addkbow_district",correctNull(rs.getString("addkbow_district")));
				hshValues.put("addkbow_state",correctNull(rs.getString("addkbow_state")));
				hshValues.put("addkbow_pincode",correctNull(rs.getString("addkbow_pincode")));
				hshValues.put("addkbow_country",correctNull(rs.getString("addkbow_country")));
				hshValues.put("addkbow_cbs_id",correctNull(rs.getString("addkbow_cbs_id")));
				hshValues.put("addkbow_app_id",correctNull(rs.getString("addkbow_app_id")));
				hshValues.put("addkbow_app_no",correctNull(rs.getString("addkbow_app_no")));
				hshValues.put("addkbow_status",correctNull(rs.getString("addkbow_status")));
				hshValues.put("addkbow_applnholder",correctNull(rs.getString("addkbow_applnholder")));
				appstatus=correctNull(rs.getString("addkbow_status"));
				hshValues.put("org_name",correctNull(rs.getString("org_name")));
				hshValues.put("addkbow_oldid",correctNull(rs.getString("addkbow_oldid")));
				hshValues.put("addkbow_kpowno",correctNull(rs.getString("addkbow_kpowno")));
				hshValues.put("ADDKBOW_SANCTIONING_DEPT",correctNull(rs.getString("ADDKBOW_SANCTIONING_DEPT")));
				hshValues.put("ADDKBOW_SANCTIONING_BRANCH",correctNull(rs.getString("ADDKBOW_SANCTIONING_BRANCH")));
				hshValues.put("Sanction_Date",correctNull(rs.getString("Sanction_Date")));
				hshValues.put("Sanc_Ref_No",correctNull(rs.getString("Sanc_Ref_No")));

				strCitycode = Helper.correctNull(rs.getString("addkbow_city"));
				strCountryCode =Helper.correctNull(rs.getString("addkbow_country"));
				strDistcode=Helper.correctNull(rs.getString("addkbow_district"));
				strPermstatecode=Helper.correctNull(rs.getString("addkbow_state"));
				hshValues.put("hidAction","");
				strAction="";
				
			}
		}
	   if(strAction.equalsIgnoreCase("new")) 
	   {
			hshValues.put("addkbow_BorrowerName",Helper.correctNull((String)hshRequestValues.get("customername")));
		    strQuery = SQLParser.getSqlQuery("sel_com_solvecncy_for_communication_details^"+strAppid);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				
				String NRIResidentStatus=correctNull(rs.getString("INDINFO_RESIDENT_STATUS"));
				hshValues.put("addkbow_BorrowerName",correctNull(rs.getString("PERAPP_FNAME")));
				if(NRIResidentStatus.equals("N"))
				{
					hshValues.put("addkbow_address_one",correctNull(rs.getString("CON_COMADDR1")));
					hshValues.put("addkbow_address_two",correctNull(rs.getString("CON_COMADDR2")));
					hshValues.put("addkbow_village",correctNull(rs.getString("CON_COMVILLAGE")));
					hshValues.put("addkbow_city",correctNull(rs.getString("CON_COMCITY")));					
					hshValues.put("addkbow_district",correctNull(rs.getString("CON_COMDIST")));
					hshValues.put("addkbow_state",correctNull(rs.getString("CON_COMSTATE")));
					hshValues.put("addkbow_pincode",correctNull(rs.getString("CON_COMZIP")));
					hshValues.put("addkbow_country",correctNull(rs.getString("CON_COMCOUNTRY")));
				    strCountryCode =Helper.correctNull(rs.getString("CON_COMCOUNTRY"));
					strCitycode = Helper.correctNull(rs.getString("CON_COMCITY"));
				    strPermstatecode=Helper.correctNull(rs.getString("CON_COMSTATE"));
				    strDistcode=Helper.correctNull(rs.getString("CON_COMDIST"));
				}
				else 
				{
					hshValues.put("addkbow_address_one",correctNull(rs.getString("CON_PERMADDR1")));
					hshValues.put("addkbow_address_two",correctNull(rs.getString("CON_PERMADDR2")));
					hshValues.put("addkbow_village",correctNull(rs.getString("CON_PERMVILLAGE")));
					hshValues.put("addkbow_city",correctNull(rs.getString("CON_PERMCITY")));					
					hshValues.put("addkbow_district",correctNull(rs.getString("CON_PERMDIST")));
					hshValues.put("addkbow_state",correctNull(rs.getString("CON_PERMSTATE")));
					hshValues.put("addkbow_pincode",correctNull(rs.getString("CON_PERMZIP")));
					hshValues.put("addkbow_country",correctNull(rs.getString("CON_PERMCOUNTRY")));
				    strCountryCode =Helper.correctNull(rs.getString("CON_PERMCOUNTRY"));
					strCitycode = Helper.correctNull(rs.getString("CON_PERMCITY"));
				    strPermstatecode=Helper.correctNull(rs.getString("CON_PERMSTATE"));
				    strDistcode=Helper.correctNull(rs.getString("CON_PERMDIST"));
				}
				
			    hshValues.put("addkbow_cbs_id",correctNull(rs.getString("perapp_cbsid")));
			    hshValues.put("addkbow_app_id",Helper.correctNull((String)rs.getString("perapp_id")));
			    hshValues.put("addkbow_Networth",Helper.correctNull((String)rs.getString("perapp_networth")));
			    hshValues.put("addkbow_oldid",Helper.correctNull((String)rs.getString("perapp_oldid")));
				hshValues.put("hidAction",strAction);
				 hshValues.put("addkbow_NetworthAsonDate",Helper.correctNull((String)rs.getString("networthason")));
				 //hshValues.put("addkbow_grossAsonDate",Helper.correctNull((String)rs.getString("")));
				 
				 
				 if(Helper.correctNull(rs.getString("perapp_employment")).equalsIgnoreCase("1")||Helper.correctNull(rs.getString("perapp_employment")).equalsIgnoreCase("9"))
					  hshValues.put("addkbow_GrossAnnincome",Helper.correctNull((String)rs.getString("perinc_takehome")));
					else
						  hshValues.put("addkbow_GrossAnnincome",Helper.correctNull((String)rs.getString("PERINC_YEAR1_INCOME")));
			}	
	    }
		if(!strCitycode.equals(""))
		{
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_citynamebycode^"+strCitycode);
			if(rs.next())
			{
				hshValues.put("txtperapp_city",correctNull(rs.getString("city_name")));
			}	
		}
		if(!strCountryCode.equals(""))
		{
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_countrynamebycode^"+strCountryCode);
			if(rs.next())
			{
				hshValues.put("txtperapp_country",correctNull(rs.getString("con_country")));
			}
		}
		if(!strPermstatecode.equals(""))
		{
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_statenamebycode^"+strPermstatecode);
			if(rs.next())
			{
				hshValues.put("txtperapp_permstate",correctNull(rs.getString("state_name")));
			}
		}
		if(!strDistcode.equals(""))
		{
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_distnamebycode^"+strDistcode);
			if(rs.next())
			{
				hshValues.put("txtperapp_district",correctNull(rs.getString("district_desc")));
			}
		}
		    hshValues.put("strAppid",strAppid);
			
       if(!strAction.equalsIgnoreCase("new"))
		{
			char readFlag=correctNull((String)hshRequestValues.get("strGroupRights")).charAt(18);
			String btnenable=(""+readFlag).equals("r")?"N":(appstatus.equalsIgnoreCase("OP") && correctNull((String)hshValues.get("addkbow_applnholder")).equals(correctNull((String)hshRequestValues.get("strUserId"))))?"Y":"N";
			hshValues.put("btnenable",btnenable);
		}
	} 
	catch(Exception ce)
	{
		throw new EJBException("Error in getAddk_powerdealisdata   "+ce.toString());
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
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}

	return hshValues; 
	
}

  public HashMap getsolworkflow(HashMap hshRequestValues) 
  {
	String strQuery = null;
	ResultSet rs = null,rs1=null,rs4=null,rs2=null;
	HashMap hshRecord = new HashMap();
	HashMap hshValues = new HashMap();
	ArrayList arrWorkid = new ArrayList();
	ArrayList arrMaxclass = new ArrayList();
	ArrayList arrDuration = new ArrayList();
	ArrayList arrWorkflowname = new ArrayList();
	ArrayList arrflowpoint = new ArrayList();
	String strPrdCode ="1";
	String strWorkflowType ="p";
	
	 String strgrpid="",strPowerAmt="";
	String strapplno=correctNull((String)hshRequestValues.get("strappno"));
	String strAppstatus=correctNull((String)hshRequestValues.get("strappstatus"));
	String strAppid=correctNull((String)hshRequestValues.get("hidDemoId"));
	
	String strUserId=correctNull((String)hshRequestValues.get("strUserId"));
	String strAppholder=correctNull((String)hshRequestValues.get("hidapplholder"));
	String strusrid="";
	try
	{	
		strusrid=correctNull((String)hshRequestValues.get("strUserId"));
		strQuery = SQLParser.getSqlQuery("sel_com_solvency^"+strAppid+"^"+strapplno);
		rs = DBUtils.executeQuery(strQuery);	
                if(rs.next())
               {
                	hshRecord.put("sol_status",correctNull(rs.getString("sol_status")));
                	strAppstatus=correctNull(rs.getString("sol_status"));
               }
		if(!strPrdCode.equals(""))
		{
			if(strAppstatus.equalsIgnoreCase("OP"))
			{
			strQuery = SQLParser.getSqlQuery("prdsolkpowsel^" + strPrdCode + "^" +strWorkflowType);
			rs = DBUtils.executeQuery(strQuery);	

			while (rs.next()) 
			{
				
				arrWorkid.add(rs.getString("prd_workid"));
				arrMaxclass.add(rs.getString("prd_minclass"));
				arrDuration.add(rs.getString("prd_duration"));
				arrflowpoint.add(rs.getString("prd_flowpoint"));
				arrWorkflowname.add(rs.getString("wrk_flowname"));
			}
		    }
	   }

		  if(!strAppstatus.equalsIgnoreCase("OP"))
		{
		  	if((strAppstatus.equalsIgnoreCase("PA")) || (strAppstatus.equalsIgnoreCase("CA"))) 
			{
				strQuery=SQLParser.getSqlQuery("prdsolkpowsel1^<17^>8");
				rs = DBUtils.executeQuery(strQuery);	
				while (rs.next()) 
				{
					arrMaxclass.add(rs.getString("prd_minclass"));
					arrflowpoint.add(rs.getString("prd_flowpoint"));
					arrWorkflowname.add(rs.getString("wrk_flowname"));
				}
			}
		  	if((strAppstatus.equalsIgnoreCase("PR")) || (strAppstatus.equalsIgnoreCase("CR"))) 
			{
				strQuery=SQLParser.getSqlQuery("prdsolkpowsel2^<25^>16");
				rs = DBUtils.executeQuery(strQuery);	
				while (rs.next()) 
				{
					arrMaxclass.add(rs.getString("prd_minclass"));
					arrflowpoint.add(rs.getString("prd_flowpoint"));
					arrWorkflowname.add(rs.getString("wrk_flowname"));
				}
			}
		}
		        hshRecord.put("strPrdCode", strPrdCode);
		        hshRecord.put("prd_workid", arrWorkid);
				hshRecord.put("prd_minclass", arrMaxclass);
				hshRecord.put("prd_duration", arrDuration);
				hshRecord.put("arrflowpoint", arrflowpoint);
				hshRecord.put("wrk_flowname", arrWorkflowname);
			
				if(rs!=null)
				rs.close();
				
				strQuery = SQLParser.getSqlQuery("sel_currentsolvencyflowpoint^"+strapplno +"^"+strapplno);
				rs = DBUtils.executeQuery(strQuery);	
		                if(rs.next())
		               {
		                	hshRecord.put("as_toflwpt",correctNull(rs.getString("as_toflwpt")));
		                	hshRecord.put("as_date",correctNull(rs.getString("as_date")));
		                	hshRecord.put("dueon_date",correctNull(rs.getString("dueon_date")));
		               }

						if(rs!=null)
						rs.close();
						
					
				strQuery = SQLParser.getSqlQuery("sel_solvency_comments^"+strapplno);
				rs = DBUtils.executeQuery(strQuery);	
		                if(rs.next())
		               {
		                hshRecord.put("sol_comments",correctNull(rs.getString("sol_comments")));
		               }
		                
		                hshRecord.put("strUserId",strUserId);
		                hshRecord.put("strAppholder",strAppholder);
		                
		                int intMinimumClass=0;
			                
			                strQuery = SQLParser.getSqlQuery("prdsolkpowactivitysel^1");
							rs = DBUtils.executeQuery(strQuery);	

							 if(rs.next()) 
							{
							
								 intMinimumClass=Integer.parseInt(Helper.correctInt(rs.getString("prd_minclassapproval")));
							
							}
		                
		                if(rs!=null)
		    				rs.close();		
		    			
		    			rs=DBUtils.executeLAPSQuery("workflowusersanlimit^"+strusrid);
		    			if(rs.next())
		    			{
		    				if(Integer.parseInt(Helper.correctInt(rs.getString("usr_class")))>=intMinimumClass)
			    				hshRecord.put("strSancAuth","Y");
		    				hshRecord.put("usrfunction",Helper.correctNull(rs.getString("usr_function")));
		    			}
		    			 rs1=DBUtils.executeLAPSQuery("selUserId^"+ strUserId);			 
		    				if(rs1.next()) 
		    					{
		    					 strgrpid=correctNull(rs1.getString("grp_id"));
		    					}
		    				if(rs1!=null)
		    				       rs1.close();
		    			 if(rs!=null){
		    				 rs.close();}
		    			 rs=DBUtils.executeLAPSQuery("sel_bankerprdsanlmt^"+"1"+"^"+ strgrpid);	
		    				if(rs.next()) 
		    				{
		    					strPowerAmt=correctNull(rs.getString("sanction_limit"));
		    					log.info("<<<<<<<<<<===========strPowerAmt===================>>>>>>>>>>>>>>"+strPowerAmt);
		    				}
		    				double dblsumgoldloan=0.00,dbldepositloan=0.00,dbltotalrecamt=0.00;

		    				strQuery=SQLParser.getSqlQuery("sel_sol_loanamt^"+strapplno);
		    		 		rs4=DBUtils.executeQuery(strQuery);
		    				if(rs4.next())
		    				{
		    					dbltotalrecamt=Double.parseDouble(Helper.correctDouble(rs4.getString("SOL_AMOUNT")));
		    				}
		    				hshRecord.put("dbltotalrecamt", String.valueOf(dbltotalrecamt));
		    				hshRecord.put("PowerAmt",strPowerAmt);
	 } 
	catch(Exception ce)
	{
		throw new EJBException("Error in getsolworkflow  "+ce.toString());
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
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	return hshRecord; 
	
}
  
  public HashMap getbankerworkflow(HashMap hshRequestValues) 
  {
	  	String strQuery = null;
	  	ResultSet rs = null,rs1=null,rs4=null;
	  	HashMap hshRecord = new HashMap();
	  	HashMap hshValues = new HashMap();
	  	ArrayList arrWorkid = new ArrayList();
	  	ArrayList arrMaxclass = new ArrayList();
	  	ArrayList arrDuration = new ArrayList();
	  	ArrayList arrWorkflowname = new ArrayList();
	  	ArrayList arrflowpoint = new ArrayList();
	  	String strPrdCode ="6";
	  	String strWorkflowType ="p";
	  	String strUserId="";
	  	String BANKER_SANCTION_FOR="";
	  	String strExp="$";
	  	String strapplno=correctNull((String)hshRequestValues.get("strappno"));
	  	if(strapplno.equalsIgnoreCase(""))
	  	{
	  		strapplno=correctNull((String)hshRequestValues.get("hidapplno"));	
	  	}
	  	
	  	String strAppstatus=correctNull((String)hshRequestValues.get("strappstatus"));
	  	String strAppid=correctNull((String)hshRequestValues.get("hidDemoId"));
	  	 strUserId=correctNull((String)hshRequestValues.get("strUserId"));
	  	String strAppholder=correctNull((String)hshRequestValues.get("hidapplholder"));
	  	String strusrid="",strgrpid="",strPowerAmt="";
	  	int noofdays1=0;
	  	try
	  	{	
	  		strusrid=correctNull((String)hshRequestValues.get("strUserId"));
	  		strQuery = SQLParser.getSqlQuery("sel_com_banker^"+strapplno);
	  		rs = DBUtils.executeQuery(strQuery);	
	                  if(rs.next())
	                 {
	                  	hshRecord.put("BANKER_STATUS",correctNull(rs.getString("BANKER_STATUS")));
	                  	strAppstatus=correctNull(rs.getString("BANKER_STATUS"));
	                  	
	                  	BANKER_SANCTION_FOR=correctNull(rs.getString("BANKER_SANCTION_FOR"));
	                  	
	                  	if(BANKER_SANCTION_FOR.equalsIgnoreCase("BC"))
	                  	{
	                  		strPrdCode ="6";
	                  	}
	                  	if(BANKER_SANCTION_FOR.equalsIgnoreCase("LC"))
	                  	{
	                  		strPrdCode ="7";
	                  	}
	                  	
	                  	hshRecord.put("ACTNETWORTH",Helper.correctDouble(correctNull(rs.getString("bank_active_limit"))));
	                  	hshRecord.put("BANKER_NETWORTH",Helper.correctDouble(correctNull(rs.getString("BANKER_NETWORTH"))));
	                  	hshRecord.put("BANKER_AMT",Helper.correctDouble(rs.getString("BANKER_AMOUNT")));
	                  	hshRecord.put("BANK_VALIDITY_EXT_COUNT",Helper.correctNull(rs.getString("BANK_VALIDITY_EXT_COUNT")));
	                  	hshRecord.put("BANK_SAN_USERID",Helper.correctNull(rs.getString("BANK_SAN_USERID")));
	                  /*	if(Helper.correctNull(rs.getString("BANK_SAN_USERID")).equalsIgnoreCase(""))
	                  	{
	                  		hshRecord.put("BANK_SAN_USERID",Helper.correctNull(rs.getString("banker_applnholder"))); 
	                  	}*/
	                  	
	                  	hshRecord.put("banker_certi_valityextdate",Helper.correctNull(rs.getString("banker_certi_valityextdate")));
	                  	hshRecord.put("VAL_EXTENSION_REASON",Helper.correctNull(rs.getString("VAL_EXTENSION_REASON")));
	                	hshRecord.put("BANKER_VALEXT_DATEON",Helper.correctNull(rs.getString("BANKER_VALEXT_DATEON")));
	                  	
	                  	hshRecord.put("BANK_VALID_DAYS",Helper.correctNull(rs.getString("BANK_VALID_DAYS")));
	                  	
	                  	hshRecord.put("BANKER_ORGCODE",Helper.correctNull(rs.getString("BANKER_ORGCODE")));
	                  	
	                  	strAppholder=Helper.correctNull(rs.getString("banker_applnholder"));
	                  	
	                 }
	                  
	                  if(FwHelper.correctNull((String)hshRecord.get("BANK_SAN_USERID")).equalsIgnoreCase(""))
	                  {
	                	    
	                	  strQuery = SQLParser.getSqlQuery("sel_sanuser_details^" +strapplno);
	            			rs = DBUtils.executeQuery(strQuery);	
	            			while (rs.next()) 
	            			{
	            				hshRecord.put("BANK_SAN_USERID",Helper.correctNull(rs.getString("as_tousrid")));	
	            			}
	                  }
	                  
	                  
	                  
	                  if(!strPrdCode.equals(""))
	          		{
	          			if(strAppstatus.equalsIgnoreCase("OP"))
	          			{
	          			strQuery = SQLParser.getSqlQuery("prdsolkpowsel^" + strPrdCode + "^" +strWorkflowType);
	          			rs = DBUtils.executeQuery(strQuery);	

	          			while (rs.next()) 
	          			{
	          				
	          				arrWorkid.add(rs.getString("prd_workid"));
	          				arrMaxclass.add(rs.getString("prd_minclass"));
	          				arrDuration.add(rs.getString("prd_duration"));
	          				arrflowpoint.add(rs.getString("prd_flowpoint"));
	          				arrWorkflowname.add(rs.getString("wrk_flowname"));
	          			}
	          		    }
	          	   }

	          		  if(!strAppstatus.equalsIgnoreCase("OP"))
	          		{
	          		  	if((strAppstatus.equalsIgnoreCase("PA")) || (strAppstatus.equalsIgnoreCase("CA"))) 
	          			{
	          				strQuery=SQLParser.getSqlQuery("prdsolkpowsel1^<17^>8");
	          				rs = DBUtils.executeQuery(strQuery);	
	          				while (rs.next()) 
	          				{
	          					arrMaxclass.add(rs.getString("prd_minclass"));
	          					arrflowpoint.add(rs.getString("prd_flowpoint"));
	          					arrWorkflowname.add(rs.getString("wrk_flowname"));
	          				}
	          			}
	          		  	if((strAppstatus.equalsIgnoreCase("PR")) || (strAppstatus.equalsIgnoreCase("CR"))) 
	          			{
	          				strQuery=SQLParser.getSqlQuery("prdsolkpowsel2^<25^>16");
	          				rs = DBUtils.executeQuery(strQuery);	
	          				while (rs.next()) 
	          				{
	          					arrMaxclass.add(rs.getString("prd_minclass"));
	          					arrflowpoint.add(rs.getString("prd_flowpoint"));
	          					arrWorkflowname.add(rs.getString("wrk_flowname"));
	          				}
	          			}
	          		}
	          		        hshRecord.put("strPrdCode", strPrdCode);
	          		        hshRecord.put("prd_workid", arrWorkid);
	          				hshRecord.put("prd_minclass", arrMaxclass);
	          				hshRecord.put("prd_duration", arrDuration);
	          				hshRecord.put("arrflowpoint", arrflowpoint);
	          				hshRecord.put("wrk_flowname", arrWorkflowname);
	          			
	          				if(rs!=null)
	          				rs.close();
	          				
	  				
	  				strQuery = SQLParser.getSqlQuery("sel_currentbankerflowpoint^"+strapplno +"^"+strapplno);
	  				rs = DBUtils.executeQuery(strQuery);	
	  		                if(rs.next())
	  		               {
	  		                	hshRecord.put("as_toflwpt",correctNull(rs.getString("as_toflwpt")));
	  		                	hshRecord.put("as_date",correctNull(rs.getString("as_date")));
	  		                	hshRecord.put("dueon_date",correctNull(rs.getString("dueon_date")));
	  		               }

	  						if(rs!=null)
	  						rs.close();
	  						
	  						rs=DBUtils.executeLAPSQuery("selstatdatabyidexpired");
	  						if(rs.next())
	  						{
	  							hshRecord.put("expdatelimit",correctNull(rs.getString("stat_data_desc1")));
	  								//bflag=true;
	  							
	  							
	  						}
	  						if(rs!=null)
	  						{
	  							rs.close();
	  						}
	  						
	  						
	  						
	  						
	  						
	  						rs=DBUtils.executeLAPSQuery("selstatdatabyidexpiredvalidityextension");
	  						if(rs.next())
	  						{
	  							hshRecord.put("validityExtensionlimit",correctNull(rs.getString("stat_data_desc1")));
	  								//bflag=true;
	  							
	  							
	  						}
	  						if(rs!=null)
	  						{
	  							rs.close();
	  						}
	  						
	  						 String BANKER_DATE="";
	  				strQuery = SQLParser.getSqlQuery("sel_banker_comments^"+strapplno);
	  				rs = DBUtils.executeQuery(strQuery);	
	  		                if(rs.next())
	  		               {
	  		                hshRecord.put("BANKER_COMMENTS",correctNull(rs.getString("BANKER_COMMENTS")));
	  		                 BANKER_DATE= correctNull(rs.getString("BANKER_DATE"));
	  		               hshRecord.put("BANK_VALIDITY_EXT_COUNT",correctNull(rs.getString("BANK_VALIDITY_EXT_COUNT")));
	  		             hshRecord.put("BANKER_APPROVE_DATE",correctNull(rs.getString("BANKER_APPROVE_DATE")));
	  		           hshRecord.put("BANKER_CLOSE_DATE",correctNull(rs.getString("BANKER_CLOSE_DATE")));
	  		         hshRecord.put("BANKER_STATUS",correctNull(rs.getString("BANKER_STATUS")));
	  		       hshRecord.put("BANK_EXPIRY_DATE",correctNull(rs.getString("BANK_EXPIRY_DATE")));
	  		               }		                
	  		              //String noofdays2=FwHelper.correctNull((String)hshValues.get("BANK_EXPIRY_DATE"));
	  					 Date dateWithValDays2=new SimpleDateFormat("dd/MM/yyyy").parse(BANKER_DATE);  
	  					 Calendar cal221 = Calendar.getInstance();
	  					 cal221.setTime(dateWithValDays2);
	  					 
	  					
	  						//cal.add(Calendar.DATE, noofdays2); 
	  						//Date dateWithValDays2 = cal.getTime();
	  						
	  						
	  						System.out.println("dateWithValDays2===="+dateWithValDays2);
	  						
	  					int noofdays=Integer.parseInt(FwHelper.correctNull((String)hshRecord.get("expdatelimit")));
	  					//cal.add(Calendar.DATE, noofdays); 
	  					//Date dateWithValDays = cal.getTime();
	  					
	 		              DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
//	  		            Calendar c = Calendar.getInstance();
	  					cal221.add(Calendar.DATE, noofdays);
	  		            System.out.println(dateFormat.format(cal221.getTime()));
	  		            
	  		            
	  		          hshRecord.put("dueon_date",FwHelper.correctNull((String)hshRecord.get("BANK_EXPIRY_DATE")));// dateFormat.format(cal221.getTime()));
	  		           		          
	  		          if(!FwHelper.correctNull((String)hshRecord.get("BANKER_APPROVE_DATE")).equalsIgnoreCase(""))
	  		          {
	  		        String stringDate=FwHelper.correctNull((String)hshRecord.get("BANKER_APPROVE_DATE"));  
					Date date1=new SimpleDateFormat("dd/MM/yyyy").parse(stringDate);  
					Calendar cal = Calendar.getInstance();
					cal.setTime(date1);
					    
					// manipulate date
					
					String todaydate=Helper.getCurrentDateTime();
					Date date2=new SimpleDateFormat("dd/MM/yyyy").parse(todaydate);  
					Calendar cal2 = Calendar.getInstance();
					cal2.setTime(date2);
					
					
					
						
					 if((date2.compareTo(date1) == 0))
						{
						 hshRecord.put("BANKER_APPROVE_DATE_FLAG","Y");
						}
					 
					 
						}
	  		        Date dateWithCloseDays2= new Date();
	  		        
	  		       /* if(!FwHelper.correctNull((String)hshRecord.get("BANKER_CLOSE_DATE")).equalsIgnoreCase(""))
						 {
							 dateWithCloseDays2=new SimpleDateFormat("dd/MM/yyyy").parse(FwHelper.correctNull((String)hshRecord.get("BANKER_CLOSE_DATE")));  
		  					 Calendar calclose = Calendar.getInstance();
		  					calclose.setTime(dateWithCloseDays2); 
						 }
	  		        
	  		      String todaydate=Helper.getCurrentDateTime();
					Date date2=new SimpleDateFormat("dd/MM/yyyy").parse(todaydate);  
					Calendar cal2 = Calendar.getInstance();
					cal2.setTime(date2);
					
					 if(FwHelper.correctNull((String)hshRecord.get("BANKER_STATUS")).equalsIgnoreCase("CA") && (date2.compareTo(dateWithCloseDays2) == 0))
						{
						 hshRecord.put("BANKER_APPROVE_DATE_FLAG","Y");
						}*/
	  		     
	  		          
	  		            
	  		                hshRecord.put("strUserId",strUserId);
	  		                hshRecord.put("strAppholder",strAppholder);
	  		                
	  		                int intMinimumClass=0;
	  			                
	  			                strQuery = SQLParser.getSqlQuery("prdsolkpowactivitysel^"+strPrdCode);
	  							rs = DBUtils.executeQuery(strQuery);	

	  							 if(rs.next()) 
	  							{
	  							
	  								 intMinimumClass=Integer.parseInt(Helper.correctInt(rs.getString("prd_minclassapproval")));
	  							
	  							}
	  		                
	  		                if(rs!=null)
	  		    				rs.close();		
	  		    			
	  		    			rs=DBUtils.executeLAPSQuery("workflowusersanlimit^"+strusrid);
	  		    			if(rs.next())
	  		    			{
	  		    				if(Integer.parseInt(Helper.correctInt(rs.getString("usr_class")))>=intMinimumClass)
	  			    				hshRecord.put("strSancAuth","Y");
	  		    				hshRecord.put("usrfunction",Helper.correctNull(rs.getString("usr_function")));
	  		    				hshRecord.put("org_level",Helper.correctNull(rs.getString("org_level")));
	  		    			}
	  		    			 rs1=DBUtils.executeLAPSQuery("selUserId^"+ strUserId);			 
	  		    				if(rs1.next()) 
	  		    					{
	  		    					 strgrpid=correctNull(rs1.getString("grp_id"));
	  		    					}
	  		    				if(rs1!=null)
	  		    				       rs1.close();
	  		    			 if(rs!=null){
	  		    				 rs.close();}
	  		    			 rs=DBUtils.executeLAPSQuery("sel_bankerprdsanlmt^"+ strPrdCode+"^"+ strgrpid);	
	  		    				if(rs.next()) 
	  		    				{
	  		    					strPowerAmt=correctNull(rs.getString("sanction_limit"));
	  		    					log.info("<<<<<<<<<<===========strPowerAmt===================>>>>>>>>>>>>>>"+strPowerAmt);
	  		    				}
	  		    				double dblsumgoldloan=0.00,dbldepositloan=0.00,dbltotalrecamt=0.00;

	  		    				strQuery=SQLParser.getSqlQuery("sel_bankers_loanamt^"+strapplno);
	  		    		 		rs4=DBUtils.executeQuery(strQuery);
	  		    				if(rs4.next())
	  		    				{
	  		    					dbltotalrecamt=Double.parseDouble(Helper.correctDouble(rs4.getString("BANKER_AMOUNT")));
	  		    				}
	  		    				hshRecord.put("dbltotalrecamt", String.valueOf(dbltotalrecamt));
	  		    				hshRecord.put("PowerAmt",strPowerAmt);
	  		    				
	  		    				
	  		    				 int strsno=0;
	  		    					rs=DBUtils.executeLAPSQuery("maxsel_bankcerhisvalmaxx^"+strapplno);
	  		    					if(rs.next())
	  		    					{
	  		    						strsno=Integer.parseInt(rs.getString("com_bank_sno"));
	  		    					}
	  		    					
	  		    					 if(rs!=null){
	  		  		    				 rs.close();}
	  		    				
	  		    				
	  		    				rs=DBUtils.executeLAPSQuery("sel_all_bankdetailscount^"+strapplno+"^"+strsno);
	  		    				if(rs.next())
	  		    				{
	  		    					hshRecord.put("currentStatus",correctNull(rs.getString("com_bank_sanstatus")));
	  		    					hshRecord.put("com_bank_expdate",correctNull(rs.getString("com_bank_expdate")));
	  		    					
	  		    				}
	  		    				
	  		    				 if(rs!=null){
	  	  		    				 rs.close();}
	  		    				 
	  		    				boolean vflag=false;
	  		    				Date dateWithvalidityext = new Date();
	  		    				 if(strAppstatus.equalsIgnoreCase("PA") && FwHelper.correctNull((String)hshRecord.get("currentStatus")).equalsIgnoreCase("EXPIRED"))
	   		             		{
	  		    				
	  		    					 if(FwHelper.correctNull((String)hshRecord.get("BANK_VALIDITY_EXT_COUNT")).equalsIgnoreCase(""))
	  		    					 {
	  		    					 dateWithvalidityext=new SimpleDateFormat("dd/MM/yyyy").parse(FwHelper.correctNull((String)hshRecord.get("BANK_EXPIRY_DATE")));  
	  		    					
	  		    					 vflag=true;
	  		    					 }
	  		    					
	  		    					 else if(!FwHelper.correctNull((String)hshRecord.get("BANK_VALIDITY_EXT_COUNT")).equalsIgnoreCase(""))
	  		    					 {
	  		    						 
	  		    						dateWithvalidityext=new SimpleDateFormat("dd/MM/yyyy").parse(FwHelper.correctNull((String)hshRecord.get("banker_certi_valityextdate")));    	  		    				   		    	  		    		
	  		    						Calendar calval = Calendar.getInstance();
	  	  		    					calval.setTime(dateWithvalidityext); 
	  	  			  					
	  	  		    					 noofdays1=Integer.parseInt(FwHelper.correctNull((String)hshRecord.get("expdatelimit")));
	  	  		    					//cal.add(Calendar.DATE, noofdays); 
	  	  		    					//Date dateWithValDays = cal.getTime();
	  	  		    					
	  	  		   		              DateFormat dateFormat1 = new SimpleDateFormat("dd/MM/yyyy");
//	  	  		    		            Calendar c = Calendar.getInstance();
	  	  		   		                calval.add(Calendar.DATE, noofdays1);
	  	  		   		         Date dateWithValDays = calval.getTime();
	  	  		    		            System.out.println(dateFormat1.format(calval.getTime()));
	  	  		    		            
	  	  		    		            
	  	  		    		        String todaydate=Helper.getCurrentDateTime();
	  	  						Date date2=new SimpleDateFormat("dd/MM/yyyy").parse(todaydate);  
	  	  						Calendar cal2 = Calendar.getInstance();
	  	  						cal2.setTime(date2);
	  	  						
	  	  					/*if((date2.compareTo(dateWithValDays) > 0))
	  						{
	  	  		    		            
	  		    					//strExp=strExp+"Proposal("+Helper.correctNull(rs.getString("BUR_APPNO"))+") created on  "+Helper.correctNull(rs.getString("created_date"))+", More than one proposal cannot create upto 90 Days ";
	  	  					strExp=strExp+"Proposal validity over on "+dateWithValDays;
	  	  						hshRecord.put("strExp",strExp);
	  		    					//throw new Exception(strExp);
	  		  				
	  		    					 }*/
	  		    					 }
	  		    					 else
	  		    					 {
	  		    						dateWithvalidityext=new SimpleDateFormat("dd/MM/yyyy").parse(FwHelper.correctNull((String)hshRecord.get("banker_certi_valityextdate")));    	  		    				 
	  		    					 }
	  		    					Calendar calval = Calendar.getInstance();
	  		    					calval.setTime(dateWithvalidityext); 
	  		    					//int noofdays1=0;
	  		    					
	  		    					 if(vflag)
	  		    					 /*{	 
	  		    							 if(FwHelper.correctNull((String)hshRecord.get("BANK_VALID_DAYS")).equalsIgnoreCase(""))
	  		    					{
	  		    						 noofdays1=30;
	  		    					}
	  		    							 else if((!FwHelper.correctNull((String)hshRecord.get("BANK_VALID_DAYS")).equalsIgnoreCase("")))
	  		    					{
	  		    						
	  		    						 noofdays1=Integer.parseInt(FwHelper.correctNull((String)hshRecord.get("BANK_VALID_DAYS")));
	  		    					}
	  		    					 }
	  		    					else*/
	  		    					{
	  		    					 noofdays1=Integer.parseInt(FwHelper.correctNull((String)hshRecord.get("expdatelimit")));
	  		    					}
	  		    					//cal.add(Calendar.DATE, noofdays); 
	  		    					//Date dateWithValDays = cal.getTime();
	  		    					
	  		   		              DateFormat dateFormat1 = new SimpleDateFormat("dd/MM/yyyy");
//	  		    		            Calendar c = Calendar.getInstance();
	  		   		                calval.add(Calendar.DATE, noofdays1);
	  		    		            System.out.println(dateFormat1.format(calval.getTime()));
	  		    		            
	  		    		          hshRecord.put("com_bank_validityExtensionmaxdate",String.valueOf(dateFormat1.format(calval.getTime())));		    		            
	   		             		}
	  		    				
	  		    				rs=DBUtils.executeLAPSQuery("workflowusersanlimit^"+strUserId);
	  		    				if(rs.next())
	  		    				{
	  		    					hshRecord.put("usrclass",rs.getString("usr_class"));
	  		    					hshRecord.put("usrfunction",Helper.correctNull(rs.getString("usr_function")));
	  		    				}
	  		    				
	  		    				
	  		    				rs=DBUtils.executeLAPSQuery("selstatdatabyidnetworth");
	  		    				while(rs.next())
	  		    				{
	  		    					hshRecord.put("networthperc",String.valueOf(Integer.valueOf(correctNull(rs.getString("stat_data_desc")))));
	  		    						//bflag=true;
	  		    					
	  		    					
	  		    				}
	  		    				if(rs!=null)
	  		    				{
	  		    					rs.close();
	  		    				}	
	  		    				boolean valiflag=false;
	  		    				  			String usrclass="",ORG_CODE="",orgcode="";			
	  		    				rs=DBUtils.executeLAPSQuery("sel_bankercertificate_org^"+strAppholder);
	  		    				if(rs.next())
	  		    				{
	  		    					//hshRecord.put("usrclass",rs.getString("usr_class"));
	  		    					//hshRecord.put("usrfunction",Helper.correctNull(rs.getString("usr_function")));
	  		    					
	  		    					
	  		    					ORG_CODE=Helper.correctNull(rs.getString("ORG_CODE"));
	  		    					//ORG_CODE=ORG_CODE.substring(0, 6);
	  		    					rs1=DBUtils.executeLAPSQuery("sel_bankercertificate_org1^"+strUserId);
	  	  		    				if(rs1.next())
	  	  		    				{
	  		    					orgcode=Helper.correctNull(rs1.getString("USR_ORGCODE"));
	  		    					usrclass=rs1.getString("usr_class");
	  	  		    				}
	  		    					if(orgcode.equalsIgnoreCase(FwHelper.correctNull((String)hshRecord.get("BANKER_ORGCODE"))))
	  		    					{ 		    						
	  		    						if(Integer.parseInt(usrclass)>=85)
	  		    						{
	  		    							hshRecord.put("valiflag","true");	
	  		    						}
	  		    					}
	  		    					
	  		    				}
	  		    				
	  		    				if(rs!=null)
	  		    				{
	  		    					rs.close();
	  		    				}
	  		    				
	  		    				if(rs1!=null)
	  		    				{
	  		    					rs1.close();
	  		    				}
	  		    				
	  		    				//hshRecord.put("BANK_SAN_USERID"
	  		    				String USR_CLASS1="",USR_CLASS2="";
	  		    				orgcode="";
	  		    				ORG_CODE="";
			    					
	  		    				boolean closeflag=false;
	  		    				rs1=DBUtils.executeLAPSQuery("sel_bankercertificate_org1^"+strUserId);
		  		    				if(rs1.next())
		  		    				{
		  		    					USR_CLASS1=Helper.correctNull(rs1.getString("USR_CLASS"));
		  		    					orgcode=Helper.correctNull(rs1.getString("USR_ORGCODE"));
		  		    				}
		  		    				rs=DBUtils.executeLAPSQuery("sel_bankercertificate_org^"+FwHelper.correctNull((String)hshRecord.get("BANK_SAN_USERID")));//strAppholder);
		  		    				if(rs.next())
		  		    				{
		  		    					USR_CLASS2=Helper.correctNull(rs.getString("USR_CLASS"));
		  		    					ORG_CODE=Helper.correctNull(rs.getString("ORG_CODE"));
		  		    				}
		  		    				
		  		    				if(orgcode.equalsIgnoreCase(ORG_CODE))
	  		    					{
		  		    				if(Integer.parseInt(USR_CLASS1)>=Integer.parseInt(USR_CLASS2))
		  		    				{
		  		    					hshRecord.put("closeflag","true");	
		  		    				}
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
	  	catch(Exception ce)
	  	{
	  		throw new EJBException("Error in getbankerworkflow  "+ce.toString());
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
	  		catch(Exception cf)
	  		{
	  			throw new EJBException("Error closing the connection "+cf.getMessage());
	  		}
	  	}
	  	return hshRecord; 
	  	
	  }
  
  public void updateAction(HashMap hshValues) 
	{
		HashMap hshqueryval =new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		
		
		ArrayList arrValues=new ArrayList();
		ResultSet rs = null;
		String strAction="";
		String strFromuserid="";
		String strTouserid="";
		String strFromflwpoint="";
		String strToflowpoint="";
		String strappno="";
		String strQuery="";
		String strCurdate="";
		String strToflwpoint="";
		String strExcep="$";
		String strAppid="";
		String appstatus="";
		String strApplStatus="";
		try
		{
	    strAction=correctNull((String)hshValues.get("hidAction"));
	    strFromuserid=correctNull((String)hshValues.get("txt_usrid"));
	    strTouserid=correctNull((String)hshValues.get("hidmail_tousrid"));
	    strFromflwpoint=correctNull((String)hshValues.get("txt_from_flwpt")); 
	    strToflwpoint=correctNull((String)hshValues.get("mail_toflowpoint")); 
	    strappno = Helper.correctNull((String) hshValues.get("strappno"));
	    strAppid=Helper.correctNull((String) hshValues.get("hidDemoId"));
	    appstatus=Helper.correctNull((String) hshValues.get("strappstatus"));
	    String strUserID=Helper.correctNull((String)hshValues.get("strUserId"));
	    String strcomments=Helper.correctNull((String)hshValues.get("txt_sanctioncomments"));
	    strCurdate=Helper.getCurrentDateTime();
	    
		if(strAction!=null && strAction.equalsIgnoreCase("send"))	
		{
			hshQuery.put("strQueryId","solappmailins");
			arrValues.add(strappno);
			arrValues.add(strFromuserid);
			arrValues.add(strTouserid);
		    arrValues.add("C");
			arrValues.add(strFromflwpoint);
			arrValues.add(strToflwpoint);
			arrValues.add("");
			
			if(rs!=null)
				rs.close();
			
			String strOrgScode="",strDept="";
			strQuery=SQLParser.getSqlQuery("workflowusersanlimit^"+strTouserid);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strOrgScode=Helper.correctNull(rs.getString("org_scode"));
				if(Helper.correctNull(rs.getString("org_level")).equalsIgnoreCase("C"))
				strDept=Helper.correctNull(rs.getString("USR_DEPARTMENT"));
				else if(Helper.correctNull(rs.getString("org_level")).equalsIgnoreCase("D"))
				strDept=Helper.correctNull(rs.getString("usr_rlpftype"));
			}
			
			arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
			if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
				arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
			else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
				arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
			else
				arrValues.add("");

			arrValues.add(strOrgScode);
			arrValues.add(strDept);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","solapplicationsupdt");
			arrValues.add("Y");
			arrValues.add(strTouserid);
			arrValues.add(strcomments);
			arrValues.add(strappno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","2");
			hshQueryValues.put("2",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
		}
		
		if(strAction.equalsIgnoreCase("approve") || strAction.equalsIgnoreCase("reject"))
		{
			if(strAction.equalsIgnoreCase("approve"))
			{
				String strAppUserID="";
				strQuery=SQLParser.getSqlQuery("sel_com_solvency^"+strAppid+"^"+strappno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strAppUserID=Helper.correctNull((String)rs.getString("SOL_USRID"));
				}
				if(strAppUserID.equals(strUserID))
				{
					strExcep=strExcep+"You cannot Sanction the Solvency you created";
					throw new Exception(strExcep);
				}
			}
            
			String strReferenceno=getSanctionRefernceNumber(hshValues);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			
			
			
			hshQuery.put("strQueryId","solapplstatupt");
	        if(strAction.equalsIgnoreCase("approve"))
			{
			  arrValues.add("PA");
			}
			else
			{
			  arrValues.add("PR");
			}
	        arrValues.add(strcomments);
			arrValues.add(strappno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
		
			
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","solappmailins");
			arrValues.add(strappno);
			arrValues.add(strFromuserid);
			arrValues.add(strFromuserid);
			arrValues.add("");
			arrValues.add(hshValues.get("hidcurrflowpoint"));
			if(strAction.equalsIgnoreCase("approve"))
			{
				arrValues.add("9");
			}
			else
			{
				arrValues.add("17");
			}
			arrValues.add("");
			arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
			if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
				arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
			else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
				arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
			else
				arrValues.add("");
			arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
			if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
				arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
			else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
				arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
			else
				arrValues.add("");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","2");
			hshQueryValues.put("2",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
		}
		if(strAction.equalsIgnoreCase("undo"))
		{
			HashMap hshRecord = new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			
			strQuery = SQLParser.getSqlQuery("sel_com_solvency^"+strAppid+"^"+strappno);
			rs = DBUtils.executeQuery(strQuery);	
	                if(rs.next())
	               {
	                	hshRecord.put("sol_status",correctNull(rs.getString("sol_status")));
	                	strApplStatus=correctNull(rs.getString("sol_status"));
	               }
			
		   if(strApplStatus.equalsIgnoreCase("PR") || strApplStatus.equalsIgnoreCase("PA"))
			{
				hshQuery.put("strQueryId","solworkflowundoupt");
				arrValues.add("OP");
				arrValues.add(strUserID);
				arrValues.add("Y");
				arrValues.add(strappno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		   
		    hshqueryval = new HashMap();
			hshquery = new HashMap();		
			arrValues=new ArrayList();
			hshquery.put("strQueryId","del_com_referencenum");
			arrValues.add(strappno);
			hshquery.put("arrValues",arrValues);
			hshqueryval.put("1",hshquery);
			hshqueryval.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
		 
		}
				
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
		
		}finally
		{
			try
			{
				if(rs!=null)
					rs.close();
			}catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in updateCompany "+ exp.toString()); 
			}
		}
	}
  
  
  public void updateBankerAction(HashMap hshValues) 
	{
		HashMap hshqueryval =new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs = null;
		String strAction="";
		String strFromuserid="";
		String strTouserid="";
		String strFromflwpoint="";
		String strToflowpoint="";
		String strappno="";
		String strQuery="";
		String strCurdate="";
		String strToflwpoint="";
		String strExcep="$";
		String strAppid="";
		String appstatus="";
		String strApplStatus="";
		 String strUserID="";
		try
		{
	    strAction=correctNull((String)hshValues.get("hidAction"));
	    strFromuserid=correctNull((String)hshValues.get("txt_usrid"));
	    strTouserid=correctNull((String)hshValues.get("hidmail_tousrid"));
	    strFromflwpoint=correctNull((String)hshValues.get("txt_from_flwpt")); 
	    strToflwpoint=correctNull((String)hshValues.get("mail_toflowpoint")); 
	    strappno = Helper.correctNull((String) hshValues.get("strappno"));
	    if(strappno.equalsIgnoreCase(""))
	    {
	    	strappno = Helper.correctNull((String) hshValues.get("hidapplno")); 
	    }
	    strAppid=Helper.correctNull((String) hshValues.get("hidDemoId"));
	    appstatus=Helper.correctNull((String) hshValues.get("strappstatus"));
	     strUserID=Helper.correctNull((String)hshValues.get("strUserId"));
	    
	    if(strUserID.equalsIgnoreCase(""))
	    {
	    	strUserID=strFromuserid;
	    }
	    String strcomments=Helper.correctNull((String)hshValues.get("txt_sanctioncomments"));
	    strCurdate=Helper.getCurrentDateTime();
	    
		if(strAction!=null && strAction.equalsIgnoreCase("send"))	
		{
			
			
			/*String strAppUserID="";
			strQuery=SQLParser.getSqlQuery("sel_com_banker^"+strAppid+"^"+strappno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strAppUserID=Helper.correctNull((String)rs.getString("BANKER_USRID"));
			}
			if(strAppUserID.equals(strUserID))
			{
				strExcep=strExcep+"You cannot Sanction the Banker's certificate proposal you created";
				throw new Exception(strExcep);
			}*/
			
			
			hshQuery.put("strQueryId","bankerappmailins");
			arrValues.add(strappno);
			arrValues.add(strFromuserid);
			arrValues.add(strTouserid);
		    arrValues.add("C");
			arrValues.add(strFromflwpoint);
			arrValues.add(strToflwpoint);
			arrValues.add("");
			
			if(rs!=null)
				rs.close();
			
			String strOrgScode="",strDept="";
			strQuery=SQLParser.getSqlQuery("workflowusersanlimit^"+strTouserid);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strOrgScode=Helper.correctNull(rs.getString("org_scode"));
				if(Helper.correctNull(rs.getString("org_level")).equalsIgnoreCase("C"))
				strDept=Helper.correctNull(rs.getString("USR_DEPARTMENT"));
				else if(Helper.correctNull(rs.getString("org_level")).equalsIgnoreCase("D"))
				strDept=Helper.correctNull(rs.getString("usr_rlpftype"));
			}
			
			arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
			if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
				arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
			else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
				arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
			else
				arrValues.add("");

			arrValues.add(strOrgScode);
			arrValues.add(strDept);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","bankerapplicationsupdt");
			arrValues.add("Y");
			arrValues.add(strTouserid);
			arrValues.add(strcomments);
			arrValues.add(strappno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","2");
			hshQueryValues.put("2",hshQuery);
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			
			
		}
		
		if(strAction.equalsIgnoreCase("approve") || strAction.equalsIgnoreCase("reject"))
		{
			if(strAction.equalsIgnoreCase("approve"))
			{
				String strAppUserID="";
				strQuery=SQLParser.getSqlQuery("sel_com_banker^"+strappno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strAppUserID=Helper.correctNull((String)rs.getString("BANKER_USRID"));
				}
				if(strAppUserID.equalsIgnoreCase(strUserID))
				{
					strExcep=strExcep+"You cannot Sanction the Banker's certificate proposal you created";
					throw new Exception(strExcep);
				}
			}
        
			
			
			///////
			
			
			if(strAction.equalsIgnoreCase("approve"))
			{
				String Tender_Opening_date="",BANKER_DATE="",BANK_VALID_DAYS="";
				strQuery=SQLParser.getSqlQuery("sel_com_banker^"+strappno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					Tender_Opening_date=Helper.correctNull((String)rs.getString("Tender_Opening_date"));
					BANKER_DATE=Helper.correctNull((String)rs.getString("BANKER_DATE"));
					BANK_VALID_DAYS=Helper.correctNull((String)rs.getString("BANK_VALID_DAYS"));
					hshValues.put("BANKER_CBS_ID", Helper.correctNull((String)rs.getString("BANKER_CBS_ID")));
					hshValues.put("BANKER_APPROVE_DATE", Helper.correctNull((String)rs.getString("BANKER_APPROVE_DATE")));
					
				}
				
			
			boolean sanflag=false;
			ResultSet rsstatus=null,rsnetworth=null,rsmax=null;
			boolean actflag=false;
			boolean expflag=false;
			int actstatus=0,expstatus=0;
			double actnethworth=0.00,expnethworth=0.00;
			//BANKER_APPROVE_DATE
			rs=DBUtils.executeLAPSQuery("selcbsidactexpapp1^"+FwHelper.correctNull((String)hshValues.get("BANKER_CBS_ID")));
			while(rs.next())
			{
				boolean issueflag=false,tendooropoendate=false,expirydate=false,validityextensiondate=false;
				String bappno="",banker_certi_valityextdate="",BANKER_DATE1="",Tender_Opening_date1="",BANK_EXPIRY_DATE="",BANK_VALID_DAYS1="";
				int iBANK_VALID_DAYS=0;
				double BANKER_AMOUNT=0.00;
				bappno=FwHelper.correctNull((String)rs.getString("BANKER_APPL_NO"));				
				if(appstatus.equalsIgnoreCase("PA"))
				{
					sanflag=true;
				rsmax=DBUtils.executeLAPSQuery("sel_com_banker_actexp1^"+bappno+"^"+FwHelper.correctNull((String)hshValues.get("BANKER_APPROVE_DATE")));
				}
				else
				{
					rsmax=DBUtils.executeLAPSQuery("sel_com_banker_actexp^"+bappno);						
				}
				if(rsmax.next())
				{
					BANKER_AMOUNT=0.00;
					BANK_EXPIRY_DATE=FwHelper.correctNull((String)rsmax.getString("BANK_EXPIRY_DATE"));
					banker_certi_valityextdate=FwHelper.correctNull((String)rsmax.getString("banker_certi_valityextdate"));
					Tender_Opening_date1=FwHelper.correctNull((String)rsmax.getString("Tender_Opening_date"));
					BANKER_DATE1=FwHelper.correctNull((String)rsmax.getString("BANKER_DATE"));
					iBANK_VALID_DAYS=rsmax.getInt("BANK_VALID_DAYS");
					BANKER_AMOUNT=Double.valueOf((FwHelper.correctNull((String)rsmax.getString("BANKER_AMOUNT"))));					
					String todaydate=Helper.getCurrentDateTime();
					Date date2=new SimpleDateFormat("dd/MM/yyyy").parse(todaydate);  
					Calendar cal2 = Calendar.getInstance();
					cal2.setTime(date2);					
					Date dateexp=new Date();
					Calendar calexp = Calendar.getInstance();					
					Date datevalcer=new Date();
					Calendar calvalcer = Calendar.getInstance();					
					Date date1=new Date();
					Calendar cal = Calendar.getInstance();					
					Date dateWithIssueDate= new Date();					
					Calendar cal21 = Calendar.getInstance();
					Date date21=new Date();					
					Date dateWithTendornotificate =new Date();						
					if(!BANK_EXPIRY_DATE.equalsIgnoreCase(""))
					{					
					dateexp=new SimpleDateFormat("dd/MM/yyyy").parse(BANK_EXPIRY_DATE);  			
					calexp.setTime(dateexp);
					}
					if(!banker_certi_valityextdate.equalsIgnoreCase(""))
					{					
					datevalcer=new SimpleDateFormat("dd/MM/yyyy").parse(banker_certi_valityextdate);  			
					calvalcer.setTime(datevalcer);
					}					
					if(!BANKER_DATE1.equalsIgnoreCase(""))
					{					
					date1=new SimpleDateFormat("dd/MM/yyyy").parse(BANKER_DATE1);  			
					cal.setTime(date1);
					cal.add(Calendar.DATE, iBANK_VALID_DAYS); 
					 dateWithIssueDate = cal.getTime();
					}
					if(!Tender_Opening_date1.equalsIgnoreCase(""))
					{					
					 date21=new SimpleDateFormat("dd/MM/yyyy").parse(Tender_Opening_date1);  			
					cal21.setTime(date21);					
					cal21.add(Calendar.DATE, iBANK_VALID_DAYS); 
					 dateWithTendornotificate = cal21.getTime();
					}
					if(!banker_certi_valityextdate.equalsIgnoreCase(""))
					{
					if(date2.compareTo(datevalcer)>0)
					{
						expstatus=expstatus+1;
						expnethworth=expnethworth+BANKER_AMOUNT;
					}
					else
					{
						actstatus=actstatus+1;
						actnethworth=actnethworth+BANKER_AMOUNT;	
					}
					validityextensiondate=true;
					}
					
					if(!BANK_EXPIRY_DATE.equalsIgnoreCase("") && !validityextensiondate)
					{
						
						if(date2.compareTo(dateexp)>0)
						{
							expstatus=expstatus+1;
							expnethworth=expnethworth+BANKER_AMOUNT;
						}
						else
						{
							actstatus=actstatus+1;
							actnethworth=actnethworth+BANKER_AMOUNT;	
						}	
						
						expirydate=true;
					 
					}
					
					
					if(!BANKER_DATE1.equalsIgnoreCase("") && !validityextensiondate && !expirydate)
					{
					if(date2.compareTo(dateWithIssueDate)>0)
				    {
						expstatus=expstatus+1;
						expnethworth=expnethworth+BANKER_AMOUNT;
					}
					else
					{
						actstatus=actstatus+1;
						actnethworth=actnethworth+BANKER_AMOUNT;	
					}	
						
				    	issueflag=true;	
				    }
					
					
					
				if(!Tender_Opening_date1.equalsIgnoreCase("") && !validityextensiondate && !expirydate && !issueflag)
				{
					if(date2.compareTo(dateWithTendornotificate)>0)
				    {
					expstatus=expstatus+1;
					
					expnethworth=expnethworth+BANKER_AMOUNT;
				}
				else
				{
					actstatus=actstatus+1;
					actnethworth=actnethworth+BANKER_AMOUNT;	
				}	
				    	tendooropoendate=true;
				    }
					
					 //actstatus
					 
					 
				}
				
			}
			
			java.text.NumberFormat nf = java.text.NumberFormat
			.getNumberInstance();
			nf.setGroupingUsed(false);
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			
			 if(!sanflag && !appstatus.equalsIgnoreCase(""))
			 {
				 hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","upd_act_expcntamt");
					arrValues.add(String.valueOf(actstatus));
					arrValues.add(nf.format(Double.parseDouble(Helper.correctDouble(String.valueOf(actnethworth)))));
					arrValues.add(String.valueOf(expstatus));
					arrValues.add(nf.format(Double.parseDouble(Helper.correctDouble(String.valueOf(expnethworth)))));
					arrValues.add(strappno);				
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	 
			 }
			
			}
			
			//////
			
			
			String strReferenceno=getBankerSanctionRefernceNumber(hshValues);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			
			
			
			hshQuery.put("strQueryId","bankerapplstatupt");
	        if(strAction.equalsIgnoreCase("approve"))
			{
			  arrValues.add("PA");
			  arrValues.add("ACTIVE");//BANK_SAN_ACTEXP_STATUS
			}
			else
			{
			  arrValues.add("PR");
			  arrValues.add("");
			}
	        
	        arrValues.add(strcomments);
	       // arrValues.add(strReferenceno);
			arrValues.add(strappno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
		
			
			
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","bankerappmailins");
			arrValues.add(strappno);
			arrValues.add(strFromuserid);
			/*if(!strTouserid.equalsIgnoreCase(""))
			{
			arrValues.add(strTouserid);
			}
			else
			{*/
				arrValues.add(strFromuserid);	//strFromuserid);
			//}
			arrValues.add("");
			arrValues.add(hshValues.get("hidcurrflowpoint"));
			if(strAction.equalsIgnoreCase("approve"))
			{
				arrValues.add("9");
			}
			else
			{
				arrValues.add("17");
			}
			arrValues.add("");
			
			String strOrgScode="",strDept="";
//			if(!strTouserid.equalsIgnoreCase(""))
//			{
//			strQuery=SQLParser.getSqlQuery("workflowusersanlimit^"+strTouserid);
//			}
//			else
//			{
				strQuery=SQLParser.getSqlQuery("workflowusersanlimit^"+strFromuserid);	
			//}
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strOrgScode=Helper.correctNull(rs.getString("org_scode"));
				if(Helper.correctNull(rs.getString("org_level")).equalsIgnoreCase("C"))
				strDept=Helper.correctNull(rs.getString("USR_DEPARTMENT"));
				else if(Helper.correctNull(rs.getString("org_level")).equalsIgnoreCase("D"))
				strDept=Helper.correctNull(rs.getString("usr_rlpftype"));
			}
			
			arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
			
			if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
			{
				arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
			}
			else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
			{
				arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
			}
			else
			{
				arrValues.add("");
			}
			
			arrValues.add(strOrgScode);//correctNull((String)hshValues.get("strOrgShortCode")));
			
			/*if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
				arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
			else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
				arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
			else*/
				arrValues.add(strDept);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","2");
			hshQueryValues.put("2",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
									
			/* int strsno=0;
				rs=DBUtils.executeLAPSQuery("maxsel_bankcerhisvalmaxx^"+strappno);
				if(rs.next())
				{
					strsno=Integer.parseInt(rs.getString("com_bank_sno"));
				}
			
			
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","updexp_bankcerhis_san");
			if(strAction.equalsIgnoreCase("approve"))
			{
			arrValues.add("ACTIVE");
			}
			else
			{
				arrValues.add("");	
			}
			
			
			if(strAction.equalsIgnoreCase("approve"))
			{
			arrValues.add("APPROVED");
			}
			else
			{
				arrValues.add("REJECTED");
			}
			arrValues.add(strFromuserid);
			if(!strTouserid.equalsIgnoreCase(""))
			{
				arrValues.add(strTouserid);	
			}
			else
			{
				arrValues.add(strFromuserid);	
			}
//			if(strAction.equalsIgnoreCase("approve"))
//			{
//			arrValues.add("PA");
//			}
			//else
			//{
				arrValues.add("OP");
			//}
			arrValues.add(strappno);
			arrValues.add(""+strsno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");*/
			
			
			 int strsno=0;
				rs=DBUtils.executeLAPSQuery("maxsel_bankcerhisvalmax^"+strappno);
				if(rs.next())
				{
					strsno=Integer.parseInt(rs.getString("com_bank_sno"));
				}	
				//strsno++;		
				
				strQuery = SQLParser.getSqlQuery("select_networth_cusprofile^"+strAppid);
				rs=DBUtils.executeQuery(strQuery);
				String perapp_cbsid="";
				if(rs.next()){
					//networth=Double.parseDouble(Helper.correctDouble(rs.getString("PERAPP_NETWORTH")));
					perapp_cbsid=Helper.correctNull(rs.getString("perapp_cbsid"));
				}
				
				//hshQuery=new HashMap();
				//arrValues=new ArrayList();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","sel_ins_bankcer_history");
				arrValues.add(strappno);
				arrValues.add(strAppid);
				arrValues.add(strUserID);
				arrValues.add(perapp_cbsid);
				arrValues.add("OP");	
				if(strAction.equalsIgnoreCase("approve"))
				{
				arrValues.add("ACTIVE");
				}
				else
				{
					arrValues.add("");	
				}
				//arrValues.add("CLOSED");
				arrValues.add(""+strsno);
				if(strAction.equalsIgnoreCase("approve"))
				{
				arrValues.add("APPROVED");
				}
				else
				{
					arrValues.add("REJECTED");
				}
				//arrValues.add("CLOSURE");
				arrValues.add(strUserID);
				arrValues.add(strUserID);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			if(strAction.equalsIgnoreCase("approve"))
			{
				String Tender_Opening_date="",BANKER_DATE="",BANK_VALID_DAYS="";
				strQuery=SQLParser.getSqlQuery("sel_com_banker^"+strappno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					Tender_Opening_date=Helper.correctNull((String)rs.getString("Tender_Opening_date"));
					BANKER_DATE=Helper.correctNull((String)rs.getString("BANKER_DATE"));
					BANK_VALID_DAYS=Helper.correctNull((String)rs.getString("BANK_VALID_DAYS"));
				}
				
				if(BANK_VALID_DAYS.equalsIgnoreCase(""))
				{
					BANK_VALID_DAYS="30";	
				}
				
						
						
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","update_bankers_san_det");
			arrValues.add(strReferenceno);
			boolean issueflag=false;
			 boolean tendooropoendate=false;
			 Date d1  =new SimpleDateFormat("dd/MM/yyyy").parse(BANKER_DATE);
			    Date d2 = new SimpleDateFormat("dd/MM/yyyy").parse(Tender_Opening_date);
			      
			    if(d1.compareTo(d2)>0)
			    {
			    	issueflag=true;	
			    }
			    else
			    {
			    	tendooropoendate=true;
			    }
			    
//			    if(d1.compareTo(d2)==0)
//			    {
//			    	issueflag=true;	
//			    }
			    
			    
			 
					
					if(issueflag)
					{
				 Date dateWithValDays2=new SimpleDateFormat("dd/MM/yyyy").parse(BANKER_DATE);  
				 Calendar cal221 = Calendar.getInstance();
				 cal221.setTime(dateWithValDays2);
				 
					//cal.add(Calendar.DATE, noofdays2); 
					//Date dateWithValDays2 = cal.getTime();
					
					
					System.out.println("dateWithValDays2===="+dateWithValDays2);
					
				int noofdays=Integer.parseInt(BANK_VALID_DAYS);
				//cal.add(Calendar.DATE, noofdays); 
				//Date dateWithValDays = cal.getTime();
				
           DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
//	            Calendar c = Calendar.getInstance();
				cal221.add(Calendar.DATE, noofdays);
	            System.out.println(dateFormat.format(cal221.getTime()));
	            arrValues.add(""+dateFormat.format(cal221.getTime()));
					}
					
					
					if(tendooropoendate)
					{
				 Date dateWithValDays2=new SimpleDateFormat("dd/MM/yyyy").parse(Tender_Opening_date); 
				 Calendar cal221 = Calendar.getInstance();
				 cal221.setTime(dateWithValDays2);
				 
					//cal.add(Calendar.DATE, noofdays2); 
					//Date dateWithValDays2 = cal.getTime();
					
					
					System.out.println("dateWithValDays2===="+dateWithValDays2);
					
				int noofdays=Integer.parseInt(BANK_VALID_DAYS);
				//cal.add(Calendar.DATE, noofdays); 
				//Date dateWithValDays = cal.getTime();
				
           DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
//	            Calendar c = Calendar.getInstance();
				cal221.add(Calendar.DATE, noofdays);
	            System.out.println(dateFormat.format(cal221.getTime()));
	            arrValues.add(""+dateFormat.format(cal221.getTime()));
					}
					arrValues.add(strUserID);
					//arrValues.add(strUserID);
					String usr_class="";
					ResultSet rs1=null;
					rs1=DBUtils.executeLAPSQuery("workflowusersanlimit^"+strUserID);
			        if(rs1.next()){
					 usr_class=Helper.correctNull(rs1.getString("usr_class"));				
			        }
			        if(rs1!=null){
						rs1.close();
					}
			arrValues.add(usr_class);       
			arrValues.add(strappno);			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			
			
			
			}
			
			if(strAction.equalsIgnoreCase("reject"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","update_bankers_rej_det");
				arrValues.add(strReferenceno);
				arrValues.add(strUserID);
				String usr_class="";
				ResultSet rs1=null;
				rs1=DBUtils.executeLAPSQuery("workflowusersanlimit^"+strUserID);
		        if(rs1.next()){
				 usr_class=Helper.correctNull(rs1.getString("usr_class"));				
		        }
		        arrValues.add(usr_class);
				arrValues.add(strappno);			
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","bankerapplicationsupdt");
			arrValues.add("Y");
			if(!strTouserid.equalsIgnoreCase(""))
			{
			arrValues.add(strTouserid);
			}
			else
			{
				arrValues.add(strFromuserid);	
			}
			
			arrValues.add(strcomments);
			arrValues.add(strappno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			
			
			
			
			
		}
		if(strAction.equalsIgnoreCase("undo"))
		{
			HashMap hshRecord = new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			
			strQuery = SQLParser.getSqlQuery("sel_com_banker^"+strappno);
			rs = DBUtils.executeQuery(strQuery);	
	                if(rs.next())
	               {
	                	hshRecord.put("BANKER_STATUS",correctNull(rs.getString("BANKER_STATUS")));
	                	strApplStatus=correctNull(rs.getString("BANKER_STATUS"));
	               }
			
		   if(strApplStatus.equalsIgnoreCase("PR") || strApplStatus.equalsIgnoreCase("PA") || strApplStatus.equalsIgnoreCase("CA"))
			{
				hshQuery.put("strQueryId","bankerworkflowundoupt");
				arrValues.add("OP");
				arrValues.add(strUserID);
				arrValues.add("Y");
				arrValues.add("");
				arrValues.add(strappno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		   
		   
		   
		    hshqueryval = new HashMap();
			hshquery = new HashMap();		
			arrValues=new ArrayList();
			hshquery.put("strQueryId","del_com_bankerreferencenum");
			arrValues.add(strappno);
			hshquery.put("arrValues",arrValues);
			hshqueryval.put("1",hshquery);
			hshqueryval.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			
			
			hshqueryval = new HashMap();
			hshquery = new HashMap();		
			arrValues=new ArrayList();
			hshquery.put("strQueryId","update_bankers_undo_det");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add(strappno);
			hshquery.put("arrValues",arrValues);
			hshqueryval.put("1",hshquery);
			hshqueryval.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			
			
			
			int strsno=0;
			rs=DBUtils.executeLAPSQuery("maxsel_bankcerhisvalmax^"+strappno);
			if(rs.next())
			{
				strsno=Integer.parseInt(rs.getString("com_bank_sno"));
			}	
			//strsno++;		
			
			strQuery = SQLParser.getSqlQuery("select_networth_cusprofile^"+strAppid);
			rs=DBUtils.executeQuery(strQuery);
			String perapp_cbsid="";
			if(rs.next()){
				//networth=Double.parseDouble(Helper.correctDouble(rs.getString("PERAPP_NETWORTH")));
				perapp_cbsid=Helper.correctNull(rs.getString("perapp_cbsid"));
			}
			
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","sel_ins_bankcer_history");
			arrValues.add(strappno);
			arrValues.add(strAppid);
			arrValues.add(strUserID);
			arrValues.add(perapp_cbsid);
			arrValues.add("OP");			
			arrValues.add("");
			arrValues.add(""+strsno);
			arrValues.add("Undo");
			arrValues.add(strUserID);
			arrValues.add(strUserID);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			
			
			
			strQuery = SQLParser.getSqlQuery("UniqAppidListnew1^"+perapp_cbsid);
			rs=DBUtils.executeQuery(strQuery);
			String perapp_newapp="";
			if(rs.next()){
				//networth=Double.parseDouble(Helper.correctDouble(rs.getString("PERAPP_NETWORTH")));
				perapp_newapp=Helper.correctNull(rs.getString("perapp_id"));
			}
			
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			arrValues.add(perapp_newapp);
			arrValues.add(strAppid);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","upd_bankercertificate_idrenew");
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		 
		}
		
		if(strAction.equalsIgnoreCase("ValidityExtension"))
		{
			
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","update_bankers_valext_det");
			arrValues.add(correctNull((String)hshValues.get("txt_valextdate")));
			arrValues.add(correctNull((String)hshValues.get("txt_reasonext")));
			int count=0;
			rs=DBUtils.executeLAPSQuery("sel_bankers_loanamt^"+strappno);
			if(rs.next())
			{
				count=rs.getInt("BANK_VALIDITY_EXT_COUNT");
			}
			count=count+1;
			arrValues.add(""+count);
			
			arrValues.add(strUserID);
			String usr_class="";
			ResultSet rs1=null;
			rs1=DBUtils.executeLAPSQuery("workflowusersanlimit^"+strUserID);
	        if(rs1.next()){
			 usr_class=Helper.correctNull(rs1.getString("usr_class"));				
	        }
	        if(rs1!=null){
				rs1.close();
			}
	        arrValues.add(usr_class);   
	        arrValues.add("ACTIVE");
			arrValues.add(strappno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			
			
			 int strsno=0;
			rs=DBUtils.executeLAPSQuery("maxsel_bankcerhisvalmax^"+strappno);
			if(rs.next())
			{
				strsno=Integer.parseInt(rs.getString("com_bank_sno"));
			}	
			//strsno++;		
			
			strQuery = SQLParser.getSqlQuery("select_networth_cusprofile^"+strAppid);
			rs=DBUtils.executeQuery(strQuery);
			String perapp_cbsid="";
			if(rs.next()){
				//networth=Double.parseDouble(Helper.correctDouble(rs.getString("PERAPP_NETWORTH")));
				perapp_cbsid=Helper.correctNull(rs.getString("perapp_cbsid"));
			}
			
			//hshQuery=new HashMap();
			//arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","sel_ins_bankcer_history");
			arrValues.add(strappno);
			arrValues.add(strAppid);
			arrValues.add(strUserID);
			arrValues.add(perapp_cbsid);
			arrValues.add("PA");			
			arrValues.add("ACTIVE");
			arrValues.add(""+strsno);
			arrValues.add("ValidityExten");
			arrValues.add(strUserID);
			arrValues.add(strUserID);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			
		}
		
		if(strAction.equalsIgnoreCase("CloseBCLOC"))
		{
						
			hshQuery=new HashMap();
			arrValues=new ArrayList();			
			hshQuery.put("strQueryId","bankerapplstatuptclose");	       
			  arrValues.add("CA");			
	       // arrValues.add(strcomments);
	       // arrValues.add(strReferenceno);
			  arrValues.add(strUserID);//banker_close_userid

				String usr_class="";
				ResultSet rs1=null;
				rs1=DBUtils.executeLAPSQuery("workflowusersanlimit^"+strUserID);
		        if(rs1.next()){
				 usr_class=Helper.correctNull(rs1.getString("usr_class"));				
		        }
		        if(rs1!=null){
					rs1.close();
				}
		arrValues.add(usr_class);   
		
			arrValues.add(strappno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
//			 int strsno=0;
//				rs=DBUtils.executeLAPSQuery("maxsel_bankcerhisvalmax^"+strappno);
//				if(rs.next())
//				{
//					strsno=Integer.parseInt(rs.getString("com_bank_sno"));
//				}
//			
//			
//			//hshQueryValues=new HashMap();
//			hshQuery=new HashMap();
//			arrValues=new ArrayList();
//			hshQuery.put("strQueryId","updexp_bankcerhis_san");
//			arrValues.add("CLOSED");
//			arrValues.add(strappno);
//			arrValues.add(""+strsno);
//			arrValues.add("CLOSED");
//			arrValues.add(strUserID);
//			arrValues.add(strUserID);
//			
//			arrValues.add("CA");
//			
//			hshQuery.put("arrValues",arrValues);
//			hshQueryValues.put("size","1");
//			hshQueryValues.put("1",hshQuery);
//			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			
			 int strsno=0;
				rs=DBUtils.executeLAPSQuery("maxsel_bankcerhisvalmax^"+strappno);
				if(rs.next())
				{
					strsno=Integer.parseInt(rs.getString("com_bank_sno"));
				}	
				//strsno++;		
				
				strQuery = SQLParser.getSqlQuery("select_networth_cusprofile^"+strAppid);
				rs=DBUtils.executeQuery(strQuery);
				String perapp_cbsid="";
				if(rs.next()){
					//networth=Double.parseDouble(Helper.correctDouble(rs.getString("PERAPP_NETWORTH")));
					perapp_cbsid=Helper.correctNull(rs.getString("perapp_cbsid"));
				}
				
				//hshQuery=new HashMap();
				//arrValues=new ArrayList();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","sel_ins_bankcer_history");
				arrValues.add(strappno);
				arrValues.add(strAppid);
				arrValues.add(strUserID);
				arrValues.add(perapp_cbsid);
				arrValues.add("CA");			
				arrValues.add("CLOSED");
				arrValues.add(""+strsno);
				arrValues.add("CLOSURE");
				arrValues.add(strUserID);
				arrValues.add(strUserID);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
			
			
		
		
		}
		catch(Exception e)
		{
			throw new EJBException("Error in  updateBankerAction "+ e.toString());
		
		}finally
		{
			try
			{
				if(rs!=null)
					rs.close();
			}catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in updateBankerAction "+ exp.toString()); 
			}
		}
	}
		
  public String getSanctionRefernceNumber(HashMap hshValues) 
	{
		String strRefno="";
		String strAppno="";
		String strSolid="";
		String strFinancialYear="";
		String strDateofSanc="";
		String strOrgLevel="";
		String strOrgCode="";
		String strCPCCode="";
		String strUserId="";
		String strSancAuthority="";
		String strSancAuthorityCode="";
		String strUserDepartment="";
		String strUserDesignation="";
		String strBifur="/";
		ResultSet rs=null;
		String strSno="";
		ArrayList arrValues=new ArrayList();
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		String strFinancialYear1="",strFinancialYear2="";
		String strQuery="";
		String strFinacleSancRefNo="",strAction="",Appstatus="",StrModuleType="";
		try
		{
			strAction=Helper.correctNull((String)hshValues.get("hidAction"));
			if(strAction.equalsIgnoreCase("approve"))
			{
				Appstatus="A";
			}
			else if(strAction.equalsIgnoreCase("reject"))
			{
				Appstatus="R";
			}
			strAppno=Helper.correctNull((String)hshValues.get("strappno"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)hshValues.get("appno"));
			}
			strSolid=Helper.correctNull((String)hshValues.get("strSolid"));
			strOrgLevel=Helper.correctNull((String)hshValues.get("strOrgLevel"));
//			strOrgLevel="SOL";
			strOrgCode=Helper.correctNull((String)hshValues.get("strOrgCode"));
			strUserDepartment=Helper.correctNull((String)hshValues.get("strUserDepartment"));
			strUserId=Helper.correctNull((String)hshValues.get("strUserId"));
			strCPCCode=strOrgCode.substring(0,6);
			StrModuleType=Helper.correctNull((String)hshValues.get("sessionModuleType"));
			if(!(strSolid.equalsIgnoreCase("") || strAppno.equalsIgnoreCase("")))
			{
				strFinancialYear=Helper.financialYear();
				rs=DBUtils.executeLAPSQuery("selCurrentdate");
				if(rs.next())
				{
					strDateofSanc=Helper.correctNull((String)rs.getString("currentdate1"));
				}
				if(rs.next())
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("setuserssel^"+strUserId);
				if(rs.next())
				{
					strSancAuthorityCode=Helper.correctNull((String)rs.getString("user_designation"));
				}
				if(rs.next())
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("selcbsiddatadesc^27^"+strSancAuthorityCode);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strSancAuthority=Helper.correctNull((String)rs.getString("cbs_static_data_passing_code"));
				}
				if(rs !=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("selfinancialyear");
				if(rs.next())
				{
					strFinancialYear=Helper.correctNull((String)rs.getString("FinancialYear"));
					strFinancialYear1=strFinancialYear.substring(0,5);
					strFinancialYear2=strFinancialYear.substring(7,9);
					strFinancialYear=strFinancialYear1+strFinancialYear2;
				}
				
				
				if(rs!=null)
				{rs.close();}
				String SanctioningAuthority="",Sanction_Ref_Num="",Sanction_dep="",strFRefno="",strSancBranch="";
				{
					rs=DBUtils.executeLAPSQuery("sel_solvency_comments^"+strAppno);
					if(rs.next())
					{
						SanctioningAuthority=correctNull(rs.getString("sol_sanctioned_by"));
						Sanction_Ref_Num=correctNull(rs.getString("Sanc_Ref_No"));
						Sanction_dep=correctNull(rs.getString("SOL_SANCTIONING_DEPT"));
						strSancBranch=correctNull(rs.getString("SOL_SANCTIONING_BRANCH"));
					}
				}
				
				if(strOrgLevel.equalsIgnoreCase("C"))
				{
					strUserDepartment="";
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("sel_cbsstaticdescbycode^"+"131"+"^"+strSancBranch);
					if(rs.next())
					{
						strUserDepartment=Helper.correctNull((String)rs.getString("CBS_STATIC_SANC_REFNO"));
					}
					strRefno=strSancAuthority+strBifur+strUserDepartment+strBifur+strSolid+strBifur;
					strFRefno=strSancAuthority+strBifur+strUserDepartment+strBifur+strSolid+strBifur;
				}
				else if(strCPCCode.equalsIgnoreCase("001001") && strOrgLevel.equalsIgnoreCase("R"))
				{
					strRefno="CPC"+strSancAuthority+strBifur;
					strFRefno="CPC"+strSancAuthority+strBifur;
				}
				else if(strOrgLevel.equalsIgnoreCase("R"))
				{
					strRefno=strSancAuthority+strBifur+strSolid+strBifur;
					strFRefno=strSancAuthority+strBifur+strSolid+strBifur;
				}
				else if(strOrgLevel.equalsIgnoreCase("D") && Helper.correctNull((String)hshValues.get("strRLPFUser")).equalsIgnoreCase("012"))
				{
					strUserDepartment="";
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("sel_cbsstaticdescbycode^"+"130"+"^"+Sanction_dep);
					if(rs.next())
					{
						strUserDepartment=Helper.correctNull((String)rs.getString("CBS_STATIC_SANC_REFNO"));
					}
					strRefno=strSancAuthority+strBifur+strUserDepartment+strBifur+strSolid+strBifur;
					strFRefno=strSancAuthority+strBifur+strUserDepartment+strBifur+strSolid+strBifur;
				}
				else if(strOrgLevel.equalsIgnoreCase("A"))
				{					
					strRefno=strSancAuthority+strBifur+strSolid+strBifur;
					strFRefno=strSancAuthority+strBifur+strSolid+strBifur;
				}
				if(rs!=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("selsolreferencenumsno^"+strOrgLevel+"^"+strFinancialYear);
				if(rs.next())
				{
					strSno=Helper.correctNull((String)rs.getString("ars_sno"));
				}
				
				int intsno=Integer.parseInt(strSno);
				intsno=++intsno;
				strSno=Integer.toString(intsno);
				strRefno=strRefno+strSno+strBifur+strFinancialYear+strBifur+strDateofSanc;	
				strFinacleSancRefNo=strFRefno+strSno+strBifur+strFinancialYear;
				
				if(Sanction_dep.equalsIgnoreCase("011"))
				{
					strRefno="CPC"+strSancAuthority+strBifur+strSno+strBifur+strFinancialYear+strBifur+strDateofSanc;
					strFinacleSancRefNo="CPC"+strSancAuthority+strBifur+strSno+strBifur+strFinancialYear;
				}
				else if(Sanction_dep.equalsIgnoreCase("012"))
				{
					
					String strRLPCCode="RLPC",strOrgScode=strSolid;
					
					if((strOrgScode.substring(0, 1)).equalsIgnoreCase("R"))
						strOrgScode=strOrgScode.substring(1, strOrgScode.length());
					
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("sel_cbsstaticdescbycode^130^"+Sanction_dep);
					if(rs.next())
					{
						strRLPCCode=Helper.correctNull(rs.getString("cbs_static_sanc_refno"));
					}
					
					strRefno=strSancAuthority+strBifur+strRLPCCode+strBifur+strOrgScode+strBifur+strSno+strBifur+strFinancialYear+strBifur+strDateofSanc;
					strFinacleSancRefNo=strSancAuthority+strBifur+strRLPCCode+strBifur+strOrgScode+strBifur+strSno+strBifur+strFinancialYear;
				}
				
				if((SanctioningAuthority.equalsIgnoreCase("14")|| SanctioningAuthority.equalsIgnoreCase("15")||SanctioningAuthority.equalsIgnoreCase("16")))
				{
					strRefno=Sanction_Ref_Num;
					strFinacleSancRefNo=Sanction_Ref_Num;
				}
				
				hshQueryValues.put("size","1");
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insreferencenumsolvency");
				arrValues.add(strAppno);
				arrValues.add(strSolid);
				arrValues.add(strFinancialYear);
				arrValues.add(strOrgLevel);
				arrValues.add(strSno);
				arrValues.add(strRefno);
				arrValues.add(Appstatus);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in generating Sanction Reference Number.."+e);
		}
		return strRefno;
	}
		
 
  
  
  public HashMap getAction(HashMap hshRequestValues) 
  {
	String strQuery = null;
	ResultSet rs = null;
	HashMap hshRecord = new HashMap();
	ArrayList arrValues = new ArrayList();
	ArrayList arrRow = new ArrayList();
	String strAppno=correctNull((String)hshRequestValues.get("strappno"));
	
	try
	{	
		strQuery = SQLParser.getSqlQuery("solappmailsel^"+strAppno);
		rs=DBUtils.executeQuery(strQuery);
		
		 while(rs.next())
		  { 
			 arrValues = new ArrayList();
			 arrValues.add(Helper.correctNull((String)rs.getString("as_fromusrid")));
			 arrValues.add(Helper.correctNull((String)rs.getString("as_date")));
			 arrValues.add(Helper.correctNull((String)rs.getString("as_tousrid")));
			 arrValues.add(Helper.correctNull((String)rs.getString("as_type")));
			 arrValues.add(Helper.correctNull((String)rs.getString("as_fromflwpt")));
			 arrValues.add(Helper.correctNull((String)rs.getString("as_toflwpt")));
			 
			 arrRow.add(arrValues);
			 
		 }
		 
		 int strsno=0;
			rs=DBUtils.executeLAPSQuery("maxsel_bankcerhisval^"+strAppno);
			if(rs.next())
			{
				strsno=Integer.parseInt(rs.getString("com_bank_sno"));
			}
			
		
		
		
		rs=DBUtils.executeLAPSQuery("sel_all_bankdetailscount^"+strAppno+"^"+strsno);
		if(rs.next())
		{
			hshRecord.put("currentStatus",correctNull(rs.getString("com_bank_sanstatus")));
		}
		
	  hshRecord.put("arrRow", arrRow);
	 } 
	catch(Exception ce)
	{
		throw new EJBException("Error in getAction "+ce.toString());
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
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}

	return hshRecord; 
	
}
  public HashMap getBankerAction(HashMap hshRequestValues) 
  {
	  	String strQuery = null;
	  	ResultSet rs = null,rs1=null,rs4;
	  	HashMap hshRecord = new HashMap();
	  	ArrayList arrValues = new ArrayList();
	  	ArrayList arrRow = new ArrayList();
	  	String strPowerAmt="",strgrpid="";
	  	String strAppno=correctNull((String)hshRequestValues.get("strappno"));
	  	if(strAppno.equalsIgnoreCase(""))
	  	{
	  		strAppno=correctNull((String)hshRequestValues.get("hidapplno"));
	  	}
	  	String strUserid=correctNull((String)hshRequestValues.get("strUserId"));
	  	try
	  	{	
	  		strQuery = SQLParser.getSqlQuery("bankerappmailsel^"+strAppno);
	  		rs=DBUtils.executeQuery(strQuery);
	  		
	  		 while(rs.next())
	  		  { 
	  			 arrValues = new ArrayList();
	  			 arrValues.add(Helper.correctNull((String)rs.getString("as_fromusrid")));
	  			 arrValues.add(Helper.correctNull((String)rs.getString("as_date")));
	  			 arrValues.add(Helper.correctNull((String)rs.getString("as_tousrid")));
	  			 arrValues.add(Helper.correctNull((String)rs.getString("as_type")));
	  			 arrValues.add(Helper.correctNull((String)rs.getString("as_fromflwpt")));
	  			 arrValues.add(Helper.correctNull((String)rs.getString("as_toflwpt")));
	  			 
	  			 arrRow.add(arrValues);
	  			 
	  		 }
	  		 rs1=DBUtils.executeLAPSQuery("selUserId^"+ strUserid);			 
	  			if(rs1.next()) 
	  				{
	  				 strgrpid=correctNull(rs1.getString("grp_id"));
	  				}
	  			if(rs1!=null)
	  			       rs1.close();
	  		 if(rs!=null){
	  			 rs.close();}
	  		 rs=DBUtils.executeLAPSQuery("sel_bankerprdsanlmt^"+"6"+"^"+ strgrpid);	
	  			if(rs.next()) 
	  			{
	  				strPowerAmt=correctNull(rs.getString("sanction_limit"));
	  				log.info("<<<<<<<<<<===========strPowerAmt===================>>>>>>>>>>>>>>"+strPowerAmt);
	  			}
	  			double dblsumgoldloan=0.00,dbldepositloan=0.00,dbltotalrecamt=0.00;

	  			strQuery=SQLParser.getSqlQuery("sel_bankers_loanamt^"+strAppno);
	  	 		rs4=DBUtils.executeQuery(strQuery);
	  			if(rs4.next())
	  			{
	  				dbltotalrecamt=Double.parseDouble(Helper.correctDouble(rs4.getString("BANKER_AMOUNT")));
	  				
	  			}
	  			hshRecord.put("dbltotalrecamt", String.valueOf(dbltotalrecamt));
	  			hshRecord.put("PowerAmt",strPowerAmt);
	  		 
	  	  hshRecord.put("arrRow", arrRow);
	  	  
	  	  
	  	  int strsno=0;
	  		rs=DBUtils.executeLAPSQuery("maxsel_bankcerhisvalmaxx^"+strAppno);
	  		if(rs.next())
	  		{
	  			strsno=Integer.parseInt(rs.getString("com_bank_sno"));
	  		}
	  		
	  	
	  	
	  	
	  	rs=DBUtils.executeLAPSQuery("sel_all_bankdetailscount^"+strAppno+"^"+strsno);
	  	if(rs.next())
	  	{
	  		hshRecord.put("currentStatus",correctNull(rs.getString("com_bank_sanstatus")));
	  	}
	  	
	  	
	  	
	  	rs=DBUtils.executeLAPSQuery("sel_userid_details_bank^"+strUserid);
	  	if(rs.next())
	  	{
	  		hshRecord.put("usrclass",(rs.getString("USR_CLASS")));
	  	}
	  	
	  	 } 
	  	catch(Exception ce)
	  	{
	  		throw new EJBException("Error in getAction "+ce.toString());
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
	  		catch(Exception cf)
	  		{
	  			throw new EJBException("Error closing the connection "+cf.getMessage());
	  		}
	  	}

	  	return hshRecord; 
	  	
	  }
  
  public HashMap getKpowerHistroy(HashMap hshRequestValues) 
  {
	String strQuery = null;
	ResultSet rs = null;
	HashMap hshRecord = new HashMap();
	ArrayList arrValues = new ArrayList();
	ArrayList arrRow = new ArrayList();
	String strAppno=correctNull((String)hshRequestValues.get("hidAppno"));
	
	try
	{	
		strQuery = SQLParser.getSqlQuery("sel_histroy_appmail^"+strAppno);
		rs=DBUtils.executeQuery(strQuery);
		
		 while(rs.next())
		  { 
			 arrValues = new ArrayList();
			 arrValues.add(Helper.correctNull((String)rs.getString("ak_fromusrid")));
			 arrValues.add(Helper.correctNull((String)rs.getString("ak_date")));
			 arrValues.add(Helper.correctNull((String)rs.getString("ak_tousrid")));
			 arrValues.add(Helper.correctNull((String)rs.getString("ak_type")));
			 arrValues.add(Helper.correctNull((String)rs.getString("ak_fromflwpt")));
			 arrValues.add(Helper.correctNull((String)rs.getString("ak_toflwpt")));
			 arrRow.add(arrValues);
		 }
	  hshRecord.put("arrRow", arrRow);
	  
	 } 
	catch(Exception ce)
	{
		throw new EJBException("Error in getKpowerHistroy "+ce.toString());
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
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}

	return hshRecord; 
	
}
  public HashMap getKpowAction(HashMap hshRequestValues) 
  {
	String strQuery = null;
	ResultSet rs = null;
	HashMap hshRecord = new HashMap();
	HashMap hshValues = new HashMap();
	ArrayList arrWorkid = new ArrayList();
	ArrayList arrMaxclass = new ArrayList();
	ArrayList arrDuration = new ArrayList();
	ArrayList arrWorkflowname = new ArrayList();
	ArrayList arrflowpoint = new ArrayList();
	String strPrdCode ="2";
	String strWorkflowType ="p";
	
	
	String strapplno=correctNull((String)hshRequestValues.get("hidAppno"));
	String strAppstatus=correctNull((String)hshRequestValues.get("hidStatus"));
	String strAppid=correctNull((String)hshRequestValues.get("hidDemoId"));
	String strUserId=correctNull((String)hshRequestValues.get("strUserId"));
	String strAppholder=correctNull((String)hshRequestValues.get("hidAppholder"));
	try
	{	
			strQuery = SQLParser.getSqlQuery("sel_addkbowerdetails^"+ strAppid + "^" +strapplno);
			rs = DBUtils.executeQuery(strQuery);	
	                if(rs.next())
	               {
	                	hshRecord.put("addkbow_status",correctNull(rs.getString("addkbow_status")));
	                	strAppstatus=correctNull(rs.getString("addkbow_status"));
	               }
			
			if(!strPrdCode.equals(""))
			{
				if(strAppstatus.equalsIgnoreCase("OP"))
				{
				strQuery = SQLParser.getSqlQuery("prdsolkpowsel^" + strPrdCode + "^" +strWorkflowType);
				rs = DBUtils.executeQuery(strQuery);	
					while (rs.next()) 
					{
						arrWorkid.add(rs.getString("prd_workid"));
						arrMaxclass.add(rs.getString("prd_minclass"));
						arrDuration.add(rs.getString("prd_duration"));
						arrflowpoint.add(rs.getString("prd_flowpoint"));
						arrWorkflowname.add(rs.getString("wrk_flowname"));
					}
			    }
		    }
	
			  if(!strAppstatus.equalsIgnoreCase("OP"))
			  {
				  	if((strAppstatus.equalsIgnoreCase("PA")) || (strAppstatus.equalsIgnoreCase("CA"))) 
					{
						strQuery=SQLParser.getSqlQuery("sel_prd_solkpowflowpoint2^<17^>8");
						rs = DBUtils.executeQuery(strQuery);	
						while (rs.next()) 
						{
							arrMaxclass.add(rs.getString("prd_minclass"));
							arrflowpoint.add(rs.getString("prd_flowpoint"));
							arrWorkflowname.add(rs.getString("wrk_flowname"));
						}
					}
				  	if((strAppstatus.equalsIgnoreCase("PR")) || (strAppstatus.equalsIgnoreCase("CR"))) 
					{
						strQuery=SQLParser.getSqlQuery("sel_prd_solkpowflowpoint2^<25^>16");
						rs = DBUtils.executeQuery(strQuery);	
						while (rs.next()) 
						{
							arrMaxclass.add(rs.getString("prd_minclass"));
							arrflowpoint.add(rs.getString("prd_flowpoint"));
							arrWorkflowname.add(rs.getString("wrk_flowname"));
						}
					}
			    }
			        hshRecord.put("strPrdCode", strPrdCode);
			        hshRecord.put("prd_workid", arrWorkid);
					hshRecord.put("prd_minclass", arrMaxclass);
					hshRecord.put("prd_duration", arrDuration);
					hshRecord.put("arrflowpoint", arrflowpoint);
					hshRecord.put("wrk_flowname", arrWorkflowname);
				
					if(rs!=null)
					rs.close();
					
					strQuery = SQLParser.getSqlQuery("sel_appmailbox_kpow_date^"+strapplno +"^"+strapplno);
					rs = DBUtils.executeQuery(strQuery);	
			                if(rs.next())
			               {
			                	hshRecord.put("ak_toflwpt",correctNull(rs.getString("ak_toflwpt")));
			                	hshRecord.put("ak_date",correctNull(rs.getString("ak_date")));
			                	hshRecord.put("dueon_date",correctNull(rs.getString("dueon_date")));
			               }
	
					if(rs!=null)
					rs.close();
					
					
					strQuery = SQLParser.getSqlQuery("sel_kpow_comments^"+strapplno);
					rs = DBUtils.executeQuery(strQuery);	
			                if(rs.next())
			               {
			                hshRecord.put("addkbow_comments",correctNull(rs.getString("addkbow_comments")));
			               }  
			                
			                hshRecord.put("strUserId",strUserId);
			                hshRecord.put("strAppholder",strAppholder);
			                
			                int intMinimumClass=0;
			                
			                strQuery = SQLParser.getSqlQuery("prdsolkpowactivitysel^2");
							rs = DBUtils.executeQuery(strQuery);	

							 if(rs.next()) 
							{
							
								 intMinimumClass=Integer.parseInt(Helper.correctInt(rs.getString("prd_minclassapproval")));
							
							}
			                
			                if(rs!=null)
			    				rs.close();		
			    			
			    			rs=DBUtils.executeLAPSQuery("workflowusersanlimit^"+strUserId);
			    			if(rs.next())
			    			{
			    				if(Integer.parseInt(Helper.correctInt(rs.getString("usr_class")))>=intMinimumClass)
			    				hshRecord.put("strSancAuth","Y");
			    				hshRecord.put("usrfunction",Helper.correctNull(rs.getString("usr_function")));
			    			}
						
	} 
	catch(Exception ce)
	{
		throw new EJBException("Error in getKpowAction  "+ce.toString());
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
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	return hshRecord; 
	
}
  public HashMap getSolDetails(HashMap hshRequestValues) 
  {
	String strQuery = null;
	ResultSet rs = null,rs1=null;
	HashMap hshRecord = new HashMap();
	ArrayList arrValues = new ArrayList();
	ArrayList arrRow = new ArrayList();
	String strAppno=correctNull((String)hshRequestValues.get("txt_applno"));
	String strAppid=correctNull((String)hshRequestValues.get("hidoldId"));
	try
	{	
		strQuery = SQLParser.getSqlQuery("sel_soldetails^"+strAppid);
		rs=DBUtils.executeQuery(strQuery);
		
		 while(rs.next())
		  { 
			 arrValues = new ArrayList();
			 arrValues.add(Helper.correctNull((String)rs.getString("sol_appl_no")));
			 arrValues.add(Helper.correctNull((String)rs.getString("sol_status")));
			 arrValues.add(Helper.correctNull((String)rs.getString("sol_applnholder")));
			 arrValues.add(Helper.correctNull((String)rs.getString("sol_appid")));
			 arrRow.add(arrValues);
		 }
		
	  hshRecord.put("arrRow", arrRow);
	  
	    strQuery=SQLParser.getSqlQuery("sel_processAppl_solvency^"+strAppid);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshRecord.put("str_approvedAppl_demoid","Y");
		}
		else
		{
			hshRecord.put("str_approvedAppl_demoid","N");
		}
		String strOccupation="";
		
		if(rs!=null)
			rs.close();
		strQuery=SQLParser.getSqlQuery("selrenewappid^"+strAppid);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
			{
				strQuery=SQLParser.getCBSSqlQuery("cbscusmastersearch_newconnection^"+Helper.correctNull(rs.getString("perapp_cbsid")));
				rs1=DBUtils.executeQueryCBSConnection(strQuery);
			}
			else
			{
				strQuery= SQLParser.getSqlQuery("cbscusmastersearch^"+Helper.correctNull(rs.getString("perapp_cbsid")));
				rs1=DBUtils.executeQuery(strQuery); 
			}
			if(rs1.next())
			{
				strOccupation=Helper.correctNull(rs1.getString("cust_occp_code"));
			}
			if(!strOccupation.equalsIgnoreCase("MIGR"))
			{
				if(rs1!=null)
					rs1.close();
				rs1=DBUtils.executeLAPSQuery("selkyc_kycActivity^"+Helper.correctNull(rs.getString("perapp_id")));
				if(rs1.next())
				{
					strOccupation=Helper.correctNull(rs1.getString("kyc_occupationcode"));
				}
			}	
		}
		
		hshRecord.put("strOccupationCode",strOccupation);
		
	 } 
	catch(Exception ce)
	{
		throw new EJBException("Error in getSolDetails "+ce.toString());
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
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}

	return hshRecord; 
	
}
  public HashMap getBankerDetails(HashMap hshRequestValues) 
  {
	String strQuery = null;
	ResultSet rs = null,rs1=null;
	HashMap hshRecord = new HashMap();
	ArrayList arrValues = new ArrayList();
	ArrayList arrRow = new ArrayList();
	String strAppno=correctNull((String)hshRequestValues.get("txt_applno"));
	String strAppid=correctNull((String)hshRequestValues.get("hidoldId"));
	try
	{	
		strQuery = SQLParser.getSqlQuery("sel_bankerdetails^"+strAppid);
		rs=DBUtils.executeQuery(strQuery);
		
		 while(rs.next())
		  { 
			 arrValues = new ArrayList();
			 arrValues.add(Helper.correctNull((String)rs.getString("BANKER_APPL_NO")));
			 arrValues.add(Helper.correctNull((String)rs.getString("BANKER_STATUS")));
			 arrValues.add(Helper.correctNull((String)rs.getString("BANKER_APPLNHOLDER")));
			 arrValues.add(Helper.correctNull((String)rs.getString("BANKER_APPID")));
			 arrValues.add(Helper.correctNull((String)rs.getString("BANKER_APPLICANT_NAME")));
			 arrRow.add(arrValues);
		 }
		
	  hshRecord.put("arrRow", arrRow);
	  
	    strQuery=SQLParser.getSqlQuery("sel_processAppl_banker^"+strAppid);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshRecord.put("str_approvedAppl_demoid","Y");
		}
		else
		{
			hshRecord.put("str_approvedAppl_demoid","N");
		}
		String strOccupation="";
		
		if(rs!=null)
			rs.close();
		strQuery=SQLParser.getSqlQuery("selrenewappid^"+strAppid);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
			{
				strQuery=SQLParser.getCBSSqlQuery("cbscusmastersearch_newconnection^"+Helper.correctNull(rs.getString("perapp_cbsid")));
				rs1=DBUtils.executeQueryCBSConnection(strQuery);
			}
			else
			{
				strQuery= SQLParser.getSqlQuery("cbscusmastersearch^"+Helper.correctNull(rs.getString("perapp_cbsid")));
				rs1=DBUtils.executeQuery(strQuery); 
			}
			if(rs1.next())
			{
				strOccupation=Helper.correctNull(rs1.getString("cust_occp_code"));
			}
			if(!strOccupation.equalsIgnoreCase("MIGR"))
			{
				if(rs1!=null)
					rs1.close();
				rs1=DBUtils.executeLAPSQuery("selkyc_kycActivity^"+Helper.correctNull(rs.getString("perapp_id")));
				if(rs1.next())
				{
					strOccupation=Helper.correctNull(rs1.getString("kyc_occupationcode"));
				}
			}	
		}
		
		hshRecord.put("strOccupationCode",strOccupation);
		
	 } 
	catch(Exception ce)
	{
		throw new EJBException("Error in getBankerDetails "+ce.toString());
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
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}

	return hshRecord; 
	}


  public void updateKpowAction(HashMap hshValues) 
	{
		HashMap hshqueryval =new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		
		
		ArrayList arrValues=new ArrayList();
		ResultSet rs = null;
		String strAction="";
		String strFromuserid="";
		String strTouserid="";
		String strFromflwpoint="";
		String strToflowpoint="";
		String strappno="";
		String strQuery="";
		String strCurdate="";
		String strToflwpoint="";
		String strExcep="$";
		String strAppid="";
		String appstatus="";
		String strApplStatus="";
		try
		{
	    strAction=correctNull((String)hshValues.get("hidAction"));
	    strFromuserid=correctNull((String)hshValues.get("txt_usrid"));
	    strTouserid=correctNull((String)hshValues.get("hidmail_tousrid"));
	    strFromflwpoint=correctNull((String)hshValues.get("txt_from_flwpt")); 
	    strToflwpoint=correctNull((String)hshValues.get("mail_toflowpoint")); 
	    strappno = Helper.correctNull((String) hshValues.get("hidAppno"));
	    strAppid=Helper.correctNull((String) hshValues.get("hidDemoId"));
	    appstatus=Helper.correctNull((String) hshValues.get("strappstatus"));
	    String strUserID=Helper.correctNull((String)hshValues.get("strUserId"));
	    String strcomments=correctNull((String)hshValues.get("txt_sanctioncomments")); 
	    strCurdate=Helper.getCurrentDateTime();
	    
		if(strAction!=null && strAction.equalsIgnoreCase("send"))	
		{
			hshQuery.put("strQueryId","ins_appmailbox_kpow");
			arrValues.add(strappno);
			arrValues.add(strFromuserid);
			arrValues.add(strTouserid);
		    arrValues.add("C");
			arrValues.add(strFromflwpoint);
			arrValues.add(strToflwpoint);
			arrValues.add("");
			String strOrgScode="",strDept="";
			strQuery=SQLParser.getSqlQuery("workflowusersanlimit^"+strTouserid);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strOrgScode=Helper.correctNull(rs.getString("org_scode"));
				if(Helper.correctNull(rs.getString("org_level")).equalsIgnoreCase("D"))
					strDept=Helper.correctNull(rs.getString("usr_rlpftype"));
				else if(Helper.correctNull(rs.getString("org_level")).equalsIgnoreCase("C"))
					strDept=Helper.correctNull(rs.getString("usr_department"));
			}
			
			arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
			if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
				arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
			else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
				arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
			else
				arrValues.add("");

			arrValues.add(strOrgScode);
			arrValues.add(strDept);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","updt_addkbow");
			arrValues.add("Y");
			arrValues.add(strTouserid);
			arrValues.add(strcomments);
			arrValues.add(strappno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","2");
			hshQueryValues.put("2",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
		}
		
		if(strAction.equalsIgnoreCase("approve") || strAction.equalsIgnoreCase("reject"))
		{
			if(strAction.equalsIgnoreCase("approve"))
			{
				String strAppUserID="";
				strQuery=SQLParser.getSqlQuery("sel_addkbowerdetails^"+strAppid+"^"+strappno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strAppUserID=Helper.correctNull((String)rs.getString("addkbow_usrid"));
				}
				if(strAppUserID.equals(strUserID))
				{
					strExcep=strExcep+"You cannot Sanction the K-Power you created";
					throw new Exception(strExcep);
				}
			}
			
			String strReferenceno=getSanctionRefernceNumberKpow(hshValues);
          
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","updt_addkbowdetail_status");
			
	        if(strAction.equalsIgnoreCase("approve"))
			{
			  arrValues.add("PA");
			}
			else
			{
			  arrValues.add("PR");
			}
	        arrValues.add(strcomments);
			arrValues.add(strappno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
		
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","ins_appmailbox_kpow");
			arrValues.add(strappno);
			arrValues.add(strFromuserid);
			arrValues.add(strFromuserid);
			arrValues.add("");
			arrValues.add(hshValues.get("hidcurrflowpoint"));
			if(strAction.equalsIgnoreCase("approve"))
			{
				arrValues.add("9");
			}
			else
			{
				arrValues.add("17");
			}
			arrValues.add("");
			arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
			if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
				arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
			else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
				arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
			else
				arrValues.add("");
			arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
			if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
				arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
			else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
				arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
			else
				arrValues.add("");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","2");
			hshQueryValues.put("2",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		
		}
		if(strAction.equalsIgnoreCase("undo"))
		{
			HashMap hshRecord = new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			
			strQuery = SQLParser.getSqlQuery("sel_addkbowerdetails^"+strAppid+"^"+strappno);
			rs = DBUtils.executeQuery(strQuery);	
	                if(rs.next())
	               {
	                	hshRecord.put("addkbow_status",correctNull(rs.getString("addkbow_status")));
	                	strApplStatus=correctNull(rs.getString("addkbow_status"));
	               }
			
		   if(strApplStatus.equalsIgnoreCase("PR") || strApplStatus.equalsIgnoreCase("PA"))
			{
				hshQuery.put("strQueryId","updt_addkbow_status");
				arrValues.add("OP");
				arrValues.add(strappno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		   
		    hshqueryval = new HashMap();
			hshquery = new HashMap();		
			arrValues=new ArrayList();
			hshquery.put("strQueryId","del_com_referencenum");
			arrValues.add(strappno);
			hshquery.put("arrValues",arrValues);
			hshqueryval.put("1",hshquery);
			hshqueryval.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
		   
		   
		    hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","upt_addkbow_undo");
			arrValues.add(strUserID);
			arrValues.add("Y");
			arrValues.add(strappno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
				
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
		
		}finally
		{
			try
			{
				if(rs!=null)
					rs.close();
			}catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection "+ exp.toString()); 
			}
		}
	}
	
  
  public HashMap getkpowDetails(HashMap hshRequestValues) 
  {
	String strQuery = null;
	ResultSet rs = null,rs1=null;
	HashMap hshRecord = new HashMap();
	ArrayList arrValues = new ArrayList();
	ArrayList arrRow = new ArrayList();
	String strAppno=correctNull((String)hshRequestValues.get("txt_applno"));
	String strAppid=correctNull((String)hshRequestValues.get("hidoldId"));
	try
	{	
		strQuery = SQLParser.getSqlQuery("sel_kpowdetails^"+strAppid);
		rs=DBUtils.executeQuery(strQuery);
		
		 while(rs.next())
		  { 
			 arrValues = new ArrayList();
			 arrValues.add(Helper.correctNull((String)rs.getString("addkbow_app_no")));
			 arrValues.add(Helper.correctNull((String)rs.getString("addkbow_status")));
			 arrValues.add(Helper.correctNull((String)rs.getString("addkbow_applnholder")));
			 arrValues.add(Helper.correctNull((String)rs.getString("addkbow_app_id")));
			 arrRow.add(arrValues);
		 }
		 
		strQuery=SQLParser.getSqlQuery("sel_processAppl_kpower^"+strAppid);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshRecord.put("str_approvedAppl_demoid","Y");
		}
		else
		{
			hshRecord.put("str_approvedAppl_demoid","N");
		}
		
		
		String strOccupation="";
		
		if(rs!=null)
			rs.close();
		strQuery=SQLParser.getSqlQuery("selrenewappid^"+strAppid);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
			{
				strQuery=SQLParser.getCBSSqlQuery("cbscusmastersearch_newconnection^"+Helper.correctNull(rs.getString("perapp_cbsid")));
				rs1=DBUtils.executeQueryCBSConnection(strQuery);
			}
			else
			{
				strQuery= SQLParser.getSqlQuery("cbscusmastersearch^"+Helper.correctNull(rs.getString("perapp_cbsid")));
				rs1=DBUtils.executeQuery(strQuery); 
			}
			if(rs1.next())
			{
				strOccupation=Helper.correctNull(rs1.getString("cust_occp_code"));
			}
			if(!strOccupation.equalsIgnoreCase("MIGR"))
			{
				if(rs1!=null)
					rs1.close();
				rs1=DBUtils.executeLAPSQuery("selkyc_kycActivity^"+Helper.correctNull(rs.getString("perapp_id")));
				if(rs1.next())
				{
					strOccupation=Helper.correctNull(rs1.getString("kyc_occupationcode"));
				}
			}	
		}
		
		hshRecord.put("strOccupationCode",strOccupation);
		
	  hshRecord.put("arrRow", arrRow);
	 } 
	catch(Exception ce)
	{
		throw new EJBException("Error in getkpowDetails "+ce.toString());
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
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}

	return hshRecord; 
	
}
    public void getSaveSolvency(HashMap hshSaveValues)
	{
		
		String strAppno = "";
		String strQuery=null;
		ResultSet rs = null;
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues = new ArrayList();
		int intCounter = 0;
		String strAppstatus="",strAppid="";
		try
		{	
			strAppno=(String)hshSaveValues.get("strappno");
			strAppid=(String)hshSaveValues.get("hidDemoId");
			strQuery = SQLParser.getSqlQuery("sel_com_solvency^"+strAppid+"^"+strAppno);
			
			rs = DBUtils.executeQuery(strQuery);	
	                if(rs.next())
	               {
	                	hshQuery.put("sol_status",correctNull(rs.getString("sol_status")));
	                	strAppstatus=correctNull(rs.getString("sol_status"));
	               }
			
			strAppstatus=strAppstatus.equalsIgnoreCase("PA")?"Processed/Approved":strAppstatus.equalsIgnoreCase("PR")?"Processed/Rejected":strAppstatus;
			
			if(strAppstatus.equalsIgnoreCase("Processed/Approved") || strAppstatus.equalsIgnoreCase("Processed/Rejected"))
			{
				hshQuery.put("strQueryId","updtsolvencyclosed");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(++intCounter),hshQuery);
				hshQueryValues.put("size",String.valueOf(intCounter));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
		}
	}	
    
    
    public void getSaveKpower(HashMap hshSaveValues)
	{
		
		String strAppno = "";
		String strQuery=null;
		ResultSet rs = null;
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues = new ArrayList();
		int intCounter = 0;
		String strAppstatus="",strAppid="";
		try
		{	
			strAppno=(String)hshSaveValues.get("hidAppno");
			strAppid=(String)hshSaveValues.get("hidDemoId");
			strQuery = SQLParser.getSqlQuery("sel_com_solvency^"+strAppid+"^"+strAppno);
			
			strQuery = SQLParser.getSqlQuery("sel_addkbowerdetails^"+ strAppid + "^" +strAppno);
			rs = DBUtils.executeQuery(strQuery);	
                if(rs.next())
               {
                	hshQuery.put("addkbow_status",correctNull(rs.getString("addkbow_status")));
                	strAppstatus=correctNull(rs.getString("addkbow_status"));
               }
	                
			strAppstatus=strAppstatus.equalsIgnoreCase("PA")?"Processed/Approved":strAppstatus.equalsIgnoreCase("PR")?"Processed/Rejected":strAppstatus;
			
			if(strAppstatus.equalsIgnoreCase("Processed/Approved") || strAppstatus.equalsIgnoreCase("Processed/Rejected"))
			{
				hshQuery.put("strQueryId","updtkpowclosed");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(++intCounter),hshQuery);
				hshQueryValues.put("size",String.valueOf(intCounter));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
		}
	}
    
    public String getSanctionRefernceNumberKpow(HashMap hshValues) 
	{
		String strRefno="";
		String strAppno="";
		String strSolid="";
		String strFinancialYear="";
		String strDateofSanc="";
		String strOrgLevel="";
		String strOrgCode="";
		String strCPCCode="";
		String strUserId="";
		String strSancAuthority="";
		String strSancAuthorityCode="";
		String strUserDepartment="";
		String strUserDesignation="";
		String strBifur="/";
		ResultSet rs=null;
		String strSno="";
		ArrayList arrValues=new ArrayList();
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		String strFinancialYear1="",strFinancialYear2="";
		String strQuery="";
		String strFinacleSancRefNo="",strAction="",Appstatus="",StrModuleType="";
		try
		{
			strAction=Helper.correctNull((String)hshValues.get("hidAction"));
			if(strAction.equalsIgnoreCase("approve"))
			{
				Appstatus="A";
			}
			else if(strAction.equalsIgnoreCase("reject"))
			{
				Appstatus="R";
			}
			strAppno=Helper.correctNull((String)hshValues.get("hidAppno"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)hshValues.get("appno"));
			}
			strSolid=Helper.correctNull((String)hshValues.get("strSolid"));
			strOrgLevel=Helper.correctNull((String)hshValues.get("strOrgLevel"));
//			strOrgLevel="KPOW";
			strOrgCode=Helper.correctNull((String)hshValues.get("strOrgCode"));
			strUserDepartment=Helper.correctNull((String)hshValues.get("strUserDepartment"));
			strUserId=Helper.correctNull((String)hshValues.get("strUserId"));
			strCPCCode=strOrgCode.substring(0,6);
			StrModuleType=Helper.correctNull((String)hshValues.get("sessionModuleType"));
			if(!(strSolid.equalsIgnoreCase("") || strAppno.equalsIgnoreCase("")))
			{
				strFinancialYear=Helper.financialYear();
				rs=DBUtils.executeLAPSQuery("selCurrentdate");
				if(rs.next())
				{
					strDateofSanc=Helper.correctNull((String)rs.getString("currentdate1"));
				}
				if(rs.next())
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("setuserssel^"+strUserId);
				if(rs.next())
				{
					strSancAuthorityCode=Helper.correctNull((String)rs.getString("user_designation"));
				}
				if(rs.next())
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("selcbsiddatadesc^27^"+strSancAuthorityCode);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strSancAuthority=Helper.correctNull((String)rs.getString("cbs_static_data_passing_code"));
				}
				if(rs !=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("selfinancialyear");
				if(rs.next())
				{
					strFinancialYear=Helper.correctNull((String)rs.getString("FinancialYear"));
					strFinancialYear1=strFinancialYear.substring(0,5);
					strFinancialYear2=strFinancialYear.substring(7,9);
					strFinancialYear=strFinancialYear1+strFinancialYear2;
				}
				
				
				
				if(rs!=null)
				{rs.close();}
				String SanctioningAuthority="",Sanction_Ref_Num="",Sanction_dep="",strFRefno="",strSancBranch="";
				{
					rs=DBUtils.executeLAPSQuery("sel_kpow_comments^"+strAppno);
					if(rs.next())
					{
						SanctioningAuthority=correctNull(rs.getString("addkbow_Sanctioned"));
						Sanction_Ref_Num=correctNull(rs.getString("Sanc_Ref_No"));
						Sanction_dep=correctNull(rs.getString("ADDKBOW_SANCTIONING_DEPT"));
						strSancBranch=correctNull(rs.getString("ADDKBOW_SANCTIONING_BRANCH"));
					}
				}
				
				if(strOrgLevel.equalsIgnoreCase("C"))
				{
					strUserDepartment="";
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("sel_cbsstaticdescbycode^"+"131"+"^"+strSancBranch);
					if(rs.next())
					{
						strUserDepartment=Helper.correctNull((String)rs.getString("CBS_STATIC_SANC_REFNO"));
					}
					strRefno=strSancAuthority+strBifur+strUserDepartment+strBifur+strSolid+strBifur;
					strFRefno=strSancAuthority+strBifur+strUserDepartment+strBifur+strSolid+strBifur;
				}
				else if(strCPCCode.equalsIgnoreCase("001001") && strOrgLevel.equalsIgnoreCase("R"))
				{
					strRefno="CPC"+strSancAuthority+strBifur;
					strFRefno="CPC"+strSancAuthority+strBifur;
				}
				else if(strOrgLevel.equalsIgnoreCase("R"))
				{
					strRefno=strSancAuthority+strBifur+strSolid+strBifur;
					strFRefno=strSancAuthority+strBifur+strSolid+strBifur;
				}
				else if(strOrgLevel.equalsIgnoreCase("D") && Helper.correctNull((String)hshValues.get("strRLPFUser")).equalsIgnoreCase("012"))
				{
					strUserDepartment="";
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("sel_cbsstaticdescbycode^"+"130"+"^"+Sanction_dep);
					if(rs.next())
					{
						strUserDepartment=Helper.correctNull((String)rs.getString("CBS_STATIC_SANC_REFNO"));
					}
					strRefno=strSancAuthority+strBifur+strUserDepartment+strBifur+strSolid+strBifur;
					strFRefno=strSancAuthority+strBifur+strUserDepartment+strBifur+strSolid+strBifur;
				}
				else if(strOrgLevel.equalsIgnoreCase("A"))
				{					
					strRefno=strSancAuthority+strBifur+strSolid+strBifur;
					strFRefno=strSancAuthority+strBifur+strSolid+strBifur;
				}
				if(rs!=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("selsolreferencenumsno^"+strOrgLevel+"^"+strFinancialYear);
				if(rs.next())
				{
					strSno=Helper.correctNull((String)rs.getString("ars_sno"));
				}
				
				int intsno=Integer.parseInt(strSno);
				intsno=++intsno;
				strSno=Integer.toString(intsno);
				strRefno=strRefno+strSno+strBifur+strFinancialYear+strBifur+strDateofSanc;	
				strFinacleSancRefNo=strFRefno+strSno+strBifur+strFinancialYear;
				
				if(Sanction_dep.equalsIgnoreCase("011"))
				{
					strRefno="CPC"+strSancAuthority+strBifur+strSno+strBifur+strFinancialYear+strBifur+strDateofSanc;
					strFinacleSancRefNo="CPC"+strSancAuthority+strBifur+strSno+strBifur+strFinancialYear;
				}
				else if(Sanction_dep.equalsIgnoreCase("012"))
				{
					
					String strRLPCCode="CLPH",strOrgScode=strSolid;
					
					if((strOrgScode.substring(0, 1)).equalsIgnoreCase("R"))
						strOrgScode=strOrgScode.substring(1, strOrgScode.length());
					
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("sel_cbsstaticdescbycode^130^"+Sanction_dep);
					if(rs.next())
					{
						strRLPCCode=Helper.correctNull(rs.getString("cbs_static_sanc_refno"));
					}
					
					strRefno=strSancAuthority+strBifur+strRLPCCode+strBifur+strOrgScode+strBifur+strSno+strBifur+strFinancialYear+strBifur+strDateofSanc;
					strFinacleSancRefNo=strSancAuthority+strBifur+strRLPCCode+strBifur+strOrgScode+strBifur+strSno+strBifur+strFinancialYear;
				}
				
				if((SanctioningAuthority.equalsIgnoreCase("14")|| SanctioningAuthority.equalsIgnoreCase("15")||SanctioningAuthority.equalsIgnoreCase("16")))
				{
					strRefno=Sanction_Ref_Num;
					strFinacleSancRefNo=Sanction_Ref_Num;
				}
				
				hshQueryValues.put("size","1");
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insreferencenumsolvency");
				arrValues.add(strAppno);
				arrValues.add(strSolid);
				arrValues.add(strFinancialYear);
				arrValues.add(strOrgLevel);
				arrValues.add(strSno);
				arrValues.add(strRefno);
				arrValues.add(Appstatus);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in generating Sanction Reference Number.."+e);
		}
		return strRefno;
	}
    
    public HashMap updateBankersData(HashMap hsh)  
	{
		HashMap hshqueryval =new HashMap();
		HashMap hshquery = new HashMap();
		ArrayList arr = new ArrayList();
		ResultSet rs = null;
		String strQuery="",strbankmaxno="";
		int  strsno=0;
		String  strAction="";
		String OrgCode="",
		       strAppno="",
		       struserid="",
		       strOrgcode="",
		       year="",
		       strAppnum="",
		       strOldid=""; 
		int month=0;
		int year1=0;
		int year2=0;
		String StrCertificateNo="";
		try
		{
			String strcertno="";
			strAction=correctNull((String)hsh.get("hidAction"));
			struserid=correctNull((String)hsh.get("txt_usrid"));
			strOrgcode=correctNull((String)hsh.get("strOrgCode"));
			strAppnum=correctNull((String)hsh.get("txt_applno"));
			
			java.text.NumberFormat nf1 = java.text.NumberFormat
			.getNumberInstance();
			nf1.setGroupingUsed(false);
			nf1.setMaximumFractionDigits(2);
			nf1.setMinimumFractionDigits(2);
			
			
			if(strAppnum.equalsIgnoreCase(""))
			{
				strAppnum=correctNull((String)hsh.get("hidapplno"));	
			}
			strAppno=correctNull((String)hsh.get("strappno"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=correctNull((String)hsh.get("hidapplno"));	
			}
			
			strOldid=correctNull((String)hsh.get("old_appid"));
			
					
			OrgCode=Helper.correctNull((String)hsh.get("strSolid"));
			String strsolid=Helper.correctNull((String)hsh.get("strSolid"));

			String code="";
			if(FwHelper.correctNull((String)hsh.get("sel_sanctionfor")).equalsIgnoreCase("BC"))
			{
				code="BC";
			}
			if(FwHelper.correctNull((String)hsh.get("sel_sanctionfor")).equalsIgnoreCase("LC"))
			{
				code="LC";
			}
			String strLoanProcFee="";
			
			if(FwHelper.correctNull((String)hsh.get("sel_sanctionfor")).equalsIgnoreCase(""))
			{
			if(strAppnum.contains("BC"))
			{
				hsh.put("sel_sanctionfor", "BC");
			}
			else if(strAppnum.contains("LC"))
			{
				hsh.put("sel_sanctionfor", "LC");
			}
			}
			if(FwHelper.correctNull((String)hsh.get("sel_sanctionfor")).equalsIgnoreCase("BC"))
			{
			HashMap hshTemp = new HashMap();
		     
			hshTemp.put("prdcode", "6");
		       hshTemp.put("recamt",Helper.correctNull((String)hsh.get("txt_amtrs")));
		       hshTemp.put("appno", strAppno);
		       HashMap hshGetDocFee = (HashMap) EJBInvoker.executeStateLess("perlimitofloan", hshTemp, "getSolvencyDocFee");
		       double procfee1 = Math.ceil(Double.parseDouble(Helper.correctDouble((String) hshGetDocFee.get("procfee"))));
				 strLoanProcFee=String.valueOf(procfee1);
				
			}
			
			
			if(FwHelper.correctNull((String)hsh.get("sel_sanctionfor")).equalsIgnoreCase("LC"))
			{
			HashMap hshTemp = new HashMap();
		       hshTemp.put("prdcode", "7");
		       hshTemp.put("recamt",Helper.correctNull((String)hsh.get("txt_amtrs")));
		       hshTemp.put("appno", strAppno);
		       HashMap hshGetDocFee = (HashMap) EJBInvoker.executeStateLess("perlimitofloan", hshTemp, "getSolvencyDocFee");
		       double procfee1 = Math.ceil(Double.parseDouble(Helper.correctDouble((String) hshGetDocFee.get("procfee"))));
				 strLoanProcFee=String.valueOf(procfee1);
				
			}

					 String OrgCode1="";
			if(strAppno.equalsIgnoreCase("") && strAction.equalsIgnoreCase("new"))
		    {	
				int scodeLength=OrgCode.length();
				if(scodeLength==1){
					OrgCode1="000"+OrgCode;
				}
				if(scodeLength==2){
					OrgCode1="00"+OrgCode;
				}
				if(scodeLength==3){
					OrgCode1="0"+OrgCode;
				}
				//BANKER_SANCTION_FOR
			    rs=DBUtils.executeLAPSQuery("sel_maxid_banker^"+OrgCode1+"^"+FwHelper.correctNull((String)hsh.get("sel_sanctionfor")));
				if(rs.next())
				{
					strsno=Integer.parseInt(rs.getString("BANKER_APPL_NO"));
				}	
				
				// int applength=strsno.length();
					
				java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
						nf.setMinimumIntegerDigits(5);
						nf.setGroupingUsed(false);
						strAppno=nf.format(strsno);
				 
					 strAppno=OrgCode1+FwHelper.correctNull((String)hsh.get("sel_sanctionfor"))+strAppno;
					 
					 hsh.put("strappno",strAppno);

		    }
			if(rs!=null)
				rs.close();
			
			strQuery = SQLParser.getSqlQuery("selmon_curyear");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{ 
				month=rs.getInt("mon_curryear");
				year1=rs.getInt("curryear");
			}
			
			if(month>3)
			{
			year2=year1+1;
			year=String.valueOf(year1)+"-"+String.valueOf(year2);
			}
			else
			{
			year2=year1-1;
			year=String.valueOf(year2)+"-"+String.valueOf(year1);	
			}
			if(rs!=null)
				rs.close();
			
//			strQuery = SQLParser.getSqlQuery("sel_bank_maxno^"+strOrgcode);
//			rs=DBUtils.executeQuery(strQuery);
//			if(rs.next())
//			{ 
//				strbankmaxno=Helper.correctNull(rs.getString("BANKER_BANKERNO"));
//				strbankmaxno="000"+strbankmaxno;
//			}
			
			strbankmaxno="000"+strsno;
			StrCertificateNo=strsolid+"/"+Helper.correctNull((String)hsh.get("sel_sanctionfor"))+"-"+strbankmaxno+"/"+year;
                			     
				hshquery=new HashMap();
				arr=new ArrayList();
				if(strAction.equalsIgnoreCase("new"))
				{
				hshquery.put("strQueryId","ins_com_banker");
				arr.add(Helper.correctNull((String)hsh.get("txt_nameofappl")));
				//arr.add(Helper.correctNull((String)hsh.get("txt_purpose")));
				arr.add(nf1.format(Double.parseDouble(Helper.correctDouble(Helper.correctNull((String)hsh.get("txt_amtrs"))))));
				arr.add(nf1.format(Double.parseDouble(Helper.correctDouble(strLoanProcFee))));
				arr.add(nf1.format(Double.parseDouble(Helper.correctDouble(Helper.correctNull((String)hsh.get("txt_networth"))))));
				arr.add(Helper.correctNull((String)hsh.get("txt_existacc")));
				arr.add(StrCertificateNo);
				arr.add(Helper.correctNull((String)hsh.get("txt_issuedt")));
				arr.add(Helper.correctNull((String)hsh.get("sel_SancAuth")));
			    arr.add(Helper.correctNull((String)hsh.get("txt_address")));
				arr.add(Helper.correctNull((String)hsh.get("txt_addresstwo")));
				arr.add(Helper.correctNull((String)hsh.get("txt_village")));
				//arr.add(Helper.correctNull((String)hsh.get("hidperapp_city")));            ////txt_city//hidperapp_city
				//arr.add(Helper.correctNull((String)hsh.get("txtperapp_district")));       //txt_district//hidperapp_dist
				//txt_state//txtperapp_permstate
				//Helper.correctNull((String)hsh.get("txt_city"))
				
				//String city ="";
				rs=DBUtils.executeLAPSQuery("sel_citynamebycode1^"+Helper.correctNull((String)hsh.get("txt_city")));
				if(rs.next())
				{
					//city=correctNull(rs.getString("city_code"));
					arr.add(correctNull(rs.getString("city_code")));
				}
				else
				{
					arr.add(Helper.correctNull((String)hsh.get("txt_city")));
				}
				if(rs!=null)
				{
					rs.close();
				}
				
				
				
				
				//arr.add(Helper.correctNull((String)hsh.get("txtperapp_district"))); 
				
				rs=DBUtils.executeLAPSQuery("sel_distnamebycode1^"+Helper.correctNull((String)hsh.get("txt_district")));
				if(rs.next())
				{
					arr.add(correctNull(rs.getString("district_code")));
				}
				else
				{
					arr.add(correctNull(rs.getString("txt_district")));
				}
				if(rs!=null)
				{
					rs.close();
				}
				
				
				//arr.add(Helper.correctNull((String)hsh.get("txt_state")));
				
				rs=DBUtils.executeLAPSQuery("sel_statenamebycode1^"+Helper.correctNull((String)hsh.get("txt_state")));
				if(rs.next())
				{
					arr.add(correctNull(rs.getString("state_code")));
				}
				else
				{
					arr.add(correctNull(rs.getString("txt_state")));
				}
				if(rs!=null)
				{
					rs.close();
				}
				
				
				
				arr.add(Helper.correctNull((String)hsh.get("txt_permzip")));
				
				
				//arr.add(Helper.correctNull((String)hsh.get("hidperapp_country")));
				
				rs=DBUtils.executeLAPSQuery("sel_countrynamebycode1^"+Helper.correctNull((String)hsh.get("txtperapp_country")));
				if(rs.next())
				{
					arr.add(correctNull(rs.getString("con_countrycode")));
				}
				else
				{
					arr.add(correctNull(rs.getString("txtperapp_country")));
				}
				if(rs!=null)
				{
					rs.close();
				}
				
				
				arr.add(Helper.correctNull((String)hsh.get("txt_cbsid")));
				arr.add(Helper.correctNull((String)hsh.get("hid_appid")));
			    arr.add(strAppno);
			    arr.add(struserid);
			    arr.add(struserid);
			    arr.add("Y");
			    arr.add("BANKER");
			    arr.add(strOrgcode);
			    arr.add("OP");
			    arr.add(strOldid);
			    arr.add(Helper.correctNull((String)hsh.get("txt_solno")));
				arr.add(Helper.correctNull((String)hsh.get("sel_SancDept")));
				arr.add(Helper.correctNull((String)hsh.get("sel_SancBranch")));
				arr.add(Helper.correctNull((String)hsh.get("sanctiondate")));
				arr.add(Helper.correctNull((String)hsh.get("txt_sancrefno")));
			    arr.add(Helper.correctNull((String)hsh.get("txt_nameofben")));
			    arr.add(Helper.correctNull((String)hsh.get("txt_benfaddress")));
				arr.add(Helper.correctNull((String)hsh.get("txt_benfaddresstwo")));
				//txt_benfCity //hid_City
				//arr.add(Helper.correctNull((String)hsh.get("txt_benfCity")));//hid_City")));
				
				rs=DBUtils.executeLAPSQuery("sel_citynamebycode1^"+Helper.correctNull((String)hsh.get("txt_benfCity")));
				if(rs.next())
				{
					arr.add(correctNull(rs.getString("city_code")));
				}
				else
				{
					arr.add(correctNull(rs.getString("txt_benfCity")));
				}
				if(rs!=null)
				{
					rs.close();
				}
				
				
				
				//txt_benfState //hidstate
				
				rs=DBUtils.executeLAPSQuery("sel_statenamebycode1^"+Helper.correctNull((String)hsh.get("txt_benfState")));
				if(rs.next())
				{
					arr.add(correctNull(rs.getString("state_code")));
				}
				else
				{
					arr.add(correctNull(rs.getString("txt_benfState")));
				}
				if(rs!=null)
				{
					rs.close();
				}
				
				//arr.add(Helper.correctNull((String)hsh.get("hid_State")));
				//txt_benfDistrict//hid_District
				
				
				//arr.add(Helper.correctNull((String)hsh.get("hid_District")));
				
				
				rs=DBUtils.executeLAPSQuery("sel_distnamebycode1^"+Helper.correctNull((String)hsh.get("txt_benfDistrict")));
				if(rs.next())
				{
					arr.add(correctNull(rs.getString("district_code")));
				}
				else
				{
					arr.add(correctNull(rs.getString("txt_benfDistrict")));
				}
				if(rs!=null)
				{
					rs.close();
				}
				
				
				
				arr.add(Helper.correctNull((String)hsh.get("sel_sanctionfor")));
				arr.add(Helper.correctNull((String)hsh.get("txt_breifworkdet")));
				 arr.add(strbankmaxno);
				 
				 arr.add(Helper.correctNull((String)hsh.get("txt_ten_not_date")));
				 arr.add(Helper.correctNull((String)hsh.get("txt_cutoffsubdate")));
				 arr.add(Helper.correctNull((String)hsh.get("txt_tenopendate")));
				 arr.add(Helper.correctNull((String)hsh.get("txt_indentno")));
				 arr.add(Helper.correctNull((String)hsh.get("txt_valoftender")));
				 arr.add(Helper.correctNull((String)hsh.get("txt_typeofbef")));
				 
				 arr.add(nf1.format(Double.parseDouble(Helper.correctDouble(Helper.correctNull((String)hsh.get("txt_appcommissionearn"))))));
				 
				/* boolean issueflag=false;
				 boolean tendooropoendate=false;
				 Date d1  =new SimpleDateFormat("dd/MM/yyyy").parse(Helper.correctNull((String)hsh.get("txt_issuedt")));
				    Date d2 = new SimpleDateFormat("dd/MM/yyyy").parse(Helper.correctNull((String)hsh.get("txt_ten_not_date")));
				      
				    if(d1.compareTo(d2)>0)
				    {
				    	issueflag=true;	
				    }
				    else
				    {
				    	tendooropoendate=true;
				    }
				    
//				    if(d1.compareTo(d2)==0)
//				    {
//				    	issueflag=true;	
//				    }
				    
				    
				 String expdatelimit="";
				 rs=DBUtils.executeLAPSQuery("selstatdatabyidexpired");
					if(rs.next())
					{
						expdatelimit=correctNull(rs.getString("stat_data_desc1"));
					}
						if(rs!=null)
						{
							rs.close();
						}
						
						if(issueflag)
						{
					 Date dateWithValDays2=new SimpleDateFormat("dd/MM/yyyy").parse(Helper.correctNull((String)hsh.get("txt_ten_not_date")));  
					 Calendar cal221 = Calendar.getInstance();
					 cal221.setTime(dateWithValDays2);
					 
						//cal.add(Calendar.DATE, noofdays2); 
						//Date dateWithValDays2 = cal.getTime();
						
						
						System.out.println("dateWithValDays2===="+dateWithValDays2);
						
					int noofdays=Integer.parseInt(expdatelimit);
					//cal.add(Calendar.DATE, noofdays); 
					//Date dateWithValDays = cal.getTime();
					
		              DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
//		            Calendar c = Calendar.getInstance();
					cal221.add(Calendar.DATE, noofdays);
		            System.out.println(dateFormat.format(cal221.getTime()));
		          arr.add(""+dateFormat.format(cal221.getTime()));
						}
						
						
						if(tendooropoendate)
						{
					 Date dateWithValDays2=new SimpleDateFormat("dd/MM/yyyy").parse(Helper.correctNull((String)hsh.get("txt_issuedt")));  
					 Calendar cal221 = Calendar.getInstance();
					 cal221.setTime(dateWithValDays2);
					 
						//cal.add(Calendar.DATE, noofdays2); 
						//Date dateWithValDays2 = cal.getTime();
						
						
						System.out.println("dateWithValDays2===="+dateWithValDays2);
						
					int noofdays=Integer.parseInt(expdatelimit);
					//cal.add(Calendar.DATE, noofdays); 
					//Date dateWithValDays = cal.getTime();
					
		              DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
//		            Calendar c = Calendar.getInstance();
					cal221.add(Calendar.DATE, noofdays);
		            System.out.println(dateFormat.format(cal221.getTime()));
		          arr.add(""+dateFormat.format(cal221.getTime()));
						}*/
		              
  		            
				 
				 //arr.add("");//Helper.correctNull((String)hsh.get("txt_appcommissionearn")));expirydate
				 arr.add(Helper.correctNull((String)hsh.get("txt_valdays")));//vality days
				 arr.add(Helper.correctNull((String)hsh.get("sel_reasonforcharges")));//charges reason 
				 
				 
				 arr.add(Helper.correctNull((String)hsh.get("txt_count")));//txt_count
				 arr.add(nf1.format(Double.parseDouble(Helper.correctDouble(Helper.correctNull((String)hsh.get("txt_sanlim"))))));//txt_sanlim
				 arr.add(Helper.correctNull((String)hsh.get("txt_expcount")));//txt_expcount
				 arr.add(nf1.format(Double.parseDouble(Helper.correctDouble(Helper.correctNull((String)hsh.get("txt_explim"))))));//txt_explim
				 
				 
				 
			    hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				hshqueryval.put("size","1");
				
				
				
				
				int strsno1=0;
				rs=DBUtils.executeLAPSQuery("maxsel_bankcerhisvalmax^"+strAppno);
				if(rs.next())
				{
					strsno1=Integer.parseInt(rs.getString("com_bank_sno"));
				}	
						
				
				strQuery = SQLParser.getSqlQuery("select_networth_cusprofile^"+Helper.correctNull((String)hsh.get("hid_appid")));
				rs=DBUtils.executeQuery(strQuery);
				 String perapp_cbsid="";
				if(rs.next()){
					//networth=Double.parseDouble(Helper.correctDouble(rs.getString("PERAPP_NETWORTH")));
					perapp_cbsid=Helper.correctNull(rs.getString("perapp_cbsid"));
				}
				
				HashMap hshQuery=new HashMap();
				ArrayList arrValues=new ArrayList();
				HashMap hshQueryValues=new HashMap();
				
				
				 hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","sel_ins_bankcer_history");
				arrValues.add(strAppno);
				arrValues.add(Helper.correctNull((String)hsh.get("hid_appid")));
				arrValues.add(struserid);
				arrValues.add(perapp_cbsid);
				arrValues.add("OP");			
				arrValues.add("");//ACTIVE");
				arrValues.add(""+strsno1);
				arrValues.add("Fresh");
				arrValues.add(struserid);
				arrValues.add(struserid);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
				
				}
				else if(strAction.equalsIgnoreCase("insert"))
				{
					hshquery.put("strQueryId","upd_com_banker");
					//arr.add(Helper.correctNull((String)hsh.get("txt_purpose")));
					arr.add(nf1.format(Double.parseDouble(Helper.correctDouble(Helper.correctNull((String)hsh.get("txt_amtrs"))))));
					arr.add(nf1.format(Double.parseDouble(Helper.correctDouble(strLoanProcFee))));
					arr.add(Helper.correctNull((String)hsh.get("txt_existacc")));
					arr.add(Helper.correctNull((String)hsh.get("txt_issuedt")));
					arr.add(Helper.correctNull((String)hsh.get("sel_SancAuth")));
					//arr.add(StrCertificateNo);
					arr.add(Helper.correctNull((String)hsh.get("txt_solno")));
					arr.add(Helper.correctNull((String)hsh.get("sel_SancDept")));
					arr.add(Helper.correctNull((String)hsh.get("sel_SancBranch")));
					arr.add(Helper.correctNull((String)hsh.get("sanctiondate")));
					arr.add(Helper.correctNull((String)hsh.get("txt_sancrefno")));
					arr.add(Helper.correctNull((String)hsh.get("txt_nameofben")));
				    arr.add(Helper.correctNull((String)hsh.get("txt_benfaddress")));
					arr.add(Helper.correctNull((String)hsh.get("txt_benfaddresstwo")));
					//arr.add(Helper.correctNull((String)hsh.get("txt_benfCity")));   //txt_City")));
					rs=DBUtils.executeLAPSQuery("sel_citynamebycode1^"+Helper.correctNull((String)hsh.get("txt_benfCity")));
					if(rs.next())
					{
						arr.add(correctNull(rs.getString("city_code")));
					}
					else
					{
						arr.add(correctNull(rs.getString("txt_benfCity")));
					}
					if(rs!=null)
					{
						rs.close();
					}
					
					
					
					//txt_benfState //hidstate
					
					
					//arr.add(Helper.correctNull((String)hsh.get("hid_State")));
					
					rs=DBUtils.executeLAPSQuery("sel_statenamebycode1^"+Helper.correctNull((String)hsh.get("txt_benfState")));
					if(rs.next())
					{
						arr.add(correctNull(rs.getString("state_code")));
					}
					else
					{
						arr.add(correctNull(rs.getString("txt_benfState")));
					}
					if(rs!=null)
					{
						rs.close();
					}
					
					//arr.add(Helper.correctNull((String)hsh.get("txt_benfDistrict")));
					
					rs=DBUtils.executeLAPSQuery("sel_distnamebycode1^"+Helper.correctNull((String)hsh.get("txt_benfDistrict")));
					if(rs.next())
					{
						arr.add(correctNull(rs.getString("district_code")));
					}
					else
					{
						arr.add(correctNull(rs.getString("txt_benfDistrict")));
					}
					if(rs!=null)
					{
						rs.close();
					}
					
					
					//arr.add(Helper.correctNull((String)hsh.get("sel_sanctionfor")));
					arr.add(Helper.correctNull((String)hsh.get("txt_breifworkdet")));
					arr.add(Helper.correctNull((String)hsh.get("txt_ten_not_date")));
					 arr.add(Helper.correctNull((String)hsh.get("txt_cutoffsubdate")));
					 arr.add(Helper.correctNull((String)hsh.get("txt_tenopendate")));
					 arr.add(Helper.correctNull((String)hsh.get("txt_indentno")));
					 arr.add(Helper.correctNull((String)hsh.get("txt_valoftender")));
					 arr.add(Helper.correctNull((String)hsh.get("txt_typeofbef")));
					 arr.add(nf1.format(Double.parseDouble(Helper.correctDouble(Helper.correctNull((String)hsh.get("txt_appcommissionearn"))))));
					 
					/* boolean issueflag=false;
					 boolean tendooropoendate=false;
					 Date d1 = new SimpleDateFormat("dd/MM/yyyy").parse(Helper.correctNull((String)hsh.get("txt_issuedt")));
					    Date d2 = new SimpleDateFormat("dd/MM/yyyy").parse(Helper.correctNull((String)hsh.get("txt_ten_not_date")));
					      
					    if(d1.compareTo(d2)>0)
					    {
					    	issueflag=true;	
					    }
					    else
					    {
					    	tendooropoendate=true;
					    }
					    
//					    if(d1.compareTo(d2)==0)
//					    {
//					    	issueflag=true;	
//					    }
					    
					    
					 String expdatelimit="";
					 rs=DBUtils.executeLAPSQuery("selstatdatabyidexpired");
						if(rs.next())
						{
							expdatelimit=correctNull(rs.getString("stat_data_desc1"));
						}
  						if(rs!=null)
  						{
  							rs.close();
  						}
  						
  						if(issueflag)
  						{
  					 Date dateWithValDays2=new SimpleDateFormat("dd/MM/yyyy").parse(Helper.correctNull((String)hsh.get("txt_ten_not_date")));  
  					 Calendar cal221 = Calendar.getInstance();
  					 cal221.setTime(dateWithValDays2);
  					 
  						//cal.add(Calendar.DATE, noofdays2); 
  						//Date dateWithValDays2 = cal.getTime();
  						
  						
  						System.out.println("dateWithValDays2===="+dateWithValDays2);
  						
  					int noofdays=Integer.parseInt(Helper.correctNull((String)hsh.get("txt_valdays")));
  					//cal.add(Calendar.DATE, noofdays); 
  					//Date dateWithValDays = cal.getTime();
  					
 		              DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
//  		            Calendar c = Calendar.getInstance();
  					cal221.add(Calendar.DATE, noofdays);
  		            System.out.println(dateFormat.format(cal221.getTime()));
  		          arr.add(""+dateFormat.format(cal221.getTime()));
  						}
  						
  						
  						if(tendooropoendate)
  						{
  					 Date dateWithValDays2=new SimpleDateFormat("dd/MM/yyyy").parse(Helper.correctNull((String)hsh.get("txt_issuedt")));  
  					 Calendar cal221 = Calendar.getInstance();
  					 cal221.setTime(dateWithValDays2);
  					 
  						//cal.add(Calendar.DATE, noofdays2); 
  						//Date dateWithValDays2 = cal.getTime();
  						
  						
  						System.out.println("dateWithValDays2===="+dateWithValDays2);
  						
  					int noofdays=Integer.parseInt(Helper.correctNull((String)hsh.get("txt_valdays")));//expdatelimit);
  					//cal.add(Calendar.DATE, noofdays); 
  					//Date dateWithValDays = cal.getTime();
  					
 		              DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
//  		            Calendar c = Calendar.getInstance();
  					cal221.add(Calendar.DATE, noofdays);
  		            System.out.println(dateFormat.format(cal221.getTime()));
  		          arr.add(""+dateFormat.format(cal221.getTime()));
  						}*/
					 //arr.add("");//Helper.correctNull((String)hsh.get("txt_appcommissionearn")));expirydate
					 arr.add(Helper.correctNull((String)hsh.get("txt_valdays")));//vality days
					 
					 arr.add(Helper.correctNull((String)hsh.get("sel_reasonforcharges")));//charges reason 
					 
					 arr.add(Helper.correctNull((String)hsh.get("txt_count")));//txt_count
					 arr.add(nf1.format(Double.parseDouble(Helper.correctDouble(Helper.correctNull((String)hsh.get("txt_sanlim"))))));//txt_sanlim
					 arr.add(Helper.correctNull((String)hsh.get("txt_expcount")));//txt_expcount
					 arr.add(nf1.format(Double.parseDouble(Helper.correctDouble(Helper.correctNull((String)hsh.get("txt_explim"))))));//txt_explim
					 
					 
				    arr.add(strAppno);
				    hshquery.put("arrValues",arr);
					hshqueryval.put("1",hshquery);
					hshqueryval.put("size","1");
					
					
					
					
				}
				else if(strAction.equalsIgnoreCase("delete"))
				{
					hshqueryval = new HashMap();
					hshquery = new HashMap();		
					arr=new ArrayList();
					hshquery.put("strQueryId","del_com_bankers");
					arr.add(strAppno);
					hshquery.put("arrValues",arr);
					hshqueryval.put("1",hshquery);
					hshqueryval.put("size","1");
					
					hshquery = new HashMap();		
					arr=new ArrayList();
					hshquery.put("strQueryId","del_banker_appmailbox");
					arr.add(strAppno);
					hshquery.put("arrValues",arr);
					hshqueryval.put("2",hshquery);
					hshqueryval.put("size","2");
					
					
					hshquery = new HashMap();		
					arr=new ArrayList();
					hshquery.put("strQueryId","del_com_bankerreferencenum");
					arr.add(strAppno);
					hshquery.put("arrValues",arr);
					hshqueryval.put("3",hshquery);
					hshqueryval.put("size","3");
					
					hshquery = new HashMap();		
					arr=new ArrayList();
					hshquery.put("strQueryId","delelete_com_banking_det_history");
					arr.add(strAppno);
					hshquery.put("arrValues",arr);
					hshqueryval.put("4",hshquery);
					hshqueryval.put("size","4");
										
				}
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				
				
				if(strAppnum.equalsIgnoreCase(""))
			    {	
				hshqueryval=new HashMap();
				arr=new ArrayList();
				hshquery.put("strQueryId","ins_mailbox_banker");
				arr.add(strAppno);
				arr.add(struserid);
				arr.add(struserid);
				arr.add("1");
				arr.add("1");
				arr.add("C");
				arr.add(correctNull((String)hsh.get("strOrgShortCode")));
				if(correctNull((String)hsh.get("strOrgLevel")).equalsIgnoreCase("C"))
					arr.add(correctNull((String)hsh.get("strUserDepartment")));
				else if(correctNull((String)hsh.get("strOrgLevel")).equalsIgnoreCase("D"))
					arr.add(correctNull((String)hsh.get("strRLPFUser")));
				else
					arr.add("");
				arr.add(correctNull((String)hsh.get("strOrgShortCode")));
				if(correctNull((String)hsh.get("strOrgLevel")).equalsIgnoreCase("C"))
					arr.add(correctNull((String)hsh.get("strUserDepartment")));
				else if(correctNull((String)hsh.get("strOrgLevel")).equalsIgnoreCase("D"))
					arr.add(correctNull((String)hsh.get("strRLPFUser")));
				else
					arr.add("");
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				hshqueryval.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			    }
				hsh.put("hidAction","select");
		       hsh = getBankersData(hsh);
		   
		  
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs!=null)
					rs.close();
			}catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in updateBankersData "+ exp.toString()); 
			}
		}
		return hsh;
		
	}
    public HashMap getBankersData(HashMap hshRequestValues){

		ResultSet rs = null;
		HashMap hshValues=new HashMap();
		
		HashMap hshQuery=null;
		HashMap hshQueryValues=null;
		ArrayList arrValues=null;
		String strQuery="",strQuery1,strCitycode="",strCountryCode="",strPermstatecode="",strbankmaxno="",strsanctionfor="",strCitycode1="",strCountryCode1="",strPermstatecode1="";
		String strAppid="",strDistcode="",strDistcode1="";
		String appstatus="",perapp_cbsid="";
		String strAction=Helper.correctNull((String)hshRequestValues.get("hidAction"));
		String strAppno = Helper.correctNull((String) hshRequestValues.get("strappno"));
		if(strAppno.equalsIgnoreCase(""))
		{
			strAppno = Helper.correctNull((String) hshRequestValues.get("hidApplno")); 
		}
		String strUserId=Helper.correctNull((String) hshRequestValues.get("strUserId"));
		if(strUserId.equalsIgnoreCase(""))
		{
			strUserId=Helper.correctNull((String) hshRequestValues.get("txt_usrid"));
		}
		double networth=0.0f;
		int month=0;
		int year1=0;
		int year2=0;
		String year="",StrCertificateNo="";
		
		java.text.NumberFormat jtn= java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		try
		{	
			
			strAppid=Helper.correctNull((String)hshRequestValues.get("appid"));	
			String strSolid=Helper.correctNull((String)hshRequestValues.get("strSolid"));
	 		String strorgcode=Helper.correctNull((String)hshRequestValues.get("strOrgCode"));
			if(strAppid.equalsIgnoreCase(""))
			{
				strAppid=Helper.correctNull((String)hshRequestValues.get("hid_appid"));	
			}
			if(strAppid.equalsIgnoreCase(""))
			{
				strAppid=Helper.correctNull((String)hshRequestValues.get("cattype"));	
			}
			if(strAppid.equalsIgnoreCase(""))
			{
				strAppid=Helper.correctNull((String)hshRequestValues.get("hidDemoId"));	
			}
			if(strAppid.equalsIgnoreCase(""))
			{
				strAppid=Helper.correctNull((String)hshRequestValues.get("hidAppid"));	
			}
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)hshRequestValues.get("hidapplno"));	
			}
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)hshRequestValues.get("hidApplno"));	
			}
			
			if(strAction.equalsIgnoreCase("new"))
			{
				strAppno="";
			}
			
			
			
			
			
			if(!strAppno.equalsIgnoreCase("") && (!strAction.equalsIgnoreCase("new")))
			{
				
				strQuery = SQLParser.getSqlQuery("sel_com_banker^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{  
					strAppid=correctNull(rs.getString("BANKER_APPID"));
				}
			}
			hshValues.put("BANKER_APPID",strAppid);
			
			String PERAPP_FNAME="",CON_COMADDR1="",CON_COMADDR2="",CON_COMVILLAGE="",CON_COMCITY="",con_comdist="",CON_COMSTATE="",CON_COMZIP="";
			String CON_COMCOUNTRY="";
			if(!strAppid.equalsIgnoreCase(""))
			{
				if(strAction.equalsIgnoreCase("new") || strAction.equalsIgnoreCase("insert") )
				{
				strQuery1 = SQLParser.getSqlQuery("select_networth_cusprofile_bankers^"+strAppid);
				rs=DBUtils.executeQuery(strQuery1);
				}
				else
				{
					strQuery1 = SQLParser.getSqlQuery("select_networth_cusprofile_bankers1^"+strAppid);
					rs=DBUtils.executeQuery(strQuery1);	
				}
				
				if(rs.next()){
					networth=Double.parseDouble(Helper.correctDouble(rs.getString("PERAPP_NETWORTH")));
					perapp_cbsid=Helper.correctNull(rs.getString("perapp_cbsid"));
					PERAPP_FNAME=Helper.correctNull(rs.getString("PERAPP_FNAME"));
					String NRIResidentStatus1=correctNull(rs.getString("INDINFO_RESIDENT_STATUS"));
					if(NRIResidentStatus1.equals("N"))
					{
						CON_COMADDR1=correctNull(rs.getString("CON_COMADDR1"));
						CON_COMADDR2=correctNull(rs.getString("CON_COMADDR2"));
						CON_COMVILLAGE=correctNull(rs.getString("CON_COMVILLAGE"));
						CON_COMCITY=correctNull(rs.getString("CON_COMCITY"));					
						con_comdist=correctNull(rs.getString("con_comdist"));
						CON_COMSTATE=correctNull(rs.getString("CON_COMSTATE"));
						CON_COMZIP=correctNull(rs.getString("CON_COMZIP"));
						CON_COMCOUNTRY=correctNull(rs.getString("CON_COMCOUNTRY"));
					    strCountryCode =Helper.correctNull(rs.getString("CON_COMCOUNTRY"));
						strCitycode = Helper.correctNull(rs.getString("CON_COMCITY"));
					    strPermstatecode=Helper.correctNull(rs.getString("CON_COMSTATE"));
					    strDistcode=Helper.correctNull(rs.getString("CON_COMDIST"));
					}
					else 
					{
						CON_COMADDR1=correctNull(rs.getString("CON_PERMADDR1"));
						CON_COMADDR2=correctNull(rs.getString("CON_PERMADDR2"));
						CON_COMVILLAGE=correctNull(rs.getString("CON_PERMVILLAGE"));
						CON_COMCITY=correctNull(rs.getString("CON_PERMCITY"));					
						con_comdist=correctNull(rs.getString("CON_PERMDIST"));
						CON_COMSTATE=correctNull(rs.getString("CON_PERMSTATE"));
						CON_COMZIP=correctNull(rs.getString("CON_PERMZIP"));
						CON_COMCOUNTRY=correctNull(rs.getString("CON_PERMCOUNTRY"));
						strCountryCode =CON_COMCOUNTRY;
						strCitycode = CON_COMCITY;
					    strPermstatecode=CON_COMSTATE;
					    strDistcode=con_comdist;
				}
					}
				
				hshValues.put("BANKER_NETWORTH",String.valueOf(networth));
				hshValues.put("BANKER_CBS_ID",perapp_cbsid);
				if(rs!=null)
					rs.close();
			}
			
			
			   
				
				
			if(!strAppno.equalsIgnoreCase(""))
			{
				
				 
					
					
				strQuery = SQLParser.getSqlQuery("sel_com_banker^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{  
					
					if(Helper.correctNull(rs.getString("BANKER_STATUS")).equals("OP"))
					{
//						if(Double.parseDouble(Helper.correctDouble(rs.getString("BANKER_NETWORTH")))!=networth)
//						{
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							hshQueryValues=new HashMap();
							hshQuery.put("strQueryId","updt_banker");
							if(Double.parseDouble(Helper.correctDouble(rs.getString("BANKER_NETWORTH")))!=networth)
								{
							arrValues.add(jtn.format(networth));
					            }
					       else
					           {
						arrValues.add(""+Double.parseDouble(Helper.correctDouble(rs.getString("BANKER_NETWORTH"))));
					           }
							if(!Helper.correctNull(rs.getString("BANKER_APPLICANT_NAME")).equalsIgnoreCase(PERAPP_FNAME))//(PERAPP_FNAME))
							{
						arrValues.add(PERAPP_FNAME);
				            }
				       else
				           {
					arrValues.add(Helper.correctNull(rs.getString("BANKER_APPLICANT_NAME")));
				           }
							if(!Helper.correctNull(rs.getString("BANKER_ADDRESS_ONE")).equalsIgnoreCase(CON_COMADDR1))
							{
						arrValues.add(CON_COMADDR1);
				            }
				       else
				           {
					arrValues.add(Helper.correctNull(rs.getString("BANKER_ADDRESS_ONE")));
				           }
							//BANKER_ADDRESS_TWO
							if(!Helper.correctNull(rs.getString("BANKER_ADDRESS_TWO")).equalsIgnoreCase(CON_COMADDR2))
							{
						arrValues.add(CON_COMADDR2);
				            }
				       else
				           {
					arrValues.add(Helper.correctNull(rs.getString("BANKER_ADDRESS_TWO")));
				           }
							//BANKER_VILLAGE_TALUK_TOWN
							
							if(!Helper.correctNull(rs.getString("BANKER_VILLAGE_TALUK_TOWN")).equalsIgnoreCase(CON_COMVILLAGE))
							{
						arrValues.add(CON_COMVILLAGE);
				            }
				       else
				           {
					arrValues.add(Helper.correctNull(rs.getString("BANKER_VILLAGE_TALUK_TOWN")));
				           }
							
							
							if(!Helper.correctNull(rs.getString("BANKER_CITY")).equalsIgnoreCase(CON_COMCITY))
							{
						arrValues.add(CON_COMCITY);
				            }
				       else
				           {
					arrValues.add(Helper.correctNull(rs.getString("BANKER_CITY")));
				           }
							
							
							//BANKER_STATE
							if(!Helper.correctNull(rs.getString("BANKER_STATE")).equalsIgnoreCase(CON_COMSTATE))
							{
						arrValues.add(CON_COMSTATE);
				            }
				       else
				           {
					arrValues.add(Helper.correctNull(rs.getString("BANKER_STATE")));
				           }
							//CON_COMZIP
							if(!Helper.correctNull(rs.getString("BANKER_PINCODE")).equalsIgnoreCase(CON_COMZIP))
							{
						arrValues.add(CON_COMZIP);
				            }
				       else
				           {
					arrValues.add(Helper.correctNull(rs.getString("BANKER_PINCODE")));
				           }
							
							
							if(!Helper.correctNull(rs.getString("BANKER_COUNTRY")).equalsIgnoreCase(CON_COMCOUNTRY))
							{
						arrValues.add(CON_COMCOUNTRY);
				            }
				       else
				           {
					arrValues.add(Helper.correctNull(rs.getString("BANKER_COUNTRY")));
				           }
							
							arrValues.add(strAppno);
							hshQueryValues.put("size","1");
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
							
							hshValues.put("BANKER_NETWORTH",jtn.format(networth));
						//}
//						else
//						{
//							hshValues.put("BANKER_NETWORTH",Helper.correctDouble(rs.getString("BANKER_NETWORTH")));
//						}
					}
					else
					{
						hshValues.put("BANKER_NETWORTH",Helper.correctDouble(rs.getString("BANKER_NETWORTH")));
					}
					hshValues.put("BANKER_APPLICANT_NAME",correctNull(rs.getString("BANKER_APPLICANT_NAME")));
					//hshValues.put("BANKER_PURPOSE",correctNull(Helper.CLOBToString((rs.getClob("BANKER_PURPOSE")))));
					hshValues.put("BANKER_AMOUNT",Helper.correctDouble(rs.getString("BANKER_AMOUNT")));
					hshValues.put("procfee",correctNull(rs.getString("BANKER_COMMISSION_EARNED")));
					hshValues.put("BANKER_EXISTING_ACCNO",correctNull(rs.getString("BANKER_EXISTING_ACCNO")));
					hshValues.put("BANKER_CERTF_NO",correctNull(rs.getString("BANKER_CERTF_NO")));
					hshValues.put("BANKER_DATE",correctNull(rs.getString("BANKER_DATE")));
					hshValues.put("BANKER_SANCTIONED_BY",correctNull(rs.getString("BANKER_SANCTIONED_BY")));
					hshValues.put("BANKER_ADDRESS_ONE",correctNull(rs.getString("BANKER_ADDRESS_ONE")));
					hshValues.put("BANKER_ADDRESS_TWO",correctNull(rs.getString("BANKER_ADDRESS_TWO")));
					hshValues.put("BANKER_VILLAGE_TALUK_TOWN",correctNull(rs.getString("BANKER_VILLAGE_TALUK_TOWN")));
					hshValues.put("BANKER_CITY",correctNull(rs.getString("BANKER_CITY")));
					hshValues.put("BANKER_STATE",correctNull(rs.getString("BANKER_STATE")));
					log.info("============BANKER DISTRICT============"+hshValues.put("strDistcode", strDistcode));
					hshValues.put("BANKER_DISTRICT",correctNull(rs.getString("BANKER_DISTRICT")));
					hshValues.put("BANKER_PINCODE",correctNull(rs.getString("BANKER_PINCODE")));
					hshValues.put("BANKER_COUNTRY",correctNull(rs.getString("BANKER_COUNTRY")));
					hshValues.put("BANKER_CBS_ID",correctNull(rs.getString("BANKER_CBS_ID")));
					hshValues.put("BANKER_APPID",correctNull(rs.getString("BANKER_APPID")));
					hshValues.put("BANKER_APPL_NO",correctNull(rs.getString("BANKER_APPL_NO")));
					hshValues.put("hidapplno",correctNull(rs.getString("BANKER_APPL_NO")));
					
					hshValues.put("BANKER_MAILCHKSTATUS",correctNull(rs.getString("BANKER_MAILCHKSTATUS")));
					hshValues.put("BANKER_LOANTYPE",correctNull(rs.getString("BANKER_LOANTYPE")));
					hshValues.put("BANKER_APPLNHOLDER",correctNull(rs.getString("BANKER_APPLNHOLDER")));
					hshValues.put("BANKER_USRID",correctNull(rs.getString("BANKER_USRID")));
					hshValues.put("BANKER_STATUS",correctNull(rs.getString("BANKER_STATUS")));
					appstatus=correctNull(rs.getString("BANKER_STATUS"));
					hshValues.put("BANKERORG_NAME",correctNull(rs.getString("ORG_NAME")));
					hshValues.put("BANKER_OLDID",correctNull(rs.getString("BANKER_OLDID")));
					hshValues.put("BANKER_BANKERNO",correctNull(rs.getString("BANKER_BANKERNO")));
					hshValues.put("BANKER_SANCTIONING_DEPT",correctNull(rs.getString("BANKER_SANCTIONING_DEPT")));
					hshValues.put("BANKER_SANCTIONING_BRANCH",correctNull(rs.getString("BANKER_SANCTIONING_BRANCH")));
					hshValues.put("BANKER_SANCTION_DATE",correctNull(rs.getString("BANKER_SANCTION_DATE")));
					hshValues.put("BANKER_SANC_REF_NO",correctNull(rs.getString("BANKER_SANC_REF_NO")));
					strPermstatecode=Helper.correctNull(rs.getString("BANKER_STATE"));
					log.info("=============BANKERS CITY============="+strCitycode);
					strCitycode= Helper.correctNull(rs.getString("BANKER_CITY"));
					strDistcode=Helper.correctNull(rs.getString("BANKER_COUNTRY"));
					hshValues.put("BANKER_BENF_NAME",correctNull(rs.getString("BANKER_BENF_NAME")));
					hshValues.put("BANKER_BRIEF_WORKORDER",correctNull(rs.getString("BANKER_BRIEF_WORKORDER")));
					hshValues.put("BANKER_BENF_ADDRESSONE",correctNull(rs.getString("BANKER_BENF_ADDRESSONE")));
					hshValues.put("BANKER_BENF_ADRESSTWO",correctNull(rs.getString("BANKER_BENF_ADRESSTWO")));
					hshValues.put("BANKER_BENF_CITY",correctNull(rs.getString("BANKER_BENF_CITY")));
					hshValues.put("BANKER_BENF_STATE",correctNull(rs.getString("BANKER_BENF_STATE")));
					hshValues.put("BANKER_BENF_DISTRICT",correctNull(rs.getString("BANKER_BENF_DISTRICT")));
					hshValues.put("BANKER_SANCTION_FOR",correctNull(rs.getString("BANKER_SANCTION_FOR")));
					
					
					
					hshValues.put("Tender_Notification_date",correctNull(rs.getString("Tender_Notification_date")));
					hshValues.put("CUT_OFF_DATED_SUBMISSION",correctNull(rs.getString("CUT_OFF_DATED_SUBMISSION")));
					hshValues.put("Tender_Opening_date",correctNull(rs.getString("Tender_Opening_date")));
					hshValues.put("Indent_Number",correctNull(rs.getString("Indent_Number")));
					hshValues.put("Validity_of_Tender",correctNull(rs.getString("Validity_of_Tender")));
					hshValues.put("Type_of_Beneficiary",correctNull(rs.getString("Type_of_Beneficiary")));
					hshValues.put("BANK_CHARGE_APPLICABLE",correctNull(rs.getString("BANK_CHARGE_APPLICABLE")));
					
					hshValues.put("banker_certi_valityextdate",correctNull(rs.getString("banker_certi_valityextdate")));
					
					hshValues.put("BANK_EXPIRY_DATE",correctNull(rs.getString("BANK_EXPIRY_DATE")));
					
                    hshValues.put("BANK_VALID_DAYS",correctNull(rs.getString("BANK_VALID_DAYS")));
					
					hshValues.put("BANK_CHARGES_REASON",correctNull(rs.getString("BANK_CHARGES_REASON")));
					
                    hshValues.put("ACTCOUNT",correctNull(rs.getString("bank_active_count")));
                    hshValues.put("ACTNETWORTH",correctNull(rs.getString("bank_active_limit")));
					
					hshValues.put("EXPCOUNT",correctNull(rs.getString("bank_expire_count")));
					hshValues.put("EXPNETWORTH",correctNull(rs.getString("bank_expire_limit")));
					hshValues.put("BANKER_APPROVE_DATE",correctNull(rs.getString("BANKER_APPROVE_DATE")));
					
					
					
					
					
					strPermstatecode1=Helper.correctNull(rs.getString("BANKER_BENF_STATE"));
					strCitycode1 = Helper.correctNull(rs.getString("BANKER_BENF_CITY"));
					log.info("=============BANKERS DISTRICT============="+hshValues.put("strDistcode1",strDistcode1));
					strDistcode1=Helper.correctNull(rs.getString("BANKER_BENF_DISTRICT"));
					hshValues.put("BANKER_BRIEF_WORKORDER",correctNull(rs.getString("BANKER_BRIEF_WORKORDER")));
					hshValues.put("hidAction","");
					strAction="";
					strsanctionfor=correctNull(rs.getString("BANKER_SANCTION_FOR"));
					hshValues.put("strPermstatecode1",strPermstatecode1);
					hshValues.put("strCitycode1",strCitycode1);
					hshValues.put("strDistcode1",strDistcode1);
					hshValues.put("strCitycode", strCitycode);
					hshValues.put("strDistcode", strDistcode);
				}
			}
			if((!perapp_cbsid.equalsIgnoreCase(""))  && strAppno.equalsIgnoreCase("") )
			{
					hshValues.put("BANKER_APPLICANT_NAME",Helper.correctNull((String)hshRequestValues.get("customername")));
				
					strQuery = SQLParser.getSqlQuery("sel_com_solvecncy_for_communication_details^"+strAppid);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						String NRIResidentStatus=correctNull(rs.getString("INDINFO_RESIDENT_STATUS"));
						hshValues.put("SOL_APPLICANT_NAME",correctNull(rs.getString("PERAPP_FNAME")));
						
						hshValues.put("BANKER_APPLICANT_NAME",correctNull(rs.getString("PERAPP_FNAME")));
						hshValues.put("BANKER_DATE",Helper.getCurrentDateTime());
						if(NRIResidentStatus.equals("N"))
						{
							hshValues.put("BANKER_ADDRESS_ONE",correctNull(rs.getString("CON_COMADDR1")));
							hshValues.put("BANKER_ADDRESS_TWO",correctNull(rs.getString("CON_COMADDR2")));
							hshValues.put("BANKER_VILLAGE_TALUK_TOWN",correctNull(rs.getString("CON_COMVILLAGE")));
							hshValues.put("BANKER_CITY",correctNull(rs.getString("CON_COMCITY")));					
							hshValues.put("BANKER_DISTRICT",correctNull(rs.getString("con_comdist")));
							hshValues.put("BANKER_STATE",correctNull(rs.getString("CON_COMSTATE")));
							hshValues.put("BANKER_PINCODE",correctNull(rs.getString("CON_COMZIP")));
							hshValues.put("BANKER_COUNTRY",correctNull(rs.getString("CON_COMCOUNTRY")));
						    strCountryCode =Helper.correctNull(rs.getString("CON_COMCOUNTRY"));
							strCitycode = Helper.correctNull(rs.getString("CON_COMCITY"));
						    strPermstatecode=Helper.correctNull(rs.getString("CON_COMSTATE"));
						    strDistcode=Helper.correctNull(rs.getString("CON_COMDIST"));
						}
						else 
						{
							hshValues.put("BANKER_ADDRESS_ONE",correctNull(rs.getString("CON_PERMADDR1")));
							hshValues.put("BANKER_ADDRESS_TWO",correctNull(rs.getString("CON_PERMADDR2")));
							hshValues.put("BANKER_VILLAGE_TALUK_TOWN",correctNull(rs.getString("CON_PERMVILLAGE")));
							hshValues.put("BANKER_CITY",correctNull(rs.getString("CON_PERMCITY")));					
							hshValues.put("BANKER_DISTRICT",correctNull(rs.getString("CON_PERMDIST")));
							hshValues.put("BANKER_STATE",correctNull(rs.getString("CON_PERMSTATE")));
							hshValues.put("BANKER_PINCODE",correctNull(rs.getString("CON_PERMZIP")));
							hshValues.put("BANKER_COUNTRY",correctNull(rs.getString("CON_PERMCOUNTRY")));
							hshValues.put("BANKER_STATE",correctNull(rs.getString("CON_PERMSTATE")));
						    strCountryCode =Helper.correctNull(rs.getString("CON_PERMCOUNTRY"));
							strCitycode = Helper.correctNull(rs.getString("CON_PERMCITY"));
						    strPermstatecode=Helper.correctNull(rs.getString("CON_PERMSTATE"));
						    strDistcode=Helper.correctNull(rs.getString("CON_PERMDIST"));
						}
						hshValues.put("BANKER_CBS_ID",correctNull(rs.getString("PERAPP_CBSID")));
				        hshValues.put("BANKER_APPID",Helper.correctNull((String)rs.getString("PERAPP_ID")));
				        hshValues.put("BANKER_NETWORTH",Helper.correctDouble((String)rs.getString("PERAPP_NETWORTH")));
				        hshValues.put("BANKER_OLDID",Helper.correctNull((String)rs.getString("PERAPP_OLDID")));
				     
					    hshValues.put("hidAction",strAction);
					    hshValues.put("strDataAvlFlag","Y");
					    hshValues.put("strCitycode",strCitycode);
					    hshValues.put("strDistcode",strDistcode);
					   
					 }	
			}
			
			
			strQuery = SQLParser.getSqlQuery("sel_com_solvecncy_for_communication_details^"+strAppid);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				String NRIResidentStatus=correctNull(rs.getString("INDINFO_RESIDENT_STATUS"));
				if(NRIResidentStatus.equals("N"))
				{
				    strCountryCode =Helper.correctNull(rs.getString("CON_COMCOUNTRY"));
					strCitycode = Helper.correctNull(rs.getString("CON_COMCITY"));
				    strPermstatecode=Helper.correctNull(rs.getString("CON_COMSTATE"));
				    strDistcode=Helper.correctNull(rs.getString("CON_COMDIST"));
				}
				else 
				{
					
				    strCountryCode =Helper.correctNull(rs.getString("CON_PERMCOUNTRY"));
					strCitycode = Helper.correctNull(rs.getString("CON_PERMCITY"));
				    strPermstatecode=Helper.correctNull(rs.getString("CON_PERMSTATE"));
				    strDistcode=Helper.correctNull(rs.getString("CON_PERMDIST"));
				}
				
			   
			 }	
			
			if(!strCitycode.equals(""))
			{
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_citynamebycode^"+strCitycode);
			if(rs.next())
			{
				hshValues.put("txtperapp_city",correctNull(rs.getString("city_name")));
			}	
			}
			if(!strCountryCode.equals(""))
			{
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_countrynamebycode^"+strCountryCode);
			if(rs.next())
			{
				hshValues.put("txtperapp_country",correctNull(rs.getString("con_country")));
			}
			}
			if(!strPermstatecode.equals(""))
			{
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_statenamebycode^"+strPermstatecode);
			if(rs.next())
			{
				hshValues.put("txtperapp_permstate",correctNull(rs.getString("state_name")));
			}
			}
			if(!strDistcode.equals(""))
			{
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_distnamebycode^"+strDistcode);
			if(rs.next())
			{
				hshValues.put("txtperapp_district",correctNull(rs.getString("district_desc")));
			}
			}
			
			
			if(!strCitycode1.equals(""))
			{
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_citynamebycode^"+strCitycode1);
			if(rs.next())
			{
				hshValues.put("txtbanker_city",correctNull(rs.getString("city_name")));
			}	
			}
			
			if(!strPermstatecode1.equals(""))
			{
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_statenamebycode^"+strPermstatecode1);
			if(rs.next())
			{
				hshValues.put("txtbanker_permstate",correctNull(rs.getString("state_name")));
			}
			}
			if(!strDistcode1.equals(""))
			{
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_distnamebycode^"+strDistcode1);
			if(rs.next())
			{
				hshValues.put("txtbanker_district",correctNull(rs.getString("district_desc")));
			}
			}
			hshValues.put("strAppid",strAppid);
		
			if(!strAction.equalsIgnoreCase("new"))
			{
				hshValues.put("strDataAvlFlag","Y");
				char readFlag=correctNull((String)hshRequestValues.get("strGroupRights")).charAt(18);
				String btnenable=(""+readFlag).equals("r")?"N":(appstatus.equalsIgnoreCase("OP") && correctNull((String)hshValues.get("BANKER_APPLNHOLDER")).equals(correctNull((String)hshRequestValues.get("strUserId"))))?"Y":"N";
				hshValues.put("btnenable",btnenable);
			}
			/*else
			{
				hshValues.put("strDataAvlFlag","Y");
				char readFlag=correctNull((String)hshRequestValues.get("strGroupRights")).charAt(18);
				String btnenable=(""+readFlag).equals("r")?"N":(appstatus.equalsIgnoreCase("OP") && correctNull((String)hshValues.get("BANKER_APPLNHOLDER")).equals(correctNull((String)hshRequestValues.get("strUserId"))))?"Y":"N";
				hshValues.put("btnenable",btnenable);	
			}*/
				
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("selstatdatabyidnetworth");
			while(rs.next())
			{
				hshValues.put("networthperc",String.valueOf(Integer.valueOf(correctNull(rs.getString("stat_data_desc")))));
					//bflag=true;
				
				
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			
			
			if(appstatus.equalsIgnoreCase(""))
			{
			rs=DBUtils.executeLAPSQuery("selstatdatabyidexpired");
			if(rs.next())
			{
				if(appstatus.equalsIgnoreCase(""))
				{
				hshValues.put("expdatelimit","30");//correctNull(rs.getString("stat_data_desc1")));
					//bflag=true;
				hshValues.put("BANK_VALID_DAYS","30");//correctNull(rs.getString("stat_data_desc1")));
				}
			}	
			}
			
			
			if(rs!=null)
			{
				rs.close();
			}
			
			if(!strAppno.equalsIgnoreCase("") && appstatus.equalsIgnoreCase("PA"))
			{
			boolean issueflag=false;
			boolean tendooropoendate=false;
			String issuedate =FwHelper.correctNull((String)hshValues.get("BANKER_DATE"));
			String Tender_Opening_date=FwHelper.correctNull((String)hshValues.get("Tender_Opening_date"));
			String banker_certi_valityextdate=FwHelper.correctNull((String)hshValues.get("banker_certi_valityextdate"));
			
			if(banker_certi_valityextdate.equalsIgnoreCase(""))
				
			{
			if(!Tender_Opening_date.equalsIgnoreCase("") && !issuedate.equalsIgnoreCase(""))
			{
			Date d1 = new Date(issuedate);
		    Date d2 = new Date(Tender_Opening_date);
		      
		    if(d1.compareTo(d2)>0)
		    {
		    	issueflag=true;	
		    }
		    else
		    {
		    	tendooropoendate=true;
		    }
		    
		    if(!issueflag && !tendooropoendate)
		    {
		    if(d1.compareTo(d2)==0)
		    {
		    	issueflag=true;	
		    }
		    
			}
			}
			}
		      
			if(!banker_certi_valityextdate.equalsIgnoreCase(""))
			
			{
				
				String stringDate=banker_certi_valityextdate;  
				Date date1=new SimpleDateFormat("dd/MM/yyyy").parse(stringDate);  
				Calendar cal = Calendar.getInstance();
				cal.setTime(date1);
				    
				// manipulate date
				
				
					
				//int noofdays=Integer.parseInt(FwHelper.correctNull((String)hshValues.get("expdatelimit")));
				//cal.add(Calendar.DATE, noofdays); 
				Date dateWithValDays = cal.getTime();
				
				
				System.out.println("dateWithValDays===="+dateWithValDays);
				
				String todaydate=Helper.getCurrentDateTime();
				Date date2=new SimpleDateFormat("dd/MM/yyyy").parse(todaydate);  
				Calendar cal2 = Calendar.getInstance();
				cal2.setTime(date2);
				
				
				/* int strsno=0;
					rs=DBUtils.executeLAPSQuery("maxsel_bankcerhisvalmaxx^"+strAppno);
					if(rs.next())
					{
						strsno=(rs.getInt("com_bank_sno"));
					}*/
				
				int strsno=0;
				rs=DBUtils.executeLAPSQuery("maxsel_bankcerhisvalmax^"+strAppno);
				if(rs.next())
				{
					strsno=Integer.parseInt(rs.getString("com_bank_sno"));
				}	
				//strsno++;
				if(rs!=null)
				{
					rs.close();
				}
					
				 if((date2.compareTo(dateWithValDays) >0))
					{
					 /*hshQueryValues=new HashMap();
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","updexp_bankcerhis");
						 
						 
					//Date	 bankexpdate = cal.getTime();
						DateFormat dateFormat1 = new SimpleDateFormat("dd/MM/yyyy");
						 arrValues.add(""+dateFormat1.format(cal.getTime()));
						// arrValues.add(""+bankexpdate);
						arrValues.add("EXPIRED");
						arrValues.add("PA");
						arrValues.add(strAppno);
						arrValues.add(""+strsno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size","1");
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");*/
						
						
					 
						
						strQuery = SQLParser.getSqlQuery("select_networth_cusprofile^"+strAppid);
						rs=DBUtils.executeQuery(strQuery);
						 perapp_cbsid="";
						if(rs.next()){
							//networth=Double.parseDouble(Helper.correctDouble(rs.getString("PERAPP_NETWORTH")));
							perapp_cbsid=Helper.correctNull(rs.getString("perapp_cbsid"));
						}
						if(rs!=null)
						{
							rs.close();
						}
						//hshQuery=new HashMap();
						//arrValues=new ArrayList();
						hshQueryValues=new HashMap();
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","sel_ins_bankcer_historye");
						arrValues.add(strAppno);
						arrValues.add(strAppid);
						arrValues.add(strUserId);
						arrValues.add(perapp_cbsid);
						arrValues.add("PA");	
						/*if(strAction.equalsIgnoreCase("approve"))
						{
						arrValues.add("ACTIVE");
						}
						else
						{*/
							arrValues.add("EXPIRED");	
						//}
						//arrValues.add("CLOSED");
						arrValues.add(""+strsno);
						//if(strAction.equalsIgnoreCase("approve"))
						//{
						arrValues.add("APPROVED");
						//}
						//else
						//{
							//arrValues.add("REJECTED");
						//}
						//arrValues.add("CLOSURE");
						arrValues.add(strUserId);
						arrValues.add(strUserId);
						DateFormat dateFormat1 = new SimpleDateFormat("dd/MM/yyyy");
						 arrValues.add(""+dateFormat1.format(cal.getTime()));
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size","1");
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						
						 hshQueryValues=new HashMap();
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","update_bankers_exp_det");
						arrValues.add(""+dateWithValDays);
						
						 DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
//				            Calendar c = Calendar.getInstance();
							
				            arrValues.add(""+dateFormat.format(cal.getTime()));
				            
						//arrValues.add(""+dateWithValDays);
				            arrValues.add("EXPIRED");   
						arrValues.add(strAppno);
						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size","1");
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						
						
						
						 hshQueryValues=new HashMap();
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","update_bankers_valexp_det");
							
						  
							arrValues.add(strAppno);
							
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size","1");
							hshQueryValues.put("1",hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
							
						
						}
				
			}
			
			else if(!FwHelper.correctNull((String)hshValues.get("BANK_EXPIRY_DATE")).equalsIgnoreCase(""))
			 {
			 String noofdays2=FwHelper.correctNull((String)hshValues.get("BANK_EXPIRY_DATE"));
			 Date dateWithValDays2=new SimpleDateFormat("dd/MM/yyyy").parse(noofdays2);  
			 Calendar cal221 = Calendar.getInstance();
			 cal221.setTime(dateWithValDays2);
				//cal.add(Calendar.DATE, noofdays2); 
				//Date dateWithValDays2 = cal.getTime();
				
				
				System.out.println("dateWithValDays2===="+dateWithValDays2);
				
				String todaydate2=Helper.getCurrentDateTime();
				Date date22=new SimpleDateFormat("dd/MM/yyyy").parse(todaydate2);  
				Calendar cal22 = Calendar.getInstance();
				cal22.setTime(date22);
				
				if(rs!=null)
				{
					rs.close();
				}
//				  int strsno=0;
//					rs=DBUtils.executeLAPSQuery("maxsel_bankcerhisvalmaxx^"+strAppno);
//					if(rs.next())
//					{
//						strsno=(rs.getInt("com_bank_sno"));
//					}
				
				int strsno=0;
				rs=DBUtils.executeLAPSQuery("maxsel_bankcerhisvalmax^"+strAppno);
				if(rs.next())
				{
					strsno=Integer.parseInt(rs.getString("com_bank_sno"));
				}	
				//strsno++;
				if(rs!=null)
				{
					rs.close();
				}
					
				 if((date22.compareTo(dateWithValDays2) > 0))
					{
//					 hshQueryValues=new HashMap();
//						hshQuery=new HashMap();
//						arrValues=new ArrayList();
//						hshQuery.put("strQueryId","updexp_bankcerhis");
//						DateFormat dateFormat1 = new SimpleDateFormat("dd/MM/yyyy");
//						 arrValues.add(""+dateFormat1.format(cal221.getTime()));
//						//arrValues.add(""+(cal221.getTime()));
//						
//						//Date	 bankexpdate = cal221.getTime();
//						 
//						// arrValues.add(""+dateFormat1.format(cal.getTime()));
//						 //arrValues.add(""+bankexpdate);
//						 
//						arrValues.add("EXPIRED");
//						arrValues.add("PA");
//						arrValues.add(strAppno);
//						arrValues.add(""+strsno);
//						hshQuery.put("arrValues",arrValues);
//						hshQueryValues.put("size","1");
//						hshQueryValues.put("1",hshQuery);
//						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					 
					 
						
					 	
						//strsno++;		
						
						strQuery = SQLParser.getSqlQuery("select_networth_cusprofile^"+strAppid);
						rs=DBUtils.executeQuery(strQuery);
						 perapp_cbsid="";
						if(rs.next()){
							//networth=Double.parseDouble(Helper.correctDouble(rs.getString("PERAPP_NETWORTH")));
							perapp_cbsid=Helper.correctNull(rs.getString("perapp_cbsid"));
						}
						
						//hshQuery=new HashMap();
						//arrValues=new ArrayList();
						hshQueryValues=new HashMap();
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","sel_ins_bankcer_historye");
						arrValues.add(strAppno);
						arrValues.add(strAppid);
						arrValues.add(strUserId);
						arrValues.add(perapp_cbsid);
						arrValues.add("PA");	
						/*if(strAction.equalsIgnoreCase("approve"))
						{
						arrValues.add("ACTIVE");
						}
						else
						{*/
							arrValues.add("EXPIRED");	
						//}
						//arrValues.add("CLOSED");
						arrValues.add(""+strsno);
						//if(strAction.equalsIgnoreCase("approve"))
						//{
						arrValues.add("APPROVED");
						//}
						//else
						//{
							//arrValues.add("REJECTED");
						//}
						//arrValues.add("CLOSURE");
						arrValues.add(strUserId);
						arrValues.add(strUserId);
						DateFormat dateFormat1 = new SimpleDateFormat("dd/MM/yyyy");
						arrValues.add(""+dateFormat1.format(cal221.getTime()));
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size","1");
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						
						
						 hshQueryValues=new HashMap();
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","update_bankers_exp_det");
						arrValues.add(""+dateWithValDays2);
						DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
//			            Calendar c = Calendar.getInstance();
						
			            arrValues.add(""+dateFormat.format(cal221.getTime()));
			            arrValues.add("EXPIRED");
						arrValues.add(strAppno);
						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size","1");
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						
						}
				 
					 
			 }
			else
			{
				Date date21=new Date();
				Calendar cal21 = Calendar.getInstance();
				Date date1=new Date();
				Calendar cal = Calendar.getInstance();
				Date dateWithValDays =new Date();
				Date dateWithTendornotificate=new Date();
				
				if(tendooropoendate)
				{
			String tenderdate=Tender_Opening_date;  
			 date21=new SimpleDateFormat("dd/MM/yyyy").parse(tenderdate);  			
			cal21.setTime(date21);
				}
			if(issueflag)
			{
			String stringDate=issuedate;  
			 date1=new SimpleDateFormat("dd/MM/yyyy").parse(stringDate);  
			cal.setTime(date1);
			} 
			// manipulate date
			
			
			int noofdays=0;
			if(FwHelper.correctNull((String)hshValues.get("BANK_VALID_DAYS")).equalsIgnoreCase(""))
			{
			 noofdays=30;
			}
			else
			{
				 noofdays=Integer.valueOf(FwHelper.correctNull((String)hshValues.get("BANK_VALID_DAYS")));	//expdatelimit")));
			}
			
			
			if(issueflag)
			{
			cal.add(Calendar.DATE, noofdays); 
			 dateWithValDays = cal.getTime();
			}
			if(tendooropoendate)
			{
			cal21.add(Calendar.DATE, noofdays); 
			 dateWithTendornotificate = cal21.getTime();
			}
			System.out.println("dateWithValDays===="+dateWithValDays);
			
			String todaydate=Helper.getCurrentDateTime();
			Date date2=new SimpleDateFormat("dd/MM/yyyy").parse(todaydate);  
			Calendar cal2 = Calendar.getInstance();
			cal2.setTime(date2);
			
			if(rs!=null)
			{
				rs.close();
			}
			
			
//			 int strsno=0;
//				rs=DBUtils.executeLAPSQuery("maxsel_bankcerhisvalmaxx^"+strAppno);
//				if(rs.next())
//				{
//					strsno=(rs.getInt("com_bank_sno"));
//				}
			
			int strsno=0;
			rs=DBUtils.executeLAPSQuery("maxsel_bankcerhisvalmax^"+strAppno);
			if(rs.next())
			{
				strsno=Integer.parseInt(rs.getString("com_bank_sno"));
			}	
			//strsno++;
			if(rs!=null)
			{
				rs.close();
			}
				
			 if((date2.compareTo(dateWithValDays) >0) || (date2.compareTo(dateWithTendornotificate) > 0))
				{
				 /*hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","updexp_bankcerhis");*/
				 
//					if(issueflag)
//					{
//					DateFormat dateFormat1 = new SimpleDateFormat("dd/MM/yyyy");
//////		            Calendar c = Calendar.getInstance();
////					
//		            arrValues.add(""+dateFormat1.format(cal.getTime()));
////		            arrValues.add(""+(cal.getTime()));
//		            
//		           // Date	 bankexpdate = cal.getTime();
//					 
//					// arrValues.add(""+dateFormat1.format(cal.getTime()));
//					// arrValues.add(""+bankexpdate);
//					 
//					}
					
//					if(tendooropoendate)
//					{
//											
//						DateFormat dateFormat1 = new SimpleDateFormat("dd/MM/yyyy");
//			            arrValues.add(""+dateFormat1.format(cal21.getTime()));	
//			           /* arrValues.add(""+(cal21.getTime()));*/
//			            
//			            
//			            Date	 bankexpdate = cal21.getTime();
//						 
//						// arrValues.add(""+dateFormat1.format(cal.getTime()));
//						 arrValues.add(""+bankexpdate);
//						 
//					}
					
//					int strsno=0;
//					rs=DBUtils.executeLAPSQuery("maxsel_bankcerhisvalmax^"+strAppno);
//					if(rs.next())
//					{
//						strsno=Integer.parseInt(rs.getString("com_bank_sno"));
//					}	
					//strsno++;		
					
					strQuery = SQLParser.getSqlQuery("select_networth_cusprofile^"+strAppid);
					rs=DBUtils.executeQuery(strQuery);
					 perapp_cbsid="";
					if(rs.next()){
						//networth=Double.parseDouble(Helper.correctDouble(rs.getString("PERAPP_NETWORTH")));
						perapp_cbsid=Helper.correctNull(rs.getString("perapp_cbsid"));
					}
					
					//hshQuery=new HashMap();
					//arrValues=new ArrayList();
					hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","sel_ins_bankcer_historye");
					arrValues.add(strAppno);
					arrValues.add(strAppid);
					arrValues.add(strUserId);
					arrValues.add(perapp_cbsid);
					arrValues.add("PA");	
					/*if(strAction.equalsIgnoreCase("approve"))
					{
					arrValues.add("ACTIVE");
					}
					else
					{*/
						arrValues.add("EXPIRED");	
					//}
					//arrValues.add("CLOSED");
					arrValues.add(""+strsno);
					//if(strAction.equalsIgnoreCase("approve"))
					//{
					arrValues.add("APPROVED");
					//}
					//else
					//{
						//arrValues.add("REJECTED");
					//}
					//arrValues.add("CLOSURE");
					arrValues.add(strUserId);
					arrValues.add(strUserId);
					if(issueflag)
					{
					DateFormat dateFormat1 = new SimpleDateFormat("dd/MM/yyyy");
////		            Calendar c = Calendar.getInstance();
//					
		            arrValues.add(""+dateFormat1.format(cal.getTime()));
					}
					if(tendooropoendate)
					{
											
						DateFormat dateFormat1 = new SimpleDateFormat("dd/MM/yyyy");
			            arrValues.add(""+dateFormat1.format(cal21.getTime()));	
			           /* arrValues.add(""+(cal21.getTime()));*/
			            
			            
			            Date	 bankexpdate = cal21.getTime();
						 
						// arrValues.add(""+dateFormat1.format(cal.getTime()));
						 arrValues.add(""+bankexpdate);
						 
					}
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					/*arrValues.add("EXPIRED");
					arrValues.add("PA");
					arrValues.add(strAppno);
					arrValues.add(""+strsno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");*/
					
					
					 hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","update_bankers_exp_det");
					if(issueflag)
					{
						arrValues.add(""+dateWithValDays);	
						DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			            arrValues.add(""+dateFormat.format(cal.getTime()));						
					}
					if(tendooropoendate)
					{
						arrValues.add(""+dateWithTendornotificate);						
						DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			            arrValues.add(""+dateFormat.format(cal21.getTime()));						
					}
					arrValues.add("EXPIRED");
					arrValues.add(strAppno);				
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					}
			 
			 ////////
			 
			 
					 
			// int  noofdays2=Integer.parseInt(FwHelper.correctNull((String)hshValues.get("BANK_EXPIRY_DATE")));
			
			
			
			}	
			}
			boolean sanflag=false;
			ResultSet rsstatus=null,rsnetworth=null,rsmax=null;
			boolean actflag=false;
			boolean expflag=false;
			int actstatus=0,expstatus=0;
			double actnethworth=0.00,expnethworth=0.00;
			//BANKER_APPROVE_DATE
			
					
			if(FwHelper.correctNull((String)hshValues.get("BANKER_APPROVE_DATE")).equalsIgnoreCase(""))
			{
				rs=DBUtils.executeLAPSQuery("selcbsidactexpapp1^"+FwHelper.correctNull((String)hshValues.get("BANKER_CBS_ID")));
			}
			else
			{
			rs=DBUtils.executeLAPSQuery("selcbsidactexpapp^"+FwHelper.correctNull((String)hshValues.get("BANKER_CBS_ID"))+"^"+FwHelper.correctNull((String)hshValues.get("BANKER_APPROVE_DATE")));
			}
			while(rs.next())
			{
				boolean issueflag=false,tendooropoendate=false,expirydate=false,validityextensiondate=false;
				String bappno="",banker_certi_valityextdate="",BANKER_DATE="",Tender_Opening_date="",BANK_EXPIRY_DATE="",BANK_VALID_DAYS="";
				int iBANK_VALID_DAYS=0;
				double BANKER_AMOUNT=0.00;
				bappno=FwHelper.correctNull((String)rs.getString("BANKER_APPL_NO"));
				
				if(appstatus.equalsIgnoreCase("PA"))
				{
					sanflag=true;
				rsmax=DBUtils.executeLAPSQuery("sel_com_banker_actexp^"+bappno);//+"^"+FwHelper.correctNull((String)hshValues.get("BANKER_APPROVE_DATE")));
				}
				else
				{
					rsmax=DBUtils.executeLAPSQuery("sel_com_banker_actexp^"+bappno);
						
				}
				if(rsmax.next())
				{
					BANKER_AMOUNT=0.00;
					BANK_EXPIRY_DATE=FwHelper.correctNull((String)rsmax.getString("BANK_EXPIRY_DATE"));
					banker_certi_valityextdate=FwHelper.correctNull((String)rsmax.getString("banker_certi_valityextdate"));
					Tender_Opening_date=FwHelper.correctNull((String)rsmax.getString("Tender_Opening_date"));
					BANKER_DATE=FwHelper.correctNull((String)rsmax.getString("BANKER_DATE"));
					iBANK_VALID_DAYS=rsmax.getInt("BANK_VALID_DAYS");
					BANKER_AMOUNT=Double.valueOf(Double.parseDouble(FwHelper.correctNull((String)rsmax.getString("BANKER_AMOUNT"))));
					
					String todaydate=Helper.getCurrentDateTime();
					Date date2=new SimpleDateFormat("dd/MM/yyyy").parse(todaydate);  
					Calendar cal2 = Calendar.getInstance();
					cal2.setTime(date2);
					
					Date dateexp=new Date();
					Calendar calexp = Calendar.getInstance();
					
					Date datevalcer=new Date();
					Calendar calvalcer = Calendar.getInstance();
					
					Date date1=new Date();
					Calendar cal = Calendar.getInstance();
					
					Date dateWithIssueDate= new Date();
					
					Calendar cal21 = Calendar.getInstance();
					Date date21=new Date();
					
					Date dateWithTendornotificate =new Date();
						
					if(!BANK_EXPIRY_DATE.equalsIgnoreCase(""))
					{
					
					dateexp=new SimpleDateFormat("dd/MM/yyyy").parse(BANK_EXPIRY_DATE);  			
					calexp.setTime(dateexp);
					}
					if(!banker_certi_valityextdate.equalsIgnoreCase(""))
					{
					
					datevalcer=new SimpleDateFormat("dd/MM/yyyy").parse(banker_certi_valityextdate);  			
					calvalcer.setTime(datevalcer);
					}					
					if(!BANKER_DATE.equalsIgnoreCase(""))
					{
					
					date1=new SimpleDateFormat("dd/MM/yyyy").parse(BANKER_DATE);  			
					cal.setTime(date1);
					cal.add(Calendar.DATE, iBANK_VALID_DAYS); 
					 dateWithIssueDate = cal.getTime();
					}
					if(!Tender_Opening_date.equalsIgnoreCase(""))
					{
					
					 date21=new SimpleDateFormat("dd/MM/yyyy").parse(Tender_Opening_date);  			
					cal21.setTime(date21);					
					cal21.add(Calendar.DATE, iBANK_VALID_DAYS); 
					 dateWithTendornotificate = cal21.getTime();
					}
					if(!banker_certi_valityextdate.equalsIgnoreCase(""))
					{
					if(date2.compareTo(datevalcer)>0)
					{
						expstatus=expstatus+1;
						expnethworth=expnethworth+BANKER_AMOUNT;
					}
					else
					{
						actstatus=actstatus+1;
						actnethworth=actnethworth+BANKER_AMOUNT;	
					}
					validityextensiondate=true;
					}
					
					if(!BANK_EXPIRY_DATE.equalsIgnoreCase("") && !validityextensiondate)
					{
						
						if(date2.compareTo(dateexp)>0)
						{
							expstatus=expstatus+1;
							expnethworth=expnethworth+BANKER_AMOUNT;
						}
						else
						{
							actstatus=actstatus+1;
							actnethworth=actnethworth+BANKER_AMOUNT;	
						}	
						
						expirydate=true;
					 
					}
					
					
					if(!BANKER_DATE.equalsIgnoreCase("") && !validityextensiondate && !expirydate)
					{
					if(date2.compareTo(dateWithIssueDate)>0)
				    {
						expstatus=expstatus+1;
						expnethworth=expnethworth+BANKER_AMOUNT;
					}
					else
					{
						actstatus=actstatus+1;
						actnethworth=actnethworth+BANKER_AMOUNT;	
					}	
						
				    	issueflag=true;	
				    }
					
					
					
				if(!Tender_Opening_date.equalsIgnoreCase("") && !validityextensiondate && !expirydate && !issueflag)
				{
					if(date2.compareTo(dateWithTendornotificate)>0)
				    {
					expstatus=expstatus+1;
					
					expnethworth=expnethworth+BANKER_AMOUNT;
				}
				else
				{
					actstatus=actstatus+1;
					actnethworth=actnethworth+BANKER_AMOUNT;	
				}	
				    	tendooropoendate=true;
				    }
					
					 //actstatus
					 
					 
				}
				
			}
			 if(!sanflag && !appstatus.equalsIgnoreCase(""))
			 {
				 hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","upd_act_expcntamt");
					arrValues.add(String.valueOf(actstatus));
					arrValues.add(String.valueOf(jtn.format(actnethworth)));
					arrValues.add(String.valueOf(expstatus));
					arrValues.add(String.valueOf(jtn.format(expnethworth)));
					arrValues.add(strAppno);				
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
				
//					hshValues.put("ACTCOUNT",String.valueOf(actstatus));
//					hshValues.put("ACTNETWORTH",String.valueOf(jtn.format(actnethworth)));
//					hshValues.put("EXPCOUNT",String.valueOf(expstatus));
//					hshValues.put("EXPNETWORTH",String.valueOf(jtn.format(expnethworth)));
//				
			 
					hshValues.put("ACTCOUNT",String.valueOf(actstatus));
					//hshValues.put("ACTNETWORTH",String.valueOf(jtn.format(actnethworth)));
					
					hshValues.put("ACTNETWORTH",String.valueOf(actnethworth));
					
					hshValues.put("EXPCOUNT",String.valueOf(expstatus));
					
					//hshValues.put("EXPNETWORTH",String.valueOf(jtn.format(expnethworth)));
					
					hshValues.put("EXPNETWORTH",String.valueOf(expnethworth));
					
			 }
			
			
			if((appstatus.equalsIgnoreCase("")) ||( FwHelper.correctNull((String)hshValues.get("ACTCOUNT")).equalsIgnoreCase("") && FwHelper.correctNull((String)hshValues.get("EXPCOUNT")).equalsIgnoreCase("")))
			{				
				hshValues.put("ACTCOUNT",String.valueOf(actstatus));
				//hshValues.put("ACTNETWORTH",String.valueOf(jtn.format(actnethworth)));
				
				hshValues.put("ACTNETWORTH",String.valueOf(actnethworth));
				
				hshValues.put("EXPCOUNT",String.valueOf(expstatus));
				
				//hshValues.put("EXPNETWORTH",String.valueOf(jtn.format(expnethworth)));
				
				hshValues.put("EXPNETWORTH",String.valueOf(expnethworth));
			}
			else
			{
				actstatus=0;
				expstatus=0;
				actnethworth=0.00;
				expnethworth=0.00;
				String stractlimit="",strexplimit="";
				actstatus=Integer.valueOf(FwHelper.correctNull((String)hshValues.get("ACTCOUNT")));
				expstatus=Integer.valueOf(FwHelper.correctNull((String)hshValues.get("EXPCOUNT")));
				
				 actnethworth=Double.parseDouble(Helper.correctDouble((String)hshValues.get("ACTNETWORTH")));

				
				 expnethworth=Double.parseDouble(Helper.correctDouble((String)hshValues.get("EXPNETWORTH")));


				//expnethworth=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("EXPNETWORTH"))));
				
				
				hshValues.put("ACTCOUNT",String.valueOf(actstatus));
                //hshValues.put("ACTNETWORTH",String.valueOf(jtn.format(FwHelper.correctDouble(FwHelper.correctNull((String)hshValues.get("ACTNETWORTH"))))));				
				
                hshValues.put("ACTNETWORTH",String.valueOf(actnethworth));				
    			
                
                hshValues.put("EXPCOUNT",String.valueOf(expstatus));
				//hshValues.put("EXPNETWORTH",String.valueOf(jtn.format(FwHelper.correctDouble(FwHelper.correctNull((String)hshValues.get("EXPNETWORTH"))))));	
			
                hshValues.put("EXPNETWORTH",String.valueOf(expnethworth));	
        		
			
			}
				
			
			
			
			/*alter table  bankercertificate add bank_active_count varchar(20);
			alter table  bankercertificate add bank_active_limit varchar(20);
			alter table bankercertificate add bank_expire_count varchar(20);
			alter table bankercertificate add bank_expire_limit varchar(20);*/
			
			
		/*	if((appstatus.equalsIgnoreCase("OP")|| appstatus.equalsIgnoreCase("") || appstatus.equalsIgnoreCase("PA") || appstatus.equalsIgnoreCase("CA")) ||((FwHelper.correctNull((String)hshValues.get("bank_active_count")).equalsIgnoreCase("") && FwHelper.correctNull((String)hshValues.get("bank_active_limit")).equalsIgnoreCase(""))
					|| (FwHelper.correctNull((String)hshValues.get("bank_expire_count")).equalsIgnoreCase("") && FwHelper.correctNull((String)hshValues.get("bank_expire_limit")).equalsIgnoreCase(""))))
			{
			ResultSet rsstatus=null,rsnetworth=null,rsmax=null;
			boolean actflag=false;
			boolean expflag=false;
			String bappno="";
			int actstatus=0,expstatus=0;
			
			double actnethworth=0.00,expnethworth=0.00;
			rs=DBUtils.executeLAPSQuery("selcbsidactexpapp^"+FwHelper.correctNull((String)hshValues.get("BANKER_CBS_ID")));
			while(rs.next())
			{
				bappno=FwHelper.correctNull((String)rs.getString("BANKER_APPL_NO"));
				
				
				
				 int rstrsno=0;
				 rsmax=DBUtils.executeLAPSQuery("maxsel_bankcerhisvalmaxx^"+bappno);
				if(rsmax.next())
				{
					rstrsno=(rsmax.getInt("com_bank_sno"));
				}
				
				
				
				
				if(rstrsno>0)
				{
				rsstatus=DBUtils.executeLAPSQuery("selcbsidactexpappcount1^"+bappno+"^"+rstrsno);
				if(rsstatus.next())
				{
					//hshValues.put("ACTCOUNT",correctNull(rsstatus.getString("count")));
					
					//actstatus=Integer.valueOf(correctNull(rsstatus.getString("count")));
					if(Integer.valueOf(correctNull(rsstatus.getString("count")))>0)
					{
					actstatus=actstatus+Integer.valueOf(correctNull(rsstatus.getString("count")));
					//actstatus++;
					actflag=true;
					}
				}
				if(rsstatus!=null)
				{
					rsstatus.close();
				}
				
				rsnetworth=DBUtils.executeLAPSQuery("selcbsidactexpappcount1amt^"+bappno+"^"+rstrsno);
				if(rsnetworth.next())
				{
					//hshValues.put("ACTCOUNT",correctNull(rsstatus.getString("count")));
					actnethworth=Double.valueOf(correctNull(rsnetworth.getString("BANKER_AMOUNT")));
					if(actnethworth>0)
					{
					actnethworth=+actnethworth;
					//actnethworth++;
					actflag=true;
					}
				}
				
				if(rsnetworth!=null)
				{
					rsnetworth.close();
				}
				
				if(!actflag)
				{
					rsstatus=DBUtils.executeLAPSQuery("selcbsidexpexpappcount1^"+bappno+"^"+rstrsno);
					if(rsstatus.next())
					{
						//hshValues.put("ACTCOUNT",correctNull(rsstatus.getString("count")));
						expstatus=Integer.valueOf(correctNull(rsstatus.getString("count")));
						expstatus=+expstatus;
						//expstatus++;
						
					}
					
					if(rsstatus!=null)
					{
						rsstatus.close();
					}
					
					
					
					rsnetworth=DBUtils.executeLAPSQuery("selcbsidexpexpappcount1amt^"+bappno+"^"+rstrsno);
					if(rsnetworth.next())
					{
						//hshValues.put("ACTCOUNT",correctNull(rsstatus.getString("count")));
						expnethworth=Double.valueOf(correctNull(rsnetworth.getString("BANKER_AMOUNT")));
						expnethworth=+expnethworth;
						//expnethworth++;
						
					}
					
					if(rsnetworth!=null)
					{
						rsnetworth.close();
					}
					
					
				}
				
				}
												
			}
			
			hshValues.put("ACTCOUNT",String.valueOf(actstatus));
			hshValues.put("ACTNETWORTH",String.valueOf(actnethworth));
			hshValues.put("EXPCOUNT",String.valueOf(expstatus));
			hshValues.put("EXPNETWORTH",String.valueOf(expnethworth));
			
			}*/
			
			/*rs=DBUtils.executeLAPSQuery("sel_sanact_bankdetailscount^"+FwHelper.correctNull((String)hshValues.get("BANKER_CBS_ID")));
			if(rs.next())
			{
				hshValues.put("ACTCOUNT",correctNull(rs.getString("count")));
			}
			if(rs!=null)
			{
				rs.close();
			}
			//sel_sanact_bankdetailsnetwork
			
			rs=DBUtils.executeLAPSQuery("sel_sanact_bankdetailsnetwork^"+FwHelper.correctNull((String)hshValues.get("BANKER_CBS_ID")));
			if(rs.next())
			{
				hshValues.put("ACTNETWORTH",correctNull(rs.getString("BANKER_AMOUNT")));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			rs=DBUtils.executeLAPSQuery("sel_sanexp_bankdetailscount^"+FwHelper.correctNull((String)hshValues.get("BANKER_CBS_ID")));
			if(rs.next())
			{
				hshValues.put("EXPCOUNT",correctNull(rs.getString("count")));
			}
			if(rs!=null)
			{
				rs.close();
			}
			//sel_sanact_bankdetailsnetwork
			
			rs=DBUtils.executeLAPSQuery("sel_sanexp_bankdetailsnetwork^"+FwHelper.correctNull((String)hshValues.get("BANKER_CBS_ID")));
			if(rs.next())
			{
				hshValues.put("EXPNETWORTH",correctNull(rs.getString("BANKER_AMOUNT")));
			}
			if(rs!=null)
			{
				rs.close();
			}*/
			
			
			
			String USR_ORGCODE="",org_level="";
			rs=DBUtils.executeLAPSQuery("workflowusersanlimit^"+strUserId);
			if(rs.next())
			{
				hshValues.put("strUserClass",rs.getString("usr_class"));
				hshValues.put("usrfunction",Helper.correctNull(rs.getString("usr_function")));
				USR_ORGCODE=Helper.correctNull(rs.getString("org_code")); 
				hshValues.put("org_level",Helper.correctNull(rs.getString("org_level")));
			}
			
			
			if(rs!=null)
			{
				rs.close();
			}
			
			
			
			 int strsno=0;
				rs=DBUtils.executeLAPSQuery("maxsel_bankcerhisvalmaxx^"+strAppno);
				if(rs.next())
				{
					strsno=(rs.getInt("com_bank_sno"));
				}
				
				if(rs!=null)
				{
					rs.close();
				}
			if(strsno==0)
			{
			rs=DBUtils.executeLAPSQuery("sel_all_bankdetailscount^"+strAppno+"^"+strsno);
			if(rs.next())
			{
				hshValues.put("currentStatus",correctNull(rs.getString("com_bank_sanstatus")));
			}
			}
			hshValues.put("strUserId",strUserId);
			
			
			
		} 
		
		
		catch(Exception ce)
		{
			throw new EJBException("Error in getBankersData "+ce.toString());
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
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshValues; 
    }
	
	public  HashMap getDelegateData(HashMap hshValues) 
	{		
		String strQuery="",strstaticdataid="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecData1 = new ArrayList();
		ArrayList vecVal=null;
		boolean recordflag=false;
		try
		{
			
			String strPrdCode = correctNull((String)hshValues.get("prd_code"));
			if(strPrdCode.equalsIgnoreCase("")){
			strPrdCode = correctNull((String)hshValues.get("sel_prd"));
			}
			if(strPrdCode.equalsIgnoreCase("1")){
				strstaticdataid="256";	
			}else if(strPrdCode.equalsIgnoreCase("6")){
				strstaticdataid="257";
			}
			else if(strPrdCode.equalsIgnoreCase("7")){
				strstaticdataid="278";
			}
			else{
				strstaticdataid="";
			}		
			if(!strstaticdataid.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("sel_solvprocesscharges^"+strstaticdataid);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("STATIC_DATA_RANGE_FROM",Helper.correctNull(rs.getString("STATIC_DATA_RANGE_FROM")));
					hshRecord.put("STATIC_DATA_RANGE_TO",Helper.correctNull(rs.getString("STATIC_DATA_RANGE_TO")));
				}
				}
				if(rs!=null){
					rs.close();
				}
			if (!strPrdCode.equals(""))
			{
				strQuery = SQLParser.getSqlQuery("selsoldelegate^"+strPrdCode);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					
					vecVal = new ArrayList();
					String strclass = correctNull(rs.getString("grp_id"));
					String strdesig = correctNull(rs.getString("grp_name"));
					String strsanction=correctNull(rs.getString("prd_power"));
					if(!strsanction.equalsIgnoreCase(""))
						recordflag=true;
					vecVal.add(correctNull(strclass));
					vecVal.add(correctNull(strsanction));
					vecVal.add(correctNull(strdesig));					
					vecData.add(vecVal);				
				}
				hshRecord.put("vecData",vecData);
			}
				if(vecData.size()==0){
					if(rs!=null){
						rs.close();
					}
					
					strQuery = SQLParser.getSqlQuery("selgroupsanctionlimit");
					rs = DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						vecVal = new ArrayList();
						String strclass = correctNull(rs.getString("grp_id"));
						String strdesig = correctNull(rs.getString("grp_name"));				
						vecVal.add(correctNull(strclass));
						vecVal.add(correctNull(strdesig));					
						vecData1.add(vecVal);				
					}
					hshRecord.put("vecDatagroup",vecData1);
				}
				if(recordflag)
					hshRecord.put("recordflag","Y");
				else
					hshRecord.put("recordflag","N");
				hshRecord.put("strPrdCode",strPrdCode);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData "+ce.toString());
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
		return hshRecord;
	}
	public void updateDelegate(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = null;
		String strSancclass[] = null;
		String strSanlimit[] = null;
		String strSanDesig[] = null;
 		int intUpdatesize=0;
		int j=0;
		ResultSet rs = null;
		try
		{
			String strAction=(String)hshValues.get("hidAction");
			String strPrdCode = correctNull((String)hshValues.get("prdCode"));
			String strBankScheme=correctNull((String)hshValues.get("sel_prd"));
			if(hshValues.get("txtsanc_class")  instanceof java.lang.String){
				strSancclass=new String[1];
				strSancclass[0]= (String) hshValues.get("txtsanc_class");
			}else{
				strSancclass= (String[]) hshValues.get("txtsanc_class");
			}			
			if(hshValues.get("txtsanc_limit")  instanceof java.lang.String){
				strSanlimit=new String[1];
				strSanlimit[0]= (String) hshValues.get("txtsanc_limit");
			}else{
				strSanlimit= (String[]) hshValues.get("txtsanc_limit");
			}
			
 			if(hshValues.get("txtsanc_desig")  instanceof java.lang.String){
 				strSanDesig=new String[1];
				strSanDesig[0]= (String) hshValues.get("txtsanc_desig");
			}else{
				strSanDesig=(String[]) hshValues.get("txtsanc_desig");
			}
		
			intUpdatesize = intUpdatesize+1;
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","delsoldelegate");
			arrValues.add(correctNull(strBankScheme));
		
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			hshQueryValues.put(Integer.toString(j+1),hshQuery);	
			j++;

			for( int i=0;i<strSancclass.length;i++)
			{				
				if(!strSancclass[i].trim().equals("") && strSancclass[i]!=null)
				{
					String strclass = correctNull((String)strSancclass[i]);
					String strlimit = correctNull((String)strSanlimit[i]);
					if(strclass.equals(""))
					{
						strclass="0";
					}
					if(strlimit.equals(""))

					{
						strlimit="0";
					}
					intUpdatesize = intUpdatesize+1;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","inssoldelegate");
					arrValues.add(String.valueOf(intUpdatesize));
					arrValues.add(strBankScheme);
					arrValues.add(strclass);
					arrValues.add(strlimit);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(j+1),hshQuery);	
					j++;
				}
			}
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
		finally
		{
			try
			{
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	}
	
	public HashMap getProcessData(HashMap hshRequestValues) 
	{		
		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol =null;
		HashMap hshRecord = new HashMap();
		String strQuery ="";
		String strPrdCode ="",strstaticdataid="";
		String strProcessID ="";
		boolean recordflag=false;
		try
		{				
			hshRecord = new HashMap();			
			strPrdCode = correctNull((String)hshRequestValues.get("prd_code"));
			if(strPrdCode.equalsIgnoreCase("")){
			strPrdCode = correctNull((String)hshRequestValues.get("sel_prd"));
			}
			if(strPrdCode.equalsIgnoreCase("1")){
				strstaticdataid="256";	
			}else if(strPrdCode.equalsIgnoreCase("6")){
				strstaticdataid="257";
			}
				else if(strPrdCode.equalsIgnoreCase("7")){
					strstaticdataid="278";
			}else{
				strstaticdataid="";
			}
			if(!strstaticdataid.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("sel_solvprocesscharges^"+strstaticdataid);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("STATIC_DATA_RANGE_FROM",Helper.correctNull(rs.getString("STATIC_DATA_RANGE_FROM")));
				hshRecord.put("STATIC_DATA_RANGE_TO",Helper.correctNull(rs.getString("STATIC_DATA_RANGE_TO")));
			}
			}
			if(rs!=null){
				rs.close();
			}
			if(!strPrdCode.equalsIgnoreCase("")){
			strProcessID =  correctNull((String )hshRequestValues.get("hiddesc"));	
			if (!strProcessID.equals(""))
			{
			strQuery = SQLParser.getSqlQuery("selsolprocesschargedata^"+strPrdCode+"^"+strProcessID);
			rs = DBUtils.executeQuery(strQuery);

			if(rs.next())
			{
				recordflag=true;
				vecCol = new ArrayList();
				for (int i=1;i< 6 ;i++ )
				{ 
					vecCol.add(rs.getString(i));
								
				}
				vecRow.add(vecCol);
			}
			}
			}
			hshRecord.put("vecRow",vecRow);
			hshRecord.put("hidId",strProcessID);
			hshRecord.put("strPrdCode",strPrdCode);
			
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
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
	
	public HashMap updateProcessChargesData(HashMap hshValues) 
	{	
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strPrdCode = null;
		String strProcessID =null;
		String strrangefrom="",strrangeto="";
		String strExp="$";
		String strQuery="";
		ResultSet rs=null;
		StringBuilder sbAuditTrial=new StringBuilder();
		String strLoanType="";
		String strKeyId = "";
		StringBuilder sbolddata=new StringBuilder();
		try
		{	
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			strLoanType=correctNull((String)hshValues.get("sel_prd"));
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				rs = DBUtils.executeLAPSQuery("selsolprocesschargedata^"+Helper.correctNull((String)hshValues.get("sel_prd"))+"^"+
						Helper.correctNull((String)hshValues.get("hiddesc")));
				while(rs.next())
				{
					sbolddata.append("Amount Range From ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("process_rangefrom"))))+
							"~Amount Range To ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("process_rangeto"))))+
							"~Processing Fees (%) ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("process_percentcharge"))))+
							"~Min Processing Fees / Flat Processing fee ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("process_minactualcharge"))))+
							"~Max Processing Fees ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("process_maxactualcharge")))));
				}
				if(rs!=null)
				rs.close();
			}
			if(strAction.equals("insert"))
			{
			strPrdCode = correctNull((String)hshValues.get("sel_prd"));
			strrangefrom=correctNull((String)hshValues.get("prd_procrangefrom"));
			strrangeto=correctNull((String)hshValues.get("prd_procrangeto"));
			strQuery = SQLParser.getSqlQuery("checksolprocessrangeins^"+strPrdCode
						+"^"+strrangefrom +"^"+strrangeto
						+"^"+strrangefrom +"^"+strrangeto
						+"^"+strrangefrom +"^"+strrangeto);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				if(rs.getInt(1)!=0)
				{
				strExp = strExp + "Processing Charge is already defined for the given amount range";
				throw new Exception(strExp);
				}
			}
				strPrdCode = correctNull((String)hshValues.get("sel_prd"));
				strProcessID = (String)getMaxSolProcessChageID(strPrdCode);
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshValues.put("hidId","strtermId");				
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insertsolprocesschargedata");
				arrValues.add(strPrdCode);
				arrValues.add(strProcessID);
				arrValues.add(strrangefrom);
				arrValues.add(strrangeto);
				arrValues.add( correctNull((String)hshValues.get("prd_procfees")));
				arrValues.add( correctNull((String)hshValues.get("prd_procfees1")));
				arrValues.add( correctNull((String)hshValues.get("prd_procfees2")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);								
			 }

			 else if(strAction.equals("update"))
			{
				strPrdCode = correctNull((String)hshValues.get("sel_prd"));
				strProcessID =  correctNull((String )hshValues.get("hiddesc"));	
				strrangefrom=correctNull((String)hshValues.get("prd_procrangefrom"));
				strrangeto=correctNull((String)hshValues.get("prd_procrangeto"));
				strQuery = SQLParser.getSqlQuery("checksolprocessrangeupd^"+strPrdCode+"^"+strProcessID
						+"^"+strrangefrom +"^"+strrangeto
						+"^"+strrangefrom +"^"+strrangeto
						+"^"+strrangefrom +"^"+strrangeto);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
					{
					if(rs.getInt(1)!=0)
						{
						strExp = strExp + "Processing Charge is already defined for the given amount range";
						throw new Exception(strExp);
						}
					}
				 
				 
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","updatesolprocesschargedata");
				
				arrValues.add(strrangefrom);
				arrValues.add(strrangeto);
				arrValues.add( correctNull((String)hshValues.get("prd_procfees")));
				arrValues.add( correctNull((String)hshValues.get("prd_procfees1")));
				arrValues.add( correctNull((String)hshValues.get("prd_procfees2")));
				arrValues.add(strPrdCode);
				arrValues.add(strProcessID);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);	
				
			}
			 else if(strAction.equals("delete"))
			{
				strPrdCode = correctNull((String)hshValues.get("sel_prd"));
				strProcessID =  correctNull((String )hshValues.get("hiddesc"));	
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				
				hshQuery.put("strQueryId","deletesolprocesschargedata");
				arrValues.add(strPrdCode);
				arrValues.add(strProcessID);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			}

			try
				{
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					HashMap HashMap3 = new HashMap();
			        HashMap3.put("prdCode", hshValues.get("sel_prd"));
			        EJBInvoker.executeStateLess("setproducts", HashMap3, "updateProductSaveStatus");
			        
			        
			        HashMap HashMap4 = new HashMap();
			        HashMap3.put("prdCode", hshValues.get("sel_prd"));
			        HashMap3.put("hiddesc", hshValues.get("hiddesc"));			         
			        hshValues=getProcessData(HashMap3);
			        
				}
				catch(Exception se)
				{
					throw new Exception("Transaction Failed");
				}
		}
		catch(Exception ce)
		{
			throw new EJBException(ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing in the updateProcessChargesData connection "+cf.getMessage());
			}
		}
		return hshValues;
	}

	private String getMaxSolProcessChageID(String strPrdCode)
	{			
			String strQuery="";
			ResultSet rs = null;
			String termId = "";
			try
			{	
				strQuery = SQLParser.getSqlQuery("selmaxsolprocesschargeid^"+strPrdCode);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					termId = rs.getString(1) ;				
				}
				rs.close();
			
			}
			catch(Exception ce)
			{
				log.error(ce.toString());
				throw new EJBException("Error in getMaxSolProcessChageID "+ce.toString());
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
				catch(Exception cf)
				{
					throw new EJBException("Error closing the connection "+cf.getMessage());
							
				}
			}
			return termId;
	}
	public String getBankerSanctionRefernceNumber(HashMap hshValues) 
	{
		String strRefno="";
		String strAppno="";
		String strSolid="";
		String strFinancialYear="";
		String strDateofSanc="";
		String strOrgLevel="";
		String strOrgCode="";
		String strCPCCode="";
		String strUserId="";
		String strSancAuthority="";
		String strSancAuthorityCode="";
		String strUserDepartment="";
		String strUserDesignation="";
		String strBifur="/";
		ResultSet rs=null;
		String strSno="";
		ArrayList arrValues=new ArrayList();
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		String strFinancialYear1="",strFinancialYear2="";
		String strQuery="";
		String strFinacleSancRefNo="",strAction="",Appstatus="",StrModuleType="";
		try
		{
			strAction=Helper.correctNull((String)hshValues.get("hidAction"));
			if(strAction.equalsIgnoreCase("approve"))
			{
				Appstatus="A";
			}
			else if(strAction.equalsIgnoreCase("reject"))
			{
				Appstatus="R";
			}
			strAppno=Helper.correctNull((String)hshValues.get("strappno"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)hshValues.get("appno"));
			}
			strSolid=Helper.correctNull((String)hshValues.get("strSolid"));
			strOrgLevel=Helper.correctNull((String)hshValues.get("strOrgLevel"));
//			strOrgLevel="SOL";
			strOrgCode=Helper.correctNull((String)hshValues.get("strOrgCode"));
			strUserDepartment=Helper.correctNull((String)hshValues.get("strUserDepartment"));
			strUserId=Helper.correctNull((String)hshValues.get("strUserId"));
			strCPCCode=strOrgCode.substring(0,6);
			StrModuleType=Helper.correctNull((String)hshValues.get("sessionModuleType"));
			if(!(strSolid.equalsIgnoreCase("") || strAppno.equalsIgnoreCase("")))
			{
				strFinancialYear=Helper.financialYear();
				rs=DBUtils.executeLAPSQuery("selCurrentdate");
				if(rs.next())
				{
					strDateofSanc=Helper.correctNull((String)rs.getString("currentdate1"));
				}
				if(rs.next())
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("setuserssel^"+strUserId);
				if(rs.next())
				{
					strSancAuthorityCode=Helper.correctNull((String)rs.getString("user_designation"));
				}
				if(rs.next())
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("selcbsiddatadesc^27^"+strSancAuthorityCode);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strSancAuthority=Helper.correctNull((String)rs.getString("cbs_static_data_passing_code"));
				}
				if(rs !=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("selfinancialyear");
				if(rs.next())
				{
					strFinancialYear=Helper.correctNull((String)rs.getString("FinancialYear"));
					strFinancialYear1=strFinancialYear.substring(0,5);
					strFinancialYear2=strFinancialYear.substring(7,9);
					strFinancialYear=strFinancialYear1+strFinancialYear2;
				}
				
				
				if(rs!=null)
				{rs.close();}
				String SanctioningAuthority="",Sanction_Ref_Num="",Sanction_dep="",strFRefno="",strSancBranch="";
				{
					rs=DBUtils.executeLAPSQuery("sel_bankers_comments^"+strAppno);
					if(rs.next())
					{
						SanctioningAuthority=correctNull(rs.getString("BANKER_SANCTIONED_BY"));
						Sanction_Ref_Num=correctNull(rs.getString("BANKER_SANC_REF_NO"));
						Sanction_dep=correctNull(rs.getString("BANKER_SANCTIONING_DEPT"));
						strSancBranch=correctNull(rs.getString("BANKER_SANCTIONING_BRANCH"));
					}
				}
				
				if(strOrgLevel.equalsIgnoreCase("C"))
				{
					strUserDepartment="";
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("sel_cbsstaticdescbycode^"+"131"+"^"+strSancBranch);
					if(rs.next())
					{
						strUserDepartment=Helper.correctNull((String)rs.getString("CBS_STATIC_SANC_REFNO"));
					}
					strRefno=strSancAuthority+strBifur+strUserDepartment+strBifur+strSolid+strBifur;
					strFRefno=strSancAuthority+strBifur+strUserDepartment+strBifur+strSolid+strBifur;
				}
				else if(strCPCCode.equalsIgnoreCase("001001") && strOrgLevel.equalsIgnoreCase("R"))
				{
					strRefno="CPC"+strSancAuthority+strBifur;
					strFRefno="CPC"+strSancAuthority+strBifur;
				}
				else if(strOrgLevel.equalsIgnoreCase("R"))
				{
					strRefno=strSancAuthority+strBifur+strSolid+strBifur;
					strFRefno=strSancAuthority+strBifur+strSolid+strBifur;
				}
				else if(strOrgLevel.equalsIgnoreCase("D") && Helper.correctNull((String)hshValues.get("strRLPFUser")).equalsIgnoreCase("012"))
				{
					strUserDepartment="";
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("sel_cbsstaticdescbycode^"+"130"+"^"+Sanction_dep);
					if(rs.next())
					{
						strUserDepartment=Helper.correctNull((String)rs.getString("CBS_STATIC_SANC_REFNO"));
					}
					strRefno=strSancAuthority+strBifur+strUserDepartment+strBifur+strSolid+strBifur;
					strFRefno=strSancAuthority+strBifur+strUserDepartment+strBifur+strSolid+strBifur;
				}
				else if(strOrgLevel.equalsIgnoreCase("A"))
				{					
					strRefno=strSancAuthority+strBifur+strSolid+strBifur;
					strFRefno=strSancAuthority+strBifur+strSolid+strBifur;
				}
				if(rs!=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("selbankerreferencenumsno^"+strOrgLevel+"^"+strFinancialYear);
				if(rs.next())
				{
					strSno=Helper.correctNull((String)rs.getString("ars_sno"));
				}
				
				int intsno=Integer.parseInt(strSno);
				intsno=++intsno;
				strSno=Integer.toString(intsno);
				strRefno=strRefno+strSno+strBifur+strFinancialYear+strBifur+strDateofSanc;	
				strFinacleSancRefNo=strFRefno+strSno+strBifur+strFinancialYear;
				
				if(Sanction_dep.equalsIgnoreCase("011"))
				{
					strRefno="CPC"+strSancAuthority+strBifur+strSno+strBifur+strFinancialYear+strBifur+strDateofSanc;
					strFinacleSancRefNo="CPC"+strSancAuthority+strBifur+strSno+strBifur+strFinancialYear;
				}
				else if(Sanction_dep.equalsIgnoreCase("012"))
				{
					
					String strRLPCCode="CLPH",strOrgScode=strSolid;
					
					if((strOrgScode.substring(0, 1)).equalsIgnoreCase("R"))
						strOrgScode=strOrgScode.substring(1, strOrgScode.length());
					
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("sel_cbsstaticdescbycode^130^"+Sanction_dep);
					if(rs.next())
					{
						strRLPCCode=Helper.correctNull(rs.getString("cbs_static_sanc_refno"));
					}
					
					strRefno=strSancAuthority+strBifur+strRLPCCode+strBifur+strOrgScode+strBifur+strSno+strBifur+strFinancialYear+strBifur+strDateofSanc;
					strFinacleSancRefNo=strSancAuthority+strBifur+strRLPCCode+strBifur+strOrgScode+strBifur+strSno+strBifur+strFinancialYear;
				}
				
				if((SanctioningAuthority.equalsIgnoreCase("14")|| SanctioningAuthority.equalsIgnoreCase("15")||SanctioningAuthority.equalsIgnoreCase("16")))
				{
					strRefno=Sanction_Ref_Num;
					strFinacleSancRefNo=Sanction_Ref_Num;
				}
				
				hshQueryValues.put("size","1");
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insreferencenumbanker");
				arrValues.add(strAppno);
				arrValues.add(strSolid);
				arrValues.add(strFinancialYear);
				arrValues.add(strOrgLevel);
				arrValues.add(strSno);
				arrValues.add(strRefno);
				arrValues.add(Appstatus);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in generating getBankerSanctionRefernceNumber.."+e);
		}
		return strRefno;
	}
	/*public HashMap getbankdata(HashMap hshRequestValues) 
	{

		ResultSet rs=null,rs1=null,rs2=null;
		HashMap hshRecord=new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		String strQuery="";
		String comapp_id="";
		String strAppid="",strAppno="";
		String strappno=correctNull((String)hshRequestValues.get("appno"));
		
		if(strappno.equalsIgnoreCase(""))
		{
			strappno=Helper.correctNull((String)hshRequestValues.get("hidapplno"));
		}
		try {
			if(strAppid.equalsIgnoreCase(""))

 		/*ResultSet rs = null;
 		ResultSet rs1=null,rs2=null,rs3=null;
		
		HashMap hshRec=null;
		ArrayList arrCol =null;
		ArrayList Arrvalues =null;
		String strQuery=null,strQuery1=null;
		String strOrgCode = null;
		String strTemp=null;
		String strFromDate=null;
		String strToDate=null;
		String strSaveDate=null;
		String strDate=null;
		String strGen=null;
		String strOrglevel=null;
		String strOrg_Name = "";
		String strloantype="",appno="";
		String strPeriodicity="";
		HashMap hshResults=new HashMap();
		ArrayList arrBorroweExposure=null;
		ArrayList arrBorroweExposureCol=null;
		double strProposedExposure=0.00;
		double strExistingExposure=0.00,strTotalExposure=0.00;
		String strDepartment="",strAppid="",strDesignation="";
		
		java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.setGroupingUsed(false);
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		double strtotSancamt=0.00;
		StringBuffer strbufOrgcode=new StringBuffer();
		double sanctionamt=0.00;
		String strorgScode="";
		StringBuffer strQueryFirst=new StringBuffer();
		StringBuffer strQueryLast=new StringBuffer();
		StringBuffer strbufDesignation=new StringBuffer();
		String strcreWeight="";
		String strStaffId="";
		String strSessionOrgCode="";
		String residentType="";
		String decodestr="";
		float sumofamount=0f;
		float actotal=0f;
		float cctotal=0f;
		String strUserId="";
		String cubsid="";
		
		try
		{
			ArrayList arrRow=new ArrayList();
			strSessionOrgCode =(String)hshRequestValues.get("org_name");
			strSessionOrgCode = strSessionOrgCode.replaceAll("\'","");
			strDate = correctNull((String)hshRequestValues.get("txtDate"));
			strGen =(String)hshRequestValues.get("strUserId");
			strUserId=(String)hshRequestValues.get("strUserId");
			if(!strDate.equals("All"))
>>>>>>> .r25411
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				
			}	
			
			strQuery=SQLParser.getSqlQuery("sel_banker_reportbasedoncusid^"+cubsid);
			
			rs2=DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs2.getString("BANKER_APPL_NO")));//0
				String decode=correctNull(rs2.getString("TYPE_OF_BENEFICIARY"));
				decodestr=SQLParser.getSqlQuery("decodeof_TYPE_OF_BENEFICIARY^"+decode);
				rs=DBUtils.executeQuery(decodestr);
				if(rs.next())
				{
					arrCol.add(correctNull(rs.getString("STAT_DATA_DESC1")));//1	
				}
				arrCol.add(correctNull(rs2.getString("BANKER_CBS_ID")));//1
				arrCol.add(correctNull(rs2.getString("BANKER_APPLICANT_NAME")));//2
				arrCol.add(Helper.addComma(nf.format(Double.parseDouble(Helper.correctDouble(rs2.getString("BANKER_AMOUNT"))))));//3
				if(!correctNull(rs2.getString("BANKER_AMOUNT")).equalsIgnoreCase(""))
				{
				sumofamount=sumofamount+Float.parseFloat(correctNull(rs2.getString("BANKER_AMOUNT")));
				}
				arrCol.add(correctNull(rs2.getString("BANKER_BENF_NAME")));//4
				arrCol.add(correctNull(rs2.getString("TENDER_NOTIFICATION_DATE")));//5
				arrCol.add(correctNull(rs2.getString("BANKER_BRIEF_WORKORDER")));//6
				arrCol.add(correctNull(rs2.getString("BANKER_DATE")));//7
				arrCol.add(correctNull(rs2.getString("BANKER_APPROVE_DATE")));//8
				arrCol.add(correctNull(rs2.getString("ARS_SANCTIONREFNO")));//9
				arrCol.add(Helper.addComma(nf.format(Double.parseDouble(Helper.correctDouble(rs2.getString("BANKER_COMMISSION_EARNED"))))));//3
				if(!correctNull(rs2.getString("BANKER_COMMISSION_EARNED")).equalsIgnoreCase(""))
				{
				actotal=actotal+Float.parseFloat(correctNull(rs2.getString("BANKER_COMMISSION_EARNED")));
				}
				arrCol.add(Helper.addComma(nf.format(Double.parseDouble(Helper.correctDouble(rs2.getString("BANK_CHARGE_APPLICABLE"))))));//3
				if(!correctNull(rs2.getString("BANK_CHARGE_APPLICABLE")).equalsIgnoreCase(""))
				{
				cctotal=cctotal+Float.parseFloat(correctNull(rs2.getString("BANK_CHARGE_APPLICABLE")));
				}
				arrCol.add(correctNull(rs2.getString("COM_BANK_SANSTATUS")));//12
				arrRow.add(arrCol);
			}
			if(rs2!=null)
			{
				rs2.close();
			}
			
			if(rs != null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("selusername^"+strGen);		
			rs= DBUtils.executeQuery(strQuery);
			
			if (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2))+" "+correctNull(rs.getString(3));
			}
			hshRequestValues.put("arrRow",arrRow);
			hshRequestValues.put("genby", strGen);
			hshRequestValues.put("txtSaveDate",strSaveDate);
			hshRequestValues.put("strFromDate",strFromDate);
			hshRequestValues.put("strToDate",strToDate);
			hshRequestValues.put("Org_Name",strOrg_Name);
			hshRequestValues.put("loantype",strloantype);
			hshRequestValues.put("sumofamount",Helper.addComma(nf.format(sumofamount)));
			hshRequestValues.put("actotal",Helper.addComma(nf.format(actotal)));
			hshRequestValues.put("cctotal",Helper.addComma(nf.format(cctotal)));
			hshRequestValues.put("strUserIdforgen",strUserId);
			
	}
	catch(Exception e)
	{
		throw new EJBException("inside getSolvencyReport"+e.toString());
	}
	finally
	{
		try
		{
			if(rs!=null)
			{

				strAppno=Helper.correctNull((String)hshRequestValues.get("hidapplno"));	
			}
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)hshRequestValues.get("hidApplno"));	
			}
			
			
			
			
			strAppno=strappno;
			strQuery=SQLParser.getSqlQuery("sel_bankersreport^"+strappno);
			rs=DBUtils.executeQuery(strQuery);						
			if(rs.next())
			{
				arrCol = new ArrayList();
				if(Helper.correctNull((String) rs.getString("BANKER_SANCTION_FOR")).equalsIgnoreCase("BC"))
				{
				arrCol.add("Bank Certificate");//1
				}
				else
				{
					arrCol.add("Line Certificate");	//1
				}
				arrCol.add(Helper.correctNull((String) rs.getString("BANKER_CBS_ID")));//2
				arrCol.add(Helper.correctNull((String) rs.getString("BANKER_APPLICANT_NAME")));//3
				arrCol.add(Helper.correctNull((String) rs.getString("BANKER_AMOUNT")));//4
				arrCol.add(Helper.correctNull((String) rs.getString("BANKER_BENF_NAME")));//5
				arrCol.add(Helper.correctNull((String) rs.getString("Tender_Notification_date")));//6
				arrCol.add(Helper.correctNull((String) rs.getString("BANKER_BRIEF_WORKORDER")));//7
				arrCol.add(Helper.correctNull((String) rs.getString("BANKER_DATE")));//8
				arrCol.add(Helper.correctNull((String) rs.getString("BANKER_SANC_REF_NO")));//9
				arrCol.add(Helper.correctNull((String) rs.getString("BANKER_SANCTION_DATE")));//10
				arrCol.add(Helper.correctNull((String) rs.getString("BANKER_COMMISSION_EARNED")));//11
				
				
				 int strsno=0;
					rs1=DBUtils.executeLAPSQuery("maxsel_bankcerhisval^"+strappno);
					if(rs1.next())
					{
						strsno=Integer.parseInt(rs1.getString("com_bank_sno"));
					}
					
					
					rs2=DBUtils.executeLAPSQuery("sel_all_bankdetailscount^"+strAppno+"^"+strsno);
					if(rs2.next())
					{
						arrCol.add(Helper.correctNull((String) rs2.getString("com_bank_sanstatus")));//12
					}
					else
					{
						arrCol.add("ACTIVE");//12	
					}
					
					
				arrRow.add(arrCol);
				
			}
			hshRequestValues.put("arrRow", arrRow);
			if (rs != null) {

				rs.close();
			}
						
		}
		catch(Exception e)
		{
			throw new EJBException("close"+e.toString()); 
		}
	}
return hshRequestValues;
 

}*/
	public HashMap getbankdata(HashMap hshRequestValues) 
	{
 		ResultSet rs = null;
 		ResultSet rs1=null,rs2=null,rs3=null;
		
		HashMap hshRec=null;
		ArrayList arrCol =null;
		ArrayList Arrvalues =null;
		String strQuery=null,strQuery1=null;
		String strOrgCode = null;
		String strTemp=null;
		String strFromDate=null;
		String strToDate=null;
		String strSaveDate=null;
		String strDate=null;
		String strGen=null;
		String strOrglevel=null;
		String strOrg_Name = "";
		String strloantype="",appno="";
		String strPeriodicity="";
		HashMap hshResults=new HashMap();
		ArrayList arrBorroweExposure=null;
		ArrayList arrBorroweExposureCol=null;
		double strProposedExposure=0.00;
		double strExistingExposure=0.00,strTotalExposure=0.00;
		String strDepartment="",strAppid="",strDesignation="";
		
		java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.setGroupingUsed(false);
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		double strtotSancamt=0.00;
		StringBuffer strbufOrgcode=new StringBuffer();
		double sanctionamt=0.00;
		String strorgScode="";
		StringBuffer strQueryFirst=new StringBuffer();
		StringBuffer strQueryLast=new StringBuffer();
		StringBuffer strbufDesignation=new StringBuffer();
		String strcreWeight="";
		String strStaffId="";
		String strSessionOrgCode="";
		String residentType="";
		String decodestr="";
		float sumofamount=0f;
		float actotal=0f;
		float cctotal=0f;
		String strUserId="";
		String cubsid="";
		
		try
		{
			ArrayList arrRow=new ArrayList();
			strSessionOrgCode =(String)hshRequestValues.get("org_name");
			strSessionOrgCode = strSessionOrgCode.replaceAll("\'","");
			strDate = correctNull((String)hshRequestValues.get("txtDate"));
			strGen =(String)hshRequestValues.get("strUserId");
			strUserId=(String)hshRequestValues.get("strUserId");
			if(!strDate.equals("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				
			}	
			
			strQuery=SQLParser.getSqlQuery("sel_banker_reportbasedoncusid^"+cubsid);
			
			rs2=DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs2.getString("BANKER_APPL_NO")));//0
				String decode=correctNull(rs2.getString("TYPE_OF_BENEFICIARY"));
				decodestr=SQLParser.getSqlQuery("decodeof_TYPE_OF_BENEFICIARY^"+decode);
				rs=DBUtils.executeQuery(decodestr);
				if(rs.next())
				{
					arrCol.add(correctNull(rs.getString("STAT_DATA_DESC1")));//1	
				}
				arrCol.add(correctNull(rs2.getString("BANKER_CBS_ID")));//1
				arrCol.add(correctNull(rs2.getString("BANKER_APPLICANT_NAME")));//2
				arrCol.add(Helper.addComma(nf.format(Double.parseDouble(Helper.correctDouble(rs2.getString("BANKER_AMOUNT"))))));//3
				if(!correctNull(rs2.getString("BANKER_AMOUNT")).equalsIgnoreCase(""))
				{
				sumofamount=sumofamount+Float.parseFloat(correctNull(rs2.getString("BANKER_AMOUNT")));
				}
				arrCol.add(correctNull(rs2.getString("BANKER_BENF_NAME")));//4
				arrCol.add(correctNull(rs2.getString("TENDER_NOTIFICATION_DATE")));//5
				arrCol.add(correctNull(rs2.getString("BANKER_BRIEF_WORKORDER")));//6
				arrCol.add(correctNull(rs2.getString("BANKER_DATE")));//7
				arrCol.add(correctNull(rs2.getString("BANKER_APPROVE_DATE")));//8
				arrCol.add(correctNull(rs2.getString("ARS_SANCTIONREFNO")));//9
				arrCol.add(Helper.addComma(nf.format(Double.parseDouble(Helper.correctDouble(rs2.getString("BANKER_COMMISSION_EARNED"))))));//3
				if(!correctNull(rs2.getString("BANKER_COMMISSION_EARNED")).equalsIgnoreCase(""))
				{
				actotal=actotal+Float.parseFloat(correctNull(rs2.getString("BANKER_COMMISSION_EARNED")));
				}
				arrCol.add(Helper.addComma(nf.format(Double.parseDouble(Helper.correctDouble(rs2.getString("BANK_CHARGE_APPLICABLE"))))));//3
				if(!correctNull(rs2.getString("BANK_CHARGE_APPLICABLE")).equalsIgnoreCase(""))
				{
				cctotal=cctotal+Float.parseFloat(correctNull(rs2.getString("BANK_CHARGE_APPLICABLE")));
				}
				arrCol.add(correctNull(rs2.getString("COM_BANK_SANSTATUS")));//12
				arrRow.add(arrCol);
			}
			if(rs2!=null)
			{
				rs2.close();
			}
			
			if(rs != null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("selusername^"+strGen);		
			rs= DBUtils.executeQuery(strQuery);
			
			if (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2))+" "+correctNull(rs.getString(3));
			}
			hshRequestValues.put("arrRow",arrRow);
			hshRequestValues.put("genby", strGen);
			hshRequestValues.put("txtSaveDate",strSaveDate);
			hshRequestValues.put("strFromDate",strFromDate);
			hshRequestValues.put("strToDate",strToDate);
			hshRequestValues.put("Org_Name",strOrg_Name);
			hshRequestValues.put("loantype",strloantype);
			hshRequestValues.put("sumofamount",Helper.addComma(nf.format(sumofamount)));
			hshRequestValues.put("actotal",Helper.addComma(nf.format(actotal)));
			hshRequestValues.put("cctotal",Helper.addComma(nf.format(cctotal)));
			hshRequestValues.put("strUserIdforgen",strUserId);
			
	}
	catch(Exception e)
	{
		throw new EJBException("inside getSolvencyReport"+e.toString());
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
			throw new EJBException("close"+e.toString()); 
		}
	}
return hshRequestValues;
 
}
public static String getDate(Calendar cal){
        return "" + cal.get(Calendar.DATE) +"/" +
                (cal.get(Calendar.MONTH)+1) + "/" + cal.get(Calendar.YEAR);
    }


}


