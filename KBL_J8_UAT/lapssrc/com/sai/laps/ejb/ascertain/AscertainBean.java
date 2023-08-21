package com.sai.laps.ejb.ascertain;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "AscertainBean", mappedName = "AscertainHome")
@Remote (AscertainRemote.class)
public class AscertainBean extends BeanAdapter 


{
	static Logger log=Logger.getLogger(AscertainBean.class);	
	public HashMap getData(HashMap hshRequestValues)
	{
		HashMap hshRecord=new HashMap();
		String strClientIP="";
		String strQuery="";
		String strUserId="";
		ResultSet rs=null;
		String strStatus="";
		boolean bstate=false;
		String strUser="";
		int intLoginCount=0;
		String strusrPage="";
		String strhidUsrId="";
		boolean boolAvail=false;
		String strFlag="Y";
		try
		{
			String strHostAddress=correctNull((String)hshRequestValues.get("strClientIP"));
			String strServerIP=correctNull((String)hshRequestValues.get("strServerIP"));
			String strServerPort=correctNull((String)hshRequestValues.get("strServerPort"));
			strClientIP=Helper.correctNull((String)hshRequestValues.get("strClientIP"));
			strusrPage = correctNull((String)hshRequestValues.get("hidPage"));
			strhidUsrId = correctNull((String)hshRequestValues.get("hidusr_id"));
			hshRecord.put("FromWhichPage",strusrPage);


			if(strClientIP.equalsIgnoreCase("127.0.0.1"))
			{
				strClientIP=strHostAddress;
			}
			if(rs !=null)
			{
				rs.close();
			}
			if(!strClientIP.equalsIgnoreCase(""))
			{
				
				if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
				{
					strQuery=SQLParser.getCBSSqlQuery("getUsedId_newconnection^"+strClientIP);
					rs=DBUtils.executeQueryCBSConnection(strQuery);
				}
				else
				{
					strQuery=SQLParser.getSqlQuery("getUsedId^"+strClientIP);
					rs=DBUtils.executeQuery(strQuery);
				}
				
				if(rs.next())
				{
					strUserId=Helper.correctNull((String)rs.getString("fin_loginid"));
				}
				if(rs !=null)
				{
					rs.close();
				}
				if(com.sai.laps.helper.ControllerServlet.mapSessionId!=null)
				{
					if(com.sai.laps.helper.ControllerServlet.mapSessionId.containsKey(strUserId))
					{
						strFlag="N";
					}
				}
				
			    rs = DBUtils.executeLAPSQuery("select_availableuser^"+strUserId);  
			    boolAvail=rs.next();
				if(!strUserId.equalsIgnoreCase("") && boolAvail==false)
				{
					boolean bool=updateUserDetails(strUserId);
					if(bool==true)
					{
						strQuery=SQLParser.getSqlQuery("ascertion^"+strUserId);
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strStatus="success";
							hshRecord.put("usr_id",correctNull(rs.getString("usr_id")));
							hshRecord.put("usr_orgcode",correctNull(rs.getString("usr_orgcode")));
							hshRecord.put("grp_rights",correctNull(rs.getString("grp_rights")));
							hshRecord.put("usr_class",correctNull(rs.getString("usr_class")));
							hshRecord.put("org_name",correctNull(rs.getString("org_name")));
							hshRecord.put("org_level",correctNull(rs.getString("org_level")));
							hshRecord.put("org_scode",correctNull(rs.getString("org_scode")));
							hshRecord.put("usr_name",correctNull(rs.getString("usr_name")));
							hshRecord.put("solid",correctNull(rs.getString("solid")));
							hshRecord.put("grp_privilege",correctNull(rs.getString("grp_privilege")));
							hshRecord.put("usr_department",correctNull(rs.getString("usr_department")));
							hshRecord.put("usr_grpid",correctNull(rs.getString("usr_grpid")));
							hshRecord.put("user_designation",correctNull(rs.getString("user_designation")));
							hshRecord.put("usr_rlpftype",correctNull(rs.getString("usr_rlpftype")));
							
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
			 				
							if(!strusrPage.equals("Navigation")  && strFlag.equalsIgnoreCase("Y"))
							{
								if(!Helper.correctNull((String)hshRecord.get("strUserExceedFlag")).equalsIgnoreCase("Y"))
								{
									HashMap hshQueryValues=new HashMap();
									HashMap hshQuery=new HashMap();
									ArrayList arrValues=new ArrayList();
									hshQueryValues.put("size","1");
							       	hshQuery.put("strQueryId", "ins_availableuser");
									arrValues.add(Helper.correctNull((String)hshRecord.get("usr_id")));
									arrValues.add(Helper.correctNull((String)hshRecord.get("usr_name")));
									arrValues.add(Helper.correctNull((String)hshRecord.get("org_scode")));
									arrValues.add(strServerIP+":"+strServerPort);
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put("1", hshQuery);
									EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
								}
							}
							
							if(rs != null) rs.close();
							strQuery = SQLParser.getSqlQuery("sel_user_pageaccess^"+strUserId);
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
						}
					}
				}
				else
				{
					strStatus="failure";
				}
				if(strStatus.equalsIgnoreCase("success"))
				{
					if(rs!=null)
					{
						rs.close();
					}
					strQuery=SQLParser.getSqlQuery("authenticate2^"+strUserId);
					rs=DBUtils.executeQuery(strQuery);
					if(!rs.next())
					{
						bstate = true;
						strUser="NotExists";
					}
					else
					{
						/*
						 * Deletion code should come here.
						 */
						bstate =deleteData(strUserId,hshRequestValues);
						strUser="Exists";
					}
					if(strUser.equalsIgnoreCase("NotExists"))
					{
						hshRequestValues.put("strClientIP", strClientIP);
						bstate = insertData(strUserId,hshRequestValues);
					}
					else
					{
						if(rs!=null){
							intLoginCount=Integer.parseInt(rs.getString("lnk_logincount"));
							if(intLoginCount >= 99)
							{
								intLoginCount=0;
							}
						}
						HashMap hshQueryValues=new HashMap();
						HashMap hshQuery=new HashMap();
						ArrayList arrValues=new ArrayList();
						try
						{
							hshQueryValues.put("size","1");
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							/*
							 * Insertion in Link table takes place here.
							 */
							hshQuery.put("strQueryId","authenticate4");
							arrValues.add(strUserId);
							arrValues.add(Integer.toString(++intLoginCount));
							arrValues.add(strClientIP);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
						catch (Exception e)
						{
							throw new EJBException("problem in Single Login"+e);
						}
						bstate=false;

					}
					if(bstate)
					{
						intLoginCount=Integer.parseInt(Helper.correctInt((String)hshRequestValues.get("hidlogincount")));
						hshRecord.put("hidlogincount",Integer.toString(++intLoginCount));
						if(rs != null)
							rs.close();
					}
					else{
						if(rs!=null){ 
							intLoginCount=Integer.parseInt(rs.getString("lnk_logincount"));
						}
						hshRecord.put("hidlogincount",Integer.toString(++intLoginCount));
						if(rs != null)
							rs.close();
					}
					
				}
				if(strusrPage.equals("Navigation"))
				{
					bstate = deleteData(strhidUsrId,hshRequestValues);
					
					HashMap hshQueryValues=new HashMap();
					HashMap hshQuery=new HashMap();
					ArrayList arrValues=new ArrayList();
					hshQueryValues.put("size","1");
			       	hshQuery.put("strQueryId", "del_availableuser");
					arrValues.add(strhidUsrId);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
			else
			{
				strStatus="failure";
			}
			
			hshRecord.put("strStatus",strStatus);
			hshRecord.put("boolLockFlag",boolAvail+"");
			hshRecord.put("strUserID",strUserId);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getData singlelogin  "+e.toString());
		}
		return hshRecord;
	}
	
	private boolean insertData(String strUserId,HashMap hshRequestValues)
	{
		ResultSet rs=null;
		String strQuery="";
		int logincount=0;
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=new ArrayList();
		boolean bstate=false;
		String strClientIP="";
		try
		{
			if(!strUserId.equalsIgnoreCase(""))
			{
				logincount=Integer.parseInt(Helper.correctInt((String)hshRequestValues.get("hidlogincount")));
				strClientIP=Helper.correctNull((String)hshRequestValues.get("strClientIP"));
				hshQueryValues.put("size","1");
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","authenticate4");
				arrValues.add(strUserId);
				arrValues.add(Integer.toString(++logincount));
				arrValues.add(strClientIP);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				bstate=true;
			}
			else
			{
				bstate=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("problem in Single Login"+e);
		}
		return bstate;
	}
	private boolean deleteData(String strUserId,HashMap hshRequestValue)
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		boolean bstate = false;
		try
		{
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","purgeid");
			arrValues.add(strUserId);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			bstate = true;
		}
		catch(Exception e)
		{
			throw new EJBException("problem in Single Login"+e);
		}
		return bstate;
	}
	private boolean updateUserDetails(String strUserId)
	{
		boolean bstate = false;
		String strQuery="";
		ResultSet rs=null;
		String strUsrName="",strDesignation="",strEmailId="";
		ArrayList arrValues=new ArrayList();
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		try
		{
			
			
			if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
			{
				strQuery=SQLParser.getCBSSqlQuery("seluserdetfromfinacle_newconnection^"+strUserId);
				rs=DBUtils.executeQueryCBSConnection(strQuery);
			}
			else
			{
				strQuery= SQLParser.getSqlQuery("seluserdetfromfinacle^"+strUserId);
				rs=DBUtils.executeQuery(strQuery); 
			}
			if(rs.next())
			{
				strUsrName=Helper.correctNull((String)rs.getString("usr_name"));
				strDesignation=Helper.correctNull((String)rs.getString("usr_designation"));
				strEmailId=Helper.correctNull((String)rs.getString("usr_mailid"));
			}
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","upduserdetfromfinacle");
			arrValues=new ArrayList();
			arrValues.add(strUsrName);
			arrValues.add(strDesignation);
			arrValues.add(strEmailId);
			arrValues.add(strUserId);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		catch(Exception e)
		{
			throw new EJBException("problem in User Updation from CBS"+e);
		}
		return true;
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
}
