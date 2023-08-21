package com.sai.laps.ejb.setorg;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.SetupParams;

@Stateless(name = "SetOrgBean", mappedName = "SetOrgHome")
@Remote (SetOrgRemote.class)
public class SetOrgBean extends BeanAdapter
{
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(SetOrgBean.class);

	public void updateData(HashMap hshValues) 
	{
		String strAction ="";
		String strLevels ="";	
		String strCodes ="";
		String strExp= "$";
		StringTokenizer stk = null;
		ResultSet rs = null;
		ResultSet rs1 = null;
		int intCount = 0;
		int intCount1 = 0;
		String strOrgHead ="";
		String strSaralHead ="";
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		StringBuilder sbolddata=new StringBuilder();
		String strKeyId="", strQuery1="";
		String strQuery="";
		String strTemp="";
		StringBuilder sbAt = new StringBuilder();
		try
		{	
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			strAction = correctNull((String)hshValues.get("hidAction"));
			strLevels = correctNull((String)hshValues.get("hidlevel"));
			strCodes = correctNull((String)hshValues.get("hidorgcode"));
			strOrgHead = correctNull((String)hshValues.get("userlist"));
			strSaralHead = correctNull((String)hshValues.get("saralhead"));
			stk = new StringTokenizer(strOrgHead,"^");
			if(stk.hasMoreTokens())
			{
				strOrgHead = (String)stk.nextToken();
			}
			stk=new StringTokenizer(strSaralHead,"^");
			if(stk.hasMoreTokens())
			{
				strSaralHead = (String)stk.nextToken();
			}
			if(strAction.equalsIgnoreCase("Update") || strAction.equalsIgnoreCase("delete"))
			{	
				strQuery=SQLParser.getSqlQuery("setorgselect^"+strCodes);
				rs=DBUtils.executeQuery(strQuery);	
				if(rs.next())
				{
					sbolddata.append("Org Name=").append(correctNull((String)rs.getString("org_name")));
					sbolddata.append("~Branch (IBR) Code=").append(correctNull((String)rs.getString("org_scode")));
					if(!correctNull((String)rs.getString("org_taxid")).equalsIgnoreCase("-")){
					sbolddata.append("~BSR Code=").append(correctNull((String)rs.getString("org_taxid")));
					}else{
						sbolddata.append("~BSR Code=").append("");	
					}
					sbolddata.append("~MICRCode=").append(correctNull((String)rs.getString("org_micr")));
					
					if(!correctNull((String)rs.getString("org_add1")).equalsIgnoreCase("")){
						sbolddata.append("~Address=").append(correctNull((String)rs.getString("org_add1"))).append(", ").append(correctNull((String)rs.getString("org_add2")));
					}else{
						sbolddata.append("~Address=").append("");
							
					}
					if(rs1 != null){
						rs1.close();
					}
					
					if(!correctNull((String)rs.getString("org_city")).equalsIgnoreCase("")){
					rs1=DBUtils.executeLAPSQuery("selcitycode^"+correctNull((String)rs.getString("org_city")));
					if(rs1.next()){
						sbolddata.append("~City="+correctNull((String)rs1.getString("city_name")));
					}else{
						sbolddata.append("~City="+"");
					}}else{
						sbolddata.append("~City="+"");
					}
					if(rs1 != null){
						rs1.close();
					}
					
					
					if(!correctNull((String)rs.getString("org_state")).equalsIgnoreCase("")){
					rs1=DBUtils.executeLAPSQuery("selstatename2^"+correctNull((String)rs.getString("org_state")));
					if(rs1.next()){
						sbolddata.append("~State="+correctNull((String)rs1.getString("state_name")));
					}else{
						sbolddata.append("~State="+"");
					}}else{
						sbolddata.append("~State="+"");
					}
					if(rs1 != null){
						rs1.close();
					}
					
					
					sbolddata.append("~Pincode=").append(correctNull((String)rs.getString("org_zip")));
					sbolddata.append("~Phone=").append(correctNull((String)rs.getString("org_phone")));
					sbolddata.append("~Fax=").append(correctNull((String)rs.getString("org_fax")));
					sbolddata.append("~Email ID=").append(correctNull((String)rs.getString("org_url")));
					
					if(!strOrgHead.equals(""))
					{
						strQuery1=SQLParser.getSqlQuery("setuserssel^"+correctNull((String)rs.getString("org_head")));
						rs1=DBUtils.executeQuery(strQuery1);	
						if(rs1.next())
						{
							sbolddata.append("~Organisation Head=").append(correctNull((String)rs1.getString("usr_id"))+" - "+correctNull((String)rs1.getString("usr_fname")).toUpperCase()+" "+correctNull((String)rs1.getString("usr_lname")).toUpperCase());
						}
					}
					else
					{
						sbolddata.append("~Organisation Head=").append("");
					}
					if(rs1 != null){
						rs1.close();
					}
					
					rs1=DBUtils.executeLAPSQuery("getstaticdata_soldid^"+"71^"+correctNull((String)rs.getString("org_branchType")));
					if(rs1.next()){
						sbolddata.append("~BranchType=").append(correctNull((String)rs1.getString("stat_data_desc1")));
					}else{
						sbolddata.append("~BranchType=").append("");
					}
					if(rs1 != null){
						rs1.close();
					}
					//sbolddata.append("~BranchType=").append(SetupParams.getSetupParams("BranchType",correctNull((String)rs.getString("org_branchType"))));
					sbolddata.append("~BranchIn=").append(SetupParams.getSetupParams("BranchIn",correctNull((String)rs.getString("org_branchIn"))));
					sbolddata.append("~Region=").append(SetupParams.getSetupParams("Region",correctNull((String)rs.getString("org_region"))));
					sbolddata.append("~SAA Branch=").append(SetupParams.getSetupParams("SAABranch",correctNull((String)rs.getString("org_saaBranch"))));
					if(correctNull((String)rs.getString("org_saaBranch")).equals("1"))
					{
						sbolddata.append("~No of Villages=").append(correctNull((String)rs.getString("org_village")));
					}
					if(rs1!=null)rs1.close();
					if(!correctNull((String)rs.getString("solid")).equals(""))
					{
						strQuery1=SQLParser.getSqlQuery("getstaticdata_soldid^"+"10"+"^"+correctNull((String)rs.getString("solid")));
						rs1=DBUtils.executeQuery(strQuery1);	
						if(rs1.next())
						{
  							sbolddata.append("~Sol Id=").append(correctNull((String)rs1.getString("stat_data_desc1")));
						}
					}
					else
					{
						sbolddata.append("~Sol Id=").append("");
					}
					if(correctNull((String)rs.getString("org_level")).equals("D"))
					{
						sbolddata.append("~Whether SARAL=").append(SetupParams.getSetupParams("SacrificeLimit",correctNull((String)rs.getString("org_issaral"))).toUpperCase());
						if(correctNull((String)rs.getString("org_issaral")).equalsIgnoreCase("Y")){
						if(!strSaralHead.equals(""))
						{
							strQuery1=SQLParser.getSqlQuery("setuserssel^"+strSaralHead);
							rs1=DBUtils.executeQuery(strQuery1);	
							if(rs1.next())
							{
								sbolddata.append("~SARAL HEAD=").append(correctNull((String)rs1.getString("usr_id")).toUpperCase()+" - "+correctNull((String)rs1.getString("usr_fname")).toUpperCase()+" "+correctNull((String)rs1.getString("usr_lname")).toUpperCase());
							}
						}
						else
						{
							sbolddata.append("~SARAL HEAD=").append("");
						}
					}
					}
					if(correctNull((String)rs.getString("org_level")).equals("A"))
					{
						sbolddata.append("~Whether Internet Application Centre =").append(SetupParams.getSetupParams("SacrificeLimit",correctNull((String)rs.getString("org_internet_centre"))).toUpperCase());
						if(correctNull((String)rs.getString("org_internet_centre")).equalsIgnoreCase("Y")){
						
							sbolddata.append("~Centre Name =").append(correctNull((String)rs.getString("org_centrename")));
							
						} else {
							
							sbolddata.append("~Centre Name =").append("");
						}
					}
					
				}
			}
			String OrgABM = correctNull((String)hshValues.get("user_abm"));
			stk = new StringTokenizer(OrgABM,"^");
			if(stk.hasMoreTokens())
			{
				OrgABM = (String)stk.nextToken();
			}
			if(strAction.equalsIgnoreCase("child"))
			{
				String[] strvalues = strIncrement(strLevels,strCodes);	
				strCodes = strvalues[0];
				strLevels = strvalues[1];				
				hshQueryValues.put("size","1");	
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","setorginsert");
				arrValues.add(strCodes);
				arrValues.add(strLevels);
				arrValues.add(correctNull((String)hshValues.get("txtorg_scode")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_name")).toString().toUpperCase());	
				arrValues.add(correctNull((String)hshValues.get("txtorg_add1")).toString().toUpperCase());
				arrValues.add(correctNull((String)hshValues.get("txtorg_add2")).toString().toUpperCase());
				arrValues.add(correctNull((String)hshValues.get("hidcity")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_zip")));
				arrValues.add(correctNull((String)hshValues.get("hidstate")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_phone")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_fax")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_taxid")));	
				arrValues.add(correctNull((String)hshValues.get("txtorg_trasitid")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_url")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_micr")));
				arrValues.add(strOrgHead);
				arrValues.add(correctNull((String)hshValues.get("branchType")));
				arrValues.add(correctNull((String)hshValues.get("branchIn")));	
				arrValues.add(correctNull((String)hshValues.get("region")));
				arrValues.add(correctNull((String)hshValues.get("saaBranch")));
				arrValues.add(correctNull((String)hshValues.get("txtSAA_branch")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_scode")));//Since solid and Brach code is same
				arrValues.add(correctNull((String)hshValues.get("selissaral")));
				arrValues.add(strSaralHead);
				arrValues.add(correctNull((String)hshValues.get("selisinternet")));
				arrValues.add(correctNull((String)hshValues.get("txt_centrename")));
				arrValues.add(correctNull((String)hshValues.get("txt_opendate")));
				arrValues.add(correctNull((String)hshValues.get("hid_district")));//added by subha
				arrValues.add(correctNull((String)hshValues.get("sel_excelupload")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_mgrphn")));
				arrValues.add(correctNull((String)hshValues.get("txt_ifsccode")));
				arrValues.add(OrgABM);
				arrValues.add(correctNull((String)hshValues.get("txtorg_abmno")));
				hshQuery.put("arrValues",arrValues);	
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				if(Helper.correctNull(ApplicationParams.getMONITORINGDBENABLED()).equalsIgnoreCase("YES")){
					hshQueryValues =new HashMap();
					arrValues = new ArrayList();
					hshQuery=new HashMap();			
					hshQueryValues.put("size","1");	
					hshQuery=new HashMap();
					hshQuery.put("strQueryId","setorginsert_mon");
					arrValues.add(strCodes);
					arrValues.add(strLevels);
					arrValues.add(correctNull((String)hshValues.get("txtorg_scode")));
					arrValues.add(correctNull((String)hshValues.get("txtorg_name")).toString().toUpperCase());	
					arrValues.add(correctNull((String)hshValues.get("txtorg_add1")).toString().toUpperCase());
					arrValues.add(correctNull((String)hshValues.get("txtorg_add2")).toString().toUpperCase());
					arrValues.add(correctNull((String)hshValues.get("hidcity")));
					arrValues.add(correctNull((String)hshValues.get("txtorg_zip")));
					arrValues.add(correctNull((String)hshValues.get("hidstate")));
					arrValues.add(correctNull((String)hshValues.get("txtorg_phone")));
					arrValues.add(correctNull((String)hshValues.get("txtorg_fax")));
					arrValues.add(correctNull((String)hshValues.get("txtorg_taxid")));	
					arrValues.add(correctNull((String)hshValues.get("txtorg_trasitid")));
					arrValues.add(correctNull((String)hshValues.get("txtorg_url")));
					arrValues.add(correctNull((String)hshValues.get("txtorg_micr")));
					arrValues.add(strOrgHead);
					arrValues.add(correctNull((String)hshValues.get("branchType")));
					arrValues.add(correctNull((String)hshValues.get("branchIn")));	
					arrValues.add(correctNull((String)hshValues.get("region")));
					arrValues.add(correctNull((String)hshValues.get("saaBranch")));
					arrValues.add(correctNull((String)hshValues.get("txtSAA_branch")));
					arrValues.add(correctNull((String)hshValues.get("txtorg_scode")));//Since solid and Brach code is same
					arrValues.add(correctNull((String)hshValues.get("selissaral")));
					arrValues.add(strSaralHead);
					arrValues.add(correctNull((String)hshValues.get("selisinternet")));
					arrValues.add(correctNull((String)hshValues.get("txt_centrename")));
					arrValues.add(correctNull((String)hshValues.get("txt_opendate")));
					arrValues.add(correctNull((String)hshValues.get("hid_district")));//added by subha
					arrValues.add(correctNull((String)hshValues.get("sel_excelupload")));
					arrValues.add(correctNull((String)hshValues.get("txt_ifsccode")));
					arrValues.add(OrgABM);
					arrValues.add(correctNull((String)hshValues.get("txtorg_abmno")));
					hshQuery.put("arrValues",arrValues);	
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateMonitoringData");
					
				}
				
				if(Helper.correctNull(ApplicationParams.getstrOnlineEnabled()).equalsIgnoreCase("YES")){
				hshQueryValues =new HashMap();
				arrValues = new ArrayList();
				hshQuery=new HashMap();
				hshQueryValues.put("size","1");	
				hshQuery.put("strQueryId","ins_setorg_online");
				arrValues.add(strCodes);
				arrValues.add(strLevels);
				arrValues.add(correctNull((String)hshValues.get("txtorg_scode")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_name")).toString().toUpperCase());	
				arrValues.add(correctNull((String)hshValues.get("txtorg_add1")).toString().toUpperCase());
				arrValues.add(correctNull((String)hshValues.get("txtorg_add2")).toString().toUpperCase());
				arrValues.add(correctNull((String)hshValues.get("hidcity")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_zip")));
				arrValues.add(correctNull((String)hshValues.get("hidstate")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_phone")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_fax")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_taxid")));	
				arrValues.add(correctNull((String)hshValues.get("txtorg_trasitid")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_url")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_micr")));
				arrValues.add(strOrgHead);
				if(rs1 != null)
				{rs1.close();}
				if(!correctNull((String)hshValues.get("hidcity")).equalsIgnoreCase("")){
				rs1=DBUtils.executeLAPSQuery("selcitycode^"+correctNull((String)hshValues.get("hidcity")));
				if(rs1.next()){
					strTemp=correctNull(rs1.getString("city_name")).trim();
					strTemp=strTemp.replaceAll(" ", "");
					arrValues.add(strTemp);
				}
				else{
					arrValues.add("");
					}
				}else{
						arrValues.add("");
				}
				if(rs1 != null)
				{rs1.close();}
				if(!correctNull((String)hshValues.get("hidstate")).equalsIgnoreCase("")){
					rs1=DBUtils.executeLAPSQuery("selstatename2^"+correctNull((String)hshValues.get("hidstate")));
					if(rs1.next()){
						strTemp=correctNull(rs1.getString("state_name")).trim();
						strTemp=strTemp.replaceAll(" ", "");
						arrValues.add(strTemp);
					}
					else{
						arrValues.add("");
						}
				}else{
						arrValues.add("");
				}
				arrValues.add(correctNull((String)hshValues.get("hid_district")));//added by subha
				if(rs1 != null)
				{rs1.close();}
				if(!correctNull((String)hshValues.get("hid_district")).equalsIgnoreCase("")){
					rs1=DBUtils.executeLAPSQuery("sel_districtmaster^"+correctNull((String)hshValues.get("hid_district")));
					if(rs1.next()){
						strTemp=correctNull(rs1.getString("district_desc")).trim();
						strTemp=strTemp.replaceAll(" ", "");
						arrValues.add(strTemp);
					}
					else{
						arrValues.add("");
						}
				}else{
						arrValues.add("");
				}
				arrValues.add(correctNull((String)hshValues.get("sel_excelupload")));
				hshQuery.put("arrValues",arrValues);	
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateInternetData");
			
			}
			
				//Branch User Creation
				hshQueryValues=new HashMap();
				arrValues = new ArrayList();
				hshQuery=new HashMap();
				hshQueryValues.put("size","1");	
				hshQuery.put("strQueryId","insertbranchuser");
				arrValues.add("BR"+correctNull((String)hshValues.get("txtorg_scode")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_name")).toUpperCase());
				arrValues.add(strCodes);
				hshQuery.put("arrValues",arrValues);	
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
			}
			else if(strAction.equalsIgnoreCase("update"))
			{			
				hshQueryValues.put("size","1");
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","setorgupdate");			
				arrValues.add(strLevels);
				arrValues.add(correctNull((String)hshValues.get("txtorg_scode")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_name").toString().toUpperCase()));
				arrValues.add(correctNull((String)hshValues.get("txtorg_add1").toString().toUpperCase()));
				arrValues.add(correctNull((String)hshValues.get("txtorg_add2").toString().toUpperCase()));
				arrValues.add(correctNull((String)hshValues.get("hidcity")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_zip")));
				arrValues.add(correctNull((String)hshValues.get("hidstate")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_phone")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_fax")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_taxid")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_trasitid")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_url")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_micr")));
				arrValues.add(strOrgHead);
				arrValues.add(correctNull((String)hshValues.get("branchType")));
				arrValues.add(correctNull((String)hshValues.get("branchIn")));	
				arrValues.add(correctNull((String)hshValues.get("region")));
				arrValues.add(correctNull((String)hshValues.get("saaBranch")));
				arrValues.add(correctNull((String)hshValues.get("txtSAA_branch")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_scode")));//Since Solid and Branch code is same
				arrValues.add(correctNull((String)hshValues.get("selissaral")));
				arrValues.add(strSaralHead);
				arrValues.add(correctNull((String)hshValues.get("selisinternet")));
				arrValues.add(correctNull((String)hshValues.get("txt_centrename")));
				arrValues.add(correctNull((String)hshValues.get("txt_opendate")));
				arrValues.add(correctNull((String)hshValues.get("hid_district")));//added by subha 
				arrValues.add(correctNull((String)hshValues.get("sel_excelupload")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_mgrphn")));
				arrValues.add(correctNull((String)hshValues.get("txt_ifsccode")));
				arrValues.add(OrgABM);
				arrValues.add(correctNull((String)hshValues.get("txtorg_abmno")));
				arrValues.add(strCodes);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				if(Helper.correctNull(ApplicationParams.getMONITORINGDBENABLED()).equalsIgnoreCase("YES")){
					hshQueryValues =new HashMap();
					arrValues = new ArrayList();
					hshQuery=new HashMap();	
					hshQueryValues.put("size","1");
					hshQuery=new HashMap();
					hshQuery.put("strQueryId","setorgupdate_mon");			
					arrValues.add(strLevels);
					arrValues.add(correctNull((String)hshValues.get("txtorg_scode")));
					arrValues.add(correctNull((String)hshValues.get("txtorg_name").toString().toUpperCase()));
					arrValues.add(correctNull((String)hshValues.get("txtorg_add1").toString().toUpperCase()));
					arrValues.add(correctNull((String)hshValues.get("txtorg_add2").toString().toUpperCase()));
					arrValues.add(correctNull((String)hshValues.get("hidcity")));
					arrValues.add(correctNull((String)hshValues.get("txtorg_zip")));
					arrValues.add(correctNull((String)hshValues.get("hidstate")));
					arrValues.add(correctNull((String)hshValues.get("txtorg_phone")));
					arrValues.add(correctNull((String)hshValues.get("txtorg_fax")));
					arrValues.add(correctNull((String)hshValues.get("txtorg_taxid")));
					arrValues.add(correctNull((String)hshValues.get("txtorg_trasitid")));
					arrValues.add(correctNull((String)hshValues.get("txtorg_url")));
					arrValues.add(correctNull((String)hshValues.get("txtorg_micr")));
					arrValues.add(strOrgHead);
					arrValues.add(correctNull((String)hshValues.get("branchType")));
					arrValues.add(correctNull((String)hshValues.get("branchIn")));	
					arrValues.add(correctNull((String)hshValues.get("region")));
					arrValues.add(correctNull((String)hshValues.get("saaBranch")));
					arrValues.add(correctNull((String)hshValues.get("txtSAA_branch")));
					arrValues.add(correctNull((String)hshValues.get("txtorg_scode")));//Since Solid and Branch code is same
					arrValues.add(correctNull((String)hshValues.get("selissaral")));
					arrValues.add(strSaralHead);
					arrValues.add(correctNull((String)hshValues.get("selisinternet")));
					arrValues.add(correctNull((String)hshValues.get("txt_centrename")));
					arrValues.add(correctNull((String)hshValues.get("txt_opendate")));
					arrValues.add(correctNull((String)hshValues.get("hid_district")));//added by subha 
					arrValues.add(correctNull((String)hshValues.get("sel_excelupload")));
					arrValues.add(correctNull((String)hshValues.get("txt_ifsccode")));
					arrValues.add(OrgABM);
					arrValues.add(correctNull((String)hshValues.get("txtorg_abmno")));
					arrValues.add(strCodes);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateMonitoringData");
					
				}
				
				if(Helper.correctNull(ApplicationParams.getstrOnlineEnabled()).equalsIgnoreCase("YES")){
				hshQuery=new HashMap();
				hshQueryValues =new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","upd_setorg_online");			
				arrValues.add(strLevels);
				arrValues.add(correctNull((String)hshValues.get("txtorg_scode")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_name").toString().toUpperCase()));
				arrValues.add(correctNull((String)hshValues.get("txtorg_add1").toString().toUpperCase()));
				arrValues.add(correctNull((String)hshValues.get("txtorg_add2").toString().toUpperCase()));
				arrValues.add(correctNull((String)hshValues.get("hidcity")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_zip")));
				arrValues.add(correctNull((String)hshValues.get("hidstate")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_phone")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_fax")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_taxid")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_trasitid")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_url")));
				arrValues.add(correctNull((String)hshValues.get("txtorg_micr")));
				arrValues.add(strOrgHead);
				if(rs1 != null)
				{rs1.close();}
				if(!correctNull((String)hshValues.get("hidcity")).equalsIgnoreCase("")){
				rs1=DBUtils.executeLAPSQuery("selcitycode^"+correctNull((String)hshValues.get("hidcity")));
				if(rs1.next()){
					strTemp=correctNull(rs1.getString("city_name")).trim();
					strTemp=strTemp.replaceAll(" ", "");
					arrValues.add(strTemp);
				}
				else{
					arrValues.add("");
					}
				}else{
						arrValues.add("");
				}
				if(rs1 != null)
				{rs1.close();}
				if(!correctNull((String)hshValues.get("hidstate")).equalsIgnoreCase("")){
					rs1=DBUtils.executeLAPSQuery("selstatename2^"+correctNull((String)hshValues.get("hidstate")));
					if(rs1.next()){
						strTemp=correctNull(rs1.getString("state_name")).trim();
						strTemp=strTemp.replaceAll(" ", "");
						arrValues.add(strTemp);
					}
					else{
						arrValues.add("");
						}
				}else{
					arrValues.add("");
				}
				arrValues.add(correctNull((String)hshValues.get("hid_district")));//added by subha 
				if(rs1 != null)
				{rs1.close();}
				if(!correctNull((String)hshValues.get("hid_district")).equalsIgnoreCase("")){
					rs1=DBUtils.executeLAPSQuery("sel_districtmaster^"+correctNull((String)hshValues.get("hid_district")));
					if(rs1.next()){
						strTemp=correctNull(rs1.getString("district_desc")).trim();
						strTemp=strTemp.replaceAll(" ", "");
						arrValues.add(strTemp);
					}
					else{
						arrValues.add("");
						}
				}else{
						arrValues.add("");
				}
				arrValues.add(correctNull((String)hshValues.get("sel_excelupload")));
				arrValues.add(strCodes);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateInternetData");
			}}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				String strLevelsDel = "";
				String strCodesDel = "";
				strLevelsDel = correctNull((String)hshValues.get("hidleveldel"));
				strCodesDel = correctNull((String)hshValues.get("hidorgcodedel"));
				rs = null;
				rs=DBUtils.executeLAPSQuery("setorgdelcheck^"+strCodesDel+"^"+strLevelsDel);
				if(rs.next())
				{
					intCount = Integer.parseInt(rs.getString(1));
				}
				int intCount2=0;
				rs=DBUtils.executeLAPSQuery("setdelcheckuser^"+strCodes);
				if(rs.next())
				{
					intCount2 = Integer.parseInt(rs.getString(1));
				}
				if(intCount2 == 0)
				{
					hshQueryValues.put("size","1");
					hshQuery=new HashMap();
					hshQuery.put("strQueryId","setorgdel");
					arrValues.add(strCodes);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					if(Helper.correctNull(ApplicationParams.getMONITORINGDBENABLED()).equalsIgnoreCase("YES")){
						hshQueryValues =new HashMap();
						hshQueryValues.put("size","1");
						hshQuery=new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId","setorgdel_monitoring");
						arrValues.add(strCodes);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateMonitoringData");
					}
					
					if(Helper.correctNull(ApplicationParams.getstrOnlineEnabled()).equalsIgnoreCase("YES")){
					hshQuery=new HashMap();
					hshQueryValues =new HashMap();
					arrValues = new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","setorgdel");
					arrValues.add(strCodes);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateInternetData");
				}}
				else
				{
					strExp = strExp+"Cannot delete this organisation, its attached to user";
					throw new Exception(strExp);					
				}
				rs = null;
				if(strLevelsDel.equalsIgnoreCase("B") && strCodesDel.length() == 15)
				{
					intCount = 0;
				}
				if(intCount == 0)
				{
					rs1 = null;
					String strOrgcode=correctNull((String)hshValues.get("txtorg_scode"));
					rs1=DBUtils.executeLAPSQuery("setorgdelcheckprd^"+strLevels+"^"+strOrgcode);
					if(rs1.next())
					{
						intCount1 = Integer.parseInt(rs1.getString(1));
					}
					ArrayList arrValues1=new ArrayList();
					if(intCount1 == 0)
					{
						hshQueryValues.put("size","1");
						hshQuery=new HashMap();
						arrValues1=new ArrayList();
						hshQuery.put("strQueryId","setorgdel");
						arrValues1.add(strCodes);
						hshQuery.put("arrValues",arrValues1);
						hshQueryValues.put("1",hshQuery);						
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						
						if(Helper.correctNull(ApplicationParams.getstrOnlineEnabled()).equalsIgnoreCase("YES")){
						hshQuery=new HashMap();
						hshQueryValues =new HashMap();
						arrValues = new ArrayList();
						hshQueryValues.put("size","1");
						hshQuery.put("strQueryId","setorgdel");
						arrValues.add(strCodes);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateInternetData");
					}
						if(Helper.correctNull(ApplicationParams.getMONITORINGDBENABLED()).equalsIgnoreCase("YES")){
							hshQuery=new HashMap();
							hshQueryValues =new HashMap();
							arrValues = new ArrayList();
							hshQueryValues.put("size","1");
							hshQuery.put("strQueryId","setorgdel_monitoring");
							arrValues.add(strCodes);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateMonitoringData");
						}	
					}
					else
					{
						strExp = strExp+"Cannot delete this organisation, its having products";
						throw new Exception(strExp);
					}
				}
				else
				{
					strExp = strExp+"Cannot delete this organisation, its having child organisation or applications";
					throw new Exception(strExp);
				}				
			}	
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("child"))
			{
				sbAt.append("Org Name=").append(correctNull((String)hshValues.get("txtorg_name")));
				sbAt.append("~Branch (IBR) Code="+correctNull((String)hshValues.get("txtorg_scode")));
				if(!correctNull((String)hshValues.get("bsr1")).equalsIgnoreCase("")){
				sbAt.append("~BSR Code="+correctNull((String)hshValues.get("bsr1"))+ "-" +correctNull((String)hshValues.get("bsr2")));
				}else{
					sbAt.append("~BSR Code=");
						
				}
				sbAt.append("~MICRCode="+correctNull((String)hshValues.get("txtorg_micr")));
				
				if(!correctNull((String)hshValues.get("txtorg_add1")).equalsIgnoreCase("")){
					sbAt.append("~Address="+correctNull((String)hshValues.get("txtorg_add1"))+", "+correctNull((String)hshValues.get("txtorg_add2")));
				}else{
					sbAt.append("~Address=");
				}
				
				sbAt.append("~City="+correctNull((String)hshValues.get("txtorg_city")));
				sbAt.append("~State="+correctNull((String)hshValues.get("txtorg_state")));
				sbAt.append("~Pincode="+correctNull((String)hshValues.get("txtorg_zip")));
				sbAt.append("~Phone="+correctNull((String)hshValues.get("txtorg_phone")));
				sbAt.append("~Fax="+correctNull((String)hshValues.get("txtorg_fax")));
				sbAt.append("~Email ID="+correctNull((String)hshValues.get("txtorg_url")));
				sbAt.append("~Organisation Head="+correctNull((String)hshValues.get("hidorghead")));
				
				if(rs1 != null){
					rs1.close();
				}
				
				rs1=DBUtils.executeLAPSQuery("getstaticdata_soldid^"+"71^"+correctNull((String)hshValues.get("branchType")));
				if(rs1.next()){
					sbAt.append("~BranchType="+correctNull((String)rs1.getString("stat_data_desc1")));
				}else{
					sbAt.append("~BranchType="+"");
				}
				if(rs1 != null){
					rs1.close();
				}
				
				sbAt.append("~BranchIn="+SetupParams.getSetupParams("BranchIn",correctNull((String)hshValues.get("branchIn"))));
				sbAt.append("~Region="+SetupParams.getSetupParams("Region",correctNull((String)hshValues.get("region"))));
				sbAt.append("~SAA Branch="+SetupParams.getSetupParams("SAABranch",correctNull((String)hshValues.get("saaBranch"))));
				if(correctNull((String)hshValues.get("saaBranch")).equals("1"))
				{
					sbAt.append("~No of Villages="+correctNull((String)hshValues.get("txtSAA_branch")));
				}
				sbAt.append("~Sol Id="+correctNull((String)hshValues.get("hidsolid")));
				if(strLevels.equals("D"))
				{
					sbAt.append("~Whether SARAL="+SetupParams.getSetupParams("SacrificeLimit", correctNull((String)hshValues.get("hidsaral"))));
					if(correctNull((String)hshValues.get("hidsaral")).equalsIgnoreCase("YES")){
					sbAt.append("~SARAL HEAD="+correctNull((String)hshValues.get("hidsaralhead")));}
				}
				if(strLevels.equals("A"))
				{
					sbAt.append("~Whether Internet Application Centre ="+SetupParams.getSetupParams("SacrificeLimit", correctNull((String)hshValues.get("selisinternet"))));
					if(correctNull((String)hshValues.get("selisinternet")).equalsIgnoreCase("Y")){
					sbAt.append("~Centre Name ="+correctNull((String)hshValues.get("txt_centrename")));}
				}
			}
			if(strAction.equalsIgnoreCase("child") && (correctNull((String)hshValues.get("hidRecordflag")).equals("N") || correctNull((String)hshValues.get("hidRecordflag")).equals("")))
			{
				hshValues.put("hidAction", "insert");	
			}
			if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
			{
				hshValues.put("hidAction", "update");	
			}
			
			
			AuditTrial.auditNewLog(hshValues,"5",strKeyId,sbAt.toString(),sbolddata.toString());	
		}
		catch(Exception ce)
		{			
			if(strAction.equalsIgnoreCase("delete"))
			{
				throw new EJBException(ce.getMessage());				
			}
			else
			{
				throw new EJBException(ce);
			}
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
	}
	public String getRegionalOffice(HashMap hshParamter)
	{
		String strRegionalOffice="";
		String strRegioanlCode="";
		String strRO="";
		String strPage="";
		String strFirstRORemaining="";
		String strLastRORemaining="";
		try
		{
			strRegionalOffice=Helper.correctNull((String)hshParamter.get("strRegionalOffice"));
			strPage=Helper.correctNull((String)hshParamter.get("strPage"));
			
			if(strPage.equalsIgnoreCase("appsearch"))//Searching the name for creating an application
			{
				strFirstRORemaining=strRegionalOffice.substring(0,1);
				strRO=strRegionalOffice.substring(1,7);
				strLastRORemaining=strRegionalOffice.substring(7);
			}
			if(strPage.equalsIgnoreCase("mastsearch"))//Searching for Masters Page
			{
				strFirstRORemaining=strRegionalOffice.substring(0,6);
				strRO=strRegionalOffice.substring(0,6);
				strLastRORemaining=strRegionalOffice.substring(6,7);
			}
			
			if(strRO.equalsIgnoreCase("001001"))
			{
				if(strPage.equalsIgnoreCase("appsearch"))
				{
					strRegioanlCode=strFirstRORemaining+strRO.substring(0,3)+"%%%"+strLastRORemaining+" and org_level <> 'C'";
				}
				else if(strPage.equalsIgnoreCase("mastsearch"))
				{
					strRegioanlCode=strFirstRORemaining;
				}
			}
			else
			{
				strRegioanlCode=strRegionalOffice;
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in Regional Office"+e.getMessage());
		}
		return strRegioanlCode;
	}

	public HashMap getData(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = null;
		HashMap hshRecords = null;
		HashMap hshLevels = null;
		String strorgcode ="";
		String strorgcode1 ="";
		String strorgcode2 ="";
		String strorgcode3 ="";
		String strorgcode4 ="";
		String strorgcode5 ="";
		String strorgcodevalue1 ="";
		String strorgcodevalue2 ="";
		String strorgcodevalue3 ="";
		String strorgcodevalue4 ="";
		String strorgcodevalue5 ="";
		String strhidOrgCode="";
		boolean recordflag=false; 
		try
		{
			strorgcode1 = correctNull((String)hshRequestValues.get("hidsetorghelp1"));
			strorgcodevalue1 = correctNull((String)hshRequestValues.get("hidsetorghelpvalue1"));
			strorgcode2 = correctNull((String)hshRequestValues.get("hidsetorghelp2"));
			strorgcodevalue2 = correctNull((String)hshRequestValues.get("hidsetorghelpvalue2"));
			strorgcode3 = correctNull((String)hshRequestValues.get("hidsetorghelp3"));
			strorgcodevalue3 = correctNull((String)hshRequestValues.get("hidsetorghelpvalue3"));
			strorgcode4 = correctNull((String)hshRequestValues.get("hidsetorghelp4"));
			strorgcodevalue4 = correctNull((String)hshRequestValues.get("hidsetorghelpvalue4"));
			strorgcode5 = correctNull((String)hshRequestValues.get("hidsetorghelp5"));
			strorgcodevalue5 = correctNull((String)hshRequestValues.get("hidsetorghelpvalue5"));
			strhidOrgCode = correctNull((String)hshRequestValues.get("hidOrgCode"));
			if(!strorgcode1.equals(""))
			{
				strorgcode = strorgcodevalue1;
			}
			if(!strorgcode2.equals(""))
			{
				strorgcode = strorgcodevalue2;
			}
			if(!strorgcode3.equals(""))
			{
				strorgcode = strorgcodevalue3;
			}
			if(!strorgcode4.equals(""))
			{
				strorgcode = strorgcodevalue4;
			}
			if(!strorgcode5.equals(""))
			{
				strorgcode = strorgcodevalue5;
			}
			rs=DBUtils.executeLAPSQuery("setorgselect^"+strorgcode);
			hshRecord = new HashMap();
			hshRecords = new HashMap();
			hshLevels = new HashMap();
			hshRecord.put("strorgcode1",strorgcode1);
			hshRecord.put("strorgcode2",strorgcode2);
			hshRecord.put("strorgcode3",strorgcode3);
			hshRecord.put("strorgcode4",strorgcode4);
			hshRecord.put("strorgcode5",strorgcode5);

			while(rs.next())
			{
				recordflag=true;
				hshRecord.put("txtorg_code",correctNull(rs.getString("org_code")));
				hshRecord.put("txtorg_name",correctNull(rs.getString("org_name")));
				hshRecord.put("txtorg_scode",correctNull(rs.getString("org_scode")));
				hshRecord.put("txtorg_taxid",correctNull(rs.getString("org_taxid")));
				hshRecord.put("txtorg_trasitid",correctNull(rs.getString("org_trasitid")));
				hshRecord.put("txtorg_add1",Helper.correctDoubleQuote(rs.getString("org_add1")));
				hshRecord.put("txtorg_add2",Helper.correctDoubleQuote(rs.getString("org_add2")));
				hshRecord.put("txtorg_city",correctNull(rs.getString("city_name")));
				hshRecord.put("txtorg_state",correctNull(rs.getString("state_name")));
				hshRecord.put("txtorg_zip",correctNull(rs.getString("org_zip")));
				hshRecord.put("txtorg_phone",correctNull(rs.getString("org_phone")));
				hshRecord.put("txtorg_fax",correctNull(rs.getString("org_fax")));
				hshRecord.put("txtorg_url",correctNull(rs.getString("org_url")));
				hshRecord.put("txtorg_level",correctNull(rs.getString("org_level")));
				hshRecord.put("txtorg_micr",correctNull(rs.getString("org_micr")));
				String	strOrgHead = correctNull((String)rs.getString("org_head"));
				
				hshRecord.put("branchType",correctNull(rs.getString("org_branchType")));
				hshRecord.put("branchIn",correctNull(rs.getString("org_branchIn")));
				hshRecord.put("region",correctNull(rs.getString("org_region")));
				hshRecord.put("saaBranch",correctNull(rs.getString("org_saaBranch")));
				hshRecord.put("txtSAA_branch",correctNull(rs.getString("org_village")));
				hshRecord.put("solid",correctNull(rs.getString("solid")));
				hshRecord.put("issaral",correctNull(rs.getString("org_issaral")));
				hshRecord.put("saralhead",correctNull(rs.getString("org_saralhead")));
				hshRecord.put("isinternet",correctNull(rs.getString("org_internet_centre")));
				hshRecord.put("centrename",correctNull(rs.getString("org_centrename")));
				hshRecord.put("citycode",correctNull(rs.getString("org_city")));
				hshRecord.put("statecode",correctNull(rs.getString("org_state")));
				hshRecord.put("opendate",correctNull(rs.getString("org_opendate")));
				hshRecord.put("districtcode",correctNull(rs.getString("org_district")));
				hshRecord.put("txtorg_district",correctNull(rs.getString("district_desc")));
				hshRecord.put("strExceluploadFlag",correctNull(rs.getString("org_excelupload_flag")));
				hshRecord.put("txtorg_mgrphn",correctNull(rs.getString("org_manager_ctnum")));
				hshRecord.put("strOrgIFSCcode",correctNull(rs.getString("org_ifsccode")));
				hshRecord.put("strOrgABMID",correctNull(rs.getString("org_abmid")));
				hshRecord.put("strOrgOrgABMMOB",correctNull(rs.getString("org_abmmobile")));
				
				StringTokenizer	stk = new StringTokenizer(strOrgHead,"^");
				if(stk.hasMoreTokens())
				{
					strOrgHead = (String)stk.nextToken();
				}
				hshRecord.put("userlist",strOrgHead);
			}
            rs.close();
			rs=DBUtils.executeLAPSQuery("setorgselectlevel");
			while(rs.next())
			{
				hshLevels.put("glp_orglevel",correctNull(rs.getString("glp_orglevel")));
				hshLevels.put("glp_orgname1",correctNull(rs.getString("glp_orgname1")));
				hshLevels.put("glp_orgname2",correctNull(rs.getString("glp_orgname2")));
				hshLevels.put("glp_orgname3",correctNull(rs.getString("glp_orgname3")));
				hshLevels.put("glp_orgname4",correctNull(rs.getString("glp_orgname4")));
				hshLevels.put("glp_orgname5",correctNull(rs.getString("glp_orgname5")));
			}
			hshRecords.put("hshRecord",hshRecord);
			hshRecords.put("hshLevels",hshLevels);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
			rs.close();
			
			hshRecords.put("hidOrgCode",strhidOrgCode);
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
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
		if(Helper.correctNull((String)hshRequestValues.get("hidAction")).equalsIgnoreCase("Move"))
			hshRecords.put("Status", "Success");
		return hshRecords;
	}


	public HashMap getDataHelp(HashMap hshParamter) 
	{
		String strName="";
		String strVal="";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecCodes = new ArrayList();
		ArrayList vecValues = new ArrayList();
		String strDynquery = (String)hshParamter.get("TagQuery");
		int intTokens =0;
		try
		{
			StringTokenizer strHelpTok =new StringTokenizer(strDynquery,"^");
			intTokens = strHelpTok.countTokens();
			if(intTokens == 2)
			{
				strName = strHelpTok.nextToken();
				strVal =  strHelpTok.nextToken();
			}
			else
			{
				strName ="";
				strVal  ="";
			}

			rs=DBUtils.executeLAPSQuery("setorghelp^"+strName+"^"+strVal);
			while(rs.next())
			{
				vecCodes.add(correctNull(rs.getString("org_code")));
				vecValues.add(correctNull(rs.getString("org_name")));
			}
			hshRecord.put("vecCodes",vecCodes);
			hshRecord.put("vecValues",vecValues);
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
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
		return hshRecord;
	}

	private String[] strIncrement(String strCode,String strValue)
	{
		ResultSet rs = null;
		int intValue = 0;
		String strValues[]=new String[2];
		java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
		nf.setMinimumIntegerDigits(3);
		try
		{
			if(strCode.equalsIgnoreCase("C"))
			{
				String strLValue="";
				String strTempValue ="";
				strTempValue = strValue;
				strLValue = strValue.substring(0,3);
				rs=DBUtils.executeLAPSQuery("setorgmaxcode^"+strLValue+"^R");
				if(rs.next())
				{
					strValue = correctNull(rs.getString(1));
				}
				if(strValue.equals("") || strValue == null)
				{
					strValue = strTempValue;
					intValue = Integer.parseInt(strValue.substring(3,6));
					intValue = intValue + 1;
					strValue = strValue.substring(0,3)+nf.format((long)intValue)+
					strValue.substring(6,strValue.length());
				}
				else
				{
					intValue = Integer.parseInt(strValue.substring(3,6));
					intValue = intValue + 1;
					strValue = strValue.substring(0,3)+nf.format((long)intValue)+
					strValue.substring(6,strValue.length());
				}
				strValues[0]=strValue;
				strValues[1]="R";
			}
			else if(strCode.equalsIgnoreCase("R"))
			{
				String strLValue="";
				String strTempValue ="";
				strTempValue = strValue;
				strLValue = strValue.substring(0,6);
				rs=DBUtils.executeLAPSQuery("setorgmaxcode^"+strLValue+"^D");
				if(rs.next())
				{
					strValue = correctNull(rs.getString(1));
				}
				if(strValue.equals("") || strValue == null)
				{
					strValue = strTempValue;
					intValue = Integer.parseInt(strValue.substring(6,9));
					intValue = intValue + 1;
					strValue = strValue.substring(0,6)+nf.format((long)intValue)+
					strValue.substring(9,strValue.length());
				}
				else 
				{
					intValue = Integer.parseInt(strValue.substring(6,9));
					intValue = intValue + 1;
					strValue = strValue.substring(0,6)+nf.format((long)intValue)+
					strValue.substring(9,strValue.length());
				}
				strValues[0]=strValue;
				strValues[1]="D";
			}
			else if(strCode.equalsIgnoreCase("D"))
			{
				String strLValue="";
				String strTempValue ="";
				strTempValue = strValue;
				strLValue = strValue.substring(0,9);
				rs=DBUtils.executeLAPSQuery("setorgmaxcode^"+strLValue+"^A");
				if(rs.next())
				{
					strValue = correctNull(rs.getString(1));
				}
				if(strValue.equals("") || strValue == null)
				{
					strValue = strTempValue;
					intValue = Integer.parseInt(strValue.substring(9,12));
					intValue = intValue + 1;
					strValue= strValue.substring(0,9)+nf.format((long)intValue)+
					strValue.substring(12,strValue.length());
				}
				else
				{
					intValue = Integer.parseInt(strValue.substring(9,12));
					intValue = intValue + 1;
					strValue= strValue.substring(0,9)+nf.format((long)intValue)+
					strValue.substring(12,strValue.length());
				}
				strValues[0]=strValue;
				strValues[1]="A";
			}
			else if(strCode.equalsIgnoreCase("A"))
			{
				String strLValue="";
				String strTempValue ="";
				strTempValue = strValue;
				strLValue = strValue.substring(0,12);
				rs=DBUtils.executeLAPSQuery("setorgmaxcode^"+strLValue+"^B");
				if(rs.next())
				{
					strValue = correctNull(rs.getString(1));
				}	
				if(strValue.equals("") || strValue == null)
				{
					strValue = strTempValue;
					intValue = Integer.parseInt(strValue.substring(12,15));
					intValue = intValue + 1;
					strValue= strValue.substring(0,12)+nf.format((long)intValue)+
					strValue.substring(15,strValue.length());
				}
				else
				{
					intValue = Integer.parseInt(strValue.substring(12,15));
					intValue = intValue + 1;
					strValue= strValue.substring(0,12)+nf.format((long)intValue)+
					strValue.substring(15,strValue.length());
				}
				strValues[0]=strValue;
				strValues[1]="B";	
			}
		}
		catch(Exception e)
		{
			log.error("Number format "+e);			
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
		return strValues;
	}
	public HashMap getDuplicateCheck(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		String branchcode=Helper.correctNull((String)hshValues.get("branchcode"));
		String solid=Helper.correctNull((String)hshValues.get("solid"));
		String strOrgCode=Helper.correctNull((String)hshValues.get("orgcode"));
		try
		{
			if(rs!=null)
			{
				rs.close();
			}
			if(!branchcode.equals(""))
			{
				strQuery=SQLParser.getSqlQuery("checkDuplicateBranchcode^"+branchcode+"^"+strOrgCode);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshResult.put("Branchname",correctNull((String)rs.getString("org_name")));
					hshResult.put("BranchCode","Already Used Number");
				}
			}
			if(rs!=null)
			{
				rs.close();
			}
			if(!solid.equals("0"))
			{
				strQuery=SQLParser.getSqlQuery("checkDuplicateSolid^"+solid+"' and org_code!='"+strOrgCode);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshResult.put("Branchname",correctNull((String)rs.getString("org_name")));
					hshResult.put("Solid","Already Given Branch");
				}
			}
		}
		catch(Exception e)
		{
			log.error("Error in getDublicateCheck :: "+e.toString());
		}
		finally
		{
			try
			{
				if(rs!=null)
				{
					rs.close();
				}
			}catch(Exception e)
			{
				throw new EJBException("Error While checking the Dubalicate values in getDublicateCheck"+e.getMessage());
			}
		}
		
		return hshResult;
		
	}
	public void updateMoveOrganisation(HashMap hshValues) 
	{

		ResultSet rs = null;
		ResultSet rs1 = null;
		String strOrgHead ="";
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strLevels="",strCodes="";
		try
		{
			strLevels = correctNull((String)hshValues.get("hidOrgLevel"));
			strCodes = correctNull((String)hshValues.get("hidOrgCodeNew"));
			String strOrgCodeOld= correctNull((String)hshValues.get("hidOrgCode"));
			String[] strvalues = strIncrement(strLevels,strCodes);	
			strCodes = strvalues[0];
			strLevels = strvalues[1];
			arrValues=new ArrayList();
			if(!strCodes.equalsIgnoreCase("") && !strOrgCodeOld.equalsIgnoreCase(""))
			{
			String strRegionalcode=strCodes.substring(0,6)+"000000000";
			String strRegional=strCodes.substring(0,9);
			arrValues.add(strCodes);
			arrValues.add(strOrgCodeOld);
			
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			hshQuery.put("strQueryId", "updorganisation_orgcode");
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);	
			
			hshQuery=new HashMap();
			hshQuery.put("strQueryId", "updusers_orgcode");
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("2", hshQuery);	
			
			hshQuery=new HashMap();
			hshQuery.put("strQueryId", "updapplications_orgcode");
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("3", hshQuery);	
			
			hshQuery=new HashMap();
			hshQuery.put("strQueryId", "updsolvency_orgcode");
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("4", hshQuery);	
			
			hshQuery=new HashMap();
			hshQuery.put("strQueryId", "updaddkpower_orgcode");
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("5", hshQuery);	
			
			hshQuery=new HashMap();
			hshQuery.put("strQueryId", "updfinrating_orgcode");
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("6", hshQuery);	
			
			hshQuery=new HashMap();
			hshQuery.put("strQueryId", "updbuildermaster_orgcode");
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("7", hshQuery);	
			
			hshQuery=new HashMap();
			hshQuery.put("strQueryId", "updcompanymaster_orgcode");
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("8", hshQuery);
			
			hshQuery=new HashMap();
			hshQuery.put("strQueryId", "updlawyermaster_orgcode");
			arrValues=new ArrayList();
			arrValues.add(strCodes);
			arrValues.add(strRegional);
			arrValues.add(strOrgCodeOld);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("9", hshQuery);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId", "updvaluersmaster_orgcode");
			arrValues.add(strOrgCodeOld);
			arrValues.add(strCodes);
			//arrValues.add(strRegionalcode);
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strAppendString", "org_code like '%"+strOrgCodeOld+"%'");
			hshQueryValues.put("10", hshQuery);
			
			hshQuery=new HashMap();
			hshQuery.put("strQueryId", "updafo_orgcode");
			arrValues=new ArrayList();
			arrValues.add(strCodes);
			arrValues.add(strOrgCodeOld);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("11", hshQuery);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId", "updafo_orgcode1");
			arrValues.add(strOrgCodeOld);
			arrValues.add(strCodes);
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strAppendString", "Sbm_Clusterbranchcode like '%"+strOrgCodeOld+"%'");
			hshQueryValues.put("12", hshQuery);
			
			hshQuery=new HashMap();
			hshQuery.put("strQueryId", "upd_query_orgcode");
			arrValues=new ArrayList();
			arrValues.add(strCodes);
			arrValues.add(strOrgCodeOld);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("13", hshQuery);
			
			hshQuery=new HashMap();
			hshQuery.put("strQueryId", "upd_query_sentorgcode");
			arrValues=new ArrayList();
			arrValues.add(strCodes);
			arrValues.add(strOrgCodeOld);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("14", hshQuery);
			
			hshQuery=new HashMap();
			hshQuery.put("strQueryId", "upd_nsdl_application");
			arrValues=new ArrayList();
			arrValues.add(strCodes);
			arrValues.add(strOrgCodeOld);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("15", hshQuery);

			hshQuery=new HashMap();
			hshQuery.put("strQueryId", "upd_valuersorgcode");
			arrValues=new ArrayList();
			arrValues.add(strCodes);
			arrValues.add(strOrgCodeOld);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("16", hshQuery);
			
			
			hshQueryValues.put("size", "16");	
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
			}
		}
		catch(Exception ce)
		{			
			throw new EJBException(ce);
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
	
	}
}