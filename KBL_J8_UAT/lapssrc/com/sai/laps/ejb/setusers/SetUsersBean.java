package com.sai.laps.ejb.setusers;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.Socket;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.setuprate.setuprateBean;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.IRB_Encryption;
import com.sai.laps.helper.SQLParser;
import java.security.MessageDigest;
import sun.misc.BASE64Encoder;
import com.sai.laps.helper.DBUtils;

@Stateless(name = "SetUsersBean", mappedName = "SetUsersHome")
@Remote (SetUsersRemote.class)

public class SetUsersBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(SetUsersBean.class);
	public void updateData(HashMap hshValues) 
	{		
		ResultSet rs = null;
		ResultSet rs1 = null;
		MessageDigest md=null;
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strExp ="$";
		String strUserId = "";
		StringBuilder sbolddata=new StringBuilder();
		String strKeyId = "",strQuery="",StrSeqId="";
		try
		{	
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				strUserId=Helper.correctNull((String)hshValues.get("usr_id"));
				strUserId=correctSingleQuote(strUserId);
				rs =DBUtils.executeLAPSQuery("setuserssel^"+strUserId);			
				if(rs.next())
				{
					sbolddata.append("~ Login Name / Employee Code = "+Helper.correctNull((String)rs.getString("usr_id")));
					sbolddata.append("~ First Name = "+Helper.correctNull((String)rs.getString("usr_fname")));
					sbolddata.append("~ Last Name = "+Helper.correctNull((String)rs.getString("usr_lname")));
					sbolddata.append("~ Designation = "+Helper.correctNull((String)rs.getString("user_designation")));
					rs1 = DBUtils.executeLAPSQuery("selmailaddress^"+Helper.correctNull((String)rs.getString("usr_orgcode")));
					if(rs1.next())
					{
						sbolddata.append("~Location ="+Helper.correctNull((String)rs1.getString("org_name")));
					}
					if(rs!=null)
					{
						rs1.close();
					}
					rs1 = DBUtils.executeLAPSQuery("setgroupssel_audit^"+Helper.correctNull((String)rs.getString("usr_grpid")));
					if(rs1.next())
					{
						sbolddata.append("~ Group = "+Helper.correctNull((String)rs1.getString("grp_name")));
					}
					if(rs!=null)
					{
						rs1.close();
					}					
					sbolddata.append("~ Class = "+Helper.correctNull((String)rs.getString("usr_class")));
					rs1 = DBUtils.executeLAPSQuery("selclasslist_workflow^7"+"^"+Helper.correctNull((String)rs.getString("usr_class")));
					if(rs1.next())
					{
						sbolddata.append("~ Class Description = "+Helper.correctNull((String)rs1.getString("stat_data_desc1")));
					}
					if(rs!=null)
					{
						rs1.close();
					}
					sbolddata.append("~ Availability = ");
					if(Helper.correctNull((String)rs.getString("usr_avail")).equalsIgnoreCase("a"))
					{
						sbolddata.append("Available");
					}
					else
					{
						sbolddata.append("Unavailable");
					}
					sbolddata.append("~ Function = "+Helper.correctNull((String)rs.getString("usr_function")));
					
				}
				if(rs!=null)
				{
					rs.close();
				}				
			}
			/*if(correctNull((String)hshValues.get("usr_function")).trim().equalsIgnoreCase("Branch Manager") || correctNull((String)hshValues.get("usr_function")).trim().equalsIgnoreCase("Regional Head") || correctNull((String)hshValues.get("usr_function")).trim().equalsIgnoreCase("Zonal Head"))
			{
				hshQueryValues.put("size","2");
			}
			else
			{
				hshQueryValues.put("size","1");
			}*/
			
			String usr_password = correctNull((String)hshValues.get("usr_password"));	
						
			String mypwd1 = usr_password;
			String encryptpwd = "";
			if(!mypwd1.equals(""))
			{
			    md= MessageDigest.getInstance("SHA");				
				md.update(mypwd1.getBytes("UTF-8"));
				byte[] encpwd=md.digest();
			    encryptpwd=(new BASE64Encoder()).encode(encpwd);
			}
			usr_password=encryptpwd;					
			if(strAction.equalsIgnoreCase("insert"))
			{				
				rs = null;
				rs = DBUtils.executeLAPSQuery("selempcode^"+correctNull((String)hshValues.get("usr_mname")));
				
				if(rs.next())
				{		
					strExp = strExp+" Employee with EC : " + correctNull((String)rs.getString(2)) + " Already exists under User Id : " +correctNull((String)rs.getString(1));					
					throw new Exception(strExp);					
				}
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","setusersins");
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_id")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_grpid")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_orgcode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_fname")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_mname")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_lname")));
				arrValues.add(usr_password);
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_class")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_supid")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_supstatus")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_avail")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_function")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_sanction")));
				arrValues.add(Helper.correctNull((String)hshValues.get("user_designation")));
				arrValues.add("Y");
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_emailid")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_department")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sle_rmd")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_rlpftype")));	
				arrValues.add(Helper.correctNull((String)hshValues.get("hrms_des")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hrms_jobCode")));
				hshQuery.put("arrValues",arrValues);
		       	hshQueryValues.put("1",hshQuery);
		       	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		       	
		    	hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
		       	hshQuery.put("strQueryId", "ins_laps_ram_users");
				arrValues.add(hshValues.get("usr_id"));
				arrValues.add(hshValues.get("usr_id"));
				arrValues.add(IRB_Encryption.cEncrypt_Base64(correctNull((String)hshValues.get("usr_password"))));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId", "ins_laps_ram_users");
				arrValues.add(hshValues.get("usr_id"));
				arrValues.add(hshValues.get("usr_id")+"F");
				arrValues.add(IRB_Encryption.cEncrypt_Base64(correctNull((String)hshValues.get("usr_password"))));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
				
				if(Helper.correctNull(ApplicationParams.getstrOnlineEnabled()).equalsIgnoreCase("YES")){
					
				if(rs!=null)
				{
					rs.close();
				}	
				rs=DBUtils.executeInternetQuery("selmaxseqid");
				if(rs.next())
				{
					StrSeqId=Helper.correctNull(rs.getString("usr_seqid"));
				}
					
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","ins_setusers_online");
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_id")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_grpid")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_orgcode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_fname")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_mname")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_lname")));
				arrValues.add(usr_password);
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_class")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_supid")));
				arrValues.add("n");
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_avail")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_function")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_sanction")));
				arrValues.add(Helper.correctNull((String)hshValues.get("user_designation")));
				arrValues.add("Y");
				arrValues.add(StrSeqId);
				hshQuery.put("arrValues",arrValues);
		       	hshQueryValues.put("1",hshQuery);
		       	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateInternetData");
			  }
				
				if(Helper.correctNull(ApplicationParams.getMONITORINGDBENABLED()).equalsIgnoreCase("YES"))
				{
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","ins_setusers_monitoring");
					arrValues.add(Helper.correctNull((String)hshValues.get("usr_id")));
					arrValues.add(Helper.correctNull((String)hshValues.get("usr_grpid")));
					arrValues.add(Helper.correctNull((String)hshValues.get("usr_orgcode")));
					arrValues.add(Helper.correctNull((String)hshValues.get("usr_fname")));
					arrValues.add(Helper.correctNull((String)hshValues.get("usr_mname")));
					arrValues.add(Helper.correctNull((String)hshValues.get("usr_lname")));
					arrValues.add(usr_password);
					arrValues.add(Helper.correctNull((String)hshValues.get("usr_class")));
					arrValues.add(Helper.correctNull((String)hshValues.get("usr_supid")));
					arrValues.add("n");
					arrValues.add(Helper.correctNull((String)hshValues.get("usr_avail")));
					arrValues.add(Helper.correctNull((String)hshValues.get("usr_function")));
					arrValues.add(Helper.correctNull((String)hshValues.get("usr_sanction")));
					arrValues.add(Helper.correctNull((String)hshValues.get("user_designation")));
					arrValues.add("Y");
					hshQuery.put("arrValues",arrValues);
			       	hshQueryValues.put("1",hshQuery);
			       	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateMonitoringData");
				  }
			}
					
			if(strAction.equalsIgnoreCase("update"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","setusersupd");
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_grpid")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_orgcode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_fname")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_mname")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_lname")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_class")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_supid")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_supstatus")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_avail")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_function")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_sanction")));
				arrValues.add(Helper.correctNull((String) hshValues.get("user_designation")));
				arrValues.add(Helper.correctNull((String) hshValues.get("usr_emailid")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_department")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sle_rmd")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_rlpftype")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hrms_des")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hrms_jobCode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_id")));
				hshQuery.put("arrValues",arrValues);
		       	hshQueryValues.put("1",hshQuery);
		       	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		       	
		       	hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
		       	hshQuery.put("strQueryId", "upd_laps_ram_users");
				arrValues.add(hshValues.get("usr_id"));
				arrValues.add(hshValues.get("usr_id"));
				arrValues.add(hshValues.get("usr_id"));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId", "upd_laps_ram_users");
				arrValues.add(hshValues.get("usr_id"));
				arrValues.add(hshValues.get("usr_id")+"F");
				arrValues.add(hshValues.get("usr_id")+"F");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				if(Helper.correctNull(ApplicationParams.getstrOnlineEnabled()).equalsIgnoreCase("YES")){
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","upd_setusers_online");
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_grpid")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_orgcode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_fname")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_mname")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_lname")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_class")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_supid")));
				arrValues.add("n");
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_avail")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_function")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_sanction")));
				arrValues.add(Helper.correctNull((String) hshValues.get("user_designation")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_id")));
				hshQuery.put("arrValues",arrValues);
		       	hshQueryValues.put("1",hshQuery);
		       	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateInternetData");
			  }
				
				if(Helper.correctNull(ApplicationParams.getMONITORINGDBENABLED()).equalsIgnoreCase("YES"))
				{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","setusersupd_monitoring");
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_grpid")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_orgcode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_fname")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_mname")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_lname")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_class")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_supid")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_supstatus")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_avail")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_function")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_sanction")));
				arrValues.add(Helper.correctNull((String) hshValues.get("user_designation")));
				arrValues.add(Helper.correctNull((String) hshValues.get("usr_emailid")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_department")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sle_rmd")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_rlpftype")));
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_id")));
				hshQuery.put("arrValues",arrValues);
		       	hshQueryValues.put("1",hshQuery);
		       	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateMonitoringData");
		    
				}
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","setusersdel");
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_id")));
				strExp = strExp+"Cannot delete the user,the user is used in applications";
				hshQuery.put("arrValues",arrValues);
		       	hshQueryValues.put("1",hshQuery);
		       	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		       	
		       if(Helper.correctNull(ApplicationParams.getstrOnlineEnabled()).equalsIgnoreCase("YES")){
		       	hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","setusersdel");
				arrValues.add(Helper.correctNull((String)hshValues.get("usr_id")));
				strExp = strExp+"Cannot delete the user,the user is used in applications";
				hshQuery.put("arrValues",arrValues);
		       	hshQueryValues.put("1",hshQuery);
		       	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateInternetData");
			 }
		       
		       if(Helper.correctNull(ApplicationParams.getMONITORINGDBENABLED()).equalsIgnoreCase("YES")){
			       	hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","setusersdel_monitoring");
					arrValues.add(Helper.correctNull((String)hshValues.get("usr_id")));
					strExp = strExp+"Cannot delete the user,the user is used in applications";
					hshQuery.put("arrValues",arrValues);
			       	hshQueryValues.put("1",hshQuery);
			       	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateMonitoringData");
				 }
			}
			

			//added by balaji for updating the org head for the organisation from the user screen
