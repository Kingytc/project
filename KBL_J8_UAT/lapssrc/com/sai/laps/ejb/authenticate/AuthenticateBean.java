package com.sai.laps.ejb.authenticate;

 
import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.ObjectInputStream;
import java.security.MessageDigest;
import java.security.PrivateKey;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.crypto.Cipher;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "AuthenticateBean", mappedName = "AuthenticateHome")
@Remote (AuthenticateRemote.class)
public class AuthenticateBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(AuthenticateBean.class);

	private boolean InsertData(String UserId,HashMap hshReqValues) 
	{	
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		boolean bstate = false;
		boolean bstate1 = false;
		String strusrPassword="",strQuery="";
		ResultSet rs1 = null;
		try
		{
			strusrPassword = correctNull((String)hshReqValues.get("txtusr_password"));
			int logincount=Integer.parseInt(Helper.correctInt((String)hshReqValues.get("hidlogincount")));
			if(logincount==5)
				logincount=0;
			hshQueryValues.put("size","1");
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","authenticate3");
			arrValues.add(UserId);
			arrValues.add(Integer.toString(++logincount));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
//			strQuery = SQLParser.getSqlQuery("select_laps_ram_users^"+UserId);
//				rs1 =DBUtils.executeQuery(strQuery);
//			bstate1 = rs1.next();
//			
//			if(bstate1 == false)
//			{
//				hshQueryValues=new HashMap();
//				hshQuery=new HashMap();
//				arrValues=new ArrayList();
//				hshQueryValues.put("size","1");
//		       	hshQuery.put("strQueryId", "ins_laps_ram_users");
//				arrValues.add(UserId);
//				arrValues.add(UserId);
//				arrValues.add(IRB_Encryption.cEncrypt_Base64(strusrPassword));
//				hshQuery.put("arrValues", arrValues);
//				hshQueryValues.put("1", hshQuery);
//				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//				
//				hshQuery=new HashMap();
//				arrValues=new ArrayList();
//				hshQueryValues.put("size","1");
//				hshQuery.put("strQueryId", "ins_laps_ram_users");
//				arrValues.add(UserId);
//				arrValues.add(UserId+"F");
//				arrValues.add(IRB_Encryption.cEncrypt_Base64(strusrPassword));
//				hshQuery.put("arrValues", arrValues);
//				hshQueryValues.put("1", hshQuery);
//				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//			}
			

			//for Entering the values into auditrial
			/*String strActionData = "UserName="+correctNull((String)hshReqValues.get("txtusr_id"))+
									"~Password="+correctNull((String)hshReqValues.get("txtusr_password"));
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","audittrial");
			arrValues.add("1");
			arrValues.add(correctNull((String)hshReqValues.get("txtusr_id")));
			arrValues.add(correctNull((String)hshReqValues.get("strClientIP")));
			arrValues.add(correctNull((String)hshReqValues.get("strUserId")));
			arrValues.add(strActionData);
			arrValues.add("insert");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);*/
			
			bstate = true;
		  
		
		}
		catch(Exception ce)
		{
			bstate = false;			
			throw new EJBException("problem in Login"+ce);
		}
		return bstate;		
	}
	
	private boolean DeleteData(String UserId,HashMap hshReqValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		boolean bstate = false;
		try
		{
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","purgeid");
			arrValues.add(UserId);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);

			//for Entering the values into auditrial
			/*String strActionData = "UserName="+correctNull((String)hshReqValues.get("txtusr_id"))+
									"~Password="+correctNull((String)hshReqValues.get("txtusr_password"));
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","audittrial");
			arrValues.add("2");
			arrValues.add(correctNull((String)hshReqValues.get("txtusr_id")));
			arrValues.add(correctNull((String)hshReqValues.get("strClientIP")));
			arrValues.add(correctNull((String)hshReqValues.get("txtusr_id")));
			arrValues.add(strActionData);
			arrValues.add("purged/deleted");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("2",hshQuery);*/
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			bstate = true;
		}
		catch(Exception ce)
		{
			bstate = false;			
			throw new EJBException("problem in Login"+ce);
		}
		return bstate;		
	}

	private boolean UpdateData(String UserId,String NewPassword,HashMap hshReqValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		boolean bstate = false;
		try
		{
			String NewIRBPassword = Helper.correctNull((String)hshReqValues.get("txtusr_newpassword"));
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","passwordchange");
			arrValues.add(NewPassword);
			arrValues.add("N");
			arrValues.add(UserId);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
//			hshQuery=new HashMap();
//			arrValues=new ArrayList();
//			hshQueryValues.put("size","1");
//			hshQuery.put("strQueryId","reset_laps_ram_users");
//			arrValues.add(IRB_Encryption.cEncrypt_Base64(NewIRBPassword));
//			arrValues.add(UserId);
//			hshQuery.put("arrValues",arrValues);
//			hshQueryValues.put("1",hshQuery);
//			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//			
//			hshQuery=new HashMap();
//			arrValues=new ArrayList();
//			hshQueryValues.put("size","1");
//			hshQuery.put("strQueryId","reset_laps_ram_users");
//			arrValues.add(IRB_Encryption.cEncrypt_Base64(NewIRBPassword));
//			arrValues.add(UserId+"F");
//			hshQuery.put("arrValues",arrValues);
//			hshQueryValues.put("1",hshQuery);
//			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//			if(Helper.correctNull(ApplicationParams.getstrOnlineEnabled()).equalsIgnoreCase("YES")){
//			hshQuery=new HashMap();
//			arrValues=new ArrayList();
//			hshQueryValues.put("size","1");
//			hshQuery.put("strQueryId","upd_passwordchange_online");
//			arrValues.add(NewPassword);
//			arrValues.add("N");
//			arrValues.add(UserId);
//			hshQuery.put("arrValues",arrValues);
//			hshQueryValues.put("1",hshQuery);
//			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateInternetData");
//           }
			
			if(Helper.correctNull(ApplicationParams.getMONITORINGDBENABLED()).equalsIgnoreCase("YES")){
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","upd_setuserspassword_monitoring");
				arrValues.add(NewPassword);
				arrValues.add("N");
				arrValues.add(UserId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateMonitoringData");
	           }
			//for Entering the values into auditrial
			String strActionData = "Password has been changed for UserName ="+correctNull((String)hshReqValues.get("txtusr_id"));
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","audittrial");
			arrValues.add("3");
			arrValues.add(correctNull((String)hshReqValues.get("txtusr_id")));
			arrValues.add(correctNull((String)hshReqValues.get("strClientIP")));
			arrValues.add(correctNull((String)hshReqValues.get("txtusr_id")));
			arrValues.add(strActionData);
			arrValues.add("passwordchanged");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			bstate = true;
		}
		catch(Exception ce)
		{
			bstate = false;			
			throw new EJBException("problem in Login"+ce);
		}
		return bstate;		
	}

	public HashMap getData(HashMap hshRequestValues) 
	{		 
		ResultSet rs = null;
		ResultSet rs1 = null,rs2=null;
		boolean bstate = false;
		boolean bstate1 = false;
		HashMap hshRecord = null;
		String strQuery="";
		String strusrId ="";
		String strusrPassword ="";
		String strusrNewPassword="";
		String strusrPage = "";
		String strhidUsrId ="";
		
		MessageDigest md=null;
		String encryptpwd="";
		String encryptnewpwd="";
		int intPasswordAge = 0;
		int logincountnew = 0;
		String strFlag="Y",strTemp="",strTempVal="";
		
	
		try
		{
			 
			hshRecord = new HashMap();
			strusrId = correctNull((String)hshRequestValues.get("txtusr_id"));
			strusrPassword = correctNull((String)hshRequestValues.get("txtusr_password"));
			strusrNewPassword = correctNull((String)hshRequestValues.get("txtusr_newpassword"));
			strusrPage = correctNull((String)hshRequestValues.get("hidPage"));
			strhidUsrId = correctNull((String)hshRequestValues.get("hidusr_id"));
			/*if(strhidUsrId.equalsIgnoreCase("")){
				strhidUsrId = correctNull((String)hshRequestValues.get("txtusr_id"));
			}*/
			hshRecord.put("FromWhichPage",strusrPage);
		    String mypwd2 = "";
			mypwd2 = strusrNewPassword;	
			String strHostAddress=correctNull((String)hshRequestValues.get("strServerIP"));
			String strServerPort=correctNull((String)hshRequestValues.get("strServerPort"));
			if(com.sai.laps.helper.ControllerServlet.mapSessionId!=null)
			{
				if(com.sai.laps.helper.ControllerServlet.mapSessionId.containsKey(strusrId))
				{
					strFlag="N";
				}
			}
			if(strusrPage.equalsIgnoreCase("ChangePassword")){
				strusrPassword = correctNull((String)hshRequestValues.get("hid_oldpwd"));
				
			}else{
				strusrPassword       = correctNull((String)hshRequestValues.get("hidLDAPpasswrd")); 
			}
			System.out.println("PAssword Before Decrypt: " +strusrPassword);
			if(!strusrPassword.equalsIgnoreCase(""))
			{
				strusrPassword 		      = decrypt(strusrPassword+"=");
				System.out.println("PAssword Afetr Decrypt: " +strusrPassword);
				if(strusrPassword.charAt(0)=='0')
			    {
			    	 strTemp 				= strusrPassword.substring(0,1);
			    	 strTempVal 			= strTemp.replace("0", "A");
			    	 strusrPassword 		= strTempVal+strusrPassword.substring(1,strusrPassword.length());
			    }
			}
			System.out.println("strusrPassword"+strusrPassword);
			System.out.println("strusrNewPassword"+strusrNewPassword);
/**
 * When the user login to the LAPS first
 * time the system should force the user to change his password.
 */
			 strQuery = SQLParser.getSqlQuery("password_reset_falg^"+strusrId);
			 rs = DBUtils.executeQuery(strQuery);  
			 String strResetFlg="",strDateDiff="0";
			 if(rs.next())
			 {
				 strResetFlg   = correctNull(rs.getString("user_first_flag"));
				 strDateDiff   = correctNull(rs.getString("datediff"));
				 hshRecord.put("strPwdExpiryDays",Helper.correctNull(rs.getString("expirydays")));
				 hshRecord.put("strPwdExpiryDate",Helper.correctNull(rs.getString("Expirydate")));
			 }
			 
			 hshRecord.put("strResetFlg",strResetFlg);
			 hshRecord.put("strDateDiff",strDateDiff);
			 if(strDateDiff.trim().equals(""))
				 strDateDiff="0";
			 //TO check change password age.
			 intPasswordAge=Integer.parseInt(strDateDiff);
			 if(intPasswordAge > 30)
				 hshRecord.put("password_age","Y");
			 else
				 hshRecord.put("password_age","");
			
			 if(rs!=null)
				 rs.close();
			
		
/**End*/	
			
			if(!mypwd2.equals(""))
			{
			    md= MessageDigest.getInstance("SHA");
				md.update(mypwd2.getBytes("UTF-8"));
				byte[] encpwd1=md.digest();
			    encryptnewpwd=(new BASE64Encoder()).encode(encpwd1);
			}
			strusrNewPassword=encryptnewpwd;
	        String mypwd1 = "";		
		    mypwd1 = strusrPassword;			
		    if(!mypwd1.equals(""))
		    {
		        md= MessageDigest.getInstance("SHA");
			    md.update(mypwd1.getBytes("UTF-8"));
			    byte[] encpwd=md.digest();
		        encryptpwd=(new BASE64Encoder()).encode(encpwd);
		    }
		    strusrPassword=encryptpwd;
		    boolean boolAvail=false;
		    rs = DBUtils.executeLAPSQuery("select_availableuser^"+strusrId);  
		    boolAvail=rs.next();
			if(!strusrId.equals("") && ((boolAvail==false && strusrPage.equalsIgnoreCase("LoginPage"))||(!strusrPage.equalsIgnoreCase("LoginPage"))))
			{
				if(rs != null)
					rs.close();
				strQuery = SQLParser.getSqlQuery("authenticate5^"+strusrId);
 				rs2 =DBUtils.executeQuery(strQuery);
 				if(rs2.next()){
				strQuery = SQLParser.getSqlQuery("authenticate1^"+strusrId+"^"+strusrPassword);
 				rs =DBUtils.executeQuery(strQuery);
				bstate = rs.next();
				if(bstate)
				{
					if(rs2!=null){rs2.close();}
					strQuery = SQLParser.getSqlQuery("authenticate5^"+strusrId+"^"+strusrPassword);
	 				rs2 =DBUtils.executeQuery(strQuery);
	 				if(rs2.next()){
						if(Helper.correctNull(rs.getString("grp_accessfor")).equalsIgnoreCase("OL")){
							HashMap hshQueryValues1=new HashMap();
							HashMap hshQuery1=new HashMap();
							ArrayList arrValues1=new ArrayList();
							hshQueryValues1.put("size","1");
							hshQuery1.put("strQueryId","updLoginCount1");
						    arrValues1.add(strusrId);
							hshQuery1.put("arrValues",arrValues1);
							hshQueryValues1.put("1",hshQuery1);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues1,"updateData");
							bstate = true; 
							hshRecord.put("authenticate","");
							hshRecord.put("usr_id",correctNull(rs.getString("usr_id")));
							hshRecord.put("c_password",hshRequestValues.get("txtusr_password"));
							hshRecord.put("usr_orgcode",correctNull(rs.getString("usr_orgcode")));
							hshRecord.put("grp_rights",correctNull(rs.getString("grp_rights")));
							hshRecord.put("usr_class",correctNull(rs.getString("usr_class")));
							hshRecord.put("org_name",correctNull(rs.getString("org_name")));
							hshRecord.put("org_level",correctNull(rs.getString("org_level")));
							hshRecord.put("org_scode",correctNull(rs.getString("org_scode")));
							hshRecord.put("usr_name",correctNull(rs.getString("usr_name")));
							hshRecord.put("issaral",correctNull(rs.getString("org_issaral")));
							hshRecord.put("solid",correctNull(rs.getString("solid")));
							hshRecord.put("grp_privilege",correctNull(rs.getString("grp_privilege")));
							hshRecord.put("usr_department",correctNull(rs.getString("usr_department")));
							hshRecord.put("usr_grpid",correctNull(rs.getString("usr_grpid")));
							hshRecord.put("user_designation",correctNull(rs.getString("user_designation")));
							hshRecord.put("usr_rlpftype",correctNull(rs.getString("usr_rlpftype")));
							hshRecord.put("LAST_LOGINDATE",correctNull(rs.getString("LAST_LOGINDATE")));
							hshRecord.put("LAST_LOGOUTDATE",correctNull(rs.getString("LAST_LOGOUTDATE")));
							
							int intUserCnt=0,intAllowedUser=0;
							//Logged User Count
							if(rs!=null)
								rs.close();
							rs =DBUtils.executeLAPSQuery("chk_loggeduserdet^"+Helper.correctNull((String)hshRecord.get("org_scode")));
			 				if(rs.next())
			 				{
			 					intUserCnt=Integer.parseInt(Helper.correctInt(rs.getString("usrcount")));
			 				}
			 				
			 				if(rs!=null)
			 					rs.close();
			 				rs =DBUtils.executeLAPSQuery("selloanagainstparams^128");
			 				if(rs.next())
			 				{
			 					if(Helper.correctNull(rs.getString("LOAN_PARAMVAL")).equalsIgnoreCase("Y"))
			 					{
			 						if(rs!=null)
					 					rs.close();
					 				if(Helper.correctNull((String)hshRecord.get("org_level")).equalsIgnoreCase("A"))
					 					rs =DBUtils.executeLAPSQuery("selloanagainstparams^U001");
					 				else if(Helper.correctNull((String)hshRecord.get("org_level")).equalsIgnoreCase("D"))
					 					rs =DBUtils.executeLAPSQuery("selloanagainstparams^U002");
					 				else if(Helper.correctNull((String)hshRecord.get("org_level")).equalsIgnoreCase("R"))
					 					rs =DBUtils.executeLAPSQuery("selloanagainstparams^U003");
					 				else if(Helper.correctNull((String)hshRecord.get("org_level")).equalsIgnoreCase("C"))
					 					rs =DBUtils.executeLAPSQuery("selloanagainstparams^U004");
					 				
					 				if(Helper.correctNull((String)hshRecord.get("org_level")).equalsIgnoreCase("A") || Helper.correctNull((String)hshRecord.get("org_level")).equalsIgnoreCase("D")||
					 						Helper.correctNull((String)hshRecord.get("org_level")).equalsIgnoreCase("R")||Helper.correctNull((String)hshRecord.get("org_level")).equalsIgnoreCase("C"))
					 				{
						 				if(rs.next())
						 				{
						 					intAllowedUser=Integer.parseInt(Helper.correctInt(rs.getString("LOAN_PARAMVAL")));
						 				}
					 				}
					 				
					 				if(intAllowedUser>0 && intAllowedUser<=intUserCnt)
					 				{
					 					hshRecord.put("strUserExceedFlag","Y");
					 					hshRecord.put("strPermittedUser",intAllowedUser+"");
					 				}
			 					}
			 				}
							
							
							if(strusrPage.equalsIgnoreCase("LoginPage") && strResetFlg.equalsIgnoreCase("N") && strFlag.equalsIgnoreCase("Y")
									&& !Helper.correctNull((String)hshRecord.get("password_age")).equalsIgnoreCase("Y"))
							{
								if(!Helper.correctNull((String)hshRecord.get("strUserExceedFlag")).equalsIgnoreCase("Y"))
								{
									HashMap hshQueryValues=new HashMap();
									HashMap hshQuery=new HashMap();
									ArrayList arrValues=new ArrayList();
									hshQueryValues.put("size","1");
							       	hshQuery.put("strQueryId", "ins_availableuser");
									arrValues.add(strusrId);
									arrValues.add(Helper.correctNull((String)hshRecord.get("usr_name")));
									arrValues.add(Helper.correctNull((String)hshRecord.get("org_scode")));
									arrValues.add(strHostAddress+":"+strServerPort);
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put("1", hshQuery);
									EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
								}
							}
	
							if(rs != null) rs.close();
							strQuery = SQLParser.getSqlQuery("sel_user_pageaccess^"+strusrId);
			 				rs =DBUtils.executeQuery(strQuery);
			 				while(rs.next())
			 				{
			 					if(Helper.correctNull((String)rs.getString("USER_PAGE_VAL")).equalsIgnoreCase("NPA"))
			 						hshRecord.put("NPA", "Y");
			 					if(Helper.correctNull((String)rs.getString("USER_PAGE_VAL")).equalsIgnoreCase("FVC"))
			 						hshRecord.put("FVC", "Y");
			 					if(Helper.correctNull((String)rs.getString("USER_PAGE_VAL")).equalsIgnoreCase("NSDL"))
			 						hshRecord.put("NSDL", "Y");
			 					if(Helper.correctNull((String)rs.getString("USER_PAGE_VAL")).equalsIgnoreCase("RRM"))
			 						hshRecord.put("RRM", "Y");
			 					if(Helper.correctNull((String)rs.getString("USER_PAGE_VAL")).equalsIgnoreCase("SHG"))
			 						hshRecord.put("SHG", "Y");
			 				}
			 				
			 				if(rs != null) rs.close();
			 				strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^KALYPTO");
			 				rs = DBUtils.executeQuery(strQuery);
			 				if(rs.next())
			 				{
			 					hshRecord.put("strKalyptoAddress", Helper.correctNull((String)rs.getString(1)));
			 				}
			 				if(strusrPage.equalsIgnoreCase("LoginPage") && strResetFlg.equalsIgnoreCase("N") && strFlag.equalsIgnoreCase("Y"))
							{   HashMap hshQueryValues=new HashMap();
								HashMap hshQuery=new HashMap();
								ArrayList arrValues=new ArrayList();
								hshQueryValues.put("size","1");
								hshQuery.put("strQueryId","set_users_logincount");
							    arrValues.add(strusrId);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("1",hshQuery);
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
							}
						}
			 				
						}else{
							bstate = false;
							hshRecord.put("authenticate","Grp");
							hshRecord.put("usr_id",strusrId);
						}
					/*}else{
						bstate = false;
						hshRecord.put("authenticate","User Account Locked");
						hshRecord.put("usr_id",strusrId);
					}*/
				}
				else
				{
					 if(strusrPage.equalsIgnoreCase("ChangePassword"))
					{
						bstate = UpdateData(strusrId,strusrNewPassword,hshRequestValues);
						if(bstate)
						{
							bstate = DeleteData(strusrId,hshRequestValues);
							hshRecord.put("Passwords","Corrected");
						}
						else
						{
							hshRecord.put("Passwords","NotCorrected");
						}
					}else{
						bstate = false;
						hshRecord.put("authenticate","Not a Valid User");
						hshRecord.put("usr_id",strusrId);
						
						HashMap hshQueryValues=new HashMap();
						HashMap hshQuery=new HashMap();
						ArrayList arrValues=new ArrayList();
						hshQueryValues.put("size","1");
						hshQuery.put("strQueryId","updLoginCount");
					    arrValues.add(strusrId);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
				}
			}else{
				bstate = false;
				hshRecord.put("authenticate","User Account Locked");
				hshRecord.put("usr_id",strusrId);
			}
				if(bstate)
				{
					if(rs!=null)
						rs.close();
					strQuery=SQLParser.getSqlQuery("authenticate2^"+strusrId);
					rs=DBUtils.executeQuery(strQuery);

					if(strusrPage.equalsIgnoreCase("LoginPage") && strResetFlg.trim().equalsIgnoreCase("N"))
					{
						if(!rs.next())
						{
							bstate = true;
							hshRecord.put("Purge","");	
						}
						else
						{
							/*
							 * Deletion from Link table occurs only when there is entry in that table
							 * and this takes place at the time of Login
							 */
							bstate = DeleteData(strusrId,hshRequestValues);
							if(bstate)
							{
								hshRecord.put("PurgeUser","Purged");
							}
							else
							{
								hshRecord.put("PurgeUser","NotPurged");
							}

						}
						
						if(correctNull((String)hshRecord.get("PurgeUser")).equals("")){
							/*
							 * Insertion takes place only when there is no entry in Link table
							 * and this takes place at the time of Login
							 */
								bstate = InsertData(strusrId,hshRequestValues);
								
						}else{
							HashMap hshQueryValues=new HashMap();
							HashMap hshQuery=new HashMap();
							ArrayList arrValues=new ArrayList();
							try
							{
								if(rs!=null){
									logincountnew=Integer.parseInt(rs.getString("lnk_logincount"));
								}
								if(logincountnew==5)
									logincountnew=0;
								hshQueryValues.put("size","1");
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								/*
								 * Insertion in Link table takes place here.
								 */
								hshQuery.put("strQueryId","authenticate3");
								arrValues.add(strusrId);
								arrValues.add(Integer.toString(++logincountnew));
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("1",hshQuery);
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
								
//								strQuery = SQLParser.getSqlQuery("select_laps_ram_users^"+strusrId);
//				 				rs1 =DBUtils.executeQuery(strQuery);
//								bstate1 = rs1.next();
//								
//								if(bstate1 == false)
//								{
//									hshQueryValues=new HashMap();
//									hshQuery=new HashMap();
//									arrValues=new ArrayList();
//									hshQueryValues.put("size","1");
//							       	hshQuery.put("strQueryId", "ins_laps_ram_users");
//									arrValues.add(strusrId);
//									arrValues.add(strusrId);
//									arrValues.add(IRB_Encryption.cEncrypt_Base64(strusrPassword));
//									hshQuery.put("arrValues", arrValues);
//									hshQueryValues.put("1", hshQuery);
//									EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//									
//									hshQuery=new HashMap();
//									arrValues=new ArrayList();
//									hshQueryValues.put("size","1");
//									hshQuery.put("strQueryId", "ins_laps_ram_users");
//									arrValues.add(strusrId);
//									arrValues.add(strusrId+"F");
//									arrValues.add(IRB_Encryption.cEncrypt_Base64(strusrPassword));
//									hshQuery.put("arrValues", arrValues);
//									hshQueryValues.put("1", hshQuery);
//									EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//								}
								
							
								bstate = false;
						 }
							catch(Exception ce)
							{
								throw new EJBException("problem in Login"+ce);
							}
						}
						if(bstate)
						{
							int logincount=Integer.parseInt(Helper.correctInt((String)hshRequestValues.get("hidlogincount")));
							if(logincount==5)
								logincount=0;
							hshRecord.put("sucess","");
							hshRecord.put("hidlogincount",Integer.toString(++logincount));
							if(rs != null)
								rs.close();
						}
						else{
							if(rs!=null){ 
								logincountnew=Integer.parseInt(rs.getString("lnk_logincount"));
							}
							if(logincountnew==5)
								logincountnew=0;
							hshRecord.put("sucess","");
							hshRecord.put("hidlogincount",Integer.toString(++logincountnew));
							if(rs != null)
								rs.close();
						}
					}

					else if(strusrPage.equalsIgnoreCase("ChangePassword"))
					{
						bstate = UpdateData(strusrId,strusrNewPassword,hshRequestValues);
						if(bstate)
						{
							bstate = DeleteData(strusrId,hshRequestValues);
							hshRecord.put("Passwords","Corrected");
						}
						else
						{
							hshRecord.put("Passwords","NotCorrected");
						}
					}				
				}
			}
			if(strusrPage.equals("Navigation"))
			{
				bstate = DeleteData(strhidUsrId,hshRequestValues);
				if(bstate)
				{
					hshRecord.put("DeleteUserid","Corrected");
				}
				else
				{
					hshRecord.put("DeleteUserid","");
				}
				
				HashMap hshQueryValues=new HashMap();
				HashMap hshQuery=new HashMap();
				ArrayList arrValues=new ArrayList();
				hshQueryValues.put("size","1");
		       	hshQuery.put("strQueryId", "del_availableuser");
		       	if(strhidUsrId.equalsIgnoreCase("")){
		       		strhidUsrId = strusrId;
		       	}
				arrValues.add(strhidUsrId);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
			
			if(correctNull((String)hshRecord.get("sucess")).equalsIgnoreCase("") && 
					correctNull((String)hshRecord.get("Purge")).equalsIgnoreCase("") &&
					correctNull((String)hshRecord.get("authenticate")).equalsIgnoreCase(""))
				{
					if(rs != null)
						rs.close();
					rs = DBUtils.executeLAPSQuery("selstatdatabyiddesc^"+"32^IRB");
					if(rs.next())
					{
						//hshRecord.put("irb_value",correctNull((String)rs.getString("stat_data_desc")));
						hshRecord.put("irb_desc",correctNull((String)rs.getString("stat_data_desc1")));
					}
					
					rs = DBUtils.executeLAPSQuery("selstatdatabyiddesc^"+"32^LAPSONLINE");
					if(rs.next())
					{
						//hshRecord.put("irb_value",correctNull((String)rs.getString("stat_data_desc")));
						hshRecord.put("ONLINELAPS",correctNull((String)rs.getString("stat_data_desc1")));
					}
				}
			if(strusrPage.equals("Navigation"))
			{
				HashMap hshQueryValues=new HashMap();
				HashMap hshQuery=new HashMap();
				ArrayList arrValues=new ArrayList();
				hshQueryValues.put("size","1");
		       	hshQuery.put("strQueryId", "set_users_logoutcount");
				arrValues.add(strhidUsrId);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
			hshRecord.put("boolLockFlag",boolAvail+"");
			hshRecord.put("strUserID",strusrId);
	
		}
		catch(Exception ce)
		{
			ce.printStackTrace();
			throw new EJBException("Error in getData login  "+ce.toString());
		}
		finally
		{
			try
			{
				/*if(rs != null)
				{
					rs.close();
				}*/
				 if(rs2!= null){rs2.close();}
			}
			catch(Exception cf)
			{
				cf.printStackTrace();
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}
	public boolean CheckSession(HashMap hshRequestValues) 
	{
		ResultSet rs=null;
		String strQuery="";
		String strUserId="";
		int intlogincount=0;
		int hidlogincount=0;
	
		try 
		{
			strUserId = correctNull((String)hshRequestValues.get("strUserId"));
			hidlogincount = Integer.parseInt(Helper.correctInt((String)hshRequestValues.get("hidlogincount")));
			strQuery=SQLParser.getSqlQuery("authenticate2^"+strUserId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				intlogincount=rs.getInt("lnk_logincount");
				if(intlogincount==hidlogincount)
					return true;
				else
					return false;
			}
			else
			{
				return false;
			}
			
		}catch(Exception ex)
		{
			throw new EJBException("Error in CheckSession of Authenticate Bean :: "+ex.toString());
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
	public HashMap RedirectMonitoring(HashMap hshValues) 
	{		ResultSet rs=null,rs1=null;
		String strQuery="";
		String strUserId="";
		String strMimeType=""; 
		String strFileExtension="";
		String strFileName="monitoring.bat";
		ByteArrayOutputStream baos=new ByteArrayOutputStream();
		try 
		{
			strUserId = correctNull((String)hshValues.get("strUserId"));
			rs=DBUtils.executeLAPSQuery("getstaticdata_soldid^32^MONBATLOC");
			if(rs.next())
			{
				String path=Helper.correctNull(rs.getString("stat_data_desc1"));
			    byte byFileName[] = new byte[25*1024*1024];
				File file = new File(path);
				strUserId=correctNull((String)hshValues.get("strUserId"));
				FileWriter fwriter = new FileWriter(file);
				BufferedWriter out = new BufferedWriter(fwriter);
				if(rs1!=null)
					rs1.close();
				
				rs1=DBUtils.executeLAPSQuery("getstaticdata_soldid^32^MONIP");
				if(rs1.next())
				{
					out.write("start chrome http://"+Helper.correctNull(rs1.getString("stat_data_desc1"))+"/lms/action/hidlogin.jsp?txtusr_id="+strUserId);
				}
				else
				{
					out.write("start chrome http://172.20.0.245:9083/lms/action/hidlogin.jsp?txtusr_id="+strUserId);
				}
				out.close();
				FileInputStream fis 	= new FileInputStream(file);
				int read = 0;
			    while ((read = fis.read(byFileName)) != -1) 
			    {
					 baos.write(byFileName, 0, read);
			    }
				byFileName = baos.toByteArray();
				baos.close();
				strMimeType = getMimeType(strFileExtension);
				if(byFileName!=null)
				{
					hshValues.put("photoimg", byFileName);
					hshValues.put("FILE_STREAM_NAME", strFileName );
					hshValues.put("FILE_STREAM_TYPE", strMimeType);
					hshValues.put("FILE_STREAM", byFileName);
					hshValues.put("FILE_STREAM_DISPOSITION_TYPE","inline");			
				}

			}
			else
			{
				throw new Exception("$ File Location is not defined. Please contact Adminstrator");
			}
			
			return hshValues;
			
		}catch(Exception ex)
		{
			throw new EJBException("Error in CheckSession of Authenticate Bean :: "+ex.toString());
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
	public String getMimeType(String fileExtension) 
	{
		if (fileExtension.equalsIgnoreCase("a"))
            return "text/a";
        else if (fileExtension.equalsIgnoreCase("jpg"))
            return "image/gif";
        else if (fileExtension.equalsIgnoreCase("gif"))
            return "image/gif";
        else if (fileExtension.equalsIgnoreCase("png"))
            return "image/gif";
        else if (fileExtension.equalsIgnoreCase("bmp"))
            return "image/bmp";
        else if (fileExtension.equalsIgnoreCase("xls")||fileExtension.equalsIgnoreCase("xlsx"))
           return "application/vnd.ms-excel";
        else if (fileExtension.equalsIgnoreCase("doc")||fileExtension.equalsIgnoreCase("docx"))
            return "application/msword";
		
        else if (fileExtension.equalsIgnoreCase("tif"))
            return "image/tiff";
        else if (fileExtension.equalsIgnoreCase("tiff"))
            return "image/tiff";
        else if (fileExtension.equalsIgnoreCase("pdf"))
            return "application/pdf";
        else
            return "application/stream";
	}
	
	public  String decrypt (String encryptedData) 
	{
		   System.out.println("decrypt fn called.. encryptd string"+encryptedData);
		   byte[] dectyptedText = null;
		   ObjectInputStream inputStream = null;
		   String dec="",strTemp="",strTempVal="",strPrivateKeyFile="";
		    try {
		    	  BASE64Decoder decod=new BASE64Decoder();
			      // get an RSA cipher object and print the provider
			      final Cipher cipher = Cipher.getInstance("RSA");
			      // decrypt the text using the private key
			      System.out.println("getting encripted file");
			      strPrivateKeyFile=ApplicationParams.getStrPRIVATEKEYFILE();
			      System.out.println("File Received"+strPrivateKeyFile);
			      inputStream = new ObjectInputStream(new FileInputStream(strPrivateKeyFile));
			      log.info("AuthenticateBean decrypt:strPrivateKeyFile: "+strPrivateKeyFile);
			      PrivateKey privateKey = (PrivateKey) inputStream.readObject();
			      log.info("AuthenticateBean decrypt:privateKey: "+privateKey);
			      cipher.init(Cipher.DECRYPT_MODE, privateKey);
			      System.out.print("privateKey::"+privateKey);
			      byte b[]		= decod.decodeBuffer(encryptedData);
			      System.out.println("decodeBuffer::"+encryptedData);
			      String str	= new String(b);
			      System.out.println("Before Decripting::"+str);
			      dectyptedText = cipher.doFinal(b);
			      dec 			= new String(dectyptedText);
			      System.out.println("dectyptedText ::"+dec);
			      if(dec.charAt(0)=='A')
			      {
			    	 System.out.println("dec.charAt(0):"+dec.charAt(0));
			    	 strTemp 	= dec.substring(0,1);
			    	 strTempVal = strTemp.replace("A", "0");
			    	 dec 		= strTempVal+dec.substring(1,dec.length());
			      }
			      if(dec.equalsIgnoreCase("empty"))
			      {
			    	  dec=null;
			      }
			      System.out.println("decrypteed text-----------------"+dec);
		    } catch (Exception ex) {
		      ex.printStackTrace();
		    }
		    return dec;
		}
}