//			if(correctNull((String)hshValues.get("usr_function")).trim().equalsIgnoreCase("Branch Manager") || correctNull((String)hshValues.get("usr_function")).trim().equalsIgnoreCase("Regional Head") || correctNull((String)hshValues.get("usr_function")).trim().equalsIgnoreCase("Zonal Head"))
//			{
//				hshQuery=new HashMap();
//				arrValues=new ArrayList();
//				hshQuery.put("strQueryId","usrhead");
//				if(strAction.equalsIgnoreCase("delete"))
//				{
//					arrValues.add("");
//				}
//				else
//				{
//					arrValues.add(hshValues.get("usr_id"));
//				}
//				arrValues.add(hshValues.get("usr_orgcode"));
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("2",hshQuery);
//			}

			//for Entering the values into auditrial
			String Avil="";
			String strActionData="";
			if(correctNull((String)hshValues.get("usr_avail")).equalsIgnoreCase("a"))
			{
				Avil="Available";
			}
			else
			{
				Avil="Unavailable";
			}
		/*	if(!(strAction.equalsIgnoreCase("reset")))
			{					
				if(correctNull((String)hshValues.get("usr_function")).trim().equalsIgnoreCase("Branch Manager") || correctNull((String)hshValues.get("usr_function")).trim().equalsIgnoreCase("Regional Head") || correctNull((String)hshValues.get("usr_function")).trim().equalsIgnoreCase("Zonal Head"))
				{
					hshQueryValues.put("2",hshQuery);
				}
				else
				{
					hshQueryValues.put("1",hshQuery);
				}
			}*/
			if(strAction.equalsIgnoreCase("reset"))
			{
				String resetpassword = correctNull((String)hshValues.get("user_id"));
				mypwd1 = resetpassword;
				encryptpwd = "";
				if(!mypwd1.equals(""))
				{
				    md= MessageDigest.getInstance("SHA");
					md.update(mypwd1.getBytes("UTF-8"));
					byte[] encpwd=md.digest();
				    encryptpwd=(new BASE64Encoder()).encode(encpwd);
				}
				resetpassword=encryptpwd;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","setuserspasswordupd");
				arrValues.add(resetpassword);
				arrValues.add("Y");
				arrValues.add(Helper.correctNull((String)hshValues.get("user_id")));				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");	
				hshQueryValues.put("1",hshQuery);
				hshQuery.put("arrValues",arrValues);
		       	hshQueryValues.put("1",hshQuery);
		       	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
											
					strActionData = "The password is reset for Login id ="+correctNull((String)hshValues.get("user_id"));					
			
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId", "reset_laps_ram_users");
				arrValues.add(IRB_Encryption.cEncrypt_Base64(Helper.correctNull((String)hshValues.get("user_id"))));
				arrValues.add(Helper.correctNull((String)hshValues.get("user_id")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId", "reset_laps_ram_users");
				arrValues.add(IRB_Encryption.cEncrypt_Base64(Helper.correctNull((String)hshValues.get("user_id"))));
				arrValues.add(Helper.correctNull((String)hshValues.get("user_id")+"F"));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				if(Helper.correctNull(ApplicationParams.getstrOnlineEnabled()).equalsIgnoreCase("YES")){
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","upd_setuserspassword_online");
				arrValues.add(resetpassword);
				arrValues.add("Y");
				arrValues.add(Helper.correctNull((String)hshValues.get("user_id")));				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");	
				hshQueryValues.put("1",hshQuery);
		       	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateInternetData");
			  }
				if(Helper.correctNull(ApplicationParams.getMONITORINGDBENABLED()).equalsIgnoreCase("YES")){
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","upd_setuserspassword_monitoring");
					arrValues.add(resetpassword);
					arrValues.add("Y");
					arrValues.add(Helper.correctNull((String)hshValues.get("user_id")));				
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size","1");	
					hshQueryValues.put("1",hshQuery);
			       	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateMonitoringData");
				  }
			}
		
			if(strAction.equalsIgnoreCase("insert")||strAction.equalsIgnoreCase("update"))
			{
				strActionData = "Login Name/Employee Code ="+correctNull((String)hshValues.get("usr_id"))+
				"~First Name ="+correctNull((String)hshValues.get("usr_fname"))+
				"~Last Name ="+correctNull((String)hshValues.get("usr_lname"))+
				"~Designation ="+correctNull((String)hshValues.get("user_designation"))+
				"~Location ="+correctNull((String)hshValues.get("hid_location"))+
				"~Group ="+correctNull((String)hshValues.get("hid_grouplist"))+
				"~Class  ="+correctNull((String)hshValues.get("usr_class"))+
				"~Class Description="+correctNull((String)hshValues.get("txt_class_desc"))+
				"~Availability ="+Avil+
				"~Function ="+correctNull((String)hshValues.get("usr_function"));
				if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
					hshValues.put("hidAction", "update");
			}
			AuditTrial.auditNewLog(hshValues,"8",strKeyId,strActionData,sbolddata.toString());
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateData "+ce.toString());
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

	public HashMap getData(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strUserId="";
		int applicationsCount=0;
		boolean recordflag=false;
		try
		{			
            strUserId=Helper.correctNull((String)hshRequestValues.get("usr_id"));
			strUserId=correctSingleQuote(strUserId);
			rs =DBUtils.executeLAPSQuery("setuserssel^"+strUserId);			
			hshRecord = new HashMap();
			while(rs.next())
			{
				recordflag=true;
				hshRecord.put("usr_grpid",Helper.correctNull((String)rs.getString("usr_grpid")));
				hshRecord.put("usr_orgcode",Helper.correctNull((String)rs.getString("usr_orgcode")));
				hshRecord.put("usr_fname",Helper.correctNull((String)rs.getString("usr_fname")));
				hshRecord.put("usr_mname",Helper.correctNull((String)rs.getString("usr_mname")));
				hshRecord.put("usr_lname",Helper.correctNull((String)rs.getString("usr_lname")));
				hshRecord.put("usr_class",Helper.correctNull((String)rs.getString("usr_class")));
				hshRecord.put("usr_supid",Helper.correctNull((String)rs.getString("usr_supid")));
				hshRecord.put("usr_supstatus",Helper.correctNull((String)rs.getString("usr_supstatus")));
				hshRecord.put("usr_avail",Helper.correctNull((String)rs.getString("usr_avail")));
				hshRecord.put("usr_function",Helper.correctNull((String)rs.getString("usr_function")));
				hshRecord.put("usr_sanction",Helper.correctNull((String)rs.getString("usr_sanction_limit")));
				hshRecord.put("user_designation",Helper.correctNull((String)rs.getString("user_designation")));
				hshRecord.put("user_flag",Helper.correctNull((String)rs.getString("user_designation")));
				hshRecord.put("usr_emailid",Helper.correctNull((String)rs.getString("usr_emailid")));
				hshRecord.put("usr_department",Helper.correctNull((String)rs.getString("usr_department")));
				hshRecord.put("usr_rmdflag",Helper.correctNull((String)rs.getString("usr_rmdflag")));
				hshRecord.put("usr_rlpftype",Helper.correctNull(rs.getString("usr_rlpftype")));
				hshRecord.put("USR_HRMS_DESIGNATION",Helper.correctNull((String)rs.getString("USR_HRMS_DESIGNATION")));
				hshRecord.put("USR_HRMS_JOBCODE",Helper.correctNull(rs.getString("USR_HRMS_JOBCODE")));
				String txt_flag="y";
				hshRecord.put("txt_flag",txt_flag);
			}
			hshRecord.put("strUserId",strUserId);
			
			if(rs!=null) 
				rs.close();
			rs = DBUtils.executeLAPSQuery("applications_mailbox_totcount^" + strUserId);
			if(rs.next())
				applicationsCount=rs.getInt("cnt");
			
			if(applicationsCount < 1)
			{
				if(rs!=null) 
					rs.close();
				rs = DBUtils.executeLAPSQuery("sel_userappcount^" + strUserId+"^"+strUserId+"^"+strUserId+"^"+strUserId);
				while(rs.next())
				{
					applicationsCount=applicationsCount+rs.getInt("count");	
				}
			}
			
			if(applicationsCount < 1)
			{
				if(rs!=null) 
					rs.close(); 
				rs = DBUtils.executeLAPSQuery("npaapplications_mailbox_totcount^" + strUserId);
				if(rs.next())
					applicationsCount = applicationsCount+rs.getInt(1);
			}
			
			if(applicationsCount < 1)
			{
				if(rs!=null) 
					rs.close(); 
				rs = DBUtils.executeLAPSQuery("mmr_mailbox_totcount^" + strUserId);
				if(rs.next())
					applicationsCount = applicationsCount+rs.getInt(1);
			}
			if(applicationsCount < 1)
			{
				if(rs!=null) 
					rs.close(); 
				rs = DBUtils.executeLAPSQuery("termloan_mailbox_count^" + strUserId);
				if(rs.next())
					applicationsCount = applicationsCount+rs.getInt(1);
			}
			if(applicationsCount < 1)
			{
				if(rs!=null) 
					rs.close(); 
				rs = DBUtils.executeLAPSQuery("bstmailboxcount^" + strUserId);
				if(rs.next())
					applicationsCount = applicationsCount+rs.getInt(1);
			}
			if(applicationsCount < 1)
			{
				if(rs!=null) 
					rs.close(); 
				rs = DBUtils.executeLAPSQuery("mstmailboxcount^" + strUserId);
				if(rs.next())
					applicationsCount = applicationsCount+rs.getInt(1);
			}
			if(applicationsCount < 1)
			{
				if(rs!=null) 
					rs.close(); 
				rs = DBUtils.executeLAPSQuery("insmailcount^" + strUserId);
				if(rs.next())
					applicationsCount = applicationsCount+rs.getInt(1);
			}
			if(applicationsCount < 1)
			{
				if(rs!=null) 
					rs.close(); 
				rs = DBUtils.executeLAPSQuery("sel_cus_security_ownership_temp^" + strUserId);
				if(rs.next())
					applicationsCount = applicationsCount+rs.getInt(1);
			}
			if(applicationsCount < 1)
			{
				if(rs!=null) 
					rs.close(); 
				rs = DBUtils.executeLAPSQuery("sel_SECURITIES_APPROVAL_TEMP^" + strUserId);
				if(rs.next())
					applicationsCount = applicationsCount+rs.getInt(1);
			}
			if(applicationsCount < 1)
			{
				if(rs!=null) 
					rs.close(); 
				rs = DBUtils.executeLAPSQuery("sel_revalidate_app1^" + strUserId+"^"+strUserId);
				if(rs.next())
					applicationsCount = applicationsCount+rs.getInt(1);
			}
			
			if(applicationsCount>0)
				hshRecord.put("mailboxcount","Y");
			else
				hshRecord.put("mailboxcount","N");
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
			
		}
		catch(Exception e)
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
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap getUploaddata(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = null;
		MessageDigest md=null;
		String struserpassword1 ="";
		HashMap hshQuery = new HashMap();
		ArrayList arrValues=new ArrayList();
		HashMap hshQueryValues = new HashMap();
		String strId="", struserpassword ="";
		try
		{
			rs = DBUtils.executeLAPSQuery("seluploaddata");			
			hshRecord = new HashMap();

			while(rs.next())
			{
				strId=rs.getString("usr_id");
				struserpassword=rs.getString("usr_password");				
				String mypwd1 = struserpassword;
				String encryptpwd = "";
				if(!mypwd1.equals(""))
				{
				    md= MessageDigest.getInstance("SHA");				
					md.update(mypwd1.getBytes("UTF-8"));
					byte[] encpwd=md.digest();
				    encryptpwd=(new BASE64Encoder()).encode(encpwd);
				}
				struserpassword1=encryptpwd;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_uploaddata");
				arrValues.add(struserpassword1);
				arrValues.add(strId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}		
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getUserList "+ce.toString());
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
	
	public HashMap getOrgUploaddata(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = null;
		HashMap hshQuery = new HashMap();
		ArrayList arrValues=new ArrayList();
		HashMap hshQueryValues = new HashMap();
		String strorgcode="", struserorgcode ="";
		try
		{
			rs = DBUtils.executeLAPSQuery("sel_usersorgcode");			
			hshRecord = new HashMap();

			while(rs.next())
			{
				struserorgcode=rs.getString("usr_orgcode");
				strorgcode=rs.getString("org_code");				
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_users");
				arrValues.add(strorgcode);
				arrValues.add(struserorgcode);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}		
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getUserList "+ce.toString());
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
	
	public HashMap getUserList(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecVal = new ArrayList();		
		ArrayList vecRec= new ArrayList();

		try
		{
			rs = DBUtils.executeLAPSQuery("setuserlist");			
			hshRecord = new HashMap();

			while(rs.next())
			{
				String strId=rs.getString("usr_id");
				String strName=rs.getString("usr_fname");
				String strUsrClass=rs.getString("usr_class");
				vecRec = new ArrayList();		
				vecRec.add(strId);
				vecRec.add(strName);
				vecRec.add(strUsrClass);						
				vecVal.add(vecRec);
			}
			hshRecord.put("users_data",vecVal);			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getUserList "+ce.toString());
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

	public HashMap getOrgList(HashMap hshRequestValues) 
	{
		String scode="";
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		try
		{			
			scode=Helper.correctNull((String)hshRequestValues.get("scode"));
			if(scode.equals(""))
			{
				rs = DBUtils.executeLAPSQuery("setorglist");
			}
			else
			{
				rs = DBUtils.executeLAPSQuery("setorglistcode");
			}
			hshRecord = new HashMap();
			while(rs.next())
			{
				String strCode=rs.getString(1);
				String strName=rs.getString(2);
				hshRecord.put(strCode,strName);
				arr.add(correctNull(rs.getString(1)));
				arr1.add(correctNull(rs.getString(2)));
			}
			hshRecord.put("arr",arr);
			hshRecord.put("arr1",arr1);			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getOrgList "+ce.toString());
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
	
	public HashMap getOrgLocationData(HashMap hshRequestValues) 
	{	
		String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		String strquery1 ="";
		try
		{
			String strOrgLevel=Helper.correctNull((String)hshRequestValues.get("orglevel"));
			String strOrgSelect = Helper.correctNull((String)hshRequestValues.get("orgSelect"));
			if(strOrgLevel.equalsIgnoreCase("C"))
			{
				strQuery = SQLParser.getSqlQuery("setorglocation^"+strOrgSelect+"^"+strquery1);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("setorghelp1^"+strOrgSelect+"^"+strOrgLevel);
			}
			rs = DBUtils.executeQuery(strQuery);
			hshRecord = new HashMap();
			while(rs.next())
			{
				String strCode=rs.getString(1);
				String strName=rs.getString(2);
				hshRecord.put(strCode,strName);
				arr.add(correctNull(rs.getString(1)));
				arr1.add(correctNull(rs.getString(2)));
			}
			hshRecord.put("arr",arr);
			hshRecord.put("arr1",arr1);			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getOrgList "+ce.toString());
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
	
//	public HashMap getBranchRefListData(HashMap hshRequestValues) 
//	{		
//		String strQuery="";
//		ResultSet rs = null;
//		HashMap hshRecord = null;
//		ArrayList arrValues = null;
//		
//		try
//		{		
//			String strOrgCode = Helper.correctNull((String)hshRequestValues.get("strOrgCode"));
//			strQuery = SQLParser.getSqlQuery("branchreflist^"+strOrgCode);
//			rs = DBUtils.executeLAPSQuery(strQuery);
//			hshRecord = new HashMap();
//			while(rs.next())
//			 {
//				String strId=rs.getString("branch_refno");
//				arrValues=new ArrayList();
//				arrValues.add(strId);
//				hshRecord.put(strId,arrValues);
//			}
//		}
//		catch(Exception ce)
//		{
//			throw new EJBException("Error in getOrgList "+ce.toString());
//		}
//		finally
//		{
//			try
//			{
//				if(rs != null)
//				{
//					rs.close();
//				}
//			}
//			catch(Exception cf)
//			{
//				throw new EJBException("Error closing the connection "+cf.getMessage());
//			}
//		}
//		return hshRecord;
//	}
	//karthiikeyan user search screen
	public HashMap getUserSearchData(HashMap hshRequestValues) 
	{		
 		String strQuery="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = null;
		ArrayList arrValues = null;
		ArrayList arrData = null;
		String strUserFlag="";
		String strUserName="%";
		String strUserId="%";
		String grpid="";
		try
		{		
			//strOrgCode = Helper.correctNull((String)hshRequestValues.get("strOrgCode"));
			strUserFlag = Helper.correctNull((String)hshRequestValues.get("userStatus"));
			if (strUserFlag.equals("id"))
			{
				strUserId="%"+Helper.correctNull((String)hshRequestValues.get("txt_user_id_name")).toUpperCase()+"%";
			}
			else if(strUserFlag.equals("name"))
			{
				strUserName="%"+Helper.correctNull((String)hshRequestValues.get("txt_user_id_name")).toUpperCase()+"%";
			}
			
			//strQuery = SQLParser.getSqlQuery("setUsers^"+strUserId+"^"+strUserName);
			//rs = DBUtils.executeLAPSQuery(strQuery);
			
			if(Helper.correctNull((String)hshRequestValues.get("hidDetails")).equalsIgnoreCase("A"))
			{
				hshRecord = new HashMap();
				arrValues=new ArrayList();
				
				rs=DBUtils.executeLAPSQuery("sel_workflowusers^"+Helper.correctNull((String)hshRequestValues.get("appno")));
				while(rs.next())
				{

					arrData=new ArrayList();
					arrData.add(Helper.correctNull(rs.getString("usr_id")));
					arrData.add("");
					arrData.add("");
					arrData.add(Helper.correctNull(rs.getString("usr_fname")));
					arrData.add("");
					arrData.add("");
					arrData.add("");
					arrData.add("");
					arrData.add("");
					arrData.add("");
					arrData.add("");
					arrData.add("");
					strQuery = SQLParser.getSqlQuery("selcbsiddatadesc^"+"27^"+Helper.correctNull(rs.getString("user_designation")));
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
							arrData.add(Helper.correctNull(rs1.getString("cbs_static_data_desc")));//12
					}
					else
					{
						arrData.add("");//12
					}
					arrData.add("");//13
					
					arrData.add("");
					arrData.add(Helper.correctNull((String)rs.getString("user_designation")));
					arrData.add(Helper.correctNull(rs.getString("maildate")));
					arrValues.add(arrData);	
				
				}
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("setUsers^"+strUserId+"^"+strUserName);
				rs = DBUtils.executeQuery(strQuery);
				
				hshRecord = new HashMap();
				arrValues=new ArrayList();
				String classno="";
				while(rs.next())
				 {
					arrData=new ArrayList();
					arrData.add(Helper.correctNull((String)rs.getString("usr_id")));
					grpid=Helper.correctNull((String)rs.getString("usr_grpid"));
					arrData.add(grpid);
					arrData.add(Helper.correctNull((String)rs.getString("usr_orgcode")));
					arrData.add(Helper.correctNull((String)rs.getString("usr_fname")));
					arrData.add(Helper.correctNull((String)rs.getString("usr_mname")));
					arrData.add(Helper.correctNull((String)rs.getString("usr_lname")));
					classno=Helper.correctNull((String)rs.getString("usr_class"));
					arrData.add(classno);
					arrData.add(Helper.correctNull((String)rs.getString("usr_supid")));
					arrData.add(Helper.correctNull((String)rs.getString("usr_supstatus")));
					arrData.add(Helper.correctNull((String)rs.getString("usr_avail")));
					arrData.add(Helper.correctNull((String)rs.getString("usr_function")));
					arrData.add(Helper.correctNull((String)rs.getString("usr_sanction_limit")));
					//arrData.add(Helper.correctNull((String)rs.getString("user_designation")));
					
					
					strQuery = SQLParser.getSqlQuery("selcbsiddatadesc^"+"27^"+Helper.correctNull((String)rs.getString("user_designation")));
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
							arrData.add(Helper.correctNull((String)rs1.getString("cbs_static_data_desc")));//13
					}
					else{
						arrData.add("");//13
					}
					
					strQuery = SQLParser.getSqlQuery("selclasslist_workflow^"+"7^"+classno);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
							arrData.add(Helper.correctNull((String)rs1.getString("stat_data_desc1")));//13
					}
					else{
						arrData.add("");//13
					}
					
					if(rs1!=null)
					{
						rs1=null;
					}
					
					strQuery=SQLParser.getSqlQuery("getgrpgights^"+grpid);
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						arrData.add(rs1.getString("grp_rights"));
					}
					else{
						arrData.add("");
					}
					arrData.add(Helper.correctNull((String)rs.getString("user_designation")));
					arrData.add("");
					arrValues.add(arrData);	
				}
			}
			
			// CFR deviation class power from Laps other paramters
			
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("selotherparam_ratexpos^112");
			if (rs.next()) 
			{
				hshRecord.put("strCFRdevPower",Helper.correctNull(rs.getString("LOAN_PARAMVAL")));
				
				if(rs1!=null)
					rs1.close();
				rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^7^"+Helper.correctInt(rs.getString("LOAN_PARAMVAL")));
				if(rs1.next())
				{
					hshRecord.put("strCFRdevPwrDesc",Helper.correctNull(rs1.getString("stat_data_desc1")));
				}
			}
			
			hshRecord.put("arrUserValues",arrValues);
			hshRecord.put("frompage",Helper.correctNull((String)hshRequestValues.get("hidFrmPage")));
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getUserSearchData "+ce.toString());
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
		return hshRecord;
	}
	public HashMap getLockedUserSearchData(HashMap hshRequestValues) 
	{		
 		String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();;
		ArrayList arrValues = null;
		ArrayList arrData = null;
		String strUserFlag="";
		String strUserName="%";
		String strUserId="%";
		try
		{		
			strUserFlag = Helper.correctNull((String)hshRequestValues.get("userStatus"));
			if (strUserFlag.equals("id"))
			{
				strUserId=Helper.correctNull((String)hshRequestValues.get("txt_user_id_name")).toUpperCase();
			}
			else if(strUserFlag.equals("name"))
			{
				strUserName="%"+Helper.correctNull((String)hshRequestValues.get("txt_user_id_name")).toUpperCase()+"%";
			}
			
			
			
			if(!strUserId.equalsIgnoreCase(Helper.correctNull((String)hshRequestValues.get("strUserId"))))
			{
				strQuery = SQLParser.getSqlQuery("selectlockedUsers^"+strUserId+"^"+strUserName);
				rs = DBUtils.executeQuery(strQuery);
				
				arrValues=new ArrayList();
				while(rs.next())
				 {
					arrData=new ArrayList();
					arrData.add(Helper.correctNull((String)rs.getString("au_usr_id")));
					arrData.add(Helper.correctNull((String)rs.getString("au_usr_name")));
					arrValues.add(arrData);	
					hshRecord.put("strDataFlag","Y");
					hshRecord.put("strName",Helper.correctNull((String)rs.getString("au_usr_name")));
				}
				
				hshRecord.put("arrValues",arrValues);
			}
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getLockedUserSearchData "+ce.toString());
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
	public HashMap UnLockUsers(HashMap hshRequestValues) 
	{	
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		
		String strUserId="";
		try
		{		
			strUserId=Helper.correctNull((String)hshRequestValues.get("txt_user_id"));
			
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strUserId);
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "delete_availableuser");
			hshQueryValues.put("1", hshQuery);
			hshQueryValues.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			
			hshRequestValues.put("strstatus", "Y");
			
			com.sai.laps.helper.ControllerServlet.mapSessionId.remove(strUserId);
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in UnLockUsers "+ce.toString());
		}
		
		return hshRequestValues;
	}
	public String doSelfSACMethod(HashMap hshRequestValues) 
	{	
		ResultSet rs=null;
		String strResponse="",strUserId="",strAction="";
		
		try
		{		
			strUserId=Helper.correctNull((String)hshRequestValues.get("strUserID"));
			strAction=Helper.correctNull((String)hshRequestValues.get("hidAction"));
			if(strAction.equalsIgnoreCase("Invoke"))
			{
				rs=DBUtils.executeLAPSQuery("select_availableuser^"+strUserId);
				if(rs.next())
				{
					
					String strMacineIP=Helper.correctNull(rs.getString("au_ip_address")).split(":")[0];
					
					if(strMacineIP.equalsIgnoreCase(Helper.correctNull((String)hshRequestValues.get("strServerIP"))))
					{
					
						/*Socket socket = null;
						int intPort=9114;
				        try {
				            socket = new Socket("192.168.0.224",intPort);

				            if(socket.isConnected()) {
				                System.out.println("Service is up ");
				            } else {
				                System.out.println("Service is down ");
				            }            
				        } catch (IOException ioe) {
				            ioe.printStackTrace();
				        } finally {
				            if(socket != null && socket.isConnected()) {
				                try {
				                    socket.close();
				                } catch (IOException ioe) {
				                    ioe.printStackTrace();
				                }
				            }
				        }*/
						
						String strURL = "http://"+Helper.correctNull(rs.getString("au_ip_address"))+"/laps/controllerservlet";
						String charset = "UTF-8";																																		
						String query = String.format("SACMETHOD=%s&UserID=%s",						  
					    URLEncoder.encode("UnLockUsers",charset),
					    URLEncoder.encode(strUserId,charset)
					    );
						
						URLConnection connection_1 = new URL(strURL+ "?" + query ).openConnection();
						connection_1.setDoOutput(true);
						connection_1.setRequestProperty("Accept-Charset", charset);			
						BufferedReader br = new BufferedReader(new InputStreamReader(connection_1.getInputStream()));
						StringBuffer strResult = new StringBuffer();
						while((strResponse = br.readLine()) != null)
						{
							strResult.append(strResponse);
						}
						
						strResponse=strResult.toString();
					}
					else
					{
						HashMap hshQueryValues = new HashMap();
						HashMap hshQuery = new HashMap();
						ArrayList arrValues = new ArrayList();
						
						arrValues = new ArrayList();
						hshQuery = new HashMap();
						arrValues.add(strUserId);
						hshQuery.put("arrValues", arrValues);
						hshQuery.put("strQueryId", "delete_availableuser");
						hshQueryValues.put("1", hshQuery);
						hshQueryValues.put("size", "1");
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
						
						strResponse="User Unlocked Successfully";
						
						com.sai.laps.helper.ControllerServlet.mapSessionId.remove(strUserId);
					}
				}
			}
			else if(strAction.equalsIgnoreCase("Purge"))
			{
				HashMap hshQueryValues = new HashMap();
				HashMap hshQuery = new HashMap();
				ArrayList arrValues = new ArrayList();
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(strUserId);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "delete_availableuser");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
				strResponse="User Unlocked Successfully";
				
				com.sai.laps.helper.ControllerServlet.mapSessionId.remove(strUserId);
			}
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in UnLockUsers "+ce.toString());
		}
		
		return strResponse;
	}
	public HashMap getUserSearchDataforLopv(HashMap hshRequestValues) 
	{		
 		String strQuery="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = null;
		ArrayList arrValues = null;
		ArrayList arrData = null;
		String strUserFlag="";
		String strUserName="%";
		String strUserId="%";
		String grpid="";
		try
		{		
			//strOrgCode = Helper.correctNull((String)hshRequestValues.get("strOrgCode"));
			strUserFlag = Helper.correctNull((String)hshRequestValues.get("userStatus"));
			if (strUserFlag.equals("id"))
			{
				strUserId="%"+Helper.correctNull((String)hshRequestValues.get("txt_user_id_name")).toUpperCase()+"%";
			}
			else if(strUserFlag.equals("name"))
			{
				strUserName="%"+Helper.correctNull((String)hshRequestValues.get("txt_user_id_name")).toUpperCase()+"%";
			}
			
			//strQuery = SQLParser.getSqlQuery("setUsers^"+strUserId+"^"+strUserName);
			//rs = DBUtils.executeLAPSQuery(strQuery);
			
			
			
			
				strQuery = SQLParser.getSqlQuery("setUsersforclph^"+strUserId+"^"+strUserName);
				rs = DBUtils.executeQuery(strQuery);
				
				hshRecord = new HashMap();
				arrValues=new ArrayList();
				String classno="";
				while(rs.next())
				 {
					arrData=new ArrayList();
					arrData.add(Helper.correctNull((String)rs.getString("usr_id")));
					grpid=Helper.correctNull((String)rs.getString("usr_grpid"));
					arrData.add(grpid);
					arrData.add(Helper.correctNull((String)rs.getString("usr_orgcode")));
					arrData.add(Helper.correctNull((String)rs.getString("usr_fname")));
					arrData.add(Helper.correctNull((String)rs.getString("usr_mname")));
					arrData.add(Helper.correctNull((String)rs.getString("usr_lname")));
					classno=Helper.correctNull((String)rs.getString("usr_class"));
					arrData.add(classno);
					arrData.add(Helper.correctNull((String)rs.getString("usr_supid")));
					arrData.add(Helper.correctNull((String)rs.getString("usr_supstatus")));
					arrData.add(Helper.correctNull((String)rs.getString("usr_avail")));
					arrData.add(Helper.correctNull((String)rs.getString("usr_function")));
					arrData.add(Helper.correctNull((String)rs.getString("usr_sanction_limit")));
					//arrData.add(Helper.correctNull((String)rs.getString("user_designation")));
					
					
					strQuery = SQLParser.getSqlQuery("selcbsiddatadesc^"+"27^"+Helper.correctNull((String)rs.getString("user_designation")));
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
							arrData.add(Helper.correctNull((String)rs1.getString("cbs_static_data_desc")));//13
					}
					else{
						arrData.add("");//13
					}
					
					strQuery = SQLParser.getSqlQuery("selclasslist_workflow^"+"7^"+classno);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
							arrData.add(Helper.correctNull((String)rs1.getString("stat_data_desc1")));//13
					}
					else{
						arrData.add("");//13
					}
					
					if(rs1!=null)
					{
						rs1=null;
					}
					
					strQuery=SQLParser.getSqlQuery("getgrpgights^"+grpid);
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						arrData.add(rs1.getString("grp_rights"));
					}
					else{
						arrData.add("");
					}
					arrData.add(Helper.correctNull((String)rs.getString("user_designation")));
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery = SQLParser.getSqlQuery("selcbsiddatadesc^"+"27^"+Helper.correctNull((String)rs.getString("user_designation")));
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
							arrData.add(Helper.correctNull((String)rs1.getString("LEG_OPI")));
					}
					else{
						arrData.add("");
					}
					
					
					arrData.add("");
					arrValues.add(arrData);	
				}
			
			
			// CFR deviation class power from Laps other paramters
			
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("selotherparam_ratexpos^112");
			if (rs.next()) 
			{
				hshRecord.put("strCFRdevPower",Helper.correctNull(rs.getString("LOAN_PARAMVAL")));
				
				if(rs1!=null)
					rs1.close();
				rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^7^"+Helper.correctInt(rs.getString("LOAN_PARAMVAL")));
				if(rs1.next())
				{
					hshRecord.put("strCFRdevPwrDesc",Helper.correctNull(rs1.getString("stat_data_desc1")));
				}
			}
			
			hshRecord.put("arrUserValues",arrValues);
			hshRecord.put("frompage",Helper.correctNull((String)hshRequestValues.get("hidFrmPage")));
			hshRecord.put("valueforsel",Helper.correctNull((String)hshRequestValues.get("selval")));
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getUserSearchData "+ce.toString());
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
		return hshRecord;
	}
	public HashMap getUserSearchDataforddrbir(HashMap hshRequestValues) 
	{		
 		String strQuery="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = null;
		ArrayList arrValues = null;
		ArrayList arrData = null;
		String strUserFlag="";
		String strUserName="%";
		String strUserId="%";
		String grpid="";
		try
		{		
			//strOrgCode = Helper.correctNull((String)hshRequestValues.get("strOrgCode"));
			strUserFlag = Helper.correctNull((String)hshRequestValues.get("userStatus"));
			if (strUserFlag.equals("id"))
			{
				strUserId="%"+Helper.correctNull((String)hshRequestValues.get("txt_user_id_name")).toUpperCase()+"%";
			}
			else if(strUserFlag.equals("name"))
			{
				strUserName="%"+Helper.correctNull((String)hshRequestValues.get("txt_user_id_name")).toUpperCase()+"%";
			}
			
			//strQuery = SQLParser.getSqlQuery("setUsers^"+strUserId+"^"+strUserName);
			//rs = DBUtils.executeLAPSQuery(strQuery);
			
			
			
			
				strQuery = SQLParser.getSqlQuery("setUsersforclphddrbir^"+strUserId+"^"+strUserName);
				rs = DBUtils.executeQuery(strQuery);
				
				hshRecord = new HashMap();
				arrValues=new ArrayList();
				String classno="";
				while(rs.next())
				 {
					arrData=new ArrayList();
					arrData.add(Helper.correctNull((String)rs.getString("usr_id")));
					grpid=Helper.correctNull((String)rs.getString("usr_grpid"));
					arrData.add(grpid);
					arrData.add(Helper.correctNull((String)rs.getString("usr_orgcode")));
					arrData.add(Helper.correctNull((String)rs.getString("usr_fname")));
					arrData.add(Helper.correctNull((String)rs.getString("usr_mname")));
					arrData.add(Helper.correctNull((String)rs.getString("usr_lname")));
					classno=Helper.correctNull((String)rs.getString("usr_class"));
					arrData.add(classno);
					arrData.add(Helper.correctNull((String)rs.getString("usr_supid")));
					arrData.add(Helper.correctNull((String)rs.getString("usr_supstatus")));
					arrData.add(Helper.correctNull((String)rs.getString("usr_avail")));
					arrData.add(Helper.correctNull((String)rs.getString("usr_function")));
					arrData.add(Helper.correctNull((String)rs.getString("usr_sanction_limit")));
					//arrData.add(Helper.correctNull((String)rs.getString("user_designation")));
					
					
					strQuery = SQLParser.getSqlQuery("selcbsiddatadesc^"+"27^"+Helper.correctNull((String)rs.getString("user_designation")));
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
							arrData.add(Helper.correctNull((String)rs1.getString("cbs_static_data_desc")));//13
					}
					else{
						arrData.add("");//13
					}
					if(rs1!=null)
					{
						rs1=null;
					}
					strQuery = SQLParser.getSqlQuery("selclasslist_workflow^"+"7^"+classno);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
							arrData.add(Helper.correctNull((String)rs1.getString("stat_data_desc1")));//13
					}
					else{
						arrData.add("");//13
					}
					
					if(rs1!=null)
					{
						rs1=null;
					}
					
					strQuery=SQLParser.getSqlQuery("getgrpgights^"+grpid);
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						arrData.add(rs1.getString("grp_rights"));
					}
					else{
						arrData.add("");
					}
					arrData.add(Helper.correctNull((String)rs.getString("user_designation")));
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery = SQLParser.getSqlQuery("selcbsiddatadesc^"+"27^"+Helper.correctNull((String)rs.getString("user_designation")));
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
							arrData.add(Helper.correctNull((String)rs1.getString("DDR_BIR")));
					}
					else{
						arrData.add("");
					}
					
					
					arrData.add("");
					arrValues.add(arrData);	
				}
			
			
			// CFR deviation class power from Laps other paramters
			
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("selotherparam_ratexpos^112");
			if (rs.next()) 
			{
				hshRecord.put("strCFRdevPower",Helper.correctNull(rs.getString("LOAN_PARAMVAL")));
				
				if(rs1!=null)
					rs1.close();
				rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^7^"+Helper.correctInt(rs.getString("LOAN_PARAMVAL")));
				if(rs1.next())
				{
					hshRecord.put("strCFRdevPwrDesc",Helper.correctNull(rs1.getString("stat_data_desc1")));
				}
			}
			
			hshRecord.put("arrUserValues",arrValues);
			hshRecord.put("frompage",Helper.correctNull((String)hshRequestValues.get("hidFrmPage")));
			hshRecord.put("valueforsel",Helper.correctNull((String)hshRequestValues.get("selval")));
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getUserSearchData "+ce.toString());
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
		return hshRecord;
	}
}